Subject: [PATCH] mls in modules
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-WqnDoHciXY4IRivRAgDy"
Date: Fri, 30 Sep 2005 16:42:32 -0400
Message-Id: <1128112952.22583.25.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WqnDoHciXY4IRivRAgDy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch allows both base modules and modules to be built with the -M
(MLS) flag. For base modules it adds all the MLS components that are in
the normal policy. For modules it sets the MLS flag. The following
restrictions are currently placed on the policy:

- Users cannot be declared in MLS modules, because levels cannot be
'required'
- Only MLS modules can be linked to an MLS base and non MLS modules to a
non-MLS base.

Although the modules don't have any MLS components the policydb version
for both modules and base were bumped, this keeps the formats consistent
(ie, empty MLS fields in a non-mls policy)

To do this several changes had to be made; most notably mls_enabled is
no longer a global state in libsepol. Because we have multiple
policydb's loaded at one time, each with a potentially different value
for mls_enabled. There is now an mls field in the policydb struct which
represents whether that particular policydb is an mls policy. 

Second, context management functions were changed because they could not
determine MLS state from the global variable. Rather than try to
propagate MLS state to all of them we initialize the entire context
struct, including MLS portions every time. This should be a no-op in
non-mls cases (eg., ebitmap_cpy short circuits if highbit is 0)

Joshua 

--=-WqnDoHciXY4IRivRAgDy
Content-Disposition: attachment; filename=mls-in-modules.diff
Content-Type: text/x-patch; name=mls-in-modules.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn checkpolicy/checkmodule.c checkpolicy/checkmodule.c
--- checkpolicy/checkmodule.c	2005-09-23 15:02:52.000000000 -0400
+++ checkpolicy/checkmodule.c	2005-09-30 11:16:30.000000000 -0400
@@ -39,6 +39,7 @@ extern queue_t id_queue;
 extern unsigned int policydb_errors;
 extern unsigned long policydb_lineno;
 extern char source_file[];
+extern int mlspol;
 
 extern FILE *yyin;
 extern void init_parser(int);
@@ -50,7 +51,7 @@ static char *binfile = "policy";
 
 unsigned int policy_type = POLICY_BASE;
 unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
-unsigned int mlspol = 0;
+
 /* always set to 0 for checkpolicy, set to 1 for checkmodule */
 unsigned int is_building_modules = 1;
 
@@ -89,7 +90,7 @@ static int read_binary_policy(policydb_t
         }
         
         /* Check Policy Consistency */
