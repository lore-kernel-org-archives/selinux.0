Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388010;
	b=IsWyjxsJhm7y7F29WJTzccc7DRQ5zIssp1axMkBAs3YHIr8Ot3bcsCHoOAqEq6OHReA4
	 ChjejP8HuUhb7J4Muo99ETqdvMouD6V3JGpkUWH9jsP3Os17tfxYQowMHjfzHLBao9ncO
	 R4X0jq6A5DHhJ2aYid3qD7RnfMM4+VxIjNm3fNEVa2X93Slaw5HxuxCXnHVy3PPhErBma
	 KDPqCCRiZc3E0NHRVo6LtoQpmOarBA3MhAtYwzm95Qq2/jSN/L1JLzp8IJlBQp/pJ+FbK
	 kdru9fWFQh0w1vVns67Wp3JK10P9+9ao7rRzv8QXsI6I9jYopbdN7MFMyWj5LlVYnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
	b=1irCu8bbxA5JbTvKmdiokfXSrumMhTzUW4lZW+7m+ybYks2LSpFZRzrhzAzvorvWMTxI
	 HsmUvC6WW43p3vVbhWME74/Q3oxvZpUIJAu6Q7pfp2SQ62fa3D9hLvBqymRglIHQagR5i
	 7HCECHnOe6+udzIxOaNdcIP59gnvzjkKhzFcHYdTg1z1p1VZ4ivMPg+bCnvIiuXAY4t4z
	 7yj9lU1rrvcL/5qT6kEdInneKGmdmMJIwh1HAIrZFvi+bpnPSlUb9mw/oIH0/PSgjSOVU
	 FAb3pDWBDZpLGK/XNezKKKhHOg7cK5b7s7Crpf1rivz3OxuP87pn90YIFvhtHRgXEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnCNlloE;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5D606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF5D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnCNlloE
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-536717a4d83so9623271cf.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388009; x=1793992809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=qnCNlloEF0Ks/jN+77YMvnnjkii0uj7ljhv7l+IsIiapeNYXhDynjqsmG1y2LX0h0R
         i87e3b1PSRZHzp5WqU8DhCxz+08qyQr7CIYcDAc+n9z2rv+C8fYa+8T6fqNMi/TrVXSY
         Mkf9Yt3GamVr1YN7XNSR6VDbTgOZNxfrHIuEr1JissBlFh0S4lUKftD2zf2+0CP4kuZq
         VFRXmXAb5xolqHr4tkcYVEI2iTmyMZhHOzWtUTjA3763edma1uY0g4SaSS2A6qSejGgl
         OqhU0TKdO0Y5SNd514rp0U+yLI/ctWm+K2OEPdcyqhV+10Y5N/jhgNlVDpAhF5/JUuJ3
         KuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388009; x=1793992809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=HvQyZ6AnajjQi6Dmn1/sm3LllHwk1rQjdStHV+aYDZpX9OQagMk0fFH1oM85iVargi
         GYv82wBWXB6smnOKmEtHgs+YWwI9tfMQp4vtSkJ7ydRVwncX8xp+TBvVlAEyHVzWwYee
         bHh63q8o+NSlK4DlzHbd9+vfnZYclICywweTokZvA+w11BcBATIu01EJyc3veDog6SXB
         UHjesR8zDJYKUUwMgfGjXurflF0YO/V8NsyGBWuQiEAFLtrc5Rb/bPuoSCDZ9R7bbnPI
         Pa9aO2Fag1C27kehhIbRw1ntbRsQ0PAI6xdo4MhMEVtPtEd79VHM/xGFNur0oKrD6qLJ
         yibg==
X-Gm-Message-State: AFq9FYIyTDO/ZdVKhElktw2xxbN9iSAE4NZAwe0wI/NsLM3S/6P+BG2p
	1ck+1CQCFdkyQgokP6zAjm53eTsXU8avCT1DsoBI2xP22bBD/KEXZaPrSOIhQp4S
