Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D12236FA
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526443; cv=none; b=oKz7j2ihDICruTD+OQDXMCkNU82iR7LNhvqKpqPiFqJtxLcz8CKQRmypKSGAV8V4jfG82SLez3WVmPr+qeEzzuWEG1gNBGb1gShi+OFtd25TSw13HU9ZaZlObYSiU/Hph073oOKzQIS8rJjg5BahIWEc4si462tq6fW+nfZVWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526443; c=relaxed/simple;
	bh=UyCJBTfuhEp+Ni4G5mlbGTTMVkJdAVgVfFk2ItfgdCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBe8Xeohl8Hv51bSYLlDQGtn7E7P7k+5pFXgoTDInjyXDH8yng5PIrzDU1SPcvELCNM2oSMgo0BLigL/pGk1P/qWuuuE1z+ZdkQLk3c3yFlejCTB9thi3arqu/DjJRL4eR+TBxeK0bphDaMZwmO6c6BRF/6djux2hhQJNeBfqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SsYp2fBV; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SsYp2fBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526440; bh=7BSeliQV1VLiCfSV65JktQ+lUnNoX3/LR/dHf0syM7M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SsYp2fBVaZtVWvF6m0VIZDBGFwoUlo52YswPtvcMnIOfHv+OJyk/2yi63hr+V22+mL/6N4eQFpCP4ewdiX26IxdqJne9QrHPeVmXI2Hx1jVO9PGiHN5+oGrc8fZOsFDCsIQZA+dK5rBeP/3JIYPa9A3Nt2aXUsia0jXyaThtAAyWiG+/KO1RWo9UwauewZONNO1QgC6MwHDNqNpaY/0N/G2S8gZrvEQnpdFckWJtRThJnwRPUcuajPvGq4b71eMFeUa5DxERAtQXD9hc4w090Nn5YJ9d4CiQpVOXdSTk2FTP09WsMkNxFn50ot2fPcBeJ9tUZecLCuS3oqc318uQtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526440; bh=lI283QOmAWHWBmQjMNMGJxgXApdqw0BW7OMdI0Zg+6u=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZHF2rhGnh4RFIrNLnZsoXbjIfK0hlMuswT8AUY3oNFjxheIqzl8JqosAlUSCJQ1ODam4uUmvxfRmqh5brcBajz6Y1LS4SrGFmNm0X2SL9/JwJxduh7KbIly8OCpIaXy21j7R0lC31CnOKMFI0lgsa7a8gEcZn+27nzvD69GCLihkNxv30xwslqwvto8Ht1GDOPE2uh9EK+f+X2NIyWPOzE/z4ZBZtSZ7vrVl5UKbQC7IdgGVEXmDQnRDv0EqzwtqpDSb/9mAa3w5i3DkdAGacUQkPe+N01kLxAuOqCZhYoNHhM8JcTVPGS71iDfgItbF4ZgwcMRJfDJcBlfGWCneRA==
