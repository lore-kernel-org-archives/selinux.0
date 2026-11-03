Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732017;
	b=a82n7MxBNN2EKj4bui9kbjKiOTaMA4VvGtftY1DYyUUYj5X49rTK1eizIDnH89OVNTjh
	 DejKRR6QFfwk51JwhoxbmFwaxWRlIEw7bYTY64y+X79CImtJqEIYPJHpLWqBvE5HSgUAs
	 +DMWHkj45PVHNr4aBS6xXBhzEJXk3Yf/y9Gu3foX2lWWiDa0zx0Gw5iwi2NtlGxI608t6
	 4Cba11XI4CPFJgLUS5Lv5uCUmBBzyBypAkGwgWJlxz7+kuU4uPeupeq+1Mt6v9lw1pfl3
	 DMEdcgHGABzosC8tTkHeUydrtiuerxW03iBQ4kS152karXCaWRMWhUI73OFCgU7LHQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
	b=JXsOAtM69t4y/tio/edE1tNRaokijyf8mMaYHyQjV8IioFKaQzvHFnQGDQhTI3dm71MX
	 BgLxud185Rhwhuj4CzOuvZ4o8cezkMUXjpUgYVXXy96fr942XoUm1fNChjlyzpCCTEVpk
	 7NYaX/RkdgB9xa1gWlj4CCSXJPuy0qlCx/WP7PEOxd4npKdfXdE8szFIUlsY4CjeGdlCq
	 tnVfcBb/mNQrarPf5tx/DoiLcc/RrAa9qrbPzbvdC6S3IKIi94rPGpyKb5MV0rVALbyGY
	 BmCeFoAbrHUUG5rrcl+ML2UhbZ5EdF5LFKfBzq426Irsm2ucICn9kkaDd4DT7Cxsnow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyfHmZMr;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D06606A31B
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D06606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyfHmZMr
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b8306b9f8so76734386d6.3
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732015; x=1794336815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
        b=wyfHmZMrwIxWCxt8IGxjJLblGV9x3/xpBfO8ws1/8cdwSiaZf3yFZ3n9bRO7inPuor
         r7cjWW3do9v7uiLHgfI7aXa5XVr8rJPwcprKQw750pzxsr/6EG8BAqcYFntkJITT3tQT
         NaTlFxfz6BT0/aA9/qQkCgmG5EHhWQJPw4tB6VAtZ8H51fD8XAYs0m9X3QKv5kDJW1dx
         kjI2GpPjylZC78taSwa5J7d5m5jSJnMZpS7BztxTIWZ5iqCOMjWFypKPDHBetn6fdXep
         Us7J5bZuSfbh5eglG868J3QIsbGTCbl1f3PklitQoLTTLYlwA2+ZM6Wi1xVxy+P62rMT
         /hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732015; x=1794336815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
        b=vyELYvPid6dst6Nj3Os9p9Lq94Kx+CjNch6JTsZPLYvXYEOW28FCQXNPh1ym/jCpjZ
         s/6xVxUaiezgrkWsE72k6yunSindc4kJUmOe/eKHbssO8rE62sCRSl3/DslBINfCs+B9
         cJ/ipY+voBiYAP5k2nYInWltk2nCu4pbicARyD8gXUeBVZoT/jW3fHhX1h41DxW0GFGU
         1yu5tSTjn88VKsqL7yyxgM1VmFe6EJob6HcinhTsMPfE7Cyh+xdVINQOcxYWs6028630
         2M7Aow8p0omWacgUQDEt4dBisOc+I+weHJnJS82/Wqvddf+LkcCKuqntpJuF+m71hNyj
         xJ1w==
X-Gm-Message-State: APuU4Z9OoWzTobCxp3HiESwYjDvKTjCQo7I8Ki8eSS0gk36ZHCcLp7NO
	0cBDj58KGSmMJAyxw71p6CLH6K7HroQ+1fwMRp7pmACS4w44hFZPqzlVDjVnJMT0
