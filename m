Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A33A1CFC
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779557; cv=none; b=fJtLAQqE97yrDYMFa55ZcbN/iG9KaTByzR1bwI3xRCd3CHRTibonhy4gFhfN+TUaCgbY+LQ+JILnQMEC/eLbPJosrI960JK8rhnPCR4lqZSG9JdniEZkXJB7IJmqNkCY4Zg+kOgNLIO5MvKuvHObivAzerYRgj8wL3L2wqJKUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779557; c=relaxed/simple;
	bh=ZGYlfjWxFXL5/OKNsSdWhn8+ku+juJ5N05H/JJnxOeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNFaci4ayZ3cU9bllyIwn5pdgkUV3hmQWzkLGZG3wubWtGxVfssubNpKODQxOrqLOEf6QUBiVeQno2f8CJO1sSRdrwplXLUDQLrAHquSDbuUWyF0HfYoQ/S5fCdbICXr12BKw8qcJjIYlE4XB3f4HRxvK/6clQL3wRMe8VYS2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUjmjuvA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUjmjuvA"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2d56eaaceso670845285a.0
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779554; x=1765384354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No4FY0cu04v58BTGST7lSWAxQO2HHVUl9Rgv3MAH630=;
        b=nUjmjuvAMvF9mZSAv7SdWpGHFNJDaOyM3MDsT3W5Gtx5Sv6UqnsrOqzumdm1yN2HuN
         sKtcHIhMd6olPA4n1bHjU8wbwUoGSzRlRqjw6lKosH6ZSJfyan0U2rxtlTCw5QBvp5a6
         2q7bd3iBz8VmT1HLq2GIyflAZCKGGb8/vPTRqtXDqmVSiEmkCB9834s63wlE0SgqJxyL
         r3BJ0Wc2HuDM9f/Gtsy2wUDU5vdwZ/6bkzuYZitCQgqvNd9vFV6PTuOYsVZxtM2icf92
         Rob8/OGeC2G8X4QfZ0KInWON1AtcKhl9Q0cvIEUtibviTMbZCIHkrfWSk86kSlIKhcf8
         QYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779554; x=1765384354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=No4FY0cu04v58BTGST7lSWAxQO2HHVUl9Rgv3MAH630=;
        b=CCKdwHwsMk6xBJpUkRm1MZJN5idk4wGHofEM/sqQsIs3hG9h9+FiSGu4th6o66qMQj
         zewghL2Pj8oI/xyXUTYeWpTXyeOK+g4DtXZ6V9K/E3eEn7icCzmc26jcQSJ0/HDOXPhb
         rQ/WJgQma11reV335EC0i35QRClxzVI/laKoOrxvdNF1ZctMBaah2fwzY/3T2anAO1rJ
         FII38JjCFHQHTGjSQO6gbfHVTrcwBju5pJncmLiuxClyRBe2f0qEWtPQ6EoVt1bahs38
         nUvkYr5u3y9Y6mR4e/f6aC7dWPKYMgdntyb/goxzSINJNhRGSzfUHPTHO0tHL72zXttN
         ckpg==
X-Gm-Message-State: AOJu0YyD/L36cRbNoFm4qrDrNt08qb+TcyI3swkasZXLM+M1UIPErdyf
	1UEV6ga84dIGeY32Sgrg3nmNBFvbTQ0zBuCT7E+S6tuNUDOmVk1Et8gKYuM3Dg==
X-Gm-Gg: ASbGnct9Nvx9fMOZDNkzlmpkANtzhksHeQGeLjT+2Thu/YNz0fsW3XtwOUjsXOW0MoE
	xcb7cerFbh4uRdoXshjNoIrkClvDkzXaZeckdGobMBlD9nwrwRERIwydXfu3IjxsaN+pddUp1/D
	XTQmmP8O4ZVGQiIwJWGRUMp7S8e7j2RdCJam9Sannq1k2FzttiuJgQrLtxDaWO92ziomELhO6A3
	2kB5eOj43aFeDlxiM0JsmXxlQSXRkuXapSGUsyCnN1jr9kzF3XsHxwdPF7NHfWx7lKJX0wW92vR
	4jDz8tjH+XBjBApIsTKL3eS58U2EXJX3E2We/SSoqbYBWJeyKoagabCdlQ0oA7pW1EroeRwaNh/
	0xlEkTbtcZtWYpXlrHPVA05I0d6vLFfg6aItzs9j9Rx61wpRMnWUSvWB/TtBJWps8yHS4Jwpz/f
	wVnDFoy9INBsqtmZud1CU=
