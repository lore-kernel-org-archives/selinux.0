Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A641E6DF
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577134; cv=none; b=hv1gvbkpYuhzz9uoJquPmJvRgQXK6Wal264iOPSjATV2SYelDGGgirZGwyr9FGKxTi1nPQZ5FgkuZTx8CFMYQLbpg0K/pWWNgbCAAWfP6MBpLG7QtlwVHtVr7swZM/7olqXJLi4DPVoIsXZ9k1dYOVQ9paV2plTr93GlnMoGXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577134; c=relaxed/simple;
	bh=R9NkyV4IQVz26auN1xt9+iixA6pK4uCOm0v3lvjeq9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ll68A6UqZt/MLH+23t1pKeCZHdAJ/c55N8bHGns1a/KBw/zaA1L1ttJ0IMt09gm1iYIUBnQdj+PsUQw8fWzEEfL16j/I181mg5t/Yrz3dqSlwDieYjKflzFMiXqsDDV20H1DQmCGwOSAw1+UEHNWIAlCyp429Np2MnvPVlFGCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0HoMIys; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0HoMIys"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d590ce5cdso23399461cf.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787577131; x=1788181931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3bMldZhBeVFlSREbi3Ic0Q0RIsI33riTsMv7xgM+yo=;
        b=m0HoMIysvGHYvvpZuayZ5p6oOI6tm0kJLE4wqq3hv+7f2687hoxDjn82jB+WdbU7r3
         q0iBHcTb0Id/D/gvfegzlfJNOx+G6Byy4kUrXpnKdPiNm8rtFGid2QgwD6VCZwcqWSh9
         GBsc9TJZycmQCfe/zXD0UFK6cM/CKrcFI/GJcFIWgzn5UU5bqTfbR5v/gJGV3RA8OTKb
         X5qadGEamyZ9WafJ33R+C/hD3EYdhzjUbmYAf2gLQMnEvpfhx+UqUpx+OrvKnXwIYTGJ
         wSNhR06bjYWPeI3KXNGIjEyio+WWWxS5m56pwLr7IzKsZWyw0J8KJMq3CFSKPGCzm3Wu
         siXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577131; x=1788181931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3bMldZhBeVFlSREbi3Ic0Q0RIsI33riTsMv7xgM+yo=;
        b=hW8IKeyEsvGAms2+ef+FO0YxZZGlBFFeq+ea5sIeaJu+VEgJIGqhz3yvbTXluehX+r
         Y5bMBXuqK0zu4vMSa1fRTKhCdqsl7j5HLXqb4uuFmcNpmFx8aJEMtFPnukwut5ZkoD+b
         YhTETuVgpssy4DAFGDEggS8husuWKdhPcREtrQ4rZkCWoY+VzXmNmXAH574v+/1XXX0D
         ATtIYOxgyTASXqDBYjIIWlDafsbfZaPGUAOQbkhYJX4fFQtdy37Oi93Q/jwQPx8ydAgB
         ihL0nTpia6qcOCOywIpPQchhwj8kBQBDhwDdfrX9K7NfHSsDCqy54tYaTTV30qhCBo0l
         byOg==
X-Gm-Message-State: AFuF++l+O5qUC/HskPwSedeG1yY46rGMfmrP7K+MzWHKc6Ik/y7Og23e
	CEADmf8wOqL7ZoJBPA8cnMvBUJf+TnyzAk1uxHYepcTXEDkubp6qNW8LR312Lw==
X-Gm-Gg: AR+sD12j4arSNTpIta5MtBqbIPGwGHicT8hqI8GN4Titnvdc2kihuSI8f+1eLzRAhPK
	j149CRkMarTatNNQOAEO3W15f36no1G8sQIFy6MRVdmmtDnWS1w0A8H8q3fyAtf1VAVY9Hwi1/h
	K0l6uw3oBFBIvPeOpzJKVXyUR380nM0KOU0eqeSSF0PJ5BJ/dzpjZa7CVmNhfE0xgERC23FefUf
	QzBwRttUkVsXYnbf8FQV4ci0e3C1BKKDBwEZS72oYmRENz1grfv+GBf/rVxgi01gxsbhgAIxdq2
	Vb3epaLXkG4BElemxtdCcaYfhkqHAWxivhvq6b4VYWpCYJTUpz5AsrQaYkKdU0W2Ez1jdPP+WcU
	DB0OcLetGmFvaWqiZykGxu3sPW9WfrtxuvfQBphffxuFFGP16mgsqzm8yc154gCELaL1/U6YJGs
	9A8grwm06r5QUP9PRqcS/5lUfE7X8AWvxtf1eAKj5q5Sio0KJwXrQ3Ulrc197eAt1oDm77mSTz+
	JK4ofu5eLzVQgegxp6yHb0Lqm1y/AUmn8y3vptE/My/BEX5NeptvKidErQFLJ02
