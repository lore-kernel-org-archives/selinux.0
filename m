Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6C4DD3CA
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578408; cv=none; b=PUTGh7o8FHKM7Xypdp65eqyr400Ts34jVA19AdXgTgtDFE33XtaSIKvgHmzaTWQwR7/FKyQSULcjzGItcmYEm84cZpJz5qKz1LXMDXHGN2apfAMCdT7mlRvGm1trt9lZVvGFqKob5MtX1wCr0PjtImHTJ6VV46GA3nC9VCG1nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578408; c=relaxed/simple;
	bh=Pulv4bJ954GUQIFKJ0zpYxlvWxApRjBpVSiUGAxl/mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juS6a5OHrBSz+WPWvHmXBazCpMgJurUTSE5TtzA/t7qURhbe88Fhquijf2RcdWmXmzXV2/lYTFljurdnt+Udw+zG3npkxj2qz/TlK9uUZY4hSuoEwYPHpR/jwsEhZmkrxBAeZD+/jF8h4neuPvywo2ZsOli5sETTcKai8kw+9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auN+YW8x; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auN+YW8x"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-6713d20d375so1219492d50.0
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578398; x=1790183198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYHti5DAfFe/X89dipb7vtBrEiFX7oG3Rr3u/txsyN4=;
        b=auN+YW8x61UVgpcq5Fm/f5oi6c3Wx6qeNrQT11Q1P+MnADc7DZICdx28AnJYEErD/U
         SXa+g1yJHCtTy+Dx0X8lFUj4Y6CsJMf1JU+EUwZoMkTsRBEb0nTdFD4cZt7FKWR9hEeW
         qIwB5yhj34Hed+g6gL/KoETgZoPfc9jyYf7Xwuvmh1e4j1ZcNP2slJ7svht0YCj6gcy0
         CtKfIx653vlbbAyOBr73L0dBjMNRQ93OBxdb3OYBI4zb5ZA035aeAMik6xbDHMM6PuoE
         Vq0tBwZGaMTIG1pUx8U4BigcrZ163ZkKwhqoPmLMrh8aG5QTw8r7pQwRZpwFgylCY/hb
         QZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578398; x=1790183198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYHti5DAfFe/X89dipb7vtBrEiFX7oG3Rr3u/txsyN4=;
        b=hHhK706q1S2IS78UmiQ1Fx5f6BJxpFF2V+05pzjZedelnBhM5VrJDJrUA2VPsF8YQZ
         1NmKKmLRhocWav/4MonzEhzSsaS1O9SP1odUIw9wLC9eFfTMV3ciQE4oVpJ2aazaBlw2
         1Y3PpsbU3ykNHJ13iqV3B9k1bKzTgEUIjUpu6vehWVnYewgiGM8I7tKkWQ0icqwTou+h
         wSRFBnb8ovTyIPvyM3mqkPQAun7T7baC2TG5m3lSP+pMxRreCHyQsmM8l/WhFzJSjFRd
         nggqLRB+XQJwig+9jO8b6QMWAtZ1KKrvSWjSiQSroZ8PsaOZVT/ZHAGfGyQvPCLEmZHp
         DUZQ==
X-Gm-Message-State: AFuF++mx90oN1xBRNZjNXsSZo6ew5RvhENZI5MnK+I7HP0vROGeI/LrR
	tTQvEMI1iiA6PhW+sibFNyeAxU/opCfKhlHeuljQ7WPcOGpyCQBGcyX+3p1vjw==
X-Gm-Gg: AYBFou0HHnRkoB4lRXeViF2HG63qLzhIWy9RcO3joqIgdbJwp7WjtWzPgeOjQ2YPAtA
	51YVUf6UBUq7WwN3qvSGS/hHATvnR3lZsXQ3yx7KsqZ12J+hirvSxVh8hCHG0X91j84zZHd8jtr
	ctjompo4u0+3fxqU9mqi6RQqMd0atpMh/eDgWdFwU73fchmbIcQKi9gtejHRpCqS72naZrGkOLT
	20h+/rrsYCmsODi4Z72aPBRQ2MUCLLm0dL1f2xcZOx+ACxT1sdCulblY6QsRXjcFqgj88dP7DNO
	yJEFfbt8g04qIUdzrmt+tjjUOLpnnIHWrzEjePo+t74ly8kl6oNXwkLa0Y2e7XoPzLo2Vugd2d2
	XzP6IXkk77Vjal/2pbugsJlgXKLuglOs4APMu2XXGcQcZkBvKsluPTUSzCe8P33vgcurNeSDXMB
	8hgP3j7TCW5tFjWymWRRmMUlI2cbR5ZaQtZyR5kwSBeX4EmClajMSQOXIP5Q6q1fQ5VsHA1gqbC
	NFvl4ceOf8gSAX+uW+vqDoejtizBMk3c8XTz+rYU7p1xWc68ZP1Z5bEt6R9IOxWbbVrMLIvrR4=
