Received: from mail-qv2-f17.google.com (mail-qv2-f17.google.com [74.125.230.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D04C6522
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579712; cv=none; b=VAfljxAmoZTxOSNNBPAjhwi09GC4N4WeRitBpReYo5Kp7hq7t34PrrtWousRZN5spOOdgymwPvaSdMGtnMZNH/bY4CZzB42GtE762j3rwKmv14NjnVpzONKFRhz9mFGYy5e7v8cO0xTslrQxcRTvtoctH8U0nrKgAhh+mgKTdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579712; c=relaxed/simple;
	bh=IdE31JSQKHKiez4ZILBytPo32IQY5+Ub3KmtCJD6lxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0yJcbz7A4T9nxrFjMv5MnINVs9X3fDBQ53GvHP3hpgffzZrv2HEuZdFvHzHHp4a4VFqxndOP1aXEFFheGUl1RqRaijLZ7fFUlznHaY6vTgVwfK6NBrKAl/6/PeMtYZZoRs++Fg0fZklvB6jb3N8avq8FYDFRwHxVszcAf38+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGkM2KJk; arc=none smtp.client-ip=74.125.230.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGkM2KJk"
Received: by mail-qv2-f17.google.com with SMTP id 6a1803df08f44-90cdfe57a3aso10774546d6.2
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789579709; x=1790184509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KOyDsfqM5x6DJlFrdxgAJXjJvgXSc6uXiN3kJOMNyg=;
        b=KGkM2KJkJ15ypHCW+ZAdavzZAjafKV4Z9ww9qHAqNaJXGlYXD7V/FNvYBvmwsnMfq/
         Zo7+oXOSROYWBECrHXYysX6ramUCsOAnlsVGhzSeLJDQPJwdYjRXMKB+i6b2Xft5RjJn
         NLz0w+GYpsTZe+I3kW/TaF8HoL0lRoRWTG3dsPHcRDU9bAIyx0PKwJqiwG1NA+VdV4RV
         qmqITzC4HFlOTNd7uZ9lbVRm96fcOZ+CEOfu5g3mG8xo7MS0yi/D9sh9SG2ZvJBYj6yE
         zs/loZI/amPku4WK3oP96cFI5ckJCfH3hRRiZ6BHgt8wIWFH8zTgGlN2XD9e1Dc9PP/m
         7odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579709; x=1790184509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KOyDsfqM5x6DJlFrdxgAJXjJvgXSc6uXiN3kJOMNyg=;
        b=kzQdcBknmxzHVQ0QWI5iIuNkDJFEZlVJmdfu2+3/MGG83wGHNTYNKK4pfJp2B25Nr/
         4qpHOZn9xNDswcH2wkw1+ZpLVkAfGEvkZsUtb2TMiU1a55nQttClsCZGZTzyxUTcPHGI
         NiFX7d+H2G1/L1AnCWw1egkxELVjCx8ucUvuNP+j9ZgtT/o0iExZhULdLZEhT8XJXDG9
         qwS5gQCaEQzFUA/lmw68sjyuu7ldS88uEi7Mre4DiFOnTzqgu0xufhV8vJcU9Wkcv903
         gzrEV9FKWUf0x8nounyd/MQW0KsW597k6yxNE0b5uCvCaA756vZm5pA6X4dUHutk+CtX
         YlUg==
X-Gm-Message-State: AFuF++kMCabUqGO/2BiVSuQDdH1dah83+tySvQ6lj9+4q1fbrpJgtOZa
	j1eRWsIkYHDBdAE/lmTMCzn75wo30Y8swHPaYkOx9LVFQ9h1LOoJqpcPaUB3PQ==
X-Gm-Gg: AYBFou25+XPusF9Nibd94oLig4ySAuf5soxGrIhpnnkRNxoq21yK4ClUWtH5/JC0An0
	0KZNwjwqzziQMZ+jMfThxQjal1EHpcFru3GmQ1xj7MO4f6SdomEcXTJgj4XIFipG6WPRGEliCb/
	AQTNX2jOo7KVOxd37ingC8sMijmwAoJ8+1e+edyGlGIM8Yn+J7COLeki+4FSiegLfIQ57AnfYHe
	pqHiztLbOLAuvSsAprXnxnGK4j3weO2wkvWNvyl3lPQmUcPQlcWghysH0qz2MFY4r3Rm/hDp3lj
	N/LLgVC5BhNRskcXYA+LRDAmaYvwXyuOEzOeLTKcG+KeBOT/jqYowL0Tuc4CKUJ4gviVHNht3o5
	89J0cBh7l6k+3KEdR0U+tCv/8VSHzjfznrIsj72FvrDzERi6pM+q4cr8R8dRnHUDM2VAR+Yn3N7
	7MhgsUcy1mGFj+3mafAvO2iEvS0BfEtbhvsDj3jeioVRuATEsbmjR9T0XvjgDcCDr6sIa48SPId
	QgnVajWHXAhhN73ouK+IMUYilMCtmRuvZg2SekHUgr5/sNMgkTllepie510VWKGjThMcCMf3RFs
	B8i4BqynIg==
X-Received: by 2002:a05:6214:529c:b0:910:44e8:e643 with SMTP id 6a1803df08f44-9123d754448mr58958336d6.15.1789579708994;
        Wed, 16 Sep 2026 10:28:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be9ca82sm30053746d6.32.2026.09.16.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:28:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5] libselinux: fix incorrect regexp anchoring
Date: Wed, 16 Sep 2026 13:26:03 -0400
Message-ID: <20260916172602.74725-2-stephen.smalley.work@gmail.com>
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
with JIT compilation, so selabel_partial_match() is unaffected.

For the legacy PCRE1 back end, anchor as \A(?:...\E)\z so a top-level
| stays inside the anchors, a trailing newline in the subject is not
matched, and a pattern ending inside \Q does not swallow the closing
group and anchor. PCRE1 has no equivalent of PCRE2_EXTRA_MATCH_LINE,
so an (?x)#... comment at the end of the pattern will still consume
the suffix; that case is left unhandled on this legacy path.

compile_regex() no longer needs to build an anchored copy of the
string.

Reported-by: Stephane Chazelas (@stephane-chazelas)
Suggested-by: Stephane Chazelas (@stephane-chazelas)
Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v5 fixes a mixup about the anchoring prefix/suffix to use for
the legacy PCRE1 case; use \A(?:...\E)\z instead as the safer
and more precise expression.

 libselinux/man/man5/selabel_file.5 |  8 ++-
 libselinux/src/label_file.h        | 23 ++-------
 libselinux/src/regex.c             | 78 ++++++++++++++++++++++++++++--
 libselinux/src/regex.h             |  3 ++
 4 files changed, 88 insertions(+), 24 deletions(-)

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
index d6b5bf02..483f92e6 100644
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
@@ -373,15 +416,42 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
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
+	/*
+	 * Anchor as \A(?:...\E)\z so a top-level | stays inside the anchors,
+	 * a trailing newline in the subject is not matched, and a pattern
+	 * ending inside \Q does not swallow the closing group and anchor.
+	 * PCRE1 has no equivalent of PCRE2_EXTRA_MATCH_LINE, so an (?x)#...
+	 * comment at the end of the pattern will still consume the suffix;
+	 * that case is left unhandled on this legacy path.
+	 */
+	len = strlen(pattern_string);
+#define REPREFIX "\\A(?:"
+#define RESUFFIX "\\E)\\z"
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

