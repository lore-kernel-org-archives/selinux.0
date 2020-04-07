Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F05C2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063A32072A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VpthmC00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDGAZK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:25:10 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:42741
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgDGAZK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586219106; bh=SyvzILywajsV6CaJF4vrWz2vZXWWkL2eWcxv1z7kj8A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VpthmC00t3y7tgmRr0+sJ3X7L446op3JP+06xxTpAEhrfznM4TSsUDCD5L9LLZ+5QgKys4jkgkpvktsmZ5z9LRzWSCaQbMn3I81DGwMB8NJhpKcHi2MLfqwD4VGG1JNjfTmoGF3i9LEXN1frE0SIwcc+wCv25pds+1XLDwP2lDdi9GQZavxlgiHvDHFK6n3CPoL+v/m2ibS0fOliv8ItPoRhOOsotGCyQm1nvMAn3a/mEg4kcBRpCeW2qeWutfebQNlkzpaGZyOKRL5uJxH/Eblkb+kd+9rqAXu5qMvBHoLYLqzveSzp7tWjSmcLH6BsY19IaeZTGH7Rih5VNyXsUg==
X-YMail-OSG: PJWPn18VM1kD9nX88Fbtc58__bUGx5AdZx8nhrnPxFoqUpfTD6tSPYOIw_Xx53X
 cnHhFTA5OaaW8ZSfg.ROgUaKsdbLer6c_WegiUil2sQ8jGBUACgEI.FJpGIPggHvBfBWjBXzQqL6
 2VPVQcEwBlTujWIg6LEWRG9BiS2NFYYtmLX1rrTf8dOobHaZyAw30.i.7v3PpUQbNcKWBuYVTYtW
 6tDQrQLweTrFeZNcnTeHmodLIgYK9OwE2BP.Zso9nB8sIfahxS4ddjCrbPVoWFeXNzEhjm_si7X9
 niICJRUGPxGsH2I.Cv6FiI5.0C7BB6ZzyhIF_u3aFVjJkvYePwpJw9Hm.sXydWvLj9V4jWtVr28B
 gm8E4tlKHyLQPjB6AJ_vmJ820mVNkN4BU8tzwfKaGC8hn2YEJoNNWPHfpBlJprAyWWsa9Ya_rSSW
 sH7DNtip0gKG4wv3beQ4CxI1XTudBOU231o5fO56ui3isaz4Y1XWs__SoybZ35oW9mvpslSuq9wv
 8Dgd7VHA1Bi2xR_lIQDO2Pszjj9Msj079Y1FAeDG7.MzkVWKprJIANHZ12nnCs032Za2j.EFU_Av
 aHPhvln1satIe8gzvAeUTkkquvIeKmwgYU_CRmmTHhtiuapx6ucQTpASLNcZbhd4.ZfAjT5QFvH_
 Yq7FK.8yzuis7xbyaw1dOq3gPR.3kwdg4WUOcU4qrd33f.XdVhOyPFYW5fgTmRGaYGlKkr8SJybv
 DdIOVgC3LxjDoNpW6lMF1a97ACcR_UEVfJHl8xjY5S7ZeoY2vgsl28XKseDj3lsOW4jriOQ7qr_z
 9KiyCeme5glJ.mrDismyAN69zyC3YF45fjnLTcPNfRWy_wa2WRbpl0SwaJYKIrtCU3Blk7_ie4Pw
 rqn2ebcxNfx1lIASf38ecEVh77FYGZCR2P02evRPAkf_fiGf73FeELNnBd7jmUSivLYeWJvMhL7l
 4oMGT8Bt39dUC2UpgPh.d6pc_LA3MxWk5bQnUDaig.scn.sDCvM4lE3L5yJKNtfS7FokVjQ8F26x
 08s5m9cKfVerFIOyQVyFmv70oZEYjoAdSgHFa9YrQ75ZM6suYAKdBoi0qhmFVU4FieS5o6PPlGmI
 CWayBneOGeBA32PEYcF5zqPN6JI5WlSaNQ5HUpmvMx_dVhvQRRrlSpFgyrWx.kZ2JKX5cqsy7xRg
 wwKuLSKPn5dnzjPZa6DtAHYP8_PIAgO8yr1mDs8PvpjWRtkor4wLldHh66NHJgsghpknx61YUu_r
 cqGL29SKeFL6.6rpZPhm3ufDQleFe3I5KP1Pdb3x_LNB3abauUmS22CmRi6N6HWHU0_o8BaN69Zc
 6mcG6i8EQhkEojDkNZF44N5iU7n8C_P3doybqVbppJbnvSbFXD_6lyHgCsCmPZ3UZaXcr.ZEgrTc
 ofGd3Yhlswr8dSMLNMlO_fLJe5W8hA3yP5nvE31NueMFp.vHXOv9LEacq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:25:06 +0000
Received: by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0011115247f55b0b2547aac425a3961b;
          Tue, 07 Apr 2020 00:25:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 21/23] Audit: Add a new record for multiple object LSM attributes
Date:   Mon,  6 Apr 2020 17:01:57 -0700
Message-Id: <20200407000159.43602-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  2 ++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 53 +++++++++++++++++++++++++++++
 kernel/audit.h             |  4 +--
 kernel/auditsc.c           | 70 +++++---------------------------------
 5 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 8e1c759fd1ff..4c7c0ee867a1 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -163,6 +163,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 2e6dbf907ee3..2269100ba0ca 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -139,6 +139,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM object contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 00a4fbecfdf7..6a6146a34cc9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2113,6 +2113,59 @@ int audit_log_task_context(struct audit_buffer *ab)
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
index 4df540c32581..f567f3776ca5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -659,14 +659,6 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -674,7 +666,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -688,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -969,7 +959,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -979,15 +968,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1214,26 +1195,14 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1373,20 +1342,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1935,17 +1892,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2291,16 +2244,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

