Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D47363C50
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767463; cv=none; b=k31eB6oWJwT99zGftAdXdI31hQZFPasPzm3O/6D3fbAfDAd0ARu1kghZKPjl7BJcBD3f1nsDIBSymVb5hmtHbAD9Yo8TuwY5fzpUjsV5yfeHPZh1WLw6St/MiRSluREHvLWTYwHniGbAeXIeZznMQ8eexU538HIYOCG2KwFzTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767463; c=relaxed/simple;
	bh=AZxqgqv8V9CtEboaZwJjfce+JeKBaWA12QMRRs1BODs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTn+oEjv/kC1EcmeW8hilZ3uHs8EqqpITRwyS05mq3/Xm0pTOnnZsZ+lNokVgsHt9s4XqflRLd3P/KTW7zXSV/T6UBAbUJP2SLwSg2ipdIsHposHlyUD95R1QfQQvUvrh58aOfiVYnrgsKxDHV1sKgq2lNGSKlubm7QjZNVQp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAcH1fUG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAcH1fUG"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ea24a2dbfso103383185a.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767452; x=1788372252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkSwsE6/SXhStv+smFHGWRr/zMlBHyGjnJ2LsMbdOBY=;
        b=SAcH1fUG9q3ylsZ5O9mvaK6OTA7IJHYUkDa9lTdZFswZrrVTLdC1cHaLBvTEHxaVe2
         VFnFimBWS0fXptB/rcVf6aJe8qZ+fvP0xb8Gc/qbhPjoFhoV0s0TZ/ZhFlM4SXp+uh4l
         uqHJlkPeP2+fkalnDQHKoFqId9JWfINpdKUc6wAO4wKEAotO7RIqNI/2z1CT2kXUAQop
         a2fllBJHW38Z1IJAwqTbT5KP/zk/FDQve5MkLLi/RreT8pthE3v8MQPxPzqWt0xxel7u
         iHHDq5Ysm6i08NVDS+jLRfMrHuLmUOwLSzfqtl92egAhTxzkPufgiP7wIfGMLHZGKFjc
         iM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767452; x=1788372252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkSwsE6/SXhStv+smFHGWRr/zMlBHyGjnJ2LsMbdOBY=;
        b=rhjwR8QizgyA6p0qJ0z4qpb+OD62IuJVN/sb9Dfhx2BkoZ5J+t1obQ/rEoVaOUe+Gy
         gw/AjC6iX2j/+2QcVsL0EUvvsEEqM7qCmkfZSXMXtzX4oY6ReaNfLB8wK77cuh2lG7ns
         lFe85eapvieC0lNPgjlV3KYDHBKUG2lR6GsvWRnu8EA2o8BPDEZYfQWFqeIw0OtZt+tp
         4HXlobumYtAnfCxgRAwjepdSmYyi2whP/FxYzXHC1bb9P5uxwiFBCw3FOXkAMZnRyrGZ
         JiG1PfbOenLUFs+YR1GQNl6f8LK2PTh7iI5Az8AuSYJ9Bp96EbOuWE65Hq5fOFpP0Je1
         Lmng==
X-Gm-Message-State: AFuF++kq+jiykA1lm5V5V4c2hJX5itwsZZXtHDHVweW6zL1Z4LDQPpo4
	Js9HSqCR3tQLXIzIgwDfxXzqaF07zi7v4NpvpLoqtFwV05l2+z/uQW5wthl5ig==
X-Gm-Gg: AR+sD10TXQgfCLGNvu7gasqpty6E5+jhp0kkgDepjYao3N+NOWQs80GL+xctmIH0WTi
	9hDwon5hIT0gGK3aMrobmlZAAbXdvbjdvl0ti6PSfadNjvbEWm+yOdFcP/91ud6k/txRd0MlqUM
	8Fj6FaLHCioKgPo12VyBhHtZ7EBpJ9l/UroI7cVXXw0HfnHRBt2bVJidY4G4Q34FPFtLTF6gqsZ
	MElv5R9jteFNBWKVjkQilJROgyJhN2vMprw7cp7ObZ7ovhFCMn3VxT25X4PP801rY/zXboY8lAf
	IyG2PqQ6Q5vBX4h4XawIcRI7cX44j/6dzuu8wX9fYJTaoh8xVGzria9rYAOLF9a22kvAFvF9Kww
	aixS+UVcz+BxJdruSO21ekMmWCZwpCIHZUG7E/SSAuKRuYW/Ljw80odZiLxERaHSHfLCP1rPXeY
	nDkLpyA7V++PNa2K6DJl3PEBaqO8v2b6ESeifNyjkEkvEqzwjLHgHJK3XoIl+tMpITwK0YYVKPp
	5ZXrMkFGGqFZus++58ohtQkJ4TXd9GPJ98/3HsISWybWjPlquiW0CCPA4XM+qNp
