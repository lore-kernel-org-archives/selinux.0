Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0OISURb020485
	for <selinux@tycho.nsa.gov>; Sat, 24 Jan 2004 13:28:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0OIRFxt008126
	for <selinux@tycho.nsa.gov>; Sat, 24 Jan 2004 18:27:16 GMT
Date: Sat, 24 Jan 2004 13:28:24 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: linux-security-module@wirex.com
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH][RFC] Security mount data & sb_copy_data hook.
Message-ID: <Xine.LNX.4.44.0401241303100.22819-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch below allows security-specific mount data to be managed via LSM.

An example of use is under SELinux, where a filesystem may need to be 
mounted with a specific security context because the filesystem does not 
support extended attributes (e.g. NFS), or where the existing attributes 
are not trusted (e.g. inserting removable media).

A new LSM hook has been added, sb_copy_data, which allows the security
module to copy security-specific mount data once the superblock has been
setup by the filesystem.

The sb_kern_mount hook has been modified to take this security data as a
parameter, and would typically be used at that point to configure the
security parameters of the filesystem being mounted.

Allocation and freeing of the security data has been implemented in the
core fs code as it is cleaner than trying to do it purely via LSM hooks,
and should make maintenance easier.  This code will be compiled away if 
LSM is not enabled.

Any feedback on this will be most appreciated.

Related patches for NFS, userspace and experimental SELinux context 
mounting are at:
http://people.redhat.com/jmorris/selinux/context_mounts/


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.2-rc1.p/fs/super.c linux-2.6.2-rc1.w/fs/super.c
--- linux-2.6.2-rc1.p/fs/super.c	2003-10-15 08:53:19.000000000 -0400
+++ linux-2.6.2-rc1.w/fs/super.c	2004-01-22 14:11:36.000000000 -0500
@@ -708,6 +708,7 @@
 	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
 	int error;
+	char *secdata = NULL;
 
 	if (!type)
 		return ERR_PTR(-ENODEV);
@@ -715,11 +716,26 @@
 	mnt = alloc_vfsmnt(name);
 	if (!mnt)
 		goto out;
+	
+	if (data) {
+		secdata = alloc_secdata();
+		if (!secdata) {
+			sb = ERR_PTR(-ENOMEM);
+			goto out_mnt;
+		}
+
+		error = security_sb_copy_data(fstype, data, secdata);
+		if (error) {
+			sb = ERR_PTR(error);
+			goto out_free_secdata;
+		}
+	}
+
 	sb = type->get_sb(type, flags, name, data);
 	if (IS_ERR(sb))
-		goto out_mnt;
- 	error = security_sb_kern_mount(sb);
- 	if (error) 
+		goto out_free_secdata;
+ 	error = security_sb_kern_mount(sb, secdata);
+ 	if (error)
  		goto out_sb;
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
@@ -732,6 +748,8 @@
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
 	sb = ERR_PTR(error);
+out_free_secdata:
+	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
diff -urN -X dontdiff linux-2.6.2-rc1.p/include/linux/fs.h linux-2.6.2-rc1.w/include/linux/fs.h
--- linux-2.6.2-rc1.p/include/linux/fs.h	2004-01-21 13:39:03.000000000 -0500
+++ linux-2.6.2-rc1.w/include/linux/fs.h	2004-01-22 11:58:50.000000000 -0500
@@ -1421,5 +1421,25 @@
 /* kernel/fork.c */
 extern int unshare_files(void);
 
