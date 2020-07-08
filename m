Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE265C433E1
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B822920772
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZxbH6NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgGHLY7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:24:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728706AbgGHLY7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 07:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594207496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au2z6LK0sGGWRmC9mXHPh7aI4IUKmj1NA9DV3+5TidE=;
        b=XZxbH6NXxamqnaQGpJe+HF9jK7Vn64PrxOdoLbmTrRFeHB96gJlNM/P94xXDy4n0zf9rDd
        1lbwDmI8PBrw5uIjEdA+YA5Zh1cnAvkIEUePH79TICznbh7PTYGwB34EdCtsAIaIcHtuja
        rL3DP+TCuncBhN3U1f6Ba0QSQmKDqx0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-a-cIb7pjO3ykvCCfkP20tQ-1; Wed, 08 Jul 2020 07:24:55 -0400
X-MC-Unique: a-cIb7pjO3ykvCCfkP20tQ-1
Received: by mail-ej1-f72.google.com with SMTP id e21so43330361ejr.9
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 04:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=au2z6LK0sGGWRmC9mXHPh7aI4IUKmj1NA9DV3+5TidE=;
        b=nQ8e6cpcg4vBQj+znSS5TG47LEh4Cg5LTYcSkQ9Ag/EK8BlwmYLZz7QpswswUaA2cl
         bgUEF1G/SYvRgI58CjbP98taGx+SCnxfqPIWO8wzytJS6XovCtsnkXVRkTvlkn0r9dHg
         pps7KU+8uqD9K/lSd0bzcmbBJuNL1t4n+yU6zU+zvdjWUrTBh8buVS6DMHrOUWucbM2F
         98UzdKbC95Va/8KBrh+H3tCI0r7tnjvBGzYSeva8Hhh5XX27G8XtHc3aVV5VChNhjgRN
         H0NByZNHQFNhuy77cdt5D5alKuBYlq76qPdAeRjp9lH6yKV7UQ414ALsjSDtR9SARTZh
         bvUw==
X-Gm-Message-State: AOAM533KgZgXmCcGrEtLcHVw8PBMrJ7xZxykc/A0/mx7f44Hs1SgpXBO
        7mYI9k/UOe5sAys81A+mFegbiJWaqIYdsYdGBd3DRcZqrv4s2i9k/ansyRMG27mOcgM7hwqLecf
        IltYTFv8tJ82kixqNJA==
X-Received: by 2002:a17:906:e51:: with SMTP id q17mr1230346eji.218.1594207493757;
        Wed, 08 Jul 2020 04:24:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOWGycr6pzQDuonILgBUroBaIH3xbBWWGzN35Joflrsi0OFXae+yRI7psURgzIo1f5405cGA==
X-Received: by 2002:a17:906:e51:: with SMTP id q17mr1230336eji.218.1594207493515;
        Wed, 08 Jul 2020 04:24:53 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm1839374ejd.50.2020.07.08.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:24:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 3/3] selinux: complete the inlining of hashtab functions
Date:   Wed,  8 Jul 2020 13:24:47 +0200
Message-Id: <20200708112447.292321-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708112447.292321-1-omosnace@redhat.com>
References: <20200708112447.292321-1-omosnace@redhat.com>
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