X-Received: by 2002:a05:620a:2852:b0:92e:541e:632b with SMTP id af79cd13be357-9378010a43amr978918785a.2.1787767451523;
        Wed, 26 Aug 2026 11:04:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e30f097sm268808385a.1.2026.08.26.11.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:04:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	nicolas.iooss@m4x.org,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] FUZZ.md,{checkpolicy,libselinux}/fuzz: document selinux fuzzing
Date: Wed, 26 Aug 2026 14:01:14 -0400
Message-ID: <20260826180113.6262-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the use of OSS-Fuzz and CIFuzz by the selinux userspace
project and provide some instructions and helpers for debugging
fuzzing failures.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This is based on my experience thus far in handling OSS-Fuzz/CIFuzz;
for those who may be more familiar with them, feel free to correct
or suggest additions! The decode*.c programs are just copied from
the fuzzers themselves and then tweaked to display additional info;
I also found them useful for reproducing bugs in a manner more
amenable to using gdb/valgrind than the oss-fuzz.sh-produced build.

 FUZZ.md                                       |  86 +++++
 checkpolicy/fuzz/decodecheckpolicyfuzz.c      |  41 +++
 .../fuzz/decodeselabelfilecompiledfuzz.c      | 335 ++++++++++++++++++
 libselinux/fuzz/decodeselabelfiletextfuzz.c   | 313 ++++++++++++++++
 4 files changed, 775 insertions(+)
 create mode 100644 FUZZ.md
 create mode 100644 checkpolicy/fuzz/decodecheckpolicyfuzz.c
 create mode 100644 libselinux/fuzz/decodeselabelfilecompiledfuzz.c
 create mode 100644 libselinux/fuzz/decodeselabelfiletextfuzz.c

