Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787861DB365
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933667; cv=none; b=PViIEMizBODhx0FCE6II/dGxfcR8nAVZgIKCu6OuYNMxTJjTctMYEodJ6mdqZSGMP1/hakkQjZwJ/RGXuyzrqvUwBWRir1E5AVUIqEj0iWZWNhIiXhgkdnSsrGMKgzU6IQYEyRNAoTQeXg7xf6qnBGv5fsRN9TV94zAX0RctbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933667; c=relaxed/simple;
	bh=8jEUX6S9jonOcce+frLmxyX18aLWCBdIevGssgUlZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pod1jRUOWTGYKvjeHkLbPQiBkSuBat4KKTwYqm+xwPL8LVWZtUEJ9hn7RZkSq1WYKoEzn4I8vSyDXr9UBpfB9yPA1vu7FkSsiEL5OPi5XFzm8Lu+YfRuprZsP9bRPUoiaOxnnqBdwnH0gOO2y+m+cH7MpUMZ6SFRCOJTsMuczv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGmF44c+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGmF44c+"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6efe4e3d698so50958147b3.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933664; x=1734538464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ms8tRZNhETN9/nLJmCwaQb7pbNSh/lQ5pkLt6ubIRQ=;
        b=KGmF44c+QkbeNbg6NNbUtEqVXuv3+D1xB6pzNaVpnoeCzhKLwpTng2h8MxoGwp8ODm
         BRSS81DpfDUvQnG6aQGDSbzvojQ4dv1HAV+6Y268YZz4LYFuGsz0REH3YLIhnpzQSbPk
         hx0zBo5zONTZwG5J/IWsiTDKATRp5+GfBG5/QDwyvVlM4oUW4hVB2Nj24SJkWLRUKlSI
         Usezo6CR7Mm+wSgvojafxh74wuptV1RjH501L/B2CVE4S1ZfvSiRP9ZtceAjTt4OYg1x
         otdmvL6o/WG4LSeL5zWBwWCgdo3K//eOZPCYDAeiqkSwmAQMupByWx/I7kx+9DWfqRtg
         95SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933664; x=1734538464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ms8tRZNhETN9/nLJmCwaQb7pbNSh/lQ5pkLt6ubIRQ=;
        b=dLXZmvpl2tZxZNlFhOSM70Ey87wQ+9CevLag7ruM8BEAVzs2TxAvDkb8IVNyw+LE0X
         mDicm94+RTin54bWat1FqLQN7XVP50uZgQyM7EWFwSzIpsg4RgLAT/mebbag49jXj7Ne
         1guEMgH4YCkXq9DLKKm+LeLosXAojJuT8Qfj8Va1sPr3j79mB8N/F8Yp1RgVI26BACaS
         A3yKiiuetCDArZqwsmvOB99v3DqNxCuQ2EySCJvXu8uMWrMhjjDM4lEzGHXq492Ai4Oi
         s10f3Ks8ARrWOa9ZCwwdYKvi1/IoKaJPio86FxA4NHUEWxRko1T7RTERnknLHiJNgyel
         cqWA==
X-Gm-Message-State: AOJu0YzPVRv6wzZWxDqtRQyDNUug8/whff/74dCQD2P42tyQgKmbGDWx
	e2DxIfVycdGkfmeTpWR3VNhWOFqVRfDMewCNBQwEGBhN8MitiRtuPR68Uw==
X-Gm-Gg: ASbGncvyQT3m+haH1cCpxaw1lw9pAt5Gzd2q1ZxgShI3j/wbqYJH/mSxdzwd+GGeOBa
	mnG4lA0sdTcwLyC5NfMz+X4wIS77aIXPdvmtk0D6Eor8544Ms1sw962kAuqciUWvJfvJhPl3ddM
	HLb+XQtYg6Fjn33WYrI+/04D8HFqia56QR3WUkMyRXcfLzHBCgRY+ac50bpsCzql6f0HhUVvPC9
	9FcfWKPEz3ggyTfBa7qwV7NFBaThz39j+2RFy3YswW6Y3iykxk7XIt7zAoeXNiqwk+3OdyUbcIF
	X2AHRTtvVTs=
