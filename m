Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9136C76190
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478A21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S84TSR+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfGZXjh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:37 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:41707
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbfGZXjg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184375; bh=jeAwtj61x3mTeiR+JjReHIO7CbjGJFrxN2vWv0bqU0U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=S84TSR+O0+Xm5gryLySzaiad/krOeaiSl27iz9OL1gDrVr485ttqhl2JyMqyT/GwmmXOr3+yuqQ4g3WgufVnu5fFRwuiycyXBk9jQw5FM1KKaqXfZFPmf++y0nDUBhBFFD0CkM7bgK3E/iOblEN0xLxoQWYYg/F7V3LnpBPVe9sr1mQg17lae2zTts8fO62nD54eNCO/JLV2rrTQSbF9iYEubh8ieIWpTIw87gp4bwl9pAqVj9Y4uxh8vF0LWaS9b9w4OoOSk+E1GPKGebMKD4u2Q3wR56LiUXqrvhpN8z73NTrUvxxl7UXNYwy4JzVS1qkqJGWEjzDU6GRr6qvXBw==
X-YMail-OSG: zxLVo9IVM1ln3jCWijUXLjbkrgzXZHB4sDGkn5wbjoRZCW06WwU6rwrulE4U_WM
 3jWn7HP1v8yVzHFTF7Lnb3Aa_IBz8YPrnV15PEi7YH4rU7OORzIz4Bu6Q.JoLuxfODcysCIuQUG2
 Rd1c8c0aCrzz2NcJ1uVD9VDcM3tpZqdAvTyKJwSBsyW3exSrfu0XAGSXlMDrD5qFhM8QK33FZzUP
 2LXspgJ6eJ962yWCnXKjfDta.g3jUNMAxfK2v1br1iVjdh4yPZYQnlH36gSBINA.NDe1JTNJI41c
 igMbCogN9nqqwZGBNqIvSPSqnMH6wi_bi5wMdzB2cDmAJ5NNVLtHa52MsMqneu2e45Z8ecauZjGA
 LK7Y6rJGoWIYckgz1iAcM9k9ljYeOuFGUpPZ4K6vPRa2L3JgJFiQ0JL5yxUPn3mIApaylwdiN07C
 QaGjeoQRdZXRjdHA.zOktWZ1orlHCrrVzmSUukZtIB1qg605sIgYp7qN.izmLYczaHGOfk3OFooF
 EZveJkhC02QYcJTdx8TUEWDcSKP3yA72gEo94fWaehcHmajqgJ1wnwvX1VsjQaI6yPYWP_9RNMlC
 3Qp2s8x12wRLwso1EUlGA4W9GeZypQbia3A6oXUYZwVdkZsw38.0VUF5d2HbSbPacVCAfZiV2ST_
 G4gwQAir8PMLlLITNVp1I8RpC.55tPDcezRAptvtvbo4qwoN26FZoFTNzcbOxHd64mmlrv.sf4jC
 vuUjyUwtHl8SS03tIdXoKAst6U_7GvZQcaWolt9ECjTs_fIKxPvAMVXcsnc3VuCzUSX5CFPGqANi
 6GE1fSOK_l6ecETmO5GHg1lfl3vIuVSsEQztniiYs49wQ0mdagdbNM9QTdVyyZgKS0kFtwyatDim
 tR4Q3yOiF4OmOjd_F.h0QtGmjinRetk9xmq3IKZfWwDgQ6BGjfnKlP3W2TDTCkpvqVmDyh4FxG85
 A26FpsyBskT6mKxcAeNnqGsvN9eZvDucqQ05Pl3TiYPwfZ..MEkPj.jXCbi1e4ksy1x3U_BVAuQs
 P6M83DTAUc3VGEpwfgMdmsRJd5V64K5J4ljSV2O8wrLmMTRBFutD73rvjuTQM9rP7W28PzGmXQOK
 PKOHb0UI.SwJ9ksMjjJzDDbqycXzbvXtzLC1aIxKmbRhbl_XoMRYDUA7CzkWEgbPSlH_aARPflUa
 skmp5OvVrrbShJ32I7mrikN8W.p.7yd0QVv3.ew8etWZvKcHnG481JZGNmxu17BPK23VWe_960pe
 urRCiVdTCOXb2BmZu1b9oVINlFdhyWoq.ZSLz27.ciICrhcMOog--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:35 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID faf3134ce3e2400a4a56efaeaba728ba;
          Fri, 26 Jul 2019 23:39:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 07/27] LSM: Use lsmblob in security_secctx_to_secid
Date:   Fri, 26 Jul 2019 16:39:03 -0700
Message-Id: <20190726233923.2570-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

