Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35C1DC1B7
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933670; cv=none; b=ti/cHXGjhCUOk9co774oW52doOjD/+LcgWDF1GF82M695KWcc+oWZ8NbsQxL2sNDidOF+tawKt4QJlo7UukWP4NfevY1bZ/88B0Yx1kFIXMskrTJnrUpi77SY5cs4nDw/AnAVVNK7rMqfIRjseppduKd8/OI4mVQWKxwiId+I7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933670; c=relaxed/simple;
	bh=SMcEZrET/hD1t4PdeIYKLP5avHWn2OsYzQRyr6h35qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpDNCxHHIUkNeCQiZEY0fzLeae/pa6DHcbmueH+UZWcqxnqYEaxoXyOLbhqkhiAOq9pGeKvG4t8AOQzoiOGKOkgfIQPr4cLuIV0AzNjqgj4uNLP35idjsoca0lMgV8aAprQ7mhXSUEuODfWF+OlOrza9Is4v0i5EoapxfDz8M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ1KeKXd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ1KeKXd"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3c8ef95ae5so759924276.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933667; x=1734538467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9kQU5pEmEU4M25BX9HEHJ/Qj8KCarjtkUKpKRgj0SY=;
        b=IQ1KeKXdZ6Cw6eWUlv688xSTz601nZ46c9OOtP1AKos+fa5m7h+R6i0CjuT+8L1F5C
         LEjWkUAC6swu0TQigrYmrcTRpfMvTm4CZZvpk/4xOEJy9SbbbIcKSUtBS/d5kqfMF6l/
         pDTFGr8EY3x8WopsgqC30wp1q6gcmzr0+Dup/UkWfPacl9GFSEgH0SEqyBOAJyht4ecd
         9MfORwSY6+OYjQs4PHZzAgdrt2uCVWNwprUjdBdfx/19irKkrGCPbyh7BnFZfOV7zq/d
         M/XAwxNuG8Q6p8jbLbs03eDbXpzU7K6V25oPbKBf3Kee2rMBIob9iDUaXENAyCrsY02r
         h6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933667; x=1734538467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9kQU5pEmEU4M25BX9HEHJ/Qj8KCarjtkUKpKRgj0SY=;
        b=VSouK/YN5EXqlx+pWoZ7stUrj3Ey51mQZaCmdccC5PoOYz8iVIa8aCRBCcIntePB6z
         Z1MAEd40rMcAUQInIDxOLdhZ3UGUY3+tJYXw+exjZ1QN0JrjOihuLhGg4S12eV9V8hTG
         lNkMCkO5F+XW+5/i9REX8fxWJucwU8zQKh6uTsp3uKXmk5cIjhkV+6gs3S/m+POCTP6J
         x0XVF9i/3cnhZVkRtHCpKvUr2kGc8p0p0BkFMGhufzm3zTL1yDL0afLcmoPQAZttyFEI
         +9TFrDIhrNYt4bhULoBxMhJrXGwpqBGTSDpDwGzSf7axbfpWIiKj/nfkJXFnzyunDLd7
         c9tA==
X-Gm-Message-State: AOJu0YwyESmN+XuHQfjCesfXJi+kKWfMUh41UdBmzD2C+y5NPiMDh1ZW
	p3NZpB0c/3HwL4LN9JP7Nk8ds5SQdLLqnXDJrPLAtNIBYYHuzXJqtvqjSw==
X-Gm-Gg: ASbGncupkeiKjMdoYy4hjuNSA27GsHVjdH8Uko4JInWMd7CFB1Y27zX3z21IGZF4WM5
	zuD1hcq6jweg3+d7gNEWcqUuQM5CTgPYjMVWHoGGTcmyTTWs8/CjL/2Nt8I+3wpv43KzUofiSuP
	9oUoOAnQichhLXLVyYgRvhkv2i3B51eNgTUFywDY4QwZ3be0eD3MFXywKP6fxU/+lm2IVhSaj0d
	pPBuPz9+uNmavgM0nblwafKPxwubOP28AgUnky59G/tUNwsKZ14mlTxSAPk/bVgwophkpWYkkuZ
	WEOQCWjyTcU=