X-Google-Smtp-Source: AGHT+IFSdGAxrPVVoHicNBrGBrIccmKE3aS6LJGSFVj3AHC71QVUGn1O8wMXruY7cStqCgTo9Ywtug==
X-Received: by 2002:a05:690c:7484:b0:6ef:4696:f1d0 with SMTP id 00721157ae682-6f17d5dab66mr2512487b3.12.1733933664137;
        Wed, 11 Dec 2024 08:14:24 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:23 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/9] Revert "libselinux: avoid memory allocation in common file label lookup"
Date: Wed, 11 Dec 2024 11:14:02 -0500
Message-ID: <20241211161417.126236-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211161417.126236-1-jwcart2@gmail.com>
References: <20241211161417.126236-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 89dd0b234f041abeb53cd8a436f3998d4cd7eace.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label_file.c       | 103 +++++++++++++-----------------
 libselinux/src/selinux_internal.h |   8 ---
 2 files changed, 43 insertions(+), 68 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index be1ee11a..40bcb9ee 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1535,30 +1535,12 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 	}
 }
 
-/**
- * lookup_check_node() - Try to find a file context definition in the given node or parents.
- * @node:      The deepest specification node to match against. Parent nodes are successively
- *             searched on no match or when finding all matches.
- * @key:       The absolute file path to look up.
- * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
- * @partial:   Whether to partially match the given file path or completely.
- * @find_all:  Whether to find all file context definitions or just the most specific.
- * @buf:       A pre-allocated buffer for a potential result to avoid allocating it on the heap or
- *             NULL. Mututal exclusive with @find_all.
- *
- * Return: A pointer to a file context definition if a match was found. If @find_all was specified
- *         its a linked list of all results. If @buf was specified it is returned on a match found.
- *         NULL is returned in case of no match found.
- */
-static struct lookup_result *lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
-					       bool partial, bool find_all, struct lookup_result *buf)
+static struct lookup_result *lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind, bool partial, bool find_all)
 {
 	struct lookup_result *result = NULL;
 	struct lookup_result **next = &result;
 	size_t key_len = strlen(key);
 
-	assert(!(find_all && buf != NULL));
-
 	for (struct spec_node *n = node; n; n = n->parent) {
 
 		uint32_t literal_idx = search_literal_spec(n->literal_specs, n->literal_specs_num, key, key_len, partial);
@@ -1581,14 +1563,10 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 						return NULL;
 					}
 
-					if (likely(buf)) {
-						r = buf;
-					} else {
-						r = malloc(sizeof(*r));
-						if (!r) {
-							free_lookup_result(result);
-							return NULL;
-						}
+					r = malloc(sizeof(*r));
+					if (!r) {
+						free_lookup_result(result);
+						return NULL;
 					}
 
 					*r = (struct lookup_result) {
@@ -1600,11 +1578,11 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 						.next = NULL,
 					};
 
-					if (likely(!find_all))
-						return r;
-
 					*next = r;
 					next = &r->next;
+
+					if (!find_all)
+						return result;
 				}
 
 				literal_idx++;
@@ -1646,14 +1624,10 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					return NULL;
 				}
 
-				if (likely(buf)) {
-					r = buf;
-				} else {
-					r = malloc(sizeof(*r));
-					if (!r) {
-						free_lookup_result(result);
-						return NULL;
-					}
+				r = malloc(sizeof(*r));
+				if (!r) {
+					free_lookup_result(result);
+					return NULL;
 				}
 
 				*r = (struct lookup_result) {
@@ -1665,12 +1639,12 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					.next = NULL,
 				};
 
-				if (likely(!find_all))
-					return r;
-
 				*next = r;
 				next = &r->next;
 
+				if (!find_all)
+					return result;
+
 				continue;
 			}
 
@@ -1786,8 +1760,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 				 const char *key,
 				 int type,
 				 bool partial,
