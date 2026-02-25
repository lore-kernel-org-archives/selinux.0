Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05D2D7DE1
	for <selinux@vger.kernel.org>; Wed, 25 Feb 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047335; cv=none; b=Pa1UVZd9TeCDvwo5CuIsWgB79mCoB+0s8b4Os8Q2k3ru19ThUN87aFABkvQGoXmcpNSYMiaj2dQvQpPbmg5tz9LC3GHqN5/s/lW1m5IwAWpZuJHoGVMW++O0nWGnovYAzM8Pkhb5XVKIYk1mHjfZPyCuVXE5BNY/cGVANO3Kik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047335; c=relaxed/simple;
	bh=Ugm29/8cN+3G81MnTiss0pGa1d4IdO7Qaf5n3sbJy0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbUwxMXMR+aPb5GAwwZyHg9KFYN4ZYcp36hGB/l8OCHoE83XeGPNsH3lobZkWfIn3zuJI9Nzc5wyO5746a8aNB4izWatg8/3++Y0IWad1m5nmiskDDwqkq0tSNTV7AmYMY0aUVpZHdnxgodz4czw0OzCiOpszry6XYEPbo75Moo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=b8LLCBDE; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="b8LLCBDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047326; bh=Z43PNb06pzZtCLUlarDHLUOJAGWD6uFtJOlYdsVZrfE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=b8LLCBDE72mWnOYS22DrLCTBC0atWBpf/8HmGeLu1Hk55a+ftcTcdxzfpUwITYWKRAVvyE04cod0wS0YDsBacq8ighR5JA2NRER/oXWIeEzgHALE8iZcuBgd7ITByTc6ntjs9MnzaqqYfGYaTtneOfXAVCQIwBU3nsgmsRCy/Htd2UDPg6ncMQBwuVpf2+nPs6o3iW5QblGFyThpfDOmTyiDEmqy/m4eArGQwbErO6W8TiY2naJyW1KXM21DDG3/gl73QUDE9K0+W40z6poYUeF4BUUiKEIRQgpG8xCQ0H/TJyHhk84XJqjloEd+NmchXu7J0olWhn2E0jcvrIKbLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047326; bh=OCb8IwyAqFgRAA3oPQRu8S1E29/mN0mX+uZUOpnO9HB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KKxgTDeY5VRaswB7yP7Abapuog0Z0MSO4w/jlo2+vinWDd5naA77jo/xhRbiUfH5fEU+aV3WksxN9glqtX42X01RrmDUZvKBDU6F3PK+cXpOE1l1Gb741sEku114bQOaDuuFR4nXohTa6PnodT4tBDC0glwxV4WEN3mpuzXV8ouSpaGuCvA+UAbyewuSH80MeJAYobilT3GwULh2811VWmcW9u4fw6Gdt4XdqaRaTzOBU8xxVtRW58HMkZhjKFFG7GHDXik4lVlKdqDPC1kN+xxCCJdeQDcGSVQDRpuwLCBM0v5B3QT1bSPWwfxxZ4RlglZZGYkldIMtmOMLqOFkaw==
