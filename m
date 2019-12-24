Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E780C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4C6206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QqMCXjc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXXW7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:22:59 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:41748
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLXXW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229777; bh=AqABZKrHoJ2O/YxWBBlyrWT0dGVssWeBH837HbXrHjo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QqMCXjc5yr6g0ccCvm/+uUq55lDOlY7pFuVKWhS0DZcf9HdXAeOPsb21WzX1korBSVt8ar6g5RRcCkNMYk675pP2oh2bqzke44Q8IN3w3wDX1PDbW1AxEKw5YpdU8ZnzvuSrv5J3etk625+AdgLHSa7qn2kyaNBhlp35UepenkTBgQz7X2WXRubzlW33K5nwYds7+yjJZ5N0UquSLhK5x8l4VohGIp88m/bYy+YLgULMP+gCrbhl68KGhxWYx06PvTR7FjDhaXmZWfmLJyw/Qc23gKsI8dmz1Fm7Ge1B0FUgmj/Y2r4Z/BJj8SDBjrjMPN/mj/qAtrbSjd4G0/Erxw==
X-YMail-OSG: sQN1Mw8VM1lyOiPgc4sbjfluUv.E.rYAUCX0FvLQnePTgHmvyYgYNW2.d8zmj5H
 tO6zZmQQbpJ3Z6GGRGg_UkKbBIUtlWlW9YyzhQRpmDckZ1PMddUjK2zlltSzGyPTAugAcHWasW7q
 on_gCaqbs5uxFaZWMd1hezQp.awsi7raAsFBwM16h3YgBinQDuhTDjKYIdHo4HiL6XEWpzgpk4hY
 v3N3zQU19xZ4vGy5tacf9vMgPZLP.Bpi8U81JsCsnpf_fAAtzIS_LIsM9bt_Kx0sk8OEFA.kLbrw
 hcKor1K1HXN1Tc4C4ycyLODv8pnKa3EAkB8YZd6j4DWI3Dzfumf8zanDegFBUiGJA2q9Z438IMjg
 xEyQRYg2kDrS2kh3Y.K_cbuDGAFjHCFbLyOeLmIlkndvtK12Y7e_fNyBC1_1PwZCWqoHVd3lkaYb
 g_deSVu_n9wwi5TpU91CFQiyr55vEoYSv7On7wKhU.ME1aEyNe2CKxRUagxx6eIGLVGCwSleALS3
 iTLeN6akVV11k2jdFt7JZn6Ns31O1z2GCstKdPpiygfZ8z9i7mmb3DXUWaKsEWKqRePJ4rHclfRG
 GHtNGV4SXSeho_z8BWTMbMApqPKJ6UU0W7K5ay3U2xUHPFrSMiRT526Xep6J91GNWZJQQCPtaqs1
 tPVDurBqEBZ9iIkdyYSrLSD8ZEgx8V4QHQgQHjW0bB12LNok9.HqB.PeamYVTYft30h..Mu2L8Wc
 Iw1lnSL3k8xddkCEklLIGJ_f83a6FuembgwsKoYmI7Bf8FD9YtWsW76SLGnkW1zTiEDLcqqRirri
 9psvoKUCO5dkHylrWFJ.jQyJAtU5cAPJRfCJCpuCULOn7OXSiyxf7nZi22k.pRsaqWFhCizyJ7Dw
 f2dxG76A2nFSHTTm5Bcpqi0tcKU2dgGMK1yggapYCAQ6pqvifZCHn7aLl_TmEyWh2lj1MUMukokb
 RzfNYUl5Gq1TUuT3V0eIZCg9ts5iYQkpqc2LR4qk5LuQduLWswQhP9x4BKo0WZPSbgAIRKm6.s9y
 a7e_1D9uNS4YjtRhZXuHQuc0TQBhsnfkFP3zJ9TRDTlR2wl.Y6MgWL1aVvp0A3EuTP2Z2ycaNnIp
 8gJ04_oElYMpAmibphz2Uz9KHXjeKknZSRiOeTi0stvGDLX2BEVqxDdevq1vuDWJ1ywx3ivHStWU
 4.Mv9m3T.xu.1jbXtBpK_EAsEkLewhtsXqm6ySUFakOpru3hLftnfNFup3M.oI6ciP_XGR.3ajmP
 77QdvImokD2L7SyQ8Ww78F4S_VnrTXAKggI5yfT0svccELFQJloiH7Z6IT_6p.FXeZQNvv8r5p2W
 prdF3GVEM_6FOx7V5tNjSk2kkr8l4XyCxSovSQm4CNJvyAjz_c0pF6RMZtq8nYjOBhxkaGIStW79
 sJI6xyKGA0P106Vlb6ok5Bz.gr3AzUXEMaQgjHg.4x1qY0rFz0rTRUsJxcvzlituJng--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:22:57 +0000
Received: by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 319daea56c06f408287f535497dabd6a;
          Tue, 24 Dec 2019 23:22:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 22/25] Audit: Include object data for all security modules
Date:   Tue, 24 Dec 2019 15:19:12 -0800
Message-Id: <20191224231915.7208-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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

