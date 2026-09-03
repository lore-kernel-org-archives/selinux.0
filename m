Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090338332F
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459717; cv=none; b=lF8ugKjJfN3r8EsjjqE0VUUQJ3INeyPUxZ5dcSqlZeF7vAsGWxVAYM34MTPclYfPzXW+RPP/MHrZaAj4VqVBMhVzr0E29Fp3Ma2WToK9YmILwi4JAtrlX0UVg2amVXpBcqyKXRAJhQ18rk4085lJlzuPFWgEOuu+MiSEj52tSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459717; c=relaxed/simple;
	bh=yu+qBSGji+km4M8ezlygBR5E4wuliPswlruUvo+n904=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7y5YXhu5GnAMK3XQJ/KpAz/Qk697tG0oFOgF4ylhwNHU1/ZmvBC30ozATPdbYYNADh7iksL3jSiIffqHouULzaLBJpz5E7Qvpv18ApNt5g91sfV1p3xqPtEUCLaD37qtFDu3thMMRHdn3wq3OkWgEd2ALEbbH9OvFvTiVYYapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei7/MbSe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei7/MbSe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5218927884fso3528091cf.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788459713; x=1789064513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qZAlhVHZLYF5pNw40rE0BRv4mue4vbmUASu46DN4do=;
        b=Ei7/MbSe3uFbcnKBlB6Bh4LsoVqPg7GDneDGIyZs7WzfO9YOmXiw5jY3dyey6okMxc
         X3QfImM8woPhRMtPcyXIKd7kTdew9Z/2Ui09dqJNDZKft3Oe4TJ/qflD6TbwNCeDLfiJ
         gb060uu5wrSLMTJ1tU4QjOUnBtfmsBtWr2AM6exJ+bBSK5+qSOcCwiWpl79VlHs5CahF
         nAMFbFGlMVuZ0Mdzk7yx/RKQc/hqomm6UDXaidjOXjKlyZ9GL5qVQ3gr4eAg9czWNkhj
         jRn/KUfaX4+sIcXjEW4gS7TDcvPGr6ZyP8fh1rZp4DBGR9Yag4dj1pkkGSAlTJ2bWsr4
         8Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459713; x=1789064513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qZAlhVHZLYF5pNw40rE0BRv4mue4vbmUASu46DN4do=;
        b=r/WJsgtvfOudqANa4pr4zw8cnqtjthBYnQj8igHkdWG1rxgWecWDCTjHdNROMUCfK6
         iR8RdtsuNfMvPvdl6MuO1T3J2iA5QU16oujoilyR+gA0fHtN11xBE7J2MSG3jmaWWEs7
         9jtJnhqwGvLdzVjvvT+SHrsVDAOt/AgFp+LFmj5CT0nKfxPvKzKfhze8TC5e4FKnNGvF
         4lWCtWjMuC2DUlQRw5r6YYzAr2WFeOrd/ZVahth3w8E7xoC9qAUQXGP824bCc95UBWZk
         ij4SRUs8UU08UR/NppkK9JBietwH/Ng4CjAMQIWYb46n8n9Pnna/UwoVIJ8PZdN6oj1a
         6LTQ==
X-Gm-Message-State: AFuF++m7mX4wyavNxjABIf7pCSrgoXVTEKJan4U+C//mG22qjxoEvS6Y
	bkPG7DhHbPAXVNIdanWZ8rUQQF4BnLM/sV2AoQcFf8Gx1+F/zuCElwujEE7aTA==
X-Gm-Gg: AYBFou3kkgTecyCcY+WDx9IX/hSQjsDOjmaXhC+tmi+/TiCf7G/OqSZ2qJ9Q/CV/CT4
	BYGTQmWYHTimsrjF9W9/b2rq7PJYezwo1kxecxI7ZBqUpmOGGlRetZCyQqoT4+i0IBhG0EXaqBP
	idXjSvGx6zJ2mKf6FOdfnX5T4HqyyTwdVV1cRXMnO37s1mrc+Nv6rTFH5ONVTLsRbjoYMAQKJYZ
	5T+S2p7vctAY4BJyrhmZ0dRr0Qbs6R1+Nbhuz5A/i6ZVI/PqDn2rSSBenJWTUOlZeQl84uNK6K2
	NyD6VKBmhAHBSRKkhpdbAZnlvYOgGV+iyxXVp5BzKMtWhrYJjdARLHLsw+2A4MlJYPyVq6cfR9l
	Wb6uXDeWLQ2VJxVouR+vKU7cJbuZSaLq0HqKzJbDPPT44RBKstfonHQGvffsFyet+kxGde4b2MI
	j9k90GvS8cCEfrv8gtc43IrYtwPzb9+Qk6nkR1MBIOf2QuXo7W/iQ25BDqXnPO2MFfWfy/2eXQJ
	LePujTXVV3dcTqtQqrfcEqk51fZx74o0ymMBx2UWTfwxAzLPkBIhw1R140yVc2Q
X-Received: by 2002:a05:622a:4d8d:b0:52d:7b2a:93b with SMTP id d75a77b69052e-530547e32eamr9207331cf.9.1788459712847;
        Thu, 03 Sep 2026 11:21:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541eab6csm3471361cf.26.2026.09.03.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:21:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libselinux: allow a '*' wildcard in file_contexts.subs_dist/.subs
Date: Thu,  3 Sep 2026 14:21:33 -0400
Message-ID: <20260903182133.22011-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/label_file.c        | 105 ++++++++++++++++++++++++-----
 libselinux/src/label_file.h        |   2 +
 3 files changed, 105 insertions(+), 21 deletions(-)

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
index 54c43419..8ad1b97c 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1327,33 +1327,72 @@ static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
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
+		if (strncmp(src, ptr->src, ptr->plen) != 0)
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
+		if (src[len] == '/' && ptr->dlen == 1 && ptr->dst[0] == '/')
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
@@ -1386,7 +1425,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *ptr;
 		char *src = buf;
 		char *dst;
-		size_t slen, dlen;
+		size_t slen, dlen, plen;
+		bool has_wild;
 
 		while (*src && isspace((unsigned char)*src))
 			src++;
@@ -1422,6 +1462,33 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
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
@@ -1439,6 +1506,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
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

