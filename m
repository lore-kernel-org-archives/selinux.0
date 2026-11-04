Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804980;
	b=n+wL3QXsQR4koBz4/T9gjm49jx2j7wgOE6P0N5vuViHXpixcrXqxnDPjowcLYQJR06lM
	 cFmjthkxP/osJldEGdHsZ9LAyua0DlcXDfhS/rZifh0DL1cwywAyVlYe5udKJG+GngmcA
	 MFQ9+7GK9RcVm7Zmpg4FIaf2fumyJBKKFErXH7sUZdM8NXe+GbXE0zaOm8q9bMO5FPBfp
	 cKg8SVoD4kigyEcOxdWcpt6zQnj2aKHZZoWqIESGG81K4m+q7f1dpuWkpHsI5lDtkRXLC
	 PTNq9OpQKfzqkvoMC6hP7LnH5ARd8UUHzLev5EvfaQQFpDnGTUR47tS+NE0CRPuxH8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2J79l8+E7IgJXmyDyW7vwjXOl/cSz2+xU2YywBnG16o=;
	b=aYP4QQzXAIAUzYuhjpkarvLiAipHFmJ5O6f5B7raMFrQ/7a1DgW1ZGwkkL1B2q9r+gLM
	 DIqupHKKQs0P8kjaTD7TWOXYuqhrshGny/So1VMuuEnQNMbcv+U1EiIdUPiIshZ5m0wsz
	 NQoRNbFoEL1Xl7sPEyno2+fU1r94uWp+kxnHUaYIL3kCfWs6ugL6c/9lhIoF4lLIGtDG/
	 QXoM85gUZYSKNr8HEkDHCH0thZzNiGVWKklY8tL1KYYikv3vrX1HbekATyFqQ+eSL4zyh
	 eBQnJmFbvbHL51bcG2K6wCWs14pRoIsMupnwI4l2AUk+IwOZxPTiCt5ScQ2g7fwTHaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NlkS0/L/";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30C606A32D
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A30C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NlkS0/L/
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53fdd2fb171so8185791cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804979; x=1794409779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J79l8+E7IgJXmyDyW7vwjXOl/cSz2+xU2YywBnG16o=;
        b=NlkS0/L/sBw4SXffGvPv4QMH1KaoddnP21m1nUvPnTsVVXHvQoqowGNzgX/mV2W+jb
         Q7O8RQWS9io9l9Z0PPbdhr46ARxp6APmmgLQERss45Hwn+PjpANwsk5Y/S2mxsDJJ/AV
         4OLm2xE6DL0xCgFTxWg20mX4U9frXNiOQO7YdL4gbZc4UDvuKtkAx91nS3yBqbNOSWnW
         LgEfpJVHnIN1LG+zz+rqmCBF//BBTnUyOx9s/GFMw829flFE2+TYW2/Q0ClFSh8E2oQ4
         LKTgahr10cKkkliP54ib5cXmKKTvEAMB1ciuCdImAe8zU+2To+EOaBiOpHRp9l14czHt
         GWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804979; x=1794409779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2J79l8+E7IgJXmyDyW7vwjXOl/cSz2+xU2YywBnG16o=;
        b=jSf9EiwkHiGI9+RkDi4GetRO84TwpBW8mbowv4/AHPxiC2HfGt+N4xMXMDmitXM8nj
         Nhx04NyLEjDkntzjENgiZSY6lakRZtCP0qlaialIPEy6IOxtl09eV8vJgCOnPLaKohOD
         ygb7rPFHldNT5fbgPBIfz/TpYXUvcmSRaWEjQgisEVOcoLWw60gJZYgSjrJbog5+eHty
         MDbj4Qlx2EHe0PtgA8mdUkrpPMz5SeQelWdQubTWCVNmnl9mlonVdUWIffUG/A0i/aZx
         uo0j1gnRRmUvIf9GFo83wb25FoOdWp4EHNXT0L9gfiETsMuc7dGI+rTGbUEYjXBO9Gam
         9cZQ==
