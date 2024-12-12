Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5E1B393D
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038116; cv=none; b=UulgyKQjkpQpmgZNyl2rCNyl7apxLw6sKrXr7ylVbWbgNYF+kZrkBPQyJSwXtsoTDBXwaCQVXrfDo+Bfxu16voI+rMV7ulz1skLbojgI/pT32HyloTw5w4Gb7usle8Hk29fcnRZZfRQINEld1YUztc/i9rcqkNltKeT2heu280U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038116; c=relaxed/simple;
	bh=RxQ0X03jAPnrm8yu8sQDUD9pFa1qVoZBoNRvnmOijZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKHwlLFbX0Q/moaQ3cbXBY3Otf2kjrkYbX46cIdC5Uro2ieEIZqmyDa7m7EDMC78n0E+Pa+8U0WUmLOe+ZSvxa0EKE9L27u22VjfqhVwNgn9HaCCWgn/N1FXR3+fusnUEC7i8O6RmxoSgv9t8LTqLUUQlaoDgL117L/OEgVJlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=M8pdjEes; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="M8pdjEes"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734038103;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7nTVPOuO+/yZmdFspoAIst/a2hdMVK0kQSk+Zwqig/g=;
	b=M8pdjEesmQdUQPdFqbV9R4MH2JpYlFmzyZzePlo0uo6200jmaZqnWPG978P259ZQSoR6ry
	YFJdiLtFKV+Mql1v9knknCIeZT5ei8Ib2Tnjou1CdWCqdXTccZ0kejr2R6y+5+9HjTCKTS
	LTnVJxlpGVf2rZziiWbqHL8XUYw3dxh0kg/z2LMx+McFBwzvln6gU4LUcE7duq5YDnqhZd
	Qp1oSCNbubafTYOxuv6cibya7p/twfHo8L9N4OyY6MhI50RI+dZIOtgBdrwW6zeo32ZfdQ
	umCIMdBBisXngNQOLiMYDj7Os/CMCZ0h+cAdMYqA44L9jS7th10DnY0Uqaf3ZA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Takaya Saeki <takayas@chromium.org>
Subject: [RFC PATCH v2] libselinux: restore previous regex spec ordering
Date: Thu, 12 Dec 2024 22:14:59 +0100
Message-ID: <20241212211459.125929-1-cgoettsche@seltendoof.de>
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

Prior the recent selabel_file(5) rework regular expressions for a
certain stem where matched in the order given by the input.
The Reference and Fedora Policy as well as CIL and libsemanage pre-sort
the file context definitions based on the prefix stem length, so this
ordering was adopted.

Do not alter the order by the input of regex specifications, and search
on matches on regex specifications in in parent nodes, which might
contain specifications with definitions defined later in the source
file.
This restores backward compatibility, especially for Android.

Reported-by: Takaya Saeki <takayas@chromium.org>
Closes: https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com/
Fixes: 92306da ("libselinux: rework selabel_file(5) database")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - search parent nodes for later regex specs
    The pre-compiled fcontext format changed, due to the addition of the
    line number for regex specs.  Thus files generated with 3.8-rc1
    will fail to load, but it won't result in wrong lookup results like
    the v1 patch.
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c           | 331 ++++++++++++++------------
 libselinux/src/label_file.h           |  47 +---
 libselinux/utils/sefcontext_compile.c |  11 +-
 3 files changed, 202 insertions(+), 187 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 80a7c5ab..56e20949 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -87,14 +87,14 @@ void sort_spec_node(struct spec_node *node, struct spec_node *parent)
 
 	node->parent = parent;
 
-	/* Sort for comparison support and binary search lookup */
+	/*
+	 * Sort for comparison support and binary search lookup,
+	 * except for regex specs which are matched in reverse input order.
+	 */
 
 	if (node->literal_specs_num > 1)
 		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
 
-	if (node->regex_specs_num > 1)
-		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
-
 	if (node->children_num > 1)
 		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
 