X-Google-Smtp-Source: AGHT+IHKNnq7XG6LBAS6lFKNPwjE0EfVyqRpmDoYm+ZLhLPMlyTUrUINy9rnzgcYqqbtjq9mOb2Y+g==
X-Received: by 2002:a05:620a:4448:b0:8ad:32ae:b6c1 with SMTP id af79cd13be357-8b5e6c8ce6dmr366190285a.47.1764779553411;
        Wed, 03 Dec 2025 08:32:33 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:32 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6] libsepol: Fix problem with handling type attributes in role-types rule
Date: Wed,  3 Dec 2025 11:32:17 -0500
Message-ID: <20251203163218.54939-6-jwcart2@gmail.com>
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

A role-types rule that has an attribute in the types expression will
be improperly expanded if types are associated with the attribute
in other modules.

For example:
In a base module there is the following:
attribute at1;
type t1a;
typeattribute t1a at1;
role r1a;
role r1a types at1;

In another module there is the following:
type t1b;
typeattribute t1b at1;

In this example, t1b will not be associated with r1a even though it
is associated with at1.

The problem is with the order that types and roles are expanded.
All types must be completely expanded before expanding the types
of a role.

First, expand types completely, then expand roles completely, and
then, expand users completely.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 229 ++++++++++++++++++++++--------------------
 1 file changed, 122 insertions(+), 107 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 61dee255..5ecd43e5 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -747,21 +747,79 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
-static int role_remap_dominates(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *data)
+static int role_dominates_copy_callback(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *data)
 {
-	ebitmap_t mapped_roles;
-	role_datum_t *role = (role_datum_t *) datum;
-	expand_state_t *state = (expand_state_t *) data;
+	char *id;
+	role_datum_t *role, *new_role;
+	expand_state_t *state;
+	ebitmap_t mapped;
 
-	if (map_ebitmap(&role->dominates, &mapped_roles, state->rolemap))
+	id = (char *)key;
+	role = (role_datum_t *) datum;
+	state = (expand_state_t *) data;
+
+	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
+		/* identifier's scope is not enabled */
+		return 0;
+	}
+
+	if (state->verbose)
+		INFO(state->handle, "Copying role dominates %s", id);
+
+	new_role = (role_datum_t *) hashtab_search(state->out->p_roles.table, id);
+	if (!new_role) {
+		ERR(state->handle, "Role lookup failed for %s", id);
 		return -1;
+	}
 
-	ebitmap_destroy(&role->dominates);	
-	
-	if (ebitmap_cpy(&role->dominates, &mapped_roles))
+	if (map_ebitmap(&role->dominates, &mapped, state->rolemap))
 		return -1;
+	if (ebitmap_union(&new_role->dominates, &mapped))
+		return -1;
+	ebitmap_destroy(&mapped);
 
-	ebitmap_destroy(&mapped_roles);
+	return 0;
+}
+
+static int role_types_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	char *id;
+	role_datum_t *role, *new_role;
+	expand_state_t *state;
+	ebitmap_t tmp_union_types;
+
+	id = key;
+	role = (role_datum_t *) datum;
+	state = (expand_state_t *)data;
+
+	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
+		/* identifier's scope is not enabled */
+		return 0;
+	}
+
+	if (state->verbose)
+		INFO(state->handle, "copying types for role %s", id);
+
+	new_role = (role_datum_t *)hashtab_search(state->out->p_roles.table, id);
+	if (!new_role) {
+		ERR(state->handle, "Could not find role %s", id);
+		return -1;
+	}
+
+	/* convert types in the role datum in the global symtab */
+	ebitmap_init(&tmp_union_types);
+	if (expand_convert_type_set
+	    (state->out, state->typemap, &role->types, &tmp_union_types, 1)) {
+		ebitmap_destroy(&tmp_union_types);
+		ERR(state->handle, "Out of memory!");
+		return -1;
+	}
+	if (ebitmap_union(&new_role->types.types, &tmp_union_types)) {
+		ERR(state->handle, "Out of memory!");
+		ebitmap_destroy(&tmp_union_types);
+		return -1;
+	}
+	ebitmap_destroy(&tmp_union_types);
 
 	return 0;
 }
