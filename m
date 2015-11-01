Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA1HOleI002534
 for <selinux@tycho.nsa.gov>; Sun, 1 Nov 2015 12:24:51 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 5/7] security: Add hook to invalidate inode security labels
Date: Sun,  1 Nov 2015 18:24:31 +0100
Message-Id: <1446398673-886-6-git-send-email-agruenba@redhat.com>
In-Reply-To: <1446398673-886-1-git-send-email-agruenba@redhat.com>
References: <1446398673-886-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a hook to invalidate an inode's security label when the cached
information becomes invalid.

Add the new hook in selinux: set a flag when a security label becomes
invalid.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
---
 include/linux/lsm_hooks.h         |  6 ++++++
 include/linux/security.h          |  5 +++++
 security/security.c               |  8 ++++++++
 security/selinux/hooks.c          | 30 ++++++++++++++++++++----------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4c48227..71969de 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1261,6 +1261,10 @@
  *	audit_rule_init.
  *	@rule contains the allocated rule
  *
+ * @inode_invalidate_secctx:
+ *	Notify the security module that it must revalidate the security context
+ *	of an inode.
+ *
  * @inode_notifysecctx:
  *	Notify the security module of what the security context of an inode
  *	should be.  Initializes the incore security context managed by the
@@ -1516,6 +1520,7 @@ union security_list_options {
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
+	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
@@ -1757,6 +1762,7 @@ struct security_hook_heads {
 	struct list_head secid_to_secctx;
 	struct list_head secctx_to_secid;
 	struct list_head release_secctx;
+	struct list_head inode_invalidate_secctx;
 	struct list_head inode_notifysecctx;
 	struct list_head inode_setsecctx;
 	struct list_head inode_getsecctx;
diff --git a/include/linux/security.h b/include/linux/security.h
index e79149a..4824a4c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -353,6 +353,7 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
+void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
@@ -1093,6 +1094,10 @@ static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
 
+static inline void security_inode_invalidate_secctx(struct inode *inode)
+{
+}
+
 static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
 	return -EOPNOTSUPP;
diff --git a/security/security.c b/security/security.c
index c5beb7e..e8ffd92 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1161,6 +1161,12 @@ void security_release_secctx(char *secdata, u32 seclen)
 }
 EXPORT_SYMBOL(security_release_secctx);
 
+void security_inode_invalidate_secctx(struct inode *inode)
+{
+	call_void_hook(inode_invalidate_secctx, inode);
+}
+EXPORT_SYMBOL(security_inode_invalidate_secctx);
+
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
 	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
@@ -1763,6 +1769,8 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.secctx_to_secid),
 	.release_secctx =
 		LIST_HEAD_INIT(security_hook_heads.release_secctx),
+	.inode_invalidate_secctx =
+		LIST_HEAD_INIT(security_hook_heads.inode_invalidate_secctx),
 	.inode_notifysecctx =
 		LIST_HEAD_INIT(security_hook_heads.inode_notifysecctx),
 	.inode_setsecctx =
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 48d1908..dcac6dc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -820,7 +820,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 
 		root_isec->sid = rootcontext_sid;
-		root_isec->initialized = 1;
+		root_isec->initialized = LABEL_INITIALIZED;
 	}
 
 	if (defcontext_sid) {
@@ -1308,11 +1308,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	unsigned len = 0;
 	int rc = 0;
 
-	if (isec->initialized)
+	if (isec->initialized == LABEL_INITIALIZED)
 		goto out;
 
 	mutex_lock(&isec->lock);
-	if (isec->initialized)
+	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
 
 	sbsec = inode->i_sb->s_security;
@@ -1484,7 +1484,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		break;
 	}
 
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 
 out_unlock:
 	mutex_unlock(&isec->lock);
@@ -2793,7 +2793,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		struct inode_security_struct *isec = inode->i_security;
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
-		isec->initialized = 1;
+		isec->initialized = LABEL_INITIALIZED;
 	}
 
 	if (!ss_initialized || !(sbsec->flags & SBLABEL_MNT))
@@ -3091,7 +3091,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 
 	return;
 }
@@ -3185,7 +3185,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 	return 0;
 }
 
@@ -3763,7 +3763,7 @@ static void selinux_task_to_inode(struct task_struct *p,
 	u32 sid = task_sid(p);
 
 	isec->sid = sid;
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 }
 
 /* Returns error only if unable to parse addresses */
@@ -4094,7 +4094,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 			return err;
 	}
 
-	isec->initialized = 1;
+	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
 		sksec = sock->sk->sk_security;
@@ -4285,7 +4285,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	isec = inode_security(SOCK_INODE(sock));
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
-	newisec->initialized = 1;
+	newisec->initialized = LABEL_INITIALIZED;
 
 	return 0;
 }
@@ -5775,6 +5775,15 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 	kfree(secdata);
 }
 
+static void selinux_inode_invalidate_secctx(struct inode *inode)
+{
+	struct inode_security_struct *isec = inode->i_security;
+
+	mutex_lock(&isec->lock);
+	isec->initialized = LABEL_INVALID;
+	mutex_unlock(&isec->lock);
+}
+
 /*
  *	called with inode->i_mutex locked
  */
@@ -6006,6 +6015,7 @@ static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
+	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 81fa718..a2ae054 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -37,6 +37,12 @@ struct task_security_struct {
 	u32 sockcreate_sid;	/* fscreate SID */
 };
 
+enum label_initialized {
+	LABEL_MISSING,		/* not initialized */
+	LABEL_INITIALIZED,	/* inizialized */
+	LABEL_INVALID		/* invalid */
+};
+
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
 	union {
-- 
2.5.0
