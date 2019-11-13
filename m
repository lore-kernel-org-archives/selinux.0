Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80433C43141
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBBC206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Wx1pHQ7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfKMR6z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:55 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:33739
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbfKMR6y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667929; bh=Nyxc1lgsHb7MsiF6cKwXf4WJaIu2jc4nFSf8dAtzPuM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Wx1pHQ7jo/rhR6LQ5Ptg8fScYgK6mRgXPPwiDaZJmI8+F3zgU2lFD3NOHTQwtjIZxpkr9M6P4gUnnpoEpuQGdhSQ9ylGOe5ev4MSVzBqlrtIiOx2U/M/Ec41QqXbkGL7awy5SqJ5nazpXRa7Ps8YUYV3jzCouSabbI7Z3HmZ9FDAGaKKsReueheHM1ohKUOzx0H2XE7oZos1yFCwfcbkRO/2C4QznNQAdJRveOQ3gUjIE51ZuJrgxtmSsDEk8tdKWRuvIe4CRG8i0pu7wV7af0taAiL2EGfLx0Em4BJCkGf5prc2L+ReRdmpN6vfy/3L21tCG6nnf8ilrPJpA6byMQ==
X-YMail-OSG: _3y.bbUVM1nwoTP8dtKNuriqIKBVLOA_zP1NBrgwtGwjY5.WTZjaRjIwmWHu0t7
 OmLRr5sR_ZLL8NNonFdnI.GNxse5VDYcLmF5s468KhVyjAZqocgAY.OkgHW1Z8_Cza0cK.T2npCf
 ZWd5GcUko8vRLpvAXCJVtcIxM3Ihf5dER8KEyuC.ie539HIv0l9fAQI_6HDIZBWeViRVu8G51Zb2
 cytaF8fIU5orEfuOXe92poEyC19rHrwtJfYCsVYvwpbV0ynoOD3xcFzkeZ_Bm9t4alymFvi8thvy
 1DfoGX9QfXfzMPgE6mgcik9Llrf7Suzmdb4_vzNWcmu57PF.n3bFzBR3fxUVzKytW9ILW3cL.400
 G7pZCkfxGc3wRqzUC3NCO5ZSq_EDSGFTnlA.nVBWBF.Kp6EPmasS1P4KyXbuHVDXSLD0m0.GbiYt
 GLmeBJvXDrsu.cyvF4BkeT7.HkmQHUk_ujJJqvey.kCdybzrtu5Nrs6FVpll9VaGgG8YB37JaixI
 jlAO8faKkQe2aVZ0uKnQIqexu0v389y.r48PY9IS2NkwrRbvPu0.FNW.vIFRtzhiMf2qbpOF0Pfc
 bu5O_L7FsKhHPl4cI3sNYvITd2sNRJVAq.LQnTgisAJdkd.DGqW4nCOepOUT88HGJ6FPVPBb7X2I
 NWDa3iRLSeE791KphfPWh85_PeATnW47xijdn945EbsFi0Co51I9zZdyJnQKenAa6p2w3IhBleX4
 wdZdO7xk35qcPoCvnkL3h7yr7DZsYmERicgkJJSa6h_Buv6O_UbFD5Rc.ncbG0fKQSUk4Qi4EVK6
 x9vqxqInCRQ.Vu5OIebSvY54Ss8XjEFdZpBZ80MEpIleFMiYe.L2f8YdoTc8iW6gcrVIcSTaZh3t
 ic2UAwYPHLEy8O0khcIUJ3FHS1DUSfJSOmhEzkuPrIUeq6FYexOvQoeAUGXqDM5K93fxd65I5Yt_
 WXkDVzZsMAd5XMJ3F3xXlKMZ.N8HCiNPt5gv34O_lXsSfEo_no2c7y9wYz1Jr2rOSuuZGEdIwbEw
 wWg0S2OdRODWoUD3EW7BGhWbparXzqCRu2LJLbkoFrIhfNieehN.2GMbiyzARUS7IZW.cQUSdvrM
 _PYqz4U78rv.F7hUrqRPptfDfzgyXa3bwYEMuIBZGdsltklp95oxcLTOUj5UXJMNLxWrgXNp7qrd
 T3grZzbWGz08rfiAAIHcK2nhBmogaAJ9w.nD9tNfSveulpALIhxdcgMamf5Z.6NReJmdap9uOpbR
 R7bftyR4TXrDqOjJMhDLK9Lx7om4MvT.iFmSThODrdJiLDBQXv0FfwARoaFctFon.9NzIbYasQx8
 2mPuIyvtezOkDBy9hqB8e.4RUpsVKDwLEHqtB1OwtRiBiikKv4ELtKxx614q9GRH6eUcfbrZsWbg
 QCg.CR.PT5QDUsmxm88j1xbYPSPO_RFOWJIJLfQiAN7lBUNx5ikh2fzA7yi15ivnoaCk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:49 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1cea930ac777c9304573db67db0c3ad6;
          Wed, 13 Nov 2019 17:58:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 15/25] LSM: Use lsmcontext in security_secid_to_secctx
