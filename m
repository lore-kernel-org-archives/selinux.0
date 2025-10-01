Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F72367BA
	for <selinux@vger.kernel.org>; Wed,  1 Oct 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357034; cv=none; b=LINFVHEHtiFLzQ8w2FhgGE9lJ79YVD+ZsfHYnvj345lnuJiQbCE8Rd7OLpxnLz0nKDde4NHJbXvqKmDIYebhJ5JCJnNJvL6oK3r3/6x7y0UC9ahY7GRQdhThgQkdB+dqzCiMlf6Ves16vJpWcjXtQ6ejE48oAmE+aRgstC+FEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357034; c=relaxed/simple;
	bh=W36MxqvebnHnXzOblIQQBeCGhhGdtUB6F/MvJgE2FZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAaREajfTeE0HlSMqM5NJhFR9I+hSRhMZ0dVb3GhObLv/xgY9I/abjmD+GA044yGX1JQ7Oo2+r+VJZ+7zmTTCCOQ+dCOHGFLDUbD9TYblv3PRMT8GMerch0W5zDkJoSuRDRrhNdSXdxdqu8b5Ucx/YiH2S7RMFoS8+eYfgeTPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qK1E0PcE; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qK1E0PcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759357031; bh=I1haNk3gbqzhuI+DGI17PSbHsMJSVVkb5RArBZVpqK8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qK1E0PcEXa6UO1irwvYK0N9XJF/wp3SjgmD7nvDupRh8x/a/rEQ/HZ7VXFcgg2C6gDEVD8ZnYcLJ6VVJu7rflWwjJW8s1pA9uHaCUeDQs5etMPTmPWy/EkmA7b2FdHeRFiMc+YKd3pgjNRWYibhNLNHfd4sg3iPu6bwQl8MYtdJ/a71xHpcre5OH1wPsYhK3gRcuWc+k6d8J3yoQ7ZmTKEW/Ab5bVugPIcZe7Q+zh/pBa0zzpVmn/wYNPyjP0LmIKGkpcOTZ4587+fz/2xnBPJhuyo9uKc4gr4CjTwAPRG3iSGDQ5r/Uk9NkFfhpBMDzFt5T4/u2TUu6nqHSFwoPhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759357031; bh=JpDcOohgZC6pPBeOWs5TNfrO+t31vsT0p4Jo/JSMrPm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Jz7zyFvZJS+aqf1Zm5tyrshqWw523zzE74ldqHn9rlnKTGb+y3hdyqRt7lIjKkmAEbNhffoFAK8RE17cy5ji/a6IfFsfQ9EOIzcr4HlMECzXZoq2wFHZyVRYVGbpQNZGza5yEMOxmRkDrEiDlo1LXDoeKHSZarRRBa5MsgzFh2hVVk2e4PlIP9IM5LM9Ke2cAq+1pg7rQi5hFS7snaJfMDuDXNO2c8EMQPsbPmTWvrzPn9/ccGLKmer0ffxvknp+wWkuQdR4lgvXkhDO/GNOSgY1IQJC24oZ4wQXoOvyt6LB6g+jK577nq3hRMlWedIM954PIrSETQcBnTV+vxBQgw==
