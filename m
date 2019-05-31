Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F77C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DFD26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ndmw5dX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaXM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:12:58 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:40934 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbfEaXM6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344376; bh=rnYFo5ZRZDk+OWS44zRZyocobFLx6h6kqTHu/9Enlaw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ndmw5dX7FlnDjNXy+p82zSNCuqaxHV1vqquxHttDhqiMzgpOr2RHwI/ra0uYgVVvfIEC2VX+6f9kMkvjOzfILO+ZOFarsPJ84ps6oW0GA3v2rCeqIj4jn5/6PR+5g1ClC0pXpq+oxEE5/kDEU96cDzK1J/kScXRRZButxRKj9a3edP+0OVyYRR0uyoUuCp5t3p0l7Z9y2g2mMHEaynv37lbMW4PVncl+kcJT4GSAP9Kzhh1z1iQEhR2FpedwQcCEPKFJtxemNXqlirAW8NxLrNyzhGWoAoYMihzyew4V40oPEeq5nxj+V6mx26FFbYB9IUUjSeElhkvCTq90xpWHow==
X-YMail-OSG: k_0FXlkVM1m_oEPYK6rDgU4Z49OLhAN70TCax_WnkPLy7QhtJ0Quf3oXkKrxxvt
 fthe4YaJLnz42FrqNhNSgvj40XRAOGfHnWjiIF_7VDc2Kqo0xst.IXL7CeVQ4KT5w4EklUjkvN1J
 ROmS9P3OTlJAOHXof.rhVmWiAWQM6yYtO4A6xjCoqHBVXM2IsLM4PyOysJtMlaH.C5UWI6zGtErs
 YlMKAg4aIVyoe38GYqB6kSQ.5RBtysAOajM5n8PtZOqQX0fmMFmW0LM0EA4ugrPG3nLs5eXc9b0l
 Ic4_KKwJKm679Dn_D7y1OS4YKHwHS_0ZfaUf.RuRQLDALfulnIa2FYiht6LrRpOytXGcm5_LVejx
 PBa9LS1YWPEMXr1PHtrDn1f26_MWcItfGazaA9zsWC8dev6PiDbXOv7GT4JZDJI64oo9Pl46XbpK
 V36WJgHdcDjyy7.86uMTAEK5YGo_OduiyYQ28ZerBGkPUbiqVDpYuMcLQtXocXtPZRSVsEetkcGe
 JKSWC6VsDzmDhXgy1LV5w_687OBwUsEjsYpXoNTcM9koQ3Nb_ivk78XzEKXiZfcdc.uC_rX1TbWe
 C0P_d_uD21k.s5FkzCbZajHppW1gVF98AyylnV15VDXXzxo1Fwyd59GU5Y_MnrJezqxLWa4OATfC
 OG2zknTuq8N7bxRF1AI0_14My6mQ9hRIZzBsfVkRwHriJO4WERlW2rScQ.oLNWHtl_cTLcAi7_Jh
 2qI3h9wLhlUgKzs_yo3CDz2oNFY5onlahdvwfMjYePA564Mrg2d8HVsTW2L.LL24hWPQ9jGQ_Xam
 p9M3H4PgN5DUAk3Vr7dhPFb3wxd3NYGAN5f_EIhgQ_eQUvdgPkuPJ9rHF_dCu_Ddp5COLDNdYdbp
 FMJNJYa3627czrMu5kTrK_9xZ2OWDgTtn02sSVfuG2YtjfqWhBh92mfTimsP26NvTnRBCN8s.XnS
 CeWHoVVlkVcx4R24cr1Umn10sT9kj1z5zUN4pi23.tNeFz8U019YIEUXWxebfkIQINgdzeYGAKED
 IroTgtOxNu5VZxbAckn2pMyCoudzXv41Ln8AOz1d2aDJfGuX0NU4TYO8D1jWPjLuWPcINpy6UVsz
 HeTTlQxMn8lXLmULEhPe76tnhx0rIc1Sn7gS7tNOrOcsr7du0Y8ZFsGaaHcQ4P_sdIDSnZslzd2o
 wStFLVTtJb0bFabRpIbJVBf36TzaYj1qejbpVn6WaweJGDsPa6veWQ2cDhmw0hcOGusyvWXMrZcV
 do5CXJ0DO_eQVCl83zQQEjuM8Yr.2lPzYnAYKY3qtev_zFNMiuSx7F75T
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:12:56 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6b512c5bef0dbdf030d04ed894ce55d5;
          Fri, 31 May 2019 23:12:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 19/58] LSM: Use lsm_export in security_task_getsecid
