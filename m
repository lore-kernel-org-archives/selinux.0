Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979DC04A6A
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjHNNVo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHNNVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA110CE
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdcade7fbso562109566b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019256; x=1692624056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9sB/i+fJ2D8NRrEogkLTLeWWVpbDLi6FEgRZblUVIM=;
        b=LDgIg5Udn5UUr3Xki2PJQhIBmx2AX4uf2Nd0z/5RFSb7o+uAKVJWkwdoduCZWRhWt6
         xBjHIZClXDtnR9AW1jmD7r6h5LoZFQ/qExmmb7dDzTpKpGCCsM/MJUBXYtR3bVBuCNe6
         hdLi6D/cocO5uepQjb0X/8mc9TXEkqWG8e+/K7163NFCzSjFOVAKq5VWK3Bxkmg1TLq8
         lOJHjq9XPeIH8WFobopDIz6CK3t87lSatUhbd0bVXwHvpF2BE+iVwKAHx9aul04b8GIm
         qhYC7AczSLarYvRadsPSye5Boz7dHqyfcLnGWQ1oHSXpiuy91Hf0HhLhKAKzQMSDwG3o
         liJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019256; x=1692624056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9sB/i+fJ2D8NRrEogkLTLeWWVpbDLi6FEgRZblUVIM=;
        b=WqG0pQbbuiDfCoUtGsyxJ1fxz44auMVIXE/VlyyLDWp2tFo4eq6qLt39G7xLmGtkfl
         k2ktmnPwTjVuyHZm2ZxJjZ96HDM4/Y7y3UJod+uJ8vGOpZEHOFimh2p1EcTXF4wsCWIo
         jkY4RTdPFYKPVyNqHy8fwdIao+8KqAOdODHREsyehD/oo1iP5JLP4VHeXJZE5eGScdsQ
         yYQ0UGiwV0kPvRet+FWsh+pwcucnkC3AZ16mH1NEEsB93Tnz9RiepRPrcscQEa9UnuZw
         K3J4WIqr6I0PGL5E68GVOnYtWiDnb6eaVWXlBilUMPjEIL61w0ZvC/kSJCc/4sr6BARz
         jNNQ==
X-Gm-Message-State: AOJu0YxHgotVyePjXFvb+Trr+MOvHgZoibh6RZQPC/DVQtzYIDap1ykB
        Ey+tbPfGGfGhuv6oIODkUJBlopN+M54lmuliVYY=
X-Google-Smtp-Source: AGHT+IHz3ZzqHZJ9ggoSTaYwbUqioWBWuUoojPh9UDGE2PK+/EHUm4QaFEbL6pOHjKPYH9pklRzODA==
X-Received: by 2002:a17:906:3f12:b0:99c:5623:a8fb with SMTP id c18-20020a1709063f1200b0099c5623a8fbmr8408181ejj.18.1692019256264;
        Mon, 14 Aug 2023 06:20:56 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Evgeny Vereshchagin <evverx@gmail.com>
Subject: [RFC PATCH v2 27/27] libselinux: add selabel_file(5) fuzzer
Date:   Mon, 14 Aug 2023 15:20:25 +0200
Message-Id: <20230814132025.45364-28-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add two fuzzer reading and performing lookup on selabel_file(5)
databases.  One fuzzer takes input in form of a textual fcontext
definition, the other one takes compiled fcontexts definitions.  The
lookup key and whether to lookup any or a specific file type is also
part of the generated input.

CC: Evgeny Vereshchagin <evverx@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/fuzz/input                         |   0
 .../fuzz/selabel_file_compiled-fuzzer.c       | 279 ++++++++++++++++++
 libselinux/fuzz/selabel_file_text-fuzzer.c    | 223 ++++++++++++++
 libselinux/src/label_file.c                   |  36 ++-
 libselinux/src/label_file.h                   |  17 ++
 scripts/oss-fuzz.sh                           |  25 ++
 6 files changed, 561 insertions(+), 19 deletions(-)
 create mode 100644 libselinux/fuzz/input
 create mode 100644 libselinux/fuzz/selabel_file_compiled-fuzzer.c
 create mode 100644 libselinux/fuzz/selabel_file_text-fuzzer.c

