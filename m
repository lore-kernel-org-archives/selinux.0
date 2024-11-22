Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8913635E
	for <selinux@vger.kernel.org>; Fri, 22 Nov 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293598; cv=none; b=ApTgqwsRK+f0JCnhOwolNS2w2hmlAr3QaVu1B2rx8KStLAmd0C0VZeGZqRjpfjjgssCH8YTjMf9i/NGjFYKAm0xjmIlB7rkSNrTEEQzm9aF5aUnTGfIL79LgjsYINB3yZV4QewEYmf5WigeqBpWa/JwZi+fGIheAWa1FcnJBr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293598; c=relaxed/simple;
	bh=kPK4b2vjoU9dwB2jiO5Umuc1TaZhauHE8K8unE+GtaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMPHMd+PfVY8s3j7qbe4I76p6h57LLOQqAZqNFLZw37ssLz83fMZlgaUH50jEuosjbcZriz2QUauc2iT87WVFSLDWPV2AxMbMnOz76tg5kSeXaw/t59qwOrI6L22BryMQtOzwCXTEyI+sBcYa4bNLhM9mct2e6txcejIMqfcT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=STwRb89L; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="STwRb89L"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732293585;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rOxhfs+HvVUHM0pcP6BkBK4At9ZElki7bJwTmkFqFRY=;
	b=STwRb89LPTnnNTyrlOQTz8vw8MxZ2qipRvjXspGVjzOvdDKNEBE+XxAD3griTa+QZClDU3
	+CP0O8BtAlpP/gC+J+V77OSip1FoitvexkiECw7oa3mJr1/EaOkcz9jPy48/qB4dj+8+7S
	6LQQJniQ2/0iawer5d+9DxLuQqwXJfv0/hbN7/1KJHVwnkoEqCOvB7Dlv2Otb+JRQQA6DW
	XlKKSU7UTgxZTDaV8gzBJ279t6PwPRshGfi4VtjEcEO4qQ+C5gnxN1k6JG8kl1JYe8P88N
	XmcTiQGtt9A3LovG9v+CqRotgeuJArAdNmrDmwp2MwYNIqpEiL0vtxmo/vwW8A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: avoid memory allocation in common file label lookup
Date: Fri, 22 Nov 2024 17:39:40 +0100
Message-ID: <20241122163941.69833-1-cgoettsche@seltendoof.de>
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

Remove the sole memory allocation during a common file label lookup,
e.g. requested by restorecon(8)/setfiles(8), by using a local stack
buffer for a potential lookup result.

Additional minor optimization tweaks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c       | 103 +++++++++++++++++-------------
 libselinux/src/selinux_internal.h |   8 +++
 2 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 189a5ed2..4e212aa4 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1467,12 +1467,30 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 	}
 }
 
-static struct lookup_result *lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind, bool partial, bool find_all)
+/**
+ * lookup_check_node() - Try to find a file context definition in the given node or parents.
+ * @node:      The deepest specification node to match against. Parent nodes are successively
+ *             searched on no match or when finding all matches.
+ * @key:       The absolute file path to look up.
+ * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
+ * @partial:   Whether to partially match the given file path or completely.
+ * @find_all:  Whether to find all file context definitions or just the most specific.
+ * @buf:       A pre-allocated buffer for a potential result to avoid allocating it on the heap or
+ *             NULL. Mututal exclusive with @find_all.
+ *
+ * Return: A pointer to a file context definition if a match was found. If @find_all was specified
+ *         its a linked list of all results. If @buf was specified it is returned on a match found.
+ *         NULL is returned in case of no match found.
+ */
+static struct lookup_result *lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
+					       bool partial, bool find_all, struct lookup_result *buf)
 {
 	struct lookup_result *result = NULL;
 	struct lookup_result **next = &result;
 	size_t key_len = strlen(key);
 
+	assert(!(find_all && buf != NULL));
+
 	for (struct spec_node *n = node; n; n = n->parent) {
 
 		uint32_t literal_idx = search_literal_spec(n->literal_specs, n->literal_specs_num, key, key_len, partial);
@@ -1495,10 +1513,14 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 						return NULL;
 					}
 
-					r = malloc(sizeof(*r));
-					if (!r) {
-						free_lookup_result(result);
-						return NULL;
+					if (likely(buf)) {
+						r = buf;
+					} else {
+						r = malloc(sizeof(*r));
+						if (!r) {
+							free_lookup_result(result);
+							return NULL;
+						}
 					}
 
 					*r = (struct lookup_result) {
@@ -1510,11 +1532,11 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 						.next = NULL,
 					};
 
+					if (likely(!find_all))
+						return r;
+
 					*next = r;
 					next = &r->next;
-
-					if (!find_all)
-						return result;
 				}
 
 				literal_idx++;
@@ -1556,10 +1578,14 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					return NULL;
 				}
 