@@ -144,36 +144,38 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 
 	if (node->regex_specs_num > 1) {
 		for (uint32_t i = 0; i < node->regex_specs_num - 1; i++) {
-			const struct regex_spec *node1 = &node->regex_specs[i];
-			const struct regex_spec *node2 = &node->regex_specs[i+1];
+			for (uint32_t j = i; j < node->regex_specs_num - 1; j++) {
+				const struct regex_spec *node1 = &node->regex_specs[i];
+				const struct regex_spec *node2 = &node->regex_specs[j + 1];
 
-			if (node1->prefix_len != node2->prefix_len)
-				continue;
+				if (node1->prefix_len != node2->prefix_len)
+					continue;
 
-			if (strcmp(node1->regex_str, node2->regex_str) != 0)
-				continue;
+				if (strcmp(node1->regex_str, node2->regex_str) != 0)
+					continue;
 
-			if (node1->file_kind != LABEL_FILE_KIND_ALL && node2->file_kind != LABEL_FILE_KIND_ALL && node1->file_kind != node2->file_kind)
-				continue;
+				if (node1->file_kind != LABEL_FILE_KIND_ALL && node2->file_kind != LABEL_FILE_KIND_ALL && node1->file_kind != node2->file_kind)
+					continue;
 
-			rc = -1;
-			errno = EINVAL;
-			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) != 0) {
-				COMPAT_LOG
-					(SELINUX_ERROR,
-						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
-						path,
-						file_kind_to_string(node1->file_kind),
-						node1->regex_str,
-						node1->lr.ctx_raw,
-						node2->lr.ctx_raw);
-			} else {
-				COMPAT_LOG
-					(SELINUX_ERROR,
-						"%s: Multiple same specifications for %s %s.\n",
-						path,
-						file_kind_to_string(node1->file_kind),
-						node1->regex_str);
+				rc = -1;
+				errno = EINVAL;
+				if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) != 0) {
+					COMPAT_LOG
+						(SELINUX_ERROR,
+							"%s: Multiple different specifications for %s %s  (%s and %s).\n",
+							path,
+							file_kind_to_string(node1->file_kind),
+							node1->regex_str,
+							node1->lr.ctx_raw,
+							node2->lr.ctx_raw);
+				} else {
+					COMPAT_LOG
+						(SELINUX_ERROR,
+							"%s: Multiple same specifications for %s %s.\n",
+							path,
+							file_kind_to_string(node1->file_kind),
+							node1->regex_str);
+				}
 			}
 		}
 	}
@@ -190,7 +192,8 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 }
 
 FUZZ_EXTERN int process_text_file(FILE *fp, const char *prefix,
-				  struct selabel_handle *rec, const char *path)
+				  struct selabel_handle *rec, const char *path,
+				  uint8_t inputno)
 {
 	int rc;
 	size_t line_len;
@@ -199,7 +202,7 @@ FUZZ_EXTERN int process_text_file(FILE *fp, const char *prefix,
 	char *line_buf = NULL;
 
 	while ((nread = getline(&line_buf, &line_len, fp)) > 0) {
-		rc = process_line(rec, path, prefix, line_buf, nread, ++lineno);
+		rc = process_line(rec, path, prefix, line_buf, nread, inputno, ++lineno);
 		if (rc)
 			goto out;
 	}
@@ -568,9 +571,10 @@ static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
 }
 
 static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bool do_load_precompregex,
+				uint8_t inputno,
 				struct regex_spec *rspec, const struct context_array *ctx_array)
 {
-	uint32_t data_u32, ctx_id;
+	uint32_t data_u32, ctx_id, lineno;
 	uint16_t data_u16, regex_len;
 	uint8_t data_u8;
 	int rc;
@@ -600,6 +604,20 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 		rspec->lr.validated = true;
 
 
+	/*
+	 * Read line number in source file.
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	lineno = be32toh(data_u32);
+
+	if (lineno == 0 || lineno == UINT32_MAX)
+		return -1;
+	rspec->lineno = lineno;
+	rspec->inputno = inputno;
+
+
 	/*
 	 * Read original regex
 	 */
@@ -649,14 +667,14 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 	if (rc < 0)
 		return -1;
 
-	__pthread_mutex_init(&rspec->regex_lock, NULL);
 
+	__pthread_mutex_init(&rspec->regex_lock, NULL);
 
 	return 0;
 }
 
 static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bool validating, bool do_load_precompregex,
