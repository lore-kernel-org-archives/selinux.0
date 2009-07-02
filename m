Subject: [PATCH 3/4] Namespacing of security/selinux
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Content-Type: text/plain
Date: Thu, 02 Jul 2009 16:55:08 -0400
Message-Id: <1246568108.2480.29.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Namespacing of security/selinux/ss/policydb.h.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
 security/selinux/ss/avtab.c       |    4 +-
 security/selinux/ss/avtab.h       |    6 +-
 security/selinux/ss/conditional.c |   26 ++--
 security/selinux/ss/conditional.h |   12 +-
 security/selinux/ss/context.h     |   20 ++--
 security/selinux/ss/mls.c         |   62 +++++-----
 security/selinux/ss/mls.h         |   50 ++++----
 security/selinux/ss/policydb.c    |  164 +++++++++++-----------
 security/selinux/ss/policydb.h    |   86 ++++++------
 security/selinux/ss/services.c    |  270
++++++++++++++++++------------------
 security/selinux/ss/services.h    |    2 +-
 security/selinux/ss/sidtab.c      |   52 ++++----
 security/selinux/ss/sidtab.h      |   34 +++---
 security/selinux/ss/symtab.c      |    2 +-
 security/selinux/ss/symtab.h      |    4 +-
 15 files changed, 397 insertions(+), 397 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index fec765d..44d8167 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -323,7 +323,7 @@ static uint16_t spec_order[] = {
 	AVTAB_MEMBER
 };
 
