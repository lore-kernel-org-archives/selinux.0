Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490E2FFDF8
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365366; cv=none; b=VQUBImVo+KntJQwGlImYY9RdlMRrSrkUuISOSLcz9baFG9LG3Co+/+BN+BY5LrB1ohVJct9bZ4czIDQhlbbQWr6wgyRNinjd3X4ZsnoIPAIL9gXEqBsC6p8HAXjLFw33FbyKIxHUMgppf9j9FuM0ghcKCrn2BVbC1PH6nRXkvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365366; c=relaxed/simple;
	bh=vFw9bdj5HQvCzxgaSmVlE9yk3fIiueGOkl8bgkAx3+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0pXoKeGk8GLNOlnWQEdyE3op8xdA3DFyv19SuZQyclQKRf67Qv60ljWy3J0kLDSZWoXFHYvf56Laxqhi+Gj9A0Inxg7lAmU8oO/PtBoYhP8r6lr9bjgU2stuPOtQUiL5pZ3viL7Pe5jRSGgJ0ihEqP1D1vSNa/rLDy3gpuaO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Q5N48rTl; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q5N48rTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=PZswrgrb/iVrnC1GS9cUq6KksvfabfMQsHxJRWkedHE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Q5N48rTlDgPp3nEUpriQ6iN6jJc0m+NfdhrOIOEDOiRyoaq0/nXjjHge9eN3UFt8+1me2SGm4WA4ayGzkq1QD8Kk18wfmyuGJEyWGaIeO+QY+6BraZ2dXUaLNfG7S30+69rfz6HkOtEjAL1nJW5eCenf+UVo7Qoau+rdMyi0Re+j5PvCbqnNq4eZ8kiJ0fK9NXbDikwq/wVJg4focIGgeS7E1aou1h3DD4B8ZzKrwUjnZed9wLWTyd4GD1yNwNlNGtXXwmyas4M4jzhZ77pni1c/G2m+mDBYU6z+ELlCZ+CP6DNPu9jdtQ0FP6c7Z7soaTmTDCbYT4HOS58XK/Wn4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=kkXwEDnK+4G3RYopdJ22Q9JEhID4IOmQuxkTZjWZk/s=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=imxkPN2bYYf3jQEesMwKC0m02WMSxjZYq7ZFxGf4T9n26uO1ra1iOZOQmXTsBRT6C/b+PacemZv5jzTG6LqAndIEiCdI9zbWLQVBAuNtvGApPd2r810stJ5dsU3AEQpavxdF3WjWzK4Vat0QfR9ed/3oFSgeeOKI6tcZcqwI4Aujy0cyb1Yi1+EwMFTRJ+LhNZi8ZDcmC3YeCnHQNQ3RZvw0L0cu134wAkac7KJR4ZInKNLWueVB+YaSFHDQbOP4ERz/+bJnYI/5THxDhTsF6lCp4vzZdusWxUGfJGwVXM/pSl3VRJOLYNgAAOzzHpi9SAnaJNwL+SMuwJpQsGJQeA==
