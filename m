Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D759C433B4
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E79C613CB
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhEMUN5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:13:57 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37495
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhEMUN5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936766; bh=wUB0iYE8Twioo5ZIk6y7nf85VKY6XjvcN02gxsSW0T0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nSdXTqCUZm1Vp+aW4h4oiIwz+rcxGs57ajQWFQUm6e/+iK8QLXnVgkEkokbgjMI57CrWh/o10ZlfCoKUl6770n/oJN4JIE7zPntl9fcs0917OnGQWJA63SMqEKsNmZejfZwi65rXbdR4HRUoZvgWRz0wtisTJv0Afz72rRn23LwQkUXFWj2ve/7Zr1jmLlpAxw4MZdd5ND9o5a+KvW31kElqX0L6tBedomUvR9J0agkYs1RkOYsXJLpoTH6nWBRfjMjshwSj/wsZyFIiyq9OS26gOlDXw3q+dK5k1hZZdepqhr6EyvPLms/dFyez5XWEAs943wbr21Y9TY0fN70fYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936766; bh=tEAjkkTzf9hkTGPbh8mdDK6q/4dxkK9cvxYj2wxIlJI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VWB6MCYCCCMY28WkQXgTrB0wx7G46dHfsLlDL6RDPSSD31A8fYfJOPx2iXbQT5wXlmgFaoxrD6Vr5vulbfgx2uUH/FzOgDjXpNVDwa+MQDl9ouqCoy6XqXFKeWnRHktjtUV218WV7lRg9Lvn84brcxpqVeJ1sXi+6L+/M72gNl51tQvzGBH8AoG57CL+n8K1Pcq5aqqMSDRqCsjlbxPw/m/cCKRM5K4cK+NSwqXtnYYAHdup1CFD4CSR3Z6A1X0HPy0TtyegaCdsjUjCp/hfCpzuVT4MZg2cb1CjS13Is7IooutR+zRMZbHAsH0uzMM9PG6kAD2FSbITrpopffFbvQ==
X-YMail-OSG: 9kXz4IwVM1lE1GhB.wvWjJgckIFxM_gPc9AYuONZkMGTRzYpOWQYGtAAUYsKzH2
 TMgqqPM0ZTF0AeDFmG0oIclSJ3d.BGTJaPsaygYuoekw5BgnRvDbFPFzu_3Qd8djSCgyee4UvpJJ
 YMfGXW0KAcqXv_rE026aSKmgkzs6F4ndAN4ImdTiI2FP5CK47qKaiL0ynxxfHPeUPZ91d4ZmIkau
 hKsUfOHRqwbZJZiB7ZNOXKC32HIHT0HGfRqX6lKT3Th2HYw_gvzPNs7NqnGoFAL6gthp1iQb5COb
 SfALF66dmJubwGDISyIbmfkRcYLaKnsJ_4q2aV_urpfSBy.VoAYoh_MRflD1H86CHwDDbr9_oAhg
 zlFrFLzm0iQQr_BEfh69qAf4nvYckFUsxDxIZ7TkjaJkXkC4_DhwnNVkJhFLQdTnZFsDGK32y7_1
 6GVTBiEzWX4v3H1TGaSoImLogjwNEwGUhLlfcGfktDI9DgzGh5Vab69PjfkFJtrzVZD2LtI.w0xo
 MsJ4Aa9LcRbmvR01Cx3i_LpMs9MjebdHTjQZcSRPkX7SVbLS7FVk8GWVZbZM7fSG_PzZgCpdpAW1
 98Au5CBxkZkje94Xn73NKLCL8kPDgXWbGwOQSG8EetFEIfvRjXxoiuNA35TCfm42Q1A7OK.SQJNw
 jbz9BT31kJwCFFDt6.WZUQrYg1NF6od_DLBZ7Tc0ALmf_ZFk1Naej1ZuiguZTxwY8ZmGq_HgDB_X
 4G2whssJpkzMawQ0pcW6W9BbJol9jEff1xdZz4yt1gVQnh7JUDch4fFXzIyp_K_cf_wk_f5DdmVv
 PO9E.faL_yVsOVQ27dxOMOjLArRosxHQnb5TpN3ID6NM.qZEoFIc1b6OCsVDRQcBoiVAJ0NoKgfm
 7OsYaaA90VrWiw3rb.TtDI95m6m2B4jc7.Gl8.0roRbu8VadUlMpPeA9WhVZrwUNr1q8MFoxVeDu
 a3ZZsxUy73HPuNDMN8ukcRiyEZkHrTP6eM3VvcrBdzJnFTGAYlXzigHXcrtXEN.RvtiHeAoAV4KJ
 YIQNRF6Nta0Kkl6Kg.0uBoXB7SooIahWXyq6ybgUT455k_kOvM75qlRQZeVui66rHUSrvnpxIqHP
 GHLVJBcu5f5m1InF5N7wR4Tnm2uKMR235.AiV7__W_ie_OF3FOfBtVEW0UioYmiPFIogdmbHRhhx
 ewZNEYygSaqrS4IPflNz8CYA6iI7eo4FrjH84h09u8MTA1dfEiohGtj2TQHNJ9RMuea9JA9_gIQb
 VI.HDCruk2dY9_zr9VNSfVQ75cSXY_MX7ydVv7Kn6TmeFsR8ykE7MoBUQEZANFTBM6bgBYGulbZ0
 7LEGc1Kjq1yZWvFGPdNJDyEG0XmPcGSUeqOOkTDHdz6xZSw5KMGW4Pj3dul7Mq4ezpsdoqrRSL5s
 NtKfak6s2t.GhVQo6CneZGLV5PqCfqSIVqXl3MFSh.J5UhpvhLScLPUHFnLs012VgeB2j8Ra71yq
 QHf9ca0fTuxMJjo5tB4yyMWxoXfcet0YTs2.vjRjDAdpUwNiKX7lsrctnsDGRLsxQ1zd1_vY4qjG
 RT2GT.C_u2dubmS_okdIqkk5tQYtU7Z4OL.NXb5gp3VdRJKfAj1Sv9r_1Lj36dUFub8xPcy1tcFF
 S2NyBOKCxgox1469xaVs0qIyhi66Mmb58iv7A8EbcwdC9wduQjoDSoEUw7NGVEsGChzko8GhLp_x
 z9b57jhURZMBreywz.L8HhmMdD7CjYkr.f0oFKPUNzxC5uMqMuy_hA34UXjQHDlQfaTiMdRGafZi
 QZXanTXm_ckw1TlBzPvIWyjQMKIvlEkqrmbGwUIneonUNIJQ67JRoW6XC7JCWUEAdZbSybAo9a5n
 8qbGJyEm.90wpspq6ZzO50MAyiV2rEz1CQLtTXJ8lrLkhqVTRDUNAPvkw23_6x629NBCW9kfc52H
 x6Li.Xnv88k8NtMCenCLsYLDXIwPId7h54D_zVUAJf6CUDIikV2Tbd18wT3_TFkv2g6cwV2Ynl3_
 stk_37rYmWdhkZ8iFl6gyhKt84zWRlatfm1TS_QNSH_tbIgXCOlLUiJm8zHnR4AOh8DdHoGEL.5x
 FDjUSt_qh71IokuO1nNUIfLtYh.zMUs_lVbhCHPowwLt_QDNBxX_yvrm_iEFwgIcODdZaGwYys2k
 BC5OiqII4IGw033haOZ9RDVPa7LMbRgjQ.lYzJxZZsdmFX9cpC194yjY29JGirSSR41.f6.6jCmZ
 _TqGkdfxBP67xSRzRWrsMrn5aNO52t3YwWfO0hRjtt8l7QKljRT3aMRxCqjpunKJiUBTR3uSI.HU
 vi3IKxmLW1BuxAJAaVmU_6muvOp5jXbCN6zQstDwC_0dFPWC1xXyzkzMRWC943PW6PYjt9Kow9rS
 5zDX6iZMCB6QgVnUOdW.kqbtRneacpFcwfKBJIQ5eM60jE4fW3OSY7LTLcZ4NMTEB98kTbTvjusb
 4fsla5XUH4oEErRdZa.S_2cO9RKH9G9uImsfEl8ofQVCAns7TN4T1MEdD61PoUTcGbCZfRKyI40_
 4aFb66SZvz9w9lxPAoXUCpI1f8QSV.88y76zjE_yuCMoLHayUM20w0.wk46CEa67mJvc27aVEuU7
 Y2smNuA91EyY3aW9oMJTUPXKWrwA8m2A.1lobXK9uWDt3wZUjiLsAVS9jQQkkQrkyklskMRWVoji
 jolNDYFJdFyiRaFxcto1T21BIc1ntJxg_CSL7HgrPYoSOZX1SWuLpbygWh5ZHjM7F_iw66yrQGLi
 zxZOKDeJ3q8Goxbgek4ONPJUCNcX4JUTKI7bvV22hsJISL558AjMYqfhrMGfX8TwQtSLjerIpoMt
 48KexM5znbnrTVFJViizCjtbevkysoXhYY4YT5vWFA6uQYk923rjdlIDFt4QCpp7W3d2ov11MbhR
 ary_dM_PiIErYEM7l_6iumf4DrSlPuTavvcQ9G5rs_k3.WJ4oGf1YZUafy7dPEj924JIXc4TFKDV
 xHXSCEjkQDAGFTj5dl3J_kSA6BueQX_CjdhfxAjim6DqAqZjyBOtsgwSJgUqMqe1Np1QDe6rjWeF
 m35pzAZpJ4LFdbcZ8dTedfnFF.T7s63ZLCTGbzjV638FecSnqPB3c.S1RmgwdGCEdWKJ4nVmsn1H
 bkbmKN6aBaoOMrbxZc2hYX3BEovRa4bBWQB2Fl2MNKgOQ.qhEXgl9PKcI4TQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:12:46 +0000