X-Gm-Gg: AYBFou3QmCa6ofYwkUtqf76K902E92J2Hn6JkfX2nJSnwYWAy9mKcbKqRPouMDpFqGG
	eZPyyXgzz+pudUFnMrC1aiDrGGCuk4Tr9mX4sBAy3rquM847U9iTPHqMYrUlCnj777FQywypwhc
	I5QMMP74QFhqFtTIudH2iKVNac8nOvXbHCUTXJRcHyI4Dx6TF3hb+d+5vtUb3E9ScaHkct9S/0j
	cTdek4t1zjE/6hhAHyDsEEynQUCdSHhXRw4I6mP6hkfYFSABMc/3DXXnpI7j6LZ9KnEyw8mzv3n
	BM/S6ChAKKRRGy/dDqCObOmku2FXBjaoF1wAYrU8bRL66gK73YnKDntNSLzPVS0amZXuF1wK2B6
	/4bx8MLgDUbHYKZAy4qRIq98UETnbgu41pmFBfeubW2NNw0hxP6v9JHGc8IctsXiqgUH4yJLhk/
	kab7iMscGDgKt3VPMw0AiFuqyFYXXdKsqJLpdL4cjRsmtpseyLKlv2qqH0CYjJe7ekD12wvcF6T
	AsSAyYVeWLRIGJI4y66pO7g/X8Z3GjT8ZHKpHogQpoo+ytF22mmEu9Bb+56HOw0YnQJfslYHSfh
	6R1xRQRjFR6IXEgONRBuRDog2nUXbzck9Je5+S4Uh9XxHhdQ9Edte5MLSV3RMIeUrBni66m1R4F
	QCe/rYZdZ+RVS2b2kXgCM+wU8i/v2kjIO7VzYHG3EGJ/Vpyj0xo+/GRvpw+JsC3g5b4XkCpYqtL
	FO/uT0aWWSK2b9BuJh+TH6q+DBChUX6/EhKX4YygBndB1ZT34RkRICq9OpINtuMeK1q2LQQUqJ
X-Received: by 2002:a05:622a:4d98:b0:533:3aa2:d8e0 with SMTP id d75a77b69052e-542b7ff210dmr47890821cf.55.1793388008991;
        Fri, 30 Oct 2026 12:20:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:08 -0700 (PDT)
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
Subject: [PATCH 04/10] libselinux: skip read-open for excluded directories in restorecon
Date: Fri, 30 Oct 2026 15:19:18 -0400
Message-ID: <20261030191924.150495-4-stephen.smalley.work@gmail.com>
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

The recursive walker opens root and child directories for reading before
checking the exclusion list. A read-open failure therefore records an
error, increments the skipped-error count, or aborts traversal even when
the directory was explicitly excluded.

Check exclusions before both directory read-opens. Keep O_PATH pinning
and the worker exclusion check, which still prevents relabeling. Preserve
error handling for directories that have not been excluded.

Add 72 regression cases covering root and child directories, exclusions,
readable and denied read-opens, ordinary/count/abort modes, and 1/2/8
workers. Assert excluded directories are neither opened for reading nor
relabeled and that readable siblings are still processed.

Fixes: c1efe48ab11b ("libselinux: fix selinux_restorecon() error handling")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c        |   6 +-
 libselinux/tests/.gitignore                |   1 +
 libselinux/tests/Makefile                  |   9 +-
 libselinux/tests/test_restorecon_exclude.c | 154 +++++++++++++++++++++
 4 files changed, 166 insertions(+), 4 deletions(-)
 create mode 100644 libselinux/tests/test_restorecon_exclude.c

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 416695b4..240852e5 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1250,7 +1250,8 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		*ent_pathlen = strlen(state->pathbuf);
 		strlcpy(ent_path, state->pathbuf, ent_path_sz);
 		*rd_fd = -1;
