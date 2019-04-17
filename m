Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F5C282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01D20663
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kyDgk5fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDQSKI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:10:08 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48659 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQSKI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 14:10:08 -0400
Received: by mail-ua1-f73.google.com with SMTP id j45so3482984uag.15
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=46awXYwpWdLPLOz8Ei3XYBreuCDEFgFgnT4C8KML+Jg=;
        b=kyDgk5fBzmHKLFPh12I0/DtVX/WoGB+asBMC+bu7cV1fp6HRpgOusq5EPjVsfZD+n3
         GwbwmWUeawJYF/xnuQfkd9iVr+SazRYhuBz8r1cD2s9L/onxcP8wx3d4sHdAbhgxtVra
         fL+nRvWtuvA8EP+yoUmv5Mzm+PZ3dMHItg0+3vu1RbsNvFNJ6ZKjsb2chC6aKotrro0Z
         +EaeOXKJZHsGardmOxvim+8lzxk7bPOq0qbk88CCMP6MbczbYGMFqBzdeoQ1vYErou23
         1zpGylHdKNjo0tQo4gcVdKNCz+EoO2geMj//diTL0o0NQnNmMdLb5KCgXnblykc1SEX3
         sUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=46awXYwpWdLPLOz8Ei3XYBreuCDEFgFgnT4C8KML+Jg=;
        b=aA3lly5zKwwL7Ws/qWfDq6cza5/AFAszmYixx8AaZoOWg3j/RyunVbTsmbbvF+pHJl
         pU7L/EfVbrGSie6bM78n+6SCoDg1IqgOG2LnH/I3orxH8NwdhUPfBGpf7HMs/SKlcIJo
         LU3bGOzpEXgmwSAXPHSl4c6m6dZEpFNsmlOl5zBVztO0xIR4DgfQIKnvQ9PVB6gaORXn
         4bH+CpOh3dHb1dHnZxwQtMLVd8uMnpopOFXMytVT/Rzf+SsWKm6Xyxss05vlqlkWZRv5
         +E3TxF+/NA6L3fUpgXcwUimtVnpjrq6eLH7O6mcn8Uc+3cGVH1HE9LprYtApuvcnV6Jz
         4q8A==
X-Gm-Message-State: APjAAAUx2Oqta4UZ1gqsZx1nLQdoVGyX+cqQEMzGRojE6AFjhY8auFaW
        NotjrSUtV9dcJB/lTWXpDpmIKrkECWNV/iQUgtxgkFA7hzJrHlczdLwyfEwWgTgGanlGOSpmrCw
        2MjuCK70XmeqXdiTEn6IYHcYXSDuCgrqnr7XGykrY8PgZtewSS2nHQnb64p8yXIQ0GD/q
X-Google-Smtp-Source: APXvYqy0olESAETpuYVjaSnQnpIspoU2aAUrkQp4CGTs/mRHqArOQBjlSUX1e9K7+ofLIzCAlkhQKMt7ZPWOlw==
X-Received: by 2002:a67:7cd1:: with SMTP id x200mr44644289vsc.32.1555524606717;
 Wed, 17 Apr 2019 11:10:06 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:09:55 -0700
Message-Id: <20190417180955.136942-1-xunchang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] libselinux: Ignore the stem when looking up all matches in
 file context
From:   xunchang <xunchang@google.com>
To:     selinux@vger.kernel.org
Cc:     xunchang <xunchang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a follow up fix to the restorecon change in
commit 6ab5fbaabc84f7093b37c1afae855292e918090f This change has been
tested in android for a while.

The stem is a list of top level directory (without regex metachar)
covered in the file context. And it constructs from finding the
second '/' in the regex_string; and aims to speed up the lookup by
skipping unnecessary regex matches. More contexts in
https://lore.kernel.org/selinux/200309231522.25749.russell@coker.com.au/

However, this caused some issue when we try to find all the partial
matches for a root directory. For example, the path "/data" doesn't
have a stem while the regex "/data/misc/(/.*)?" has "/data" as the
stem. As a result, all the regex for the subdirs of /data will not
considered as a match for "/data". And the restorecon will wrongly
skip on top level "/data" when there's a context change to one of
subdir.

This CL always includes the stem when compiling the regex in all
circumstances. Also, it ignores the stem id check in the "match all"
case, while the behavior for the single match stays unchanged. I will
collect more data to find out if stem id check is still necessary at
all with the new restorecon logic.

