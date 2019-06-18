Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B4C31E62
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405152080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z+E4pTuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfFRXGs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:48 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:44488
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730962AbfFRXGr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899205; bh=DMDQCSs/laXHmQ4+yf4yXohRp+cHssqIOWTamx1IYAU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z+E4pTuLJeNpwGMLd4ldolsORql2cPdVMVc+6yx4C6WsoaUI0a8yxw8tmIzRblms1sIC7aN8eAabkJ2fnJKtAcAvh/7YptyG2NdxuYnTGDXqyds6rpeR9VezE+B5LqYkRMGa//oT3ne9zPPdCfVIaHO6Hg5uOuq5NAYY9CAigyh1ZFI54HNMqjcs0uzognn3QLZNIeieQDcJtZ5JWPa4eJjuLXou+I08G50f+z13ubhcQWiqywCNB/eUwEj3VFOcMAbOTMXZ2qmG4yXbXi7HQdmUOxI4Xa4GzFqr89K1JoITL0b7gKRhmsPX60DWq1f0LTjENTCfWCujT+/KDU/Rpw==
X-YMail-OSG: TpEa6KEVM1mhyXldZ32xaqyVGoOgnTHKcbPgfNRVb_ZZQiT.KPfbZ4HPejSjG_P
 T_tcLeuqdRHdanv0CmQiHDIhNe.SUDtNDOTZ3t1oAWn_2GyV6YS5bx0k70BuvF22y10imuDu1vui
 FSf0S6E10WYO72cSekX.P9C9Y69U1BlD89og6GDCQyHV_WvHZxCGq6241vSCk6DFmMICz3UXx.wl
 R3tDUej6l577pBlpSiQDYoRe92aZbNiUk2IpjSYk37xi_fGDMnlujpfpY98.3BjunDAKMwtKIqlI
 l9MMlkpogLu8PKsa8_Uvqk6JdYBEaWhMy.r_NIchw5Iggf4qSajGXFFWQOg.DW5xREYXN2ca7prG
 3O9odNS2PmxQa_k7e7DQrry9DTVMX3Kp0Ihfx0NQBL1sLdwtxt4n7EXJxAWssQ2qixU_5IduupAx
 bAzRskVuAmrnNQWQltHnrwYlYb6YZgvl7zIDj0vcHSOFJEMCv9vcaF_r2JceHAiVhvzEB79LLsSn
 b0dZyfEEjZBRD8Dz3B78pebQxsAEvtS43z37zz2CJ6AoLQTpJvST4isn7DG864Xj3h.kQyBIAoB9
 acBpgIOo8TRyj6mVJYSnxkpW.dvOhA2ofg2fZsfoEGjUWD7Cez3AWZIEj8eoz5zjdXVqxBtw0cjX
 ncIcDwcJiVaRFN7iZSmdOWbxCqSybE.10iN0XQ0tGjTZLS_luWP7sTNKBwzCE72TbWie90QD8UA6
 LnqwQmFuuW1HBjRzfuOOknSOAuM9ldlii15AJgU2Yp4CZSUnjCLall5vizUALGDtbKj1i_i4ufnz
 JNOVaoGmIb6R.JoCySLIkT53.xcChq.k37WgQwsHzkKGz.K0S0uTjdWl_0pHjflWjzTb6E8MaMd3
 i_MDOavd8UgUvCcsZNkkqJD9GBrrYncFc0TqfRTwa.ygZU7iVz04Aa.uaiDdGI7ynftOLPrOgpU9
 oUxCQVSHjBssZ_1Ul3Gw2R4i4QivrX0Xp4UyzthQZQiXI92K1usQ.K7JroDeqx2QuzNzhiFhaR1j
 b0x.nF4Fwf.AOChNYsmKPsKCfCsRRgzbpZHagJP5UZplzCw9IJWVVGFi4Z3ZuWDLinVa_mx0DpxA
 QOVgW0qKKg5QexXTx5gIfX4O5Lf5_BVE0p5n6o9MGwzd0uZhbgDF_WS1fdyG0E6BuLJqi7ovMKtu
 ywK2IoD.uwrHWEfpu1OgdOdlWTbauR1Q.pZ_aYvFCQxssIVEbJGLKBEM.LWHnWl7khtkDNcN9_ap
 dum7ugMib6wVt38c94UKi7FLQLgKPADoHn9aeSsu3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:45 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b5c484e6312471c03acab1f233ace257;
          Tue, 18 Jun 2019 23:06:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 14/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue, 18 Jun 2019 16:05:40 -0700
Message-Id: <20190618230551.7475-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The IMA interfaces ima_get_action() and ima_match_policy()
call LSM functions that use lsmblobs. Change the IMA functions
to pass the lsmblob to be compatible with the LSM functions.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/ima/ima.h          | 10 ++++++----
 security/integrity/ima/ima_api.c      |  9 +++++----
 security/integrity/ima/ima_appraise.c |  4 +---
 security/integrity/ima/ima_main.c     | 21 ++++++++-------------
 security/integrity/ima/ima_policy.c   | 14 +++++++-------
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fe5e921d621d..0bffee031704 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -192,8 +192,9 @@ enum ima_hooks {
 };
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *l, int mask, enum ima_hooks func,
+		   int *pcr);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -213,8 +214,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr);
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *l, enum ima_hooks func, int mask,
+		     int flags, int *pcr);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..dd5bbcc06415 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @l: LAM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -175,14 +175,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr)
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *l, int mask, enum ima_hooks func,
+		   int *pcr)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
+	return ima_match_policy(inode, cred, l, func, mask, flags, pcr);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index b2af58b34255..b0cb08f81484 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -50,15 +50,13 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
 	struct lsmblob le;
 
 	if (!ima_appraise)
 		return 0;
 
 	security_task_getsecid(current, &le);
-	lsmblob_secid(&le, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
+	return ima_match_policy(inode, current_cred(), &le, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9959d7cbe42e..ba66b9ab3cc8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -169,8 +169,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *l, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -192,7 +192,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
+	action = ima_get_action(inode, cred, l, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -339,8 +339,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &le);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), le.secid[1],
+		return process_measurement(file, current_cred(), &le,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -366,15 +365,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob le;
 
 	security_task_getsecid(current, &le);
-	/* scaffolding until process_measurement changes */
-	ret = process_measurement(bprm->file, current_cred(), le.secid[1],
+	ret = process_measurement(bprm->file, current_cred(), &le,
 				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &le);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(bprm->file, bprm->cred, le.secid[1], NULL, 0,
+	return process_measurement(bprm->file, bprm->cred, &le, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -393,8 +390,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob le;
 
 	security_task_getsecid(current, &le);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), le.secid[1], NULL, 0,
+	return process_measurement(file, current_cred(), &le, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -526,8 +522,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &le);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), le.secid[1], buf, size,
+	return process_measurement(file, current_cred(), &le, buf, size,
 				   MAY_READ, func);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6757cd6f4027..409667d9ccf6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -286,7 +286,7 @@ static void ima_lsm_update_rules(void)
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *l,
 			    enum ima_hooks func, int mask)
 {
 	int i;
@@ -345,8 +345,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&le, secid);
-			rc = security_filter_rule_match(&le,
+			rc = security_filter_rule_match(l,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -394,7 +393,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @l: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -406,8 +405,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr)
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *l, enum ima_hooks func, int mask,
+		     int flags, int *pcr)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -418,7 +418,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, l, func, mask))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.20.1

