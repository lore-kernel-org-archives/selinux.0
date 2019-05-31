Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D78C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2418826FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aFdp5S4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfEaXSc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:18:32 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:39469 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfEaXSc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344711; bh=mT7CWYfSqkiX5vZ0p/C8Hg9IONMlLrjlhp5TmNjwBEM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aFdp5S4fNbErE0yvXikDkH+UEfemnucaafrs3X6CKk/G+Dz1xI8CqQrh1xZdjXrecG3ZIsabWpUXuyV1W+4uV+oU7CENnCHqXm6bj7+pwZcEsL1q0RYPpaL3bOYZaUbZ6YIBzP6hiKJSI8+Gu6c+ARh5J5djxRLTQ78a/AtPVfUm6R81/F/PerxUEwJZEG3Grmo8DXZWC3EMK1uss0F56zfZrBNbyJvohYVaUOAJmsqkP9ZCiGDdG/awijrM0zdAX2LpLFhbFjlZq6uGgFnDDKvRBCz1X3wCPfZRqJmtsL13PDiKkNmV/AxQlV3q/UBIwpGShre7VjKDpHz1tBqcQw==
X-YMail-OSG: iJqhqqcVM1lvsSsSfvubsBwfHSnTAP.RQfFEYFdC9Fwv5nII4chOzH08G8fQRWk
 jHADj8gPdHNtoLwFTqSsdaXRp5D4G7i4mihVkX4vxtZ1PlWP7q0NtQqKms_F0RLRDIUP1e8.a_eW
 wDxgJmGS3Xz8G44uL_jxYy2LuHoE.fZQoVZwzH0u9ag1ryHqatc6psoBVzTQSNqxK4aN_I4fGlHR
 1IIXAE4.EXzNuuaaweIvDzquEyJE5mwgfQyVOpte1suG3Dqd29ULekqFB2D2KsxhaWwL6IMQdZ2v
 2Uxtv4Jn2guiRJp.yN7wgeV4l13ZyXaGIrg24cb3IdtGLh5xoTND36XabrYTbI62V_mtiV.AiCMN
 HW4orVdveHqqeQeIr0CpIlfCMdvVu4lqU1CEF6cyIg5iAqB7B3beBocJ8HxIiS.MP4I.ZOjhnaW8
 nd3xUM7ZwrnruJ0hHAbkK0iMPNmT8VV0MIOhybSKGs47ycNYBK3d3YbSpMEDs031DFCSUdIK2Slu
 KuwBdbtWGhbAvh_N2rNkfmRknQ2WSo4sBYs9YGqf4wRvXPtwMlWNwtZgN5hRCZuyJRz05uVBBhpN
 abHKwQ6I.ZEXc2xtfJJcIpV.7Cf39neAQqWQDUuwuOsqdaczVnJW01Pyx74oCyGgDTdcO70yFr9d
 lkbqH6w5PUJVGAfWaZKYVBBfTs3Tn7TGX5frAEYleROW3orxgnn.nWXthxKijpntb002OPBlxUHL
 AwmUbqy2jgVxnHAfTBuuI8UTWIBAZ_ZdfATO8EdT08OatvroukVl7HXAlG59iWx6RaaWN.AkwYOP
 xqJBtWKGkVfvevIV5TPL60Vpw8rApyg64Kdtdr25PDTjNbEnQwvbTmgRPqsHNQhIzKeYwT9FbdDJ
 1t0ub1Etba_IH3ctUwtJQrxXrOVMUNQzIqLuBxgreHhqPasapmg7V3ACv9roFvRYYxJEJTXHk6r0
 1HTFaeqARElzO4jvIr4DnqL3Lruy1.YRSjSa7_QTV9lum109ahUaWdDWcIGXV.GcT2qAOqX7lbPv
 vvigE0mEEa2pUguFutWJVeXp6lkRCAMqpaGIQ2xi1e4vh7_Z2Dnwf1Z2h75VMNJVKhbbCgs5RLr4
 zXZem3Dmy2SzzUXgpTI3KzOK6_gaBIFDwnBM9ACmyYLy__cz1YiYejByG7r_gnrIZwgnz.CNas89
 Q9HC1KUaXca5YqpCmRGGvhKYigDfu7ltz_1c1MxPcor1qQUnUWbiTm8zPFljcMd4eXq8Cx23tZDm
 3QPBAss2MK0vTRJo7J1NiVnpfz6U2y3.HtLBcaFTcgiHEQ6lJsCS08ReE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:18:31 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86e200249ed5328d0602f8eedef58520;
          Fri, 31 May 2019 23:18:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 45/58] LSM: Use lsm_context in security_secctx_to_secid
Date:   Fri, 31 May 2019 16:10:07 -0700
Message-Id: <20190531231020.628-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secctx_to_secid to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  6 ++----
 kernel/cred.c                     |  5 ++++-
 net/netfilter/nft_meta.c          |  5 ++++-
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 16 ++++++++--------
 security/security.c               |  9 ++-------
 6 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 90d1ff7a2fe6..3f757b2d8275 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -432,8 +432,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l);
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1217,8 +1216,7 @@ static inline int security_secid_to_secctx(struct lsm_export *l,
 	return -EOPNOTSUPP;
 }
 
-static inline int security_secctx_to_secid(const char *secdata,
-					   u32 seclen,
+static inline int security_secctx_to_secid(struct lsm_context *cp,
 					   struct lsm_export *l)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/cred.c b/kernel/cred.c
index 7792538b1ca6..ebae67fdd4d0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -724,10 +724,13 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsm_context lc;
 	struct lsm_export le;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &le);
+	lc.context = secctx;
+	lc.len = strlen(secctx);
+	ret = security_secctx_to_secid(&lc, &le);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index a1d3dab5bc25..f25b26318d72 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -577,11 +577,14 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
 	struct lsm_export le;
+	struct lsm_context lc;
 	u32 tmp_secid = 0;
 	int err;
 
 	lsm_export_init(&le);
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
+	lc.context = priv->ctx;
+	lc.len = strlen(priv->ctx);
+	err = security_secctx_to_secid(&lc, &le);
 	if (err)
 		return err;
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 9a2a97c200a2..a06e50535194 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -50,13 +50,16 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
 	struct lsm_export le;
+	struct lsm_context lc;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	lsm_export_init(&le);
-	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
+	lc.context = info->secctx;
+	lc.len = strlen(info->secctx);
+	err = security_secctx_to_secid(&lc, &le);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index f79ab91bf25e..707ea5a364b0 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -894,6 +894,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	struct lsm_export le;
+	struct lsm_context lc;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -914,10 +915,9 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
-	ret_val = security_secctx_to_secid(
-		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &le);
+	lc.context = nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	lc.len = nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	ret_val = security_secctx_to_secid(&lc, &le);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -945,6 +945,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	struct lsm_export le;
+	struct lsm_context lc;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -963,10 +964,9 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
-	ret_val = security_secctx_to_secid(
-		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &le);
+	lc.context = nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	lc.len = nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]);
+	ret_val = security_secctx_to_secid(&lc, &le);
 	if (ret_val != 0)
 		return ret_val;
 
diff --git a/security/security.c b/security/security.c
index 4f999cfcf949..44a4402073d7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1987,15 +1987,10 @@ int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen,
-			     struct lsm_export *l)
+int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-	struct lsm_context lc;
-
-	lc.context = (char *)secdata;
-	lc.len = seclen;
 	lsm_export_init(l);
-	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
+	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.19.1

