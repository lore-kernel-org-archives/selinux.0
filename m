Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFED41C313
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319762; cv=none; b=OnfeiAPH4jdBEtqSU/xjbZtm7WP4O/BbgMh/SGXeMk73li5H3s+kFLpX0GfQqJ4pOCzHAn0r/de/iM5o6GMcG3R0CyVg1IZ5YMsP1/iy/Zh7Rge+wKY5RQhrUk4TkcB4HmC/E11y5ijCM5rgXQ3ToiCSIQvD9j18U1VOt3Z0OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319762; c=relaxed/simple;
	bh=gmLiOmW1+SELy3PQGVgSOUc8/ZPs/mvR3/03G4PKWVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt2fX/gR0q8HJhHpPd4zBLo8tMT2Bqw24Tdn/DNdOeyVjtXEmQpFxcH/sPIDykuiNRWjLuInXFWqZjD/m4m5YElkDzm8ZiniH0/S72a1ReQSDPCynpuRrB4XyXeiXycd1H95l1MX6Jsn6OMVGfDkLlXULIbYiuu46g8ZaJSWdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mClVgAis; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mClVgAis"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e63771d91so94018101cf.0
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777319760; x=1777924560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX1696mu3tGIhFLA1ktzQP+Mq668Sv134Y9/mYhcA4I=;
        b=mClVgAisRhWWx7qaqkJfNdf9tTe6NHJwWMlki6vprEb7HDfP0hEgZ4H2YcF1AttNrN
         c7xBAvzRMYuqy65oOIctOczvkyqiubTGqbK4Wp3mpMJWKOi4bUbZicgDJJR0BlkV5VZo
         iJ1w9UUPPWwL/PTYemdXgY+WTkMzkt/PR4uXV4l29QZps5qN/rLbUndrt4RudxNMIO3f
         Jg/8GJm7OLBw/0RNlP/dEc8aAVS4u8koFQPtjNwvcJOM5k3ej7ky5XuQcW1jCRfds3l9
         3mlxpZMzPeDIPd6jexEkvQwL0oAnJbW2Kb+ts2P+9C48IfoqF9BtOwTN6OZkqZg4yQDe
         cMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319760; x=1777924560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TX1696mu3tGIhFLA1ktzQP+Mq668Sv134Y9/mYhcA4I=;
        b=UYfc4ImqQPEQh9gCQZ8wiYUoocpB77xOn307cwgO9x8142vswASNSpk4SenxQiEGo9
         D3CyTxjahhFk7ctMVEPtFUrLm76BuUDe+8FVhg8AUcF9rLgxotZlLp2nv1km1XXN0V4F
         ptk2oEJNXMz2iGsmnE42eGi7ufqUYfpjS62ODoDcEM2psTIjjmWBJMmjUzrSHX3L59Hh
         aXm63EHKweu5uy0disFymi+QrP3p+ijH1PsATAqikHsweTV4+OVyZBzWp6P2Z4tjOX8Z
         ZIHqxT3U64OzwfIQMak0HvhL5Ox+e3vfTsv+xL76T4UkREd0/mVRfWqUJgwBAOBE+zbV
         R9cw==
X-Gm-Message-State: AOJu0Ywsa9TPviaUad733REJ9gZDN4xE4s2+d1ILnUYEGp2Dw65khCR8
	/uFw9hr74LdF0soyR4dxXqPD4pWW4TrzK7p1BYsUYWcneVAuYpLS8EhPzkKJYw==
X-Gm-Gg: AeBDietGMPytHx4AukgGptpJC98UsSgk74ebY0vIdIYaSjQZVujtHp9tcMI67bj+ufZ
	UVAOZMzNounAJLoInjz1+9oNKCC08mVrqrS7VRnqX2C8IXAp9lsUZoIHupwMCEb2Zrq76w42Xe1
	SC9wYmPtvgdsLPGzQ3KRde4wUfhGwqiZkRh9lEpWahKuEwXq/nNJw5w9hdzFh+dWVNrcofp8rJj
	u4orck73/912bPESSVvV8TK8OXxFE25AIKmgMXbuUda5BKMPWJPmSBvPAXI4D+OOkudayccBqHH
	wdwxS9K10LufbzPQSJ+wTp9UWCM6w5RMRVz/8500vMcO4+zT1aBXXMbyzr47+v80wRsni8ee8oC
	T98F3hLQDyMTQWfvni6Dhg/F2DmXcqdLQJrHSxY2LPS85pEm+QmygvuW0+DyL0TsJ5NrKE+uUxO
	FTJfPw/IMjbKRaZTWW1aNUIUllwGdUNCD9OjMU0vTrGnD/Koz0KpCNebGC
X-Received: by 2002:a05:622a:1651:b0:50e:5eba:caec with SMTP id d75a77b69052e-5100c9fe778mr11294451cf.54.1777319759786;
        Mon, 27 Apr 2026 12:55:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100db1ffd1sm1047601cf.14.2026.04.27.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:55:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 2/3] libsepol: Add a function to output CIL declarations from a binary policy
Date: Mon, 27 Apr 2026 15:55:45 -0400
Message-ID: <20260427195546.91395-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427195546.91395-1-jwcart2@gmail.com>
References: <20260427195546.91395-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function sepol_kernel_policydb_decls_to_cil() that takes a
binary policy as input and outputs the declarations in CIL format.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/kernel_to_cil.h |  3 +-
 libsepol/src/kernel_to_cil.c           | 92 ++++++++++++++++++++++++++
 libsepol/src/libsepol.map.in           |  1 +
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/libsepol/include/sepol/kernel_to_cil.h b/libsepol/include/sepol/kernel_to_cil.h
index 60346ad1..1db0383a 100644
--- a/libsepol/include/sepol/kernel_to_cil.h
+++ b/libsepol/include/sepol/kernel_to_cil.h
@@ -2,4 +2,5 @@
 
 #include <sepol/policydb/policydb.h>
 
-int sepol_kernel_policydb_to_cil(FILE *fp, struct policydb *pdb);
+int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
+int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb);
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 06cf4498..9ad7d443 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -3533,3 +3533,95 @@ exit:
 
 	return rc;
 }
+
+int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)
+{
+	int rc = 0;
+
+	if (pdb == NULL) {
+		ERR(NULL, "No policy");
+		rc = -1;
+		goto exit;
+	}
+
+	if (pdb->policy_type != SEPOL_POLICY_KERN) {
+		ERR(NULL, "Policy is not a kernel policy");
+		rc = -1;
+		goto exit;
+	}
+
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		ERR(NULL, "Writing policy versions between 20 and 23 as CIL is not supported");
+		rc = -1;
+		goto exit;
+	}
+
+	rc = write_class_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_sid_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_mls_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_attributes_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_role_attributes_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_boolean_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_alias_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_bounds_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_attribute_sets_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_role_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_user_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 2b103993..8785cff1 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -297,5 +297,6 @@ LIBSEPOL_3.6 {
 
 LIBSEPOL_3.11 {
   global:
+	sepol_kernel_policydb_decls_to_cil;
 	cil_check_neverallows_against_pdb;
 } LIBSEPOL_3.6;
-- 
2.53.0

