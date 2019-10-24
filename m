Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369ACA9EBC
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7C621929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jHbb3lUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfJXUyP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:15 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:32972
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728537AbfJXUyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950452; bh=n9KYhenHMFy6/DvHoF7GAdIedxEuRn1itu30mtANhCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jHbb3lUNrlU6L+ONd7sH/W2DH9V/yPbFoQS24p3yXCekygPKyjAHsGOsB99BMd+O5UCUCEIIQVmSj0whqc9jJW4AyBcLTdPESD7USN32TSMvJRGVu+4KZFkNtRTwFDwoK6S1vsDm3ovq2xDQ6TNEYXPuXzcQvccvzbVZXNn4Mjxsd9HC94xT6J76u7Iz9yL1idxqImbdRwzCduJk/P6Ih5eW3pZLZB9I7T0suxsDeiWqu9fl4n+dzTqI/xDoeEVsrM2qUquWmVNriyUbW43I5qEP6YMcDIBZQ8JubftGjzceooP4Yh0rYWGSxqVmFQ2NJ3ASrqXUg7oKxUQc0JsPFQ==
X-YMail-OSG: YjyKbh4VM1mkk8Rj4IOZ5U7CP6PIXv2dPZShEvjFxTrJpJ.JYoC_hT9AA1bKDdz
 IbfqfBY2ZcsF_Ua.4B4BmFy9YHk5anLBBA4S0XQ0NWTtb0z7AbuxGMA1Liqo0sZhz5L2o4UyMi9W
 iYd6wDL58yFIRviAgjj8DYzl4tBO3sUVUXpXgnYfxTzOqkbLuIXkhYDIMe8nazFFfM94Df4a0ugH
 hvu2t36qLWnuoAqCFnzZXQoPvjPIW0mewP.Uy6gxOcVgkY50XP6y_k6Wlg.gA2JZCyUTfwDYKRi_
 FBxDZpyLxojxFToRVvU2JERMKbmB5a4j6.mEYfyrHv_lduyjf9Ld1e7zO7zmqZJ3oDKAoY09F0e9
 aHdF9HcVszWExE1Qmukc5xatTMuqRhHZ1b_SW_2ad4tRe7xfajIH8kymL6wxI3LXX4F67liq69qm
 59oZotXEiSkpXfO7CwB.8dh_1izr8elhesKckccYvz1xTU4mjnrySHMg78XNfziw0cEMP0Iy.z_b
 jkvlqsk8_zZtIozPHUhVKwmVdKT3zlmN9N9Dfw6EmByk5mqBb6.JeY6oik61PB6Lf3oMDpQWw70A
 0lVGGZPCT6Tmla1Yh7yfhh7r2eD77TlO0rSTrhVCTiHyRoQZchJN64EBx4Sk4r64zCphdb0etRUy
 gUqzzi1hP7QHXYoJWA4DogsKGKwjbt9u8qvqmp8N77mbHwBINUulIMgkQnMMSFHLnLMGM2m7MDDj
 wydnNzN8uZ7f8qcez9feggMjVMFO9giPjfSd8L4e8Rx_nC3kU1Q9RzDZxEgELKu8AoY8WtMpQMj9
 wwfXr5E96.PIvS9HCEiAjlVL_MfQJSTmFgEw4qNQF6eptFIivNTbbndUe92f.tUa585BLWODKNTr
 qyWws2ZhiquZbq42hr1qSwWKXKdGpve9kqfYpRRbLaFpQ9jbg8nh_pdxzDBpDrWr11YjeijCiYPI
 4cO3Sv1D3ko7by9wAUKPXN6SnwZvXTho2pZvPm._tnak0i.CiiKY2AzekLukXgRdha572EhdPcXB
 fqCWyZu7XVOqJFfayfT1dTop0VrzwsWf8LMDNQGgme9bQb_1gxgP.l5.34FRELPkJEioidvpj9wM
 hC7iQLZeFdLIrW37916AMPBFcATe2qGLhbQjUNzq8PL3Cd0O2tWXmnERt5r.pvpxQqtMdSlwk0IH
 xhea7XCaRMVYwUebqJpYHaNGxFHDbgx3hCSXvDG7EsPPv1zVP9SxIkQy12SsUZ2y1GQgcWJDIBFS
 apSeO84aX0gz.IsGOxiBAuA2FFnnuBIjUIdFaK2oV5Tnv8slTSYoArON3KfqjTQXZk354FLXdgQu
 VQJ0bJ5ilHEWzc.YCdROWCFgkuwlGKxvNgfg0_RYpuCl1o5sinE2qIGJNaruLLHUiS1ncvkTEiiY
 RZhrLwyn4wHSTD3TWLfRaxCja
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:12 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 656d248acb5116d5cebde187ab2fdbab;
          Thu, 24 Oct 2019 20:54:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 22/25] Audit: Include object data for all security modules
Date:   Thu, 24 Oct 2019 13:52:25 -0700
Message-Id: <20191024205228.6922-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index 29e29c6f4afb..af9a7d1fc069 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -91,7 +91,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -165,7 +165,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 46d7a58babd2..04367c3593e4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -646,17 +646,15 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -668,8 +666,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -937,13 +934,57 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -953,15 +994,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1187,26 +1220,14 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1347,20 +1368,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1908,17 +1917,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
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
+	security_inode_getsecid(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2268,14 +2273,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

