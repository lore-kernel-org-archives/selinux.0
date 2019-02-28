Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DEC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591A82184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eu0+BU6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfB1WUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:03 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:33906
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729764AbfB1WUD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=F6fmm5jKLmwlt0y5u6kuYRvW64MVx1tG/nhRJwLDYS0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eu0+BU6thpxT8eCI/E2TwjtQwVH3CQ+H4hrtG/CjResquAGB2Avsvn805zkH6ae3nVySwXW/ejSvptYFE0+PcIgT4PDo8XAVIcTig4FncyU8Oy80mrRTZRRWxSXYEH1uMzK2+Uv95Mmc2gpeH90K6oL3UJNvP7KuUNJ47KD9vubPTDucRnjHd58xUxxW1KnTNGdMkrCbE97bPjrctdE2k2mvVxh3cA84C38kEG6cQvWxI10vnP2jQsc1dgqor7tQVSgnT+A5JOqVYwPuJOYkUnbREx/Q+MsiZCLSDHWXsp6/t2fjKbgftyPdsHGGiqzieK0m/98qqBsTElEPo0gp+Q==
X-YMail-OSG: V0xnpnkVM1lvptuMhCjMFECSECfsh20rNUVvdgXjoptbZsm50I4ehSXAriRHPlY
 0pWcjfpXtkONmwsFIj.8S9CPWBKj49CKaosvLEz3vpspWzdivcGdA9mu3fD_xtZUTB1zYrsl7Mzm
 qQHkoPH67HPcwhfPf4uWmhAm1dIscOGi33Yyc5kh8okBLZBfCeEHOGovzDzQ4K8.bZOcT40BZxT4
 XK8PdndCFtmraMedZjz0NI2o0wL3QRNN0E3aDfCQPnkUnfL1fx_2Qd..oWtxSp4UVwu8By5VFY_D
 vC10MbHlLohG9A2c9Z2i2SmDjAYpEXuD645C6U2OuP_kqZmilEPg7Pj.ZvhoKcrtyCzMx9tkUHVR
 TVht9SKDWWA9I2JvKsWSzZOyV.U6CXwuXh2QUk6ZJu3dQhplwUSIqnR1Rxka9FbEGps4kMvGdNC1
 vijHaefA9wXKpvLq8m34v7D5ewZJ3CT3ONQru1MrZ3DC1gIsYbbNzUJGz2FCXp9JqKV.VgT6ULWL
 Vzfnri5L3AXKZZAMLE.rQ7K_CJxRXCunhX.4t7wkG8DuPvuYWfO.fZdmz00huVrJeXOMrMLLEbV0
 BUCAbU.q04pI.oRxs9RnkHIm7mtqbRHPBLHC5igTkqpwTp.GukflyplS7hzSNaxiyszWc_VauRT5
 5Y8qrKTk6u2gPjociaOiHfbh53V29Oi45hx3fRcOc3SNrdz7XO6P3jb9qYXLJb4y3oHz.q4KwYHj
 Vl5z4X6lsDqtqzzeTBun.ReBTJWOtLqMHKSRvyntE0WwUnxcjiH09zC20yEmjFnfwlqQ9Oq7Dzy2
 MEPIHlpnPdQUZ9vp9oruaNsoT6CdpCbfCkvE.EEdEEWoSKKRH9jVThJNwyX_b3..9en6RCrwjynx
 k4DRLdIXubHLHZyXm_z9fUavShtcUTA8JNgNY9Ygps9GkJoToMDAyu.gUdWt3mTqDc_pV9HdF31x
 _tNNd1H1zXQl4y04cCYtQQeTfXTlIEUnCjxf6f5gyuFrjBnpjMx5JFCtWAukPWFZP3AMOZ6ACzKL
 3UVOzDDEtUSuhR0cBaESaAyFYt01E1uFS2z4AZULS377QADiaC9hxe7pnV3tM7MYe4FJU2H7ZNIj
 slPoohpG343aibxB5pw969iXh1r3edo7I1SCta30G0VU_rZ4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 21/97] LSM: Use lsm_export in security_secid_to_secctx
Date:   Thu, 28 Feb 2019 14:18:17 -0800
Message-Id: <20190228221933.2551-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secid_to_secctx to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h                |  9 +++++++--
 include/net/scm.h                       |  4 +---
 kernel/audit.c                          | 15 +++++++++++----
 kernel/auditsc.c                        |  8 ++++++--
 net/ipv4/ip_sockglue.c                  |  5 ++---
 net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
 net/netfilter/nf_conntrack_standalone.c |  2 ++
 net/netfilter/nfnetlink_queue.c         |  6 +++++-
 net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
 net/unix/af_unix.c                      |  9 ++++++---
 security/security.c                     |  8 ++------
 11 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 330fc7ac8d7d..d0adf4032baf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,10 @@ static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
 	case LSM_EXPORT_APPARMOR:
 		*secid = data->apparmor;
 		break;
