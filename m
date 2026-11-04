Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804989;
	b=TDr7xlZQFtESpRH6giRa2HTZP8J2G/m50I5pkunrx4d7d9cL1SCuhVkGs8YRfgMqYufR
	 Hoa1hFUA4Lbkqo/K72cdEqzjiPULMx92lw8RXIj0Q7qPgHCIc9agoJBJQ91KWTsSUgeOn
	 81frXH2WTWgICGpU4nnHiDTvpFlzfXYZM94bmZvIhMJWbYMR5bjac7MP5w/2NE++fPEFY
	 NDCS+NXSCQ7fmLO1dsOipCcWaZKK2jH1rAq/unnqQx2fMz06xAvo+E78DqtM+5gESvgTJ
	 vfywN0as+NZlmR0n0FrW1S/s66ElddRJ2TTbFxavaj9j57H1Hnd4mObskRHlFu5+1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
	b=kwZUQIoCRWASfRvpw3pHb8U83rZzketCY9lsVf060qvhnWpoPSj8XOo6JYuceEG78UYa
	 42+uXhQHlEb8EUPwqr0r3bHT2m53CAN947x25QKso8/6oWC/v1ItHUzy46msWorjZgn15
	 333YMT8mIwNyJnoLRJvxn4EYmzSd6V33VSajAKhbKMAyfCwX8ffAVBxQd1D2VSth+Dazk
	 NXvsETE6/Tu6YqC0Ku0ZftuiuJY1mPJJa0X1nwalz58aI19TdTH28mgKeei8H4Mvq3YvI
	 BeEL0pQVS2mc2PE1cAHIzqjuTSxweTZ/NggmwXGjfy6OESk5e1ftC9Ry/O5X/jrWq7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngobqRMM;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB2606A326
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DB2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngobqRMM
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366ae57896so8200461cf.3
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804987; x=1794409787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
        b=ngobqRMMpt3JE88bEzS8yDxmdahIYxJTg4QcEew8WjIaVQ/3MZl5fWineRn+VWmTbA
         he6JHFPU8NJ+DxM9iXnxNA9WEu448WUYXzgAtMyY7a6d5FMVNk+ajrg+GD/DRqRNvwxt
         zUup5cSGhAcjQEPfxdSUffC4+GUZd0FmSuxJK1jtqP4TQZS/mimGD1m7Fzo6cTSswp7U
         HwGe6xvka9Q5q57EfpOnzwnmIK7V6+q3FTrBI5GiALfs+hQYN3PwRTCyP3m/8k4cscu2
         RpEG5mbV/jVcmbg49FTYwq2ZsKaQgn7YbUS3LcQU2wHrWjDDRqzsbbvqvDLPZnEbWsp9
         f55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804987; x=1794409787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
        b=UsM6+5DsTijVnT517Cq4rFC/UN7IXn97ToNUb987DBq+eoQG+RLh7ZTjWFHCxWbSQL
         sCVJNN1TAftmx+gZM6shemOEX6Ol5ZSNf6RnhcKM1iijLuAYZSI3sWMXeYwUyWnpQkPS
         62QLsikbQoUR7JMDBarWhlMan0IdWcMeLlcXj3YokcGq1Fbm3WbIW8XlQr4JeG43EjKW
         3aSbyUqUR6hUWf0JApbQ2ejuj28R81nCgoAoILG8C4Hb9/3+CZOF5iRMHQkY8HEcEtfc
         xBFB8ZrP0R2H+6j2/5zR0qolPGM0CVZb/wfj1HerzW45x5ghc9FWu5LLfkDTAyOlhn3E
         fMOQ==
X-Gm-Message-State: APuU4Z/DmXFYYCBzmszhb96MejHfZC3+Y7aao0XqRvbFLx2sG/+fUg5B
	geiaHyUIuZx5Dh9XUhe6hs67GDaJNK0AW1ZVbNk5gktajnIG2A6tCOCwcAswGlsy
