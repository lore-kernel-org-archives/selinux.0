Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C5BC433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEC3610C7
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 17:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbhIXSAx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:00:53 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42870
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344942AbhIXSAv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506357; bh=MBg5DT8kcNaAjWC4ca3qG/0B/Qy0LwbwlLvBZoCnmEs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=blTPhGqjh+aFlB3oE66Nd+zNfaApdKBSKkqup1onzjnKN2An6PsZPmNLb9imc+zPbyKo4fO2VUXMNMi742McZe1ihJV4PCBuCHT2ILjq+1+9YTua3NHe9GiPbvX8y95SxdDh2rinPg3ZiVPDbCv+p36tOyHY1yPCw68hYsvfBwE5a7PuSSn0j9JCgwX/jFbSDt4XTZUwLy4iBOTtsOOPU5Us1W9Y7859a1ACVQGOeAwQI+3/vZ4bpzaTWW3P63ZGZdi7Bb1SEZKSk1h03VK8oX3C3tOTIgTcBo/KPXWCaOslfmMS2lQpGDb6WQGvgsPMtfha2onAgL7xNE/z8Fx9yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506357; bh=nXOALhki1ySgsBY8RsE17RSwD1fxGYQP/fqkLOODPzV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=G5aQphhVsROW6Z/MfaFmbXGbX675Jz802QIHHjpkR8V4GjGZF0Z90WzI5k5eFCqT4L8UhcBYCCsp4cUN1bfIyNg1AilpPLSJ4D5BNWMgM+UgwquWsCxCSm+MZbFTemVIp87zp2Rq0n95nqBhG732K+uTXd4egrd1w71scRHeaP3Qa0L5CMAaek8Xq/7uX/37A6xK+zCSyTv0Sp4e0ydcwnhJ2AQy5zl1AeSNmEClX7I/zXMvFEjz82fY7GXCtoy7FipEBiTwwxUK1UIdXUOSVvi6sA/1H3HpPFWAphx3gBRjnsaGaaXT+9AdNqZVgRFy4ErQkGSsCN6xfjqtECLedQ==
X-YMail-OSG: gcGqTZAVM1n8e.hStoc7oohaohiDwmAri2fQpaO_QXFeZERAH7wHGHmIXb10ygM
 WT7HifJnI_P7bDVIIWQRxPvvXzo8nVqkA3jGGPjT2K_QERYuTLRUheUaSBXv14OClvPWAhP5SIhk
 eZo0Z2U.OnopkCpVgCdGR31WDHgDVYbRnVkqSGkVt5MbmWIq57Wj0sSU4eDr_OM.YVV.TeZtlmep
 Chk3aqfcOGhINzCCyHnHjpiZ6AZzufhtpumCLYRF4AaG.78e6OqVp0DiyNkY0yrZxRiYvSk7SzOT
 NxeXZeArtkvUsX63WNYV6TCN1qlBtIDC_xF3IMFMZdzNbNa3.kEoE0eY_WtBRRY692DOttxP.61Z
 p2IOcBqch48stwVb6KPm82UyglfLAEjS_pt1bdLsa15EaQyejzbvt2xO5IprDHGpFJki0pmpl2nm
 fK9gzjLHXfKrtdhzYpVH1cCnYeZ7wTqSSjHWEPb_B8E4EqjkEm7NJypTRJPerS2giXXTiNK7Mi6t
 bt2SxGz4NQcIwKeVlhUIvTSzYZxaOaJoMjGv9U7FRpJe7WWRB1OGt6YDLnE5IuxRdpPbrRpsAiSN
 ry_2iATcrtnVKUT19f2ztZT5yzrNi13f5pOVFUzeg45p.4UUrHgBzZfti_Bvan012.0Qk7U7lU5x
 .r53QuyzYKSygIQn8Jj.ml1NN6nkIzornLcUncQbnhQfg0qMTRsD0kh0HLBPao4RKjw.3uZC.rAI
 wOa9VurSAZnl9C5ligx.wHNYKwatK0qOY6WNKYDaRohZBhdE6R8SmgElD9T1ffb7p9aXjm9x.wtE
 444ZcxbQbQMjoA246e6wxo28wXgTm.fQ7OfWNmLASZJ2Hkkl22HopzUF_Tmbu9YLXQUoBun8KHNe
 cG.z9jN7esicaDd68XKVTIrzuv7.IWH6uyfPavoq7FpNcTV_YWCGVwPZ2HOh.jK6ciP3aYhIa1uE
 6gSlL_Zx7d3YtHtEQsxh6R.p9pyfLjBiegP.Gf2hzsqBG3pruBLMaDl4zLSBpHoO14VlhVGkEChR
 XUCfQfjRTkJyV5hTGa4.TYxKlXsdA96PdWKNUPIGpokrMLmNGLRzrTZi.QznrIKEmDBCqB5PLb.j
 S6aK8POk4ndwIVVbtmu5rLjpABxxg.X5bSrp6MYo.2L4RDKcIqvOvJAmD.azILG_b0bkRpB0Hk_B
 TUKOI2ePaGzOaG22nn66XYDix6_bXtAhyQRyghlVBNJnATlQscJ6DLOCok_0WXDFZZOIWsOkPEKE
 dUz.yv17dlc98Ib8z5uPNV8Bquv1Zr5pNfp4Oooy9VH56o8r9RCKfLRFldrI7tp.4Cd5qg78DmYY
 OAcdRNeVCKy01F.ATFheH0boN2T3KBz29.e8Io3eTtEKycJ6CfQHBpnAbN.PSltNrs5nFt2yU3h3
 fEf2RMVs0sL6yGEFpchAefi5uZ0JVwj1mJH_1vfKeR6nAWrohaJ0ekJ0b3rFq.H8NGWeumEJGKbB
 BmjMkJ09t.nmJDE_cAS_Ctrgby9L3HNeg2asyLZz_gePcTdwJ23Oge7w0.k4TGBuQGAb80st0Xhx
 whWZfHjjZ96F6rCGazksMa1t4.6Hm3q7qcUt77.q_ajNgbL_joCP2OP5uO4ESiXTrCi_wpBAgcuV
 5FnW_LlzrNOe2qhgaPQMmcaE0YSDMgH_hX9F70E1q0NjkPJWTKt.XsDPuMaNP63WDU9EdGEI4PAp
 zWcuAsxf1k.T6qTEXQxSgihlofFzBQAWJRENj46_bSOYVi900lfcwal6h_j.ZsZRJISK.8.j_Ogk
 VuYcex2exy2ipldGn4ni_6tl26jvGhQCA6g8kOl.4UQibKXcjF3RjJbNjEPlL.0HEp48WuqAonHG
 .axnMQguVl4_nxSFzjy0wg9TcCcvX23yKT4aGh.4PIIHAfKiOZv5RHQMd.6P805Hs6Gur0SPee1S
 9mx35RlnrXOhyDkUx6kLdTZaDjgFUfCg5Qggt2l09Nq1q7MyKvhXPHstYcNL6YY4L1otV6HWxoyk
 LAFYCK9SCn6TXyrGWRNldA6G2cWfNHeukks2EaOYvbZXl9tzL0bXj4O5BFwvr_rrRZoccb2dbt8N
 NcQXi7hZzgbDz1q0K6tNtbaVNz1OQFkIoQoqihloQiH2DZ1i2GbAMpRkz7DqSxgVMEhvcAdK0mhJ
 Yz2Z3W_3YwTQN0GN3H0RTc_sQe3T266BHzjaicALWLKQT1oQ3VfszLRz_2HmuiAbCU7qlut3NLfk
 Nu6Be824p6MNLHM2ThLSHw7XViXF7MyF9BxE7_mW2FQ.B9xZW7IjtI03ng3JmnGOxkbmDuPMSoDO
 XLx4PZGMXf5Tzfb5F04QVRUwIkKJbNOwuP.Tg2xUFeA_c0A0JVs7BGS6Sb9Tlbtrh2SsytyWi7Li
 IoPrvT7y9GvmcdsIszHZr25lDi9WVK8e6ptC_eA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 17:59:17 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d92f82df13f171d3f133cc62319c1ca1;
          Fri, 24 Sep 2021 17:59:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 04/28] IMA: avoid label collisions with stacked LSMs
