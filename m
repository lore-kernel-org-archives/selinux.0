Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478BDC433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhKXBws (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:52:48 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:43829
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236204AbhKXBwr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718579; bh=3/8RBVV2g7vxTlJLIdexlqAMFUzEx32GgRcCLieYGPY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r77cuPhHT3cZxYYUSV40ozy7+5E59LhvdWV2CdLqUunizchn0IFusRVs9M8yT3kPBOK9KHyUbC+s3dleXvzVRI3U2Lg+U/wsWVSp8JGLgMtHe/hbbRdEwbSGEhI8BSLqbM+kWvEYT4DRuEtxAEcC5+STQQtyykqMCKqTfCx9ZN3+baMFCBwYyLVG/3zc4ciHqFqMXGQF4R0DF4b27NGTpSXYhHXMNzEAK4npuICKf/A+TIiw5pSEfqxC1XAxKMWpLMP8TvepWcEoAY61J3v201PwyjbRzWzB7mCPfNkgQPrqWW/Sqp5oD1DpHFv4rf5nh/EDI7PL2dtTbitXpao9rA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718579; bh=YbRQ8FfvFz9LnGU1NLSH2w/l/hV0y/FI+dRhWPh/4fY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FYPP7o/Bmlk0UK2cXdshC0sxhrWZlHVDoJ+DRw22i+4g6o8uoBIYFrD8gGjlFuAy6W9KP8euMEpBCrd+jYiwx7iKUCR6uN0Nxsvd2WJi1XI5tT+3XKMJD6wg7Jo95OT8gz1ovZfhYsCMhOgIzmG7kGkALtoIjUq4XxJUipW/6Fwt4G3YLYxtr6C9OdrNId29ONdu55ovYo0PTyf4BKlS3MOt2pChafhoYqjzpsAJx6EL6JU7klXnN9g9f0H05fIOdghT8BvlDYFMCnVWGfK0p26huOlKqV/WZMFovqeQjJ8GuMYrl86y6mGkT1tKUoqXNsTYUzW9w1bazZFQd5m2gA==
X-YMail-OSG: qBYoQpYVM1kbr_BL8PVm7ENQDjuh4hcZCFIaRHKToC5_aye8dphqYkzs_AhzYTs
 WSOSuXkQGelqUjcBujFBQLjduyRET5nFH3BgH2naMggGxWE_TC9tlmSmwYWLIscUPkBZKoIQbfUE
 jNLH802IHjGQQ0wvHyU1FoJRsOw8WbzwAXXoqOYarxUSdWqEM_EjVbOmbrQRiQf370.9Gg74L9gL
 Wuv8Jrv0P2w6XR9gjfdbtbeTkzSeOMN3mLnk3ZsIcggfKdfiNCIIe7oVKdCgB3hgxcci3S1bAadn
 mO416sdlYMpH4GGG8TEcb.DqBjWK2_hSRolCjsvC921TgtY96VBx6Q5dWtaJFZV4pC62XJKFEqrf
 nvbirT_jwmnrSFOLqr0FbcJLqzbrItyo9ILysY_QMWkZ4LGHR8EQZQ0EsS731nzOeKz._qwc08G0
 XVJFdFKa3v8xj__fhkpGc4sx8SBgjN5zdmQULFXiC7zpXJIiOGDaga0oYOf6ftopIFbLtCVc6eGW
 b4IwbW1CkbKktqM0HR_gYINY3CFE2mozrYJFo4bKclMTr74n12n5X0nF1xM3pcEYBbBomPYp.MLy
 .chpgSACzObGPfTyHNuWOvh5EMTY7vuTmhZMyb_C4cEprTvqVl4W9M3le3SGqYcnRC6kTm_F_CsV
 F.cvF1adu_cgXgvwC7PQjZlsO5o.ioXLYx2dyUVXhUoQmoY5VgZzwNXWwRfZRWieWx1DyEmZZo69
 TEgPP8vqX3HqdvUbtpMXeV47x9qRpBAuZmGinDtdSn81lzBV6sbDWvIb6OgxTas3Cwr3ynx.PKKa
 RTVGFKCDG6VfJWvhiQBPnhHYjbl7K6D6l6fMdAgdYMP0VR2fIpxg33I.11be9jMWdYfAktL51nxW
 SIpwwcWHCwxnCQ9JMH4VjAt2TCSHE2BVXX.sRWb1WN5i_P6ZB51xR7t2gu3y4Dvl5cLGmIYA7lUQ
 oywPXZ9uI7vX81SEFaJZxDYd.sIR0r3AxWxcr91OVSq_GXU.9czXVUGACAON3RJ4XY0zva43dM4n
 NN4Z7lxxJBdk0Uw.jovcP2d7Bz8ZnP27xwfiNVbMp5QwZE1_IZoFoP4E5D3z6LWefBzOlVkL6.ya
 RkLbLtRZ8xcPjaPlMKPxkrsyMgCf1AK4V2uZ0AyESGQZCV0onDvWEYN8x.600_insl01fzww_uEL
 vDe7yLFGWj6gQ5xstkAMl2qQ894JqKvx14It4gFnC6raCvCU58T40pD5bliJry4l4sO1u5T8TK3W
 RjJvnZ2ETA8tYdb3UuL1gGc79DpDVCdc3gRLeG_bcHfTjUSzp1aObTEGDRvJ7aN4VjZ4AKz_0RCh
 lWk6Qt7kDxlbq7UhzsjThzvECc0m0IBWbtJ16e2BeluYZqaG2OEqUg5cpSfMOAtZTOmRtXpwiEGx
 bMexxVuLgQar9VvUOw.RIRFJD4gNz7bsNQWI5VaVTzRJ5_oMrG4IoX5w9i1knJi_01x3m302nGy6
 fBRO4ZuGvHKbz_RSgJIpoX57Yzc4rFucVFc_jxj.FuR3eMUrcJdME22qGzY09sIvOr5OWJPhGT.5
 WEKvIkYY7bqO500MTNG5bXigMttlIPecLcOPO1sDtiOO5P7pNgx0EqucOzdEEnQ4FdJBXtVBKStU
 8ezBQbzA0TIdl.UDvKzJFSP4k5T1pYoHTOVdUhK5CW.bMkfKr5uCNBEDjcphuW_FF1hVm0cydfKU
 ZfJ3If_46Et7IE4.027NWSwyuzY7X_fyMPGpBoDFnuooX.VV5RQUnaE5DAmzbyABQ8.wo5w91KgK
 .Nqf7tIC4X0r2mFHVIojJxgRlG1qRemOC6BDaUvjBrfVL3zQzXZH.NpORNJX6PmCoJVDH4KnXqNA
 OyBBNAcW9AOwa9AczsrVhCXt75.En1VVlwaOvd63sSvbJLlQUzRathmeRgh85zPavPV89sUn6MS2
 kXK_G2NoCHP_p60KvVtNcGi_3MRxlJxxedywpbXVsd.W3eHVCCBLSee20J2XloBOQuYeKnYXHa0C
 9DHsFV1Zbs9t7jkKWl5f4_9Wun7U43qluJW3bvcgEf6RYTdqPn5VgBh0fnS0MGQa0rICTelCAvHx
 jUPKsSIRju5XCXMSlw0z2zVCAnpNr8ccNqVAEqiLXfsZ5M0.4.gzlvLWf2ogWCy085ZshYfrTCKK
 yY4YV2PHS3ZfuXtPFS.dCOSRyPMOB_HkLHk.KRNXZIswVtb9KA1GfUlPOk9S4s7FGSwvJH2mc_F7
 .HF1.wVPfayN35PfXWAdXuKwUFT_lVphF1otFqxspxR.mLrRb_iwKxqo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:49:39 +0000
Received: by kubenode503.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d601fc60808c5fb6510d4038ab063ddb;
          Wed, 24 Nov 2021 01:49:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 05/28] IMA: avoid label collisions with stacked LSMs
