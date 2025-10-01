Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625E23E229
	for <selinux@vger.kernel.org>; Wed,  1 Oct 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357034; cv=none; b=NqUvX/9wgM5IbI761H4/AmuE0Yz7X4SKD12zE1gnaDF9dVE7mkScC6/KTpGKQIR75gJiVWJrg86y8sXado3JIih9T6obtm4ei7tMYYyBwd6fHqlgKoJAgIxcQPMg86p1j3ua0UPSs4JHCpi9im4y5WJSXUipSCj/InpV3kAWSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357034; c=relaxed/simple;
	bh=O4vgldMJkfJVR3WKnspyouNxUzyUTx1wJmAoHTW+4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghwR3u1u5yw25uPHzXQ7c8pJ9RdpNaudsErcHwT3i+c/glR+UiRo8K9loEYwYViKMSNcEi2MtEjGJ8bPKonooEfY1dHZLowZLhyUew40/Z3+Zt8Y5oUgdrYOIHz7/eoWlQRvON7XQBPY1vxfh8/vK6UhsKYq8xt14lBibzLPS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i6N+ezxM; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i6N+ezxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759357032; bh=GHB9c/lhZUSJNqBAsqXREjpMs70P0O1p9YElSjptZzU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i6N+ezxMhZE9eTqe/Xm82FSJNoX7KJOfmVFs8WU7jYobxRj/BKEHkAA4sdM/I5KZpqw8DlUdZA5u551ExAl9LGKLdToaQj1aZMhATE9eNNhzHZg+2fVZFnYApEdqk4zc7cFtEiY82nfd2Y4sIamF0HYz1Sei36eLqnUWFl5i1+4Xfrk0mKOYuWbQm4TmTZ884aMaAKPvwzaB43wq1Nyf7XnhKrX8jWGxKFvc9aa9/xKsTw3JwrEGrLAKw7sl49DpETJPY5zGDg0WsU6ip5yUIM1oeKd0f5FjjBBfKbNFqC4AUfge0nrnCjGVAsgQVla20GAuCSa/3R8fi39/KD6t9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759357032; bh=82RCPzXt5vBdxiOPeo16jM0/wlDoO7HhNuItF5xWQjf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Y+pTgohflu4nWavkkosP6mqfswfLSDvQDTl25L+LNelMcrwHcJ8T008QTaFLjanKuSXYk3rUnubtIwrVBdJcKd7dwATEJlJaGTgq/J362/ecZxzIfhEl5P+rqX/sQoaOLy3AjWaet0MAgzcWITjVv3UXmg+oTKjjzO2HO5pfSqFXVEbz3LlsKHyLPcJrQtjGfdARxzrMwTIcyCEa3WR5VtACGmnHoEhQY3NHJI//dhm8WahiCWVaqT4K3UbsnDfLg6dnHt7l1LtQyv/8DAX9k8FTFyd9765o9m/q0g8gftkFaPU+Qavqbq1GTvZEWJ/WwvPb+r1qjAOYjnUpsorPXA==