X-YMail-OSG: OQ6kNm0VM1l18xVJ.VaayufrF71Sq.A3vGc9MQJdDhGUAKrbl3HSVqSzdf2NC_S
 leNjzd2nU9uzcAiVO0yajKzjrV2TZWc9mM.t5gAOg5h1gv.TCyXz.OuNg3d9gaQajFvmuzD5YaN2
 9W63y9HEfXqhW4bcCvDoWcXucuH21NF8iyScSZJpnYKyxcfmlLjy7sakp7Pz42xu.fNR.W7ZX1Rb
 e.TT8cz8EkRhmfcjBgv7.bQxoRSNWzh2BVU8FmLF8AenMvVqEkulbvhcHPDcLcNA864BdPv4SPhX
 UxCA6eNnkEiDa0u3U3rDO60u372RyA0MmoPsTxk.GrciEYK5Qsg0ppfrTVa2hpgMdpIPUFyvuzVI
 sZZ7UKFwJebbSF_93U8Xf.e56hwZp8d.OZ0arfj9GIl2hH9r9wQI8p5GDl0vJHfo.eAhtot8oCfP
 pKglN4n.F828Xvm7YcgWkzPMBQpEPuMMLyPhfuKwtMGGx70SgFCOJJ5Nvj75Vog2aLMgSE3N6JK.
 ZI8XuFAK2geN5BbQquT4qSXZWD12S14vYGOIyo6hbg6P.By3e8Hn9lG6hcdB27Ami32Jgpprh4qW
 0Utw3Sh861pi2NVan6GzG6Y1.2HtYCA8aph0V_7AaQGZwE1cXb.ysxBKgPg.FQ6pbpbull00xc00
 FSPFInMqU1i2SrOXIjyWPZBg8nJuyYvjyVeSbOeLLtUgUPoW6cBZDZLZhxAt50Akj_Z95ASDwiU7
 SGItKLJM.EA7N6RMUUk_Zu5V_uQvambvEE5hyEyW82O610Fv.UJOkh9PmWxxav4Gi9A_Pz42do._
 ckqBqT1VlJkQ4mQRr6nZSDmj2v6TRacfyHhOBiWpXa8FEUcYjkCrocUzls1TQs1qDD8haP1GcqUw
 phYSg9tQCuLInQqnQ4Tace1OOikTONvC_TgIOBszYHg5vkfok2v6_yyYgnmGk0Av1hOxX9HvqDlL
 VrN4SxQdGjAEZ.tvq20QOFNY4DvARUn8DbdO0l4ASACXMhFIMRqu7ussw3c30u98Oe5eGQ5Fddgv
 nMfITAowmmDOUF9XdQSpsgn0Qb7uceUMGzJSpMidMev9ur0P0m2l3VhJV8R8yuCMtbtIl78hISP.
 Pma2dAJTEnM6Xfu57tYHK5zpUdGXX0.SWScKpFp6k1x8vIHasB038oe.SbbtVOH.vTTiksMNKwSP
 _sHBqUGfy8GkMJzhONZp2l_5d1hDRuuvpnvP3RqpJrok69CLQPACBm8brfE3ORBbc3SkKAO7D.aY
 EEsLmkUPGd9lMF1EsUjcNobg8C1gP4sgs2NfvLdhJAL1rr591WiJM2UeEkcNK1PKmhiBlZHhX54R
 i.vOboj_6J9g0YuUIZomj1qAiP09Yn2Oxy4iwJrdiwi6.E1sQnz_i3VIiBVj4iyibEJj0T500cFY
 95VJTLqVf.LIl7Zm5gXXn4uAYy15Verxg5ZSbOWYgRFoAmUdpodz3fg9bA5kaNO2oZM49yYxTH9A
 EVpqOKk4OHTY1JmM1gmqF3UXQRDpSm.gYs2K2Ihq5hhaQkbyGp9JwtXhR9sTrts9unX8ppvIGQAY
 S_w8XX97APc6d_t4cUNdM6HbQTy_OAAtG1TTJP3sxfYo5lBAEruez8.tysY.9rlB.MN_tXSon4lY
 F2RAtr_nLPLiOab5Vx1rqcWZpqIIalSoHqux48l2i8MRIgDHRvad4yqz7lUlSRZrsVKJTQN6.7gg
 imP7KUSvNR9h2Fa8vJJzlXuxCNmi454fbcYf_8lOYmzW6X8MU15wt666cQuQxW8eS63DUfgaSm1X
 LTMtOs30BbHhHaDs_wu0ZpUT29NCudlQkNXtIjaiwvTrZirB0ERjgPqt8fGspxRUNNdxfCcdGe8H
 TCamv.67oTo071fNwggWP5VJ.AlyuvO4QaNCqkbN0FNWp1xe.S_Q2BREELbGDQpnl9wdITqXz4kY
 P9146r7B3vd6sh1QjAJ4XkzuYdE7SxkdEV1aK1UDjucBoxeOel1NmoKEjkoiA3vkajwQE4rsE_TC
 dKPGWRUJzxTbWy6Yj4qEvFPIIMlzMTKZOaQgHr0vIKv2Ihxk6LTSLt_T97KcixbaU61jVuB7vmPK
 .fkgvEU.LM2ZG2UO5qoU8BzdmP3l3yo5.5ccMtzynHO3jXxj5xG7vDb7VC_hEQ2Kx9FKjh4xti_W
 E3Ug8vmct8i0mkkW9Rl6aJR.6h_7BfgxxZn2VVJes8imP7lwpmEBns0bn3rMsp.o9SuvUp3szFX9
 B8UiegflNtGa1GnjN4eitWGf4y6sxmul1yLD0DdotSVSahMeU94GRjPWc3oHWZeta4uZBxKEAaTL
 48JElKvMmAsOpPeuJKLQHGA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4c7c1ae8-1394-4802-b1a1-a20162ce0607
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Feb 2026 19:22:06 +0000
Received: by hermes--production-gq1-6dfcf9f8b-5skm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 34de27226d18fbed2fa1781e81910440;
          Wed, 25 Feb 2026 19:22:00 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	selinux@vger.kernel.org
