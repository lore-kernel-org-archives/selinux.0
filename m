Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62895296BCB
	for <selinux@vger.kernel.org>; Wed,  1 Apr 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020618; cv=none; b=adH+wOIJhBhksPnonrWjChHCVRMI0GK5isc8ZjgZ/5XDlTd1xNWg3FIRo5xhUv3iGzpFUAqjIxvp1sKtB+sa7IBWuA15B/ks1nBQRKRoNKtdEOAdD0caUFzRozgjEjjXByrl46hpWnvK0AAdMxzZ0rfTHlhHPPRLJq9MQIpJKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020618; c=relaxed/simple;
	bh=goDzKJH7Ze0RHhp50Vhgzk9KIPH561u9nZljJXHtUow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s3reB9e/L2F76GNVMrUNApAEU87Lh3opG6b5iCZzhil6i3nEkvtGoFUOETaNjZ/3EdDUCEfRLEBLzNg36RyD59FY3J6LlmWSdXRZEU//V/xoYOr3xngeIo70CYx9X8EE/cLoeFKFtvnumehF746E7ix6lwLr8OxGFyC4nkMbtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMLgl5xr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMLgl5xr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso20274681a91.1
        for <selinux@vger.kernel.org>; Tue, 31 Mar 2026 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775020616; x=1775625416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMKoI3zSc54IzBeMW6rQEMnM3lklsaaNAxqth4MWb6Q=;
        b=JMLgl5xrWBBk+n/Bv72/ZLoGUYrwZ8JnJs9DM28fRx1Ew6JiPiNeVFIHOAtsi5uNhz
         ahWNRUvLmCaFOSGK3zKMLJZKH9ATTHyCOjjReEH2YXp+74jt7Dtlhm3VgFrU7Rv42oBX
         1QGDLzLq2Ma+ktF1HWKHrJbm9WhmVV+eqNrdMjdAosOrQqxVw6nyETnSE8ByyJ1l9ew3
         Sb8Damp9Y/frbRe4K44qTDKv5jlVAX/hl11LzoRGARFRaxauvtGV/epZby7hEn4Alx1a
         LoaD15XCod+53YpCdOO+1Tsr1fUKsOMHOeImvVwBrUfA/BoVjcgN6oVKY4IbgrXLrqvp
         LvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020616; x=1775625416;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMKoI3zSc54IzBeMW6rQEMnM3lklsaaNAxqth4MWb6Q=;
        b=MkJRjVtUY2hkA17zGvHsNJaYIBzjKwhQW56rEjl6SH8ODx/zUsLuLwHOOp2bxJXTIb
         Ein43UTMIFkdj3lLVwdJ5TRGpqHzqiN0zscJXNWQumCbbX9Z6fLq9Dt9tHGfJ8Tef3Sm
         gVATUnNe5Pflup+FNNGZB8s3qaftNZws3BFI6BaGGoo0wXchyfM8O9I3+6jpQIPejXh1
         E7zicwLFgIkWTXgcjV3H6x8QtVYc1VmhEgXBV0UZFWeJrCLIjfOF6HTnsTiIMmCPmGPN
         GbVHAz8Rcz5q18fa1GOuP6+/j9HOZY53DKzKYBw/XNayo2NelRZB1igF7NzKD7JZacjS
         mNNA==
X-Gm-Message-State: AOJu0YwsCj+s1lkG7nUsBi9wkOHIkcXAckxk1P8sdTE5AUhLX6OM7fPe
	6Rsnw7iW7etH0SXcbfh4joA3GlD/6KRhxImDMzgpb3d4WBASFDaOlGN4iglG89dUOT9olcxJZqr
	8/TYLvyDtWSNAPbDPhKvmLZu3zsG27gIA9utBPkjI0TU4OMjpwbAIVG8gnx1zN+DSPUEnsBZOvw
	C7YJ0PeuzrQ0XV6Z996HHOd8GELmsainDk
X-Received: from pjbcz4.prod.google.com ([2002:a17:90a:d444:b0:35c:2c27:e619])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224b:b0:35d:997c:8ec0
 with SMTP id 98e67ed59e1d1-35dc6f5fe01mr2216957a91.18.1775020615433; Tue, 31
 Mar 2026 22:16:55 -0700 (PDT)
