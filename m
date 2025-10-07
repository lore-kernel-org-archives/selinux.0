Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1745C0B
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860568; cv=none; b=R6+7l5ZQn3rgZHjlKOC5co45IxIDAjvy5ViesPdxBfYRrdma+urOB3HuDQkRuzjbvNPIxakOQtny7h9FpzeCtJtGqxKkvDleZIHX4q3yUIIJKLPAFRuOJxfFy5KjuJD3AUTb6vhBx9Sv5Q9igwYYtyvZjq0l9021gr9waDLnB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860568; c=relaxed/simple;
	bh=cVQDLiu0R6FU9jwdREqSR3eNG0AdJ6lIpfEXyJnypQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuJ1Zx+AIJ2u4Ix2zfZ44cWGRBhLyHkdLuJ8QW8GDrp6z/hb+Ys7WIYLrNCRQwNVXjlbwSRuRosI9OS5usVxaC8Ib9qazoTB+FDtFc/XXfO9GNNev7cQyNSLUfS8oftTX4l0Y6c3f3LI4Ap1NyoEYa074ca7vH5cbw69FQnQ+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhy0tsQh; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhy0tsQh"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f715fb44cso3715309b6e.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860565; x=1760465365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RQqM4m70i33twbOchl/nLy/YG+wOKOmqw3SC2riNMo=;
        b=Bhy0tsQhhb7XmLW+yJ8VCH/7jIE1GG1MyuDApmC9ZYpehMzERfqD4yKRFTLTK9nHoc
         NuKiyTpE1m/LiMEHKkbETLYEmV5fm/RD2qnGJqsxtgnvex7oUb9q1ya7QcEelz8jw81T
         IHKRjz/VS2sQ7XNH2LbfxvQ7oewJU6z1cthZclQaBGYTLnvlT73xdq5oKA0PawV40P8h
         tjgZsT/KmUWb2BpJuqtagNrNl4SU1Whp/59G+9L0u6XheGruWAU7BJ5eEfuH/VVlqmyg
         oVypoQni8ZJYc+qzFyFbH2/j3Bm4oDzwtU3uczpce2ywuUC9oviMs2/zMkQ4LAygbp59
         n+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860565; x=1760465365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RQqM4m70i33twbOchl/nLy/YG+wOKOmqw3SC2riNMo=;
        b=PzsCz5Zt/oCqpDptT/tWB8iVVM2HnbxJfr9VWleWDq8HHKMxWAWV6fUCWgSwWbVmK1
         kbtOb4CeVsVUsMSB89LwsMVU2wYcmZ9FpB2wKTmKIvyIRpyIMSCEL+n1y1qCepQy1lap
         /NPw9aLntqyUDXispqIEg8/w3pwK4ZCqrL8Svg5dnWTcuTeSwX1sSDBDP+S74VpokAmr
         hbzUz/NDI5AMYBzrkcvLV8ha3t/xpV0ScDIkkMc0ZO9dWu3MbB5drjZb7uvulRH55Bth
         pMfMQ9Ijilcj2d+IH/7c2cjeC9xxQIlsy7f4vRFexdAaLLnsHdgbH3paVxwUUyom4BK7
         xkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHFraRVGvAQ8PNmODPPw4Qp06HP1VudgNqX2aD1MiLGMWr2q6CIdSFclQ4r/53HVTDek0vQCq@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4dHJ50H1zeEZPSp2VFF4JitdQwIKv2Aoqhdc9RXYKeZTmBX1
	oFPXnMIT6mKm0MAlyxuafDSu6txID9ogXae+ANKuQyvbNXBkFclHKT3J
X-Gm-Gg: ASbGncugDsqOel+g/To1E/dO5OpfAq+i+Ihpu9JRGB99W5WBkyqKE+yE267a4oBAU7p
	9MW2YjVD8y91rxJXA+tVosLprhf27bEJytwxz2oZP9PKGGF5q9zpWPlW+YDjtQwdUiC1XlU658D
	iqGbgC+otuk06QX5axw89L9Ix39ReyKbGlbDN8CmwHvsWLLCadak0B2tJFBNmrsuBx4bsM4CIxe
	wkjMsF3x42MxTS0UQ+mQ4hEPFqwSwrhyH8vgXB5Elu6wNcqZeHllX4y3CYCB1xFyQ2sAw4ZkP0s
	vyqWUYiJyjulnbqw2RmJ1RkRQevbhRY7IUfR/VjW4Idr9x/CoAhKkO06TcqYicDT76LDB+bGqZF
	uXH5ZaJXBJBDtYHUc100jR952hkjUoblZww==
X-Google-Smtp-Source: AGHT+IHhOp++Ph76mkdEznUR1Kpvm0PiG2wo2p0gCHcuibBiJi5Mnhx2S7UbV3r5N2kr8CsUCYS2vw==
X-Received: by 2002:a05:6808:80cc:b0:43f:7287:a5ac with SMTP id 5614622812f47-4417b3b6034mr289145b6e.30.1759860564687;
        Tue, 07 Oct 2025 11:09:24 -0700 (PDT)
Received: from sierra ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf435ed6dfsm4924209a34.33.2025.10.07.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:09:24 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: jwcart2@gmail.com,
	lautrbach@redhat.com,
	nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v7] seunshare: fix the frail tmpdir cleanup
Date: Tue,  7 Oct 2025 19:09:06 +0100
Message-ID: <20251007180906.507115-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ7xRYnSgN2qauMPHT54uV5PB7z+8DO1=PPOtT68so6=4g@mail.gmail.com>
References: <CAEjxPJ7xRYnSgN2qauMPHT54uV5PB7z+8DO1=PPOtT68so6=4g@mail.gmail.com>
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
 sandbox/seunshare.c | 78 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

v2: don't use else after return
v3: don't follow symlinks in rm_rf ().  This is pretty important as we
    we are operating on an untrusted directory, which may have symlinks
    pointed to privileged content.  However, as we only really need to
    operate on the contents of the tmpdir, we can ignore symlinks.
v4: fix spelling in commit message
v5: fix spelling in comment
v6: fix the error checking for the rm_rf () function.
v7: include stdbool.h

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 106f625f..01ed9d8e 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -4,6 +4,7 @@
  */
 
 #define _GNU_SOURCE
+#include <stdbool.h>
 #include <signal.h>
 #include <sys/fsuid.h>
 #include <sys/stat.h>
@@ -403,6 +404,66 @@ err:
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
@@ -428,24 +489,17 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
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

