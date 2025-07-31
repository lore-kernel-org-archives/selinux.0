Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCF17DFE7
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996739; cv=none; b=iZdF4SV/EJ4pPNJZ+jM5pwWkiWPPkV5eqtlxBssIXIJVEAqsG4y7qwGt8QjWBOWN1ubZNQBP6pdE4S89awDvuLBX6c0BIc18nJw4AEYATGo3CYBvehO94+11jRsVUZ0QZqK5sjitWqLrIerHNsdRTVLzWu2oW70hiBUN126Yq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996739; c=relaxed/simple;
	bh=G6nFqeTuGJeiGnUr6a1vA9647zrtWqwsNgcEX1Ad314=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD5QK9BF5HH/gPf86dW0tCpgizsaiTpwmhTu/jzlzX91LfksFwVCueTdntq/aWhrGkJUBed5K9nUQBF7RekMTI94WmYZg9Vewbdl37/FWVLLnRHFWcDFyBjjWIkAgZFpovVReLexN8zOLOwONybDwfCyoi8J0TaEmf2F/kwwcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyiCwDIS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyiCwDIS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so7859815e9.2
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996736; x=1754601536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuBWD56bkJCAWYOCLno1DVOyk8qEh5OjdN0XiiapI9k=;
        b=WyiCwDISgMGiQ8G2x2COhous8z0d+2q8MUX71oqXHI7RAG2apHOkAmX9ILuecdwaSM
         TMY4Y+vTpYOsO4wAO9WXp1oJK/zFecO5jq8PfJOPrf8U2rtlf7yS0KV37UTxMm3+nvGH
         pXQCZ07BM6geUq3L9klKU8oCeFO5nYkLaAJpMVseCod6JqHtDzP34/gWcAq5FWTyhW7v
         xmtDChy6mxHvSo9CzF2yECwKsUcsbDwB1SAFR2ON/9O498mfdJbEAyr8aIzgZqSjE98w
         Sk9XAPbiscUsZViwNsB0vfJeEOXEfRZZ38Pc5CK3hMCv2oyKEDYf4Wn5MZjIAJrd/rfm
         bQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996736; x=1754601536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuBWD56bkJCAWYOCLno1DVOyk8qEh5OjdN0XiiapI9k=;
        b=GcnoUEIP/VMaPV88+F9FePhuyawnNFFnTSHwNZHZVcpB9MKnRgKwu6MzvmBbvUQUtj
         s/1rEyeAiBMLB5HDbXYkvz4KZT7yDwZkpjxYKPrZme5+wmCdMNyDfOWxPimIUKCsSLdI
         2TJT+cZkvVwxzPOqegKoXLcppzdGfqRE1lEGFyyWs162ShJatnz4Cl4B29rCLnUeJj6c
         1UQRN8PHs1l41hWtFMx55ayo7GmfMIm8AC1ocl1xwWWwbf26J23Tt/x5Pfp2wblZOBoR
         mf0Yr03FX5NGYcYRTGBIQjfDEaeszDrJbaLb3e15PO4njnlWCQoNWVqjPsLuSfrayIhs
         7HXw==
X-Gm-Message-State: AOJu0YxT6KmrjuQyAFpP7CYKAIICnSCLxikJ5klDLvo4QKVNIyovKZot
	ydVqSsaU/ElikU6VeeDQCydX/jOT8OBIlVY+HEar6OB5rAZD5tNmASDAGoUYbg==
X-Gm-Gg: ASbGncuXNQXRBEorKm1c9T1svvgIpsWWCXvFJjTTXSWFzMr37s6bUTY9aSq0CwE1X25
	1451mcE8y0wpOPEejZxQBS586RjVvYlrd22DbbKFgu4holl0SiI9LaQU5SRcyFlDdoTJh3Qbdid
	Fsz5yjzDASnCTosNnD0p3O7dExvsH+9HCvzBZh/HtvMyyWrDqM3p3qiu+8weAPNLtye7QcE2DRB
	yiu5B6WY9EEiYVlNY0qrkvalFM4LYyVX2s38DJb5DhfWKpCxIMyb/tkMeTDdkz0VRu8/iW/Sl1M
	NRvpAm1VPRVOE7m67FukpmersU2JOjUvqv0b1fKPIOuuUUOKDiBDUoLmU5AOYwTFQ60diYmtpd8
	XVDZ1QQ83ephtsSYK3V/MCrE=
