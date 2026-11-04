Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804985;
	b=1DnZY8YDDrT/zYtpTJi5AaMIkcmjl28XvBQ2igwk60T91Dx9JKj2O+5mku5NUodUCCtB
	 d5aUUUgTeKDs8rATZzSu4c6w24jIiSAeWbRnLdWniDzAzRWtvdCiSeiZrjeiLmEm3uTcZ
	 lQvz0ucTZ3+tXak+V8qZ9cDOFOUfdrAAfWr6H/SPgkvb7Shhf1+NHYX/lLl3u0glpoAky
	 ESrkVaz75nLsFuOmNnYxEps32MztcHRJwwLidDMQNpHBIsiPDxNgRQMmzjPTz3Dhq+8p4
	 vEJ17wVg5lEpIWRNzjjbuHTBMM2LWFy6/RwR6KYIp084NRMIMd1aMk59IcHPL1gD3Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TLj88Nlm8BI8it0+YQoZrZq+VGf7CypTyGE73vlHypI=;
	b=JkvgmaZE8VoQz/PwvVloEy6j00CYdwXa+gexR9pl7GoiQN8aZ1bDyAfqVBOHqT/L2+uR
	 +E8AWiJ+8baY50LInIkEBywomXK/x38wbJZDGS4/UIPANK+g1NCYowv5X3T7Fw0kGA7Ht
	 p6ssS2rlp7bAdKc9o7XQr+pAiO5fs6yJRaRH08Jvs86AmkBnNrUVM/kF2vajsG1gmzcuC
	 iHYjAAHHb/GJum3S7ku6uqGygWfT7PUSSDZpTctW/Jp9TseiRR85JOYffSOq/NazhNC6S
	 L1irH46VVhkCwl0qotK3ZdPva/cHRo463NjvoA6f3cE23dq2HkICeaqe0yeR8jnHHRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC51qi5e;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E22606A333
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E22606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC51qi5e
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53bb57f1310so7883541cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804984; x=1794409784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLj88Nlm8BI8it0+YQoZrZq+VGf7CypTyGE73vlHypI=;
        b=GC51qi5eHxRbo4MUDTknxYogMBtbzfS8UQIL+QseEX83WEy3CrcDMYEFJ+jNZdfVZp
         txOjCuh0QlXlUoghiYtxhtuvToWv7wB2sEqmiKPaWKMugiKubbhB2eHhZpLS/q8CvgWV
         oZkw2hadt7ORr1RFcwKSFgmCzh4Jqgtf7EQJUSACEN5jxw93L4vqC3KRucdpU7xdqBD5
         JCPtividqjKCVx4Fic4AMGqyN+jcJAyacXLdHqZcx8IK6qIjiTyO8LR7thbdSFdWNR8q
         YBwCnGEC9lzgChoiHpHyQqBTYF81I/EilOE0YOztdpY7Hr3xJ/hYAa6WEF6hMfbfvkz8
         lfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804984; x=1794409784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLj88Nlm8BI8it0+YQoZrZq+VGf7CypTyGE73vlHypI=;
        b=duFiCdVxMP57czhVFrvw+q0L6freM+BPKXsyQopj1Tv6wLjLFlmUO+ozEZKdzef5nI
         k5bT7hixkx5eugZmDPbvMlbg+QQ7OTPZO63pxyo37BjGnBQcHZDnKQw8zl+3KJGgOmie
         UBG36emUF2z6B6QN3wOSVMRdQWs47vThbSj6854nZ/huu4zAcsOH/AdB52LGqyxfCL1v
         vI7iAgIYhSJ/67v0vkQVeJ5TAMv9ecDzmgKIu1Do46rBPsg7d+z39625VZq8eZL6vktc
         UzftvzJgLihVKBQc2oHZprnvYqYRUdE2jPjzUhJYZYUCQ9D/0HJzbu+Hs1XIrLU7Be3m
         pHGA==