Date:   Tue, 23 Nov 2021 17:43:09 -0800
Message-Id: <20211124014332.36128-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Integrity measurement may filter on security module information
and needs to be clear in the case of multiple active security
modules which applies. Provide a boot option ima_rules_lsm= to
allow the user to specify an active security module to apply
filters to. If not specified, use the first registered module
that supports the audit_rule_match() LSM hook. Allow the user
to specify in the IMA policy an lsm= option to specify the
security module to use for a particular rule.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
---
 Documentation/ABI/testing/ima_policy |  8 ++++-
 include/linux/security.h             | 14 ++++----
 security/integrity/ima/ima_policy.c  | 51 ++++++++++++++++++++++++----
 security/security.c                  | 35 +++++++++++++++----
 4 files changed, 89 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 839fab811b18..64863e9d87ea 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -26,7 +26,7 @@ Description:
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
-				 [obj_user=] [obj_role=] [obj_type=]]
+				 [obj_user=] [obj_role=] [obj_type=]] [lsm=]
 			option:	[[appraise_type=]] [template=] [permit_directio]
 				[appraise_flag=] [appraise_algos=] [keyrings=]
 		  base:
@@ -126,6 +126,12 @@ Description:
 
 			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
 
+		It is possible to explicitly specify which security
+		module a rule applies to using lsm=.  If the security
+		module specified is not active on the system the rule
+		will be rejected.  If lsm= is not specified the first
+		security module registered on the system will be assumed.
+
 		Example of measure rules using alternate PCRs::
 
 			measure func=KEXEC_KERNEL_CHECK pcr=4
