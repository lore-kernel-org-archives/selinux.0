Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804991;
	b=t4BSikkS9M/J5RKKZsLSS9+8XPCndW4bD9BU0pXy2cG8U74Rg5XTXOyYgl1mxt3xk3Zh
	 zR8WANn5d7xX1BfQnsyHMG6FjFuTPTby1v5bvd6QUsQyAE3a5znhpkO+gpWBdLO7YdbCa
	 UUM3ddjqHMYv2C5LvKsz2LV8vkkGp70oNS+behSYmP3d0H7ylY5IIinhgeLKRHyAEPwIe
	 LhRiZ5gRTzFVrM0SVYSPgfdOfjhsXNTgPMz4sQW45DFi+BgKORpPvukM8lJQY57xlHiJn
	 s7IQM3/hAJQ4+OqlcmzTaSk0qgmYAlyaFM+5IpO/ihjArwhOOIt+biCu0vuxrWoHOUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
	b=mE9EfWKU7M/4qHgP7/RE3WSIUGX3yroD50NTCRZ8Dy0vQT50IGT6+U8PB1oxMfFse0jf
	 YjgXNNKkS45ZJZN1hroNeZl37tUU8jj9CjXplGJ72L/7qm3JLpD13sXYyZrJaHJ7Me31R
	 5vvyjz0zcN/wjdd0Dy0jm5dpeV+PTGSvChvVPheoXPHH0ptuiT4kiAP2aLnp8prP5PNqt
	 Po1Mz78wGyP0k1yMwzXVasDUmCyCaSSyLob4CU8HOqbwTmHZxRrv9CjaUZN64RfIzrRSb
	 9c1A7CB7cNbZEnZSEsgOjMvQ90ha1kM3hrG+G+0EREx3s9nyoMM4qyH/cxWKFPe9zNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqjBS312;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FE606A32F
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385FE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqjBS312
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53394bffe0fso18939281cf.1
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804990; x=1794409790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
        b=UqjBS312/c/2w9evq5oVv50fh7fn+AU2LR7D7BudxqdKdVweR4EHuyWSg+EzWJoxuv
         DYg7+0HsuU3jnjcfZJQ7U/KGN+iBwjLSQ3EgaojcJEHhqiIy775oZrLCgrF57lqzitB9
         WhS+wwZZOpmt0h3VELNcA/qG8erntWKPsNgAz6UOJtGlFiS3R76vlsUZu+feEkKZeL3x
         EEZKFvTcyB8wOWuimYAVo0Up7g4SBElo1JUyVut6bikcIFdGUpW8CLf6o+Bm5qBBy2HI
         LBNSLtofdXii3oUCTvCU7w99JPQcamBuXG2gjNbwCEO481IczwcmN6hv8xvXG2OHRRX7
         XuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804990; x=1794409790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
        b=JskOdGGLAQ3d5j8hiJRiAR/R2uDX52SH4VRD/75tPKuTwGJEI8tN8rWaViIUaRcLJE
         QKcJNVSUF0Z7WW0uG+iNJutj+kt66SVvs7Pdxge45KTpjxvKeg4TVA6rhsNgw6+3ezHA
         KXdLgSIAovn590wvfqF0Qd/wAZbFsU6VTMDm3UZMttWWUhzd+AvBbSHpslL1P7E7LUl+
         bcq5FDJbkqJXKcxj/VOv1JGjYpl6c+xWlWpJjN6yDHC9k7VPU7fP9HRYoQBihtAnaG0j
         qlKbb2S5OtrEbCsTmbleJjorQXhoZj8BLGJsQzyfporpq9fI4AmTODctYn1Eg2bNFaBf
         h3kg==
X-Gm-Message-State: APuU4Z+Fkw0wULez5Rf7zboSIT+oLisUk07UKic/v5RWbKdaLOmM9yWU
	FZyugukf2spj7y6B7qvSUqfiSt3grwZSm0EuAKc7XJMzjAZh5v2hpAKm+oMHVVm/
