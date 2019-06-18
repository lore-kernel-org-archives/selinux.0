Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D23BC31E5E
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB2A20863
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TaplVFEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfFRXGh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:37 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:41427
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730890AbfFRXGg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899193; bh=u07B+yoYWI2GYadu+kIgq7a6BiKfohEF6wrJByzSF04=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TaplVFEBGrftGg5r3xU5G19EIxQShW6IRmDfk/kWFG3Z/i4dssKH3m9GrLFvshq3eqgmCzPkTldO9KFk/BgLHrA7YSFba4/JUkFg7FzEvfU23TQMhjfU9oIpRmw04hIQRevX88R8jeYWhc9/rTeHmRW/P27OYWM+dXvBX436R4tu2S7D+pc8eReCapTDlg3dBZqjP91bTtEEsWD8FSU2dMA7UoQQ9bspHi7oRDpkHoTF0F8VtjTVqt+oyByOEZlHCI+L3LComYVvToxh0ROGRSAQUYBPA7Zxh6R58MW+5Eto6isfTqfbX1RXCpOI9YX5G7H/LkxcYYnQXqX7nw62ww==
X-YMail-OSG: MW4jhigVM1kEg9_7SdIAa_13BBSNNJ8IesFsJFhBJVodt2OfM1xMK4UYqbbMbdZ
 QnM7oRqnskOrzLa5czNM8RPGnf.bvd2F7X7ph2zlqiqwhD_zJ727BQBPQa8rtNqYi2TbiMV.wDCk
 ux6IzY1a5aYqu_.650LtyDDKIq4It0X1SZ6IGKbBhZ4K7QIC7Nda9xIFumiXTIPQHgS0UoPIjq70
 ._w3TdL3dQfbYfrdKvHjKuaXURsgQ2MvgUYdLc68kXCdfe3RjNC5N_sbCeH1Bsqtrbwmt13x_Zgn
 7sPdYM.V.XBSzGK4sN_JKfNopEuR4.7mMJv_T6VsVeRrzgzo5wL9Tnu2ybh0QXjGYpGo3ETmDDsy
 YEaUNo77sSt8Dk9bZj0Y3.HbVQEY1iPn9T0SVh38fb8ssMK4JZ6_BjePjKbgcw10qgPESoesj0pS
 HrQg8mpM6aycKAsGYB0OHWDAxtyM9U.bUgt3fr5XR8iGI8zQgPchqyYULxVM9zLF9Rz0sjRE_d3W
 EVAdCn5FWNqZBE1MvFfUBeGb_Jk3Mc9ZrL4_91rgamEPCDM11mClEhtWwHVwuouweydfD2mi_bPA
 N6aEOc.TlwSHJICuxiF_y4MicISXtiTapJOVJEm4v9QI0PMX4KyzsFaxCWxK1lCgVP98APLb8hDP
 0CB79Cp00rdEsIBBzXOhYLWJFKiq9a2FeNTlYKPxXx0zb417zwxeFB_My078prjG7.XTHFmep6hJ
 1DE7nt9ZUZKKUorkU5TyYHxE4hAGwKzkjwNWrR2HuZzWaYpHYFjwjDEpx4IDTAGZcE7RUN.6KMkx
 WB26ujeL9aqF.lZ.L9xghZExXPGOgOtckHNVfAqKeYiwc8uuKsq5hEMstqetIOXnYZsrSFaqe14F
 oYcjppZfTuhbsl8EFK5G0Mdh_ihaEtn228xumt8QCI4bWlodRbv0CkqFMArIziRoPAe6X2dKNknG
 uU5qfYW59eKXp4wrC2qc_vCv0ejoVy1A1vcnWw5x_sgX5hF1V4vqeXpC_W21nqcjfoL1LQYQT3.4
 HYl8TstXxX3YT3LWZ56KDaomc8B0dQKTHpGELjfyusQUPOesu9N6HMFL2q2.2mKECwvodwCezk8j
 HQx0Hn3WKDtpoAaj3q.Pwmk6zMIbVX9y7VrodZ9FEr_fJ8VY.a0D7eLFwwJ67w3QDP94hMe_6m6n
 tedT.ZdBuOQFB66IEaO.TC8p83uu13f0D.phA7cpwzm.JHFyML6rVPtyC5D4xBOdTYu34DuwGFyU
 zg_HXlTDJ9zMnxyaP1GJnlMdUTiovDreHaY54zFRW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:33 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 671694aa74794ae915ae1b1c311da411;
          Tue, 18 Jun 2019 23:06:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 11/25] LSM: Use lsmblob in security_task_getsecid
