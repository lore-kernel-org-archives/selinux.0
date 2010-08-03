From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: convert part of the sym_val_to_name array to use
	flex_array
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 03 Aug 2010 15:58:35 -0400
Message-ID: <20100803195835.6191.56934.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The sym_val_to_name type array can be quite large as it grows linearly with
the number of types.  With known policies having over 5k types these
allocations are growing large enough that they are likely to fail.  Convert
those to flex_array so no allocation is larger than PAGE_SIZE

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/conditional.c |    6 ++
 security/selinux/ss/mls.c         |   25 ++++----
 security/selinux/ss/policydb.c    |  109 ++++++++++++++++++++++++++++---------
 security/selinux/ss/policydb.h    |   17 +++---
 security/selinux/ss/services.c    |   38 ++++++-------
 5 files changed, 127 insertions(+), 68 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 655fe1c..c3f845c 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -193,6 +193,7 @@ int cond_index_bool(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct cond_bool_datum *booldatum;
+	struct flex_array *fa;
 
 	booldatum = datum;
 	p = datap;
@@ -200,7 +201,10 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
 		return -EINVAL;
 
-	p->p_bool_val_to_name[booldatum->value - 1] = key;
+	fa = p->sym_val_to_name[SYM_BOOLS];
+	if (flex_array_put_ptr(fa, booldatum->value - 1, key,
+			       GFP_KERNEL | __GFP_ZERO))
+		BUG();
 	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
 
 	return 0;
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b4eff7a..a6aa69d 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -45,7 +45,7 @@ int mls_compute_context_len(struct context *context)
 	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
 		int index_sens = context->range.level[l].sens;
-		len += strlen(policydb.p_sens_val_to_name[index_sens - 1]);
+		len += strlen(sym_name(&policydb, SYM_LEVELS, index_sens - 1));
 
 		/* categories */
 		head = -2;
@@ -55,17 +55,17 @@ int mls_compute_context_len(struct context *context)
 			if (i - prev > 1) {
 				/* one or more negative bits are skipped */
 				if (head != prev) {
-					nm = policydb.p_cat_val_to_name[prev];
+					nm = sym_name(&policydb, SYM_CATS, prev);
 					len += strlen(nm) + 1;
 				}
-				nm = policydb.p_cat_val_to_name[i];
+				nm = sym_name(&policydb, SYM_CATS, i);
 				len += strlen(nm) + 1;
 				head = i;
 			}
 			prev = i;
 		}
 		if (prev != head) {
-			nm = policydb.p_cat_val_to_name[prev];
+			nm = sym_name(&policydb, SYM_CATS, prev);
 			len += strlen(nm) + 1;
 		}
 		if (l == 0) {
@@ -102,8 +102,8 @@ void mls_sid_to_context(struct context *context,
 	scontextp++;
 
 	for (l = 0; l < 2; l++) {
-		strcpy(scontextp,
-		       policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
+		strcpy(scontextp, sym_name(&policydb, SYM_LEVELS,
+					   context->range.level[l].sens - 1));
 		scontextp += strlen(scontextp);
 
 		/* categories */
@@ -118,7 +118,7 @@ void mls_sid_to_context(struct context *context,
 						*scontextp++ = '.';
 					else
 						*scontextp++ = ',';
-					nm = policydb.p_cat_val_to_name[prev];
+					nm = sym_name(&policydb, SYM_CATS, prev);
 					strcpy(scontextp, nm);
 					scontextp += strlen(nm);
 				}
@@ -126,7 +126,7 @@ void mls_sid_to_context(struct context *context,
 					*scontextp++ = ':';
 				else
 					*scontextp++ = ',';
-				nm = policydb.p_cat_val_to_name[i];
+				nm = sym_name(&policydb, SYM_CATS, i);
 				strcpy(scontextp, nm);
 				scontextp += strlen(nm);
 				head = i;
@@ -139,7 +139,7 @@ void mls_sid_to_context(struct context *context,
 				*scontextp++ = '.';
 			else
 				*scontextp++ = ',';
-			nm = policydb.p_cat_val_to_name[prev];
+			nm = sym_name(&policydb, SYM_CATS, prev);
 			strcpy(scontextp, nm);
 			scontextp += strlen(nm);
 		}
@@ -166,7 +166,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return 0;
 	levdatum = hashtab_search(p->p_levels.table,
-				  p->p_sens_val_to_name[l->sens - 1]);
+				  sym_name(p, SYM_LEVELS, l->sens - 1));
 	if (!levdatum)
 		return 0;
 
@@ -482,7 +482,8 @@ int mls_convert_context(struct policydb *oldp,
 
 	for (l = 0; l < 2; l++) {
 		levdatum = hashtab_search(newp->p_levels.table,
-			oldp->p_sens_val_to_name[c->range.level[l].sens - 1]);
+					  sym_name(oldp, SYM_LEVELS, 
+						   c->range.level[l].sens - 1));
 
 		if (!levdatum)
 			return -EINVAL;
@@ -493,7 +494,7 @@ int mls_convert_context(struct policydb *oldp,
 			int rc;
 
 			catdatum = hashtab_search(newp->p_cats.table,
-						  oldp->p_cat_val_to_name[i]);
+						  sym_name(oldp, SYM_CATS, i));
 			if (!catdatum)
 				return -EINVAL;
 			rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c462d53..a80bf9d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -247,12 +247,17 @@ static int common_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct common_datum *comdatum;
+	struct flex_array *fa;
 
 	comdatum = datum;
 	p = datap;
 	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
 		return -EINVAL;
-	p->p_common_val_to_name[comdatum->value - 1] = key;
+
+	fa = p->sym_val_to_name[SYM_COMMONS];
+	if (flex_array_put_ptr(fa, comdatum->value - 1, key,
+			       GFP_KERNEL | __GFP_ZERO))
+		BUG();
 	return 0;
 }
 
@@ -260,12 +265,16 @@ static int class_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct class_datum *cladatum;
+	struct flex_array *fa;
 
 	cladatum = datum;
 	p = datap;
 	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
 		return -EINVAL;
-	p->p_class_val_to_name[cladatum->value - 1] = key;
+	fa = p->sym_val_to_name[SYM_CLASSES];
+	if (flex_array_put_ptr(fa, cladatum->value - 1, key,
+			       GFP_KERNEL | __GFP_ZERO))
+		BUG();
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 	return 0;
 }
@@ -274,6 +283,7 @@ static int role_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct role_datum *role;
+	struct flex_array *fa;
 
 	role = datum;
 	p = datap;
@@ -281,7 +291,11 @@ static int role_index(void *key, void *datum, void *datap)
 	    || role->value > p->p_roles.nprim
 	    || role->bounds > p->p_roles.nprim)
 		return -EINVAL;
-	p->p_role_val_to_name[role->value - 1] = key;
+
+	fa = p->sym_val_to_name[SYM_ROLES];
+	if (flex_array_put_ptr(fa, role->value - 1, key,
+			       GFP_KERNEL | __GFP_ZERO))
+		BUG();
 	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
 }
@@ -290,6 +304,7 @@ static int type_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct type_datum *typdatum;
+	struct flex_array *fa;
 
 	typdatum = datum;
 	p = datap;
@@ -299,10 +314,13 @@ static int type_index(void *key, void *datum, void *datap)
 		    || typdatum->value > p->p_types.nprim
 		    || typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
-		p->p_type_val_to_name[typdatum->value - 1] = key;
-		/* this flex array was all preallocated, this cannot fail */
-		if (flex_array_put_ptr(p->type_val_to_struct_array,
-				       typdatum->value - 1, typdatum,
+		fa = p->sym_val_to_name[SYM_TYPES];
+		if (flex_array_put_ptr(fa, typdatum->value - 1, key,
+				       GFP_KERNEL | __GFP_ZERO))
+			BUG();
+
+		fa = p->type_val_to_struct_array;
+		if (flex_array_put_ptr(fa, typdatum->value - 1, typdatum,
 				       GFP_KERNEL | __GFP_ZERO))
 			BUG();
 	}
@@ -314,6 +332,7 @@ static int user_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct user_datum *usrdatum;
+	struct flex_array *fa;
 
 	usrdatum = datum;
 	p = datap;
@@ -321,7 +340,11 @@ static int user_index(void *key, void *datum, void *datap)
 	    || usrdatum->value > p->p_users.nprim
 	    || usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
-	p->p_user_val_to_name[usrdatum->value - 1] = key;
+
+	fa = p->sym_val_to_name[SYM_USERS];
+	if (flex_array_put_ptr(fa, usrdatum->value - 1, key,
+			       GFP_KERNEL | __GFP_ZERO))
+		BUG();
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
 }
@@ -330,6 +353,7 @@ static int sens_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct level_datum *levdatum;
+	struct flex_array *fa;
 
 	levdatum = datum;
 	p = datap;
@@ -338,7 +362,10 @@ static int sens_index(void *key, void *datum, void *datap)
 		if (!levdatum->level->sens ||
 		    levdatum->level->sens > p->p_levels.nprim)
 			return -EINVAL;
-		p->p_sens_val_to_name[levdatum->level->sens - 1] = key;
+		fa = p->sym_val_to_name[SYM_LEVELS];
+		if (flex_array_put_ptr(fa, levdatum->level->sens - 1, key,
+				       GFP_KERNEL | __GFP_ZERO))
+			BUG();
 	}
 
 	return 0;
