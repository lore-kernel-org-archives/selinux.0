Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB3C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373C2206D3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UuEnHI/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKMQvx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:51:53 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:45358
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfKMQvx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 11:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573663911; bh=co4jpZY+mhudboH3Pzmlm1GU8BGwBGVp+kygYlsjIuI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UuEnHI/I7mpPubVIHFlt+Yo9yr14yatATRuVemneFQV8KKyTM0gMuxywY5MlU5i8bKzvbVVY04HRIbubpHdasLvG/bQ0DiE9NQKZNKVpOMf4jQOf+1r5//z1PzN5DqA0M5J+xKv1gdaGTMtDvOHXD+yqKPV2d2WOsQy//oTlEtELZlRbMHPRKVsaQLfyZ+0BVEr9Mu/ycy7rv6fA5R9spBsiyQrNdEhyMIYH+GS6dsln+HJWRMEP3O3HuRzB1JRa7INM3sVq6hU0fQ3HwqT3l/4hepyY65bms57MnpRL7KzK/af24xpakSFqWxg0z0gtCCgt0CvnTJtWnesQgGnCfw==
X-YMail-OSG: IztB1jAVM1kxtayOaTq9JWMhGt2LS8edd2YylrWsx1pW04XckDoQxVwAECbLNuI
 HhCD0dnrhxO6OcAMa.Ss2fbGM27Q1ozaQU34Q7uOjqY7jhmA.Zvi70hytKFazVV.on7BexPuuP.f
 OkdgbfvQVYvH372OQS6WozR6.ywkqRYUTMELtXs7M9AIT0lbKUMCQXsErEOod8PlIsfZexgnOY6C
 IGNmCo620o_Nx4Ee6LjftopZouE9ulbz3tSAcCOyAp_zYBXCvup1M54tiXbVMIS2Sjaej3c_1wzX
 BFF6G5T5anvQdZsHcfv5KKMdcl.dhTXZGyNkpn9Whi80jRIfkVA0NRSrOfSP4pgrVKf_wDosatTw
 XwiJFFJ8eXYtMYGDsO_8_c5t_Vg0RMjOIr4PvOJdySS0vtF5.NeUbKtDP_VhPRpdXgznpS83FGoa
 GByCp5YG.sSNSqZNeVaqi1qy6J5rIqEx3pQuilxdxtgY__8PTOkJHGicGy5t9Ab2P.w46W2d0KhB
 zCQm8pkV7PeQj80DTavLrVKuZ7b.y0CG5Wnqc9YOr0AJu793ISZ8ciNuxPCllsl_urvUuqsIHQnL
 erEXZWZijs530Pw1na437jSj_jVfA0KMFAohkD5n4nmqoH63srx1Opc9nzcLr02umIt.rWwqKVrQ
 FGAG8.WuSQ27kHrdDxNVBcXCFG86C2krHzXpFF7wQOUjM6oPdcOQzPL1Qsx2L_AccAiu3EuGi1xD
 NgyUlMXJUuHfYXCE1FzCEamKqS7hvX5jxTsUKYLWxemoRKU8yZS96qKP_LN9lHDHbFCaGtaq_atM
 x8mWROX1id7CD3nyX.jYy0o2uZItZpHHyJN6PWV65MAmlwA7K3DvR6YTRSEg9DGBLAs79ryrEyBX
 gqFIUbhlVkwArRK.hJ9AT7qrWLlleZxGWnlnom83xyd78c_8wdeMHPn7X0b4bCgofARgpUEfBVGz
 JRoJLiNmYKjM0.abNMXs.vCaqdCeXBQGPlvaiWuQr5uHj6BkWPLsGIihTJrMnYbWpY25Z3Lesno_
 DsHW46z_FBc532g.LQQZCsdlBBgD4je6p7hByxHaf7Dv8Tg.lsmxu6CXQapJv8O23pkIHDRktnDO
 e9QuQuJlZZOpTHed2T_IKPJI1mOojm5eEn_MFXcb37w3F_FBaVwaNA8l1dQRVZIXBiWeWa0HiBLL
 QfEpswVv3ahh5qEIxPSP4lKa6s_Oho93RSIn_FsNZbNLrzQFneMfolMWG0DkiRlQcIGQUJH268BJ
 knUw6OeKIDqIFaKKgkS31a61z3VFM7Ok1kiBLQOoSMzA8A6R.J8p8zrelBmIW7KMvUWFgKmPxsgQ
 ldQPp25OVbhL..bPn7WQy3RUvNmvU26_yv1drhbSL1vqs_rocLG6YU7pXf_Ku1le.YfwKV5B4sEz
 XnpLXiZO8G9dkuP1oIQyNa4_2lAeuaHOe25eJ1HFwcUsrB1jegvLztVFeTthIq54-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 16:51:51 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 689fd9ed4f3afbe656322824a2096f21;
          Wed, 13 Nov 2019 16:51:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed, 13 Nov 2019 08:50:52 -0800
Message-Id: <20191113165111.6744-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113165111.6744-1-casey@schaufler-ca.com>
References: <20191113165111.6744-1-casey@schaufler-ca.com>
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

