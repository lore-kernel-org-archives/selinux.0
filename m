Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61B36CE00
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779552; cv=none; b=CWpc//bRmus4Xt3pE7vhQoYzPZ/S8zxAYxTaBO0cfLDB0F0mv4s02MigSWLibR9Qi5BBmdrpMfKgBS9o3fjif9QMNA8Q7YLCq88S9hWABVZrtf/idOKhnnp/bDXkMc3a8a6IoX9p6leVkDeNnfnlNetrgc1LJJtw/0F9PvfZuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779552; c=relaxed/simple;
	bh=kEhFmC2LWgzBO4CSWHt4w1OcSYo/vro/BL/S5oh7riQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0Mn3StqcDwpsSBVPKvpa5R8HugXaalMjxw+NoX5c2KIvZn/c7IEfiZg9ZpbWb4lP9HgYIXu0XVSI3EGqJ4DwKeHoH3eoL41F9eDKAkUEWPPuUuHyib8hkNE0HJ+vL/zO06vIh+UeJ9rz2KXojBm3ZQJY31KoL1shJIVelLH1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2+wcS4/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2+wcS4/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d56eaaceso670838985a.0
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779549; x=1765384349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8Gg2SXaTk11PvcZgTejNXGj66KufXSCUUjfmtwhnI=;
        b=S2+wcS4/pFISQxTa504HyxjaHuHVw8AKsTk4pFdfOUOx4AlpCzWk44+EMXpJfEcvlZ
         eSLcb4K7S82uIgpzNWtTf7Q5hTeQRrSlUTam4bBZeRsG1cAwTfVCqFRNKXqixr+dHYGz
         FzcOGvvHw2CWlc7xltiiUwfTsLkC4NS0l96XhgVRzr3wFGyl9BSy08l4ztDCBEwxubvn
         S2T9/2+7mndu6lybunDxwh1M3pRWCLps5IZf5HtLofyWAKq1ng0bUzH4ZvZlEWCTalqk
         /nawvwpaxPS7yC3dMhNyLickZ5crm1+s+L6dejKA8Os3eEtbwv+YSHl50cj1YxKE98kn
         aHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779549; x=1765384349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb8Gg2SXaTk11PvcZgTejNXGj66KufXSCUUjfmtwhnI=;
        b=dmtMmBUUhkEYBk4qTp2lTz3+85K0g4tnT5UemDQ+8jEZ/h2Hu6AAIkc0Bed+DDwX7y
         GS6YrjW9CyNfEoTNovPowhrbzPPSWN3ZBSCUP9TFblOIBVg/ESV47bcrLKaVbby+ecCz
         x67zyIAxbTl4b8EOSVSdBAdbCTCIXeleFbkVVn33pR7mWpkIiRL9bpIYml6hNyhESSdw
         k806cSxPRaW7v9pv3eanBoseJdTm0DkXL6pjz/JLhceujdPxMWP2Mq47Yiu4E+fOzd6z
         +6hht+qIc5Ea8tPadYzI7oE9zr8QB8bL26OlJEzhnQMF2kuqGDhptGJLooXk2pDBvYFy
         Yz9A==
X-Gm-Message-State: AOJu0Yxf53si5n6eSLW960WGF1wA952QtF9nNcH0cVsrxHTR5UeEXj63
	adXwXWRVCMlW8zXB2eJPG+ZCBOjzFaFCJI1K9IYSREUaVr5333yBxKxiLlxvhw==
X-Gm-Gg: ASbGnctw3bU9NIM5Fj/tJJSlQZtJQXNmdCY+G179sCpE2EtHBaECKEolt6AySi7HRbu
	MyuShYgxpbkXnO71I0Eq050p9hyqTNO8sZtaV5Ycg1f43IWIgP/kNPfBaM8ATEmENj3Je21Uw0i
	4m5Pl8qUEBn5WfWZrZZPSzCga+i7rE17aeXTug7cbL4RzU6oNyKTJTDZIUgKXL5sCIiaMK99ffj
	RGeSQ04gNbHtKmH9kXG5PumZ58jm28BFm+9D6lfqsuyC2NIOrLaHZ0PVMdnPGWO5pao5y3M2Py4
	ihpjRHjM4l2S9CgF5s6AHAYJCBdFM1c0saoN0yMJiMzs42uB4bfxrBwE13hlXBgCke42CLw9lof
	55AMriNfOFGhOeV0IxhHMvuP7lBRV1EroA8LyKHLhyqlMVrGEqM/f8Bl14bN0fu1O8hQe4Xd+e+
	fgFNCn0h/aRZ6JgJqJaqJXZvSqoQ6GzQ==
X-Google-Smtp-Source: AGHT+IGfu4Y4ibNcACaTqlosJqOW/87/mEpQDpliqa4Rr97JvFWv8UMujXSm+12bcrbL0UXP6613qQ==
X-Received: by 2002:a05:620a:440a:b0:8ab:5cb2:1f68 with SMTP id af79cd13be357-8b5e70730femr390265785a.69.1764779548773;
        Wed, 03 Dec 2025 08:32:28 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:28 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/6] Fix bugs related to policy declarations
Date: Wed,  3 Dec 2025 11:32:12 -0500
Message-ID: <20251203163218.54939-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In testing an upcoming patch to allow type attributes to be associated
with other type attributes and expanding them before creating the kernel
policy, I came across a bug in how type attributes were handled in role-
type statements. This caused me to take a closer look at how declarations
and the things associated to them were being handled.

With these patches, I feel that the code in link.c and expand.c is clearer
and more robust.

James Carter (6):
  Fix problem with bounds statements in optional blocks
  Provide a better error message for implicit role and user bounds
  Fix an error in the policyd validation of user datums
  libsepol: Fix processing of levels for user rule in an optional block
  libsepol: Fix problem with handling type attributes in role-types rule
  libsepol: Expand role attributes when expanding instead of when
    linking

 checkpolicy/module_compiler.c    |  34 +--
 checkpolicy/policy_define.c      |  11 +-
 libsepol/src/expand.c            | 396 +++++++++++++++++++------------
 libsepol/src/link.c              | 153 ++----------
 libsepol/src/module_to_cil.c     |  23 +-
 libsepol/src/policydb_validate.c |   5 +
 6 files changed, 296 insertions(+), 326 deletions(-)

-- 
2.50.0

