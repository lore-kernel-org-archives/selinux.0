Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D1C433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhKXCML (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:12:11 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33091
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239677AbhKXCMK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719741; bh=QNUuIy+Q9ZpmqzmySzUSoehny9z7UaG/wqEe2iSuix8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fjBbxQjEcJcYw2c1w4lb+EU2/4uOK5+ftsk8T06Vje8K37mB/EtegEgIGg7eKA6MlNHb7U155vymYhz8i5e7rSaOOKScnM7rOAciuUNHocjh6zjqdrPj4hPkrtPl/zrC70rQHgy2d4n8QPcus6kbyAMk9nznQ/2ApZOThZPwqfx7pjHgDWwhqxl7cP6hOeZv84MVN9o8UDz1HUR3f2sRda7PJrnx4LU3aeZG54DBge+BXESuitxXSgDpvn1bXTSjcDN5Cmu4xOmw+tZWkX8mE1YZu0U06gPr/YTuMuqhdG0oIYw+Src42WkJfLascddNZs8YYAOEotKliBjqBlCjoQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719741; bh=IgDpy135jkWXFTFsiqcI5wE/1lj4zKtaimt6fxmYNDY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=g7FRqB5Wsl4il15d7Va8F322Mq6o4vV0yDSbt+xy0guOGwoxoJH33kStecDRtfFvVMtG7cbmeQ5SSJJhsj1G1D7rkQGk5EzxJdpvLCDV+GDTQNQ7tzRBkkta+B1Ir7dTBQR4Qy/BX8BjMboIuL7vjC8tu+BN2dkN9pyXncnd/TF4xVZXfRNJHjvev/bvLVbS9Xg2r3Z1a0iBmt08LclcW7wK9BxYCtdb8OU8pDIwUA8G8GGlsFDqWR0G2K0UPoWHnoVtUGAUH9fDApUgr2AXlChvjY9Z0J8kpK4MXJpsKWIMb3Lw2V3HqySdcETi5yA1No+fILAvLIr2BUxjluOWgA==
X-YMail-OSG: f.36IwgVM1l_p4UWsX9wTBfZ74XMsy.739wMmAdXeKOlEdBLsi9V1kUSzA_2NI_
 Em_c0vqmlll86KK1YuHv03r1l0Ejmg8Fi1A48IGmycNCTmYpDP7BT24ZKRaYGGUr0iUOA1Fbsmc8
 aCzEETcUvG.hD7F60g0qi.lBDacVJ_ooUuvF9JPdTnET5qC0nxuWrJ2U45Jmw.xbyynJNeQHs0SO
 YeTmbt5MsMQfsSiOPc.AeircjIvo802o1LC5J4rAZX0Bi_aeNNLYAvUKvP0Daj7at9xsaTf.0xNu
 ynXJSFbxm9NK2LNgkt3VYh59LLO0Luia.pp0SqoXMWKpznCPEJLK7Pwglec6YEY8D84N9b5nIkWF
 fmb8bGbbcYJS2WCI18A6k2OZwzwLGtorLcZW3Y9oUtV1CgART_K7i4_Ry7e8crvxuoXuUobLaZA5
 Ngq_V1QJ6QME_v1pt705bALVjE4Tu588hV.EcGik_YbhkA8XEmxr.unRdLuQMyS07QYI7bPNRMOm
 sRIvHq0pQiyidh0fu3LepcSKkePy14U69hUYGTPxAvm1feVeWWOzSWIdnhnLFXpl1bKxK3udONQw
 rVavPkI2J.qabuLuqHd0w7eKa02Z_xfeReQESkcIHT3sUt_TLKdjpG4_PZ12sGe1uDwTNQNf0u5U
 BFftgXSzAmdj4cX2Ak1NK5sKUvY45WeKpfaVmuPr9kYxoW33ZVvI7lJn6ZLxZ8J5cw8RnLaCaMBT
 jQSxY1osvcjgc6o4UbrAw5lzFNRpb5PpPHqUbJJ9VJSgQzRJ_12cUCnuwH2pb2F3kEitaFnTlCOl
 T9tv4A5boQDz1dKwJCuEvNJaPlImoRXkTo4Bds7wICi8R11BPDXPYLTlJkI0vNnES.Mq6dJ7vWXs
 4a7V9iXhggciLX3uC_OfvGVGfG7xDEsMf6slKdcfMmJZiAHMqbd3l8_do6O6fxWHiPS3E06DZws5
 CIw1msSCPo_hBsHtFdp_YXYlIa0mow7M7nf.YZS.njeUdpX6z6Mz4d_7cUyWcgxOneiaMOcCwOfw
 IpXaBCZJNnYCKz1uu0iFkKDUjL_XVEx7I0RrSbH0NFPMdgw0alfPiXPcyJgoUTsmVHMG11gMs02i
 uc0..VwWKmimZ2aprFXWJ8iAiBX.acylEHm9gwOUxYnAFBBbYnx24WmC15YeQBMWnPmtugZ2.k9p
 v0X1acSrOYO.GsI.RoN6vG0fAUVvFI4J7tjCcPD3obL5AYQk3OEM6UphHJ.CGsyr.SH6tAMriN0F
 atC8A3hk.kYYBavUZ4Ifoym8id72bM37Gpu36Xho4IxstNFiFNAEyAi7iUPs2aohnIw_sr3XoHPy
 WlbwAKYGknpuCDpt0QIpat2fd1S1bRIGkQrKfCvmdrjfX2s2bRwHKmr89vKaCFIF4NKQrYwWi4zx
 TanW366tSaBcw14G4vDWWzq_UIgP47tIeYncegW73t2zoRRGntMlLkpyqyF6zK1arENc2jUfr6dG
 H3RBdRaMWMIwqTMtJxHtwf5n2HVC71Y487WtcLYRCmINFVVsKk1s2NoKgLerEVml4GF2s7mY_e7S
 G3XcbEB1pVMCXsKd5TaFcoM2BQgA.EfEYWEeOWmfsy33kNRe106F1f1ZrWEjhHbebDap07vaulvo
 .HqShQVOiHrAzuYNWisb5919zUowK9sIE2CT4h871OUC28xfJYlS.tMxHvgZ1awaLzryAB0jEilt
 DqJfy_6MeIcK5wd0Z_ip1yIReJGOVOyiUGjFyMtp0zACkU.TE9n0m97dbwbeMIrmng45dUIppc6_
 qE0nnomxWzAqvfizENZImG5JBVhJs2LCAd86uGzy7SW6.UQrsnbKCanXrI.i5qsJeOYw50O_cCvx
 dvn_TXUze04KI6jbXkJUIWPvs8xrsOABp4qMFtSJ3V3a_cv8l1SXCiAA2h8AgQnNJ7J_9EgV7RiV
 6PIpmniio5pHtuYSJiwi6vS1EX1c0U01qlLGYFY5J8Zyfwrtc54qIcAYF1cxgTg9I9OAYAXXAqnK
 BWTyorLvEc5Tszw8_AFgxK91.zLiV1YCgpVo1muwfXQ78fsFb70LVXJAj2axf8XSCiRn5vUr5LT9
 .J6oTWsO5yzmOwfg9q2HGqiNrcbp0hpkqDdDKHhWNgrz4znxu_WyWbu.O.iPflQ6lyaWHBdZeqe_
 70l_Fih0EifsU4nhGX2w5kiLPTmUE27we__Dr1Od8umtGMIamXlHrHn2MXtuyQtyA3wJ5qxTsCDY
 0eSqZZs8ExBQdKe7f6jvuIiZqBv7LvW1AK4JhrB8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:09:01 +0000
Received: by kubenode503.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2cc95bb42913982b444d40acf5ef28ff;
          Wed, 24 Nov 2021 02:08:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 23/28] Audit: Create audit_stamp structure
Date:   Tue, 23 Nov 2021 17:43:27 -0800
Message-Id: <20211124014332.36128-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 12 +++++++++---
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 3c6e88a9ff62..069cd4c81a61 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1786,11 +1786,11 @@ unsigned int audit_serial(void)
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
 
@@ -1813,8 +1813,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1867,12 +1866,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
index a2fca1134519..56560846f3b0 100644
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
@@ -108,10 +114,10 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
+	struct audit_stamp  stamp;	/* event identifier */
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -261,7 +267,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -302,7 +308,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0d0351dc0c52..e6868d072648 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -983,10 +983,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1889,7 +1889,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2005,7 +2005,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2474,21 +2474,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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
2.31.1

