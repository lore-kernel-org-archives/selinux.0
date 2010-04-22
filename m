From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/3] SELinux: standardize return code handling in policydb.c
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 22 Apr 2010 13:36:32 -0400
Message-ID: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
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

 security/selinux/ss/policydb.c |  590 +++++++++++++++++++---------------------
 1 files changed, 282 insertions(+), 308 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4f584fb..c58f733 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -144,35 +144,33 @@ static int roles_init(struct policydb *p)
 {
 	char *key = NULL;
 	int rc;
-	struct role_datum *role;
+	struct role_datum *role = NULL;
 
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
 	key = kmalloc(strlen(OBJECT_R) + 1, GFP_KERNEL);
-	if (!key) {
-		rc = -ENOMEM;
-		goto out_free_role;
-	}
+	if (!key)
+		goto out;
+
 	strcpy(key, OBJECT_R);
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
@@ -224,13 +222,12 @@ static int policydb_init(struct policydb *p)
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
-out:
-	return rc;
+	return 0;
 
 out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);
-	goto out;
+	return rc;
 }
 
 /*
@@ -380,30 +377,27 @@ static int policydb_index_classes(struct policydb *p)
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
@@ -449,7 +443,7 @@ static inline void rangetr_hash_eval(struct hashtab *h)
  */
 static int policydb_index_others(struct policydb *p)
 {
-	int i, rc = 0;
+	int i, rc;
 
 	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
@@ -466,47 +460,42 @@ static int policydb_index_others(struct policydb *p)
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
@@ -765,19 +754,21 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
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
+
+		rc = -EINVAL;
 		if (sidtab_insert(s, c->sid[0], &c->context[0])) {
-			printk(KERN_ERR "SELinux:  unable to load initial "
-			       "SID %s.\n", c->u.name);
-			rc = -EINVAL;
+			printk(KERN_ERR "SELinux:  unable to load initial SID %s.\n",
+				c->u.name);
 			goto out;
 		}
 	}
+	rc = 0;
 out:
 	return rc;
 }
@@ -864,17 +855,19 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 	if (rc < 0)
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
 	if (rc < 0) {
 		printk(KERN_ERR "SELinux: mls:  truncated range\n");
 		goto out;
 	}
+
 	r->level[0].sens = le32_to_cpu(buf[0]);
 	if (items > 1)
 		r->level[1].sens = le32_to_cpu(buf[1]);
@@ -883,15 +876,13 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 
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
@@ -902,12 +893,12 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 		}
 	}
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
+
 bad_high:
 	ebitmap_destroy(&r->level[0].cat);
-	goto out;
+out:
+	return rc;
 }
 
 /*
@@ -922,7 +913,7 @@ static int context_read_and_validate(struct context *c,
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: context truncated\n");
 		goto out;
 	}
@@ -930,19 +921,20 @@ static int context_read_and_validate(struct context *c,
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		rc = -EINVAL;
 		if (mls_read_range_helper(&c->range, fp)) {
-			printk(KERN_ERR "SELinux: error reading MLS range of "
-			       "context\n");
-			rc = -EINVAL;
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
@@ -961,37 +953,37 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
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
-	perm_destroy(key, perdatum, NULL);
-	goto out;
+	if (perdatum)
+		perm_destroy(key, perdatum, NULL);
+	return rc;
 }
 
 static int common_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1002,14 +994,13 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1021,13 +1012,13 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
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
 
@@ -1040,11 +1031,11 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, comdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
-	common_destroy(key, comdatum, NULL);
-	goto out;
+	if (comdatum)
+		common_destroy(key, comdatum, NULL);
+	return rc;
 }
 
 static int read_cons_helper(struct constraint_node **nodep, int ncons,
@@ -1068,7 +1059,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 			*nodep = c;
 
 		rc = next_entry(buf, fp, (sizeof(u32) * 2));
-		if (rc < 0)
+		if (rc)
 			return rc;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
@@ -1085,7 +1076,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 				c->expr = e;
 
 			rc = next_entry(buf, fp, (sizeof(u32) * 3));
-			if (rc < 0)
+			if (rc)
 				return rc;
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
@@ -1137,14 +1128,13 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1159,33 +1149,30 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 
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
 		if (rc < 0)
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
@@ -1202,7 +1189,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) {
 		/* grab the validatetrans rules */
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
 		rc = read_cons_helper(&cladatum->validatetrans, ncons, 1, fp);