X-YMail-OSG: rGY7mw8VM1m2vedgZmNuOCGJg5dcFAerDfyZNhEr_qtWyjJ8E0WG_GmtWQXNBl9
 mCMOyKO3gpf4V8M8vt1V6D_.qtDFUNgpzfLT8C_JM6a6YlA38a3nii.xbKM8Ubz8qwMun3gmU3ph
 cRZSGvt6wyj8W3TZVKkeorjSmdZrQLTL90lpuvTIO17UrKqKoNEvF69zbn8uxsSN1jgR1XLtZ_dR
 c7bEPwi0ICXqqjwzRO2aUuptrY7d.JOkl3ELpwFeluG_yYgq4.j5BEEqgkX.bAxW7lU9pJU1cG3B
 riamvjBWqnccCfQdWBxhoxyXA7VvZhuWQ20z42u2E41XquUfM8KJpiDZ0YroiDUSRBv4amBkBtCa
 xpVIHqFe2ZvJhie6f6poTu1Yehi3t06ioCqFssnkZC2CTlIGXiDZ3CmP2kIeqFnDLWLcsZNEc950
 sTsnjYdmdSoXa2mmTskUYLdyMjVEyU.Z4FFN7xxYEYo1B2kE_Fa_O9n0niV6A3uV1oAeRMHlqFMT
 3Hia5B7TxVnbIyrMOkFzZEsFclnHhfv9pxBOPmWO1h5AB.n39Wxbz2ZInjDshBJGqZU23kJcO35A
 FrSPxEHKBSr3upMwCP_oEhcY2oj53Gwf_n.6KKjl.4FUyByZCdvZkHT806mtiUFOkRZpdKkoB4vU
 w0s26qVOfSl6NlBYEMUi9xu5d9y4vijVNOIWDP1_CrvualKcLf5wLeato.Va2DumQp95PhhNFyTC
 1B8isk2Ep8R3N8k6uPxtS9DyIRPUiPtVc3xli_Y1zgzPED.UbxtDWr6.d.Nb.w4aTrSxh0aqpZfU
 FELACwHUNXRAYSSmfyy7tUhpOWR0CREVFFjRYI7cLl2k6s9atycRm...kCRhWeODcCB2JsFkyzMf
 28Mz9WqT9I7Q8Vd5pQ9svtBI8_IBOVZtsIdeTbvSEeB2MQHKL7mYMnYEEc8e52QggkT6VZ44hbGQ
 RNnTEiIZ_2sYYg_2gQXMY30Cp51r5mzGZcOtfPLmQE.BQxm6D5tvbJEZ55iPUrHjDXY8DNtBCWRI
 DD_KFyFFobAYfWbbgdbYkB4I9A0UMeOMezOg8Yg7JQ7DRARg2.wWCrqL1MfIjVItGqORO8CdG4M3
 slcP1ffu5YD3OG2klJlgdf7yW7i7coY8d.T0BZCrNpdRnyPz3KtkUEc9OxML3uOBqTYeSBicjnpN
 .Qz.WRNbjz1wi_8iAP2Xa6wGNT62cGB0UM6lxljaJvtH6OUhV0oIqlBvOzzrGLtWXthAmLwY9jiu
 h6.bDpveSNbd8fP0Rplkb7Mv3JPRvJSpWVj0RPe1KkhPzD0lVVKzyg7XQwNfsHy4Udt95tHt9GFV
 RFlVrG1xG6K7cNxlXV7SPr2S6hIpn7ysjax0z8zGUffe5grPMbjxUr42bzk330IRVWo3NkFq5.U6
 cT3RsBocPhVMqfcB_QUGLxkPQxNnbO7gb5EPNnsMixLtTCoIPGYdh.Ee7R4KePzlLbvPdT9FYEAB
 HFEMG8kRU9HZNzv6pjcguo5DrYloY1rLN._M9rnurBjh0UgXF8rqrSw3A7L7d8Xds9KBZG0pvGuV
 uq5z7Nd34kXAeekHjlqTQiXrorXe1rX4MubTpSJHQXIPqN_k.vuylZqpLlHsu5QLOJfegZLnrVdW
 zA7fq73DW_qdxSXj.nl.AUEUzEelTP8RdDsdVn.TmqxgaJgJxIzS8ThwFdPqEnCea77mX1jjdCs3
 MYYKa5kX1us1iF.Rg_ey9FkM7Kn.apq.KQ.zQDgWeGYKBC3PW2AhwWSg9fI1eKUPObDrqehQF8Hr
 5Xk9ilBI36sL1MLev8km.uOt2opldCIxm79lyo6CDaUz7WSgWXGfnqD_HRPpT9rD7qwlvIrVv.MA
 lrVu1znWg0Qb5ifHB4l.bUPB9NmSDQjraZQI2aamp7.BK8xFHR1Ig.rS93jJ8Q9blO3_5QVRGWSS
 hQJeKtsxbHNzlk75z5HbKb7XlR1p5r.idIkXj75ABsKMYKpOiskwoP1D2RVUBb2E43RIS8.cM77Q
 oNJGkfkfnBZ4.u2yYape2YDdzDUQzlu3MlvmJEOZiK7XjKZkQ5QjFIW8RwHSQZQiN.BSy_xwq_Cc
 OgcKN_FgBoo6CgL5djpNqWnP2uDqLeX4J17rpgPqfmcPJu6Qy6Sdac9vjueiNiCbKLbF0b9sAx4b
 mFJ3_ExJElqwog4qY9Jz.ZxhGMkXmVQhWwzAYxGKIktf_ljmb_R9oXCy1XLMW3Yt1ql_Ti_3yfbm
 UHVPdluCSpMfzU87AwtCfv15.tsOOiiJhC4zR4HOvSE1SuKuDXwORLGvraTUfXiQ1O7KyEri6n8b
 753Qm32NqL5oylIPETeVxYpRp7P1w
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ffe1763e-d3af-4a28-ac8e-854791229561
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:20:40 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 311260ab82870132bd75579510690963;
          Sat, 21 Jun 2025 17:20:37 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 06/15] LSM: Exclusive secmark usage
