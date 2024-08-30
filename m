Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4623B1
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978157; cv=none; b=oWnAzxY/yOTpyGD6L/AEXp8cXG87+rnec3SLP0kCvV03pFapd0J1J9QmQch5jM6NIg0nOKTMZ2rt6muAhIvjlXBbzkpb57qGSQBRFDYSgc9nG4M5QFTcrTejqszHy6/o5FWnweLi3ueaKAlbRXOU0MZgX7dydCcha95ZGM2pQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978157; c=relaxed/simple;
	bh=phU8pKeh6p7o5ScZsi1BEJtdlQy4iq/UIYHsfl6XcXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLCSRiBRlHA6SUcZmq74aM3b72ZCsOSoTVPFhmjaSCOEFct44yKk3vj2ft5jYBmfjher4yauf0zsvCe4V8sxfg7Yuwvififj0678eYvqObbu23GTeJVxc3HX4t6nwaloB0JAJbHJ7l6oWElBsHZU92vYyoH1cjP/xqhnzsxV+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ITJEOGTf; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ITJEOGTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978155; bh=69InFlsfk6vDVq6FRMomS3FCfOYk+0BgDCIOhifz0HE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ITJEOGTf3std/VcHSx3djvoqjbiS8hwTfv40sxqi4feACE2OFEIzwU3ZawMuoCuW80aadLqy827uAbsAiaP63L1yyHeRTYoJ9l3uOtieC4dPZWPBGWZ/v5DKpeNUIn3E9hVJX63dVRdRGG4sz657dLKoH150k0YntgvNSOBv8IIGnKYhvbpCSo5HE6jVcYkbnzzf4MgPFkoCm9VIEV4aQM2gDKBFuip1zY6szaBjtYdeZpryh0ZqR/MEgEdz9JGtM34Qs+ICsP4i4X4zDIrdNqbvNtHO9SkYob/IwajFZaj5Cml2THBbVfrJs44EnU65+6DtxRII1ZhczGtSysR0xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978155; bh=9e133hUSuI5T1nE5JR6lnlZTd8ov0H8v+Z4DGVH6zxa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GitzyQzWYTsS3owX8I5hIdJxci+3/BehlHqQg9s2Fymrc6PZismzv/FLlcYU2hoim1cW57IWaHRUc2+rNqNYPFswnu0i8gUvG86mg66ouvzR57Cr4lpeR0+U529ECfpcE3k6p/MmYTg+ufmRbgOeyFmx8de43hcPKR47V2awdxK8j6cvzXjQ+hALgD0gscpydK69eezIJYuz6qTRemxIiZHmupkDDUriOthzhQD5o73wXMKZMHFuIO365ZIi9DzYRK8ECNw3O/fPqLz0a1Vq8i6REhSU6mF9KNwQ9bLMH5boUmITL7OEsWOylLmp80sJvFM57wk51mAL0WlecTMc9Q==
