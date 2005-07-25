Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PK5FgA026813
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 16:05:16 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PJx5AP007116
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 19:59:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j6PK0JFO027656
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 16:00:19 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j6PK0J4t027655
	for selinux@tycho.nsa.gov; Mon, 25 Jul 2005 16:00:19 -0400
Subject: [RFC][PATCH 2/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@redhat.com>
In-Reply-To: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 15:53:49 -0400
Message-Id: <1122321229.3029.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch modifies libsepol for the reduced avtab size.  This includes
both read-side and write-side compatibility code for dealing with older
policy versions.

---

 include/sepol/avtab.h    |   38 ++++----
 include/sepol/policydb.h |    3 
 src/assertion.c          |    7 -
 src/avtab.c              |  180 +++++++++++++++++++++++++++------------
 src/conditional.c        |  205 +++++++++++++++++++++++++--------------------
 src/expand.c             |   69 +++++----------
 src/hierarchy.c          |   29 +++---
 src/policydb.c           |    8 +
 src/private.h            |    4 
 src/services.c           |   43 +++------
 src/write.c              |  214 +++++++++++++++++++++++++++++++++++++----------
 11 files changed, 507 insertions(+), 293 deletions(-)

Index: libsepol/include/sepol/avtab.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/avtab.h,v
retrieving revision 1.4
diff -u -p -r1.4 avtab.h
--- libsepol/include/sepol/avtab.h	13 Jul 2005 19:26:17 -0000	1.4
+++ libsepol/include/sepol/avtab.h	23 Jul 2005 03:00:57 -0000
@@ -39,12 +39,9 @@
 #include <stdint.h>
 
 typedef struct avtab_key {
-	uint32_t source_type;	/* source type */
-	uint32_t target_type;	/* target type */
-	uint32_t target_class;     /* target object class */
-} avtab_key_t;
-
-typedef struct avtab_datum {
+	uint16_t source_type;
+	uint16_t target_type;
+	uint16_t target_class;
 #define AVTAB_ALLOWED     1
 #define AVTAB_AUDITALLOW  2
 #define AVTAB_AUDITDENY   4
@@ -53,15 +50,13 @@ typedef struct avtab_datum {
 #define AVTAB_MEMBER     32
 #define AVTAB_CHANGE     64
 #define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_ENABLED    0x80000000 /* reserved for used in cond_avtab */
-	uint32_t specified;	/* what fields are specified */
-        uint32_t data[3];          /* access vectors or types */
-#define avtab_allowed(x) (x)->data[0]
-#define avtab_auditdeny(x) (x)->data[1]
-#define avtab_auditallow(x) (x)->data[2]
-#define avtab_transition(x) (x)->data[0]
-#define avtab_change(x) (x)->data[1]
-#define avtab_member(x) (x)->data[2]
+#define AVTAB_ENABLED_OLD 0x80000000
+#define AVTAB_ENABLED    0x8000 /* reserved for used in cond_avtab */
+	uint16_t specified;	/* what fields are specified */
+} avtab_key_t;
+
+typedef struct avtab_datum {
+        uint32_t data;          /* access vector or type */
 } avtab_datum_t;
 
 typedef struct avtab_node *avtab_ptr_t;
@@ -72,6 +67,8 @@ struct avtab_node {
 	avtab_ptr_t next;
 	void *parse_context;	/* generic context pointer used by parser;
 				 * not saved in binary policy */
+	unsigned merged;       /* flag for avtab_write only;
+				  not saved in binary policy */
 };
 
 typedef struct avtab {
@@ -83,7 +80,7 @@ extern int avtab_init(avtab_t *);
 
 extern int avtab_insert(avtab_t * h, avtab_key_t * k, avtab_datum_t * d);
 
-extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k, int specified);
+extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k);
 
 extern void avtab_destroy(avtab_t * h);
 
@@ -95,16 +92,19 @@ extern int avtab_map(avtab_t * h,
 
 extern void avtab_hash_eval(avtab_t * h, char *tag);
 
-extern int avtab_read_item(void *fp, avtab_datum_t *avdatum, avtab_key_t *avkey);
+extern int avtab_read_item(void *fp, uint32_t vers, avtab_t *a, 
+			   int (*insert)(avtab_t *a, avtab_key_t *k, 
+					 avtab_datum_t *d, void *p),
+			   void *p);
 
-extern int avtab_read(avtab_t * a, void * fp, uint32_t config);
+extern int avtab_read(avtab_t * a, void * fp, uint32_t vers);
 
 extern avtab_ptr_t avtab_insert_nonunique(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum);
 
 extern avtab_ptr_t avtab_insert_with_parse_context(avtab_t *h, avtab_key_t *key,
 					    avtab_datum_t *datum, void *parse_context);
 
-extern avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key, int specified);
+extern avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key);
 
 extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 
Index: libsepol/include/sepol/policydb.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb.h,v
retrieving revision 1.12
diff -u -p -r1.12 policydb.h
--- libsepol/include/sepol/policydb.h	18 Jul 2005 14:22:06 -0000	1.12
+++ libsepol/include/sepol/policydb.h	23 Jul 2005 02:25:47 -0000
@@ -514,10 +514,11 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_NLCLASS	18
 #define POLICYDB_VERSION_VALIDATETRANS	19
 #define POLICYDB_VERSION_MLS		19
+#define POLICYDB_VERSION_AVTAB		20
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_MLS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	4
Index: libsepol/src/assertion.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/assertion.c,v
retrieving revision 1.1
diff -u -p -r1.1 assertion.c
--- libsepol/src/assertion.c	6 Jul 2005 17:24:54 -0000	1.1
+++ libsepol/src/assertion.c	23 Jul 2005 02:25:47 -0000
@@ -95,14 +95,15 @@ static int check_assertion_helper(policy
                 avkey.source_type = stype + 1;
                 avkey.target_type = ttype + 1;
                 avkey.target_class = curperm->class;
-                avdatump = avtab_search(avtab, &avkey, AVTAB_AV);
+		avkey.specified = AVTAB_ALLOWED;
+                avdatump = avtab_search(avtab, &avkey);
                 if (!avdatump)
 			continue;
-                if ((avdatump->specified & AVTAB_ALLOWED) && (avtab_allowed(avdatump) & curperm->data)) {
+                if (avdatump->data & curperm->data) {
                         fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s {%s };\n",
                                 line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
                                 p->p_class_val_to_name[curperm->class - 1],
-				av_to_string(p, curperm->class+1, avtab_allowed(avdatump) & curperm->data));
+				av_to_string(p, curperm->class+1, avdatump->data & curperm->data));
                         return -1;
                 }
 
