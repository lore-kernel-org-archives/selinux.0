Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C758393DDB
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779558; cv=none; b=ub+dTxyKeYgx5Nj5e/P3z+vcEIY1PDR9nfWrZrghEbJCfST/UUTD0aiC3GO2hF8HcBtmvHTYgwTIgOkJLo6rZ0/blzAtGO1uYInfInNpzkY2DppyrEt/shrvKFOezSFQjOM0SjEQK87fVB5QzJ0lzkThn2hTQUtD2LBEHx+XEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779558; c=relaxed/simple;
	bh=jY5wWmWUHToC0dOCVityOqdVXr2XjnPBwT2tsLkz/2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYJ3iHW/d0qPUIR78Ffc/8bMBTwqokofEju9E6VImAMecq6y0zxNEdhq2pnTQR1s3Zoglu1HSNRBw7LT0R2qjqqNpkWWuXVbhOnC3hBEUdFwpS0C5uuPnWQIKzrhHz0nxfGVs+qcPIAomrpXXGrWQXVm3rXdnjzgdw/kmVMji+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G80M1vHP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G80M1vHP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b5ed9e7500so55067385a.0
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779555; x=1765384355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw7VnDg9qmfCXT7+AEVfyLDYTa7zHIeVr4JGnzp/qvQ=;
        b=G80M1vHPl1X13SSDsm8ZcuDkomM9FkK412SXvNFRLiNiTzM2EirzntgOL16jrv41CK
         uEBRJg020BsLyzDbtx3xr9o9D0eQqgFu9PEFAsPshcqRasX0aY5hzJuVreMvIXN89Sqm
         gIX5oqEN7cdV9/7R3KTqxhvMKyo4BseNUaLm43OykpAYeQ003jl61NoEIKF2t6RrtFGl
         fGNfXLVPD6zgYxC5i44e4cuNjYx7Oi7qIFzwkqsX60076mxbxFLkI/gbq1Rl4WI8zThT
         FJYCo7SaBdoMPx5eEqTijfv26td4P+GWcUXJKXqWo46rlva7mVHUzz3sAUhJL8vPUC/8
         8fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779555; x=1765384355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sw7VnDg9qmfCXT7+AEVfyLDYTa7zHIeVr4JGnzp/qvQ=;
        b=eBi1Xu1EGeJGrZorNOB13Z4BeClWekATYAchp7gFDM6enE1bdo10EYLhbTeSFfnc+N
         HoZQkJOOxrIXGF+97IN97NPr0nrRPSPGef+qJDbNVzO8V73S21cTEJ2Fev/zzukSMLes
         v8I7xQUwUBZ8En89x68Nj/abOnRA+qR67oc7GLjwlCzInHMjV1GP0X91AmEvrqy/5+Qh
         7+WyqFfCs9UOW2idyq79j+UN36EVmwjmXHmphOSmZYVeFcZ7KLjcTbwCwWSLoeB0VCzu
         MHtbtr62i2Wg8z7iddWNhQT5nHCGZaxhkNOPzSXDyl/phvxnvOOIROMVgOIFMfqRje4H
         iTiA==
X-Gm-Message-State: AOJu0Yw8imDYnSImtuBOXor+hZ9HZi1JxX9e/H8klBqkD995cQKtxRqp
	AEndW8YKDi9aVikvn6H7AbCqYmYtVj98Hxx6vSsep8sQB57JHVzwdViiznD/vQ==
X-Gm-Gg: ASbGnctYn1Lv3Hl/dGk7CSJHl6t25QBXbClt7iFC7XVIaABcBoVSmNDyAgUAX0yoWJT
	3m6kMlEpJeVps9VjbpsU4M6ffbQjeylUzbwnlVeb1o6CGrCEnGDFo8iG6JfDcfIhqK6pAFwJ2yo
	ZXLOxOHUu6UOg5k94MCHaG45OINC4op3FsUgurE4k7v5/L1AHF3rAK/KOpLndBFAmlQ1uwILNja
	Wbh2rEZXpnL8W0PU/JtTVAnUPC9OK8Q3t/fdYRBhp+LfEo8a+lI7Cz1fROaPoLBSulSMRjwMYk/
	e77SovzZo2n784sz39edMJAEHbmGuoAVFzcnhFsDxs1/uvdpl5Sl+2C69tqpgyxDr74PxK+wqKM
	N6UD2nktGg36B2LyB5ZombnF25pO2waS4f1OTMA0gPLHFcVq9y3ed4DnZJdQLV+wMJbEJ3fQz0b
	Uu74/rV5IXPIrausY0zKA=
