Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819E42A160
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435192; cv=none; b=LXmK4iBw6fjgRysJSWJv8MHUreIDmLYCN56dS87tvLM/u834DJpQ4Y8DsVlsAM8EMd6PIJvngs1ivxH+WerX6/KzGQ5RQ6lHj+Z/8okI2HCBeeFjDvjFj/ajOsV99g6s/3G2p8v36DaRKNMCfRg6Rb3DXDq5Fxe42BtNphm/764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435192; c=relaxed/simple;
	bh=BZxZuLir9/1a/oYRDg/n+cRNA34lm1C5Fbxc7kOYpEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mm/UizdMLlTAKl26VvOn0nVspW2FrGvUQ0CvNyGlKDAlAGNb1l7ZM3gppcs6YReUbTIlB4b+/j7lyh1PXrxOH2ixZQa1lhFApM0INg3zd94eveaeeGusFK/+R6IA5yQyuJVSDV/fMr+Ne0fGkAjMZsk7Q9GeVN+Cuv4fyvtShYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbQm9ZCz; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbQm9ZCz"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-485ecc0f2dfso2569474b6e.3
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783435190; x=1784039990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JotQkYJsSJrNJaS8J0hWEmsilTMyQkVpzfpxW/mJ7Y=;
        b=bbQm9ZCzb4VHwBJiw0O2DGh+XdkXDI9QMvcMiFE/SAxQO5X9Zo7ea2UgRw6hh00D0H
         L8ekcWL8vrwsflaUx55dTNS68QoIQaoBYPJFJT5vug6Os2pAvPBSRmM80CnggnfHwig4
         eo6eBthTzLe6RbEhqERVWUw3TS/fA0kHp/p6e6KCfv9/kj8Hp1DV2YW9ltNODbTpZexn
         EJLnDxunaGBJ6aVAJF2a7ZFrQNMXfHfjq3S+n4X+Zi4GKNWPWkFDG6tHbQyETJzUMo2S
         18nrRWQHpL558pMm7BRqNyG1vPnpKlhfqPhy8OP6US3ecXBXDhPRZc2EyIhtCedAAevS
         lKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435190; x=1784039990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JotQkYJsSJrNJaS8J0hWEmsilTMyQkVpzfpxW/mJ7Y=;
        b=qHB+AZfFQ5d/s7aNEQphZfkBV6Ted0+0vlw9coR7UasxKpomOEUQMGDwgY/6W6Sa6C
         +8dwb6lPqDS400Omv6IlWdMSgJ1KVZr6FTebYixM/LTJJm90jfgbmP6UZIKr92ugRCki
         d+8l1NjQ+Uh+okO0sWrbHLjMm6jksmV76oHnQ0fTT6hzAAckAgX5/qxluo8oj1m/3eRA
         +NGAkZyzuWKp/67ReTL68r2L8ErVfzcEdHaiIA1LBp2fmaVOPL4AZO57/DoEvS4fwUbn
         V5pmsqlrOUmoklnIdQTtf2jmprW2Jc/6Tf1fycjsRNiOC1VdcpmysmhVSnxt1oyum6WU
         GYUg==
X-Gm-Message-State: AOJu0Yyd0o3Ct4feI4HZFoKQCCpJ+z87M5IbffLUVwYm0TLC8ps7bxJ4
	ogT2Vd59qXuzOgHw2jZ2npu6vT0V4TTirZUWlKweF5LX6/9u0bHP5PXwk280/g==
X-Gm-Gg: AfdE7cm8AXUqGLAt9TbR26/ik5uOwS1QI0LL6D7bYcoKaQO3DHyBgB0sIGXxv3D5DZi
	Z1Ce7kGla1+qwcSDeDBi+A9FBofG/U8PDsQxe8O8+wbxRN8FR3LWWh3+ep5LfyxgCRgsu45ho3O
	5sAlAdpNjznPUxaS76fhn0uIjwMQ3fbFO/OoY+pBFO+bHQuVCcsiAs+HRjsXP+8aeWZzhecXAJV
	1WEeAHsoqFkuJR2sK6/OGsbdmPJbISFv5zXWQN8ngDjI45OPe/+EnPqVCxd4pwiLpoGR072TZ7m
	j335kUvIFxMJUJeXvVt+G+8Dn1NQTl2Fvs+wkQhjZi1rhQxXl16CoHpklFPXLKGhomE07mrQZTe
	MOf/6y4GTI2OtqZXFX8LB2F0Og+lITrBByORAb7rzC/YlF86tTJVXRBQd5KHIUafLapilPRWcXP
	HVLTYFwM1JyFIVrZoWpEytTyk=
X-Received: by 2002:a05:6808:3505:b0:495:ffb3:f4aa with SMTP id 5614622812f47-49fdc6528e9mr4027966b6e.13.1783435190296;
        Tue, 07 Jul 2026 07:39:50 -0700 (PDT)
Received: from fedora ([98.97.80.55])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1af6086sm11094824b6e.11.2026.07.07.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:39:49 -0700 (PDT)
From: Bill Roberts <bill.c.roberts@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	Bill Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH] SECURITY.md: remove William Roberts
Date: Tue,  7 Jul 2026 09:39:38 -0500
Message-ID: <20260707143938.1653637-1-bill.c.roberts@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Bill Roberts <bill.c.roberts@gmail.com>
---
 SECURITY.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/SECURITY.md b/SECURITY.md
index 2a7ce5b3..a1d02c4d 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -38,7 +38,6 @@ the issue as quickly as possible and shorten the disclosure window.
 * Jason Zaman, perfinion@gentoo.org
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Steve Lawrence, slawrence@tresys.com
-* William Roberts, bill.c.roberts@gmail.com
 * Ondrej Mosnacek, omosnace@redhat.com
 
 ### Resolving Sensitive Security Issues
-- 
2.54.0

