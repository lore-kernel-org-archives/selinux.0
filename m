Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD367AE6D
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706540; cv=none; b=EzS8RZzN4IDFRh42C/+XKERq1or3L1fIA7TOt+5DBOLWimSKoh5y3rl53rbQRVp3yoY+YeIXU7y4F4pNEtF3JFSOcM59x7UJa117FYE3PJparM0whG33gUUv+SZh13GTxSywaWwaDz8oxGzSJYUyMc+YSeI+B4/w8h6ccbRi+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706540; c=relaxed/simple;
	bh=nzvjc5BWpHkF2xaD0Km3MIe9gmc0CT7ukNgdSZbrhW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OK97KzfdlR3mfZZ1yiDaqj55WBHjNrVlXYHDHcFbmYm2oDrUP9A7etEEgcDIdCJz6lMxJ78Zk9G/15d0vtpVIj61cAfhgFVr+66hlqYC9oNWoM4asR+I8fQdsWNIh6DAyPem/bTGJHb8bunYNn7zjqIpZ3sisrXH4xBHGqurVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MM/p9an+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MM/p9an+"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso4203297a12.0
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706532; x=1707311332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha1A6Kn+bkcgv+g3rl8I/rNKLelMVa+jFTu2IcMfQYM=;
        b=MM/p9an+2JTag02fCa7DAkISuBzXz0/Mlf6WAJO8bkS1FfXfZ2T0zKPSsbtAOCc4pi
         HMzZ/qvzwGRzB+yZEFKDTtmNmV8uDwAN+0JyCN8WXltKkq51tIA4i0UW2+f98g9k2HGf
         baHq3xdLH/Tmfkt0hPwV8wm3AHoI7zHlXmSZWZ4axxzC+bnPjE0pZekEgWsGvPJsPmt8
         y5fTkhkpUB6BjBS3bN6GqQaHqkPPKgmvvlYb6FzMjHfR5Jzh3ferJf9upviVA6ZHnY1y
         GmNH8QEq68849Iz+fSkG3EN4zRrBuPsIePt3zOtR3hNo0oYz6dT/F2LSuqBu3EKWcXjS
         Pf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706532; x=1707311332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha1A6Kn+bkcgv+g3rl8I/rNKLelMVa+jFTu2IcMfQYM=;
        b=AFCKHsmxnKu4wS+31vZSRaOMqTFVGCWRY67Aw5oAUf8BXfUUwx1p2BekUH0qIw6IYh
         3MLfWKe4APRFapR4FVt9dr9cxslEDxWZMpBgRYT/G0QnStG+UH+7wjbDIm2N/B6bXY2A
         I9OERfWwK2cEORfCfz+WCBraIXCi9avz8jtvVhLWwB7pnY5tr0NmAXQO0aUpYMUYjuFd
         qXwH8dAfT+1G4atROYYUiGS3c7BbzHn5eCQsEH1RgARmHakybfxJqCgnOHjfcFul0TX5
         ytL7zuXSP6g2Jt+DvWMPt6xt9RO5Ll6p9l/s8Jjgqx6CdDV9TD55i76EXEp3KwazP3us
         KZ4w==
X-Gm-Message-State: AOJu0Yz5Jy2me7fxFSWrfMBUHDWQRR8KclJNse2zMZe5iu5PdT7H+tBi
	O0EJ7ejUj8m4wglCwnfXpWwh/wL7LT3R++4/KuASpuMJJLlJlIB0AzS0RvRI
X-Google-Smtp-Source: AGHT+IHj4kCwUd7oaNjaVXT9cpRKgGoHFu6EgauQPR1jwvT7jHMU4dIgJv96PXDxhTjw4pTKsDDzMw==
X-Received: by 2002:a17:906:895:b0:a35:9cf0:56d9 with SMTP id n21-20020a170906089500b00a359cf056d9mr1151554eje.70.1706706531224;
        Wed, 31 Jan 2024 05:08:51 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:50 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <plautrba@redhat.com>,
	James Carter <jwcart2@gmail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2 6/9] libselinux: rework selabel_file(5) database
Date: Wed, 31 Jan 2024 14:08:32 +0100
Message-ID: <20240131130840.48155-7-cgzones@googlemail.com>
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

Currently the database for file backend of selabel stores the file
context specifications in a single long array.  This array is sorted by
special precedence rules, e.g. regular expressions without meta
character first, ordered by length, and the remaining regular
expressions ordered by stem (the prefix part of the regular expressions
without meta characters) length.

This results in suboptimal lookup performance for two reasons;
File context specifications without any meta characters (e.g.
'/etc/passwd') are still matched via an expensive regular expression
match operation.
All such trivial regular expressions are matched against before any non-
trivial regular expression, resulting in thousands of regex match
operations for lookups for paths not matching any of the trivial ones.

Rework the internal representation of the database in two ways:
Convert regular expressions without any meta characters and containing
only supported escaped characters (e.g. '/etc/rc\.d/init\.d') into
literal strings, which get compared via strcmp(3) later on.
Store the specifications in a tree structure to reduce the to number of
specifications that need to be checked.

Since the internal representation is completely rewritten introduce a
new compiled file context file format mirroring the tree structure.
The new format also stores all multi-byte data in network byte-order, so
that such compiled files can be cross-compiled, e.g. for embedded
devices with read-only filesystems (except for the regular expressions,
which are still architecture-dependent, but ignored on architecture mis-
match).

The improved lookup performance will also benefit SELinux aware daemons,
which create files with their default context, e.g. systemd.

Fedora 39 (pre-compiled regular expressions are omitted on Fedora):
    file_contexts.bin:           599034  ->   430211  (bytes)
    file_contexts.homedirs.bin:   21275  ->    13491  (bytes)

Debian Sid (pre-compiled regular expressions are included):
    file_contexts.bin:          7790690  ->  3646256  (bytes)
    file_contexts.homedirs.bin:  835950  ->   708793  (bytes)

(selabel_lookup -b file -k /bin/bash)

Fedora 39 in VM:
    text:      time:       3.1 ms  ->   3.6 ms
               peak heap:   2.33M  ->    1.81M
               peak rss:    6.64M  ->    6.37M
    compiled:  time:       1.8 ms  ->   1.7 ms
               peak heap:   2.14M  ->    1.23M
               peak rss:    6.76M  ->    5.91M

Debian Sid on Raspberry Pi 3:
    text:      time:      33.4 ms  ->  21.2 ms
               peak heap:  10.59M  ->  607.32K
               peak rss:    6.55M  ->    4.46M
    compiled:  time:      38.3 ms  ->  23.5 ms
               peak heap:  13.28M  ->    2.00M
               peak rss:   12.21M  ->    7.60M

(restorecon -vRn /)

Fedora 39 in VM:
      28.3 s  ->   3.6 s
Debian Sid on Raspberry Pi 3:
      94.6 s  ->  12.1 s

(restorecon -vRn -T0 /)

Fedora 39 in VM (8 cores):
      31.1 s  ->   2.5 s
Debian Sid on Raspberry Pi 3 (4 cores):
      58.9 s  ->  12.6 s

(note: I am unsure why the parallel runs on Fedora are slower)

There might be subtle differences in lookup results which evaded my
testing, because some precedence rules are oblique.  For example
`/usr/(.*/)?lib(/.*)?` has to have a higher precedence than
`/usr/(.*/)?bin(/.*)?` to match the current Fedora behavior.  Please
report any behavior changes.

The maximum node depth in the database is set to 3, which seems to give
the best performance to memory usage ratio.  Might be tweaked for
systems with different filesystem hierarchies (Android?).

I am not that familiar with the selabel_partial_match(3),
selabel_get_digests_all_partial_matches(3) and
selabel_hash_all_partial_matches(3) related interfaces, so I only did
some rudimentary tests for them.

CC: Petr Lautrbach <plautrba@redhat.com>
CC: James Carter <jwcart2@gmail.com>
CC: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: misc issues revealed via fuzzing:
  - free root node via data pointer in sefcontext_compile
  - drop reachable assert in regex_simplify()
  - fix crash on unexpected NUL byte in read_spec_entries()
  - more strict checks when loading compiled format
  - do not return <<none>> context for literal specs
  - add missing partial support for literal specs
  - set errno on load_mmap() failure
  - support SELABEL_OPT_SUBSET
  - de-duplicate context strings into a separate array for the binary
    format
  - store an internal file kind instead of the whole mode_t
