Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804990;
	b=Cx5YYZHOa0H13EqDi0LsbLTbUuDdc0JvjjH2QKFczPqRL4lf0tVmfNtb20bqJp6/AqjQ
	 uzjDnsm3yq7X+KgOvTqiPWrOqe/B+C4zzTU3w70ac5+88VuInAOrCYZlttHFzRN+/LfCM
	 AUnMYi3NDuM/1RjXK1W9AGee3N+iulS6gFZw9kEDs36YT5Ls4tWhHc0XOcld5txpcIMZi
	 i4/N9fIGFMI+aDewY5T5TT5fk2YWTzJ8dKS7P4gMoFihXNuMFhUqd79M8Ulv34YTm1fsZ
	 y+bivRbNzL+oaWV80xUoKD2riB1hnKw3yEbSEgOmOR+aylwgebpKA3Hrtuv55O9p6sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bj1NuMbANr/Z5gFJ9wJQ+PrgwIzmpwkHAXMC2xHxs2w=;
	b=hqJ97Iek4GEefPAiUVH5HwEwAugcJL1NLrHXi8ZgCNfkE1FVtUCC1acH8cE6jj1uBAbG
	 vnrS3oTpn4/I0VIv6zc9gsxtUPkfB5DDq/ef9Z7iKaCMlpUdzSldA/c5qoactZZG3Z0FZ
	 K4rb9GyiClzqFiboU6t1jOsSwBWgePhw1Tc5A+3Lw6tuqwFWF81seSi2W1ueasQJGD+cW
	 KrbF0NxLhe746mQyJOafcNvEn8sEClMKkEiFdTWfpb7GD1T+2dWft0P1N4G49N/pI65et
	 YV/FEsZJm1J99NBCxGsgAdc4DnboRxHBgr6eK4PlYUp3gQAV8IOhb36jQfmSc2Ea2Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aV6o8RWo;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC3606D802
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAC3606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aV6o8RWo
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53cd0c8614eso5049241cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804989; x=1794409789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bj1NuMbANr/Z5gFJ9wJQ+PrgwIzmpwkHAXMC2xHxs2w=;
        b=aV6o8RWoNcbZl+D/pghaNRexJl6aPRCD5pgg+HSD6lDNqkpuV9mz98I+7a19n+1pBM
         rkQEayYPfmsBO61QB+/oQOfwQcudG4qeyxKwkdNXO1pYzo1b7ONiB4TAUI1hwQ9jJyPr
         Ed7AwyFMgHtnxr5zmGQavx3oyjuLtUHCw6qfcg9/EZRTOLKe9CcYQi+/mbV/2QpO+s/a
         UsouiSEF9Umg+uv0c84v5uoJO21tYGivaYc8hAVZ8kAlyhLjz7VBNajJo9YtZan3Nw+t
         viiixOJNx394iHjHFuoBvgYf55RiiuWtGwx5HO7ktCA1EPa+iglgivM68ZMqeI6VBjVW
         0wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804989; x=1794409789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bj1NuMbANr/Z5gFJ9wJQ+PrgwIzmpwkHAXMC2xHxs2w=;
        b=u5Pea9A6WMoh8VUJu331vmOMIN5fF2dOjFvNicbD5VDAi/hSbE1AU5Bk/hGUUTJEVQ
         CSYAplqd6V7UcclPoZkCeOdHzIW8dJa4GkM3CBZaQsxabXpFs8ZfGnneApFDW0l13r6W
         n9WMG8XnOxInA9aa1KYL3nliYdZooeYk5MG+nm1XQTaPF/nmwo994asmFP+LbHpAuc2K
         kWRWe9EHdAq0Iiz8SADSOKSoDh8JUAbotftaN7pLJzPOI1yXsLvFzYVcqvzf0jD/02sN
         1cB0xXTWWIJjatVHR3B4qkBJ9bl4I20YJnb7bgV9Nf/55gCQyC4rYr1/P31sqU14E2QL
         MSow==
X-Gm-Message-State: APuU4Z963ukXwHJCoRqqUaw0Y5jZ3YKACQvDqF0k8bA9PHQ0sl/BsNPD
	4dKQYAaI3q6urdz3j1H1LSPUlePb1ISnujrKG6oif//DAnUEc3mejwpOCIDI1t4B