-			       struct spec_node *node, bool is_root, const struct context_array *ctx_array)
+			       struct spec_node *node, bool is_root, uint8_t inputno, const struct context_array *ctx_array)
 {
 	uint32_t data_u32, lspec_num, rspec_num, children_num;
 	uint16_t data_u16, stem_len;
@@ -744,7 +762,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 		node->regex_specs_alloc = rspec_num;
 
 		for (uint32_t i = 0; i < rspec_num; i++) {
-			rc = load_mmap_regex_spec(mmap_area, validating, do_load_precompregex, &node->regex_specs[i], ctx_array);
+			rc = load_mmap_regex_spec(mmap_area, validating, do_load_precompregex, inputno, &node->regex_specs[i], ctx_array);
 			if (rc)
 				return -1;
 		}
@@ -776,7 +794,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 		node->children_alloc = children_num;
 
 		for (uint32_t i = 0; i < children_num; i++) {
-			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], false, ctx_array);
+			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], false, inputno, ctx_array);
 			if (rc)
 				return -1;
 
@@ -796,7 +814,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 }
 
 FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
-			  const char *path)
+			  const char *path, uint8_t inputno)
 {
 	struct saved_data *data = rec->data;
 	struct spec_node *root = NULL;
@@ -952,6 +970,7 @@ end_arch_check:
 	rc = load_mmap_spec_node(mmap_area, path, rec->validating,
 				 reg_version_matches && reg_arch_matches,
 				 root, true,
+				 inputno,
 				 &ctx_array);
 	if (rc)
 		goto err;
@@ -1142,7 +1161,8 @@ static FILE *open_file(const char *path, const char *suffix,
 static int process_file(const char *path, const char *suffix,
 			struct selabel_handle *rec,
 			const char *prefix,
-			struct selabel_digest *digest)
+			struct selabel_digest *digest,
+			uint8_t inputno)
 {
 	int rc;
 	unsigned int i;
@@ -1171,9 +1191,9 @@ static int process_file(const char *path, const char *suffix,
 			COMPAT_LOG(SELINUX_INFO, "%s:  Old compiled fcontext format, skipping\n", found_path);
 			errno = EINVAL;
 		} else if (rc == 1) {
-			rc = load_mmap(fp, sb.st_size, rec, found_path);
+			rc = load_mmap(fp, sb.st_size, rec, found_path, inputno);
 		} else {
-			rc = process_text_file(fp, prefix, rec, found_path);
+			rc = process_text_file(fp, prefix, rec, found_path, inputno);
 		}
 
 		if (!rc)
@@ -1434,7 +1454,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	/*
 	 * The do detailed validation of the input and fill the spec array
 	 */
-	status = process_file(path, NULL, rec, prefix, rec->digest);
+	status = process_file(path, NULL, rec, prefix, rec->digest, 0);
 	if (status)
 		goto finish;
 
@@ -1448,12 +1468,12 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 
 	if (!baseonly) {
 		status = process_file(path, "homedirs", rec, prefix,
-							    rec->digest);
+							    rec->digest, 1);
 		if (status && errno != ENOENT)
 			goto finish;
 
 		status = process_file(path, "local", rec, prefix,
-							    rec->digest);
+							    rec->digest, 2);
 		if (status && errno != ENOENT)
 			goto finish;
 	}
