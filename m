Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE149DB8F
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416105; cv=none; b=MjurJw9LHojvITK3Wyj0EFVZecGXHZgFHBZDqm0PYq+U3m9R4Y2pMMjCbFeMM3Oi1STVSgk/0IpvZJh835b5B7EPZ3B+Arg5mQZmXtBLbdaIqZmiROoSgIYUfaMXXvieCRtjPMZbnh50xGirhIctifAupQ1fySnoG4AbqDK4Pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416105; c=relaxed/simple;
	bh=7tgSYru+paLZFu4Ul1WMEfLV+iyin5kUhUrwjVbjpg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqRZSQh/2xQ9VIJp2NbWxhn6o3Mtk312TH01niwxEFb9t1RcjEtV0+/VuEhz1XvmcjEsgw+WPPoXCPSUknU9uF5DUtC5r0QDG2YGG56B2pZ2QB1DEgLRREDDN/8M4JGgOdexR1+CwkQrpaAS4FmO4L0nQJ5G6v4Upuq9doORAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaETKctQ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaETKctQ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939eb3249c1so311308785a.2
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789416099; x=1790020899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9QR9Cjz24ViKvlOA2EuxflubFxzUVYYoMeC9hEDulI=;
        b=DaETKctQsIChL07IwST7oSo1MwI595gQMJ4eLyMaxfSj5Rv2c/J9rzesBWrNmh6Ox2
         iFW0tMXBLi+5WPagmUzht/7Z2WepWxor+wVEZLbO6qna1EalN8wadJLKT2B+OdDD4Pz1
         wkmwYUx2LMsAgzwSHcz5SF4YKHP2PEPVjptE+87MHQqcDQZaL8tj/IBmlLSWCL5/QgJL
         UeVASUYgg7xV7Q3gKb9/O9oaMnen0mny5zrEd1wQAHltNB7ftgAR0RwHlJORyCz3sf0Z
         TCR0WNcBFPU5M65bnquHxBhtIsH6pOkEpjYM5saZ5X7yfQSWu4mbJlYHLB333v1lD/zx
         N9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416099; x=1790020899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9QR9Cjz24ViKvlOA2EuxflubFxzUVYYoMeC9hEDulI=;
        b=QUqM1jSIj+N5nwXmkW9W/A0tmHVyMHD1rIh2o5zMaY7j/N1LmnBPCRhvmVeWlS8AM/
         9UTiQz1sTCGNmg5/F0zkrKpSDDZm/a91hXJVEE5fQDA/G6a2t56+ozVEk9DYXJyNtYps
         tx1513m3aNm3bJzoep16gCBbzBkQ0tjk+A+60oW6t6DaulkeZJz995xeWUMxCOiyodDG
         g24Im7F0NGfBj3BYwMKBZ31nDqS900xXDwMV+Tf9R/DOyrCAKuDWtb6p3ZjHnzxir35Z
         WVVwse0idr6p+K5lDZqhIZRrqidcfl/QemxokoJxEigTPBcq8ETNKUxzA/twHZ4kFwKm
         Lfog==
X-Gm-Message-State: AFuF++mZFBZbZwiY3WZxF9bM8OFCohutlUQt7ruwMJJB0Vp9m2Epz3sS
	Wksqdd4KeFejDsZbW4UCUzZoKipTaxSyfP41sD3+DLB63X9Igc6RQR55JkqJBw==
X-Gm-Gg: AYBFou2AILXNY+QP/0Tu/02kZ5ikm1knQCH7irA+zSRGhExxquXuKJ5er6kXkJvz/Cp
	0SwQdtXDBkp1HQaAcOJMPEDrf913prjgBBsRe4qOceb4vP4B5SEwQuS6m9gQRJWhnWoUlt4E+ug
	CqHLTpuHZAGGweAZfPtV+X9oIG9OZOZZwYXvhK6XdxhWZ9p3yBIWqgI/RGzVQNNdBHSH5LcOwn8
	5CyJaFWdYqmYBG9LOIkoEPJvgzZH+dDS7uUivp8fHyd1W6+E5P9sSq/NPSiYkqCY+pj6c54sjUO
	H6P1c0H2kpowx2PIRLivxskB1GN2lOHgAphWlqWbZzmsloa7/CHFZ8CZrUZF2wgjg4/XkNPuwM0
	r/LaM/gUDPrE00lHHNtZNShqUHARxv9o4CwgPQoYP7ZXzqzz/8z/anr8DIwv0OEAoHS/dZrguZZ
	yaM+dTJej/rWaDx+Z4W/H7z0XjzIFkVchsTHt4jkWIdspFvHbRzrvfiCmIlba109DS3+W4KI35a
	HnJz/JM3qVVV6kFycBvIEXmFgyBL0K9WObNEuocoasix/c7Q4Gykyp0dD3ujgPUL4phkcbWyX0=