X-Received: by 2002:a05:690e:bcf:b0:670:f743:6eb0 with SMTP id 956f58d0204a3-67163308531mr1104854d50.98.1789578397657;
        Wed, 16 Sep 2026 10:06:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91240419385sm18155266d6.10.2026.09.16.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:06:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] libselinux: fix incorrect regexp anchoring
Date: Wed, 16 Sep 2026 13:02:28 -0400
Message-ID: <20260916170227.74181-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As identified in #544, libselinux anchors the pathname regexes by
prepending a ^ and appending a $, which will produce the wrong result
for a regexp like /foo|/bar. #544 also notes that we should be using
PCRE2_DOLLAR_ENDONLY/PCRE_DOLLAR_ENDONLY when compiling the regexp to
avoid matching a pathname with a trailing newline.

Move the anchoring into the regex backend. For PCRE2, set
PCRE2_EXTRA_MATCH_LINE (as used by pcre2grep -x and GNU grep -Px):
pcre2 wraps the pattern in ^(?:...)$ after parsing it, so a top-level
| is grouped without shifting user backreference numbers, an unmatched
parenthesis is still rejected with an offset that points into the
input, and mode changes like (?x)#... or an unterminated \Q inside the
input cannot swallow the appended anchor. Set PCRE2_DOLLAR_ENDONLY so
the injected $ matches only at the end of the
subject. PCRE2_EXTRA_MATCH_LINE composes with PCRE2_PARTIAL_SOFT and
with JIT compilation, so selabel_partial_match() is unaffected. For
the legacy PCRE1 back end, anchor with ^(?:...)$ around the input
string.

compile_regex() no longer needs to build an anchored copy of the
string.

Reported-by: Stephane Chazelas (@stephane-chazelas)
Suggested-by: Stephane Chazelas (@stephane-chazelas)
Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 follows further suggestions from the issue reporter to use
PCRE2_EXTRA_MATCH_LINE, thereby obviating the need for building
an anchored copy of the regex string in the PCRE2 case. It
therefore moves the anchoring into the regex backend where we
can handle it differently for PCRE1 vs PCRE2. It also updates
the selabel_file.5 man page accordingly.

 libselinux/man/man5/selabel_file.5 |  8 +++-
 libselinux/src/label_file.h        | 23 ++--------
 libselinux/src/regex.c             | 73 ++++++++++++++++++++++++++++--
 libselinux/src/regex.h             |  3 ++
 4 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 679a3f0e..34a17351 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -129,8 +129,12 @@ An entry that defines the path to be labeled.
 May contain either a fully qualified path,
 or a Perl compatible regular expression (PCRE),
 describing fully qualified path(s).
-The only PCRE flag in use is PCRE2_DOTALL,
-which causes a wildcard '.' to match anything, including a new line.
+The regular expression is anchored at both ends,
+so the whole path must match; a leading ^ or trailing $ is not required.
+The PCRE flags in use are PCRE2_DOTALL,
+which causes a wildcard '.' to match anything, including a new line,
+PCRE2_DOLLAR_ENDONLY, and PCRE2_MATCH_EXTRA_MATCH_LINE,
+which apply the anchoring.
 Strings representing paths are processed as bytes (as opposed to Unicode),
 meaning that non-ASCII characters are not matched by a single wildcard.
 .RE
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index a42e2aef..a4f1d4b5 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -403,7 +403,6 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 			 size_t errbuf_size, bool jit)
 {
 	const char *reg_buf;
-	char *anchored_regex, *cp;
 	struct regex_error_data error_data;
 	size_t len;
 	int rc;
@@ -449,7 +448,6 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 	}
 
 	reg_buf = spec->regex_str;
-	/* Anchor the regular expression. */
 	len = strlen(reg_buf);
 	/* Use a sufficient large upper bound for regular expression lengths
 	 * to limit the compilation time on malformed inputs. */
@@ -460,23 +458,12 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 		errno = EINVAL;
 		return -1;
 	}
-	cp = anchored_regex = malloc(len + 3);
-	if (!anchored_regex) {
-		__pthread_mutex_unlock(&spec->regex_lock);
-		snprintf(errbuf, errbuf_size, "out of memory");
-		return -1;
-	}
 
-	/* Create ^...$ regexp.  */
-	*cp++ = '^';
-	memcpy(cp, reg_buf, len);
-	cp += len;
-	*cp++ = '$';
-	*cp = '\0';
-
-	/* Compile the regular expression. */
-	rc = regex_prepare_data(&spec->regex, anchored_regex, &error_data, jit);
-	free(anchored_regex);
+	/*
+	 * Compile the regular expression; anchoring is applied by the
+	 * regex back end.
+	 */
+	rc = regex_prepare_data(&spec->regex, reg_buf, &error_data, jit);
 	if (rc < 0) {
 		regex_format_error(&error_data, errbuf, errbuf_size);
 		__pthread_mutex_unlock(&spec->regex_lock);
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index d6b5bf02..9e3b2bb3 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -41,7 +41,9 @@ static pthread_once_t match_data_key_once = PTHREAD_ONCE_INIT;
 static int match_data_key_alloc_failed = 0;
 static int match_data_key_created = 0;
 static pthread_once_t once = PTHREAD_ONCE_INIT;
+static pthread_once_t compile_context_once = PTHREAD_ONCE_INIT;
 static pcre2_match_context *match_context;
+static pcre2_compile_context *compile_context;
 static char arch_string_buffer[32];
 
 /*
@@ -86,19 +88,58 @@ struct regex_data {
 	pcre2_code *regex; /* compiled regular expression */
 };
 
