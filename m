Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A612BC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE820833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nr/5z+Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDIUAK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:10 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:45978
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbfDIUAJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840007; bh=nhyQ5HEMViXMwzj11P6PbXR0lPC7xmZwGngBq91che4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nr/5z+BwBBx6SY1em+evjT1mTu2rTle5sPW4ANpcNe9mDkXiURD1mKx2kIRvYVEyKUZBKWLFlhV/DJMTo4ymPpq/mNQ7fFxofvjHFSDWXKmeRV+T3zZU2S5x6NnUQ6LKdH9UzoeS7gyJcw1LlZAqiRDIbSDQtjVio53e0Vr2jLQjqdlqHUBKvoYkdbrlgep10a5ktDC3jyb6dJfamKwShUbhvMmzJvE+H0Aje4O/BHhQLvnKvl83kaGdRusxQjdeVgM32VFbaHUPcMRSD2ozgT2ZbyHKytNtZP8BALlBGlslXPaRRJdAFMfCHrYPtsgOYh5tf/8IcuX5MntNcbsmgw==
X-YMail-OSG: Iq_fq_0VM1nEDHbgPa0wDH_QLc3g2HUcsLHk1.fm3maLE15gGmH5fTpZ2a5gQ_s
 ahQNxjk3FRxKh5KHgE7ZiWw1k2voo8XyljXqCv2Y4zsfxyi1Wro.GyEBoJscuC6hpba_mDQKiUXa
 Fy0o.DgGIJLfoxHmbLNpHavCit3kaS9ZhSV5.sWzYN4T07eHEAnN3IrhjCnp4FxEV2Sh_0TbETMv
 6V2uFHPni7u_KCXnWPVIItTzpa4jyohTVciHPeajtH2Rru8xFY.wR0v1XSVS7coDaurKKO1kI5wd
 XmdZejS.C5v6mo5TD99GGsJZqiImsapHrP7hn3RoHlGZHUGBaUDmX4G4BmgNbi_.8zUFCyHfgjkU
 7vEqEma70VyLpJIov4obTGJaYoQM6P47oUotNuo8LwjTk774ynZXv_xU1zG1T.XLS8gkJ.Zw1fJB
 FFMknntfoco_SIh21BMRw1cg5e96OEuPfm1HUevdyprViW8CnZFoaVL6zgqpjJIGTESHuQazorJJ
 mbBd0oAjAa97P7B8CLBlAt0aBT27CFxRb8U9MIGoo0hnghJ.mqB1F82U9EcJD5w1pTwvBMUuqEhm
 UqfgWAV0ptGeDrnv8hCjJl3NGiD9_K70B2fAFhwW1Yhd73AI59sefeUnw0tuvdayStNbSmMwB78o
 vMkH3t19Im9bShlg9TLbcO3.HQ6hXUCqS650O10GsO9C77tLuQmdUnFQBgM6dgX30R_E8j.5csuo
 o4FgJVQh8NHhHCyIxN8VZBt8waNs0w0VnBsU9hrEmN3OLy41MvDt5C7YyOLOARbjKXCJQeFrcGe4
 8MfDgEZ8OPuetyoEw3_tEpBYwNCVdb_Z1a_C8t5ngiqK6jwgde1ErhawtZZQ9ZZC8T1rNFQzK.TX
 c2oydM0lEqFbfEjzJ_YxgAz4urOUrYoDgFHYcm4Qkjb2kcxOtQBiLp.PwL93kQHZSDiW44D2Fe4m
 VjsXiKEG1nuEPCLQ6Nb6Gg6mTtdRjSbPLmBc5aIQE_U3g5Plq2NBK2oppeZujN8w5CagW9zxwEde
 taKUGt1IHrnllhSmfcNFdpdQiLj_ymxKzsnKnPxKXOs_vqZp.Om2ny5ZdR6KWgOqLNZwa5NXqEMl
 HVyy5wtj_MybdZlpkHqgZKljY.BiPhQdmUbsakN2YeG3E.KMGo7Lki.exw21NObeFvchniMxnVys
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24fceb1ba198cd68afe9603a17bf6fc8;
          Tue, 09 Apr 2019 20:00:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 17/59] LSM: Use lsm_export in security_secctx_to_secid
Date:   Tue,  9 Apr 2019 12:58:42 -0700
Message-Id: <20190409195924.1509-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

