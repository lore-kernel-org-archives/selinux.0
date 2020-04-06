Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ADDC2BA80
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA120768
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oNmY3xhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgDFVCE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:04 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:39022
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgDFVCC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 17:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206920; bh=xeM5O9VWq2QvuqfWm1TEoLqTzg+0Mk5HotqvF+QuxSw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oNmY3xhiQj57kmIGm6uq7WAimAOVe1ENPGa1hER1OqIsaPj+dd/WJC/ta/aBXtEPIdnQLdJZ3rORkWuMTxhuq4aY6ypAYN5FusBWq8PPP9KtOPKcZPXZeolcSMIp5VqZAyXTS+5D2JE0qXAMUM6h3WINm3b2ptw4k1q/imcdvvdVsF2iKZpQ8fLIyAgnX7PoXA3iUBMtbSs73VdFm0mr0UEvgkMOHHqFBv0qNAqbZL03wraRMuiDkxQD+yIqzeNJFFtQWXrkVzJX916gD5M7Z4lBlv+ZwpaZkQDub3vWAqlWcUU32M0jvrqE9KsppKKXY+07u4eGsMw2ZOw0bk6c8A==
X-YMail-OSG: RkQ_MskVM1k3_cAPIE0HCdhgoBkJqfQbHYVgyXOrlMZ_1pHiLLg2RfcmM3iCfwt
 aRIiEsu_Tl_O2iS8mZqLoplKKkvuZ5m27OLzYiqyDI2dEDoAxhRGIS2TifDNapFnEh9UmfKb7mYk
 W3GfUP3j4uPXe5DHvtinywBeZ8eeBYAcndjQzLAFR7wSvdRmNqLHAmbwkJvboeYlPWzFkQ7.8EmF
 YhcemAzo9rrKGRglOTZWwXcQV225CXvCYKD97_UO9quXvgYUTMGXhzqY2slcLbrtFSGT_gp.MmPB
 UzN86rkL95ZPdSEE6xysjCP_PZf_KV2XN771SWR6pyJoYhdO7fu0wgMGPFyv8uAk6Nb5YVk0BwiH
 VlowdEJn7yRdVYZDG8Oeotf1q7OvRQezeUUiE4KKsIdTivXP5o_ZOIn.xFgYUMM3WbB2pN2XRVkV
 iZ6uq8GP4pmSX9ITXzOycFb7HhvQk10YM_69ZHf_wJiu2UdAyGkm2VS9rV76GA0K969PtQ8_fHI9
 kR5Wp7oxN2uGGyrEEXS0qxdql5ud4yNKuqOFcN0DN0BrcOUqt35CBDsSke72F4ZucA7JBX.ozJW6
 cEQd73ebL_3JdPVnUnoqmJfZklHipzyBZeKD9nPxmxTb8141.lcWtXGBdVyW6vrF2iJBLiQ_u.m.
 XBtgXJPqhvHqNctD87dOWJlMcl7eF..hLATO00LHvJ6IE_oyJnrw6_Ths23ObzNmuAKvwTIqXKnx
 2a8fzdF7EcPQ6YgDqQX68oWAAPdtnOo0VdC8CWJQmHfuG9yneOc9P1H8izB3HJzrlU9SPF1Vnj0u
 LmLnZvvdubkbTIRvXL9ANGlYDJdPA6JCU2RtEZUrcoz_7n5ZqccjjYWUceSM2tbpUVM6YXNirLrE
 72wgJaakk.omvGwDLwvOJMSS1ErvI3.oDbCfMrWvEabil3EBvQb1B9kfuR.v9TOCSrLLCWfI_gp.
 eMhR1fn0_bOdXQykhO7LGuYyCsfxqn8oleXKqoodZDt4_nOSLTZ2GpWPI82QzarJLiHgQMoDmots
 HSVQ3HO8whb6id_MoaS4tGaLL4IqXVIQ9Aq4PTDfx7dHid8G1iFZTebp5s6ITpXnPhJQiGg8jGW7
 lRvNsGC.GvmXm1Uqu3zZHDydduWiycu5whpfoobcWinq2JyAL28s0tHJZov_CG9Pc19noHsNxdlB
 zcEwj0ya2VhbHs.Mltrw5A3ecklrn1kagPr8vf3yF64Xzf3wF0F147Lt7JS.eV4aFwBRl9Js5giQ
 cEolKFpt6AIRCp9JoX.bO3kMeaKCQxAh0ooUfg8dcqeDwB6M7aaZANtDSyeveYLOIrc0B8HGnQvb
 c4b5XNNMPb53yCGAVM_BWTy7I04rt6aqgtmLh25uCBOeq7wTqHxyo9qwiE7pik9pYldqp9qeVcls
 q9vCjENdPWqfAdL2q_lZtTymrn1ZnY134NEcCU6aEEDEfvuIBGzHbxCTg95xIy9QRIPxkhw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 21:02:00 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7c203c6b3a5ede762d0a99e279a453f6;
          Mon, 06 Apr 2020 21:01:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 09/23] LSM: Use lsmblob in security_task_getsecid
