Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B2C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C512520873
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BRvlAXyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfFRXHR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:17 -0400
Received: from sonic308-14.consmr.mail.gq1.yahoo.com ([98.137.68.38]:34447
        "EHLO sonic308-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730977AbfFRXHR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899235; bh=RERcXLTyAePTJ8OZWbyIzr5dgnEjvD6VkeohahSK/oE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BRvlAXyKVtybKUty7XxUPepdV2thM3hKpN3vH6fLPEHYaa3uf1LaFQgY5gl1cKUiNVbYy/ytN2W90xiYvGbZ4U8m/Z9O27bQurdQhMEbTJQVU5w+8InPhNm8lXxlF5nMK6XMTbmHEf4ikRpFIiQUesvZG1RdZGrnJy3ehsXSTrafcpG3NoaudjKvUA2PRAhL+scgLwokLAc+H3Ki6lFqHNtUPbBbBbC5YoCGDskDobME+nY9EMqfMavU8a5ozA8FbYCTbFQ2JJIcQxyQZI0eyrH/sbVh1Insf02wPcNf3+vLwx6tOZEsZYX/aVnMQ7tWNDGgcosE0yGIA0827ociEQ==
X-YMail-OSG: FOhaMNoVM1nKy4lMNbU8qs0CJA5ueTQ9wfYxclvxMrZiWktdzZG75xVZv3PIlHt
 ccIg26L5TyZhur1._M_3Szb6DghgxzM5aukGGJcGDBmEnlyYr5EsO4T6FlmFvD1fMTCFHkVkVwh8
 tj4mqf1NHrSIhe85ZUf23R8wH8zqq9PqZ3Uy7E4tOYUIJDHzS8EvFzysE84ywXF37h_zo7ZeI3hg
 dZdJkzFEGy3n_lYDhw8XvZtoXv55pjnORmbNWuA.IqDlvg5W0ufwD35Z44.6z09DzhhZJrIfMSLj
 RrRJcUmRXo30rJiSrJtYEbrA9ioxE2.6RbI5Odp4HeBmc0Ful8YHbAKIVHwgU08PwWt6bUwyZHmI
 axUiS2RsjyH05OCZfEkiUKJ8e9R4a0nAeJfAsIJknz579OUR_8UBpyBkTyxkX.RaRp8AuC4cZppV
 r9MbxB84wtta7O2WVZoE2sffrStgyeyyYJljUZxiGXK6rM3EW96khtFnJPi8TOcUPksNlC1MLgn6
 PSb1tp6UpTsQLLcotzqItM4RrELiCsR9yZbIVstyArZfsthwOKRsxM3AuBMBkQVzP3ukWysKGEFF
 Ok_0OHIN7nSn4V8.9H2UK8MMnoCHSBoiq_fauUC_pPKQKbWGPXRd8bi.A1bNG6t_Qj6dPOmmc122
 66xakLo339tC7CqwYRekcdAsLUprDufPuw4aFi_5UvAQLPuuooYqyW07EXzpQkZlazxfhobZtRwc
 byHnphuKZyR8SsdSkI6erhLP_YmQD1AA6bt6sVAGn1uM1h7L3W_djDJQZXUq5dwD7Gm5YZ8Pnrly
 sOZ.PO7YFy5wBPDBTmG76hCpfXW6I1OlMkeh5xO0aVI5Zsio4SlwJzrkSX3ur689VM8hObAhIZIC
 ewKhjGPxHUt_8bM3E__66HMXXUKgPg2rZKsiUpjSJPBGcLU30O2SfJcAqS4YPShcdOLdfaqakhtR
 kb8svGxfkdcUiNok9l9eIa5FOt7HQa0C9k4fiGeAiBqhSgQl8mKyRL2FPRnTFF8OENyvwrYYgJ3B
 JIjIFp4hjw7yTXb1UpEMPHSYMa_4vnjrVhzqnrWQLG9jsj8ygY8CgiV0hMcz__bSagK5yWuiinO2
 xU_sUBS3JAdckXp.y6TN8kAAWcaZI_z7yVGmkjvM4Jth.IbvwhGzY0eT4B3IegoVej29MkNdo6yB
 VJACMZnqHj5V06xRTgn4qeTlLGR8vBeG24vSx9nGgtVCJQ7IAd1wOLWyRV5FdfZtFVlZVaC7P9Yk
 R15iNm_lh3vtfFWUbvvqXnJjvKBwmH0.fbaj2yw4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:15 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 63d042c01c7ef77757fc0dff1b9276c8;
          Tue, 18 Jun 2019 23:07:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 21/25] Audit: Store LSM audit information in an lsmblob
Date:   Tue, 18 Jun 2019 16:05:47 -0700
Message-Id: <20190618230551.7475-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the audit code to store full lsmblob data instead of
a single u32 secid. This allows for multiple security modules
to use the audit system at the same time. It also allows the
removal of scaffolding code that was included during the
revision of LSM interfaces.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  6 +++---
 kernel/auditsc.c | 38 +++++++++++---------------------------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 29e29c6f4afb..a8dd479e9556 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -91,7 +91,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		olsm;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -148,7 +148,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	struct lsmblob   target_lsm;
+	struct lsmblob	    target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
@@ -165,7 +165,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		olsm;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 847c1d59212d..eb898043031f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -645,17 +645,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsmblob_init(&le, name->osid);
 					result = security_audit_rule_match(
-								&le,
+								&name->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&le, n->osid);
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
-				lsmblob_init(&le, ctx->ipc.osid);
-				if (security_audit_rule_match(&le,
+				if (security_audit_rule_match(&ctx->ipc.olsm,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1186,20 +1183,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsmblob *olsm = &context->ipc.olsm;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsmblob_is_set(olsm)) {
 			struct lsmcontext lsmcxt;
-			struct lsmblob le;
-			lsmblob_init(&le, osid);
-			if (security_secid_to_secctx(&le, &lsmcxt)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_secid_to_secctx(olsm, &lsmcxt))
 				*call_panic = 1;
-			} else {
+			else {
 				audit_log_format(ab, " obj=%s", lsmcxt.context);
 				security_release_secctx(&lsmcxt);
 			}
@@ -1344,13 +1338,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob le;
+	if (lsmblob_is_set(&n->olsm)) {
 		struct lsmcontext lsmctx;
 
-		lsmblob_init(&le, n->osid);
-		if (security_secid_to_secctx(&le, &lsmctx)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->olsm, &lsmctx)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1904,17 +1895,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
-	struct lsmblob le;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &le);
-	/* scaffolding until osid is updated */
-	name->osid = le.secid[1];
+	security_inode_getsecid(inode, &name->olsm);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2264,14 +2251,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &le);
-	/* scaffolding on the [1] - change "osid" to a lsmblob */
-	context->ipc.osid = le.secid[1];
+	security_ipc_getsecid(ipcp, &context->ipc.olsm);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.20.1

