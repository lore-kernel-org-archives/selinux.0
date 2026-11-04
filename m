Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804977;
	b=io66/gD2SZlfN+nAsa5bnJ69xsp8EnaiSNWYsgqQqOZWB5VBLgWEjnhl7rKj2L5nHc3j
	 gc/A/0GQ8ldMs6vpOm4RH36Gy2mtsrMJGcDW31nGKG687S39f5OmBg3qknYF+KgsSqU65
	 lU2WZuFrMKgYu77GghFEWMqjNvKzAEI33pT7wOJwqjboJGilBj3LFs/vJ/KOEsUGX5mwp
	 OQnbe3lHrt8hc2xykmX4xKrVO6xzMypAh5pbL9xzkQUY01/EnmLePzETZ6Wd9QQAVn1nW
	 5b9yzngv2Z/vVLJeXmqisf9vQTscGsjBjz4qYH+mXGP6mvC6bjjF9bDl7unUsNIRdFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
	b=BCUBCBTZHj1CYzU6LHs4NlkC6NLJW7Qt5SPmkOvvoGWN9vfwW/FIgeWsT3krKNXG61hT
	 TPDhAVfIVkALjMJ/TuKCfZTk8KW8vD54jtFaKF0GsGyEk41mM3EFhX2btBJl+Iku48reS
	 QtM0iRthAcsQ/EpUWAo9rOy9S9T/8fslyR87/jZM949hEQ9Svchpj2t5SJj5ZRNwO9OCT
	 XgcTia5hqBw1TupLSFUJv2ZduDz70SJdxgwjfJ3Ug1bFt1nGEjTdG2JipG0sO4Mmj46Is
	 Y3jGVifJgF8W6PxfgnyWmX3gxLOhYtf8H15G8N5x1L61vfxzJGzwqT0htzhvKH2dNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Istgwl62;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C726606A329
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C726606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Istgwl62
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535179e995bso7773821cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804976; x=1794409776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
        b=Istgwl62Cj3PhVqPPAD0xIBDvAPhoDKlQ6xYtaNee0321lx3NPpfI7iy4VHvEW8Wc7
         HTDYOUmgaSDkx0PY/hrT7BDJzhfUWqZ9ivSv1isbPMeOpBQQX4AX2nLgM8rg+R/IFwn6
         64cxsXfEbyggIRXRTPoEx0HUb7oBrPV9vgaRB6vFvT3xgr2TVZXQyDsiJqJG5AkIjEPr
         2+BZkeE5z9DcuYEo5DdbH3iosZo/XQh1ynU11TRbsjkyuJ2E+QCw4zPf7G2zX+LNercg
         p4n0Bpmj4Cl60TAToDPfhoG9x9KEXoFIs3PUXJepFj59Oe/OwHZUbLnoWQR6D9Yrht94
         Ba6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804976; x=1794409776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
        b=J3WYhlQ9apCjVHTS441pL7TSNmb3oc01cKXxFOae6hSp36keWCfd6C6s3CdtyZi0dR
         7ZzMPLDcTjqCTp9RzrAEf9zjJrNhx4jHykrIoucU4WhFFYR6Go+ZaKzxtTk4Ga48B4gP
         oW4JbD4yfh9RsSfoG4WHjPfW4kbk+obQ+uvbCN1Q00YMjqcFNt6l0WtdPogXpoz7mmvV
         TiF24PonCAZ/XRcfbFVWjatT3NhnIJEjC9H4eN0yHKanArAbq+srz3nczqhMBMa5BlId
         KwctCE2XgkCPgfWIF30somKp3cT5forBAKDR8qKBHBrXVeUsV9WnOBjcgCc5DjMWyncH
         93mg==
X-Gm-Message-State: APuU4Z9h42v0Y+pAAGKqa7GYbsioKEHk0ldMVvQZu19XKOMl+KAv1FlJ
	Ph5cfzV59OPMhfcclKqKXhQt2q6nDVK1DIesWEFhtNYN7tMG7Y0Ezaosg5mqpeGw