Date:   Mon,  6 Apr 2020 14:00:21 -0700
Message-Id: <20200406210035.42547-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406210035.42547-1-casey@schaufler-ca.com>
References: <20200406210035.42547-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_task_getsecid() interface to fill in
a lsmblob structure instead of a u32 secid in support of
LSM stacking. Audit interfaces will need to collect all
possible secids for possible reporting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 drivers/android/binder.c              | 12 +-------
 include/linux/security.h              |  7 +++--
 kernel/audit.c                        | 16 ++++------
 kernel/auditfilter.c                  |  4 +--
 kernel/auditsc.c                      | 25 ++++++++--------
 net/netlabel/netlabel_unlabeled.c     |  5 +++-
 net/netlabel/netlabel_user.h          |  6 +++-
 security/integrity/ima/ima_appraise.c | 10 ++++---
 security/integrity/ima/ima_main.c     | 42 +++++++++++++++------------
 security/security.c                   | 12 ++++++--
 10 files changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 2783fd9c7ad6..b6f22979a1db 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3106,20 +3106,10 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsmblob blob;
 		size_t added_size;
 
-		security_task_getsecid(proc->tsk, &secid);
-		/*
-		 * Later in this patch set security_task_getsecid() will
-		 * provide a lsmblob instead of a secid. lsmblob_init
-		 * is used to ensure that all the secids in the lsmblob
-		 * get the value returned from security_task_getsecid(),
-		 * which means that the one expected by
-		 * security_secid_to_secctx() will be set.
-		 */
-		lsmblob_init(&blob, secid);
+		security_task_getsecid(proc->tsk, &blob);
 		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 10c607a40057..cbc02e13e4b4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -472,7 +472,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1124,9 +1124,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 11da27db9b90..1a7646854813 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2071,19 +2071,12 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsmblob blob;
 
-	security_task_getsecid(current, &sid);
-	if (!sid)
+	security_task_getsecid(current, &blob);
+	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	/*
-	 * lsmblob_init sets all values in the lsmblob to sid.
-	 * This is temporary until security_task_getsecid is converted
-	 * to use a lsmblob, which happens later in this patch set.
-	 */
-	lsmblob_init(&blob, sid);
 	error = security_secid_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
@@ -2291,6 +2284,7 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
+	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2301,7 +2295,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid(current, &blob);
+		/* scaffolding until audit_sig_sid is converted */
+		audit_sig_sid = blob.secid[0];
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 542eee7ad882..eb1dc5dfe408 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1332,7 +1332,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsmblob blob;
 
 			switch (f->type) {
@@ -1363,8 +1362,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
-					security_task_getsecid(current, &sid);
-					lsmblob_init(&blob, sid);
+					security_task_getsecid(current, &blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
 						   f->lsm_rules);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c5aa1f10e7cc..e64f73cd5bc4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob;
 	unsigned int sessionid;
 
@@ -641,17 +640,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_isset) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &blob);
 					need_sid = 0;
 				}
-				/*
-				 * lsmblob_init sets all values in the lsmblob
-				 * to sid. This is temporary until
-				 * security_task_getsecid() is converted to
-				 * provide a lsmblob, which happens later in
-				 * this patch set.
-				 */
-				lsmblob_init(&blob, sid);
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2398,12 +2389,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid(t, &blob);
+	/* scaffolding - until target_sid is converted */
+	context->target_sid = blob.secid[0];
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2419,6 +2413,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2430,7 +2425,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid(t, &blob);
+		/* scaffolding until target_sid is converted */
+		ctx->target_sid = blob.secid[0];
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2451,7 +2448,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &blob);
+	/* scaffolding until target_sid is converted */
+	axp->target_sid[axp->pid_count] = blob.secid[0];
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 2ebe29ddf05e..f4a6204f4205 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1557,11 +1557,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until audit_info.secid is converted */
+	audit_info.secid = blob.secid[0];
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 3c67afce64f1..438b5db6c714 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -34,7 +34,11 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	struct lsmblob blob;
+
+	security_task_getsecid(current, &blob);
+	/* scaffolding until secid is converted */
+	audit_info->secid = blob.secid[0];
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a9649b04b9f1..3dfb573c7171 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -48,14 +48,16 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+	security_task_getsecid(current, &blob);
+	/* scaffolding the .secid[0] */
+	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
+				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL,
+				NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..1f50f68a6f5b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -384,12 +384,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		security_task_getsecid(current, &blob);
+		/* scaffolding - until process_measurement changes */
+		return process_measurement(file, current_cred(), blob.secid[0],
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -412,10 +413,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
+				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
@@ -436,10 +439,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -597,7 +601,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -619,9 +623,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], buf,
+				   size, MAY_READ, func);
 }
 
 /**
@@ -703,7 +708,7 @@ void process_buffer_measurement(const void *buf, int size,
 	} hash = {};
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_policy_flag)
 		return;
@@ -716,9 +721,10 @@ void process_buffer_measurement(const void *buf, int size,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_task_getsecid(current, &secid);
-		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template, keyring);
+		security_task_getsecid(current, &blob);
+		/* scaffolding */
+		action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
+					func, &pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/security.c b/security/security.c
index 776f62291b9f..58c8866d2871 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1732,10 +1732,16 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.task_getsecid(p, &blob->secid[hp->lsmid->slot]);
+	}
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
-- 
2.24.1

