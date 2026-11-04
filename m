Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804989;
	b=oA2IFl+Plbwj7S3lWpEuT9vhohLgte9BCYApBBcIdLLVVVqYjpXGY1MYWPDwyPR4/RXY
	 Fn8RBksjbgLPCsiK1ocdjVDGWJFvkFswgHS28NgFbPQrPTvQYNhSed4uWaeqNxABpjlq8
	 41AeumxhSNwPhGuMIRMAjZdm9e899Lg8CesD8MfsQKE9RM7H2oIeIHHgje8DrV9OCfpPI
	 Qikoj953R00pdsZX+zOYuuUq+/OsVjmwmjjShjy6x4fQt3FWIleqeWZO9V4EDvnv0vqmm
	 eb0pmBsJMbTHa5vXh2/VeBKG4B1ZZrDwMp05atM7oFOnycNoLIm1PDkxub5ussgDAzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
	b=zPRMJJr5zMkrGh+2OuC8sdvr4sELTlDdih1J1ybStKPQWLk5b2YzotRhEp4Slj2OS7Pz
	 6nVSicbOUqmMWQxDJgf3QNaFfjXs3yiLYioiYW1ZUGhU5LwNFAQxGOo9OW05UnKp+RFIX
	 Z7X2Qzmuw1U4pJCNGIO8hcAUAcVxI5eSazHF4sRi6MLkcdvviUV2S14LHwKDX4CcESsV2
	 kGoYadlXIgoxDQRZOmkZjX6M1E4r+DcmaEntPSAQQF3MbucMmgfGlhW374309bsM4w0oF
	 +5yGUsd6XbRhIRE29p+lMUbYFywseDpbc/4Fi1akU+oDGX1aAkQ009WvVmbVbpVXzIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLlF6aaZ;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEC606A332
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FEEC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLlF6aaZ
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365b48238dso6266691cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804988; x=1794409788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
        b=WLlF6aaZDct2E4Ttd3YzYj0CJBBfCFOIRi/jZDwUwIOXELU1BPOICg4qzMMMtFKYom
         jX0W4gjdo+3JuB+HGIhRQmp0MXMbpJD4p2QYujuULw6nmez/yVzETvRIPDFazM2XfO2i
         kG9zAFCUONKaFe5CHBiVnQpZtRv6iFn59L2vcFcd/Fc/rIhPKswVrGF7oYTrfVdk8h/9
         YRBCGNAYJSdxPM5c7n4qWIkM8jT9tJZwOVcp3JoPjFLchuZo4zlX2jfHnTBZXzkR7AcH
         CcZUNhxmUv3mkli6No27TiDNbn/egH0amM4NqP04NMc6CexgAt2ybNiYGw2trQiCToGx
         q7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804988; x=1794409788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
        b=mUvNJl7JmhkoSoNajJJNuXgoAcmUSNN76v0X0QHGlvxpe6ux2DC6Np97tSd8ujV50r
         qoQ1hUCVCO87ObRqxk7euDLMh6sBSvuiiS2PjT1ko54W4dWS2rrAjV/w9JLNTB7OPcr9
         6VEy0/5VrXl5rvsb481gn0I8XZ/birCbagRuwAfKfAmuTrbyHH7A3kd8YOprMUA7JbCY
         RI70CDDSFjeNNWonGlQ0YfYqHOWV1DOE5EiuYkf9UAO60NFDYyYjpKN27GO86tkAqng/
         I4KIxwmcZnx4FkCSfPPRxXl9+RriL+QenDL52gxPxYKEwZK78p7B/GrN5USYyPB6DKfl
         uzBQ==
X-Gm-Message-State: APuU4Z/KwQa8DPiwHw1ywYsB+ZFqxA3ZHpIOCrekZX3SJK0nAEJCgKB9
	VZnzmM2CI9AfmzjgWMTcHZCMe7AqEqgyo7z4nsh1QC8UhQ/5jk+eiVlCgjWRM+2J
