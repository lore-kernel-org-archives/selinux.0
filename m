Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F2C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1CE2080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tzyFyIwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfFRXGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:47 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:36536
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730914AbfFRXGq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899190; bh=DwCwQTc7UpQ7hZFmk1YoU7AFVOTyGg2HaqFaRcRqP0A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tzyFyIwdga9bc+TDuQzKlXVKIt5T8BCEUgSMia05JADNXNn87a/+v3eR88hFxOvgEVuO5/UjPTtDXJx0KWC7ScZviY4KNLBQAsaPnQe6uqZnhJY9NkXK2+jzUBGF4q6WKoGJqSlvAIcjaQF5KEtfkmUu4aNgwFz59+mCRN1mVEhGz+p1WsXvu3D0+SeRJjHbwtj1+DOCGIII9MbPGJfR9beW4WShww2k7FE6AYb79NajPy6pM2BfyQJnsZ7mVjua/A2WwXfAAmEcsnnxQQ+lfNoqZAgCb7Qnu+7ZksF4t9LQu3h8sX4LyxZlAEArNwR+VKVqSPKPe+wvkkL477oGMA==
X-YMail-OSG: DJix5A0VM1nAHMs07Mq1PYDIGtbTqz41DOw1_UUTlGgZKH.joE2m9wpKMzVHWfy
 ubdFThdPDec_0_XhxnU3qXDlf_J3.HHjFAsMoyiE9jeNRqVEbWYVK06S6bD0W4FIG3H0Zm4.4VtE
 YMWwbKs.DY94Lks38FYf295_hXUtVQAWt.tE49H7x4UU6mzLXYJKSD2AJ1XqNOhFh9FWRBLw1WVV
 _mLBoSK06O9VD_Mk1.hcUE6rRLmvFFf6hEW6plBgTXin_gWuz9zhO0zcrilbbMn5PlZT2vj7UgrV
 HFznxv2HrdOdTWqAokuUem1pavKjmMDLZzFNDSLPQ9ROHxqx_vuIHNIz7zE5oStKcTW7tjljQ6cS
 ktXnzP84OThIzPFhTjVup3e6UWrsl_sV93FPt_DRmxocz9yRcMDq0vdgbjUvoQRwC1vZYJ9QU4Ku
 bG6PJS67K6ql_uMYdrbBrvc1mK4dIfz9vFGiiRE97rek7Qu4bLqMC7LWczYeOQywvtIFZA0m0kD2
 acavh2qPZWi3_pLQX9Jdgo5L_OdwQxQKcK0zzVryK_4Iw8GL1kdg2SkjvMVzvWexYAe9ewW2TR8F
 kBe4i11K4.LJ7WhpYypTerXU6I55Pzr5cLMTRgGdP2Ho90pL5cdwtpw1eT7PVvP9Rcw72HgssrWU
 _Krh4VJOWkuPU9XY_QgEMWTCzrPzFqp0EN5dwZl1kcVmke5Bb8aVfzj2MoP3pB7.fo4_isr1GMpQ
 AI_W8sUiWg4Kp79Ewt__EBPTx8lFPwERfkKVUguthro8L_P1mvCeM.dyNrLZIWjtUs_qQvjIC_UU
 6bVahNcveQeMJYh1hTsj.vS3E4NHc5ckYbWuJGbzaTDaxI05bBkDd.WzWTJmjkt0WpKcV0a.HTjE
 HpWoSyfjzP_S8pieb6_Y1wqLPS4cNpcJQ_yB0PecCwVZgjAiLXA0lE76o.2izHWkNGk1vrWkrWBV
 BfmfjBDvjbkJbbva6s3Qf9GYVsvsFbGh1yIYRZanjyMbhS2lfFUEYDaRM.1gdnqUph4nLFZ6ehVB
 B_VZnBQRErffDhm1PCRj2yxeAlUSOW5G0zwKlBN5WO.jt1X_U3x5ChlJpJqP0ucJztBA0ySG_E.s
 axaitRB7pzjYq5kvf_0LM9qZalw2YM6BkbjVqqM4PM9fB0Micv6Ctr6oHaY1Z5OhObc5kHYcfnlj
 QfNshDGVRCqcz3sLhLxDzDKtCQqFVKEEs5LhI39gBRpVKI7NzR4ds0gqWFNW3NcTIQkd8zqa6o2F
 gF8Av2zkeJzhjQSUkeS5z9oauMCa_VfpPQwo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:30 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 671694aa74794ae915ae1b1c311da411;
          Tue, 18 Jun 2019 23:06:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 09/25] LSM: Use lsmblob in security_secid_to_secctx
