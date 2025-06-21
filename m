Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417082459D1
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526640; cv=none; b=nfu5QkG/cdbi2tLCTAp+HDdXttDk//l0FthePJBww164QyTOel8AJMcCn5Yp2pzFPW5wBcrVPeAoenY1zWNFbqkq65vO/HSrPglw6pJgS9AOk+Ip2GzolAd2fVJkb1cisUiSo1dNWnidyO0hX6l60HLg8yziQCdD/uv8JF/dEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526640; c=relaxed/simple;
	bh=WCex6USUjchIBX3agUhZ21r2drcQgrb/zwis2EoHBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PapBojKJ1nsWXM9QMzfZibaDSi2/XEryVjClwRxreNAQL95geVYI9KTpStF5pz03KYnKJ7D2VIN5GHDC1T3liU+Btj2++aLWsCieJqfvBpPEkhDPYCtSpSyBbWsYO8cGM3ZBObzSRT0i9denl32fN6RwLdVEbTBvbfa/iVfRYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BavUeyvv; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BavUeyvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526637; bh=/X9aAotKwhvZSj8lCSMa1mezz/JdY5QwcNE+kbuMXz0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BavUeyvvKetASYW+Ks78y/wpBjdMesLCEdxtpnbHcW/8crwEV7+GfUSrwgFOwuGuBQExoYsSK3dNt5oWzMRkFwiG1p7PGF9GvpIbAjRNWA8zl/OpCjo7uv705WN+ULx3+jA8A1HqmDT5CefazI0kkrRysDI84wSDq2HGiIqBz0bxA1jm/arQkRpps/kn2bL1c3NH2z1u/nyOhpzgwZUug8CDPmNJPncKIB1YXJ83p9tU8jO+TeVFhK6idSCtQ9zpMxw3/0qJjhams4KwSC611BCTQP/uv9v+Jyki4dsJLsdthKm4SBd4HTZDpMJ1170PTRD3eh7N0YLGIGDEeV6Klg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526637; bh=gsUloo5tYjuY1bMON3q4xynOB2TMU483/jAQmtCEmhn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HszgQfES8M4keViwjQrf3mOiCZuDFey/XH+XH9WcfKQu4Sa3j4EEHV2k4ObgW/zulaqZKrb1q70J9AG4KUnEVcDZH5K2l6XS3TSCBGHKoyRDzoq6lpkw9+3FdsFKEFtkhIxEzb6sm9T7eHVoc/c10TjiuhmdrGuEjz33G37BzqwKlYl/wix725rnsvPnfBR6iG/fDhQn6zPK5aBjwlRqRSGUFolFB85P0/KQ2TU3Qc+vNVugG2M5eNF6ilC2YwpJPMhkF5Q9dZ8l0KjLpJfNc1bmBBFzI9lxeRXUfzky00HtT2SPB71foqMBzoTaZ450LTGnOBigaqwQChd4QdGnUA==