X-Received: by 2002:a05:622a:4d8c:b0:530:e502:4bfe with SMTP id d75a77b69052e-5310d03eec8mr70751201cf.38.1789416099357;
        Mon, 14 Sep 2026 13:01:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-531140cc8b1sm15136781cf.31.2026.09.14.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:01:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libselinux: fix incorrect regexp anchoring
Date: Mon, 14 Sep 2026 16:00:03 -0400
Message-ID: <20260914200002.33399-2-stephen.smalley.work@gmail.com>
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

Wrap the input in \A(?:...)\z instead: the non-capturing group keeps a
top-level | inside the anchors without shifting user backreference
numbers, and \z (unlike $) never matches before a trailing newline.
PCRE2_DOLLAR_ENDONLY is set as well so that any $ inside the input
pattern is tightened the same way.

Because the added (?: and ) can pair with an unmatched ) or ( in the
input, an entry that used to fail pcre2_compile() with "unmatched
closing parentheis" would now compile as a different pattern. Reject
an unmatched ) before wrapping so that malformed input keeps failing;
an unmatched ( still fails inside pcre2_compile() on the wrapped
string.

PCRE2_ANCHORED|PCRE2_ENDANCHORED at compile time would avoid the
wrapping entirely, but a pattern compiled with PCRE2_ENDANCHORED
returns PCRE2_ERROR_BADOPTION for PCRE2_PARTIAL_SOFT and passing
PCRE2_ENDANCHORED at match time bypasses JIT, so neither is usable
here given selabel_partial_match().

Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 rejects an unmatched ')' before wrapping so an entry that failed
pcre2_compile() before does not silently start compiling as a
different pattern, explains why PCRE2_ANCHORED/ENDANCHORED cannot be
used, and #undef's REPREFIX/RESUFFIX after use.

 libselinux/src/label_file.h | 68 +++++++++++++++++++++++++++++++++----
 libselinux/src/regex.c      |  6 ++--
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index a42e2aef..8e1f1932 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -399,6 +399,50 @@ static inline void sort_specs(struct saved_data *data)
 	sort_spec_node(data->root, NULL);
 }
 
+static bool regex_no_unmatched_close_paren(const char *regex)
+{
+	const char *p;
+	int depth = 0;
+
+	for (p = regex; *p; p++) {
+		switch (*p) {
+		case '\\':
+			if (p[1])
+				p++;
+			break;
+		case '[':
+			p++;
+			if (*p == '^')
+				p++;
+			if (*p == ']')
+				p++;
+			for (; *p && *p != ']'; p++) {
+				if (*p == '\\' && p[1])
+					p++;
+				else if (p[0] == '[' && p[1] == ':') {
+					const char *q = strstr(p + 2, ":]");
+
+					if (q)
+						p = q + 1;
+				}
+			}
+			if (!*p)
+				return true;
+			break;
+		case '(':
+			depth++;
+			break;
+		case ')':
+			if (depth == 0)
+				return false;
+			depth--;
+			break;
+		}
+	}
+
+	return true;
+}
+
 static int compile_regex(struct regex_spec *spec, char *errbuf,
 			 size_t errbuf_size, bool jit)
 {
@@ -460,19 +504,31 @@ static int compile_regex(struct regex_spec *spec, char *errbuf,
 		errno = EINVAL;
 		return -1;
 	}
-	cp = anchored_regex = malloc(len + 3);
+
+	if (!regex_no_unmatched_close_paren(reg_buf)) {
+		__pthread_mutex_unlock(&spec->regex_lock);
+		snprintf(errbuf, errbuf_size, "unmatched closing parenthesis");
+		errno = EINVAL;
+		return -1;
+	}
+
+#define REPREFIX "\\A(?:"
+#define RESUFFIX ")\\z"
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