X-Gm-Gg: AYBFou2qUmRI6bR3ctw9pDGF+Y7s9dihedgVHxGxZIHsqdseoPI7ykNSly1JPsymTC6
	PGKYk8Mf5pf71M2NG1NKed+lmzx4eGtxDzTv2+p3R1snLO166cJioJhLyJ2C5qaB/3f6WRoRO9s
	x13jK1HecJScNjuxVnwPJ+pi8i/zbW+BLhJ8jBWvQ8RLQqs4Z+2lIiAR0XeCWsSRsKNk9r6skJB
	Y7tSDqCeUA8oKg9edAzMXuShAl81Gv2d0iSJeRBcuTeJIxjAKUWBzx2A2ItB2+AxNCDGVBNy8Sm
	mL639wEgbbmwLQ2bzuiGFd4zd8JEDEJrutQ5op0iluMrD4fy69Ims95wxpIBNRC0PqK3e8EKBb8
	hvbbEw0Oo9YVPj2g5zvIJucGdRNP5mXVeoIkaszsDhsW6Sjvj9sxxzOCrzZhS7WcBpncNYaR40/
	7tlGJfPZMjaIp+H7pMeaqxsGZznUiaLbzh2HZ/gqXwxl1hUmetHPm3k5Z1yTlVRO7g9O4UtBWTg
	6CnQtmIxbdIWW1IkYyrbycVttg5177mbFoSHfhBV08HNgto/YM7G/6Grm1WgdCq2rRWqv+x6D8K
	gW3WwuM8dmSGmUEo4gOsDg5AC6wTNZojccvc82yyYs+CViant2GA+dhEE5KACI5n5s2Aty4ugYZ
	0rfBQp1vZvS/QvyNGlcCM2jBuaC0YMZOyLvJPXKL0stxi73VQvbqdhQ39SUHHZ0jrZzkXFjQX9x
	BMe6B80A07+Pan7t96NMzLTDCHDBKRKiH5XWEYA42JwDXask7L+w+f
X-Received: by 2002:a05:622a:58f:b0:533:32f3:1db9 with SMTP id d75a77b69052e-542b405a1c2mr273759541cf.11.1793804987223;
        Wed, 04 Nov 2026 07:09:47 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:46 -0800 (PST)
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
Subject: [PATCH v3 17/20] libselinux: propagate file-context regex match failures
Date: Wed,  4 Nov 2026 10:09:12 -0500
Message-ID: <20261104150915.175923-17-stephen.smalley.work@gmail.com>
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

Treat PCRE2 match-limit exhaustion as an error rather than a non-match.
Otherwise a lower-priority rule can supply a context despite an unresolved
higher-priority match, including a <<none>> exclusion.

This reverses the deliberate choice in 92af7f1b61db to treat match-limit
exhaustion as a non-match rather than fail noisily. Keep the resource bound,
but report exhaustion to the caller: silently falling through can select a
different rule or produce an incomplete digest. Callers can then distinguish
an unsuccessful lookup from a completed search with no matching rule.

Report matcher errors as EIO instead of ENOENT. Stop partial result
collection and alias selection on lookup errors, and conservatively allow
traversal when the boolean partial-match API cannot rule out a match.
Failed hash calculations must not produce incomplete directory digests.

Document the error behavior and add tests for real match-limit exhaustion
with JIT enabled and disabled, exclusions, hash and alias error paths,
recovery, and recursive traversal with one, two and eight workers.

Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex matching")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/man/man3/selabel_lookup.3        |   4 +
 libselinux/man/man3/selabel_partial_match.3 |   2 +
 libselinux/src/label_file.c                 |  12 +-
 libselinux/src/regex.c                      |   1 -
 libselinux/tests/.gitignore                 |   1 +
 libselinux/tests/Makefile                   |   7 +-
 libselinux/tests/test_match_limit.c         | 331 ++++++++++++++++++++
 7 files changed, 354 insertions(+), 4 deletions(-)
 create mode 100644 libselinux/tests/test_match_limit.c

diff --git a/libselinux/man/man3/selabel_lookup.3 b/libselinux/man/man3/selabel_lookup.3
index e20345e6..eae51608 100644
--- a/libselinux/man/man3/selabel_lookup.3
+++ b/libselinux/man/man3/selabel_lookup.3
@@ -69,6 +69,10 @@ regular expression in the database failed to compile.
 .TP
 .B ENOMEM
 An attempt to allocate memory failed.
