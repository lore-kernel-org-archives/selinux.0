Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804980;
	b=h/CZ5+twU1xse5uODdNcVseQE7rYvNXYuY72MKN3VWWQCe6nk0/IX0fYsAulEhwhnFRO
	 wUvFht75ZjgQZUZiKcDRy3/LiW1kwY0S0Nd6ZReYFgzGDcLW5BX8tFTLIsmBo5pLfOT32
	 pjaH29GTbKZFCoMhfGju4DnwUOIM20dBrRxXPZ0YiKyIPypaqh55CKxQ2w0GzkUmXW0cF
	 PZmd8RTiCIFKi06xphfIb4AeGj9SPldqnWZ0SvUG++RHyzCiDN8CgL9X5wkazKtlC0LGK
	 00Th0P7PlTuZcil3FE+FpZDxIUJODT79X8vZCmNMwM4WdagOuvzQruzkZAoRkaVGlUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
	b=UeHTz8BSwfjCX6YTlg3d1oHre0dYLJ2fgjou8kTDEes7DCM2unysKnbpeRj8VzWNE3Z7
	 OWE6J/obtCZTY+5ylxU9I4yW4JctpqNeSejLAiPp7MSleiZ9z0AeaVhniTToD9HbYooU0
	 5xzekRYttafMX3vYfQyyAZwRmBgVywzW+Gg9wAwwwdD03qp5/XhbG0/roa8kWOzPzjSRu
	 C2RLNQ9kW0HNoaapuKNay+DClnMxPv6FfdCrC32Czfwc5Jn5liWVnTP5RIlzI3cQJG0Qs
	 CV5NK2VyMgEEKq9R//FZIZjg3Mg8Ff6bX4zQByJAljC1GBhSFK7rt+euORLjDoAssJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEzfiGmi;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE962606A331
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE962606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEzfiGmi
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53e1d40628eso22675151cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804979; x=1794409779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=uEzfiGmi2J23VTApHjabSUjJlWPJz/ojAqfGJ8/FLtjvfTPeWbVBS0wCl8o348srGr
         vYb2LfuXbGhEPTcIqjobqXnaBxKQBFHScJGotymgYk5jpTWKBrWC59FI7dyPKZsXW5vT
         m8XfGEEfiIM4zOKFU07FzbcN2G/1M4zlWBX3eoHrXoAaYNMOb2h4TRWljGA0KFF9zH5Q
         WU7XS4+P+8rlM5IrZCq1y/LIpZcsoLuasstwErfZ2BW8X9qLX5oBrN6dnlunSz37shSs
         9U6Qlgpitid53mldKegCpz80XSRRmSqobr5tNlPB8cNsfHiJMm3eMT1xSrZqQCa9Dv4U
         20PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804979; x=1794409779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=r7rUeL+cVx/apJsfwe+keJPKPownM9DPfd4LAYagH+ZVPfKGzAxKLy7g7D8j/S3ZS9
         RnImZIoc3UB54hxvm0Zb2Mvddnq28NDx8NaEYtW5DBIeeDp75+nMhBaCTA0zriIfFrWw
         x2WVVPu93YxkOcBJSR6YN1dJG4NYMI1ksP1yWweb+uQSrVTcI4JXjqB61Q6bG0XBhmAs
         /whPN6uCIAITg2Ip09YHVQQynTEKYkYNQx+ZqoLuY3QCEDKa11BPIOaVx5cl7UKlCQ16
         hPUtu2JA4nYYzE+HByLf3s/gS7o1Z2EsC2dYgsmI1lC+Ix3QRGpZKRngMSvdATM8raVQ
         76IA==
X-Gm-Message-State: APuU4Z/mMrl/kg7lyu4Efp4jEOxr6qpiHnUKlyngK3GLLfQDC4kCrLtC
	JubPdA2HHPY2II3CIeb6UUFmYH1Z9oUDmsGwjvXOJhVZhnvWnJ5iYgaFkIs8ApxU
X-Gm-Gg: AYBFou0hWf2cnS5mRxnraLQ9qEaCBHFxqNpxUwhfOXfiM8gyZs4E5hSIY5BuNh8IOZX
	IiCgMcaEfFpmk8tVyLTHt3RB7ew3zQK63CBrrUqRhgeFno/WsUHzyuFD7yLxfcs6fomcuRRKwtb
	QfuQvLZnv9pr+B6+ZIyg1vcmobSisH/xa9/7gmIJzGwUda1vPCvQp+A5s6p951hj/e0B3WMZJy1
	9fGwr0bBN1Xp1n/CnYK98mrMeae7X5MK28h1KR+fQC+KBHioBidPSJrofJU+i6RQoLP1F3V19J1
	eGBIKVe9RRjAdcVF0eWnL7H7SwW+ldpAjI7dWVY0msrdcnkMOMd07wKMEBqFk0lqvYZr9stqxRr
	fdbddCm7AAtRtpQD0ToXaKFNBu/CA/uy8NHm0MagEKGro+p7WT/IxSs7bYeDUPDXkGwlMhEH8IE
	tQGzp8Bf+QULVM+wbwy3U/1mtuSPFVBzRgGijNXqIr4nzkCkGOmeE5niVcJxuzoFFeWOCTpGQGP
	4/pHhWQoE3rwgX8HYuVhMhs7uIhmDSU8a9UUjnOZ4fPDIKpHC9rAtM4e7kRg+u3kfbZJ1wGNJqE
	w7Ovk6fDOU02cWcQr26lvqUuvYcSa9LmP/fth48kpcXUUpEJNky9StWZvqzagJCx7alCZYrBMv6
	520XlifHkVWgep+9LCtcTYJHuU8FPa5+bGmd4w225bRN6lC49zG0QL74z8G2Fc2W7ce+9jPWPNS
	5s8X6PqZrL0zUcbxtT2wbdEHBLSuD4+gnrtKnv42a4v10ORiQ0zw8=
X-Received: by 2002:a05:622a:410b:b0:535:8559:3401 with SMTP id d75a77b69052e-542b7dfc94bmr261568861cf.28.1793804978631;
        Wed, 04 Nov 2026 07:09:38 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:38 -0800 (PST)
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
Subject: [PATCH v3 05/20] libselinux: skip read-open across restorecon device boundaries
Date: Wed,  4 Nov 2026 10:09:00 -0500
Message-ID: <20261104150915.175923-5-stephen.smalley.work@gmail.com>
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

