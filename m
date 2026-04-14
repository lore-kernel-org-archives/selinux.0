Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66030B529
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193900; cv=none; b=tJeOu6jZZJSQ2g145hkSba9dwFy1v+SnWyXC8VZ82Gdl143ZIdre7f9b5a9PPJrkJ1HZKZCPCZLOwdZgswcmQjBhJOVP4OPnwTkVTcqw0QPpqTsLVDUc2+Ky8SGplDsyOIKW1zKufyuUDX4F7wJRxj8UituU0zWT01n/UC34syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193900; c=relaxed/simple;
	bh=2rjpoIae8sih1hByGKiLBywoOiOI85e109WmfjVED7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWlpSWk1G1biPtpkSGl6EuShBr8sYblshbqFz6QYwA15xK0uNf8mBaNrGVkD17epUK7/XkiGY03yv5gyl4j47rg8ygPybHwXwxi2cCSIi97wef17aBTZ1Xj8eEkgmbQgRKj7tJ472TlE3d458CRpPTs5CvYI3Zj5ClNMAnwEqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1RgtGRK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1RgtGRK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd71fb9f06so371409485a.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193898; x=1776798698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DTy3L779vbrInAOC+qfDcKmFqZ02YERXGk8phRK0Fk=;
        b=R1RgtGRK0HYNRhldrnE7faDTF+0LLnTWhFURTINVlN4V+S1I9gztVltHTJypiLMFWH
         1fxOiQN2Z+C9bzE6Bb5AOFL7JJ4B5gIxWtJTUHPLxLvrFbeJHSrIx7v5cY1iyKNLfyXz
         z8w12jNEbN3xK2F6oFIIr7MZ1s8c6BA1rEQ9ITRoTOsvQi5YUO6jayRXAkF6Bq48rPmO
         P8tDS1Eo3heUbrqCnPCXb2uz5LkfxvFMgPZikFd+BnvWYDsnos4eePzRhYMDbC787mfi
         eIwA3Hs59/4DZcR/rLUFR9jRwHsD0s0uvpCCmQYe5SEl9cMCjLuLd1nrXIlGmETd+e3w
         RDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193898; x=1776798698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DTy3L779vbrInAOC+qfDcKmFqZ02YERXGk8phRK0Fk=;
        b=UPu/3b9t4Yei4bK2oLU/RP5CFyQB4xJ3/nPDN0cGvyZJW0JTKLbrGb8rNCidrHfO2s
         AGPJpotc8H8m9Cf7AlwlcJMj7fKSF6/6STuBCkVf9HCmkdUs2M82zAVf4h3Ym98i2f3+
         T1prxAJdROMUa5Osf3iTngj42PGC7OAYT9JGWUqzfeEXY+gkCzcvNe9Z/uVOavsZ1AHF
         d1gfaZJ0zLguxMu65RGsS0pRG8DbmumruoUmMaUVeTAcjFH10VQH99wvjoHXODU1rXcf
         jnNlXsVDuMjEkbXBAR9dBc88l7QYw4nN3mftz3vE+68bJSBkt2LtB/JgGM6drRN7qgYL
         vCFA==
X-Gm-Message-State: AOJu0Yx/03K9tzkGz1a8d1iYPoJhHQAfwouzw7cUMGLp10oQRSsWolIE
	5mBzIzvC3YxG9EW7f4mS8PU8BREYYNgHMKHs91HYlNhWHDCRvi0ud2J/Qp5m1A==
X-Gm-Gg: AeBDiesDz48VY2F3STHZnhQsX8qWHXFLuxTsSiEd5svT1VEMuyAGB9Pn7lI+6r9jPvi
	FmKqvYzfUh+zlLjaEAkg1+qXpgSWn/VuI1V950UNDGllzMN6CwKmV6dJic//EmygAo8RN0ckbAI
	PN7gO9rx/qvErZ0NB7oHmCoy3AhG7Wi4t2RkrprRx4A/fH2LRIl5+1HBCrdanH5xfwy60y0+TEA
	Btev0OXtI36yUNAfxt06+yrOlCDEuSOW0SqxpX1ZieOYNJelDiT8AhPnutuT8S9H/6Yiy/FNUZc
	SnhK7mvxLXY2G41LpxA17YKtF16sxzu8ZpcnkgwhaP+avHqUFg3YR4Rfb++wtx8ucAuvV8YSe2O
	ZSIiWHIjl13+Od60MLP68v+RIOl2Jt3b9rbHMeaOs+7AAD/Q+bZuG/wM/nrlC8kuE9tX94ggapT
	9asNbbBROk6YjtzW5sw1zHJ8QsbRB28o6TzhFUfwfS7k95yE6su1+4GtJP
