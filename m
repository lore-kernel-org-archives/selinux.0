Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3F30648C
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132458; cv=none; b=T05ypye3Ah7M6Dm018ThHs6xt6aFNT7LHm96pfRcdb0RDkMJw5+pBFLjFUq4uJdYv1jxskVvzXleAK5vcaQb/kKaS3WQd+KLrTtZo9Xt3gbyVEfY6DgL7jsw+AZNwtXjxJi0lTGWJ6U3b/OlYmrPQyBAE/sLDxHb7ThFCEEfoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132458; c=relaxed/simple;
	bh=IzPaDnDFe3y3sfNaENqJ3ERtOOa4a6pfgvlmxRjMoI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il51EeNVFr2/DpbpgKOUbyyfPgSd2Tse5CRKir8YZZJRfZgGwQAharR4Cs4j2Tvq4sfTAleRPAP5wlixmhV1AYbN6KSYsZOERoIN3M9R5ETjtJ7u953Rz1z41N9ksm37asAZgOhBmLEgFw/mlrsSs3cH84LNv+gyw9dBOGhyppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1gFngkT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1gFngkT"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92eafc94c9cso438140185a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132455; x=1784737255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFQs0ZJlNsYll6k/LoQ4LeZC/2dSu3jvw5XVbC/DvqI=;
        b=N1gFngkTjadDeVCjuU8a55zLtcel4NlDXYEC3ieh9tB4xGtL1u+W2ArP8dw/NTFWo2
         RKEDk4owaoep4QrUjgz79LL3WDNmznl/wjBzWKS1zBWtLPmaTIRvmSn1LQLEiVXCpd2v
         dt/HaQnbzIg0QFaKrc4X1PUsVF2CVKoenKBHUGiZGF21EDRiT0M64h5ZPO/GfHDwqCK2
         TtzkrwDyBvI28Yr6k5hg5hcoBPdR58GtPXDRTmQiLt3tHgC29czXbc5LeWrac54jot0e
         Bk+/9upUriu6QLmJhWYDfSicM2GOVXdb60gv3SfOrgUEMgJlOzIMsEt3cL61cF4tk04f
         6f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132455; x=1784737255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFQs0ZJlNsYll6k/LoQ4LeZC/2dSu3jvw5XVbC/DvqI=;
        b=KjffLuoJwpB58wQjyex/Ibk0f5z1RyIy8tLCQfNPWlMr6lOsJGzzUiGzEFYkySOoXQ
         QVHXa0PfV2bkoJleMezMTwmGgVUycKDBqo/ux0XA4TzbodoQHlG6na4MnEzLHtmaln20
         ijfMwYqoTOfprjC8gdBMBenJYEcX3gpRtDtz5t7rbmPE4ICDiDKgX0IGkw17diNO16B8
         ixTjBWzqh6dVVuY53eTjVukOBhXegwt/ttjJwb/6pmZqtceh6ihKV4qg3tOvEDiz+mzE
         XWGDyD3g51fQOTxUEWwDK9RLaVT1i7ZVyYIAm2YTE3L+cq2sUViIhCs3ID3N8BFbGsQq
         eB5g==
X-Gm-Message-State: AOJu0YzFHaS9z4/1qHTbf6df9Xvr1g3gOJjfOY8c/ldEtAj6vbIE3DMb
	eeY563Fk47tBuyN0XiIeoQsJxC7DBs0+L0htsTi192LxKabngD438M/LbKtbig==
