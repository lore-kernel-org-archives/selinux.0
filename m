Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A3DC35242
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AF22087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Moe4VIMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAXAYy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:24:54 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:35245
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729860AbgAXAYx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825491; bh=t5dx8TZ4Zg/o/ErUFBiwR6wbezggb3MRRfDYsY5ZhvU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Moe4VIMh5n5SCmEklrhGk1nfrlM+QCQ13a552U1qP55lpFjVxY383WXPyfmUd7WklBH4taLOtaT06csZ7dUsh8hEcSqrfpchuvyiwhpwr1qGBFKjkbe0AQnrToGITvM5AL9CbuktnRzSuEbtarnscvX0quJOlfhlmHAaGBQlrHW5u5BdZPXSz/X8nq9WJDxf4ncyyI6c3gBLAKOaF+tS4ktdHf7xE3B6Q6l5z43w+Pszqd5hvcU4hsXDO1bloxsWntXtLgoJUO58hs24RuVHHCmoO3mNeqqU0lca6aVKydyaIOdQ1BH8XEm5q3RiInacArOPKKPIQiBurQZJiHrD1w==
X-YMail-OSG: XzqbnnkVM1kJFTn3jItq6dpm1uYOpAS1yf0Xab8rK87fJBjn_1QmZ3lNx77.LC6
 DuWj65EyX9GVlD7BLConIjMiOt3Hmpr35L52fpq3qvPI4Fct7AW9EEdTEy2Lpb8Xx1oDehtvqZXo
 XpDD.OHNFGw_G0rahwNrnTk1FNgOBttmY8jcGDl69zm0M8r5v5Z8JnGRaC0ERw0oVWYpotZnbqaa
 09TYRAcRQj08mVNrJ1I1UTFC1H9itZHLXW85at0kC_dNB8bH9BJihlTmgGM5SPXFt69zQ6TxOob9
 pJiP1J.7.NigqBfeOF0R_8MRROTE97kJatGSkdaUrjZPFIc888G.sEjf8JCyP3rKbxn2hzQo__kj
 DB7xlGf8KYoK45g9RNBMaz_kzPadm5gxD_SD7mh0DVwEDrGAqcH0885HaVIiliB828wAmmv3bhg0
 _jKHAeuYNjE18DiB26ADQl3rhCWiEozbQhZYreodSgZQR.cts5KChJsiFHuaY0EOCWeVNESFKBvO
 jczU.2jXVVRJ6TzL3sxLIUSOWHNf9C9fL71IJEPMstlx5rPGpqs0cDrkKnsFrRobv63yf0Aq9VqW
 W7x6ewyy57L5NKIq0b9dS9lt2Wq869.6vzZE88B7tLBq466pMqknJ5P.s2v.CFsipnPGu._g7auK
 ZZnonPAaE037BRZx3AcMZEi7_5lHu9_wmmND1tUugoCgQZle.uZDizgHA9kOIhYwSrlruI5YY9Bq
 5bLQFPL40LphRrbkQUkObUlWllWNT0omFYQKtEiy29pJs2z6ErYqwWaeys0ZhxXyZ0BYnqHhZcIN
 __6T31mqa.8LoCtaZmOsbgIJ_G3Skbx4RkBZ1ROSZ8f.OrWo2wchY15SYVpfrQjI.CKBT19TdfQE
 bzYKt1LCRrMofFGFpFHzt8xKe8QwSxfIcRB74PuQ_Hs1awlLQWmKJz.PWiy1JYWlpJ9ORBnjLTnX
 KdFvCUw5N_x8F5JPCjLE4Lp2ag4Y7x7WXFQ5jpAY5op6KV5YQ0kgj.jd.SOhfV2.jpmH0cEB5baF
 jiOlOKZ1OBZcdYBfSO.v2C2RzM6izqXyiBFRRRT2pcypgpntjId_Btbdz65OUOqiMl8QibKiLmYW
 7vVu1D3NxteMng0fHONA55f6cGNQFFaM_YeIO7hDTm5DmtXjuVKIduWkokQMCB8MlIoAqlZcr3rZ
 fwt6EAdrbLkzoeqjssEHgJGC.G0Uf4vQcM6L.uxUhbeRupGfj5dVxigzg2g2U6a1Wd296yOeAI8O
 LK7xYvAJldSuL5dSZvZ1HcTSItMDr8eydvVXZ.jQmQpxYZfmMns3lfLgB3X8L.WPXnYOA3SCJKFz
 pqXy1QJ8AmSd5Br7NjuFuvxv_JWTQBSIuHtXWxX7w1UgwjzWf_L9KFjsyTO5iXYsiR_3QXmgqlUv
 EAb99ai8ITfguroZCh7ZgenpcEHME1XyO..s3wCTHg3fsor5SVyItVI9xvUtKOGud77Dj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:24:51 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33e3032ffce284febc475e586577a65a;
          Fri, 24 Jan 2020 00:24:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 11/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu, 23 Jan 2020 16:22:54 -0800
Message-Id: <20200124002306.3552-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index a3426c002644..0c6d37bd43cd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -436,7 +436,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 6ee53e43c986..69b52f25038a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -124,7 +124,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1416,23 +1416,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -2275,7 +2273,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2286,9 +2283,7 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index 7c4bfc051ebc..c8e3e234d446 100644
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
index a4a1a7cccd4d..100e55777426 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,10 +1615,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