-		if (S_ISDIR(state->root_sb.st_mode)) {
+		if (S_ISDIR(state->root_sb.st_mode) &&
+		    !check_excluded(state->pathbuf)) {
 			*rd_fd = openat(fd, ".",
 					O_RDONLY | O_DIRECTORY | O_NOFOLLOW |
 						O_CLOEXEC);
@@ -1373,7 +1374,8 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		}
 
 		int rdfd = -1;
-		if (S_ISDIR(ent_sb->st_mode)) {
+		if (S_ISDIR(ent_sb->st_mode) &&
+		    !check_excluded(state->pathbuf)) {
 			rdfd = openat(fd, ".",
 				      O_RDONLY | O_DIRECTORY | O_NOFOLLOW |
 					      O_CLOEXEC);
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 681a24f4..3aac1e7a 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -1,3 +1,4 @@
 test-restorecon-digest
 /test-restorecon-errors
 /test-restorecon-errno
+/test-restorecon-exclude
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 04967f36..6e3a5681 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,7 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -pthread
+EXCLUDE_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64
 WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
 ERROR_WRAPS = getfilecon_raw setfilecon_raw lgetfilecon_raw lsetfilecon_raw
 ERRNO_WRAPS = $(ERROR_WRAPS) close closedir fdopendir readdir readdir64 fstatfs fstatfs64 openat openat64 fstat fstat64 reallocarray
@@ -17,10 +18,14 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
+	./test-restorecon-exclude
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude
+
+test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_restorecon_exclude.c b/libselinux/tests/test_restorecon_exclude.c
new file mode 100644
index 00000000..e75b9544
--- /dev/null
+++ b/libselinux/tests/test_restorecon_exclude.c
@@ -0,0 +1,154 @@
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
+static ino_t target_ino;
+static dev_t target_dev;
+static bool deny_read;
+static unsigned int read_attempts, target_labels, other_labels;
+
+static bool is_target(const struct stat *sb)
+{
+	return sb->st_ino == target_ino && sb->st_dev == target_dev;
+}
+
+/* Only the directory read-open is fault-injected; O_PATH pinning is real. */
+#define WRAP_OPENAT(name)                                             \
+	int __real_##name(int fd, const char *path, int flags, ...);  \
+	int __wrap_##name(int fd, const char *path, int flags, ...);  \
+	int __wrap_##name(int fd, const char *path, int flags, ...)   \
+	{                                                             \
+		assert(!(flags & O_CREAT));                           \
+		if (!(flags & O_PATH) && !strcmp(path, ".")) {        \
+			struct stat sb;                               \
+			assert(fstat(fd, &sb) == 0);                  \
+			if (is_target(&sb)) {                         \
+				__atomic_add_fetch(&read_attempts, 1, \
+						   __ATOMIC_RELAXED); \
+				if (deny_read) {                      \
+					errno = EACCES;               \
+					return -1;                    \
+				}                                     \
+			}                                             \
+		}                                                     \
+		return __real_##name(fd, path, flags);                \
+	}
+WRAP_OPENAT(openat)
+WRAP_OPENAT(openat64)
+
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_lgetfilecon_raw(const char *path, char **context);
+
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	struct stat sb;
+	assert(stat(path, &sb) == 0);
+	if (is_target(&sb))
+		__atomic_add_fetch(&target_labels, 1, __ATOMIC_RELAXED);
+	else
+		__atomic_add_fetch(&other_labels, 1, __ATOMIC_RELAXED);
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
+static void run_case(bool root_case, bool exclude, bool denied,
+		     unsigned int mode, size_t threads)
+{
+	char root[] = "/tmp/restorecon-exclude-XXXXXX";
+	char target[256], sibling[256], fc[256];
+	struct stat sb;
+	alarm(15);
+	assert(mkdtemp(root));
+	assert(snprintf(target, sizeof(target), "%s/target", root) > 0);
+	assert(snprintf(sibling, sizeof(sibling), "%s/sibling", root) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s.fc", root) > 0);
+	assert(mkdir(target, 0700) == 0);
+	int fd = open(sibling, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	assert(stat(target, &sb) == 0);
+	target_ino = sb.st_ino;
+	target_dev = sb.st_dev;
+	deny_read = denied;
+	FILE *fp = fopen(fc, "w");
+	assert(fp);
+	assert(fprintf(fp, "%s(/.*)? system_u:object_r:test_t:s0\n", root) > 0);
+	assert(fclose(fp) == 0);
+	struct selinux_opt option = { SELABEL_OPT_PATH, fc };
+	struct selabel_handle *handle =
+		selabel_open(SELABEL_CTX_FILE, &option, 1);
+	assert(handle);
+	selinux_restorecon_set_sehandle(handle);
+	const char *excluded[] = { target, NULL };
+	if (exclude)
+		selinux_restorecon_set_exclude_list(excluded);
+	unsigned int flags = SELINUX_RESTORECON_RECURSE |
+			     SELINUX_RESTORECON_IGNORE_MOUNTS |
+			     SELINUX_RESTORECON_NOCHANGE |
+			     SELINUX_RESTORECON_SET_SPECFILE_CTX | mode;
+	int rc = selinux_restorecon_parallel(root_case ? target : root, flags,
+					     threads);
+	bool failure = denied && !exclude;
+	assert(rc ==
+	       (failure && mode != SELINUX_RESTORECON_COUNT_ERRORS ? -1 : 0));
+	assert(read_attempts == (exclude ? 0 : 1));
+	if (exclude) {
+		assert(target_labels == 0);
+		assert(selinux_restorecon_get_skipped_errors() == 0);
+	}
+	if (!failure) {
+		assert(target_labels == (exclude ? 0 : 1));
+		assert(other_labels == (root_case ? 0 : 2));
+	}
+	assert(unlink(sibling) == 0 && rmdir(target) == 0);
+	assert(rmdir(root) == 0 && unlink(fc) == 0);
+	selinux_restorecon_set_sehandle(NULL);
+}
+
+int main(void)
+{
+	const size_t threads[] = { 1, 2, 8 };
+	const unsigned int modes[] = { 0, SELINUX_RESTORECON_COUNT_ERRORS,
+				       SELINUX_RESTORECON_ABORT_ON_ERROR };
+	unsigned int cases = 0;
+	for (int root = 0; root < 2; root++)
+		for (int exclude = 0; exclude < 2; exclude++)
+			for (int deny = 0; deny < 2; deny++)
+				for (size_t m = 0; m < 3; m++)
+					for (size_t t = 0; t < 3; t++) {
+						pid_t pid = fork();
+						int status;
+						assert(pid >= 0);
+						if (!pid) {
+							run_case(root, exclude,
+								 deny, modes[m],
+								 threads[t]);
+							_exit(0);
+						}
+						assert(waitpid(pid, &status,
+							       0) == pid);
+						assert(WIFEXITED(status) &&
+						       WEXITSTATUS(status) ==
+							       0);
+						cases++;
+					}
+	printf("Restorecon exclusions: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

