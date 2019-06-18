Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BBC31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316BE2080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kkFh0xGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfFRXGn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:43 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:36545
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730951AbfFRXGn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899190; bh=VQkUTywC8oKKPLpzwkotkCvfR/GKqlQWL88Z8rMyOvk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kkFh0xGy7+4QgruPYa5SzDerdsV3ZFru8gDj6XH4RmBctQJu8KeJSeLmer0I/WGMRgQrvB33GgO0npYNST1U//wyhdWcpUPaY6ZY9ZLWZPrsbK2f8b3rcufV313gtvo8JVahnRWnk5Lxd/xSE951udnIoxWneoXiWi10kpRGO30gc6yUnaNbhpS1W2pehgZU2VCP8P8G3ADYy5h7GfXXkoMH41TXO1zgy/LXhHGzp9pDyTItw3luF0jAbziikjjArnSTbgKTk2Gzj+YNMnU0t6THXvXDUtVJxetmNst9KQ2pTHgIx5BWH59qjM6vTtqm930qkz3rOcTvP5t1GX8mrg==
X-YMail-OSG: eubxNswVM1nXovNO9rhCEoKYuEB7kH4XeGh1sf7carsW8qhh75gRXjrCnR5Rs9d
 xcyenlSI.pLJKVEYreVieDbnvAWmbLA0rvSc94hbpRpkqNYX9o0eXlSW.FQfVSFGYrLBXNzv14E_
 el5us_tfYQnAls2U5qDV9zJBBaZKwbTzpGx9EDMr10q6YY1xyJahEZ8ymGaq.RbSJpcnrS122oDP
 FVc5NkN3TF0jakBX8DKOK7G6QXaVx4imgHK.ez3WppjHIJkgLeNCiWF6A8s7bxPrRgEPQUkmrOdv
 713uiE.viA_lU98Y_SO7ovhgwaFfRdmGgXKCIHdKQiyTK_wka8CAqpZqcqoZIHfrc7fggJP9xUJC
 Vgy8zrHeb1rHLPAcTHRCJfG9s5FxYEtUWmv99densn43Fw7NPyfS52ItGzTcEwfT1Rq9q9xkn1t3
 Vboft8F_lkwwEnhLhnYIsaFUBbWrP8Zwq1yMidpQUN9z8tgOc0A4k4kU.beHUza0m_zbJll0fe5C
 xRYKo2UhinP0W.wCuS9eyjVnJ_jVUVLF7rOm8K8aRS5Rs4MrgEsMH9ZcuOGDcMdl1gmpNgs4dj1i
 dnKcE.YMPONs2M2M2lRiixAHSUMYHjvoiTV2bIguoQBW8ALIIGNhIEDE4DoEURxc6EU7Yrw.lyxd
 Z.soHnlZdA52EUnlq4vrvkcvxusvbXjAvHUiiWJUUlG_OSG9W3HVaJ4mIs9B8HZ0q8F1xAgFbC2Y
 lOhqgO2UISpAaJVxzFUTPkz8NSiNmVvlj2IpRrIGeP_HKyUanCyGByUnUh9QVBPmtgi3rtsFEtRc
 CV.R9BVT3WGZfBrSVmL46pCEqm1Djl9ScusuNBC2uonYZxHX3ZEpN0llNIWXo6FaVfBLghcrXs9u
 .McsKzaA.QAQUQZjftyNJwvE5znR0b0YksTWF8VzGP8Fyv0aV_M4rK0skd2IAKf29gynjM8_4135
 _4P3plY6D_FSsXmiTvDCQt8aIX4NAK5Nfz2KYZJtk7H0qxYo2n4PWrfd.4ug8SQCl_m0qk7jO1yl
 kdK7fzfXuigz0A5jZg.VVb4ZkEI0YrWmBurku.FccwhWlukDG7UFlVR80F9J7oQhfaNwCwH.hxm.
 lWqWmji4MZfTAfiwSqUv4i5._AQjzoYhvq.B8PUz.Y.p24fc_67IT1WNqe6iSJBrQMudx9KQDf20
 UEr4El8GmnVgnSB0G9WSZPLQZ8Q4Ck0aU2cbxRaLMZhX_c10GFigf4yCSoOBihqv7WXyng2SRCGe
 PcQa74UxYVDPqWVFcXJbI.w5eR.rOar0UzulYE5p_wGcL6tpe51KrDg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:30 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 671694aa74794ae915ae1b1c311da411;
          Tue, 18 Jun 2019 23:06:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 08/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Tue, 18 Jun 2019 16:05:34 -0700
Message-Id: <20190618230551.7475-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change security_secctx_to_secid() to fill in a lsmblob instead
of a u32 secid. Multiple LSMs may be able to interpret the
string, and this allows for setting whichever secid is
appropriate. In some cases there is scaffolding where other
interfaces have yet to be converted.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 13 ++++++-------
 net/netfilter/xt_SECMARK.c        |  6 ++++--
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 15 ++++++++++++---
 6 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 64f5cc2dd249..dcaaa63b79b3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -443,7 +443,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1226,7 +1227,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *l)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index e71a16f177dc..fa4051365d70 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -725,14 +725,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsmblob le;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &le);
 	if (ret < 0)
 		return ret;
 
-	lsmblob_init(&le, secid);
 	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 987d2d6ce624..b6e41cb1c76e 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,21 +576,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
-	u32 tmp_secid = 0;
+	struct lsmblob le;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
 	if (err)
 		return err;
 
-	if (!tmp_secid)
-		return -ENOENT;
-
-	err = security_secmark_relabel_packet(tmp_secid);
+	/* Using le[1] is scaffolding */
+	err = security_secmark_relabel_packet(le.secid[1]);
 	if (err)
 		return err;
 
-	priv->secid = tmp_secid;
+	/* Using le[1] is scaffolding */
+	priv->secid = le.secid[1];
 	return 0;
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index f16202d26c20..040eb9515769 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -49,13 +49,13 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsmblob le;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
-	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -63,6 +63,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = le.secid[1];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index c92894c3e40a..30873e671d05 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -895,7 +895,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob le;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -919,12 +919,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &le);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [1] */
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, le.secid[1],
 				 &audit_info);
 }
 
@@ -946,7 +947,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob le;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -968,12 +969,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &le);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [1] */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
+				 NULL, addr, mask, addr_len, le.secid[1],
 				 &audit_info);
 }
 
diff --git a/security/security.c b/security/security.c
index 5ed818699e15..44927bf13d32 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1994,10 +1994,19 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen, struct lsmblob *l)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	lsmblob_init(l, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &l->secid[hp->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.20.1

