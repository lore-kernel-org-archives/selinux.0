Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CBC4332F
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 17:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLSRzr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiLSRzp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 12:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D251275A
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8EQJBe1ACqmTPnCsFrmQTUM9ZhpffhytSBj2Oj+XKs=;
        b=V9MP4LwarrmyxwOq+4kjHcQbatjmSbvoU6cS4rkRK1ECHqJ29gmEryUffHAAvJY2o7uiPF
        wtCgh+wI141i1AHAfyRsCmetC0NpEdkbx63xvLAEnyb0QO3N1LO7roaoQ4b4JQE2yARbsR
        eWxT1YDlNbhRqll/AIpysm5EBfKZ9MQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-142-xCpc2UfdOPaMi8BSBhQr_g-1; Mon, 19 Dec 2022 12:54:56 -0500
X-MC-Unique: xCpc2UfdOPaMi8BSBhQr_g-1
Received: by mail-ed1-f70.google.com with SMTP id q10-20020a056402518a00b00472a255eef7so7078324edd.15
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8EQJBe1ACqmTPnCsFrmQTUM9ZhpffhytSBj2Oj+XKs=;
        b=fc1TVSHoidYd0v9k2kEEUlWzVw6koSWQBBdioWZuqrT56JMo3Lyk9TYPhxdSQslqcz
         kMDtWyNDUNaBHzMbChVzfxzARnC/EZQy3nrSQsgBejyv7xFS11No/ttzr7j84gARasrE
         psiTmUkse0zWd0RIdSOsa02a1N4S8eKDbO7tGtgqLGxgkP1w7WEBsYcm1Dp0koWxiQn6
         cC3WiOBN6cA5NFwf+upbgqdF+VqhKJ+6RGb0HGTpR585rR0yXkQdVD5+T5cN0o8KKAcU
         0Z30YqHPy7qOcumxoSt8MSy9oWUz1/APJPi7XVbcvYuBDrWKd2xRPMJyumk5yNijLN+F
         ybqQ==
X-Gm-Message-State: ANoB5pmLovUVO8ADyciB8xO7oIJy28pcJxZAOFkkVRUAEKHuaqugawVE
        m2FlV8KwsSHqYbog+KugWaAzsXLqKmdpCzAMZjAozadLdcAX9R1SP3UvKuasomg7ilJXndATukR
        iOQ8zk3DIaIDQrFhP6w==
X-Received: by 2002:a17:906:698f:b0:7ad:d250:b903 with SMTP id i15-20020a170906698f00b007add250b903mr48341352ejr.56.1671472494474;
        Mon, 19 Dec 2022 09:54:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6YLtenQUjr2R0cuTQaiwIA9ywz+DM8e52twvcfKvsLPFUnaFvMUzZOwGwHSPNzGMgA0eMYNg==
X-Received: by 2002:a17:906:698f:b0:7ad:d250:b903 with SMTP id i15-20020a170906698f00b007add250b903mr48341337ejr.56.1671472494319;
        Mon, 19 Dec 2022 09:54:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b007bdc2de90e6sm4604210ejf.42.2022.12.19.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:54:53 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH 1/2] audit: introduce a struct to represent an audit timestamp
Date:   Mon, 19 Dec 2022 18:54:48 +0100
Message-Id: <20221219175449.1657640-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219175449.1657640-1-omosnace@redhat.com>
References: <20221219175449.1657640-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Join the two fields that comprise an audit timestamp into a common
structure. This will be used further in later commits.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h |  5 +++++
 kernel/audit.c        | 16 ++++++++--------
 kernel/audit.h        |  4 ++--
 kernel/auditsc.c      |  9 ++++-----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 3608992848d3..788ab93c3be4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -84,6 +84,11 @@ enum audit_ntp_type {
 	AUDIT_NTP_NVALS /* count */
 };
 
+struct audit_timestamp {
+	struct timespec64 t;
+	unsigned int serial;
+};
+
 #ifdef CONFIG_AUDITSYSCALL
 struct audit_ntp_val {
 	long long oldval, newval;
diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..aded2d69ea69 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1818,11 +1818,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_timestamp *ts)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, ts)) {
+		ktime_get_coarse_real_ts64(&ts->t);
+		ts->serial = audit_serial();
 	}
 }
 
@@ -1845,8 +1845,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_timestamp ts;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1901,12 +1900,13 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &ts);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)ts.t.tv_sec, ts.t.tv_nsec/1000000,
+			 ts.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index c57b008b9914..e3ea00ea399a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -262,7 +262,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_timestamp *ts);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -303,7 +303,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, ts) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9f8c05228d6d..061009ba9959 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2513,16 +2513,15 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_timestamp *ts)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	ts->t.tv_sec  = ctx->ctime.tv_sec;
+	ts->t.tv_nsec = ctx->ctime.tv_nsec;
+	ts->serial    = ctx->serial;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.38.1

