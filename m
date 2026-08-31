Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B037F32E
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202750; cv=none; b=IneW778kx4eahDaBf5jjKeWyjOAgsmxsTp5zkBWqZjHIxuHDuojd+bTw32MRInpnRL9UHT5oAyRO7WEP7bT2/D9/+gqSvAlNbUPoEJ6BeDgyVlOZp7EtT8GreMvzPC3kcCf3Ohaa6H3CI/HkN+Z1mX25uebhYxRW04rxRSXzBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202750; c=relaxed/simple;
	bh=VPWVC+Ma1f9XHd6x4MCsn82YD4DEpjiXJb+4LQrYZuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kViU0Z76Yz4xsxCOa0dFJaOmm1dwIALG8h8ADNr34+pyNFWODwc8o05EhP3ajUF2F2hIjrzjcPZ+kVwmHEQIPUiGDsdNazi6wxYdW4N0wvW8qzsXWLVNuD8dvXBql0tL+C+PI5i0N2EnYkV2nXiVfNNayTXEBnT4ksS1dH/9Gxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDme3Goc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDme3Goc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93905b1dc65so263865885a.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202747; x=1788807547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdxfR/6Mf4mxvnFyYWGY+qWOo5x4RAFsuaFWcmpDtgk=;
        b=DDme3GocYT+anzBgQFEp84MPvGOj9/7fJD5uGkNgucBAeOrdY44XsAD+vDr3qaaVML
         OfF8aFmcWYC+hx8hc3EFkds/EZDiLLcb0MEcRviUwVYrlYk5vH44Z0dNl0tPCEBYP9Az
         E5wVMyjlI5KcEChQ1tr+UpqsaUQOtVgOZwY/yXQUhdeym6uGrLYvySBPu245bb1wMDRV
         On9K5ecOzcJ86O4Sm/SErXq4mlhOuIQTkqU/QP5gvN0TxnUwqSonZRL0vHjbyXw44qCA
         fjvHaWw8L5K0aXe+aj84IFiqDNuD7B3iVnfh1IOh+BpXYnVSf42DYUGPcAxPt00wNX90
         BZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202747; x=1788807547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdxfR/6Mf4mxvnFyYWGY+qWOo5x4RAFsuaFWcmpDtgk=;
        b=r132L5Xd2rsfGY4G3ddt20AyuWlzGE0ZRt9hsu6AUS/0w6QbvJMkmCCjN2V3EfAQKn
         3oAR/E7vZJ+0iXWZZZIGRpCth2Q7kzy3jIqDM4l9RwSIWIjWWmFKoKWOKcTLshiqZXjU
         0DrNzdPHIjwnewOfrcWYWk0Aq9MbyQMu2TjBosF2CGC2Awa5JzFpmkmd7TNCRwvDd+Oz
         NTpuhVD5guDKeCfE2rJmLaIxLYaHPjjsseq+LRym3jD7+gbxeZa4CvzFANISuW+8l5FP
         1dTNUatzsVFrw4T7kS2XYlfi6iMXLsr0DAYKBdebv52IT9GLXOfUjghsVJJn2c6E/iXo
         38Tw==
X-Gm-Message-State: AFuF++kG4/c6SEQkQnfkik7FjPukLoPUg6Itr4tIs8nKjTwpYwIYVoAf
	ENK2WCkyfc8AOez3Aek5dYbdL/ElYsKhUoTH/L6Axv1Duj0XJXYzkYWSGXhEbA==
