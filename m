Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9956C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F86222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V3e77f8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgBNXoM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:44:12 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:40676
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728367AbgBNXoM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723850; bh=wd3sllg0H7uMaKBl871meRxv+kRV4h9UPqy+g1Oo7nQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V3e77f8dMHXq0niLBJQ9mNO8t74JXRVtpPO8HPSFkJYUHLhWn8Id8/rOrnw2o4pCjbWv54uKJ1O3wW03bNna2t8BmrqnaiL1KPnIYLsaEMTU7QIbkK6uE6s4HbyiXTkleNbJvI++R9wWx80p6gjjfbvRIKHQN4RHHwM++DnmBo7FCfxaIutuQnHT4kqzidbm/MgaEQ5qkFwSv0F4jVeh5M5urftx6+2sxKRB97Tj6zO4dkqAYV2kyQzaYDMdG3bQtMiSWzow4Hb24tpZUF0UdEkpO/JXYy7M4Ne8P8P0Pt76OixrDBxATXF0Ws867Je8PiDNJI5WFGh/6uaMXRi5dg==
X-YMail-OSG: E6JHWNYVM1mmFLfXr7OLfvCMQEeNDk0Ee3n6RU9vpATUI2v3tdPMm_RsQ1qSkcc
 DL98iksVThRPPHyF1PL9P7Csr6xtF8ogjtdBwbDBBDHNzW7KVmpAEVFFbKPsLUBZEZjs_5r.eGoH
 DJgxAJQJUDH0U3lKAHZYHI2pLcaJQmjMHKW2OPYEdFVuFVAWTnXGwyZ65DP_uo8oBg1ibAO7Nq_w
 B_RNJAlho2eO7DN40oP5LpaiYR.PqYplnMR8zM21eg8nRJuVrfiO95rdRviMP_sLbISBnQL2j7sa
 I2G_d.x196EEKooMGbOTUgkHaXbO_sH4DDws2ippYym.SnRUUBjj9lgOKn11sTdOhj4Hoh6xv9mC
 KbRj7QSacLgtRrI6yR9y14tmm9bmPsEiEUVIVPb3Mzu4k9XnzvgjBKUeBDoTOsPdJ3iJRqrJzh3l
 0c1UynuaIb7cG4GCViyF4nnEpVWZ5qTOl0EZw2r8TVCvPFbR4VJCOVfUJV.XNCRWkJY0N5BEQ0ik
 r.bnuZjpfFto28HNC_4gB2eRplgh8M4zEEAki.t05oOjWjWQZ08rlmf7DsJrcCFGdcQXUUb44b54
 QGTcpZgyRuUjyyadWh44YMCq6IZ2RASqh0nid1_kwvdOHHRYwTytc6l32o5QBO0TXx.CWOvdExjz
 uV04dgjFx2fTL7EK6fQckz9VxHoqOz1IpH7ewVRxBCWECjrE30Te03eiMPr.nj9FLJ8pbM54F29R
 NRh09EmV1iRre6wH5wqWKb2HxQ9FgDfNGcK4dRSlfHvwjLP.D9kywmbpyeLq7l4eQJNLW9vazq9H
 gdsWBVAADTbZYTD3jhXm0VROOPXt8wEjMaTKDC_7HX4mKndmzKm73bAQDD6E0PX95KhDJ7v4C5Y7
 BiYMxyGwySt6KV2CgnOcRDefVyHIzaAFz6.chDe6CXkxGqmft.6D0PKuMVqTdQRtpVeW5YmcKWWy
 ID0C0DAwFD6hkIaowTNqgO1KYWsTmKx9ZzUYmXJVyumNFlsOlQYrW4QvYUgqRQUww.V5wC2jJX9.
 iHiWSJdNJ3LBpmfywMwd6ywCLGUbSVNHNZOsAgaFOoNgK_L6TIR5BiR9hCHSzYb2OwWtU8uGbP_a
 JNmGbnVwV2NUir8Eg4HR2ML5Tv3chgiuMAS3uQiBgJT3.VERZtgfyXB2w9qq.3n2YFP5f35MTHG9
 D23Ow6.mpVoNm77PpMwYJcMYUU3hZ.f1XqB9GIWVd1EOms1O7wNYr4drcEN6QexJPG6zoe21Z62p
 eotEUiqPkQQDmp4EhdVtBWivg425Z.R6FFA_1md5dUaG9fkTA1.fUi0cY9fNqarGMnkp3HJY5e39
 i4u.3x5Cb4KZI8w1qHDTrDRsNbOTRzxkbDMZyeLn2heMALFNnlPDUULaGIFfYP68mth5Qs56wD94
 brILoSZcteqWCQIkhsn9RNyAJ6ztd9gmplOhnnLBFrF06dA8rmNYAOXGQBw.xiVg8nlQCsQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:44:10 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cb3a62f0a1530c83edfb2fd8c399384b;
          Fri, 14 Feb 2020 23:44:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 12/23] IMA: Change internal interfaces to use lsmblobs
Date:   Fri, 14 Feb 2020 15:41:52 -0800
Message-Id: <20200214234203.7086-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima.h          | 11 ++++-----
 security/integrity/ima/ima_api.c      | 10 ++++-----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 32 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 +++++-----
 5 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f9e3ca96fa52..a85aa57d28c5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -230,9 +230,9 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
@@ -258,8 +258,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f6bc00914aa5..b481bbc2e55f 100644
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
@@ -182,16 +182,16 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
 				template_desc, keyring);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dfb573c7171..bf66e3e6f398 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -54,10 +54,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding the .secid[0] */
-	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
-				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL,
-				NULL);
+	return ima_match_policy(inode, current_cred(), &blob, func, mask,
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8ad399ea7883..a6348dca299c 100644
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
 				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -388,8 +388,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -415,16 +414,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -442,8 +439,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -624,9 +620,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -722,9 +717,8 @@ void process_buffer_measurement(const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
-					func, &pcr, &template, keyring);
+		action = ima_get_action(NULL, current_cred(), &blob, 0, func,
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5c3270050dd8..5ff6218a9c4a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -426,7 +426,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -496,7 +496,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&blob, secid);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
@@ -540,7 +539,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -555,8 +554,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring)
 {
@@ -572,7 +572,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.24.1

