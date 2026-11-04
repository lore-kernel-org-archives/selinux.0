Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804979;
	b=Q4MqpKjgoSUJkTOmvNIww8gESPh65ppFIj7u6hkfJDg7LhzisITItOVVIpdQXQ5wD4+v
	 xhfAxiUdcBGFbrNjbHUrOaoxZhJL/BzbvbM02fRxVoXNSaTzs59RGGav4f+oejwHPtsTU
	 6Mla0eHODwBigKm615Bt63/e9TWWJbIImlhlFHWQrHCAdmc+gz/oPiMNVMRhKEdu9W0Yn
	 cXB6XGDPxLjgXfN1eXkOkCKf0riQD/O2Eertqy1ErLhUWFeG5vOYHzdmIYxu2mHOGavqo
	 v7+Qgp86CwVK2i/bXaafwGssehe458YLUgkJpIDFNUHUNe9pB4gmkbia/1yzTiWLk8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
	b=cDOeF+QaucMOEVH46tyjRnpQ1ukLxQ2AlOFQqCSK8dPfGSrsFVO3LEV3+9DEVaSx/3cC
	 Ny6/h0f5ak7cY96c0iyGDs+oeW7zKGpmJOMNb6pdwDCSdAx4eeqummLo0nqjFDcXXB6dB
	 QKxxsCZLAXq1+F57gJTdgq9ITC5H0E3aPUunCDtSgttUF5dlnXmBu7CAg7cdqA6Qlk7wY
	 ChEfmOQxDWx/Rm7bLzOcdJCX75qKyiYD6g/0uTu6IIa4Io5Wg7f64wNlCmaUr1vZgdtFE
	 E2tWDoCl48/3zLMANHHK7tHsLdVQp7W06h7OUCRftMp2BsfuJShKQ4C1bfmU1kDphXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J6lFPDgJ;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F9606A339
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 156F9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J6lFPDgJ
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53c4b82919fso10023761cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804978; x=1794409778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=J6lFPDgJGGgX/bFn37xytYdVMzceNacLCGZG2zlexRCiSVAtc0cur0xxSI1FQgoP3K
         pbUDjIi2TYI3IC/j0B6+ZZtM/Ycu0N4g9JdS9PFxRMZwQI2J/UHZm1689bPkJjm9m+6W
         mbcfKbWeq4Qp8FbPlz7RkgUKyPkJEAz7ZrJjin19mkFnx5qcKjSAKJvmDf+2E4oC32T2
         WJavynnCcjQMaCUMSMEc3DiCo83hC5kIsCDAZeD14h9DsBz7tMtNWx7vI5aslQM5PTB3
         CLqr10iZ+s+q+00WQG/VubVmc5cEbFj35lJE5I9MYUlyH1ulmf4ktEx5Naq+82MRqqck
         iB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804978; x=1794409778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nbgjdCOJsNzUVU9LHMMe7nBzjYcsqJYK4+v11dPsDc=;
        b=WJhR3MY65XKTHXOCFGwZI0qyYvQqj2aCEvrroO9og0momvotveDNoxTUhfqLkOm/KG
         e+uJgdf+1zwnElIvIO+ga30H9YEBv6AgfV/EpD7rjW0A2J/l+PzKoY3+GEjPiHrXUqHy
         ReDiDH4LpoWvXj8zK3/MuwIGFUp/nQ6O8qQQRb8L4C+BaqdPWH/ppINQTp+AYw6urOKr
         K9v3qtPO29SDnw89fUYrW3Lm7fZuvvNMiH7QCdJpOo0TTEEW2BVXIcE6P/3avin4Ql2h
         zge9bxjxoohARF7KKOKlAmzFkYg0ka270bqgp+o30R66p4c/ma72QCw6rMNfiymWiwBi
         h8ug==
X-Gm-Message-State: APuU4Z9rwJ3vN+7+tRsrqxZ8jj84PlM+hOjQeX3LeNEuwdmG4r4Y9O7e
	M7nasv9Q0GphRMERiBmyg9kIpNJmSEDk6zTUZAB9YSrReHk24SA+2+qyaNLb7Tzz
X-Gm-Gg: AYBFou3YFBgocg8+Vbf/9Ol1cuF6mwvac9V+pNGatsWn4tdAsYnYfQB0xeQU5RGjBU2
	8SfyLIgyIeS6HxWjFjvQkoLGGMtGdl+CGeqgj9ojwAWEU9C7sOJGMldw6xC5gzAix7z/Q7eAojd
	//FulWQi2YvEOSagtg9XZdJzNYluVnf/moHjHKQ0T1bdE9Eda8hkrreiUSyX8b4/KgkbJtPg4Im
	d+02lGvsvp13f9TWGgOdxPin7fouL7KDOcFeAIyU1mqRDxKh3Tb5teQDfNiXmVShSPkeYhl6P93
	7JVppDRWmKoqi4sxp8HZTz7ywvx/jB5msLGxm7GrJhajuCHIPN861FWKUjxjPDIjORR7dsnAIET
	C98/y234jPvOMGHJeTxE/VLrD8Kn7loRanZZtRmX2gCsXUJzwy9RhNrCXivQW+YTYNqhzWP4OMP
	8NYcODl1zDX3YuXpsd7HHjA3sOBh7uLHkpdBY7lZSa6ZwR98diE1L7pkDNh841ge7zCClxpVhu5
	S1AhE/DvnFnjjwvWFHGGOG7c3g9X4anwCKmc0l0WXqmNySaS9dSTg3kaIpJBqySxOYrpjN4q4AG
	uJOL7thoGy5o0uPjIB/XN+Ne+WoB0XkGaAB5qidODtD3ozk8WJOsu7Xte7ssFXgmgaZt5Vg4N/m
	Q16NU5rSCgT0SDK2jNKmyv1q0FFpMAAz6QZQ0lkcAYyF7nFQQuaOsPwmX7v9lx2E9CCPErFIKyL
	osr43w/CnE/ooVydVIvEfhBs7v8bkTssvBYh5vMkjALabocRcKgjTr3/A/eboCO9Gdu8q+fOns
X-Received: by 2002:a05:622b:99:20b0:54b:235d:57be with SMTP id d75a77b69052e-54b235d7b60mr32999691cf.11.1793804977983;
        Wed, 04 Nov 2026 07:09:37 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:37 -0800 (PST)
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
Subject: [PATCH v3 04/20] libselinux: skip read-open for excluded directories in restorecon
Date: Wed,  4 Nov 2026 10:08:59 -0500
Message-ID: <20261104150915.175923-4-stephen.smalley.work@gmail.com>
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