-int selinux_ss_avtab_read_item(struct selinux_ss_avtab *a, void *fp,
struct policydb *pol,
+int selinux_ss_avtab_read_item(struct selinux_ss_avtab *a, void *fp,
struct selinux_ss_policydb *pol,
 		    int (*insertf)(struct selinux_ss_avtab *a, struct
selinux_ss_avtab_key *k,
 				   struct selinux_ss_avtab_datum *d, void *p),
 		    void *p)
@@ -457,7 +457,7 @@ static int avtab_insertf(struct selinux_ss_avtab *a,
struct selinux_ss_avtab_key
 	return avtab_insert(a, k, d);
 }
 
-int selinux_ss_avtab_read(struct selinux_ss_avtab *a, void *fp, struct
policydb *pol)
+int selinux_ss_avtab_read(struct selinux_ss_avtab *a, void *fp, struct
selinux_ss_policydb *pol)
 {
 	int rc;
 	__le32 buf[1];
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index a7752bb..70b39c1 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -64,13 +64,13 @@ struct selinux_ss_avtab_datum
*selinux_ss_avtab_search(struct selinux_ss_avtab *
 void selinux_ss_avtab_destroy(struct selinux_ss_avtab *h);
 void selinux_ss_avtab_hash_eval(struct selinux_ss_avtab *h, char *tag);
 
-struct policydb;
-int selinux_ss_avtab_read_item(struct selinux_ss_avtab *a, void *fp,
struct policydb *pol,
+struct selinux_ss_policydb;
+int selinux_ss_avtab_read_item(struct selinux_ss_avtab *a, void *fp,
struct selinux_ss_policydb *pol,
 			       int (*insert)(struct selinux_ss_avtab *a, struct
selinux_ss_avtab_key *k,
 			       struct selinux_ss_avtab_datum *d, void *p),
 			       void *p);
 
-int selinux_ss_avtab_read(struct selinux_ss_avtab *a, void *fp, struct
policydb *pol);
+int selinux_ss_avtab_read(struct selinux_ss_avtab *a, void *fp, struct
selinux_ss_policydb *pol);
 
 struct selinux_ss_avtab_node *selinux_ss_avtab_insert_nonunique(struct
selinux_ss_avtab *h, struct selinux_ss_avtab_key *key,
 								struct selinux_ss_avtab_datum *datum);
diff --git a/security/selinux/ss/conditional.c
b/security/selinux/ss/conditional.c
index 306ef50..c48f1c2 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -22,7 +22,7 @@
  * or undefined (-1). Undefined occurs when the expression
  * exceeds the stack depth of COND_EXPR_MAXDEPTH.
  */
-static int cond_evaluate_expr(struct policydb *p, struct
selinux_ss_cond_expr *expr)
+static int cond_evaluate_expr(struct selinux_ss_policydb *p, struct
selinux_ss_cond_expr *expr)
 {
 
 	struct selinux_ss_cond_expr *cur;
@@ -86,7 +86,7 @@ static int cond_evaluate_expr(struct policydb *p,
struct selinux_ss_cond_expr *e
  * list appropriately. If the result of the expression is undefined
  * all of the rules are disabled for safety.
  */
-int selinux_ss_evaluate_cond_node(struct policydb *p, struct
selinux_ss_cond_node *node)
+int selinux_ss_evaluate__cond_node(struct selinux_ss_policydb *p,
struct selinux_ss_cond_node *node)
 {
 	int new_state;
 	struct selinux_ss_cond_av_list *cur;
@@ -115,7 +115,7 @@ int selinux_ss_evaluate_cond_node(struct policydb
*p, struct selinux_ss_cond_nod
 	return 0;
 }
 
-int selinux_ss_cond_policydb_init(struct policydb *p)
+int selinux_ss_cond_policydb_init(struct selinux_ss_policydb *p)
 {
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
@@ -161,14 +161,14 @@ static void cond_list_destroy(struct
selinux_ss_cond_node *list)
 	}
 }
 
-void selinux_ss_cond_policydb_destroy(struct policydb *p)
+void selinux_ss_cond_policydb_destroy(struct selinux_ss_policydb *p)
 {
 	kfree(p->bool_val_to_struct);
 	selinux_ss_avtab_destroy(&p->te_cond_avtab);
 	cond_list_destroy(p->cond_list);
 }
 
-int selinux_ss_cond_init_bool_indexes(struct policydb *p)
+int selinux_ss_cond_init_bool_indexes(struct selinux_ss_policydb *p)
 {
 	kfree(p->bool_val_to_struct);
 	p->bool_val_to_struct = (struct selinux_ss_cond_bool_datum **)
@@ -187,7 +187,7 @@ int selinux_ss_cond_destroy_bool(void *key, void
*datum, void *p)
 
 int selinux_ss_cond_index_bool(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
+	struct selinux_ss_policydb *p;
 	struct selinux_ss_cond_bool_datum *booldatum;
 
 	booldatum = datum;
@@ -209,7 +209,7 @@ static int bool_isvalid(struct
selinux_ss_cond_bool_datum *b)
 	return 1;
 }
 
-int selinux_ss_cond_read_bool(struct policydb *p, struct
selinux_ss_hashtab *h, void *fp)
+int selinux_ss_cond_read_bool(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct selinux_ss_cond_bool_datum *booldatum;
@@ -250,7 +250,7 @@ err:
 }
 
 struct cond_insertf_data {
-	struct policydb *p;
+	struct selinux_ss_policydb *p;
 	struct selinux_ss_cond_av_list *other;
 	struct selinux_ss_cond_av_list *head;
 	struct selinux_ss_cond_av_list *tail;
@@ -259,7 +259,7 @@ struct cond_insertf_data {
 static int cond_insertf(struct selinux_ss_avtab *a, struct
selinux_ss_avtab_key *k, struct selinux_ss_avtab_datum *d, void *ptr)
 {
 	struct cond_insertf_data *data = ptr;
-	struct policydb *p = data->p;
+	struct selinux_ss_policydb *p = data->p;
 	struct selinux_ss_cond_av_list *other = data->other, *list, *cur;
 	struct selinux_ss_avtab_node *node_ptr;
 	u8 found;
@@ -334,7 +334,7 @@ err:
 	return -1;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp, struct
selinux_ss_cond_av_list **ret_list, struct selinux_ss_cond_av_list
*other)
+static int cond_read_av_list(struct selinux_ss_policydb *p, void *fp,
struct selinux_ss_cond_av_list **ret_list, struct
selinux_ss_cond_av_list *other)
 {
 	int i, rc;
 	__le32 buf[1];
@@ -368,7 +368,7 @@ static int cond_read_av_list(struct policydb *p,
void *fp, struct selinux_ss_con
 	return 0;
 }
 
-static int expr_isvalid(struct policydb *p, struct selinux_ss_cond_expr
*expr)
+static int expr_isvalid(struct selinux_ss_policydb *p, struct
selinux_ss_cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
 		printk(KERN_ERR "SELinux: conditional expressions uses unknown
operator.\n");
@@ -382,7 +382,7 @@ static int expr_isvalid(struct policydb *p, struct
selinux_ss_cond_expr *expr)
 	return 1;
 }
 
-static int cond_read_node(struct policydb *p, struct
selinux_ss_cond_node *node, void *fp)
+static int cond_read_node(struct selinux_ss_policydb *p, struct
selinux_ss_cond_node *node, void *fp)
 {
 	__le32 buf[2];
 	u32 len, i;
@@ -437,7 +437,7 @@ err:
 	return -1;
 }
 
-int selinux_ss_cond_read_list(struct policydb *p, void *fp)
+int selinux_ss_cond_read_list(struct selinux_ss_policydb *p, void *fp)
 {
 	struct selinux_ss_cond_node *node, *last = NULL;
 	__le32 buf[1];
diff --git a/security/selinux/ss/conditional.h
b/security/selinux/ss/conditional.h
index e593277..cccee8a 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -59,19 +59,19 @@ struct selinux_ss_cond_node {
 	struct selinux_ss_cond_node *next;
 };
 
-int selinux_ss_cond_policydb_init(struct policydb *p);
-void selinux_ss_cond_policydb_destroy(struct policydb *p);
+int selinux_ss_cond_policydb_init(struct selinux_ss_policydb *p);
+void selinux_ss_cond_policydb_destroy(struct selinux_ss_policydb *p);
 
-int selinux_ss_cond_init_bool_indexes(struct policydb *p);
+int selinux_ss_cond_init_bool_indexes(struct selinux_ss_policydb *p);
 int selinux_ss_cond_destroy_bool(void *key, void *datum, void *p);
 
 int selinux_ss_cond_index_bool(void *key, void *datum, void *datap);
 
-int selinux_ss_cond_read_bool(struct policydb *p, struct
selinux_ss_hashtab *h, void *fp);
-int selinux_ss_cond_read_list(struct policydb *p, void *fp);
+int selinux_ss_cond_read_bool(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp);
+int selinux_ss_cond_read_list(struct selinux_ss_policydb *p, void *fp);
 
 void selinux_ss_cond_compute_av(struct selinux_ss_avtab *ctab, struct
selinux_ss_avtab_key *key, struct av_decision *avd);
 
-int selinux_ss_evaluate_cond_node(struct policydb *p, struct
selinux_ss_cond_node *node);
+int selinux_ss_evaluate_cond_node(struct selinux_ss_policydb *p, struct
selinux_ss_cond_node *node);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/context.h
b/security/selinux/ss/context.h
index 78a37bf..489865f 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -23,7 +23,7 @@
  * A security context consists of an authenticated user
  * identity, a role, a type and a MLS range.
  */
-struct context {
+struct selinux_ss_context {
 	u32 user;
 	u32 role;
 	u32 type;
@@ -32,12 +32,12 @@ struct context {
 	char *str;	/* string representation if context cannot be mapped. */
 };
 
-static inline void mls_context_init(struct context *c)
+static inline void mls_context_init(struct selinux_ss_context *c)
 {
 	memset(&c->range, 0, sizeof(c->range));
 }
 
-static inline int mls_context_cpy(struct context *dst, struct context
*src)
+static inline int mls_context_cpy(struct selinux_ss_context *dst,
struct selinux_ss_context *src)
 {
 	int rc;
 
@@ -60,7 +60,7 @@ out:
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of
'src'.
  */
-static inline int mls_context_cpy_low(struct context *dst, struct
context *src)
+static inline int mls_context_cpy_low(struct selinux_ss_context *dst,
struct selinux_ss_context *src)
 {
 	int rc;
 
@@ -80,7 +80,7 @@ out:
 	return rc;
 }
 
-static inline int mls_context_cmp(struct context *c1, struct context
*c2)
+static inline int mls_context_cmp(struct selinux_ss_context *c1, struct
selinux_ss_context *c2)
 {
 	if (!selinux_mls_enabled)
 		return 1;
@@ -91,7 +91,7 @@ static inline int mls_context_cmp(struct context *c1,
struct context *c2)
 		selinux_ss_ebitmap_cmp(&c1->range.level[1].cat,
&c2->range.level[1].cat));
 }
 
-static inline void mls_context_destroy(struct context *c)
+static inline void mls_context_destroy(struct selinux_ss_context *c)
 {
 	if (!selinux_mls_enabled)
 		return;
@@ -101,12 +101,12 @@ static inline void mls_context_destroy(struct
context *c)
 	mls_context_init(c);
 }
 
-static inline void context_init(struct context *c)
+static inline void context_init(struct selinux_ss_context *c)
 {
 	memset(c, 0, sizeof(*c));
 }
 
-static inline int context_cpy(struct context *dst, struct context *src)
+static inline int context_cpy(struct selinux_ss_context *dst, struct
selinux_ss_context *src)
 {
 	int rc;
 
@@ -130,7 +130,7 @@ static inline int context_cpy(struct context *dst,
struct context *src)
 	return 0;
 }
 
-static inline void context_destroy(struct context *c)
+static inline void context_destroy(struct selinux_ss_context *c)
 {
 	c->user = c->role = c->type = 0;
 	kfree(c->str);
@@ -139,7 +139,7 @@ static inline void context_destroy(struct context
*c)
 	mls_context_destroy(c);
 }
 
-static inline int context_cmp(struct context *c1, struct context *c2)
+static inline int context_cmp(struct selinux_ss_context *c1, struct
selinux_ss_context *c2)
 {
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 7f08105..e884269 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -32,7 +32,7 @@
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
-int mls_compute_context_len(struct context *context)
+int mls_compute_context_len(struct selinux_ss_context *context)
 {
 	int i, l, len, head, prev;
 	char *nm;
@@ -85,7 +85,7 @@ int mls_compute_context_len(struct context *context)
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-void mls_sid_to_context(struct context *context,
+void mls_sid_to_context(struct selinux_ss_context *context,
 			char **scontext)
 {
 	char *scontextp, *nm;
@@ -157,9 +157,9 @@ void mls_sid_to_context(struct context *context,
 	return;
 }
 
-int mls_level_isvalid(struct policydb *p, struct mls_level *l)
+int mls_level_isvalid(struct selinux_ss_policydb *p, struct mls_level
*l)
 {
-	struct level_datum *levdatum;
+	struct selinux_ss_level_datum *levdatum;
 	struct selinux_ss_ebitmap_node *node;
 	int i;
 
@@ -185,7 +185,7 @@ int mls_level_isvalid(struct policydb *p, struct
mls_level *l)
 	return 1;
 }
 
-int mls_range_isvalid(struct policydb *p, struct mls_range *r)
+int mls_range_isvalid(struct selinux_ss_policydb *p, struct mls_range
*r)
 {
 	return (mls_level_isvalid(p, &r->level[0]) &&
 		mls_level_isvalid(p, &r->level[1]) &&
@@ -196,9 +196,9 @@ int mls_range_isvalid(struct policydb *p, struct
mls_range *r)
  * Return 1 if the MLS fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int mls_context_isvalid(struct policydb *p, struct context *c)
+int mls_context_isvalid(struct selinux_ss_policydb *p, struct
selinux_ss_context *c)
 {
-	struct user_datum *usrdatum;
+	struct selinux_ss_user_datum *usrdatum;
 
 	if (!selinux_mls_enabled)
 		return 1;
@@ -239,18 +239,18 @@ int mls_context_isvalid(struct policydb *p, struct
context *c)
  * Policy read-lock must be held for sidtab lookup.
  *
  */
-int mls_context_to_sid(struct policydb *pol,
+int mls_context_to_sid(struct selinux_ss_policydb *pol,
 		       char oldc,
 		       char **scontext,
-		       struct context *context,
-		       struct sidtab *s,
+		       struct selinux_ss_context *context,
+		       struct selinux_ss_sidtab *s,
 		       u32 def_sid)
 {
 
 	char delim;
 	char *scontextp, *p, *rngptr;
-	struct level_datum *levdatum;
-	struct cat_datum *catdatum, *rngdatum;
+	struct selinux_ss_level_datum *levdatum;
+	struct selinux_ss_cat_datum *catdatum, *rngdatum;
 	int l, rc = -EINVAL;
 
 	if (!selinux_mls_enabled) {
@@ -264,12 +264,12 @@ int mls_context_to_sid(struct policydb *pol,
 	 * default if provided.
 	 */
 	if (!oldc) {
-		struct context *defcon;
+		struct selinux_ss_context *defcon;
 
 		if (def_sid == SECSID_NULL)
 			goto out;
 
-		defcon = sidtab_search(s, def_sid);
+		defcon = selinux_ss_sidtab_search(s, def_sid);
 		if (!defcon)
 			goto out;
 
@@ -382,7 +382,7 @@ out:
  * the string `str'.  This function will allocate temporary memory with
the
  * given constraints of gfp_mask.
  */
-int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
+int mls_from_string(char *str, struct selinux_ss_context *context,
gfp_t gfp_mask)
 {
 	char *tmpstr, *freestr;
 	int rc;
@@ -407,7 +407,7 @@ int mls_from_string(char *str, struct context
*context, gfp_t gfp_mask)
 /*
  * Copies the MLS range `range' into `context'.
  */
-static inline int mls_range_set(struct context *context,
+static inline int mls_range_set(struct selinux_ss_context *context,
 				struct mls_range *range)
 {
 	int l, rc = 0;
@@ -424,8 +424,8 @@ static inline int mls_range_set(struct context
*context,
 	return rc;
 }
 
-int mls_setup_user_range(struct context *fromcon, struct user_datum
*user,
-			 struct context *usercon)
+int mls_setup_user_range(struct selinux_ss_context *fromcon, struct
selinux_ss_user_datum *user,
+			 struct selinux_ss_context *usercon)
 {
 	if (selinux_mls_enabled) {
 		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
@@ -467,12 +467,12 @@ int mls_setup_user_range(struct context *fromcon,
struct user_datum *user,
  * structure `c' from the values specified in the
  * policy `oldp' to the values specified in the policy `newp'.
  */
-int mls_convert_context(struct policydb *oldp,
-			struct policydb *newp,
-			struct context *c)
+int mls_convert_context(struct selinux_ss_policydb *oldp,
+			struct selinux_ss_policydb *newp,
+			struct selinux_ss_context *c)
 {
-	struct level_datum *levdatum;
-	struct cat_datum *catdatum;
+	struct selinux_ss_level_datum *levdatum;
+	struct selinux_ss_cat_datum *catdatum;
 	struct selinux_ss_ebitmap bitmap;
 	struct selinux_ss_ebitmap_node *node;
 	int l, i;
@@ -507,13 +507,13 @@ int mls_convert_context(struct policydb *oldp,
 	return 0;
 }
 
-int mls_compute_sid(struct context *scontext,
-		    struct context *tcontext,
+int mls_compute_sid(struct selinux_ss_context *scontext,
+		    struct selinux_ss_context *tcontext,
 		    u16 tclass,
 		    u32 specified,
-		    struct context *newcontext)
+		    struct selinux_ss_context *newcontext)
 {
-	struct range_trans *rtr;
+	struct selinux_ss_range_trans *rtr;
 
 	if (!selinux_mls_enabled)
 		return 0;
@@ -558,7 +558,7 @@ int mls_compute_sid(struct context *scontext,
  * NetLabel MLS sensitivity level field.
  *
  */
-void mls_export_netlbl_lvl(struct context *context,
+void mls_export_netlbl_lvl(struct selinux_ss_context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!selinux_mls_enabled)
@@ -578,7 +578,7 @@ void mls_export_netlbl_lvl(struct context *context,
  * NetLabel MLS sensitivity level into the context.
  *
  */
-void mls_import_netlbl_lvl(struct context *context,
+void mls_import_netlbl_lvl(struct selinux_ss_context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!selinux_mls_enabled)
@@ -598,7 +598,7 @@ void mls_import_netlbl_lvl(struct context *context,
  * MLS category field.  Returns zero on success, negative values on
failure.
  *
  */
-int mls_export_netlbl_cat(struct context *context,
+int mls_export_netlbl_cat(struct selinux_ss_context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
@@ -626,7 +626,7 @@ int mls_export_netlbl_cat(struct context *context,
  * negative values on failure.
  *
  */
-int mls_import_netlbl_cat(struct context *context,
+int mls_import_netlbl_cat(struct selinux_ss_context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 1276715..4eeca61 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -24,60 +24,60 @@
 #include "context.h"
 #include "policydb.h"
 
-int mls_compute_context_len(struct context *context);
-void mls_sid_to_context(struct context *context, char **scontext);
-int mls_context_isvalid(struct policydb *p, struct context *c);
-int mls_range_isvalid(struct policydb *p, struct mls_range *r);
-int mls_level_isvalid(struct policydb *p, struct mls_level *l);
+int mls_compute_context_len(struct selinux_ss_context *context);
+void mls_sid_to_context(struct selinux_ss_context *context, char
**scontext);
+int mls_context_isvalid(struct selinux_ss_policydb *p, struct
selinux_ss_context *c);
+int mls_range_isvalid(struct selinux_ss_policydb *p, struct mls_range
*r);
+int mls_level_isvalid(struct selinux_ss_policydb *p, struct mls_level
*l);
 
-int mls_context_to_sid(struct policydb *p,
+int mls_context_to_sid(struct selinux_ss_policydb *p,
 		       char oldc,
 		       char **scontext,
-		       struct context *context,
-		       struct sidtab *s,
+		       struct selinux_ss_context *context,
+		       struct selinux_ss_sidtab *s,
 		       u32 def_sid);
 
-int mls_from_string(char *str, struct context *context, gfp_t
gfp_mask);
+int mls_from_string(char *str, struct selinux_ss_context *context,
gfp_t gfp_mask);
 
-int mls_convert_context(struct policydb *oldp,
-			struct policydb *newp,
-			struct context *context);
+int mls_convert_context(struct selinux_ss_policydb *oldp,
+			struct selinux_ss_policydb *newp,
+			struct selinux_ss_context *context);
 
-int mls_compute_sid(struct context *scontext,
-		    struct context *tcontext,
+int mls_compute_sid(struct selinux_ss_context *scontext,
+		    struct selinux_ss_context *tcontext,
 		    u16 tclass,
 		    u32 specified,
-		    struct context *newcontext);
+		    struct selinux_ss_context *newcontext);
 
-int mls_setup_user_range(struct context *fromcon, struct user_datum
*user,
-			 struct context *usercon);
+int mls_setup_user_range(struct selinux_ss_context *fromcon, struct
selinux_ss_user_datum *user,
+			 struct selinux_ss_context *usercon);
 
 #ifdef CONFIG_NETLABEL
-void mls_export_netlbl_lvl(struct context *context,
+void mls_export_netlbl_lvl(struct selinux_ss_context *context,
 			   struct netlbl_lsm_secattr *secattr);
-void mls_import_netlbl_lvl(struct context *context,
+void mls_import_netlbl_lvl(struct selinux_ss_context *context,
 			   struct netlbl_lsm_secattr *secattr);
-int mls_export_netlbl_cat(struct context *context,
+int mls_export_netlbl_cat(struct selinux_ss_context *context,
 			  struct netlbl_lsm_secattr *secattr);
-int mls_import_netlbl_cat(struct context *context,
+int mls_import_netlbl_cat(struct selinux_ss_context *context,
 			  struct netlbl_lsm_secattr *secattr);
 #else
-static inline void mls_export_netlbl_lvl(struct context *context,
+static inline void mls_export_netlbl_lvl(struct selinux_ss_context
*context,
 					 struct netlbl_lsm_secattr *secattr)
 {
 	return;
 }
-static inline void mls_import_netlbl_lvl(struct context *context,
+static inline void mls_import_netlbl_lvl(struct selinux_ss_context
*context,
 					 struct netlbl_lsm_secattr *secattr)
 {
 	return;
 }
-static inline int mls_export_netlbl_cat(struct context *context,
+static inline int mls_export_netlbl_cat(struct selinux_ss_context
*context,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOMEM;
 }
-static inline int mls_import_netlbl_cat(struct context *context,
+static inline int mls_import_netlbl_cat(struct selinux_ss_context
*context,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOMEM;
diff --git a/security/selinux/ss/policydb.c
b/security/selinux/ss/policydb.c
index 776635a..c415b47 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -65,14 +65,14 @@ static unsigned int symtab_sizes[SYM_NUM] = {
 	16,
 };
 
-struct policydb_compat_info {
+struct selinux_ss_policydb_compat_info {
 	int version;
 	int sym_num;
 	int ocon_num;
 };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
-static struct policydb_compat_info policydb_compat[] = {
+static struct selinux_ss_policydb_compat_info policydb_compat[] = {
 	{
 		.version	= POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM - 3,
@@ -125,10 +125,10 @@ static struct policydb_compat_info
policydb_compat[] = {
 	},
 };
 
-static struct policydb_compat_info *policydb_lookup_compat(int version)
+static struct selinux_ss_policydb_compat_info
*policydb_lookup_compat(int version)
 {
 	int i;
-	struct policydb_compat_info *info = NULL;
+	struct selinux_ss_policydb_compat_info *info = NULL;
 
 	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
 		if (policydb_compat[i].version == version) {
@@ -142,11 +142,11 @@ static struct policydb_compat_info
*policydb_lookup_compat(int version)
 /*
  * Initialize the role table.
  */
-static int roles_init(struct policydb *p)
+static int roles_init(struct selinux_ss_policydb *p)
 {
 	char *key = NULL;
 	int rc;
-	struct role_datum *role;
+	struct selinux_ss_role_datum *role;
 
 	role = kzalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
@@ -180,14 +180,14 @@ out_free_role:
 /*
  * Initialize a policy database structure.
  */
-static int policydb_init(struct policydb *p)
+static int policydb_init(struct selinux_ss_policydb *p)
 {
 	int i, rc;
 
 	memset(p, 0, sizeof(*p));
 
 	for (i = 0; i < SYM_NUM; i++) {
-		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
+		rc = selinux_ss_symtab_init(&p->symtab[i], symtab_sizes[i]);
 		if (rc)
 			goto out_free_symtab;
 	}
@@ -228,8 +228,8 @@ out_free_symtab:
 
 static int common_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct common_datum *comdatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_common_datum *comdatum;
 
 	comdatum = datum;
 	p = datap;
@@ -241,8 +241,8 @@ static int common_index(void *key, void *datum, void
*datap)
 
 static int class_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct class_datum *cladatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_class_datum *cladatum;
 
 	cladatum = datum;
 	p = datap;
@@ -255,8 +255,8 @@ static int class_index(void *key, void *datum, void
*datap)
 
 static int role_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct role_datum *role;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_role_datum *role;
 
 	role = datum;
 	p = datap;
@@ -271,8 +271,8 @@ static int role_index(void *key, void *datum, void
*datap)
 
 static int type_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct type_datum *typdatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_type_datum *typdatum;
 
 	typdatum = datum;
 	p = datap;
@@ -291,8 +291,8 @@ static int type_index(void *key, void *datum, void
*datap)
 
 static int user_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct user_datum *usrdatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_user_datum *usrdatum;
 
 	usrdatum = datum;
 	p = datap;
@@ -307,8 +307,8 @@ static int user_index(void *key, void *datum, void
*datap)
 
 static int sens_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct level_datum *levdatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_level_datum *levdatum;
 
 	levdatum = datum;
 	p = datap;
@@ -325,8 +325,8 @@ static int sens_index(void *key, void *datum, void
*datap)
 
 static int cat_index(void *key, void *datum, void *datap)
 {
-	struct policydb *p;
-	struct cat_datum *catdatum;
+	struct selinux_ss_policydb *p;
+	struct selinux_ss_cat_datum *catdatum;
 
 	catdatum = datum;
 	p = datap;
@@ -359,7 +359,7 @@ static int (*index_f[SYM_NUM]) (void *key, void
*datum, void *datap) =
  *
  * Caller must clean up upon failure.
  */
-static int policydb_index_classes(struct policydb *p)
+static int policydb_index_classes(struct selinux_ss_policydb *p)
 {
 	int rc;
 
@@ -394,7 +394,7 @@ out:
 }
 
 #ifdef DEBUG_HASHES
-static void symtab_hash_eval(struct symtab *s)
+static void symtab_hash_eval(struct selinux_ss_symtab *s)
 {
 	int i;
 
@@ -416,7 +416,7 @@ static void symtab_hash_eval(struct symtab *s)
  *
  * Caller must clean up on failure.
  */
-static int policydb_index_others(struct policydb *p)
+static int policydb_index_others(struct selinux_ss_policydb *p)
 {
 	int i, rc = 0;
 
@@ -495,7 +495,7 @@ static int perm_destroy(void *key, void *datum, void
*p)
 
 static int common_destroy(void *key, void *datum, void *p)
 {
-	struct common_datum *comdatum;
+	struct selinux_ss_common_datum *comdatum;
 
 	kfree(key);
 	comdatum = datum;
@@ -507,7 +507,7 @@ static int common_destroy(void *key, void *datum,
void *p)
 
 static int cls_destroy(void *key, void *datum, void *p)
 {
-	struct class_datum *cladatum;
+	struct selinux_ss_class_datum *cladatum;
 	struct selinux_ss_constraint_node *constraint, *ctemp;
 	struct selinux_ss_constraint_expr *e, *etmp;
 
@@ -550,7 +550,7 @@ static int cls_destroy(void *key, void *datum, void
*p)
 
 static int role_destroy(void *key, void *datum, void *p)
 {
-	struct role_datum *role;
+	struct selinux_ss_role_datum *role;
 
 	kfree(key);
 	role = datum;
@@ -569,7 +569,7 @@ static int type_destroy(void *key, void *datum, void
*p)
 
 static int user_destroy(void *key, void *datum, void *p)
 {
-	struct user_datum *usrdatum;
+	struct selinux_ss_user_datum *usrdatum;
 
 	kfree(key);
 	usrdatum = datum;
@@ -583,7 +583,7 @@ static int user_destroy(void *key, void *datum, void
*p)
 
 static int sens_destroy(void *key, void *datum, void *p)
 {
-	struct level_datum *levdatum;
+	struct selinux_ss_level_datum *levdatum;
 
 	kfree(key);
 	levdatum = datum;
@@ -612,7 +612,7 @@ static int (*destroy_f[SYM_NUM]) (void *key, void
*datum, void *datap) =
 	cat_destroy,
 };
 
-static void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct selinux_ss_ocontext *c, int i)
 {
 	context_destroy(&c->context[0]);
 	context_destroy(&c->context[1]);
@@ -625,14 +625,14 @@ static void ocontext_destroy(struct ocontext *c,
int i)
 /*
  * Free any memory allocated by a policy database structure.
  */
-void policydb_destroy(struct policydb *p)
+void policydb_destroy(struct selinux_ss_policydb *p)
 {
-	struct ocontext *c, *ctmp;
-	struct genfs *g, *gtmp;
+	struct selinux_ss_ocontext *c, *ctmp;
+	struct selinux_ss_genfs *g, *gtmp;
 	int i;
-	struct role_allow *ra, *lra = NULL;
-	struct role_trans *tr, *ltr = NULL;
-	struct range_trans *rt, *lrt = NULL;
+	struct selinux_ss_role_allow *ra, *lra = NULL;
+	struct selinux_ss_role_trans *tr, *ltr = NULL;
+	struct selinux_ss_range_trans *rt, *lrt = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -724,12 +724,12 @@ void policydb_destroy(struct policydb *p)
  * Load the initial SIDs specified in a policy database
  * structure into a SID table.
  */
-int policydb_load_isids(struct policydb *p, struct sidtab *s)
+int policydb_load_isids(struct selinux_ss_policydb *p, struct
selinux_ss_sidtab *s)
 {
-	struct ocontext *head, *c;
+	struct selinux_ss_ocontext *head, *c;
 	int rc;
 
-	rc = sidtab_init(s);
+	rc = selinux_ss_sidtab_init(s);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  out of memory on SID table init\n");
 		goto out;
@@ -743,7 +743,7 @@ int policydb_load_isids(struct policydb *p, struct
sidtab *s)
 			rc = -EINVAL;
 			goto out;
 		}
-		if (sidtab_insert(s, c->sid[0], &c->context[0])) {
+		if (selinux_ss_sidtab_insert(s, c->sid[0], &c->context[0])) {
 			printk(KERN_ERR "SELinux:  unable to load initial "
 			       "SID %s.\n", c->u.name);
 			rc = -EINVAL;
@@ -754,21 +754,21 @@ out:
 	return rc;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct selinux_ss_policydb *p, unsigned int
class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
 	return 1;
 }
 
-int policydb_role_isvalid(struct policydb *p, unsigned int role)
+int policydb_role_isvalid(struct selinux_ss_policydb *p, unsigned int
role)
 {
 	if (!role || role > p->p_roles.nprim)
 		return 0;
 	return 1;
 }
 
-int policydb_type_isvalid(struct policydb *p, unsigned int type)
+int policydb_type_isvalid(struct selinux_ss_policydb *p, unsigned int
type)
 {
 	if (!type || type > p->p_types.nprim)
 		return 0;
@@ -779,10 +779,10 @@ int policydb_type_isvalid(struct policydb *p,
unsigned int type)
  * Return 1 if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int policydb_context_isvalid(struct policydb *p, struct context *c)
+int policydb_context_isvalid(struct selinux_ss_policydb *p, struct
selinux_ss_context *c)
 {
-	struct role_datum *role;
-	struct user_datum *usrdatum;
+	struct selinux_ss_role_datum *role;
+	struct selinux_ss_user_datum *usrdatum;
 
 	if (!c->role || c->role > p->p_roles.nprim)
 		return 0;
@@ -886,8 +886,8 @@ bad_high:
  * Read and validate a security context structure
  * from a policydb binary representation file.
  */
-static int context_read_and_validate(struct context *c,
-				     struct policydb *p,
+static int context_read_and_validate(struct selinux_ss_context *c,
+				     struct selinux_ss_policydb *p,
 				     void *fp)
 {
 	__le32 buf[3];
@@ -925,10 +925,10 @@ out:
  * binary representation file.
  */
 
-static int perm_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int perm_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct perm_datum *perdatum;
+	struct selinux_ss_perm_datum *perdatum;
 	int rc;
 	__le32 buf[2];
 	u32 len;
@@ -966,10 +966,10 @@ bad:
 	goto out;
 }
 
-static int common_read(struct policydb *p, struct selinux_ss_hashtab
*h, void *fp)
+static int common_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct common_datum *comdatum;
+	struct selinux_ss_common_datum *comdatum;
 	__le32 buf[4];
 	u32 len, nel;
 	int i, rc;
@@ -987,7 +987,7 @@ static int common_read(struct policydb *p, struct
selinux_ss_hashtab *h, void *f
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 
-	rc = symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE);
+	rc = selinux_ss_symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE);
 	if (rc)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
@@ -1101,10 +1101,10 @@ static int read_cons_helper(struct
selinux_ss_constraint_node **nodep, int ncons
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int class_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct class_datum *cladatum;
+	struct selinux_ss_class_datum *cladatum;
 	__le32 buf[6];
 	u32 len, len2, ncons, nel;
 	int i, rc;
@@ -1123,7 +1123,7 @@ static int class_read(struct policydb *p, struct
selinux_ss_hashtab *h, void *fp
 	len2 = le32_to_cpu(buf[1]);
 	cladatum->value = le32_to_cpu(buf[2]);
 
-	rc = symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE);
+	rc = selinux_ss_symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE);
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
@@ -1194,10 +1194,10 @@ bad:
 	goto out;
 }
 
-static int role_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int role_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct role_datum *role;
+	struct selinux_ss_role_datum *role;
 	int rc, to_read = 2;
 	__le32 buf[3];
 	u32 len;
@@ -1259,10 +1259,10 @@ bad:
 	goto out;
 }
 
-static int type_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int type_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct type_datum *typdatum;
+	struct selinux_ss_type_datum *typdatum;
 	int rc, to_read = 3;
 	__le32 buf[4];
 	u32 len;
@@ -1346,10 +1346,10 @@ bad:
 	return -EINVAL;
 }
 
-static int user_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int user_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct user_datum *usrdatum;
+	struct selinux_ss_user_datum *usrdatum;
 	int rc, to_read = 2;
 	__le32 buf[3];
 	u32 len;
@@ -1405,10 +1405,10 @@ bad:
 	goto out;
 }
 
-static int sens_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int sens_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct level_datum *levdatum;
+	struct selinux_ss_level_datum *levdatum;
 	int rc;
 	__le32 buf[2];
 	u32 len;
@@ -1456,10 +1456,10 @@ bad:
 	goto out;
 }
 
-static int cat_read(struct policydb *p, struct selinux_ss_hashtab *h,
void *fp)
+static int cat_read(struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp)
 {
 	char *key = NULL;
-	struct cat_datum *catdatum;
+	struct selinux_ss_cat_datum *catdatum;
 	int rc;
 	__le32 buf[3];
 	u32 len;
@@ -1499,7 +1499,7 @@ bad:
 	goto out;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct
selinux_ss_hashtab *h, void *fp) =
+static int (*read_f[SYM_NUM]) (struct selinux_ss_policydb *p, struct
selinux_ss_hashtab *h, void *fp) =
 {
 	common_read,
 	class_read,
@@ -1513,8 +1513,8 @@ static int (*read_f[SYM_NUM]) (struct policydb *p,
struct selinux_ss_hashtab *h,
 
 static int user_bounds_sanity_check(void *key, void *datum, void
*datap)
 {
-	struct user_datum *upper, *user;
-	struct policydb *p = datap;
+	struct selinux_ss_user_datum *upper, *user;
+	struct selinux_ss_policydb *p = datap;
 	int depth = 0;
 
 	upper = user = datum;
@@ -1550,8 +1550,8 @@ static int user_bounds_sanity_check(void *key,
void *datum, void *datap)
 
 static int role_bounds_sanity_check(void *key, void *datum, void
*datap)
 {
-	struct role_datum *upper, *role;
-	struct policydb *p = datap;
+	struct selinux_ss_role_datum *upper, *role;
+	struct selinux_ss_policydb *p = datap;
 	int depth = 0;
 
 	upper = role = datum;
@@ -1587,8 +1587,8 @@ static int role_bounds_sanity_check(void *key,
void *datum, void *datap)
 
 static int type_bounds_sanity_check(void *key, void *datum, void
*datap)
 {
-	struct type_datum *upper, *type;
-	struct policydb *p = datap;
+	struct selinux_ss_type_datum *upper, *type;
+	struct selinux_ss_policydb *p = datap;
 	int depth = 0;
 
 	upper = type = datum;
@@ -1613,7 +1613,7 @@ static int type_bounds_sanity_check(void *key,
void *datum, void *datap)
 	return 0;
 }
 
-static int policydb_bounds_sanity_check(struct policydb *p)
+static int policydb_bounds_sanity_check(struct selinux_ss_policydb *p)
 {
 	int rc;
 
@@ -1644,19 +1644,19 @@ extern int ss_initialized;
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
-int policydb_read(struct policydb *p, void *fp)
+int policydb_read(struct selinux_ss_policydb *p, void *fp)
 {
-	struct role_allow *ra, *lra;
-	struct role_trans *tr, *ltr;
-	struct ocontext *l, *c, *newc;
-	struct genfs *genfs_p, *genfs, *newgenfs;
+	struct selinux_ss_role_allow *ra, *lra;
+	struct selinux_ss_role_trans *tr, *ltr;
+	struct selinux_ss_ocontext *l, *c, *newc;
+	struct selinux_ss_genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
 	__le32 buf[4];
 	u32 nodebuf[8];
 	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
-	struct policydb_compat_info *info;
-	struct range_trans *rt, *lrt;
+	struct selinux_ss_policydb_compat_info *info;
+	struct selinux_ss_range_trans *rt, *lrt;
 
 	config = 0;
 
diff --git a/security/selinux/ss/policydb.h
b/security/selinux/ss/policydb.h
index b1a3ffd..cb16f9f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -38,49 +38,49 @@
  */
 
 /* Permission attributes */
-struct perm_datum {
+struct selinux_ss_perm_datum {
 	u32 value;		/* permission bit + 1 */
 };
 
 /* Attributes of a common prefix for access vectors */
-struct common_datum {
+struct selinux_ss_common_datum {
 	u32 value;			/* internal common value */
-	struct symtab permissions;	/* common permissions */
+	struct selinux_ss_symtab permissions;	/* common permissions */
 };
 
 /* Class attributes */
-struct class_datum {
+struct selinux_ss_class_datum {
 	u32 value;			/* class value */
 	char *comkey;			/* common name */
-	struct common_datum *comdatum;	/* common datum */
-	struct symtab permissions;	/* class-specific permission symbol table
*/
+	struct selinux_ss_common_datum *comdatum;	/* common datum */
+	struct selinux_ss_symtab permissions;	/* class-specific permission
symbol table */
 	struct selinux_ss_constraint_node *constraints;	/* constraints on
class permissions */
 	struct selinux_ss_constraint_node *validatetrans;	/* special
transition rules */
 };
 
 /* Role attributes */
-struct role_datum {
+struct selinux_ss_role_datum {
 	u32 value;			/* internal role value */
 	u32 bounds;			/* boundary of role */
 	struct selinux_ss_ebitmap dominates;	/* set of roles dominated by this
role */
 	struct selinux_ss_ebitmap types;		/* set of authorized types for role
*/
 };
 
-struct role_trans {
+struct selinux_ss_role_trans {
 	u32 role;		/* current role */
 	u32 type;		/* program executable type */
 	u32 new_role;		/* new role */
-	struct role_trans *next;
+	struct selinux_ss_role_trans *next;
 };
 
-struct role_allow {
+struct selinux_ss_role_allow {
 	u32 role;		/* current role */
 	u32 new_role;		/* new role */
-	struct role_allow *next;
+	struct selinux_ss_role_allow *next;
 };
 
 /* Type attributes */
-struct type_datum {
+struct selinux_ss_type_datum {
 	u32 value;		/* internal type value */
 	u32 bounds;		/* boundary of type */
 	unsigned char primary;	/* primary name? */
@@ -88,7 +88,7 @@ struct type_datum {
 };
 
 /* User attributes */
-struct user_datum {
+struct selinux_ss_user_datum {
 	u32 value;			/* internal user value */
 	u32 bounds;			/* bounds of user */
 	struct selinux_ss_ebitmap roles;		/* set of authorized roles for user
*/
@@ -98,23 +98,23 @@ struct user_datum {
 
 
 /* Sensitivity attributes */
-struct level_datum {
+struct selinux_ss_level_datum {
 	struct mls_level *level;	/* sensitivity and associated categories */
 	unsigned char isalias;	/* is this sensitivity an alias for another? */
 };
 
 /* Category attributes */
-struct cat_datum {
+struct selinux_ss_cat_datum {
 	u32 value;		/* internal category bit + 1 */
 	unsigned char isalias;  /* is this category an alias for another? */
 };
 
-struct range_trans {
+struct selinux_ss_range_trans {
 	u32 source_type;
 	u32 target_type;
 	u32 target_class;
 	struct mls_range target_range;
-	struct range_trans *next;
+	struct selinux_ss_range_trans *next;
 };
 
 /* Boolean data type */
@@ -132,7 +132,7 @@ struct selinux_ss_cond_node;
  * relevant data for one such entry.  Entries of the same kind
  * (e.g. all initial SIDs) are linked together into a list.
  */
-struct ocontext {
+struct selinux_ss_ocontext {
 	union {
 		char *name;	/* name of initial SID, fs, netif, fstype, path */
 		struct {
@@ -153,15 +153,15 @@ struct ocontext {
 		u32 sclass;  /* security class for genfs */
 		u32 behavior;  /* labeling behavior for fs_use */
 	} v;
-	struct context context[2];	/* security context(s) */
+	struct selinux_ss_context context[2];	/* security context(s) */
 	u32 sid[2];	/* SID(s) */
-	struct ocontext *next;
+	struct selinux_ss_ocontext *next;
 };
 
-struct genfs {
+struct selinux_ss_genfs {
 	char *fstype;
-	struct ocontext *head;
-	struct genfs *next;
+	struct selinux_ss_ocontext *head;
+	struct selinux_ss_genfs *next;
 };
 
 /* symbol table array indices */
@@ -186,9 +186,9 @@ struct genfs {
 #define OCON_NUM   7
 
 /* The policy database */
-struct policydb {
+struct selinux_ss_policydb {
 	/* symbol tables */
-	struct symtab symtab[SYM_NUM];
+	struct selinux_ss_symtab symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
 #define p_classes symtab[SYM_CLASSES]
 #define p_roles symtab[SYM_ROLES]
@@ -210,16 +210,16 @@ struct policydb {
 #define p_cat_val_to_name sym_val_to_name[SYM_CATS]
 
 	/* class, role, and user attributes indexed by (value - 1) */
-	struct class_datum **class_val_to_struct;
-	struct role_datum **role_val_to_struct;
-	struct user_datum **user_val_to_struct;
-	struct type_datum **type_val_to_struct;
+	struct selinux_ss_class_datum **class_val_to_struct;
+	struct selinux_ss_role_datum **role_val_to_struct;
+	struct selinux_ss_user_datum **user_val_to_struct;
+	struct selinux_ss_type_datum **type_val_to_struct;
 
 	/* type enforcement access vectors and transitions */
 	struct selinux_ss_avtab te_avtab;
 
 	/* role transitions */
-	struct role_trans *role_tr;
+	struct selinux_ss_role_trans *role_tr;
 
 	/* bools indexed by (value - 1) */
 	struct selinux_ss_cond_bool_datum **bool_val_to_struct;
@@ -229,19 +229,19 @@ struct policydb {
 	struct selinux_ss_cond_node *cond_list;
 
 	/* role allows */
-	struct role_allow *role_allow;
+	struct selinux_ss_role_allow *role_allow;
 
 	/* security contexts of initial SIDs, unlabeled file systems,
 	   TCP or UDP port numbers, network interfaces and nodes */
-	struct ocontext *ocontexts[OCON_NUM];
+	struct selinux_ss_ocontext *ocontexts[OCON_NUM];
 
 	/* security contexts for files in filesystems that cannot support
 	   a persistent label mapping or use another
 	   fixed labeling behavior. */
-	struct genfs *genfs;
+	struct selinux_ss_genfs *genfs;
 
 	/* range transitions */
-	struct range_trans *range_tr;
+	struct selinux_ss_range_trans *range_tr;
 
 	/* type -> attribute reverse mapping */
 	struct selinux_ss_ebitmap *type_attr_map;
@@ -257,13 +257,13 @@ struct policydb {
 	u32 *undefined_perms;
 };
 
-extern void policydb_destroy(struct policydb *p);
-extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
-extern int policydb_context_isvalid(struct policydb *p, struct context
*c);
-extern int policydb_class_isvalid(struct policydb *p, unsigned int
class);
-extern int policydb_type_isvalid(struct policydb *p, unsigned int
type);
-extern int policydb_role_isvalid(struct policydb *p, unsigned int
role);
-extern int policydb_read(struct policydb *p, void *fp);
+extern void policydb_destroy(struct selinux_ss_policydb *p);
+extern int policydb_load_isids(struct selinux_ss_policydb *p, struct
selinux_ss_sidtab *s);
+extern int policydb_context_isvalid(struct selinux_ss_policydb *p,
struct selinux_ss_context *c);
+extern int policydb_class_isvalid(struct selinux_ss_policydb *p,
unsigned int class);
+extern int policydb_type_isvalid(struct selinux_ss_policydb *p,
unsigned int type);
+extern int policydb_role_isvalid(struct selinux_ss_policydb *p,
unsigned int role);
+extern int policydb_read(struct selinux_ss_policydb *p, void *fp);
 
 #define PERM_SYMTAB_SIZE 32
 
@@ -279,12 +279,12 @@ extern int policydb_read(struct policydb *p, void
*fp);
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
 
-struct policy_file {
+struct selinux_ss_policy_file {
 	char *data;
 	size_t len;
 };
 
-static inline int next_entry(void *buf, struct policy_file *fp, size_t
bytes)
+static inline int next_entry(void *buf, struct selinux_ss_policy_file
*fp, size_t bytes)
 {
 	if (bytes > fp->len)
 		return -EINVAL;
diff --git a/security/selinux/ss/services.c
b/security/selinux/ss/services.c
index 82b8c18..ec85a56 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -77,8 +77,8 @@ extern const struct selinux_class_perm
selinux_class_perm;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
-static struct sidtab sidtab;
-struct policydb policydb;
+static struct selinux_ss_sidtab sidtab;
+struct selinux_ss_policydb policydb;
 int ss_initialized;
 
 /*
@@ -90,11 +90,11 @@ int ss_initialized;
 static u32 latest_granting;
 
 /* Forward declaration. */
-static int context_struct_to_string(struct context *context, char
**scontext,
+static int context_struct_to_string(struct selinux_ss_context *context,
char **scontext,
 				    u32 *scontext_len);
 
-static int context_struct_compute_av(struct context *scontext,
-				     struct context *tcontext,
+static int context_struct_compute_av(struct selinux_ss_context
*scontext,
+				     struct selinux_ss_context *tcontext,
 				     u16 tclass,
 				     u32 requested,
 				     struct av_decision *avd);
@@ -109,14 +109,14 @@ static int context_struct_compute_av(struct
context *scontext,
  * of the process performing the transition.  All other callers of
  * constraint_expr_eval should pass in NULL for xcontext.
  */
-static int constraint_expr_eval(struct context *scontext,
-				struct context *tcontext,
-				struct context *xcontext,
+static int constraint_expr_eval(struct selinux_ss_context *scontext,
+				struct selinux_ss_context *tcontext,
+				struct selinux_ss_context *xcontext,
 				struct selinux_ss_constraint_expr *cexpr)
 {
 	u32 val1, val2;
-	struct context *c;
-	struct role_datum *r1, *r2;
+	struct selinux_ss_context *c;
+	struct selinux_ss_role_datum *r1, *r2;
 	struct mls_level *l1, *l2;
 	struct selinux_ss_constraint_expr *e;
 	int s[CEXPR_MAXDEPTH];
@@ -289,7 +289,7 @@ mls_ops:
  */
 static int dump_masked_av_helper(void *k, void *d, void *args)
 {
-	struct perm_datum *pdatum = d;
+	struct selinux_ss_perm_datum *pdatum = d;
 	char **permission_names = args;
 
 	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
@@ -299,14 +299,14 @@ static int dump_masked_av_helper(void *k, void *d,
void *args)
 	return 0;
 }
 
-static void security_dump_masked_av(struct context *scontext,
-				    struct context *tcontext,
+static void security_dump_masked_av(struct selinux_ss_context
*scontext,
+				    struct selinux_ss_context *tcontext,
 				    u16 tclass,
 				    u32 permissions,
 				    const char *reason)
 {
-	struct common_datum *common_dat;
-	struct class_datum *tclass_dat;
+	struct selinux_ss_common_datum *common_dat;
+	struct selinux_ss_class_datum *tclass_dat;
 	struct audit_buffer *ab;
 	char *tclass_name;
 	char *scontext_name = NULL;
@@ -376,18 +376,18 @@ out:
  * security_boundary_permission - drops violated permissions
  * on boundary constraint.
  */
-static void type_attribute_bounds_av(struct context *scontext,
-				     struct context *tcontext,
+static void type_attribute_bounds_av(struct selinux_ss_context
*scontext,
+				     struct selinux_ss_context *tcontext,
 				     u16 tclass,
 				     u32 requested,
 				     struct av_decision *avd)
 {
-	struct context lo_scontext;
-	struct context lo_tcontext;
+	struct selinux_ss_context lo_scontext;
+	struct selinux_ss_context lo_tcontext;
 	struct av_decision lo_avd;
-	struct type_datum *source
+	struct selinux_ss_type_datum *source
 		= policydb.type_val_to_struct[scontext->type - 1];
-	struct type_datum *target
+	struct selinux_ss_type_datum *target
 		= policydb.type_val_to_struct[tcontext->type - 1];
 	u32 masked = 0;
 
@@ -454,17 +454,17 @@ static void type_attribute_bounds_av(struct
context *scontext,
  * Compute access vectors based on a context structure pair for
  * the permissions in a particular class.
  */
-static int context_struct_compute_av(struct context *scontext,
-				     struct context *tcontext,
+static int context_struct_compute_av(struct selinux_ss_context
*scontext,
+				     struct selinux_ss_context *tcontext,
 				     u16 tclass,
 				     u32 requested,
 				     struct av_decision *avd)
 {
 	struct selinux_ss_constraint_node *constraint;
-	struct role_allow *ra;
+	struct selinux_ss_role_allow *ra;
 	struct selinux_ss_avtab_key avkey;
 	struct selinux_ss_avtab_node *node;
-	struct class_datum *tclass_datum;
+	struct selinux_ss_class_datum *tclass_datum;
 	struct selinux_ss_ebitmap *sattr, *tattr;
 	struct selinux_ss_ebitmap_node *snode, *tnode;
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
@@ -607,9 +607,9 @@ inval_class:
 	return 0;
 }
 
-static int security_validtrans_handle_fail(struct context *ocontext,
-					   struct context *ncontext,
-					   struct context *tcontext,
+static int security_validtrans_handle_fail(struct selinux_ss_context
*ocontext,
+					   struct selinux_ss_context *ncontext,
+					   struct selinux_ss_context *tcontext,
 					   u16 tclass)
 {
 	char *o = NULL, *n = NULL, *t = NULL;
@@ -638,10 +638,10 @@ out:
 int selinux_ss_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass)
 {
-	struct context *ocontext;
-	struct context *ncontext;
-	struct context *tcontext;
-	struct class_datum *tclass_datum;
+	struct selinux_ss_context *ocontext;
+	struct selinux_ss_context *ncontext;
+	struct selinux_ss_context *tcontext;
+	struct selinux_ss_class_datum *tclass_datum;
 	struct selinux_ss_constraint_node *constraint;
 	int rc = 0;
 
@@ -669,7 +669,7 @@ int selinux_ss_validate_transition(u32 oldsid, u32
newsid, u32 tasksid,
 	}
 	tclass_datum = policydb.class_val_to_struct[tclass - 1];
 
-	ocontext = sidtab_search(&sidtab, oldsid);
+	ocontext = selinux_ss_sidtab_search(&sidtab, oldsid);
 	if (!ocontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, oldsid);
@@ -677,7 +677,7 @@ int selinux_ss_validate_transition(u32 oldsid, u32
newsid, u32 tasksid,
 		goto out;
 	}
 
-	ncontext = sidtab_search(&sidtab, newsid);
+	ncontext = selinux_ss_sidtab_search(&sidtab, newsid);
 	if (!ncontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, newsid);
@@ -685,7 +685,7 @@ int selinux_ss_validate_transition(u32 oldsid, u32
newsid, u32 tasksid,
 		goto out;
 	}
 
-	tcontext = sidtab_search(&sidtab, tasksid);
+	tcontext = selinux_ss_sidtab_search(&sidtab, tasksid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, tasksid);
@@ -720,21 +720,21 @@ out:
  */
 int selinux_ss_bounded_transition(u32 old_sid, u32 new_sid)
 {
-	struct context *old_context, *new_context;
-	struct type_datum *type;
+	struct selinux_ss_context *old_context, *new_context;
+	struct selinux_ss_type_datum *type;
 	int index;
 	int rc = -EINVAL;
 
 	read_lock(&policy_rwlock);
 
-	old_context = sidtab_search(&sidtab, old_sid);
+	old_context = selinux_ss_sidtab_search(&sidtab, old_sid);
 	if (!old_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
 		       __func__, old_sid);
 		goto out;
 	}
 
-	new_context = sidtab_search(&sidtab, new_sid);
+	new_context = selinux_ss_sidtab_search(&sidtab, new_sid);
 	if (!new_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
 		       __func__, new_sid);
@@ -811,7 +811,7 @@ int selinux_ss_compute_av(u32 ssid,
 			u32 requested,
 			struct av_decision *avd)
 {
-	struct context *scontext = NULL, *tcontext = NULL;
+	struct selinux_ss_context *scontext = NULL, *tcontext = NULL;
 	int rc = 0;
 
 	if (!ss_initialized) {
@@ -824,14 +824,14 @@ int selinux_ss_compute_av(u32 ssid,
 
 	read_lock(&policy_rwlock);
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = selinux_ss_sidtab_search(&sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		rc = -EINVAL;
 		goto out;
 	}
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = selinux_ss_sidtab_search(&sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -857,7 +857,7 @@ out:
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-static int context_struct_to_string(struct context *context, char
**scontext, u32 *scontext_len)
+static int context_struct_to_string(struct selinux_ss_context *context,
char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
 
@@ -914,7 +914,7 @@ const char *selinux_ss_get_initial_sid_context(u32
sid)
 static int security_sid_to_context_core(u32 sid, char **scontext,
 					u32 *scontext_len, int force)
 {
-	struct context *context;
+	struct selinux_ss_context *context;
 	int rc = 0;
 
 	*scontext = NULL;
@@ -941,9 +941,9 @@ static int security_sid_to_context_core(u32 sid,
char **scontext,
 	}
 	read_lock(&policy_rwlock);
 	if (force)
-		context = sidtab_search_force(&sidtab, sid);
+		context = selinux_ss_sidtab_search_force(&sidtab, sid);
 	else
-		context = sidtab_search(&sidtab, sid);
+		context = selinux_ss_sidtab_search(&sidtab, sid);
 	if (!context) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
@@ -981,16 +981,16 @@ int selinux_ss_sid_to_context_force(u32 sid, char
**scontext, u32 *scontext_len)
 /*
  * Caveat:  Mutates scontext.
  */
-static int string_to_context_struct(struct policydb *pol,
-				    struct sidtab *sidtabp,
+static int string_to_context_struct(struct selinux_ss_policydb *pol,
+				    struct selinux_ss_sidtab *sidtabp,
 				    char *scontext,
 				    u32 scontext_len,
-				    struct context *ctx,
+				    struct selinux_ss_context *ctx,
 				    u32 def_sid)
 {
-	struct role_datum *role;
-	struct type_datum *typdatum;
-	struct user_datum *usrdatum;
+	struct selinux_ss_role_datum *role;
+	struct selinux_ss_type_datum *typdatum;
+	struct selinux_ss_user_datum *usrdatum;
 	char *scontextp, *p, oldc;
 	int rc = 0;
 
@@ -1071,7 +1071,7 @@ static int security_context_to_sid_core(const char
*scontext, u32 scontext_len,
 					int force)
 {
 	char *scontext2, *str = NULL;
-	struct context context;
+	struct selinux_ss_context context;
 	int rc = 0;
 
 	if (!ss_initialized) {
@@ -1114,7 +1114,7 @@ static int security_context_to_sid_core(const char
*scontext, u32 scontext_len,
 		str = NULL;
 	} else if (rc)
 		goto out;
-	rc = sidtab_context_to_sid(&sidtab, &context, sid);
+	rc = selinux_ss_sidtab_context_to_sid(&sidtab, &context, sid);
 	context_destroy(&context);
 out:
 	read_unlock(&policy_rwlock);
@@ -1173,10 +1173,10 @@ int selinux_ss_context_to_sid_force(const char
*scontext, u32 scontext_len,
 }
 
 static int compute_sid_handle_invalid_context(
-	struct context *scontext,
-	struct context *tcontext,
+	struct selinux_ss_context *scontext,
+	struct selinux_ss_context *tcontext,
 	u16 tclass,
-	struct context *newcontext)
+	struct selinux_ss_context *newcontext)
 {
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
@@ -1208,8 +1208,8 @@ static int security_compute_sid(u32 ssid,
 				u32 specified,
 				u32 *out_sid)
 {
-	struct context *scontext = NULL, *tcontext = NULL, newcontext;
-	struct role_trans *roletr = NULL;
+	struct selinux_ss_context *scontext = NULL, *tcontext = NULL,
newcontext;
+	struct selinux_ss_role_trans *roletr = NULL;
 	struct selinux_ss_avtab_key avkey;
 	struct selinux_ss_avtab_datum *avdatum;
 	struct selinux_ss_avtab_node *node;
@@ -1231,14 +1231,14 @@ static int security_compute_sid(u32 ssid,
 
 	read_lock(&policy_rwlock);
 
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = selinux_ss_sidtab_search(&sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = selinux_ss_sidtab_search(&sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
@@ -1332,7 +1332,7 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
+	rc = selinux_ss_sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&policy_rwlock);
 	context_destroy(&newcontext);
@@ -1407,16 +1407,16 @@ int selinux_ss_change_sid(u32 ssid,
  * Verify that each kernel class that is defined in the
  * policy is correct
  */
-static int validate_classes(struct policydb *p)
+static int validate_classes(struct selinux_ss_policydb *p)
 {
 	int i, j;
-	struct class_datum *cladatum;
-	struct perm_datum *perdatum;
+	struct selinux_ss_class_datum *cladatum;
+	struct selinux_ss_perm_datum *perdatum;
 	u32 nprim, tmp, common_pts_len, perm_val, pol_val;
 	u16 class_val;
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	const char *def_class, *def_perm, *pol_class;
-	struct symtab *perms;
+	struct selinux_ss_symtab *perms;
 	bool print_unknown_handle = 0;
 
 	if (p->allow_unknown) {
@@ -1542,15 +1542,15 @@ static int validate_classes(struct policydb *p)
 
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
-		     struct context *context,
+		     struct selinux_ss_context *context,
 		     void *arg)
 {
-	struct sidtab *s = arg;
+	struct selinux_ss_sidtab *s = arg;
 
-	return sidtab_insert(s, sid, context);
+	return selinux_ss_sidtab_insert(s, sid, context);
 }
 
-static inline int convert_context_handle_invalid_context(struct context
*context)
+static inline int convert_context_handle_invalid_context(struct
selinux_ss_context *context)
 {
 	int rc = 0;
 
@@ -1571,8 +1571,8 @@ static inline int
convert_context_handle_invalid_context(struct context *context
 }
 
 struct convert_context_args {
-	struct policydb *oldp;
-	struct policydb *newp;
+	struct selinux_ss_policydb *oldp;
+	struct selinux_ss_policydb *newp;
 };
 
 /*
@@ -1583,14 +1583,14 @@ struct convert_context_args {
  * context is valid under the new policy.
  */
 static int convert_context(u32 key,
-			   struct context *c,
+			   struct selinux_ss_context *c,
 			   void *p)
 {
 	struct convert_context_args *args;
-	struct context oldc;
-	struct role_datum *role;
-	struct type_datum *typdatum;
-	struct user_datum *usrdatum;
+	struct selinux_ss_context oldc;
+	struct selinux_ss_role_datum *role;
+	struct selinux_ss_type_datum *typdatum;
+	struct selinux_ss_user_datum *usrdatum;
 	char *s;
 	u32 len;
 	int rc;
@@ -1598,7 +1598,7 @@ static int convert_context(u32 key,
 	args = p;
 
 	if (c->str) {
-		struct context ctx;
+		struct selinux_ss_context ctx;
 		s = kstrdup(c->str, GFP_KERNEL);
 		if (!s) {
 			rc = -ENOMEM;
@@ -1694,7 +1694,7 @@ static void selinux_load_policycaps(void)
 }
 
 extern void selinux_complete_init(void);
-static int security_preserve_bools(struct policydb *p);
+static int security_preserve_bools(struct selinux_ss_policydb *p);
 
 /**
  * selinux_load_policy - Load a security policy configuration.
@@ -1708,12 +1708,12 @@ static int security_preserve_bools(struct
policydb *p);
  */
 int selinux_ss_load_policy(void *data, size_t len)
 {
-	struct policydb oldpolicydb, newpolicydb;
-	struct sidtab oldsidtab, newsidtab;
+	struct selinux_ss_policydb oldpolicydb, newpolicydb;
+	struct selinux_ss_sidtab oldsidtab, newsidtab;
 	struct convert_context_args args;
 	u32 seqno;
 	int rc = 0;
-	struct policy_file file = { data, len }, *fp = &file;
+	struct selinux_ss_policy_file file = { data, len }, *fp = &file;
 
 	if (!ss_initialized) {
 		selinux_ss_avtab_cache_init();
@@ -1730,7 +1730,7 @@ int selinux_ss_load_policy(void *data, size_t len)
 		if (validate_classes(&policydb)) {
 			printk(KERN_ERR
 			       "SELinux:  the definition of a class is incorrect\n");
-			sidtab_destroy(&sidtab);
+			selinux_ss_sidtab_destroy(&sidtab);
 			policydb_destroy(&policydb);
 			selinux_ss_avtab_cache_destroy();
 			return -EINVAL;
@@ -1748,13 +1748,13 @@ int selinux_ss_load_policy(void *data, size_t
len)
 	}
 
 #if 0
-	sidtab_hash_eval(&sidtab, "sids");
+	selinux_ss_sidtab_hash_eval(&sidtab, "sids");
 #endif
 
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
-	if (sidtab_init(&newsidtab)) {
+	if (selinux_ss_sidtab_init(&newsidtab)) {
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
 	}
@@ -1774,8 +1774,8 @@ int selinux_ss_load_policy(void *data, size_t len)
 	}
 
 	/* Clone the SID table. */
-	sidtab_shutdown(&sidtab);
-	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
+	selinux_ss_sidtab_shutdown(&sidtab);
+	if (selinux_ss_sidtab_map(&sidtab, clone_sid, &newsidtab)) {
 		rc = -ENOMEM;
 		goto err;
 	}
@@ -1786,18 +1786,18 @@ int selinux_ss_load_policy(void *data, size_t
len)
 	 */
 	args.oldp = &policydb;
 	args.newp = &newpolicydb;
-	rc = sidtab_map(&newsidtab, convert_context, &args);
+	rc = selinux_ss_sidtab_map(&newsidtab, convert_context, &args);
 	if (rc)
 		goto err;
 
 	/* Save the old policydb and SID table to free later. */
 	memcpy(&oldpolicydb, &policydb, sizeof policydb);
-	sidtab_set(&oldsidtab, &sidtab);
+	selinux_ss_sidtab_set(&oldsidtab, &sidtab);
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&policy_rwlock);
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
-	sidtab_set(&sidtab, &newsidtab);
+	selinux_ss_sidtab_set(&sidtab, &newsidtab);
 	selinux_load_policycaps();
 	seqno = ++latest_granting;
 	policydb_loaded_version = policydb.policyvers;
@@ -1805,7 +1805,7 @@ int selinux_ss_load_policy(void *data, size_t len)
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(&oldpolicydb);
-	sidtab_destroy(&oldsidtab);
+	selinux_ss_sidtab_destroy(&oldsidtab);
 
 	selinux_avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
@@ -1815,7 +1815,7 @@ int selinux_ss_load_policy(void *data, size_t len)
 	return 0;
 
 err:
-	sidtab_destroy(&newsidtab);
+	selinux_ss_sidtab_destroy(&newsidtab);
 	policydb_destroy(&newpolicydb);
 	return rc;
 
@@ -1829,7 +1829,7 @@ err:
  */
 int selinux_ss_port_sid(u8 protocol, u16 port, u32 *out_sid)
 {
-	struct ocontext *c;
+	struct selinux_ss_ocontext *c;
 	int rc = 0;
 
 	read_lock(&policy_rwlock);
@@ -1845,7 +1845,7 @@ int selinux_ss_port_sid(u8 protocol, u16 port, u32
*out_sid)
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -1869,7 +1869,7 @@ out:
 int selinux_ss_netif_sid(char *name, u32 *if_sid)
 {
 	int rc = 0;
-	struct ocontext *c;
+	struct selinux_ss_ocontext *c;
 
 	read_lock(&policy_rwlock);
 
@@ -1882,12 +1882,12 @@ int selinux_ss_netif_sid(char *name, u32
*if_sid)
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 						  &c->context[0],
 						  &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 						   &c->context[1],
 						   &c->sid[1]);
 			if (rc)
@@ -1928,7 +1928,7 @@ int selinux_ss_node_sid(u16 domain,
 		      u32 *out_sid)
 {
 	int rc = 0;
-	struct ocontext *c;
+	struct selinux_ss_ocontext *c;
 
 	read_lock(&policy_rwlock);
 
@@ -1973,7 +1973,7 @@ int selinux_ss_node_sid(u16 domain,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2010,11 +2010,11 @@ int selinux_ss_get_user_sids(u32 fromsid,
 			   u32 **sids,
 			   u32 *nel)
 {
-	struct context *fromcon, usercon;
+	struct selinux_ss_context *fromcon, usercon;
 	u32 *mysids = NULL, *mysids2, sid;
 	u32 mynel = 0, maxnel = SIDS_NEL;
-	struct user_datum *user;
-	struct role_datum *role;
+	struct selinux_ss_user_datum *user;
+	struct selinux_ss_role_datum *role;
 	struct selinux_ss_ebitmap_node *rnode, *tnode;
 	int rc = 0, i, j;
 
@@ -2028,7 +2028,7 @@ int selinux_ss_get_user_sids(u32 fromsid,
 
 	context_init(&usercon);
 
-	fromcon = sidtab_search(&sidtab, fromsid);
+	fromcon = selinux_ss_sidtab_search(&sidtab, fromsid);
 	if (!fromcon) {
 		rc = -EINVAL;
 		goto out_unlock;
@@ -2056,7 +2056,7 @@ int selinux_ss_get_user_sids(u32 fromsid,
 			if (mls_setup_user_range(fromcon, user, &usercon))
 				continue;
 
-			rc = sidtab_context_to_sid(&sidtab, &usercon, &sid);
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab, &usercon, &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2123,8 +2123,8 @@ int selinux_ss_genfs_sid(const char *fstype,
 		       u32 *sid)
 {
 	int len;
-	struct genfs *genfs;
-	struct ocontext *c;
+	struct selinux_ss_genfs *genfs;
+	struct selinux_ss_ocontext *c;
 	int rc = 0, cmp = 0;
 
 	while (path[0] == '/' && path[1] == '/')
@@ -2158,7 +2158,7 @@ int selinux_ss_genfs_sid(const char *fstype,
 	}
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(&sidtab,
+		rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 					   &c->context[0],
 					   &c->sid[0]);
 		if (rc)
@@ -2183,7 +2183,7 @@ int selinux_ss_fs_use(
 	u32 *sid)
 {
 	int rc = 0;
-	struct ocontext *c;
+	struct selinux_ss_ocontext *c;
 
 	read_lock(&policy_rwlock);
 
@@ -2197,7 +2197,7 @@ int selinux_ss_fs_use(
 	if (c) {
 		*behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = selinux_ss_sidtab_context_to_sid(&sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2333,7 +2333,7 @@ out:
 	return rc;
 }
 
-static int security_preserve_bools(struct policydb *p)
+static int security_preserve_bools(struct selinux_ss_policydb *p)
 {
 	int rc, nbools = 0, *bvalues = NULL, i;
 	char **bnames = NULL;
@@ -2370,9 +2370,9 @@ out:
  */
 int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 {
-	struct context *context1;
-	struct context *context2;
-	struct context newcon;
+	struct selinux_ss_context *context1;
+	struct selinux_ss_context *context2;
+	struct selinux_ss_context newcon;
 	char *s;
 	u32 len;
 	int rc = 0;
@@ -2385,7 +2385,7 @@ int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid,
u32 *new_sid)
 	context_init(&newcon);
 
 	read_lock(&policy_rwlock);
-	context1 = sidtab_search(&sidtab, sid);
+	context1 = selinux_ss_sidtab_search(&sidtab, sid);
 	if (!context1) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
@@ -2393,7 +2393,7 @@ int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid,
u32 *new_sid)
 		goto out_unlock;
 	}
 
-	context2 = sidtab_search(&sidtab, mls_sid);
+	context2 = selinux_ss_sidtab_search(&sidtab, mls_sid);
 	if (!context2) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, mls_sid);
@@ -2415,7 +2415,7 @@ int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid,
u32 *new_sid)
 			goto bad;
 	}
 
-	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
+	rc = selinux_ss_sidtab_context_to_sid(&sidtab, &newcon, new_sid);
 	goto out_unlock;
 
 bad:
@@ -2457,8 +2457,8 @@ int selinux_ss_net_peersid_resolve(u32 nlbl_sid,
u32 nlbl_type,
 				 u32 *peer_sid)
 {
 	int rc;
-	struct context *nlbl_ctx;
-	struct context *xfrm_ctx;
+	struct selinux_ss_context *nlbl_ctx;
+	struct selinux_ss_context *xfrm_ctx;
 
 	/* handle the common (which also happens to be the set of easy) cases
 	 * right away, these two if statements catch everything involving a
@@ -2485,14 +2485,14 @@ int selinux_ss_net_peersid_resolve(u32 nlbl_sid,
u32 nlbl_type,
 
 	read_lock(&policy_rwlock);
 
-	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
+	nlbl_ctx = selinux_ss_sidtab_search(&sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, nlbl_sid);
 		rc = -EINVAL;
 		goto out_slowpath;
 	}
-	xfrm_ctx = sidtab_search(&sidtab, xfrm_sid);
+	xfrm_ctx = selinux_ss_sidtab_search(&sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, xfrm_sid);
@@ -2517,7 +2517,7 @@ out_slowpath:
 
 static int get_classes_callback(void *k, void *d, void *args)
 {
-	struct class_datum *datum = d;
+	struct selinux_ss_class_datum *datum = d;
 	char *name = k, **classes = args;
 	int value = datum->value - 1;
 
@@ -2555,7 +2555,7 @@ out:
 
 static int get_permissions_callback(void *k, void *d, void *args)
 {
-	struct perm_datum *datum = d;
+	struct selinux_ss_perm_datum *datum = d;
 	char *name = k, **perms = args;
 	int value = datum->value - 1;
 
@@ -2569,7 +2569,7 @@ static int get_permissions_callback(void *k, void
*d, void *args)
 int selinux_ss_get_permissions(char *class, char ***perms, int *nperms)
 {
 	int rc = -ENOMEM, i;
-	struct class_datum *match;
+	struct selinux_ss_class_datum *match;
 
 	read_lock(&policy_rwlock);
 
@@ -2643,7 +2643,7 @@ int selinux_ss_policycap_supported(unsigned int
req_cap)
 
 struct selinux_audit_rule {
 	u32 au_seqno;
-	struct context au_ctxt;
+	struct selinux_ss_context au_ctxt;
 };
 
 void selinux_audit_rule_free(void *vrule)
@@ -2659,9 +2659,9 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void
**vrule)
 {
 	struct selinux_audit_rule *tmprule;
-	struct role_datum *roledatum;
-	struct type_datum *typedatum;
-	struct user_datum *userdatum;
+	struct selinux_ss_role_datum *roledatum;
+	struct selinux_ss_type_datum *typedatum;
+	struct selinux_ss_user_datum *userdatum;
 	struct selinux_audit_rule **rule = (struct selinux_audit_rule
**)vrule;
 	int rc = 0;
 
@@ -2777,7 +2777,7 @@ int selinux_audit_rule_known(struct audit_krule
*rule)
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 			     struct audit_context *actx)
 {
-	struct context *ctxt;
+	struct selinux_ss_context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
 	int match = 0;
@@ -2797,7 +2797,7 @@ int selinux_audit_rule_match(u32 sid, u32 field,
u32 op, void *vrule,
 		goto out;
 	}
 
-	ctxt = sidtab_search(&sidtab, sid);
+	ctxt = selinux_ss_sidtab_search(&sidtab, sid);
 	if (!ctxt) {
 		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 			  "selinux_audit_rule_match: unrecognized SID %d\n",
@@ -2962,8 +2962,8 @@ int selinux_ss_netlbl_secattr_to_sid(struct
netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
 	int rc = -EIDRM;
-	struct context *ctx;
-	struct context ctx_new;
+	struct selinux_ss_context *ctx;
+	struct selinux_ss_context ctx_new;
 
 	if (!ss_initialized) {
 		*sid = SECSID_NULL;
@@ -2979,7 +2979,7 @@ int selinux_ss_netlbl_secattr_to_sid(struct
netlbl_lsm_secattr *secattr,
 		*sid = secattr->attr.secid;
 		rc = 0;
 	} else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
-		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
+		ctx = selinux_ss_sidtab_search(&sidtab, SECINITSID_NETMSG);
 		if (ctx == NULL)
 			goto netlbl_secattr_to_sid_return;
 
@@ -2999,7 +2999,7 @@ int selinux_ss_netlbl_secattr_to_sid(struct
netlbl_lsm_secattr *secattr,
 		if (mls_context_isvalid(&policydb, &ctx_new) != 1)
 			goto netlbl_secattr_to_sid_return_cleanup;
 
-		rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
+		rc = selinux_ss_sidtab_context_to_sid(&sidtab, &ctx_new, sid);
 		if (rc != 0)
 			goto netlbl_secattr_to_sid_return_cleanup;
 
@@ -3032,13 +3032,13 @@ netlbl_secattr_to_sid_return_cleanup:
 int selinux_ss_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr
*secattr)
 {
 	int rc;
-	struct context *ctx;
+	struct selinux_ss_context *ctx;
 
 	if (!ss_initialized)
 		return 0;
 
 	read_lock(&policy_rwlock);
-	ctx = sidtab_search(&sidtab, sid);
+	ctx = selinux_ss_sidtab_search(&sidtab, sid);
 	if (ctx == NULL) {
 		rc = -ENOENT;
 		goto netlbl_sid_to_secattr_failure;
diff --git a/security/selinux/ss/services.h
b/security/selinux/ss/services.h
index e8d907e..9d42e9d 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -9,7 +9,7 @@
 #include "policydb.h"
 #include "sidtab.h"
 
-extern struct policydb policydb;
+extern struct selinux_ss_policydb policydb;
 
 #endif	/* _SS_SERVICES_H_ */
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e817989..294ede4 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -14,7 +14,7 @@
 #define SIDTAB_HASH(sid) \
 (sid & SIDTAB_HASH_MASK)
 
-int sidtab_init(struct sidtab *s)
+int selinux_ss_sidtab_init(struct selinux_ss_sidtab *s)
 {
 	int i;
 
@@ -30,10 +30,10 @@ int sidtab_init(struct sidtab *s)
 	return 0;
 }
 
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
+int selinux_ss_sidtab_insert(struct selinux_ss_sidtab *s, u32 sid,
struct selinux_ss_context *context)
 {
 	int hvalue, rc = 0;
-	struct sidtab_node *prev, *cur, *newnode;
+	struct selinux_ss_sidtab_node *prev, *cur, *newnode;
 
 	if (!s) {
 		rc = -ENOMEM;
@@ -82,10 +82,10 @@ out:
 	return rc;
 }
 
-static struct context *sidtab_search_core(struct sidtab *s, u32 sid,
int force)
+static struct selinux_ss_context *selinux_ss_sidtab_search_core(struct
selinux_ss_sidtab *s, u32 sid, int force)
 {
 	int hvalue;
-	struct sidtab_node *cur;
+	struct selinux_ss_sidtab_node *cur;
 
 	if (!s)
 		return NULL;
@@ -112,24 +112,24 @@ static struct context *sidtab_search_core(struct
sidtab *s, u32 sid, int force)
 	return &cur->context;
 }
 
-struct context *sidtab_search(struct sidtab *s, u32 sid)
+struct selinux_ss_context *selinux_ss_sidtab_search(struct
selinux_ss_sidtab *s, u32 sid)
 {
-	return sidtab_search_core(s, sid, 0);
+	return selinux_ss_sidtab_search_core(s, sid, 0);
 }
 
-struct context *sidtab_search_force(struct sidtab *s, u32 sid)
+struct selinux_ss_context *selinux_ss_sidtab_search_force(struct
selinux_ss_sidtab *s, u32 sid)
 {
-	return sidtab_search_core(s, sid, 1);
+	return selinux_ss_sidtab_search_core(s, sid, 1);
 }
 
-int sidtab_map(struct sidtab *s,
+int selinux_ss_sidtab_map(struct selinux_ss_sidtab *s,
 	       int (*apply) (u32 sid,
-			     struct context *context,
+			     struct selinux_ss_context *context,
 			     void *args),
 	       void *args)
 {
 	int i, rc = 0;
-	struct sidtab_node *cur;
+	struct selinux_ss_sidtab_node *cur;
 
 	if (!s)
 		goto out;
@@ -147,11 +147,11 @@ out:
 	return rc;
 }
 
-static inline u32 sidtab_search_context(struct sidtab *s,
-						  struct context *context)
+static inline u32 selinux_ss_sidtab_search_context(struct
selinux_ss_sidtab *s,
+						  struct selinux_ss_context *context)
 {
 	int i;
-	struct sidtab_node *cur;
+	struct selinux_ss_sidtab_node *cur;
 
 	for (i = 0; i < SIDTAB_SIZE; i++) {
 		cur = s->htable[i];
@@ -164,8 +164,8 @@ static inline u32 sidtab_search_context(struct
sidtab *s,
 	return 0;
 }
 
-int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
+int selinux_ss_sidtab_context_to_sid(struct selinux_ss_sidtab *s,
+			  struct selinux_ss_context *context,
 			  u32 *out_sid)
 {
 	u32 sid;
@@ -174,11 +174,11 @@ int sidtab_context_to_sid(struct sidtab *s,
 
 	*out_sid = SECSID_NULL;
 
-	sid = sidtab_search_context(s, context);
+	sid = selinux_ss_sidtab_search_context(s, context);
 	if (!sid) {
 		spin_lock_irqsave(&s->lock, flags);
 		/* Rescan now that we hold the lock. */
-		sid = sidtab_search_context(s, context);
+		sid = selinux_ss_sidtab_search_context(s, context);
 		if (sid)
 			goto unlock_out;
 		/* No SID exists for the context.  Allocate a new one. */
@@ -191,7 +191,7 @@ int sidtab_context_to_sid(struct sidtab *s,
 			printk(KERN_INFO
 		       "SELinux:  Context %s is not valid (left unmapped).\n",
 			       context->str);
-		ret = sidtab_insert(s, sid, context);
+		ret = selinux_ss_sidtab_insert(s, sid, context);
 		if (ret)
 			s->next_sid--;
 unlock_out:
@@ -205,10 +205,10 @@ unlock_out:
 	return 0;
 }
 
-void sidtab_hash_eval(struct sidtab *h, char *tag)
+void selinux_ss_sidtab_hash_eval(struct selinux_ss_sidtab *h, char
*tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
-	struct sidtab_node *cur;
+	struct selinux_ss_sidtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
@@ -232,10 +232,10 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
 	       max_chain_len);
 }
 
-void sidtab_destroy(struct sidtab *s)
+void selinux_ss_sidtab_destroy(struct selinux_ss_sidtab *s)
 {
 	int i;
-	struct sidtab_node *cur, *temp;
+	struct selinux_ss_sidtab_node *cur, *temp;
 
 	if (!s)
 		return;
@@ -256,7 +256,7 @@ void sidtab_destroy(struct sidtab *s)
 	s->next_sid = 1;
 }
 
-void sidtab_set(struct sidtab *dst, struct sidtab *src)
+void selinux_ss_sidtab_set(struct selinux_ss_sidtab *dst, struct
selinux_ss_sidtab *src)
 {
 	unsigned long flags;
 
@@ -268,7 +268,7 @@ void sidtab_set(struct sidtab *dst, struct sidtab
*src)
 	spin_unlock_irqrestore(&src->lock, flags);
 }
 
-void sidtab_shutdown(struct sidtab *s)
+void selinux_ss_sidtab_shutdown(struct selinux_ss_sidtab *s)
 {
 	unsigned long flags;
 
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 64ea5b1..a48ab7f 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -9,10 +9,10 @@
 
 #include "context.h"
 
-struct sidtab_node {
+struct selinux_ss_sidtab_node {
 	u32 sid;		/* security identifier */
-	struct context context;	/* security context structure */
-	struct sidtab_node *next;
+	struct selinux_ss_context context;	/* security context structure */
+	struct selinux_ss_sidtab_node *next;
 };
 
 #define SIDTAB_HASH_BITS 7
@@ -21,33 +21,33 @@ struct sidtab_node {
 
 #define SIDTAB_SIZE SIDTAB_HASH_BUCKETS
 
-struct sidtab {
-	struct sidtab_node **htable;
+struct selinux_ss_sidtab {
+	struct selinux_ss_sidtab_node **htable;
 	unsigned int nel;	/* number of elements */
 	unsigned int next_sid;	/* next SID to allocate */
 	unsigned char shutdown;
 	spinlock_t lock;
 };
 
-int sidtab_init(struct sidtab *s);
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
-struct context *sidtab_search(struct sidtab *s, u32 sid);
-struct context *sidtab_search_force(struct sidtab *s, u32 sid);
+int selinux_ss_sidtab_init(struct selinux_ss_sidtab *s);
+int selinux_ss_sidtab_insert(struct selinux_ss_sidtab *s, u32 sid,
struct selinux_ss_context *context);
+struct selinux_ss_context *selinux_ss_sidtab_search(struct
selinux_ss_sidtab *s, u32 sid);
+struct selinux_ss_context *selinux_ss_sidtab_search_force(struct
selinux_ss_sidtab *s, u32 sid);
 
-int sidtab_map(struct sidtab *s,
+int selinux_ss_sidtab_map(struct selinux_ss_sidtab *s,
 	       int (*apply) (u32 sid,
-			     struct context *context,
+			     struct selinux_ss_context *context,
 			     void *args),
 	       void *args);
 
-int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
+int selinux_ss_sidtab_context_to_sid(struct selinux_ss_sidtab *s,
+			  struct selinux_ss_context *context,
 			  u32 *sid);
 
-void sidtab_hash_eval(struct sidtab *h, char *tag);
-void sidtab_destroy(struct sidtab *s);
-void sidtab_set(struct sidtab *dst, struct sidtab *src);
-void sidtab_shutdown(struct sidtab *s);
+void selinux_ss_sidtab_hash_eval(struct selinux_ss_sidtab *h, char
*tag);
+void selinux_ss_sidtab_destroy(struct selinux_ss_sidtab *s);
+void selinux_ss_sidtab_set(struct selinux_ss_sidtab *dst, struct
selinux_ss_sidtab *src);
+void selinux_ss_sidtab_shutdown(struct selinux_ss_sidtab *s);
 
 #endif	/* _SS_SIDTAB_H_ */
 
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 7ef607d..4a8a122 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -33,7 +33,7 @@ static int symcmp(struct selinux_ss_hashtab *h, const
void *key1, const void *ke
 }
 
 
-int symtab_init(struct symtab *s, unsigned int size)
+int selinux_ss_symtab_init(struct selinux_ss_symtab *s, unsigned int
size)
 {
 	s->table = selinux_ss_hashtab_create(symhash, symcmp, size);
 	if (!s->table)
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index 4166ae4..80aa9e6 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -11,12 +11,12 @@
 
 #include "hashtab.h"
 
-struct symtab {
+struct selinux_ss_symtab {
 	struct selinux_ss_hashtab *table;	/* hash table (keyed on a string) */
 	u32 nprim;		/* number of primary names in table */
 };
 
-int symtab_init(struct symtab *s, unsigned int size);
+int selinux_ss_symtab_init(struct selinux_ss_symtab *s, unsigned int
size);
 
 #endif	/* _SS_SYMTAB_H_ */
 
-- 
1.6.2.5




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
