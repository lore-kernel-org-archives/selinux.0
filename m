Subject: [PATCH 4/4 -v2] Namespacing of security/selinux
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Content-Type: text/plain
Date: Mon, 06 Jul 2009 14:58:42 -0400
Message-Id: <1246906722.2460.15.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Final namespacing patch, including namespacing of functions
prefixed with mls_.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
 security/selinux/ss/avtab.c     |    2 +-
 security/selinux/ss/context.h   |   20 ++++----
 security/selinux/ss/ebitmap.c   |   20 ++++----
 security/selinux/ss/ebitmap.h   |   28 +++++-----
 security/selinux/ss/mls.c       |  102 +++++++++++++++++++-------------------
 security/selinux/ss/mls.h       |   36 +++++++-------
 security/selinux/ss/mls_types.h |   24 +++++-----
 security/selinux/ss/policydb.c  |   30 ++++++------
 security/selinux/ss/policydb.h  |    8 ++--
 security/selinux/ss/services.c  |   88 +++++++++++++++++-----------------
 10 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 9992040..063424a 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -125,7 +125,7 @@ selinux_avtab_insert_nonunique(struct selinux_avtab *h, struct selinux_avtab_key
 	return selinux_avtab_insert_node(h, hvalue, prev, cur, key, datum);
 }
 
