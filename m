Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCABC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9EB21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z0hj+yUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDSAsL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:11 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:44569 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfDSAsL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634889; bh=iZvk5ymjUnVfkF81CAYui3SoSjojdju46pk91UHS7sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z0hj+yUZioT934l5fYkwGnuNs7qU/N2S6w1befaSPhyxqx/XLmDChauaRHdarmg7XsTXqxE2pEz9kwXAlozmk/Lbt/G0tIwif0kq8uTf7nKDfnrlP3GfX/GUAU1SOPmdcVQb1GvShmPZCdlLD8RqCAFeg2deCEyRJ8wRMUl6Wx4wsPEbN3pqrqYwf1BTaczqg9eaDr4cTMhIRgN7+hCUxFaHk/wI6GPgmPd1u4DFV9idNw7fjCCYNjDZPYyF9H+7AIuat2V5MsZ6ZsUiJ+wCmbwwYVzTNb7EdTiHp8yiO4xPq7tR6HubrZJU1NYrqqVIQMzw0e+qGNMaOi3CbMa6yw==
X-YMail-OSG: Ftz_42YVM1nJ7FSKLwgjWTRbtTVIiYskwdLaJb3gnu3Z5hT3nRiQf909oSHxu03
 M7ujvm27lkMUHeu3FgiDSgpzrTCbzMWiDdF01WwuDNcafnT_gf4VZpoGHHPxRyMOqkQFXRx04P0K
 wNs1Nqe9gk2RHyTicT0MIbFNW0RjNa7c4gqlCJKoqSLJYZtxiKT8w3NZWvs8WwsFm.UYTb8z8VPS
 ug.UcARpT4BpHUAczXEuaSp1.R2SXgWxuCVFawauqWzq.3kzRijdMbuyY8302hszDaAuGaRxbAUZ
 t2Q9eWXyLZ628cbdpabCPhXelLhjchzHNEv6qsGY0kuASyOUDqZ9QNPueUZ3PNcGFdezDvxumIT.
 idpWXeypkTMK5hhVofyad9V4p4JBrz5v.QfJ8kqq0qnffKqIhjI6VML_5gzvqF2g3JEqkfhjs0Kw
 uooLnsuur5pbOqdg94O0CpbMZI4Alc73vH1lvGMO39g9nBAtKW.JgIKqtumyLEAFPswST0_TnseO
 r.WOfmtI9tDKpyTihnyh1y873m1l4DEWQc.2b0LTL95lP.sb0Q6gMViCXulyBVBdQNiUKrfGfyxe
 _yabEhiVHKLpb39P.MbUdr38oE56tVJfKe3A8jZaNpXh1ecMQIVUOU7zSt40AKy1hCqVd3b92rwa
 j.GQl4uOciFMtGDE1L7sbPm89DPyg_sJN.S7m4qEwimjze6NMAIHsg3SU8mSM7GRignloUUQbmu7
 Ed._T1siGchTENebdSJA7AZs9wvsyyI77T_0mSvkwzA6I3Z6LMnT.w6C.0PM2dNYtwuqmz2d3OF8
 yXfs4Q.4Liisvd63x_PdSE_zAeFtPPqtIXHHBEXPOApHx_f4Ok98Rxonm4qly8j7o.YEE.P_Of8g
 morf0fhKlQ4U7J3MtsNdfLq9uHedDvuNFBBu58RLg6axI74UByGyw.UZRoM04yZ0hisl5NkcolH2
 S_8JG.gCJA3uOTWNb2TW40n1QiIxrkO6P7EH7ai4dYS.T24Yiv3q475LMG1Qi9x039RRa0LrUf_r
 MXbWyVNSwqUJFGf2na2refIr9bhowCYcBkST6LHkHPcKWs9UJ4VzQ9VhsOmkYkZceePA7Li0fGgk
 Y5JHsdKcXxRz1Cl.9pg6Isn_JDZGocM2_dgn27yIiMuAK69U4fWK_pCoXvarh9bORm0PT3G876Xj
 Vyij7_ag8QpRkgA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 354bec82e8db1938f39555b4d4e62c9d;
          Fri, 19 Apr 2019 00:48:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 46/90] LSM: Use lsm_context in security_secctx_to_secid
Date:   Thu, 18 Apr 2019 17:45:33 -0700
Message-Id: <20190419004617.64627-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 90d1ff7a2fe6..3f757b2d8275 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -432,8 +432,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l);
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1217,8 +1216,7 @@ static inline int security_secid_to_secctx(struct lsm_export *l,
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
index b37bce99107c..9f32865e7329 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1987,15 +1987,11 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
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