Date: Wed,  1 Apr 2026 16:16:51 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401051651.3639709-1-tweek@google.com>
Subject: [RFC PATCH] libsepol: Add support for checking standalone CIL
 neverallow rules
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit refactors the CIL part of libsepol to support validating
standalone "neverallow" assertions provided in CIL format against an
existing binary policy.

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Android has the requirement of validating various policies from partners
against the standard AOSP assertions. While this is done at build time,
we also enforce this requirement during certification via the
Compatibility Test Suite.

Until now, this validation was implemented by manually parsing the
neverallow assertions [1]. This approach is brittle and limited (we
currently do not support neverallowxperm assertions).

Design idea
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
An idea is to reuse the existing parsing in libsepol/cil to parse the
assertions. However, the current API forces the policy to be complete
before being able to run the verification. That is, all the symbols
referred to in the assertions must already be defined.

To solve this issue, the implementation idea of this patch is to attach
an existing kernel policy to the incomplete cil_db_t. This existing
policy is considered a "fallback" policy. When compiling the cil_db_t if
any type, attribute, class or permission is unknown, it is pulled in
from the fallback policy.

An alternative option to this patch is to (1) use checkpolicy to
translate a binary policy into its CIL format; (2) append neverallow
assertions to the CIL policy and (3) rebuild the complete policy. While
this reuses the current tools and API, this requires a lot of
unnecessary translation.

Implementation changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Lazy Symbol Import: Modified cil_resolve_ast.c to support a "fallback
  policy". If a symbol (type, attribute, class, or permission) is not
  found in the CIL database during resolution, it now searches a provided
  policydb_t. When found, it dynamically creates CIL datums and inserts
  them into the AST, allowing compilation to proceed without requiring
  the full source policy in CIL format.
- Lazy Attribute Resolution: Updated cil_binary.c to correctly handle
  imported attributes by utilizing their bitmask from the binary policy
  when they have no explicit members in CIL.
- New Public API: Introduced cil_compile_against and
  cil_check_neverallows_assertions. These functions allow a caller to
  set a fallback binary policy for compilation and then run neverallow
  validation against it.
- Validation Utility: Added a new utility cil_neverallow_check in
  libsepol/utils to facilitate testing and validation of this new API.

Feedback
=3D=3D=3D=3D=3D=3D=3D=3D
This is an RFC and I am looking for feedback on the idea. If a similar
tool can be written without having to increase the API, please let me
know.

I don't know if these new functions (cil_compile_against and
cil_check_neverallows_assertions) are sufficient or how they could be
improved. Could they be made more generic to cover similar use cases?

If the approach seems sensible, more work is likely needed to support
users, roles and others objects. Please let me know what you think is
missing here.

[1] https://cs.android.com/android/platform/superproject/+/android-latest-r=
elease:system/sepolicy/tools/sepolicy-analyze/neverallow.c

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/cil/include/cil/cil.h        |  16 ++++
 libsepol/cil/src/cil.c                |  68 +++++++++++++++++
 libsepol/cil/src/cil_binary.c         |  15 +++-
 libsepol/cil/src/cil_binary.h         |  24 ++++++
 libsepol/cil/src/cil_internal.h       |   1 +
 libsepol/cil/src/cil_resolve_ast.c    | 102 +++++++++++++++++++++++--
 libsepol/src/libsepol.map.in          |   4 +-
 libsepol/utils/Makefile               |   2 +-
 libsepol/utils/cil_neverallow_check.c | 103 ++++++++++++++++++++++++++
 9 files changed, 324 insertions(+), 11 deletions(-)
 create mode 100644 libsepol/utils/cil_neverallow_check.c

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.=
h
index 88e47e79..51a999b9 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -81,6 +81,22 @@ extern void cil_log(enum cil_log_level lvl, const char *=
msg, ...);
=20
 extern void cil_set_malloc_error_handler(void (*handler)(void));
=20
+/*
+ * Compile a partial policy (db), importing types, attributes,
+ * classes and permissions from sepol_db if not found.
+ */
+extern int cil_compile_against(cil_db_t *db, sepol_policydb_t *sepol_db);
+
+/*
+ * Validate neverallow assertions in a policy.
+ *
+ * This step is usually performed implicitly within cil_build_policydb.
+ * However, there might be some interest in validating these assertions
+ * without a full build.
+ */
+extern int cil_check_neverallows_assertions(cil_db_t *db);
+
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 9662cf45..b323f144 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -467,6 +467,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->qualified_names =3D CIL_FALSE;
 	(*db)->target_platform =3D SEPOL_TARGET_SELINUX;
 	(*db)->policy_version =3D POLICYDB_VERSION_MAX;
