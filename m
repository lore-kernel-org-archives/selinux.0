From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: [PATCH] selinux: Don't sleep inside inode_getsecid hook
Date: Thu, 18 Feb 2016 12:04:08 +0100
Message-Id: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The inode_getsecid hook is called from contexts in which sleeping is not
allowed, so we cannot revalidate inode security labels from there. Use
the non-validating version of inode_security() instead.

Reported-by: Benjamin Coddington <bcodding@redhat.com> 
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f8110cf..f1ab715 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3249,7 +3249,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 
 static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
 {
-	struct inode_security_struct *isec = inode_security(inode);
+	struct inode_security_struct *isec = inode_security_novalidate(inode);
 	*secid = isec->sid;
 }
 
-- 
2.4.3
