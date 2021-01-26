Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F88C43331
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260852224C
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 18:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbhAZRX3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:23:29 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:34668
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730593AbhAZQ4e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 11:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680146; bh=pqv54oSuUrZwTgY3lT+6ERg3vpWhVoE4nooytqbk/Vg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AwF61e15st3RZFjrR2sKX655rtS38F/GZtAXKA1BPN78Ua2D/F7X0/rsa/fDYeXk6OgFsKb9hoSwfGcoWOgDfKWnRSx7NUWyvdfQYZ9k7pcEg2oXbXwHNWQSWIoL6bsYu+K8ctkQ0gDQLB5LhEeUoZXWXWeeC9ytPnDcg6NlaPLJwKMHG5/BbXt2qLrrXC8wbOfmB3y8hrwF40wPUaviEvDSrY1gbSHHu1zQWMj5FWXnjLGUf1Nc9v9keuCtSWD8jajcv3EXek3P/gEQvRo2YxyefjuTTeD+s72DsDV1lnGxDu5v+MMy4jiURp8+bwYHBFu2kWnnO05ubdMxS2KZoQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680146; bh=ebodx2G9Lfba7haX34Yc64bh2HZYjZ87VjHeAHXWRGn=; h=From:To:Subject:Date:From:Subject:Reply-To; b=dESDuYi+0u+CBXBoYV47vn0T9ZF8tJZwMxBUVDrCbN53dVgYWeORkjrMjLfROCAacBOjOydz3g7QAkQ1gATckLKb+iops0Gprdj/AUmyEDaZiYaU2ms05VePsKLq3LJcZ2/G8jwLwl+G3Xxr1ja5Ye9t4L7KIp0r483NEPTF3QsZqVt5Mr1c2npdmZ6PkFeE1ZaCq99XcoPvajSHAjtVp1YCa5KhAHZIR9fGvNFWjcelNjKEguUknctGF+D7h8XB809wi/EUJttZi0B8ZJWbloURFI3aT8MnrRukSiHilO041jr3s8xKWmhdQ8n8h7NxFz/Ueal3DFJYf+f1Mdw9uA==
X-YMail-OSG: S2ObzhkVM1mOy8IvELZKxHodeDPvJy71yZT9kysPYgKUFFb0phG7RZjvKRb1Mz2
 Dr1Rvy4vT_zHFYVcuF9h2UJ7y9PJWtNWerTeZE8GYxVAGMpH.L4wO4vi77q8jI45Pmg_YSC8O5I2
 VHXhwmPcWF694DBkOoczVxdOZISPU1ahfNxKOSczjm7PGp6DQ7MGHhuqrhBUOQcCydto6rtrKrrI
 qvyFeFRk.FsZvXk_Bhf9WAeVPzUel7VaCe09KUv_XwnrmFf7efW_Gu4oqcIim359KqOIxbtt7UHT
 PbgTq3BfcZrpvzeI41cBmGBRBULeRS23XYIuVxFMoxgSoB2.tMtnZT2w3jmsuzJP7yir0SKKEzui
 mk1bvDjg6MLFjt6FKp0ZVpjopqLvOlYX1ltSzJchdtYrcQhGrZ6tmmfIbbEY0t.OqHHph2MWDSC8
 Fjy_lz9qBlHDhbnXQxmSv3.iDg0nIK25Aant5MncGXcCrjL_k1LKDfDADgGu_H_AzZM8jBj2jCtH
 psk1N2JKHHxPIipiLWziAbHpk6bGpfqqOjFWA1CHSJGPhmDYBJ9Tp2HUPX88tlnSMQQ.r.vEMyZ2
 aqSaxeiJ2DAU4lTp8oZr77GphDcNlKw6rT01nraloeYhoXUMV5bMITQluDLBzPDHiEUteo2u45.T
 d_u_NEIP0gjZvcSWvK9iup8KGZOR1PLB.QRr9YX.9MGLlMovYqZ9gmZS7FGwnxrl2cACR0J0N9pO
 Tg5uVFp6Cq4N7jSRI7EUc4pEhVx1xbADUKSD8jYsQ3nnAKG81dbP9UIl0A4uoBBLk0sxytaH5iYX
 bLwtw3ieslRaKGayQPHEhMXsJ9K0jGymkKHO4JXsIPH2FvxRjjhqD_TlVt0QDVDu8L1cMezx3qvj
 ZFjkiPD6Mx5S7vUrRKUM7IiorUTCrti1vD4JDCcsOP6suzEPlaYXLyYzcYhgimMB3_jOlt9nGVLF
 1N6TFzZqcwFZZ4USQBTdjuNmV4lC7oFalT874abaFuu.rSOmUrdacLVZ08TDf1yiqNyPOHKD3.KM
 lkh6z.4nc5YBZH0p2FZGBmPqypSKo0af6YTOv8FSsOkfgBmo36_k.usKCNDfQWooQGJJoEH2EOE5
 UU3lk9EhVLnBpRGgymAbo3KNiZrO8nQZq0asxM_VP0.V5B_5sot2r8csJN2tfAP3WIheNxMB_Wal
 VbCrfFpi82eFp8GUMuVLumf41JqdWFoM6N11T7PrGc_AIsmyr1GKrl6ePNxJjCq.C_Ay3LKHX6tj
 Shj2Mdboa1jxcw1otSf19rMkQAHdpncqWmpTiQn1UKQChMMSGazF_CHk6UGcrNRbhs5vI_ontflk
 FixMPN_LW91Bp1Mdk5.suHrhDCN9Wp6ZLillaPmt.UKWjaWA98qYovdz._ONHLqkx2etwB4CUt3L
 NFHWnFhHZswNYAmf3zYnN7Xfp.DbDTsO2xRVCD76zuugZeI_vkuEe0q2nGdhjQ70Ok1NCm9YLJEs
 DHXntLPkYDCBWkEgTJ85E27mfJ8G4rgbjwSR6R6WdjnBJB1VWijjT3S.fmnfr8XrAIeha_fSgTLW
 gN4JiA5D9aN2RDHXrBdNOuQwLC_49K5z.BySrgDofok3rmc67qcs53Cqz.l08UFVUuXgowiv9i9l
 GFpeKfKJQtD75fYnQvSUT8TVPBHJdWOFY4DZyz7OZQiJB_cX4wbt_7Z2Hp2agWyB_NGF_0oIIHR_
 wKiOCW9t9gC7tyc6Sil1Pr1Qt5j4g2xPSPTy00Eu56HsgpQipCVIoF._lPKjuJppjZAkqhumUBEE
 ziCYedvz5nFRI1Q1C4HsJ1HNd23tn7GidcHChLQrAmF1VpIdFhAVJy_NlDrJ37D9DLOMviqK0ObF
 ud4DGWWWSDt3zIwZ3YQ5X_c__pa68tUswtuSfG8QZJHNUXXHc1NPY54f.wSHlFxOvroou.qbA39h
 VD2PZrtvQMjXhViwqz84e01aYkauWPzJ5MCt8EninRc5If.akazIxDRAtU8ndlrNpHTKU6xNV_LK
 KI1IaN6L_0za5wq83h.4g7i_D0oYdsUr6Z1ZHac8xkziO_vj6xM77nlctzixR38FEYDAtG46WmAI
 h15cyXJ.Uy1ZD.zo5J9S7fUn80T2lMP3OE0EQqYSWN.d444gHIIPX_IG2nPGbqGCTzzecENLwS_.
 MuVx8U3ZU3LiZmN0PV3yxuPoilIB0hlEbjTBjDjAjNbp_YI.hL8dL8xaTMcKxAQt1fw8uEWvxbSR
 AfL6lfWH11sLfYVtNT_.0oN7vWqmAVA1HOSXpBepZ2NlR3IfHtOlcwfIa_oZr527FdPn0cbPyBVQ
 HzB9HIxHMHpTDqx3GE5LDcFJ5ta.fGgd.Hq.PeL7Sy9kv9O8Bidk.72KPFKfYZVC3qPbNmxvXeXI
 tcq2cMLUlJlgbMs6WMy03FE_JEcsKwTRyD8b6a8e5cJ7FTaxxKEEBY6vDbo2xJu_LwhYl2TGHtFE
 VMpHatpWjT0Injf5qLivku8U6p80zxC3vPWLCtYX6MeUPG0Y.NGA_fXSEbbxuazjCvo59UftOH_U
 8.rjv_T.6dNFFhhqilC7pugbJ5b55_pebevxW.lNOnGKAX_.IN7nnPv1gDjPyXkPXBUfCW8ECyah
 DYCTLfOjvDaLesVvD_ObIT_o4hyVvsVwSPAJ87jIKDDhBGKL01p8S97pR4ffl.Goj3vc3X32IaVE
 IxQNoWtcb0Tm.FzWwiSAXLiHygqB6JCXf.Fdkhxd50YboPBeTR62z8Ahkwleap3NwSzB_RHnIsm0
 j6SkBXAaGCHGHCoRWw70lz8ErVw5ZEs_rMWdj_Tn5znr76Ay38PWhWSx8v2.bTt.DHrjxxuhnvzT
 iV57SkV5dz.jzER7gf_q9tCl244Evjn7jZQCCb1OwQyB3VXhz5qSwUj2CCEiO7jx3GckTX0OfgIM
 MFFAh6CrmMUFCt2XT5tZIhcyyMSy7h7qrZz6iSFHDbk88EDWPvJ7Z2JBqkpssVdLZI0mw2jtUiCa
 43pXv0yzR0dBIp7MxsIamNpYpv.W4l8mZUiXV_lPMoB5vtqXcC4bH1GZYndkavKWHWMc5cvroLIL
 NDD0xlnuhSFDyvuDDVsZ5P7m7vogVPLk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 16:55:46 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e895881efdbbf41af31f9904897acf15;
          Tue, 26 Jan 2021 16:45:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v24 04/25] IMA: avoid label collisions with stacked LSMs
