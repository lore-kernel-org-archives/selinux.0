Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C99C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AEF206DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DTjuu5Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgGIAlB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:41:01 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:46683
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgGIAlA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594255258; bh=5IeZgTmQGZV6VOs+MT2Nv+RZfslgp65Z5XUxf8Ma5CE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DTjuu5JqBXpmMqDR6QOpYcPgQi8AkIcwpgCgKjK6FVhZ7lv/Ou2lsqu2RqtCPg+mmt2SD2OjBoQpG33vmJ2QbWhUB3jZwOlb1BaxC57klx+CPr/UHmbCsDx+eMZwsDgbSc65fmfqA/0TnHRU5VANHjOP8s0B0EXWJ92n5umMYT3B/C6R1Bg087WjsPvUUZhmXJv34cnuER1SpRST5iK3ZfkhrosQvqXASF8w3GleA+jPHfwRqc1vj3LSt5Ac0tQcfRmcHNo0OKPJ497VAAL5Mkz2XoukoeqDCNkO8eoI/8LcWvbgU+RIlO1TZPqVagM9GUf9iS/jLNHx3K3jGVvMUA==
X-YMail-OSG: Rnjg0PYVM1n.67hzDrYlU80W..AVt2sS7_i5akkr0TuPnxNiPz.N9a4mmAdv2Q.
 uagJfQDNMztN29XNSqEVc7ED2yNTmiPdhBli3RWH_Twrc63gyNsaOjMQ8iI0RIt.fUNpooUwRxPy
 ya6oXqK2qKx6Ca9fYEeDYDHlVbxlVdovwSr.fvjOpqwKU_nxLEL4fcMGEkD1toayCanzuh0exDPF
 Gs7OpD9q4HKYB2dahiHbV.0wPaRGhfYQXPMnd3kkQQ.B8w1W_VULlbM5EWfXl_WNAEzjTn5RhX4t
 kXYtOwx_e8CylLKenk5e8K6FNQpRbl71kAU.Png1Wc6SfJs7__TNNyiWj2QuzZe5kwHstFIymO1t
 Ee.Gyjd4D27SrD_FY.ItHpMlNLeso0umSvYJupkRosR7R2G_rWju0lsQ1.DTPGM_b0RLzjP4Z_ju
 clZWLU88.6jmjtAp_nJmuSJTUXxJ1Kreg5gDoKGqUCpydsqMEERBRXn.1ASGGmctC12ICa.CnDKQ
 q6z1HgGNV.c7vxpb12jD3LjwjSJ8grjuQP5o7LPlhOhtR4yVnYi6kVZ8xcuBeKwUC5B7ttgmVbZW
 b.EGA7C1LUHU8ST0vUU7rKH8taaW1IXW1nhqRcgyWSihBft2JhVArWj5ETeyFPdgwjEGJ8ZLuOpt
 g4gAR5dyWFMaJpg5cbNOS6vUdCCZseLJRU.ChrRV0ZnmlUKtZXxT2NcfZYrAocpsPz5dkgNFQ3_f
 VOqjvBEVfx6PnoCfHGkO7mD1zyql1pbBxxZOf5a.y3njjgr4eNJwRXlt6HL1Y3HBoeTAB_gQo5wU
 t4_ZZRxijKhqHb_BLouUvzhgJ118z3EZOGk62Rpd9FeWDPWiMV_sqj391Js_xQPG39npbMOcw4tt
 dRRWzPVLWoAqxIXwuIZfoZUw_XNkK3orNMAgj131W3jP1nYCjku9Jy8q649lx.TUc7nCN1R5Un99
 FXiIotFnCHaym5jsAL5MlXI2bsULZXZimKq4_xJXlAX5x2m2K0VYSkqxe7Czg7GB9QTrNpwYfrlI
 KmfyxZB9orqPMh4QMc.ERynhUqeEPY8ZiAcR7.IidgYHuaHAIHI.G_UsmRCZnvNG5bJyTvaPnAPc
 WAOIBiAeDsre5cj40SCDy7cSvUTthVaDMoWYwfgG1iBHDnzOovh90a2e7R4i06.8NrCRWGA9nxow
 Cm3eAjjiOyIot728kdtdqjaUVl7u9YbyqyEhOZ5.I9OCqLYH.VfSMDuiHXk1.FQuDH8RabidCHQi
 814HUcCA8.l8.vWOZvl7tPsWjNtMqZirFuazsEqeJpU.e7ypb9p2jzPheWOPOwc3_Lmy6y1EDGgA
 tYJxEZKSs.IkWft6xCcL2dQdIDA3h6brYHSurWkhgS03O36XJMxItWY2K89KRvgc5eFLoG4d92_s
 pp8_S0uL9u3V3Y22NBSUj9kd75qjMzr0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:40:58 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4e6e575ab1c481ad0414ff438aaf1c6d;
          Thu, 09 Jul 2020 00:40:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v18 21/23] Audit: Add a new record for multiple object LSM attributes