@@ -841,10 +899,8 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 {
 	int ret;
 	char *id, *new_id;
-	role_datum_t *role;
-	role_datum_t *new_role;
+	role_datum_t *role, *new_role;
 	expand_state_t *state;
-	ebitmap_t tmp_union_types;
 
 	id = key;
 	role = (role_datum_t *) datum;
@@ -864,8 +920,7 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	if (state->verbose)
 		INFO(state->handle, "copying role %s", id);
 
-	new_role =
-	    (role_datum_t *) hashtab_search(state->out->p_roles.table, id);
+	new_role = (role_datum_t *) hashtab_search(state->out->p_roles.table, id);
 	if (!new_role) {
 		new_role = (role_datum_t *) malloc(sizeof(role_datum_t));
 		if (!new_role) {
@@ -897,31 +952,6 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		}
 	}
 
-	/* The dominates bitmap is going to be wrong for the moment, 
- 	 * we'll come back later and remap them, after we are sure all 
- 	 * the roles have been added */
-	if (ebitmap_union(&new_role->dominates, &role->dominates)) {
-		ERR(state->handle, "Out of memory!");
-		return -1;
-	}
-
-	ebitmap_init(&tmp_union_types);
-
-	/* convert types in the role datum in the global symtab */
-	if (expand_convert_type_set
-	    (state->out, state->typemap, &role->types, &tmp_union_types, 1)) {
-		ebitmap_destroy(&tmp_union_types);
-		ERR(state->handle, "Out of memory!");
-		return -1;
-	}
-
-	if (ebitmap_union(&new_role->types.types, &tmp_union_types)) {
-		ERR(state->handle, "Out of memory!");
-		ebitmap_destroy(&tmp_union_types);
-		return -1;
-	}
-	ebitmap_destroy(&tmp_union_types);
-
 	return 0;
 }
 