Date:   Tue, 26 Jan 2021 08:40:47 -0800
Message-Id: <20210126164108.1958-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
 Documentation/ABI/testing/ima_policy |  8 +++-
 security/integrity/ima/ima_policy.c  | 64 ++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e35263f97fc1..a7943d40466f 100644
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
@@ -114,6 +114,12 @@ Description:
 
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
index 8002683003e6..de72b719c90c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -82,6 +82,7 @@ struct ima_rule_entry {
 		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
 		char *args_p;	/* audit value */
 		int type;	/* audit type */
+		int which_lsm; /* which of the rules to use */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
@@ -90,17 +91,15 @@ struct ima_rule_entry {
 
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
+	if (entry->lsm[lsm_rule].rules[entry->lsm[lsm_rule].which_lsm])
+		return true;
 	return false;
 }
 
@@ -273,6 +272,20 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int ima_rule_lsm __ro_after_init;
+
+static int __init ima_rule_lsm_init(char *str)
+{
+	ima_rule_lsm = lsm_name_to_slot(str);
+	if (ima_rule_lsm < 0) {
+		ima_rule_lsm = 0;
+		pr_err("rule lsm \"%s\" not registered", str);
+	}
+
+	return 1;
+}
+__setup("ima_rule_lsm=", ima_rule_lsm_init);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -346,7 +359,8 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		for (r = 0; r < LSMBLOB_ENTRIES; r++)
-			ima_filter_rule_free(entry->lsm[i].rules[r]);
+			if (entry->lsm[i].rules[r])
+				ima_filter_rule_free(entry->lsm[i].rules[r]);
 		kfree(entry->lsm[i].args_p);
 	}
 }
