Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388015;
	b=qQkBHuESWgh0Vix5ft95XCMePGBQVEuMS2jFKag20IgRepRCBJ6ODOA8Ftt8YMQtOknW
	 X+/043K9j1ClY/geBoFad6frUXPpA8IrHd+s3D3N4s2dCqq35fvYuYxpw/GD7HoVPLwAs
	 DKVEGq0gudsKGbfpEBhdii9Hq2Gm3L832XYoPDu2FpXkdXKPMBXFhVfAyOEds4t1gt6Uj
	 XrwoqbgUMLv9XuzpMQ+Cuh+eMJiaJRQAeeylYcih4bFGGwWWwvI1+v5OEADCu/nkHc/Pe
	 DSZMR5e3wU8VWQ5b8+pS0a7arVREGfkvN1GgfYBHFEvjcHpGr7NIE0Qb7zNr+GC+Ssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
	b=MzWgsxHy+J58BPYSTBdk2Ye6XgO3QIS9TVcT63eSzvNATH/7iXcjvCy61QE+OWkO5p7A
	 zXJlbIBejkPnbdUPkAUhCtxBVoUKoyAb7ON9ErqdiE8yAedTbDfyPbOaZyoYl/xoKo0CF
	 JbQEDrWgajH/7V+4pA+PIKrAg3sHiMNqkdku8W1+SMbYE+nqDolF/qGOEU0eOFbIZ12KV
	 /8lku3aScmkmYUOG1vS0sYWuVpNvanpqZaMMRrIPPkG531IuG9aq9I5T5S2PTxPsNGkbX
	 c824DMttKm1x7X9dMY28S0GfuIQ1uZw5F/wsWip2IkQA+lUdA8F+VS5zUr14jtWMhKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxP9zqX3;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C2606A320
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B6C2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxP9zqX3
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b52ba422cso14317716d6.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388014; x=1793992814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
        b=uxP9zqX3/4VPciqtQyN9NpSrpaCSnBAw0bURZr3f8z6OxO7fQTN9Meve3sVAUu+Z4m
         59+yPuMH/ahWB+Nn9ZmNE4IKcrLcWE4ugcHGyC1+974mhWf3zl5XfzWyrl5fMiEGrqNZ
         T3Ht8dAyW+1RFuyHHEz3wXqzjLkb/0KjZTZBkhkK4pcbIZfD6RBltAMA5ejnVSF/mvCL
         n0Az3aEh/qYjCvbaZkIK8b8+ZwgYM6FBhvNJ+g8kwWdAyVEGeseSLaYAKbc0WBsR0L8X
         9x8iYVxLHxbtsINztybXRfJIPWLxbwfi/EYlNQvhYzaqXq/EQk0HzYk1qrSSBaAer14d
         dzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388014; x=1793992814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Kh7EROY6Wfo0D99EBHPttmmYElwrFmbzMk20M5wHc0=;
        b=xpBo8WOvfnkzBIhc53qmOhYUpOTkNPc6kD522QZN6FAvDQtyFktwmZ1TQW4PS47Duh
         tkFuuluB9MtcgQwbEEWSJbn/9zR2COsoQZ0zBYFvwYAjFUf8xNQbi1nP23fwxllMWTnG
         zBC6GSP2/oz3rMEtUfl7Wb03R7UyhzO5+YMzVCQzcALnFQe0AkWZLv8IT8sLCxoYk/Ld
         NS2i/qTV9vd3yy1w+zH7mIJBRhMKTjlC0YPRtPw1PFLbXP7j+J4pyp0dCuCwNbgCUND0
         ARVyvs7FUc8kCQi5l68cqvhKNcksZH2W8xvGmXkT8KwVMg2F93LLgFOTaT1x9oNlyfRV
         5onw==
X-Gm-Message-State: AFq9FYKhrjh8ehvl583kSrOY8VEsyFdPWEDbTg43Lb7T8vClWdl8OdhU
	SL1Wm2Jta6wIeTTVrQpoYxEyEXK8DePVqaoeXEacnpaS2e8CtOTcJiPEMbFeqvKb
X-Gm-Gg: AYBFou1UzDaE127u4aDkH6CB/78VqekBej/5nFKaiRABTu9o1Mrsulynlj/ByKN3BgA
	sFV6EfsPu1NAcY5je84hrdWMYf+U0E1b7xKk9yw1+kTbpn2E62dudDSn19nuaH6hASGxprdNM1/
	1s5aPd3O1KCqj9d5e/1goc+TgUN7Ge0t/XCNmBKz4vEMXEKBNciwdcPpLhjVWZzkPaYwXUBOEgf
	SArsedf8JkevMX/T7F1zTH0jHfzywAYJKAvy3X+zwIKmbm1Mp2fuPbvcyHYzj2IinFAgX5CRSLY
	Mb67vLENRPsuF0aNvgx1+IuRDnRlu7VsHuaCRVZ6GQeb55MB1ERqTeyv6qlC7LKivZ8mrtE0C5m
	1k9amxG73Nznb8qqOmEPmtu1MwV3yQVPTPv1441YHdEmCvIyzhFAVioY4h8JBcI78+kZORDyfDc
	VWhbV0XQKcyEyZeitcK2Gn/kckefKtbFOxYZzCUxAmRrJOID0h6Qb6GPYO8cwIxWX3Z+5AitZ3o
	Rc8rBXNgDJmqe1kB2F6PkDI7z+AfkwCyYSpC9Gkr1WgTkaXDi8QRfVJvhyO5m9mCPutofVHy15I
	5aqYi5g2dtd07Zk4Zxv7rwsItpFJqo9ZEpIw6uyS5OFlNIvpkLQXRGrsV+OlWJ2t+B3DKcecH+t
	EHwb9bFbd7z8ya3QMSOyp170khZ4QWHQm2gqHKGsmtLCAWOVyURAMTjkHmT5JM2O2f8cj4mPzuf
	RtAR/AtfU/kIfZtpqcZRBq97LkrawMM+8GlptBKmZ2+g5WMyJgfcI=
X-Received: by 2002:a05:6214:c49:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91ca4b7aa24mr51954796d6.28.1793388013492;
        Fri, 30 Oct 2026 12:20:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:13 -0700 (PDT)
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
Subject: [PATCH 10/10] libselinux: grow the digest specification file list dynamically
Date: Fri, 30 Oct 2026 15:19:24 -0400
Message-ID: <20261030191924.150495-10-stephen.smalley.work@gmail.com>
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