Date:   Wed, 13 Nov 2019 09:57:11 -0800
Message-Id: <20191113175721.2317-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the (secctx,seclen) pointer pair with a single
lsmcontext pointer to allow return of the LSM identifier
along with the context and context length. This allows
security_release_secctx() to know how to release the
context. Callers have been modified to use or save the
returned data from the new structure.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 drivers/android/binder.c                | 26 +++++++---------
 include/linux/security.h                |  4 +--
 include/net/scm.h                       | 10 ++-----
 kernel/audit.c                          | 29 +++++++-----------
 kernel/auditsc.c                        | 31 +++++++------------
 net/ipv4/ip_sockglue.c                  |  7 ++---
 net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
 net/netfilter/nf_conntrack_standalone.c |  7 ++---
 net/netfilter/nfnetlink_queue.c         |  5 +++-
 net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
 net/netlabel/netlabel_user.c            |  7 ++---
 security/security.c                     | 10 +++++--
 12 files changed, 74 insertions(+), 116 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49b84b6fafd9..cc81d0f540fd 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2863,9 +2863,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
-	char *secctx = NULL;
-	u32 secctx_sz = 0;
-	struct lsmcontext scaff; /* scaffolding */
+	struct lsmcontext lsmctx = { };
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
@@ -3113,14 +3111,14 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_task_getsecid(proc->tsk, &blob);
-		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
+		ret = security_secid_to_secctx(&blob, &lsmctx);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
 			return_error_line = __LINE__;
 			goto err_get_secctx_failed;
 		}
-		added_size = ALIGN(secctx_sz, sizeof(u64));
+		added_size = ALIGN(lsmctx.len, sizeof(u64));
 		extra_buffers_size += added_size;
 		if (extra_buffers_size < added_size) {
 			/* integer overflow of extra_buffers_size */
@@ -3147,24 +3145,22 @@ static void binder_transaction(struct binder_proc *proc,
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
-	if (secctx) {
+	if (lsmctx.context) {
 		int err;
 		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
 				    ALIGN(tr->offsets_size, sizeof(void *)) +
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
-				    ALIGN(secctx_sz, sizeof(u64));
+				    ALIGN(lsmctx.len, sizeof(u64));
 
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
-						  secctx, secctx_sz);
+						  lsmctx.context, lsmctx.len);
 		if (err) {
 			t->security_ctx = 0;
 			WARN_ON(1);
 		}
-		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
-		security_release_secctx(&scaff);
-		secctx = NULL;
+		security_release_secctx(&lsmctx);
 	}
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
@@ -3220,7 +3216,7 @@ static void binder_transaction(struct binder_proc *proc,
 	off_end_offset = off_start_offset + tr->offsets_size;
 	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
 	sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
-		ALIGN(secctx_sz, sizeof(u64));
+		ALIGN(lsmctx.len, sizeof(u64));
 	off_min = 0;
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
@@ -3496,10 +3492,8 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
 err_binder_alloc_buf_failed:
 err_bad_extra_size:
-	if (secctx) {
-		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
-		security_release_secctx(&scaff);
-	}
+	if (lsmctx.context)
+		security_release_secctx(&lsmctx);
 err_get_secctx_failed:
 	kfree(tcomplete);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9bb11d9f1348..e47cef3d62f0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -528,7 +528,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1333,7 +1333,7 @@ static inline int security_ismaclabel(const char *name)
 }
 
 static inline int security_secid_to_secctx(struct lsmblob *blob,
-					   char **secdata, u32 *seclen)
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 30ba801c91bd..4a6ad8caf423 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -93,18 +93,14 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 {
 	struct lsmcontext context;
-	char *secdata;
-	u32 seclen;
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
-					       &seclen);
+		err = security_secid_to_secctx(&scm->lsmblob, &context);
 
 		if (!err) {
-			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
-			/*scaffolding*/
-			lsmcontext_init(&context, secdata, seclen, 0);
+			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
+				 context.len, context.context);
 			security_release_secctx(&context);
 		}
 	}
diff --git a/kernel/audit.c b/kernel/audit.c
index 35970e7191b6..cd0024c89807 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1178,9 +1178,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
 	struct audit_sig_info   *sig_data;
-	char			*ctx = NULL;
 	u32			len;
-	struct lsmcontext	scaff; /* scaffolding */
+	struct lsmcontext	context = { };
 
 	err = audit_netlink_ok(skb, msg_type);
 	if (err)
