Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02501
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 15:29:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBRKThI16257
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 20:29:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gBRKTgf16247 for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 20:29:42 GMT
Message-Id: <200212272036.PAA07075@moss-shockers.ncsc.mil>
Date: Fri, 27 Dec 2002 15:36:55 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [patch] Re: new kernel patch
To: selinux@tycho.nsa.gov, russell@coker.com.au, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Herd_of_Zebra_708_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Herd_of_Zebra_708_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: DXTUVjOKx4Q/X6Z8kZ61bQ==


> When an inode is allocated, its SID is initialized to the unlabeled
> initial SID (=> system_u:object_r:unlabeled_t), and its security class
> is initialized to the file class by default.  This log message indicates
> that a devfs inode reached a permission check without first being
> initialized by inode_doinit, likely due to a race between 
> selinux_inode_post_lookup and a cached lookup.  The empty permission
> set is due to an inability to map the requested permission (likely search)
> to a permission in the file class.
> 
> As a short term fix, I'd suggest the attached patch.  A proper fix requires
> adjusting the inode_init call in d_instantiate and the SELinux hook function
> to properly handle filesystems that rely on genfs_contexts.

The attached patches, also committed to the sourceforge CVS tree, should 
implement a proper fix to this problem.  To apply to an existing tree, you would 
revert the short term fix (perminit.patch), revert the old version of the 
selinux-2.[45].patch, apply the attached lsm-2.[45]-inode.patch, and then apply 
the attached new version of the selinux-2.[45].patch. 

As a side note, if you haven't already picked it up, don't forget to apply the 
nfsd.patch to your lsm-2.4 tree as well (the second patch included in 
http://marc.theaimsgroup.com/?l=selinux&m=104041691605427&w=2, also committed to 
the sourceforge CVS tree).  The lsm-2.5 tree is already fine in that regard.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Herd_of_Zebra_708_000
Content-Type: TEXT/plain; name="lsm-2.4-inode.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: lsm-2.4-inode.patch
Content-MD5: xstpvRqbsG6n4ZedFxSJdw==

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.23
diff -u -r1.23 hooks.c
--- lsm-2.4/security/selinux/hooks.c	4 Dec 2002 17:54:52 -0000	1.23
+++ lsm-2.4/security/selinux/hooks.c	27 Dec 2002 18:24:23 -0000
@@ -458,7 +458,12 @@
 	"not configured for labeling"
 };
 
-static int inode_doinit(struct inode *inode);
+static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
+
+static inline int inode_doinit(struct inode *inode) 
+{
+	return inode_doinit_with_dentry(inode, NULL);
+}
 
 static int superblock_doinit(struct super_block *sb) 
 {
@@ -548,7 +553,7 @@
 	       labeling_behaviors[behavior-1]);
 	
 	/* Initialize the root inode. */
-	rc = inode_doinit(sb->s_root->d_inode);
+	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
 	if (rc)
 		return rc;
 
@@ -560,7 +565,7 @@
  * The /proc/PID entries are labeled with the SID of the owning process.
  * Most entries simply inherit their SID from the parent directory SID.
  */
-static void procfs_set_sid(struct dentry *dentry)
+static void procfs_set_sid(struct inode *inode, struct dentry *dentry)
 {
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec, *pisec;
@@ -570,10 +575,7 @@
 	const char *name;
 	int len;
 
-	if (!dentry->d_inode)
-		return;
-
-	isec = dentry->d_inode->i_security;
+	isec = inode->i_security;
 #ifndef _SELINUX_KERNEL_PATCH_
 	if (!isec)
 		return;
@@ -641,7 +643,7 @@
 			 char *buffer, int buflen);
 
 /* The inode's security attributes must be initialized before first use. */