diff --git a/FUZZ.md b/FUZZ.md
new file mode 100644
index 00000000..405234b9
--- /dev/null
+++ b/FUZZ.md
@@ -0,0 +1,86 @@
+Fuzzing of the SELinux userspace
+================================
+
+OSS-Fuzz
+--------
+
+Portions of the SELinux userspace are regularly fuzzed by OSS-Fuzz based
+on the configuration at:
+https://github.com/google/oss-fuzz/blob/master/projects/selinux/project.yaml
+
+The fuzzers can be found under the fuzz subdirectories of various
+directories within the selinux repository, and can be built using the
+./scripts/oss-fuzz.sh script. OSS-Fuzz itself uses this script to
+build the fuzzers.
+
+See
+https://issues.oss-fuzz.com/issues?q=project:selinux
+for public OSS-Fuzz selinux issues. OSS-Fuzz automatically makes
+issues public once they are verified to be fixed or after a 90 day
+disclosure window. Issues are initially created private and
+sent via email to those listed in the configuration above.
+
+Not all issues will be fixed by the upstream SELinux project, e.g.
+small memory leaks on error paths for checkpolicy are not viewed as
+worth fixing since checkpolicy will exit shortly thereafter, and OSS
+Fuzz will create issues if it encounters a timeout during fuzzing even
+though the fuzzer would have completed if given more time.
+
+Items categorized as a vulnerability by OSS-Fuzz will not always be
+treated as security issues by the upstream SELinux project; in
+particular, issues that depend on attacker-controlled policy are not
+considered to be security issues and will just be handled as regular
+bugs. See
+[SECURITY.md](https://github.com/SELinuxProject/selinux/blob/main/SECURITY.md)
+for more information on the SELinux userspace security vulnerability
+handling process.
+
+CIFuzz
+------
+
+The selinux GitHub CI Actions include a CIFuzz workflow based on the
+configuration at:
+https://github.com/SELinuxProject/selinux/blob/main/.github/workflows/cifuzz.yml
+
+This action is invoked for pushes and pull requests targeting the main
+branch of the SELinuxProject/selinux repository to help detect
+regressions on new commits.
+
+The status of CIFuzz workflow runs can be viewed at:
+https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml
+as well as in the check status for each push or pull request and
+displayed in the banner at the top of the
+[README.md](https://github.com/SELinuxProject/selinux/blob/main/README.md)
+file.
+
+Debugging Fuzzing Failures
+--------------------------
+
+OSS-Fuzz provides a detailed report and, when possible, a reproducer
+testcase. If the cause cannot be determined from the report, the
+reproducer testcase can be downloaded locally, the fuzzer can be built
+using ./scripts/oss-fuzz.sh, and the fuzzer can be manually run on the
+reproducer testcase input.
+
+In some cases, it may be helpful to run one of the selinux userspace
+programs on the fuzzer input directly, potentially under gdb or
+valgrind, to better understand the issue and whether it is applicable
+to any production tool. This can be done when the fuzzer input is
+accepted directly as input to one of the selinux userspace programs,
+such as a CIL policy file to secilc or a binary policy file to
+checkpolicy -b. In other cases, the fuzzing input actually consists of
+a binary header and one or more concatenated files that must be
+decoded or split. Simple programs for decoding the fuzzer input can
+also be found under the fuzz/ subdirectories within the selinux
+repository, starting with the prefix "decode". These programs can be
+run on the reproducer testcase to extract and display information
+about the reproducer. To build these programs, one must compile the
+selinux userspace and the program with the
+-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION flag to provide access to
+the necessary helper functions that would otherwise not be exposed in
+a production build, e.g.
+
+    make CFLAGS+='-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -g' clean all
+    gcc -g -o decodeselabelfiletextfuzz libselinux/fuzz/decodeselabelfiletextfuzz.c libselinux/src/libselinux.a /usr/lib64/libpcre2-8.a
+    valgrind ./decodeselabelfiletextfuzz clusterfuzz-testcase-minimized-selabel_file_text-fuzzer-5721256067137536
+
diff --git a/checkpolicy/fuzz/decodecheckpolicyfuzz.c b/checkpolicy/fuzz/decodecheckpolicyfuzz.c
new file mode 100644
index 00000000..99ab150c
--- /dev/null
+++ b/checkpolicy/fuzz/decodecheckpolicyfuzz.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+int main(int argc, char **argv)
+{
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+	unsigned char buf[3];
+	size_t nread = fread(buf, 1, 3, fp);
+	if (nread != 3) {
+		perror("fread");
+		exit(1);
+	}
+	switch (buf[0]) {
+	case 'S':
+		printf("SELinux");
+		break;
+	case 'X':
+		printf("Xen");
+		break;
+	default:
+		printf("Unknown");
+	}
+	puts("\n");
+	switch (buf[1]) {
+	case '0':
+		printf("non-MLS");
+		break;
+	case '1':
+		printf("MLS");
+		break;
+	default:
+		printf("Unknown");
+	}
+	puts("\n");
+	printf("%d\n", buf[2] - 'A');
+	return 0;
+}
diff --git a/libselinux/fuzz/decodeselabelfilecompiledfuzz.c b/libselinux/fuzz/decodeselabelfilecompiledfuzz.c
new file mode 100644
index 00000000..b5abd830
--- /dev/null
+++ b/libselinux/fuzz/decodeselabelfilecompiledfuzz.c
@@ -0,0 +1,335 @@
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+
+#define FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+#include "selinux/libselinux/src/label_file.h"
+
+#define MEMFD_FILE_NAME "file_contexts"
+#define CTRL_PARTIAL (1U << 0)
+#define CTRL_FIND_ALL (1U << 1)
+#define CTRL_MODE (1U << 2)
+
+__attribute__((format(printf, 2, 3))) static int
+null_log(int type __attribute__((unused)),
+	 const char *fmt __attribute__((unused)), ...)
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
+static FILE *convert_data(const uint8_t *data, size_t size)
+{
+	FILE *stream;
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
+	FILE *fp = NULL;
+	struct lookup_result *result = NULL;
+	uint8_t control;
+	uint8_t *fcontext_data1 = NULL, *fcontext_data2 = NULL,
+		*fcontext_data3 = NULL;
+	char *key = NULL;
+	size_t fcontext_data1_len, fcontext_data2_len = 0,
+				   fcontext_data3_len = 0, key_len;
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
+	partial = control & CTRL_PARTIAL;
+	find_all = control & CTRL_FIND_ALL;
+	/* S_IFSOCK has the highest integer value */
+	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
+
+	if (partial)
+		printf("partial\n");
+	if (find_all)
+		printf("find_all\n");
+	if (mode)
+		printf("mode\n");
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
+		if (fcontext_data2_len) {
+			fcontext_data2 = malloc(fcontext_data2_len);
+			if (!fcontext_data2)
+				goto cleanup;
+
+			memcpy(fcontext_data2, data, fcontext_data2_len);
+		}
+
+		data += fcontext_data2_len + 4;
+		size -= fcontext_data2_len + 4;
+	}
+
+	sep = memmem(data, size, separator, 4);
+	if (sep) {
+		fcontext_data3_len = sep - data;
+		if (fcontext_data3_len) {
+			fcontext_data3 = malloc(fcontext_data3_len);
+			if (!fcontext_data3)
+				goto cleanup;
+
+			memcpy(fcontext_data3, data, fcontext_data3_len);
+		}
+
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
+	/*
+	 * Mock selabel handle
+	 */
+	rec = (struct selabel_handle){
+		.backend = SELABEL_CTX_FILE,
+		.validating = 1,
+		.data = &sdata,
+	};
+
+	selinux_set_callback(SELINUX_CB_LOG,
+			     (union selinux_callback){ .func_log = &null_log });
+	/* validate to pre-compile regular expressions */
+	selinux_set_callback(
+		SELINUX_CB_VALIDATE,
+		(union selinux_callback){ .func_validate = &validate_context });
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
+	rc = load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME, 0);
+	if (rc) {
+		assert(errno != 0);
+		goto cleanup;
+	}
+
+	fclose(fp);
+	fp = NULL;
+
+	if (fcontext_data2_len) {
+		fp = convert_data(fcontext_data2, fcontext_data2_len);
+		if (!fp)
+			goto cleanup;
+
+		errno = 0;
+		rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME,
+			       1);
+		if (rc) {
+			assert(errno != 0);
+			goto cleanup;
+		}
+
+		fclose(fp);
+		fp = NULL;
+	}
+
+	if (fcontext_data3_len) {
+		fp = convert_data(fcontext_data3, fcontext_data3_len);
+		if (!fp)
+			goto cleanup;
+
+		errno = 0;
+		rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME,
+			       2);
+		if (rc) {
+			assert(errno != 0);
+			goto cleanup;
+		}
+
+		fclose(fp);
+		fp = NULL;
+	}
+
+	sort_specs(&sdata);
+
+	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
+
+	errno = 0;
+	result = lookup_all(&rec, key, mode, partial, find_all, NULL);
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
+
+int main(int argc, char **argv)
+{
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
diff --git a/libselinux/fuzz/decodeselabelfiletextfuzz.c b/libselinux/fuzz/decodeselabelfiletextfuzz.c
new file mode 100644
index 00000000..35f56761
--- /dev/null
+++ b/libselinux/fuzz/decodeselabelfiletextfuzz.c
@@ -0,0 +1,313 @@
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+
+#define FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+#include "selinux/libselinux/src/label_file.h"
+
+#define MEMFD_FILE_NAME "file_contexts"
+#define CTRL_PARTIAL (1U << 0)
+#define CTRL_FIND_ALL (1U << 1)
+#define CTRL_MODE (1U << 2)
+
+__attribute__((format(printf, 2, 3))) static int
+null_log(int type __attribute__((unused)),
+	 const char *fmt __attribute__((unused)), ...)
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
+static FILE *convert_data(const uint8_t *data, size_t size)
+{
+	FILE *stream;
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
+	FILE *fp = NULL;
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
+	partial = control & CTRL_PARTIAL;
+	find_all = control & CTRL_FIND_ALL;
+	/* S_IFSOCK has the highest integer value */
+	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
+
+	if (partial)
+		printf("partial\n");
+	if (find_all)
+		printf("find_all\n");
+	if (mode)
+		printf("mode\n");
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
+	printf("fcontext_data_len=%zu fcontext=", fcontext_data_len);
+	unsigned char *str = fcontext_data;
+	unsigned char *end = str + fcontext_data_len;
+	while (str < end) {
+		unsigned char c = *str;
+		if (isspace(c)) {
+			printf("\\s");
+		} else if (isprint(c)) {
+			putchar(c);
+		} else {
+			printf("\\x%02x", c);
+		}
+		str++;
+	}
+	printf("\n");
+
+	key_len = size - fcontext_data_len - 4;
+	key = malloc(key_len + 1);
+	if (!key)
+		goto cleanup;
+
+	memcpy(key, sep + 4, key_len);
+	key[key_len] = '\0';
+
+	printf("len=%zu key=", key_len);
+	str = key;
+	end = str + key_len;
+	while (str < end) {
+		unsigned char c = *str;
+		if (isspace(c)) {
+			printf("\\s");
+		} else if (isprint(c)) {
+			putchar(c);
+		} else {
+			printf("\\x%02x", c);
+		}
+		str++;
+	}
+	printf("\n");
+
+	/*
+	 * Mock selabel handle
+	 */
+	rec = (struct selabel_handle){
+		.backend = SELABEL_CTX_FILE,
+		.validating = 1,
+		.data = &sdata,
+	};
+
+	selinux_set_callback(SELINUX_CB_LOG,
+			     (union selinux_callback){ .func_log = &null_log });
+	/* validate to pre-compile regular expressions */
+	selinux_set_callback(
+		SELINUX_CB_VALIDATE,
+		(union selinux_callback){ .func_validate = &validate_context });
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
+	rc = process_text_file(fp, /*prefix=*/NULL, &rec, MEMFD_FILE_NAME, 0);
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
+	result = lookup_all(&rec, key, mode, partial, find_all, NULL);
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
+	sort_specs(&sdata);
+
+	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
+
+	errno = 0;
+	result = lookup_all(&rec, key, mode, partial, find_all, NULL);
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
+
+int main(int argc, char **argv)
+{
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
-- 
2.55.0