@@ -398,7 +412,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
 				     &nentry->lsm[i].rules[0]);
-		if (!ima_lsm_isset(nentry->lsm[i].rules))
+		if (!ima_lsm_isset(nentry, i))
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
 	}
@@ -563,7 +577,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		u32 osid;
 
-		if (!ima_lsm_isset(rule->lsm[i].rules)) {
+		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
 				continue;
 			else
@@ -925,6 +939,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
+	Opt_lsm,
 	Opt_err
 };
 
@@ -962,6 +977,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_lsm, "lsm=%s"},
 	{Opt_err, NULL}
 };
 
@@ -970,7 +986,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 {
 	int result;
 
-	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
+	if (ima_lsm_isset(entry, lsm_rule))
 		return -EINVAL;
 
 	entry->lsm[lsm_rule].args_p = match_strdup(args);
@@ -981,7 +997,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
 				      &entry->lsm[lsm_rule].rules[0]);
-	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
+	if (!ima_lsm_isset(entry, lsm_rule)) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
@@ -1488,6 +1504,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
+			entry->lsm->which_lsm = result;
+			result = 0;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1524,6 +1553,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	int i;
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1541,6 +1571,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		entry->lsm[i].which_lsm = ima_rule_lsm;
+
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
@@ -1751,7 +1784,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (ima_lsm_isset(entry->lsm[i].rules)) {
+		if (ima_lsm_isset(entry, i)) {
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
@@ -1793,6 +1826,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->lsm->which_lsm >= 0)
+		seq_printf(m, pt(Opt_lsm),
+			   lsm_slot_to_name(entry->lsm->which_lsm));
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.25.4

