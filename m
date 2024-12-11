Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52111DACAA
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933709; cv=none; b=XnVg/mAytm7HeGO7jbzqS6UtLVCFOcjXYBPJfc3qHfFmAzEWZzfxRCOU+zYJ06nnVk7D8lw21H7A8pxAdQa6tZRbLmHog54PVejXyUXalNZHBj/a24tLO9QxiemVuDir8YkwSrG6QhLeDkd0H+zwr2KHXTzqwlrmUu+9cU9e1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933709; c=relaxed/simple;
	bh=2K+TOaLCdwOwIOW2QXyLxk1PWqIVhySRUn41RK/aQFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IcxO7oQXknCu7ghWXVIAjMck5wMpI0FomQW0SyDWWKZk/qkvY00pa3utPsVHK4TCv7tMM+Sujct/D6uNXK9k5JJ2Uf6S+JdclDqTEM8gRXCV3Gil6WEhCQIR8ZL++/hmKy3gpM7+cTbvLFMiqIHBHLuP953pdewNi0lbWoVuH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pNZpM8YD; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pNZpM8YD"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733933697;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I0eePQUggxIUogPo2DqKUc6FnN75BmKtg+iF5ZkfVGY=;
	b=pNZpM8YD/TtIoSVAAXceT04TBKzP/T93FYIm8AXvlZ8Nw2AGHHK7L7crmxTwJS4hewAdus
	HhqrH6DpO1wFFi6SOpW78IFd3rKaAYTrdSxARYP8EsrTMLJ8TtosaGL+RJaA9wWhQLLv+8
	NRpKzXTTXZlW0rdJjITUvRLKeunBBjpRDoTZXX/1nYXAG991XoiPeBn9PajSPQrzz3f6/J
	Cc3ehNUl4aWF5zJkeVr/c1UGVP99vkypa/jXYzocmAkRmWbsNP/Y5ySh7I6sTrqZ2VArSw
	w6c2Ue46D0Y9C0eEjQ+kpPdf48W40g9KH9GRYx3cGzgscQWX18nJAe4WlDWddQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Takaya Saeki <takayas@chromium.org>
Subject: [RFC PATCH] libselinux: restore previous regex spec ordering
Date: Wed, 11 Dec 2024 17:14:43 +0100
Message-ID: <20241211161443.51286-1-cgoettsche@seltendoof.de>
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
Do not alter the order by the input of regex specifications to retain
backward compatibility, e.g. for Android.

Reported-by: Takaya Saeki <takayas@chromium.org>
Closes: https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com/
Fixes: 92306da ("libselinux: rework selabel_file(5) database")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
**NOTE**:
Using a pre-compiled fcontext file generated with 3.8-rc1 (3.7 and prior
is fine) will result in vastly wrong lookup results.
Thus all users upgrading from 3.8-rc1 **should** remove their
pre-compiled fcontext definitions, e.g. via

  rm /etc/selinux/*/contexts/files/*.bin

In case this commits get applied this should be mentioned in the release
notes for 3.8-rc2.
---
 libselinux/src/label_file.c | 163 +++++++++++++++++-------------------
 libselinux/src/label_file.h |  34 +-------
 2 files changed, 80 insertions(+), 117 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 80a7c5ab..3e35381d 100644
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
@@ -1637,8 +1639,9 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					  : (strcmp(n->literal_specs[literal_idx].literal_match, key) == 0)));
 		}
 
-		for (uint32_t i = 0; i < n->regex_specs_num; i++) {
-			struct regex_spec *rspec = &n->regex_specs[i];
+		for (uint32_t i = n->regex_specs_num; i > 0; i--) {
+			/* search in reverse order */
+			struct regex_spec *rspec = &n->regex_specs[i - 1];
 			const char *errbuf = NULL;
 			int rc;
 
@@ -2221,81 +2224,69 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
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
-
-			if (rspec1->file_kind > rspec2->file_kind) {
-				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
-					result = SELABEL_SUPERSET;
-					iter1++;
-					continue;
-				}
+			if (found_successor)
+				continue;
 
-				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1, iter2);
-			}
+			for (uint32_t i = iter1; i < node1->regex_specs_num; i++) {
+				const struct regex_spec *successor = &node1->regex_specs[i];
 
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
@@ -2303,7 +2294,11 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
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
index c7fe3a48..7e999ce8 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -123,7 +123,7 @@ struct spec_node {
 	uint32_t literal_specs_num, literal_specs_alloc;
 
 	/*
-	 * Array of regular expression specifications (ordered from most to least specific)
+	 * Array of regular expression specifications (order preserved from input)
 	 */
 	struct regex_spec *regex_specs;
 	uint32_t regex_specs_num, regex_specs_alloc;
@@ -369,38 +369,6 @@ static inline int compare_literal_spec(const void *p1, const void *p2)
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
-- 
2.45.2