-				r = malloc(sizeof(*r));
-				if (!r) {
-					free_lookup_result(result);
-					return NULL;
+				if (likely(buf)) {
+					r = buf;
+				} else {
+					r = malloc(sizeof(*r));
+					if (!r) {
+						free_lookup_result(result);
+						return NULL;
+					}
 				}
 
 				*r = (struct lookup_result) {
@@ -1571,12 +1597,12 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					.next = NULL,
 				};
 
+				if (likely(!find_all))
+					return r;
+
 				*next = r;
 				next = &r->next;
 
-				if (!find_all)
-					return result;
-
 				continue;
 			}
 
@@ -1692,7 +1718,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 				 const char *key,
 				 int type,
 				 bool partial,
-				 bool find_all)
+				 bool find_all,
+				 struct lookup_result *buf)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct lookup_result *result = NULL;
@@ -1704,18 +1731,18 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
-	if (!key) {
+	if (unlikely(!key)) {
 		errno = EINVAL;
 		goto finish;
 	}
 
-	if (!data->num_specs) {
+	if (unlikely(!data->num_specs)) {
 		errno = ENOENT;
 		goto finish;
 	}
 
 	/* Remove duplicate slashes */
-	if ((next_slash = strstr(key, "//"))) {
+	if (unlikely(next_slash = strstr(key, "//"))) {
 		clean_key = (char *) malloc(strlen(key) + 1);
 		if (!clean_key)
 			goto finish;
@@ -1732,12 +1759,12 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	/* remove trailing slash */
 	len = strlen(key);
-	if (len == 0) {
+	if (unlikely(len == 0)) {
 		errno = EINVAL;
 		goto finish;
 	}
 
-	if (len > 1 && key[len - 1] == '/') {
+	if (unlikely(len > 1 && key[len - 1] == '/')) {
 		/* reuse clean_key from above if available */
 		if (!clean_key) {
 			clean_key = (char *) malloc(len);
@@ -1757,7 +1784,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	node = lookup_find_deepest_node(data->root, key);
 
-	result = lookup_check_node(node, key, file_kind, partial, find_all);
+	result = lookup_check_node(node, key, file_kind, partial, find_all, buf);
 
 finish:
 	free(clean_key);
@@ -1768,14 +1795,9 @@ finish:
 static struct lookup_result *lookup_common(struct selabel_handle *rec,
 					   const char *key,
 					   int type,
-					   bool partial) {
-	struct lookup_result *result = lookup_all(rec, key, type, partial, false);
-	if (!result)
-		return NULL;
-
-	free_lookup_result(result->next);
-	result->next = NULL;
-	return result;
+					   bool partial,
+					   struct lookup_result *buf) {
+	return lookup_all(rec, key, type, partial, false, buf);
 }
 
 /*
@@ -1835,7 +1857,7 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 {
 	assert(digest);
 
-	struct lookup_result *matches = lookup_all(rec, key, 0, true, true);
+	struct lookup_result *matches = lookup_all(rec, key, 0, true, true, NULL);
 	if (!matches) {
 		return false;
 	}
@@ -1864,25 +1886,20 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key, int type)
 {
-	struct lookup_result *result;
-	struct selabel_lookup_rec *lookup_result;
+	struct lookup_result buf, *result;
 
-	result = lookup_common(rec, key, type, false);
+	result = lookup_common(rec, key, type, false, &buf);
 	if (!result)
 		return NULL;
 
-	lookup_result = result->lr;
-	free_lookup_result(result);
-	return lookup_result;
+	return result->lr;
 }
 
 static bool partial_match(struct selabel_handle *rec, const char *key)
 {
-	struct lookup_result *result = lookup_common(rec, key, 0, true);
-	bool ret = result;
+	struct lookup_result buf;
 
-	free_lookup_result(result);
-	return ret;
+	return !!lookup_common(rec, key, 0, true, &buf);
 }
 
 static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
@@ -1904,7 +1921,7 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 	results = calloc(n+1, sizeof(*results));
 	if (!results)
 		return NULL;
-	results[0] = lookup_common(rec, key, type, false);
+	results[0] = lookup_common(rec, key, type, false, NULL);
 	if (results[0]) {
 		if (!results[0]->has_meta_chars) {
 			/* exact match on key */
@@ -1915,7 +1932,7 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 		prefix_len = results[0]->prefix_len;
 	}
 	for (i = 1; i <= n; i++) {
-		results[i] = lookup_common(rec, aliases[i-1], type, false);
+		results[i] = lookup_common(rec, aliases[i-1], type, false, NULL);
 		if (results[i]) {
 			if (!results[i]->has_meta_chars) {
 				/* exact match on alias */
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 372837dd..964b8418 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -142,4 +142,12 @@ static inline void fclose_errno_safe(FILE *stream)
 	errno = saved_errno;
 }
 
+#ifdef __GNUC__
+# define likely(x)			__builtin_expect(!!(x), 1)
+# define unlikely(x)			__builtin_expect(!!(x), 0)
+#else
+# define likely(x)			(x)
+# define unlikely(x)			(x)
+#endif /* __GNUC__ */
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.45.2