@@ -1579,77 +1599,84 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 {
 	struct lookup_result *result = NULL;
 	struct lookup_result **next = &result;
+	struct lookup_result *child_regex_match = NULL;
+	uint8_t child_regex_match_inputno = 0;  /* initialize to please GCC */
+	uint32_t child_regex_match_lineno = 1;  /* initialize to please GCC */
 	size_t key_len = strlen(key);
 
 	assert(!(find_all && buf != NULL));
 
 	for (struct spec_node *n = node; n; n = n->parent) {
 
-		uint32_t literal_idx = search_literal_spec(n->literal_specs, n->literal_specs_num, key, key_len, partial);
-		if (literal_idx != (uint32_t)-1) {
-			do {
-				struct literal_spec *lspec = &n->literal_specs[literal_idx];
+		if (n == node) {
+			uint32_t literal_idx = search_literal_spec(n->literal_specs, n->literal_specs_num, key, key_len, partial);
+			if (literal_idx != (uint32_t)-1) {
+				do {
+					struct literal_spec *lspec = &n->literal_specs[literal_idx];
 
-				if (file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == file_kind) {
-					struct lookup_result *r;
+					if (file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == file_kind) {
+						struct lookup_result *r;
 
 #ifdef __ATOMIC_RELAXED
-					__atomic_store_n(&lspec->any_matches, true, __ATOMIC_RELAXED);
+						__atomic_store_n(&lspec->any_matches, true, __ATOMIC_RELAXED);
 #else
 #error "Please use a compiler that supports __atomic builtins"
 #endif
 
-					if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0) {
-						free_lookup_result(result);
-						errno = ENOENT;
-						return NULL;
-					}
+						if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0) {
+							errno = ENOENT;
+							goto fail;
+						}
 
-					if (likely(buf)) {
-						r = buf;
-					} else {
-						r = malloc(sizeof(*r));
-						if (!r) {
-							free_lookup_result(result);
-							return NULL;
+						if (likely(buf)) {
+							r = buf;
+						} else {
+							r = malloc(sizeof(*r));
+							if (!r)
+								goto fail;
 						}
-					}
 
-					*r = (struct lookup_result) {
-						.regex_str = lspec->regex_str,
-						.prefix_len = lspec->prefix_len,
-						.file_kind = lspec->file_kind,
-						.lr = &lspec->lr,
-						.has_meta_chars = false,
-						.next = NULL,
-					};
+						*r = (struct lookup_result) {
+							.regex_str = lspec->regex_str,
+							.prefix_len = lspec->prefix_len,
+							.file_kind = lspec->file_kind,
+							.lr = &lspec->lr,
+							.has_meta_chars = false,
+							.next = NULL,
+						};
 
-					if (likely(!find_all))
-						return r;
+						if (likely(!find_all))
+							return r;
 
-					*next = r;
-					next = &r->next;
-				}
+						*next = r;
+						next = &r->next;
+					}
 
-				literal_idx++;
-			} while (literal_idx < n->literal_specs_num &&
-				 (partial ? (strncmp(n->literal_specs[literal_idx].literal_match, key, key_len) == 0)
-					  : (strcmp(n->literal_specs[literal_idx].literal_match, key) == 0)));
+					literal_idx++;
+				} while (literal_idx < n->literal_specs_num &&
+					(partial ? (strncmp(n->literal_specs[literal_idx].literal_match, key, key_len) == 0)
+						: (strcmp(n->literal_specs[literal_idx].literal_match, key) == 0)));
+			}
 		}
 
-		for (uint32_t i = 0; i < n->regex_specs_num; i++) {
-			struct regex_spec *rspec = &n->regex_specs[i];
+		for (uint32_t i = n->regex_specs_num; i > 0; i--) {
+			/* search in reverse order */
+			struct regex_spec *rspec = &n->regex_specs[i - 1];
 			const char *errbuf = NULL;
 			int rc;
 
+			if (child_regex_match &&
+			    (rspec->inputno < child_regex_match_inputno ||
+			     (rspec->inputno == child_regex_match_inputno && rspec->lineno < child_regex_match_lineno)))
+				break;
+
 			if (file_kind != LABEL_FILE_KIND_ALL && rspec->file_kind != LABEL_FILE_KIND_ALL && file_kind != rspec->file_kind)
 				continue;
 
 			if (compile_regex(rspec, &errbuf) < 0) {
 				COMPAT_LOG(SELINUX_ERROR, "Failed to compile regular expression '%s':  %s\n",
 					   rspec->regex_str, errbuf);
-				free_lookup_result(result);
-				return NULL;
+				goto fail;
 			}
 
 			rc = regex_match(rspec->regex, key, partial);
@@ -1665,19 +1692,18 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 				}
 
 				if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0) {
-					free_lookup_result(result);
 					errno = ENOENT;
-					return NULL;
+					goto fail;
 				}
 
-				if (likely(buf)) {
+				if (child_regex_match) {
+					r = child_regex_match;
+				} else if (buf) {
 					r = buf;
 				} else {
 					r = malloc(sizeof(*r));
-					if (!r) {
-						free_lookup_result(result);
-						return NULL;
-					}
+					if (!r)
+						goto fail;
 				}
 
 				*r = (struct lookup_result) {
@@ -1689,8 +1715,12 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					.next = NULL,
 				};
 
-				if (likely(!find_all))
-					return r;
+				if (likely(!find_all)) {
+					child_regex_match = r;
+					child_regex_match_inputno = rspec->inputno;
+					child_regex_match_lineno = rspec->lineno;
+					goto parent_node;
+				}
 
 				*next = r;
 				next = &r->next;
@@ -1702,15 +1732,28 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 				continue;
 
 			/* else it's an error */
-			free_lookup_result(result);
 			errno = ENOENT;
-			return NULL;
+			goto fail;
 		}
+
+	    parent_node:
+		continue;
 	}
 
+	if (child_regex_match)
+		return child_regex_match;
+
 	if (!result)
 		errno = ENOENT;
 	return result;
+
+    fail:
+	if (!find_all && child_regex_match && child_regex_match != buf)
+		free(child_regex_match);
+
+	free_lookup_result(result);
+
+	return NULL;
 }
 
 static struct spec_node* search_child_node(struct spec_node *array, uint32_t size, const char *key, size_t key_len)