X-Gm-Gg: AYBFou2nL+IOv5QYj0sse5ku+aczApjIugpNEzJsIqJI39CW+BNmtapVsEdw8ewcN7n
	2Ma5XqJ887x1SM4zqjgENYSEyhLF6UI+/k2nvucHEb0dDWYbiYsrlOfIJ6CKLNCRfhIQznZ9UgY
	EujeKBnRVWlpbCCMR01KCqSeGDu4jJxTvEnIf8hmN7wT8E46Dgzu5dZLGSvpR6+ZhKoeQ9IBBs1
	yuuh/CQhOdYbqfFMrqApsGvADgOd5q592QCQ4C+NCZO1Wgw2YbE9ikwO184r6LEljO0ExqbYdic
	yWLUayA2jfBvjFVvXAiD4FnIumC3uISapvBQZmjDpEYOT407lM3bFa/fda4D841uoqH9aj0mbMt
	Hxg61etZJG8V/c5otVEitgyhW6gzGsEgfeN/5eqkTmR37Mt4+pYPNyZNmpU2YJnNm6ndn8sNJzx
	6ir39H6U7x1Os4QuLA5Wl5ib9SGuUPgs8p1GwsASu9nVsX5T7NK3nrErsDwpMYOUN+haQJOqBKs
	64iF42bqUIB+yI1xhmqpuSdYWa78s1B8GLWCtgp27tqGcO/0xw/D/pKSzqn/IMVjRtHvZKqTOAr
	StAxAlnZVhnKzrkpAOxjrPvY+KYgstR5GMf1A9dmaKTX3hhWAveiq3qN9/NE50PQ9s7dpH/PLrP
	jIsfxM8x00SwbGBqKphf0yzvFDglSIbRdgIVKyyDvqeJXybJqQj2zHW21k1grr2PJhZQAZorWzK
	IvvTys3bLdjYFzVF6yLZrbyeuP1Xg7pio90DWqkxFDzILVOCxnMYk=
X-Received: by 2002:ac8:5d8c:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-542b3d6f83dmr266767031cf.3.1793804975788;
        Wed, 04 Nov 2026 07:09:35 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:35 -0800 (PST)
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
Subject: [PATCH v3 01/20] libselinux: wait for relabel completion before writing digests
Date: Wed,  4 Nov 2026 10:08:56 -0500
Message-ID: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Parallel traversal can reach directory EOF while another worker is still
relabeling a child. Publishing the directory digest at that point can
cache success before the child fails, causing later restorecon runs to
skip the failed subtree.

Track active relabel calls under the traversal mutex and wait for them
to finish before publishing a directory digest. Broadcast when the last
call finishes, recording its result before releasing the mutex. Recheck
abort state and reacquire the current stack entry after each wait.

Check synchronization initialization failures and include condition
broadcast in the weak pthread capability check. Leave the d_type
optimization unchanged.

Add isolated regression coverage for serial and parallel traversal,
shallow and deep trees, successful and failed relabels, abort and counted
errors, disabled digests, dry runs, and retry behavior.

Fixes: 86fbd1f66da6 ("libselinux: selinux_restorecon: write digests during traversal")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/Makefile                       |   4 +-
 libselinux/src/selinux_internal.h         |   8 +-
 libselinux/src/selinux_restorecon.c       |  49 ++++-
 libselinux/tests/.gitignore               |   1 +
 libselinux/tests/Makefile                 |  16 ++
 libselinux/tests/test_restorecon_digest.c | 233 ++++++++++++++++++++++
 6 files changed, 300 insertions(+), 11 deletions(-)
 create mode 100644 libselinux/tests/.gitignore
 create mode 100644 libselinux/tests/Makefile
 create mode 100644 libselinux/tests/test_restorecon_digest.c

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 00b52aa7..be3923f0 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -64,6 +64,7 @@ clean distclean:
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 	$(MAKE) -C fuzz clean
+	$(MAKE) -C tests clean
 
 .PHONY: fuzz
 fuzz: all
@@ -90,4 +91,5 @@ clean-pywrap:
 clean-rubywrap:
 	$(MAKE) -C src $@
 
-test:
+test: all
+	$(MAKE) -C tests test
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index c32bb4c0..9df6eadd 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -81,13 +81,15 @@ extern size_t selinux_page_size;
 #pragma weak pthread_join
 #pragma weak pthread_cond_init
 #pragma weak pthread_cond_signal
+#pragma weak pthread_cond_broadcast
 #pragma weak pthread_cond_destroy
 #pragma weak pthread_cond_wait
 
 /* check if all functions needed to do parallel operations are available */
