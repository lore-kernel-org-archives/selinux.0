Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB024291E
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373243; cv=none; b=Q6wNxyjDBCGsq1+M5MZXm7ez5qL5Ck24i27gknEXHuZAxsZtwVs0g+7OG8PQuaTWSoe8B9ZWqkSTUe+08PQl2WJEvtXP7Y5UyWyT4qwzMotXsYijvlnQEMFLdftieXeP78xKhVSWg7HcXt7ZvurlNSEd2kiSbUuuuUniXweeZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373243; c=relaxed/simple;
	bh=bf1+QbpcbSVah0/h8uBb3DCVF+GdYtB5ASLxPrihG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7NFF7Fjm0V3/1a05XodsLxUIYSpomfYb+5sv2fGEoo1DMRAvMAPpkcfdpSdfm9GSQkDEsgvTKNJxFwguu3tvppAMA1MFAxZ4+Roujob0vqt2tagRwSF/UvmSciYci0XmT2cjsI8529JDSW9RBX8YYkIy9GjXyrwyz1m0QoQax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kOl1g4aJ; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kOl1g4aJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741373241; bh=azN7Kk9YErwtWuqymGLMrPgHPFYKiUq/drMMdKqTQgM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kOl1g4aJnGndSR3xj11kHZAb2EigOFHN0t1ZE4eSwqBn4pQvpmdOhZ2mDSFpFbWRmmD/cpxapeS/5G62V0ylmysqK52WN0imKHKdmUqM6pAAly1uD4VUQOHgUso7koRYNe5bU2g9/0T4BjaR/qMye8krvNSkDYeMgQU4KN3aFuAyLogtLhjSclR3QSH4lJtZCRBISpOGVsDP7Hf10MtYhiCjSPl2mQsqnslC95G9hyRwGuXLKO1PMDIL0b1iR1XjvbcCrBhlYB/emj1Pd722s7MppnHEI3IAfl/M/htRoNX3RwFe9P7ANzO4+bF8/EZ5rZg+fy5zpxyGYymFtiaUCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741373241; bh=SzdaTR8AC5CICaFPPj5Rj28etpGKqv7AkRPX98rNaWD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XIih8ZKZ3Rr9gYf5378VEUq8ukm7zq3yo+Sqm75wfBgR1XzdxPrLxErRPCsjp9V4WbMmGufmCUunwURDISikv/o780mlHj+u2AyXxsan0dF5MKPRi2J9ooCr/lgVqY6l1Nsgugjqxkgr2LXLmjAoTGARyzb4NJBtmlwk3v0E2L8AHGUIo7eQYevsD9FKyiXHhC4yvk5s3loMOA/k4oo3dsYIp4Iu50wsrZ6O3o+ggGJsHwpvyn3JBzEK2FEe0QeaC5JDeTqvUaUYRI3dPLsyeqeQWUK/n9OvCKlW3UdwnjHvDcFNzCEA1Kxznd/kGoqz6lp//KvlaUa/ik78nrAjAg==
