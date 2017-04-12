Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CIQK5c030322
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 14:26:20 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2 v2] libsepol/cil: Add ability to expand some attributes in
 binary policy
Date: Wed, 12 Apr 2017 14:26:53 -0400
Message-Id: <1492021614-23133-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1492021614-23133-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1492021614-23133-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Originally, all type attributes were expanded when building a binary
policy. As the policy grew, binary policy sizes became too large, so
changes were made to keep attributes in the binary policy to minimize
policy size.

Keeping attributes works well as long as each type does not have too
many attributes. If an access check fails for types t1 and t2, then
additional checks must be made for every attribute that t1 is a member
of against t2 and all the attributes that t2 is a member of. This is
O(n*m) behavior and there are cases now where this is becoming a
performance issue.

Attributes are more aggressively removed than before. An attribute
will now be removed if it only appears in rules where attributes are
always expanded (typetransition, typechange, typemember, roletransition,
rangetransition, roletype, and AV Rules with self).

Attributes that are used in constraints are always kept because the
attribute name is stored for debugging purposes in the binary policy.

Attributes that are used in neverallow rules, but not in other AV rules,
will be kept unless the attribute is auto-generated.

Attributes that are only used in AV rules other than neverallow rules
are kept unless the number of types assigned to them is less than the
value of attrs_expand_size in the CIL db. The default is 1, which means
that any attribute that has no types assigned to it will be expanded (and
the rule removed from the policy), which is CIL's current behavior. The
value can be set using the function cil_set_attrs_expand_size().

Auto-generated attributes that are used only in neverallow rules are
always expanded. The rest are kept by default, but if the value of
attrs_expand_generated in the CIL db is set to true, they will be
expanded. The function cil_set_attrs_expand_generated() can be used
to set the value.

When creating the binary policy, CIL will expand all attributes that
are being removed and it will expand all attributes with less members
than the value specified by attrs_expand_size. So even if an attribute
is used in a constraint or neverallow and the attribute itself will be
included in the binary policy, it will be expanded when writing AV
rules if it has less members than attrs_expand_size.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/include/cil/cil.h     |   2 +
 libsepol/cil/src/cil.c             |  12 ++
 libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----------
 libsepol/cil/src/cil_internal.h    |   7 +-
 libsepol/cil/src/cil_post.c        |  32 +++--
 libsepol/cil/src/cil_resolve_ast.c |  25 ++--
 libsepol/src/libsepol.map.in       |   2 +
 7 files changed, 233 insertions(+), 100 deletions(-)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index c4a6fb9..4507892 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -50,6 +50,8 @@ extern void cil_set_disable_neverallow(cil_db_t *db, int disable_neverallow);
 extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_tunables);
 extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
 extern void cil_set_mls(cil_db_t *db, int mls);
+extern void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_expand_generated);
+extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_expand_size);
 extern void cil_set_target_platform(cil_db_t *db, int target_platform);
 extern void cil_set_policy_version(cil_db_t *db, int policy_version);
 extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 7c40ad0..a64c528 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -282,6 +282,8 @@ void cil_db_init(struct cil_db **db)
 
 	(*db)->disable_dontaudit = CIL_FALSE;
 	(*db)->disable_neverallow = CIL_FALSE;
+	(*db)->attrs_expand_generated = CIL_FALSE;
+	(*db)->attrs_expand_size = 1;
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
@@ -1629,6 +1631,16 @@ void cil_set_disable_neverallow(struct cil_db *db, int disable_neverallow)
 	db->disable_neverallow = disable_neverallow;
 }
 