X-YMail-OSG: mZpZzcQVM1l8XD.P9xUxA9wQtaj1skoG.M6idQG0BTlZnYSCi4zJ0_jCAzfC0pd
 L4LpUqW_LARIE6KqmNitAEqIBbS02I8H1i5FXcQqudyWFGzCWjn_s813j2w4ZgXyUx2HgSufCLvg
 0r6rO0Tukqe7.HDmGKM6s8xjtsfT4zGIPVl3L6AI.Wljo9HvWthe41.ZLyEhObowH2RUejQLP9Wf
 vSGZef4lMw01Lk1mxWO4il6jAl80qrDCMQDawFxT3mnGYOtt0HN53moXNj6NI5mSTqDPpRvGVL6b
 2rM8bx03ES0QsdMFDkXcFD.S7tqVLydvP_VE7buuNLACy7fB4Exe5AqpS.pul0pN9xY5B4lvgQ1j
 qzu6pxi9bqmO575sEeUo_BbvIaNr989UxPxnBpDb5AtejJiNlVUO.G17ik_EX9YotMwinzfMGJGE
 zTPho7XlIyeW0Zhruq8KJL2hVUWAhEU0YnL7jKuDMcJLI.kHlfKFhd6xDY5ihl7bURUnk.2Tf_lM
 C5V30HYQ2GA4HKHtpzXUX8L9Ua72XW1eb8IuMnRKHUx9X8EZmKgrl_GoMp7n9h8kquY9MFeHX1FO
 VnFLANIZv2HGwfAnFx53X.FWbfNotVI1LegIXohy1r_u8ZhfBoOFpuV7Y3hWa4upgWiy9cPxya0j
 dBgn5rv0ai5t3JrmfZZvhEaE0XQ_SFarEp3WHCQ9dO5RIQVm4bzpBa8mthjoHGbzn__eKlHB0Uyq
 oLQ3PwsKYJwhPQ1thW0Bvprd5mYlSd88kdZZns7x4j3SnhiRNt5LxKqiqOGtYdTPmHL.H08C_Ol6
 oI6hK3GZas2Pk5zcV4EyfrRthglTWU10NThfUTNT6i8pWa7cGo6orzhGB.TV5z_3NjsAg9Rb2Lcg
 v5I56yDQYHo7G.P2t.c0K6rk3JnhagCoi44LvzMN.bCgvutlaT.iN6tI5AwNiXmAsBvBHEWFjXzR
 BsmPcD3sIpS2b29QT2LEfpT94_IWeifaL4zWCh7rv_XdjJpY0nZ8pnOQPf4wEYnNWEWAznhrjrY7
 SrJF_5V4J8xrnDiFVAq47aeqRYoMUHY.DDbmLGa5n06iZUs33xmK6hfQX0QGw.F9bWZjSjqsVR6I
 ajGiK4WMafyIR4sbxbpoJiKnpB6zFwvMiJOoib65_mYrdIXg3QPC.SsqoeR7NposBpdlCOuNGi8t
 GSCIPwvcwC7zwWMKvxstW9mHvRYCD57gjLr4AfpaF6UseWZNHeDxY_Ho4zRmHPwoiTXdKVXgXJdm
 FYMdgp.ge4BF3z.b_ZGSsOBCFLgXsVO_GUZc99B36GCgdN62Xle59W9QiHNVS_tvpPiJDeVLdk7j
 JfIc3kvHFWsunmw1yh04uwK8wuxQLMT4fcfEJHScKQ.BIASL.yuLqMjH8GJmV1DuErZECTCk45y5
 C1FEcte6FqwO3Lbl.j1Y8f6YPuQ8hfzuV6g7brgQkpEVjshe6Cw63ASRgZ6hg3KsW7Fpd7o7eGf1
 4OOjc.XXMghAkH9aFJegw9NotOhh9i6hzQB_6OOOBxcwQ_F73_zw9hlWXpsdOgqx891ONirtXYwF
 wBDLxKziHzizIjEL4pQItX9ttG4EgUIMu5xqYSTIRytQKyjFXdgyrQjL_WKqQh67uMYDs0yoC9HV
 Vbm0RcR4AfTmktC4Fh2s2Ma.cw.TWKrcEEghtsyZ0YxvseLm_4CgYDZcapiYLYI6spH.hjizSnG_
 zvYN.JzGSe4vFVIFMuMRlyuIYXJb4nybueAdaW1QLQKPZabvFm7Tnqoztwr3SPj8auT2XI8brc5D
 DJmMRbZpWSz3nTMYPhKH4o9BVGXqTn4CM9h4BuQZzLSHJVeft2DDzxEIm4RAxklXIdzBqpHziIRT
 tkhg6HxFKwNXIB78UYO.QvwSy9lHqRt19JxX8FXwHBApoJXDd_qA_4ld9y9eqXszmYcI9UdE3VG0
 Ql0YN6rVH1n44E6h5fQdpFIYLYK0N3ODFPaDL9wq4LgWEFxeGKKeQor9yWm1dZeA.1Z24Pvw5I7F
 4P6Gx_c6Aqkf3aSh3lPuTDRLW6ONrCDtlbRz0IpQBUvIwmlO773oIKfBm80b3W6aSK7r18jeP8iz
 irZ.HMA93_1eM3Alw3ZR_86ilOazi1nLhadKTsh1T0oDe6bwjtapxChBORhs_GlifDXFkRis6EOU
 g1urCMPz_3akSjKU2oZVvd.daTryOhA.hWFik2l76.qyOroBeOtsRGCwu7Syh5l1gs8a9o0K04k9
 vqi7osyaalTrwUJeD4UcLLRnL4VPgRgvuraOVFeHWG.lPzvmJhIgfZ_FEr5ymSEg3y4adW9OBIkN
 GthaeH1XAMmuuL9HNIrow8ZUc
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 85a9734b-0f73-43d5-b676-4101e5827dfc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 1 Oct 2025 22:17:11 +0000
Received: by hermes--production-gq1-66b66ffd5-4kj8j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49e653aa15d96dc3c9cb4665110aa952;
          Wed, 01 Oct 2025 21:56:55 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 1/2] LSM: Exclusive secmark usage
