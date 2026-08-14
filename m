Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F038237B
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750346; cv=none; b=lR4i/exnbE1yHEFPwiMzyCNbFG55XEmO6ZUkKzuxzkun7ZMEu/R3DF1PUjKIIzDd6CqV9A6WX1eF+sVePLdlZMW3Rghi2K6mGSTTLQpxn7Qc5LD4xp0ZmbRbfoCig6VqhyacHcS8hNjzBsvh/nm4QmqXYzjfFdzgNJgJD1oI0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750346; c=relaxed/simple;
	bh=v2yyGwjRSahoTLx53UXYWpmA7oV9udAV4mGC9VuUa9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+FTjMBTu/JqD+1p4GbuOMR8cp+aEZzY+s/m0UEKodyZ5RCUHZbEM9dHUBBI/e62PnQR+j6Nyie43ds6gPso+HBlBUuiXEj/28tmp15g6GBW0va5tkG8056lKM3KNJc5eaezdlNcVNMoJozG0RhCrI7kB8meqBuHK31LvRKAOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=SFufzdKo; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="SFufzdKo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xJGEHQGBfP8LuHl4vq9JWA6mOBd2wUlmLANFvOfHMSo=; b=SFufzdKoZKz3lQJJ1ck1CGK7Pc
	RrJJhqauG5iu1VhxOgjm7SNcYY9kUb/dWi+KyKlFOIkr4d5Karp3/2JssqcFlI/tCYbReDIzJ6G1H
	dQXvm4xt54JvWerLWe/INuKbUKsxL5LiG9F7prSGUIlHmt/yLfZDNhVSatuIjFS2Vw2x0oUYo2Z/D
	wJC+kPnPS5iRFz2as7VkHPHL9Xa77tOkOShFsoEEWXDeOrz4UhiWC1DBDAvypfKK/YNHHmWJtTWv5
	avFAwZNcxdf0xPO/I0eOdWU2v4cdKeyD2nozbV7tzrQPyd+fOyHDpbMseA1gSbx4LvIvJUiXHnJfC
	mdarAw4A==;
Received: from [82.128.205.39] (port=29696 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wv0xD-00000003TcM-26LL;
	Sat, 15 Aug 2026 02:04:45 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libsepol: use bool instead of int in validation functions
Date: Sat, 15 Aug 2026 02:04:32 +0300
Message-ID: <20260814230432.53831-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is an effort to use boolean return values instead of
int in as many libsepol validation functions as possible.
The functions passed to hashtab_map() have been kept as is
to avoid excessive reworking of the codebase.

The change from int to bool requires adjusting the callers
to invert their return value checking logic. The caller
conversion has been performed to keep the existing logic
intact.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c |   4 +-
 libsepol/fuzz/binpolicy-fuzzer.c      |   6 +-
 libsepol/src/policydb.c               |   2 +-
 libsepol/src/policydb_validate.c      | 622 +++++++++++++-------------
 libsepol/src/policydb_validate.h      |   5 +-
 5 files changed, 320 insertions(+), 319 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 401f24e3..cad9dd7e 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -15,7 +15,7 @@
 #include "module_compiler.h"
 #include "queue.h"
 
-extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+extern bool policydb_validate(sepol_handle_t *handle, const policydb_t *p);
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 extern int mlspol;
@@ -248,7 +248,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (policydb_sort_ocontexts(finalpolicydb))
 		goto exit;
 
-	if (policydb_validate(NULL, finalpolicydb))
+	if (!policydb_validate(NULL, finalpolicydb))
 		/* never generate an invalid policy */
 		abort();
 
diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index f2379175..613ffef6 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -7,7 +7,7 @@
 #include <sepol/policydb/link.h>
 #include <sepol/policydb/policydb.h>
 
-extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+extern bool policydb_validate(sepol_handle_t *handle, const policydb_t *p);
 
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
@@ -50,7 +50,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (policydb.policy_type == POLICY_KERN) {
 		(void)policydb_optimize(&policydb);
 
-		if (policydb_validate(NULL, &policydb) == -1)
+		if (!policydb_validate(NULL, &policydb))
 			abort();
 	}
 
@@ -88,7 +88,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 					  /*check_assertions=*/0))
 				goto exit;
 