X-YMail-OSG: m_NG6hYVM1l9VPNbPf6AaCglffgtfgGJp9RQeuwz1BOXfDZkAOfOK2sgSd8yfLO
 cWgZAS77A0I.Qp67rSksqqqwOU3CTsaGtjVZ9ZTdZ2nQ.ZmkRgNkzOurGMzucpE0v8yb1qmClRHu
 7KbpJctjF9E0z7qAdZMuuFnIQ0xwZwFhnHxq4ljfe1por1VGS10gBlgYoWTsrJsW26o5uBdeU.dC
 2yb4wOcHLQPLN.HJyj5KE1Sfyhtk.OYR8Qo8kISACbSmdsRBuN9SY1U8OmkHNzqu3DgTRuezA._5
 2qwmpd3lr0pCxRQl4QzfNnlCVbr7guwewMgPcpP45ZNdPdjRmvA3paL8u7UxJm_7v6N5dGHrC1P2
 pIxwkVxfS3PvzCLgbD2OKPddNC540V8rU32gDGxbozQA9mKN5u2Kd5uEHZ3_Fi9hMdYpMg1ElU.I
 COdEhtW5YgaemsTjDtjYuHR6C0e34MhA.tZUuLthrYVitCoP6QOREyFOKXRzMahHnLzjsBRiOkme
 MoqD73_SG.eeF5YhZmGc9JussRo62lyFxZTsUP6GH2Paj0Yau1iKMjfKgabBFaSd1P0I6KYgWwvn
 QT.Ooc7RUurj4Exx5H2bnZDVBlriJQYgEBQRuA1qepl96.pvoUPg1bh_6t5i79kbY.w.IBeYrjfE
 y75gkKrJosfDX24tgD846vr1CRG4NfKBzNdDjStsf6oVgnjp4CWv8FzbLJCA.hUGxdaUgsudeTEH
 st2yFfrIHUjM6PneMxMgoyr5LkOi4Rk9IcYIcIYIf4NYvMTg2RoaSo2ZrOFUHoIFyXTpe2dF8bHd
 xkT4XNv_aDTmKqPyoJgSBrxvVhmcGxzH3k1q.Tp8AQVELNdCS93dcKC4h3zR4_30r5raPGKbvg4l
 Abg6_7IXwmBOj.oNiy9YNuRTwFY_yBa9yuUBgv85R.lUDQ0NlJ5mDCqEK.iDzbIZWJfrtKbS0FpL
 4g5.nIE2pKWr_x9VsZGyTSUK4WPC2fAJf_BZ8hWopq57bOxqCPfINK6CTG9RQ5h6TZh_H3_IMlpf
 bH3LcMo9sXAY_msQ0wCqIjXwqb1spxpx0i4UIPSXRrnTKGyJPI3ITpTm2qIvP7ub_vvd19T_n05l
 jv5xtqlsqsetBskoRxlo3VlBCRXUxpDhtz.2bdbp_zOA.GbRAWMBa_iED1i1tEg0UlDFfYWw3UY5
 mRKudl80KV47TMsJHJ640rM4S8caYWm1wuh6gOML7t5p_sQGM_mzVq6bb3fA9jYMJ7t8So1Rdcsg
 eaRae4gPAsLOloep5yqn8uDsuHFUU79HUa1lthZ.c_gDk_RP7zzcRoenAJWC91Sjh3_yW32JMhYi
 qMCmmGeGALVnYLx.rz9HvyBcnV1MMLxrP6z7rvU1tB85_UgRAduH1BMPwR.p7zgJH7Ul.FC5ISbE
 eUoFoMftNQ9YnX2YM2fDJMSauRPK3U8oKKE8pt__hCOmJkXNA93YHlp2ewkiSB9M6TFddqwoUJmC
 SbSImMW9b40uVEJSq9tqZPEhBgbzsQqjhrCqgJBmv2Lgy4xSCIVP_ZIn51Iy.DB1SGNbqGdNh51t
 p2ozDqGB63ovNGE0mWl77W5o_fiQQK6eEMRuVVZigcmeezrFd47haJuCrn6HTqQkG5XjQQIJpjqg
 Oda4xyKqRJMWXkYrwRkuUa_nny4wSiBkORM4pAD3L7sKrJR4nNtiH7_alDjutc84P1H5DsjM5Jfq
 KPip1L3j09UMEctonekdeqzIW18yzPJ.CaAa7sXqFivKHj4Ot6ZSdLyKPjQGQNdv59yqr6BeGNje
 AFhceYumV9OzMZLKuJbkgMEcgEMkdI0k00j1162WWzpsrHooBLFij.32V2lYrp3pwIqTrTr_YmTD
 Gb2FzTRitWoG4lc02WDe8RO4iGI9uT2S1mHz4DZrJ3RnZMjFxedI_e92lnw4qBraXcW1AxwPjEI2
 jmQAJkNShYHuU9Lnb7DQ0CvXwno0lpsx0LQso6OYp_xKqgS7BQis3NRDLCU1r_qpNSxsOmm6LZ6m
 UoimNexyfW4SOQOXuZnPTBWfDHQTYa4jOJhlt7NnUB2BEQbSVJ61fC2C8pzQYAqqR3K3P98OiRkT
 cZg6kCzIUn8o.eGfWo4U0KeBdtCDla8KTdTjKBBxskG8BfnP0LJT7me17JPPwwBVKahf5WqkjV1b
 2.eNeJklitDO.QD1vtCQVBJG7TKkxIZV0IEvk18hEBAYS.INX_4lJEukYJp8A6EhH9_eUs3I4Vsy
 8cCZiL_bVh_m.lTsw52M2kfe8cICzqNXVtZxiZ7He86iZP5E4FHTQnHXnzr0vspKZHtH_yZGxMNi
 nC25xoB5668mPUunSpbIxMGPG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: deeb574e-584b-4ed3-bea1-ed12d77e7f16
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 1 Oct 2025 22:17:12 +0000
Received: by hermes--production-gq1-66b66ffd5-4kj8j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49e653aa15d96dc3c9cb4665110aa952;
          Wed, 01 Oct 2025 21:56:56 +0000 (UTC)
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
Subject: [PATCH 2/2] LSM: Allow reservation of netlabel
Date: Wed,  1 Oct 2025 14:56:43 -0700
Message-ID: <20251001215643.31465-3-casey@schaufler-ca.com>
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

