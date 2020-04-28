Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B8C83006
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA28206D9
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkOmpOhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD1Mza (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbgD1Mza (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 08:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCGJqawdTA0RmAdD6MzJ1hAHyjIHoPCxAfvHZe5YuWE=;
        b=KkOmpOhBCJpp6UfMr262fskG8c7atXjO3bVqROm3mwZaWNh2Q0FbrwHcDDB/Y6EPV+DYa/
        TYE2fgQW3t88h1AK7OwJc9NHgCVL61gUaUPCH2oLVbiHFH4FfL/gMsQBVVZhTxW+cNoaJb
        L3yi+gJ2WI3Tan6Lcs9tRGtjouW4Rqk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-AkAtEVE6PfWgtkPOGH9WpQ-1; Tue, 28 Apr 2020 08:55:26 -0400
X-MC-Unique: AkAtEVE6PfWgtkPOGH9WpQ-1
Received: by mail-wr1-f70.google.com with SMTP id r17so12265911wrg.19
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 05:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCGJqawdTA0RmAdD6MzJ1hAHyjIHoPCxAfvHZe5YuWE=;
        b=UmMHaJFWA+uJMIuL7Ziw3gAP6y3SMlNVbN9T3VkJ06/OC0py81IvrD5biaSNGTM2XB
         Ga44AFGSfmKp/Yrzz2DW2ns4iHOCNajlevTHAnWlI/6E/68xbksfzv7/a2N/0amYQjdj
         wXpyYNBoEHrhX+QLd07RjxAkgcybmQXqi+9Do+91gcfIMT2mjTaRd7gHPuV+J6CbuOwL
         EArg2njocTz0djtzQP5IOQ8f1jAI7fOM/Oi0KmuQA3hvq/Jo2x3EGxYtMADylEGTPzdP
         wR4/4rTndYmleLiQuByB6Qf3YLIp5cpdWmiQXR1uWg4yB2XPKMJuOs+QGOoz3mu1/+Gd
         /b9A==
X-Gm-Message-State: AGi0PuYcngdayCFupf2fow+N2iwMzMXOSXC1Q5VDNQhL109/IwkHZvqV
        LxznNxOIhmJMh2k+8fGO0L66meN3AmRIejqTbZ2WZIg7Xqdc8FyKxY4cqB8vey/U/efZLHSTP6Q
        hGjrETIF5nXi2YKFIJA==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr4337067wma.28.1588078524179;
        Tue, 28 Apr 2020 05:55:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypIDF8xr40OcuN4xF1+tu+GXOOrZFsFihlMyFr79KjB1A+EcHCVdk7h/5jA1A43GN37jNxW1Sw==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr4337040wma.28.1588078523835;
        Tue, 28 Apr 2020 05:55:23 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y63sm3082438wmg.21.2020.04.28.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:55:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 4/4] selinux: complete the inlining of hashtab functions
Date:   Tue, 28 Apr 2020 14:55:14 +0200
Message-Id: <20200428125514.2780171-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200428125514.2780171-1-omosnace@redhat.com>
References: <20200428125514.2780171-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move (most of) the definitions of hashtab_search(), hashtab_insert(),
and hashtab_map() to the header file and make them inline. This avoids
indirect function calls and allows better optimization, leading to a
drastic performance improvement of these operations.

For example, the duration of security_transition_sid() (which now spends
a lot of its time doing hashtab lookups) when called from
selinux_msg_queue_msgsnd() is cut by half thanks to this patch. This was
measured by analysing the following command using the perf tool:

    stress-ng --msg 1 --msg-ops 4000000

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c | 79 +++-----------------------------
 security/selinux/ss/hashtab.h | 84 +++++++++++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 8126b909a757..e5af05770e43 100644
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
@@ -124,26 +75,6 @@ void hashtab_destroy(struct hashtab *h)
 	h->htable = NULL;
 }
 
-int hashtab_map(struct hashtab *h,
-		int (*apply)(void *k, void *d, void *args),
-		void *args)
-{
-	u32 i;
-	int ret;
-	struct hashtab_node *cur;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret)
-				return ret;
-			cur = cur->next;
-		}
-	}
-	return 0;
-}
-
 
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 4885234257d4..a6ccf695405b 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -11,7 +11,10 @@
 #ifndef _SS_HASHTAB_H_
 #define _SS_HASHTAB_H_
 
-#define HASHTAB_MAX_NODES	0xffffffff
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#define HASHTAB_MAX_NODES	U32_MAX
 
 struct hashtab_key_params {
 	u32 (*hash)(const void *key);	/* hash function */
@@ -43,6 +46,9 @@ struct hashtab_info {
  */
 int hashtab_init(struct hashtab *h, u32 nel_hint);
 
+int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
+		     void *key, void *datum);
+
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
  *
@@ -51,8 +57,34 @@ int hashtab_init(struct hashtab *h, u32 nel_hint);
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
@@ -60,8 +92,28 @@ int hashtab_insert(struct hashtab *h, void *k, void *d,
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
@@ -79,9 +131,25 @@ void hashtab_destroy(struct hashtab *h);
  * iterating through the hash table and will propagate the error
  * return to its caller.
  */
-int hashtab_map(struct hashtab *h,
-		int (*apply)(void *k, void *d, void *args),
-		void *args);
+static inline int hashtab_map(struct hashtab *h,
+			      int (*apply)(void *k, void *d, void *args),
+			      void *args)
+{
+	u32 i;
+	int ret;
+	struct hashtab_node *cur;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret)
+				return ret;
+			cur = cur->next;
+		}
+	}
+	return 0;
+}
 
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
-- 
2.25.4

