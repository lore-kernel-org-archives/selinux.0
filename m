Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31160C43219
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5F360F23
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhJNOzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231878AbhJNOzb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=eWdxKlL9PX0uvuOnnCuXv0BgOuYDzNBBPwNVypcqLbpCqu1F3Xfx2vH3CkbWgJXUv+BVcw
        3GV4MzlZxFBqfotweci2XbioEEjN6y7spypUq/B7PCZ1WRoJo0tCK12rgVe7uG3JNBsWuW
        KbrFYjPUBE3ub+GR/Dijkz9MokcZXq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-UMXUpArhPS6CpG6sdR3N1w-1; Thu, 14 Oct 2021 10:53:24 -0400
X-MC-Unique: UMXUpArhPS6CpG6sdR3N1w-1
Received: by mail-wr1-f70.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so4768932wrd.8
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=1phrstA/zFhFpdFR/sOcOx2IT3ZRd5PKtJbKoRRJmgM7rapgCnghMHwMHSK9bbimaL
         MNb2qmDTgD0UcEX0ZCvkJTuPvO4dm/Fb3pIW2KRycGmFZEFwYQyvTzaIBdvRjp2ijYTn
         6C0+BiTDSoZv4c6e814EpNnv4xq2bI4o88YvicjguvErZeiJF/xbN+IT5EgNUITaxmfm
         iHYH/Okt/YR0C72DL9i2rztrlmlEU9P1RSn0TyfCTKbzyKnxWDjL/Mdrj+OywXpACvXp
         Ij01tCjTzF4YQj960bnRR1V4VJychY10uK3AeWl3chpveV3aspVYnSNHptOMpclbBNqn
         0mRg==
X-Gm-Message-State: AOAM531I6c3gApnYf19iZVCpwZs9gNWIbFYWM8zeJkue/XeeFF+D2DY/
        U7EJ2tSg091/9EZnJUyFryhx41+bQEcMYLo0lvVC6ZOAkjgTX8kMJ8rYMr5ztBzTbMqpknaeh0k
        NvsOPh6RIuCU3L86gpUM/4w1yJk0WWydBPHCGx0V3hAzG/ohE0FVNqKglJZCLZROxHHKP0g==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr19704430wmc.69.1634223203209;
        Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNwkMysSrKC7FafUxdOeB+MLUVBoU3V3OQ0qDbD469sfYGKF2rfhdxsUelXvCpJPvDspeJ7Q==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr19704400wmc.69.1634223202922;
        Thu, 14 Oct 2021 07:53:22 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k17sm2485489wrc.93.2021.10.14.07.53.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:53:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 3/6] libselinux: make selinux_log() thread-safe
Date:   Thu, 14 Oct 2021 16:53:16 +0200
Message-Id: <20211014145319.798740-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014145319.798740-1-omosnace@redhat.com>
References: <20211014145319.798740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure that selinux_log() is thread-safe by guarding the call to the
underlying callback with a mutex.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/callbacks.c |  8 +++++---
 libselinux/src/callbacks.h | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index c18ccc54..469c4055 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -10,6 +10,8 @@
 #include <selinux/selinux.h>
 #include "callbacks.h"
 
+pthread_mutex_t log_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 /* default implementations */
 static int __attribute__ ((format(printf, 2, 3)))
 default_selinux_log(int type __attribute__((unused)), const char *fmt, ...)
@@ -56,7 +58,7 @@ default_selinux_policyload(int seqno __attribute__((unused)))
 
 /* callback pointers */
 int __attribute__ ((format(printf, 2, 3)))
-(*selinux_log)(int, const char *, ...) =
+(*selinux_log_direct)(int, const char *, ...) =
 	default_selinux_log;
 
 int
@@ -81,7 +83,7 @@ selinux_set_callback(int type, union selinux_callback cb)
 {
 	switch (type) {
 	case SELINUX_CB_LOG:
-		selinux_log = cb.func_log;
+		selinux_log_direct = cb.func_log;
 		break;
 	case SELINUX_CB_AUDIT:
 		selinux_audit = cb.func_audit;
@@ -106,7 +108,7 @@ selinux_get_callback(int type)
 
 	switch (type) {
 	case SELINUX_CB_LOG:
-		cb.func_log = selinux_log;
+		cb.func_log = selinux_log_direct;
 		break;
 	case SELINUX_CB_AUDIT:
 		cb.func_audit = selinux_audit;
diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index 03d87f0c..f4dab157 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -10,9 +10,11 @@
 #include <string.h>
 #include <selinux/selinux.h>
 
+#include "selinux_internal.h"
+
 /* callback pointers */
 extern int __attribute__ ((format(printf, 2, 3)))
-(*selinux_log) (int type, const char *, ...) ;
+(*selinux_log_direct) (int type, const char *, ...) ;
 
 extern int
 (*selinux_audit) (void *, security_class_t, char *, size_t) ;
@@ -26,4 +28,13 @@ extern int
 extern int
 (*selinux_netlink_policyload) (int seqno) ;
 
+/* Thread-safe selinux_log() function */
+extern pthread_mutex_t log_mutex;
+
+#define selinux_log(type, ...) do { \
+	__pthread_mutex_lock(&log_mutex); \
+	selinux_log_direct(type, __VA_ARGS__); \
+	__pthread_mutex_unlock(&log_mutex); \
+} while(0)
+
 #endif				/* _SELINUX_CALLBACKS_H_ */
-- 
2.31.1