Date:   Fri, 31 May 2019 16:09:41 -0700
Message-Id: <20190531231020.628-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_task_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c              |  4 +---
 include/linux/security.h              |  7 ++++---
 kernel/audit.c                        |  4 ++--
 kernel/auditfilter.c                  |  4 +---
 kernel/auditsc.c                      | 18 +++++++++++-------
 net/netlabel/netlabel_unlabeled.c     |  4 +++-
 net/netlabel/netlabel_user.h          |  5 ++++-
 security/integrity/ima/ima_appraise.c |  4 +++-
 security/integrity/ima/ima_main.c     | 16 ++++++++++++----
 security/security.c                   |  8 +++-----
 10 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9119333f794b..0eeb5b75da5b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3119,11 +3119,9 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsm_export le;
 
-		security_task_getsecid(proc->tsk, &secid);
-		lsm_export_to_all(&le, secid);
+		security_task_getsecid(proc->tsk, &le);
 		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 6ac48c7c4a41..ae4c058abc5e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -394,7 +394,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsm_export *l);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1023,9 +1023,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index b5d96a0320fb..fa4c5544eb37 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2078,11 +2078,11 @@ int audit_log_task_context(struct audit_buffer *ab)
 	u32 sid;
 	struct lsm_export le;
 
-	security_task_getsecid(current, &sid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &sid);
 	if (!sid)
 		return 0;
 
-	lsm_export_to_all(&le, sid);
 	error = security_secid_to_secctx(&le, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 15771102919d..468dac2bdce5 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1323,7 +1323,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsm_export le;
 
 			switch (f->type) {
@@ -1354,8 +1353,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid(current, &sid);
-					lsm_export_to_all(&le, sid);
+					security_task_getsecid(current, &le);
 					result = security_audit_rule_match(&le,
 						   f->type, f->op, f->lsm_rule);
 				}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eabbf78fee96..b06ffcf9bb9f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsm_export le;
 	unsigned int sessionid;
 
@@ -628,10 +627,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &le);
 					need_sid = 0;
 				}
-				lsm_export_to_all(&le, sid);
 				result = security_audit_rule_match(&le, f->type,
 								   f->op,
 								   f->lsm_rule);
@@ -2362,12 +2360,14 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsm_export le;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid(t, &le);
+	lsm_export_secid(&le, &context->target_sid);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2384,6 +2384,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
+	struct lsm_export le;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2394,7 +2395,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid(current, &le);
+		lsm_export_secid(&le, &audit_sig_sid);
 	}
 
 	if (!audit_signals || audit_dummy_context())
@@ -2407,7 +2409,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid(t, &le);
+		lsm_export_secid(&le, &ctx->target_sid);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2428,7 +2431,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &le);
+	lsm_export_secid(&le, &axp->target_sid[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 00922f55dd9e..7f245d593c8f 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1554,11 +1554,13 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsm_export le;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &audit_info.secid);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 4a397cde1a48..2dbc4276bdcc 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -48,7 +48,10 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	struct lsm_export le;
+
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &audit_info->secid);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..be714afc9fd2 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -51,11 +51,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
 	u32 secid;
+	struct lsm_export le;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..1e3cfaf0ee5c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -336,9 +336,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
 	u32 secid;
+	struct lsm_export le;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
+		security_task_getsecid(current, &le);
+		lsm_export_secid(&le, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 	}
@@ -363,8 +365,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsm_export le;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
 				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
@@ -388,8 +392,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
 int ima_file_check(struct file *file, int mask)
 {
 	u32 secid;
+	struct lsm_export le;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
@@ -500,6 +506,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 {
 	enum ima_hooks func;
 	u32 secid;
+	struct lsm_export le;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -521,7 +528,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &le);
+	lsm_export_secid(&le, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
 }
diff --git a/security/security.c b/security/security.c
index 6ba1187c9655..22ea709593f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1690,12 +1690,10 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(task_getsecid, p, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(task_getsecid, p, l);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
-- 
2.19.1

