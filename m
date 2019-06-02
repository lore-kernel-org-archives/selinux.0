Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5542C28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34F2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GSHIIZit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFBQx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:57 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:41802 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfFBQx4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494435; bh=mT7CWYfSqkiX5vZ0p/C8Hg9IONMlLrjlhp5TmNjwBEM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GSHIIZitK8K1CxkGeVrYiVaI0p9/CWd45OB++MQlgsQoHj2hjiCVM7ydNRJpjgySI5zkYPEWaBRGFzJbBLLChCIKXV7fVblFaqs5ovgVe5rC7+S9k3mxUdPn+0iQq0Ue1EXfnVdhQ0dkbi+a5kBlcTdQL0uNx25ly1BKrvawN+NYrhB//SV1TP2L9OV+6yr8+fUDmS9EZXMYOtSVTH2AYNT8B5Q5Aha8y/CJiCKMHoiRPlUleDD03b6bryyTcpeeICTMLTIFYS1e+ZiUYHbpZvDB1vzoSIsn0uQdBlXO9QDYkBc/o/TBr8EnsZ3kLafRJjsmmTVv7Gh6valbqldcJA==
X-YMail-OSG: awEj7x4VM1mDPESiIxPCCt3QuO7XGlH9wPkAEcR5x.vpelsOAxjEgfkMPF30e97
 lPBFBS9DOkySXCiP4KvVLA1kFLAcYAXEmk3wDxuIzM0SREykoBqWtWYIdyPiuoSFUOFM8RKHpNz9
 O6Kea1VBSS_6kD2ZH9xppl6rZ5AHE3WujECGUEZGctc3zQSNHCJuz4IZ7Pe7Dp8yMdn2EG4AfN9o
 d.1npzwBGB0lVzBUcp3gQjZl.ejDHvsW9lIXDd9sUt5Id5BeZf32FPA8mfVuuc8cofnjCEHzhTFO
 0LOgLXWvknOZ9gyU0v9Myh6gJ1SY1bAk4T7XiTD1INAvoJhhgomWDAK8F8VmxmBBfLjtU_qq0lw0
 dZJcm6lcMNC.JisIDpNkQrGt3R4KAz3Cyzbb_lfNJDVZVEg95LZyawcKj.pbCHiCG8pLQ9142kfs
 Aq6EGFVVvJLDFMB5KAac96pqqxwCNyjN08Vi_FUcQ0F1wK3NGKt0S1HVqzx6eDAwog2iQxh44t3N
 w3irHN7Aa2cKe7NP5uASpG3zCGrRWQ_DGoefGVk2CMfIAqzoXyEeou21COjdmkNPdVD6QqWQCvTz
 BkSr6XiT3Q_Q2c15c7a4JwXMbC13xurG1iOHtlqoNK5.60O_brX_n3BasNQMkF_jihKM_kd3wO_F
 4t2_CxpFCGrI7c3RzAlWJ0JakR3RBf1iwUEUDD98qJEv.7GWBUmgUVZUor5asLhR.EuBCptxO4Hp
 9nj7P1Sg0NlxJSJAaFK9k_AwSxvy_7TNNetVTFIODvnbk.I3dlpM6JfY5Wy7HPUDjlSMoGjwReKw
 Iywqn4nK9ran4jdnvRNfNRInQI7aG3KGe9Evq1SD639sNnq91i5.XItRuLWQJr7zTbbG6XNpUdO_
 jvQtecnR.a9HAPkUqoCRv2KGqXbMiLox_6kpii0q5OfurESXhu2kWCaTu2qXDDhXCK5yfpsCqenH
 _NbwE.hPkwzNpQ5OT51gdyDfWcG._381cfgOfSekDem2GRXRvOVerpKJzW.IBBUjKlnzFd9Iz90v
 op_.UnYbhsi1AgL47uA2CdbXCMQkdq1Lc22NW.aNkHdXLUqsaeSf2Q8yyU5kWb4LFllhTBIY0aYh
 LsV4ekJ1EDxqhGyRlHEoqfRMzE7MtHQ3xYjKxWr24jeodqo5UP.X8qOEmKsIi6oiWhdjgwcT59GX
 Mr3tvcBIeUxI.dr_X6ASU3R4jQ5BKzh4jYn1G7HRUYPPcA5b8W8.3ut51G37WQ29XKaIROGzfTrc
 oBjUoSH5ZZq8dmaUpzyONYj2yfNdCGFKFX.ylRB2eSL8E05t3hdFT0PEEtg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 378fb4b825ee861f1e4674117ce93fdc;
          Sun, 02 Jun 2019 16:53:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 45/58] LSM: Use lsm_context in security_secctx_to_secid
Date:   Sun,  2 Jun 2019 09:50:48 -0700
Message-Id: <20190602165101.25079-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 security/security.c               |  9 ++-------
 6 files changed, 24 insertions(+), 22 deletions(-)

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
index 4f999cfcf949..44a4402073d7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1987,15 +1987,10 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l)
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-	struct lsm_context lc;
-
-	lc.context = (char *)secdata;
-	lc.len = seclen;
 	lsm_export_init(l);
-	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
+	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.19.1

