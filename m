Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E76C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61326FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Km/Be437"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEaXTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:19:17 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:45409 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfEaXTR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344752; bh=fEFSaTJW0PhJ/+1XDLyA9EJN3fv5fqnG/83jcoBEXmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Km/Be437jnj4mqynUq4/M7BO6USdFwX49Oi3omkKiekaAuPzq8GhmcEC1sMTxQN5ydRqJhZX1b/7k7eY/cOR543YqYzbEW6NbLod5g8N6Bc2QyhuO4mgsd/vp4OuohMno7G+CqqAXDb5EM8474QdWyRt4mpVhi3fGZqqld8tpfwxxI8cuNAYhdHCBE7VPxuvqC9vvhgNZXBlNQ76F4UrKFSefWnvQ+PKzEL53XnEEB7rSrkCly61OtEPQOockrObGb0QkQsOe6cq108YjyqAAMrHC4BdB2wwuPH14Zlw8jo0knWzylRweS3GvpEYJ2mvjHYJ467zz5SHHBA9b19TSA==
X-YMail-OSG: bfQrwsIVM1kK_syUY_fanW8TIMKnN2fofWLCXIu8u.v0U59qHUOID3hzJMOEuXM
 WUESOch4PYtYZ9OJCdA1xffmw0dud17OESvdKVqIWwjnuFkBGK4WduQbF7KtZXtN.vAG1dnPD849
 _Yd0NWiiSDxOlK0BJ7h4mUm0KhEae__ZoemFMnjKYQPnIWX3P2u7jOtUrGzAwT5j6ueDxL_1G0us
 sBTw9S5w6FXtwMRUcEkG.0Op1LjQJcK_xiipEo6NO1YpeEiBd7NiDRkAl4aILGILin3qIMfDoQa9
 qN1nTuETjno7Axao007VtWRJFRRf5oG7LnlbmTHn.CFpO4hcW82GJrBHTJoKVc09lZLFG97cStDw
 EouAe.ly8hXwWXRd1UbzVxlzstvC3WnQssj1HII7tg6SAw_kcAq6k70t_CzzBHtndrVrigLhtlUq
 VGFVfyE7qOLiSV3X1Cn0ZRIb01dyNHImtf6gnif4DZtEFnhW0fF68lYHymTkCy1jGgiS7x9clA89
 eecYwz4Gbedn4qOLnrcH.wZwqK.9_N9o3NwS.mp1ke4m4oLOzTs5BG1xltlR0WBOPqlV4TgFe7q3
 wspn01Jp2otX31AR2Rj.8NufavbWohiYRuRDRwM1osKq1bK.ozEPUMzsgYJNTFQtXmlDi7TowZgY
 VnOfZ5WggSvn1nZStZyam.BqHO6BOxasy7CqK9P3NoRltaacKjgJXf9JKHdCr_HLUpKNLficbXNV
 vmTEDyDn4W0HNzUHpvhkYOmJloxi31FNIFF1ZLJkDxt3uSIWlcm34Pqmdm0Ht82FMtuYvIXDMJ9I
 OFDVWdt.TBap70IjE4s0zZ9xAa8hLLOh8zeE7oXS6M7V2_n4C0JwuChPzXKmku6gijrKcnylNTta
 0IftPZ1Fyr_Shpb1edEXTvFWcF76xRK73Wk5rU0bHPRtulMbz_5XvTCB3k3r1obZHVhA8rh0.jPc
 idgbcaJNzP2t5e6mtB6Ighfj0QppLIRU5sk8XrI2AlA3XoQux2P4xeen8stRzYTERztElMhsVZP6
 51YuAk6xOf7dpQ.RWzir.hkpfrv0RTtrReqOG1L5ITASoe3OwTgSqX7Z2KpGn1n3Rd.2_1ZH7VtW
 .ibJR3yfYZpSH5KPSTeQ4yn6VM9SQOvbf6CVMJ7sttQ98aRYuWz.gze55sfplISifyH_LjqUPuw7
 AaGhTkQDxRQRx93DBVEO8EI1VZkx6C0PcwlMaX6K_kfX4f6nBirrIHtCOMH6ogWPylDKMIFCT44Q
 7TZCY9CU_OmV2xUWDZXeMelUQNWeqt9KgBtVcY3uJlPeD6TPV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:19:12 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6dfb1cc58eca6b211ba8deba6fd0269d;
          Fri, 31 May 2019 23:19:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 47/58] LSM: Use lsm_context in security_release_secctx