X-Google-Smtp-Source: AGHT+IF+zW+Za9B8iOg4PHspuFltuzcHDh5mboCCZbzrqEsrBcUhpp7VDf1HewiW0rCN+jewzrooTw==
X-Received: by 2002:a05:620a:29d5:b0:8b2:dabe:de27 with SMTP id af79cd13be357-8b5e7453da5mr400184485a.85.1764779554233;
        Wed, 03 Dec 2025 08:32:34 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:33 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6] libsepol: Expand role attributes when expanding instead of when linking
Date: Wed,  3 Dec 2025 11:32:18 -0500
Message-ID: <20251203163218.54939-7-jwcart2@gmail.com>
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

Role attributes are being expanded during the linking phase rather
than during the expand phase. This might be due to some concern
over role attributes not being kept for the kernel policy.

Instead of this, expand role attributes during the expand phase.
One extra step is needed to make sure the pp and mod files end up
the same as before. The role attributes in the base policy need to
be expanded as well as those in the kernel policy. This is because
of a side effect that occurs when compiling a base module. When a
base module is compiled it is linked and expanded inorder to verify
that linking and expansion will work. Even though the resulting
kernel policy is discarded, the base module is changed because the
linking phase expands the role attributes in the base module.

With this change the pp files, mod files, and the final binary
file (bin file) produced are identical to ones produced by an old
toolchain without these changes. The only file that is different
is the linked binary (lnk file). In the old toolchain, all roles
in blocks are added to the role in the global scope and the role
attributes are expanded, but this will be done again when the
policy is expanded. Expanding a linked binary created with these
patches using the old toolchain will produce the same kernel binary
policy. Expanding a linked binary created with the old toolchain
using the new toolchain will also produce the same kernel binary
policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 179 +++++++++++++++++++++++++++++-------------
 libsepol/src/link.c   | 129 ------------------------------
 2 files changed, 126 insertions(+), 182 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 5ecd43e5..04b5e5e4 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -824,27 +824,18 @@ static int role_types_copy_callback(hashtab_key_t key, hashtab_datum_t datum, vo
 	return 0;
 }
 
-/* For the role attribute in the base module, escalate its counterpart's
- * types.types ebitmap in the out module to the counterparts of all the
- * regular role that belongs to the current role attribute. Note, must be
- * invoked after role_copy_callback so that state->rolemap is available.
- */
-static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
-			     void *data)
+static int role_roles_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-	char *id, *base_reg_role_id;
-	role_datum_t *role, *new_role, *regular_role;
+	char *id;
+	role_datum_t *role, *new_role;
 	expand_state_t *state;
-	ebitmap_node_t *rnode;
-	unsigned int i;
-	ebitmap_t mapped_roles;
+	ebitmap_t mapped;
 
 	id = key;
-	role = (role_datum_t *)datum;
+	role = (role_datum_t *) datum;
 	state = (expand_state_t *)data;
 