X-YMail-OSG: 23SHywgVM1m35VLEKkx4FEeU9xJaC9nMbangtT7g1qCVbMqbHm2gAoM2rGdYtKe
 NJwQ6qgeuapXTz37.Doge4R2l_rRTnqJg0ZMTR6cxlIE5WLaSidLZGvbN4frkgPvWO3u_fgimxNq
 gk6VecGm0yoIKjlvytkqMHePILbRb6ouxDn0e6cq4lc72kwIr0HYXjPSFA7T7DaTX3zUEauPWMUS
 cf2PSXqx0gC37jWQF3qezUMhCpV4iM4IbmWjDP1HPzxM9ndW4EJpHUGNH9EJ2tQcyYurkyRPHmC5
 QXl5fdu8f1efl76KFhdtklyKm0lbffwjXBfukozKVNOlcFGwoFS.lbE.WXhMCmsMqv52TtAylWtN
 m_FYBkMgYx6l9C2L8dhskpS1V6u61GdWbdQfyr7AKm3T7HJZSG0Elke57TPXm5WrvlAij3GJwDAt
 eTMwPunaqyEbM4Uguvic_cCUk4Q3vE5STLV4ozvcIoFXEnqVt6VuyldEvVeIPd2nfIHOt.JFy3D8
 Z68frnSwLTtPXc2ad7bocqvr05icOCRGi_7C9678cK65reOPXkUuLb2rtpUA57op769BLP7kwgg4
 Ij.j0fq_gmHW.4bUiGzvw.OT6yZdvXtyWA5ROIm2ytz50X9BtgQlRZ5t.4FMNxBf5b01qmu_3KfM
 IxgADdCmTNEbG6a0zF8gcUKfHjrQgXeVGbJZ28RAm.iIh95L6JuFASiOu5MzDnQBSTOMv1gEmbg.
 x...hwUpO6hKYz6tccvnoDGYBvgdQTjz68FxFK0TQU_8ZtCOy74pXK7QJrClPVLI0Bw1.3zuaq3Z
 dT0kcMCvSvBzmh.PDN5Sj.xR_HqHYyUQ37.B1tNXQ7.Fc41HISSUcHpG4AnO_aBoPDw9axQmaR8n
 t_CRL5sdMG_d_FNBoaY6u6tm0E0dJJKj0MxTinOUO4szIssvyovnTCmPBTN6mxdFiEZbtSlse8Ly
 eGvhAW_45dH1kZ5YbL88NBdKovmNvzLHhuCZqtVe75HOHpOwYj9Z0kOLrxmFyk4RX.7H2PfZPaUW
 jarDX_B_.lvfvL9AD1sXQlO.Fkg2enzdY044FeXKPs0Vsy2Zr78.v6oBHAGtw8YhbX9_XTapDoF.
 l8UE4dIzdjzOqprOivDEuJ8eMtXuHYNKJrICCtn4DSS3ohr1rPqM27ZIy9KS24ipSrVYsX3sh3DU
 4qyTcfjTQm2gm5_yEwTdXIfVBI0eYl28usG3Lo38PT114YVvJBIX1VqTBbi5uOho5kIWb_FmE_by
 N9RpYSeJTVwkVMciycoiVy_XxpiMI_y_neh6liAUnBHckOZl3WHy0101f7.WAZ0AIIOjZd8KxTs7
 YaZ4GBrphTf3FlJXGwPrj89EIvHQnGDhR06tCzA7y0e6QdTHwAHXxmczXombd0G65TRtYF.BeDgE
 XWfiEz_lrjD772ZYKS3olXLu0dPa_w34rZCxJxJcTJe0OKmao6THOhjmn_K1L7uAw3Az5MlHr5yS
 mzW6881KLTSypfSiuZRJqdBgbkRu.uCL6Ax82qsrFPjJFDwHAuZcQs.jdyHxw4On4F2ByBXvgJkr
 FhdjvOJSETk2hpnh26gglJ10aJqnjUMNexMvU7fWfn6YXybBryqJsm3zWCbt7kV6t7s.oB_kwomm
 5X5rN0hZI6SPYV_Fy7UfhAmlCMBZhWmOY7mFtDLVgbnWzSWIZ30M_VEXPVOJj0KP2cds5I9Rz53F
 XkTeIreXq4lshQ4rryVvmhuUIsIj3vpvUXB8.XWEYl5F_LMLR2Bupz6AaYCv3MKE0fRFkXrsr8r1
 5NDoJOxwzbx3iKUpwreHsWv7H6PypkWn4Kd5C3GvieO6DIyeRmxw14N6bc0mngfLp06amq7v5IiP
 53vsyrKa9Wk5_RfLQdVbQcDqiJOU_f.vwsas2U5zCjfHTH_d_M3iosAPS5F_C3FWRbhDT0JOSIGc
 U3M1xUuJHoTuzecqAbF38dtsl9XOY3FF79NnN49VNH.18KP3YbA6H2qh6nPecZLXq5Yvha5Tl91_
 _YD8BmxWtg2gYDOVpyWy2Y4eqB1wyzXlwGeoP0U4qvZMuPBod_UxdHHgi0D6NLeWdZGdSkbpBHxr
 j3dAcQGz0mwYxeGGgszvH9vio4VUMculAuz7UhF6b8dwuGk7Pnphp3Y7hM8ChN2xz0BQBtCDXYLU
 x3MtHbK7kP_ku7VVoSbUf.dPXf4qqWxssS7Tt.R2R5ZlTN0EZ154PKM7hP68OQRk0IP6sNKyTP.z
 rQu9lU_Fsvxby2ug2moyPV4D32bkNGZGARImebqhNJHQUNCtfbE21IfY2RmHbV2_nevclypGWbuK
 uyaJjZRc0dkc.gf8G8Umr5LzkqjfxCNg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 09ffffb8-7fd0-485c-ad13-99c228659dc0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:29:16 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7374b10bab8e01c99c92e4838c45fe8;
          Sat, 16 Aug 2025 17:29:11 +0000 (UTC)
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
Subject: [PATCH v6 1/4] Audit: Create audit_stamp structure
Date: Sat, 16 Aug 2025 10:28:56 -0700
Message-ID: <20250816172859.6437-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816172859.6437-1-casey@schaufler-ca.com>
References: <20250816172859.6437-1-casey@schaufler-ca.com>
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
index 2a24d01c5fb0..0f05933a173b 100644
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
index eb98cd6fe91f..aa6add4b9e30 100644
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

