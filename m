Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D736F8E0
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388488; cv=none; b=csN1UfFay7+Bt5DxaKqvm3jb6bFRjkLYDZb13N4v+xOVbd57Hz2hDrvfRdiDcgK7wwRt/5fs0fixoDQQQ5Ptgotx916YYRbV/OR8F3TexF5t8bo9/ikyBzhOLJ8MYJq/F8LG5G88iH3rO7rto1czgyDcrLmBAtzOH/vR2DNxxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388488; c=relaxed/simple;
	bh=DjiwSspVtPxBhLiFH82z2ahMBHG8WbEETvhoCTwFT9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnryR8B43uZGAPj6dqA5r6LixbgCvvOAB9HQMxeDWbhDXAlZAly2Ek/DLIQHwNmazCp6uCbuZrADhw8w040DbFL78885YSHYtsV8aj7bT2CsWkTiQ3x3POcTwTZkpoLzrG8hRrjseBr95uvibr6fvgNrJMfF3p4351k3VFOK+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqf4VbkI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqf4VbkI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e614fdb42so50878201cf.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779388485; x=1779993285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mggl10a85I4p7foLrQZ6lJ4Eg2BtJdDEMhotLlrMiF4=;
        b=Nqf4VbkI0LtNYRcMQFGw0IOP1vcQ+cF5eOuTm+RL+gLNSO5Xi5ORbp3E3NZgeHa5AD
         hq5OP3XSaKnGXYDXKGiwoEKH5cCmyEx46BY9haS8Pp0shd6Cx5Dwq3DNZE+27aXAVnKG
         rpPG1Pmj1PXrdjhoivI7pDC3pQMDxPAxyNtCQVOgqjfGX/y6d1agz1gZqg0rDAP5fuql
         rPv9UQi+e99471W/y1gEWU5fnwz/HGMbenzgjAPbKp9Qxt0glpyWm6FqN+exPH6LePLL
         unbENikLkaVzLO7+QyCgcWBDGLFlrbFextR+55dnSxTfcLvFPlPFLI35Smp0kUTa4pet
         W3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779388485; x=1779993285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mggl10a85I4p7foLrQZ6lJ4Eg2BtJdDEMhotLlrMiF4=;
        b=UgvW4vka+PdSKVMoHHOYc0/NoRIB8fE9c9BCx5j3GVQQ2qHv7OW8hcVZGobFF673x9
         7msmmlTrTfsccRYkVQzQT4LjS95ol3S5DJlsMznisAyyPjFq3z/uqxekM8URdHV8LAy5
         BQmcaDt5ym0Hbsqo26L9XTOqVe/ZMV1kSMX/E49GtlNDS1GVIXU220WJgb9OWR8VSneG
         6hOv/nbM1BG3ygaX8Zsql9Dx6/yNuuPvNtPbBtaW3aO2VxF0sULCBOUeT3Ox2kcwbTeP
         Rm+N4cRbZ/OqzEfp1Xr0WbyWDjjoYmLzgxPtwTrKkzN3yi2d5w6sgNFDy3/HHU59JZ69
         LjWg==
X-Gm-Message-State: AOJu0YyQ5fs4VECPGr3do1z2vD/mnOM6Tq1LZ4m1DeIzRO9EXGScM+Zj
	DfhdfCF6xhEz+9FkqunFZdPqSf/yUICUJlsCAII01N0mxnCORKV0eHETixqi/Q==
X-Gm-Gg: Acq92OEMzfpBqtU1kkfPEM1XvUcrscaA3rwbP+LQqeLyPHP1I1M/CoH/1x4j0hPnZ8h
	hxyFpuZ6RXlOivkWlhDmffL0Iy6WS6NLCnSfp4XwjQ/myIP0+PQHS8nFWv9+IkOAwzucTdnnxOe
	mEOBi963QTIxdXurfwq4PnJIEUY8a9XELZqrDzdhQ8PlEMl9YmGwdvgX1FdXfcguVfvNBmWJxnw
	raEyOe8EowhciH/ACM7mELGhikB5ksIavlHFbdlyUpWOBBV5AcfKM4HkvSMF9yrDmTdK8+JOvPH
	Zs8HMZ1szyIgG4X/dX7/VED6acObXY4f3fuEg9Lh87qxJpKa99W5oqYgyB0ilplWgz1Og7kquZS
	Zr0ygffQKjYlZiZSheHKdwPaRDKFfQ3y4YIDxA9gliXdmLuPCabWLq7jOWAtwzKJ7/yqm1LeUHD
	A2u3tIJhTwFeW4Lv0y8/1anRbZ6A/HKyDxyQ+szr6JZS08cw==
X-Received: by 2002:a05:622a:4a84:b0:50d:9174:cf33 with SMTP id d75a77b69052e-516d4321556mr7399901cf.16.1779388484967;
        Thu, 21 May 2026 11:34:44 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccf32a55sm14536041cf.26.2026.05.21.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:34:44 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix index off-by-one errors for categories
Date: Thu, 21 May 2026 14:34:32 -0400
Message-ID: <20260521183432.22333-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The category bitmap for a MLS level or range start at 0 as does the
p_cat_val_to_name array, so just the bit position should be used
without subtracting one from it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/mls.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index a37405d1..7f53c61a 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -138,14 +138,14 @@ int mls_compute_context_len(const policydb_t * policydb,
 				if (range > 1)
 					len +=
 					    strlen(policydb->
-						   p_cat_val_to_name[i - 1]) +
+						   p_cat_val_to_name[i]) +
 					    1;
 				range = 0;
 			}
 		}
 		/* Handle case where last category is the end of range */
 		if (range > 1)
-			len += strlen(policydb->p_cat_val_to_name[i - 1]) + 1;
+			len += strlen(policydb->p_cat_val_to_name[i]) + 1;
 
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
@@ -216,11 +216,9 @@ void mls_sid_to_context(const policydb_t * policydb,
 						*scontextp++ = ',';
 
 					strcpy(scontextp,
-					       policydb->p_cat_val_to_name[i -
-									   1]);
+					       policydb->p_cat_val_to_name[i]);
 					scontextp +=
-					    strlen(policydb->
-						   p_cat_val_to_name[i - 1]);
+					    strlen(policydb->p_cat_val_to_name[i]);
 				}
 				range = 0;
 			}
@@ -232,8 +230,8 @@ void mls_sid_to_context(const policydb_t * policydb,
 			else
 				*scontextp++ = ',';
 
-			strcpy(scontextp, policydb->p_cat_val_to_name[i - 1]);
-			scontextp += strlen(policydb->p_cat_val_to_name[i - 1]);
+			strcpy(scontextp, policydb->p_cat_val_to_name[i]);
+			scontextp += strlen(policydb->p_cat_val_to_name[i]);
 		}
 
 		if (l == 0) {
-- 
2.54.0

