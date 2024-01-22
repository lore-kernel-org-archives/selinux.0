Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFF3D3A0
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931719; cv=none; b=WvU9bL9XrkQB+j2Ne676H68DuQ2bsOhxkiUNQGQpNImwTsX02KOBR47m+T96OBumweyFntaX2tanerDeFr0ddwidM24guWIxy/g72UZ6RdfJODwR5Afw2ZEXjSUAwtf88ltmU56tRlRRGsTFF29WPdqPmOcKtwFYDmDNPAmF+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931719; c=relaxed/simple;
	bh=cl6SIwFEarVex7VYICq2weCv8alWb3XB3TxJiOvl10o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUMvZv90UZ5pBXcC5BP510lU+bQrtX0bRUV2uO6a7iKJuM5/WVoMWG9bFdfZnwljPmwl9aZd8QbE1AgZ1Dk1Kp0a6EQYcHrO2B8gMO4bmBu0AnRXyeirdJqt/OK35rYR+8H8aapbltpqmP0lKi5elL4oFnUqU9g3KwJimEJYoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LX2KoFUU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LX2KoFUU"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd33336b32so41026251fa.0
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931715; x=1706536515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFk4m6iPOYII/GpizUkOAfGKmwJeNtqA/FGMNqm2usg=;
        b=LX2KoFUU3xZxpM6jmPADMDnWQu01NhY/p1Gw+qc2CnQwoAnwvCVSpQweqDc9gFW6MD
         cNhr+h0HaEQADiq7/wldSrR/dTvWUPIXpvMA96KSfMkggNwzP7dl9RuNkjvUjdlNKpbL
         /GQQz6v56RM745zmKkBCXa1wBWC0OyqK4f5KIQKVRul5GvSBnPHl1T9b5WjHLnPYdtt9
         45jYLOIFeVmIoHphC2/+l7gy+Uf7oAnoxg2upLROR3PU54rkE7G7I5oqaVV8RIKmFOca
         DDsSg5k20/bnRrym4D4GjpaQDmP3KiPKuvoI81qCPz3dMUWlVLt/4BvmMcay3ChHsQxv
         Nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931715; x=1706536515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFk4m6iPOYII/GpizUkOAfGKmwJeNtqA/FGMNqm2usg=;
        b=H4Ec48tMSnXnQylYwY8rh8iMA3Aq5VVrhjSaRWHwUwt0TXpRiPfGLtajhu8ICgzA1Q
         3Yogo91HlAe2Sc+9ficnVmYpBenHSIwY3D3WUwaS/84LaDzC25EU5Z96HePQry1xfHwY
         RF7qJytXwa1kzGPPtsD0wyGJmxLSNcTd6XKdVdXKevjb3/E7Mp/6sTC3NxsNJF9w1XpI
         qb3xWslnNiVWhDay5xPaDJGGMdnkVovVBuGFocjsg4NU7sgbcMN1nhopwkpwY9oipPcA
         a9ti+dhBknpVheqEtW2OgpLW01g1wRydf49TzEP0jytLrKh3nM2HQNHHiRsXbXacAwsc
         GVhg==
X-Gm-Message-State: AOJu0YyM+Na1JEgyrlBDWJXxcJv5xhi/csd/J9rgqdbKsDOCJ5IazTNf
	5b5EFRl3G7rEfU5tEJvsZ5taO3MplsQKh+YmKTDLBPCqtvApT+FEg2UolIrs
X-Google-Smtp-Source: AGHT+IGczWoECc/LtgztB7W2gKIKCnLUBnhuti3qaPK7u1TaL/Wzp8eu9mxNrW552nxvvT13r01mrQ==
X-Received: by 2002:a05:6512:2312:b0:50e:8158:1fae with SMTP id o18-20020a056512231200b0050e81581faemr2440958lfu.99.1705931715235;
        Mon, 22 Jan 2024 05:55:15 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:14 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 03/15] checkpolicy: cleanup identifiers on error