X-Gm-Gg: AR+sD10am94vUuja1Iw03MRgaxhu/dpqaCmE03gVlAcrKSxnN/QngmIv7bIRYOPcB26
	KIS1JbKvr564oIC1Sn1XxLddf5s4lz6UZCxcS43ff9xfMeyf3EssWH11yejydRclb2E0H6Gk7I4
	lBnZVcK4Ip/6jsh8+lVFOFyI1ypwupAzWjZuoLZiph6KNw3mFg8XmVt3dd5JHGe+ZxrLZPd/KVi
	ojiTJJXes69UjVNiO6mePRjlO1a/STz9hNKyLl6diVQdI7SqKI6n+VvXY2VnA9BEpmswHITOM+i
	StOfuZKxqnTXbRfvakcwnrNwiyEYeGl1MwxkuJgCzx6GyBcwmMKpIvPmKZJXuLdBU+jvZEx/1mb
	3pyuUBiBqVZO3IbAZivr59n1jRL6yaqEYijQUmVZXsOa9d40u2uBBiU7taNJn5QKMDVrQArTqnZ
	oFVoCRc4rDOar2+V+6TsEoHWiti7S3aF0gKBn+H8nvDM3+rhVaet5N6TVi5YEcs1v8wK+CJSklP
	fFEHbYSGDNKQclDnYYw8A==
X-Received: by 2002:a05:620a:319d:b0:937:45fb:6b95 with SMTP id af79cd13be357-93947fe52e2mr441610085a.17.1788202747340;
        Mon, 31 Aug 2026 11:59:07 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740bb62sm862219185a.43.2026.08.31.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:59:06 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Check for mls components in non-mls policy during validation
Date: Mon, 31 Aug 2026 14:58:51 -0400
Message-ID: <20260831185851.80078-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831185851.80078-1-jwcart2@gmail.com>
References: <20260831185851.80078-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-mls policies:
- Check that the level and category global symbol tables are empty.
- Check that the level and category avrule block symbol tables are
empty.
- Check that the level and category scope bitmaps are empty.
- Check that users range and default level (both semantic and
expanded) are not set.
- Check that constraints and validatetrans rules have no MLS
expressions.
- Check that there are no range transitions

Fail validation if any of these checks fail.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 99 +++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d27f88..7ef6eea2 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -263,7 +263,7 @@ bad:
 
 static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				     const constraint_node_t *cons,
-				     validate_t flavors[])
+				     const policydb_t *p, validate_t flavors[])
 {
 	const constraint_expr_t *cexp;
 	const int is_validatetrans = (nperms == UINT32_MAX);
@@ -368,12 +368,15 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				case CEXPR_USER:
 				case CEXPR_ROLE:
 				case CEXPR_TYPE:
+					break;
 				case CEXPR_L1L2:
 				case CEXPR_L1H2:
 				case CEXPR_H1L2:
 				case CEXPR_H1H2:
 				case CEXPR_L1H1:
 				case CEXPR_L2H2:
+					if (!p->mls)
+						goto bad;
 					break;
 				default:
 					goto bad;
@@ -487,7 +490,7 @@ validate_common_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 }
 
 static int validate_class_datum(sepol_handle_t *handle,
-				const class_datum_t *class,
+				const class_datum_t *class, const policydb_t *p,
 				validate_t flavors[])
 {
 	if (class->s.value > UINT16_MAX ||
@@ -509,10 +512,10 @@ static int validate_class_datum(sepol_handle_t *handle,
 		    class->comdatum ? class->comdatum->permissions.nprim : 0))
 		goto bad;
 	if (validate_constraint_nodes(handle, class->permissions.nprim,
-				      class->constraints, flavors))
+				      class->constraints, p, flavors))
 		goto bad;
 	if (validate_constraint_nodes(handle, UINT32_MAX, class->validatetrans,
-				      flavors))
+				      p, flavors))
 		goto bad;
 
 	switch (class->default_user) {
@@ -568,7 +571,8 @@ static int validate_class_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 {
 	map_arg_t *margs = args;
 
-	return validate_class_datum(margs->handle, d, margs->flavors);
+	return validate_class_datum(margs->handle, d, margs->policy,
+				    margs->flavors);
 }
 
 static int validate_role_datum(sepol_handle_t *handle, const role_datum_t *role,
@@ -862,30 +866,29 @@ bad:
 static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
 			       validate_t flavors[], const policydb_t *p)
 {
+	int allow_unset;
+
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
 	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
 		goto bad;
-	if (p->mls) {
-		int allow_unset = (p->policy_type != POLICY_MOD);
-		if (validate_mls_semantic_range(
-			    &user->range, &flavors[SYM_LEVELS],
-			    &flavors[SYM_CATS], allow_unset))
-			goto bad;
-		if (validate_mls_semantic_level(
-			    &user->dfltlevel, &flavors[SYM_LEVELS],
-			    &flavors[SYM_CATS], allow_unset))
-			goto bad;
 
-		allow_unset = (p->policy_type != POLICY_KERN);
-		if (validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS],
-				       &flavors[SYM_CATS], allow_unset))
-			goto bad;
-		if (validate_mls_level(&user->exp_dfltlevel,
-				       &flavors[SYM_LEVELS], &flavors[SYM_CATS],
-				       allow_unset))
-			goto bad;
-	}
+	allow_unset = (!p->mls) || (p->policy_type != POLICY_MOD);
+	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS],
+					&flavors[SYM_CATS], allow_unset))
+		goto bad;
+	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS],
+					&flavors[SYM_CATS], allow_unset))
+		goto bad;
+
+	allow_unset = (!p->mls) || (p->policy_type != POLICY_KERN);
+	if (validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS],
+			       &flavors[SYM_CATS], allow_unset))
+		goto bad;
+	if (validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS],
+			       &flavors[SYM_CATS], allow_unset))
+		goto bad;
+
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
@@ -1021,13 +1024,20 @@ static int validate_datum_array_entries(sepol_handle_t *handle,
 			&margs))
 		goto bad;
 
