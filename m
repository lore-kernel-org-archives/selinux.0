Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FJlHZi029319
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 15:47:23 -0400
Received: by obbop1 with SMTP id op1so33394597obb.2
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 12:47:21 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 5/7] security: Restrict security attribute updates for userns
 mounts
Date: Wed, 15 Jul 2015 14:46:06 -0500
Message-Id: <1436989569-69582-6-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Respecting security labels for mounts from user namespaces may
allow unprivileged users to introduce security labels into the
system. To stop this from happening prevent calling the
inode_post_setxattr, inode_setsecurity, inode_notifysecctx, and
inode_setsecctx hooks when s_user_ns != init_user_ns. There's no
purpose in actually blocking setting of these xattrs, as (for rw
mounts at least) the user must have write access to the
underlying filesystem and could set the xattrs by other means.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 security/security.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 062f3c997fdc..980710baa8f9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -653,7 +653,9 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
-	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
+	if (dentry->d_inode->i_sb->s_user_ns == &init_user_ns)
+		call_void_hook(inode_post_setxattr, dentry, name, value, size,
+			       flags);
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
@@ -712,6 +714,8 @@ int security_inode_getsecurity(const struct inode *inode, const char *name, void
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
+	if (inode->i_sb->s_user_ns != &init_user_ns)
+		return -EOPNOTSUPP;
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	return call_int_hook(inode_setsecurity, -EOPNOTSUPP, inode, name,
@@ -1168,12 +1172,16 @@ EXPORT_SYMBOL(security_release_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+	if (inode->i_sb->s_user_ns != &init_user_ns)
+		return -EOPNOTSUPP;
 	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
+	if (dentry->d_inode->i_sb->s_user_ns != &init_user_ns)
+		return -EOPNOTSUPP;
 	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
-- 
1.9.1
