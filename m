Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732007;
	b=t16rGK0T4+6JUloyqou1Q9NQkyRgiL/DNM3HvdHIhJP/kUYkGvbuh/FUJJ3uHNhIh6UB
	 bJLM+4R3CG+SfIGdrggdQrxpJn3PIhCTsvD9eE6YpD1Hy2TJskjswhYOJAkbK0XS5wSkl
	 9tKKdBWUwuJkCTNh6wKZd8PdmSU5VQQypJW7/Ll4pCNiOVDdpY29h9y2+hdjhZh8YeDrc
	 hQr9ZtAjRGmb0VUcZKuHsJQoyfode20woXEs4ikGynSPGqTx5ebFubuV1zYbsoh/IDsZA
	 aZzEQLjQ+pY/5Y9Y/vHqZRMmOv6X4NF3Y/QinQzFzvvAIANAQx87L/S7GoUQAyCNJAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
	b=JnDcR3N8FqJZG8PW3Oy3rbyqv5MqaMIr0DCdST6X9FT02U0qSTBjG3GdlNVXVI33kBnh
	 /3AJFsvWw0X+Q1oHP39OBi0Ys4Gbudh2Es1CgUB00ydiQsfzkKXnJo3grh8wiqNsS9NI4
	 zi88TS43PXHg3XEBCj31AFGwyy14zCjxd1RBFqDTD+uaPVs526LwRpgtc3GdD6FKw+wcG
	 kycg0J9DWvjW+PwS+/bSlvJtYkjN0fCrpXU4Tq4d72lRUepMA38FNwZKesn2dNKzxt+VI
	 v58NBTzi/xnNlwRR+ak0lTKB9w4ddsZb37EOkHxYzcanC54S5+KEv/yHAuGYI7GqMrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6v6fJS4;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAA606A32E
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CAA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6v6fJS4
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e7c847aceso73806d6.3
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732006; x=1794336806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=b6v6fJS4auKT6ZRp7DWFu5fMcDYZDkYjHQzPwmjiCgtd/ooVsFilgzkLn0ka6+JhTz
         eSjdwkLUUmABu2yzWQcozHt90+nW29NmLC6cvhuJoaw0JEyek8H3rfHueQk9o+VMq+Mq
         n0Alcqj1IzD22/5cqsUA9gPDFEfTaxdGtZhCuGnZ8SybfQovBJ47+6dT4BBgUA/UWnvb
         XI0ZyKtoT1GC/DfVP2A5SV8mwPDMOP0TwTFGJHsRQANpuYp3WPV6ztr+p1jhpFHucDL9
         ChqD/r0n2aYbQbJIBke5sjvUR48YTmDhvwabxOsacgkYHQiPNVTCvHblKYAB/20TdfDM
         8TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732006; x=1794336806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=BPzUG7X1uOOfi9aSYimVuL0UWwbk3PLP7yFqWojhzYkI5TSIK/LKhNMLLVW1XqHrEo
         rHal/u2NclwUJMQr4gMK2+8TX6zZuGU4lpgyvaF+5vhhOGDahe/zze5N7EG7byCOBoev
         dkDnh0+9P07Nx1917rhfHd+scCNOMcL87xVZhNDOrA6cE2q0HV6XXR5q4Q280QX91dpb
         2147EN6ef1Z1DEwd6ZikKgns0/i57J/0TQ4QoHPsyBigNpULyKD8cPHRBXrd6in9FivE
         4v3VXhw9M5MiVE+OxhtwwWDe/CsLS3ZFIkGU1vZiOjLn+jbe5/ZpDNOER5PRWvfI9+YJ
         B5rg==
X-Gm-Message-State: APuU4Z9TlyhT9M6AsWnOw+ZAEyAhAenc0uE/c7hxBJBFIDWhkGdhM73D
	JOUtpe1CnveeyX18YriuOtG/cZmocLeQfao/ZiVOaIcWLJbIabn61psiL2zYwEd5