Date:   Wed,  8 Jul 2020 17:12:32 -0700
Message-Id: <20200709001234.9719-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record type to contain the object information
when there are multiple security modules that require such data.
This record is emitted before the other records for the event, but
is linked with the same timestamp and serial number.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/audit.h      |  2 ++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 53 +++++++++++++++++++++++++++++
 kernel/audit.h             |  4 +--
 kernel/auditsc.c           | 70 +++++---------------------------------
 5 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4693febcf41f..3cc02ddd7779 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -171,6 +171,8 @@ extern void		    audit_log_lost(const char *message);
 extern void audit_log_lsm(struct lsmblob *blob, bool exiting);
 extern int audit_log_task_context(struct audit_buffer *ab,
 				  struct lsmblob *blob);
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index a5403efc2fdf..753a69c6bbbe 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -140,6 +140,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM object contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 9ca8445ca539..e05f9e1f1254 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2177,6 +2177,59 @@ int audit_log_task_context(struct audit_buffer *ab, struct lsmblob *blob)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob)
+{
+	int i;
+	int error;
+	bool sep = false;
+	struct lsmcontext lsmdata;
+	struct audit_buffer *lsmab = NULL;
+	struct audit_context *context = NULL;
+
+	/*
+	 * If there is more than one security module that has a
+	 * object "context" it's necessary to put the object data
+	 * into a separate record to maintain compatibility.
+	 */
+	if (security_lsm_slot_name(1) != NULL) {
+		audit_log_format(ab, " obj=?");
+		context = ab->ctx;
+		if (context)
+			lsmab = audit_log_start(context, GFP_KERNEL,
+						AUDIT_MAC_OBJ_CONTEXTS);
+	}
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+		if (blob->secid[i] == 0)
+			continue;
+		error = security_secid_to_secctx(blob, &lsmdata, i);
+		if (error && error != -EINVAL) {
+			audit_panic("error in audit_log_object_context");
+			return error;
+		}
+
+		if (context) {
+			audit_log_format(lsmab, "%sobj_%s=%s",
+					 sep ? " " : "",
+					 security_lsm_slot_name(i),
+					 lsmdata.context);
+			sep = true;
+		} else
+			audit_log_format(ab, " obj=%s", lsmdata.context);
+
+		security_release_secctx(&lsmdata);
+		if (!context)
+			break;
+	}
+
+	if (context)
+		audit_log_end(lsmab);
+
+	return 0;
+}
+EXPORT_SYMBOL(audit_log_object_context);
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/audit.h b/kernel/audit.h
index 8efb68c21c2d..830e4dfeb83b 100644
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
index 54639da63dbf..db8628709971 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -670,14 +670,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
-					/*
-					 * lsmblob_init sets all values in the
-					 * lsmblob to sid. This is temporary
-					 * until name->osid is converted to a
-					 * lsmblob, which happens later in
-					 * this patch set.
-					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
 								&blob,
 								f->type,
@@ -685,7 +677,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -699,8 +690,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -982,7 +972,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -992,15 +981,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1227,26 +1208,14 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsmblob *oblob = &context->ipc.oblob;
 
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
@@ -1386,20 +1355,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1992,17 +1949,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2369,16 +2322,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &blob);
-	/* context->ipc.osid will be changed to a lsmblob later in
-	 * the patch series. This will allow auditing of all the object
-	 * labels associated with the ipc object. */
-	context->ipc.osid = lsmblob_value(&blob);
+	security_ipc_getsecid(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.24.1

