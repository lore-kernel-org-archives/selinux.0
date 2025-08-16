Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C572F60B7
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362527; cv=none; b=ilOkaFQj0G+buSfbIMdfT3jf7SRp6gR4dxBuaq+wpuTTenqHkw8PReJcU3mot/69AtBv8zqjThwN7xNN3qW1zk95D2hQZwVDqOSZAhu+u/GBZKU+OXoZRxMnBlH8Yv+/UcafMVFo5lMYraHdfs5ZYrZbSvnEUy7X/c7Cwo/AJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362527; c=relaxed/simple;
	bh=LdSH0wZXA0d9ZO+V9BqGuMWnBUCrEK/3MhTgmFMbuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8mGgHZ07yE2JGgHZL5FeYDXP4l8MjkRUaCaH2I1TLxH+7fOri2ycDlF4vv6rLOAd8zM0dPpiPVYtvJRg/Q8EeurtoGSYGtJ5eXn83Ib092MAM14uqJP8RsIukgttIQw3Gj9o2aoM6Vhs5P/akjaN3mxDgnsfwMZQ0rO+y2JZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fzND00tT; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fzND00tT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362517; bh=D0lcggDIluX3CxfaaRR5GM2Q348797+wJXjQGm4ExYY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fzND00tTwqvQQj0Z4sB62wJEF+MNwfas750XEwQuZ7B7PxkKfqu2ZKXRa9lcoTiwsM9kpwFTEfcbDBSy3FsSn3TzTQG/9u0rcSUBepzHOjoRlpXROKG7Ia2fKEAGgAMnHbINxh/jG2SD/yM5uOW1Xg/Bq0KbDIF8Bb/KTTwTXsX+9hb3xvHX7+Z6JLNHhQ0II//lT1uInGMheYZ6WzFseWHD7Fi5EqugtQZQd2GDjtqnuCxtalkbSIkV4inf/e23yF+PvjJ93VdJEXooKt/3mN4BO9+o7PNJ/aUw93BMFhXgnmthLRVLDIHC40xvC23ZEqDR1xubWfeP91Ha56zl5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362517; bh=iAYOMfjvuoRciCFSqB/hofsrDh8lNHnHo95pMviXXuK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Z+b/ZJep2PExnm1+9XuaxnwoS+XhcDG2Id1JXaYMlplnVCZHK6pRJDeovL6kRxs01fI1lK7GloLrBifjpX2Z9UVRbBUB3NM+Nfp/Iu0RfpsyLYCUZIgwTyZltbFOSBHL9AHeorfpJhqn/W8F1mm/vjyUta/yHDAi2/ArOj0RBu1Uunzj8Hs3Dhn6aqUSaMGkyIfXj0WWNIJegXyzLQb7r8ZKlEhKKmsgO0FVZ5ouf1TjRdYqMYNBpeRQq1QUKsF2iuj5YQBE/Y6J0GBCrNLN6dThvuycHqL1OQuFpcyEcybklDqvYX/8cMqZepJ8LjW7EykgAWCGFD2yA4Fdvn9yCA==