---
 libselinux/src/label_backends_android.c |    2 +-
 libselinux/src/label_file.c             | 2210 ++++++++++++++++-------
 libselinux/src/label_file.h             |  951 +++++++---
 libselinux/src/label_internal.h         |    6 +-
 libselinux/src/label_support.c          |   26 +-
 libselinux/src/regex.c                  |   55 +-
 libselinux/utils/sefcontext_compile.c   |  658 ++++---
 7 files changed, 2740 insertions(+), 1168 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 33a17236..97d58bb5 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -91,7 +91,7 @@ static int process_line(struct selabel_handle *rec,
 	unsigned int nspec = data->nspec;
 	const char *errbuf = NULL;
 
-	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
+	items = read_spec_entries(line_buf, strlen(line_buf), &errbuf, 2, &prop, &context);
 	if (items < 0) {
 		if (errbuf) {
 			selinux_log(SELINUX_ERROR,
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3b2bda97..096e5dab 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -3,9 +3,11 @@
  *
  * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
  * Author : Stephen Smalley <stephen.smalley.work@gmail.com>
+ * Author : Christian Göttsche <cgzones@googlemail.com>
  */
 
 #include <assert.h>
+#include <endian.h>
 #include <fcntl.h>
 #include <stdarg.h>
 #include <string.h>
@@ -19,149 +21,95 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#include "hashtab.h"
 #include "callbacks.h"
 #include "label_internal.h"
+#include "selinux_internal.h"
 #include "label_file.h"
 
-/* controls the shrink multiple of the hashtab length */
-#define SHRINK_MULTIS 1
-
-struct chkdups_key {
-	char *regex;
-	unsigned int mode;
-};
 
 /*
- * Internals, mostly moved over from matchpathcon.c
+ * Warn about duplicate specifications.
  */
-
-/* return the length of the text that is the stem of a file name */
-static int get_stem_from_file_name(const char *const buf)
+static int nodups_spec_node(const struct spec_node *node, const char *path)
 {
-	const char *tmp = strchr(buf + 1, '/');
+	int rc = 0;
 
-	if (!tmp)
-		return 0;
-	return tmp - buf;
-}
+	if (node->literal_specs_num > 1) {
+		for (uint32_t i = 0; i < node->literal_specs_num - 1; i++) {
+			const struct literal_spec *node1 = &node->literal_specs[i];
+			const struct literal_spec *node2 = &node->literal_specs[i+1];
 
-/* find the stem of a file name, returns the index into stem_arr (or -1 if
- * there is no match - IE for a file in the root directory or a regex that is
- * too complex for us). */
-static int find_stem_from_file(struct saved_data *data, const char *key)
-{
-	int i;
-	int stem_len = get_stem_from_file_name(key);
+			if (strcmp(node1->literal_match, node2->literal_match) != 0)
+				continue;
 
-	if (!stem_len)
-		return -1;
-	for (i = 0; i < data->num_stems; i++) {
-		if (stem_len == data->stem_arr[i].len
-		    && !strncmp(key, data->stem_arr[i].buf, stem_len)) {
-			return i;
+			if (node1->file_kind != LABEL_FILE_KIND_ALL && node2->file_kind != LABEL_FILE_KIND_ALL && node1->file_kind != node2->file_kind)
+				continue;
+
+			rc = -1;
+			errno = EINVAL;
+			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) != 0) {
+				COMPAT_LOG
+					(SELINUX_ERROR,
+						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
+						path,
+						file_kind_to_string(node1->file_kind),
+						node1->literal_match,
+						node1->lr.ctx_raw,
+						node2->lr.ctx_raw);
+			} else {
+				COMPAT_LOG
+					(SELINUX_ERROR,
+						"%s: Multiple same specifications for %s %s.\n",
+						path,
+						file_kind_to_string(node1->file_kind),
+						node1->literal_match);
+			}
 		}
 	}
-	return -1;
-}
 
-/*
- * hash calculation and key comparison of hash table
- */
-ignore_unsigned_overflow_
-static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
-{
-	const struct chkdups_key *k = (const struct chkdups_key *)key;
-	const char *p = NULL;
-	size_t size;
-	unsigned int val = 0;
-
-	size = strlen(k->regex);
-	for (p = k->regex; ((size_t) (p - k->regex)) < size; p++)
-		val =
-			((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
-	return val % h->size;
-}
-
-static int symcmp(hashtab_t h
-		  __attribute__ ((unused)), const_hashtab_key_t key1,
-		  const_hashtab_key_t key2)
-{
-	const struct chkdups_key *a = (const struct chkdups_key *)key1;
-	const struct chkdups_key *b = (const struct chkdups_key *)key2;
+	if (node->regex_specs_num > 1) {
+		for (uint32_t i = 0; i < node->regex_specs_num - 1; i++) {
+			const struct regex_spec *node1 = &node->regex_specs[i];
+			const struct regex_spec *node2 = &node->regex_specs[i+1];
 
-	return strcmp(a->regex, b->regex) || (a->mode && b->mode && a->mode != b->mode);
-}
+			if (node1->prefix_len != node2->prefix_len)
+				continue;
 
-static int destroy_chkdups_key(hashtab_key_t key)
-{
-	free(key);
+			if (strcmp(node1->regex_str, node2->regex_str) != 0)
+				continue;
 
-	return 0;
-}
+			if (node1->file_kind != LABEL_FILE_KIND_ALL && node2->file_kind != LABEL_FILE_KIND_ALL && node1->file_kind != node2->file_kind)
+				continue;
 
-/*
- * Warn about duplicate specifications.
- */
-static int nodups_specs(struct saved_data *data, const char *path)
-{
-	int rc = 0, ret = 0;
-	unsigned int ii;
-	struct spec *curr_spec, *spec_arr = data->spec_arr;
-	struct chkdups_key *new = NULL;
-	unsigned int hashtab_len = (data->nspec / SHRINK_MULTIS) ? data->nspec / SHRINK_MULTIS : 1;
-
-	hashtab_t hash_table = hashtab_create(symhash, symcmp, hashtab_len);
-	if (!hash_table) {
-		rc = -1;
-		COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n", path);
-		return rc;
-	}
-	for (ii = 0; ii < data->nspec; ii++) {
-		new = (struct chkdups_key *)malloc(sizeof(struct chkdups_key));
-		if (!new) {
-			rc = -1;
-			hashtab_destroy_key(hash_table, destroy_chkdups_key);
-			COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create failed.\n", path);
-			return rc;
-		}
-		new->regex = spec_arr[ii].regex_str;
-		new->mode = spec_arr[ii].mode;
-		ret = hashtab_insert(hash_table, (hashtab_key_t)new, &spec_arr[ii]);
-		if (ret == HASHTAB_SUCCESS)
-			continue;
-		if (ret == HASHTAB_PRESENT) {
-			curr_spec =
-				(struct spec *)hashtab_search(hash_table, (hashtab_key_t)new);
 			rc = -1;
 			errno = EINVAL;
-			free(new);
-			if (strcmp(spec_arr[ii].lr.ctx_raw, curr_spec->lr.ctx_raw)) {
+			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) != 0) {
 				COMPAT_LOG
 					(SELINUX_ERROR,
-					 "%s: Multiple different specifications for %s  (%s and %s).\n",
-					 path, curr_spec->regex_str,
-					 spec_arr[ii].lr.ctx_raw,
-					 curr_spec->lr.ctx_raw);
+						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
+						path,
+						file_kind_to_string(node1->file_kind),
+						node1->regex_str,
+						node1->lr.ctx_raw,
+						node2->lr.ctx_raw);
 			} else {
 				COMPAT_LOG
 					(SELINUX_ERROR,
-					 "%s: Multiple same specifications for %s.\n",
-					 path, curr_spec->regex_str);
+						"%s: Multiple same specifications for %s %s.\n",
+						path,
+						file_kind_to_string(node1->file_kind),
+						node1->regex_str);
 			}
 		}
-		if (ret == HASHTAB_OVERFLOW) {
-			rc = -1;
-			free(new);
-			COMPAT_LOG
-				(SELINUX_ERROR,
-				"%s: hashtab happen memory error.\n",
-				path);
-			break;
-		}
 	}
 
-	hashtab_destroy_key(hash_table, destroy_chkdups_key);
+	for (uint32_t i = 0; i < node->children_num; i++) {
+		int rc2;
+
+		rc2 = nodups_spec_node(&node->children[i], path);
+		if (rc2)
+			rc = rc2;
+	}
 
 	return rc;
 }
@@ -171,11 +119,12 @@ static int process_text_file(FILE *fp, const char *prefix,
 {
 	int rc;
 	size_t line_len;
+	ssize_t nread;
 	unsigned int lineno = 0;
 	char *line_buf = NULL;
 
-	while (getline(&line_buf, &line_len, fp) > 0) {
-		rc = process_line(rec, path, prefix, line_buf, ++lineno);
+	while ((nread = getline(&line_buf, &line_len, fp)) > 0) {
+		rc = process_line(rec, path, prefix, line_buf, nread, ++lineno);
 		if (rc)
 			goto out;
 	}
@@ -185,300 +134,796 @@ out:
 	return rc;
 }
 
-static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
-		     const char *path)
+static int merge_mmap_spec_nodes(struct spec_node *restrict dest, struct spec_node *restrict source)
 {
-	struct saved_data *data = (struct saved_data *)rec->data;
-	int rc;
-	char *addr, *str_buf;
-	int *stem_map;
-	struct mmap_area *mmap_area;
-	uint32_t i, magic, version;
-	uint32_t entry_len, stem_map_len, regex_array_len;
-	const char *reg_version;
-	const char *reg_arch;
-	char reg_arch_matches = 0;
+	/* Nodes should have the same stem */
+	assert((dest->stem == NULL && source->stem == NULL) ||
+	       (dest->stem && source->stem && dest->stem_len && source->stem_len && strcmp(dest->stem, source->stem) == 0));
+	/* Source should be loaded from mmap, so we can assume its data is sorted */
+	assert(source->from_mmap);
 
-	mmap_area = malloc(sizeof(*mmap_area));
-	if (!mmap_area) {
-		return -1;
+
+	/*
+	 * Merge literal specs
+	 */
+	if (source->literal_specs_num > 0) {
+		if (dest->literal_specs_num > 0) {
+			struct literal_spec *lspecs;
+			uint32_t lspecs_num;
+
+			if (__builtin_add_overflow(dest->literal_specs_num, source->literal_specs_num, &lspecs_num))
+				return -1;
+
+			lspecs = reallocarray(dest->literal_specs, lspecs_num, sizeof(struct literal_spec));
+			if (!lspecs)
+				return -1;
+
+			memcpy(&lspecs[dest->literal_specs_num], source->literal_specs, source->literal_specs_num * sizeof(struct literal_spec));
+
+			dest->literal_specs = lspecs;
+			dest->literal_specs_num = lspecs_num;
+			dest->literal_specs_alloc = lspecs_num;
+
+			/* Cleanup moved source */
+			for (uint32_t i = 0; i < source->literal_specs_num; i++) {
+				source->literal_specs[i].lr.ctx_raw = NULL;
+				source->literal_specs[i].lr.ctx_trans = NULL;
+			}
+
+		} else {
+			assert(dest->literal_specs == NULL);
+			dest->literal_specs       = source->literal_specs;
+			dest->literal_specs_num   = source->literal_specs_num;
+			dest->literal_specs_alloc = source->literal_specs_alloc;
+			source->literal_specs       = NULL;
+			source->literal_specs_num   = 0;
+			source->literal_specs_alloc = 0;
+		}
 	}
 
-	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
-	if (addr == MAP_FAILED) {
-		free(mmap_area);
-		perror("mmap");
-		return -1;
+
+	/*
+	 * Merge regex specs
+	 */
+	if (source->regex_specs_num > 0) {
+		if (dest->regex_specs_num > 0) {
+			struct regex_spec *rspecs;
+			uint32_t rspecs_num;
+
+			if (__builtin_add_overflow(dest->regex_specs_num, source->regex_specs_num, &rspecs_num))
+					return -1;
+
+			rspecs = reallocarray(dest->regex_specs, rspecs_num, sizeof(struct regex_spec));
+			if (!rspecs)
+				return -1;
+
+			memcpy(&rspecs[dest->regex_specs_num], source->regex_specs, source->regex_specs_num * sizeof(struct regex_spec));
+
+			dest->regex_specs = rspecs;
+			dest->regex_specs_num = rspecs_num;
+			dest->regex_specs_alloc = rspecs_num;
+
+			/* Cleanup moved source */
+			for (uint32_t i = 0; i < source->regex_specs_num; i++) {
+				source->regex_specs[i].lr.ctx_raw = NULL;
+				source->regex_specs[i].lr.ctx_trans = NULL;
+				source->regex_specs[i].regex = NULL;
+				source->regex_specs[i].regex_compiled = false;
+				__pthread_mutex_init(&source->regex_specs[i].regex_lock, NULL);
+			}
+		} else {
+			assert(dest->regex_specs == NULL);
+			dest->regex_specs       = source->regex_specs;
+			dest->regex_specs_num   = source->regex_specs_num;
+			dest->regex_specs_alloc = source->regex_specs_alloc;
+			source->regex_specs       = NULL;
+			source->regex_specs_num   = 0;
+			source->regex_specs_alloc = 0;
+		}
 	}
 
-	/* save where we mmap'd the file to cleanup on close() */
-	mmap_area->addr = mmap_area->next_addr = addr;
-	mmap_area->len = mmap_area->next_len = len;
-	mmap_area->next = data->mmap_areas;
-	data->mmap_areas = mmap_area;
 
-	/* check if this looks like an fcontext file */
-	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
-		return -1;
+	/*
+	 * Merge child nodes
+	 */
+	if (source->children_num > 0) {
+		if (dest->children_num > 0) {
+			struct spec_node *new_children;
+			uint32_t iter_dest, iter_source, new_children_alloc, new_children_num, remaining_dest, remaining_source;
 
-	/* check if this version is higher than we understand */
-	rc = next_entry(&version, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
-		return -1;
+			if (__builtin_add_overflow(dest->children_num, source->children_num, &new_children_alloc))
+				return -1;
 
-	reg_version = regex_version();
-	if (!reg_version)
-		return -1;
+			/* Over-allocate in favor of re-allocating multiple times */
+			new_children = calloc(new_children_alloc, sizeof(struct spec_node));
+			if (!new_children)
+				return -1;
 
-	reg_arch = regex_arch_string();
-	if (!reg_arch)
+			/* Since source is loaded from mmap its child nodes are sorted */
+			qsort(dest->children, dest->children_num, sizeof(struct spec_node), compare_spec_node);
+
+			for (iter_dest = 0, iter_source = 0, new_children_num = 0; iter_dest < dest->children_num && iter_source < source->children_num;) {
+				struct spec_node *child_dest = &dest->children[iter_dest];
+				struct spec_node *child_source = &source->children[iter_source];
+				int r;
+
+				r = strcmp(child_dest->stem, child_source->stem);
+				if (r == 0) {
+					int rc;
+
+					rc = merge_mmap_spec_nodes(child_dest, child_source);
+					if (rc) {
+						free(new_children);
+						return rc;
+					}
+
+					new_children[new_children_num++] = *child_dest;
+					free_spec_node(child_source);
+					iter_dest++;
+					iter_source++;
+				} else if (r < 0) {
+					new_children[new_children_num++] = *child_dest;
+					iter_dest++;
+				} else {
+					new_children[new_children_num++] = *child_source;
+					iter_source++;
+				}
+			}
+
+			remaining_dest = dest->children_num - iter_dest;
+			remaining_source = source->children_num - iter_source;
+			assert(!remaining_dest || !remaining_source);
+			assert(new_children_num + remaining_dest + remaining_source <= new_children_alloc);
+
+			if (remaining_dest > 0) {
+				memcpy(&new_children[new_children_num], &dest->children[iter_dest], remaining_dest * sizeof(struct spec_node));
+				new_children_num += remaining_dest;
+			}
+
+			if (remaining_source > 0) {
+				memcpy(&new_children[new_children_num], &source->children[iter_source], remaining_source * sizeof(struct spec_node));
+				new_children_num += remaining_source;
+			}
+
+			free(dest->children);
+			dest->children       = new_children;
+			dest->children_alloc = new_children_alloc;
+			dest->children_num   = new_children_num;
+
+			free(source->children);
+			source->children       = NULL;
+			source->children_alloc = 0;
+			source->children_num   = 0;
+
+		} else {
+			assert(dest->children == NULL);
+			dest->children       = source->children;
+			dest->children_num   = source->children_num;
+			dest->children_alloc = source->children_alloc;
+			source->children = NULL;
+			source->children_num = 0;
+			source->children_alloc = 0;
+		}
+	}
+
+	return 0;
+}
+
+static inline bool entry_size_check(const struct mmap_area *mmap_area, size_t nmenb, size_t size)
+{
+	size_t required;
+
+	if (__builtin_mul_overflow(nmenb, size, &required))
+		return true;
+
+	return required > mmap_area->next_len;
+}
+
+struct context_array {
+	char **data;
+	uint32_t size;
+};
+
+static void free_context_array(struct context_array *ctx_array)
+{
+	if (!ctx_array->data)
+		return;
+
+	for (uint32_t i = 0; i < ctx_array->size; i++)
+		free(ctx_array->data[i]);
+
+	free(ctx_array->data);
+}
+
+static int load_mmap_ctxarray(struct mmap_area *mmap_area, const char *path, struct context_array *ctx_array, bool validating)
+{
+	uint32_t data_u32, count;
+	uint16_t data_u16, ctx_len;
+	char *ctx;
+	int rc;
+
+	/*
+	 * Read number of context definitions
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
+	count = be32toh(data_u32);
 
-	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
+	if (entry_size_check(mmap_area, count, 3 * sizeof(char)))
+			return -1;
 
-		len = strlen(reg_version);
+	(*ctx_array).data = calloc(count, sizeof(char *));
+	if (!(*ctx_array).data) {
+		(*ctx_array).size = 0;
+		return -1;
+	}
+	(*ctx_array).size = count;
 
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+	for (uint32_t i = 0; i < count; i++) {
+		/*
+		 * Read raw context
+		 * We need to allocate it on the heap since it might get free'd and replaced in a
+		 * SELINUX_CB_VALIDATE callback.
+		 */
+		rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
 		if (rc < 0)
 			return -1;
+		ctx_len = be16toh(data_u16);
 
-		/* Check version lengths */
-		if (len != entry_len)
+		if (ctx_len == 0 || ctx_len == UINT16_MAX)
 			return -1;
 
-		/* Check if regex version mismatch */
-		str_buf = malloc(entry_len + 1);
-		if (!str_buf)
+		if (entry_size_check(mmap_area, ctx_len, sizeof(char)))
 			return -1;
 
-		rc = next_entry(str_buf, mmap_area, entry_len);
+		ctx = malloc(ctx_len + 1);
+		if (!ctx)
+			return -1;
+
+		rc = next_entry(ctx, mmap_area, ctx_len);
 		if (rc < 0) {
-			free(str_buf);
+			free(ctx);
 			return -1;
 		}
+		ctx[ctx_len] = '\0';
+
+		if (validating && strcmp(ctx, "<<none>>") != 0) {
+			if (selinux_validate(&ctx) < 0) {
+				selinux_log(SELINUX_ERROR, "%s: context %s is invalid\n",
+					    path, ctx);
+				free(ctx);
+				return -1;
+			}
+		}
+
+		(*ctx_array).data[i] = ctx;
+	}
+
+	return 0;
+}
+
+static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
+				  struct literal_spec *lspec, const struct context_array *ctx_array)
+{
+	uint32_t data_u32, ctx_id;
+	uint16_t data_u16, regex_len, lmatch_len;
+	uint8_t data_u8;
+	int rc;
+
+	lspec->from_mmap = true;
+
 
-		str_buf[entry_len] = '\0';
-		if ((strcmp(str_buf, reg_version) != 0)) {
-			COMPAT_LOG(SELINUX_ERROR,
-				"Regex version mismatch, expected: %s actual: %s\n",
-				reg_version, str_buf);
-			free(str_buf);
+	/*
+	 * Read raw context id
+	 * We need to allocate it on the heap since it might get free'd and replaced in a
+	 * SELINUX_CB_VALIDATE callback.
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	ctx_id = be32toh(data_u32);
+
+	if (ctx_id == 0 || ctx_id == UINT32_MAX || ctx_id > ctx_array->size)
+		return -1;
+
+	lspec->lr.ctx_raw = strdup(ctx_array->data[ctx_id - 1]);
+	if (!lspec->lr.ctx_raw)
+		return -1;
+
+	if (validating)
+		/* validated in load_mmap_ctxarray() */
+		lspec->lr.validated = true;
+
+
+	/*
+	 * Read original regex
+	 */
+	rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
+	if (rc < 0)
+		return -1;
+	regex_len = be16toh(data_u16);
+
+	if (regex_len <= 1)
+		return -1;
+
+	lspec->regex_str = mmap_area->next_addr;
+	rc = next_entry(NULL, mmap_area, regex_len);
+	if (rc < 0)
+		return -1;
+
+	if (lspec->regex_str[0] == '\0' || lspec->regex_str[regex_len - 1] != '\0')
+		return -1;
+
+
+	/*
+	 * Read literal match
+	 */
+	rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
+	if (rc < 0)
+		return -1;
+	lmatch_len = be16toh(data_u16);
+
+	if (lmatch_len <= 1)
+		return -1;
+
+	lspec->literal_match = mmap_area->next_addr;
+	rc = next_entry(NULL, mmap_area, lmatch_len);
+	if (rc < 0)
+		return -1;
+
+	if (lspec->literal_match[0] == '\0' || lspec->literal_match[lmatch_len - 1] != '\0')
+		return -1;
+
+	lspec->prefix_len = lmatch_len - 1;
+
+	if (lspec->prefix_len > strlen(lspec->regex_str))
+		return -1;
+
+
+	/*
+	 * Read file kind
+	 */
+	rc = next_entry(&data_u8, mmap_area, sizeof(uint8_t));
+	if (rc < 0)
+		return -1;
+	lspec->file_kind = data_u8;
+
+
+	return 0;
+}
+
+static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bool do_load_precompregex,
+				struct regex_spec *rspec, const struct context_array *ctx_array)
+{
+	uint32_t data_u32, ctx_id;
+	uint16_t data_u16, regex_len;
+	uint8_t data_u8;
+	int rc;
+
+	rspec->from_mmap = true;
+
+
+	/*
+	 * Read raw context id
+	 * We need to allocate it on the heap since it might get free'd and replaced in a
+	 * SELINUX_CB_VALIDATE callback.
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	ctx_id = be32toh(data_u32);
+
+	if (ctx_id == 0 || ctx_id == UINT32_MAX || ctx_id > ctx_array->size)
+		return -1;
+
+	rspec->lr.ctx_raw = strdup(ctx_array->data[ctx_id - 1]);
+	if (!rspec->lr.ctx_raw)
+		return -1;
+
+	if (validating)
+		/* validated in load_mmap_ctxarray() */
+		rspec->lr.validated = true;
+
+
+	/*
+	 * Read original regex
+	 */
+	rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
+	if (rc < 0)
+		return -1;
+	regex_len = be16toh(data_u16);
+
+	if (regex_len <= 1)
+		return -1;
+
+	rspec->regex_str = mmap_area->next_addr;
+	rc = next_entry(NULL, mmap_area, regex_len);
+	if (rc < 0)
+		return -1;
+
+	if (rspec->regex_str[0] == '\0' || rspec->regex_str[regex_len - 1] != '\0')
+		return -1;
+
+
+	/*
+	 * Read prefix length
+	 */
+	rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
+	if (rc < 0)
+		return -1;
+	rspec->prefix_len = be16toh(data_u16);
+
+	if (rspec->prefix_len > strlen(rspec->regex_str))
+		return -1;
+
+
+	/*
+	 * Read file kind
+	 */
+	rc = next_entry(&data_u8, mmap_area, sizeof(uint8_t));
+	if (rc < 0)
+		return -1;
+	rspec->file_kind = data_u8;
+
+
+	/*
+	 * Read pcre regex related data
+	 */
+	rc = regex_load_mmap(mmap_area, &rspec->regex, do_load_precompregex,
+			     &rspec->regex_compiled);
+	if (rc < 0)
+		return -1;
+
+	__pthread_mutex_init(&rspec->regex_lock, NULL);
+
+
+	return 0;
+}
+
+static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bool validating, bool do_load_precompregex,
+			       struct spec_node *node, bool is_root, const struct context_array *ctx_array)
+{
+	uint32_t data_u32, lspec_num, rspec_num, children_num;
+	uint16_t data_u16, stem_len;
+	int rc;
+
+	node->from_mmap = true;
+
+
+	/*
+	 * Read stem
+	 */
+	rc = next_entry(&data_u16, mmap_area, sizeof(uint16_t));
+	if (rc < 0)
+		return -1;
+	stem_len = be16toh(data_u16);
+
+	if (stem_len == 0)
+		return -1;
+
+	if ((stem_len == 1) != is_root)
+		return -1;
+
+	node->stem_len = stem_len - 1;
+	node->stem = mmap_area->next_addr;
+	rc = next_entry(NULL, mmap_area, stem_len);
+	if (rc < 0)
+		return -1;
+
+	if (is_root)
+		node->stem = NULL;
+	else if (node->stem[0] == '\0' || node->stem[stem_len - 1] != '\0')
+		return -1;
+
+
+	/*
+	 * Read literal specs
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	lspec_num = be32toh(data_u32);
+
+	if (lspec_num == UINT32_MAX)
+		return -1;
+
+	if (lspec_num > 0) {
+		if (entry_size_check(mmap_area,  lspec_num, 3 * sizeof(uint16_t) + sizeof(uint32_t) + 6 * sizeof(char)))
 			return -1;
+
+		node->literal_specs = calloc(sizeof(struct literal_spec), lspec_num);
+		if (!node->literal_specs)
+			return -1;
+
+		node->literal_specs_num   = lspec_num;
+		node->literal_specs_alloc = lspec_num;
+
+		for (uint32_t i = 0; i < lspec_num; i++) {
+			rc = load_mmap_literal_spec(mmap_area, validating, &node->literal_specs[i], ctx_array);
+			if (rc)
+				return -1;
 		}
-		free(str_buf);
+	}
+
+
+	/*
+	 * Read regex specs
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	rspec_num = be32toh(data_u32);
+
+	if (rspec_num == UINT32_MAX)
+		return -1;
 
-		if (version >= SELINUX_COMPILED_FCONTEXT_REGEX_ARCH) {
-			len = strlen(reg_arch);
+	if (rspec_num > 0) {
+		if (entry_size_check(mmap_area, rspec_num, sizeof(uint32_t) + 3 * sizeof(uint16_t) + 4 * sizeof(char)))
+			return -1;
+
+		node->regex_specs = calloc(sizeof(struct regex_spec), rspec_num);
+		if (!node->regex_specs)
+			return -1;
 
-			rc = next_entry(&entry_len, mmap_area,
-					sizeof(uint32_t));
-			if (rc < 0)
+		node->regex_specs_num   = rspec_num;
+		node->regex_specs_alloc = rspec_num;
+
+		for (uint32_t i = 0; i < rspec_num; i++) {
+			rc = load_mmap_regex_spec(mmap_area, validating, do_load_precompregex, &node->regex_specs[i], ctx_array);
+			if (rc)
 				return -1;
+		}
+	}
 
-			/* Check arch string lengths */
-			if (len != entry_len) {
-				/*
-				 * Skip the entry and conclude that we have
-				 * a mismatch, which is not fatal.
-				 */
-				next_entry(NULL, mmap_area, entry_len);
-				goto end_arch_check;
-			}
 
-			/* Check if arch string mismatch */
-			str_buf = malloc(entry_len + 1);
-			if (!str_buf)
+	/*
+	 * Read child nodes
+	 */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	children_num = be32toh(data_u32);
+
+	if (children_num == UINT32_MAX)
+		return -1;
+
+	if (children_num > 0) {
+		const char *prev_stem = NULL;
+
+		if (entry_size_check(mmap_area, children_num, 3 * sizeof(uint32_t) + sizeof(uint16_t)))
+			return -1;
+
+		node->children = calloc(sizeof(struct spec_node), children_num);
+		if (!node->children)
+			return -1;
+
+		node->children_num   = children_num;
+		node->children_alloc = children_num;
+
+		for (uint32_t i = 0; i < children_num; i++) {
+			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], false, ctx_array);
+			if (rc)
 				return -1;
 
-			rc = next_entry(str_buf, mmap_area, entry_len);
-			if (rc < 0) {
-				free(str_buf);
+			/* Ensure child nodes are sorted and distinct */
+			if (prev_stem && strcmp(prev_stem, node->children[i].stem) >= 0)
 				return -1;
-			}
 
-			str_buf[entry_len] = '\0';
-			reg_arch_matches = strcmp(str_buf, reg_arch) == 0;
-			free(str_buf);
-		}
-	}
-end_arch_check:
+			prev_stem = node->children[i].stem;
+		}
+	}
+
+
+	if (!is_root && lspec_num == 0 && rspec_num == 0 && children_num == 0)
+		return -1;
+
+	return 0;
+}
+
+static int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
+		     const char *path)
+{
+	struct saved_data *data = rec->data;
+	struct spec_node *root = NULL;
+	struct context_array ctx_array = {};
+	int rc;
+	char *addr = NULL, *str_buf = NULL;
+	struct mmap_area *mmap_area = NULL;
+	uint64_t data_u64, num_specs;
+	uint32_t data_u32, pcre_ver_len, pcre_arch_len;
+	const char *reg_arch, *reg_version;
+	bool reg_version_matches = false, reg_arch_matches = false;
+
+	mmap_area = malloc(sizeof(*mmap_area));
+ 	if (!mmap_area)
+ 		goto err;
+
+	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
+	if (addr == MAP_FAILED)
+		goto err;
+
+	rc = madvise(addr, len, MADV_WILLNEED);
+	if (rc == -1)
+		COMPAT_LOG(SELINUX_INFO, "%s:  Failed to advise memory mapping:  %m\n",
+			   path);
+
+	/* save where we mmap'd the file to cleanup on close() */
+	*mmap_area = (struct mmap_area) {
+		.addr      = addr,
+		.next_addr = addr,
+		.next      = NULL,
+		.next_len  = len,
+		.len       = len,
+	};
+
+	/* check if this looks like an fcontext file */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || be32toh(data_u32) != SELINUX_MAGIC_COMPILED_FCONTEXT)
+		goto err;
+
+	/* check if this version is higher than we understand */
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || be32toh(data_u32) != SELINUX_COMPILED_FCONTEXT_TREE_LAYOUT) {
+		COMPAT_LOG(SELINUX_WARNING,
+				"%s:  Unsupported compiled fcontext version %d, supported is version %d\n",
+				path, be32toh(data_u32), SELINUX_COMPILED_FCONTEXT_TREE_LAYOUT);
+		goto err;
+	}
+
+	reg_version = regex_version();
+	if (!reg_version)
+		goto err;
+
+	reg_arch = regex_arch_string();
+	if (!reg_arch)
+		goto err;
 
