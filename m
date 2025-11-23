Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA217DFE7
	for <selinux@vger.kernel.org>; Sun, 23 Nov 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881143; cv=none; b=P3nRMWwp6jAxvsO8zSvkb4HStQHPRyL5EEEf9UhCJxh03zZAdil4ANGe4dsl7t8V4MB5djrnMhs5h3d/vVmveK7gdVlGMWv74usKko0ap86BBDcH6KcO6it/hdBUwkX7IpZKKBIiXtWMguL2CXvP0SFJuCIqiE7wQ92yJP2EFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881143; c=relaxed/simple;
	bh=gBWUOrIi1NetHapLhOyB2YubOlI4+Y4Go+GQYb7XXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ky6NFAV5TVM4LkvNJ6b2LH4STjdoUdZBME2ldJ0j+20HYn9c4EQBeiUwN7QUWAADwAguNJV4ujeZtGKd2qDxfjHTDVaA2+PJ64VdYGFc+81b7Yd4XUaO5bimII3ScFUux264rGMQrVOPzAXBo6SM5SzAsqiPEqU5Epx9oyldUN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5QoVh8j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5QoVh8j"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7373fba6d1so533708666b.3
        for <selinux@vger.kernel.org>; Sat, 22 Nov 2025 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763881139; x=1764485939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/CrVnV6p6oZCWoERaoyRUb0oKVoYmXObMFTIsxR7G8=;
        b=h5QoVh8jZojAOc1/04UXUfVt9ie/cwfF5jIrlBRAkSLzBkmPLE631KglVb/z9mqpWN
         HGhMkzkoYRP1qQCBZhzr3Q6dq/Xefpsr6ulaSjPgSwjfRtFVJhng+Upw00rB0mi+NYAQ
         l+Bj6goc5YKASSQwGixcNLVU+PuRjsVpLxZvpeorAkPxx0SIVUK5AClg3Mhy8zjdiqVo
         1rkXc+kxC/dlFYEJIFIMwkSLcCcFM3Tfaz7kBsDukUsGr0131RF1RCDVFRVtfLYrvoNY
         SlxbJAOA0ds2X7doZfwKWs5R4sCN/KrHE9LZtXsmyNpJ0yxFqJG59RY8beSNx4dFh0LE
         WMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763881139; x=1764485939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/CrVnV6p6oZCWoERaoyRUb0oKVoYmXObMFTIsxR7G8=;
        b=MycuQC9yHk6L1BTEcvHKBSk9Zlvm12ho0xPkvNHpqgSNFqjrCvE/9lLfHFB7o/ODxl
         I5onICNvcewl7SVaWveVzUh+3uDPLClMZBEnicfdazKpLk/nOumBrLkYDt/W0mhCOz8Y
         Y9lAka+shV2h+J+MvbNAeDEwkUA7E1UlOlG2975U40euVNGUDJuJfGvOQNkFVc/gz24r
         ZLEbisF0onA+H8VFkXo2Fv9qO3Deq7E+0/VU6Ym/o1D17i7D3j3GKMLdtpSQxlllQ2Rx
         Zs7Vn3f8ajGoDsCeftY7V/75rO614pQu4MUYGAYumVYa4fVmg7zQQJv2LQi8crQubPXN
         +qig==
X-Gm-Message-State: AOJu0YxQyCfe7D8dApM4dI4CVfU32j0lByOURpxrpyGsJRKxopVYNvuC
	8UflvKf5GhTE+vL9LfENaOmPJoLDyyZOZcCf9/RrQBe9FqcFq42wrnofdvcGtA==
X-Gm-Gg: ASbGncsMjLieZRVzap8Lh+ZukGo+RTXITWJOb7Y/9hPw3lKJ9JP8DC6ZKP32/Zl0y5C
	njHQpjHHGvRsK47gAxd6Yzvex4/03/MWcQSzVnVBHUx/ZNoLczQmU31erqYzArtqJfBJ0UpT75Q
	Pth+tPzW0ZZ8LYVqu15WZq/DFK7Zh3+VGfiza4tvRvbcTfMLvQbVrpvIa4VRk/CAFnv/Cj0Yqez
	dqUcYkF4HW5JYTUiHsnIUeAPep2yNr/FZwrLdx+VvBvZaswaqfqdzQY6Tt9RTh9HNZnLScmp3YK
	z34NpcfPC/+iOg+QJXEPM6bDTP3r/jrCd5EUcRwcz8Vbz7sJDClz0v3Az8LdguIKIwcSJP//s9R
	PJYYwN6cNLrwmDGmVXe0uwbmFwSYHVVJ6KdI6qf5z7Qm0WRzYfLPHZtXQic+ecftWD5pKppgN2i
	ailcTn2qac1A+Lyw==
X-Google-Smtp-Source: AGHT+IHlkpjNcv4ff8ADzfg11U8tXJsDKke+a9nF0CU89/3LyvAUg1+t8vKUYeZlFid07+fcWZifTQ==
X-Received: by 2002:a17:906:6a13:b0:b72:c261:3ad2 with SMTP id a640c23a62f3a-b7671ad9240mr729335466b.50.1763881138794;
        Sat, 22 Nov 2025 22:58:58 -0800 (PST)
Received: from graphite ([2a0a:ef40:995:8600:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5e0sm984295866b.1.2025.11.22.22.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 22:58:58 -0800 (PST)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] cil: reference guide: remove extra @ in valid symbol chars
Date: Sun, 23 Nov 2025 06:58:43 +0000
Message-ID: <20251123065843.377806-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@ is listed twice.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 secilc/docs/cil_reference_guide.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index 5ae5a3a3..bcd34b68 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the policy. Duplicates will re
 Symbol Character Set
 --------------------
 
-Symbols (any string not enclosed in double quotes) must only contain alphanumeric `[a-z A-Z] [0-9]` characters plus the following special characters: `\.@=/-_$%@+!|&^:`
+Symbols (any string not enclosed in double quotes) must only contain alphanumeric `[a-z A-Z] [0-9]` characters plus the following special characters: `\.=/-_$%@+!|&^:`
 
 However symbols are checked for any specific character set limitations, for example:
 
-- 
2.52.0

