Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0FC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E513C2078B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTsOygEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGITUC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:20:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgGITUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 15:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594322400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAziBYEfanUcQgnObCkYCVZQEnz7vEDFmXkGcLPHS+8=;
        b=WTsOygEOD5CWWlIY63zV+shQ4BtmEORZ1qHbHenYqo/dcGtepH329pIipljEQkniXvrmpK
        XnkgzlvzeqJhgsP4+H0PJ2zeR+iECJzHh32vvPtY9GmLKJzCxtTaD1QF6fpHP7cWpnFnkd
        5sp6Sy5cEQh+MxBa9nR9lSPe9Li0rTk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-q5P9nzqmOA6a17Rh-3zNOw-1; Thu, 09 Jul 2020 15:19:58 -0400
X-MC-Unique: q5P9nzqmOA6a17Rh-3zNOw-1
Received: by mail-wr1-f71.google.com with SMTP id b14so2899112wrp.0
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 12:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAziBYEfanUcQgnObCkYCVZQEnz7vEDFmXkGcLPHS+8=;
        b=pxdakfwzD45lPvd1HAp9n+I9doAeZw1pfhvDokuVZK/MPhBKpwu3YORHNnLjokYhoy
         KIBVn3rr/H+Dmwgt3Gwvm6AiIu/y6p9df5jQS3Z58M5yys8cP43q1nYkmm3T2KsMRPYd
         ZjpFerK2u54vBbJJjdSm2b5NcKgMXTKZIUyT6g7n+THOPJGHNaV5NKitjV5A8xafKqcm
         oCotLk6kjkl9SojCF/EpqwULuoOir9wrKTVSI2YsilaicQyBhp1W8L4dakAviGpU/TE2
         BTnuu9n8WPQEeEjIbQUU4BvtpLVOEQ5ojG9NuwcnLVFw1tfAYc7/+SJ96i39f2yFKy1T
         zOZQ==
X-Gm-Message-State: AOAM533ENZg5NGstKyqxP6wXQjJEObFKp77HHFgGqtLXqbxgcPXAXHWy
        9J08PMUDaEZzlDPMad3DbDAs0XpRcy2nlONi8XvzizQ30geddjiPTpTzjtDj/X4HCMCO/fVwkbU
        +Ow5ED4f+N3M6UZzayw==
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr38642091wrm.116.1594322396643;
        Thu, 09 Jul 2020 12:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwISMMRHza/YJJ8ufCVbpSWVwVlrolNA7kvIYXA3VVKm5MgCNjggA35JNNXpH4thV5jx0llCQ==
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr38642072wrm.116.1594322396282;
        Thu, 09 Jul 2020 12:19:56 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id f14sm7205086wro.90.2020.07.09.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 12:19:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 2/2] selinux: complete the inlining of hashtab functions
Date:   Thu,  9 Jul 2020 21:19:52 +0200
Message-Id: <20200709191952.435970-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709191952.435970-1-omosnace@redhat.com>
References: <20200709191952.435970-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move (most of) the definitions of hashtab_search() and hashtab_insert()
to the header file. In combination with the previous patch, this avoids
calling the callbacks indirectly by function pointers and allows for
better optimization, leading to a drastic performance improvement of
these operations.

With this patch, I measured a speed up in the following areas (measured
on x86_64 F32 VM with 4 CPUs):
  1. Policy load (`load_policy`) - takes ~150 ms instead of ~230 ms.
  2. `chcon -R unconfined_u:object_r:user_tmp_t:s0:c381,c519 /tmp/linux-src`
     where /tmp/linux-src is an extracted linux-5.7 source tarball -
     takes ~522 ms instead of ~576 ms. This is because of many
     symtab_search() calls in string_to_context_struct() when there are
     many categories specified in the context.
  3. `stress-ng --msg 1 --msg-ops 10000000` - takes 12.41 s instead of
     13.95 s (consumes 18.6 s of kernel CPU time instead of 21.6 s).
     This is thanks to security_transition_sid() being ~43% faster after
     this patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/hashtab.c | 59 +++-----------------------------
 security/selinux/ss/hashtab.h | 63 ++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 8126b909a7574..d9287bb4bfebb 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include "hashtab.h"
 
 static struct kmem_cache *hashtab_node_cachep;
