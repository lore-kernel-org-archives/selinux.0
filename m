Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B91FA14A
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476948; cv=none; b=YpEiTiyOBYnDx30SMooWY+GXZ0xiqYOMgqj3rEHcJiAPQ9ho5T3GiSemzEbrlltCxcfA5PTJQr0KhKR3zeF0vRmLNCwkAFwY7sxXOowTkFT46BlR3jJgW0U4efOLjZxJkI/tm4w89GJASsNK6Qpf+uBjiMlA52QPVq8A6NSq71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476948; c=relaxed/simple;
	bh=Yuz38oaRw9Idknb/CnHzV3knyNXt+wF/WpPe0XX9UDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7UQbI0cYgMP7KlPIUbBjlZXhWX/wNabErYORcU3Nibwjm6rE/71bAUP8xLNNny+UOKFE6Xk7aHh/aI1JBn6MpL+jGrGYGYfo7RNMfzSU70XtvfKWZhUo0lp0lkCGXsr1iixdH0Pp0E03ruG7C2SCC/vup32B6d6S4alH/IfhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VlT54rtN; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VlT54rtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476944; bh=lyJqxTnbid+EHXLFZDEwKssgzcVubmZ0EzkCB8fEBt0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VlT54rtNPMuqgf4uCoYPNF9VE+gM28Pj/vRB04nPNoo8FnoW2s+llLNSN+PA6AllXzC9Jz3QAopAVbh7KXmLZorlegPRsqmDvQtKgEHq6qJhmGGoYeInlnxP70kZ/9LgFdBsKezWMVe6k4BNzK7Yu8YXFpGdIfpf+ktgPs6ReP2FwyzLWJG50aUn8orzSjEb9GVyOTaWzQHdezfYJBkuorGwIbH7HxESqtD4c3DchVdg+OBYySkRvE8KqiK3n5jbABXTji/bA+npk51m+atrQQciEame6m3VgwnjTUUtuXu6jrzsR+RsZnQsrTq+hEGrookSkksyd5OIAmnxGBYTeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476944; bh=W+Mub/ug/On4xJ9S7TjZzqk1CjAqWy0MS4EhbHrjXrh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TBn+trPzgnZ57DCGF0xSRnHIc4lq7Ai8ng9E472Ah+6h5d0bwOJ5aPYiUEWE2+bVYLmlqmx7E/mGi0Tjb43aqmxxWjFkQN/SkkNPnTrWPaSCuCjJv+s2yQhyhG69xd8y966MnvZS5GbqNo6BbjjBXS9LjN9t6pC1Tf3BwoQFkG/RhXZOCt59hvxnBVOjwpIk7tWwo5wq6A+zt9pEDUB7FV6pw8TZNJMNSDvvsRPxtMiCcI3V04URMWOuV5/9nKMiaFcgmQ74z/AjIaESCmukXcVOqwwKcUKBbx+3p8jiG9I0hus4+lf2MrnnevpfgdOJJW3YEOtQAci49yA7qnG+bQ==