-#define __pthread_supported                                     \
-	(pthread_create && pthread_join && pthread_cond_init && \
-	 pthread_cond_destroy && pthread_cond_signal && pthread_cond_wait)
+#define __pthread_supported                                                  \
+	(pthread_create && pthread_join && pthread_cond_init &&              \
+	 pthread_cond_destroy && pthread_cond_signal && pthread_cond_wait && \
+	 pthread_cond_broadcast)
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index fbadf367..a0851802 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -963,7 +963,9 @@ struct rest_state {
 	long unsigned skipped_errors;
 	long unsigned relabeled_files;
 	int saved_errno;
+	size_t active_relabels;
 	pthread_mutex_t mutex;
+	pthread_cond_t idle;
 };
 
 static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
@@ -1218,6 +1220,9 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		     struct stat *ent_sb, char *ent_path, size_t ent_path_sz,
 		     size_t *ent_pathlen)
 {
+	if (state->abort)
+		return 0;
+
 	if (state->root_fd >= 0) {
 		int fd = state->root_fd;
 
@@ -1243,6 +1248,9 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 	}
 
 	while (state->depth) {
+		if (state->abort)
+			return 0;
+
 		struct walk_level *top = &state->stack[state->depth - 1];
 		int pdfd = dirfd(top->dirp);
 		struct dirent *de;
@@ -1260,10 +1268,15 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 					return -1;
 				continue;
 			}
-			/*
-			 * Completed directory traversal; set digest
-			 * if requested and no errors.
-			 */
+			/* Enumeration can finish while another worker is relabeling. */
+			if (top->write_digest && state->setrestorecondigest &&
+			    !state->flags.nochange && state->parallel &&
+			    state->active_relabels) {
+				pthread_cond_wait(&state->idle, &state->mutex);
+				/* Another worker may have popped or grown the stack. */
+				continue;
+			}
+			/* All relabel results are recorded before publishing a digest. */
 			if (top->write_digest && state->setrestorecondigest &&
 			    !state->flags.nochange && !state->error &&
 			    !state->skipped_errors &&
@@ -1476,8 +1489,10 @@ static void *selinux_restorecon_thread(void *arg)
 			}
 		}
 