@@ -1214,12 +1201,11 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
 bad:
-	cls_destroy(key, cladatum, NULL);
-	goto out;
+	if (cladatum)
+		cls_destroy(key, cladatum, NULL);
+	return rc;
 }
 
 static int role_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1230,11 +1216,10 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1248,13 +1233,13 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
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
 
@@ -1267,10 +1252,10 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1280,11 +1265,11 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, role);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
-	role_destroy(key, role, NULL);
-	goto out;
+	if (role)
+		role_destroy(key, role, NULL);
+	return rc;
 }
 
 static int type_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1295,17 +1280,16 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1323,24 +1307,23 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
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
-	type_destroy(key, typdatum, NULL);
-	goto out;
+	if (typdatum)
+		type_destroy(key, typdatum, NULL);
+	return rc;
 }
 
 
@@ -1356,22 +1339,21 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	memset(lp, 0, sizeof(*lp));
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: mls: truncated level\n");
 		goto bad;
 	}
 	lp->sens = le32_to_cpu(buf[0]);
 
+	rc = -EINVAL;
 	if (ebitmap_read(&lp->cat, fp)) {
 		printk(KERN_ERR "SELinux: mls:  error reading level "
 		       "categories\n");
 		goto bad;
 	}
-
-	return 0;
-
+	rc = 0;
 bad:
-	return -EINVAL;
+	return rc;
 }
 
 static int user_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1382,17 +1364,16 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
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
@@ -1400,13 +1381,12 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
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
 
@@ -1426,11 +1406,11 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	rc = hashtab_insert(h, key, usrdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
-	user_destroy(key, usrdatum, NULL);
-	goto out;
+	if (usrdatum)
+		user_destroy(key, usrdatum, NULL);
+	return rc;
 }
 
 static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1441,47 +1421,43 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
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
+	rc = -EINVAL;
+	if (mls_read_level(levdatum->level, fp))
 		goto bad;
-	}
 
 	rc = hashtab_insert(h, key, levdatum);
 	if (rc)
 		goto bad;
-out:
-	return rc;
+	return 0;
 bad:
-	sens_destroy(key, levdatum, NULL);
-	goto out;
+	if (levdatum)
+		sens_destroy(key, levdatum, NULL);
+	return rc;
 }
 
 static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
@@ -1492,39 +1468,37 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
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
+	return 0;
 
 bad:
-	cat_destroy(key, catdatum, NULL);
-	goto out;
+	if (catdatum)
+		cat_destroy(key, catdatum, NULL);
+	return rc;
 }
 
 static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
@@ -1710,26 +1684,27 @@ int policydb_read(struct policydb *p, void *fp)
 {
 	struct role_allow *ra, *lra;
 	struct role_trans *tr, *ltr;
-	struct ocontext *l, *c, *newc;
+	struct ocontext *l, *c, *newc = NULL;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
 	__le32 buf[4];
 	u32 nodebuf[8];
 	u32 len, len2, nprim, nel, nel2;
-	char *policydb_str;
+	char *policydb_str = NULL;
 	struct policydb_compat_info *info;
-	struct range_trans *rt;
-	struct mls_range *r;
+	struct range_trans *rt = NULL;
+	struct mls_range *r = NULL;
 
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
@@ -1737,6 +1712,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	}
 
