Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4942C2D0A3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B36E206E3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dXfA67oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbgKEBNy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:13:54 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:38086
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388274AbgKEBNy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 20:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538832; bh=+9S2HV66nBwhdO6JEpeIV6imVdsyvJyagp00DQi7xc4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dXfA67oC+rCRm4AXvJktWHZaOAUyqAC2viaQSKYMkdejtF8xiztTuHAITw5aBr1D1TBEHu9xpB8LpueYMPHnx2Z/aonFTRgSauzM2NvzAyqlHr1dyuBXqe/5rF8W5el8p4TDjMq/yWTTR12mqMUDQ7JCRcRVi/z++qibUOo0QaoTGcb8jlSRqV+Yaos6qlWJ+fY9+PPJA+fcPtbEKR0hSNgRgjKb89Y9QLSZfsi7MYtdfXs59rR9NjFltmT9mImQLl0kotCF7jIqq6Tq7mfQTucfprWjkLpz8uu324nglV8e/OeT1WnIbnhaxfIb24IXDVzSJXmpleCYK9BNMQwEOQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538832; bh=GMsyCcAIUWZQKJEeP0I2iulaakVfUt8u3EXGmHphXOs=; h=From:To:Subject:Date; b=mhy1RENqq6UZ1RwpcOs04/Px+jmB7M2S4dNxPnP32fmV9yG6PkQmBkmVP1WqOBhgQaI37lh3p0g+vX40lzprWf3QBkpi1A4iqTQ53MtcGCVcvOi1mXToAYhKkkoa96JmUnE5zjqdeA3NhejGAqN/UrNk6c+m3X4i4Yttfkesez3hB+xtzc9139nGxm/Ytm2wnXlLFpfDmlaLDo7rqNcjqK9Ouh7IvtKl6dqWrproDItn1G8IQI/jTs+nccyMiZ0dshxxrDJx2BRRajHWwsQDSE12oPY5968HQwIz02Eo6nmm/ipkt8pRsHA033T3qFy+/UDTeIPCGJ0YNmnwFiEXQA==
X-YMail-OSG: ebXtPbMVM1kpvNcW4bhge96ggrdkJmROIEzMIO7TqY7II_0EpBnhmgx5OXxpvJr
 74xce8iUyDViTwdH80wgvJoauuU4_HvwRq4baoeQxVspYfTn0f3MFlKsGu7dgINzpFXBFc1gGIgG
 WwxD8ndD42VLvuNeyarY_BTzs.ZD05GMmHocPFavs8YHXF2wBJxnb59McOS5DOCFZHRW.g12.11B
 OciYoMMLgnHAaBu8EaeatICk83SKW75SVTa0_kQ6CqjrN8IzoOrqMGjQ_02p6MsjebGxwVgxTRQk
 BvIa__a2.UMYQxxRqrfq4ipe7edxaxeO.NkzbHI2659gyW8clUzGZOO6NY31EaZ_8zEgNOvVhbv8
 ClBV7cMPU956.ag9ko0sxemDS7p2c1Aw7OBX3BvJJWBj_dAc3i8mcR_1HvtI1hcO7.HAGTW0ULoH
 J4f3cNgkjEVKwuoFy5.SPsR8xyLwlcvwK3WPbiBL2aeYI.6EJ6WEVCxxqEFGrU_E6E0azbuYQXMb
 pLifWysFj5_esvrMnq9hzvmV7IdYAYSDGvEeMQbIR0Vhnznpo62EUBpdGDRphVmNUaTCAfe4mg9M
 .DNQdhigZHZBrPHtlkbx5dJ5wVzZ5PBLDF9wv7pve2WqUrtATf4gVCNZX15HRG.5lwGskSnaPRcP
 GJWtYy4aM4Yw5M7CBHsWEhDKVgBgNm5r1TJH8OHE12QvJ2uEpIAYhD4b__1OmA.KLpggMa3XQ.7E
 JJ12COvQOze1MJb6ddA2vJWp7nQMmepqSeG.8A2Tf5bwkCPp4sW_nQx8griA8D1Qex97N52m80oK
 E1AOegGdC88uOaVp0NO.65SQ6RHjYc65eYl.JUaBZTPgWQPAyPVYyFJD_IYdXZl00LBOKSJHzFdZ
 sjYftOehI868RyhXuiHmgGFTyWEITxWpgxG4hvDjlRERUHS0xcVWA.HCrizxjbMgnCOb.by1EmE1
 7h3XnMsJlJZa_QpbrP4o1Hk9x8o.85sGfkJGe73G2Kcc.fByb1MhY28svdhibbKXv3rnEBFbqIFF
 NZJq1vTUrHL5ZXnxeo82hadqof7atbQolKJrP79fQelzAjPOPitWW_8W_69LjJfosSO9dYBE5QfJ
 wYudI46f1F56PJWla.IB0AcHX2UAgN42gGtf7jq2jQcHzAncKr5oCKB7M7y185hNfoFaCr2Avu3w
 Z_psk3qVQ38CRinNIxsxbcFSNek3CIskbHPdQ1dWz7qOI1c8Zjzql6FQS6mlG1wf_OsZ5zIQ7e_a
 MNGhHiWTAh_f28khVrUxpJ0mW.TpbdouzJeluqoIrh2tHNHEcHGQBENiXyKdciAp2rPM4IKNP9q0
 T_MsuA5U8IEgF_FoIbM3wdIbkHB3vOTr.o1PPgOC1fzKg.ymmTzop_LMQlMTH9Curs9NRZbucp9L
 eBSA35s.iphMgv64jxNsKKlAApoUldTzE.r2uFJq9HtAT6e_cJFxwzU7FZt6m.cWW9rTHgKd2e0x
 V.9z_joX1nNiA8XouSlbAPcrycL3wi_lLpnSR7KVDT5OcY.Eyk9KnWZFAc5Sfdo5OlsGG_IC2M_8
 Yfub6ZGSjfQRvnlqR3Zzls2UJbmSpjREA6SH1LB9mFOIgk.9nSFZAy2YPAnsMxjZrB4gCVb53rwg
 5K5XpR1puMmGNiIF0fV2hW7rGe38YwaKwFVn8ELhTljM2xcESBz4vkPzpCfs0It2SHqt1eaNY44O
 BqyMvGrrKrYD846YybZKqaZ7i_JUDON4F3s4KUkVUXTNngH3559fN4AdOiasRwR4DSXjkxlnHKRE
 6TXcewKmg5OS3R6e1M0sO1yAVUNy4KtjkFEv2cIh4yU4bEzXMsawXuahClsg_giC3B67ywrt3nKy
 UGAQWLuugdPUwhaHV7.lu20BdsIOQavjxnI7QXPQwea3Zddh6Hq0Z1T0A1hMpq1lFCzY_zHvpjWz
 zwJJ0b2kklNKPoxLgbdQnK0Pc6bXB7TxIePDu0.qy90hMxRsga_3Sq5wbS.Yum4122j1au2z_CR_
 DcrgUyf5ars3wVHNjxbDXoNP3usgrdUOD5yZqCP__3GN4WjQfdee.AhvfdtouTj6e5OzWMoxNLEe
 yT4DtgFQ3cKjzRvIe4ZHO3Npvs1BcMzuAVhvch9wVM0QACJ34cKdFj.RipQXF7JAW1.NHczds3Ui
 EP36RSVB2AbQGZPgVsmnEOkdD7Ypn9DJW5tXthsRc4Jlpv6KQSbln615PKBoamlri3DQLf4MmRjV
 A96srWJz_SlUwtDlwHNssl1pxX6bmNCMCWsgxfnbzcHz7OxTZXpdvTPIS5QGmCDciPdpbcxMSeNf
 _EXT4ZBHlZL_yK5rSvf4SV8rCLMB12Ke7HaSnFTaXfNlzD.9CW8maoVVWnQJFipKM0.jBk9o1sd3
 vXSY3eh1DuvZn_Owo8YwwBS0ilElAvutfnTug5zSMGUmHE6KP5TNs2tTV_As00KrY3a7Lw0BfwFq
 Hl4xkzJyXOxOON_RpaoS1wl_1GVHAvah4qB0sdunqgIwhSPTLLMf2QYAi.mpXnti6k3Yd8v4j.T2
 stGtY9lhHK3f4eBb24UoJ5VSnuhPxJWKMFSI3zMuCCQVtfwEHD7RryS3AMaqeG0mvXrFOPz5H6GB
 Ofb8nBy5fnW1ZkyJESm4e3rVpBj_NZ1FDFVrHUU3BoglbO8vQTSL.EzEhrXsMLq.s3BNrM2hadA_
 iLRWnM8WtIqrmCoFMlNw3NhT9bLkG7OpJ0qj_qXF0EiFg4WZ_ERS2zeyxVUTd1ls7sXZaQnt3d35
 gaOvXhDsSMvfI5lwPhCqd2JLvVqH.hDq4I9vHlcn6KW4u9wK2_0h5qx5nFYprv.CIYTBto_FCakz
 BcC_wBJSeIbkIyCUtPt0yno7kurZDMXN6QC_BZTDOyUpahuPcHuF7wXM_elXpgWFLEJst2W9KN8i
 uRSFjWAui0pSUvSYGnrbVJdEnMqPybb51AHxuI64gxYY8RJ3W_EpmIOQJBCOzdNKgK2l2hXeTIf9
 xVm_eIZ8fZtvlIJWIIhC4VTossbUsig0XOpGbNSwJRJBp7YrSHHo.c7.NxpQfDaUD4lZF5PZXgv0
 LCFw2Fge0IToc81l.dCEgmXPXs0R_D5YkVXJo3z9mc4BZA_hlswCwoKFEPGgrgMe5zSsIEL72Q6g
 c75FS3Qgt5QHfigWhiInC.QMhrSpxrc0xSbrMusaz5KQbE53YCMv5kJ8ojcrVFDdP2NsTeUO1nU9
 EhaxTqBWdWC5ydfRNzTsp9Lhq3ypljVI4ILgYKeDVi3r6NIbyB7wRalQoIQnneibEr5DJ8ILM47b
 tZziEJxan7uagV0Lr_YbY55_WWc1nqbX8GXciVeBV3iWW1zFG1ih4Qp2eapaPbiMlHV4h5Hf_B02
 gsgCSI2FKUDUhZkI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:13:52 +0000
