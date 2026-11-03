Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732013;
	b=Fh0JDRxIfIlAj+rj0JiL7L3chcL1SgoFHTHe5gdGhBbIOmq011ztUUj+jK3Ra62P66TU
	 0xP5kuN78RKhpA5Y34t9Z3tnZVDoCnJhaDx9wSgm4Zy0Oay5ql+hHft5umwYT0dMPppmu
	 TU6kGSuTwon+iu8ps6prGNVnsMjyxeEPkXgAybomlHMU7WJaWUCLVF1XCZL8GfKLUXHIs
	 UGCg5vgq0vPOIDukvn+DDynmImqHftBcqp55MWRwBU4i38Xl66kyrsNdCXgeobabXixH5
	 ZN/GnoVN2WD0aBFauDuPOXUBQcvmm/gljYEsTUUhecw6iC5gvlzO9wk82DlwKEjZOBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
	b=GFxkfEY9N4/4r9IVO/u4WRBuFBGxpWxFNNLzQAu4ciDXjicsj+dMKAWXDpvhX8MvQfEf
	 m2ly9LMsWQ/3LnVAMqz/+xfJu5aAYKGf78Qic2t4XrkKX9fPa5AxQxZ171+EGXNbWdxX7
	 5RYBSUmU1g2OeuRlyht0GVC7UBKh6i3t8WB4WcBzSK78X9qTT8GfDTfp7g4/rrPRMsATK
	 cW/9VzUVqq8eTgYP0TlhlUB/+Vmvgtrh1wUPDB/rQYsDvSwAvJxTyZJUp+F2wSosTT8sd
	 K88+nn3kRf+2MHeXPllt+9YgWii2G5WPpqxHE5Qsb0HIW33a6EU9IxBYvbGoeKjbp3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zOu5o12Q;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C2606A328
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8C2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zOu5o12Q
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b9e758c50so13098336d6.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732012; x=1794336812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
        b=zOu5o12QOKMy+bhTtNx7x2wdlQ1NQpyFMNZeyN/TA/44745hJw64ZEtdTv7Z4lA9it
         ORg2z6zB/+uErXpvYarVGrQk0MEdGyg6Pdk8Mn2SvkgQuTXmxGt0BzV14+nlN1r+54sC
         XXJpUpJqdVVgqunLt3KDRsKrGbrbSbeaA96qQbl7lXt6WknTHbM4NYy+qFVSwh9WxgJc
         oWUr6WqVfxXPRpjMqzrne4q7hGSHqq1c90qfBE6eVaLMSKLtAdG4Bb+0ntWULxHzmbsJ
         XKhNWgKbh7vCalDwIgMf7eA+PK4b6qodrWdHKn0CKW3oRBUN59YGUEA7cTjenJii/Shi
         jrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732012; x=1794336812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
        b=Mk3Up4stKwV65QOf4V+H7hTUKOQgaf19RjXmWBLzUwTLiPwlByWmJrTTunYiJ8wrJV
         g6xzWBnmZ7VYV5ZhrWKXZJxGbz1JGqDmA4Q4YuxkAfEfXwX5PJOhaxe5cFB+PEzpVuR6
         fLaYNjAETtklqiVfOXUuFh184PnfheztG/CrS1u9vTFsob1q+7sKamPbdbXaO5HEvflL
         u/XHuA929m3/Tqd5k6kA0vsN1P7sSrvTepHY1knUaASGAPLrQMfN1sGlKwctNnvWxNAd
         EJ0N9+EgcnddS8NFcNf5Z3+sz8/TIqmcFFRPkmhQJSIQICVof1FdvsT4hbu1eIdhEXdg
         uMaA==
X-Gm-Message-State: APuU4Z/qfasDx6CS8uriw+JiWiXco3c81hWd4UltNTy5cO/fcGeaiUI8
	CWAu5bNA36pVMSlou0V0CN+Fr6zQs49BfVkHqRRzv4McSxeSFIVvYE6wCfp75WTl
