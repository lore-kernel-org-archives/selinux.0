Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182BC433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhKXCPb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:15:31 -0500
Received: from sonic302-26.consmr.mail.ne1.yahoo.com ([66.163.186.152]:35356
        "EHLO sonic302-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhKXCPb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719942; bh=mtYI3oD8Hvdbv8bkBbvB/0+CbZD2oGKGTVBtkTuSY1A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pvdvNIFbra1u1o/Mz/dyon2J4cDhgw4sHR2BF54Hq7K/76XfwEolfCBd9cl3nWbCN2ZUcMkYzuNhFJm9bnvJF6YL4wmhUh9XPL8IXCwZRqOsRhMrynS/b6W0XshV5K5aQ3bVJIVngB05f7lmFQEGL5/qHobdUGWAqJRmttHqHQh0CisZnYqMe20U6B6+wOQXG78XLIcjAFE9AC44sVqD5ncS5kViXryxdF2wfbVOd/XqGufvt5VwROS+19/2HS4uXEyqN6Cf77h6x4HpD2h1YDxYaHTjXzgIGvSKC37tLmhpPNCmPz5VxN+PtCZnrgFzSOy86xG+sgPwX9q9clE6pg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719942; bh=66d/hMP7LpdIOCiEgGPsqEBO7FQ6krZslStfo2g55Jp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GoGnmOjVy6EPNrcS5FcGVT2b0w6wEWpUoNwshVURK/MfvGY2edeIBeK3xCACUuQTpvVWqTctYtOtUWCuzNzHnSmMupQbulEdpWMsE6IWBwYbezDefui9K5V5CpVqDtYaC+HEgukxj0pT3OpMOEsg1xGeG+bpX6NZJR1ykyStTvPTlT5P8rZs/sJJhVvpCX5h/a1/xx8T6SY8ifeF5ehCacc5qB3N0zEuQ88SDs8dtTNa1YBY1p9T6oHMZfzEO1mAA1jCIUUws+vSTZThxPNB9Sa59g7hxinQCR0WAncLxzjpK6dFrOPwseNazT96U8sRKNvPBDPQ3L/rwBaglWxi6Q==
X-YMail-OSG: 3gAa8SoVM1mvoAWazgFGJDvQTyOZIMTgZ3dw20ChD8Nu6qcj7LJvkj5csXO3DxV
 rSElV2l9WLf0QxWttUKjBusudOAYO46TszwJKBduh0w_nS6A_07nPs8nO.9HdJGMPiFqsgQ6v6iM
 WG.46kXpm0OX5Npqz3M4HqJT.5P7Kv0b7k6GwhzA9gxycdoJx1eZFMB9DnZlBY0ZkShB2dUvzSCy
 6lCiJfJ3fdbn2wMcXVp7bSxmRSQvnSIny7PXpNmLtMXWplLUQq3RhMR3V2UufsqAtRiS9tUUSSei
 Nfh4tKGIL6g_JFURyuW6g1VA57xZRBE8OTYBb9u4z3GbDtbRkTEvt.kWnpkPBU9yKV35v1dkr3fc
 QRnYsNIOR1qHmb0E7WI9qRHec78Saf8Q_u0CvJo1ayURJhmj61p4VDuvp09eVLFZhSFK7gTx7HZU
 QHZSuXG1HCE3vi8JRHQGN3_90nOBQiyzjJCLdVrvHlExoxxPyxoxIMMUhZ0g.ckkAw6_Z4AddZo7
 i.pfCbpE7eKXuYA2CCqOrTz9yoxhWxBhULSuR8W7Z1pg.bCCpyYa71_zPa.Ac8xMrTxpovzClgll
 dS1SC.Q0TL_DZJU2_yHJLQ60RQBTzDIvxhTyUVi5PJ5Y4NvB5WlaALbXETfpL433PEqRQLWacLAM
 hhz5L1SDLZcheT.QKHdqBU..Jfbfqo1d5sTr3NWnzp.uk.60erPjmW7iWdBWbyBVTg_JvlmF4Eyg
 Nf0_VQC8hKsjU4MeCAyTTH2dPHoAMmuXmkNH4K_priP_kSCL2C4.nlo_wQxCt2__QKA3eShApRV_
 UkKolkwFff2x0I_unhRxpASrLe4LZoEpNR1D4Vvw1TSklrgAa1n7zB2ARTFO23jH9BcrQncZ7.pW
 X3GW7eykW6CpF8Wy626JzK3Cx5wVNGL6xifCVdjudwW9HYdfjZJrL7_qHAoqKqyox0aVzRT0TVTA
 oUGFXrEmj.0GDiHQe.Vh69TV7lk2leHURKo48JjQ0HyU7RnO6dx26bO.soX0x.KK8.qiZBlHfxGe
 VVvNrQInBLWbNQel75.clFnbA8DdmqCMV3GTyT_loXyYmOvLO4vN8QZrzdDGxX2DX1nFHwLDuAAw
 A_LxkveEVZ0Q2NWydFl.dvZjVqqG87lKy62_sUpQrbJWAUJdcRU5MziyoZKyfY4KsKj5t_MpYBQp
 Lr79b.kwyy_Hh_eglZEOG_hi9Y1oRikoRCwj6Dcn3luWooYKMZmPmu33TsqXusOqdAoc1O5ErV0c
 IClABNZxtDEeh0.ZPh6P4BCrKEbAsxdN0wf4XVdnfchGT5JGVwV1IaqyeOss83tnmjJ.1txyushm
 qCWcu.Q3Z4X_oRXTjpLhaAfBf8Z459Q18htOqzvG.Ync80z9Kke9PF40JM8zAk9sOe4AeZsejSmo
 xrPAWJbMVsar9v84raUG79LqFKqYqMwcyX5CkGUIHSiKr1Ul_vPvJ0Tq0yYxsDbyt7ju.6T_XhS_
 yNtF7dLwrrT3O2KJPr7cB9n8RileH.Aj6RwqwT6IF9Gu9TnuupcvEw41BJuzCsRjT7bCG5mK.cHy
 d9JDEVy0dyQ3RVDtofZKi8YEiMse2T5F4EtdngCT85d3iagN1gbfpeEzCmQJyzX6vUSnmKZAkNIf
 m40BQZ8NiTsKrjfs9NSoHc9rhSjsc.0az5tK51yQD18I56qxmRVAj9klSLSRsabxnqgAvrtWllHA
 Phhb8mxHsFHnTgOfW81nz4DOdkH_a35R5Hdcv_JdGay929zHj2d91bf7GtMgwTTejndBA4dGR42t
 DRfaRktOttDxelmYhegkvsBmwyphE5bB1wUluL9ajkpU_JXyb7InNTuti_iFdrLLZsIAoWQabQov
 1nDeRgcXIndfeQN1RqXsPxWoL65wpoOtVM54T6G7IKp2xZo1WHDX_M3D9100a_RAk1XVtSVWNhU_
 dFGAWmva_3oGCx2GIH4YTb5eocKtT_q6WZ1dKlCJ8HqYVzj9fPaShbbzWDVVGDP3bkLzkeUCpr48
 LGxIq1vsR9LTZUpKyiX82HIYAr3nauKrQb5_FCmWN.fFvgsI.OI2PiDPYG1c6NDp9_aWoQaddJ7b
 aTn7FskAzZt3fbATcmsWu1GOIilwjs_sgi.DmscXavFfnGTMG1zqB0X1FcQR2.DBg84kIcQBG9Ms
 xj0tx5iNhJ24CJzgM8ojhNEH4hYQofSDi9UDzIwYirBlexsCI8Mmy30JwWugjAyuo64y1FloBruV
 OfI2tdu_oWNBgvCMczKGh7QRJP00._JeNemBoK08NVFkU9v1Nagh7gwThu6FOTmlkSHDpJGaJIPJ
 i7hMu3_LMzrknvv2mF8w-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:12:22 +0000
Received: by kubenode548.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9ef5d2f3f4863db559dc6f4e0dc49d21;
          Wed, 24 Nov 2021 02:12:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 26/28] Audit: Add record for multiple object security contexts
