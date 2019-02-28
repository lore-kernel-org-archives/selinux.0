Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0615AC10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C550A2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I438bRHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfB1WUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:04 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:32906
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729755AbfB1WUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=V43EQp2nHtiYphRJr4hBUbs8PYsKCo+3aftn1oHIhLc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=I438bRHyrrzwoMIViRYnOH5so0ZibZHyEGQWfvEcwZ1NCX04AMijSQHaFDkbI5kNCgmbZY4mmxDutPR0gksQNgel2azw1J3RjGjQhbqK/0K0NnnjeNQneKE5aXq+mMcOUNKP85IFeVrUKG+sijRBUCai7XVF0YYhSNs4BqGP0PuhuY8JgkNr2/kb2nAv+68xRBUHOPUqshO6G/d5v1YUaH9fYkePLk6ZeuTQlXZIb3zN3cxl30pqYQ+ZnRmXSg9yORiIf/H2JDq7Ea0k8ilRNBkyt6092Pp6qk8chB7vRaUOk9bXGu+MTrW8HAUeVshbUUaXcmeyEl1rU6hBjU6/0Q==
X-YMail-OSG: nhFpK9YVM1kw98nB8oam2JZBfqVWREbYarf22L1ANDkWisNrG9QepDO1CNS1Z2I
 wzotwMKqD20_flwBB9gatN6hbx8Xm9ibeVfrZ2RcxH8WotAeqK9YUPZ3rHeompcWsSATUd0pxLOy
 fybj8hPlZdp10J7lcW3Dk08TKyscuM7Q_7Ctt60yTCM9nfyaOWf_TQNs5NfTlxZynfujP88.3IQx
 UYn5bqQyA.GjKXWvmmCxVtV4zC_EzYTrfOehFV3QlKH9PsNYfwC3znIkXIZ95BC.NTT5Dj38cBqv
 mxEWdTVr6RXGJ3aKuwXo2gNfdVvSHBE97pdVsT065pflQMNJWY.WFgCDjqgdGew5uuC1guO.wTbX
 yBDP.zJjxI3TTdcAJQ9uN6VxoBelz2PSYnTjMyKC7BKEMU9WRDa7l8Boqm4I8d9L1RfTOS8oRayw
 jvdzoIgzA7euY1AaMNomp_ugTjFS4T9KBPE6Enpr1ioLaf9908_HJ96FbyTvbN7lACQMLvOPR35x
 UB4MRM31g5L6ZISnP7NE3mx9Mpz4kL2_Yq5giECv6erpJl4M8oIj3dBqPymSeHIPQcgNQXJFfyiA
 TLVFAi.gw8oF8IT0ZR898cHw_0sea.Y58gWtQvAi7agBpOL6u9nidZhlSvfxwplO6CxBP4X9rttj
 Vd_9VVBcU__r_3Xej9nU7StUO_tj52pGnT2M2bJu2qlqK39TfFydCZXfsYVHYVKgBhYZViewvBip
 rMAh3KwPgnJxn1xGZwouKORWLFdJmqshFKe9HruEhAPBgDmpP2xzOz5DNN9PA__Lgwoto.AfBWg8
 SvfZ3hALL5aaqlSMKh8pYdWdD4j0G7uHyVoCfOpiITJBJMGZ99C58RNEq4FIMeCOoN8gqqGRpsXZ
 OcFVHs0SN5H6sTaus0GCYHZIauCzAqMNVvJ7uIOl6Z2m.klTD2MSZlChd.u0QfDsruWoYt1_19kk
 lVMll.WKFKtt1SgT6xyURDn598K1gu0abgQMGhHarPDWpgUd1JCOY3r1MZQH6ecyriOTGVSyxuZa
 G.8_sJs0o1bT9F7PgjEEQbOFpnXSmjJr19OxPO9kt0ZpInsA6UvZmtw0x_Eouuu.coV1WRT8EcEY
 DP2vG..p255jkZCIFHCbOk0wgqLwWbQoRPfywGQkFfgxIAO.Tu8dZHvfWAHrZUxR._Ta.WUOkH9X
 m32v6wMVxOqstmj.Ja2BsH72T9A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 20/97] LSM: Use lsm_export in security_secctx_to_secid
Date:   Thu, 28 Feb 2019 14:18:16 -0800
Message-Id: <20190228221933.2551-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
 security/security.c               | 10 +++-------
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5837cc2a5dad..330fc7ac8d7d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -432,7 +432,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1204,7 +1205,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
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
index 6df486c5ebd3..a03de2ab833a 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -564,13 +564,15 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
index b86ac7b8a946..da3ccb19dcae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1953,14 +1953,10 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
+	return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.17.0

