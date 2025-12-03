Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C23A1CEF
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779554; cv=none; b=CLTeRghx8H9gtmBVBvw9X7IdgrJNZ8SThtuLxf4TskLvqJt6wkI+1Xu4udAY3YvxN1ax7ojEzWqNpUm374e+ENfhVepouUt5YaKstwnJRrMa+hHSzFCKy8Z406OXdv1odUZq/jDJiRboEUqt6xaERsXCIYD9xYSkEttayVXV9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779554; c=relaxed/simple;
	bh=YMEiYhCjNzBqNaY/banzdZa0AOu0zf9bxkC3vUC5Uis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdTBOFEG/GW/Yzlc1o7ZIbJEsX7PWgTCmxJ18vX7NueJ1BCrd2uzCknObsJPgh1RppdMYsDy6ZxKesEdvrCNmnRcVCSnCLgDBOOIGsI6gOLDvYslmubWcFZ5DLWAL91fe+V1vb5d3RdIZlEC/m2PVDbrh/XwOWwQo8x+LxAz72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsesCt6V; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsesCt6V"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b21fc25ae1so658601785a.1
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779551; x=1765384351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amQAODbbqlbUJt3HX5X1LyF+s3TCIELjpcRP5NTe0rU=;
        b=XsesCt6VmrCMFCPhCXa5aOH6Jug92RqS/4Mpzr+nDtyo/v0f/Z1ifIvFBXFKZDOxPd
         LkAQ7OthtmfAtSlCIhZ+1JO3dzuzB4dUU3c7ij5ceIwZX4LIDxZk/zN36yLTn4/ZEnRu
         upWHpwbhXJN1EGJ991ZH4aR38z3m9NTgg2w02ZUDMfmYidK0E2LT4E07qW+CQ0+Fw5Cw
         6P6t9LVNWnNqRT1vG40uXaW2Ro4tUQ6G4a153gQrhzQfl26WVg5+cghdfbdlSstnKlRK
         58eB6fhr3wdD29HxFqARqIzlbn09aY2Q2UHun89kUTIuadqTOtfI0ov9U3RGP9+flcPr
         q7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779551; x=1765384351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amQAODbbqlbUJt3HX5X1LyF+s3TCIELjpcRP5NTe0rU=;
        b=kKS4AAb6o2u/GLftmFxh0hlisNLMna5mGm8l2UzVRlxHCSF+cAzG+n0j08madKyJJF
         SxsXiag6v/gXh9w79OOklI0/zmESuNft2oZzOZICW9GH61Ers61FSVIYYhZryI1TndWK
         iXzf/9rHQObHNhj7/8YA3PD0/ax2LKFMdAAswax9NpSbT5Q3XNCBZ3TDHVY8zWD/qOo9
         71csQrVbOYFmkIPWjf4NBvJvOBYI02aXxBzTAPYdNTYU5uOuYs9asV0MqOkIJMCOGnGQ
         dycni8U4q34wnFbLu2REIX+4HNoikGYXvCWcR8Vxs7b3PFc0jF48Ums5EB/AjPhCnbji
         RXDg==
X-Gm-Message-State: AOJu0YyFgcmE5N91neQkJQVC2T4KqJDC+5K0hPw0xRzUqdG1FBxIBvx4
	xAlINR21OCE+lprgyKVp5P/5F8mabwraWxIVLL4pz744IUG7vDD42+LiVZwbwQ==
X-Gm-Gg: ASbGncvQ2KrFQDVj8WY+w4KkYKWmpbcejg9trnUYb4bUhAruf6fH2u3MOEuq/ZgZ0WH
	IUGRDEOn6FOFtGZOB/t8uu4N2n0gyD6H8rbSmORq7gCPW3BgZymcpllrYLFPTTAfewsgRybw4hl
	VJsF+4ueOdhbT3d8FUNbUm/g/8nPI7TaH4di6+VXU5WKngqI0e3OxmQtV2CCaz77hW1p2zXg7mM
	KFaaEf1YvZew6385rO+J7aP5/OC/3nVqKfZjXgfC+Cbs1mvXnGWg/pVmwK8Z7Dnp0ARNifOSBHT
	h1OWOC/W1/U0O+SIbycpLsud+D5muD0DmeIAfnNWyhOGa6qJpMAsv+W7zVGS6pRDuIaIQS/VXqm
	yQcI8O0NXuC8iYW87FoIDE3F8qMDAZ8A9tIZCcE5ZvLrE1LrY4GaeRUadBWcMYpcHPpMrB+Ozja
	4J4QhQ4z23JDrWh6Dx6g0=
X-Google-Smtp-Source: AGHT+IHMx03+xNK2U2wn7ldOuummO8quMVmGEExJ8JTE8rOSjE9nzb9l/GhUa0c1k1c8ZX7g0/yHGQ==
X-Received: by 2002:a05:620a:4506:b0:8b5:dbd9:2114 with SMTP id af79cd13be357-8b5e2496a61mr401534085a.0.1764779551351;
        Wed, 03 Dec 2025 08:32:31 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:30 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6] Fix an error in the policyd validation of user datums
Date: Wed,  3 Dec 2025 11:32:15 -0500
Message-ID: <20251203163218.54939-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251203163218.54939-1-jwcart2@gmail.com>
References: <20251203163218.54939-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a user is in a require block in a base module, then a user datum
will be created for the user. This will cause the policydb to fail
validation when the base module is loaded if the required user is
not in the base module because the MLS level and range will be
empty.

Make sure that a level datum has a sensitivity and fail validation
if it does not, but allow levels and ranges in the user datum to
have no MLS information.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d441526e..fb79c8d9 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -665,6 +665,8 @@ bad:
 
 static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats)
 {
+	if (level->sens == 0)
+		return 0;
 	if (validate_value(level->sens, sens))
 		goto bad;
 	if (validate_ebitmap(&level->cat, cats))
@@ -681,6 +683,9 @@ static int validate_level_datum(sepol_handle_t *handle, const level_datum_t *lev
 	if (level->notdefined != 0)
 		goto bad;
 
+	if (level->level->sens == 0)
+		goto bad;
+
 	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
 
-- 
2.50.0

