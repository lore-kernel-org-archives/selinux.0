Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4B9C43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A42087F
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 22:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4WFn+YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfCKWYt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:24:49 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42143 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfCKWYt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 18:24:49 -0400
Received: by mail-qt1-f202.google.com with SMTP id o56so512916qto.9
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2019 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1kWeYJOaJl3coIvguAQh7gyj3vhMSWM02b6ArA001q0=;
        b=Z4WFn+YJzy9C3H5sv95CZrXOwNpHPxJMJfQdXfCJpKZJHdgEajM++n1PqWpngChg4W
         ESZT9s2+oKjIi7rQoITWOd5AURrSkADwyQ4kDfkUacLBbMrPHfxhD4DR/uu9mMksUpC1
         b2HRisiuPj9P7/Hz+tJb4Hv+8SOUHf5tpIaq/gSAEAespLt7AXxp32BDbG+TrwX1OeNs
         Yku+dcDamr5FCKkOIk/L3rJlBCImkOH9In3SygaLX8z9yNaujGMmeu34CbAQ2buVzIVg
         LTocM4KRgFd0hEr+twZyR4z+DYOyJh6lTn4mEBTsCwTlvUWuuRkin2q/HRLm0GS0K2H2
         B/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1kWeYJOaJl3coIvguAQh7gyj3vhMSWM02b6ArA001q0=;
        b=LOTBwW65DwbD0Y+cdKLjz57VV1PonK076HdPkcsgaUzWtaYZoHGID3qrPaa99Mr8rK
         NntZxFXY9WjjblLiq7OJNsShK2XBCZgSeTcogfrgFlaJSqzOCg5KwNViJziYKel7vW8S
         j3JoQqnWpJbP7FXGHkO12pxPH8g0cxKbL+3YJgcIbax+fJsF6ueuhuNxPl0QCZvnjZWp
         hInJJ9rZgJdOAaSaCAiQucElilhZSWqAtwXZcKkOcWkprHM0A9uugX9aTmg+bKXpcX9m
         3oHemwvYnOMvtAQEP8rMz6p2qwJ/xRLTw2AJ5CGL/jXpNzic97RR0HkWPvEFqt/aAnaK
         0QPw==
X-Gm-Message-State: APjAAAU147mJ97ThTB74N5GjGV3QctfyK81170q881UjdPm23VvfrzJ/
        7uSFgWrc3OzGdVB6ED+kpp4IH8MWqe2pBM+Bmd5h94zWvbgaPYLwbtvIRAeAA0vwoNXEP4gORpq
        4uT+hAZzKLY0V6r5SJWBeVGLFD0ilexWrmAyw8rU1DSibE4drFurb3D7OuOxO4HJnXuwG
X-Google-Smtp-Source: APXvYqwGSJ70kOthrXqUyoowwZn36kJC7K10hBLNKZbwwM7BZHo+YLYNaX8iHWAuVRz3FYWN5Y9d/M+zZ4axnQ==
X-Received: by 2002:aed:380a:: with SMTP id j10mr20342967qte.10.1552343087746;
 Mon, 11 Mar 2019 15:24:47 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:24:42 -0700
Message-Id: <20190311222442.49824-1-xunchang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH] Restorecon: factor out a lookup helper for context matches
From:   xunchang <xunchang@google.com>
To:     selinux@vger.kernel.org
Cc:     xunchang <xunchang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We used to hash the file_context and skip the restorecon on the top
level directory if the hash doesn't change. But the file_context might
change after an update; and some users experienced long restorecon
time as they have lots of files under directories like /data/media.
Therefore, we try to skip unnecessary restores if the file context
relates to the given directory doesn't change.

This CL is the first step that factors out a lookup helper function
and returns an array of matched pointers instead of a single one.
The old loopup_common function is then modified to take the first
element in the array.

This change has already been submitted in android selinux branch. And
porting it upstream will make these two branches more consistent and
save some work for the future merges.

Signed-off-by: Tianjie Xu <xunchang@google.com>
---
 libselinux/include/selinux/label.h |   4 ++
 libselinux/src/label.c             |   9 +++
 libselinux/src/label_file.c        | 111 +++++++++++++++++++++++------
 libselinux/src/label_internal.h    |   2 +
 4 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 277287ed..e537aa11 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -7,6 +7,7 @@
 #define _SELABEL_H_
 
 #include <stdbool.h>
+#include <stdint.h>
 #include <sys/types.h>
 #include <selinux/selinux.h>
 
@@ -105,6 +106,9 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 
 bool selabel_partial_match(struct selabel_handle *handle, const char *key);
 
+bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
+                                      const char *key, uint8_t* digest);
+
 int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 			      const char *key, const char **aliases, int type);
 int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 8d586bda..1d16f685 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -274,6 +274,15 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 	return rec->func_partial_match(rec, key);
 }
 
+bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
+                                      const char *key, uint8_t *digest) {
+	if (!rec->func_hash_all_partial_matches) {
+		return false;
+	}
+
+	return rec->func_hash_all_partial_matches(rec, key, digest);
+}
+
 int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 			      const char *key, const char **aliases, int type)
 {
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b81fd552..90cbd666 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -843,22 +843,38 @@ static void closef(struct selabel_handle *rec)
 	free(data);
 }
 
-static struct spec *lookup_common(struct selabel_handle *rec,
-					     const char *key,
-					     int type,
-					     bool partial)
+// Finds all the matches of |key| in the given context. Returns the result in
+// the allocated array and updates the match count. If match_count is NULL,
+// stops early once the 1st match is found.
+static const struct spec **lookup_all(struct selabel_handle *rec,
+                                      const char *key,
+                                      int type,
+                                      bool partial,
+                                      size_t *match_count)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct spec *spec_arr = data->spec_arr;
 	int i, rc, file_stem;
 	mode_t mode = (mode_t)type;
 	const char *buf;
-	struct spec *ret = NULL;
 	char *clean_key = NULL;
 	const char *prev_slash, *next_slash;
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
+	const struct spec **result = NULL;
+	if (match_count) {
+		*match_count = 0;
+		result = calloc(data->nspec, sizeof(struct spec*));
+	} else {
+		result = calloc(1, sizeof(struct spec*));
+	}
+	if (!result) {
+		selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
+			    data->nspec * sizeof(struct spec*));
+		goto finish;
+	}
+
 	if (!data->nspec) {
 		errno = ENOENT;
 		goto finish;
@@ -899,18 +915,33 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 		 * specified or if the mode matches the file mode then we do
 		 * a regex check        */
 		if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
-		    (!mode || !spec->mode || mode == spec->mode)) {
+				(!mode || !spec->mode || mode == spec->mode)) {
 			if (compile_regex(data, spec, NULL) < 0)
 				goto finish;
 			if (spec->stem_id == -1)
 				rc = regex_match(spec->regex, key, partial);
 			else
 				rc = regex_match(spec->regex, buf, partial);
-			if (rc == REGEX_MATCH) {
-				spec->matches++;
-				break;
-			} else if (partial && rc == REGEX_MATCH_PARTIAL)
+
+			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
+				if (rc == REGEX_MATCH) {
+					spec->matches++;
+				}
+
+				if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
+					errno = ENOENT;
+					goto finish;
+				}
+
+				if (match_count) {
+					result[*match_count] = spec;
+					*match_count += 1;
+					// Continue to find all the matches.
+					continue;
+				}
+				result[0] = spec;
 				break;
+			}
 
 			if (rc == REGEX_NO_MATCH)
 				continue;
@@ -921,19 +952,58 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 		}
 	}
 
-	if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
-		/* No matching specification. */
-		errno = ENOENT;
-		goto finish;
-	}
-
-	errno = 0;
-	ret = &spec_arr[i];
-
 finish:
 	free(clean_key);
 	free(sub);
-	return ret;
+	if (result && !result[0]) {
+		free(result);
+		result = NULL;
+	}
+	return result;
+}
+
+static struct spec *lookup_common(struct selabel_handle *rec,
+                                  const char *key,
+                                  int type,
+                                  bool partial) {
+	const struct spec **matches = lookup_all(rec, key, type, partial, NULL);
+	if (!matches) {
+		return NULL;
+	}
+	struct spec *result = (struct spec*)matches[0];
+	free(matches);
+	return result;
+}
+
+static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
+{
+	assert(digest);
+
+	size_t total_matches;
+	const struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
+	if (!matches) {
+		return false;
+	}
+
+	Sha1Context context;
+	Sha1Initialise(&context);
+	size_t i;
+	for (i = 0; i < total_matches; i++) {
+		char* regex_str = matches[i]->regex_str;
+		mode_t mode = matches[i]->mode;
+		char* ctx_raw = matches[i]->lr.ctx_raw;
+
+		Sha1Update(&context, regex_str, strlen(regex_str) + 1);
+		Sha1Update(&context, &mode, sizeof(mode_t));
+		Sha1Update(&context, ctx_raw, strlen(ctx_raw) + 1);
+	}
+
+	SHA1_HASH sha1_hash;
+	Sha1Finalise(&context, &sha1_hash);
+	memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
+
+	free(matches);
+	return true;
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
@@ -1133,6 +1203,7 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_stats = &stats;
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
+	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
 	rec->func_lookup_best_match = &lookup_best_match;
 	rec->func_cmp = &cmp;
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 0e020557..1fa5ade6 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -87,6 +87,8 @@ struct selabel_handle {
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
 	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
+	bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
+	                                       const char *key, uint8_t *digest);
 	struct selabel_lookup_rec *(*func_lookup_best_match)
 						    (struct selabel_handle *h,
 						    const char *key,
-- 
2.21.0.360.g471c308f928-goog

