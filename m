Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6D9C2D0BF
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28BE21D7D
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WUXDfJV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLPWZE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:25:04 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36648
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfLPWZE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535101; bh=0zDCsRUbBXNMnzR7q25z+S52L6EOybyFN1coPBY1oEY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WUXDfJV/3yW6A/re9TONY3e4qFLPaAr4A2Yc0ly0h6lQszVtruFXuEtMbk0igp+lB2NmySUZyf1XDR9ZDRNtjlVxm7P8ItjmdGdEtOmt8tJZ77Jkegpejs4ABnDzGWJ+IMVAe0NJKhxITCwvOoxEXdxKp9LZAwzc/U4Q761eVlZ5nfRjXTuV7XzQiV5qYgEzgtkwD66iteYRjiRALdJmPPP6QL4y50Yf6b9X1eW05dfU4J6cXAKWPW1l4X6woY/EFcSZFVGa03zD+JUEIKP+IJwj6dqZ+BQDTpLRWe9PsH9rI/ZO+Ly/6NiTikdr3rHixJAioS9rsYBBhSGLCaq8bg==
X-YMail-OSG: _JgTOMEVM1mDng6tpLI7m7B1RhXo.fjAsH4QU_kH0EF3gTSDzqemADBv4NqvVXo
 qDqAg1nnwN_FVW5eSPyeqZURKbOp5usM6w0d_2JIdF.1Pve2DMyw8L4Z0CKwFhDurKwiFeuIzCkr
 BtUlQc4dhNSyN4ptk1b5e8PimUu_3o26DQheizh2ixcOWRZtRJkr8oC81.xV3XfswzTlZk.r8jEK
 CFEPcgzDvfWHHsHG2v_ezrh4bWYy67lLV.uINB0.20hYQ6pCzfEatF8GAJhStFq.cP7KuGoBXYxs
 KwkNghQ0XA9fSGDQOnx4nCiZ6rntPkKM.CSRAsOxs_g1fOwfj1xSiflQVKOg_shLzEs28V.TKeO2
 HR5yGPps6u71E.TypNF9HIkkhmKbyAmhqLWBpCSUHN2tJFw.pNNDf5jTl_8mv6KPqysKJRJl9I1t
 Ynojj0ezFpee8U4woYiZVXjNzMPHciesigww9M7NmO7BiuiDhzYPOoI25YMYFOUWG1oKXZfrknmY
 2VruCfxM4005OI6PZ5A0I2U6sNtgdnnc2_X4pS5tIWBssY7uwuyY7T_1J01LM5Hi0n9I_v4DI87b
 BWAvK1QC8fqs0rQnG0dV1.bHyOKypLK3Z2hnZfBy0766TINfc2rwCXGMhp8SlSqNd0gGuhe98yyx
 3EICloa4RoJH1L4g.3Yv9lH0cJY9KCmfG58hmkZ7F4G3nWCDvdphbJVZFHGQ3wF.c3F0BBhFQpdm
 MeqtNYdFd3Zt4Ldf33C_4zz23vMnS_yPO4IK361glyoLRwvDiSweRxDQnVtot0QvNjLgWbwkUj9t
 x03SuOQjt.i.nlqv1UaBEgYyV5R6BuQJG6_ppmQJJIqC1.kdxyGZsZJil4lOR0Nm6.HbDSi54Oy2
 Ykd2sz9ZSMLLXBiWM.ftVtaSIKVksSWxzq1ygWUKSZ4IHBRFu4z8KlEHu1TwRBMdGoR8GNQZ11DQ
 1Ou1WL3cmaB1rtEgj2sr0Wy7sq0LrLMEu0BCm4i_b0JpwalihAdWU4sJDUJxT66GDMj7qkyZtTVF
 EZLKZxZQhi3ZTnYAg3PeX_wudjxvsXV1dKjS0QY0g31_OshOsaV1yaU3aJo.sovBBbn9pn8omcTu
 U4gewq_DLvkXYi5spiV2lsK05C3vswo9j9o7SS4YFC3lj1dfI_EosZO3eGJbzy4XRnbXpy58NktK
 ZHS7KGI5ADzJPpQ7ugrmZAPTbMP7xvo1Ek81Ijk00R6mULE5s_Hyj_sCUd5RrQEgYikYH9KEC.Yd
 rcn1k9s4q71_UM9dcEBEUveW.Du9WSL5TOkLLSQqAzKJ2HXIr1BTCe_KFtnwuvyUvXPtqqSc3UWx
 sQsQ5YZHpLcs9K_etfihwQr2qxh64lUsWkNQovThWG2jIAO4gx7bsNAKChxlrRuIHjzjq_HkuJ8S
 oortDgbDNO4WAkMnKs6eM5VAgfsaicF30HNqvyMQtFXHAJO2UUfD.P7JP.NOMmA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:01 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1be22e4886451d124518193455ee7ee2;
          Mon, 16 Dec 2019 22:24:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 07/25] LSM: Use lsmblob in security_secid_to_secctx
