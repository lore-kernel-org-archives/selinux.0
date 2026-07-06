Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB293822BE
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348667; cv=none; b=u8QNCHx3XJ3Oh2LXGgVg2+40j0xf/Qxe3vcFx8CYwc7irii5NaZUPUlkBamplSKYJYd4PO0cYjFvmhFlshqZst0UdRH6VtayTuKEOQPchxKK0RFlTftNW0Z6FgzCIPWEbgKlgwYXdTWHnJNtzT5T+2MsdzHEMa2g/OXT+XLx2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348667; c=relaxed/simple;
	bh=V6IIB/yd6hMfJ0lvTXkdCasqIqsdUighNmyYYStvmeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8JyF3pITF4DIksF3sI3zMQJoTKCklZwTBxWHh1xdf5jzNYWvf7Etm1vKbuUCdNWOWXfr1djXRkihlRSindorYBJCtJIV3vQzGbtKNO/Yn/q2R+kS6vJlH7mOILmzKAi0274jqkodQxeoiTpkLrLglEwzqbGftcwkaILnfAR1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2/FjHvX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2/FjHvX"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c1372f84dso21003531cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348665; x=1783953465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49KydwLMLrP5/8WLzUlr3r90/ociaSaT618Qvrv5Z68=;
        b=p2/FjHvXJCcHl3hPpuNQdbObJpC4FEMfESfaPDLsw9lTQcgi1kjOpRqfl8m0axthUg
         sWPQbZ7HZ4lzFcHAJrc/zcd6D6UaEvBVJf8AFAFAH23qpvsqtwobLpz+27Wxiodg3Ese
         /23d0SdZKC9N5rkfnLuyYpqdZ6qFr5phMXPtm7Y5GSJAmssiKwYH/m+TCDVm8m96X5cF
         DqNJwCuUP8NatLLx2TYpAk78BMhLx6c1UgXHRQlNzytCsMZCuE4lRqF43D6nwwxI1XzA
         WAk+2HW/oUGLtz/JhYQjZr2D3BYRGRNAd3yVh+ouby3EAAVjnyiZ+voACbgJkbozEuQ2
         N2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348665; x=1783953465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49KydwLMLrP5/8WLzUlr3r90/ociaSaT618Qvrv5Z68=;
        b=YdjLQhd9Uv6lysooOtWLVVu9DBbTuMf3RwIAt2F7lByf74jKN/WSEgSBfOGJmyq/9A
         m2LrdPCc6ETAxJgONf2JuJWIC1rzuOAJlWxF3YEXXCt0dGQUCg860jrHEexRmCOnvYo9
         b55vkXjJT1pHlIvxEAGgDh7mlQN2kd8fcpa3eXBt9TAYcjfXsBt4rb/Qf20w+MhWiAhb
         JK0ELFOXc7YZIj+Zuc2oLPIVS76YUK70GEf3Fd4xDX5mRWMfnrkBMXiMXwolxmgpRDs1
         ons101XgfSLB59mgBsjinXcMu/WAx+vqpiZd4r7CUJnY432X3QMWw44JlRJrkbYcSibb
         ma7w==
X-Gm-Message-State: AOJu0YyHZNbGdECXCJrpNs++EjQ6N+13DW/Y/Nqf1d9dJ4xopVAZR74i
	JggufNcDhiBvwVHD0JDSZAbC0YJXiiafQbFp/+ri1imGJbofNn3auQvHrlrr4w==
X-Gm-Gg: AfdE7clGRZ9aw+IJPq4JUq8KvY4rvggYW1Gz6EGhjVG/UFrWmiJHwzBoqHJO8ApMeQ6
	kwIL2xSNA6+WmcjikSf+shPSwtzd0G9jmdSA+NcT2OT870knQjwBuCsT0CYCK6Z5lwLyL63xO9+
	eNXjkPm1uYxurrlgwAq3qCCUj3hBCdpyjGe2j7yUri2jvG43+gQZziqnOVOu+jFEEIMPHY/CAbg
	of7xgt6cQyV2H6ORWWo7Gn5pLP2WLEjvW+D61sDS0MpNAVEeQFYAQcMhYyceqmNoDNx4nGFt227
	SiVZoPPeA/uA0+JzD2XFsKzi7bvN66RRaV/mqRpZe/oGX8x/ZMXX6Y9jKMNE379LMai0mc09uZc
	5RZlI/7Dj3Pf1YBAj7uI0jmMyalKRMO3lgGtTLwv9OTIDaSTveUgi+kWcWPHlVrMV+IlP0DB0JH
	bVWemUamy0c1da6wY1KzRGbheQ2N7KqZjS4thWzcvHy2taXHskI3YsDPwKPEbKCc/q1w3rvbX+J
	TRmdujhGOJpkuIr
X-Received: by 2002:ac8:584a:0:b0:51c:1b22:b855 with SMTP id d75a77b69052e-51c748731admr9832091cf.62.1783348663462;
        Mon, 06 Jul 2026 07:37:43 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm136972416d6.18.2026.07.06.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:37:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] sandbox/seunshare: pin_dir: use openat2 if available
Date: Mon,  6 Jul 2026 10:37:26 -0400
Message-ID: <20260706143726.47421-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
References: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
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
index 3fa42f9a..f2d637e1 100644
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

