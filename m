Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8FC282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC521736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Nileiq8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDSArv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:51 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:34569 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfDSArv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634869; bh=iBWav/LqSAuvSVxnNUBmym1Fz0E8+WobP7qsqhd5Fm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Nileiq8qe96rFGuXt/BfQEeTxLXIo+KRRc0nhzG/ensz6iJgRYeYn9U8QJMrPWzGMzUZuwMCKZQG/fIpP2XNiCsUvoN3JBo4pS6KpPmtgh2FIhkNlc4tkQFbW5dUw62vSWskUW0M7J3UZ7lJd+RxBbchzYTmVCockUc2CPNEj0CSmzlh6HoUvO5Rh3TeUMcAui4RBy2Aw7ozLVhZ4PRAsJOIdHMVNxQFjy2ZBWvzQ7IVsc6wWQeVS5JQRTZ2/df1SjSo8c2YxV+5MACaKSDO44RdjTomO3ECMAKo1Bur6WWwcVGbG4Vw1LCx0TNai9/WmnWHTXbJXCXM6VMS2t5U9w==
X-YMail-OSG: Iq7cLwAVM1kftIiASQ4ovQ7IUDM1RzJz7wPvqPPy92MNfLVvPWo6leY725E3ZGK
 msklmvCrSWVvGhmmnkrRvSECpDJ78XQu_U4URYGUoJTbCSSwgEQFSLwUXeTZXpMszY0VR0p9kcNj
 7U8nB9nmmOhswDFwtp9Ee9hSEalXrs5oTBVniuIxN_W2sCWnUEd9Hbdajmiw.QUvv8XToeZpPKuG
 m0tKVnqa9PLbEBc8kg_L42GLA1KUrVH5ZA9D1cibkfaNRBr95THQNKlsACEu9bMh61YOdZ8aOfR8
 nGAi.yzi9KfH9KfmogttccstG0yQy2iB1JMmIAPuDJ3PF7N7f3SSSb5SDA2woUryQYkqjVq6drNB
 xP1RE5gijZg3sL3CRFNFR6lkODB3yQayr7QL_Vif3aiaVyVfw0O4CkFpJE2Vey_23oApf2pxW8RP
 ORTJufY4Tx8sZWHT5xoPPjKAeksBev8.FQzwrTHOWq4vPAO_G9qEZvYmQp_.utTGxs.Twog4oTEy
 Py4aQ.6MTtnJKYs6XieSV6tnkGuXjJ_85wY_cBIQFR3826rlW0eG70FXPmFBELLVDoOqnb9sBtI6
 .ocbcgW.bV1saSUjKqFHgkV5_P6zeRV6ICSdDBW4eB.7qp6GpbkAyp9JZo8eLv1y5981gXRsMlQ2
 YrU6l70qEYqR8uXjZWRpYDLeewuIkCPGr2HCwgH.nkBsxp3ar3LSY1NNqOR4b4DEOrYdZgze3qTf
 fcZyfah5vgjA44bR5ol_JE57YRlOGG8k20HUZtXBLHw1mAqUE_uGIXnJK4T_wSFshXTaklx0FHpb
 2hMZSNboItsn12kOToV7y5nsmj2IeNyFMd6e9qNRux9E9np_hQVT_A52olcy9y_ofyw3li1bA1M1
 TaCXD7_hc.YgTFNwX39xEHPYn9JCI.mvp6sfkrxkl4GmSDxbomfJY2HxkExRgPCBZxUhr2sDbJ9z
 fhD_Ewb0G8Ig_rrj.i90NRW9o6faPc7sHW2_fQxfdb4FQDyQ30evAXWsCk5d3rzvaQGCYiQW9WoT
 mt3_TcDFOAokxKldVPl2ChtdgFgXnwERYeHS9wItgQdtk2rDv6E5lNjLWcnUT4Y7UWITQvrTqYZv
 Uy0.QQjIfLwD6gPaJsUzzQAv_s9R56xFXJDTuykFjb.5YWazkRiPUIneEED9teg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be9fa3e2c75d2b77c1de47e4a712b0c9;
          Fri, 19 Apr 2019 00:47:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 38/90] LSM: Use lsm_context in secid_to_secctx hooks
Date:   Thu, 18 Apr 2019 17:45:25 -0700
Message-Id: <20190419004617.64627-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 365970f2501d..ac0498daa49e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1974,8 +1974,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 
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