Received: by kubenode532.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2180a90ee2d0cc9936d3029a48cc28ba;
          Thu, 13 May 2021 20:12:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 04/25] IMA: avoid label collisions with stacked LSMs
Date:   Thu, 13 May 2021 13:07:46 -0700
Message-Id: <20210513200807.15910-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Integrity measurement may filter on security module information
and needs to be clear in the case of multiple active security
modules which applies. Provide a boot option ima_rules_lsm= to
allow the user to specify an active securty module to apply
filters to. If not specified, use the first registered module
that supports the audit_rule_match() LSM hook. Allow the user
to specify in the IMA policy an lsm= option to specify the
security module to use for a particular rule.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
---
 Documentation/ABI/testing/ima_policy |  8 ++-
 security/integrity/ima/ima_policy.c  | 77 ++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 070779e8d836..84dd19bc4344 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,7 +25,7 @@ Description:
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
 				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
 				[appraise_flag=] [keyrings=]
 		  base:
@@ -117,6 +117,12 @@ Description:
 
 			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
 
+		It is possible to explicitly specify which security
+		module a rule applies to using lsm=.  If the security
+		modules specified is not active on the system the rule
+		will be rejected.  If lsm= is not specified the first
+		security module registered on the system will be assumed.
+
 		Example of measure rules using alternate PCRs::
 
 			measure func=KEXEC_KERNEL_CHECK pcr=4
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5c40677e881c..d804b9a0dd95 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -79,8 +79,9 @@ struct ima_rule_entry {
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
+	int which_lsm; /* which of the rules to use */
 	struct {
-		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
+		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -92,17 +93,15 @@ struct ima_rule_entry {
 
 /**
  * ima_lsm_isset - Is a rule set for any of the active security modules
- * @rules: The set of IMA rules to check
+ * @entry: the rule entry to examine
+ * @lsm_rule: the specific rule type in question
  *
- * If a rule is set for any LSM return true, otherwise return false.
+ * If a rule is set return true, otherwise return false.
  */
-static inline bool ima_lsm_isset(void *rules[])
+static inline bool ima_lsm_isset(struct ima_rule_entry *entry, int lsm_rule)
 {
-	int i;
-
-	for (i = 0; i < LSMBLOB_ENTRIES; i++)
-		if (rules[i])
-			return true;
+	if (entry->lsm[lsm_rule].rule)
+		return true;
 	return false;
 }
 
@@ -282,6 +281,20 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int ima_rules_lsm __ro_after_init;
+
+static int __init ima_rules_lsm_init(char *str)
+{
+	ima_rules_lsm = lsm_name_to_slot(str);
+	if (ima_rules_lsm < 0) {
+		ima_rules_lsm = 0;
+		pr_err("rule lsm \"%s\" not registered", str);
+	}
+
+	return 1;
+}
+__setup("ima_rules_lsm=", ima_rules_lsm_init);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -351,11 +364,10 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
 static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 {
 	int i;
-	int r;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		for (r = 0; r < LSMBLOB_ENTRIES; r++)
-			ima_filter_rule_free(entry->lsm[i].rules[r]);
+		if (entry->lsm[i].rule)
+			ima_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -406,8 +418,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rules[0]);
-		if (!ima_lsm_isset(nentry->lsm[i].rules))
+				     &nentry->lsm[i].rule);
+		if (!ima_lsm_isset(nentry, i))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -596,7 +608,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		int rc = 0;
 		u32 osid;
 
-		if (!ima_lsm_isset(rule->lsm[i].rules)) {
+		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -609,14 +621,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rules);
+						   rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rules);
+						   rule->lsm[i].rule);
 			break;
 		default:
 			break;
@@ -966,7 +978,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1004,6 +1016,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1012,7 +1025,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
+	if (ima_lsm_isset(entry, lsm_rule))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -1022,8 +1035,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rules[0]);
-	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
+				      &entry->lsm[lsm_rule].rule);
+	if (!ima_lsm_isset(entry, lsm_rule)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1561,6 +1574,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_lsm:
+			result = lsm_name_to_slot(args[0].from);
+			if (result == LSMBLOB_INVALID) {
+				int i;
+
+				for (i = 0; i < MAX_LSM_RULES; i++)
+					entry->lsm[i].args_p = NULL;
+				result = -EINVAL;
+				break;
+			}
+			entry->which_lsm = result;
+			result = 0;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1597,6 +1623,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1614,6 +1641,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which_lsm = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -1830,7 +1860,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (ima_lsm_isset(entry->lsm[i].rules)) {
+		if (ima_lsm_isset(entry, i)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
@@ -1872,6 +1902,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->which_lsm >= 0)
+		seq_printf(m, pt(Opt_lsm),
+			   lsm_slot_to_name(entry->which_lsm));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.29.2

