Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81898C6377A
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D40161249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGVALx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:11:53 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:37639
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhGVALx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915149; bh=GlrAXFGsg/Yt+KkWxSBPa/D/0T2x/zGQTm5oPPZ+1JE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r18fIa/wldrDW+VlHS3ZeZrNjDk8RvCfHkRtFSX+vG/QOMV++k2SNc2om/nnITdjIwLdcQf+fi5SPmXqBI5ssfIY/OXBdzRkgskf6khieVdaPr2kDedELopbdks1LxrwOjZSYK3mkCKl0x6o9oBb+Ppt4G/NyTYavbYLsF9v+E+3NLC3l78WgB0UHKJnMopdjVYkY8xhhWRVn0YVmYXU3cUjAK4UGDVIxvdmqBIlC2poill6XLG1V4DjDQL7Obk7eDgBqXyFXoZobKJEQQdwCngPVVNFEpiO9+Q9NKU9FA1CUYXz/N2EbNoRR6Pke38Coy27InWmQUc8yJy5VWnI1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915149; bh=lzo7/qO6mPTyqKFhjEeGYh6Zt8dExGjftyk5iLwI9T/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xu4MlYIM8Us/P/km/7wgqVoST8BAqJXus6WdSA3xs/pDxLMLVxOb8IaDs99drAvBmc2xzMFv8Aa+d+K1eng+FeMPqabktQdePnBSgl665immSV7yUlnqH3kglh0YcDH8P3txUzPjgcqSlPJc0lL7RA+fPA7FPi+EAz/id8vwcEQLzhJfs18Ya6inCiErEB/KmI+b0DkRRG0VjE9plnCw+0Nlhx4QbJ53EGVJyZ43Wi20n5biciVf5P5deOU7X0YGqrt0YchTnGaWa9iW6tPhfG6YIadPUD60Xdp8A6xuOnlAQYvBIF/lTkKO7d9MCt3ZEJARal5rny/G9TJeGy8RQg==
X-YMail-OSG: dAA5Sc4VM1kbTGcBR7tkjHGtcAQLNTBbjACN6ZG4VLJIFQe3ZHcsTSLT__7sLMx
 6.mn4PZNLBxi7SnzwlPYMJJuClXFmWf91R2TJbwPfRFXZ.e_EJd8snUIxeV9nDwngS6HhI5u24Vn
 NEsFyW9RNDC0x68PQpvNC5BKG1z5RN0VELttfdx2XSrhsY31jh9eviVBZJpZ4zPtHegcLSOFh5Ld
 lXtK5Wzf1sIlWoABbCH_KGjD7f.4xsZx6lyXx99jW38KG37TTLgOmNV0C7afSYfiQZK74YGa.kTw
 djVpj2qC5QkTfZz5Ru8GXFiP8rPq9abV5WHkuFGRjzRHupxgPOnxhCvcLvZr9aK32zJkFepw3nFD
 WU108FolPfOc98ZJRstsTsYwCJ3Zd6t7v9T4PTGzrxuFSon_lW5ixG91FxEdTtx8OKMbyXTSm3Qg
 bDPgnKqwWNLssT_LWfduHjXDwG6w0Nkp1B.VMESU23554li9tqomxHosVmwdxNpZb4cMK1cPgCTj
 .gkhiDv3fXJSb5e5cP3gBcCTbSnfGRvTz5ILq1xjFUJs.G9r6IN1jM9jNej3z8WcmKdP0FRz2kq3
 W9sS6rADOEyFMJyekA4RZJOMsO0XOeJfZRhFVdSXrD4q5LkyW3ubO.6szWko9AZ7gSGqNv0O81GZ
 7nvLz3GciltmqpaBvcr05sy9hwYTER9KJvpZpP9iopf_AEkE6vW_u_IXfYVItwbwb5ukcpBqyH8l
 eWntE_Ex5HoGCztSU9ESl6dByDViErWvszJemZb391Gk3hoO2o8.T.wRzQOsGFPqpQg44Dq713zw
 jhnwG9oENq12128Ahi9HAFfPQg7WxKAWui_2m6HifKzPu.hH0MbtAVOs9cT2uDEr..FbXSXbRLti
 9xztvcwd7HgcnY18T3yOjpsW4tBmUKOpvZ93bmcFdiK216AYMX52VkOiwMqPYZfNtmAPmvxPKYck
 rVv.I1F9q_8NA6K9IKzAjbk7jTsan7j9VlWVarRpDXFyQFmBe6edybuWiL_kaABIpDAoHtNJ9Yh4
 iGw9q43fOwVMBtQalrydwiIvsPskeoUJGUVumo7LL.azXLu5zVbeTH2rNpLepASv5ADAFFuxXTrg
 Ut6GWsP8sVSiep_rEgWxrD9Hw8TR8JScCtFdZ.aElsVAB_8h8LmIczdM1tgXr3qZAeFOrlWDQ2BW
 t8IwOEAL_NpehXEKUD1mjzdyIfRW301OoQvQvTCJzcyikA324WfNTAK6e3iAY_6oblNfqCfJ.NhM
 bZ_rNUVRyo9m2H2Pz2N1ksJh6Yn9R0oUykIXX2SJvRosgQy3TyWMiCR4a3BLRlFUepG1CXzk.V9J
 1Z6yiIqMWx1j49wACH4pZoAKFtQNZPGUzPCLAyZjiO5dLcO7aL92AZ1Iroc7rC.71G00eHQggbmN
 Ql80SArgShLo.EEUDPoJYBc7QcxMbei1dsTbq4d6UGZgE5FtpgAedzMs3X_UJfS685u8EyeYO3OA
 pr_kJozKr1lG4c9LFPIZS5jfUj0bpNwfggmnOtJRbpAUXC7NFaeV.ksOeXcpvmsc4bS065Yp3XY8
 vXclb12i6YdY1fqtH65vSRxW3jyMYvG6MAK0Ixfk_alhOZHx2iyVa_XYY1Kwko898fbjSgyFQY2L
 p7Rf.QW_vHBhUgsls.3Ta__DvvOOI6qCHEjxr0IGAEijWPY5uqBT1.BY9PRDfrstz2iJ3cfRJoMe
 IGYpTF7aGMKYgK3aCe6.yeGuZ2VlIYyIwy3ZciX8t7qQ5zIm6DD7du4_zgJ8pnlQY_kfEMI45.Ur
 wgCvn2EFGdh7OburH9DCKWeT0.qv1IY0nIXTiwKAjMB3HojldRP9ZacPjc0AbxTahz6sLv4zRKj.
 7UCQ4G9q8yrU.MnjDJwdGMBl9fSruaX5PT7p52ZrLBlmXUfKKJLtuvhus2rJvpL0GnUGe.HLYwKw
 HQkSmZdwubX9QMPUN9vPwHH_O5_GDBwvKGJPg93ReNkaPR7eUBl0ztcSS76Drzmy8vYt8kZS_YgI
 4IT1FnWvefh4y8DHMfIMpPNkVlOVz_hISBb_GcF4o877MnHJmGfb7IuM8ABUyIM7AbLlq.k9YXjv
 TKM_sojIi7Efsczurikn59Rsn4XEAmgp4Q0Vpr.SoWbAN5X.SXyeKvXuphoyaB6_zQEJHCCKgAPf
 RTGzljMX2bUAZXRNU3LmXL_mn.x0A0LNqkFKoSIrT37XV9ivsckOOLRX8Ss553xzvclOMlBpvFXe
 oPMX0uoiTjdGCboB0sqdGETB9xIZlPlG1E0gQtg39wXn1JFhx1A7eX6wvUEm9MVYEJlsdMhDJC0z
 ZFUtVROcLKOVDtd2Tiq8p566ZkeRjfgzc7fyD7GGomzzeOxuyhKVZlVZd1MWIC6qEtZNYV2nxqg_
 iVObc1WkTtNjoCiIhJ1S0QzKpCrtj2szXzqnkfayLd7aL.1qld.QK7Nj5vyqisWXVGUdoXbp_OqT
 TItKR5CAWv.fzreG.6IC7rj8UPwwKirS0aFBp7pZwxxPfNLmvferDke6EHahNMO5YGsfy5u.oWM5
 DwEfM3AuVURhedpUuPQoQymOVnlPku5SJltG0qthLODxKxtou2sHzOmpbO7SitldIwpOf_IhUw_3
 5TKoYy87X3O6YpUuSmPkphWl95W8TZgSuYB5SLIEbBIb7hFBOpmUFDFjzUvo7J0CC5sK1DbLmZtq
 THoAcS6v0KQP5fHemOBzr_EpS0ktvo5VrlijBPTYuIisoD3BzrPef9r7UsRHVotFj3nOoLJAgItK
 6AvnViaujvgY21hAFc8OXQyUliC875pJ9Ah9DUKzp56Acj7uk_afOQxMDhAm3XXwN3DCmLq2NtvW
 Fbj22hIkVWi9CLCFTiriguyHoSJ3NI9szkzejLDhfGyh2TSG_w3KJlACO2jIgbnM7nYu3YSlALvo
 LUsuokDXd2HqllkmJgknH9qsrAIZH8gFWKXqbyv5MAG1mf7X713APInsTpgyb_.uI8AOhbeNO78e
 y20HUuIdllDm1VMgARI4FgfJsGMKfwsS1bccf3Zq8TLBkmzTaG9tMjPLrc8rTX1KyFwzhlcK9_Xi
 IPUCkAyDSdR59NfEfx_kN4N_uqVmZzLyk5TJmpzaKGhukCHS9O46LzwGFLaMwahI8p6sc27.qVJN
 7aRtTWBE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 00:52:29 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5c8901e1e80da122a250c2c906f5e7d9;
          Thu, 22 Jul 2021 00:52:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 04/25] IMA: avoid label collisions with stacked LSMs
