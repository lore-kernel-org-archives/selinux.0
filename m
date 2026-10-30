Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388009;
	b=rtI3zzEdlvFfmOdlwoyL2fo8hEYXYSeE15pd6SvjaWX8dme4Ljijrzdf2CElCiOdzAan
	 Y5KsrJjKhGvVapRk2sLx4wImkFFySc0Bt/j4mUIvJ5FTwtLvR4QfkBDCub7ZmmPLRPkiW
	 PGp4YXs+Qsf4Mycvgl7otUNy8k8DTrWpUnun+tprkTwP+3yXwKT2kTLTf7qnbzkwSpvui
	 c+B9vJarUne+w7lnE3XAX2rcBq2MEt1qCVqBuoRi7A97FqIGpdGMwe4TRUOM5QOuNdUEp
	 DRrbwnT/h7PbayoZuJYCPcVGjKptryExShRzPdranYEuMypTe3p1diBBht4EWQ+vZ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
	b=bvlhhkv9Q3JykXsUE6rLmB+n5et07Cz9xKQ5CoBAwyTEX+xP1oRaQYihCyCO1VByV0LD
	 QEj38Hq9RCdjSTiYGMCBTSY+EOrHkczhd8xRbzxuuu5+GZk/0r8jsiLjxQqzQN+tsWv6N
	 xcOVTFBWGq3NwLOxdfo/hD4F8jnsHvyR//KJkvsVcDH+QbNN8s88CWuvbOCqyXX9D5oV2
	 PHIZEywIvJxmVG0cqC3tYFAnYBmnFocUkiIG8jPQ+KezXOParS6YO1yKLMyYq0n5lXitX
	 SJ1DXcKqis5nt2UuBclisEocTUgrygPHWAmhVVK1LKU82fZc9hxcD2KcTHDPwx8CiQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQtbAWej;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A7606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4A7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQtbAWej
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c719669a8so11373376d6.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388008; x=1793992808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=SQtbAWej+9U10akab6M/KDdRMroMwTWCecKNNw2TnPPftu89PcP2ETNtMjA23pq7ff
         t0yoIW3483sEtb9OqrmnSVtx+CYctYSn5tJ3W7qvecXQQbWZTbLpJAJfDxXEpXB40AoH
         Czbx0kyqTLLxtUq12aauXLVgGqasvsafgcxe/1c6QYUPVNZUErD1N81sWfxvxsjPtPjx
         HkU0wJWbBHnAVRT1rBZC5t8iwhIF2bHMamgfWRjmy98yod0Kcrb28HSOtgmxg8Dg47xJ
         2Ag9duhONkaCbjWNdmXMyXKqpCjf6lOqKx7AvE60dKWyFFGO1AfmXqxtl2/Btrn4VB8u
         aGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388008; x=1793992808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ET0zKi3oFFqgbla1Qx8rmbNMndJZavHZK9f+6EcJaE=;
        b=h7BYyfRf6OcH3atz65Eq9yuF7J1aGI+vzbR9kVDhZdNPuj1sgEfn1q26CcQwQ3KXVj
         oKPEOuGDcFV8kWS0hhaCEyywhK58eUaYrLDj4UJ0kKAwkb/fMZhMztYazrTVW5ZDWShT
         Dq2AeDdWXhmzTVhDzT3EKgX8sAilRYdpbDM/Wy9P8f32k+v8+ckSjTzABWR9c5NAskg0
         UadYmwjZY2ulJIiUuXZZCLtJjEuCNdO0Z+sadlxvQOZoFiKxPbpRU7qlcKOtMNDFqWR2
         3lxr7wRyysjsrzPSdCaT/n8J1w2a1Q6vC/yQpfOC8oFKPAUDvKXie9QZk4zFFiFjyf4n
         WyWg==
X-Gm-Message-State: AFq9FYJQXRfrbQQEslmko7/xTdG0HFPOUvuUolsYRUZQOhvcaI9y5KK1
	g7P1Y8Kc3zz6V35qh0CaW/EeiWnAZDmONWAi3OSKUR3vcV5xFrq81U4SOJktqtKD
X-Gm-Gg: AYBFou1Px91NRpf+81+h2wUSGZgCCz0oz905NXNGCov/jKjXF3MR6lA5c9IYQFoQdWg
	5dA9Rx0DvzSbBJLlxd1IY0SY7Wkx+pwcn0Kqxs59jUXjw6gi8WqbF6K7i/g/LPJEtIz6PdUxJ90
	x/jqc2xN0WPaRaWWcq1qL2U6bUldmnfIpje7uiNhHt3zUf8jrR/2XOe2WZDoFrgCIA80IUi2Wf7
	fGBUXKJQzNpMm87vh3yvlp+D9JtRrF/eExugKvXJ3WOm6Z1QjTWFUSdwxPGn5P+yq53wfXVoKcp
	xqfewPDzdr6vdTM+/vnBWtK0d7S5BFB6ZTDTloLRYIvZ2N+iEUWSLfErLfp5xUaFWUF4nNucOB1
	qjgJJOVb8tOluG7gArDdOiZuG6N6zCnrlykssh+18nXrTOA+8TfogNpFcc8SCNiLM7KnqPMP0vT
	uzknTLqIpciWMg2dQ1UKjNcCuP0c2odUj2J6jHFH0Jn+arB8uv7gtfU7nB90YYyhpWIFEfw6qWC
	8s2p3+/ETrNWvFmZuskA3+j2UmjrHaXwv9lpnYBZJRq57wMa2/1qxqi3eC5oyDTGxpyNbltE/pU
	otN8eaoUMlcJsyU7/7UV9ciE5ObFKCba6QdNbAzOIfQvmWq+CkL2050boKTaaxcX1A7E/I1Bo6Y
	F536j1s3VjCyxxDvi1uKk8BSuk898am4bExB49zrsYh82GR2M2hP0d/1b6xoDCjErJgGCNAJ9FY
	znWC5bO27cmtUXbzDdd8oPcLa6lZZn2zjAv8UxoLBD0N27dt2cPhs=
X-Received: by 2002:a05:6214:4906:b0:91c:dfc:ce64 with SMTP id 6a1803df08f44-91ca4b63e46mr42537686d6.45.1793388007401;
        Fri, 30 Oct 2026 12:20:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:07 -0700 (PDT)
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
Subject: [PATCH 02/10] libselinux: publish restorecon error counts on every successful call
Date: Fri, 30 Oct 2026 15:19:16 -0400
Message-ID: <20261030191924.150495-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
References: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
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

