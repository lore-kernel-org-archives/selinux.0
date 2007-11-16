Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKD4KP019465
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:13:04 -0500
Subject: [PATCH 13/13] NFSD: Label change notification for NFSv4 Server
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:13:02 -0500
Message-Id: <1195243982.20981.30.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

NFSv4 Provides methods for detecting changes in attributes and recalling
delegations when state has changed on the server. This has been extended to
include this functionality for label changes on the server. This patch provides
the server implementation for a new callback used to signal relabeling of
files.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfsd/nfs4callback.c     |  125 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c        |   95 ++++++++++++++++++++++++++++++++-
 include/linux/nfsd/state.h |   17 ++++++
 3 files changed, 233 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 9d536a8..6fe48b1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -40,6 +40,8 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
+#include <linux/security.h>
+#include <linux/xattr.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/clnt.h>
@@ -49,6 +51,7 @@
 #include <linux/nfs4.h>
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
+#define NFS_MAXLABELLEN			255
 
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
@@ -61,10 +64,12 @@ static const struct rpc_call_ops nfs4_cb_null_ops;
 enum {
         NFSPROC4_CLNT_CB_NULL = 0,
 	NFSPROC4_CLNT_CB_RECALL,
+	NFSPROC4_CLNT_CB_RELABEL,
 };
 
 enum nfs_cb_opnum4 {
 	OP_CB_RECALL            = 4,
+	OP_CB_RELABEL		= 5,
 };
 
 #define NFS4_MAXTAGLEN		20
@@ -76,6 +81,8 @@ enum nfs_cb_opnum4 {
 #define op_enc_sz			1
 #define op_dec_sz			2
 #define enc_nfs4_fh_sz			(1 + (NFS4_FHSIZE >> 2))
+#define	enc_nfs4_label_sz		(1 + (NFS_MAXLABELLEN >> 2))
+#define	enc_i_ino_sz			1
 #define enc_stateid_sz			(NFS4_STATEID_SIZE >> 2)
 #define NFS4_enc_cb_recall_sz		(cb_compound_enc_hdr_sz +       \
 					1 + enc_stateid_sz +            \
@@ -84,6 +91,13 @@ enum nfs_cb_opnum4 {
 #define NFS4_dec_cb_recall_sz		(cb_compound_dec_hdr_sz  +      \
 					op_dec_sz)
 
+#define	NFS4_enc_cb_relabel_sz		(cb_compound_enc_hdr_sz +	\
+					 op_enc_sz +			\
+					 enc_i_ino_sz +			\
+					 enc_nfs4_fh_sz +		\
+					 enc_nfs4_label_sz)
+#define	NFS4_dec_cb_relabel_sz		(cb_compound_dec_hdr_sz  +      \
+					 op_dec_sz)
 /*
 * Generic encode routines from fs/nfs/nfs4xdr.c
 */
@@ -233,6 +247,24 @@ encode_cb_recall(struct xdr_stream *xdr, struct nfs4_cb_recall *cb_rec)
 }
 
 static int
+encode_cb_relabel(struct xdr_stream *xdr, struct nfs4_cb_relabel *cbr)
+{
+	__be32 *p;
+
+	RESERVE_SPACE(12 + 8 + cbr->fhlen + cbr->label_len);
+	WRITE32(OP_CB_RELABEL);
+	/* ino_t */
+	p = xdr_encode_hyper(p, cbr->ino);
+	/* File handle */
+	WRITE32(cbr->fhlen);
+	WRITEMEM(cbr->fhval, cbr->fhlen);
+	/* Label */
+	WRITE32(cbr->label_len);
+	WRITEMEM(cbr->label, cbr->label_len);
+	return 0;
+}
+
+static int
 nfs4_xdr_enc_cb_null(struct rpc_rqst *req, __be32 *p)
 {
 	struct xdr_stream xdrs, *xdr = &xdrs;
@@ -256,6 +288,19 @@ nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, __be32 *p, struct nfs4_cb_recall *a
 	return (encode_cb_recall(&xdr, args));
 }
 
