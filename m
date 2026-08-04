Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436E385D74
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869322; cv=none; b=ZecMAQHa654QFIOrzwXP2sLVGsMvzaItk2XpPaKJUcAMyz9Or1VgHhHq1mQ+0IPm5ic301wsUmx8+KHgYlDMFhYVCB8yJphGdp98EiElX0gGf5KhtoNgbfUK85Y2zanH+OSWTVfhbdFEbfc+d+DIjb3S6caeWjkVKpYit+i+80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869322; c=relaxed/simple;
	bh=FTmVdOtGxUJTbxkJSh82c08FklseM+ChH6hXJ9l8QDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agLImG5YKxzenHsyLIUnb9C1cYnMjvS6awIrukhrSdCU0ZmoRYOQFqJTiE7ogyqP4vD1Ax5pJzxEfd2qkMdI33xAJTl5x21s1b3Go9b6sus9QTfsbTE8FPcQftN190jh3IbKcck7FFEjn8k67htoC17G4RJwLqlEyI7pUGWsF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inj0XMM1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inj0XMM1"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92f0b5ed131so16600785a.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785869320; x=1786474120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1I9iy/3TI7H5A2fB2j2yHrgotTlKQHF8vg3rOzGDyWw=;
        b=Inj0XMM1jikY1EeWvPqHauQH5q7TokQHLdZ5aT6HYDdc1PqTFat6jkUbTKhR3Yb3zy
         Hm80YyXXTY4qUrdWVk4PsnI5pwaOt9JxpP0Bsfolx/8A+W77gzTbkaR1/U5U5eLjQS+p
         NrKpsczFFgxXpSHLF77AYiicfV4bgy7ADEEh7zur4lPR1OPshhQ3t1rwwcydWzw3KYYq
         bB9BAfWEfkp42es6vIvNjhaPZJuG9zHqh7CTS93ek240F3zWzqfgxUjKx63ZfE5seM+P
         MH87A9Qj8E3OOCAGDhoSVJAouHQ3JGxd10hEVgv2siA1YwqLVgFzBp5iz/w1YK3tNfi6
         OPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869320; x=1786474120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1I9iy/3TI7H5A2fB2j2yHrgotTlKQHF8vg3rOzGDyWw=;
        b=E2A/NxnXzY5bJz3TFmU/3i2lKB4ZzDF5trmiVtGKJ+Nrk86A2mBhpBWTIkbNNfiQDD
         EzppP+q5sMQizcLbqtCShEt1A2WdmO5mwbvM4Lp6alMvgL3zE2wapOeAItl3v2iA++ZT
         1pVosaw5RyCdt1mQC4T4I5ojxXxE6QYYmpeFV4BO1zcn+0NhWqyuo70ZyMlITNRKHfyw
         aa2F6yM8C3qKmFOOyhumSLbe0qxSLEgCIcAIm5fNFtA4zJZPAPS0jNhYyH9sTLvt1CoK
         nTf3CokeH2mAFm6EUjidTW72jllkIcedhr+3w8f0NWYOLqCFs6YH9Rrolo6Ke08kb3NG
         +TKQ==
X-Gm-Message-State: AOJu0Yx0yFEn3/iQKxUclwYI6jWkJqLn9o3d6Wh4/n5+ixU1tiq1aUL8
	LNwbat+FGptN28WFP5MctM7/RkOU3yziFnTodaay/kX3slrozzxigbMfbvxCsA==
X-Gm-Gg: AR+sD10rb9Y/Q3psk/ayRoVUNfHI5HXSqyd1fByD5PgpNOe/67+yacqvrBgTq7EogCi
	RX2hrP4wVHg3r94ULqPAV7ejO6CR1jlxVJU/GiggAZDYvbLOitI4gCSGTlaItJo68mIaYktgaPx
	VZzYtnaJQrjKT2o/YadNryKk/rsczHiKgeQdd89xyfHirCGRNTw2zwoq3/4IE+ZoqPlmvRG9fk5
	7nOnCYj9469GNnn7jCjmJ7UsVAFIXt0Vf4YqYKsEaQ80iPHcpz5gq1TOEKdJR3EnBm65d8eKmhZ
	RK/Mz00a3Cj9m1JycpBWwBJBLazeMpK00SRi6kwKfO1qdPIL9TqVnJ6Z3nHDaxz0XfXA/wdPQej
	dKEPupTYbH906w71F36DUboQhdM2Bpnmu0yZgu/1tca0dQlNfsbowtjBQ7hmRqA0KuFpOqgItnW
	X3fnsMA5yiwRG3qWqlgWJrCKpHMezsMF0IF8GemQJdyA5myXZdAb2aGZloU1eCBHriIt8Gk5Yp7
	hPepBEoNKg=
X-Received: by 2002:a05:620a:aa04:b0:931:369:ff0a with SMTP id af79cd13be357-936491ab26amr53237685a.35.1785869319654;
        Tue, 04 Aug 2026 11:48:39 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641732353sm155057285a.12.2026.08.04.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:48:39 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Do not convert mls rules to CIL for a non-mls policy
Date: Tue,  4 Aug 2026 14:48:26 -0400
Message-ID: <20260804184826.36330-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When converting a module policydb to CIL mls rules for sensitivies
and categories are processed if they exist even for a non-mls
policy. This allows for a maliciously crafted policy to cause an
OOB access.

If the policy is not an mls policy, then skip sensitivity,
category, and the ordering rules for sensitivies and categories.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 06fbdc30..6876bd76 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2711,6 +2711,9 @@ static int sens_to_cil(int indent, struct policydb *pdb,
 {
 	level_datum_t *level = datum;
 
+	if (!pdb->mls)
+		return 0;
+
 	if (scope == SCOPE_DECL) {
 		if (!level->isalias) {
 			cil_println(indent, "(sensitivity %s)", key);
@@ -2738,6 +2741,9 @@ static int sens_order_to_cil(int indent, struct policydb *pdb,
 	struct ebitmap_node *node;
 	uint32_t i;
 
+	if (!pdb->mls)
+		return 0;
+
 	if (ebitmap_is_empty(&order)) {
 		return 0;
 	}
@@ -2761,6 +2767,9 @@ static int cat_to_cil(int indent, struct policydb *pdb,
 {
 	struct cat_datum *cat = datum;
 
+	if (!pdb->mls)
+		return 0;
+
 	if (scope == SCOPE_REQ) {
 		return 0;
 	}
@@ -2783,6 +2792,9 @@ static int cat_order_to_cil(int indent, struct policydb *pdb,
 	struct ebitmap_node *node;
 	uint32_t i;
 
+	if (!pdb->mls)
+		return 0;
+
 	if (ebitmap_is_empty(&order)) {
 		rc = 0;
 		goto exit;
-- 
2.55.0

