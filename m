Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FF409E0A
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187089; cv=none; b=siWp8pVT7DjbAXaGUxYHhDWIhv2OCEALKTuVTl40Htf+cIWhLQn0JfH/HI0bD7cLhk1kgadfGawZAWfAvSA5JRT0plE9jdfWKLw2ioocgKgk5WSaYz7Ub7DGuUqZgNr/tYkuIit5pUeVxCm0Bj1m0zgBGvfSA/FuDngWNFtn/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187089; c=relaxed/simple;
	bh=AUofH0ZI5WyZd+ANpfN8qf7FJGOwr0WDVZOKT0kZsM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgggcZQQz2Sycmmth/XY4e2m3Lbu0Kzf7fIG98/bVGwaY1J3Em/7RHLaFH9hy0wkJDcK9PQVuFjBMQy2ScFk4C+8J49PoiZd0XLJ7wFZKenc8/04NaO0OB8M8by/3dlp0fP7LYHG5EAXEHWar2PK4uKbtRKbeLVXUoAcKI6zQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSVjMnk8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSVjMnk8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51761d27612so93252331cf.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187087; x=1781791887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9V9t/jTrtysf8N1w7xdxgaeata57qvvM6uw4DUzfzY=;
        b=WSVjMnk8JLn9UKWwe6r+nWEFO9co+Oj9HxAsxURU/tODTB2k7KH+uv1EVvgVYurXZp
         DIWBujT2/5LYs8cYPARdclZ5lvYUyiscAbGDLyXWhpW2tNCTW5cznJzk9Sr/gDHBqa4M
         aOTyvRZIMQ2RH7M+E8VCJNW1hYDBbtK9rQTMiCNGb9+6WMRs779CmA6KtgV9OiNhPh2X
         nIniankEYz7+Lt4BCp/agBFN5ZTB0Fk7cxKMCjEWFVh+kfBaPWdE4jZDeR3IFlZFAjw+
         SxRvFT6t4+TA4KKw0akF5kkxH9wSNXKE8cfziN+yyyc0pCDYu8w7vSVVquxAr4q25V7H
         nNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187087; x=1781791887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9V9t/jTrtysf8N1w7xdxgaeata57qvvM6uw4DUzfzY=;
        b=a+VvRvCf1vBSYCyCS98y+FKWvCpy3boYbX+hm2UxTDDtZX4BOXtxD0YOXhoUpXbJ13
         9DpuW78Q8LovBECWyDuqrCvcT53aI7v3dgZSd4GaxBpRpWFIlk9HiDUFXzsi8Ml8Z65G
         Ut5VJ3bPP1CklnDDISuNaCAQXv7tqTAreefaE5Tx0icLLOLvs6NFetzWt3ZpVz5Curn/
         gFvNoRtLPxhnbGlIg4fcaZIL8O9QKOU3CdB0zbRMgez9kJZO/4JLaBcPmEUUnMk7htxp
         cQp5IgkEnU5WXIjUnSluSuH8aeALcnzCa4p6WDoiJ9cHDYPLexMCkLnO6zlrNp8fO17z
         6Ckg==
X-Gm-Message-State: AOJu0YyuvvviOOAfrGxmN1FpNcYKwpfC6U3DpHeN0Zry670/QyvdXZuS
	mZxgGuM7xkLkCQ25Ie11NGgduG1G3NtNOHW5HflAOEYIor5Lsrd2BZwpYAfv4g==
X-Gm-Gg: Acq92OEXI5sSgFi7HMw+z6EasLjnGqwE9YpXHlC40IjxYGsT1+WzBxuE9r8iv0EWJqa
	X4VU+WlQ8ji9ZE3C0hgjP9LH2avw9fu88BtoYGy0NDLFDUbtCkRYDtGDZTR5CaI+PcJes0ubEYp
	txMYKSHUzHu0t8zdH4jkt3eG4b97S21rMLC7TL2u4ZNG5sAdHoshwYuuk8JCZE1pl1RZWYA7Wm/
	GD5dk8qtCQcIrpM8tV+tNXBGtFK9POKekLUhKNrp/m2lqg1GWrUeg4p3x98UvztOxHkjjBHN7Vq
	2dG2nQq05/NyJR1EVKgSWgcIBAIMnSSCuGVeyo7ttlg5xiKzb2d0dBbfvvUZGib5wVtGlJISilM
	ODpUi1gy9v4oGQm/ZTz7S6WbYFzXamx8qFIZRr1sZVV/C5i9GWlfLoR1QlOFNQ4KYSepw9wW77r
	qUA1DzF4RgI3nt58AM+LizVrh7zLENiIal5Pjveax4gdq3Her1Eq9TyDqEaiz1xAa9kc76TQNxY
	xDPHwVj89/zPQHphXJdimty1/pimm1JoaJRPw==
X-Received: by 2002:ac8:7fca:0:b0:516:e10f:b1ec with SMTP id d75a77b69052e-517edcccce8mr44789221cf.11.1781187087537;
        Thu, 11 Jun 2026 07:11:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef620e44sm17844061cf.22.2026.06.11.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: pin_dir: use openat2 if available
Date: Thu, 11 Jun 2026 10:11:02 -0400
Message-ID: <20260611141102.17893-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
References: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update seunshare's pin_dir() helper to use openat2() if defined to
optimize the lookup of the directory and prevent following any
intermediate symlinks. Fall back to the existing open() on
ENOSYS/EINVAL so that pre-5.6 and seccomp-filtered environments are
unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 58baa7ff..829c6289 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -10,8 +10,12 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
 #include <syslog.h>
 #include <sys/mount.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <glob.h>
 #include <pwd.h>
 #include <sched.h>
@@ -219,10 +223,19 @@ static int check_owner_gid(gid_t gid, const char *file, struct stat *st)
  */
 static int pin_dir(const char *dir, struct stat *st_out)
 {
-	int fd;
+	int fd = -1;
 	struct stat sb;
 
-	fd = open(dir, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
+#ifdef __NR_openat2
+	struct open_how how = {
+		.flags = O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC,
+		.resolve = RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS,
+	};
+
+	fd = syscall(__NR_openat2, AT_FDCWD, dir, &how, sizeof(how));
+	if (fd < 0 && (errno == ENOSYS || errno == EINVAL))
+#endif
+		fd = open(dir, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
 	if (fd < 0) {
 		fprintf(stderr, _("Failed to open %s: %m\n"), dir);
 		return -1;
-- 
2.54.0

