Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D4C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144520820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ezt/nsCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDITTd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:33 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:33233
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbfDITTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837570; bh=Bz4Myh+vsbujN22ch93KZc6mzSg5aPOU0wuPwMKBSrE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ezt/nsCFWWx/UACsnLzkde6Czv0oHoQp7glzx6EbTxbq+hcTubVcam6cfCuv38kN4brJIJBJc8fFRy5ut9h1O99TCBLcIS9TyykGaMhrwxhoChNt8nbjqwc8LManNwBW738Mvt7qhxK4nS7koWo2HHjysIzLr/OicqALEs4buUJ7WDvQ7zSp67AELTV/UVQva53FiOiOVobqQ/MZyMxbmB4IaJoUozloKFU4QhKGTqA5vHqSzN96pEg5pXoAqh4SZ1QUqyU2xgaDwA6ayYKMBitR6znYwfSciwNoY4rPxNhen0ZI0C23+6DdvROsbwaEMMfdjjmM5FiTwVCXh7+jtQ==
X-YMail-OSG: bPNdFA0VM1nRi3lugPh40VqglWicZHYGudFOA8_YCRXRkCtqQ3MeyLfMqB3o.5S
 2z0zjmqk9atNd8VZzBW6P.3bz3Ppgz6NaOhlbZWdxGqAOeDq6NEq.qfg.OsoB2cwVfX3GZaLIOwn
 BV0pdn.QR0V9LOPMEAqFwDK4WWn6fK4JgAHdRlwTkfgChwSXWj48qzwNwM_BEG7uuHVsBydWssDZ
 CnbR2cjr_sJipwtHSK2xPa18O_dKqvc1Z9EuUiDI3kE3fxFsXTllgKs_N4nYwBCDCYyx_CIWjA6S
 _Rrr0csfAkCuKXRHzSr40VawEhXsGIHUDrGrvHeZl2dsMazdESQO3HkaF7CSahTkvS68edgZYSwI
 _cLWpTUGE_j_yVdVHAhcfdY6VULyiAdpnkOvVH9k9yNd82R8z_Xx.Vcy_YtJvcHo6eGhhkEnMlEv
 UFiy39hIMfrKzLePvVuEXmvYURCUyPq8AN3WehWrDqHY23E88aODmoaXdC.P_mH7Z.DJGFUz3PCp
 _9zY5Hm54bI9ivBTr61fKulCWZujrwKFnu_fiYHelA9J39lWK1SuVLXXDD3.g0p6whDGImJ62wYv
 8TbiQaNnhWYOG4cgk7l95LPvBG01XmvNff1ffsd37GLTGkbwlMHTIGWq6V3Xnd6RTXf.dNtK9Kuy
 MduT4USERhzBPnwYPiSojcvnBJfdABsCXqPnhkXzSbj.MbFqnGf9jlPUuWoHFCfxesxBwKuulL6c
 9RVzZPCAnSAMvgbhjJpWPVhjhb74LXLTS1ogAnuEyiJWKS8mcLQX36lM3nMFJnswkc_F69vVbS3M
 gKY55VphNpDdrFXMBb5FYU3xKh0s2APDmE4J0AZbqadETwxnI22LFStLUpBmsH6mz9jirnGYkhdW
 sOMLShq.gY5sIzEvETkPAVwt9dTtqS6vTAl4BunMGVqVPgwE6Wssc.v0Mx1gvY9IJxDBp.96ZzrA
 1R7jwjLYyTfqrGs3Wo.yyrDXMA14sSduCg6lIpxNckcf7QPrHk11tH8eCCM.lDjy8iWGnTK4QuRi
 6XJgaweibuk2VAyT9r39QJJOMx.xuB38Xe1qkEB7JXy0xtFFlNpQliLIHg1iB9KndrhCW8ghk.I2
 pRQ5S0Gmwt2i6NAhQHNjDzNfS_jyB9Q75vXF3HTpoj5VDmXYop_O_q5M13Qc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 46/59] LSM: Use lsm_context in security_secctx_to_secid
Date:   Tue,  9 Apr 2019 12:18:35 -0700
Message-Id: <20190409191848.1380-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

