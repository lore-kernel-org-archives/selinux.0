Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F4C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C06206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oYl/NdNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKMR6h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:37 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:33682
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfKMR6h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667914; bh=LfZjM4efI1ndLKOfcohV7YwoVdWrRHtus0U2gr1s04M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oYl/NdNwMbFYIKaxc4RnZ54cqsUW5yOrgJ1GZmayouZdCgkUcQuKkV350jn/3VD89yFVd3/VoC1y0zar5e/Yg7PqxRrebcoEnapi3qftAc7Es4V8txAlgIIbmUweNmVlqvlNOLQtW7/vjmfe+bVl7RZfE3/QWwYu+vt1C09NT1+v4BUrisF+NxdQ0Ercivi9KQ7SEb6PHgyOTUW8a87PRur1t/0wiwz4Ms+zPLbru/qY9Z1Uegvwpp/Tp3u/HdgqXRv9hfXy/3vcZLXXyCnVcV1CtBZXgM/UsGP543KW1ye3dA/3HN/nMZ702Ka6ZaHppZGnhdhxBu/t2w9ZXRm5Jg==
X-YMail-OSG: 8Hk_lFUVM1n29EW9Jh21WtXFQlgo57eVt.orwtOv_IzK1wttyVNsTaXisFSXY9E
 Ix0x78xElycqBftvnl9JyKeY_XvYRwRXjqVaA0VgsLV7xvPmKNdoQWS_8EBu6EHJHrPGK913Li5L
 hpRZu3IOulIKiTXoG47D4K7sPVzNGgTCRJ5XHGSDe75NVlGZFAodueyZ7FM_URq2rXItLHqln8D_
 GisensNG6NcIKDm1YIN7nHoGXDT4fu.O.kH4SbAyhXPozKvqQH8gIY0arcGrbX9GDaocmI8Z6e56
 lCl_exD4y6fbcTGFujPYR.U2YyHlG.75DmMN5UEPtXN.hDmdJeOZ1WguBXJTwOMtvkMfEobaJ07x
 k5UBsH9cipn25ULAyc1kl.dEr6sqPsAo.H0vwxn_o0aAFj_rsMnOxOct4clqiwX3FxjiTzjViNi_
 VaZ.ZynZ3flaNxq4IK9VgvQQoU2BlkFJWW2BMb.WPLEy234RmVJqpH2UsF5nvrZUn2K7QtLFu3qv
 3qzmI7g1LuApNDnhu87281pi1xPgO87SlKNDm82JgcsxsZc00hq1J_QwVJX.1TsH7Jfx1oI2HAgu
 vhgwvRpIDwi.ZSpDBcsv30QhJqKkM0g4W24p3CYftosfqr6CTiE1dAYNNSm3O1s72W4Dks7YTG37
 E_rveMYlFMIsHzl_sqSTtmqVCIRNDveo81D_ONg2PohfTSW4v1NGUEvuYsS0Ocn86QHisUSMi2Ak
 0MkH3ulwxnGa.0LR_Q8EfykuwZOg_eRFpi6bLJh8VBg9veejXqaL5w1x8_rtHsfnk8ITEPfXy8y7
 fs4x_O6xVnWjAuGAriDKWT3c7B44Gh8KHhJACXYv_BS2BdSDgK5m6wpTC4AkmdTDrXGR2OwZqnlq
 ChBqmCCas_QZ29xQkeJaxWWwtNZWI4oysMgqHy72oUvhTpU3lYjwqtttXdCVi9poUq65MbRPVlue
 9GL0xtWAU9Joj5LRAlhMmi5oWjQlkN1dfP9t8FyIb9jmHUPMPEqClib.4ANYIeC0MWcH3qndL_ne
 rC.iIdtQDFywaxQ2yw6zt9We7tCzNjgwqw2Y93dxT1YhamSSEJSbW0a3l9BCEVlyfvNM5kyO0uF0
 Nx3lCGCJUfewGkyIih0Ot0x8BynkBWkdoVIUXYu8I4MyiTVtL5.CPIN8QCiSczhHOslnGb_RK0bJ
 u5j1K2HVSHXb6R2VmCWhBP9IihoLoPDXIzwl.mKZPE1Xhyzki.pmR3dgcWhgDyTFPGVh72Std0U7
 YGF8h66FE6kEmvC4.okcoV1GvPa_z3_4U3t2Bfocs8fNdbiumSSgJC2j50P0u9cSPlVaDCNf9ISg
 _ndJzFVGMphrr79R8hHeey3IiUFEdQdDhERidpF3dhnEH4ULY4sOuhqC7WJalueiz0G3UXrpZL1r
 eiyQvKIZsAhaAIQe33N9XLTFFKs3GW1O0eTUSgGm283u3UmD6BLU2Sy07c8.9Pg5EMjjRyg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:34 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7adf454ff38eea70a1372d4a5370b9fb;
          Wed, 13 Nov 2019 17:58:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Wed, 13 Nov 2019 09:57:08 -0800
Message-Id: <20191113175721.2317-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The IMA interfaces ima_get_action() and ima_match_policy()
call LSM functions that use lsmblobs. Change the IMA functions
to pass the lsmblob to be compatible with the LSM functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima.h          | 11 ++++----
 security/integrity/ima/ima_api.c      | 10 +++----
 security/integrity/ima/ima_appraise.c |  4 +--
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 ++++-----
 5 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5bcd6011ef8c..4226622f50b1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,9 +205,9 @@ extern const char *const func_tokens[];
 struct modsig;
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -229,8 +229,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc);
 void ima_init_policy(void);
 void ima_update_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 610759fe63b8..1ab769fa7df6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -163,7 +163,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -181,15 +181,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
 				template_desc);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 7288a574459b..bc04c6f4bb20 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -47,15 +47,13 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
 	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	lsmblob_secid(&blob, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
+	return ima_match_policy(inode, current_cred(), &blob, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 305a00a6b087..a8e7e11b1c84 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -190,8 +190,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
 				&template_desc);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -384,8 +384,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -411,16 +410,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
-				  NULL, 0, MAY_EXEC, BPRM_CHECK);
+	ret = process_measurement(bprm->file, current_cred(), &blob, NULL, 0,
+				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
-				   NULL, 0, MAY_EXEC, CREDS_CHECK);
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
+				   MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -438,8 +435,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -571,9 +567,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -632,13 +627,14 @@ int ima_load_data(enum kernel_load_data_id id)
  * @size: size of buffer(in bytes).
  * @eventname: event name to be used for the buffer entry.
  * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * @blob: the LSM data of the task to be validated.
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 static void process_buffer_measurement(const void *buf, int size,
 				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+				       const struct cred *cred,
+				       struct lsmblob *blob)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -656,7 +652,7 @@ static void process_buffer_measurement(const void *buf, int size,
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
 
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
+	action = ima_get_action(NULL, cred, blob, 0, KEXEC_CMDLINE, &pcr,
 				&template_desc);
 	if (!(action & IMA_MEASURE))
 		return;
@@ -691,14 +687,12 @@ static void process_buffer_measurement(const void *buf, int size,
  */
 void ima_kexec_cmdline(const void *buf, int size)
 {
-	u32 secid;
 	struct lsmblob blob;
 
 	if (buf && size != 0) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   current_cred(), blob.secid[0]);
+					   current_cred(), &blob);
 	}
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c5417045e165..e863c0d0f9b7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -368,7 +368,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask)
 {
 	int i;
@@ -431,7 +431,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&blob, secid);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
@@ -475,7 +474,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -488,8 +487,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc)
 {
 	struct ima_rule_entry *entry;
@@ -504,7 +504,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.20.1