-static int inode_doinit(struct inode *inode) 
+static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry) 
 {
 	struct superblock_security_struct *sbsec = NULL; 
 	struct inode_security_struct *isec = inode->i_security;
@@ -716,7 +718,10 @@
 		isec->sid = sbsec->sid;
 		
 		/* Obtain a SID based on the fstype, path, and class. */
-		dentry = d_find_alias(inode);
+		if (opt_dentry) 
+			dentry = dget(opt_dentry);
+		else
+			dentry = d_find_alias(inode);
 		if (dentry) {
 			buffer = (char*)__get_free_page(GFP_KERNEL);
 			if (buffer) {
@@ -747,7 +752,7 @@
 				
 			if (sbsec->proc) {
 				/* Handle /proc/PID. */
-				procfs_set_sid(dentry);
+				procfs_set_sid(inode, dentry);
 			}
 				
 			dput(dentry);
@@ -2032,7 +2037,7 @@
 		/* No permission to check.  Existence test. */
 		return 0;
 	}
-
+	
 	return inode_has_perm(current, inode, 
 			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
 }
@@ -2066,10 +2071,6 @@
 
 static void selinux_inode_post_lookup(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *inode = dentry->d_inode;
-
-	if (inode) 
-		inode_doinit(inode);
 	return;
 }
 

--Herd_of_Zebra_708_000
Content-Type: TEXT/plain; name="lsm-2.5-inode.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: lsm-2.5-inode.patch
Content-MD5: 9pCsFNShWhY6jCMvDOLdgA==

Index: lsm-2.5/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/selinux/hooks.c,v
retrieving revision 1.11
diff -u -r1.11 hooks.c
--- lsm-2.5/security/selinux/hooks.c	16 Dec 2002 14:06:02 -0000	1.11
+++ lsm-2.5/security/selinux/hooks.c	27 Dec 2002 18:29:14 -0000
@@ -461,7 +461,12 @@
 	"not configured for labeling"
 };
 
-static int inode_doinit(struct inode *inode);
+static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
+
+static inline int inode_doinit(struct inode *inode) 
+{
+	return inode_doinit_with_dentry(inode, NULL);
+}
 
 static int superblock_doinit(struct super_block *sb) 
 {
@@ -551,7 +556,7 @@
 	       labeling_behaviors[behavior-1]);
 	
 	/* Initialize the root inode. */
-	rc = inode_doinit(sb->s_root->d_inode);
+	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
 	if (rc)
 		return rc;
 
@@ -563,7 +568,7 @@
  * The /proc/PID entries are labeled with the SID of the owning process.
  * Most entries simply inherit their SID from the parent directory SID.
  */
-static void procfs_set_sid(struct dentry *dentry)
+static void procfs_set_sid(struct inode *inode, struct dentry *dentry)
 {
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec, *pisec;
@@ -573,10 +578,7 @@
 	const char *name;
 	int len;
 
-	if (!dentry->d_inode)
-		return;
-
-	isec = dentry->d_inode->i_security;
+	isec = inode->i_security;
 #ifndef _SELINUX_KERNEL_PATCH_
 	if (!isec)
 		return;
@@ -644,7 +646,7 @@
 			 char *buffer, int buflen);
 
 /* The inode's security attributes must be initialized before first use. */
-static int inode_doinit(struct inode *inode) 
+static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry) 
 {
 	struct superblock_security_struct *sbsec = NULL; 
 	struct inode_security_struct *isec = inode->i_security;
@@ -719,7 +721,10 @@
 		isec->sid = sbsec->sid;
 		
 		/* Obtain a SID based on the fstype, path, and class. */
-		dentry = d_find_alias(inode);
+		if (opt_dentry)
+			dentry = dget(opt_dentry);
+		else
+			dentry = d_find_alias(inode);
 		if (dentry) {
 			buffer = (char*)__get_free_page(GFP_KERNEL);
 			if (buffer) {
@@ -750,7 +755,7 @@
 				
 			if (sbsec->proc) {
 				/* Handle /proc/PID. */
-				procfs_set_sid(dentry);
+				procfs_set_sid(inode, dentry);
 			}
 				
 			dput(dentry);
@@ -2073,10 +2078,6 @@
 
 static void selinux_inode_post_lookup(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *inode = dentry->d_inode;
-
-	if (inode) 
-		inode_doinit(inode);
 	return;
 }
 

--Herd_of_Zebra_708_000
Content-Type: TEXT/plain; name="selinux-2.4.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: selinux-2.4.patch
Content-MD5: YN2yBVdDlGQxK0VaZt2T2A==

Index: lsm-2.4/Makefile
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/Makefile,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 Makefile
--- lsm-2.4/Makefile	13 Dec 2002 14:26:57 -0000	1.1.1.6
+++ lsm-2.4/Makefile	27 Dec 2002 19:10:13 -0000
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
-EXTRAVERSION = -lsm1
+EXTRAVERSION = -selinux
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
Index: lsm-2.4/arch/i386/defconfig
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/arch/i386/defconfig,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 defconfig
--- lsm-2.4/arch/i386/defconfig	13 Dec 2002 14:27:05 -0000	1.1.1.4
+++ lsm-2.4/arch/i386/defconfig	27 Dec 2002 19:10:15 -0000
@@ -160,7 +160,8 @@
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
 # CONFIG_FILTER is not set
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -879,3 +880,12 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+
+#
+# Security options
+#
+CONFIG_SECURITY_CAPABILITIES=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_SELINUX_DEVELOP=y
+CONFIG_SECURITY_SELINUX_NSID=n
+CONFIG_SECURITY_SELINUX_SELOPT=n
Index: lsm-2.4/fs/dcache.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/fs/dcache.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 dcache.c
--- lsm-2.4/fs/dcache.c	13 Dec 2002 18:36:27 -0000	1.1.1.5
+++ lsm-2.4/fs/dcache.c	27 Dec 2002 19:10:25 -0000
@@ -651,6 +651,7 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
+	security_ops->d_instantiate(entry, inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
Index: lsm-2.4/fs/devpts/inode.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/fs/devpts/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- lsm-2.4/fs/devpts/inode.c	20 Dec 2001 23:28:59 -0000	1.1.1.1
+++ lsm-2.4/fs/devpts/inode.c	27 Dec 2002 19:10:27 -0000
@@ -199,6 +199,7 @@
 	inode->i_gid = sbi->setgid ? sbi->gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|sbi->mode, kdev_t_to_nr(device));
+	security_ops->devpts_pty_new(inode);
 
 	if ( sbi->inodes[number] ) {
 		iput(inode);
Index: lsm-2.4/include/linux/security.h
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/include/linux/security.h,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 security.h
--- lsm-2.4/include/linux/security.h	23 Oct 2002 17:58:15 -0000	1.1.1.7
+++ lsm-2.4/include/linux/security.h	27 Dec 2002 19:10:31 -0000
@@ -1425,6 +1425,11 @@
 				  struct security_operations * ops);
 	int (*unregister_security) (const char *name,
 				    struct security_operations * ops);
+
+	/* Added by the separate SELinux patch. */
+	void (*devpts_pty_new) (struct inode * inode);
+	void (*d_instantiate) (struct dentry * dentry, struct inode * inode);
+
 };
 
 /* prototypes */
Index: lsm-2.4/init/do_mounts.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/init/do_mounts.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 do_mounts.c
--- lsm-2.4/init/do_mounts.c	13 Dec 2002 18:38:37 -0000	1.1.1.2
+++ lsm-2.4/init/do_mounts.c	27 Dec 2002 19:10:31 -0000
@@ -812,6 +812,8 @@
 	/* switch root and cwd back to / of rootfs */
 	sys_fchdir(root_fd);
 	sys_chroot(".");
+	close(old_fd);
+	close(root_fd);
 	sys_umount("/old/dev", 0);
 
 	if (real_root_dev == ram0) {
Index: lsm-2.4/init/main.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/init/main.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 main.c
--- lsm-2.4/init/main.c	23 Aug 2002 17:23:37 -0000	1.1.1.4
+++ lsm-2.4/init/main.c	27 Dec 2002 19:10:32 -0000
@@ -342,6 +342,10 @@
  	cpu_idle();
 } 
 
+#ifdef CONFIG_SECURITY_SELINUX
+extern void selinux_init(void);
+#endif
+
 /*
  *	Activate the first processor.
  */
@@ -412,6 +416,9 @@
 	fork_init(num_mappedpages);
 	proc_caches_init();
 	security_scaffolding_startup();
+#ifdef CONFIG_SECURITY_SELINUX
+	selinux_init();
+#endif
 	vfs_caches_init(num_physpages);
 	buffer_init(num_physpages);
 	page_cache_init(num_physpages);
Index: lsm-2.4/net/netsyms.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/net/netsyms.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 netsyms.c
--- lsm-2.4/net/netsyms.c	13 Dec 2002 18:38:43 -0000	1.1.1.5
+++ lsm-2.4/net/netsyms.c	27 Dec 2002 19:10:32 -0000
@@ -295,7 +295,9 @@
 #include <net/ip6_route.h>
 EXPORT_SYMBOL(ip6_route_output);
 #endif
-#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_KHTTPD) || defined (CONFIG_KHTTPD_MODULE)
+#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_KHTTPD) || \
+		defined (CONFIG_KHTTPD_MODULE) || defined (CONFIG_SECURITY_SELINUX_SELOPT_MODULE)
+extern struct tcp_func  ipv4_specific;
 /* inet functions common to v4 and v6 */
 EXPORT_SYMBOL(inet_release);
 EXPORT_SYMBOL(inet_stream_connect);
Index: lsm-2.4/security/capability.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/capability.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 capability.c
--- lsm-2.4/security/capability.c	23 Oct 2002 18:00:16 -0000	1.1.1.6
+++ lsm-2.4/security/capability.c	27 Dec 2002 19:10:33 -0000
@@ -1065,6 +1065,16 @@
 	return -EINVAL;
 }
 
+static void cap_devpts_pty_new (struct inode *inode)
+{
+	return;
+}
+
+static void cap_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
 static struct security_operations capability_ops = {
 	sethostname:			cap_sethostname,
 	setdomainname:			cap_setdomainname,
@@ -1242,6 +1252,9 @@
 	
 	register_security:		cap_register,
 	unregister_security:		cap_unregister,
+
+	devpts_pty_new:                 cap_devpts_pty_new,
+	d_instantiate:                  cap_d_instantiate,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
Index: lsm-2.4/security/dummy.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/dummy.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 dummy.c
--- lsm-2.4/security/dummy.c	23 Oct 2002 18:00:16 -0000	1.1.1.7
+++ lsm-2.4/security/dummy.c	27 Dec 2002 19:10:33 -0000
@@ -886,6 +886,16 @@
 	return -EINVAL;
 }
 
+static void dummy_devpts_pty_new (struct inode *inode)
+{
+	return;
+}
+
+static void dummy_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
 struct security_operations dummy_security_ops = {
 	sethostname:			dummy_sethostname,
 	setdomainname:			dummy_setdomainname,
@@ -1063,5 +1073,8 @@
 	
 	register_security:		dummy_register,
 	unregister_security:		dummy_unregister,
+
+	devpts_pty_new:                 dummy_devpts_pty_new,
+	d_instantiate:                  dummy_d_instantiate,
 };
 
Index: lsm-2.4/security/owlsm.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/owlsm.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 owlsm.c
--- lsm-2.4/security/owlsm.c	23 Oct 2002 18:00:16 -0000	1.1.1.6
+++ lsm-2.4/security/owlsm.c	27 Dec 2002 19:10:33 -0000
@@ -901,6 +901,16 @@
 	return -EINVAL;
 }
 