+	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
+		/* For scaffolding only */
+		*secid = data->selinux;
+		break;
 	default:
 		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
 			data->flags);
@@ -431,7 +435,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
@@ -1198,7 +1202,8 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(struct lsm_export *l,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 13b8a369fd89..b5d1c24318e3 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,7 +33,6 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
 	struct lsm_export	le;		/* Passed LSM data */
 #endif
 };
@@ -48,7 +47,6 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
 	security_socket_getpeersec_dgram(sock, NULL, &scm->le);
-	lsm_export_secid(&scm->le, &scm->secid);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
@@ -99,7 +97,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->le, &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/kernel/audit.c b/kernel/audit.c
index 632d36059556..aeed1368a166 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1418,7 +1418,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+			struct lsm_export le;
+
+			lsm_export_to_all(&le, audit_sig_sid);
+			err = security_secid_to_secctx(&le, &ctx, &len);
 			if (err)
 				return err;
 		}
@@ -2167,8 +2170,10 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (n->osid != 0) {
 		char *ctx = NULL;
 		u32 len;
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
+		struct lsm_export le;
+
+		lsm_export_to_all(&le, n->osid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
@@ -2207,12 +2212,14 @@ int audit_log_task_context(struct audit_buffer *ab)
 	unsigned len;
 	int error;
 	u32 sid;
+	struct lsm_export le;
 
 	security_task_getsecid(current, &sid);
 	if (!sid)
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	lsm_export_to_all(&le, sid);
+	error = security_secid_to_secctx(&le, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5988f4fce7de..0d4e006a7ae1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -943,6 +943,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
+	struct lsm_export le;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -952,7 +953,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+		lsm_export_to_all(&le, sid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1168,7 +1170,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
+			struct lsm_export le;
+			lsm_export_to_all(&le, osid);
+			if (security_secid_to_secctx(&le, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b8ef7677a7e5..a4f37ba6dbe2 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -132,15 +132,14 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
 	struct lsm_export le;
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
 	int err;
 
 	err = security_socket_getpeersec_dgram(NULL, skb, &le);
 	if (err)
 		return;
 
-	lsm_export_secid(&le, &secid);
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	err = security_secid_to_secctx(&le, &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 1213beb5a714..d19092fc6580 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -330,8 +330,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct nlattr *nest_secctx;
 	int len, ret;
 	char *secctx;
+	struct lsm_export le;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsm_export_to_all(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return 0;
 
@@ -615,8 +617,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
+	struct lsm_export le;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	lsm_export_to_all(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index b6177fd73304..51dc1e390d84 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -171,7 +171,9 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	int ret;
 	u32 len;
 	char *secctx;
+	struct lsm_export le;
 
+	lsm_export_to_all(&le, ct->secmark);
 	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
 	if (ret)
 		return;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 0dcc3592d053..537effb6e5be 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -309,13 +309,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+	struct lsm_export le;
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
-	if (skb->secmark)
+	if (skb->secmark) {
+		lsm_export_to_all(&le, skb->secmark);
 		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index fc38934ccb35..00922f55dd9e 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -389,6 +389,7 @@ int netlbl_unlhsh_add(struct net *net,
 	struct audit_buffer *audit_buf = NULL;
 	char *secctx = NULL;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -451,7 +452,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
+		lsm_export_to_all(&le, secid);
+		if (security_secid_to_secctx(&le,
 					     &secctx,
 					     &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
@@ -488,6 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -507,8 +510,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsm_export_to_all(&le, entry->secid);
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
+	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -568,8 +574,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsm_export_to_all(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -1092,6 +1100,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	u32 secid;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1146,7 +1155,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	lsm_export_to_all(&le, secid);
+	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 74d1eed7cbd4..e2327428aecb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,17 +141,20 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	lsm_export_secid(&scm->le, &(UNIXCB(skb).secid));
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	lsm_export_to_all(&scm->le, UNIXCB(skb).secid);
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	u32 best_secid;
+
+	lsm_export_secid(&scm->le, &best_secid);
+	return (best_secid == UNIXCB(skb).secid);
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index da3ccb19dcae..0026edf0a424 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1943,13 +1943,9 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	struct lsm_export data;
-
-	lsm_export_to_all(&data, secid);
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
-				seclen);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.17.0

