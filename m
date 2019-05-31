Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49889C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18104259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d2B2pTMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfEaXdy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:54 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:42146
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfEaXdy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345633; bh=nhyQ5HEMViXMwzj11P6PbXR0lPC7xmZwGngBq91che4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=d2B2pTMT7kIwvunJoM5AGpdOApeA02IXiPqAQFFxqxdgNis6O6fWs4Sb8Scl1GYkudehSGxi7pvi+oPRtDPDc6TePZoFNZJSMLpBjX3l3hCEHTEGAhbbwAfLltRCpKUXEqbxYmUkNS/6P5OtwRy2Zvsf78BYuadGpTeYTp0VJjbZq8o7qt6LHlM5rCxEVUF3KpizFjcA/RVrIrcoZvS9DVyQ76jps27ObOct6iFTu45t6eFRmmQLH6zjiYCYLFAmF1zM8GCx64ghJVXAtAZ3t3R+WMZEoABbyZSO6WLF+JvpUF10wKK16CpWN8nustNvnRMnf2kU4+VsqB335mjZzQ==
X-YMail-OSG: n.JRiCAVM1mP2wcooc_KRGuzx.JsjpAmaRdP7VsvmaeKTghWla12HXY606hpT3B
 1AjFht8qPK7fZLgEKAAQf0Vu_QGGPnDFillz_fyymz1ZkUCaNboMuyCkoG_KlDTCf6mX1O64KGyV
 xXfDFTYgVr9Jy1Tq8HPm7R70z.qa9VwUrpDtPJ95lQvTVjdJjpkjhL6vX51LW3yU_M9YmqhoqUly
 cFRxhNmFflkYGh.kqk46f5oH8eYn8kkb.2Q8KdR1z4Hl_M5gZZkjUGuy8Pe96h2OhdXGpFRTQpcB
 lGCr0_R3eb.J3ZLkMOjlQFR2SCyHj37WWLO_zua5G2Jtm.UZdVBefhKFEan0290NurOY5kwanLkn
 Tx5cmoqIkaLyAt2vWMZIVu18NFuC3.8fI0HXFvDqA8WordSMYBpOSCiNzCE4oss1C5SxpbcJzQdi
 BY3l9ntQsoyOzjcFYjyFvM40uHteTe6JE7fmXgLG0ftFkdl7s1W0g4DmiH0cwruN2.aPcLIRAKBT
 lGCAmuCsvXpGOxxITNlni4z5pLgAur6WZRbL7ZhlmgxWH5IZvx9ClwOAwzH6AmBQwoY.L7fFKit6
 P5ZpgGrl9TvaMZDWRpbrhWnhJuGb0c8mSqxi8atopTzBlKUM9pwV.lc_Bmv.gSkUI_FqjeRKYkDY
 4jqwgz9T8y65hA2.gDemaMjZWfTbPvBHo2WjC4tK2Na9DuBOj_4gvER0fPkikWVQno8mLhEOBEV0
 G95k_9Jb2QnfoYlHcZMgFo864pgJafAKZYbx.6HOb1TbSUqeev87GE_Hm5R7dskn3pGbPXXfDwZB
 ZgyU0txaqFR8MRVYRBx.LsF0M30JxZa85WcH0nFOMnxJWjghD7YAGWLFSfgHFSSWxkI_uzt7hTpe
 aMM_qOGUdv.TGuMENbZcsfq.KwmqahkUA3kMJLkKPXW8UL6bAA.e.1jj66HHo5_ua5.sUms63ioW
 it99y5.rFMyEvsfWKFeVo5pvdWeYIHvI6Ggz9gV_R_2Olj78GpSDyKtf7H3OAMeef719Sj1VCc1z
 r3QPecRNnaRwF3hFBuVtmXDA7TkBruvKmgnkne9Te_WGekEkriAT7cgKBRkIzB.mi4mwLLsS4Vi8
 DeDyO_Yn4FgBRv_fz8vh0eINzjo9SS1cB3ZyAbZiCiq5rS9sS0usjocOFWBrlzSjg7CT8Zf3T8kp
 6CYRhcVTTylMpWUw0w0i3rx8PLgG3gKCSVnT9hAdYG7JtQguPksJl1XbfwUiO53GkKzpYFLdsEmf
 rALp9N4NzZVZbjj1O2qKnszqvKrlBFbd9nSev2QaTaQCjdlL0CvGzBwmntvQfQ..RkFWbqQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:53 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dff83863137057b31af62ce7e411c239;
          Fri, 31 May 2019 23:33:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 16/58] LSM: Use lsm_export in security_secctx_to_secid
Date:   Fri, 31 May 2019 16:31:07 -0700
Message-Id: <20190531233149.715-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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
 security/security.c               | 11 ++++-------
 6 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e3f5c61b9b2c..991d2d2e290e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1220,7 +1221,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
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
index 987d2d6ce624..598bea8e4799 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,13 +576,15 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
index d8300a6400c3..868e9ae6b48c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1967,14 +1967,11 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
+	lsm_export_init(l);
+	return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.19.1

