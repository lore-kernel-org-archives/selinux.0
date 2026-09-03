Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608B4FC8EB
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457976; cv=none; b=PFFU93rMB6UuejcP2JQ/GFA4x2qkusjKNWDn/ysiSKppCuLKHI01e9GOj7gDKRUou4ow3WrzPDfM51PxWIftOfl46eWjMSNOFrUDM/yiJlqyvryhMxtv1LVeB+8oLp2il6T4KupI/y6uDbUw5u6SvGM46KN9MY15Cf0TwncYB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457976; c=relaxed/simple;
	bh=4EqhXSHJoxq3HkgWTJW7vTs9BXRVppsejWKnr4q74LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcogkqzcRTWbOnYwI+aoARtTbQCBBqMSZPhdwNaHHMz1eaNsbZc4PfoKKtUZNgrhqudWXH0EGVN9pUDy1agTngWEtV09q8NgUIKn4SuKcVIC0sxtoOGVGlU0wtoxHRCEFgfHvjwPDML8mI744jHYxG4lUFuP0rQcfQm1ur5dddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITaKJnAz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITaKJnAz"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5301a453186so1846761cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457973; x=1789062773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elfcUjCgKaPQzZe+/lmBNqlfrMyhh43rELBHVlF7ut4=;
        b=ITaKJnAzsKqA+OwCYW1GWwf7pZE/yR4CN4ufXVxZO7vBnKCRmiB3ZYwcba8lnmSHHk
         8Ae7ZVgr5vMOHFS2H+7Ghz59MK/laUg1eo3r4LSGM0sGqTOIzCXPOxM5lBk8BaArONPU
         06+UWgtD3cSv1gwwce69UTJXvRirPUoi5n66NkW/+so0eCqkCPTDumYoF3nIzpbh5q0E
         DiNQP7brM2Ib7cU4OfyEu/Ryf3RVXmrElBi++p2gBw3Tfvhl0DkHR4TS6ws64xtLQ0YO
         e/zszOBuvowjDkTQnEbKzfocrQ5PQbcphyE0RL9myqRpPDUIYKUq7QsdPqLCpcgGev66
         MouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457973; x=1789062773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elfcUjCgKaPQzZe+/lmBNqlfrMyhh43rELBHVlF7ut4=;
        b=JVkh/3ge7aqDCoNmMUIHbww9Godarr9yGS5AKB+Wn/sfV05nbPudGt7pL0Qmw7e3ey
         gdBTAj3X7tixTSPvf+SiEjh+iH4CAM7Y7EDOupAuueL/K3DtSTSwaU5WlO7z9lCEg27p
         uhHSOpapZculobq1kDpAaxq0UQ+JpNVSRChoAxxwykDAaE1jLQ3W/D/CpbP4OYhCDqvj
         ljVEGCWdtTmVI2v+UtPykTiuPkOmJn+tagjwXKUXWvjxzlZ38suJOlW74/uPCumiNtnm
         lgu/XJmtechVQdhCE9f4qzh7ZDKaTJi5Y+a3icxlZ2pFfNnAdCOhO+jllVDvr9pd32M4
         dRQg==
X-Gm-Message-State: AFuF++kf0qmybCFQf6c7Pu61/tYni6G7j98zS3cNCCLa/q6McZJTXkwN
	a2ddyv+lbFUnlqrGpBiYG5VzpNmsI+mqnZTvlQYrIqn/XoU+GZ1cySN9MoxvGw==
X-Gm-Gg: AYBFou05fJVQe68++9+MlGrP7iTEQwGXrn1WZU+2c360tgK/4IidKBvpkJ5sJiv2E2X
	QKYIS5phhXAq7Y1lkd1g9VGKhgtPo0G1N4oHqjGVzYipGPXOzOurGOMHwHmLXTG/LSXXnpx5l8Z
	lQ4SN6hdaWqHeLlpLM+4U6iSfFp6dqjyjORMJM5kX+W+glQA9x4VnesaF7TfWi6Kh82wJcasx4S
	raBEKgomOFbn5z75rhmo/xTfKDoFAWnIen8kKtVTyK6B+z9czeUR+8hlth212dX1YOg5hzm1Kfu
	nwHGBbKguP1p8ZGXbX/dJQF6rSGJxNHcltYRI5l/9TY6cmons75ps4ST/Snzx3hIqVSYTDDDWJo
	A+b3AYMZm87MK76m2AdulU3rUL7G9y/g7AeZLlu+PO84y4vB6pCAgJaf+dPjAo7VkYESXgdHfQI
	CvOGnygG0qLD8sUnKsIpErL3RkZqS+FpGT3SQh4o5S5PQ1D4qBnpSqCh6mq7AxKQG8HihVQdz5v
	ayd3BD2aS7MSrkrZgeQT5cahF8ayyt9cmvGuXuz18wzGfKTmHN24j5UzXDuFLj/