X-YMail-OSG: NZS89RwVM1lFKIgSFinjkOrUoxS.cKdjBj1lK5IySsDvQbZfN6KkzToz67E.Zb9
 _hSnxGt.Bft3unowLyYJyUVmapUod2VKbI4aTcPI1NVHhCdRdIp98uWsUf7tGXvjYxxQwxdcjYAl
 IXYybBnSk4UkzwD_pXXgpNNvLEMcVK92YrVSfnzHF.nAUYSEtV7.tlzTlJoEx9AXoYN_cSF4L9CA
 QJUNdwxzpAZr9P6L.LyOcHzsqotDd5e40BcqPvqz_phnrW6i7Rog4GwD_M02qx_m5CYyMdvO7b1s
 Rr0QUk0shOsteEJGfxawE1tGrg8lfLY90XToPMiilOZ0NugWCuNipG.WjCv.nOVdvCyn4_w6S_qK
 1K18HRkZPzxI.d03w.SJ1OQsNoGQl4iZcQHPkdrebZobCvTxS9CFAMLImNX8DZ2mD9hNuLPvyK_A
 aDkFMtZxYh_G6aA_uW.fDfsvpcwf_lFFs7pKJ9cVYkWqVUewxt5xoNVjcqtpMkgVWuAs2dTC5cMQ
 mTwW4PWfyqgXHCOYU..k0Tir6O.zLVoeshxTCCDYeg6IjhRVtkE.A7MFfr9ttPJC3QQ4WO_.rygu
 JVOuiJjsFAvVL7uaESYr7M87BGKzu9AbaLTfoa6U_rOcOeK3421ECd192CQb7Up93stdtcTN9TQ.
 qkAihusxaIO7LjPEj5hZvA_BPxlDMrdQGo0k8ThxFI6nmVD.FL.4STwqO6QZQKYowf8wzLf.55Ug
 KFrICEcBJqYDr2OYqrTbF1LOsD1u0oZnChtITt1iEMu3T3i2xlJ6LJGexFZ9Brt_0xzTrYAfM7On
 j7TLLh1N3KrWqrozg1njBSiAejM2iZl5IL825ZZxDzb42DI.Ui_l2D9DbiiH3xadVfiOpBU7I3Sc
 bF1LfnLktga2nzN5Bc1E34Y41qmojhpbDQuxTx2Kbfb5M1nWlJAsQ4d3FZTggk0pYcgL2.gXpGRg
 Yf6tkHOkMkppkBoBzu1yuq90IQVPhf.G1GdiChwyHc5YT6sYxqKT1o2dFjg.XxRtbw08dYrZNprZ
 7dSumdw2ilGpo.mVa8ZN7979YYwPWLCnvu.W.mNNL0eu1.s4u__.KjzqxywW4jE.UOWb7XVv9UAF
 sTu7crxt0bprJYAtq84dmdYefkz2YRURyUHWPXctO5clHgSn_RbCUtuoJQtNNIb9FPBJ_pt2Nxx_
 aFKR.7zVwlJMyNGDbCEo4GZ4b7F9udvz_RBgdw5N284TDxfDx2kboZ4VhTBFPkFu9O0VSE3JJcdm
 Q4P6.QppJ634iW.ZP6zr3WGyPEIFHUMLk.ltkGp_gbAbfIhWU4Q446Q11xzmLSpq9QcHRgHK5CrO
 YglsESDhNmfNuLZa.exptxoePBOvl2hR8w9cc.9_0u3gTPlY70rNIGYIss1zNeGCJu4OPgUSH6TF
 DUP6USv6i26qAnNNkrl__BJhkgwC.7Ek9mHNPm4YwBWOAd7NYIHtE_20NPjTJJHUjAJo4DcOi7IM
 vvrqqwgz2NSRP3lf36n6YQ4IKtVIYedcSgKqf_mrLDUXJbjVd2b1HsfPJymBwZGs2hhH73LrkeU9
 tVjd2PL93oqgTMnc488Vd3Siml0ZcNULYsdv2UnsXLkHUgEQMbNWls8XkOfR.r.wymTb441UL6Mt
 w.6aKUl1BKUgajt7x6HAyWoGi7lUN.Y0nHaaYOk1tma1jh_IIQ2DMS5GloPK8t1W9yuIxj.6NKFA
 1rIYNEqWftmHaxYHl8.Ag1gn1VjM.SJvepU38V0zd6E3UE9nNT95GTs97Q4fAwTjWvDF_19GNe8z
 qZVmd.bmD8l6RKQJd3zT7Gp3pAxrNpBD1rpvWyUp9QmGfaYlhl1uYGEhcmcyQ.hc2BkHwDXX_eDT
 Em3iGD7NyXBt9ASRWNJj5pAreWU7YSYfcysFnkrryXhdzOihuyt4gf2IJMZ6LRdZ5JPM4IOxmSdw
 JNlGgaZW.gfa2izM.nQu6QOZHbOglCn7S3IZTdbGy1jDSksNeh30ILkjvugZYDnvDWoNOVxecuvo
 1WIS_jZPGfjZFs1etQDcAwdsbhOO.oBQD2q2KEG5fB6XrxqRrDlCXgN_Vi3oTSx9FY2iQwrIXPWl
 .JGBYNOJrl_GKmDjEvqc5ac3ZRCBCYLsz4TYz9SHJ4HuCEcPjdpgzQqg4ayZz9FiWr.XynakdAgD
 GYdq23Bjcj.MoLDkq3lfegwu0LVkGVHss8OJeRUfnAd_FXVXdM.FmD0GoGDPHkTod1m4nx1lyppK
 dTUfdLSh.DD4.VACMFgM6vssIrkhywfJjsv.UhFdtx99a4hoFqr.RqKWriCYNPJl1QFGvZX52IO8
 Q79rFCIs9_lTuhtgdK7g4YEvPC7Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f86f1082-4200-4328-af52-f09a82e3a195
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:09:04 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 617dfd7e8dbc08c7e277f225736da47f;
          Tue, 17 Dec 2024 23:09:01 +0000 (UTC)
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
Subject: [PATCH 1/6] Audit: Create audit_stamp structure
Date: Tue, 17 Dec 2024 15:08:49 -0800
Message-ID: <20241217230854.6588-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217230854.6588-1-casey@schaufler-ca.com>
References: <20241217230854.6588-1-casey@schaufler-ca.com>
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
index 13d0144efaa3..310c1a7859bb 100644
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
index bb0e7346d916..6e16208c2968 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
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
@@ -2510,21 +2510,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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

