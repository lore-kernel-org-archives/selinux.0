Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732009;
	b=njTog9tOyIMRiAwL9GF/HZQsVVJxRpRvyhlHoiuNbkDAg9/IA4J0xYP5AxxNHJKv02e6
	 s7CY89R9Hq48enkSQyiUfjZBtMu+5KfXi/g+0tqRxCbOzOzhK1sm717xQ8DBa3ncpfHpu
	 BXk7dYK87vXVMTo3xRsXxnwW/w8y+wQAtYge/YHWkkebHyOXe2klHaKeZzAKU0DPUqvn0
	 w9HXnQXmYCHpW3MOsyOSBeMnkE1xcKzLH6RPdikexfRqdSYYs9gsvqK8afhpp0tjywzyC
	 z4WOAa0h5+eit/QRmb9vE2DykkCaHfIOq5ASDzehSqCcJPGLJFjFA/9V8X/znBRjN6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
	b=qUph7qIBx8EkdnNi99upNoepBB91BOJkcDeZC+neB95UUnwKrreMMlcv/WBrSSc8DoKr
	 v8EHxPvrvvi8NrLyoD/6qrA5bJx9lJSOUsdhYgzS3+cc2hUPWeaczTDifodELcwleJf/s
	 58Cs0F+3CIQAAVZmxL8/TIxUDehdgxH2HaFF7PWj+pVG/xTfkjHhKcFEtiOV2OMiqKhyt
	 LuDDQfujbSpJXXogwPSlqR4DRFIafxAtG74GR/FRab9j5XSjD5cjbEcu8u13jfsN33sjK
	 5kRsVMs4Z8x06LtifKs0EMNy7X4NrAPXhjCv4wAMbtBs+KsUhiml1g7ieigugg0/daQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iR5QxV9A;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C9606A32D
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692C9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iR5QxV9A
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c76540d0bso51648326d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732008; x=1794336808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=iR5QxV9AOzwARb8dBfPUti8kep0Nzb12g6riGmKG4e0mFJXRMp0aPkYZHokFjADh35
         ekSez4j6yrmpYhJs2nzG4mgyxdPkoZUh7t5sUxzYkIh8q3gwC1IAvg8cFI/HC89UQ3+0
         L5f44seJpliKB+dmYdxH51OFyRq74pwbADVPcdJlTzpkaAqi8rBNCrWYULaN9h07Iv8W
         Q7fO590pAdxMC4g5S9jJN6EnMgu8Kp7rKR5qnivbj4mnkfas0kX9HaD1l3SflWU1Pv2L
         bf1pdGtLPYOCXW3980t0mgpElT4R9L08SkRFGRLt/o2LwouCAa3O3/ex4KDJSe0pwbot
         ffrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732008; x=1794336808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=s/tps4pfWNt0BUzdFkgjDa+qzMgJPygTOMy2zC8FICm8GCRQJknvzyVHyuZtmJJb7T
         gpnMLc4p1ZHUO6udrhAMchdRCFOXXsKsBlm+zD/CVaTQYW1jSKWjm/JdmVn6Aohq/a1r
         hAw6o/5IvoqrvlFw1DFv0bXoffwcupg+ZJ5StNyhz1xapjCRHV1V6tyFHOlJUSQe9EQX
         Cr7nqF61mywX8AP73bU37SgnITgltaWs8AMuj6y/RPH5kPQla1WVp0VAouzPDd49ebf4
         TPfzSjSysf6nhegRRQRgjAOC95BkKQBMG1c/y+izYq+JVB6vqSyDt8IZGLL5u2YQyZ/5
         IeOQ==
X-Gm-Message-State: APuU4Z/sqz2gvFm+kKNoGFw199fGnzRcjSeM/rqKwuh+8oKmJwebx4tY
	qs3Qsbzv0gBSN9XoKTC83AfItZEtDe5XrvDXf1U1fJz1M7IS9n+m8AzziFFqZ1A/
