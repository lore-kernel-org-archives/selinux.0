Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE2C3F68F
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09DD2064B
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RNjSPEhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLPWer (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:47 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:41382
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbfLPWeq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535683; bh=vAY+BSSlZvLKw6BmZsbfSaSyBBrsJ1eETqHGtnGVNto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RNjSPEhj4dUwG/bZfQTuln0lMFONSbbwIiJGU5Mqh7IUaM8vhGJS/OJdjy5bT5lwrI6FJq0nCEd7rXFx/Qj4acMDSMK6YGOFV16M14a1PBBAMjpZZmzvjmPXjXC1C3/0ftHV77KsVrlQE+16vRSvkQcdV7iixpYblBBEVImXEssUbukawkoNiuta0M1Ca1CNLEWelvrvbYI3wZyIAHNKCwzaYrsRkJV20Gf6GbwExnLyD3ruHtpQqXYM7gqSj/p61vPSP9Rg2tgN1EQPI6aBktmYGwdgRXgHADqRS2pBM6EGz3WSPZ+UiNkBkHfE4A92hJBNFG1L/LnxOC8rYComHQ==
X-YMail-OSG: cNyOXlQVM1muBjq88liMTevaBYzF6cyb9OZ_.oxSFzFcyLRuuqL1mL2ChdVZxct
 95N7axVwGwC.l.C5JBVbPCT1_pmk83aLNdH32_Z3CyRxDktDmpKNeGROZeXY1cuzcI2HXw0trwhQ
 2EaCAl1xGUQk6MXTpDi7gG4xUWtOw0Vn.I4suOyULavGwPyPNUlkYKpMof778JGyqVWcRC8U4co4
 RM5SqN48FS8zSltchRCNAC4tf9JcGZmqhzAaZSlsKzQEHdofsXTHOlmFvZ2mytfWRyp7RTwwL1hZ
 LzKfx3owzWUbTdNkoEst.jSjUkUKE.7y04H0H.ncxVrJl7x4vhzVd.o2_VpVEaUxc_xyJQ3PBZDC
 L273raDNFJhgwJ2gYlBGw4Z2lzWD_P7sQgAmojQFBXz4nbhM7bxMkL5ZaWxkaxT7TSrl9lcLBgDf
 3coCQy42.psGbQa9LsSFSDtI.6RPn.kSkOK2biSonCnzdf_S0mE18SoToRNQOdg.Z9Yl7P0HrqcG
 VRKNB0L0Iwoz8yMI2MhiAht7Gt_hzcawcuKRghkU82R6Wr7pb.pGXvc2xHfaPUO5ZDi759b7SnRw
 4TCrjoVhHnz1RPV7fasrmwSYW00PLU0Jj7OYGipokHgtyGlGXzI_8fWKt_kloNNJQLjVkGjv.Obl
 WkznV2OM9ZNeIWUIyRmbmNvVxNmTGnUUsazuuhDpy3yWCgnCeFa3MaWazi4OoOWp_lNZ_1v1wa.J
 hZbV61fTF4U5C_Q1TbmIOiZKSbtcQLuZwchfTRgIturbRkdQ3Ffjj_.g3uKfJdwT6s2rqt7Hg5Fo
 YmSALtOV9C13DS1P.7hLu6KF09p_l449bpLsk7gTURcDZYC6m6BMH4SCqvJnhy_.arqQILHcp2OL
 1eAVJlK_cKeDk_wtAklF64C6k7Pqfk7eEPpYU9g_fd_uSrul96xN9I0xTx3IWHA.szzcPihfASab
 OhwjjcWYroy31BoVHI5DaXtuu_rO9JtKMsleKaCtb1x_PTm0N.LQqwQ7Pb80Im1ALdT9F86Wf4BJ
 j3z_7mvryiwIqJ1Iu8E5iP85WsfMnm7zI2hUkW0hcedvueJqd7dIwOeWLFvEIOL0kgljLw9AGSuO
 cBg4CbHRJnrMXkKpneQwZGMUf_bumBxgCx0UWjdFVE2c08OFAxu_jmD1rejvs81XbWVM_2.ohWdu
 Ig2TEkgs335d9fUb5YR2TIZsRg1OOQZDHNUskzseM4FmhnEuZS1LFdBApuGqghS8svC5jWSEwZQa
 1ltHZPVN3J8GyfcoGaOK7eGMSRGogVOrWpGXqZn542e8gaolVDlYV8t0rq2.RsZQGdL6SS2JdZkg
 IKyKE1rkitdM.RP81OxjEr134mDGJ7KjjjVMbU73M95M87oxspEu25n_SooUomWAex16Gvqe3G_9
 ToVxt0dB2mZY8CTx5rMDxtj4kUi71mnUfd4E6Mwy54VegNClcEFTnUnP5rZxqqLdQKD4EzTw6SQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:34:43 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 521dcbc8e4baff33d92f27a3b49b3d9a;
          Mon, 16 Dec 2019 22:34:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Mon, 16 Dec 2019 14:33:32 -0800
Message-Id: <20191216223345.5066-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
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

