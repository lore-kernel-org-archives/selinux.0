Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF21C07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6436D61206
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 22:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGLWd1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGLWd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 18:33:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8CC0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 15:30:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a0569021005b029055b51419c7dso24266041ybt.23
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AcKTQiqn97MYk2ChbLOaIyItYJmJ17DqrBMBWaOpLLY=;
        b=guIJSuBLGq4xG3uDNCwB3SVbf/Nn/YHyLuaXiG9NZAguL8iZg0d9MWrLl3cuqp6JSF
         28dO7BaKOb7BaenIlrr3D4QH5pLfjJFdBGPlCZurONrrza92OQMuU9qfdG55vFlZ/GEe
         ug9sZ350Ziz2rewy7U+laqUvlqtQThxs5f29+mrw9T3u/ehafFEsCyWqAbi1VtVHOTta
         OUTq8aR8nRKfQ40zTh1ipPDLDE1RyVk8YvZpCRQylYgHG547MN0qPeazx4W8hgwZgw7d
         IURexvAI1AFEnnmT1lLFamU+1OO111Ky7ACytrNv7Zo9iOv6zOFpEM7Ym79JISWrdT1+
         sQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AcKTQiqn97MYk2ChbLOaIyItYJmJ17DqrBMBWaOpLLY=;
        b=cxo1HQNJXzvbjxBgwQ3eJqCavgdhoWzvxLpO6Zvfgxb0Ba0+4iNKUxQ2sUxqPoTccb
         q77kHWCRQGBPAfmXuGKlxDRYJGfvMItRrCziT9fDS5G9xSsDcTQBuwC8TgDJTlU5pbt7
         TVRRlqxBYoNPR0RwJ782Q+TV/Vii/neCIjnhJao1LV77ip4Q1trUNyEzHSVmNN5HJDgv
         K3i7lk2jG/tuMFTK7RnY+3/CddD+ZA2lKBYyULjQkmPKhPbHvGR3IcNJ9hP7Zho/KiYy
         ZlFa/RHyJljQGpVZrQ3BnFRkD7NoNKLB2SQgapyzlRN9gMbhYBQpgmfyxVzg8QF6VQ49
         6WFA==
X-Gm-Message-State: AOAM530JZm4inHf8dpwuwoy9cTVmLRtyP7RDtSZ/1rE3rE3mFqBxIVFg
        dmUJPsd83l9Xx1BuJrtiInNLQfBHE1l2i9ANRFFemV/DoNRyvHUUUXfu5flD/BWJwxuohD52sre
        djsYpkkvqs0DgrqVbPrR7Rnb5yVd/jCK89urC0dUAwhP9TV4rKoHg55wjtvfoick=
X-Google-Smtp-Source: ABdhPJwV2Xg3hBNy1EkhMT/K06i+LZw9d1bJJZ+tk00MAslJgl7VCwhgIW57OEOEGFpFfrjCfRqFKTdQg8w=
X-Received: from sethmo-lotsa-cores.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2959])
 (user=sethmo job=sendgmr) by 2002:a25:9a45:: with SMTP id r5mr1577764ybo.450.1626129037801;
 Mon, 12 Jul 2021 15:30:37 -0700 (PDT)
Date:   Mon, 12 Jul 2021 22:30:13 +0000
Message-Id: <20210712223013.2165325-1-sethmo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] libselinux: add lock callbacks
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
 libselinux/src/avc_internal.h              | 20 ++++++++--
 libselinux/src/callbacks.c                 | 13 ++++++
 4 files changed, 88 insertions(+), 3 deletions(-)

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
index a9a4aa0b..1f8e0102 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -9,6 +9,7 @@
 #ifndef _SELINUX_AVC_INTERNAL_H_
 #define _SELINUX_AVC_INTERNAL_H_
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -112,26 +113,39 @@ static inline void avc_stop_thread(void *thread)
 		avc_func_stop_thread(thread);
 }
 
+static inline void check_lock_callbacks(void)
+{
+    if (avc_func_alloc_lock || avc_func_get_lock
+            || avc_func_release_lock || avc_func_free_lock) {
+        assert(avc_func_alloc_lock && avc_func_get_lock
+                && avc_func_release_lock && avc_func_free_lock);
+    }
+}
+
 static inline void *avc_alloc_lock(void)
 {
+	check_lock_callbacks();
 	return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
 }
 
 static inline void avc_get_lock(void *lock)
 {
-	if (avc_func_get_lock)
+	check_lock_callbacks();
+	if (avc_func_get_lock && lock)
 		avc_func_get_lock(lock);
 }
 
 static inline void avc_release_lock(void *lock)
 {
-	if (avc_func_release_lock)
+	check_lock_callbacks();
+	if (avc_func_release_lock && lock)
 		avc_func_release_lock(lock);
 }
 
 static inline void avc_free_lock(void *lock)
 {
-	if (avc_func_free_lock)
+	check_lock_callbacks();
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

