Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKCnkc019419
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:12:49 -0500
Subject: [PATCH 12/13] NFS: Label change notification for NFSv4 Clients
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:12:36 -0500
Message-Id: <1195243956.20981.28.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

NFSv4 Provides methods for detecting changes in attributes and recalling
delegations when state has changed on the server. This has been extended to
include this functionality for label changes on the server. This patch provides
the client implementation for a new callback used to signal relabeling of
files.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfs/callback.h        |   10 ++++
 fs/nfs/callback_proc.c   |  104 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/callback_xdr.c    |   34 +++++++++++++++
 fs/nfs/internal.h        |    1 +
 fs/nfs/nfs3proc.c        |    5 ++-
 fs/nfs/nfs4proc.c        |   13 ++++-
 fs/nfs/proc.c            |    5 ++-
 fs/nfs/super.c           |   13 ++++++
 include/linux/fcntl.h    |    1 +
 include/linux/fsnotify.h |    5 ++
 include/linux/inotify.h  |    3 +-
 11 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index c2bb14e..dfb85d2 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -20,6 +20,7 @@ enum nfs4_callback_procnum {
 enum nfs4_callback_opnum {
 	OP_CB_GETATTR = 3,
 	OP_CB_RECALL  = 4,
+	OP_CB_RELABEL = 5,
 	OP_CB_ILLEGAL = 10044,
 };
 
@@ -59,8 +60,17 @@ struct cb_recallargs {
 	uint32_t truncate;
 };
 
+struct cb_relabelargs {
+	struct sockaddr_in *addr;
+	unsigned long ino;
+	struct nfs_fh fh;
+	const char *label;
+	int labellen;
+};
+
 extern __be32 nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res);
 extern __be32 nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
+extern __be32 nfs4_callback_relabel(struct cb_relabelargs *args, void *dummy);
 
 #ifdef CONFIG_NFS_V4
 extern int nfs_callback_up(void);
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 72e55d8..6eddc48 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -7,6 +7,8 @@
  */
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
+#include <linux/xattr.h>
+#include <linux/security.h>
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
@@ -86,3 +88,105 @@ out:
 	dprintk("%s: exit with status = %d\n", __FUNCTION__, ntohl(res));
 	return res;
 }
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+
+struct nfs_testfh_desc {
+	struct nfs_fh *fh;
+	unsigned long ino;
+};
+
+	static int
+nfs_testfh(struct inode *inode, void *opaque)
+{
+	struct nfs_testfh_desc *desc = (struct nfs_testfh_desc *)opaque;
+
+	if (inode->i_ino != desc->ino)
+		return (0);
+	if (nfs_compare_fh(NFS_FH(inode), desc->fh))
+		return (0);
+	if (is_bad_inode(inode) || NFS_STALE(inode))
+		return (0);
+	return (1);
+}
+
+/*
+ * Lookup an inode by filehandle, i_ino
+ */
+struct inode *nfs_client_inode(struct nfs_client *client, struct nfs_fh *fh, unsigned long ino)
+{
+	struct nfs_testfh_desc desc = {
+		.fh	= fh,
+		.ino	= ino
+	};
+	struct nfs_server *server;
+	struct super_block *sb;
+	struct inode *inode;
+
+	list_for_each_entry(server, &client->cl_superblocks, client_link) {
+		sb = nfs4_server_get_sb(server);
+		if (IS_ERR(sb))
+			continue;
+
+		inode = ilookup5_nowait(sb, ino, nfs_testfh, &desc);
+		if (inode != NULL)
+			return (inode);
+	}
+	return (NULL);
+}
+
+__be32 nfs4_callback_relabel(struct cb_relabelargs *args, void *dummy)
+{
+	struct nfs_client *clp;
+	struct inode *inode;
+	void *context;
+	const char *key;
+	int len;
+	__be32 res;
+
+	res = htonl(NFS4ERR_BADHANDLE);
+	clp = nfs_find_client(args->addr, 4);
+	if (clp == NULL) {
+		printk("%s() nfs_find_client() returned NULL\n", __func__);
+		goto out;
+	}
+
+	inode = nfs_client_inode(clp, &args->fh, args->ino);
+	if (inode == NULL) {
+		printk("%s() nfs_client_inode() returned NULL\n", __func__);
+		goto out_putclient;
+	}
+
+	key = security_inode_xattr_getname() + XATTR_SECURITY_PREFIX_LEN;
+
+	len = security_inode_getsecurity(inode, key, &context, true);
+	if (len < 0) {
+		/* XXX: really should return the error in 'len' */
+		goto out_iput;
+	}
+	if (len > NFS_MAXLABELLEN) {
+		security_release_secctx(context, len);
+		res = -EINVAL;
+		goto out_iput;
+	}
+	if (args->labellen != len ||
+			strncmp(args->label, context, args->labellen) != 0) {
+		(void)security_inode_setsecurity(inode, key,
+				args->label, args->labellen, 0);
+
+		printk("%s() ino %ld label %.*s -> %.*s\n", __func__,
+				inode->i_ino, len, (char *)context, args->labellen, args->label);
+	}
+
+	res = 0;
+
+out_iput:
+	iput(inode);
+out_putclient:
+	nfs_put_client(clp);
+out:
+	dprintk("%s: exit with status = %d\n", __FUNCTION__, ntohl(res));
+	return res;
+}
+
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL */
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 058ade7..ebf68a8 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -12,6 +12,7 @@
 #include "nfs4_fs.h"
 #include "callback.h"
 
