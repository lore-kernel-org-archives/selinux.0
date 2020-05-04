Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73342C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 11:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E72073E
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 11:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5wxAa6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgEDL7h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 07:59:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728029AbgEDL7g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 07:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588593573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3CHLxCRGyzJQM5EgsyHKisQKJQeUcgDZaWhyPuQXtc=;
        b=Z5wxAa6JGyVcocEBp4AUKyTq6AtLBVhADAqZ0ZhDqgm2OS2aRbc8IVz5mvViYAyT+5qmAV
        JgbuegoEFcuI95EZoJSm+zd7pJHSBhgMea8b3DAslDY7DwFXsmtuw3JrMwMW5rw+6ANIiv
        x5zdjcQVDDCWJU6EV0Kn4pkc3BMeLhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-rFy5pbN2PVSuBCQTAM-KRg-1; Mon, 04 May 2020 07:59:32 -0400
X-MC-Unique: rFy5pbN2PVSuBCQTAM-KRg-1
Received: by mail-wm1-f72.google.com with SMTP id w2so4747107wmc.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2020 04:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3CHLxCRGyzJQM5EgsyHKisQKJQeUcgDZaWhyPuQXtc=;
        b=q3POAcZjRmY/d70ZJAJuQ8a3It66wNBPwmwuJFjRGgGHJoUeIWhQK9I7/B8V+waQCv
         Xl9dL7fgURBmRpb16CKBYvi82dovjvibacKhsupJmr/bYo/Sf8lFX22dpd91zMgQ66IJ
         trAOqfYx37boUgcCmXtbeCme6mN8LvMilQ3MfdbaX0Mgo05BRt+5CLdX2fYsVrl6253w
         sHtiGUjmjbLFFhDfB1yOn1hTT47Bv31hKUYotQosZKlIyNK91VxjZ9z5N0MbUflT5pxz
         UuNMMJHf78N4i8NH0SAoexTpXyVJWJgckfOPhoPpLuPq5N7+0Fm/MBbMPIo7svpfvOhI
         BLKw==
X-Gm-Message-State: AGi0PubZE6iF/V4flxkJas5E0R6ZVGV0HNgnMwqpuWvTy/E5WsuZex+f
        vXjh08+zzvYQy3BOIWgJhi3CUi0c4xyNi0Togtl0crxRN0CcrOcM4J72a3whIzy0R8XNKV4TgXe
        xyqAZ2S371+7Mxj8Zqw==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr15306831wmc.121.1588593570247;
        Mon, 04 May 2020 04:59:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypLKpOE5dnO/yO1VkfJL56DjAJMmbhyB/VasR+Hm8MDkgIu8cNsj1wCm0mqaBkxAJQ80ijXqmA==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr15306807wmc.121.1588593569977;
        Mon, 04 May 2020 04:59:29 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y9sm12524724wmm.26.2020.05.04.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:59:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 3/3] selinux: complete the inlining of hashtab functions
Date:   Mon,  4 May 2020 13:59:23 +0200
Message-Id: <20200504115923.88828-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200504115923.88828-1-omosnace@redhat.com>
References: <20200504115923.88828-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move (most of) the definitions of hashtab_search(), hashtab_insert(),
and hashtab_map() to the header file and make them inline. In
combination with the previous patch, this avoids calling the callbacks
indirectly by function pointers and allows better optimization, leading
to a drastic performance improvement of these operations.

For example, the duration of security_transition_sid() (which spends a
lot of its time doing hashtab lookups after recnt optimizations) when
called from selinux_msg_queue_msgsnd() is cut by half thanks to these
patches. This was measured by analyzing the following command using the
perf tool:

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

