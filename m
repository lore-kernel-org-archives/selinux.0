Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88153C10F0F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AE22184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="arY0dk9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfB1WUO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:14 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:42349
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbfB1WUM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392411; bh=jPKwi0Xu4DayYN/NA2jFvINUoFK9sSYkBTVu8ePKagU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=arY0dk9e2RzdapoV2uQhGcvlEN2h9TH0B9/S2iBBIommPNWh/JbTjFj58OjsZUGzH+XZYMhUsb0bcZ7Rj5/BlEv6B37R1sSHHwEg4v2VhpzxDoiGCGIgZ0gPoi/wz+0zfjNSL9CcaAag7ywysxPZMbpRtznCACIddBG+3m131JB9zp015oc1Tdndg4g2ZcjkS8F9dbDIYD+qgePmd1I/VJtLvXszLXjMw20ImlgiDxlLnO7a4NgALB+8iEcvSPY3C4QAxyBv3Lli+MWZ24xhRr3opWjgIPlqV2Al88f9YkX0roMLyghxpQspS85bqn8pXBbfYV0DgpoufIqrVekp3A==
X-YMail-OSG: Zp7qou4VM1klA2D62xK6a9J_Ks5CEoKMv._rWCPTG0qW0MVIF_JBR7uEm63_hki
 8uMtd1SoX5P1FN0rJo4vgcUQ26M1ttWTcaV5viSQKaWkXlHbeUDfJygn0HTcMgCPx1j31HejPO.Y
 PweiIPdTN_X7xnsWVF75kbOX264WbfuFtr4f7hd4qPQfbhi0CR1MBM8GuFI8vYWlCBarTOfaJEdn
 ft8YLNMt4PPjTpuVopr8BObEOefwg7ez.LsZezc7YgNu7_qgIYg5UD20AyQLAVHPSoxGyubMsI8g
 bX_1Z0aRaJZg8PYDwf07UyX56ZqQm2ic75.rVJVryRT8lIs8.WvQyLxZhY7gCnxD7fOTZ8NU3_Nt
 A_L2P_NdMqgVNaM2JY4sTh.1MSgSBS2MhWg77k1lxb6BcFJF6WFVAg4oafPlyy4lCvIKWG_bkCO5
 3tTHfTcBSMDjg.ojbgYqe8FOUq98HEn4g7e9jo7XMBheBA5FVSsV95bWcOwt8XqdPq0UGQLb_Zhs
 OjcjH3sqXOQz9i2V6S3XPJmLKnQv7EXU5gAkft9FKY0w6H8S5nZlUJbTMqskOD1nvOqLvG8pbbgP
 SS_eQ7CvMjCItKnbpq2byBvjPq1_3tLi9ZoDdAvHVm4MGUXudAAg1EpJ0u0CMYUl8JMFF4yMZbSY
 yoKGkCHu2z7yXZc5kQtb5H0KOWoAPvBiOFxNVjgB5jiwTtsDlbjiAYLaUOSqrw0B78_nO_u7YcyG
 8KIptMSKavvIFHe6XxGZEdLVjsj4GL4MwCZ_zIOATCoyEghFQ59lJrOdEG31jb3qLquaaWiy.wh6
 qL03lIsvadYBeRxE5Pbmfpo5Em4tOSMLg_ZdWy8xsS7mOTTtFQC.n_R6RJV9G.NN_CzIbkE6UC8j
 UGW4J.4_W9MWuRFlhltx7cqJum.eO_94RYhBfRezs5Gnx6FdnKP6XUtgDgb8sI7e6RBSiC4U0Dcj
 PeWbkKAa2bEuKzBE5osrXB3VaLVm119IcwT2baNjtIxMg.F4vs7xbV57jhncyNtXJ0hK0E9hiDsb
 H3I4DNvmsuc.giCmPM8MC8l1xCTMDpQ2iUMgn3wUrlK12tJGcIaYlpPpwsLTK3c4JkcBLfl2A9aL
 bf2FZjnmAsBQeyNdsCqPojAI75hTWwCkFdNmJtfZNX.QEFls-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:11 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 44/97] LSM: Use lsm_context in secid_to_secctx hooks
Date:   Thu, 28 Feb 2019 14:18:40 -0800
Message-Id: <20190228221933.2551-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppArmor to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 ++----
 security/apparmor/include/secid.h |  2 +-
 security/apparmor/secid.c         | 11 +++++------
 security/security.c               | 12 ++++++++++--
 security/selinux/hooks.c          |  5 ++---
 security/smack/smack_lsm.c        |  8 +++-----
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index cbfc2a9b5f27..97b258488e4d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1307,9 +1307,8 @@
  *	length and the next call which actually allocates and returns the
  *	secdata.
  *	@l points to the security information.
- *	@secdata contains the pointer that stores the converted security
+ *	@cp contains the pointer that stores the converted security
  *	context.
- *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
  *	@l contains the pointer to the generated security data.
@@ -1654,8 +1653,7 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
-				u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen,
 				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 5381eff03d4f..964d3dc92635 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 69d98a89db75..4e11434605d6 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,7 +81,7 @@ static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label;
@@ -89,13 +89,12 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 
 	label = aa_secid_to_label(l);
 
-	AA_BUG(!seclen);
-
 	if (!label)
 		return -EINVAL;
 
-	if (secdata)
-		len = aa_label_asxprint(secdata, root_ns, label,
+	/* scaffolding check - Casey */
+	if (cp)
+		len = aa_label_asxprint(&cp->context, root_ns, label,
 					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT,
 					GFP_ATOMIC);
@@ -106,7 +105,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	if (len < 0)
 		return -ENOMEM;
 
-	*seclen = len;
+	cp->len = len;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index c81010db34bf..9b25f0113b4f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1975,8 +1975,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
-				 seclen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, &lc);
+	if (secdata)
+		*secdata = lc.context;
+	else
+		security_release_secctx(lc.context, lc.len);
+	*seclen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9879dd828e1c..4d679697cdad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6194,14 +6194,13 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
-				   u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
-				       secdata, seclen);
+				       &cp->context, &cp->len);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2695bd373752..015a2342aad5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4349,8 +4349,7 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
-				 u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	struct smack_known *skp;
 	u32 secid;
@@ -4358,9 +4357,8 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
 	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
-	if (secdata)
-		*secdata = skp->smk_known;
-	*seclen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
 	return 0;
 }
 
-- 
2.17.0

