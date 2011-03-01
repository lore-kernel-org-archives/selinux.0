From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/2] LSM: Pass -o remount options to the LSM
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, eparis@redhat.com
Date: Tue, 01 Mar 2011 16:58:22 -0500
Message-ID: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The VFS mount paths pass the mount options to the LSM.  The LSM will remove
options it understands from the path and will them pass the remaining
options onto the underlying filesystem.  This is how options like the
SELinux context= work.  The problem comes in that -o remount never calls
into LSM code.  So if you include an LSM specific option it will get passed
to the filesystem and will cause the remount to fail.  An example of where
this is a problem is the 'seclabel' option.  The SELinux LSM hook will
print this word in /proc/mounts if the filesystem is being labeled using
xattrs.  If you pass this word on mount it will be silently stripped and
ignored.  But if you pass this word on remount the LSM never gets called
and it will be passed to the FS.  The FS doesn't know what seclabel means
and thus should fail the mount.  For example an ext3 fs mounted over loop

# mount -o loop /tmp/fs /mnt/tmp
# cat /proc/mounts | grep /mnt/tmp
/dev/loop0 /mnt/tmp ext3 rw,seclabel,relatime,errors=continue,barrier=0,data=ordered 0 0
# mount -o remounte /mnt/tmp
mount: /mnt/tmp not mounted already, or bad option
# dmesg
EXT3-fs (loop0): error: unrecognized mount option "seclabel" or missing value

This patch passes the remount mount options to an new LSM hook.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 fs/namespace.c           |    4 ++++
 include/linux/security.h |   13 +++++++++++++
 security/capability.c    |    6 ++++++
 security/security.c      |    5 +++++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d1edf26..a66feed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1767,6 +1767,10 @@ static int do_remount(struct path *path, int flags, int mnt_flags,
 	if (path->dentry != path->mnt->mnt_root)
 		return -EINVAL;
 
+	err = security_sb_remount(sb, data);
+	if (err)
+		return err;
+
 	down_write(&sb->s_umount);
 	if (flags & MS_BIND)
 		err = change_mount_flags(path->mnt, flags);
diff --git a/include/linux/security.h b/include/linux/security.h
index 39062f6..a8c75fa 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -268,6 +268,12 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
+ * @sb_remount:
+ *	Extracts security system specifc mount options and verifys no changes
+ *	are being made to those options.
+ *	@sb superblock being remounted
+ *	@data contains the filesystem-specific data.
+ *	Return 0 if permission is granted.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -1395,6 +1401,7 @@ struct security_operations {
 	int (*sb_alloc_security) (struct super_block *sb);
 	void (*sb_free_security) (struct super_block *sb);
 	int (*sb_copy_data) (char *orig, char *copy);
+	int (*sb_remount) (struct super_block *sb, void *data);
 	int (*sb_kern_mount) (struct super_block *sb, int flags, void *data);
 	int (*sb_show_options) (struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs) (struct dentry *dentry);
@@ -1679,6 +1686,7 @@ int security_bprm_secureexec(struct linux_binprm *bprm);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
+int security_sb_remount(struct super_block *sb, void *data);
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
@@ -1960,6 +1968,11 @@ static inline int security_sb_copy_data(char *orig, char *copy)
 	return 0;
 }
 
+static inline int security_sb_remount(struct super_block *sb, void *data)
+{
+	return 0;
+}
+
 static inline int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	return 0;
diff --git a/security/capability.c b/security/capability.c
index b44142b..3cf5ae3 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -54,6 +54,11 @@ static int cap_sb_copy_data(char *orig, char *copy)
 	return 0;
 }
 
+static int cap_sb_remount(struct super_block *sb, void *data)
+{
+	return 0;
+}
+
 static int cap_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	return 0;
@@ -891,6 +896,7 @@ void __init security_fixup_ops(struct security_operations *ops)
 	set_to_cap_if_null(ops, sb_alloc_security);
 	set_to_cap_if_null(ops, sb_free_security);
 	set_to_cap_if_null(ops, sb_copy_data);
+	set_to_cap_if_null(ops, sb_remount);
 	set_to_cap_if_null(ops, sb_kern_mount);
 	set_to_cap_if_null(ops, sb_show_options);
 	set_to_cap_if_null(ops, sb_statfs);
diff --git a/security/security.c b/security/security.c
index a3462fa..924fee1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -266,6 +266,11 @@ int security_sb_copy_data(char *orig, char *copy)
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
+int security_sb_remount(struct super_block *sb, void *data)
+{
+	return security_ops->sb_remount(sb, data);
+}
+
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	return security_ops->sb_kern_mount(sb, flags, data);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
