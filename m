From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>, Doug
 Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
CC: peter <pme@localhost.localdomain>
Date: Wed, 30 May 2018 16:11:00 +0200
Message-ID: <20180530141104.28569-2-peter.enderborg@sony.com>
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH V3 1/5 selinux-next] selinux: Make allocation atomic
 in policydb objects functions.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: peter <pme@localhost.localdomain>

As preparation for RCU the allocation need to be atomic,
there is a lot of them so they do in this patch.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/avtab.c       |   8 +--
 security/selinux/ss/conditional.c |  14 ++---
 security/selinux/ss/ebitmap.c     |   3 +-
 security/selinux/ss/hashtab.c     |   6 +--
 security/selinux/ss/policydb.c    | 104 +++++++++++++++++++-------------------
 5 files changed, 69 insertions(+), 66 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index a2c9148b0662..1114a308aa94 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -72,13 +72,13 @@ avtab_insert_node(struct avtab *h, int hvalue,
 {
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
-	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
+	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_ATOMIC);
 	if (newnode == NULL)
 		return NULL;
 	newnode->key = *key;
 
 	if (key->specified & AVTAB_XPERMS) {
-		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_KERNEL);
+		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_ATOMIC);
 		if (xperms == NULL) {
 			kmem_cache_free(avtab_node_cachep, newnode);
 			return NULL;
@@ -95,7 +95,7 @@ avtab_insert_node(struct avtab *h, int hvalue,
 	} else {
 		newnode->next = flex_array_get_ptr(h->htable, hvalue);
 		if (flex_array_put_ptr(h->htable, hvalue, newnode,
-				       GFP_KERNEL|__GFP_ZERO)) {
+				       GFP_ATOMIC|__GFP_ZERO)) {
 			kmem_cache_free(avtab_node_cachep, newnode);
 			return NULL;
 		}
@@ -330,7 +330,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	mask = nslot - 1;
 
 	h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
-				     GFP_KERNEL | __GFP_ZERO);
+				     GFP_ATOMIC | __GFP_ZERO);
 	if (!h->htable)
 		return -ENOMEM;
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index c91543a617ac..a09c8a8e9472 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -178,7 +178,7 @@ int cond_init_bool_indexes(struct policydb *p)
 	kfree(p->bool_val_to_struct);
 	p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
 					      sizeof(*p->bool_val_to_struct),
-					      GFP_KERNEL);
+					      GFP_ATOMIC);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
 	return 0;
@@ -205,7 +205,7 @@ int cond_index_bool(void *key, void *datum, void *datap)
 
 	fa = p->sym_val_to_name[SYM_BOOLS];
 	if (flex_array_put_ptr(fa, booldatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
+			       GFP_ATOMIC | __GFP_ZERO))
 		BUG();
 	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
 
@@ -227,7 +227,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len;
 	int rc;
 
-	booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
+	booldatum = kzalloc(sizeof(*booldatum), GFP_ATOMIC);
 	if (!booldatum)
 		return -ENOMEM;
 
@@ -247,7 +247,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 		goto err;
 
 	rc = -ENOMEM;
-	key = kmalloc(len + 1, GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_ATOMIC);
 	if (!key)
 		goto err;
 	rc = next_entry(key, fp, len);
@@ -332,7 +332,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 		goto err;
 	}
 
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	list = kzalloc(sizeof(*list), GFP_ATOMIC);
 	if (!list) {
 		rc = -ENOMEM;
 		goto err;
@@ -420,7 +420,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			goto err;
 
 		rc = -ENOMEM;
-		expr = kzalloc(sizeof(*expr), GFP_KERNEL);
+		expr = kzalloc(sizeof(*expr), GFP_ATOMIC);
 		if (!expr)
 			goto err;
 
@@ -471,7 +471,7 @@ int cond_read_list(struct policydb *p, void *fp)
 
 	for (i = 0; i < len; i++) {
 		rc = -ENOMEM;
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		node = kzalloc(sizeof(*node), GFP_ATOMIC);
 		if (!node)
 			goto err;
 
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 5ae8c61b75bf..a49fabe6f744 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -403,7 +403,8 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
 			struct ebitmap_node *tmp;
-			tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
+			tmp = kmem_cache_zalloc(ebitmap_node_cachep,
+						GFP_ATOMIC);
 			if (!tmp) {
 				printk(KERN_ERR
 				       "SELinux: ebitmap: out of memory\n");
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index ebfdaa31ee32..0944b1f8060e 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -19,7 +19,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	struct hashtab *p;
 	u32 i;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_ATOMIC);
 	if (!p)
 		return p;
 
@@ -27,7 +27,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	p->nel = 0;
 	p->hash_value = hash_value;
 	p->keycmp = keycmp;
-	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
+	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_ATOMIC);
 	if (!p->htable) {
 		kfree(p);
 		return NULL;
@@ -60,7 +60,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	if (cur && (h->keycmp(h, key, cur->key) == 0))
 		return -EEXIST;
 
-	newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_KERNEL);
+	newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_ATOMIC);
 	if (!newnode)
 		return -ENOMEM;
 	newnode->key = key;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6e8c8056d7ad..2a0e21d8c275 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -188,7 +188,7 @@ static int roles_init(struct policydb *p)
 	int rc;
 	struct role_datum *role;
 
