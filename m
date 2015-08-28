Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7SJ0CEV032265
 for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2015 15:00:13 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/3] libsepol/cil: add ioctl whitelist support
Date: Fri, 28 Aug 2015 14:59:45 -0400
Message-ID: <1440788386-17637-3-git-send-email-slawrence@tresys.com>
In-Reply-To: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
References: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add three new extended avrule statements with the following syntax:

  (allowx source_type target_type permissionx)
  (auditallowx source_type target_type permissionx)
  (dontauditx source_type target_type permissionx)

source_type - type, typeattribute, or typealias
target_type - type, typeattribute, typealias, or "self" keyword
permissionx - named or anonymous permissionx statement, which has the syntax:

  (permissionx name (kind object expression))

name - unique identifier of the permissionx statement
kind - must be "ioctl"; could be extended in the future
object - class or classmap
expression - standard CIL expression containing hexadecimal values,
  prefixed with '0x', and the expression keywords 'or', 'xor', 'and',
  'not', 'range', or 'all'. Values must be between 0x0000 and 0xFFFF.
  Values may also be provided in decimal, or in octal if starting with '0'.

For example:

 (allowx src_t tgt_t (ioctl cls (0x1111 0x1222 0x1333)))
 (allowx src_t tgt_t (ioctl cls (range 0x1400 0x14FF)))
 (allowx src_t tgt_t (ioctl cls (and (range 0x1600 0x19FF) (not (range 0x1750 0x175F)))))

 (permissionx ioctl_nodebug (ioctl cls (not (range 0x2010 0x2013))))
 (allowx src_t tgt_t ioctl_nodebug)

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil.c             |  63 ++++++-
 libsepol/cil/src/cil_binary.c      | 360 ++++++++++++++++++++++++++++++++++++-
 libsepol/cil/src/cil_build_ast.c   | 175 ++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h   |   4 +
 libsepol/cil/src/cil_copy_ast.c    |  59 ++++++
 libsepol/cil/src/cil_flavor.h      |   2 +
 libsepol/cil/src/cil_internal.h    |  28 +++
 libsepol/cil/src/cil_post.c        | 144 +++++++++++++--
 libsepol/cil/src/cil_resolve_ast.c |  79 ++++++++
 libsepol/cil/src/cil_verify.c      |   4 +-
 10 files changed, 898 insertions(+), 20 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index dcc1a4f..a89c585 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -70,11 +70,11 @@ asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1"
 #endif
 
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
-	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
-	{64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
-	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
-	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
-	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
+	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
+	{64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
+	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
+	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
+	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
 };
 
 static void cil_init_keys(void)
@@ -223,6 +223,11 @@ static void cil_init_keys(void)
 	CIL_KEY_ROOT = cil_strpool_add("<root>");
 	CIL_KEY_NODE = cil_strpool_add("<node>");
 	CIL_KEY_PERM = cil_strpool_add("perm");
+	CIL_KEY_ALLOWX = cil_strpool_add("allowx");
+	CIL_KEY_AUDITALLOWX = cil_strpool_add("auditallowx");
+	CIL_KEY_DONTAUDITX = cil_strpool_add("dontauditx");
+	CIL_KEY_PERMISSIONX = cil_strpool_add("permissionx");
+	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
 }
 
 void cil_db_init(struct cil_db **db)
@@ -653,6 +658,12 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_AVRULE:
 		cil_destroy_avrule(*data);
 		break;
+	case CIL_AVRULEX:
+		cil_destroy_avrulex(*data);
+		break;
+	case CIL_PERMISSIONX:
+		cil_destroy_permissionx(*data);
+		break;
 	case CIL_ROLETRANSITION:
 		cil_destroy_roletransition(*data);
 		break;
@@ -824,6 +835,9 @@ int cil_flavor_to_symtab_index(enum cil_flavor flavor, enum cil_sym_index *sym_i
 	case CIL_POLICYCAP:
 		*sym_index = CIL_SYM_POLICYCAPS;
 		break;
+	case CIL_PERMISSIONX:
+		*sym_index = CIL_SYM_PERMX;
+		break;
 	default:
 		*sym_index = CIL_SYM_UNKNOWN;
 		cil_log(CIL_INFO, "Failed to find flavor: %d\n", flavor);
@@ -994,6 +1008,20 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 			break;
 		}
 		break;
+	case CIL_AVRULEX:
+		switch (((struct cil_avrulex *)node->data)->rule_kind) {
+		case CIL_AVRULE_ALLOWED:
+			return CIL_KEY_ALLOWX;
+		case CIL_AVRULE_AUDITALLOW:
+			return CIL_KEY_AUDITALLOWX;
+		case CIL_AVRULE_DONTAUDIT:
+			return CIL_KEY_DONTAUDITX;
+		default:
+			break;
+		}
+		break;
+	case CIL_PERMISSIONX:
+		return CIL_KEY_PERMISSIONX;
 	case CIL_ROLETRANSITION:
 		return CIL_KEY_ROLETRANSITION;
 	case CIL_TYPE_RULE:
