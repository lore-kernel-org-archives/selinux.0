Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4775DC433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42A964F62
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhCIOrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:47:47 -0500
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:46647
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231644AbhCIOrX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 09:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301243; bh=MhUKNH9AbEvMO9ssyFkO3hkcJ8g8aBBpJhhu8bEdY24=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KqvIly/yQKvccJoks3+rzFPoLgWPIakaTP0pLRXsWcrWunkd6UWztU5bKpIcNJWsnRaN9U0iEPjGNrNJkpaBGoVoRNPOJsdcRJd6fr6NSd00uS4jKGext/7JAwGDfS2i4phy7/5Mu1uPB2BnJi9PnxAVlb4U11gWAU7MmYcxMLlc0K8gL1WAd+vXFmc4w8cdjU7yhS3RCJRxzZLjTIds2pJ2HFLLMBUSd5nbi+0iXNnH5DNAr5qLsPhpp0Yud5Mjgc1ZJ8jDG88W9VzNccLqhaYqvTJCOM90uTgXGBWRk0Fy08lutotqFmD+TT3p5xwqfeB8aWlS6l+XrVoZexPt3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301243; bh=EbN6dx2ZTCeKmydmOW/O/fPJ+xm7qoucnGmPsoB6PtQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=amOwuIGPLz15mTkstQNm18GXqd2mHhzmfLi5vMLmrcOOYCMhu7357SYCBZhG7Y6iyvKMV9CDhAUqlmDbU294CzSfKe+PaMsJdZY2MpZvD2ChFN8O/gBRSIm2Y+NX1yJA6XgdjvxbB5LpEmDBieMYTuzlyQuXMvvefeI00JrqNbve6e7GVJlRSI2TTquCSwQ2qS6h2Wv3fNWxkxVPtPNu65FyiHsqFTeEfXw4+h7v9ZRnRqEu3agrBfTPSUPk1gYZfy9i3N3BmZbPVQRqZyLDr7xd/VaN5pDpxxEYLKQ1s8ym0SRWjV3JqhShCnhgI6fKLvzBfosNIXRv/tod3mrLxQ==
X-YMail-OSG: MCZXe9AVM1ltVqg3sm_lvVOEwaL9bzVDuQD2yQacAZD_YDg1FVlGcIp10LogqrQ
 esET.sviCBAgRXUlgxKof7ivYpsVhBg5A6M.xSpgLwalPX6GgLOQD5GD4pk4IH5DoS4bPis_1eAY
 tAlLiGAzHRDtvUtRh2OeNWmo4UBhFx7bU.2A4ecrgneDTC4KwsK9keiG99mPuD8P37EP8Ey2md0_
 esRaO2eyxZ9ZKEeoenYdrJh22r0dK5YW3HAJBBR7fGacGD2Ffl8QdFKyRCuS.YBSLindX3LVQOj.
 71iSazfz7YPC4zxYhN_LZ5SNbKq.C_856iBtNlNeHzQYyOZKMkbVBFzImbyqV3mIhHAhLKRHKV16
 kkhGqWQDRCe.YWFJ0mKLWSUcmolYoBqM8t6SK3CGjCfGLfJJ5AZpsuAARka61wJkZZZSVh4nycM2
 bwsQSzWxB49ObTCr7F_fpCoEzRLqnKyTMaIeYr41KyVYPawyxTlpb6B5f1Dvqs5l13yLorSyKnEy
 hnCCmo_MmEyZYihNQz0GVgKFy8sxG_baEzC2GAufL6aB17je.Gads9lsUpG4WO.eLKjxMyrEdwL.
 BMi4u3.jRgEnXLIze1eDATLInZFOYDEd2mgOB7QAomH8PtT0y3oZOr8SegsOWYjjnoBPqcaTz9Pc
 _ReMVkUqLtvjJ0S82ChhPV.nL6vfXIvpO4Yp3whLv2BqhUR62zFg7G9P8RXzgzhmoFfDJSlrXeEs
 113UwaB2SLmgE3JM3cD4EbD3TDekRe2c9idiT2r2tLFbQbtsVafK096gwkVrDdmyOqS9hkZy4VV_
 UuA9XkAv_v1evzci05..4uo73u70UJGgQ_J8jgzuRdiHh.2gIS6cag6_W0gHgvDdJaqMPTcA9oqS
 L28G_c_A6Gbn.PvgyrK2xs8eCSX32ZNEmXUavOrYff5QTFLJZVEfwBJf_kmFSiqsvtHUygq4CfKw
 3CQxQXfS6LOWNnC3zWni6_gvtS0U0gaXuQp6RAwh2ePbn1svWLplAOopuvJgDQhqjluIHYtcx5eY
 r8gXnqRgeFn_V4GHA0u2cTawBT1elb3DdWQczliiCTaR9QWr0ckHHbgI3xbEOCQr9TkAbZl1ZsvX
 HVhH4Oy7HQW0eOosxIxOX_kwmv_HgawaPx6wY2FfFniFo.dLDTHQrSg9r2QmbVphBK8Hx7RP6vNc
 kj84kYSOvQR84AH2lTJDl8gXeF_P3CSxa5ZH.wySKII6GILjJeuQoR2ufBp3zmUwvQ3grNhUWCGn
 pr.LpV5Pw8a4ceN8fhZT8ZhtiocnwWB7s.qzg_YryrDLpwYMzA4P2jhU41qXcOMo2UEvoifxajHJ
 cXSp1OGWlyXSHU63AuKmd4g_XVOs9rdLyOV.h8oGpa0URRe.Nm5fwN6kuesdlSDTEe9IeYHJw.B4
 vcLlOkfusDHu4hdvB5Kp0XCAChXJr_9dHWe3lkTC9gi89sybh9CEgN3VqCK9mOGzXLFoaBy.ZjMT
 6Mp6oGaayNYsWPu4x2o4LeJCEcz9BtponzUJA8KKlhSf1NP2F.koQhLAC3k0tYfvbdYoMGEJ1iHs
 JPl81UrdGy5R_Xx28yYLe7a8ZrPQ6L5ed71TcGOoxpqon4WwlaPAQhiFebrW_JK3wmk6EAXo2WZW
 aGtD976Hble4NCREhTlHISCDctfw5VQCvTmlGpPvrWaFM329SkhX7wrd1OLYjwn8mncEDIiFvAWo
 bTV13g85twxQ2b6hPhFYLt0nPH7O9eAjKYCmgnrq.FWZbGu5QB1zv_mYM2vljbop9vd1xuDgYZ2Y
 oAdcls0XwjBIuPnXUcd5.waVjCxUQ2LA90uyf90xpaKG12QMMaSsYegf_4llKDQoSII8xRLW1bim
 KJwsf10ByWVom4w50.mjmaxnonbR4XpL9RB5hFdBMVTfUHGFDWtix35Rfl_Aj6UYq9Pu2Xss8yf2
 .tUERyEyS0kiNgDhjkppoB6fLPS4lQBSa1NdiS3VNkZYQYSu1EdCMfAE2z_5GwAHO.LFB_Rum0JC
 0LUC6L.QNT6sPmqRuXigd8LLGhWxTSlby2IYAqoqjs35Mlp7jEbuayshpReFGKqquqDr9ugLHnvj
 P7pWH_ljODIGvGZEfkTJGFUMUTvPLsHZ17kt_Sor2w8lupu3F1Bzqq3ercaeBHYefLsTV45lViPw
 vXiawqWEEbaDEXHGHEV3tjiJRsD8gEkA2F9swjH6EZRq0dvimgUsFgAHKpM3DbgB4VP_Vd4ls5Kx
 QTrzNZ6T_B67i1QlAX.fqBzTVutqk32QqmshFH.x4gdeGS1sSNhaGXUBqPdkJ62NF0obys5grxI4
 LNoT0Nd7Px451wJ4a1j8Wj6q8gZyBoN6ORHY2FG0_5NQTlbL9ZEXPDNa_JNG.nrloiMFTcvvn0Tg
 814.z94DkjZs.zeOL3CiUqcl0tG9JxDxytjBrmxjCnr_CAm2UUOuTRA50wECbpcdX.kRb5PBHXhz
 DTIpde_S2h8qrGiHbQiVqbTmeVhBlwGIPP05I.ssvVRZeyZsyy.Wby.GopLqWyDfLU4XHzm3CLR6
 puL8ZcIi.7UAZgeAtKTbJKopSOSebRHht9aQUuyvftowlscqx17Px67OvNVMX0geXaSJmZ2XM5vj
 ak3MoGyPKwdwONS.zHplLGNYxqPmcrgBaC01i2RUTWEUqoP8Y6BZ5lBJc8EQI.nJVJUdU8gX0A9.
 UkvOBGHKxwVqtPg83phk6qy_1L9tQIo98ysd0SJX.9PzoataRJho9kOWsVuCNTlrsDgOC6gl6sSO
 OhIusoSbBdiaJgyLLz6w3pcfa_7UYSPoT_dMoQODI0C0D_yoAHNzc4hMkz44mYq0OTzpWQc2aWDV
 yGa06Snnb2H3RKADY3H2GPbKcDNCqzvqbj_LKxuG0uxXYqxPbNXNSTKlA1zue4M3gxIfEUkN14pa
 dgkecdx9TBpVPcoDTtlu1OYWr8oPxlf44Be5h1hE8BlZByx_YxbhJ9cC2yTSVKjM04M23HqnMTP2
 rWkte_vSwxeS3ktCGri63_MnQ1.LzpLQbQC2bKP7UDDLMuyZQjbrh1chZ1IU.R_TDZJC40WHr5Sk
 BSKCYWLoLsgeFhyTE5p9x6.ruWkbUKGO2bS0mR07W54xIF_TCeyZYscBPGNVRGmY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:47:23 +0000
Received: by smtp424.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 020dfdc711ebc6dad7f2870b8cc68e70;
          Tue, 09 Mar 2021 14:47:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 04/25] IMA: avoid label collisions with stacked LSMs
Date:   Tue,  9 Mar 2021 06:42:22 -0800
Message-Id: <20210309144243.12519-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index ce4b8a70ca43..42a11f2c1068 100644
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
 		default:
 			break;
 		}
@@ -964,7 +976,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1002,6 +1014,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1010,7 +1023,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
+	if (ima_lsm_isset(entry, lsm_rule))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -1020,8 +1033,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rules[0]);
-	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
+				      &entry->lsm[lsm_rule].rule);
+	if (!ima_lsm_isset(entry, lsm_rule)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1559,6 +1572,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1595,6 +1621,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1612,6 +1639,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which_lsm = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -1828,7 +1858,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (ima_lsm_isset(entry->lsm[i].rules)) {
+		if (ima_lsm_isset(entry, i)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
@@ -1870,6 +1900,9 @@ int ima_policy_show(struct seq_file *m, void *v)
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