+	(*db)->fallback_pdb =3D NULL;
 }
=20
 static void cil_declared_strings_list_destroy(struct cil_list **strings)
@@ -3001,3 +3002,70 @@ void cil_src_info_init(struct cil_src_info **info)
 	(*info)->hll_line =3D 0;
 	(*info)->path =3D NULL;
 }
+
+struct cil_check_neverallow_args {
+	const struct cil_db *db;
+	policydb_t *pdb;
+	int violation;
+};
+
+static int __cil_check_neverallow_helper(struct cil_tree_node *node, uint3=
2_t *finished __attribute__((unused)), void *extra_args)
+{
+	struct cil_check_neverallow_args *args =3D extra_args;
+	int rc =3D SEPOL_OK;
+
+	if (node->flavor =3D=3D CIL_AVRULE) {
+		struct cil_avrule *rule =3D node->data;
+		if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
+			int violation =3D CIL_FALSE;
+			rc =3D cil_check_neverallow(args->db, args->pdb, node, &violation);
+			if (rc !=3D SEPOL_OK) {
+				return rc;
+			}
+			if (violation =3D=3D CIL_TRUE) {
+				args->violation =3D CIL_TRUE;
+			}
+		}
+	}
+	return SEPOL_OK;
+}
+
+int cil_compile_against(cil_db_t *db, sepol_policydb_t *sepol_db)
+{
+	int rc;
+
+	if (db =3D=3D NULL || sepol_db =3D=3D NULL) {
+		return SEPOL_ERR;
+	}
+
+	db->fallback_pdb =3D &sepol_db->p;
+
+	rc =3D cil_compile(db);
+
+	return rc;
+}
+
+int cil_check_neverallows_assertions(cil_db_t *db)
+{
+	int rc;
+	struct cil_check_neverallow_args extra_args;
+
+	if (db =3D=3D NULL || db->fallback_pdb =3D=3D NULL) {
+		return SEPOL_ERR;
+	}
+
+	extra_args.db =3D db;
+	extra_args.pdb =3D db->fallback_pdb;
+	extra_args.violation =3D CIL_FALSE;
+
+	rc =3D cil_tree_walk(db->ast->root, __cil_check_neverallow_helper, NULL, =
NULL, &extra_args);
+	if (rc !=3D SEPOL_OK) {
+		return rc;
+	}
+
+	if (extra_args.violation =3D=3D CIL_TRUE) {
+		return SEPOL_ERR;
+	}
+
+	return SEPOL_OK;
+}
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 74ec3cd5..a1485560 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4843,6 +4843,17 @@ static int __cil_add_sepol_type(policydb_t *pdb, con=
st struct cil_db *db, struct
 		ebitmap_node_t *tnode;
 		unsigned int i;
 		struct cil_typeattribute *attr =3D (struct cil_typeattribute *)datum;
+
+		if (attr->types =3D=3D NULL) {
+			rc =3D __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
+			if (rc !=3D SEPOL_OK) goto exit;
+			if (sepol_datum->flavor !=3D TYPE_ATTRIB) {
+				rc =3D SEPOL_ERR;
+				goto exit;
+			}
+			return ebitmap_union(map, &pdb->attr_type_map[sepol_datum->s.value - 1]=
);
+		}
+
 		ebitmap_for_each_positive_bit(attr->types, tnode, i) {
 			datum =3D DATUM(db->val_to_type[i]);
 			rc =3D __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
@@ -5032,7 +5043,7 @@ exit:
 	return rc;
 }
=20
-static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, =
struct cil_tree_node *node, int *violation)
+int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct =
cil_tree_node *node, int *violation)
 {
 	int rc =3D SEPOL_OK;
 	struct cil_avrule *cil_rule =3D node->data;
@@ -5127,7 +5138,7 @@ exit:
 	return rc;
 }
=20
-static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb,=
 struct cil_list *neverallows, int *violation)
