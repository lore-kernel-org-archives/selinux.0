Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B54AE8C1
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500576; cv=none; b=oJzPxmmKj6rYyuTVEBZpZnJXFdLVdrzzLJ3YZM468Dx7LIuPY/JW+vbOQmnQWbLE7z7zmy+kReWjWBkfmahXqveHNzpYI8jlMLMSfW1qkI0mBjxg2kE1krMhuARhSqJWe8fYic9fghua8t6WQBodQ9IA0n/gDqbkicFs0tg68f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500576; c=relaxed/simple;
	bh=1K2YXLOotAAtBVRqrmzDosJnaI79ZPDH6bT4X3X3MU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGKinTCbTzFpo3z53rBwXDa3PoMucpP71vTKVhVrXySTuEOYv6/rSflA6PwGyDkYfx1avofmgKIjUeMLARO5l3XvgxPBhj0n72sbm4Y8mR4u1SREBnYlNqGXDcIj1dfu0xpV2/4PwrNh4sNWgOc8B3j/8A4Uewo7Iqkn0vmscC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg75n3Dp; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg75n3Dp"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76798a2so199171cf.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789500574; x=1790105374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2t8Pv0bMKhcwsl6d0334iOLDi69rB/ROsm69P5ou/S8=;
        b=Mg75n3Dpq74ImqFr+HBmcas0cBIN9J26zJDmnCGNTGqIlzOo0CQ6Xt5R9s1yqunoXd
         vzNTcFXi5vw0LuH7+RS8UjHbL4d3UE6uQzPyylbuVHaLd/aidtHgJBz8vrxdM2yVmFyI
         mCGWy9ijQrnwy5UhBQSWL4YSIQGdKrqUixxAWM8u9YlVZZwq4X4xkzCB9wt1e6zhFpc1
         /qsTiNpR/2fB8imVwHBtCNQWOI+dNMMFhLp3LvnDA75kCRZWs3ZsSqmi5M5gi3MIqSOn
         Lm2eeslBrk9nDrv21mPCX9x3MIK4+8xtGDjlcWbYI79Wr9cyJ0GwX99TrsR/fwjf9KZH
         DLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500574; x=1790105374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2t8Pv0bMKhcwsl6d0334iOLDi69rB/ROsm69P5ou/S8=;
        b=zTv/nWFaUJP08zfTxxezVp0dQjKMzYqkDXZZggxay8dFLYzqpLswbVJlfcMARMqv4p
         qZ6iRSjpRVltg2fHy30fKTHiKqNPyQkbG/QlwYAH1N9lI737z1WUQO4k6SvnxRt7DeC2
         q+wTcU4cQErDH78ejf6Q9cAp0NqXIzE/lrxyddxTw8MBxWDQOiORS1zSdn3/Gmd4QTLu
         pyE5Ep0PUPZy8Ltjrp22WkzwOZiyhDtNDYTsU8D24RCfPtA0WhHs+0of6We6f4O9ns+y
         eZO1H5TiERt3/Y530Dcwm7C0x7plDySk4l3OkGnH6FbbeZpE0Vdv2wPQQ2kM20Su2B2B
         cA/Q==
X-Gm-Message-State: AFuF++nxgm1sn8DwugFurV+o/oW+j+6Wzj8hX9KmG3J2LleK0wUzKlkG
	nbJ/hYfGu8Thpi1/Mftnu/Qc1TeDMPttsDY2UH2T3nrBdWTmf/MiNXxoSNJ9nw==
X-Gm-Gg: AYBFou0CFMOYhWCzUsiwAtK439+HJk1yuv8THVaHnW23Jvv3uJbu6Qzp91kidcrXpCm
	nX9G9sH0VnvyLDr1Eb/YBQebHUH6OqG4cNyYGh0DR6rWvgwwOxmdPb2Kf6frk5e9VwHGKoqoods
	k/sqWsaDkrlT0i4IEFeLcNyDvufn1D+HDpIQw3I7qG85FHQjM+pGca6mFVzf9i0FskSD7+imREg
	IyDTZ0E0g3nRBkkhTJ43XarKWXN7QH3NhX85/qc/tTGknYhE4zDcFBNzEhEQV/eprZC5SukXsmK
	VAzAQ3DwBSz8CMp9qiH/S4Wu7TJrJF2fUscd1yVBCCzDIo1hGQ0LjlYMp9yX1M6PrPGdcE8B9li
	Sru06/Kt8UsnRjciClIe6sb7lQFrEzcq8Drm5XNc/b3WMz4sEUr2Axe/w3VGCe/kEWcHKWEwPUL
	u2cV+T16KYcjyBUSt4DXUsaaP4c83C1deYYtuAysKDolNVvxiwYHPlatVrQez8/5mL5+BoeJE1d
	zGwExiBZcEIdhkcG09XYwCvYOmEdHcxAeuEFGRDwekXeBKdD6QIqr51sO49xx5pLGSSdY+xlLQ=
X-Received: by 2002:a05:622a:86:b0:530:cc3c:c63f with SMTP id d75a77b69052e-53119e6770fmr70693601cf.19.1789500573975;
        Tue, 15 Sep 2026 12:29:33 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620c2ffbsm2151111cf.27.2026.09.15.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:29:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: drop dead store in ocontext_read_xen()
Date: Tue, 15 Sep 2026 15:29:19 -0400
Message-ID: <20260915192919.64833-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c84fd6e3f40e ("libsepol,checkpolicy: reject out-of-range
pirqcon values") left a dead store behind in ocontext_read_xen();
remove it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 60707fb4..9716f5fa 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2582,7 +2582,6 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 				if (pirq > UINT16_MAX)
 					return -1;
 				c->u.pirq = pirq;
-				c->u.pirq = le32_to_cpu(buf[0]);
 				if (context_read_and_validate(&c->context[0], p,
 							      fp))
 					return -1;
-- 
2.55.0