X-Gm-Message-State: APuU4Z98xMEOl4cbi5cNcSSXMkw9ssrHLZxTqhacKkFIxcmNCtOKZF3A
	js2P8nXs5Me72jnmBQJKBKIxm1IlSpx/HV3n2NDRClvg0B39BUpd7JSntvPnNxnW
X-Gm-Gg: AYBFou2srsSi+2+GxfQtwCtw7yeVRWd+qJaVmjrUcnVKiyKtJeBL5VKgiABfD1egCwN
	+yCvKbDpfvkhRFd+Ci7HhZ3NCudUqWJZ6qt2BOHmeBwDa9NstXIR8pVWzKtgZl6tV/twBhInHt1
	JX6PQSS2jg0abdr0z8ftlMvw6nwoa3+E7xj5Zkvrvu8zI3yknz0xy8SdvaB/C05CJoxbWqVOuoI
	/ew8xBU98lbUUC3miQUjcqoTgXaBnkzOxp8thTtgR6HB6uZEw7js5eTImvoEG1J/84DpJ9IFTo5
	n1KGlPC+koyPbMLaeojoBidFagL8Fmq/Sfx4Cca5rW/OYj7msAZFMtJcXwmLC2k/v+9sL0XG37F
	mSkoGppHnTAcThYQeG9q0ZHA6XbPJ5Q6cG2s+2//W05PyExuhz5NHbxzMJJUs3aXWTO8zdkrYMF
	9/e4JIzIOap4Ocf8bJRAjxEiFQCgmgneAZVb4EKP+yMprzjIRFQm3cZsB1/hfxssJ5RXhncTqL6
	T8/iS1agvfIK4laogtzmccEFLoRF7dHPLSD+EMU+2dfkD2HJicBUdXevk0UaMqdNTxbDcag+5Nd
	fmBExD00iwJUuoqXS28b0NgInjO+y1sbLl8aYOsI/2TmbWgWcbtfQJuPLedgIeyHuJmaygycJxk
	QaZMrO7UrZWyo12bdVwNt+f5e8EPLFox8qmrUTN9KLEo7vWQ70lpuLvRzjWTTeXPeznZBtuQ97r
	X0iGSDPbRdk2KtUH4nl9j735fSD/d7/COp5oo257nZqJXSGkR5Cv0=
X-Received: by 2002:a05:622a:550:b0:535:1f7a:e29c with SMTP id d75a77b69052e-542b704627bmr256293611cf.37.1793804983931;
        Wed, 04 Nov 2026 07:09:43 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:43 -0800 (PST)
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
Subject: [PATCH v3 13/20] libselinux: record specification paths for Android backends
Date: Wed,  4 Nov 2026 10:09:08 -0500
Message-ID: <20261104150915.175923-13-stephen.smalley.work@gmail.com>
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

The generalized labeling frontend now uses spec_files[0] when finalizing
a successful lookup, but the Android property and service backends never
initialize spec_files. Matching lookups therefore dereference NULL even
when validation is disabled.

Allocate the one-entry specification list and copy the input path before
parsing, matching the other backends. Existing selabel_close cleanup owns
the list and path, including initialization failures.

Add regression coverage for both backends, raw and translated lookups,
validation and digest options, allocation failure cleanup and retry, and
empty or malformed inputs.

Fixes: 55a33ff38387 ("libselinux: support multiple spec_files")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_backends_android.c   |   8 +
 libselinux/tests/.gitignore               |   2 +
 libselinux/tests/Makefile                 |  13 +-
 libselinux/tests/test_android_specfiles.c | 202 ++++++++++++++++++++++
 4 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/tests/test_android_specfiles.c

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index f1a3050a..3c3f5d3a 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -184,6 +184,14 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (!S_ISREG(sb.st_mode))
 		goto finish;
 
