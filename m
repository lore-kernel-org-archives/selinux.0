Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C9C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54926FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ahHpL4Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEaXOO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:14 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:33410 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfEaXOO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344451; bh=WdnFJNhqMM887DyLRoNCsL62MRkkEDeoMEYJROIA3Sw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ahHpL4EuYR5RmK/5mqnxkuM01ebP0aiGCNLM/10C9TYlJgSkXdQJGRlkUvSr7lEgc91f17ddPoYsoLwFPIzCnBCSM5ZSoJeXTRBsAvDQVYkzP+4EnuIR2Taio5RT9alKsmY8PQc7Ddpx1d0LuiLg7CQcgR8fPx3SArj/Vd1wTHnV58dME0olwLmlof7SrDZI7Kv4sHaRcM3+sfkXf3EDcWYPQIt+8DxUbPrnAj+2DjssuiZjka+bi6oZSNrO9YnCnJMhI6zWpm+CQyCcf+YXUWrzVH8YWtHhMF2gKGbeCyftY2pXH+LqBPLGYmjUy84os4SpFLMPVJ0Vi+fAR82OKg==
X-YMail-OSG: r7Swh10VM1mg04rC9EwYOUmWI8MNsWfLeo5TV6c1JESTFQ3BUwMjv1qRxA91a8V
 nWd96w.XK4ttHJ8zyyu6DkXaEO55Jk9P76jbEE8SmG8oBl.cCXivvMhOlLXwhxBNb.otPSn0sTjS
 EfwE9uNdabwWBaU1qo7zl9Mni8xnYLU1M8vIyEIF8Bw9SlFwNmSqMJYwuU_TLUyGodPBeshoUuOw
 2ey.l2h9T6HLNUoZffxKfJLPglaXINZQNTwgK20kw.8knabpyfc7VUg4CYYEsvOJ49NQ7usV0shr
 FXs_CnR0HOZWOA8Z0LZrM1kwtJr0KzFqyX5M5LU5ukciNGNQprf8hftBNl_CFJpFyCuNNSoudS.J
 ym57Eysz2CpT8qcdx3M6VWaEvoOoPOzmOfiizWx9CoGxLwBXylMMTqj637HoOdgJkzRUv1msC7dU
 yflFRA3QMJFUM43JGMy31TzPmlvRzdvS5v1Vq91b1oGf2mEnruwJru1aRbMF91Qky.EEWX8GkuQb
 CvFxWELiKx7fWKG9646b1cgGNL.EnH_t8w0LPiUsgujK.3ffr7NDty6ty8KJb4IDbsvg7Fi7J59c
 H6zzteWf9etT65V_k76qaNmxVfVGZFCBUgGcJ0oUueCx7PPcLKXeAFgRb4NR2GXP1NlO.jjsFQz8
 y6SUJ9wYEFLEauvgpZSRg3T2u5Kv8kErgIiCICFaea_DyuoaBlC9VlvgBlWJCKk7V1aWeFwLevHW
 48AS2mK7JEBG1R5EmxRB9nKUO3PNyJAer4OPJT6hIc3L0pvMisl20EkVYZD2q8RijYgeZ3trD3Me
 TMWBCw9JPmHmdNkrzlFk3MwGa9bnT0TZV.12E5CsKxUTffpYpefiEJn_MOnwM9fR3K1lewc.euHj
 WwDBQH1ZweSDKEf_M5_MwQcHwjKemy_TKzl48W7IGQ2ykSVyI0bC8oiuaMDiZWRJctptPgXbcs0j
 A9oe8mirjMRVAne9srM7vS2mWtT5l1aA_Jfja__7F.u7VnDqRuKfDFdN24KFVo38AX3kPyzcaKOD
 LkOIU6aMtTByTGmHy1OyANbJ4qzND2.XMWT049O3PM20rQutuKZFNN2n1F59oxH234jjq_kuP3g1
 LjSXYZNECu1pjozHXdISOGUthnx2IG3S6Ij7NhbZPvWAp1PRsVURTdn_YfLvinth2qScOC9aNbnX
 Vi3NjAhU6AvVuJ9BmiBy8mD7wVGgBi2pjEoKig8CYT0Aar5uWi.lD6glIOKDtjuk6Zq.m25Zaf9Y
 FCmKzriOftJYXkLvSpN4lgi6EM8kmRnofS6_rHtqMM_1pAiaHITOzvGdNnw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 36cce48665e985747dedfe39c8f2f209;
          Fri, 31 May 2019 23:14:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 25/58] IMA: Clean out lsm_export scaffolding
Date:   Fri, 31 May 2019 16:09:47 -0700
Message-Id: <20190531231020.628-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