-	/* allocate the stems_data array */
-	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
 	if (rc < 0)
-		return -1;
+		goto err;
+	pcre_ver_len = be32toh(data_u32);
 
-	/*
-	 * map indexed by the stem # in the mmap file and contains the stem
-	 * number in the data stem_arr
-	 */
-	stem_map = calloc(stem_map_len, sizeof(*stem_map));
-	if (!stem_map)
-		return -1;
+	/* Check version lengths */
+	if (strlen(reg_version) != pcre_ver_len) {
+		/*
+		 * Skip the entry and conclude that we have
+		 * a mismatch, which is not fatal.
+		 */
+		next_entry(NULL, mmap_area, pcre_ver_len);
+		goto end_version_check;
+	}
 
-	for (i = 0; i < stem_map_len; i++) {
-		char *buf;
-		uint32_t stem_len;
-		int newid;
+	if (entry_size_check(mmap_area, pcre_ver_len, sizeof(char)))
+		goto err;
 
-		/* the length does not include the nul */
-		rc = next_entry(&stem_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !stem_len) {
-			rc = -1;
-			goto out;
-		}
+	str_buf = malloc(pcre_ver_len + 1);
+	if (!str_buf)
+		goto err;
 
-		/* Check for stem_len wrap around. */
-		if (stem_len < UINT32_MAX) {
-			buf = (char *)mmap_area->next_addr;
-			/* Check if over-run before null check. */
-			rc = next_entry(NULL, mmap_area, (stem_len + 1));
-			if (rc < 0)
-				goto out;
+	rc = next_entry(str_buf, mmap_area, pcre_ver_len);
+	if (rc < 0)
+		goto err;
 
-			if (buf[stem_len] != '\0') {
-				rc = -1;
-				goto out;
-			}
-		} else {
-			rc = -1;
-			goto out;
-		}
+	str_buf[pcre_ver_len] = '\0';
 
-		/* store the mapping between old and new */
-		newid = find_stem(data, buf, stem_len);
-		if (newid < 0) {
-			newid = store_stem(data, buf, stem_len);
-			if (newid < 0) {
-				rc = newid;
-				goto out;
-			}
-			data->stem_arr[newid].from_mmap = 1;
-		}
-		stem_map[i] = newid;
-	}
+	/* Check for regex version mismatch */
+	if (strcmp(str_buf, reg_version) != 0)
+		COMPAT_LOG(SELINUX_WARNING,
+			"%s:  Regex version mismatch, expected: %s actual: %s\n",
+			path, reg_version, str_buf);
+	else
+		reg_version_matches = true;
 
-	/* allocate the regex array */
-	rc = next_entry(&regex_array_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !regex_array_len) {
-		rc = -1;
-		goto out;
-	}
+	free(str_buf);
+	str_buf = NULL;
 
-	for (i = 0; i < regex_array_len; i++) {
-		struct spec *spec;
-		int32_t stem_id, meta_chars;
-		uint32_t mode = 0, prefix_len = 0;
+end_version_check:
 
-		rc = grow_specs(data);
-		if (rc < 0)
-			goto out;
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		goto err;
+	pcre_arch_len = be32toh(data_u32);
 
-		spec = &data->spec_arr[data->nspec];
-		spec->from_mmap = 1;
+	/* Check arch string lengths */
+	if (strlen(reg_arch) != pcre_arch_len) {
+		/*
+		 * Skip the entry and conclude that we have
+		 * a mismatch, which is not fatal.
+		 */
+		next_entry(NULL, mmap_area, pcre_arch_len);
+		goto end_arch_check;
+	}
 
-		/* Process context */
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto out;
-		}
+	if (entry_size_check(mmap_area, pcre_arch_len, sizeof(char)))
+		goto err;
 
-		str_buf = malloc(entry_len);
-		if (!str_buf) {
-			rc = -1;
-			goto out;
-		}
-		rc = next_entry(str_buf, mmap_area, entry_len);
-		if (rc < 0) {
-			free(str_buf);
-			goto out;
-		}
+	str_buf = malloc(pcre_arch_len + 1);
+	if (!str_buf)
+		goto err;
 
-		if (str_buf[entry_len - 1] != '\0') {
-			free(str_buf);
-			rc = -1;
-			goto out;
-		}
-		spec->lr.ctx_raw = str_buf;
+	rc = next_entry(str_buf, mmap_area, pcre_arch_len);
+	if (rc < 0)
+		goto err;
 
-		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
-			if (selabel_validate(&spec->lr) < 0) {
-				selinux_log(SELINUX_ERROR,
-					    "%s: context %s is invalid\n",
-					    path, spec->lr.ctx_raw);
-				goto out;
-			}
-		}
+	str_buf[pcre_arch_len] = '\0';
 
-		/* Process regex string */
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto out;
-		}
+	/* Check if arch string mismatch */
+	if (strcmp(str_buf, reg_arch) != 0)
+		COMPAT_LOG(SELINUX_WARNING,
+			"%s:  Regex architecture mismatch, expected: %s actual: %s\n",
+			path, reg_arch, str_buf);
+	else
+		reg_arch_matches = true;
 
-		spec->regex_str = (char *)mmap_area->next_addr;
-		rc = next_entry(NULL, mmap_area, entry_len);
-		if (rc < 0)
-			goto out;
+	free(str_buf);
+	str_buf = NULL;
 
-		if (spec->regex_str[entry_len - 1] != '\0') {
-			rc = -1;
-			goto out;
-		}
+end_arch_check:
 
-		/* Process mode */
-		if (version >= SELINUX_COMPILED_FCONTEXT_MODE)
-			rc = next_entry(&mode, mmap_area, sizeof(uint32_t));
-		else
-			rc = next_entry(&mode, mmap_area, sizeof(mode_t));
-		if (rc < 0)
-			goto out;
+	/* Read number of total specifications */
+	rc = next_entry(&data_u64, mmap_area, sizeof(uint64_t));
+	if (rc < 0)
+		goto err;
+	num_specs = be64toh(data_u64);
 
-		spec->mode = mode;
+	rc = load_mmap_ctxarray(mmap_area, path, &ctx_array, rec->validating);
+	if (rc)
+		goto err;
 
-		/* map the stem id from the mmap file to the data->stem_arr */
-		rc = next_entry(&stem_id, mmap_area, sizeof(int32_t));
-		if (rc < 0)
-			goto out;
+	root = calloc(1, sizeof(*root));
+	if (!root)
+		goto err;
 
-		if (stem_id < 0 || stem_id >= (int32_t)stem_map_len)
-			spec->stem_id = -1;
-		else
-			spec->stem_id = stem_map[stem_id];
+	rc = load_mmap_spec_node(mmap_area, path, rec->validating,
+				 reg_version_matches && reg_arch_matches,
+				 root, true,
+				 &ctx_array);
+	if (rc)
+		goto err;
 
-		/* retrieve the hasMetaChars bit */
-		rc = next_entry(&meta_chars, mmap_area, sizeof(uint32_t));
-		if (rc < 0)
-			goto out;
+	/*
+	 * On intermediate failure some data might already have been merged, so always keep the mmap'ed memory.
+	 */
+	mmap_area->next = data->mmap_areas;
+	data->mmap_areas = mmap_area;
+	mmap_area = NULL;
 
-		spec->hasMetaChars = meta_chars;
-		/* and prefix length for use by selabel_lookup_best_match */
-		if (version >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN) {
-			rc = next_entry(&prefix_len, mmap_area,
-					    sizeof(uint32_t));
-			if (rc < 0)
-				goto out;
+	if (data->num_specs == 0) {
+		free_spec_node(data->root);
+		free(data->root);
+		data->root = root;
+		root = NULL;
+	} else {
+		rc = merge_mmap_spec_nodes(data->root, root);
+		if (rc)
+			goto err;
 
-			spec->prefix_len = prefix_len;
-		}
+		free_spec_node(root);
+		free(root);
+		root = NULL;
+	}
 
-		rc = regex_load_mmap(mmap_area, &spec->regex, reg_arch_matches,
-				     &spec->regex_compiled);
-		if (rc < 0)
-			goto out;
+	/* Success */
+	data->num_specs += num_specs;
 
-		__pthread_mutex_init(&spec->regex_lock, NULL);
-		data->nspec++;
-	}
+	free_context_array(&ctx_array);
 
-	rc = 0;
-out:
-	free(stem_map);
+	return 0;
 
-	return rc;
+err:
+	free_context_array(&ctx_array);
+	if (root) {
+		free_spec_node(root);
+		free(root);
+	}
+	free(str_buf);
+	free(mmap_area);
+	if (addr && addr != MAP_FAILED)
+		munmap(addr, len);
+	if (errno == 0)
+		errno = EINVAL;
+	return -1;
 }
 
 struct file_details {
@@ -530,13 +975,26 @@ static int fcontext_is_binary(FILE *fp)
 	if (rc == -1)
 		return -1;
 
-	return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
+	if (!len)
+		return 0;
+
+	if (be32toh(magic) == SELINUX_MAGIC_COMPILED_FCONTEXT)
+		return 1;
+
+	/*
+	 * Treat old format magic in little endian as fcontext file as well,
+	 * to avoid it getting parsed as text file.
+	 */
+	if (le32toh(magic) == SELINUX_MAGIC_COMPILED_FCONTEXT)
+		return 2;
+
+	return 0;
 }
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static FILE *open_file(const char *path, const char *suffix,
-	       char *save_path, size_t len, struct stat *sb, bool open_oldest)
+		       char *save_path, size_t len, struct stat *sb, bool open_oldest)
 {
 	unsigned int i;
 	int rc;
@@ -553,7 +1011,7 @@ static FILE *open_file(const char *path, const char *suffix,
 	};
 
 	rc = snprintf(stack_path, sizeof(stack_path), "%s", path);
-	if (rc >= (int) sizeof(stack_path)) {
+	if (rc < 0 || (size_t)rc >= sizeof(stack_path)) {
 		errno = ENAMETOOLONG;
 		return NULL;
 	}
@@ -606,8 +1064,9 @@ static FILE *open_file(const char *path, const char *suffix,
 }
 
 static int process_file(const char *path, const char *suffix,
-			  struct selabel_handle *rec,
-			  const char *prefix, struct selabel_digest *digest)
+			struct selabel_handle *rec,
+			const char *prefix,
+			struct selabel_digest *digest)
 {
 	int rc;
 	unsigned int i;
@@ -632,14 +1091,19 @@ static int process_file(const char *path, const char *suffix,
 			return -1;
 		}
 
-		rc = rc ?
-				load_mmap(fp, sb.st_size, rec, found_path) :
-				process_text_file(fp, prefix, rec, found_path);
+		if (rc == 2) {
+			COMPAT_LOG(SELINUX_INFO, "%s:  Old compiled fcontext format, skipping\n", found_path);
+		} else if (rc == 1) {
+			rc = load_mmap(fp, sb.st_size, rec, found_path);
+		} else {
+			rc = process_text_file(fp, prefix, rec, found_path);
+		}
+
 		if (!rc)
 			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
 				found_path);
 
-		fclose(fp);
+		(void) fclose(fp);
 
 		if (!rc)
 			return 0;
@@ -660,10 +1124,10 @@ static void selabel_subs_fini(struct selabel_sub *ptr)
 	}
 }
 
-static char *selabel_sub(struct selabel_sub *ptr, const char *src)
+static char *selabel_sub(const struct selabel_sub *ptr, const char *src)
 {
 	char *dst = NULL;
-	int len;
+	unsigned int len;
 
 	while (ptr) {
 		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
@@ -686,7 +1150,7 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 static int selabel_subs_init(const char *path, struct selabel_digest *digest,
-		       struct selabel_sub **out_subs)
+			     struct selabel_sub **out_subs)
 {
 	char buf[1024];
 	FILE *cfg = fopen(path, "re");
@@ -707,6 +1171,7 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *ptr = NULL;
 		char *src = buf;
 		char *dst = NULL;
+		size_t len;
 
 		while (*src && isspace((unsigned char)*src))
 			src++;
@@ -727,6 +1192,12 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! *dst)
 			continue;
 
+		len = strlen(src);
+		if (len >= UINT32_MAX) {
+			errno = EINVAL;
+			goto err;
+		}
+
 		sub = calloc(1, sizeof(*sub));
 		if (! sub)
 			goto err;
@@ -739,7 +1210,7 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! sub->dst)
 			goto err;
 
-		sub->slen = strlen(src);
+		sub->slen = len;
 		sub->next = list;
 		list = sub;
 		sub = NULL;
@@ -769,7 +1240,7 @@ err:
 }
 #endif
 
-static char *selabel_sub_key(struct saved_data *data, const char *key)
+static char *selabel_sub_key(const struct saved_data *data, const char *key)
 {
 	char *ptr = NULL;
 	char *dptr = NULL;
@@ -784,10 +1255,8 @@ static char *selabel_sub_key(struct saved_data *data, const char *key)
 	} else {
 		ptr = selabel_sub(data->dist_subs, key);
 	}
-	if (ptr)
-		return ptr;
 
-	return NULL;
+	return ptr;
 }
 
 static void closef(struct selabel_handle *rec);
@@ -795,7 +1264,7 @@ static void closef(struct selabel_handle *rec);
 static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
-	struct saved_data *data = (struct saved_data *)rec->data;
+	struct saved_data *data = rec->data;
 	const char *path = NULL;
 	const char *prefix = NULL;
 	int status = -1, baseonly = 0;
@@ -850,130 +1319,393 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			goto finish;
 	}
 
-#endif
+#endif
+
+	if (!path) {
+		errno = EINVAL;
+		goto finish;
+	}
+
+	rec->spec_file = strdup(path);
+	if (!rec->spec_file)
+		goto finish;
+
+	/*
+	 * The do detailed validation of the input and fill the spec array
+	 */
+	status = process_file(path, NULL, rec, prefix, rec->digest);
+	if (status)
+		goto finish;
+
+	if (rec->validating) {
+		sort_specs(data);
+
+	 	status = nodups_spec_node(data->root, path);
+	 	if (status)
+	 		goto finish;
+	}
+
+	if (!baseonly) {
+		status = process_file(path, "homedirs", rec, prefix,
+							    rec->digest);
+		if (status && errno != ENOENT)
+			goto finish;
+
+		status = process_file(path, "local", rec, prefix,
+							    rec->digest);
+		if (status && errno != ENOENT)
+			goto finish;
+	}
+
+	if (!rec->validating || !baseonly)
+		sort_specs(data);
+
+	digest_gen_hash(rec->digest);
+
+	status = 0;
+
+finish:
+	if (status)
+		closef(rec);
+
+	return status;
+}
+
+/*
+ * Backend interface routines
+ */
+static void closef(struct selabel_handle *rec)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	struct mmap_area *area, *last_area;
+
+	selabel_subs_fini(data->subs);
+	selabel_subs_fini(data->dist_subs);
+
+	free_spec_node(data->root);
+	free(data->root);
+
+	area = data->mmap_areas;
+	while (area) {
+		munmap(area->addr, area->len);
+		last_area = area;
+		area = area->next;
+		free(last_area);
+	}
+	free(data);
+}
+
+static uint32_t search_literal_spec(const struct literal_spec *array, uint32_t size, const char *key, size_t key_len, bool partial)
+{
+	uint32_t lower, upper;
+
+	if (size == 0)
+		return (uint32_t)-1;
+
+	lower = 0;
+	upper = size - 1;
+
+	while (lower <= upper) {
+		uint32_t m = lower + (upper - lower) / 2;
+		int r;
+
+		if (partial)
+			r = strncmp(array[m].literal_match, key, key_len);
+		else
+			r = strcmp(array[m].literal_match, key);
+
+		if (r == 0) {
+			/* Return the first result, regardless of file kind */
+			while (m > 0) {
+				if (partial)
+					r = strncmp(array[m - 1].literal_match, key, key_len);
+				else
+					r = strcmp(array[m - 1].literal_match, key);
+
+				if (r == 0)
+					m--;
+				else
+				 	break;
+			}
+			return m;
+		}
+
+		if (r < 0)
+			lower = m + 1;
+		else {
+			if (m == 0)
+				break;
+
+			upper = m - 1;
+		}
+	}
+
+	return (uint32_t)-1;
+}
+
+struct lookup_result {
+	const char *regex_str;
+	struct selabel_lookup_rec *lr;
+	uint16_t prefix_len;
+	uint8_t file_kind;
+	bool has_meta_chars;
+	struct lookup_result *next;
+};
+
+static void free_lookup_result(struct lookup_result *result)
+{
+	struct lookup_result *tmp;
+
+	while (result) {
+		tmp = result->next;
+		free(result);
+		result = tmp;
+	}
+}
+
+static struct lookup_result *lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind, bool partial, bool find_all)
+{
+	struct lookup_result *result = NULL;
+	struct lookup_result **next = &result;
+	size_t key_len = strlen(key);
+
+	for (struct spec_node *n = node; n; n = n->parent) {
+
+		uint32_t literal_idx = search_literal_spec(n->literal_specs, n->literal_specs_num, key, key_len, partial);
+		if (literal_idx != (uint32_t)-1) {
+			do {
+				struct literal_spec *lspec = &n->literal_specs[literal_idx];
+
+				if (file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == file_kind) {
+					struct lookup_result *r;
+
+#ifdef __ATOMIC_RELAXED
+					__atomic_store_n(&lspec->any_matches, true, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
+
+					if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0) {
+						free_lookup_result(result);
+						errno = ENOENT;
+						return NULL;
+					}
+
+					r = malloc(sizeof(*r));
+					if (!r) {
+						free_lookup_result(result);
+						return NULL;
+					}
+
+					*r = (struct lookup_result) {
+						.regex_str = lspec->regex_str,
+						.prefix_len = lspec->prefix_len,
+						.file_kind = lspec->file_kind,
+						.lr = &lspec->lr,
+						.has_meta_chars = false,
+						.next = NULL,
+					};
+
+					*next = r;
+					next = &r->next;
+
+					if (!find_all)
+						return result;
+				}
+
+				literal_idx++;
+			} while (literal_idx < n->literal_specs_num &&
+				 (partial ? (strncmp(n->literal_specs[literal_idx].literal_match, key, key_len) == 0)
+					  : (strcmp(n->literal_specs[literal_idx].literal_match, key) == 0)));
+		}
+
+		for (uint32_t i = 0; i < n->regex_specs_num; i++) {
+			struct regex_spec *rspec = &n->regex_specs[i];
+			const char *errbuf = NULL;
+			int rc;
+
+			if (file_kind != LABEL_FILE_KIND_ALL && rspec->file_kind != LABEL_FILE_KIND_ALL && file_kind != rspec->file_kind)
+				continue;
+
+			if (compile_regex(rspec, &errbuf) < 0) {
+				COMPAT_LOG(SELINUX_ERROR, "Failed to compile regular expression '%s':  %s\n",
+					   rspec->regex_str, errbuf);
+				free_lookup_result(result);
+				return NULL;
+			}
+
+			rc = regex_match(rspec->regex, key, partial);
+			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
+				struct lookup_result *r;
+
+				if (rc == REGEX_MATCH) {
+#ifdef __ATOMIC_RELAXED
+					__atomic_store_n(&rspec->any_matches, true, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
+				}
+
+				if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0) {
+					free_lookup_result(result);
+					errno = ENOENT;
+					return NULL;
+				}
+
+				r = malloc(sizeof(*r));
+				if (!r) {
+					free_lookup_result(result);
+					return NULL;
+				}
+
+				*r = (struct lookup_result) {
+					.regex_str = rspec->regex_str,
+					.prefix_len = rspec->prefix_len,
+					.file_kind = rspec->file_kind,
+					.lr = &rspec->lr,
+					.has_meta_chars = true,
+					.next = NULL,
+				};
+
+				*next = r;
+				next = &r->next;
+
+				if (!find_all)
+					return result;
+
+				continue;
+			}
+
+			if (rc == REGEX_NO_MATCH)
+				continue;
+
+			/* else it's an error */
+			free_lookup_result(result);
+			errno = ENOENT;
+			return NULL;
+		}
+	}
 
