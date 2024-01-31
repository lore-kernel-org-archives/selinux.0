Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64087AE78
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706535; cv=none; b=RBzxo3/L/u+UyXWZ4CHODdQOzrBu4EimMGMtTKs9ZFC+TW/5IO9IGMzB4EiQ6u9Asmuy8HzTxNymrmw2XyBUsuD3K4DVYB45sKo6Df0K1CRjk0H5zkCwnvxqSoYYkv4c0u4+EC2vasyDqPJXB+EakZ5RNbImJSGyzKSEWP09820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706535; c=relaxed/simple;
	bh=ahZTNCA0/kXXm5mRv2Z2/5/u4GrFDSDJ+Wz2s9nQ45w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jONNJ6PIWSz+ynbaQUmBBgEDy3O4kkyZC+RiwgO7+7DVuZXjUwB02dcNMZSpvpuPN8d6Hx7I7QOdcnMOadch7uNprteB+KFELsgNHPrRFraL+z9vi9tDF6SlM76U83vZPmmyOYA7H9ImnapzwlKGfwBnJcJvE/wVN7ve9bPxVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=K6outh5F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K6outh5F"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a363961b96aso218310066b.3
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706532; x=1707311332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pINrv28ihfORB4WmnwIOdTFZsWgoeUFUfH1cO12yv4=;
        b=K6outh5FeuRM94qvffSlUejJb3TZu1aaaqJ6UbGxXpk3ONWTQRdFNnv07xTrxl9BF5
         lx1zdGTMzWcgXHkgFZS4QL1Vy3oVOK3Qxfx67VUs1pFPMeZgLOKYVIT/n2bx/tijOzzy
         d6PNMHJOEPQJ8Fc3bnOqMpQD62x1+wQsmJMLJ01AWC5MK4j1RUKgZuNc6pbabeH3/wsG
         HF29rGqo93nqdosYdY5RZEWzbOE+pnchK1i1srcpJsyFpX5rItMO91tXK5n0/s6noHgL
         aOQHsRK8GXbMvs3HkkOE5MGVa6hn2S1k7JaPF9fcc3bb6STcLPXg3gE1tT5JNlcZ72uM
         3lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706532; x=1707311332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pINrv28ihfORB4WmnwIOdTFZsWgoeUFUfH1cO12yv4=;
        b=QZmia0XCqxC/a83wDnJtUBsdfG6xZIQyQlrJonBWaNmPO77eGnQGntFTtMaorxlLmT
         +EgsJ/zm/xy+toRvdsX6mqPt2n9B1csmu/LsN8PEWd5RISFzqVJ03j6gG2xRg0E+5gjY
         20B4ezHQeZl5uby0gL4Mid2+nzfTXvPsKLlj5tePSHmn5JLlIvfAAUviSNy8E9EZJbTm
         AGIa14JHAtGCne/U3BrzqFIDgHHzVa204gZMHxJpM5MEAcCZ2XH9BcmS3+w0oDPTVgIh
         KC0cB6eNMcJSGRkHOXT0PFNr34+qnZvEBdqiBigimmprulTWxT5NzH3xbSzLJdvf3nYy
         KMfA==
X-Gm-Message-State: AOJu0YxaRDgaPV90iS5PNGHlyytphIugmleqzGXOfen2mvoxlBeej4Zy
	tzet9mD6+mKdG8b5vdXhIXDZbxfmQ5QBi+XN3qhOQCIiq5y91pJ5z5cLc5Ch
X-Google-Smtp-Source: AGHT+IFd25SyBGU5Mj/+hWZ50aR+AeGkBGzKS5IkHnFsTdG7/TX7a4zBuQajOw//T9qBxkAKXJWPeQ==
X-Received: by 2002:a17:906:c78b:b0:a33:1d7d:912f with SMTP id cw11-20020a170906c78b00b00a331d7d912fmr1280342ejb.8.1706706531861;
        Wed, 31 Jan 2024 05:08:51 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:51 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 7/9] libselinux: remove unused hashtab code
Date: Wed, 31 Jan 2024 14:08:33 +0100
Message-ID: <20240131130840.48155-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index 7452613b..00000000
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
-hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
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
-int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
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
-int hashtab_remove(hashtab_t h, hashtab_key_t key,
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
-hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
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
-void hashtab_destroy(hashtab_t h)
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
-void hashtab_destroy_key(hashtab_t h,
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
-int hashtab_map(hashtab_t h,
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
-void hashtab_hash_eval(hashtab_t h, char *tag)
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
index f10fc0af..00000000
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
-extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
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
-extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
-
-/*
-   Removes the entry with the specified key from the hash table.
-   Applies the specified destroy function to (key,datum,args) for
-   the entry.
-
-   Returns HASHTAB_MISSING if no entry has the specified key or
-   HASHTAB_SUCCESS otherwise.
- */
-extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
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
-extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
-
-/*
-   Destroys the specified hash table.
- */
-extern void hashtab_destroy(hashtab_t h);
-extern void hashtab_destroy_key(hashtab_t h,
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
-extern int hashtab_map(hashtab_t h,
-		       int (*apply) (hashtab_key_t k,
-				     hashtab_datum_t d,
-				     void *args), void *args);
-
-extern void hashtab_hash_eval(hashtab_t h, char *tag);
-
-#endif
-- 
2.43.0