X-Gm-Gg: AYBFou2deKVe+1D4zKnf62ONiXbnWlWARpV90I5Bnjc5fA1nJFD8lpyYNZlgRV8DmDh
	YXxIuEzr5yDwrTqDw7T53FLw+L+j7OYgCubTRXvauh0Y4ej2PcKEsbr6+wSorM7sMF6KPVyQrkn
	PR2+VfOjHxlOdOx/oVFcFOONwMiiwx5GX8BifES+l2TBaiDI1rrVsNE4vZ9BwcSj5hsY5FDPzZ6
	7MxR3NqLyqFDUlSeIOvDR/5Psa8t7yzpYCd5+aq6XF++/EKeLHUmbinzbxzZEjpAyqaPjLc+aCn
	LhcXWPpG6c0use26j9MyFxrq0+23u0YrmlX0yi4CATI0gYSvZgnkAj+AWwrgDvj7CM6swH3Mccv
	4RDMMh293KuQP6ahkWiUQae2TPJf8YDEGIeTCBI+KwE3XrHqV2IFIBp/8kUE19NPKtG5gmh+HKV
	b0kj0JWvr3pTSbhQ3RIpY1SGPGNtbdj1Mu6LkLpifKcRweuagm4XhyROz/1xbzRBJev5xEMAwwS
	4jNRFD7vrVL5j1+2czHEZfrTalPM1VxJ59izowh5SAW3S2SxPWjhM9jMrcgpYEcasIcqBaVZaSv
	7lxLtzcOK/Zs4T5uYt7t+D7RomqTfxv54gUtOqmo5pR0a5c4htMiHUUcIt7W/Rc8id3eoMIZwCp
	slotFJuZEVJbVUqXz+4/uw9GPy3XWV1i7mSZOkgyKbA2z968++1fv6TWb6FF6neLnZ15gnmfkgA
	072thchjzhm94gYq4uErid7pSi1qUriuPVIE7vzOQIGzYPxH6MCEM=
X-Received: by 2002:ad4:5cef:0:b0:91c:7a28:ac2c with SMTP id 6a1803df08f44-91ca4bcac7emr240576156d6.45.1793732014696;
        Tue, 03 Nov 2026 10:53:34 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:34 -0800 (PST)
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
Subject: [PATCH v2 15/20] libselinux: free regex match data when TLS assignment fails
Date: Tue,  3 Nov 2026 13:53:02 -0500
Message-ID: <20261103185307.45924-15-stephen.smalley.work@gmail.com>
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

Return the pthread_setspecific result from the internal wrapper and check
it when caching PCRE2 match data. If assignment fails, keep the buffer
locally owned and free it after matching rather than leaking one buffer
per attempt. Successfully cached data remains owned by the TLS destructor.

Use the same temporary ownership flag for the existing uncached fallback.
Other wrapper callers retain their previous behavior. Test persistent and
transient assignment failure, key creation failure, allocation fallback,
and successful caching with JIT on and off through public label lookups.

Fixes: ffd5b6645ac7 ("libselinux: improve performance with pcre matches")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/regex.c            |  13 +--
 libselinux/src/selinux_internal.h |   7 +-
 libselinux/tests/.gitignore       |   1 +
 libselinux/tests/Makefile         |   7 +-
 libselinux/tests/test_regex_tls.c | 153 ++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 12 deletions(-)
 create mode 100644 libselinux/tests/test_regex_tls.c

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index deadcc6f..251c41a0 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -310,7 +310,7 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
-	bool slow;
+	bool temporary = false;
 	pcre2_match_data *match_data = NULL;
 
 	__selinux_once(match_data_key_once, match_data_key_init);
@@ -320,18 +320,19 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 		if (!match_data) {
 			match_data = pcre2_match_data_create(1, NULL);
 			if (match_data) {
-				__selinux_setspecific(match_data_key,
-						      match_data);
+				temporary =
+					__selinux_setspecific(match_data_key,
+							      match_data) != 0;
 			}
 		}
 	}
 
