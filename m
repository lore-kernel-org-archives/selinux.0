Subject: [patch] libsepol:  eliminate unaligned accesses (Was: Re: wrong
	magic number (using old sources))
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
	 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20070816080523.135750@gmx.net>
	 <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 13:05:23 -0400
Message-Id: <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Full patch follows, replaces the prior short term one.

Rewrite libsepol next_entry function and all callers to copy entry data
from the binary policy into properly aligned buffers, eliminating
unaligned accesses, just as I did for the kernel back in 2004,
http://marc.info/?l=selinux&m=110252376515271&w=2

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/src/avtab.c       |   32 +--
 libsepol/src/conditional.c |   44 ++--
 libsepol/src/ebitmap.c     |   23 +-
 libsepol/src/module.c      |  111 +++++-----
 libsepol/src/policydb.c    |  472 +++++++++++++++++++++++----------------------
 libsepol/src/private.h     |   20 -
 6 files changed, 365 insertions(+), 337 deletions(-)

Index: trunk/libsepol/src/conditional.c
===================================================================
--- trunk/libsepol/src/conditional.c	(revision 2520)
+++ trunk/libsepol/src/conditional.c	(working copy)
@@ -569,15 +569,16 @@
 {
 	char *key = 0;
 	cond_bool_datum_t *booldatum;
-	uint32_t *buf, len;
+	uint32_t buf[3], len;
+	int rc;
 
 	booldatum = malloc(sizeof(cond_bool_datum_t));
 	if (!booldatum)
 		return -1;
 	memset(booldatum, 0, sizeof(cond_bool_datum_t));
 
-	buf = next_entry(fp, sizeof(uint32_t) * 3);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0)
 		goto err;
 
 	booldatum->s.value = le32_to_cpu(buf[0]);
