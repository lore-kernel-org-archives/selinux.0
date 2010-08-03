From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/4] SELinux: standardize return code handling in policydb.c
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 03 Aug 2010 14:31:16 -0400
Message-ID: <20100803183116.31021.33444.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policydb.c has lots of different standards on how to handle return paths on
error.  For the most part transition to

	rc=errno
	if (failure)
		goto out;
[...]
out:
	cleanup()
	return rc;

Instead of doing cleanup mid function, or having multiple returns or other
options.  This doesn't do that for every function, but most of the complex
functions which have cleanup routines on error.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |  555 +++++++++++++++++++---------------------
 1 files changed, 268 insertions(+), 287 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 31039ba..4ca9b5c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -148,32 +148,30 @@ static int roles_init(struct policydb *p)
 	int rc;
 	struct role_datum *role;
 
+	rc = -ENOMEM;
 	role = kzalloc(sizeof(*role), GFP_KERNEL);
-	if (!role) {
-		rc = -ENOMEM;
+	if (!role)
 		goto out;
-	}
+
+	rc = -EINVAL;
 	role->value = ++p->p_roles.nprim;
-	if (role->value != OBJECT_R_VAL) {
-		rc = -EINVAL;
-		goto out_free_role;
-	}
+	if (role->value != OBJECT_R_VAL)
+		goto out;
+
+	rc = -ENOMEM;
 	key = kstrdup(OBJECT_R, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
-		goto out_free_role;
-	}
+	if (!key)
+		goto out;
+
 	rc = hashtab_insert(p->p_roles.table, key, role);
 	if (rc)
-		goto out_free_key;
-out:
-	return rc;
+		goto out;
 
-out_free_key:
+	return 0;
+out:
 	kfree(key);
-out_free_role:
 	kfree(role);
-	goto out;
+	return rc;
 }
 
 static u32 rangetr_hash(struct hashtab *h, const void *k)
@@ -203,35 +201,33 @@ static int policydb_init(struct policydb *p)
 	for (i = 0; i < SYM_NUM; i++) {
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
 		if (rc)
-			goto out_free_symtab;
+			goto out;
 	}
 
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
-		goto out_free_symtab;
+		goto out;
 
 	rc = roles_init(p);
 	if (rc)
-		goto out_free_symtab;
+		goto out;
 
 	rc = cond_policydb_init(p);
 	if (rc)
-		goto out_free_symtab;
+		goto out;
 
 	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
 	if (!p->range_tr)
-		goto out_free_symtab;
+		goto out;
 
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
+	return 0;
 out:
-	return rc;
-
-out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);
-	goto out;
+	return rc;
 }
 
 /*
@@ -381,30 +377,27 @@ static int policydb_index_classes(struct policydb *p)
 {
 	int rc;
 
+	rc = -ENOMEM;
 	p->p_common_val_to_name =
 		kmalloc(p->p_commons.nprim * sizeof(char *), GFP_KERNEL);
-	if (!p->p_common_val_to_name) {
-		rc = -ENOMEM;
+	if (!p->p_common_val_to_name)
 		goto out;
-	}
 
 	rc = hashtab_map(p->p_commons.table, common_index, p);
 	if (rc)
 		goto out;
 
+	rc = -ENOMEM;
 	p->class_val_to_struct =
 		kmalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)), GFP_KERNEL);
-	if (!p->class_val_to_struct) {
-		rc = -ENOMEM;
+	if (!p->class_val_to_struct)
 		goto out;
-	}
 
+	rc = -ENOMEM;
 	p->p_class_val_to_name =
 		kmalloc(p->p_classes.nprim * sizeof(char *), GFP_KERNEL);
-	if (!p->p_class_val_to_name) {
-		rc = -ENOMEM;
+	if (!p->p_class_val_to_name)
 		goto out;
-	}
 
 	rc = hashtab_map(p->p_classes.table, class_index, p);
 out:
@@ -450,7 +443,7 @@ static inline void rangetr_hash_eval(struct hashtab *h)
  */
 static int policydb_index_others(struct policydb *p)
 {
-	int i, rc = 0;
+	int i, rc;
 
 	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
@@ -467,47 +460,42 @@ static int policydb_index_others(struct policydb *p)
 	symtab_hash_eval(p->symtab);
 #endif
 
+	rc = -ENOMEM;
 	p->role_val_to_struct =
 		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
 			GFP_KERNEL);
