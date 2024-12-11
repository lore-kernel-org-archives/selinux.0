Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7F1DACAA
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933663; cv=none; b=sPxjRrRCcsD/GY6ocUfm/x4TiYvO2MuU3l2+5DeoqWA6wAnRZqzrcq1EKMq2Rg90bOmqM1d+83+H9MXxv9wlohuBE1j+JCadLSRkCaVVF8YQPQa4JLALPEzmRusKexXIQgk/9wAqb1kSHzuiS//0kTYKlFomT9dfsfEtslc5iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933663; c=relaxed/simple;
	bh=/NqFHTzlLGTn8j8gfXUtpQgXhLkGPyHRiPD0N3wMYk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REdubbK7TGKsxQ0J55k4Kr264luJxBL891MfSrtGoWyK4XRwHGc1Ttmn0MrSQGpufti6YQGpjrTiLbuSPWOSQdBfyRNeYW/TTrSfbnRJc5UzpQazpTDNoxRAWKirXmh2rdVFItQzry+nEqsMSJctauSo0QrOnrl2SuJZRrKfgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nudw0G+Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nudw0G+Q"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eff4f0d627so38368137b3.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933661; x=1734538461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khlMIab2G7Qnqnu2ehl1tE8BEbAldemlfNyTInB5uik=;
        b=Nudw0G+QsTJnFMUKl/1pZCNRGSw3hwTMvDyynL3+toh1cfzz+TP/miiSK1T5lKtFS7
         Yo9lGG4NsXkUMZMve4f2Ncx/7GyvWiGCM1+jRte8HnzVNHYYXjS4ql40wrxSl4ouAzEX
         f8+6M/LKSkXn3SD/+0FZ9p7p62mSraALQzaeOypZI2uG/5CEnt1cNgWBkM1yKVmf8eEt
         bRwD5cHz+EVwYOkLbK/3ajlw2mEYRnL9D3kG0ZAJd2jJYBOYj8+VQjM9TgGiiBKNLHC0
         D9tcSsDzhqOILcn1owkaqJUFx8pJwGDiznUdJOcN0wUIlshQijFvaib1dnz9joIFcgG9
         V4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933661; x=1734538461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khlMIab2G7Qnqnu2ehl1tE8BEbAldemlfNyTInB5uik=;
        b=Ymxi1j8WeRN0Cp3LXg9BqjnicdLWzM9TfdergmJ0cFwhmh41AE4BAPLc4bcVpm7IW1
         GPKqcvpCcEk2XRz1L9VFxZEklxRVbHDL6ZXqprjOrhAWeXNEH7bzbHg3g9SqwCq2TqDa
         FlGzkTPN5//0qzq9uWpG+NXNuD8JuC2A6zwc2rrnUXRYGI3EAhHYbGQtxuCBYJHmPN7b
         UN/PM2ARoXzNl4bLuRN9cKUefcXyiI8bCMGCm2713lCHD15EiVDRgy845to+iAXnMObF
         1V6jEyUJgC5f3+fPv0PRtQUz+p+lomg2DlyVy7YgJ1bVuk4IgyvmoFAZS2nkQEk0QwKV
         p/rg==
X-Gm-Message-State: AOJu0YzaHwi4zSAUAtNb9Ec+Oz16ZJc/K3gmw6Fd7svrdL/o4sXuoEwB
	JHrSGBIc8qON01B7mihPf8AZJS9upsIq1tMkb5JilHX7mOFddLyRKDW6Sw==
X-Gm-Gg: ASbGncujJlKMq+pYpYhEJrAb77L6Ywqpori8KDdLge6Lt1SY51Q7DXj7GNJ8NuuWKRn
	qivjoFTP/gMvRhIBTOggcQupCNRfE3kKPvwsC/VlT+O4HiSZRlzIOsYLoq6cRefefJgfYIiOW+g
	FfvU04+jMbymn5QniI1wQBLRYzpCxYY210qj9CLfn0VPwwj5YBbbGcc6gmODNr6yr57tZnpRtGA
	aGol9Wly6uNyqdg0xdRBCspQ0gbFqDjBlEs2TPzMIbNWxwlbNXcqWHTpFvuP87KD5NSqoWtniJE
	2JpCmjwmQ84=
X-Google-Smtp-Source: AGHT+IFcVgvTqEvibDro0z00/g3TrSO8c0F0Z4q8GXCqjC5m2F2C4hzuWuMW18Fi51b4Gi36A9Vy/Q==
X-Received: by 2002:a05:690c:3388:b0:6ef:6cdd:57e3 with SMTP id 00721157ae682-6f198a3c9c3mr809627b3.8.1733933661187;
        Wed, 11 Dec 2024 08:14:21 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:20 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/9] Revert "libselinux/utils: drop reachable assert in sefcontext_compile"
Date: Wed, 11 Dec 2024 11:13:58 -0500
Message-ID: <20241211161417.126236-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f50abe2a3aad0716a0711cfcc07f934f4a9d2b02.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/utils/sefcontext_compile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index b4445a1f..5d7ab301 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -188,9 +188,6 @@ static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
 	if (len != 1)
 		return -1;
 
-	if (stab->nel == 0)
-		return 0;
-
 	/* sort entries by id */
 	sids = calloc(stab->nel, sizeof(*sids));
 	if (!sids)
@@ -206,6 +203,8 @@ static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
 	}
 	assert(index == stab->nel);
 	qsort(sids, stab->nel, sizeof(struct security_id), security_id_compare);
+	assert(sids[0].id == 1);
+	assert(sids[stab->nel - 1].id == stab->nel);
 
 	/* write raw contexts sorted by id */
 	for (uint32_t i = 0; i < stab->nel; i++) {
-- 
2.47.1