@@ -588,13 +589,12 @@
 
 	len = le32_to_cpu(buf[2]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto err;
 	key = malloc(len + 1);
 	if (!key)
 		goto err;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto err;
 	key[len] = 0;
 	if (hashtab_insert(h, key, booldatum))
 		goto err;
@@ -703,14 +703,14 @@
 {
 	unsigned int i;
 	int rc;
-	uint32_t *buf, len;
+	uint32_t buf[1], len;
 	struct cond_insertf_data data;
 
 	*ret_list = NULL;
 
 	len = 0;
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
@@ -752,27 +752,27 @@
 
 static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 {
-	uint32_t *buf;
-	int len, i;
+	uint32_t buf[2];
+	int len, i, rc;
 	cond_expr_t *expr = NULL, *last = NULL;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto err;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
 	len = 0;
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto err;
 
 	/* expr */
 	len = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < len; i++) {
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0)
 			goto err;
 
 		expr = malloc(sizeof(cond_expr_t));
@@ -820,11 +820,11 @@
 int cond_read_list(policydb_t * p, cond_list_t ** list, void *fp)
 {
 	cond_node_t *node, *last = NULL;
-	uint32_t *buf;
-	int i, len;
+	uint32_t buf[1];
+	int i, len, rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
Index: trunk/libsepol/src/policydb.c
===================================================================
--- trunk/libsepol/src/policydb.c	(revision 2520)
+++ trunk/libsepol/src/policydb.c	(working copy)
@@ -1316,11 +1316,13 @@
 
 static int role_set_read(role_set_t * r, struct policy_file *fp)
 {
-	uint32_t *buf;
+	uint32_t buf[1];
+	int rc;
+
 	if (ebitmap_read(&r->roles, fp))
 		return -1;
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	r->flags = le32_to_cpu(buf[0]);
 
@@ -1329,15 +1331,16 @@
 
 static int type_set_read(type_set_t * t, struct policy_file *fp)
 {
-	uint32_t *buf;
+	uint32_t buf[1];
+	int rc;
 
 	if (ebitmap_read(&t->types, fp))
 		return -1;
 	if (ebitmap_read(&t->negset, fp))
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	t->flags = le32_to_cpu(buf[0]);
 
@@ -1350,16 +1353,21 @@
  */
 static int mls_read_range_helper(mls_range_t * r, struct policy_file *fp)
 {
-	uint32_t *buf;
-	int items, rc = -EINVAL;
+	uint32_t buf[2], items;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto out;
 
 	items = le32_to_cpu(buf[0]);
-	buf = next_entry(fp, sizeof(uint32_t) * items);
-	if (!buf) {
+	if (items > ARRAY_SIZE(buf)) {
+		ERR(fp->handle, "range overflow");
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = next_entry(buf, fp, sizeof(uint32_t) * items);
+	if (rc < 0) {
 		ERR(fp->handle, "truncated range");
 		goto out;
 	}
@@ -1403,14 +1411,15 @@
 static int mls_read_semantic_level_helper(mls_semantic_level_t * l,
 					  struct policy_file *fp)
 {
-	uint32_t *buf, ncat;
+	uint32_t buf[2], ncat;
 	unsigned int i;
 	mls_semantic_cat_t *cat;
+	int rc;
 
 	mls_semantic_level_init(l);
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0) {
 		ERR(fp->handle, "truncated level");
 		goto bad;
 	}
@@ -1428,8 +1437,8 @@
 		cat->next = l->cat;
 		l->cat = cat;
 
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf) {
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0) {
 			ERR(fp->handle, "error reading level categories");
 			goto bad;
 		}
@@ -1513,10 +1522,11 @@
 static int context_read_and_validate(context_struct_t * c,
 				     policydb_t * p, struct policy_file *fp)
 {
-	uint32_t *buf;
+	uint32_t buf[3];
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 3);
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0) {
 		ERR(fp->handle, "context truncated");
 		return -1;
 	}
@@ -1554,27 +1564,27 @@
 {
 	char *key = 0;
 	perm_datum_t *perdatum;
-	uint32_t *buf;
+	uint32_t buf[2];
 	size_t len;
+	int rc;
 
 	perdatum = calloc(1, sizeof(perm_datum_t));
 	if (!perdatum)
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->s.value = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (hashtab_insert(h, key, perdatum))
@@ -1591,16 +1601,17 @@
 {
 	char *key = 0;
 	common_datum_t *comdatum;
-	uint32_t *buf;
+	uint32_t buf[4];
 	size_t len, nel;
 	unsigned int i;
+	int rc;
 
 	comdatum = calloc(1, sizeof(common_datum_t));
 	if (!comdatum)
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 4);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1611,13 +1622,12 @@
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[3]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	for (i = 0; i < nel; i++) {
@@ -1641,10 +1651,10 @@
 {
 	constraint_node_t *c, *lc;
 	constraint_expr_t *e, *le;
-	uint32_t *buf;
+	uint32_t buf[3];
 	size_t nexpr;
 	unsigned int i, j;
-	int depth;
+	int rc, depth;
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
@@ -1657,8 +1667,8 @@
 		else
 			*nodep = c;
 
-		buf = next_entry(fp, (sizeof(uint32_t) * 2));
-		if (!buf)
+		rc = next_entry(buf, fp, (sizeof(uint32_t) * 2));
+		if (rc < 0)
 			return -1;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
@@ -1678,8 +1688,8 @@
 				c->expr = e;
 			}
 
-			buf = next_entry(fp, (sizeof(uint32_t) * 3));
-			if (!buf)
+			rc = next_entry(buf, fp, (sizeof(uint32_t) * 3));
+			if (rc < 0)
 				return -1;
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
@@ -1730,16 +1740,17 @@
 {
 	char *key = 0;
 	class_datum_t *cladatum;
-	uint32_t *buf;
+	uint32_t buf[6];
 	size_t len, len2, ncons, nel;
 	unsigned int i;
+	int rc;
 
 	cladatum = (class_datum_t *) calloc(1, sizeof(class_datum_t));
 	if (!cladatum)
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 6);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 6);
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1753,23 +1764,21 @@
 
 	ncons = le32_to_cpu(buf[5]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (len2) {
 		cladatum->comkey = malloc(len2 + 1);
 		if (!cladatum->comkey)
 			goto bad;
-		buf = next_entry(fp, len2);
-		if (!buf)
+		rc = next_entry(cladatum->comkey, fp, len2);
+		if (rc < 0)
 			goto bad;
-		memcpy(cladatum->comkey, buf, len2);
 		cladatum->comkey[len2] = 0;
 
 		cladatum->comdatum = hashtab_search(p->p_commons.table,
@@ -1792,8 +1801,8 @@
 	    || (p->policy_type == POLICY_BASE
 		&& p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
 		/* grab the validatetrans rules */
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
 		if (read_cons_helper(p, &cladatum->validatetrans, ncons, 1, fp))
@@ -1816,27 +1825,27 @@
 {
 	char *key = 0;
 	role_datum_t *role;
-	uint32_t *buf;
+	uint32_t buf[2];
 	size_t len;
+	int rc;
 
 	role = calloc(1, sizeof(role_datum_t));
 	if (!role)
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	role->s.value = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (ebitmap_read(&role->dominates, fp))
@@ -1877,19 +1886,20 @@
 {
 	char *key = 0;
 	type_datum_t *typdatum;
-	uint32_t *buf;
+	uint32_t buf[4];
 	size_t len;
+	int rc;
 
 	typdatum = calloc(1, sizeof(type_datum_t));
 	if (!typdatum)
 		return -1;
 
 	if (p->policy_type == POLICY_KERN) {
-		buf = next_entry(fp, sizeof(uint32_t) * 3);
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 	} else {
-		buf = next_entry(fp, sizeof(uint32_t) * 4);
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
 	}
-	if (!buf)
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
@@ -1901,13 +1911,12 @@
 			goto bad;
 	}
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (hashtab_insert(h, key, typdatum))
@@ -1923,11 +1932,12 @@
 int role_trans_read(role_trans_t ** t, struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t *buf, nel;
+	uint32_t buf[3], nel;
 	role_trans_t *tr, *ltr;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	ltr = NULL;
@@ -1941,8 +1951,8 @@
 		} else {
 			*t = tr;
 		}
-		buf = next_entry(fp, sizeof(uint32_t) * 3);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+		if (rc < 0)
 			return -1;
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
@@ -1955,11 +1965,12 @@
 int role_allow_read(role_allow_t ** r, struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t *buf, nel;
+	uint32_t buf[2], nel;
 	role_allow_t *ra, *lra;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
@@ -1973,8 +1984,8 @@
 		} else {
 			*r = ra;
 		}
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0)
 			return -1;
 		ra->role = le32_to_cpu(buf[0]);
 		ra->new_role = le32_to_cpu(buf[1]);
@@ -1989,10 +2000,12 @@
 	unsigned int i, j;
 	size_t nel, len;
 	ocontext_t *l, *c;
-	uint32_t *buf;
+	uint32_t buf[8];
+	int rc;
+
 	for (i = 0; i < info->ocon_num; i++) {
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
 			return -1;
 		nel = le32_to_cpu(buf[0]);
 		l = NULL;
@@ -2009,8 +2022,8 @@
 			l = c;
 			switch (i) {
 			case OCON_ISID:
-				buf = next_entry(fp, sizeof(uint32_t));
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
 				if (context_read_and_validate
@@ -2019,18 +2032,16 @@
 				break;
 			case OCON_FS:
 			case OCON_NETIF:
-				buf = next_entry(fp, sizeof(uint32_t));
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
 					return -1;
 				len = le32_to_cpu(buf[0]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					return -1;
 				c->u.name = malloc(len + 1);
-				if (!c->u.name) {
+				if (!c->u.name)
 					return -1;
-				}
-				memcpy(c->u.name, buf, len);
+				rc = next_entry(c->u.name, fp, len);
+				if (rc < 0)
+					return -1;
 				c->u.name[len] = 0;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
@@ -2040,8 +2051,8 @@
 					return -1;
 				break;
 			case OCON_PORT:
-				buf = next_entry(fp, sizeof(uint32_t) * 3);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+				if (rc < 0)
 					return -1;
 				c->u.port.protocol = le32_to_cpu(buf[0]);
 				c->u.port.low_port = le32_to_cpu(buf[1]);
@@ -2051,8 +2062,8 @@
 					return -1;
 				break;
 			case OCON_NODE:
-				buf = next_entry(fp, sizeof(uint32_t) * 2);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
 					return -1;
 				c->u.node.addr = le32_to_cpu(buf[0]);
 				c->u.node.mask = le32_to_cpu(buf[1]);
@@ -2061,19 +2072,17 @@
 					return -1;
 				break;
 			case OCON_FSUSE:
-				buf = next_entry(fp, sizeof(uint32_t) * 2);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
 					return -1;
 				c->v.behavior = le32_to_cpu(buf[0]);
 				len = le32_to_cpu(buf[1]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					return -1;
 				c->u.name = malloc(len + 1);
-				if (!c->u.name) {
+				if (!c->u.name)
 					return -1;
-				}
-				memcpy(c->u.name, buf, len);
+				rc = next_entry(c->u.name, fp, len);
+				if (rc < 0)
+					return -1;
 				c->u.name[len] = 0;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
@@ -2082,10 +2091,9 @@
 			case OCON_NODE6:{
 					int k;
 
-					buf =
-					    next_entry(fp,
-						       sizeof(uint32_t) * 8);
-					if (!buf)
+					rc = next_entry(buf, fp,
+							sizeof(uint32_t) * 8);
+					if (rc < 0)
 						return -1;
 					for (k = 0; k < 4; k++)
 						c->u.node6.addr[k] =
@@ -2109,36 +2117,37 @@
 
 static int genfs_read(policydb_t * p, struct policy_file *fp)
 {
-	uint32_t *buf;
+	uint32_t buf[1];
 	size_t nel, nel2, len, len2;
 	genfs_t *genfs_p, *newgenfs, *genfs;
 	unsigned int i, j;
 	ocontext_t *l, *c, *newc = NULL;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 	genfs_p = NULL;
 	for (i = 0; i < nel; i++) {
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
 			goto bad;
 		len = le32_to_cpu(buf[0]);
 		newgenfs = calloc(1, sizeof(genfs_t));
 		if (!newgenfs)
 			goto bad;
-		buf = next_entry(fp, len);
-		if (!buf) {
+		newgenfs->fstype = malloc(len + 1);
+		if (!newgenfs->fstype) {
 			free(newgenfs);
 			goto bad;
 		}
-		newgenfs->fstype = malloc(len + 1);
-		if (!newgenfs->fstype) {
+		rc = next_entry(newgenfs->fstype, fp, len);
+		if (rc < 0) {
+			free(newgenfs->fstype);
 			free(newgenfs);
 			goto bad;
 		}
-		memcpy(newgenfs->fstype, buf, len);
 		newgenfs->fstype[len] = 0;
 		for (genfs_p = NULL, genfs = p->genfs; genfs;
 		     genfs_p = genfs, genfs = genfs->next) {
@@ -2157,8 +2166,8 @@
 			genfs_p->next = newgenfs;
 		else
 			p->genfs = newgenfs;
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
 			goto bad;
 		nel2 = le32_to_cpu(buf[0]);
 		for (j = 0; j < nel2; j++) {
@@ -2166,21 +2175,20 @@
 			if (!newc) {
 				goto bad;
 			}
-			buf = next_entry(fp, sizeof(uint32_t));
-			if (!buf)
+			rc = next_entry(buf, fp, sizeof(uint32_t));
+			if (rc < 0)
 				goto bad;
 			len = le32_to_cpu(buf[0]);
-			buf = next_entry(fp, len);
-			if (!buf)
-				goto bad;
 			newc->u.name = malloc(len + 1);
 			if (!newc->u.name) {
 				goto bad;
 			}
-			memcpy(newc->u.name, buf, len);
+			rc = next_entry(newc->u.name, fp, len);
+			if (rc < 0)
+				goto bad;
 			newc->u.name[len] = 0;
-			buf = next_entry(fp, sizeof(uint32_t));
-			if (!buf)
+			rc = next_entry(buf, fp, sizeof(uint32_t));
+			if (rc < 0)
 				goto bad;
 			newc->v.sclass = le32_to_cpu(buf[0]);
 			if (context_read_and_validate(&newc->context[0], p, fp))
@@ -2226,12 +2234,13 @@
  */
 static int mls_read_level(mls_level_t * lp, struct policy_file *fp)
 {
-	uint32_t *buf;
+	uint32_t buf[1];
+	int rc;
 
 	mls_level_init(lp);
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0) {
 		ERR(fp->handle, "truncated level");
 		goto bad;
 	}
@@ -2251,27 +2260,27 @@
 {
 	char *key = 0;
 	user_datum_t *usrdatum;
-	uint32_t *buf;
+	uint32_t buf[2];
 	size_t len;
+	int rc;
 
 	usrdatum = calloc(1, sizeof(user_datum_t));
 	if (!usrdatum)
 		return -1;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	usrdatum->s.value = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (p->policy_type == POLICY_KERN) {
@@ -2332,27 +2341,27 @@
 {
 	char *key = 0;
 	level_datum_t *levdatum;
-	uint32_t *buf, len;
+	uint32_t buf[2], len;
+	int rc;
 
 	levdatum = malloc(sizeof(level_datum_t));
 	if (!levdatum)
 		return -1;
 	level_datum_init(levdatum);
 
-	buf = next_entry(fp, (sizeof(uint32_t) * 2));
-	if (!buf)
+	rc = next_entry(buf, fp, (sizeof(uint32_t) * 2));
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	levdatum->level = malloc(sizeof(mls_level_t));
@@ -2375,28 +2384,28 @@
 {
 	char *key = 0;
 	cat_datum_t *catdatum;
-	uint32_t *buf, len;
+	uint32_t buf[3], len;
+	int rc;
 
 	catdatum = malloc(sizeof(cat_datum_t));
 	if (!catdatum)
 		return -1;
 	cat_datum_init(catdatum);
 
-	buf = next_entry(fp, (sizeof(uint32_t) * 3));
-	if (!buf)
+	rc = next_entry(buf, fp, (sizeof(uint32_t) * 3));
+	if (rc < 0)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->s.value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto bad;
 	key = malloc(len + 1);
 	if (!key)
 		goto bad;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (hashtab_insert(h, key, catdatum))
@@ -2420,9 +2429,10 @@
 			     __attribute__ ((unused)), struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t *buf, len;
+	uint32_t buf[2], len;
 	class_perm_node_t *cur, *tail = NULL;
 	avrule_t *avrule;
+	int rc;
 
 	avrule = (avrule_t *) malloc(sizeof(avrule_t));
 	if (!avrule)
@@ -2430,8 +2440,8 @@
 
 	avrule_init(avrule);
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		goto bad;
 
 	(avrule)->specified = le32_to_cpu(buf[0]);
@@ -2443,8 +2453,8 @@
 	if (type_set_read(&avrule->ttypes, fp))
 		goto bad;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto bad;
 	len = le32_to_cpu(buf[0]);
 
@@ -2454,8 +2464,8 @@
 			goto bad;
 		class_perm_node_init(cur);
 
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf) {
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0) {
 			free(cur);
 			goto bad;
 		}
@@ -2482,15 +2492,16 @@
 
 static int range_read(policydb_t * p, struct policy_file *fp)
 {
-	uint32_t *buf, nel;
+	uint32_t buf[2], nel;
 	range_trans_t *rt, *lrt;
 	range_trans_rule_t *rtr, *lrtr = NULL;
 	unsigned int i;
 	int new_rangetr = (p->policy_type == POLICY_KERN &&
 			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	lrt = NULL;
@@ -2502,14 +2513,14 @@
 			lrt->next = rt;
 		else
 			p->range_tr = rt;
-		buf = next_entry(fp, (sizeof(uint32_t) * 2));
-		if (!buf)
+		rc = next_entry(buf, fp, (sizeof(uint32_t) * 2));
+		if (rc < 0)
 			return -1;
 		rt->source_type = le32_to_cpu(buf[0]);
 		rt->target_type = le32_to_cpu(buf[1]);
 		if (new_rangetr) {
-			buf = next_entry(fp, (sizeof(uint32_t)));
-			if (!buf)
+			rc = next_entry(buf, fp, (sizeof(uint32_t)));
+			if (rc < 0)
 				return -1;
 			rt->target_class = le32_to_cpu(buf[0]);
 		} else
@@ -2578,12 +2589,13 @@
 {
 	unsigned int i;
 	avrule_t *cur, *tail;
-	uint32_t *buf, len;
+	uint32_t buf[1], len;
+	int rc;
 
 	*avrules = tail = NULL;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0) {
 		return -1;
 	}
 	len = le32_to_cpu(buf[0]);
@@ -2607,12 +2619,13 @@
 
 static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
 {
-	uint32_t *buf, nel;
+	uint32_t buf[1], nel;
 	unsigned int i;
 	role_trans_rule_t *tr, *ltr;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	ltr = NULL;
@@ -2635,8 +2648,8 @@
 		if (type_set_read(&tr->types, fp))
 			return -1;
 
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
 			return -1;
 		tr->new_role = le32_to_cpu(buf[0]);
 		ltr = tr;
@@ -2648,11 +2661,12 @@
 static int role_allow_rule_read(role_allow_rule_t ** r, struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t *buf, nel;
+	uint32_t buf[1], nel;
 	role_allow_rule_t *ra, *lra;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
@@ -2683,12 +2697,13 @@
 static int range_trans_rule_read(range_trans_rule_t ** r,
 				 struct policy_file *fp)
 {
-	uint32_t *buf, nel;
+	uint32_t buf[2], nel;
 	unsigned int i;
 	range_trans_rule_t *rt, *lrt = NULL;
+	int rc;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 	for (i = 0; i < nel; i++) {
@@ -2725,15 +2740,17 @@
 			    unsigned int num_scope_syms, struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t *buf;
+	uint32_t buf[1];
+	int rc;
+
 	for (i = 0; i < num_scope_syms; i++) {
 		if (ebitmap_read(scope_index->scope + i, fp) == -1) {
 			return -1;
 		}
 	}
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
-	}
 	scope_index->class_perms_len = le32_to_cpu(buf[0]);
 	if (scope_index->class_perms_len == 0) {
 		scope_index->class_perms_map = NULL;
@@ -2755,11 +2772,13 @@
 static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 			    unsigned int num_scope_syms, struct policy_file *fp)
 {
-	uint32_t *buf, nprim, nel;
+	uint32_t buf[2], nprim, nel;
 	unsigned int i, j;
-	if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		return -1;
-	}
 	decl->decl_id = le32_to_cpu(buf[0]);
 	decl->enabled = le32_to_cpu(buf[1]);
 	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
@@ -2778,9 +2797,9 @@
 	}
 
 	for (i = 0; i < num_scope_syms; i++) {
-		if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0) 
 			return -1;
-		}
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 		for (j = 0; j < nel; j++) {
@@ -2799,11 +2818,12 @@
 			     struct policy_file *fp)
 {
 	avrule_block_t *last_block = NULL, *curblock;
-	uint32_t *buf, num_blocks, nel;
+	uint32_t buf[2], num_blocks, nel;
+	int rc;
 
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		return -1;
-	}
 	num_blocks = le32_to_cpu(buf[0]);
 	nel = num_blocks;
 	while (num_blocks > 0) {
@@ -2812,8 +2832,8 @@
 		if ((curblock = calloc(1, sizeof(*curblock))) == NULL) {
 			return -1;
 		}
-
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0) {
 			free(curblock);
 			return -1;
 		}
@@ -2869,23 +2889,23 @@
 static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 {
 	scope_datum_t *scope = NULL;
-	uint32_t *buf;
+	uint32_t buf[2];
 	char *key = NULL;
 	size_t key_len;
 	unsigned int i;
 	hashtab_t h = p->scope[symnum].table;
+	int rc;
 
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
 		goto cleanup;
-	}
 	key_len = le32_to_cpu(buf[0]);
-	if ((buf = next_entry(fp, key_len)) == NULL) {
+	key = malloc(key_len + 1);
+	if (!key)
 		goto cleanup;
-	}
-	if ((key = malloc(key_len + 1)) == NULL) {
+	rc = next_entry(key, fp, key_len);
+	if (rc < 0)
 		goto cleanup;
-	}
-	memcpy(key, buf, key_len);
 	key[key_len] = '\0';
 
 	/* ensure that there already exists a symbol with this key */
@@ -2896,9 +2916,9 @@
 	if ((scope = calloc(1, sizeof(*scope))) == NULL) {
 		goto cleanup;
 	}
-	if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		goto cleanup;
-	}
 	scope->scope = le32_to_cpu(buf[0]);
 	scope->decl_ids_len = le32_to_cpu(buf[1]);
 	assert(scope->decl_ids_len > 0);
@@ -2906,12 +2926,11 @@
 	     malloc(scope->decl_ids_len * sizeof(uint32_t))) == NULL) {
 		goto cleanup;
 	}
-	if ((buf =
-	     next_entry(fp, sizeof(uint32_t) * scope->decl_ids_len)) == NULL) {
+	rc = next_entry(scope->decl_ids, fp, sizeof(uint32_t) * scope->decl_ids_len);
+	if (rc < 0)
 		goto cleanup;
-	}
 	for (i = 0; i < scope->decl_ids_len; i++) {
-		scope->decl_ids[i] = le32_to_cpu(buf[i]);
+		scope->decl_ids[i] = le32_to_cpu(scope->decl_ids[i]);
 	}
 
 	if (strcmp(key, "object_r") == 0 && h == p->p_roles_scope.table) {
@@ -2938,18 +2957,19 @@
 {
 
 	unsigned int i, j, r_policyvers;
-	uint32_t *buf, config;
+	uint32_t buf[5], config;
 	size_t len, nprim, nel;
 	char *policydb_str, *target_str = NULL;
 	struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
+	int rc;
 
 	config = 0;
 
 	/* Read the magic number and string length. */
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		return POLICYDB_ERROR;
 	for (i = 0; i < 2; i++)
 		buf[i] = le32_to_cpu(buf[i]);
@@ -2974,18 +2994,18 @@
 		return POLICYDB_ERROR;
 	}
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		ERR(fp->handle, "truncated policydb string identifier");
-		return POLICYDB_ERROR;
-	}
 	policydb_str = malloc(len + 1);
 	if (!policydb_str) {
 		ERR(fp->handle, "unable to allocate memory for policydb "
 		    "string of length %zu", len);
 		return POLICYDB_ERROR;
 	}
-	memcpy(policydb_str, buf, len);
+	rc = next_entry(policydb_str, fp, len);
+	if (rc < 0) {
+		ERR(fp->handle, "truncated policydb string identifier");
+		free(policydb_str);
+		return POLICYDB_ERROR;
+	}
 	policydb_str[len] = 0;
 	if (strcmp(policydb_str, target_str)) {
 		ERR(fp->handle, "policydb string %s does not match "
@@ -3003,8 +3023,8 @@
 	else
 		nel = 5;
 
-	buf = next_entry(fp, sizeof(uint32_t) * nel);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(uint32_t) * nel);
+	if (rc < 0)
 		return POLICYDB_ERROR;
 	for (i = 0; i < nel; i++)
 		buf[i] = le32_to_cpu(buf[i]);
@@ -3077,35 +3097,33 @@
 
 	if (p->policy_type == POLICY_MOD) {
 		/* Get the module name and version */
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+		if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
 			goto bad;
 		}
 		len = le32_to_cpu(buf[0]);
-		if ((buf = next_entry(fp, len)) == NULL) {
+		if ((p->name = malloc(len + 1)) == NULL) {
 			goto bad;
 		}
-		if ((p->name = malloc(len + 1)) == NULL) {
+		if ((rc = next_entry(p->name, fp, len)) < 0) {
 			goto bad;
 		}
-		memcpy(p->name, buf, len);
 		p->name[len] = '\0';
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+		if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
 			goto bad;
 		}
 		len = le32_to_cpu(buf[0]);
-		if ((buf = next_entry(fp, len)) == NULL) {
+		if ((p->version = malloc(len + 1)) == NULL) {
 			goto bad;
 		}
-		if ((p->version = malloc(len + 1)) == NULL) {
+		if ((rc = next_entry(p->version, fp, len)) < 0) {
 			goto bad;
 		}
-		memcpy(p->version, buf, len);
 		p->version[len] = '\0';
 	}
 
 	for (i = 0; i < info->sym_num; i++) {
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
@@ -3135,7 +3153,7 @@
 			goto bad;
 		}
 		for (i = 0; i < info->sym_num; i++) {
-			if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+			if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
 				goto bad;
 			}
 			nel = le32_to_cpu(buf[0]);
Index: trunk/libsepol/src/private.h
===================================================================
--- trunk/libsepol/src/private.h	(revision 2520)
+++ trunk/libsepol/src/private.h	(working copy)
@@ -27,6 +27,8 @@
 #undef min
 #define min(a,b) (((a) < (b)) ? (a) : (b))
 
+#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
+
 /* Policy compatibility information. */
 struct policydb_compat_info {
 	unsigned int type;
@@ -39,31 +41,27 @@
 							   unsigned int type);
 
 /* Reading from a policy "file". */
-static inline void *next_entry(struct policy_file *fp, size_t bytes)
+static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 {
-	static unsigned char buffer[BUFSIZ];
 	size_t nread;
 
-	if (bytes > sizeof buffer)
-		return NULL;
-
 	switch (fp->type) {
 	case PF_USE_STDIO:
-		nread = fread(buffer, bytes, 1, fp->fp);
+		nread = fread(buf, bytes, 1, fp->fp);
 		if (nread != 1)
-			return NULL;
+			return -1;
 		break;
 	case PF_USE_MEMORY:
 		if (bytes > fp->len)
-			return NULL;
-		memcpy(buffer, fp->data, bytes);
+			return -1;
+		memcpy(buf, fp->data, bytes);
 		fp->data += bytes;
 		fp->len -= bytes;
 		break;
 	default:
-		return NULL;
+		return -1;
 	}
-	return buffer;
+	return 0;
 }
 
 static inline size_t put_entry(const void *ptr, size_t size, size_t n,
Index: trunk/libsepol/src/ebitmap.c
===================================================================
--- trunk/libsepol/src/ebitmap.c	(revision 2520)
+++ trunk/libsepol/src/ebitmap.c	(working copy)
@@ -265,16 +265,16 @@
 
 int ebitmap_read(ebitmap_t * e, void *fp)
 {
-	int rc = -EINVAL;
+	int rc;
 	ebitmap_node_t *n, *l;
-	uint32_t *buf, mapsize, count, i;
+	uint32_t buf[3], mapsize, count, i;
 	uint64_t map;
 
 	ebitmap_init(e);
 
-	buf = next_entry(fp, sizeof(uint32_t) * 3);
-	if (!buf)
-		goto out;
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0)
+		goto bad;
 
 	mapsize = le32_to_cpu(buf[0]);
 	e->highbit = le32_to_cpu(buf[1]);
@@ -284,7 +284,7 @@
 		printf
 		    ("security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n",
 		     mapsize, MAPSIZE, e->highbit);
-		goto out;
+		goto bad;
 	}
 	if (!e->highbit) {
 		e->node = NULL;
@@ -298,8 +298,8 @@
 	}
 	l = NULL;
 	for (i = 0; i < count; i++) {
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0) {
 			printf("security: ebitmap: truncated map\n");
 			goto bad;
 		}
@@ -325,12 +325,11 @@
 			     n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
-		buf = next_entry(fp, sizeof(uint64_t));
-		if (!buf) {
+		rc = next_entry(&map, fp, sizeof(uint64_t));
+		if (rc < 0) {
 			printf("security: ebitmap: truncated map\n");
 			goto bad_free;
 		}
-		memcpy(&map, buf, sizeof(uint64_t));
 		n->map = le64_to_cpu(map);
 
 		if (!n->map) {
@@ -360,6 +359,8 @@
       bad_free:
 	free(n);
       bad:
+	if (!rc)
+		rc = -EINVAL;
 	ebitmap_destroy(e);
 	goto out;
 }
Index: trunk/libsepol/src/module.c
===================================================================
--- trunk/libsepol/src/module.c	(revision 2520)
+++ trunk/libsepol/src/module.c	(working copy)
@@ -326,7 +326,7 @@
 static int read_helper(char *buf, struct policy_file *file, uint32_t bytes)
 {
 	uint32_t offset, nel, read_len;
-	void *tmp;
+	int rc;
 
 	offset = 0;
 	nel = bytes;
@@ -336,10 +336,9 @@
 			read_len = nel;
 		else
 			read_len = _read_helper_bufsize;
-		tmp = next_entry(file, read_len);
-		if (!tmp)
+		rc = next_entry(&buf[offset], file, read_len);
+		if (rc < 0)
 			return -1;
-		memcpy(&buf[offset], tmp, read_len);
 		offset += read_len;
 		nel -= read_len;
 	}
@@ -354,11 +353,13 @@
 				       struct policy_file *file,
 				       size_t ** offsets, uint32_t * sections)
 {
-	uint32_t *buf, nsec;
+	uint32_t buf[3], nsec;
 	unsigned i;
+	size_t *off;
+	int rc;
 
-	buf = next_entry(file, sizeof(uint32_t) * 3);
-	if (!buf) {
+	rc = next_entry(buf, file, sizeof(uint32_t) * 3);
+	if (rc < 0) {
 		ERR(file->handle, "module package header truncated");
 		return -1;
 	}
@@ -378,29 +379,31 @@
 		return -1;
 	}
 
-	*offsets = (size_t *) malloc((nsec + 1) * sizeof(size_t));
-	if (!*offsets) {
+	off = (size_t *) malloc((nsec + 1) * sizeof(size_t));
+	if (!off) {
 		ERR(file->handle, "out of memory");
 		return -1;
 	}
 
-	buf = next_entry(file, sizeof(uint32_t) * nsec);
-	if (!buf) {
+	rc = next_entry(off, file, sizeof(uint32_t) * nsec);
+	if (rc < 0) {
 		ERR(file->handle, "module package offset array truncated");
 		return -1;
 	}
 
 	for (i = 0; i < nsec; i++) {
-		(*offsets)[i] = le32_to_cpu(buf[i]);
-		if (i && (*offsets)[i] < (*offsets)[i - 1]) {
+		off[i] = le32_to_cpu(off[i]);
+		if (i && off[i] < off[i - 1]) {
 			ERR(file->handle, "offsets are not increasing (at %u, "
-			    "offset %zu -> %zu", i, (*offsets)[i - 1],
-			    (*offsets)[i]);
+			    "offset %zu -> %zu", i, off[i - 1],
+			    off[i]);
 			return -1;
 		}
 	}
 
-	(*offsets)[nsec] = policy_file_length(file);
+	
+	off[nsec] = policy_file_length(file);
+	*offsets = off;
 	return 0;
 }
 
@@ -415,9 +418,9 @@
 			      struct sepol_policy_file *spf, int verbose)
 {
 	struct policy_file *file = &spf->pf;
-	uint32_t *buf, nsec;
+	uint32_t buf[5], nsec;
 	size_t *offsets, len;
-	int retval = -1;
+	int rc;
 	unsigned i, seen = 0;
 
 	if (module_package_read_offsets(mod, file, &offsets, &nsec))
@@ -442,8 +445,8 @@
 		}
 
 		/* read the magic number, so that we know which function to call */
-		buf = next_entry(file, sizeof(uint32_t));
-		if (!buf) {
+		rc = next_entry(buf, file, sizeof(uint32_t));
+		if (rc < 0) {
 			ERR(file->handle,
 			    "module package section %u truncated, lacks magic number",
 			    i);
@@ -565,8 +568,8 @@
 			if (policy_file_seek(file, offsets[i]))
 				goto cleanup;
 
-			retval = policydb_read(&mod->policy->p, file, verbose);
-			if (retval < 0) {
+			rc = policydb_read(&mod->policy->p, file, verbose);
+			if (rc < 0) {
 				ERR(file->handle,
 				    "invalid module in module package (at section %u)",
 				    i);
@@ -593,7 +596,7 @@
 
       cleanup:
 	free(offsets);
-	return retval;
+	return -1;
 }
 
 int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
@@ -601,9 +604,11 @@
 {
 	struct policy_file *file = &spf->pf;
 	sepol_module_package_t *mod = NULL;
-	uint32_t *buf, len, nsec;
+	uint32_t buf[5], len, nsec;
 	size_t *offsets = NULL;
 	unsigned i, seen = 0;
+	char *id;
+	int rc;
 
 	if (sepol_module_package_create(&mod))
 		return -1;
@@ -630,8 +635,8 @@
 		}
 
 		/* read the magic number, so that we know which function to call */
-		buf = next_entry(file, sizeof(uint32_t) * 2);
-		if (!buf) {
+		rc = next_entry(buf, file, sizeof(uint32_t) * 2);
+		if (rc < 0) {
 			ERR(file->handle,
 			    "module package section %u truncated, lacks magic number",
 			    i);
@@ -695,16 +700,24 @@
 			}
 
 			/* skip id */
-			buf = next_entry(file, len);
-			if (!buf) {
+			id = malloc(len + 1);
+			if (!id) {
 				ERR(file->handle,
+				    "out of memory (at section %u)",
+				    i);
+				goto cleanup;				
+			}
+			rc = next_entry(id, file, len);
+			free(id);
+			if (rc < 0) {
+				ERR(file->handle,
 				    "cannot get module string (at section %u)",
 				    i);
 				goto cleanup;
 			}
-
-			buf = next_entry(file, sizeof(uint32_t) * 5);
-			if (!buf) {
+			
+			rc = next_entry(buf, file, sizeof(uint32_t) * 5);
+			if (rc < 0) {
 				ERR(file->handle,
 				    "cannot get module header (at section %u)",
 				    i);
@@ -726,49 +739,47 @@
 			}
 
 			/* read the name and version */
-			buf = next_entry(file, sizeof(uint32_t));
-			if (!buf) {
+			rc = next_entry(buf, file, sizeof(uint32_t));
+			if (rc < 0) {
 				ERR(file->handle,
 				    "cannot get module name len (at section %u)",
 				    i);
 				goto cleanup;
 			}
 			len = le32_to_cpu(buf[0]);
-			buf = next_entry(file, len);
-			if (!buf) {
-				ERR(file->handle,
-				    "cannot get module name string (at section %u)",
-				    i);
-				goto cleanup;
-			}
 			*name = malloc(len + 1);
 			if (!*name) {
 				ERR(file->handle, "out of memory");
 				goto cleanup;
 			}
-			memcpy(*name, buf, len);
-			(*name)[len] = '\0';
-			buf = next_entry(file, sizeof(uint32_t));
-			if (!buf) {
+			rc = next_entry(*name, file, len);
+			if (rc < 0) {
 				ERR(file->handle,
-				    "cannot get module version len (at section %u)",
+				    "cannot get module name string (at section %u)",
 				    i);
 				goto cleanup;
 			}
-			len = le32_to_cpu(buf[0]);
-			buf = next_entry(file, len);
-			if (!buf) {
+			(*name)[len] = '\0';
+			rc = next_entry(buf, file, sizeof(uint32_t));
+			if (rc < 0) {
 				ERR(file->handle,
-				    "cannot get module version string (at section %u)",
+				    "cannot get module version len (at section %u)",
 				    i);
 				goto cleanup;
 			}
+			len = le32_to_cpu(buf[0]);
 			*version = malloc(len + 1);
 			if (!*version) {
 				ERR(file->handle, "out of memory");
 				goto cleanup;
 			}
-			memcpy(*version, buf, len);
+			rc = next_entry(*version, file, len);
+			if (rc < 0) {
+				ERR(file->handle,
+				    "cannot get module version string (at section %u)",
+				    i);
+				goto cleanup;
+			}
 			(*version)[len] = '\0';
 			seen |= SEEN_MOD;
 			break;
Index: trunk/libsepol/src/avtab.c
===================================================================
--- trunk/libsepol/src/avtab.c	(revision 2520)
+++ trunk/libsepol/src/avtab.c	(working copy)
@@ -337,8 +337,8 @@
 		    int (*insertf) (avtab_t * a, avtab_key_t * k,
 				    avtab_datum_t * d, void *p), void *p)
 {
-	uint16_t *buf16, enabled;
-	uint32_t *buf32, items, items2, val;
+	uint16_t buf16[4], enabled;
+	uint32_t buf32[7], items, items2, val;
 	avtab_key_t key;
 	avtab_datum_t datum;
 	unsigned set;
@@ -349,20 +349,20 @@
 	memset(&datum, 0, sizeof(avtab_datum_t));
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
-		buf32 = next_entry(fp, sizeof(uint32_t));
-		if (!buf32) {
+		rc = next_entry(buf32, fp, sizeof(uint32_t));
+		if (rc < 0) {
 			ERR(fp->handle, "truncated entry");
 			return -1;
 		}
 		items2 = le32_to_cpu(buf32[0]);
 
-		if (items2 < 5 || items2 > 8) {
+		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
 			ERR(fp->handle, "invalid item count");
 			return -1;
 		}
 
-		buf32 = next_entry(fp, sizeof(uint32_t) * items2);
-		if (!buf32) {
+		rc = next_entry(buf32, fp, sizeof(uint32_t) * items2);
+		if (rc < 0) {
 			ERR(fp->handle, "truncated entry");
 			return -1;
 		}
@@ -400,7 +400,7 @@
 			return -1;
 		}
 
-		for (i = 0; i < sizeof(spec_order) / sizeof(uint16_t); i++) {
+		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
 				key.specified = spec_order[i] | enabled;
 				datum.data = le32_to_cpu(buf32[items++]);
@@ -418,8 +418,8 @@
 		return 0;
 	}
 
-	buf16 = next_entry(fp, sizeof(uint16_t) * 4);
-	if (!buf16) {
+	rc = next_entry(buf16, fp, sizeof(uint16_t) * 4);
+	if (rc < 0) {
 		ERR(fp->handle, "truncated entry");
 		return -1;
 	}
@@ -430,7 +430,7 @@
 	key.specified = le16_to_cpu(buf16[items++]);
 
 	set = 0;
-	for (i = 0; i < sizeof(spec_order) / sizeof(uint16_t); i++) {
+	for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 		if (key.specified & spec_order[i])
 			set++;
 	}
@@ -439,8 +439,8 @@
 		return -1;
 	}
 
-	buf32 = next_entry(fp, sizeof(uint32_t));
-	if (!buf32) {
+	rc = next_entry(buf32, fp, sizeof(uint32_t));
+	if (rc < 0) {
 		ERR(fp->handle, "truncated entry");
 		return -1;
 	}
@@ -458,11 +458,11 @@
 {
 	unsigned int i;
 	int rc;
-	uint32_t *buf;
+	uint32_t buf[1];
 	uint32_t nel;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0) {
 		ERR(fp->handle, "truncated table");
 		goto bad;
 	}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