@@ -2221,81 +2264,69 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
 		while (iter1 < node1->regex_specs_num && iter2 < node2->regex_specs_num) {
 			const struct regex_spec *rspec1 = &node1->regex_specs[iter1];
 			const struct regex_spec *rspec2 = &node2->regex_specs[iter2];
-			int cmp;
-
-			if (rspec1->prefix_len > rspec2->prefix_len) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
-					result = SELABEL_SUPERSET;
-					iter1++;
-					continue;
-				}
+			bool found_successor;
 
-				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_prefix_length", iter1, iter2);
+			if (rspec1->file_kind == rspec2->file_kind && strcmp(rspec1->regex_str, rspec2->regex_str) == 0) {
+				iter1++;
+				iter2++;
+				continue;
 			}
 
-			if (rspec1->prefix_len < rspec2->prefix_len) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
-					result = SELABEL_SUBSET;
-					iter2++;
-					continue;
-				}
+			if (result == SELABEL_SUPERSET) {
+				iter1++;
+				continue;
+			}
 
-				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_prefix_length", iter1, iter2);
+			if (result == SELABEL_SUBSET) {
+				iter2++;
+				continue;
 			}
 
-			/* If prefix length is equal compare regex string */
+			assert(result == SELABEL_EQUAL);
 
-			cmp = strcmp(rspec1->regex_str, rspec2->regex_str);
-			if (cmp < 0) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
-					result = SELABEL_SUPERSET;
-					iter1++;
-					continue;
-				}
+			found_successor = false;
 
-				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1, iter2);
-			}
+			for (uint32_t i = iter2; i < node2->regex_specs_num; i++) {
+				const struct regex_spec *successor = &node2->regex_specs[i];
 
-			if (cmp > 0) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+				if (rspec1->file_kind == successor->file_kind && strcmp(rspec1->regex_str, successor->regex_str) == 0) {
 					result = SELABEL_SUBSET;
-					iter2++;
-					continue;
+					iter1++;
+					iter2 = i + 1;
+					found_successor = true;
+					break;
 				}
-
-				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1, iter2);
 			}
 