-	if (!p->role_val_to_struct) {
-		rc = -ENOMEM;
+	if (!p->role_val_to_struct)
 		goto out;
-	}
 
+	rc = -ENOMEM;
 	p->user_val_to_struct =
 		kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
 			GFP_KERNEL);
-	if (!p->user_val_to_struct) {
-		rc = -ENOMEM;
+	if (!p->user_val_to_struct)
 		goto out;
-	}
 
+	rc = -ENOMEM;
 	p->type_val_to_struct =
 		kmalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
 			GFP_KERNEL);
-	if (!p->type_val_to_struct) {
-		rc = -ENOMEM;
+	if (!p->type_val_to_struct)
 		goto out;
-	}
 
-	if (cond_init_bool_indexes(p)) {
-		rc = -ENOMEM;
+	rc = -ENOMEM;
+	if (cond_init_bool_indexes(p))
 		goto out;
-	}
 
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
+		rc = -ENOMEM;
 		p->sym_val_to_name[i] =
 			kmalloc(p->symtab[i].nprim * sizeof(char *), GFP_KERNEL);
-		if (!p->sym_val_to_name[i]) {
-			rc = -ENOMEM;
+		if (!p->sym_val_to_name[i])
 			goto out;
-		}
 		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
 		if (rc)
 			goto out;
 	}
-
+	rc = 0;
 out:
 	return rc;
 }
@@ -530,9 +518,11 @@ static int common_destroy(void *key, void *datum, void *p)
 	struct common_datum *comdatum;
 
 	kfree(key);
-	comdatum = datum;
-	hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
-	hashtab_destroy(comdatum->permissions.table);
+	if (datum) {
+		comdatum = datum;
+		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(comdatum->permissions.table);
+	}
 	kfree(datum);
 	return 0;
 }
@@ -544,38 +534,40 @@ static int cls_destroy(void *key, void *datum, void *p)
 	struct constraint_expr *e, *etmp;
 
 	kfree(key);
-	cladatum = datum;
-	hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-	hashtab_destroy(cladatum->permissions.table);
-	constraint = cladatum->constraints;
-	while (constraint) {
-		e = constraint->expr;
-		while (e) {
-			ebitmap_destroy(&e->names);
-			etmp = e;
-			e = e->next;
-			kfree(etmp);
+	if (datum) {
+		cladatum = datum;
+		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(cladatum->permissions.table);
+		constraint = cladatum->constraints;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				ebitmap_destroy(&e->names);
+				etmp = e;
+				e = e->next;
+				kfree(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
 		}
-		ctemp = constraint;
-		constraint = constraint->next;
-		kfree(ctemp);
-	}
-
-	constraint = cladatum->validatetrans;
-	while (constraint) {
-		e = constraint->expr;
-		while (e) {
-			ebitmap_destroy(&e->names);
-			etmp = e;
-			e = e->next;
-			kfree(etmp);
+	
+		constraint = cladatum->validatetrans;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				ebitmap_destroy(&e->names);
+				etmp = e;
+				e = e->next;
+				kfree(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
 		}
-		ctemp = constraint;
-		constraint = constraint->next;
-		kfree(ctemp);
+	
+		kfree(cladatum->comkey);
 	}
-
-	kfree(cladatum->comkey);
 	kfree(datum);
 	return 0;
 }
@@ -585,9 +577,11 @@ static int role_destroy(void *key, void *datum, void *p)
 	struct role_datum *role;
 
 	kfree(key);
-	role = datum;
-	ebitmap_destroy(&role->dominates);
-	ebitmap_destroy(&role->types);
+	if (datum) {
+		role = datum;
+		ebitmap_destroy(&role->dominates);
+		ebitmap_destroy(&role->types);
+	}
 	kfree(datum);
 	return 0;
 }
@@ -604,11 +598,13 @@ static int user_destroy(void *key, void *datum, void *p)
 	struct user_datum *usrdatum;
 
 	kfree(key);
-	usrdatum = datum;
-	ebitmap_destroy(&usrdatum->roles);
-	ebitmap_destroy(&usrdatum->range.level[0].cat);
-	ebitmap_destroy(&usrdatum->range.level[1].cat);
-	ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	if (datum) {
+		usrdatum = datum;
+		ebitmap_destroy(&usrdatum->roles);
+		ebitmap_destroy(&usrdatum->range.level[0].cat);
+		ebitmap_destroy(&usrdatum->range.level[1].cat);
+		ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	}
 	kfree(datum);
 	return 0;
 }