diff --git a/libselinux/fuzz/input b/libselinux/fuzz/input
new file mode 100644
index 00000000..e69de29b
diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
new file mode 100644
index 00000000..cd0b41d7
--- /dev/null
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -0,0 +1,279 @@
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+
+#include "../src/label_file.h"
+
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+#define MEMFD_FILE_NAME "file_contexts"
+#define CTRL_PARTIAL  (1U << 0)
+#define CTRL_FIND_ALL (1U << 1)
+#define CTRL_MODE     (1U << 2)
+
+
+__attribute__ ((format(printf, 2, 3)))
+static int null_log(int type __attribute__((unused)), const char *fmt __attribute__((unused)), ...)
+{
+	return 0;
+}
+
+static int validate_context(char **ctxp)
+{
+	assert(strcmp(*ctxp, "<<none>>") != 0);
+
+	if (*ctxp[0] == '\0') {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int write_full(int fd, const void *data, size_t size)
+{
+	ssize_t rc;
+	const unsigned char *p = data;
+
+	while (size > 0) {
+		rc = write(fd, p, size);
+		if (rc == -1) {
+			if (errno == EINTR)
+				continue;
+
+			return -1;
+		}
+
+		p += rc;
+		size -= rc;
+	}
+
+	return 0;
+}
+
+static FILE* convert_data(const uint8_t *data, size_t size)
+{
+	FILE* stream;
+	int fd, rc;
+
+	fd = memfd_create(MEMFD_FILE_NAME, MFD_CLOEXEC);
+	if (fd == -1)
+		return NULL;
+
+	rc = write_full(fd, data, size);
+	if (rc == -1) {
+		close(fd);
+		return NULL;
+	}
+
+	stream = fdopen(fd, "r");
+	if (!stream) {
+		close(fd);
+		return NULL;
+	}
+
+	rc = fseek(stream, 0L, SEEK_SET);
+	if (rc == -1) {
+		fclose(stream);
+		return NULL;
+	}
+
+	return stream;
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct selabel_handle rec;
+	struct saved_data sdata = {};
+	struct spec_node *root = NULL;
+	FILE* fp = NULL;
+	struct lookup_result *result = NULL;
+	uint8_t control;
+	uint8_t *fcontext_data1 = NULL, *fcontext_data2 = NULL, *fcontext_data3 = NULL;
+	char *key = NULL;
+	size_t fcontext_data1_len, fcontext_data2_len, fcontext_data3_len, key_len;
+	bool partial, find_all;
+	mode_t mode;
+	int rc;
+
+	/*
+	 * Treat first byte as control byte, whether to use partial mode, find all matches or mode to lookup
+	 */
+	if (size == 0)
+		return 0;
+
+	control = data[0];
+	data++;
+	size--;
+
+	if (control & ~(CTRL_PARTIAL | CTRL_FIND_ALL | CTRL_MODE))
+		return 0;
+
+	partial  = control & CTRL_PARTIAL;
+	find_all = control & CTRL_FIND_ALL;
+	/* S_IFSOCK has the highest integer value */
+	mode     = (control & CTRL_MODE) ? S_IFSOCK : 0;
+
+
+	/*
+	 * Split the fuzzer input into up to four pieces: one to three compiled fcontext
+	 * definitions (to mimic file_contexts, file_contexts.homedirs and file_contexts.local,
+	 * and the lookup key
+	 */
+	const unsigned char separator[4] = { 0xde, 0xad, 0xbe, 0xef };
+	const uint8_t *sep = memmem(data, size, separator, 4);
+	if (!sep || sep == data)
+		return 0;
+
+	fcontext_data1_len = sep - data;
+	fcontext_data1 = malloc(fcontext_data1_len);
+	if (!fcontext_data1)
+		goto cleanup;
+
+	memcpy(fcontext_data1, data, fcontext_data1_len);
+	data += fcontext_data1_len + 4;
+	size -= fcontext_data1_len + 4;
+
+	sep = memmem(data, size, separator, 4);
+	if (sep) {
+		fcontext_data2_len = sep - data;
+		fcontext_data2 = malloc(fcontext_data2_len);
+		if (!fcontext_data2)
+			goto cleanup;
+
+		memcpy(fcontext_data2, data, fcontext_data2_len);
+		data += fcontext_data2_len + 4;
+		size -= fcontext_data2_len + 4;
+	}
+
+	sep = memmem(data, size, separator, 4);
+	if (sep) {
+		fcontext_data3_len = sep - data;
+		fcontext_data3 = malloc(fcontext_data3_len);
+		if (!fcontext_data3)
+			goto cleanup;
+
+		memcpy(fcontext_data3, data, fcontext_data3_len);
+		data += fcontext_data3_len + 4;
+		size -= fcontext_data3_len + 4;
+	}
+
+	key_len = size;
+	key = malloc(key_len + 1);
+	if (!key)
+		goto cleanup;
+
+	memcpy(key, data, key_len);
+	key[key_len] = '\0';
+
+
+	/*
+	 * Mock selabel handle
+	 */
+	rec = (struct selabel_handle) {
+		.backend = SELABEL_CTX_FILE,
+		.validating = 1,
+		.data = &sdata,
+	};
+
+	selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = &null_log });
+	/* validate to pre-compile regular expressions */
+	selinux_set_callback(SELINUX_CB_VALIDATE, (union selinux_callback) { .func_validate = &validate_context });
+
+	root = calloc(1, sizeof(*root));
+	if (!root)
+		goto cleanup;
+
+	sdata.root = root;
+
+	fp = convert_data(fcontext_data1, fcontext_data1_len);
+	if (!fp)
+		goto cleanup;
+
+	errno = 0;
+	rc = load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	fclose(fp);
+
+	fp = convert_data(fcontext_data2, fcontext_data2_len);
+	if (!fp)
+		goto cleanup;
+
+	errno = 0;
+	rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	fclose(fp);
+
+	fp = convert_data(fcontext_data3, fcontext_data3_len);
+	if (!fp)
+		goto cleanup;
+
+	errno = 0;
+	rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	sort_specs(&sdata);
+
+	errno = 0;
+	result = lookup_all(&rec, key, mode, partial, find_all);
+
+	if (!result)
+		assert(errno != 0);
+
+	for (const struct lookup_result *res = result; res; res = res->next) {
+		assert(res->regex_str);
+		assert(res->regex_str[0] != '\0');
+		assert(res->lr->ctx_raw);
+		assert(res->lr->ctx_raw[0] != '\0');
+		assert(strcmp(res->lr->ctx_raw, "<<none>>") != 0);
+		assert(!res->lr->ctx_trans);
+		assert(res->lr->validated);
+		assert(res->prefix_len <= strlen(res->regex_str));
+	}
+
+
+cleanup:
+	free_lookup_result(result);
+	if (fp)
+		fclose(fp);
+	if (sdata.root) {
+		free_spec_node(sdata.root);
+		free(sdata.root);
+	}
+
+	{
+		struct mmap_area *area, *last_area;
+
+		area = sdata.mmap_areas;
+		while (area) {
+			rc = munmap(area->addr, area->len);
+			assert(rc == 0);
+			last_area = area;
+			area = area->next;
+			free(last_area);
+		}
+	}
+
+	free(key);
+	free(fcontext_data3);
+	free(fcontext_data2);
+	free(fcontext_data1);
+
+	/* Non-zero return values are reserved for future use. */
+	return 0;
+}
diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz/selabel_file_text-fuzzer.c
new file mode 100644
index 00000000..fd25078f
--- /dev/null
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -0,0 +1,223 @@
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+
+#include "../src/label_file.h"
+
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+#define MEMFD_FILE_NAME "file_contexts"
+#define CTRL_PARTIAL  (1U << 0)
+#define CTRL_FIND_ALL (1U << 1)
+#define CTRL_MODE     (1U << 2)
+
+
+__attribute__ ((format(printf, 2, 3)))
+static int null_log(int type __attribute__((unused)), const char *fmt __attribute__((unused)), ...)
+{
+	return 0;
+}
+
+static int validate_context(char **ctxp)
+{
+	assert(strcmp(*ctxp, "<<none>>") != 0);
+
+	if (*ctxp[0] == '\0') {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int write_full(int fd, const void *data, size_t size)
+{
+	ssize_t rc;
+	const unsigned char *p = data;
+
+	while (size > 0) {
+		rc = write(fd, p, size);
+		if (rc == -1) {
+			if (errno == EINTR)
+				continue;
+
+			return -1;
+		}
+
+		p += rc;
+		size -= rc;
+	}
+
+	return 0;
+}
+
+static FILE* convert_data(const uint8_t *data, size_t size)
+{
+	FILE* stream;
+	int fd, rc;
+
+	fd = memfd_create(MEMFD_FILE_NAME, MFD_CLOEXEC);
+	if (fd == -1)
+		return NULL;
+
+	rc = write_full(fd, data, size);
+	if (rc == -1) {
+		close(fd);
+		return NULL;
+	}
+
+	stream = fdopen(fd, "r");
+	if (!stream) {
+		close(fd);
+		return NULL;
+	}
+
+	rc = fseek(stream, 0L, SEEK_SET);
+	if (rc == -1) {
+		fclose(stream);
+		return NULL;
+	}
+
+	return stream;
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct selabel_handle rec;
+	struct saved_data sdata = {};
+	struct spec_node *root = NULL;
+	FILE* fp = NULL;
+	struct lookup_result *result = NULL;
+	uint8_t control;
+	uint8_t *fcontext_data = NULL;
+	char *key = NULL;
+	size_t fcontext_data_len, key_len;
+	bool partial, find_all;
+	mode_t mode;
+	int rc;
+
+	/*
+	 * Treat first byte as control byte, whether to use partial mode, find all matches or mode to lookup
+	 */
+	if (size == 0)
+		return 0;
+
+	control = data[0];
+	data++;
+	size--;
+
+	if (control & ~(CTRL_PARTIAL | CTRL_FIND_ALL | CTRL_MODE))
+		return 0;
+
+	partial  = control & CTRL_PARTIAL;
+	find_all = control & CTRL_FIND_ALL;
+	/* S_IFSOCK has the highest integer value */
+	mode     = (control & CTRL_MODE) ? S_IFSOCK : 0;
+
+
+	/*
+	 * Split the fuzzer input into two pieces: the textual fcontext definition and the lookup key
+	 */
+	const unsigned char separator[4] = { 0xde, 0xad, 0xbe, 0xef };
+	const uint8_t *sep = memmem(data, size, separator, 4);
+	if (!sep || sep == data)
+		return 0;
+
+	fcontext_data_len = sep - data;
+	fcontext_data = malloc(fcontext_data_len);
+	if (!fcontext_data)
+		goto cleanup;
+
+	memcpy(fcontext_data, data, fcontext_data_len);
+
+	key_len = size - fcontext_data_len - 4;
+	key = malloc(key_len + 1);
+	if (!key)
+		goto cleanup;
+
+	memcpy(key, sep + 4, key_len);
+	key[key_len] = '\0';
+
+
+	/*
+	 * Mock selabel handle
+	 */
+	rec = (struct selabel_handle) {
+		.backend = SELABEL_CTX_FILE,
+		.validating = 1,
+		.data = &sdata,
+	};
+
+	selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = &null_log });
+	/* validate to pre-compile regular expressions */
+	selinux_set_callback(SELINUX_CB_VALIDATE, (union selinux_callback) { .func_validate = &validate_context });
+
+	root = calloc(1, sizeof(*root));
+	if (!root)
+		goto cleanup;
+
+	sdata.root = root;
+
+	fp = convert_data(fcontext_data, fcontext_data_len);
+	if (!fp)
+		goto cleanup;
+
+	errno = 0;
+	rc = process_text_file(fp, &rec, MEMFD_FILE_NAME);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	sort_specs(&sdata);
+
+	errno = 0;
+	result = lookup_all(&rec, key, mode, partial, find_all);
+
+	if (!result)
+		assert(errno != 0);
+
+	for (const struct lookup_result *res = result; res; res = res->next) {
+		assert(res->regex_str);
+		assert(res->regex_str[0] != '\0');
+		assert(res->lr->ctx_raw);
+		assert(res->lr->ctx_raw[0] != '\0');
+		assert(strcmp(res->lr->ctx_raw, "<<none>>") != 0);
+		assert(!res->lr->ctx_trans);
+		assert(res->lr->validated);
+		assert(res->prefix_len <= strlen(res->regex_str));
+	}
+
+
+cleanup:
+	free_lookup_result(result);
+	if (fp)
+		fclose(fp);
+	if (sdata.root) {
+		free_spec_node(sdata.root);
+		free(sdata.root);
+	}
+
+	{
+		struct mmap_area *area, *last_area;
+
+		area = sdata.mmap_areas;
+		while (area) {
+			rc = munmap(area->addr, area->len);
+			assert(rc == 0);
+			last_area = area;
+			area = area->next;
+			free(last_area);
+		}
+	}
+
+	free(key);
+	free(fcontext_data);
+
+	/* Non-zero return values are reserved for future use. */
+	return 0;
+}
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index bb4b7130..60510551 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -26,6 +26,13 @@
 #include "label_file.h"
 
 
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+# define FUZZ_EXTERN
+#else
+# define FUZZ_EXTERN static
+#endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
+
+
 /*
  * Warn about duplicate specifications.
  */
