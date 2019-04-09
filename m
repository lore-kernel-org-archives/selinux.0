Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1106CC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2BB2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HlwY0lNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDIVkj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:39 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:44393
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=JqmHPCKmgnqzoENFdhELAFCXcZpoQtrMW7bW3NRYmPs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=HlwY0lNhX1FhcFnPElrBurIZ15Zrm4ArjEJP0wdlT6vdAQf8Hnd1Io7idDx8UoqPwckWRmZQCySiwt81+awjQ2YXU6mv1L5HHGDFskYg/402ThG9cLimJj8k9rdE9QCqukBjeljhUjClIjj9OCcFsw8/YQrldRiQhGlgwv4h3hNsZ6rkCbCY44f1qKRMUsMerzs5isiPT46mnKF3nKNaSAD96TqIzQZIfnVQFZVEcM3t6wWsC007LE2nkZzm8BRWfL1DD1uN73m3MFq/5LB0vHgMEocxlfR7Oogjk9SJd1WDbg/4EzUiFsjrV6vsDNfZv04lW8yriPwHdxjWV2sn+Q==
X-YMail-OSG: Gg4XAOUVM1nPPTxCYwxtHpzBZGwRUFRJNoFXnhRROCwsMFhZLEQ7mQf_7Asj5kH
 EhmwWCNCOiKmn2HucVGPOKbXk_RrDZ3i6AZIM2vnrgHP83r9DFrB5pSWuLe5IcdqD_ZgKaUZQfaS
 BCODeL5ix3HO1mXV5TxaLcSD4Iu1ZvwZaGZhJy6hanKu6HWOO5jlOEVSSZkm5lRxmtPZplhm91Lg
 t0OfwQOiwEKwjoCoSxa6ODRPvdghGrXwgdgKmslIHDD3.0t_gx4.myXykA7rP8QpqaSb94Qhys3K
 fhe3t5V97ax6WgBSwD47xaDEZeIPBOUzsXZw7.dtsxqRDUVBWi11WgCv0VuyZTCDHtk4ARtpug04
 xIJXQPxEhY7xemPh1L.wue7ipYTUh6xt.VEIe2hkhDvmJiimGROiWyPa74lumhjYWeHTiJ7TMQUe
 UivwnWHY53viSjmKlIa1m9fNeWnomqk5uUe9zABh29KMJsea3RRvp.L4hZsyjAvARNo2swkPWvKY
 rSbye_5H2k.ZechIMqz.aLRrvVoKoihsAdGyZxokipDdWf1xU3V2HgUcwuiXMHPdRDDooUP7Cd20
 8ROq9T7qf74sEAWDXjMAHHR6ZAZOROWW4XIBBEESXK1jamJYSl.z_idGeARB2bllT6pmv6d6SK3m
 4yjYgkM2H1dhsnl17BKv9_VlyHrF.9hbXFM1rMC0dNLElMmXL9ILEHrDXOkNHFHw_ZZRyL40aPjO
 kAk2wj9bysr8n66K6G8kk3c6Os8V_pEZLgMGCGHkgDihylAslAh8.WS_wv_T.p3B9uZnqkTNcQHD
 iyEsWc286uunRoT2_ptbaCD07xQR0UPa3HL9sC3W7sYElCVlq0y1O283gwQf5eLMPd5aGc3CbXwo
 mkeIv42DqY5vJtcabt6vAKc69lqfj9EO8O3xXWvL1VSeji_9z0p9QOlyAgq7FTdnynsJ_Ehq18rc
 oTXoMNO0zthrqFz5CAmLea6wqngFkgd1XKMEmiMxVt5d2qQksy__3Bh3jgygeLZFWxHvd3vTFWg6
 tQUaXwX72uC2dloehYNR.NzQ2FTpo06QjCBrN5uMt31wwt6as2XlLHNtmGkJY3qp4tq5u4q0ZaB6
 .H7ODeR4wUfxeOiCTRD.hFaJxIIzhdl2PZMKhTAcMBmuG8lvNjpVnQztSyY4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3d2ea789de6b345569f1c9b3872b02c3;
          Tue, 09 Apr 2019 21:40:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 10/59] LSM: Use lsm_export in the audit_rule_match hooks
Date:   Tue,  9 Apr 2019 14:38:57 -0700
Message-Id: <20190409213946.1667-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 59f38c18426a..690ab020508e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1357,7 +1357,7 @@
  * @audit_rule_match:
  *	Determine if given @secid matches a rule previously approved
  *	by @audit_rule_known.
- *	@secid contains the security id in question.
+ *	@l points to the security data in question.
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
  *	@rule points to the audit rule that will be checked against.
@@ -1786,7 +1786,8 @@ union security_list_options {
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
index 03dfa0cd6739..bfd0f1f5979f 100644
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
index 5318b9e6820a..0e048c1456ed 100644
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

