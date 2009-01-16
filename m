From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 3/3] SELinux: Unify context mount and genfs behavior
Date: Fri, 16 Jan 2009 09:22:04 -0500
Message-Id: <1232115724-2621-4-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
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
index 3d099ee..bb78b4e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1613,7 +1613,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	if (!newsid || sbsec->behavior == SECURITY_FS_USE_MNTPOINT) {
+	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
 		rc = security_transition_sid(sid, dsec->sid, tclass, &newsid);
 		if (rc)
 			return rc;
@@ -2597,7 +2597,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
 
-	if (!newsid || sbsec->behavior == SECURITY_FS_USE_MNTPOINT) {
+	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
 		rc = security_transition_sid(sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
 					     &newsid);
@@ -2619,7 +2619,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = 1;
 	}
 
-	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+	if (!ss_initialized || !(sbsec->flags & SE_SBLABELSUPP))
 		return -EOPNOTSUPP;
 
 	if (name) {
@@ -2796,7 +2796,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
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