diff --git a/include/linux/security.h b/include/linux/security.h
index cd68b4199877..ddd4cf48413c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1985,25 +1985,27 @@ static inline void security_audit_rule_free(struct audit_rules *lsmrules)
 
 #ifdef CONFIG_IMA_LSM_RULES
 #ifdef CONFIG_SECURITY
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void ima_filter_rule_free(void *lsmrule);
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot);
+void ima_filter_rule_free(void *lsmrule, int lsmslot);
 
 #else
 
 static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+					   void **lsmrule, int lsmslot)
 {
 	return 0;
 }
 
 static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    void *lsmrule, int lsmslot)
 {
 	return 0;
 }
 
-static inline void ima_filter_rule_free(void *lsmrule)
+static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..22952efcc0b0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -90,6 +90,7 @@ struct ima_rule_entry {
 	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
+	int which;		/* which LSM rule applies to */
 	struct {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
@@ -286,6 +287,20 @@ static int __init default_appraise_policy_setup(char *str)
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
@@ -357,7 +372,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		ima_filter_rule_free(entry->lsm[i].rule);
+		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -408,7 +423,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     entry->which);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -624,14 +640,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			security_inode_getsecid(inode, &osid);
 			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->which);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   rule->lsm[i].rule,
+						   rule->which);
 			break;
 		default:
 			break;
@@ -1026,7 +1044,7 @@ enum policy_opt {
 	Opt_fowner_lt, Opt_fgroup_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_lsm, Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1074,6 +1092,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1092,7 +1111,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      entry->which);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
@@ -1781,6 +1801,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
+			entry->which = result;
+			result = 0;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1817,6 +1850,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1834,6 +1868,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->which = ima_rules_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -2151,6 +2188,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->which >= 0)
+		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/security.c b/security/security.c
index bc169b9a6d77..c472cac72641 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2705,19 +2705,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
  * The integrity subsystem uses the same hooks as
  * the audit subsystem.
  */
-int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			 int lsmslot)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_init(field, op, rulestr,
+							lsmrule);
+
+	return 0;
 }
 
-void ima_filter_rule_free(void *lsmrule)
+void ima_filter_rule_free(void *lsmrule, int lsmslot)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (hp->lsmid->slot == lsmslot) {
+			hp->hook.audit_rule_free(lsmrule);
+			return;
+		}
+	}
 }
 
-int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
+			  int lsmslot)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
+		if (hp->lsmid->slot == lsmslot)
+			return hp->hook.audit_rule_match(secid, field, op,
+							 lsmrule);
+
+	return 0;
 }
 #endif /* CONFIG_IMA_LSM_RULES */
 
-- 
2.31.1