X-Gm-Gg: AYBFou0kAWlMqF+hBcBxkR86Bao0V5xcgNqIgb0bnaZjNH7Kdgmlg6hy/SuW+W9Em14
	ivz87l72iaRFB3n+CSpgQNXt/sD6KqYYhyiPOZ3MKdyl7y7pQY4NhObkcEnGnuVs9LdPFDr4HGS
	tF4jycmghCXCQ2BbEBCEhKT+dleDmz+kQum3SGYaZNm4OTIJQy+I9cfCKmMhxZaFIWOCRvcxuBe
	s8g1hdqwiUaiLQiCGZUTFFlV9LAyYhhAKQ842MUC3BI4f8YJPkREjEuRK4d2H1zk726QM2rmjdN
	dNQfmQ/f6Cl5uxwIAIPYZuubgtpnqdI9JCy8LXLiljFf5AfAui/bKlWJ2Ken33iEe0qRg9c36kk
	1j8R3oIj24JxBX6r46aNnQfEKfIpd9m49fARcuHNJ3ofssL5C8e8kfmmb0XZkeHb1zl7Ol8aQ8f
	YYPNQRcKofqg+OeHpm+JBtBbYYa5GjS/jeWGtk9pcfKhjpgdK92nra/CcSi31CJnRt6Oh6Vzn4q
	DKpLWunzmFPyHXDDPqL8mfuOyjRMerzIMZR6+D+Zj4bF+7txcz4rgJeqZP9KX/21j8VnFxWDyTi
	aND5uDEJErergmacrpSqHwW3gzkqYdR7bNogyVWGA+8VbMu6/AAeKromoLteW7wFjsPpdb1NPNY
	/bvNLczquI8xsS+qYQfqyDEOt2x8vLiqSqdtdfh1XxwI5Cn3LBSHWJZGZz3ySmwmtLAUtxaikmt
	ium5g0kly5dJaEIzaHRCqSbbHh4GW5YWuspm9yq/O92NAWPxqRdNA=
X-Received: by 2002:a05:6214:252b:b0:917:a1d0:890c with SMTP id 6a1803df08f44-91c906bab4bmr270472206d6.17.1793732011523;
        Tue, 03 Nov 2026 10:53:31 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:31 -0800 (PST)
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
Subject: [PATCH v2 10/20] libselinux: grow the digest specification file list dynamically
Date: Tue,  3 Nov 2026 13:52:57 -0500
Message-ID: <20261103185307.45924-10-stephen.smalley.work@gmail.com>
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

Multiple SELABEL_OPT_PATH inputs can exceed the old eight-file digest
limit. Nine primary files, or five with all four auxiliary inputs, fail
with EOVERFLOW solely because digest collection is enabled.

Grow the list with checked capacity arithmetic and preserve its NULL
sentinel. Publish the input count and hash-buffer length only after an
addition succeeds, so allocation or read failure permits cleanup or retry.
Avoid realloc(ptr, 0) for empty inputs.

Add 20 regression scenarios covering up to 253 primary files plus four
auxiliaries, growth allocation failures, retries and empty inputs.

Fixes: 1550c8aaf255 ("libselinux: support multiple context files for the file backend")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label.c                |   5 +-
 libselinux/src/label_internal.h       |   3 +-
 libselinux/src/label_support.c        |  63 ++++++++----
 libselinux/tests/.gitignore           |   3 +-
 libselinux/tests/Makefile             |  10 +-
 libselinux/tests/test_digest_inputs.c | 134 ++++++++++++++++++++++++++
 6 files changed, 192 insertions(+), 26 deletions(-)
 create mode 100644 libselinux/tests/test_digest_inputs.c

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 93848bfe..89ba00be 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -75,10 +75,11 @@ selabel_is_digest_set(const struct selinux_opt *opts, unsigned n)
 			if (!digest->digest)
 				goto err;
 
-			digest->specfile_list =
-				calloc(DIGEST_FILES_MAX + 1, sizeof(char *));
+			digest->specfile_list = calloc(DIGEST_FILES_INITIAL + 1,
+						       sizeof(char *));
 			if (!digest->specfile_list)
 				goto err;
+			digest->specfile_capacity = DIGEST_FILES_INITIAL;
 
 			return digest;
 		}
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 47c5d3cb..3a3301e8 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -48,12 +48,13 @@ int selabel_service_init(struct selabel_handle *rec,
  * used. This is released once the value has been calculated.
  */
 #define DIGEST_SPECFILE_SIZE SHA1_HASH_SIZE
-#define DIGEST_FILES_MAX 8
+#define DIGEST_FILES_INITIAL 8
 struct selabel_digest {
 	unsigned char *digest; /* SHA1 digest of specfiles */
 	unsigned char *hashbuf; /* buffer to hold specfiles */
 	size_t hashbuf_size; /* buffer size */
 	size_t specfile_cnt; /* how many specfiles processed */
+	size_t specfile_capacity; /* allocated entries, excluding the sentinel */
 	char **specfile_list; /* and their names */
 };
 
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 5112c59c..c712afcc 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -256,6 +256,8 @@ int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 			const char *from_addr, size_t buf_len, const char *path)
 {
 	unsigned char *tmp_buf;
+	char *name;
+	size_t new_size;
 
 	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
@@ -265,35 +267,58 @@ int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 		errno = EOVERFLOW;
 		return -1;
 	}
