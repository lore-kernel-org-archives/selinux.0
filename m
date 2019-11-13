Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA15DC17440
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ABB2084E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H6a9v1p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKMABM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:12 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:43829
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfKMABM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603269; bh=3OZ0QTMhwcTIDhDEmCMlZD0E+hS3/MR+doho0EPOFT0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=H6a9v1p0OJLDa43Nk6+dwTdHC/Su1ewxoLXE4hfQ8Oik5da1YgRNTnT7Jzs19sXjKQVTx3eaNpeEWGQaZFAZ667h2Hkv0pY8C5iDvE4htmKoSHSK1QjF7bnW6G/HaMm5IsmLw0oOjlb5yjD+KEDQg1sBXlyLvvAZxuZ7gMl0ijzWHZhYltvUGYunl6e6ZVewgotMirXKDhNTGbZWhBvkZ3K8hDmQEM18enksfk5CNkkXdgKiL0CQiuke7rUSLPq+2XtKQUsdPqUEgABkWSyGB8zCzjCnmhFNOUHYsNo1CP7R7m94qaKRkaLgtal/RAKBMYQD37aIKNNc9OtDvhGzPA==
X-YMail-OSG: KGUWPyIVM1loKxtdt2t9YpGfUzEpmyyFy.2hPabaWNhhNDPG2NyWg4CIX.MKRuy
 ucusVz9CqGyj.5n6YNVQwHKRfuBF0RNvPcDLEaafGrw5RS90qx6_vDrGhA_o7c.0Ge.tg4U6LyHH
 qcMul_BdxJ8EhgvxUuvk.TwpauDYOkqMngnMfPZnR4VMEU7Qa1BF8SC2irEGHmNvcOVIcnAT94ui
 RjqVvK.41LuHw6Y2YvktxJ7lr9oIpgnMh21dOsaHad3jHPCZ2jSIH6VJ6hNGc34WWLIFj182j_yS
 DadY8oMLWAyjbyytmK4CFpgL6KaWfXlOYD0YJBh.egjJdIj5mZPC7BT8xx3qABlDJp6NtwCZi7b0
 UOdYOZj0uVH6MlrB9tRWiggXihn1J5L1nZK.RBLC.0vDz_I20ZNapsuM.Biua0yDbCKbKKEiPz9t
 cWJF8Zr2Lp9Itg1YMhVh.nFLYWLov1VTdO3zPoRSQoLVvmuYvboG47G05JKgxBj2g8OwG9xWbrp_
 8zz5SF6P9QXyalVqOu5pYeUM1m7vS29gs0Vcqxapeq3ldRvss8FJCE4zc71NR4HFHRwqysrz9kd8
 bliSr4CGr28EwH.z.Eikk8jB8tcoTXbW34E..wv4f9eMKdl9vCr2OMiz3YXnav.KZZ3XjyRNaZ9.
 SAg1tWzvjjGx0yEfw3NtsAF74s.VG2PbptAAUJj0V7LHCrflDto9.4qZZBvpN2C5K5rt1L3pHxFA
 ap0BTCkbP3hmyfJ64CsrPPgow8cTblLBqGZM2eYc3w9PbXsvB1mZvo12A6C7ztfcwURGFlrUbXi3
 AmZ6WgbJRzonFOWOaJ5sehwZ_EqMWeFv1gmPcTTNs_AMxbl5TulSf8m1jxaUa..zzHz.drRJsDwy
 yjCZEmrM8boD7.pa5sJGCkzn84N8mffeEFdIUVmo75XexzWaU7gN6Q_2_iFo8E4Bn_C6LOMSu0Yb
 8gPbCupwFVxk6Ab7jrq.E5orcwMIJyx4yUTMWygPbBLoubOwPS9lXYC8Kqsk7qn6CgNekHs5pc6O
 TQK_1i4QijEsQIgk1pyTln1zAXNgYCbFog5GFfhM_CVUU7Q1SSe0YNIn3tpdgztL5b4dFkH5ICGO
 F4i7YdGr2VnCVE8I18qe_kQ7vBnypYOQBoqRdbSXNgQSryDbdUqCkWwNHFkgZi21wDuN8SgshjLF
 ncWMRpIh5t37kYMKfwfWmagmNfnrOZ6376M2ZxxaXNY1npdd4G8yScP1Eo7eXnQopJifTugggfTv
 r9uEy4PUnd.G.8werC4lCWQMumGzO3jGzJVX8X_yAOe0REIZux._9JoWwr6F.OzUNtJ14n_B91om
 AXmAktclrnAFhR0H5XHok9Z.3n0NyRtAWOHTGDoZWJL9B_ENEQpLbKRqeMRns.S5e46ctlqzFAOT
 XkoV668mlyU7D9wyZViAhTBassxievCDTkzzw6NFb__9.7s5mYJNiL828Aytrxy6T
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:09 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 498aa4bc8ee3a781207e3ee551d35445;
          Wed, 13 Nov 2019 00:01:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue, 12 Nov 2019 16:00:09 -0800
Message-Id: <20191113000022.5300-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
---
 security/integrity/ima/ima.h          | 10 ++++++----
 security/integrity/ima/ima_api.c      |  9 +++++----
 security/integrity/ima/ima_appraise.c |  4 +---
 security/integrity/ima/ima_main.c     | 27 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 ++++++------
 5 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5a337239d9e4..73b3b15dec5c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -192,8 +192,9 @@ enum ima_hooks {
 };
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
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
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..94b2a4840d81 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
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
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 85c7692fc4a3..3ff7aae81829 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -50,15 +50,13 @@ bool is_ima_appraise_enabled(void)
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
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1afb75a893af..0588dd9a88db 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -169,8 +169,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -192,7 +192,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -339,8 +339,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -366,16 +365,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -393,8 +390,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -526,9 +522,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 92ee3d984c73..dbad256aa7b4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -286,7 +286,7 @@ static void ima_lsm_update_rules(void)
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask)
 {
 	int i;
@@ -345,7 +345,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&blob, secid);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
@@ -394,7 +393,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
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
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -418,7 +418,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.20.1

