Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326E1990C7
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526346; cv=none; b=p5HW6YYH8Z3qKXv2wgloLa1xFQh9M57NtdM3lHYNn5GCmPJlOik7VpIKYiQZwWC/v3x6uzQEPOhH4ToYYdp1ZbrGf6hz1Q3FmffM2vjXrRf3oQcEFoyqesxJczKaLSK7GPggoBz5VIXaJNQzf6WFuwfWRSreINDq0qp9HJRPI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526346; c=relaxed/simple;
	bh=foLWTmSFbq1rceU6d97FGgq+vU1w14xbqY+Q6ZfnhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtUS6rcK4ROVL86lGLghvZ+KPrKHuwlr5eXh147b4cGSsxBIL7uPXU0M7cYXWTdkJo7XNXnThJkUVXYfj0cZzwc/E9ml+/AqKO//CtMkxR0VwZo0FuCW4cu3BurTolvUZaTjHWXK84590VkEhZLyY+njugTPROEm1btXWI922Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ES57MrqN; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ES57MrqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526338; bh=T735gLFSu6sJJ+AgJymFISZ7osZRKKZtK3bncmGvTo8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ES57MrqNxnoLffIN1pBgiFojjR7QYomvo50gAFLpq208rMqBq0y8aiQ2XrFJ6wM/E3WuoGDW4r2ZtuOaI//1LdCiAA3x2z2tV3xAo/WW0xcJrKuJC8KulUpJyapz8ydUENK/HBonUTmvgWOgCP3FoEnn4a0C7V3/wYaum8nE93WQI0Umlbg5REm5NrZVpjwnuGL70cuC9sqdc2nHvoNeUdrk9McrknaWPNRmn98F8WI2tUxZxJqplRCaN17J5szuXVDTIo3v8oEOcciCnPIr3rrE4ECjriuh47E0E6MN26SC9ZwvFS9aVvPEO632vig+9Ux6pJBkFP17wJhdWxYRYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526338; bh=uV1apujUxPf8zIpPvkxccpYmCVi+UCf+UegtfPdhbJg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZgyosvMYGyjjoZlnTvvIobfht10cZFGdP0z1+pcpYLMGf3ZSZ4eGwfoIimFPB/KRyA4OchgFghV1g7eYRA89oT4XoIoSiZ/zllYxeRMO8tmjcgdM9cDoRUzoUBrEDuOjkrA/Ba5Yr+S3VXN9QrZTlhxS1GNXBmUAEi7IrJ+PGfwvrLEcgUkiw8rgmn9ytolGn/1J2kTdju8kc+A4tJadQyWmUmKmD1Ka032+BkJKAGZ6JyXWfbwfxYUFcs3H1cXC4hsl+V/uhVDoQrEb3OW3i1/85o17Jk9AVta2JEHGkkW5Wm/Nrvf+waUS7RaYG1WfQN8aNGQaJqeR/EGVYGjIOg==
