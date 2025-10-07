Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0311A5B9E
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829410; cv=none; b=a6YBSUTBmxOVx8aXbL2+NsAro22/gzPKmQ94EE6lwN1zeIur5uxI6/Q1T2J9xaKaATVxL0vV7eweeDKiq5YGUJ6f3suCzpsD9xegU/0dYfoHI+tOtDLD8fexmi4TF1S5rcandHxHv+ILeTQLz5IoEAvlyvjPmhY2M+HeieiBwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829410; c=relaxed/simple;
	bh=R5O/IgrVIKBOY6GX4Oj6C6HKM4/E5VGoTLq+HJnyvy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6U6k45d7GI8Q6lyVRwCUkafBNaklXLhJFseHZs2tpGxTYWAXlog719JAtUORq5vUX+z+c9LGoKzF1EuUF8pQ1WQsPH/IPjCcZbdY0FWGDBSF7RbE5O7qJrrxpDPboUX5iP76mJ8Cf9jQqFjI/8ZGRWRf8oBQmpskddtw0KLx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCREAYBD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCREAYBD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7b4f7a856acso2067373a34.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759829408; x=1760434208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfmffdYzF/IIgH9nnjW44N7uah3mYrgTaF0Z4IoQSc4=;
        b=NCREAYBD84IFGEFRuTs2tzaELYd//Jv4lRSkehg0XZK1GYZ9WEKl1TvgedXhWRUrA4
         Wg+Em4uScDbbjJ+UmYXacbE2pMuSjU2ScAJzNw2WnRiMTAQn3MntqdYfXF9D0TAfrzb/
         k1niIHWJp1Q1qGCOOfyjGl+8pBfl2szPmQW220nSzHMfDslYjepOth4A4+bZmuwKo+Ua
         vCcnakZP2FUrj5TrxOf6b+syGu0lnBWX1iP2xLJeu1lYYbgmgBTwNVwhig5APEw4eXt8
         XZjOjiDTIiCavvybfOb/0QK45czHDWPgN06gn2wApe4QJt4BzIU5MIjvET5q60+WtPou
         /CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829408; x=1760434208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfmffdYzF/IIgH9nnjW44N7uah3mYrgTaF0Z4IoQSc4=;
        b=mJAYUMk0ef9RBePRG1xf4J5Hlm/Qj9h0SyWclF63ZrzjyT29IesMhmD0Ufv7CBvs/1
         AbwiGdXSfqOxpY20emiset/jVjcksEh3kBzdIrW9uBgS51bcWjniLOkKCagufyXxfo7w
         x28AF9i8PmrW+5T8zo8vI+EilwLXpXFD+D/TCo8+OJlV5VjSFaMDwLIIenZiqegsKjXF
         wj5QYl5/PKuXaa4+Py0olr7NqMBuBmOCcyQgq7jQ+l1A1Bf6wAs3XAlTlRJt//Z6sdWk
         14cWqiZONXKQvljw8f8pm+9gg2VibuRTDUQX4Gqn9pA+boQ3UapLd7ASsVtPzumQZSKl
         VGZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9eQqgIrFx9uqi5HL2Xgxb4oRwx66jzito/IDgNt4TkSa+RvBppx8R3tDP/xINWrlzYbN7V9F3@vger.kernel.org
X-Gm-Message-State: AOJu0YwIH26L1vObShL2gdo+E1l1uhYl75puEnbG2/6n09XYiPuQBpzD
	8MXjU2dS+UFsSbdFUrMp8yVuMUYwi5VbbZG+mJg/Ky4lAVJfGA8CF1KI
X-Gm-Gg: ASbGnct2/mGH5kXSznT+Nk2XJ51RhbkaLkkoBvAPjKRYJugmWkzXUP2ce7eKEufBLem
	fKeMmv7EZQ+JXr6589JG41/kIbso1t9ewKxV0ps7yZbx5+8WzZSn8H4jNMKhl/7j2m94YLEG9SH
	TTyXJNKKAWZHaY2jymH/5PWAUnzu6o6QngRzNW3x4SRHUcJJeg1/qa65iSx6Nx+fv84QIIhmN/2
	/F2Kp+zJCqHfx3DYkscN5s4ypbvnrClpES2S4YhSvvrMHNVB1BJJ7Ty56mL4GYYhgtA7BFyGZ4r
	bFJ4t6jIFqOLHGrCTHKXgciT7h7m1TMiOz20/vZQbSgjnSMYLg3fdpwdUUlBShtGLyWM0PkzAr7
	7525XByjAYE5PEj6Q4jxrfWwklLVcxMiviWY35mNOl2x6
X-Google-Smtp-Source: AGHT+IGDdKHLgfeQ7eMFS4EKVJcQlZ29fFacTCqV2DCONyoCTKpxWB3X7w+ZXTkmY0kgfD/PBFWFKw==
X-Received: by 2002:a05:6830:6519:b0:759:5b2f:ab9 with SMTP id 46e09a7af769-7bf772c3045mr8659016a34.30.1759829407897;
        Tue, 07 Oct 2025 02:30:07 -0700 (PDT)
Received: from sierra ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf9a52320csm1322389a34.28.2025.10.07.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:30:06 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: jwcart2@gmail.com,
	nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v5] seunshare: fix the frail tmpdir cleanup
Date: Tue,  7 Oct 2025 10:29:22 +0100
Message-ID: <20251007092922.471609-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ5BOMkXu+=F0yG=OhqR0=w4vcY+J8KtUU-732vEXokk6w@mail.gmail.com>
References: <CAEjxPJ5BOMkXu+=F0yG=OhqR0=w4vcY+J8KtUU-732vEXokk6w@mail.gmail.com>
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
v5: fix spelling in comment

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 106f625f..55e62620 100644
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

