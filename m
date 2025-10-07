Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB443C33
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856790; cv=none; b=UMe031T8bkIaJaYcBzpOd7jU1sjt+h+JONmjdZIoj1aQ+cueKtE462ZkuUNe5R5z87tdiFEs5zfwq4xCWdQ79vVzGlpicO4BeIY71mDZbU4z8at14V/EQHljluWSu4i2ojy8LF4dSO+M70vFq3k0v4Sd0KvarF49IosjzkAXrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856790; c=relaxed/simple;
	bh=YEX36DWzO7Vx19NVqOJ3fgZxyzRyBMNAvPwOdduJjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXwpotSa6SNj5KdRVOgqctK8B1N+eEtbUApD7M6o+fhnZg/EmCuwZ7U76UTRnvy58QhwMyUBD7vi1s8Ts8/ek6IL4FiUIiEkC97o0rtLAwHGEEG1vdeOLlPUDqIJ1cqkbPqZVdepSzgYRwAH9RrfOygauiqAatGgnvAlB+u6mBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1uBIjWr; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1uBIjWr"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-64fdca63b41so605086eaf.2
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759856787; x=1760461587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjN7L1ocmpSJtNNorOcaLMbRheunL+U4LJvt8GoOPb4=;
        b=b1uBIjWr725W/L/a+xiooQNQQdQQE7c5h+SiVRGjXgCOn7MFuaqQ/VLYU1Oj5fgrr5
         39oacbWa33AgxlMCrxurvUKKxtFVh50XuGp8hElFutk4izbGNleig9c2od218ZeLKTTe
         xUBdAxpADPdBOYazcOHf4RsQdwrr8brey3dgO/KWi6DeNES9Ryis8KNrAZXlGgUvyS8J
         0QcHdRKKmeSoIcIFGXBJWfCQMfoOOBrXzx3wdrE6htbdE23OdXTITgNYpKovofbBjBTa
         atE0Sj0z906TTouenv49y+7eDOGTWVo0tMFFuW1pXsdbA7CC+PCFhCwKBHKT2YdpON3Y
         KPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856787; x=1760461587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjN7L1ocmpSJtNNorOcaLMbRheunL+U4LJvt8GoOPb4=;
        b=oU7ypm/qhuAvU9qGJ89X+jn654htCUTqUm5uaBp+SE7hsDbgkvnT7gFVGm+codOLsT
         YqFRTouSF2O7VMhJOFt762w1xJN3edoWZ0qzTQzVSdztc4OJifI/u4fScIV9KMA4ujMC
         Z9ckNklUNCW3BV1RO0gCiK4S2dWTBQOb14S/gmws/X6OOq0qvxXLUx2Kp1tjvL5gOuTW
         nLwFSURdtrtEYFc7/9iRZVmGrJ89e6l4ekJpWvdOnUbBcP/hyIqRWkeDecJKxqq5tnsS
         776e8gWtp/Owg4Fugd6+lyOliR87i4tVrLQ/JLWnbGdE1G73GwT1p9jbTOAY3hIlu4Aw
         4TIA==
X-Forwarded-Encrypted: i=1; AJvYcCX8hYAaKXAUs0iVQ0btwuiuDAY72mlreivTVMMtQlHT8Svu+R46chWrm/anp6RGGC/DVXY54ZmA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzygt9Cnve3pgIQ0vP98AVIWkFX1zKLe73kQuasDkttQ7Cecchy
	HClUcZ/wNWKquG2toLTYLZoP8FxhLW7PhpkfrSABln4xh9G2S0Vtl0Ko
X-Gm-Gg: ASbGnctXqaCdxQWZEAisb+ciI80DEcPjtejcKan5vRmUNkUwViRbY2sM9nluUxJbMf8
	l9zfn318xBHvrruqK+cOTBN7M5XXjMCY65t7aT6B4oVzghfandIBcxCG7iK6HjxKPsQopKwYbV/
	x2+9Zxh4yrjLro/KrVpg3Mqvzo6L55f2jKmQ3SV8o6qNAUeaIx+eg9L4jSgTlXNIwEhqUYyEWjx
	FSHT8Nvs43/VQV6hZvXie1sbE1BqA/zs5b0E7C8rbJR2NSQAub60Tui6OxZYbWGG/QoLK8EUy6r
	RAAEdWaOGZXDncFXX2slzLYriBm0iTKv90RGGk3OZh6cMyAq4/Rt3ff1dggZ5vwSRWCiCniKNr/
	7ubzskR5w/2uuNIOqdvRqO8bWOvwHYtmoqQ==
X-Google-Smtp-Source: AGHT+IHVVPE66TXce2iIwHYcxK8ZEHhTPNhbRS7KI36aNsiepvayCwITfECoxbNa+SGrWuRueUbaRA==
X-Received: by 2002:a05:6820:7405:b0:63e:effa:86f5 with SMTP id 006d021491bc7-64fffef2f5cmr176913eaf.7.1759856787358;
        Tue, 07 Oct 2025 10:06:27 -0700 (PDT)
Received: from sierra ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf435ed63csm4837126a34.32.2025.10.07.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 10:06:26 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: jwcart2@gmail.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH v6] seunshare: fix the frail tmpdir cleanup
Date: Tue,  7 Oct 2025 18:06:08 +0100
Message-ID: <20251007170608.502567-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <DDC92OTGUZC7.OWZX9FSUWYQN@gmail.com>
References: <DDC92OTGUZC7.OWZX9FSUWYQN@gmail.com>
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

Also make sure that we don't follow symbolic links; the input being
deleted is untrusted, and hence a malicious symbolic link may be placed
outside of the sandbox.

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
v5: fix spelling in comment
v6: fix the error checking for the rm_rf () function.

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 106f625f..337a9205 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -403,6 +403,66 @@ err:
 	return rc;
 }
 
+/*
+ * Recursively delete a directory.
+ * SAFETY: This function will NOT follow symbolic links (AT_SYMLINK_NOFOLLOW).
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
+			if (!rm_rf(dirfd(dir), entry->d_name)) {
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

