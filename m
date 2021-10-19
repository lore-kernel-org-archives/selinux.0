Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79696C43219
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6469860FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhJSPDu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232402AbhJSPDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=Irv9dTh0d0suf+HMpRPu8ddKkbjHh9+N52GqubTJ+yG69EkcWmPvOZGbNFP2RwWJ3VBSsW
        YBTbwfVsAjhSmRYZc1ij0Az1Nc+8cVl5yP+SAchHJWS2FNIABdKSL7ztZinHrQ2J1pd3hz
        O/DyJ5DnBOXdVwhPBwMr1HplKjDfcmo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-m9RIxGPuO6WOMejIhIVPqg-1; Tue, 19 Oct 2021 11:01:30 -0400
X-MC-Unique: m9RIxGPuO6WOMejIhIVPqg-1
Received: by mail-wm1-f72.google.com with SMTP id n9-20020a1c7209000000b0030da7d466b8so1267094wmc.5
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=ZroP6QEejwARJP9a2MtCQHj7oo4us4CZJsW2zG6P374edJKI0cPqfm0rDmJCvxrkG/
         m/yUBndY2wyPiMgaLmMDbNGh1jH67HRfX1OioTI4oV8CPGg0aAtLOH9I0l6u5U4L8wxi
         mIaONxjr/426SpSq+IQwpQvL7Nj7CEp3Jey9765a7rlSC9qtR3go6Ots1I4C9keNZo/P
         TQY8JnhL67jIWn6OfdBqj2OXCKjpWuGC3/wZFkN8o32gFJuZciwj0sjSoer9saviIvha
         +hyKAVhbYI2OnoVPePcts1DpoFGfd/+C1qr6rRTqWn+GAgzAOWFOqnQv35E8A8D33C3C
         +wbA==
X-Gm-Message-State: AOAM530iQI2mmeHB7QP+qVLd+t5KqIKt7MbMTy5XgMpSodL8GdNtIhlU
        vrB+jJbsb3TEIHkOGmlrtmuqYv8AeOmEi7FjlVyjoaSnTcKhtTIxeWmcJNqNU+2nxLpWFt4+mFb
        osdMNThxvuD0EujzycjuT0+EgtKwOlcH3G0WWQXDmCuksBUiKNRnhimxkbJZKwjARQ01PXw==
X-Received: by 2002:a05:6000:2ca:: with SMTP id o10mr44831413wry.383.1634655688016;
        Tue, 19 Oct 2021 08:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy+DnYCYTaoUFm96se4Kc24nssZwcTj0Nu4GLtgf0AWRKitxbqfCP2rF+kTp9F6lvbTNXVlw==
X-Received: by 2002:a05:6000:2ca:: with SMTP id o10mr44831371wry.383.1634655687754;
        Tue, 19 Oct 2021 08:01:27 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:27 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 4/7] libselinux: make selinux_log() thread-safe
Date:   Tue, 19 Oct 2021 17:01:19 +0200
Message-Id: <20211019150122.459722-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
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