Test: run restorecon on "/data"; change the context of one subdir and
run again, and the context is restored on that subdir; search the caller
of regex_match

Signed-off-by: Tianjie Xu <xunchang@google.com>
---
 libselinux/src/label_file.c | 27 ++++++++++++---------------
 libselinux/src/label_file.h | 10 ++--------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 90cbd666..37b037a0 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -39,18 +39,17 @@ static int get_stem_from_file_name(const char *const buf)
 
 /* find the stem of a file name, returns the index into stem_arr (or -1 if
  * there is no match - IE for a file in the root directory or a regex that is
- * too complex for us).  Makes buf point to the text AFTER the stem. */
-static int find_stem_from_file(struct saved_data *data, const char **buf)
+ * too complex for us). */
+static int find_stem_from_file(struct saved_data *data, const char *key)
 {
 	int i;
-	int stem_len = get_stem_from_file_name(*buf);
+	int stem_len = get_stem_from_file_name(key);
 
 	if (!stem_len)
 		return -1;
 	for (i = 0; i < data->num_stems; i++) {
 		if (stem_len == data->stem_arr[i].len
-		    && !strncmp(*buf, data->stem_arr[i].buf, stem_len)) {
-			*buf += stem_len;
+		    && !strncmp(key, data->stem_arr[i].buf, stem_len)) {
 			return i;
 		}
 	}
@@ -856,7 +855,6 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 	struct spec *spec_arr = data->spec_arr;
 	int i, rc, file_stem;
 	mode_t mode = (mode_t)type;
-	const char *buf;
 	char *clean_key = NULL;
 	const char *prev_slash, *next_slash;
 	unsigned int sofar = 0;
@@ -900,8 +898,7 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 	if (sub)
 		key = sub;
 
-	buf = key;
-	file_stem = find_stem_from_file(data, &buf);
+	file_stem = find_stem_from_file(data, key);
 	mode &= S_IFMT;
 
 	/*
@@ -914,15 +911,15 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 		 * stem as the file AND if the spec in question has no mode
 		 * specified or if the mode matches the file mode then we do
 		 * a regex check        */
-		if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
+		bool stem_matches = spec->stem_id == -1 || spec->stem_id == file_stem;
+		// Don't check the stem if we want to find partial matches.
+                // Otherwise the case "/abc/efg/(/.*)?" will be considered
+                //a miss for "/abc".
+		if ((partial || stem_matches) &&
 				(!mode || !spec->mode || mode == spec->mode)) {
-			if (compile_regex(data, spec, NULL) < 0)
+			if (compile_regex(spec, NULL) < 0)
 				goto finish;
-			if (spec->stem_id == -1)
-				rc = regex_match(spec->regex, key, partial);
-			else
-				rc = regex_match(spec->regex, buf, partial);
-
+			rc = regex_match(spec->regex, key, partial);
 			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
 				if (rc == REGEX_MATCH) {
 					spec->matches++;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 47859baf..6f4ee101 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -336,13 +336,11 @@ static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
 	return 0;
 }
 
-static inline int compile_regex(struct saved_data *data, struct spec *spec,
-					    const char **errbuf)
+static inline int compile_regex(struct spec *spec, const char **errbuf)
 {
 	char *reg_buf, *anchored_regex, *cp;
 	struct regex_error_data error_data;
 	static char regex_error_format_buffer[256];
-	struct stem *stem_arr = data->stem_arr;
 	size_t len;
 	int rc;
 	bool regex_compiled;
@@ -379,11 +377,7 @@ static inline int compile_regex(struct saved_data *data, struct spec *spec,
 		return 0;
 	}
 
-	/* Skip the fixed stem. */
 	reg_buf = spec->regex_str;
-	if (spec->stem_id >= 0)
-		reg_buf += stem_arr[spec->stem_id].len;
-
 	/* Anchor the regular expression. */
 	len = strlen(reg_buf);
 	cp = anchored_regex = malloc(len + 3);
@@ -501,7 +495,7 @@ static inline int process_line(struct selabel_handle *rec,
 	data->nspec++;
 
 	if (rec->validating
-			&& compile_regex(data, &spec_arr[nspec], &errbuf)) {
+			&& compile_regex(&spec_arr[nspec], &errbuf)) {
 		COMPAT_LOG(SELINUX_ERROR,
 			   "%s:  line %u has invalid regex %s:  %s\n",
 			   path, lineno, regex, errbuf);
-- 
2.21.0.593.g511ec345e18-goog