+void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_expand_generated)
+{
+	db->attrs_expand_generated = attrs_expand_generated;
+}
+
+void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_expand_size)
+{
+	db->attrs_expand_size = attrs_expand_size;
+}
+
 void cil_set_preserve_tunables(struct cil_db *db, int preserve_tunables)
 {
 	db->preserve_tunables = preserve_tunables;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ac18c4e..e1481a4 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -567,7 +567,7 @@ int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil
 	char *key = NULL;
 	type_datum_t *sepol_attr = NULL;
 
-	if (cil_attr->used == CIL_FALSE) {
+	if (!cil_attr->used) {
 		return SEPOL_OK;		
 	}
 
@@ -632,7 +632,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const struct cil_db *db, struct
 	ebitmap_node_t *tnode;
 	unsigned int i;
 
-	if (cil_attr->used == CIL_FALSE) {
+	if (!cil_attr->used) {
 		return SEPOL_OK;
 	}
 
@@ -1429,46 +1429,20 @@ exit:
 	return rc;
 }
 
-static int __cil_type_datum_is_unused_attrib(struct cil_symtab_datum *src)
+static int __cil_should_expand_attribute( const struct cil_db *db, struct cil_symtab_datum *datum)
 {
-	struct cil_tree_node *node = NULL;
-	struct cil_typeattribute *attrib = NULL;
+	struct cil_tree_node *node;
+	struct cil_typeattribute *attr;
 
-	if (src->fqn == CIL_KEY_SELF) {
-		return CIL_FALSE;
-	}
-
-	node = NODE(src);
+	node = NODE(datum);
 
 	if (node->flavor != CIL_TYPEATTRIBUTE) {
 		return CIL_FALSE;
 	}
 
-	attrib = (struct cil_typeattribute *) src;
-	return ebitmap_cardinality(attrib->types) == 0;
-}
-
-static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)
-{
-	struct cil_symtab_datum *src = cil_avrule->src;
-	struct cil_symtab_datum *tgt = cil_avrule->tgt;
-
-	// Don't remove neverallow rules so they are written to
-	// the resulting policy and can be checked by tools in
-	// AOSP.
-	if (cil_avrule->rule_kind == CIL_AVRULE_NEVERALLOW) {
-		return CIL_FALSE;
-	}
-
-	if (__cil_type_datum_is_unused_attrib(src)) {
-		return CIL_TRUE;
-	}
-
-	if (__cil_type_datum_is_unused_attrib(tgt)) {
-		return CIL_TRUE;
-	}
+	attr = (struct cil_typeattribute *)datum;
 
-	return CIL_FALSE;
+	return !attr->used || (ebitmap_cardinality(attr->types) < db->attrs_expand_size);
 }
 
 int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
@@ -1478,6 +1452,9 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 	struct cil_symtab_datum *src = NULL;
 	struct cil_symtab_datum *tgt = NULL;
 	struct cil_list *classperms = cil_avrule->perms.classperms;
+	ebitmap_t src_bitmap, tgt_bitmap;
+	ebitmap_node_t *snode, *tnode;
+	unsigned int s,t;
 
 	if (cil_avrule->rule_kind == CIL_AVRULE_DONTAUDIT && db->disable_dontaudit == CIL_TRUE) {
 		// Do not add dontaudit rules to binary
@@ -1485,36 +1462,98 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 		goto exit;
 	}
 
-	if (__cil_avrule_can_remove(cil_avrule)) {
-		rc = SEPOL_OK;
-		goto exit;
-	}
-
 	src = cil_avrule->src;
 	tgt = cil_avrule->tgt;
 
 	if (tgt->fqn == CIL_KEY_SELF) {
-		ebitmap_t type_bitmap;
-		ebitmap_node_t *tnode;
-		unsigned int i;
-
-		rc = __cil_expand_type(src, &type_bitmap);
-		if (rc != SEPOL_OK) goto exit;
+		rc = __cil_expand_type(src, &src_bitmap);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 
-		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
-			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
+		ebitmap_for_each_bit(&src_bitmap, snode, s) {
+			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
 
-			src = DATUM(db->val_to_type[i]);
+			src = DATUM(db->val_to_type[s]);
 			rc = __cil_avrule_expand(pdb, kind, src, src, classperms, cond_node, cond_flavor);
 			if (rc != SEPOL_OK) {
-				ebitmap_destroy(&type_bitmap);
+				ebitmap_destroy(&src_bitmap);
 				goto exit;
 			}
 		}
-		ebitmap_destroy(&type_bitmap);
+		ebitmap_destroy(&src_bitmap);
 	} else {
-		rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
-		if (rc != SEPOL_OK) goto exit;
+		int expand_src = __cil_should_expand_attribute(db, src);
+		int expand_tgt = __cil_should_expand_attribute(db, tgt);
+		if (!expand_src && !expand_tgt) {
+			rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		} else if (expand_src && expand_tgt) {
+			rc = __cil_expand_type(src, &src_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			rc = __cil_expand_type(tgt, &tgt_bitmap);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(&src_bitmap);
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&src_bitmap, snode, s) {
+				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+				src = DATUM(db->val_to_type[s]);
+				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
+					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+					tgt = DATUM(db->val_to_type[t]);
+
+					rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						ebitmap_destroy(&tgt_bitmap);
+						goto exit;
+					}
+				}
+			}
+			ebitmap_destroy(&src_bitmap);
+			ebitmap_destroy(&tgt_bitmap);
+		} else if (expand_src) {
+			rc = __cil_expand_type(src, &src_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&src_bitmap, snode, s) {
+				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+				src = DATUM(db->val_to_type[s]);
+
+				rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+				if (rc != SEPOL_OK) {
+					ebitmap_destroy(&src_bitmap);
+					goto exit;
+				}
+			}
+			ebitmap_destroy(&src_bitmap);
+		} else { /* expand_tgt */
+			rc = __cil_expand_type(tgt, &tgt_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
+				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+				tgt = DATUM(db->val_to_type[t]);
+
+				rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+				if (rc != SEPOL_OK) {
+					ebitmap_destroy(&tgt_bitmap);
+					goto exit;
+				}
+			}
+			ebitmap_destroy(&tgt_bitmap);
+		}
 	}
 
 	return SEPOL_OK;
