Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388008;
	b=WDhcuY5POhA5B7di3aXjJTUS0WwBAdd0ooHx/ZVm1gbWkbE3+yHUpA7bX1ZpMbN5wrW7
	 otD3L766vilGqibqcGfccwSIo7rGaDro0KYUZ6jqlu+Vf+yrv9oExthi3IPGJeVP7pp1y
	 QoamVC4kwNRegGbHAEdRg/NY8Tpb/dYjAcbQaHp8OdM4aiYLG5qWchGP1wtaFrMbIJ9sl
	 zRjI/Z24D3KAmrnvbUcFE8g4D4gcyEOUBGC1B6keS72BnUdJwVzVPrM25ayx3nkiq9nAu
	 x8Fmeojmp/ltTs7Oa33A77GRw1eF03bzqHNEzwyGJRn5uf6+K1MxJ/TQ308WvvVmPYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
	b=xHdiISqpXezfr47qA3M43gqNuyZIxdDWF8XfvPXZqy76BcQnYPDOnLSmNubdWKlEGc5j
	 /gelUj8rrKn39muH3u2gGf8NCI/lTEScDKq30PIr6fKxRs28wtgNKJwpDgc74hgeXB7QE
	 4MvQM7UuaKGGBCYcoYO6NLnaUkxo1CA43hGIWuOk92N4Akv+ZyExJN/kWe3opjeAmiQAC
	 MTKhEQW6OGdF/r2HhKZn5uuhVTTwHSyERf1LdH9hiRlE/VZh4hS9/1jfwp+TZLN47dbpX
	 QdGsmNMGa5FPPgyahlzeJsL0WtA2wzdJ7OKaRLztukMTRkleC9LeNz1tCNW4OTj0vzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccJard8F;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1B606A31A
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccJard8F
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91bb5795792so12220266d6.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388007; x=1793992807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
        b=ccJard8Fqb2Lo515EYFwjTJ0cZVrMsmkItwtgSqqgCg64NRfQX7T185wXoZN6nTCnL
         +GmKKfwQ7fprhuanomxU6pHJVsPfkqqiF5nvH8IgQohB4IxR0Avo+FrCIpBXIbPJcakg
         O/5kmQl4ueUJqQWVSc0IOImArTB/zbb5Ta8Be2Hvs3yVASJu2C1zKF9VE4g55zU3zqBV
         +oK4UlkqYC0wLTVJaj5pkzmsBvfjT+mvFag82YQviSce4+TlLqO0Z7n5yS1GAP+p5sXG
         b6g0kUkkjzdDYh+G+pqkgHtP7dLMc0No6zegXXboIaP7mv5iTkvPtnMJvYXtfeU7/dN5
         fZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388007; x=1793992807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6VEUFA0uKu2Qc0Z4j79bBYArXb6vxTIsunvirEJWSM=;
        b=W9pmt8X3kqXtk81nUXulS9oOUinEzhmIrtL8wRmp2HKjTeAXc5JYjYBAVPEH3PkI+w
         BsxS0ckCTtXdH1Zjp+szKI8PsKvZTp0kld90O5zkCqlbSBzROeWoqSDLvAgmv1cKxrfe
         OaDOMmeyGu1PKUPLAf4iAqYwp+XwEAoqH6v7gforfNv1JRD4EgWrdHgJU54QfcNTkF0o
         1m81ar4n17p4vEtkdcemZdzhi0/BfuDw8j7XrQVjr19lTR9j7+flisNOy8zLqMpYjiXR
         0mDYBK22OxKzTYG9KIn/2814axyLL3iIKzy2WmUKYZF1yjkf902W883tHf2TSdzY7s2+
         WZZQ==
X-Gm-Message-State: AFq9FYKJuQaSdQW59UYCzJmuAzoBm4P7vZgt87AXZJnaI/wBdsfG+w+0
	STlnbWZ6WHPWedmDanHowe0IZaCzq6LLu1l3+1XBBuAweVwOErmAsoWEd5Cf5rl0
X-Gm-Gg: AYBFou1m+HUFMJDiIZbzmj0ejKu52lcdwGFu/ppbBQS4eVgWrUNXJqvfmrqem8GWYC8
	6vVokGA7ZaIMX0Ku9keSTYKiiEoTsfwIyKyvVM0Z6Lprw9ZN8SMYZAar7lJpEpb7kYeuBOnQAMt
	PO7AiWWswgkmlfWQpnfLZUlGJdoZIh+CP2RUYRNneEiGJu6wGPsviuJVFIfZ0GsTgkPJFomIuQ9
	ZPvpf3DTIiP01xYW3w5SiBOBY5x1M8ZqrgglxfMdeJ4aSPAQHKhRrxxJvpsReTBgdEQvk0trnxC
	6RftqrDrqeZInfLZAi1S1MxMtdJJlDAJBpDstmWRjcnpU4UWtQZoHhX4F6UrpdS+0kwrFF8wYLS
	N8nlP5uDG08fZ6UIlGlnEy/pTEVJJxNiOlA59UokMBO19oQ58KtW6+SuXg0XK7R/mGVdgu+A8Pe
	LsxTN/a0/GBCvy6NDj7NsAwAF9n2tTUHU383eK4CJyOIp5TAhAzl99E05K4OK9NeWCrGzpzochv
	QpO0bM8QeQNA2SC9RpfR1XHFL8iBo0Bnb9zMZA6E5dvb+3Qa7bcOImP/8MkQ0nxrwcKWCBdXYqi
	C4niGX9lVhat+Gmhc9Slvnr+Fh41HXDbipm1nsFnDpqJGXZ2Agmh+RcQ1YdYG6Kiiyq4ivY+SUG
	ARo+vCwFN2r5cXgNN/fx3I7o8L4g9+lDm/yI/JO+AQaH1mqQYFkhHAWgmnNfRadUAKqDL8F2F9g
	blTTyDuNxzdAYRzz3z5jhL/bjdMu50Pnp5RNGKWiPsTihYIYMTrOU=
X-Received: by 2002:a05:6214:4518:b0:914:45c3:7920 with SMTP id 6a1803df08f44-91ca4b1cb1amr55657176d6.31.1793388006771;
        Fri, 30 Oct 2026 12:20:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:06 -0700 (PDT)
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
Subject: [PATCH 01/10] libselinux: wait for relabel completion before writing digests
Date: Fri, 30 Oct 2026 15:19:15 -0400
Message-ID: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
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