Allow LSMs to request exclusive access to the netlabel facility.
Provide mechanism for LSMs to determine if they have access to
netlabel. Update the current users of netlabel, SELinux and Smack,
to use and respect the exclusive use of netlabel.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           |  1 +
 security/security.c                 |  6 +++++
 security/selinux/hooks.c            |  7 +++---
 security/selinux/include/netlabel.h |  5 ++++
 security/selinux/netlabel.c         |  4 ++--
 security/smack/smack.h              |  5 ++++
 security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
 security/smack/smackfs.c            | 20 +++++++++++++++-
 8 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 69c1b509577a..e49b5617383f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -117,6 +117,7 @@ struct lsm_blob_sizes {
 	int lbs_tun_dev;
 	int lbs_bdev;
 	bool lbs_secmark; /* expressed desire for secmark use */
+	bool lbs_netlabel; /* expressed desire for netlabel use */
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index e59e3d403de6..9eca10844b56 100644
--- a/security/security.c
+++ b/security/security.c
@@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		else
 			blob_sizes.lbs_secmark = true;
 	}
+	if (needed->lbs_netlabel) {
+		if (blob_sizes.lbs_netlabel)
+			needed->lbs_netlabel = false;
+		else
+			blob_sizes.lbs_netlabel = true;
+	}
 }
 
 /* Prepare LSM for initialization. */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6db7d8effb..24edeef41d25 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -182,7 +182,7 @@ static int selinux_secmark_enabled(void)
 static int selinux_peerlbl_enabled(void)
 {
 	return (selinux_policycap_alwaysnetwork() ||
-		netlbl_enabled() || selinux_xfrm_enabled());
+		selinux_netlbl_enabled() || selinux_xfrm_enabled());
 }
 
 static int selinux_netcache_avc_callback(u32 event)
@@ -5863,7 +5863,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_enabled())
+	if (selinux_netlbl_enabled())
 		/* we do this in the FORWARD path and not the POST_ROUTING
 		 * path because we want to make sure we apply the necessary
 		 * labeling before IPsec is applied so we can leverage AH
@@ -5880,7 +5880,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	struct sock *sk;
 	u32 sid;
 
-	if (!netlbl_enabled())
+	if (!selinux_netlbl_enabled())
 		return NF_ACCEPT;
 
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
@@ -7185,6 +7185,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
 	.lbs_secmark = true,
+	.lbs_netlabel = true,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 5731c0dcd3e8..5be82aa8e7ca 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -134,4 +134,9 @@ static inline int selinux_netlbl_socket_connect_locked(struct sock *sk,
 }
 #endif /* CONFIG_NETLABEL */
 
+static inline bool selinux_netlbl_enabled(void)
+{
+	return selinux_blob_sizes.lbs_netlabel && netlbl_enabled();
+}
+
 #endif
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index d51dfe892312..a6c58b8e7bfd 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -199,7 +199,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	int rc;
 	struct netlbl_lsm_secattr secattr;
 
