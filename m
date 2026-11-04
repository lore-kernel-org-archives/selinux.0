Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804987;
	b=12RiZ9snlHkQDb0W2/gVU8/3sDZzScwo0WeiVN0qpW2kBRMYhbFK0XXGZ57/IWi2L8GG
	 7qCioeHQo2wzGZc+DPdHy6h0aBb1BTIqoN6WPQ5ep868iGA1Y+/kXtGu1TPieqPXjYBOu
	 XEptALtOqBAzY8wBn3tvlicndAu6yal0aY5K25fHDNf+CacrDxpnuFNnTZHOkySF6eJuQ
	 K61CFKcKdjq857dgGZA16mn3n/JrTUJO+fbzne5H3Kmy0zcRTepm1zbQUzoNIfUd4L6aP
	 t+EzcFT2SlhanAfN4teMLs0/k6+JmkglFOHNdC9y857kuXX7Chnu1JM8+i65EWM8rXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
	b=QVl56c6J9xScgphlNDCmrMpphC1iCOb76ITSsJDR52EOVFQ/iyGfImML3sT1BQ4LbmGb
	 SoKKYFezQjYT7GdvEUpcPIf78WbmAv3vYwsBjEz7nPUWfO68RnQbryeORW6J2bjgQVdB8
	 SMgjIQLalnA5GFJJK1AcL6eErCAYdCAGVGAq8ZA6EdtPK7assM4h0YEfTD/yIn6C33wTn
	 PtY193OV72qCrJmEPXhj+hUT+v2+x4IF+3g3qg3q3G/UiDuc6PQHRIMdE7/sz/Kl4fRHp
	 8VqfXJ4j+8bMIyKmocl/cLZ5f15jCon9vMiCD4Fqq4stpJHftBy14Xch5UqmlultW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LO6q+YGg;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EF606A332
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D98EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LO6q+YGg
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365d26ccbdso9036551cf.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804986; x=1794409786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
        b=LO6q+YGgrpMbr/2GAtWY78qK4I9IGAIV8yziyUQG2p2EqjY2kpmvKOTN2sC0PEdI2/
         CJxrIO80JCJFMM4U3ijB4wZJ/voGN7e7ERC0CRM9oUvW34VVobuck84NPI2hZxwQgQk+
         DEUQPMa6O4oiljDmwKPtPeJILGYVYhUT1BnYpjpwE+Ut9JTm3gHJhNCAkTX2PNiRrMUH
         O61W5ZBCLFwpOwq4c4TjpF1FkxmPbMRgil436fx37ZxFz96TRdpUXvqbOlLlkBgjqLky
         8KqjHrJg4zKmzz11/yeso9t6n0lB81HOoeL9GPhk7G6Cc5VO8IN20eaWnqq5xKj7U/sg
         WrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804986; x=1794409786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OR3Wp512Y0vsO6UYmfUKg2ChjL4XSk89qJA9CdPpDA=;
        b=n1lCd7/CswcATR6BzFBywv7/6SdpBFqfIeuhJY9yiIskBDNawj6Qy7ZZmJj2RFfnuI
         g8rvE2HetJGyWY3ZrNUFq+kTGtvsripWAHS0SYxRHgkb4+cs1B1R9E7CxdDUabKjnp9a
         5zNGy4jNAj93DCTJ/QForwnvo+uXVI4YvLDAvqlW8OUeOUzwb77crq9sVgCwnlevLYVj
         8QEXw+VGNyhDI2oGC+IhQ5FONpMYjy+truAcHLSjR4fRlNAmn/Yq6EYA6ZwDrbPycDLC
         x5eeIe5tirltlYW4c4f0lKT2UcQmRB+ZZ4YoeHZNhU2X0E1SQqd89MwwYMNCPPd60CQw
         kpxg==
X-Gm-Message-State: APuU4Z/s8Z19tBdt5x9d3aHPB/oOCHXFmG3hVFb7uOqGgN5DndoVh01Q
	Yw32H2JE4LdyQmoR+ESTM6Sq2DUmqIOhVtdNGnDwuu2s/WCE0HbDh6S+5zfWMI/B
X-Gm-Gg: AYBFou1fCgmLplHEr5S67qRR5YQaCxz3YvMo4QRoLSNH5Ezergahor3B7S5DykD1VA7
	tbPbdOW4THBg5q8BUGHlw57l+gdGyHcJ16Sn96RZxB5lT/SlEMh46YEEjs7Bz+tyjMipQzhGf/z
	f1U8Kprsq2r8nyHJYhnz8Ip73AS8jX3WB2mfI5qgq2Fo+Dt0bKPjrOXr+ZO32aNBdw2dJtXcTY/
	3nJ+8bxL+W3Vycxhv7M1W9YJABAIpjQwPFbiHsShtWX5JDF8IEG7FbrYM5rum4deTUUsaKvu6EM
	+cZLOOSivFQ98jO30+87CBJB6VQqi7yjHIRErByiBurOHybj0QPTcLoTkNDKkDVfDAPV+mCGj3o
	IUMqpnW5H4bHFkj+Oo1SuypHR4UGOVrzPizlR56634e6hoOM/cV2EvBw3SdhGiz8C2sB2sblUKB
	Llvngwa1m4KBRmy1bIshw2WGrSz3oP7EK2QTwSIK5fpNmKhlRczYfuxxpl6XtDYC+o8A5Bd9kP9
	7YLRXwLiTU8Q/gcRA8iDBisrvsPoqGA4JmZ3ANgnt4IzFCcjE2lLHpgLMKumqq7vCANcjCuDcH8
	6ar+syat1+gAPaFBpoT0311E1jREpe+pnlvO/F8/vw/T0XBDD3z3CrbM44VvaEAmGAS67GQbcRj
	V3v69g1G0xbirOCpGrVJGatXgsmArMiPK6btg9npujfQQe91lNgqH4vQpOmEFJRAk+nwQN8s/FD
	2BNsWzwB3yFeneAPadQ94gTSuG+OyK/3/dbsFyFLkw7Qr7lKhySpE=
X-Received: by 2002:a05:622a:1386:b0:537:f05d:6ae9 with SMTP id d75a77b69052e-542b62a5744mr269811171cf.13.1793804985300;
        Wed, 04 Nov 2026 07:09:45 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:44 -0800 (PST)
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
Subject: [PATCH v3 15/20] libselinux: free regex match data when TLS assignment fails
Date: Wed,  4 Nov 2026 10:09:10 -0500
Message-ID: <20261104150915.175923-15-stephen.smalley.work@gmail.com>
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

