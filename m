Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190E40245C
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771165; cv=none; b=FSB1MhAO5eG6a+X2zZz+emaFiZsxgVq67L97CAR0p5hwYG0N/S/w3ulQSnnM0EKSjAqIPH9hVdI4Lzy2sr656qrR3Dw2khukroomamqHdlK7L1DQWs7e1nKPPLWRzxne95loj1GcJk4n1Aqbza22878lJObIIsxlKtfT1fHCaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771165; c=relaxed/simple;
	bh=1HOJU1oRea00XeihFOVwkERIS/nbmIX69G/oQyX6ZPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjv1EeSJvrv3TIGvPYUqaSjS5VcJot/LjNl2ENkS2jOEVIo7AeL/dLERKCjgPeALfxRBrwoBeNp6/Dftqw+uXkvFfxmInj6v+9qhw2BcmozgzvgayOrh1p+7up98+nIuJgLj1eI/Ed0bf9cRcRWpJi1GhHhydZQKG4OQU494f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY1BW1rn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY1BW1rn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e594413c2so52945081cf.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771159; x=1779375959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7typ5ifOGeB/utZQZSnTynIlEcBXms2cMi5ljxddaY=;
        b=gY1BW1rnXv6Z2qh/h8ZC1EWKv8T+Pxoaf7omS5AMUaPeCMelj9telo0ziifUf2hPMU
         DXKYZ2wHbLKJNdGU5E6dI+wGZ98xh+u5Wvv5G/cjt9oHvKYbqaE5CQUxynFv560+TuXJ
         km6JI/dRHdwfSbrs5q7lgbBDCuWjFTrthf8u/Hg0HXxb+ZfU3xCwhWCMYsv+Jfi+uGT6
         SAdVKVPovae4aD26AEvMIZc1badQuxn8CealdmAchUeyjlFMkjaw+wpnEyjn/3z2MCtt
         E4cjG9KZDHkkNiGoaNm1UwUuK+uRYCgt1f52UdcATMo3ZY5K1SBvnLtF9EUTKTtVc2xK
         4vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771159; x=1779375959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7typ5ifOGeB/utZQZSnTynIlEcBXms2cMi5ljxddaY=;
        b=J7t2LyGHTuOA8ImYpWsZ5Xm+E+rDRIseYtnzR7rWbjG7+SzdUintC9B2xUM2aBPab2
         Y6e3Sm9AHxCTcCVeY5/WZSEBy0cU1Z6jyzl1ZdF2LMPkltJrqfKM0RxJOn7cb85aXcBb
         QYl6njBRguivlmILFViaVsJfYuFGhKPLJDXsGvWAJSyHu6CnSf1LyGqop0xdhALj6hPn
         eRCn00vUZahF4YWkvXxZR9ovShHaLXpzzomDQ14m2LTzGLyTWLMkWGAOkHOYfRN3apRl
         UbS1Iw/o1rgArsTv2coy2QRYmPUdfLZvYY6NfO0LwIYUlqpiPqfIPYGMxfu6awJR+KmV
         bMrQ==
X-Gm-Message-State: AOJu0YwN1VQAcSpQTo0XIfnrUGyokuPsnLrcM+iRIanRWikygBaqVTSI
	PVAkYpGdb0W2zouAxV8cZgignzGmEw1IHrsYDmHVlPiVDKqXayyQJeIZE4zfpw==
X-Gm-Gg: Acq92OG9kaTyDSX/6MTsu90twHiuVVj0JMKN8svVO4JiQJGuaILYXAoWubU1vM3RNnX
	Tb4paqHxhIILWSgtA4MWB9gE/mD/Z07iZLd/RoaLUVFUSUCoNXiIIliHy18KQholS4C7/yXmtmC
	RlExqKJba86Hx5sGEPxFzJFp+4wgLRfCcjeg44qMr2gaWcgK1wfU3Tr+j6Qy2D3tvee5EMCShWB
	VeiNF7f1b0J0GknVnpvA53nlk59wW3TxnpIVN7GxyWS+aA2lOQU65KCKTG8DTOGQhEcprLoOxK8
	BTvyIZ5vLLAQDtDXW9FJsuyZxW6Pfzcx+8dfsjYhWkcuHG/jpLVRG+Sm7gnAtsKKpkz7Hcp7KXu
	t6k9b54+KRM4LORXyCDqMORTL5bsfSASLrVABEyBUvPxMaMtF8DBvds0nX3mgJzyPe7LOjuzSXx
	nc7biPZDreFw3Y1ZIi2BsX4NOLJ1wqqCeDydTcsydDmxm83ew5fWtX920TRPkeXGJlQMwX/94tp
	4R3LB5ibKjieJKczboehLwEnXE=
X-Received: by 2002:a05:622a:8302:b0:50d:815e:7977 with SMTP id d75a77b69052e-516419365d7mr42200671cf.34.1778771158584;
        Thu, 14 May 2026 08:05:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516457d630csm18296351cf.14.2026.05.14.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:05:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fully check setfsuid() calls