-	slow = (match_data_key_alloc_failed || match_data == NULL);
-	if (slow) {
+	if (!match_data) {
 		match_data = pcre2_match_data_create_from_pattern(regex->regex,
 								  NULL);
 		if (!match_data)
 			return REGEX_ERROR;
+		temporary = true;
 	}
 
 	/* Use pcre2_match() rather than pcre2_jit_match(): pcre2_match()
@@ -343,7 +344,7 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 			 partial ? PCRE2_PARTIAL_SOFT : 0, match_data,
 			 match_context);
 
-	if (slow)
+	if (temporary)
 		pcre2_match_data_free(match_data);
 
 	if (rc >= 0)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8592c80c..0d47f40f 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -37,11 +37,8 @@ extern size_t selinux_page_size;
 			pthread_key_delete(KEY); \
 	} while (0)
 
-#define __selinux_setspecific(KEY, VALUE)                \
-	do {                                             \
-		if (pthread_setspecific != NULL)         \
-			pthread_setspecific(KEY, VALUE); \
-	} while (0)
+#define __selinux_setspecific(KEY, VALUE) \
+	(pthread_setspecific != NULL ? pthread_setspecific(KEY, VALUE) : -1)
 
 #define __selinux_getspecific(KEY) \
 	(pthread_getspecific != NULL ? pthread_getspecific(KEY) : NULL)
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index ecbbc014..5361f4f6 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -13,3 +13,4 @@ test-restorecon-digest
 /test-auxiliary-duplicates
 /test-android-specfiles
 /*.o
+/test-regex-tls
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 89899d6f..02e9b594 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -37,12 +37,14 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-auxiliary-duplicates ../utils/sefcontext_compile
 	./test-android-specfiles
 	$(PYTHON) test_policy_open.py
+	./test-regex-tls
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 	rm -f test-load-policy-version
 	rm -f test-auxiliary-duplicates
 	rm -f test-android-specfiles android-label.o android-backend.o
+	rm -f test-regex-tls
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -78,3 +80,6 @@ android-backend.o: ../src/label_backends_android.c ../src/label_internal.h
 
 test-android-specfiles: test_android_specfiles.c android-label.o android-backend.o ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=calloc,--wrap=strdup,--wrap=free,--wrap=fclose $(PCRE_LDLIBS) -ldl -pthread
+
+test-regex-tls: test_regex_tls.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=pthread_setspecific,--wrap=pthread_key_create,--wrap=pcre2_match_data_create_8,--wrap=pcre2_match_data_create_from_pattern_8,--wrap=pcre2_match_data_free_8 $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_regex_tls.c b/libselinux/tests/test_regex_tls.c
new file mode 100644
index 00000000..5976550d
--- /dev/null
+++ b/libselinux/tests/test_regex_tls.c
@@ -0,0 +1,153 @@
+#define _GNU_SOURCE
+#define PCRE2_CODE_UNIT_WIDTH 8
+#include <assert.h>
+#include <errno.h>
+#include <pcre2.h>
+#include <pthread.h>
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static unsigned created, freed, assignments, mode, jit;
+static void *live[128];
+static char path[256];
+
+static void track(void *p)
+{
+	assert(p && created < 128);
+	live[created++] = p;
+}
+
+pcre2_match_data *__wrap_pcre2_match_data_create_8(uint32_t n,
+						   pcre2_general_context *ctx);
+pcre2_match_data *
+__wrap_pcre2_match_data_create_from_pattern_8(const pcre2_code *code,
+					      pcre2_general_context *ctx);
+void __wrap_pcre2_match_data_free_8(pcre2_match_data *p);
+int __wrap_pthread_setspecific(pthread_key_t key, const void *p);
+int __wrap_pthread_key_create(pthread_key_t *key, void (*destroy)(void *));
+
+pcre2_match_data *__real_pcre2_match_data_create_8(uint32_t,
+						   pcre2_general_context *);
+pcre2_match_data *__wrap_pcre2_match_data_create_8(uint32_t n,
+						   pcre2_general_context *ctx)
+{
+	if (mode == 4) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	pcre2_match_data *p = __real_pcre2_match_data_create_8(n, ctx);
+	track(p);
+	return p;
+}
+
+pcre2_match_data *
+__real_pcre2_match_data_create_from_pattern_8(const pcre2_code *,
+					      pcre2_general_context *);
+pcre2_match_data *
+__wrap_pcre2_match_data_create_from_pattern_8(const pcre2_code *code,
+					      pcre2_general_context *ctx)
+{
+	pcre2_match_data *p =
+		__real_pcre2_match_data_create_from_pattern_8(code, ctx);
+	track(p);
+	return p;
+}
+
+void __real_pcre2_match_data_free_8(pcre2_match_data *);
+void __wrap_pcre2_match_data_free_8(pcre2_match_data *p)
+{
+	if (p) {
+		unsigned i;
+		for (i = 0; i < created; i++)
+			if (live[i] == p)
+				break;
+		assert(i < created);
+		live[i] = NULL;
+		freed++;
+	}
+	__real_pcre2_match_data_free_8(p);
+}
+
+int __real_pthread_setspecific(pthread_key_t, const void *);
+int __wrap_pthread_setspecific(pthread_key_t key, const void *p)
+{
+	assignments++;
+	if (mode == 1 || (mode == 2 && assignments == 1))
+		return ENOMEM;
+	return __real_pthread_setspecific(key, p);
+}
+
+int __real_pthread_key_create(pthread_key_t *, void (*)(void *));
+int __wrap_pthread_key_create(pthread_key_t *key, void (*destroy)(void *))
+{
+	if (mode == 3)
+		return EAGAIN;
+	return __real_pthread_key_create(key, destroy);
+}
+
+static void *worker(void *unused)
+{
+	(void)unused;
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, path },
+		{ SELABEL_OPT_BASEONLY, "1" },
+		{ SELABEL_OPT_JIT, jit ? "1" : NULL },
+	};
+	struct selabel_handle *h = selabel_open(SELABEL_CTX_FILE, opts, 3);
+	assert(h);
+	for (unsigned i = 0; i < 32; i++) {
+		char *context = NULL;
+		int rc = selabel_lookup_raw(
+			h, &context, i % 2 ? "/test/file" : "/test/missing", 0);
+		if (i % 2) {
+			assert(rc == 0 &&
+			       !strcmp(context, "system_u:object_r:test_t:s0"));
+			freecon(context);
+		} else
+			assert(rc == -1 && errno == ENOENT && !context);
+	}
+	selabel_close(h);
+	return NULL;
+}
+
+int main(void)
+{
+	char dir[] = "/tmp/selinux-regex-tls-XXXXXX";
+	assert(mkdtemp(dir));
+	snprintf(path, sizeof(path), "%s/contexts", dir);
+	FILE *fp = fopen(path, "we");
+	assert(fp &&
+	       fputs("/test/(file) system_u:object_r:test_t:s0\n", fp) >= 0 &&
+	       fclose(fp) == 0);
+	for (jit = 0; jit < 2; jit++) {
+		for (mode = 0; mode < 5; mode++) {
+			/* Isolate one-time TLS key initialization for key-failure cases. */
+			pid_t pid = fork();
+			assert(pid >= 0);
+			if (!pid) {
+				pthread_t thread;
+				assert(pthread_create(&thread, NULL, worker,
+						      NULL) == 0);
+				assert(pthread_join(thread, NULL) == 0);
+				assert(created == freed);
+				assert(created == (mode == 0 ? 1U :
+						   mode == 2 ? 2U :
+							       32U));
+				assert(assignments ==
+				       (mode >= 3 ? 0U : created));
+				exit(0);
+			}
+			int status;
+			assert(waitpid(pid, &status, 0) == pid);
+			assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+		}
+	}
+	assert(unlink(path) == 0 && rmdir(dir) == 0);
+	puts("regex-tls: 10 scenarios, 320 lookups passed");
+	return 0;
+}
-- 
2.56.0