+	rec->spec_files = calloc(1, sizeof(*rec->spec_files));
+	if (!rec->spec_files)
+		goto finish;
+	rec->spec_files[0] = strdup(path);
+	if (!rec->spec_files[0])
+		goto finish;
+	rec->spec_files_len = 1;
+
 	/*
 	 * Two passes of the specification file. First is to get the size.
 	 * After the first pass, the spec array is malloced to the appropriate
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 09604645..ecbbc014 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -11,3 +11,5 @@ test-restorecon-digest
 /test-digest-inputs
 /test-load-policy-version
 /test-auxiliary-duplicates
+/test-android-specfiles
+/*.o
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 1a73a0e6..c73e5c65 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -34,11 +34,13 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-digest-inputs
 	./test-load-policy-version
 	./test-auxiliary-duplicates ../utils/sefcontext_compile
+	./test-android-specfiles
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 	rm -f test-load-policy-version
 	rm -f test-auxiliary-duplicates
+	rm -f test-android-specfiles android-label.o android-backend.o
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -65,3 +67,12 @@ test-load-policy-version: test_load_policy_version.c ../src/libselinux.a ../../l
 
 test-auxiliary-duplicates: test_auxiliary_duplicates.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -ldl -pthread
+
+android-label.o: ../src/label.c ../src/label_internal.h
+	$(CC) $(CPPFLAGS) $(CFLAGS) -D_GNU_SOURCE -UNO_ANDROID_BACKEND -c -o $@ $<
+
+android-backend.o: ../src/label_backends_android.c ../src/label_internal.h
+	$(CC) $(CPPFLAGS) $(CFLAGS) -D_GNU_SOURCE -c -o $@ $<
+
+test-android-specfiles: test_android_specfiles.c android-label.o android-backend.o ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=calloc,--wrap=strdup,--wrap=free,--wrap=fclose $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_android_specfiles.c b/libselinux/tests/test_android_specfiles.c
new file mode 100644
index 00000000..66586350
--- /dev/null
+++ b/libselinux/tests/test_android_specfiles.c
@@ -0,0 +1,202 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include "label_internal.h"
+
+static char path[256];
+static unsigned fail, hits, closes, cases;
+static int tracking;
+static void *list, *name;
+
+void *__wrap_calloc(size_t n, size_t size);
+char *__wrap_strdup(const char *s);
+void __wrap_free(void *p);
+int __wrap_fclose(FILE *fp);
+
+void *__real_calloc(size_t, size_t);
+void *__wrap_calloc(size_t n, size_t size)
+{
+	if (tracking && n == 1 && size == sizeof(char *)) {
+		if (fail == 1) {
+			hits++;
+			errno = ENOMEM;
+			return NULL;
+		}
+		assert(!list);
+		list = __real_calloc(n, size);
+		return list;
+	}
+	return __real_calloc(n, size);
+}
+
+char *__real_strdup(const char *);
+char *__wrap_strdup(const char *s)
+{
+	if (tracking && !strcmp(s, path)) {
+		if (fail == 2) {
+			hits++;
+			errno = ENOMEM;
+			return NULL;
+		}
+		/* Digest bookkeeping also duplicates the path. Track the first. */
+		char *p = __real_strdup(s);
+		if (!name)
+			name = p;
+		return p;
+	}
+	return __real_strdup(s);
+}
+
+void __real_free(void *);
+void __wrap_free(void *p)
+{
+	if (p == list)
+		list = NULL;
+	if (p == name)
+		name = NULL;
+	__real_free(p);
+}
+
+int __real_fclose(FILE *);
+int __wrap_fclose(FILE *fp)
+{
+	if (tracking)
+		closes++;
+	return __real_fclose(fp);
+}
+
+static int validate(char **context)
+{
+	assert(context && *context);
+	return 0;
+}
+
+static void put(const char *text)
+{
+	FILE *fp = fopen(path, "we");
+	assert(fp);
+	assert(fputs(text, fp) >= 0 && fclose(fp) == 0);
+}
+
+static struct selabel_handle *open_handle(unsigned backend, unsigned digest,
+					  unsigned validating)
+{
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, path },
+		{ SELABEL_OPT_DIGEST, digest ? "1" : NULL },
+		{ SELABEL_OPT_VALIDATE, validating ? "1" : NULL },
+	};
+	assert(!list && !name);
+	closes = hits = 0;
+	tracking = 1;
+	struct selabel_handle *h = selabel_open(backend, opts, 3);
+	tracking = 0;
+	assert(closes == 1);
+	return h;
+}
+
+static void check_handle(struct selabel_handle *h)
+{
+	assert(h && list && name);
+	assert(h->spec_files == list && h->spec_files_len == 1);
+	assert(h->spec_files[0] == name && !strcmp(h->spec_files[0], path));
+}
+
+static void close_handle(struct selabel_handle *h)
+{
+	selabel_close(h);
+	assert(!list && !name);
+}
+
+int main(void)
+{
+	char dir[] = "/tmp/selinux-android-specfiles-XXXXXX";
+	assert(mkdtemp(dir));
+	snprintf(path, sizeof(path), "%s/contexts", dir);
+	union selinux_callback cb = { .func_validate = validate };
+	selinux_set_callback(SELINUX_CB_VALIDATE, cb);
+	for (unsigned backend = SELABEL_CTX_ANDROID_PROP;
+	     backend <= SELABEL_CTX_ANDROID_SERVICE; backend++) {
+		for (unsigned digest = 0; digest < 2; digest++) {
+			for (unsigned validating = 0; validating < 2;
+			     validating++) {
+				for (unsigned match = 0; match < 3; match++) {
+					put(match == 1 ?
+						    "* system_u:object_r:test_t:s0\n" :
+						    "test.key system_u:object_r:test_t:s0\n");
+					struct selabel_handle *h = open_handle(
+						backend, digest, validating);
+					check_handle(h);
+					for (unsigned raw = 0; raw < 2; raw++) {
+						char *context = NULL;
+						const char *key =
+							match == 0 ?
+								"test.key" :
+								"missing";
+						int rc =
+							raw ? selabel_lookup_raw(
+								      h,
+								      &context,
+								      key, 0) :
+							      selabel_lookup(
+								      h,
+								      &context,
+								      key, 0);
+						if (match == 2)
+							assert(rc == -1 &&
+							       errno ==
+								       ENOENT &&
+							       !context);
+						else
+							assert(rc == 0 &&
+							       !strcmp(context,
+								       "system_u:object_r:test_t:s0"));
+						freecon(context);
+						cases++;
+					}
+					if (digest) {
+						unsigned char *hash;
+						char **files;
+						size_t length, count;
+						assert(selabel_digest(
+							       h, &hash,
+							       &length, &files,
+							       &count) == 0);
+						assert(hash && length == 20 &&
+						       count == 1 &&
+						       !strcmp(files[0], path));
+					}
+					close_handle(h);
+				}
+				for (fail = 1; fail <= 2; fail++) {
+					struct selabel_handle *h = open_handle(
+						backend, digest, validating);
+					assert(!h && errno == ENOMEM &&
+					       hits == 1 && !list && !name);
+					cases++;
+				}
+				fail = 0;
+				struct selabel_handle *h = open_handle(
+					backend, digest, validating);
+				check_handle(h);
+				close_handle(h);
+				cases++;
+			}
+		}
+		put("");
+		struct selabel_handle *h = open_handle(backend, 0, 0);
+		check_handle(h);
+		close_handle(h);
+		cases++;
+		put("invalid-line\n");
+		h = open_handle(backend, 0, 0);
+		assert(!h && !list && !name);
+		cases++;
+	}
+	assert(unlink(path) == 0 && rmdir(dir) == 0);
+	printf("android-specfiles: %u cases passed\n", cases);
+	return 0;
+}
-- 
2.56.0

