Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DCC433FE
	for <selinux@archiver.kernel.org>; Sat, 12 Dec 2020 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E307722571
	for <selinux@archiver.kernel.org>; Sat, 12 Dec 2020 18:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439670AbgLLSEH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Dec 2020 13:04:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51008 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439660AbgLLSD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Dec 2020 13:03:56 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0737D20B717B;
        Sat, 12 Dec 2020 10:03:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0737D20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607796194;
        bh=4Pm1A8J4Ohx8aWW4dXBLUuGUMZ5/4psVaaJYU4uo0VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRB94mMQrMVGPXbbtJbA8gjSKFknIEYB/17G526XEGY5bNkFFpQalihRp31tZ9yDb
         jtMF7YHbbxG7Wm7CRFla3zQraLfmrl1CjXXSxqt36XOyHNGShjiB/YlkNhq4LYYdsU
         5msPbmXs3woLDz4UOtcZZlCdUpI9fdJnBeq3qI0k=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v9 1/8] IMA: generalize keyring specific measurement constructs
Date:   Sat, 12 Dec 2020 10:02:44 -0800
Message-Id: <20201212180251.9943-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

IMA functions such as ima_match_keyring(), process_buffer_measurement(),
ima_match_policy() etc. handle data specific to keyrings. Currently,
these constructs are not generic to handle any func specific data.
This makes it harder to extend them without code duplication.

Refactor the keyring specific measurement constructs to be generic and
reusable in other measurement scenarios.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima.h        |  6 ++--
 security/integrity/ima/ima_api.c    |  6 ++--
 security/integrity/ima/ima_main.c   |  6 ++--
 security/integrity/ima/ima_policy.c | 46 ++++++++++++++++++-----------
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8e8b1e3cb847..e5622ce8cbb1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -256,7 +256,7 @@ static inline void ima_process_queued_keys(void) {}
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring);
+		   const char *func_data);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -268,7 +268,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring);
+				int pcr, const char *func_data);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -284,7 +284,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring);
+		     const char *func_data);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..af218babd198 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -170,7 +170,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
- * @keyring: keyring name used to determine the action
+ * @func_data: private data specific to @func, can be NULL.
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -186,14 +186,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring)
+		   const char *func_data)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, keyring);
+				template_desc, func_data);
 }
 
 /*
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 68956e884403..e76ef4bfd0f4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -786,13 +786,13 @@ int ima_post_load_data(char *buf, loff_t size,
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
- * @keyring: keyring name to determine the action to be performed
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring)
+				int pcr, const char *func_data)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -831,7 +831,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, keyring);
+					&pcr, &template, func_data);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 823a0c1379cb..a09d1a41a290 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -453,30 +453,41 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 }
 
 /**
- * ima_match_keyring - determine whether the keyring matches the measure rule
- * @rule: a pointer to a rule
- * @keyring: name of the keyring to match against the measure rule
+ * ima_match_rule_data - determine whether the given func_data matches
+ *			 the measure rule data
+ * @rule: IMA policy rule
+ * @func_data: data to match against the measure rule data
  * @cred: a pointer to a credentials structure for user validation
  *
- * Returns true if keyring matches one in the rule, false otherwise.
+ * Returns true if func_data matches one in the rule, false otherwise.
  */
-static bool ima_match_keyring(struct ima_rule_entry *rule,
-			      const char *keyring, const struct cred *cred)
+static bool ima_match_rule_data(struct ima_rule_entry *rule,
+				const char *func_data,
+				const struct cred *cred)
 {
+	const struct ima_rule_opt_list *opt_list = NULL;
 	bool matched = false;
 	size_t i;
 
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
 		return false;
 
-	if (!rule->keyrings)
-		return true;
+	switch (rule->func) {
+	case KEY_CHECK:
+		if (!rule->keyrings)
+			return true;
+
+		opt_list = rule->keyrings;
+		break;
+	default:
+		return false;
+	}
 
-	if (!keyring)
+	if (!func_data)
 		return false;
 
-	for (i = 0; i < rule->keyrings->count; i++) {
-		if (!strcmp(rule->keyrings->items[i], keyring)) {
+	for (i = 0; i < opt_list->count; i++) {
+		if (!strcmp(opt_list->items[i], func_data)) {
 			matched = true;
 			break;
 		}
@@ -493,20 +504,20 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
- * @keyring: keyring name to check in policy for KEY_CHECK func
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const struct cred *cred, u32 secid,
 			    enum ima_hooks func, int mask,
-			    const char *keyring)
+			    const char *func_data)
 {
 	int i;
 
 	if (func == KEY_CHECK) {
 		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-		       ima_match_keyring(rule, keyring, cred);
+			ima_match_rule_data(rule, func_data, cred);
 	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -610,8 +621,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
- * @keyring: the keyring name, if given, to be used to check in the policy.
- *           keyring can be NULL if func is anything other than KEY_CHECK.
+ * @func_data: private data specific to @func, can be NULL.
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -623,7 +633,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring)
+		     const char *func_data)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -638,7 +648,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 			continue;
 
 		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
-				     keyring))
+				     func_data))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.17.1