X-Gm-Gg: AYBFou1hvAD+5tN8emBmndo2nP0ha88J+NuTz5C2f+5MUgyTMYjZFgvPaaKdwx/GV81
	HTX3h7J6X4cITM1W284LU3J48rWbD87Mg/xrDMd9MQDIFiPKJaaXrovI9W3Bq8wIt4i9Id5kgQm
	ii705UEO1DZ74huGxdECyt//HBb0Espzflf8VjCMbI7g+qlNsBcEpwqDMyPzra3R96ojAaK2vOL
	B1guUJYqwWadkuIf6wRiwqR4aiqm0qfLQeDs/rlE2wxDbp0RJeHgEQkhdHHowIQ6KaOLBi/W/FY
	HVAnGnRSwAtFi2UHIz74ULzpDJSfPyt0lyEL5ChfRhYuxyR+NwpeR4s1Pi+Gm+QiGcLnFepHklf
	+kOLb4KKtxcl4pSFsVyUP90o7aQGZBqhU2e+C9mTVfLaIc45yRMDU6QMhDg3DghleHBLWR47Bvo
	dppmF9iWlmfafwJY1hhHbGIsIudwHxPgI7AM0Amb6k2kwQP/wQJAdRrKlUsFWD+tnCvcekT5u8V
	Q5ncZbXzZNvfiWG6cJxuuv+EiAZKiVdR4YM2mD9sjdHuTIo/RQeyXhlhimjIT8mm6JDEwWcGNIa
	hAk/mSWNNR3ku5p8qO1Oyj6MaEIdQSiq0FbPTJ8MxDhUnB1HC0DARQOihxhbvrTNRtrlSHaGq+Q
	INtm4jpnCkqLyxJV7vGfjd1yJ9A3d2H38FgUMP1kWeXQcFPug4tQokCuu6Q206ZQ/kbHGDwfOcT
	OKcqT3Gb++wwL2Z2ugvULbg20ORSTibj0FSicQL86mH5cvLIwMlps=
X-Received: by 2002:a05:622a:2445:b0:533:3d48:37f0 with SMTP id d75a77b69052e-542b7332ab4mr271353401cf.47.1793804988485;
        Wed, 04 Nov 2026 07:09:48 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.47
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
Subject: [PATCH v3 19/20] libselinux: propagate descendant match allocation failures
Date: Wed,  4 Nov 2026 10:09:14 -0500
Message-ID: <20261104150915.175923-19-stephen.smalley.work@gmail.com>
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

all_node_specs() returns NULL both when there are no matching definitions
and when allocating a result fails. Its recursive caller and lookup_all()
skip either result, so a failed descendant allocation can leave a partial
list that is accepted as a complete partial-match digest.

Set ENOENT for an empty collection and propagate allocation failure through
both callers, freeing any results already collected. This prevents hashing
and publishing an incomplete digest. In particular, restorecon must not
cache an incomplete directory digest and later skip a changed subtree when
another allocation failure omits the same definitions.

Add a regression test covering literal and regex descendants, nested and
sibling collection, previously collected parent matches, empty branches,
JIT on/off, digest output publication, result ownership and handle reuse.
The separate matcher-error handling is unchanged.

Fixes: 33930961b ("libselinux: correctly find partial matches")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c            |  20 ++-
 libselinux/tests/.gitignore            |   1 +
 libselinux/tests/Makefile              |   7 +-
 libselinux/tests/test_descendant_oom.c | 179 +++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 4 deletions(-)
 create mode 100644 libselinux/tests/test_descendant_oom.c

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0b13ace2..52f65dd0 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1980,7 +1980,8 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
  *             NULL. Mutual exclusive with @find_all.
  *
  * Return: A linked list of all file context definitions if a match was found.
