Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE2DC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C864D2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KxRl7PqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfB1WUC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:02 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:39088
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbfB1WT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=PhfowEp+3DGeterhV4KUylGtSjWL9Xf3fqYgDtVzLGY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KxRl7PqP2LIQ1qjrDYvBQM/0SpgUqPCLfHpIjdASJnKXRfcMssfmiDtXTFXhzWM+TQE22Db91PGqJKoYDbVIWe8vhO5vwSScTEn/mu16KQ9L9p4dzgEIF+X81zSIv0Pqbbq0amR5nN1GT/q6jAYUj9XZxoj74GV4VvWmv+ixbER7lXJtattlrefV++IU4x6Wo5GSw6/GUzucR3/hcrookAkd6HdpHtM4Lt+9ivJTj4l+e5DYGUtOxbmd8YYGLBooC+L+HEyaCtfkA1htEpSQ+u1VqMV1MBuSslN2VOKzFO0wa9szQrGI42F8Zx2N9FVXUjXyYZYiO1+qY8XvXqgVEA==
X-YMail-OSG: lPvaEDMVM1mJNMp_0EksKrmn2gUBZzk1XTI2Dn9g4rvqVjUI05toklDwLTgHYvD
 7Cxh.ZBdTkmxxYYCKRf081GD2kvv3c8aSVcze2hA8R10iBRxaLFiHvjiVeewPinF4SlqBwQ0cfKD
 j2WMjC6ihC1rTIM2oCELbUCaGXpv9bqUj3pIv2PPmGEjRc1J8aAx8SNBHAJYxFQdoS8o470u8lc3
 l6jhDNxCZ5S.ybOgnYnD7VrKMtjsnBe2KQhJtMtY1om6mlg4Vs3Yz20YKIkf8DQtNn6xoKIRXk5c
 sbPCQQF_G3nM8JPYyoruSvXveu8KxP51qKyVlL4JmUGWHhk6lA.wRRMrIitYHSyXEC_Y0iN0Fow_
 DgFhGX8A_b5WtSaM.K5dMnUZh4r31i0Uh6zfF1W0qgYoVQjHtbS_eHYksU7ltnK8MiKZh4kVUULu
 5nX40.xD6Los_ARUPjWLpc5YGMVVTQBfwCHsWI0Z9rwl42EPI69S8Yl00SeJYepPxCXEXNM1Xc4X
 PbCtQ2uScfVGaxsFoTgsKJgIzXEn78oPew1qPEOA0XKQbJFCXd0Cmi_457A8h3dXAItHKuqLklo3
 VN8rgPIarDTDGvaKTPKDe6W5h5ePaph4QLRt0lZ_cnOtUatmqH6Jb6pT3d74ntGUkXZAj2lkNUm7
 rM6uVsRIQ0oqxXthrRQFCQRKXSa7LSg2Lfrci.YKVC9DVEnOxdb1MipQpOxCt.5ZYwl.HI9aLzwf
 1PxI_DYskXPyovnhQlZD5b4A_7ILB7WVoObYDstT_eMy7AxpxgUcmK0WIZE7B6ruxJ5JjHdcoY_w
 j4.WMzO0W5AOvj2RTskmZPSALTy.Bc7SXJxafOniADn9Bw9dOyQNFDP94tUCqXbv7AA3L516V53A
 fTxx4PcD0L7Ycn3ELKJFNiMmxNK0ieECTWJScucGmypEACzVPhpnGX7.4G2CrdohU9PJnOXfAS.B
 ScZtG_G2QqOtyPEsId3roz0hNH1DUrfTmLqIYYE3DOP1HQie_G1KmbnVbg5AFNCppQSiMnSVpWbT
 yONySWduNcvGyFz4lgn42Wx38AoiJkfVh7d1LgsCPpd9DINU6tQC_e6SmhT.EL28DTY_TJCTyWPL
 UxmyssfY2mnVKbOs5i6OzJHxujKnZWOtV2xjFS8KtT3tBkg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 13/97] LSM: Use lsm_export in the audit_rule_match hooks
Date:   Thu, 28 Feb 2019 14:18:09 -0800
Message-Id: <20190228221933.2551-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert the audit_rule_match hooks to use the lsm_export
structure instead of a u32 secid. There is quite a bit of scaffolding
involved that will be removed when security_audit_rule_match()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 +++---
 security/apparmor/audit.c         |  4 ++--
 security/apparmor/include/audit.h |  2 +-
 security/apparmor/include/secid.h |  2 +-
 security/apparmor/secid.c         | 17 +++++++++++++++--
 security/security.c               |  7 ++++++-
 security/selinux/hooks.c          | 17 -----------------
 security/selinux/include/audit.h  |  6 +++---
 security/selinux/include/objsec.h | 17 +++++++++++++++++
 security/selinux/ss/services.c    |  7 +++++--
 security/smack/smack_lsm.c        |  8 +++++---
 11 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d4f260812c20..932af86333b4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1341,7 +1341,7 @@
  * @audit_rule_match:
  *	Determine if given @secid matches a rule previously approved
  *	by @audit_rule_known.
- *	@secid contains the security id in question.
+ *	@l points to the security data in question.
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
  *	@rule points to the audit rule that will be checked against.