Date:   Tue, 18 Jun 2019 16:05:37 -0700
Message-Id: <20190618230551.7475-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c              |  4 +---
 include/linux/security.h              |  7 +++---
 kernel/audit.c                        |  6 ++----
 kernel/auditfilter.c                  |  4 +---
 kernel/auditsc.c                      | 22 +++++++++++++------
 net/netlabel/netlabel_unlabeled.c     |  5 ++++-
 net/netlabel/netlabel_user.h          |  6 +++++-
 security/integrity/ima/ima_appraise.c |  4 +++-
 security/integrity/ima/ima_main.c     | 31 ++++++++++++++++-----------
 security/security.c                   |  9 +++++---
 10 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a3204fbc1f28..9eb790200fba 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3119,11 +3119,9 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsmblob le;
 
-		security_task_getsecid(proc->tsk, &secid);
-		lsmblob_init(&le, secid);
+		security_task_getsecid(proc->tsk, &le);
 		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index ae448814f169..c73ad27a01c0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -396,7 +396,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsmblob *l);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1025,9 +1025,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct lsmblob *l)
 {
-	*secid = 0;
+	lsmblob_init(l, 0);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 5efd78ced915..3ab2a1c0ba61 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2075,14 +2075,12 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsmblob le;
 
-	security_task_getsecid(current, &sid);
-	if (!sid)
+	security_task_getsecid(current, &le);
+	if (!lsmblob_is_set(&le))
 		return 0;
 
-	lsmblob_init(&le, sid);
 	error = security_secid_to_secctx(&le, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 934ceae1ff70..3176fcac2b4a 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1323,7 +1323,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsmblob le;
 
 			switch (f->type) {
@@ -1354,8 +1353,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid(current, &sid);
-					lsmblob_init(&le, sid);
+					security_task_getsecid(current, &le);
 					result = security_audit_rule_match(&le,
 						   f->type, f->op, f->lsm_rule);
 				}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index a094f58aebbc..851947a77a16 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob le;
 	unsigned int sessionid;
 
@@ -628,10 +627,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &le);
 					need_sid = 0;
 				}
-				lsmblob_init(&le, sid);
 				result = security_audit_rule_match(&le, f->type,
 								   f->op,
 								   f->lsm_rule);
@@ -2363,12 +2361,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob le;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid(t, &le);
+	/* scaffolding - until target_sid is converted */
+	context->target_sid = le.secid[1];
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2385,6 +2386,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
+	struct lsmblob le;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2395,7 +2397,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid(current, &le);
+		/* scaffolding until audit_sig_sid is converted */
+		audit_sig_sid = le.secid[1];
 	}
 
 	if (!audit_signals || audit_dummy_context())
@@ -2408,7 +2412,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid(t, &le);
+		/* scaffolding until target_sid is converted */
+		ctx->target_sid = le.secid[1];
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2429,7 +2435,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &le);
+	/* scaffolding until target_sid is converted */
+	axp->target_sid[axp->pid_count] = le.secid[1];
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 46ac9721e261..57e0f81a2ec5 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1552,11 +1552,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob le;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid(current, &le);
+	/* scaffolding until audit_info.secid is converted */
+	audit_info.secid = le.secid[1];
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 4a397cde1a48..0f6ba20b9153 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -48,7 +48,11 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	struct lsmblob le;
+
+	security_task_getsecid(current, &le);
+	/* scaffolding until secid is converted */
+	audit_info->secid = le.secid[1];
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..b2af58b34255 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -51,11 +51,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
 	u32 secid;
+	struct lsmblob le;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &le);
+	lsmblob_secid(&le, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..99870a6286a9 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -335,12 +335,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	u32 secid;
+	struct lsmblob le;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		security_task_getsecid(current, &le);
+		/* scaffolding - until process_measurement changes */
+		return process_measurement(file, current_cred(), le.secid[1],
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -363,10 +364,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob le;
 
-	security_task_getsecid(current, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_task_getsecid(current, &le);
+	/* scaffolding until process_measurement changes */
+	ret = process_measurement(bprm->file, current_cred(), le.secid[1],
+				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
@@ -387,10 +390,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob le;
 
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_task_getsecid(current, &le);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), le.secid[1], NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -499,7 +503,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob le;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -521,8 +525,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	security_task_getsecid(current, &le);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), le.secid[1], buf, size,
 				   MAY_READ, func);
 }
 
diff --git a/security/security.c b/security/security.c
index bd929866ce0d..c92d6e04d577 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1724,10 +1724,13 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct lsmblob *l)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(l, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list)
+		hp->hook.task_getsecid(p, &l->secid[hp->slot]);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
-- 
2.20.1

