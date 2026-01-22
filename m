Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D82376BF7
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107997; cv=none; b=retkbP26kNfMjxuSMJ/4/fZv1vSHSu/Pp37A4T1KIm6vOWFeHODi7nR/hvFF04fuodRIu5U6tJr0/7qHsLoU1l7/2KLVkQyGm9erwVNpBaaBwQRhYX0Ms1bdZM/OuECVmNMBzIICm17YRvrOy8mKSugq4M7ZZ46e/SrJg9xKsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107997; c=relaxed/simple;
	bh=9vB6dnHO1WaPXpzeI1NxW4xRieEHjn6fupV102yX8dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE3iXuvU2OI/VduONTcruQaXA2kjhaxzFK65S49s41+6ShrvAVVcE8m4A5MRuoEJZm4FEDcETL+u5y2xkalTPmS4ZxFLC5XQhrS73mawSwxDXzaFsOQFN9Q3OfLXm4LoxfumUZhZw4GUfUUP1jtkTeOXLjCnqzkUtrAznzOJGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSAbYUht; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSAbYUht"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6af798a83so132989285a.0
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107978; x=1769712778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CLYlblczlFiC+TGOVC9aPfMGtYo+WgOCNHffya0cQI=;
        b=WSAbYUht40hYAHE8hVVI07vV2SpI5DzTc+y7tFQ0lA58CQNyfEnPMVqDc/m7AiWLv8
         vOyphDzxhNbnv2PBoDNzft4n7HHmN2ZTNpM/8zoqwJUUNY/gYCkZvlcSdTJom2EIv468
         RMa7o5D8w1FBIIqwFrHnz4gGyIOoBP422Jw9gs081uPHYzO00Re/1IP390LALvpf0Ja5
         QMDZL8Q3hKZ5elLcIrWbp5IJKZ+IZT8JiLIBYiVqq7EbTh4bT+ynuIwheVaiz7m2vLx0
         PWDLXrfUEPRoMzssFzaS5Lgc5iYTkv1sFy1WbyNqInn051bhgiQ4NsHfpqQmIJ9Mg593
         8Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107978; x=1769712778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CLYlblczlFiC+TGOVC9aPfMGtYo+WgOCNHffya0cQI=;
        b=mMbAyuVp5WlsJTqCLzuAhB2y3j5t/mutdVM7mLgdMtwRywP6sKfrzTzN2OrAa9E6+6
         617cS/ed7Aon1eDMjLl4BI4qhUHpbms4wxqGJzSWt/eRSBwhbX2Vca6iMjJlbh1rmVsc
         +dsUme/glcbLYPr8CB1siZ0UXcGmToPJorVoKQMEXtOfbPWa3DEp4jsSv1kwThVAsaeE
         TGAtkOzv+R7WS0nRZtwQv3qElhnlULXxgNaubVG/b1qrntW24MKzVcu9HebspZyRml1b
         pezLaZwymIt4rYp+gbGpfO75VxZ/EZRr+N6/gfW61vPUrcM+20Iym3T2TTtDf5Abdikg
         UTdA==
X-Gm-Message-State: AOJu0YwhecWVTVfUFaboN95LP9mz3c2HFt05oaP7c/NaKjrdinskRY2m
	bHmapaVbTf7jgxBomCfS0R78B25Ez7lRkt7Dak3BkNovaNp1zO1jp7/3lMhePg==
X-Gm-Gg: AZuq6aJH6xOr9maNTAfcdftH0RHhxy6HBj+OT/FAOEJ6e598XOTcUHnPXVyZq24LO74
	9cG+e/jDEZJxtVaX/9EK5HyebPI7HjA3/UV/rFWgaV+0upBqsyNr5ItXr2itHj2aDhRdpioIDkx
	UFWOgKeKMxdWDkGc7bNOZbWqU8OwRhj0BfgQoqrwW1aLAc3cJ07V72VJPGBpDxGW7m7T6kwz7Ib
	Wr9M0bHj+aNGp6DWAqFkqB69E/HBkeGLxoSZ6CD9drLy9MGX4+CsfxEMtSXRX8nrsC02W3lND+L
	37CztsapGo54RtSx4xwQC+8rkSG+hzIu5phoTmV5YLY+XOs0tC/JBH60ij2dd0osGn+nO1ZWi8/
	ifJjZ8Xa+/dyPb9mFKUZ+TMy7SRLEVRAWXRvqOchGzTV6O6XqPPhuESWAqc0jJLlqtfYcOI/ojI
	vtChr6P4SDjCn9Rp2+yCA=
X-Received: by 2002:a05:620a:2808:b0:8c5:3321:91e6 with SMTP id af79cd13be357-8c6e2e4b86bmr58108585a.79.1769107978410;
        Thu, 22 Jan 2026 10:52:58 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918243fdsm714446d6.5.2026.01.22.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:52:57 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix potential use of an uninitialized value in link.c
Date: Thu, 22 Jan 2026 13:52:43 -0500
Message-ID: <20260122185243.86209-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fields in struct missing_requirement are not assigned a value
in the case where a class is required but not in scope for an
optional block. This results in the use of an uninitialized value
in  print_missing_requirements(). The fields of the struct are
assigned correctly when the permission of a class is not in scope.

Assign values to the fields of the struct missing_requirement when
exiting early because the class is not in scope. Use 0 for the
permission index and only print the class name in
print_missing_requirements() if the permission index is 0.

Reported-by: oss-fuzz (issue 472084713)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/link.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index da65257a..188b4020 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1987,6 +1987,9 @@ static int is_decl_requires_met(link_state_t * state,
 
 
 		if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
+			req->symbol_type = SYM_CLASSES;
+			req->symbol_value = i + 1;
+			req->perm_value = 0;
 			return 0;
 		}
 
@@ -2109,20 +2112,22 @@ static void print_missing_requirements(link_state_t * state,
 	    cur->branch_list->module_name : "BASE";
 
 	if (req->symbol_type == SYM_CLASSES) {
-
 		struct find_perm_arg fparg;
+		class_datum_t *cladatum = p->class_val_to_struct[req->symbol_value - 1];
 
-		class_datum_t *cladatum;
-		cladatum = p->class_val_to_struct[req->symbol_value - 1];
-
-		fparg.valuep = req->perm_value;
-		fparg.key = NULL;
-		(void)hashtab_map(cladatum->permissions.table, find_perm, &fparg);
+		if (req->perm_value == 0) {
+			ERR(state->handle, "%s's global requirements were not met: class %s",
+				mod_name, p->p_class_val_to_name[req->symbol_value - 1]);
+		} else {
+			fparg.valuep = req->perm_value;
+			fparg.key = NULL;
+			(void)hashtab_map(cladatum->permissions.table, find_perm, &fparg);
 
-		ERR(state->handle,
-		    "%s's global requirements were not met: class %s, permission %s",
-		    mod_name,
-		    p->p_class_val_to_name[req->symbol_value - 1], fparg.key);
+			ERR(state->handle,
+				"%s's global requirements were not met: class %s, permission %s",
+				mod_name,
+				p->p_class_val_to_name[req->symbol_value - 1], fparg.key);
+		}
 	} else {
 		ERR(state->handle,
 		    "%s's global requirements were not met: %s %s",
-- 
2.52.0