-	role = kzalloc(sizeof(*role), GFP_KERNEL);
+	role = kzalloc(sizeof(*role), GFP_ATOMIC);
 	if (!role)
 		return -ENOMEM;
 
@@ -198,7 +198,7 @@ static int roles_init(struct policydb *p)
 		goto out;
 
 	rc = -ENOMEM;
-	key = kstrdup(OBJECT_R, GFP_KERNEL);
+	key = kstrdup(OBJECT_R, GFP_ATOMIC);
 	if (!key)
 		goto out;
 
@@ -350,7 +350,7 @@ static int common_index(void *key, void *datum, void *datap)
 
 	fa = p->sym_val_to_name[SYM_COMMONS];
 	if (flex_array_put_ptr(fa, comdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
+			       GFP_ATOMIC | __GFP_ZERO))
 		BUG();
 	return 0;
 }
@@ -367,7 +367,7 @@ static int class_index(void *key, void *datum, void *datap)
 		return -EINVAL;
 	fa = p->sym_val_to_name[SYM_CLASSES];
 	if (flex_array_put_ptr(fa, cladatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
+			       GFP_ATOMIC | __GFP_ZERO))
 		BUG();
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 	return 0;
@@ -388,7 +388,7 @@ static int role_index(void *key, void *datum, void *datap)
 
 	fa = p->sym_val_to_name[SYM_ROLES];
 	if (flex_array_put_ptr(fa, role->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
+			       GFP_ATOMIC | __GFP_ZERO))
 		BUG();
 	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
@@ -410,12 +410,12 @@ static int type_index(void *key, void *datum, void *datap)
 			return -EINVAL;
 		fa = p->sym_val_to_name[SYM_TYPES];
 		if (flex_array_put_ptr(fa, typdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
+				       GFP_ATOMIC | __GFP_ZERO))
 			BUG();
 
 		fa = p->type_val_to_struct_array;
 		if (flex_array_put_ptr(fa, typdatum->value - 1, typdatum,
-				       GFP_KERNEL | __GFP_ZERO))
+				       GFP_ATOMIC | __GFP_ZERO))
 			BUG();
 	}
 
@@ -437,7 +437,7 @@ static int user_index(void *key, void *datum, void *datap)
 
 	fa = p->sym_val_to_name[SYM_USERS];
 	if (flex_array_put_ptr(fa, usrdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
+			       GFP_ATOMIC | __GFP_ZERO))
 		BUG();
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
@@ -458,7 +458,7 @@ static int sens_index(void *key, void *datum, void *datap)
 			return -EINVAL;
 		fa = p->sym_val_to_name[SYM_LEVELS];
 		if (flex_array_put_ptr(fa, levdatum->level->sens - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
+				       GFP_ATOMIC | __GFP_ZERO))
 			BUG();
 	}
 
@@ -479,7 +479,7 @@ static int cat_index(void *key, void *datum, void *datap)
 			return -EINVAL;
 		fa = p->sym_val_to_name[SYM_CATS];
 		if (flex_array_put_ptr(fa, catdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
+				       GFP_ATOMIC | __GFP_ZERO))
 			BUG();
 	}
 
@@ -550,31 +550,31 @@ static int policydb_index(struct policydb *p)
 
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
 					 sizeof(*p->class_val_to_struct),
-					 GFP_KERNEL);
+					 GFP_ATOMIC);
 	if (!p->class_val_to_struct)
 		return -ENOMEM;
 
 	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
 					sizeof(*p->role_val_to_struct),
-					GFP_KERNEL);
+					GFP_ATOMIC);
 	if (!p->role_val_to_struct)
 		return -ENOMEM;
 
 	p->user_val_to_struct = kcalloc(p->p_users.nprim,
 					sizeof(*p->user_val_to_struct),
-					GFP_KERNEL);
+					GFP_ATOMIC);
 	if (!p->user_val_to_struct)
 		return -ENOMEM;
 
 	/* Yes, I want the sizeof the pointer, not the structure */
 	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
 						       p->p_types.nprim,
