Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732017;
	b=Sv1o+gswsQy3R9UATLPPpou/riBRa2ORQa5AV45BoKjnlspe0lrvfq/hSgdc2HXl4HeG
	 cg9CL1gRdy4oWmVtL0IhpBBameWqx2Ycxi6sjhSxYvBlBprUhyx7bNst1LNcJgI4NhO6f
	 aGifxEeD2Jo2IoiRXdu+M/4cPceb6JECYSMNxQvrX0ZTrIULV5QOw3PR4u5LetOi+bfK6
	 urSTWdR1Rlkfxvkv5TVFvrMVK2slccHvbCbshSJPfyAGYSxdILMa1h7TjEGBwi/zjN+GS
	 SGuxsIku0p9Rztp+Oxu5hU45EFtE6ZumrEqSumhDC+5ZoBxRV4rbUEMSJsxkoahuY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
	b=4+SY/37KRztBIc9OmMU6yX4ORHoQ0WSfyz3v6EqHT5dm0UfSY/4+Y8GXWK78Xf/m8nTA
	 0OWelX3MLCt073IBiV8ICW5VZbU0Gzfoca4MV6pSYkMDMf/dawHeZbWnEh2i4+U+RDz6e
	 gjcfVa10yM+hD0YqnB2TBFlcCXA+yWjOhLPTnM0e80lL3Aodgqsepd7prOkWMDmJIqp5H
	 /KfdONGsFqssaybJUokTqKDwGzyXmzcB6hYJfd99ikfgaAn4DrMxIgda1WE5TDcCB6Tc8
	 u1nYMcnjT98Zi4JmloS8jWynfBKvQt0lqKfJY3e5U7MFB/OLwV16gP6G7VqIW7775sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1SRL5uk;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC606A324
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EAC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1SRL5uk
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c847584b8so13070756d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732016; x=1794336816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
        b=Z1SRL5uk4y8RIgl0E6xPGepsxh8VJR3anvpELrvlf3EY1Q7L/3+0WyZCQCb01iIzY1
         65zRJeMu6jYTkTr+x5NAI7xQkTrFFL4hhaRdAboTmXhJET18NhRtty+LBxHYHBDZoNK3
         gcUIBxy6jLM0Gnj9BtLvC0pvUAcM6vhXwrcKCwXtK2QzNd+MzJoKISCkIO6iTo83IP9s
         xf95KD6Wrsb9MJqf+Q408BnKJeMePxusu3Hnq2lszt62oztNhv2MboO4ny/X1rZhg6D1
         9ARw07gX07RxAColJtgngxfBbGp6f2fUtsgUMmq+1wELTqH6NFGLMI3tdJOamAa0vYvR
         kP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732016; x=1794336816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7TOm72pnPhkTuk+abUG0gJtMyf41IlJ4A7b0UFIKuw=;
        b=lKSAr3e66YFC+pbi/XI/Oj4O4aEnjrKwdwe3zbPbnc05qcXoPWOvEXG8Uu629sM7QH
         Rmgoby9599TwfgyhPCBKWyXO0Sp8CjElz/2/HIgnP5+BDm3VjDudXuCwJCMdnhZP+02m
         LsDcLfFqXLqLAVGVwtjVQq0hDwPX7WVC/2XmOOJgGVgqdFIS7D0oYO6KwLO4AgmIGvX9
         ZIbGrmTa2A1NpbPbcOBdxeLrkrqJpWn0kovQnwgs0TgYeWC5ulGNJBuz6AzT3g427WC5
         THP+S7enlJLiAbZlqufXt/DdxTudCVhHO/py3S0HgHVwQpoxB4gPvkw2Mu7pVFUviKhj
         RN8w==
X-Gm-Message-State: APuU4Z8kFfVVr+H3m1tayuYZW1RURTKy/YtzCafbPZbSQt+pXrX/hoE3
	cjwwLdXEv7x4t9psmYY25uqMQa9jhFTQd250H94ZkdI6DBb9uW/Rs3n/9J5oXPSS
X-Gm-Gg: AYBFou1CdkYs/0b3RSdk8MftA1cllafu5y3wOPH9Mxm8BMImuwQQd1xtg6Q8aRmTv8S
	NO6Yg42F7DuLlRu5PWlDbxXeI3eAKsmwEWPZyyH93RgHLiZDVXqQUcsqLYA2LWouUyMFr93wj7e
	hIfK7vbZvyTdZzPDwMzmn8NmOsvKHHfp2OuU7sE5DSTuix85TtyP8yP7jF/9PWuXdlSY6/zTCuu
	PK0HSSdzmVPvnhQ0YG3NhIylUEAmIlXw/qUmgDM8VLQUNFAkSTMUVEpoIJMhdLVC2ja+nmVytNh
	TFuWXsbCfS6MDU5jjqjhOdyvHxDXJfuVu34PbjwOv4Ogs2cHo0fv0zNNqANZ5Vn5G4yHPM3UIWX
	Ee8w1tRuUFyRkMOSUd5x5shIfUhfZlZVvJy/BnsGnimj/o0084Ke5CQOyJ9URdvp2r6N2ei/6jn
	5UIpmG4jIu8F01MiOJkHtPmjiGAiMfg1jYQ8oOEOJFHnhmeJg5h6BJrxPZO6QCyz9rtpgZOEtoy
	Dh4ishnDGjSJbTzCR2oQ8KBPvgAxcmkAie/jSYIHQ3wOV85Q7/pbbsVo1j19ZWrpDY4n+WCp/82
	nO5fT38GIetvtJyEx+HGFs3dtOX5SqeK2JWhjuHXKVrFvPRK1h5QBTmUMAeXiZD+JX5KSIJD3Qw
	Z8WL2/85pHTXSRZj/LEcrphXXKi8F6TcMLXb/3fgFhbSvLVgSgMKiaXjlNheJqLDSJmS3GAqzrY
	KRkfpIXbC4Dn4VOHhntjlpyijfE2UhyuAIUmNUa9VK4lT5ZFf4QtVxDT3D3tSud2SZpfm1duEf
X-Received: by 2002:a05:6214:da5:b0:91c:c52a:cb7 with SMTP id 6a1803df08f44-91cc52a0d5fmr109653306d6.8.1793732015919;
        Tue, 03 Nov 2026 10:53:35 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:35 -0800 (PST)
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
Subject: [PATCH v2 17/20] libselinux: propagate file-context regex match failures
Date: Tue,  3 Nov 2026 13:53:04 -0500
Message-ID: <20261103185307.45924-17-stephen.smalley.work@gmail.com>
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