@@ -2079,6 +2107,31 @@ void cil_avrule_init(struct cil_avrule **avrule)
 	(*avrule)->classperms = NULL;
 }
 
+void cil_permissionx_init(struct cil_permissionx **permx)
+{
+	*permx = cil_malloc(sizeof(**permx));
+
+	cil_symtab_datum_init(&(*permx)->datum);
+	(*permx)->kind = CIL_NONE;
+	(*permx)->obj_str = NULL;
+	(*permx)->obj = NULL;
+	(*permx)->expr_str = NULL;
+	(*permx)->perms = NULL;
+}
+
+void cil_avrulex_init(struct cil_avrulex **avrule)
+{
+	*avrule = cil_malloc(sizeof(**avrule));
+
+	(*avrule)->rule_kind = CIL_NONE;
+	(*avrule)->src_str = NULL;
+	(*avrule)->src = NULL;
+	(*avrule)->tgt_str = NULL;
+	(*avrule)->tgt = NULL;
+	(*avrule)->permx_str = NULL;
+	(*avrule)->permx = NULL;
+}
+
 void cil_type_rule_init(struct cil_type_rule **type_rule)
 {
 	*type_rule = cil_malloc(sizeof(**type_rule));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 6d095db..1439581 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -52,9 +52,10 @@
 /* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
  * size of a hashtable. The next power of 2 of this is 2 ** 16.
  */
-#define FILENAME_TRANS_TABLE_SIZE 1 << 16
-#define RANGE_TRANS_TABLE_SIZE 1 << 13
-#define ROLE_TRANS_TABLE_SIZE 1 << 10
+#define FILENAME_TRANS_TABLE_SIZE (1 << 16)
+#define RANGE_TRANS_TABLE_SIZE (1 << 13)
+#define ROLE_TRANS_TABLE_SIZE (1 << 10)
+#define AVRULEX_TABLE_SIZE (1 <<  10)
 #define PERMS_PER_CLASS 32
 
 struct cil_args_binary {
@@ -65,6 +66,7 @@ struct cil_args_binary {
 	hashtab_t filename_trans_table;
 	hashtab_t range_trans_table;
 	hashtab_t role_trans_table;
+	hashtab_t avrulex_ioctl_table;
 	void **type_value_to_cil;
 };
 
@@ -1451,6 +1453,286 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
 	return __cil_avrule_to_avtab(pdb, db, cil_avrule, NULL, CIL_FALSE);
 }
 
+// Copied from checkpolicy/policy_define.c
+
+/* index of the u32 containing the permission */
+#define XPERM_IDX(x) (x >> 5)
+/* set bits 0 through x-1 within the u32 */
+#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
+/* low value for this u32 */
+#define XPERM_LOW(x) (x << 5)
+/* high value for this u32 */
+#define XPERM_HIGH(x) (((x + 1) << 5) - 1)
+void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_extended_perms *xperms)
+{
+	unsigned int i;
+	uint16_t h = high + 1;
+	/* for each u32 that this low-high range touches, set driver permissions */
+	for (i = XPERM_IDX(low); i <= XPERM_IDX(high); i++) {
+		/* set all bits in u32 */
+		if ((low <= XPERM_LOW(i)) && (high >= XPERM_HIGH(i)))
+			xperms->perms[i] |= ~0U;
+		/* set low bits */
+		else if ((low <= XPERM_LOW(i)) && (high < XPERM_HIGH(i)))
+			xperms->perms[i] |= XPERM_SETBITS(h);
+		/* set high bits */
+		else if ((low > XPERM_LOW(i)) && (high >= XPERM_HIGH(i)))
+			xperms->perms[i] |= ~0U - XPERM_SETBITS(low);
+		/* set middle bits */
+		else if ((low > XPERM_LOW(i)) && (high <= XPERM_HIGH(i)))
+			xperms->perms[i] |= XPERM_SETBITS(h) - XPERM_SETBITS(low);
+	}
+}
+
+
+#define IOC_DRIV(x) (x >> 8)
+#define IOC_FUNC(x) (x & 0xff)
+
+int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+{
+	int rc = SEPOL_OK;
+	struct policydb *pdb;
+	avtab_key_t *avtab_key;
+	avtab_datum_t avtab_datum;
+	ebitmap_t *xperms;
+	ebitmap_node_t *node;
+	unsigned int i;
+	uint16_t low, high;
+	struct avtab_extended_perms *partial = NULL;
+	struct avtab_extended_perms *complete = NULL;
+	int start_new_range;
+
+	avtab_key = (avtab_key_t *)k;
+	xperms = datum;
+	pdb = args;
+
+	avtab_datum.data = 0;
+
+	start_new_range = 1;
+
+	ebitmap_for_each_bit(xperms, node, i) {
+		if (!ebitmap_get_bit(xperms, i)) continue;
+
+		if (start_new_range) {
+			low = i;
+			start_new_range = 0;
+		}
+
+		// continue if the current bit isn't the end of the driver function or the next bit is set
+		if (IOC_FUNC(i) != 0xff && ebitmap_get_bit(xperms, i + 1)) {
+			continue;
+		}
+
+		// if we got here, i is the end of this range (either becuase the func
+		// is 0xff or the next bit isn't set). The next time around we are
+		// going to need a start a new range
+		high = i;
+		start_new_range = 1;
+
+		if (IOC_FUNC(low) == 0x00 && IOC_FUNC(high) == 0xff) {
+			if (!complete) {
+				complete = cil_calloc(1, sizeof(*complete));
+				complete->driver = 0x0;
+				complete->specified = AVTAB_XPERMS_IOCTLDRIVER;
+			}
+
+			__avrule_xperm_setrangebits(IOC_DRIV(low), IOC_DRIV(low), complete);
+		} else {
+			if (partial && partial->driver != IOC_DRIV(low)) {
+				avtab_datum.xperms = partial;
+				rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}
+				free(partial);
+				partial = NULL;
+			}
+
+			if (!partial) {
+				partial = cil_calloc(1, sizeof(*partial));
+				partial->driver = IOC_DRIV(low);
+				partial->specified = AVTAB_XPERMS_IOCTLFUNCTION;
+			}
+
+			__avrule_xperm_setrangebits(IOC_FUNC(low), IOC_FUNC(high), partial);
+		}
+	}
+
+	if (partial) {
+		avtab_datum.xperms = partial;
+		rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	if (complete) {
+		avtab_datum.xperms = complete;
+		rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	free(partial);
+	free(complete);
+
+	// hashtab_t does not have a way to free keys or datum since it doesn't
+	// know what they are. We won't need the keys/datum after this function, so
+	// clean them up here.
+	free(avtab_key);
+	ebitmap_destroy(xperms);
+	free(xperms);
+
+	return rc;
+}
+
+int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
+{
+	uint16_t specified;
+	avtab_key_t *avtab_key;
+	ebitmap_t *hashtab_xperms;
+	int rc = SEPOL_ERR;
+
+	switch (kind) {
+	case CIL_AVRULE_ALLOWED:
+		specified = AVTAB_XPERMS_ALLOWED;
+		break;
+	case CIL_AVRULE_AUDITALLOW:
+		specified = AVTAB_XPERMS_AUDITALLOW;
+		break;
+	case CIL_AVRULE_DONTAUDIT:
+		specified = AVTAB_XPERMS_DONTAUDIT;
+		break;
+	default:
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	avtab_key = cil_malloc(sizeof(*avtab_key));
+	avtab_key->source_type = src;
+	avtab_key->target_type = tgt;
+	avtab_key->target_class = obj;
+	avtab_key->specified = specified;
+
+	hashtab_xperms = (ebitmap_t *)hashtab_search(h, (hashtab_key_t)avtab_key);
+	if (!hashtab_xperms) {
+		hashtab_xperms = cil_malloc(sizeof(*hashtab_xperms));
+		rc = ebitmap_cpy(hashtab_xperms, xperms);
+		if (rc != SEPOL_OK) {
+			free(avtab_key);
+			goto exit;
+		}
+		rc = hashtab_insert(h, (hashtab_key_t)avtab_key, hashtab_xperms);
+		if (rc != SEPOL_OK) {
+			free(avtab_key);
+			goto exit;
+		}
+	} else {
+		free(avtab_key);
+		rc = ebitmap_union(hashtab_xperms, xperms);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
+int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_permissionx *permx, struct cil_args_binary *args)
+{
+	int rc = SEPOL_ERR;
+	type_datum_t *sepol_src = NULL;
+	type_datum_t *sepol_tgt = NULL;
+	class_datum_t *sepol_obj = NULL;
+	struct cil_list *class_list = NULL;
+	struct cil_list_item *c;
+	
+	rc = __cil_get_sepol_type_datum(pdb, src, &sepol_src);
+	if (rc != SEPOL_OK) goto exit;
+
+	rc = __cil_get_sepol_type_datum(pdb, tgt, &sepol_tgt);
+	if (rc != SEPOL_OK) goto exit;
+
+	class_list = cil_expand_class(permx->obj);
+
+	cil_list_for_each(c, class_list) {
+		rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+		if (rc != SEPOL_OK) goto exit;
+
+		switch (permx->kind) {
+		case  CIL_PERMX_KIND_IOCTL:
+			rc = __cil_avrulex_ioctl_to_hashtable(args->avrulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->perms);
+			if (rc != SEPOL_OK) goto exit;
+			break;
+		default:
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	cil_list_destroy(&class_list, CIL_FALSE);
+
+	return rc;
+}
+
+int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct cil_avrulex *cil_avrulex, struct cil_args_binary *args)
+{
+	int rc = SEPOL_ERR;
+	uint16_t kind;
+	struct cil_symtab_datum *src = NULL;
+	struct cil_symtab_datum *tgt = NULL;
+	ebitmap_t type_bitmap;
+	ebitmap_node_t *tnode;
+	unsigned int i;
+
+	ebitmap_init(&type_bitmap);
+
+	if (cil_avrulex->rule_kind == CIL_AVRULE_DONTAUDIT && db->disable_dontaudit == CIL_TRUE) {
+		// Do not add dontaudit rules to binary
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	kind = cil_avrulex->rule_kind;
+	src = cil_avrulex->src;
+	tgt = cil_avrulex->tgt;
+
+	if (tgt->fqn == CIL_KEY_SELF) {
+		rc = __cil_expand_type(src, &type_bitmap);
+		if (rc != SEPOL_OK) goto exit;
+
+		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
+			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
+
+			src = DATUM(db->val_to_type[i]);
+			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->permx, args);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		}
+	} else {
+		rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->permx, args);
+		if (rc != SEPOL_OK) goto exit;
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	ebitmap_destroy(&type_bitmap);
+
+	return rc;
+}
+
 int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
 {
 	int rc;
@@ -3162,6 +3444,9 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 				}
 			}
 			break;
+		case CIL_AVRULEX:
+			rc = cil_avrulex_to_hashtable(pdb, db, node->data, args);
+			break;
 		case CIL_ROLEALLOW:
 			rc = cil_roleallow_to_policydb(pdb, db, node->data);
 			break;
@@ -3595,6 +3880,58 @@ static int role_trans_compare(hashtab_t h
 	return a->role != b->role || a->type != b->type || a->tclass != b->tclass;
 }
 
+/* Based on MurmurHash3, written by Austin Appleby and placed in the
+ * public domain.
+ */
+static unsigned int avrulex_hash(hashtab_t h, hashtab_key_t key)
+{
+	avtab_key_t *k = (avtab_key_t *)key;
+
+	static const uint32_t c1 = 0xcc9e2d51;
+	static const uint32_t c2 = 0x1b873593;
+	static const uint32_t r1 = 15;
+	static const uint32_t r2 = 13;
+	static const uint32_t m  = 5;
+	static const uint32_t n  = 0xe6546b64;
+
+	uint32_t hash = 0;
+
+#define mix(input) { \
+	uint32_t v = input; \
+	v *= c1; \
+	v = (v << r1) | (v >> (32 - r1)); \
+	v *= c2; \
+	hash ^= v; \
+	hash = (hash << r2) | (hash >> (32 - r2)); \
+	hash = hash * m + n; \
+}
+
+	mix(k->target_class);
+	mix(k->target_type);
+	mix(k->source_type);
+	mix(k->specified);
+
+#undef mix
+
+	hash ^= hash >> 16;
+	hash *= 0x85ebca6b;
+	hash ^= hash >> 13;
+	hash *= 0xc2b2ae35;
+	hash ^= hash >> 16;
+
+	return hash & (AVRULEX_TABLE_SIZE - 1);
+}
+
+static int avrulex_compare(hashtab_t h
+             __attribute__ ((unused)), hashtab_key_t key1,
+			              hashtab_key_t key2)
+{
+	avtab_key_t *a = (avtab_key_t *)key1;
+	avtab_key_t *b = (avtab_key_t *)key2;
+
+	return a->source_type != b->source_type || a->target_type != b->target_type || a->target_class != b->target_class || a->specified != b->specified;
+}
+
 int cil_binary_create(const struct cil_db *db, sepol_policydb_t **policydb)
 {
 	int rc = SEPOL_ERR;
@@ -4039,6 +4376,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	hashtab_t filename_trans_table = NULL;
 	hashtab_t range_trans_table = NULL;
 	hashtab_t role_trans_table = NULL;
+	hashtab_t avrulex_ioctl_table = NULL;
 	void **type_value_to_cil = NULL;
 	struct cil_class **class_value_to_cil = NULL;
 	struct cil_perm ***perm_value_to_cil = NULL;
@@ -4092,6 +4430,12 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		goto exit;
 	}
 
+	avrulex_ioctl_table = hashtab_create(avrulex_hash, avrulex_compare, AVRULEX_TABLE_SIZE);
+	if (!avrulex_ioctl_table) {
+		cil_log(CIL_INFO, "Failure to create hashtab for avrulex\n");
+		goto exit;
+	}
+
 	cil_list_init(&neverallows, CIL_LIST_ITEM);
 
 	extra_args.db = db;
@@ -4100,6 +4444,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	extra_args.filename_trans_table = filename_trans_table;
 	extra_args.range_trans_table = range_trans_table;
 	extra_args.role_trans_table = role_trans_table;
+	extra_args.avrulex_ioctl_table = avrulex_ioctl_table;
 	extra_args.type_value_to_cil = type_value_to_cil;
 
 	for (i = 1; i <= 3; i++) {
@@ -4118,6 +4463,14 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 				goto exit;
 			}
 		}