X-YMail-OSG: s43fKssVM1mSEWJVNIFZDWhrYBYzWkiC_5fhmz_1pBxKCNbsh.tehhqnkGuwEN.
 u0G5kBoVGcCZGi7dfptupHdElrlWhQVogvgXLOyhNB2CUDCRSKNLAtKswhXvbX4LNU0JgGU0vTZz
 CmvWqtcgU6NIYvtD4LLB7KBgbVDAthiOz.dVs4dtUc.FGFgo4RIXOciu2pw7Gv6Cr_OxlhrgNkF5
 345K_ZH_a7qY1HuCuFMv4Jas5RM5HU10qCOnGr1fCuGMcB.wlHC26L0tbwG.lZS43rmEmIjwblnw
 aeE.paRS_PCAdECMwJG0uFAvp3avJ.SAU9ps_DiN83yQMdrYwaOPleKEEQXe.huuKjkQzDtUXcyS
 CTYKPetz4Ti1o487ctV1802w2tVdlHithDI1w8IbXl_.3gPlaH1hqvpFvrbWA58oALpw5SLb3Usw
 d_IwnarLD6NjncSf7Gwgv5RlPwkj94SC.i5DXorsy.YDTEC7HxFBpJm7mOmMtFLS9Hm74lzPK9vA
 rYi2CE4AoNerqi7EriHG62VqvgpSHaNtrcBU8Ux4ZRzwyGDe.pJh2nub5Fz9BJt9GuJjNJQqH8EQ
 E4ICvcRLsjzCy1YDoTRCZmZrPSM.vlp0NHlyT2aMGaZq6TCkH3PaD2KJy_7Sbm_2fHcXeTShc88v
 1P.0dju_F2QbEhmXg7mKpI4X7J7VmpGH_bSsJDKxoyFgQvQj5G_JbJdl_nYXynoRv0qWSdFTIUsy
 ZkgkZwrcn152yLXaeX1HD_U6XzgZQKPTUNL8ADeiqQIxtpwqUcoMJIsQa7HSCX923uiqUM59e28R
 F9MnYchERY1tzF93ty4Wh3.0SMkBHXVrxQH6BvVWBgBkW3q0JfWEORh8YSj.n131Ble7GM1F6QWP
 yI0WiPxvEXbR7Df8sldMQ6X6s3_n.3.9Vb5hr1jrVc0HESfF5XWey02ITNdKZS0wSme0V4i6.zTt
 nOQjnJTD6n_uPY1Edw54gOFhqjUVypKLiINrE7nvI5hSvBTKBFuaGv6l9AHTohxXd8IprHFVrr..
 qepqS1BuGShJf9.gkzG_nWk7ZueJ0SOFEp50ZUqLKLtnnZ7X1.dWQ22c9CJ5cBkcn9BCitNAbRYV
 VQMvEh0eeV6OJrEzc0hFG6z8k6cdAHe1upWHyHjy_XqFxOfwG4VuK5_rRiim1vqiWl1JqVKxKXL6
 t4pAzWgnQCVSsjv6DK7XbuEZo5KK.MIuagPr0Ad5N9EP5NC30a68_OtFjXgza8J1EJM3VlXJ_g4A
 a5ZlNcuS82m36b9wdDcnwXRNyun2uN.nrSICBJgWrOxgZ.Heiv7vg3Hm8opCRiB3JcWmekcHhqSh
 EcpsjCfVM7Uq5mPVIbT7FzQ9okabxA665R3jy6CJH8y4OUNfniyq4HwSaS0RimMDol_5.VmbgSs0
 T5XybRetKqgE7UHhaWOx34tdYZh45jfpX3F.ytCH93ZqQ0HnGqa94vEkn8wDQKdUmlUcQ.m.2g2p
 TTgtzbCKEnKMTikn0_a5VXI.Thm4uvaqMkehSFfp2gL3iq9jPs1ta4mWiex_GPWhgKnZFwV4SPJ5
 IzTOCBm11loI2pueKvQLLgp0biw3Q8CB1CdvtodNy__zhOdCXdxbyk3BEItiU9hxQIQJtp4hXSqe
 5719BO982auhtaQcg3zP9KmU8numQw6MjNnx_37hokgcFP2FaAswIXjxVUjKpRaPliQYEyhurpv5
 MJyMPaKM_eHx29LO7g8h5c8Cjr5MO5Du5IBRd6897NE9EwfC1q0K64ZuH9IZL2fHTE6H6JNPz2II
 SjFrwQkZG_BYj38UH9CEtbk3AdPB25bSaLqtk40A_x96hjIaS9pn2E62BToaUhpn5KO9otjeuyNI
 7ltDnIgc7PdFxmwuUpkTTpJ14sknQTa5HUEFKhSdr4MaXDoZdvZcTg3HtAcKK0RJ4QgpKfB.nC_.
 lrc9gYY3d.gmZVWavjejZiTGETXUIez1njZfdjUqOdv3M74yt4VtYIvHfpcs2GTCIKRLsbFhZ3nS
 .pT4pAQajS25ro_SCVTbIQx66acAXSZbnDs7WvBa1tmLYccz92ykviHauZdjGaXJwDZ.OhIAj5OC
 zm4nscSL0kBiW_5V4snD3Q_4A..ctsYcfHGAPjhImMzgQVSLiCfTlE68Ymili4ob9apuisvX5OQC
 gYjoV1.3sr5Umf1nVW2z3cVFjlFXuW4xmjPvRJkffuyxe22Rggn_thfyBeLo76BsDtr75gvDg_HK
 dwcwAYyTw_FrpAtWsuwxVj1w9a5VF9_5LqtgbHWnCz7._adG69rM3j0tOo.0YRNHWvQF8VjfPiza
 iUuTZ1XxiDOG4nn6IRIuJZVT_3.VDYgi78GtJfg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f3d2ab60-019c-4839-b765-23bd0792f2de
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:23:57 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5256f3ef263223dbc5f852ba156c094e;
          Sat, 21 Jun 2025 17:23:51 +0000 (UTC)
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
Subject: [RFC PATCH 12/15] LSM: Allow reservation of netlabel
Date: Sat, 21 Jun 2025 10:18:47 -0700
Message-ID: <20250621171851.5869-13-casey@schaufler-ca.com>
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

