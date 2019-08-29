Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F6C3A5A7
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F4E21874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Odtz69Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfH2XaV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:21 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:39541
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbfH2XaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121419; bh=n9KYhenHMFy6/DvHoF7GAdIedxEuRn1itu30mtANhCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Odtz69WdwWJLGBHZyCaZ1Foo7iOFfwTA3mHk1ofhQI7HuUnpSx8kuKoqbDTYifQr5fA/lb1m6P+e8IR9AVBimo+kF2/rbiL+EkFmM0RKKBnXoYTzbnbxN546MADKY4Eyl/hBcIZYjlks4lj0zbwXspI+RYDxB3xISx0dlPng523R2DNXDFRBUl7NRxY30ab7W5dHB+1dTtsNSTxVtaIPg8XOpGRuzgF276VlDF1qn88lzbPMWf4KucVUret8p8dN4V48x6VG/qWtbRsYXDKVXW4QlyNKFCblkszxWJ9VXVXx+Dxu5UPl+XLLNhJHr+sMf+uMw4lb///PVMz/ss4JDg==
X-YMail-OSG: Gitt1WkVM1nZyszDwbDW6YdZY_ktPUKQ35aD_lkizzvKKBgXXzAb5qpbNnaXAzC
 hURA.D1f4x6nDN3qEfL3vFUQP1Oxppv0oG_15IUP8kT6WI9SnYE3n39kHWT2VtzDdJvSKjJXrU90
 rSLVN0fyzsQhxse29B_QfRtdPhZXo2V2Byr6g7tQGsaFbN5ZpWAtIu4Xq5lDwwHbHE9QcQAtvYIT
 wweSHPN6I9V_2nHX852FfEP3CMWzGB2WEgK6WeCBu018_iEgRWCjZLfyfrgiVQgfqZ_BxUYg1mqU
 WmreaYwcQoVmWvm_oztEN0uF2dEusKwfffeEfAhYcFAfgclfpynGGkxM8lLIThTIEtvyGtBGRJd0
 CpDDJH7lzgDZAws2FrYNrG4AKJTbNDx9v.Du6REE_ISk1Oa6IxuZrFFZbJx9KAkGO0berOY9JF85
 _JM1NKCbno.L2heTmDfevoZl4mIqlDr1s9qVH2WqzuaytmxCWghtMU.C5vwfeZ8n1S68zplT2lTz
 p2Zdw.aPD_coY6SVBFSB3j47cmcVolaTTzq8RrbI921qFDCDyZGC4Y8EO_Rc.70.35CvXEthb.y6
 lFTjC6LzU4LPN0FP25dsJXlI3bpVJVzqxzpGmv.FeGX6q4osEkzlGjRFGQOrsOVxhoF7jb91YITn
 0hrdZ6v8ASyOkUqM5T5_mhavsI.tNQceToAHxIk5RmPyG_vDoLUi3ubln6Gvxkl09iAoJuiLj2yt
 3kLCkNf7PMV6XCokZWxiF4K1PqK47X4K_TveTue6_6koCh8b4CC6F5n6Id3DgONC8vahowf.dt2s
 3YzVDDI5vIQgY_orKAv5doUEl9qXm8pt9BuzMnrm8bx7jPxvQd_8Ze9phVY6ZmS27qvVivo3A_lP
 s6tJ.HOxr7VY09pqsx9R93CBReSyZVff17ISGwEH.hAuZULZpwwasa4aQ98m_tgU8SrOpcQkBy8a
 9rjd7p55EFIjh5yXbhHJykGs_UEkLk5pvhTMqi.g1mjZ7q__mQ4of7mEDXgQjZMk0bj9Uv6esL4U
 1lIAhzyEi5668FQ81lVvP2mX3W.cgtA6lVhumnTB7M3.vMEyu4p00rhvR81Jy.DTl.mQhBD3LxKY
 tzQoR73SFdNzHpfh_HwAfyS7irKNjn_FlKgHKBZyr6NdjvqF7BN5niOHWLhOspJeiz5fWwZNRV2Y
 3GybpKpT1LsZ6GL1GnoCRKQqmU9L3S.As8KO60VwuwTX.BJ_Z_QDsNouY.gHd68b.t1xGMYRuyEB
 NJ5VY30RT7s_sAOWiTsqPpP82MeyfP7VsneNEpJya0sOLdP9tBiBMez3cJ0XdM3P5J9JyUPUeRCm
 7ts1LFPQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:19 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f8639e220c8a96cf24b2b0474e56d17f;
          Thu, 29 Aug 2019 23:30:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 24/28] Audit: Include object data for all security modules
Date:   Thu, 29 Aug 2019 16:29:31 -0700
Message-Id: <20190829232935.7099-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

