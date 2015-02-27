Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1REpE8S002463
 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2015 09:51:14 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol: clean up the CIL API
Date: Fri, 27 Feb 2015 09:50:41 -0500
Message-ID: <1425048642-22860-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- No longer require the caller to create a sepol_policydb. CIL is now
  responsible for that
- Since the user is no longer responsible for creating the policydb, two
  functions are added to let CIL know how it should configure the
  policydb, to set the policy version and the target platform
- Some functions, like cil_compile, do not need a policydb. Additionally
  some functions, like cil_filecons_to_string use the policydb, but could
  be rewritten to not require it. In these cases, remove the policydb
  from the API, and rewrite functions so they don't depend on it. The
  only function that uses a policydb is cil_build_policydb
- Add functions and symbolic versioning to maintain binary backwards
  compatability. API backwards compatability is not maintained

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/include/cil/cil.h  |  12 ++--
 libsepol/cil/secilc.c           |  21 ++----
 libsepol/cil/src/cil.c          | 155 ++++++++++++++++++++++++++++++++++------
 libsepol/cil/src/cil_binary.c   |  67 ++++++++++++++++-
 libsepol/cil/src/cil_binary.h   |  18 ++++-
 libsepol/cil/src/cil_internal.h |   8 ++-
 libsepol/src/libsepol.map.in    |  14 +++-
 7 files changed, 246 insertions(+), 49 deletions(-)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 902ca3e..e4b10c5 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -40,16 +40,18 @@ extern void cil_db_destroy(cil_db_t **db);
 
 extern int cil_add_file(cil_db_t *db, char *name, char *data, size_t size);
 
-extern int cil_compile(cil_db_t *db, sepol_policydb_t *sepol_db);
-extern int cil_build_policydb(cil_db_t *db, sepol_policydb_t *sepol_db);
-extern int cil_userprefixes_to_string(cil_db_t *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
-extern int cil_selinuxusers_to_string(cil_db_t *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
-extern int cil_filecons_to_string(cil_db_t *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
+extern int cil_compile(cil_db_t *db);
+extern int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db);
+extern int cil_userprefixes_to_string(cil_db_t *db, char **out, size_t *size);
+extern int cil_selinuxusers_to_string(cil_db_t *db, char **out, size_t *size);
+extern int cil_filecons_to_string(cil_db_t *db, char **out, size_t *size);
 extern void cil_set_disable_dontaudit(cil_db_t *db, int disable_dontaudit);
 extern void cil_set_disable_neverallow(cil_db_t *db, int disable_neverallow);
 extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_tunables);
 extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
 extern void cil_set_mls(cil_db_t *db, int mls);
+extern void cil_set_target_platform(cil_db_t *db, int target_platform);
+extern void cil_set_policy_version(cil_db_t *db, int policy_version);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/secilc.c b/libsepol/cil/secilc.c
index 8f16c98..f4e32b3 100644
--- a/libsepol/cil/secilc.c
+++ b/libsepol/cil/secilc.c
@@ -204,6 +204,8 @@ int main(int argc, char *argv[])
 	}
 
 	cil_set_mls(db, mls);
+	cil_set_target_platform(db, target);
+	cil_set_policy_version(db, policyvers);
 
 	for (i = optind; i < argc; i++) {
 		file = fopen(argv[i], "r");
@@ -238,26 +240,13 @@ int main(int argc, char *argv[])
 		buffer = NULL;
 	}
 
-	rc = sepol_policydb_create(&pdb);
-	if (rc < 0) {
-		cil_log(CIL_ERR, "Failed to create policy db\n");
-		goto exit;
-	}
-	pdb->p.policy_type = POLICY_KERN;
-	pdb->p.target_platform = target;
-	
-	rc = sepol_policydb_set_vers(pdb, policyvers);
-	if (rc != 0) {
-		cil_log(CIL_ERR, "Failed to set policy version: %d\n", rc);
-		goto exit;
-	}
-	rc = cil_compile(db, pdb);
+	rc = cil_compile(db);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to compile cildb: %d\n", rc);
 		goto exit;
 	}
 
-	rc = cil_build_policydb(db, pdb);
+	rc = cil_build_policydb(db, &pdb);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to build policydb\n");
 		goto exit;
@@ -306,7 +295,7 @@ int main(int argc, char *argv[])
 
 	cil_log(CIL_INFO, "Writing file contexts\n");
 	
-	rc = cil_filecons_to_string(db, pdb, &fc_buf, &fc_size);
+	rc = cil_filecons_to_string(db, &fc_buf, &fc_size);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to get file context data\n");
 		goto exit;
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 0971bb3..a25f878 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -51,6 +51,21 @@
 #include "cil_policy.h"
 #include "cil_strpool.h"
 
+asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
+asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
+
+asm(".symver cil_compile_pdb,   cil_compile@");
+asm(".symver cil_compile_nopdb, cil_compile@@LIBSEPOL_1.1");
+
+asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@");
+asm(".symver cil_userprefixes_to_string_nopdb, cil_userprefixes_to_string@@LIBSEPOL_1.1");
+
+asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@");
+asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSEPOL_1.1");
+
+asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
+asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
+
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
 	{64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
@@ -249,6 +264,8 @@ void cil_db_init(struct cil_db **db)
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
+	(*db)->target_platform = SEPOL_TARGET_SELINUX;
+	(*db)->policy_version = POLICYDB_VERSION_MAX;
 }
 
 void cil_db_destroy(struct cil_db **db)
@@ -332,11 +349,11 @@ exit:
 	return rc;
 }
 
-int cil_compile(struct cil_db *db, sepol_policydb_t *sepol_db)
+int cil_compile_nopdb(struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 
-	if (db == NULL || sepol_db == NULL) {
+	if (db == NULL) {
 		goto exit;
 	}
 
@@ -376,7 +393,27 @@ exit:
 	return rc;
 }
 
-int cil_build_policydb(cil_db_t *db, sepol_policydb_t *sepol_db)
+int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
+{
+	return cil_compile_nopdb(db);
+}
+
+int cil_build_policydb_pdb(cil_db_t *db, sepol_policydb_t *sepol_db)
+{
+	int rc;
+
+	cil_log(CIL_INFO, "Building policy binary\n");
+	rc = cil_binary_create_allocated_pdb(db, sepol_db);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to generate binary\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
+int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
 {
 	int rc;
 
@@ -1059,7 +1096,7 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 	return "<unknown>";
 }
 
-int cil_userprefixes_to_string(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
+int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 {
 	int rc = SEPOL_ERR;
 	size_t str_len = 0;
@@ -1104,20 +1141,78 @@ exit:
 
 }
 
-static int cil_level_equals(policydb_t *pdb, struct cil_level *low, struct cil_level *high)
+int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
+{
+	return cil_userprefixes_to_string_nopdb(db, out, size);
+}
+
+static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitmap)
+{
+	int rc = SEPOL_ERR;
+	struct cil_list_item *i;
+	struct cil_list_item *j;
+	struct cil_cat* cat;
+	struct cil_catset *cs;
+	struct cil_tree_node *node;
+
+	if (cats == NULL) {
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	cil_list_for_each(i, cats->datum_expr) {
+		node = DATUM(i->data)->nodes->head->data;
+		if (node->flavor == CIL_CATSET) {
+			cs = (struct cil_catset*)i->data;
+			cil_list_for_each(j, cs->cats->datum_expr) {
+				cat = (struct cil_cat*)j->data;
+				rc = ebitmap_set_bit(cats_ebitmap, cat->value, 1);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}
+			}
+		} else {
+			cat = (struct cil_cat*)i->data;
+			rc = ebitmap_set_bit(cats_ebitmap, cat->value, 1);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
+static int cil_level_equals(struct cil_level *low, struct cil_level *high)
 {
-	mls_level_t l;
-	mls_level_t h;
 	int rc;
+	struct ebitmap elow;
+	struct ebitmap ehigh;
 
-	cil_level_to_mls_level(pdb, low, &l);
-	cil_level_to_mls_level(pdb, high, &h);
+	if (strcmp(low->sens->datum.fqn, high->sens->datum.fqn)) {
+		rc = 0;
+		goto exit;
+	}
 
-	rc = mls_level_eq(&l, &h);
+	ebitmap_init(&elow);
+	ebitmap_init(&ehigh);
 
-	mls_level_destroy(&l);
-	mls_level_destroy(&h);
+	rc = cil_cats_to_ebitmap(low->cats, &elow);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
 
+	rc = cil_cats_to_ebitmap(high->cats, &ehigh);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	return ebitmap_cmp(&elow, &ehigh);
+
+exit:
 	return rc;
 }
 
@@ -1236,7 +1331,7 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
 	return str_tmp - out;
 }
 
-int cil_selinuxusers_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char **out, size_t *size)
+int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 {
 	size_t str_len = 0;
 	int buf_pos = 0;
@@ -1255,7 +1350,7 @@ int cil_selinuxusers_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, ch
 
 		str_len += strlen(selinuxuser->name_str) + strlen(user->datum.fqn) + 1;
 
-		if (sepol_db->p.mls == CIL_TRUE) {
+		if (db->mls == CIL_TRUE) {
 			struct cil_levelrange *range = selinuxuser->range;
 			str_len += __cil_level_strlen(range->low) + __cil_level_strlen(range->high) + 2;
 		}
@@ -1274,7 +1369,7 @@ int cil_selinuxusers_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, ch
 		buf_pos = sprintf(str_tmp, "%s:%s", selinuxuser->name_str, user->datum.fqn);
 		str_tmp += buf_pos;
 
-		if (sepol_db->p.mls == CIL_TRUE) {
+		if (db->mls == CIL_TRUE) {
 			struct cil_levelrange *range = selinuxuser->range;
 			buf_pos = sprintf(str_tmp, ":");
 			str_tmp += buf_pos;
@@ -1293,7 +1388,12 @@ int cil_selinuxusers_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, ch
 	return SEPOL_OK;
 }
 
-int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char **out, size_t *size)
+int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
+{
+	return cil_selinuxusers_to_string_nopdb(db, out, size);
+}
+
+int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 {
 	uint32_t i = 0;
 	int buf_pos = 0;
@@ -1320,9 +1420,9 @@ int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char *
 
 			str_len += (strlen(user->datum.fqn) + strlen(role->datum.fqn) + strlen(type->datum.fqn) + 3);
 
-			if (sepol_db->p.mls == CIL_TRUE) {
+			if (db->mls == CIL_TRUE) {
 				struct cil_levelrange *range = ctx->range;
-				if (cil_level_equals(&sepol_db->p, range->low, range->high)) {
+				if (cil_level_equals(range->low, range->high)) {
 					str_len += __cil_level_strlen(range->low) + 1;
 				} else {
 					str_len += __cil_level_strlen(range->low) + __cil_level_strlen(range->high) + 2;
@@ -1385,14 +1485,14 @@ int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char *
 							  type->datum.fqn);
 			str_tmp += buf_pos;
 
-			if (sepol_db->p.mls == CIL_TRUE) {
+			if (db->mls == CIL_TRUE) {
 				struct cil_levelrange *range = ctx->range;
 				buf_pos = sprintf(str_tmp, ":");
 				str_tmp += buf_pos;
 				buf_pos = __cil_level_to_string(range->low, str_tmp);
 				str_tmp += buf_pos;
 
-				if (!cil_level_equals(&sepol_db->p, range->low, range->high)) {
+				if (!cil_level_equals(range->low, range->high)) {
 					buf_pos = sprintf(str_tmp, "-");
 					str_tmp += buf_pos;
 					buf_pos = __cil_level_to_string(range->high, str_tmp);
@@ -1411,6 +1511,11 @@ int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char *
 	return SEPOL_OK;
 }
 
+int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
+{
+	return cil_filecons_to_string_nopdb(db, out, size);
+}
+
 void cil_set_disable_dontaudit(struct cil_db *db, int disable_dontaudit)
 {
 	db->disable_dontaudit = disable_dontaudit;
@@ -1449,6 +1554,16 @@ void cil_set_mls(struct cil_db *db, int mls)
 	db->mls = mls;
 }
 
+void cil_set_target_platform(struct cil_db *db, int target_platform)
+{
+	db->target_platform = target_platform;
+}
+
+void cil_set_policy_version(struct cil_db *db, int policy_version)
+{
+	db->policy_version = policy_version;
+}
+
 void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM])
 {
 	uint32_t i = 0;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 8ee8f33..387237f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3320,7 +3320,7 @@ int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
 		goto exit;
 	}
 
-	if (pdb->target_platform == SEPOL_TARGET_XEN) {
+	if (db->target_platform == SEPOL_TARGET_XEN) {
 		rc = cil_pirqcon_to_policydb(pdb, db->pirqcon);
 		if (rc != SEPOL_OK) {
 			goto exit;
@@ -3550,10 +3550,42 @@ static void __cil_set_conditional_state_and_flags(policydb_t *pdb)
 	}
 }
 
+int __cil_policydb_create(const struct cil_db *db, struct sepol_policydb **spdb)
+{
+	int rc;
+	struct policydb *pdb = NULL;
+
+	rc = sepol_policydb_create(spdb);
+	if (rc < 0) {
+		cil_log(CIL_ERR, "Failed to create policy db\n");
+		// spdb could be a dangling pointer at this point, so reset it so
+		// callers of this function don't need to worry about freeing garbage
+		*spdb = NULL;
+		goto exit;
+	}
+
+	pdb = &(*spdb)->p;
+
+	pdb->policy_type = POLICY_KERN;
+	pdb->target_platform = db->target_platform;
+	pdb->policyvers = db->policy_version;
+	pdb->handle_unknown = db->handle_unknown;
+	pdb->mls = db->mls;
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
+
 int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 
+	// these flags should get set in __cil_policydb_create. However, for
+	// backwards compatability, it is possible that __cil_policydb_create is
+	// never called. So, they must also be set here.
 	pdb->handle_unknown = db->handle_unknown;
 	pdb->mls = db->mls;
 
@@ -3587,6 +3619,7 @@ int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db)
 	return SEPOL_OK;
 
 exit:
+
 	return rc;
 }
 
@@ -3641,7 +3674,34 @@ static int role_trans_compare(hashtab_t h
 	return a->role != b->role || a->type != b->type || a->tclass != b->tclass;
 }
 
-int cil_binary_create(const struct cil_db *db, sepol_policydb_t *policydb)
+int cil_binary_create(const struct cil_db *db, sepol_policydb_t **policydb)
+{
+	int rc = SEPOL_ERR;
+	struct sepol_policydb *pdb = NULL;
+
+	rc = __cil_policydb_create(db, &pdb);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = cil_binary_create_allocated_pdb(db, pdb);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	*policydb = pdb;
+
+	return SEPOL_OK;
+
+exit:
+	sepol_policydb_free(pdb);
+
+	return rc;
+}
+
+// assumes policydb is already allocated and initialized properly with things
+// like policy type set to kernel and version set appropriately
+int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *policydb)
 {
 	int rc = SEPOL_ERR;
 	int i;
@@ -3664,7 +3724,7 @@ int cil_binary_create(const struct cil_db *db, sepol_policydb_t *policydb)
 	rc = __cil_policydb_init(pdb, db);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR,"Problem in policydb_init\n");
-		return SEPOL_ERR;
+		goto exit;
 	}
 
 	filename_trans_table = hashtab_create(filename_trans_hash, filename_trans_compare, FILENAME_TRANS_TABLE_SIZE);
@@ -3740,5 +3800,6 @@ exit:
 	hashtab_destroy(range_trans_table);
 	hashtab_destroy(role_trans_table);
 	cil_neverallows_list_destroy(neverallows);
+
 	return rc;
 }
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index c3f0357..5045c6e 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -44,7 +44,23 @@
  *
  * @return SEPOL_OK upon success or an error otherwise.
  */
-int cil_binary_create(const struct cil_db *db, sepol_policydb_t *pdb);
+int cil_binary_create(const struct cil_db *db, sepol_policydb_t **pdb);
+
+/**
+ * Create a pre allocated binary policydb from the cil db.
+ *
+ * It is assumed that pdb has been allocated and initialzed so that fields such
+ * as policy type and version are set appropriately. It is reccomended that
+ * instead of calling this, one instead calls cil_binary_create, which will
+ * properly allocate and initialize the pdb and then calls this function. This
+ * funcion is used to maintain binary backwards compatability.
+ *
+ * @param[in] db The cil database.
+ * @param[in] pdb The policy database.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *pdb);
 
 /**
  * Insert cil common structure into sepol policydb.
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index f88864f..cf0a8b1 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -287,6 +287,8 @@ struct cil_db {
 	int preserve_tunables;
 	int handle_unknown;
 	int mls;
+	int target_platform;
+	int policy_version;
 };
 
 struct cil_root {
@@ -871,9 +873,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor);
 int cil_flavor_to_symtab_index(enum cil_flavor flavor, enum cil_sym_index *index);
 const char * cil_node_to_string(struct cil_tree_node *node);
 
-int cil_userprefixes_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
-int cil_selinuxusers_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
-int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char **out, size_t *size);
+int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size);
+int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size);
+int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size);
 
 void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM]);
 void cil_symtab_array_destroy(symtab_t symtab[]);
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index c18f57d..1285314 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -1,4 +1,4 @@
-{
+LIBSEPOL_1.0 {
   global: 
 	expand_module_avrules;
 	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
@@ -34,3 +34,15 @@
 	cil_set_malloc_error_handler;
   local: *;
 };
+
+LIBSEPOL_1.1 {
+  global:
+	cil_build_policydb;
+	cil_compile;
+	cil_userprefixes_to_string;
+	cil_selinuxusers_to_string;
+	cil_filecons_to_string;
+	cil_set_target_platform;
+	cil_set_policy_version;
+  local: *;
+} LIBSEPOL_1.0;
-- 
2.1.0
