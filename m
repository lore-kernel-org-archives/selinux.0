Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E242C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0892084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OmSpPmrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDITTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:17 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:44774
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=WdnFJNhqMM887DyLRoNCsL62MRkkEDeoMEYJROIA3Sw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OmSpPmrzMO11FJI/w9Pu6kSt1UnK0hcCC9tAwxP79J+jgmo8o+nM1quZPGjNVrYYatcs3JHKinUmiVkhpL9VEYJ822j0AIk2T+u1r2hrwbTaPWhHUcP0VN/NV/DpNIvREzkhkqRcPwdK4e8j7myCS8HnhWSf9Ecqa47JftQ+e8viLUOdIufmpoaqGmC+lRkMe2s3orBDWBEeE+q36GEaqA67G2G1doh4MAJgwxTcPS8IVmxIO17hNo/kWugf2wACs89nKB5r9WFgzA9K9ljDUR1aNH0jiLu40al3RrDd3HgDh9Y8GPElsD6Z9vSHIs8M2K26K2lxKCOV6zHac5WoTg==
X-YMail-OSG: b_XjZREVM1lMzadR2eJyrTRrBvUK2kZlF5NeTMBiji9t8Az7r1XBn0T3LrYZlPM
 IZFaAgDmXmWJdoRlV6S_Q55sQ5Wh7AZfkO4xtF1WPT0xE_74y0e1atno5SI6lfHdGyBe6hlZl7KM
 Yk6oyxrT2wjmgA4qYg8Y5nB7jIDefwMzrEdp6xeKcUXlTTXaixjR2G7B2FRFSv1dGR7a1slD2gWS
 pOHThZ5qWRBnpaIAWhBx1kFIJcchoDfuEB.ytj4J95fXYcr2vhshgJy0hrIeZRGstxf_.LYoZNbF
 h7ti53EilDy4285Q3YCHMJekCDTCakVagC3mVd0r7TgnRHDu4m_0LQMd_fOqrFXSG.Mr0Z30P3Vb
 mwlSc9kmHSMOrhqs7mmhcm2d2UPmh3eYLfK2HJk.rsxjxSzDw3PCkeT.4mTjWYTK13CHbgZkpnpm
 G.LPqGwqNv34WgDzOoX1RlVxtUJMAiaw1fdv7hf5rXpkRs2JHWJygdsG0b8aZ7td0zBd1NXmSfkl
 lq7widGkCFuFdEl2irgUH0gYe1iQYWd8jBj_ish33vfHNFiOJJbEz0COakeDyn3roLdzTG8ANrNi
 EIsX9VIF2NQ_4cKFubk_DJck_4Z09h3uNvJ65qsdKvtBP4rDnjOhk.aNl0g7w.RdMOQ.CanN9eGC
 ljTZUpfEHPbcZtOZfjBFW5e05XJnN_fiK68qdIFjvikz8amUtkaE.ECOC1vqRXtNH5Ekf7xGUXqO
 TdDqM5matxc.vicTj.5RD3Ld5w06yixNwyysoDvvUrkvSnFXqI2Wgi3d1MjAYugvzFpzsU9X7e7h
 lG2H2wraVL1D8xnMBpDcAiBwzGv0xXA5orWhDt13JTMPQND8a03HaPPB0c.gJseTfFaSpXg5MKTZ
 OZRBuEZv2aIfv6CdCEwfboowZFc1G71KQV2X5ZkKs25CskFkGh3yiGhK5rUfDl7Xif0pp9MGoWGa
 cT59a_GvsAFfxHvk4BCnd_E_lbIAHiREb9tdmpDU4sRMSG3QOhUl2kYaQPaaPALTrqtf5NQq8hhU
 vJEHUb0KTbL8krFa7i9hFoAw5sA85gNavXlh4KjUJt_CTII1PZeHlTBCnO.1IR3RJHoNkkx6Kex1
 ThWXfPnDK34Eq_drPuOCLWqOE9xrGfLYw_GoBbSDULX_KDFGUo5zKt8s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 26/59] IMA: Clean out lsm_export scaffolding
Date:   Tue,  9 Apr 2019 12:18:15 -0700
Message-Id: <20190409191848.1380-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