+static void owlsm_devpts_pty_new (struct inode *inode)
+{
+	return;
+}
+
+static void owlsm_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
 static struct security_operations owlsm_ops = {
 	sethostname:			owlsm_sethostname,
 	setdomainname:			owlsm_setdomainname,
@@ -1078,6 +1088,9 @@
 	
 	register_security:		owlsm_register,
 	unregister_security:		owlsm_unregister,
+
+	devpts_pty_new:                 owlsm_devpts_pty_new,
+	d_instantiate:                  owlsm_d_instantiate,
 };
 
 #if defined(CONFIG_SECURITY_owlsm_MODULE)
Index: lsm-2.4/security/dte/dte.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/dte/dte.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 dte.c
--- lsm-2.4/security/dte/dte.c	23 Oct 2002 18:00:17 -0000	1.1.1.6
+++ lsm-2.4/security/dte/dte.c	27 Dec 2002 19:10:33 -0000
@@ -934,6 +934,16 @@
 		return dte_secondary_ops->unregister_security(name, ops);
 }
 
+static void dte_devpts_pty_new (struct inode *inode)
+{
+	return;
+}
+
+static void dte_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
 struct security_operations dte_security_ops = {
 	sethostname:			dte_sethostname,
 	setdomainname:			dte_setdomainname,
@@ -1110,6 +1120,9 @@
 	
 	register_security:		dte_register,
 	unregister_security:		dte_unregister,
+
+	devpts_pty_new:                 dte_devpts_pty_new,
+	d_instantiate:                  dte_d_instantiate,
 };
 
 extern int setup_dte_module(void);
