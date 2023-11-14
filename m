Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9421C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKNGRL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNGRL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 01:17:11 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B44BA
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:17:07 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789577b53fso328585185a.3
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699942626; x=1700547426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBgweTzktMlBpmTS3ebYx06hjG7q4oN+e9C/Vlfw/iw=;
        b=avIscec9P/MaZiXgKrCgB6zIanF3r0I+1HzJ0KAh+wqbtCZX/otC4Mp3/WjpRY4yuO
         FSP5gj3zqLz62nCar055aCoyBZ+Zl5xYAceV8R/kffH/qFP1lPqq8MM6Ma0KeWo58ott
         mjRTOr0BjN4mKUtNZhxvsSSj5Uzh8U7FFsNwl19xUKFad1qCz0hs/TauXQVLoINLw051
         lnxp1+gVhwhLlgXpMDdD5KeyqGDq2bSQfXRisnqTt9VuKYpnvcJ3x0/cPc7mdBr+/1n9
         azEoaUFElHqliOukwSkfL1KU0BzQ1iMAQNOmJYI1RFgy8nI4XTcqd5TkTL1gTvknVxfM
         BA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699942626; x=1700547426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBgweTzktMlBpmTS3ebYx06hjG7q4oN+e9C/Vlfw/iw=;
        b=r8tvQTw6vCLQYAae9DVvgoUnQG8TgWQaLonOgAwYvMXtAXaz2YT6PVGZuf2QZ/lryK
         ICq15X7/IUp/j8eCBXepRsjkgUoSDDvAzpgWNWWOdmvwinmXmb6C9AD5GJQ5qK3Hp4W5
         HSyly0ZD7cYarXcsKnm/bR7Z5ggMA5HXNHkSoP+pGgDBJdZNQjj3nkm1oqOYhZLMtZ3g
         w3ENn30OzvwfGRreVD+d3ocKfi7ZWm0Th54iEPKfmCTI7AKq7MxupG56NMgu0p3wwO8d
         trIMRAVKuB1kFjd2/hiBk/TdrYWRd+cXKRykSv2H6R2hBmCnhprV7Q4/BixbYq+LSkGb
         clnw==
X-Gm-Message-State: AOJu0YwjtyyCq92jRdygZuF7VPeB78uGbMPo+/HTumtr+UoHqYFjEDGl
        gI6xQ4toxWRjLAD5Nf9DjLRl+FHuIaeXWj/66g==
X-Google-Smtp-Source: AGHT+IEYuswUMgctaCc46jixY5i5E6c2oRVLQDkQvi7d8c6/9VySv7yN1CGytrNbUstDeTqZRgcksg==
X-Received: by 2002:a05:620a:888b:b0:778:8fee:e863 with SMTP id qk11-20020a05620a888b00b007788feee863mr1195032qkn.75.1699942626292;
        Mon, 13 Nov 2023 22:17:06 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05620a179100b0076f124abe4dsm2413777qkb.77.2023.11.13.22.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 22:17:05 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] selinux: assorted hash table improvements
Date:   Tue, 14 Nov 2023 01:16:57 -0500
Message-ID: <20231114061656.557513-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8645; i=paul@paul-moore.com; h=from:subject; bh=6grWF3C4GmOlPpbL/Xudckh7CFv0apMjsK3ZsNimhDE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlUxDYrU3ZEddzSpdnghUE+jWhmtBjykIs1yWgk uNLFopjVryJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVMQ2AAKCRDqIPLalzeJ c/MRD/9z5znfxNMETIEyYdAqPHVZrjyK6eddUgYHWHIZU9vfPgODH5oxdCJnicuqVueMDmGDvCJ PKX4/p8XW6QowFcXyij9vnKNxWuwsowB+dNDAOEtwBPwdFXOkqnQMTepBge60w2vCs+ru2XbbVw cvba5SBy178nB0yjnFUIZbMxrh+W8c4j9vJOsxKagyJ++sR3/3KiccflEvF7SXOhVNR5UynvTpi deqwLxpxoNcZO7xWyeEY62AXiwqLxW90HrgELTzmRRNncjEWOIdCMpzHECjn9l0TrwVV8TXELyY Mq0lA/IWat9r4Zw8D4h25ZOAlfDDPFgco1apJhOhmRQccAb2TqMkJWbsx5R4YAcTEc/Qom2V2C8 heOM79KfFWPBvRvg6PwkxGYlbpi99eIbOgBpLlWTkQnlQqgmu0hJEV8ShBGh4uuDEeHYiwIrxpS 39/K98nWmODwvzoST23qYTQ9+Vwy6jYO/dm24KnbrES0sMBI3uxRD8WxgKWFtOKXNHUvT1qU23f speD6sYImmjB/9/fAfAFAZ5ah6p8J/LFmld/97wRljn6cmbSCjz0Fw1JGnPphfEl5z8RNL17GKP yfaTcA2tH1s3MKVoNpM3+TeNSJ4BOaB/HUKVnS1eL4Y3/I9lHyCtSpDGmeJusgKGB2Y++tv03y+ dY9xZYcOObiKNWQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