Date:   Wed, 21 Jul 2021 17:47:37 -0700
Message-Id: <20210722004758.12371-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
---
 Documentation/ABI/testing/ima_policy |  8 ++-
 security/integrity/ima/ima_policy.c  | 79 ++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 23 deletions(-)

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
index 5c40677e881c..008a043335d4 100644
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
@@ -92,17 +93,17 @@ struct ima_rule_entry {
 
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
+	if (lsm_rule < 0 || lsm_rule > MAX_LSM_RULES)
+		return false;
+	if (entry->lsm[lsm_rule].rule)
+		return true;
 	return false;
 }
 
@@ -282,6 +283,20 @@ static int __init default_appraise_policy_setup(char *str)
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
@@ -351,11 +366,10 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
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
@@ -406,8 +420,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rules[0]);
-		if (!ima_lsm_isset(nentry->lsm[i].rules))
+				     &nentry->lsm[i].rule);
+		if (!ima_lsm_isset(nentry, i))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -596,7 +610,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		int rc = 0;
 		u32 osid;
 
-		if (!ima_lsm_isset(rule->lsm[i].rules)) {
+		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -609,14 +623,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
@@ -966,7 +980,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1004,6 +1018,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1012,7 +1027,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
+	if (ima_lsm_isset(entry, lsm_rule))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -1022,8 +1037,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rules[0]);
-	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
+				      &entry->lsm[lsm_rule].rule);
+	if (!ima_lsm_isset(entry, lsm_rule)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1561,6 +1576,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1597,6 +1625,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1614,6 +1643,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which_lsm = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -1830,7 +1862,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (ima_lsm_isset(entry->lsm[i].rules)) {
+		if (ima_lsm_isset(entry, i)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
@@ -1872,6 +1904,9 @@ int ima_policy_show(struct seq_file *m, void *v)
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
2.31.1

