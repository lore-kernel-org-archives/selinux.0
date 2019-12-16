Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85BC2D0C3
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313DB21739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fam9OwUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfLPWi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:26 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39116
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbfLPWi0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535904; bh=AqABZKrHoJ2O/YxWBBlyrWT0dGVssWeBH837HbXrHjo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fam9OwUzaNvMcgF1Nokg58E4KBQQX8hiXlQ0gpFeLwrQ2jwH28ESrr3ud6ghTvB5b4QO16tJwmVAXJ1hL9YTYY8ohZgMjX1uN3CqZs/GJuaBihn/5Swt0VBUrelA7IoHxphS8n25f7E5TJ6mty6NZ3fyxmuII9KrnQOLGAJx50p2nSYuEeXoL/+n9EZ+7Crt0F4XGOAglElHphmz5rf1A7T8uq4mI15CFmYRQa/xYsaGY3PJ24Nx+VKK1UXjI4rUA5pK4jy9qQ4rr5SJa8MNbgsjlM226u414xwf7C3ZpBX8FcmCT8O3OQHIAPR8KDgL7+bPYTYXPizZUNA6nX5I4w==
X-YMail-OSG: H50dCtEVM1mItH4NRPva5huSUQwwg1oJhtQC8WKhDMCSRoUaS29rLJlL7Sh7ZIU
 3HOGC3Wms5Qzj1Q5McMH4fl1b6TVtqUwdNbPacLnqbww54ovJZRILqSkWTC9QMu6zYDzg1fq0oGU
 3CzE_3jHvjzv2lMDvegq8nU7iwN7.MwI2ZpWBuEgxltZBbUwHeTEu0e7VwhP_3rS0yUKiABRJUxN
 dhQZS8Zg294gW1s1a9VN1lOZynwJrD8izi2GCcwe03.dCLxJRvGaEK3ssROv6Nvr0u9hCqbDd9hz
 be5BbBBwb_m0fnd2sSwjGcIr8A_GeYIu7uKPo6sFqlihcon7lvrHhc3tsC72HP61_ryDZ4xppY9V
 jQeEQBEffra.X1NSU1J7PXmXZLmZZoBzEGwnF8NNnxjORlTNYG3xgSifDUJJqpG_eNgOrdFFLAxL
 wRZG8IKSBvasqw.RrUVMoYzRwjV38TXhQEQCM0llNDuZICNoRpwB5aVv0SZ4b08x875Cy0yYeley
 ssVL_NUJNh5uoSsmyb.n3vxNHYOb3qKZI9gRYjxGQSmWYizLHhXBafqmVzx0JiUBEE0ZZsc7fQ1M
 AIzU5MjqN0k.2LHGe3TxuFLizM.9Al6H.r9ZqwmyizxLMBxM5Atl3ioWOzuzh6OCqR8VE0gpAFRH
 SyhiFl8Zg9C0uLsXSYJ1v08PSjPvI_N61IwY2Pdcq_Igvf5DEFqYxfdihmqMwJDPIxKN2.FmZ2.d
 o7havt819rbCujAizbngI5sT7r5qnxvpXUXNuDpOWhPak8f_BOQF2PwNvE2FQNOogwpbzhYLj3xA
 vZtmla003ftAcw7ZSSIeP78MeG3UPm0DpVe2GlaVEYFf4tlmLyoh0x1JTz_kLnkT3jxouaB95mdZ
 VPFKC_FDyj6rXTPQdLPLXevfOMami4G1RVeoWae0_gjwwQh04TBg7v8jkQH8aKdpVX57wkRwNyak
 oUiuBdtr3sye.J1cURzI.q2NeqNlupiHTT765szms.HLxuUQ60GMTHUbdLws99LrtWdIHcGFv32u
 JhZbZV0c3YaIPABtH1fx5wdcnvMXfBFjqcOsN1M40GW7hbPQjMZgXv.vf9A0garycUp0f6QBzhxE
 g77noYAZNUQtsrBDk9w_yBJxQJpeXav5AQEquZgG0ckLjle1HJYTaiLzf4XXzI6CpU4VnfGsY1Ck
 7ulqc3YXrIZwnVdsNLGk5o96q.v7xpfWNohdqeuhr.VjbTC0WM1G35.0gNNni.H35lnQLIICC.XN
 seE.JxAHmsT9kEarkGnA9W8D.fm_z7ZWMn8sxrBbhsloZzzYT6Vt0wqke7xTQnx3D15XdEKtRdD2
 FNOIFDeZpNqfQ0JYIjLKuMIELIQyXdoiPpyFaDWXGQYaMXb._liknOjPl3DcWzNuA.NfOCFmlHav
 ZTN38Zbqki9IZZ6uZQKYqH5mejaA_c351AkIJBuBSEv2wAiHM4jjCkYof1IE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:24 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 93195002d59abd5bf2e6730fba371f7f;
          Mon, 16 Dec 2019 22:38:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 22/25] Audit: Include object data for all security modules
Date:   Mon, 16 Dec 2019 14:36:18 -0800
Message-Id: <20191216223621.5127-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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