+
+		if (i == 3) {
+			rc = hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_to_policydb, pdb);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_INFO, "Failure creating avrulex rules\n");
+				goto exit;
+			}
+		}
 	}
 
 	rc = cil_sidorder_to_policydb(pdb, db);
@@ -4165,6 +4518,7 @@ exit:
 	hashtab_destroy(filename_trans_table);
 	hashtab_destroy(range_trans_table);
 	hashtab_destroy(role_trans_table);
+	hashtab_destroy(avrulex_ioctl_table);
 	free(type_value_to_cil);
 	free(class_value_to_cil);
 	/* Range is because libsepol values start at 1. */
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 92c3e09..a5aae86 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -1903,6 +1903,169 @@ void cil_destroy_avrule(struct cil_avrule *rule)
 	free(rule);
 }
 
+int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permissionx *permx)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	int rc = SEPOL_ERR;
+	
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	
+	if (parse_current->data == CIL_KEY_IOCTL) {
+		permx->kind = CIL_PERMX_KIND_IOCTL;
+	} else {
+		cil_log(CIL_ERR, "Unknown permissionx kind, %s. Must be \"ioctl\"\n", (char *)parse_current->data);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	permx->obj_str = parse_current->next->data;
+
+	rc = cil_gen_expr(parse_current->next->next, CIL_PERMISSIONX, &permx->expr_str);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Bad permissionx content at line %d of %s\n",
+		parse_current->line, parse_current->path);
+	return rc;
+}
+
+int cil_gen_permissionx(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	char *key = NULL;
+	struct cil_permissionx *permx = NULL;
+	int rc = SEPOL_ERR;
+
+	if (parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_permissionx_init(&permx);
+
+	key = parse_current->next->data;
+
+	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)permx, (hashtab_key_t)key, CIL_SYM_PERMX, CIL_PERMISSIONX);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = cil_fill_permissionx(parse_current->next->next->cl_head, permx);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Bad permissionx statement at line %d of %s\n",
+		parse_current->line, parse_current->path);
+	cil_destroy_permissionx(permx);
+	cil_clear_node(ast_node);
+	return rc;
+}
+
+void cil_destroy_permissionx(struct cil_permissionx *permx)
+{
+	if (permx == NULL) {
+		return;
+	}
+
+	cil_symtab_datum_destroy(&permx->datum);
+
+	cil_list_destroy(&permx->expr_str, CIL_TRUE);
+	ebitmap_destroy(permx->perms);
+	free(permx->perms);
+	free(permx);
+}
+
+int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_avrulex *rule = NULL;
+	int rc = SEPOL_ERR;
+
+	if (parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_avrulex_init(&rule);
+
+	rule->rule_kind = rule_kind;
+	rule->src_str = parse_current->next->data;
+	rule->tgt_str = parse_current->next->next->data;
+
+	if (parse_current->next->next->next->cl_head == NULL) {
+		rule->permx_str = parse_current->next->next->next->data;
+	} else {
+		cil_permissionx_init(&rule->permx);
+
+		rc = cil_fill_permissionx(parse_current->next->next->next->cl_head, rule->permx);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	ast_node->data = rule;
+	ast_node->flavor = CIL_AVRULEX;
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Bad allowx rule at line %d of %s\n", 
+		parse_current->line, parse_current->path);
+	cil_destroy_avrulex(rule);
+	return rc;
+}
+
+void cil_destroy_avrulex(struct cil_avrulex *rule)
+{
+	if (rule == NULL) {
+		return;
+	}
+
+	if (rule->permx_str == NULL && rule->permx != NULL) {
+		cil_destroy_permissionx(rule->permx);
+	}
+	
+	free(rule);
+}
+
 int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind)
 {
 	enum cil_syntax syntax[] = {
@@ -5789,6 +5952,18 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_NEVERALLOW) {
 		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_NEVERALLOW);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_ALLOWX) {
+		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_ALLOWED);
+		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_AUDITALLOWX) {
+		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_AUDITALLOW);
+		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_DONTAUDITX) {
+		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_DONTAUDIT);
+		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_PERMISSIONX) {
+		rc = cil_gen_permissionx(db, parse_current, ast_node);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_TYPETRANSITION) {
 		rc = cil_gen_typetransition(db, parse_current, ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPECHANGE) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 43bc7f6..1b40ae5 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -107,6 +107,10 @@ void cil_destroy_roleattributeset(struct cil_roleattributeset *attrset);
 int cil_gen_rolebounds(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 int cil_gen_avrule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
 void cil_destroy_avrule(struct cil_avrule *rule);
+int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
+void cil_destroy_avrulex(struct cil_avrulex *rule);
+int cil_gen_permissionx(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_permissionx(struct cil_permissionx *permx);
 int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
 void cil_destroy_type_rule(struct cil_type_rule *rule);
 int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 199ce1c..34d8d4c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -760,6 +760,59 @@ int cil_copy_avrule(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
+void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig, struct cil_permissionx *new)
+{
+	new->kind = orig->kind;
+	new->obj_str = orig->obj_str;
+	cil_copy_expr(db, orig->expr_str, &new->expr_str);
+}
+
+int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+{
+	struct cil_permissionx *orig = data;
+	struct cil_permissionx *new = NULL;
+	char *key = orig->datum.name;
+	struct cil_symtab_datum *datum = NULL;
+
+
+	cil_symtab_get_datum(symtab, key, &datum);
+	if (datum != NULL) {
+		cil_log(CIL_INFO, "cil_copy_permissionx: permissionx cannot be redefined\n");
+		return SEPOL_ERR;
+	}
+
+	cil_permissionx_init(&new);
+	cil_copy_fill_permissionx(db, orig, new);
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
+
+int cil_copy_avrulex(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_avrulex *orig = data;
+	struct cil_avrulex *new = NULL;
+
+	cil_avrulex_init(&new);
+
+	new->rule_kind = orig->rule_kind;
+	new->src_str = orig->src_str;
+	new->tgt_str = orig->tgt_str;
+
+	if (new->permx_str != NULL) {
+		new->permx_str = orig->permx_str;
+	} else {
+		cil_permissionx_init(&new->permx);
+		cil_copy_fill_permissionx(db, orig->permx, new->permx);
+	}
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int cil_copy_type_rule(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_type_rule  *orig = data;
@@ -1732,6 +1785,12 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_AVRULE:
 		copy_func = &cil_copy_avrule;
 		break;
+	case CIL_AVRULEX:
+		copy_func = &cil_copy_avrulex;
+		break;
+	case CIL_PERMISSIONX:
+		copy_func = &cil_copy_permissionx;
+		break;
 	case CIL_TYPE_RULE:
 		copy_func = &cil_copy_type_rule;
 		break;
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index d839f68..79483c7 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -83,6 +83,7 @@ enum cil_flavor {
 	CIL_SIDORDER,
 	CIL_ROLEALLOW,
 	CIL_AVRULE,
+	CIL_AVRULEX,
 	CIL_ROLETRANSITION,
 	CIL_TYPE_RULE,
 	CIL_NAMETYPETRANSITION,
@@ -180,6 +181,7 @@ enum cil_flavor {
 	CIL_CONTEXT,
 	CIL_IPADDR,
 	CIL_POLICYCAP,
+	CIL_PERMISSIONX
 };
 
 
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index abe52de..ec518bc 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -216,6 +216,11 @@ char *CIL_KEY_DEFAULTTYPE;
 char *CIL_KEY_ROOT;
 char *CIL_KEY_NODE;
 char *CIL_KEY_PERM;
+char *CIL_KEY_ALLOWX;
+char *CIL_KEY_AUDITALLOWX;
+char *CIL_KEY_DONTAUDITX;
+char *CIL_KEY_PERMISSIONX;
+char *CIL_KEY_IOCTL;
 
 /*
 	Symbol Table Array Indices
@@ -239,6 +244,7 @@ enum cil_sym_index {
 	CIL_SYM_POLICYCAPS,
 	CIL_SYM_IPADDRS,
 	CIL_SYM_NAMES,
+	CIL_SYM_PERMX,
 	CIL_SYM_NUM,
 	CIL_SYM_UNKNOWN,
 	CIL_SYM_PERMS	// Special case for permissions. This symtab is not included in arrays
@@ -554,6 +560,26 @@ struct cil_avrule {
 	struct cil_list *classperms;
 };
 
+#define CIL_PERMX_KIND_IOCTL 1
+struct cil_permissionx {
+	struct cil_symtab_datum datum;
+	uint32_t kind;
+	char *obj_str;
+	void *obj;
+	struct cil_list *expr_str;
+	ebitmap_t *perms;
+};
+
+struct cil_avrulex {
+	uint32_t rule_kind;
+	char *src_str;
+	void *src; /* type, alias, or attribute */
+	char *tgt_str;	
+	void *tgt; /* type, alias, or attribute */
+	char *permx_str;
+	struct cil_permissionx *permx;
+};
+
 #define CIL_TYPE_TRANSITION 16
 #define CIL_TYPE_MEMBER     32
 #define CIL_TYPE_CHANGE     64
@@ -930,6 +956,8 @@ void cil_condblock_init(struct cil_condblock **cb);
 void cil_tunable_init(struct cil_tunable **ciltun);
 void cil_tunif_init(struct cil_tunableif **tif);
 void cil_avrule_init(struct cil_avrule **avrule);
+void cil_avrulex_init(struct cil_avrulex **avrulex);
+void cil_permissionx_init(struct cil_permissionx **permx);
 void cil_type_rule_init(struct cil_type_rule **type_rule);
 void cil_roletransition_init(struct cil_roletransition **roletrans);
 void cil_roleallow_init(struct cil_roleallow **role_allow);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index e69b5a4..c4ea66a 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -682,6 +682,70 @@ exit:
 	return rc;
 }
 
+static int __evaluate_permissionx_expression(struct cil_permissionx *permx, struct cil_db *db)
+{
+	int rc;
+
+	permx->perms = cil_malloc(sizeof(*permx->perms));
+	ebitmap_init(permx->perms);
+
+	rc = __cil_expr_to_bitmap(permx->expr_str, permx->perms, 0x10000, db); // max is one more than 0xFFFF
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to expand permissionx expression\n");
+		ebitmap_destroy(permx->perms);
+		free(permx->perms);
+		permx->perms = NULL;
+	}
+
+	return rc;
+}
+
+static int __cil_permx_str_to_int(char *permx_str, uint16_t *val)
+{
+	char *endptr = NULL;
+	long lval = strtol(permx_str, &endptr, 0);
+
+	if (*endptr != '\0') {
+		cil_log(CIL_ERR, "permissionx value %s not valid number\n", permx_str);
+		goto exit;
+	}
+	if (lval < 0x0000 || lval > 0xFFFF) {
+		cil_log(CIL_ERR, "permissionx value %s must be between 0x0000 and 0xFFFF\n", permx_str);
+		goto exit;
+	}
+
+	*val = (uint16_t)lval;
+
+	return SEPOL_OK;
+
+exit:
+	return SEPOL_ERR;
+}
+
+static int __cil_permx_to_bitmap(struct cil_symtab_datum *datum, ebitmap_t *bitmap, __attribute__((unused)) struct cil_db *db)
+{
+	int rc = SEPOL_ERR;
+	uint16_t val;
+
+	ebitmap_init(bitmap);
+
+	rc = __cil_permx_str_to_int((char*)datum, &val);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	if (ebitmap_set_bit(bitmap, (unsigned int)val, 1)) {
+		cil_log(CIL_ERR, "Failed to set permissionx bit\n");
+		ebitmap_destroy(bitmap);
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 static int __cil_perm_to_bitmap(struct cil_symtab_datum *datum, ebitmap_t *bitmap, __attribute__((unused)) struct cil_db *db)
 {
 	struct cil_perm *perm = (struct cil_perm *)datum;
@@ -792,7 +856,7 @@ exit:
 	return rc;
 }
 
-static int __cil_expr_range_to_bitmap_helper(struct cil_list_item *i1, struct cil_list_item *i2, ebitmap_t *bitmap)
+static int __cil_cat_expr_range_to_bitmap_helper(struct cil_list_item *i1, struct cil_list_item *i2, ebitmap_t *bitmap)
 {
 	int rc = SEPOL_ERR;
 	struct cil_symtab_datum *d1 = i1->data;
@@ -832,6 +896,39 @@ exit:
 	return rc;
 }
 
+static int __cil_permissionx_expr_range_to_bitmap_helper(struct cil_list_item *i1, struct cil_list_item *i2, ebitmap_t *bitmap)
+{
+	int rc = SEPOL_ERR;
+	char *p1 = i1->data;
+	char *p2 = i2->data;
+	uint16_t v1;
+	uint16_t v2;
+	uint32_t i;
+
+	rc = __cil_permx_str_to_int(p1, &v1);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = __cil_permx_str_to_int(p2, &v2);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	for (i = v1; i <= v2; i++) {
+		if (ebitmap_set_bit(bitmap, i, 1)) {
+			cil_log(CIL_ERR, "Failed to set permissionx bit\n");
+			ebitmap_destroy(bitmap);
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 static int __cil_expr_to_bitmap_helper(struct cil_list_item *curr, enum cil_flavor flavor, ebitmap_t *bitmap, int max, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
@@ -860,6 +957,10 @@ static int __cil_expr_to_bitmap_helper(struct cil_list_item *curr, enum cil_flav
 		if (rc != SEPOL_OK) {
 			ebitmap_destroy(bitmap);
 		}	
+	} else if (flavor == CIL_PERMISSIONX) {
+		// permissionx expressions aren't resolved into anything, so curr->flavor
+		// is just a CIL_STRING, not a CIL_DATUM, so just check on flavor for those
+		rc = __cil_permx_to_bitmap(curr->data, bitmap, db);
 	}
 
 	return rc;
@@ -892,18 +993,27 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 				goto exit;
 			}
 		} else if (op == CIL_RANGE) {
-			if (flavor != CIL_CAT) {
-				cil_log(CIL_INFO, "Range operation only supported for categories\n");
+			if (flavor == CIL_CAT) {
+				ebitmap_init(&tmp);
+				rc = __cil_cat_expr_range_to_bitmap_helper(curr->next, curr->next->next, &tmp);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_INFO, "Failed to expand category range\n");
+					ebitmap_destroy(&tmp);
+					goto exit;
+				}
+			} else if (flavor == CIL_PERMISSIONX) {
+				ebitmap_init(&tmp);
+				rc = __cil_permissionx_expr_range_to_bitmap_helper(curr->next, curr->next->next, &tmp);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_INFO, "Failed to expand category range\n");
+					ebitmap_destroy(&tmp);
+					goto exit;
+				}
+			} else {
+				cil_log(CIL_INFO, "Range operation only supported for categories permissionx\n");
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-			ebitmap_init(&tmp);
-			rc = __cil_expr_range_to_bitmap_helper(curr->next, curr->next->next, &tmp);
-			if (rc != SEPOL_OK) {
-				cil_log(CIL_INFO, "Failed to expand category range\n");
-				ebitmap_destroy(&tmp);
-				goto exit;
-			}
 		} else {
 			rc = __cil_expr_to_bitmap_helper(curr->next, flavor, &b1, max, db);
 			if (rc != SEPOL_OK) {
@@ -1039,6 +1149,20 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, __attribute__((
 		}
 		break;
 	}
+	case CIL_AVRULEX: {
+		struct cil_avrulex *rule = node->data;
+		if (rule->permx_str == NULL) {
+			rc = __evaluate_permissionx_expression(rule->permx, db);
+			if (rc != SEPOL_OK) goto exit;
+		}
+		break;
+	}
+	case CIL_PERMISSIONX: {
+		struct cil_permissionx *permx = node->data;
+		rc = __evaluate_permissionx_expression(permx, db);
+		if (rc != SEPOL_OK) goto exit;
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index e68a2da..e260a22 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -320,6 +320,79 @@ exit:
 	return rc;
 }
 
+int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
+{
+	struct cil_symtab_datum *obj_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	permx->obj = (struct cil_class*)obj_datum;
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
+int cil_resolve_avrulex(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_args_resolve *args = extra_args;
+	struct cil_db *db = NULL;
+
+	struct cil_avrulex *rule = current->data;
+	struct cil_symtab_datum *src_datum = NULL;
+	struct cil_symtab_datum *tgt_datum = NULL;
+	struct cil_symtab_datum *permx_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	if (args != NULL) {
+		db = args->db;
+	}
+
+	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, args, &src_datum);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	rule->src = src_datum;
+	if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
+		cil_type_used(src_datum);
+	}
+		
+	if (rule->tgt_str == CIL_KEY_SELF) {
+		rule->tgt = db->selftype;
+	} else {
+		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rule->tgt = tgt_datum;
+		if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
+			cil_type_used(tgt_datum);
+		}
+	}
+
+	if (rule->permx_str != NULL) {
+		rc = cil_resolve_name(current, rule->permx_str, CIL_SYM_PERMX, args, &permx_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rule->permx = (struct cil_permissionx*)permx_datum;
+	} else {
+		rc = cil_resolve_permissionx(current, rule->permx, extra_args);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_type_rule *rule = current->data;
@@ -3121,6 +3194,12 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_AVRULE:
 			rc = cil_resolve_avrule(node, args);
 			break;
+		case CIL_AVRULEX:
+			rc = cil_resolve_avrulex(node, args);
+			break;
+		case CIL_PERMISSIONX:
+			rc = cil_resolve_permissionx(node, (struct cil_permissionx*)node->data, args);
+			break;
 		case CIL_TYPE_RULE:
 			rc = cil_resolve_type_rule(node, args);
 			break;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 62b88d0..065de88 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -179,8 +179,8 @@ int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, en
 		syntax_len = 2;
 		break;
 	case CIL_RANGE:
-		if (expr_flavor != CIL_CAT) {
-			cil_log(CIL_ERR,"Operator (%s) only valid for catset expression\n", (char*)current->data);
+		if (expr_flavor != CIL_CAT && expr_flavor != CIL_PERMISSIONX) {
+			cil_log(CIL_ERR,"Operator (%s) only valid for catset and permissionx expression\n", (char*)current->data);
 			goto exit;
 		}
 		syntax[1] = CIL_SYN_STRING;
-- 
2.4.3
