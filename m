Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128230D41E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787847; cv=none; b=WV7dOA9NGDhFrUpqJHutMRPoa+WBVLhg/3EBvuVL8ZlzcXOdROiqotBJt5lLNiVsfvwYHMzTjpkTqsMZh0dv6WuWMgPow2Qw2qex+2WgUyWNTkCDUrd5WDHbHv3g+cU77mm5BRIYcEBYlOnA99whKk+7thrrTxTBRgVW3d5qw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787847; c=relaxed/simple;
	bh=BSJoAXUrW8+atVDp+K1KPlC3b40rN52b0qh6QSKbifU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6GU1eyiAdTVewnDzddYNiS88VxdSpNk7ypCJDTCYYlgIWBnXCoHn7g5htCMuicd/wP8XklFNF5B0irJu0dlbznzyxmvGyD4d/mXThO1HxhPTOQuYWE2wS+V7IvRr2IxEJcdVRjYFKP+CD4R01xLx+8aWqbKkgQHetJpVoxEfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b=BqfG5Yme; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b="BqfG5Yme"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb7926836eso216153a12.3
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20251104.gappssmtp.com; s=20251104; t=1784787841; x=1785392641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTUpoBnujzYrtKeKZT8aRPy7+D9nMam8A6AhSW9oYjw=;
        b=BqfG5YmeNXQArdDuM43F2wvFEugO8/321jyMwoJV2HOG/CYNvFUJld4ZvheyIF0ceH
         wpHm6QClCgGHf4FAXS9ODMCPhCdQK64mPw11csCHtaJJDaK8Xtmhie93tQ24VlqgA57R
         021yU8Ing/q587H8HiekmLz5p4gDqFadamDIIkrBDgqQYSCyYnEKD8d/stpNHK6lGpwO
         tnd+4fdLDBvfXV3rPkZxT1G5cfC4pKplM5yO/wjDzog7LlJOtlua7DaWKxcexFs0tRA1
         pO75e+E3wUHixziWoht577i/b/l+uYKh8ftmsGHrzYWCwFefZwIldfkxPopzEdYevfYc
         +Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787841; x=1785392641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTUpoBnujzYrtKeKZT8aRPy7+D9nMam8A6AhSW9oYjw=;
        b=qxnXuf3S9fD8stKOY2+pkE+n5enaAFRbye+ZZbuY3Lep7XgfyEXT6zuEdbhRaZ5dGT
         +VQ40ldNkszkd9Erpg1ZVIxjK/QmrFeGSZKTHcK7wb2G3zIDJyK8uCplRRukqQjf6QGx
         ubI9j5V/lXcm2n8VAExqRP1JVKrRpceNv7SoCpmsMAouysv4UZzQzBd4GZZkfbhRXt/z
         G9PRFShmDxM0bEKIomsV8OwQNO695kTmYfGZXs1G/Yba8AchW2BdjEkfFsF1u+0pAR+E
         jaMHo7ehAtXClLY+VrzlC0QXCaNiDStNXRZAxpq5kuhSFcvDypaevUO+tnWbFM8aiL4d
         YvLw==
X-Gm-Message-State: AOJu0Yw1CmhuX4uej9U/ZbIZhc+S9yQf6B7hE6FYu+ASB1+n0aXyv5eX
	Vcp1ro/26nWTBOjByJWRPYG63KYPHKc3plXC5bm3QZ8cfkDNdH0dRedl7DFcHSEVe8GpqHTj8ep
	xGsoN
X-Gm-Gg: AR+sD13nuPtPv2uuofMfrUyaaFRDmGAjdkEw/EjxBma6+weaXmO2yxRZDdPGSb7ZLrT
	sNVpVAcMWXqCCenEmYUXlI4kC3vwhpmcXN8nQ5GJ1ewwYZrVIAJDrpk5dFkg0raDuZEtR/N+DNr
	LJlrixdsVhNy9WPOm5bN0Y26/taJL5peCBIhZXN7BHNGRBhfPLSLB1DyrEsQR6Jk3NogABULJfh
	l71W1NkM0aQbDrRcrKcrhbH5Uy62V1KeF0J5TyBo5C9nhfCk6GNa33hNHQ3+JDVZwUi+SQCwzgy
	LevNUqV22lwL6OeTRP1S46TA7YxL6yNFgpS1yrSBXLnHvpCvIyL1eW1syUXZvY/oAN/ukiuXIjo
	IBd7Y0sJnoizY9FYINbJz0zJ7ogCYIRyoNa3v20U/sf/cZgCX2I64rLOyzPoPkqhdYaXT6H0/gt
	c3xnror3DTRUDWwnx4CARsLWZPLpGpqoBh3DKh5u4=
X-Received: by 2002:a05:6a20:160a:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3c44b013273mr1833168637.18.1784787840492;
        Wed, 22 Jul 2026 23:24:00 -0700 (PDT)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm16654332eec.17.2026.07.22.23.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:23:59 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Cc: Jason Zaman <jason@perfinion.com>
Subject: [PATCH 1/3] SECURITY.md: Update security contacts
Date: Wed, 22 Jul 2026 23:23:53 -0700
Message-ID: <20260723062355.3096648-1-jason@perfinion.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of the annual cleanup of security contacts, drop people that are
not as active committers currently. Thanks for all the work over the
years!

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 SECURITY.md | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/SECURITY.md b/SECURITY.md
index a1d02c4d..49c40e97 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -25,10 +25,6 @@ the issue before it is made public, but we will make every effort to address
 the issue as quickly as possible and shorten the disclosure window.
 
 * Petr Lautrbach, plautrba@redhat.com
-* Nicolas Iooss, nicolas.iooss@m4x.org
-  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
-* Jeffrey Vander Stoep, jeffv@google.com
-* Joshua Brindle, brindle@gmail.com
 * James Carter, jwcart2@gmail.com
   *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
 * Paul Moore, paul@paul-moore.com
@@ -37,7 +33,6 @@ the issue as quickly as possible and shorten the disclosure window.
   *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4ECF
 * Jason Zaman, perfinion@gentoo.org
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
-* Steve Lawrence, slawrence@tresys.com
 * Ondrej Mosnacek, omosnace@redhat.com
 
 ### Resolving Sensitive Security Issues
-- 
2.54.0