-	if (!path)
-		goto finish;
+	if (!result)
+		errno = ENOENT;
+	return result;
+}
 
-	rec->spec_file = strdup(path);
+static struct spec_node* search_child_node(struct spec_node *array, uint32_t size, const char *key, size_t key_len)
+{
+	uint32_t lower, upper;
 
-	/*
-	 * The do detailed validation of the input and fill the spec array
-	 */
-	status = process_file(path, NULL, rec, prefix, rec->digest);
-	if (status)
-		goto finish;
+	if (size == 0)
+		return NULL;
 
-	if (rec->validating) {
-		status = nodups_specs(data, path);
-		if (status)
-			goto finish;
-	}
+	lower = 0;
+	upper = size - 1;
 
-	if (!baseonly) {
-		status = process_file(path, "homedirs", rec, prefix,
-							    rec->digest);
-		if (status && errno != ENOENT)
-			goto finish;
+	while (lower <= upper) {
+		uint32_t m = lower + (upper - lower) / 2;
+		int r;
 
-		status = process_file(path, "local", rec, prefix,
-							    rec->digest);
-		if (status && errno != ENOENT)
-			goto finish;
-	}
+		r = strncmp(array[m].stem, key, key_len);
 
-	digest_gen_hash(rec->digest);
+		if (r == 0 && array[m].stem[key_len] == '\0')
+			return &array[m];
 
-	status = sort_specs(data);
+		if (r < 0)
+			lower = m + 1;
+		else {
+			if (m == 0)
+				break;
 
-finish:
-	if (status)
-		closef(rec);
+			upper = m - 1;
+		}
+	}
 
-	return status;
+	return NULL;
 }
 
-/*
- * Backend interface routines
- */
-static void closef(struct selabel_handle *rec)
+static struct spec_node* lookup_find_deepest_node(struct spec_node *node, const char *key)
 {
-	struct saved_data *data = (struct saved_data *)rec->data;
-	struct mmap_area *area, *last_area;
-	struct spec *spec;
-	struct stem *stem;
-	unsigned int i;
+	/* Find the node matching the deepest stem */
 
-	selabel_subs_fini(data->subs);
-	selabel_subs_fini(data->dist_subs);
+	struct spec_node *n = node;
+	const char *p = key;
 
-	for (i = 0; i < data->nspec; i++) {
-		spec = &data->spec_arr[i];
-		free(spec->lr.ctx_trans);
-		free(spec->lr.ctx_raw);
-		regex_data_free(spec->regex);
-		__pthread_mutex_destroy(&spec->regex_lock);
-		if (spec->from_mmap)
-			continue;
-		free(spec->regex_str);
-		free(spec->type_str);
-	}
+	while (true) {
+		struct spec_node *child;
+		size_t length;
+		const char *q;
 
-	for (i = 0; i < (unsigned int)data->num_stems; i++) {
-		stem = &data->stem_arr[i];
-		if (stem->from_mmap)
-			continue;
-		free(stem->buf);
+		if (*p != '/')
+			break;
+
+		q = strchr(p + 1, '/');
+		if (q == NULL)
+			break;
+
+		length = q - p - 1;
+		if (length == 0)
+			break;
+
+		child = search_child_node(n->children, n->children_num, p + 1, length);
+		if (!child)
+			break;
+
+		n = child;
+		p = q;
 	}
 
-	if (data->spec_arr)
-		free(data->spec_arr);
-	if (data->stem_arr)
-		free(data->stem_arr);
+	return n;
+}
 
-	area = data->mmap_areas;
-	while (area) {
-		munmap(area->addr, area->len);
-		last_area = area;
-		area = area->next;
-		free(last_area);
+static uint8_t mode_to_file_kind(int type) {
+	type &= S_IFMT;
+
+	switch (type) {
+	case S_IFBLK:
+		return LABEL_FILE_KIND_BLK;
+	case S_IFCHR:
+		return LABEL_FILE_KIND_CHR;
+	case S_IFDIR:
+		return LABEL_FILE_KIND_DIR;
+	case S_IFIFO:
+		return LABEL_FILE_KIND_FIFO;
+	case S_IFLNK:
+		return LABEL_FILE_KIND_LNK;
+	case S_IFSOCK:
+		return LABEL_FILE_KIND_SOCK;
+	case S_IFREG:
+		return LABEL_FILE_KIND_REG;
+	case 0:
+	default:
+		return LABEL_FILE_KIND_ALL;
 	}
-	free(data);
 }
 
 // Finds all the matches of |key| in the given context. Returns the result in
 // the allocated array and updates the match count. If match_count is NULL,
 // stops early once the 1st match is found.
-static struct spec **lookup_all(struct selabel_handle *rec,
-                                      const char *key,
-                                      int type,
-                                      bool partial,
-                                      size_t *match_count)
+static struct lookup_result *lookup_all(struct selabel_handle *rec,
+					const char *key,
+					int type,
+					bool partial,
+					bool find_all)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec_arr = data->spec_arr;
-	int i, rc, file_stem;
+	struct lookup_result *result = NULL;
+	struct spec_node *node;
 	size_t len;
-	mode_t mode = (mode_t)type;
+	uint8_t file_kind = mode_to_file_kind(type);
 	char *clean_key = NULL;
 	const char *prev_slash, *next_slash;
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
-	struct spec **result = NULL;
-	if (match_count) {
-		*match_count = 0;
-		result = calloc(data->nspec, sizeof(struct spec*));
-	} else {
-		result = calloc(1, sizeof(struct spec*));
-	}
-	if (!result) {
-		selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
-			    data->nspec * sizeof(struct spec*));
+	if (!key) {
+		errno = EINVAL;
 		goto finish;
 	}
 
-	if (!data->nspec) {
+	if (!data->num_specs) {
 		errno = ENOENT;
 		goto finish;
 	}
@@ -1019,84 +1751,26 @@ static struct spec **lookup_all(struct selabel_handle *rec,
 	if (sub)
 		key = sub;
 
-	file_stem = find_stem_from_file(data, key);
-	mode &= S_IFMT;
-
-	/*
-	 * Check for matching specifications in reverse order, so that
-	 * the last matching specification is used.
-	 */
-	for (i = data->nspec - 1; i >= 0; i--) {
-		struct spec *spec = &spec_arr[i];
-		/* if the spec in question matches no stem or has the same
-		 * stem as the file AND if the spec in question has no mode
-		 * specified or if the mode matches the file mode then we do
-		 * a regex check        */
-		bool stem_matches = spec->stem_id == -1 || spec->stem_id == file_stem;
-		// Don't check the stem if we want to find partial matches.
-                // Otherwise the case "/abc/efg/(/.*)?" will be considered
-                //a miss for "/abc".
-		if ((partial || stem_matches) &&
-				(!mode || !spec->mode || mode == spec->mode)) {
-			if (compile_regex(spec, NULL) < 0)
-				goto finish;
-			rc = regex_match(spec->regex, key, partial);
-			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
-				if (rc == REGEX_MATCH) {
-#ifdef __ATOMIC_RELAXED
-					__atomic_store_n(&spec->any_matches,
-							 true, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
-				}
-
-				if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
-					errno = ENOENT;
-					goto finish;
-				}
-
-				if (match_count) {
-					result[*match_count] = spec;
-					*match_count += 1;
-					// Continue to find all the matches.
-					continue;
-				}
-				result[0] = spec;
-				break;
-			}
-
-			if (rc == REGEX_NO_MATCH)
-				continue;
+	node = lookup_find_deepest_node(data->root, key);
 
-			errno = ENOENT;
-			/* else it's an error */
-			goto finish;
-		}
-	}
-	if (!result[0])
-		errno = ENOENT;
+	result = lookup_check_node(node, key, file_kind, partial, find_all);
 
 finish:
 	free(clean_key);
 	free(sub);
-	if (result && !result[0]) {
-		free(result);
-		result = NULL;
-	}
 	return result;
 }
 
-static struct spec *lookup_common(struct selabel_handle *rec,
-                                  const char *key,
-                                  int type,
-                                  bool partial) {
-	struct spec **matches = lookup_all(rec, key, type, partial, NULL);
-	if (!matches) {
+static struct lookup_result *lookup_common(struct selabel_handle *rec,
+					   const char *key,
+					   int type,
+					   bool partial) {
+	struct lookup_result *result = lookup_all(rec, key, type, partial, false);
+	if (!result)
 		return NULL;
-	}
-	struct spec *result = matches[0];
-	free(matches);
+
+	free_lookup_result(result->next);
+	result->next = NULL;
 	return result;
 }
 
@@ -1143,7 +1817,7 @@ static bool get_digests_all_partial_matches(struct selabel_handle *rec,
 	}
 
 	if (status && read_size == SHA1_HASH_SIZE &&
-	    memcmp(read_digest, hash_digest, SHA1_HASH_SIZE) == 0)
+		memcmp(read_digest, hash_digest, SHA1_HASH_SIZE) == 0)
 		return true;
 
 	return false;
@@ -1157,22 +1831,21 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 {
 	assert(digest);
 
-	size_t total_matches;
-	struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
+	struct lookup_result *matches = lookup_all(rec, key, 0, true, true);
 	if (!matches) {
 		return false;
 	}
 
 	Sha1Context context;
 	Sha1Initialise(&context);
-	size_t i;
-	for (i = 0; i < total_matches; i++) {
-		char* regex_str = matches[i]->regex_str;
-		mode_t mode = matches[i]->mode;
-		char* ctx_raw = matches[i]->lr.ctx_raw;
+
+	for (const struct lookup_result *m = matches; m; m = m->next) {
+		const char* regex_str = m->regex_str;
+		uint8_t file_kind = m->file_kind;
+		const char* ctx_raw = m->lr->ctx_raw;
 
 		Sha1Update(&context, regex_str, strlen(regex_str) + 1);
-		Sha1Update(&context, &mode, sizeof(mode_t));
+		Sha1Update(&context, &file_kind, sizeof(file_kind));
 		Sha1Update(&context, ctx_raw, strlen(ctx_raw) + 1);
 	}
 
@@ -1180,24 +1853,32 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 	Sha1Finalise(&context, &sha1_hash);
 	memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
 
-	free(matches);
+	free_lookup_result(matches);
 	return true;
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key, int type)
 {
-	struct spec *spec;
+	struct lookup_result *result;
+	struct selabel_lookup_rec *lookup_result;
 
-	spec = lookup_common(rec, key, type, false);
-	if (spec)
-		return &spec->lr;
-	return NULL;
+	result = lookup_common(rec, key, type, false);
+	if (!result)
+		return NULL;
+
+	lookup_result = result->lr;
+	free_lookup_result(result);
+	return lookup_result;
 }
 
 static bool partial_match(struct selabel_handle *rec, const char *key)
 {
-	return lookup_common(rec, key, 0, true) ? true : false;
+	struct lookup_result *result = lookup_common(rec, key, 0, true);
+	bool ret = result;
+
+	free_lookup_result(result);
+	return ret;
 }
 
 static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
@@ -1205,10 +1886,9 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 						    const char **aliases,
 						    int type)
 {
-	size_t n, i;
-	int best = -1;
-	struct spec **specs;
-	size_t prefix_len = 0;
+	size_t n, i, best = (size_t)-1;
+	struct lookup_result **results;
+	uint16_t prefix_len = 0;
 	struct selabel_lookup_rec *lr = NULL;
 
 	if (!aliases || !aliases[0])
@@ -1217,177 +1897,407 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 	for (n = 0; aliases[n]; n++)
 		;
 
-	specs = calloc(n+1, sizeof(struct spec *));
-	if (!specs)
+	results = calloc(n+1, sizeof(*results));
+	if (!results)
 		return NULL;
-	specs[0] = lookup_common(rec, key, type, false);
-	if (specs[0]) {
-		if (!specs[0]->hasMetaChars) {
+	results[0] = lookup_common(rec, key, type, false);
+	if (results[0]) {
+		if (!results[0]->has_meta_chars) {
 			/* exact match on key */
-			lr = &specs[0]->lr;
+			lr = results[0]->lr;
 			goto out;
 		}
 		best = 0;
-		prefix_len = specs[0]->prefix_len;
+		prefix_len = results[0]->prefix_len;
 	}
 	for (i = 1; i <= n; i++) {
-		specs[i] = lookup_common(rec, aliases[i-1], type, false);
-		if (specs[i]) {
-			if (!specs[i]->hasMetaChars) {
+		results[i] = lookup_common(rec, aliases[i-1], type, false);
+		if (results[i]) {
+			if (!results[i]->has_meta_chars) {
 				/* exact match on alias */
-				lr = &specs[i]->lr;
+				lr = results[i]->lr;
 				goto out;
 			}
-			if (specs[i]->prefix_len > prefix_len) {
+			if (results[i]->prefix_len > prefix_len) {
 				best = i;
-				prefix_len = specs[i]->prefix_len;
+				prefix_len = results[i]->prefix_len;
 			}
 		}
 	}
 
-	if (best >= 0) {
+	if (best != (size_t)-1) {
 		/* longest fixed prefix match on key or alias */
-		lr = &specs[best]->lr;
+		lr = results[best]->lr;
 	} else {
 		errno = ENOENT;
 	}
 
 out:
-	free(specs);
+	for (i = 0; i <= n; i++)
+		free_lookup_result(results[i]);
+	free(results);
 	return lr;
 }
 
-static enum selabel_cmp_result incomp(const struct spec *spec1, const struct spec *spec2, const char *reason, int i, int j)
+static void spec_node_stats(const struct spec_node *node)
+{
+	bool any_matches;
+
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		const struct literal_spec *lspec = &node->literal_specs[i];
+
+#ifdef __ATOMIC_RELAXED
+		any_matches = __atomic_load_n(&node->literal_specs[i].any_matches, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
+
+		if (!any_matches) {
+			COMPAT_LOG(SELINUX_WARNING,
+				"Warning!  No matches for (%s, %s, %s)\n",
+				lspec->regex_str,
+				file_kind_to_string(lspec->file_kind),
+				lspec->lr.ctx_raw);
+		}
+	}
+
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		const struct regex_spec *rspec = &node->regex_specs[i];
+
+#ifdef __ATOMIC_RELAXED
+		any_matches = __atomic_load_n(&rspec->any_matches, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
+
+		if (!any_matches) {
+			COMPAT_LOG(SELINUX_WARNING,
+				"Warning!  No matches for (%s, %s, %s)\n",
+				rspec->regex_str,
+				file_kind_to_string(rspec->file_kind),
+				rspec->lr.ctx_raw);
+		}
+	}
+
+	for (uint32_t i = 0; i < node->children_num; i++)
+		spec_node_stats(&node->children[i]);
+}
+
+static void stats(struct selabel_handle *rec)
+{
+	const struct saved_data *data = (const struct saved_data *)rec->data;
+
+	spec_node_stats(data->root);
+}
+
+static inline const char* fmt_stem(const char *stem)
+{
+	return stem ?: "(root)";
+}
+
+static enum selabel_cmp_result lspec_incomp(const char *stem, const struct literal_spec *lspec1, const struct literal_spec *lspec2, const char *reason, uint32_t iter1, uint32_t iter2)
 {
 	selinux_log(SELINUX_INFO,
-		    "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s) vs entry %d: (%s, %x, %s)\n",
-		    reason,
-		    i, spec1->regex_str, spec1->mode, spec1->lr.ctx_raw,
-		    j, spec2->regex_str, spec2->mode, spec2->lr.ctx_raw);
-	return SELABEL_INCOMPARABLE;
+ 		    "selabel_cmp: mismatched %s in stem %s on literal entry %u: (%s, %s, %s) vs entry %u: (%s, %s, %s)\n",
+ 		    reason,
+		    fmt_stem(stem),
+ 		    iter1, lspec1->regex_str, file_kind_to_string(lspec1->file_kind), lspec1->lr.ctx_raw,
+ 		    iter2, lspec2->regex_str, file_kind_to_string(lspec2->file_kind), lspec2->lr.ctx_raw);
+ 	return SELABEL_INCOMPARABLE;
 }
 
-static enum selabel_cmp_result cmp(const struct selabel_handle *h1,
-				   const struct selabel_handle *h2)
+static enum selabel_cmp_result rspec_incomp(const char *stem, const struct regex_spec *rspec1, const struct regex_spec *rspec2, const char *reason, uint32_t iter1, uint32_t iter2)
 {
-	const struct saved_data *data1 = (const struct saved_data *)h1->data;
-	const struct saved_data *data2 = (const struct saved_data *)h2->data;
-	unsigned int i, nspec1 = data1->nspec, j, nspec2 = data2->nspec;
-	const struct spec *spec_arr1 = data1->spec_arr, *spec_arr2 = data2->spec_arr;
-	const struct stem *stem_arr1 = data1->stem_arr, *stem_arr2 = data2->stem_arr;
-	bool skipped1 = false, skipped2 = false;
-
-	i = 0;
-	j = 0;
-	while (i < nspec1 && j < nspec2) {
-		const struct spec *spec1 = &spec_arr1[i];
-		const struct spec *spec2 = &spec_arr2[j];
+	selinux_log(SELINUX_INFO,
+ 		    "selabel_cmp: mismatched %s in stem %s on regex entry %u: (%s, %s, %s) vs entry %u: (%s, %s, %s)\n",
+ 		    reason,
+		    fmt_stem(stem),
+ 		    iter1, rspec1->regex_str, file_kind_to_string(rspec1->file_kind), rspec1->lr.ctx_raw,
+ 		    iter2, rspec2->regex_str, file_kind_to_string(rspec2->file_kind), rspec2->lr.ctx_raw);
+ 	return SELABEL_INCOMPARABLE;
+}
 
-		/*
-		 * Because sort_specs() moves exact pathnames to the
-		 * end, we might need to skip over additional regex
-		 * entries that only exist in one of the configurations.
-		 */
-		if (!spec1->hasMetaChars && spec2->hasMetaChars) {
-			j++;
-			skipped2 = true;
-			continue;
-		}
+static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, const struct spec_node *node2)
+{
+	enum selabel_cmp_result result = SELABEL_EQUAL;
 
-		if (spec1->hasMetaChars && !spec2->hasMetaChars) {
-			i++;
-			skipped1 = true;
-			continue;
-		}
+	if ((node1->stem && node2->stem && strcmp(node1->stem, node2->stem) != 0) ||
+	    (node1->stem && node1->stem[0] != '\0' && !node2->stem) ||
+		(!node1->stem && node2->stem && node2->stem[0] != '\0')) {
+		selinux_log(SELINUX_INFO, "selabel_cmp: incompareable nodes: %s vs %s\n",
+					fmt_stem(node1->stem), fmt_stem(node2->stem));
+		return SELABEL_INCOMPARABLE;
+	}
+
+	/* Literal specs comparison */
+	{
+		uint32_t iter1 = 0, iter2 = 0;
+		while (iter1 < node1->literal_specs_num && iter2 < node2->literal_specs_num) {
+			const struct literal_spec *lspec1 = &node1->literal_specs[iter1];
+			const struct literal_spec *lspec2 = &node2->literal_specs[iter2];
+			int cmp;
+
+			cmp = strcmp(lspec1->literal_match, lspec2->literal_match);
+			if (cmp < 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					iter1++;
+					continue;
+				}
 
-		if (spec1->regex && spec2->regex) {
-			if (regex_cmp(spec1->regex, spec2->regex) == SELABEL_INCOMPARABLE){
-				return incomp(spec1, spec2, "regex", i, j);
+				return lspec_incomp(node1->stem, lspec1, lspec2, "literal_str", iter1, iter2);
 			}
-		} else {
-			if (strcmp(spec1->regex_str, spec2->regex_str))
-				return incomp(spec1, spec2, "regex_str", i, j);
-		}
 
-		if (spec1->mode != spec2->mode)
-			return incomp(spec1, spec2, "mode", i, j);
-
-		if (spec1->stem_id == -1 && spec2->stem_id != -1)
-			return incomp(spec1, spec2, "stem_id", i, j);
-		if (spec2->stem_id == -1 && spec1->stem_id != -1)
-			return incomp(spec1, spec2, "stem_id", i, j);
-		if (spec1->stem_id != -1 && spec2->stem_id != -1) {
-			const struct stem *stem1 = &stem_arr1[spec1->stem_id];
-			const struct stem *stem2 = &stem_arr2[spec2->stem_id];
-			if (stem1->len != stem2->len ||
-			    strncmp(stem1->buf, stem2->buf, stem1->len))
-				return incomp(spec1, spec2, "stem", i, j);
+			if (cmp > 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+					result = SELABEL_SUBSET;
+					iter2++;
+					continue;
+				}
+
+				return lspec_incomp(node1->stem, lspec1, lspec2, "literal_str", iter1, iter2);
+			}
+
+			/* If literal match is equal compare file kind */
+
+			if (lspec1->file_kind > lspec2->file_kind) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					iter1++;
+					continue;
+				}
+
+				return lspec_incomp(node1->stem, lspec1, lspec2, "file_kind", iter1, iter2);
+			}
+
+			if (lspec1->file_kind < lspec2->file_kind) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+					result = SELABEL_SUBSET;
+					iter2++;
+					continue;
+				}
+
+				return lspec_incomp(node1->stem, lspec1, lspec2, "file_kind", iter1, iter2);
+			}
+
+			iter1++;
+			iter2++;
+		}
+		if (iter1 != node1->literal_specs_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+				result = SELABEL_SUPERSET;
+			} else {
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch literal left remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+		}
+		if (iter2 != node2->literal_specs_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+				result = SELABEL_SUBSET;
+			} else {
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch literal right remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
 		}
+	}
+
+	/* Regex specs comparison */
+	{
+		uint32_t iter1 = 0, iter2 = 0;
+		while (iter1 < node1->regex_specs_num && iter2 < node2->regex_specs_num) {
+			const struct regex_spec *rspec1 = &node1->regex_specs[iter1];
+			const struct regex_spec *rspec2 = &node2->regex_specs[iter2];
+			int cmp;
+
+			cmp = strcmp(rspec1->regex_str, rspec2->regex_str);
+			if (cmp < 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					iter1++;
+					continue;
+				}
+
+				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1, iter2);
+			}
+
+			if (cmp > 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+					result = SELABEL_SUBSET;
+					iter2++;
+					continue;
+				}
+
+				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1, iter2);
+			}
+
+			/* If literal match is equal compare file kind */
+
+			if (rspec1->file_kind > rspec2->file_kind) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					iter1++;
+					continue;
+				}
+
+				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1, iter2);
+			}
+
+			if (rspec1->file_kind < rspec2->file_kind) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+					result = SELABEL_SUBSET;
+					iter2++;
+					continue;
+				}
 
