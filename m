Received: from mx208.easyname.com (mx208.easyname.com [212.232.28.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917E2FA0C6
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.232.28.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147595; cv=none; b=cRRQB4ougSX+KdfospSsZZ4b0FKmcQ3czujtOBxpQNsDNQD8GUqMCp90YYSiYNlWJaORl7NyBmEa4JdX0O5AD5jxl9An15UJIz9njdoAXJ+vbbBfRwOQSfeJutusPanBiZLXkuYAgp6bS7yt7s++YGCqVmEfnnd3dBoUk8mcEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147595; c=relaxed/simple;
	bh=+LELZDBKz4GsAjLlYRaqkJGwMp5fd0qB1bBSki/gSgA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ffXEanT0dEz+BXyiOg62vwcjabM0CO72fChJ1j3tp+3BPURw6tzPwKuWAXRi6IxDnNWqW7o49m6FSgm1u69m9WH43d2x1KVDUm4CoNQgp5GK4HY2ER3J3j98FNumvUiWYPLRw2I2k26L/amCQ8dKwN6YxEFcb2HmcmyvuNviZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz; spf=pass smtp.mailfrom=peppergray.xyz; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=bNoaomby; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=bNoaomby; arc=none smtp.client-ip=212.232.28.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="bNoaomby";
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="bNoaomby"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XGoWQBEsd+DU+vQNSnXoJI1yTElpsZJVohedkJlAuT8=; b=bNoaombyvYJY7twENVTYu2dTuL
	d/ITc0tJl0I+CxHZsIb+HTJKkFO3DZ+kk8tI6HTW+Psb2QL1SDZNgEDPZ43LSoFSl7v4JSbrndoJh
	zXa3/O5aJw9dLxhINgT8skB236mD2x+i2W9Ys0I/hYXlvfL6Ak/CpgU5wd8snDjMbhBI5zBHqdN5a
	FnFsQNr+1PFxe+5IyIEhmZZFsjxqEIu+ATVURh2Akb38sH4BcWSPNvg2Z7yDAg4x7SC0jKyZznOTB
	QoYtXklAR/l/BgKM/VlVGszvecoVzbMsYHLn9DuXRVZUW6mJ36NMJ82oV3TXUd6kk0nXhE1rsejbT
	Ge3JCToA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XGoWQBEsd+DU+vQNSnXoJI1yTElpsZJVohedkJlAuT8=; b=bNoaombyvYJY7twENVTYu2dTuL
	d/ITc0tJl0I+CxHZsIb+HTJKkFO3DZ+kk8tI6HTW+Psb2QL1SDZNgEDPZ43LSoFSl7v4JSbrndoJh
	zXa3/O5aJw9dLxhINgT8skB236mD2x+i2W9Ys0I/hYXlvfL6Ak/CpgU5wd8snDjMbhBI5zBHqdN5a
	FnFsQNr+1PFxe+5IyIEhmZZFsjxqEIu+ATVURh2Akb38sH4BcWSPNvg2Z7yDAg4x7SC0jKyZznOTB
	QoYtXklAR/l/BgKM/VlVGszvecoVzbMsYHLn9DuXRVZUW6mJ36NMJ82oV3TXUd6kk0nXhE1rsejbT
	Ge3JCToA==;
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <hello@peppergray.xyz>)
	id 1wKvPl-000Ftw-Rl
	for selinux@vger.kernel.org; Thu, 07 May 2026 09:53:06 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso995120a12.3
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 02:53:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQtZ1jiTtyN1tbccJzPOtDmh5zQKcncDfSTNi+mqMkFMSEgJwl
	ar+BxpnpUzjSuQPWth7SdSW4+AZt1R5EiZu+qKH6XOkvLxWNdY196iOtfR8LcG6GtHnhcxTcato
	oZyNqSujCDBjW4K+gcr86ZFmZAurRPNdg80fRBj+ZrQ==
X-Received: by 2002:a05:6402:913:b0:67c:e014:464c with SMTP id
 4fb4d7f45d1cf-67d638a7675mr3362725a12.5.1778147580731; Thu, 07 May 2026
 02:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pepper Gray <hello@peppergray.xyz>
Date: Thu, 7 May 2026 11:52:48 +0200
X-Gmail-Original-Message-ID: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
X-Gm-Features: AVHnY4L-Ohczuy8QLywmHfIy7wcRr4QRuVVLOCDNj_J_3XmScQDqMsKRpbNthRA
Message-ID: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
Subject: [PATCH] define matchpathcon_filespec_add/add64
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From ce907fb1daa4d165b29f2d91b3d0958e2eb7f044 Mon Sep 17 00:00:00 2001
From: Pepper Gray <hello@peppergray.xyz>
Date: Sat, 11 Apr 2026 15:55:17 +0200
Subject: [PATCH] define matchpathcon_filespec_add/add64

matchpathcon_filespec_add and matchpathcon_filespec_add64 are
exported in libselinux.map, so both need to be linker-visible
symbols

fix: #512
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 libselinux/include/selinux/selinux.h |  4 +---
 libselinux/src/matchpathcon.c        | 17 ++++++-----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h
b/libselinux/include/selinux/selinux.h
index b1431e5d0d..241bb54a94 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -537,10 +537,8 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the
    file contexts configuration.  Return the used specification index. */
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64 &&
defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
-#define matchpathcon_filespec_add matchpathcon_filespec_add64
-#endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
+extern int matchpathcon_filespec_add64(ino_t ino, int specind, const
char *file);

 /* Destroy any inode associations that have been added, e.g. to restart
    for a new filesystem. */
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 240c9fa76d..df4cabf597 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,25 +261,20 @@ int matchpathcon_filespec_add(ino_t ino, int
specind, const char *file)
  return -1;
 }

+int matchpathcon_filespec_add64(unsigned long ino, int specind,
+                              const char *file)
+{
+ return matchpathcon_filespec_add(ino, specind, file);
+}
+
 #if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) &&
defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
-/* alias defined in the public header but we undefine it here */
-#undef matchpathcon_filespec_add

 /* ABI backwards-compatible shim for non-LFS 32-bit systems */
-
 static_assert(sizeof(unsigned long) == sizeof(__ino_t), "inode size mismatch");
 static_assert(sizeof(unsigned long) == sizeof(uint32_t), "inode size
mismatch");
 static_assert(sizeof(ino_t) == sizeof(ino64_t), "inode size mismatch");
 static_assert(sizeof(ino64_t) == sizeof(uint64_t), "inode size mismatch");

-extern int matchpathcon_filespec_add(unsigned long ino, int specind,
-                                     const char *file);
-
-int matchpathcon_filespec_add(unsigned long ino, int specind,
-                              const char *file)
-{
- return matchpathcon_filespec_add64(ino, specind, file);
-}
 #elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) ||
defined(__INO_T_MATCHES_INO64_T)

 static_assert(sizeof(uint64_t) == sizeof(ino_t), "inode size mismatch");