X-Google-Smtp-Source: AGHT+IHVAZGgh4zBVmj4oXup+FmwcpjU1LVsDnmm8OWqBmNcs+WB/0EYyC7HqVeTsnCKAnDMdX0TBw==
X-Received: by 2002:a05:600c:c1d7:10b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45892d5e314mr62354765e9.9.1753996735636;
        Thu, 31 Jul 2025 14:18:55 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd77cbbsm67023115e9.2.2025.07.31.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:18:55 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [PATCH v3] seunshare: fix the frail tmpdir cleanup
Date: Thu, 31 Jul 2025 22:18:49 +0100
Message-ID: <20250731211849.1102381-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <DBQHP9O2QZP7.15GAYG3PERBJ8@gmail.com>
References: <DBQHP9O2QZP7.15GAYG3PERBJ8@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, rm is invoked via system (3) to cleanup the runtime
temp directory.  This really isn't all that robust, *especially* given
that seunshare is supposed to be a security boundry.  Instead do this
using libc, the API designed to be used within C programs.

Also, don't bother trying to delete the contents of the tmpdir and then
trying to delete the parent directory with rmdir later - for some...
undocumented reason currently we attempt to delete the contents of the
dir with dropped perms, *then* elevate perms, *then* delete the tmpdir.

This doesn't really make all that much sense as far as I can tell.  We
should be the only ones using the tmpdir, so we may as well just delete
the entire thing using the rm_rf () function with elevated permissions.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 sandbox/seunshare.c | 77 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 12 deletions(-)

v2: don't use else after return
v3: don't follow symlinks in rm_rf ().  This is pretty important as we
    we are operating on an untrusted directory, which may have symlinks
    pointed to privileged content.  However, as we only really need to
    operate on the contents of the tmpdir, we can ignore symlinks.

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 97430535..8b1af609 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -403,6 +403,66 @@ err:
 	return rc;
 }
 
+/*
+ * Recursively delete a directory.
+ * SAFTEY: This function will NOT follow symbolic links (AT_SYMLINK_NOFOLLOW).
+ *         As a result, this function can be run safely on a directory owned by
+ *         a non-root user: symbolic links to root paths (such as /root) will
+ *         not be followed.
+ */
+static bool rm_rf(int targetfd, const char *path) {
+	struct stat statbuf;
+
+	if (fstatat(targetfd, path, &statbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+		if (errno == ENOENT) {
+			return true;
+		}
+		perror("fstatat");
+		return false;
+	}
+
+	if (S_ISDIR(statbuf.st_mode)) {
+		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (newfd < 0) {
+			perror("openat");
+			return false;
+		}
+
+		DIR *dir = fdopendir(newfd);
+		if (!dir) {
+			perror("fdopendir");
+			close(newfd);
+			return false;
+		}
+
+		struct dirent *entry;
+		int rc = true;
+		while ((entry = readdir(dir)) != NULL) {
+			if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
+				continue;
+			}
+
+			if (rm_rf(dirfd(dir), entry->d_name) != 0) {
+				rc = false;
+			}
+		}
+
+		closedir(dir);
+
+		if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
+			perror("unlinkat");
+			rc = false;
+		}
+
+		return rc;
+	}
+	if (unlinkat(targetfd, path, 0) < 0) {
+		perror("unlinkat");
+		return false;
+	}
+	return true;
+}
+
 /**
  * Clean up runtime temporary directory.  Returns 0 if no problem was detected,
  * >0 if some error was detected, but errors here are treated as non-fatal and
@@ -428,24 +488,17 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free(cmdbuf); cmdbuf = NULL;
 	}
 
-	/* remove files from the runtime temporary directory */
-	if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir) == -1) {
-		fprintf(stderr, _("Out of memory\n"));
-		cmdbuf = NULL;
+	if ((uid_t)setfsuid(0) != 0) {
+		/* setfsuid does not return error, but this check makes code checkers happy */
 		rc++;
 	}
-	/* this may fail if there's root-owned file left in the runtime tmpdir */
-	if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) rc++;
-	free(cmdbuf); cmdbuf = NULL;
 
-	/* remove runtime temporary directory */
-	if ((uid_t)setfsuid(0) != 0) {
-		/* setfsuid does not return error, but this check makes code checkers happy */
+	/* Recursively remove the runtime temp directory.  */
+	if (!rm_rf(AT_FDCWD, tmpdir)) {
+		fprintf(stderr, _("Failed to recursively remove directory %s\n"), tmpdir);
 		rc++;
 	}
 
-	if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
-		fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
 	if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
 		fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
 		rc++;
-- 
2.50.1