-	if (hashtab_map(symtabs[SYM_LEVELS].table, validate_level_datum_wrapper,
-			&margs))
-		goto bad;
+	if (p->mls) {
+		if (hashtab_map(symtabs[SYM_LEVELS].table,
+				validate_level_datum_wrapper, &margs))
+			goto bad;
 
-	if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
-			&flavors[SYM_CATS]))
-		goto bad;
+		if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
+				&flavors[SYM_CATS]))
+			goto bad;
+	} else {
+		if (symtabs[SYM_LEVELS].table->nel != 0)
+			goto bad;
+		if (symtabs[SYM_CATS].table->nel != 0)
+			goto bad;
+	}
 
 	if (hashtab_map(symtabs[SYM_BOOLS].table, validate_bool_datum_wrapper,
 			&margs))
@@ -1740,10 +1750,19 @@ static int validate_scope_index(sepol_handle_t *handle,
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_bools_scope, &flavors[SYM_BOOLS]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_sens_scope, &flavors[SYM_LEVELS]))
-		goto bad;
-	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
-		goto bad;
+	if (p->mls) {
+		if (validate_ebitmap(&scope_index->p_sens_scope,
+				     &flavors[SYM_LEVELS]))
+			goto bad;
+		if (validate_ebitmap(&scope_index->p_cat_scope,
+				     &flavors[SYM_CATS]))
+			goto bad;
+	} else {
+		if (!ebitmap_is_empty(&scope_index->p_sens_scope))
+			goto bad;
+		if (!ebitmap_is_empty(&scope_index->p_cat_scope))
+			goto bad;
+	}
 
 	if (scope_index->class_perms_map != NULL) {
 		uint32_t i;
@@ -1927,8 +1946,13 @@ static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data,
 	const range_trans_t *rt = (const range_trans_t *)key;
 	const mls_range_t *r = data;
 	const map_arg_t *margs = args;
+	const policydb_t *p = margs->policy;
 	const validate_t *flavors = margs->flavors;
 
+	if (!p->mls) {
+		ERR(margs->handle, "Range transition found in non-MLS policy");
+		goto bad;
+	}
 	if (validate_value(rt->source_type, &flavors[SYM_TYPES]))
 		goto bad;
 	if (validate_value(rt->target_type, &flavors[SYM_TYPES]))
@@ -2091,6 +2115,13 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_policycaps(handle, p))
 		goto bad;
 
+	if (!p->mls) {
+		if (flavors[SYM_LEVELS].nprim != 0)
+			goto bad;
+		if (flavors[SYM_CATS].nprim != 0)
+			goto bad;
+	}
+
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtab(handle, &p->te_avtab, p, flavors))
 			goto bad;
-- 
2.55.0

