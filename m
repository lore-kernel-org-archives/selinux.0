Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA42C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC12794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QQZcn3HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFBQwk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:40 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:41461
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbfFBQwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494359; bh=NLJ9WRLN3mqnoEKmIr7GkqEF3TZIbdXheKniGVooL5g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QQZcn3HIGH5lFNHVaJbpPUXuG0TQA7F+B9BZ76foR43HrSPC56vqV99T1SkyBY36ZXQmT8sBa9t7SnBdxbfrpmRwUX1BI/spfBjDsiHy1xhwXn2507GQQ0kXvqVTYMw3cdHiwELAYuqUn2hH5X7rALL1m9XSuN4Yna1LfThDqARI8qsMN4Uhp9R2c1vFRQIgft5RYTgMaSuHp/QtlHz6VY4Z8ARiLqdO1hkpSvMSRqXVbE1AVcWV9oD7db884A8SdH0oJXFshgMBBGM0nmHQ1qOwvNfE8y+GeTO5MqyGUNIQqMcCcW8v1jOsA26ocHLiAl4C8UsPzoj9z49H0cEaHg==
X-YMail-OSG: CpKt2wkVM1nrbhXJGB2wnN0Qx61d.8PepWm7vcHViKGjHllzt4RV0mtjy5IuXm4
 _oegOQeJJFLV7tqgIeIxSu7v2DObW5lvP.xUB1Cyr3limKnZ9Ww_UafhFsTj7lICvaPDCgmsyT_O
 cO5B1uk1n7bYOZbPmIF4glArBaYfzw2H5rXYLvwCD.zDPDxFh6eXUoG0mHelHbnLTDX_LbTmoTh5
 2OLla1XzJBcS9l2.Y4T94Nz1o91NlWHCUdpN_PPoGbwuHRmH281JVeWj.YiFY51hQfquMmcZy6Tt
 iBfGCYitHTWP0R8QZbBE8RjBNh35dSv5M1x_yZqlMtAnbUUbW8anbh6GKonvGUgFeFBaDwXPZejg
 Naxf7doglk0uGdx_Ss2SQGCiD5YbPhjWvVbx4v0dVoFn8wrk8HcUIdK.qXK4tqOAwv5laJlzn2rH
 QovOLemFm3tqzIZwkKMb0tgexglCjsPMy2HMRt9wzn_5SpGYZBeFBa5PMBmolTMmdj1yUu1KmQeU
 fHprDCCUVYKoZyVe8YV8VhoUIK.gJP4LWQJxJQ0IwFQFoH4Kil1ybijtpk9AlknIAw7CQ3v0yZ1Z
 .DP_Si0Lb14Qz4OcC9caOct0jZL6c021hmJiP0JGd.P_1H_NT.IvjWn0viu4g1BSGhwrxf9fJ0xr
 6jN0xeTumc4IgVVB74Dp8xcPrOnanebSo9wkQ.x1QiikjlOa4dWdhC_IKtZ6OW_DANLZs9jUbWJH
 XKttAvt2G8Ua_UuBccTawpbem3H29n.3p1toxbQVUcECefjtK6E1RxDXMAPPqot.vs76RSNmMkYA
 jQOwVEAMGgAUX6EAv1qy1zqlsZevT8TGxOE_eDQwLGrZ9wQjJfCANsNV1mPZJUcPDGI8geTFzDw7
 ekg9oc1B0G6c1XhW3N_B_W_lb4ZClHxgp9El4DYmcLYYNRJPVJGnme5D0ZJXdn3R1wAlP11ZZslk
 A4JenZT.pIJZFK.rkNyRscEUv25KInP3P2RWuKgA1ojfYH2XRIdrsTCRTUGWFGjLC9WlKTuqdRxm
 Gl8mf3vshdzfBnjZ.tIX_njSfIb.5HYqmc1l9Lvau3Mqtkqqi7p0MAIs98CYq51yymJJHj4PzeOh
 pOJ7pdWriSKeRbubZ4c56RyjCsasj6XimWy736eUz2pX2G7BnwVsn6oIQG6fU6YxBQ2n8KmeslxM
 hTB0ZHL.LkIzX.w3DQUNqDkwGz.q6ZjDzsoeAyFlUL85itm7gCka4rB2plRuv1O2BRoHt1h8HqcR
 ji_4wul9DyBtXnWnNO6o49vGtORArHzgH9g49di_a7PFSj55BgHA8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:39 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 225d748664d0767f72d028f09ace7268;
          Sun, 02 Jun 2019 16:52:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 24/58] Audit: Convert osid to an lsm_export structure
Date:   Sun,  2 Jun 2019 09:50:27 -0700
Message-Id: <20190602165101.25079-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

