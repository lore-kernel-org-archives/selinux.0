Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D459C433EF
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 07:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359009AbiATHd5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiATHdz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 02:33:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8AC061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 23:33:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e9so4895662pgb.3
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 23:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MbXPaMC/iq2p4K/m9u2asFhgk8DrTOUj+XKBbs5jfeg=;
        b=Xgf5nyWUMpHO77/ZZbf9DGcZ16K4Y2th/df0vnYIJGHAD4J9QWl/RAEDeRXdB5pQw3
         9w7ZrfTvTjIFhZgdpvKMCgIKngCubrqXLP2L3hTxWGCBPq5OUIB7SrGk135gx4ybdtxV
         ATmnHHSjUHYmGUE3RA9Xo0+ZVEk3NYQQkDEh7AW2uNrJBAyn4qqujJ043eaJiXPx/btD
         IhQK8i0N7RnQZUOHTkUKmYNNB4jx7jfBsVpqbMAXWB1h4csVuKKFJFGS7ru+INLkHpEd
         Pad+qvXQp9Lncr51zTfPu3f2bUP6+yDzJ16x6/4rA8z2ayfwaIpwTip1+UuwRXM9HiA3
         08/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MbXPaMC/iq2p4K/m9u2asFhgk8DrTOUj+XKBbs5jfeg=;
        b=AEfrk48vjwTtMdFPpJi/sU/bg4G4kDyR2XkMjhXGggYGo0ThXLAJ94NH+G377ZONhK
         AT0qm4CEIUnJy5HtIQ7w8aXmJAIM1JrP5e7fICTe8nY72TuRG+7zPleOvo8CLh8uFMvx
         IZM0jVaZZf814EfT00dETbNXBETWiwxMvC8/fR3CPJWlGn80RZYlEea2OzdmWguLbeCZ
         lPIQ2WOc4nNQU56K/0CT++ravDKXG+uVtNqlM/aKVJhvPwoPlPIcDQlSmx1uL87gyhsO
         zQ/k+NFwVj9lemyoqx4k/i3t2PenFWyRkE6cjKso29VtjyDaGOqpzdpPgTm4dWfzOvGA
         /lQA==
X-Gm-Message-State: AOAM532FszGwQTwLBXVwQh4XiEggZrcGs5Y1Obyi81g6cERqdKxloLc4
        zWJPRzYzRMsGLBZLMQA8KmI1ZmTsKyQa/Q==
X-Google-Smtp-Source: ABdhPJywuS9YQ18ux04QUoNiKmgia+mc5zC6NDvv1ldHyMrUcaBUC+FliEw2HRzZMk2UqVQzlKZYeg==
X-Received: by 2002:a63:b702:: with SMTP id t2mr31099407pgf.49.1642664033924;
        Wed, 19 Jan 2022 23:33:53 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a410:a06c:fcc7:e7a9:a2ac:7bc5])
        by smtp.gmail.com with ESMTPSA id j11sm2109694pfc.188.2022.01.19.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:33:53 -0800 (PST)
From:   Purushottam Choudhary <purushottamchoudhary29@gmail.com>
To:     selinux@vger.kernel.org
Cc:     ranjitsinh.rathod@kpit.com,
        purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [libselinux][PATCH] libselinux: make threadsafe for discover_class_cache
Date:   Thu, 20 Jan 2022 13:03:29 +0530
Message-Id: <20220120073329.15234-1-purushottamchoudhary29@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: purushottam Choudhary <purushottamchoudhary29@gmail.com>

Crash is observed in process dbus-daemon while accessing name
from discover_class_cache structure variable,
discover_class_cache->name vairable found NULL
during backtrace analysis.
Add mutex lock for the discover_class_cache to handle multiple
threads for the function which uses discover_class_cache
This avoids variable corruption during parallel access
in the multiple thread environment.

Signed-off-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>
---
 libselinux/src/avc.c       |  7 +++++--
 libselinux/src/stringrep.c | 24 ++++++++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 7493e4b2..4fbaa30d 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -685,8 +685,11 @@ static void avc_dump_query(security_id_t ssid, security_id_t tsid,
 		   ssid->ctx, tsid->ctx);
 
 	avc_release_lock(avc_lock);
-	log_append(avc_audit_buf, " tclass=%s",
-		   security_class_to_string(tclass));
+	char *tclass_name = security_class_to_string(tclass);
+	log_append(avc_audit_buf, " tclass=%s", tclass_name);
+	if (tclass_name != NULL) {
+		free(tclass_name);
+	}
 }
 
 void avc_audit(security_id_t ssid, security_id_t tsid,
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 2fe69f43..52ae3f2d 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -19,6 +19,7 @@
 
 #define MAXVECTORS 8*sizeof(access_vector_t)
 
+pthread_mutex_t cache_mutex = PTHREAD_MUTEX_INITIALIZER;
 struct discover_class_node {
 	char *name;
 	security_class_t value;
@@ -140,9 +141,10 @@ static struct discover_class_node * discover_class(const char *s)
 	}
 	closedir(dir);
 
+	__pthread_mutex_lock(&cache_mutex);
 	node->next = discover_class_cache;
 	discover_class_cache = node;
-
+	__pthread_mutex_unlock(&cache_mutex);
 	return node;
 
 err4:
@@ -160,6 +162,7 @@ err1:
 
 void selinux_flush_class_cache(void)
 {
+	__pthread_mutex_lock(&cache_mutex);
 	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
 	size_t i;
 
@@ -178,6 +181,7 @@ void selinux_flush_class_cache(void)
 	}
 
 	discover_class_cache = NULL;
+	__pthread_mutex_unlock(&cache_mutex);
 }
 
 
@@ -185,6 +189,7 @@ security_class_t string_to_security_class(const char *s)
 {
 	struct discover_class_node *node;
 
+	__pthread_mutex_lock(&cache_mutex);
 	node = get_class_cache_entry_name(s);
 	if (node == NULL) {
 		node = discover_class(s);
@@ -195,7 +200,9 @@ security_class_t string_to_security_class(const char *s)
 		}
 	}
 
-	return map_class(node->value);
+	security_class_t ret_value = map_class(node->name);
+	__pthread_mutex_unlock(&cache_mutex);
+	return ret_value;
 }
 
 security_class_t mode_to_security_class(mode_t m) {
@@ -224,6 +231,7 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	struct discover_class_node *node;
 	security_class_t kclass = unmap_class(tclass);
 
+	__pthread_mutex_lock(&cache_mutex);
 	node = get_class_cache_entry_value(kclass);
 	if (node != NULL) {
 		size_t i;
@@ -233,6 +241,7 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	}
 
 	errno = EINVAL;
+	__pthread_mutex_unlock(&cache_mutex);
 	return 0;
 }
 
@@ -242,11 +251,14 @@ const char *security_class_to_string(security_class_t tclass)
 
 	tclass = unmap_class(tclass);
 
+	__pthread_mutex_lock(&cache_mutex);
+	char *node_name = NULL;
 	node = get_class_cache_entry_value(tclass);
-	if (node == NULL)
-		return NULL;
-	else
-		return node->name;
+	if (node != NULL) {
+		node_name = strdup(node->name);
+	}
+	__pthread_mutex_unlock(&cache_mutex);
+	return node_name;
 }
 
 const char *security_av_perm_to_string(security_class_t tclass,
-- 
2.17.1

