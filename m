Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0064C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8820820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="b53+YALO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDITTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:31 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:43308
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbfDITTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837563; bh=7gPoCWetxgh6OIRNGIIxTECY/QFBwCB1nRYgDUU/GGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=b53+YALOutjx8gi220EBfqI2aO9PHO1t0UaWRMIiZos5R5Qag3q6Ey0pjiAWbUQ6GIENGlHdhAdwWKZrl5mM6qKq0IQGFJYCLF82CtfVP0lc6snjMxRTKMTuWqUpbmUSbpLLZyo2jKm4x9qECSUU+FR8YF40yWYmb3A63DKh6xXE9XrqgzMF9BuCV2TzDnmrecHoBLzJpEM6o79sOZjccbp9gxlJscgJyckIk1M/wVDqQPpuZJp+UYZnQEJWvkY9ZKdAqepb9b1Tn4vLhSp7deTQgQURR53NfZMboEZ8jTb6XnBHQQhaCBXGBcaI4h6ijcT14qqWT2D98rmlq1BmeQ==
X-YMail-OSG: fSo7JpgVM1n1JJSauni1vnUxOHbZdmZCWGm_gl.vTpUI3itnhj3UtP7vedoMr53
 1RZYdvXaKgbm.JXZKhnje5UeOYLVZU5ZNSOIcDx0imgbf9CYjEKk9jPPZyK5pibzj8Tw.O8hIine
 mTVUITh4trngk18kxCpJAgIRqhZtpmHm4idioe7CxKz0wI_.n0Ef6AKO8ZRyovL67hoQrQB.LAe1
 4P5UQJj.G4xtjSL390jIQTpqiAMO9GEAA6XRYGa8alvFHuvmRiyTVaW5Kp862PEEXJMolg2TQoMH
 KAIjCNZyT5NZpS6I1slIWfFyZb4kE5GEjblxfstKFb90D3s601AXuCLLjCheLfEsDsGC6mzPwwgg
 LRsd.2eqOwW66ypA9JRCcjcxEYKoFTOfMXZud0udqR13nfYYtxms9AGoUvvg5AMmurvTfE1feq0B
 igaRBUxt8Tvej41JowHDtgNBMDXNUpC.0RW3zHvM0V.oZ.8__psO.7FZMsDFWPi1XvETrUA38dz6
 Wh1kNWpLZkvR1t3_c2dZJunOTuXLxgA0_4LbW9PUIkFOoNo3eedRk.g75SDJWIFOVYS_2W8dve4V
 m5CwbsaLB6niSgWRE6FNHJ3U.LMed6aLb6Bv41aziN9kDTop_P6uv1T0IDs7nTBeoLSbkVQKkU2E
 ynHsj55U7W32u00n_dUERH2JGvPXKiVLwge0hhxrxvDOpCEvKwQ6OlpOBh3l068r8p5eOHXYal.D
 yJpOc4oMPdgUL93jhPn._Ft877F6xKtjnnxWbin5U_E0u4QezMLkKQioyc5AhQ_snhAVisDkEPMq
 _nyYrFHmbdxMrEWTTHrSEmoYSufAusztl2IZ6FRdGd3QaOOVM8mKnHzZ0U01DVhwCGCnsoYtb4U1
 RH1olyXMLMY8IvlYxwpJZJo2HBD38EyPrkBj3EuSaoc2yPTTUZDprKi5zusyL5wrPR10ZT2d0ZSw
 .5VzWhPOLX07PFXpOsNlN02AThTEBLb.gWwI0nvZcRc1ixBY9n6M3tOdY9C1IW0sc7Zqf6LS0FCb
 dbjimAC2Y9hlNUPF.ldhCGTqXLub11NjzXUPlMrxo4S4HSNKOAVvBrVz0mLyKa_22ffrm1vONyob
 8Rp_Og2n3g_a_O8O9Ts3kWsxZToBfK9QpXKLHqi8niwU6UhCqaL.bwp9.3PM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 38/59] LSM: Use lsm_context in secid_to_secctx hooks
Date:   Tue,  9 Apr 2019 12:18:27 -0700
Message-Id: <20190409191848.1380-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
index af0bcdf8fcfe..566714aa0caf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1323,9 +1323,8 @@
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
@@ -1672,8 +1671,7 @@ union security_list_options {
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
index 7bf16c547010..7cf8e268a45c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1989,8 +1989,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 
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
index 7dd333f133db..6a2a82dcd948 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,14 +6301,13 @@ static int selinux_ismaclabel(const char *name)
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
index a837af153ed9..10d6c6a1a001 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4434,8 +4434,7 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
-				 u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	struct smack_known *skp;
 	u32 secid;
@@ -4443,9 +4442,8 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
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
2.19.1