Received: by smtp404.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 23eb33e62b0cbee37bc8e85076d42198;
          Thu, 05 Nov 2020 01:13:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 21/23] Audit: Add a new record for multiple object LSM  attributes
Date:   Wed,  4 Nov 2020 16:49:22 -0800
Message-Id: <20201105004924.11651-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record type to contain the object information
when there are multiple security modules that may require such data.
This record is linked with the same timestamp and serial number.

An example of the MAC_OBJ_CONTEXTS (1421) record is:

        type=UNKNOWN[1421]
        msg=audit(1601152467.009:1050):
        obj_selinux=unconfined_u:object_r:user_home_t:s0

Not all security modules that can provide object information
do so in all cases. It is possible that a security module won't
apply an object attribute in all cases.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
Cc: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  7 ++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 53 +++++++++++++++++++++++++++
 kernel/audit.h             |  4 +--
 kernel/auditsc.c           | 73 +++++++-------------------------------
 5 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ad1eda37166f..af9403ba8a8a 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -189,6 +189,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 extern void audit_log_lsm(struct audit_context *context);
 
@@ -256,6 +258,11 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
 }
+static inline int audit_log_object_context(struct audit_buffer *ab,
+					   struct lsmblob *blob)
+{
+	return 0;
+}
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 static void audit_log_lsm(struct audit_context *context)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 2a63720e56f6..dbb1dce16962 100644
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
index 554279cb1e20..1257c1787f3c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2164,6 +2164,59 @@ int audit_log_task_context(struct audit_buffer *ab)
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
+	if (lsm_multiple_contexts()) {
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
index 624828a9a7e4..3be4b03e5cb5 100644
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
@@ -154,7 +154,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 44b150432147..c314533dd220 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -688,14 +688,6 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -703,7 +695,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -717,8 +708,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -1027,7 +1017,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1037,15 +1026,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
+		rc = audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1272,26 +1254,15 @@ static void show_special(struct audit_context *context, int *call_panic)
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
+		if (lsmblob_is_set(oblob) &&
+		    audit_log_object_context(ab, oblob))
+			*call_panic = 1;
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1431,20 +1402,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
+	if (lsmblob_is_set(&n->oblob) &&
+	    audit_log_object_context(ab, &n->oblob) && call_panic)
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -2047,17 +2007,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2403,16 +2359,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

