Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F9FC433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFC460F0F
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhJZLzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235583AbhJZLzM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=ZRVf+C/2aSbKt8TY2Nbqd4F45giJ/4QHvbeD9MlYBmvsSN35eiveKTZ8y07DQPTb2w77z+
        eZzp8fOQMkc3atY45mT1qE3Ut+1nhhmHBo25NYwneKaflCLc3malwpAVSmtYP7OWscWAo0
        hU4pe3EPj91kW0kopTf/CQWwWi67EJM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-VWIaCABtMKGh15XZpSHgFQ-1; Tue, 26 Oct 2021 07:52:47 -0400
X-MC-Unique: VWIaCABtMKGh15XZpSHgFQ-1
Received: by mail-ed1-f69.google.com with SMTP id y3-20020a056402358300b003dd490c775cso3549592edc.22
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhVx/FPQ6AXDaf7Y/fBqCHyvSz3uZuq8CXAnzLmjIJ4=;
        b=zVOGSNhCx2Ls0jDfrfp01aSuZkOkKsS+LZ6c8KadRKgewmbsVkTuFpnWL3WTz5Mt9a
         yFwg6MAGthOJ7/oHioDkGDEqZQg+StMiMajyP7KEaDvyt5HREy/Nj+KWiXblgDekSnqD
         B97gaXF476juNlQ3dLwQyK5IWasCJs1F/PZ/WDkTRYdo45OZD0OloSfyrSgVRgMIlC+U
         bzEFKTzaQXc422cO3ds79OdfMKYfulkSR07ER1lRcWnD0XkZIjQOTjePY1nE5Lke2sqU
         CAfGEIf2MA6nN6v2SQS88vcm7Uv+MFH5XBZ+/jHmLHUNntS+xfKrvrvwqDKNzkWxacHg
         p/OA==
X-Gm-Message-State: AOAM530zNgGTJJsDdpcvimjGiEjgB8x1sNg8oxqHonjgVjzD7NgxXJd1
        0gAdLQKK7Eqky2izcHd6f92uZx/W7TxEBf8l27Vj4v0BkRL0Nrg8dpM1OQdPLgvDFkyJTEd3rbC
        Yb+Bp/qQQ0zqgBj9ulfBbd91XLnrwxq6Fuv2tvq/HAtB5DTUp95HF+4Y+KM4DbusNsFZ7Vw==
X-Received: by 2002:a05:6402:2884:: with SMTP id eg4mr2213365edb.254.1635249166081;
        Tue, 26 Oct 2021 04:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh/81v3ilTu6lbBv/2pFMJO3b4WhpXQ8sd69vCTR6wE+zDdydFrlCbaKP+NfzMRkMxRcibJQ==
X-Received: by 2002:a05:6402:2884:: with SMTP id eg4mr2213336edb.254.1635249165848;
        Tue, 26 Oct 2021 04:52:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 4/8] libselinux: make selinux_log() thread-safe
Date:   Tue, 26 Oct 2021 13:52:35 +0200
Message-Id: <20211026115239.267449-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

