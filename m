Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732015;
	b=DpI2S4AATT6rm7qtoUSH1dWTyhFRqDU4AIaZUCm7s/+IIpVJL4a55A/TIKuz8tBgAhzd
	 hsvjwNSJ/eXvME9/PeNbPQhP6oZvCP18Ktp0q3aY4hYwkahNskEaY5yhCYyCoZuqS9BQi
	 B5hhu9lPLRhr68y4Ym/peAKXuhLBPWRLW96zKFUfjOD5EdRhHAnWD16iq59piKHO0F0cZ
	 5MOAH3mGJRVDhBYQBMAnQ9V3ELcd6Xcw5kmt/p9QyE0k4tcw6iG5ukty/UHyY6YCI0GSG
	 YTL1+UdEm30g7WiCEbIEb7M4IIRJ72W6YbgIwcZKVzNtALAGE9LSN3loy5leEZysaBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P5KGjyDqXHzjNMca1zvC+obua3ycO5nonaODMEzhuRM=;
	b=gyb5XgOumnEuM7v1bOKhKRkYRHzK0SBN+BDN01vJW4/9TBKlZ46w5mtegzUrpGztXDJR
	 xii1dyQ7i/j1hSPeqaXVnCNB8/zMLOitdPIEQP67+E0vokDmg1lgeVbLAXSyyHXx0J/Yx
	 WHMj1kojMuIT7MJbE83Sv3829jnV8uHlE3pjH1Gb9YSIt4MZRoLRPkmQXTIiOY64tN3/y
	 kklZJ3XH0eXs0TGBVcpv59fMqBP0RDZAGYTt4UWS8cbRPUUEtfmX7eoMW/5vsMrw32Uoi
	 gD9MkEYA2R6m3RIw1vgBRWWTfgZQl0FJ7p4FPyEBhMPcW2K748zII6CO7gPWwNMfQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4eJGXp1;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD737606A32F
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD737606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4eJGXp1
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f1cf92c9eso425868485a.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732014; x=1794336814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5KGjyDqXHzjNMca1zvC+obua3ycO5nonaODMEzhuRM=;
        b=k4eJGXp1OnzDHTyMckFdhWc7TjH8Nb6aZ1i4L7j4PNlVtSfvsAi82U9gwrV7RBlXB+
         /cxMgJBBnqjegCbmlc1jf8PjwgALIDMvqpSbcrIu1XJLGb7Afm+X2ehMZQoPfjFE4jDT
         5rmtf24zi9Lcbl0UYfRTOu9LePmVlQ36rdjkhwwqoVRdMM+a0sHuQ1/x9nkXC1glf7tP
         iq4aemV1nQDIh5aSvmTSZ/96PY/HoT9BS0amyGEsX6vuE5jF8Fg3pIlVrii0IatpouJg
         BrS58AUw7yI0LR9Aw1bgq7ra4nm1vD5Mkw0gn4fY1j4B4iGYO3DESZELgweEVhb0xMEJ
         nHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732014; x=1794336814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5KGjyDqXHzjNMca1zvC+obua3ycO5nonaODMEzhuRM=;
        b=Mq2x4wuR6WR5nY3qrfKsZZi5EqA4RV+VbiVC+hSowiGrqDCt/YFRoljqHtCOWKcJZY
         mE1vaGUGZMBModdAFqW0et+0YhKk3pXN1Hr9VJaHmeds2CuRT2+FD+e12JC+FrsYm66z
         TJ6hbrXQBzWFzpzYyABWris2WLjnmRQURhpealKY1WW0RTM6ZS5bbx6FMKih2GEJFd1u
         TzWplpQu+2NOSSH+vrmLKpgZzG4n93A6Jz69bdeJYAxZvU0OF+5UTThXH3Qy52H+xtmd
         oFkF8DDVEIyWuVDSvnHkfrodGkxELe1KK5rXpofcson+w7IAbuTjgvTu5eLV6+x0QJcu
         2cXg==
