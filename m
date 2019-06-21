Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A932BC43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C512208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WJ5ATO41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFUSxO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:14 -0400
Received: from sonic316-19.consmr.mail.bf2.yahoo.com ([74.6.130.193]:45695
        "EHLO sonic316-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfFUSxO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143193; bh=hFcCsg9zV7QkE4d0Vm0mILJ2wP/KMZqh43Zw8pneyBc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WJ5ATO41mozm3AlwMi4SNfgT51GdfO00na74qZiYSyFMekk0XKVHZXeUmu7RYNDnPo3VZe7yC1YFgPyI5Cap4td2xkqF/jfdeqzwK85+39g7paBFNRYLWPaORlOz4rv0mDwtWifVqQFK1zGeU5aB5ge2CKDDIeq/kNCypvi+KFkAFN6PnI2j/tbFIu8GSJiid213u5mMTA1gvJFxuvAe5LEKK9xwdO3AlYS4Ij3RJbq9E+RC3PyuFSwqclXXnSEQ85eCrcpPUyfbrbWVOYEnfaMpmJwPpoUYVRK7YPgI8OyK7cjfmAeHvEmUQgwth0npSVvuMkGZwMwzv21qWRtopw==
X-YMail-OSG: 2nScNwIVM1n3BXLNFieErdY7dkagsnSKud46QUYaMexW15jiRyv6AJQ1aIQBV5D
 hl2dhQjP90aoJm2hmOEqMareUPxdF2Pgb2LzkuUxN3bh4mI5Tlv1vX247lZCLbxJ7l1Vz3fhc196
 4HubeuiXGmhCwtMdp9bI.YB1RHAI9SS2MdKHz14noU1aZ4IK.GDzaKWbc2dMTl6V64wxI16Vowih
 VtZs7ARReJQOawRPf_MV72uLHY7bfG5a4aH6u4AquutNGyJIBvlr5iKJQfqeronmJFeUNwK1dQxE
 XWC7aK0BmWrSnYB65XQNzu2BLlIgTnoZUd5jRU_mfNJ9.v0gtlqJMe42maWqysOwLSIz8S8XedjN
 8rXDgAu9fXjeI5c5RDsY6yxw.IgQCQF.I8lv9FBN7gBV.1wZ.X66nXLiv8hXxi7DboJLdHBxgC85
 QY07qpzRQpdRuD72k_JF1PB4VuA9WjBGs6fJnrKfI4DIcctTjvm68yQfvJD4YKTSaPB0mUbhXFWF
 cDuizTWqtm.Zz0kBNQAqJp5GjTd4YQLUsI1.LA2KoRDtaqdCjqZpw1JLTjupzW3rEWtxJdusF2ce
 D23OAZpniF4EdWrUpD3tYpsOtFN4sZg7c_Nh4gOm6_mMK98Gl.2TcPsTx9WKNzjNR6jaJfPm.hUc
 ZurNNbfTNcs4MTbWKHY5vc.N5Vb8vU85OoD1muvR5jq90ssGkE63b_5RIuW84Ffj.jMJV0CDs1aC
 DGB2Wpon2je_bDbanxzVGdroD47qplzeLV_EGykw7ebPGa0m2jsHtcXNd.VoDJkYZxkEh5YnASRo
 svJpZu_WSKXb3deF3BgWC9sExsUY_je9xo159DpWJ4BZ03lbjFme5lbbLi5pXVdhKQW2Pn6rWoT8
 lK_t5rEpIBP1jokj5Wan2J1zXOHImHkPJ8R.cT7bSmLhecpxfemsy5YlU7MxBO1an8pG60x8CVFz
 Jbcp3.tyLG5atHRKVcN7m878jONgTr1GdzlUGUbEDq6UT.Bt29Vio_WFE976RkiWuo8a3IqV6LHA
 dDRX8IF.oo18xnHBScp3fRJSXdcpCMsTmb6Lq_bbthmoAGxrbb_cfCL6tI5oyXTpGruz_43iAi5M
 SAP0b5QsJKjjVs4UuYAsCVjfBTK33.0Btv3yQff4DEdz7M2HVOT3evPYiUKnCZL.MuH46rEqUssI
 K04pE4qZQyPAuMvfFniNARKUEg.QUYsuqxdJHAnHI.Ck41g__fBs7H1KGYGznXlXwUdoUogx7YGB
 2JpsJFJLpm09YUCbK9kq9E36uiTPMSpV8x2ieZ.jCsJo4.0sZVJc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 989e9db4908b36ea4a327798a97c8ae5;
          Fri, 21 Jun 2019 18:53:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 14/24] IMA: Change internal interfaces to use lsmblobs
Date:   Fri, 21 Jun 2019 11:52:23 -0700
Message-Id: <20190621185233.6766-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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
index c7505fb122d4..03a2392852de 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LAM data of the task being validated
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

