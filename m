Subject: [PATCH 2/4 -v2] Namespacing of security/selinux
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Content-Type: text/plain
Date: Mon, 06 Jul 2009 14:58:40 -0400
Message-Id: <1246906720.2460.13.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Namespacing of most files in security/selinux/ss, not including
most of the functions in policydb.h nor things with the mls_
prefix.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
 security/selinux/ss/avtab.c       |   92 ++++++++++----------
 security/selinux/ss/avtab.h       |   50 +++++-----
 security/selinux/ss/conditional.c |  110 ++++++++++++------------
 security/selinux/ss/conditional.h |   40 ++++----
 security/selinux/ss/constraint.h  |   12 ++--
 security/selinux/ss/context.h     |   20 ++--
 security/selinux/ss/ebitmap.c     |   58 ++++++------
 security/selinux/ss/ebitmap.h     |   46 +++++-----
 security/selinux/ss/hashtab.c     |   26 +++---
 security/selinux/ss/hashtab.h     |   28 +++---
 security/selinux/ss/mls.c         |   50 +++++-----
 security/selinux/ss/mls_types.h   |    6 +-
 security/selinux/ss/policydb.c    |  174 ++++++++++++++++++------------------
 security/selinux/ss/policydb.h    |   28 +++---
 security/selinux/ss/services.c    |  122 +++++++++++++-------------
 security/selinux/ss/symtab.c      |    6 +-
 security/selinux/ss/symtab.h      |    2 +-
 17 files changed, 435 insertions(+), 435 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 1215b8e..eb9c7c0 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -14,7 +14,7 @@
  *	the Free Software Foundation, version 2.
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
- *	Tuned number of hash slots for avtab to reduce memory usage
+ *	Tuned number of hash slots for selinux_avtab to reduce memory usage
  */
 
 #include <linux/kernel.h>
@@ -25,18 +25,18 @@
 
 static struct kmem_cache *avtab_node_cachep;
 
-static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
+static inline int avtab_hash(struct selinux_avtab_key *keyp, u16 mask)
 {
 	return ((keyp->target_class + (keyp->target_type << 2) +
 		 (keyp->source_type << 9)) & mask);
 }
 
-static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue,
-		  struct avtab_node *prev, struct avtab_node *cur,
-		  struct avtab_key *key, struct avtab_datum *datum)
+static struct selinux_avtab_node*
+selinux_avtab_insert_node(struct selinux_avtab *h, int hvalue,
+		  struct selinux_avtab_node *prev, struct selinux_avtab_node *cur,
+		  struct selinux_avtab_key *key, struct selinux_avtab_datum *datum)
 {
-	struct avtab_node *newnode;
+	struct selinux_avtab_node *newnode;
 	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
 	if (newnode == NULL)
 		return NULL;
@@ -54,10 +54,10 @@ avtab_insert_node(struct avtab *h, int hvalue,
 	return newnode;
 }
 
-static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+static int avtab_insert(struct selinux_avtab *h, struct selinux_avtab_key *key, struct selinux_avtab_datum *datum)
 {
 	int hvalue;
-	struct avtab_node *prev, *cur, *newnode;
+	struct selinux_avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->htable)
@@ -83,7 +83,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
 			break;
 	}
 
-	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	newnode = selinux_avtab_insert_node(h, hvalue, prev, cur, key, datum);
 	if (!newnode)
 		return -ENOMEM;
 
@@ -94,11 +94,11 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
  * key/specified mask into the table, as needed by the conditional avtab.
  * It also returns a pointer to the node inserted.
  */
-struct avtab_node *
-avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+struct selinux_avtab_node *
+selinux_avtab_insert_nonunique(struct selinux_avtab *h, struct selinux_avtab_key *key, struct selinux_avtab_datum *datum)
 {
 	int hvalue;
-	struct avtab_node *prev, *cur;
+	struct selinux_avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->htable)
@@ -122,13 +122,13 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
 		    key->target_class < cur->key.target_class)
 			break;
 	}
-	return avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	return selinux_avtab_insert_node(h, hvalue, prev, cur, key, datum);
 }
 
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
+struct selinux_avtab_datum *avtab_search(struct selinux_avtab *h, struct selinux_avtab_key *key)
 {
 	int hvalue;
-	struct avtab_node *cur;
+	struct selinux_avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->htable)
@@ -157,13 +157,13 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 }
 
 /* This search function returns a node pointer, and can be used in
- * conjunction with avtab_search_next_node()
+ * conjunction with selinux_avtab_search_next_node()
  */
-struct avtab_node*
-avtab_search_node(struct avtab *h, struct avtab_key *key)
+struct selinux_avtab_node*
+selinux_avtab_search_node(struct selinux_avtab *h, struct selinux_avtab_key *key)
 {
 	int hvalue;
-	struct avtab_node *cur;
+	struct selinux_avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->htable)
@@ -190,10 +190,10 @@ avtab_search_node(struct avtab *h, struct avtab_key *key)
 	return NULL;
 }
 
-struct avtab_node*
-avtab_search_node_next(struct avtab_node *node, int specified)
+struct selinux_avtab_node*
+selinux_avtab_search_node_next(struct selinux_avtab_node *node, int specified)
 {
-	struct avtab_node *cur;
+	struct selinux_avtab_node *cur;
 
 	if (!node)
 		return NULL;
@@ -219,10 +219,10 @@ avtab_search_node_next(struct avtab_node *node, int specified)
 	return NULL;
 }
 
-void avtab_destroy(struct avtab *h)
+void selinux_avtab_destroy(struct selinux_avtab *h)
 {
 	int i;
-	struct avtab_node *cur, *temp;
+	struct selinux_avtab_node *cur, *temp;
 
 	if (!h || !h->htable)
 		return;
@@ -242,14 +242,14 @@ void avtab_destroy(struct avtab *h)
 	h->mask = 0;
 }
 
-int avtab_init(struct avtab *h)
+int selinux_avtab_init(struct selinux_avtab *h)
 {
 	h->htable = NULL;
 	h->nel = 0;
 	return 0;
 }
 
