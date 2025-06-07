Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0118C31
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749257508; cv=none; b=cAsUQfwcg8M+JELYWyviAdVVjnT6Fu4eyMHxN8wu0vkjQuv37Ed7McRrkBhSgLRP9NJ/Cpe7O32qdWLfQXR858auHUTlFEdshBYu7HQMddO6mmbHFgdd4tkG00+R5L5P6YKGRYcs3XjcM/6agKLrSwnSWJ19KiNG4SkfND6DBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749257508; c=relaxed/simple;
	bh=2pOezyS2qZSc5TQVN6o92sO38Z6T9iIfdEifdZOn8G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLNuGhb6TBbnx1sO8KBod2uHiy8bkc02sXS0WVWfw5SijgH4r3CO9vWPkogcxJyo3svePlWEX1ZWzIqgc0p2jnTlKSqMyvzzYQuNbogi6/LFmmpOukSO5sjH5vlpw7vnaf1OI3mAifCNvMfNmfFYwrlkMCSC/LjNSGVPxkFnbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Gx23wNyv; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gx23wNyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749257505; bh=ztbvXsukeivLvQbhQeIQBI0l9DOjlssE9T9GW9VTq1o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Gx23wNyvhnqsrqyNKoThrUa09uWArZTFjGFx+OzGiAuwGqIxsM7/HTW87E9eRNk4BhEd07rEutF7s9QazbJ5e49o5ZT7/SO6LhbaW/wnWpxSr4lA0zbHQlo313AeNsPBJ/RI2QKdFRQS8srmcwiyveKVYwazE7lqJl6XBNYo3WovxhYawrgkR9Hc76GKPFCCbZ+UZQ1Yaw0InUS4TJpl6Y754r86nl2uXdo1MqRPoUD2bq9qVpnKYBZ3Yoi9lWY/BBnzi1Plw77A6J/YpYOB89abTxGEABtFxd4qhZMCz3L/MMA2MWQnB6OsuNXyq3aNlFsaxmQdXvROfLTnRQox2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749257505; bh=CZt7aJZlmfbjhZZ+sB+H1ocFquYWVoehBvoESd9kWeC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DX7rsuSGa5+GBHWOFkDcSXOXA8csdHuP8ocOF3F8xbCoMTYIrWF95aCfOdN+mIiMActrJ22ICilp2mmK9/QttHJ/CG7NAswz09T4CFM0jRw9DGHLfcD5a7PZ4f+O2REsQvwg9VAt9Ui9gPiUO0wnHyDSlHVE2Ti8dxpyz7i6+tF0BYE++c7RwOiFbkD1S/czRgCbE/pPwWlIQn2RgZvOGLHe3Z7O6td88bks4D/AzJqYdhWk0o4dIlUswMy8f9o0ax+XJeW09WtfkZ+JbmczEhoDz8sj28kPUiV1qRjU7t0ckD0at6EtaEaAg9OZshO8O+vCk5DWgCTNUfdzvxLGkw==