X-YMail-OSG: liHcFTEVM1kmcFAJD40iGPX1rr25whu5qcuEX4rvVl4n7i5tBfU8fW5Zwjmys_q
 tlzP6Nsibzb72PE.dwJRUqBKrZElIHLqf.VfXxGe8hsInizleOBQQFDWw0MoD1mf5V1BHTUBsNX5
 tfm7A1FyDdv6lQwLTfonm21BOol1ITu.BR81uiz7u1R_dFneGQzVyKhOA98KiS3pKuGUxnhTlyWM
 R69WSUvN944PG8WV.NKkJfGl46wu4pKjjYWiLLp7R7x9Kyjozx.MrmwOnID_RpL6hs1CsTzYoBPv
 plFK.Z8AjwzKbfgenHx3aBVyxuQaeuGOpTjls6xgEYoQhodK0GsrEDHIondj_Wk5qPSMUvyw2PsI
 GOtSKBDp70YoIck.t0QpIOleJmKA04gfl2.UQBoo80SJRz0yTU_q1KvZ0FhFyvBs9DsntI70Xhj7
 nCM6fYsCLwP5kTY1PZXF_F7AuF97DHrogzR8EzcJOvingUOB4JZurzscBFkq0IuCHIDxe4Gpu_4L
 4O.KDDrEHfxlEO3K4teDe_frXJpgEwvj3_UZ4YJYr_9s17oYPI4xJ_fLxK7QOjxGPbCHGCSQSNh1
 LjNkCHk4nrDhLWGZSf1v8L0MHJqgBfhrlvU1Ze4dPCIyh.Uzr_Xn_uQ9wj5n_pvn8EQggsj5.osX
 6TCZj5roFGdF7IWaZCyIWp5qnNgMgQG9rdY9LyTxpBKipLjDN6KVaI3tWO6_ELxvWtC4zvl6THxy
 WHtRk_pSmZ4Ly7HO5IQY2VGYlZHUyY1vW9hpSRCJTCfaRfiV90BjwghPaQTLG6gSMeR90cRxAJ_l
 5iChnY.DFPRH_PIm9phX0thLFSz4Dk4D9Typ7JAQcM5P_neZRb3gCsmm3r5Ld4ffjAR.I4JgjJpM
 zoLQ1BrSClaFLfDXUMWVc_FXARCUAzdtFOHRXCVmOzaZEM.CMASx6J8ngiM6TccDi.sQDBY_aJvn
 hQhLMW9j.bmA96Qb1Cf.viRCEHs0v_wLAk.B67f3DaxmjQaL2RKbPSCzK2lrGlWuARxNjGBp64u1
 sXODzl72757sRqEifcXidKKjR_GK8wJ6SzHq3SAvbYJaFM6RaeYm1I1AK61ypiPng_hCoX3beKTn
 osL64ClNOX4NmeGc4rYYmzrRmOrVV0_OJrZs4rZgGbYjQj1f_Qpi0.cB3YL6zR1Q0_2rbnPXRgjZ
 LXYtf0VLMxvx3mlJ6vIkM30zTLV3RAkkGYVkDTrq3tKr7cf0JeF.suy7rO7aH3fjZ5JQChfKVXUR
 qgFmJOPucmN6AjQxNR.mvNYqu0SsIwqxOvAsF8hIxbGTZ2xZMjiou_sUL5JtkBboGej1D7pqI8jq
 yp3b.TtBpoFW8wv1wvld7ap.Y0Mc4F9H.KG1tvcMZxMM8zr6dYuckOinyqavLGxmqEKJYM_Taru_
 jHdZhVCE9tYBvKANWAFZXZ6tr43LnAp3.iUkWNLsKvkkf3wouS.uwl.2RmNDc.doAbREGDnR2k4a
 mUVVqcuS4VS6ZH9Qaw6BNOxKUFfu3bHrZSfkVX2Mirl2uXjcRklKqz3znHb_ekUAAV9PzvZ82MBt
 FUgEs8ZIJARY5kRBZ5e.03opBuVw9aRfbY2n2b84GrsamYrFGc4..k9aj2u2eLEUXZSCd7yBsyx8
 vP8JsL2yZEiaxe4dKTzV4DzuviBDkwypbVe5DnVX1QdnT6qnmo_IczIMbMBCmfY17HcACvT4y79X
 _cOw6hBcz4uMaV3N1nzr9C3kBI.s6O1aSF0WEqseXyqqEznTi7DPZGNp1SuPPcurMD0aowgAZO6p
 y4UIH.hDW.uTc7vG6bP_aXT1X5rBx0hTBQpBJXMpZveHsTVb7jIieZ9DNmhfzahKfZEUbboBF8SR
 ruDMBacgDwcjCBEgvQgtkkAJwpnAd0Sg_LRNJUgr9TaehWNPDMhQhkNfuKcSj_oafgP3T0.DxpyV
 feA0n3XSwk37zYIAOFlnRbJK9hNcaluZptLnsZ8VpIuVi1MsEufGflvpk0hTcBNrMaIqampdRYhV
 9y4Hwum9Tlj8Trao4Q_LR0UvFCPqFXqoCTtaFgohjqVYJ9wgvlJv8K70w6YrBpg2vfpxtfQ1nJ1C
 J32NwONX0DQhbYRy_zQygMOHbvXklnzEOMsBtpeyFOxGXnCDoPQIe01t72zITv8R3CvSmv9iAbON
 WuUdYIomT1EoyI4KEWsqhSZ5TVVDdYMvYZFiK3dhyBnKXNfisSkvmXTu_mvECMa1rFjZF49CSWpZ
 RN6.90SBoBqBhO3woigdfi8DQso7sULHSByXboGjFCUlb0waB44U-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b4fda604-d86e-4f1f-aa37-c93c0e6ea58e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:18:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 250c349a2671887e65e0396b7ea9bbf4;
          Sat, 21 Jun 2025 17:18:55 +0000 (UTC)
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
Subject: [RFC PATCH 01/15] Audit: Create audit_stamp structure
Date: Sat, 21 Jun 2025 10:18:36 -0700
Message-ID: <20250621171851.5869-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
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
2.47.0