-			/* If literal match is equal compare file kind */
+			if (found_successor)
+				continue;
 
-			if (rspec1->file_kind > rspec2->file_kind) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
-					result = SELABEL_SUPERSET;
-					iter1++;
-					continue;
-				}
+			for (uint32_t i = iter1; i < node1->regex_specs_num; i++) {
+				const struct regex_spec *successor = &node1->regex_specs[i];
 
-				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1, iter2);
-			}
-
-			if (rspec1->file_kind < rspec2->file_kind) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
-					result = SELABEL_SUBSET;
+				if (successor->file_kind == rspec2->file_kind && strcmp(successor->regex_str, rspec2->regex_str) == 0) {
+					result = SELABEL_SUPERSET;
+					iter1 = i + 1;
 					iter2++;
-					continue;
+					found_successor = true;
+					break;
 				}
-
-				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1, iter2);
 			}
 
-			iter1++;
-			iter2++;
+			if (found_successor)
+				continue;
+
+			return rspec_incomp(node1->stem, rspec1, rspec2, "regex", iter1, iter2);
 		}
 		if (iter1 != node1->regex_specs_num) {
 			if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
 				result = SELABEL_SUPERSET;
 			} else {
-				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str left remnant in stem %s\n", fmt_stem(node1->stem));
+				const struct regex_spec *rspec1 = &node1->regex_specs[iter1];
+
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex left remnant in stem %s entry %u: (%s, %s, %s)\n",
+					    fmt_stem(node1->stem),
+					    iter1, rspec1->regex_str, file_kind_to_string(rspec1->file_kind), rspec1->lr.ctx_raw);
 				return SELABEL_INCOMPARABLE;
 			}
 		}
@@ -2303,7 +2334,11 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
 			if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
 				result = SELABEL_SUBSET;
 			} else {
-				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str right remnant in stem %s\n", fmt_stem(node1->stem));
+				const struct regex_spec *rspec2 = &node2->regex_specs[iter2];
+
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex right remnant in stem %s entry %u: (%s, %s, %s)\n",
+					    fmt_stem(node1->stem),
+					    iter2, rspec2->regex_str, file_kind_to_string(rspec2->file_kind), rspec2->lr.ctx_raw);
 				return SELABEL_INCOMPARABLE;
 			}
 		}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index c7fe3a48..2506f9b5 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -61,7 +61,7 @@ struct lookup_result {
 };
 #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
 extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
-extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path);
+extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path, uint8_t inputno);
 extern void free_lookup_result(struct lookup_result *result);
 extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all);
 extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
@@ -81,7 +81,9 @@ struct regex_spec {
 	char *regex_str;			/* original regular expression string for diagnostics */
 	struct regex_data *regex;		/* backend dependent regular expression data */
 	pthread_mutex_t regex_lock;		/* lock for lazy compilation of regex */
+	uint32_t lineno;			/* Line number in source file */
 	uint16_t prefix_len;			/* length of fixed path prefix */
+	uint8_t inputno;			/* Input number of source file */
 	uint8_t file_kind;			/* file type */
 	bool regex_compiled;			/* whether the regex is compiled */
 	bool any_matches;			/* whether any pathname match */
@@ -123,7 +125,7 @@ struct spec_node {
 	uint32_t literal_specs_num, literal_specs_alloc;
 
 	/*
-	 * Array of regular expression specifications (ordered from most to least specific)
+	 * Array of regular expression specifications (order preserved from input)
 	 */
 	struct regex_spec *regex_specs;
 	uint32_t regex_specs_num, regex_specs_alloc;
@@ -369,38 +371,6 @@ static inline int compare_literal_spec(const void *p1, const void *p2)
 	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind);
 }
 
