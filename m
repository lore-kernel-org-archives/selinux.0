Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496FC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ADC2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mzv9etOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfB1WUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:18 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:34399
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730845AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=xFoB7UEDemun7LHgUdKvmFQJzUPr56+9v/fv1ouPu8c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mzv9etOiUsrbZrWu4al8RMIQSll4TpeLZ8EBItqThnYXNISY2fShUd3Fn1IWSNmdRUyKaNLYUcDuMi8ZPPRoUogIlgXsC1TZX3IBO7Ta7idmY7+nqaU1Zz0QNNceAvYnC7sngDaEvHUHpYK8TZdpIvoTSI7mpjYDIfBbp12EZY9Zpb5i+rCjBJJhVF1PKY4EOBHuoi8eUIaR/gpdSgDZLg8L1S9mdAbCUHJorTic4iCBJ7zfW2WjORmhWMWfTFObtG3+W0Wu7vktV4WInc3n5XHoSmRWdgaBlpGRblj0YEEzXnONzNwxXJMmupFU/ejtK7HHiM7PRszG3+5QTYp5Fg==
X-YMail-OSG: qE23XL4VM1kj3JngZ_avCor430cG0LqL2qNiac2tDrwZPFDm7BeyQdcfRK2Ow25
 oc_eNcb45PNPXHZ6WG6SYdcJ8JQIDKF2RrzSIwkow6RD6OEVJ7zdh6bNifhvWqgce4FArGlM96jN
 OQNKuPkOytTOv9BTkshDrCDpV0GS_nkRv1AxPKlNmCM7KUmAFzkrR0CDvyaXcc2jJfvlCcKpfGIx
 ZH5.3Kah6bcDcWvughJhaZLA7SN0cNm8o7lwDm4iMwBI5Z3uYL4.7lIewM9xfBRkX4oZ6lMTTry4
 zBrCeteLcUho9b15zOr5KlWIz0zm7PguaroKesqgbw6zMTqOCzYb9nJA33MKTz65DQjyTH0Y9Jlj
 HSfBfigZHADWU4O_ZCz_Z2x834nT0bpA8fezaJ9K1ajntCw.nRVsR05JGU_H8oir3gjjOyKHUp2I
 ECvI4TGvWw3nKjTzhv_9eZFofgysUDMQHECRPl8nye9hudR9k5eiN4PF0yqOkX5yKw_YTML37V9e
 6Fs.zpJQgE1ih4a5Ie9ABbRlXNtXSscuQXzuAS64Z.6.xswtfdPQNOlMXMVf4LGoW3lCDfj0DA9z
 KtiChnlKlQPi4xM2iOnWB9wd6w_tDYA78J9MEdIkcRnrCSfIKZBM1h2mYvL3vOc3gOiOet9xOLgj
 dRChCg64JsJgUIjATdAbhJs_ZeS1N9O3YCl0aBVpIV7LMuNv6ZlTtQaGy75Wh6dh.5g5m6cGnxZM
 AJM0_wWVmFDwP40zQzgZUfzstEWeSX6PAIKZiTwKUOBdg9HWXzA_6KQGQtwW4wBql32o9jrTd3JR
 6BrkUYIzW74xzttC7QoA7Q0Jd7EOtaWBJRYmfrDHRqYeY0MMdjrx8aEA5zpxnGecC.TKf7A7dSCL
 rrSsdwvtZV7sfyFsTiWRKadB7GK5gwxTXwsNWUZYvhL3_dHJ6l9rBF2LrGFu.xphBrqjkh3BBuMX
 Vmgi4G_IsTQi9TJNS0WsdHr1QKO3zQPzf1qKBykroFDgf5gY8mznd8K5wIywIH6lZPS6CI1Aj_3f
 yHvs2p3XgepPk_USARlEpWYtj0QoxNVbn7htnm1iWiJroEkjS.CgwO3j_mCQN3T8CMoZReFMNXNc
 VuyZPn7C4TB7sTbCPfF7mzaq40QGvfl_c2V4Y8tCSCWsQ6UHl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 52/97] LSM: Use lsm_context in security_secctx_to_secid
Date:   Thu, 28 Feb 2019 14:18:48 -0800
Message-Id: <20190228221933.2551-53-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 2d948f1104cb..23b776bc16bf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -429,8 +429,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l);
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1203,8 +1202,7 @@ static inline int security_secid_to_secctx(struct lsm_export *l,
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
index 9f5040140fe0..ad1aa430f733 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -565,11 +565,14 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
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
index 934667e8969c..314528bca31c 100644
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
index fd1ce1116969..dadb1cb72920 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1988,15 +1988,11 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
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
2.17.0