X-Gm-Gg: AYBFou0UZ//IgYyLiUC3HH3lOSsmquyOaLvIYPr81CWrBEketb6PRPoWGncIrv8s7Fu
	yvegqdJm6FmrF22nvqMF66yvWlQrHNjv3DngX8daBvk2oVvnTW7AHf2TOUs0LijzxPBoE5p9tqu
	qr6XfzMLIp1Tap6uB2XmWI9tMTuHgGAKvCFov/5iY6qlCN7l8TiGGTj1bAI6fRddUSK238lXDO8
	rlBd+QP5E6PB4zkSyAT+MkIEE9lldIkmdH/WtPHoV6jfp4JvLTAZ8NS5VrTjPXBzczNiyQxe9+3
	zDwp6sQD+211ZzCcAt/Nl7Ox9mjMAmAwp4Y0+YAUhgR8TRtGjLzJ7orsc4FMj1TF91AWnWSB0xS
	37Fnk/DylzxWTajYWVdERmn48VwqRdk3fHjsA5MQITJfcCiYHu3HRxCh2f8lwS/w36nZdxcJy7y
	6+EBsapEshZgllC5TN0Loyz3LpeyLNHunYQwdI2OKCwn2EKkm+Y0cMSBo7EuQGTNT0VhFcRKB1U
	sefJIXuTtxlBixwG5l5Qm7BN1T8+pwh9OCfckrs7XIxEY2dyod8m5k/94ZnG26Z/QnclJ5OCt+w
	CMMS5k0FcDSRNwFEmohj4z066J622j4iS3pqg5bTJTJ3GB07cZH0KAyW0Qm/2irVebdDD3Ighmb
	NQKUbmA5XnAwUwRtBXEkQPXVBkEYHyRRmMm/Cx/sLScmQHEjtcYNONOw6N2HtkyPXOriBQAFpiM
	4nAgGXJ0e6oZFT40kZuodifW9Rga1VeW6OEyziGVfbuI4SZCxkfcDNnJJgENnad/+FlEPyiv9a
X-Received: by 2002:a05:6214:2501:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91ca4bb67b5mr231401276d6.39.1793732005865;
        Tue, 03 Nov 2026 10:53:25 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:25 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 02/20] libselinux: publish restorecon error counts on every successful call
Date: Tue,  3 Nov 2026 13:52:49 -0500
Message-ID: <20261103185307.45924-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
References: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset the public skipped-error count before any early return and publish
the recursive count independently of saved_errno. A nonzero errno does
not imply failure when COUNT_ERRORS masks relabel errors, and successful
operations can leave errno set as well.

The fd-based walker can finish a regular-file root without clearing
errno through readdir, causing a failed relabel to return success with
an unchanged public count. setfiles -C can consequently exit zero.
Early successful returns can also retain the count from a previous call.

Add serial and parallel regression coverage for counted failures,
successive calls, ignored missing paths, exclusions, nonrecursive calls,
and abort and uncounted-error return values. Leave errno preservation
for a separate change.

Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to avoid TOCTOU issues")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c       |   5 +-
 libselinux/tests/.gitignore               |   1 +
 libselinux/tests/Makefile                 |   9 +-
 libselinux/tests/test_restorecon_errors.c | 203 ++++++++++++++++++++++
 4 files changed, 212 insertions(+), 6 deletions(-)
 create mode 100644 libselinux/tests/test_restorecon_errors.c

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index a0851802..9755409e 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1619,6 +1619,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	int error;
 
 	fc_count = 0;
+	skipped_errors = 0;
 
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
@@ -1846,12 +1847,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	}
 
 	error = state.error;
-	if (state.saved_errno)
-		goto out;
-
 	skipped_errors = state.skipped_errors;
 
-out:
 	if (state.flags.progress && state.flags.mass_relabel)
 		fprintf(stdout, "\r%s 100.0%%\n", pathname);
 
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 3763df4a..e8790485 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -1 +1,2 @@
 test-restorecon-digest