-	digest->hashbuf_size += buf_len;
+	new_size = digest->hashbuf_size + buf_len;
+	if (digest->specfile_cnt == digest->specfile_capacity) {
+		size_t capacity;
+		char **files;
+
+		if (digest->specfile_capacity >
+		    (SIZE_MAX / sizeof(*files) - 1) / 2) {
+			errno = EOVERFLOW;
+			return -1;
+		}
+		capacity = digest->specfile_capacity ?
+				   digest->specfile_capacity * 2 :
+				   DIGEST_FILES_INITIAL;
+		files = realloc(digest->specfile_list,
+				(capacity + 1) * sizeof(*files));
+		if (!files)
+			return -1;
+		files[digest->specfile_cnt] = NULL;
+		digest->specfile_list = files;
+		digest->specfile_capacity = capacity;
+	}
+	name = strdup(path);
+	if (!name)
+		return -1;
 
-	tmp_buf = realloc(digest->hashbuf, digest->hashbuf_size);
-	if (!tmp_buf)
+	/* Avoid realloc(ptr, 0), which can free ptr while returning NULL. */
+	tmp_buf = realloc(digest->hashbuf, new_size ? new_size : 1);
+	if (!tmp_buf) {
+		free(name);
 		return -1;
+	}
 
 	digest->hashbuf = tmp_buf;
 
 	if (fp) {
 		if (fseek(fp, 0L, SEEK_SET) == -1)
-			return -1;
+			goto err;
 
-		if (fread(digest->hashbuf + (digest->hashbuf_size - buf_len), 1,
-			  buf_len, fp) != buf_len)
-			return -1;
+		if (fread(digest->hashbuf + digest->hashbuf_size, 1, buf_len,
+			  fp) != buf_len)
+			goto err;
 
 	} else if (from_addr)
-		memcpy(digest->hashbuf + (digest->hashbuf_size - buf_len),
-		       from_addr, buf_len);
-
-	/* Now add path to list */
-	if (digest->specfile_cnt >= DIGEST_FILES_MAX) {
-		errno = EOVERFLOW;
-		return -1;
-	}
-	digest->specfile_list[digest->specfile_cnt] = strdup(path);
-	if (!digest->specfile_list[digest->specfile_cnt])
-		return -1;
+		memcpy(digest->hashbuf + digest->hashbuf_size, from_addr,
+		       buf_len);
 
-	digest->specfile_cnt++;
+	/* Publish together so a failed addition can be retried or cleaned up. */
+	digest->hashbuf_size = new_size;
+	digest->specfile_list[digest->specfile_cnt++] = name;
+	digest->specfile_list[digest->specfile_cnt] = NULL;
 	return 0;
+err:
+	free(name);
+	return -1;
 }
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 1cf58a45..51d18f6d 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -7,4 +7,5 @@ test-restorecon-digest
 /test-label-merge
 /test-substitution-hash
 /test-substitution-restorecon
-/test-readable-fallback
\ No newline at end of file
+/test-readable-fallback
+/test-digest-inputs
\ No newline at end of file
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 1f010c4f..cdc395b7 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,6 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
-override CFLAGS += -I../include -pthread
+override CFLAGS += -I../include -I../src -pthread
 INIT_OOM_WRAPS = asprintf __asprintf_chk strdup calloc free
 XDEV_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64 fstat fstat64
 EXCLUDE_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -31,9 +31,10 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-substitution-hash
 	./test-substitution-restorecon
 	LD_LIBRARY_PATH=../src ./test-readable-fallback ../utils/sefcontext_compile
+	./test-digest-inputs
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -51,3 +52,6 @@ test-substitution-restorecon: test_substitution_restorecon.c ../src/libselinux.a
 
 test-readable-fallback: test_readable_fallback.c ../src/selinux_config.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ test_readable_fallback.c ../src/libselinux.a $(PCRE_LDLIBS) -pthread
