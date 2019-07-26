Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671CC761AA
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C02F21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="On36LP4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGZXkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:40:06 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:43956
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbfGZXkF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184403; bh=n9KYhenHMFy6/DvHoF7GAdIedxEuRn1itu30mtANhCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=On36LP4Slld1mQXLhP4XQTsCH4DtVy6vWuQbqNPssQZo50tBh6hswUX0tQTU94wgK6wF0Fqul8cvyEHqYIyniBR3yeHOaXUXOTMQPLkUFElwy3pClpl1dr5b9RrCmTUiGxgdKI80Iovj5+pSAtE2YoowOPhc4hMmUmJwfycjD2NjmiU4JWeW22+ZP23tTn0nPnovb7lF/mKXXr+uxW9yeGsvYpgN1ffvEo67Uz5O3XNo6iACvCvtM9p5NhocVtQAw2Niu4BFhlv73YZ6QtT3ShOqniGfps1uhPclrVKfS/oZkIprkJnbt9nuna/zVG/wxLUoH6/BCIlLMpm+miX1rQ==
X-YMail-OSG: _qKYDBEVM1lB2B0CxbOI4GLTwTJwN5G1DW7gJj3ioR85yEUO_NOVIfD5MmVkysa
 Czol9HLAhexvWNbN_cMrgJob0nI04ucaN401IrheluokZAxs3tqNNGxk4uS5zNzT.3NB8lEn9mcB
 95OGkbz3ALzkrsfuxFBezdz.yACNDm__brFNdflnU.KrKM5wlP__Sv5UnKwPDrt8di_Kwgwu.xak
 LSN_J0FGiyHZl77cjLthbJ.Xp2W2_D_HrXq2c3E7D30ewNWUmHVNt6uvBXig5mH.PnxBl8FYq1Ux
 ZFaZrC9mUFOe2g8gmbMLQgbtNoulKY3zlUMkZMgs0dRXhgRhjwl0U0xCyuYxFfzeMpY7FZ4ZtK06
 OoVbEnAz2XZq8xmBo7ig.0sAmWsjXnI1TU4XqZvVWmQrLVDGCN97ackLFcSMNIMPQ8X05jPTFJEb
 FA2VJW.57Hfkt29vjC22_uXWmOBJVhT_ocxFdsHnOh69JOO6DE3.uYG9GQ3lzeRKEKMteYxogoO4
 F4uz8AHqz0DhVf_0ltTk6zzX_hfYff3AGq9NwzMpwmTzOx_IBzknhgKA5UN5p8YL.9jiu4mZ3EIr
 IFoFomrLf1PLHtEOYA9cIaNLa2A9_tmnS08F2AAgqOfg7ipzvDMGcO7swfma3x_NDl7OafmDgDhR
 Iyy__8UKlrkW1NDp0V8sQLwZ.qPwuGixyVmxk15JxRipDx_poYXVcvVRRplm_U.EE8m73TvPBcfs
 Qvb2uhhBNj9xoqhxE444wmAgwEWzIj0lkVpKdXDh2kRl1jrDmTrVf8qZ0inQyxTgbz9RIvuy_RxP
 k_IPje7AAbImDSawK389nD8jWqrBJ4X9zLDt.octHMj3wetqMvkwfj7E7Lupm3zD24CVVYdsjLX.
 J8FvLn3WI6O286Gl3mGS_cSiFxXYetjYqZpmVHp.rMuJi0rTwI8LKUJhz3nOlVHln.9EW3p25vwj
 eRZnQ9aZXTfzUYVou44zU5rimrxkJrjaeMn6OaAxLl9ORTZGe3EVZdYG_Wq_Tnf8S2R3r8fooxLl
 LhpCPAILh7bdxzrIyeGvxd0tZvomm0JGjBiN18DTzUbvDifwjjRnFgtgyeJbOKXfzPbQdwu9Rq85
 tzEw4i42_bql28nUfh7vZe39EoFzFDw4anAVUujZPt4em8XGaKXbsag2OHF8MzzSEl9doXMSV1A8
 YH30AxrFtph_gweBEh388.BnzvsJbIEK_AVhGJdgNu_v7BlKxFP6YHihDcjFihYFZkiw7FtjoX0J
 jbe46dVNV99.aJEfCvy8PtbTg_T50CylqK3oMFGA6xlEZMsRHJGeIZaIvhwQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:40:03 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 18e1fd6e499df9a683528f197f9ab77d;
          Fri, 26 Jul 2019 23:39:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 23/27] Audit: Include object data for all security modules
Date:   Fri, 26 Jul 2019 16:39:19 -0700
Message-Id: <20190726233923.2570-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

