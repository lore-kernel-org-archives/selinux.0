Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B3C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D2206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nOQHuxua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfKMSUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:04 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:43658
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfKMSUE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669202; bh=co4jpZY+mhudboH3Pzmlm1GU8BGwBGVp+kygYlsjIuI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nOQHuxua94zx+1afY1Ii/OAA5URC8zaB3/oafKUodwHK+jVrzGwTdHwlaQ4qYIh6JlETS9RD+lJF81gF1sUzvmblcMtCDOjGsttJfXMZrkhyfeJswRo9epEXZubnL1CkbRq/S3XvwFxg/ag/N1bUThLaN7pAE6JvczOcqjh4DALvjhHfCdlSyPT+O/XNFgRnwa7aenWRmpCRPBw/L2vlVVlFi2qE+vfUuAcRli3WwsRaPNBaTU41n33QKM9qrODn6L2lJVjf+iYw0h8/kLjT1DMpLLF2PCAM7kYhKBFkqV3oCfQSfPda9r+fUafUYb0DY7rSIadPBTY0Bf50xcgNkA==
X-YMail-OSG: xJizGawVM1nnAbWJTUQbuhYqzbk0.NYeYPsJD7ypt0jOe6k_J1Y5E_4E..z6uAp
 n9lbQVsu0FrrfbyNhKeKJYsCCdCNOiXaOifZvvBh0NotsZSb2G2yXLgm_9eqcTsixpNz.J_R6IwJ
 oLTzLTD3kWDP8I8dW5hlB025seOhhK8sICS7DO12ofiTAh.bt96jF3yWMQn74Npxy8t85htSTEW9
 8We.ZPRhqWqG7rG5Yja18bUexo40aJ9uHvIUqbet849nnEtVFOG9YiOUCyeoNduochuopU_4alr0
 f3qiLZY93heSApsfYu6MrqiyU_uozIx04JsyLnXG.ViDfm44XfIgVZEt5HKCL0qC.95IH3RzFGm4
 OvSMDTN8ZTWXLQJxm87bnpGwereYq2rBSCW9fkHsAr9IPpJuNx2QalAUu5VWAIxy4TKOezwM_y_K
 VeCv.RM6zvWZeTTG67xtYSfGqQeXsxhWY3eu74ZyvbKgSaepP5BLwDg72R5FM2jGVaSS01vLKzn4
 ST7C9nlL2_o2ogNLp3BCscX__.c6bd1RzMAdjSyJ.y.otxRAoyIdSCVVZaLz.PdoVjcYP1.Md_a9
 MTEZ79UxPXHSgrNUbcL8x0kM5V22rW_IhhG9Z7AKEdRlTWZ9NdbvqSWLu4hYShMmNFVGs8aq_7rv
 .RYZnSkua8vkiSQoAmaY5Xsgr9wQJFvscRbGPdjb7OO9reB6HvJWOJAm2tBZ9XoTCdIQGwsSpmdy
 aVndEWX5fNQtAnurl8Sa3LmVEwBjgy6cqNjPckuspsy6vUvECEpxQMbBeP4BOmpyXIE1S.um7sCg
 WkO0cVmIyiLKPo.6qWqcVBGtEbWGEXjQ9p_2ox5.vDbxdZEOvM9.Rw6JmWd.gy4UpB_knLxi7.1z
 uR6T00UZIKReqvSISiajhcbtGppbnQlSbFcrcIURgxigFpRVmQcdMWdld4ni2WR4pjCuxhDQ9n.A
 pmgw6Ur8wn587JzPQkaGpQWFsVkzQ7Ks_zpLV.PfgZFW4Hyxx4OdezHKGRbMcsL46PaN.PrFgUff
 XU8g6PyP_HJl3wge7Qhw18m8OqbnrtW6H.tlFYwer6miOYV8gBchuTnzn9hf4iwqLt1d5vDaYrIs
 aVmTuqp8wkqrUOBEwdr4OyIKqTd9zjLRvrM5PNtQFLXQf0.L_7T3pO_8cDhyJqTMt73uf2hDPKgw
 EaeuAGjirm5yJzwWUEkHDuKfrA2hrGxZpk8IadiYm4g_vOLMED4zJvAK00SgHi0XQRrBL2NIdUWt
 xJAZ3pfa6hxMuLKi6DEtPY.GtVuhAh2WUud8SpO0eGG.3hoIz_fZ1PrItCWr7Y2lh6qR84cLTY4Y
 YB2YKP4c0mLu0GM8GbcwJVu_9u4TJt2n09BgJt7NdJZTlWan5LS2Tkdk6CIJqeNjVSsC02AKIJWL
 DPVpJ1Ewtp5iYJZKEOfJ9YN6p5XGTxrSnwtOMraJ6RWpgq.fXFTYp5qVtGC5YLFM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:20:02 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b1a61182257f10df38d21beca379be88;
          Wed, 13 Nov 2019 18:20:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed, 13 Nov 2019 10:19:06 -0800
Message-Id: <20191113181925.2437-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 13 ++++++-------
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index d57f400a307e..b69877a13efa 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -494,7 +494,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
@@ -1300,7 +1301,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 846ac4b23c16..7fef90f3f10b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsmblob blob;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
 	if (ret < 0)
 		return ret;
 
-	lsmblob_init(&blob, secid);
 	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 317e3a9e8c5b..7c49397c33fd 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -617,21 +617,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
-	u32 tmp_secid = 0;
+	struct lsmblob blob;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
 	if (err)
 		return err;
 
-	if (!tmp_secid)
-		return -ENOENT;
-
-	err = security_secmark_relabel_packet(tmp_secid);
+	/* Using le[0] is scaffolding */
+	err = security_secmark_relabel_packet(blob.secid[0]);
 	if (err)
 		return err;
 
-	priv->secid = tmp_secid;
+	/* Using le[0] is scaffolding */
+	priv->secid = blob.secid[0];
 	return 0;
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2317721f3ecb..2d68416b4552 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsmblob blob;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+				       &blob);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = blob.secid[0];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d2e4ab8d1cb1..7a5a87f15736 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
@@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
+				 NULL, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
diff --git a/security/security.c b/security/security.c
index 55837706e3ef..32bb5383de9b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.20.1

