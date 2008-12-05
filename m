From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 3/3] SELinux: Unify context mount and genfs behavior
Date: Fri,  5 Dec 2008 15:27:32 -0500
Message-Id: <1228508852-2906-4-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1228508852-2906-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1228508852-2906-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Context mounts and genfs labeled file systems behave differently with respect to
setting file system labels. This patch brings genfs labeled file systems in line
with context mounts in that setxattr calls to them should return EOPNOTSUPP and
fscreate calls will be ignored.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 security/selinux/hooks.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fe0b3eb..7fa25de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1536,7 +1536,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
+	if (tsec->create_sid && sbsec->flags & SE_SBLABELSUPP) {
 		newsid = tsec->create_sid;
 	} else {
 		rc = security_transition_sid(tsec->sid, dsec->sid, tclass,
@@ -2543,7 +2543,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
-	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
+	if (tsec->create_sid && sbsec->flags & SE_SBLABELSUPP) {
 		newsid = tsec->create_sid;
 	} else {
 		rc = security_transition_sid(tsec->sid, dsec->sid,
@@ -2567,7 +2567,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = 1;
 	}
 
-	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+	if (!ss_initialized || !(sbsec->flags & SE_SBLABELSUPP))
 		return -EOPNOTSUPP;
 
 	if (name) {
@@ -2736,7 +2736,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 		return selinux_inode_setotherxattr(dentry, name);
 
 	sbsec = inode->i_sb->s_security;
-	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+	if (!(sbsec->flags & SE_SBLABELSUPP))
 		return -EOPNOTSUPP;
 
 	if (!is_owner_or_cap(inode))
-- 
1.5.6.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
