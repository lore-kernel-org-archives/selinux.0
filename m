Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621C3C2D0D2
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C28A20679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dRExiASH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLYADS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:03:18 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:46055
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfLYADS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232196; bh=Bq5qGJHX13cD644zefpRoDn61VV6l/ibu4fEKBgyUnw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dRExiASHT3OdvZKYnVDYLGA+mrdT2OZweDgxins2rGm2wIa07MDxqjPGqSvuZZ5scIZ3Hmj57CjW9gyu/p8yVlawoobc5EfN1TdioNWtLDSteBVwzpdoISli2U0j5NLabBNHoMomkcAGguRU0lbuWucAxdHTHJFL2coiq4TaNEKiStKvcmXN/5QuvzrVgVi6NHxtyBOWxFkRIxSAonlPbIEnYzdVOdSGWkIf9BSC6i8fAf/ggs6/WVW2NWwaHjfkcf9z0J90xlLeaFekkItPRdJmUU0JLjobzxSuA4pO1Ko+CoyDkN4bYZ+ED1zUQCmUrOGCNd9XO53pQJ2OB5U6qg==
X-YMail-OSG: pjArOSMVM1lF2w9GgBcfarE2YyA2XycKFhB8aQpaAf6zWPM40zb2n6ZUV7b0lzw
 G6uZ.gkSZNDnx0kOtXwE9TBh24gCdop8bxemgwbrqj1dT3sMqvHyIGvpO1CGFO9rdwoGfV0lc5rF
 ctEKjtE5VN.rH5gNwklVeMdEnDHWrYJ9QL.vVZ.tH6SXOpZS0P2SXgevo9L8orjtJWVBA6NKf_mA
 Za0TzMscjfNglqQgh106M3UJqtfs9qXJbyRXcLDHqv1sC2nILBrlLfaUN7cnmqCp3TS3qr1_Egyk
 d7JLcH0ob8kbiBp6vSY9xxpdaUdmuPaBUpx_L1X1Qkd13XSONQyZRxT._sLaQHWnSIemrOoMz19M
 HD2AC3gFdzAWk3M9Zd2M8fWRKKGKShh9AwDnY0wgTfPqMQ30WsL0HcFf8cdXoFtUPEe23eD3GPy4
 NLrN0NO5PpxiAmdaxl4Yq8t.15f1ZOnrYuckM.euruBWWBYwlaOw45BS8XooCH1DuJhDQiOsvjzt
 hvjfIWNjO2_2qUudL3Q.quWfbRJGzAThF6liPZmP5Yqn2CpQiNd8Dy985ZBd98GcfVCuBZoCVKP.
 UDGX1W.JX7b9QAUUfEtKidrP0sVjqF9nQqCrkUvRLh._ytjufFVb1yrT67XhbsB.RsnASwxjVuLR
 nuVZyHpgfFUKglu2zqppCaMPhrwopHEFVggwPq2Nu5yGrqVzrPw3Cl1y0PXrI7mCN2SStx049TjO
 XDxep54gn8SZmSa_AEtA_Nw91A4JML9bCkEwa8iwc9i1uEG0Ng4N0BMxeuSY47O_0ZbOlQAiaaPU
 o1Ci41nR0iV4LcCWEy4Vqdb90kWLGzQExMHQAreFmObShB.mWKGmYWfhX5i2DV_qHNfTLRXAKD8Y
 fTUHmIRzbir4vA9SCtfem7Lr2xRUgzNH_U5dENsXcwWBwPktk_cOPMpXNOuEC0Qxo6bs66l29vQ9
 K_ql4esIlz7prtE_z1.p4bO3Cei5mKrJjPhgIMjfaZKQg6kZinnPM_0qoKFYYw24mht1bovz0NnX
 CT0hjI89T2r8VgIagM5MHj0_qwcRZWjL6U9fB4PHxLT6JK9M.5yZX.OjEoR2bO.RabqihaNPG8zD
 ckQ3BSxqNKPcn2S03KiDhkrsK4hAUvWbZQU_DZsn7yV6SDGrhwTWEOeCMY09YnBu_le5oIlB3bzZ
 PUYjyV3MbtsLmO8nW0Iz79n9DaMXoAPoa8NfV6sHSdlN00lrGPAS0j2sy7GhdsKZNMrn.ypor7kQ
 rM.DcxO1RDm5jT0972F_tRTmuIHZit1VatedWh1SKHiMbv0SbAV4HzyZ8FM2h8yiB_3.C_n3GURB
 n4mxXgZMlc32EkywkbxR3f7UYomuNaPLUY_6Fhr79MAh0jzPkka11kAcQjIL2gPcicZClKEDWfuF
 1WFeUzUZmbKVSC63LBNP8dAfJ4pBqU3YHs1URdKL10zU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:03:16 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aedf02fec9fe6bb4a4ffd9636b4dac63;
          Wed, 25 Dec 2019 00:03:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 22/25] Audit: Include object data for all security modules
Date:   Tue, 24 Dec 2019 15:59:36 -0800
Message-Id: <20191224235939.7483-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc:linux-audit@redhat.com
---
 kernel/audit.h   |   4 +-
 kernel/auditsc.c | 110 ++++++++++++++++++++++++-----------------------
 2 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index f65f516913c6..9a26ba213f6a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -78,7 +78,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -152,7 +152,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7c381b1e9993..28fea2e73040 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -659,17 +659,15 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -681,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -956,13 +953,57 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -972,15 +1013,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1207,26 +1240,14 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1366,20 +1387,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1929,17 +1938,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
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
@@ -2285,14 +2290,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