Date:   Fri, 24 Sep 2021 10:54:17 -0700
Message-Id: <20210924175441.7943-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
index 5c2798534950..fb2b66b3c1e7 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,7 +25,7 @@ Description:
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
 				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
 				[appraise_flag=] [appraise_algos=] [keyrings=]
 		  base:
@@ -122,6 +122,12 @@ Description:
 
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
index cbe6f1244e31..af278e225f9e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -82,9 +82,10 @@ struct ima_rule_entry {
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
+	int which_lsm; /* which of the rules to use */
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
 	struct {
-		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
+		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
@@ -96,17 +97,17 @@ struct ima_rule_entry {
 
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
 
@@ -294,6 +295,20 @@ static int __init default_appraise_policy_setup(char *str)
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
@@ -363,11 +378,10 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
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
@@ -418,8 +432,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rules[0]);
-		if (!ima_lsm_isset(nentry->lsm[i].rules))
+				     &nentry->lsm[i].rule);
+		if (!ima_lsm_isset(nentry, i))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -608,7 +622,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		int rc = 0;
 		u32 osid;
 
-		if (!ima_lsm_isset(rule->lsm[i].rules)) {
+		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -621,14 +635,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
@@ -1017,7 +1031,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1056,6 +1070,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1064,7 +1079,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
+	if (ima_lsm_isset(entry, lsm_rule))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -1074,8 +1089,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rules[0]);
-	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
+				      &entry->lsm[lsm_rule].rule);
+	if (!ima_lsm_isset(entry, lsm_rule)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1680,6 +1695,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1716,6 +1744,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1733,6 +1762,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which_lsm = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -1972,7 +2004,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (ima_lsm_isset(entry->lsm[i].rules)) {
+		if (ima_lsm_isset(entry, i)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
@@ -2014,6 +2046,9 @@ int ima_policy_show(struct seq_file *m, void *v)
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