X-Received: by 2002:a05:622a:514e:b0:51c:1a17:eba0 with SMTP id d75a77b69052e-52df56e10d6mr272164971cf.2.1787577131312;
        Mon, 24 Aug 2026 06:12:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aafa4bsm46842741cf.14.2026.08.24.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:12:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	p.matyas13@gmail.com,
	pmatyas@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: label_file: make JIT compilation opt-in
Date: Mon, 24 Aug 2026 09:11:54 -0400
Message-ID: <20260824131154.68022-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 92af7f1b61db6e ("libselinux: prevent ReDoS in file context
regex matching") introduced the use of pcre2_jit_compile() after every
pattern compilation to leverage JIT for regex matching to help
mitigate catastrophic backtracking on crafted file context regexes or
lookup keys. This triggers SELinux execmem permission checks on every
caller of selabel_open(SELABEL_CTX_FILE, ..). Permission denial is
non-fatal in this case but allowing this permission may be undesirable
for some callers and will produce audit log noise for others. Further,
the JITed matching itself is subject to stack overflow on crafted
regexes. Make the JIT compilation opt-in rather than automatic via a
new SELABEL_OPT_JIT option for selabel_open() so that we do not impact
existing callers while allowing callers to selectively opt in when
they want this behavior and run in a context that can be allowed
execmem without concern.

Link: https://lore.kernel.org/selinux/20260729131413.1390890-1-pmatyas@redhat.com/
Link: https://lore.kernel.org/selinux/CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8bFEJ6NCXWerrSvvYA@mail.gmail.com/
Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex matching")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/include/selinux/label.h |  4 +++-
 libselinux/man/man3/selabel_open.3 |  7 +++++++
 libselinux/src/label.c             | 13 ++++++++++++
 libselinux/src/label_file.c        | 33 ++++++++++++++++++------------
 libselinux/src/label_file.h        |  6 +++---
 libselinux/src/label_internal.h    |  2 ++
 libselinux/src/regex.c             | 11 ++++++----
 libselinux/src/regex.h             |  6 ++++--
 8 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index bde2501f..10e3a718 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -59,8 +59,10 @@ struct selabel_handle;
 #define SELABEL_OPT_SUBSET 4
 /* require a hash calculation on spec files */
 #define SELABEL_OPT_DIGEST 5
+/* enable JIT compilation of regexes */
+#define SELABEL_OPT_JIT 6
 /* total number of options */
-#define SELABEL_NOPT 6
+#define SELABEL_NOPT 7
 
 /*
  * Label operations
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 0e03e1be..fa71d27c 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -73,6 +73,13 @@ A non-null value for this option enables the generation of an SHA1 digest of
 the spec files loaded as described in
 .BR selabel_digest (3)
 .
+.TP
+.B SELABEL_OPT_JIT
+A non-null value for this option enables the JIT compilation of regexes
+read from the spec files. This option is only currently supported with
+the
+.B SELABEL_CTX_FILE
+backend.
 .SH "BACKENDS"
 .TP
 .B SELABEL_CTX_FILE
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 4a97d3bc..93848bfe 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -155,6 +155,18 @@ int selabel_validate(struct selabel_lookup_rec *contexts)
 	return 0;
 }
 
+/* Should we enable JIT compilation? */
+static inline int selabel_is_jit_set(const struct selinux_opt *opts, unsigned n)
+{
+	while (n) {
+		n--;
+		if (opts[n].type == SELABEL_OPT_JIT)
+			return !!opts[n].value;
+	}
+
+	return 0;
+}
+
 /* Public API helpers */
 static int selabel_fini(const struct selabel_handle *rec,
 			struct selabel_lookup_rec *lr, bool translating)
@@ -261,6 +273,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
 
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
+	rec->jit = selabel_is_jit_set(opts, nopts);
 
 	rec->digest = selabel_is_digest_set(opts, nopts);
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index d716e0f1..91220fc8 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -633,8 +633,8 @@ static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
 }
 
 static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating,