X-YMail-OSG: sodVNuwVM1nIIpzBOdI2aquWxNcSw17J9YDkAJypoaHFNRlW8ZXFw60VFV03BZh
 P3fTkGn0Me06EkYTBC_bZJ2BNt5JbOB2ggAChV043f5dyP84Bp.xWeSERNT6v3D4venGmz5wTLOl
 xx3u.w5cZEfJQIGxZbO3wFs6.OfzXM.M9yMZ8Itf6b1dO.gf.by3Ty5Uw8ETXk0OBM_UCY9pzZjf
 DsZYfDekfxE26XvBEfpGRkLiZBbKhF.nKw1caJenSBZEguNnv0Ktph5qrCJHjdqvL0KBgBvkJMt3
 hZMBVDmFIPHpPIYruYxM5AVftrGPb69kjjcgiSHZ6Iz1I7ksSIrY9ufZvoXvWu2ab01IPxcWJHcr
 p3Ykh6WcQyj8TEGx1E5TvLeMZvxAw1qOKpJbjNp3j3cBrfOOVKP5pHcGWYisnwn65IzQdWwq2G72
 wkW1sbMMrH1UtEcVGFBNzAeXm5H6OZvwE1jH.cSDgewCyoFo3wH0fxRieENOc_TLxm2vwrGJWjEe
 m3FuGavirEO9bShs76cT858PeN83lX.qAt1EDQ1n8oMG4zZ9DDgKYKmVbB1wuZbqRZ71BrcbsbFS
 QGNLymFI5KeaV5Y7K2O8DBwMBmiAKEM2oVKiivFy19GcACB70gZf0Tk123OQV1315rNfskJZTzjY
 AU7hnaAdaIZUUNVr8cn8z_xCy1AkKShLO7koLeuaoADlX36rM2izwieN6Y3QPiNqZwyd_SNI1dkv
 ZTvjgCa1RsJVch0kTkebzkGfQbiZ6UnC8locjOb4y8OgocsYiw4DRME3MDmCle.c4nU7vItYK3va
 gG3iOarmoGnxHx.fa9jWMoMguYv3wSoS3MmwaoPltOAWTjfk9Tyf.YgC2BOVN97HsnprFf8YFCsZ
 NodX5TWWcRfNFaSqDYzhKfmZvYs_1h331m4_watSDvtEMslG74TFTWGFWY.lnHLZU3gNjAVWm28P
 KcEbt9ILd0qJUHrt6ouYIacVx1arHsWD.xT50OSVrcxHOBj79vAraAA2oR8.tsUvGwP3GzfWpouN
 G64Fc3WIAUzz9o_Rof9tI5y40p2lhWsY0wRZuDRKb8nuUD.dEKSsenqAVZN2jiqaFku6Gm7cpe1y
 HbCHcecpPqlx0m0kkyfHueu_DM57x4v1OPRuT8U1cv5BGPpzKnLjQrJWTYp3aCReolYnbixarMHz
 FPZKnBECIiJHRIZFXE2PDDf1ag9ljHgl9ycGK4pJM7nIPKk39UTrtcaztuLu_iB6zhonnxhFmS1r
 9odvaf1iod2XsrJ2lcLpMaBnHeKb5PIJoM.jENQWNXxwCXzDLuz_nkdHUcQxfS1DFW4uE9uZ5CTj
 GNmyU.NA5s7HGJ5nhQNautVCiZiuco6O72AqDLVbZsKlffpeeCQnWbvv4MBFEv5BavS3si7nsnct
 19IMfHJckK0cfu7ZNGjQx3o.Vru.3iGvn1lDQs_dAaP0CURto7Xr0IVrDijmB2X1E0DXu.CtE5T1
 7iWL9suQP2fHahA_plJc7MZH1C0nkk1ikXXo0xNKQO70uAzR8tF7SLFozYxGWLhaQhEyveReOoJ3
 hA8IbrgEdFrftWZElNP1ljBF22BtG73UeBE2UVm_dpHuvf..22dqb5YKakrdZmQ5fDToDbMrsHiB
 gf2.4jaIhhaBUw6GK1tk7FAExQthESMhYsJXQtHUhwoXAzsJ4NswwpsOlF0hog94ERdrZAaSdEVx
 do9nLrBRs8wc4pfxcP1U.5YGKF.xLkaqgl4jy7tWbf4v0jBPQVFSytIQhpWiuZFn7Dt6z8xwKqxR
 6aUGgTlM4qbqRQoa_vVLh5F3hGULrSJ3yFrma50OCmrARp37jxN7YHgAUqSx5bPDmiWr5tdwlTFi
 0DmoIpKic7D_aOK_W8ecWDEY8ugtwEhEUehFUQ3rOPOrBxsVbXUdz700LyIB0Y9AOCespGOSMDUo
 WhekrVCycwr0lRDPXT.AYunFtLtw3oYUn9exD.N8aZsbvCVglXjonYUmhQ9OermDwVq0BqvHfN3m
 QeBy.buEIc8BSjMeuW5bAkFY2qF0y8FRt6d01ARutQ9ABl7L.z.6P_pne.S3v4hyX_t6qXJmcICW
 r0RJ.kOVTdFPsUrLwDgubX.S0VJwVEPoF3_vLZ68UaGZSBaypx.DKIupuQ_Z34MIBUzapSbmH32F
 m0N8tveOza7gQlQPCmG7Mart_ptzJQ3XfGVKWMim.lqqzuuRq9oceZiMcYjHagkehDR9ibauu3nV
 Fn3f4qtpjpFRnSuDqa_7EP3pXU.b7glhlPS0OCjoG754If6lvdsho
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eac63fb3-8e16-4dd8-b4ed-5160a93bfede
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:47:21 +0000
Received: by hermes--production-gq1-7d5f4447dd-9qjv2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e6d6a2ea591e1dd2da3497c747300b1;
          Fri, 07 Mar 2025 18:37:07 +0000 (UTC)
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
Subject: [PATCH v2 1/6] Audit: Create audit_stamp structure
Date: Fri,  7 Mar 2025 10:36:56 -0800
Message-ID: <20250307183701.16970-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307183701.16970-1-casey@schaufler-ca.com>
References: <20250307183701.16970-1-casey@schaufler-ca.com>
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
index 9c853cde9abe..2ec3a0d85447 100644
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