Date:   Fri, 31 May 2019 16:10:09 -0700
Message-Id: <20190531231020.628-48-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_release_secctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                | 21 +++++++--------
 fs/kernfs/dir.c                         |  9 ++++---
 fs/kernfs/inode.c                       |  2 +-
 fs/nfs/nfs4proc.c                       |  9 +++++--
 fs/nfsd/nfs4xdr.c                       |  2 +-
 include/linux/security.h                |  4 +--
 include/net/scm.h                       | 10 +++----
 kernel/audit.c                          | 27 +++++++++----------
 kernel/auditsc.c                        | 27 +++++++++----------
 net/ipv4/ip_sockglue.c                  |  9 +++----
 net/netfilter/nf_conntrack_netlink.c    | 10 +++----
 net/netfilter/nf_conntrack_standalone.c |  9 +++----
 net/netfilter/nfnetlink_queue.c         | 28 ++++++++++---------
 net/netlabel/netlabel_unlabeled.c       | 36 ++++++++++++-------------
 net/netlabel/netlabel_user.c            | 11 ++++----
 security/security.c                     | 10 +++----
 16 files changed, 109 insertions(+), 115 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 0eeb5b75da5b..c2cfef13257c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2874,8 +2874,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
-	char *secctx = NULL;
-	u32 secctx_sz = 0;
+	struct lsm_context lc = { .len = 0, .context = NULL, };
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
@@ -3122,14 +3121,14 @@ static void binder_transaction(struct binder_proc *proc,
 		struct lsm_export le;
 
 		security_task_getsecid(proc->tsk, &le);
-		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
+		ret = security_secid_to_secctx(&le, &lc.context, &lc.len);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
 			return_error_line = __LINE__;
 			goto err_get_secctx_failed;
 		}
-		extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
+		extra_buffers_size += ALIGN(lc.len, sizeof(u64));
 	}
 
 	trace_binder_transaction(reply, t, target_node);
@@ -3148,18 +3147,18 @@ static void binder_transaction(struct binder_proc *proc,
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
-	if (secctx) {
+	if (lc.context) {
 		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
 				    ALIGN(tr->offsets_size, sizeof(void *)) +
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
-				    ALIGN(secctx_sz, sizeof(u64));
+				    ALIGN(lc.len, sizeof(u64));
 
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		binder_alloc_copy_to_buffer(&target_proc->alloc,
 					    t->buffer, buf_offset,
-					    secctx, secctx_sz);
-		security_release_secctx(secctx, secctx_sz);
-		secctx = NULL;
+					    lc.context, lc.len);
+		security_release_secctx(&lc);
+		lc.context = NULL;
 	}
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
@@ -3479,8 +3478,8 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->transaction = NULL;
 	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
 err_binder_alloc_buf_failed:
-	if (secctx)
-		security_release_secctx(secctx, secctx_sz);
+	if (lc.context)
+		security_release_secctx(&lc);
 err_get_secctx_failed:
 	kfree(tcomplete);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b84d635567d3..11672c075a8b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,9 +532,12 @@ void kernfs_put(struct kernfs_node *kn)
 	kfree_const(kn->name);
 
 	if (kn->iattr) {
-		if (kn->iattr->ia_secdata)
-			security_release_secctx(kn->iattr->ia_secdata,
-						kn->iattr->ia_secdata_len);
+		if (kn->iattr->ia_secdata) {
+			struct lsm_context lc;	/* Scaffolding -Casey */
+			lc.context = kn->iattr->ia_secdata;
+			lc.len = kn->iattr->ia_secdata_len;
+			security_release_secctx(&lc);
+		}
 		simple_xattrs_free(&kn->iattr->xattrs);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 41c5afc698fc..45781f0da80f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -370,7 +370,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	mutex_unlock(&kernfs_mutex);
 
 	if (lc.context)
-		security_release_secctx(lc.context, lc.len);
+		security_release_secctx(&lc);
 	return error;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index de000649f9f3..8dee01eda643 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -134,8 +134,13 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	if (label)
-		security_release_secctx(label->label, label->len);
+	struct lsm_context lc;	/* Scaffolding -Casey */
+
+	if (label) {
+		lc.context = label->label;
+		lc.len = label->len;
+		security_release_secctx(&lc);
+	}
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1bf34730d054..3d1251bd588f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2918,7 +2918,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (lc.context)
-		security_release_secctx(lc.context, lc.len);
+		security_release_secctx(&lc);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 3f757b2d8275..57ce9b824eef 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -433,7 +433,7 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
-void security_release_secctx(char *secdata, u32 seclen);
+void security_release_secctx(struct lsm_context *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
@@ -1222,7 +1222,7 @@ static inline int security_secctx_to_secid(struct lsm_context *cp,
 	return -EOPNOTSUPP;
 }
 
-static inline void security_release_secctx(char *secdata, u32 seclen)
+static inline void security_release_secctx(struct lsm_context *cp);
 {
 }
 
diff --git a/include/net/scm.h b/include/net/scm.h
index b5d1c24318e3..7e242ebdd258 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -92,16 +92,16 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 #ifdef CONFIG_SECURITY_NETWORK
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 {
-	char *secdata;
-	u32 seclen;
+	struct lsm_context lc;
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(&scm->le, &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->le, &lc.context, &lc.len);
 
 		if (!err) {
-			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
-			security_release_secctx(secdata, seclen);
+			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
+				 lc.len, lc.context);
+			security_release_secctx(&lc);
 		}
 	}
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index d83d1f05c95d..269c76fefe40 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1191,8 +1191,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
 	struct audit_sig_info   *sig_data;
-	char			*ctx = NULL;
-	u32			len;
+	struct lsm_context	lc = { .context = NULL, .len = 0, };
 
 	err = audit_netlink_ok(skb, msg_type);
 	if (err)
@@ -1428,27 +1427,26 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		break;
 	}
 	case AUDIT_SIGNAL_INFO:
-		len = 0;
 		if (lsm_export_any(&audit_sig_lsm)) {
-			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
-						       &len);
+			err = security_secid_to_secctx(&audit_sig_lsm,
+						       &lc.context, &lc.len);
 			if (err)
 				return err;
 		}