+static void compile_context_init(void)
+{
+	pcre2_compile_context *cctx;
+
+	cctx = pcre2_compile_context_create(NULL);
+	if (cctx) {
+		pcre2_set_compile_extra_options(cctx, PCRE2_EXTRA_MATCH_LINE);
+		compile_context = cctx;
+	}
+}
+
 int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		       struct regex_error_data *errordata, bool jit)
 {
+	pcre2_compile_context *cctx, *tmp_cctx = NULL;
+
 	memset(errordata, 0, sizeof(struct regex_error_data));
+	*regex = NULL;
+
+	__selinux_once(compile_context_once, compile_context_init);
+	cctx = compile_context;
+	if (!cctx) {
+		/*
+		 * One-time init failed (OOM); retry per call so a
+		 * long-running process is not left permanently unable to
+		 * compile file context entries.
+		 */
+		tmp_cctx = pcre2_compile_context_create(NULL);
+		if (!tmp_cctx)
+			return -1;
+		pcre2_set_compile_extra_options(tmp_cctx,
+						PCRE2_EXTRA_MATCH_LINE);
+		cctx = tmp_cctx;
+	}
 
 	*regex = regex_data_create();
 	if (!(*regex))
-		return -1;
+		goto err;
 
+	/*
+	 * PCRE2_EXTRA_MATCH_LINE anchors the pattern as ^(?:pattern)$
+	 * inside pcre2 after parsing, so a top-level | is grouped, an
+	 * unmatched parenthesis in the pattern is still rejected, and
+	 * (?x)/\Q inside the pattern cannot swallow the anchoring.
+	 * PCRE2_DOLLAR_ENDONLY makes the injected $ match only at the end
+	 * of the subject.
+	 */
 	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
-					PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
+					PCRE2_ZERO_TERMINATED,
+					PCRE2_DOTALL | PCRE2_DOLLAR_ENDONLY,
 					&errordata->error_code,
-					&errordata->error_offset, NULL);
+					&errordata->error_offset, cctx);
 	if (!(*regex)->regex) {
 		goto err;
 	}
@@ -111,9 +152,11 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	if (jit)
 		(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
 
+	pcre2_compile_context_free(tmp_cctx);
 	return 0;
 
 err:
+	pcre2_compile_context_free(tmp_cctx);
 	regex_data_free(*regex);
 	*regex = NULL;
 	return -1;
@@ -373,15 +416,37 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		       struct regex_error_data *errordata,
 		       bool jit __attribute__((unused)))
 {
+	char *anchored, *cp;
+	size_t len;
+
 	memset(errordata, 0, sizeof(struct regex_error_data));
 
 	*regex = regex_data_create();
 	if (!(*regex))
 		return -1;
 
-	(*regex)->regex = pcre_compile(pattern_string, PCRE_DOTALL,
+	/* Anchor as ^(?:...)$ so a top-level | stays inside the anchors. */
+	len = strlen(pattern_string);
+#define REPREFIX "\\A(?:"
+#define RESUFFIX "\\E)\\z"
+#define REPREFIX "^(?:"
+#define RESUFFIX ")$"
+	anchored = malloc(len + strlen(REPREFIX) + strlen(RESUFFIX) + 1);
+	if (!anchored)
+		goto err;
+
+	cp = mempcpy(cp, REPREFIX, strlen(REPREFIX));
+	cp = mempcpy(cp, pattern_string, len);
+	cp = mempcpy(cp, RESUFFIX, strlen(RESUFFIX));
+	*cp = '\0';
+#undef REPREFIX
+#undef RESUFFIX
+
+	(*regex)->regex = pcre_compile(anchored,
+				       PCRE_DOTALL | PCRE_DOLLAR_ENDONLY,
 				       &errordata->error_buffer,
 				       &errordata->error_offset, NULL);
+	free(anchored);
 	if (!(*regex)->regex)
 		goto err;
 
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 4cda7bfc..f5499fad 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -71,6 +71,9 @@ void regex_data_free(struct regex_data *regex);
  * a pcre2_match_data structure of appropriate size to hold all possible
  * matches created by the pattern.
  *
+ * The pattern is anchored to match the whole subject string, so callers
+ * must not add their own ^/$ or \A/\z.
+ *
  * @arg regex If successful, the structure returned through *regex was allocated
  *            with regex_data_create and must be freed with regex_data_free.
  * @arg pattern_string The pattern string that is to be compiled.
-- 
2.55.0

