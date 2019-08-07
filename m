Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0068C433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BF821EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uebcghh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbfHGTpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:45:01 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:34370
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389197AbfHGTpB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207099; bh=n9KYhenHMFy6/DvHoF7GAdIedxEuRn1itu30mtANhCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Uebcghh1SKIVom3cBgptWgDNnkqRIqzNC9hHpCmKAU2zot7YDwqvYp32xeNf1pf7f33psWmjDRfhr7zNvGtQZffTGYZ/tCn5SqQnYyHfbrFJxJT6DuLVc0VZ75QF9JoZgQsgEr+COoif9JtcYCCnn7wVjMcSNXzb/gQh5ZHt4cor+axssyJf27J5qS9Tlh1XHL/WSXUttZUcaNAhraJ7Q7oUBxuWxjw/MFe0QOV5cGZ2HNRe2ke8SAJkwr9J5u6iYna4dP/OAHvdhdSc59nyym63u+JcKwRNVI9tE4y08FBiKXNyHrJJYiKz4GIqCdkuqiT1neffC3GKP30kNjEyiA==
X-YMail-OSG: VO040kEVM1n8UB38io72bu66wlRcVE2X3wBq1duDPpKsjKM924aoACGk4MDuvEU
 YOHitb00tV634d3Kwzc.Ja0S6kFPuh7YaKhOSlVT9RbsYQBIGe1FfzmmxhgGmZxzunE_Fj_S6XHx
 tfYAf_XmVeE.bFyWCyFjcp_2hsr6ObtJn44qko2ic1QLyFCn_TsjtCKjUG.JW44_V1IYKMCSmssN
 9bbo.AWSPwyXbMwByzbyJ9.UfZ_s5wtje3u1px_6Agc8U8r50.inoio0uSen_RfKMIWIMJsliASu
 XH8w2dO_KB9E4UBQmu6eGMD6x94mTeo_5oR2UWhDsghMwsJlhnRbYj3uFH7bTFAK0XKzzvxDjaxs
 nE2Tsz358MPM.0Td1DtldXjZARkxzUnVpPRuDkor8cIWNKHb8w4C2MAgQmwN8ZVhwhwd.mP_9SBa
 ylRpQYkDgri327GcILTidtZ7.r0N6MG5pGPQQc1IH1kd7XAIuABXpo_Gs.ECkOUKwQiV6mHYgpjI
 9PtG0qXZTSIxYgZ10SNT.H0xAVMXCpbEXqHTyNcsaXo1BbD5EATkp5k182uvaYheFS.VMzQRa9yD
 3arWhRU_YdcGA95_5s8EXh06pehR9ljPP8.jlyGbS4c9dVrLp2vduCfSczb8yKn_0YbsgJDpWE_X
 GR6Ts9Jd2XY50bVoQXFHSHR_9YUS9b9wK_tIS0uq8uJP5ocJiL9PtBx0CYjeTsqauO.RpxSmvcN7
 BGZ3zNcdzjgeXw3rb9AUoyu807kgdE0uGzJJsD4gwzgyY3Lfg0JwADT7mXi4BTPB5_dR4SGZvUS8
 APjdFffG13DxG._sNS2JxFXYwvf20YlCf.dKEK8rpqyC3koR8EPEr5RG3Bu.dJVmgobTehDGLABW
 Q7EWy2Kp9SoJCnruKq5hZbVfN6tx4p33rVC6rlDGf4.mnKW4T37PDqv1j1lmXWf.5pR15npgXBnN
 Iym0IorWCr_fIfD.TNemv769rHxtSqsEG_xxIoE4Wqc3qowif11fAaWPnkqwoj9l1GaHx677s2uH
 avh_7UGs3xyNbzu.6CptxDmM.lqNs6bFFdgn1OXzFl2S7zP.FcctsWoOTyc8FmMQXgI4WxRO90m8
 O4Sy8LiyQXUzNmZeq7zLjoQYQzoQNXgANCf4TAHyBQMXcKbalkAyiIy1CBXqrV7bgQpYqTsfxB_G
 cfwdXIcpxb57wjbO3j2hZ7pKazDplbXdRT6yk6acw6njdcxy70U9SXWlZ5.BI0bhP8IE9xvWrY1V
 f4uVXgEKPn1Ru0eNlLOOKAOSvMB4o8jLJj3jQJGlCSVWwP1sWuZ5glVKEbM2b8AIGZUhJinzsrnC
 fn.ku
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:59 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e1e2368a1a71816f77f09bb43c177f80;
          Wed, 07 Aug 2019 19:44:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 24/28] Audit: Include object data for all security modules
Date:   Wed,  7 Aug 2019 12:44:06 -0700
Message-Id: <20190807194410.9762-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When there is more than one context displaying security
module extend what goes into the audit record by supplimenting
the "obj=" with an "obj_<lsm>=" for each such security
module.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |   4 +-
 kernel/auditsc.c | 110 ++++++++++++++++++++++++-----------------------
 2 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 29e29c6f4afb..af9a7d1fc069 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -91,7 +91,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -165,7 +165,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 46d7a58babd2..04367c3593e4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -646,17 +646,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -668,8 +666,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -937,13 +934,57 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
+static int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob)
+{
+	struct lsmcontext context;
+	const char *lsm;
+	int i;
+
+	/*
+	 * None of the installed modules have object labels.
+	 */
+	if (security_lsm_slot_name(0) == NULL)
+		return 0;
+
+	if (blob->secid[0] != 0) {
+		if (security_secid_to_secctx(blob, &context, 0)) {
+			audit_log_format(ab, " obj=?");
+			return 1;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+	}
+
+	/*
+	 * Don't do anything more unless there is more than one LSM
+	 * with a security context to report.
+	 */
+	if (security_lsm_slot_name(1) == NULL)
+		return 0;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+		lsm = security_lsm_slot_name(i);
+		if (lsm == NULL)
+			break;
+		if (blob->secid[i] == 0)
+			continue;
+		if (security_secid_to_secctx(blob, &context, i)) {
+			audit_log_format(ab, " obj_%s=?", lsm);
+			continue;
+		}
+		audit_log_format(ab, " obj_%s=%s", lsm, context.context);
+		security_release_secctx(&context);
+	}
+	return 0;
+}
+
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid,
 				 unsigned int sessionid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -953,15 +994,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	rc = audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1187,26 +1220,14 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsmblob *oblob = & context->ipc.oblob;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
-			struct lsmcontext lsmcxt;
-			struct lsmblob blob;
-
-			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
-		}
+		if (audit_log_object_context(ab, oblob))
+			*call_panic = 1;
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1347,20 +1368,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
-		struct lsmcontext lsmctx;
-
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (audit_log_object_context(ab, &n->oblob) && call_panic)
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1908,17 +1917,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = blob.secid[0];
+	security_inode_getsecid(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2268,14 +2273,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &blob);
-	/* scaffolding on the [0] - change "osid" to a lsmblob */
-	context->ipc.osid = blob.secid[0];
+	security_ipc_getsecid(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.20.1

