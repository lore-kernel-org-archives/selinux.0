Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A94C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A527F259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hy4cwR6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfEaXdS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:18 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:34385
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfEaXdJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345588; bh=ZCT9uElDRTx+ICdatyCuPDJ03LmAmILNxQZ9h703pNY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Hy4cwR6JrJ8UjCHGlpDKuYzVBuomXBXVuuuqLkPorP5cZfc6k80vvJ2PCKWKyZlSrqqRFrpv2CcO7ZMvlN2oHBrtho0OBuqVrhWTT5RvcssNjMgkR6U3KKQOcZVkVCyYt7wtQ5qQI7Rg4W0atNmF2ZM11RTKxR8FXlWtBMStVgYozNQBsSK/mO/PNRHvoqKLGE9w6INVk9uZfUbFc/bzNOu67iBKQek/vdkZ1mmnNUGhbHTJMm3o41tOvVa4NntQWgSsJBySBNh7fCuliFnErKT2a0SbgQuZB6vS9f9GNeZ7neTU57ittsE5AQKxlr777rOrBqq7qYWiX1zvbFZF2A==
X-YMail-OSG: S9q.M1oVM1lydW..a_LCf_zcUyqnNW6VI4.WbmoAQ.LISQQxzMELP6RIkS0yoEd
 tPyneQdCWD.6MpNVQgzdJpJiXHowc_EFvXR8XZISVtw915AE4fJyDzOI3_PB_okx9KLDftZC1xCS
 6rooZ3WUN.XXihLl7Meu_QWB2XbTAsJh6YA4UA_FBncUES3WTF9tzu5tV9kOUsD6XIudasyeBgzZ
 25kBhWcXzxoi2T5ZuE.rq1TuAme9UXEwk4fFH6sS5YAfNp.oCAiDiShS5R0hX.H53eFD7UQ6e_n0
 e2Uu3r.qQ_Bc1lEcJdtIk9QIyztKYE4uen6XfP9p6FHQP7apPb7D1.nVMjzQlQlijEN4lgQlEYF0
 ERmUXSz6vsKkv0Q4i0DvM5f_gCX2l09MWBafMvm8EeB3MOXXsamJLXgsa.0HxYBZiYirGOCEzwAP
 vEEGZuQtbzvUYKF4FsE2wI7EHT2nitV..UX18WB_y.5_6S.0BcLkdOGKqsfa25tDTEKAfes7FNLR
 cKFYo3.jqwZujmtJY6rt0atmugnGVz9bZ51.BvoXggazR5.ftXp2cqVTzM2OYCg9dHZVDltwgP1o
 tfj4BwJS5PFGv9UkJ425L4voIul_hiyEVGNQiElIkEUh2hFMPO9HgopSuGJZZxRq4fF23I5vu9G0
 9zLtHAKD5L8H75g5ru6OaSM3BKC_WXsYIouaJMe986dGnRrEHj0zG68d_LJ5ezaC_pHiR9c5EM_L
 3JYiiAo2Xe__9Y3bwqAicJjZzD5qXqflwr9wcZNWA3ICAuqV162MZVOp57h85El7luZqiffoWDH.
 KYr1LFfG7IA8DbFCvSOA4li34T4og.vqrxgNVyTv8HMuVyjuXOzXsLg4VWLElNE.4sDl7H8Gh8TM
 KNhx9m5HZiFfXs1htCjfaQp1c.zYqyRb6OxW5xPcFtihSXYttXQbI8cztCSSoWxmCWsSQOse_Wt7
 .EMhjUfgE2kMcP7XLUQRLmJAoc7rAeGlaV0htjbJClxC3IKkEnIJlVTEGxHqzQQvIFW4zvr4.pgf
 T_oJgDW_s7zk7ObkPSe4ZM1ktb6v7QgcaTS1fSA0YfNoNgovvd7xsxF8w072OueeOmIbVh0Qwxr0
 qC1I3Oy6ABrCKmx_eK58E804ztC51gRYVvLnNpy1aL37pFHcoWwLi8ztr3WuR7zrdFmv88mWY_X7
 VWcV_qZSkPFSfBfqUwW1I1q5YG2SsGo6V8xq_gpgw_G8nfiNU7A.4tKlhwWeIiAyw7sW8dfFdGNP
 .CH7gObpJ5Puua5NACKswh0wwtYlfAV98BfImj6U_ArWa1h2U6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:08 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0ff781cb969a300ef92504fa45022956;
          Fri, 31 May 2019 23:33:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 10/58] LSM: Use lsm_export in the audit_rule_match hooks