-		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
+		sig_data = kmalloc(sizeof(*sig_data) + lc.len, GFP_KERNEL);
 		if (!sig_data) {
 			if (lsm_export_any(&audit_sig_lsm))
-				security_release_secctx(ctx, len);
+				security_release_secctx(&lc);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
 		if (lsm_export_any(&audit_sig_lsm)) {
-			memcpy(sig_data->ctx, ctx, len);
-			security_release_secctx(ctx, len);
+			memcpy(sig_data->ctx, lc.context, lc.len);
+			security_release_secctx(&lc);
 		}
 		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
-				 sig_data, sizeof(*sig_data) + len);
+				 sig_data, sizeof(*sig_data) + lc.len);
 		kfree(sig_data);
 		break;
 	case AUDIT_TTY_GET: {
@@ -2070,24 +2068,23 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
-	char *ctx = NULL;
-	unsigned len;
 	int error;
 	struct lsm_export le;
+	struct lsm_context lc = { .context = NULL, };
 
 	security_task_getsecid(current, &le);
 	if (!lsm_export_any(&le))
 		return 0;
 
-	error = security_secid_to_secctx(&le, &ctx, &len);
+	error = security_secid_to_secctx(&le, &lc.context, &lc.len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
 		return 0;
 	}
 
-	audit_log_format(ab, " subj=%s", ctx);
-	security_release_secctx(ctx, len);
+	audit_log_format(ab, " subj=%s", lc.context);
+	security_release_secctx(&lc);
 	return 0;
 
 error_path:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d64775f4bb1b..4dab81c7aca0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -938,9 +938,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 unsigned int sessionid,
 				 struct lsm_export *l, char *comm)
 {
+	struct lsm_context lc = { .context = NULL, };
 	struct audit_buffer *ab;
-	char *ctx = NULL;
-	u32 len;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -951,12 +950,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsm_export_any(l)) {
-		if (security_secid_to_secctx(l, &ctx, &len)) {
+		if (security_secid_to_secctx(l, &lc.context, &lc.len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			security_release_secctx(ctx, len);
+			audit_log_format(ab, " obj=%s", lc.context);
+			security_release_secctx(&lc);
 		}
 	}
 	audit_log_format(ab, " ocomm=");
@@ -1191,14 +1190,13 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (lsm_export_any(l)) {
-			char *ctx = NULL;
-			u32 len;
-			if (security_secid_to_secctx(l, &ctx, &len)) {
+			struct lsm_context lc = { .context = NULL, };
+			if (security_secid_to_secctx(l, &lc.context, &lc.len)) {
 				audit_log_format(ab, " osid=(unknown)");
 				*call_panic = 1;
 			} else {
-				audit_log_format(ab, " obj=%s", ctx);
-				security_release_secctx(ctx, len);
+				audit_log_format(ab, " obj=%s", lc.context);
+				security_release_secctx(&lc);
 			}
 		}
 		if (context->ipc.has_perm) {
@@ -1342,16 +1340,15 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
 	if (lsm_export_any(&n->olsm)) {
-		char *ctx = NULL;
-		u32 len;
+		struct lsm_context lc;
 
-		if (security_secid_to_secctx(&n->olsm, &ctx, &len)) {
+		if (security_secid_to_secctx(&n->olsm, &lc.context, &lc.len)) {
 			audit_log_format(ab, " osid=(unknown)");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			security_release_secctx(ctx, len);
+			audit_log_format(ab, " obj=%s", lc.context);
+			security_release_secctx(&lc);
 		}
 	}
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a4f37ba6dbe2..18a7fab8b2d3 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -131,20 +131,19 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
 	struct lsm_export le;
-	char *secdata;
-	u32 seclen;
+	struct lsm_context lc;
 	int err;
 
 	err = security_socket_getpeersec_dgram(NULL, skb, &le);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(&le, &secdata, &seclen);
+	err = security_secid_to_secctx(&le, &lc.context, &lc.len);
 	if (err)
 		return;
 
-	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
-	security_release_secctx(secdata, seclen);
+	put_cmsg(msg, SOL_IP, SCM_SECURITY, lc.len, lc.context);
+	security_release_secctx(&lc);
 }
 
 static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d10cc1924e46..49bce1b085ce 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -328,16 +328,16 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct)
 static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 {
 	struct nlattr *nest_secctx;
-	int len, ret;
-	char *secctx;
+	int ret;
 	struct lsm_export le;
+	struct lsm_context lc;
 
 	lsm_export_init(&le);
 	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
 	le.selinux = ct->secmark;
 	le.smack = ct->secmark;
 
-	ret = security_secid_to_secctx(&le, &secctx, &len);
+	ret = security_secid_to_secctx(&le, &lc.context, &lc.len);
 	if (ret)
 		return 0;
 
@@ -346,13 +346,13 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	if (!nest_secctx)
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
+	if (nla_put_string(skb, CTA_SECCTX_NAME, lc.context))
 		goto nla_put_failure;
 	nla_nest_end(skb, nest_secctx);
 
 	ret = 0;
 nla_put_failure:
-	security_release_secctx(secctx, len);
+	security_release_secctx(&lc);
 	return ret;
 }
 #else
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index d353f3efc5a5..97d16a51504b 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -173,9 +173,8 @@ static void ct_seq_stop(struct seq_file *s, void *v)
 static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 {
 	int ret;
-	u32 len;
-	char *secctx;
 	struct lsm_export le;
+	struct lsm_context lc;
 
 	/* Whichever LSM may be using the secmark */
 	lsm_export_init(&le);
@@ -183,13 +182,13 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	le.selinux = ct->secmark;
 	le.smack = ct->secmark;
 
-	ret = security_secid_to_secctx(&le, &secctx, &len);
+	ret = security_secid_to_secctx(&le, &lc.context, &lc.len);
 	if (ret)
 		return;
 
-	seq_printf(s, "secctx=%s ", secctx);
+	seq_printf(s, "secctx=%s ", lc.context);
 
-	security_release_secctx(secctx, len);
+	security_release_secctx(&lc);
 }
 #else
 static inline void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a0670137477b..b70871693368 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -307,9 +307,9 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 
 static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
-	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsm_export le;
+	struct lsm_context lc = { .context = NULL, .len = 0, };
 
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
@@ -322,12 +322,15 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 		le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
 		le.selinux = skb->secmark;
 		le.smack = skb->secmark;
-		security_secid_to_secctx(&le, secdata, &seclen);
+		security_secid_to_secctx(&le, &lc.context, &lc.len);
+		*secdata = lc.context;
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
+	return lc.len;
+#else
+	return 0;
 #endif
-	return seclen;
 }
 
 static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
@@ -403,8 +406,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	char *secdata = NULL;
-	u32 seclen = 0;
+	struct lsm_context lc = { .context = NULL, };
 
 	size =    nlmsg_total_size(sizeof(struct nfgenmsg))
 		+ nla_total_size(sizeof(struct nfqnl_msg_packet_hdr))
@@ -470,9 +472,9 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
-		if (seclen)
-			size += nla_total_size(seclen);
+		lc.len = nfqnl_get_sk_secctx(entskb, &lc.context);
+		if (lc.len)
+			size += nla_total_size(lc.len);
 	}
 
 	skb = alloc_skb(size, GFP_ATOMIC);
@@ -605,7 +607,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (lc.len && nla_put(skb, NFQA_SECCTX, lc.len, lc.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -633,8 +635,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen)
-		security_release_secctx(secdata, seclen);
+	if (lc.context)
+		security_release_secctx(&lc);
 	return skb;
 
 nla_put_failure:
@@ -642,8 +644,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen)
-		security_release_secctx(secdata, seclen);
+	if (lc.context)
+		security_release_secctx(&lc);
 	return NULL;
 }
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 707ea5a364b0..4c4a8f6df261 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -387,8 +387,6 @@ int netlbl_unlhsh_add(struct net *net,
 	struct net_device *dev;
 	struct netlbl_unlhsh_iface *iface;
 	struct audit_buffer *audit_buf = NULL;
-	char *secctx = NULL;
-	u32 secctx_len;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -451,9 +449,10 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(l, &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+		struct lsm_context lc;
+		if (security_secid_to_secctx(l, &lc.context, &lc.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
+			security_release_secctx(&lc);
 		}
 		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -484,8 +483,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct netlbl_unlhsh_addr4 *entry;
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
-	char *secctx;
-	u32 secctx_len;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -499,6 +496,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
 					      audit_info);
 	if (audit_buf != NULL) {
+		struct lsm_context lc;
 		dev = dev_get_by_index(net, iface->ifindex);
 		netlbl_af4list_audit_addr(audit_buf, 1,
 					  (dev != NULL ? dev->name : NULL),
@@ -507,9 +505,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->le,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+					     &lc.context, &lc.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
+			security_release_secctx(&lc);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -560,6 +558,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
 					      audit_info);
 	if (audit_buf != NULL) {
+		struct lsm_context lc;
 		dev = dev_get_by_index(net, iface->ifindex);
 		netlbl_af6list_audit_addr(audit_buf, 1,
 					  (dev != NULL ? dev->name : NULL),
@@ -568,9 +567,9 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 			dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(&entry->le,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			security_release_secctx(secctx, secctx_len);
+					     &lc.context, &lc.len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
+			security_release_secctx(&lc);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
 		audit_log_end(audit_buf);
@@ -1082,9 +1081,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
 	struct net_device *dev;
 	void *data;
-	char *secctx;
-	u32 secctx_len;
 	struct lsm_export *lep;
+	struct lsm_context lc;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1139,14 +1137,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lep = (struct lsm_export *)&addr6->le;
 	}
 
-	ret_val = security_secid_to_secctx(lep, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(lep, &lc.context, &lc.len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
 			  NLBL_UNLABEL_A_SECCTX,
-			  secctx_len,
-			  secctx);
-	security_release_secctx(secctx, secctx_len);
+			  lc.len,
+			  lc.context);
+	security_release_secctx(&lc);
 	if (ret_val != 0)
 		goto list_cb_failure;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 2cc96305c841..0418f0935199 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,8 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	char *secctx;
-	u32 secctx_len;
+	struct lsm_context lc;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -113,10 +112,10 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsm_export_any(&audit_info->le) &&
-	    security_secid_to_secctx(&audit_info->le, &secctx,
-				     &secctx_len) == 0) {
-		audit_log_format(audit_buf, " subj=%s", secctx);
-		security_release_secctx(secctx, secctx_len);
+	    security_secid_to_secctx(&audit_info->le, &lc.context,
+				     &lc.len) == 0) {
+		audit_log_format(audit_buf, " subj=%s", lc.context);
+		security_release_secctx(&lc);
 	}
 
 	return audit_buf;
diff --git a/security/security.c b/security/security.c
index 029d2f4fe48c..3da7302d20ec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1981,7 +1981,7 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	if (secdata)
 		*secdata = lc.context;
 	else
-		security_release_secctx(lc.context, lc.len);
+		security_release_secctx(&lc);
 	*seclen = lc.len;
 	return rc;
 }
@@ -1994,13 +1994,9 @@ int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-void security_release_secctx(char *secdata, u32 seclen)
+void security_release_secctx(struct lsm_context *cp)
 {
-	struct lsm_context lc;
-
-	lc.context = secdata;
-	lc.len = seclen;
-	call_one_void_hook(release_secctx, &lc);
+	call_one_void_hook(release_secctx, cp);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
-- 
2.19.1