Date:   Mon, 16 Dec 2019 14:24:13 -0800
Message-Id: <20191216222431.4956-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change security_secid_to_secctx() to take a lsmblob as input
instead of a u32 secid. It will then call the LSM hooks
using the lsmblob element allocated for that module. The
callers have been updated as well. This allows for the
possibility that more than one module may be called upon
to translate a secid to a string, as can occur in the
audit code.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 drivers/android/binder.c                |  4 +++-
 include/linux/security.h                |  5 +++--
 include/net/scm.h                       |  5 ++---
 kernel/audit.c                          |  9 +++++++--
 kernel/auditsc.c                        | 14 ++++++++++----
 net/ipv4/ip_sockglue.c                  |  3 +--
 net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
 net/netfilter/nf_conntrack_standalone.c |  4 +++-
 net/netfilter/nfnetlink_queue.c         |  8 ++++++--
 net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
 net/netlabel/netlabel_user.c            |  6 +++---
 security/security.c                     | 16 +++++++++++++---
 12 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e9bc9fcc7ea5..cd7a5f446457 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3105,10 +3105,12 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
+		struct lsmblob blob;
 		size_t added_size;
 
 		security_task_getsecid(proc->tsk, &secid);
-		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
+		lsmblob_init(&blob, secid);
+		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index 8cae9e4bd760..26b8cee65c64 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -495,7 +495,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
@@ -1296,7 +1296,8 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(struct lsmblob *blob,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index e2e71c4bf9d0..31ae605fcc0a 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -97,9 +97,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		/* Scaffolding - it has to be element 0 for now */
-		err = security_secid_to_secctx(scm->lsmblob.secid[0],
-					       &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
+					       &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/kernel/audit.c b/kernel/audit.c
index 8e09f0f55b4b..e3e515158295 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1417,7 +1417,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+			struct lsmblob blob;
+
+			lsmblob_init(&blob, audit_sig_sid);
+			err = security_secid_to_secctx(&blob, &ctx, &len);
 			if (err)
 				return err;
 		}
@@ -2060,12 +2063,14 @@ int audit_log_task_context(struct audit_buffer *ab)
 	unsigned len;
 	int error;
 	u32 sid;
+	struct lsmblob blob;
 
 	security_task_getsecid(current, &sid);
 	if (!sid)
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	lsmblob_init(&blob, sid);
+	error = security_secid_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7566e5b1c419..04803c3099b2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -966,6 +966,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
+	struct lsmblob blob;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -975,7 +976,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+		lsmblob_init(&blob, sid);
+		if (security_secid_to_secctx(&blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1218,7 +1220,10 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
+			struct lsmblob blob;
+
+			lsmblob_init(&blob, osid);
+			if (security_secid_to_secctx(&blob, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1368,9 +1373,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (n->osid != 0) {
 		char *ctx = NULL;
 		u32 len;
+		struct lsmblob blob;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
+		lsmblob_init(&blob, n->osid);
+		if (security_secid_to_secctx(&blob, &ctx, &len)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6cf57d5ac899..1ca97d0cb4a9 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -139,8 +139,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	/* Scaffolding - it has to be element 0 */
-	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
+	err = security_secid_to_secctx(&lb, &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d8d33ef52ce0..873dbd95f84a 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -331,8 +331,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct nlattr *nest_secctx;
 	int len, ret;
 	char *secctx;
+	struct lsmblob blob;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsmblob_init(&blob, ct->secmark);
+	ret = security_secid_to_secctx(&blob, &secctx, &len);
 	if (ret)
 		return 0;
 
@@ -643,8 +645,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
+	struct lsmblob blob;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	lsmblob_init(&blob, ct->secmark);
+	ret = security_secid_to_secctx(&blob, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 410809c669e1..183a85412155 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	int ret;
 	u32 len;
 	char *secctx;
+	struct lsmblob blob;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsmblob_init(&blob, ct->secmark);
+	ret = security_secid_to_secctx(&blob, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index feabdfb22920..bfa7f12fde99 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -305,13 +305,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+	struct lsmblob blob;
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
-	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+	if (skb->secmark) {
+		lsmblob_init(&blob, skb->secmark);
+		security_secid_to_secctx(&blob, secdata, &seclen);
+	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7a5a87f15736..0cda17cb44a0 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -375,6 +375,7 @@ int netlbl_unlhsh_add(struct net *net,
 	struct audit_buffer *audit_buf = NULL;
 	char *secctx = NULL;
 	u32 secctx_len;
+	struct lsmblob blob;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -437,7 +438,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
+		lsmblob_init(&blob, secid);
+		if (security_secid_to_secctx(&blob,
 					     &secctx,
 					     &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
@@ -474,6 +476,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -493,8 +496,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&blob,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -536,6 +541,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -554,8 +560,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&blob,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -1076,6 +1084,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	u32 secid;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob blob;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1130,7 +1139,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	lsmblob_init(&blob, secid);
+	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..893301ae0131 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -86,6 +86,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -98,10 +99,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
+	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/security/security.c b/security/security.c
index 03ac668c0c10..61571f5c7c5f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1963,10 +1963,20 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
-				seclen);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
+					      secdata, seclen);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.20.1