X-Gm-Gg: AfdE7cmKa9mABNoAg7SkhaejUdzIJbF4+BrVqh0YZyMaSF+6yTNzloox0sdENQL/SXf
	MCknxKK/AS9j8qGYlnA4eOJhZM7zjjwn3fSyzCvDqpmWmz5oDb6iz9b7meFbdxg0F/EhTQZY2EN
	mlpHh9VlJui1XQrDhB+oofPsCVBFpmfAK+Oto/8DVaqYLcRJD5XyF67ow8jOhHBEQt/u0jwwKcy
	1inr9/jt7qLuImIptZLtNcuU9PjxnrFY54bf5UWnIyM7/7JDnYZHZyN89AYemg1mw4EUiuR9VFC
	B8fg5+/PZwmYUAxRMcOEuTXX69YpfJ4XfkBTbpQqLtLQFZoI/pDCY3gmmx7tZhs9xJ7hP+rGaT/
	bQzjSFb/QLaHdOu8cYnfBheNxr+4ca4L2j22EX1hqRc4EvAIJms9AEK9pErOfSDfB/nl1Ol+vcI
	TNUsgDN3kYl+NzbJAObpSNqzOADAHe66BqqceQg0WrjBeBov1Tvh9HqbfFF3r3GuPBorGObb33F
	XA5Cg2HXPSHfWTj
X-Received: by 2002:a05:620a:4611:b0:92e:6c8a:2a1a with SMTP id af79cd13be357-9308683eb04mr770892185a.7.1784132453721;
        Wed, 15 Jul 2026 09:20:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 06/10] sandbox/seunshare: remove files under tmpdir as user
Date: Wed, 15 Jul 2026 12:20:32 -0400
Message-ID: <20260715162037.42329-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The files under the tmpdir are user-owned so removal of those files is
best done under the user's uid. Only the tmpdir itself is root-owned
and therefore should be removed as root.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 53 +++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 7c6154e1..c60b0e3e 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -486,7 +486,8 @@ err:
  *         not be followed.
  */
 #define RM_RF_MAXDEPTH 128
-static bool rm_rf(int targetfd, const char *path, unsigned int depth)
+static bool rm_rf(int targetfd, const char *path, unsigned int depth,
+		  bool removetop)
 {
 	struct stat statbuf;
 
@@ -527,24 +528,31 @@ static bool rm_rf(int targetfd, const char *path, unsigned int depth)
 				continue;
 			}
 
-			if (!rm_rf(dirfd(dir), entry->d_name, depth + 1)) {
+			if (!rm_rf(dirfd(dir), entry->d_name, depth + 1,
+				   true)) {
 				rc = false;
 			}
 		}
 
 		closedir(dir);
 
-		if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
-			perror("unlinkat");
-			rc = false;
+		if (removetop) {
+			if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
+				perror("unlinkat");
+				rc = false;
+			}
 		}
 
 		return rc;
 	}
-	if (unlinkat(targetfd, path, 0) < 0) {
-		perror("unlinkat");
-		return false;
+
+	if (removetop) {
+		if (unlinkat(targetfd, path, 0) < 0) {
+			perror("unlinkat");
+			return false;
+		}
 	}
+
 	return true;
 }
 
@@ -630,20 +638,37 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free_args(args);
 	}
 
-	if (setfsuid_checked(0, 0) < 0)
+	/* Remove files under the tmpdir as the user */
+	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
+		fprintf(stderr,
+			_("unable to switch to user for removing files under tmp dir\n"));
 		rc++;
-
-	/* Recursively remove the runtime temp directory.  */
-	if (!rm_rf(AT_FDCWD, tmpdir, 0)) {
+	}
+	if (!rm_rf(AT_FDCWD, tmpdir, 0, false)) {
 		fprintf(stderr,
 			_("Failed to recursively remove directory %s\n"),
 			tmpdir);
 		rc++;
 	}
 
-	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
+	/* Then remove the tmpdir itself as root */
+	if (setfsuid_checked(pwd->pw_uid, 0) < 0) {
 		fprintf(stderr,
-			_("unable to switch back to user after clearing tmp dir\n"));
+			_("unable to switch back to root to delete tmpdir\n"));
+		rc++;
+	}
+	if (rmdir(tmpdir) < 0) {
+		fprintf(stderr, _("Failed to remove directory %s\n"), tmpdir);
+		rc++;
+	}
+
+	/*
+	 * Then switch back to the user and return.
+	 * NB This seems odd but preserving for consistency
+	 * with the existing code.
+	 */
+	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
+		fprintf(stderr, _("unable to switch back to user\n"));
 		rc++;
 	}
 
-- 
2.55.0

