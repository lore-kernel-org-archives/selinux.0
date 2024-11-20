Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CC1A3056
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104009; cv=none; b=hOqos6FTKLu4awRndtXNdiT6+lGsMWtrA9OvEcmWWSjXbZYmDsaToOK32VMBGFtv9w7crU8c0gYGnljwjpjVR/BX/Q03TOH5DutFkKPG2Ln4i1MmFYY0fh1m1rywrlfVfgDMBqE8UtP3/UgJeImufhek6+LapMBFumZLogiIQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104009; c=relaxed/simple;
	bh=xnD31VWmzgT/zx+OloSCWZuZ9QXBXBf5xpSHz6ieICw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNdepmac/R9v7jh8rHzkq2WdL4PHopogP+0d+WbeLbSdq1gXxryprR1O4S4hfUIVHseGsii9Rhbs2Go3FxKuLDVCQdGjkZ/8E5WKG8wNA+0aBI7cXaP4cDhDbME4172uoyKE4BdiHL15QoIPh7MCiTXQrSeTEDczdwsxAi54zoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Gke0Yll6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Gke0Yll6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732103998;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7z1uVjloLm6oWfzAA7CtwZwufEXxECXJ2j3hatsY8Q=;
	b=Gke0Yll6lh73N69thjtQ3ga1JMVn7UWF74wgg0mOG/wzna/wpUWpi5DpypnlaGuHgH1aRz
	ZMJl2kgcS540odh878eoL0Nm01eVTH4VnFQLx/pktLrNIPMmAaXZ4dcM8wLOTpRkFIM11/
	6EQ85NNxVhfw4M4IAL/Kcc+NJeL5q+/YbftA8YiJ9YQYUxoT0xBIKeZKGce0dM9AGOmej/
	t3ULLJCzCFHgWsyI/SzUEDkG6H6qjTfQs0oOOjNGsUXaK0CND0vBJYZrDH4qahp6/TDaQ+
	V7B4sJUl92E1GQJnRChhJQxoepWXq0Guts3ypDpypMNg2kps01lsPaf6cu9MWA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/3] libselinux: move functions out of header file
Date: Wed, 20 Nov 2024 12:59:50 +0100
Message-ID: <20241120115951.42445-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241120115951.42445-1-cgoettsche@seltendoof.de>
References: <20241120115951.42445-1-cgoettsche@seltendoof.de>
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

When building libselinux from its own directory GCC complains about the
two functions free_spec_node() and sort_spec_node(), which are not tiny
and also recursive.

    In file included from label_file.c:27:
    In function ‘load_mmap’,
       inlined from ‘process_file’ at label_file.c:1106:9:
    label_file.h:816:20: error: inlining failed in call to ‘free_spec_node’: --param max-inline-insns-single limit reached [-Werror=inline]
      816 | static inline void free_spec_node(struct spec_node *node)
          |                    ^~~~~~~~~~~~~~
    label_file.c:899:17: note: called from here
      899 |                 free_spec_node(data->root);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
    label_file.h:816:20: error: inlining failed in call to ‘free_spec_node’: --param max-inline-insns-single limit reached [-Werror=inline]
      816 | static inline void free_spec_node(struct spec_node *node)
          |                    ^~~~~~~~~~~~~~
    label_file.c:908:17: note: called from here
      908 |                 free_spec_node(root);
          |                 ^~~~~~~~~~~~~~~~~~~~
  In function ‘sort_specs’,
      inlined from ‘init’ at label_file.c:1350:3:
    label_file.h:404:20: error: inlining failed in call to ‘sort_spec_node’: --param max-inline-insns-single limit reached [-Werror=inline]
      404 | static inline void sort_spec_node(struct spec_node *node, struct spec_node *parent)
          |                    ^~~~~~~~~~~~~~
    label_file.h:433:9: note: called from here
      433 |         sort_spec_node(data->root, NULL);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In function ‘sort_specs’,
        inlined from ‘init’ at label_file.c:1370:3:
    label_file.h:404:20: error: inlining failed in call to ‘sort_spec_node’: --param max-inline-insns-single limit reached [-Werror=inline]
      404 | static inline void sort_spec_node(struct spec_node *node, struct spec_node *parent)
          |                    ^~~~~~~~~~~~~~
    label_file.h:433:9: note: called from here
      433 |         sort_spec_node(data->root, NULL);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - add patch
---
 libselinux/src/label_file.c | 68 +++++++++++++++++++++++++++++++++++
 libselinux/src/label_file.h | 71 ++-----------------------------------
 2 files changed, 71 insertions(+), 68 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 189a5ed2..40bcb9ee 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -34,6 +34,74 @@
 #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
 
 
