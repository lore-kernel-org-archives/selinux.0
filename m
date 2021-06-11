Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F17C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263856140F
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFKALO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:11:14 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:46825
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhFKALN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370156; bh=wUB0iYE8Twioo5ZIk6y7nf85VKY6XjvcN02gxsSW0T0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Dw23ITUS4KdPZ9MqhasbSd+HiTzMQIOs/UBOHZXkIhiZV8jK8+SK40cniGMC1hurXPwk0rmAtIOK3BPgKVR4wKfrCbaLtoWwnbNSd+kSXpx0jLckRa+pd/jwm+Hx8lhMvfI1e0fpjmJiQeeWeM3zO990CyJZn8Jm2vKFEfPdJ8ufNDgxPU91QwPAc1YHOuzp9S1Adx8FbbaY01/IzgWlkqvtL7ME8rZDA+vJ7ZpkjHtMkLBUw5ihwRF3oiQChr79r4/iaRDi9ym0yn2qksG+PvGqzEdjzTV8O62D/yaG57hcxu4aO8MIpM3jzkTBdaZGkl+jq4TsAa43llb44Mmdkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370156; bh=XLYwOhYWj/8JSPDhRpNX04eUUu3Yb5/hgwwVv+F2CFK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MEooFJWkTqvcHbEIs6tNjxyli2cSi4Tf/+4ZzjrHyDj+XUQL9FTaCofzi8MxliEN095TUaTOAvFZJP/wJMR6hEvEzeXL8bBuSFxTmEmj6HPRt7dLYk+puoFcMPn06MUvp36wLuNM5qlhZe5ffT/ZimeMhoYrDiJ7OMdx29trJjUj1OIgTOQhqSO5lSv24e+XJUY8he1vrJw9pQeZ8SDxPbK29lsk5MQkn8wuaXLaYIN80iP/a8z2x3jbkXqSBQvC6tpgvuP3iQzfk5vbdQOwmVNjgzDGPc/0DnQZfPGNhWmfzPNJe7FCp9oPO9NuoZysral4tjxeaDlRTYfGpAH/6Q==
X-YMail-OSG: SAeNjQQVM1l4FCYIfs9T4uml3Cfz_LtMOvBxnka1mQ1IueBrjdFPiupKbJgw4B9
 bjCfbUj9sNlGZMwdj1MgBYaRn_U1LlTeVeC3KrD6L4fWfP7RWsW93AUyAIHDmCY4fv2nT1dCU5Ku
 A_d_qsLSlKTux8WvxJW_1R.ems.0XttgdHLb0F.5QVtGDJNuP.UUYACsjASFUXdb2hGa9WlsEUnV
 lo4nSWnRhvHc9TN7poYbgwRRvc4mvpFXe.UCcLigclQqA7w.Doms1aNq9QyXUGSeUu9NrpJa9mz0
 Z25YS1h.D33VFNnEIv9Rq7Ie0jdTaNQQmkMbo2iGhwoAQesrFMC5hbk9TeLJo_kkC3N87gw48wY3
 u2T40Dza5ckVDG7S2M_tggoyq27zU3Vp5gTjVgi4Hk4IbRduV6D4nXiNeZxQfR2E186lY2SgOtw5
 GKhe6xMlWnOfail4EpapXfUJC5Kq.J425TrFN_xqNJhXyd3Z2h3jpST6AXuKs_ITPe7bdCdEiNCs
 wYWm6Z92OkTd.wzN5ii3sI9ReLGF4zRDDyBh7oLaIBmnk9ePZzVzRAOJMtnGdB5z9C30aNjn8DAR
 xrTPD5bMMcY63lZNMF9c3FauUuzi2seGslApSDFYwmbfitkkYF.4for5BQdfRsjicZ9yWt9mtzf1
 8kk0sYhZm7u5GI1UCIFgQFYaqD7iOT4gmkaGHGatlQsC8st.8vmH2nvuq5Krk6_6VgOOxgzlmbv7
 Rjai1s3pbOa0oap1Zvrhlg1uLntheV3NYzwb1R83GwLLDeRzaTanvuJraaIS35c0TTYnnTnGqlR0
 xCH7niOiLJgV1RzkYW4pJJu2VllH9YtqVA3yr5eLthnOlC2NLXZMfNtRWaU5RIjyzwWPN.bjPadD
 9yihWHUWSHafvWD6NhwyrFihZJICEPxHKwhhexK9IqE_YqU3sNBbarxLVNpXE7LccrGuHI5CZlND
 nMKxhNufkkQRKfC97Uj.Ch9cSC2FJ93cI7tL9JD_j8MVX4oNQDyKU18SbQiXVoC1Z7BD21EIK17J
 y6YHC74j2PYk14cl0EA_awUdYrESsUhpSRFbHkek3WgOVbnt_MBiv6U5igxvHk.XUQdq6jo9Jhh6
 _zCxJimEC5jYQBzxFutaQ4IqprdM6d6V5wxTzJTQ_CtOWSa9AYQ.3cR.SfFeyodhHFkjLyHuSJkK
 .6gw9u7LCpur_CHvpHHC6qe_DfqRSY4LS_MLMxlrR5E5qtMxjKiwFZMiUykiiG3qJLf2IJB6DISK
 EXeqvt2NlmLMAw4qZBVsNABxAZLbkf3bd8wCG18BdPtbpdVwSUZSGwrISd_v0BFFTFqb0n8YZJKQ
 ggo3mCCkxqfCSDExmzzCVF.WoL10_OSjJ8.K6Ovd08s8IcpiFyKjzYBEJbhZsKZtVeddt4xIh0Gk
 T9qPfG7fTz2Dn0WbqbWQyvYSz064EqlbK56PFSN3juxm603_VzRLefMw2uFL6N8dMZTFfFfIISJX
 kHjtI7nzAA.VzOS5KKQIA6CgqCTyAv6Qa1azf..NdsaX6XLWezGtLiLeLFQmS7icIlDKe5IU0w63
 iAAQJRwiTT.tC6c3k7NJ1lmCHQ7.aeokaLPTPB.6AURxDVNJ8muZ5GiqeI.NlFnNW2qPHPrnt...
 CxPDJhs97dU5kf1sBRKUKOENCFh4TQgsQbTWI0gJWDtjwddRRfA9iil09OSOumxayL4wjpWAnlhI
 jq6HWKVr2WPlWwqDwNJOHpx7PoU2Y64ubIkKk.5J1Ky9OhMz19eAPqCDCl55EcKaZbqVbhBfR7Vc
 _fMfuj9Jicme1MYGQnNVcA_s0FlFgV8LtxVIY74Myz1rX.2DJcpLSh_zYtnuCpM2KVtJgpHuS9fj
 qW9rQmka3GVbhDUacRlunKh9A8eqZeYZMOW.Qasn4uVIpnkoAfU0qfH9igbyVbPu80aUzuCYRyK7
 bjv9w5KuCt4mIEuiig0o98BuK0kUvwrtNDbn.dBx5PgiQpj1EX6DMCEqpfXBvgYT4jQyIOH.CCAN
 WK.dxXluxHN_pHTM3052Q84SkrMN1X7yQsQNkb8_TXIK2o7d_VTyXzrquYEMBywMvLyuYvhoj6uu
 3cNlfQufpa8jdUPkEucXAdYTG6QV3gtnFpnxV46Q.eRtgWyQOjvhtfxAb0QBWzj3c_g3XfHP1q5j
 9bSXocP5wUsHlK_VVUWsUHwDYOpsIfvkvJSF42KK_7nI4W7rvi3Fgs7UcN3VPntGfW_xNHJs0t2k
 GyjX6Ro54GYl4MM5ATsK08kxZAlHbb1LuHGVi7_6Nil7XUiZUySSw_F5mixjMajsT7NwiUo.sfw1
 2to5tuk_VjQw4QMmZBOn4.Gl2FveYR3tsKa.y0pR6lWjTHrZGVNuuveX5M_XSyBQO548F8PobqmX
 _Ybfu8ZEfm0enWTWzRblHBRR9k72dm7IcsL.3p1TSeU2efBMLzLNmxejs.A7dPH4aa9p58GrYGay
 NsB3f5thCQ_WivSFV3NKap2EuCiRDrSpkoKLIw8DdzNPrqOsJMSeefJfIENyqhnyFo84HCx7nIl9
 pisFwdMRBJv18HQM34MuccoyexC8511eAZVzKtci7kWqE_Qns9Q6SGWEdZ9FWSKM0meCG0mjdS9v
 cYjQbVbJOx6iyPTSVZaO0h2o0m9RX0drbX_IyeRBgfy8_v8oTQQGL97oWJl1IvzD_sI5vBbH4wFA
 zNoe7IKrAO25.aZ9nYuCiJqk39irMqxOXqlaEkJHWXzXDCmsu.K8nOBudjBtJCmtUx4ns1.yyb60
 _hg253rA6O5NJEkZTix.84q1OAe9Vw00W.YIjb9IfKXLewZtW5mOymKC41ciJOG6F.J8y3DYABdo
 NCCkoNLuwx8juL4.bqRTYiKwEFkEhXHnijogaex36N219U_4qF9bq8obCYCBrVtVYb16mAGAugPb
 xsoNKSkzmD5zbU5.8y7TZIl8FRBHJ3ztJtYeTfKjH2QMDpZIHTv5E_CA8GVsSdmrJlyWMlzXfwcT
 DcLWLYqAdW289b4QdagCdg48QWnsaqx2_uQXpRG7vdlTzd08PHh_J9.Q7_V3j0g.3P1G9kWecgWJ
 18cfV1.RpTu5j3aMxElrTrIRgw.jlh5EsRNSk86QvakQmdt05aoOA6CkFZHIkLFF3yAHyTjp5wAt
 0XA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:09:16 +0000
Received: by kubenode533.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 255edc09bd7d50db69e2da09a8f9b69c;
          Fri, 11 Jun 2021 00:09:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 04/25] IMA: avoid label collisions with stacked LSMs
Date:   Thu, 10 Jun 2021 17:04:14 -0700
Message-Id: <20210611000435.36398-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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