@@ -348,6 +375,7 @@ static int cat_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct cat_datum *catdatum;
+	struct flex_array *fa;
 
 	catdatum = datum;
 	p = datap;
@@ -355,7 +383,10 @@ static int cat_index(void *key, void *datum, void *datap)
 	if (!catdatum->isalias) {
 		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
 			return -EINVAL;
-		p->p_cat_val_to_name[catdatum->value - 1] = key;
+		fa = p->sym_val_to_name[SYM_CATS];
+		if (flex_array_put_ptr(fa, catdatum->value - 1, key,
+				       GFP_KERNEL | __GFP_ZERO))
+			BUG();
 	}
 
 	return 0;
@@ -385,9 +416,16 @@ static int policydb_index_classes(struct policydb *p)
 	int rc;
 
 	rc = -ENOMEM;
-	p->p_common_val_to_name =
-		kmalloc(p->p_commons.nprim * sizeof(char *), GFP_KERNEL);
-	if (!p->p_common_val_to_name)
+	p->sym_val_to_name[SYM_COMMONS] = flex_array_alloc(sizeof(char *),
+							   p->p_commons.nprim,
+							   GFP_KERNEL | __GFP_ZERO);
+	if (!p->sym_val_to_name[SYM_COMMONS])
+		goto out;
+
+	rc = flex_array_prealloc(p->sym_val_to_name[SYM_COMMONS],
+				 0, p->p_commons.nprim - 1,
+				 GFP_KERNEL | __GFP_ZERO);
+	if (rc)
 		goto out;
 
 	rc = hashtab_map(p->p_commons.table, common_index, p);