@@ -1789,11 +1828,9 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 	uint16_t kind;
 	struct cil_symtab_datum *src = NULL;
 	struct cil_symtab_datum *tgt = NULL;
-	ebitmap_t type_bitmap;
-	ebitmap_node_t *tnode;
-	unsigned int i;
-
-	ebitmap_init(&type_bitmap);
+	ebitmap_t src_bitmap, tgt_bitmap;
+	ebitmap_node_t *snode, *tnode;
+	unsigned int s,t;
 
 	if (cil_avrulex->rule_kind == CIL_AVRULE_DONTAUDIT && db->disable_dontaudit == CIL_TRUE) {
 		// Do not add dontaudit rules to binary
@@ -1806,28 +1843,97 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 	tgt = cil_avrulex->tgt;
 
 	if (tgt->fqn == CIL_KEY_SELF) {
-		rc = __cil_expand_type(src, &type_bitmap);
+		rc = __cil_expand_type(src, &src_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
-			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
+		ebitmap_for_each_bit(&src_bitmap, snode, s) {
+			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
 
-			src = DATUM(db->val_to_type[i]);
+			src = DATUM(db->val_to_type[s]);
 			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->perms.x.permx, args);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
+		ebitmap_destroy(&src_bitmap);
 	} else {
-		rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
-		if (rc != SEPOL_OK) goto exit;
+		int expand_src = __cil_should_expand_attribute(db, src);
+		int expand_tgt = __cil_should_expand_attribute(db, tgt);
+
+		if (!expand_src && !expand_tgt) {
+			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		} else if (expand_src && expand_tgt) {
+			rc = __cil_expand_type(src, &src_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			rc = __cil_expand_type(tgt, &tgt_bitmap);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(&src_bitmap);
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&src_bitmap, snode, s) {
+				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+				src = DATUM(db->val_to_type[s]);
+				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
+					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+					tgt = DATUM(db->val_to_type[t]);
+
+					rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						ebitmap_destroy(&tgt_bitmap);
+						goto exit;
+					}
+				}
+			}
+			ebitmap_destroy(&src_bitmap);
+			ebitmap_destroy(&tgt_bitmap);
+		} else if (expand_src) {
+			rc = __cil_expand_type(src, &src_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&src_bitmap, snode, s) {
+				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+				src = DATUM(db->val_to_type[s]);
+
+				rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+				if (rc != SEPOL_OK) {
+					ebitmap_destroy(&src_bitmap);
+					goto exit;
+				}
+			}
+			ebitmap_destroy(&src_bitmap);
+		} else { /* expand_tgt */
+			rc = __cil_expand_type(tgt, &tgt_bitmap);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+
+			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
+				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+				tgt = DATUM(db->val_to_type[t]);
+
+				rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+				if (rc != SEPOL_OK) {
+					ebitmap_destroy(&tgt_bitmap);
+					goto exit;
+				}
+			}
+			ebitmap_destroy(&tgt_bitmap);
+		}
 	}
 
