Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE433644A0
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581590; cv=none; b=iH7WoTiKZDPOcNPy0N1b4Sd+1wibR8minkJf/bPdThjlLTBm5vrykzEMBJeYzMNWTZWYUrX0uciFOIB/WPr0wNOn6Q8jqrggFwgr44/JkbFQGrN19ic6HFvf57zvfhGfT7aIN9lJ/vZkS34j3Ca5nZxChseYe6el0vMAvBU9w7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581590; c=relaxed/simple;
	bh=Nb6T/U9faxyHSOzTBopYUn2X/Z554OO2Gsip9r22XJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ft6hZo0VFbUrVzSTk/U5jASt04X7pzQWbRgPJGsCE18c6BgLaRkoEBvMUs0cJeUmy+cJDi0ECDHKTNp+tiwlVbij8szabmAWUkkJ0F3RGR9bl7m/hNtyHTO6wb8n4F22b5NChpgE1ttGMIvoQp8XP6Zf0thBHf9z+yAlGVKcuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQbQ3XxC; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQbQ3XxC"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadea2so93016885a.2
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789581564; x=1790186364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6GNxLpEYDfbqch7uL5gsAGsCKSfLeyRtPGl9OQd9n8=;
        b=mQbQ3XxCv+wHoshdX16PqgLTK8MQfgGtUA+Xb58/D0dgjRRkDTKJwWALAPi3J6FcCr
         /owIk3PFPhw9zmt8erEIRPP79EpBzQbnfY+a24L5MSURvtxpLpe/2B3JY5yqtM1r3krY
         l0KgSHF/u5bwV/XyBGdQIRbTLGfvkAEfGEoP9IcLhk1SK7UITfi5dRmXTq6RXeym3Cc0
         YsKxU4hpzKWuy4eOvmig574J3z+KQdwGBMuhM7sqT4011kzyLcx8nCP9xu8Q5dDi1Hx5
         ZPZY7y92Aj506AyqwiYhFSFdJNoOHGZbKytqAh5E74P6cQls5ZDHJTGONiqJPYI6XMn5
         DuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581564; x=1790186364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6GNxLpEYDfbqch7uL5gsAGsCKSfLeyRtPGl9OQd9n8=;
        b=sYGNpFWnwQAUglgtrLPpHI4Rt7IYfABbdmcnup2l4ixaEAWD33lreppunMdJZeuSSC
         XuYlgT5+mve4nd8vqGoBfRKkiCmSpnaWQtDmVJrxo8WdNfKt/J/mp2+ho56k9LgOwTzC
         Q36DEew0j5mBZHC5IidFNx08uiJ3DdGsx9Sbf3YPzmKRKUIU2sQJpQNpz0zdW37mvvqZ
         Tdgn75zKUVTZBKWz5MSkl9h/lspbuPkXEnqn9h9RcTr/Jk+jSImxvDMd/rt+4tQcCvPo
         K+WGapPu80XnUTRuXdbp2vf9sonHs3l2zrpj/XaFcXQfmHaPn337ZxFN7DpOf/5E/WJJ
         bIBg==
X-Gm-Message-State: AFuF++mkpDqQX2IEeAt8+Yuq/hrd+t54y4OyaJj57e2R8bqzQMME3ule
	NVr4pM60RNcyGUw5724yYtUX0oO09/3OQyysUFmg29B7vR2a+1ciONfatO7ITg==
X-Gm-Gg: AYBFou09Hq3RvevuMuJUNXDKhu0SQwg2e99/pYogYbf7weLOrL0CC4zO4M+cAD7pTTT
	K9Ipy3juifgPa/gurY3xpVrItDdZ4fcfLV6GkRslUVkaSGTvMQfnkhv0wH+rDMSeS9j40O2lbMm
	ghnauzgz5+rw7w0Oy/eKnxYaBhm8+6shpFMKSx2KsQlKldzwBL7fTEvY2seGuVYRtNqLUpzdnvf
	baFksJHbmBzJsKogJ51OU7CS9htMfF1LS5D9eL1NeBW2R96Mft5/3R0kat5uYlGWyaoxheYNF4Y
	605UNrMRv12b60F5cqwT7WUb9UXpmLl86JzWj4UPAFqhwfmYNLJxfp6ffAKA5FG+TMGHexUSSfO
	RKak1Y/Lz0OR0TCO0G2C54IHW4NBlM/Ur3uaWTuOEy8PcqjSLYNznfWcp89eZ86PACYDT7rjqUl
	dfvyAVEmJf/JrePbrxhff1u7fz6E54//7k6DLbqoU03xEcUCCddvsbs1LR/PpSheHZRfZyZlzx7
	zOLUitEGbk2f2TYtnpDXwwvobYG1Zus3k7wOCLH4AKq7E1WuA87Lizz8GOyBiFuvwCzwGP0XLE=
X-Received: by 2002:a05:620a:2a05:b0:937:6900:a7ae with SMTP id af79cd13be357-93bb77ac6famr602175585a.15.1789581563620;
        Wed, 16 Sep 2026 10:59:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91240419385sm19190996d6.10.2026.09.16.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:59:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6] libselinux: fix incorrect regexp anchoring
Date: Wed, 16 Sep 2026 13:58:48 -0400
Message-ID: <20260916175848.74978-2-stephen.smalley.work@gmail.com>
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
v6 fixes the missing initialization of cp in the pcre1 code.

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
index d6b5bf02..deadcc6f 100644
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
+	cp = anchored = malloc(len + strlen(REPREFIX) + strlen(RESUFFIX) + 1);
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

