Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE64C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731042065F
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G9UZ5HHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgENWew (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:34:52 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:37411
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgENWew (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589495691; bh=/Wa1tpeoF3meJljiacp8Di1TWAwsIoXmJ8ykO3n83ik=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=G9UZ5HHWlN9KHJwn7MzMOWW8+djX5gWSctZqKWOIO5Ke+LY5HrX+SuRwLw1RD1MbxRLr0BFAADQMTdnILkx6a77RS6tniX8CIveL+MUf5yc3ESSwJnpsDji977vVqYnZEmHXsTSQfK1ttyr6Weup3Cacx8cByvIG6KD+CL2RL0dAl98BsKVUnoXzax39gpd0C7zgLcoDgGZS0tE2P0mWiR/+Kt5YOHTwsFdkHPOKhmmNnnYZ35y5wYgFF6Nelm3qPmZv9PLzaj8Pj4jpzJg5jmc+ugxJYphMYTORKQYUbbOtUvGTrWY2vmpHsakDQDkfecLm3baFR11HPn6g3kdQtA==
X-YMail-OSG: Wm6t5MAVM1lkbDvQZSqQwTPeP1Le5UjoEcXndk5eyWkQ0w1aGRTSP479U5VXGUK
 AvtYOaNB6e_T6.wxdLCkUFDB968m6nzBO46_pY6yQTG3Bc45J9ukS_YIq7682oxfKfxK7v0qK8If
 _05Le_FxlCwbsrMQvUcJr7zH7S_aq_OzecjkbAbfbWLo_T8jSKL1NNwVSsrePzQXlEqOpaS9VBN5
 MUmU8jUaK4x5kvXZjo9UobaGVjn5qm2xBpMV5DSgFFDuhUXC6ZBB39F2Az.mBiCbQC6auU2xVqNz
 oEIwdMOBahbwD_w8Y8JeSb7HWhDJnarhQ3fvWsELW7Ra76wuWZ5ztKMFoaHLqqFe0kpEmZAG1745
 fOvyU_YspuKw2ebMprILhbgI4QW4x1i.6mCt7YfQAUvanajxrqYHu4QdXNfOIecEUVKSxgarAtUw
 DDClMabtD_nJL6S0vwygWsxW5cKJMhclT.HCu05MvP195ZHNX.2Ktrymzhmyr1jGkmbl8no0NvHJ
 f9e4TB1RtUCJedU3LAqimRLxLtVO7u.MH4c5vdNjzFB6bWoww8JwCMckbJCaBApWs29hghcmjsM9
 cnT090hQK_cOL3OQsyU0Ir8DsaEKoacE0XNQXUdUTZouawMPrl9If7LmjIzdiS9VZHZ1nQgmDaWe
 XLup2LjG.CmtCsfzM75FDpLqB9gVTr2Z5xu_VoPycaYNbgovU7zsbw.YE6qfn_RlwHTAYw9NyU07
 hV6mpLPlIwyi3Lw_ggMozVz2glAO1kWTY5G4qDCxpFFiaXVQQ9ngqzBYm3JSnSGe..bXwlZHcrNo
 Ia5ED.iS8k2HrlhHNGsLspXC.qxNPCo6vvTRK42349sZ1yMqe_BRULMahbqgqxgxvnzDvLGhw_4u
 AXyKxZpIaUSYu.Ox4.viPZCwEfpALlKrTf0rmSoKpbZH55b3t5k2yWLUxxC9aub4enbN.3Mghmxw
 uWDfM6FEgmu2hy4DblYQIZJVXKxo6W.Hx1ti5FBD4FKwQeMCGx9y9SKMroCA.QK0KrCv4sjOQCk_
 ZfqY5DgdiROI3T0YdDLDZcehKtOEYyTtACwbsCOknv.UyODfArSIygzcDY6mCaH6Fy02zXu3Nj5v
 ihIII37D9rBhbdW__oPBL15zEKtloA6Gkb1DhTZp5FPScP2IrkhuNF0AcUEmDmjirvCmliD.vsbs
 cFdbLjWEUuBzy3jZOQ00T2TrEFsckka50.Rb7VpcnnHmuKW2zDoQ05VyW9Bbi7qCEeB9mty9its6
 aBA3Uix3.6ry6dq6CYy2zIlO40UuCzPYjJ0k2hfPzGDOJSM.LruRmZqDN2MbcF.OUtgxKjjf93xh
 N0PA9pQQudi0GlG9HdMqR37e2DPDeMUkoDXY3B7GItqNLjy36Zxmo9dJ7ySls7a79.vuNT3KsAHC
 OfpGWYlnp7x_tjv4Mmw4kFe9DZAHYS4SWNp24GwXuO1p1.KQwc9gur1eZmDc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:34:51 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 537fb358348115366aa1943b4c9dbdfe;
          Thu, 14 May 2020 22:34:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 21/23] Audit: Add a new record for multiple object LSM attributes
Date:   Thu, 14 May 2020 15:11:40 -0700
Message-Id: <20200514221142.11857-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
index 5e8c3559dbef..d5ab3d69f8d6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2117,6 +2117,59 @@ int audit_log_task_context(struct audit_buffer *ab)
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
index 74be988cda01..b8e1b50e6447 100644
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
index 661527d14166..fbea59e3bb47 100644
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
@@ -1932,17 +1889,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2288,16 +2241,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