Date:   Fri, 31 May 2019 16:31:01 -0700
Message-Id: <20190531233149.715-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the audit_rule_match hooks to use the lsm_export
structure instead of a u32 secid. There is quite a bit of scaffolding
involved that will be removed when security_audit_rule_match()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  5 +++--
 security/apparmor/audit.c         |  4 ++--
 security/apparmor/include/audit.h |  2 +-
 security/apparmor/include/secid.h |  2 +-
 security/apparmor/secid.c         | 17 +++++++++++++++--
 security/security.c               |  7 ++++++-
 security/selinux/hooks.c          | 17 -----------------
 security/selinux/include/audit.h  |  5 +++--
 security/selinux/include/objsec.h | 17 +++++++++++++++++
 security/selinux/ss/services.c    |  6 +++++-
 security/smack/smack_lsm.c        |  7 +++++--
 11 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bcc628cffe6a..01296e4ce474 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1354,7 +1354,7 @@
  * @audit_rule_match:
  *	Determine if given @secid matches a rule previously approved
  *	by @audit_rule_known.
- *	@secid contains the security id in question.
+ *	@l points to the security data in question.
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
  *	@lrule points to the audit rule that will be checked against.
@@ -1778,7 +1778,8 @@ union security_list_options {
 	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
 				void **lsmrule);
 	int (*audit_rule_known)(struct audit_krule *krule);
-	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);
+	int (*audit_rule_match)(struct lsm_export *l, u32 field, u32 op,
+				void *lsmrule);
 	void (*audit_rule_free)(void *lsmrule);
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 5a8b9cded4f2..bea59bfad332 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -225,13 +225,13 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int aa_audit_rule_match(struct lsm_export *l, u32 field, u32 op, void *vrule)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
 	int found = 0;
 
-	label = aa_secid_to_label(sid);
+	label = aa_secid_to_label(l);
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index ee559bc2acb8..372ba4fada9c 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -192,6 +192,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
+int aa_audit_rule_match(struct lsm_export *l, u32 field, u32 op, void *vrule);
 
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
index 2f1355d10e0d..60dd064c0531 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2477,7 +2477,12 @@ void security_audit_rule_free(void *lsmrule)
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	int rc;
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	rc = call_int_hook(audit_rule_match, 0, &data, field, op, lsmrule);
+	lsm_export_secid(&data, &secid);
+	return rc;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9db12f6b1221..bfd0f1f5979f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,23 +213,6 @@ static void cred_init_security(void)
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
-	if (l->flags & LSM_EXPORT_SELINUX)
-		*secid = l->selinux;
-	else
-		*secid = SECSID_NULL;
-}
-
 /*
  * get the security ID of a set of credentials
  */
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 682e2b5de2a4..92dd5ab15fb2 100644
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
@@ -47,7 +47,8 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			     void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3b78aa4ee98f..59a3b1cd5ba9 100644
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
+	if (l->flags & LSM_EXPORT_SELINUX)
+		*secid = l->selinux;
+	else
+		*secid = SECSID_NULL;
+}
+
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e3f5d6aece66..626b877363fb 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3395,13 +3395,15 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			     void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
 	int match = 0;
+	u32 sid;
 
 	if (unlikely(!rule)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
@@ -3415,6 +3417,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
+	selinux_import_secid(l, &sid);
+
 	ctxt = sidtab_search(state->ss->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3e3724bbd6ea..a3776501965d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4369,7 +4369,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @l: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4377,10 +4377,12 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+				  void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
+	u32 secid;
 
 	if (unlikely(!rule)) {
 		WARN_ONCE(1, "Smack: missing rule\n");
@@ -4390,6 +4392,7 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
+	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
 	/*
-- 
2.19.1