X-Gm-Message-State: APuU4Z/7bKWy2fBpGRfpUPkxYMdcKh5929d9EHS1jb0KYD6j3f5QcUro
	btd+4ELi5f1dQ9sHT+DLu30ZlJhinNA4gyR+l4FyRL/pUgc5XROd68qhZB5mMIKU
X-Gm-Gg: AYBFou2OrIEVY572x69SJFOFLqUtGhiRa/nW1esCQonmDqhwH37zXGY+kuJ73QZjzl/
	bbYyrlsk4JXW8oYjd9RdoHKiOIXjdL5v8o9n9FRYqlts7hKuvhrVLxKE4duM7+kKZcq2VkR5UGu
	Yk2UfObg8pigRGU4Yt1X65qpE4pe0zUkU1VVK6xJG7IMtoBspMrbmyKpYF7sEym/fifK5yb9DY4
	fSJ0WkBEYf3SQvKDwnu7GsROuv6ERQEx8vm7j7KmyQvxMyK5IK+yI7Bv7/BTZ3KACVUhmeno0I1
	FhxkHq9oV2pHsJ5SzRc2840H7wnwP+dF5ulNVVk6a11q38GLIJYXj9SlfOgnDZU8FZiXCVkjPcG
	C1eGmwQSvnjNGMaB8s06DilIE7s+kQa0kjsZk4t9zG2/qsqYmYJWNSbM6Rpj9i+Q3n+gmZs+0lz
	4E/dSyDAeeu1KZ8DgwGWXSx0qL+E4tA79Xe8iVgcgggMpChDI7zmBx4wvGYKQf/HKvZzRP0pTn0
	Vwgofc47wq1A7Nvx73SjLI4FY45/ERTbIUdtlXGDMeyZ5MPltsM4a2mqUEQLssKNU4METKU+TT+
	RB2yu5mI0AMAt4aOemPchPF65Q29+RBG7aC4VByxnxD8j+5RqFAcd1txuZhAKfXODtcP9cKK9Pv
	6bASqodGkFbZw/wYQ4QWRu6+bAMSR0Wk7MZsFGE/uEJe1xCYaJM4H/bZQwXONBk09MIA0ZXi8OT
	BZ1VC7hk/HplrquH2DFQTaO6BhyCtEN2aVNh6qhqsYwWo72/fXTx3BHMCj6p4DsW6EAKbCCuQi
X-Received: by 2002:a05:622a:5a18:b0:535:232f:ca25 with SMTP id d75a77b69052e-542b3d6f303mr257656901cf.7.1793804979241;
        Wed, 04 Nov 2026 07:09:39 -0800 (PST)
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
Subject: [PATCH v3 06/20] libselinux: fail file label initialization on auxiliary path OOM
Date: Wed,  4 Nov 2026 10:09:01 -0500
Message-ID: <20261104150915.175923-6-stephen.smalley.work@gmail.com>
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
 libselinux/tests/test_label_init_oom.c | 214 +++++++++++++++++++++++++
 4 files changed, 225 insertions(+), 3 deletions(-)
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
index 00000000..3cac58c9
--- /dev/null
+++ b/libselinux/tests/test_label_init_oom.c
@@ -0,0 +1,214 @@
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
+static int __attribute__((format(printf, 2, 0)))
+allocate_path(char **out, const char *format, va_list args)
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
+int __wrap_asprintf(char **out, const char *format, ...)
+	__attribute__((format(printf, 2, 3)));
+int __wrap_asprintf(char **out, const char *format, ...)
+{
+	va_list args;
+	va_start(args, format);
+	int rc = allocate_path(out, format, args);
+	va_end(args);
+	return rc;
+}
+
+int __wrap___asprintf_chk(char **out, int flag, const char *format, ...)
+	__attribute__((format(printf, 3, 4)));
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

