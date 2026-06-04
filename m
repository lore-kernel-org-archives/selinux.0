Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6631F986
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595744; cv=none; b=jztrTwMC/xZeWnMctXfEjHr+q+iy/Yj/3qp0ZKmqAMprFb4AHpww+8fkSnYJKiNRXswvQFFIkok2QV8xRks38zLIGbaHbiy83Y1I4y+E0IJZxIIk24F8jxjaI/f3JHhJwuTeKbqhV9gCV5/2JmroWs4pnqqQWI5WaTfYvIdWl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595744; c=relaxed/simple;
	bh=7tZsuTe35SCfNZqH3lTerQHEI+h05zE/SR3dGKuMDo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6PPjDgXR7lAFhF3D0XtBpAlNtUwtBhnK+A1P5dfwHby3koC3f+OIM6nrX6OM1Pg2tfcfVNQ138KczWQX7CnO+647YSRVzm2vIAK27+TYXUadDdY12ZrY6ut5KmKvO4ILvWvEe2Et4xMjSvwmF1P1fnG3vNb1FJ1EZ8Y6vClxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzKm9Ea2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzKm9Ea2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91550dda53cso138066985a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595742; x=1781200542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAZuk51u122as9ZO3SGLuHinEf3Zb0/UzwTX9BQhtvg=;
        b=RzKm9Ea2cJOrswqK1Gm1j2hEQPBtre0ANAkyvlMIMnjbph6HUIyfGgB5II/7QvtnLU
         Pz1CsBdLNmzFYh1Rd0clQFmrcxusER0YOpPRxfvqgpLlgyP8pJggMAHQMyui9+HAR6uj
         IS5O41xAHjW51Vk2r/4YCeJUP2W35w55tNWSiEFCc/rFNXZGuw+jm3LREyNWTPgBLO90
         yGHf6uLyaBQgLdOgK3Uswn8OBMZIGpQIyyWIyWWClmMjXQITVDVDbYRWpIO4Zr+ZxtFY
         5GnazuXLHpDWruDSwou5pRxqYVfNjmREsYVuR3+Yo2W28zDTr41Y/wF54Zb2EykhCRWW
         xdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595742; x=1781200542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAZuk51u122as9ZO3SGLuHinEf3Zb0/UzwTX9BQhtvg=;
        b=gQDHd70ZTkgxlyGgb4NBvgD8LEAW+TZwMyZ6kQCKdYwzROnhykfsKR2tr95ldn0qYq
         lfUWtcBGUKuKi68rbso78OsNORdxMl3Cc0PA4nfe8nyuChs1G81m0F+bxF671JcoWyM3
         XgaFYgJRrRsAvl4Vx2bvWAEYD9HdB0KEXkhDBudVaBzar0clVXonQt/5x9D3makfHGhQ
         M77LaM67so0Uq3ZOlP5SiQQFoE6LJqL1h/inxOFXa60UB4y8/ug+FP5jwkHkgqrpL/nv
         Og3b6F77q03w7TVAkNa+Mpvh1iMTxzVWoO8hLdFim2MUqNAbSahmX7dsxK/nKvOQPHe7
         R03Q==
X-Gm-Message-State: AOJu0Ywfkf/E1DUIeVRT7x0WQEJQ7jG9FMfChA4Vrrv15WaOIgszxazZ
	RhfxHjuCV5QnRjs//qGJ8j1tY7Qyd6kMouQLSiejgXOaK8TrSgtfquisxyik7w==
X-Gm-Gg: Acq92OHOBVCpxPt1x+OzU4hol9NC0pWFDIUsuiDisTqQabUqVXFLaIkh2eAazph4qiz
	SE6EOYXDBib70eFZRB9yNcU7CD8Mk0EP+sZV3XecCoOIfcqG/AgO9hQhEeQZ3+43flM0L9GfNBV
	SMkKQ4Li4oWAbSxhcKdzoOXe3Z6CQ8XGankTuvuHwcMeWWLcuRV05jbsEIYg21+x9WlQm/PrXej
	xCTbK+ubLN8wY8IhvBmOOtOrJsUteWUUBUb6EggOqHHXZ/q/6XK3CXXhRZfD6vpMwH/7B8n9sQe
	3x0xPk9mtJM2nrtSb6oT6rrZ7Q49nQXDv1PrXZ9L2QbmxTwPxK6qMzKNeMGhpw6ujue+HwACTbe
	t0YwC/aLmhdrqKK+wCrt5mZMKUDzR2pfLLRWtx1M1FuEd24KlZHra3FTht+aiCK7cjc1RVhbP05
	x8dFWwao78X2orrTs6s4c5qSCl7enDOffmC5omHhSX1Wt/FaHViygCeN3juhp/qg39ocQ=
X-Received: by 2002:a05:620a:17a6:b0:915:8f76:8002 with SMTP id af79cd13be357-915a9dc26e5mr25922085a.42.1780595741931;
        Thu, 04 Jun 2026 10:55:41 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm649688385a.27.2026.06.04.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:55:41 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Add check for too large of file size
Date: Thu,  4 Jun 2026 13:55:29 -0400
Message-ID: <20260604175529.42776-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cil_add_file() add a check for a file size that is too large.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 83377821..64d02466 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -549,6 +549,11 @@ int cil_add_file(cil_db_t *db, const char *name, const char *data, size_t size)
 
 	cil_log(CIL_INFO, "Parsing %s\n", name);
 
+	if (size > SIZE_MAX - 2) {
+		cil_log(CIL_ERR, "File size is too large");
+		return SEPOL_ERR;
+	}
+
 	buffer = cil_malloc(size + 2);
 	memcpy(buffer, data, size);
 	memset(buffer + size, 0, 2);
-- 
2.54.0