@@ -401,9 +439,16 @@ static int policydb_index_classes(struct policydb *p)
 		goto out;
 
 	rc = -ENOMEM;
-	p->p_class_val_to_name =
-		kmalloc(p->p_classes.nprim * sizeof(char *), GFP_KERNEL);
-	if (!p->p_class_val_to_name)
+	p->sym_val_to_name[SYM_CLASSES] = flex_array_alloc(sizeof(char *),
+							   p->p_classes.nprim,
+							   GFP_KERNEL | __GFP_ZERO);
+	if (!p->sym_val_to_name[SYM_CLASSES])
+		goto out;
+
+	rc = flex_array_prealloc(p->sym_val_to_name[SYM_CLASSES],
+				 0, p->p_classes.nprim - 1,
+				 GFP_KERNEL | __GFP_ZERO);
+	if (rc)
 		goto out;
 
 	rc = hashtab_map(p->p_classes.table, class_index, p);
@@ -500,10 +545,18 @@ static int policydb_index_others(struct policydb *p)
 
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
 		rc = -ENOMEM;
-		p->sym_val_to_name[i] =
-			kmalloc(p->symtab[i].nprim * sizeof(char *), GFP_KERNEL);
+		p->sym_val_to_name[i] = flex_array_alloc(sizeof(struct type_dataum *),
+							 p->symtab[i].nprim,
+							 GFP_KERNEL | __GFP_ZERO);
 		if (!p->sym_val_to_name[i])
 			goto out;
+
+		rc = flex_array_prealloc(p->sym_val_to_name[i],
+					 0, p->symtab[i].nprim - 1,
+					 GFP_KERNEL | __GFP_ZERO);
+		if (rc)
+			goto out;
+
 		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
 		if (rc)
 			goto out;
