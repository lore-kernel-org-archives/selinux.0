Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388012;
	b=bzTKyRqN9rNHBlzRUiuL3shpfgeETfICqkUEkykIWpUmELHXnLwhksMg3mEpvK1eb6pf
	 qVBkuR9EeH99wCZMdJwsr3QHJ59M3DKfOhk08qZndPwvK/rrT2pdq0Q1B3jxIq6og1Zw4
	 e23sPsslV5SoMV9bTmJGImPfE/WPR0X+ijS+ttnJgXoDuVxPhcHNC8ufwS9Ecsxaf6MMQ
	 bRPNjv+jCTxd+7M0tCJEuN59H7EEkCUIm78w7HFkzryGVWCTly4zRVc2rbNHtU8XiVdMm
	 SjF9La/vkLHMzfVkVoNHgKXSfpf7H1QujBaOQm2HGUos42qdbiM/5KyxVCwlGfcbBFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NzO5HKIAIbnK8C728CnWjFLq7SVQCMdi4HZtpHOTo0M=;
	b=3wlMsCWiGnErWCb2X1pF12YkiDq573eNE2a3g0Kfo+bQhBPGXGKSry6MLWgHsNW5E256
	 tYMjJ+k29kODaU7/DBm26kV+RWo09KawDZPu8Em3DvVLLeYuPT7IwCazfna6bDCrJWQb4
	 DnBcJdN/pBxM5KUhzyL5calQJQlvHUZP9wCWeyKxHTDvg6k0RLdcrFjXIRxbfhyU6Ilcn
	 K1HM0n76m5BSe1q2N220yHSDAbaa+mRbIQ1N+kYMhAGXD8OAAPBnuL0c0vBBWEbh5JypP
	 6140QCz/83W4NpPxvJpNcZVjjmQYO6zHw5F+mxTW1fe3PS7qhcjpW/Djv7ZjuVvG/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcse5KdD;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3564606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3564606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcse5KdD
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c7b00a75fso12264066d6.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388011; x=1793992811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NzO5HKIAIbnK8C728CnWjFLq7SVQCMdi4HZtpHOTo0M=;
        b=xcse5KdDmZCvAiEVIqDe8+91s13s6hahZln2AfCfhfZ2zsZrqZn4bUyefxtRwWtW4U
         icwc76ZGNr2K9EVCw20IRkyYDOoyiV/NVASnaSrGdTyJ8r8uWLmr8OCY3tVzpB8dRMvJ
         6jDDh+xGkNIsHRPPEuERaq2h1souAe9khCmCmm/q6QClZwlswVNUUK+wZfqmhPcTG8qs
         yDgG2+qZt3fjXxifo3SepUUh8K2LHm4vtFGYoCBq16iRXEHC1JEBsGwX6elUY/O4Smvi
         UCdhf3U3+3N0rS0GuKKpHCNy9JgCvsxdfs1luHaFiD5CwUqRLLD3uG5kaLyDpfqC46MD
         7hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388011; x=1793992811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NzO5HKIAIbnK8C728CnWjFLq7SVQCMdi4HZtpHOTo0M=;
        b=ITsJJrMhxeAfYvGD2+vcVnsoSy2fvDAQTtT93z1XHtvP8BQOx4lMLYacO/Zb6MHEK7
         k0DkQmB3UAj0VmVT0wodqubcbRdHfAE/HjRqaLJM9rE1dDKysY4s9ISLpz1MYzyWxCuw
         bb44Wx+x9F4QBmraKE5mvAi90XD4huiONbkViNhEFxjiu3h+Y5KBYsV4IDDhdv52dLxv
         EzDDnUnMIv1AVbKAa2JX+6PR9LOZVOqOYkPhX5Wp+Ke18msJyQX8IjZuTRbf13SqPYk0
         xjVR9K45rHr82y2lqYVaUqgwM5jEzzd9zrYgxIHBur4y9nCYvnRcL4wBiEQSTWmXfKCa
         UOtQ==