Date: Sat, 21 Jun 2025 10:18:41 -0700
Message-ID: <20250621171851.5869-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
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
 security/lsm_init.c              |  6 ++++++
 security/selinux/hooks.c         |  4 +++-
 security/smack/smack.h           |  5 +++++
 security/smack/smack_lsm.c       |  3 ++-
 security/smack/smack_netfilter.c | 10 ++++++++--
 8 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5bc144c5f685..1ad9f8a86b10 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -122,6 +122,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
 	unsigned int lbs_tun_dev;
 	unsigned int lbs_bdev;
+	bool lbs_secmark; /* expressed desire for secmark use */
 };
 
 /*
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index c42ed8a73f1c..2e43e1e8303c 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,6 +51,11 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
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
index 4ba6db93e5b0..255d2e40386f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1291,7 +1291,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	/*
@@ -1407,7 +1407,7 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return 0;
 
 	return apparmor_secmark_check(ctx->label, OP_CONNECT, AA_MAY_CONNECT,
@@ -1423,6 +1423,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
 	.lbs_sock = sizeof(struct aa_sk_ctx),
+	.lbs_secmark = true,
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -2085,7 +2086,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	struct aa_sk_ctx *ctx;
 	struct sock *sk;
 
-	if (!skb->secmark)
+	if (!aa_secmark() || !skb->secmark)
 		return NF_ACCEPT;
 
 	sk = skb_to_full_sk(skb);
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 54166688efff..4e3944c68bc8 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -313,6 +313,12 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_xattr_count,
 			     &blob_sizes.lbs_xattr_count);
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	if (blobs->lbs_secmark) {
+		if (blob_sizes.lbs_secmark)
+			blobs->lbs_secmark = false;
+		else
+			blob_sizes.lbs_secmark = true;
+	}
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9f816e25198a..18ab1f13f3f9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -165,7 +165,8 @@ __setup("checkreqprot=", checkreqprot_setup);
  */
 static int selinux_secmark_enabled(void)
 {
-	return (selinux_policycap_alwaysnetwork() ||
+	return selinux_blob_sizes.lbs_secmark &&
+	       (selinux_policycap_alwaysnetwork() ||
 		atomic_read(&selinux_secmark_refcount));
 }
 
@@ -7160,6 +7161,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_secmark = true,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 709e0d6cd5e1..2f7b8d79b69f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -389,6 +389,11 @@ static inline int smk_inode_transmutable(const struct inode *isp)
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
index d363adead435..c8c173bb9cc3 100644
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
index 17ba578b1308..1dcaba0d224a 100644
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
 
 int __init smack_nf_ip_init(void)
 {
-	if (smack_enabled == 0)
+	if (smack_enabled == 0 || !smack_secmark())
 		return 0;
 
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
-- 
2.47.0

