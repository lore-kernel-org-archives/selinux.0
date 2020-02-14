Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C416C3F68F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB8222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RLx+piZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBNXpj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:45:39 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:33804
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728316AbgBNXpi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723936; bh=JSaMrCw5rIOsb/PJrZw0TEWxJjBXsuaEn7uKyAVvJ7M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RLx+piZqTjZmaqa0SKq5x0oDwLKUgvQNYWFXVMoY/PZQLKmMGSs026/rweZFmu5azxzOnhd2fGHpdskg20udkA4hZhssDNkQCU+4oYzNL7BtlRfMJ0w5XdcRjX3Qf6JHyOAVoizuXbMhDhxRzHsqy949CfZ55FKsep8s2Tu3CpeT/J//0WYRlY44yubksroWi3xv6LN2t3kJHQ1qLCVwQsVl3Ua2PPEcUYb/x8QIsCqZ/AV24FW1gGahz38/QahT8GF0rBzYEAR/6ytQqRhuhz/PhKJSnBzAK6XX7RayySJrh25+NvL8rrhffdfQti7XiU2SriMWz6gP27tah7AsQg==
X-YMail-OSG: XJUCSRsVM1kP_jOV_1_9cVy9zgBl6JG.awfK1uulwir_M2ervU_BXEt4Fyn9jr6
 l5AX5v.Cjeu7D5aNiV9FX4IsLm3SOdP_PkIu61x9mQzFupnxebbEuQSr75GNA6hknknx4a_P5UKV
 Nqtbc0MUXrUlHJvZyhtovz20_67oQKRgF9DNZn.xCs7GGLQ5uYYzx_f1HxIq7UmBL8Qi1ss1_SUX
 fDRLSdoOGrva3jp8cPJHejtIiBqF1oNYjYd0fSlibu2pcDTLqxDWuO1p0WdwZ3e3DX71qb9rk_nu
 LwOj3wpTibaksxQGMuZdmlaIgax8.bb3GWUAxbLwLBgh.1IM_Rkhj0fb.hcmNTWBT0wvRZBf37jb
 omxqV7JMG6Ix5RfL_uVaicXReAnSP08BfxemGVlRaiTCBYFB.MMyw719AyhTUqSDpP2copbYGpAB
 2i0D66WdZSoarH0oM5WC3CwevInyRyw.lC2T_2CTAJzazgDeK7s2Rjvv9f5KOpaolaoabwYNroZl
 KxKfKCpgsWTB1xjLYRzZQ31HbOMz7Fb9ZeuWdSMDjuxxqBK4Ww7KJYxqARRF3eCCOu1SztaOJ0sR
 kxKvRx3J.G_jTiPotZfR8mu4pFnZCOCCvgd7rQQ801YyZLGMLLwYlQx0SE1NpIieEwPe1jZDo5OU
 hmY8pYBD5VIY5vIvblJghavjtG.GoqR8i5R5fraCPjYA2tF0h.Wa8zIgOSpAv0jg3HlA9Lx9WmlY
 yjl8s7qIqv0GuAeOfNtHh1TejHvfiYZkNonhBz4NRTChyrtGyjXF_mZVYqIWK08X87u6FvJt58Av
 ZrxrNAMFvhTVI_H78Wfd8jZPajyd40bn.5HA.ED4cQXWcXU_49QJ_UryXmrWy8pMuSkjJ5i74wVY
 K3PH099o6AltJaD6WzA1M_mPSxNqTUOOizB4eW9uWWBiWplMEQPyQks2NyqRrTLpYgGHd5eztPjl
 Ri4.ZPK87Tgl0h6wyZRbTkGakyKJhMLRhX3eTEYoAAAHM5_UMrDyffiLgKjAbKsmYF2Bs7mngr3K
 ._faAz_R9ooZO1Z1xlynmNACuYCxjSSayBYA.S4nEenndn_ykbSEWiOMC3tmfoc7sxrBGudFkLNE
 9dvSbtfWhr1Zyn640o2oEseKTkIScW1Na559YKJ4ZYDT_tZ95zHWXVdSizUAo0A_dXPT9byItZ3E
 0bOa_piuYN8J9NStJCnG.lwil7asqHDAwZQfWe1kOVpDHqe3uU2MhpxjGn59i_nf74e1hhNIl9b4
 QsFfrsC3gnFwpqjQhEvdL6y6K9jedFKKe2O3umQaD4ytMeHGIpdbdzGF4GSCUINZs.Ge6Fo4Qp.H
 Ogsolv4QCTJcGyYTKhbJGgP6bjPxd0iQe8tgIRbtRt9okamBgAxoQi_Clbdn4nAZLDFg2Pf4HmJU
 FrmsLrj15uPFPYMeDKmXV4joEfBdoszKT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:45:36 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ce63e428e13fa705f0ae101fe46b87ce;
          Fri, 14 Feb 2020 23:45:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 21/23] Audit: Include object data for all security modules
Date:   Fri, 14 Feb 2020 15:42:01 -0800
Message-Id: <20200214234203.7086-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc:linux-audit@redhat.com
---
 kernel/audit.h   |   4 +-
 kernel/auditsc.c | 106 ++++++++++++++++++++++++-----------------------
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index f65f516913c6..9a26ba213f6a 100644
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
index 68ae5fa843c1..7dab48661e31 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -659,7 +659,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
 								&blob,
 								f->type,
@@ -667,7 +666,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -681,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
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
2.24.1

