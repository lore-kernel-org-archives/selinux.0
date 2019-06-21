Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3697EC43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECE8208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MHkp/HBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFUSx1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:27 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:34768
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbfFUSx1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143205; bh=agqOqqdlq1wMKaoQmQ4HlWS5nJTTtu13BMy5NKF/XwA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MHkp/HBy0vEk//kygRwJPqzdAOkCxQoPniFx49NbVDRwzWhoAeTnzJmdwuW/C7rq4PrqEstzQWPiGarzy/k6Or7oJirlBv3ExHMLWQ4nrI9ScG2aRtWXsSu2ZqqK3sC9R2604Uo2iTsom5lrI9vvZGwTUaUKCY6elwzgqKCM4vZfZlrUW6Y0nnaQu2X3BTk8XaKOKR4kdsE7XEaxcOcv0TqsVEdY/X6+primQEx9Eh/iq8qA4yrFz7mhMbEfeIMkJt3hVKnaoSSeDeHV1SCL+29b3MPzLDmPrCU/FRp1CSk8S1w2rZkfv60KvuDwPyzSrngjOiHMJ5o0RO1nSdLwPA==
X-YMail-OSG: .4nEYKIVM1kNQzcofQAulzSw_KVbXU7TtpiDrS4eURQDSFucHGvhXUQbePHVG3r
 TH4mvSmRohd65LBe2my.y4l3g9Ukw7up6.mP7VwXC96hrJs.mbzQC4ZX5ZzDNpA08fyeGhNgIQ8V
 DvMy9OhOUR2I4DFYkQmMJgr5JHFdtjX8rT8foh_A914XZ95WRcWy9NqyJ4YrgoOi8abz7x2Mx99C
 oaWczOnFY9odZo6PZQlI7sujDFtqxmX2IZCOtRMzrAI4zSf5ZKGw6jQw9oCKOB3K2Yhg.EY_zHUe
 97192eHtPhrdwh69avpYUuq7h9UHVYWPOhoeW.6kMpIZNLvJwPcsk74G_1a_qNG11PMkAepeSiWP
 cE.PQa0zG0YmZ9Mp932fLczdrlR152OJpV5kGAfv07heBMxQndxvK_yPL174uImRWNlzS2n26yU3
 CI7WkU6542JeO.qO4CrLhoyBHjyTLB8oR_cmgATkqfiDc.R.h.SOp0wmPLP0F83B456zoABBELf.
 .np7IwYhy7EJKEo4N0YcsGB5xrjDFzVmUxKWX2wIKhkQVXbAGl8xWnO4m0QBJ6kYdAWnH89U4wAF
 6JoLq.kuvoES4ojdv0CeNu1ePGLIbNEjkWwAUwQlYOlvEfgdp.I2lrydpjXnVp0q7aAMtY1DoVCc
 5Bzwibg.ahLpPqXAiGzsIwaPv5NCzoKkWPEgnvaYYupw3nxuZ01j7zacLRShk9v0nulPZowC4B4Q
 DbP2hbsALmGgmUvaiAknVWl6BsJeQDlo40I2L44B_7a3SAUE_5WQWlF_W4OwiZlC9lDlLQGlXiEj
 cvt1ZcsO_c0Mb.PFKVqS6uoG4l75CtiS_pfIiSAH8KNJ.5LfvtnZPKKwcxQZO172Uj1srck76WWG
 I6THxBZ3PQw3EFOqGl08yh35GfC.vt.l3cO6jSVEiO.hgpzXsKMnYvtmhQvzV50srWisL9cM_Xnc
 eed6RcYgDzcrFWCXt4T23hgzOrRA5SUIjpcsV0QtuhWU4jbaNMdBudloxmjsbkqYCRGHgp0jWXFy
 JPyMdlnEoA19OJB3OQfq2fLFL2KuFR_NST_7w2L1sO1h0HZ3gJJTcmujovQBhwSM05Wzref6qWwQ
 esdMQhl6WE7V1xy8.vNxL8s_DlEUrEeYgeGjWgv7rY89lrGeJGKsbv7tXlFfS68BU0RvBik40FjX
 WqAMCkc3NNqstjQtWiXHxs6CyeDNlCBjG1mbI0BzAvRHGlGELx.uHT2Lcuv7xAkbBh5B6MALYQJs
 4cfAYWkzdmCugXfJOQbLTB5_.sTIL9Yh1v0hRwwYd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0eb7bde0fe71be6c1c6028ab1630b25e;
          Fri, 21 Jun 2019 18:53:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
Date:   Fri, 21 Jun 2019 11:52:30 -0700
Message-Id: <20190621185233.6766-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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
index 0478680cd0a8..d3ad13f11788 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -646,17 +646,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								&blob,
+								&n->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -668,8 +666,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.olsm,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1187,21 +1184,18 @@ static void show_special(struct audit_context *context, int *call_panic)
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
-			struct lsmblob blob;
 
-			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_secid_to_secctx(olsm, &lsmcxt))
 				*call_panic = 1;
-			} else {
+			else {
 				audit_log_format(ab, " obj=%s", lsmcxt.context);
 				security_release_secctx(&lsmcxt);
 			}
@@ -1346,13 +1340,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
+	if (lsmblob_is_set(&n->olsm)) {
 		struct lsmcontext lsmctx;
 
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->olsm, &lsmctx)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1906,17 +1897,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
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
+	security_inode_getsecid(inode, &name->olsm);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2266,14 +2253,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
+	security_ipc_getsecid(ipcp, &context->ipc.olsm);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.20.1