Date:   Tue, 18 Jun 2019 16:05:35 -0700
Message-Id: <20190618230551.7475-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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
possibility that more than one module may called upon
to translate a secid to a string, as can occur in the
audit code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  4 +++-
 include/linux/security.h                |  5 +++--
 include/net/scm.h                       |  4 +---
 kernel/audit.c                          |  9 +++++++--
 kernel/auditsc.c                        | 13 +++++++++----
 net/ipv4/ip_sockglue.c                  |  3 +--
 net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
 net/netfilter/nf_conntrack_standalone.c |  4 +++-
 net/netfilter/nfnetlink_queue.c         |  8 ++++++--
 net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
 net/netlabel/netlabel_user.c            |  6 +++---
 security/security.c                     | 14 +++++++++++---
 12 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8685882da64c..a3204fbc1f28 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3120,9 +3120,11 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
+		struct lsmblob le;
 
 		security_task_getsecid(proc->tsk, &secid);
-		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
+		lsmblob_init(&le, secid);
+		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index dcaaa63b79b3..c9ed83e57a97 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -442,7 +442,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *l);
 void security_release_secctx(char *secdata, u32 seclen);
@@ -1220,7 +1220,8 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(struct lsmblob *l,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index c87a17101c86..bcb0f8560cdf 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -97,9 +97,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		/* Scaffolding - it has to be element 1 for now */
-		err = security_secid_to_secctx(scm->lsmblob.secid[1],
-					       &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->lsmblob, &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/kernel/audit.c b/kernel/audit.c
index c89ea48c70a6..5efd78ced915 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1430,7 +1430,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+			struct lsmblob le;
+
+			lsmblob_init(&le, audit_sig_sid);
+			err = security_secid_to_secctx(&le, &ctx, &len);
 			if (err)
 				return err;
 		}
@@ -2073,12 +2076,14 @@ int audit_log_task_context(struct audit_buffer *ab)
 	unsigned len;
 	int error;
 	u32 sid;
+	struct lsmblob le;
 
 	security_task_getsecid(current, &sid);
 	if (!sid)
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	lsmblob_init(&le, sid);
+	error = security_secid_to_secctx(&le, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 93c74205ef40..67d3f71a095a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -946,6 +946,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
+	struct lsmblob le;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -955,7 +956,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+		lsmblob_init(&le, sid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1197,7 +1199,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
+			struct lsmblob le;
+			lsmblob_init(&le, osid);
+			if (security_secid_to_secctx(&le, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1348,9 +1352,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (n->osid != 0) {
 		char *ctx = NULL;
 		u32 len;
+		struct lsmblob le;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
+		lsmblob_init(&le, n->osid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index fbe2147ee595..e05f4ef68bd8 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -139,8 +139,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	/* Scaffolding - it has to be element 1 */
-	err = security_secid_to_secctx(lb.secid[1], &secdata, &seclen);
+	err = security_secid_to_secctx(&lb, &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 66c596d287a5..6098b586da07 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -330,8 +330,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct nlattr *nest_secctx;
 	int len, ret;
 	char *secctx;
+	struct lsmblob le;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsmblob_init(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return 0;
 
@@ -615,8 +617,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
+	struct lsmblob le;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	lsmblob_init(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index c2ae14c720b4..6e6fb1f9f6ba 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	int ret;
 	u32 len;
 	char *secctx;
+	struct lsmblob le;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsmblob_init(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 0dcc3592d053..105018d19318 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -309,13 +309,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+	struct lsmblob le;
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
-	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+	if (skb->secmark) {
+		lsmblob_init(&le, skb->secmark);
+		security_secid_to_secctx(&le, secdata, &seclen);
+	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 30873e671d05..46ac9721e261 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -389,6 +389,7 @@ int netlbl_unlhsh_add(struct net *net,
 	struct audit_buffer *audit_buf = NULL;
 	char *secctx = NULL;
 	u32 secctx_len;
+	struct lsmblob le;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -451,7 +452,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
+		lsmblob_init(&le, secid);
+		if (security_secid_to_secctx(&le,
 					     &secctx,
 					     &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
@@ -488,6 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -507,8 +510,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsmblob_init(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -550,6 +555,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -568,8 +574,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsmblob_init(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -1090,6 +1098,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	u32 secid;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob le;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1144,7 +1153,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	lsmblob_init(&le, secid);
+	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 4676f5bb16ae..4145adf55a22 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,6 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
+	struct lsmblob le;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -112,10 +113,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
+	lsmblob_init(&le, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	    security_secid_to_secctx(&le, &secctx, &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/security/security.c b/security/security.c
index 44927bf13d32..561a41eccbd9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1987,10 +1987,18 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
-				seclen);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.secid_to_secctx(l->secid[hp->slot],
+					      secdata, seclen);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.20.1

