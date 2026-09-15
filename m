Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5039EF0B
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484902; cv=none; b=HdFxGGKv3Q1XrZv3NAmq2BptIpmLFCF5KAYXT24EtsP0yZq6E7tjWQo+AKnPTPoa31bemb5lVd1g9CUq4ggjEMxpIORIuso0bULli99P+xUor3n9jo01EqpSJkiuy7oRYH8M0I3i0ev/AZSCyEN/iLT/hYSrfxzbIkLyEVtuFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484902; c=relaxed/simple;
	bh=GEcszAonAs5PAxDlnbXNrFO5UnrZ/I9Hmig05ASP6U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLwDcx8aJDwFUG54Y3CnoS78FujYMq9kpMkp5G+mFMigFuUlteFfT7NS1M4v27ZbLDHgAR/sIayrdwWKx4m+e0ARGlEJE2N4LcrdXZQAduPjcqIy3s3L3DCh/45yWknn1wRqzdOBSItYEMflam73OtMMtFxWCXdDwlS2mxGvrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsYimA/I; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsYimA/I"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe20aso40337086d6.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789484899; x=1790089699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+cWeYWx/gboxtOfMLvGCFyeMy0MyP5mCvu6LNzSEinA=;
        b=hsYimA/IcUhntwr/6c0oLoBNpEUQ0GWAXZtrghJIlEI4QqMzqKjsBx1udKaJKsBtJW
         BcTQTyey3RiZsq6EelzSe5RJhveuCG40Z27lc3pPF7Ygq7ounRH8HcsV5Wy4WGim38EF
         Ds8IM3esYjslsiYOvRdI7OvnWl59JPiaUhnScnvVNd41jL113PYxHMxP7l5AqLF1fvYL
         cFHo4fQmQqtrGmsOBjN8zDRkPr62D6v3TSw/cwiKTR76xiqzGUojJTWP+nIDk5yJzAUs
         SHBRJJsH9yddnwkiEqSNb01OG8H62npP6LcTEY9CtUZ+jJzD5nb8HvCEbjWWz96sFC7m
         OHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789484899; x=1790089699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cWeYWx/gboxtOfMLvGCFyeMy0MyP5mCvu6LNzSEinA=;
        b=rcdviuPt465phcpjt0VHuWNfCxm5wrM01laoIYYhGzx4BV8mtt5KenGjhNKQKyPZc/
         SRIxXXEBx/b3Bx8yn0pnppIim0EzE6mvL5L23YbDb63+VEhSeAPZE5mIBi64YRTkQJYq
         jyK/uKc4R6nTSynm3UyDxTLuz0vV4UrrbWtPsOGGOxJMPrfQkaZ9NhN+iWYOS7otNIAV
         DFlud2EpPMjZN2ZfLQMt5YDD9Vw3wHXKHoc9UbXrVsGyQw8OlkxHKkOJD6G+AcfR8or3
         SR4X1H6nwWcd7O2mootEiNh6sTdn9+EZ2ymg4HJhr5rsPu0Cr2vktn3C8RPpLe/gb4oZ
         gAWQ==
X-Gm-Message-State: AFuF++mC9tFrS0AjxtFc+oShp/Mz4ph2uH73uQ1BQsQ+5K08H6yF3X75
	Xdxxp+Kl+X5Mqu4Ps/coyVuHgHsVTb7FDyycUtjuMtevP9prS5zl2eQpeiI0cw==
X-Gm-Gg: AYBFou0TmcjnmZVV4UCJPcLwUHQUj1F5HvvSlAc63hW6Uzez7kLUxjtEQcNLkf+PS4O
	/OG4FT4xDgQhB5+e4qgTmgTc1i65GdXfOjIAjrZqfPa13rdouGGEWHHakdgluIlhy4tpuirM9ky
	3CD6jh6OzGPsCwd1ErAuz3YOzWUM52DuJKPNOJor+yRx4CgC82iELUb/nfaA8Xfyz8lnACC/jMO
	UrgMZc/+vo04mwUMlBfaiS17M36uU+tpXA5U9g4NBDu7SeSRCiejY5CcNlAITUYovwZ+dBFXW4/
	oH1+bFCUTR89EfJImrx7AzppK2UY+MqfA4VO9+QR5pH9F2hCj8kIGS9fOmJdjorJTb/avYX2ePc
	zdWRRa84gyMXbP5IF/14gX+TalDt9jfkjdJAKmY1pxhkeCZKjNatiEM5DbJEqDKEHEn1aMsYrwD
	GQKKGkGEH3q66/zNIHlmSJGUdJYnXx8UDZiF6uqN0mzJ0HCQMhZ8M9uI8gSjbVhrVChKL07xBfP
	j1NN826U1W+7NDUU1WrhjQvd1evv924nD7Td3a5QkfLOE9osY1EL4bLLjjalNDoRcgPR+AiJY4=