+	rc = -EINVAL;
 	len = le32_to_cpu(buf[1]);
 	if (len != strlen(POLICYDB_STRING)) {
 		printk(KERN_ERR "SELinux:  policydb string length %d does not "
@@ -1744,19 +1720,23 @@ int policydb_read(struct policydb *p, void *fp)
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
@@ -1770,9 +1750,10 @@ int policydb_read(struct policydb *p, void *fp)
 
 	/* Read the version and table sizes. */
 	rc = next_entry(buf, fp, sizeof(u32)*4);
-	if (rc < 0)
+	if (rc)
 		goto bad;
 
+	rc = -EINVAL;
 	p->policyvers = le32_to_cpu(buf[0]);
 	if (p->policyvers < POLICYDB_VERSION_MIN ||
 	    p->policyvers > POLICYDB_VERSION_MAX) {
@@ -1785,6 +1766,7 @@ int policydb_read(struct policydb *p, void *fp)
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
 		p->mls_enabled = 1;
 
+		rc = -EINVAL;
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
 			printk(KERN_ERR "SELinux: security policydb version %d "
 				"(MLS) not backwards compatible\n",
@@ -1795,14 +1777,17 @@ int policydb_read(struct policydb *p, void *fp)
 	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
 	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
 
+	rc = -EINVAL;
 	if (p->policyvers >= POLICYDB_VERSION_POLCAP &&
 	    ebitmap_read(&p->policycaps, fp) != 0)
 		goto bad;
 
+	rc = -EINVAL;
 	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
 	    ebitmap_read(&p->permissive_map, fp) != 0)
 		goto bad;
 
+	rc = -EINVAL;
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "SELinux:  unable to find policy compat info "
@@ -1810,6 +1795,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	}
 
+	rc = -EINVAL;
 	if (le32_to_cpu(buf[2]) != info->sym_num ||
 		le32_to_cpu(buf[3]) != info->ocon_num) {
 		printk(KERN_ERR "SELinux:  policydb table sizes (%d,%d) do "
@@ -1821,7 +1807,7 @@ int policydb_read(struct policydb *p, void *fp)
 
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32)*2);
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
@@ -1845,60 +1831,58 @@ int policydb_read(struct policydb *p, void *fp)
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
 
@@ -1910,38 +1894,37 @@ int policydb_read(struct policydb *p, void *fp)
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
 
 	for (i = 0; i < info->ocon_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		nel = le32_to_cpu(buf[0]);
 		l = NULL;
 		for (j = 0; j < nel; j++) {
+			rc = -ENOMEM;
 			c = kzalloc(sizeof(*c), GFP_KERNEL);
-			if (!c) {
-				rc = -ENOMEM;
+			if (!c)
 				goto bad;
-			}
 			if (l)
 				l->next = c;
 			else
 				p->ocontexts[i] = c;
 			l = c;
-			rc = -EINVAL;
 			switch (i) {
 			case OCON_ISID:
 				rc = next_entry(buf, fp, sizeof(u32));
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->sid[0] = le32_to_cpu(buf[0]);
 				rc = context_read_and_validate(&c->context[0], p, fp);
@@ -1951,16 +1934,15 @@ int policydb_read(struct policydb *p, void *fp)
 			case OCON_FS:
 			case OCON_NETIF:
 				rc = next_entry(buf, fp, sizeof(u32));
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				len = le32_to_cpu(buf[0]);
+				rc = -ENOMEM;
 				c->u.name = kmalloc(len + 1, GFP_KERNEL);
-				if (!c->u.name) {
-					rc = -ENOMEM;
+				if (!c->u.name)
 					goto bad;
-				}
 				rc = next_entry(c->u.name, fp, len);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->u.name[len] = 0;
 				rc = context_read_and_validate(&c->context[0], p, fp);
@@ -1972,7 +1954,7 @@ int policydb_read(struct policydb *p, void *fp)
 				break;
 			case OCON_PORT:
 				rc = next_entry(buf, fp, sizeof(u32)*3);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->u.port.protocol = le32_to_cpu(buf[0]);
 				c->u.port.low_port = le32_to_cpu(buf[1]);
@@ -1983,7 +1965,7 @@ int policydb_read(struct policydb *p, void *fp)
 				break;
 			case OCON_NODE:
 				rc = next_entry(nodebuf, fp, sizeof(u32) * 2);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->u.node.addr = nodebuf[0]; /* network order */
 				c->u.node.mask = nodebuf[1]; /* network order */
@@ -1993,19 +1975,18 @@ int policydb_read(struct policydb *p, void *fp)
 				break;
 			case OCON_FSUSE:
 				rc = next_entry(buf, fp, sizeof(u32)*2);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->v.behavior = le32_to_cpu(buf[0]);
 				if (c->v.behavior > SECURITY_FS_USE_NONE)
 					goto bad;
 				len = le32_to_cpu(buf[1]);
+				rc = -ENOMEM;
 				c->u.name = kmalloc(len + 1, GFP_KERNEL);
-				if (!c->u.name) {
-					rc = -ENOMEM;
+				if (!c->u.name)
 					goto bad;
-				}
 				rc = next_entry(c->u.name, fp, len);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				c->u.name[len] = 0;
 				rc = context_read_and_validate(&c->context[0], p, fp);
@@ -2016,13 +1997,14 @@ int policydb_read(struct policydb *p, void *fp)
 				int k;
 
 				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
-				if (rc < 0)
+				if (rc)
 					goto bad;
 				for (k = 0; k < 4; k++)
 					c->u.node6.addr[k] = nodebuf[k];
 				for (k = 0; k < 4; k++)
 					c->u.node6.mask[k] = nodebuf[k+4];
-				if (context_read_and_validate(&c->context[0], p, fp))
+				rc = context_read_and_validate(&c->context[0], p, fp);
+				if (rc)
 					goto bad;
 				break;
 			}
@@ -2031,30 +2013,28 @@ int policydb_read(struct policydb *p, void *fp)
 	}
 
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
+	if (rc)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 	genfs_p = NULL;
-	rc = -EINVAL;
 	for (i = 0; i < nel; i++) {
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		len = le32_to_cpu(buf[0]);
+		rc = -ENOMEM;
 		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
-		if (!newgenfs) {
-			rc = -ENOMEM;
+		if (!newgenfs)
 			goto bad;
-		}
 
 		newgenfs->fstype = kmalloc(len + 1, GFP_KERNEL);
+		rc = -ENOMEM;
 		if (!newgenfs->fstype) {
-			rc = -ENOMEM;
 			kfree(newgenfs);
 			goto bad;
 		}
 		rc = next_entry(newgenfs->fstype, fp, len);
-		if (rc < 0) {
+		if (rc) {
 			kfree(newgenfs->fstype);
 			kfree(newgenfs);
 			goto bad;
@@ -2062,9 +2042,10 @@ int policydb_read(struct policydb *p, void *fp)
 		newgenfs->fstype[len] = 0;
 		for (genfs_p = NULL, genfs = p->genfs; genfs;
 		     genfs_p = genfs, genfs = genfs->next) {
+			rc = -EINVAL;
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
-				printk(KERN_ERR "SELinux:  dup genfs "
-				       "fstype %s\n", newgenfs->fstype);
+				printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
+					newgenfs->fstype);
 				kfree(newgenfs->fstype);
 				kfree(newgenfs);
 				goto bad;
@@ -2078,45 +2059,45 @@ int policydb_read(struct policydb *p, void *fp)
 		else
 			p->genfs = newgenfs;
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		nel2 = le32_to_cpu(buf[0]);
 		for (j = 0; j < nel2; j++) {
 			rc = next_entry(buf, fp, sizeof(u32));
-			if (rc < 0)
+			if (rc)
 				goto bad;
 			len = le32_to_cpu(buf[0]);
 
+			rc = -ENOMEM;
 			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
-			if (!newc) {
-				rc = -ENOMEM;
+			if (!newc)
 				goto bad;
-			}
 
 			newc->u.name = kmalloc(len + 1, GFP_KERNEL);
-			if (!newc->u.name) {
-				rc = -ENOMEM;
-				goto bad_newc;
-			}
+			rc = -ENOMEM;
+			if (!newc->u.name)
+				goto bad;
 			rc = next_entry(newc->u.name, fp, len);
-			if (rc < 0)
-				goto bad_newc;
+			if (rc)
+				goto bad;
 			newc->u.name[len] = 0;
 			rc = next_entry(buf, fp, sizeof(u32));
-			if (rc < 0)
-				goto bad_newc;
+			if (rc)
+				goto bad;
 			newc->v.sclass = le32_to_cpu(buf[0]);
-			if (context_read_and_validate(&newc->context[0], p, fp))
-				goto bad_newc;
+
+			rc = context_read_and_validate(&newc->context[0], p, fp);
+			if (rc)
+				goto bad;
 			for (l = NULL, c = newgenfs->head; c;
 			     l = c, c = c->next) {
+				rc = -EINVAL;
 				if (!strcmp(newc->u.name, c->u.name) &&
 				    (!c->v.sclass || !newc->v.sclass ||
 				     newc->v.sclass == c->v.sclass)) {
-					printk(KERN_ERR "SELinux:  dup genfs "
-					       "entry (%s,%s)\n",
+					printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
 					       newgenfs->fstype, c->u.name);
-					goto bad_newc;
+					goto bad;
 				}
 				len = strlen(newc->u.name);
 				len2 = strlen(c->u.name);
@@ -2129,72 +2110,63 @@ int policydb_read(struct policydb *p, void *fp)
 				l->next = newc;
 			else
 				newgenfs->head = newc;
+			newc = NULL;
 		}
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
 		int new_rangetr = p->policyvers >= POLICYDB_VERSION_RANGETRANS;
 		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
+		if (rc)
 			goto bad;
 		nel = le32_to_cpu(buf[0]);
 		for (i = 0; i < nel; i++) {
+			rc = -ENOMEM;
 			rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-			if (!rt) {
-				rc = -ENOMEM;
+			if (!rt)
 				goto bad;
-			}
 			rc = next_entry(buf, fp, (sizeof(u32) * 2));
-			if (rc < 0) {
-				kfree(rt);
+			if (rc)
 				goto bad;
-			}
 			rt->source_type = le32_to_cpu(buf[0]);
 			rt->target_type = le32_to_cpu(buf[1]);
 			if (new_rangetr) {
 				rc = next_entry(buf, fp, sizeof(u32));
-				if (rc < 0) {
-					kfree(rt);
+				if (rc)
 					goto bad;
-				}
 				rt->target_class = le32_to_cpu(buf[0]);
 			} else
 				rt->target_class = p->process_class;
+			rc = -EINVAL;
 			if (!policydb_type_isvalid(p, rt->source_type) ||
 			    !policydb_type_isvalid(p, rt->target_type) ||
-			    !policydb_class_isvalid(p, rt->target_class)) {
-				kfree(rt);
-				rc = -EINVAL;
+			    !policydb_class_isvalid(p, rt->target_class))
 				goto bad;
-			}
+
+			rc = -ENOMEM;
 			r = kzalloc(sizeof(*r), GFP_KERNEL);
-			if (!r) {
-				kfree(rt);
-				rc = -ENOMEM;
+			if (!r)
 				goto bad;
-			}
+
 			rc = mls_read_range_helper(r, fp);
-			if (rc) {
-				kfree(rt);
-				kfree(r);
+			if (rc)
 				goto bad;
-			}
+
+			rc = -EINVAL;
 			if (!mls_range_isvalid(p, r)) {
 				printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
-				kfree(rt);
-				kfree(r);
 				goto bad;
 			}
 			rc = hashtab_insert(p->range_tr, rt, r);
-			if (rc) {
-				kfree(rt);
-				kfree(r);
+			if (rc)
 				goto bad;
-			}
 		}
 		rangetr_hash_eval(p->range_tr);
+		rt = NULL;
+		r = NULL;
 	}
 
+	rc = -EINVAL;
 	p->type_attr_map = kmalloc(p->p_types.nprim * sizeof(struct ebitmap), GFP_KERNEL);
 	if (!p->type_attr_map)
 		goto bad;
@@ -2202,10 +2174,12 @@ int policydb_read(struct policydb *p, void *fp)
 	for (i = 0; i < p->p_types.nprim; i++) {
 		ebitmap_init(&p->type_attr_map[i]);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
+			rc = -EINVAL;
 			if (ebitmap_read(&p->type_attr_map[i], fp))
 				goto bad;
 		}
 		/* add the type itself as the degenerate case */
+		rc = -EINVAL;
 		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
 				goto bad;
 	}
@@ -2214,14 +2188,14 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = 0;
-out:
-	return rc;
-bad_newc:
-	ocontext_destroy(newc, OCON_FSUSE);
+	return 0;
 bad:
-	if (!rc)
-		rc = -EINVAL;
+	BUG_ON(rc >= 0);
+	if (newc)
+		ocontext_destroy(newc, OCON_FSUSE);
+	kfree(policydb_str);
+	kfree(rt);
+	kfree(r);
 	policydb_destroy(p);
-	goto out;
+	return rc;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
