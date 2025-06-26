Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A72EBBBB
	for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953512; cv=none; b=D2pvHhEyFlHZpVgiOdEZN7AsTC8aJUPbNYZTWLTbZy5lzGywijZoLBmTXIlf5XXnXBsajK8M2rL2wRSpVLjYOQ48gxS+DLiGki5ntg+35bMkhvs+xikFMApuAhP7TEg4Yl6O8I6D2QQklzvEfQbed5MagMoAwG6hnj2dD2Dfk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953512; c=relaxed/simple;
	bh=+SVU5ZxQz88mAZsHAik+Gj+h8rgeVpmGynIkpFdrmss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxNZiAoKY+n7DfLEJ63mDn4ASjRCajsvWoyd8O/rhiq3VldFV7kQrDc5r841ErNNWhxp24v+U4yveYwrGo8NLRjGBm3TCuOwLIYrUY+24e41mpSH2KGKephLbGEcco00mpG9cHPsJ4PWMWk631QTRHW+OsYlw3Cih/HzzQffEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7Qqb47U; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Qqb47U"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fa980d05a8so11215786d6.2
        for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750953509; x=1751558309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJYqYEmIlhp/HShua+CFBFLtj3sk71NMpWTn/rrLbgw=;
        b=N7Qqb47UzGpOT3dX0uda0jkqQceCyB0CLQpwE0pGgeyAw4RgsAcSQeXEquQejaS9Wc
         Xg2ipW+KY0XP2BDNEpsWTcEguocv1H6b+lWCXBntsdBYY5+DhO+Q0UC31kx2OfN2ZjKN
         a8L8CxeDveiLLP5Kf0p2kDw5L/JqR7iTvNlzMsKLzEs2Ugk3ThGAqNmwFbzNDPeWZEWK
         DvZk7wF0xdBAMavOVDr+msOrVP1DUy4xZKuXMGAzY9dmLlIf5OnArdR05L0oUuqWVICS
         17icItvO1HC1KgWVo4nxUK7J4z96PRUyRPAMxzToYeBzMtWtBMrPdsAWZlUNhfOrMKri
         hxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953509; x=1751558309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJYqYEmIlhp/HShua+CFBFLtj3sk71NMpWTn/rrLbgw=;
        b=lxZgSI6wCZAUHFJpVADGDc9KM3oL/FsvG7ut/dmHHStD93D44VE3B14LQUP5ey8GCw
         pkH/3OxHC0MphcDH17R/bkfUp4UgjaTFmpHlVXo8K14NkpWTC53NSJELf8wnMmK8l7cZ
         oRfc/sBPiIwN4/k0nTj8DRPPY/u9M19qbhDArUHQyuk1Rj0puh2jgl9wbn3zf5A7dWc4
         Q3OzPYHJQkLcZZ+g1k8WVx1iLvINpp8VZmkZz4MdtGNN5xRcCgdJEEl16xBiLmRjkh9t
         RDJJhNryTvSUBkmWgD78ZzybFl+ZMR+kyymInmF2Jv+U51SdPW4wzFqFQS8JgDWPhcz0
         HhmQ==
X-Gm-Message-State: AOJu0YzJNx94YUbCJGBHPD1tGTSUxxvqjiYqhTaSyfyLZz02/UvL1LmS
	L6EjAKiQsGmxx4KxfO05daNHQ2MZI24DwmhJjaUA8cyUy71P7mFgbSNNzXIyvA==
X-Gm-Gg: ASbGncvM3B93mw/93ajJQCZz6uStY/yJxNWAO9WnA7hl3+0FNAz3J3kFM+wJuHP7rzI
	wxVlP5foffurcMpwNobBISz26/vQmnIo8RLmq0auxRMJcb0wfBOUuuYWTPJmKKsA3NVJFRadzaS
	9Pp33QF92XbxIoUYNz19GmsOfpaLGft0IzGtCpLV+340ZU+Zlm0Jwom4TrqQeCUP8P+86lhtbSa
	6O6LV2O+s+tWm+vqFNguwDVIP/pV4EN5+nkR6VPeXZSeEjAAqd3OL4su3Wd9BE/TqKVYlwUXJkp
	1DmS4ZmDY+DjNUnj0uXCCGT004+jFYA1o/cPiCj+a534nIWCTSzVoa7xMexwATGwY6aTRbXpOPO
	NCLBvIajT0DrknXzfyF0vJbtDtyuqXiD3HVfLhAUuA+3Oe6NM1i95dbHlws7a2Miq9QXk/LKbGU
	17ZbNxfscdj7LVEAg=
X-Google-Smtp-Source: AGHT+IEB0mOybX5A2I2WI94gKbIcgyMEtBXpIo/hyArb9biM+doDRI53X2nXfwVXf+w4vTzcRKt+Hw==
X-Received: by 2002:a05:6214:ca6:b0:6fb:4b54:ebb with SMTP id 6a1803df08f44-700026284d9mr542186d6.14.1750953508987;
        Thu, 26 Jun 2025 08:58:28 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e4fddsm8865486d6.65.2025.06.26.08.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:58:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	lautrbach@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
Date: Thu, 26 Jun 2025 11:57:56 -0400
Message-ID: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
No hurry on this so feel free to wait until after final release if you like.

 SECURITY.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index 4f624f5d..2fee4927 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the disclosure window.
   *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
 * Paul Moore, paul@paul-moore.com
   *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
+* Stephen Smalley, stephen.smalley.work@gmail.com
+  *  (GPG fingerprint) 5073 3D29 EB3D 5CF7 17AB  32FE 100E 57E3 3B8B 54F2
 * Jason Zaman, perfinion@gentoo.org
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Steve Lawrence, slawrence@tresys.com
-- 
2.49.0

