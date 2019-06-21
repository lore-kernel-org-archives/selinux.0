Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B0C48BE3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAC72075E
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QaLMw2fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFUSw5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:57 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:46351
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbfFUSw4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143175; bh=7mpD+7fDGFnoMe/tJr4CjgldfLtTxCzI+FMb6ZtEfuM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QaLMw2fHKpz5vF9+VezvQhrsuddHcpBms9d2m+gpt3qNYu5Z4rbw66H73+z/jkCkAswPQHCk09KJcJB6pbiVd157jBGMPGTU/Wxk5Sk9nM9GczFsV61H9OYzfQAHpzBoRlZaSxiHaMtZhwZe9a7uh7TNMyf2+e4r5Q/NWT7LTg1cuAOqu4pjDi0wTL+u8UIBqrBngXfkNF1FeMUJXK65Iq2Tp6Lw1lb7z77h0Q67o7gB2IgwMALeSZzYQzwDonJx0RpLHqPeIXtluDGucsYzmySBEU/wB/tdIWFxJle4q9AlAVEja1PwovWeGtMnS+9QpMsqqVNnIYkt1WUbBiPTsg==
X-YMail-OSG: W9RvCZcVM1mGu5JsFpqmQFWkWXcRqLfIki.KaVyTy8okWlVfL3dyWvbqq8hWuFO
 y2DXza_T3fXuT7kQ8z.i2QhLGVLxqFbEsZXqMnOMav7xhW64IMfHwVci9xezpE3y0HNfmIRN277e
 GvIPTwuQLGJXLRGZ8ZLIAtJqGoaT4nY1wcRH6uGSE655yBpmuG0FUjuVikjgyo6Z159xqMiOSfi6
 5qn.5kWK.Rp5cIc8f5zi1rtXjP0cotEoKAjsHtnIZ3JUygsuRV4nnlRiYYlUBHuCsAkILiRqBWZx
 uM6fzPCUK6UGo66XM0yPgyYt2b9GOH6T6yB4eD3ED8nOrvpbjJF4.K8HvXvMd1nTxd.d5OD1uDlK
 lolBlOLEFj8suFkERPr.uihxSpH1i4oDA69DtfnfalL9vFlJLCfQq.S1N7WAiJNbKXVNLnsq.Hba
 1yo_5A4a8bGrouj3yQ1Y8hmtkfsfkmqLjudGhabXDhmQ5yjUBIp0.KacTEC8VlB18EF0bLRVnzBp
 Urrvh1zQ4KpItytxRgaqwV1pS6VxpXCy4A3dJOeWtvRTtrtr.yw1wye3Hinp9nqb7XBC8WQIIK1r
 ZFqHhnPND4OWsw2MGYkQhSlJDfBC.auuLcZhQjspSmkRoNzY0OMqS6eYKoYJ6KBxOnyZqibEE4_K
 0_8cEPOHLiGmojWiwNLcqVybV3Im8yFV9r6jc0bW1hztiPTSduf_4pYEAJiQH9Vpl6wNZb.AxBie
 .3hXQ.tyYfl_tiy0xNMxRe4pC6xtrW_3_Qm_SrdG6aLbIo.PDmIap.zRfVXbNbiHIetENfm8g8No
 ONZNwy8V3schqNVmYZByTn.QwynTkGAGTpLxH.sTXh6kXxGjS0NPUS80AopnmerNZWygwiT9Dp5y
 iedQZy.XIF_YwEHXIh_JFg652sCUw.34BxIq5_mzxsRNqKa7yIUNqoEqjsZMltqarcOGYlLfiKko
 JsfGkclLEHHbR41Fa6OhEvGTVu9HwkYtR6MWgZcp2DriQBGAgFT437c0EJujqXYyCtn36XR71DKn
 EzrrdsGtgCaaJntSDzzrpjY4jgBD3iW.xIH1fBtOjToy4YGEcC.x.qzcLx4m3u5n5yT_gCbeRyq6
 2yS14us_ueF8VqMRqqAxD01zOdFRBwZPAfGVxw77ObgTwWs5Orv_CRTPiR2oi4ujw8kGj0B0WgZU
 wePaGpjG3__m2wKrSFkQGm_OlvG2jK9U0Osmkd4WvsTUYj_gPfaFIaaCGuQYl2djQiAvQutBxBE7
 2LEUssZQlLJJF_PoCEucxoCJ.vj2XkubBCUsu6miWyDsk8ZTofhZC_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1d10864c45a2fe45d2b5b4a73ef7e245;
          Fri, 21 Jun 2019 18:52:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 08/24] LSM: Use lsmblob in security_secctx_to_secid
Date:   Fri, 21 Jun 2019 11:52:17 -0700
Message-Id: <20190621185233.6766-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 16 +++++++++++++---
 6 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 905830a90745..b0395d224c43 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -443,7 +443,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1226,7 +1227,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
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
index 987d2d6ce624..91973d3a5f6a 100644
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
+	/* Using le[1] is scaffolding */
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
index c7b3d1a294ad..cb1545bfe8c5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1999,10 +1999,20 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &blob->secid[hp->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.20.1