X-Gm-Message-State: APuU4Z9Xjcv5UDI1qi2IK/ppOPD/9qmncjJxE9b/1+zOG6AhGsWaLYly
	Vrva1eaPZin4FgYdRMvfaoaoExHKe2hNbYrAu/1IiS5ILtPFup1AsfhawHr7UxfN
X-Gm-Gg: AYBFou1ODjNYznxAwhDcOgbCKJ60FZxoUVN1ZlCqlVg4bF5zVz+8swdPuxItrpAugpF
	kX4nET6h/A5hwMUbX0DkaYB61g5uWX+hHrL0Y5yf/nSoQfws8UAS3CmXPxFFbeAXJsJ2mArQo78
	GwT+M+eVYDfEhQzU3/hJPLTP258H4ErMOlMmiN4EMpDPQBoBZMmPFRieTCznJe5KMqRfAXJOWOy
	xB7dxXppUMcL2Carf0jNhAOx4SSxoxDN9ZEvNu4P/xUklEez5k6iwmH5Z5kDAPk+6PO9PuH6P+Z
	ee4g6Xad1EbpMPdcJ9yX/scfPYZDZT/eiN08sJhtPNJ3tgvfHltzVxgXJOsmz9VLmWuDy3gsWvB
	OA3nwS0ynKmuDBouPpsP3l1Db/wyuqIdTflSFuK0/QrrRCBSX8veczvo0JigfwQGWr593WsOlQq
	S1fou9kwMchUJtfBeLroWsq8OQ+wkFB2paQalfqrBzR/UlQEaHckeczyt5wxspQo14r2wy/WtCo
	vJ7MNwrtM+0nwlmldG682BFNEpVMUvY54zzm+YOdHVi37XbMpFzReZCHNGCampJVbwUn2Svhed0
	dbjj4oWSdJtyHc5Kfkct2o4UvATKbz1OGMNGcM9n3uVCZAHRvPt3SIsv0LFCHvRKF5ZjsvDU1i4
	g8N02RHYqJ+oy5gWVG4e1vxrMdwNp5qPQAfojeGrvS5lOib34ouo8BPmc3fmk02eE+y8v+5vJlJ
	07O8ui9IYbWkJor+wBb2hsbeeWFReKY7/W+fWOsICvDChXYpvEJr8=
X-Received: by 2002:a05:620a:29d2:b0:940:e34a:aead with SMTP id af79cd13be357-9442156a732mr2274810385a.5.1793732013482;
        Tue, 03 Nov 2026 10:53:33 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:33 -0800 (PST)
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
Subject: [PATCH v2 13/20] libselinux: record specification paths for Android backends
Date: Tue,  3 Nov 2026 13:53:00 -0500
Message-ID: <20261103185307.45924-13-stephen.smalley.work@gmail.com>
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
 libselinux/tests/.gitignore               |   4 +-
 libselinux/tests/Makefile                 |  15 +-
 libselinux/tests/test_android_specfiles.c | 202 ++++++++++++++++++++++
 4 files changed, 227 insertions(+), 2 deletions(-)
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
index dff32587..ecbbc014 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -10,4 +10,6 @@ test-restorecon-digest
 /test-readable-fallback
 /test-digest-inputs
 /test-load-policy-version
-/test-auxiliary-duplicates
\ No newline at end of file
+/test-auxiliary-duplicates
+/test-android-specfiles
+/*.o
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index bc3ce5bc..c73e5c65 100644
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
@@ -34,9 +34,13 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-digest-inputs
 	./test-load-policy-version
 	./test-auxiliary-duplicates ../utils/sefcontext_compile
+	./test-android-specfiles
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
+	rm -f test-load-policy-version
+	rm -f test-auxiliary-duplicates
+	rm -f test-android-specfiles android-label.o android-backend.o
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -63,3 +67,12 @@ test-load-policy-version: test_load_policy_version.c ../src/libselinux.a ../../l
 
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