-	if (strcmp(id, OBJECT_R) == 0) {
-		/* object_r is never a role attribute by far */
+	if (role->flavor != ROLE_ATTRIB) {
 		return 0;
 	}
 
@@ -853,39 +844,107 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
-	if (role->flavor != ROLE_ATTRIB)
-		return 0;
-
 	if (state->verbose)
-		INFO(state->handle, "fixing role attribute %s", id);
+		INFO(state->handle, "copying roles for role %s", id);
 
-	new_role =
-		(role_datum_t *)hashtab_search(state->out->p_roles.table, id);
-
-	assert(new_role != NULL && new_role->flavor == ROLE_ATTRIB);
+	new_role = (role_datum_t *)hashtab_search(state->out->p_roles.table, id);
+	if (!new_role) {
+		ERR(state->handle, "Could not find role %s", id);
+		return -1;
+	}
 
-	ebitmap_init(&mapped_roles);
-	if (map_ebitmap(&role->roles, &mapped_roles, state->rolemap))
+	/* convert roles in the role datum in the global symtab */
+	if (map_ebitmap(&role->roles, &mapped, state->rolemap))
 		return -1;
-	if (ebitmap_union(&new_role->roles, &mapped_roles)) {
+	if (ebitmap_union(&new_role->roles, &mapped)) {
 		ERR(state->handle, "Out of memory!");
-		ebitmap_destroy(&mapped_roles);
+		ebitmap_destroy(&mapped);
 		return -1;
 	}
-	ebitmap_destroy(&mapped_roles);
+	ebitmap_destroy(&mapped);
+
+	return 0;
+}
+static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb_t *p)
+{
+	ebitmap_t attrs, roles;
+	ebitmap_node_t *ni, *nj;
+	unsigned int i, j, reps = 0, done = 0;
+	role_datum_t *rd, *ad;
+
+	ebitmap_init(&attrs);
+	for (i=0; i < p->p_roles.nprim; i++) {
+		rd = p->role_val_to_struct[i];
+		if (rd->flavor == ROLE_ATTRIB) {
+			ebitmap_set_bit(&attrs, i, 1);
+		}
+	}
+
+	while (!done && reps < p->p_roles.nprim) {
+		done = 1;
+		reps++;
+		ebitmap_for_each_positive_bit(&attrs, ni, i) {
+			rd = p->role_val_to_struct[i];
+			if (ebitmap_match_any(&rd->roles, &attrs)) {
+				done = 0;
+				if (ebitmap_get_bit(&rd->roles, i)) {
+					ERR(handle, "Before: attr has own bit set: %d\n", i);
+				}
+				ebitmap_init(&roles);
+				ebitmap_for_each_positive_bit(&rd->roles, nj, j) {
+					if (ebitmap_get_bit(&attrs, j)) {
+						ad = p->role_val_to_struct[j];
+						ebitmap_union(&roles, &ad->roles);
+						ebitmap_set_bit(&rd->roles, j, 0);
+					}
+				}
+				ebitmap_union(&rd->roles, &roles);
+				ebitmap_destroy(&roles);
+				if (ebitmap_get_bit(&rd->roles, i)) {
+					ERR(handle, "After: attr has own bit set: %d\n", i);
+					done = 1; /* Just end early */
+				}
+			}
+		}
+	}
 
-	ebitmap_for_each_positive_bit(&role->roles, rnode, i) {
-		/* take advantage of sym_val_to_name[]
-		 * of the base module */
-		base_reg_role_id = state->base->p_role_val_to_name[i];
-		regular_role = (role_datum_t *)hashtab_search(
-					state->out->p_roles.table,
-					base_reg_role_id);
-		assert(regular_role != NULL &&
-		       regular_role->flavor == ROLE_ROLE);
-
-		if (ebitmap_union(&regular_role->types.types,
-				  &new_role->types.types)) {
+	if (reps >= p->p_roles.nprim) {
+		ERR(handle, "Had to bail: reps = %u\n", reps);
+	}
+
+	ebitmap_destroy(&attrs);
+
+	return 0;
+}
+
+/* For the role attribute in the base module, escalate its counterpart's
+ * types.types ebitmap in the out module to the counterparts of all the
+ * regular role that belongs to the current role attribute. Note, must be
+ * invoked after role_copy_callback so that state->rolemap is available.
+ */
+static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
+			     void *data)
+{
+	char *id;
+	role_datum_t *attr, *role;
+	expand_state_t *state;
+	ebitmap_node_t *rnode;
+	unsigned int i;
+
+	id = key;
+	attr = (role_datum_t *)datum;
+	state = (expand_state_t *)data;
+
+	if (attr->flavor != ROLE_ATTRIB)
+		return 0;
+
+	if (state->verbose)
+		INFO(state->handle, "fixing role attribute %s", id);
+
+	ebitmap_for_each_positive_bit(&attr->roles, rnode, i) {
+		role = state->out->role_val_to_struct[i];
+		assert(role != NULL && role->flavor == ROLE_ROLE);
+		if (ebitmap_union(&role->types.types, &attr->types.types)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
@@ -2494,7 +2553,7 @@ int expand_rule(sepol_handle_t * handle,
  * the regular role belongs to could be properly handled by
  * copy_role_trans and copy_role_allow.
  */
-int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t * base, uint32_t * rolemap)
+int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, __attribute__ ((unused)) policydb_t * base, uint32_t * rolemap)
 {
 	unsigned int i;
 	ebitmap_node_t *rnode;
@@ -2515,29 +2574,25 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 	ebitmap_init(&roles);
 	
 	if (rolemap) {
-		assert(base != NULL);
-		ebitmap_for_each_positive_bit(&x->roles, rnode, i) {
-			/* take advantage of p_role_val_to_struct[]
-			 * of the base module */
-			role = base->role_val_to_struct[i];
+		if (map_ebitmap(&x->roles, &mapped_roles, rolemap))
+			goto bad;
+		ebitmap_for_each_positive_bit(&mapped_roles, rnode, i) {
+			role = out->role_val_to_struct[i];
 			assert(role != NULL);
 			if (role->flavor == ROLE_ATTRIB) {
-				if (ebitmap_union(&roles,
-						  &role->roles))
+				if (ebitmap_union(&roles, &role->roles))
 					goto bad;
 			} else {
 				if (ebitmap_set_bit(&roles, i, 1))
 					goto bad;
 			}
 		}
-		if (map_ebitmap(&roles, &mapped_roles, rolemap))
-			goto bad;
 	} else {
-		if (ebitmap_cpy(&mapped_roles, &x->roles))
+		if (ebitmap_cpy(&roles, &x->roles))
 			goto bad;
 	}
 
-	ebitmap_for_each_positive_bit(&mapped_roles, rnode, i) {
+	ebitmap_for_each_positive_bit(&roles, rnode, i) {
 		if (ebitmap_set_bit(r, i, 1))
 			goto bad;
 	}
@@ -3138,6 +3193,8 @@ int expand_module(sepol_handle_t * handle,
 		goto cleanup;
 	if (hashtab_map(state.base->p_roles.table, role_types_copy_callback, &state))
 		goto cleanup;
+	if (hashtab_map(state.base->p_roles.table, role_roles_copy_callback, &state))
+		goto cleanup;
 	for (curblock = state.base->global; curblock != NULL;
 	     curblock = curblock->next) {
 		avrule_decl_t *decl = curblock->enabled;
@@ -3149,9 +3206,25 @@ int expand_module(sepol_handle_t * handle,
 			goto cleanup;
 		if (hashtab_map(decl->p_roles.table, role_types_copy_callback, &state))
 			goto cleanup;
+		if (hashtab_map(decl->p_roles.table, role_roles_copy_callback, &state))
+			goto cleanup;
+	}
+	/* Expand any role attributes found in the roles ebitmap of each role attribute */
+	if (expand_role_attributes_in_attributes(state.handle, state.out)) {
+		goto cleanup;
 	}
+	/* When compiling a base module, the base module is linked and expanded (to
+	 * verify that it could be done) and the resulting kernel module is discarded.
+	 * But the base module is changed while linking because role attributes are
+	 * expanded while linking instead of being expanded when expanding.
+	 * To duplicate that behavior, expand the base module role attributes.
+	 */
+	if (expand_role_attributes_in_attributes(state.handle, state.base)) {
+		goto cleanup;
+	}
+
 	/* Copy types in role attribute to all roles that belongs to it */
-	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
+	if (hashtab_map(state.out->p_roles.table, role_fix_callback, &state))
 		goto cleanup;
 
 	/* copy MLS's sensitivity level and categories - this needs to be done
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 55c29d21..da65257a 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2366,120 +2366,6 @@ static int prepare_base(link_state_t * state, uint32_t num_mod_decls)
 	return 0;
 }
 
-static int expand_role_attributes(hashtab_key_t key, hashtab_datum_t datum,
-				  void * data)
-{
-	char *id;
-	role_datum_t *role, *sub_attr;
-	link_state_t *state;
-	unsigned int i;
-	ebitmap_node_t *rnode;
-
-	id = key;
-	role = (role_datum_t *)datum;
-	state = (link_state_t *)data;
-
-	if (strcmp(id, OBJECT_R) == 0){
-		/* object_r is never a role attribute by far */
-		return 0;
-	}
-
-	if (role->flavor != ROLE_ATTRIB)
-		return 0;
-
-	if (state->verbose)
-		INFO(state->handle, "expanding role attribute %s", id);
-
-restart:
-	ebitmap_for_each_positive_bit(&role->roles, rnode, i) {
-		sub_attr = state->base->role_val_to_struct[i];
-		if (sub_attr->flavor != ROLE_ATTRIB)
-			continue;
-
-		/* remove the sub role attribute from the parent
-		 * role attribute's roles ebitmap */
-		if (ebitmap_set_bit(&role->roles, i, 0))
-			return -1;
-
-		/* loop dependency of role attributes */
-		if (sub_attr->s.value == role->s.value)
-			continue;
-
-		/* now go on to expand a sub role attribute
-		 * by escalating its roles ebitmap */
-		if (ebitmap_union(&role->roles, &sub_attr->roles)) {
-			ERR(state->handle, "Out of memory!");
-			return -1;
-		}
-
-		/* sub_attr->roles may contain other role attributes,
-		 * re-scan the parent role attribute's roles ebitmap */
-		goto restart;
-	}
-
-	return 0;
-}
-
-/* For any role attribute in a declaration's local symtab[SYM_ROLES] table,
- * copy its roles ebitmap into its duplicate's in the base->p_roles.table.
- */
-static int populate_decl_roleattributes(hashtab_key_t key, 
-					hashtab_datum_t datum,
-					void *data)
-{
-	char *id = key;
-	role_datum_t *decl_role, *base_role;
-	link_state_t *state = (link_state_t *)data;
-
-	decl_role = (role_datum_t *)datum;
-
-	if (strcmp(id, OBJECT_R) == 0) {
-		/* object_r is never a role attribute by far */
-		return 0;
-	}
-
-	if (decl_role->flavor != ROLE_ATTRIB)
-		return 0;
-
-	base_role = (role_datum_t *)hashtab_search(state->base->p_roles.table,
-						   id);
-	assert(base_role != NULL && base_role->flavor == ROLE_ATTRIB);
-
-	if (ebitmap_union(&base_role->roles, &decl_role->roles)) {
-		ERR(state->handle, "Out of memory!");
-		return -1;
-	}
-
-	return 0;
-}
-
-static int populate_roleattributes(link_state_t *state, policydb_t *pol)
-{
-	avrule_block_t *block;
-	avrule_decl_t *decl;
-
-	if (state->verbose)
-		INFO(state->handle, "Populating role-attribute relationship "
-			    "from enabled declarations' local symtab.");
-
-	/* Iterate through all of the blocks skipping the first(which is the
-	 * global block, is required to be present and can't have an else).
-	 * If the block is disabled or not having an enabled decl, skip it.
-	 */
-	for (block = pol->global->next; block != NULL; block = block->next)
-	{
-		decl = block->enabled;
-		if (decl == NULL || decl->enabled == 0)
-			continue;
-
-		if (hashtab_map(decl->symtab[SYM_ROLES].table, 
-				populate_decl_roleattributes, state))
-			return -1;
-	}
-
-	return 0;
-}
-
 /* Link a set of modules into a base module. This process is somewhat
  * similar to an actual compiler: it requires a set of order dependent
  * steps.  The base and every module must have been indexed prior to
@@ -2576,21 +2462,6 @@ int link_modules(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
-	/* Now that all role attribute's roles ebitmap have been settled,
-	 * escalate sub role attribute's roles ebitmap into that of parent.
-	 *
-	 * First, since some role-attribute relationships could be recorded
-	 * in some decl's local symtab(see get_local_role()), we need to
-	 * populate them up to the base.p_roles table. */
-	if (populate_roleattributes(&state, state.base)) {
-		retval = SEPOL_EREQ;
-		goto cleanup;
-	}
-	
-	/* Now do the escalation. */
-	if (hashtab_map(state.base->p_roles.table, expand_role_attributes,
-			&state))
-		goto cleanup;
 
 	retval = 0;
       cleanup:
-- 
2.50.0

