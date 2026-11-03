Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732009;
	b=YjBZKMLx17FUAdjZ9G1pQsEDvKjl6SM8zJWYdnOt4K/bgGZA2EYzTEFEmRXdnYlj/HaU
	 HmMqoPrumVdj7/P5xSjnTu44WDIS4MhcOypLQ27EB5Z+3fbUjKeo5CLIoCfd1OylBIZKE
	 GyCTCWFfTCO98qwOwaTqIh8ssCKgSjQq+O5rZcoFfqQ7VlfvLEZYpVnwVU8Z9Lx1wKupb
	 QmN9Syk8X87jPRQ7QT9Gb4I/MG+taQXQuOCV6YysBzTY5hmcwaBzNS7nEIXOB4d/R45df
	 h4oWsjZRMLGl22VND0NXSfKUHvjpf9gf3yrOfMuhZYnsMAjej0K+VJQbln30NFpfFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
	b=qhk9pkMJ80R9QkEkysrJrQJ9FhzWziSAkbi9epr4xtcv8YkUULQ81GxckXkIZ1EKdXJy
	 jLvlJcnSX2QYUZf/9Dvk+qfCbbCUKHu37m4+UALQ1QFAzXfMJw9wkVR099mp3CoRizhoW
	 Yf+/VwVyQvVOQdIOT6Iqd6ssign1pOI/J/itPLRL0c+iTY90c6lfFuZokUNDKzWyN6QlY
	 53CK2q457zH7lcWc2M2bu+ag7qxomAz1oefcAYWF2k9XnV18EOLTEKmQsTiMf/cadb71/
	 oKwahInYprrPLFjSCB4pZzWDg5AsHZUw89zNxvyBZXhwYN/FGs2BV1PXM86VKb87tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUqqMvzL;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4890606A337
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4890606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUqqMvzL
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c5e31bea9so70987396d6.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732008; x=1794336808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=TUqqMvzLMvsjjfcHiB1WpO8OFSV8QYPaJ/w9d0sIyv924cKC8wnNX8dnIaVWv8AZWL
         T8O59+QHjw7TTkcyOsqR5ZavQH3cAnCEkZbX7ZsaBghsSwsvfYqBqjiBctyRureN8YLr
         NaX0EJcke6dshAnbI8dAfiD6Hiz/5KeMc+vbk+tpS/0/k65ETybCbxoKA96EXIYRulP9
         lf9yS2WUC74sASyICVoyIvlww5vWpkp3Sr0KdVR3PCuVnotdcUwnalfei6RgugU0MyV1
         4moifnFPGRZni6hBcuG5ozd+zX3FC993LktFRgYRUCtP5YkP/alJzTYP2y7IjBneZ6yL
         aBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732008; x=1794336808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=0MMLrpbgU4pr40LvJlaIwJGpZeQ5/04C9BHCRstjo6WPOh/xwUGwFp3Ol1fsKpFxLv
         fEVwtotLNDU6oFMrVBxAEmRxjmu6SCrcnOD4mRbilJsyCdo++liF+hFMys5+sqjJW6at
         3WNryfgOynIcqevwuMDWYDn3s4Ey8vBvsdXlllMvZdPBRqOwvHVjS454DMafD4a6pBhB
         FbsdOwZJm4axSz15WwTiEGeSVBQGVuiN+ULR0jKkiQg8IFS6DPdeany9baxAt6KY/vt3
         lbWD0Fq1dZFSibybX5cvvSDiP0h3KJZ9c1WgAH1pFAjqVXJ4i2beGmyKoaWIa8mD4EWZ
         e1tw==
X-Gm-Message-State: APuU4Z/WjTJS4g8Bg3CZ2kTwciewVgSbpXXcgRvsOgNYdo6Pf67kAM7v
	EFedc12euFrTvRu+OtqkJ9ejzMxrBnjBTOTZXlNorQ80l0ulsvT4T2iz9JjJ+fUt
X-Gm-Gg: AYBFou0PY969xy+qI83ul70rkY+4TEomRZQQKEIqZ2h61Hq2YMg6mL7ZOlxDsPYIzUu
	VcCIsu6iavPKX/UXD/IdQnn5tVghCyM1jNT0Ko5xKyqrlj3i6iuBFJnM5ADJrSh5TUtzlU3F2Ur
	yRBqXQlENbjHdoxWBLS2nZdl4jCVv+lAMg54ruzlOP/v8ULtl5GGyP8T18ZOxCQb3Kjf9DsSQk7
	ojN5WlQqtqqvs6+HpR3CUdBymM/I3CkJK9J74kcfxbNyCwp83XKLrVo1jW4tBuKTr6FHluJNglK
	koWgarn9nNgJulrcPXwJJaouFdXz1MFNjY1dhI3TQ21l6L6rka+/6u0iI36e1uuwI0/aU+9+7x3
	9jdmOcJUDd9GzblrX1QmP601O3T+DYF4WQJx1SZ8E61i89y1WxxLDkJBbSD8WKSesTPt55JQvK2
	/qD6MQVjNzrmEvb2BXhgaBzOt7HU/ZKjsiAyiQSpMXbo4rpR/V0jWE4i954NEJJLGOBXXxywZms
	60dnVwg5RfdIFBksfBFzaYQpeweo78LOXxtWcAjKvd4hcoKMZp4JmEnN1YrJeePGzcTtnidpeA8
	5Aw0YqP5CIBmZkMQ3E+oY/8zfw7xFBNX07lHWXax4VV37Zswcw68FZunoFZ+KN3IQgw7FzVe74x
	OtxtMhcATuvsNZx52xlJnusN6nyuOz7IcBXI5PLjDzf2AGbDWkj1WZl9EpsgssZt7E2NOzSc1J0
	s86KA5x+2pSQVfBS9luiawMW1r9oMk0vBBHFkdH7kATFqiMjs073A=
X-Received: by 2002:a05:6214:570d:b0:914:525b:8ff3 with SMTP id 6a1803df08f44-91ca4b6d614mr243019046d6.23.1793732007426;
        Tue, 03 Nov 2026 10:53:27 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:27 -0800 (PST)
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
Subject: [PATCH v2 04/20] libselinux: skip read-open for excluded directories in restorecon
Date: Tue,  3 Nov 2026 13:52:51 -0500
Message-ID: <20261103185307.45924-4-stephen.smalley.work@gmail.com>
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