+#define CB_OP_COMPOUND_MAXSZ	(16)
 #define CB_OP_TAGLEN_MAXSZ	(512)
 #define CB_OP_HDR_RES_MAXSZ	(2 + CB_OP_TAGLEN_MAXSZ)
 #define CB_OP_GETATTR_BITMAP_MAXSZ	(4)
@@ -19,6 +20,7 @@
 				CB_OP_GETATTR_BITMAP_MAXSZ + \
 				2 + 2 + 3 + 3)
 #define CB_OP_RECALL_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
+#define	CB_OP_RELABEL_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
 
 #define NFSDBG_FACILITY NFSDBG_CALLBACK
 
@@ -204,6 +206,30 @@ out:
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+static __be32 decode_relabel_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_relabelargs *args)
+{
+	__be32 status;
+	__be32 *p;
+
+	p = read_buf(xdr, 8);
+	if (unlikely(p == NULL)) {
+		status = htonl(NFS4ERR_RESOURCE);
+		goto out;
+	}
+	p = xdr_decode_hyper(p, (__u64 *)&args->ino);
+
+	status = decode_fh(xdr, &args->fh);
+	if (unlikely(status != 0))
+		goto out;
+	args->addr = svc_addr_in(rqstp);
+	status = decode_string(xdr, &args->labellen, &args->label);
+out:
+	dprintk("%s: exit with status = %d\n", __FUNCTION__, status);
+	return status;
+}
+#endif
+
 static __be32 encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
 	__be32 *p;