X-Gm-Gg: AYBFou0QjkDBIkkdwt1dalKhctz4FoD2RW0VINhO8oYE/iQU3GRSADS69eN6y+UYgWC
	slBRQ9zSpglGS5lucyxKz3SYW5IglMM1qycQtKEKw/BAQn0SYeUNoOXrgbpJkBIaQiIornEs/qi
	uqArZCZsyk9B+M0O/IV+X2Qxf1FMq+qp7oADGPejlJfU+8ZPevabltvWBbGPs5WJghqrL+5laxK
	ZOMHhtnvIIWejCYHKquro4wnqOAe62agvQy6yI43CnWyNcT22jWAGGOwYY91dS/ckYJ1sGsW6E0
	ZE7aYDTvVN+Ecs1mqSPp7jtTemNVDdiTgZ8K/+d3ATfKbuS+wwpcB3tG8YY5YbEkAF34qZ/N+xe
	6am+4Nw5I8E/Kvci/MVjWfNPSraHHVQC6Ddx4wlbz32VCXk3ukvvoonukdC8TRanF3GjC0iRXjn
	jM2S96T0w5FzAJ/duJlrrsYjyU+xLxg0YfQ0H7g4p+mcikMnUwdR+y7vF1MW3lXFaL0DqnPJoWk
	HACda1pabqT6tv86qBIhAu8wJA4pXq/XsJMSfjsulIoxPJeGwXbE6rcJ8XqGyjVFDBn7RiVuWpj
	zf285dqTWtR4zk/ZKpAqqFTDwFrFQbCvogo76dZOTOplUaIhbNpNpNVKny0fXDucEaCQHs5ANI+
	eb28tYJUVrZE/EyUr9BwwXonCT1u6p5/7+csz4uxrLKywsRJR5dZSpBD8eqMCPmT4gcmnRm1Vuj
	pazj5V1XpJ7/tPkqAfn/YPxzrzQT8w6xnQioASQpcQ+jS3pA+h5DQ=
X-Received: by 2002:a05:622a:4c13:b0:535:1740:d334 with SMTP id d75a77b69052e-542b4059965mr249930861cf.3.1793804990079;
        Wed, 04 Nov 2026 07:09:50 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:48 -0800 (PST)
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
Subject: [PATCH v3 20/20] libselinux: free shared regex contexts on library unload
Date: Wed,  4 Nov 2026 10:09:15 -0500
Message-ID: <20261104150915.175923-20-stephen.smalley.work@gmail.com>
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

The PCRE2 compile and match contexts are allocated once and shared across
regexes, but neither is freed when libselinux is unloaded. Repeatedly
loading the library, performing lookups and unloading it leaks one of each
context per cycle, even when all lookup threads exit before unload.

Free both shared contexts in the existing PCRE2 destructor. The PCRE2 free
functions accept NULL, including when initialization was never attempted
or allocation failed. Leave thread-local match-data ownership unchanged.

