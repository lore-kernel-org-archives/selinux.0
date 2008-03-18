From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access LSM security context information.
Date: Tue, 18 Mar 2008 14:57:44 -0400
Message-Id: <1205866664-24902-3-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1205866664-24902-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1205866664-24902-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces two new hooks. One to get all relevant information from
an LSM about an inode an the second given that context to set it on the
inode. The setcontext call takes a flag to indicate if it should set the incore
representation, the ondisk representation or both. This hook is for use in the
labeled NFS code and addresses concerns of how to set security on an inode in a
multi-xattr LSM.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 include/linux/security.h |   37 +++++++++++++++++++++++++++++++++++++
 security/dummy.c         |   17 +++++++++++++++++
 security/security.c      |   18 ++++++++++++++++++
 security/selinux/hooks.c |   32 +++++++++++++++++++++++++++++++-
 4 files changed, 103 insertions(+), 1 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b07357c..220ec46 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1224,6 +1224,23 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	@secdata contains the security context.
  *	@seclen contains the length of the security context.
  *
+ * @inode_notifysecctx:
+ * 	Set the incore security context of an inode.
+ * 	@dentry contains the inode we wish to set the security context of.
+ * 	@ctx contains the string which we wish to set in the inode.
+ * 	@ctxlen contains the length of @ctx.
+ *
+ * @inode_setsecctx:
+ * 	Sets both the incore and persistant form of the inode's security context.
+ * 	@dentry contains the inode we wish to set the security context of.
+ * 	@ctx contains the string which we wish to set in the inode.
+ * 	@ctxlen contains the length of @ctx.
+ *
+ * @inode_getsecctx:
+ * 	Returns a string containing all relavent security context information 	
+ * 	@dentry contains the inode we wish to set the security context of.
+ *	@ctx is a pointer to place the allocated security context should be placed.
+ *	@ctxlen points to the place to put the length of @ctx.	
  * This is the main security structure.
  */
 struct security_operations {
@@ -1414,6 +1431,10 @@ struct security_operations {
 	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
+	int (*inode_notifysecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_getsecctx)(struct dentry *dentry, void **ctx, u32 *ctxlen);
+
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
 				    struct socket * other, struct sock * newsk);
@@ -1653,6 +1674,9 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
+int security_inode_notifysecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -2365,6 +2389,19 @@ static inline int security_secctx_to_secid(char *secdata,
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
+
+static inline int security_inode_notifysecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+static inline int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 78d8f92..872b45c 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -962,6 +962,20 @@ static void dummy_release_secctx(char *secdata, u32 seclen)
 {
 }
 
+static int dummy_inode_notifysecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+static int dummy_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+
+static int dummy_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1121,6 +1135,9 @@ void security_fixup_ops (struct security_operations *ops)
  	set_to_dummy_if_null(ops, secid_to_secctx);
 	set_to_dummy_if_null(ops, secctx_to_secid);
  	set_to_dummy_if_null(ops, release_secctx);
+	set_to_dummy_if_null(ops, inode_notifysecctx);
+	set_to_dummy_if_null(ops, inode_setsecctx);
+	set_to_dummy_if_null(ops, inode_getsecctx);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/security.c b/security/security.c
index b1387a6..39ed78f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -852,6 +852,24 @@ void security_release_secctx(char *secdata, u32 seclen)
 }
 EXPORT_SYMBOL(security_release_secctx);
 
+int security_inode_notifysecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return security_ops->inode_notifysecctx(dentry, ctx, ctxlen);
+}
+EXPORT_SYMBOL(security_inode_notifysecctx);
+
+int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+{
+	return security_ops->inode_setsecctx(dentry, ctx, ctxlen);
+}
+EXPORT_SYMBOL(security_inode_setsecctx);
+
+int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen)
+{
+	return security_ops->inode_getsecctx(dentry, ctx, ctxlen);
+}
+EXPORT_SYMBOL(security_inode_getsecctx);
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct socket *sock, struct socket *other,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4bf4807..5ce6bbe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -75,6 +75,7 @@
 #include <linux/string.h>
 #include <linux/selinux.h>
 #include <linux/mutex.h>
+#include <linux/fsnotify.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -5174,6 +5175,33 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 	kfree(secdata);
 }
 
+/*
+ *	This hook requires that the inode i_mutex be locked
+ */
+static int selinux_inode_notifysecctx(struct dentry *dentry, void *ctx, u32 ctxlen, bool setdisk)
+{
+	struct inode *inode = dentry->d_inode;
+
+	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	
+}
+
+/*
+ *	This hook requires that the inode i_mutex be locked
+ */
+static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen, bool setdisk)
+{
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0); 
+}
+
+static int selinux_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen)
+{
+	struct inode *inode = dentry->d_inode;
+	
+	*ctxlen = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
+						ctx, true);
+	return *ctxlen;
+}
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -5364,7 +5392,9 @@ static struct security_operations selinux_ops = {
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.secctx_to_secid =		selinux_secctx_to_secid,
 	.release_secctx =		selinux_release_secctx,
-
+	.inode_notifysecctx =		selinux_inode_notifysecctx,
+	.inode_setsecctx =		selinux_inode_setsecctx,
+	.inode_getsecctx =		selinux_inode_getsecctx,
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
 
-- 
1.5.4.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