X-YMail-OSG: njfaFDwVM1kpElMw3IxHcCdSmMk0xxNZM8fo3fmoe4rb1yVz3CRicBZeGgJ.Nli
 R41nJq37h9.OatlgxMLXI6JQrvUmE_W2Y9C87JwWMC6jQSqor3iknKl7bigDKbMIExVFMCQeI8oZ
 .kvFKBWHjIE0O_ydfvw7mKHQQYhEYYiWxI4j3zjMPjJJlH3AJjRu_L6zWEp1Y6icXjATgrOxe9h0
 yCWXs.Ukxa17qeN7PPgpRmIEmpFgME5xfQccfmLvFai2.UNte82twjbnfyts1JKgZiq0vrVo2hci
 Fdt7.efE5XbCyh4uCmgM2ve80av4oDPQSfxNYmvl5ryLLizPpkpUiAiAYENrHnY.mqIP5dEBDwmm
 DC6kGOnukkdzXiiZUnj8vJG5zfp_jaqCrhKyUCFM66x6Jd87Pqg.MIs.aWPbppVZVmynDrF_C.RQ
 t8Tvbz3LHXWreJ6zwNq3FGb0PDqw83jql3CiG4mhCdymjOebRtbPdUSdE3iqMu7NVFc8Dti8ZZyp
 RuY3fnTmrT6SPB_LfZ4atTNrwEcn7ew_MFjvowhSPYAJQSdh8xSGu6DJmkS2bHwyZHMWDklgmv3J
 dQI_ze1hBOjBTfTdAFYhhDYpeNFOJowLpfb6cUuyz6pZRQ18P4vkuHQGrffer0jWgNglvVMHSdR3
 Ir8x6xoTPr.R7rHUweutq3Z2hMM9OjHAPtsLKa0rSxHbSsCXv0gr3DB7PEwjlsiJy1AzARFR4Uco
 GvGE.Wo9mx_G_BISX7JvFElustO6FnBlpJKjnZipNdQ7muGAkbzLPfUPWBgnHSRamkHdLVKvwAr7
 GYczr4HmQzUw0rJ31fcT.3g822AGPJ_ozBGX8caabYXFfcvUKTSfJ7AJdV4W.VQP.DOvaIF2Fj.k
 7qmZSQ.kowjjqSahhkv6Gd9OOyGidXMkCyaLcfJefA8vfFhxQDs8WzddDsA0U31scpWfSlXGdwf3
 4y6eq6BvP8rov6rbqclmxBoQ01LM4iYAYKrbgUDuSgsCiiwI3aks5OsEyD1KUZVyPqh_god5atng
 iaF5RG.A6Oe4YF5ekF3Kbmvob.0FVmEdB804umCOXz7M79oWytusI2wa.6xxDTdDOHWfRIatHOLX
 jkHWj9uF32g6TnNrgi__iQShRwNeDZscyQswRchOHoH4fGp.HZW1gtYC7KwWRWnK0.izTm__1L6u
 IkSl3AgAyxVHuH2Vm518lR4YgGBScTV1cUjzR0oiIyE3z._mXD9pMrEyytFyATmML80naRINbSaT
 qXDGt.ZvN2T81Z9adpgdnC8cly_prcVrkKq8kDIoacbb5NfY_7MQSYs_EG9uSymwleauk3bxbgsk
 _xL8kyjcvEYaIpii_VoCF0aHt.JWYKuPCwA4ZARwGFtjNa.0N8.8K4YHNClWg3NpVEcAKzrBdicu
 SqwRmDqt5cBSSEAqmHkGbbmFWmz.zKR4IIidlBPsBKTssQjL4sVJz7pxnF4.hkMb4A66E6BDLT_q
 P7BmrlsKg3sJmQSbijQcM_wO4_pOR9n82o8CCT5VbGBzelz8DV_DN7lL9ZuSoQ.Egjnj.TXqdvQ4
 zM31SrREFZXB2TEHFNPAeJ5AUr5edpS4zbEsKBt5xsR.DCNKKLb__ZsSgJoHRAcvf3cRM1sg89ce
 QSkQui39D.Eq8l.WlR3k_018yARydmAz10lN9mk0TmK_f24OnOKntMfEZtvvdFPduDEhSec5pdWz
 O.Fcny7dU438ogCBZ_urRWVmo4bY4DktKsND6ZxhFY0ZVM.PuMG1CO2So1mUXsYHCy0Q6B9o67yn
 EtXqmAaoRBoqo4ZeQbLugIyhy7XjIcRxqgSrN700zj7ZMVwahlxsoETfOy3zjjNEabc7U5hIq2qM
 n0osCLE7wsN3aufQcy.1eLjr_QBm083RXl5c8VZdEI1BAzlb.aC1SgqKmfo1ES4QahhLAM3Mz4aW
 asRTPQrbt5Y2.80JMIf91GheFkJB1M398DSZeSYiydSbpO0G7xOelVsaesUISYgpHiynimXBEKaS
 hxpQtbwiEmyWoET69xxLy.wLasEvZDRaVpssFQuERXpOHpEfpnvcQKViPSQXgVSDgJHK9Cpy3gM5
 kHVzuNDcgF3gERWdbMFJrOiHFGNU.T1fdArzN.5MHdFMavAeWeKT2WsYEmsF2cZDUBHB68ld9F0L
 mLsqNNGygPmLmNdJ88EBe_aJSyC_s6Q4x_VmoeQtQTrda5KYOZtEDVGErEftnRM1trRKEJQnJxgh
 tnR28nOiFLuIbaIISRVP9zzDUakgCtrQYML0bdKsIRd1waU98fTM7MMaGbQD3owO9FIk6O0LJ8YT
 wPSYvtGZLKyXlSDzEsInf1adK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 27f2f0f8-8167-4224-b0b6-64b5e33f7407
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:41:57 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:54 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v5 1/5] Audit: Create audit_stamp structure
Date: Sat, 16 Aug 2025 09:41:36 -0700
Message-ID: <20250816164140.6045-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816164140.6045-1-casey@schaufler-ca.com>
References: <20250816164140.6045-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 61b5744d0bb6..547967cb4266 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1833,11 +1833,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_stamp *stamp)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
+		ktime_get_coarse_real_ts64(&stamp->ctime);
+		stamp->serial = audit_serial();
 	}
 }
 
@@ -1860,8 +1860,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1916,12 +1915,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)stamp.ctime.tv_sec,
+			 stamp.ctime.tv_nsec/1000000,
+			 stamp.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..4d6dd2588f9b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,12 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64	ctime;	/* time of syscall entry */
+	unsigned int		serial;	/* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
@@ -108,10 +114,9 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
-	unsigned int	    serial;     /* serial number for record */
+	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -263,7 +268,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 extern unsigned int audit_serial(void);
 #ifdef CONFIG_AUDITSYSCALL
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -304,7 +309,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 78fd876a5473..528b6d2f5cb0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1917,7 +1917,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2039,7 +2039,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2508,21 +2508,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
- * @t: timespec64 to store time recorded in the audit_context
- * @serial: serial value that is recorded in the audit_context
+ * @stamp: timestamp to record
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
-	if (!ctx->serial)
-		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	if (!ctx->stamp.serial)
+		ctx->stamp.serial = audit_serial();
+	*stamp = ctx->stamp;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.50.1