-		if (strcmp(spec1->lr.ctx_raw, spec2->lr.ctx_raw))
-			return incomp(spec1, spec2, "ctx_raw", i, j);
+				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1, iter2);
+			}
 
-		i++;
-		j++;
+			iter1++;
+			iter2++;
+		}
+		if (iter1 != node1->regex_specs_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+				result = SELABEL_SUPERSET;
+			} else {
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str left remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+		}
+		if (iter2 != node2->regex_specs_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+				result = SELABEL_SUBSET;
+			} else {
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str right remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+		}
 	}
 
-	if ((skipped1 || i < nspec1) && !skipped2)
-		return SELABEL_SUPERSET;
-	if ((skipped2 || j < nspec2) && !skipped1)
-		return SELABEL_SUBSET;
-	if (skipped1 && skipped2)
-		return SELABEL_INCOMPARABLE;
-	return SELABEL_EQUAL;
-}
+	/* Child nodes comparison */
+	{
+		uint32_t iter1 = 0, iter2 = 0;
+		while (iter1 < node1->children_num && iter2 < node2->children_num) {
+			const struct spec_node *child1 = &node1->children[iter1];
+			const struct spec_node *child2 = &node2->children[iter2];
+			enum selabel_cmp_result child_result;
+			int cmp;
+
+			cmp = strcmp(child1->stem, child2->stem);
+			if (cmp < 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					iter1++;
+					continue;
+				}
 
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch left remnant child node %s stem %s\n", child1->stem, fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
 
-static void stats(struct selabel_handle *rec)
-{
-	struct saved_data *data = (struct saved_data *)rec->data;
-	unsigned int i, nspec = data->nspec;
-	struct spec *spec_arr = data->spec_arr;
-	bool any_matches;
+			if (cmp > 0) {
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+						result = SELABEL_SUBSET;
+						iter2++;
+						continue;
+				}
 
-	for (i = 0; i < nspec; i++) {
-#ifdef __ATOMIC_RELAXED
-		any_matches = __atomic_load_n(&spec_arr[i].any_matches, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
-		if (!any_matches) {
-			if (spec_arr[i].type_str) {
-				COMPAT_LOG(SELINUX_WARNING,
-				    "Warning!  No matches for (%s, %s, %s)\n",
-				    spec_arr[i].regex_str,
-				    spec_arr[i].type_str,
-				    spec_arr[i].lr.ctx_raw);
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch right remnant child node %s stem %s\n", child1->stem, fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+
+			iter1++;
+			iter2++;
+
+			/* If stem is equal do a deep comparison */
+
+			child_result = spec_node_cmp(child1, child2);
+			switch (child_result) {
+			case SELABEL_SUBSET:
+				if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+					result = SELABEL_SUBSET;
+					continue;
+				}
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch child node %s stem %s\n", child1->stem, fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			case SELABEL_EQUAL:
+				continue;
+			case SELABEL_SUPERSET:
+				if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+					result = SELABEL_SUPERSET;
+					continue;
+				}
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch child node %s stem %s\n", child1->stem, fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			case SELABEL_INCOMPARABLE:
+			default:
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch child node %s stem %s\n", child1->stem, fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+		}
+		if (iter1 != node1->children_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUPERSET) {
+				result = SELABEL_SUPERSET;
+			} else {
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch child left remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
+			}
+		}
+		if (iter2 != node2->children_num) {
+			if (result == SELABEL_EQUAL || result == SELABEL_SUBSET) {
+				result = SELABEL_SUBSET;
 			} else {
-				COMPAT_LOG(SELINUX_WARNING,
-				    "Warning!  No matches for (%s, %s)\n",
-				    spec_arr[i].regex_str,
-				    spec_arr[i].lr.ctx_raw);
+				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch child right remnant in stem %s\n", fmt_stem(node1->stem));
+				return SELABEL_INCOMPARABLE;
 			}
 		}
 	}
+
+	return result;
+}
+
+static enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2)
+{
+	const struct saved_data *data1, *data2;
+
+	/* Ensured by selabel_cmp() */
+	assert(h1->backend == SELABEL_CTX_FILE && h2->backend == SELABEL_CTX_FILE);
+
+	data1 = h1->data;
+	data2 = h2->data;
+
+	if (data1->num_specs == 0)
+		return data2->num_specs == 0 ? SELABEL_EQUAL : SELABEL_SUBSET;
+	if (data2->num_specs == 0)
+		return SELABEL_SUPERSET;
+
+	return spec_node_cmp(data1->root, data2->root);
 }
 
 int selabel_file_init(struct selabel_handle *rec,
-				    const struct selinux_opt *opts,
-				    unsigned nopts)
+		      const struct selinux_opt *opts,
+		      unsigned nopts)
 {
 	struct saved_data *data;
+	struct spec_node *root;
 
-	data = (struct saved_data *)calloc(1, sizeof(*data));
+	data = calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
 
+	root = calloc(1, sizeof(*root));
+	if (!root) {
+		free(data);
+		return -1;
+	}
+
+	data->root = root;
+
 	rec->data = data;
 	rec->func_close = &closef;
 	rec->func_stats = &stats;
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
-	rec->func_get_digests_all_partial_matches =
-					&get_digests_all_partial_matches;
+	rec->func_get_digests_all_partial_matches = &get_digests_all_partial_matches;
 	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
 	rec->func_lookup_best_match = &lookup_best_match;
 	rec->func_cmp = &cmp;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index c91a6c18..2dc772eb 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -1,8 +1,12 @@
 #ifndef _SELABEL_FILE_H_
 #define _SELABEL_FILE_H_
 
+#include <assert.h>
+#include <ctype.h>
 #include <errno.h>
 #include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
 #include <string.h>
 
 #include <sys/stat.h>
@@ -28,46 +32,100 @@
 #define SELINUX_COMPILED_FCONTEXT_MODE		3
 #define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN	4
 #define SELINUX_COMPILED_FCONTEXT_REGEX_ARCH	5
+#define SELINUX_COMPILED_FCONTEXT_TREE_LAYOUT	6
 
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
-	SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
+	SELINUX_COMPILED_FCONTEXT_TREE_LAYOUT
 
 /* Required selinux_restorecon and selabel_get_digests_all_partial_matches() */
 #define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
 
+#define LABEL_FILE_KIND_INVALID		255
+#define LABEL_FILE_KIND_ALL		0
+#define LABEL_FILE_KIND_DIR		1
+#define LABEL_FILE_KIND_CHR		2
+#define LABEL_FILE_KIND_BLK		3
+#define LABEL_FILE_KIND_SOCK		4
+#define LABEL_FILE_KIND_FIFO		5
+#define LABEL_FILE_KIND_LNK		6
+#define LABEL_FILE_KIND_REG		7
+
 struct selabel_sub {
 	char *src;
-	int slen;
+	unsigned int slen;
 	char *dst;
 	struct selabel_sub *next;
 };
 
-/* A file security context specification. */
-struct spec {
-	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
-	char *regex_str;	/* regular expression string for diagnostics */
-	char *type_str;		/* type string for diagnostic messages */
-	struct regex_data * regex; /* backend dependent regular expression data */
-	bool regex_compiled; /* bool to indicate if the regex is compiled */
-	pthread_mutex_t regex_lock; /* lock for lazy compilation of regex */
-	mode_t mode;		/* mode format value */
-	bool any_matches;	/* did any pathname match? */
-	int stem_id;		/* indicates which stem-compression item */
-	char hasMetaChars;	/* regular expression has meta-chars */
-	char from_mmap;		/* this spec is from an mmap of the data */
-	size_t prefix_len;      /* length of fixed path prefix */
+/* A regular expression file security context specification */
+struct regex_spec {
+	struct selabel_lookup_rec lr;		/* contexts for lookup result */
+	char *regex_str;			/* original regular expression string for diagnostics */
+	struct regex_data *regex;		/* backend dependent regular expression data */
+	pthread_mutex_t regex_lock;		/* lock for lazy compilation of regex */
+	uint16_t prefix_len;			/* length of fixed path prefix */
+	uint8_t file_kind;			/* file type */
+	bool regex_compiled;			/* whether the regex is compiled */
+	bool any_matches;			/* whether any pathname match */
+	bool from_mmap;				/* whether this spec is from an mmap of the data */
+};
+
+/* A literal file security context specification */
+struct literal_spec {
+	struct selabel_lookup_rec lr;		/* contexts for lookup result */
+	char *regex_str;			/* original regular expression string for diagnostics */
+	char *literal_match;			/* simplified string from regular expression */
+	uint16_t prefix_len;			/* length of fixed path prefix, i.e. length of the literal match */
+	uint8_t file_kind;			/* file type */
+	bool any_matches;			/* whether any pathname match */
+	bool from_mmap;				/* whether this spec is from an mmap of the data */
 };
 
-/* A regular expression stem */
-struct stem {
-	char *buf;
-	int len;
-	char from_mmap;
+/*
+ * Max depth of specification nodes
+ *
+ * Measure before changing:
+ *   - 2  leads to slower lookup
+ *   - >4 require more memory (and allocations) for no performance gain
+ */
+#define SPEC_NODE_MAX_DEPTH 3
+
+/* A specification node */
+struct spec_node {
+	/* stem of the node, or NULL for root node */
+	char *stem;
+
+	/* parent node */
+	struct spec_node *parent;
+
+	/*
+	 * Array of literal specifications (ordered alphabetically)
+	 */
+	struct literal_spec *literal_specs;
+	uint32_t literal_specs_num, literal_specs_alloc;
+
+	/*
+	 * Array of regular expression specifications (ordered from most to least specific)
+	 */
+	struct regex_spec *regex_specs;
+	uint32_t regex_specs_num, regex_specs_alloc;
+
+	/*
+	 * Array of child nodes (ordered alphabetically)
+	 */
+	struct spec_node *children;
+	uint32_t children_num, children_alloc;
+
+	/* length of the stem (reordered to minimize padding) */
+	uint16_t stem_len;
+
+	/* whether this node is from an mmap of the data */
+	bool from_mmap;
 };
 
 /* Where we map the file in during selabel_open() */
 struct mmap_area {
-	void *addr;	/* Start addr + len used to release memory at close */
+	void *addr;		/* Start addr + len used to release memory at close */
 	size_t len;
 	void *next_addr;	/* Incremented by next_entry() */
 	size_t next_len;	/* Decremented by next_entry() */
@@ -76,20 +134,12 @@ struct mmap_area {
 
 /* Our stored configuration */
 struct saved_data {
-	/*
-	 * The array of specifications, initially in the same order as in
-	 * the specification file. Sorting occurs based on hasMetaChars.
-	 */
-	struct spec *spec_arr;
-	unsigned int nspec;
-	unsigned int alloc_specs;
+	/* Root specification node */
+	struct spec_node *root;
+
+	/* Number of file specifications */
+	uint64_t num_specs;
 
-	/*
-	 * The array of regular expression stems.
-	 */
-	struct stem *stem_arr;
-	int num_stems;
-	int alloc_stems;
 	struct mmap_area *mmap_areas;
 
 	/* substitution support */
@@ -97,73 +147,126 @@ struct saved_data {
 	struct selabel_sub *subs;
 };
 
-static inline mode_t string_to_mode(const char *mode)
+static inline mode_t string_to_file_kind(const char *mode)
 {
 	if (mode[0] != '-' || mode[1] == '\0' || mode[2] != '\0')
-		return (mode_t)-1;
+		return LABEL_FILE_KIND_INVALID;
 	switch (mode[1]) {
 	case 'b':
-		return S_IFBLK;
+		return LABEL_FILE_KIND_BLK;
 	case 'c':
-		return S_IFCHR;
+		return LABEL_FILE_KIND_CHR;
 	case 'd':
-		return S_IFDIR;
+		return LABEL_FILE_KIND_DIR;
 	case 'p':
-		return S_IFIFO;
+		return LABEL_FILE_KIND_FIFO;
 	case 'l':
-		return S_IFLNK;
+		return LABEL_FILE_KIND_LNK;
 	case 's':
-		return S_IFSOCK;
+		return LABEL_FILE_KIND_SOCK;
 	case '-':
-		return S_IFREG;
+		return LABEL_FILE_KIND_REG;
 	default:
-		return (mode_t)-1;
+		return LABEL_FILE_KIND_INVALID;
 	}
 }
 
-static inline int grow_specs(struct saved_data *data)
+static inline const char* file_kind_to_string(uint8_t file_kind)
 {
-	struct spec *specs;
-	size_t new_specs, total_specs;
-
-	if (data->nspec < data->alloc_specs)
-		return 0;
+	switch (file_kind) {
+	case LABEL_FILE_KIND_BLK:
+		return "block-device";
+	case LABEL_FILE_KIND_CHR:
+		return "character-device";
+	case LABEL_FILE_KIND_DIR:
+		return "directory";
+	case LABEL_FILE_KIND_FIFO:
+		return "fifo-file";
+	case LABEL_FILE_KIND_LNK:
+		return "symlink";
+	case LABEL_FILE_KIND_SOCK:
+		return "sock-file";
+	case LABEL_FILE_KIND_REG:
+		return "regular-file";
+	case LABEL_FILE_KIND_ALL:
+		return "wildcard";
+	default:
+		return "(invalid)";
+	}
+}
 
-	new_specs = data->nspec + 16;
-	total_specs = data->nspec + new_specs;
+/*
+ * Determine whether the regular expression specification has any meta characters
+ * or any unsupported escape sequence.
+ */
+static bool regex_has_meta_chars(const char *regex, size_t *prefix_len, const char *path, unsigned int lineno)
+{
+	const char *p = regex;
+	size_t plen = 0;
 
-	specs = realloc(data->spec_arr, total_specs * sizeof(*specs));
-	if (!specs) {
-		perror("realloc");
-		return -1;
+	for (;*p != '\0'; p++, plen++) {
+		switch(*p) {
+		case '.':
+		case '^':
+		case '$':
+		case '?':
+		case '*':
+		case '+':
+		case '|':
+		case '[':
+		case '(':
+		case '{':
+		case ']':
+		case ')':
+		case '}':
+			*prefix_len = plen;
+			return true;
+		case '\\':
+			p++;
+			switch (*p) {
+			/* curated list of supported characters */
+			case '.':
+			case '^':
+			case '$':
+			case '?':
+			case '*':
+			case '+':
+			case '|':
+			case '[':
+			case '(':
+			case '{':
+			case ']':
+			case ')':
+			case '}':
+			case '-':
+			case '_':
+			case ',':
+				continue;
+			default:
+				COMPAT_LOG(SELINUX_INFO, "%s:  line %u has unsupported escaped character %c (%#x) for literal matching, continuing using regex\n",
+					   path, lineno, isprint((unsigned char)*p) ? *p : '?', *p);
+				*prefix_len = plen;
+				return true;
+			}
+		}
 	}
 
-	/* blank the new entries */
-	memset(&specs[data->nspec], 0, new_specs * sizeof(*specs));
-
-	data->spec_arr = specs;
-	data->alloc_specs = total_specs;
-	return 0;
+	*prefix_len = plen;
+	return false;
 }
 
-/* Determine if the regular expression specification has any meta characters. */
-static inline void spec_hasMetaChars(struct spec *spec)
+static int regex_simplify(const char *regex, size_t len, char **out, const char *path, unsigned int lineno)
 {
-	char *c;
-	int len;
-	char *end;
-
-	c = spec->regex_str;
-	len = strlen(spec->regex_str);
-	end = c + len;
+	char *result, *p;
+	size_t i = 0;
 
-	spec->hasMetaChars = 0;
-	spec->prefix_len = len;
+	result = malloc(len + 1);
+	if (!result)
+		return -1;
 
-	/* Look at each character in the RE specification string for a
-	 * meta character. Return when any meta character reached. */
-	while (c < end) {
-		switch (*c) {
+	p = result;
+	while (i < len) {
+		switch(regex[i]) {
 		case '.':
 		case '^':
 		case '$':
@@ -174,172 +277,149 @@ static inline void spec_hasMetaChars(struct spec *spec)
 		case '[':
 		case '(':
 		case '{':
-			spec->hasMetaChars = 1;
-			spec->prefix_len = c - spec->regex_str;
-			return;
-		case '\\':	/* skip the next character */
-			c++;
+		case ']':
+		case ')':
+		case '}':
+			free(result);
+			return 0;
+		case '\\':
+			i++;
+			if (i >= len) {
+				COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has unsupported final escape character\n",
+					   path, lineno);
+				free(result);
+				return 0;
+			}
+			switch (regex[i]) {
+			/* curated list of supported characters */
+			case '.':
+			case '^':
+			case '$':
+			case '?':
+			case '*':
+			case '+':
+			case '|':
+			case '[':
+			case '(':
+			case '{':
+			case ']':
+			case ')':
+			case '}':
+			case '-':
+			case '_':
+			case ',':
+				*p++ = regex[i++];
+				break;
+			default:
+				/* regex_has_meta_chars() reported already the notable occurrences */
+				free(result);
+				return 0;
+			}
 			break;
 		default:
-			break;
-
+			*p++ = regex[i++];
 		}
-		c++;
 	}
+
+	*p = '\0';
+	*out = result;
+	return 1;
 }
 
-/* Move exact pathname specifications to the end. */
-static inline int sort_specs(struct saved_data *data)
+static inline int compare_literal_spec(const void *p1, const void *p2)
 {
-	struct spec *spec_copy;
-	struct spec spec;
-	unsigned int i;
-	int front, back;
-	size_t len = sizeof(*spec_copy);
-
-	spec_copy = malloc(len * data->nspec);
-	if (!spec_copy)
-		return -1;
-
-	/* first move the exact pathnames to the back */
-	front = 0;
-	back = data->nspec - 1;
-	for (i = 0; i < data->nspec; i++) {
-		if (data->spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[front++], &data->spec_arr[i], len);
-		else
-			memcpy(&spec_copy[back--], &data->spec_arr[i], len);
-	}
-
-	/*
-	 * now the exact pathnames are at the end, but they are in the reverse
-	 * order. Since 'front' is now the first of the 'exact' we can run
-	 * that part of the array switching the front and back element.
-	 */
-	back = data->nspec - 1;
-	while (front < back) {
-		/* save the front */
-		memcpy(&spec, &spec_copy[front], len);
-		/* move the back to the front */
-		memcpy(&spec_copy[front], &spec_copy[back], len);
-		/* put the old front in the back */
-		memcpy(&spec_copy[back], &spec, len);
-		front++;
-		back--;
-	}
+	const struct literal_spec *l1 = p1;
+	const struct literal_spec *l2 = p2;
+	int ret;
 
-	free(data->spec_arr);
-	data->spec_arr = spec_copy;
+	ret = strcmp(l1->literal_match, l2->literal_match);
+	if (ret)
+		return ret;
 
-	return 0;
+	/* Order wildcard mode (0) last */
+	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind);
 }
 
-/* Return the length of the text that can be considered the stem, returns 0
- * if there is no identifiable stem */
-static inline int get_stem_from_spec(const char *const buf)
+static inline int compare_regex_spec(const void *p1, const void *p2)
 {
-	const char *tmp = strchr(buf + 1, '/');
-	const char *ind;
+	const struct regex_spec *r1 = p1;
+	const struct regex_spec *r2 = p2;
+	size_t regex_len1, regex_len2;
+	int ret;
+
+	/* Order from high prefix length to low */
+	ret = (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2->prefix_len);
+	if (ret)
+		return ret;
+
+	/* Order from long total regex length to short */
+	regex_len1 = strlen(r1->regex_str);
+	regex_len2 = strlen(r2->regex_str);
+	ret = (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
+	if (ret)
+		return ret;
 
-	if (!tmp)
-		return 0;
+	/*
+	 * Order for no-duplicates check.
+	 * Use reverse alphabetically order to retain the Fedora ordering of
+	 * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
+	 */
+	ret = strcmp(r1->regex_str, r2->regex_str);
+	if (ret)
+		return -ret;
 
-	for (ind = buf; ind < tmp; ind++) {
-		if (strchr(".^$?*+|[({", (int)*ind))
-			return 0;
-	}
-	return tmp - buf;
+	/* Order wildcard mode (0) last */
+	return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->file_kind);
 }
 
-/*
- * return the stemid given a string and a length
- */
-static inline int find_stem(struct saved_data *data, const char *buf,
-						    int stem_len)
+static inline int compare_spec_node(const void *p1, const void *p2)
 {
-	int i;
-
-	for (i = 0; i < data->num_stems; i++) {
-		if (stem_len == data->stem_arr[i].len &&
-		    !strncmp(buf, data->stem_arr[i].buf, stem_len))
-			return i;
-	}
+	const struct spec_node *n1 = p1;
+	const struct spec_node *n2 = p2;
+	int rc;
 
-	return -1;
+	rc = strcmp(n1->stem, n2->stem);
+	/* There should not be two nodes with the same stem in the same array */
+	assert(rc != 0);
+	return rc;
 }
 
-/* returns the index of the new stored object */
-static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
+static inline void sort_spec_node(struct spec_node *node, struct spec_node *parent)
 {
-	int num = data->num_stems;
-
-	if (data->alloc_stems == num) {
-		struct stem *tmp_arr;
-		int alloc_stems = data->alloc_stems * 2 + 16;
-		tmp_arr = realloc(data->stem_arr,
-				  sizeof(*tmp_arr) * alloc_stems);
-		if (!tmp_arr) {
-			return -1;
-		}
-		data->alloc_stems = alloc_stems;
-		data->stem_arr = tmp_arr;
-	}
-	data->stem_arr[num].len = stem_len;
-	data->stem_arr[num].buf = buf;
-	data->stem_arr[num].from_mmap = 0;
-	data->num_stems++;
+	/* A node should not be its own parent */
+	assert(node != parent);
+	/* Only root node has NULL stem */
+	assert((!parent && !node->stem) || (parent && node->stem && node->stem[0] != '\0'));
+	/* A non-root node should not be empty */
+	assert(!parent || (node->literal_specs_num || node->regex_specs_num || node->children_num));
 
-	return num;
-}
 
-/* find the stem of a file spec, returns the index into stem_arr for a new
- * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us). */
-static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
-{
-	int stem_len = get_stem_from_spec(buf);
-	int stemid;
-	char *stem;
-	int r;
+	node->parent = parent;
 
-	if (!stem_len)
-		return -1;
+	/* Sort for comparison support and binary search lookup */
 
-	stemid = find_stem(data, buf, stem_len);
-	if (stemid >= 0)
-		return stemid;
+	if (node->literal_specs_num > 1)
+		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
 
-	/* not found, allocate a new one */
-	stem = strndup(buf, stem_len);
-	if (!stem)
-		return -1;
+	if (node->regex_specs_num > 1)
+		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
 
-	r = store_stem(data, stem, stem_len);
-	if (r < 0)
-		free(stem);
+	if (node->children_num > 1)
+		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
 
-	return r;
+	for (uint32_t i = 0; i < node->children_num; i++)
+		sort_spec_node(&node->children[i], node);
 }
 
-/* This will always check for buffer over-runs and either read the next entry
- * if buf != NULL or skip over the entry (as these areas are mapped in the
- * current buffer). */
-static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
+static inline void sort_specs(struct saved_data *data)
 {
-	if (bytes > fp->next_len)
-		return -1;
-
-	if (buf)
-		memcpy(buf, fp->next_addr, bytes);
-
-	fp->next_addr = (char *)fp->next_addr + bytes;
-	fp->next_len -= bytes;
-	return 0;
+	sort_spec_node(data->root, NULL);
 }
 
-static inline int compile_regex(struct spec *spec, const char **errbuf)
+static inline int compile_regex(struct regex_spec *spec, const char **errbuf)
 {
-	char *reg_buf, *anchored_regex, *cp;
+	const char *reg_buf;
+	char *anchored_regex, *cp;
 	struct regex_error_data error_data;
 	static char regex_error_format_buffer[256];
 	size_t len;
@@ -423,29 +503,383 @@ static inline int compile_regex(struct spec *spec, const char **errbuf)
 	return 0;
 }
 
+#define GROW_ARRAY(arr) ({                                                                  \
+	int ret_;                                                                           \
+	if ((arr ## _num) < (arr ## _alloc)) {                                              \
+		ret_ = 0;                                                                   \
+	} else {                                                                            \
+		size_t addedsize_ = ((arr ## _alloc) >> 1) + ((arr ## _alloc >> 4)) + 4;    \
+		size_t newsize_ = addedsize_ + (arr ## _alloc);                             \
+		if (newsize_ < (arr ## _alloc) || newsize_ >= (typeof(arr ## _alloc))-1) {  \
+			errno = EOVERFLOW;                                                  \
+			ret_ = -1;                                                          \
+		} else {                                                                    \
+			typeof(arr) tmp_ = reallocarray(arr, newsize_, sizeof(*(arr)));     \
+			if (!tmp_) {                                                        \
+				ret_ = -1;                                                  \
+			} else {                                                            \
+				(arr) = tmp_;                                               \
+				(arr ## _alloc) = newsize_;                                 \
+				ret_ = 0;                                                   \
+			}                                                                   \
+		}                                                                           \
+	}                                                                                   \
+	ret_;                                                                               \
+})
+
+static int insert_spec(const struct selabel_handle *rec, struct saved_data *data,
+		       const char *prefix, char *regex, uint8_t file_kind, char *context,
+		       const char *path, unsigned int lineno)
+{
+	size_t prefix_len;
+	bool has_meta;
+
+	if (data->num_specs == UINT64_MAX) {
+		free(regex);
+		free(context);
+		errno = EOVERFLOW;
+		return -1;
+	}
+
+	has_meta = regex_has_meta_chars(regex, &prefix_len, path, lineno);
+
+	/* Ensured by read_spec_entry() */
+	assert(prefix_len < UINT16_MAX);
+
+	if (has_meta) {
+		struct spec_node *node = data->root;
+		const char *p = regex;
+		uint32_t id;
+		int depth = 0, rc;
+
+		while (depth < SPEC_NODE_MAX_DEPTH) {
+			const char *q;
+			size_t regex_stem_len, stem_len;
+			char *stem = NULL;
+			bool child_found;
+
+			q = strchr(p + 1, '/');
+			if (!q)
+				break;
+
+			regex_stem_len = q - p - 1;
+			/* Double slashes */
+			if (regex_stem_len == 0) {
+				p = q;
+				continue;
+			}
+
+			rc = regex_simplify(p + 1, regex_stem_len, &stem, path, lineno);
+			if (rc < 0) {
+				free(regex);
+				free(context);
+				return -1;
+			}
+			if (rc == 0)
+				break;
+
+			stem_len = strlen(stem);
+			if (stem_len >= UINT16_MAX) {
+				free(stem);
+				break;
+			}
+
+			if (depth == 0 && prefix && strcmp(prefix + 1, stem) != 0) {
+				free(stem);
+				free(regex);
+				free(context);
+				return 0;
+			}
+
+			child_found = false;
+			for (uint32_t i = 0; i < node->children_num; i++) {
+				if (node->children[i].stem_len == stem_len && strncmp(node->children[i].stem, stem, stem_len) == 0) {
+					child_found = true;
+					node = &node->children[i];
+					break;
+				}
+			}
+
+			if (!child_found) {
+				rc = GROW_ARRAY(node->children);
+				if (rc) {
+					free(stem);
+					free(regex);
+					free(context);
+					return -1;
+				}
+
+				id = node->children_num++;
+				node->children[id] = (struct spec_node) {
+					.stem = stem,
+					.stem_len = stem_len,
+				};
+
+				node = &node->children[id];
+			} else {
+				free(stem);
+			}
+
+			p += regex_stem_len + 1;
+			depth++;
+		}
+
+		rc = GROW_ARRAY(node->regex_specs);
+		if (rc) {
+			free(regex);
+			free(context);
+			return -1;
+		}
+
+		id = node->regex_specs_num++;
+
+		node->regex_specs[id] = (struct regex_spec) {
+			.regex_str = regex,
+			.prefix_len = prefix_len,
+			.regex_compiled = false,
+			.regex_lock = PTHREAD_MUTEX_INITIALIZER,
+			.file_kind = file_kind,
+			.any_matches = false,
+			.lr.ctx_raw = context,
+			.lr.ctx_trans = NULL,
+			.lr.lineno = lineno,
+			.lr.validated = false,
+		};
+
+		data->num_specs++;
+
+		if (rec->validating) {
+			const char *errbuf = NULL;
+
+			if (compile_regex(&node->regex_specs[id], &errbuf)) {
+				COMPAT_LOG(SELINUX_ERROR,
+					   "%s:  line %u has invalid regex %s:  %s\n",
+					   path, lineno, regex, errbuf);
+				return -1;
+			}
+
+			if (strcmp(context, "<<none>>") != 0) {
+				rc = compat_validate(rec, &node->regex_specs[id].lr, path, lineno);
+				if (rc < 0)
+					return rc;
+			}
+		}
+	} else { /* !has_meta */
+		struct spec_node *node = data->root;
+		char *literal_regex = NULL;
+		const char *p;
+		uint32_t id;
+		int depth = 0, rc;
+
+		rc = regex_simplify(regex, strlen(regex), &literal_regex, path, lineno);
+		if (rc != 1) {
+			if (rc == 0) {
+				COMPAT_LOG(SELINUX_ERROR,
+					   "%s:  line %u failed to simplify regex %s\n",
+					   path, lineno, regex);
+				errno = EINVAL;
+			}
+			free(regex);
+			free(context);
+			return -1;
+		}
+
+		p = literal_regex;
+
+		while (depth < SPEC_NODE_MAX_DEPTH) {
+			const char *q;
+			size_t length;
+			char *stem;
+			bool child_found;
+
+			if (*p != '/')
+				break;
+
+			q = strchr(p + 1, '/');
+			if (!q)
+				break;
+
+			length = q - p - 1;
+			/* Double slashes */
+			if (length == 0) {
+				p = q;
+				continue;
+			}
+
+			/* Ensured by read_spec_entry() */
+			assert(length < UINT16_MAX);
+
+			if (depth == 0 && prefix && strncmp(prefix + 1, p + 1, length) != 0) {
+				free(literal_regex);
+				free(regex);
+				free(context);
+				return 0;
+			}
+
+			child_found = false;
+			for (uint32_t i = 0; i < node->children_num; i++) {
+				if (node->children[i].stem_len == length && strncmp(node->children[i].stem, p + 1, length) == 0) {
+					child_found = true;
+					node = &node->children[i];
+					break;
+				}
+			}
+
+			if (!child_found) {
+				rc = GROW_ARRAY(node->children);
+				if (rc) {
+					free(literal_regex);
+					free(regex);
+					free(context);
+					return -1;
+				}
+
+				stem = strndup(p + 1, length);
+				if (!stem) {
+					free(literal_regex);
+					free(regex);
+					free(context);
+					return -1;
+				}
+
+				id = node->children_num++;
+				node->children[id] = (struct spec_node) {
+					.stem = stem,
+					.stem_len = length,
+				};
+
+				node = &node->children[id];
+			}
+
+			p = q;
+			depth++;
+		}
+
+		rc = GROW_ARRAY(node->literal_specs);
+		if (rc) {
+			free(literal_regex);
+			free(regex);
+			free(context);
+			return -1;
+		}
+
+		id = node->literal_specs_num++;
+
+		assert(prefix_len == strlen(literal_regex));
+
+		node->literal_specs[id] = (struct literal_spec) {
+			.regex_str = regex,
+			.prefix_len = prefix_len,
+			.literal_match = literal_regex,
+			.file_kind = file_kind,
+			.any_matches = false,
+			.lr.ctx_raw = context,
+			.lr.ctx_trans = NULL,
+			.lr.lineno = lineno,
+			.lr.validated = false,
+		};
+
+		data->num_specs++;
+
+		if (rec->validating && strcmp(context, "<<none>>") != 0) {
+			rc = compat_validate(rec, &node->literal_specs[id].lr, path, lineno);
+			if (rc < 0)
+				return rc;
+		}
+
+	}
+
+	return 0;
+}
+
+#undef GROW_ARRAY
+
+static inline void free_spec_node(struct spec_node *node)
+{
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		struct literal_spec *lspec = &node->literal_specs[i];
+
+		free(lspec->lr.ctx_raw);
+		free(lspec->lr.ctx_trans);
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
+/* This will always check for buffer over-runs and either read the next entry
+ * if buf != NULL or skip over the entry (as these areas are mapped in the
+ * current buffer). */
+static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
+{
+	if (bytes > fp->next_len)
+		return -1;
+
+	if (buf)
+		memcpy(buf, fp->next_addr, bytes);
+
+	fp->next_addr = (unsigned char *)fp->next_addr + bytes;
+	fp->next_len -= bytes;
+	return 0;
+}
+
 /* This service is used by label_file.c process_file() and
  * utils/sefcontext_compile.c */
 static inline int process_line(struct selabel_handle *rec,
-			const char *path, const char *prefix,
-			char *line_buf, unsigned lineno)
+			       const char *path, const char *prefix,
+			       char *line_buf, size_t nread, unsigned lineno)
 {
-	int items, len, rc;
+	int items;
 	char *regex = NULL, *type = NULL, *context = NULL;
-	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec_arr;
-	unsigned int nspec = data->nspec;
+	struct saved_data *data = rec->data;
 	const char *errbuf = NULL;
+	uint8_t file_kind = LABEL_FILE_KIND_ALL;
+
+	if (prefix) {
+		if (prefix[0] != '/' ||
+		    prefix[1] == '\0' ||
+		    strchr(prefix + 1, '/') != NULL) {
+			errno = EINVAL;
+			return -1;
+		}
+	}
 
-	items = read_spec_entries(line_buf, &errbuf, 3, &regex, &type, &context);
+	items = read_spec_entries(line_buf, nread, &errbuf, 3, &regex, &type, &context);
 	if (items < 0) {
 		if (errbuf) {
-			selinux_log(SELINUX_ERROR,
-				    "%s:  line %u error due to: %s\n", path,
-				    lineno, errbuf);
+			COMPAT_LOG(SELINUX_ERROR,
+				   "%s:  line %u error due to: %s\n", path,
+				   lineno, errbuf);
 		} else {
-			selinux_log(SELINUX_ERROR,
-				    "%s:  line %u error due to: %m\n", path,
-				    lineno);
+			COMPAT_LOG(SELINUX_ERROR,
+				   "%s:  line %u error due to: %m\n", path,
+				   lineno);
 		}
 		free(regex);
 		free(type);
@@ -458,81 +892,38 @@ static inline int process_line(struct selabel_handle *rec,
 
 	if (items < 2) {
 		COMPAT_LOG(SELINUX_ERROR,
-			    "%s:  line %u is missing fields\n", path,
-			    lineno);
+			   "%s:  line %u is missing fields\n", path,
+			   lineno);
 		if (items == 1)
 			free(regex);
 		errno = EINVAL;
 		return -1;
-	} else if (items == 2) {
-		/* The type field is optional. */
-		context = type;
-		type = 0;
 	}
 
-	len = get_stem_from_spec(regex);
-	if (len && prefix && strncmp(prefix, regex, len)) {
-		/* Stem of regex does not match requested prefix, discard. */
-		free(regex);
-		free(type);
-		free(context);
-		return 0;
-	}
-
-	rc = grow_specs(data);
-	if (rc)
-		return rc;
-
-	spec_arr = data->spec_arr;
-
-	/* process and store the specification in spec. */
-	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
-	spec_arr[nspec].regex_str = regex;
-	__pthread_mutex_init(&spec_arr[nspec].regex_lock, NULL);
-	spec_arr[nspec].regex_compiled = false;
-
-	spec_arr[nspec].type_str = type;
-	spec_arr[nspec].mode = 0;
-
-	spec_arr[nspec].lr.ctx_raw = context;
-	spec_arr[nspec].lr.lineno = lineno;
-
-	/*
-	 * bump data->nspecs to cause closef() to cover it in its free
-	 * but do not bump nspec since it's used below.
-	 */
-	data->nspec++;
-
-	if (rec->validating
-			&& compile_regex(&spec_arr[nspec], &errbuf)) {
-		COMPAT_LOG(SELINUX_ERROR,
-			   "%s:  line %u has invalid regex %s:  %s\n",
-			   path, lineno, regex, errbuf);
-		errno = EINVAL;
-		return -1;
+	if (items == 2) {
+		/* The type field is optional. */
+		context = type;
+		type = NULL;
 	}
 
 	if (type) {
-		mode_t mode = string_to_mode(type);
+		file_kind = string_to_file_kind(type);
 
-		if (mode == (mode_t)-1) {
+		if (file_kind == LABEL_FILE_KIND_INVALID) {
 			COMPAT_LOG(SELINUX_ERROR,
 				   "%s:  line %u has invalid file type %s\n",
 				   path, lineno, type);
+			free(regex);
+			free(type);
+			free(context);
 			errno = EINVAL;
 			return -1;
 		}
-		spec_arr[nspec].mode = mode;
-	}
-
-	/* Determine if specification has
-	 * any meta characters in the RE */
-	spec_hasMetaChars(&spec_arr[nspec]);
 
-	if (strcmp(context, "<<none>>") && rec->validating)
-		return compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
+		free(type);
+	}
 
-	return 0;
+	return insert_spec(rec, data, prefix, regex, file_kind, context, path, lineno);
 }
 
 #endif /* _SELABEL_FILE_H_ */
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index ea60cd9a..854f92fa 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -71,8 +71,8 @@ extern void digest_gen_hash(struct selabel_digest *digest);
 struct selabel_lookup_rec {
 	char * ctx_raw;
 	char * ctx_trans;
-	int validated;
-	unsigned lineno;
+	unsigned int lineno;
+	bool validated;
 };
 
 struct selabel_handle {
@@ -143,6 +143,6 @@ compat_validate(const struct selabel_handle *rec,
  * The read_spec_entries function may be used to
  * replace sscanf to read entries from spec files.
  */
-extern int read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...);
+extern int read_spec_entries(char *line_buf, size_t nread, const char **errbuf, int num_args, ...);
 
 #endif				/* _SELABEL_INTERNAL_H_ */
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index f7ab9292..978ba828 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -4,6 +4,7 @@
  * Author : Richard Haines <richard_c_haines@btinternet.com>
  */
 
+#include <stdint.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <ctype.h>
@@ -21,10 +22,11 @@
  *            errno will be set.
  *
  */
-static inline int read_spec_entry(char **entry, char **ptr, int *len, const char **errbuf)
+static inline int read_spec_entry(char **entry, const char **ptr, size_t *len, const char **errbuf)
 {
+	const char *tmp_buf;
+
 	*entry = NULL;
-	char *tmp_buf = NULL;
 
 	while (isspace((unsigned char)**ptr) && **ptr != '\0')
 		(*ptr)++;
@@ -43,6 +45,9 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
 	}
 
 	if (*len) {
+		if (*len >= UINT16_MAX)
+			return -1;
+
 		*entry = strndup(tmp_buf, *len);
 		if (!*entry)
 			return -1;
@@ -62,22 +67,23 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
  * This function calls read_spec_entry() to do the actual string processing.
  * As such, can return anything from that function as well.
  */
-int  read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
+int  read_spec_entries(char *line_buf, size_t nread, const char **errbuf, int num_args, ...)
 {
-	char **spec_entry, *buf_p;
-	int len, rc, items, entry_len = 0;
+	char **spec_entry;
+	const char *buf_p;
+	size_t entry_len = 0;
+	int rc, items;
 	va_list ap;
 
 	*errbuf = NULL;
 
-	len = strlen(line_buf);
-	if (line_buf[len - 1] == '\n')
-		line_buf[len - 1] = '\0';
+	if (line_buf[nread - 1] == '\n')
+		line_buf[nread - 1] = '\0';
 	else
 		/* Handle case if line not \n terminated by bumping
 		 * the len for the check below (as the line is NUL
 		 * terminated by getline(3)) */
-		len++;
+		nread++;
 
 	buf_p = line_buf;
 	while (isspace((unsigned char)*buf_p))
@@ -94,7 +100,7 @@ int  read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
 	while (items < num_args) {
 		spec_entry = va_arg(ap, char **);
 
-		if (len - 1 == buf_p - line_buf) {
+		if (buf_p[0] == '\0' || nread - 1 == (size_t)(buf_p - line_buf)) {
 			va_end(ap);
 			return items;
 		}
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 88d82fed..182c8c89 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <endian.h>
 #include <pthread.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -18,7 +19,6 @@
 
 /* If the compiler doesn't define __BYTE_ORDER__, try to use the C
  * library <endian.h> header definitions. */
-#include <endian.h>
 #ifndef __BYTE_ORDER
 #error Neither __BYTE_ORDER__ nor __BYTE_ORDER defined. Unable to determine endianness.
 #endif
@@ -116,13 +116,15 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		    int do_load_precompregex, bool *regex_compiled)
 {
 	int rc;
-	uint32_t entry_len;
+	uint32_t data_u32, entry_len;
 
 	*regex_compiled = false;
-	rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
 	if (rc < 0)
 		return -1;
 
+	entry_len = be32toh(data_u32);
+
 	if (entry_len && do_load_precompregex) {
 		/*
 		 * this should yield exactly one because we store one pattern at
@@ -169,7 +171,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
 	int rc = 0;
 	size_t len;
 	PCRE2_SIZE serialized_size;
-	uint32_t to_write = 0;
+	uint32_t to_write = 0, data_u32;
 	PCRE2_UCHAR *bytes = NULL;
 
 	if (do_write_precompregex) {
@@ -177,14 +179,15 @@ int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
 		rc = pcre2_serialize_encode((const pcre2_code **)&regex->regex,
 					    1, &bytes, &serialized_size, NULL);
 		if (rc != 1 || serialized_size >= UINT32_MAX) {
-			rc = -1;
+			rc = -3;
 			goto out;
 		}
 		to_write = serialized_size;
 	}
 
 	/* write serialized pattern's size */
-	len = fwrite(&to_write, sizeof(uint32_t), 1, fp);
+	data_u32 = htobe32(to_write);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, fp);
 	if (len != 1) {
 		rc = -1;
 		goto out;
@@ -355,11 +358,15 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		    int do_load_precompregex __attribute__((unused)), bool *regex_compiled)
 {
 	int rc;
-	uint32_t entry_len;
+	uint32_t data_u32, entry_len;
 	size_t info_len;
 
-	rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !entry_len)
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+
+	entry_len = be32toh(data_u32);
+	if (!entry_len)
 		return -1;
 
 	*regex = regex_data_create();
@@ -380,10 +387,12 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 	if (rc < 0 || info_len != entry_len)
 		goto err;
 
-	rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+	rc = next_entry(&data_u32, mmap_area, sizeof(uint32_t));
 	if (rc < 0)
 		goto err;
 
+	entry_len = be32toh(data_u32);
+
 	if (entry_len) {
 		(*regex)->lsd.study_data = (void *)mmap_area->next_addr;
 		(*regex)->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
@@ -424,45 +433,45 @@ int regex_writef(struct regex_data *regex, FILE *fp,
 {
 	int rc;
 	size_t len;
-	uint32_t to_write;
+	uint32_t data_u32;
 	size_t size;
 	pcre_extra *sd = get_pcre_extra(regex);
 
 	/* determine the size of the pcre data in bytes */
 	rc = pcre_fullinfo(regex->regex, NULL, PCRE_INFO_SIZE, &size);
-	if (rc < 0)
-		return -1;
+	if (rc < 0 || size >= UINT32_MAX)
+		return -3;
 
 	/* write the number of bytes in the pcre data */
-	to_write = size;
-	len = fwrite(&to_write, sizeof(uint32_t), 1, fp);
+	data_u32 = htobe32(size);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, fp);
 	if (len != 1)
 		return -1;
 
 	/* write the actual pcre data as a char array */
-	len = fwrite(regex->regex, 1, to_write, fp);
-	if (len != to_write)
+	len = fwrite(regex->regex, 1, size, fp);
+	if (len != size)
 		return -1;
 
 	if (sd) {
 		/* determine the size of the pcre study info */
 		rc =
 		    pcre_fullinfo(regex->regex, sd, PCRE_INFO_STUDYSIZE, &size);
-		if (rc < 0)
-			return -1;
+		if (rc < 0 || size >= UINT32_MAX)
+			return -3;
 	} else
 		size = 0;
 
 	/* write the number of bytes in the pcre study data */
-	to_write = size;
-	len = fwrite(&to_write, sizeof(uint32_t), 1, fp);
+	data_u32 = htobe32(size);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, fp);
 	if (len != 1)
 		return -1;
 
 	if (sd) {
 		/* write the actual pcre study data as a char array */
-		len = fwrite(sd->study_data, 1, to_write, fp);
-		if (len != to_write)
+		len = fwrite(sd->study_data, 1, size, fp);
+		if (len != size)
 			return -1;
 	}
 
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 6c32172d..9106c7dd 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -1,25 +1,25 @@
-#include <ctype.h>
+#include <endian.h>
 #include <errno.h>
+#include <getopt.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <getopt.h>
-#include <limits.h>
+
 #include <selinux/selinux.h>
 #include <sepol/sepol.h>
 
+#include "../src/avc_sidtab.h"
 #include "../src/label_file.h"
 #include "../src/regex.h"
 
+
 static const char *policy_file;
 static int ctx_err;
 
 static int validate_context(char **ctxp)
 {
-	char *ctx = *ctxp;
+	const char *ctx = *ctxp;
 
 	if (policy_file && sepol_check_context(ctx) < 0) {
 		ctx_err = -1;
@@ -35,20 +35,20 @@ static int process_file(struct selabel_handle *rec, const char *filename)
 	int rc;
 	char *line_buf = NULL;
 	size_t line_len = 0;
+	ssize_t nread;
 	FILE *context_file;
 	const char *prefix = NULL;
 
-	context_file = fopen(filename, "r");
+	context_file = fopen(filename, "re");
 	if (!context_file) {
-		fprintf(stderr, "Error opening %s: %s\n",
-			    filename, strerror(errno));
+		fprintf(stderr, "Error opening %s: %m\n", filename);
 		return -1;
 	}
 
 	line_num = 0;
 	rc = 0;
-	while (getline(&line_buf, &line_len, context_file) > 0) {
-		rc = process_line(rec, filename, prefix, line_buf, ++line_num);
+	while ((nread = getline(&line_buf, &line_len, context_file)) > 0) {
+		rc = process_line(rec, filename, prefix, line_buf, nread, ++line_num);
 		if (rc || ctx_err) {
 			/* With -p option need to check and fail if ctx err as
 			 * process_line() context validation on Linux does not
@@ -65,211 +65,445 @@ out:
 	return rc;
 }
 
+static int literal_spec_to_sidtab(const struct literal_spec *lspec, struct sidtab *stab)
+{
+	security_id_t dummy;
+
+	return sidtab_context_to_sid(stab, lspec->lr.ctx_raw, &dummy);
+}
+
+static int regex_spec_to_sidtab(const struct regex_spec *rspec, struct sidtab *stab)
+{
+	security_id_t dummy;
+
+	return sidtab_context_to_sid(stab, rspec->lr.ctx_raw, &dummy);
+}
+
+static int spec_node_to_sidtab(const struct spec_node *node, struct sidtab *stab)
+{
+	int rc;
+
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		rc = literal_spec_to_sidtab(&node->literal_specs[i], stab);
+		if (rc)
+			return rc;
+	}
+
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		rc = regex_spec_to_sidtab(&node->regex_specs[i], stab);
+		if (rc)
+			return rc;
+	}
+
+	for (uint32_t i = 0; i < node->children_num; i++) {
+		rc = spec_node_to_sidtab(&node->children[i], stab);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int create_sidtab(const struct saved_data *data, struct sidtab *stab)
+{
+	int rc;
+
+	rc = sidtab_init(stab);
+	if (rc < 0)
+		return rc;
+
+	return spec_node_to_sidtab(data->root, stab);
+}
+
+
 /*
  * File Format
  *
- * u32 - magic number
- * u32 - version
- * u32 - length of pcre version EXCLUDING nul
- * char - pcre version string EXCLUDING nul
- * u32 - number of stems
- * ** Stems
- *	u32  - length of stem EXCLUDING nul
- *	char - stem char array INCLUDING nul
- * u32 - number of regexs
- * ** Regexes
- *	u32  - length of upcoming context INCLUDING nul
- *	char - char array of the raw context
- *	u32  - length of the upcoming regex_str
- *	char - char array of the original regex string including the stem.
- *	u32  - mode bits for >= SELINUX_COMPILED_FCONTEXT_MODE
- *	       mode_t for <= SELINUX_COMPILED_FCONTEXT_PCRE_VERS
- *	s32  - stemid associated with the regex
- *	u32  - spec has meta characters
- *	u32  - The specs prefix_len if >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
- *	u32  - data length of the pcre regex
- *	char - a buffer holding the raw pcre regex info
- *	u32  - data length of the pcre regex study daya
- *	char - a buffer holding the raw pcre regex study data
+ * The format uses network byte-order.
+ *
+ * u32     - magic number
+ * u32     - version
+ * u32     - length of upcoming pcre version EXCLUDING nul
+ * [char]  - pcre version string EXCLUDING nul
+ * u32     - length of upcoming pcre architecture EXCLUDING nul
+ * [char]  - pcre architecture string EXCLUDING nul
+ * u64     - number of total specifications
+ * u32     - number of upcoming context definitions
+ * [Ctx]   - array of context definitions
+ * Node    - root node
+ *
+ * Context Definition Format (Ctx)
+ *
+ * u16     - length of upcoming raw context EXCLUDING nul
+ * [char]  - char array of the raw context EXCLUDING nul
+ *
+ * Node Format
+ *
+ * u16     - length of upcoming stem INCLUDING nul
+ * [char]  - stem char array INCLUDING nul
+ * u32     - number of upcoming literal specifications
+ * [LSpec] - array of literal specifications
+ * u32     - number of upcoming regular expression specifications
+ * [RSpec] - array of regular expression specifications
+ * u32     - number of upcoming child nodes
+ * [Node]  - array of child nodes
+ *
+ * Literal Specification Format (LSpec)
+ *
+ * u32     - context table index for raw context (1-based)
+ * u16     - length of upcoming regex_str INCLUDING nul
+ * [char]  - char array of the original regex string including the stem INCLUDING nul
+ * u16     - length of upcoming literal match INCLUDING nul
+ * [char]  - char array of the simplified literal match INCLUDING nul
+ * u8      - file kind (LABEL_FILE_KIND_*)
+ *
+ * Regular Expression Specification Format (RSpec)
+ *
+ * u32     - context table index for raw context (1-based)
+ * u16     - length of upcoming regex_str INCLUDING nul
+ * [char]  - char array of the original regex string including the stem INCLUDING nul
+ * u16     - length of the fixed path prefix
+ * u8      - file kind (LABEL_FILE_KIND_*)
+ * [Regex] - serialized pattern of regex, subject to underlying regex library
  */
-static int write_binary_file(struct saved_data *data, int fd,
-			     int do_write_precompregex)
+
+
+static int security_id_compare(const void *a, const void *b)
 {
-	struct spec *specs = data->spec_arr;
-	FILE *bin_file;
+	const struct security_id *sid_a = a, *sid_b = b;
+
+	return (sid_a->id > sid_b->id) - (sid_a->id < sid_b->id);
+}
+
+static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
+{
+	struct security_id *sids;
+	uint32_t data_u32, index;
+	uint16_t data_u16;
+	size_t len;
+
+	/* write number of entries */
+	data_u32 = htobe32(stab->nel);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* sort entries by id */
+	sids = calloc(stab->nel, sizeof(*sids));
+	if (!sids)
+		return -1;
+	index = 0;
+	for (unsigned i = 0; i < SIDTAB_SIZE; i++) {
+		const struct sidtab_node *cur = stab->htable[i];
+
+		while (cur) {
+			sids[index++] = cur->sid_s;
+			cur = cur->next;
+		}
+	}
+	assert(index == stab->nel);
+	qsort(sids, stab->nel, sizeof(struct security_id), security_id_compare);
+	assert(sids[0].id == 1);
+	assert(sids[stab->nel - 1].id == stab->nel);
+
+	/* write raw contexts sorted by id */
+	for (uint32_t i = 0; i < stab->nel; i++) {
+		const char *ctx = sids[i].ctx;
+		size_t ctx_len = strlen(ctx);
+
+		if (ctx_len == 0 || ctx_len >= UINT16_MAX) {
+			free(sids);
+			return -2;
+		}
+		data_u16 = htobe16(ctx_len);
+		len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+		if (len != 1) {
+			free(sids);
+			return -1;
+		}
+		len = fwrite(ctx, sizeof(char), ctx_len, bin_file);
+		if (len != ctx_len) {
+			free(sids);
+			return -1;
+		}
+	}
+
+	free(sids);
+	return 0;
+}
+
+static int write_literal_spec(FILE *bin_file, const struct literal_spec *lspec, const struct sidtab *stab)
+{
+	const struct security_id *sid;
+	const char *orig_regex, *literal_match;
+	size_t orig_regex_len, literal_match_len;
+	uint32_t data_u32;
+	uint16_t data_u16;
+	uint8_t data_u8;
+	size_t len;
+
+	/* write raw context sid */
+	sid = sidtab_context_lookup(stab, lspec->lr.ctx_raw);
+	assert(sid); /* should be set via create_sidtab() */
+	data_u32 = htobe32(sid->id);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write original regex string */
+	orig_regex = lspec->regex_str;
+	orig_regex_len = strlen(orig_regex);
+	if (orig_regex_len == 0 || orig_regex_len >= UINT16_MAX)
+		return -2;
+	orig_regex_len += 1;
+	data_u16 = htobe16(orig_regex_len);
+	len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+	len = fwrite(orig_regex, sizeof(char), orig_regex_len, bin_file);
+	if (len != orig_regex_len)
+		return -1;
+
+	/* write literal match string */
+	literal_match = lspec->literal_match;
+	literal_match_len = strlen(literal_match);
+	if (literal_match_len == 0 || literal_match_len >= UINT16_MAX)
+		return -2;
+	literal_match_len += 1;
+	data_u16 = htobe16(literal_match_len);
+	len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+	len = fwrite(literal_match, sizeof(char), literal_match_len, bin_file);
+	if (len != literal_match_len)
+		return -1;
+
+	/* write file kind */
+	data_u8 = lspec->file_kind;
+	len = fwrite(&data_u8, sizeof(uint8_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	return 0;
+}
+
+static int write_regex_spec(FILE *bin_file, bool do_write_precompregex, const struct regex_spec *rspec, const struct sidtab *stab)
+{
+	const struct security_id *sid;
+	const char *regex;
+	size_t regex_len;
+	uint32_t data_u32;
+	uint16_t data_u16;
+	uint8_t data_u8;
 	size_t len;
-	uint32_t magic = SELINUX_MAGIC_COMPILED_FCONTEXT;
-	uint32_t section_len;
-	uint32_t i;
 	int rc;
-	const char *reg_version;
-	const char *reg_arch;
 
-	bin_file = fdopen(fd, "w");
-	if (!bin_file) {
-		perror("fopen output_file");
-		exit(EXIT_FAILURE);
+	/* write raw context sid */
+	sid = sidtab_context_lookup(stab, rspec->lr.ctx_raw);
+	assert(sid); /* should be set via create_sidtab() */
+	data_u32 = htobe32(sid->id);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write regex string */
+	regex = rspec->regex_str;
+	regex_len = strlen(regex);
+	if (regex_len == 0 || regex_len >= UINT16_MAX)
+		return -2;
+	regex_len += 1;
+	data_u16 = htobe16(regex_len);
+	len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+	len = fwrite(regex, sizeof(char), regex_len, bin_file);
+	if (len != regex_len)
+		return -1;
+
+	/* write prefix length */
+	data_u16 = htobe16(rspec->prefix_len);
+	len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write file kind */
+	data_u8 = rspec->file_kind;
+	len = fwrite(&data_u8, sizeof(uint8_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* Write serialized regex */
+	rc = regex_writef(rspec->regex, bin_file, do_write_precompregex);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static int write_spec_node(FILE *bin_file, bool do_write_precompregex, const struct spec_node *node, const struct sidtab *stab)
+{
+	size_t stem_len;
+	uint32_t data_u32;
+	uint16_t data_u16;
+	size_t len;
+	int rc;
+
+	stem_len = node->stem_len;
+	if ((stem_len == 0 && node->parent) || stem_len >= UINT16_MAX)
+		return -2;
+	stem_len += 1;
+	data_u16 = htobe16(stem_len);
+	len = fwrite(&data_u16, sizeof(uint16_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+	len = fwrite(node->stem ?: "", sizeof(char), stem_len, bin_file);
+	if (len != stem_len)
+		return -1;
+
+	/* write number of literal specs */
+	data_u32 = htobe32(node->literal_specs_num);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write literal specs */
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		rc = write_literal_spec(bin_file, &node->literal_specs[i], stab);
+		if (rc)
+			return rc;
+	}
+
+	/* write number of regex specs */
+	data_u32 = htobe32(node->regex_specs_num);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write regex specs */
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		rc = write_regex_spec(bin_file, do_write_precompregex, &node->regex_specs[i], stab);
+		if (rc)
+			return rc;
+	}
+
+	/* write number of child nodes */
+	data_u32 = htobe32(node->children_num);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		return -1;
+
+	/* write child nodes */
+	for (uint32_t i = 0; i < node->children_num; i++) {
+		rc = write_spec_node(bin_file, do_write_precompregex, &node->children[i], stab);
+		if (rc)
+			return rc;
 	}
 
+	return 0;
+}
+
+static int write_binary_file(const struct saved_data *data, const struct sidtab *stab,
+			     int fd, const char *path, bool do_write_precompregex,
+			     const char *progname)
+{
+ 	FILE *bin_file;
+	const char *reg_arch, *reg_version;
+	size_t len, reg_arch_len, reg_version_len;
+	uint64_t data_u64;
+	uint32_t data_u32;
+ 	int rc;
+
+ 	bin_file = fdopen(fd, "we");
+ 	if (!bin_file) {
+		fprintf(stderr, "%s: failed to open %s: %m\n", progname, path);
+		close(fd);
+		return -1;
+ 	}
+
 	/* write some magic number */
-	len = fwrite(&magic, sizeof(uint32_t), 1, bin_file);
+	data_u32 = htobe32(SELINUX_MAGIC_COMPILED_FCONTEXT);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
 	if (len != 1)
-		goto err;
+		goto err_write;
 
 	/* write the version */
-	section_len = SELINUX_COMPILED_FCONTEXT_MAX_VERS;
-	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+	data_u32 = htobe32(SELINUX_COMPILED_FCONTEXT_MAX_VERS);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
 	if (len != 1)
-		goto err;
+		goto err_write;
 
 	/* write version of the regex back-end */
 	reg_version = regex_version();
 	if (!reg_version)
-		goto err;
-	section_len = strlen(reg_version);
-	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+		goto err_check;
+	reg_version_len = strlen(reg_version);
+	if (reg_version_len == 0 || reg_version_len >= UINT32_MAX)
+		goto err_check;
+	data_u32 = htobe32(reg_version_len);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
 	if (len != 1)
-		goto err;
-	len = fwrite(reg_version, sizeof(char), section_len, bin_file);
-	if (len != section_len)
-		goto err;
+		goto err_write;
+	len = fwrite(reg_version, sizeof(char), reg_version_len, bin_file);
+	if (len != reg_version_len)
+		goto err_write;
 
 	/* write regex arch string */
 	reg_arch = regex_arch_string();
 	if (!reg_arch)
-		goto err;
-	section_len = strlen(reg_arch);
-	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+		goto err_check;
+	reg_arch_len = strlen(reg_arch);
+	if (reg_arch_len == 0 || reg_arch_len >= UINT32_MAX)
+		goto err_check;
+	data_u32 = htobe32(reg_arch_len);
+	len = fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
 	if (len != 1)
-		goto err;
-	len = fwrite(reg_arch, sizeof(char), section_len, bin_file);
-	if (len != section_len)
-		goto err;
-
-	/* write the number of stems coming */
-	section_len = data->num_stems;
-	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+		goto err_write;
+	len = fwrite(reg_arch, sizeof(char), reg_arch_len, bin_file);
+	if (len != reg_arch_len)
+		goto err_write;
+
+	/* write number of total specifications */
+	data_u64 = htobe64(data->num_specs);
+	len = fwrite(&data_u64, sizeof(uint64_t), 1, bin_file);
 	if (len != 1)
-		goto err;
-
-	for (i = 0; i < section_len; i++) {
-		char *stem = data->stem_arr[i].buf;
-		uint32_t stem_len = data->stem_arr[i].len;
+		goto err_write;
 
-		/* write the strlen (aka no nul) */
-		len = fwrite(&stem_len, sizeof(uint32_t), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* include the nul in the file */
-		stem_len += 1;
-		len = fwrite(stem, sizeof(char), stem_len, bin_file);
-		if (len != stem_len)
-			goto err;
-	}
+	/* write context table */
+	rc = write_sidtab(bin_file, stab);
+	if (rc)
+		return rc;
 
-	/* write the number of regexes coming */
-	section_len = data->nspec;
-	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
-	if (len != 1)
+	rc = write_spec_node(bin_file, do_write_precompregex, data->root, stab);
+	if (rc)
 		goto err;
 
-	for (i = 0; i < section_len; i++) {
-		char *context = specs[i].lr.ctx_raw;
-		char *regex_str = specs[i].regex_str;
-		mode_t mode = specs[i].mode;
-		size_t prefix_len = specs[i].prefix_len;
-		int32_t stem_id = specs[i].stem_id;
-		struct regex_data *re = specs[i].regex;
-		uint32_t to_write;
-
-		/* length of the context string (including nul) */
-		to_write = strlen(context) + 1;
-		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* original context strin (including nul) */
-		len = fwrite(context, sizeof(char), to_write, bin_file);
-		if (len != to_write)
-			goto err;
-
-		/* length of the original regex string (including nul) */
-		to_write = strlen(regex_str) + 1;
-		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* original regex string */
-		len = fwrite(regex_str, sizeof(char), to_write, bin_file);
-		if (len != to_write)
-			goto err;
-
-		/* binary F_MODE bits */
-		to_write = mode;
-		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* stem for this regex (could be -1) */
-		len = fwrite(&stem_id, sizeof(stem_id), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* does this spec have a metaChar? */
-		to_write = specs[i].hasMetaChars;
-		len = fwrite(&to_write, sizeof(to_write), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* For SELINUX_COMPILED_FCONTEXT_PREFIX_LEN */
-		to_write = prefix_len;
-		len = fwrite(&to_write, sizeof(to_write), 1, bin_file);
-		if (len != 1)
-			goto err;
-
-		/* Write regex related data */
-		rc = regex_writef(re, bin_file, do_write_precompregex);
-		if (rc < 0)
-			goto err;
-	}
-
-	rc = 0;
 out:
-	fclose(bin_file);
+	if (fclose(bin_file) && rc == 0) {
+		fprintf(stderr, "%s: failed to close %s: %m\n", progname, path);
+		rc = -1;
+	}
 	return rc;
-err:
-	rc = -1;
-	goto out;
-}
 
-static void free_specs(struct saved_data *data)
-{
-	struct spec *specs = data->spec_arr;
-	unsigned int num_entries = data->nspec;
-	unsigned int i;
-
-	for (i = 0; i < num_entries; i++) {
-		free(specs[i].lr.ctx_raw);
-		free(specs[i].lr.ctx_trans);
-		free(specs[i].regex_str);
-		free(specs[i].type_str);
-		regex_data_free(specs[i].regex);
-	}
-	free(specs);
+err_check:
+	rc = -2;
+	goto err;
 
-	num_entries = data->num_stems;
-	for (i = 0; i < num_entries; i++)
-		free(data->stem_arr[i].buf);
-	free(data->stem_arr);
+err_write:
+	rc = -1;
+	goto err;
 
-	memset(data, 0, sizeof(*data));
+err:
+	fprintf(stderr, "%s: failed to compile file context specifications: %s\n",
+		progname,
+		(rc == -3) ? "regex serialization failure" :
+		((rc == -2) ? "invalid fcontext specification" : "write failure"));
+	goto out;
 }
 
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-	    "usage: %s [-o out_file] [-p policy_file] fc_file\n"
+	    "usage: %s [-iV] [-o out_file] [-p policy_file] fc_file\n"
 	    "Where:\n\t"
 	    "-o       Optional file name of the PCRE formatted binary\n\t"
 	    "         file to be output. If not specified the default\n\t"
@@ -287,28 +521,32 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 	    "         Arch identifier format (PCRE2):\n\t"
 	    "         <pointer width>-<size type width>-<endianness>, e.g.,\n\t"
 	    "         \"8-8-el\" for x86_64.\n\t"
+	    "-V       Print binary output format version and exit.\n\t"
 	    "fc_file  The text based file contexts file to be processed.\n",
 	    progname);
-		exit(EXIT_FAILURE);
+	exit(EXIT_FAILURE);
 }
 
 int main(int argc, char *argv[])
 {
-	const char *path = NULL;
+	const char *path;
 	const char *out_file = NULL;
-	int do_write_precompregex = 1;
+	bool do_write_precompregex = true;
 	char stack_path[PATH_MAX + 1];
 	char *tmp = NULL;
+	size_t len;
 	int fd, rc, opt;
 	FILE *policy_fp = NULL;
 	struct stat buf;
 	struct selabel_handle *rec = NULL;
 	struct saved_data *data = NULL;
+	struct spec_node *root = NULL;
+	struct sidtab stab = {};
 
 	if (argc < 2)
 		usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "io:p:r")) > 0) {
+	while ((opt = getopt(argc, argv, "io:p:rV")) > 0) {
 		switch (opt) {
 		case 'o':
 			out_file = optarg;
@@ -317,18 +555,20 @@ int main(int argc, char *argv[])
 			policy_file = optarg;
 			break;
 		case 'r':
-			do_write_precompregex = 0;
+			do_write_precompregex = false;
 			break;
 		case 'i':
-			printf("%s (%s)\n", regex_version(),
-					regex_arch_string());
+			printf("%s (%s)\n", regex_version(), regex_arch_string());
+			return 0;
+		case 'V':
+			printf("Compiled fcontext format version %d\n", SELINUX_COMPILED_FCONTEXT_MAX_VERS);
 			return 0;
 		default:
 			usage(argv[0]);
 		}
 	}
 
-	if (optind >= argc)
+	if (optind + 1 != argc)
 		usage(argv[0]);
 
 	path = argv[optind];
@@ -339,7 +579,7 @@ int main(int argc, char *argv[])
 
 	/* Open binary policy if supplied. */
 	if (policy_file) {
-		policy_fp = fopen(policy_file, "r");
+		policy_fp = fopen(policy_file, "re");
 
 		if (!policy_fp) {
 			fprintf(stderr, "%s: failed to open %s: %s\n",
@@ -373,7 +613,7 @@ int main(int argc, char *argv[])
 	 * error is detected, the process will be aborted. */
 	rec->validating = 1;
 	selinux_set_callback(SELINUX_CB_VALIDATE,
-			    (union selinux_callback)&validate_context);
+			    (union selinux_callback) { .func_validate = &validate_context });
 
 	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data) {
@@ -384,6 +624,17 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
+	root = calloc(1, sizeof(*root));
+	if (!root) {
+		fprintf(stderr, "%s: calloc failed: %s\n", argv[0], strerror(errno));
+		free(data);
+		free(rec);
+		if (policy_fp)
+			fclose(policy_fp);
+		exit(EXIT_FAILURE);
+	}
+
+	data->root = root;
 	rec->data = data;
 
 	rc = process_file(rec, path);
@@ -392,9 +643,11 @@ int main(int argc, char *argv[])
 		goto err;
 	}
 
-	rc = sort_specs(data);
-	if (rc) {
-		fprintf(stderr, "%s: sort_specs failed\n", argv[0]);
+	sort_specs(data);
+
+	rc = create_sidtab(data, &stab);
+	if (rc < 0) {
+		fprintf(stderr, "%s: failed to generate sidtab: %s\n", argv[0], strerror(errno));
 		goto err;
 	}
 
@@ -403,40 +656,41 @@ int main(int argc, char *argv[])
 	else
 		rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
 
-	if (rc < 0 || rc >= (int)sizeof(stack_path)) {
+	if (rc < 0 || (size_t)rc >= sizeof(stack_path)) {
 		fprintf(stderr, "%s: snprintf failed\n", argv[0]);
 		goto err;
 	}
+	len = rc;
 
-	tmp = malloc(strlen(stack_path) + 7);
+	tmp = malloc(len + 7);
 	if (!tmp) {
 		fprintf(stderr, "%s: malloc failed: %s\n", argv[0], strerror(errno));
 		goto err;
 	}
 
-	rc = sprintf(tmp, "%sXXXXXX", stack_path);
-	if (rc < 0) {
-		fprintf(stderr, "%s: sprintf failed\n", argv[0]);
+	rc = snprintf(tmp, len + 7, "%sXXXXXX", stack_path);
+	if (rc < 0 || (size_t)rc >= len + 7) {
+		fprintf(stderr, "%s: snprintf failed\n", argv[0]);
 		goto err;
 	}
 
-	fd  = mkstemp(tmp);
+	fd = mkstemp(tmp);
 	if (fd < 0) {
 		fprintf(stderr, "%s: mkstemp %s failed: %s\n", argv[0], tmp, strerror(errno));
+		close(fd);
 		goto err;
 	}
 
 	rc = fchmod(fd, buf.st_mode);
 	if (rc < 0) {
 		fprintf(stderr, "%s: fchmod %s failed: %s\n", argv[0], tmp, strerror(errno));
+		close(fd);
 		goto err_unlink;
 	}
 
-	rc = write_binary_file(data, fd, do_write_precompregex);
-	if (rc < 0) {
-		fprintf(stderr, "%s: write_binary_file %s failed\n", argv[0], tmp);
+	rc = write_binary_file(data, &stab, fd, tmp, do_write_precompregex, argv[0]);
+	if (rc < 0)
 		goto err_unlink;
-	}
 
 	rc = rename(tmp, stack_path);
 	if (rc < 0) {
@@ -449,9 +703,11 @@ out:
 	if (policy_fp)
 		fclose(policy_fp);
 
-	free_specs(data);
-	free(rec);
+	sidtab_destroy(&stab);
+	free_spec_node(data->root);
+	free(data->root);
 	free(data);
+	free(rec);
 	free(tmp);
 	return rc;
 
-- 
2.43.0

