Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865183ACA49
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132188; cv=none; b=UCT9M34LEl0psX1Gjh9/V3kEYIw7bmN3e+/0ZoTsPURg5DF5qe3dgdVlMUz+HKOTD6esVRA3+gWV7FrJlVoeowHF5Wgg42Yxqjtpq5T7qsIZGD9mwyM0zwquWbInOtIcjBf2o4yJHzGNHkyzh0VEKUewBLvlVJ+lQ0z9FZhyjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132188; c=relaxed/simple;
	bh=knus8yLzuC4rvDPBQ/q9ZkSHLLimEQLQOYdmpCTgWaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aekw5YoJPFP56YZnJ+6Vhz0w9uiPBN1mKXxxhZJwNtqqZK1Ki3DlkzcWU7LZa4PybwCYRcGuHP8Le0h/rVK4pfQz6R1Ianp0o6O57/4j6y4lRVovhCZV/O+TPxqIGvr7+mz+ddHD/pmOQhQazMF7ncSxl4igzBRNgjbby5ZFygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXz3NHAs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXz3NHAs"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-519ff1c8b8bso25502951cf.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132186; x=1782736986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdwjP0r8Q2tFqFXe+cdnzMsLGDHLDP9zuLFPqNvu9lI=;
        b=TXz3NHAs9Bpzm0+QOQuVZPyVPfruYwxc+18/JuGZ9AKsSF3DGP3T8K21cg8hdI1CbX
         z384NfczkSkClsk/C8yNxJTQi6be0iLN6hyqFpSn/UKEapkmZeOEl2VnaH9F/9kTPIfj
         Hv2NVbkOo0BNbpim9h3SQK1DPOGSIBD6fev/rj+CLVordGViDMVO9cG6+TRNdLFlf/AK
         kNYyUEChANJvpituInfSj74iFSUDC6OkVz9px6mOOzlgsSUNRClYm7eiLSNHWBjx8gNV
         nWn+qEw+BMvWbdFy9EIaFXq4WoweuLl7sLx8wIg6aaBhGV77Pe9wUUYp2Wp1fYOZdr97
         KiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132186; x=1782736986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdwjP0r8Q2tFqFXe+cdnzMsLGDHLDP9zuLFPqNvu9lI=;
        b=e2mkxnaoowmH+mYg1tinTyhGKJ3IVT5nrzmP2mzXhuM26z99QSGV78c0Kks0u8MHOU
         Un9Lp02ocWiYPWcK0e0vwZEfY9CZ+scC0uk0XmgbN7M8+40Yl6NsWx/KRYzbbuwnunJj
         uI47Wgfput2kmpNWc+fx2o/Qqi3Xd3AZCzHQffwvelyka36yrGPK98dNxUH4CrXUAqHb
         O/kAuieAlzor47m1Wy9eE4g2NFXF73m0XxxddEPgYQDL5VueeRgcK5iAEkFHLvIxq05W
         NZja24PLCZ5jRuyYvfmN3m79R1DR08iHnBSfJmfquSSZszwmecM0tbg1hogkaQXsGcUG
         KOTQ==
X-Gm-Message-State: AOJu0YxJ2PyMAYC1Lkw21j46fERj6IZaygnqSuqCvbhnKCBHPOGU/KVz
	jsIP07zchp+v6v5k2yoUcILb3wuRavp+pgvIvyaWfVybhe1y6uyHrPTOPdRlVw==
X-Gm-Gg: AfdE7cm0KPGfEWPMOSSiMPb1+xTZy7bsvoUOgnkIb/2GGTMN3FUimDYAJvPUc5UBvFw
	gDHaq3pQFWPJ1qcJGG3Eb4fPa9wZ8Q8McbhIXOuBqLGBiBqqV+jvIJZ7qFDcJoyYDMBJo+LI3eF
	vW76qoO23+rI0hO8ZvJNASy9Td+dTkJIsRPpcIvz+4eVC/FeI2fQGha9tZ/jAEsrQgv00ygNvvU
	I4a95REv5XICKNkaAcqCalOOkPgdthvMYtDqSVTMdTNlVb+wlet+FZXJ5yN9cOI1xBgrRmy+tM7
	srqLQSyNY9AIwOPkjdf6hfwxcCOh7ZXFIvrpLSPbTe9uLtN/HU4s7ZAWHUhDAdygmiz731ffAbC
	81c0ZYYMx/1bDU2wMVlW4ZLIezVxE1ltjTXYpGNC9X7+5Sp0A3/Sbzp3N9dCqgw7U+qieoXU+bA
	5s+ZUwArUS9d9RaHpLZ+Ho8Bw2gMUQi6qDp7/zbKyNRowTAln3MoN8/quS/70Jh0OSOwjjbCKbs
	btIxRcWG8teWuCr
X-Received: by 2002:a05:622a:258e:b0:519:5836:2f07 with SMTP id d75a77b69052e-519e4dfccc1mr95334741cf.55.1782132186307;
        Mon, 22 Jun 2026 05:43:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0984da98sm66632621cf.15.2026.06.22.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:43:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol/cil: fix double free of borrowed type datum on error path
Date: Mon, 22 Jun 2026 08:42:51 -0400
Message-ID: <20260622124251.31555-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

cil_typepermissive_to_policydb() and cil_typeneveraudit_to_policydb()
get sepol_type from __cil_get_sepol_type_datum(), a borrowed
hashtab_search() result owned by pdb->p_types. Their error path ran
type_datum_destroy() and free() on that borrowed pointer, so
type_destroy() freed the same type again when the policydb was
destroyed.

Drop the destroy and free of the borrowed datum from both error paths,
matching the sibling alias converters that only release their own
allocation. With nothing left under the exit label, the gotos are
replaced with direct returns and the now-empty label removed.

Fixes: https://github.com/SELinuxProject/selinux/pull/534
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index db3eb0be..caf2d987 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -611,18 +611,13 @@ int cil_typepermissive_to_policydb(policydb_t *pdb,
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type),
 					&sepol_type);
 	if (rc != SEPOL_OK)
-		goto exit;
+		return rc;
 
 	if (ebitmap_set_bit(&pdb->permissive_map, sepol_type->s.value, 1)) {
-		goto exit;
+		return rc;
 	}
 
 	return SEPOL_OK;
-
-exit:
-	type_datum_destroy(sepol_type);
-	free(sepol_type);
-	return rc;
 }
 
 int cil_typeneveraudit_to_policydb(policydb_t *pdb,
@@ -634,18 +629,13 @@ int cil_typeneveraudit_to_policydb(policydb_t *pdb,
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type),
 					&sepol_type);
 	if (rc != SEPOL_OK)
-		goto exit;
+		return rc;
 
 	if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, 1)) {
-		goto exit;
+		return rc;
 	}
 
 	return SEPOL_OK;
-
-exit:
-	type_datum_destroy(sepol_type);
-	free(sepol_type);
-	return rc;
 }
 
 int cil_typeattribute_to_policydb(policydb_t *pdb,
-- 
2.54.0

