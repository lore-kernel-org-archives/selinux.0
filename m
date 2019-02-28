Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7465C10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC2B2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hKBAstce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfB1WUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:12 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:43928
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729826AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392405; bh=NuwxabuwXKPQuPkTBG+ktKnf+vpaEZcwOMco3zy0Pd0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hKBAstceQ1z1Q13DGDzgcTSr8enZjFe2KPUsm/Hr0Pvs6/j/Qal4nmS6iwB0Z/+fxzN5Pn/rNT+PPMnXentJiSSMYvFrnPryGQZaJz+MotzjTY7bvTE6/tzOfVFKV9IWWWNMuru1hAI9OWO+plV+A+HxoRr0kRY5Vegk3RBqqg+tpPsRKyUQQF7y8aL9u1y4f7KzMmx5gUhUpV1b2S6yLcqldYoCuyjtR7WgAnT5ypnnx3btv8yCXKR5+WrtLbHgy8KadzWJQ+DM3S3s1xLb+jwFdK3nflHdvcujAg0FR0dZSbTaj+0eGQqrg1y2FiaP35pvYRXyEVO0s/lmsAkHjA==
X-YMail-OSG: lhaSxwEVM1kjaXcjn3aTuaZQDVDL.PVWeIbvDR5Hfbdj1OOBFL50PrbwGAwRBDv
 cBh4YoyryfDqajbYJhKkPSSScNRkGxb6Lkj.jqnle0ANVWB0BUOor57QI2GAMug4ZQ3EmLbasDWD
 u2QvNZ.2LydFHLoqmZdBpp3wngX.N9U.VKT4yM52O5rCAghbYF5Ajd5mkzfTkibDiozURCNyqy4J
 UQrnWGDeUrcRVTyEAkI9fB6OK1nAbOXqLv9JKsm4sk5RcLcbkVwY85Xdnk9yhJSdkyI.us1.kUil
 hZd3nYM5yhPcYAcu4glNL9Od0Us50YzQliYfT3SnhdhV9m2Xm_3AOVmiM9VeE0irU0NFnEClvD5L
 MmtrTFE8e4tY6kt3DCUXwqfpKC0So6qzbKmf_HPxISpDKWn5fXkl0Q7aqGFfpICi8Ha1YssJnVVY
 ln690zMXX1ZBGfzFj3zHmsmCZaNK2w9zJge.4VvztQik0tSob8MRXlIKCNKu3PVKkjtAsAjVLB8L
 jXgswPKCeAuRjS5DNttkIh.nHgGLcuLOQhr.T4WLBvsUDd_yatcUG883ibOI52R9_miDk4zuVPAn
 BeZQSrjsqJyyQ5DRbmRQz8RjgH8LfJ4ly5onz7bSqGoxOM8KjKzp0Qfzf4Q1iknCD5rAHSPPk32d
 2SVcpdEc65r5ujZd0GfxCYS95EwH9SK2ecKbqvICagwz_xnRhv_4VCRmDUYa3I38XhGWmDILlS8d
 I7XQ4jaMAi25xgtgVq0ZfWcfMINlBxNrNwpLZIa8iTxXAMuSLdyGammWqoG4C.xsNkQyvoe.gSde
 z6xTRn.a1vyh41j9aGpjwpoX7xu7E6tyl.Qu5llOZXgtr4fyv.n8UVkASaSMAFFM99LtDiH8Ixae
 GXJb6CT8SJzpMc2TcQEeu0K8iZ4kVbsPasPxrquyN_9RfAh.RAjI0B7F.IJlS5B.zN3mrxJFPLKv
 aSzBI0G02ADhAadNM4SB6N0CWBAjyuhQm0sA2VOe3fbipfsErNiDdTk08O2gWS7teCXhZmtP2JVp
 eCwrkDXqg38S2VUNkoCVa0bwaSi.GsAz612ca6fd7qDCcU4zwHFuY4H57egEDeU1hJhcuBnSWdzt
 j5mNY5mV2SM7eHxtOxAVZCscYE2K8mwrZuLH5GuTQY2950Pih
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 31/97] Audit: Convert osid to an lsm_export structure
Date:   Thu, 28 Feb 2019 14:18:27 -0800
Message-Id: <20190228221933.2551-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
 kernel/audit.c   | 17 +++++------------
 kernel/audit.h   |  4 ++--
 kernel/auditsc.c | 23 ++++++++---------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f89fc60b34d3..8f76f164d2af 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2102,16 +2102,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode)
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
 	audit_copy_fcaps(name, dentry);
 }
 
@@ -2168,14 +2165,12 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2212,12 +2207,10 @@ int audit_log_task_context(struct audit_buffer *ab)
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
index 63883a773aa2..7bcabad8104c 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -90,7 +90,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsm_export	olsm;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -164,7 +164,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsm_export	olsm;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2ee74d18c90c..090f9f2cb571 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -646,14 +646,12 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsm_export_to_all(&le, name->osid);
 					result = security_audit_rule_match(
-					           &le, f->type, f->op,
+					           &name->olsm, f->type, f->op,
 					           f->lsm_rule, ctx);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsm_export_to_all(&le, n->osid);
-						if (security_audit_rule_match(&le, f->type,
+						if (security_audit_rule_match(&n->olsm, f->type,
 									      f->op, f->lsm_rule,
 									      ctx)) {
 							++result;
@@ -664,8 +662,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsm_export_to_all(&le, ctx->ipc.osid);
-				if (security_audit_rule_match(&le,
+				if (security_audit_rule_match(&ctx->ipc.olsm,
 							      f->type, f->op,
 							      f->lsm_rule, ctx))
 					++result;
@@ -1158,19 +1155,17 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -2163,13 +2158,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
2.17.0

