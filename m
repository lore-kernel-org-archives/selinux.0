Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D612367AD
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778722; cv=none; b=Olu4FajR0WzYHtF5n25I5ogUMObPLH+d9enehUqZA+Fw1rDk2R0YUJ9RKTOSs/sP+EnvxIpB1lpWlHFJR3e+WuTnvFMyI8awassfV+SGwQlSvWh+/NCD0RMUjz3p/AYjT6Dc1hab2ezfgucp5ViexvJlFAUR+XHxDZqq0KFi6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778722; c=relaxed/simple;
	bh=Y7Z0aP8X9Q5hSzoJsdP1eruWVsF5mYVE+jdifxidvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icfLi7PNC87xhplg0ekIcUwAQdh6V1+UHmycYurYqHNtl7A5xBqmwC8lfW2FsrHEciNse5NFtS8xiTEZH4GTx3z8/bhuR1IaY1NwWpeSEJCcAwQmtjmbrKiKdPtsR0Dwi9m59Vm84lqloOJtkbGUG54s6LinNXt9/Lm+cRcaxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G38HIgv+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G38HIgv+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso3575965e9.3
        for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758778718; x=1759383518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVGUQGgvtamLXhjwKqBrcn6V62KoibaQO/LkFyt7Ij8=;
        b=G38HIgv+uM33zEMcg+6JSplyHLzR68sJnpVl2yeTPzZqvDjqDmCCj3GYRreMqM9nOX
         BofxgWwkprxISIOqxeNz+Hi3oj64wFKuDB6/Qv3l8PrCtiso/vJsqMphOaAYflnnfkOK
         BLUvKkGlviinhC6wjhMov3gbMqJx8BHkTiIPdFf/XET06IXHWZ7prgSTeGvbBQtKq2SI
         Kz4e4tGFr/bH4dXK7LZs9sXt0JlwIhtolzJRlCBIXOy36e8gRzkNF6mG4tt/lMoY0xV7
         UOuCGpHtXp/B+BADn0QrBhhycgsyouCxiolAJIiFBiF2lBLko9rM6XX4pHNbAh3T1Urd
         NTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758778718; x=1759383518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVGUQGgvtamLXhjwKqBrcn6V62KoibaQO/LkFyt7Ij8=;
        b=Huy6TNaxAeBrfQTqrTUkMnlIYpRLG5nuH0VdccMvsO+F4LucPpDMl8AUhkJU00YtZ+
         gYKyMFvyY8sd9i47VkxYXw4QGHyvmXOW19GnR/CYMHnkgqcIM0ycPZ9SMfPn3+J2ToyA
         KBHXGXOGb/uRk7DVT+6v4tydl5R0hkqfMXMbe1l3MAE4b9cJ2eTd//bNeUDQ9UZRiD9H
         fL9fwy/52jSgARL8ozyFeuY3wGCDUOCXepcFwqSh3sDivQOHvZEjIIs2lcacVlqZF8cy
         jTXB8xVOMH+L551JGAkUsUSmU+k4KW5xj1h6Ehy2v6c7yLqNyMoH0Pw2IOs6txU10MfR
         8umg==
X-Forwarded-Encrypted: i=1; AJvYcCVZkWfU/d7kvrNyuALRkpFygTRgaKk+3KuVzhfZXVIQrzdrf7sB4paYWPC2RCnEYDWK7apmzpz2@vger.kernel.org
X-Gm-Message-State: AOJu0YylHQKhiiVdqfGUAvI5yYfUvTC+/H3hUZA8LCYDrHGu/gVrhy3+
	FUtAXdPvubUscyM6fAp3YCE47YX785IYp7UXhc1DWuVcqngoH/GmOO3G
X-Gm-Gg: ASbGncsXeMOPBEBJm1geq/3+qAgy2qCJzcLSRCUaThCJTeE3LAi4oiea8hEILpN28h+
	Q99pqmsWXxAvDm29Qk1l62HjnjwL+HK1RiABXRqhLm/VmAqZOapwrAyP8iqk19tvzg7hPd1E9El
	uWVO53QAHlxlHx9AxKodB3H0tK8TxSFY0zohW9BBKHGaiMqxCOadV4oK1RQD5bsfyT/1lXzjSqR
	J6Sh8KYlvDgeLcna8qGXvT03m9Dko3CEccl14POXrzBrQJgRKTqXv62qBPA+Rk0LN3TZHxsHaYv
	8T4gcICzot9rmXy35HnZmG8TeiO9uMpfJMchV+3RL+m/0xdIu1gWUwRU/zB/LBd+5Ft2p9JGMVi
	MeawM2nX0k8uMwrKJag==
X-Google-Smtp-Source: AGHT+IErlPBMaJUnhIEAZP9AvS30VHjPgDpqGkZX0P6+Za9SCXjK3izJm8aMHzMExpll08lLmnGOLA==
X-Received: by 2002:a05:600c:4816:b0:46e:3287:57d6 with SMTP id 5b1f17b1804b1-46e32a0bd2amr11331865e9.27.1758778718105;
        Wed, 24 Sep 2025 22:38:38 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602df0sm1366724f8f.36.2025.09.24.22.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 22:38:37 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: jwcart2@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH v4] seunshare: fix the frail tmpdir cleanup
Date: Thu, 25 Sep 2025 06:38:15 +0100
Message-ID: <20250925053816.904674-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
References: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, rm is invoked via system (3) to cleanup the runtime
temp directory.  This really isn't all that robust, *especially* given
that seunshare is supposed to be a security boundary.  Instead do this
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
v4: fix spelling in commit message

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 106f625f..c46db90f 100644
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

