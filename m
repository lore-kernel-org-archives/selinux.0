Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E8AC5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EC021882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DGm/Fqte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGCV0I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:08 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:34294
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbfGCV0I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189166; bh=jeAwtj61x3mTeiR+JjReHIO7CbjGJFrxN2vWv0bqU0U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DGm/Fqte4vphC1yuVd5mfnEk6rvvzyHOwlEnElgDm+8iARW22GNOy9VMTvfoutai1/43y6tXad43u27a48QAmAUiLAcnL1ggT+Vzyh4dBjwpDq48vlbDHdGwViab73xRkL0IluRUqGDihG5pWHO4Ya34eOdJZqAipzPHmHVR6mt96o4isd9v3rJ/zYJuZ9uXLbLkio2OCBmCkG3gnEs5BMm/0k2x65ZQJEnAQ8ru58ZJBQo/hO4AnY3N8+vsq96ava3KbK8ov4hxZRXsBHCEcm/rcI8OTxoyCeIbylMevbtt8NNwfGAPFZROlUvvalGpxSjZiUFFOYa38vAC0oNswQ==
X-YMail-OSG: AG8HUvIVM1lpQ8cWH90.et47qlMQPG2t9NJSMbUbPanfAMPU1AKUh2Se7DbAg04
 OZXXd_LBgEKD0c.L1fr2CMDCPu00SNqjZl5mgwkIOy.vuv7KaRU3XJlTri2rZOGXV9QL_o2qFnel
 hPFkaYf4rwXaG1quKBiAPkbxtsevTbM7.atDUv4wC1bhaZWTXDCS2NxQkSg.GC5M_xr5DT0lM5Ju
 K0XsvzfsgzwDDWtUxg7Z_iqnefdFDRe_OSJCYxiGJba.gccnyYHd574JeebWGv4OiyNP0Vqam6ds
 Q1usUiGYMVH.4G2Iync.pMDXSoScb2_4KzGxNxSvqumCrekSxr2fdxXWwsN1FLy0QSTVQZNr1Nns
 P.4ZEzQL1GHj66vSqrQJUG1i7BeXaAEwIr3uCxxjuwW1Fto9O6SjteQnYI0hRPnd0WQKwEeg6oeD
 tZsXvgvTyCO.v.W3G_JZ6fRDvqbjXQslaNIPUAv.2bObWKcSXqGleIbDxIqyqtdoop_txGLZBzdO
 lAhb23PisNoX.DTNbLEF_g1GMGKk8aZq4L_JKhY0zLm5S5Be1JIRGc3epfr.pY8bSuvy9GM0u9IO
 VkdyD7qPxNqzqA0d0ofByhnsmADAKEA6pt2zwJJr64doPPYCvLbBMtRkgr2u5JHG7802Qcp_L8bb
 eqCIU3IPxJNryShy6Y2yZ7ZCtQWYxknjZRISzgKtn2mh5u_AnxuLROQGHPsdl0M8Sc8DHRz27zPK
 tD041jse35r3fLBz3Q9IeNJ7ETP1FSotvZoBWWKtHqp3rdpSkw3l8b4SCesqrJ_bNw2xbydbKZz0
 _gIgAwx8ce8SgV.Clnu35iQQqilSk20X.S8lc1s_pzqY8lbcJiytq0rdblT.Tezlr0NcGn5KN7WK
 EXVjzV9uzzn9s31udCci8bPat8VPM4N1DqRF3DAe6TpNnJdvf4wIQqis.w5KKGQ4PE_3XSUQbjDl
 i68vsfE.0fLgy_ZhpF3dcv9bn5evEdX1RekeM.4irvqyW.1BDUtzMZcRwLGAqHqk2kZdEhum1dJ6
 BqlDSJX4UOIQPfGL9cGAgYWtCBDAmk0FYZb0DzLIzEeKA6Z5OUAeXYWvxMISdwa6cLKPKur_oyHr
 QlFWTpPbJJyXz6TK1If_b6TpJn4ZAuP36_fZvchQsPAuGyoPLo3Kr2u1.HN6v6MO3uoDke9SYLTS
 YqbguQagR1aOmJmRf2qDJuhxqkwvofyyQXFRrnXs1Lue_iyxXnRds3ihQzW6TCu1vhKpTYRD.eq5
 0knTS5N4tLfVw0Pbz1wG78A2BBu0lCyd9HkFray5LX5oP30Bi
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:06 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0d1593ba5df32fb20abdbc1b1b8a4c8;
          Wed, 03 Jul 2019 21:26:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 08/23] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed,  3 Jul 2019 14:25:23 -0700
Message-Id: <20190703212538.7383-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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
index dcf20da87d1b..30337f1a9056 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -447,7 +447,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1230,7 +1231,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 71c14dda107e..d70a2c02ced4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -725,14 +725,12 @@ EXPORT_SYMBOL(set_security_override);
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
index 987d2d6ce624..054fb4b48d51 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,21 +576,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
index f16202d26c20..8081fadc30e9 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -49,13 +49,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
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
@@ -63,6 +64,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = blob.secid[0];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index c92894c3e40a..2976370e41aa 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -895,7 +895,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -919,12 +919,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
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
 
@@ -946,7 +947,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -968,12 +969,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
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
index fe76dfa0f2fd..e231fbfd68f2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1982,10 +1982,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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

