Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2DC41513
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHNNVN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHNNVB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BF1722
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso575376266b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019250; x=1692624050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMXhmSjjU0BUkSzUeTbPfordFh728nv3OcCPvR1zI+0=;
        b=pxnjmHuuCPYmWL1ubnci8b3PTnAhOVWq5Jm0XQfoKXOEFcUsAN/HGHHY6rjAN/oog6
         mSVXaIoXDk7dOWPVNw6oL1cQ1z+9tKk7FJroeUxkuy+zFSK3mSPg31yrCPcwFSelCibT
         wygD1z5k93NDaFD/3m8OEXL7RjjxhFrmBITBSCpBRT6404mV0USasZTZymPxIIp18XY/
         5jvPFJXqQYm16JzMawWKPx3fFz3ut8ItBsxEbgGHWdhr6bDXIXxuWAbLAy3H+PXVWpl7
         C9+KRRUZPJeJ6MQKAstx/dRXGVm/gvo+iM+Ve1qQSB3Qvow6JM21+PUEmqweGFfMubJH
         SyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019250; x=1692624050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMXhmSjjU0BUkSzUeTbPfordFh728nv3OcCPvR1zI+0=;
        b=jXLeuijk4zimr8yuUDJ2WhTfHTWKFgz93WLKNFd6yHSg2on5lm90xzhtJoWDZ+9Bql
         R9c3W5FU5EwIy+lqxy+Q2rmIy8pel4O8Wpd0Chk/qqdRUIGX9CEDXAQs2YjfGv0ClozG
         7BHgp3xg6QXJxOyH27MAp7F7WW2t7ndeyJZSeCvwAkv1ELwXvkNT2KHEqr1zfQTY9NfZ
         l+O1YR7qLYQZVt7nSPsJF1MJHD/hAq3sNGjmuLW+sV4+NAlQZaTwzmoiTnA81cUJT0NL
         hOls3ptXRTxcLy8WaPZmcblr+w76Owe6LDnhxXxqt1QUaYwOOmBjic6ApWV7v+LoAG0K
         X8DQ==
X-Gm-Message-State: AOJu0YzpT8UXwmdqfVOG1RBYb5k3jw0D3KIONqBNAyiBDInh7CKktoTe
        83dOSES/JOGSlB4Q5KtYwYssFmjxfkQO8tQmEC4=
X-Google-Smtp-Source: AGHT+IHapC3tcZI39DoW+vc12OIOtuPcasqUkcuexSRRDVFzjuLjYMKpd/tqD5ObfeNvTO+ZI7jk1A==
X-Received: by 2002:a17:906:73dc:b0:99d:101b:8403 with SMTP id n28-20020a17090673dc00b0099d101b8403mr7679791ejl.36.1692019249870;
        Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 17/27] libselinux: remove SELABEL_OPT_SUBSET support from selabel_file(5)
Date:   Mon, 14 Aug 2023 15:20:15 +0200
Message-Id: <20230814132025.45364-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The selabel_file(5) option SELABEL_OPT_SUBSET has been deprecated in
commit 26e05da0fc2d ("libselinux: matchpathcon/selabel_file: Fix man
pages.") for version 2.5.

Drop the support to easy refactoring the selabel_file related code.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/label.h    |  2 +-
 libselinux/include/selinux/selinux.h  |  6 +++++-
 libselinux/src/Makefile               |  4 ++++
 libselinux/src/label_file.c           | 19 ++++++++-----------
 libselinux/src/label_file.h           | 13 ++-----------
 libselinux/src/matchpathcon.c         |  4 +---
 libselinux/utils/matchpathcon.c       | 11 ++---------
 libselinux/utils/sefcontext_compile.c |  3 +--
 8 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index ce189a3a..6cb2d782 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -50,7 +50,7 @@ struct selabel_handle;
 #define SELABEL_OPT_BASEONLY	2
 /* specify an alternate path to use when loading backend data */
 #define SELABEL_OPT_PATH	3
-/* select a subset of the search space as an optimization (file backend) */
+/* Unsupported since v3.6: select a subset of the search space as an optimization (file backend) */
 #define SELABEL_OPT_SUBSET	4
 /* require a hash calculation on spec files */
 #define SELABEL_OPT_DIGEST	5
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index a0948853..3b23cb50 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -484,7 +484,11 @@ extern int matchpathcon_init(const char *path)
 
 /* Same as matchpathcon_init, but only load entries with
    regexes that have stems that are prefixes of 'prefix'. */
-extern int matchpathcon_init_prefix(const char *path, const char *prefix);
+extern int matchpathcon_init_prefix(const char *path, const char *prefix)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_CTX_FILE")))
+#endif
+;
 
 /* Free the memory allocated by matchpathcon_init. */
 extern void matchpathcon_fini(void)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac656257..15d224e1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -144,6 +144,10 @@ ifeq ($(DISABLE_X11),y)
 SRCS:= $(filter-out label_x.c, $(SRCS))
 endif
 
+# ignore usage of matchpathcon_init_prefix(3)
+matchpathcon.o:  CFLAGS += -Wno-deprecated -Wno-deprecated-declarations
+matchpathcon.lo: CFLAGS += -Wno-deprecated -Wno-deprecated-declarations
+
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b9be1c9d..f9f4648a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -166,7 +166,7 @@ static int nodups_specs(struct saved_data *data, const char *path)
 	return rc;
 }
 