X-YMail-OSG: Q_ZJ05gVM1lwoXP7hRnqm.uYjVrgJXZMDzgrPRHF7g49LX2rDAH2AtH51NMvvmG
 JN9upaK_hU2HOyNbT2ep4OnGl2JW.vlmYj5EBRzXBQd2hpnwSPLHdDyZsWW0lODlbBpcLL9L20mT
 vxaOAKPd7BIEqbe.ULqvbyoxVH8Tm3PbFA7G1VJhnGC64nSzQAN0DjkaTJ4RkxyxjvZf9NEfQAsO
 lJMT2PNx.q237WGzC0Ylc69l.g7uCoSs0Cw3S_m2TkkiLnI.78Wc4W79N9wBHxFaIK.6MIUNQ1x5
 oGn8dFgA4VZ0zxroHia7H0Ht3X9E8hX8z3dMhDLdfuGT7UF2yIzVeOZBVPLw3qhdINlzao9ha_ta
 GcyAJ5uZkOdZKAhd.gzPy2k53eqAkCgvaOMWrcu0g9ujZO5GMgFryWGxsrZRmMBz5Jqu.sQlf134
 Y9yMTTZrbdcSUiJgVlp8189dzKQ4ExlsqzS4Zju8PT4NC_JwyCpUxv0qlw79qgZ9rGvb5B9MUAVX
 G2f_wUJNxNLb_Fy8Na1PNRUcodlUenZZejVgMJXMFpUUe7R3xM7JMEUFJ0sImwiFALYdIKVJQxTW
 3wY707PkVHMCKSRw3JD7k5EYEG3gjpntikVQUgjp.tyebGXUiLWQJkm6EB_nfjGkGRpGumSLalLT
 ZefXRWFOZkHf2LG04n9yDmaPxvkqoGsSpNMoUc0rFD62yd0YE3tWa6wGBVUQ7esN6gVGJqz668VX
 4lZnTGXyzHoB6zx9RpuPn5RYB_Xy56ADxw5LXB.n3Veq6VbBeiXY09rVLMmvEzKoLzuvz.3By5BL
 MkFl5APmD2Xnqbo3BTcf_0AJYBUGEp3h5m0xZok4Z4uNe3t.KLCgbyCvnhsPOqZXTwrPpKDYyCMu
 Tw7X8.IjqtjcuakBlnKRj0FsVkEU_CSumHHyWEPIjOhGRkJU70aRuL7sslZDPLoIBOGet7KNbwfe
 zeasziTbAE1XgRUccHn22oUZ0BI0cClg6fPm4ul.F1sTr3hh7j2chYgxTBWoV94DfRyTVPmAWZ2W
 ZBoGawf5_yeP305NJS5mCXemJk5LY4EcFJWk1eV1gp_fUHY4.kHZqurBNCB72vhMCY6k8x3RMR_9
 HdgA0oa4YUXEFvVP6em30D8FuUSU82XFzJ2d.BAmgwqlXWFvVUKTrpoj7OmO5uRAsqfOeHUWT.SS
 LmPeQx5EJ3hab1VFlLbhb8ssRQvFtdt7zF7x3lpPAh0jN1jBIZIVCy4YNFL74LE5DHECUWluXeS4
 QtaZWuYIZx1T9sR00qqPtsEBhiVNCLEGtDNy1gWKgPTUwnkfe94xwImkYyE7ez6eghRFHv_PXRR.
 tc1Lkgc00QuQJFAFdDpaQGBCOcLCzEu610vDaTvHI8unIZknR3.U2W6hGe4P3WoH5WXDTXdmwcey
 9K6i2YI.MxQL6fWexGwyeeWk.HpWBOrnO93WlfqMfwQqvnAPqAUNgqRVm5pORtKEnTmaoOhXfYfh
 2csabUxhLMHuFWlzT00WkynGY2WnXRV_fHnrDhdRx9ACuHbKz4iJL94qJl8uYZ2yZv1QM6a4S.dd
 6dP7kpPfqPr9yMYw.l8wVYnpM8Acup_Nxy1mkCXJY8qQRfqLDhilQhJtCZVewvIipvRrL8P9o2ek
 v5tw5PgCrIK1NkiKqw4HFbN1rrHjpjwxUHDczy6bp6GFY19Vk1Sy9D0FLopFdPTAlxdzWYPj6v4o
 sh2PqAkoXz0YNVbWqBCaM_LlJ4ba08cx4FCWLZyfYzxeLQbBw4Eunc0HRrI7EsKFobEekW8gp0kY
 Dc1h6.fbn3mkrbe_3LgrNXi3KeNKJStnEaIrvILM4BGV7UsyyDN5Cstf06Ev4yUsowy64HyyX._e
 RQQCrO5FgOonwaeBOhYV7eE7q9AijHX370SQ7hu3eIxX9crLBZIFUDRrmzwsuEZpHOMjd5UkhSTG
 Czagrdn5nttZEhyL89T3o1mTM5LW5nMQJ2pqjTKYWUvm_kzzIT9csF9_oUludrAIbCyyMj.fpMKF
 t4L9VUVBUpVqf6CFdC6YAFhDO3b4nBxBLAecD1cUzk9LFAnCuluJkeppaNyOUamnCwIAVZH2PCyr
 mr6hfjSlPnItqZ162lD8Xk83TIPeA9rcgpsyA.xlK8R9_ypzB3X1ybsPEQqFwRY4rD62.anN4B45
 tLF7OSh4HMSWTRwPY6y8OAiuM1oNYNskoIv4XNU4fjMva9Jj8d53Nx5Fa9px1IiNsELKhJJSsjr.
 EEG.ld8FBGk3hQOG4xLJjcLA4F2uf9JowB.wRJPaeQ560qCrSFYfhmU4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 014f01e8-783b-452f-95db-6c125a354d78
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:35:55 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dffbd785ee8ecfc4db9f25ae20a43d90;
          Fri, 30 Aug 2024 00:35:52 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v2 04/13] Audit: maintain an lsmblob in audit_context
Date: Thu, 29 Aug 2024 17:34:02 -0700
Message-ID: <20240830003411.16818-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the secid value stored in struct audit_context with a struct
lsmblob. Change the code that uses this value to accommodate the
change. security_audit_rule_match() expects a lsmblob, so existing
scaffolding can be removed. A call to security_secid_to_secctx()
is changed to security_lsmblob_to_secctx().  The call to
security_ipc_getsecid() is scaffolded.

A new function lsmblob_is_set() is introduced to identify whether
an lsmblob contains a non-zero value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 +++++++++++++
 kernel/audit.h           |  3 ++-
 kernel/auditsc.c         | 19 ++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 457fafc32fb0..a0b23b6e8734 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 	return kernel_load_data_str[id];
 }
 
+/**
+ * lsmblob_is_set - report if there is a value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	const struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..b1f2de4d4f1e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -160,7 +161,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 23adb15cae43..84f6e9356b8f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				/* scaffolding */
-				blob.scaffold.secid = ctx->ipc.osid;
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
 		break; }
-	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
-
+	case AUDIT_IPC:
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsmblob_is_set(&context->ipc.oblob)) {
 			char *ctx = NULL;
 			u32 len;
 
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_lsmblob_to_secctx(&context->ipc.oblob,
+						       &ctx, &len)) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->ipc.perm_gid,
 				context->ipc.perm_mode);
 		}
-		break; }
+		break;
 	case AUDIT_MQ_OPEN:
 		audit_log_format(ab,
 			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
@@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	/* scaffolding */
+	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.46.0