X-Gm-Gg: AYBFou0H0Mrcmc/EXxFDBKubWM4mPw/zqUeIaB8oKVI5WNYJQfMuFnxi+oRy8lW04+i
	Z9SDnTeqp6EFpKRitIoD29QHI7r4PS6AkNzw/6S5tKsYoaKF+bs7KDryS4+pkuDi+0TMqiGHPEh
	+8nucfWjTmVwI29fa6kEGwXZmH4EXMKPnK0i+YiuEPYDI+jcuektj04yzF1+N08PsXcvsGWx3qo
	I6QkNTPwjYs2u5+wl6OnCPA+qvOvvJUx4oJtJd53gHKNPbxL76ySSr6RpfFYAQd8+vUHSVKnZ8t
	4m2vRhrLewlBV5XEKBP3YEI0nVDY07VNLl4nmug0LfaQr2keNXBN9liSLp0FrsrzKyhv3S1LzI8
	QJDHimYM2ZzRqvagr5d3fzGv95h14Aky34ozedm8p5KxkrT7WvEONzDKiOu4hIFrYZQvkTAZ7OG
	uEw9/h2oZ4Q8qzdZK1jj56d2gcaIAqPeEiTXEKOID64DNhoCKNNIlP3L0BW0ofOhcjBnux6cOvI
	w7AgXyc0xqdOyhktrs+MkYtpC9IrIH85e9khBZJZ2D8VxEPbsDoz/N3LLhDNnbeuTBDgCI57XyW
	NuR4MRDntbn/Sp5Gtt6pB9+7Vm6Hq7e1NPLWdzfeGQUSEe4Bkl/AJLUKaQ/VtHRidSYP1/dp5jN
	3BcoEXlQ2dw0gBlECzzOg5I8Vz9KlCrZpg09MEH8yuq6X/uSu+GeCdPtSXp9/Eh6D5/qG67KNLK
	ap1EfA+RH5pWvdwgZuqpl2I/HeNF4/Pyxne+ptDr/5LiXaTWKu9/8=
X-Received: by 2002:ad4:596d:0:b0:91c:7a0d:4fe6 with SMTP id 6a1803df08f44-91ca4b7fd6dmr224774386d6.25.1793732008017;
        Tue, 03 Nov 2026 10:53:28 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.27
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
Subject: [PATCH v2 05/20] libselinux: skip read-open across restorecon device boundaries
Date: Tue,  3 Nov 2026 13:52:52 -0500
Message-ID: <20261103185307.45924-5-stephen.smalley.work@gmail.com>
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

The recursive walker opens child directories for reading before the
worker checks SELINUX_RESTORECON_XDEV. A denied read on a different
filesystem therefore causes an error, increments the skipped-error
count, or aborts traversal even though that filesystem is out of scope.

Check the device boundary before the child read-open. Keep the worker
filter for both directories and other entries, and preserve read errors
for directories on the traversal device.

Add 72 regression cases covering device boundaries, XDEV settings,
read denial, error modes and worker counts without mount privileges.

