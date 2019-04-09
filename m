Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0273BC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00B32084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QUl8EYMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDIUA1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:27 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:44129
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbfDIUAZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840023; bh=NLJ9WRLN3mqnoEKmIr7GkqEF3TZIbdXheKniGVooL5g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QUl8EYMxfMvLwZlmuD8nopFEW51VbXHSFkIzF4Wjr3nOsICYGbjubl1Vi/N/iXetzUVHUH0cAqqNbaasjYR7aU54iM9mG8rkgAhOmK3mH6P35xUqefR7KVNMIAXuU7hxVXMImLkeIYB9FdjDCafW+WN9mLXW8AEcmh19fJiAS6u6hEsh3wAjD38oSZKFlzuwxIPNRZxbpWEZxsJ9Rrl3PnJWUH217fVni37+xg5PYinanuMRYd8WYazgvhYZ7OzvKQNw7zXFLeSUCTifn+fX3C0r0JqFV4j8BeIkJ0XusMkwyFJSS6DnM7HtpI21MTZaFV8OAyL687mPNw+kbYISfg==
X-YMail-OSG: GYUBOSkVM1mmKo3bL7G5bbSK7MOhMMpBWOQwTWudJYcKv5AaVGn0KXWYoHOvSGr
 9zAU_PMN0bs9kjQxoSQzYiKP7AfGmy.lUff_2cFW1iEKnFcX0IA97N.5WrotqcQhBVzFiaTp0aDR
 Rj8YNp9GB.7Wrc_lYs4J9v7FaINX3DUMDmzHGw1VEg0FVPWG2ra6MgFC9QwyNESdmZFgFTAeWvL7
 V_kLHzOr1IkxXWNK6tBe2L.mr5NoegHULOc2xpZWuO_7OtPW7w7KBEkL1RR2Z4fqQeNhM9LDelpO
 tZ.ZNbmjg2H.qLDpItoXhHyDUTtt_CptifjSz6f4lfBD1cHDxHqPEQvcEJJd_atXnN37Hydnku0m
 UIhb5F32n8BumPm8c8zKKUEC5LR5KtuSVP9j.lhZkujB_di_6OCb_zD5OKt_hjJz8GB.2THNdnFd
 l8RXQ1kKqLJLxLzgnKkxxpxTVFwJnJiINtQgoAWok_WdoG8bqki74a9jEJ5JrjEr9AcWdAN8jjiP
 v.SVG1r6leTMCEQie8B0Hyc9Ir.4VsYEFd_RlTZAi_kIqH1qhYzhUvGoXYN2dtnlLTGc7UT9uVXp
 VL8FkOAYee50lfAgDYjp681nuYD.vBhJiPlLqFi1LPaj8AdUqM6ZtXLsjr3Zrd1.5iIz8SGVv4yI
 50GXTDnyJMvRQVyw19pRiJFm5dr5XZChGuCZgGV6_jeWfNhYYNiT2Knj6GuWwRF.62hoSF2aGvPv
 3gLmR.EBcq8QN4sq1oKxQcVYNSJB9c1EXUGePjMf5oGlTk4XDU7F0jAkMD9OjWb1NKiX56SZbZxj
 erFpciloalJ.hacCyX8nYNxNhNhht5eViQ_EIkmtvyUdphPyJprVEYu5EWbVdJbVDZne1sPrAydT
 pRUOcLd4iiACbfENSq8YlSaAywL8FPR3_vpuGO7FcU9f8E91jgEGeX9ewX_7laV3g33kfUq27FVx
 c1bCxF3rmYR0DVZok40C66QmgZZsazDdLGbLQwSSA90_Bo_gq28SCVj3RbokZhRM6YQc0SRkAjME
 sPGbPgrPTltjMgT7r7W4zZu_H98K9ZOMTyUYgEKcHUlSgV1.KqhgsxRoYEp8UvHxx.QxzhU6ODdi
 N_3Cl90i0ZijBfvrk9e_nyI5HmeAbWwZ0QPgKx3mtU0QHO3pIHdWAeWM9rl5o
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 25/59] Audit: Convert osid to an lsm_export structure
Date:   Tue,  9 Apr 2019 12:58:50 -0700
Message-Id: <20190409195924.1509-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