X-Received: by 2002:a05:6214:8613:b0:90e:8424:4068 with SMTP id 6a1803df08f44-9122e55cee9mr124676086d6.24.1789484899252;
        Tue, 15 Sep 2026 08:08:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c885sm642396d6.21.2026.09.15.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:08:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] libselinux: fix incorrect regexp anchoring
Date: Tue, 15 Sep 2026 11:04:23 -0400
Message-ID: <20260915150422.41797-2-stephen.smalley.work@gmail.com>
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

Wrap the input in \A(?:...\E)\z instead: the non-capturing group keeps
a top-level | inside the anchors without shifting user backreference
numbers, and \z (unlike $) never matches before a trailing newline.
The \E before the closing ) is a no-op unless the input ends inside an
open \Q, in which case it closes the quoting so the added ) and \z are
not swallowed. PCRE2_DOLLAR_ENDONLY is set as well so that any $
inside the input pattern is tightened the same way.

Because the added (?: and ) can pair with an unmatched ) or ( in the
input, an entry that used to fail pcre2_compile() with "unmatched
closing parenthesis" would now compile as a different pattern. Compile
the un-anchored input once first and report any error from that; this
also gives error offsets that point into what the user wrote rather
than into the wrapped string. On a validating open of a
refpolicy-sized file_contexts (~5800 entries) the extra compile costs
~3-4ms.

PCRE2_ANCHORED|PCRE2_ENDANCHORED at compile time would avoid the
wrapping entirely, but a pattern compiled with PCRE2_ENDANCHORED
returns PCRE2_ERROR_BADOPTION for PCRE2_PARTIAL_SOFT and passing
PCRE2_ENDANCHORED at match time bypasses JIT, so neither is usable
here given selabel_partial_match().

Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 drops the custom regex parenthesis matching function and just
performs a regex_prepare_data() on the original regex string before
anchoring to provide full validation and accurate error reporting,
and adds a \E before the closing ) to prevents a \Q in the input
from swallowing the suffix.

 libselinux/src/label_file.h | 34 ++++++++++++++++++++++++++++------
 libselinux/src/regex.c      |  6 ++++--
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index a42e2aef..01f53238 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -405,6 +405,7 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 	const char *reg_buf;
 	char *anchored_regex, *cp;
 	struct regex_error_data error_data;
+	struct regex_data *tmp_regex;
 	size_t len;
 	int rc;
 	bool regex_compiled;
@@ -460,19 +461,40 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 		errno = EINVAL;
 		return -1;
 	}
-	cp = anchored_regex = malloc(len + 3);
+
+	/*
+	 * Compile the input as-is once, so an entry that is invalid on its
+	 * own (e.g. unmatched ')') is rejected here rather than being
+	 * silently made valid by the (?:...) added below. Report the error
+	 * against the unanchored string so the offset points into what the
+	 * user wrote.
+	 */
+	rc = regex_prepare_data(&tmp_regex, reg_buf, &error_data, false);
+	if (rc < 0) {
+		regex_format_error(&error_data, errbuf, errbuf_size);
+		__pthread_mutex_unlock(&spec->regex_lock);
+		errno = EINVAL;
+		return -1;
+	}
+	regex_data_free(tmp_regex);
+
+#define REPREFIX "\\A(?:"
+#define RESUFFIX "\\E)\\z"
+	cp = anchored_regex =
+		malloc(len + strlen(REPREFIX) + strlen(RESUFFIX) + 1);
 	if (!anchored_regex) {
 		__pthread_mutex_unlock(&spec->regex_lock);
 		snprintf(errbuf, errbuf_size, "out of memory");
 		return -1;
 	}
 
-	/* Create ^...$ regexp.  */
-	*cp++ = '^';
-	memcpy(cp, reg_buf, len);
-	cp += len;
-	*cp++ = '$';
+	/* Create anchored regexp.  */
+	cp = mempcpy(cp, REPREFIX, strlen(REPREFIX));
+	cp = mempcpy(cp, reg_buf, len);
+	cp = mempcpy(cp, RESUFFIX, strlen(RESUFFIX));
 	*cp = '\0';
+#undef REPREFIX
+#undef RESUFFIX
 
 	/* Compile the regular expression. */
 	rc = regex_prepare_data(&spec->regex, anchored_regex, &error_data, jit);
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index d6b5bf02..a76f29ce 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -96,7 +96,8 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		return -1;
 
 	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
-					PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
+					PCRE2_ZERO_TERMINATED,
+					PCRE2_DOTALL | PCRE2_DOLLAR_ENDONLY,
 					&errordata->error_code,
 					&errordata->error_offset, NULL);
 	if (!(*regex)->regex) {
@@ -379,7 +380,8 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	if (!(*regex))
 		return -1;
 
-	(*regex)->regex = pcre_compile(pattern_string, PCRE_DOTALL,
+	(*regex)->regex = pcre_compile(pattern_string,
+				       PCRE_DOTALL | PCRE_DOLLAR_ENDONLY,
 				       &errordata->error_buffer,
 				       &errordata->error_offset, NULL);
 	if (!(*regex)->regex)
-- 
2.55.0

