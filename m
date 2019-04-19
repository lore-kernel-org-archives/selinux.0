Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6CBC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4982B21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C7e8wUMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDSArZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:25 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:38868 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbfDSArY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634843; bh=NLJ9WRLN3mqnoEKmIr7GkqEF3TZIbdXheKniGVooL5g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=C7e8wUMaIAeyN6q4BGU93pGTOhTalGoh9uuHdg4zt0cx+4CaEhmZJL6mtv1d1hHrW9uIMT7hQcEFPmtMin/uZQ6Kr8Yit8tAlKt69i4bNdVSNU0EUZhp8f8MH4TidkR/N4+elkSPVVoGKXjKQGffm08H7OjEkuepDW2R1q3RgLVs5fqthdKSGAp102rhOoZSGKDfAO727xdb/IdBqn4/cvx77dDaynj212q3VJYBXXyKJ43ETSpLLrM7QXPb9KhM54leCagCoUylV6PDgJP3fV3c7g5+f3GWqF8KK723rS4At0vgbhN50haWrKIwUCFBkcFdY4+mjZjP9zUZNpSqig==
X-YMail-OSG: zDR9TKgVM1kF0Ol4kQIfT71oMvRFaC.QUs23laOag_i8T8snfVzuoGb6cDH30Hf
 KIGw_2ThFYckaoFttVOC6FbT4A7wmbc7pI6O.5aBpBX8Ek7VA4cXHsZED.WJw1byCyBoB6yRsCEw
 3ea58od0xBbWfueJ_1TTbhjDSCnxMKsr9y7VpTOue8eVTJU9NOgWjkV50cLrHPAiOjI7S5wtUvRs
 FXAImiffhWez0TPhvi.u27cXxNDXocVqssZl2wBzbq2BKfk_8kQmri0tOJ_dj5lriQGwNIPzECHZ
 azREQtM_4uETeXDqj6cFqUBFtoWJKXfMjzgX2oZxU7etyb_rNmwfdAI60CHIoBu5fH_4Z.NmyLxu
 ZYPuJzFv5ags0V2orewBXecbJBrhwjCqbpzYMgbJaUfSEqqaVgh68vKE0TTIQywPTMVbiSTl1FXv
 FJtVtyfEPTAicKRqNz6FnvxiXA2zWQ0touz56zSEEGJ5.cNP0SJDK0v1qmhoroAT4cYjXoKkTg2Z
 RzmVoY53Jgr2uW09DskgPnme9ywFeDS4aJcRO7_kLH7icx5M.cucJ88yQmVIyWyWf4MAY7ZHTbN1
 878j0b3krnxJiHIryFzdHQUJsrLtNM18T3.FZ.K6FQHl7FpOPbXketFNhwc_BlMg5s911u2xEjiQ
 lg0In_up44VVl_OBoT4BNf9Z5MRJLIU73w8CV34zrzP221dl2rUk853eBUq2c2Nr5whQjg7GxEgv
 eVXR9fEDjHjZ.81QvOwYa0wFn8f4fKBatIFSP4ULZDESRq8aA6tiITmp6lgXoHpFYiwOD7BnyBUS
 hi6XOR5SKiRSXLx3LqGHWpJd5VMBbnq75uHYBbBbTGF_FNn68_t3f3nvg1KkMoz26UcbxvBxreFr
 OrK7.7ImfMrTzrSaIK0dja7gjKBKaXbNjy6Swdq_IKkr7s5r3lRvKHaMkklFSXuSdI07hg0u0gvf
 XEIDioYEONhO1gGuypBY8dNDdNAbXG8iii_I4vF94UxkO.qCl0FEk2ueY7fTENrGwn7hQ_sCdbLT
 bH9eN7jtFXduFfPXbosCv72VJP7yGwDx_JuFePHvlFS3wL00GkdkWON7Akw_ZibcWXs8yAadF6c3
 Dc8LJK2Kx3d3a81XeOfXJXg5Nft8mLaaYkH3WK8JB.6_r0dANVdLyn12D3V05avevdJawPD.Mgvy
 5j8Gfx7R.fVNG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d780a730ba98836fa707a31546db6ad;
          Fri, 19 Apr 2019 00:47:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 25/90] Audit: Convert osid to an lsm_export structure
Date:   Thu, 18 Apr 2019 17:45:12 -0700
Message-Id: <20190419004617.64627-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert osid to be an lsm_export structure
instead of a u32 secid. Clean out the associated
scaffolding. Change the name to olsm to be
descriptive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c   |  4 +---
 kernel/audit.h   |  4 ++--
 kernel/auditsc.c | 36 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5226e2af9498..d83d1f05c95d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2073,12 +2073,10 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsm_export le;
 
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &sid);
-	if (!sid)
+	if (!lsm_export_any(&le))
 		return 0;
 
 	error = security_secid_to_secctx(&le, &ctx, &len);
diff --git a/kernel/audit.h b/kernel/audit.h
index e2e6fa911f9c..7d2fcdf0bc94 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -91,7 +91,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsm_export	olsm;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -165,7 +165,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsm_export	olsm;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 75d181029d40..d64775f4bb1b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -645,17 +645,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsm_export_to_all(&le, name->osid);
 					result = security_audit_rule_match(
-								&le,
+								&name->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsm_export_to_all(&le, n->osid);
 						if (security_audit_rule_match(
-								&le,
+								&n->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -667,8 +665,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsm_export_to_all(&le, ctx->ipc.osid);
-				if (security_audit_rule_match(&le,
+				if (security_audit_rule_match(&ctx->ipc.olsm,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1187,19 +1184,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsm_export *l = &context->ipc.olsm;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsm_export_any(l)) {
 			char *ctx = NULL;
 			u32 len;
-			struct lsm_export le;
-			lsm_export_to_all(&le, osid);
-			if (security_secid_to_secctx(&le, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_secid_to_secctx(l, &ctx, &len)) {
+				audit_log_format(ab, " osid=(unknown)");
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1346,14 +1341,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsm_export_any(&n->olsm)) {
 		char *ctx = NULL;
 		u32 len;
-		struct lsm_export le;
 
-		lsm_export_to_all(&le, n->osid);
-		if (security_secid_to_secctx(&le, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->olsm, &ctx, &len)) {
+			audit_log_format(ab, " osid=(unknown)");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1907,16 +1900,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
-	struct lsm_export le;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &le);
-	lsm_export_secid(&le, &name->osid);
+	security_inode_getsecid(inode, &name->olsm);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2266,13 +2256,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsm_export le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &le);
-	lsm_export_secid(&le, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &context->ipc.olsm);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.19.1