-int avtab_alloc(struct avtab *h, u32 nrules)
+int selinux_avtab_alloc(struct selinux_avtab *h, u32 nrules)
 {
 	u16 mask = 0;
 	u32 shift = 0;
@@ -278,16 +278,16 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	h->nel = 0;
 	h->nslot = nslot;
 	h->mask = mask;
-	printk(KERN_DEBUG "SELinux: %d avtab hash slots, %d rules.\n",
+	printk(KERN_DEBUG "SELinux: %d selinux_avtab hash slots, %d rules.\n",
 	       h->nslot, nrules);
 	return 0;
 }
 
-void avtab_hash_eval(struct avtab *h, char *tag)
+void selinux_avtab_hash_eval(struct selinux_avtab *h, char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
-	struct avtab_node *cur;
+	struct selinux_avtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
@@ -323,22 +323,22 @@ static uint16_t spec_order[] = {
 	AVTAB_MEMBER
 };
 
-int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-		    int (*insertf)(struct avtab *a, struct avtab_key *k,
-				   struct avtab_datum *d, void *p),
+int selinux_avtab_read_item(struct selinux_avtab *a, void *fp, struct policydb *pol,
+		    int (*insertf)(struct selinux_avtab *a, struct selinux_avtab_key *k,
+				   struct selinux_avtab_datum *d, void *p),
 		    void *p)
 {
 	__le16 buf16[4];
 	u16 enabled;
 	__le32 buf32[7];
 	u32 items, items2, val, vers = pol->policyvers;
-	struct avtab_key key;
-	struct avtab_datum datum;
+	struct selinux_avtab_key key;
+	struct selinux_avtab_datum datum;
 	int i, rc;
 	unsigned set;
 
-	memset(&key, 0, sizeof(struct avtab_key));
-	memset(&datum, 0, sizeof(struct avtab_datum));
+	memset(&key, 0, sizeof(struct selinux_avtab_key));
+	memset(&datum, 0, sizeof(struct selinux_avtab_datum));
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(u32));
@@ -451,13 +451,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	return insertf(a, &key, &datum, p);
 }
 
-static int avtab_insertf(struct avtab *a, struct avtab_key *k,
-			 struct avtab_datum *d, void *p)
+static int avtab_insertf(struct selinux_avtab *a, struct selinux_avtab_key *k,
+			 struct selinux_avtab_datum *d, void *p)
 {
 	return avtab_insert(a, k, d);
 }
 
-int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
+int selinux_avtab_read(struct selinux_avtab *a, void *fp, struct policydb *pol)
 {
 	int rc;
 	__le32 buf[1];
@@ -476,12 +476,12 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		goto bad;
 	}
 
-	rc = avtab_alloc(a, nel);
+	rc = selinux_avtab_alloc(a, nel);
 	if (rc)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = selinux_avtab_read_item(a, fp, pol, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				printk(KERN_ERR "SELinux: avtab: out of memory\n");
@@ -498,18 +498,18 @@ out:
 	return rc;
 
 bad:
-	avtab_destroy(a);
+	selinux_avtab_destroy(a);
 	goto out;
 }
 
-void avtab_cache_init(void)
+void selinux_avtab_cache_init(void)
 {
 	avtab_node_cachep = kmem_cache_create("avtab_node",
-					      sizeof(struct avtab_node),
+					      sizeof(struct selinux_avtab_node),
 					      0, SLAB_PANIC, NULL);
 }
 
-void avtab_cache_destroy(void)
+void selinux_avtab_cache_destroy(void)
 {
 	kmem_cache_destroy(avtab_node_cachep);
 }
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 8da6a84..ef9fe89 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -18,12 +18,12 @@
  *	the Free Software Foundation, version 2.
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
- * 	Tuned number of hash slots for avtab to reduce memory usage
+ * 	Tuned number of hash slots for selinux_avtab to reduce memory usage
  */
 #ifndef _SS_AVTAB_H_
 #define _SS_AVTAB_H_
 
-struct avtab_key {
+struct selinux_avtab_key {
 	u16 source_type;	/* source type */
 	u16 target_type;	/* target type */
 	u16 target_class;	/* target object class */
@@ -40,47 +40,47 @@ struct avtab_key {
 	u16 specified;	/* what field is specified */
 };
 
-struct avtab_datum {
+struct selinux_avtab_datum {
 	u32 data; /* access vector or type value */
 };
 
-struct avtab_node {
-	struct avtab_key key;
-	struct avtab_datum datum;
-	struct avtab_node *next;
+struct selinux_avtab_node {
+	struct selinux_avtab_key key;
+	struct selinux_avtab_datum datum;
+	struct selinux_avtab_node *next;
 };
 
-struct avtab {
-	struct avtab_node **htable;
+struct selinux_avtab {
+	struct selinux_avtab_node **htable;
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u16 mask;       /* mask to compute hash func */
 
 };
 
-int avtab_init(struct avtab *);
-int avtab_alloc(struct avtab *, u32);
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
-void avtab_destroy(struct avtab *h);
-void avtab_hash_eval(struct avtab *h, char *tag);
+int selinux_avtab_init(struct selinux_avtab *);
+int selinux_avtab_alloc(struct selinux_avtab *, u32);
+struct selinux_avtab_datum *selinux_avtab_search(struct selinux_avtab *h, struct selinux_avtab_key *k);
+void selinux_avtab_destroy(struct selinux_avtab *h);
+void selinux_avtab_hash_eval(struct selinux_avtab *h, char *tag);
 
 struct policydb;
-int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-		    int (*insert)(struct avtab *a, struct avtab_key *k,
-				  struct avtab_datum *d, void *p),
-		    void *p);
+int selinux_avtab_read_item(struct selinux_avtab *a, void *fp, struct policydb *pol,
+			       int (*insert)(struct selinux_avtab *a, struct selinux_avtab_key *k,
+			       struct selinux_avtab_datum *d, void *p),
+			       void *p);
 
-int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
+int selinux_avtab_read(struct selinux_avtab *a, void *fp, struct policydb *pol);
 
-struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
-					  struct avtab_datum *datum);
+struct selinux_avtab_node *selinux_avtab_insert_nonunique(struct selinux_avtab *h, struct selinux_avtab_key *key,
+								struct selinux_avtab_datum *datum);
 
-struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key);
+struct selinux_avtab_node *selinux_avtab_search_node(struct selinux_avtab *h, struct selinux_avtab_key *key);
 
-struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
+struct selinux_avtab_node *selinux_avtab_search_node_next(struct selinux_avtab_node *node, int specified);
 
-void avtab_cache_init(void);
-void avtab_cache_destroy(void);
+void selinux_avtab_cache_init(void);
+void selinux_avtab_cache_destroy(void);
 
 #define MAX_AVTAB_HASH_BITS 13
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 4a4e35c..ccb6c2d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -22,10 +22,10 @@
  * or undefined (-1). Undefined occurs when the expression
  * exceeds the stack depth of COND_EXPR_MAXDEPTH.
  */
-static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
+static int cond_evaluate_expr(struct policydb *p, struct selinux_cond_expr *expr)
 {
 
-	struct cond_expr *cur;
+	struct selinux_cond_expr *cur;
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
@@ -81,15 +81,15 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 
 /*
  * evaluate_cond_node evaluates the conditional stored in
- * a struct cond_node and if the result is different than the
+ * a struct selinux_cond_node and if the result is different than the
  * current state of the node it sets the rules in the true/false
  * list appropriately. If the result of the expression is undefined
  * all of the rules are disabled for safety.
  */
-int evaluate_cond_node(struct policydb *p, struct cond_node *node)
+int selinux_evaluate_cond_node(struct policydb *p, struct selinux_cond_node *node)
 {
 	int new_state;
-	struct cond_av_list *cur;
+	struct selinux_cond_av_list *cur;
 
 	new_state = cond_evaluate_expr(p, node->expr);
 	if (new_state != node->cur_state) {
@@ -115,29 +115,29 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	return 0;
 }
 
-int cond_policydb_init(struct policydb *p)
+int selinux_cond_policydb_init(struct policydb *p)
 {
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
-	if (avtab_init(&p->te_cond_avtab))
+	if (selinux_avtab_init(&p->te_cond_avtab))
 		return -1;
 
 	return 0;
 }
 
-static void cond_av_list_destroy(struct cond_av_list *list)
+static void cond_av_list_destroy(struct selinux_cond_av_list *list)
 {
-	struct cond_av_list *cur, *next;
+	struct selinux_cond_av_list *cur, *next;
 	for (cur = list; cur; cur = next) {
 		next = cur->next;
-		/* the avtab_ptr_t node is destroy by the avtab */
+		/* the avtab_ptr_t node is destroy by the selinux_avtab */
 		kfree(cur);
 	}
 }
 
-static void cond_node_destroy(struct cond_node *node)
+static void cond_node_destroy(struct selinux_cond_node *node)
 {
-	struct cond_expr *cur_expr, *next_expr;
+	struct selinux_cond_expr *cur_expr, *next_expr;
 
 	for (cur_expr = node->expr; cur_expr; cur_expr = next_expr) {
 		next_expr = cur_expr->next;
@@ -148,9 +148,9 @@ static void cond_node_destroy(struct cond_node *node)
 	kfree(node);
 }
 
-static void cond_list_destroy(struct cond_node *list)
+static void cond_list_destroy(struct selinux_cond_node *list)
 {
-	struct cond_node *next, *cur;
+	struct selinux_cond_node *next, *cur;
 
 	if (list == NULL)
 		return;
@@ -161,34 +161,34 @@ static void cond_list_destroy(struct cond_node *list)
 	}
 }
 
-void cond_policydb_destroy(struct policydb *p)
+void selinux_cond_policydb_destroy(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	avtab_destroy(&p->te_cond_avtab);
+	selinux_avtab_destroy(&p->te_cond_avtab);
 	cond_list_destroy(p->cond_list);
 }
 
-int cond_init_bool_indexes(struct policydb *p)
+int selinux_cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = (struct cond_bool_datum **)
-		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum *), GFP_KERNEL);
+	p->bool_val_to_struct = (struct selinux_cond_bool_datum **)
+		kmalloc(p->p_bools.nprim * sizeof(struct selinux_cond_bool_datum *), GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -1;
 	return 0;
 }
 
-int cond_destroy_bool(void *key, void *datum, void *p)
+int selinux_cond_destroy_bool(void *key, void *datum, void *p)
 {
 	kfree(key);
 	kfree(datum);
 	return 0;
 }
 
-int cond_index_bool(void *key, void *datum, void *datap)
+int selinux_cond_index_bool(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
-	struct cond_bool_datum *booldatum;
+	struct selinux_cond_bool_datum *booldatum;
 
 	booldatum = datum;
 	p = datap;
@@ -202,22 +202,22 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int bool_isvalid(struct cond_bool_datum *b)
+static int bool_isvalid(struct selinux_cond_bool_datum *b)
 {
 	if (!(b->state == 0 || b->state == 1))
 		return 0;
 	return 1;
 }
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
+int selinux_cond_read_bool(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct cond_bool_datum *booldatum;
+	struct selinux_cond_bool_datum *booldatum;
 	__le32 buf[3];
 	u32 len;
 	int rc;
 
-	booldatum = kzalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	booldatum = kzalloc(sizeof(struct selinux_cond_bool_datum), GFP_KERNEL);
 	if (!booldatum)
 		return -1;
 
@@ -240,38 +240,38 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc < 0)
 		goto err;
 	key[len] = '\0';
-	if (hashtab_insert(h, key, booldatum))
+	if (selinux_hashtab_insert(h, key, booldatum))
 		goto err;
 
 	return 0;
 err:
-	cond_destroy_bool(key, booldatum, NULL);
+	selinux_cond_destroy_bool(key, booldatum, NULL);
 	return -1;
 }
 
 struct cond_insertf_data {
 	struct policydb *p;
-	struct cond_av_list *other;
-	struct cond_av_list *head;
-	struct cond_av_list *tail;
+	struct selinux_cond_av_list *other;
+	struct selinux_cond_av_list *head;
+	struct selinux_cond_av_list *tail;
 };
 
-static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
+static int cond_insertf(struct selinux_avtab *a, struct selinux_avtab_key *k, struct selinux_avtab_datum *d, void *ptr)
 {
 	struct cond_insertf_data *data = ptr;
 	struct policydb *p = data->p;
-	struct cond_av_list *other = data->other, *list, *cur;
-	struct avtab_node *node_ptr;
+	struct selinux_cond_av_list *other = data->other, *list, *cur;
+	struct selinux_avtab_node *node_ptr;
 	u8 found;
 
 
 	/*
 	 * For type rules we have to make certain there aren't any
 	 * conflicting rules by searching the te_avtab and the
-	 * cond_te_avtab.
+	 * selinux_cond_te_avtab.
 	 */
 	if (k->specified & AVTAB_TYPE) {
-		if (avtab_search(&p->te_avtab, k)) {
+		if (selinux_avtab_search(&p->te_avtab, k)) {
 			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
 			goto err;
 		}
@@ -284,9 +284,9 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 		 * be any other entries.
 		 */
 		if (other) {
-			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
+			node_ptr = selinux_avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
-				if (avtab_search_node_next(node_ptr, k->specified)) {
+				if (selinux_avtab_search_node_next(node_ptr, k->specified)) {
 					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
 					goto err;
 				}
@@ -303,20 +303,20 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 				}
 			}
 		} else {
-			if (avtab_search(&p->te_cond_avtab, k)) {
+			if (selinux_avtab_search(&p->te_cond_avtab, k)) {
 				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
 				goto err;
 			}
 		}
 	}
 
-	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
+	node_ptr = selinux_avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
 		printk(KERN_ERR "SELinux: could not insert rule.\n");
 		goto err;
 	}
 
-	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+	list = kzalloc(sizeof(struct selinux_cond_av_list), GFP_KERNEL);
 	if (!list)
 		goto err;
 
@@ -334,7 +334,7 @@ err:
 	return -1;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
+static int cond_read_av_list(struct policydb *p, void *fp, struct selinux_cond_av_list **ret_list, struct selinux_cond_av_list *other)
 {
 	int i, rc;
 	__le32 buf[1];
@@ -357,7 +357,7 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 	data.head = NULL;
 	data.tail = NULL;
 	for (i = 0; i < len; i++) {
-		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
+		rc = selinux_avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
 				     &data);
 		if (rc)
 			return rc;
@@ -368,7 +368,7 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 	return 0;
 }
 
-static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
+static int expr_isvalid(struct policydb *p, struct selinux_cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
 		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
@@ -382,12 +382,12 @@ static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 	return 1;
 }
 
-static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+static int cond_read_node(struct policydb *p, struct selinux_cond_node *node, void *fp)
 {
 	__le32 buf[2];
 	u32 len, i;
 	int rc;
-	struct cond_expr *expr = NULL, *last = NULL;
+	struct selinux_cond_expr *expr = NULL, *last = NULL;
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc < 0)
@@ -408,7 +408,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 		if (rc < 0)
 			goto err;
 
-		expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		expr = kzalloc(sizeof(struct selinux_cond_expr), GFP_KERNEL);
 		if (!expr)
 			goto err;
 
@@ -437,9 +437,9 @@ err:
 	return -1;
 }
 
-int cond_read_list(struct policydb *p, void *fp)
+int selinux_cond_read_list(struct policydb *p, void *fp)
 {
-	struct cond_node *node, *last = NULL;
+	struct selinux_cond_node *node, *last = NULL;
 	__le32 buf[1];
 	u32 i, len;
 	int rc;
@@ -450,12 +450,12 @@ int cond_read_list(struct policydb *p, void *fp)
 
 	len = le32_to_cpu(buf[0]);
 
-	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
+	rc = selinux_avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
 	if (rc)
 		goto err;
 
 	for (i = 0; i < len; i++) {
-		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
+		node = kzalloc(sizeof(struct selinux_cond_node), GFP_KERNEL);
 		if (!node)
 			goto err;
 
@@ -478,15 +478,15 @@ err:
 /* Determine whether additional permissions are granted by the conditional
  * av table, and if so, add them to the result
  */
-void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd)
+void selinux_cond_compute_av(struct selinux_avtab *ctab, struct selinux_avtab_key *key, struct av_decision *avd)
 {
-	struct avtab_node *node;
+	struct selinux_avtab_node *node;
 
 	if (!ctab || !key || !avd)
 		return;
 
-	for (node = avtab_search_node(ctab, key); node;
-				node = avtab_search_node_next(node, key->specified)) {
+	for (node = selinux_avtab_search_node(ctab, key); node;
+				node = selinux_avtab_search_node_next(node, key->specified)) {
 		if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) ==
 		    (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
 			avd->allowed |= node->datum.data;
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 53ddb01..163b49c 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -20,7 +20,7 @@
  * A conditional expression is a list of operators and operands
  * in reverse polish notation.
  */
-struct cond_expr {
+struct selinux_cond_expr {
 #define COND_BOOL	1 /* plain bool */
 #define COND_NOT	2 /* !bool */
 #define COND_OR		3 /* bool || bool */
@@ -31,17 +31,17 @@ struct cond_expr {
 #define COND_LAST	COND_NEQ
 	__u32 expr_type;
 	__u32 bool;
-	struct cond_expr *next;
+	struct selinux_cond_expr *next;
 };
 
 /*
- * Each cond_node contains a list of rules to be enabled/disabled
+ * Each selinux_cond_node contains a list of rules to be enabled/disabled
  * depending on the current value of the conditional expression. This
  * struct is for that list.
  */
-struct cond_av_list {
-	struct avtab_node *node;
-	struct cond_av_list *next;
+struct selinux_cond_av_list {
+	struct selinux_avtab_node *node;
+	struct selinux_cond_av_list *next;
 };
 
 /*
@@ -51,27 +51,27 @@ struct cond_av_list {
  * expression (the true list corresponds to if and the false list corresponds
  * to else)..
  */
-struct cond_node {
+struct selinux_cond_node {
 	int cur_state;
-	struct cond_expr *expr;
-	struct cond_av_list *true_list;
-	struct cond_av_list *false_list;
-	struct cond_node *next;
+	struct selinux_cond_expr *expr;
+	struct selinux_cond_av_list *true_list;
+	struct selinux_cond_av_list *false_list;
+	struct selinux_cond_node *next;
 };
 
-int cond_policydb_init(struct policydb *p);
-void cond_policydb_destroy(struct policydb *p);
+int selinux_cond_policydb_init(struct policydb *p);
+void selinux_cond_policydb_destroy(struct policydb *p);
 
-int cond_init_bool_indexes(struct policydb *p);
-int cond_destroy_bool(void *key, void *datum, void *p);
+int selinux_cond_init_bool_indexes(struct policydb *p);
+int selinux_cond_destroy_bool(void *key, void *datum, void *p);
 
-int cond_index_bool(void *key, void *datum, void *datap);
+int selinux_cond_index_bool(void *key, void *datum, void *datap);
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
-int cond_read_list(struct policydb *p, void *fp);
+int selinux_cond_read_bool(struct policydb *p, struct selinux_hashtab *h, void *fp);
+int selinux_cond_read_list(struct policydb *p, void *fp);
 
-void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd);
+void selinux_cond_compute_av(struct selinux_avtab *ctab, struct selinux_avtab_key *key, struct av_decision *avd);
 
-int evaluate_cond_node(struct policydb *p, struct cond_node *node);
+int selinux_evaluate_cond_node(struct policydb *p, struct selinux_cond_node *node);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 149dda7..d07bd2a 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -19,7 +19,7 @@
 
 #define CEXPR_MAXDEPTH 5
 
-struct constraint_expr {
+struct selinux_constraint_expr {
 #define CEXPR_NOT		1 /* not expr */
 #define CEXPR_AND		2 /* expr and expr */
 #define CEXPR_OR		3 /* expr or expr */
@@ -47,15 +47,15 @@ struct constraint_expr {
 #define CEXPR_INCOMP 5		/* incomp */
 	u32 op;			/* operator */
 
-	struct ebitmap names;	/* names */
+	struct selinux_ebitmap names;	/* names */
 
-	struct constraint_expr *next;   /* next expression */
+	struct selinux_constraint_expr *next;   /* next expression */
 };
 
-struct constraint_node {
+struct selinux_constraint_node {
 	u32 permissions;	/* constrained permissions */
-	struct constraint_expr *expr;	/* constraint on permissions */
-	struct constraint_node *next;	/* next constraint */
+	struct selinux_constraint_expr *expr;	/* constraint on permissions */
+	struct selinux_constraint_node *next;	/* next constraint */
 };
 
 #endif	/* _SS_CONSTRAINT_H_ */
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index d9dd7a2..6e93020 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -45,14 +45,14 @@ static inline int mls_context_cpy(struct context *dst, struct context *src)
 		return 0;
 
 	dst->range.level[0].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	rc = selinux_ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
 	if (rc)
 		goto out;
 
 	dst->range.level[1].sens = src->range.level[1].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
+	rc = selinux_ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
 	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
+		selinux_ebitmap_destroy(&dst->range.level[0].cat);
 out:
 	return rc;
 }
@@ -68,14 +68,14 @@ static inline int mls_context_cpy_low(struct context *dst, struct context *src)
 		return 0;
 
 	dst->range.level[0].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	rc = selinux_ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
 	if (rc)
 		goto out;
 
 	dst->range.level[1].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
+	rc = selinux_ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
 	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
+		selinux_ebitmap_destroy(&dst->range.level[0].cat);
 out:
 	return rc;
 }
@@ -86,9 +86,9 @@ static inline int mls_context_cmp(struct context *c1, struct context *c2)
 		return 1;
 
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
-		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
+		selinux_ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
 		(c1->range.level[1].sens == c2->range.level[1].sens) &&
-		ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
+		selinux_ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
 }
 
 static inline void mls_context_destroy(struct context *c)
@@ -96,8 +96,8 @@ static inline void mls_context_destroy(struct context *c)
 	if (!selinux_mls_enabled)
 		return;
 
-	ebitmap_destroy(&c->range.level[0].cat);
-	ebitmap_destroy(&c->range.level[1].cat);
+	selinux_ebitmap_destroy(&c->range.level[0].cat);
+	selinux_ebitmap_destroy(&c->range.level[1].cat);
 	mls_context_init(c);
 }
 
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 68c7348..40ba1ab 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -22,9 +22,9 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
+int selinux_ebitmap_cmp(struct selinux_ebitmap *e1, struct selinux_ebitmap *e2)
 {
-	struct ebitmap_node *n1, *n2;
+	struct selinux_ebitmap_node *n1, *n2;
 
 	if (e1->highbit != e2->highbit)
 		return 0;
@@ -44,9 +44,9 @@ int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 	return 1;
 }
 
-int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
+int selinux_ebitmap_cpy(struct selinux_ebitmap *dst, struct selinux_ebitmap *src)
 {
-	struct ebitmap_node *n, *new, *prev;
+	struct selinux_ebitmap_node *n, *new, *prev;
 
 	ebitmap_init(dst);
 	n = src->node;
@@ -54,7 +54,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 	while (n) {
 		new = kzalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
-			ebitmap_destroy(dst);
+			selinux_ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
 		new->startbit = n->startbit;
@@ -74,8 +74,8 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 
 #ifdef CONFIG_NETLABEL
 /**
- * ebitmap_netlbl_export - Export an ebitmap into a NetLabel category bitmap
- * @ebmap: the ebitmap to export
+ * ebitmap_netlbl_export - Export an selinux_ebitmap into a NetLabel category bitmap
+ * @ebmap: the selinux_ebitmap to export
  * @catmap: the NetLabel category bitmap
  *
  * Description:
@@ -83,10 +83,10 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
  * Returns zero on success, negative values on error.
  *
  */
-int ebitmap_netlbl_export(struct ebitmap *ebmap,
+int selinux_ebitmap_netlbl_export(struct selinux_ebitmap *ebmap,
 			  struct netlbl_lsm_secattr_catmap **catmap)
 {
-	struct ebitmap_node *e_iter = ebmap->node;
+	struct selinux_ebitmap_node *e_iter = ebmap->node;
 	struct netlbl_lsm_secattr_catmap *c_iter;
 	u32 cmap_idx, cmap_sft;
 	int i;
@@ -142,7 +142,7 @@ netlbl_export_failure:
 
 /**
  * ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
- * @ebmap: the ebitmap to import
+ * @ebmap: the selinux_ebitmap to import
  * @catmap: the NetLabel category bitmap
  *
  * Description:
@@ -150,11 +150,11 @@ netlbl_export_failure:
  * Returns zero on success, negative values on error.
  *
  */
-int ebitmap_netlbl_import(struct ebitmap *ebmap,
+int selinux_ebitmap_netlbl_import(struct selinux_ebitmap *ebmap,
 			  struct netlbl_lsm_secattr_catmap *catmap)
 {
-	struct ebitmap_node *e_iter = NULL;
-	struct ebitmap_node *emap_prev = NULL;
+	struct selinux_ebitmap_node *e_iter = NULL;
+	struct selinux_ebitmap_node *emap_prev = NULL;
 	struct netlbl_lsm_secattr_catmap *c_iter = catmap;
 	u32 c_idx, c_pos, e_idx, e_sft;
 
@@ -201,19 +201,19 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 	if (e_iter != NULL)
 		ebmap->highbit = e_iter->startbit + EBITMAP_SIZE;
 	else
-		ebitmap_destroy(ebmap);
+		selinux_ebitmap_destroy(ebmap);
 
 	return 0;
 
 netlbl_import_failure:
-	ebitmap_destroy(ebmap);
+	selinux_ebitmap_destroy(ebmap);
 	return -ENOMEM;
 }
 #endif /* CONFIG_NETLABEL */
 
-int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
+int selinux_ebitmap_contains(struct selinux_ebitmap *e1, struct selinux_ebitmap *e2)
 {
-	struct ebitmap_node *n1, *n2;
+	struct selinux_ebitmap_node *n1, *n2;
 	int i;
 
 	if (e1->highbit < e2->highbit)
@@ -241,9 +241,9 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
 	return 1;
 }
 
-int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
+int selinux_ebitmap_get_bit(struct selinux_ebitmap *e, unsigned long bit)
 {
-	struct ebitmap_node *n;
+	struct selinux_ebitmap_node *n;
 
 	if (e->highbit < bit)
 		return 0;
@@ -258,9 +258,9 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+int selinux_ebitmap_set_bit(struct selinux_ebitmap *e, unsigned long bit, int value)
 {
-	struct ebitmap_node *n, *prev, *new;
+	struct selinux_ebitmap_node *n, *prev, *new;
 
 	prev = NULL;
 	n = e->node;
@@ -326,9 +326,9 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 	return 0;
 }
 
-void ebitmap_destroy(struct ebitmap *e)
+void selinux_ebitmap_destroy(struct selinux_ebitmap *e)
 {
-	struct ebitmap_node *n, *temp;
+	struct selinux_ebitmap_node *n, *temp;
 
 	if (!e)
 		return;
@@ -345,9 +345,9 @@ void ebitmap_destroy(struct ebitmap *e)
 	return;
 }
 
-int ebitmap_read(struct ebitmap *e, void *fp)
+int selinux_ebitmap_read(struct selinux_ebitmap *e, void *fp)
 {
-	struct ebitmap_node *n = NULL;
+	struct selinux_ebitmap_node *n = NULL;
 	u32 mapunit, count, startbit, index;
 	u64 map;
 	__le32 buf[3];
@@ -388,20 +388,20 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 		startbit = le32_to_cpu(startbit);
 
 		if (startbit & (mapunit - 1)) {
-			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
+			printk(KERN_ERR "SELinux: selinux_ebitmap start bit (%d) is "
 			       "not a multiple of the map unit size (%u)\n",
 			       startbit, mapunit);
 			goto bad;
 		}
 		if (startbit > e->highbit - mapunit) {
-			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
+			printk(KERN_ERR "SELinux: selinux_ebitmap start bit (%d) is "
 			       "beyond the end of the bitmap (%u)\n",
 			       startbit, (e->highbit - mapunit));
 			goto bad;
 		}
 
 		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
-			struct ebitmap_node *tmp;
+			struct selinux_ebitmap_node *tmp;
 			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 			if (!tmp) {
 				printk(KERN_ERR
@@ -443,6 +443,6 @@ out:
 bad:
 	if (!rc)
 		rc = -EINVAL;
-	ebitmap_destroy(e);
+	selinux_ebitmap_destroy(e);
 	goto out;
 }
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index f283b43..98090bc 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -24,22 +24,22 @@
 #define EBITMAP_SHIFT_UNIT_SIZE(x)					\
 	(((x) >> EBITMAP_UNIT_SIZE / 2) >> EBITMAP_UNIT_SIZE / 2)
 
-struct ebitmap_node {
-	struct ebitmap_node *next;
+struct selinux_ebitmap_node {
+	struct selinux_ebitmap_node *next;
 	unsigned long maps[EBITMAP_UNIT_NUMS];
 	u32 startbit;
 };
 
-struct ebitmap {
-	struct ebitmap_node *node;	/* first node in the bitmap */
+struct selinux_ebitmap {
+	struct selinux_ebitmap_node *node;	/* first node in the bitmap */
 	u32 highbit;	/* highest position in the total bitmap */
 };
 
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 
-static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
-						  struct ebitmap_node **n)
+static inline unsigned int ebitmap_start_positive(struct selinux_ebitmap *e,
+						  struct selinux_ebitmap_node **n)
 {
 	unsigned int ofs;
 
@@ -51,13 +51,13 @@ static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
 	return ebitmap_length(e);
 }
 
-static inline void ebitmap_init(struct ebitmap *e)
+static inline void ebitmap_init(struct selinux_ebitmap *e)
 {
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
-						 struct ebitmap_node **n,
+static inline unsigned int ebitmap_next_positive(struct selinux_ebitmap *e,
+						 struct selinux_ebitmap_node **n,
 						 unsigned int bit)
 {
 	unsigned int ofs;
@@ -79,7 +79,7 @@ static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
 #define EBITMAP_NODE_OFFSET(node, bit)	\
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
-static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
+static inline int ebitmap_node_get_bit(struct selinux_ebitmap_node *n,
 				       unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -91,7 +91,7 @@ static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
 	return 0;
 }
 
-static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
+static inline void ebitmap_node_set_bit(struct selinux_ebitmap_node *n,
 					unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -101,7 +101,7 @@ static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
-static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
+static inline void ebitmap_node_clr_bit(struct selinux_ebitmap_node *n,
 					unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -116,26 +116,26 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 	     bit < ebitmap_length(e);			\
 	     bit = ebitmap_next_positive(e, &n, bit))	\
 
-int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
-int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
-void ebitmap_destroy(struct ebitmap *e);
-int ebitmap_read(struct ebitmap *e, void *fp);
+int selinux_ebitmap_cmp(struct selinux_ebitmap *e1, struct selinux_ebitmap *e2);
+int selinux_ebitmap_cpy(struct selinux_ebitmap *dst, struct selinux_ebitmap *src);
+int selinux_ebitmap_contains(struct selinux_ebitmap *e1, struct selinux_ebitmap *e2);
+int selinux_ebitmap_get_bit(struct selinux_ebitmap *e, unsigned long bit);
+int selinux_ebitmap_set_bit(struct selinux_ebitmap *e, unsigned long bit, int value);
+void selinux_ebitmap_destroy(struct selinux_ebitmap *e);
+int selinux_ebitmap_read(struct selinux_ebitmap *e, void *fp);
 
 #ifdef CONFIG_NETLABEL
-int ebitmap_netlbl_export(struct ebitmap *ebmap,
+int selinux_ebitmap_netlbl_export(struct selinux_ebitmap *ebmap,
 			  struct netlbl_lsm_secattr_catmap **catmap);
-int ebitmap_netlbl_import(struct ebitmap *ebmap,
+int selinux_ebitmap_netlbl_import(struct selinux_ebitmap *ebmap,
 			  struct netlbl_lsm_secattr_catmap *catmap);
 #else
-static inline int ebitmap_netlbl_export(struct ebitmap *ebmap,
+static inline int selinux_ebitmap_netlbl_export(struct selinux_ebitmap *ebmap,
 				struct netlbl_lsm_secattr_catmap **catmap)
 {
 	return -ENOMEM;
 }
-static inline int ebitmap_netlbl_import(struct ebitmap *ebmap,
+static inline int selinux_ebitmap_netlbl_import(struct selinux_ebitmap *ebmap,
 				struct netlbl_lsm_secattr_catmap *catmap)
 {
 	return -ENOMEM;
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 933e735..bb3dad7 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -8,11 +8,11 @@
 #include <linux/errno.h>
 #include "hashtab.h"
 
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
+struct selinux_hashtab *selinux_hashtab_create(u32 (*hash_value)(struct selinux_hashtab *h, const void *key),
+			       int (*keycmp)(struct selinux_hashtab *h, const void *key1, const void *key2),
 			       u32 size)
 {
-	struct hashtab *p;
+	struct selinux_hashtab *p;
 	u32 i;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
@@ -35,10 +35,10 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	return p;
 }
 
-int hashtab_insert(struct hashtab *h, void *key, void *datum)
+int selinux_hashtab_insert(struct selinux_hashtab *h, void *key, void *datum)
 {
 	u32 hvalue;
-	struct hashtab_node *prev, *cur, *newnode;
+	struct selinux_hashtab_node *prev, *cur, *newnode;
 
 	if (!h || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
@@ -71,10 +71,10 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, const void *key)
+void *selinux_hashtab_search(struct selinux_hashtab *h, const void *key)
 {
 	u32 hvalue;
-	struct hashtab_node *cur;
+	struct selinux_hashtab_node *cur;
 
 	if (!h)
 		return NULL;
@@ -90,10 +90,10 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	return cur->datum;
 }
 
-void hashtab_destroy(struct hashtab *h)
+void selinux_hashtab_destroy(struct selinux_hashtab *h)
 {
 	u32 i;
-	struct hashtab_node *cur, *temp;
+	struct selinux_hashtab_node *cur, *temp;
 
 	if (!h)
 		return;
@@ -114,13 +114,13 @@ void hashtab_destroy(struct hashtab *h)
 	kfree(h);
 }
 
-int hashtab_map(struct hashtab *h,
+int selinux_hashtab_map(struct selinux_hashtab *h,
 		int (*apply)(void *k, void *d, void *args),
 		void *args)
 {
 	u32 i;
 	int ret;
-	struct hashtab_node *cur;
+	struct selinux_hashtab_node *cur;
 
 	if (!h)
 		return 0;
@@ -138,10 +138,10 @@ int hashtab_map(struct hashtab *h,
 }
 
 
-void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
+void selinux_hashtab_stat(struct selinux_hashtab *h, struct selinux_hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
-	struct hashtab_node *cur;
+	struct selinux_hashtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 953872c..0a81e71 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -12,23 +12,23 @@
 
 #define HASHTAB_MAX_NODES	0xffffffff
 
-struct hashtab_node {
+struct selinux_hashtab_node {
 	void *key;
 	void *datum;
-	struct hashtab_node *next;
+	struct selinux_hashtab_node *next;
 };
 
-struct hashtab {
-	struct hashtab_node **htable;	/* hash table */
+struct selinux_hashtab {
+	struct selinux_hashtab_node **htable;	/* hash table */
 	u32 size;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
-	u32 (*hash_value)(struct hashtab *h, const void *key);
+	u32 (*hash_value)(struct selinux_hashtab *h, const void *key);
 					/* hash function */
-	int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
+	int (*keycmp)(struct selinux_hashtab *h, const void *key1, const void *key2);
 					/* key comparison function */
 };
 
-struct hashtab_info {
+struct selinux_hashtab_info {
 	u32 slots_used;
 	u32 max_chain_len;
 };
@@ -39,8 +39,8 @@ struct hashtab_info {
  * Returns NULL if insufficent space is available or
  * the new hash table otherwise.
  */
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
+struct selinux_hashtab *selinux_hashtab_create(u32 (*hash_value)(struct selinux_hashtab *h, const void *key),
+			       int (*keycmp)(struct selinux_hashtab *h, const void *key1, const void *key2),
 			       u32 size);
 
 /*
@@ -51,7 +51,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
  * -EINVAL for general errors or
   0 otherwise.
  */
-int hashtab_insert(struct hashtab *h, void *k, void *d);
+int selinux_hashtab_insert(struct selinux_hashtab *h, void *k, void *d);
 
 /*
  * Searches for the entry with the specified key in the hash table.
@@ -59,12 +59,12 @@ int hashtab_insert(struct hashtab *h, void *k, void *d);
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, const void *k);
+void *selinux_hashtab_search(struct selinux_hashtab *h, const void *k);
 
 /*
  * Destroys the specified hash table.
  */
-void hashtab_destroy(struct hashtab *h);
+void selinux_hashtab_destroy(struct selinux_hashtab *h);
 
 /*
  * Applies the specified apply function to (key,datum,args)
@@ -77,11 +77,11 @@ void hashtab_destroy(struct hashtab *h);
  * iterating through the hash table and will propagate the error
  * return to its caller.
  */
-int hashtab_map(struct hashtab *h,
+int selinux_hashtab_map(struct selinux_hashtab *h,
 		int (*apply)(void *k, void *d, void *args),
 		void *args);
 
 /* Fill info with some hash table statistics */
-void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
+void selinux_hashtab_stat(struct selinux_hashtab *h, struct selinux_hashtab_info *info);
 
 #endif	/* _SS_HASHTAB_H */
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b5407f1..af1bf49 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -36,8 +36,8 @@ int mls_compute_context_len(struct context *context)
 {
 	int i, l, len, head, prev;
 	char *nm;
-	struct ebitmap *e;
-	struct ebitmap_node *node;
+	struct selinux_ebitmap *e;
+	struct selinux_ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return 0;
@@ -90,8 +90,8 @@ void mls_sid_to_context(struct context *context,
 {
 	char *scontextp, *nm;
 	int i, l, head, prev;
-	struct ebitmap *e;
-	struct ebitmap_node *node;
+	struct selinux_ebitmap *e;
+	struct selinux_ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return;
@@ -160,12 +160,12 @@ void mls_sid_to_context(struct context *context,
 int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 {
 	struct level_datum *levdatum;
-	struct ebitmap_node *node;
+	struct selinux_ebitmap_node *node;
 	int i;
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return 0;
-	levdatum = hashtab_search(p->p_levels.table,
+	levdatum = selinux_hashtab_search(p->p_levels.table,
 				  p->p_sens_val_to_name[l->sens - 1]);
 	if (!levdatum)
 		return 0;
@@ -173,7 +173,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 	ebitmap_for_each_positive_bit(&l->cat, node, i) {
 		if (i > p->p_cats.nprim)
 			return 0;
-		if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
+		if (!selinux_ebitmap_get_bit(&levdatum->level->cat, i)) {
 			/*
 			 * Category may not be associated with
 			 * sensitivity.
@@ -287,7 +287,7 @@ int mls_context_to_sid(struct policydb *pol,
 		*p++ = '\0';
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(pol->p_levels.table, scontextp);
+		levdatum = selinux_hashtab_search(pol->p_levels.table, scontextp);
 		if (!levdatum) {
 			rc = -EINVAL;
 			goto out;
@@ -312,14 +312,14 @@ int mls_context_to_sid(struct policydb *pol,
 					*rngptr++ = '\0';
 				}
 
-				catdatum = hashtab_search(pol->p_cats.table,
+				catdatum = selinux_hashtab_search(pol->p_cats.table,
 							  scontextp);
 				if (!catdatum) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				rc = ebitmap_set_bit(&context->range.level[l].cat,
+				rc = selinux_ebitmap_set_bit(&context->range.level[l].cat,
 						     catdatum->value - 1, 1);
 				if (rc)
 					goto out;
@@ -328,7 +328,7 @@ int mls_context_to_sid(struct policydb *pol,
 				if (rngptr) {
 					int i;
 
-					rngdatum = hashtab_search(pol->p_cats.table, rngptr);
+					rngdatum = selinux_hashtab_search(pol->p_cats.table, rngptr);
 					if (!rngdatum) {
 						rc = -EINVAL;
 						goto out;
@@ -340,7 +340,7 @@ int mls_context_to_sid(struct policydb *pol,
 					}
 
 					for (i = catdatum->value; i < rngdatum->value; i++) {
-						rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
+						rc = selinux_ebitmap_set_bit(&context->range.level[l].cat, i, 1);
 						if (rc)
 							goto out;
 					}
@@ -365,7 +365,7 @@ int mls_context_to_sid(struct policydb *pol,
 
 	if (l == 0) {
 		context->range.level[1].sens = context->range.level[0].sens;
-		rc = ebitmap_cpy(&context->range.level[1].cat,
+		rc = selinux_ebitmap_cpy(&context->range.level[1].cat,
 				 &context->range.level[0].cat);
 		if (rc)
 			goto out;
@@ -415,7 +415,7 @@ static inline int mls_range_set(struct context *context,
 	/* Copy the MLS range into the  context */
 	for (l = 0; l < 2; l++) {
 		context->range.level[l].sens = range->level[l].sens;
-		rc = ebitmap_cpy(&context->range.level[l].cat,
+		rc = selinux_ebitmap_cpy(&context->range.level[l].cat,
 				 &range->level[l].cat);
 		if (rc)
 			break;
@@ -473,15 +473,15 @@ int mls_convert_context(struct policydb *oldp,
 {
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
-	struct ebitmap bitmap;
-	struct ebitmap_node *node;
+	struct selinux_ebitmap bitmap;
+	struct selinux_ebitmap_node *node;
 	int l, i;
 
 	if (!selinux_mls_enabled)
 		return 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(newp->p_levels.table,
+		levdatum = selinux_hashtab_search(newp->p_levels.table,
 			oldp->p_sens_val_to_name[c->range.level[l].sens - 1]);
 
 		if (!levdatum)
@@ -492,15 +492,15 @@ int mls_convert_context(struct policydb *oldp,
 		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
 			int rc;
 
-			catdatum = hashtab_search(newp->p_cats.table,
+			catdatum = selinux_hashtab_search(newp->p_cats.table,
 						  oldp->p_cat_val_to_name[i]);
 			if (!catdatum)
 				return -EINVAL;
-			rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
+			rc = selinux_ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
 			if (rc)
 				return rc;
 		}
-		ebitmap_destroy(&c->range.level[l].cat);
+		selinux_ebitmap_destroy(&c->range.level[l].cat);
 		c->range.level[l].cat = bitmap;
 	}
 
@@ -606,7 +606,7 @@ int mls_export_netlbl_cat(struct context *context,
 	if (!selinux_mls_enabled)
 		return 0;
 
-	rc = ebitmap_netlbl_export(&context->range.level[0].cat,
+	rc = selinux_ebitmap_netlbl_export(&context->range.level[0].cat,
 				   &secattr->attr.mls.cat);
 	if (rc == 0 && secattr->attr.mls.cat != NULL)
 		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
@@ -634,12 +634,12 @@ int mls_import_netlbl_cat(struct context *context,
 	if (!selinux_mls_enabled)
 		return 0;
 
-	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
+	rc = selinux_ebitmap_netlbl_import(&context->range.level[0].cat,
 				   secattr->attr.mls.cat);
 	if (rc != 0)
 		goto import_netlbl_cat_failure;
 
-	rc = ebitmap_cpy(&context->range.level[1].cat,
+	rc = selinux_ebitmap_cpy(&context->range.level[1].cat,
 			 &context->range.level[0].cat);
 	if (rc != 0)
 		goto import_netlbl_cat_failure;
@@ -647,8 +647,8 @@ int mls_import_netlbl_cat(struct context *context,
 	return 0;
 
 import_netlbl_cat_failure:
-	ebitmap_destroy(&context->range.level[0].cat);
-	ebitmap_destroy(&context->range.level[1].cat);
+	selinux_ebitmap_destroy(&context->range.level[0].cat);
+	selinux_ebitmap_destroy(&context->range.level[1].cat);
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index b6e943a..5d33694 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -18,7 +18,7 @@
 
 struct mls_level {
 	u32 sens;		/* sensitivity */
-	struct ebitmap cat;	/* category set */
+	struct selinux_ebitmap cat;	/* category set */
 };
 
 struct mls_range {
@@ -31,7 +31,7 @@ static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 		return 1;
 
 	return ((l1->sens == l2->sens) &&
-		ebitmap_cmp(&l1->cat, &l2->cat));
+		selinux_ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
 static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
@@ -40,7 +40,7 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 		return 1;
 
 	return ((l1->sens >= l2->sens) &&
-		ebitmap_contains(&l1->cat, &l2->cat));
+		selinux_ebitmap_contains(&l1->cat, &l2->cat));
 }
 
 #define mls_level_incomp(l1, l2) \
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 72e4a54..6bd9c9c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -164,7 +164,7 @@ static int roles_init(struct policydb *p)
 		goto out_free_role;
 	}
 	strcpy(key, OBJECT_R);
-	rc = hashtab_insert(p->p_roles.table, key, role);
+	rc = selinux_hashtab_insert(p->p_roles.table, key, role);
 	if (rc)
 		goto out_free_key;
 out:
@@ -192,7 +192,7 @@ static int policydb_init(struct policydb *p)
 			goto out_free_symtab;
 	}
 
-	rc = avtab_init(&p->te_avtab);
+	rc = selinux_avtab_init(&p->te_avtab);
 	if (rc)
 		goto out_free_symtab;
 
@@ -200,7 +200,7 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out_free_symtab;
 
-	rc = cond_policydb_init(p);
+	rc = selinux_cond_policydb_init(p);
 	if (rc)
 		goto out_free_symtab;
 
@@ -212,7 +212,7 @@ out:
 
 out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++)
-		hashtab_destroy(p->symtab[i].table);
+		selinux_hashtab_destroy(p->symtab[i].table);
 	goto out;
 }
 
@@ -347,7 +347,7 @@ static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	role_index,
 	type_index,
 	user_index,
-	cond_index_bool,
+	selinux_cond_index_bool,
 	sens_index,
 	cat_index,
 };
@@ -370,7 +370,7 @@ static int policydb_index_classes(struct policydb *p)
 		goto out;
 	}
 
-	rc = hashtab_map(p->p_commons.table, common_index, p);
+	rc = selinux_hashtab_map(p->p_commons.table, common_index, p);
 	if (rc)
 		goto out;
 
@@ -388,7 +388,7 @@ static int policydb_index_classes(struct policydb *p)
 		goto out;
 	}
 
-	rc = hashtab_map(p->p_classes.table, class_index, p);
+	rc = selinux_hashtab_map(p->p_classes.table, class_index, p);
 out:
 	return rc;
 }
@@ -399,10 +399,10 @@ static void symtab_hash_eval(struct symtab *s)
 	int i;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		struct hashtab *h = s[i].table;
-		struct hashtab_info info;
+		struct selinux_hashtab *h = s[i].table;
+		struct selinux_hashtab_info info;
 
-		hashtab_stat(h, &info);
+		selinux_hashtab_stat(h, &info);
 		printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
 		       "longest chain length %d\n", symtab_name[i], h->nel,
 		       info.slots_used, h->size, info.max_chain_len);
@@ -431,7 +431,7 @@ static int policydb_index_others(struct policydb *p)
 	       p->p_classes.nprim, p->te_avtab.nel);
 
 #ifdef DEBUG_HASHES
-	avtab_hash_eval(&p->te_avtab, "rules");
+	selinux_avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 #endif
 
@@ -459,7 +459,7 @@ static int policydb_index_others(struct policydb *p)
 		goto out;
 	}
 
-	if (cond_init_bool_indexes(p)) {
+	if (selinux_cond_init_bool_indexes(p)) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -471,7 +471,7 @@ static int policydb_index_others(struct policydb *p)
 			rc = -ENOMEM;
 			goto out;
 		}
-		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
+		rc = selinux_hashtab_map(p->symtab[i].table, index_f[i], p);
 		if (rc)
 			goto out;
 	}
@@ -499,8 +499,8 @@ static int common_destroy(void *key, void *datum, void *p)
 
 	kfree(key);
 	comdatum = datum;
-	hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
-	hashtab_destroy(comdatum->permissions.table);
+	selinux_hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
+	selinux_hashtab_destroy(comdatum->permissions.table);
 	kfree(datum);
 	return 0;
 }
@@ -508,18 +508,18 @@ static int common_destroy(void *key, void *datum, void *p)
 static int cls_destroy(void *key, void *datum, void *p)
 {
 	struct class_datum *cladatum;
-	struct constraint_node *constraint, *ctemp;
-	struct constraint_expr *e, *etmp;
+	struct selinux_constraint_node *constraint, *ctemp;
+	struct selinux_constraint_expr *e, *etmp;
 
 	kfree(key);
 	cladatum = datum;
-	hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-	hashtab_destroy(cladatum->permissions.table);
+	selinux_hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
+	selinux_hashtab_destroy(cladatum->permissions.table);
 	constraint = cladatum->constraints;
 	while (constraint) {
 		e = constraint->expr;
 		while (e) {
-			ebitmap_destroy(&e->names);
+			selinux_ebitmap_destroy(&e->names);
 			etmp = e;
 			e = e->next;
 			kfree(etmp);
@@ -533,7 +533,7 @@ static int cls_destroy(void *key, void *datum, void *p)
 	while (constraint) {
 		e = constraint->expr;
 		while (e) {
-			ebitmap_destroy(&e->names);
+			selinux_ebitmap_destroy(&e->names);
 			etmp = e;
 			e = e->next;
 			kfree(etmp);
@@ -554,8 +554,8 @@ static int role_destroy(void *key, void *datum, void *p)
 
 	kfree(key);
 	role = datum;
-	ebitmap_destroy(&role->dominates);
-	ebitmap_destroy(&role->types);
+	selinux_ebitmap_destroy(&role->dominates);
+	selinux_ebitmap_destroy(&role->types);
 	kfree(datum);
 	return 0;
 }
@@ -573,10 +573,10 @@ static int user_destroy(void *key, void *datum, void *p)
 
 	kfree(key);
 	usrdatum = datum;
-	ebitmap_destroy(&usrdatum->roles);
-	ebitmap_destroy(&usrdatum->range.level[0].cat);
-	ebitmap_destroy(&usrdatum->range.level[1].cat);
-	ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	selinux_ebitmap_destroy(&usrdatum->roles);
+	selinux_ebitmap_destroy(&usrdatum->range.level[0].cat);
+	selinux_ebitmap_destroy(&usrdatum->range.level[1].cat);
+	selinux_ebitmap_destroy(&usrdatum->dfltlevel.cat);
 	kfree(datum);
 	return 0;
 }
@@ -587,7 +587,7 @@ static int sens_destroy(void *key, void *datum, void *p)
 
 	kfree(key);
 	levdatum = datum;
-	ebitmap_destroy(&levdatum->level->cat);
+	selinux_ebitmap_destroy(&levdatum->level->cat);
 	kfree(levdatum->level);
 	kfree(datum);
 	return 0;
@@ -607,7 +607,7 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	role_destroy,
 	type_destroy,
 	user_destroy,
-	cond_destroy_bool,
+	selinux_cond_destroy_bool,
 	sens_destroy,
 	cat_destroy,
 };
@@ -636,8 +636,8 @@ void policydb_destroy(struct policydb *p)
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
-		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
-		hashtab_destroy(p->symtab[i].table);
+		selinux_hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
+		selinux_hashtab_destroy(p->symtab[i].table);
 	}
 
 	for (i = 0; i < SYM_NUM; i++)
@@ -648,7 +648,7 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->user_val_to_struct);
 	kfree(p->type_val_to_struct);
 
-	avtab_destroy(&p->te_avtab);
+	selinux_avtab_destroy(&p->te_avtab);
 
 	for (i = 0; i < OCON_NUM; i++) {
 		cond_resched();
@@ -677,7 +677,7 @@ void policydb_destroy(struct policydb *p)
 	}
 	p->genfs = NULL;
 
-	cond_policydb_destroy(p);
+	selinux_cond_policydb_destroy(p);
 
 	for (tr = p->role_tr; tr; tr = tr->next) {
 		cond_resched();
@@ -696,26 +696,26 @@ void policydb_destroy(struct policydb *p)
 	for (rt = p->range_tr; rt; rt = rt->next) {
 		cond_resched();
 		if (lrt) {
-			ebitmap_destroy(&lrt->target_range.level[0].cat);
-			ebitmap_destroy(&lrt->target_range.level[1].cat);
+			selinux_ebitmap_destroy(&lrt->target_range.level[0].cat);
+			selinux_ebitmap_destroy(&lrt->target_range.level[1].cat);
 			kfree(lrt);
 		}
 		lrt = rt;
 	}
 	if (lrt) {
-		ebitmap_destroy(&lrt->target_range.level[0].cat);
-		ebitmap_destroy(&lrt->target_range.level[1].cat);
+		selinux_ebitmap_destroy(&lrt->target_range.level[0].cat);
+		selinux_ebitmap_destroy(&lrt->target_range.level[1].cat);
 		kfree(lrt);
 	}
 
 	if (p->type_attr_map) {
 		for (i = 0; i < p->p_types.nprim; i++)
-			ebitmap_destroy(&p->type_attr_map[i]);
+			selinux_ebitmap_destroy(&p->type_attr_map[i]);
 	}
 	kfree(p->type_attr_map);
 	kfree(p->undefined_perms);
-	ebitmap_destroy(&p->policycaps);
-	ebitmap_destroy(&p->permissive_map);
+	selinux_ebitmap_destroy(&p->policycaps);
+	selinux_ebitmap_destroy(&p->permissive_map);
 
 	return;
 }
@@ -798,7 +798,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->types,
+		if (!selinux_ebitmap_get_bit(&role->types,
 				     c->type - 1))
 			/* role may not be associated with type */
 			return 0;
@@ -810,7 +810,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		if (!usrdatum)
 			return 0;
 
-		if (!ebitmap_get_bit(&usrdatum->roles,
+		if (!selinux_ebitmap_get_bit(&usrdatum->roles,
 				     c->role - 1))
 			/* user may not be associated with role */
 			return 0;
@@ -853,21 +853,21 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 	else
 		r->level[1].sens = r->level[0].sens;
 
-	rc = ebitmap_read(&r->level[0].cat, fp);
+	rc = selinux_ebitmap_read(&r->level[0].cat, fp);
 	if (rc) {
 		printk(KERN_ERR "SELinux: mls:  error reading low "
 		       "categories\n");
 		goto out;
 	}
 	if (items > 1) {
-		rc = ebitmap_read(&r->level[1].cat, fp);
+		rc = selinux_ebitmap_read(&r->level[1].cat, fp);
 		if (rc) {
 			printk(KERN_ERR "SELinux: mls:  error reading high "
 			       "categories\n");
 			goto bad_high;
 		}
 	} else {
-		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
+		rc = selinux_ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
 		if (rc) {
 			printk(KERN_ERR "SELinux: mls:  out of memory\n");
 			goto bad_high;
@@ -878,7 +878,7 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 out:
 	return rc;
 bad_high:
-	ebitmap_destroy(&r->level[0].cat);
+	selinux_ebitmap_destroy(&r->level[0].cat);
 	goto out;
 }
 
@@ -925,7 +925,7 @@ out:
  * binary representation file.
  */
 
-static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
+static int perm_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -956,7 +956,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	key[len] = '\0';
 
-	rc = hashtab_insert(h, key, perdatum);
+	rc = selinux_hashtab_insert(h, key, perdatum);
 	if (rc)
 		goto bad;
 out:
@@ -966,7 +966,7 @@ bad:
 	goto out;
 }
 
-static int common_read(struct policydb *p, struct hashtab *h, void *fp)
+static int common_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
@@ -1009,7 +1009,7 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, comdatum);
+	rc = selinux_hashtab_insert(h, key, comdatum);
 	if (rc)
 		goto bad;
 out:
@@ -1019,11 +1019,11 @@ bad:
 	goto out;
 }
 
-static int read_cons_helper(struct constraint_node **nodep, int ncons,
+static int read_cons_helper(struct selinux_constraint_node **nodep, int ncons,
 			    int allowxtarget, void *fp)
 {
-	struct constraint_node *c, *lc;
-	struct constraint_expr *e, *le;
+	struct selinux_constraint_node *c, *lc;
+	struct selinux_constraint_expr *e, *le;
 	__le32 buf[3];
 	u32 nexpr;
 	int rc, i, j, depth;
@@ -1085,7 +1085,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 				if (depth == (CEXPR_MAXDEPTH - 1))
 					return -EINVAL;
 				depth++;
-				if (ebitmap_read(&e->names, fp))
+				if (selinux_ebitmap_read(&e->names, fp))
 					return -EINVAL;
 				break;
 			default:
@@ -1101,7 +1101,7 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct hashtab *h, void *fp)
+static int class_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
@@ -1152,7 +1152,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 		cladatum->comkey[len2] = '\0';
 
-		cladatum->comdatum = hashtab_search(p->p_commons.table,
+		cladatum->comdatum = selinux_hashtab_search(p->p_commons.table,
 						    cladatum->comkey);
 		if (!cladatum->comdatum) {
 			printk(KERN_ERR "SELinux:  unknown common %s\n",
@@ -1182,7 +1182,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, cladatum);
+	rc = selinux_hashtab_insert(h, key, cladatum);
 	if (rc)
 		goto bad;
 
@@ -1194,7 +1194,7 @@ bad:
 	goto out;
 }
 
-static int role_read(struct policydb *p, struct hashtab *h, void *fp)
+static int role_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
@@ -1230,11 +1230,11 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	key[len] = '\0';
 
-	rc = ebitmap_read(&role->dominates, fp);
+	rc = selinux_ebitmap_read(&role->dominates, fp);
 	if (rc)
 		goto bad;
 
-	rc = ebitmap_read(&role->types, fp);
+	rc = selinux_ebitmap_read(&role->types, fp);
 	if (rc)
 		goto bad;
 
@@ -1249,7 +1249,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	}
 
-	rc = hashtab_insert(h, key, role);
+	rc = selinux_hashtab_insert(h, key, role);
 	if (rc)
 		goto bad;
 out:
@@ -1259,7 +1259,7 @@ bad:
 	goto out;
 }
 
-static int type_read(struct policydb *p, struct hashtab *h, void *fp)
+static int type_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
@@ -1305,7 +1305,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	key[len] = '\0';
 
-	rc = hashtab_insert(h, key, typdatum);
+	rc = selinux_hashtab_insert(h, key, typdatum);
 	if (rc)
 		goto bad;
 out:
@@ -1334,7 +1334,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	}
 	lp->sens = le32_to_cpu(buf[0]);
 
-	if (ebitmap_read(&lp->cat, fp)) {
+	if (selinux_ebitmap_read(&lp->cat, fp)) {
 		printk(KERN_ERR "SELinux: mls:  error reading level "
 		       "categories\n");
 		goto bad;
@@ -1346,7 +1346,7 @@ bad:
 	return -EINVAL;
 }
 
-static int user_read(struct policydb *p, struct hashtab *h, void *fp)
+static int user_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
@@ -1382,7 +1382,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	key[len] = '\0';
 
-	rc = ebitmap_read(&usrdatum->roles, fp);
+	rc = selinux_ebitmap_read(&usrdatum->roles, fp);
 	if (rc)
 		goto bad;
 
@@ -1395,7 +1395,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, usrdatum);
+	rc = selinux_hashtab_insert(h, key, usrdatum);
 	if (rc)
 		goto bad;
 out:
@@ -1405,7 +1405,7 @@ bad:
 	goto out;
 }
 
-static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
+static int sens_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct level_datum *levdatum;
@@ -1446,7 +1446,7 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	}
 
-	rc = hashtab_insert(h, key, levdatum);
+	rc = selinux_hashtab_insert(h, key, levdatum);
 	if (rc)
 		goto bad;
 out:
@@ -1456,7 +1456,7 @@ bad:
 	goto out;
 }
 
-static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
+static int cat_read(struct policydb *p, struct selinux_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct cat_datum *catdatum;
@@ -1488,7 +1488,7 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	key[len] = '\0';
 
-	rc = hashtab_insert(h, key, catdatum);
+	rc = selinux_hashtab_insert(h, key, catdatum);
 	if (rc)
 		goto bad;
 out:
@@ -1499,14 +1499,14 @@ bad:
 	goto out;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
+static int (*read_f[SYM_NUM]) (struct policydb *p, struct selinux_hashtab *h, void *fp) =
 {
 	common_read,
 	class_read,
 	role_read,
 	type_read,
 	user_read,
-	cond_read_bool,
+	selinux_cond_read_bool,
 	sens_read,
 	cat_read,
 };
@@ -1519,7 +1519,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 
 	upper = user = datum;
 	while (upper->bounds) {
-		struct ebitmap_node *node;
+		struct selinux_ebitmap_node *node;
 		unsigned long bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
@@ -1531,7 +1531,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 
 		upper = p->user_val_to_struct[upper->bounds - 1];
 		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
-			if (ebitmap_get_bit(&upper->roles, bit))
+			if (selinux_ebitmap_get_bit(&upper->roles, bit))
 				continue;
 
 			printk(KERN_ERR
@@ -1556,7 +1556,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 
 	upper = role = datum;
 	while (upper->bounds) {
-		struct ebitmap_node *node;
+		struct selinux_ebitmap_node *node;
 		unsigned long bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
@@ -1568,7 +1568,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 
 		upper = p->role_val_to_struct[upper->bounds - 1];
 		ebitmap_for_each_positive_bit(&role->types, node, bit) {
-			if (ebitmap_get_bit(&upper->types, bit))
+			if (selinux_ebitmap_get_bit(&upper->types, bit))
 				continue;
 
 			printk(KERN_ERR
@@ -1620,17 +1620,17 @@ static int policydb_bounds_sanity_check(struct policydb *p)
 	if (p->policyvers < POLICYDB_VERSION_BOUNDARY)
 		return 0;
 
-	rc = hashtab_map(p->p_users.table,
+	rc = selinux_hashtab_map(p->p_users.table,
 			 user_bounds_sanity_check, p);
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->p_roles.table,
+	rc = selinux_hashtab_map(p->p_roles.table,
 			 role_bounds_sanity_check, p);
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->p_types.table,
+	rc = selinux_hashtab_map(p->p_types.table,
 			 type_bounds_sanity_check, p);
 	if (rc)
 		return rc;
@@ -1747,11 +1747,11 @@ int policydb_read(struct policydb *p, void *fp)
 	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
 
 	if (p->policyvers >= POLICYDB_VERSION_POLCAP &&
-	    ebitmap_read(&p->policycaps, fp) != 0)
+	    selinux_ebitmap_read(&p->policycaps, fp) != 0)
 		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
-	    ebitmap_read(&p->permissive_map, fp) != 0)
+	    selinux_ebitmap_read(&p->permissive_map, fp) != 0)
 		goto bad;
 
 	info = policydb_lookup_compat(p->policyvers);
@@ -1785,12 +1785,12 @@ int policydb_read(struct policydb *p, void *fp)
 		p->symtab[i].nprim = nprim;
 	}
 
-	rc = avtab_read(&p->te_avtab, fp, p);
+	rc = selinux_avtab_read(&p->te_avtab, fp, p);
 	if (rc)
 		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_BOOL) {
-		rc = cond_read_list(p, fp);
+		rc = selinux_cond_read_list(p, fp);
 		if (rc)
 			goto bad;
 	}
@@ -2119,18 +2119,18 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 	}
 
-	p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct ebitmap), GFP_KERNEL);
+	p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct selinux_ebitmap), GFP_KERNEL);
 	if (!p->type_attr_map)
 		goto bad;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
 		ebitmap_init(&p->type_attr_map[i]);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
-			if (ebitmap_read(&p->type_attr_map[i], fp))
+			if (selinux_ebitmap_read(&p->type_attr_map[i], fp))
 				goto bad;
 		}
 		/* add the type itself as the degenerate case */
-		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+		if (selinux_ebitmap_set_bit(&p->type_attr_map[i], i, 1))
 				goto bad;
 	}
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 55152d4..85716f0 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -54,16 +54,16 @@ struct class_datum {
 	char *comkey;			/* common name */
 	struct common_datum *comdatum;	/* common datum */
 	struct symtab permissions;	/* class-specific permission symbol table */
-	struct constraint_node *constraints;	/* constraints on class permissions */
-	struct constraint_node *validatetrans;	/* special transition rules */
+	struct selinux_constraint_node *constraints;	/* constraints on class permissions */
+	struct selinux_constraint_node *validatetrans;	/* special transition rules */
 };
 
 /* Role attributes */
 struct role_datum {
 	u32 value;			/* internal role value */
 	u32 bounds;			/* boundary of role */
-	struct ebitmap dominates;	/* set of roles dominated by this role */
-	struct ebitmap types;		/* set of authorized types for role */
+	struct selinux_ebitmap dominates;	/* set of roles dominated by this role */
+	struct selinux_ebitmap types;		/* set of authorized types for role */
 };
 
 struct role_trans {
@@ -91,7 +91,7 @@ struct type_datum {
 struct user_datum {
 	u32 value;			/* internal user value */
 	u32 bounds;			/* bounds of user */
-	struct ebitmap roles;		/* set of authorized roles for user */
+	struct selinux_ebitmap roles;		/* set of authorized roles for user */
 	struct mls_range range;		/* MLS range (min - max) for user */
 	struct mls_level dfltlevel;	/* default login MLS level for user */
 };
@@ -118,12 +118,12 @@ struct range_trans {
 };
 
 /* Boolean data type */
-struct cond_bool_datum {
+struct selinux_cond_bool_datum {
 	__u32 value;		/* internal type value */
 	int state;
 };
 
-struct cond_node;
+struct selinux_cond_node;
 
 /*
  * The configuration data includes security contexts for
@@ -216,17 +216,17 @@ struct policydb {
 	struct type_datum **type_val_to_struct;
 
 	/* type enforcement access vectors and transitions */
-	struct avtab te_avtab;
+	struct selinux_avtab te_avtab;
 
 	/* role transitions */
 	struct role_trans *role_tr;
 
 	/* bools indexed by (value - 1) */
-	struct cond_bool_datum **bool_val_to_struct;
+	struct selinux_cond_bool_datum **bool_val_to_struct;
 	/* type enforcement conditional access vectors and transitions */
-	struct avtab te_cond_avtab;
+	struct selinux_avtab te_cond_avtab;
 	/* linked list indexing te_cond_avtab by conditional */
-	struct cond_node *cond_list;
+	struct selinux_cond_node *cond_list;
 
 	/* role allows */
 	struct role_allow *role_allow;
@@ -244,11 +244,11 @@ struct policydb {
 	struct range_trans *range_tr;
 
 	/* type -> attribute reverse mapping */
-	struct ebitmap *type_attr_map;
+	struct selinux_ebitmap *type_attr_map;
 
-	struct ebitmap policycaps;
+	struct selinux_ebitmap policycaps;
 
-	struct ebitmap permissive_map;
+	struct selinux_ebitmap permissive_map;
 
 	unsigned int policyvers;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 55816c0..109cd50 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -112,13 +112,13 @@ static int context_struct_compute_av(struct context *scontext,
 static int constraint_expr_eval(struct context *scontext,
 				struct context *tcontext,
 				struct context *xcontext,
-				struct constraint_expr *cexpr)
+				struct selinux_constraint_expr *cexpr)
 {
 	u32 val1, val2;
 	struct context *c;
 	struct role_datum *r1, *r2;
 	struct mls_level *l1, *l2;
-	struct constraint_expr *e;
+	struct selinux_constraint_expr *e;
 	int s[CEXPR_MAXDEPTH];
 	int sp = -1;
 
@@ -157,17 +157,17 @@ static int constraint_expr_eval(struct context *scontext,
 				r2 = policydb.role_val_to_struct[val2 - 1];
 				switch (e->op) {
 				case CEXPR_DOM:
-					s[++sp] = ebitmap_get_bit(&r1->dominates,
+					s[++sp] = selinux_ebitmap_get_bit(&r1->dominates,
 								  val2 - 1);
 					continue;
 				case CEXPR_DOMBY:
-					s[++sp] = ebitmap_get_bit(&r2->dominates,
+					s[++sp] = selinux_ebitmap_get_bit(&r2->dominates,
 								  val1 - 1);
 					continue;
 				case CEXPR_INCOMP:
-					s[++sp] = (!ebitmap_get_bit(&r1->dominates,
+					s[++sp] = (!selinux_ebitmap_get_bit(&r1->dominates,
 								    val2 - 1) &&
-						   !ebitmap_get_bit(&r2->dominates,
+						   !selinux_ebitmap_get_bit(&r2->dominates,
 								    val1 - 1));
 					continue;
 				default:
@@ -263,10 +263,10 @@ mls_ops:
 
 			switch (e->op) {
 			case CEXPR_EQ:
-				s[++sp] = ebitmap_get_bit(&e->names, val1 - 1);
+				s[++sp] = selinux_ebitmap_get_bit(&e->names, val1 - 1);
 				break;
 			case CEXPR_NEQ:
-				s[++sp] = !ebitmap_get_bit(&e->names, val1 - 1);
+				s[++sp] = !selinux_ebitmap_get_bit(&e->names, val1 - 1);
 				break;
 			default:
 				BUG();
@@ -324,11 +324,11 @@ static void security_dump_masked_av(struct context *scontext,
 
 	/* init permission_names */
 	if (common_dat &&
-	    hashtab_map(common_dat->permissions.table,
+	    selinux_hashtab_map(common_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
 		goto out;
 
-	if (hashtab_map(tclass_dat->permissions.table,
+	if (selinux_hashtab_map(tclass_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
 		goto out;
 
@@ -460,13 +460,13 @@ static int context_struct_compute_av(struct context *scontext,
 				     u32 requested,
 				     struct av_decision *avd)
 {
-	struct constraint_node *constraint;
+	struct selinux_constraint_node *constraint;
 	struct role_allow *ra;
-	struct avtab_key avkey;
-	struct avtab_node *node;
+	struct selinux_avtab_key avkey;
+	struct selinux_avtab_node *node;
 	struct class_datum *tclass_datum;
-	struct ebitmap *sattr, *tattr;
-	struct ebitmap_node *snode, *tnode;
+	struct selinux_ebitmap *sattr, *tattr;
+	struct selinux_ebitmap_node *snode, *tnode;
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
 
@@ -532,9 +532,9 @@ static int context_struct_compute_av(struct context *scontext,
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
-			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
+			for (node = selinux_avtab_search_node(&policydb.te_avtab, &avkey);
 			     node;
-			     node = avtab_search_node_next(node, avkey.specified)) {
+			     node = selinux_avtab_search_node_next(node, avkey.specified)) {
 				if (node->key.specified == AVTAB_ALLOWED)
 					avd->allowed |= node->datum.data;
 				else if (node->key.specified == AVTAB_AUDITALLOW)
@@ -544,7 +544,7 @@ static int context_struct_compute_av(struct context *scontext,
 			}
 
 			/* Check conditional av table for additional permissions */
-			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+			selinux_cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
 
 		}
 	}
@@ -642,7 +642,7 @@ int selinux_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 	struct context *ncontext;
 	struct context *tcontext;
 	struct class_datum *tclass_datum;
-	struct constraint_node *constraint;
+	struct selinux_constraint_node *constraint;
 	int rc = 0;
 
 	if (!ss_initialized)
@@ -843,7 +843,7 @@ int selinux_compute_av(u32 ssid,
 				       requested, avd);
 
 	/* permissive domain? */
-	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
+	if (selinux_ebitmap_get_bit(&policydb.permissive_map, scontext->type))
 	    avd->flags |= AVD_FLAGS_PERMISSIVE;
 out:
 	read_unlock(&policy_rwlock);
@@ -1011,7 +1011,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(pol->p_users.table, scontextp);
+	usrdatum = selinux_hashtab_search(pol->p_users.table, scontextp);
 	if (!usrdatum)
 		goto out;
 
@@ -1027,7 +1027,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	role = hashtab_search(pol->p_roles.table, scontextp);
+	role = selinux_hashtab_search(pol->p_roles.table, scontextp);
 	if (!role)
 		goto out;
 	ctx->role = role->value;
@@ -1039,7 +1039,7 @@ static int string_to_context_struct(struct policydb *pol,
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(pol->p_types.table, scontextp);
+	typdatum = selinux_hashtab_search(pol->p_types.table, scontextp);
 	if (!typdatum || typdatum->attribute)
 		goto out;
 
@@ -1210,9 +1210,9 @@ static int security_compute_sid(u32 ssid,
 {
 	struct context *scontext = NULL, *tcontext = NULL, newcontext;
 	struct role_trans *roletr = NULL;
-	struct avtab_key avkey;
-	struct avtab_datum *avdatum;
-	struct avtab_node *node;
+	struct selinux_avtab_key avkey;
+	struct selinux_avtab_datum *avdatum;
+	struct selinux_avtab_node *node;
 	int rc = 0;
 
 	if (!ss_initialized) {
@@ -1278,12 +1278,12 @@ static int security_compute_sid(u32 ssid,
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avkey.specified = specified;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey);
+	avdatum = selinux_avtab_search(&policydb.te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
 	if (!avdatum) {
-		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
-		for (; node; node = avtab_search_node_next(node, specified)) {
+		node = selinux_avtab_search_node(&policydb.te_cond_avtab, &avkey);
+		for (; node; node = selinux_avtab_search_node_next(node, specified)) {
 			if (node->key.specified & AVTAB_ENABLED) {
 				avdatum = &node->datum;
 				break;
@@ -1456,7 +1456,7 @@ static int validate_classes(struct policydb *p)
 		if (class_val > p->p_classes.nprim)
 			continue;
 		pol_class = p->p_class_val_to_name[class_val-1];
-		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		cladatum = selinux_hashtab_search(p->p_classes.table, pol_class);
 		BUG_ON(!cladatum);
 		perms = &cladatum->permissions;
 		nprim = 1 << (perms->nprim - 1);
@@ -1471,7 +1471,7 @@ static int validate_classes(struct policydb *p)
 			print_unknown_handle = 1;
 			continue;
 		}
-		perdatum = hashtab_search(perms->table, def_perm);
+		perdatum = selinux_hashtab_search(perms->table, def_perm);
 		if (perdatum == NULL) {
 			printk(KERN_ERR
 			       "SELinux:  permission %s in class %s not found in policy, bad policy\n",
@@ -1491,7 +1491,7 @@ static int validate_classes(struct policydb *p)
 		if (class_val > p->p_classes.nprim)
 			continue;
 		pol_class = p->p_class_val_to_name[class_val-1];
-		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		cladatum = selinux_hashtab_search(p->p_classes.table, pol_class);
 		BUG_ON(!cladatum);
 		if (!cladatum->comdatum) {
 			printk(KERN_ERR
@@ -1519,7 +1519,7 @@ static int validate_classes(struct policydb *p)
 				print_unknown_handle = 1;
 				continue;
 			}
-			perdatum = hashtab_search(perms->table, def_perm);
+			perdatum = selinux_hashtab_search(perms->table, def_perm);
 			if (perdatum == NULL) {
 				printk(KERN_ERR
 				       "SELinux:  permission %s in class %s not found in policy, bad policy\n",
@@ -1635,21 +1635,21 @@ static int convert_context(u32 key,
 	rc = -EINVAL;
 
 	/* Convert the user. */
-	usrdatum = hashtab_search(args->newp->p_users.table,
+	usrdatum = selinux_hashtab_search(args->newp->p_users.table,
 				  args->oldp->p_user_val_to_name[c->user - 1]);
 	if (!usrdatum)
 		goto bad;
 	c->user = usrdatum->value;
 
 	/* Convert the role. */
-	role = hashtab_search(args->newp->p_roles.table,
+	role = selinux_hashtab_search(args->newp->p_roles.table,
 			      args->oldp->p_role_val_to_name[c->role - 1]);
 	if (!role)
 		goto bad;
 	c->role = role->value;
 
 	/* Convert the type. */
-	typdatum = hashtab_search(args->newp->p_types.table,
+	typdatum = selinux_hashtab_search(args->newp->p_types.table,
 				  args->oldp->p_type_val_to_name[c->type - 1]);
 	if (!typdatum)
 		goto bad;
@@ -1687,9 +1687,9 @@ bad:
 
 static void selinux_load_policycaps(void)
 {
-	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
+	selinux_policycap_netpeer = selinux_ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_NETPEER);
-	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
+	selinux_policycap_openperm = selinux_ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_OPENPERM);
 }
 
@@ -1716,14 +1716,14 @@ int selinux_load_policy(void *data, size_t len)
 	struct policy_file file = { data, len }, *fp = &file;
 
 	if (!ss_initialized) {
-		avtab_cache_init();
+		selinux_avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
-			avtab_cache_destroy();
+			selinux_avtab_cache_destroy();
 			return -EINVAL;
 		}
 		if (policydb_load_isids(&policydb, &sidtab)) {
 			policydb_destroy(&policydb);
-			avtab_cache_destroy();
+			selinux_avtab_cache_destroy();
 			return -EINVAL;
 		}
 		/* Verify that the kernel defined classes are correct. */
@@ -1732,7 +1732,7 @@ int selinux_load_policy(void *data, size_t len)
 			       "SELinux:  the definition of a class is incorrect\n");
 			sidtab_destroy(&sidtab);
 			policydb_destroy(&policydb);
-			avtab_cache_destroy();
+			selinux_avtab_cache_destroy();
 			return -EINVAL;
 		}
 		selinux_load_policycaps();
@@ -2015,7 +2015,7 @@ int selinux_get_user_sids(u32 fromsid,
 	u32 mynel = 0, maxnel = SIDS_NEL;
 	struct user_datum *user;
 	struct role_datum *role;
-	struct ebitmap_node *rnode, *tnode;
+	struct selinux_ebitmap_node *rnode, *tnode;
 	int rc = 0, i, j;
 
 	*sids = NULL;
@@ -2034,7 +2034,7 @@ int selinux_get_user_sids(u32 fromsid,
 		goto out_unlock;
 	}
 
-	user = hashtab_search(policydb.p_users.table, username);
+	user = selinux_hashtab_search(policydb.p_users.table, username);
 	if (!user) {
 		rc = -EINVAL;
 		goto out_unlock;
@@ -2269,7 +2269,7 @@ int selinux_set_bools(int len, int *values)
 {
 	int i, rc = 0;
 	int lenp, seqno = 0;
-	struct cond_node *cur;
+	struct selinux_cond_node *cur;
 
 	write_lock_irq(&policy_rwlock);
 
@@ -2297,7 +2297,7 @@ int selinux_set_bools(int len, int *values)
 	}
 
 	for (cur = policydb.cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(&policydb, cur);
+		rc = selinux_evaluate_cond_node(&policydb, cur);
 		if (rc)
 			goto out;
 	}
@@ -2337,19 +2337,19 @@ static int security_preserve_bools(struct policydb *p)
 {
 	int rc, nbools = 0, *bvalues = NULL, i;
 	char **bnames = NULL;
-	struct cond_bool_datum *booldatum;
-	struct cond_node *cur;
+	struct selinux_cond_bool_datum *booldatum;
+	struct selinux_cond_node *cur;
 
 	rc = selinux_get_bools(&nbools, &bnames, &bvalues);
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
-		booldatum = hashtab_search(p->p_bools.table, bnames[i]);
+		booldatum = selinux_hashtab_search(p->p_bools.table, bnames[i]);
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
 	for (cur = p->cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(p, cur);
+		rc = selinux_evaluate_cond_node(p, cur);
 		if (rc)
 			goto out;
 	}
@@ -2539,7 +2539,7 @@ int selinux_get_classes(char ***classes, int *nclasses)
 	if (!*classes)
 		goto out;
 
-	rc = hashtab_map(policydb.p_classes.table, get_classes_callback,
+	rc = selinux_hashtab_map(policydb.p_classes.table, get_classes_callback,
 			*classes);
 	if (rc < 0) {
 		int i;
@@ -2573,7 +2573,7 @@ int selinux_get_permissions(char *class, char ***perms, int *nperms)
 
 	read_lock(&policy_rwlock);
 
-	match = hashtab_search(policydb.p_classes.table, class);
+	match = selinux_hashtab_search(policydb.p_classes.table, class);
 	if (!match) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
@@ -2587,13 +2587,13 @@ int selinux_get_permissions(char *class, char ***perms, int *nperms)
 		goto out;
 
 	if (match->comdatum) {
-		rc = hashtab_map(match->comdatum->permissions.table,
+		rc = selinux_hashtab_map(match->comdatum->permissions.table,
 				get_permissions_callback, *perms);
 		if (rc < 0)
 			goto err;
 	}
 
-	rc = hashtab_map(match->permissions.table, get_permissions_callback,
+	rc = selinux_hashtab_map(match->permissions.table, get_permissions_callback,
 			*perms);
 	if (rc < 0)
 		goto err;
@@ -2635,7 +2635,7 @@ int selinux_policycap_supported(unsigned int req_cap)
 	int rc;
 
 	read_lock(&policy_rwlock);
-	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
+	rc = selinux_ebitmap_get_bit(&policydb.policycaps, req_cap);
 	read_unlock(&policy_rwlock);
 
 	return rc;
@@ -2707,7 +2707,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	switch (field) {
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
-		userdatum = hashtab_search(policydb.p_users.table, rulestr);
+		userdatum = selinux_hashtab_search(policydb.p_users.table, rulestr);
 		if (!userdatum)
 			rc = -EINVAL;
 		else
@@ -2715,7 +2715,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		break;
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
-		roledatum = hashtab_search(policydb.p_roles.table, rulestr);
+		roledatum = selinux_hashtab_search(policydb.p_roles.table, rulestr);
 		if (!roledatum)
 			rc = -EINVAL;
 		else
@@ -2723,7 +2723,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		break;
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
-		typedatum = hashtab_search(policydb.p_types.table, rulestr);
+		typedatum = selinux_hashtab_search(policydb.p_types.table, rulestr);
 		if (!typedatum)
 			rc = -EINVAL;
 		else
@@ -2989,7 +2989,7 @@ int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		ctx_new.type = ctx->type;
 		mls_import_netlbl_lvl(&ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
-			if (ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
+			if (selinux_ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
 						  secattr->attr.mls.cat) != 0)
 				goto netlbl_secattr_to_sid_return;
 			memcpy(&ctx_new.range.level[1].cat,
@@ -3005,7 +3005,7 @@ int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 
 		security_netlbl_cache_add(secattr, *sid);
 
-		ebitmap_destroy(&ctx_new.range.level[0].cat);
+		selinux_ebitmap_destroy(&ctx_new.range.level[0].cat);
 	} else {
 		*sid = SECSID_NULL;
 		rc = 0;
@@ -3015,7 +3015,7 @@ netlbl_secattr_to_sid_return:
 	read_unlock(&policy_rwlock);
 	return rc;
 netlbl_secattr_to_sid_return_cleanup:
-	ebitmap_destroy(&ctx_new.range.level[0].cat);
+	selinux_ebitmap_destroy(&ctx_new.range.level[0].cat);
 	goto netlbl_secattr_to_sid_return;
 }
 
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 837658a..a55884e 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -9,7 +9,7 @@
 #include <linux/errno.h>
 #include "symtab.h"
 
-static unsigned int symhash(struct hashtab *h, const void *key)
+static unsigned int symhash(struct selinux_hashtab *h, const void *key)
 {
 	const char *p, *keyp;
 	unsigned int size;
@@ -23,7 +23,7 @@ static unsigned int symhash(struct hashtab *h, const void *key)
 	return val & (h->size - 1);
 }
 
-static int symcmp(struct hashtab *h, const void *key1, const void *key2)
+static int symcmp(struct selinux_hashtab *h, const void *key1, const void *key2)
 {
 	const char *keyp1, *keyp2;
 
@@ -35,7 +35,7 @@ static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 
 int symtab_init(struct symtab *s, unsigned int size)
 {
-	s->table = hashtab_create(symhash, symcmp, size);
+	s->table = selinux_hashtab_create(symhash, symcmp, size);
 	if (!s->table)
 		return -1;
 	s->nprim = 0;
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index ca422b4..09bbf05 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -12,7 +12,7 @@
 #include "hashtab.h"
 
 struct symtab {
-	struct hashtab *table;	/* hash table (keyed on a string) */
+	struct selinux_hashtab *table;	/* hash table (keyed on a string) */
 	u32 nprim;		/* number of primary names in table */
 };
 
-- 
1.6.2.5




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
