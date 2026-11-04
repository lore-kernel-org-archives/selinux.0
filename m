Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804977;
	b=SAKKEsn/LnJ2Imt3hyFExEiVftK4gfBdRNtlTNYEUQ+x509w8hZ6V9itkEAxPcpe7QOL
	 I/+o9KGQAGOUUf8RYowtzhttWzsoGQGCeIl9eSHUf/JkO+OdtJPViad84+au4J/t8ix6D
	 gEL89Ull0QOMU29AyU7c4whlbBYZsHT+O5e8EvPtHDeVCKCZDCLqEhtED/rn4FnyzWQMo
	 MOb7Tv/sqCbIQsOdlBDc7J3ItjPoVi0bj10A6SNI6NYdAjc2uD+WfOsTnbndpfKmUwNqF
	 BbifWV8JXmRvJHRfe4zDwkirUF3e+FlzBnm8X+8cZ+H7F6gqhlZijZjwLuYeVqJfdcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
	b=X3VupW8ItbkHaH5NhNtcq0bN67gt2cKyJiERR6+K7S9FJFI82D0DoxdRv4P5b4r0/JG8
	 P6DCUTahxaNQ0179J8Ns3Of1bzwmYkQuLEfYFtlZZ4KRzU+2n5wlRitLTpeLmq5fWiMsr
	 yMEkBQuXihWSpC+vd9IdMIqSN/el0Hf3ejdD0TddyCqAUscpTazSiouWjfRv4ai99iWdy
	 xHb03uFQVzAhl3HwOStqN393mU4/6cne/omicwwoBFrOrnhlQTHI//+xq6EMY58trPvyQ
	 UvH83LTyIlKuwIhc8OZQVRlRh+57KjR2RvKfPwfJGLVnAH9uQ7AySQF4CsJrWIx8nvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQwuKYzD;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C540606A337
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C540606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQwuKYzD
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53669f7b518so7887081cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804976; x=1794409776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=KQwuKYzD4Jozl/KMk9BJlhrU2CgyknIaLsZa+sZDh/6xq4fXI8PFbFTrhD5geiSVsO
         lCLLjie5yF+zf2NDb45+gC3kjqbbzlKBI45k/ybb4Ycl/DMEC8elDmil2zqQaTdm4OJO
         XElL2DSravxkzBlU9BXT2YlW0057p7ozP5D0Ec1wgkZb3xDwYmsuntipm5U9C/oUzWVw
         QzvME6NhgzfwZa6E0IWwHa4YZrG9Q+0kDiAzeJxaWujdQA344uOjvQ220Q7yDq7f5l0d
         ulZRmnUXYd2Bm9B8Uvv1flPkCzTo/k1+y2bGItrIw55DAXCAIYfJTQwYaifdCSKJQEwo
         17pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804976; x=1794409776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=tmWXO6QSyvHmCziWhR5oexZ7yLXSS6y+/1yQ/XVY5uma1Iu5uJnb9HdUGQoP8zOFnb
         otPNbPc4ytjIHH3OCH0h/9uKZzo4xg4n9IQnXEY3MvdaZLO2I3rnBEwPAlSk1dljoZn/
         czE/81amBitY5f5vag8TX0DID/KQH0VEwwnEoiUv96RZJn4haoggnacAQdeN0BdbVpM5
         cxHPt0eKBnC4vk8qQkQ8V5Cn48/Q3guODNHitTBqC9VUwecqslnkSX55n3yaJn6fIcNP
         2OPk4GcGH4A3KzoTzNo9CK0AZhOLwKggE/xMcm4MKAhDBLegAOBR3l6HbEVI0s3Yvxhk
         Rhrw==
X-Gm-Message-State: APuU4Z8wxmEZFvZnCeIwujoHpj6tnleMFjqhxKt87ztsZvoA/OieUcaO
	ceh+iOdy7JjMJxZUUvlop0SF2CzozoeoZh+0vkzIQBxo0SuDKObQIsIBJr9/seXD
X-Gm-Gg: AYBFou38kvaPESSu56x3gy8j0ppv8KMLDeMybKdjYaPjkIKzRmZoW0sSWCLu6jlHyvj
	FMaPo2QiHAyGtz5h1TUW6KVtvwUVJAA42cLDM6osd3Qu+WH4HG0IFhbYSYYqlE4sBGUDhWgpNc+
	WhCZc8FE5tyQ/93ZS3k4a0O45Fp50EZl8qDOeoqmIosnr6pc1cNtWcW7S3bpi499AiAL69I7EA6
	/4mUrXvgrlSbmEBeXVAyQiUPWUlxgTMaSPHxiorYdOfvCZLWV9IfNiLkGgaqGDyvRcupHVP+52T
	SEUbSDDOZFxdCfGo3DfAd5sQAEh8jQQ6kAIWNqbOSAdOJwtyevgxOuU6gcW64rqZCcBEuy7HyyW
	iveiF7Q88wikn9dxTXE19V4RUXPuNdtzrBfEic4Me5jFE849zNbY5PylkuqXtAKUjMPupwS/Xfa
	kzcp957xH9QRyaz99uuVXw9nf3zJRBjMMm5Iyjudm393xn1G0Jx0FURVT7Wtq08mSAJnY8W5KfO
	3FX4ye6N/krk7y4yrW+U+hPsmeHq2uCkr/o6sLhsi3R900Wd56fAeCM6cvOxSdcOqpfqs5JI7wt
	DwssKcHTD/JVGiuYKvWnS6i8ANanJS98anqLjDgGadQzGWkuxZngy/5xepAvuNb+CCYsMJhSDAo
	GGl2/c9COTawb1PtXveKw0DgYE+V8dwLet6L2rzKtDUMneX+CzcLjqeUxUAePN86qpaYp2kdnzE
	StypUiCJyCqTZ5PyeI3EuYISrDSczv+eeADgcbP4Z+RjebEq+5Xoo=
X-Received: by 2002:a05:622a:251b:b0:535:9686:b9e9 with SMTP id d75a77b69052e-542b405b6d7mr287769331cf.11.1793804976518;
        Wed, 04 Nov 2026 07:09:36 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:36 -0800 (PST)
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
Subject: [PATCH v3 02/20] libselinux: publish restorecon error counts on every successful call
Date: Wed,  4 Nov 2026 10:08:57 -0500
Message-ID: <20261104150915.175923-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
References: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
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