@@ -369,6 +395,7 @@ static __be32 process_op(struct svc_rqst *rqstp,
 		switch (op_nr) {
 			case OP_CB_GETATTR:
 			case OP_CB_RECALL:
+			case OP_CB_RELABEL:
 				op = &callback_ops[op_nr];
 				break;
 			default:
@@ -452,7 +479,14 @@ static struct callback_op callback_ops[] = {
 		.process_op = (callback_process_op_t)nfs4_callback_recall,
 		.decode_args = (callback_decode_arg_t)decode_recall_args,
 		.res_maxsize = CB_OP_RECALL_RES_MAXSZ,
+	},
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	[OP_CB_RELABEL] = {
+		.process_op = (callback_process_op_t)nfs4_callback_relabel,
+		.decode_args = (callback_decode_arg_t)decode_relabel_args,
+		.res_maxsize = CB_OP_RELABEL_RES_MAXSZ,
 	}
+#endif
 };
 
 /*
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f3acf48..0e6d403 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -160,6 +160,7 @@ extern struct rpc_stat nfs_rpcstat;
 
 extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
+extern struct super_block *nfs4_server_get_sb(struct nfs_server *);
 
 /* namespace.c */
 extern char *nfs_path(const char *base,
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1df7137..6b3fcb9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -17,6 +17,7 @@
 #include <linux/nfs_page.h>
 #include <linux/lockd/bind.h>
 #include <linux/nfs_mount.h>
+#include <linux/fsnotify.h>
 
 #include "iostat.h"
 #include "internal.h"
@@ -134,8 +135,10 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	dprintk("NFS call  setattr\n");
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
-	if (status == 0)
+	if (status == 0) {
 		nfs_setattr_update_inode(inode, sattr);
+		fsnotify_change(dentry, sattr->ia_valid);
+	}
 	dprintk("NFS reply setattr: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2d71e44..f8f3b78 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -49,6 +49,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/xattr.h>
+#include <linux/fsnotify.h>
 
 #include "nfs4_fs.h"
 #include "delegation.h"
@@ -1711,8 +1712,10 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 		state = ctx->state;
 
 	status = nfs4_do_setattr(inode, fattr, sattr, state);
-	if (status == 0)
+	if (status == 0) {
 		nfs_setattr_update_inode(inode, sattr);
+		fsnotify_change(dentry, sattr->ia_valid);
+	}
 	if (ctx != NULL)
 		put_nfs_open_context(ctx);
 	put_rpccred(cred);
@@ -1966,8 +1969,10 @@ nfs4_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 			nfs_fattr_alloc(&fattr);
 #endif
 		status = nfs4_do_setattr(state->inode, &fattr, sattr, state);
-		if (status == 0)
+		if (status == 0) {
 			nfs_setattr_update_inode(state->inode, sattr);
+			fsnotify_change(dentry, sattr->ia_valid);
+		}
 		nfs_post_op_update_inode(state->inode, &fattr);
 
 		nfs_fattr_fini(&fattr);
@@ -3061,8 +3066,10 @@ nfs4_set_security_label(struct dentry *dentry, const void *buf, size_t buflen)
 		state = ctx->state;
 
 	status = nfs4_do_set_security_label(inode, &sattr, &fattr, state);
-	if (status == 0)
+	if (status == 0) {
 		nfs_setattr_update_inode(inode, &sattr);
+		fsnotify_change(dentry, sattr.ia_valid);
+	}
 	if (ctx != NULL)
 		put_nfs_open_context(ctx);
 	put_rpccred(cred);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 76f9951..a558e5e 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -43,6 +43,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
 #include <linux/lockd/bind.h>
+#include <linux/fsnotify.h>
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PROC
@@ -131,8 +132,10 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	dprintk("NFS call  setattr\n");
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
-	if (status == 0)
+	if (status == 0) {
 		nfs_setattr_update_inode(inode, sattr);
+		fsnotify_change(dentry, sattr->ia_valid);
+	}
 	dprintk("NFS reply setattr: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 012211f..5faa9ac 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1929,4 +1929,17 @@ error_splat_super:
 	return error;
 }
 
+struct super_block *
+nfs4_server_get_sb(struct nfs_server *server)
+{
+	struct super_block *s;
+
+	list_for_each_entry(s, &nfs4_fs_type.fs_supers, s_instances) {
+		if (server == NFS_SB(s))
+			return (s);
+		/* XXX: refcount? */
+	}
+	return NULL;
+}
+
 #endif /* CONFIG_NFS_V4 */
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 8603740..1b4a576 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -30,6 +30,7 @@
 #define DN_DELETE	0x00000008	/* File removed */
 #define DN_RENAME	0x00000010	/* File renamed */
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
+#define	DN_LABEL	0x00000040	/* File (re)labeled */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
 #define AT_FDCWD		-100    /* Special value used to indicate
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 2bd31fa..bfef9c2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -231,6 +231,11 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		in_mask |= IN_ATTRIB;
 		dn_mask |= DN_ATTRIB;
 	}
+	if (ia_valid & ATTR_SECURITY_LABEL) {
+		in_mask |= IN_LABEL;
+		dn_mask |= DN_LABEL;
+	}
+
 
 	if (dn_mask)
 		dnotify_parent(dentry, dn_mask);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 742b917..10f3ace 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -36,6 +36,7 @@ struct inotify_event {
 #define IN_DELETE		0x00000200	/* Subfile was deleted */
 #define IN_DELETE_SELF		0x00000400	/* Self was deleted */
 #define IN_MOVE_SELF		0x00000800	/* Self was moved */
+#define IN_LABEL		0x00001000	/* Self was (re)labeled */
 
 /* the following are legal events.  they are sent as needed to any watch */
 #define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
@@ -61,7 +62,7 @@ struct inotify_event {
 #define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
 			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
 			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF | \
-			 IN_MOVE_SELF)
+			 IN_MOVE_SELF | IN_LABEL)
 
 #ifdef __KERNEL__
 
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