Date:   Tue, 23 Nov 2021 17:43:30 -0800
Message-Id: <20211124014332.36128-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=UNKNOWN[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux="unconfined_u:object_r:user_home_t:s0"

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
A AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  5 ++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 61 ++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c           | 37 ++++-------------------
 4 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 943584128399..8381afb4f49e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -192,6 +192,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
@@ -255,6 +257,9 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
 }
+static inline void audit_log_object_context(struct audit_buffer *ab,
+					    struct lsmblob *blob);
+{ }
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 86ad3da4f0d4..116566d0fc03 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -144,6 +144,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 6c93545a14f3..55fdcc2c88e4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -199,6 +199,7 @@ struct audit_context_entry {
 	int			type;	/* Audit record type */
 	union {
 		struct lsmblob	mac_task_context;
+		struct lsmblob	mac_obj_context;
 	};
 };
 
@@ -2190,6 +2191,44 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	struct audit_context_entry *ace;
+	struct lsmcontext context;
+	int error;
+
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+		return;
+	}
+	/*
+	 * If there is more than one security module that has a
+	 * object "context" it's necessary to put the object data
+	 * into a separate record to maintain compatibility.
+	 */
+	audit_log_format(ab, " obj=?");
+	ace = kzalloc(sizeof(*ace), GFP_KERNEL);
+	if (ace) {
+		INIT_LIST_HEAD(&ace->list);
+		ace->type = AUDIT_MAC_OBJ_CONTEXTS;
+		ace->mac_obj_context = *blob;
+		list_add(&ace->list, &ab->aux_records);
+		return;
+	}
+	error = -ENOMEM;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
+EXPORT_SYMBOL(audit_log_object_context);
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
@@ -2497,6 +2536,28 @@ void audit_log_end(struct audit_buffer *ab)
 				}
 			}
 			break;
+		case AUDIT_MAC_OBJ_CONTEXTS:
+			for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+				if (entry->mac_obj_context.secid[i] == 0)
+					continue;
+				rc = security_secid_to_secctx(
+							&entry->mac_obj_context,
+							&lcontext, i);
+				if (rc) {
+					if (rc != -EINVAL)
+						audit_panic("error in audit_log_end");
+					audit_log_format(mab, "%sobj_%s=\"?\"",
+							 i ? " " : "",
+							 lsm_slot_to_name(i));
+				} else {
+					audit_log_format(mab, "%sobj_%s=\"%s\"",
+							 i ? " " : "",
+							 lsm_slot_to_name(i),
+							 lcontext.context);
+					security_release_secctx(&lcontext);
+				}
+			}
+			break;
 		default:
 			audit_panic("Unknown type in audit_log_end");
 			break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c128f7e73e89..dc8531a79174 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1111,7 +1111,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1121,15 +1120,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
+	if (lsmblob_is_set(blob))
+		audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1364,18 +1356,10 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (osid) {
-			struct lsmcontext lsmcxt;
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
+			audit_log_object_context(ab, &blob);
 		}
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
@@ -1527,19 +1511,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmblob_is_set(&n->lsmblob)) {
-		struct lsmcontext lsmctx;
-
-		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
-					     LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=?");
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(&n->lsmblob))
+		audit_log_object_context(ab, &n->lsmblob);
 
 	/* log the audit_names record type */
 	switch (n->type) {
-- 
2.31.1

