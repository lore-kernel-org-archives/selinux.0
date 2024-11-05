Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62D1E883C
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831613; cv=none; b=iyoxIGFoh7rVHzFdn88Bjge1qXK9E1PMehh2CS6YRzhlD+zpMNiiL7oYTf0m3TK3swxUvVxnM0aUXmkKWN8XCWu7JEYtpjDQsh+rqxad6Ccum2wNiCQHgkHI0rL0pyeh7d4vGyr6bt8p+geqIGzPg9ZJFumBODg30w6C0Bdo8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831613; c=relaxed/simple;
	bh=uPy+sXrsgn2ImYagH90S3RqKPExW+/SRrHd2d5pta5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTJtCWHTsZL7g70twnIyqBJUfhQUruWp3TdM5PmYEhgy8hbiGgpVRYGwKFFPYd1Y6OP43hA0MvbsX9E1uBJOTkDGI+HhL9wfLyz9ytXzco5PUIo2tQWAwdFKgaUTLBcg0QCx0Kuov9Y+Z+TXMaopxCG7LE4PTViSO1RKwKaknPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=to96Ng+m; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="to96Ng+m"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831607;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lNeZZ+YS1KSaBdeuBw6PRqAY+bvY4WOL2M/YhwH9Pg=;
	b=to96Ng+mqzIWY6b6kzrqM4JYeQ7NSTZgnvwm7o0LJS9nyjNSnNbyDLA3XqTYVa9Qe2Vzs+
	V7aJjHjNw4uSR3sI8smRg+OikCh/54D5PZq3cAsHJ5pkXXF+sfycKlCskv2pYVbuYQ6KI0
	lDE5KcJ9w9lGL1edcRZPefBT8DZbBd8/9rHvZzPjkGWCqZAlg/ypmL4W0kpSfttu6f2Tht
	oBpxyMm1zw+nrZRFPxsaMESJ5ZdrTAueAsLmei6gHtZvdf1c8Id1zs7oC5MuFEQZTJu3Y8
	ADrm+OpGNl6OCYAPwEdMnRmg7spB39ShKYq227pxfQ/BBOeUr6AElsqQPOuX1w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 7/9] libselinux: remove unused hashtab code
Date: Tue,  5 Nov 2024 19:33:17 +0100
Message-ID: <20241105183319.250410-8-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Due to the selabel_file(5) rework this code is no longer used.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/hashtab.c | 234 ---------------------------------------
 libselinux/src/hashtab.h | 117 --------------------
 2 files changed, 351 deletions(-)
 delete mode 100644 libselinux/src/hashtab.c
 delete mode 100644 libselinux/src/hashtab.h

diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
deleted file mode 100644
index 0c6641ed..00000000
--- a/libselinux/src/hashtab.c
+++ /dev/null
@@ -1,234 +0,0 @@
-
-/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
-
-/* FLASK */
-
-/*
- * Implementation of the hash table type.
- */
-
-#include <stdlib.h>
-#include <string.h>
-#include "hashtab.h"
-
-hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     const_hashtab_key_t key),
-			 int (*keycmp) (hashtab_t h,
-					const_hashtab_key_t key1,
-					const_hashtab_key_t key2),
-			 unsigned int size)
-{
-
-	hashtab_t p;
-	unsigned int i;
-
-	p = (hashtab_t) malloc(sizeof(hashtab_val_t));
-	if (p == NULL)
-		return p;
-
-	memset(p, 0, sizeof(hashtab_val_t));
-	p->size = size;
-	p->nel = 0;
-	p->hash_value = hash_value;
-	p->keycmp = keycmp;
-	p->htable = (hashtab_ptr_t *) malloc(sizeof(hashtab_ptr_t) * size);
-	if (p->htable == NULL) {
-		free(p);
-		return NULL;
-	}
-	for (i = 0; i < size; i++)
-		p->htable[i] = (hashtab_ptr_t) NULL;
-
-	return p;
-}
-
-int selinux_hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
-{
-	unsigned int hvalue;
-	hashtab_ptr_t prev, cur, newnode;
-
-	if (!h)
-		return HASHTAB_OVERFLOW;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return HASHTAB_PRESENT;
-
-	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
-	if (newnode == NULL)
-		return HASHTAB_OVERFLOW;
-	memset(newnode, 0, sizeof(struct hashtab_node));
-	newnode->key = key;
-	newnode->datum = datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
-
-	h->nel++;
-	return HASHTAB_SUCCESS;
-}
-
-int selinux_hashtab_remove(hashtab_t h, hashtab_key_t key,
-		   void (*destroy) (hashtab_key_t k,
-				    hashtab_datum_t d, void *args), void *args)
-{
-	unsigned int hvalue;
-	hashtab_ptr_t cur, last;
-
-	if (!h)
-		return HASHTAB_MISSING;
-
-	hvalue = h->hash_value(h, key);
-	last = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		last = cur;
-		cur = cur->next;
-	}
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return HASHTAB_MISSING;
-
-	if (last == NULL)
-		h->htable[hvalue] = cur->next;
-	else
-		last->next = cur->next;
-
-	if (destroy)
-		destroy(cur->key, cur->datum, args);
-	free(cur);
-	h->nel--;
-	return HASHTAB_SUCCESS;
-}
-
-hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_key_t key)
-{
-
-	unsigned int hvalue;
-	hashtab_ptr_t cur;
-
-	if (!h)
-		return NULL;
-
-	hvalue = h->hash_value(h, key);
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
-		cur = cur->next;
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return NULL;
-
-	return cur->datum;
-}
-
-void selinux_hashtab_destroy(hashtab_t h)
-{
-	unsigned int i;
-	hashtab_ptr_t cur, temp;
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			temp = cur;
-			cur = cur->next;
-			free(temp);
-		}
-		h->htable[i] = NULL;
-	}
-
-	free(h->htable);
-	h->htable = NULL;
-
-	free(h);
-}
-
-void selinux_hashtab_destroy_key(hashtab_t h,
-		int (*destroy_key) (hashtab_key_t k))
-{
-	unsigned int i;
-	hashtab_ptr_t cur, temp;
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			temp = cur;
-			cur = cur->next;
-			destroy_key(temp->key);
-			free(temp);
-		}
-		h->htable[i] = NULL;
-	}
-
-	free(h->htable);
-	h->htable = NULL;
-
-	free(h);
-}
-
-int selinux_hashtab_map(hashtab_t h,
-		int (*apply) (hashtab_key_t k,
-			      hashtab_datum_t d, void *args), void *args)
-{
-	unsigned int i;
-	hashtab_ptr_t cur;
-	int ret;
-
-	if (!h)
-		return HASHTAB_SUCCESS;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret)
-				return ret;
-			cur = cur->next;
-		}
-	}
-	return HASHTAB_SUCCESS;
-}
-
-void selinux_hashtab_hash_eval(hashtab_t h, char *tag)
-{
-	unsigned int i;
-	int chain_len, slots_used, max_chain_len;
-	hashtab_ptr_t cur;
-
-	slots_used = 0;
-	max_chain_len = 0;
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		if (cur) {
-			slots_used++;
-			chain_len = 0;
-			while (cur) {
-				chain_len++;
-				cur = cur->next;
-			}
-
-			if (chain_len > max_chain_len)
-				max_chain_len = chain_len;
-		}
-	}
-
-	printf
-	    ("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
-	     tag, h->nel, slots_used, h->size, max_chain_len);
-}
diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
deleted file mode 100644
index 6fbf5fb4..00000000
--- a/libselinux/src/hashtab.h
+++ /dev/null
@@ -1,117 +0,0 @@
-
-/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
-
-/* FLASK */
-
-/*
- * A hash table (hashtab) maintains associations between
- * key values and datum values.  The type of the key values
- * and the type of the datum values is arbitrary.  The
- * functions for hash computation and key comparison are
- * provided by the creator of the table.
- */
-
-#ifndef _SELINUX_HASHTAB_H_
-#define _SELINUX_HASHTAB_H_
-
-#include <stdint.h>
-#include <errno.h>
-#include <stdio.h>
-
-typedef char *hashtab_key_t;	/* generic key type */
-typedef const char *const_hashtab_key_t;	/* constant generic key type */
-typedef void *hashtab_datum_t;	/* generic datum type */
-
-typedef struct hashtab_node *hashtab_ptr_t;
-
-typedef struct hashtab_node {
-	hashtab_key_t key;
-	hashtab_datum_t datum;
-	hashtab_ptr_t next;
-} hashtab_node_t;
-
-typedef struct hashtab_val {
-	hashtab_ptr_t *htable;	/* hash table */
-	unsigned int size;	/* number of slots in hash table */
-	uint32_t nel;		/* number of elements in hash table */
-	unsigned int (*hash_value) (struct hashtab_val * h, const_hashtab_key_t key);	/* hash function */
-	int (*keycmp) (struct hashtab_val * h, const_hashtab_key_t key1, const_hashtab_key_t key2);	/* key comparison function */
-} hashtab_val_t;
-
-typedef hashtab_val_t *hashtab_t;
-
-/* Define status codes for hash table functions */
-#define HASHTAB_SUCCESS     0
-#define HASHTAB_OVERFLOW    -ENOMEM
-#define HASHTAB_PRESENT     -EEXIST
-#define HASHTAB_MISSING     -ENOENT
-
-/*
-   Creates a new hash table with the specified characteristics.
-
-   Returns NULL if insufficient space is available or
-   the new hash table otherwise.
- */
-extern hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-							    const_hashtab_key_t
-							    key),
-				int (*keycmp) (hashtab_t h,
-					       const_hashtab_key_t key1,
-					       const_hashtab_key_t key2),
-				unsigned int size);
-/*
-   Inserts the specified (key, datum) pair into the specified hash table.
-
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_PRESENT  if there is already an entry with the same key or
-   HASHTAB_SUCCESS otherwise.
- */
-extern int selinux_hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
-
-/*
-   Removes the entry with the specified key from the hash table.
-   Applies the specified destroy function to (key,datum,args) for
-   the entry.
-
-   Returns HASHTAB_MISSING if no entry has the specified key or
-   HASHTAB_SUCCESS otherwise.
- */
-extern int selinux_hashtab_remove(hashtab_t h, hashtab_key_t k,
-			  void (*destroy) (hashtab_key_t k,
-					   hashtab_datum_t d,
-					   void *args), void *args);
-
-/*
-   Searches for the entry with the specified key in the hash table.
-
-   Returns NULL if no entry has the specified key or
-   the datum of the entry otherwise.
- */
-extern hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_key_t k);
-
-/*
-   Destroys the specified hash table.
- */
-extern void selinux_hashtab_destroy(hashtab_t h);
-extern void selinux_hashtab_destroy_key(hashtab_t h,
-			int (*destroy_key) (hashtab_key_t k));
-
-/*
-   Applies the specified apply function to (key,datum,args)
-   for each entry in the specified hash table.
-
-   The order in which the function is applied to the entries
-   is dependent upon the internal structure of the hash table.
-
-   If apply returns a non-zero status, then hashtab_map will cease
-   iterating through the hash table and will propagate the error
-   return to its caller.
- */
-extern int selinux_hashtab_map(hashtab_t h,
-		       int (*apply) (hashtab_key_t k,
-				     hashtab_datum_t d,
-				     void *args), void *args);
-
-extern void selinux_hashtab_hash_eval(hashtab_t h, char *tag);
-
-#endif
-- 
2.45.2