Subject: [RFC PATCH 3/3] LSM: Reserve use of secmarks
Date: Wed, 25 Feb 2026 11:21:43 -0800
Message-ID: <20260225192143.14448-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225192143.14448-1-casey@schaufler-ca.com>
References: <20260225192143.14448-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of "exclusive" LSM hooks are limited to the first LSM registering
them. These hooks include those use to process network secmarks.
The hooks required to process secmarks are flagged with LSM_FLAG_EXCLUSIVE
in their definitions. This includes secid_to_secctx and secctx_to_secid,
which are used by netfilter.

The various LSMs that use secmarks are updated to detect whether
they are providing exclusive hooks, and to eschew the use of secmarks
if they are not.

SELinux has a peculiar behavior in that it may decide that it
must have network controls, but only after policy is loaded.
This patch includes a warning should policy capability alwaysnetwork
be set when another LSM holds the exclusive hooks. It has been
suggested that SELinux would consider this a fatal condition, in
which case a panic might be a favored, if draconian, option.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h    | 12 +++++------
 include/linux/security.h         |  1 +
 security/apparmor/lsm.c          | 24 ++++++++++++++++------
 security/security.c              | 15 ++++++++++++++
 security/selinux/hooks.c         | 35 ++++++++++++++++++++++++--------
 security/selinux/ss/services.c   |  3 +++
 security/smack/smack_lsm.c       |  6 ++++--
 security/smack/smack_netfilter.c |  6 ++++++
 8 files changed, 80 insertions(+), 22 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index acda3a02da97..e6d4d9c80ac6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -309,12 +309,12 @@ LSM_HOOK(int, -EINVAL, 0, getprocattr, struct task_struct *p, const char *name,
 LSM_HOOK(int, -EINVAL, 0, setprocattr, const char *name, void *value,
 	 size_t size)
 LSM_HOOK(int, 0, 0, ismaclabel, const char *name)
-LSM_HOOK(int, -EOPNOTSUPP, 0, secid_to_secctx, u32 secid,
+LSM_HOOK(int, -EOPNOTSUPP, LSM_FLAG_EXCLUSIVE, secid_to_secctx, u32 secid,
 	 struct lsm_context *cp)
 LSM_HOOK(int, -EOPNOTSUPP, 0, lsmprop_to_secctx, struct lsm_prop *prop,
 	 struct lsm_context *cp)
-LSM_HOOK(int, 0, 0, secctx_to_secid, const char *secdata, u32 seclen,
-	 u32 *secid)
+LSM_HOOK(int, 0, LSM_FLAG_EXCLUSIVE, secctx_to_secid, const char *secdata,
+	 u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, 0, release_secctx, struct lsm_context *cp)
 LSM_HOOK(void, LSM_RET_VOID, 0, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, 0, inode_notifysecctx, struct inode *inode, void *ctx,
@@ -379,9 +379,9 @@ LSM_HOOK(void, LSM_RET_VOID, 0, inet_csk_clone, struct sock *newsk,
 	 const struct request_sock *req)
 LSM_HOOK(void, LSM_RET_VOID, 0, inet_conn_established, struct sock *sk,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, 0, secmark_relabel_packet, u32 secid)
-LSM_HOOK(void, LSM_RET_VOID, 0, secmark_refcount_inc, void)
-LSM_HOOK(void, LSM_RET_VOID, 0, secmark_refcount_dec, void)
+LSM_HOOK(int, 0, LSM_FLAG_EXCLUSIVE, secmark_relabel_packet, u32 secid)
+LSM_HOOK(void, LSM_RET_VOID, LSM_FLAG_EXCLUSIVE, secmark_refcount_inc, void)
+LSM_HOOK(void, LSM_RET_VOID, LSM_FLAG_EXCLUSIVE, secmark_refcount_dec, void)
 LSM_HOOK(void, LSM_RET_VOID, 0, req_classify_flow,
 	 const struct request_sock *req, struct flowi_common *flic)
 LSM_HOOK(int, 0, 0, tun_dev_alloc_security, void *security)
diff --git a/include/linux/security.h b/include/linux/security.h
index e3c137a1b30a..638436b9b748 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -326,6 +326,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 extern int security_init(void);
 extern int early_security_init(void);
 extern u64 lsm_name_to_attr(const char *name);
+extern u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..2ce0d9a73973 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1511,9 +1511,11 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
 static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
+	u32 secmark;
 	int error;
 
-	if (!skb->secmark)
+	secmark = lsm_secmark_from_skb(skb, LSM_ID_APPARMOR);
+	if (!secmark)
 		return 0;
 
 	/*
@@ -1525,7 +1527,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	rcu_read_lock();
 	error = apparmor_secmark_check(rcu_dereference(ctx->label), OP_RECVMSG,
-				       AA_MAY_RECEIVE, skb->secmark, sk);
+				       AA_MAY_RECEIVE, secmark, sk);
 	rcu_read_unlock();
 
 	return error;
@@ -1640,14 +1642,16 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
 				      struct request_sock *req)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
+	u32 secmark;
 	int error;
 
-	if (!skb->secmark)
+	secmark = lsm_secmark_from_skb(skb, LSM_ID_APPARMOR);
+	if (!secmark)
 		return 0;
 
 	rcu_read_lock();
 	error = apparmor_secmark_check(rcu_dereference(ctx->label), OP_CONNECT,
-				       AA_MAY_CONNECT, skb->secmark, sk);
+				       AA_MAY_CONNECT, secmark, sk);
 	rcu_read_unlock();
 
 	return error;
@@ -2359,9 +2363,11 @@ static unsigned int apparmor_ip_postroute(void *priv,
 {
 	struct aa_sk_ctx *ctx;
 	struct sock *sk;
+	u32 secmark;
 	int error;
 
-	if (!skb->secmark)
+	secmark = lsm_secmark_from_skb(skb, LSM_ID_APPARMOR);
+	if (!secmark)
 		return NF_ACCEPT;
 
 	sk = skb_to_full_sk(skb);
@@ -2371,7 +2377,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	ctx = aa_sock(sk);
 	rcu_read_lock();
 	error = apparmor_secmark_check(rcu_dereference(ctx->label), OP_SENDMSG,
-				       AA_MAY_SEND, skb->secmark, sk);
+				       AA_MAY_SEND, secmark, sk);
 	rcu_read_unlock();
 	if (!error)
 		return NF_ACCEPT;
@@ -2399,12 +2405,18 @@ static const struct nf_hook_ops apparmor_nf_ops[] = {
 
 static int __net_init apparmor_nf_register(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_APPARMOR)
+		return 0;
+
 	return nf_register_net_hooks(net, apparmor_nf_ops,
 				    ARRAY_SIZE(apparmor_nf_ops));
 }
 
 static void __net_exit apparmor_nf_unregister(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_APPARMOR)
+		return;
+
 	nf_unregister_net_hooks(net, apparmor_nf_ops,
 				ARRAY_SIZE(apparmor_nf_ops));
 }
diff --git a/security/security.c b/security/security.c
index 25e7cfc96f20..754b16004677 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4509,6 +4509,21 @@ void security_inet_conn_established(struct sock *sk,
 }
 EXPORT_SYMBOL(security_inet_conn_established);
 
+/**
+ * lsm_secmark_from_skb - secid for the specified LSM from the packet
+ * @skb: the packet
+ * @lsm: which LSM is asking
+ *
+ * If the specified LSM has use of the secmark, return its value.
+ * Otherwise, return the invalid secid 0.
+ */
+u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid)
+{
+	if (lsmid == lsm_exclusive_hooks)
+		return skb->secmark;
+	return 0;
+}
+
 /**
  * security_secmark_relabel_packet() - Check if setting a secmark is allowed
  * @secid: new secmark value
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d053ce562370..1dff2121a834 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5269,6 +5269,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	int err = 0;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
+	u32 secmark;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
@@ -5279,7 +5280,8 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		secmark = lsm_secmark_from_skb(skb, LSM_ID_SELINUX);
+		err = avc_has_perm(sk_sid, secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -5299,6 +5301,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
+	u32 secmark;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
@@ -5348,7 +5351,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		secmark = lsm_secmark_from_skb(skb, LSM_ID_SELINUX);
+		err = avc_has_perm(sk_sid, secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -5850,6 +5854,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	int ifindex;
 	u16 family;
 	char *addrp;
+	u32 secmark;
 	u32 peer_sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
@@ -5883,10 +5888,12 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 		}
 	}
 
-	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+	if (secmark_active) {
+		secmark = lsm_secmark_from_skb(skb, LSM_ID_SELINUX);
+		if (avc_has_perm(peer_sid, secmark,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
+	}
 
 	if (netlbl_enabled())
 		/* we do this in the FORWARD path and not the POST_ROUTING
@@ -5950,6 +5957,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	u8 proto = 0;
+	u32 secmark;
 
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
@@ -5960,10 +5968,12 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
 		return NF_DROP;
 
-	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->sid, skb->secmark,
+	if (selinux_secmark_enabled()) {
+		secmark = lsm_secmark_from_skb(skb, LSM_ID_SELINUX);
+		if (avc_has_perm(sksec->sid, secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
+	}
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
 		return NF_DROP_ERR(-ECONNREFUSED);
@@ -5978,6 +5988,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	u16 family;
 	u32 secmark_perm;
 	u32 peer_sid;
+	u32 secmark;
 	int ifindex;
 	struct sock *sk;
 	struct common_audit_data ad;
@@ -6082,10 +6093,12 @@ static unsigned int selinux_ip_postroute(void *priv,
 	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
 		return NF_DROP;
 
-	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+	if (secmark_active) {
+		secmark = lsm_secmark_from_skb(skb, LSM_ID_SELINUX);
+		if (avc_has_perm(peer_sid, secmark,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
+	}
 
 	if (peerlbl_active) {
 		u32 if_sid;
@@ -7718,12 +7731,18 @@ static const struct nf_hook_ops selinux_nf_ops[] = {
 
 static int __net_init selinux_nf_register(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_SELINUX)
+		return 0;
+
 	return nf_register_net_hooks(net, selinux_nf_ops,
 				     ARRAY_SIZE(selinux_nf_ops));
 }
 
 static void __net_exit selinux_nf_unregister(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_SELINUX)
+		return;
+
 	nf_unregister_net_hooks(net, selinux_nf_ops,
 				ARRAY_SIZE(selinux_nf_ops));
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 13fc712d5923..269ad09f8dca 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2189,6 +2189,9 @@ static void security_load_policycaps(struct selinux_policy *policy)
 			pr_info("SELinux:  unknown policy capability %u\n",
 				i);
 	}
+	if (selinux_state.policycap[POLICYDB_CAP_ALWAYSNETWORK] &&
+	    lsm_exclusive_hooks != LSM_ID_SELINUX)
+		pr_warn("SELinux:  policy capability alwaysnetwork is set, but secmark is used by another LSM.\n");
 }
 
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a0bd4919a9d9..7a98dcc4c67d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4195,10 +4195,12 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 #ifdef CONFIG_NETWORK_SECMARK
 static struct smack_known *smack_from_skb(struct sk_buff *skb)
 {
-	if (skb == NULL || skb->secmark == 0)
+	u32 secmark = lsm_secmark_from_skb(skb, LSM_ID_SMACK);
+
+	if (skb == NULL || secmark == 0)
 		return NULL;
 
-	return smack_from_secid(skb->secmark);
+	return smack_from_secid(secmark);
 }
 #else
 static inline struct smack_known *smack_from_skb(struct sk_buff *skb)
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 17ba578b1308..47426973843b 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -54,12 +54,18 @@ static const struct nf_hook_ops smack_nf_ops[] = {
 
 static int __net_init smack_nf_register(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_SMACK)
+		return 0;
+
 	return nf_register_net_hooks(net, smack_nf_ops,
 				     ARRAY_SIZE(smack_nf_ops));
 }
 
 static void __net_exit smack_nf_unregister(struct net *net)
 {
+	if (lsm_exclusive_hooks != LSM_ID_SMACK)
+		return;
+
 	nf_unregister_net_hooks(net, smack_nf_ops, ARRAY_SIZE(smack_nf_ops));
 }
 
-- 
2.52.0