@@ -618,9 +614,11 @@ static int sens_destroy(void *key, void *datum, void *p)
 	struct level_datum *levdatum;
 
 	kfree(key);
-	levdatum = datum;
-	ebitmap_destroy(&levdatum->level->cat);
-	kfree(levdatum->level);
+	if (datum) {
+		levdatum = datum;
+		ebitmap_destroy(&levdatum->level->cat);
+		kfree(levdatum->level);
+	}
 	kfree(datum);
 	return 0;
 }
@@ -775,19 +773,21 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
+		rc = -EINVAL;
 		if (!c->context[0].user) {
-			printk(KERN_ERR "SELinux:  SID %s was never "
-			       "defined.\n", c->u.name);
-			rc = -EINVAL;
+			printk(KERN_ERR "SELinux:  SID %s was never defined.\n",
+				c->u.name);
 			goto out;
 		}
-		if (sidtab_insert(s, c->sid[0], &c->context[0])) {
-			printk(KERN_ERR "SELinux:  unable to load initial "
-			       "SID %s.\n", c->u.name);
-			rc = -EINVAL;
+
+		rc = sidtab_insert(s, c->sid[0], &c->context[0]);
+		if (rc) {
+			printk(KERN_ERR "SELinux:  unable to load initial SID %s.\n",
+				c->u.name);
 			goto out;
 		}
 	}
+	rc = 0;
 out:
 	return rc;
 }
@@ -836,8 +836,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->types,
-				     c->type - 1))
+		if (!ebitmap_get_bit(&role->types, c->type - 1))
 			/* role may not be associated with type */
 			return 0;
 
@@ -848,8 +847,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		if (!usrdatum)
 			return 0;
 
-		if (!ebitmap_get_bit(&usrdatum->roles,
-				     c->role - 1))
+		if (!ebitmap_get_bit(&usrdatum->roles, c->role - 1))
 			/* user may not be associated with role */
 			return 0;
 	}
@@ -871,20 +869,22 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
+	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	items = le32_to_cpu(buf[0]);
 	if (items > ARRAY_SIZE(buf)) {
 		printk(KERN_ERR "SELinux: mls:  range overflow\n");
-		rc = -EINVAL;
 		goto out;
 	}
+
 	rc = next_entry(buf, fp, sizeof(u32) * items);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: mls:  truncated range\n");
 		goto out;
 	}
+
 	r->level[0].sens = le32_to_cpu(buf[0]);
 	if (items > 1)
 		r->level[1].sens = le32_to_cpu(buf[1]);
@@ -893,15 +893,13 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 
 	rc = ebitmap_read(&r->level[0].cat, fp);
 	if (rc) {
-		printk(KERN_ERR "SELinux: mls:  error reading low "
-		       "categories\n");
+		printk(KERN_ERR "SELinux: mls:  error reading low categories\n");
 		goto out;
 	}
 	if (items > 1) {
 		rc = ebitmap_read(&r->level[1].cat, fp);
 		if (rc) {
-			printk(KERN_ERR "SELinux: mls:  error reading high "
-			       "categories\n");
+			printk(KERN_ERR "SELinux: mls:  error reading high categories\n");
 			goto bad_high;
 		}
 	} else {
@@ -912,12 +910,11 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 		}
 	}
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
 bad_high:
 	ebitmap_destroy(&r->level[0].cat);