X-Received: by 2002:a05:620a:448f:b0:8cf:d80c:5ac2 with SMTP id af79cd13be357-8ddce5b5825mr2599156985a.28.1776193897500;
        Tue, 14 Apr 2026 12:11:37 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6e13fsm1210787685a.23.2026.04.14.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:11:36 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol: Validate datum array entries for avrule blocks
Date: Tue, 14 Apr 2026 15:11:20 -0400
Message-ID: <20260414191120.29067-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191120.29067-1-jwcart2@gmail.com>
References: <20260414191120.29067-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both base and module policies have avrule blocks that have their
own symbol tables. When validating a policy, only a very basic
check of the validity of the datum's value was being done for
these symbol tables. The data specific to each kind of datum was
not being checked. This can lead to invalid policies being loaded.

Instead, preform the same specific checks being done on the global
symbol tables on these avrule block symbol tables.

This patch is based on a report from the security firm Trail of Bits

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 36 ++++++++++----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9ee71bf2..3fcdab23 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -874,32 +874,32 @@ static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum
 	return !value_isvalid(s->value, *nprim);
 }
 
-static int validate_datum_array_entries(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
+static int validate_datum_array_entries(sepol_handle_t *handle, const policydb_t *p, const symtab_t *symtabs, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p, 0 };
 
-	if (hashtab_map(p->p_commons.table, validate_common_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_COMMONS].table, validate_common_datum_wrapper, &margs))
 		goto bad;
 
-	if (hashtab_map(p->p_classes.table, validate_class_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_CLASSES].table, validate_class_datum_wrapper, &margs))
 		goto bad;
 
-	if (hashtab_map(p->p_roles.table, validate_role_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_ROLES].table, validate_role_datum_wrapper, &margs))
 		goto bad;
 
-	if (hashtab_map(p->p_types.table, validate_type_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_TYPES].table, validate_type_datum_wrapper, &margs))
 		goto bad;
 
-	if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_USERS].table, validate_user_datum_wrapper, &margs))
 		goto bad;
 
-	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum_wrapper, &margs))
+	if (p->mls && hashtab_map(symtabs[SYM_LEVELS].table, validate_level_datum_wrapper, &margs))
 		goto bad;
 
-	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
+	if (hashtab_map(symtabs[SYM_CATS].table, validate_datum, &flavors[SYM_CATS]))
 		goto bad;
 
-	if (hashtab_map(p->p_bools.table, validate_bool_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_BOOLS].table, validate_bool_datum_wrapper, &margs))
 		goto bad;
 
 	return 0;
@@ -1565,20 +1565,6 @@ bad:
 	return -1;
 }
 
-static int validate_symtabs(sepol_handle_t *handle, const symtab_t symtabs[], validate_t flavors[])
-{
-	unsigned int i;
-
-	for (i = 0; i < SYM_NUM; i++) {
-		if (hashtab_map(symtabs[i].table, validate_datum, &flavors[i].nprim)) {
-			ERR(handle, "Invalid symtab");
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_block_t *avrule_block, const policydb_t *p, validate_t flavors[])
 {
 	const avrule_decl_t *decl;
@@ -1601,7 +1587,7 @@ static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_block_t *
 				goto bad;
 			if (validate_filename_trans_rules(handle, decl->filename_trans_rules, p, flavors))
 				goto bad;
-			if (validate_symtabs(handle, decl->symtab, flavors))
+			if (validate_datum_array_entries(handle, p, decl->symtab, flavors))
 				goto bad;
 		}
 
@@ -1853,7 +1839,7 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_datum_array_gaps(handle, p, flavors))
 		goto bad;
 
-	if (validate_datum_array_entries(handle, p, flavors))
+	if (validate_datum_array_entries(handle, p, p->symtab, flavors))
 		goto bad;
 
 	if (validate_permissives(handle, p, flavors))
-- 
2.53.0

