Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDDC433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhKXCO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:14:26 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39289
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhKXCOZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719876; bh=m9z6o5dnm8sdyVoupZTMpf/y8KugHoQUZlUN1bqiah4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mRlE2LP8F+SB1McJjmr23GgyjCan9y0sgGMw2Sl8hIPiOjpX8f9Yx9qK9MXiwCBHwU+UMBk1O1+vZ230ZbkkLcYEUviNUS4qc8e51TpalbPUD6xQ55psGhkQAZC57qfZhzuFfIphqK+BJD6zoHgCq3rHrzpTQgbM2MT1OXu4tZS18Z1UD9+gAeMkWH+a5g1NM7z+rBMBc/r9XszNGwohBD0+jXS2LWx0JkukpG2ufBLwtxDKslWM6wNvMPczqnNoVWIpkv6GLw3vvtYpMUrbADtJ+Nq0RdNHDiY+US2ATMNFURAbs/wmYQJRRCAp3cAiM8gjxtcTdJiY6+wbjcVWbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719876; bh=plgdhcLKUxH8+Bnhd4lqtY5xCUxt4vuPx4n0hktunY2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tC5AoFbEmJvvWpbHITgiQ1f8b98EmNTpJL/TOwJPfuj43n5WiG+5lWuiL4PK5g/BQ+I8nNBaeXmaEeZx0Q+d1ovZwa+x3cw29hSo+DBT4PkT2R07MeeNRUBo3FyeCNJxKAujNGNrU3CYybbUWaEaLQ20mczNCahfxl9ThR1UQ5+GTVYW02sT28O0V8JdRO4RUkofT+vc1cEu4WlBbu+RHXlZ824CTPLw+5Jg4/uqaDAPS7NqmClHIzINqjpKosL+yBUt+V+9cEVBewc933ciwPAsxCf/+YB9YG62wO4Im1O7jiHcNOUB68Kn1SQpvYecLU2P11uHgPt9tRSKJetlbg==
X-YMail-OSG: 9avVOs4VM1nweajwj3WQrPrqpXoGK5xp3RRzd_JeUK26SblMsTeODD2n86ZnJVz
 XcWZ5BBeUJvCQmuGBxQXIUMnY54dp9wqRcKkFysvFKQ7ciKqb1_DMNtHZbD9tdzwaLSbrX9szTTV
 pAIuiWUoOLTtTBW9tdbFCxlYIj8OJG01gNORI24TOyzMTOU2Np_VtP_UNdrshBsIsSWQsEuW4obO
 Lk1eOwynjaa.cDShGYv0mSp5pqR5w_bxIlCh.fZsv8.yv.JLfmv1W8nk.fj0GtwvvgZDlalMKtw1
 qIEFXBjUwglaP4MbhGmU4coZt_GSeYddJVFjw3wHy1.RsvFXxfvRJLIs8iQy7ZkGL67Y9yAfvkgc
 IDmGth363isusDA0CwqBkUWNFzlx7jJwBZrGh41PJwgeTol8zUqF9XqN89AwVLvCGibtng3tUoAK
 yTPAkf8hGIqxkSs5_NWoUeRppx4c5G7bhUUwiW_M7C1NjGPbn9U9fXHJvR_tm62mVsCJIb0Pz_uV
 FId4hoX9oDv6KLAe_MIpyDqxaf.Wiwll5oF395vGRAdJQd4oXYeoaHndnjroNxaYKinyRWK7GytL
 x1yfWmyW0bGQ90eSEg6vQJsLDWIYWiMBmVtuj5XcfD0Etk_7iT53M9B5l0vpKFD_tzNo3H.saY2A
 6dKWiNUv9_JBO259OTuAmPXjRM4v20Z0ACp9OwXlOYWCUtl06A_RCk6.MLrA9aTMAlpeQceC_Y3x
 RtqpFm6vWL0s6f3fAXbq5u.vfWtdcIjPq9weGfr6xXAT7mNX.pOv9im7mCjrQUi_nIczY9oljt94
 DBEJrEFpEhhlpN8.Z9cWt.JcEIXl2hZV223aytpsqB5w26qHgTlI5UzF1NZBrkCza8bmVdqtQVlO
 rNhVd0iQd.Qu8kp8hRO8yIBeoQ2BB8_rkCMPT7CIxMFzEA5WSXum9nMgNNc3od1H0KHKx4RDJnwS
 XrDy1fPEsLWcl2aU6nttCrxoCfh4kLIVodkUaOsZ7Rm_DNMyxVtN4IKKeZyQvc8Rh1aVGLDN49VV
 YI3i7FQ8RwOBz1xWLWeVrq5iHaUf_5Bt9s.cuQ1kanh4Rl8Z8Ms5WBV7Lf9XJECuLYiRAqoW6dm3
 Jnx0Zz2qPD6Glw5zt8g0xPURAnHVacySiSfL0k_DdDMzOIkt5UCy8XE5mi1p_hAZ_1jiFi1_FxpO
 iT8A5oSO9t9UqN45SAJG_uwVpIedqQ9k9PleJlEOifD_tpcp5kSFkjJDvMn2I394PSCbGyAU2NHW
 xVFuPx9ynnJ1zqBwEhEulzc6nkBqG3w7XtrkhTGI8.kgDDvKQEu_0S5q8iTMVTSRvg5UTIyjBPh8
 gH2iMi30_sPiCXgdh3ngr.JhtIm4YJ9KdGPiw45ylJOCdSc0Z1X8WXl9S3ZmGt8lBxDi12mBJciu
 ha0V_yV6WasGqNN_94UZ8STshXLvBxlYtOKLNoUZSF1xt0xvEJ0zmeF9d1aLzdQCuIKQZEYri_FW
 QSIOqW8jyuYKjw2OS8DbbcJmnqDdWoIViTYtcQUhV8RiWo2TsayDsiH88lA8O0RN4iTAcu5coCk3
 sEKV7vnG_FfcnqZqb02xTFDZI7hitBBBscsDBXSJGGesncYFU4I9H6FckVP3K9FyY0JOMrBnN7go
 Ee_iGQ9ADIjEYTDd6KvVzWL1Ew3CPrZYq0Jwgdx5Jl2y84rVX0wo3ZYFRvDmRi6bafwF6IxYqbWe
 ftLFrXOlLlag8..7Ec7EBtFUP8BI2lSm4Vh.d5NskM0uaKTLUl.u_1AR.5v.A89t4RRHGOO0tfz8
 jTovX3f514FdSw6zlEM4dKdaGb6mlXxSU2goD9LL4jI5EIQgHxx.wLEF3yc0zCXJNg3JjFhbrp8Z
 WFrdXyvKrAoh1wlKu_sn0FvsOewB76jLU6RlgMiNjhXOV3gqSbm8_tuuQERwRKte7_Hrte3XER2l
 AguQ3Ir6Rw2W0_MITbyAzVVxYv75E82LI8.KN3u5cu8sAEnqf524fD9ZZF2C1K_86kMvf0zgBK.1
 UWkU8jkOUUPaxrOSBtX8li4d9Q2Q0ferKBRfHAvHkDNuo1w4XiDTEmBu4l.BxW_QgljHNJGkznkx
 bv5eEx.X_fmGtvG8ui7ZaLwQmn6bd2dsHWW3onY6tiWknUh_w.sEAbRFh5kJwu4FslKMGUYVCPZ0
 5z1NEodgyw4nfcbzFMtDQW_ROpP4fKMqpr.zIXNCrXUl2vqLfCP3FUdVr0XVipNZ9J1Lp9TxJoV4
 qx_rUKE0ZPKNwVWrT8Q8lFvMbAonJRQJm5T4Ume0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:11:16 +0000