Date: Wed,  1 Oct 2025 14:56:42 -0700
Message-ID: <20251001215643.31465-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001215643.31465-1-casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The network secmark can only be used by one security module
at a time. Establish mechanism to identify to security modules
whether they have access to the secmark. SELinux already
incorparates mechanism, but it has to be added to Smack and
AppArmor.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  1 +
 security/apparmor/include/net.h  |  5 +++++
 security/apparmor/lsm.c          |  7 ++++---
 security/security.c              |  6 ++++++
 security/selinux/hooks.c         |  4 +++-
 security/smack/smack.h           |  5 +++++
 security/smack/smack_lsm.c       |  3 ++-
 security/smack/smack_netfilter.c | 10 ++++++++--
 8 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fe..69c1b509577a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -116,6 +116,7 @@ struct lsm_blob_sizes {
 	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 	int lbs_tun_dev;
 	int lbs_bdev;
+	bool lbs_secmark; /* expressed desire for secmark use */
 };
 
 /*
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 0d0b0ce42723..1199918448a9 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -52,6 +52,11 @@ struct aa_sk_ctx {
 	struct aa_label __rcu *peer_lastupdate;	/* ptr cmp only, no deref */
 };
 
+static inline bool aa_secmark(void)
+{
+	return apparmor_blob_sizes.lbs_secmark;
+}
+
 static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
 {
 	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8e1cc229b41b..34eac7da80e6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1512,7 +1512,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 	int error;
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	/*
@@ -1641,7 +1641,7 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 	int error;
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	rcu_read_lock();
@@ -1661,6 +1661,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
 	.lbs_sock = sizeof(struct aa_sk_ctx),
+	.lbs_secmark = true,
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -2360,7 +2361,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	struct sock *sk;
 	int error;
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return NF_ACCEPT;
 
 	sk = skb_to_full_sk(skb);
diff --git a/security/security.c b/security/security.c
index ad163f06bf7a..e59e3d403de6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
 	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
+	if (needed->lbs_secmark) {
+		if (blob_sizes.lbs_secmark)
+			needed->lbs_secmark = false;
+		else
+			blob_sizes.lbs_secmark = true;
+	}
 }
 
 /* Prepare LSM for initialization. */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..5b6db7d8effb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -164,7 +164,8 @@ __setup("checkreqprot=", checkreqprot_setup);
  */
 static int selinux_secmark_enabled(void)
 {
-	return (selinux_policycap_alwaysnetwork() ||
+	return selinux_blob_sizes.lbs_secmark &&
+	       (selinux_policycap_alwaysnetwork() ||
 		atomic_read(&selinux_secmark_refcount));
 }
 
@@ -7183,6 +7184,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_secmark = true,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..89bf62ad60f1 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -383,6 +383,11 @@ static inline int smk_inode_transmutable(const struct inode *isp)
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
+static inline bool smack_secmark(void)
+{
+	return smack_blob_sizes.lbs_secmark;
+}
+
 /*
  * Present a pointer to the smack label entry in an inode blob.
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..ee86818633c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4102,7 +4102,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 #ifdef CONFIG_NETWORK_SECMARK
 static struct smack_known *smack_from_skb(struct sk_buff *skb)
 {
-	if (skb == NULL || skb->secmark == 0)
+	if (!smack_secmark() || skb == NULL || skb->secmark == 0)
 		return NULL;
 
 	return smack_from_secid(skb->secmark);
@@ -5030,6 +5030,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_secmark = true,
 };
 
 static const struct lsm_id smack_lsmid = {
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 8fd747b3653a..2e82051b3998 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,7 +26,7 @@ static unsigned int smack_ip_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk) {
+	if (smack_secmark() && sk) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
@@ -54,12 +54,18 @@ static const struct nf_hook_ops smack_nf_ops[] = {
 
 static int __net_init smack_nf_register(struct net *net)
 {
+	if (!smack_secmark())
+		return 0;
+
 	return nf_register_net_hooks(net, smack_nf_ops,
 				     ARRAY_SIZE(smack_nf_ops));
 }
 
 static void __net_exit smack_nf_unregister(struct net *net)
 {
+	if (!smack_secmark())
+		return;
+
 	nf_unregister_net_hooks(net, smack_nf_ops, ARRAY_SIZE(smack_nf_ops));
 }
 
@@ -70,7 +76,7 @@ static struct pernet_operations smack_net_ops = {
 
 static int __init smack_nf_ip_init(void)
 {
-	if (smack_enabled == 0)
+	if (smack_enabled == 0 || !smack_secmark())
 		return 0;
 
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
-- 
2.51.0