Index: libsepol/src/avtab.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/avtab.c,v
retrieving revision 1.5
diff -u -p -r1.5 avtab.c
--- libsepol/src/avtab.c	6 Jul 2005 17:24:54 -0000	1.5
+++ libsepol/src/avtab.c	23 Jul 2005 02:43:05 -0000
@@ -84,7 +84,7 @@ int avtab_insert(avtab_t * h, avtab_key_
 		if (key->source_type == cur->key.source_type && 
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (datum->specified & cur->datum.specified))
+		    (key->specified & cur->key.specified))
 			return -EEXIST;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -123,7 +123,7 @@ avtab_ptr_t
 		if (key->source_type == cur->key.source_type && 
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (datum->specified & cur->datum.specified))
+		    (key->specified & cur->key.specified))
 			break;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -141,7 +141,7 @@ avtab_ptr_t
 }
 
 avtab_datum_t *
- avtab_search(avtab_t * h, avtab_key_t * key, int specified)
+ avtab_search(avtab_t * h, avtab_key_t * key)
 {
 	int hvalue;
 	avtab_ptr_t cur;
@@ -155,7 +155,7 @@ avtab_datum_t *
 		if (key->source_type == cur->key.source_type && 
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (key->specified & cur->key.specified))
 			return &cur->datum;
 
 		if (key->source_type < cur->key.source_type)
@@ -176,7 +176,7 @@ avtab_datum_t *
  * conjunction with avtab_search_next_node()
  */
 avtab_ptr_t 
- avtab_search_node(avtab_t * h, avtab_key_t * key, int specified)
+ avtab_search_node(avtab_t * h, avtab_key_t * key)
 {
 	int hvalue;
 	avtab_ptr_t cur;
@@ -189,7 +189,7 @@ avtab_ptr_t 
 		if (key->source_type == cur->key.source_type && 
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (key->specified & cur->key.specified))
 			return cur;
 
 		if (key->source_type < cur->key.source_type)
@@ -217,7 +217,7 @@ avtab_ptr_t
 		if (node->key.source_type == cur->key.source_type && 
 		    node->key.target_type == cur->key.target_type &&
 		    node->key.target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			return cur;
 
 		if (node->key.source_type < cur->key.source_type)
@@ -323,67 +323,138 @@ void avtab_hash_eval(avtab_t * h, char *
 	       tag, h->nel, slots_used, AVTAB_SIZE, max_chain_len);
 }
 
-int avtab_read_item(void *fp, avtab_datum_t *avdatum, avtab_key_t *avkey)
+/* Ordering of datums in the original avtab format in the policy file. */
+static uint16_t spec_order[] = {
+	AVTAB_ALLOWED,
+	AVTAB_AUDITDENY,
+	AVTAB_AUDITALLOW,
+	AVTAB_TRANSITION,
+	AVTAB_CHANGE,
+	AVTAB_MEMBER
+};
+
+int avtab_read_item(void *fp, uint32_t vers, avtab_t *a, 
+	            int (*insertf)(avtab_t *a, avtab_key_t *k, 
+				   avtab_datum_t *d, void *p),
+		    void *p)
 {
-	uint32_t *buf;
-	uint32_t items, items2;
+  	uint16_t *buf16, enabled;
+	uint32_t *buf32, items, items2, val;
+	avtab_key_t key;
+	avtab_datum_t datum;
+	unsigned set;
+	int i, rc;
+
+	memset(&key, 0, sizeof(avtab_key_t));
+	memset(&datum, 0, sizeof(avtab_datum_t));
+
+	if (vers < POLICYDB_VERSION_AVTAB) {
+		buf32 = next_entry(fp, sizeof(uint32_t));
+		if (!buf32) {
+			printf("security: avtab: truncated entry\n");
+			return -1;
+		}
+		items2 = le32_to_cpu(buf32[0]);
 
-	memset(avkey, 0, sizeof(avtab_key_t));
-	memset(avdatum, 0, sizeof(avtab_datum_t));
-	
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf) {
-		printf("security: avtab: truncated entry\n");
-		return -1;
+		if (items2 < 5 || items2 > 8) {
+			printf("security: avtab: invalid item count\n");
+			return -1;
+		}
+
+		buf32 = next_entry(fp, sizeof(uint32_t)*items2);
+		if (!buf32) {
+			printf("security: avtab: truncated entry\n");
+			return -1;
+		}
+
+		items = 0;
+		val = le32_to_cpu(buf32[items++]);
+		key.source_type = (uint16_t)val;
+		if (key.source_type != val) {
+			printf("security: avtab: truncated source type\n");
+			return -1;
+		}
+		val = le32_to_cpu(buf32[items++]);
+		key.target_type = (uint16_t)val;
+		if (key.target_type != val) {
+			printf("security: avtab: truncated target type\n");
+			return -1;
+		}
+		val = le32_to_cpu(buf32[items++]);
+		key.target_class = (uint16_t)val;
+		if (key.target_class != val) {
+			printf("security: avtab: truncated target class\n");
+			return -1;
+		}
+
+		val = le32_to_cpu(buf32[items++]);
+		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
+
+		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
+			printf("security: avtab: null entry\n");
+			return -1;
+		}
+		if ((val & AVTAB_AV) &&
+		    (val & AVTAB_TYPE)) {
+			printf("security: avtab: entry has both access vectors and types\n");
+			return -1;
+		}
+
+		for (i = 0; i < sizeof(spec_order)/sizeof(uint16_t); i++) {
+			if (val & spec_order[i]) {
+				key.specified = spec_order[i] | enabled;
+				datum.data = le32_to_cpu(buf32[items++]);
+				rc = insertf(a, &key, &datum, p);
+				if (rc) return rc;
+			}
+		}
+
+		if (items != items2) {
+			printf("security: avtab: entry only had %d items, expected %d\n", items2, items);
+			return -1;
+		}
+		return 0;
 	}
-	items2 = le32_to_cpu(buf[0]);
-	buf = next_entry(fp, sizeof(uint32_t)*items2);
-	if (!buf) {
+	
+	buf16 = next_entry(fp, sizeof(uint16_t)*4);
+	if (!buf16) {
 		printf("security: avtab: truncated entry\n");
 		return -1;
 	}
 	items = 0;
-	avkey->source_type = le32_to_cpu(buf[items++]);
-	avkey->target_type = le32_to_cpu(buf[items++]);
-	avkey->target_class = le32_to_cpu(buf[items++]);
-	avdatum->specified = le32_to_cpu(buf[items++]);
-	if (!(avdatum->specified & (AVTAB_AV | AVTAB_TYPE))) {
-		printf("security: avtab: null entry\n");
-		return -1;
+	key.source_type = le16_to_cpu(buf16[items++]);
+	key.target_type = le16_to_cpu(buf16[items++]);
+	key.target_class = le16_to_cpu(buf16[items++]);
+	key.specified = le16_to_cpu(buf16[items++]);
+
+	set = 0;
+	for (i = 0; i < sizeof(spec_order)/sizeof(uint16_t); i++) {
+			if (key.specified & spec_order[i])
+				set++;
 	}
-	if ((avdatum->specified & AVTAB_AV) &&
-	    (avdatum->specified & AVTAB_TYPE)) {
-		printf("security: avtab: entry has both access vectors and types\n");
+	if (!set || set > 1) {
+		printf("security: avtab: more than one specifier\n");
 		return -1;
 	}
-	if (avdatum->specified & AVTAB_AV) {
-		if (avdatum->specified & AVTAB_ALLOWED)
-			avtab_allowed(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_AUDITDENY) 
-			avtab_auditdeny(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_AUDITALLOW) 
-			avtab_auditallow(avdatum) = le32_to_cpu(buf[items++]);
-	} else {		
-		if (avdatum->specified & AVTAB_TRANSITION)
-			avtab_transition(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_CHANGE)
-			avtab_change(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_MEMBER)
-			avtab_member(avdatum) = le32_to_cpu(buf[items++]);
-	}	
-	if (items != items2) {
-		printf("security: avtab: entry only had %d items, expected %d\n", items2, items);
+		
+	buf32 = next_entry(fp, sizeof(uint32_t));
+	if (!buf32) {
+		printf("security: avtab: truncated entry\n");
 		return -1;
-	}	
-	return 0;
+	}
+	datum.data = le32_to_cpu(*buf32);
+	return insertf(a, &key, &datum, p);
 }
 
-int avtab_read(avtab_t * a, void * fp, uint32_t config __attribute__ ((unused)))
+static int avtab_insertf(avtab_t *a, avtab_key_t *k, avtab_datum_t *d, void *p)
+{
+	return avtab_insert(a, k, d);
+}
+
+int avtab_read(avtab_t * a, void * fp, uint32_t vers)
 {
 	unsigned int i;
 	int rc;
-	avtab_key_t avkey;
-	avtab_datum_t avdatum;
 	uint32_t *buf;
 	uint32_t nel;
 
@@ -399,14 +470,13 @@ int avtab_read(avtab_t * a, void * fp, u
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		if (avtab_read_item(fp, &avdatum, &avkey))
-			goto bad;
-		rc = avtab_insert(a, &avkey, &avdatum);
+		rc = avtab_read_item(fp, vers, a, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				printf("security: avtab: out of memory\n");
 			if (rc == -EEXIST)
 				printf("security: avtab: duplicate entry\n");
+			printf("Failed on entry %d of %u\n", i, nel);
 			goto bad;
 		}
 	}
Index: libsepol/src/conditional.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/conditional.c,v
retrieving revision 1.8
diff -u -p -r1.8 conditional.c
--- libsepol/src/conditional.c	6 Jul 2005 17:24:54 -0000	1.8
+++ libsepol/src/conditional.c	23 Jul 2005 02:25:47 -0000
@@ -34,7 +34,7 @@ static void cond_optimize(cond_av_list_t
 	top = p = cur = *l;
 
 	while(cur) {
-		if ((cur->node->datum.specified & AVTAB_TYPE) && (top != cur)) {
+		if ((cur->node->key.specified & AVTAB_TYPE) && (top != cur)) {
 			p->next = cur->next;
 			cur->next = top;
 			top = cur;
@@ -283,18 +283,18 @@ static int evaluate_cond_node(policydb_t
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur != NULL; cur = cur->next) {
 			if (new_state <= 0) {
-				cur->node->datum.specified &= ~AVTAB_ENABLED;
+				cur->node->key.specified &= ~AVTAB_ENABLED;
 			} else {
-				cur->node->datum.specified |= AVTAB_ENABLED;
+				cur->node->key.specified |= AVTAB_ENABLED;
 			}
 		}
 
 		for (cur = node->false_list; cur != NULL; cur = cur->next) {	
 			/* -1 or 1 */
 			if (new_state) {
-				cur->node->datum.specified &= ~AVTAB_ENABLED;
+				cur->node->key.specified &= ~AVTAB_ENABLED;
 			} else {
-				cur->node->datum.specified |= AVTAB_ENABLED;
+				cur->node->key.specified |= AVTAB_ENABLED;
 			}
 		}
 	}
@@ -551,16 +551,100 @@ err:
 	return -1;
 }
 
-static int cond_read_av_list(policydb_t *p, void *fp, cond_av_list_t **ret_list, cond_av_list_t *other)
+struct cond_insertf_data 
 {
-	cond_av_list_t *list, *last = NULL, *cur;
-	avtab_key_t key;
-	avtab_datum_t datum;
+	struct policydb *p;
+	cond_av_list_t *other;
+	cond_av_list_t *head;
+	cond_av_list_t *tail;
+};
+
+static int cond_insertf(avtab_t *a, avtab_key_t *k, avtab_datum_t *d, void *ptr)
+{
+	struct cond_insertf_data *data = ptr;
+	struct policydb *p = data->p;
+	cond_av_list_t *other = data->other, *list, *cur;
 	avtab_ptr_t node_ptr;
-	int len, i;
-	uint32_t *buf;
 	uint8_t found;
 
+
+	/*
+	 * For type rules we have to make certain there aren't any
+	 * conflicting rules by searching the te_avtab and the
+	 * cond_te_avtab.
+	 */
+	if (k->specified & AVTAB_TYPE) {
+		if (avtab_search(&p->te_avtab, k)) {
+			printf("security: type rule already exists outside of a conditional.");
+			goto err;
+		}
+		/*
+		 * If we are reading the false list other will be a pointer to
+		 * the true list. We can have duplicate entries if there is only
+		 * 1 other entry and it is in our true list.
+		 *
+		 * If we are reading the true list (other == NULL) there shouldn't
+		 * be any other entries.
+		 */
+		if (other) {
+			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
+			if (node_ptr) {
+				if (avtab_search_node_next(node_ptr, k->specified)) {
+					printf("security: too many conflicting type rules.");
+					goto err;
+				}
+				found = 0;
+				for (cur = other; cur != NULL; cur = cur->next) {
+					if (cur->node == node_ptr) {
+						found = 1;
+						break;
+					}
+				}
+				if (!found) {
+					printf("security: conflicting type rules.\n");
+					goto err;
+				}
+			}
+		} else {    
+			if (avtab_search(&p->te_cond_avtab, k)) {
+				printf("security: conflicting type rules when adding type rule for true.\n");
+				goto err;
+			}
+		}
+	}
+
+	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
+	if (!node_ptr) {
+		printf("security: could not insert rule.");
+		goto err;
+	}
+	node_ptr->parse_context = (void*)1;
+
+	list = malloc(sizeof(cond_av_list_t));
+	if (!list)
+		goto err;
+	memset(list, 0, sizeof(cond_av_list_t));
+
+	list->node = node_ptr;
+	if (!data->head)
+		data->head = list;
+	else
+		data->tail->next = list;
+	data->tail = list;
+	return 0;
+
+err:
+	cond_av_list_destroy(data->head);
+	data->head = NULL;
+	return -1;
+}
+
+static int cond_read_av_list(policydb_t *p, void *fp, cond_av_list_t **ret_list, cond_av_list_t *other)
+{
+	int i, rc;
+	uint32_t *buf, len;
+	struct cond_insertf_data data;
+
 	*ret_list = NULL;
 
 	len = 0;
@@ -573,80 +657,19 @@ static int cond_read_av_list(policydb_t 
 		return 0;
 	}
 
+	data.p = p;
+	data.other = other;
+	data.head = NULL;
+	data.tail = NULL;
 	for (i = 0; i < len; i++) {
-		if (avtab_read_item(fp, &datum, &key))
-			goto err;
-
-		/*
-		 * For type rules we have to make certain there aren't any
-		 * conflicting rules by searching the te_avtab and the
-		 * cond_te_avtab.
-		 */
-		if (datum.specified & AVTAB_TYPE) {
-			if (avtab_search(&p->te_avtab, &key, AVTAB_TYPE)) {
-				printf("security: type rule already exists outside of a conditional.");
-				goto err;
-			}
-			/*
-			 * If we are reading the false list other will be a pointer to
-			 * the true list. We can have duplicate entries if there is only
-			 * 1 other entry and it is in our true list.
-			 *
-			 * If we are reading the true list (other == NULL) there shouldn't
-			 * be any other entries.
-			 */
-			if (other) {
-				node_ptr = avtab_search_node(&p->te_cond_avtab, &key, AVTAB_TYPE);
-				if (node_ptr) {
-					if (avtab_search_node_next(node_ptr, AVTAB_TYPE)) {
-						printf("security: too many conflicting type rules.");
-						goto err;
-					}
-					found = 0;
-					for (cur = other; cur != NULL; cur = cur->next) {
-						if (cur->node == node_ptr) {
-							found = 1;
-							break;
-						}
-					}
-					if (!found) {
-						printf("security: conflicting type rules.\n");
-						goto err;
-					}
-				}
-			} else {    
-				if (avtab_search(&p->te_cond_avtab, &key, AVTAB_TYPE)) {
-					printf("security: conflicting type rules when adding type rule for true.\n");
-					goto err;
-				}
-			}
-		}
-		node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, &key, &datum);
-		if (!node_ptr) {
-			printf("security: could not insert rule.");
-			goto err;
-		}
-		node_ptr->parse_context = (void*)1;
-
-		list = malloc(sizeof(cond_av_list_t));
-		if (!list)
-			goto err;
-		memset(list, 0, sizeof(cond_av_list_t));
-
-		list->node = node_ptr;
-		if (i == 0)
-			*ret_list = list;
-		else
-			last->next = list;
-		last = list;
+		rc = avtab_read_item(fp, p->policyvers, &p->te_cond_avtab, cond_insertf, &data);
+		if (rc)
+			return rc;
 
 	}
 
+	*ret_list = data.head;
 	return 0;
-err:
-	cond_av_list_destroy(*ret_list);
-	*ret_list = NULL;
-	return -1;
 }
 
 static int expr_isvalid(policydb_t *p, cond_expr_t *expr)
@@ -769,22 +792,22 @@ void cond_compute_av(avtab_t *ctab, avta
 	if(!ctab || !key || !avd) 
 		return;
 		
-	for(node = avtab_search_node(ctab, key, AVTAB_AV); node != NULL; 
-				node = avtab_search_node_next(node, AVTAB_AV)) {
-		if ( (uint32_t) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
-			avd->allowed |= avtab_allowed(&node->datum);
-		if ( (uint32_t) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+	for(node = avtab_search_node(ctab, key); node != NULL; 
+				node = avtab_search_node_next(node, key->specified)) {
+		if ( (uint16_t) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+			avd->allowed |= node->datum.data;
+		if ( (uint16_t) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
 			/* Since a '0' in an auditdeny mask represents a 
 			 * permission we do NOT want to audit (dontaudit), we use
 			 * the '&' operand to ensure that all '0's in the mask
 			 * are retained (much unlike the allow and auditallow cases).
 			 */
-			avd->auditdeny &= avtab_auditdeny(&node->datum);
-		if ( (uint32_t) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
-			avd->auditallow |= avtab_auditallow(&node->datum);
+			avd->auditdeny &= node->datum.data;
+		if ( (uint16_t) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+			avd->auditallow |= node->datum.data;
 	}
 	return;	
 }
Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.1
diff -u -p -r1.1 expand.c
--- libsepol/src/expand.c	6 Jul 2005 17:24:54 -0000	1.1
+++ libsepol/src/expand.c	23 Jul 2005 02:25:47 -0000
@@ -808,20 +808,15 @@ static int copy_role_trans(expand_state_
 /* Search for an AV tab node within a hash table with the given key.
  * If the node does not exist, create it and return it; otherwise
  * return the pre-existing one.
- *
- * When looking for the existing node, use 'lookup_specified' as part
- * of the lookup key.  If doesn't exist, then create it, but instead
- * set the node's specified field to 'real_specified'.
 */
 static avtab_ptr_t find_avtab_node(avtab_t *avtab, avtab_key_t *key,
-                                   uint32_t lookup_specified, uint32_t real_specified,
                                    cond_av_list_t **cond)
 {               
         avtab_ptr_t node;
         avtab_datum_t avdatum;
         cond_av_list_t *nl;
 
-        node = avtab_search_node(avtab, key, lookup_specified);
+        node = avtab_search_node(avtab, key);
 
         /* If this is for conditional policies, keep searching in case
            the node is part of my conditional avtab. */
@@ -829,13 +824,12 @@ static avtab_ptr_t find_avtab_node(avtab
                 while (node) {
                         if (node->parse_context == cond)
                                 break;
-                        node = avtab_search_node_next(node, lookup_specified);
+                        node = avtab_search_node_next(node, key->specified);
                 }
         }
 
         if (!node) {
                 memset(&avdatum, 0, sizeof avdatum);
-                avdatum.specified = real_specified;
                 /* this is used to get the node - insertion is actually unique */
                 node = avtab_insert_nonunique(avtab, key, &avdatum);
                 if (!node) {
@@ -887,16 +881,17 @@ static int expand_terule_helper(policydb
                 avkey.source_type = stype + 1;
                 avkey.target_type = ttype + 1;
                 avkey.target_class = cur->class;
+		avkey.specified = spec;
 
                 conflict = 0;
                 /* check to see if the expanded TE already exists --
                  * either in the global scope or in another
                  * conditional AV tab */
-                node = avtab_search_node(&p->te_avtab, &avkey, spec);
+                node = avtab_search_node(&p->te_avtab, &avkey);
                 if (node) {
                         conflict = 1;
                 } else {
-                        node = avtab_search_node(&p->te_cond_avtab, &avkey, spec);
+                        node = avtab_search_node(&p->te_cond_avtab, &avkey);
                         if (node && node->parse_context != other) {
                                 conflict = 2;
                         }
@@ -905,11 +900,11 @@ static int expand_terule_helper(policydb
                 if (conflict) {
                         avdatump = &node->datum;
                         if (specified & AVRULE_TRANSITION) {
-                                oldtype = avtab_transition(avdatump);
+                                oldtype = avdatump->data;
                         } else if (specified & AVRULE_MEMBER) {
-                                oldtype = avtab_member(avdatump);
+                                oldtype = avdatump->data;
                         } else if (specified & AVRULE_CHANGE) {
-                                oldtype = avtab_change(avdatump);
+                                oldtype = avdatump->data;
                         }
                         /* ignore duplicates */
                         
@@ -943,28 +938,23 @@ static int expand_terule_helper(policydb
 	                        return 0;
                 }
 
-                /* the upstream compiler does not collapse multiple AV
-                   rules into a single one for those given within
-                   conditionals */
-                node = find_avtab_node(avtab, &avkey,
-                                       (cond == NULL ? AVTAB_TYPE : spec),
-                                       spec, cond);
+                node = find_avtab_node(avtab, &avkey, cond);
                 if (!node)
                         return -1;
-                avdatump = &node->datum;
-                if (enabled) {
-                        avdatump->specified |= AVTAB_ENABLED;
+                 if (enabled) {
+                        node->key.specified |= AVTAB_ENABLED;
                 }
                 else {
-                        avdatump->specified &= ~AVTAB_ENABLED;
+                        node->key.specified &= ~AVTAB_ENABLED;
                 }
 
+               avdatump = &node->datum;
                 if (specified & AVRULE_TRANSITION) {
-                        avtab_transition(avdatump) = remapped_data;
+                        avdatump->data = remapped_data;
                 } else if (specified & AVRULE_MEMBER) {
-                        avtab_member(avdatump) = remapped_data;
+                        avdatump->data = remapped_data;
                 } else if (specified & AVRULE_CHANGE) {
-                        avtab_change(avdatump) = remapped_data;
+                        avdatump->data = remapped_data;
                 } else {
                         assert(0);   /* should never occur */
                 }
@@ -1003,28 +993,23 @@ static int expand_avrule_helper(uint32_t
                 avkey.source_type = stype + 1;
                 avkey.target_type = ttype + 1;
                 avkey.target_class = cur->class;
+		avkey.specified = spec;
 
-                /* the upstream compiler does not collapse multiple AV
-                   rules into a single one for those given within
-                   conditionals */
-                node = find_avtab_node(avtab, &avkey,
-                                       (cond == NULL ? AVTAB_AV : spec),
-                                       spec, cond);
+                node = find_avtab_node(avtab, &avkey, cond);
                 if (!node)
                         return -1;
-                avdatump = &node->datum;
-                avdatump->specified |= spec;
                 if (enabled) {
-                        avdatump->specified |= AVTAB_ENABLED;
+                        node->key.specified |= AVTAB_ENABLED;
                 }
                 else {
-                        avdatump->specified &= ~AVTAB_ENABLED;
+                        node->key.specified &= ~AVTAB_ENABLED;
                 }
 
+                avdatump = &node->datum;
                 if (specified & AVRULE_ALLOWED) {
-                        avtab_allowed(avdatump) |= cur->data;
+                        avdatump->data |= cur->data;
                 } else if (specified & AVRULE_AUDITALLOW) {
-                        avtab_auditallow(avdatump) |= cur->data;
+                        avdatump->data |= cur->data;
                 } else if (specified & AVRULE_AUDITDENY) {
                         /* Since a '0' in an auditdeny mask represents
                          * a permission we do NOT want to audit
@@ -1033,12 +1018,12 @@ static int expand_avrule_helper(uint32_t
                          * retained (much unlike the allow and
                          * auditallow cases).
                          */
-                        avtab_auditdeny(avdatump) &= cur->data;
+                        avdatump->data &= cur->data;
                 } else if (specified & AVRULE_DONTAUDIT) {
-                        if (avtab_auditdeny(avdatump))
-                                avtab_auditdeny(avdatump) &= ~cur->data;
+                        if (avdatump->data)
+                                avdatump->data &= ~cur->data;
                         else
-                                avtab_auditdeny(avdatump) = ~cur->data;
+                                avdatump->data = ~cur->data;
                 } else {
                         assert(0);   /* should never occur */
                 }
Index: libsepol/src/hierarchy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/hierarchy.c,v
retrieving revision 1.5
diff -u -p -r1.5 hierarchy.c
--- libsepol/src/hierarchy.c	18 Jul 2005 13:51:21 -0000	1.5
+++ libsepol/src/hierarchy.c	23 Jul 2005 02:25:47 -0000
@@ -127,7 +127,7 @@ static int check_avtab_hierarchy_callbac
 	uint32_t av;
 	type_datum_t *t = NULL, *t2 = NULL;
 	
-       if (!(d->specified & AVTAB_AV)) {
+       if (!(k->specified & AVTAB_AV)) {
                /* This is a type rule, no checking done */
                return 0;
        }
@@ -151,21 +151,22 @@ static int check_avtab_hierarchy_callbac
 		key.source_type = t->value;
 		key.target_type = k->target_type;
 		key.target_class = k->target_class;
+		key.specified = AVTAB_ALLOWED;
 	
-		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		avdatump = avtab_search(&a->p->te_avtab, &key);
 		if (avdatump) {
 			/* search for access allowed between type 1's parent and type 2 */
-			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+			if ((avdatump->data & d->data) == d->data) {
 				return 0;
 			}
-			av = avtab_allowed(avdatump);
+			av = avdatump->data;
 		} else 
 			av = 0;
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);
 			if (avdatump) {
-				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+				if (((av | avdatump->data) & d->data) == d->data) {
 					return 0;
 				}
 			}			
@@ -189,20 +190,21 @@ static int check_avtab_hierarchy_callbac
 		key.source_type = k->source_type;
 		key.target_type = t2->value;
 		key.target_class = k->target_class;
+		key.specified = AVTAB_ALLOWED;
 		
-		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		avdatump = avtab_search(&a->p->te_avtab, &key);
 		if (avdatump) {
-			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+			if ((avdatump->data & d->data) == d->data) {
 				return 0;
 			}
-			av = avtab_allowed(avdatump);
+			av = avdatump->data;
 		} else 
 			av = 0;
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);
 			if (avdatump) {
-				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+				if (((av | avdatump->data) & d->data) == d->data) {
 					return 0;
 				}
 			}			
@@ -213,20 +215,21 @@ static int check_avtab_hierarchy_callbac
 		key.source_type = t->value;
 		key.target_type = t2->value;
 		key.target_class = k->target_class;
+		key.specified = AVTAB_ALLOWED;
 	
-		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		avdatump = avtab_search(&a->p->te_avtab, &key);
 		if (avdatump) {
-			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+			if ((avdatump->data & d->data) == d->data) {
 				return 0;
 			}
-			av = avtab_allowed(avdatump);
+			av = avdatump->data;
 		} else 
 			av = 0;
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);
 			if (avdatump) {
-				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+				if (((av | avdatump->data) & d->data) == d->data) {
 					return 0;
 				}
 			}
Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.12
diff -u -p -r1.12 policydb.c
--- libsepol/src/policydb.c	13 Jul 2005 19:16:59 -0000	1.12
+++ libsepol/src/policydb.c	23 Jul 2005 02:25:47 -0000
@@ -85,6 +85,12 @@ static struct policydb_compat_info polic
 		.ocon_num	= OCON_NODE6 + 1,
 	},
 	{
+		.type		= POLICY_KERN,
+		.version	= POLICYDB_VERSION_AVTAB,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NODE6 + 1,
+	},
+	{
 		.type		= POLICY_BASE,
 		.version 	= POLICYDB_VERSION_MAX,
 		.sym_num	= SYM_NUM,
@@ -2567,7 +2573,7 @@ int policydb_read(policydb_t * p, struct
 	}
         
 	if (policy_type == POLICY_KERN) {
-		if (avtab_read(&p->te_avtab, fp, config))
+		if (avtab_read(&p->te_avtab, fp, r_policyvers))
 			goto bad;
 		if (r_policyvers >= POLICYDB_VERSION_BOOL)
 			if (cond_read_list(p, &p->cond_list, fp))
Index: libsepol/src/private.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/private.h,v
retrieving revision 1.8
diff -u -p -r1.8 private.h
--- libsepol/src/private.h	13 Jul 2005 19:17:00 -0000	1.8
+++ libsepol/src/private.h	23 Jul 2005 02:25:47 -0000
@@ -7,11 +7,15 @@
 #include <sepol/policydb.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(x) (x)
+#define le16_to_cpu(x) (x)
 #define cpu_to_le32(x) (x)
 #define le32_to_cpu(x) (x)
 #define cpu_to_le64(x) (x)
 #define le64_to_cpu(x) (x)
 #else
+#define cpu_to_le16(x) bswap_16(x)
+#define le16_to_cpu(x) bswap_16(x)
 #define cpu_to_le32(x) bswap_32(x)
 #define le32_to_cpu(x) bswap_32(x)
 #define cpu_to_le64(x) bswap_64(x)
Index: libsepol/src/services.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/services.c,v
retrieving revision 1.14
diff -u -p -r1.14 services.c
--- libsepol/src/services.c	6 Jul 2005 17:24:55 -0000	1.14
+++ libsepol/src/services.c	23 Jul 2005 02:25:47 -0000
@@ -303,8 +303,8 @@ static int context_struct_compute_av(con
 	constraint_node_t *constraint;
 	struct role_allow *ra;
 	avtab_key_t avkey;
-	avtab_datum_t *avdatum;
 	class_datum_t *tclass_datum;
+	avtab_ptr_t node;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
 		printf("security_compute_av:  unrecognized class %d\n",
@@ -330,14 +330,16 @@ static int context_struct_compute_av(con
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb->te_avtab, &avkey, AVTAB_AV);
-	if (avdatum) {
-		if (avdatum->specified & AVTAB_ALLOWED)
-			avd->allowed = avtab_allowed(avdatum);
-		if (avdatum->specified & AVTAB_AUDITDENY)
-			avd->auditdeny = avtab_auditdeny(avdatum);
-		if (avdatum->specified & AVTAB_AUDITALLOW)
-			avd->auditallow = avtab_auditallow(avdatum);
+	avkey.specified = AVTAB_AV;
+	for (node = avtab_search_node(&policydb->te_avtab, &avkey);
+	     node != NULL;
+	     node = avtab_search_node_next(node, avkey.specified)) {
+		if (node->key.specified == AVTAB_ALLOWED)
+			avd->allowed = node->datum.data;
+		else if (node->key.specified == AVTAB_AUDITALLOW)
+			avd->auditallow = node->datum.data;
+		else if (node->key.specified == AVTAB_AUDITDENY)
+			avd->auditdeny = node->datum.data;
 	}
 
 	/* Check conditional av table for additional permissions */
@@ -704,7 +706,6 @@ static int sepol_compute_sid(sepol_secur
 	avtab_key_t avkey;
 	avtab_datum_t *avdatum;
 	avtab_ptr_t node;
-	unsigned int type_change = 0;
 	int rc = 0;
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
@@ -753,33 +754,23 @@ static int sepol_compute_sid(sepol_secur
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb->te_avtab, &avkey, AVTAB_TYPE);
+	avkey.specified = specified;
+	avdatum = avtab_search(&policydb->te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
 	if(!avdatum) {
-		node = avtab_search_node(&policydb->te_cond_avtab, &avkey, specified);
+		node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
 		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
-			if (node->datum.specified & AVTAB_ENABLED) {
+			if (node->key.specified & AVTAB_ENABLED) {
 				avdatum = &node->datum;
 				break;
 			}
 		}
 	}
 
-	type_change = (avdatum && (avdatum->specified & specified));
-	if (type_change) {
+	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		switch (specified) {
-		case AVTAB_TRANSITION:
-			newcontext.type = avtab_transition(avdatum);
-			break;
-		case AVTAB_MEMBER:
-			newcontext.type = avtab_member(avdatum);
-			break;
-		case AVTAB_CHANGE:
-			newcontext.type = avtab_change(avdatum);
-			break;
-		}
+		newcontext.type = avdatum->data;
 	}
 
 	/* Check for class-specific changes. */
Index: libsepol/src/write.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/write.c,v
retrieving revision 1.10
diff -u -p -r1.10 write.c
--- libsepol/src/write.c	6 Jul 2005 17:24:55 -0000	1.10
+++ libsepol/src/write.c	23 Jul 2005 03:04:00 -0000
@@ -128,46 +128,147 @@ static int ebitmap_write(ebitmap_t * e, 
 	return 0;
 }
 
-static int avtab_write_item(avtab_ptr_t cur, struct policy_file *fp)
-{
-	uint32_t buf[32];
+/* Ordering of datums in the original avtab format in the policy file. */
+static uint16_t spec_order[] = {
+	AVTAB_ALLOWED,
+	AVTAB_AUDITDENY,
+	AVTAB_AUDITALLOW,
+	AVTAB_TRANSITION,
+	AVTAB_CHANGE,
+	AVTAB_MEMBER
+};
+
+static int avtab_write_item(avtab_ptr_t cur, struct policy_file *fp, 
+	                    unsigned merge, unsigned commit,
+			    uint32_t *nel)
+{
+	avtab_ptr_t node;
+	uint16_t buf16[4];
+	uint32_t buf32[10], lookup, val;
 	size_t items, items2;
+	unsigned set;
+	int i;
 
-	items = 1;	/* item 0 is used for the item count */
-	buf[items++] = cpu_to_le32(cur->key.source_type);
-	buf[items++] = cpu_to_le32(cur->key.target_type);
-	buf[items++] = cpu_to_le32(cur->key.target_class);
-	buf[items++] = cpu_to_le32(cur->datum.specified);
-	if (!(cur->datum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-		printf("security: avtab: null entry\n");
-		return -1;
-	}
-	if ((cur->datum.specified & AVTAB_AV) &&
-	    (cur->datum.specified & AVTAB_TYPE)) {
-		printf("security: avtab: entry has both access vectors and types\n");
-		return -1;
-	}
-	if (cur->datum.specified & AVTAB_AV) {
-		if (cur->datum.specified & AVTAB_ALLOWED)
-			buf[items++] = cpu_to_le32(avtab_allowed(&cur->datum));
-		if (cur->datum.specified & AVTAB_AUDITDENY)
-			buf[items++] = cpu_to_le32(avtab_auditdeny(&cur->datum));
-		if (cur->datum.specified & AVTAB_AUDITALLOW)
-			buf[items++] = cpu_to_le32(avtab_auditallow(&cur->datum));
-	} else {
-		if (cur->datum.specified & AVTAB_TRANSITION)
-			buf[items++] = cpu_to_le32(avtab_transition(&cur->datum));
-		if (cur->datum.specified & AVTAB_CHANGE)
-			buf[items++] = cpu_to_le32(avtab_change(&cur->datum));
-		if (cur->datum.specified & AVTAB_MEMBER)
-			buf[items++] = cpu_to_le32(avtab_member(&cur->datum));
+	if (policyvers < POLICYDB_VERSION_AVTAB) {
+		/* Generate the old avtab format.
+		   Requires merging similar entries if uncond avtab. */
+		if (merge) {
+			if (cur->merged)
+				return 0; /* already merged by prior merge */
+		}
+
+		items = 1;	/* item 0 is used for the item count */
+		val = cur->key.source_type;
+		buf32[items++] = cpu_to_le32(val);
+		val = cur->key.target_type;
+		buf32[items++] = cpu_to_le32(val);
+		val = cur->key.target_class;
+		buf32[items++] = cpu_to_le32(val);
+
+		val = cur->key.specified & ~AVTAB_ENABLED;
+		if (cur->key.specified & AVTAB_ENABLED)
+			val |= AVTAB_ENABLED_OLD;
+		set = 1;
+
+		if (merge) {
+			/* Merge specifier values for all similar (av or type)
+			   entries that have the same key. */
+			if (val & AVTAB_AV) 
+				lookup = AVTAB_AV;
+			else if (val & AVTAB_TYPE)
+				lookup = AVTAB_TYPE;
+			else
+				return -1;
+			for (node = avtab_search_node_next(cur, lookup); 
+			     node; node = avtab_search_node_next(node, lookup)) {
+				val |= (node->key.specified & ~AVTAB_ENABLED);
+				set++;
+				if (node->key.specified & AVTAB_ENABLED)
+					val |= AVTAB_ENABLED_OLD;
+			}
+		}
+
+		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
+			printf("security: avtab: null entry\n");
+			return -1;
+		}
+		if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
+			printf("security:  avtab:  entry has both access vectors and types\n");
+			return -1;
+		}
+
+		buf32[items++] = cpu_to_le32(val);
+
+		if (merge) {
+			/* Include datums for all similar (av or type)
+			   entries that have the same key. */
+			for (i = 0; 
+			     i < (sizeof(spec_order)/sizeof(spec_order[0]));
+			     i++) {
+				if (val & spec_order[i]) {
+					if (cur->key.specified & spec_order[i])
+						node = cur;
+					else {
+						node = avtab_search_node_next(cur, spec_order[i]);
+						if (nel)
+							(*nel)--; /* one less node */
+					}
+
+					if (!node) {
+						printf("security:  avtab:  missing node\n");
+						return -1;
+					}
+					buf32[items++] = cpu_to_le32(node->datum.data);
+					set--;
+					node->merged = 1;
+				}
+			}
+		} else {
+			buf32[items++] = cpu_to_le32(cur->datum.data);
+			cur->merged = 1;
+			set--;
+		}
+
+		if (set) {
+			printf("security:  avtab:  data count wrong\n");
+			return -1;
+		}
+
+		buf32[0] = cpu_to_le32(items - 1);
+
+		if (commit) {
+			/* Commit this item to the policy file. */
+			items2 = put_entry(buf32, sizeof(uint32_t), items, fp);
+			if (items != items2)
+				return -1;
+		}
+
+		return 0;
 	}
-	buf[0] = cpu_to_le32(items - 1);
-	
-	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-	if (items != items2)
+
+	/* Generate the new avtab format. */
+	buf16[0] = cpu_to_le16(cur->key.source_type);
+	buf16[1] = cpu_to_le16(cur->key.target_type);
+	buf16[2] = cpu_to_le16(cur->key.target_class);
+	buf16[3] = cpu_to_le16(cur->key.specified);
+	items = put_entry(buf16, sizeof(uint16_t), 4, fp);
+	if (items != 4)
 		return -1;
-	return 0;
+	buf32[0] = cpu_to_le32(cur->datum.data);
+	items = put_entry(buf32, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+ 	return 0;
+}
+
+static inline void avtab_reset_merged(avtab_t *a)
+{
+	int i;
+	avtab_ptr_t cur;
+	for (i = 0; i < AVTAB_SIZE; i++) {
+		for (cur = a->htable[i]; cur; cur = cur->next)
+			cur->merged = 0;
+	}
 }
 
 static int avtab_write(avtab_t * a, struct policy_file * fp)
@@ -176,19 +277,48 @@ static int avtab_write(avtab_t * a, stru
 	avtab_ptr_t cur;
 	uint32_t nel;
 	size_t items;
+	unsigned int oldvers = policyvers < POLICYDB_VERSION_AVTAB;
 
-	nel = cpu_to_le32(a->nel);
-	items = put_entry(&nel, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return -1;
+
+	if (oldvers) {
+		/* Old avtab format.
+		   Requires merging similar entries, so need to
+		   track merged ones and compute the final nel. */
+		avtab_reset_merged(a);
+		nel = a->nel;
+	} else {
+		/* New avtab format.  nel is good to go. */
+		nel = cpu_to_le32(a->nel);
+		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return -1;
+	}
 
 	for (i = 0; i < AVTAB_SIZE; i++) {
 		for (cur = a->htable[i]; cur; cur = cur->next) {
-			if (avtab_write_item(cur, fp))
+			/* If old format, compute final nel.
+			   If new format, write out the items. */
+			if (avtab_write_item(cur, fp, 1, !oldvers, &nel))
 			    return -1;
 		}	
 	}
 
+	if (oldvers) {
+		/* Old avtab format.
+		   Write the computed nel value, then write the items. */
+		nel = cpu_to_le32(nel);
+		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return -1;
+		avtab_reset_merged(a);
+		for (i = 0; i < AVTAB_SIZE; i++) {
+			for (cur = a->htable[i]; cur; cur = cur->next) {
+				if (avtab_write_item(cur, fp, 1, 1, NULL))
+					return -1;
+			}	
+		}
+	}
+
 	return 0;
 }
 
@@ -434,7 +564,7 @@ static int cond_write_av_list(cond_av_li
 
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
-			if (avtab_write_item(cur_list->node, fp))
+			if (avtab_write_item(cur_list->node, fp, 0, 1, NULL))
 				return -1;
 	}
 	return 0;


-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