+static int
+nfs4_xdr_enc_cb_relabel(struct rpc_rqst *req, __be32 *p, struct nfs4_cb_relabel *args)
+{
+	struct xdr_stream xdr;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = args->ident,
+		.nops   = 1,
+	};
+
+	xdr_init_encode(&xdr, &req->rq_snd_buf, p);
+	encode_cb_compound_hdr(&xdr, &hdr);
+	return (encode_cb_relabel(&xdr, args));
+}
 
 static int
 decode_cb_compound_hdr(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr){
@@ -314,6 +359,22 @@ out:
 	return status;
 }
 
+static int
+nfs4_xdr_dec_cb_relabel(struct rpc_rqst *rqstp, __be32 *p)
+{
+	struct xdr_stream xdr;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+
+	xdr_init_decode(&xdr, &rqstp->rq_rcv_buf, p);
+	status = decode_cb_compound_hdr(&xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_cb_op_hdr(&xdr, OP_CB_RELABEL);
+out:
+	return status;
+}
+
 /*
  * RPC procedure tables
  */
@@ -329,8 +390,9 @@ out:
 }
 
 static struct rpc_procinfo     nfs4_cb_procedures[] = {
-    PROC(CB_NULL,      NULL,     enc_cb_null,     dec_cb_null),
-    PROC(CB_RECALL,    COMPOUND,   enc_cb_recall,      dec_cb_recall),
+	PROC(CB_NULL,		NULL,		enc_cb_null,		dec_cb_null),
+	PROC(CB_RECALL,		COMPOUND,	enc_cb_recall,		dec_cb_recall),
+	PROC(CB_RELABEL,	COMPOUND,	enc_cb_relabel,		dec_cb_relabel),
 };
 
 static struct rpc_version       nfs_cb_version4 = {
@@ -490,3 +552,62 @@ out_put_cred:
 	nfs4_put_delegation(dp);
 	return;
 }
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+void
+nfsd4_cb_relabel(struct nfs4_stateid *stp)
+{
+	struct nfs4_client *clp = stp->st_stateowner->so_client;
+	struct rpc_clnt *clnt = clp->cl_callback.cb_client;
+	struct nfs4_cb_relabel args;
+	struct rpc_message msg = {
+		.rpc_proc       = &nfs4_cb_procedures[NFSPROC4_CLNT_CB_RELABEL],
+		.rpc_argp       = &args,
+	};
+	void *context;
+	const char *key;
+	int len;
+	int retries = 1;
+	int status = 0;
+
+	key = security_inode_xattr_getname() + XATTR_SECURITY_PREFIX_LEN;
+	len = security_inode_getsecurity(stp->st_file->fi_inode, key, &context
+						, true);
+	if (len < 0) {
+		goto out;
+	}
+	if (len > NFS_MAXLABELLEN) {
+		security_release_secctx(context, len);
+		goto out;
+	}
+	args.ident = clp->cl_callback.cb_ident;
+	args.ino = stp->st_file->fi_inode->i_ino;
+	args.fhlen = stp->st_fh.fh_handle.fh_size;
+	memcpy(args.fhval, &stp->st_fh.fh_handle.fh_base, args.fhlen);
+	args.label = context;
+	args.label_len = len;
+
+	status = rpc_call_sync(clnt, &msg, RPC_TASK_SOFT);
+	while (retries--) {
+		switch (status) {
+			case -EIO:
+				/* Network partition? */
+			case -EBADHANDLE:
+			case -NFS4ERR_BAD_STATEID:
+				/* Race: client probably got cb_recall
+				 * before open reply granting delegation */
+				break;
+			default:
+				goto out_put_cred;
+		}
+		ssleep(2);
+		status = rpc_call_sync(clnt, &msg, RPC_TASK_SOFT);
+	}
+
+out_put_cred:
+	security_release_secctx(context, len);
+out:
+	/* XXX: need to release references! */
+	return;
+}
+#endif
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 31673cd..dcd7f69 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -79,6 +79,17 @@ static void release_stateid_lockowners(struct nfs4_stateid *open_stp);
 static char user_recovery_dirname[PATH_MAX] = "/var/lib/nfs/v4recovery";
 static void nfs4_set_recdir(char *recdir);
 
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+static struct inotify_handle *nfsd_ih = NULL;
+static void nfsd_watch_event(struct inotify_watch *, u32, u32, u32,
+		const char *, struct inode *);
+static void nfsd_watch_destroy(struct inotify_watch *);
+static struct inotify_operations nfsd_state_event_handler = {
+	.handle_event	= nfsd_watch_event,
+	.destroy_watch	= nfsd_watch_destroy,
+};
+#endif
+
 /* Locking:
  *
  * client_mutex:
@@ -135,7 +146,13 @@ free_nfs4_file(struct kref *kref)
 	struct nfs4_file *fp = container_of(kref, struct nfs4_file, fi_ref);
 	list_del(&fp->fi_hash);
 	iput(fp->fi_inode);
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	(void)inotify_rm_watch(nfsd_ih, &fp->fi_wdata);
+	put_inotify_watch(&fp->fi_wdata);
+	/* Defer free to nfsd_watch_destroy() */
+#else
 	kmem_cache_free(file_slab, fp);