+.TP
+.B EIO
+A regular expression match could not be completed, for example because
+the matching resource limit was exceeded.
 .
 .SH "AUTHOR"
 Eamon Walsh <ewalsh@tycho.nsa.gov>
diff --git a/libselinux/man/man3/selabel_partial_match.3 b/libselinux/man/man3/selabel_partial_match.3
index 4cd46f74..80f5a6c6 100644
--- a/libselinux/man/man3/selabel_partial_match.3
+++ b/libselinux/man/man3/selabel_partial_match.3
@@ -25,6 +25,8 @@ The \fIkey\fR parameter is a file path to check for a direct or partial match.
 .sp
 .SH "RETURN VALUE"
 TRUE is returned if a direct or partial match is found, FALSE if not.
+TRUE is also returned if an error prevents ruling out a match, so callers
+do not skip potentially matching descendants.
 .sp
 .SH "SEE ALSO"
 .BR selabel_open (3),
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 1d520517..0b13ace2 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -2284,7 +2284,7 @@ static struct lookup_result *lookup_check_node(struct spec_node *node,
 				continue;
 
 			/* else it's an error */
-			errno = ENOENT;
+			errno = EIO;
 			goto fail;
 		}
 
@@ -2488,6 +2488,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 	result = lookup_check_node(node, key, file_kind, partial, find_all,
 				   rec->jit, buf);
+	if (!result && errno != ENOENT)
+		goto finish;
 
 	/* For partial lookup if the key matches a child node, recursively add all specs */
 	if (partial && rest_key) {
@@ -2643,7 +2645,9 @@ static bool partial_match(struct selabel_handle *rec, const char *key)
 	if (substitution_affected(rec->data, key))
 		return true;
 
-	return !!lookup_common(rec, key, 0, true, &buf);
+	/* An unsuccessful match attempt cannot rule out matching descendants. */
+	return lookup_common(rec, key, 0, true, &buf) != NULL ||
+	       errno != ENOENT;
 }
 
 static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
@@ -2666,6 +2670,8 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 	if (!results)
 		return NULL;
 	results[0] = lookup_common(rec, key, type, false, NULL);