+int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct=
 cil_list *neverallows, int *violation)
 {
 	int rc =3D SEPOL_OK;
 	struct cil_list_item *item;
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index e6826221..8b20e45e 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -341,6 +341,30 @@ int cil_sepol_level_define(policydb_t *pdb, struct cil=
_sens *cil_sens);
  */
 int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *=
db, struct cil_rangetransition *rangetrans);
=20
+/**
+ * Check a neverallow rule against a policydb.
+ *
+ * @param[in] db The cil database.
+ * @param[in] pdb The policy database to check against.
+ * @param[in] node The AST node containing the neverallow rule.
+ * @param[out] violation Set to CIL_TRUE if a violation is found.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct =
cil_tree_node *node, int *violation);
+
+/**
+ * Check a list of neverallow rules against a policydb.
+ *
+ * @param[in] db The cil database.
+ * @param[in] pdb The policy database to check against.
+ * @param[in] neverallows The list of AST nodes containing neverallow rule=
s.
+ * @param[out] violation Set to CIL_TRUE if any violation is found.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct=
 cil_list *neverallows, int *violation);
+
 /**
  * Insert cil ibpkeycon structure into sepol policydb.
  * The function is given a structure containing the sorted ibpkeycons and
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_interna=
l.h
index ae3ab824..fcfa7b0d 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -336,6 +336,7 @@ struct cil_db {
 	int qualified_names;
 	int target_platform;
 	int policy_version;
+	policydb_t *fallback_pdb;
 };
=20
 struct cil_root {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_reso=
lve_ast.c
index bcac4026..75a790e7 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -68,17 +68,18 @@ struct cil_args_resolve {
 	struct cil_list *abstract_blocks;
 };
=20
-static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_sy=
mtab, struct cil_list *perm_strs, struct cil_list **perm_datums, enum cil_f=
lavor class_flavor)
+static int __cil_resolve_perms(struct cil_db *db, struct cil_class *class,=
 symtab_t *common_symtab, struct cil_list *perm_strs, struct cil_list **per=
m_datums, enum cil_flavor class_flavor)
 {
 	int rc =3D SEPOL_ERR;
 	struct cil_list_item *curr;
+	symtab_t *class_symtab =3D &class->perms;
=20
 	cil_list_init(perm_datums, perm_strs->flavor);
=20
 	cil_list_for_each(curr, perm_strs) {
 		if (curr->flavor =3D=3D CIL_LIST) {
 			struct cil_list *sub_list;
-			rc =3D __cil_resolve_perms(class_symtab, common_symtab, curr->data, &su=
b_list, class_flavor);
+			rc =3D __cil_resolve_perms(db, class, common_symtab, curr->data, &sub_l=
ist, class_flavor);
 			if (rc !=3D SEPOL_OK) {
 				cil_log(CIL_ERR, "Failed to resolve permission list\n");
 				goto exit;
@@ -92,6 +93,37 @@ static int __cil_resolve_perms(symtab_t *class_symtab, s=
ymtab_t *common_symtab,
 					rc =3D cil_symtab_get_datum(common_symtab, curr->data, &perm_datum);
 				}
 			}
+
+			if (rc =3D=3D SEPOL_ENOENT && db->fallback_pdb !=3D NULL) {
+				/* Try fallback to policydb */
+				if (class !=3D NULL && FLAVOR(class) =3D=3D CIL_CLASS) {
+					class_datum_t *sepol_class =3D hashtab_search(db->fallback_pdb->p_cla=
sses.table, DATUM(class)->fqn);
+					if (sepol_class !=3D NULL) {
+						perm_datum_t *sepol_perm =3D hashtab_search(sepol_class->permissions=
.table, curr->data);
+						if (sepol_perm =3D=3D NULL && sepol_class->comdatum !=3D NULL) {
+							sepol_perm =3D hashtab_search(sepol_class->comdatum->permissions.ta=
ble, curr->data);
+						}
+
+						if (sepol_perm !=3D NULL) {
+							struct cil_perm *cil_perm =3D NULL;
+							struct cil_tree_node *node =3D NULL;
+							cil_perm_init(&cil_perm);
+							cil_tree_node_init(&node);
+							node->data =3D cil_perm;
+							node->flavor =3D CIL_PERM;
+							node->parent =3D NODE(class);
+							rc =3D cil_symtab_insert(class_symtab, curr->data, (struct cil_symt=
ab_datum *)cil_perm, node);
+							if (rc =3D=3D SEPOL_OK) {
+								perm_datum =3D (struct cil_symtab_datum *)cil_perm;
+							} else {
+								cil_destroy_data(&node->data, node->flavor);
+								cil_tree_node_destroy(&node);
+							}
+						}
+					}
+				}
+			}
+
 			if (rc !=3D SEPOL_OK) {
 				if (class_flavor =3D=3D CIL_MAP_CLASS) {
 					cil_log(CIL_ERR, "Failed to resolve permission %s for map class\n", (=
char*)curr->data);
@@ -137,7 +169,7 @@ int cil_resolve_classperms(struct cil_tree_node *curren=
t, struct cil_classperms
=20
 	cp->class =3D class;
=20
-	rc =3D __cil_resolve_perms(&class->perms, common_symtab, cp->perm_strs, &=
cp->perms, FLAVOR(datum));
+	rc =3D __cil_resolve_perms(db, class, common_symtab, cp->perm_strs, &cp->=
perms, FLAVOR(datum));
 	if (rc !=3D SEPOL_OK) {
 		goto exit;
 	}
@@ -4188,9 +4220,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tr=
ee_node *current)
 		}
 	}