@@ -696,8 +749,10 @@ void policydb_destroy(struct policydb *p)
 		hashtab_destroy(p->symtab[i].table);
 	}
 
-	for (i = 0; i < SYM_NUM; i++)
-		kfree(p->sym_val_to_name[i]);
+	for (i = 0; i < SYM_NUM; i++) {
+		if (p->sym_val_to_name[i])
+			flex_array_free(p->sym_val_to_name[i]);
+	}
 
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
@@ -1559,9 +1614,9 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 			printk(KERN_ERR
 			       "SELinux: boundary violated policy: "
 			       "user=%s role=%s bounds=%s\n",
-			       p->p_user_val_to_name[user->value - 1],
-			       p->p_role_val_to_name[bit],
-			       p->p_user_val_to_name[upper->value - 1]);
+			       sym_name(p, SYM_USERS, user->value - 1),
+			       sym_name(p, SYM_ROLES, bit),
+			       sym_name(p, SYM_USERS, upper->value - 1));
 
 			return -EINVAL;
 		}
@@ -1596,9 +1651,9 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 			printk(KERN_ERR
 			       "SELinux: boundary violated policy: "
 			       "role=%s type=%s bounds=%s\n",
-			       p->p_role_val_to_name[role->value - 1],
-			       p->p_type_val_to_name[bit],
-			       p->p_role_val_to_name[upper->value - 1]);
+			       sym_name(p, SYM_ROLES, role->value - 1),
+			       sym_name(p, SYM_TYPES, bit),
+			       sym_name(p, SYM_ROLES, upper->value - 1));
 
 			return -EINVAL;
 		}
@@ -1630,7 +1685,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 			printk(KERN_ERR "SELinux: type %s: "
 			       "bounded by attribute %s",
 			       (char *) key,
-			       p->p_type_val_to_name[upper->value - 1]);
+			       sym_name(p, SYM_TYPES, upper->value - 1));
 			return -EINVAL;
 		}
 	}
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 9826a92..4e3ab9d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -203,15 +203,7 @@ struct policydb {
 #define p_cats symtab[SYM_CATS]
 
 	/* symbol names indexed by (value - 1) */
-	char **sym_val_to_name[SYM_NUM];
-#define p_common_val_to_name sym_val_to_name[SYM_COMMONS]
-#define p_class_val_to_name sym_val_to_name[SYM_CLASSES]
-#define p_role_val_to_name sym_val_to_name[SYM_ROLES]
-#define p_type_val_to_name sym_val_to_name[SYM_TYPES]
-#define p_user_val_to_name sym_val_to_name[SYM_USERS]
-#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
-#define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]
-#define p_cat_val_to_name sym_val_to_name[SYM_CATS]
+	struct flex_array *sym_val_to_name[SYM_NUM];
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
@@ -321,6 +313,13 @@ static inline int put_entry(void *buf, size_t bytes, int num, struct policy_file
 	return 0;
 }
 
+static inline char *sym_name(struct policydb *p, unsigned int sym_num, unsigned int element_nr)
+{
+	struct flex_array *fa = p->sym_val_to_name[sym_num];
+
+	return flex_array_get_ptr(fa, element_nr);
+}
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 060ae71..89ade0b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -463,7 +463,7 @@ static void security_dump_masked_av(struct context *scontext,
 	if (!permissions)
 		return;
 
-	tclass_name = policydb.p_class_val_to_name[tclass - 1];
+	tclass_name = sym_name(&policydb, SYM_CLASSES, tclass - 1);
 	tclass_dat = policydb.class_val_to_struct[tclass - 1];
 	common_dat = tclass_dat->comdatum;
 
@@ -715,7 +715,7 @@ static int security_validtrans_handle_fail(struct context *ocontext,
 	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 		  "security_validate_transition:  denied for"
 		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
-		  o, n, t, policydb.p_class_val_to_name[tclass-1]);
+		  o, n, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
 out:
 	kfree(o);
 	kfree(n);
@@ -1010,9 +1010,9 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 	}
 
 	/* Compute the size of the context. */
-	*scontext_len += strlen(policydb.p_user_val_to_name[context->user - 1]) + 1;
-	*scontext_len += strlen(policydb.p_role_val_to_name[context->role - 1]) + 1;
-	*scontext_len += strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
+	*scontext_len += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) + 1;
+	*scontext_len += strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) + 1;
+	*scontext_len += strlen(sym_name(&policydb, SYM_TYPES, context->type - 1)) + 1;
 	*scontext_len += mls_compute_context_len(context);
 
 	/* Allocate space for the context; caller must free this space. */