-	goto out;
+out:
+	return rc;
 }
 
 /*
@@ -932,7 +929,7 @@ static int context_read_and_validate(struct context *c,
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: context truncated\n");
 		goto out;
 	}
@@ -940,19 +937,20 @@ static int context_read_and_validate(struct context *c,
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
-		if (mls_read_range_helper(&c->range, fp)) {
-			printk(KERN_ERR "SELinux: error reading MLS range of "
-			       "context\n");
-			rc = -EINVAL;
+		rc = mls_read_range_helper(&c->range, fp);
+		if (rc) {
+			printk(KERN_ERR "SELinux: error reading MLS range of context\n");
 			goto out;
 		}
 	}
 
+	rc = -EINVAL;
 	if (!policydb_context_isvalid(p, c)) {
 		printk(KERN_ERR "SELinux:  invalid security context\n");
 		context_destroy(c);
-		rc = -EINVAL;
+		goto out;
 	}
+	rc = 0;
 out:
 	return rc;
 }
@@ -971,37 +969,36 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[2];
 	u32 len;
 
+	rc = -ENOMEM;
 	perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
-	if (!perdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!perdatum)
+		goto bad;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
+
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
 	rc = hashtab_insert(h, key, perdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+
+	return 0;
 bad:
 	perm_destroy(key, perdatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int common_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1012,14 +1009,13 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len, nel;
 	int i, rc;
 
+	rc = -ENOMEM;
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
-	if (!comdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!comdatum)
+		goto bad;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1031,13 +1027,13 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[3]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
+
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
@@ -1050,11 +1046,10 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, comdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
 	common_destroy(key, comdatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int read_cons_helper(struct constraint_node **nodep, int ncons,
@@ -1078,7 +1073,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 			*nodep = c;
 
 		rc = next_entry(buf, fp, (sizeof(u32) * 2));
-		if (rc < 0)
+		if (rc)
 			return rc;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
@@ -1095,7 +1090,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 				c->expr = e;
 
 			rc = next_entry(buf, fp, (sizeof(u32) * 3));
-			if (rc < 0)
+			if (rc)
 				return rc;
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
@@ -1123,8 +1118,9 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 				if (depth == (CEXPR_MAXDEPTH - 1))
 					return -EINVAL;
 				depth++;
-				if (ebitmap_read(&e->names, fp))
-					return -EINVAL;
+				rc = ebitmap_read(&e->names, fp);
+				if (rc)
+					return rc;
 				break;
 			default:
 				return -EINVAL;
@@ -1147,14 +1143,13 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len, len2, ncons, nel;
 	int i, rc;
 
+	rc = -ENOMEM;
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
-	if (!cladatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!cladatum)
+		goto bad;
 
 	rc = next_entry(buf, fp, sizeof(u32)*6);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1169,33 +1164,30 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	ncons = le32_to_cpu(buf[5]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
+
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
 	if (len2) {
+		rc = -ENOMEM;
 		cladatum->comkey = kmalloc(len2 + 1, GFP_KERNEL);
-		if (!cladatum->comkey) {
-			rc = -ENOMEM;
+		if (!cladatum->comkey)
 			goto bad;
-		}
 		rc = next_entry(cladatum->comkey, fp, len2);
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		cladatum->comkey[len2] = '\0';
 
-		cladatum->comdatum = hashtab_search(p->p_commons.table,
-						    cladatum->comkey);
+		rc = -EINVAL;
+		cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
 		if (!cladatum->comdatum) {
-			printk(KERN_ERR "SELinux:  unknown common %s\n",
-			       cladatum->comkey);
-			rc = -EINVAL;
+			printk(KERN_ERR "SELinux:  unknown common %s\n", cladatum->comkey);
 			goto bad;
 		}
 	}
@@ -1212,7 +1204,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) {
 		/* grab the validatetrans rules */
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
 		rc = read_cons_helper(&cladatum->validatetrans, ncons, 1, fp);
@@ -1224,12 +1216,10 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int role_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1240,17 +1230,16 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
+	rc = -ENOMEM;
 	role = kzalloc(sizeof(*role), GFP_KERNEL);
-	if (!role) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!role)
+		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		to_read = 3;
 
 	rc = next_entry(buf, fp, sizeof(buf[0]) * to_read);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1258,13 +1247,13 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
+
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
@@ -1277,10 +1266,10 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 
 	if (strcmp(key, OBJECT_R) == 0) {
+		rc = -EINVAL;
 		if (role->value != OBJECT_R_VAL) {
 			printk(KERN_ERR "SELinux: Role %s has wrong value %d\n",
 			       OBJECT_R, role->value);
-			rc = -EINVAL;
 			goto bad;
 		}
 		rc = 0;
@@ -1290,11 +1279,10 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, role);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
 	role_destroy(key, role, NULL);
-	goto out;
+	return rc;
 }
 
 static int type_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1305,17 +1293,16 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[4];
 	u32 len;
 
+	rc = -ENOMEM;
 	typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
-	if (!typdatum) {
-		rc = -ENOMEM;
-		return rc;
-	}
+	if (!typdatum)
+		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		to_read = 4;
 
 	rc = next_entry(buf, fp, sizeof(buf[0]) * to_read);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1333,24 +1320,22 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
 	rc = hashtab_insert(h, key, typdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
 	type_destroy(key, typdatum, NULL);
-	goto out;
+	return rc;
 }
 
 
@@ -1366,22 +1351,18 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	memset(lp, 0, sizeof(*lp));
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: mls: truncated level\n");
-		goto bad;
+		return rc;
 	}
 	lp->sens = le32_to_cpu(buf[0]);
 
