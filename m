Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9245518D
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339815; cv=none; b=ibzauPRknZmOE8IDt26OnIBtlNKpPvCrF6QjX6tRTdIlPL/3Y5rhHd7BdGKU16H7nAxoBYkLRKkRZDLCczECgB1iu/7DRBz++0uWGXkqw07NpqMQuzh1G1vWFHnknvbZriorUUXbu7FnynnG0saIZ4vdo/PFQ1bjmx5tsnZRkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339815; c=relaxed/simple;
	bh=7vOKVq9ZLbQhHiSaM+GU9SLwhkqPmJ/aKq8Blpd4XwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uC87FjhnPjQUqvQ4Uyn/5rM/AzYpdiC3cRWnS08ttj2Y2cd+ie05WhaIP+OwFDLzvgkk2G1qk4F3JCkcpy9R0iJ2VQiGg/tj1y3cjDi8NmOdOpB8fFzoqB0siG/Snvk/SzX7awiUzhLrYdCRzYcUeEoyfsPIcqEBgQkSkx+0I0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVlygslV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVlygslV"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c68aa31so7625461cf.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339813; x=1785944613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iu0CvhE9hdVAoWr2C6Z15cRMaccAu3ksqF4qGYT93AA=;
        b=hVlygslVKrFX3ZhyTfKVbSGkBeMxAUBu/puf30c76NcbJ7GLpM9pu3qzC4tPHw2t7o
         oxMJ1W5oht4sCjtMMmdfZP7Tfv8dJO//cRMfflFMRe3i3nB/e0qFfmdBvHNnm+gkcbI/
         xt6gZU4y/3WIkASP6ZItk8R3zJY/uMc2fDPxAeAQLII/7t/NFH0kyOmcjS08Rn504tLS
         SryMtUCRmzdCc4LrNKm7Ca35yl6w3zcMNWGnInmjtlHJp08v0NW5p1zS29z+cZbssb/T
         +zJ/HyARIjqblqVDNkbz/6SrZGgmfQFQB+MP2T+8uc0gJNo7qdKs3vfhirw3lXUBv2za
         m0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339813; x=1785944613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iu0CvhE9hdVAoWr2C6Z15cRMaccAu3ksqF4qGYT93AA=;
        b=M/pix/o9DtwalJ3mrro7+ITav09eOofRdvij+5xFgNMkw02hc3Cj5c8/frgPYgDupp
         uwC0uB1q9Bovu7/js1UMNj6MWqsdUX8pST/CrmV8hpDCIwlUNDhqv5EbUurG8qpzwEhp
         kmjEp4hO/2L80ZfBFtfSu7K+qRUbQX5rPbuxJ0noWtMfATcTr2TTMa+eneNYhbJwx3ck
         hhBEqhsvq1zLHx5ckEPzYdwoOO+KxY6NA5Yhrs0HEdYxzA4edrC8EGG+oiReSInjsAq4
         PaUsAlayUPW5x9c3s5v1fupvRBoIw3ql1y1bxTtGpalRXwncpj6WjekoVoTSIYk4k0z0
         G42Q==
X-Gm-Message-State: AOJu0YxkMo/AFTLF5DzFo80pt4X1W/82v300P9Qb4kBaRZjkqhjtACO0
	7IXi4fKvOKc53FCXQCdbxH+4KHTlWU8bWKhOXkhQyZ+ziqfSCUDJL1vRXcNM3w==
X-Gm-Gg: AR+sD10fh1MntKWzYYjbkQgZbMIikciqtwa8i1cEw9tvJ/MmiVinf25SuiSxswyGeJE
	/4RPotuP1/pNcBJKdmLSLcLHwqqhvqvonF51xtQuAgP5CXY4v0PVSjuCAIGOF7JJ9aMiA4kxY24
	iP8VsIE+SbOef2Ddf1uzHlJfB8i5kAuX3pqJLU3QmT1v6Eisc13jlhunusScJFJFOyBjnILYaBs
	1AilvcjScB9JFQ33SXMa8MqUB2djbOXFsLXTGCH1zAiOn1SvqrQzhWkhl6NfwdDFNFBcqInUFGU
	aO41tmZ7hfAV/yKn3Ef2g3A5JSfD9b6v0ZxlcdeRtdOYs6R917cWITk1fyDyWELsP+Qcf02RoRR
	Pmkn2lor1CYOCtAn9ijAfNP1kw3/ZuYyoizigvPU9PGUz/zZQJaGVp0wfQGE2E7OY7TI3huGVCV
	CxeMtZK+xnrFFHvQWNjqKV44UpXSguTseyYnbY3pU4KvHRHW97wP1U/ZLlrAjqdCrtqqXsfjJMf
	XIsKYGxeuI=
X-Received: by 2002:a05:622a:15ce:b0:51c:1132:c80d with SMTP id d75a77b69052e-529d6ff38edmr63309531cf.28.1785339813137;
        Wed, 29 Jul 2026 08:43:33 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2ff6f31sm21017781cf.27.2026.07.29.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:43:32 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check for invalid categories when expanding semantic levels
Date: Wed, 29 Jul 2026 11:43:23 -0400
Message-ID: <20260729154323.14694-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mls_semantic_level_expand() is used before the policy
has been validated. A maliciously crafted policy might have gaps in
the categories, so a check must be done to verify that the categories
referred to actually exist.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d7fe519..35f26c23 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1128,18 +1128,27 @@ int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
 		return -1;
 	}
 	for (cat = sl->cat; cat; cat = cat->next) {
-		if (!cat->low || cat->low > cat->high ||
-		    cat->high > p->p_cats.nprim) {
-			ERR(h, "Category range is not valid %s.%s",
-			    (cat->low && cat->low <= p->p_cats.nprim) ?
-				    p->p_cat_val_to_name[cat->low - 1] :
-				    "Invalid",
-			    (cat->high && cat->high <= p->p_cats.nprim) ?
-				    p->p_cat_val_to_name[cat->high - 1] :
-				    "Invalid");
+		if (!cat->low || cat->low > p->p_cats.nprim ||
+		    !p->p_cat_val_to_name[cat->low - 1]) {
+			ERR(h, "Low category is invalid");
+			return -1;
+		}
+		if (!cat->high || cat->high > p->p_cats.nprim ||
+		    !p->p_cat_val_to_name[cat->high - 1]) {
+			ERR(h, "High category is invalid");
+			return -1;
+		}
+		if (cat->low > cat->high) {
+			ERR(h, "Category range \"%s.%s\" is not valid",
+			    p->p_cat_val_to_name[cat->low - 1],
+			    p->p_cat_val_to_name[cat->high - 1]);
 			return -1;
 		}
 		for (i = cat->low - 1; i < cat->high; i++) {
+			if (!p->p_cat_val_to_name[i]) {
+				ERR(h, "Invalid category in range");
+				return -1;
+			}
 			if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
 				ERR(h,
 				    "Category %s can not be associated with "
-- 
2.55.0

