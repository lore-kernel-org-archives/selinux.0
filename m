Subject: Re: [PATCH] move module read/write code into libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122994854.5842.14.camel@localhost.localdomain>
References: <1122994854.5842.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 14:57:50 -0400
Message-Id: <1123009070.11904.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-02 at 11:00 -0400, Jason Tang wrote:
> With the newly agreed upon use of libsepol as "internal representation
> of data" it has become apparant that module read/write code really
> belongs in libsepol and not in libsemanage.  The following patch moves
> that logic into a new file libsepol/module.c.  It also corrects an
> outstanding error, by adding checkpolicy/test and
> policycoreutils/semodule_package into their parents' Makefile.

dismod doesn't compile in our tree (missing definitions related to
policycon).

I'm adding further compiler warning flags to libsepol, and have fixed
current occurrences of such warnings, and I'd suggest that libsemanage
do likewise (adding the same warning flags to it yields several
warnings).  Patch for libsepol is below.

Index: libsepol/include/sepol/conditional.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/conditional.h,v
retrieving revision 1.9
diff -u -p -r1.9 conditional.h
--- libsepol/include/sepol/conditional.h	13 Jul 2005 19:26:17 -0000	1.9
+++ libsepol/include/sepol/conditional.h	2 Aug 2005 18:02:35 -0000
@@ -81,7 +81,7 @@ typedef struct cond_node {
 	avrule_t *avtrue_list;
 	avrule_t *avfalse_list;
 	/* these fields are not written to binary policy */
-	int nbools;
+	unsigned int nbools;
 	uint32_t bool_ids[COND_MAX_BOOLS];
 	uint32_t expr_pre_comp;
 	/*                                               */
Index: libsepol/src/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/Makefile,v
retrieving revision 1.9
diff -u -p -r1.9 Makefile
--- libsepol/src/Makefile	18 Jul 2005 13:42:20 -0000	1.9
+++ libsepol/src/Makefile	2 Aug 2005 17:51:17 -0000
@@ -10,7 +10,7 @@ TARGET=libsepol.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS ?= -Wall
+CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 all: $(LIBA) $(LIBSO)
Index: libsepol/src/avrule_block.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/avrule_block.c,v
retrieving revision 1.1
diff -u -p -r1.1 avrule_block.c
--- libsepol/src/avrule_block.c	6 Jul 2005 17:24:54 -0000	1.1
+++ libsepol/src/avrule_block.c	2 Aug 2005 17:52:40 -0000
@@ -61,7 +61,7 @@ avrule_decl_t *avrule_decl_create(uint32
 }
 
 static void scope_index_destroy(scope_index_t *scope) {
-        int i;
+        unsigned int i;
         if (scope == NULL) {
                 return;
         }
Index: libsepol/src/conditional.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/conditional.c,v
retrieving revision 1.8
diff -u -p -r1.8 conditional.c
--- libsepol/src/conditional.c	6 Jul 2005 17:24:54 -0000	1.8
+++ libsepol/src/conditional.c	2 Aug 2005 18:06:32 -0000
@@ -58,8 +58,8 @@ void cond_optimize_lists(cond_list_t* cl
 }
 
 
-static int bool_present(int target, unsigned int bools[], int num_bools) {
-	int i = 0;
+static int bool_present(unsigned int target, unsigned int bools[], unsigned int num_bools) {
+	unsigned int i = 0;
 	int ret = 1;
 
 	if (num_bools > COND_MAX_BOOLS) {
@@ -71,7 +71,7 @@ static int bool_present(int target, unsi
 }
 
 static int same_bools(cond_node_t *a, cond_node_t *b) {
-	int i, x;
+	unsigned int i, x;
 	
 	x = a->nbools;
 
@@ -133,7 +133,7 @@ cond_node_t *cond_node_find(policydb_t *
                             cond_node_t *needle, cond_node_t *haystack,
                             int *was_created) {
 	cond_node_t *new_node;
-	int i;
+	unsigned int i;
 
 	while(haystack) {
 		if (cond_expr_equal(needle,haystack)) {
@@ -309,7 +309,8 @@ int cond_normalize_expr(policydb_t *p, c
 {
 	cond_expr_t *ne,*e;
 	cond_av_list_t *tmp;
-	int i, j, k, orig_value[COND_MAX_BOOLS];
+	unsigned int i, j, orig_value[COND_MAX_BOOLS];
+	int k;
 	uint32_t test = 0x0;
 	avrule_t *tmp2;
 
@@ -372,7 +373,7 @@ int cond_normalize_expr(policydb_t *p, c
 		}
 		
 		/* loop through all possible combinations of values for bools in expression */
-		for(test = 0x0; test < (0x1 << cn->nbools) ; test++) {
+		for(test = 0x0; test < (0x1U << cn->nbools) ; test++) {
 			/* temporarily set the value for all the bools in the
 			 * expression using the corr.  bit in test */
 			for(j = 0; j < cn->nbools; j++) {
@@ -479,7 +480,7 @@ int cond_init_bool_indexes(policydb_t *p
 	return 0;
 }
 
-int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p)
+int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		free(key);
@@ -511,7 +512,7 @@ static int bool_isvalid(cond_bool_datum_
 	return 1;
 }
 
-int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp)
+int cond_read_bool(policydb_t *p __attribute__ ((unused)), hashtab_t h, struct policy_file *fp)
 {
 	char *key = 0;
 	cond_bool_datum_t *booldatum;
Index: libsepol/src/constraint.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/constraint.c,v
retrieving revision 1.2
diff -u -p -r1.2 constraint.c
--- libsepol/src/constraint.c	26 Jul 2005 15:45:32 -0000	1.2
+++ libsepol/src/constraint.c	2 Aug 2005 18:06:39 -0000
@@ -35,7 +35,7 @@ void constraint_expr_destroy(constraint_
         }
 }
 
-static int expand_constraint_bit(constraint_expr_t *expr, constraint_expr_t *dest_expr,
+static int expand_constraint_bit(constraint_expr_t *expr __attribute__ ((unused)), constraint_expr_t *dest_expr,
                                  int bit, uint32_t *typemap) {
         if (typemap != NULL) {
                 if (ebitmap_set_bit(&dest_expr->names, typemap[bit] - 1, 1)) {
@@ -50,10 +50,10 @@ static int expand_constraint_bit(constra
         return 0;
 }
 
-int expand_constraint(constraint_expr_t *expr, constraint_expr_t *dest_expr,
+int expand_constraint(constraint_expr_t *expr __attribute__ ((unused)), constraint_expr_t *dest_expr,
                       uint32_t *typemap, policydb_t *pol) {
          ebitmap_t e;
-         int i, j;
+         unsigned int i, j;
          if (type_set_expand(expr->type_names, &e, pol)) {
                  ebitmap_destroy(&e);
                  return -1;
Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.1
diff -u -p -r1.1 expand.c
--- libsepol/src/expand.c	6 Jul 2005 17:24:54 -0000	1.1
+++ libsepol/src/expand.c	2 Aug 2005 18:07:17 -0000
@@ -44,6 +44,9 @@ typedef struct expand_state {
 
 /* Write an error message to the current error buffer, up to the
  * buffer's specified size. */
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
 static void write_error (expand_state_t *state, char *fmt, ...) {
         va_list ap;
         if (state->error_buf == NULL) {
@@ -671,7 +674,7 @@ static int cats_copy_callback(hashtab_ke
 
 static int copy_role_allows(expand_state_t *state, role_allow_rule_t *rules)
 {
-	int i, j;
+	unsigned int i, j;
 	role_allow_t *cur_allow, *n, *l;
 	role_allow_rule_t *cur;
 	ebitmap_t roles, new_roles;
@@ -734,7 +737,7 @@ static int copy_role_allows(expand_state
 
 static int copy_role_trans(expand_state_t *state, role_trans_rule_t *rules)
 {
-	int i, j;
+	unsigned int i, j;
 	role_trans_t *n, *l, *cur_trans;
 	role_trans_rule_t *cur;
 	ebitmap_t roles, types;
@@ -1054,7 +1057,8 @@ static int expand_rule_helper(policydb_t
                               int enabled, char **error_msg,
                               ebitmap_t *stypes, ebitmap_t *ttypes)
 {
-        int i, j, retval;
+	unsigned int i, j;
+	int retval;
         for (i = ebitmap_startbit(stypes); i < ebitmap_length(stypes); i++) {
                 if (!ebitmap_get_bit(stypes, i))
                         continue;
@@ -1214,7 +1218,7 @@ static int context_copy(context_struct_t
 
 static int ocontext_copy(expand_state_t *state)
 {
-	int i, j;
+	unsigned int i, j;
 	ocontext_t *c, *n, *l;
 	
 	for (i = 0; i < OCON_NUM; i++) {	
@@ -1384,7 +1388,7 @@ static int type_attr_remove(hashtab_key_
 
 int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types)
 {
-        int i;
+        unsigned int i;
         ebitmap_t tmp;
         
         ebitmap_init(types);
@@ -1439,7 +1443,7 @@ int expand_rule(policydb_t *source_pol,
 
 int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p)
 {
-        int i;
+        unsigned int i;
 
         ebitmap_init(r);
 
@@ -1477,7 +1481,7 @@ int role_set_expand(role_set_t *x, ebitm
  */
 int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p)
 {
-        int i;
+        unsigned int i;
         ebitmap_t types, neg_types;
 
         ebitmap_init(&types);
Index: libsepol/src/genusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/genusers.c,v
retrieving revision 1.16
diff -u -p -r1.16 genusers.c
--- libsepol/src/genusers.c	26 Jul 2005 15:51:13 -0000	1.16
+++ libsepol/src/genusers.c	2 Aug 2005 18:08:50 -0000
@@ -21,6 +21,9 @@ void sepol_debug(int on) { 
 	sepol_debug_compat(on);
 };
 
+#ifdef __GNUC__
+__attribute__ ((format (printf, 1, 2)))
+#endif
 void __sepol_debug_printf(const char *fmt, ...) {
 	if (gdebug) {
 		va_list ap;
@@ -281,7 +284,7 @@ static int load_users(struct policydb *p
 
 /* Select users for removal based on whether they were defined in the
    new users configuration. */
-static int select_user(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int select_user(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *datap __attribute__ ((unused)))
 {
 	user_datum_t *usrdatum = datum;
 	
@@ -319,13 +322,13 @@ static void kill_user(hashtab_key_t key,
    As the SID table is remapped by the kernel upon a policy reload,
    this is safe for existing SIDs.  But it could be a problem for
    constraints if they refer to the particular user.  */
-static int remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int remap_users(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p)
 {
 	user_datum_t *usrdatum = datum;
 	struct kill_user_data *kud = p;
 	struct policydb *pol = kud->policydb;
 	ebitmap_t *free_users = kud->free_users;
-	int i;
+	unsigned int i;
 
 	if (usrdatum->value > pol->p_users.nprim) {
 		for (i = ebitmap_startbit(free_users); i < ebitmap_length(free_users); i++) {
Index: libsepol/src/hierarchy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/hierarchy.c,v
retrieving revision 1.5
diff -u -p -r1.5 hierarchy.c
--- libsepol/src/hierarchy.c	18 Jul 2005 13:51:21 -0000	1.5
+++ libsepol/src/hierarchy.c	2 Aug 2005 18:09:24 -0000
@@ -73,7 +73,7 @@ static int find_parent(char *type, char 
 /* This function verifies that the type passed in either has a parent or is in the 
  * root of the namespace, 0 on success, 1 on orphan and -1 on error
  */
-static int check_type_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d, void *args)
+static int check_type_hierarchy_callback(hashtab_key_t k __attribute__ ((unused)), hashtab_datum_t d, void *args)
 {
 	char *parent;
 	hierarchy_args_t *a;
@@ -280,7 +280,7 @@ static int check_cond_avtab_hierarchy(co
  * This function should be called with hashtab_map, it will return 0 on success, 1 on 
  * constraint violation and -1 on error
  */
-static int check_role_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d, void *args)
+static int check_role_hierarchy_callback(hashtab_key_t k __attribute__ ((unused)), hashtab_datum_t d, void *args)
 {
 	char *parent;
 	hierarchy_args_t *a;
Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.1
diff -u -p -r1.1 link.c
--- libsepol/src/link.c	6 Jul 2005 17:24:54 -0000	1.1
+++ libsepol/src/link.c	2 Aug 2005 18:13:50 -0000
@@ -107,6 +107,9 @@ static int add_i_to_a(uint32_t i, uint32
 
 /* Write an error message to the current error buffer, up to the
  * buffer's specified size. */
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
 static void write_error(link_state_t *state, char *fmt, ...) {
         va_list ap;
         if (state->error_buf == NULL) {
@@ -121,7 +124,7 @@ static void write_error(link_state_t *st
  * structure within, as well as the pointer itself. */
 static void policy_module_destroy(policy_module_t *mod)
 {
-        int i;
+        unsigned int i;
         if (mod == NULL) {
                 return;
         }
@@ -557,9 +560,9 @@ static int alias_copy_callback(hashtab_k
 /*********** callbacks that fix bitmaps ***********/
 
 static int type_set_convert(type_set_t *types, type_set_t *dst,
-                            policy_module_t *mod, link_state_t *state)
+                            policy_module_t *mod, link_state_t *state __attribute__ ((unused)))
 {
-	int i;
+	unsigned int i;
         for (i = ebitmap_startbit(&types->types); i < ebitmap_length(&types->types); i++) {
                 if (ebitmap_get_bit(&types->types, i)) {
                         assert(mod->map[SYM_TYPES][i]);
@@ -611,7 +614,7 @@ static int type_set_or_convert(type_set_
 static int role_set_or_convert(role_set_t *roles, role_set_t *dst,
                                policy_module_t *mod, link_state_t *state)
 {
-	int i;
+	unsigned int i;
 	ebitmap_t tmp;
 
 	ebitmap_init(&tmp);
@@ -637,7 +640,7 @@ static int role_set_or_convert(role_set_
 
 static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-        int i;
+        unsigned int i;
         char *id = key;
         role_datum_t *role, *dest_role = NULL;
 	link_state_t *state = (link_state_t *)data;
@@ -680,7 +683,7 @@ static int role_fix_callback(hashtab_key
 
 static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-        int i;
+        unsigned int i;
         char *id = key;
         type_datum_t *type, *new_type = NULL;
 	link_state_t *state = (link_state_t *)data;
@@ -1105,7 +1108,7 @@ static int copy_module_identifiers(link_
 
 static int copy_scope_index(scope_index_t *src, scope_index_t *dest,
                             policy_module_t *module, link_state_t *state) {
-        int i, j;
+        unsigned int i, j;
         uint32_t largest_mapped_class_value = 0;
         /* copy the scoping information for this avrule decl block */
         for (i = 0; i < SYM_NUM; i++) {
@@ -1223,7 +1226,8 @@ static int copy_avrule_block(link_state_
 
 static int scope_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-        int i, ret;
+	unsigned int i;
+	int ret;
         char *id = key, *new_id = NULL;
         scope_datum_t *scope, *base_scope;
 	link_state_t *state = (link_state_t *)data;
@@ -1377,7 +1381,7 @@ static int is_decl_requires_met(link_sta
          * redundant checks.  A very obvious improvement is to cache
          * which symbols have been verified, so that they do not need
          * to be re-checked.) */
-        int i, j;
+        unsigned int i, j;
         ebitmap_t *bitmap;
         char *id, *perm_id;
         policydb_t *pol = state->base;
@@ -1560,7 +1564,7 @@ int merge_avrules(link_state_t *state, a
         block = block->next; /* start with the first non-base block */
         while (block != NULL) {
                 avrule_decl_t *decl = block->enabled;
-                int i, j;
+                unsigned int i, j;
 
                 block = block->next;
                 if (decl == NULL) {
@@ -1678,7 +1682,7 @@ static int check_symbol_used(hashtab_key
         /* if the scope is declared and at least one of its decls is
          * enabled then don't remove this symbol */
         if (scope->scope == SCOPE_DECL) {
-                int i;
+                unsigned int i;
                 for (i = 0; i < scope->decl_ids_len; i++) {
                         avrule_decl_t *decl = state->decl_id_to_decl[scope->decl_ids[i]];
                         if (decl->enabled) {
Index: libsepol/src/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/mls.c,v
retrieving revision 1.7
diff -u -p -r1.7 mls.c
--- libsepol/src/mls.c	20 May 2005 15:27:48 -0000	1.7
+++ libsepol/src/mls.c	2 Aug 2005 18:24:56 -0000
@@ -43,7 +43,7 @@
  */
 int mls_compute_context_len(policydb_t *policydb, context_struct_t * context)
 {
-	int i, l, len, range;
+	unsigned int i, l, len, range;
 
 	if (!mls_enabled)
 		return 0;
@@ -95,7 +95,7 @@ void mls_sid_to_context(policydb_t *poli
                         char **scontext)
 {
 	char *scontextp;
-	int i, l, range, wrote_sep;
+	unsigned int i, l, range, wrote_sep;
 
 	if (!mls_enabled)
 		return;
@@ -174,7 +174,7 @@ int mls_context_isvalid(policydb_t *p, c
 {
 	level_datum_t *levdatum;
 	user_datum_t *usrdatum;
-	int i, l;
+	unsigned int i, l;
 
 	if (!mls_enabled)
 		return 1;
@@ -245,7 +245,8 @@ int mls_context_to_sid(policydb_t *polic
 	char *scontextp, *p, *rngptr;
 	level_datum_t *levdatum;
 	cat_datum_t *catdatum, *rngdatum;
-	int l, rc = -EINVAL;
+	unsigned int l;
+	int rc = -EINVAL;
 
 	if (!mls_enabled)
 		return 0;
@@ -305,7 +306,7 @@ int mls_context_to_sid(policydb_t *polic
 
 				/* If range, set all categories in range */
 				if (rngptr) {
-					int i;
+					unsigned int i;
 
 					rngdatum = (cat_datum_t *)hashtab_search(policydb->p_cats.table, (hashtab_key_t)rngptr);
 					if (!rngdatum) {
@@ -464,7 +465,7 @@ int mls_convert_context(policydb_t * old
 	level_datum_t *levdatum;
 	cat_datum_t *catdatum;
 	ebitmap_t bitmap;
-	int l, i;
+	unsigned int l, i;
 
 	if (!mls_enabled)
 		return 0;
Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.18
diff -u -p -r1.18 policydb.c
--- libsepol/src/policydb.c	26 Jul 2005 17:22:20 -0000	1.18
+++ libsepol/src/policydb.c	2 Aug 2005 18:25:41 -0000
@@ -135,9 +135,10 @@ int sepol_mls_enabled(void)
 	return mls_enabled;
 }
 
-struct policydb_compat_info *policydb_lookup_compat(int version, int type)
+struct policydb_compat_info *policydb_lookup_compat(unsigned int version, 
+						    unsigned int type)
 {
-	int i;
+	unsigned int i;
 	struct policydb_compat_info *info = NULL;
 	
 	for (i = 0; i < sizeof(policydb_compat)/sizeof(*info); i++) {
@@ -413,7 +414,7 @@ out_free_symtab:
 	goto out;
 }
 
-int policydb_role_cache(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+int policydb_role_cache(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *arg)
 {
 	policydb_t *p;
 	role_datum_t *role;
@@ -428,7 +429,7 @@ int policydb_role_cache(hashtab_key_t ke
 	return 0;
 }
 
-int policydb_user_cache(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+int policydb_user_cache(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *arg)
 {
 	policydb_t *p;
 	user_datum_t *user;
@@ -784,7 +785,7 @@ static int class_destroy(hashtab_key_t k
 	return 0;
 }
 
-static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	free(key);
 	role_datum_destroy((role_datum_t*)datum);
@@ -792,7 +793,7 @@ static int role_destroy(hashtab_key_t ke
 	return 0;
 }
 
-static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	free(key);
 	type_datum_destroy((type_datum_t*) datum);
@@ -808,7 +809,7 @@ static int user_destroy(hashtab_key_t ke
 	return 0;
 }
 
-static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	level_datum_t *levdatum;
 
@@ -821,7 +822,7 @@ static int sens_destroy(hashtab_key_t ke
 	return 0;
 }
 
-static int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		free(key);
@@ -941,7 +942,7 @@ void symtabs_destroy(symtab_t *symtab) {
 	}
 }
 
-int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
+int scope_destroy(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
         scope_datum_t *cur = (scope_datum_t *) datum;
         if (cur != NULL) {
@@ -1206,7 +1207,8 @@ static int common_read(policydb_t * p, h
 	return -1;
 }
 
-static int read_cons_helper(policydb_t *p, constraint_node_t **nodep, int ncons,
+static int read_cons_helper(policydb_t *p, constraint_node_t **nodep, 
+			    unsigned int ncons,
                             int allowxtarget, void *fp)
 {
 	constraint_node_t *c, *lc;
@@ -1509,7 +1511,7 @@ static int type_read(policydb_t * p __at
 
 int role_trans_read(role_trans_t **t, struct policy_file *fp)
 {                       
-        int i;
+        unsigned int i;
         uint32_t *buf, nel;
         role_trans_t *tr, *ltr;
                                 
@@ -1542,7 +1544,7 @@ int role_trans_read(role_trans_t **t, st
 
 int role_allow_read(role_allow_t **r, struct policy_file *fp)
 {
-        int i;
+        unsigned int i;
         uint32_t *buf, nel;
         role_allow_t *ra, *lra;
 
@@ -1865,7 +1867,7 @@ bad:
 	return -1;
 }
 
-static int sens_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
+static int sens_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	level_datum_t *levdatum;
@@ -1906,7 +1908,7 @@ bad:
 	return -1;
 }
 
-static int cat_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
+static int cat_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	cat_datum_t *catdatum;
@@ -1958,9 +1960,9 @@ static int (*read_f[SYM_NUM]) (policydb_
 
 /************** module reading functions below **************/
 
-static avrule_t *avrule_read(policydb_t *p, struct policy_file *fp)
+static avrule_t *avrule_read(policydb_t *p __attribute__ ((unused)), struct policy_file *fp)
 {                       
-        int i;                  
+        unsigned int i;                  
         uint32_t *buf, len;
         class_perm_node_t *cur, *tail = NULL;
         avrule_t *avrule;
@@ -2053,7 +2055,7 @@ static int range_read(policydb_t *p, str
 int avrule_read_list(policydb_t *p, avrule_t **avrules,
                      struct policy_file *fp)
 {
-        int i;
+        unsigned int i;
         avrule_t *cur, *tail;
         uint32_t *buf, len;
 
@@ -2085,7 +2087,7 @@ int avrule_read_list(policydb_t *p, avru
 static int role_trans_rule_read(role_trans_rule_t **r, struct policy_file *fp)
 {
         uint32_t *buf, nel;
-        int i;
+        unsigned int i;
         role_trans_rule_t *tr, *ltr;
 
         buf = next_entry(fp, sizeof(uint32_t));
@@ -2122,7 +2124,7 @@ static int role_trans_rule_read(role_tra
 
 static int role_allow_rule_read(role_allow_rule_t **r, struct policy_file *fp)
 {
-        int i;
+        unsigned int i;
         uint32_t *buf, nel;
         role_allow_rule_t *ra, *lra;
 
@@ -2155,10 +2157,11 @@ static int role_allow_rule_read(role_all
         return 0;
 }
 
-static int scope_index_read(scope_index_t *scope_index, int num_scope_syms,
+static int scope_index_read(scope_index_t *scope_index, 
+			    unsigned int num_scope_syms,
                             struct policy_file *fp)
 {
-        int i;
+        unsigned int i;
         uint32_t *buf;
         for (i = 0; i < num_scope_syms; i++) {
                 if (ebitmap_read(scope_index->scope + i, fp) == -1) {
@@ -2186,9 +2189,9 @@ static int scope_index_read(scope_index_
 }
 
 static int avrule_decl_read(policydb_t *p, avrule_decl_t *decl,
-                            int num_scope_syms, struct policy_file *fp) {
+                            unsigned int num_scope_syms, struct policy_file *fp) {
         uint32_t *buf, nprim, nel;
-        int i, j;
+        unsigned int i, j;
         if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
                 return -1;
         }
@@ -2222,7 +2225,7 @@ static int avrule_decl_read(policydb_t *
 }
 
 static int avrule_block_read(policydb_t *p,
-                             avrule_block_t **block, int num_scope_syms,
+                             avrule_block_t **block, unsigned int num_scope_syms,
                              struct policy_file *fp)
 {
         avrule_block_t *last_block, *curblock;
@@ -2292,7 +2295,7 @@ static int scope_read(policydb_t * p, ha
 	uint32_t *buf;
         char *key = NULL;
         size_t key_len;
-        int i;
+        unsigned int i;
 
         if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
                 goto cleanup;
@@ -2356,7 +2359,7 @@ int policydb_read(policydb_t * p, struct
 	size_t len, nprim, nel;
 	char *policydb_str, *target_str = NULL;
 	struct policydb_compat_info *info;
-        int policy_type, bufindex;
+        unsigned int policy_type, bufindex;
 
 	config = 0;
 
Index: libsepol/src/private.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/private.h,v
retrieving revision 1.8
diff -u -p -r1.8 private.h
--- libsepol/src/private.h	13 Jul 2005 19:17:00 -0000	1.8
+++ libsepol/src/private.h	2 Aug 2005 18:20:02 -0000
@@ -20,13 +20,16 @@
 
 /* Policy compatibility information. */
 struct policydb_compat_info {
-	int type;
-        int version;
-	int sym_num;
-	int ocon_num;
+	unsigned int type;
+        unsigned int version;
+	unsigned int sym_num;
+	unsigned int ocon_num;
 };
 
-extern struct policydb_compat_info *policydb_lookup_compat(int version, int type);
+extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version, unsigned int type);
+#ifdef __GNUC__
+__attribute__ ((format (printf, 1, 2)))
+#endif
 extern void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
Index: libsepol/src/services.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/services.c,v
retrieving revision 1.18
diff -u -p -r1.18 services.c
--- libsepol/src/services.c	2 Aug 2005 13:00:33 -0000	1.18
+++ libsepol/src/services.c	2 Aug 2005 18:22:22 -0000
@@ -943,7 +943,11 @@ int sepol_load_policy(void * data, size_
 	convert_context_args_t args;
 	uint32_t seqno;
 	int rc = 0;
-	struct policy_file file = { 0, data, len }, *fp = &file;
+	struct policy_file file = { 
+	  .type = PF_USE_MEMORY, 
+	  .data = data, 
+	  .len = len,
+	  .fp = NULL }, *fp = &file;
 
 	if (policydb_read(&newpolicydb, fp, 1)) {
 		return -EINVAL;
Index: libsepol/src/user_record.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/user_record.c,v
retrieving revision 1.2
diff -u -p -r1.2 user_record.c
--- libsepol/src/user_record.c	2 Aug 2005 13:06:46 -0000	1.2
+++ libsepol/src/user_record.c	2 Aug 2005 18:26:47 -0000
@@ -19,7 +19,7 @@ struct sepol_user {
 	char** roles;
 
 	/* The number of roles */
-	int num_roles;
+	unsigned int num_roles;
 
 	/* The default role */
 	char* def_role;
@@ -151,7 +151,7 @@ int sepol_user_add_role(sepol_user_t use
 }
 
 int sepol_user_has_role(sepol_user_t user, const char* role) {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < user->num_roles; i++)
 		if (!strcmp(user->roles[i], role)) 
@@ -164,7 +164,7 @@ int sepol_user_set_roles(
 	const char** roles_arr,
 	size_t num_roles) {
 
-	int i;
+	unsigned int i;
 	char** tmp_roles =
 		(char**) calloc(1, sizeof(char*) * num_roles);
 	if (!tmp_roles) 
@@ -198,7 +198,7 @@ int sepol_user_get_roles(
 	const char*** roles_arr, 
 	size_t* num_roles) {
 
-	int i;	
+	unsigned int i;	
 	const char** tmp_roles = 
 		(const char**) malloc(sizeof (char*) * user->num_roles);
 	if (!tmp_roles)
@@ -219,7 +219,7 @@ int sepol_user_get_roles(
 }
 
 int sepol_user_del_role(sepol_user_t user, const char* role) {
-	int i;
+	unsigned int i;
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
 
@@ -301,7 +301,7 @@ int sepol_user_create(sepol_user_t* user
 /* Deep copy clone */
 int sepol_user_clone(sepol_user_t user, sepol_user_t* user_ptr) {
 	sepol_user_t new_user = NULL;
-	int i;
+	unsigned int i;
 
 	if (sepol_user_create(&new_user) < 0)
 		goto err;
@@ -336,7 +336,7 @@ int sepol_user_clone(sepol_user_t user, 
 
 /* Destroy */
 void sepol_user_free(sepol_user_t user) {
-	int i;
+	unsigned int i;
 
 	if (!user)
 		return;
Index: libsepol/src/users.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/users.c,v
retrieving revision 1.3
diff -u -p -r1.3 users.c
--- libsepol/src/users.c	2 Aug 2005 13:00:34 -0000	1.3
+++ libsepol/src/users.c	2 Aug 2005 18:24:06 -0000
@@ -20,7 +20,9 @@ void sepol_set_delusers(int on) {
 /* Select users for removal based on whether they were defined in the
    new users configuration. */
 static int select_user(
-	hashtab_key_t key, hashtab_datum_t datum, void *datap) {
+	hashtab_key_t key __attribute__ ((unused)), 
+	hashtab_datum_t datum, 
+	void *datap __attribute__ ((unused))) {
 	user_datum_t *usrdatum = datum;
 
 	if (!usrdatum->defined)
@@ -167,7 +169,7 @@ int sepol_user_load(policydb_t* policydb
 	/* Low-level representation */
 	user_datum_t* usrdatum = NULL;
 	role_datum_t* roldatum;
-	int i;
+	unsigned int i;
 
 	context_struct_t context;
 	unsigned bit;
Index: libsepol/src/util.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/util.c,v
retrieving revision 1.2
diff -u -p -r1.2 util.c
--- libsepol/src/util.c	26 Jul 2005 15:45:33 -0000	1.2
+++ libsepol/src/util.c	2 Aug 2005 18:27:09 -0000
@@ -148,7 +148,8 @@ int symtab_insert(policydb_t *pol, uint3
                   uint32_t scope, uint32_t avrule_decl_id,
                   uint32_t *value)
 {
-        int rc, i, retval = 0;
+	int rc, retval = 0;
+	unsigned int i;
         scope_datum_t *scope_datum;
         
         /* check if the symbol is already there.  multiple
Index: libsepol/src/write.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/write.c,v
retrieving revision 1.12
diff -u -p -r1.12 write.c
--- libsepol/src/write.c	26 Jul 2005 17:06:37 -0000	1.12
+++ libsepol/src/write.c	2 Aug 2005 18:28:46 -0000
@@ -387,7 +387,7 @@ static int cond_write_bool(hashtab_key_t
 {
 	cond_bool_datum_t *booldatum;
 	uint32_t buf[3], len;
-	int items, items2;
+	unsigned int items, items2;
 	struct policy_file *fp = p;
 
 	booldatum = (cond_bool_datum_t*)datum;
@@ -829,7 +829,7 @@ static int (*write_f[SYM_NUM]) (hashtab_
 
 static int ocontext_write (struct policydb_compat_info *info, policydb_t * p,
                            struct policy_file * fp) {
-        int i, j;
+        unsigned int i, j;
         size_t nel, items, len;
 	uint32_t buf[32];
         ocontext_t *c;
@@ -1110,10 +1110,10 @@ static int role_allow_rule_write(role_al
 	return 0;
 }
 
-static int scope_index_write(scope_index_t *scope_index, int num_scope_syms,
+static int scope_index_write(scope_index_t *scope_index, unsigned int num_scope_syms,
                              struct policy_file *fp)
 {
-        int i;
+        unsigned int i;
         uint32_t buf[1];
         for (i = 0; i < num_scope_syms; i++) {
                 if (ebitmap_write(scope_index->scope + i, fp) == -1) {
@@ -1204,7 +1204,7 @@ static int scope_write(hashtab_key_t key
         struct policy_file *fp = (struct policy_file *) p;
         uint32_t static_buf[32], *dyn_buf = NULL, *buf;
         size_t key_len = strlen(key);
-        int items = 2 + scope->decl_ids_len, i;
+        unsigned int items = 2 + scope->decl_ids_len, i;
 
         if (items >= sizeof(buf)) {
                 /* too many things required, so dynamically create a



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