X-Google-Smtp-Source: AGHT+IHQ3KEKXq+wMdq7CdI0SI5Gbemxmu+Hofapy3klPdiA5hTLn4FuEzJOWP/r9sQ88TViiDf4fg==
X-Received: by 2002:a05:690c:3342:b0:6ef:5ca3:d0d2 with SMTP id 00721157ae682-6f19e84d192mr298577b3.34.1733933666372;
        Wed, 11 Dec 2024 08:14:26 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:26 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/9] Revert "libselinux: add selabel_file(5) fuzzer"
Date: Wed, 11 Dec 2024 11:14:05 -0500
Message-ID: <20241211161417.126236-8-jwcart2@gmail.com>
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

This reverts commit 8997f54322f5648721ce42f723432a023219f02b.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/fuzz/input                         |   0
 .../fuzz/selabel_file_compiled-fuzzer.c       | 281 ------------------
 libselinux/fuzz/selabel_file_text-fuzzer.c    | 225 --------------
 libselinux/src/label_file.c                   |  38 +--
 libselinux/src/label_file.h                   |  17 --
 scripts/oss-fuzz.sh                           |  25 --
 6 files changed, 20 insertions(+), 566 deletions(-)
 delete mode 100644 libselinux/fuzz/input
 delete mode 100644 libselinux/fuzz/selabel_file_compiled-fuzzer.c
 delete mode 100644 libselinux/fuzz/selabel_file_text-fuzzer.c