@@ -1418,25 +1417,22 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
-			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
-						       &len);
+			err = security_secid_to_secctx(&audit_sig_lsm,
+						       &context);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			if (lsmblob_is_set(&audit_sig_lsm)) {
-				lsmcontext_init(&scaff, ctx, len, 0);
-				security_release_secctx(&scaff);
-			}
+			if (lsmblob_is_set(&audit_sig_lsm))
+				security_release_secctx(&context);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
-			memcpy(sig_data->ctx, ctx, len);
-			lsmcontext_init(&scaff, ctx, len, 0);
-			security_release_secctx(&scaff);
+			memcpy(sig_data->ctx, context.context, context.len);
+			security_release_secctx(&context);
 		}
 		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
 				 sig_data, sizeof(*sig_data) + len);
@@ -2061,26 +2057,23 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
-	char *ctx = NULL;
-	unsigned len;
 	int error;
 	struct lsmblob blob;
-	struct lsmcontext scaff; /* scaffolding */
+	struct lsmcontext context;
 
 	security_task_getsecid(current, &blob);
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &ctx, &len);
+	error = security_secid_to_secctx(&blob, &context);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
 		return 0;
 	}
 
-	audit_log_format(ab, " subj=%s", ctx);
-	lsmcontext_init(&scaff, ctx, len, 0);
-	security_release_secctx(&scaff);
+	audit_log_format(ab, " subj=%s", context.context);
+	security_release_secctx(&context);
 	return 0;
 
 error_path:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8790e7aafa7d..6d273183dd87 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -962,9 +962,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmcxt;
-	char *ctx = NULL;
-	u32 len;
+	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -975,13 +973,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &ctx, &len)) {
+		if (security_secid_to_secctx(blob, &lsmctx)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			lsmcontext_init(&lsmcxt, ctx, len, 0); /*scaffolding*/
-			security_release_secctx(&lsmcxt);
+			audit_log_format(ab, " obj=%s", lsmctx.context);
+			security_release_secctx(&lsmctx);
 		}
 	}
 	audit_log_format(ab, " ocomm=");
@@ -1194,7 +1191,6 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
 
 static void show_special(struct audit_context *context, int *call_panic)
 {
-	struct lsmcontext lsmcxt;
 	struct audit_buffer *ab;
 	int i;
 
@@ -1218,17 +1214,15 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (osid) {
-			char *ctx = NULL;
-			u32 len;
+			struct lsmcontext lsmcxt;
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &ctx, &len)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
-				audit_log_format(ab, " obj=%s", ctx);
-				lsmcontext_init(&lsmcxt, ctx, len, 0);
+				audit_log_format(ab, " obj=%s", lsmcxt.context);
 				security_release_secctx(&lsmcxt);
 			}
 		}
@@ -1372,20 +1366,17 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
 	if (n->osid != 0) {
-		char *ctx = NULL;
-		u32 len;
 		struct lsmblob blob;
-		struct lsmcontext lsmcxt;
+		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &ctx, &len)) {
+		if (security_secid_to_secctx(&blob, &lsmctx)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
 		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			lsmcontext_init(&lsmcxt, ctx, len, 0); /* scaffolding */
-			security_release_secctx(&lsmcxt);
+			audit_log_format(ab, " obj=%s", lsmctx.context);
+			security_release_secctx(&lsmctx);
 		}
 	}
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 96d56a30ecca..27af7a6b8780 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -132,20 +132,17 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
 	struct lsmcontext context;
 	struct lsmblob lb;
-	char *secdata;
-	u32 seclen;
 	int err;
 
 	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(&lb, &secdata, &seclen);
+	err = security_secid_to_secctx(&lb, &context);
 	if (err)
 		return;
 
-	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
-	lsmcontext_init(&context, secdata, seclen, 0); /* scaffolding */
+	put_cmsg(msg, SOL_IP, SCM_SECURITY, context.len, context.context);
 	security_release_secctx(&context);
 }
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 78791e015d8b..7c8a7edac36d 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -329,13 +329,12 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct)
 static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 {
 	struct nlattr *nest_secctx;
-	int len, ret;
-	char *secctx;
+	int ret;
 	struct lsmblob blob;
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &secctx, &len);
+	ret = security_secid_to_secctx(&blob, &context);
 	if (ret)
 		return 0;
 
@@ -344,13 +343,12 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	if (!nest_secctx)
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
+	if (nla_put_string(skb, CTA_SECCTX_NAME, context.context))
 		goto nla_put_failure;
 	nla_nest_end(skb, nest_secctx);
 
 	ret = 0;
 nla_put_failure:
-	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
 	security_release_secctx(&context);
 	return ret;
 }
@@ -626,12 +624,16 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
 	struct lsmblob blob;
