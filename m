Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6128FAA8
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701275; cv=none; b=OqVDgCn8K6QY3+CS4l9ct75+8BG6j9v1vyFTjQdTfRhVG49KgTlgCWa0TFNZA7frqJpuO9Vh5o5H9RPKlOF8aTA0m3r2wpnD3znvutsD+y/zckT0jTbSSIUT3xmRwg2x7UtIS+VBVcaaKTV9nSW5f404WyHjobL9cJXpvRbj8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701275; c=relaxed/simple;
	bh=LdSH0wZXA0d9ZO+V9BqGuMWnBUCrEK/3MhTgmFMbuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjQa022W9myZlBFVi73J3JBr8a/cLb0YMhOtdzXO1XQt9QlJvFTEdm10UCKWTE0vMZL4hWOnGTH9ayI4TPm6XeWIXj2FClFAkjouxHkJC7rAHf33iYbhH0iyRJuBB2a0nAxtLEQvG+Y7ZdKUDaZupJw+7zWiOqVDphb/PxT7edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Z3gfBHgj; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z3gfBHgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701267; bh=D0lcggDIluX3CxfaaRR5GM2Q348797+wJXjQGm4ExYY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Z3gfBHgjjR4jO91A0/ezMKKGnpO2zFSVjRqIwi+bQz7EyG+oVCp9mPW3h7PIXFQTIt3q+TwBq8cIgenbWS7cfet52SITskLv1g9FJwXXo2un6IuHU+Axn1lnsipUkykYgqGAGjG4R7hno131jDGNJEbVh+8A39ywVEMq1bOylQKLHEiBukzvgwxCirCAgJnPgLwBWjEjy6TnUCn/1uZMttWcK1mNkp+C8KZcWLQuSORXaRVgkg53eaqaIDAZUIJyG14/aDvu2u/cuPLyJfE5nCIZ7PHAubrGaIw609Huw840+i/qnG5tAUS5a1i4CmkoVgqP22kQxnzhl4XrgR/tRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701267; bh=YCp60X/e+YOn8w5tyIx6cYQ49hNIZmz7B4Y0KybJQfL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BrJtxjvQNKLS1KWClBIfC6WJrf9V7KpGwiGCrD6w/IL2N6VlIIL1MFATHbfTtXDgG8sXCQmVh6FEErqSGRh/IykMsb1LaYpMK3qAhzHKFsyTQB4xsfaHCttFijPfNfnSUHk0x/J66Ho7mh50jO9O5QsZ+O2lS/BkxYq/6/+qae4Bh6MWrLHeJbjA4IknzoWE3kUfib24GD7Sm4ZK2BB9LxqdgZhhlViEUvP6ybo2xZ54831Ghvv7QkMSD/uis1AJcKp+GXcd6CBr/uKIXI+kXZFtVOy0/E1xLsI5MIqtm6YJJeSnCJ8fdQ2CVHwwf0R1/1TdDEa3yoje2z3jqQF0bw==