@@ -1768,8 +1768,8 @@ union security_list_options {
 	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
 				void **lsmrule);
 	int (*audit_rule_known)(struct audit_krule *krule);
-	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx);
+	int (*audit_rule_match)(struct lsm_export *l, u32 field, u32 op,
+				void *lsmrule, struct audit_context *actx);
 	void (*audit_rule_free)(void *lsmrule);
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index eeaddfe0c0fb..9a726892a068 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -225,14 +225,14 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
+int aa_audit_rule_match(struct lsm_export *l, u32 field, u32 op, void *vrule,
 			struct audit_context *actx)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
 	int found = 0;
 
-	label = aa_secid_to_label(sid);
+	label = aa_secid_to_label(l);
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index b8c8b1066b0a..5e4632bacd32 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -192,7 +192,7 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
+int aa_audit_rule_match(struct lsm_export *l, u32 field, u32 op, void *vrule,
 			struct audit_context *actx);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index fa2062711b63..c283c620efe3 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -25,7 +25,7 @@ struct aa_label;
 /* secid value that matches any other secid */
 #define AA_SECID_WILDCARD 1
 
-struct aa_label *aa_secid_to_label(u32 secid);
+struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 05373d9a3d6a..1546c45a2a18 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -61,9 +61,12 @@ void aa_secid_update(u32 secid, struct aa_label *label)
  *
  * see label for inverse aa_label_to_secid
  */
-struct aa_label *aa_secid_to_label(u32 secid)
+struct aa_label *aa_secid_to_label(struct lsm_export *l)
 {
 	struct aa_label *label;
+	u32 secid;
+
+	secid = (l->flags & LSM_EXPORT_APPARMOR) ? l->apparmor : 0;
 
 	rcu_read_lock();
 	label = idr_find(&aa_secids, secid);
@@ -72,12 +75,22 @@ struct aa_label *aa_secid_to_label(u32 secid)
 	return label;
 }
 
+static inline void aa_import_secid(struct lsm_export *l, u32 secid)
+{
+	l->flags = LSM_EXPORT_APPARMOR;
+	l->apparmor = secid;
+}
+
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct aa_label *label = aa_secid_to_label(secid);
+	struct lsm_export data;
+	struct aa_label *label;
 	int len;
 
+	aa_import_secid(&data, secid);
+	label = aa_secid_to_label(&data);
+
 	AA_BUG(!seclen);
 
 	if (!label)
diff --git a/security/security.c b/security/security.c
index bbb206b01e8e..51491fda1bc2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2467,8 +2467,13 @@ void security_audit_rule_free(void *lsmrule)
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
+	int rc;
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	rc = call_int_hook(audit_rule_match, 0, &data, field, op, lsmrule,
 				actx);
+	lsm_export_secid(&data, &secid);
+	return rc;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1004aa4fc5db..1cde918e4140 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -211,23 +211,6 @@ static void cred_init_security(void)
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
 
-/*
- * Set the SELinux secid in an lsm_export structure
- */
-static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
-{
-	l->selinux = secid;
-	l->flags |= LSM_EXPORT_SELINUX;
-}
-
-static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
-{
-	if (l->flags | LSM_EXPORT_SELINUX)
-		*secid = l->selinux;
-	else
-		*secid = SECSID_NULL;
-}
-
 /*
  * get the security ID of a set of credentials
  */
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 36e1d44c0209..7daa44d188f7 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -39,7 +39,7 @@ void selinux_audit_rule_free(void *rule);
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
+ *	@l: points to the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operater the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -48,8 +48,8 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule,
-			     struct audit_context *actx);
+int selinux_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			     void *rule, struct audit_context *actx);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3b78aa4ee98f..d7efc5f23c1e 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -50,6 +50,23 @@ static inline u32 current_sid(void)
 	return tsec->sid;
 }
 
+/*
+ * Set the SELinux secid in an lsm_export structure
+ */
+static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
+{
+	l->selinux = secid;
+	l->flags |= LSM_EXPORT_SELINUX;
+}
+
+static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags | LSM_EXPORT_SELINUX)
+		*secid = l->selinux;
+	else
+		*secid = SECSID_NULL;
+}
+
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4190c5e9e66c..fcd11105fafa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3376,14 +3376,15 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
-			     struct audit_context *actx)
+int selinux_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			     void *vrule, struct audit_context *actx)
 {
 	struct selinux_state *state = &selinux_state;
 	struct context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
 	int match = 0;
+	u32 sid;
 
 	if (unlikely(!rule)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
@@ -3397,6 +3398,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		goto out;
 	}
 
+	selinux_import_secid(l, &sid);
+
 	ctxt = sidtab_search(state->ss->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0bed974b833b..d26a5e77a92c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4283,7 +4283,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @l: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4292,11 +4292,12 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
-				  struct audit_context *actx)
+static int smack_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+				  void *vrule, struct audit_context *actx)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
+	u32 secid;
 
 	if (unlikely(!rule)) {
 		WARN_ONCE(1, "Smack: missing rule\n");
@@ -4306,6 +4307,7 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
+	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
 	/*
-- 
2.17.0