-			if (policydb_validate(NULL, &out))
+			if (!policydb_validate(NULL, &out))
 				goto exit;
 
 			(void)check_assertions(
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3dd3ac4f..55a27449 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4331,7 +4331,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
-	if (policydb_validate(fp->handle, p))
+	if (!policydb_validate(fp->handle, p))
 		goto bad;
 
 	return POLICYDB_SUCCESS;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fe8bf1cf..f9758b96 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -58,74 +58,74 @@ static int create_gap_ebitmap(char **val_to_name, uint32_t nprim,
 	return 0;
 }
 
-static int validate_init(validate_t *flavor, char **val_to_name, uint32_t nprim)
+static bool validate_init(validate_t *flavor, char **val_to_name, uint32_t nprim)
 {
 	flavor->nprim = nprim;
 	if (create_gap_ebitmap(val_to_name, nprim, &flavor->gaps))
-		return -1;
+		return false;
 
-	return 0;
+	return true;
 }
 
-static int validate_array_init(const policydb_t *p, validate_t flavors[])
+static bool validate_array_init(const policydb_t *p, validate_t flavors[])
 {
-	if (validate_init(&flavors[SYM_COMMONS], p->p_common_val_to_name,
+	if (!validate_init(&flavors[SYM_COMMONS], p->p_common_val_to_name,
 			  p->p_commons.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_CLASSES], p->p_class_val_to_name,
+	if (!validate_init(&flavors[SYM_CLASSES], p->p_class_val_to_name,
 			  p->p_classes.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name,
+	if (!validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name,
 			  p->p_roles.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
+	if (!validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
 			  p->p_types.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_USERS], p->p_user_val_to_name,
+	if (!validate_init(&flavors[SYM_USERS], p->p_user_val_to_name,
 			  p->p_users.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_BOOLS], p->p_bool_val_to_name,
+	if (!validate_init(&flavors[SYM_BOOLS], p->p_bool_val_to_name,
 			  p->p_bools.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_LEVELS], p->p_sens_val_to_name,
+	if (!validate_init(&flavors[SYM_LEVELS], p->p_sens_val_to_name,
 			  p->p_levels.nprim))
 		goto bad;
-	if (validate_init(&flavors[SYM_CATS], p->p_cat_val_to_name,
+	if (!validate_init(&flavors[SYM_CATS], p->p_cat_val_to_name,
 			  p->p_cats.nprim))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 /*
  * Functions to validate both kernel and module policydbs
  */
 
-int value_isvalid(uint32_t value, uint32_t nprim)
+bool value_isvalid(uint32_t value, uint32_t nprim)
 {
 	if (!value || value > nprim)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int validate_value(uint32_t value, const validate_t *flavor)
+static bool validate_value(uint32_t value, const validate_t *flavor)
 {
 	if (!value || value > flavor->nprim)
 		goto bad;
 	if (ebitmap_get_bit(&flavor->gaps, value - 1))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_string_field(const char *s)
+static bool validate_string_field(const char *s)
 {
 	if (!s || !*s)
 		goto bad;
@@ -136,13 +136,13 @@ static int validate_string_field(const char *s)
 		s++;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_ebitmap(const ebitmap_t *map, const validate_t *flavor)
+static bool validate_ebitmap(const ebitmap_t *map, const validate_t *flavor)
 {
 	if (ebitmap_length(map) > 0 &&
 	    ebitmap_highest_set_bit(map) >= flavor->nprim)
@@ -150,17 +150,17 @@ static int validate_ebitmap(const ebitmap_t *map, const validate_t *flavor)
 	if (ebitmap_match_any(map, &flavor->gaps))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_type_set(const type_set_t *type_set, const validate_t *type)
+static bool validate_type_set(const type_set_t *type_set, const validate_t *type)
 {
-	if (validate_ebitmap(&type_set->types, type))
+	if (!validate_ebitmap(&type_set->types, type))
 		goto bad;
-	if (validate_ebitmap(&type_set->negset, type))
+	if (!validate_ebitmap(&type_set->negset, type))
 		goto bad;
 
 	switch (type_set->flags) {
@@ -172,13 +172,13 @@ static int validate_type_set(const type_set_t *type_set, const validate_t *type)
 		goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_empty_type_set(const type_set_t *type_set)
+static bool validate_empty_type_set(const type_set_t *type_set)
 {
 	if (!ebitmap_is_empty(&type_set->types))
 		goto bad;
@@ -187,15 +187,15 @@ static int validate_empty_type_set(const type_set_t *type_set)
 	if (type_set->flags != 0)
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_role_set(const role_set_t *role_set, const validate_t *role)
+static bool validate_role_set(const role_set_t *role_set, const validate_t *role)
 {
-	if (validate_ebitmap(&role_set->roles, role))
+	if (!validate_ebitmap(&role_set->roles, role))
 		goto bad;
 
 	switch (role_set->flags) {
@@ -207,10 +207,10 @@ static int validate_role_set(const role_set_t *role_set, const validate_t *role)
 		goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 static int validate_scope(__attribute__((unused)) hashtab_key_t k,
@@ -239,7 +239,7 @@ bad:
 	return -1;
 }
 
-static int validate_scopes(sepol_handle_t *handle, const symtab_t scopes[],
+static bool validate_scopes(sepol_handle_t *handle, const symtab_t scopes[],
 			   const avrule_block_t *block)
 {
 	const avrule_decl_t *decl;
@@ -257,14 +257,14 @@ static int validate_scopes(sepol_handle_t *handle, const symtab_t scopes[],
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid scope");
-	return -1;
+	return false;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
+static bool validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				     const constraint_node_t *cons,
 				     validate_t flavors[])
 {
@@ -297,7 +297,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				    !is_validatetrans)
 					goto bad;
 				if (!(cexp->attr & CEXPR_TYPE)) {
-					if (validate_empty_type_set(
+					if (!validate_empty_type_set(
 						    cexp->type_names))
 						goto bad;
 				}
@@ -314,7 +314,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				case CEXPR_USER:
 				case CEXPR_USER | CEXPR_TARGET:
 				case CEXPR_USER | CEXPR_XTARGET:
-					if (validate_ebitmap(
+					if (!validate_ebitmap(
 						    &cexp->names,
 						    &flavors[SYM_USERS]))
 						goto bad;
@@ -322,7 +322,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				case CEXPR_ROLE:
 				case CEXPR_ROLE | CEXPR_TARGET:
 				case CEXPR_ROLE | CEXPR_XTARGET:
-					if (validate_ebitmap(
+					if (!validate_ebitmap(
 						    &cexp->names,
 						    &flavors[SYM_ROLES]))
 						goto bad;
@@ -330,11 +330,11 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 				case CEXPR_TYPE:
 				case CEXPR_TYPE | CEXPR_TARGET:
 				case CEXPR_TYPE | CEXPR_XTARGET:
-					if (validate_ebitmap(
+					if (!validate_ebitmap(
 						    &cexp->names,
 						    &flavors[SYM_TYPES]))
 						goto bad;
-					if (validate_type_set(
+					if (!validate_type_set(
 						    cexp->type_names,
 						    &flavors[SYM_TYPES]))
 						goto bad;
@@ -349,7 +349,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 
 				if (!ebitmap_is_empty(&cexp->names))
 					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
+				if (!validate_empty_type_set(cexp->type_names))
 					goto bad;
 
 				switch (cexp->op) {
@@ -403,7 +403,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 					goto bad;
 				if (!ebitmap_is_empty(&cexp->names))
 					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
+				if (!validate_empty_type_set(cexp->type_names))
 					goto bad;
 			}
 		}
@@ -412,11 +412,11 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid constraint expr");
-	return -1;
+	return false;
 }
 
 static int perm_visit(__attribute__((__unused__)) hashtab_key_t k,
@@ -439,7 +439,7 @@ static int perm_visit(__attribute__((__unused__)) hashtab_key_t k,
 	return 0;
 }
 
-static int validate_permission_symtab(sepol_handle_t *handle,
+static bool validate_permission_symtab(sepol_handle_t *handle,
 				      const symtab_t *permissions,
 				      uint32_t inherited_nprim)
 {
@@ -452,25 +452,25 @@ static int validate_permission_symtab(sepol_handle_t *handle,
 	if (hashtab_map(permissions->table, perm_visit, &pargs))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid permission table");
-	return -1;
+	return false;
 }
 
 static int validate_common_datum(sepol_handle_t *handle,
 				 const common_datum_t *common,
 				 validate_t flavors[])
 {
-	if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
+	if (!validate_value(common->s.value, &flavors[SYM_COMMONS]))
 		goto bad;
 	if (common->permissions.nprim == 0 ||
 	    common->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
 	if (common->permissions.nprim != common->permissions.table->nel)
 		goto bad;
-	if (validate_permission_symtab(handle, &common->permissions, 0))
+	if (!validate_permission_symtab(handle, &common->permissions, 0))
 		goto bad;
 
 	return 0;
@@ -494,7 +494,7 @@ static int validate_class_datum(sepol_handle_t *handle,
 				validate_t flavors[])
 {
 	if (class->s.value > UINT16_MAX ||
-	    validate_value(class->s.value, &flavors[SYM_CLASSES]))
+	    !validate_value(class->s.value, &flavors[SYM_CLASSES]))
 		goto bad;
 	if (class->comdatum &&
 	    validate_common_datum(handle, class->comdatum, flavors))
@@ -507,14 +507,14 @@ static int validate_class_datum(sepol_handle_t *handle,
 	    (class->permissions.table->nel +
 	     (class->comdatum ? class->comdatum->permissions.table->nel : 0)))
 		goto bad;
-	if (validate_permission_symtab(
+	if (!validate_permission_symtab(
 		    handle, &class->permissions,
 		    class->comdatum ? class->comdatum->permissions.nprim : 0))
 		goto bad;
-	if (validate_constraint_nodes(handle, class->permissions.nprim,
+	if (!validate_constraint_nodes(handle, class->permissions.nprim,
 				      class->constraints, flavors))
 		goto bad;
-	if (validate_constraint_nodes(handle, UINT32_MAX, class->validatetrans,
+	if (!validate_constraint_nodes(handle, UINT32_MAX, class->validatetrans,
 				      flavors))
 		goto bad;
 
@@ -577,15 +577,15 @@ static int validate_class_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 static int validate_role_datum(sepol_handle_t *handle, const role_datum_t *role,
 			       validate_t flavors[])
 {
-	if (validate_value(role->s.value, &flavors[SYM_ROLES]))
+	if (!validate_value(role->s.value, &flavors[SYM_ROLES]))
 		goto bad;
-	if (validate_ebitmap(&role->dominates, &flavors[SYM_ROLES]))
+	if (!validate_ebitmap(&role->dominates, &flavors[SYM_ROLES]))
 		goto bad;
-	if (validate_type_set(&role->types, &flavors[SYM_TYPES]))
+	if (!validate_type_set(&role->types, &flavors[SYM_TYPES]))
 		goto bad;
-	if (role->bounds && validate_value(role->bounds, &flavors[SYM_ROLES]))
+	if (role->bounds && !validate_value(role->bounds, &flavors[SYM_ROLES]))
 		goto bad;
-	if (validate_ebitmap(&role->roles, &flavors[SYM_ROLES]))
+	if (!validate_ebitmap(&role->roles, &flavors[SYM_ROLES]))
 		goto bad;
 
 	switch (role->flavor) {
@@ -611,12 +611,12 @@ static int validate_role_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_role_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_simpletype(uint32_t value, const policydb_t *p,
+static bool validate_simpletype(uint32_t value, const policydb_t *p,
 			       const validate_t flavors[SYM_NUM])
 {
 	const type_datum_t *type;
 
-	if (validate_value(value, &flavors[SYM_TYPES]))
+	if (!validate_value(value, &flavors[SYM_TYPES]))
 		goto bad;
 
 	type = p->type_val_to_struct[value - 1];
@@ -626,40 +626,40 @@ static int validate_simpletype(uint32_t value, const policydb_t *p,
 	if (type->flavor == TYPE_ATTRIB)
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_types_in_attribute(const ebitmap_t *map,
+static bool validate_types_in_attribute(const ebitmap_t *map,
 				       const policydb_t *p,
 				       const validate_t flavors[SYM_NUM])
 {
 	ebitmap_node_t *node;
 	uint32_t i;
 
-	if (validate_ebitmap(map, &flavors[SYM_TYPES]))
+	if (!validate_ebitmap(map, &flavors[SYM_TYPES]))
 		goto bad;
 
 	if (p->policy_type != POLICY_KERN &&
 	    p->policyvers < MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS) {
 		ebitmap_for_each_positive_bit(map, node, i) {
-			if (validate_simpletype(i + 1, p, flavors))
+			if (!validate_simpletype(i + 1, p, flavors))
 				goto bad;
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 			       const policydb_t *p, validate_t flavors[])
 {
-	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
+	if (!validate_value(type->s.value, &flavors[SYM_TYPES]))
 		goto bad;
 
 	switch (type->flags) {
@@ -682,7 +682,7 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 			if (!ebitmap_is_empty(&type->types))
 				goto bad;
 		} else {
-			if (validate_types_in_attribute(&type->types, p,
+			if (!validate_types_in_attribute(&type->types, p,
 							flavors))
 				goto bad;
 		}
@@ -693,7 +693,7 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 		if (!ebitmap_is_empty(&type->types))
 			goto bad;
 		if (type->bounds &&
-		    validate_simpletype(type->bounds, p, flavors))
+		    !validate_simpletype(type->bounds, p, flavors))
 			goto bad;
 		if ((type->flavor == TYPE_TYPE) && type->primary) {
 			if (type->primary > 1)
@@ -706,7 +706,7 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 				if (repeats >= MAX_ALIAS_REPEATS)
 					break;
 				v = (t->primary) ? t->primary : t->s.value;
-				if (validate_value(v, &flavors[SYM_TYPES]))
+				if (!validate_value(v, &flavors[SYM_TYPES]))
 					break;
 				t = p->type_val_to_struct[v - 1];
 				if (t == type)
@@ -738,72 +738,72 @@ static int validate_type_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 				   margs->flavors);
 }
 
-static int validate_mls_semantic_cat(const mls_semantic_cat_t *cat,
+static bool validate_mls_semantic_cat(const mls_semantic_cat_t *cat,
 				     const validate_t *cats)
 {
 	for (; cat; cat = cat->next) {
-		if (validate_value(cat->low, cats))
+		if (!validate_value(cat->low, cats))
 			goto bad;
-		if (validate_value(cat->high, cats))
+		if (!validate_value(cat->high, cats))
 			goto bad;
 		if (cat->low > cat->high)
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_mls_semantic_level(const mls_semantic_level_t *level,
+static bool validate_mls_semantic_level(const mls_semantic_level_t *level,
 				       const validate_t *sens,
 				       const validate_t *cats, int allow_unset)
 {
 	if (allow_unset && level->sens == 0)
-		return 0;
-	if (validate_value(level->sens, sens))
+		return true;
+	if (!validate_value(level->sens, sens))
 		goto bad;
-	if (validate_mls_semantic_cat(level->cat, cats))
+	if (!validate_mls_semantic_cat(level->cat, cats))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_mls_semantic_range(const mls_semantic_range_t *range,
+static bool validate_mls_semantic_range(const mls_semantic_range_t *range,
 				       const validate_t *sens,
 				       const validate_t *cats, int allow_unset)
 {
-	if (validate_mls_semantic_level(&range->level[0], sens, cats,
+	if (!validate_mls_semantic_level(&range->level[0], sens, cats,
 					allow_unset))
 		goto bad;
-	if (validate_mls_semantic_level(&range->level[1], sens, cats,
+	if (!validate_mls_semantic_level(&range->level[1], sens, cats,
 					allow_unset))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_mls_level(const mls_level_t *level, const validate_t *sens,
+static bool validate_mls_level(const mls_level_t *level, const validate_t *sens,
 			      const validate_t *cats, int allow_unset)
 {
 	if (allow_unset && level->sens == 0)
-		return 0;
-	if (validate_value(level->sens, sens))
+		return true;
+	if (!validate_value(level->sens, sens))
 		goto bad;
-	if (validate_ebitmap(&level->cat, cats))
+	if (!validate_ebitmap(&level->cat, cats))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 static int validate_level_datum(sepol_handle_t *handle,
@@ -816,7 +816,7 @@ static int validate_level_datum(sepol_handle_t *handle,
 	if (level->level->sens == 0)
 		goto bad;
 
-	if (validate_mls_level(level->level, &flavors[SYM_LEVELS],
+	if (!validate_mls_level(level->level, &flavors[SYM_LEVELS],
 			       &flavors[SYM_CATS], 0))
 		goto bad;
 
@@ -848,48 +848,48 @@ static int validate_level_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 				    margs->policy);
 }
 
-static int validate_mls_range(const mls_range_t *range, const validate_t *sens,
+static bool validate_mls_range(const mls_range_t *range, const validate_t *sens,
 			      const validate_t *cats, int allow_unset)
 {
-	if (validate_mls_level(&range->level[0], sens, cats, allow_unset))
+	if (!validate_mls_level(&range->level[0], sens, cats, allow_unset))
 		goto bad;
-	if (validate_mls_level(&range->level[1], sens, cats, allow_unset))
+	if (!validate_mls_level(&range->level[1], sens, cats, allow_unset))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
 			       validate_t flavors[], const policydb_t *p)
 {
-	if (validate_value(user->s.value, &flavors[SYM_USERS]))
+	if (!validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
-	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
+	if (!validate_role_set(&user->roles, &flavors[SYM_ROLES]))
 		goto bad;
 	if (p->mls) {
 		int allow_unset = (p->policy_type != POLICY_MOD);
-		if (validate_mls_semantic_range(
+		if (!validate_mls_semantic_range(
 			    &user->range, &flavors[SYM_LEVELS],
 			    &flavors[SYM_CATS], allow_unset))
 			goto bad;
-		if (validate_mls_semantic_level(
+		if (!validate_mls_semantic_level(
 			    &user->dfltlevel, &flavors[SYM_LEVELS],
 			    &flavors[SYM_CATS], allow_unset))
 			goto bad;
 
 		allow_unset = (p->policy_type != POLICY_KERN);
-		if (validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS],
+		if (!validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS],
 				       &flavors[SYM_CATS], allow_unset))
 			goto bad;
-		if (validate_mls_level(&user->exp_dfltlevel,
+		if (!validate_mls_level(&user->exp_dfltlevel,
 				       &flavors[SYM_LEVELS], &flavors[SYM_CATS],
 				       allow_unset))
 			goto bad;
 	}
-	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
+	if (user->bounds && !validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
 	return 0;
@@ -912,7 +912,7 @@ static int validate_bool_datum(sepol_handle_t *handle,
 			       const cond_bool_datum_t *boolean,
 			       validate_t flavors[])
 {
-	if (validate_value(boolean->s.value, &flavors[SYM_BOOLS]))
+	if (!validate_value(boolean->s.value, &flavors[SYM_BOOLS]))
 		goto bad;
 
 	switch (boolean->state) {
@@ -946,7 +946,7 @@ static int validate_bool_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_bool_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_datum_array_gaps(sepol_handle_t *handle,
+static bool validate_datum_array_gaps(sepol_handle_t *handle,
 				     const policydb_t *p, validate_t flavors[])
 {
 	uint32_t i;
@@ -981,11 +981,11 @@ static int validate_datum_array_gaps(sepol_handle_t *handle,
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid datum array gaps");
-	return -1;
+	return false;
 }
 
 static int validate_datum(__attribute__((unused)) hashtab_key_t k,
@@ -997,7 +997,7 @@ static int validate_datum(__attribute__((unused)) hashtab_key_t k,
 	return !value_isvalid(s->value, *nprim);
 }
 
-static int validate_datum_array_entries(sepol_handle_t *handle,
+static bool validate_datum_array_entries(sepol_handle_t *handle,
 					const policydb_t *p,
 					const symtab_t *symtabs,
 					validate_t flavors[])
@@ -1036,33 +1036,33 @@ static int validate_datum_array_entries(sepol_handle_t *handle,
 			&margs))
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid datum array entries");
-	return -1;
+	return false;
 }
 
 /*
  * Functions to validate a kernel policydb
  */
 
-static int validate_avtab_key(const avtab_key_t *key, int conditional,
+static bool validate_avtab_key(const avtab_key_t *key, int conditional,
 			      const policydb_t *p, validate_t flavors[])
 {
 	if (p->policy_type == POLICY_KERN && key->specified & AVTAB_TYPE) {
-		if (validate_simpletype(key->source_type, p, flavors))
+		if (!validate_simpletype(key->source_type, p, flavors))
 			goto bad;
-		if (validate_simpletype(key->target_type, p, flavors))
+		if (!validate_simpletype(key->target_type, p, flavors))
 			goto bad;
 	} else {
-		if (validate_value(key->source_type, &flavors[SYM_TYPES]))
+		if (!validate_value(key->source_type, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_value(key->target_type, &flavors[SYM_TYPES]))
+		if (!validate_value(key->target_type, &flavors[SYM_TYPES]))
 			goto bad;
 	}
 
-	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
+	if (!validate_value(key->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1084,13 +1084,13 @@ static int validate_avtab_key(const avtab_key_t *key, int conditional,
 		goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
-static int validate_xperms(const avtab_extended_perms_t *xperms)
+static bool validate_xperms(const avtab_extended_perms_t *xperms)
 {
 	switch (xperms->specified) {
 	case AVTAB_XPERMS_IOCTLDRIVER:
@@ -1101,10 +1101,10 @@ static int validate_xperms(const avtab_extended_perms_t *xperms)
 		goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
-	return -1;
+	return false;
 }
 
 static int validate_access_vector(sepol_handle_t *handle, const policydb_t *p,
@@ -1128,7 +1128,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d,
 {
 	map_arg_t *margs = args;
 
-	if (validate_avtab_key(k, margs->conditional, margs->policy,
+	if (!validate_avtab_key(k, margs->conditional, margs->policy,
 			       margs->flavors))
 		return -1;
 
@@ -1144,7 +1144,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d,
 	}
 
 	if ((k->specified & AVTAB_TYPE) &&
-	    validate_simpletype(d->data, margs->policy, margs->flavors))
+	    !validate_simpletype(d->data, margs->policy, margs->flavors))
 		return -1;
 
 	if (k->specified & AVTAB_XPERMS) {
@@ -1156,27 +1156,27 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d,
 					   k->target_class, data))
 			return -1;
 
-		if (validate_xperms(d->xperms))
+		if (!validate_xperms(d->xperms))
 			return -1;
 	}
 
 	return 0;
 }
 
-static int validate_avtab(sepol_handle_t *handle, const avtab_t *avtab,
+static bool validate_avtab(sepol_handle_t *handle, const avtab_t *avtab,
 			  const policydb_t *p, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p, 0 };
 
 	if (avtab_map(avtab, validate_avtab_key_and_datum, &margs)) {
 		ERR(handle, "Invalid avtab");
-		return -1;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
-static int validate_cond_av_list(sepol_handle_t *handle,
+static bool validate_cond_av_list(sepol_handle_t *handle,
 				 const cond_av_list_t *cond_av,
 				 const policydb_t *p, validate_t flavors[])
 {
@@ -1190,23 +1190,23 @@ static int validate_cond_av_list(sepol_handle_t *handle,
 				    &avtab_ptr->key, &avtab_ptr->datum, &margs))
 				goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid cond av list");
-	return -1;
+	return false;
 }
 
-static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
+static bool validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 			    int conditional, const policydb_t *p,
 			    validate_t flavors[])
 {
 	const class_perm_node_t *classperm;
 
 	for (; avrule; avrule = avrule->next) {
-		if (validate_type_set(&avrule->stypes, &flavors[SYM_TYPES]))
+		if (!validate_type_set(&avrule->stypes, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_type_set(&avrule->ttypes, &flavors[SYM_TYPES]))
+		if (!validate_type_set(&avrule->ttypes, &flavors[SYM_TYPES]))
 			goto bad;
 
 		switch (avrule->specified) {
@@ -1233,7 +1233,7 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 		for (classperm = avrule->perms; classperm;
 		     classperm = classperm->next) {
 			class_datum_t *cladatum;
-			if (validate_value(classperm->tclass,
+			if (!validate_value(classperm->tclass,
 					   &flavors[SYM_CLASSES]))
 				goto bad;
 			cladatum =
@@ -1245,7 +1245,7 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 					goto bad;
 				}
 			} else if (avrule->specified & AVRULE_TYPE) {
-				if (validate_simpletype(classperm->data, p,
+				if (!validate_simpletype(classperm->data, p,
 							flavors)) {
 					goto bad;
 				}
@@ -1292,14 +1292,14 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid avrule");
-	return -1;
+	return false;
 }
 
-static int validate_bool_id_array(sepol_handle_t *handle,
+static bool validate_bool_id_array(sepol_handle_t *handle,
 				  const uint32_t bool_ids[],
 				  unsigned int nbools,
 				  const validate_t *boolean)
@@ -1310,18 +1310,18 @@ static int validate_bool_id_array(sepol_handle_t *handle,
 		goto bad;
 
 	for (i = 0; i < nbools; i++) {
-		if (validate_value(bool_ids[i], boolean))
+		if (!validate_value(bool_ids[i], boolean))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid bool id array");
-	return -1;
+	return false;
 }
 
-static int validate_cond_expr(sepol_handle_t *handle,
+static bool validate_cond_expr(sepol_handle_t *handle,
 			      const struct cond_expr *expr,
 			      const validate_t *boolean)
 {
@@ -1333,7 +1333,7 @@ static int validate_cond_expr(sepol_handle_t *handle,
 	for (; expr; expr = expr->next) {
 		switch (expr->expr_type) {
 		case COND_BOOL:
-			if (validate_value(expr->boolean, boolean))
+			if (!validate_value(expr->boolean, boolean))
 				goto bad;
 			if (depth >= (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
@@ -1364,28 +1364,28 @@ static int validate_cond_expr(sepol_handle_t *handle,
 	if (depth != 0)
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid cond expression");
-	return -1;
+	return false;
 }
 
-static int validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond,
+static bool validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond,
 			      const policydb_t *p, validate_t flavors[])
 {
 	for (; cond; cond = cond->next) {
-		if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
+		if (!validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
 			goto bad;
-		if (validate_cond_av_list(handle, cond->true_list, p, flavors))
+		if (!validate_cond_av_list(handle, cond->true_list, p, flavors))
 			goto bad;
-		if (validate_cond_av_list(handle, cond->false_list, p, flavors))
+		if (!validate_cond_av_list(handle, cond->false_list, p, flavors))
 			goto bad;
-		if (validate_avrules(handle, cond->avtrue_list, 1, p, flavors))
+		if (!validate_avrules(handle, cond->avtrue_list, 1, p, flavors))
 			goto bad;
-		if (validate_avrules(handle, cond->avfalse_list, 1, p, flavors))
+		if (!validate_avrules(handle, cond->avfalse_list, 1, p, flavors))
 			goto bad;
-		if (validate_bool_id_array(handle, cond->bool_ids, cond->nbools,
+		if (!validate_bool_id_array(handle, cond->bool_ids, cond->nbools,
 					   &flavors[SYM_BOOLS]))
 			goto bad;
 
@@ -1406,51 +1406,51 @@ static int validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond,
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid cond list");
-	return -1;
+	return false;
 }
 
-static int validate_role_transes(sepol_handle_t *handle,
+static bool validate_role_transes(sepol_handle_t *handle,
 				 const role_trans_t *role_trans,
 				 validate_t flavors[])
 {
 	for (; role_trans; role_trans = role_trans->next) {
-		if (validate_value(role_trans->role, &flavors[SYM_ROLES]))
+		if (!validate_value(role_trans->role, &flavors[SYM_ROLES]))
 			goto bad;
-		if (validate_value(role_trans->type, &flavors[SYM_TYPES]))
+		if (!validate_value(role_trans->type, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_value(role_trans->tclass, &flavors[SYM_CLASSES]))
+		if (!validate_value(role_trans->tclass, &flavors[SYM_CLASSES]))
 			goto bad;
-		if (validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
+		if (!validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid role trans");
-	return -1;
+	return false;
 }
 
-static int validate_role_allows(sepol_handle_t *handle,
+static bool validate_role_allows(sepol_handle_t *handle,
 				const role_allow_t *role_allow,
 				validate_t flavors[])
 {
 	for (; role_allow; role_allow = role_allow->next) {
-		if (validate_value(role_allow->role, &flavors[SYM_ROLES]))
+		if (!validate_value(role_allow->role, &flavors[SYM_ROLES]))
 			goto bad;
-		if (validate_value(role_allow->new_role, &flavors[SYM_ROLES]))
+		if (!validate_value(role_allow->new_role, &flavors[SYM_ROLES]))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid role allow");
-	return -1;
+	return false;
 }
 
 static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d,
@@ -1462,18 +1462,18 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d,
 	const validate_t *flavors = margs->flavors;
 	const policydb_t *p = margs->policy;
 
-	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
+	if (!validate_value(ftk->ttype, &flavors[SYM_TYPES]))
 		goto bad;
-	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
+	if (!validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
 		goto bad;
-	if (validate_string_field(ftk->name))
+	if (!validate_string_field(ftk->name))
 		goto bad;
 	if (!ftd)
 		goto bad;
 	for (; ftd; ftd = ftd->next) {
-		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
+		if (!validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_simpletype(ftd->otype, p, flavors))
+		if (!validate_simpletype(ftd->otype, p, flavors))
 			goto bad;
 	}
 
@@ -1483,7 +1483,7 @@ bad:
 	return -1;
 }
 
-static int validate_filename_trans_hashtab(sepol_handle_t *handle,
+static bool validate_filename_trans_hashtab(sepol_handle_t *handle,
 					   const policydb_t *p,
 					   validate_t flavors[])
 {
@@ -1491,29 +1491,29 @@ static int validate_filename_trans_hashtab(sepol_handle_t *handle,
 
 	if (hashtab_map(p->filename_trans, validate_filename_trans, &margs)) {
 		ERR(handle, "Invalid filename trans");
-		return -1;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
-static int validate_context(const context_struct_t *con, validate_t flavors[],
+static bool validate_context(const context_struct_t *con, validate_t flavors[],
 			    int mls)
 {
-	if (validate_value(con->user, &flavors[SYM_USERS]))
-		return -1;
-	if (validate_value(con->role, &flavors[SYM_ROLES]))
-		return -1;
-	if (validate_value(con->type, &flavors[SYM_TYPES]))
-		return -1;
-	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS],
+	if (!validate_value(con->user, &flavors[SYM_USERS]))
+		return false;
+	if (!validate_value(con->role, &flavors[SYM_ROLES]))
+		return false;
+	if (!validate_value(con->type, &flavors[SYM_TYPES]))
+		return false;
+	if (mls && !validate_mls_range(&con->range, &flavors[SYM_LEVELS],
 				      &flavors[SYM_CATS], 0))
-		return -1;
+		return false;
 
-	return 0;
+	return true;
 }
 
-static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 			      validate_t flavors[])
 {
 	const ocontext_t *octx;
@@ -1521,7 +1521,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 
 	for (i = 0; i < OCON_NUM; i++) {
 		for (octx = p->ocontexts[i]; octx; octx = octx->next) {
-			if (validate_context(&octx->context[0], flavors,
+			if (!validate_context(&octx->context[0], flavors,
 					     p->mls))
 				goto bad;
 
@@ -1534,10 +1534,10 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					break;
 				case OCON_FS:
 				case OCON_NETIF:
-					if (validate_context(&octx->context[1],
+					if (!validate_context(&octx->context[1],
 							     flavors, p->mls))
 						goto bad;
-					if (validate_string_field(octx->u.name))
+					if (!validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				case OCON_PORT:
@@ -1554,7 +1554,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					default:
 						goto bad;
 					}
-					if (validate_string_field(octx->u.name))
+					if (!validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				case OCON_IBPKEY:
@@ -1565,7 +1565,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 				case OCON_IBENDPORT:
 					if (octx->u.ibendport.port == 0)
 						goto bad;
-					if (validate_string_field(
+					if (!validate_string_field(
 						    octx->u.ibendport.dev_name))
 						goto bad;
 					break;
@@ -1593,7 +1593,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 						goto bad;
 					break;
 				case OCON_XEN_DEVICETREE:
-					if (validate_string_field(octx->u.name))
+					if (!validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				}
@@ -1601,14 +1601,14 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid ocontext");
-	return -1;
+	return false;
 }
 
-static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 			  validate_t flavors[])
 {
 	const genfs_t *genfs;
@@ -1616,121 +1616,121 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 
 	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		for (octx = genfs->head; octx; octx = octx->next) {
-			if (validate_context(&octx->context[0], flavors,
+			if (!validate_context(&octx->context[0], flavors,
 					     p->mls))
 				goto bad;
 			if (octx->v.sclass &&
-			    validate_value(octx->v.sclass,
+			    !validate_value(octx->v.sclass,
 					   &flavors[SYM_CLASSES]))
 				goto bad;
-			if (validate_string_field(octx->u.name))
+			if (!validate_string_field(octx->u.name))
 				goto bad;
 		}
 
-		if (validate_string_field(genfs->fstype))
+		if (!validate_string_field(genfs->fstype))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid genfs");
-	return -1;
+	return false;
 }
 
 /*
  * Functions to validate a module policydb
  */
 
-static int validate_role_trans_rules(sepol_handle_t *handle,
+static bool validate_role_trans_rules(sepol_handle_t *handle,
 				     const role_trans_rule_t *role_trans,
 				     validate_t flavors[])
 {
 	for (; role_trans; role_trans = role_trans->next) {
-		if (validate_role_set(&role_trans->roles, &flavors[SYM_ROLES]))
+		if (!validate_role_set(&role_trans->roles, &flavors[SYM_ROLES]))
 			goto bad;
-		if (validate_type_set(&role_trans->types, &flavors[SYM_TYPES]))
+		if (!validate_type_set(&role_trans->types, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_ebitmap(&role_trans->classes,
+		if (!validate_ebitmap(&role_trans->classes,
 				     &flavors[SYM_CLASSES]))
 			goto bad;
-		if (validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
+		if (!validate_value(role_trans->new_role, &flavors[SYM_ROLES]))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid role trans rule");
-	return -1;
+	return false;
 }
 
-static int validate_role_allow_rules(sepol_handle_t *handle,
+static bool validate_role_allow_rules(sepol_handle_t *handle,
 				     const role_allow_rule_t *role_allow,
 				     validate_t flavors[])
 {
 	for (; role_allow; role_allow = role_allow->next) {
-		if (validate_role_set(&role_allow->roles, &flavors[SYM_ROLES]))
+		if (!validate_role_set(&role_allow->roles, &flavors[SYM_ROLES]))
 			goto bad;
-		if (validate_role_set(&role_allow->new_roles,
+		if (!validate_role_set(&role_allow->new_roles,
 				      &flavors[SYM_ROLES]))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid role allow rule");
-	return -1;
+	return false;
 }
 
-static int validate_range_trans_rules(sepol_handle_t *handle,
+static bool validate_range_trans_rules(sepol_handle_t *handle,
 				      const range_trans_rule_t *range_trans,
 				      validate_t flavors[])
 {
 	for (; range_trans; range_trans = range_trans->next) {
-		if (validate_type_set(&range_trans->stypes,
+		if (!validate_type_set(&range_trans->stypes,
 				      &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_type_set(&range_trans->ttypes,
+		if (!validate_type_set(&range_trans->ttypes,
 				      &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_ebitmap(&range_trans->tclasses,
+		if (!validate_ebitmap(&range_trans->tclasses,
 				     &flavors[SYM_CLASSES]))
 			goto bad;
-		if (validate_mls_semantic_range(&range_trans->trange,
+		if (!validate_mls_semantic_range(&range_trans->trange,
 						&flavors[SYM_LEVELS],
 						&flavors[SYM_CATS], 0))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid range trans rule");
-	return -1;
+	return false;
 }
 
-static int validate_scope_index(sepol_handle_t *handle,
+static bool validate_scope_index(sepol_handle_t *handle,
 				const scope_index_t *scope_index,
 				const policydb_t *p, validate_t flavors[])
 {
 	if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_classes_scope,
+	if (!validate_ebitmap(&scope_index->p_classes_scope,
 			     &flavors[SYM_CLASSES]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_ROLES]))
+	if (!validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_ROLES]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_types_scope, &flavors[SYM_TYPES]))
+	if (!validate_ebitmap(&scope_index->p_types_scope, &flavors[SYM_TYPES]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_users_scope, &flavors[SYM_USERS]))
+	if (!validate_ebitmap(&scope_index->p_users_scope, &flavors[SYM_USERS]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_bools_scope, &flavors[SYM_BOOLS]))
+	if (!validate_ebitmap(&scope_index->p_bools_scope, &flavors[SYM_BOOLS]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_sens_scope, &flavors[SYM_LEVELS]))
+	if (!validate_ebitmap(&scope_index->p_sens_scope, &flavors[SYM_LEVELS]))
 		goto bad;
-	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
+	if (!validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
 		goto bad;
 
 	if (scope_index->class_perms_map != NULL) {
@@ -1745,7 +1745,7 @@ static int validate_scope_index(sepol_handle_t *handle,
 			class_datum_t *class;
 			ebitmap_node_t *node;
 			unsigned int bit = 0;
-			if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+			if (!validate_value(i + 1, &flavors[SYM_CLASSES]))
 				goto bad;
 			map = &scope_index->class_perms_map[i];
 			class = p->class_val_to_struct[i];
@@ -1770,31 +1770,31 @@ static int validate_scope_index(sepol_handle_t *handle,
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid scope");
-	return -1;
+	return false;
 }
 
-static int
+static bool
 validate_filename_trans_rules(sepol_handle_t *handle,
 			      const filename_trans_rule_t *filename_trans,
 			      const policydb_t *p, validate_t flavors[])
 {
 	for (; filename_trans; filename_trans = filename_trans->next) {
-		if (validate_type_set(&filename_trans->stypes,
+		if (!validate_type_set(&filename_trans->stypes,
 				      &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_type_set(&filename_trans->ttypes,
+		if (!validate_type_set(&filename_trans->ttypes,
 				      &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_value(filename_trans->tclass,
+		if (!validate_value(filename_trans->tclass,
 				   &flavors[SYM_CLASSES]))
 			goto bad;
-		if (validate_simpletype(filename_trans->otype, p, flavors))
+		if (!validate_simpletype(filename_trans->otype, p, flavors))
 			goto bad;
-		if (validate_string_field(filename_trans->name))
+		if (!validate_string_field(filename_trans->name))
 			goto bad;
 
 		/* currently only the RULE_SELF flag can be set */
@@ -1811,14 +1811,14 @@ validate_filename_trans_rules(sepol_handle_t *handle,
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid filename trans rule list");
-	return -1;
+	return false;
 }
 
-static int validate_avrule_blocks(sepol_handle_t *handle,
+static bool validate_avrule_blocks(sepol_handle_t *handle,
 				  const avrule_block_t *avrule_block,
 				  const policydb_t *p, validate_t flavors[])
 {
@@ -1827,32 +1827,32 @@ static int validate_avrule_blocks(sepol_handle_t *handle,
 	for (; avrule_block; avrule_block = avrule_block->next) {
 		for (decl = avrule_block->branch_list; decl != NULL;
 		     decl = decl->next) {
-			if (validate_cond_list(handle, decl->cond_list, p,
+			if (!validate_cond_list(handle, decl->cond_list, p,
 					       flavors))
 				goto bad;
-			if (validate_avrules(handle, decl->avrules, 0, p,
+			if (!validate_avrules(handle, decl->avrules, 0, p,
 					     flavors))
 				goto bad;
-			if (validate_role_trans_rules(
+			if (!validate_role_trans_rules(
 				    handle, decl->role_tr_rules, flavors))
 				goto bad;
-			if (validate_role_allow_rules(
+			if (!validate_role_allow_rules(
 				    handle, decl->role_allow_rules, flavors))
 				goto bad;
-			if (validate_range_trans_rules(
+			if (!validate_range_trans_rules(
 				    handle, decl->range_tr_rules, flavors))
 				goto bad;
-			if (validate_scope_index(handle, &decl->required, p,
+			if (!validate_scope_index(handle, &decl->required, p,
 						 flavors))
 				goto bad;
-			if (validate_scope_index(handle, &decl->declared, p,
+			if (!validate_scope_index(handle, &decl->declared, p,
 						 flavors))
 				goto bad;
-			if (validate_filename_trans_rules(
+			if (!validate_filename_trans_rules(
 				    handle, decl->filename_trans_rules, p,
 				    flavors))
 				goto bad;
-			if (validate_datum_array_entries(handle, p,
+			if (!validate_datum_array_entries(handle, p,
 							 decl->symtab, flavors))
 				goto bad;
 		}
@@ -1866,47 +1866,47 @@ static int validate_avrule_blocks(sepol_handle_t *handle,
 		}
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid avrule block");
-	return -1;
+	return false;
 }
 
-static int validate_permissives(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_permissives(sepol_handle_t *handle, const policydb_t *p,
 				validate_t flavors[])
 {
 	ebitmap_node_t *node;
 	uint32_t i;
 
 	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
-		if (validate_simpletype(i, p, flavors))
+		if (!validate_simpletype(i, p, flavors))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid permissive type");
-	return -1;
+	return false;
 }
 
-static int validate_neveraudit(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_neveraudit(sepol_handle_t *handle, const policydb_t *p,
 			       validate_t flavors[])
 {
 	ebitmap_node_t *node;
 	uint32_t i;
 
 	ebitmap_for_each_positive_bit(&p->neveraudit_map, node, i) {
-		if (validate_simpletype(i, p, flavors))
+		if (!validate_simpletype(i, p, flavors))
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid neveraudit type");
-	return -1;
+	return false;
 }
 
 static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data,
@@ -1917,13 +1917,13 @@ static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data,
 	const map_arg_t *margs = args;
 	const validate_t *flavors = margs->flavors;
 
-	if (validate_value(rt->source_type, &flavors[SYM_TYPES]))
+	if (!validate_value(rt->source_type, &flavors[SYM_TYPES]))
 		goto bad;
-	if (validate_value(rt->target_type, &flavors[SYM_TYPES]))
+	if (!validate_value(rt->target_type, &flavors[SYM_TYPES]))
 		goto bad;
-	if (validate_value(rt->target_class, &flavors[SYM_CLASSES]))
+	if (!validate_value(rt->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
-	if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
+	if (!validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
 		goto bad;
 
 	return 0;
@@ -1932,20 +1932,20 @@ bad:
 	return -1;
 }
 
-static int validate_range_transitions(sepol_handle_t *handle,
+static bool validate_range_transitions(sepol_handle_t *handle,
 				      const policydb_t *p, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p, 0 };
 
 	if (hashtab_map(p->range_tr, validate_range_transition, &margs)) {
 		ERR(handle, "Invalid range transition");
-		return -1;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
-static int validate_typeattr_map(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_typeattr_map(sepol_handle_t *handle, const policydb_t *p,
 				 validate_t flavors[])
 {
 	const ebitmap_t *maps = p->type_attr_map;
@@ -1953,20 +1953,20 @@ static int validate_typeattr_map(sepol_handle_t *handle, const policydb_t *p,
 
 	if (p->policy_type == POLICY_KERN) {
 		for (i = 0; i < p->p_types.nprim; i++) {
-			if (validate_ebitmap(&maps[i], &flavors[SYM_TYPES]))
+			if (!validate_ebitmap(&maps[i], &flavors[SYM_TYPES]))
 				goto bad;
 		}
 	} else if (maps)
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid type attr map");
-	return -1;
+	return false;
 }
 
-static int validate_attrtype_map(sepol_handle_t *handle, const policydb_t *p,
+static bool validate_attrtype_map(sepol_handle_t *handle, const policydb_t *p,
 				 validate_t flavors[])
 {
 	const ebitmap_t *maps = p->attr_type_map;
@@ -1974,20 +1974,20 @@ static int validate_attrtype_map(sepol_handle_t *handle, const policydb_t *p,
 
 	if (p->policy_type == POLICY_KERN) {
 		for (i = 0; i < p->p_types.nprim; i++) {
-			if (validate_ebitmap(&maps[i], &flavors[SYM_TYPES]))
+			if (!validate_ebitmap(&maps[i], &flavors[SYM_TYPES]))
 				goto bad;
 		}
 	} else if (maps)
 		goto bad;
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid attr type map");
-	return -1;
+	return false;
 }
 
-static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
+static bool validate_properties(sepol_handle_t *handle, const policydb_t *p)
 {
 	switch (p->policy_type) {
 	case POLICY_KERN:
@@ -2030,14 +2030,14 @@ static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 		goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid policy property");
-	return -1;
+	return false;
 }
 
-static int validate_policycaps(sepol_handle_t *handle, const policydb_t *p)
+static bool validate_policycaps(sepol_handle_t *handle, const policydb_t *p)
 {
 	ebitmap_node_t *node;
 	uint32_t i;
@@ -2047,11 +2047,11 @@ static int validate_policycaps(sepol_handle_t *handle, const policydb_t *p)
 			goto bad;
 	}
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid policy capability");
-	return -1;
+	return false;
 }
 
 static void validate_array_destroy(validate_t flavors[])
@@ -2066,74 +2066,74 @@ static void validate_array_destroy(validate_t flavors[])
 /*
  * Validate policydb
  */
-int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
+bool policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 {
 	validate_t flavors[SYM_NUM] = {};
 
-	if (validate_array_init(p, flavors))
+	if (!validate_array_init(p, flavors))
 		goto bad;
 
-	if (validate_properties(handle, p))
+	if (!validate_properties(handle, p))
 		goto bad;
 
-	if (validate_policycaps(handle, p))
+	if (!validate_policycaps(handle, p))
 		goto bad;
 
 	if (p->policy_type == POLICY_KERN) {
-		if (validate_avtab(handle, &p->te_avtab, p, flavors))
+		if (!validate_avtab(handle, &p->te_avtab, p, flavors))
 			goto bad;
-		if (validate_cond_list(handle, p->cond_list, p, flavors))
+		if (!validate_cond_list(handle, p->cond_list, p, flavors))
 			goto bad;
-		if (validate_role_transes(handle, p->role_tr, flavors))
+		if (!validate_role_transes(handle, p->role_tr, flavors))
 			goto bad;
-		if (validate_role_allows(handle, p->role_allow, flavors))
+		if (!validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
-			if (validate_filename_trans_hashtab(handle, p, flavors))
+			if (!validate_filename_trans_hashtab(handle, p, flavors))
 				goto bad;
 	} else {
 		if ((p->policy_type == POLICY_MOD) && (p->p_commons.nprim > 0))
 			goto bad;
-		if (validate_avrule_blocks(handle, p->global, p, flavors))
+		if (!validate_avrule_blocks(handle, p->global, p, flavors))
 			goto bad;
 	}
 
-	if (validate_ocontexts(handle, p, flavors))
+	if (!validate_ocontexts(handle, p, flavors))
 		goto bad;
 
-	if (validate_genfs(handle, p, flavors))
+	if (!validate_genfs(handle, p, flavors))
 		goto bad;
 
-	if (validate_scopes(handle, p->scope, p->global))
+	if (!validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-	if (validate_datum_array_gaps(handle, p, flavors))
+	if (!validate_datum_array_gaps(handle, p, flavors))
 		goto bad;
 
-	if (validate_datum_array_entries(handle, p, p->symtab, flavors))
+	if (!validate_datum_array_entries(handle, p, p->symtab, flavors))
 		goto bad;
 
-	if (validate_permissives(handle, p, flavors))
+	if (!validate_permissives(handle, p, flavors))
 		goto bad;
 
-	if (validate_neveraudit(handle, p, flavors))
+	if (!validate_neveraudit(handle, p, flavors))
 		goto bad;
 
-	if (validate_range_transitions(handle, p, flavors))
+	if (!validate_range_transitions(handle, p, flavors))
 		goto bad;
 
-	if (validate_typeattr_map(handle, p, flavors))
+	if (!validate_typeattr_map(handle, p, flavors))
 		goto bad;
 
-	if (validate_attrtype_map(handle, p, flavors))
+	if (!validate_attrtype_map(handle, p, flavors))
 		goto bad;
 
 	validate_array_destroy(flavors);
 
-	return 0;
+	return true;
 
 bad:
 	ERR(handle, "Invalid policydb");
 	validate_array_destroy(flavors);
-	return -1;
+	return false;
 }
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
index 86a53168..657e3cf8 100644
--- a/libsepol/src/policydb_validate.h
+++ b/libsepol/src/policydb_validate.h
@@ -1,7 +1,8 @@
 #include <stdint.h>
+#include <stdbool.h>
 
 #include <sepol/handle.h>
 #include <sepol/policydb/policydb.h>
 
-int value_isvalid(uint32_t value, uint32_t nprim);
-int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+bool value_isvalid(uint32_t value, uint32_t nprim);
+bool policydb_validate(sepol_handle_t *handle, const policydb_t *p);
-- 
2.55.0