- *         NULL is returned in case of no match found, or an allocation failure.
+ *         NULL is returned with errno set to ENOENT if no match was found, or
+ *         ENOMEM on allocation failure.
  */
 static struct lookup_result *all_node_specs(struct spec_node *node,
 					    uint8_t file_kind, bool find_all,
@@ -2068,8 +2069,11 @@ static struct lookup_result *all_node_specs(struct spec_node *node,
 		struct lookup_result *r, *last;
 
 		r = all_node_specs(child, file_kind, find_all, buf);
-		if (!r)
+		if (!r) {
+			if (errno != ENOENT)
+				goto fail;
 			continue;
+		}
 
 		if (!find_all)
 			return r;
@@ -2082,10 +2086,13 @@ static struct lookup_result *all_node_specs(struct spec_node *node,
 		next = &last->next;
 	}
 
+	if (!result)
+		errno = ENOENT;
 	return result;
 
 fail:
 	free_lookup_result(result);
+	errno = ENOMEM;
 
 	return NULL;
 }
@@ -2507,8 +2514,15 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 				continue;
 
 			r = all_node_specs(child, file_kind, find_all, buf);
-			if (!r)
+			if (!r) {
+				if (errno != ENOENT) {
+					free_lookup_result(result);
+					result = NULL;
+					errno = ENOMEM;
+					goto finish;
+				}
 				continue;
+			}
 
 			last = r;
 			while (last->next)
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 0363bf3d..deaac265 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -17,3 +17,4 @@ test-restorecon-digest
 /test-policy-root-boundary
 /test-match-limit
 /test-avc-lock-failure
+/test-descendant-oom
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index ef1c490a..6c146b07 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -41,6 +41,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-policy-root-boundary
 	./test-match-limit
 	./test-avc-lock-failure
+	./test-descendant-oom
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -51,6 +52,7 @@ clean:
 	rm -f test-policy-root-boundary
 	rm -f test-match-limit
 	rm -f test-avc-lock-failure
+	rm -f test-descendant-oom
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -98,3 +100,6 @@ test-match-limit: test_match_limit.c ../src/libselinux.a
 
 test-avc-lock-failure: test_avc_lock_failure.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=malloc,--wrap=free,--wrap=security_getenforce,--wrap=selinux_status_open,--wrap=selinux_status_close $(PCRE_LDLIBS) -ldl -pthread
+
+test-descendant-oom: test_descendant_oom.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=malloc,--wrap=free,--wrap=getxattr $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_descendant_oom.c b/libselinux/tests/test_descendant_oom.c
new file mode 100644
index 00000000..4cfb8249
--- /dev/null
+++ b/libselinux/tests/test_descendant_oom.c
@@ -0,0 +1,179 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <selinux/label.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *live[128];
+static unsigned calls, outstanding, fail_at, cases;
+static bool active;
+static uint8_t cached[20];
+
+void *__real_malloc(size_t size);
+void __real_free(void *ptr);
+
+void *__wrap_malloc(size_t size);
+void __wrap_free(void *ptr);
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size);
+
+void *__wrap_malloc(size_t size)
+{
+	if (active && ++calls == fail_at) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	void *ptr = __real_malloc(size);
+	if (active && ptr) {
+		unsigned i;
+		for (i = 0; i < 128 && live[i]; i++) {
+		}
+		assert(i < 128);
+		live[i] = ptr;
+		outstanding++;
+	}
+	return ptr;
+}
+
+void __wrap_free(void *ptr)
+{
+	for (unsigned i = 0; ptr && i < 128; i++) {
+		if (live[i] == ptr) {
+			live[i] = NULL;
+			outstanding--;
+			break;
+		}
+	}
+	__real_free(ptr);
+}
+
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size)
+{
+	(void)path;
+	assert(!strcmp(name, "security.sehash") && size >= sizeof(cached));
+	memcpy(value, cached, sizeof(cached));
+	return sizeof(cached);
+}
+
+static struct selabel_handle *open_rules(const char *file, const char *rules,
+					 unsigned jit)
+{
+	FILE *fp = fopen(file, "we");
+	assert(fp);
+	assert(fputs(rules, fp) >= 0 && fclose(fp) == 0);
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_BASEONLY, "1" },
+		{ SELABEL_OPT_DIGEST, "1" },
+		{ SELABEL_OPT_JIT, jit ? "1" : NULL },
+	};
+	struct selabel_handle *h = selabel_open(SELABEL_CTX_FILE, opts, 4);
+	assert(h);
+	return h;
+}
+
+static void check(struct selabel_handle *h, const char *path, unsigned first)
+{
+	uint8_t healthy[20], digest[20], sentinel[20];
+	memset(sentinel, 0xa5, sizeof(sentinel));
+	/* Warm regex caches before tracking result-list ownership. */
+	assert(selabel_hash_all_partial_matches(h, path, healthy));
+	calls = fail_at = 0;
+	active = true;
+	assert(selabel_hash_all_partial_matches(h, path, digest));
+	active = false;
+	assert(!outstanding && !memcmp(digest, healthy, sizeof(digest)));
+	unsigned allocations = calls;
+	assert(allocations >= first);
+	for (unsigned n = first; n <= allocations; n++) {
+		for (unsigned ambient = 0; ambient < 2; ambient++) {
+			memcpy(digest, sentinel, sizeof(digest));
+			calls = 0;
+			fail_at = n;
+			errno = ambient ? ENOENT : EIO;
+			active = true;
+			bool rc = selabel_hash_all_partial_matches(h, path,
+								   digest);
+			active = false;
+			assert(!rc && errno == ENOMEM && calls == n);
+			assert(!outstanding &&
+			       !memcmp(digest, sentinel, sizeof(digest)));
+			/* Even a cached healthy digest cannot turn failure into a hit. */
+			memcpy(cached, healthy, sizeof(cached));
+			uint8_t *calculated = NULL, *stored = NULL;
+			size_t length = 0;
+			calls = 0;
+			active = true;
+			rc = selabel_get_digests_all_partial_matches(
+				h, path, &calculated, &stored, &length);
+			active = false;
+			assert(!rc && errno == ENOMEM && !calculated && stored);
+			assert(length == sizeof(cached) && !outstanding);
+			free(stored);
+			fail_at = 0;
+			calls = 0;
+			active = true;
+			assert(selabel_hash_all_partial_matches(h, path,
+								digest));
+			active = false;
+			assert(!outstanding &&
+			       !memcmp(digest, healthy, sizeof(digest)));
+			cases++;
+		}
+	}
+}
+
+int main(void)
+{
+	const char *rules[] = {
+		"/audit/branch/leaf system_u:object_r:one_t:s0\n"
+		"/audit/broom/leaf system_u:object_r:two_t:s0\n",
+		"/audit/branch/deep/leaf system_u:object_r:one_t:s0\n"
+		"/audit/branch/deep/other system_u:object_r:two_t:s0\n"
+		"/audit/broom/leaf system_u:object_r:three_t:s0\n",
+		"/audit/branch/deep/leaf.* system_u:object_r:one_t:s0\n"
+		"/audit/branch/deep/other.* system_u:object_r:two_t:s0\n"
+		"/audit/broom/leaf system_u:object_r:three_t:s0\n",
+		"/audit/.* system_u:object_r:base_t:s0\n"
+		"/audit/branch/deep/leaf system_u:object_r:one_t:s0\n"
+		"/audit/broom/leaf system_u:object_r:two_t:s0\n",
+		"/audit/blank/deep/leaf <<none>>\n"
+		"/audit/branch/deep/leaf system_u:object_r:one_t:s0\n"
+		"/audit/broom/leaf <<none>>\n",
+	};
+	char file[] = "/tmp/selinux-descendant-oom-XXXXXX";
+	int fd = mkstemp(file);
+	assert(fd >= 0 && close(fd) == 0);
+	for (unsigned jit = 0; jit < 2; jit++) {
+		for (unsigned i = 0; i < sizeof(rules) / sizeof(rules[0]);
+		     i++) {
+			struct selabel_handle *h =
+				open_rules(file, rules[i], jit);
+			/* The base regex's allocation belongs to the separate matcher path. */
+			check(h, "/audit/b", i == 3 ? 2 : 1);
+			check(h, "/audit/branch", i == 3 ? 2 : 1);
+			selabel_close(h);
+		}
+		struct selabel_handle *h = open_rules(
+			file, "/audit/blank/deep/leaf <<none>>\n", jit);
+		uint8_t digest[20];
+		errno = ENOMEM;
+		assert(!selabel_hash_all_partial_matches(h, "/audit/b",
+							 digest));
+		assert(errno == ENOENT);
+		errno = ENOMEM;
+		assert(!selabel_partial_match(h, "/audit/b"));
+		assert(errno == ENOENT);
+		selabel_close(h);
+		cases++;
+	}
+	assert(unlink(file) == 0);
+	printf("descendant-oom: %u scenarios passed\n", cases);
+	return 0;
+}
-- 
2.56.0