X-Received: by 2002:ac8:5989:0:b0:52d:6afd:7db5 with SMTP id d75a77b69052e-5305498d4fbmr5747601cf.25.1788457973307;
        Thu, 03 Sep 2026 10:52:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910405966f0sm35616d6.6.2026.09.03.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:52:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: allow a '*' wildcard in file_contexts.subs_dist/.subs
Date: Thu,  3 Sep 2026 13:52:38 -0400
Message-ID: <20260903175238.21602-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

systemd-sysext and systemd-confext stage extension trees under
{/etc,/run, /var/lib,/usr/lib,/usr/local/lib}/extensions/<name>/ and
{/var/lib,/run,/usr/lib}/confexts/<name>/ and merge them onto /usr,
/opt, and /etc via overlayfs. overlayfs presents the underlying
layer's on-disk security.selinux xattrs, so the staging tree needs the
same labels the merged paths would have. setfiles -r <root> can
already do this per extension, but callers that don't know they are
writing into a staging tree (rpm scriptlets, tmpfiles) run a plain
restorecon and get the wrong label.

The natural place to express this mapping is file_contexts.subs_dist,
but substitution sources are a literal prefix match and cannot express
the <name> component.

Allow a '*' as a whole-component wildcard in the subtitution sources.
Each '*' matches exactly one non-empty component of the input. When the
pattern ends in '*' the substitution only applies when the input has a
further '/' after the matched component so any entry such as:

    /var/lib/extensions/* /

remaps the contents of each named directory but leaves the directory
itself and any sibling regular files unchanged.  Multiple '*'
components are supported for layouts such as
/var/lib/flatpak/app/*/*/active/files.

Entries without a '*' keep the existing strncmp() fast path; wildcard
entries record the literal prefix length so the same prefix comparison
short-circuits before the component walk. A '*' that is not a whole
component is rejected at load.

The systemd-specific paths belong in policy (file_contexts.subs_dist);
this only provides the mechanism for matching them.

Fixes: https://github.com/SELinuxProject/selinux/issues/491
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/man/man5/selabel_file.5 |  19 +++++-
 libselinux/src/label_file.c        | 106 ++++++++++++++++++++++++-----
 libselinux/src/label_file.h        |   2 +
 3 files changed, 106 insertions(+), 21 deletions(-)

diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index baba7776..679a3f0e 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -188,6 +188,13 @@ A path that matches an entry in one or more of the file contexts policy configur
 .I subs_pathname
 .RS
 The path that will be aliased (considered equivalent) with pathname by the look up process.