+
+test-digest-inputs: test_digest_inputs.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=realloc,--wrap=strdup $(PCRE_LDLIBS) -pthread
diff --git a/libselinux/tests/test_digest_inputs.c b/libselinux/tests/test_digest_inputs.c
new file mode 100644
index 00000000..ba0fcef5
--- /dev/null
+++ b/libselinux/tests/test_digest_inputs.c
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "label_internal.h"
+
+static int fail_at, allocations;
+void *__real_realloc(void *, size_t);
+char *__real_strdup(const char *);
+void *__wrap_realloc(void *p, size_t n);
+char *__wrap_strdup(const char *p);
+
+static bool fail(void)
+{
+	if (fail_at && ++allocations == fail_at) {
+		errno = ENOMEM;
+		return true;
+	}
+	return false;
+}
+void *__wrap_realloc(void *p, size_t n)
+{
+	return fail() ? NULL : __real_realloc(p, n);
+}
+char *__wrap_strdup(const char *p)
+{
+	return fail() ? NULL : __real_strdup(p);
+}
+
+static void destroy(struct selabel_digest *d)
+{
+	for (size_t i = 0; i < d->specfile_cnt; i++)
+		free(d->specfile_list[i]);
+	free(d->specfile_list);
+	free(d->hashbuf);
+}
+
+int main(void)
+{
+	unsigned cases = 0;
+	for (int failure = 1; failure <= 3; failure++) {
+		struct selabel_digest d = { 0 };
+		for (unsigned i = 0; i < 8; i++)
+			assert(digest_add_specfile(&d, NULL, "a", 1, "first") ==
+			       0);
+		fail_at = failure;
+		allocations = 0;
+		assert(digest_add_specfile(&d, NULL, "b", 1, "next") == -1);
+		assert(errno == ENOMEM && d.specfile_cnt == 8 &&
+		       d.hashbuf_size == 8);
+		assert(d.specfile_list[8] == NULL &&
+		       !memcmp(d.hashbuf, "aaaaaaaa", 8));
+		fail_at = 0;
+		assert(digest_add_specfile(&d, NULL, "b", 1, "next") == 0);
+		assert(d.specfile_cnt == 9 && d.hashbuf_size == 9 &&
+		       d.specfile_list[9] == NULL);
+		destroy(&d);
+		cases++;
+	}
+	struct selabel_digest d = { 0 };
+	assert(digest_add_specfile(&d, NULL, "", 0, "empty") == 0);
+	FILE *fp = tmpfile();
+	assert(fp);
+	assert(digest_add_specfile(&d, fp, NULL, 1, "short") == -1);
+	assert(d.specfile_cnt == 1 && d.hashbuf_size == 0 &&
+	       d.specfile_list[1] == NULL);
+	assert(fclose(fp) == 0);
+	assert(digest_add_specfile(&d, NULL, "x", 1, "retry") == 0);
+	destroy(&d);
+	cases++;
+
+	const unsigned counts[] = { 1, 4, 5, 8, 9, 16, 32, 253 };
+	for (unsigned extras = 0; extras < 2; extras++) {
+		char path[] = "/tmp/selabel-many-XXXXXX", aux[128];
+		int fd = mkstemp(path);
+		assert(fd >= 0);
+		fp = fdopen(fd, "w");
+		assert(fp &&
+		       fputs("/probe system_u:object_r:test_t:s0\n", fp) >= 0);
+		assert(fclose(fp) == 0);
+		const char *suffixes[] = { ".subs", ".subs_dist", ".homedirs",
+					   ".local" };
+		if (extras) {
+			for (unsigned i = 0; i < 4; i++) {
+				snprintf(aux, sizeof(aux), "%s%s", path,
+					 suffixes[i]);
+				fp = fopen(aux, "w");
+				assert(fp);
+				assert(fputs(i < 2 ? "/other /elsewhere\n" :
+						     "/extra system_u:object_r:extra_t:s0\n",
+					     fp) >= 0);
+				assert(fclose(fp) == 0);
+			}
+		}
+		for (unsigned c = 0; c < sizeof(counts) / sizeof(counts[0]);
+		     c++) {
+			struct selinux_opt opts[254];
+			unsigned n = counts[c];
+			for (unsigned i = 0; i < n; i++)
+				opts[i] =
+					(struct selinux_opt){ SELABEL_OPT_PATH,
+							      path };
+			opts[n] =
+				(struct selinux_opt){ SELABEL_OPT_DIGEST, "1" };
+			struct selabel_handle *h =
+				selabel_open(SELABEL_CTX_FILE, opts, n + 1);
+			assert(h);
+			unsigned char *hash;
+			char **files, *context = NULL;
+			size_t len, num;
+			assert(selabel_digest(h, &hash, &len, &files, &num) ==
+			       0);
+			assert(len == 20 && num == n + 4 * extras &&
+			       files[num] == NULL);
+			assert(selabel_lookup_raw(h, &context, "/probe", 0) ==
+			       0);
+			freecon(context);
+			selabel_close(h);
+			cases++;
+		}
+		for (unsigned i = 0; extras && i < 4; i++) {
+			snprintf(aux, sizeof(aux), "%s%s", path, suffixes[i]);
+			assert(unlink(aux) == 0);
+		}
+		assert(unlink(path) == 0);
+	}
+	printf("Dynamic digest inputs: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

