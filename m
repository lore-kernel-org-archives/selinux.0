Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D41E3DF2
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831613; cv=none; b=olRFLp0OCTYjdGooOyBkPHXp4ffdfdI+ZIUMTrDqpluNJSzJmQMIGYyxwtyQ0CEWZWPB3rcysRu5XOOESoo91yofFT2ZHHSrbdb/dYIHYM1ZaDnHBbRJp71odCFmXlFmEi/s2B1IQtUWe9xwNu7eFNfHHzee0fErJaU+rN+smok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831613; c=relaxed/simple;
	bh=+/CFZYDlXzAirQOdEpfHgCmQ+mrZia/Mu3/XNXVXfvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqrNY5LcqjKEGTs5Oqcl3uyEFN2sHUp74o3EbT4w4E7mQRkrh3RK9cTyuMgApfmjonNPcJQVoH0kce8ViAFGptTtz/cuk6EbIypdHAcIrm/uLnuE0YEgOM44KVLjfcEMSWaEhma9I7+wPAUeskU6Wf/OOWgBgA/j00uFphbMVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=MXEB6UyP; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="MXEB6UyP"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831608;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7IpiAWAAeBHDqMH98wEEpDyGrsk60rdgWHHDTZiTgQ=;
	b=MXEB6UyP7zIpBXJ2RrmpfZKA+MJNspP9BiDTegmJqmSRRgTnMx7qM7CnMGTRHcQV76uuDm
	wWcgXTqpcek6wuYE+Qqszt3FXhNUit//O9d1jdGOG5TRi5beyztKouoX8T0qVeHgXDRa0l
	xPYK413kj8j1Cd1+fhEhx6L7YbWCuv5vr2tjFNb0OicxWI99rmhQ8sAP33V5Q/I70yy3Ww
	42x/PzqaMetX1/MaABMGp3+/WRnrzT3w5K7fl7wN6GKEKTKUjOOkG0qWMEkLaLy03VIBx/
	mBOPqESjKM0T9xUDpkjsdydsvcihb/OURd+uW8f5ykdff7zRrVWeqtuIrBbZaQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Evgeny Vereshchagin <evverx@gmail.com>
Subject: [PATCH v3 8/9] libselinux: add selabel_file(5) fuzzer
Date: Tue,  5 Nov 2024 19:33:18 +0100
Message-ID: <20241105183319.250410-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
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

Add two fuzzers reading and performing lookup on selabel_file(5)
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
 .../fuzz/selabel_file_compiled-fuzzer.c       | 281 ++++++++++++++++++
 libselinux/fuzz/selabel_file_text-fuzzer.c    | 225 ++++++++++++++
 libselinux/src/label_file.c                   |  38 ++-
 libselinux/src/label_file.h                   |  17 ++
 scripts/oss-fuzz.sh                           |  25 ++
 6 files changed, 566 insertions(+), 20 deletions(-)
 create mode 100644 libselinux/fuzz/input
 create mode 100644 libselinux/fuzz/selabel_file_compiled-fuzzer.c
 create mode 100644 libselinux/fuzz/selabel_file_text-fuzzer.c

diff --git a/libselinux/fuzz/input b/libselinux/fuzz/input
new file mode 100644
index 00000000..e69de29b
diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
new file mode 100644
index 00000000..cf0710ad
--- /dev/null
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -0,0 +1,281 @@
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
+	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
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
index 00000000..5d851de1
--- /dev/null
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -0,0 +1,225 @@
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
+	rc = process_text_file(fp, /*prefix=*/ NULL, &rec, MEMFD_FILE_NAME);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	sort_specs(&sdata);
+
+	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
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
index c7713d7c..267f708e 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -27,6 +27,13 @@
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
@@ -114,8 +121,8 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 	return rc;
 }
 
-static int process_text_file(FILE *fp, const char *prefix,
-			     struct selabel_handle *rec, const char *path)
+FUZZ_EXTERN int process_text_file(FILE *fp, const char *prefix,
+				  struct selabel_handle *rec, const char *path)
 {
 	int rc;
 	size_t line_len;
@@ -720,8 +727,8 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 	return 0;
 }
 
-static int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
-		     const char *path)
+FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec,
+			  const char *path)
 {
 	struct saved_data *data = rec->data;
 	struct spec_node *root = NULL;
@@ -1449,16 +1456,7 @@ static uint32_t search_literal_spec(const struct literal_spec *array, uint32_t s
 	return (uint32_t)-1;
 }
 
-struct lookup_result {
-	const char *regex_str;
-	struct selabel_lookup_rec *lr;
-	uint16_t prefix_len;
-	uint8_t file_kind;
-	bool has_meta_chars;
-	struct lookup_result *next;
-};
-
-static void free_lookup_result(struct lookup_result *result)
+FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 {
 	struct lookup_result *tmp;
 
@@ -1690,11 +1688,11 @@ static uint8_t mode_to_file_kind(int type) {
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
@@ -2283,7 +2281,7 @@ static enum selabel_cmp_result spec_node_cmp(const struct spec_node *node1, cons
 	return result;
 }
 
-static enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2)
+FUZZ_EXTERN enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2)
 {
 	const struct saved_data *data1, *data2;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 2dc772eb..529a1bd2 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -50,6 +50,23 @@
 #define LABEL_FILE_KIND_LNK		6
 #define LABEL_FILE_KIND_REG		7
 
+/* Only exported for fuzzing */
+struct lookup_result {
+	const char *regex_str;
+	struct selabel_lookup_rec *lr;
+	uint16_t prefix_len;
+	uint8_t file_kind;
+	bool has_meta_chars;
+	struct lookup_result *next;
+};
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
+extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path);
+extern void free_lookup_result(struct lookup_result *result);
+extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all);
+extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
+#endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
+
 struct selabel_sub {
 	char *src;
 	unsigned int slen;
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 069f130a..9376b6e4 100755
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
 
@@ -84,3 +87,25 @@ $CXX $CXXFLAGS $LIB_FUZZING_ENGINE checkpolicy-fuzzer.o checkpolicy/*.o "$DESTDI
 
 zip -j "$OUT/checkpolicy-fuzzer_seed_corpus.zip" checkpolicy/fuzz/min_pol.mls.conf
 cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
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
2.45.2