-						       GFP_KERNEL | __GFP_ZERO);
+						       GFP_ATOMIC | __GFP_ZERO);
 	if (!p->type_val_to_struct_array)
 		return -ENOMEM;
 
 	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
-				 p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
+				 p->p_types.nprim, GFP_ATOMIC | __GFP_ZERO);
 	if (rc)
 		goto out;
 
@@ -585,13 +585,14 @@ static int policydb_index(struct policydb *p)
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
 							 p->symtab[i].nprim,
-							 GFP_KERNEL | __GFP_ZERO);
+							 GFP_ATOMIC |
+							 __GFP_ZERO);
 		if (!p->sym_val_to_name[i])
 			return -ENOMEM;
 
 		rc = flex_array_prealloc(p->sym_val_to_name[i],
 					 0, p->symtab[i].nprim,
-					 GFP_KERNEL | __GFP_ZERO);
+					 GFP_ATOMIC | __GFP_ZERO);
 		if (rc)
 			goto out;
 
@@ -1122,7 +1123,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[2];
 	u32 len;
 
-	perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
+	perdatum = kzalloc(sizeof(*perdatum), GFP_ATOMIC);
 	if (!perdatum)
 		return -ENOMEM;
 
@@ -1133,7 +1134,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1155,7 +1156,7 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len, nel;
 	int i, rc;
 
-	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
+	comdatum = kzalloc(sizeof(*comdatum), GFP_ATOMIC);
 	if (!comdatum)
 		return -ENOMEM;
 
