From: Stephen Smalley <sds@tycho.nsa.gov>
To: eparis@parisplace.org
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Enable setting security contexts on rootfs inodes.
Date: Fri, 10 May 2013 10:25:56 -0400
Message-Id: <1368195956-19672-1-git-send-email-sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rootfs (ramfs) can support setting of security contexts
by userspace due to the vfs fallback behavior of calling
the security module to set the in-core inode state
for security.* attributes when the filesystem does not
provide an xattr handler.  No xattr handler required
as the inodes are pinned in memory and have no backing
store.

This is useful in allowing early userspace to label individual
files within a rootfs while still providing a policy-defined
default via genfs.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b28b7eb..6c13d06 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -405,6 +405,13 @@ static int sb_finish_set_opts(struct super_block *sb)
 	if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)
 		sbsec->flags |= SE_SBLABELSUPP;
 
+	/*
+	 * Special handling for rootfs. Is genfs but supports
+	 * setting SELinux context on in-core inodes.
+	 */
+	if (strncmp(sb->s_type->name, "rootfs", sizeof("rootfs")) == 0)
+		sbsec->flags |= SE_SBLABELSUPP;
+
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(root_inode, root);
 
-- 
1.8.1.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