-	if (!netlbl_enabled()) {
+	if (!selinux_netlbl_enabled()) {
 		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
@@ -444,7 +444,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 	u32 perm;
 	struct netlbl_lsm_secattr secattr;
 
-	if (!netlbl_enabled())
+	if (!selinux_netlbl_enabled())
 		return 0;
 
 	netlbl_secattr_init(&secattr);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 89bf62ad60f1..46e513f27e0a 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -374,6 +374,11 @@ static inline struct smack_known **smack_key(const struct key *key)
 }
 #endif /* CONFIG_KEYS */
 
+static inline bool smack_netlabel(void)
+{
+	return smack_blob_sizes.lbs_netlabel;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ee86818633c1..4cbdb8c91a07 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2575,6 +2575,9 @@ static int smack_netlbl_add(struct sock *sk)
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
+	if (!smack_netlabel())
+		return 0;
+
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
@@ -2606,6 +2609,9 @@ static void smack_netlbl_delete(struct sock *sk)
 {
 	struct socket_smack *ssp = smack_sock(sk);
 
+	if (!smack_netlabel())
+		return;
+
 	/*
 	 * Take the label off the socket if one is set.
 	 */
@@ -2656,7 +2662,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 		/*
 		 * Clear the socket netlabel if it's set.
 		 */
-		if (!rc)
+		if (!rc && smack_netlabel())
 			smack_netlbl_delete(sk);
 	}
 	rcu_read_unlock();
@@ -3982,6 +3988,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 	int acat;
 	int kcat;
 
+	if (!smack_netlabel())
+		return smack_net_ambient;
 	/*
 	 * Netlabel found it in the cache.
 	 */
@@ -4132,6 +4140,9 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp = NULL;
 
+	if (!smack_netlabel())
+		return NULL;
+
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
@@ -4202,7 +4213,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-		if (rc != 0)
+		if (rc != 0 && smack_netlabel())
 			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4390,7 +4401,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	if (skp == NULL) {
 		skp = smack_from_netlbl(sk, family, skb);
 		if (skp == NULL)
-			skp = &smack_known_huh;
+			skp = smack_net_ambient;
 	}
 
 #ifdef CONFIG_AUDIT
@@ -4411,8 +4422,11 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	/*
 	 * Save the peer's label in the request_sock so we can later setup
 	 * smk_packet in the child socket so that SO_PEERCRED can report it.
+	 *
+	 * Only do this if Smack is using netlabel.
 	 */
-	req->peer_secid = skp->smk_secid;
+	if (smack_netlabel())
+		req->peer_secid = skp->smk_secid;
 
 	/*
 	 * We need to decide if we want to label the incoming connection here
@@ -4425,10 +4439,13 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	hskp = smack_ipv4host_label(&addr);
 	rcu_read_unlock();
 
-	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
-	else
-		netlbl_req_delattr(req);
+	if (smack_netlabel()) {
+		if (hskp == NULL)
+			rc = netlbl_req_setattr(req,
+						&ssp->smk_out->smk_netlabel);
+		else
+			netlbl_req_delattr(req);
+	}
 
 	return rc;
 }
@@ -4446,7 +4463,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
-	if (req->peer_secid != 0) {
+	if (smack_netlabel() && req->peer_secid != 0) {
 		skp = smack_from_secid(req->peer_secid);
 		ssp->smk_packet = skp;
 	} else
@@ -5031,6 +5048,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 	.lbs_secmark = true,
+	.lbs_netlabel = true,
 };
 
 static const struct lsm_id smack_lsmid = {
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index b1e5e62f5cbd..b2487f676e0a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -79,7 +79,7 @@ static DEFINE_MUTEX(smk_net6addr_lock);
  * If it isn't somehow marked, use this.
  * It can be reset via smackfs/ambient
  */
-struct smack_known *smack_net_ambient;
+struct smack_known *smack_net_ambient = &smack_known_floor;
 
 /*
  * This is the level in a CIPSO header that indicates a
@@ -671,6 +671,9 @@ static void smk_cipso_doi(void)
 	struct cipso_v4_doi *doip;
 	struct netlbl_audit nai;
 
+	if (!smack_netlabel())
+		return;
+
 	smk_netlabel_audit_set(&nai);
 
 	rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
@@ -711,6 +714,9 @@ static void smk_unlbl_ambient(char *oldambient)
 	int rc;
 	struct netlbl_audit nai;
 
+	if (!smack_netlabel())
+		return;
+
 	smk_netlabel_audit_set(&nai);
 
 	if (oldambient != NULL) {
@@ -834,6 +840,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (format == SMK_FIXED24_FMT &&
@@ -1156,6 +1164,8 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
@@ -1414,6 +1424,8 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 	 */
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 	if (*ppos != 0)
 		return -EINVAL;
 	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
@@ -1585,6 +1597,8 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
@@ -1652,6 +1666,8 @@ static ssize_t smk_write_direct(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
@@ -1730,6 +1746,8 @@ static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (!smack_netlabel())
+		return -EINVAL;
 
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
-- 
2.51.0