@@ -1172,7 +1173,7 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[3]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1228,7 +1229,7 @@ static int read_cons_helper(struct policydb *p,
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
-		c = kzalloc(sizeof(*c), GFP_KERNEL);
+		c = kzalloc(sizeof(*c), GFP_ATOMIC);
 		if (!c)
 			return -ENOMEM;
 
@@ -1245,7 +1246,7 @@ static int read_cons_helper(struct policydb *p,
 		le = NULL;
 		depth = -1;
 		for (j = 0; j < nexpr; j++) {
-			e = kzalloc(sizeof(*e), GFP_KERNEL);
+			e = kzalloc(sizeof(*e), GFP_ATOMIC);
 			if (!e)
 				return -ENOMEM;
 
@@ -1290,7 +1291,7 @@ static int read_cons_helper(struct policydb *p,
 					POLICYDB_VERSION_CONSTRAINT_NAMES) {
 						e->type_names = kzalloc(sizeof
 						(*e->type_names),
-						GFP_KERNEL);
+						GFP_ATOMIC);
 					if (!e->type_names)
 						return -ENOMEM;
 					type_set_init(e->type_names);
@@ -1320,7 +1321,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len, len2, ncons, nel;
 	int i, rc;
 
-	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
+	cladatum = kzalloc(sizeof(*cladatum), GFP_ATOMIC);
 	if (!cladatum)
 		return -ENOMEM;
 
@@ -1340,12 +1341,12 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	ncons = le32_to_cpu(buf[5]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
 	if (len2) {
-		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
+		rc = str_read(&cladatum->comkey, GFP_ATOMIC, fp, len2);
 		if (rc)
 			goto bad;
 
@@ -1413,7 +1414,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	role = kzalloc(sizeof(*role), GFP_KERNEL);
+	role = kzalloc(sizeof(*role), GFP_ATOMIC);
 	if (!role)
 		return -ENOMEM;
 
@@ -1429,7 +1430,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1469,7 +1470,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[4];
 	u32 len;
 
-	typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
+	typdatum = kzalloc(sizeof(*typdatum), GFP_ATOMIC);
 	if (!typdatum)
 		return -ENOMEM;
 
@@ -1495,7 +1496,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1543,7 +1544,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	usrdatum = kzalloc(sizeof(*usrdatum), GFP_KERNEL);
+	usrdatum = kzalloc(sizeof(*usrdatum), GFP_ATOMIC);
 	if (!usrdatum)
 		return -ENOMEM;
 
@@ -1559,7 +1560,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_ATOMIC, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1853,7 +1854,7 @@ static int range_read(struct policydb *p, void *fp)
 	nel = le32_to_cpu(buf[0]);
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
-		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
+		rt = kzalloc(sizeof(*rt), GFP_ATOMIC);
 		if (!rt)
 			goto out;
 
@@ -1878,7 +1879,7 @@ static int range_read(struct policydb *p, void *fp)
 			goto out;
 
 		rc = -ENOMEM;
-		r = kzalloc(sizeof(*r), GFP_KERNEL);
+		r = kzalloc(sizeof(*r), GFP_ATOMIC);
 		if (!r)
 			goto out;
 
@@ -1929,12 +1930,12 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		name = NULL;
 
 		rc = -ENOMEM;
-		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
+		ft = kzalloc(sizeof(*ft), GFP_ATOMIC);
 		if (!ft)
 			goto out;
 
 		rc = -ENOMEM;
-		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
+		otype = kmalloc(sizeof(*otype), GFP_ATOMIC);
 		if (!otype)
 			goto out;
 
@@ -1945,7 +1946,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		len = le32_to_cpu(buf[0]);
 
 		/* path component string */
-		rc = str_read(&name, GFP_KERNEL, fp, len);
+		rc = str_read(&name, GFP_ATOMIC, fp, len);
 		if (rc)
 			goto out;
 
@@ -2011,11 +2012,11 @@ static int genfs_read(struct policydb *p, void *fp)
 		len = le32_to_cpu(buf[0]);
 
 		rc = -ENOMEM;
-		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
+		newgenfs = kzalloc(sizeof(*newgenfs), GFP_ATOMIC);
 		if (!newgenfs)
 			goto out;
 
-		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
+		rc = str_read(&newgenfs->fstype, GFP_ATOMIC, fp, len);
 		if (rc)
 			goto out;
 
@@ -2050,11 +2051,11 @@ static int genfs_read(struct policydb *p, void *fp)
 			len = le32_to_cpu(buf[0]);
 
 			rc = -ENOMEM;
-			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
+			newc = kzalloc(sizeof(*newc), GFP_ATOMIC);
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			rc = str_read(&newc->u.name, GFP_ATOMIC, fp, len);
 			if (rc)
 				goto out;
 
@@ -2120,7 +2121,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 		l = NULL;
 		for (j = 0; j < nel; j++) {
 			rc = -ENOMEM;
-			c = kzalloc(sizeof(*c), GFP_KERNEL);
+			c = kzalloc(sizeof(*c), GFP_ATOMIC);
 			if (!c)
 				goto out;
 			if (l)
@@ -2147,7 +2148,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_ATOMIC, fp, len);
 				if (rc)
 					goto out;
 
@@ -2193,7 +2194,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 
 				len = le32_to_cpu(buf[1]);
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_ATOMIC, fp, len);
 				if (rc)
 					goto out;
 
@@ -2244,7 +2245,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.ibendport.dev_name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.ibendport.dev_name,
+					      GFP_ATOMIC, fp, len);
 				if (rc)
 					goto out;
 
@@ -2311,7 +2313,7 @@ int policydb_read(struct policydb *p, void *fp)
 	}
 
 	rc = -ENOMEM;
-	policydb_str = kmalloc(len + 1, GFP_KERNEL);
+	policydb_str = kmalloc(len + 1, GFP_ATOMIC);
 	if (!policydb_str) {
 		printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
 		       "string of length %d\n", len);
@@ -2433,7 +2435,7 @@ int policydb_read(struct policydb *p, void *fp)
 	ltr = NULL;
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
-		tr = kzalloc(sizeof(*tr), GFP_KERNEL);
+		tr = kzalloc(sizeof(*tr), GFP_ATOMIC);
 		if (!tr)
 			goto bad;
 		if (ltr)
@@ -2472,7 +2474,7 @@ int policydb_read(struct policydb *p, void *fp)
 	lra = NULL;
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
-		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
+		ra = kzalloc(sizeof(*ra), GFP_ATOMIC);
 		if (!ra)
 			goto bad;
 		if (lra)
@@ -2521,13 +2523,13 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = -ENOMEM;
 	p->type_attr_map_array = flex_array_alloc(sizeof(struct ebitmap),
 						  p->p_types.nprim,
-						  GFP_KERNEL | __GFP_ZERO);
+						  GFP_ATOMIC | __GFP_ZERO);
 	if (!p->type_attr_map_array)
 		goto bad;
 
 	/* preallocate so we don't have to worry about the put ever failing */
 	rc = flex_array_prealloc(p->type_attr_map_array, 0, p->p_types.nprim,
-				 GFP_KERNEL | __GFP_ZERO);
+				 GFP_ATOMIC | __GFP_ZERO);
 	if (rc)
 		goto bad;
 
-- 
2.15.1
