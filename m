From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] selinux: Inode label revalidation performance fix
Date: Tue,  5 Jan 2016 23:12:33 +0100
Message-Id: <1452031953-497-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 5d226df4 has introduced a performance regression of about
10% in the UnixBench pipe benchmark.  It turns out that the call
to inode_security in selinux_file_permission can be moved below
the zero-mask test and that inode_security_revalidate can be
removed entirely, which brings us back to roughly the original
performance.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 40e071a..f8110cf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -273,11 +273,6 @@ static int __inode_security_revalidate(struct inode *inode,
 	return 0;
 }
 
-static void inode_security_revalidate(struct inode *inode)
-{
-	__inode_security_revalidate(inode, NULL, true);
-}
-
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
 	return inode->i_security;
@@ -3277,19 +3272,19 @@ static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
 	struct file_security_struct *fsec = file->f_security;
-	struct inode_security_struct *isec = inode_security(inode);
+	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
 	if (!mask)
 		/* No permission to check.  Existence test. */
 		return 0;
 
+	isec = inode_security(inode);
 	if (sid == fsec->sid && fsec->isid == isec->sid &&
 	    fsec->pseqno == avc_policy_seqno())
 		/* No change since file_open check. */
 		return 0;
 
-	inode_security_revalidate(inode);
 	return selinux_revalidate_file_permission(file, mask);
 }
 
@@ -3595,7 +3590,6 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	 * new inode label or new policy.
 	 * This check is not redundant - do not remove.
 	 */
-	inode_security_revalidate(file_inode(file));
 	return file_path_has_perm(cred, file, open_file_to_av(file));
 }
 
-- 
2.7.0
