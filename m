Subject: [PATCH] work around filesystems which incorrectly call
	d_instantiate before setting inode mode
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 17:57:52 -0400
Message-Id: <1155592672.17242.88.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One filesystem in particular, CIFS, will do this when you list the
contents of a directory.  It will create a dentry for any subdirectories
thereby calling d_instantiate but does so before setting the inode mode
for these subdirectories.  Thus the selinux sclass in the corresponding
inode security struct is set incorrectly to believe these directories
are files.  Then when operations are performed on these subdirectories
at a later point in time SELinux will deny operations which are being
may be allowed for directories but not for files or SELinux may do
things like ask for permission to rmdir what it believes is a 'file',
which is obviously not properly defined.  What this patch does is to
recalculate the sclass on each permission check.  Thus if the filesystem
in question decided to later set the mode bits (as CIFS does) we will
make the correct security checks.  We also output a warning message
letting the user know that they have a filesystem which is creating
things improperly.  I believe that the CIFS people were contacted twice
trying to get this fixed but we want SELinux users to be able to work
now.  This patch will also let us know if some other filesystem makes
such a mistake in the future.

As a general question how do you decide where to put things (like this
helper function) in hooks.c?  I just put it immediately before it's
first user, but is there some organization I should be paying attention
to if I am to add things like this?

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d1b8c7..ee08b1e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1066,6 +1066,22 @@ static int task_has_system(struct task_s
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
+/* 
+ * Update the sclass of an inode.  This shouldn't ever do anything unless a FS
+ * actually called d_instantiate before it set the i_mode. (which is wrong)
+ */
+static inline void inode_update_sclass(struct inode *inode)
+{
+	struct inode_security_struct *isec = inode->i_security;
+	if (isec->sclass == SECCLASS_FILE)
+	{
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+		if (unlikely(isec->sclass != SECCLASS_FILE) && printk_ratelimit())
+			printk(KERN_INFO "Fixing up inode found with sclass "
+				"set improperly on dev=%s\n", inode->i_sb->s_id);
+	}
+}
+
 /* Check whether a task has a particular permission to an inode.
    The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
@@ -1081,6 +1097,8 @@ static int inode_has_perm(struct task_st
 	tsec = tsk->security;
 	isec = inode->i_security;
 
+	inode_update_sclass(inode);
+
 	if (!adp) {
 		adp = &ad;
 		AVC_AUDIT_DATA_INIT(&ad, FS);
@@ -1220,6 +1238,8 @@ static int may_link(struct inode *dir,
 	dsec = dir->i_security;
 	isec = dentry->d_inode->i_security;
 
+	inode_update_sclass(dentry->d_inode);
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1266,6 +1286,8 @@ static inline int may_rename(struct inod
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
 	new_dsec = new_dir->i_security;
 
+	inode_update_sclass(old_dir);
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	ad.u.fs.dentry = old_dentry;
@@ -2260,6 +2282,8 @@ static int selinux_inode_setxattr(struct
 	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 		return -EPERM;
 
+	inode_update_sclass(inode);
+
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