Fixes: c1efe48ab11b ("libselinux: fix selinux_restorecon() error handling")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c     |   2 +
 libselinux/tests/.gitignore             |   1 +
 libselinux/tests/Makefile               |   8 +-
 libselinux/tests/test_restorecon_xdev.c | 167 ++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/tests/test_restorecon_xdev.c

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 240852e5..73f66435 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1375,6 +1375,8 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 
 		int rdfd = -1;
 		if (S_ISDIR(ent_sb->st_mode) &&
+		    (!state->flags.set_xdev ||
+		     ent_sb->st_dev == state->dev_num) &&
 		    !check_excluded(state->pathbuf)) {
 			rdfd = openat(fd, ".",
 				      O_RDONLY | O_DIRECTORY | O_NOFOLLOW |
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 3aac1e7a..e308af53 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -2,3 +2,4 @@ test-restorecon-digest
 /test-restorecon-errors
 /test-restorecon-errno
 /test-restorecon-exclude
+/test-restorecon-xdev
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 6e3a5681..da82cfd3 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,7 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -pthread
+XDEV_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64 fstat fstat64
 EXCLUDE_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64
 WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
 ERROR_WRAPS = getfilecon_raw setfilecon_raw lgetfilecon_raw lsetfilecon_raw
@@ -18,14 +19,17 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
 	./test-restorecon-exclude
+	./test-restorecon-xdev
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+test-restorecon-xdev: test_restorecon_xdev.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(XDEV_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_restorecon_xdev.c b/libselinux/tests/test_restorecon_xdev.c
new file mode 100644
index 00000000..0e05f95a
--- /dev/null
+++ b/libselinux/tests/test_restorecon_xdev.c
@@ -0,0 +1,167 @@
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
+static bool foreign_device, deny_read;
+static unsigned int read_attempts, target_labels, other_labels;
+
+/* Simulate a mount boundary without requiring mount privileges. */
+#define WRAP_STAT(name, type)                                            \
+	int __real_##name(int fd, struct type *sb);                      \
+	int __wrap_##name(int fd, struct type *sb);                      \
+	int __wrap_##name(int fd, struct type *sb)                       \
+	{                                                                \
+		int rc = __real_##name(fd, sb);                          \
+		if (!rc && foreign_device && sb->st_ino == target_ino && \
+		    sb->st_dev == target_dev)                            \
+			sb->st_dev ^= 1;                                 \
+		return rc;                                               \
+	}
+WRAP_STAT(fstat, stat)
+WRAP_STAT(fstat64, stat64)
+
+/* The pinned inode remains real; only its read-open can be denied. */
+#define WRAP_OPENAT(name)                                             \
+	int __real_##name(int fd, const char *path, int flags, ...);  \
+	int __wrap_##name(int fd, const char *path, int flags, ...);  \
+	int __wrap_##name(int fd, const char *path, int flags, ...)   \
+	{                                                             \
+		assert(!(flags & O_CREAT));                           \
+		if (!(flags & O_PATH) && !strcmp(path, ".")) {        \
+			struct stat sb;                               \
+			assert(__real_fstat(fd, &sb) == 0);           \
+			if (sb.st_ino == target_ino &&                \
+			    sb.st_dev == target_dev) {                \
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
+	if (sb.st_ino == target_ino && sb.st_dev == target_dev)
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
+static void run_case(bool foreign, bool xdev, bool denied, unsigned int mode,
+		     size_t threads)
+{
+	char root[] = "/tmp/restorecon-xdev-XXXXXX";
+	char target[256], child[256], sibling[256], fc[256];
+	struct stat sb;
+	alarm(15);
+	assert(mkdtemp(root));
+	assert(snprintf(target, sizeof(target), "%s/target", root) > 0);
+	assert(snprintf(child, sizeof(child), "%s/target/child", root) > 0);
+	assert(snprintf(sibling, sizeof(sibling), "%s/sibling", root) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s.fc", root) > 0);
+	assert(mkdir(target, 0700) == 0);
+	int fd = open(sibling, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	fd = open(child, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	assert(stat(target, &sb) == 0);
+	target_ino = sb.st_ino;
+	target_dev = sb.st_dev;
+	foreign_device = foreign;
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
+	unsigned int flags = SELINUX_RESTORECON_RECURSE |
+			     SELINUX_RESTORECON_IGNORE_MOUNTS |
+			     SELINUX_RESTORECON_NOCHANGE |
+			     SELINUX_RESTORECON_SET_SPECFILE_CTX | mode;
+	if (xdev)
+		flags |= SELINUX_RESTORECON_XDEV;
+	int rc = selinux_restorecon_parallel(root, flags, threads);
+	bool skip = foreign && xdev;
+	bool failure = denied && !skip;
+	assert(rc ==
+	       (failure && mode != SELINUX_RESTORECON_COUNT_ERRORS ? -1 : 0));
+	assert(read_attempts == (skip ? 0 : 1));
+	if (skip) {
+		assert(target_labels == 0 && other_labels == 2);
+		assert(selinux_restorecon_get_skipped_errors() == 0);
+	} else if (!failure || mode != SELINUX_RESTORECON_ABORT_ON_ERROR) {
+		assert(target_labels == 1);
+		assert(other_labels == (denied ? 2 : 3));
+	}
+	assert(unlink(child) == 0 && unlink(sibling) == 0);
+	assert(rmdir(target) == 0 && rmdir(root) == 0 && unlink(fc) == 0);
+	selinux_restorecon_set_sehandle(NULL);
+}
+
+int main(void)
+{
+	const size_t threads[] = { 1, 2, 8 };
+	const unsigned int modes[] = { 0, SELINUX_RESTORECON_COUNT_ERRORS,
+				       SELINUX_RESTORECON_ABORT_ON_ERROR };
+	unsigned int cases = 0;
+	for (int foreign = 0; foreign < 2; foreign++)
+		for (int xdev = 0; xdev < 2; xdev++)
+			for (int deny = 0; deny < 2; deny++)
+				for (size_t m = 0; m < 3; m++)
+					for (size_t t = 0; t < 3; t++) {
+						pid_t pid = fork();
+						int status;
+						assert(pid >= 0);
+						if (!pid) {
+							run_case(foreign, xdev,
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
+	printf("Restorecon XDEV: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

