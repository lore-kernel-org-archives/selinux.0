Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A0FC433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC68C61241
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbhIXSZM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:25:12 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:42077
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348107AbhIXSZM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507818; bh=18YBw5lrrEScsVFFDKFU/jbFXs15+sxrq394imit4R8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cCpPdnKAvxJVMBQ9nRt4rRRLWQ3hL0EEFg+bhW268Izg8x/e1Gv8Ryd7hOqTplZmEbhkIcb4Zubesk+6IVvzLJ3feIUm+COzepC6gxK4DC5zBgsSVdMvJsa8faBT7z96oPzO6IFigXmngyRWIxkTgXz2MjtiTtS5TIXtt5N2K/MK/Vae6G9JhRh9ehVQWnITFfL6MbfDedcB4MUIiWqwS+VlARRsnCqnZlAw/AKv/DrHUIsHzzGl0Ysyk62OO7/K74uIsfvvsven0n57xZm4ho76XtvauYngEDPUTxAFtxcgaAczlwX2N936ULZ6X19FuJwzI9LWxZBSfjdZJO8T8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507818; bh=PHk0rpGdGsXUhxAQJz5eSBQ8jBMwddQXkX+4QE2UovQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V8c2C6LBX7AgWYp5XEi9elFfehLHPabzFt3v+wGWwOZF90n9wwUWxd0pX09J65R40BiFQq5r2Sb+4TJhjgqcUnIGfZz3rj3yUVZF3/UW+fgVDAFpR1ZVki3rLmcBmEus3KTNaNnWX3k61a28PurO248IiLG1GS4iRvEEY3toZe2Wl/66JG20bN6f0/7swQxNtYhh5kowPJ3lq+FYCXoQrPpm/iV5dI6TiR7VAuVovnez2IlJvCDAWS9kZH73bxxadiZKl29k19sraEf/Aj5v7jZiXMZRKrfo/JYy9bqe0vh/YIkEVvVl/4gRIOFoXZ/WIBkwP5DICc+Op+IVxfvtqA==
X-YMail-OSG: H3GUxlYVM1klHA9mzoNN6XIEjGs8EfiE0DhQeElFh4NqozpNJ9zvVhRCIkfcSq6
 3GUNp8fMqQUBxZ4dcSt0ga6ZZUXq9LiLeGdLByqIXiAIo2DRw_ufeqgAi.8h.n0m.EVNH5nVJ99R
 xs_0DS_gNwGhchGknAsKNWtTaOZWgAhELHPD..uJL402wzoRWZSEF3Mr.xECvLI4kMuBNRqGSMnI
 0J0cDlXNEoVGIJ_AeEhHTXH.OwOFeta01DaA4ZZri74pXCQmCz636XPUhnk6s7rN8dT.CxYgarej
 t2IqM0fxJ2zWxSBEFsBHtX24UtUoHLzsAQqanw0aU2CIgc_Pv2tWyPRkaBjoDO1dkfnsGe3oPu_d
 0fTuTvvm7v5c6QcvzaheR47Vzzux0acz5YuWlHGRwyj5Sz6hjh_CpqTQvTsRf30yWgjso1LxtU8a
 nH7PKGKQAXro5CFlD5vPZL3OKV04XcKLTFaDa9NwNswlPV0UjtpmOYIRpf2Nm.gcxicQanz577Bq
 YpUVYERCCX.p2OfFNKIQlv3uuS69dojMftgwdUPRYctJ61.KVix74MvRhvjbTgeKj0p7tNa0CJ0u
 aR9HnvvLwyGbpyMS2rAd.bM_lDklk7pSQZLVYwwT_zQIEUMDiPGvWaXi59MBrRaUqT3KlW4wnWyf
 Y8fYUVdaNCcfK41zQoQnTOHF9PdjbrfZYvdOPz4TI8Bba2PR99NJ8rOi0mREdcW0Tnqlp7UQbYYO
 FS_oBR_jOPDh3EO4xo0FK1RC.NckPtHHZ_jsjQfZ03kcEHqPONHjZCNb4A9cvFk8Tv_5YIjXEiwu
 dizVH3gHRAm8_go719Agbp9P1tc4kXvZY30C_fWdsdHMwflv1M9cNEVCxaAcIQcjh5eXBPmxlyC5
 pgzaLvdF3bYCE_sYrWIHODAQ6E3kUYFRvzE0DTnl_JatmxBu6ENSOCL6j6IyR_QJlmZYTRYFeXXw
 njzuzVkZiQhO9VPtMoBfs45Gv.sihRTWjQ2zSbltqOeml5.SSZwnPCxM6zGvJn7WNsfT8KLEnL95
 qiB9n982EURrR45pe8uz89BczPkNoNZr2zeh93vA9BMxR0Jo3Gkeo91AklHRBobdpPmMUrLs.8jb
 XRlw2ym4.Ga6e8iaDDCw9O_qerzfiXtisP9aFFpZCo1ogPQ_f1lrVjm86yQEM7YOz_n9LrccyQof
 gWjPPfpxNDvp3FfFLglfKtBIKnDW9pPYAPoVQxTeaO4CxffyGue2kgPQHqP.ET1yWmO.ykwMdfQe
 7HYDIjKNprJd1IcqFnYB888qtRRN98R3ani5YNl.qJ7VdjFhd4kwpTnWnLVsxbxJ8r3Kr212wlH9
 RYWN9bGwhJ75vu8tTo.QVjSyC2QO5qIhR8kuKe1c2BjLnMkRATBnNhnfV8dU6Fp7mhPbX0jhyz3i
 6g6gj.bEmR468tBykYJ3amFPr4dq1IuitZfWi9l4un6gtQ7VRE7U5QkV9rrVm.Jbxhnug2L105Sw
 i4_46dLmVfWKZPEO6gxhpxZkQyPqbAzAnqxOOj4glIwhyHscw390VZPWMLhfoU7NP_7dakP1i27E
 .fXzQnDGm0fGczCQ58koom9woioTAaoWtJebJb3XLMf.65nNsIOCyE.2tXiw9dQ3p0uYeUo.WdwY
 _LGLhZGjf99ym8PbWj3M.PbNSe4sE0ZEvct6omk2X9Xz6NgNPOo7a9Ye6xq0x_fzNudAS8Vubip6
 R0uKAyAXMcx_BI.FiiETQO6hY60GBIWawLql49Pr_qDWJsWUXBe1jxximIm6ZLFx0kL4w70.Z.w_
 Xuuf4FgkgYUnLDHFfAlT64gGFCLT6bLxqve8pCXBwlUOcsKiDLfWahYFIVYiR4e0tYnYBoPeOyM2
 mI0IIHMQdKoOZeNyy5o_63OQ1Sz6U.Rh.ugUkQh_lSB_ern36XY8S1X2QtssUScm9LH2THthLKI0
 0Las1BkquVLwzeX3hQmK_R3xyEf0RkwTUWaLVYGIf1tnGZJP3Cm7e3ZG5pJjRR569DnSz6Vj6ing
 rSqfcq0RDpj5uzladCG_2Sj03CSHrS4XJYoJZj0V6Y52WABmcaYY9SCVw8CvFCQEDsM_Jj9TSWpt
 I9reWiKOYW3Z_vQ9jln359XLGoVcz8KI8X4I3VQt7b.xJ_BGgDAqxwhnLNeC0PaD4aRf.rrQFMH4
 UZQv4tmUws7HcLwwaAt2_7Mz1rtHx8qMOlrKfo7crt6n8UMfyXHdkD6E196YF0hAmBsSdlzaqg1D
 7AM0QWM9fM7E6tj6cN64CSK0lIrufAqm8mXw3fwTLER0sCh3PJI1tgZ5OcgU1Uofq620JkodtGXT
 pkkTNTaWl_vRyhNlzmIDlau48BRP0q7dZdg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:23:38 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6f034eb0e81e998fbc74e56988a9ebb5;
          Fri, 24 Sep 2021 18:23:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 26/28] Audit: Add record for multiple object security contexts
Date:   Fri, 24 Sep 2021 10:54:39 -0700
Message-Id: <20210924175441.7943-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
 kernel/audit.c             | 59 ++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c           | 37 ++++--------------------
 4 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 418a485af114..fe7a7c9ea05a 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -187,6 +187,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
@@ -250,6 +252,9 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
 }
+static inline void audit_log_object_context(struct audit_buffer *ab,
+					    struct lsmblob *blob);
+{ }
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 6a0ac60688b1..4be22169840c 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -140,6 +140,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 707689605791..1d11a47b6a2b 100644
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
@@ -2495,6 +2534,26 @@ void audit_log_end(struct audit_buffer *ab)
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
+					audit_log_format(mab, "obj_%s=?",
+							 lsm_slot_to_name(0));
+				} else {
+					audit_log_format(mab, "obj_%s=%s",
+							 lsm_slot_to_name(0),
+							 lcontext.context);
+					security_release_secctx(&lcontext);
+				}
+			}
+			break;
 		default:
 			audit_panic("Unknown type in audit_log_end");
 			break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0fef12638d8a..7cfd0877747a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1000,7 +1000,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1010,15 +1009,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1253,18 +1245,10 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1410,19 +1394,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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

