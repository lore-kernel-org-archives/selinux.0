Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D13368D42
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614015; cv=none; b=at9regwMsF6iPhkQGrllgvLmuVDBXRaLyFN+w+mqH8wVmb2nh7TGI6QkzJ8j1j+NYz0sIIuedke+hgBG03401XatYhKE6zQmkTV3rSYVY3G32D1UzWBj+2tiwt+f2s0k3uVie5LQneE3QUrj0yqU1BoIJzgpWno2pK56D1XLX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614015; c=relaxed/simple;
	bh=wrzm3FBO8yhFp0asx5D6jmOR1grUfwFb//IpS7HLG20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zr8CHdhwBn3cCOeVHgC5/q6nbdhxEE/hou8c/rt0aO1I2Vrxddmh6E1ZYV3Wiq/YugLgG4XhUJgP4fUDjyhCszwnQW13s3iv5PY8PIc6shJdSzBX3Av3a/J+ROlW0O2ETAO53kbWxixz1Hes3K2K2BYFcndJyoO6v5gITpdM7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSDLQ5Fi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSDLQ5Fi"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso52329316d6.2
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614013; x=1779218813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnZRPshhqXE2QCMttwCx1N7PS54ZQJ8ISi7kWmYzTQ0=;
        b=DSDLQ5FioU5r9dRvoQ+avWQ2AxWTcJbAdX3evLeGftgjA+JkzK+aMEo6qDJZ0Td5H6
         tE4DfbvYc1oeYf+B/mnIi0o1/HEgbH/RER6PNcRbtNXPkdMxemzjThuwKdPvCNKitNJY
         1A8cCBk6R5fLZmQnO28f7iej4fv04jIRkLG9YCCXKSmMme9qfHq0wtyWQgx43B1L8Xp4
         kA932OQjMc4dUbdH5/mIKWuvbUybtsdzVk8VcWlOocHm2/8vwYQ7vOsQnB07/m6nWjBO
         NZ/PFx1tzN2qRfPeE9LRqw8ttmx5brM1m684RZMqTzg5M9EtTDrPgu5EmfAAOD+eWsVb
         +wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614013; x=1779218813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnZRPshhqXE2QCMttwCx1N7PS54ZQJ8ISi7kWmYzTQ0=;
        b=KDk2Cy+jFZbCDOSpM7v3ucdvCx0Nh9aabsmHSkTMhr9SKq7kxGS1OE3DOE5TyU22pW
         vxvhmrGzfQKMBxQgwFf+0dTEG+oqk9gEwfzo/K4fo0rD02pruhNZxkL9yuw+0xd5VPa9
         OTUOA/Bqr5H0PihBMjw/qGAeLz919uIK5ik/KV1W0zJH53ndiswIDrj9pIHO6Sg5l9pK
         4LXJ/CoWiGVJBF0ELLZyVSpEHG0ht4WGCwS3179lbXTBot8NB6OoM/FpxKKQkoMp4R+P
         dKovcZ6nW4YgESV159rb9T2qe+ZXiBE8wRcmbiJrUm/KwGEak0NvLh59JGiMxeWTUu5O
         1WrA==
X-Gm-Message-State: AOJu0Yyug1dja4Ur09Uib8FbL7WMooQ71DChdT5pe4SEwgCQnAu8KeQd
	XaOJDsb87d4ywL3/nTRNcDaP5s0U1uzoZrenxKvXARadUQjaGVF28U5vm7wB5A==
X-Gm-Gg: Acq92OHiTatmIiBRZ6Uod+KFWVRCcunt3bA/pbjB0Digg9rXOEXrlDMbjEha9/Pkf4C
	nwl84tPMP5TowsoOJ29GTBjESSrhDngTe6XRpwBp+KwhbT4Hqpax7A3JKMfTwGEvQvqBqYhp2ve
	L7xUER9In8BDx5hOezDi1kIvbmCdWrVqurfXHBwVsdC01e2RG/SoKQ7zSfNRW11M4yPr9LctdQJ
	12n0nVGQ9/r4bj3SFJLo/KdWZyQuNcu9YAWASc9pjRlHQnMTDeN8nQpu9gL9xkvwdCHdJ4Hh3py
	xw34Rd7/gke+t5f6tjLDJ0rNDx54hEaWZT2gP6VWgGaBrVVfVGasEHvlo7T7e4x4tI4kFqkiE03
	/m/DHA/6+JNiOe0S1zBISM3hMLLhSp/B1TPinCTFlDi85QmaZGi3LUccwQBNmJroOCRD1179yH5
	njxpMqgEMOnChMXAon6Qy7WdnSsI4PEP4ydsIL6r3zkSTvW3hXmwo2NnR9NBsfmNb8EltuJFxj8
	9UiZVznh053qZpYaEIY6O4Mhr2ZPNUCzAb0QmHdGZgM1oWjEAbbUUM=
X-Received: by 2002:a05:6214:4f02:b0:8ac:7d43:f88d with SMTP id 6a1803df08f44-8c7b5d3eff1mr6659886d6.0.1778614012833;
        Tue, 12 May 2026 12:26:52 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d83114fsm346136056d6.48.2026.05.12.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:26:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: switch seunshare_mount_file() to use open()
Date: Tue, 12 May 2026 15:26:31 -0400
Message-ID: <20260512192631.751908-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seunshare_mount_file() currently uses fopen() to create the dst
if it doesn't already exist. Switch to using open() with
explicitly specified flags including O_NOFOLLOW and an explicitly
specified mode for the new file.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index a1900eaa..17a727e7 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -304,18 +304,20 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
  */
 static int seunshare_mount_file(const char *src, const char *dst)
 {
-	int flags = 0;
-
 	if (verbose)
 		printf(_("Mounting %s on %s\n"), src, dst);
 
 	if (access(dst, F_OK) == -1) {
-		 FILE *fptr;
-         fptr = fopen(dst, "w");
-		 fclose(fptr);
+		int fd = open(dst, O_WRONLY | O_CREAT | O_NOFOLLOW | O_CLOEXEC, 0600);
+		if (fd < 0) {
+			fprintf(stderr, _("Failed to create mount point %s: %m\n"), dst);
+			return -1;
+		}
+		close(fd);
 	}
+
 	/* mount file */
-	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
+	if (mount(src, dst, NULL, MS_BIND, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
 		return -1;
 	}
-- 
2.54.0