Index: lsm-2.4/security/lids/lids_lsm.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/lids/lids_lsm.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 lids_lsm.c
--- lsm-2.4/security/lids/lids_lsm.c	23 Oct 2002 18:00:19 -0000	1.1.1.4
+++ lsm-2.4/security/lids/lids_lsm.c	27 Dec 2002 19:10:33 -0000
@@ -1106,6 +1106,16 @@
 	return -EINVAL;
 }
 
+static void lids_devpts_pty_new (struct inode *inode)
+{
+	return;
+}
+
+static void lids_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
 struct security_operations lids_security_ops = {
 	sethostname:			lids_sethostname,
 	setdomainname:			lids_setdomainname,
@@ -1288,6 +1298,9 @@
 	
 	register_security:		lids_register,
 	unregister_security:		lids_unregister,
+
+	devpts_pty_new:                 lids_devpts_pty_new,
+	d_instantiate:                  lids_d_instantiate,
 };
 
 extern void setup_lids_module(void);
Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.24
diff -u -r1.24 hooks.c
--- lsm-2.4/security/selinux/hooks.c	27 Dec 2002 19:08:33 -0000	1.24
+++ lsm-2.4/security/selinux/hooks.c	27 Dec 2002 19:10:33 -0000
@@ -62,6 +62,8 @@
 #include "selinux_plug.h"
 #include "extsocket.h"
 
