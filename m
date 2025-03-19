Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80221C9EE
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423283; cv=none; b=LFxOlpUf4PT9Kck9a7kPO1w0MRTMoophNfLrbl9WkhsqLdJwIy/ImNnUkddppdm6IMYm1Cb05vBp6MP4UgHZ8UtvuJipl+a6t40KSbSIx1O/QsRnn8fllbDefvCS6j/oTr3VwmI/A0jPNF2OYoPoptBRHYtWZyNQzpw9+FB1DY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423283; c=relaxed/simple;
	bh=DCG6bifvByBuCsqPYIEHPBVhWlTZPfFDODT2mif8HkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahtIaysEJ6XY8OpSeTBBLDLnOQkCszAUUqigC8z/Q8gOATDj6+nAQlwx4PEVs53GKr6VbcCk3Efk6C0LZvQqysRvbT+C72+9MxgL7bZhZ8Jt7OpK8+9S8Yhzx1NFy6TJrGgStzS1zOGWuOHnIgXIRjxxXAgEamKaHBPySMg4FJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cXdmOTe2; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cXdmOTe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423275; bh=1J3lSB8n1jv+w9ZqbP54sFbPpicu2hj+x/1lxo/qb7o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cXdmOTe221UUt0YMQT/ZxIGB8+RnPVLRwzvTc63Dmr1ZOWzgpYWMJi9pPTlBnGgMN3iJL7ZYPQn2PW0pedfoi5ovVzdvzq6Ex6KZDzzj0DP5R0Uu9x8bLCAUcD3uoDSoQ/4fLeODJMa418VgV5xHRoB1Z7lvyQak/fNyaOLiY+AqEagO19nYqgCiIutbWKJCfuymUrETUPq5jSgSUCJUoyPEJflwskFAv/KqFZ5QITnfBb0Gy1/pTRIGNztSgmzedXhetRL3uO0SV5JwVMkYvmQghyMt2U5j2AUgqWpXe1TIFlBY0ozGXhbriYMMBEDitMrXjnUY5nx1NCm/3FS1cg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423275; bh=9hFaUMJXnjqmwy1bjt7ez7Vg/rj3BG73KqJDaadIQq3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CStW19mdZZtTdDgjfTmB8ONPdTTuYo/aRLkLIc80Z09x8bi5FqWIZ7NVxvMiZU7FB4JD2EgEstBG6G1TJCB+3dHh2C1pJ1PSR6mpaH6KYMzua0Ox7UJnkp51XaCs1FZxGBCsT/OjpHp/ZrdYeiN5AxHfzKRjRFaFfip9STWPzAR5UaLeOe0rhaDxFWCfKv/+11of9A0UyCBirI9DOY8LRIJIUoDTMlipJHanNyMx9pblCzr4eF/K1JG7HWr3bQug5elZnbPpPcr9IOsC4aNCgsGiSltFzvbzji4E+KyVQ3DFfFimoQdSnQQ8NAICnKLxlY5cEdGLeCDpvf9hdxW1DQ==
