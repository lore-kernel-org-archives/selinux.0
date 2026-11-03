Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732018;
	b=FfYV8GoyfpFcReCuncVrtHKdejfne4tAoaQIuJ6vyVn50cM7TgMY3Yd7ZxbaCwZ9h3HO
	 mk0OVNzjgXgT/B/wowCj+M9O2y8lkVPIGAtLpXuAlFZZwwEIuskcLemLRFM1Nf9/f5m4D
	 b9yWk1kL07KXEPE2waXsZG1kDmTF16RDcc9keBx6tYdU+SBMtEq3O0HQtRaWnVNGn+ODb
	 /HwMz9Wper778XzBZ8qOJ/DrE3/Ll5wZpx7Lck4jFPcRymndPtn+uNDaVUs+qBxxtXQFk
	 +h6VT8EJp66cowvHz2ziIkFIeGaWmzd3P8iveAbf/O+1prFyQTzEuYEi/kAwze3cpvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
	b=leTwgGK3VMyyy3kzNpuPRYdAsfywv2qaxl0ZEncIf6GVEfxKUPx8cPF7t7jXUI0riwEZ
	 eNno3UTCw9x6yZqq/8vPjW9+bzxPkROaIpxNODVl7wVifB+qMHh0pDctGt++jSvcB8sns
	 ZylWMpuBw6l/rri4wIoqcAD3EXjDYkEcyATFWdwFwizu1/gEDlHlwvb3RUE9cnSe3JgzK
	 qG/c8gWZNXGZ3hQ8wlb8KlX/wJ4CJfVN0VHVxWs2z5msJlsTAB2jNJofNARorjbqQiCcE
	 MgGaTgAFCTYXBavyYQ7Mp17+jciNpcC2vdzn2yti9RvTf6YMCNXwpHhsYrIdVTO+dCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P0iOXQA/";
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895C606A31B
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C895C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0iOXQA/
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c719669a8so47596296d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732017; x=1794336817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
        b=P0iOXQA/MW6w6Qc2vE64rxGRvFLQLrpWmX+NE7nz9z1UvtlznpxRBDRJ8y66qOYCgt
         v30I6ixzWFP3zvFd0ZD9ea1G4/PBFCo+CDqXqWJTlfoCNtJpgYqrvPoQQpLyX7VVQELh
         2XXqqRTS0Jl+seCUTJSUS4YitKFws4zd+TOptCWJb2mKCGTXzsYj65H7asKLIgoh9Qjo
         69lQZVRB2C6jOPeXkL/rSB4oiiT5DoXJMsjVBCk5un4mVA7ac2/5dNK9gZ/3fhejs6hb
         m2efip7b9h2Cm1qmLShvGxmrmbdfBI3+/JAOfDeYStRqZJIwF6uwPQL0IggQ1ryM+e+c
         DALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732017; x=1794336817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=457xCmAoVktCvk3q/jBVLHnyTBAurTvz8m5HFaSMKZI=;
        b=lo1pbbqHROAE6taDyldCmLcm0Fg2sU0Ma2xfHPAWE4o0UWkpymS+sToE6Tv0XCvEFj
         qpZzyuDDRF8LSHtDiVwGaG3xVnsdmk0vp3ON/Q8PBsR0J5357eicSOK/VbZisamdcxzd
         rlQ4pSN/4xcPVtwhCjXyF4SdUFLRtvBTJa7uInoMjGywVywjM+I7VQcDkZQRafCPoIpf
         BvL7mvHvFMvBDM4UcYfkqIxakHqhqcCh5iBQu7T/AW16STYFFQneWrLhiNUom7FNjZJY
         bmldyeBxlVo91oZG0xUbUeofQLuDebIXnX0iLm/pWKyVlqoTJSOON3FkIJ4PROkIdW7X
         vzFg==
X-Gm-Message-State: APuU4Z9T6xOHUhihWVrp3dllPptSguTQfT61YtzYjhH5O3cdLTP/F9aH
	BoF2BEyUPzcwa2FChN3vMUHThkj7qv7NtuM5JYWqFu+PG03g6rwvFRrj8f1KUbSA
X-Gm-Gg: AYBFou3XtKM2feS4TVkPyg3/NMva3f5I+GXM9VoIN4S8zNopiPegOrzWuPR4iIVdAVU
	MPeASkRi7yCvlV2Gal3c+dmVTDAiafq+AHrwcbYaeYdsI+S+U3xZFjjL1ixnOwT/BJBO7t2lyp1
	ZAmQUz6Tx4cjKxmjT8vBcLWL4MlOXh11EpDH9CvZC2lW5+XuPkWxYHadZvkThLw6XrvlnqUqW1m
	n9EatNtdn2/0hBFlJtHsQQ6SpBg1CzNXtN4JUndxbJwYRrid4e7RIeanrlOrEOi6GtEluo/IHGW
	HLMdGT54IgzVx4o/ZOi2UZpEpw1zPmuHqf60S3xvt9LB0hT6L+hYSvbLckdXPTsEIcD/vz+X0ZF
	4B+UjCADLBvnjx6W11hcOq71GiO8/z+MEG0/+NlJ+9luIALpLgMz6ERNAuNnkFQqVsGXnrDVc16
	jemoO2CsN7qSMlFejQeeWNR9i1ZPbITp5wCC/5wdhDiHM/mMLkqf8kbeJhDkv9G7fZwq1LdRQ38
	OFqMeZjj1tewXKifJHeBEkj24/EVXVq+E67xy3K1+AwKLzPvsMHNNoVKB+t/4Dm5cIE0DfRu46d
	3fofeAcNc0ZOaSzTh+E+U06dNZYBQeDxKBgD0tvJeRBJ7fr53i2SUE6mt1odmcNOcC9YnLqjVNU
	rZ3fhgB/Wg083WhCMLFBUwIjbLu/7lwPKziN+hV4RpTLRDjjQXMlbNx8mwiobyiKiQo7pl9zrAm
	Waf6raa8hCgyoXeOo0aXYIoXT2iKV/jOpH+65uXmDGuorZJhazSMg=
X-Received: by 2002:a0c:f409:0:b0:91b:98fe:d2ca with SMTP id 6a1803df08f44-91ca4af7b65mr238496716d6.23.1793732016499;
        Tue, 03 Nov 2026 10:53:36 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:36 -0800 (PST)
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
Subject: [PATCH v2 18/20] libselinux: fail AVC initialization when a default lock allocation fails
Date: Tue,  3 Nov 2026 13:53:05 -0500
Message-ID: <20261103185307.45924-18-stephen.smalley.work@gmail.com>
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