+#define _SELINUX_KERNEL_PATCH_
+
 #ifndef _SELINUX_KERNEL_PATCH_
 #warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."
 #endif
@@ -3991,6 +3993,17 @@
 	return 0;
 }
 
+static void selinux_devpts_pty_new (struct inode *inode)
+{
+	inode_doinit(inode);
+}
+
+static void selinux_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	if (inode)
+		inode_doinit_with_dentry(inode, dentry);
+}
+
 struct security_operations selinux_ops = {
 	sethostname:			selinux_sethostname,
 	setdomainname:			selinux_setdomainname,
@@ -4167,6 +4180,9 @@
 	
 	register_security:		&selinux_register_security,
 	unregister_security:		&selinux_unregister_security,
+
+	devpts_pty_new:                 selinux_devpts_pty_new,
+	d_instantiate:                  selinux_d_instantiate,
 };
 
 extern long sys_security_selinux(struct pt_regs regs);

--Herd_of_Zebra_708_000
Content-Type: TEXT/plain; name="selinux-2.5.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: selinux-2.5.patch
Content-MD5: 3eJEfLcnmIor52KubbqLwA==

Index: lsm-2.5/Makefile
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/Makefile,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 Makefile
--- lsm-2.5/Makefile	13 Dec 2002 20:57:05 -0000	1.1.1.8
+++ lsm-2.5/Makefile	27 Dec 2002 19:14:05 -0000
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 51
-EXTRAVERSION = -lsm1
+EXTRAVERSION = -selinux
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
Index: lsm-2.5/arch/i386/defconfig
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/arch/i386/defconfig,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 defconfig
--- lsm-2.5/arch/i386/defconfig	23 Oct 2002 17:31:30 -0000	1.1.1.5
+++ lsm-2.5/arch/i386/defconfig	27 Dec 2002 19:14:07 -0000
@@ -401,7 +401,7 @@
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETFILTER=y
 # CONFIG_FILTER is not set
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -1169,3 +1169,13 @@
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
+
+#
+# Security options
+#
+CONFIG_SECURITY=y
+CONFIG_SECURITY_CAPABILITIES=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_SELINUX_DEVELOP=y
+CONFIG_SECURITY_SELINUX_NSID=y
+CONFIG_SECURITY_SELINUX_SELOPT=y
Index: lsm-2.5/fs/dcache.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/fs/dcache.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 dcache.c
--- lsm-2.5/fs/dcache.c	13 Dec 2002 21:00:16 -0000	1.1.1.8
+++ lsm-2.5/fs/dcache.c	27 Dec 2002 19:14:11 -0000
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <linux/security.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -699,6 +700,7 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
+	security_d_instantiate(entry, inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
@@ -825,6 +827,7 @@
 	struct dentry *new = NULL;
 
 	if (inode && S_ISDIR(inode->i_mode)) {
+		security_d_instantiate(dentry, inode);
 		spin_lock(&dcache_lock);
 		if (!list_empty(&inode->i_dentry)) {
 			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
Index: lsm-2.5/include/linux/security.h
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/include/linux/security.h,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 security.h
--- lsm-2.5/include/linux/security.h	13 Dec 2002 21:01:07 -0000	1.1.1.8
+++ lsm-2.5/include/linux/security.h	27 Dec 2002 19:14:12 -0000
@@ -1375,6 +1375,9 @@
 	                          struct security_operations *ops);
 	int (*unregister_security) (const char *name,
 	                            struct security_operations *ops);
+
+	/* Added by the separate SELinux patch. */
+	void (*d_instantiate) (struct dentry * dentry, struct inode * inode);
 };
 
 /* global variables */
@@ -2244,6 +2247,10 @@
 	return security_ops->sem_semctl(sma, cmd);
 }
 
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	security_ops->d_instantiate (dentry, inode);
+}
 
 /* prototypes */
 extern int security_scaffolding_startup	(void);
