Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDEFC48BDB
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33A120663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m+cKeCQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFZTXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:25 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:37670
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfFZTXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561577002; bh=ANE0Xaj0gkvTfYna4Owf4j3msmctCEHRk7H5VSxz8hU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=m+cKeCQFgwu0e6bKu0WFMMffvIdppmHs/Bi/zrDhKpw6VIq9EsAUDLt/FFCvGnRY8Z58VgmAPv3QDaDBTn2N02lOuf4OWDfigg00GSebGRnuqg91TeWuVkpV9EMp0YgnE5F0nwUXoFWr5ly3kmLhQG442FBWJz62GmFd3C6OrNUUAKUvIcLvcOWtUscL5z/7rYjVidLfXZPPWQLc1pSTarTzBUQUqcj3znuCJ6IezgJKXAfTxlUGKVL4rQJJ3FbCNiSVJ3wxm5vMg6xFMG3u9iYS7inOrF8xsSLkfGxc5Pv6AAlpdIAHbgyrp4mhq+VdeDxBMr6R90ZTL8hZhBtp6g==
X-YMail-OSG: T585WWsVM1n_eB.R8mfn3Kh65wjI08B2tlwuUHahmijVNAa2aWWYSDZh.JWCSjY
 cWOeDV8rksVBFzh9ONrkyrBWmQ.q8txe0Pui5Rjvl5yG5UxrHVziyKzHAL3V.3v8QkZYnK5lvLlM
 ZxsNkgExukUYc.9M2N7ltbuRugT.KdL5o66ptWMT.8p6tLxhMzA8I_Pk2YLjEIcz7nm4YxjmVtFI
 TaMHX4ckdNyaRxacStNOFtJnEugOtGroUlJM0_nW0.LONg3CAdgajzsmX._wJxaon8hVVVWxe_Rt
 HLIUf9iU.t6Lsp97zJF5B8m2.avmSC1ic1mucWoEJi_q3Jkd7r2rSVlF016URQEPl2f1Nsj3ziQM
 DeStBMehf2QWZP_cP071Oxa2ERzKZKOF.i2ak9n4hjG7AF1EYCObQOT0EZd59DmzzvedgaotBCyF
 3i7Su4UMMkR5ykXHDuvn7wNXCj9_dCr4Q2PGLoSSSxEW_eoM_787vMKJWYBZsk9Vk3BUsD4pcPRa
 9vnfZxqaXD22XVO4bIElWhnWXIRXg70IHig3CwVuggOh7iTdk9v63iYjoB9tJlT5PSeV0Z52z8jj
 mpm2MrcYrY48.Q7uVEgc5LaaKlmRztCRAABCvm7IVNrJTtYl4R1QTQjL8CID6OkHss8s1QWsZCyA
 iS6ol0Nihg1HLKWd0En0qcgqvDfqT68anPJwji3.me98kMyLtUGpqunCnTwSFm8XVI4_wr7yNVle
 QZHbRhCEKn1hiXBXqj0rExha15eG5nqYV6tM.ICM5hs0QhqaIyohKeI2iM42w3Ub.5XP2SUb0yJ2
 q5z6iebEztz6Pff.OsuPJ_eF.XbVE1Mi_C3DUQl4BNWM2XHGJEPjt6HVQyF70sYBX2FqPNh8A1PM
 c5s2McqsY2o1ZQLwsCdScnAFkHmz5lJHP6OmR3YkuTAj0jotttI345WESk7FOjn9qxBFqK23sWhZ
 qDUbdEKmAb9F354N2gURclKbr.8pnmWf6OA5Hv_0cxB91LcncHxtY_zxHjYn8.QLWMZDUppeGPce
 YLta.j3x2xHU6J68NBSEU490STJWvQB4FSm.dkRZZWT58RNjppJ8_X9.SL41nVIkHF1nKpBxxAby
 6FiJ7G7rf3fFlyHNaHfG11VWzd78hbsJA.pQjNGC42UGYCohEtaH9HSLFOUp.dbc_1mrL5wyswf.
 k.4J5PFxxbSBPQXoUVvI6I3hrKYSAmbP1290b0h6PJZV2.xrap9LLw3iB5cvhMxznHZHEUJ9Xlc.
 V4VECfKh3An7mf8VBL_m_K3qNH8SarVzrQtP4a9on9oU1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:23:22 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7fc532bf6bcf33ac8b649a0abf15fbe8;
          Wed, 26 Jun 2019 19:23:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 21/23] Audit: Store LSM audit information in an lsmblob
Date:   Wed, 26 Jun 2019 12:22:32 -0700
Message-Id: <20190626192234.11725-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c | 40 +++++++++++++---------------------------
 2 files changed, 16 insertions(+), 30 deletions(-)

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
index 0478680cd0a8..ec8872430fb6 100644
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
@@ -955,7 +952,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
 		if (security_secid_to_secctx(blob, &lsmctx)) {
-			audit_log_format(ab, " obj=(none)");
+			audit_log_format(ab, " obj=?");
 			rc = 1;
 		} else {
 			audit_log_format(ab, " obj=%s", lsmctx.context);
@@ -1187,19 +1184,17 @@ static void show_special(struct audit_context *context, int *call_panic)
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
+			if (security_secid_to_secctx(olsm, &lsmcxt)) {
+				audit_log_format(ab, " obj=?");
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", lsmcxt.context);
@@ -1346,13 +1341,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
+			audit_log_format(ab, " obj=?");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1906,17 +1899,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
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
@@ -2266,14 +2255,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

