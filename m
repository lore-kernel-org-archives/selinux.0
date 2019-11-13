Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4764C43141
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC647206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JfyjcQ6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfKMSZf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:35 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43879
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbfKMSZe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669533; bh=AqABZKrHoJ2O/YxWBBlyrWT0dGVssWeBH837HbXrHjo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JfyjcQ6NUCYw8FsUl+NJIDTySLWpyQaVxr091yrrTLYQtu79zv+g2eOhtcs1t6NmggV+g1504iKAME+8zcB8Dfd3ZfI7VPEqAA2OKVJicK35cW0dqcVSayLkJYKjT4FLBK0M4xeFH+5GAVR5TzAyL/6T6VXa4gyEJsOAB0k8zoBvQK7AJFhBSrf6xxT47QqJ1ssHNvSs76cPUnPzrFRyKK9yHbrgdITiv5l268ZVb+NVNTKbI6ZsAgz5OWfQbeoqur710pImAwuOgHVXUUhxUIUoCcvbemF80L52ArVWi6V+v/tiHDyawOHwi2wCgVjlv05C18uQbk7MzmZlaY4f7g==
X-YMail-OSG: S1qBDk0VM1mM.fUjEi9MniiYq0QiznKKSC5HZTH1ttPdcP0.sNO6ncr3w.B4exo
 EDVU9bmcZOshR7dnNvWH26GBUzIHEcjzeTnzoK4GQ90cyEjXqYEDebuJR14BBoiN5X5RDqb7Q4yg
 jXjgWXH6JqBn.EZcH2GU9ANrtF1h8JUNaJzvtHNv3Qwp7SKf0wAYOBEWr8zKC4VO.abDk.WvHB7D
 ZGkr3yfBSmyxk7pYOphX8qJm2TIAFEompYZCL.c9tB131tKWUH1ndtXBtbe_j3uz5g7LdNXVJOon
 Z8XfskZ9rlXjrVJxt5hyqFO1SaISJNnM8rbSYYD.KwabMuM9YDEdjx0mIgl1m5NZqNNTf0W8Nrge
 .Vb7gDU35G5xbGabE0MVuVepzG1M_fzu91v9zPcc_9.s5ihwlIglmjYMYLwfqIUeNqe0J1GAh6Hc
 4qaV4kLhhY4ZB1gGwGLoH_DqbAW2EOU8ta8wMnhuS4H6uCaetB.X_8mzDoNW74DwITlKTGi37sw_
 ViXcPx.oVfD58uNB3gLp1ZzOIhQkyWGAgcx_MzHGOzJYTrz5z1GzWfamvuPNzddvaHM5vUbdbyDN
 mykeHk.88XQyUqM.AwHqmMpPnq6Kj9p6msP4cXHVT9sDPWbovHDXRF1RlQIT2nF5PqD8KKB0eB2o
 RyDmnQJVs.H.UpJ6D_Y8vImexbCPhI8hcFRocsS5vm.JWs2kLlfc.2kQ1FWoJ7AkJWRElgMmCxt6
 PUFtKbsCMhuoT6e2cKGYHNwSJ2zC4OGLIDm3AUGxQi5kp45KkMO7_0vr6M4t2lS1SRTkDoKlxXQw
 G89DQjECe6TYiIbbvrLivcHj6tz4d_twAwPTuGl2sxlHBbo0Kb1Oaj1yfhDSFdx1Ul0ah0kn_1bv
 uksZ0hzmseJ3sr4M8MNzMTiCMunG_HmjVvXrIotIKXV0FOFIs_eWSVPq5HOE4DMQ0hkKZI3RaWat
 b4VbbF49QW34WGOtUlhlRQZAtcTG9Z8fKn3rakfY9Z1SnrX0FkClcudh_Nr9xcl4.PGXeb3vNDWF
 gf3bh59_QOKwgprJqouKAAvxZENwh8XMRS3aDedHQZe58GOzOi14gLJYI4nOiOkKIugbeocO0J.K
 eYnI_APVh2G69oJxVAZa90JP_ka0ZgrBb2wenowEtgNrO7CsR5uiq7.R1.0LA1P6rYn6hyvNpd.E
 wT4zKA.2usGtsJEfZG._LQOOQtROZggU_95WcMtqheD.K.vWWYazcrfm7JquIQ8ZKFIwqY5_Rko3
 Jb5hzvPH_gHVaRPnw.f4jNPp94iOg7I1KIa1jZD97DbDf4CxwW73z02XnVWIxmKkStOW490TVBxv
 aaaXVC.AUjvcDDFUuxfgNmN_.dShO2HF1jcUVdYLgmkqyEY5BIOOVMaT1N8NeIe90C4W5lBRAQ3p
 aep40b.FLLZD.7OxRce.lH36vHTPZerrjV28HorOALNCkTfp3yMv.xkA4bUs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:25:33 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 49e6f77245781a0699a1cd8181a84e13;
          Wed, 13 Nov 2019 18:25:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 22/25] Audit: Include object data for all security modules
Date:   Wed, 13 Nov 2019 10:25:03 -0800
Message-Id: <20191113182506.2580-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113182506.2580-1-casey@schaufler-ca.com>
References: <20191113182506.2580-1-casey@schaufler-ca.com>
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
index af9bc09e656c..c9f1e1641542 100644
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
index e0dd643e9b13..0c071947c2b3 100644
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

