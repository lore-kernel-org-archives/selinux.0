Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3791C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E6964E05
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhCRUnM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhCRUmi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 16:42:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77AEC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s2so5153964qtx.10
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N9/ZQWi3H1ZEoOPreAR08y/uDM2Vy6hcQtcK3+tbs64=;
        b=0wWFLi970CnA3BY9IPStn9yc3+kK/yNnbIIOxj8FaiyVlycQjhMJrQAGcKqhy8QO3H
         6LA3m45RQPPKpcvGsF6H2T+3yWW44yq0MH1r24X/mA3gaadr7g3UUxl/rJi/lj+nRk6/
         ZgUGkFLTxyoIsUNc6Vhir/WTCqUfdYu5umoUwhZxZB7zj4w5qPrpND+sMJloTqbFfpe5
         BLapx6o2lwYEnnftOVziwMXFXDPX8kFVfV07BXpcY54aqL7mFO2MYAm3/gzDn3eSW+oY
         wX/20NkPK9aEtNGzxNOA6PzxrCph4q8zRM5lG+vAxioMNdmvzKB30Z4Q2HnUFVZmDaEo
         xiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N9/ZQWi3H1ZEoOPreAR08y/uDM2Vy6hcQtcK3+tbs64=;
        b=p6lA2+cd7Nox8S7bu/IY8OkVSJ9JUnrJct/SpIaqQxclA92YPLCrQJQUS7KUhu8yze
         izvs7ApBlczeyRHphzZHzFin1pSyM7fFW1zBL8U69nLt11ExFT2P8LIAo9jAXSW6JNpn
         TuqFEgBVzw3NdWmH+nK9kb/DLCrIRjmAuPodXzBo4+unWGCcTCF2D5Dvyb1DEPiXvAYR
         nK6q9IiqK2mS1iU8z0fIaKtEZr4TfsNeZb+7/JEYX8ke+F5PpB5S+XvDAdVh0RtdeHkp
         B6p05qCgfhXVdgzCXq5QWAjPA8xsuOZ5UadsacYoZsli1cEnLui4WIZ90KBGcZXjSVqz
         SLPg==
X-Gm-Message-State: AOAM533XxjAocy2r7rmIOl2S0V2jrhGXahnvRidQuDxHWlCaX7zkL3vO
        eF66EJxMjoC7yzQ88wsJrKWlQjCV5ILukfQ=
X-Google-Smtp-Source: ABdhPJx3Em5N/vYp+usiM91ouf8RmFOqcpD72K/cfzTIvX/oyyqRpuQIwnNMHU4ERK5AfnTScOJ7Sw==
X-Received: by 2002:ac8:4b6d:: with SMTP id g13mr5519189qts.369.1616100157077;
        Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
Received: from localhost (pool-72-74-249-41.bstnma.fios.verizon.net. [72.74.249.41])
        by smtp.gmail.com with ESMTPSA id m25sm2288520qtq.59.2021.03.18.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:42:36 -0700 (PDT)
Subject: [PATCH v2 3/3] smack: differentiate between subjective and objective
 task credentials
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Richard Guy Briggs <rgb@redhat.com>
Date:   Thu, 18 Mar 2021 16:42:36 -0400
Message-ID: <161610015605.55424.11441635230700169117.stgit@olly>
In-Reply-To: <161609713992.55424.6906498317563652734.stgit@olly>
References: <161609713992.55424.6906498317563652734.stgit@olly>
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

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack.h     |   18 +++++++++++++++++-
 security/smack/smack_lsm.c |   40 +++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index a9768b12716b..08f9cb80655c 100644
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
index f546fb832f30..cd14bec4ad80 100644
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
@@ -2033,7 +2033,7 @@ static int smk_curacc_on_task(struct task_struct *p, int access,
 				const char *caller)
 {
 	struct smk_audit_info ad;
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_subj(p);
 	int rc;
 
 	smk_ad_init(&ad, caller, LSM_AUDIT_DATA_TASK);
@@ -2078,15 +2078,29 @@ static int smack_task_getsid(struct task_struct *p)
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
@@ -2174,7 +2188,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 {
 	struct smk_audit_info ad;
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task_struct(p);
+	struct smack_known *tkp = smk_of_task_struct_obj(p);
 	int rc;
 
 	if (!sig)
@@ -2212,7 +2226,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	struct inode_smack *isp = smack_inode(inode);
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_obj(p);
 
 	isp->smk_inode = skp;
 	isp->smk_flags |= SMK_INODE_INSTANT;
@@ -3483,7 +3497,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  */
 static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *skp = smk_of_task_struct_subj(p);
 	char *cp;
 	int slen;
 
@@ -4759,8 +4773,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
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