diff --git a/libselinux/fuzz/input b/libselinux/fuzz/input
deleted file mode 100644
index e69de29b..00000000
diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
deleted file mode 100644
index cf0710ad..00000000
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ /dev/null
@@ -1,281 +0,0 @@
-#include <errno.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <sys/mman.h>
-#include <unistd.h>
-
-#include <selinux/label.h>
-
-#include "../src/label_file.h"
-
-extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
-
-#define MEMFD_FILE_NAME "file_contexts"
-#define CTRL_PARTIAL  (1U << 0)
-#define CTRL_FIND_ALL (1U << 1)
-#define CTRL_MODE     (1U << 2)
-
-
-__attribute__ ((format(printf, 2, 3)))
-static int null_log(int type __attribute__((unused)), const char *fmt __attribute__((unused)), ...)
-{
-	return 0;
-}
-
-static int validate_context(char **ctxp)
-{
-	assert(strcmp(*ctxp, "<<none>>") != 0);
-
-	if (*ctxp[0] == '\0') {
-		errno = EINVAL;
-		return -1;
-	}
-
-	return 0;
-}
-
-static int write_full(int fd, const void *data, size_t size)
-{
-	ssize_t rc;
-	const unsigned char *p = data;
-
-	while (size > 0) {
-		rc = write(fd, p, size);
-		if (rc == -1) {
-			if (errno == EINTR)
-				continue;
-
-			return -1;
-		}
-
-		p += rc;
-		size -= rc;
-	}
-
-	return 0;
-}
-
-static FILE* convert_data(const uint8_t *data, size_t size)
-{
-	FILE* stream;
-	int fd, rc;
-
-	fd = memfd_create(MEMFD_FILE_NAME, MFD_CLOEXEC);
-	if (fd == -1)
-		return NULL;
-
-	rc = write_full(fd, data, size);
-	if (rc == -1) {
-		close(fd);
-		return NULL;
-	}
-
-	stream = fdopen(fd, "r");
-	if (!stream) {
-		close(fd);
-		return NULL;
-	}
-
-	rc = fseek(stream, 0L, SEEK_SET);
-	if (rc == -1) {
-		fclose(stream);
-		return NULL;
-	}
-
-	return stream;
-}
-
-int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
-{
-	struct selabel_handle rec;
-	struct saved_data sdata = {};
-	struct spec_node *root = NULL;
-	FILE* fp = NULL;
-	struct lookup_result *result = NULL;
-	uint8_t control;
-	uint8_t *fcontext_data1 = NULL, *fcontext_data2 = NULL, *fcontext_data3 = NULL;
-	char *key = NULL;
-	size_t fcontext_data1_len, fcontext_data2_len, fcontext_data3_len, key_len;
-	bool partial, find_all;
-	mode_t mode;
-	int rc;
-
-	/*
-	 * Treat first byte as control byte, whether to use partial mode, find all matches or mode to lookup
-	 */
-	if (size == 0)
-		return 0;
-
-	control = data[0];
-	data++;
-	size--;
-
-	if (control & ~(CTRL_PARTIAL | CTRL_FIND_ALL | CTRL_MODE))
-		return 0;
-
-	partial  = control & CTRL_PARTIAL;
-	find_all = control & CTRL_FIND_ALL;
-	/* S_IFSOCK has the highest integer value */
-	mode     = (control & CTRL_MODE) ? S_IFSOCK : 0;
-
-
-	/*
-	 * Split the fuzzer input into up to four pieces: one to three compiled fcontext
-	 * definitions (to mimic file_contexts, file_contexts.homedirs and file_contexts.local,
-	 * and the lookup key
-	 */
-	const unsigned char separator[4] = { 0xde, 0xad, 0xbe, 0xef };
-	const uint8_t *sep = memmem(data, size, separator, 4);
-	if (!sep || sep == data)
-		return 0;
-
-	fcontext_data1_len = sep - data;
-	fcontext_data1 = malloc(fcontext_data1_len);
-	if (!fcontext_data1)
-		goto cleanup;
-
-	memcpy(fcontext_data1, data, fcontext_data1_len);
-	data += fcontext_data1_len + 4;
-	size -= fcontext_data1_len + 4;
-
-	sep = memmem(data, size, separator, 4);
-	if (sep) {
-		fcontext_data2_len = sep - data;
-		fcontext_data2 = malloc(fcontext_data2_len);
-		if (!fcontext_data2)
-			goto cleanup;
-
-		memcpy(fcontext_data2, data, fcontext_data2_len);
-		data += fcontext_data2_len + 4;
-		size -= fcontext_data2_len + 4;
-	}
-
-	sep = memmem(data, size, separator, 4);
-	if (sep) {
-		fcontext_data3_len = sep - data;
-		fcontext_data3 = malloc(fcontext_data3_len);
-		if (!fcontext_data3)
-			goto cleanup;
-
-		memcpy(fcontext_data3, data, fcontext_data3_len);
-		data += fcontext_data3_len + 4;
-		size -= fcontext_data3_len + 4;
-	}
-
-	key_len = size;
-	key = malloc(key_len + 1);
-	if (!key)
-		goto cleanup;
-
-	memcpy(key, data, key_len);
-	key[key_len] = '\0';
-
-
-	/*
-	 * Mock selabel handle
-	 */
-	rec = (struct selabel_handle) {
-		.backend = SELABEL_CTX_FILE,
-		.validating = 1,
-		.data = &sdata,
-	};
-
-	selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = &null_log });
-	/* validate to pre-compile regular expressions */
-	selinux_set_callback(SELINUX_CB_VALIDATE, (union selinux_callback) { .func_validate = &validate_context });
-
-	root = calloc(1, sizeof(*root));
-	if (!root)
-		goto cleanup;
-
-	sdata.root = root;
-
-	fp = convert_data(fcontext_data1, fcontext_data1_len);
-	if (!fp)
-		goto cleanup;
-
-	errno = 0;
-	rc = load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
-	}
-
-	fclose(fp);
-
-	fp = convert_data(fcontext_data2, fcontext_data2_len);
-	if (!fp)
-		goto cleanup;
-
-	errno = 0;
-	rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
-	}
-
-	fclose(fp);
-
-	fp = convert_data(fcontext_data3, fcontext_data3_len);
-	if (!fp)
-		goto cleanup;
-
-	errno = 0;
-	rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
-	}
-
-	sort_specs(&sdata);
-
-	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
-
-	errno = 0;
-	result = lookup_all(&rec, key, mode, partial, find_all);
-
-	if (!result)
-		assert(errno != 0);
-
-	for (const struct lookup_result *res = result; res; res = res->next) {
-		assert(res->regex_str);
-		assert(res->regex_str[0] != '\0');
-		assert(res->lr->ctx_raw);
-		assert(res->lr->ctx_raw[0] != '\0');
-		assert(strcmp(res->lr->ctx_raw, "<<none>>") != 0);
-		assert(!res->lr->ctx_trans);
-		assert(res->lr->validated);
-		assert(res->prefix_len <= strlen(res->regex_str));
-	}
-
-
-cleanup:
-	free_lookup_result(result);
-	if (fp)
-		fclose(fp);
-	if (sdata.root) {
-		free_spec_node(sdata.root);
-		free(sdata.root);
-	}
-
-	{
-		struct mmap_area *area, *last_area;
-
-		area = sdata.mmap_areas;
-		while (area) {
-			rc = munmap(area->addr, area->len);
-			assert(rc == 0);
-			last_area = area;
-			area = area->next;
-			free(last_area);
-		}
-	}
-
-	free(key);
-	free(fcontext_data3);
-	free(fcontext_data2);
-	free(fcontext_data1);
-
-	/* Non-zero return values are reserved for future use. */
-	return 0;
-}
diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz/selabel_file_text-fuzzer.c
deleted file mode 100644
index 5d851de1..00000000
--- a/libselinux/fuzz/selabel_file_text-fuzzer.c
+++ /dev/null
@@ -1,225 +0,0 @@
-#include <errno.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <sys/mman.h>
-#include <unistd.h>
-
-#include <selinux/label.h>
-
-#include "../src/label_file.h"
-
-extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
-
-#define MEMFD_FILE_NAME "file_contexts"
-#define CTRL_PARTIAL  (1U << 0)
-#define CTRL_FIND_ALL (1U << 1)
-#define CTRL_MODE     (1U << 2)
-
-
-__attribute__ ((format(printf, 2, 3)))
-static int null_log(int type __attribute__((unused)), const char *fmt __attribute__((unused)), ...)
-{
-	return 0;
-}
-
-static int validate_context(char **ctxp)
-{
-	assert(strcmp(*ctxp, "<<none>>") != 0);
-
-	if (*ctxp[0] == '\0') {
-		errno = EINVAL;
-		return -1;
-	}
-
-	return 0;
-}
-
-static int write_full(int fd, const void *data, size_t size)
-{
-	ssize_t rc;
-	const unsigned char *p = data;
-
-	while (size > 0) {
-		rc = write(fd, p, size);
-		if (rc == -1) {
-			if (errno == EINTR)
-				continue;
-
-			return -1;
-		}
-
-		p += rc;
-		size -= rc;
-	}
-
-	return 0;
-}
-
-static FILE* convert_data(const uint8_t *data, size_t size)
-{
-	FILE* stream;
-	int fd, rc;
-
-	fd = memfd_create(MEMFD_FILE_NAME, MFD_CLOEXEC);
-	if (fd == -1)
-		return NULL;
-
-	rc = write_full(fd, data, size);
-	if (rc == -1) {
-		close(fd);
-		return NULL;
-	}
-
-	stream = fdopen(fd, "r");
-	if (!stream) {
-		close(fd);
-		return NULL;
-	}
-
-	rc = fseek(stream, 0L, SEEK_SET);
-	if (rc == -1) {
-		fclose(stream);
-		return NULL;
-	}
-
-	return stream;
-}
-
-int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
-{
-	struct selabel_handle rec;
-	struct saved_data sdata = {};
-	struct spec_node *root = NULL;
-	FILE* fp = NULL;
-	struct lookup_result *result = NULL;
-	uint8_t control;
-	uint8_t *fcontext_data = NULL;
-	char *key = NULL;
-	size_t fcontext_data_len, key_len;
-	bool partial, find_all;
-	mode_t mode;
-	int rc;
-
-	/*
-	 * Treat first byte as control byte, whether to use partial mode, find all matches or mode to lookup
-	 */
-	if (size == 0)
-		return 0;
-
-	control = data[0];
-	data++;
-	size--;
-
-	if (control & ~(CTRL_PARTIAL | CTRL_FIND_ALL | CTRL_MODE))
-		return 0;
-
-	partial  = control & CTRL_PARTIAL;
-	find_all = control & CTRL_FIND_ALL;
-	/* S_IFSOCK has the highest integer value */
-	mode     = (control & CTRL_MODE) ? S_IFSOCK : 0;
-
-
-	/*
-	 * Split the fuzzer input into two pieces: the textual fcontext definition and the lookup key
-	 */
-	const unsigned char separator[4] = { 0xde, 0xad, 0xbe, 0xef };
-	const uint8_t *sep = memmem(data, size, separator, 4);
-	if (!sep || sep == data)
-		return 0;
-
-	fcontext_data_len = sep - data;
-	fcontext_data = malloc(fcontext_data_len);
-	if (!fcontext_data)
-		goto cleanup;
-
-	memcpy(fcontext_data, data, fcontext_data_len);
-
-	key_len = size - fcontext_data_len - 4;
-	key = malloc(key_len + 1);
-	if (!key)
-		goto cleanup;
-
-	memcpy(key, sep + 4, key_len);
-	key[key_len] = '\0';
-
-
-	/*
-	 * Mock selabel handle
-	 */
-	rec = (struct selabel_handle) {
-		.backend = SELABEL_CTX_FILE,
-		.validating = 1,
-		.data = &sdata,
-	};
-
-	selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = &null_log });
-	/* validate to pre-compile regular expressions */
-	selinux_set_callback(SELINUX_CB_VALIDATE, (union selinux_callback) { .func_validate = &validate_context });
-
-	root = calloc(1, sizeof(*root));
-	if (!root)
-		goto cleanup;
-
-	sdata.root = root;
-
-	fp = convert_data(fcontext_data, fcontext_data_len);
-	if (!fp)
-		goto cleanup;
-
-	errno = 0;
-	rc = process_text_file(fp, /*prefix=*/ NULL, &rec, MEMFD_FILE_NAME);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
-	}
-
-	sort_specs(&sdata);
-
-	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
-
-	errno = 0;
-	result = lookup_all(&rec, key, mode, partial, find_all);
-
-	if (!result)
-		assert(errno != 0);
-
-	for (const struct lookup_result *res = result; res; res = res->next) {
-		assert(res->regex_str);
-		assert(res->regex_str[0] != '\0');
-		assert(res->lr->ctx_raw);
-		assert(res->lr->ctx_raw[0] != '\0');
-		assert(strcmp(res->lr->ctx_raw, "<<none>>") != 0);
-		assert(!res->lr->ctx_trans);
-		assert(res->lr->validated);
-		assert(res->prefix_len <= strlen(res->regex_str));
-	}
-
-
-cleanup:
-	free_lookup_result(result);
-	if (fp)
-		fclose(fp);
-	if (sdata.root) {
-		free_spec_node(sdata.root);
-		free(sdata.root);
-	}
-
-	{
-		struct mmap_area *area, *last_area;
-
-		area = sdata.mmap_areas;
-		while (area) {
-			rc = munmap(area->addr, area->len);
-			assert(rc == 0);
-			last_area = area;
-			area = area->next;
-			free(last_area);
-		}
-	}
-
-	free(key);
-	free(fcontext_data);
-
-	/* Non-zero return values are reserved for future use. */
-	return 0;
-}
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 189a5ed2..d9ee4063 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -27,13 +27,6 @@
 #include "label_file.h"
 
 