-	rc = SEPOL_OK;
+	return SEPOL_OK;
 
 exit:
-	ebitmap_destroy(&type_bitmap);
-
 	return rc;
 }
 
@@ -2417,12 +2523,19 @@ int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
 		if (pdb->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
 			rc = __cil_get_sepol_type_datum(pdb, item->data, &sepol_type);
 			if (rc != SEPOL_OK) {
-				ebitmap_destroy(&type_bitmap);
-				goto exit;
+				if (FLAVOR(item->data) == CIL_TYPEATTRIBUTE) {
+					struct cil_typeattribute *attr = item->data;
+					if (!attr->used) {
+						rc = 0;
+					}
+				}
 			}
 
-			if (ebitmap_set_bit(&expr->type_names->types, sepol_type->s.value - 1, 1)) {
-				ebitmap_destroy(&type_bitmap);
+			if (sepol_type) {
+				rc = ebitmap_set_bit(&expr->type_names->types, sepol_type->s.value - 1, 1);
+			}
+
+			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 03672bb..efa2cd6 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -306,6 +306,8 @@ struct cil_db {
 	struct cil_user **val_to_user;
 	int disable_dontaudit;
 	int disable_neverallow;
+	int attrs_expand_generated;
+	unsigned attrs_expand_size;
 	int preserve_tunables;
 	int handle_unknown;
 	int mls;
@@ -513,11 +515,14 @@ struct cil_type	{
 	int value;
 };
 
+#define CIL_ATTR_AVRULE     0x01
+#define CIL_ATTR_NEVERALLOW 0x02
+#define CIL_ATTR_CONSTRAINT 0x04
 struct cil_typeattribute {
 	struct cil_symtab_datum datum;
 	struct cil_list *expr_list;
 	ebitmap_t *types;
-	int used;	// whether or not this typeattribute was used and should be added to the binary
+	int used;	// whether or not this attribute was used in a binary policy rule
 };
 
 struct cil_typeattributeset {
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 089c02f..e32a8fc 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1188,22 +1188,32 @@ exit:
 	return SEPOL_ERR;
 }
 
-static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)
+static int cil_typeattribute_used(struct cil_typeattribute *attr, struct cil_db *db)
 {
-	if (cil_attr->used) {
-		return CIL_TRUE;
+	if (!attr->used) {
+		return CIL_FALSE;
 	}
 
-	if (strcmp(DATUM(cil_attr)->name, GEN_REQUIRE_ATTR) == 0) {
-		return CIL_FALSE;
+	if (attr->used & CIL_ATTR_CONSTRAINT) {
+		return CIL_TRUE;
 	}
 
-	if (strstr(DATUM(cil_attr)->name,TYPEATTR_INFIX) != NULL) {
-		return CIL_FALSE;
+	if (db->attrs_expand_generated || attr->used == CIL_ATTR_NEVERALLOW) {
+		if (strcmp(DATUM(attr)->name, GEN_REQUIRE_ATTR) == 0) {
+			return CIL_FALSE;
+		} else if (strstr(DATUM(attr)->name, TYPEATTR_INFIX) != NULL) {
+			return CIL_FALSE;
+		}
+
+		if (attr->used == CIL_ATTR_NEVERALLOW) {
+			return CIL_TRUE;
+		}
 	}
 
-	if (ebitmap_cardinality(cil_attr->types) == 0) {
-		return CIL_FALSE;
+	if (attr->used == CIL_ATTR_AVRULE) {
+		if (ebitmap_cardinality(attr->types) < db->attrs_expand_size) {
+			return CIL_FALSE;
+		}
 	}
 
 	return CIL_TRUE;
@@ -1231,10 +1241,8 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, uint32_t *finis
 		if (attr->types == NULL) {
 			rc = __evaluate_type_expression(attr, db);
 			if (rc != SEPOL_OK) goto exit;
-			if (cil_typeattribute_used(attr)) {
-				attr->used = CIL_TRUE;
-			}
 		}
+		attr->used = cil_typeattribute_used(attr, db);
 		break;
 	}
 	case CIL_ROLEATTRIBUTE: {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 1870501..6da44ba 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -269,13 +269,13 @@ exit:
 	return rc;
 }
 
-int cil_type_used(struct cil_symtab_datum *datum)
+int cil_type_used(struct cil_symtab_datum *datum, int used)
 {
 	struct cil_typeattribute *attr = NULL;
 
 	if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
 		attr = (struct cil_typeattribute*)datum;
-		attr->used = CIL_TRUE;
+		attr->used |= used;
 	}
 
 	return 0;
@@ -307,6 +307,7 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
 	struct cil_symtab_datum *permx_datum = NULL;
+	int used;
 	int rc = SEPOL_ERR;
 
 	if (args != NULL) {
@@ -318,9 +319,6 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 	rule->src = src_datum;
-	if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
-		cil_type_used(src_datum);
-	}
 		
 	if (rule->tgt_str == CIL_KEY_SELF) {
 		rule->tgt = db->selftype;
@@ -330,9 +328,10 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 			goto exit;
 		}
 		rule->tgt = tgt_datum;
-		if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
-			cil_type_used(tgt_datum);
-		}
+		used = (rule->rule_kind == CIL_AVRULE_NEVERALLOW) ?
+			CIL_ATTR_NEVERALLOW : CIL_ATTR_AVRULE;
+		cil_type_used(src_datum, used); /* src not used if tgt is self */
+		cil_type_used(tgt_datum, used);
 	}
 
 	if (!rule->is_extended) {
@@ -376,14 +375,12 @@ int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 	rule->src = src_datum;
-	cil_type_used(src_datum);
 
 	rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rule->tgt = tgt_datum;
-	cil_type_used(tgt_datum);
 
 	rc = cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
@@ -589,14 +586,12 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_ar
 		goto exit;
 	}
 	nametypetrans->src = src_datum;
-	cil_type_used(src_datum);
 
 	rc = cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	nametypetrans->tgt = tgt_datum;
-	cil_type_used(tgt_datum);
 
 	rc = cil_resolve_name(current, nametypetrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
@@ -647,14 +642,12 @@ int cil_resolve_rangetransition(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 	rangetrans->src = src_datum;
-	cil_type_used(src_datum);
 
 	rc = cil_resolve_name(current, rangetrans->exec_str, CIL_SYM_TYPES, extra_args, &exec_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rangetrans->exec = exec_datum;
-	cil_type_used(exec_datum);
 
 	rc = cil_resolve_name(current, rangetrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
@@ -1006,7 +999,6 @@ int cil_resolve_roletype(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 	roletype->type = (struct cil_type*)type_datum;
-	cil_type_used(type_datum);
 
 	return SEPOL_OK;
 
@@ -1035,7 +1027,6 @@ int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 	roletrans->tgt = tgt_datum;
-	cil_type_used(tgt_datum);
 
 	rc = cil_resolve_name(current, roletrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
@@ -3108,7 +3099,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			}
 
 			if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
-				cil_type_used(res_datum);
+				cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
 			}
 
 			cil_list_append(*datum_expr, CIL_DATUM, res_datum);
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 5e68fcb..4042640 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -45,6 +45,8 @@ LIBSEPOL_1.1 {
 	cil_set_target_platform;
 	cil_set_policy_version;
 	cil_set_mls;
+	cil_set_attrs_expand_generated;
+	cil_set_attrs_expand_size;
 	cil_write_policy_conf;
 	sepol_ppfile_to_module_package;
 	sepol_module_package_to_cil;
-- 
2.7.4
