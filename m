Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47922C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E702084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WYA2au8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDITTV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:21 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:35369
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbfDITTP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=NLJ9WRLN3mqnoEKmIr7GkqEF3TZIbdXheKniGVooL5g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WYA2au8L2/MMz/JEEcHXhdL3TpapnhpuigtszhArGDU5DqG77DhGDqkX3A6FxztxRG/cDpNs4XJpY/eS94mMAJZMhR1qK2l2kakWrarQlrNRmgzElu1BhMGDhGFmEx3fGz2N7aaicvd7HQCacoYHuuTgxKBfgdkhmvRwmU4l77+8GLRT6ZaYQNp4XR3xoAW7gBMxB1l2Jgmrvme1RisdMv2cKFuTkiuCrf0MZdK1+X/fkCw/CA+FzSvW8ySj+JZULc+L8hvDIliienk3J1A0M+JwfZRuQS4wD75KfJl4iYYfMdxKsTZz0/XEill3NXY/912cfaUa/Yja9urwQ5PJBg==
X-YMail-OSG: cfnj6X8VM1kb3wQbYs7gDyvCI2920QK2cXNFRqq1o4kgy27WQy3h3TvZEAN6nHQ
 rwYnQVLHZh8Bt2.dcZvOCJus_wWBzTKrDpoL0cXgxkaFa4b2h_YQGL00VC.2GW_EVspzf5DCLdhP
 HbWPAGdJRrodVNX7ebAJKcNeOrk8LW4LS919T9hiFSlD5nfB78CHqlqR7r1JWVqbrZxo6r72MDv_
 4rAPxtqYHevC.bhhG64qOFQeYTIIbrDK3E6xwj3j_nkjC.iCKZIwB6eCff5AsKh3l2lQoPCfvppa
 8FFjCHLMCeMK1kuYhcG59EyZkqhtSid.E4Y48HpvC4JeS.q6473WRlevtVb1MMydfBPaj5fsHPvQ
 3J0w55hw6Z22UicahmLOXYKmcFj9WSALWocc7Nri1Cw7Uvi4SJt3RMqSYeqtQHevdsr.FrdHjWfT
 5wMnA2SZO33OJv3EmIsYg8ol8exUsqNNmWFLxePisn08ggC00a7FxZ86.XEBVSsoQnLYhHOhimWU
 8n3JdMgESisHH1p0lOS0jnn0Suvh7k4J0WI0Nn0b9EP5b49QNxp7Qufgv8ydbz5v4MpVv73.CtcO
 fhte3dpDjC8ePjMYMt7omE4K_28tuiSH.iIGUsU78kR62pTWWNXURxN32xPY5ibd7m5H4kgkGMMI
 Pi8mNTmcR7sHAyOpAm4sDDW1g4aaaKUF0zadfh81PnJBN94ubMFVBhVUjixj9ulVlJePJeZxlPTX
 .sFUIRpv70xC2Pqixxoi6_RhNc2sJQFx2TZcWxbIHbYUfSUBA2IVyzHroYIR2V4VhwsFNr00VcHZ
 GjxA08dwFYw7wASFmCXicJ73vsrDB3rxgkZ3bteKW0PZIZSiocjLy1vRzb8BGCHnCBw1idaZ1lmW
 bwBfEuiU7PTjbVihgWfdXwU0yrYrJMNT0KMSyle2i5E4Up8xS5gH0quE70cWrStTPVWr1Wv1F464
 Imt0mR1gt3KURmO5EHP8.eHXjC_gpFVOrsxlMO1nbZbxx1Kkc1m2Rvgs0f48Da01EX0gNNK9z7mw
 adi.z9_pONHcr_UoRW2XBlif5VjtyzgSVVJX4JHrTpEWaeRGI5Nwc2wHnl12C59QDM.1jp.M7zP8
 D53IaXlCYbVeWNl28zfzwFHa9xCmfXwiDrh36K89h01ENIJtB3TL6ug--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 25/59] Audit: Convert osid to an lsm_export structure
Date:   Tue,  9 Apr 2019 12:18:14 -0700
Message-Id: <20190409191848.1380-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

