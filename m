Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211B4C9573
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097988; cv=none; b=rZI9G2wuBNV8X1Km3di0/hgb7+4KEV2pjf8x8GhN84DmnQL2RMSHtSnz+SVf9GPJzi/sPyLTyHqbxuqqCRE9HzdXH9a2SE54i624Lc1sej2hWKZv4nkdV5F/ED2vpE7VFJGz5f/DoRnPI8lit89ZEPN5vltpkUfoj5ahegjCZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097988; c=relaxed/simple;
	bh=PztqHbVs1KLOSerB8B/t3xEI2h21FAoUuJeG/mcdV+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdkY7q3D+PUQye93ou/WOTwqXeJ4oezWJkZ8PgBSv7R7GYnOp/0i7EGiycxv/HFuOsLLQ16+Ndg7kAOR+uuNPDJ+oMwgVGsQcZ6gPw037bos4f4dSM2R47HNXApeHr51Ur4vGRLDbui+idu2L9X6icQF+3AM5Jcusg+gCrKNqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRpm61yD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRpm61yD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c52e25e644so115160485a.0
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097975; x=1769702775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkDZmRUQH2tGAt58EC0AYh+I6qMqVTFx3k1QJ/F1CHQ=;
        b=MRpm61yDr9oPBWi8F0LD1btVJc4yg4igu9psmY+wULvtsSP0XrN6Xg6uBo9kKKYBo3
         J+Dwmu6qG/bx1dvilcpGZOIzIeC7EIAZHk0KGFltKE2+CPQOLPq/LKI+4RGjgfUNF5II
         8cNGfq060qMuEzZvCrigJBvL1qgTYmeCGiKP+QzkvB6B5rfvz4zgGl91o+zGjLkqgmR5
         9nzKMcc00+dtxBPhA6EUdCcASl61+9d+3MfElMoJjO5nxlzvYZ/jaIo7UIh+ZPu87tDn
         rCNSV0ZRAkj6fdk3m8anK39XAKeGKkaTPgxvW6LGHft9GtCWDKyH3dCkvLkd2BHwQky9
         Lqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097975; x=1769702775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkDZmRUQH2tGAt58EC0AYh+I6qMqVTFx3k1QJ/F1CHQ=;
        b=bzQhl5chRDWf4qN+1Frv7P6Hxnn4hrnyfy+K1PZ3oifEu5CTIGuVxOQaSBHWkGyrZS
         rQg816KPk8WkYyypznghtAaIYY0AbeELJGtbiuikSJlSbmBodv8lhH+Iwhn0JGWLYNkQ
         Z8er9G+EufVt9c6qhbRXOEvmUcJcZiqKpZP24uLjj/+OrynNvyhgiTwwxd+yDdB4ogjP
         uQVq9+Dt3TSW545LvmXI+T2/m5jP32fepM1W+JhSaTXVf5HgqeNgruaEIAXX9nxpLWpO
         vNMFAZ3Z7ScXFLne1qSVirQWGPdvly5QttTBVcNaVLZ1AyujPHFQYaGpJrBdYhPessSI
         KJyQ==
X-Gm-Message-State: AOJu0Ywet9bkdUFPdJZE7jcXV45t+ayu30oEwXGaghb1Ap6uTGdkV+xO
	f0zJsesaXcyF2ZqqeoGDenkOCwiTn93r0Tf58dMtKSxTE5+siaZvoT0KNcUJZQ==
X-Gm-Gg: AZuq6aLVR31g/oYDIl1EEUP9dETCyjdpn9wKiwvDM+XZvPeZpwpPmkHiG78ADVvYFfR
	eY5TKGbcC+5Orr8BB7FqkXPKuhmLOYI+t2Xs7wqV8ItuhRYd+pLYzQ2kQcLIHvsdSDIhEwCeiTS
	cT4Mle021ZgKnzgPdHMTZ1Ta8WyXUdm9gsOs6fbUbZBz+LQysZCdAh8L4L5AKyXYSCOG34suiQC
	ad4uWLDbLfjmLFc76Vv4BESqb2ToXL57FnYwcW8f1E14iaini6W4/OFiS7ku2nUF/XUd6jIEjD9
	jTHdDFcy5fhL6hJ62StsbOUbg3x/IQNf1pKevhGWzEGUPMDA8XyaUL+FaKl8BNGPMShA4nSvxbU
	/YJz5YNZpRxKGZHLjfuJlU2A8UP54JXIerknqSsW4UKDqRQgqC8s8KIEyvplFJ0CLQPEpGPbnhY
	FhltQlnP9BBUSVBl6UV5U=
X-Received: by 2002:a05:620a:470a:b0:8ba:2b0e:fa36 with SMTP id af79cd13be357-8c6a68d8ec4mr2573897185a.24.1769097975082;
        Thu, 22 Jan 2026 08:06:15 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a725e897sm1562127385a.38.2026.01.22.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:06:14 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol: Check for an unset sensitivity in module_to_cil
Date: Thu, 22 Jan 2026 11:06:01 -0500
Message-ID: <20260122160602.65567-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122160602.65567-1-jwcart2@gmail.com>
References: <20260122160602.65567-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a base policy to have sensitivities for user
levels and ranges that are not set if the user is used in a require
block.

Check for an unset sensitivity before using it to look up the
name of the sensitivity to prevent a memory access error.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 41c2b051..56ebd9c8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -520,6 +520,9 @@ static int semantic_level_to_cil(struct policydb *pdb, struct mls_semantic_level
 {
 	struct mls_semantic_cat *cat;
 
+	if (level->sens == 0)
+		return -1;
+
 	cil_printf("(%s ", pdb->p_sens_val_to_name[level->sens - 1]);
 
 	if (level->cat != NULL) {
@@ -2499,6 +2502,9 @@ static int level_to_cil(struct policydb *pdb, struct mls_level *level)
 {
 	struct ebitmap *map = &level->cat;
 
+	if (level->sens == 0)
+		return -1;
+
 	cil_printf("(%s", pdb->p_sens_val_to_name[level->sens - 1]);
 
 	if (!ebitmap_is_empty(map)) {
-- 
2.52.0