@@ -113,8 +120,8 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 	return rc;
 }
 
-static int process_text_file(FILE *fp,
-			     struct selabel_handle *rec, const char *path)
+FUZZ_EXTERN int process_text_file(FILE *fp,
+				  struct selabel_handle *rec, const char *path)
 {
 	int rc;
 	size_t line_len;
@@ -669,8 +676,8 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 	return 0;
 }
 
-static int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
-		     const char *path)
+FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
+			  const char *path)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct spec_node *root = NULL;
@@ -1363,16 +1370,7 @@ static uint32_t search_literal_spec(const struct literal_spec *array, uint32_t s
 	return (uint32_t)-1;
 }
 
-struct lookup_result {
-	const char *regex_str;
-	struct selabel_lookup_rec *lr;
-	mode_t mode;
-	bool has_meta_chars;
-	uint16_t prefix_len;
-	struct lookup_result *next;
-};
-
-static void free_lookup_result(struct lookup_result *result)
+FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 {
 	struct lookup_result *tmp;
 
@@ -1577,11 +1575,11 @@ static struct spec_node* lookup_find_deepest_node(struct spec_node *node, const
 // Finds all the matches of |key| in the given context. Returns the result in
 // the allocated array and updates the match count. If match_count is NULL,
 // stops early once the 1st match is found.
-static struct lookup_result *lookup_all(struct selabel_handle *rec,
-					const char *key,
-					int type,
-					bool partial,
-					bool find_all)
+FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
+				 const char *key,
+				 int type,
+				 bool partial,
+				 bool find_all)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct lookup_result *result = NULL;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index ee01defe..8e4824e8 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -40,6 +40,23 @@
 /* Required selinux_restorecon and selabel_get_digests_all_partial_matches() */
 #define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
 
+/* Only exported for fuzzing*/
+struct lookup_result {
+	const char *regex_str;
+	struct selabel_lookup_rec *lr;
+	mode_t mode;
+	bool has_meta_chars;
+	uint16_t prefix_len;
+	struct lookup_result *next;
+};
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
+extern int process_text_file(FILE *fp, struct selabel_handle *rec, const char *path);
+extern void free_lookup_result(struct lookup_result *result);
+extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all);
+#endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
+
+
 struct selabel_sub {
 	char *src;
 	unsigned int slen;
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 72d275e8..e51efe74 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -44,10 +44,13 @@ export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
 
 rm -rf "$DESTDIR"
 make -C libsepol clean
+make -C libselinux clean
 # LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
 # has been read by make
 # shellcheck disable=SC2016
 make -C libsepol V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=$(LIBMAP)' -j"$(nproc)" install
+# shellcheck disable=SC2016
+make -C libselinux V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=libselinux.map' -j"$(nproc)" install
 
 ## secilc fuzzer ##
 
@@ -70,3 +73,25 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/binpolicy-fuzzer.c
 $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/binpolicy-fuzzer"
 
 zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
+
+## selabel-file text fcontext based fuzzer ##
+
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_text-fuzzer.o libselinux/fuzz/selabel_file_text-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_text-fuzzer"
+
+zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
+
+## selabel-file compiled fcontext based fuzzer ##
+
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_compiled-fuzzer.o libselinux/fuzz/selabel_file_compiled-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_compiled-fuzzer"
+
+zip -j "$OUT/selabel_file_compiled-fuzzer_seed_corpus.zip" libselinux/fuzz/input
-- 
2.40.1

