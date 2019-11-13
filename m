Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF879C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA92084E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sF+DwaxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKMABi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:38 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:37294
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfKMABi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603296; bh=n9KYhenHMFy6/DvHoF7GAdIedxEuRn1itu30mtANhCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sF+DwaxR9GGbXlptfhAJTc6yc5ak7rWK31LeQf6R2e34HG/88fHRczBGgqnxTsw7GzP5KdoJyltASvQBhQcO8BI/zIwwwO3iE6OCSGXbs5FD636t2q6NYqDwN/IiPF+KqZhE0vWkYvPhf+HQq9EAjmBj1UeyuWjop8gSD64dr+TTg7+KJuxL6ZxJtlu5MJHwTCpLtTrWKYTNw4O+UYd4m39c9cUQaJ2jjPtm95cPhSASY1XOUtTPqaO2y081I5SyBk+vP0B+h3MIW6hg8eVQVR+AKX/6IUzUl/i/EaRiE/lNaCDJnCh1/slkUGx2UW0DlaP9+hq6uvf0zkwVmTieIg==
X-YMail-OSG: n3QsrNkVM1n7UaqPtgKyFJ01u27Y55IQ4GlcW3JUnVqxFY..AI6.oNdONgVsU.U
 6RDtooZDV5mJeeAYekaTwN0FYq_4XsVs1GDALK7kpd0RniNULjFhT3oi4A.luO2aiZ0uPK0nF5cq
 8LRmW2LuoWxcDhmARntDXNk.GqdExeokKwC4gzfOa2g10SMqqEHuljsWXl7YwIJjPoN5o.KaNRx1
 Jj9XTteX7OMEITVk5x37vIorRCvJn11b._KGp0hVNCnR0_6FA17B_EskVvAUAOnawvni5uYxkeBF
 tvR73JFZ0h6jgOLIPLsfc3shmTwhSvm9LMe6IceENrIxJek.Rp4AcONFfZ.glxNpCSnr___iJXhA
 cRyJAfVUF9WY_nuAKjGGO0XxBngon3__iraazRxYtAG8p3L8wEtlIsAn2eD2DZEKS2R0AN0.wFJ.
 tMAqPrGzkFpCCcul7qzKXngHI9aW8AWrtPdjkQJkLN9n2h0asrMxqmEzPUCcISvlA2N2s8fkyN02
 xTd5HIc_Q.LRu_IBbTJ8GFc_HBUJ_OvUcOypMjiwdxAFODaKVKjPw.tGHehQjlmFihOrKOMmYGEu
 63t7ThFtubk.E3e5otMA4GUo9FgmlVMJeUZoEHdyvVmOGqT5eVEX7JN1x912MtGH3MAcl3eYa.Ol
 S2E36o64c9v6kfT3p7w5vWkal49PrecGF48niSNmvb1AHwRAgiRZxm40Moo0r7CeYDn3jCvEOYVa
 vh0YP4NYBTYFBUEJDtTMegVIR82PZ59L8Ywun3vEL4Jszv.Mrt6EoaGoD2TLGDA0dvfD4sbk43QV
 9W9NBUO2vXUW3CIVI5fpkkawv4Buie4pNhbuAiTAEIAz.6J3wQ9TwfZVRxfJFLVQ1wZp.PnodfA8
 Y35oRBL1IGeNIpXBgZDSe5w7P0u54VSqRWHpu8INApjUQMThhPwSGpl64Ys77fx8cOJ1yecN2eDI
 cVnbtvouUScQ3QLUi4RuD0dkynEg_E0PIqpmwd5Fb5JDW89w.JARIcA6cBi_eKNItxQjp8YOkl8q
 i3oAOlqe8Io4KsacgnnksHMQujEqalLDrm0l5HqSaOoZPk37WqE6caUWMujX2RvsrMvoWamhY8_r
 hbfeNTZPyRGtkx3guCuc3MYKgepk.tGk4doN9xkVPNOoXJ7044MG27d1gZyrU9VznVZA_7pN0Ktg
 eWx1pkUzckDFhOLFGF_iF5mjHoxLXPOgl8OObjtnifP0kfMrS_L8c8kk1RNMSObSbPZwS1QE4EMI
 Nf5RExlf8aLEm6QsC.c_PnZmYraWRsrJGAal7P7D0Df_bWw4Bsp7BKLscl.IxIsNTIbB0V8d_iv4
 XaxiQY3WIV5c2gVBqQzb5Y5cfdn2PVLNoSldbPT30wuk5QPpv93GBvvhiNk6jlYu69Rq1a7T7vqk
 qkRO.8qj0Ot4sBA8.xG4M.qgMDgzh6lePXhZSij.p4I8QYcvjPnojXBFxQyNp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:36 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3fc9e96fd936fb81ed3ed6b645523234;
          Wed, 13 Nov 2019 00:01:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 22/25] Audit: Include object data for all security modules
Date:   Tue, 12 Nov 2019 16:00:19 -0800
Message-Id: <20191113000022.5300-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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