X-Gm-Gg: AYBFou3Dwpg16K8Zx03CPxR6I0f/byrIeV57KbttY5DB/4ELvGD6ZNfTs3q5wFISrF6
	nGOQn6hU2r1HjPIgy2XsqMuuw5CaZj24BCJMkGPBfq+383QNwuGxHXG36wCtDRa3OJb1hfKmT6i
	IByPbRH2FB65fQHjmnFEYQlEmheDLMwypZzAKqvXEM6ufKT0WXeVoeAKc2FGAC0YSkZXSnFLVDI
	pfkrApP2PbTtCFLqOW2Kf8/bnBEV6I7e2xqPzzpI/cEc9gbSsVSIMc57Rmue1e844PiPHa59tX8
	Uhq5YHTlOdwMQb1Dwq2KEhcZUvgdi32JuiB9pInZPo3hS+Ev4QyCjciVwKFGzZi0ohyR1AiRgE3
	X8cuDHFSFGBlRR5POpnbrH/CtjVglOWbWCZ3KY0kZ/0IAOZUy2/10FCIDIU7eN7d7sRBcb54cHv
	5L/VxZNO9z+JUAfCbYlHtRQvBib21VFmImCTvuisN1VMlJqKHf1nhzmwcXur9mW8wzoGb1Kkuxf
	l2Hz6n2sMv6rAU/qM4DCpDuhQ2GwNXp5w3VB/19WJ9wxWK23Cw35A3okbK2px21+PkTrYDsCIhY
	0DaMCFSYLWMXqe6hdCZCCL7LvhEMeKOELSZYTGYKkCUH/TKF/g336awcLJJOtNoWlp5ozw83DIf
	cmEs1dCZ4cWvrtVFJMi9Rh5erKVsg+1NWC0ivqJvOLGT2/vKIwoUf/mS4aWKko/sm5K7dWJbFpz
	kUhgvsyhchKIBSSOmmLsvGltAeqjwDirLyfNC25RE/7TVizgMrrTV71YStNZoSY2xFwegIz2ay
X-Received: by 2002:a05:622a:580e:b0:535:a5fb:644c with SMTP id d75a77b69052e-542b83f1a71mr257041361cf.70.1793804987860;
        Wed, 04 Nov 2026 07:09:47 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:47 -0800 (PST)
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
Subject: [PATCH v3 18/20] libselinux: fail AVC initialization when a default lock allocation fails
Date: Wed,  4 Nov 2026 10:09:13 -0500
Message-ID: <20261104150915.175923-18-stephen.smalley.work@gmail.com>
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

The default AVC lock allocator can return NULL, but avc_init_internal()
does not check either result. If later allocations succeed, avc_open()
reports success without a cache lock or audit-buffer lock, leaving
concurrent callers unsynchronized.

When using the default allocator, require both locks before proceeding.
Free any successfully allocated lock and return ENOMEM on failure.
Preserve application-supplied lock callback behavior, including callbacks
that use a NULL token for a no-op lock.

Add allocation-failure, later initialization-failure, cleanup/retry and
custom callback regression coverage. This does not change mutex lifetime
or the inactive ratelimit code.

