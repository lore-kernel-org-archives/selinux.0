Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEEC433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AE421EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TaWwqA7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfHGToo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:44 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:41109 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388703AbfHGToo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207083; bh=3OZ0QTMhwcTIDhDEmCMlZD0E+hS3/MR+doho0EPOFT0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TaWwqA7ydGYGf91YYwiPOoB0Qz9tnr7BnIl6q719I4ug5JA4AYR9RlCNoBcUWOxkrefiCgsMKvNzqkMjQtt33kpb+Vx6fPm+oosKFNWD9H6iXFhPKDiDiqzj3XIu+vrcxg/EGXenwvNOjDu+MhuUaPT/17/V98MQqREVDZw/fmiM+JVTOuN5uZZEkwtEwXm5ZswIWanFRImn7QKI97pjuuvPEsXtFIAFnsxOHaQO0sSiIf/yX5Hr/7+tSse6YaBNNRdsTPmFvR1OfzITfGy1bacfzkcRlImJZVdAc/hz6J5eDkJGEb0n9veEVDkXYMnjqv+TgyvMt64VbssYoULj9w==
X-YMail-OSG: 5WQ0pvIVM1lIbhBOisMQE4YNIt03tCGQpA7CoT1SeZhAgk2egaXOAyiqMOp6QsR
 HQbidKrVZ2Oc0TtWtoK3F1nagDw0AW70XYqpqoWHsJzuWbyTUXAFBkzMYsbYlZUAfp5HkOfA22km
 .5IDxtaU8mJLK47z2TjuCu9fX1Mwa5ylxV2OlMjDQgSexiz0v1atI6jN5reqBIMP0ELxFN9m.m2e
 GOQKXWemQZx2nQjcFM8Ne2ym4YaF90IUSzTctc9O5eHG10vgt3T4QHSXunu170BIBKJWZY9.HI6o
 d7VccDRDzVOVcNkBeU9x95IBWgZpiHpPh3gQ8d8L4afgHrFt_GSddtg_TU.QEV7Q75k7u5.AVkgo
 .44Tp7Y53GpOVlt9kNCaotNIC85suhGHoWRFDuciPOShfdDhl5LyydhOtp.6RVPtloP3AL1MlmAN
 UmLmRtt_DjKAp0jIkK.bgc4j_qpKYP6hWRnn1pyUB9BQYYLoWWPEpIy8jdwbGPk9AUqPgE9Z7Rjc
 be2E63FRg82ZBVhED_PWXlvSxs.3L8uofKHhAVet20cCnK6NKdyCNyi4SedgrMcEMmRb3qukup1c
 sKhhExDDU.rDpJdHRxhjhFONTqF0ISCNrgpsiN3nY4jAxx5XSv5KRcag6ItuzWBVG3RFZMkMlrk9
 hThOrZcmuT0cpMIEYb5f973G48_kuiGiHjLi4dH57vQPzzhpPVQRcPLyMY2g6y8x2fbOIcoNwfrz
 J5iMY8o8XPzvQOeGOCkAKilhLq.uZ_dwInZYWzCIjfrN3UEw5i.GXg0S2AlKhsGiAWz6ZgI65sb9
 Q4KfUsEXC8Z5LbSMeuu0davf8wxep8Q9eYetJHO1BcjEwaTRrEsCoasjbCTYh7LmFDqLAPd7mN7z
 i9dg1NqCY0yaFo1R4qYARNiVmtL6Z3OvqDrzF3RiTBelDre9cfEXKmv8N5W1l.5VMgNc9ZAPYpm3
 ZLtAQrAWHCFRk6NkqUHX_YMKHeWGbgZdhAJH9M_eGFfWl_oWb5si6O3Z5AKup.MTR2IlQQbbRolj
 bFD1I1dmuPkJIFMcTdhYzmYyF4HvFXG6PRN1IlFBky07.dUYFBjCcyn0Mbf79P6pAoXhZA0Y9EhW
 181ZMnIVU63v_veno4g6Da4k3Xb5YluXk1eL_jkXAtax5nkgZ6pkXyHNsOhRpm3mcJP.ap588EBm
 4rYj.7kX7n44N4UXcj4.koiPJ7luS5jmxKkWMYJzcDov9t_QpHbwYBqMfaf6px9tK8SNq2I.c1hj
 A2tsShsWK.P9M5oh0SAocAx0e0.G_08RdOkmILdggFqlgeoEQ5wxZskjNiz.9CNv6xytuFeVDnSX
 7fqWvAl7g9BRqZ1o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:43 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5794cbfdaa50515bb41c5d22b089570d;
          Wed, 07 Aug 2019 19:44:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 14/28] IMA: Change internal interfaces to use lsmblobs
Date:   Wed,  7 Aug 2019 12:43:56 -0700
Message-Id: <20190807194410.9762-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

