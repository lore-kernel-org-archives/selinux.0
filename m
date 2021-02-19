Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D77C433DB
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF05B64E28
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSXaX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 18:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhBSXaW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 18:30:22 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA8C061794
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:19 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so3428999qvd.13
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S6kkwPyFasGabciXBJltzlq7+5sHKuwrKAkqRgvQL3M=;
        b=gRrVTkMd0bLcPNErbCR+furVE3KJWXR7HYFYaD6bMbRH9z+qIWwlb3CaflWrTEc8ot
         EHovfFYlJdwUY6F3YfvV1XaOuFKWvqYfwgRCoGBPHTLtYABAvXLSMOmb6BmocCYjdczC
         dVUsgVcVf/EJkAU3ORPdjOWOmZ0DSWJbbJ1bQq1pb6aoOnQxSapoZbS5gcj32Q6a+ind
         wBObNxdDm/1gHJmbSpRU53uc3N6Uw0ytopufVXh+FivYgm0WRu1SkOZqlQVj4QLN5lI0
         cWgvX+JaHfOXJD/qtXBKvLmCdPvoeSqZyHWpjDTkAWRaBYn3Yy5q01kaGtEAOLa4AOOa
         /DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S6kkwPyFasGabciXBJltzlq7+5sHKuwrKAkqRgvQL3M=;
        b=qmdSVgII9NsxnE5935yMGSU8UZD+QQvb5gNB/+nxp0AnY39e57xNwG2ZM+AI86e+sx
         bT7oVT+wF2WP9Tzv7SKHStrhG5CWI0A26TQHMQLaaNoFmPI/6BUs6ioJz+9TPBV6yfQn
         EYTMN7CJd02lcJlOvCbDlwCgyPSPERJMKWVUBp6A7gzlJhrYHiU0gBB4/6MoMCA0AXr0
         ux08yPUi0RelCYyLqc/klm/sZsoG2M0wuN7oKQfcdqYCSj2pfKfMkYQ9DH6vXezEr0KL
         um7qy/bTjd2MgHwLx6TxUnh4Nft09vhfKXlxOqxsvL5iylNdnbE73Gr2IPjKZ/yAOjdC
         gjmA==
X-Gm-Message-State: AOAM532q7GJKrWGX7cqtlw1raJxBI5fQbslWM6DHLNXy+Ab8VExwdkq8
        F5QonwJIuy7KashsmYP+Fvqfr4uproCKcBM=
X-Google-Smtp-Source: ABdhPJwHyXGvX+vZp5aaFyZsFbg5bgM6WfZ3lg0g95EmkbsrgxQTZ15j0Z3CDahrB9UZRwlnhsES0g==
X-Received: by 2002:a0c:90c9:: with SMTP id p67mr3868287qvp.14.1613777358770;
        Fri, 19 Feb 2021 15:29:18 -0800 (PST)
Received: from localhost ([151.203.60.33])
        by smtp.gmail.com with ESMTPSA id a206sm7569909qkc.7.2021.02.19.15.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:29:18 -0800 (PST)
Subject: [RFC PATCH 3/4] smack: differentiate between subjective and objective
 task credentials
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Fri, 19 Feb 2021 18:29:17 -0500
Message-ID: <161377735771.87807.8998552586584751981.stgit@sifl>
In-Reply-To: <161377712068.87807.12246856567527156637.stgit@sifl>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the split of the security_task_getsecid() into subjective and
objective variants it's time to update Smack to ensure it is using
the correct task creds.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack.h     |   18 +++++++++++++++++-
 security/smack/smack_lsm.c |   40 +++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index a9768b12716bf..08f9cb80655ce 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -383,7 +383,23 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
 	return tsp->smk_task;
 }
 
-static inline struct smack_known *smk_of_task_struct(
+static inline struct smack_known *smk_of_task_struct_subj(
+						const struct task_struct *t)
+{
+	struct smack_known *skp;
+	const struct cred *cred;
+
+	rcu_read_lock();
+
+	cred = rcu_dereference(t->cred);
+	skp = smk_of_task(smack_cred(cred));
+
+	rcu_read_unlock();
+
+	return skp;
+}
+
+static inline struct smack_known *smk_of_task_struct_obj(
 						const struct task_struct *t)
 {
 	struct smack_known *skp;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2bb354ef2c4a9..ea1a82742e8ba 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -159,7 +159,7 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
 static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct smack_known *smk_task = smk_of_task_struct(otp);
+	struct smack_known *smk_task = smk_of_task_struct_obj(otp);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (rc <= 0)
@@ -479,7 +479,7 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
 {
 	struct smack_known *skp;
 
-	skp = smk_of_task_struct(ctp);
+	skp = smk_of_task_struct_obj(ctp);
 
 	return smk_ptrace_rule_check(current, skp, mode, __func__);
 }
@@ -2031,7 +2031,7 @@ static int smk_curacc_on_task(struct task_struct *p, int access,
 				const char *caller)
 {
 	struct smk_audit_info ad;
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_subj(p);
 	int rc;
 
 	smk_ad_init(&ad, caller, LSM_AUDIT_DATA_TASK);
@@ -2076,15 +2076,29 @@ static int smack_task_getsid(struct task_struct *p)
 }
 
 /**
- * smack_task_getsecid - get the secid of the task
- * @p: the object task
+ * smack_task_getsecid_subj - get the subjective secid of the task
+ * @p: the task
  * @secid: where to put the result
  *
- * Sets the secid to contain a u32 version of the smack label.
+ * Sets the secid to contain a u32 version of the task's subjective smack label.
+ */
+static void smack_task_getsecid_subj(struct task_struct *p, u32 *secid)
+{
+	struct smack_known *skp = smk_of_task_struct_subj(p);
+
+	*secid = skp->smk_secid;
+}
+
+/**
+ * smack_task_getsecid_obj - get the objective secid of the task
+ * @p: the task
+ * @secid: where to put the result
+ *
+ * Sets the secid to contain a u32 version of the task's objective smack label.
  */
-static void smack_task_getsecid(struct task_struct *p, u32 *secid)
+static void smack_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_obj(p);
 
 	*secid = skp->smk_secid;
 }
@@ -2172,7 +2186,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 {
 	struct smk_audit_info ad;
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task_struct(p);
+	struct smack_known *tkp = smk_of_task_struct_obj(p);
 	int rc;
 
 	if (!sig)
@@ -2210,7 +2224,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	struct inode_smack *isp = smack_inode(inode);
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_obj(p);
 
 	isp->smk_inode = skp;
 	isp->smk_flags |= SMK_INODE_INSTANT;
@@ -3481,7 +3495,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  */
 static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_subj(p);
 	char *cp;
 	int slen;
 
@@ -4755,8 +4769,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid),
-	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid_subj),
+	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),