+void free_spec_node(struct spec_node *node)
+{
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		struct literal_spec *lspec = &node->literal_specs[i];
+
+		free(lspec->lr.ctx_raw);
+		free(lspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&lspec->lr.lock);
+
+		if (lspec->from_mmap)
+			continue;
+
+		free(lspec->literal_match);
+		free(lspec->regex_str);
+	}
+	free(node->literal_specs);
+
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		struct regex_spec *rspec = &node->regex_specs[i];
+
+		free(rspec->lr.ctx_raw);
+		free(rspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&rspec->lr.lock);
+		regex_data_free(rspec->regex);
+		__pthread_mutex_destroy(&rspec->regex_lock);
+
+		if (rspec->from_mmap)
+			continue;
+
+		free(rspec->regex_str);
+	}
+	free(node->regex_specs);
+
+	for (uint32_t i = 0; i < node->children_num; i++)
+		free_spec_node(&node->children[i]);
+	free(node->children);
+
+	if (!node->from_mmap)
+		free(node->stem);
+}
+
+void sort_spec_node(struct spec_node *node, struct spec_node *parent)
+{
+	/* A node should not be its own parent */
+	assert(node != parent);
+	/* Only root node has NULL stem */
+	assert((!parent && !node->stem) || (parent && node->stem && node->stem[0] != '\0'));
+	/* A non-root node should not be empty */
+	assert(!parent || (node->literal_specs_num || node->regex_specs_num || node->children_num));
+
+
+	node->parent = parent;
+
+	/* Sort for comparison support and binary search lookup */
+
+	if (node->literal_specs_num > 1)
+		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
+
+	if (node->regex_specs_num > 1)
+		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
+
+	if (node->children_num > 1)
+		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
+
+	for (uint32_t i = 0; i < node->children_num; i++)
+		sort_spec_node(&node->children[i], node);
+}
+
 /*
  * Warn about duplicate specifications.
  */
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index de8190f9..b59db003 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -164,6 +164,9 @@ struct saved_data {
 	struct selabel_sub *subs;
 };
 
+void free_spec_node(struct spec_node *node);
+void sort_spec_node(struct spec_node *node, struct spec_node *parent);
+
 static inline mode_t string_to_file_kind(const char *mode)
 {
 	if (mode[0] != '-' || mode[1] == '\0' || mode[2] != '\0')
@@ -401,33 +404,6 @@ static inline int compare_spec_node(const void *p1, const void *p2)
 	return rc;
 }
 
-static inline void sort_spec_node(struct spec_node *node, struct spec_node *parent)
-{
-	/* A node should not be its own parent */
-	assert(node != parent);
-	/* Only root node has NULL stem */
-	assert((!parent && !node->stem) || (parent && node->stem && node->stem[0] != '\0'));
-	/* A non-root node should not be empty */
-	assert(!parent || (node->literal_specs_num || node->regex_specs_num || node->children_num));
-
-
-	node->parent = parent;
-
-	/* Sort for comparison support and binary search lookup */
-
-	if (node->literal_specs_num > 1)
-		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
-
-	if (node->regex_specs_num > 1)
-		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
-
-	if (node->children_num > 1)
-		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
-
-	for (uint32_t i = 0; i < node->children_num; i++)
-		sort_spec_node(&node->children[i], node);
-}
-
 static inline void sort_specs(struct saved_data *data)
 {
 	sort_spec_node(data->root, NULL);
@@ -813,47 +789,6 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 
 #undef GROW_ARRAY
 
-static inline void free_spec_node(struct spec_node *node)
-{
-	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
-		struct literal_spec *lspec = &node->literal_specs[i];
-
-		free(lspec->lr.ctx_raw);
-		free(lspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&lspec->lr.lock);
-
-		if (lspec->from_mmap)
-			continue;
-
-		free(lspec->literal_match);
-		free(lspec->regex_str);
-	}
-	free(node->literal_specs);
-
-	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
-		struct regex_spec *rspec = &node->regex_specs[i];
-
-		free(rspec->lr.ctx_raw);
-		free(rspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&rspec->lr.lock);
-		regex_data_free(rspec->regex);
-		__pthread_mutex_destroy(&rspec->regex_lock);
-
-		if (rspec->from_mmap)
-			continue;
-
-		free(rspec->regex_str);
-	}
-	free(node->regex_specs);
-
-	for (uint32_t i = 0; i < node->children_num; i++)
-		free_spec_node(&node->children[i]);
-	free(node->children);
-
-	if (!node->from_mmap)
-		free(node->stem);
-}
-
 /* This will always check for buffer over-runs and either read the next entry
  * if buf != NULL or skip over the entry (as these areas are mapped in the
  * current buffer). */
-- 
2.45.2

