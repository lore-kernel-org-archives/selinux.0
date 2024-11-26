Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA21CC89D
	for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616800; cv=none; b=ZcUzv04jwZGl5furFjXGAgZQO/lKy+Ljb42Y2eYMvFV6RUHWCre6AK7u/WYg0yjRP06auT9kgcXNOVxBUDJkakiv8ahIjbE6j57YfhmKJ/Gbsp55BPVU49KuzQvXCs19eWiUPhoHQvAikZ/WhoD7H+yI0unZBTXcESoE/nmO6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616800; c=relaxed/simple;
	bh=FU9hOxAsf7+9rprPXtzqxlwq7WGorsjoDW/6yH6pfFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sso9XNjYuM+VkDs0Zq8xZuvtpCD4YTLdkBVgWduWR4/jEG5sRq5YBRjW9n0lJXCLekkRSywGS15VzUJJcj4jXfSBsGa9AyvQpNmFD3KDllF+Yd1v8mCDn6L+mT9ekF1pijtmAcZjikYP0iamHzA4DJUnvqzq+3RWgkqyhcLTCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kwnzXcXS; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kwnzXcXS"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732616794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mtKidiXapmX3A9JU3r1UYAElvEUaIuKmxPRyI0z97GE=;
	b=kwnzXcXSf8UtmhHRB2xe+pP16gTycQEaGhi44aV3jKO2Z4QAWbCNOT3RHg18FF4yVzlc0U
	8i/3stqJt53YI6BYMe/NV7YCmSTCgy+YJ0dmwTWNDD9bdQO9gTWX3YJmWhDLH+VQ1DDJ0z
	JiHPFmA0YRW76/8/uCpfQnm2DnqS9Er7DYAgZkBPrg6dOm7u/DTc7xUe3wp+Y0S7l7+9v1
	rUIe13D0g3VENxsjWoTMCYWed+sTOCuvxMmW1Z9FapD4wMl4+Qe9UUClUh4YS8Vu8U28MS
	jSeqORjkOQOCoYxnMtag6Dy6WO9SS3B3jG0GVEijU0ws1ZGnkbPumKkRqRt+AQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 1/3] libselinux: avoid memory allocation in common file label lookup
Date: Tue, 26 Nov 2024 11:26:19 +0100
Message-ID: <20241126102621.20253-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Remove a memory allocation during a common file label lookup,
e.g. requested by restorecon(8)/setfiles(8), by using a local stack
buffer for a potential lookup result.

Additional minor optimization tweaks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: drop claim about this being the sole memory allocation, since
    applying a substitution path allocates as well
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