+#endif
 }
 
 static inline void
@@ -988,6 +1005,11 @@ alloc_init_file(struct inode *ino)
 		fp->fi_inode = igrab(ino);
 		fp->fi_id = current_fileid++;
 		fp->fi_had_conflict = false;
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+		inotify_init_watch(&fp->fi_wdata);
+		get_inotify_watch(&fp->fi_wdata);
+		(void)inotify_add_watch(nfsd_ih, &fp->fi_wdata, ino, IN_LABEL);
+#endif
 		return fp;
 	}
 	return NULL;
@@ -1137,7 +1159,9 @@ release_stateowner(struct nfs4_stateowner *sop)
 }
 
 static inline void
-init_stateid(struct nfs4_stateid *stp, struct nfs4_file *fp, struct nfsd4_open *open) {
+init_stateid(struct nfs4_stateid *stp, struct nfs4_file *fp, struct svc_fh *fh,
+			struct nfsd4_open *open)
+{
 	struct nfs4_stateowner *sop = open->op_stateowner;
 	unsigned int hashval = stateid_hashval(sop->so_id, fp->fi_id);
 
@@ -1160,6 +1184,9 @@ init_stateid(struct nfs4_stateid *stp, struct nfs4_file *fp, struct nfsd4_open *
 	__set_bit(open->op_share_access, &stp->st_access_bmap);
 	__set_bit(open->op_share_deny, &stp->st_deny_bmap);
 	stp->st_openstp = NULL;
+
+	fh_init(&stp->st_fh, NFS4_FHSIZE);
+	(void)fh_compose(&stp->st_fh, fh->fh_export, fh->fh_dentry, fh);
 }
 
 static void
@@ -1177,6 +1204,7 @@ release_stateid(struct nfs4_stateid *stp, int flags)
 	} else if (flags & LOCK_STATE)
 		locks_remove_posix(filp, (fl_owner_t) stp->st_stateowner);
 	put_nfs4_file(stp->st_file);
+	fh_put(&stp->st_fh);
 	kmem_cache_free(stateid_slab, stp);
 }
 
@@ -1791,7 +1819,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfs4_new_open(rqstp, &stp, dp, current_fh, flags);
 		if (status)
 			goto out;