-static int process_text_file(FILE *fp, const char *prefix,
+static int process_text_file(FILE *fp,
 			     struct selabel_handle *rec, const char *path)
 {
 	int rc;
@@ -175,7 +175,7 @@ static int process_text_file(FILE *fp, const char *prefix,
 	char *line_buf = NULL;
 
 	while (getline(&line_buf, &line_len, fp) > 0) {
-		rc = process_line(rec, path, prefix, line_buf, ++lineno);
+		rc = process_line(rec, path, line_buf, ++lineno);
 		if (rc)
 			goto out;
 	}
@@ -603,7 +603,7 @@ static FILE *open_file(const char *path, const char *suffix,
 
 static int process_file(const char *path, const char *suffix,
 			  struct selabel_handle *rec,
-			  const char *prefix, struct selabel_digest *digest)
+			  struct selabel_digest *digest)
 {
 	int rc;
 	unsigned int i;
@@ -624,7 +624,7 @@ static int process_file(const char *path, const char *suffix,
 
 		rc = fcontext_is_binary(fp) ?
 				load_mmap(fp, sb.st_size, rec, found_path) :
-				process_text_file(fp, prefix, rec, found_path);
+				process_text_file(fp, rec, found_path);
 		if (!rc)
 			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
 				found_path);
@@ -785,7 +785,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	const char *path = NULL;
-	const char *prefix = NULL;
 	int status = -1, baseonly = 0;
 
 	/* Process arguments */
@@ -795,7 +794,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			path = opts[n].value;
 			break;
 		case SELABEL_OPT_SUBSET:
-			prefix = opts[n].value;
+			selinux_log(SELINUX_WARNING, "selabel_open(3): SELABEL_OPT_SUBSET support has been removed, ignoring option\n");
 			break;
 		case SELABEL_OPT_BASEONLY:
 			baseonly = !!opts[n].value;
@@ -839,7 +838,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	/*
 	 * The do detailed validation of the input and fill the spec array
 	 */
-	status = process_file(path, NULL, rec, prefix, rec->digest);
+	status = process_file(path, NULL, rec, rec->digest);
 	if (status)
 		goto finish;
 
@@ -850,13 +849,11 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 
 	if (!baseonly) {
-		status = process_file(path, "homedirs", rec, prefix,
-							    rec->digest);
+		status = process_file(path, "homedirs", rec, rec->digest);
 		if (status && errno != ENOENT)
 			goto finish;
 
-		status = process_file(path, "local", rec, prefix,
-							    rec->digest);
+		status = process_file(path, "local", rec, rec->digest);
 		if (status && errno != ENOENT)
 			goto finish;
 	}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 1363c83c..56439e2d 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -425,10 +425,10 @@ static inline int compile_regex(struct spec *spec, const char **errbuf)
 /* This service is used by label_file.c process_file() and
  * utils/sefcontext_compile.c */
 static inline int process_line(struct selabel_handle *rec,
-			const char *path, const char *prefix,
+			const char *path,
 			char *line_buf, unsigned lineno)
 {
-	int items, len, rc;
+	int items, rc;
 	char *regex = NULL, *type = NULL, *context = NULL;
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct spec *spec_arr;
@@ -466,15 +466,6 @@ static inline int process_line(struct selabel_handle *rec,
 		type = 0;
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
 	rc = grow_specs(data);
 	if (rc)
 		return rc;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index a1c5b0cc..971ace62 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -347,7 +347,7 @@ static void matchpathcon_init_once(void)
 		destructor_key_initialized = 1;
 }
 
-int matchpathcon_init_prefix(const char *path, const char *subset)
+int matchpathcon_init_prefix(const char *path, const char *prefix __attribute__((unused)))
 {
 	if (!mycanoncon)
 		mycanoncon = default_canoncon;
@@ -355,8 +355,6 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
 	__selinux_once(once, matchpathcon_init_once);
 	__selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
 
-	options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
-	options[SELABEL_OPT_SUBSET].value = subset;
 	options[SELABEL_OPT_PATH].type = SELABEL_OPT_PATH;
 	options[SELABEL_OPT_PATH].value = path;
 
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index 1d713c01..8e1c45c1 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -13,7 +13,7 @@
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
+		"usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-P policy_root_path] filepath...\n",
 		progname);
 	exit(1);
 }
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "m:Nnf:P:p:Vq")) > 0) {
+	while ((opt = getopt(argc, argv, "m:Nnf:P:Vq")) > 0) {
 		switch (opt) {
 		case 'n':
 			header = 0;
@@ -114,13 +114,6 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			break;
-		case 'p':
-			// This option has been deprecated since libselinux 2.5 (2016):
-			// https://github.com/SELinuxProject/selinux/commit/26e05da0fc2d0a4bd274320968a88f8acbb3b6a6
-			fprintf(stderr, "Warning: using %s -p is deprecated\n", argv[0]);
-			options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
-			options[SELABEL_OPT_SUBSET].value = optarg;
-			break;
 		case 'q':
 			quiet = 1;
 			break;
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 6c32172d..eed6e4fd 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -36,7 +36,6 @@ static int process_file(struct selabel_handle *rec, const char *filename)
 	char *line_buf = NULL;
 	size_t line_len = 0;
 	FILE *context_file;
-	const char *prefix = NULL;
 
 	context_file = fopen(filename, "r");
 	if (!context_file) {
@@ -48,7 +47,7 @@ static int process_file(struct selabel_handle *rec, const char *filename)
 	line_num = 0;
 	rc = 0;
 	while (getline(&line_buf, &line_len, context_file) > 0) {
-		rc = process_line(rec, filename, prefix, line_buf, ++line_num);
+		rc = process_line(rec, filename, line_buf, ++line_num);
 		if (rc || ctx_err) {
 			/* With -p option need to check and fail if ctx err as
 			 * process_line() context validation on Linux does not
-- 
2.40.1