@@ -1025,12 +1025,12 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 	 * Copy the user name, role name and type name into the context.
 	 */
 	sprintf(scontextp, "%s:%s:%s",
-		policydb.p_user_val_to_name[context->user - 1],
-		policydb.p_role_val_to_name[context->role - 1],
-		policydb.p_type_val_to_name[context->type - 1]);
-	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
-		     1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
-		     1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
+		sym_name(&policydb, SYM_USERS, context->user - 1),
+		sym_name(&policydb, SYM_ROLES, context->role - 1),
+		sym_name(&policydb, SYM_TYPES, context->type - 1));
+	scontextp += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) +
+		     1 + strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) +
+		     1 + strlen(sym_name(&policydb, SYM_TYPES, context->type - 1));
 
 	mls_sid_to_context(context, &scontextp);
 
@@ -1325,7 +1325,7 @@ static int compute_sid_handle_invalid_context(
 		  " for scontext=%s"
 		  " tcontext=%s"
 		  " tclass=%s",
-		  n, s, t, policydb.p_class_val_to_name[tclass-1]);
+		  n, s, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
 out:
 	kfree(s);
 	kfree(t);
@@ -1646,7 +1646,7 @@ static int convert_context(u32 key,
 	/* Convert the user. */
 	rc = -EINVAL;
 	usrdatum = hashtab_search(args->newp->p_users.table,
-				  args->oldp->p_user_val_to_name[c->user - 1]);
+				  sym_name(args->oldp, SYM_USERS, c->user - 1));
 	if (!usrdatum)
 		goto bad;
 	c->user = usrdatum->value;
@@ -1654,7 +1654,7 @@ static int convert_context(u32 key,
 	/* Convert the role. */
 	rc = -EINVAL;
 	role = hashtab_search(args->newp->p_roles.table,
-			      args->oldp->p_role_val_to_name[c->role - 1]);
+			      sym_name(args->oldp, SYM_ROLES, c->role - 1));
 	if (!role)
 		goto bad;
 	c->role = role->value;
@@ -1662,7 +1662,7 @@ static int convert_context(u32 key,
 	/* Convert the type. */
 	rc = -EINVAL;
 	typdatum = hashtab_search(args->newp->p_types.table,
-				  args->oldp->p_type_val_to_name[c->type - 1]);
+				  sym_name(args->oldp, SYM_TYPES, c->type - 1));
 	if (!typdatum)
 		goto bad;
 	c->type = typdatum->value;
@@ -2310,14 +2310,14 @@ int security_get_bools(int *len, char ***names, int **values)
 		size_t name_len;
 
 		(*values)[i] = policydb.bool_val_to_struct[i]->state;
-		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
+		name_len = strlen(sym_name(&policydb, SYM_BOOLS, i)) + 1;
 
 		rc = -ENOMEM;
 		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
 
-		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
+		strncpy((*names)[i], sym_name(&policydb, SYM_BOOLS, i), name_len);
 		(*names)[i][name_len - 1] = 0;
 	}
 	rc = 0;
@@ -2352,7 +2352,7 @@ int security_set_bools(int len, int *values)
 			audit_log(current->audit_context, GFP_ATOMIC,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
-				policydb.p_bool_val_to_name[i],
+				sym_name(&policydb, SYM_BOOLS, i),
 				!!values[i],
 				policydb.bool_val_to_struct[i]->state,
 				audit_get_loginuid(current),
@@ -3116,7 +3116,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 		goto out;
 
 	rc = -ENOMEM;
-	secattr->domain = kstrdup(policydb.p_type_val_to_name[ctx->type - 1],
+	secattr->domain = kstrdup(sym_name(&policydb, SYM_TYPES, ctx->type - 1),
 				  GFP_ATOMIC);
 	if (secattr->domain == NULL)
 		goto out;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