X-Gm-Message-State: AFq9FYI5okGLJ99+t+iwh2TpnmaOVkvcYKVKzhEEAbyNqkkIFWCzrJ9o
	H3BM04TCSok25sgexS12J3qNg/jdqIy1UavBv7nlq75aup+OgtGC5pL8Fcve9epB
X-Gm-Gg: AYBFou1Q9PLPIuwkaWJolZ7wMiE8rcHbf1ZVcYWGz1NUP4HgkWE5TPrQuJzWs4eUeUP
	cbTYoKBy35PGrmO406GZ2XUopc9LHLPmfE/JVD9t/Sb8j7Nn2HnoYtoLE1J2t1eBGAnm0KgviWi
	b8p+YEge1WMrAjmxqk9xrdMVu3UjeoWWLZrz8QixlxUfqkKTuwWJ1Do7Y24/ZJ8BqTme6+6OqjS
	zt0jY9HNC005X4iRbDtwNa8aAD7PMs0byxA4aGBPWY7aoZGZoxM3BaAXtTuD9X1to3tnfPYz6nE
	x/dEnq1NvBGglapnSLOylsNzFdovCljHavaB/0Dm5fhjggGKE7SO9SCUjv9alhU1FO9zDYSgWHG
	z3hSRKxgVvC4zSPmNYhy07zTHmSi+iwLpA+5wXl+P5w8wDAtt8O8Pk53Ul7A52OfRoPBB4z0+lP
	Gkh95gib4Ky8e5YTTXqC+Iy9VGUsz7WywTD0WlR4vqbUQlax7eciG3JpPYzJxdcIRrHPbNsTudM
	NYjjJlrT3XL24V9o2nfGiHxeXZ3ObABerz1BzphlPJHLes+6wBtEvOfIxAYLyZmcDjLx0qXSdLs
	17PX//r2vSXf256L/CK+fOTx3YN6IFkFsLJA8hOT+RZJyuCyb2YdpRpNStFJoHoA69AAO8rbGS0
	SbjHwjMcifRXuS6jYcDgSO2qMBbPApX9BFxIJ+3MlXDpXYc0rXiZw4CJ904eiin4OUBfU90NpS2
	B9ZOgDO0gKWn4fix/IlEJg18tzOpqYMEF9SOYkMsD2ImkqJtDXFz4=
X-Received: by 2002:a05:6214:1c4d:b0:91c:8632:6917 with SMTP id 6a1803df08f44-91ca4b39221mr52932716d6.34.1793388010577;
        Fri, 30 Oct 2026 12:20:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:10 -0700 (PDT)
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
Subject: [PATCH 06/10] libselinux: fail file label initialization on auxiliary path OOM
Date: Fri, 30 Oct 2026 15:19:20 -0400
Message-ID: <20261030191924.150495-6-stephen.smalley.work@gmail.com>
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

Successful substitution setup leaves status set to zero. If allocating
an auxiliary file-context path then fails, init returns that success
without loading any specifications. selabel_open returns an empty handle,
and restorecon treats subsequent ENOENT lookups as successful no-ops.

Set failure status for both the explicit-path asprintf and default-path
strdup failures, using the existing cleanup. Keep the NULL assignment
for the unspecified asprintf output on failure.

Add 48 cases covering both path modes, auxiliary files present or absent,
BASEONLY, DIGEST and failures at either suffix. Check NULL/ENOMEM,
tracked allocation cleanup, and a successful subsequent open.

Fixes: 1550c8aaf255 ("libselinux: support multiple context files for the file backend")
Fixes: 27280a14f26e ("libselinux: search file_contexts files across configuration roots")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c            |   5 +-
 libselinux/tests/.gitignore            |   1 +
 libselinux/tests/Makefile              |   8 +-
 libselinux/tests/test_label_init_oom.c | 211 +++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 3 deletions(-)
 create mode 100644 libselinux/tests/test_label_init_oom.c

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 8ad1b97c..de4600dd 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1726,14 +1726,17 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 					       sizeof(resolved));
 			rec->spec_files[num_required_paths + i] =
 				strdup(resolved);