+	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, NULL, &len);
+	ret = security_secid_to_secctx(&blob, &context);
 	if (ret)
 		return 0;
 
+	len = context.len;
+	security_release_secctx(&context);
+
 	return nla_total_size(0) /* CTA_SECCTX */
 	       + nla_total_size(sizeof(char) * len); /* CTA_SECCTX_NAME */
 #else
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 8601fcb99f7a..8969754d7fe9 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -173,19 +173,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
 static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 {
 	int ret;
-	u32 len;
-	char *secctx;
 	struct lsmblob blob;
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &secctx, &len);
+	ret = security_secid_to_secctx(&blob, &context);
 	if (ret)
 		return;
 
-	seq_printf(s, "secctx=%s ", secctx);
+	seq_printf(s, "secctx=%s ", context.context);
 
-	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
 	security_release_secctx(&context);
 }
 #else
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index cc3ef03ee198..2d6668fd026c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -306,6 +306,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsmblob blob;
+	struct lsmcontext context = { };
 
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
@@ -314,10 +315,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 
 	if (skb->secmark) {
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, secdata, &seclen);
+		security_secid_to_secctx(&blob, &context);
+		*secdata = context.context;
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
+	seclen = context.len;
 #endif
 	return seclen;
 }
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 288c005b44c7..c03fe9a4f7b9 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -374,8 +374,6 @@ int netlbl_unlhsh_add(struct net *net,
 	struct netlbl_unlhsh_iface *iface;
 	struct audit_buffer *audit_buf = NULL;
 	struct lsmcontext context;
-	char *secctx = NULL;
-	u32 secctx_len;
 	struct lsmblob blob;
 
 	if (addr_len != sizeof(struct in_addr) &&
@@ -440,12 +438,9 @@ int netlbl_unlhsh_add(struct net *net,
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
 		lsmblob_init(&blob, secid);
-		if (security_secid_to_secctx(&blob,
-					     &secctx,
-					     &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			/* scaffolding */
-			lsmcontext_init(&context, secctx, secctx_len, 0);
+		if (security_secid_to_secctx(&blob, &context) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s",
+					 context.context);
 			security_release_secctx(&context);
 		}
 		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
@@ -478,8 +473,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
 	struct lsmcontext context;
-	char *secctx;
-	u32 secctx_len;
 	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
@@ -503,11 +496,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		if (entry != NULL)
 			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&blob,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			/* scaffolding */
-			lsmcontext_init(&context, secctx, secctx_len, 0);
+		    security_secid_to_secctx(&blob, &context) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s",
+					 context.context);
 			security_release_secctx(&context);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
@@ -546,8 +537,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
 	struct lsmcontext context;
-	char *secctx;
-	u32 secctx_len;
 	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
@@ -570,10 +559,9 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		if (entry != NULL)
 			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&blob,
-					     &secctx, &secctx_len) == 0) {
-			audit_log_format(audit_buf, " sec_obj=%s", secctx);
-			lsmcontext_init(&context, secctx, secctx_len, 0);
+		    security_secid_to_secctx(&blob, &context) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s",
+					 context.context);
 			security_release_secctx(&context);
 		}
 		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
@@ -1091,8 +1079,6 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	struct lsmcontext context;
 	void *data;
 	u32 secid;
-	char *secctx;
-	u32 secctx_len;
 	struct lsmblob blob;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
@@ -1149,15 +1135,13 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	}
 
 	lsmblob_init(&blob, secid);
-	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(&blob, &context);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
 			  NLBL_UNLABEL_A_SECCTX,
-			  secctx_len,
-			  secctx);
-	/* scaffolding */
-	lsmcontext_init(&context, secctx, secctx_len, 0);
+			  context.len,
+			  context.context);
 	security_release_secctx(&context);
 	if (ret_val != 0)
 		goto list_cb_failure;
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index ef139d8ae7cd..951ba0639d20 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -85,8 +85,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 {
 	struct audit_buffer *audit_buf;
 	struct lsmcontext context;
-	char *secctx;
-	u32 secctx_len;
 	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
@@ -102,9 +100,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
-		audit_log_format(audit_buf, " subj=%s", secctx);
-		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
+	    security_secid_to_secctx(&blob, &context) == 0) {
+		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
 
diff --git a/security/security.c b/security/security.c
index c05ef9d0c8ed..618d4f90936b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2109,18 +2109,22 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 {
 	struct security_hook_list *hp;
 	int display = lsm_task_display(current);
 
+	memset(cp, 0, sizeof(*cp));
+
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
+			cp->slot = hp->lsmid->slot;
 			return hp->hook.secid_to_secctx(
 					blob->secid[hp->lsmid->slot],
-					secdata, seclen);
+					&cp->context, &cp->len);
+		}
 	}
 	return 0;
 }
-- 
2.20.1