-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-# define FUZZ_EXTERN
-#else
-# define FUZZ_EXTERN static
-#endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
-
-
 /*
  * Warn about duplicate specifications.
  */
@@ -121,8 +114,8 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 	return rc;
 }
 
-FUZZ_EXTERN int process_text_file(FILE *fp, const char *prefix,
-				  struct selabel_handle *rec, const char *path)
+static int process_text_file(FILE *fp, const char *prefix,
+			     struct selabel_handle *rec, const char *path)
 {
 	int rc;
 	size_t line_len;
@@ -727,8 +720,8 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 	return 0;
 }
 
-FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
-			  const char *path)
+static int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
+		     const char *path)
 {
 	struct saved_data *data = rec->data;
 	struct spec_node *root = NULL;
@@ -1456,7 +1449,16 @@ static uint32_t search_literal_spec(const struct literal_spec *array, uint32_t s
 	return (uint32_t)-1;
 }
 
-FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
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
 {
 	struct lookup_result *tmp;
 
@@ -1688,11 +1690,11 @@ static uint8_t mode_to_file_kind(int type) {
 // Finds all the matches of |key| in the given context. Returns the result in
 // the allocated array and updates the match count. If match_count is NULL,
 // stops early once the 1st match is found.
-FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
-				 const char *key,
-				 int type,
-				 bool partial,
-				 bool find_all)
+static struct lookup_result *lookup_all(struct selabel_handle *rec,
+					const char *key,
+					int type,
+					bool partial,
+					bool find_all)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct lookup_result *result = NULL;
@@ -2281,7 +2283,7 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
 	return result;
 }
 
-FUZZ_EXTERN enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2)
+static enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2)
 {
 	const struct saved_data *data1, *data2;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 529a1bd2..2dc772eb 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -50,23 +50,6 @@
 #define LABEL_FILE_KIND_LNK		6
 #define LABEL_FILE_KIND_REG		7
 
-/* Only exported for fuzzing */
-struct lookup_result {
-	const char *regex_str;
-	struct selabel_lookup_rec *lr;
-	uint16_t prefix_len;
-	uint8_t file_kind;
-	bool has_meta_chars;
-	struct lookup_result *next;
-};
-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
-extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path);
-extern void free_lookup_result(struct lookup_result *result);
-extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all);
-extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
-#endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
-
 struct selabel_sub {
 	char *src;
 	unsigned int slen;
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 9376b6e4..069f130a 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -44,13 +44,10 @@ export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
 
 rm -rf "$DESTDIR"
 make -C libsepol clean
-make -C libselinux clean
 # LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
 # has been read by make
 # shellcheck disable=SC2016
 make -C libsepol V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=$(LIBMAP)' -j"$(nproc)" install
-# shellcheck disable=SC2016
-make -C libselinux V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=libselinux.map' -j"$(nproc)" install
 
 ## secilc fuzzer ##
 
@@ -87,25 +84,3 @@ $CXX $CXXFLAGS $LIB_FUZZING_ENGINE checkpolicy-fuzzer.o checkpolicy/*.o "$DESTDI
 
 zip -j "$OUT/checkpolicy-fuzzer_seed_corpus.zip" checkpolicy/fuzz/min_pol.mls.conf
 cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
-
-## selabel-file text fcontext based fuzzer ##
-
-# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
-# the compiler/linker so they shouldn't be quoted
-# shellcheck disable=SC2086
-$CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_text-fuzzer.o libselinux/fuzz/selabel_file_text-fuzzer.c
-# shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_text-fuzzer"
-
-zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
-
-## selabel-file compiled fcontext based fuzzer ##
-
-# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
-# the compiler/linker so they shouldn't be quoted
-# shellcheck disable=SC2086
-$CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_compiled-fuzzer.o libselinux/fuzz/selabel_file_compiled-fuzzer.c
-# shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_compiled-fuzzer"
-
-zip -j "$OUT/selabel_file_compiled-fuzzer_seed_corpus.zip" libselinux/fuzz/input
-- 
2.47.1