-static inline int compare_regex_spec(const void *p1, const void *p2)
-{
-	const struct regex_spec *r1 = p1;
-	const struct regex_spec *r2 = p2;
-	size_t regex_len1, regex_len2;
-	int ret;
-
-	/* Order from high prefix length to low */
-	ret = (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2->prefix_len);
-	if (ret)
-		return ret;
-
-	/* Order from long total regex length to short */
-	regex_len1 = strlen(r1->regex_str);
-	regex_len2 = strlen(r2->regex_str);
-	ret = (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
-	if (ret)
-		return ret;
-
-	/*
-	 * Order for no-duplicates check.
-	 * Use reverse alphabetically order to retain the Fedora ordering of
-	 * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
-	 */
-	ret = strcmp(r1->regex_str, r2->regex_str);
-	if (ret)
-		return -ret;
-
-	/* Order wildcard mode (0) last */
-	return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->file_kind);
-}
-
 static inline int compare_spec_node(const void *p1, const void *p2)
 {
 	const struct spec_node *n1 = p1;
@@ -531,7 +501,7 @@ static inline int compile_regex(struct regex_spec *spec, const char **errbuf)
 
 static int insert_spec(const struct selabel_handle *rec, struct saved_data *data,
 		       const char *prefix, char *regex, uint8_t file_kind, char *context,
-		       const char *path, unsigned int lineno)
+		       const char *path, uint8_t inputno, uint32_t lineno)
 {
 	size_t prefix_len;
 	bool has_meta;
@@ -642,6 +612,8 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.regex_lock = PTHREAD_MUTEX_INITIALIZER,
 			.file_kind = file_kind,
 			.any_matches = false,
+			.inputno = inputno,
+			.lineno = lineno,
 			.lr.ctx_raw = context,
 			.lr.ctx_trans = NULL,
 			.lr.lineno = lineno,
@@ -816,7 +788,8 @@ static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
  * utils/sefcontext_compile.c */
 static inline int process_line(struct selabel_handle *rec,
 			       const char *path, const char *prefix,
-			       char *line_buf, size_t nread, unsigned lineno)
+			       char *line_buf, size_t nread,
+			       uint8_t inputno, uint32_t lineno)
 {
 	int items;
 	char *regex = NULL, *type = NULL, *context = NULL;
@@ -886,7 +859,7 @@ static inline int process_line(struct selabel_handle *rec,
 		free(type);
 	}
 
-	return insert_spec(rec, data, prefix, regex, file_kind, context, path, lineno);
+	return insert_spec(rec, data, prefix, regex, file_kind, context, path, inputno, lineno);
 }
 
 #endif /* _SELABEL_FILE_H_ */
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index b4445a1f..811b2a1a 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -31,7 +31,7 @@ static int validate_context(char **ctxp)
 
 static int process_file(struct selabel_handle *rec, const char *filename)
 {
-	unsigned int line_num;
+	uint32_t line_num;
 	int rc;
 	char *line_buf = NULL;
 	size_t line_len = 0;
@@ -48,7 +48,7 @@ static int process_file(struct selabel_handle *rec, const char *filename)
 	line_num = 0;
 	rc = 0;
 	while ((nread = getline(&line_buf, &line_len, context_file)) > 0) {
-		rc = process_line(rec, filename, prefix, line_buf, nread, ++line_num);
+		rc = process_line(rec, filename, prefix, line_buf, nread, 0, ++line_num);
 		if (rc || ctx_err) {
 			/* With -p option need to check and fail if ctx err as
 			 * process_line() context validation on Linux does not
@@ -160,6 +160,7 @@ static int create_sidtab(const struct saved_data *data, struct sidtab *stab)
  * Regular Expression Specification Format (RSpec)
  *
  * u32     - context table index for raw context (1-based)
+ * u32     - line number in source file
  * u16     - length of upcoming regex_str INCLUDING nul
  * [char]  - char array of the original regex string including the stem INCLUDING nul
  * u16     - length of the fixed path prefix
@@ -307,6 +308,12 @@ static int write_regex_spec(FILE *bin_file, bool do_write_precompregex, const st
 	if (len != 1)
 		return -1;
 
+	/* write line number */
+	data_u32 = htobe32(rspec->lineno);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
 	/* write regex string */
 	regex = rspec->regex_str;
 	regex_len = strlen(regex);
-- 
2.45.2