@@ -3055,14 +3085,26 @@ int expand_module(sepol_handle_t * handle,
 	/* order is important - types must be first */
 
 	/* copy types */
-	if (hashtab_map(state.base->p_types.table, type_copy_callback, &state)) {
+	if (hashtab_map(state.base->p_types.table, type_copy_callback, &state))
 		goto cleanup;
-	}
-
-	/* convert attribute type sets */
-	if (hashtab_map
-	    (state.base->p_types.table, attr_convert_callback, &state)) {
+	/* Needed for processing aliases */
+	if (policydb_index_others(handle, out, verbose))
+		goto cleanup;
+	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
+		goto cleanup;
+	if (hashtab_map(state.base->p_types.table, type_bounds_copy_callback, &state))
+		goto cleanup;
+	if (hashtab_map(state.base->p_types.table, attr_convert_callback, &state))
 		goto cleanup;
+	for (curblock = state.base->global; curblock != NULL;
+	     curblock = curblock->next) {
+		avrule_decl_t *decl = curblock->enabled;
+		if (decl == NULL)
+			continue;
+		if (hashtab_map(decl->p_types.table, attr_convert_callback, &state))
+			goto cleanup;
+		if (hashtab_map(decl->p_types.table, type_bounds_copy_callback, &state))
+			goto cleanup;
 	}
 
 	/* copy commons */
@@ -3078,16 +3120,7 @@ int expand_module(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
-	/* copy type bounds */
-	if (hashtab_map(state.base->p_types.table,
-			type_bounds_copy_callback, &state))
-		goto cleanup;
-
-	/* copy aliases */
-	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
-		goto cleanup;
-
-	/* index here so that type indexes are available for role_copy_callback */
+	/* index here so that type indexes are available for role_types_copy_callback */
 	if (policydb_index_others(handle, out, verbose)) {
 		ERR(handle, "Error while indexing out symbols");
 		goto cleanup;
@@ -3096,8 +3129,29 @@ int expand_module(sepol_handle_t * handle,
 	/* copy roles */
 	if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
 		goto cleanup;
-	if (hashtab_map(state.base->p_roles.table,
-			role_bounds_copy_callback, &state))
+	/* Needed for evaluating role attributes and the types for each role */
+	if (policydb_index_others(handle, out, verbose))
+		goto cleanup;
+	if (hashtab_map(state.base->p_roles.table, role_bounds_copy_callback, &state))
+		goto cleanup;
+	if (hashtab_map(state.base->p_roles.table, role_dominates_copy_callback, &state))
+		goto cleanup;
+	if (hashtab_map(state.base->p_roles.table, role_types_copy_callback, &state))
+		goto cleanup;
+	for (curblock = state.base->global; curblock != NULL;
+	     curblock = curblock->next) {
+		avrule_decl_t *decl = curblock->enabled;
+		if (decl == NULL)
+			continue;
+		if (hashtab_map(decl->p_roles.table, role_bounds_copy_callback, &state))
+			goto cleanup;
+		if (hashtab_map(decl->p_roles.table, role_dominates_copy_callback, &state))
+			goto cleanup;
+		if (hashtab_map(decl->p_roles.table, role_types_copy_callback, &state))
+			goto cleanup;
+	}
+	/* Copy types in role attribute to all roles that belongs to it */
+	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
 		goto cleanup;
 
 	/* copy MLS's sensitivity level and categories - this needs to be done
@@ -3114,9 +3168,18 @@ int expand_module(sepol_handle_t * handle,
 	/* copy users */
 	if (hashtab_map(state.base->p_users.table, user_copy_callback, &state))
 		goto cleanup;
-	if (hashtab_map(state.base->p_users.table,
-			user_bounds_copy_callback, &state))
+	if (hashtab_map(state.base->p_users.table, user_bounds_copy_callback, &state))
 		goto cleanup;
+	for (curblock = state.base->global; curblock != NULL;
+	     curblock = curblock->next) {
+		avrule_decl_t *decl = curblock->enabled;
+		if (decl == NULL)
+			continue;
+		if (hashtab_map(decl->p_users.table, user_copy_callback, &state))
+			goto cleanup;
+		if (hashtab_map(decl->p_users.table, user_bounds_copy_callback, &state))
+			goto cleanup;
+	}
 
 	/* copy bools */
 	if (hashtab_map(state.base->p_bools.table, bool_copy_callback, &state))
@@ -3131,54 +3194,6 @@ int expand_module(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
-	/* loop through all decls and union attributes, roles, users */
-	for (curblock = state.base->global; curblock != NULL;
-	     curblock = curblock->next) {
-		avrule_decl_t *decl = curblock->enabled;
-
-		if (decl == NULL) {
-			/* nothing was enabled within this block */
-			continue;
-		}
-
-		/* convert attribute type sets */
-		if (hashtab_map
-		    (decl->p_types.table, attr_convert_callback, &state)) {
-			goto cleanup;
-		}
-		/* copy type bounds */
-		if (hashtab_map(decl->p_types.table,
-						type_bounds_copy_callback, &state))
-			goto cleanup;
-
-		/* copy roles */
-		if (hashtab_map
-		    (decl->p_roles.table, role_copy_callback, &state))
-			goto cleanup;
-		if (hashtab_map(state.base->p_roles.table,
-						role_bounds_copy_callback, &state))
-			goto cleanup;
-
-		/* copy users */
-		if (hashtab_map
-		    (decl->p_users.table, user_copy_callback, &state))
-			goto cleanup;
-		if (hashtab_map(decl->p_users.table,
-						user_bounds_copy_callback, &state))
-			goto cleanup;
-
-	}
-
-	/* remap role dominates bitmaps */
-	 if (hashtab_map(state.out->p_roles.table, role_remap_dominates, &state)) {
-		goto cleanup;
-	}
-
-	/* escalate the type_set_t in a role attribute to all regular roles
-	 * that belongs to it. */
-	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
-		goto cleanup;
-
 	if (copy_and_expand_avrule_block(&state) < 0) {
 		ERR(handle, "Error during expand");
 		goto cleanup;
-- 
2.50.0

