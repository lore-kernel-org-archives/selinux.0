Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EDFC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07BC2133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qiojpj9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfDIVlw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:52 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:34174
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbfDIVlv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846102; bh=Bz4Myh+vsbujN22ch93KZc6mzSg5aPOU0wuPwMKBSrE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qiojpj9WNyp6BZprYbc56V/m7vo9AuZ1T9eEgmJAHar8fRkyxJ0Z3vtI7HtvuTKiubOyYSanROKriVXfcbPQoJVWeSEjemPiEjApBvbwSmuLVHp6IpccXOvPjxRDiw3zFlbo56qrtFNtKbegNgFymKao66JnuOc3JaSLmNLhR/U0KQQVmvTPZchY8aLu3gsJiAnbzDy99xoPASTfgaoWW7KMfihTCtjjx5BMsJm+AIx6Cm3fVybKWtiIQAriyNZg9YxGQlHgRCrQVoFLtwa+7ov4J+AIHewLJ8VGkaJL7+Lk3GyMSMShbHJsPIx5+4Vq8gdaA1eF/ZZqRpx3dQkQRg==
X-YMail-OSG: YuhJvy4VM1kOp0WPRE6VdQVnXDwVxdp_W8db11kgOHVofUDvewJztuAweYkJK7a
 Gm4.rG8fXHTZlvj6A2od94BYEZiloeYkn5YnlQMo8sQCuMd1n04jMm9t._NeNuJBDXPeWpcASSt0
 _eZaiZOmdCpfh.ASlkd8p_vfDH6QNH_lyr11Z.6B3_mgK18AVAHlV7G_2o2.qK_RO7PQfERt4r1I
 x.1rLss1STtVHIO2M_6uIuvnzkZHBSaRnU8IwEfJf2Hwd04bo9T5h0SRmbGuYNhcy94YlOjclsVT
 GfbK2gc54RFJj020CSex8IfwTEa.geAfWemhWM7i6fz_eZcUZK.RcXgQpdJjKipmf1yud3a5.z0S
 r1HsNBdVg5E6RzQapM5PSRtbKlxL6pOUTbZdQuQJAEE3B4WFUnzzeICyIm78YzgvHF43ydbPIk6n
 Wj1VkHEEHA7_1wSEWg0VWNmBR6qRZlq6fAfCx4Vcu6seKPTDF_Tnj9ROnBTFkBZXE4sAWFGe88Dt
 .SG6WfIZXJIyoSl2FRLXnkN.oQh3OPQVb2HqBF.XT896RlJQC5WMNA1T3bV2ZvO.mJDD30LM0nXG
 XXZn600wPmOFzkAL3w6IPkN07eau6euYwOSQkF1b8_w3CHh_0ZLxlirXKF3dzrju3P5w_nSCbsWX
 KQ0nc7zPK.Lz_F4fVlFqwnF8GkIvncwxuRHtGFvGPwWg.slnsz.NB8FjK9AQRGmBIjhijfe0yvnI
 IwhmUxSDfcIOZ_BEo_Kf6ucyh33ByzZJro7tidHgMhpulRcXYHRpDjdozdkzxr1QBK5xr7NX6wNO
 MD7CEtT43yUpBDcATj__zsZK_ug3dPgbQEVxNxiiFLPtPioZaH_tMMdiORpQrdXAQdJT664Iwbdf
 vzDhZ_CDSJ_6vIad2PRP6XGko.GI0nW5qm5F6q6iQOR32PB.WbLHPAorJvNrcIQhpYz8O4jsA1Qw
 4.IQ7vyF11hQ2FeJjxNRZR7CG6sWgrCT.A917C4Cz3p93GHlmw2D1mqi7iQMx3GCqq.faoSrbRo.
 1D3qNIxce9DX3_sgxR1B1NwgptjgDHYXiPQznhFtvCfB4vLeWoCQX25rBy98qZNlIMe08hWOVTI.
 ASksDpqAflVptIBcYzJ7AOs5idUTIF8XQitY3thubGP1VksGPvlDeLFawvTBTZA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:42 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 909a163ce0f03793fff6be9a79785446;
          Tue, 09 Apr 2019 21:41:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 46/59] LSM: Use lsm_context in security_secctx_to_secid
Date:   Tue,  9 Apr 2019 14:39:33 -0700
Message-Id: <20190409213946.1667-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secctx_to_secid to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  6 ++----
 kernel/cred.c                     |  5 ++++-
 net/netfilter/nft_meta.c          |  5 ++++-
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 16 ++++++++--------
 security/security.c               |  8 ++------
 6 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b9f824952748..9a842a20b4b7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -434,8 +434,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l);
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1219,8 +1218,7 @@ static inline int security_secid_to_secctx(struct lsm_export *l,
 	return -EOPNOTSUPP;
 }
 
-static inline int security_secctx_to_secid(const char *secdata,
-					   u32 seclen,
+static inline int security_secctx_to_secid(struct lsm_context *cp,
 					   struct lsm_export *l)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/cred.c b/kernel/cred.c
index 7792538b1ca6..ebae67fdd4d0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -724,10 +724,13 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsm_context lc;
 	struct lsm_export le;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &le);
+	lc.context = secctx;
+	lc.len = strlen(secctx);
+	ret = security_secctx_to_secid(&lc, &le);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index a1d3dab5bc25..f25b26318d72 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -577,11 +577,14 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
 	struct lsm_export le;
+	struct lsm_context lc;
 	u32 tmp_secid = 0;
 	int err;
 
 	lsm_export_init(&le);
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
+	lc.context = priv->ctx;
+	lc.len = strlen(priv->ctx);
+	err = security_secctx_to_secid(&lc, &le);
 	if (err)
 		return err;
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 9a2a97c200a2..a06e50535194 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -50,13 +50,16 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
 	struct lsm_export le;
+	struct lsm_context lc;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	lsm_export_init(&le);
-	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
+	lc.context = info->secctx;
+	lc.len = strlen(info->secctx);
+	err = security_secctx_to_secid(&lc, &le);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index f79ab91bf25e..707ea5a364b0 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -894,6 +894,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	struct lsm_export le;
+	struct lsm_context lc;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -914,10 +915,9 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
-	ret_val = security_secctx_to_secid(
-		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &le);
+	lc.context = nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	lc.len = nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	ret_val = security_secctx_to_secid(&lc, &le);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -945,6 +945,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	struct lsm_export le;
+	struct lsm_context lc;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -963,10 +964,9 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
-	ret_val = security_secctx_to_secid(
-		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &le);
+	lc.context = nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	lc.len = nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	ret_val = security_secctx_to_secid(&lc, &le);
 	if (ret_val != 0)
 		return ret_val;
 
diff --git a/security/security.c b/security/security.c
index b7e15cbd4021..f51ea4a134ae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,15 +2002,11 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l)
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-	struct lsm_context lc;
 
-	lc.context = secdata;
-	lc.len = seclen;
 	lsm_export_init(l);
-	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
+	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.19.1