@@ -40,71 +39,23 @@ int hashtab_init(struct hashtab *h, u32 nel_hint)
 	return h->htable ? 0 : -ENOMEM;
 }
 
-int hashtab_insert(struct hashtab *h, void *key, void *datum,
-		   struct hashtab_key_params key_params)
+int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
+		     void *key, void *datum)
 {
-	u32 hvalue;
-	struct hashtab_node *prev, *cur, *newnode;
-
-	cond_resched();
-
-	if (!h->size || h->nel == HASHTAB_MAX_NODES)
-		return -EINVAL;
-
-	hvalue = key_params.hash(key) & (h->size - 1);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur) {
-		int cmp = key_params.cmp(key, cur->key);
-
-		if (cmp == 0)
-			return -EEXIST;
-		if (cmp < 0)
-			break;
-		prev = cur;
-		cur = cur->next;
-	}
+	struct hashtab_node *newnode;
 
 	newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_KERNEL);
 	if (!newnode)
 		return -ENOMEM;
 	newnode->key = key;
 	newnode->datum = datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
+	newnode->next = *dst;
+	*dst = newnode;
 
 	h->nel++;
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, const void *key,
-		     struct hashtab_key_params key_params)
-{
-	u32 hvalue;
-	struct hashtab_node *cur;
-
-	if (!h->size)
-		return NULL;
-
-	hvalue = key_params.hash(key) & (h->size - 1);
-	cur = h->htable[hvalue];
-	while (cur) {
-		int cmp = key_params.cmp(key, cur->key);
-
-		if (cmp == 0)
-			return cur->datum;
-		if (cmp < 0)
-			break;
-		cur = cur->next;
-	}
-	return NULL;
-}
-
 void hashtab_destroy(struct hashtab *h)
 {
 	u32 i;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 4885234257d40..3c952f0f01f9c 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -11,7 +11,11 @@
 #ifndef _SS_HASHTAB_H_
 #define _SS_HASHTAB_H_
 
-#define HASHTAB_MAX_NODES	0xffffffff
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#define HASHTAB_MAX_NODES	U32_MAX
 
 struct hashtab_key_params {
 	u32 (*hash)(const void *key);	/* hash function */
@@ -43,6 +47,9 @@ struct hashtab_info {
  */
 int hashtab_init(struct hashtab *h, u32 nel_hint);
 
+int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
+		     void *key, void *datum);
+
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
  *
@@ -51,8 +58,34 @@ int hashtab_init(struct hashtab *h, u32 nel_hint);
  * -EINVAL for general errors or
   0 otherwise.
  */
-int hashtab_insert(struct hashtab *h, void *k, void *d,
-		   struct hashtab_key_params key_params);
+static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
+				 struct hashtab_key_params key_params)
+{
+	u32 hvalue;
+	struct hashtab_node *prev, *cur;
+
+	cond_resched();
+
+	if (!h->size || h->nel == HASHTAB_MAX_NODES)
+		return -EINVAL;
+
+	hvalue = key_params.hash(key) & (h->size - 1);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
+
+		if (cmp == 0)
+			return -EEXIST;
+		if (cmp < 0)
+			break;
+		prev = cur;
+		cur = cur->next;
+	}
+
+	return __hashtab_insert(h, prev ? &prev->next : &h->htable[hvalue],
+				key, datum);
+}
 
 /*
  * Searches for the entry with the specified key in the hash table.
@@ -60,8 +93,28 @@ int hashtab_insert(struct hashtab *h, void *k, void *d,
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, const void *k,
-		     struct hashtab_key_params key_params);
+static inline void *hashtab_search(struct hashtab *h, const void *key,
+				   struct hashtab_key_params key_params)
+{
+	u32 hvalue;
+	struct hashtab_node *cur;
+
+	if (!h->size)
+		return NULL;
+
+	hvalue = key_params.hash(key) & (h->size - 1);
+	cur = h->htable[hvalue];
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
+
+		if (cmp == 0)
+			return cur->datum;
+		if (cmp < 0)
+			break;
+		cur = cur->next;
+	}
+	return NULL;
+}
 
 /*
  * Destroys the specified hash table.
-- 
2.26.2