-				 bool find_all,
-				 struct lookup_result *buf)
+				 bool find_all)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct lookup_result *result = NULL;
@@ -1799,18 +1772,18 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
-	if (unlikely(!key)) {
+	if (!key) {
 		errno = EINVAL;
 		goto finish;
 	}
 
-	if (unlikely(!data->num_specs)) {
+	if (!data->num_specs) {
 		errno = ENOENT;
 		goto finish;
 	}
 
 	/* Remove duplicate slashes */
-	if (unlikely(next_slash = strstr(key, "//"))) {
+	if ((next_slash = strstr(key, "//"))) {
 		clean_key = (char *) malloc(strlen(key) + 1);
 		if (!clean_key)
 			goto finish;
@@ -1827,12 +1800,12 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	/* remove trailing slash */
 	len = strlen(key);
-	if (unlikely(len == 0)) {
+	if (len == 0) {
 		errno = EINVAL;
 		goto finish;
 	}
 
-	if (unlikely(len > 1 && key[len - 1] == '/')) {
+	if (len > 1 && key[len - 1] == '/') {
 		/* reuse clean_key from above if available */
 		if (!clean_key) {
 			clean_key = (char *) malloc(len);
@@ -1852,7 +1825,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	node = lookup_find_deepest_node(data->root, key);
 
-	result = lookup_check_node(node, key, file_kind, partial, find_all, buf);
+	result = lookup_check_node(node, key, file_kind, partial, find_all);
 
 finish:
 	free(clean_key);
@@ -1863,9 +1836,14 @@ finish:
 static struct lookup_result *lookup_common(struct selabel_handle *rec,
 					   const char *key,
 					   int type,
-					   bool partial,
-					   struct lookup_result *buf) {
-	return lookup_all(rec, key, type, partial, false, buf);
+					   bool partial) {
+	struct lookup_result *result = lookup_all(rec, key, type, partial, false);
+	if (!result)
+		return NULL;
+
+	free_lookup_result(result->next);
+	result->next = NULL;
+	return result;
 }
 
 /*
@@ -1925,7 +1903,7 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 {
 	assert(digest);
 
-	struct lookup_result *matches = lookup_all(rec, key, 0, true, true, NULL);
+	struct lookup_result *matches = lookup_all(rec, key, 0, true, true);
 	if (!matches) {
 		return false;
 	}
@@ -1954,20 +1932,25 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key, int type)
 {
-	struct lookup_result buf, *result;
+	struct lookup_result *result;
+	struct selabel_lookup_rec *lookup_result;
 
-	result = lookup_common(rec, key, type, false, &buf);
+	result = lookup_common(rec, key, type, false);
 	if (!result)
 		return NULL;
 
-	return result->lr;
+	lookup_result = result->lr;
+	free_lookup_result(result);
+	return lookup_result;
 }
 
 static bool partial_match(struct selabel_handle *rec, const char *key)
 {
-	struct lookup_result buf;
+	struct lookup_result *result = lookup_common(rec, key, 0, true);
+	bool ret = result;
 
-	return !!lookup_common(rec, key, 0, true, &buf);
+	free_lookup_result(result);
+	return ret;
 }
 
 static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
@@ -1989,7 +1972,7 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 	results = calloc(n+1, sizeof(*results));
 	if (!results)
 		return NULL;
-	results[0] = lookup_common(rec, key, type, false, NULL);
+	results[0] = lookup_common(rec, key, type, false);
 	if (results[0]) {
 		if (!results[0]->has_meta_chars) {
 			/* exact match on key */
@@ -2000,7 +1983,7 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 		prefix_len = results[0]->prefix_len;
 	}
 	for (i = 1; i <= n; i++) {
-		results[i] = lookup_common(rec, aliases[i-1], type, false, NULL);
+		results[i] = lookup_common(rec, aliases[i-1], type, false);
 		if (results[i]) {
 			if (!results[i]->has_meta_chars) {
 				/* exact match on alias */
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 964b8418..372837dd 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -142,12 +142,4 @@ static inline void fclose_errno_safe(FILE *stream)
 	errno = saved_errno;
 }
 
-#ifdef __GNUC__
-# define likely(x)			__builtin_expect(!!(x), 1)
-# define unlikely(x)			__builtin_expect(!!(x), 0)
-#else
-# define likely(x)			(x)
-# define unlikely(x)			(x)
-#endif /* __GNUC__ */
-
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.47.1