-		if (state->parallel)
+		if (state->parallel) {
+			state->active_relabels++;
 			__pthread_mutex_unlock(&state->mutex);
+		}
 
 		bool updated = false;
 		error = restorecon_sb(ent_fd, ent_path, &ent_sb, &state->flags,
@@ -1486,6 +1501,9 @@ static void *selinux_restorecon_thread(void *arg)
 
 		if (state->parallel) {
 			__pthread_mutex_lock(&state->mutex);
+			state->active_relabels--;
+			if (!state->active_relabels)
+				pthread_cond_broadcast(&state->idle);
 			if (state->abort)
 				goto unlock;
 		}
@@ -1590,6 +1608,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	state.skipped_errors = 0;
 	state.relabeled_files = 0;
 	state.saved_errno = 0;
+	state.active_relabels = 0;
 	state.stack = NULL;
 	state.depth = 0;
 	state.stack_cap = 0;
@@ -1767,15 +1786,30 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		selinux_restorecon_thread(&state);
 	} else {
 		size_t i;
+		int rc;
 		pthread_t self = pthread_self();
 		pthread_t *threads = NULL;
 
-		__pthread_mutex_init(&state.mutex, NULL);
-
 		threads = calloc(nthreads - 1, sizeof(*threads));
 		if (!threads)
 			goto oom;
 
+		rc = pthread_mutex_init(&state.mutex, NULL);
+		if (rc) {
+			free(threads);
+			errno = rc;
+			error = -1;
+			goto cleanup;
+		}
+		rc = pthread_cond_init(&state.idle, NULL);
+		if (rc) {
+			pthread_mutex_destroy(&state.mutex);
+			free(threads);
+			errno = rc;
+			error = -1;
+			goto cleanup;
+		}
+
 		state.parallel = true;
 		/*
 		 * Start (nthreads - 1) threads - the main thread is going to
@@ -1807,6 +1841,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		}
 		free(threads);
 
+		pthread_cond_destroy(&state.idle);
 		__pthread_mutex_destroy(&state.mutex);
 	}
 
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
new file mode 100644
index 00000000..3763df4a
--- /dev/null
+++ b/libselinux/tests/.gitignore
@@ -0,0 +1 @@
+test-restorecon-digest
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
new file mode 100644
index 00000000..0f940640
--- /dev/null
+++ b/libselinux/tests/Makefile
@@ -0,0 +1,16 @@
+PCRE_LDLIBS ?= -lpcre2-8
+CFLAGS ?= -O2 -g -Wall -Wextra -Werror
+override CFLAGS += -I../include -pthread
+WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
+
+test-restorecon-digest: test_restorecon_digest.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+
+COMMA := ,
+
+.PHONY: test clean
+test: test-restorecon-digest
+	./test-restorecon-digest
+
+clean:
+	rm -f test-restorecon-digest
diff --git a/libselinux/tests/test_restorecon_digest.c b/libselinux/tests/test_restorecon_digest.c
new file mode 100644
index 00000000..53a5cbef
--- /dev/null
+++ b/libselinux/tests/test_restorecon_digest.c
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t release = PTHREAD_COND_INITIALIZER;
+static bool block_relabel, fail_relabel, ready;
+static unsigned int pending, attempts, barriers, writes;
+static unsigned char digest[20];
+static bool stored;
+static bool nested;
+
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_setfilecon_raw(const char *path, const char *context);
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size);
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags);
+int __real_pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
+int __wrap_pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
+int __real_fstatfs(int fd, struct statfs *buf);
+int __wrap_fstatfs(int fd, struct statfs *buf);
+int __real_fstatfs64(int fd, struct statfs64 *buf);
+int __wrap_fstatfs64(int fd, struct statfs64 *buf);
+
+/* Keep digest coverage even when the temporary directory is on tmpfs. */
+int __wrap_fstatfs(int fd, struct statfs *buf)
+{
+	int rc = __real_fstatfs(fd, buf);
+	if (!rc)
+		buf->f_type = 0xef53;
+	return rc;
+}
+
+int __wrap_fstatfs64(int fd, struct statfs64 *buf)
+{
+	int rc = __real_fstatfs64(fd, buf);
+	if (!rc)
+		buf->f_type = 0xef53;
+	return rc;
+}
+
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	(void)path;
+	*context = NULL;
+	errno = ENODATA;
+	return -1;
+}
+
+int __wrap_setfilecon_raw(const char *path, const char *context)
+{
+	struct stat st;
+	(void)context;
+	assert(stat(path, &st) == 0);
+	if (!S_ISREG(st.st_mode))
+		return 0;
+	assert(pthread_mutex_lock(&lock) == 0);
+	attempts++;
+	pending++;
+	while (block_relabel && !ready)
+		assert(__real_pthread_cond_wait(&release, &lock) == 0);
+	pending--;
+	assert(pthread_mutex_unlock(&lock) == 0);
+	if (fail_relabel) {
+		errno = EACCES;
+		return -1;
+	}
+	return 0;
+}
+
+/* Release the blocked label write only once traversal reaches its barrier. */
+int __wrap_pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
+{
+	assert(cond != &release);
+	assert(pthread_mutex_lock(&lock) == 0);
+	barriers++;
+	ready = true;
+	assert(pthread_cond_broadcast(&release) == 0);
+	assert(pthread_mutex_unlock(&lock) == 0);
+	return __real_pthread_cond_wait(cond, mutex);
+}
+
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size)
+{
+	(void)path;
+	assert(!strcmp(name, "security.sehash"));
+	if (!stored || nested) {
+		errno = ENODATA;
+		return -1;
+	}
+	assert(size >= sizeof(digest));
+	memcpy(value, digest, sizeof(digest));
+	return sizeof(digest);
+}
+
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags)
+{
+	(void)fd;
+	(void)flags;
+	assert(!strcmp(name, "security.sehash"));
+	assert(size == sizeof(digest));
+	assert(pthread_mutex_lock(&lock) == 0);
+	assert(!pending && !fail_relabel);
+	if (block_relabel)
+		assert(barriers && attempts);
+	memcpy(digest, value, size);
+	stored = true;
+	writes++;
+	assert(pthread_mutex_unlock(&lock) == 0);
+	return 0;
+}
+
+static void run_case(size_t threads, unsigned int extra, bool failure,
+		     bool deep)
+{
+	char root[] = "/tmp/restorecon-digest-XXXXXX";
+	char file[1024], fc[256], directory[1024];
+	FILE *fp;
+	int fd, rc;
+	unsigned int flags = SELINUX_RESTORECON_RECURSE |
+			     SELINUX_RESTORECON_IGNORE_MOUNTS |
+			     SELINUX_RESTORECON_SET_SPECFILE_CTX | extra;
+	bool cache = !(extra & (SELINUX_RESTORECON_SKIP_DIGEST |
+				SELINUX_RESTORECON_NOCHANGE));
+	struct selabel_handle *handle;
+
+	alarm(15);
+	nested = deep;
+	assert(mkdtemp(root));
+	strcpy(directory, root);
+	if (deep) {
+		for (unsigned int i = 0; i < 20; i++) {
+			strcat(directory, "/sub");
+			assert(mkdir(directory, 0700) == 0);
+		}
+	}
+	assert(snprintf(file, sizeof(file), "%s/child", directory) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s.fc", root) > 0);
+	fd = open(file, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	fp = fopen(fc, "w");
+	assert(fp);
+	assert(fprintf(fp, "%s(/.*)? system_u:object_r:test_t:s0\n", root) > 0);
+	assert(fclose(fp) == 0);
+	struct selinux_opt options[] = { { SELABEL_OPT_PATH, fc },
+					 { SELABEL_OPT_DIGEST, (char *)1 } };
+	handle = selabel_open(SELABEL_CTX_FILE, options, 2);
+	assert(handle);
+	selinux_restorecon_set_sehandle(handle);
+	block_relabel = threads > 1 && cache;
+	fail_relabel = failure;
+	rc = selinux_restorecon_parallel(root, flags, threads);
+	assert(rc == (failure && !(extra & SELINUX_RESTORECON_COUNT_ERRORS) ?
+			      -1 :
+			      0));
+	assert(!pending);
+	assert(stored == (cache && !failure));
+	assert(writes == (cache && !failure ? (deep ? 21U : 1U) : 0U));
+	if (block_relabel)
+		assert(barriers > 0);
+
+	unsigned int before = attempts;
+	block_relabel = fail_relabel = false;
+	rc = selinux_restorecon(root, flags);
+	assert(rc == 0);
+	if (extra & SELINUX_RESTORECON_NOCHANGE)
+		assert(attempts == 0 && writes == 0);
+	else
+		assert(attempts == before + !(cache && !failure && !deep));
+	assert(unlink(file) == 0);
+	if (deep) {
+		for (unsigned int i = 0; i < 20; i++) {
+			assert(rmdir(directory) == 0);
+			*strrchr(directory, '/') = '\0';
+		}
+	}
+	assert(rmdir(root) == 0);
+	assert(unlink(fc) == 0);
+	selinux_restorecon_set_sehandle(NULL);
+}
+
+int main(void)
+{
+	const unsigned int options[] = { 0, SELINUX_RESTORECON_ABORT_ON_ERROR,
+					 SELINUX_RESTORECON_COUNT_ERRORS,
+					 SELINUX_RESTORECON_SKIP_DIGEST,
+					 SELINUX_RESTORECON_NOCHANGE };
+	const size_t threads[] = { 1, 2, 8 };
+	unsigned int cases = 0;
+	for (size_t i = 0; i < sizeof(threads) / sizeof(threads[0]); i++) {
+		for (size_t j = 0; j < sizeof(options) / sizeof(options[0]);
+		     j++) {
+			for (unsigned int fail = 0; fail < 2; fail++) {
+				if (fail &&
+				    options[j] == SELINUX_RESTORECON_NOCHANGE)
+					continue;
+				for (unsigned int deep = 0; deep < 2; deep++) {
+					pid_t pid = fork();
+					int status;
+					assert(pid >= 0);
+					if (!pid) {
+						run_case(threads[i], options[j],
+							 fail, deep);
+						_exit(0);
+					}
+					assert(waitpid(pid, &status, 0) == pid);
+					assert(WIFEXITED(status) &&
+					       WEXITSTATUS(status) == 0);
+					cases++;
+				}
+			}
+		}
+	}
+	printf("Restorecon digest completion: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