Add a full-library dlopen regression test covering repeated lookups and
unloads, unused loads, failed shared-context allocations, per-call compile
context fallback, and JIT on/off. Join workers before dlclose so thread-local
destructors run while the library is still loaded.

Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex matching")
Fixes: c42116d304b6 ("libselinux: fix incorrect regexp anchoring")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/regex.c                        |   2 +
 libselinux/tests/.gitignore                   |   1 +
 libselinux/tests/Makefile                     |   7 +-
 .../tests/test_regex_context_lifetime.c       | 192 ++++++++++++++++++
 4 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/tests/test_regex_context_lifetime.c

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 352767c9..3891610a 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -292,6 +292,8 @@ static void match_data_key_init(void)
 
 static void __attribute__((destructor)) match_data_key_destroy(void)
 {
+	pcre2_compile_context_free(compile_context);
+	pcre2_match_context_free(match_context);
 	if (match_data_key_created) {
 		__selinux_key_delete(match_data_key);
 		match_data_key_created = 0;
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index deaac265..6cc9309b 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -18,3 +18,4 @@ test-restorecon-digest
 /test-match-limit
 /test-avc-lock-failure
 /test-descendant-oom
+/test-regex-context-lifetime
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 6c146b07..c229e540 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom test-regex-context-lifetime
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -42,6 +42,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-match-limit
 	./test-avc-lock-failure
 	./test-descendant-oom
+	./test-regex-context-lifetime ../src/libselinux.so.1
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -53,6 +54,7 @@ clean:
 	rm -f test-match-limit
 	rm -f test-avc-lock-failure
 	rm -f test-descendant-oom
+	rm -f test-regex-context-lifetime
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -103,3 +105,6 @@ test-avc-lock-failure: test_avc_lock_failure.c ../src/libselinux.a
 
 test-descendant-oom: test_descendant_oom.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=malloc,--wrap=free,--wrap=getxattr $(PCRE_LDLIBS) -ldl -pthread
+
+test-regex-context-lifetime: test_regex_context_lifetime.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< -Wl,--export-dynamic,--no-as-needed $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_regex_context_lifetime.c b/libselinux/tests/test_regex_context_lifetime.c
new file mode 100644
index 00000000..71a0bf87
--- /dev/null
+++ b/libselinux/tests/test_regex_context_lifetime.c
@@ -0,0 +1,192 @@
+#define _GNU_SOURCE
+#define PCRE2_CODE_UNIT_WIDTH 8
+#include <assert.h>
+#include <dlfcn.h>
+#include <errno.h>
+#include <pcre2.h>
+#include <pthread.h>
+#include <selinux/label.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *live[32];
+static unsigned kinds[32], allocated[2], freed[2], failures[2];
+static unsigned fail_compile, fail_match, jit;
+static void *library;
+static const char *file;
+
+static void track(void *ptr, unsigned kind)
+{
+	unsigned i;
+	assert(ptr);
+	for (i = 0; i < 32 && live[i]; i++) {
+	}
+	assert(i < 32);
+	live[i] = ptr;
+	kinds[i] = kind;
+	allocated[kind]++;
+}
+
+static void untrack(void *ptr, unsigned kind)
+{
+	if (!ptr)
+		return;
+	unsigned i;
+	for (i = 0; i < 32 && live[i] != ptr; i++) {
+	}
+	assert(i < 32 && kinds[i] == kind);
+	live[i] = NULL;
+	freed[kind]++;
+}
+
+pcre2_compile_context *
+pcre2_compile_context_create_8(pcre2_general_context *ctx);
+pcre2_match_context *pcre2_match_context_create_8(pcre2_general_context *ctx);
+void pcre2_compile_context_free_8(pcre2_compile_context *ptr);
+void pcre2_match_context_free_8(pcre2_match_context *ptr);
+
+pcre2_compile_context *
+pcre2_compile_context_create_8(pcre2_general_context *ctx)
+{
+	if (fail_compile) {
+		fail_compile--;
+		failures[0]++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	pcre2_compile_context *(*fn)(pcre2_general_context *) =
+		dlsym(RTLD_NEXT, "pcre2_compile_context_create_8");
+	assert(fn);
+	pcre2_compile_context *ptr = fn(ctx);
+	track(ptr, 0);
+	return ptr;
+}
+
+pcre2_match_context *pcre2_match_context_create_8(pcre2_general_context *ctx)
+{
+	if (fail_match) {
+		fail_match--;
+		failures[1]++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	pcre2_match_context *(*fn)(pcre2_general_context *) =
+		dlsym(RTLD_NEXT, "pcre2_match_context_create_8");
+	assert(fn);
+	pcre2_match_context *ptr = fn(ctx);
+	track(ptr, 1);
+	return ptr;
+}
+
+void pcre2_compile_context_free_8(pcre2_compile_context *ptr)
+{
+	void (*fn)(pcre2_compile_context *) =
+		dlsym(RTLD_NEXT, "pcre2_compile_context_free_8");
+	assert(fn);
+	untrack(ptr, 0);
+	fn(ptr);
+}
+
+void pcre2_match_context_free_8(pcre2_match_context *ptr)
+{
+	void (*fn)(pcre2_match_context *) =
+		dlsym(RTLD_NEXT, "pcre2_match_context_free_8");
+	assert(fn);
+	untrack(ptr, 1);
+	fn(ptr);
+}
+
+static void *worker(void *unused)
+{
+	(void)unused;
+	struct selabel_handle *(*openfn)(unsigned, const struct selinux_opt *,
+					 unsigned) =
+		dlsym(library, "selabel_open");
+	int (*lookupfn)(struct selabel_handle *, char **, const char *, int) =
+		dlsym(library, "selabel_lookup_raw");
+	void (*closefn)(struct selabel_handle *) =
+		dlsym(library, "selabel_close");
+	assert(openfn && lookupfn && closefn);
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_BASEONLY, "1" },
+		{ SELABEL_OPT_JIT, jit ? "1" : NULL },
+	};
+	struct selabel_handle *h = openfn(SELABEL_CTX_FILE, opts, 3);
+	assert(h);
+	for (unsigned i = 0; i < 3; i++) {
+		char *ctx = NULL;
+		assert(lookupfn(h, &ctx, "/test/leaf", 0) == 0);
+		assert(!strcmp(ctx, "system_u:object_r:test_t:s0"));
+		free(ctx);
+	}
+	closefn(h);
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	assert(argc == 2);
+	char path[] = "/tmp/selinux-regex-context-XXXXXX";
+	int fd = mkstemp(path);
+	assert(fd >= 0);
+	FILE *fp = fdopen(fd, "we");
+	assert(fp && fputs("/test/.* system_u:object_r:test_t:s0\n", fp) >= 0 &&
+	       fclose(fp) == 0);
+	file = path;
+	unsigned cases = 0;
+	for (jit = 0; jit < 2; jit++) {
+		for (unsigned mode = 0; mode < 5; mode++) {
+			for (unsigned cycle = 0; cycle < 3; cycle++) {
+				memset(allocated, 0, sizeof(allocated));
+				memset(freed, 0, sizeof(freed));
+				memset(failures, 0, sizeof(failures));
+				fail_compile = mode == 2 || mode == 4;
+				fail_match = mode == 3 || mode == 4;
+				library =
+					dlopen(argv[1], RTLD_NOW | RTLD_LOCAL);
+				if (!library) {
+					fprintf(stderr, "%s\n", dlerror());
+					abort();
+				}
+				if (mode) {
+					for (unsigned repeat = 0; repeat < 3;
+					     repeat++) {
+						pthread_t thread;
+						assert(pthread_create(
+							       &thread, NULL,
+							       worker,
+							       NULL) == 0);
+						assert(pthread_join(thread,
+								    NULL) == 0);
+					}
+					assert(failures[0] ==
+					       (mode == 2 || mode == 4));
+					assert(failures[1] ==
+					       (mode == 3 || mode == 4));
+					assert(allocated[0] ==
+					       (failures[0] ? 3U : 1U));
+					assert(allocated[1] == !failures[1]);
+					assert(allocated[0] - freed[0] ==
+					       !failures[0]);
+					assert(allocated[1] - freed[1] ==
+					       !failures[1]);
+				} else {
+					assert(!allocated[0] && !allocated[1]);
+				}
+				/* Join first so all TLS destructors finish before unload. */
+				assert(dlclose(library) == 0);
+				assert(!dlopen(argv[1],
+					       RTLD_NOW | RTLD_NOLOAD));
+				assert(allocated[0] == freed[0] &&
+				       allocated[1] == freed[1]);
+				cases++;
+			}
+		}
+	}
+	assert(unlink(path) == 0);
+	printf("regex-context-lifetime: %u unload scenarios passed\n", cases);
+	return 0;
+}
-- 
2.56.0