-	if (ebitmap_read(&lp->cat, fp)) {
-		printk(KERN_ERR "SELinux: mls:  error reading level "
-		       "categories\n");
-		goto bad;
+	rc = ebitmap_read(&lp->cat, fp);
+	if (rc) {
+		printk(KERN_ERR "SELinux: mls:  error reading level categories\n");
+		return rc;
 	}
-
 	return 0;
-
-bad:
-	return -EINVAL;
 }
 
 static int user_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1392,17 +1373,16 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
+	rc = -ENOMEM;
 	usrdatum = kzalloc(sizeof(*usrdatum), GFP_KERNEL);
-	if (!usrdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!usrdatum)
+		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		to_read = 3;
 
 	rc = next_entry(buf, fp, sizeof(buf[0]) * to_read);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1410,13 +1390,12 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
@@ -1436,11 +1415,10 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, usrdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
 	user_destroy(key, usrdatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1451,47 +1429,43 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[2];
 	u32 len;
 
+	rc = -ENOMEM;
 	levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
-	if (!levdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!levdatum)
+		goto bad;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_ATOMIC);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
+	rc = -ENOMEM;
 	levdatum->level = kmalloc(sizeof(struct mls_level), GFP_ATOMIC);
-	if (!levdatum->level) {
-		rc = -ENOMEM;
+	if (!levdatum->level)
 		goto bad;
-	}
-	if (mls_read_level(levdatum->level, fp)) {
-		rc = -EINVAL;
+
+	rc = mls_read_level(levdatum->level, fp);
+	if (rc)
 		goto bad;
-	}
 
 	rc = hashtab_insert(h, key, levdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
 	sens_destroy(key, levdatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1502,39 +1476,35 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
+	rc = -ENOMEM;
 	catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
-	if (!catdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!catdatum)
+		goto bad;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_ATOMIC);
-	if (!key) {
-		rc = -ENOMEM;
+	if (!key)
 		goto bad;
-	}
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	key[len] = '\0';
 
 	rc = hashtab_insert(h, key, catdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
-
+	return 0;
 bad:
 	cat_destroy(key, catdatum, NULL);
-	goto out;
+	return rc;
 }
 
 static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
@@ -2056,13 +2026,14 @@ int policydb_read(struct policydb *p, void *fp)
 
 	rc = policydb_init(p);
 	if (rc)
-		goto out;
+		return rc;
 
 	/* Read the magic number and string length. */
 	rc = next_entry(buf, fp, sizeof(u32) * 2);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
+	rc = -EINVAL;
 	if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
 		printk(KERN_ERR "SELinux:  policydb magic number 0x%x does "
 		       "not match expected magic number 0x%x\n",
@@ -2070,6 +2041,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	}
 
+	rc = -EINVAL;
 	len = le32_to_cpu(buf[1]);
 	if (len != strlen(POLICYDB_STRING)) {
 		printk(KERN_ERR "SELinux:  policydb string length %d does not "
@@ -2077,19 +2049,23 @@ int policydb_read(struct policydb *p, void *fp)
 		       len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
+
+	rc = -ENOMEM;
 	policydb_str = kmalloc(len + 1, GFP_KERNEL);
 	if (!policydb_str) {
 		printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
 		       "string of length %d\n", len);
-		rc = -ENOMEM;
 		goto bad;
 	}
+
 	rc = next_entry(policydb_str, fp, len);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux:  truncated policydb string identifier\n");
 		kfree(policydb_str);
 		goto bad;
 	}
+
+	rc = -EINVAL;
 	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		printk(KERN_ERR "SELinux:  policydb string %s does not match "
@@ -2103,9 +2079,10 @@ int policydb_read(struct policydb *p, void *fp)
 
 	/* Read the version and table sizes. */
 	rc = next_entry(buf, fp, sizeof(u32)*4);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
+	rc = -EINVAL;
 	p->policyvers = le32_to_cpu(buf[0]);
 	if (p->policyvers < POLICYDB_VERSION_MIN ||
 	    p->policyvers > POLICYDB_VERSION_MAX) {
@@ -2118,6 +2095,7 @@ int policydb_read(struct policydb *p, void *fp)
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
 		p->mls_enabled = 1;
 
+		rc = -EINVAL;
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
 			printk(KERN_ERR "SELinux: security policydb version %d "
 				"(MLS) not backwards compatible\n",
@@ -2128,14 +2106,19 @@ int policydb_read(struct policydb *p, void *fp)
 	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
 	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
 
-	if (p->policyvers >= POLICYDB_VERSION_POLCAP &&
-	    ebitmap_read(&p->policycaps, fp) != 0)
-		goto bad;
+	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
+		rc = ebitmap_read(&p->policycaps, fp);
+		if (rc)
+			goto bad;
+	}
 
-	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
-	    ebitmap_read(&p->permissive_map, fp) != 0)
-		goto bad;
+	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE) {
+		rc = ebitmap_read(&p->permissive_map, fp);
+		if (rc)
+			goto bad;
+	}
 
+	rc = -EINVAL;
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "SELinux:  unable to find policy compat info "
@@ -2143,6 +2126,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	}
 
