From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/2] LSM/SELinux: inode_{get,set,notify}secctx hooks to access LSM security context information.
Date: Wed, 23 Apr 2008 12:57:16 -0400
Message-Id: <1208969836-8129-3-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces three new hooks. The inode_getsecctx hook is used to get
all relevant information from an LSM about an inode. The inode_setsecctx is
used to set both the in-core and on-disk state for the inode based on a context
derived from inode_getsecctx.The final hook inode_notifysecctx will notify the
LSM of a change for the in-core state of the inode in question. These hooks are
for use in the labeled NFS code and addresses concerns of how to set security
on an inode in a multi-xattr LSM. For historical reasons Stephen Smalley's
explination of the reason for these hooks is pasted below.

Quote Stephen Smalley

inode_setsecctx:  Change the security context of an inode.  Updates the
incore security context managed by the security module and invokes the
fs code as needed (via __vfs_setxattr_noperm) to update any backing
xattrs that represent the context.  Example usage:  NFS server invokes
this hook to change the security context in its incore inode and on the
backing filesystem to a value provided by the client on a SETATTR
operation.

inode_notifysecctx:  Notify the security module of what the security
context of an inode should be.  Initializes the incore security context
managed by the security module for this inode.  Example usage:  NFS
client invokes this hook to initialize the security context in its
incore inode to the value provided by the server for the file when the
server returned the file's attributes to the client.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 include/linux/security.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |   17 +++++++++++++++
 security/security.c      |   18 ++++++++++++++++
 security/selinux/hooks.c |   28 +++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fea1f4a..0b1ae00 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1276,6 +1276,36 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	audit_rule_init.
  *	@rule contains the allocated rule
  *
+ * @inode_notifysecctx:
+ *	Notify the security module of what the security context of an inode
+ *	should be.  Initializes the incore security context managed by the
+ *	security module for this inode.  Example usage:  NFS client invokes
+ *	this hook to initialize the security context in its incore inode to the
+ *	value provided by the server for the file when the server returned the
+ *	file's attributes to the client.
+ *
+ * 	@inode we wish to set the security context of.
+ * 	@ctx contains the string which we wish to set in the inode.
+ * 	@ctxlen contains the length of @ctx.
+ *
+ * @inode_setsecctx:
+ * 	Change the security context of an inode.  Updates the
+ * 	incore security context managed by the security module and invokes the
+ * 	fs code as needed (via __vfs_setxattr_noperm) to update any backing
+ * 	xattrs that represent the context.  Example usage:  NFS server invokes
+ * 	this hook to change the security context in its incore inode and on the
+ * 	backing filesystem to a value provided by the client on a SETATTR
+ * 	operation.
+ *
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
@@ -1470,6 +1500,10 @@ struct security_operations {
 	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
+	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_getsecctx)(struct dentry *dentry, void **ctx, u32 *ctxlen);
+
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
 				    struct socket * other, struct sock * newsk);
@@ -1719,6 +1753,9 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
+int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -2443,6 +2480,19 @@ static inline int security_secctx_to_secid(char *secdata,
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
+
+static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
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
index 98d5f96..15d21c8 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -976,6 +976,20 @@ static void dummy_release_secctx(char *secdata, u32 seclen)
 {
 }
 
+static int dummy_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
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
@@ -1163,6 +1177,9 @@ void security_fixup_ops (struct security_operations *ops)
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
index 2e250c7..3accb45 100644
--- a/security/security.c
+++ b/security/security.c
@@ -898,6 +898,24 @@ void security_release_secctx(char *secdata, u32 seclen)
 }
 EXPORT_SYMBOL(security_release_secctx);
 
+int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+{
+	return security_ops->inode_notifysecctx(inode, ctx, ctxlen);
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
index 1bf2543..58f4bd8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -75,6 +75,7 @@
 #include <linux/string.h>
 #include <linux/selinux.h>
 #include <linux/mutex.h>
+#include <linux/fsnotify.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -5236,6 +5237,30 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 	kfree(secdata);
 }
 
+/*
+ *	This hook requires that the inode i_mutex be locked
+ */
+static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+{
+	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+}
+
+/*
+ *	This hook requires that the inode i_mutex be locked
+ */
+static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
@@ -5429,6 +5454,9 @@ static struct security_operations selinux_ops = {
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.secctx_to_secid =		selinux_secctx_to_secid,
 	.release_secctx =		selinux_release_secctx,
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