X-YMail-OSG: p9HGJPIVM1k.yY8zVrgLB8q2oDhvJ.E7YrXSQvM4IYJ9_Ou6mFFfzbv2d9pBCP2
 AcVEWwCJXmKQBs9yS1N5c9m2rOLqbwQrtcthxHnXI.AfpzaOjoUmL9iZXO_yL5r4b6xLnFo8LUkO
 3qO9KM6zLQe0nwzWmMAA_qSVgQ_1iUd9VPzamvjIkWSqYMZ2i2itr2d6cN27v07ASm5kYUnHa1wq
 JeAKulMtkAnDVNNbZ9pfIpxeOoSO_we.CVTUUgd9h_YzkwjOjxTQq0qHY4gKqz3sbrQKrK4ZY8UB
 1N94qu1lgQBs6sGWtnzA.y.KfWe6zvdsllkB6T2T0e2bjzTjPdu2iZPfQ1vMe5MH0udvfVM5YGZq
 nvPPoj6rHOYB2s5uouIzB02h0HL184BjsxC.N33_eHJGVkB06k5pfXImubmgqPvaN0CUqX4Uww9t
 Lsck_aOqMk1teqXHK5eRSpjsmvk2.gtyy23W876zV8rPIJZoejwjtNmqlFixKYxfs_Wix4Jedxbr
 9P5YbQXPyhK9kBV8dSIV4hx.OWITamPP_BzRMzGMvZupiPRY1Ur3GjmOkAosqxMSkplmHWtrdkon
 Nt4XCpa0pqF85UDbd.sPpQvnOUQVWmH7i82FzrsiydMa_.MWk280gqDS6CbGWnLwIYxeafq58_yY
 Cm1L88_jij8Tqz8zEKvaAvbNdRQlXw1IySPF5wuNgAmoKIFV9DCG29PQHVOOqP4XUVJqCKSS3Nww
 cvzCbvlk6g1DmC9rjTCfiFen7aDSFT0sWPK2hS1F7m9ypPrIu.MnwAIQ0HroNE.GgNLvw_cdn4Qx
 MpFRHlUz5IHAJeHazgmMF6ptWyEigtFlwAJVnMqHnfzBO.iOA.BCewDaZ3mCET11Q_JFFxa6A42X
 txQo2UFSKv96rN2BWOpR6AkyvkCZI1ZqPl.jW9o.cJkDJWVg5EwM1GMvNXFw5LzABlT8KHs7J3aq
 0tfehKsQA9N578S6oP8zQy3UGxB98CRdZEHB7ZOO4O_Pjev8LqWqQv0UgbOGOnY6PUTDC0VYmGpB
 ycJth7UNByejyJ9W9F8LOjE.cYPQ2K4BIdxWZfB9PCnQgeLOCCEbMH4_ba6LOd7AnyasseE6pwbo
 rgZTxojRGYbtVZ86ElBN_RhafGnc80V7DroTAuDFW7Mh718Rs8rBmxruc2jDZSmMSEfqzEI_F0iR
 q2VxEz7PNzGnXZDlnxquP00h5woQ4FTkHzoRDCOKPAgabLYT_jeQeSVxQtS32cInOGf6eJgGJQZp
 3d.c3bILshXC4Ciw0dS8ETy8aCD_EWmj13WEIEBNY6ZWfI9edITLtTFGyrTK2kk0VWiu6wdSmjna
 SlbLTfF0CyqWw_9s_6U8j_WmWnUT3d8Nr8igCTSId982ljBP7XNHUD8u6T8AB9t6smrLwUsFuf2O
 xi3pGFnlZQF8IKTzR1S57JXQq9FhUoPF3xaLLjlvWZ9DtYsruZQIS2ro2NhqGhxyMFs3inwHTeI3
 kUed.TPAt.VXA0fLzcZtqfCk_e.gkvwbvYq4J68rnbCv4E.o0WN.WhUeQ.LR33khJxGEd7VQuoJ5
 .OvpdjyEn_fjMUTAH3xhQVZyidq_3o1TCfeLXtVyk1P9kyCLgG35RhFMD9HVjkBFCbbee4dJd.8D
 ztTrAcHR9PcIozMEklyhXfIc4J.7iTFxqph5lNQdGpg3xHO8U9bksPGyM7sgydUO6e8kGxXEPCjU
 mybGifjqpka889u_8pRbVbIPARrSBotUCouAqinplRjflRmlQShH9CdvB1kFkGMx71uEGJAQPL8_
 ZDej_tmTBAAMOQiyDBMaRc8NrWE0xM.NN2hy7v.soOYiQYvQgZFuweoTowZ5m3jlGhZ3LaxNWgKq
 9gXV4EevI6FnCNTd0.uq0FpuKvdkxXRWeeHmb8jVDjh0OZMb1aGu.x_EGzdTlR_y9NXA2m4K2nbL
 Bz9bJ5YnWYtCeM6josv9kt9S9VQATe6iR45rky9Lz1kxVFjykLFD_9QM9Jl5ZpiJvuNFlkV5BDhG
 5.8rxpkH0JJy7akymbr1tTH7UTuLEjs06yBS2GseAd7UBqbosaoLxPvS4C7LgiJ2f3bEIPfUcd7u
 pKEnKlKbVa.Fq5j8eoWmNTpOYcFGKbSmPJgTQqkLjS4kCUCBRCHWYjEmWOyJteVSlUjh7Ae3UbJi
 ETAYHRRTqthj5fNhWgwuXeiVKMObBzKICjNwNkE5zVKDcMKsBRhbF1U9a9qkQN1DWRvw_fNlORbb
 bjf.RrfnaGHuMAgQYYmQexdyM6NvwxfCgXzHANUR1iWG.gag.85p7PPq7WkDWtDr5JVL7UsMukOP
 rXPfhNNdnNEGaFzGCtXUqDfR6ukE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 95528723-bf9e-4362-aebe-92442b848819
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Jun 2025 00:51:45 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7461f2feac0d1a8decd03521522bae75;
          Sat, 07 Jun 2025 00:51:39 +0000 (UTC)
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
Subject: [PATCH v4 1/4] Audit: Create audit_stamp structure
Date: Fri,  6 Jun 2025 17:51:31 -0700
Message-ID: <20250607005134.10488-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250607005134.10488-1-casey@schaufler-ca.com>
References: <20250607005134.10488-1-casey@schaufler-ca.com>
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
index 5f5bf85bcc90..2a567f667528 100644
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

