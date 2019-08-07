Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE92C41517
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7705E21EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IEtORHil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbfHGToc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:32 -0400
Received: from sonic307-13.consmr.mail.gq1.yahoo.com ([98.137.64.37]:42360
        "EHLO sonic307-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388945AbfHGTob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207070; bh=jeAwtj61x3mTeiR+JjReHIO7CbjGJFrxN2vWv0bqU0U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IEtORHilzKP8fdEpwEuSedPh7Ksr1CbDObssORk1MJm7804Q6fnQ5uAuw1hlN/9nctdd6jOy11K+wnYM2StjlPJIlDqPz0FXE/6cy/TTlS2QkjiAyAGR/V/Esh5iETUXRhjEsj8orftLgoYmJmJhlJeiooW5cTLsYFGsQG2dejuOprBzrON3Kh0fsIECo5xZQMZgJbSQ6A3Z6W72mVfJb2XsL5br1qHXU6+ePqeM9RdXPQ3ytrlB1OVSqHNb+1XqVz0QoVWYkN+Ie464pO4w10oxy1UU0srMSuGs6fpSX5f8LLLugfA9ovhG+gFvzu9rKUyTX25ADu+a8/s0xnoB8A==
X-YMail-OSG: Bejw5wsVM1kokhr6CgGyHXoVKzJkYvcQF5dp5x9Z6f2_XJIsurUK4KIXTjYCvg7
 Jz8j5EgwdEhK7igAK8gRskWMhMKp4fZBx3_5hsGR8rOH.mnB4fNVUsNOM1QRJF4DkWQAQNPwXP_j
 Z0sLla0ovjjBd.yk_t7DmNBktpwqrN4EC0i2.uGNhb0VqNn398W9KbGhp6enyHFu1KWTGKTrpEce
 SQ4hObFn.fFxjorP_Vec5UeZhOq8IekaHA815DT0HLfycrQMe55V8WL2nynS3laxDujuzn44_n2I
 KwK.ciYYkJ.keAL1xsYvzf1ww1cwq2FVN8kTns6wql1tPBOfGUCuWEVbxENtQcAf6xlDau.pk8Ei
 i1Ci3Yd2sNHqlhVHsfaKwjXtqwFQLCVehMstqC_CwRkkOxpNP5cn20yxGTGtvR9SMQaHg.l4yo.5
 SgOdCaMalruCQQWY4A0fO42ad67LP7Yz4HOxAK2Qm18Eo6b8EM83U9d2pcT0cRue8ibvmFvrggpt
 kboIc.fUxZm1qca4VZX_i.CxhKMSAhzpwdekTWVdEiKR_kWi7KIj.WvYrR0n51FD9aK8gsl_izlb
 j9feGKDGkMnm0c1szKign2l54T15VO0akOXfeebZbgoYchV5ruSwW1u_NKz3Qk_sdAE9ozgf0b.B
 Thx06mh7STy09dEqlFNQ.V.JXTKUASDZnUPHM1oHy2pJ4zdp976NW5yC2Hko.kGFQLDKLWokL6Gn
 cyLWaETLYMiEt5.EN1Bchq9C70syJM_n96Gfhdre1.lXDKO5307Gm2XQoEMShJ5zN.Uj9_UwUkJN
 mGUQkH7v29tTrdneGGx3vhoxEIVyLJ6QiPbPgTbYW7SCbXwk8wMVGdoqgPU9oOMxbTwBeZHGBjh.
 HlHiUDqqfGttfenjJPCl2pHGvrcK6lA06JHpBptxPT6FDM8LfkcnedARKNS9B3Tzlu8lqG1AKp5I
 22r3keHkO0UpiXnZX0wzR9i668wyU_4gXZFJ8Ugb9hp8ChM33A3lPKk1NGDnj3qI9gjZqMFPVTfq
 QDEjeMgPu6suynBokqTeaJC4hzaGmKs7YH5JDDaVVe5.EJXJfGZTOOoKP.ZiyyGehJRFyrlM7WSH
 d4LglSR05SbY1dl5bf6_j0FflkGR23Jg9sd5IEyELAP_evHZXMhI_EQYp19wvlRBP.stGHjuxCCa
 CSPVe_YrriBIxcX3ApS.F4cg5yp8RtOfvF8uaUSMTwplxb3DcFLKgPTZZfnqz_VzRKZhNHVPCau4
 zyhmjqvTa.GrSibIkqU3sHP4YouBxiaeemT.GaTRu5.pIQ7jx1CkxFWC9hyUXVHfm4gci63Wrknw
 yHD7SUDo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:30 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58c279a944991d666e27c38577be4792;
          Wed, 07 Aug 2019 19:44:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 08/28] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed,  7 Aug 2019 12:43:50 -0700
Message-Id: <20190807194410.9762-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