@@ -3066,6 +3073,9 @@
 {
 	return 0;
 }
+
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{ }
 
 #endif	/* CONFIG_SECURITY */
 
Index: lsm-2.5/init/main.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/init/main.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 main.c
--- lsm-2.5/init/main.c	13 Dec 2002 21:01:12 -0000	1.1.1.8
+++ lsm-2.5/init/main.c	27 Dec 2002 19:14:12 -0000
@@ -370,6 +370,10 @@
  	cpu_idle();
 } 
 
+#ifdef CONFIG_SECURITY_SELINUX 
+extern void selinux_init(void);
+#endif
+
 /*
  *	Activate the first processor.
  */
@@ -425,6 +429,9 @@
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
+#ifdef CONFIG_SECURITY_SELINUX
+	selinux_init();
+#endif
 	buffer_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
Index: lsm-2.5/net/netsyms.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/net/netsyms.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 netsyms.c
--- lsm-2.5/net/netsyms.c	13 Dec 2002 21:01:14 -0000	1.1.1.8
+++ lsm-2.5/net/netsyms.c	27 Dec 2002 19:14:12 -0000
@@ -324,7 +324,8 @@
 EXPORT_SYMBOL(xfrm_policy_list);
 
 
-#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_IP_SCTP_MODULE)
+#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_IP_SCTP_MODULE) || defined (CONFIG_SECURITY_SELINUX_SELOPT_MODULE)
+extern struct tcp_func  ipv4_specific;
 /* inet functions common to v4 and v6 */
 EXPORT_SYMBOL(inet_release);
 EXPORT_SYMBOL(inet_stream_connect);
Index: lsm-2.5/security/dummy.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/dummy.c,v
retrieving revision 1.2
diff -u -r1.2 dummy.c
--- lsm-2.5/security/dummy.c	16 Dec 2002 15:19:45 -0000	1.2
+++ lsm-2.5/security/dummy.c	27 Dec 2002 19:14:12 -0000
@@ -873,6 +873,12 @@
 	return -EINVAL;
 }
 
+static void dummy_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
+
 struct security_operations dummy_security_ops;
 
 #define set_to_dummy_if_null(ops, function)				\
@@ -1039,5 +1045,6 @@
 	set_to_dummy_if_null(ops, skb_set_owner_w);
 	set_to_dummy_if_null(ops, skb_recv_datagram);
 	set_to_dummy_if_null(ops, skb_free_security);
+	set_to_dummy_if_null(ops, d_instantiate);
 }
 
Index: lsm-2.5/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/selinux/hooks.c,v
retrieving revision 1.12
diff -u -r1.12 hooks.c
--- lsm-2.5/security/selinux/hooks.c	27 Dec 2002 19:09:46 -0000	1.12
+++ lsm-2.5/security/selinux/hooks.c	27 Dec 2002 19:14:12 -0000
@@ -65,6 +65,8 @@
 #include "selinux_plug.h"
 #include "extsocket.h"
 
+#define _SELINUX_KERNEL_PATCH_
+
 #ifndef _SELINUX_KERNEL_PATCH_
 #warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."
 #endif
@@ -3994,6 +3996,12 @@
 	return 0;
 }
 
+static void selinux_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	if (inode)
+		inode_doinit_with_dentry(inode, dentry);
+}
+
 struct security_operations selinux_ops = {
 	sethostname:			selinux_sethostname,
 	setdomainname:			selinux_setdomainname,
@@ -4164,6 +4172,8 @@
 	
 	register_security:		&selinux_register_security,
 	unregister_security:		&selinux_unregister_security,
+
+	d_instantiate:                  selinux_d_instantiate,
 };
 
 extern long sys_security_selinux(struct pt_regs regs);

--Herd_of_Zebra_708_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
