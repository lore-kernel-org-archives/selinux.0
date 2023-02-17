Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8288C636D4
	for <selinux@archiver.kernel.org>; Fri, 17 Feb 2023 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQIpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBQIpG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Feb 2023 03:45:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2305F839
        for <selinux@vger.kernel.org>; Fri, 17 Feb 2023 00:45:04 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PJ50v1KqbznWGp;
        Fri, 17 Feb 2023 16:42:39 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 16:45:02 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>, <nixiaoming@huawei.com>,
        <chenjingwen6@huawei.com>, <dongxinhua@huawei.com>
CC:     <lautrbach@redhat.com>, <jwcart2@gmail.com>, <jason@perfinion.com>,
        <cgzones@googlemail.com>, <wangfangpeng1@huawei.com>,
        <weiyuchen3@huawei.com>, <wanghuizhao1@huawei.com>
Subject: [PATCH v2 1/3] libselinux: migrating hashtab from policycoreutils
Date:   Fri, 17 Feb 2023 16:44:56 +0800
Message-ID: <20230217084458.40597-2-wanghuizhao1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20230217084458.40597-1-wanghuizhao1@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-1-wanghuizhao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.136.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To use hashtab in libselinux, migrate the existing hashtab template
from policycoreutils/newrole to libselinux.

Signed-off-by: wanghuizhao <wanghuizhao1@huawei.com>
---
 libselinux/src/hashtab.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++
 libselinux/src/hashtab.h | 115 ++++++++++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100644 libselinux/src/hashtab.c
 create mode 100644 libselinux/src/hashtab.h

diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
new file mode 100644
index 00000000..26d4f4c7
--- /dev/null
+++ b/libselinux/src/hashtab.c
@@ -0,0 +1,208 @@
+
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
+
+/* FLASK */
+
+/*
+ * Implementation of the hash table type.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include "hashtab.h"
+
+hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+						     const_hashtab_key_t key),
+			 int (*keycmp) (hashtab_t h,
+					const_hashtab_key_t key1,
+					const_hashtab_key_t key2),
+			 unsigned int size)
+{
+
+	hashtab_t p;
+	unsigned int i;
+
+	p = (hashtab_t) malloc(sizeof(hashtab_val_t));
+	if (p == NULL)
+		return p;
+
+	memset(p, 0, sizeof(hashtab_val_t));
+	p->size = size;
+	p->nel = 0;
+	p->hash_value = hash_value;
+	p->keycmp = keycmp;
+	p->htable = (hashtab_ptr_t *) malloc(sizeof(hashtab_ptr_t) * size);
+	if (p->htable == NULL) {
+		free(p);
+		return NULL;
+	}
+	for (i = 0; i < size; i++)
+		p->htable[i] = (hashtab_ptr_t) NULL;
+
+	return p;
+}
+
+int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+{
+	unsigned int hvalue;
+	hashtab_ptr_t prev, cur, newnode;
+
+	if (!h)
+		return HASHTAB_OVERFLOW;
+
+	hvalue = h->hash_value(h, key);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur && h->keycmp(h, key, cur->key) > 0) {
+		prev = cur;
+		cur = cur->next;
+	}
+
+	if (cur && (h->keycmp(h, key, cur->key) == 0))
+		return HASHTAB_PRESENT;
+
+	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
+	if (newnode == NULL)
+		return HASHTAB_OVERFLOW;
+	memset(newnode, 0, sizeof(struct hashtab_node));
+	newnode->key = key;
+	newnode->datum = datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return HASHTAB_SUCCESS;
+}
+
+int hashtab_remove(hashtab_t h, hashtab_key_t key,
+		   void (*destroy) (hashtab_key_t k,
+				    hashtab_datum_t d, void *args), void *args)
+{
+	unsigned int hvalue;
+	hashtab_ptr_t cur, last;
+
+	if (!h)
+		return HASHTAB_MISSING;
+
+	hvalue = h->hash_value(h, key);
+	last = NULL;
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
+		last = cur;
+		cur = cur->next;
+	}
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return HASHTAB_MISSING;
+
+	if (last == NULL)
+		h->htable[hvalue] = cur->next;
+	else
+		last->next = cur->next;
+
+	if (destroy)
+		destroy(cur->key, cur->datum, args);
+	free(cur);
+	h->nel--;
+	return HASHTAB_SUCCESS;
+}
+
+hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
+{
+
+	unsigned int hvalue;
+	hashtab_ptr_t cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = h->hash_value(h, key);
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
+		cur = cur->next;
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return NULL;
+
+	return cur->datum;
+}
+
+void hashtab_destroy(hashtab_t h)
+{
+	unsigned int i;
+	hashtab_ptr_t cur, temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			temp = cur;
+			cur = cur->next;
+			free(temp);
+		}
+		h->htable[i] = NULL;
+	}
+
+	free(h->htable);
+	h->htable = NULL;
+
+	free(h);
+}
+
+int hashtab_map(hashtab_t h,
+		int (*apply) (hashtab_key_t k,
+			      hashtab_datum_t d, void *args), void *args)
+{
+	unsigned int i;
+	hashtab_ptr_t cur;
+	int ret;
+
+	if (!h)
+		return HASHTAB_SUCCESS;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret)
+				return ret;
+			cur = cur->next;
+		}
+	}
+	return HASHTAB_SUCCESS;
+}
+
+void hashtab_hash_eval(hashtab_t h, char *tag)
+{
+	unsigned int i;
+	int chain_len, slots_used, max_chain_len;
+	hashtab_ptr_t cur;
+
+	slots_used = 0;
+	max_chain_len = 0;
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		if (cur) {
+			slots_used++;
+			chain_len = 0;
+			while (cur) {
+				chain_len++;
+				cur = cur->next;
+			}
+
+			if (chain_len > max_chain_len)
+				max_chain_len = chain_len;
+		}
+	}
+
+	printf
+	    ("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+	     tag, h->nel, slots_used, h->size, max_chain_len);
+}
diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
new file mode 100644
index 00000000..78471269
--- /dev/null
+++ b/libselinux/src/hashtab.h
@@ -0,0 +1,115 @@
+
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
+
+/* FLASK */
+
+/*
+ * A hash table (hashtab) maintains associations between
+ * key values and datum values.  The type of the key values
+ * and the type of the datum values is arbitrary.  The
+ * functions for hash computation and key comparison are
+ * provided by the creator of the table.
+ */
+
+#ifndef _NEWROLE_HASHTAB_H_
+#define _NEWROLE_HASHTAB_H_
+
+#include <stdint.h>
+#include <errno.h>
+#include <stdio.h>
+
+typedef char *hashtab_key_t;	/* generic key type */
+typedef const char *const_hashtab_key_t;	/* constant generic key type */
+typedef void *hashtab_datum_t;	/* generic datum type */
+
+typedef struct hashtab_node *hashtab_ptr_t;
+
+typedef struct hashtab_node {
+	hashtab_key_t key;
+	hashtab_datum_t datum;
+	hashtab_ptr_t next;
+} hashtab_node_t;
+
+typedef struct hashtab_val {
+	hashtab_ptr_t *htable;	/* hash table */
+	unsigned int size;	/* number of slots in hash table */
+	uint32_t nel;		/* number of elements in hash table */
+	unsigned int (*hash_value) (struct hashtab_val * h, const_hashtab_key_t key);	/* hash function */
+	int (*keycmp) (struct hashtab_val * h, const_hashtab_key_t key1, const_hashtab_key_t key2);	/* key comparison function */
+} hashtab_val_t;
+
+typedef hashtab_val_t *hashtab_t;
+
+/* Define status codes for hash table functions */
+#define HASHTAB_SUCCESS     0
+#define HASHTAB_OVERFLOW    -ENOMEM
+#define HASHTAB_PRESENT     -EEXIST
+#define HASHTAB_MISSING     -ENOENT
+
+/*
+   Creates a new hash table with the specified characteristics.
+
+   Returns NULL if insufficient space is available or
+   the new hash table otherwise.
+ */
+extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+							    const_hashtab_key_t
+							    key),
+				int (*keycmp) (hashtab_t h,
+					       const_hashtab_key_t key1,
+					       const_hashtab_key_t key2),
+				unsigned int size);
+/*
+   Inserts the specified (key, datum) pair into the specified hash table.
+
+   Returns HASHTAB_OVERFLOW if insufficient space is available or
+   HASHTAB_PRESENT  if there is already an entry with the same key or
+   HASHTAB_SUCCESS otherwise.
+ */
+extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
+
+/*
+   Removes the entry with the specified key from the hash table.
+   Applies the specified destroy function to (key,datum,args) for
+   the entry.
+
+   Returns HASHTAB_MISSING if no entry has the specified key or
+   HASHTAB_SUCCESS otherwise.
+ */
+extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
+			  void (*destroy) (hashtab_key_t k,
+					   hashtab_datum_t d,
+					   void *args), void *args);
+
+/*
+   Searches for the entry with the specified key in the hash table.
+
+   Returns NULL if no entry has the specified key or
+   the datum of the entry otherwise.
+ */
+extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
+
+/*
+   Destroys the specified hash table.
+ */
+extern void hashtab_destroy(hashtab_t h);
+
+/*
+   Applies the specified apply function to (key,datum,args)
+   for each entry in the specified hash table.
+
+   The order in which the function is applied to the entries
+   is dependent upon the internal structure of the hash table.
+
+   If apply returns a non-zero status, then hashtab_map will cease
+   iterating through the hash table and will propagate the error
+   return to its caller.
+ */
+extern int hashtab_map(hashtab_t h,
+		       int (*apply) (hashtab_key_t k,
+				     hashtab_datum_t d,
+				     void *args), void *args);
+
+extern void hashtab_hash_eval(hashtab_t h, char *tag);
+
+#endif
-- 
2.12.3