-			if (rec->spec_files[num_required_paths + i] == NULL)
+			if (rec->spec_files[num_required_paths + i] == NULL) {
+				status = -1;
 				goto finish;
+			}
 			continue;
 		}
 #endif
 		if (asprintf(&rec->spec_files[num_required_paths + i], "%s.%s",
 			     rec->spec_files[0], opt_suffixes[i]) < 0) {
 			rec->spec_files[num_required_paths + i] = NULL;
+			status = -1;
 			goto finish;
 		}
 	}
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index e308af53..a4695e6f 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -3,3 +3,4 @@ test-restorecon-digest
 /test-restorecon-errno
 /test-restorecon-exclude
 /test-restorecon-xdev
+/test-label-init-oom
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index da82cfd3..babadfe8 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,7 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -pthread
+INIT_OOM_WRAPS = asprintf __asprintf_chk strdup calloc free
 XDEV_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64 fstat fstat64
 EXCLUDE_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64
 WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
@@ -19,17 +20,20 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
 	./test-restorecon-exclude
 	./test-restorecon-xdev
+	./test-label-init-oom
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 test-restorecon-xdev: test_restorecon_xdev.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(XDEV_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+test-label-init-oom: test_label_init_oom.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(INIT_OOM_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_label_init_oom.c b/libselinux/tests/test_label_init_oom.c
new file mode 100644
index 00000000..e826b7d4
--- /dev/null
+++ b/libselinux/tests/test_label_init_oom.c
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+
+static const char *fail_suffix;
+static bool default_path, tracking;
+static unsigned int faults;
+static void *allocations[256];
+static size_t live;
+
+static void track(void *ptr)
+{
+	if (tracking && ptr) {
+		assert(live < sizeof(allocations) / sizeof(allocations[0]));
+		allocations[live++] = ptr;
+	}
+}
+
+void *__real_calloc(size_t n, size_t size);
+void *__wrap_calloc(size_t n, size_t size);
+void *__wrap_calloc(size_t n, size_t size)
+{
+	void *ptr = __real_calloc(n, size);
+	track(ptr);
+	return ptr;
+}
+
+void __real_free(void *ptr);
+void __wrap_free(void *ptr);
+void __wrap_free(void *ptr)
+{
+	for (size_t i = 0; i < live; i++) {
+		if (allocations[i] == ptr) {
+			allocations[i] = allocations[--live];
+			break;
+		}
+	}
+	__real_free(ptr);
+}
+
+char *__real_strdup(const char *text);
+char *__wrap_strdup(const char *text);
+char *__wrap_strdup(const char *text)
+{
+	if (default_path && fail_suffix) {
+		size_t len = strlen(text), suffix_len = strlen(fail_suffix);
+		if (len > suffix_len && text[len - suffix_len - 1] == '.' &&
+		    !strcmp(text + len - suffix_len, fail_suffix)) {
+			faults++;
+			errno = ENOMEM;
+			return NULL;
+		}
+	}
+	char *ptr = __real_strdup(text);
+	track(ptr);
+	return ptr;
+}
+
+static int allocate_path(char **out, const char *format, va_list args)
+{
+	if (fail_suffix && !strcmp(format, "%s.%s")) {
+		va_list copy;
+		va_copy(copy, args);
+		(void)va_arg(copy, const char *);
+		bool fail = !strcmp(va_arg(copy, const char *), fail_suffix);
+		va_end(copy);
+		if (fail) {
+			faults++;
+			/* POSIX leaves the output unspecified on failure. */
+			*out = (char *)&faults;
+			errno = ENOMEM;
+			return -1;
+		}
+	}
+	int rc = vasprintf(out, format, args);
+	if (rc >= 0)
+		track(*out);
+	return rc;
+}
+
+int __wrap_asprintf(char **out, const char *format, ...);
+int __wrap_asprintf(char **out, const char *format, ...)
+{
+	va_list args;
+	va_start(args, format);
+	int rc = allocate_path(out, format, args);
+	va_end(args);
+	return rc;
+}
+
+int __wrap___asprintf_chk(char **out, int flag, const char *format, ...);
+int __wrap___asprintf_chk(char **out, int flag, const char *format, ...)
+{
+	(void)flag;
+	va_list args;
+	va_start(args, format);
+	int rc = allocate_path(out, format, args);
+	va_end(args);
+	return rc;
+}
+
+static void write_context(const char *path, const char *context)
+{
+	FILE *fp = fopen(path, "w");
+	assert(fp);
+	assert(fprintf(fp, "/probe %s\n", context) > 0);
+	assert(fclose(fp) == 0);
+}
+
+static void check_handle(struct selabel_handle *handle, const char *expected)
+{
+	char *context = NULL;
+	assert(handle);
+	assert(selabel_lookup_raw(handle, &context, "/probe", S_IFREG) == 0);
+	assert(!strcmp(context, expected));
+	free(context);
+	selabel_close(handle);
+	assert(live == 0);
+}
+
+static void run_case(bool use_default, bool base, bool digest, bool present,
+		     const char *suffix)
+{
+	char root[] = "/tmp/label-init-oom-XXXXXX";
+	char contexts[256], files[256], fc[256], homedirs[256], local[256];
+	assert(mkdtemp(root));
+	assert(snprintf(contexts, sizeof(contexts), "%s/contexts", root) > 0);
+	assert(snprintf(files, sizeof(files), "%s/contexts/files", root) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s/contexts/files/file_contexts",
+			root) > 0);
+	assert(snprintf(homedirs, sizeof(homedirs), "%s.homedirs", fc) > 0);
+	assert(snprintf(local, sizeof(local), "%s.local", fc) > 0);
+	assert(mkdir(contexts, 0700) == 0 && mkdir(files, 0700) == 0);
+	assert(selinux_set_policy_root(root) == 0);
+	write_context(fc, "system_u:object_r:base_t:s0");
+	if (present) {
+		write_context(homedirs, "system_u:object_r:home_t:s0");
+		write_context(local, "system_u:object_r:local_t:s0");
+	}
+	const char *expected = present && !base ?
+				       "system_u:object_r:local_t:s0" :
+				       "system_u:object_r:base_t:s0";
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, use_default ? NULL : fc },
+		{ SELABEL_OPT_BASEONLY, base ? "1" : NULL },
+		{ SELABEL_OPT_DIGEST, digest ? "1" : NULL },
+	};
+	default_path = use_default;
+	tracking = true;
+	fail_suffix = suffix;
+	errno = 0;
+	struct selabel_handle *handle = selabel_open(SELABEL_CTX_FILE, opts, 3);
+	int error = errno;
+	fail_suffix = NULL;
+	if (suffix && !base) {
+		assert(faults == 1 && handle == NULL && error == ENOMEM);
+		assert(live == 0);
+	} else {
+		assert(faults == 0);
+		check_handle(handle, expected);
+	}
+	/* A failed open must not poison a subsequent successful open. */
+	check_handle(selabel_open(SELABEL_CTX_FILE, opts, 3), expected);
+	tracking = false;
+	if (present)
+		assert(unlink(local) == 0 && unlink(homedirs) == 0);
+	assert(unlink(fc) == 0 && rmdir(files) == 0);
+	assert(rmdir(contexts) == 0 && rmdir(root) == 0);
+}
+
+int main(void)
+{
+	const char *suffixes[] = { NULL, "homedirs", "local" };
+	unsigned int cases = 0;
+	for (int def = 0; def < 2; def++)
+		for (int base = 0; base < 2; base++)
+			for (int digest = 0; digest < 2; digest++)
+				for (int present = 0; present < 2; present++)
+					for (size_t s = 0; s < 3; s++) {
+						pid_t pid = fork();
+						int status;
+						assert(pid >= 0);
+						if (!pid) {
+							alarm(15);
+							run_case(def, base,
+								 digest,
+								 present,
+								 suffixes[s]);
+							exit(0);
+						}
+						assert(waitpid(pid, &status,
+							       0) == pid);
+						assert(WIFEXITED(status) &&
+						       WEXITSTATUS(status) ==
+							       0);
+						cases++;
+					}
+	printf("Label init OOM: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

