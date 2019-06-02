Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F9C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF32794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tSgpz2+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFBQwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:42 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:40094
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfFBQwm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494360; bh=WdnFJNhqMM887DyLRoNCsL62MRkkEDeoMEYJROIA3Sw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tSgpz2+BAsfq0MQyu3X+1RwAVC3OpGtfmO3b7HSj1pVohKrENyKUVRU0/dIQIU1jRD7LobubbDv2PvuZN4kh8s910nAhAS8G1dKCdPm0jjnb/pZgMGc7+iaNG5kFvhvHIYE/EZtKyw7iQQlRgkMepm80g8fYzOq6OzTqum+bWzg1EP/GEz8sRNabIc34H0ARk6ULnD36+J5C1x6FCoOxzpuHm8tNakvlzuIVaalExsWZNehl3LD6+GHeTuRHH+ifBfOqjHPtHEz9CUqXhEjW8QoHm36df4V0kulrGtSd+pDrKoq8JFtIbJHsA25/NbzMmL4dlFs+IMRREOKdz7qrFQ==
X-YMail-OSG: dUqoG4sVM1lA4cND2AF_bvq8.o_5KHIP6gYUVDCdG2sZONnKdhh3EBIRsp8ChzQ
 jqX8bm6u9C.R4CrgJO3JhAiUXDoNdGnTX2nfIPjQ6m3Hd_eYyBpUc8PpnXXk.pmsGgUtK.jhmh7x
 izza8p_APjNeHenSsLPlPvBdPBrF.7ATIYlf6JZn_AU1xkqGXWw_ZjjM3MeqKlFJO4m7gGW98oN3
 gF8k9yqT43M_gvGrhnpnXWwBnUDctICwaTAxVUuhNp72vahOeTYn0ybzoX36cO8bBUq_LV8_Rzl_
 7GyuIponsDwapUAXwTSi1woao9JfSmWlFRYYi8lU2jChHlubABfaIvAJMw6M0TeDWAjyDS47cUJX
 viaEDi3Q59G6ifqHV520pO.ScF3wkhHzm6e7k4aMWM5zijEDIXucd4gCzWrV01dsWHed4du0RsaB
 OrWEdcv73IgE05RKCbsMsQFaoYSy0Bhpv_iL2aFHbSr1p1Z4G4redJCwyofEutDQ1pAzL5oMKYUF
 Y_J.3lijYaUUovAAU1mXI9XMaVm.hKcBDMChmxMZZiIHh4HXMhylE.0EM_MYPhoTDzzpsXhigTOO
 4XYlEM46MS6I3PmB2NeHg4FaB8QB_FCpTztcmZKMf6kA6REzOvV91XgGJYcg5iMXK0Vx8HPP2HWH
 jKACICwT4meW3_4H.zz.naGd58OeSafNQmhstdamFjc5MH.wDwuiYmrJK1kD3SM7UOUDjUbI_Sxe
 kDqsIPDCseUYN9BL2NFfE_V6jq9nBPNJrV7XtoaOqcMfgAkF.r_cVR2xgUiSLwqsKTZLIsfALAHc
 IKDsK3kVicS71bO1PucUT_VL63czuTURDnjGno0ZhgZxCTXVXbMA4p4hWN1tE.chfWpRxw7U8zj5
 VEKT97zKQVYiNZ0LQrCViwhcifdmjCjL2xPkQHX0Y6HANhkXZnzdv_u4zswtLIFu8rzcf63vUa_c
 qV2VhFPPcmLEHIVQRAA3p13XEnRTe3J9sW2eRTuF5NClSGgTajW0gQ0JEBJ3LyoYynoVwcYle8qg
 9KHRHPaL6yUOxyTcCLLnJ7sp1sSp29so3xJxSqh0n0Ar.RtnIskL6esIRge9x5YvS1ZCxH81oXi9
 m40SKEIhapUCtiqFLsbMBouyzUxMW85YqaeHA1fixFz1e5kkrkkWCop_cIJwbyxO27Lu5I67rPFO
 02IcGYUvDS6YYCA8UV3SmqRjyejKdkZEEPCJW5PU.4phRSi0MXgZr0jAcWl7CI6sEZ4.l91d21HS
 xviR8JiGnnPLH3tfPKXj5NBwdZWIG5YlOUe0Sv1p6XH7BV95ASr3zwtE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 225d748664d0767f72d028f09ace7268;
          Sun, 02 Jun 2019 16:52:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 25/58] IMA: Clean out lsm_export scaffolding
Date:   Sun,  2 Jun 2019 09:50:28 -0700
Message-Id: <20190602165101.25079-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clean out the scaffolding used in the lsm_export transition.
This requires changing some of the IMA internal interfaces
from u32 to struct lsm_export pointers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/ima/ima.h          | 10 ++++++----
 security/integrity/ima/ima_api.c      |  9 +++++----
 security/integrity/ima/ima_appraise.c |  4 +---
 security/integrity/ima/ima_main.c     | 25 ++++++++-----------------
 security/integrity/ima/ima_policy.c   | 14 +++++++-------
 5 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..8b109ad0de2e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -192,8 +192,9 @@ enum ima_hooks {
 };
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsm_export *l, int mask, enum ima_hooks func,
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
+		     struct lsm_export *l, enum ima_hooks func, int mask,
+		     int flags, int *pcr);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..7e493af96134 100644
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
+		   struct lsm_export *l, int mask, enum ima_hooks func,
+		   int *pcr)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
+	return ima_match_policy(inode, cred, l, func, mask, flags, pcr);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index be714afc9fd2..ba64b0b61383 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -50,15 +50,13 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
 	struct lsm_export le;
 
 	if (!ima_appraise)
 		return 0;
 
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
+	return ima_match_policy(inode, current_cred(), &le, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f5efa9ef270d..22b973e743fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -169,8 +169,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsm_export *l, char *buf, loff_t size,
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
@@ -335,13 +335,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	u32 secid;
 	struct lsm_export le;
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &le);
-		lsm_export_secid(&le, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
+		return process_measurement(file, current_cred(), &le, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -364,19 +362,16 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsm_export le;
 
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
+	ret = process_measurement(bprm->file, current_cred(), &le, NULL, 0,
 				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &le);
-	lsm_export_secid(&le, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	return process_measurement(bprm->file, bprm->cred, &le, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -392,12 +387,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
 	struct lsm_export le;
 
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	return process_measurement(file, current_cred(), &le, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -506,7 +499,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
 	struct lsm_export le;
 
 	if (!file && read_id == READING_FIRMWARE) {
@@ -530,8 +522,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	return process_measurement(file, current_cred(), &le, buf, size,
 				   MAY_READ, func);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 280f2410e551..fae4718d24f9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -286,7 +286,7 @@ static void ima_lsm_update_rules(void)
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsm_export *l,
 			    enum ima_hooks func, int mask)
 {
 	int i;
@@ -345,8 +345,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsm_export_to_all(&le, secid);
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
+		     struct lsm_export *l, enum ima_hooks func, int mask,
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
2.19.1

