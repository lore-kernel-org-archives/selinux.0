Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028722E62A9
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433643; cv=none; b=WYIicfPzYcnL0LNqia3kMKWo8J7QkCvR2OIky7/joelAOtmfCARyodJ5zjI6RZ1hPFO2VRCh7khjlzsSr1jom+D7VlL1LAkyJ9ol0edStTuQUX+385wdg+poLpoAE3q8oMNk9mq8TzLPcYKyBmuj9zr9D1K7kSntvgOhD48p4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433643; c=relaxed/simple;
	bh=mPv/CdezfChMWXNvxgTPmGjPnN9Gv3fZCgQC/JF6pkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boiFir6baota7ZpszIsWMs0LgFDmx/9tMD3PMrfAfk8h8ajR6PSnVoibl+NILJFNa9qNaDjjUdaVKED3x2JHDcnA8qGoPBetqGOGcy8Ca85EQUdgJIwxZN99KgvIIOpH6Ma5IrHNB4/36JziPx/8dyL78q9oBJZ0AW8IZUVefhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMzgepbI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMzgepbI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a7629380so29852295e9.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433640; x=1781038440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpG73LPossZ05TbFRHwawmT/qm5/7jVyHiEC/pW5aZE=;
        b=oMzgepbIFvXVuljMR/p8yY+ch4rGaCwhptFMQgyhl327piixnh36/hK1nn+wQ9401Y
         3YZNo/aJnW2qEyGQd2OtbMhI6TP4KFApzlkEqMi2B3ME4mPMPQjcBCcBDU6jyQYhh28/
         aoQK/T7lP04Qu6jNl1Y0thw+LynQFGttY2WSxaClDQwh0vdKLpISrPZ5tl9MHqNmd69I
         KnaAj3VxaQO7CfOWOsYRDW0rKuS0d5L0wDongWyawJz9ldX61sOq+Z47+m8Ud6EmMpn2
         Ka3UgEU4O06LsKKz78Vt6ahDYMmK+HUxQ4ciQTaOyf32HMwDPoajE8DR59pOMZKylXDA
         bH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433640; x=1781038440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpG73LPossZ05TbFRHwawmT/qm5/7jVyHiEC/pW5aZE=;
        b=UkyuhkfqlGTdjCJ6xQbNL9btfkvhCRwRBUA9U3SnMTKK7JYqXhWmd1H0kpOrfl+PiZ
         OwHJtl7x4WHBPL6im7qu426nLDtiwrJMRVQRbF0RAr5gHRY2E4mz6vpUb/bWqafO4YfH
         v32yfjG64Fw+s6qZ7czQ1dnSHP0EMRGZxjd8415NSZBt+XqM0j3VlcEhDAyMel4kq/AA
         fSnAj37kITBGppHKc5SjFvlcDFNFhdRn0jkX77QN08AKMAk89GL68zhF5xjoajC10ArN
         W6WTReIby5+aD0oSncjacX/pAeGp1w9foilRcefk03VJxdc4nY8P37c7qEdmUa2D3HcO
         ZphQ==
X-Gm-Message-State: AOJu0Ywj/xAEEIXTHTLXryJSP7m7MGTicxL/e9A7y7ywGfRqHfq05Wos
	GJgZWwBFf+lE81R6uW0s5UZGgK1LfUu1bUvw7zHtmY59LscT//UtcxuZ
X-Gm-Gg: Acq92OH/akm2XYHfmdjikoB7FUaaFryAfUjXnRDrjH4oLlviOoJd7rJ4qpr8BfPj/3l
	pUEiwczq6iCaY9q+GvZ+S9bDNsIxTAJdMXuPeSsBcacJa9xipDNG+J1II6WwKiZPKXjhF+nlfgw
	yJ23yv9xujzijNDVDAnej39WCW1SFhX7b8Mt9tI0/8eLM+gMF/GcJku10tHnp8Sr4lZ5FNuLPqi
	v92bL35DstGkLj1gAXiq/ilkXmDtnSVfy+3bJ7sAQVM6iVdkWX+f5RcZZc6u2SWZjaO02j9MMVM
	RMblbSUqYMVl4G0Vdm1uWx/CZxhwZ+6uVJ9HBnzW/ux8pKBXNd5Tn/XrjecVL7lUXGep3CbWWmx
	+G2hjAGw1ZBBrvbNO0hiAjjKCBvIlKP5tUnSs1AN2lnlanLdbjUlJfadYsEm9lGpXm8TnEQuc0i
	2D6X/hbRjX9WFWaqYgWDB2sw==
X-Received: by 2002:a05:600c:4712:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490b5ec4258mr6527185e9.18.1780433640360;
        Tue, 02 Jun 2026 13:54:00 -0700 (PDT)
Received: from nz.home ([5.80.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b575aaa4sm3901395e9.3.2026.06.02.13.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:53:59 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
	id 240E245F247038; Tue, 02 Jun 2026 21:53:59 +0100 (BST)
From: Sergei Trofimovich <slyich@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH v2] libselinux: drop long deprecated `-Wstrict-overflow=5` flag
Date: Tue,  2 Jun 2026 21:53:43 +0100
Message-ID: <20260602205343.3692139-1-slyich@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAEjxPJ4DhfG8-p9=B5fvv6_GFNtEg7T-KekJyXsYQ8TmJzabKw@mail.gmail.com>
References: <CAEjxPJ4DhfG8-p9=B5fvv6_GFNtEg7T-KekJyXsYQ8TmJzabKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`gcc-17` formally deprecated `-Wstrict-overflow` options in
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=b31a43560e88600d412318f75a43ac8e562ba8c5.

I only noticed it because `gcc-17` deprecated it slightly incorrectly and
started to fail `libselinux` build: https://gcc.gnu.org/PR125558

While it's a `gcc` bug `gcc` devs suggested removing use of the flag.
This change does the removal.

Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c62ad1ed..373a6251 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -65,7 +65,7 @@ EXTRA_CFLAGS = -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-	-Wstrict-overflow=5 -fno-semantic-interposition
+	-fno-semantic-interposition
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 20dc44eb..ddbd2445 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -33,7 +33,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
+          -Werror -Wno-aggregate-return -Wno-redundant-decls \
           $(EXTRA_CFLAGS)
 
 override CFLAGS += $(LFS_CFLAGS)
-- 
2.54.0

