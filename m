Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A535C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163B21D7D
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="L76FGo+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPWZf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:25:35 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:38485
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfLPWZe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535131; bh=vAY+BSSlZvLKw6BmZsbfSaSyBBrsJ1eETqHGtnGVNto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=L76FGo+GM2WS8N/KomXAGDbhgTOKN720CbA6rBvKXiOHAYbrF8ntUs2khDeyg3+nbkcrRQDmxa1zclIYDieIiY2w0/Uo8oU59bBufCpoczpZEVeUgDMpQLExZD+l5ksWlOIugJD3vfUHsc5N2RpXbb5qJmODfuZVaJQb+9X0+kMAq56awuPM0T3xZdlIdBbwO193L88xheb4AiPK1O87mkZYs28pwzUWWNFaGMXePhYqn14urtDTlMaUjfMIix13LM5EsM5fwLEdCAApmfvQgh66QL51CgywmwN7nSNPpoD3h97f6scrceb73IGHX2ieUqiV/+sP/VWrFVgduFz5Hw==
X-YMail-OSG: d207woUVM1mpYUfR8KCDHujN9aE7Y9kcdhqKPiMCfXr0BawtFRt0NDpCTy3fTue
 aH_k1NiULdFa04Q8XglcbVmZ1WpMP5AeCskCqDLK1JXfSE.hYSU9utUh_cG4M9b.jFRa9ObZmNTL
 cKtFoMKLY8a0ErEK7gnydZCZSA8tdu5ohWjm2lRa8TCijBi8zhr01YEL1CAsJERmQqaTYWbjqpck
 0I02md1Hee6Jwpjxkwzhc8ss3gpAuSMZN.2uBW9kIyICP4LnqmGfhuBFcMe2MM4vVtd3EEmArHhA
 YH4m2R4bDTKAH3ppkUDDdbLdbKpJp_RfqeU7kGUXGYmaWVxfYXmnzc54XpwOL2_bApJMwUwAQRur
 7UdCfm4sDn.bigfgVJ_ISXegoc8AA6gKO9Z0unfhGnFxjqghnkxyrzEnxuaQVDX0jsIBVPojii3.
 GNPQ6oY6oMV9.lPmgYiCYguAMsgQKIOdsAUgwkvgWAzfTjojeSYJ9jGkyqr6BuMsBPdnaUwrCYYU
 D2WQ127CcKfZmM9jTVYPzILUL81vKRnoYCYAodPgnCLpgvgSN.bmaDwJkEtf6_jXaH4BlqLt2_aM
 Bwu8o6rUjn7tEZBB2T3NWTDy2knlwJrI1ncKvJUDTS4v_7ZKoxSkeipzSagYq079t17IMDzDiw.9
 _7hIJ_3b8gDMffMxrDmKzkXr1dQZgfFuSueRoTLhoi.uF7c4PQfzUx96csZtc_NRcIWpFGEnPo82
 sNwbbsDb62R34wasLGpQkgCfC2Il8Qu6XeeksCgyf4y8dpcUmobt.kyoHSHHTZPd6oeYEX8XNDOJ
 _kD.9mpmm1XhnxI3Li6qIwgqO4zqBYy.auKIRf7r6wZWaPCx_eZ2VlPZfSbgWVIx9qoIOqD.WaOE
 cMnFmQvCEJC8kXsE5EDKwc02kfa4.BA7FSjceqUybVyPQKRQT8I7aUQyan2.zA9eyjT7SryhrJnd
 sw0LLUEgJ3AQE3Tf8fBGT_ehR_ljDDNWk80ksi4573HcDUpPhiBMbf1RePqErnEM_N1cHaehJGde
 ctwcSuBAVi0UyyWydn9EHwIOmBqnNQAvyuY.bxckpB6Dc7W2hlQA9J.5S7dlLf4wTEFGbdFp3Mxx
 ZpY6TEXCVVDM1O0YZzdBb7E8vH9yezCjqj0PWld0OAZgHRhkgOJO0tFIqmslM5p2yAMjKuZhprpo
 G4jSKrQcLqm60V9CFoWjD0_qbg_rdDA_LddqVmA1mbYfTrdbA2Uu1CSyYQJ7SVMCcJOW8V_oUXaL
 Qtv0C4ELbA6ooc7nPCvgTSExKrW1Lnnz.rbe2ptrpwO9Qv5zZMyOsBlPAOYAiUH9hVY.G04xA292
 RdUHuPrsIrdfzj1eRTSkMtqlNNxWTmIKv1omWpgoK9ZrKUOxkJ78jcbwgmJ7asqPBnrlUoZMCea5
 rvSXkeSiWVyOzQuChgvmBn_vZ6qX8Cb83MEiVj_.DdT6NjaQclppvaBHrhsgfWa653Sk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:31 +0000
Received: by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92ff60b9e77fc5dff8e9e81027c191c6;
          Mon, 16 Dec 2019 22:25:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Mon, 16 Dec 2019 14:24:18 -0800
Message-Id: <20191216222431.4956-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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
 security/integrity/ima/ima.h          | 11 ++++-----
 security/integrity/ima/ima_api.c      | 10 ++++-----
 security/integrity/ima/ima_appraise.c |  4 +---
 security/integrity/ima/ima_main.c     | 32 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 +++++-----
 5 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d95b0ece7434..96b6662ea39f 100644
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
@@ -232,8 +232,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
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
index 69e549164949..01c755a242ac 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -48,15 +48,13 @@ bool is_ima_appraise_enabled(void)
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
index c8e3e234d446..86cc1419587e 100644
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
@@ -575,9 +571,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -669,9 +664,8 @@ void process_buffer_measurement(const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(NULL, current_cred(), blob.secid[0],
-					0, func, &pcr, &template);
+		action = ima_get_action(NULL, current_cred(), &blob, 0, func,
+					&pcr, &template);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c7d2ea47a326..b089d4a8b27b 100644
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