Fixes: a21061f5f335 ("libselinux: avc: use pthread mutexes by default when no lock callbacks set")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/avc.c                     |   6 +
 libselinux/tests/.gitignore              |   1 +
 libselinux/tests/Makefile                |   9 +-
 libselinux/tests/test_avc_lock_failure.c | 134 +++++++++++++++++++++++
 4 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/tests/test_avc_lock_failure.c

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 779ce8ab..e9def111 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -162,6 +162,12 @@ static int avc_init_internal(const char *prefix,
 
 	avc_lock = avc_alloc_lock();
 	avc_log_lock = avc_alloc_lock();
+	if (!avc_func_alloc_lock && (!avc_lock || !avc_log_lock)) {
+		avc_free_lock(avc_lock);
+		avc_free_lock(avc_log_lock);
+		errno = ENOMEM;
+		return -1;
+	}
 
 	memset(&cache_stats, 0, sizeof(cache_stats));
 
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 39548615..0363bf3d 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -16,3 +16,4 @@ test-restorecon-digest
 /test-regex-tls
 /test-policy-root-boundary
 /test-match-limit
+/test-avc-lock-failure
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index c36cd4ae..ef1c490a 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,6 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
-override CFLAGS += -I../include -I../src -pthread
+override CFLAGS += -I../include -I../src -pthread -Wno-deprecated-declarations
 PYTHON ?= python3
 INIT_OOM_WRAPS = asprintf __asprintf_chk strdup calloc free
 XDEV_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64 fstat fstat64
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -40,6 +40,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-regex-tls
 	./test-policy-root-boundary
 	./test-match-limit
+	./test-avc-lock-failure
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -49,6 +50,7 @@ clean:
 	rm -f test-regex-tls
 	rm -f test-policy-root-boundary
 	rm -f test-match-limit
+	rm -f test-avc-lock-failure
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -93,3 +95,6 @@ test-policy-root-boundary: test_policy_root_boundary.c ../src/selinux_config.c .
 
 test-match-limit: test_match_limit.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=pcre2_match_8,--wrap=getfilecon_raw,--wrap=setfilecon_raw,--wrap=getxattr,--wrap=fsetxattr,--wrap=fstatfs,--wrap=fstatfs64 $(PCRE_LDLIBS) -ldl -pthread
+
+test-avc-lock-failure: test_avc_lock_failure.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=malloc,--wrap=free,--wrap=security_getenforce,--wrap=selinux_status_open,--wrap=selinux_status_close $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_avc_lock_failure.c b/libselinux/tests/test_avc_lock_failure.c
new file mode 100644
index 00000000..b995f35e
--- /dev/null
+++ b/libselinux/tests/test_avc_lock_failure.c
@@ -0,0 +1,134 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <selinux/avc.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void *live[2048];
+static unsigned calls, outstanding, fail_at;
+static unsigned custom_allocs, custom_gets, custom_frees;
+static bool track, fail_enforce, fail_status;
+void *__real_malloc(size_t size);
+void __real_free(void *p);
+
+void *__wrap_malloc(size_t size);
+void __wrap_free(void *p);
+int __wrap_security_getenforce(void);
+int __wrap_selinux_status_open(int fallback);
+void __wrap_selinux_status_close(void);
+
+void *__wrap_malloc(size_t size)
+{
+	if (track && ++calls == fail_at) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	void *p = __real_malloc(size);
+	if (track && p) {
+		unsigned i;
+		for (i = 0; i < 2048 && live[i]; i++) {
+		}
+		assert(i < 2048);
+		live[i] = p;
+		outstanding++;
+	}
+	return p;
+}
+
+void __wrap_free(void *p)
+{
+	for (unsigned i = 0; p && i < 2048; i++) {
+		if (live[i] != p)
+			continue;
+		live[i] = NULL;
+		outstanding--;
+		break;
+	}
+	__real_free(p);
+}
+
+int __wrap_security_getenforce(void)
+{
+	if (!fail_enforce)
+		return 1;
+	errno = EIO;
+	return -1;
+}
+
+int __wrap_selinux_status_open(int fallback)
+{
+	(void)fallback;
+	if (!fail_status)
+		return 0;
+	errno = EIO;
+	return -1;
+}
+
+void __wrap_selinux_status_close(void)
+{
+}
+
+/* Complete application callbacks may use a NULL token for a no-op lock. */
+static void *custom_alloc(void)
+{
+	custom_allocs++;
+	return NULL;
+}
+
+static void custom_get(void *p)
+{
+	assert(!p);
+	custom_gets++;
+}
+
+static void custom_put(void *p)
+{
+	assert(!p);
+}
+
+static void custom_free(void *p)
+{
+	assert(!p);
+	custom_frees++;
+}
+
+int main(void)
+{
+	for (unsigned stage = 0; stage < 6; stage++) {
+		for (unsigned cycle = 0; cycle < 3; cycle++) {
+			calls = 0;
+			fail_at = stage < 4 ? stage + 1 : 0;
+			fail_enforce = stage == 4;
+			fail_status = stage == 5;
+			track = true;
+			errno = 0;
+			assert(avc_open(NULL, 0) == -1);
+			assert(errno == (stage < 4 ? ENOMEM : EIO));
+			track = false;
+			assert(outstanding == 0);
+			calls = fail_at = 0;
+			fail_enforce = fail_status = false;
+			track = true;
+			assert(avc_open(NULL, 0) == 0);
+			track = false;
+			security_id_t sid;
+			assert(avc_context_to_sid_raw(
+				       "system_u:object_r:retry_t:s0", &sid) ==
+			       0);
+			avc_destroy();
+			assert(outstanding == 0);
+		}
+	}
+	struct avc_lock_callback cb = { custom_alloc, custom_get, custom_put,
+					custom_free };
+	assert(avc_init("test", NULL, NULL, NULL, &cb) == 0);
+	security_id_t sid;
+	assert(avc_context_to_sid_raw("system_u:object_r:callback_t:s0",
+				      &sid) == 0);
+	avc_destroy();
+	assert(custom_allocs == 2 && custom_frees == 2 && custom_gets);
+	puts("AVC lock failure: 18 failure/retry cases and custom callback control passed");
+	return 0;
+}
-- 
2.56.0