+/test-restorecon-errors
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 0f940640..d5155ebb 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -2,15 +2,20 @@ PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -pthread
 WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
+ERROR_WRAPS = getfilecon_raw setfilecon_raw lgetfilecon_raw lsetfilecon_raw
 
 test-restorecon-digest: test_restorecon_digest.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 COMMA := ,
 
+test-restorecon-errors: test_restorecon_errors.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERROR_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+
 .PHONY: test clean
-test: test-restorecon-digest
+test: test-restorecon-digest test-restorecon-errors
 	./test-restorecon-digest
+	./test-restorecon-errors
 
 clean:
-	rm -f test-restorecon-digest
+	rm -f test-restorecon-digest test-restorecon-errors
diff --git a/libselinux/tests/test_restorecon_errors.c b/libselinux/tests/test_restorecon_errors.c
new file mode 100644
index 00000000..8ad97abd
--- /dev/null
+++ b/libselinux/tests/test_restorecon_errors.c
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+static int label_errno;
+static unsigned int attempts;
+
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_lgetfilecon_raw(const char *path, char **context);
+int __wrap_setfilecon_raw(const char *path, const char *context);
+int __wrap_lsetfilecon_raw(const char *path, const char *context);
+
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	(void)path;
+	*context = NULL;
+	errno = ENODATA;
+	return -1;
+}
+
+int __wrap_lgetfilecon_raw(const char *path, char **context)
+{
+	return __wrap_getfilecon_raw(path, context);
+}
+
+int __wrap_setfilecon_raw(const char *path, const char *context)
+{
+	struct stat sb;
+	(void)context;
+	assert(stat(path, &sb) == 0);
+	if (S_ISREG(sb.st_mode)) {
+		__atomic_add_fetch(&attempts, 1, __ATOMIC_RELAXED);
+		if (label_errno) {
+			errno = label_errno;
+			return -1;
+		}
+	}
+	/* A successful operation need not clear errno. */
+	errno = ENODATA;
+	return 0;
+}
+
+int __wrap_lsetfilecon_raw(const char *path, const char *context)
+{
+	return __wrap_setfilecon_raw(path, context);
+}
+
+enum test_case {
+	FAILED_FILE,
+	FAILED_DIRECTORY,
+	SUCCESS_FILE,
+	SUCCESS_DIRECTORY,
+	MISSING_FILE,
+	MISSING_REALPATH_FILE,
+	MISSING_REALPATH_PARENT,
+	EXCLUDED_FILE,
+	NONRECURSIVE_FILE,
+	IGNORED_LABEL_ERROR,
+	ABORT_ERROR,
+	UNCOUNTED_ERROR,
+	CASE_COUNT
+};
+
+static void run_case(size_t threads, enum test_case test)
+{
+	char root[] = "/tmp/restorecon-errors-XXXXXX";
+	char file[256], fc[256], missing[256], missing_parent[256];
+	unsigned int flags = SELINUX_RESTORECON_RECURSE |
+			     SELINUX_RESTORECON_IGNORE_MOUNTS |
+			     SELINUX_RESTORECON_SET_SPECFILE_CTX |
+			     SELINUX_RESTORECON_COUNT_ERRORS;
+	unsigned long expected = 0;
+	int expected_rc = 0;
+	unsigned int expected_attempts = 1;
+	const char *path = file;
+
+	alarm(15);
+	assert(mkdtemp(root));
+	assert(snprintf(file, sizeof(file), "%s/child", root) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s.fc", root) > 0);
+	assert(snprintf(missing, sizeof(missing), "%s/missing", root) > 0);
+	assert(snprintf(missing_parent, sizeof(missing_parent),
+			"%s/missing/child", root) > 0);
+	int fd = open(file, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	FILE *fp = fopen(fc, "w");
+	assert(fp);
+	assert(fprintf(fp, "%s(/.*)? system_u:object_r:test_t:s0\n", root) > 0);
+	assert(fclose(fp) == 0);
+	struct selinux_opt option = { SELABEL_OPT_PATH, fc };
+	struct selabel_handle *handle =
+		selabel_open(SELABEL_CTX_FILE, &option, 1);
+	assert(handle);
+	selinux_restorecon_set_sehandle(handle);
+
+	if (test >= SUCCESS_FILE) {
+		/* Seed a nonzero count without depending on the root-file fix. */
+		label_errno = EACCES;
+		assert(selinux_restorecon(root, flags) == 0);
+		assert(selinux_restorecon_get_skipped_errors() == 1);
+		label_errno = 0;
+		attempts = 0;
+	}
+	switch (test) {
+	case FAILED_DIRECTORY:
+		path = root;
+		/* fall through */
+	case FAILED_FILE:
+		label_errno = EACCES;
+		expected = 1;
+		break;
+	case SUCCESS_FILE:
+		break;
+	case SUCCESS_DIRECTORY:
+		path = root;
+		break;
+	case MISSING_REALPATH_PARENT:
+		path = missing_parent;
+		flags |= SELINUX_RESTORECON_REALPATH;
+		flags |= SELINUX_RESTORECON_IGNORE_NOENTRY;
+		expected_attempts = 0;
+		break;
+	case MISSING_REALPATH_FILE:
+		flags |= SELINUX_RESTORECON_REALPATH;
+		/* fall through */
+	case MISSING_FILE:
+		path = missing;
+		flags |= SELINUX_RESTORECON_IGNORE_NOENTRY;
+		expected_attempts = 0;
+		break;
+	case EXCLUDED_FILE: {
+		const char *excludes[] = { file, NULL };
+		selinux_restorecon_set_exclude_list(excludes);
+		flags &= ~SELINUX_RESTORECON_RECURSE;
+		expected_attempts = 0;
+		break;
+	}
+	case NONRECURSIVE_FILE:
+		flags &= ~SELINUX_RESTORECON_RECURSE;
+		break;
+	case IGNORED_LABEL_ERROR:
+		label_errno = ENOENT;
+		flags |= SELINUX_RESTORECON_IGNORE_NOENTRY;
+		break;
+	case ABORT_ERROR:
+		flags |= SELINUX_RESTORECON_ABORT_ON_ERROR;
+		label_errno = EACCES;
+		expected_rc = -1;
+		break;
+	case UNCOUNTED_ERROR:
+		flags &= ~SELINUX_RESTORECON_COUNT_ERRORS;
+		label_errno = EACCES;
+		expected_rc = -1;
+		break;
+	case CASE_COUNT:
+		abort();
+	}
+	int rc = threads == 1 ?
+			 selinux_restorecon(path, flags) :
+			 selinux_restorecon_parallel(path, flags, threads);
+	assert(rc == expected_rc);
+	assert(attempts == expected_attempts);
+	if (!rc)
+		assert(selinux_restorecon_get_skipped_errors() == expected);
+	assert(unlink(file) == 0 && rmdir(root) == 0 && unlink(fc) == 0);
+	selinux_restorecon_set_sehandle(NULL);
+}
+
+int main(int argc, char **argv)
+{
+	const size_t threads[] = { 1, 2, 8 };
+	unsigned int cases = 0;
+	for (size_t i = 0; i < sizeof(threads) / sizeof(threads[0]); i++) {
+		for (int test = 0; test < CASE_COUNT; test++) {
+			if (argc > 1 && test != atoi(argv[1]))
+				continue;
+			pid_t pid = fork();
+			int status;
+			assert(pid >= 0);
+			if (!pid) {
+				run_case(threads[i], test);
+				_exit(0);
+			}
+			assert(waitpid(pid, &status, 0) == pid);
+			assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+			cases++;
+		}
+	}
+	printf("Restorecon error counts: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