=20
-	rc =3D __cil_verify_initsids(db->sidorder);
-	if (rc !=3D SEPOL_OK) {
-		goto exit;
+	if (db->fallback_pdb =3D=3D NULL) {
+		rc =3D __cil_verify_initsids(db->sidorder);
+		if (rc !=3D SEPOL_OK) {
+			goto exit;
+		}
 	}
=20
 	rc =3D SEPOL_OK;
@@ -4211,8 +4245,62 @@ exit:
 static int __cil_resolve_name_with_root(struct cil_db *db, char *name, enu=
m cil_sym_index sym_index, struct cil_symtab_datum **datum)
 {
 	symtab_t *symtab =3D &((struct cil_root *)db->ast->root->data)->symtab[sy=
m_index];
+	int rc =3D cil_symtab_get_datum(symtab, name, datum);
+
+	if (rc !=3D SEPOL_OK && db->fallback_pdb !=3D NULL) {
+		void *sepol_datum =3D NULL;
+		struct cil_tree_node *node =3D NULL;
+		struct cil_symtab_datum *new_datum =3D NULL;
+
+		enum cil_flavor flavor =3D CIL_NONE;
+
+		switch (sym_index) {
+		case CIL_SYM_TYPES:
+			sepol_datum =3D hashtab_search(db->fallback_pdb->p_types.table, name);
+			if (sepol_datum !=3D NULL) {
+				type_datum_t *type =3D sepol_datum;
+				if (type->flavor =3D=3D TYPE_ATTRIB) {
+					struct cil_typeattribute *cil_attr =3D NULL;
+					cil_typeattribute_init(&cil_attr);
+					new_datum =3D (struct cil_symtab_datum *)cil_attr;
+					flavor =3D CIL_TYPEATTRIBUTE;
+				} else {
+					struct cil_type *cil_type =3D NULL;
+					cil_type_init(&cil_type);
+					new_datum =3D (struct cil_symtab_datum *)cil_type;
+					flavor =3D CIL_TYPE;
+				}
+			}
+			break;
+		case CIL_SYM_CLASSES:
+			sepol_datum =3D hashtab_search(db->fallback_pdb->p_classes.table, name)=
;
+			if (sepol_datum !=3D NULL) {
+				struct cil_class *cil_class =3D NULL;
+				cil_class_init(&cil_class);
+				new_datum =3D (struct cil_symtab_datum *)cil_class;
+				flavor =3D CIL_CLASS;
+			}
+			break;
+		default:
+			break;
+		}
=20
-	return cil_symtab_get_datum(symtab, name, datum);
+		if (new_datum !=3D NULL) {
+			cil_tree_node_init(&node);
+			node->data =3D new_datum;
+			node->flavor =3D flavor;
+			node->parent =3D db->ast->root;
+			rc =3D cil_symtab_insert(symtab, name, new_datum, node);
+			if (rc =3D=3D SEPOL_OK) {
+				*datum =3D new_datum;
+			} else {
+				cil_destroy_data(&node->data, node->flavor);
+				cil_tree_node_destroy(&node);
+			}
+		}
+	}
+
+	return rc;
 }
=20
 static int __cil_resolve_name_with_parents(struct cil_tree_node *node, cha=
r *name, enum cil_sym_index sym_index, struct cil_symtab_datum **datum)
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index e5e6608c..3440fe98 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -290,7 +290,9 @@ LIBSEPOL_3.4 {
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
=20
-LIBSEPOL_3.6 {
+LIBSEPOL_3.11 {
   global:
 	cil_write_post_ast;
+	cil_compile_against;
+	cil_check_neverallows_assertions;
 } LIBSEPOL_3.4;
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index a8bedf2e..67eebd16 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -3,7 +3,7 @@ PREFIX ?=3D /usr
 BINDIR ?=3D $(PREFIX)/bin
=20
 CFLAGS ?=3D -Wall -Werror
-override CFLAGS +=3D -I../include
+override CFLAGS +=3D -I../include -I../cil/include
 override LDFLAGS +=3D -L../src
 override LDLIBS +=3D -lsepol
=20
diff --git a/libsepol/utils/cil_neverallow_check.c b/libsepol/utils/cil_nev=
erallow_check.c
new file mode 100644
index 00000000..0dae047c
--- /dev/null
+++ b/libsepol/utils/cil_neverallow_check.c
@@ -0,0 +1,103 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <sepol/policydb.h>
+#include <cil/cil.h>
+
+int main(int argc, char *argv[])
+{
+	if (argc < 3) {
+		fprintf(stderr, "Usage: %s <policy_file> <neverallow_cil_file>\n", argv[=
0]);
+		return -1;
+	}
+
+	const char *policy_file =3D argv[1];
+	const char *neverallow_file =3D argv[2];
+
+	sepol_policydb_t *pdb =3D NULL;
+	sepol_policy_file_t *pf =3D NULL;
+	FILE *fp;
+
+	fp =3D fopen(policy_file, "re");
+	if (!fp) {
+		perror("fopen policy_file");
+		return -1;
+	}
+
+	if (sepol_policy_file_create(&pf) !=3D 0) {
+		fprintf(stderr, "sepol_policy_file_create failed\n");
+		fclose(fp);
+		return -1;
+	}
+	sepol_policy_file_set_fp(pf, fp);
+
+	if (sepol_policydb_create(&pdb) !=3D 0) {
+		fprintf(stderr, "sepol_policydb_create failed\n");
+		sepol_policy_file_free(pf);
+		fclose(fp);
+		return -1;
+	}
+
+	if (sepol_policydb_read(pdb, pf) !=3D 0) {
+		fprintf(stderr, "sepol_policydb_read failed\n");
+		sepol_policydb_free(pdb);
+		sepol_policy_file_free(pf);
+		fclose(fp);
+		return -1;
+	}
+	fclose(fp);
+	sepol_policy_file_free(pf);
+
+	struct cil_db *db;
+	cil_db_init(&db);
+
+	int fd =3D open(neverallow_file, O_RDONLY);
+	if (fd < 0) {
+		perror("open neverallow_file");
+		sepol_policydb_free(pdb);
+		cil_db_destroy(&db);
+		return -1;
+	}
+	struct stat sb;
+	if (fstat(fd, &sb) < 0) {
+		perror("fstat neverallow_file");
+		close(fd);
+		sepol_policydb_free(pdb);
+		cil_db_destroy(&db);
+		return -1;
+	}
+	char *text =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (cil_add_file(db, neverallow_file, text, sb.st_size)) {
+		fprintf(stderr, "cil_add_file failed\n");
+		munmap(text, sb.st_size);
+		sepol_policydb_free(pdb);
+		cil_db_destroy(&db);
+		return -1;
+	}
+
+	int rc =3D cil_compile_against(db, pdb);
+	if (rc !=3D SEPOL_OK) {
+		fprintf(stderr, "cil_compile_against failed\n");
+	} else {
+		rc =3D cil_check_neverallows_assertions(db);
+		if (rc =3D=3D SEPOL_OK) {
+			printf("Neverallow check passed (no violations)\n");
+		} else {
+			printf("Neverallow check failed (violation found or error)\n");
+		}
+	}
+
+	munmap(text, sb.st_size);
+	cil_db_destroy(&db);
+	sepol_policydb_free(pdb);
+
+	return (rc =3D=3D SEPOL_OK) ? 0 : 1;
+}
--=20
2.53.0.1118.gaef5881109-goog