Date: Thu, 14 May 2026 11:05:42 -0400
Message-ID: <20260514150542.55256-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setfsuid() returns the old fsuid value and doesn't always
set errno. The existing code was checking that it did
successfully return the old fsuid value but not explicitly
checking that the new one was set, which can be done by
a second call to setfsuid() with -1 and checking its
return value. Add a wrapper for setfsuid() and use it
throughout to ensure complete checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 60 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 44557d4d..0e5107e4 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -486,6 +486,44 @@ static bool rm_rf(int targetfd, const char *path) {
 	return true;
 }
 
+/*
+ * setfsuid() returns the previous fsuid value,
+ * and does not reliably set errno on errors.
+ * Let's do better.
+ */
+static int setfsuid_checked(uid_t old, uid_t new)
+{
+	int rc;
+
+	rc = setfsuid(new);
+	if ((uid_t)rc != old) {
+		int save_errno = errno;
+		fprintf(stderr,
+			"setfsuid(%u): Returned unexpected old uid %u\n",
+			new, (uid_t)rc);
+		if (save_errno)
+			errno = save_errno;
+		else
+			errno = EPERM;
+		return -1;
+	}
+
+	rc = setfsuid(-1);
+	if ((uid_t)rc != new) {
+		int save_errno = errno;
+		fprintf(stderr,
+			"setfsuid(%u): Produced unexpected new uid %u\n",
+			new,(uid_t)rc);
+		if (save_errno)
+			errno = save_errno;
+		else
+			errno = EPERM;
+		return -1;
+	}
+
+	return 0;
+}
+
 /**
  * Clean up runtime temporary directory.  Returns 0 if no problem was detected,
  * >0 if some error was detected, but errors here are treated as non-fatal and
@@ -529,10 +567,8 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free_args(args);
 	}
 
-	if ((uid_t)setfsuid(0) != 0) {
-		/* setfsuid does not return error, but this check makes code checkers happy */
+	if (setfsuid_checked(0, 0) < 0)
 		rc++;
-	}
 
 	/* Recursively remove the runtime temp directory.  */
 	if (!rm_rf(AT_FDCWD, tmpdir)) {
@@ -540,7 +576,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		rc++;
 	}
 
-	if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
+	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
 		fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
 		rc++;
 	}
@@ -570,7 +606,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 
 	/* get selinux context of source directory */
 	if (execcon) {
-		if ((uid_t)setfsuid(pwd->pw_uid) != 0)
+		if (setfsuid_checked(0, pwd->pw_uid))
 			goto err;
 		if ((fd_s = pin_dir(src, &tmp_st)) < 0)
 			goto err;
@@ -585,7 +621,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 			fprintf(stderr, _("Failed to get context of the directory %s: %m\n"), src);
 			goto err;
 		}
-		if ((uid_t)setfsuid(0) != pwd->pw_uid)
+		if (setfsuid_checked(pwd->pw_uid, 0) < 0)
 			goto err;
 	}
 
@@ -629,7 +665,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 		}
 	}
 
-	if ((uid_t)setfsuid(pwd->pw_uid) != 0)
+	if (setfsuid_checked(0, pwd->pw_uid) < 0)
 		goto err;
 
 	if (rsynccmd(src, tmpdir, &cmd) < 0) {
@@ -637,7 +673,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 	}
 
 	/* ok to not reach this if there is an error */
-	if ((uid_t)setfsuid(0) != pwd->pw_uid)
+	if (setfsuid_checked(pwd->pw_uid, 0) < 0)
 		goto err;
 
 	if (spawn_command(cmd, pwd->pw_uid) != 0) {
@@ -874,9 +910,8 @@ int main(int argc, char **argv) {
 	/* Changing fsuid is usually required when user-specified directory is
 	 * on an NFS mount.  It's also desired to avoid leaking info about
 	 * existence of the files not accessible to the user. */
-	if ((uid_t)setfsuid(uid) != 0) {
+	if (setfsuid_checked(0, uid) < 0) {
 		fprintf(stderr, _("Error: unable to setfsuid\n"));
-
 		return -1;
 	}
 
@@ -913,7 +948,8 @@ int main(int argc, char **argv) {
 		close(fd);
 	}
 
-	if ((uid_t)setfsuid(0) != uid) return -1;
+	if (setfsuid_checked(uid, 0) < 0)
+		return -1;
 
 	/* create runtime tmpdir */
 	if (tmpdir_s) {
@@ -957,7 +993,7 @@ int main(int argc, char **argv) {
 		}
 
 		/* assume fsuid==ruid after this point */
-		if ((uid_t)setfsuid(uid) != 0) goto childerr;
+		if (setfsuid_checked(0, uid) < 0) goto childerr;
 
 		/*
 		 * Now we can pin the source directories in this namespace
-- 
2.53.0