+A path component consisting of a single \fB*\fR matches exactly one
+non-empty component of the input path.
+When the last component of \fIsubs_pathname\fR is \fB*\fR the
+substitution only applies when the input has a further \fB/\fR after
+the matched component, so an entry such as \fI/var/lib/extensions/*\fR
+remaps the contents of each named directory but not the directory itself
+or a sibling regular file.
 .RE
 .RE
 .sp
@@ -195,11 +202,13 @@ Example:
 .RS
 # ./contexts/files/file_contexts.subs
 .br
-# pathname  subs_pathname
+# pathname	subs_pathname
 .br
-/myweb      /var/www
+/myweb			/var/www
 .br
-/myspool    /var/spool/mail
+/myspool		/var/spool/mail
+.br
+/var/lib/extensions/*	/
 .sp
 Using the above example, when \fBselabel_lookup\fR(3) is passed a path of
 \fI/myweb/index.html\fR the function will substitute the \fI/myweb\fR
@@ -208,6 +217,10 @@ component with \fI/var/www\fR, therefore the path used is:
 .RS
 .I /var/www/index.html
 .RE
+.sp
+and a path of \fI/var/lib/extensions/example/usr/lib/foo.so\fR is looked
+up as \fI/usr/lib/foo.so\fR, while \fI/var/lib/extensions/example\fR and
+\fI/var/lib/extensions/example.raw\fR are left unchanged.
 .RE
 .
 .SH "NOTES"
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 54c43419..feec61fe 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1327,33 +1327,73 @@ static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
 	free(subs);
 }
 
+static bool selabel_sub_match_wild(const struct selabel_sub *sub,
+				   const char *path, size_t *matched)
+{
+	const char *pat = sub->src + sub->plen;
+	const char *in = path + sub->plen;
+	bool trailing_wild = false;
+
+	/* The literal prefix before the first '*' has been checked. */
+	while (*pat) {
+		if (pat[0] == '*' && (pat == sub->src || pat[-1] == '/') &&
+		    (pat[1] == '/' || pat[1] == '\0')) {
+			/* Consume one non-empty component of the input. */
+			if (*in == '/' || *in == '\0')
+				return false;
+			while (*in && *in != '/')
+				in++;
+			trailing_wild = (pat[1] == '\0');
+			pat++;
+		} else if (*pat == *in) {
+			trailing_wild = false;
+			pat++;
+			in++;
+		} else
+			return false;
+	}
+
+	if (trailing_wild) {
+		if (*in != '/')
+			return false;
+	} else if (*in != '/' && *in != '\0')
+		return false;
+
+	*matched = (size_t)(in - path);
+	return true;
+}
+
 static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num,
 				const char *src, size_t slen)
 {
 	char *dst, *tmp;
-	uint32_t len;
+	size_t len;
 
 	for (uint32_t i = 0; i < num; i++) {
 		const struct selabel_sub *ptr = &subs[i];
 
-		if (strncmp(src, ptr->src, ptr->slen) == 0) {
-			if (src[ptr->slen] == '/' || src[ptr->slen] == '\0') {
-				if ((src[ptr->slen] == '/') &&
-				    (strcmp(ptr->dst, "/") == 0))
-					len = ptr->slen + 1;
-				else
-					len = ptr->slen;
+		if (strncmp(src, ptr->src, ptr->slen) != 0)
+			continue;
 
-				dst = malloc(ptr->dlen + slen - len + 1);
-				if (!dst)
-					return NULL;
+		if (!ptr->has_wild) {
+			if (src[ptr->slen] != '/' && src[ptr->slen] != '\0')
+				continue;
+			len = ptr->slen;
+		} else if (!selabel_sub_match_wild(ptr, src, &len))
+			continue;
 
-				tmp = mempcpy(dst, ptr->dst, ptr->dlen);
-				tmp = mempcpy(tmp, &src[len], slen - len);
-				*tmp = '\0';
-				return dst;
-			}
-		}
+		if (src[ptr->slen] == '/' && ptr->dlen == 1 &&
+		    ptr->dst[0] == '/')
+			len++;
+
+		dst = malloc(ptr->dlen + slen - len + 1);
+		if (!dst)
+			return NULL;
+
+		tmp = mempcpy(dst, ptr->dst, ptr->dlen);
+		tmp = mempcpy(tmp, &src[len], slen - len);
+		*tmp = '\0';
+		return dst;
 	}
 
 	return NULL;
@@ -1386,7 +1426,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *ptr;
 		char *src = buf;
 		char *dst;
-		size_t slen, dlen;
+		size_t slen, dlen, plen;
+		bool has_wild;
 
 		while (*src && isspace((unsigned char)*src))
 			src++;
@@ -1422,6 +1463,33 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 			goto err;
 		}
 
+		/*
+		 * A '*' in the source is a single-component wildcard: it
+		 * must be a whole path component. Reject a '*' that is
+		 * only part of a component so a literal '*' in a path stays
+		 * expressible without ambiguity, and record the literal
+		 * prefix length so non-wildcard entries keep the plain
+		 * strncmp() fast path.
+		 */
+		plen = slen;
+		has_wild = false;
+		for (size_t j = 0; j < slen; j++) {
+			if (src[j] != '*')
+				continue;
+			if ((j > 0 && src[j - 1] != '/') ||
+			    (src[j + 1] != '/' && src[j + 1] != '\0')) {
+				selinux_log(
+					SELINUX_ERROR,
+					"%s: '*' in substitution source '%s' is not a whole path component\n",
+					path, src);
+				errno = EINVAL;
+				goto err;
+			}
+			if (!has_wild)
+				plen = j;
+			has_wild = true;
+		}
+
 		src_cpy = strdup(src);
 		if (!src_cpy)
 			goto err;
@@ -1439,6 +1507,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 			.slen = slen,
 			.dst = dst_cpy,
 			.dlen = dlen,
+			.plen = plen,
+			.has_wild = has_wild,
 		};
 		src_cpy = NULL;
 		dst_cpy = NULL;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index acfe2e0d..a42e2aef 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -79,6 +79,8 @@ struct selabel_sub {
 	char *dst; /* substituted path prefix */
 	uint32_t slen; /* length of source path prefix */
 	uint32_t dlen; /* length of substituted path prefix */
+	uint32_t plen; /* prefix up to first wildcard, == slen if none */
+	bool has_wild; /* src contains one or more '*' whole-component wildcards */
 };
 
 /* A regular expression file security context specification */
-- 
2.55.0

