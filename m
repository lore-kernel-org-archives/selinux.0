Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E20BC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D33206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pm/lb7g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfKMSUj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:39 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:45966
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728304AbfKMSUj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669237; bh=LfZjM4efI1ndLKOfcohV7YwoVdWrRHtus0U2gr1s04M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pm/lb7g8W2k2PD+C7pSPfEazZZskX/jx+QKvyi4bjpKVwObKg0Qux1zz9TpdUVEYfnGOlaMMw4ej0CLSdgX4T91ph1qVltzACuycrjoKF/7h17fDrOfarE+4+OnXqw727Zjp+7lY+WqH2UIsHZX7HlFTyLdC/DtH9RUWTLn1z15Dnzlp8zqNVoye6ZQNhVetVCurZ3H2IUV8R8m26C1VgLjg5iFevj+CYFpwOOyfEnBNaaCTh4j5rUT96GJ8sQwJDhSkFSC+rVo40uSSHmUCEG/Q2+oAWlVSNrxJs+bI51tXFIh7ICjdzI0RRI2wan4XW2y068X/l9f6mZPtigmsyw==
X-YMail-OSG: Rk5h7gwVM1klq2US0ES5aL3.Zknc1NxxUUTuINcLRvRIEQLtAFpiGw.XG4BAf2f
 LqjxL1CxOpBJ5.c7qClILkxBhqkNO0rLrgRzkHFkjP4c1pzdFl4lUMOGfxUpQhuUnZGym1fBaBba
 uUCiCQ4bgoCwwrC0CmhPswSvv_wso5MpPpMLROFLX3AaLyBmirA.CqmEK5IeSi.kIXgof2DDLTCr
 .LsfzXcnBAZo8oYN8wB4o57NPoBq2qZ2A.xjNKAIj2rksZ._dsEmYgVaFGJDWPV4cwKP_EMBw9r8
 I7zGQwRXubM.7JvS4ypW4w2dZXdVOGAgItRxf1BV.HTRprP5Qd1wQo4LGhcPuDFD6B11vKNFVaUE
 lp.5LR8_U1_5iK53f58QV08tqEEKeD2wsyYyHlo9eiad4E.CPjTjCEwK0xzbiBbJRbJrn3jIAKE0
 B6lEZ_gPuE_XmHtiOeWa_hgBfOYHyiXfbZ7U7ebUWWQRIyuc_fFjH3T4aLgyiGqmiPqDm2fqSV68
 wYO0Idz1MrkS7.jqFagP00DyFr8rfX83rbXu9TuFezcl9YIITcjVWFrmn.ehVKcI3CLWKClgV9uK
 J_5_fpqadgUCnAWJ5Ojpecu9KGu9HWJ4Uyz2YOn8j4KIQbvxeqopMl8qz2aOHErnxkq0RefTk4Ml
 58sCK9XUnedCZ0Oj.lKnvc4bnJOX0T50wy8T.HsnoehHwckNEfPBj1WU6.Yv.NVLe9f5yU4gTNO1
 CN0kX9ytRLMhHssPsG2T8mk0UeF2RLQsAVr_CM1OQC8KBE0M3B7FemoXchgDhsMW7WKXGsKVzJP6
 t02s6eaSNPEEISwisy7_u1LZkor.9vLxSf.YOFNBGGSOzfI.q93Yu63Kks16WW3K_5OHGF8oTKPv
 KRO3Plwqq8bpRSvdZEz4FAz.NKwvk1uF8SPhD2wHbdjlxatdXZl4j1jFTBeNV0lR78tvuqpKh.g2
 dsUP9dbXXha_yMk06aMYg4FY_Gk9aDv3xYIdeXp5JOgUTuYuBMWWYXWKumpYWuYgkSmZOAMaP_IX
 WXA2E2IwqfUlgZEy5sE5qdYkWStt3ztisqa80QkQbo9jv.02z2BKzDxJccZWjbBI_erOqFxW0tOi
 4AWCrM9mu5XAUX3sGzQXrwEac5tnlm3gl6MBgQ1s85x1ydQQyNCOrNA5Y4Yhg9N80vD8Mgn2CRNr
 nnlD5fgd8q4hR6wGkYX7.A6FqxRqvv.fNA8koHABXNj0zITPfJ3xcP_ccRaYofMN2OrMFTdYqIdT
 PgXul0IzJ8d6kty0iHw6VNC4oDRRY2qutZgDpIiXkqak_3ZNdpH4jweU3Ia7X23Ky6H7SOmHBGCp
 qX.49FoYdpp2GM1OimiEuo_VscQplgQXDmVYHuqI51b0UKMLF00dI_n0VdZsRSul11JHKsx3iJCZ
 thu2bwzL49_pqmdsbjN9Mn72urzDQU5FVBSwFgLMphMNSLPaGmUXnbUyG4C07O.MxN9FWUo7mGnI
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:20:37 +0000
Received: by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9cbcf78174c4efea072c9ee035f53f86;
          Wed, 13 Nov 2019 18:20:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Wed, 13 Nov 2019 10:19:12 -0800
Message-Id: <20191113181925.2437-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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