Date: Mon, 22 Jan 2024 14:54:55 +0100
Message-ID: <20240122135507.63506-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Free identifiers removed from the queue but not yet owned by the policy
on errors.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 260e609d..db7e9d0e 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -342,6 +342,7 @@ static int read_classes(ebitmap_t *e_classes)
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
+			free(id);
 			return -1;
 		}
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
@@ -373,15 +374,18 @@ int define_default_user(int which)
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
+			free(id);
 			return -1;
 		}
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
 		if (!cladatum) {
 			yyerror2("unknown class %s", id);
+			free(id);
 			return -1;
 		}
 		if (cladatum->default_user && cladatum->default_user != which) {
 			yyerror2("conflicting default user information for class %s", id);
+			free(id);
 			return -1;
 		}
 		cladatum->default_user = which;
@@ -405,15 +409,18 @@ int define_default_role(int which)
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
+			free(id);
 			return -1;
 		}
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
 		if (!cladatum) {
 			yyerror2("unknown class %s", id);
+			free(id);
 			return -1;
 		}
 		if (cladatum->default_role && cladatum->default_role != which) {
 			yyerror2("conflicting default role information for class %s", id);
+			free(id);
 			return -1;
 		}
 		cladatum->default_role = which;
@@ -437,15 +444,18 @@ int define_default_type(int which)
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
+			free(id);
 			return -1;
 		}
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
 		if (!cladatum) {
 			yyerror2("unknown class %s", id);
+			free(id);
 			return -1;
 		}
 		if (cladatum->default_type && cladatum->default_type != which) {
 			yyerror2("conflicting default type information for class %s", id);
+			free(id);
 			return -1;
 		}
 		cladatum->default_type = which;
@@ -469,15 +479,18 @@ int define_default_range(int which)
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_CLASSES, id)) {
 			yyerror2("class %s is not within scope", id);
+			free(id);
 			return -1;
 		}
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
 		if (!cladatum) {
 			yyerror2("unknown class %s", id);
+			free(id);
 			return -1;
 		}
 		if (cladatum->default_range && cladatum->default_range != which) {
 			yyerror2("conflicting default range information for class %s", id);
+			free(id);
 			return -1;
 		}
 		cladatum->default_range = which;
@@ -508,6 +521,7 @@ int define_common_perms(void)
 	comdatum = hashtab_search(policydbp->p_commons.table, id);
 	if (comdatum) {
 		yyerror2("duplicate declaration for common %s\n", id);
+		free(id);
 		return -1;
 	}
 	comdatum = (common_datum_t *) malloc(sizeof(common_datum_t));
@@ -770,12 +784,14 @@ int define_sens(void)
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
 			yyerror("sensitivity aliases may not contain periods");
-			goto bad_alias;
+			free(id);
+			return -1;
 		}
 		aliasdatum = (level_datum_t *) malloc(sizeof(level_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
-			goto bad_alias;
+			free(id);
+			return -1;
 		}
 		level_datum_init(aliasdatum);
 		aliasdatum->isalias = TRUE;
@@ -940,12 +956,14 @@ int define_category(void)
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
 			yyerror("category aliases may not contain periods");
-			goto bad_alias;
+			free(id);
+			return -1;
 		}
 		aliasdatum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
-			goto bad_alias;
+			free(id);
+			return -1;
 		}
 		cat_datum_init(aliasdatum);
 		aliasdatum->isalias = TRUE;
@@ -3722,6 +3740,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 				if (!is_id_in_scope(SYM_USERS, id)) {
 					yyerror2("user %s is not within scope",
 						 id);
+					free(id);
 					constraint_expr_destroy(expr);
 					return 0;
 				}
@@ -3733,6 +3752,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 								    id);
 				if (!user) {
 					yyerror2("unknown user %s", id);
+					free(id);
 					constraint_expr_destroy(expr);
 					return 0;
 				}
@@ -3742,6 +3762,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 					yyerror2("role %s is not within scope",
 						 id);
 					constraint_expr_destroy(expr);
+					free(id);
 					return 0;
 				}
 				role =
@@ -3753,6 +3774,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 				if (!role) {
 					yyerror2("unknown role %s", id);
 					constraint_expr_destroy(expr);
+					free(id);
 					return 0;
 				}
 				val = role->s.value;
@@ -3765,11 +3787,13 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 			} else {
 				yyerror("invalid constraint expression");
 				constraint_expr_destroy(expr);
+				free(id);
 				return 0;
 			}
 			if (ebitmap_set_bit(&expr->names, val - 1, TRUE)) {
 				yyerror("out of memory");
 				ebitmap_destroy(&expr->names);
+				free(id);
 				constraint_expr_destroy(expr);
 				return 0;
 			}
-- 
2.43.0

