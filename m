Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1BC07E99
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ACB613C3
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGITKy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITKx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jul 2021 15:10:53 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F0C0613DD
        for <selinux@vger.kernel.org>; Fri,  9 Jul 2021 12:08:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed21430000b029024e7e455d67so6333475qtc.16
        for <selinux@vger.kernel.org>; Fri, 09 Jul 2021 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CRgXHjFbThyiYfOk42TTZiXfSglfdisccALPSKqrllA=;
        b=K8qIXmOvDXZ3UrgiKRXsUHBGJinaM5LbjbmkzBIqoWZjxSmu+D7pT67SjUzTJWk1NJ
         oUz30/haMeHvg7AUQ2cHCLstBTna+gHW2cvd8QwYCBqpsIVoEL8C219MiESjtOCjZbWn
         x3vmDraryN9EU48qdXxF8X/00FSh2ygBckuPRoE0qc6/5OuOzQA5jH77HRB5N9ZsSYOT
         rjfRZgBwdxLLZB+DT7YC+Fv/3FL97byVkqqWKUrbhO3Uu8yGdi0pRd1fBbBwdvJ5v3Fi
         H1jrppSm3akyQwRpQ0fOEhSVqEOA5D+HtWBZ6YHJ5dWzvsnc9EXYKsr0GNVahGSCFmRm
         w4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CRgXHjFbThyiYfOk42TTZiXfSglfdisccALPSKqrllA=;
        b=D2HVR7d7Z5MWvIwpUoNibRtNd99xAOFQs4K5xryn9tmqIIQpxYzKv9KcZ8lOeZ8MhV
         DjGWZrIo2nRrePdAZLdTRmRSUP2yMB+cptBJM6+JlZAvGRGUrpI+QdT9GV5uoFEHQhDg
         9+8Zm0NhHwYAsmUe5faelpzovw6FHWTY9WyT6pgG752yG5HF9Nm7TlPu4AnhIZaYEvJF
         COLVNE1yMoEc+A3syw6XpHaf4qB+/pF3xaMJKoqCMpB7Cx8IJXSkDPQnThy6sY13ran3
         gKsuci3sPMs3bnx3H4k0TVMfIkNRsv4GvzRaccUWPdZfCK00NjjoYwAy2151nYjmMJqj
         mZwg==
X-Gm-Message-State: AOAM5306/yc+R/qkML+Q1CffPkD+iHRcTARqHslSrDrpLCjSiIy27DF2
        pxSqS4s+ptYsogKzqL23GNY4wLJGgKPdkKkZTZoH+cVOIwM/DHdG4ZtUzG4BfuHJ0Tpmt++vif3
        cH4+QiDCkRuMtRX4o9qdA6e/i7p76nz0d0C9af+Q1lVzO+8Fq6UJtcKGkaDLH1rU=
X-Google-Smtp-Source: ABdhPJwTY4rDVpfX+6i2Znq4fmYzZOJPxKJuFWZwC+XfYWIhnmfpT3N7jyEhrOSV1QciktDRfHsTih1tmT8=
X-Received: from sethmo-lotsa-cores.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2959])
 (user=sethmo job=sendgmr) by 2002:a0c:fc43:: with SMTP id w3mr38041478qvp.0.1625857688056;
 Fri, 09 Jul 2021 12:08:08 -0700 (PDT)
Date:   Fri,  9 Jul 2021 19:08:03 +0000
Message-Id: <20210709190803.1700915-1-sethmo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] libselinux: add lock callbacks
From:   Seth Moore <sethmo@google.com>
To:     selinux@vger.kernel.org
Cc:     Seth Moore <sethmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The old mechanism to initialize AVC, avc_init(3), is deprected. This
leaves libselinux with no way of guarding the AVC cache when accessed
from multiple threads. When applications call access check APIs from
multiple threads, the AVC cache may become corrupted.

This change adds new callback functions to selinux_set_callback(3).
These new callbacks all correspond to the functions that used to be
passed via avc_init(3). Multi-threaded applications may set these
callbacks to guard the AVC cache against simultaneous access by
multiple threads.

This change adds the following callbacks:
  - SELINUX_CB_ALLOC_LOCK
      is invoked to allocate new locks
  - SELINUX_CB_GET_LOCK
      is invoked to acquire a lock
  - SELINUX_CB_RELEASE_LOCK
      is invoked to release a previously-acquired lock
  - SELINUX_CB_FREE_LOCK
      is invoked to free a previosly-allocated lock

Signed-off-by: Seth Moore <sethmo@google.com>
---
 libselinux/include/selinux/selinux.h       | 12 ++++++
 libselinux/man/man3/selinux_set_callback.3 | 46 ++++++++++++++++++++++
 libselinux/src/avc_internal.h              | 22 +++++++++--
 libselinux/src/callbacks.c                 | 13 ++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index ae98a92e..c3c68b3a 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -166,6 +166,14 @@ __attribute__ ((format(printf, 2, 3)))
 	int (*func_setenforce) (int enforcing);
 	/* netlink callback for policyload message */
 	int (*func_policyload) (int seqno);