-struct selinux_avtab_datum *avtab_search(struct selinux_avtab *h, struct selinux_avtab_key *key)
+struct selinux_avtab_datum *selinux_avtab_search(struct selinux_avtab *h, struct selinux_avtab_key *key)
 {
 	int hvalue;
 	struct selinux_avtab_node *cur;
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index df94e68..756da23 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -28,16 +28,16 @@ struct selinux_context {
 	u32 role;
 	u32 type;
 	u32 len;        /* length of string in bytes */
-	struct mls_range range;
+	struct selinux_mls_range range;
 	char *str;	/* string representation if context cannot be mapped. */
 };
 
-static inline void mls_context_init(struct selinux_context *c)
+static inline void selinux_mls_context_init(struct selinux_context *c)
 {
 	memset(&c->range, 0, sizeof(c->range));
 }
 
-static inline int mls_context_cpy(struct selinux_context *dst, struct selinux_context *src)
+static inline int selinux_mls_context_cpy(struct selinux_context *dst, struct selinux_context *src)
 {
 	int rc;
 
@@ -60,7 +60,7 @@ out:
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
  */
-static inline int mls_context_cpy_low(struct selinux_context *dst, struct selinux_context *src)
+static inline int selinux_mls_context_cpy_low(struct selinux_context *dst, struct selinux_context *src)
 {
 	int rc;
 
@@ -80,7 +80,7 @@ out:
 	return rc;
 }
 
-static inline int mls_context_cmp(struct selinux_context *c1, struct selinux_context *c2)
+static inline int selinux_mls_context_cmp(struct selinux_context *c1, struct selinux_context *c2)
 {
 	if (!selinux_mls_enabled)
 		return 1;
@@ -91,14 +91,14 @@ static inline int mls_context_cmp(struct selinux_context *c1, struct selinux_con
 		selinux_ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
 }
 
-static inline void mls_context_destroy(struct selinux_context *c)
+static inline void selinux_mls_context_destroy(struct selinux_context *c)
 {
 	if (!selinux_mls_enabled)
 		return;
 
 	selinux_ebitmap_destroy(&c->range.level[0].cat);
 	selinux_ebitmap_destroy(&c->range.level[1].cat);
-	mls_context_init(c);
+	selinux_mls_context_init(c);
 }
 
 static inline void context_init(struct selinux_context *c)
@@ -122,7 +122,7 @@ static inline int context_cpy(struct selinux_context *dst, struct selinux_contex
 		dst->str = NULL;
 		dst->len = 0;
 	}
-	rc = mls_context_cpy(dst, src);
+	rc = selinux_mls_context_cpy(dst, src);
 	if (rc) {
 		kfree(dst->str);
 		return rc;
@@ -136,7 +136,7 @@ static inline void context_destroy(struct selinux_context *c)
 	kfree(c->str);
 	c->str = NULL;
 	c->len = 0;
-	mls_context_destroy(c);
+	selinux_mls_context_destroy(c);
 }
 
 static inline int context_cmp(struct selinux_context *c1, struct selinux_context *c2)
@@ -148,7 +148,7 @@ static inline int context_cmp(struct selinux_context *c1, struct selinux_context
 	return ((c1->user == c2->user) &&
 		(c1->role == c2->role) &&
 		(c1->type == c2->type) &&
-		mls_context_cmp(c1, c2));
+		selinux_mls_context_cmp(c1, c2));
 }
 
 #endif	/* _SS_CONTEXT_H_ */
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 40ba1ab..65fb78b 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -48,7 +48,7 @@ int selinux_ebitmap_cpy(struct selinux_ebitmap *dst, struct selinux_ebitmap *src
 {
 	struct selinux_ebitmap_node *n, *new, *prev;
 
-	ebitmap_init(dst);
+	selinux_ebitmap_init(dst);
 	n = src->node;
 	prev = NULL;
 	while (n) {
@@ -74,7 +74,7 @@ int selinux_ebitmap_cpy(struct selinux_ebitmap *dst, struct selinux_ebitmap *src
 
 #ifdef CONFIG_NETLABEL
 /**
- * ebitmap_netlbl_export - Export an selinux_ebitmap into a NetLabel category bitmap
+ * selinux_ebitmap_netlbl_export - Export an selinux_ebitmap into a NetLabel category bitmap
  * @ebmap: the selinux_ebitmap to export
  * @catmap: the NetLabel category bitmap
  *
@@ -93,7 +93,7 @@ int selinux_ebitmap_netlbl_export(struct selinux_ebitmap *ebmap,
 
 	/* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
 	 * however, it is not always compatible with an array of unsigned long
-	 * in ebitmap_node.
+	 * in selinux_ebitmap_node.
 	 * In addition, you should pay attention the following implementation
 	 * assumes unsigned long has a width equal with or less than 64-bit.
 	 */
@@ -141,7 +141,7 @@ netlbl_export_failure:
 }
 
 /**
- * ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
+ * selinux_ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
  * @ebmap: the selinux_ebitmap to import
  * @catmap: the NetLabel category bitmap
  *
@@ -160,7 +160,7 @@ int selinux_ebitmap_netlbl_import(struct selinux_ebitmap *ebmap,
 
 	/* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
 	 * however, it is not always compatible with an array of unsigned long
-	 * in ebitmap_node.
+	 * in selinux_ebitmap_node.
 	 * In addition, you should pay attention the following implementation
 	 * assumes unsigned long has a width equal with or less than 64-bit.
 	 */
@@ -251,7 +251,7 @@ int selinux_ebitmap_get_bit(struct selinux_ebitmap *e, unsigned long bit)
 	n = e->node;
 	while (n && (n->startbit <= bit)) {
 		if ((n->startbit + EBITMAP_SIZE) > bit)
-			return ebitmap_node_get_bit(n, bit);
+			return selinux_ebitmap_node_get_bit(n, bit);
 		n = n->next;
 	}
 
@@ -267,11 +267,11 @@ int selinux_ebitmap_set_bit(struct selinux_ebitmap *e, unsigned long bit, int va
 	while (n && n->startbit <= bit) {
 		if ((n->startbit + EBITMAP_SIZE) > bit) {
 			if (value) {
-				ebitmap_node_set_bit(n, bit);
+				selinux_ebitmap_node_set_bit(n, bit);
 			} else {
 				unsigned int s;
 
-				ebitmap_node_clr_bit(n, bit);
+				selinux_ebitmap_node_clr_bit(n, bit);
 
 				s = find_first_bit(n->maps, EBITMAP_SIZE);
 				if (s < EBITMAP_SIZE)
@@ -309,7 +309,7 @@ int selinux_ebitmap_set_bit(struct selinux_ebitmap *e, unsigned long bit, int va
 		return -ENOMEM;
 
 	new->startbit = bit - (bit % EBITMAP_SIZE);
-	ebitmap_node_set_bit(new, bit);
+	selinux_ebitmap_node_set_bit(new, bit);
 
 	if (!n)
 		/* this node will be the highest map within the bitmap */
@@ -353,7 +353,7 @@ int selinux_ebitmap_read(struct selinux_ebitmap *e, void *fp)
 	__le32 buf[3];
 	int rc, i;
 
-	ebitmap_init(e);
+	selinux_ebitmap_init(e);
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 98090bc..9a5ea86 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -35,10 +35,10 @@ struct selinux_ebitmap {
 	u32 highbit;	/* highest position in the total bitmap */
 };
 
-#define ebitmap_length(e) ((e)->highbit)
-#define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
+#define selinux_ebitmap_length(e) ((e)->highbit)
+#define selinux_ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 
-static inline unsigned int ebitmap_start_positive(struct selinux_ebitmap *e,
+static inline unsigned int selinux_ebitmap_start_positive(struct selinux_ebitmap *e,
 						  struct selinux_ebitmap_node **n)
 {
 	unsigned int ofs;
@@ -48,15 +48,15 @@ static inline unsigned int ebitmap_start_positive(struct selinux_ebitmap *e,
 		if (ofs < EBITMAP_SIZE)
 			return (*n)->startbit + ofs;
 	}
-	return ebitmap_length(e);
+	return selinux_ebitmap_length(e);
 }
 
-static inline void ebitmap_init(struct selinux_ebitmap *e)
+static inline void selinux_ebitmap_init(struct selinux_ebitmap *e)
 {
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(struct selinux_ebitmap *e,
+static inline unsigned int selinux_ebitmap_next_positive(struct selinux_ebitmap *e,
 						 struct selinux_ebitmap_node **n,
 						 unsigned int bit)
 {
@@ -71,7 +71,7 @@ static inline unsigned int ebitmap_next_positive(struct selinux_ebitmap *e,
 		if (ofs < EBITMAP_SIZE)
 			return ofs + (*n)->startbit;
 	}
-	return ebitmap_length(e);
+	return selinux_ebitmap_length(e);
 }
 
 #define EBITMAP_NODE_INDEX(node, bit)	\
@@ -79,7 +79,7 @@ static inline unsigned int ebitmap_next_positive(struct selinux_ebitmap *e,
 #define EBITMAP_NODE_OFFSET(node, bit)	\
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
-static inline int ebitmap_node_get_bit(struct selinux_ebitmap_node *n,
+static inline int selinux_ebitmap_node_get_bit(struct selinux_ebitmap_node *n,
 				       unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -91,7 +91,7 @@ static inline int ebitmap_node_get_bit(struct selinux_ebitmap_node *n,
 	return 0;
 }
 
-static inline void ebitmap_node_set_bit(struct selinux_ebitmap_node *n,
+static inline void selinux_ebitmap_node_set_bit(struct selinux_ebitmap_node *n,
 					unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -101,7 +101,7 @@ static inline void ebitmap_node_set_bit(struct selinux_ebitmap_node *n,
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
-static inline void ebitmap_node_clr_bit(struct selinux_ebitmap_node *n,
+static inline void selinux_ebitmap_node_clr_bit(struct selinux_ebitmap_node *n,
 					unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -111,10 +111,10 @@ static inline void ebitmap_node_clr_bit(struct selinux_ebitmap_node *n,
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
 }
 
-#define ebitmap_for_each_positive_bit(e, n, bit)	\
-	for (bit = ebitmap_start_positive(e, &n);	\
-	     bit < ebitmap_length(e);			\
-	     bit = ebitmap_next_positive(e, &n, bit))	\
+#define selinux_ebitmap_for_each_positive_bit(e, n, bit)	\
+	for (bit = selinux_ebitmap_start_positive(e, &n);	\
+	     bit < selinux_ebitmap_length(e);			\
+	     bit = selinux_ebitmap_next_positive(e, &n, bit))	\
 
 int selinux_ebitmap_cmp(struct selinux_ebitmap *e1, struct selinux_ebitmap *e2);
 int selinux_ebitmap_cpy(struct selinux_ebitmap *dst, struct selinux_ebitmap *src);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 873a42a..91c4990 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -32,7 +32,7 @@
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
-int mls_compute_context_len(struct selinux_context *context)
+int selinux_mls_compute_context_len(struct selinux_context *context)
 {
 	int i, l, len, head, prev;
 	char *nm;
@@ -51,7 +51,7 @@ int mls_compute_context_len(struct selinux_context *context)
 		head = -2;
 		prev = -2;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
+		selinux_ebitmap_for_each_positive_bit(e, node, i) {
 			if (i - prev > 1) {
 				/* one or more negative bits are skipped */
 				if (head != prev) {
@@ -69,7 +69,7 @@ int mls_compute_context_len(struct selinux_context *context)
 			len += strlen(nm) + 1;
 		}
 		if (l == 0) {
-			if (mls_level_eq(&context->range.level[0],
+			if (selinux_mls_level_eq(&context->range.level[0],
 					 &context->range.level[1]))
 				break;
 			else
@@ -85,7 +85,7 @@ int mls_compute_context_len(struct selinux_context *context)
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-void mls_sid_to_context(struct selinux_context *context,
+void selinux_mls_sid_to_context(struct selinux_context *context,
 			char **scontext)
 {
 	char *scontextp, *nm;
@@ -110,7 +110,7 @@ void mls_sid_to_context(struct selinux_context *context,
 		head = -2;
 		prev = -2;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
+		selinux_ebitmap_for_each_positive_bit(e, node, i) {
 			if (i - prev > 1) {
 				/* one or more negative bits are skipped */
 				if (prev != head) {
@@ -145,7 +145,7 @@ void mls_sid_to_context(struct selinux_context *context,
 		}
 
 		if (l == 0) {
-			if (mls_level_eq(&context->range.level[0],
+			if (selinux_mls_level_eq(&context->range.level[0],
 					 &context->range.level[1]))
 				break;
 			else
@@ -157,7 +157,7 @@ void mls_sid_to_context(struct selinux_context *context,
 	return;
 }
 
-int mls_level_isvalid(struct selinux_policydb *p, struct mls_level *l)
+int selinux_mls_level_isvalid(struct selinux_policydb *p, struct selinux_mls_level *l)
 {
 	struct selinux_level_datum *levdatum;
 	struct selinux_ebitmap_node *node;
@@ -170,7 +170,7 @@ int mls_level_isvalid(struct selinux_policydb *p, struct mls_level *l)
 	if (!levdatum)
 		return 0;
 
-	ebitmap_for_each_positive_bit(&l->cat, node, i) {
+	selinux_ebitmap_for_each_positive_bit(&l->cat, node, i) {
 		if (i > p->p_cats.nprim)
 			return 0;
 		if (!selinux_ebitmap_get_bit(&levdatum->level->cat, i)) {
@@ -185,25 +185,25 @@ int mls_level_isvalid(struct selinux_policydb *p, struct mls_level *l)
 	return 1;
 }
 
-int mls_range_isvalid(struct selinux_policydb *p, struct mls_range *r)
+int selinux_mls_range_isvalid(struct selinux_policydb *p, struct selinux_mls_range *r)
 {
-	return (mls_level_isvalid(p, &r->level[0]) &&
-		mls_level_isvalid(p, &r->level[1]) &&
-		mls_level_dom(&r->level[1], &r->level[0]));
+	return (selinux_mls_level_isvalid(p, &r->level[0]) &&
+		selinux_mls_level_isvalid(p, &r->level[1]) &&
+		selinux_mls_level_dom(&r->level[1], &r->level[0]));
 }
 
 /*
  * Return 1 if the MLS fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c)
+int selinux_mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c)
 {
 	struct selinux_user_datum *usrdatum;
 
 	if (!selinux_mls_enabled)
 		return 1;
 
-	if (!mls_range_isvalid(p, &c->range))
+	if (!selinux_mls_range_isvalid(p, &c->range))
 		return 0;
 
 	if (c->role == OBJECT_R_VAL)
@@ -215,7 +215,7 @@ int mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c)
 	if (!c->user || c->user > p->p_users.nprim)
 		return 0;
 	usrdatum = p->user_val_to_struct[c->user - 1];
-	if (!mls_range_contains(usrdatum->range, c->range))
+	if (!selinux_mls_range_contains(usrdatum->range, c->range))
 		return 0; /* user may not be associated with range */
 
 	return 1;
@@ -239,7 +239,7 @@ int mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c)
  * Policy read-lock must be held for sidtab lookup.
  *
  */
-int mls_context_to_sid(struct selinux_policydb *pol,
+int selinux_mls_context_to_sid(struct selinux_policydb *pol,
 		       char oldc,
 		       char **scontext,
 		       struct selinux_context *context,
@@ -273,7 +273,7 @@ int mls_context_to_sid(struct selinux_policydb *pol,
 		if (!defcon)
 			goto out;
 
-		rc = mls_context_cpy(context, defcon);
+		rc = selinux_mls_context_cpy(context, defcon);
 		goto out;
 	}
 
@@ -382,7 +382,7 @@ out:
  * the string `str'.  This function will allocate temporary memory with the
  * given constraints of gfp_mask.
  */
-int mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask)
+int selinux_mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask)
 {
 	char *tmpstr, *freestr;
 	int rc;
@@ -390,13 +390,13 @@ int mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask)
 	if (!selinux_mls_enabled)
 		return -EINVAL;
 
-	/* we need freestr because mls_context_to_sid will change
+	/* we need freestr because selinux_mls_context_to_sid will change
 	   the value of tmpstr */
 	tmpstr = freestr = kstrdup(str, gfp_mask);
 	if (!tmpstr) {
 		rc = -ENOMEM;
 	} else {
-		rc = mls_context_to_sid(&policydb, ':', &tmpstr, context,
+		rc = selinux_mls_context_to_sid(&policydb, ':', &tmpstr, context,
 					NULL, SECSID_NULL);
 		kfree(freestr);
 	}
@@ -407,8 +407,8 @@ int mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask)
 /*
  * Copies the MLS range `range' into `context'.
  */
-static inline int mls_range_set(struct selinux_context *context,
-				struct mls_range *range)
+static inline int selinux_mls_range_set(struct selinux_context *context,
+				struct selinux_mls_range *range)
 {
 	int l, rc = 0;
 
@@ -424,24 +424,24 @@ static inline int mls_range_set(struct selinux_context *context,
 	return rc;
 }
 
-int mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_datum *user,
+int selinux_mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_datum *user,
 			 struct selinux_context *usercon)
 {
 	if (selinux_mls_enabled) {
-		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
-		struct mls_level *fromcon_clr = &(fromcon->range.level[1]);
-		struct mls_level *user_low = &(user->range.level[0]);
-		struct mls_level *user_clr = &(user->range.level[1]);
-		struct mls_level *user_def = &(user->dfltlevel);
-		struct mls_level *usercon_sen = &(usercon->range.level[0]);
-		struct mls_level *usercon_clr = &(usercon->range.level[1]);
+		struct selinux_mls_level *fromcon_sen = &(fromcon->range.level[0]);
+		struct selinux_mls_level *fromcon_clr = &(fromcon->range.level[1]);
+		struct selinux_mls_level *user_low = &(user->range.level[0]);
+		struct selinux_mls_level *user_clr = &(user->range.level[1]);
+		struct selinux_mls_level *user_def = &(user->dfltlevel);
+		struct selinux_mls_level *usercon_sen = &(usercon->range.level[0]);
+		struct selinux_mls_level *usercon_clr = &(usercon->range.level[1]);
 
 		/* Honor the user's default level if we can */
-		if (mls_level_between(user_def, fromcon_sen, fromcon_clr))
+		if (selinux_mls_level_between(user_def, fromcon_sen, fromcon_clr))
 			*usercon_sen = *user_def;
-		else if (mls_level_between(fromcon_sen, user_def, user_clr))
+		else if (selinux_mls_level_between(fromcon_sen, user_def, user_clr))
 			*usercon_sen = *fromcon_sen;
-		else if (mls_level_between(fromcon_clr, user_low, user_def))
+		else if (selinux_mls_level_between(fromcon_clr, user_low, user_def))
 			*usercon_sen = *user_low;
 		else
 			return -EINVAL;
@@ -451,9 +451,9 @@ int mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_da
 		   that of the user's default clearance (but
 		   only if the "fromcon" clearance dominates
 		   the user's computed sensitivity level) */
-		if (mls_level_dom(user_clr, fromcon_clr))
+		if (selinux_mls_level_dom(user_clr, fromcon_clr))
 			*usercon_clr = *fromcon_clr;
-		else if (mls_level_dom(fromcon_clr, user_clr))
+		else if (selinux_mls_level_dom(fromcon_clr, user_clr))
 			*usercon_clr = *user_clr;
 		else
 			return -EINVAL;
@@ -467,7 +467,7 @@ int mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_da
  * structure `c' from the values specified in the
  * policy `oldp' to the values specified in the policy `newp'.
  */
-int mls_convert_context(struct selinux_policydb *oldp,
+int selinux_mls_convert_context(struct selinux_policydb *oldp,
 			struct selinux_policydb *newp,
 			struct selinux_context *c)
 {
@@ -488,8 +488,8 @@ int mls_convert_context(struct selinux_policydb *oldp,
 			return -EINVAL;
 		c->range.level[l].sens = levdatum->level->sens;
 
-		ebitmap_init(&bitmap);
-		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
+		selinux_ebitmap_init(&bitmap);
+		selinux_ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
 			int rc;
 
 			catdatum = selinux_hashtab_search(newp->p_cats.table,
@@ -507,7 +507,7 @@ int mls_convert_context(struct selinux_policydb *oldp,
 	return 0;
 }
 
-int mls_compute_sid(struct selinux_context *scontext,
+int selinux_mls_compute_sid(struct selinux_context *scontext,
 		    struct selinux_context *tcontext,
 		    u16 tclass,
 		    u32 specified,
@@ -526,7 +526,7 @@ int mls_compute_sid(struct selinux_context *scontext,
 			    rtr->target_type == tcontext->type &&
 			    rtr->target_class == tclass) {
 				/* Set the range from the rule */
-				return mls_range_set(newcontext,
+				return selinux_mls_range_set(newcontext,
 						     &rtr->target_range);
 			}
 		}
@@ -534,13 +534,13 @@ int mls_compute_sid(struct selinux_context *scontext,
 	case AVTAB_CHANGE:
 		if (tclass == SECCLASS_PROCESS)
 			/* Use the process MLS attributes. */
-			return mls_context_cpy(newcontext, scontext);
+			return selinux_mls_context_cpy(newcontext, scontext);
 		else
 			/* Use the process effective MLS attributes. */
-			return mls_context_cpy_low(newcontext, scontext);
+			return selinux_mls_context_cpy_low(newcontext, scontext);
 	case AVTAB_MEMBER:
 		/* Use the process effective MLS attributes. */
-		return mls_context_cpy_low(newcontext, scontext);
+		return selinux_mls_context_cpy_low(newcontext, scontext);
 	default:
 		return -EINVAL;
 	}
@@ -549,7 +549,7 @@ int mls_compute_sid(struct selinux_context *scontext,
 
 #ifdef CONFIG_NETLABEL
 /**
- * mls_export_netlbl_lvl - Export the MLS sensitivity levels to NetLabel
+ * selinux_mls_export_netlbl_lvl - Export the MLS sensitivity levels to NetLabel
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -558,7 +558,7 @@ int mls_compute_sid(struct selinux_context *scontext,
  * NetLabel MLS sensitivity level field.
  *
  */
-void mls_export_netlbl_lvl(struct selinux_context *context,
+void selinux_mls_export_netlbl_lvl(struct selinux_context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!selinux_mls_enabled)
@@ -569,7 +569,7 @@ void mls_export_netlbl_lvl(struct selinux_context *context,
 }
 
 /**
- * mls_import_netlbl_lvl - Import the NetLabel MLS sensitivity levels
+ * selinux_mls_import_netlbl_lvl - Import the NetLabel MLS sensitivity levels
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -578,7 +578,7 @@ void mls_export_netlbl_lvl(struct selinux_context *context,
  * NetLabel MLS sensitivity level into the context.
  *
  */
-void mls_import_netlbl_lvl(struct selinux_context *context,
+void selinux_mls_import_netlbl_lvl(struct selinux_context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
 	if (!selinux_mls_enabled)
@@ -589,7 +589,7 @@ void mls_import_netlbl_lvl(struct selinux_context *context,
 }
 
 /**
- * mls_export_netlbl_cat - Export the MLS categories to NetLabel
+ * selinux_mls_export_netlbl_cat - Export the MLS categories to NetLabel
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -598,7 +598,7 @@ void mls_import_netlbl_lvl(struct selinux_context *context,
  * MLS category field.  Returns zero on success, negative values on failure.
  *
  */
-int mls_export_netlbl_cat(struct selinux_context *context,
+int selinux_mls_export_netlbl_cat(struct selinux_context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
@@ -615,7 +615,7 @@ int mls_export_netlbl_cat(struct selinux_context *context,
 }
 
 /**
- * mls_import_netlbl_cat - Import the MLS categories from NetLabel
+ * selinux_mls_import_netlbl_cat - Import the MLS categories from NetLabel
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -626,7 +626,7 @@ int mls_export_netlbl_cat(struct selinux_context *context,
  * negative values on failure.
  *
  */
-int mls_import_netlbl_cat(struct selinux_context *context,
+int selinux_mls_import_netlbl_cat(struct selinux_context *context,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index af84f26..08bf61c 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -24,60 +24,60 @@
 #include "context.h"
 #include "policydb.h"
 
-int mls_compute_context_len(struct selinux_context *context);
-void mls_sid_to_context(struct selinux_context *context, char **scontext);
-int mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c);
-int mls_range_isvalid(struct selinux_policydb *p, struct mls_range *r);
-int mls_level_isvalid(struct selinux_policydb *p, struct mls_level *l);
+int selinux_mls_compute_context_len(struct selinux_context *context);
+void selinux_mls_sid_to_context(struct selinux_context *context, char **scontext);
+int selinux_mls_context_isvalid(struct selinux_policydb *p, struct selinux_context *c);
+int selinux_mls_range_isvalid(struct selinux_policydb *p, struct selinux_mls_range *r);
+int selinux_mls_level_isvalid(struct selinux_policydb *p, struct selinux_mls_level *l);
 
-int mls_context_to_sid(struct selinux_policydb *p,
+int selinux_mls_context_to_sid(struct selinux_policydb *p,
 		       char oldc,
 		       char **scontext,
 		       struct selinux_context *context,
 		       struct selinux_sidtab *s,
 		       u32 def_sid);
 
-int mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask);
+int selinux_mls_from_string(char *str, struct selinux_context *context, gfp_t gfp_mask);
 
-int mls_convert_context(struct selinux_policydb *oldp,
+int selinux_mls_convert_context(struct selinux_policydb *oldp,
 			struct selinux_policydb *newp,
 			struct selinux_context *context);
 
-int mls_compute_sid(struct selinux_context *scontext,
+int selinux_mls_compute_sid(struct selinux_context *scontext,
 		    struct selinux_context *tcontext,
 		    u16 tclass,
 		    u32 specified,
 		    struct selinux_context *newcontext);
 
-int mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_datum *user,
+int selinux_mls_setup_user_range(struct selinux_context *fromcon, struct selinux_user_datum *user,
 			 struct selinux_context *usercon);
 
 #ifdef CONFIG_NETLABEL
-void mls_export_netlbl_lvl(struct selinux_context *context,
+void selinux_mls_export_netlbl_lvl(struct selinux_context *context,
 			   struct netlbl_lsm_secattr *secattr);
-void mls_import_netlbl_lvl(struct selinux_context *context,
+void selinux_mls_import_netlbl_lvl(struct selinux_context *context,
 			   struct netlbl_lsm_secattr *secattr);
-int mls_export_netlbl_cat(struct selinux_context *context,
+int selinux_mls_export_netlbl_cat(struct selinux_context *context,
 			  struct netlbl_lsm_secattr *secattr);
-int mls_import_netlbl_cat(struct selinux_context *context,
+int selinux_mls_import_netlbl_cat(struct selinux_context *context,
 			  struct netlbl_lsm_secattr *secattr);
 #else
-static inline void mls_export_netlbl_lvl(struct selinux_context *context,
+static inline void selinux_mls_export_netlbl_lvl(struct selinux_context *context,
 					 struct netlbl_lsm_secattr *secattr)
 {
 	return;
 }
-static inline void mls_import_netlbl_lvl(struct selinux_context *context,
+static inline void selinux_mls_import_netlbl_lvl(struct selinux_context *context,
 					 struct netlbl_lsm_secattr *secattr)
 {
 	return;
 }
-static inline int mls_export_netlbl_cat(struct selinux_context *context,
+static inline int selinux_mls_export_netlbl_cat(struct selinux_context *context,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOMEM;
 }
-static inline int mls_import_netlbl_cat(struct selinux_context *context,
+static inline int selinux_mls_import_netlbl_cat(struct selinux_context *context,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOMEM;
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 5d33694..9eb8042 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -16,16 +16,16 @@
 
 #include "security.h"
 
-struct mls_level {
+struct selinux_mls_level {
 	u32 sens;		/* sensitivity */
 	struct selinux_ebitmap cat;	/* category set */
 };
 
-struct mls_range {
-	struct mls_level level[2]; /* low == level[0], high == level[1] */
+struct selinux_mls_range {
+	struct selinux_mls_level level[2]; /* low == level[0], high == level[1] */
 };
 
-static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
+static inline int selinux_mls_level_eq(struct selinux_mls_level *l1, struct selinux_mls_level *l2)
 {
 	if (!selinux_mls_enabled)
 		return 1;
@@ -34,7 +34,7 @@ static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 		selinux_ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
-static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
+static inline int selinux_mls_level_dom(struct selinux_mls_level *l1, struct selinux_mls_level *l2)
 {
 	if (!selinux_mls_enabled)
 		return 1;
@@ -43,14 +43,14 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 		selinux_ebitmap_contains(&l1->cat, &l2->cat));
 }
 
-#define mls_level_incomp(l1, l2) \
-(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
+#define selinux_mls_level_incomp(l1, l2) \
+(!selinux_mls_level_dom((l1), (l2)) && !selinux_mls_level_dom((l2), (l1)))
 
-#define mls_level_between(l1, l2, l3) \
-(mls_level_dom((l1), (l2)) && mls_level_dom((l3), (l1)))
+#define selinux_mls_level_between(l1, l2, l3) \
+(selinux_mls_level_dom((l1), (l2)) && selinux_mls_level_dom((l3), (l1)))
 
-#define mls_range_contains(r1, r2) \
-(mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
- mls_level_dom(&(r1).level[1], &(r2).level[1]))
+#define selinux_mls_range_contains(r1, r2) \
+(selinux_mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
+ selinux_mls_level_dom(&(r1).level[1], &(r2).level[1]))
 
 #endif	/* _SS_MLS_TYPES_H_ */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2955cae..0ec60b0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -204,8 +204,8 @@ static int policydb_init(struct selinux_policydb *p)
 	if (rc)
 		goto out_free_symtab;
 
-	ebitmap_init(&p->policycaps);
-	ebitmap_init(&p->permissive_map);
+	selinux_ebitmap_init(&p->policycaps);
+	selinux_ebitmap_init(&p->permissive_map);
 
 out:
 	return rc;
@@ -816,7 +816,7 @@ int policydb_context_isvalid(struct selinux_policydb *p, struct selinux_context
 			return 0;
 	}
 
-	if (!mls_context_isvalid(p, c))
+	if (!selinux_mls_context_isvalid(p, c))
 		return 0;
 
 	return 1;
@@ -826,7 +826,7 @@ int policydb_context_isvalid(struct selinux_policydb *p, struct selinux_context
  * Read a MLS range structure from a policydb binary
  * representation file.
  */
-static int mls_read_range_helper(struct mls_range *r, void *fp)
+static int selinux_mls_read_range_helper(struct selinux_mls_range *r, void *fp)
 {
 	__le32 buf[2];
 	u32 items;
@@ -902,7 +902,7 @@ static int context_read_and_validate(struct selinux_context *c,
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
-		if (mls_read_range_helper(&c->range, fp)) {
+		if (selinux_mls_read_range_helper(&c->range, fp)) {
 			printk(KERN_ERR "SELinux: error reading MLS range of "
 			       "context\n");
 			rc = -EINVAL;
@@ -1320,7 +1320,7 @@ bad:
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-static int mls_read_level(struct mls_level *lp, void *fp)
+static int selinux_mls_read_level(struct selinux_mls_level *lp, void *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1387,10 +1387,10 @@ static int user_read(struct selinux_policydb *p, struct selinux_hashtab *h, void
 		goto bad;
 
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
-		rc = mls_read_range_helper(&usrdatum->range, fp);
+		rc = selinux_mls_read_range_helper(&usrdatum->range, fp);
 		if (rc)
 			goto bad;
-		rc = mls_read_level(&usrdatum->dfltlevel, fp);
+		rc = selinux_mls_read_level(&usrdatum->dfltlevel, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1436,12 +1436,12 @@ static int sens_read(struct selinux_policydb *p, struct selinux_hashtab *h, void
 		goto bad;
 	key[len] = '\0';
 
-	levdatum->level = kmalloc(sizeof(struct mls_level), GFP_ATOMIC);
+	levdatum->level = kmalloc(sizeof(struct selinux_mls_level), GFP_ATOMIC);
 	if (!levdatum->level) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	if (mls_read_level(levdatum->level, fp)) {
+	if (selinux_mls_read_level(levdatum->level, fp)) {
 		rc = -EINVAL;
 		goto bad;
 	}
@@ -1530,7 +1530,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 		}
 
 		upper = p->user_val_to_struct[upper->bounds - 1];
-		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
+		selinux_ebitmap_for_each_positive_bit(&user->roles, node, bit) {
 			if (selinux_ebitmap_get_bit(&upper->roles, bit))
 				continue;
 
@@ -1567,7 +1567,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 		}
 
 		upper = p->role_val_to_struct[upper->bounds - 1];
-		ebitmap_for_each_positive_bit(&role->types, node, bit) {
+		selinux_ebitmap_for_each_positive_bit(&role->types, node, bit) {
 			if (selinux_ebitmap_get_bit(&upper->types, bit))
 				continue;
 
@@ -2108,10 +2108,10 @@ int policydb_read(struct selinux_policydb *p, void *fp)
 				rc = -EINVAL;
 				goto bad;
 			}
-			rc = mls_read_range_helper(&rt->target_range, fp);
+			rc = selinux_mls_read_range_helper(&rt->target_range, fp);
 			if (rc)
 				goto bad;
-			if (!mls_range_isvalid(p, &rt->target_range)) {
+			if (!selinux_mls_range_isvalid(p, &rt->target_range)) {
 				printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
 				goto bad;
 			}
@@ -2124,7 +2124,7 @@ int policydb_read(struct selinux_policydb *p, void *fp)
 		goto bad;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
-		ebitmap_init(&p->type_attr_map[i]);
+		selinux_ebitmap_init(&p->type_attr_map[i]);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
 			if (selinux_ebitmap_read(&p->type_attr_map[i], fp))
 				goto bad;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 04a54d0..6efb70e 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -92,14 +92,14 @@ struct selinux_user_datum {
 	u32 value;			/* internal user value */
 	u32 bounds;			/* bounds of user */
 	struct selinux_ebitmap roles;		/* set of authorized roles for user */
-	struct mls_range range;		/* MLS range (min - max) for user */
-	struct mls_level dfltlevel;	/* default login MLS level for user */
+	struct selinux_mls_range range;		/* MLS range (min - max) for user */
+	struct selinux_mls_level dfltlevel;	/* default login MLS level for user */
 };
 
 
 /* Sensitivity attributes */
 struct selinux_level_datum {
-	struct mls_level *level;	/* sensitivity and associated categories */
+	struct selinux_mls_level *level;	/* sensitivity and associated categories */
 	unsigned char isalias;	/* is this sensitivity an alias for another? */
 };
 
@@ -113,7 +113,7 @@ struct selinux_range_trans {
 	u32 source_type;
 	u32 target_type;
 	u32 target_class;
-	struct mls_range target_range;
+	struct selinux_mls_range target_range;
 	struct selinux_range_trans *next;
 };
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 420cdbf..af6ec02 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -117,7 +117,7 @@ static int constraint_expr_eval(struct selinux_context *scontext,
 	u32 val1, val2;
 	struct selinux_context *c;
 	struct selinux_role_datum *r1, *r2;
-	struct mls_level *l1, *l2;
+	struct selinux_mls_level *l1, *l2;
 	struct selinux_constraint_expr *e;
 	int s[CEXPR_MAXDEPTH];
 	int sp = -1;
@@ -177,43 +177,43 @@ static int constraint_expr_eval(struct selinux_context *scontext,
 			case CEXPR_L1L2:
 				l1 = &(scontext->range.level[0]);
 				l2 = &(tcontext->range.level[0]);
-				goto mls_ops;
+				goto selinux_mls_ops;
 			case CEXPR_L1H2:
 				l1 = &(scontext->range.level[0]);
 				l2 = &(tcontext->range.level[1]);
-				goto mls_ops;
+				goto selinux_mls_ops;
 			case CEXPR_H1L2:
 				l1 = &(scontext->range.level[1]);
 				l2 = &(tcontext->range.level[0]);
-				goto mls_ops;
+				goto selinux_mls_ops;
 			case CEXPR_H1H2:
 				l1 = &(scontext->range.level[1]);
 				l2 = &(tcontext->range.level[1]);
-				goto mls_ops;
+				goto selinux_mls_ops;
 			case CEXPR_L1H1:
 				l1 = &(scontext->range.level[0]);
 				l2 = &(scontext->range.level[1]);
-				goto mls_ops;
+				goto selinux_mls_ops;
 			case CEXPR_L2H2:
 				l1 = &(tcontext->range.level[0]);
 				l2 = &(tcontext->range.level[1]);
-				goto mls_ops;
-mls_ops:
+				goto selinux_mls_ops;
+selinux_mls_ops:
 			switch (e->op) {
 			case CEXPR_EQ:
-				s[++sp] = mls_level_eq(l1, l2);
+				s[++sp] = selinux_mls_level_eq(l1, l2);
 				continue;
 			case CEXPR_NEQ:
-				s[++sp] = !mls_level_eq(l1, l2);
+				s[++sp] = !selinux_mls_level_eq(l1, l2);
 				continue;
 			case CEXPR_DOM:
-				s[++sp] = mls_level_dom(l1, l2);
+				s[++sp] = selinux_mls_level_dom(l1, l2);
 				continue;
 			case CEXPR_DOMBY:
-				s[++sp] = mls_level_dom(l2, l1);
+				s[++sp] = selinux_mls_level_dom(l2, l1);
 				continue;
 			case CEXPR_INCOMP:
-				s[++sp] = mls_level_incomp(l2, l1);
+				s[++sp] = selinux_mls_level_incomp(l2, l1);
 				continue;
 			default:
 				BUG();
@@ -528,8 +528,8 @@ static int context_struct_compute_av(struct selinux_context *scontext,
 	avkey.specified = AVTAB_AV;
 	sattr = &policydb.type_attr_map[scontext->type - 1];
 	tattr = &policydb.type_attr_map[tcontext->type - 1];
-	ebitmap_for_each_positive_bit(sattr, snode, i) {
-		ebitmap_for_each_positive_bit(tattr, tnode, j) {
+	selinux_ebitmap_for_each_positive_bit(sattr, snode, i) {
+		selinux_ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
 			for (node = selinux_avtab_search_node(&policydb.te_avtab, &avkey);
@@ -876,7 +876,7 @@ static int context_struct_to_string(struct selinux_context *context, char **scon
 	*scontext_len += strlen(policydb.p_user_val_to_name[context->user - 1]) + 1;
 	*scontext_len += strlen(policydb.p_role_val_to_name[context->role - 1]) + 1;
 	*scontext_len += strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
-	*scontext_len += mls_compute_context_len(context);
+	*scontext_len += selinux_mls_compute_context_len(context);
 
 	/* Allocate space for the context; caller must free this space. */
 	scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
@@ -895,7 +895,7 @@ static int context_struct_to_string(struct selinux_context *context, char **scon
 		     1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
 		     1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
 
-	mls_sid_to_context(context, &scontextp);
+	selinux_mls_sid_to_context(context, &scontextp);
 
 	*scontextp = 0;
 
@@ -1045,7 +1045,7 @@ static int string_to_context_struct(struct selinux_policydb *pol,
 
 	ctx->type = typdatum->value;
 
-	rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
+	rc = selinux_mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
 	if (rc)
 		goto out;
 
@@ -1318,7 +1318,7 @@ static int security_compute_sid(u32 ssid,
 
 	/* Set the MLS attributes.
 	   This is done last because it may allocate memory. */
-	rc = mls_compute_sid(scontext, tcontext, tclass, specified, &newcontext);
+	rc = selinux_mls_compute_sid(scontext, tcontext, tclass, specified, &newcontext);
 	if (rc)
 		goto out_unlock;
 
@@ -1655,7 +1655,7 @@ static int convert_context(u32 key,
 		goto bad;
 	c->type = typdatum->value;
 
-	rc = mls_convert_context(args->oldp, args->newp, c);
+	rc = selinux_mls_convert_context(args->oldp, args->newp, c);
 	if (rc)
 		goto bad;
 
@@ -2047,13 +2047,13 @@ int selinux_get_user_sids(u32 fromsid,
 		goto out_unlock;
 	}
 
-	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
+	selinux_ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
 		role = policydb.role_val_to_struct[i];
 		usercon.role = i+1;
-		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
+		selinux_ebitmap_for_each_positive_bit(&role->types, tnode, j) {
 			usercon.type = j+1;
 
-			if (mls_setup_user_range(fromcon, user, &usercon))
+			if (selinux_mls_setup_user_range(fromcon, user, &usercon))
 				continue;
 
 			rc = selinux_sidtab_context_to_sid(&sidtab, &usercon, &sid);
@@ -2366,9 +2366,9 @@ out:
 
 /*
  * selinux_sid_mls_copy() - computes a new sid based on the given
- * sid and the mls portion of mls_sid.
+ * sid and the mls portion of selinux_mls_sid.
  */
-int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
+int selinux_sid_mls_copy(u32 sid, u32 selinux_mls_sid, u32 *new_sid)
 {
 	struct selinux_context *context1;
 	struct selinux_context *context2;
@@ -2393,10 +2393,10 @@ int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 		goto out_unlock;
 	}
 
-	context2 = selinux_sidtab_search(&sidtab, mls_sid);
+	context2 = selinux_sidtab_search(&sidtab, selinux_mls_sid);
 	if (!context2) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
-			__func__, mls_sid);
+			__func__, selinux_mls_sid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -2404,7 +2404,7 @@ int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	newcon.user = context1->user;
 	newcon.role = context1->role;
 	newcon.type = context1->type;
-	rc = mls_context_cpy(&newcon, context2);
+	rc = selinux_mls_context_cpy(&newcon, context2);
 	if (rc)
 		goto out_unlock;
 
@@ -2421,7 +2421,7 @@ int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 bad:
 	if (!context_struct_to_string(&newcon, &s, &len)) {
 		audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-			  "security_sid_mls_copy: invalid context %s", s);
+			  "security_sid_selinux_mls_copy: invalid context %s", s);
 		kfree(s);
 	}
 
@@ -2499,7 +2499,7 @@ int selinux_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 		rc = -EINVAL;
 		goto out_slowpath;
 	}
-	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
+	rc = (selinux_mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
 
 out_slowpath:
 	read_unlock(&policy_rwlock);
@@ -2733,7 +2733,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_CLR:
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
-		rc = mls_from_string(rulestr, &tmprule->au_ctxt, GFP_ATOMIC);
+		rc = selinux_mls_from_string(rulestr, &tmprule->au_ctxt, GFP_ATOMIC);
 		break;
 	}
 
@@ -2778,7 +2778,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 			     struct audit_context *actx)
 {
 	struct selinux_context *ctxt;
-	struct mls_level *level;
+	struct selinux_mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
 	int match = 0;
 
@@ -2851,31 +2851,31 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 			 &ctxt->range.level[0] : &ctxt->range.level[1]);
 		switch (op) {
 		case Audit_equal:
-			match = mls_level_eq(&rule->au_ctxt.range.level[0],
+			match = selinux_mls_level_eq(&rule->au_ctxt.range.level[0],
 					     level);
 			break;
 		case Audit_not_equal:
-			match = !mls_level_eq(&rule->au_ctxt.range.level[0],
+			match = !selinux_mls_level_eq(&rule->au_ctxt.range.level[0],
 					      level);
 			break;
 		case Audit_lt:
-			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
+			match = (selinux_mls_level_dom(&rule->au_ctxt.range.level[0],
 					       level) &&
-				 !mls_level_eq(&rule->au_ctxt.range.level[0],
+				 !selinux_mls_level_eq(&rule->au_ctxt.range.level[0],
 					       level));
 			break;
 		case Audit_le:
-			match = mls_level_dom(&rule->au_ctxt.range.level[0],
+			match = selinux_mls_level_dom(&rule->au_ctxt.range.level[0],
 					      level);
 			break;
 		case Audit_gt:
-			match = (mls_level_dom(level,
+			match = (selinux_mls_level_dom(level,
 					      &rule->au_ctxt.range.level[0]) &&
-				 !mls_level_eq(level,
+				 !selinux_mls_level_eq(level,
 					       &rule->au_ctxt.range.level[0]));
 			break;
 		case Audit_ge:
-			match = mls_level_dom(level,
+			match = selinux_mls_level_dom(level,
 					      &rule->au_ctxt.range.level[0]);
 			break;
 		}
@@ -2987,7 +2987,7 @@ int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		ctx_new.user = ctx->user;
 		ctx_new.role = ctx->role;
 		ctx_new.type = ctx->type;
-		mls_import_netlbl_lvl(&ctx_new, secattr);
+		selinux_mls_import_netlbl_lvl(&ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
 			if (selinux_ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
 						  secattr->attr.mls.cat) != 0)
@@ -2996,7 +2996,7 @@ int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 			       &ctx_new.range.level[0].cat,
 			       sizeof(ctx_new.range.level[0].cat));
 		}
-		if (mls_context_isvalid(&policydb, &ctx_new) != 1)
+		if (selinux_mls_context_isvalid(&policydb, &ctx_new) != 1)
 			goto netlbl_secattr_to_sid_return_cleanup;
 
 		rc = selinux_sidtab_context_to_sid(&sidtab, &ctx_new, sid);
@@ -3051,8 +3051,8 @@ int selinux_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	}
 	secattr->attr.secid = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
-	mls_export_netlbl_lvl(ctx, secattr);
-	rc = mls_export_netlbl_cat(ctx, secattr);
+	selinux_mls_export_netlbl_lvl(ctx, secattr);
+	rc = selinux_mls_export_netlbl_cat(ctx, secattr);
 	if (rc != 0)
 		goto netlbl_sid_to_secattr_failure;
 	read_unlock(&policy_rwlock);
-- 
1.6.2.5




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