+	if (!results[0] && errno != ENOENT)
+		goto out;
 	if (results[0]) {
 		if (!results[0]->has_meta_chars) {
 			/* exact match on key */
@@ -2678,6 +2684,8 @@ static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 	for (i = 1; i <= n; i++) {
 		results[i] =
 			lookup_common(rec, aliases[i - 1], type, false, NULL);
+		if (!results[i] && errno != ENOENT)
+			goto out;
 		if (results[i]) {
 			if (!results[i]->has_meta_chars) {
 				/* exact match on alias */
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 251c41a0..352767c9 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -353,7 +353,6 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 	case PCRE2_ERROR_PARTIAL:
 		return REGEX_MATCH_PARTIAL;
 	case PCRE2_ERROR_NOMATCH:
-	case PCRE2_ERROR_MATCHLIMIT:
 		return REGEX_NO_MATCH;
 	default:
 		return REGEX_ERROR;
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 3a8f0706..39548615 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -15,3 +15,4 @@ test-restorecon-digest
 /*.o
 /test-regex-tls
 /test-policy-root-boundary
+/test-match-limit
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 2e6b9823..c36cd4ae 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -39,6 +39,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	$(PYTHON) test_policy_open.py
 	./test-regex-tls
 	./test-policy-root-boundary
+	./test-match-limit
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -47,6 +48,7 @@ clean:
 	rm -f test-android-specfiles android-label.o android-backend.o
 	rm -f test-regex-tls
 	rm -f test-policy-root-boundary
+	rm -f test-match-limit
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -88,3 +90,6 @@ test-regex-tls: test_regex_tls.c ../src/libselinux.a
 
 test-policy-root-boundary: test_policy_root_boundary.c ../src/selinux_config.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< ../src/libselinux.a $(PCRE_LDLIBS) -ldl -pthread
+
+test-match-limit: test_match_limit.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=pcre2_match_8,--wrap=getfilecon_raw,--wrap=setfilecon_raw,--wrap=getxattr,--wrap=fsetxattr,--wrap=fstatfs,--wrap=fstatfs64 $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_match_limit.c b/libselinux/tests/test_match_limit.c
new file mode 100644
index 00000000..aa7465f5
--- /dev/null
+++ b/libselinux/tests/test_match_limit.c
@@ -0,0 +1,331 @@
+#define _GNU_SOURCE
+#define PCRE2_CODE_UNIT_WIDTH 8
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pcre2.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+static unsigned limits, writes, cases;
+static int injected;
+static char recorded[128];
+static char root[] = "/tmp/selinux-match-limit-XXXXXX";
+static char fc[256];
+static unsigned char cached[20];
+static long filesystem;
+static unsigned digest_writes;
+
+int __wrap_fstatfs(int fd, struct statfs *buf);
+int __wrap_fstatfs64(int fd, struct statfs64 *buf);
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags);
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size);
+int __wrap_pcre2_match_8(const pcre2_code *code, PCRE2_SPTR subject,
+			 PCRE2_SIZE length, PCRE2_SIZE start, uint32_t options,
+			 pcre2_match_data *data, pcre2_match_context *context);
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_setfilecon_raw(const char *path, const char *context);
+
+int __real_fstatfs(int fd, struct statfs *buf);
+int __wrap_fstatfs(int fd, struct statfs *buf)
+{
+	int rc = __real_fstatfs(fd, buf);
+	if (!rc && filesystem)
+		buf->f_type = filesystem;
+	return rc;
+}
+
+int __real_fstatfs64(int fd, struct statfs64 *buf);
+int __wrap_fstatfs64(int fd, struct statfs64 *buf)
+{
+	int rc = __real_fstatfs64(fd, buf);
+	if (!rc && filesystem)
+		buf->f_type = filesystem;
+	return rc;
+}
+
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags)
+{
+	(void)fd;
+	(void)name;
+	(void)value;
+	(void)size;
+	(void)flags;
+	__atomic_add_fetch(&digest_writes, 1, __ATOMIC_RELAXED);
+	return 0;
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
+int __real_pcre2_match_8(const pcre2_code *, PCRE2_SPTR, PCRE2_SIZE, PCRE2_SIZE,
+			 uint32_t, pcre2_match_data *, pcre2_match_context *);
+int __wrap_pcre2_match_8(const pcre2_code *code, PCRE2_SPTR subject,
+			 PCRE2_SIZE length, PCRE2_SIZE start, uint32_t options,
+			 pcre2_match_data *data, pcre2_match_context *context)
+{
+	int rc = injected ? injected :
+			    __real_pcre2_match_8(code, subject, length, start,
+						 options, data, context);
+	if (rc == PCRE2_ERROR_MATCHLIMIT)
+		__atomic_add_fetch(&limits, 1, __ATOMIC_RELAXED);
+	return rc;
+}
+
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	(void)path;
+	*context = NULL;
+	errno = ENODATA;
+	return -1;
+}
+
+int __wrap_setfilecon_raw(const char *path, const char *context)
+{
+	struct stat st;
+	assert(stat(path, &st) == 0);
+	assert(strlen(context) < sizeof(recorded));
+	strcpy(recorded, context);
+	writes++;
+	return 0;
+}
+
+static struct selabel_handle *open_rules(const char *rules, unsigned jit)
+{
+	FILE *fp = fopen(fc, "we");
+	assert(fp);
+	assert(fputs(rules, fp) >= 0 && fclose(fp) == 0);
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, fc },
+		{ SELABEL_OPT_BASEONLY, "1" },
+		{ SELABEL_OPT_JIT, jit ? "1" : NULL },
+		{ SELABEL_OPT_DIGEST, "1" },
+	};
+	struct selabel_handle *h = selabel_open(SELABEL_CTX_FILE, opts, 4);
+	assert(h);
+	return h;
+}
+
+static void real_limits(unsigned jit)
+{
+	for (unsigned complex = 0; complex < 2; complex++) {
+		for (unsigned none = 0; none < 2; none++) {
+			char rules[512];
+			snprintf(rules, sizeof(rules),
+				 "/audit/.* system_u:object_r:fallback_t:s0\n"
+				 "/audit/(%s+b|a+) %s\n",
+				 complex ? "(a|aa)" : "a",
+				 none ? "<<none>>" :
+					"system_u:object_r:required_t:s0");
+			struct selabel_handle *h = open_rules(rules, jit);
+			selinux_restorecon_set_sehandle(h);
+			for (unsigned len = 20; len <= 34; len += 14) {
+				char key[128] = "/audit/", path[256],
+				     *context = NULL;
+				memset(key + 7, 'a', len);
+				key[7 + len] = '\0';
+				limits = 0;
+				errno = 0;
+				int rc = selabel_lookup_raw(h, &context, key,
+							    S_IFREG);
+				if (complex && len == 34) {
+					assert(rc == -1 && errno == EIO &&
+					       limits == 1 && !context);
+				} else if (none) {
+					assert(rc == -1 && errno == ENOENT &&
+					       !context && !limits);
+				} else {
+					assert(rc == 0 &&
+					       strstr(context,
+						      ":required_t:") &&
+					       !limits);
+				}
+				freecon(context);
+				snprintf(path, sizeof(path), "%s%s", root, key);
+				int fd = open(path, O_CREAT | O_EXCL | O_WRONLY,
+					      0600);
+				assert(fd >= 0 && close(fd) == 0);
+				writes = 0;
+				rc = selinux_restorecon(
+					path,
+					SELINUX_RESTORECON_IGNORE_MOUNTS |
+						SELINUX_RESTORECON_SKIP_DIGEST |
+						SELINUX_RESTORECON_SET_SPECFILE_CTX);
+				if (complex && len == 34)
+					assert(rc == -1 && !writes);
+				else {
+					assert(rc == 0 && writes == !none);
+					if (!none)
+						assert(strstr(recorded,
+							      ":required_t:"));
+				}
+				assert(unlink(path) == 0);
+				cases++;
+			}
+			selinux_restorecon_set_sehandle(NULL);
+		}
+	}
+}
+
+static void hashes(unsigned jit)
+{
+	char key[128] = "/audit/", rules[512];
+	unsigned char hash[20], sentinel[20];
+	memset(key + 7, 'a', 34);
+	key[41] = '\0';
+	memset(sentinel, 0xa5, sizeof(sentinel));
+	for (unsigned version = 0; version < 2; version++) {
+		snprintf(
+			rules, sizeof(rules),
+			"/audit/.* system_u:object_r:fallback_t:s0\n"
+			"/audit/((a|aa)+b|a+)/child system_u:object_r:%s_t:s0\n",
+			version ? "new" : "old");
+		struct selabel_handle *h = open_rules(rules, jit);
+		memcpy(hash, sentinel, sizeof(hash));
+		limits = 0;
+		errno = 0;
+		assert(!selabel_hash_all_partial_matches(h, key, hash));
+		assert(errno == EIO && limits == 1 &&
+		       !memcmp(hash, sentinel, sizeof(hash)));
+		assert(selabel_partial_match(h, key));
+		assert(selabel_hash_all_partial_matches(h, "/audit/a", hash));
+		selabel_close(h);
+		cases++;
+	}
+	/* A previously cached digest cannot make a failed calculation a hit. */
+	struct selabel_handle *h =
+		open_rules("/audit/.* system_u:object_r:base_t:s0\n", jit);
+	assert(selabel_hash_all_partial_matches(h, key, cached));
+	unsigned char *calculated = NULL, *stored = NULL;
+	size_t length;
+	assert(selabel_get_digests_all_partial_matches(h, key, &calculated,
+						       &stored, &length));
+	free(calculated);
+	free(stored);
+	injected = PCRE2_ERROR_MATCHLIMIT;
+	assert(!selabel_get_digests_all_partial_matches(h, key, &calculated,
+							&stored, &length));
+	assert(!calculated && stored && length == sizeof(cached));
+	free(stored);
+	injected = 0;
+	selabel_close(h);
+	cases++;
+}
+
+static void error_paths(unsigned jit)
+{
+	const int errors[] = { PCRE2_ERROR_MATCHLIMIT, PCRE2_ERROR_DEPTHLIMIT,
+			       PCRE2_ERROR_NOMEMORY };
+	struct selabel_handle *h =
+		open_rules("/audit/.* system_u:object_r:base_t:s0\n"
+			   "/audit/branch/child system_u:object_r:child_t:s0\n"
+			   "/alias system_u:object_r:alias_t:s0\n",
+			   jit);
+	for (unsigned i = 0; i < sizeof(errors) / sizeof(errors[0]); i++) {
+		unsigned char digest[20];
+		char *context = NULL;
+		const char *aliases[] = { "/alias", NULL };
+		injected = errors[i];
+		errno = ENOENT;
+		assert(selabel_lookup_raw(h, &context, "/audit/x", S_IFREG) ==
+		       -1);
+		assert(errno == EIO && !context);
+		assert(selabel_partial_match(h, "/audit/x"));
+		assert(errno == EIO);
+		/* Descendant literals must not resurrect an incomplete hash. */
+		assert(!selabel_hash_all_partial_matches(h, "/audit/branch",
+							 digest));
+		assert(errno == EIO);
+		assert(selabel_lookup_best_match_raw(h, &context, "/audit/x",
+						     aliases, S_IFREG) == -1);
+		assert(errno == EIO && !context);
+		const char *bad_aliases[] = { "/audit/x", "/alias", NULL };
+		assert(selabel_lookup_best_match_raw(h, &context, "/missing",
+						     bad_aliases,
+						     S_IFREG) == -1);
+		assert(errno == EIO && !context);
+		injected = 0;
+		errno = EIO;
+		assert(!selabel_partial_match(h, "/missing"));
+		assert(errno == ENOENT);
+		assert(selabel_lookup_raw(h, &context, "/audit/x", S_IFREG) ==
+		       0);
+		freecon(context);
+		cases++;
+	}
+	selabel_close(h);
+}
+
+static void recursive(void)
+{
+	char dir[256], child[256], rules[768];
+	const size_t threads[] = { 1, 2, 8 };
+	snprintf(dir, sizeof(dir), "%s/recursive", root);
+	snprintf(child, sizeof(child), "%s/recursive/child", root);
+	assert(mkdir(dir, 0700) == 0);
+	int fd = open(child, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	snprintf(rules, sizeof(rules),
+		 "/.* system_u:object_r:base_t:s0\n"
+		 "%s system_u:object_r:child_t:s0\n",
+		 child);
+	assert(selinux_restorecon_set_alt_rootpath("/") == 0);
+	for (unsigned sysfs = 0; sysfs < 2; sysfs++) {
+		filesystem = sysfs ? 0x62656572 : 0xef53;
+		for (unsigned i = 0; i < sizeof(threads) / sizeof(threads[0]);
+		     i++) {
+			struct selabel_handle *h = open_rules(rules, 0);
+			selinux_restorecon_set_sehandle(h);
+			injected = PCRE2_ERROR_MATCHLIMIT;
+			writes = digest_writes = 0;
+			int rc = selinux_restorecon_parallel(
+				dir,
+				SELINUX_RESTORECON_RECURSE |
+					SELINUX_RESTORECON_IGNORE_MOUNTS |
+					SELINUX_RESTORECON_SET_SPECFILE_CTX,
+				threads[i]);
+			assert(rc == -1 && writes == 1 && !digest_writes);
+			assert(strstr(recorded, ":child_t:"));
+			injected = 0;
+			selinux_restorecon_set_sehandle(NULL);
+			cases++;
+		}
+	}
+	filesystem = 0;
+	assert(unlink(child) == 0 && rmdir(dir) == 0);
+}
+
+int main(void)
+{
+	char path[256];
+	assert(mkdtemp(root));
+	snprintf(fc, sizeof(fc), "%s/contexts", root);
+	snprintf(path, sizeof(path), "%s/audit", root);
+	assert(mkdir(path, 0700) == 0);
+	assert(selinux_restorecon_set_alt_rootpath(root) == 0);
+	for (unsigned jit = 0; jit < 2; jit++) {
+		real_limits(jit);
+		hashes(jit);
+		error_paths(jit);
+	}
+	recursive();
+	assert(unlink(fc) == 0 && rmdir(path) == 0 && rmdir(root) == 0);
+	printf("match-limit: %u scenarios passed\n", cases);
+	return 0;
+}
-- 
2.56.0