+#ifdef CONFIG_SECURITY
+static inline char *alloc_secdata(void)
+{
+	return (char *)get_zeroed_page(GFP_KERNEL);
+}
+
+static inline void free_secdata(void *secdata)
+{
+	free_page((unsigned long)secdata);
+}
+#else
+static inline char *alloc_secdata(void)
+{
+	return (char *)1;
+}
+
+static inline void free_secdata(void *secdata)
+{ }
+#endif	/* CONFIG_SECURITY */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_FS_H */
diff -urN -X dontdiff linux-2.6.2-rc1.p/include/linux/security.h linux-2.6.2-rc1.w/include/linux/security.h
--- linux-2.6.2-rc1.p/include/linux/security.h	2004-01-21 13:39:03.000000000 -0500
+++ linux-2.6.2-rc1.w/include/linux/security.h	2004-01-22 14:12:18.000000000 -0500
@@ -171,6 +171,16 @@
  *	@flags contains the mount flags.
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
+ * @sb_copy_data:
+ *	Allow mount option data to be copied prior to parsing by the filesystem,
+ *	so that the security module can extract security-specific mount
+ *	options cleanly (a filesystem may modify the data e.g. with strsep()).
+ *	This also allows the original mount data to be stripped of security-
+ *	specific options to avoid having to make filesystems aware of them.
+ *	@fstype the type of filesystem being mounted.
+ *	@orig the original mount data copied from userspace.
+ *	@copy copied data which will be passed to the security module.
+ *	Returns 0 if the copy was successful.
  * @sb_check_sb:
  *	Check permission before the device with superblock @mnt->sb is mounted
  *	on the mount point named by @nd.
@@ -1024,7 +1034,8 @@
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
-	int (*sb_kern_mount) (struct super_block *sb);
+	int (*sb_copy_data)(const char *fstype, void *orig, void *copy);
+	int (*sb_kern_mount) (struct super_block *sb, void *data);
 	int (*sb_statfs) (struct super_block * sb);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
 			 char *type, unsigned long flags, void *data);
@@ -1308,9 +1319,14 @@
 	security_ops->sb_free_security (sb);
 }
 
-static inline int security_sb_kern_mount (struct super_block *sb)
+static inline int security_sb_copy_data (const char *fstype, void *orig, void *copy)
 {
-	return security_ops->sb_kern_mount (sb);
+	return security_ops->sb_copy_data (fstype, orig, copy);
+}
+
+static inline int security_sb_kern_mount (struct super_block *sb, void *data)
+{
+	return security_ops->sb_kern_mount (sb, data);
 }
 
 static inline int security_sb_statfs (struct super_block *sb)
@@ -1973,7 +1989,12 @@
 static inline void security_sb_free (struct super_block *sb)
 { }
 
-static inline int security_sb_kern_mount (struct super_block *sb)
+static inline int security_sb_copy_data (const char *fstype, void *orig, void *copy)
+{
+	return 0;
+}
+
+static inline int security_sb_kern_mount (struct super_block *sb, void *data)
 {
 	return 0;
 }
diff -urN -X dontdiff linux-2.6.2-rc1.p/security/dummy.c linux-2.6.2-rc1.w/security/dummy.c
--- linux-2.6.2-rc1.p/security/dummy.c	2004-01-21 13:39:03.000000000 -0500
+++ linux-2.6.2-rc1.w/security/dummy.c	2004-01-21 17:17:13.000000000 -0500
@@ -194,7 +194,12 @@
 	return;
 }
 
-static int dummy_sb_kern_mount (struct super_block *sb)
+static int dummy_sb_copy_data (const char *fstype, void *orig, void *copy)
+{
+	return 0;
+}
+
+static int dummy_sb_kern_mount (struct super_block *sb, void *data)
 {
 	return 0;
 }
@@ -877,6 +882,7 @@
 	set_to_dummy_if_null(ops, bprm_secureexec);
 	set_to_dummy_if_null(ops, sb_alloc_security);
 	set_to_dummy_if_null(ops, sb_free_security);
+	set_to_dummy_if_null(ops, sb_copy_data);
 	set_to_dummy_if_null(ops, sb_kern_mount);
 	set_to_dummy_if_null(ops, sb_statfs);
 	set_to_dummy_if_null(ops, sb_mount);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