Allow LSMs to request exclusive access to the netlabel facility.
Provide mechanism for LSMs to determine if they have access to
netlabel. Update the current users of netlabel, SELinux and Smack,
to use and respect the exclusive use of netlabel.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           |  1 +
 security/lsm_init.c                 |  6 +++++
 security/selinux/hooks.c            |  7 +++---
 security/selinux/include/netlabel.h |  5 ++++
 security/selinux/netlabel.c         |  4 ++--
 security/smack/smack.h              |  5 ++++
 security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
 security/smack/smackfs.c            | 20 +++++++++++++++-
 8 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 38f89762c0df..06e840fd4b63 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -124,6 +124,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_bdev;
 	unsigned int lbs_mnt_opts;
 	bool lbs_secmark; /* expressed desire for secmark use */
+	bool lbs_netlabel; /* expressed desire for netlabel use */
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index d27a457627ed..784f8296966f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -320,6 +320,12 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 		else
 			blob_sizes.lbs_secmark = true;
 	}
+	if (blobs->lbs_netlabel) {
+		if (blob_sizes.lbs_netlabel)
+			blobs->lbs_netlabel = false;
+		else
+			blob_sizes.lbs_netlabel = true;
+	}
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 636a38449253..9578b63bbd2a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -183,7 +183,7 @@ static int selinux_secmark_enabled(void)
 static int selinux_peerlbl_enabled(void)
 {
 	return (selinux_policycap_alwaysnetwork() ||
-		netlbl_enabled() || selinux_xfrm_enabled());
+		selinux_netlbl_enabled() || selinux_xfrm_enabled());
 }
 
 static int selinux_netcache_avc_callback(u32 event)
@@ -5860,7 +5860,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_enabled())
+	if (selinux_netlbl_enabled())
 		/* we do this in the FORWARD path and not the POST_ROUTING
 		 * path because we want to make sure we apply the necessary
 		 * labeling before IPsec is applied so we can leverage AH
@@ -5877,7 +5877,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	struct sock *sk;
 	u32 sid;
 
-	if (!netlbl_enabled())
+	if (!selinux_netlbl_enabled())
 		return NF_ACCEPT;
 
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
@@ -7183,6 +7183,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_ib = sizeof(struct ib_security_struct),
 	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
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
index 2f7b8d79b69f..de707d481e39 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -380,6 +380,11 @@ static inline struct smack_known **smack_key(const struct key *key)
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
index ced66130fb7d..650f2700160f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2598,6 +2598,9 @@ static int smack_netlbl_add(struct sock *sk)
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
+	if (!smack_netlabel())
+		return 0;
+
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
@@ -2629,6 +2632,9 @@ static void smack_netlbl_delete(struct sock *sk)
 {
 	struct socket_smack *ssp = smack_sock(sk);
 
+	if (!smack_netlabel())
+		return;
+
 	/*
 	 * Take the label off the socket if one is set.
 	 */
@@ -2679,7 +2685,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 		/*
 		 * Clear the socket netlabel if it's set.
 		 */
-		if (!rc)
+		if (!rc && smack_netlabel())
 			smack_netlbl_delete(sk);
 	}
 	rcu_read_unlock();
@@ -4005,6 +4011,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 	int acat;
 	int kcat;
 
+	if (!smack_netlabel())
+		return smack_net_ambient;
 	/*
 	 * Netlabel found it in the cache.
 	 */
@@ -4155,6 +4163,9 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp = NULL;
 
+	if (!smack_netlabel())
+		return NULL;
+
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
@@ -4225,7 +4236,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-		if (rc != 0)
+		if (rc != 0 && smack_netlabel())
 			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4413,7 +4424,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	if (skp == NULL) {
 		skp = smack_from_netlbl(sk, family, skb);
 		if (skp == NULL)
-			skp = &smack_known_huh;
+			skp = smack_net_ambient;
 	}
 
 #ifdef CONFIG_AUDIT
@@ -4434,8 +4445,11 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
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
@@ -4448,10 +4462,13 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
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
@@ -4469,7 +4486,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
-	if (req->peer_secid != 0) {
+	if (smack_netlabel() && req->peer_secid != 0) {
 		skp = smack_from_secid(req->peer_secid);
 		ssp->smk_packet = skp;
 	} else
@@ -5055,6 +5072,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_secmark = true,
+	.lbs_netlabel = true,
 };
 
 static const struct lsm_id smack_lsmid = {
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 405ace6db109..2e43e9670265 100644
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
2.47.0

