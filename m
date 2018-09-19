From: Taras Kondratiuk <takondra@cisco.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 xe-linux-external@cisco.com
Date: Wed, 19 Sep 2018 16:52:48 +0000
Message-Id: <20180919165248.53090-1-takondra@cisco.com>
Subject: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When files on NFSv4 server are not properly labeled (label doesn't match
a policy on a client) they will end up with unlabeled_t type which is
too generic. We would like to be able to set a default context per
mount. 'defcontext' mount option looks like a nice solution, but it
doesn't seem to be fully implemented for native labeling. Default
context is stored, but is never used.

The patch adds a fallback to a default context if a received context is
invalid. If the inode context is already initialized, then it is left
untouched to preserve a context set locally on a client.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..f7debe798bf5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	struct superblock_security_struct *sbsec;
+	struct inode_security_struct *isec;
+	int rc;
+
+	rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+
+	/*
+	 * In case of Native labeling with defcontext mount option fall back
+	 * to a default SID if received context is invalid.
+	 */
+	if (rc == -EINVAL) {
+		sbsec = inode->i_sb->s_security;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
+		    sbsec->flags & DEFCONTEXT_MNT) {
+			isec = inode->i_security;
+			if (!isec->initialized) {
+				isec->sclass = inode_mode_to_security_class(inode->i_mode);
+				isec->sid = sbsec->def_sid;
+				isec->initialized = 1;
+			}
+			rc = 0;
+		}
+	}
+	return rc;
 }
 
 /*
-- 
2.10.3.dirty
