Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C841C35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30582087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QL7uQ59N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgAXAYN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:24:13 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:41712
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbgAXAYN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825451; bh=95i6vDMqUvd6jTgBi7Zn4gXL1jNw1342STwQ4VPSjAc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QL7uQ59NYF9sT2f6G+cfo2PTMxwUimzgfOhQGNOkTi8PM+ysZA6vtvYJl7ALshs3rpJanZtiNNbnaCyrZs75zKPe/l74X1V3XDhMVWnfsCrZMZCYhl3ml/dLPKVkq30XfCYHODsOImpFM8Wr6NRrS1DP425lU6y8mp6J5yx/RDAjum0Xt+3aMCklq/1LZIuqt4v7lZOvgoFXOQg4Dutz9vN/U6wDKHYI1KzTFpnrGR3PzUWdx5H3Ee9e/QXsVY8GinEt+E6F0N0hmsGnsxVcUqxo0wR0bzEV3sHMHJ81YQzPSejxGYGkW/FSpMfXK5+0vlBvPSPvwboc2bWkr4nVSQ==
X-YMail-OSG: g.PeG00VM1kTPbrMJdawxHudSK6xbWUbQtLjEEuWfxVyqOxHcQXi8XwYHzZWJpy
 KGucQjOai5TP_zZU4Gy_Ak5VViD08YRPiRIIJdntZ2uqUqNlU6g5fV8ur2qMM.KuBwmLgSkJEUzA
 w1VpnzF1vCAEymp.CODj2frhv.Sk0Z8AxlW7CnTnp_WO37VP6.RV91HNNLs3_eAJ1R42uN7MYwLs
 d4F5MFqRZQh7wUZskpqOWmXWgsnNTLP98ME_KSttrmejdDdZfNfEy0qB8pHMLQZpdKsvky7Vmh.5
 jwmIFQvGABvSJf_L2uNQhSXDvNZ7gWa0oY5zZ92lDNj6fti_tjTcw7AXLZfXTNbF705OdeWaz0kx
 QH2vllYw2HLukjSH8hbASCJ6Ik69AblxTOxgSdTrcsClqYW6w8omaqcSPQA1k0WrHrSjX35_aL17
 fmalOuV6qylaAzPPOwyXGZr9.3SMTrUWmLRMXQYZNluFpTfR4tEwv92x7NkAdpoUsf76oVtOdiWa
 RBsHjtHLRS8tQFCep2PBE2ZRQfhxtB0lJvy3g4CSW0KrzB9QBAfSxkEDpPD6Hd15km6amIuJd76O
 dtz0dGWNHh0KXBmBcGLSDVna.wG7xR8cuGRapoglOQXbwV6N4wIr_RQq_PDxcYz5nZ.Pl0eEXGKE
 ly78maivhE7nsYjyYZkzUpC.hXtDigyVjBhXPU2vxbb6r5t5Ks1X7XQW8HSGSNt52Goso2MFE9KF
 a_lEaIYEYU_c_7FGBFFs2EvN4xh0en94flH4UFh210TG2C_6G8kEmumqRoZ4SmGN_wQml9oxQE_z
 VvYxvHMd0ocGKXkix4bDZa9.iGLdEKpO2jqMP9szyLmJGLz.7F2vleqARtIWsE3taYdHNDdaGZs.
 7gsj3BD.VOF64i3DHaHu8XdF54zRtSqXybfgjxk5695xX3Qx_GZ6V5jYAoGweQpdU9jOBK1Dh3yf
 lxTrPsRpfy5f.YBlZfx_RJRk523E6CeERMkQXvks6LaYImx.1eOywn2tavE2YcwfSp7GolLsLibE
 OW19kIvxVzH_BTfYswTLnormtlV7H3.1Cl6oKhBP7Mo1waiQPC.k.PqpmGavPOaGIS_v0u2Gf6.6
 jisSF9JCnCSuzUyGTe7LCIfgzEj0UlYg9..ZRM6kHfGUQk1mBA_PRG63iFpwAmwQOK..gStZtijg
 K..A9by1PqfE4l2XY0w1OG.6LJtT6N1PoEBn5syLAalpJlTLz.d4qir1h93XYY91hxJhSDAE7rW1
 2Xfd0Vy3OeXOEcjZGIjQ1.9UC.O_LZr_2RwIFf2u9MMbfrXGWFI1kgllZWwnbYNWi3zxJAJd9PKa
 XhwUKQ7LJ_qUEEYwkrjBim3BEWZXMz3AHovvgWEBylQilFk2ZifFiaxsMXDqfrJSSvCn4V1ZMz2P
 TXA4Og7lvVMcoqkFXoJiaaey0BF108YZugL08WyVQfJRdPsyXN2ribJQpHLBPOcR8UA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:24:11 +0000
Received: by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f455687063dfe584d97e9b33b1091134;
          Fri, 24 Jan 2020 00:24:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 06/23] Use lsmblob in security_secctx_to_secid
Date:   Thu, 23 Jan 2020 16:22:49 -0800
Message-Id: <20200124002306.3552-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
 net/netfilter/nft_meta.c          | 12 +++++++-----
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e53ff7eebcc5..5ad7cc8abd55 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -496,7 +496,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
@@ -1302,7 +1303,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 490d72825aa5..b41c2bbd357f 100644
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
index 9740b554fdb3..259c78d2f371 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -625,21 +625,23 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
+	if (!lsmblob_is_set(&blob))
 		return -ENOENT;
 
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
index b7404bfc8938..c722cd495517 100644
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
2.24.1