-				bool do_load_precompregex, uint8_t inputno,
-				struct regex_spec *rspec,
+				bool jit, bool do_load_precompregex,
+				uint8_t inputno, struct regex_spec *rspec,
 				const struct context_array *ctx_array)
 {
 	uint32_t data_u32, ctx_id, lineno;
@@ -723,7 +723,7 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating,
 	 * Read pcre regex related data
 	 */
 	rc = regex_load_mmap(mmap_area, &rspec->regex, do_load_precompregex,
-			     &rspec->regex_compiled);
+			     jit, &rspec->regex_compiled);
 	if (rc < 0)
 		return -1;
 
@@ -733,7 +733,8 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating,
 }
 
 static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path,
-			       bool validating, bool do_load_precompregex,
+			       bool jit, bool validating,
+			       bool do_load_precompregex,
 			       struct spec_node *node, const unsigned depth,
 			       uint8_t inputno,
 			       const struct context_array *ctx_array)
@@ -840,7 +841,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path,
 		node->regex_specs_alloc = rspec_num;
 
 		for (uint32_t i = 0; i < rspec_num; i++) {
-			rc = load_mmap_regex_spec(mmap_area, validating,
+			rc = load_mmap_regex_spec(mmap_area, validating, jit,
 						  do_load_precompregex, inputno,
 						  &node->regex_specs[i],
 						  ctx_array);
@@ -876,7 +877,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path,
 
 		for (uint32_t i = 0; i < children_num; i++) {
 			rc = load_mmap_spec_node(mmap_area, path, validating,
-						 do_load_precompregex,
+						 jit, do_load_precompregex,
 						 &node->children[i], depth + 1,
 						 inputno, ctx_array);
 			if (rc)
@@ -1064,7 +1065,7 @@ end_arch_check:
 	if (!root)
 		goto err;
 
-	rc = load_mmap_spec_node(mmap_area, path, rec->validating,
+	rc = load_mmap_spec_node(mmap_area, path, rec->validating, rec->jit,
 				 reg_version_matches && reg_arch_matches, root,
 				 0, inputno, &ctx_array);
 	if (rc)
@@ -1539,6 +1540,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		case SELABEL_OPT_VALIDATE:
 		case SELABEL_OPT_DIGEST:
 			break;
+		case SELABEL_OPT_JIT:
+			break;
 		default:
 			errno = EINVAL;
 			return -1;
@@ -1890,6 +1893,7 @@ fail:
  * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
  * @partial:   Whether to partially match the given file path or completely.
  * @find_all:  Whether to find all file context definitions or just the most specific.
+ * @jit:       Whether to enable JIT compilation of regexes.
  * @buf:       A pre-allocated buffer for a potential result to avoid allocating it on the heap or
  *             NULL. Mutual exclusive with @find_all.
  *
@@ -1897,9 +1901,11 @@ fail:
  *         its a linked list of all results. If @buf was specified it is returned on a match found.
  *         NULL is returned in case of no match found.
  */
-static struct lookup_result *
-lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
-		  bool partial, bool find_all, struct lookup_result *buf)
+static struct lookup_result *lookup_check_node(struct spec_node *node,
+					       const char *key,
+					       uint8_t file_kind, bool partial,
+					       bool find_all, bool jit,
+					       struct lookup_result *buf)
 {
 	struct lookup_result *result = NULL;
 	struct lookup_result **next = &result;
@@ -2002,7 +2008,8 @@ lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
 			    file_kind != rspec->file_kind)
 				continue;
 
-			if (compile_regex(rspec, errbuf, sizeof(errbuf)) < 0) {
+			if (compile_regex(rspec, errbuf, sizeof(errbuf), jit) <
+			    0) {
 				COMPAT_LOG(
 					SELINUX_ERROR,
 					"Failed to compile regular expression '%s':  %s\n",
@@ -2274,8 +2281,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	node = lookup_find_deepest_node(data->root, key, &rest_key);
 
-	result =
-		lookup_check_node(node, key, file_kind, partial, find_all, buf);
+	result = lookup_check_node(node, key, file_kind, partial, find_all,
+				   rec->jit, buf);
 
 	/* For partial lookup if the key matches a child node, recursively add all specs */
 	if (partial && rest_key) {
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 3be15f25..acfe2e0d 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -398,7 +398,7 @@ static inline void sort_specs(struct saved_data *data)
 }
 
 static int compile_regex(struct regex_spec *spec, char *errbuf,
-			 size_t errbuf_size)
+			 size_t errbuf_size, bool jit)
 {
 	const char *reg_buf;
 	char *anchored_regex, *cp;
@@ -473,7 +473,7 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 	*cp = '\0';
 
 	/* Compile the regular expression. */
-	rc = regex_prepare_data(&spec->regex, anchored_regex, &error_data);
+	rc = regex_prepare_data(&spec->regex, anchored_regex, &error_data, jit);
 	free(anchored_regex);
 	if (rc < 0) {
 		regex_format_error(&error_data, errbuf, errbuf_size);
@@ -655,7 +655,7 @@ static int insert_spec(const struct selabel_handle *rec,
 			char errbuf[256];
 
 			if (compile_regex(&node->regex_specs[id], errbuf,
-					  sizeof(errbuf))) {
+					  sizeof(errbuf), rec->jit)) {
 				COMPAT_LOG(
 					SELINUX_ERROR,
 					"%s:  line %u has invalid regex %s:  %s\n",
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 4279637e..47c5d3cb 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 #include "sha1.h"
@@ -73,6 +74,7 @@ struct selabel_handle {
 	/* arguments that were passed to selabel_open */
 	unsigned int backend;
 	int validating;
+	bool jit;
 
 	/* labeling operations */
 	struct selabel_lookup_rec *(*func_lookup)(struct selabel_handle *h,
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 017647b4..d72d54eb 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -87,7 +87,7 @@ struct regex_data {
 };
 
 int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
-		       struct regex_error_data *errordata)
+		       struct regex_error_data *errordata, bool jit)
 {
 	memset(errordata, 0, sizeof(struct regex_error_data));
 
@@ -108,7 +108,8 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	 * susceptibility to catastrophic backtracking. Partial matches fall
 	 * back to the interpreter, protected by the match limit. Failures
 	 * are non-fatal. */
-	(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
+	if (jit)
+		(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
 
 	return 0;
 
@@ -130,7 +131,7 @@ char const *regex_version(void)
 }
 
 int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
-		    int do_load_precompregex, bool *regex_compiled)
+		    int do_load_precompregex, bool jit, bool *regex_compiled)
 {
 	int rc;
 	uint32_t data_u32, entry_len;
@@ -164,7 +165,9 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		if (rc != 1)
 			goto err;
 
-		(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
+		if (jit)
+			(void)pcre2_jit_compile((*regex)->regex,
+						PCRE2_JIT_COMPLETE);
 
 		*regex_compiled = true;
 	}
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 0eea2803..4cda7bfc 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -78,11 +78,12 @@ void regex_data_free(struct regex_data *regex);
  *                to this function. This structure depends on the underlying
  *                implementation. It can be passed to regex_format_error
  *                to generate a human readable error message.
+ * @arg jit A boolean indicating whether JIT compilation should be performed.
  * @retval 0 on success
  * @retval -1 on error
  */
 int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
-		       struct regex_error_data *errordata);
+		       struct regex_error_data *errordata, bool jit);
 /**
  * This function loads a serialized precompiled pattern from a contiguous
  * data region given by map_area.
@@ -93,6 +94,7 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
  *            with regex_data_create and must be freed with regex_data_free.
  * @arg do_load_precompregex If non-zero precompiled patterns get loaded from
  *			     the mmap region (ignored by PCRE1 back-end).
+ * @arg jit A boolean indicating whether JIT compilation should be performed.
  * @arg regex_compiled Set to true if a precompiled pattern was loaded
  * 		       into regex, otherwise set to false to indicate later
  *		       compilation must occur
@@ -101,7 +103,7 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
  * @retval -1 on error
  */
 int regex_load_mmap(struct mmap_area *map_area, struct regex_data **regex,
-		    int do_load_precompregex, bool *regex_compiled);
+		    int do_load_precompregex, bool jit, bool *regex_compiled);
 /**
  * This function stores a precompiled regular expression to a file.
  * In the case of PCRE, it just dumps the binary representation of the
-- 
2.55.0