-        if (sepol_mls_enabled()) {
+        if (p->mls) {
                 if (!mlspol) {
                         fprintf(stderr,"%s:  MLS policy, but non-MLS"
                                 " is specified\n", progname);
@@ -121,7 +122,9 @@ static int read_source_policy(policydb_t
                 fprintf(stderr, "%s: out of memory!\n", progname);
                 return -1;
         }
-        
+
+	p->mls = mlspol;
+
         init_parser(1);
         if (yyparse() || policydb_errors) {
                 fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", progname);
@@ -226,16 +229,14 @@ int main(int argc, char **argv)
                         policyvers = MOD_POLICYDB_VERSION_MAX;
 			break;
                 case 'M':
-                        fprintf(stderr, "checkmodule does not currently accept MLS policies\n");
-                        exit(1);
+			mlspol = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
 	}
 
 	if (show_version) {
-		printf("%d (compatibility range %d-%d)\n", policyvers, 
-                       POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
                 printf("Module versions %d-%d\n",
                        MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
 		exit(0);
diff -purN -x .svn checkpolicy/checkpolicy.c checkpolicy/checkpolicy.c
--- checkpolicy/checkpolicy.c	2005-09-23 15:03:52.000000000 -0400
+++ checkpolicy/checkpolicy.c	2005-09-30 11:16:30.000000000 -0400
@@ -91,6 +91,7 @@ extern queue_t id_queue;
 extern unsigned int policydb_errors;
 extern unsigned long policydb_lineno;
 extern char source_file[];
+extern int mlspol;
 
 extern FILE *yyin;
 extern void init_parser(int);
@@ -101,7 +102,6 @@ static char *txtfile = "policy.conf";
 static char *binfile = "policy";
 
 unsigned int policyvers = POLICYDB_VERSION_MAX;
-unsigned int mlspol = 0;
 
 /* always set to 0 for checkpolicy, set to 1 for checkmodule */
 unsigned int is_building_modules = 0;
@@ -504,7 +504,7 @@ int main(int argc, char **argv)
 		policydbp = &policydb;
 
 		/* Check Policy Consistency */
-		if (sepol_mls_enabled()) {
+		if (policydbp->mls) {
 			if (!mlspol) {
 				fprintf(stderr,"%s:  MLS policy, but non-MLS"
 				        " is specified\n", argv[0]);
@@ -532,7 +532,7 @@ int main(int argc, char **argv)
 			exit(1);
 
 		/* Let sepol know if we are dealing with MLS support */
-		sepol_set_mls(mlspol);
+		parse_policy.mls = mlspol;
 
 		id_queue = queue_create();
 		if (!id_queue) {
diff -purN -x .svn checkpolicy/checkpolicy.h checkpolicy/checkpolicy.h
--- checkpolicy/checkpolicy.h	2005-09-19 09:03:13.000000000 -0400
+++ checkpolicy/checkpolicy.h	2005-09-30 09:50:57.000000000 -0400
@@ -16,6 +16,5 @@ typedef struct te_assert { 
 te_assert_t *te_assertions;
 
 extern unsigned int policyvers;
-extern unsigned int mlspol;
 
 #endif
diff -purN -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-09-26 17:27:11.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-09-30 09:53:29.000000000 -0400
@@ -65,6 +65,7 @@ policydb_t *policydbp;
 queue_t id_queue = 0;
 static unsigned int pass;
 char *curfile = 0;
+int mlspol = 0;
 
 extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;
@@ -3639,6 +3640,11 @@ static int define_user(void)
 	level_datum_t *levdatum;
 	int l;
 
+	if (policydbp->policy_type == POLICY_MOD && mlspol) {
+		yyerror("Users cannot be declared in MLS modules");
+		return -1;
+	}
+
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
 			free(id);
diff -purN -x .svn libsepol/include/sepol/context.h libsepol/include/sepol/context.h
--- libsepol/include/sepol/context.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/include/sepol/context.h	2005-09-30 11:16:30.000000000 -0400
@@ -38,6 +38,10 @@ typedef struct context_struct {
 static inline void mls_context_init(context_struct_t * c)
 {
 	memset(&c->range, 0, sizeof(c->range));
+	memset(&c->range.level[0], 0, sizeof(c->range.level[0]));
+	memset(&c->range.level[1], 0, sizeof(c->range.level[1]));
+	ebitmap_init(&c->range.level[0].cat);
+	ebitmap_init(&c->range.level[1].cat);
 }
 
 static inline int mls_context_cpy(context_struct_t * dst, 
@@ -45,9 +49,6 @@ static inline int mls_context_cpy(contex
 {
 	int rc;
 
-	if (!sepol_mls_enabled())
-		return 0;
-
 	dst->range.level[0].sens = src->range.level[0].sens;
 	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
 	if (rc)
@@ -64,9 +65,6 @@ out:
 static inline int mls_context_cmp(context_struct_t * c1,
                                   context_struct_t * c2)
 {
-	if (!sepol_mls_enabled())
-		return 1;
-
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
 		ebitmap_cmp(&c1->range.level[0].cat,&c2->range.level[0].cat) &&
 		(c1->range.level[1].sens == c2->range.level[1].sens) &&
@@ -75,12 +73,9 @@ static inline int mls_context_cmp(contex
 
 static inline void mls_context_destroy(context_struct_t * c)
 {
-	if (!sepol_mls_enabled())
-		return;
-
 	ebitmap_destroy(&c->range.level[0].cat);
 	ebitmap_destroy(&c->range.level[1].cat);
-	mls_context_init(c);
+	memset(&c->range, 0, sizeof(c->range));
 }
 
 static inline void context_init(context_struct_t * c)
diff -purN -x .svn libsepol/include/sepol/mls.h libsepol/include/sepol/mls.h
--- libsepol/include/sepol/mls.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/include/sepol/mls.h	2005-09-30 10:06:06.000000000 -0400
@@ -61,7 +61,7 @@ extern int mls_compute_sid(policydb_t *p
 
 extern int mls_setup_user_range(
 	context_struct_t *fromcon, user_datum_t *user,
-	context_struct_t *usercon);
+	context_struct_t *usercon, int mls);
 
 #endif	/* _MLS_H_ */
 
diff -purN -x .svn libsepol/include/sepol/mls_types.h libsepol/include/sepol/mls_types.h
--- libsepol/include/sepol/mls_types.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/include/sepol/mls_types.h	2005-09-30 11:16:30.000000000 -0400
@@ -44,22 +44,14 @@ typedef struct mls_range {
 	mls_level_t level[2]; /* low == level[0], high == level[1] */
 } mls_range_t;
 
-extern int sepol_mls_enabled(void);
-
 static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 {
-	if (!sepol_mls_enabled())
-		return 1;
-
 	return ((l1->sens == l2->sens) &&
 	        ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
 static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 {
-	if (!sepol_mls_enabled())
-		return 1;
-
 	return ((l1->sens >= l2->sens) &&
 	        ebitmap_contains(&l1->cat, &l2->cat));
 }
diff -purN -x .svn libsepol/include/sepol/policydb.h libsepol/include/sepol/policydb.h
--- libsepol/include/sepol/policydb.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/include/sepol/policydb.h	2005-09-30 10:06:06.000000000 -0400
@@ -360,6 +360,9 @@ typedef struct policydb {
 	uint32_t policy_type;
 	char *name;
 	char *version;
+	
+	/* Whether this policydb is mls, should always be set */
+	int mls;	
 
 	/* symbol tables */
 	symtab_t symtab[SYM_NUM];
@@ -530,10 +533,12 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB
 
 /* Module versions and specific changes*/
-#define MOD_POLICYDB_VERSION_BASE	4
+#define MOD_POLICYDB_VERSION_BASE	   4
+#define MOD_POLICYDB_VERSION_VALIDATETRANS 5
+#define MOD_POLICYDB_VERSION_MLS	   5
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_BASE
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS
 
 /*
  * Set policy version for writing policies.
@@ -542,18 +547,6 @@ extern int policydb_write(struct policyd
  */
 extern int sepol_set_policyvers(unsigned int policy_type, unsigned int policyvers);
 
-/* Enable/Disable MLS support for the service functions.
-   MLS support is appropriately enabled/disabled when a policydb file
-   is read, according to the status of MLS support in the policy.  Use this
-   interface to enable/disable support only if you are not reading a policy,
-   such as when you build a binary policy and wish to write it to a file. */
-extern int sepol_set_mls(int enabled);
-
-/* Query the status of MLS support in the currently loaded policy.
-   A return of zero indicates a policy without MLS support,
-   non-zero indicates a policy with MLS support. */
-extern int sepol_mls_enabled(void);
-
 #define POLICYDB_CONFIG_MLS    1
 
 #define OBJECT_R "object_r"
diff -purN -x .svn libsepol/src/context.c libsepol/src/context.c
--- libsepol/src/context.c	2005-09-19 09:03:16.000000000 -0400
+++ libsepol/src/context.c	2005-09-30 11:16:30.000000000 -0400
@@ -173,13 +173,13 @@ int sepol_ctx_struct_create(
 	scontext->type = typdatum->value;
 
 	/* MLS */
-	if (mls && !sepol_mls_enabled()) {
+	if (mls && !policydb->mls) {
  		DEBUG(__FUNCTION__, "Warning! mls context \"%s\" found, "
  			"but mls is disabled\n", mls);
  		free(mls);
 		mls = NULL;
 	}
-	else if (!mls && sepol_mls_enabled()) {
+	else if (!mls && policydb->mls) {
  		DEBUG(__FUNCTION__, "mls is enabled, but no "
  			"mls context found\n");
 		goto err_destroy;
diff -purN -x .svn libsepol/src/expand.c libsepol/src/expand.c
--- libsepol/src/expand.c	2005-09-23 14:59:57.000000000 -0400
+++ libsepol/src/expand.c	2005-09-30 14:41:43.000000000 -0400
@@ -1755,7 +1755,10 @@ int expand_module(policydb_t *base, poli
                 write_error (&state, "Out of memory!");
                 goto cleanup;
         }
-		
+
+	/* Copy mls state from base to out */
+	out->mls = base->mls;
+
 	if ((state.typemap = (uint32_t*)calloc(state.base->p_types.nprim, sizeof(uint32_t))) == NULL) {
                 write_error (&state, "Out of memory!");
                 goto cleanup;
diff -purN -x .svn libsepol/src/genusers.c libsepol/src/genusers.c
--- libsepol/src/genusers.c	2005-09-19 09:03:16.000000000 -0400
+++ libsepol/src/genusers.c	2005-09-30 10:06:07.000000000 -0400
@@ -152,7 +152,7 @@ static int load_users(struct policydb *p
 			}
 		} while (islist);
 
-		if (mls_enabled) {
+		if (policydb->mls) {
 			context_struct_t context;
 			char *scontext, *r, *s;
 
diff -purN -x .svn libsepol/src/link.c libsepol/src/link.c
--- libsepol/src/link.c	2005-09-23 15:00:21.000000000 -0400
+++ libsepol/src/link.c	2005-09-30 15:24:59.000000000 -0400
@@ -362,6 +362,11 @@ static int user_copy_callback(hashtab_ke
         user_datum_t *user, *base_user, *new_user = NULL;
 	link_state_t *state = (link_state_t *)data;
 
+	if (state->base->mls) {
+		write_error(state, "Users cannot be declared in MLS modules");
+		return -1;
+	}
+
         user = (user_datum_t*)datum;
 
         base_user = hashtab_search(state->base->p_users.table, id);
@@ -1897,6 +1902,15 @@ int link_modules(policydb_t *b, policydb
                         write_error(&state, "Tried to link in a policy that was not a module.");
                         goto cleanup;
                 }
+
+		if (mods[i]->mls != b->mls) {
+			if (b->mls) 
+				write_error(&state, "Tried to link in a non-MLS module with an MLS base.");
+			else	
+				write_error(&state, "Tried to link in an MLS module with a non-MLS base.");
+			goto cleanup;
+		}
+
         	if ((modules[i] = (policy_module_t*)calloc(1, sizeof(policy_module_t))) == NULL) {
                         write_error(&state, "Out of memory!");
                         goto cleanup;
diff -purN -x .svn libsepol/src/mls.c libsepol/src/mls.c
--- libsepol/src/mls.c	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/src/mls.c	2005-09-30 11:16:30.000000000 -0400
@@ -46,7 +46,7 @@ int mls_compute_context_len(policydb_t *
 	unsigned int i, l, len, range;
 	ebitmap_node_t *cnode;
 
-	if (!mls_enabled)
+	if (!policydb->mls)
 		return 0;
 
 	len = 1; /* for the beginning ":" */
@@ -99,7 +99,7 @@ void mls_sid_to_context(policydb_t *poli
 	unsigned int i, l, range, wrote_sep;
 	ebitmap_node_t *cnode;
 
-	if (!mls_enabled)
+	if (!policydb->mls)
 		return;
 
 	scontextp = *scontext;
@@ -179,7 +179,7 @@ int mls_context_isvalid(policydb_t *p, c
 	unsigned int i, l;
 	ebitmap_node_t *cnode;
 
-	if (!mls_enabled)
+	if (!p->mls)
 		return 1;
 
 	/*
@@ -251,7 +251,7 @@ int mls_context_to_sid(policydb_t *polic
 	unsigned int l;
 	int rc = -EINVAL;
 
-	if (!mls_enabled)
+	if (!policydb->mls)
 		return 0;
 
 	/* No MLS component to the security context */
@@ -419,9 +419,9 @@ static inline int mls_range_set(context_
 }
 
 int mls_setup_user_range(context_struct_t *fromcon, user_datum_t *user,
-                         context_struct_t *usercon)
+                         context_struct_t *usercon, int mls)
 {
-	if (mls_enabled) {
+	if (mls) {
 		mls_level_t *fromcon_sen = &(fromcon->range.level[0]);
 		mls_level_t *fromcon_clr = &(fromcon->range.level[1]);
 		mls_level_t *user_low = &(user->range.level[0]);
@@ -471,7 +471,7 @@ int mls_convert_context(policydb_t * old
 	unsigned int l, i;
 	ebitmap_node_t *cnode;
 
-	if (!mls_enabled)
+	if (!oldp->mls)
 		return 0;
 
 	for (l = 0; l < 2; l++) {
@@ -511,7 +511,7 @@ int mls_compute_sid(policydb_t *policydb
 		    uint32_t specified,
 		    context_struct_t *newcontext)
 {
-	if (!mls_enabled)
+	if (!policydb->mls)
 		return 0;
 
 	switch (specified) {
diff -purN -x .svn libsepol/src/policydb.c libsepol/src/policydb.c
--- libsepol/src/policydb.c	2005-09-23 15:00:51.000000000 -0400
+++ libsepol/src/policydb.c	2005-09-30 11:16:30.000000000 -0400
@@ -98,10 +98,22 @@ static struct policydb_compat_info polic
 		.ocon_num	= OCON_NODE6 + 1,
         },
 	{
+		.type		= POLICY_BASE,
+		.version 	= MOD_POLICYDB_VERSION_MLS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NODE6 + 1,
+        },
+	{
 		.type		= POLICY_MOD,
 		.version	= MOD_POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM,
 		.ocon_num	= 0,
+        },
+	{
+		.type		= POLICY_MOD,
+		.version	= MOD_POLICYDB_VERSION_MLS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= 0,
         }
 };
 
@@ -129,19 +141,6 @@ static unsigned int symtab_sizes[SYM_NUM
 	16,
 };
 
-int mls_enabled = 0;
-
-int sepol_set_mls(int enabled)
-{
-	mls_enabled = enabled ? 1 : 0;
-	return 0;
-}
-
-int sepol_mls_enabled(void)
-{
-	return mls_enabled;
-}
-
 struct policydb_compat_info *policydb_lookup_compat(unsigned int version, 
 						    unsigned int type)
 {
@@ -666,7 +665,7 @@ int policydb_index_others(policydb_t * p
 		       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
 		       p->p_bools.nprim);
 
-		if (mls_enabled)
+		if (p->mls)
 			printf(", %d sens, %d cats", p->p_levels.nprim,
 			       p->p_cats.nprim);
 
@@ -1135,7 +1134,8 @@ static int context_read_and_validate(con
 	c->user = le32_to_cpu(buf[0]);
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
-	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+	if ((p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_MLS) ||
+	    (p->policy_type == POLICY_BASE && p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
 		if (mls_read_range_helper(&c->range, fp)) {
 			DEBUG(__FUNCTION__, "error reading MLS range "
 				"of context\n");
@@ -1417,7 +1417,8 @@ static int class_read(policydb_t * p, ha
 	if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
 		goto bad;
 
-	if (p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) {
+	if ((p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) ||
+	    (p->policy_type == POLICY_BASE && p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
 		/* grab the validatetrans rules */
 		buf = next_entry(fp, sizeof(uint32_t));
 		if (!buf)
@@ -1894,7 +1895,8 @@ static int user_read(policydb_t * p, has
 			goto bad;
 	}
 
-	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+	if ((p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_MLS) ||
+	    (p->policy_type == POLICY_BASE && p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
 		if (mls_read_range_helper(&usrdatum->range, fp))
 			goto bad;
 		if (mls_read_level(&usrdatum->dfltlevel, fp))
@@ -2530,8 +2532,11 @@ int policydb_read(policydb_t * p, struct
         p->policyvers = r_policyvers;
 
 	if (buf[bufindex] & POLICYDB_CONFIG_MLS) {
-                sepol_set_mls(1);
-        }
+                p->mls = 1;
+        } else {
+		p->mls = 0;
+	}
+ 
         bufindex++;
 
 	info = policydb_lookup_compat(r_policyvers, policy_type);
@@ -2636,7 +2641,8 @@ int policydb_read(policydb_t * p, struct
                 goto bad;
         }
 
-	if (r_policyvers >= POLICYDB_VERSION_MLS) {
+	if ((p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_MLS) ||
+	    (p->policy_type == POLICY_BASE && p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
                 if (range_read(p, fp)) {
 			goto bad;
                 }
diff -purN -x .svn libsepol/src/private.h libsepol/src/private.h
--- libsepol/src/private.h	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/src/private.h	2005-09-30 10:06:06.000000000 -0400
@@ -86,4 +86,3 @@ static inline size_t put_entry(const voi
 	return 0;
 }
 
-extern int mls_enabled;
diff -purN -x .svn libsepol/src/services.c libsepol/src/services.c
--- libsepol/src/services.c	2005-09-19 09:03:15.000000000 -0400
+++ libsepol/src/services.c	2005-09-30 11:16:30.000000000 -0400
@@ -1279,7 +1279,7 @@ int sepol_get_user_sids(sepol_security_i
 			if (usercon.type == fromcon->type)
 				continue;
 
-			if (mls_setup_user_range(fromcon, user, &usercon))
+			if (mls_setup_user_range(fromcon, user, &usercon, policydb->mls))
 				continue;
 
 			rc = context_struct_compute_av(fromcon, &usercon, 
diff -purN -x .svn libsepol/src/users.c libsepol/src/users.c
--- libsepol/src/users.c	2005-09-22 09:40:08.000000000 -0400
+++ libsepol/src/users.c	2005-09-30 10:06:07.000000000 -0400
@@ -240,7 +240,7 @@ int sepol_user_load(policydb_t* policydb
 	}
 
 	/* For MLS systems */
-	if (mls_enabled) {
+	if (policydb->mls) {
 		char* mls_tmp;
 		context_init(&context);
 
diff -purN -x .svn libsepol/src/write.c libsepol/src/write.c
--- libsepol/src/write.c	2005-09-23 15:01:16.000000000 -0400
+++ libsepol/src/write.c	2005-09-30 10:06:07.000000000 -0400
@@ -674,7 +674,8 @@ static int context_write(context_struct_
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items2 != items)
 		return -1;
-	if (policyvers >= POLICYDB_VERSION_MLS)
+	if ((policyvers >= POLICYDB_VERSION_MLS && policy_type == POLICY_KERN) ||
+	    (policyvers >= MOD_POLICYDB_VERSION_MLS && policy_type == POLICY_BASE))
 		if (mls_write_range_helper(&c->range, fp))
 			return -1;
 
@@ -840,7 +841,8 @@ static int class_write(hashtab_key_t key
 	if (write_cons_helper(cladatum->constraints, 0, fp))
 		return -1;
 
-	if (policyvers >= POLICYDB_VERSION_VALIDATETRANS) {
+	if ((policy_type == POLICY_KERN && policyvers >= POLICYDB_VERSION_VALIDATETRANS) ||
+	    (policy_type == POLICY_BASE && policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
 		/* write out the validatetrans rule */
 		ncons = 0;
 		for (c = cladatum->validatetrans; c; c = c->next) {
@@ -953,7 +955,11 @@ static int user_write(hashtab_key_t key,
 		if (role_set_write(&usrdatum->roles, fp))
 			return -1;
 	}
-	if (policyvers >= POLICYDB_VERSION_MLS) {
+	/* Users are allowed in non-mls modules, so the empty field will be present
+	   in modules with users >= MOD_POLICYDB_VERSION_MLS */
+	if ((policyvers >= POLICYDB_VERSION_MLS && policy_type == POLICY_KERN) ||
+	    (policyvers >= MOD_POLICYDB_VERSION_MLS && policy_type == POLICY_MOD) ||
+	    (policyvers >= MOD_POLICYDB_VERSION_MLS && policy_type == POLICY_BASE)) {
 		if (mls_write_range_helper(&usrdatum->range, fp))
 			return -1;
 		if (mls_write_level(&usrdatum->dfltlevel, fp))
@@ -1399,7 +1405,7 @@ int policydb_write(policydb_t * p, struc
 	char *policydb_str;
 
 	config = 0;
-	if (sepol_mls_enabled())
+	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;
 
 	/* Write the magic number and string identifiers. */
@@ -1509,7 +1515,8 @@ int policydb_write(policydb_t * p, struc
                 return -1;
         }
 
-        if (policyvers >= POLICYDB_VERSION_MLS) {
+	if ((policyvers >= POLICYDB_VERSION_MLS && policy_type == POLICY_KERN) ||
+	    (policyvers >= MOD_POLICYDB_VERSION_MLS && policy_type == POLICY_BASE)) {
                 if (range_write(p, fp)) {
                         return -1;
                 }

--=-WqnDoHciXY4IRivRAgDy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