X-YMail-OSG: 2i0Yc7UVM1my2FqAaaH2t_AOqoZgWQOMfxs3jIjsJO4xBsJCpxbjLA6.gT0Mqro
 NLhboNbdYEbbcCtPuRBq0NoZIPLa0AvXN9p19t2nZ6174WNf2uAkpH.jnKmvHmdofOC9SBcqG3VV
 1qk.T2VUZEKO4eyT8nhnkPqawU80YzQgxMi6UGOWmI5ZvL_pI60EwwjdDzsjF3rXLtj4.hrBuExu
 qvQa61Zpl4yu8a_L2N7FcgHKUSBdejfJ.mbAHJjquBYACJcKW5894_zn9h0JjXrp.NxcJH6ToOL7
 oYAYEm5gcMgcOD5nk0oBuB0ch9rkievT5j6K1XFiZAnRqoo_VfFqFdksIxmd4ytqFl_UcnkO8IND
 eGjV2tE6XmNV7i_1TfZpQRtdXKR87SdCCtOfabsvrS4UNGzOZuW_IZzN4d4RACCCr18WNS41tnaP
 DyWFR8buj4._zapNp.1jRkrQYXbS7yRf5SGDbiegJpne0IOsg4P5K08nYmwn2pY4lE3MSvgAkdED
 chmo8IxpGhjVhF9AFzjsLfn_BupHgpAE3QcXSq5UObganRGpnwutOo7jshBnHAD4x0cKVQj7wV7L
 XiuS_dgS1xUrHEU5MfSmD2b70HwnGot9y7G0rY3yoHKYaqWmfi3CwYSeLcn1Exw0VxcN7hGfGOjP
 axCePhg.PWomgO1ur1kAjurBZVrCYtJBzBph.QZgomUnEfg3K8QBpW05.6AM8hbwoLyK0gzrb.4p
 pgBzztLkNeJDGv4Bjxd4foA_Uw0HPn8_K0c_iuVRVq8hSEpRJyd6bFaYikaZHJQ0z6.F3yk5WXts
 zlgr3h79Sech_X7K9FQaEDbf3ZaQDCEUtm96ON1RDVvDkgB_B7aIuYg3H64yRzJsK5u7ik3fzP7l
 bVVdcbfJGVsPG4YANn9F7deQ0Efv3fdDqhn3VnPZHj.kOnSWGoWGStZ2Zhp5IoKAy2hsT.7z9u0t
 KXD9RrJCyM7m4SfDBnRwJYAv7BTReSyNPD937SyBWdU0aJuyeJVnVyGAYw.1vEbPNZiy_xDgV1sm
 tskp3EzuQR.XrYEZ3axgHIP8bJawEPbrbWxsQR1CX.IjuFbbIXD2tO7JZ5H2zMyJeAWgXh8Cej4F
 crP.o03yAeHUGRS03CWtU57stTvGhI4Hn1_Fzzj9DFmRQpXgQEMgBfXUhNcveXuDNwtPYo.pRDok
 5Yg75mY40CDoPX3CjX5OCcDgQXvD1agqTs1cc4FHzzBDmda4Su6L.fvOq0Yb9hir.pIESSMYy8qF
 mIdbK8msTA5uS.M.k7YxQGSbEB6Kx.x3oMpO1qn1NUxjJSEx2gn9JVL83aAEWIVRhL8t5RKA7RAR
 1Zk2yBFcuoT8to8e71EWZukUfVFtL81fOQuJjCbt0wa_VSlcqyzU0taUrR5XRKxgBslmAg9alR_r
 Xy.7dpk0wpmRrzoVrZH9Hp.o9.2y4egvkzG_uV_eFG_GDd8LXuTfEI3pZnnfQMZpniYrqnZTi6P_
 g3K5DHT922VWP4zqHtFMd2DbPr3nTLKj6n3kv8iGUQiuNyipRjwJWIzKMdRUyu16F1h1IyaNwV6s
 8sSNC2d34r2C1SHtvsDcK2HF6iwIFd_.mJkDxgbhocRzkQGD6ND1j9HAISBrLQX7zJV5U1.2FUq4
 eEH4NTuDDRI_FERV1Tvtp6kqbQcQnX5iZrcRjM4GQqReXddQsRl.H7marZG5v.GsFuLLBEtq4AM9
 7c2V_q7IvZjZUBDn27Q9E_YciVlMz0pqDAsC7HVeggtHqv4flUJgSS2QfWIowqiW0pe4E634evcD
 vH.SjTQV9eJQHYUTYV1ZEtTOBJuRqfYI2BIE9uLPc6lBFRtSDeHVQ.mFnPz3Q_gmohYGnCXkeTVW
 yuYySrZ7bUZjO0yvUZrMXEIMp4TSrgMJ7PvgnJInbSLJ5QYUkdUI.vLj5JQhWcfwMKR0dDiWdrQm
 e3I8E.dAqbP581IbVc6SQlIAUsH6ruN_YoFGQZl80SjG1BjyyuGjfM_6UQtMB.5kapHKSPtu4HqD
 GqCPaIw1.kxZjRDlCsqsmUup38pBaIkdIRkdg3tnpuBHAn15IJJTE8LzAZ08Nv6Jq6R3p1eGDIH.
 STsFdoo8H6Ti3PflYYJ3uJwt6lr719O9BaYegviG1ZI1AKd2ZJT7N3_iCktmi33SyKkAQqdN.5zg
 zgSuGxnwEfjMVwmDBh76alKpJN45MaUfRBQmaeSnO7oH3DsIDPfcw_K5uwguvtCb9qQN9sso.sgn
 HknFUDGZZiPlIZx4_t7B1aLZ62SJxUr.3KfbpOL0zRil6PMlHxkG2ZpagtAdkQ1Sl1qbJmruiFND
 td80.B.EURLO31DyNop4Xqv4R7Qo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b86a8153-41de-4246-87ac-b32565e305db
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:27:55 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:49 +0000 (UTC)
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
Subject: [PATCH v3 1/5] Audit: Create audit_stamp structure
Date: Wed, 19 Mar 2025 15:27:40 -0700
Message-ID: <20250319222744.17576-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319222744.17576-1-casey@schaufler-ca.com>
References: <20250319222744.17576-1-casey@schaufler-ca.com>
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
index 9c853cde9abe..60f2c927afd7 100644
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