Received: by kubenode503.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3947682d601f244e6395ec4483004229;
          Wed, 24 Nov 2021 02:11:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 25/28] Audit: Add record for multiple task security contexts
Date:   Tue, 23 Nov 2021 17:43:29 -0800
Message-Id: <20211124014332.36128-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=UNKNOWN[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor="=unconfined"
    subj_smack="_"

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
A AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h   |  9 ++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 66 ++++++++++++++++++++++++++++++++------
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 763dca314c00..b98545d2ae04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -231,6 +231,15 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9176a095fefc..86ad3da4f0d4 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 2b22498d3532..6c93545a14f3 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -197,6 +197,9 @@ static struct audit_ctl_mutex {
 struct audit_context_entry {
 	struct list_head	list;
 	int			type;	/* Audit record type */
+	union {
+		struct lsmblob	mac_task_context;
+	};
 };
 
 /* The audit_buffer is used when formatting an audit record.  The caller
@@ -2139,6 +2142,21 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+static int audit_add_aux_task(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	struct audit_context_entry *ace;
+
+	ace = kzalloc(sizeof(*ace), GFP_KERNEL);
+	if (!ace)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ace->list);
+	ace->type = AUDIT_MAC_TASK_CONTEXTS;
+	ace->mac_task_context = *blob;
+	list_add(&ace->list, &ab->aux_records);
+	return 0;
+}
+
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	int error;
@@ -2149,16 +2167,22 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-	if (error) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", context.context);
+		security_release_secctx(&context);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
-	return 0;
+	audit_log_format(ab, " subj=?");
+	error = audit_add_aux_task(ab, &blob);
+	if (!error)
+		return 0;
 
 error_path:
 	audit_panic("error in audit_log_task_context");
@@ -2419,9 +2443,12 @@ void audit_log_end(struct audit_buffer *ab)
 	struct audit_context_entry *entry;
 	struct audit_context mcontext;
 	struct audit_context *mctx;
+	struct lsmcontext lcontext;
 	struct audit_buffer *mab;
 	struct list_head *l;
 	struct list_head *n;
+	int rc;
+	int i;
 
 	if (!ab)
 		return;
@@ -2448,7 +2475,28 @@ void audit_log_end(struct audit_buffer *ab)
 			continue;
 		}
 		switch (entry->type) {
-		/* Don't know of any quite yet. */
+		case AUDIT_MAC_TASK_CONTEXTS:
+			for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+				if (entry->mac_task_context.secid[i] == 0)
+					continue;
+				rc = security_secid_to_secctx(
+						&entry->mac_task_context,
+						&lcontext, i);
+				if (rc) {
+					if (rc != -EINVAL)
+						audit_panic("error in audit_log_end");
+					audit_log_format(mab, "%ssubj_%s=\"?\"",
+							 i ? " " : "",
+							 lsm_slot_to_name(i));
+				} else {
+					audit_log_format(mab, "%ssubj_%s=\"%s\"",
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
-- 
2.31.1

