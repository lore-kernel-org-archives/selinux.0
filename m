Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED4C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26C42082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RYM/YZTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIVkh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:37 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:43503
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=nhyQ5HEMViXMwzj11P6PbXR0lPC7xmZwGngBq91che4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RYM/YZTVP2CUe9PdTwmWc0xz16rtXHOTDxjrrrRXaQaCpegPXbefTFWwdZ2OpjoDcVkoyGM7dto7cND78XeZi/N+vaYA6cTL67o/SIwPaqqM/bGzGwEuYXa/q3Q1O9LIoOmiZDokUEppFL0+XN8qjqNLi2SV88Xo9w77sE8K+WEtcnigraVCy04XX652aP+4PyRLaPtOkHe9nrz8mI2yjlTbyYz/FhegGNaWRlCnOYmrOA8ZHO7MzqQAtqTDGTZnw2e+ReJ+7ipA5FR25zmuDirptFy08lnGSYarZ0a0nLXhiZeAOKO7jVQMTEb2DNaXsEyjVtfl5MIG382obcJ4AA==
X-YMail-OSG: HpMg8KcVM1l4JpgPyp97MBeZK.a55Kkbz4bZ6L2BoIWqMaTvXo3t1Y9mVvUe7wf
 1bPbubdxvZ_RW0zDBZroxj.Ets.k1GGpNy8ZvPHVpwJLoyYHXYBQEpPOi3mKRwJ62CEY._gjx7z.
 JT7tmy_tpTrPaKkPbXz3TH7e_vx7SkhJ3pbbsKcE2vuNTPJWdZtiS89SlkYzpMGuVqc7U48D1aH5
 kQ3tkt18VHAOh3mQVc92UZ7j7ooY_ItTgPCrsCZaKR_JDZ.a8mqBYNxS2nYGGOAAvlbQvEtpyRk6
 7hl.EaxnxXPiwj5q6r6D2l5d5gGcGdY_C7DB5D0aHo9TNfn48ylPcPevRkJ5fGMRs2Tp630hyjN.
 KiV2Qod7UC7gkAfR2T_tUCG.jyjUUShiTkhZE9BozFRMWkM7Ir1JYd2QoV0EFCVit4BxSGqiVUrQ
 3Jtjgk7TUcffEvxun.j8ef7W..b7ebPPjDQZ4Xastb.2.Ztm0fiDR35WJE.gOr5XPS2fczud.6IN
 FqMnOm8o2Q0i12fo2VGBxM214Qe8cZezd35TGpqsM553DUkbM2muHA.0z0bivk72fVWoVtaR3tY5
 PTtJdXefA6MOgN7mLd8WUyXAk.wxnauJl8HMj7GpL3Z26RmgjzOGiN_zn5yyFugbAtk4BvXypAyp
 tHxljElupoV3HiZWJd71QiTdMihK5vY9nLM2hcdpNcz3tNh1nZZJpwOP5WxWsYCOgOu0zXmVnkMf
 Si_w0Q0g8l5mOpOEAV.JiG6cq4svRwDMX8yCHh40ch64qt1cONnYKUdkQmREAwk0O8Tbc5uqsLy8
 dnzOrF_yqCXJu2kKoveN_3zvo8vm8fmEaap517dpNXO0UJSwjWZtGIry_j8NXkdeXMWasCUM7PXU
 k_Y9bzh1aH6ujk9d2QJs4ggfDIFTDZtBDNE_NnXeA9ToE01BAoeZV04w3iErEhj8m4A2ShPfgXSw
 IGPMVu8e.je_9UGq9FO.v66RK_acA3HkoZpiSygYvTkpTwyVr_q8VCDOTFWhxHmkFcYaVj1B9WkA
 7pWNRU7gW_0xYbuInlX5xHdYKTX6ZDcyoaTqZV2YDm8sw.2kCCOGEE4ekQ0qInUvHdVjKLAJOaxG
 _6vKe9OzzMXjaXy5zDuCxMlfeBaRDFZczk2K8Zb4atugVepv9bOnB6PhsLzbHJcC.iZ4oJv_e1A-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d8fc391abae2ed5c1368bb3c988d9ffd;
          Tue, 09 Apr 2019 21:40:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 17/59] LSM: Use lsm_export in security_secctx_to_secid
Date:   Tue,  9 Apr 2019 14:39:04 -0700
Message-Id: <20190409213946.1667-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secctx_to_secid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          |  4 +++-
 net/netfilter/xt_SECMARK.c        |  5 +++--
 net/netlabel/netlabel_unlabeled.c |  8 ++++++--
 security/security.c               | 11 ++++-------
 6 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e3f5c61b9b2c..991d2d2e290e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1220,7 +1221,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsm_export *l)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 40a3fde22667..7792538b1ca6 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -725,14 +725,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsm_export le;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &le);
 	if (ret < 0)
 		return ret;
 
-	lsm_export_to_all(&le, secid);
 	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 987d2d6ce624..598bea8e4799 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,13 +576,15 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
+	struct lsm_export le;
 	u32 tmp_secid = 0;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
 	if (err)
 		return err;
 
+	lsm_export_secid(&le, &tmp_secid);
 	if (!tmp_secid)
 		return -ENOENT;
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index f16202d26c20..2def8d8898e6 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -49,13 +49,13 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsm_export le;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
-	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -63,6 +63,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	lsm_export_secid(&le, &info->secid);
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index c92894c3e40a..fc38934ccb35 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -896,6 +896,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct lsm_export le;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -919,10 +920,11 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &le);
 	if (ret_val != 0)
 		return ret_val;
 
+	lsm_export_secid(&le, &secid);
 	return netlbl_unlhsh_add(&init_net,
 				 dev_name, addr, mask, addr_len, secid,
 				 &audit_info);
@@ -947,6 +949,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct lsm_export le;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -968,10 +971,11 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &le);
 	if (ret_val != 0)
 		return ret_val;
 
+	lsm_export_secid(&le, &secid);
 	return netlbl_unlhsh_add(&init_net,
 				 NULL, addr, mask, addr_len, secid,
 				 &audit_info);
diff --git a/security/security.c b/security/security.c
index d8300a6400c3..868e9ae6b48c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1967,14 +1967,11 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-	int rc;
-
-	rc = call_int_hook(secctx_to_secid, 0, secdata, seclen, &data);
-	lsm_export_secid(&data, secid);
-	return rc;
+	lsm_export_init(l);
+	return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.19.1

