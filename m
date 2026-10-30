Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388011;
	b=eg41d9BYpByiOm+/a7RTWAsSV4xZzXuNfsF3WfZ254UgG2TLqHh+/fy6Js9KCqhTFBl3
	 XsKCEU7ujILBWMi3jdQGqlQpn58ScxLJ0kOFcgXX0QmBMEd6EXgKMxEeTACScKygjlX9Q
	 sKk6fdMwyQtrL1+Qj+1yIJccYPhq1IVsmuswpHhGOlGmQb68K3IdjpiwTkINQ5GkBQLJq
	 zrgqoG5nvfJECet3QnjWBiggUrdHnL9uGu0pOYRHs/eiVYEeSHKkTpCB9q5jajJz8+ArV
	 olx8jZHKLCRxtYJuJPIZA+wSzpbN3PNjmPkMURL4KlwzB+qqiz+jIKx6dGZyCDMK3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
	b=VFCv3TjiPyyLxz1ffbz7QrX2nSC+z/G9iyVMkwk/rxuNWJ9ZNHe7C6gDZ18ZQZD8QUvu
	 gHc/ctMyl7Q1AMzYsBSDNBCwkYFp2/g0W+rl9v2w57B0XfRGNiDT/DZzjs3WQE9UG36Ys
	 ZY2TIKxfK6TDaQamIWZFpsap+ucHMEllM12ia8BMgFgjS59+Jp04oY4Dc4K7Q50Vu5F1h
	 KTLsHDgLx6NKc67i8w8SLbDdgajHUJsYb/6ZCIvjZenhAklbCYjghkTW0Rjx7vRmKdU2V
	 TEdda1nO1wMNB10lKbADm9qAcTAbfN0ChTPvr9ipSBxmHm8TBX4Y2Ii4om/be7fgMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bd0TLe3k;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB8606A31C
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bd0TLe3k
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c7a706b1fso30674986d6.1
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388010; x=1793992810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=Bd0TLe3kAP/qbLLaR2pMADZ2kXi1pXGrimDuQmIZjgwCbjDLO+G8pF+3PmF87jxv8X
         s9+MibqNmg7oWaFf8yckfg0U5tWdFedETPcim4bD1ZD0WQec+pnpkwP6B93DiVarzDaI
         iIGB0/UZQJDyGaJnVE9yHvq5gDpPtDdNbORs+ypAiHmhmq7oun0Mh0d/gm2ilJwURy4s
         FvN02VP1OWsVsc3HjYriCVU32Fh0ZwOTsRYDphPIuMabmFzj5RCb48ZFqhn9n4IoAzGH
         F7ZPD47RE/d+jftYGfu0YFNkl4ePmG7MxZrGib8rNo2CeTabPRsL1cYoBW50LXHQQFxj
         1vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388010; x=1793992810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjsmGk7k5XmLpeIz4VZYZ6BfXqhwXBb3j3pIgVwtEc0=;
        b=KID8HLQ/zfB7FcrSsA4s7B7VxceHCE6BfRQ3HjWklaIs68Fkl0UArzKHzIesmFzyFi
         X6ob/R65UH/SHyteqPGdEZmoZIfzPUF4xx2UcUHIyNhsNk4cfOFfgliGEOYanTIF0Mda
         2HWoRxmBQtu97wt1JPnW2RTAt89nundhsSJ0m4/PaZ67LGJIfKvJJr4vCQAXAxFeNlg1
         s37Scgr1rBeBGtaqNpexVCpacXXdLsQpzRI67/FPR3OOMJt2mA13cUhbju0+T8fTG0Iy
         Fl0Y7LWb0lLBCRXtBHqb4hrgcr+pabkHIbpa09nVsxzJPfli7h0NkZnieRi/l0/7qbEH
         3E3A==
X-Gm-Message-State: AFq9FYLP4PTuZCTGWSM6oVkGQ567tpTF6U9zJw+8jHeUVl0YvctSTPdi
	cUyHI7rWC8yR6qygsc83rMnC07jSiA4IQiAkzj4wnOLVxqVN1d21YM/VV20biQ4n
X-Gm-Gg: AYBFou150+6wLCMY+m04tbFlk7YJdg3ccY8PvUE5VZVp/2qfwo3E18ScPWb4GNAlQzu
	GXvPxEnjYLsecz+Kue2TwYtLMxizIYkleAGBQEEFJgui8rCC6u9VDVxLALBxu4vw2myS0xiEDms
	A0uYv9oDFYMU+GfrpjE4yYowJTrX9fBNDigUsdvszeAoy8qD8xF/aisTTBibsQ/ZK88Po/c8U5c
	MiIPuvZFR2suxRYkMK3WWQHg0+C2JCgYRi1IH4vdJBHCMY4hi8OBbj7wlxnlIp/FXFR9sLaPA/N
	BI4HmpoPBOpjh+LzSOusrwWRBrThLfIlMxLG775PG5gnvyAxBJyWWtR5DYFbVwQR2eIcz84yqI0
	UIWJBpEE9O7KlmJgaf0g+BrmRcMK7JjZh8VCf+NSBfw7dOc8lHnyHnJl6hViy2DBaNuavOVsziA
	qsaP9xSA6v/qmZ/RtEZXkaYV5OeFllbkNY548Rscs8tBMGTHnmYWFtmHVzIbkq4zOVNDYccQS+X
	ZxuzSq4BJgDRqVOqoCARfb5a0nqK2ip0PFQt2/ju5xLmz/oPu0mSjErc+ygw17JYllINO7lVnJb
	xh6iXkNRM3izGdh+DYeH+9K/0Hjmd6rE3J1ZeMSPX0+I0Nig30Jqn3+E3+57DzDnbJiaIRHF4wz
	XH4/Yw2NpkQK+VVS/T7HP9apbfUK43roP28GNdplsrZ9ZAZkcjJ++0TFXhLya6t8+Wm8A3WCb05
	m1pa2blhwFQrcMsDbI6f0WlkEA1xgt+wOnDG/ex67TCRYI7rX2yyJZlsSxPQk0wiikVIz8Thfh
X-Received: by 2002:a05:6214:20ee:b0:91b:5d39:e133 with SMTP id 6a1803df08f44-91c90861e0amr107490406d6.30.1793388009795;
        Fri, 30 Oct 2026 12:20:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:09 -0700 (PDT)
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
Subject: [PATCH 05/10] libselinux: skip read-open across restorecon device boundaries
Date: Fri, 30 Oct 2026 15:19:19 -0400
Message-ID: <20261030191924.150495-5-stephen.smalley.work@gmail.com>
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

