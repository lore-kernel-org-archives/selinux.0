Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDD1C433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214FD61164
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbhIXSVz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:21:55 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43767
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348078AbhIXSVz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507621; bh=GTrFRnMTSie8hlZrhuV2J/+6ofhCo/c+/ma62tlftGk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=k8hHOGvbBCIAK/mIQREXN2nzeW2vBSzHzOTORMJ4cD38FhXJ2kzUIrilDKRCeya1CaotQY/b+vPKSTxCOn2PwGi0lXQ2MPBQsfvt6+Nj0FUTmUGKoYRb2HqwPQot7Qp2njdJCoRivlZbLmFnjDE9eR/xob8ennVJ7opHbpf8PPYhJRmv4Cli2E1X3wk8R8LRhGaMrL5TXbKOTVTFoTdrXinQaKJP4XK081CeaiUkJRrZXqGRDPyZLXywAtZ2kPED2bMHz1el9T5Yy1R6yQIjsnpMBlaF2Bt3CGQWYTpq5IHRVd3vrTvr3GC33dsCI54I3BxHYA/WIO7ZVv06QvPsVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507621; bh=uLguqGOwjtCs1sBide3aF78AgwKSdJIvuXUmQd6qw2v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mAhpaHzFl/ytc/LnjIfy47I0NnUGAeAaeFTmyl0rpNH3wurwyZSK+b3k1svf9tSmK0wnSvmNgPOHblIf1qvD0fAHSvkbW8eOPaMn6X9eVtQsOssfIBbRtAf60TO01l1oYNeQomWJgAqc/vh2E4m7WvEPtLEUjkXEzUaGfJ0pAtQ0+E60XEZgsVdaVc7UeSLxKQb+Amylw8rdjD7fa6QycZR36nObQmYPf8/z22Pqlilu1rlgUX8ru0ij4BHQOjCiP6iTzmoOaCu7FGnrcKNNKczU8DfBtAdHdeX9rXuyLHHn5bLCQTV4Bja890QADcjsOHA70iNfe8aLK0NrOsBAMQ==
X-YMail-OSG: fB6jvCQVM1mzoeyVE4EX5qkXdoexjcor4S0YB6X0TrTEY3L3FQPmAUAqH244.Ij
 g9YGzbMKSoZ0PH7Jp9f9ck2N2d5D1oqQLMq0fJrQnNCOvztIrpaXFrclJIfbSDwkPXRWyN_dxh_I
 1IhN2fW39yBPhDpS3orlTcbLaGzbpmCrolE4JhE4FX0F1mgDakqJIyMboxwtGwYvukRFWpzrvmUi
 nKzVSK542p9IxsqGpxdQZH.uOXKPqFArR9uMbyYoGWQOJ41gXRj3rj39XNfc2IAy6g3owIsmd.u7
 hMUquFIo77GIj.v2JXq7D6LpYBIM6HXjVruD7x3cdg8wk81FYa7Hdfiz2cfjitPnINglVbrRvAhI
 DK_rsMyHkhogPbexuGCEXoIQFxIjzhgSdkP31q_RahRT6iEbgP8TvSpgZLPg04Z1N1M3ZT8yv_Dj
 FP49rYIEi1IFOZJ9V4QrDaL39LZoZ5.hOflMHo1OXNDKPntMW.Q4.a5AJ.3_qanUfhQK..JumQfv
 DYdgYAwW1BpYbyki2et34ZYVM0suQhI.zvuMDQIyD8iC_0QpjzjSd8PG5hy_wXLGwTjsd1gS0MLx
 RRkqXvbN3mNk.j8pGxlxsh19FtJBJN2qImu9Tr77ORxbIggCt_PrtMn5QAafLA3Dv4cFLUnNVb3X
 Ou11uf1Kmv0bXgB4O4nTRGuw6P.zTurg.VjrTr5MT.up5z09CTYdBhOha78KcLtrwZMZRipN_dYo
 rK0gFTEq8VQ76VQaMB5vrCIY0UqoysXVu0txvfHxQyVkENa0BtYIgSX33EqfhglNFmyA6D_bBaH7
 74QQNOqFPcgs80Pg1xAxwOIg077y6qE8WkupP.SXJZ3WLjUjD8OP1o619y999Fc2UrAfg5e0dA8i
 Dx2GyPg8Z8e5iTwjOzS2Kf_7OjXl_gZ2Yzrq7UCuo7uiw1kUAOira.zLsi0FPzeDMc0rtlD9OkwS
 dSvv0OJxewNW6lHZhfiXSj5Oq5_9AjHmqNrxXYsyMOs_p3SG6P_Pnx62nGeAsmzf.mT_UlxR1Vwp
 FiX54_sLCpnzhRwrjvD0dr.dXZWoa71iZOFh5ElVc6hPPcvBaa3yALAhaMEP9ENmoTMx8ORLbjH_
 XuVcISArfpTO84VRLajrnDaW0uL4BC2hKf6gMrHNvXlRQSQYjKxQ2YNayDwctwYOpDyvB_rk6D6K
 RhQMoJelYfBcr49AYaR.0R1T4HhgsyHf4ZTBsUfbCiQIrMFdZEvfSoAmm9O4K8pCoK3LmEvSkJxm
 nA7_6Ej54A78mWC8RFHpvNzTONc7hGZe4PCYEJvIEr3jAmiatdx6t.CPoj2Jz7w_4tTPfegIjUI8
 0bNg9GRHtDgPrPncLZdIir2lCa2UYkaZ2JTNdYtTsu4.XmMAg6D.wJjFgy9mSmw9xHM0Cw5g3BMe
 sxpIZ0abRFJ3ven3yqSyJbuuQnbHlRDyTMXenuXR.TynmwgSyj_Kyr1H4kTMZsvMbdzPxfUBesQt
 3L_.oDr4xyTuUnqgLxaVyjeAy1ZC89x.0HXNGMzw56ao1IPgUCojil7a4iE0xoEfP4tI2XnL7LKQ
 P.uTp4xdc9ElQoc5dB81XfF8bn2fmLP_N6pCfe9C0..ZQRWoRn5DZyS8SjIiqiEPGy2r9MJ6fwtd
 .oq_Zzbd01mUVwX_F3yn8T2gUiwi70RXqP84y5iEDnthj3coCjcMl3vlfmd0SKAal97GXPClw8WS
 f.syZF2E9ByO64YtZzdKjP.2IOwlga.V_yNRSrC2k.dN5L2Ul7Nw.eYBvBBAC5qdtATyx7LFf8cx
 QgAJimoMVBkpylk4utAHBlBUHe3i4XGpoH.6vwU1R3xRzJiZk3zGMP81wNqxjyQmB3PS5aTBE9wt
 3tudXDypNlvJkxPz.DjbIhnOPRnJXBqOFB2j24CaA3ZDGchCnBHDDZLrV9oNau6_gxy6nDBadSYK
 rLf8sanMPenrg6AHoqQ7P.fFFadVmieIUR5WpityWR9IU4JnZDaoAF4JgFayoEuw4Yl_npIFxl.7
 i.bgINyCrPfP65nmSE5rFrTPraWVmB1.Me73LI9af1bIiRPPAoLiBUDPH_C.Dp_T5OBuptAuVjhZ
 59gk.8K64zl1_682j7U5G3_NmaUHcQ3O16xo1kkr.wgznRtLsuu3JGvK8JydzsUauDD5K1GpJdon
 OkGQGybv2pV9YC7RRepx.YyqWdsau1QgXPJwwfdAs_BED5SRag3Orlgp42jgm0l_c_KRQqpz4bxO
 WN670uY00MJoaPxzB8Pp1jIxwTS2CsvRCatJ8HK_UadCa4CAg4woKwWtmtDewLJl3aEQB2uNa89R
 WRdNVpdHch4OXh1v9qadLVfqhSfiqmXpRXejZQu6Oi86oDFpfSspDSDNnTS5zwc_MTmyKXMxP3ar
 sthQ67797_Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:20:21 +0000
Received: by kubenode526.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d3985b54882c55e1c6a279a8004cdfa9;
          Fri, 24 Sep 2021 18:20:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 23/28] Audit: Create audit_stamp structure
Date:   Fri, 24 Sep 2021 10:54:36 -0700
Message-Id: <20210924175441.7943-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 18 +++++++-----------
 3 files changed, 25 insertions(+), 23 deletions(-)

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
index f3ff2bd31459..90d98121895f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -98,14 +98,19 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64   ctime;      /* time of syscall entry */
+	unsigned int	    serial;     /* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
 	int		    in_syscall;	/* 1 if task is in a syscall */
 	enum audit_state    state, current_state;
-	unsigned int	    serial;     /* serial number for record */
+	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -254,7 +259,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -295,7 +300,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e960410cf4e4..0fef12638d8a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1700,11 +1700,11 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[1]    = a2;
 	context->argv[2]    = a3;
 	context->argv[3]    = a4;
-	context->serial     = 0;
+	context->stamp.serial = 0;
 	context->in_syscall = 1;
 	context->current_state  = state;
 	context->ppid       = 0;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2209,21 +2209,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
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
 	if (!ctx->in_syscall)
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