This is an inline patch version of a patch submitted by Linus in the
thread below.  Do not merge this patch anywhere without additional
testing or a proper commit message.

* https://lore.kernel.org/selinux/20231111160954.45911-2-paul@paul-moore.com
---
 security/selinux/ss/hashtab.c  | 78 +++++++++++++++++-----------------
 security/selinux/ss/hashtab.h  | 41 ++++++++++--------
 security/selinux/ss/policydb.c |  2 +-
 3 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index c05d8346a94a..b4bc1aebebe6 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -24,25 +24,27 @@ static struct kmem_cache *hashtab_node_cachep __ro_after_init;
  * The total memory used by the htable arrays (only) with Fedora policy loaded
  * is approximately 163 KB at the time of writing.
  */
-static u32 hashtab_compute_size(u32 nel)
+static u32 hashtab_compute_hbits(u32 nel)
 {
-	return nel == 0 ? 0 : roundup_pow_of_two(nel);
+	if (nel <= 1)
+		return nel;
+	return ilog2(nel - 1) + 1;
 }
 
 int hashtab_init(struct hashtab *h, u32 nel_hint)
 {
-	u32 size = hashtab_compute_size(nel_hint);
+	u32 hbits = hashtab_compute_hbits(nel_hint);
 
 	/* should already be zeroed, but better be safe */
 	h->nel = 0;
-	h->size = 0;
+	h->hbits = 0;
 	h->htable = NULL;
 
-	if (size) {
-		h->htable = kcalloc(size, sizeof(*h->htable), GFP_KERNEL);
+	if (hbits) {
+		h->htable = kcalloc(1 << hbits, sizeof(*h->htable), GFP_KERNEL);
 		if (!h->htable)
 			return -ENOMEM;
-		h->size = size;
+		h->hbits = hbits;
 	}
 	return 0;
 }
@@ -66,10 +68,11 @@ int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
 
 void hashtab_destroy(struct hashtab *h)
 {
-	u32 i;
-	struct hashtab_node *cur, *temp;
+	u32 size = hashtab_size(h);
+
+	for (u32 i = 0; i < size; i++) {
+		struct hashtab_node *cur, *temp;
 
-	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		while (cur) {
 			temp = cur;
@@ -81,20 +84,19 @@ void hashtab_destroy(struct hashtab *h)
 
 	kfree(h->htable);
 	h->htable = NULL;
+	h->hbits = 0;
 }
 
 int hashtab_map(struct hashtab *h,
 		int (*apply)(void *k, void *d, void *args),
 		void *args)
 {
-	u32 i;
-	int ret;
-	struct hashtab_node *cur;
+	u32 size = hashtab_size(h);
 
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
+	for (u32 i = 0; i < size; i++) {
+		struct hashtab_node *cur = cur = h->htable[i];
 		while (cur) {
-			ret = apply(cur->key, cur->datum, args);
+			int ret = apply(cur->key, cur->datum, args);
 			if (ret)
 				return ret;
 			cur = cur->next;
@@ -106,18 +108,18 @@ int hashtab_map(struct hashtab *h,
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
-	u32 i, chain_len, slots_used, max_chain_len;
+	u32 size = hashtab_size(h);
+	u32 slots_used, max_chain_len;
 	u64 chain2_len_sum;
-	struct hashtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
 	chain2_len_sum = 0;
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
+	for (u32 i = 0; i < size; i++) {
+		struct hashtab_node *cur = h->htable[i];
 		if (cur) {
+			u32 chain_len = 0;
 			slots_used++;
-			chain_len = 0;
 			while (cur) {
 				chain_len++;
 				cur = cur->next;
@@ -142,36 +144,35 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*destroy)(void *k, void *d, void *args),
 		void *args)
 {
-	struct hashtab_node *cur, *tmp, *tail;
-	u32 i;
-	int rc;
+	u32 size = hashtab_size(orig);
 
 	memset(new, 0, sizeof(*new));
 
-	new->htable = kcalloc(orig->size, sizeof(*new->htable), GFP_KERNEL);
-	if (!new->htable)
-		return -ENOMEM;
+	if (size) {
+		new->htable = kcalloc(size, sizeof(*new->htable), GFP_KERNEL);
+		if (!new->htable)
+			return -ENOMEM;
+		new->hbits = orig->hbits;
+	}
 
-	new->size = orig->size;
+	for (u32 i = 0; i < size; i++) {
+		struct hashtab_node *cur, **tailp;
+		tailp = new->htable + i;
 
-	for (i = 0; i < orig->size; i++) {
-		tail = NULL;
 		for (cur = orig->htable[i]; cur; cur = cur->next) {
+			struct hashtab_node *tmp;
+
 			tmp = kmem_cache_zalloc(hashtab_node_cachep,
 						GFP_KERNEL);
 			if (!tmp)
 				goto error;
-			rc = copy(tmp, cur, args);
-			if (rc) {
+			if (copy(tmp, cur, args)) {
 				kmem_cache_free(hashtab_node_cachep, tmp);
 				goto error;
 			}
 			tmp->next = NULL;
-			if (!tail)
-				new->htable[i] = tmp;
-			else
-				tail->next = tmp;
-			tail = tmp;
+			*tailp = tmp;
+			tailp = &tmp->next;
 			new->nel++;
 		}
 	}
@@ -179,7 +180,8 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 	return 0;
 
  error:
-	for (i = 0; i < new->size; i++) {
+	for (u32 i = 0; i < size; i++) {
+		struct hashtab_node *cur, *tmp;
 		for (cur = new->htable[i]; cur; cur = tmp) {
 			tmp = cur->next;
 			destroy(cur->key, cur->datum, args);
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 09b0a3744937..6b65c9a52559 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/hash.h>
 
 #define HASHTAB_MAX_NODES	U32_MAX
 
@@ -31,7 +32,7 @@ struct hashtab_node {
 
 struct hashtab {
 	struct hashtab_node **htable;	/* hash table */
-	u32 size;			/* number of slots in hash table */
+	u32 hbits;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
 };
 
@@ -41,6 +42,11 @@ struct hashtab_info {
 	u64 chain2_len_sum;
 };
 
+static inline u32 hashtab_size(const struct hashtab *h)
+{
+	return h->hbits ? 1 << h->hbits : 0;
+}
+
 /*
  * Initializes a new hash table with the specified characteristics.
  *
@@ -51,6 +57,12 @@ int hashtab_init(struct hashtab *h, u32 nel_hint);
 int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
 		     void *key, void *datum);
 
+static inline struct hashtab_node **hashtab_entry(struct hashtab *h,
+	const void *key, const struct hashtab_key_params key_params)
+{
+	return h->htable + hash_32(key_params.hash(key), h->hbits);
+}
+
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
  *
@@ -60,32 +72,27 @@ int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
   0 otherwise.
  */
 static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
-				 struct hashtab_key_params key_params)
+				 const struct hashtab_key_params key_params)
 {
-	u32 hvalue;
-	struct hashtab_node *prev, *cur;
+	struct hashtab_node **pprev;
 
 	cond_resched();
 
-	if (!h->size || h->nel == HASHTAB_MAX_NODES)
+	if (!h->hbits || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
-	hvalue = key_params.hash(key) & (h->size - 1);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur) {
+	pprev = hashtab_entry(h, key, key_params);
+	for (struct hashtab_node *cur; (cur = *pprev) != NULL; ) {
 		int cmp = key_params.cmp(key, cur->key);
 
 		if (cmp == 0)
 			return -EEXIST;
 		if (cmp < 0)
 			break;
-		prev = cur;
-		cur = cur->next;
+		pprev = &cur->next;
 	}
 
-	return __hashtab_insert(h, prev ? &prev->next : &h->htable[hvalue],
-				key, datum);
+	return __hashtab_insert(h, pprev, key, datum);
 }
 
 /*
@@ -95,16 +102,14 @@ static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
  * the datum of the entry otherwise.
  */
 static inline void *hashtab_search(struct hashtab *h, const void *key,
-				   struct hashtab_key_params key_params)
+				   const struct hashtab_key_params key_params)
 {
-	u32 hvalue;
 	struct hashtab_node *cur;
 
-	if (!h->size)
+	if (!h->hbits)
 		return NULL;
 
-	hvalue = key_params.hash(key) & (h->size - 1);
-	cur = h->htable[hvalue];
+	cur = *hashtab_entry(h, key, key_params);
 	while (cur) {
 		int cmp = key_params.cmp(key, cur->key);
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 595a435ea9c8..61bc82b2cea6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -685,7 +685,7 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
 
 	hashtab_stat(h, &info);
 	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
-		 hash_name, h->nel, info.slots_used, h->size,
+		 hash_name, h->nel, info.slots_used, hashtab_size(h),
 		 info.max_chain_len, info.chain2_len_sum);
 }
 
-- 
2.42.1