X-YMail-OSG: hnQoc8wVM1lP0S6rCb6t5NuhefHCkd.aI.1ehWpXAXK3cVmoOdiVh8dn_kaIYhh
 VVlFAUoO4PUUySBCo6jSj8.JFHSmlUtY1PijaHSbWHi7LE7fPOaXl1LfewQoDRj4j0Of7P61YXEq
 yeHTtnvJkQbahY5uBbe9MQ10VZlYChsPSECB78XAK.4497j8PysyomfWNLSQJ5StJxUTPNuOO.tQ
 PnnBgrvpkEoIEHyDhnoHSRa4v3bB8NYv3gBl4IekgY5mDVkB_3aQ8k2z4ZfJlQDbLXCxyepr6dZH
 vWohOV7YdVacHchNOCaEVEPxppr4qnQwWVMnpnDtVQi5uG.AT2Qdh6_rsPzF2P5.4Af9uVdYeOcY
 _HhQYiRysPFSgCiDVuydkExZKcPp1NzPgaQophCKQrLO8RLmQ2Rp8SPkbwGKYDqBDejD8OxS9MEH
 lfcTjCNubchT03AxbeO0G2cesy8akcjuqzE0p4HzT4RGxJ1iYn2kC9CCe8rL0gEjcQcIw_Vybcjh
 cmSeiD6.xSnpWM_9zXGuJd2U3LEvmUooRQyawLaBhj7SETtDaUSGFeB60kkNMOgRMkj4tQHwolqo
 EnHUmP.2iLVhgSCuv9chf1PMNR2OnHaDM7CBPlrqm9ETlJGv4AuID04yhaJFnwkyFtDdeGNyPBHD
 wJ39WdM9MEGrdN4aTRzHWnYsEDO3xqxtLSJzkdXZCFKah0fdqEaE3FqCbKj8_YL3qUDsAIstbI_3
 FzUBJDgxzxVsD3Nz9LZme.xM2bqR63KANUBRIZgJf7gtE.ggbQ9Pu9xRhEc.zDJV0JTxhDBJ6xd9
 QUpOG6vk.CUSJJHqnUIqQoOBWE_.kTrbcOCMXBW2lNKrDgZxIwSXZQ_JwDIKTDbv0LohmpzdmAGc
 1Z2dL9.RtM78bTlOD7vpxCk6aST3DCZgc_uJPmO5mxip9rBUOPwBU80rWJIy73sQosrRDneUtZyb
 n483sZlcIXDSIZg1fXKvvvtfkxEIj9.kQ5RYwToN.Hbbd_fVnEJB66HkxnsukGvHQNjynM7JDQkD
 SMh00ZvrtvJyjZhYMnpwidzDeMbiQaYcE1qgc_pME0KFZbMgVxIv_IQhk_c1bu4mNhyhkr.91g8G
 El7Zs4xo1yHtmr05NlbkoFHBqTn0kwIgcMzdwH9KU.US1jEn5CwGb8_vhCA7wEGKmQUBlyV_uB94
 YpRI6OXyYWL8I9HmqD4lh.bcvUxd8p3l6o8fgcZvvq03IlUdbEAwgV9o.YmifpzlwN8l.JQXPhro
 Ova4Jv3.JaviszcqcB84eATdqangQpRFgPMKwUof5.ILYeKYq4iIka_5AG7tgOHRIT41hk25PY0K
 X44tfVe3MQWDdDckPbanjTkiEPN9m5iGNYbME1fmNUCU_0iECugFkT1R1zZFJ0jAHLeFOwkJceTM
 buK4VWKnYSqH8_l2slheytxsFkexNJltFo9nF8pFvB8AosSykjSJxxyeikZYjSn1.hCy913HYdsb
 gsLJlN5MdHM7D4JhQ2tScdI90lnvXmCDpFdm9w.6FqUJy443qFmQYi60ssYESdwbbQWVOHQ30bV_
 fy812eDsl7aU0SN1PquHS.0.05PHtD3NNpc67r9xIXrfpX.jNYIn2koCEa_v3r2b94OsQBeXD36I
 DVVxPqmUjzODwYL.AdgMC2LTlnsHqJdpVwnDCkbl7yW3VwaJhzzFWmvfHp9fZkVjflmfRh7Hsx40
 6Un7.ENU78Okj.4oDYL_bTTAPsqL5ptVxRlJavFmIXRksZ6BcZ0bDhuyiKkNDZU0RyIJq0QcDiPE
 n45rBn_tslkfICQ_8JoLXVKfHAmZDivcEUNd766Zdl.nQMAkJHe3UJmwCdeoR_qkT3p3pb2KXf2y
 u4mb59pYFku7AtLXRhgwD8BxnWtckvkavjh0WKXW0bc.gpHpPKEgqyeNZodiU97aXIea8jlhrdGR
 xqwaQZbJlExB4wwS5BLrzKHQ8Ez.hOufHFIOLH4Hrs6diipJExNHtO6GhejazCR7Hy1P0QvoLMoo
 iobyP.V5SY1Ln9VzYdtUpbPVwvsqqg4T9WI2qM64NvMHWRxvSLJsQ3TzX7SXHKap3S5r1zCdXcl5
 _HgIN2pBs7DEyhGNkBEtOVghh075S4FN1uSxTDDDfPg7KSU8tBTjYteHrHce6wTVZ4j7tYFCVZ.F
 jGB55gXRP44_bt0kX_2.revoDyG6vQ2tDL5iLTlAInwICJS_cioydtoFF8l0K0K4if26IUW59WFC
 7qcL6BAGKEV1dLi5vAAvl_2uKgbO7s.JQoSTyfrx99DCWjcU8ed8zudnT5u4CD2s3liqpbKBymhN
 k223UQqduS7kEP602CXtFDKQdDKHu
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0f3eda83-5405-4794-a220-62277a0dae94
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 21:27:47 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c82aa99504a499c14c18b1238d973034;
          Wed, 16 Jul 2025 21:27:43 +0000 (UTC)
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
Date: Wed, 16 Jul 2025 14:27:27 -0700
Message-ID: <20250716212731.31628-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716212731.31628-1-casey@schaufler-ca.com>
References: <20250716212731.31628-1-casey@schaufler-ca.com>
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