+	/* create a lock and return an opaque pointer to it */
+	void *(*func_alloc_lock) (void);
+	/* obtain a given lock, blocking if necessary */
+	void (*func_get_lock) (void *lock);
+	/* release a given lock */
+	void (*func_release_lock) (void *lock);
+	/* destroy a given lock */
+	void (*func_free_lock) (void *lock);
 };
 
 #define SELINUX_CB_LOG		0
@@ -173,6 +181,10 @@ __attribute__ ((format(printf, 2, 3)))
 #define SELINUX_CB_VALIDATE	2
 #define SELINUX_CB_SETENFORCE	3
 #define SELINUX_CB_POLICYLOAD	4
+#define SELINUX_CB_ALLOC_LOCK   5
+#define SELINUX_CB_GET_LOCK     6
+#define SELINUX_CB_RELEASE_LOCK 7
+#define SELINUX_CB_FREE_LOCK    8
 
 extern union selinux_callback selinux_get_callback(int type);
 extern void selinux_set_callback(int type, union selinux_callback cb);
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 75f49b06..f7371504 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -116,6 +116,52 @@ The
 .I seqno
 argument is the current sequential number of the policy generation in the system.
 .
+.TP
+.B SELINUX_CB_ALLOC_LOCK
+.BI "void *(*" alloc_lock ") ();"
+
+This callback is used to allocate a fresh lock for protecting critical sections.
+Applications that call selinux library functions from multiple threads must either
+perform their own locking or set each of the following:
+
+.B SELINUX_CB_ALLOC_LOCK
+
+.B SELINUX_CB_GET_LOCK
+
+.B SELINUX_CB_RELEASE_LOCK
+
+.B SELINUX_CB_FREE_LOCK
+
+.TP
+.B SELINUX_CB_GET_LOCK
+.BI "void (*" get_lock ") (void *" lock ");"
+
+This callback acquires the
+.I lock
+that was previously allocated with
+.I alloc_lock.
+This function must block until the
+.I lock
+can be acquired.
+.
+.TP
+.B SELINUX_CB_RELEASE_LOCK
+.BI "void (*" release_lock ") (void *" lock ");"
+
+This callback releases the
+.I lock
+that was previously acquired with
+.I get_lock.
+.
+.TP
+.B SELINUX_CB_FREE_LOCK
+.BI "void (*" free_lock ") (void *" lock ");"
+
+This callback frees the
+.I lock
+that was previously allocated with
+.I alloc_lock.
+.
 .SH "RETURN VALUE"
 None.
 .
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index a9a4aa0b..f23690a1 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -9,6 +9,7 @@
 #ifndef _SELINUX_AVC_INTERNAL_H_
 #define _SELINUX_AVC_INTERNAL_H_
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -112,26 +113,41 @@ static inline void avc_stop_thread(void *thread)
 		avc_func_stop_thread(thread);
 }
 
+#define CHECK_LOCK_CALLBACKS() \
+    if (avc_func_alloc_lock \
+            || avc_func_get_lock \
+            || avc_func_release_lock \
+            || avc_func_free_lock) { \
+        assert(avc_func_alloc_lock \
+                && avc_func_get_lock \
+                && avc_func_release_lock \
+                && avc_func_free_lock); \
+    }
+
 static inline void *avc_alloc_lock(void)
 {
+	CHECK_LOCK_CALLBACKS();
 	return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
 }
 
 static inline void avc_get_lock(void *lock)
 {
-	if (avc_func_get_lock)
+	CHECK_LOCK_CALLBACKS();
+	if (avc_func_get_lock && lock)
 		avc_func_get_lock(lock);
 }
 
 static inline void avc_release_lock(void *lock)
 {
-	if (avc_func_release_lock)
+	CHECK_LOCK_CALLBACKS();
+	if (avc_func_release_lock && lock)
 		avc_func_release_lock(lock);
 }
 
 static inline void avc_free_lock(void *lock)
 {
-	if (avc_func_free_lock)
+	CHECK_LOCK_CALLBACKS();
+	if (avc_func_free_lock && lock)
 		avc_func_free_lock(lock);
 }
 
diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index c18ccc54..b635c8d8 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <selinux/selinux.h>
 #include "callbacks.h"
+#include "avc_internal.h"
 
 /* default implementations */
 static int __attribute__ ((format(printf, 2, 3)))
@@ -95,6 +96,18 @@ selinux_set_callback(int type, union selinux_callback cb)
 	case SELINUX_CB_POLICYLOAD:
 		selinux_netlink_policyload = cb.func_policyload;
 		break;
+	case SELINUX_CB_ALLOC_LOCK:
+		avc_func_alloc_lock = cb.func_alloc_lock;
+		break;
+	case SELINUX_CB_GET_LOCK:
+		avc_func_get_lock = cb.func_get_lock;
+		break;
+	case SELINUX_CB_RELEASE_LOCK:
+		avc_func_release_lock = cb.func_release_lock;
+		break;
+	case SELINUX_CB_FREE_LOCK:
+		avc_func_free_lock = cb.func_free_lock;
+		break;
 	}
 }
 
-- 
2.32.0.93.g670b81a890-goog

