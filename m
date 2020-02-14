Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B0C3F68F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A22222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c9gcD11S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgBNXn6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:43:58 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:42765
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728176AbgBNXn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723835; bh=DQ7wZIZU+MspA5KjkAuPAbFCVlWr5ctpeELSa/CfUkk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=c9gcD11SscrAGAJ8odCuT+e8vxbqSnGiAHvJl7NGI2rbhFkby2tZ5eHo2nHSJglKsyxqxnY4+m7My2GWpEvb7g3tJ8pZCK5QY/DhY1scFfox7Z2TMbeS/bQeZWOYuzeAvyGCnq38P5fltuX+cAT5LEuC0Av8bz4lB2MngOukdQJPl+cjk8GD0toQhXpf9SgaS2mRkyfKnwq5I5jMZfwMzGEtD2SySCXD9w1oHSUrWDHCjBxdMvByEPee4labn2t+jBqjCvEdFgXQ44zudV461jnW5daq7dYch1yOyyAkv12HkFMfuE30Orq0z+MUkYYNeiHPVdifxnL1Y51Dhubq4Q==
X-YMail-OSG: .nGRZe4VM1l2zQuVRAY9zeuXaRJB5rTO7EcBKJhx89CKn_rFPca4XB0Z2J2DL_1
 q5OKDEuS8CtfvVMUo.ramDq9xyp.yEOOrdE4uOST0sOn0D9Bl7LhXhhtjDjDRM2uY.MULQ2oUwtG
 Ay0_3mqdBEsqbKN00pEJaVtGMkzIcj3eVj0kv2acRrskMksn5HFm2ncYwrfgVzXybIrWdAkTQ6iE
 WdadNYHeFPBKXxb6Pe.Am9qLYToJ3EdQyS9e5ZybIBMWeScaDeuwIITEvLe9Q8ETxt5bFL9kHLuQ
 8MQR1THkvZIh0Lu3DbbKFW6Imb3oSzmq16Fzs6cbE8y7bLS8Z7la69RRXF1X_GROHdHbP.Q4Qjc_
 jPvxzkoBVkWzvGsZNQoU7exymTxnIA.29l3i1VnVCDnthiZohBbD7HD.RXrnV0RfHY6EQnUhWXAR
 UxLDYThh4Pz3lqHQCx.1bV.EI6M3EdFjCPt2PcgfBQ4Hs6mGRwnVz3fiehiHqpfOLItKr41QbtUO
 CbVIh7O5Rr_47sosT4h9q13uYn7ljjImGWxlz6he_zqrB_pOasgWkXu4OPTiTA6RGyBlEfyivWlH
 eSH4lYL5.r10oWL6gp60l7pjo7nKNm4rdIT2f8bGnLSkbXFbHj8q2xWVlD9XMnPZbuNK9_EiYzGM
 JS1l47XYJ9ZWRMGDUTPu5.g6p7d5dFsEAMIqd3XC7ELTaQoM1iC_6.x22ZvtWJQtwO5VI5W.XGhx
 OLJSlqJjc0Glt04K6TIbQoiKEFjCbN6Y2zt9U3FDtIuHfPIarHtGVqZcGmXnP60MsxbGhtsWW7so
 _6U9aKop7H_wQqKVIWWnqSPHJb5rwHXsfm5qcoqaxfWUTbSAHacRtod7LU_QVGkAmYGu2Dq1TuXB
 I1CIMmMD4YulevoQHZ.WQQg2942b4TDDkZQ.hEuXvca.xIhx4pzeS.d9aHDl3f_Jb354juHb9sYS
 Ikuf26uQxUfmlo3.0AyjRO2OHr37OzHFXfhWBIiJX_ff_0bof_6TbKa7kLf7yVKsfTORcEtPmUAa
 Qd8Lr7eHwCxKNp2HznKqc6FrPnF9eyWUrlyn2Kz9rk9V043LzsKcEYXkNH6u9RiKlDbh3CKU5KWH
 EwaMAdORU50X1kY6kiRa7bcu8CFq8S5qJHrfwJxWU_reHRAxXqv8Na2lQ3liZer7.nn9sBahJmpu
 h3zjc2qgvquklRIvQ1TxGk78i8DeAOZhzwAGdYInxYRZJCkCrj1GFctB_uzibGiG.uClhB075e.p
 n7kUiK2hMmTncwX7ze5STZQbjgLEB9W2rHgaCDnNVtC88ivsXQP1X7v_yyj5QUY1pyblX47vXpBA
 nG3qFRKeq8P50SdthXPEo9GbW9u0imEoMQl1BCjvJ1ILe0Mt780fqHlMCJMA0RxM7Z89yLrx8WpR
 94u_JmxlkJSXmcAn0jkBEjcT_TsxH_6atk_FRC0LnbHN6hCt03I6RhFnPDqnFPL4n6_umLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:43:55 +0000
Received: by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 57fdd4c7e447fc43d9116acb36d9c5de;
          Fri, 14 Feb 2020 23:43:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 11/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Fri, 14 Feb 2020 15:41:51 -0800
Message-Id: <20200214234203.7086-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_cred_getsecid() interface to fill in a
lsmblob instead of a u32 secid. The associated data elements
in the audit sub-system are changed from a secid to a lsmblob
to accommodate multiple possible LSM audit users.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 19 +++++++-----------
 kernel/audit.h                    |  5 +++--
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 62e095c34bcf..92a783f5ae1f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -438,7 +438,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index d7d51ad5d234..1bc0e1264115 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1417,23 +1417,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			struct lsmblob blob;
-
-			lsmblob_init(&blob, audit_sig_sid);
-			err = security_secid_to_secctx(&blob, &ctx, &len);
+		if (lsmblob_is_set(&audit_sig_lsm)) {
+			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
+						       &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmblob_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmblob_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2276,7 +2274,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2287,9 +2284,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &blob);
-		/* scaffolding until audit_sig_sid is converted */
-		audit_sig_sid = blob.secid[0];
+		security_task_getsecid(current, &audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/audit.h b/kernel/audit.h
index 6fb7160412d4..f65f516913c6 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 
@@ -134,7 +135,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
@@ -329,7 +330,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsmblob audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b55e66c2451d..d52ae228ad3d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -112,7 +112,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -957,14 +957,14 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid,
+				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
-	struct lsmblob blob;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -973,9 +973,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		lsmblob_init(&blob, sid);
-		if (security_secid_to_secctx(&blob, &ctx, &len)) {
+	if (lsmblob_is_set(blob)) {
+		if (security_secid_to_secctx(blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1546,7 +1545,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1555,7 +1554,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1733,7 +1732,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2384,15 +2383,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &blob);
-	/* scaffolding - until target_sid is converted */
-	context->target_sid = blob.secid[0];
+	security_task_getsecid(t, &context->target_lsm);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2408,7 +2404,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2420,9 +2415,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &blob);
-		/* scaffolding until target_sid is converted */
-		ctx->target_sid = blob.secid[0];
+		security_task_getsecid(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2443,9 +2436,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &blob);
-	/* scaffolding until target_sid is converted */
-	axp->target_sid[axp->pid_count] = blob.secid[0];
+	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1f50f68a6f5b..8ad399ea7883 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -412,7 +412,6 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
@@ -422,9 +421,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+	security_cred_getsecid(bprm->cred, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
+				   NULL, 0, MAY_EXEC, CREDS_CHECK);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 116800662a0f..2218abab789a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1647,10 +1647,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-void security_cred_getsecid(const struct cred *c, u32 *secid)
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.cred_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.cred_getsecid(c, &blob->secid[hp->lsmid->slot]);
+	}
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.24.1

