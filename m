Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067EC001B0
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHNNVm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHNNVK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F5199C
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-997c4107d62so576376566b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019256; x=1692624056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KTCosaLfwXLbYBf8UrPTir9MQzO7NqD5UT+xcBIAMg=;
        b=R1NTZqBYnHrD/IbL7z7kbpNDwBDCmIRB7rzPbPOuCUKUop3Xa7F94nI3Rb57cVl/5s
         0dTmAIJI3HQi8Etls5Y0gsbNC6VVMK1MauSXjvLcxpW6FmrQQpzsVQS9etFVsFo99Zye
         bc13W6a79os0uncN4330Z20lyCQ/4upPh2+4oY4JwGWyxDGKrUZXxG+Lnirnv1BirMnw
         7Rw1Hi0k6nwIX3RPGV4kbM9E4z3qUXCW3+Ii/gBOL9PDlTxHn2EDOahrriflax8RzzLd
         O2gOQY15ANOwoqlhxtQRdgU3hURxBUAPS9ponhULmFQbNi8mufAamxaFyFQCHajQ+o1T
         Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019256; x=1692624056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KTCosaLfwXLbYBf8UrPTir9MQzO7NqD5UT+xcBIAMg=;
        b=QY625jPEB2BQ7J4dQndgLFIo+CKnWY3DKJDAGz5WPzybApR8act21aNKLjns1zFq+A
         xKxQYvKBtPuOd6gSccXDJAlTmhRd8f93IhKxo+ATcY7d3jWWmmW49IM4DGzfWaaFDHep
         C8a8QfSjcjIOiSySMhonc5bn7rFLMqzhMgJFfBGksd8tFALtCXHjjajJglCD2VuJl+vY
         6NKq7PGnWh4EiqZFtowrsOCO3OHblkEnLq3x6Kg+MiKadRZajnrMOZ9OhHXfwm9+VhM4
         GL0s/mxoeT6nDwy6gxa7c97G4f9Sb7LMUzncCTj8YdtYK+Jbk47P9bkpTqVPAm6529Bl
         Z1kw==
X-Gm-Message-State: AOJu0YzH3FGYKaZtmhkNJ5TeqSZBVIRFhusi4FupTRy66Eai4KfNk/zy
        /HAxq5ttQ3ERFf7JuGky9EkeR7+EVpRtvcEyFE4=
X-Google-Smtp-Source: AGHT+IEso7+3S1SfOP0EUUgGJy+zpa31vAWgyaLfETnVcXynwbIHq4Z6D5IaSyqZ+P/tpsRLVP8WOQ==
X-Received: by 2002:a17:907:2c42:b0:99b:c689:3f3d with SMTP id hf2-20020a1709072c4200b0099bc6893f3dmr7870738ejc.25.1692019255660;
        Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 26/27] libselinux: remove unused hashtab code
Date:   Mon, 14 Aug 2023 15:20:24 +0200
Message-Id: <20230814132025.45364-27-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
2.40.1