+	rc = -EINVAL;
 	if (le32_to_cpu(buf[2]) != info->sym_num ||
 		le32_to_cpu(buf[3]) != info->ocon_num) {
 		printk(KERN_ERR "SELinux:  policydb table sizes (%d,%d) do "
@@ -2154,7 +2138,7 @@ int policydb_read(struct policydb *p, void *fp)
 
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32)*2);
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
@@ -2178,60 +2162,58 @@ int policydb_read(struct policydb *p, void *fp)
 	}
 
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 	ltr = NULL;
 	for (i = 0; i < nel; i++) {
+		rc = -ENOMEM;
 		tr = kzalloc(sizeof(*tr), GFP_KERNEL);
-		if (!tr) {
-			rc = -ENOMEM;
+		if (!tr)
 			goto bad;
-		}
 		if (ltr)
 			ltr->next = tr;
 		else
 			p->role_tr = tr;
 		rc = next_entry(buf, fp, sizeof(u32)*3);
-		if (rc < 0)
+		if (rc)
 			goto bad;
+
+		rc = -EINVAL;
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
 		tr->new_role = le32_to_cpu(buf[2]);
 		if (!policydb_role_isvalid(p, tr->role) ||
 		    !policydb_type_isvalid(p, tr->type) ||
-		    !policydb_role_isvalid(p, tr->new_role)) {
-			rc = -EINVAL;
+		    !policydb_role_isvalid(p, tr->new_role))
 			goto bad;
-		}
 		ltr = tr;
 	}
 
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
 	for (i = 0; i < nel; i++) {
+		rc = -ENOMEM;
 		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
-		if (!ra) {
-			rc = -ENOMEM;
+		if (!ra)
 			goto bad;
-		}
 		if (lra)
 			lra->next = ra;
 		else
 			p->role_allow = ra;
 		rc = next_entry(buf, fp, sizeof(u32)*2);
-		if (rc < 0)
+		if (rc)
 			goto bad;
+
+		rc = -EINVAL;
 		ra->role = le32_to_cpu(buf[0]);
 		ra->new_role = le32_to_cpu(buf[1]);
 		if (!policydb_role_isvalid(p, ra->role) ||
-		    !policydb_role_isvalid(p, ra->new_role)) {
-			rc = -EINVAL;
+		    !policydb_role_isvalid(p, ra->new_role))
 			goto bad;
-		}
 		lra = ra;
 	}
 
@@ -2243,13 +2225,14 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
+	rc = -EINVAL;
 	p->process_class = string_to_security_class(p, "process");
 	if (!p->process_class)
 		goto bad;
-	p->process_trans_perms = string_to_av_perm(p, p->process_class,
-						   "transition");
-	p->process_trans_perms |= string_to_av_perm(p, p->process_class,
-						    "dyntransition");
+
+	rc = -EINVAL;
+	p->process_trans_perms = string_to_av_perm(p, p->process_class, "transition");
+	p->process_trans_perms |= string_to_av_perm(p, p->process_class, "dyntransition");
 	if (!p->process_trans_perms)
 		goto bad;
 
@@ -2302,8 +2285,6 @@ int policydb_read(struct policydb *p, void *fp)
 out:
 	return rc;
 bad:
-	if (!rc)
-		rc = -EINVAL;
 	policydb_destroy(p);
 	goto out;
 }
@@ -3066,7 +3047,7 @@ int policydb_write(struct policydb *p, void *fp)
 	if (!info) {
 		printk(KERN_ERR "SELinux: compatibility lookup failed for policy "
 		    "version %d", p->policyvers);
-		return rc;
+		return -EINVAL;
 	}
 
 	buf[0] = cpu_to_le32(p->policyvers);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