-		init_stateid(stp, fp, open);
+		init_stateid(stp, fp, current_fh, open);
 		status = nfsd4_truncate(rqstp, current_fh, open);
 		if (status) {
 			release_stateid(stp, OPEN_STATE);
@@ -3241,6 +3269,9 @@ nfs4_state_start(void)
 {
 	if (nfs4_init)
 		return;
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	nfsd_ih = inotify_init(&nfsd_state_event_handler);
+#endif
 	nfsd4_load_reboot_recovery_data();
 	__nfs4_state_start();
 	nfs4_init = 1;
@@ -3350,3 +3381,63 @@ nfs4_reset_lease(time_t leasetime)
 	user_lease_time = leasetime;
 	unlock_kernel();
 }
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+
+	static int
+do_relabel(void *__stp)
+{
+	struct nfs4_stateid *stp = __stp;
+
+	daemonize("nfsv4-relabel");
+
+	nfsd4_cb_relabel(stp);
+	return (0);
+}
+
+	static void
+nfsd_watch_event(struct inotify_watch *watch, u32 wd, u32 mask, u32 cookie,
+		const char *name, struct inode *inode)
+{
+	struct nfs4_file *fp;
+	struct nfs4_stateid *stp;
+	struct task_struct *t;
+
+	fp = container_of(watch, struct nfs4_file, fi_wdata);
+
+	if (mask & IN_IGNORED) {
+		put_inotify_watch(&fp->fi_wdata);
+		return;
+	}
+
+	if ((mask & IN_LABEL) == 0)
+		return;
+
+	list_for_each_entry(stp, &fp->fi_stateids, st_perfile) {
+		struct nfs4_client *clp = stp->st_stateowner->so_client;
+
+		/* XXX: need to refcount something! */
+
+		printk("%s() STP client \"%.*s\" fh \"%s\"\n", __func__,
+				clp->cl_name.len, clp->cl_name.data,
+				SVCFH_fmt(&stp->st_fh));
+
+		t = kthread_run(do_relabel, stp, "%s", "nfs4_cb_relabel");
+		if (IS_ERR(t)) {
+			printk(KERN_INFO "NFSD: Callback thread failed for "
+					"for client (clientid %08x/%08x)\n",
+					clp->cl_clientid.cl_boot, clp->cl_clientid.cl_id);
+		}
+
+	}
+}
+
+	static void
+nfsd_watch_destroy(struct inotify_watch *watch)
+{
+	struct nfs4_file *fp;
+
+	fp = container_of(watch, struct nfs4_file, fi_wdata);
+	kmem_cache_free(file_slab, fp);
+}
+#endif	/* CONFIG_NFSD_V4_SECURITY_LABEL */
diff --git a/include/linux/nfsd/state.h b/include/linux/nfsd/state.h
index db348f7..043f800 100644
--- a/include/linux/nfsd/state.h
+++ b/include/linux/nfsd/state.h
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/sunrpc/clnt.h>
+#include <linux/inotify.h>
 
 #define NFS4_OPAQUE_LIMIT 1024
 typedef struct {
@@ -71,6 +72,15 @@ struct nfs4_cb_recall {
 	struct nfs4_delegation	*cbr_dp;
 };
 
+struct nfs4_cb_relabel {
+	u32			ident;
+	unsigned long		ino;
+	u32			fhlen;
+	u32			fhval[NFS4_FHSIZE];
+	char *			label;
+	int			label_len;
+};
+
 struct nfs4_delegation {
 	struct list_head	dl_perfile;
 	struct list_head	dl_perclnt;
@@ -85,6 +95,7 @@ struct nfs4_delegation {
 	struct nfs4_cb_recall	dl_recall;
 };
 
+#define dl_ident	dl_recall.cbr_ident
 #define dl_stateid      dl_recall.cbr_stateid
 #define dl_fhlen        dl_recall.cbr_fhlen
 #define dl_fhval        dl_recall.cbr_fhval
@@ -225,6 +236,10 @@ struct nfs4_file {
 	u32                     fi_id;      /* used with stateowner->so_id 
 					     * for stateid_hashtbl hash */
 	bool			fi_had_conflict;
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	struct inotify_watch	fi_wdata;
+#endif
 };
 
 /*
@@ -251,6 +266,7 @@ struct nfs4_stateid {
 	struct list_head              st_lockowners;
 	struct nfs4_stateowner      * st_stateowner;
 	struct nfs4_file            * st_file;
+	struct svc_fh                 st_fh;
 	stateid_t                     st_stateid;
 	struct file                 * st_vfs_file;
 	unsigned long                 st_access_bmap;
@@ -284,6 +300,7 @@ extern void put_nfs4_client(struct nfs4_client *clp);
 extern void nfs4_free_stateowner(struct kref *kref);
 extern void nfsd4_probe_callback(struct nfs4_client *clp);
 extern void nfsd4_cb_recall(struct nfs4_delegation *dp);
+extern void nfsd4_cb_relabel(struct nfs4_stateid *stp);
 extern void nfs4_put_delegation(struct nfs4_delegation *dp);
 extern __be32 nfs4_make_rec_clidname(char *clidname, struct xdr_netobj *clname);
 extern void nfsd4_init_recdir(char *recdir_name);
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
