Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732019;
	b=5lCpYKBFAcKqWJ531z/jca1Ofz5woNUd7teYRTX22p9hIUWk8I8eGaXNoAK6cojnYanh
	 6xJd+EcVEU+ZzroEA/LAQ9zsWHdUgKvXPeUgxEMS/K1tsR6cCjG2jNSXxJBf0nAHq1Umq
	 RsVv6E9xxpoboUFwo75fcVntyu5e18J1KQhVPn6658UIOPJAjW2YvpfE5oKiJW/kx1RVK
	 75fzyKPCSRdN7V3PrG8q8E96bR3ni8d4T6gmKrRECQ6oYBlyNT/yKhurH03+3ePepGGlq
	 3xZV0XBtopGdvFkEXmUMGsXGPDCIO00juEgH5z4/k0Dc73UQWw+PD1QQfsxgxkunJYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
	b=0z6QLE9A/YWTevjJjTFE7k8KNuc3CXOkxUndHq0AuYZmdx6A3e9gMVM2FnHV4Cr/Ob2p
	 0nw31B2bF+qeihVFsuTJk5nvTE/GD54BGXfBvlRZC9fG+vcOuhHkMQvbEtkSPjTOmdsXx
	 Yt+f/Bn1eHg9DndxSDzKoMIZV7ziDWTJA/cuGmRerIacZwEZVnSEvK1guWU7WxOAoxeke
	 bM/s1DCIXeSQ16ORF9eNdpIzN32cxvCjTDH7uhSRa26SCx7yNSzqn1NUkh4pFzKbwncqv
	 AtxtW0CSXa5aoZWD4w2gmqKg29ktAYWbU13JfbxK2hHSUglZfFfJ4QTW0GbX9oemtMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkeZEwXW;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16618606A328
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16618606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WkeZEwXW
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c19fc50abso55199636d6.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732018; x=1794336818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
        b=WkeZEwXWTm7TIrwTA55ZC+ENPuu9313qB2WWn8YiIPmBm/SjAgqZtdVXxd8BGadOSk
         cUsb/febxhzC8efonaDhrmKgKLGQROlax4KshWm4I7t9VmNVt77LDhp/K8hMgNGngvNZ
         IPan+5pOYFnMg0SG9Hdl++lyGJsWH6iaiFt/2z0gYhlOZughTarKS5KcS8dkvjYNvOBf
         W4HwSqYCmUThdrSGkObyZ9zR9Ez4hex5BKx2MNx1nBJfRjHFUwbM5anDxTs5QKSmVNwe
         AYVe3TUdyqMYD1ReYOT4Ah0KPmqu4ortzXDwzf6xYvfPVWJhK9CzFhtIDdVRYZXPMCT/
         qPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732018; x=1794336818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPjFR1xctPZ5vNaEvk32ZMKFBK8PlsexaCbbbzd5h+s=;
        b=PZ+Wfl5g+aKFZApk96nTxtDc9FD5qAJJ1K89vd9JaU446Stw5q/sSJz6DGCr3gWmFs
         FrenFO19ZVzukkzkEmus1+zA1DQWcx3gxmBVGYZscgLeQDZOVoDsETtOl3STdTaajORf
         VJ7wBero+edr9jFG18R6fgrMyNseABkqaqtjsl87ZxAfxQC/R9g4u0EWg+odOf/d3PTz
         tUuE8L4jtLbYH1o8NpSGBKeZfjj14DBdj6w2l8rl3NWJTO763EoBOqCMjgpnrDTka9NS
         xA9qi7mHjoPHWeLdsLms7nvHJKEBvZmgRvyx9oZnuB71uL6JoAVeTUY9dL88Nk9rgHo7
         uKKg==
X-Gm-Message-State: APuU4Z+jzjeu0NlgXyIsaJ7hP09Yft8S+63pmajz8+ush4jcqGNNTyWJ
	xeeGh6FywoZvh1N9DD6aWKie//nRDXqF6Uw6tdnrZWN8C0EoMzURo6wNu7zbZFY7
X-Gm-Gg: AYBFou3NFwwGvaXxrnBUOxmeZ4bDhenAIn6eymwUp1Ka7sXb7IcQ8wU9xp9kvF0jPiq
	hjR6jxVCDw0WI+TMo4cfkSFRV6oerv+uagQyInjLlu5iFPpBqRpuY2+nnYFD5GXvKdr98/5Ss0u
	dm5RF3M4EjMJrhJDegd0OoQetb/x9uuoBgEF7HZcze6CSSRd0cbA98364hAH6+Qnt3eR4c+zX6i
	jonYEeUkKmh9R8uJXUH12wp4nHcOYlY3QvqnYiodF02KGKLprZkYMmwRnbUeoWnV/cHVzb+SVQc
	LaM9xiN8NaqaW3k+Fc/X1jBF+4QdENw3+ooNzgN3JIfJSdoyLvM6Ur1zH5syWKifD91y5bmT31/
	MRhas/muH8bxc0SYYy1yYKERyIOL6rYsMC/JGnayBKtgC8TBul4xz7IjTtuXj76tb9DXy1zjLZY
	DMiNUZ1DDCx/ZYDPOLqj7CshRUlJVAITEAA2P/pIuQYNChNeLhff2VhM+SrUwoVGKWLsczHEzC9
	PjAKrNGHuoEbqwaJ2klGIkJpDnckjftpv50K8D/XB80mm7tQVdLMCf8BZd0kVZRnq/Dtn5SsQwS
	2RjtZv6Y+14UO7IrLFB+bfImhjjXKxSD57bb9MzdWA8gia380Hhg2RwjdsTZkmkWmg23CGHvasS
	9vg/5zxufVMbPQgE73NwpeG0OP74zlJXCn56NydtqzCL/CY/8Qmf9knZ6qtRssTLpskv2+pJr0D
	8NBXORZavXrWKeI/Kw9Wt2hODWO5SI43USkdqh4lClpYu3vsMWSDo=
X-Received: by 2002:a05:6214:3288:b0:91c:62c0:9875 with SMTP id 6a1803df08f44-91ca4ad5236mr220295936d6.19.1793732017749;
        Tue, 03 Nov 2026 10:53:37 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:37 -0800 (PST)
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
Subject: [PATCH v2 20/20] libselinux: free shared regex contexts on library unload
Date: Tue,  3 Nov 2026 13:53:07 -0500
Message-ID: <20261103185307.45924-20-stephen.smalley.work@gmail.com>
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

