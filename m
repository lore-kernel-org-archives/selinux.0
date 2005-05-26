Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QIUbgA006727
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:30:37 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QIPDmU007728
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 18:25:13 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4QIQOiH024358
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:26:24 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4QIQOZi024357
	for selinux@tycho.nsa.gov; Thu, 26 May 2005 14:26:24 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QHWUgA006175
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 13:32:30 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QHR6mU002724
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 17:27:06 GMT
Subject: [Patch 1/3] Loadable policy module infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Thu, 26 May 2005 13:27:02 -0400
Message-Id: <1117128423.3483.19.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -burNd a1/libsepol/include/sepol/avtab.h b/libsepol/include/sepol/avtab.h
--- a1/libsepol/include/sepol/avtab.h	2005-05-25 13:15:54.656228856 -0400
+++ b/libsepol/include/sepol/avtab.h	2005-05-25 13:11:20.056974288 -0400
@@ -101,9 +101,6 @@
 
 avtab_ptr_t avtab_insert_nonunique(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum);
 
-avtab_ptr_t avtab_insert_with_parse_context(avtab_t *h, avtab_key_t *key,
-					    avtab_datum_t *datum, void *parse_context);
-
 avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key, int specified);
 
 avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
diff -burNd a1/libsepol/include/sepol/conditional.h b/libsepol/include/sepol/conditional.h
--- a1/libsepol/include/sepol/conditional.h	2005-05-25 13:15:54.657228704 -0400
+++ b/libsepol/include/sepol/conditional.h	2005-05-25 13:11:19.383076736 -0400
@@ -74,27 +74,34 @@
 typedef struct cond_node {
 	int cur_state;
 	cond_expr_t *expr;
+	/* these true/false lists point into te_avtab when that is used */
+	cond_av_list_t *true_list;
+	cond_av_list_t *false_list;
+	/* and these are using during parsing and for modules */
+	avrule_t *avtrue_list;
+	avrule_t *avfalse_list;
 	/* these fields are not written to binary policy */
 	int nbools;
 	uint32_t bool_ids[COND_MAX_BOOLS];
 	uint32_t expr_pre_comp;
 	/*                                               */
-	cond_av_list_t *true_list;
-	cond_av_list_t *false_list;
 	struct cond_node *next;
 } cond_node_t;
 
 int cond_evaluate_expr(policydb_t *p, cond_expr_t *expr);
+cond_expr_t *cond_copy_expr(cond_expr_t *expr);
 
 int cond_normalize_expr(policydb_t *p, cond_node_t *cn);
-cond_node_t *cond_node_search(policydb_t *p,cond_node_t *cn);
+void cond_node_destroy(cond_node_t *node);
+cond_node_t *cond_node_search(policydb_t *p, cond_node_t *list ,cond_node_t *cn);
 int evaluate_conds(policydb_t *p);
-avtab_datum_t *cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list);
 
 void cond_optimize_lists(cond_list_t *cl);
+avtab_datum_t *cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list);
 
 int cond_policydb_init(policydb_t* p);
 void cond_policydb_destroy(policydb_t* p);
+void cond_list_destroy(cond_list_t *list);
 
 int cond_init_bool_indexes(policydb_t* p);
 int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p);
@@ -102,7 +109,7 @@
 int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap);
 
 int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp);
-int cond_read_list(policydb_t *p, void *fp);
+int cond_read_list(policydb_t *p, cond_list_t **list, void *fp);
 
 void cond_compute_av(avtab_t *ctab, avtab_key_t *key, struct sepol_av_decision *avd);
 
diff -burNd a1/libsepol/include/sepol/ebitmap.h b/libsepol/include/sepol/ebitmap.h
--- a1/libsepol/include/sepol/ebitmap.h	2005-05-25 13:14:59.135669264 -0400
+++ b/libsepol/include/sepol/ebitmap.h	2005-05-25 13:11:19.706027640 -0400
@@ -47,6 +47,7 @@
 
 int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2);
 int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
+int ebitmap_or_eq(ebitmap_t *dst, ebitmap_t *e1);
 int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src);
 int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2);
 int ebitmap_get_bit(ebitmap_t * e, unsigned int bit);
diff -burNd a1/libsepol/include/sepol/expand.h b/libsepol/include/sepol/expand.h
--- a1/libsepol/include/sepol/expand.h	1969-12-31 19:00:00.000000000 -0500
+++ b/libsepol/include/sepol/expand.h	2005-05-25 13:11:20.464912272 -0400
@@ -0,0 +1,40 @@
+/* Authors: Jason Tang <jtang@tresys.com>
+ *	    Joshua Brindle <jbrindle@tresys.com>
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * A set of utility functions that aid policy decision when dealing
+ * with hierarchal items.
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <sepol/conditional.h>
+
+#ifndef _SEPOL_EXPAND_H
+#define _SEPOL_EXPAND_H
+
+int expand_module(policydb_t *base, policydb_t *out,
+                        int verbose, char *error_buf, size_t error_buf_size);
+int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types);
+int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p);
+int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p);
+int expand_rule(policydb_t *source_pol,
+                avrule_t *source_rule, avtab_t *dest_avtab,
+                cond_av_list_t **cond, cond_av_list_t **other,
+                int enabled, char **error_msg);
+
+#endif
diff -burNd a1/libsepol/include/sepol/flask_types.h b/libsepol/include/sepol/flask_types.h
--- a1/libsepol/include/sepol/flask_types.h	2005-05-25 13:14:59.310642664 -0400
+++ b/libsepol/include/sepol/flask_types.h	2005-05-25 13:11:20.326933248 -0400
@@ -43,9 +43,11 @@
  * generated header file flask.h.
  */
 typedef uint16_t sepol_security_class_t;
+
 #define SEPOL_SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c 
+#define SELINUX_MOD_MAGIC 0xf97cff8d
 
 typedef uint32_t sepol_security_id_t;
 #define SEPOL_SECSID_NULL 0
diff -burNd a1/libsepol/include/sepol/hierarchy.h b/libsepol/include/sepol/hierarchy.h
--- a1/libsepol/include/sepol/hierarchy.h	2005-05-25 13:15:54.657228704 -0400
+++ b/libsepol/include/sepol/hierarchy.h	2005-05-25 13:11:19.945991160 -0400
@@ -1,6 +1,5 @@
 /* Authors: Jason Tang <jtang@tresys.com>
  *	    Joshua Brindle <jbrindle@tresys.com>
- *          Karl MacMillan <kmacmillan@tresys.com>
  *
  * A set of utility functions that aid policy decision when dealing
  * with hierarchal items.
@@ -22,12 +21,10 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef _HIERARCHY_H_
-#define _HIERARCHY_H_
-
-#include <sepol/avtab.h>
-#include <sepol/hashtab.h>
-
-int hierarchy_check_constraints(policydb_t *p, char *error_msg, uint32_t error_len);
+#ifndef _SEPOL_HIERARCHY_H
+#define _SEPOL_HIERARCHY_H_
 
+int hierarchy_is_valid_name (char *);
+int hierarchy_check_constraints(policydb_t *p, char *error_msg,
+                                uint32_t error_len);
 #endif
diff -burNd a1/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
--- a1/libsepol/include/sepol/policydb.h	2005-05-25 13:15:54.659228400 -0400
+++ b/libsepol/include/sepol/policydb.h	2005-05-25 13:11:19.429069744 -0400
@@ -2,6 +2,12 @@
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /*
+ * Updated: Joshua Brindle <jbrindle@tresys.com>
+ *	    Karl MacMillan <kmacmillan@tresys.com>
+ *	    Jason Tang <jtang@tresys.com>
+ *	    
+ *	Module support
+ *
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
  *	Support for enhanced MLS infrastructure.
@@ -63,6 +69,22 @@
  * users, roles, types, sensitivities, categories, etc.
  */
 
+/* type set preserves data needed by modules such as *, ~ and attributes */
+typedef struct type_set {
+	ebitmap_t types;
+	ebitmap_t negset;
+#define TYPE_STAR 1
+#define TYPE_COMP 2
+	uint32_t flags;
+} type_set_t;
+
+typedef struct role_set {
+	ebitmap_t roles;
+#define ROLE_STAR 1
+#define ROLE_COMP 2
+	uint32_t flags;
+} role_set_t;
+
 /* Permission attributes */
 typedef struct perm_datum {
 	uint32_t value;		/* permission bit + 1 */
@@ -88,7 +110,7 @@
 typedef struct role_datum {
 	uint32_t value;		/* internal role value */
 	ebitmap_t dominates;	/* set of roles dominated by this role */
-	ebitmap_t types;	/* set of authorized types for role */
+	type_set_t types;	/* set of authorized types for role */
 } role_datum_t;
 
 typedef struct role_trans {
@@ -112,12 +134,13 @@
 	unsigned char isattr;   /* is this a type attribute? */
 	ebitmap_t types;        /* types with this attribute */
 #endif
+        uint32_t order;         /* order of appearance within source policy */
 } type_datum_t;
 
 /* User attributes */
 typedef struct user_datum {
 	uint32_t value;		/* internal user value */
-	ebitmap_t roles;	/* set of authorized roles for user */
+	role_set_t roles;	/* set of authorized roles for user */
 	mls_range_t range;	/* MLS range (min. - max.) for user */
 	mls_level_t dfltlevel;	/* default login MLS level for user */
         unsigned defined;
@@ -152,6 +175,50 @@
 struct cond_node;
 
 typedef struct cond_node cond_list_t;
+struct cond_av_list;
+
+typedef struct class_perm_node {
+	uint32_t class;
+	uint32_t data; /* permissions or new type */
+	struct class_perm_node *next;
+} class_perm_node_t; 
+
+typedef struct avrule {
+/* these typedefs are almost exactly the same as those in avtab.h - they are
+ * here because of the need to include neverallow and dontaudit messages */
+#define AVRULE_ALLOWED     1
+#define AVRULE_AUDITALLOW  2
+#define AVRULE_AUDITDENY   4
+#define AVRULE_DONTAUDIT   8
+#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT)
+#define AVRULE_TRANSITION 16
+#define AVRULE_MEMBER     32
+#define AVRULE_CHANGE     64
+#define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
+#define AVRULE_NEVERALLOW 128
+        uint32_t specified;
+#define RULE_SELF 1
+        uint32_t flags;
+        type_set_t stypes;
+        type_set_t ttypes;
+        class_perm_node_t *perms;
+        unsigned long line;  /* line number from policy.conf where
+                              * this rule originated  */
+        struct avrule *next;
+} avrule_t;
+
+typedef struct role_trans_rule {
+        role_set_t roles; /* current role */
+        type_set_t types; /* program executable type */
+        uint32_t new_role;              /* new role */
+        struct role_trans_rule *next;
+} role_trans_rule_t;
+
+typedef struct role_allow_rule {
+        role_set_t roles; /* current role */
+        role_set_t new_roles; /* new roles */
+        struct role_allow_rule *next;
+} role_allow_rule_t;
 
 /*
  * The configuration data includes security contexts for 
@@ -192,6 +259,11 @@
 	struct genfs *next;
 } genfs_t;
 
+typedef struct policycon {
+        uint32_t component_type;
+	struct ocontext *head;
+} policycon_t;
+
 /* symbol table array indices */
 #define SYM_COMMONS 0
 #define SYM_CLASSES 1
@@ -203,6 +275,10 @@
 #define SYM_CATS    7
 #define SYM_NUM     8
 
+/* this #define gives the index into policycon tables for attributes */
+#define SYM_ATTRIBS (SYM_BOOLS + 1)
+#define POLICYCON_NUM (SYM_ATTRIBS + 1)
+
 /* object context array indices */
 #define OCON_ISID  0	/* initial SIDs */
 #define OCON_FS    1	/* unlabeled file systems */
@@ -213,8 +289,23 @@
 #define OCON_NODE6 6	/* IPv6 nodes */
 #define OCON_NUM   7
 
+/* role_type_node_t holds the types for role declarations
+ * in avrule blocks */
+typedef struct role_type_node {
+        uint32_t role;
+        type_set_t types;
+        struct role_type_node *next;
+} role_type_node_t;
+
 /* The policy database */
 typedef struct policydb {
+#define POLICY_KERN 0
+#define POLICY_BASE 1
+#define POLICY_MOD 2
+	uint32_t policy_type;
+	char *name;
+	char *version;
+
 	/* symbol tables */
 	symtab_t symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
@@ -241,7 +332,19 @@
 	class_datum_t **class_val_to_struct;
 	role_datum_t **role_val_to_struct;
 	user_datum_t **user_val_to_struct;
+	type_datum_t **type_val_to_struct;
 
+	/* RULES */
+	
+	/* symbolic storage of rules - used in parsing and for modules */
+	/* av rules stored as a list */
+	avrule_t *avrules;
+	/* role transitions */
+	role_trans_rule_t *role_tr_rules;
+	/* role allows */
+	role_allow_rule_t *role_allow_rules;
+
+	/* compiled storage of rules - use for the kernel policy */
 	/* type enforcement access vectors and transitions */
 	avtab_t te_avtab;
 
@@ -267,13 +370,17 @@
 	   fixed labeling behavior. */
   	genfs_t *genfs;
 
+        /* keep an array of policycon objects; each element points to
+         * a linked list of ocontexts for that policy component */
+        policycon_t policycon[POLICYCON_NUM];
+
 	/* range transitions */
 	range_trans_t *range_tr;
 
 	unsigned policyvers;
 } policydb_t;
 
-extern int policydb_init(policydb_t * p);
+extern int policydb_init(policydb_t * p, int policy_type);
 
 extern int policydb_index_classes(policydb_t * p);
 
@@ -291,6 +396,26 @@
 
 extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
 
+void class_perm_node_init(class_perm_node_t *x);
+void type_set_init(type_set_t *x);
+void type_set_destroy(type_set_t *x);
+void role_set_init(role_set_t *x);
+void role_set_destroy(role_set_t *x);
+void avrule_init(avrule_t *x);
+void avrule_destroy(avrule_t *x);
+void role_datum_init(role_datum_t *x);
+void role_datum_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
+void role_allow_rule_init(role_allow_rule_t *x);
+void user_datum_init(user_datum_t *x);
+void user_datum_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
+void avrule_list_destroy(avrule_t *x);
+
+int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab);
+int symtab_insert(policydb_t *x, uint32_t sym, hashtab_key_t key,
+                  hashtab_datum_t data, uint32_t *value);
+
+
+
 /* A policy "file" may be a memory region referenced by a (data, len) pair
    or a file referenced by a FILE pointer. */
 struct policy_file {
@@ -301,12 +426,15 @@
 	char *data;
 	size_t len;
 	FILE *fp;
+        unsigned char buffer[BUFSIZ];
 };
 
 extern int policydb_read(policydb_t * p, struct policy_file * fp, unsigned int verbose);
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
 
+extern int avrule_list_read(policydb_t *p, avrule_t **avrules, struct policy_file *fp);
+
 #define PERM_SYMTAB_SIZE 32
 
 /* Identify specific policy version changes */
@@ -321,12 +449,17 @@
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_MLS
 
+/* Module versions */
+#define MOD_POLICYDB_VERSION_BASE	4
+
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_POLICYCON
+
 /*
  * Set policy version for writing policies.
  * May be any value from POLICYDB_VERSION_MIN to POLICYDB_VERSION_MAX.
  * If not set, then policydb_write defaults to the max.
  */
-extern int sepol_set_policyvers(unsigned int policyvers);
+extern int sepol_set_policyvers(unsigned int policy_type, unsigned int policyvers);
 
 /* Enable/Disable MLS support for the service functions.
    MLS support is appropriately enabled/disabled when a policydb file
@@ -347,6 +480,11 @@
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
+#define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
+#define POLICYDB_MOD_STRING "SE Linux Module"
+
+/* Just here for debugging module packages */
+#define SEMOD_MODULE_PACKAGE_MAGIC 0xf97cff8e
 
 #endif	/* _POLICYDB_H_ */
 
diff -burNd a1/libsepol/src/assertion.c b/libsepol/src/assertion.c
--- a1/libsepol/src/assertion.c	1969-12-31 19:00:00.000000000 -0500
+++ b/libsepol/src/assertion.c	2005-05-25 13:11:20.410920480 -0400
@@ -0,0 +1,95 @@
+/* Authors: Joshua Brindle <jbrindle@tresys.com>
+ *              
+ * Assertion checker for avtab entries, taken from 
+ * checkpolicy.c by Steve Smalley
+ *              
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <sepol/avtab.h>
+#include <sepol/policydb.h>
+#include <sepol/expand.h>
+
+static int check_assertion_helper(policydb_t *p, unsigned int stype, unsigned int ttype,
+        class_perm_node_t *perm, avtab_t *avtab, unsigned long line)
+{
+        avtab_key_t avkey;
+        avtab_datum_t *avdatump;
+        class_perm_node_t *curperm;
+
+        curperm = perm;
+
+        while (curperm) {
+                avkey.source_type = stype + 1;
+                avkey.target_type = ttype + 1;
+                avkey.target_class = curperm->class;
+                avdatump = avtab_search(avtab, &avkey, AVTAB_AV);
+                if (!avdatump)
+                        goto cont;
+
+                if ((avdatump->specified & AVTAB_ALLOWED) && (avtab_allowed(avdatump) & curperm->data)) {
+                        fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s ;\n",
+                                line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
+                                p->p_class_val_to_name[curperm->class - 1]);
+                        return -1;
+                }
+
+                cont:
+                curperm = curperm->next;
+        }
+        return 0;
+}
+
+int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab)
+{
+        avrule_t *a;
+        unsigned int i, j;
+	int errors = 0;
+
+        a = avrules;
+        while (a) {
+                if (!(a->specified & AVRULE_NEVERALLOW))
+                        goto cont;
+
+		/* The assertions pretty much have to be pre-expanded since we no 
+		   longer have access to attributes and such */
+			
+                for (i = ebitmap_startbit(&a->stypes.types); i < ebitmap_length(&a->stypes.types); i++) {
+                        if (!ebitmap_get_bit(&a->stypes.types, i))
+                                continue;
+                        if (a->flags & RULE_SELF) {
+                                if (check_assertion_helper(p, i, i, a->perms, avtab, a->line))
+                                        errors++;
+                        }
+                        for (j = ebitmap_startbit(&a->ttypes.types); j < ebitmap_length(&a->ttypes.types); j++) {
+                                if (!ebitmap_get_bit(&a->ttypes.types, j))
+                                        continue;
+                                if (check_assertion_helper(p, i, j, a->perms, avtab, a->line))
+                                    errors++;
+                        }
+                }
+                cont:
+                a = a->next;
+        }
+
+	if (errors) {
+		fprintf(stderr, "%d assertion violations occured\n", errors);	
+		return -1;
+	}
+
+        return 0;
+}
diff -burNd a1/libsepol/src/avtab.c b/libsepol/src/avtab.c
--- a1/libsepol/src/avtab.c	2005-05-25 13:15:54.660228248 -0400
+++ b/libsepol/src/avtab.c	2005-05-25 13:11:19.338083576 -0400
@@ -46,7 +46,7 @@
  AVTAB_HASH_MASK)
 
 static avtab_ptr_t 
-   avtab_insert_node(avtab_t *h, int hvalue, avtab_ptr_t prev, avtab_ptr_t cur, avtab_key_t *key, avtab_datum_t *datum)
+   avtab_insert_node(avtab_t *h, int hvalue, avtab_ptr_t prev, avtab_key_t *key, avtab_datum_t *datum)
 {
 	avtab_ptr_t newnode;
 	newnode = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
@@ -68,7 +68,6 @@
 }
 
 
-
 int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
 {
 	int hvalue;
@@ -97,7 +96,7 @@
 			break;
 	}
 
-	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
 	if(!newnode)
 		return -ENOMEM;
 
@@ -135,28 +134,7 @@
 		    key->target_class < cur->key.target_class)
 			break;
 	}
-	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
-	
-	return newnode;
-}
-
-/* Unlike avtab_insert(), this function stores a caller-provided parse_context pointer, AND
- * allow multiple insertions of the same key/specified mask into the table, AND returns
- * a pointer to the new node added, all as needed by the conditional avtab.  
- */
-avtab_ptr_t
- avtab_insert_with_parse_context(avtab_t *h, avtab_key_t *key, avtab_datum_t *datum, void *parse_context)
-{
-	avtab_ptr_t newnode;
-
-	if (!h)
-		return NULL;
-
-	newnode = avtab_insert_nonunique(h, key, datum);
-	if(!newnode)
-		return NULL;
-		
-	newnode->parse_context = parse_context;
+	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
 		
 	return newnode;			
 }
diff -burNd a1/libsepol/src/conditional.c b/libsepol/src/conditional.c
--- a1/libsepol/src/conditional.c	2005-05-25 13:15:54.661228096 -0400
+++ b/libsepol/src/conditional.c	2005-05-25 13:11:19.342082968 -0400
@@ -2,6 +2,11 @@
  *          Frank Mayer <mayerf@tresys.com>
  *          David Caplan <dac@tresys.com>
  *
+ * Updated: Karl MacMillan <kmacmillan@tresys.com>
+ *          Joshua Brindle <jbrindle@tresys.com>
+ *
+ *      Added support for binary policy modules
+ *
  * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
@@ -125,13 +130,11 @@
 }
 
 /* return either a pre-existing matching node or create a new node */
-cond_node_t *cond_node_search(policydb_t *p, cond_node_t *cn)
+cond_node_t *cond_node_search(policydb_t *p, cond_node_t *list, cond_node_t *cn)
 {
-	cond_node_t *list,*new;
+	cond_node_t *new;
 	int i;
 
-	list = p->cond_list;
-
 	while(list) {
 		if (cond_expr_equal(cn,list)) break;
 		list = list->next;
@@ -139,10 +142,13 @@
 	if (list) return list;
 	else {
 		new = (cond_node_t *)malloc(sizeof (cond_node_t));
+                memset(new, 0, sizeof(cond_node_t));
 		if (!new) {
 			return NULL;
 		}
-		new->expr = cn->expr;
+		new->expr = cond_copy_expr(cn->expr);
+                if (!new->expr)
+                        return NULL;
 		new->cur_state = cond_evaluate_expr(p, new->expr);
 		new->nbools = cn->nbools;
 		for (i = 0; i < cn->nbools; i++)
@@ -150,6 +156,8 @@
 		new->expr_pre_comp = cn->expr_pre_comp;
 		new->true_list = NULL;
 		new->false_list = NULL;
+                new->avtrue_list = NULL;
+                new->avfalse_list = NULL;
 		/* add conditional node to policy list */
 		new->next = p->cond_list;
 		p->cond_list = new;
@@ -220,6 +228,30 @@
 	return s[0];
 }
 
+cond_expr_t *cond_copy_expr(cond_expr_t *expr)
+{
+        cond_expr_t *cur, *head, *tail, *new_expr;
+        tail = head = NULL;
+        cur = expr;
+        while (cur) {
+                new_expr = (cond_expr_t*)malloc(sizeof(cond_expr_t));
+                if (!new_expr)
+                        return NULL;
+                memset(new_expr, 0, sizeof(cond_expr_t));
+
+                new_expr->expr_type = cur->expr_type;
+                new_expr->bool = cur->bool;
+
+                if (!head)
+                        head = new_expr;
+                if (tail)
+                        tail->next = new_expr;
+                tail = new_expr;
+                cur = cur->next;
+        }
+        return head;
+}
+
 /*
  * evaluate_cond_node evaluates the conditional stored in
  * a cond_node_t and if the result is different than the
@@ -268,7 +300,7 @@
 	cond_av_list_t *tmp;
 	int i, j, k, orig_value[COND_MAX_BOOLS];
 	uint32_t test = 0x0;
-	
+	avrule_t *tmp2;
 
 	cn->nbools = 0;
 
@@ -294,6 +326,10 @@
 		tmp = cn->true_list;
 		cn->true_list = cn->false_list;
 		cn->false_list = tmp;
+                tmp2 = cn->avtrue_list;
+                cn->avtrue_list = cn->avfalse_list;
+                cn->avfalse_list = tmp2;
+                
 		/* free the "not" node in the list */
 		free(e);
 	}
@@ -382,7 +418,7 @@
 	}
 }
 
-static void cond_node_destroy(cond_node_t *node)
+void cond_node_destroy(cond_node_t *node)
 {
 	cond_expr_t *cur_expr, *next_expr;
 
@@ -393,12 +429,13 @@
 		next_expr = cur_expr->next;
 		free(cur_expr);
 	}
+        avrule_list_destroy(node->avtrue_list);
+        avrule_list_destroy(node->avfalse_list);
 	cond_av_list_destroy(node->true_list);
 	cond_av_list_destroy(node->false_list);
-	free(node);
 }
 
-static void cond_list_destroy(cond_list_t *list)
+void cond_list_destroy(cond_list_t *list)
 {
 	cond_node_t *next, *cur;
 	
@@ -408,6 +445,7 @@
 	for (cur = list; cur != NULL; cur = next) {
 		next = cur->next;
 		cond_node_destroy(cur);
+                free(cur);
 	}
 }
 
@@ -669,7 +707,7 @@
 	return -1;
 }
 
-int cond_read_list(policydb_t *p, void *fp)
+int cond_read_list(policydb_t *p, cond_list_t **list, void *fp)
 {
 	cond_node_t *node, *last = NULL;
 	uint32_t *buf;
@@ -691,7 +729,7 @@
 			goto err;
 
 		if (i == 0) {
-			p->cond_list = node;
+			*list = node;
 		} else {
 			last->next = node;
 		}
diff -burNd a1/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
--- a1/libsepol/src/ebitmap.c	2005-05-25 13:14:58.958696168 -0400
+++ b/libsepol/src/ebitmap.c	2005-05-25 13:11:19.522055608 -0400
@@ -1,5 +1,26 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ *
+ * Updated: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ *      Added support for binary policy modules
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 /* FLASK */
 
@@ -58,6 +79,19 @@
 	return 0;
 }
 
+int ebitmap_or_eq(ebitmap_t *dst, ebitmap_t *e1)
+{
+       int ret;
+       ebitmap_t tmp;
+
+       if (ebitmap_or(&tmp, dst, e1))
+               return -1;
+       ebitmap_destroy(dst);
+       ret = ebitmap_cpy(dst, &tmp);
+       ebitmap_destroy(&tmp);
+               
+       return ret;
+}
 
 int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2)
 {
diff -burNd a1/libsepol/src/genbools.c b/libsepol/src/genbools.c
--- a1/libsepol/src/genbools.c	2005-05-25 13:14:58.993690848 -0400
+++ b/libsepol/src/genbools.c	2005-05-25 13:11:19.592044968 -0400
@@ -126,7 +125,7 @@
 
 	/* Preserve the policy version of the original policy
 	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
+	sepol_set_policyvers(POLICY_KERN, policydb.policyvers);
 
 	if (load_booleans(&policydb, booleans) < 0) {
 		__sepol_debug_printf("%s:  Warning!  Error while reading %s\n",
@@ -189,7 +176,7 @@
 
 	/* Preserve the policy version of the original policy
 	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
+	sepol_set_policyvers(POLICY_KERN, policydb.policyvers);
 
 	for (i = 0; i < nel; i++) {
 		datum = hashtab_search(policydb.p_bools.table, names[i]);
diff -burNd a1/libsepol/src/genusers.c b/libsepol/src/genusers.c
--- a1/libsepol/src/genusers.c	2005-05-25 13:14:58.931700272 -0400
+++ b/libsepol/src/genusers.c	2005-05-25 13:11:19.527054848 -0400
@@ -81,7 +81,7 @@
 		usrdatum = hashtab_search(policydb->p_users.table, q);
 		if (usrdatum) {
 			/* Replacing an existing user definition. */
-			ebitmap_init(&usrdatum->roles);
+			ebitmap_init(&usrdatum->roles.roles);
 			usrdatum->defined = 1;
 		} else {
 			char *id = strdup(q);
@@ -98,7 +98,7 @@
 			}
 			memset(usrdatum, 0, sizeof(user_datum_t));
 			usrdatum->value = ++policydb->p_users.nprim;
-			ebitmap_init(&usrdatum->roles);
+			ebitmap_init(&usrdatum->roles.roles);
 			usrdatum->defined = 1;
 			rc = hashtab_insert(policydb->p_users.table,
 					    id, (hashtab_datum_t) usrdatum);
@@ -158,7 +158,7 @@
 			/* Set the role and every role it dominates */
 			for (bit = ebitmap_startbit(&roldatum->dominates); bit < ebitmap_length(&roldatum->dominates); bit++) {
 				if (ebitmap_get_bit(&roldatum->dominates, bit))
-					if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
+					if (ebitmap_set_bit(&usrdatum->roles.roles, bit, 1)) {
 						__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 							path, buffer, lineno);
 						errno = ENOMEM;
@@ -309,7 +309,7 @@
 	usrdatum = (user_datum_t *) datum;
 	ebitmap_set_bit(free_users, usrdatum->value - 1, 1);
 
-	ebitmap_destroy(&usrdatum->roles);
+	ebitmap_destroy(&usrdatum->roles.roles);
 	free(datum);
 	pol->p_users.nprim--;
 }
@@ -389,7 +389,7 @@
 	/* Set the policy version for the new binary policy image we are
 	   about to generate so that it stays the same as the original,
 	   even if we support a newer one. */
-	sepol_set_policyvers(policydb.policyvers);
+	sepol_set_policyvers(policydb.policyvers, POLICY_KERN);
 
 	/* Compute the length for the new binary policy image. */
 	pf.type = PF_LEN;
diff -burNd a1/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
--- a1/libsepol/src/hierarchy.c	2005-05-25 13:15:54.661228096 -0400
+++ b/libsepol/src/hierarchy.c	2005-05-25 13:11:19.340083272 -0400
@@ -302,12 +302,12 @@
 		return 1;
 	}
 
-	if (ebitmap_or(&eb, &r->types, &rp->types)) {
+	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
 		/* Memory error */
 		return -1;
 	}
 	
-	if (!ebitmap_cmp(&eb, &rp->types)) {
+	if (!ebitmap_cmp(&eb, &rp->types.types)) {
 		ebitmap_destroy(&eb);
 		/* This is a violation of the hiearchal constraint, return error condition */
 		snprintf(a->errmsg, ERRMSG_LEN, "Role hierarchy violation, %s exceeds %s",
diff -burNd a1/libsepol/src/policydb.c b/libsepol/src/policydb.c
--- a1/libsepol/src/policydb.c	2005-05-25 13:15:54.663227792 -0400
+++ b/libsepol/src/policydb.c	2005-05-25 13:11:19.345082512 -0400
@@ -44,6 +44,7 @@
 #include <stdlib.h>
 
 #include <sepol/policydb.h>
+#include <sepol/expand.h>
 #include <sepol/mls.h>
 #include <sepol/conditional.h>
 
@@ -52,30 +53,47 @@
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
 	{
+		.type		= POLICY_KERN,
 		.version	= POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM - 3,
 		.ocon_num	= OCON_NUM - 1,
 	},
 	{
+		.type		= POLICY_KERN,
 		.version	= POLICYDB_VERSION_BOOL,
 		.sym_num	= SYM_NUM - 2,
 		.ocon_num	= OCON_NUM - 1,
 	},
 	{
+		.type		= POLICY_KERN,
 		.version	= POLICYDB_VERSION_IPV6,
 		.sym_num	= SYM_NUM - 2,
 		.ocon_num	= OCON_NUM,
 	},
 	{
+		.type		= POLICY_KERN,
 		.version	= POLICYDB_VERSION_NLCLASS,
 		.sym_num	= SYM_NUM - 2,
 		.ocon_num	= OCON_NUM,
 	},
 	{
+		.type		= POLICY_KERN,
 		.version	= POLICYDB_VERSION_MLS,
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.type		= POLICY_BASE,
+		.version 	= MOD_POLICYDB_VERSION_BASE,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+        },
+	{
+		.type		= POLICY_MOD,
+		.version	= MOD_POLICYDB_VERSION_BASE,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= 0,
+        }
 };
 
 #if 0
@@ -115,13 +133,14 @@
 	return mls_enabled;
 }
 
-struct policydb_compat_info *policydb_lookup_compat(int version)
+struct policydb_compat_info *policydb_lookup_compat(int version, int type)
 {
 	int i;
 	struct policydb_compat_info *info = NULL;
 	
 	for (i = 0; i < sizeof(policydb_compat)/sizeof(*info); i++) {
-		if (policydb_compat[i].version == version) {
+		if (policydb_compat[i].version == version &&
+		    policydb_compat[i].type == type) {
 			info = &policydb_compat[i];
 			break;
 		}
@@ -129,6 +148,120 @@
 	return info;
 }
 
+void type_set_init(type_set_t *x)
+{       
+        memset(x, 0, sizeof(type_set_t));
+        ebitmap_init(&x->types);
+        ebitmap_init(&x->negset); 
+}       
+        
+void type_set_destroy(type_set_t *x)
+{               
+        ebitmap_destroy(&x->types);
+        ebitmap_destroy(&x->negset);
+}           
+
+void role_set_init(role_set_t *x)
+{       
+        memset(x, 0, sizeof(role_set_t));
+        ebitmap_init(&x->roles);
+}
+
+void role_set_destroy(role_set_t *x)
+{       
+        ebitmap_destroy(&x->roles);
+}
+
+void role_datum_init(role_datum_t *x)
+{
+        memset(x, 0, sizeof(role_datum_t));
+        ebitmap_init(&x->dominates);
+        type_set_init(&x->types);
+}
+
+void role_datum_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+        role_datum_t *x = (role_datum_t *)datum;
+        free(key);
+        ebitmap_destroy(&x->dominates);
+        type_set_destroy(&x->types);
+}
+
+void role_type_node_init(role_type_node_t *x)
+{
+        memset(x, 0, sizeof(role_type_node_t));
+        type_set_init(&x->types);
+}
+
+void user_datum_init(user_datum_t *x)
+{
+        memset(x, 0, sizeof(user_datum_t));
+        role_set_init(&x->roles);
+}
+
+void user_datum_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+        user_datum_t *x = (user_datum_t *)datum;
+        free(key);
+        role_set_destroy(&x->roles);
+}
+
+void class_perm_node_init(class_perm_node_t *x)
+{
+        memset(x, 0, sizeof(class_perm_node_t));
+}
+
+void avrule_init(avrule_t *x)
+{
+        memset(x, 0, sizeof(avrule_t));
+        type_set_init(&x->stypes);
+        type_set_init(&x->ttypes);
+}
+
+void avrule_destroy(avrule_t *x)
+{
+        class_perm_node_t *cur, *next;
+
+        type_set_destroy(&x->stypes);
+        type_set_destroy(&x->ttypes);
+
+        next = x->perms;
+        while (next) {
+                cur = next;
+                next = cur->next;
+                free(cur);
+        }
+}
+
+void role_trans_rule_init(role_trans_rule_t *x)
+{
+        memset(x,0,sizeof(*x));
+        role_set_init(&x->roles);
+        type_set_init(&x->types);
+}
+
+void role_allow_rule_init(role_allow_rule_t *x)
+{
+        memset(x,0,sizeof(role_allow_rule_t));
+        role_set_init(&x->roles);
+        role_set_init(&x->new_roles);
+}
+
+void avrule_list_destroy(avrule_t *x)
+{
+        avrule_t *next, *cur;
+
+        if (!x)
+                return;
+
+        next = x;
+        while (next) {
+                cur = next;
+                next = next->next;
+                avrule_destroy(cur);
+        }
+}
+
 /* 
  * Initialize the role table.
  */
@@ -172,7 +305,7 @@
 /*
  * Initialize a policy database structure.
  */
-int policydb_init(policydb_t * p)
+int policydb_init(policydb_t * p, int policy_type)
 {
 	int i, rc;
 
@@ -184,6 +317,10 @@
 		if (rc)
 			goto out_free_symtab;
 	}
+        for (i = 0; i < POLICYCON_NUM; i++) {
+                p->policycon[i].component_type = i;
+                p->policycon[i].head = NULL;
+	}
 
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
@@ -208,7 +345,6 @@
 	goto out;
 }
 
-
 /*
  * The following *_index functions are used to
  * define the val_to_name and val_to_struct arrays
@@ -282,8 +418,10 @@
 		if (!typdatum->value || typdatum->value > p->p_types.nprim)
 			return -EINVAL;
 		p->p_type_val_to_name[typdatum->value - 1] = (char *) key;
+		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}
 
+
 	return 0;
 }
 
@@ -401,6 +539,25 @@
 	return 0;
 }
 
+int policydb_index_types(policydb_t *p)
+{
+        free(p->p_type_val_to_name);
+        p->p_type_val_to_name = (char**)malloc(p->p_types.nprim * sizeof(char*));
+        if (!p->p_type_val_to_name)
+                return -1;
+ 
+        free(p->type_val_to_struct);
+        p->type_val_to_struct = (type_datum_t**)
+                malloc(p->p_types.nprim * sizeof(type_datum_t*));
+        if (!p->type_val_to_struct)
+                return -1;
+ 
+        if (hashtab_map(p->p_types.table, type_index, p))
+                return -1;
+ 
+        return 0;
+}
+
 /*
  * Define the other val_to_name and val_to_struct arrays
  * in a policy database structure.  
@@ -415,7 +572,7 @@
 		       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
 		       p->p_bools.nprim);
 
-		if (mls_enabled)
+		if (sepol_mls_enabled())
 			printf(", %d sens, %d cats", p->p_levels.nprim,
 			       p->p_cats.nprim);
 
@@ -431,20 +588,27 @@
 		hashtab_hash_eval(p->symtab[i].table, symtab_name[i]);
 #endif
 
+        free(p->role_val_to_struct);
 	p->role_val_to_struct = (role_datum_t **)
 	    malloc(p->p_roles.nprim * sizeof(role_datum_t *));
 	if (!p->role_val_to_struct)
 		return -1;
 
+        free(p->user_val_to_struct);
 	p->user_val_to_struct = (user_datum_t **)
 	    malloc(p->p_users.nprim * sizeof(user_datum_t *));
 	if (!p->user_val_to_struct)
 		return -1;
 
+        free(p->type_val_to_struct);
+        p->type_val_to_struct = (type_datum_t **)
+            malloc(p->p_types.nprim * sizeof(type_datum_t *));
+        if (!p->type_val_to_struct)
+                return -1;
+
 	cond_init_bool_indexes(p);
 
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
-		if (p->sym_val_to_name[i])
 			free(p->sym_val_to_name[i]);
 		p->sym_val_to_name[i] = (char **)
 		    malloc(p->symtab[i].nprim * sizeof(char *));
@@ -457,6 +621,7 @@
 	return 0;
 }
 
+
 /*
  * The following *_destroy functions are used to
  * free any memory allocated for each kind of
@@ -539,7 +704,7 @@
 		free(key);
 	role = (role_datum_t *) datum;
 	ebitmap_destroy(&role->dominates);
-	ebitmap_destroy(&role->types);
+        type_set_destroy(&role->types);
 	free(datum);
 	return 0;
 }
@@ -559,7 +724,7 @@
 	if (key)
 		free(key);
 	usrdatum = (user_datum_t *) datum;
-	ebitmap_destroy(&usrdatum->roles);
+        role_set_destroy(&usrdatum->roles);
 	ebitmap_destroy(&usrdatum->range.level[0].cat);
 	ebitmap_destroy(&usrdatum->range.level[1].cat);
 	ebitmap_destroy(&usrdatum->dfltlevel.cat);
@@ -610,6 +775,9 @@
 	genfs_t *g, *gtmp;
 	int i;
 
+        if (!p)
+                return;
+        
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->symtab[i].table, destroy_f[i], 0);
 		hashtab_destroy(p->symtab[i].table);
@@ -657,6 +825,14 @@
 		g = g->next;
 		free(gtmp);
 	}
+        for (i = 0; i < POLICYCON_NUM; i++) {
+                for (c = p->policycon[i].head; c != NULL; c = ctmp) {
+                        ctmp = c->next;
+			context_destroy(&c->context[0]);
+			free(c->u.name);
+			free(c);
+                }
+        }
 	cond_policydb_destroy(p);
 	return;
 }
@@ -699,8 +875,11 @@
 {
 	role_datum_t *role;
 	user_datum_t *usrdatum;
+	ebitmap_t types, roles;
+        int ret = 1;
 
-
+	ebitmap_init(&types);
+	ebitmap_init(&roles);
 	if (!c->role || c->role > p->p_roles.nprim)
 		return 0;
 
@@ -715,8 +894,11 @@
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->types,
-				     c->type - 1))
+		if (type_set_expand(&role->types, &types, p)) {
+			printf("something bad happened while expanding types\n");
+                        return 0;
+		}
+		if (!ebitmap_get_bit(&types, c->type - 1))
 			/* role may not be associated with type */
 			return 0;
 		
@@ -727,8 +909,11 @@
 		if (!usrdatum)
 			return 0;
 
-		if (!ebitmap_get_bit(&usrdatum->roles,
-				     c->role - 1))
+                if (role_set_expand(&usrdatum->roles, &roles, p)) {
+			printf("something bad happened while expanding roles\n");
+                        return 0;
+                }
+		if (!ebitmap_get_bit(&roles, c->role - 1))
 			/* user may not be associated with role */
 			return 0;
 	}
@@ -736,9 +921,13 @@
 	if (!mls_context_isvalid(p, c))
 		return 0;
 
-	return 1;
+	return ret;
 }
 
+
+/***********************************************************************/
+/* everything below is for policy reads */
+
 /*
  * Read a MLS range structure from a policydb binary 
  * representation file.
@@ -1132,7 +1321,7 @@
 	if (ebitmap_read(&role->dominates, fp))
 		goto bad;
 
-	if (ebitmap_read(&role->types, fp))
+	if (ebitmap_read(&role->types.types, fp))
 		goto bad;
 
 	if (strcmp(key, OBJECT_R) == 0) {
@@ -1196,6 +1385,478 @@
 	return -1;
 }
 
+int role_trans_read(role_trans_t **t, struct policy_file *fp)
+{                       
+        int i;
+        uint32_t *buf, nel;
+        role_trans_t *tr, *ltr;
+                                
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        nel = le32_to_cpu(buf[0]);
+        ltr = NULL;
+        for (i = 0; i < nel; i++) {
+                tr = malloc(sizeof(struct role_trans));
+                if (!tr) {
+                        return -1;
+                }       
+                memset(tr, 0, sizeof(struct role_trans));
+                if (ltr) {
+                        ltr->next = tr;
+                } else {
+                        *t = tr;
+                }       
+                buf = next_entry(fp, sizeof(uint32_t)*3);
+                if (!buf)
+                        return -1;
+                tr->role = le32_to_cpu(buf[0]);
+                tr->type = le32_to_cpu(buf[1]);
+                tr->new_role = le32_to_cpu(buf[2]);
+                ltr = tr;
+        }
+        return 0;
+}
+
+int role_allow_read(role_allow_t **r, struct policy_file *fp)
+{
+        int i;
+        uint32_t *buf, nel;
+        role_allow_t *ra, *lra;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        nel = le32_to_cpu(buf[0]);
+        lra = NULL;
+        for (i = 0; i < nel; i++) {
+                ra = malloc(sizeof(struct role_allow));
+                if (!ra) {
+                        return -1;
+                }
+                memset(ra, 0, sizeof(struct role_allow));
+                if (lra) {
+                        lra->next = ra;
+                } else {
+                        *r = ra;
+                }
+                buf = next_entry(fp, sizeof(uint32_t)*2);
+                if (!buf)
+                        return -1;
+                ra->role = le32_to_cpu(buf[0]);
+                ra->new_role = le32_to_cpu(buf[1]);
+                lra = ra;
+        }
+        return 0;
+}
+
+static int ocontext_read (struct policydb_compat_info *info,
+                          policydb_t * p, struct policy_file * fp) {
+        unsigned int i, j;
+        size_t nel, len;
+        ocontext_t *l, *c;
+        uint32_t *buf;
+        for (i = 0; i < info->ocon_num; i++) {
+                buf = next_entry(fp, sizeof(uint32_t));
+                if (!buf)
+                        return -1;
+                nel = le32_to_cpu(buf[0]);
+                l = NULL;
+                for (j = 0; j < nel; j++) {
+                        c = malloc(sizeof(ocontext_t));
+                        if (!c) {
+                                return -1;
+                        }
+                        memset(c, 0, sizeof(ocontext_t));
+                        if (l) {
+                                l->next = c;
+                        } else {
+                                p->ocontexts[i] = c;
+                        }
+                        l = c;
+                        switch (i) {
+                        case OCON_ISID:
+                                buf = next_entry(fp, sizeof(uint32_t));
+                                if (!buf)
+                                        return -1;
+                                c->sid[0] = le32_to_cpu(buf[0]);
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                break;
+                        case OCON_FS:
+                        case OCON_NETIF:
+                                buf = next_entry(fp, sizeof(uint32_t));
+                                if (!buf)
+                                        return -1;
+                                len = le32_to_cpu(buf[0]);
+                                buf = next_entry(fp, len);
+                                if (!buf)
+                                        return -1;
+                                c->u.name = malloc(len + 1);
+                                if (!c->u.name) {
+                                        return -1;
+                                }
+                                memcpy(c->u.name, buf, len);
+                                c->u.name[len] = 0;
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                if (context_read_and_validate(&c->context[1], p, fp))
+                                        return -1;
+                                break;
+                        case OCON_PORT:
+				buf = next_entry(fp, sizeof(uint32_t)*3);
+                                if (!buf)
+                                        return -1;
+                                c->u.port.protocol = le32_to_cpu(buf[0]);
+                                c->u.port.low_port = le32_to_cpu(buf[1]);
+                                c->u.port.high_port = le32_to_cpu(buf[2]);
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                break;
+                        case OCON_NODE:
+                                buf = next_entry(fp, sizeof(uint32_t)* 2);
+                                if (!buf)
+                                        return -1;
+                                c->u.node.addr = le32_to_cpu(buf[0]);
+                                c->u.node.mask = le32_to_cpu(buf[1]);
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                break;
+                        case OCON_FSUSE:
+                                buf = next_entry(fp, sizeof(uint32_t)*2);
+                                if (!buf)
+                                        return -1;
+                                c->v.behavior = le32_to_cpu(buf[0]);
+                                len = le32_to_cpu(buf[1]);
+                                buf = next_entry(fp, len);
+                                if (!buf)
+                                        return -1; 
+                                c->u.name = malloc(len + 1);
+                                if (!c->u.name) {
+                                        return -1; 
+                                }               
+                                memcpy(c->u.name, buf, len);
+                                c->u.name[len] = 0;
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                break;  
+                        case OCON_NODE6: {
+                                int k;
+                                
+                                buf = next_entry(fp, sizeof(uint32_t) * 8);
+                                if (!buf) 
+                                        return -1;
+                                for (k = 0; k < 4; k++)
+                                        c->u.node6.addr[k] = le32_to_cpu(buf[k]);
+                                for (k = 0; k < 4; k++)
+                                        c->u.node6.mask[k] = le32_to_cpu(buf[k+4]);
+                                if (context_read_and_validate(&c->context[0], p, fp))
+                                        return -1;
+                                break;  
+                        }       
+                        }       
+                }               
+        }
+        return 0;               
+}
+
+static int genfs_read (policydb_t *p, struct policy_file *fp) {
+        uint32_t *buf;
+        size_t nel, nel2, len, len2;
+        genfs_t *genfs_p, *newgenfs, *genfs;
+        unsigned int i, j;
+        ocontext_t *l, *c, *newc;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)               
+                goto bad;               
+        nel = le32_to_cpu(buf[0]);
+        genfs_p = NULL;         
+        for (i = 0; i < nel; i++) {
+                newgenfs = malloc(sizeof(genfs_t));
+                if (!newgenfs) {        
+                        goto bad;
+                }                       
+                memset(newgenfs, 0, sizeof(genfs_t));
+                buf = next_entry(fp, sizeof(uint32_t));
+                if (!buf)       
+                        goto bad;
+                len = le32_to_cpu(buf[0]);
+                buf = next_entry(fp, len);
+                if (!buf)       
+                        goto bad;
+                newgenfs->fstype = malloc(len + 1);
+                if (!newgenfs->fstype) {
+                        goto bad;
+                }       
+                memcpy(newgenfs->fstype, buf, len);
+                newgenfs->fstype[len] = 0;
+                for (genfs_p = NULL, genfs = p->genfs; genfs;
+                     genfs_p = genfs, genfs = genfs->next) {
+                        if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
+                                printf("security:  dup genfs fstype %s\n", newgenfs->fstype);
+                                goto bad;
+                        }       
+                        if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
+                                break;
+                }               
+                newgenfs->next = genfs; 
+                if (genfs_p)    
+                        genfs_p->next = newgenfs;
+                else
+                        p->genfs = newgenfs;
+                buf = next_entry(fp, sizeof(uint32_t));
+                if (!buf)
+                        goto bad;
+                nel2 = le32_to_cpu(buf[0]);
+                for (j = 0; j < nel2; j++) {
+                        newc = malloc(sizeof(ocontext_t));
+                        if (!newc) {
+                                goto bad;
+                        }
+                        memset(newc, 0, sizeof(ocontext_t));
+                        buf = next_entry(fp, sizeof(uint32_t));
+                        if (!buf)
+                                goto bad;
+                        len = le32_to_cpu(buf[0]);
+                        buf = next_entry(fp, len);
+                        if (!buf)
+                                goto bad;
+                        newc->u.name = malloc(len + 1);
+                        if (!newc->u.name) {
+                                goto bad;
+                        }
+                        memcpy(newc->u.name, buf, len);
+                        newc->u.name[len] = 0;
+                        buf = next_entry(fp, sizeof(uint32_t));
+                        if (!buf)
+                                goto bad;
+                        newc->v.sclass = le32_to_cpu(buf[0]);
+                        if (context_read_and_validate(&newc->context[0], p, fp))
+                                goto bad;
+                        for (l = NULL, c = newgenfs->head; c;
+                             l = c, c = c->next) {
+                                if (!strcmp(newc->u.name, c->u.name) &&
+                                    (!c->v.sclass || !newc->v.sclass || newc->v.sclass == c->v.sclass)) {
+                                        printf("security:  dup genfs entry (%s,%s)\n", newgenfs->fstype, c->u.name);
+                                        goto bad;
+                                }
+                                len = strlen(newc->u.name);
+                                len2 = strlen(c->u.name);
+                                if (len > len2)
+                                        break;
+                        }
+                        newc->next = c;
+                        if (l)
+                                l->next = newc;
+                        else
+                                newgenfs->head = newc;
+                }
+        }
+
+        return 0;
+
+bad:
+	return -1;
+}
+
+/* The following are read functions for module structures */
+
+static int role_set_read(role_set_t *r, struct policy_file *fp)
+{                       
+        uint32_t *buf;
+        if (ebitmap_read(&r->roles, fp))
+                return -1;
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        r->flags = le32_to_cpu(buf[0]);
+
+        return 0;
+}
+
+static int type_set_read(type_set_t *t, struct policy_file *fp)
+{
+        uint32_t *buf;
+
+        if (ebitmap_read(&t->types, fp))
+                return -1;
+        if (ebitmap_read(&t->negset, fp))
+                return -1;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        t->flags = le32_to_cpu(buf[0]);
+
+        return 0;
+}
+
+int role_trans_rule_read(role_trans_rule_t **r, struct policy_file *fp)
+{
+        uint32_t *buf, nel;
+        int i;
+        role_trans_rule_t *tr, *ltr;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        nel = le32_to_cpu(buf[0]);
+        ltr = NULL;
+        for (i = 0; i < nel; i++) {
+                tr = malloc(sizeof(role_trans_rule_t));
+                if (!tr) {
+                        return -1;
+                }
+                role_trans_rule_init(tr);
+
+                if (ltr) {
+                        ltr->next = tr;
+                } else {
+                        *r = tr;
+                }
+
+                if (role_set_read(&tr->roles, fp))
+                        return -1;
+
+                if (type_set_read(&tr->types, fp))
+                        return -1;
+
+                buf = next_entry(fp, sizeof(uint32_t));
+                tr->new_role = le32_to_cpu(buf[0]);
+                ltr = tr;
+        }
+
+        return 0;
+}
+
+int role_allow_rule_read(role_allow_rule_t **r, struct policy_file *fp)
+{
+        int i;
+        uint32_t *buf, nel;
+        role_allow_rule_t *ra, *lra;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        nel = le32_to_cpu(buf[0]);
+        lra = NULL;
+        for (i = 0; i < nel; i++) {
+                ra = malloc(sizeof(role_allow_rule_t));
+                if (!ra) {
+                        return -1;
+                }
+                role_allow_rule_init(ra);
+
+                if (lra) {
+                        lra->next = ra;
+                } else {
+                        *r = ra;
+                }
+
+                if (role_set_read(&ra->roles, fp))
+                        return -1;
+
+                if (role_set_read(&ra->new_roles, fp))
+                        return -1;
+
+                lra = ra;
+        }
+        return 0;
+}
+
+static avrule_t *read_avrule(policydb_t *p, struct policy_file *fp)
+{                       
+        int i;                  
+        uint32_t *buf, len;
+        class_perm_node_t *cur, *tail = NULL;
+        avrule_t *avrule;
+
+        avrule = (avrule_t*)malloc(sizeof(avrule_t));
+        if (!avrule)
+                return NULL;
+
+        avrule_init(avrule);
+
+        buf = next_entry(fp, sizeof(uint32_t) * 2);
+        if (!buf)
+                goto bad;
+        
+        (avrule)->specified = le32_to_cpu(buf[0]);
+        (avrule)->flags = le32_to_cpu(buf[1]);
+                                
+        if (type_set_read(&avrule->stypes, fp))
+                goto bad;
+                
+        if (type_set_read(&avrule->ttypes, fp))
+                goto bad;
+                                
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf)
+                goto bad;
+        len = le32_to_cpu(buf[0]); 
+                        
+                        
+        for (i = 0; i < len; i++) { 
+                cur = (class_perm_node_t*)malloc(sizeof(class_perm_node_t));
+                if (!cur)
+                        goto bad;
+                class_perm_node_init(cur);
+
+                buf = next_entry(fp, sizeof(uint32_t) * 2);
+                if (!buf)
+                        goto bad;
+
+                cur->class = le32_to_cpu(buf[0]);
+                cur->data = le32_to_cpu(buf[1]);
+
+                if (!tail) {
+			avrule->perms = cur;
+                } else {
+                        tail->next = cur;
+                }
+                tail = cur;
+        }
+
+        return avrule;
+bad:
+        if (avrule)
+                avrule_destroy(avrule);
+        return NULL;
+}
+
+int avrule_list_read(policydb_t *p, avrule_t **avrules,
+                                struct policy_file *fp)
+{
+        int i;
+        avrule_t *cur, *tail;
+        uint32_t *buf, len;
+
+        *avrules = tail = NULL;
+
+        buf = next_entry(fp, sizeof(uint32_t));
+        if (!buf) {
+                return -1;
+        }
+        len = le32_to_cpu(buf[0]);
+
+        for (i = 0; i < len; i++) {
+                cur = read_avrule(p, fp);
+                if (!cur) {
+                        return -1;
+                }
+
+                if (!tail) {
+                        *avrules = cur;
+                } else {
+                        tail->next = cur;
+                }
+                tail = cur;
+        }
+
+        return 0;
+}
+
 
 /*
  * Read a MLS level structure from a policydb binary 
@@ -1252,8 +1913,13 @@
 	memcpy(key, buf, len);
 	key[len] = 0;
 
-	if (ebitmap_read(&usrdatum->roles, fp))
+	if (p->policy_type == POLICY_KERN) {
+		if (ebitmap_read(&usrdatum->roles.roles, fp))
+			goto bad;
+	} else {
+		if (role_set_read(&usrdatum->roles, fp))
 		goto bad;
+	}
 
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
 		if (mls_read_range_helper(&usrdatum->range, fp))
@@ -1369,87 +2035,113 @@
  */
 int policydb_read(policydb_t * p, struct policy_file * fp, unsigned verbose)
 {
-	role_allow_t *ra, *lra;
-	role_trans_t *tr, *ltr;
 	range_trans_t *rt, *lrt;
-
-	ocontext_t *l, *c, *newc;
-	genfs_t *genfs_p, *genfs, *newgenfs;
 	unsigned int i, j, r_policyvers;
 	uint32_t *buf, config;
-	size_t len, len2, nprim, nel, nel2;
+	size_t len, nprim, nel;
 	char *policydb_str;
 	struct policydb_compat_info *info;
+        int policy_type, index;
 
 	config = 0;
 
-	if (policydb_init(p)) 
-		return -1;
 
 	/* Read the magic number and string length. */
 	buf = next_entry(fp, sizeof(uint32_t)* 2);
 	if (!buf)
-		goto bad;
+		return -1;
 	for (i = 0; i < 2; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	if (buf[0] != POLICYDB_MAGIC) {
-		printf("security:  policydb magic number 0x%x does not match expected magic number 0x%x\n", buf[0], POLICYDB_MAGIC);
-		goto bad;
+	if (buf[0] != POLICYDB_MAGIC && buf[0] != POLICYDB_MOD_MAGIC) {
+		printf("security:  policydb magic number 0x%x does not match expected magic number 0x%x or 0x%x\n",
+			buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
+		return -1;
 	}
 
+	if (buf[0] == POLICYDB_MAGIC)
+		policy_type = POLICY_KERN;
+	else
+		policy_type = POLICY_MOD;
+        
 	len = buf[1];
 	if (len != strlen(POLICYDB_STRING)) {
 		printf("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(POLICYDB_STRING));
-		goto bad;
+		return -1;
 	}
 	buf = next_entry(fp, len);
 	if (!buf) {
 		printf("security:  truncated policydb string identifier\n");
-		goto bad;
+		return -1;
 	}
 	policydb_str = malloc(len + 1);
 	if (!policydb_str) {
 		printf("security:  unable to allocate memory for policydb string of length %zu\n", len);
-		goto bad;
+		return -1;
 	}
 	memcpy(policydb_str, buf, len);
 	policydb_str[len] = 0;
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		printf("security:  policydb string %s does not match my string %s\n", policydb_str, POLICYDB_STRING);
 		free(policydb_str);
-		goto bad;
+		return -1;
 	}
 	/* Done with policydb_str. */
 	free(policydb_str);
 	policydb_str = NULL;
 
-	/* Read the version, config, and table sizes. */
-	buf = next_entry(fp, sizeof(uint32_t)*4);
+	/* Read the version, config, and table sizes (and policy type if it's a module). */
+        if (policy_type == POLICY_KERN)
+                nel = 4;
+        else
+                nel = 5;
+
+	buf = next_entry(fp, sizeof(uint32_t)*nel);
 	if (!buf)
-		goto bad;
-	for (i = 0; i < 4; i++)
+		return -1;
+	for (i = 0; i < nel; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	p->policyvers = r_policyvers = buf[0];
+	index = 0;
+
+	r_policyvers = buf[index];
 	if (r_policyvers < POLICYDB_VERSION_MIN || r_policyvers > POLICYDB_VERSION_MAX) {
 		printf("security:  policydb version %d does not match "
-		       "my version range %d-%d\n", buf[0], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
-		goto bad;
+		       "my version range %d-%d\n", buf[index], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+		return -1;
 	}
+	index++;
 
-	if (buf[1] & POLICYDB_CONFIG_MLS)
-		mls_enabled = 1;
+	if (policy_type != POLICY_KERN) {
+		/* We know it's a module but not whether it's a base module 
+		   or regular module, buf[4] tells us which */
+		policy_type = buf[index];
+                if (policy_type != POLICY_MOD && policy_type != POLICY_BASE) {
+                        printf("Policy type is incorrect: %x\n", policy_type);
+                        return -1;
+                }
+		index++;
+	}
 
-	info = policydb_lookup_compat(r_policyvers);
+	/* Initialize the policy structure now that we know what kind it is */
+	if (policydb_init(p, policy_type)) 
+		return -1;
+        p->policyvers = r_policyvers;
+
+	if (buf[index] & POLICYDB_CONFIG_MLS) {
+                sepol_set_mls(1);
+        }
+        index++;
+
+	info = policydb_lookup_compat(r_policyvers, policy_type);
 	if (!info) {
 		printf("security:  unable to find policy compat info for version %d\n", r_policyvers);
 		goto bad;
 	}
 
-	if (buf[2] != info->sym_num || buf[3] != info->ocon_num) {
+	if (buf[index] != info->sym_num || buf[index + 1] != info->ocon_num) {
 		printf("security:  policydb table sizes (%d,%d) do not match mine (%d,%d)\n",
-		       buf[2], buf[3], info->sym_num, info->ocon_num);
+		       buf[index], buf[index + 1], info->sym_num, info->ocon_num);
 		goto bad;
 	}
 
@@ -1467,60 +2159,22 @@
 		p->symtab[i].nprim = nprim;
 	}
 
+	if (policy_type == POLICY_KERN) {
+
 	if (avtab_read(&p->te_avtab, fp, config))
 		goto bad;
 	if (r_policyvers >= POLICYDB_VERSION_BOOL)
-		if (cond_read_list(p, fp))
+			if (cond_read_list(p, &p->cond_list, fp))
 			goto bad;
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		goto bad;
-	nel = le32_to_cpu(buf[0]);
-	ltr = NULL;
-	for (i = 0; i < nel; i++) {
-		tr = malloc(sizeof(role_trans_t));
-		if (!tr) {
-			goto bad;
-		}
-		memset(tr, 0, sizeof(role_trans_t));
-		if (ltr) {
-			ltr->next = tr;
-		} else {
-			p->role_tr = tr;
-		}
-		buf = next_entry(fp, sizeof(uint32_t)*3);
-		if (!buf)
+                if (role_trans_read(&p->role_tr, fp))
 			goto bad;
-		tr->role = le32_to_cpu(buf[0]);
-		tr->type = le32_to_cpu(buf[1]);
-		tr->new_role = le32_to_cpu(buf[2]);
-		ltr = tr;
-	}
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		goto bad;
-	nel = le32_to_cpu(buf[0]);
-	lra = NULL;
-	for (i = 0; i < nel; i++) {
-		ra = malloc(sizeof(struct role_allow));
-		if (!ra) {
-			goto bad;
-		}
-		memset(ra, 0, sizeof(struct role_allow));
-		if (lra) {
-			lra->next = ra;
-		} else {
-			p->role_allow = ra;
-		}
-		buf = next_entry(fp, sizeof(uint32_t)*2);
-		if (!buf)
+                if (role_allow_read(&p->role_allow, fp))
 			goto bad;
-		ra->role = le32_to_cpu(buf[0]);
-		ra->new_role = le32_to_cpu(buf[1]);
-		lra = ra;
 	}
+        /* FIX ME: do the alternate read here for modules */
+
 
 	if (policydb_index_classes(p))
 		goto bad;
@@ -1528,194 +2182,14 @@
 	if (policydb_index_others(p, verbose))
 		goto bad;
 
-	for (i = 0; i < info->ocon_num; i++) {
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
-			goto bad;
-		nel = le32_to_cpu(buf[0]);
-		l = NULL;
-		for (j = 0; j < nel; j++) {
-			c = malloc(sizeof(ocontext_t));
-			if (!c) {
-				goto bad;
-			}
-			memset(c, 0, sizeof(ocontext_t));
-			if (l) {
-				l->next = c;
-			} else {
-				p->ocontexts[i] = c;
-			}
-			l = c;
-			switch (i) {
-			case OCON_ISID:
-				buf = next_entry(fp, sizeof(uint32_t));
-				if (!buf)
-					goto bad;
-				c->sid[0] = le32_to_cpu(buf[0]);
-				if (context_read_and_validate(&c->context[0], p, fp))
-					goto bad;
-				break;
-			case OCON_FS:
-			case OCON_NETIF:
-				buf = next_entry(fp, sizeof(uint32_t));
-				if (!buf)
-					goto bad;
-				len = le32_to_cpu(buf[0]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					goto bad;
-				c->u.name = malloc(len + 1);
-				if (!c->u.name) {
-					goto bad;
-				}
-				memcpy(c->u.name, buf, len);
-				c->u.name[len] = 0;
-				if (context_read_and_validate(&c->context[0], p, fp))
-					goto bad;
-				if (context_read_and_validate(&c->context[1], p, fp))
-					goto bad;
-				break;
-			case OCON_PORT:
-				buf = next_entry(fp, sizeof(uint32_t)*3);
-				if (!buf)
-					goto bad;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
-				if (context_read_and_validate(&c->context[0], p, fp))
-					goto bad;
-				break;
-			case OCON_NODE:
-				buf = next_entry(fp, sizeof(uint32_t)* 2);
-				if (!buf)
-					goto bad;
-				c->u.node.addr = le32_to_cpu(buf[0]);
-				c->u.node.mask = le32_to_cpu(buf[1]);
-				if (context_read_and_validate(&c->context[0], p, fp))
-					goto bad;
-				break;
-			case OCON_FSUSE:
-				buf = next_entry(fp, sizeof(uint32_t)*2);
-				if (!buf)
-					goto bad;
-				c->v.behavior = le32_to_cpu(buf[0]);
-				len = le32_to_cpu(buf[1]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					goto bad;
-				c->u.name = malloc(len + 1);
-				if (!c->u.name) {
-					goto bad;
-				}
-				memcpy(c->u.name, buf, len);
-				c->u.name[len] = 0;
-				if (context_read_and_validate(&c->context[0], p, fp))
-					goto bad;
-				break;
-			case OCON_NODE6: {
-				int k;
 				
-				buf = next_entry(fp, sizeof(uint32_t) * 8);
-				if (!buf)
-					goto bad;
-				for (k = 0; k < 4; k++)
-					c->u.node6.addr[k] = le32_to_cpu(buf[k]);
-				for (k = 0; k < 4; k++)
-					c->u.node6.mask[k] = le32_to_cpu(buf[k+4]);
-				if (context_read_and_validate(&c->context[0], p, fp))
+	if (ocontext_read (info, p, fp) == -1) {
 					goto bad;
-				break;
-			}
-			}
-		}
 	}
 
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		goto bad;
-	nel = le32_to_cpu(buf[0]);
-	genfs_p = NULL;
-	for (i = 0; i < nel; i++) {
-		newgenfs = malloc(sizeof(genfs_t));
-		if (!newgenfs) {
-			goto bad;
-		}
-		memset(newgenfs, 0, sizeof(genfs_t));
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
-			goto bad;
-		len = le32_to_cpu(buf[0]);
-		buf = next_entry(fp, len);
-		if (!buf)
-			goto bad;
-		newgenfs->fstype = malloc(len + 1);
-		if (!newgenfs->fstype) {
-			goto bad;
-		}
-		memcpy(newgenfs->fstype, buf, len);
-		newgenfs->fstype[len] = 0;
-		for (genfs_p = NULL, genfs = p->genfs; genfs; 
-		     genfs_p = genfs, genfs = genfs->next) {
-			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
-				printf("security:  dup genfs fstype %s\n", newgenfs->fstype);
-				goto bad;
-			}
-			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
-				break;
-		}
-		newgenfs->next = genfs;
-		if (genfs_p)
-			genfs_p->next = newgenfs;
-		else
-			p->genfs = newgenfs;
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
-			goto bad;
-		nel2 = le32_to_cpu(buf[0]);
-		for (j = 0; j < nel2; j++) {
-			newc = malloc(sizeof(ocontext_t));
-			if (!newc) {
-				goto bad;
-			}
-			memset(newc, 0, sizeof(ocontext_t));
-			buf = next_entry(fp, sizeof(uint32_t));
-			if (!buf)
-				goto bad;
-			len = le32_to_cpu(buf[0]);
-			buf = next_entry(fp, len);
-			if (!buf)
-				goto bad;
-			newc->u.name = malloc(len + 1);
-			if (!newc->u.name) {
-				goto bad;
-			}
-			memcpy(newc->u.name, buf, len);
-			newc->u.name[len] = 0;
-			buf = next_entry(fp, sizeof(uint32_t));
-			if (!buf)
-				goto bad;
-			newc->v.sclass = le32_to_cpu(buf[0]);
-			if (context_read_and_validate(&newc->context[0], p, fp))
-				goto bad;
-			for (l = NULL, c = newgenfs->head; c; 
-			     l = c, c = c->next) {
-				if (!strcmp(newc->u.name, c->u.name) &&
-				    (!c->v.sclass || !newc->v.sclass || newc->v.sclass == c->v.sclass)) {
-					printf("security:  dup genfs entry (%s,%s)\n", newgenfs->fstype, c->u.name);
+        if (genfs_read (p, fp) == -1) {
 					goto bad;
 				}
-				len = strlen(newc->u.name);
-				len2 = strlen(c->u.name);
-				if (len > len2)
-					break;
-			}
-			newc->next = c;
-			if (l)
-				l->next = newc;
-			else
-				newgenfs->head = newc;
-		}
-	}
 
 	if (r_policyvers >= POLICYDB_VERSION_MLS) {
 		buf = next_entry(fp, sizeof(uint32_t));
diff -burNd a1/libsepol/src/private.h b/libsepol/src/private.h
--- a1/libsepol/src/private.h	2005-05-25 13:14:58.861710912 -0400
+++ b/libsepol/src/private.h	2005-05-25 13:11:20.113965624 -0400
@@ -19,40 +19,40 @@
 
 /* Policy compatibility information. */
 struct policydb_compat_info {
+	int type;
 	int version;
 	int sym_num;
 	int ocon_num;
 };
 
-extern struct policydb_compat_info *policydb_lookup_compat(int version);
+extern struct policydb_compat_info *policydb_lookup_compat(int version, int type);
 extern void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file * fp, size_t bytes)
 {
-	static unsigned char buffer[BUFSIZ];
 	size_t nread;
 
-	if (bytes > sizeof buffer)
+	if (bytes > sizeof(fp->buffer))
 		return NULL;
 
 	switch (fp->type) {
 	case PF_USE_STDIO:
-		nread = fread(buffer, bytes, 1, fp->fp);
+		nread = fread(fp->buffer, bytes, 1, fp->fp);
 		if (nread != 1)
 			return NULL;
 		break;
 	case PF_USE_MEMORY:
 		if (bytes > fp->len) 
 			return NULL;
-		memcpy(buffer, fp->data, bytes);
+		memcpy(fp->buffer, fp->data, bytes);
 		fp->data += bytes;
 		fp->len -= bytes;
 		break;
 	default:
 		return NULL;
 	}
-	return buffer;
+	return fp->buffer;
 }
 
 extern int mls_enabled;
diff -burNd a1/libsepol/src/services.c b/libsepol/src/services.c
--- a1/libsepol/src/services.c	2005-05-25 13:15:54.664227640 -0400
+++ b/libsepol/src/services.c	2005-05-25 13:11:19.467063968 -0400
@@ -1370,13 +1347,13 @@
 	}
 	memset(mysids, 0, maxnel*sizeof(sepol_security_id_t));
 
-	for (i = ebitmap_startbit(&user->roles); i < ebitmap_length(&user->roles); i++) {
-		if (!ebitmap_get_bit(&user->roles, i)) 
+	for (i = ebitmap_startbit(&user->roles.roles); i < ebitmap_length(&user->roles.roles); i++) {
+		if (!ebitmap_get_bit(&user->roles.roles, i)) 
 			continue;		
 		role = policydb->role_val_to_struct[i];
 		usercon.role = i+1;
-		for (j = ebitmap_startbit(&role->types); j < ebitmap_length(&role->types); j++) {
-			if (!ebitmap_get_bit(&role->types, j)) 
+		for (j = ebitmap_startbit(&role->types.types); j < ebitmap_length(&role->types.types); j++) {
+			if (!ebitmap_get_bit(&role->types.types, j)) 
 				continue;	
 			usercon.type = j+1;
 			if (usercon.type == fromcon->type)
diff -burNd a1/libsepol/src/util.c b/libsepol/src/util.c
--- a1/libsepol/src/util.c	1969-12-31 19:00:00.000000000 -0500
+++ b/libsepol/src/util.c	2005-05-25 13:11:19.488060776 -0400
@@ -0,0 +1,135 @@
+/* Authors: Joshua Brindle <jbrindle@tresys.com>
+ * 	    Jason Tang <jtang@tresys.com>
+ *
+ * A set of utility functions that aid policy decision when dealing
+ * with hierarchal namespaces.
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <sepol/flask_types.h>
+#include <sepol/policydb.h>
+
+int type_set_or(type_set_t *dst, type_set_t *a, type_set_t *b)
+{
+        type_set_init(dst);
+
+        if (ebitmap_or(&dst->types, &a->types, &b->types)) {
+                fprintf(stderr, "Memory error\n");
+                return -1;
+        }
+        if (ebitmap_or(&dst->negset, &a->negset, &b->negset)) {
+                fprintf(stderr, "Memory error\n");
+                return -1;
+        }
+
+        dst->flags |= a->flags;
+        dst->flags |= b->flags;
+
+        return 0;
+}
+
+int type_set_cpy(type_set_t *dst, type_set_t *src)
+{
+        type_set_init(dst);
+
+        dst->flags = src->flags;
+        if (ebitmap_cpy(&dst->types, &src->types))
+                return -1;
+        if (ebitmap_cpy(&dst->negset, &src->negset))
+                return -1;
+
+        return 0;
+}
+
+int type_set_or_eq(type_set_t *dst, type_set_t *other)
+{
+        int ret;
+        type_set_t tmp;
+
+        if (type_set_or(&tmp, dst, other))
+                return -1;
+        type_set_destroy(dst);
+        ret = type_set_cpy(dst, &tmp);
+        type_set_destroy(&tmp);
+
+        return ret;
+}
+
+int role_set_get_role(role_set_t *x, uint32_t role)
+{
+        if (x->flags & ROLE_STAR)
+                return 1;
+
+        if (ebitmap_get_bit(&x->roles, role - 1)) {
+                if (x->flags & ROLE_COMP)
+                        return 0;
+                else
+                        return 1;
+        } else {
+                if (x->flags & ROLE_COMP)
+                        return 1;
+                else
+                        return 0;
+        }
+}
+
+/* Insert into a symbol table for a module. This function will handle inserting
+ * the appropriate scope information in addition to inserting the symbol into
+ * the hash table.
+ *
+ * arguments:
+ *   policydb_t *x     module policy to modify
+ *   uint32_t sym             the symbole table for insertion (SYM_*)
+ *   hashtab_key_t key     the key for the symbol - not copied
+ *   hashtab_datum_t data  the data for the symbol - not copied
+ *
+ * returns:
+ *   N                     success - returns the value for the new entry
+ *   -ENOMEM               memory error
+ *   error codes from hashtab_insert
+ *   -1                    general error
+ */
+int symtab_insert(policydb_t *x, uint32_t sym, hashtab_key_t key, hashtab_datum_t data,
+                      uint32_t *value)
+{                     
+        /* fixme - the failures after the hashtab_insert  will leave the policy
+         * in a inconsistent state. */
+        int rc;
+
+        rc = hashtab_insert(x->symtab[sym].table, key, data);
+        if (rc)
+                return rc;
+                
+        /* if no value is passed in the symbol is not primary (i.e. aliases) */
+        if (value)
+                *value = ++x->symtab[sym].nprim;
+        else    
+                return 0;
+                
+        if (x->policy_type == POLICY_BASE)
+                return 0;
+
+	/* The module scoping stuff goes here */
+                
+        return 0;
+}
+
diff -burNd a1/libsepol/src/write.c b/libsepol/src/write.c
--- a1/libsepol/src/write.c	2005-05-25 13:15:54.666227336 -0400
+++ b/libsepol/src/write.c	2005-05-25 13:11:19.465064272 -0400
@@ -10,8 +10,12 @@
  *
  * 	Added conditional policy language extensions
  *
+ * Updated: Joshua Brindle <jbrindle@tresys.com> and Jason Tang <jtang@tresys.org>
+ *
+ *	Module writing support
+ *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003-2005 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -28,6 +32,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <assert.h>
+
 #include <sepol/ebitmap.h>
 #include <sepol/avtab.h>
 #include <sepol/mls.h>
@@ -37,18 +43,19 @@
 #include "private.h"
 
 static unsigned int policyvers = POLICYDB_VERSION_MAX;
+static unsigned int policy_type;
 
-int sepol_set_policyvers(unsigned int version)
-{
-	if (version < POLICYDB_VERSION_MIN ||
-	    version > POLICYDB_VERSION_MAX)
-		return -EINVAL;
+static int avrule_list_write(avrule_t *avrules, struct policy_file *fp);
 
-	/* MLS backwards compatibility to mainline inclusion */
-	if (mls_enabled && (version < POLICYDB_VERSION_MLS))
+int sepol_set_policyvers(unsigned int type, unsigned int version)
+{
+	if (type == POLICY_KERN) {
+		if (version < POLICYDB_VERSION_MIN || version > POLICYDB_VERSION_MAX)
 		return -EINVAL;
+	}
 
 	policyvers = version;
+	policy_type = type;
 	return 0;
 }
 
@@ -78,7 +85,7 @@
 	return 0;
 }
 
-int ebitmap_write(ebitmap_t * e, struct policy_file * fp)
+static int ebitmap_write(ebitmap_t * e, struct policy_file * fp)
 {
 	ebitmap_node_t *n;
 	uint32_t buf[32], bit, count;
@@ -112,7 +119,7 @@
 	return 0;
 }
 
-int avtab_write_item(avtab_ptr_t cur, struct policy_file *fp)
+static int avtab_write_item(avtab_ptr_t cur, struct policy_file *fp)
 {
 	uint32_t buf[32];
 	size_t items, items2;
@@ -154,7 +161,7 @@
 	return 0;
 }
 
-int avtab_write(avtab_t * a, struct policy_file * fp)
+static int avtab_write(avtab_t * a, struct policy_file * fp)
 {
 	int i;
 	avtab_ptr_t cur;
@@ -180,7 +187,7 @@
  * Write a MLS level structure to a policydb binary 
  * representation file.
  */
-int mls_write_level(mls_level_t * l,
+static int mls_write_level(mls_level_t * l,
 		    struct policy_file * fp)
 {
 	uint32_t sens;
@@ -230,7 +237,7 @@
 	return 0;
 }
 
-int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	level_datum_t *levdatum;
 	uint32_t buf[32];
@@ -257,7 +264,7 @@
 	return 0;
 }
 
-int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	cat_datum_t *catdatum;
 	uint32_t buf[32];
@@ -283,7 +290,138 @@
 	return 0;
 }
 
-int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int role_trans_write(role_trans_t *r, struct policy_file *fp) 
+{
+	role_trans_t *tr;
+	uint32_t buf[3];
+	size_t nel, items;
+
+	nel = 0;
+	for (tr = r; tr; tr = tr->next) 
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+	for (tr = r; tr; tr = tr->next) {
+		buf[0] = cpu_to_le32(tr->role);
+		buf[1] = cpu_to_le32(tr->type);
+		buf[2] = cpu_to_le32(tr->new_role);
+		items = put_entry(buf, sizeof(uint32_t), 3, fp);
+		if (items != 3)
+			return -1;		
+	}
+
+	return 0;
+}
+
+static int role_allow_write(role_allow_t *r, struct policy_file *fp)
+{
+	role_allow_t *ra;
+	uint32_t buf[2];
+	size_t nel, items;
+
+	nel = 0;
+	for (ra = r; ra; ra = ra->next) 
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+	for (ra = r; ra; ra = ra->next) {
+		buf[0] = cpu_to_le32(ra->role);
+		buf[1] = cpu_to_le32(ra->new_role);
+		items = put_entry(buf, sizeof(uint32_t), 2, fp);
+		if (items != 2)
+			return -1;		
+	}
+	return 0;
+}
+
+static int role_set_write(role_set_t *x, struct policy_file *fp)
+{
+	size_t items;
+	uint32_t buf[1];
+
+	if (ebitmap_write(&x->roles, fp))
+		return -1;
+
+	buf[0] = cpu_to_le32(x->flags);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+
+	return 0;
+}
+
+static int type_set_write(type_set_t *x, struct policy_file *fp)
+{
+	size_t items;
+	uint32_t buf[1];
+
+	if (ebitmap_write(&x->types, fp))
+		return -1;
+	if (ebitmap_write(&x->negset, fp))
+		return -1;
+        
+	buf[0] = cpu_to_le32(x->flags);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+
+	return 0;
+}
+
+static int role_trans_rule_write(role_trans_rule_t *t, struct policy_file *fp)
+{
+	int nel = 0;
+	size_t items;
+	uint32_t buf[1];
+	role_trans_rule_t *tr;
+
+        for (tr = t; tr; tr = tr->next)
+                nel++;
+        buf[0] = cpu_to_le32(nel);
+        items = put_entry(buf, sizeof(uint32_t), 1, fp);
+        if (items != 1)
+                return -1;
+        for (tr =t; tr; tr = tr->next) {
+		if (role_set_write(&tr->roles, fp))
+			return -1;
+		if (type_set_write(&tr->types, fp))
+			return -1;
+                buf[0] = cpu_to_le32(tr->new_role);
+                items = put_entry(buf, sizeof(uint32_t), 1, fp);
+                if (items != 1)
+                        return -1;
+        }
+	return 0;
+}
+
+static int role_allow_rule_write(role_allow_rule_t *r, struct policy_file * fp)
+{
+	int nel = 0;
+	size_t items;
+	uint32_t buf[1];
+	role_allow_rule_t *ra;
+
+        for (ra = r ; ra; ra = ra->next)
+                nel++;
+        buf[0] = cpu_to_le32(nel);
+        items = put_entry(buf, sizeof(uint32_t), 1, fp);
+        if (items != 1)
+                return -1;
+        for (ra = r; ra; ra = ra->next) {
+		if (role_set_write(&ra->roles, fp))
+			return -1;
+		if (role_set_write(&ra->new_roles, fp))
+			return -1;
+        }
+	return 0;
+}
+
+
+static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	cond_bool_datum_t *booldatum;
 	uint32_t buf[3], len;
@@ -315,7 +453,7 @@
  * the conditional. This means that the avtab with the conditional
  * rules will not be saved but will be rebuilt on policy load.
  */
-int cond_write_av_list(cond_av_list_t *list, struct policy_file *fp)
+static int cond_write_av_list(cond_av_list_t *list, struct policy_file *fp)
 {
 	uint32_t buf[4];
 	cond_av_list_t *cur_list;
@@ -331,18 +469,17 @@
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return -1;
-	if (items == 0)
-		return 0;
 
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
 			if (avtab_write_item(cur_list->node, fp))
 				return -1;
 	}
+
 	return 0;
 }
 
-int cond_write_node(cond_node_t *node, struct policy_file *fp)
+static int cond_write_node(cond_node_t *node, struct policy_file *fp)
 {
 	cond_expr_t *cur_expr;
 	uint32_t buf[2];
@@ -372,17 +509,23 @@
 			return -1;
 	}
 
+        if (policy_type == POLICY_KERN) {
 	if (cond_write_av_list(node->true_list, fp) != 0)
 		return -1;
 	if (cond_write_av_list(node->false_list, fp) != 0)
 		return -1;
+	} else {
+		if (avrule_list_write(node->avtrue_list, fp))
+			return -1;
+		if (avrule_list_write(node->avfalse_list, fp))
+			return -1;
+	}
 	
 	return 0;
 }
 
-int cond_write_list(cond_list_t *list, void *p)
+static int cond_write_list(cond_list_t *list, struct policy_file *fp)
 {
-	struct policy_file *fp = p;
 	cond_node_t *cur;
 	uint32_t len, items;
 	uint32_t buf[1];
@@ -396,7 +539,7 @@
 		return -1;
 
 	for (cur = list; cur != NULL; cur = cur->next) {
-		if (cond_write_node(cur, p) != 0)
+		if (cond_write_node(cur, fp) != 0)
 			return -1;
 	}
 	return 0;
@@ -619,9 +762,13 @@
 
 	if (ebitmap_write(&role->dominates, fp))
 		return -1;
-
-	if (ebitmap_write(&role->types, fp))
+	if (policy_type == POLICY_KERN) {
+		if (ebitmap_write(&role->types.types, fp))
+			return -1;
+	} else {
+		if (type_set_write(&role->types, fp))
 		return -1;
+	}
 
 	return 0;
 }
@@ -640,10 +787,18 @@
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(typdatum->value);
 	buf[items++] = cpu_to_le32(typdatum->primary);
+	if (policy_type != POLICY_KERN) {
+		buf[items++] = cpu_to_le32(typdatum->isattr);
+	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return -1;
 
+	if (policy_type != POLICY_KERN) {
+		if (ebitmap_write(&typdatum->types, fp))
+			return -1;
+	}
+
 	items = put_entry(key, 1, len, fp);
 	if (items != len)
 		return -1;
@@ -673,9 +828,13 @@
 	if (items != len)
 		return -1;
 
-	if (ebitmap_write(&usrdatum->roles, fp))
+	if (policy_type == POLICY_KERN) {
+		if (ebitmap_write(&usrdatum->roles.roles, fp))
 		return -1;
-
+	} else {
+		if (role_set_write(&usrdatum->roles, fp))
+			return -1;
+	}
 	if (policyvers >= POLICYDB_VERSION_MLS) {
 		if (mls_write_range_helper(&usrdatum->range, fp))
 			return -1;
@@ -699,112 +858,12 @@
 	cat_write,
 };
 
-
-/*
- * Write the configuration data in a policy database
- * structure to a policy database binary representation
- * file.
- */
-int policydb_write(policydb_t * p, struct policy_file * fp)
-{
-	struct role_allow *ra;
-	struct role_trans *tr;
-	struct range_trans *rt;
+static int ocontext_write (struct policydb_compat_info *info, policydb_t * p,
+                           struct policy_file * fp) {
+        int i, j;
+        size_t nel, items, len;
+	uint32_t buf[32];
 	ocontext_t *c;
-	genfs_t *genfs;
-	int i, j, num_syms;
-	uint32_t buf[32], config;
-	size_t items, items2, len, nel;
-	struct policydb_compat_info *info;
-	char *policydb_str = POLICYDB_STRING;
-
-	config = 0;
-	if (mls_enabled)
-		config |= POLICYDB_CONFIG_MLS;
-
-	/* Write the magic number and string identifiers. */
-	items = 0;
-	buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
-	len = strlen(POLICYDB_STRING);
-	buf[items++] = cpu_to_le32(len);
-	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-	if (items != items2)
-		return -1;
-	items = put_entry(policydb_str, 1, len, fp);
-	if (items != len)
-		return -1;
-
-	/* Write the version, config, and table sizes. */
-	items = 0;
-	info = policydb_lookup_compat(policyvers);
-	if (!info) {
-		fprintf(stderr, "policydb_lookup_compat() failed for %d\n", policyvers);
-		return -1;
-	}
-
-	buf[items++] = cpu_to_le32(policyvers);
-	buf[items++] = cpu_to_le32(config);
-	buf[items++] = cpu_to_le32(info->sym_num);
-	buf[items++] = cpu_to_le32(info->ocon_num);
-	
-	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-	if (items != items2)
-		return -1;
-
-	num_syms = info->sym_num;
-	for (i = 0; i < num_syms; i++) {
-		buf[0] = cpu_to_le32(p->symtab[i].nprim);
-		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
-		items = put_entry(buf, sizeof(uint32_t), 2, fp);
-		if (items != 2)
-			return -1;
-		if (hashtab_map(p->symtab[i].table, write_f[i], fp))
-			return -1;
-	}
-
-	if (avtab_write(&p->te_avtab, fp))
-		return -1;
-
-	if (policyvers < POLICYDB_VERSION_BOOL) {
-		if (p->p_bools.nprim)
-			fprintf(stderr, "warning: discarding booleans and conditional rules\n");
-
-	} else {
-		if (cond_write_list(p->cond_list, fp))
-			return -1;
-	}
-
-	nel = 0;
-	for (tr = p->role_tr; tr; tr = tr->next) 
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return -1;
-	for (tr = p->role_tr; tr; tr = tr->next) {
-		buf[0] = cpu_to_le32(tr->role);
-		buf[1] = cpu_to_le32(tr->type);
-		buf[2] = cpu_to_le32(tr->new_role);
-		items = put_entry(buf, sizeof(uint32_t), 3, fp);
-		if (items != 3)
-			return -1;		
-	}
-
-	nel = 0;
-	for (ra = p->role_allow; ra; ra = ra->next) 
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return -1;
-	for (ra = p->role_allow; ra; ra = ra->next) {
-		buf[0] = cpu_to_le32(ra->role);
-		buf[1] = cpu_to_le32(ra->new_role);
-		items = put_entry(buf, sizeof(uint32_t), 2, fp);
-		if (items != 2)
-			return -1;		
-	}
-
 	for (i = 0; i < info->ocon_num; i++) {
 		nel = 0;
 		for (c = p->ocontexts[i]; c; c = c->next)
@@ -823,7 +882,7 @@
 				if (context_write(&c->context[0], fp))
 					return -1;
 				break;
-			case OCON_FS:
+			case OCON_FS:  /* FALLTHROUGH */
 			case OCON_NETIF:
 				len = strlen(c->u.name);
 				buf[0] = cpu_to_le32(len);
@@ -884,11 +943,25 @@
 				if (context_write(&c->context[0], fp))
 					return -1;
 				break;	
+                        /* FIX ME: policy-server will need the SID
+                           name, stored in c->u.name.  Thus create a new
+                           ocontext chain (OCON_USER, maybe?) and read/write
+                           the relevant information */
+                        default:
+                                /* should never get here */
+                                assert(0);
 			}
 		}
 	}
+        return 0;
+}
+
+static int genfs_write (policydb_t *p, struct policy_file *fp) {
+        genfs_t *genfs;
+        ocontext_t *c;
+        size_t nel = 0, items, len;
+        uint32_t buf[32];
 
-	nel = 0;
 	for (genfs = p->genfs; genfs; genfs = genfs->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
@@ -928,8 +1001,16 @@
 				return -1;
 		}
 	}
+        return 0;
+}
 
-	if (policyvers >= POLICYDB_VERSION_MLS) {
+/* FIX ME: do policycon write here */
+
+static int range_write(policydb_t *p, struct policy_file *fp)
+{
+        size_t nel, items;
+        struct range_trans *rt;
+        uint32_t buf[32];
 		nel = 0;
 		for (rt = p->range_tr; rt; rt = rt->next)
 			nel++;
@@ -946,8 +1027,193 @@
 			if (mls_write_range_helper(&rt->range, fp))
 				return -1;
 		}
+        return 0;
+}
+
+static int avrule_write(avrule_t *avrule, struct policy_file *fp)
+{
+	size_t items, items2;
+	uint32_t buf[32], len;
+	class_perm_node_t *cur;
+
+	items = 0;
+	buf[items++] = cpu_to_le32(avrule->specified);
+	buf[items++] = cpu_to_le32(avrule->flags);
+	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
+	if (items2 != items)
+		return -1;
+
+	if (type_set_write(&avrule->stypes, fp))
+		return -1;
+
+	if (type_set_write(&avrule->ttypes, fp))
+		return -1;
+
+	cur = avrule->perms;
+	len = 0;
+	while (cur) {
+		len++;
+		cur = cur->next;
+	}
+	items = 0;
+	buf[items++] = cpu_to_le32(len);
+	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
+	if (items2 != items)
+		return -1;
+	cur = avrule->perms;
+	while (cur) {
+		items = 0;
+		buf[items++] = cpu_to_le32(cur->class);
+		buf[items++] = cpu_to_le32(cur->data);
+		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
+		if (items2 != items)
+			return -1;
+		
+		cur = cur->next;
 	}
 
 	return 0;
 }
 
+static int avrule_list_write(avrule_t *avrules, struct policy_file *fp)
+{
+	uint32_t buf[32], len;
+	avrule_t *avrule;
+
+	avrule = avrules;
+	len = 0;
+	while (avrule) {
+		len++;
+		avrule = avrule->next;
+	}
+
+	buf[0] = cpu_to_le32(len);
+	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1)
+		return -1;
+
+	avrule = avrules;
+	while (avrule) {
+		avrule_write(avrule, fp);
+		avrule = avrule->next;
+	}
+
+	return 0;
+}
+
+/*
+ * Write the configuration data in a policy database
+ * structure to a policy database binary representation
+ * file.
+ */
+int policydb_write(policydb_t * p, struct policy_file * fp)
+{
+	int i, num_syms;
+	uint32_t buf[32], config;
+	size_t items, items2, len;
+	struct policydb_compat_info *info;
+	char *policydb_str;
+
+	config = 0;
+	if (sepol_mls_enabled())
+		config |= POLICYDB_CONFIG_MLS;
+
+	/* Write the magic number and string identifiers. */
+	items = 0;
+        if (p->policy_type == POLICY_KERN) {
+		buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
+		len = strlen(POLICYDB_STRING);
+		policydb_str = POLICYDB_STRING;
+	} else {
+		buf[items++] = cpu_to_le32(POLICYDB_MOD_MAGIC);
+		len = strlen(POLICYDB_MOD_STRING);
+		policydb_str = POLICYDB_MOD_STRING;
+	}
+	buf[items++] = cpu_to_le32(len);
+	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
+	if (items != items2)
+		return -1;
+	items = put_entry(policydb_str, 1, len, fp);
+	if (items != len)
+		return -1;
+
+	/* Write the version, config, and table sizes. */
+	items = 0;
+	info = policydb_lookup_compat(policyvers, p->policy_type);
+	if (!info) {
+		fprintf(stderr, "policydb_lookup_compat() failed for %d\n", policyvers);
+		return -1;
+	}
+
+	buf[items++] = cpu_to_le32(policyvers);
+        if (p->policy_type != POLICY_KERN) {
+		buf[items++] = cpu_to_le32(p->policy_type);
+	}
+	buf[items++] = cpu_to_le32(config);
+	buf[items++] = cpu_to_le32(info->sym_num);
+	buf[items++] = cpu_to_le32(info->ocon_num);
+	
+	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
+	if (items != items2)
+		return -1;
+        
+        if (p->policy_type == POLICY_MOD) {
+                /* FIX ME: write module version here */
+                /*...*/
+                assert(0);
+        } 
+	num_syms = info->sym_num;
+	for (i = 0; i < num_syms; i++) {
+                
+		buf[0] = cpu_to_le32(p->symtab[i].nprim);
+		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
+		items = put_entry(buf, sizeof(uint32_t), 2, fp);
+		if (items != 2)
+			return -1;
+		if (hashtab_map(p->symtab[i].table, write_f[i], fp))
+			return -1;
+	}
+
+	if (p->policy_type == POLICY_KERN) {
+		if (avtab_write(&p->te_avtab, fp))
+			return -1;
+        }
+
+	if (p->policy_type == POLICY_KERN && policyvers < POLICYDB_VERSION_BOOL) {
+		if (p->p_bools.nprim)
+			fprintf(stderr, "warning: discarding booleans and conditional rules\n");
+
+	} else if (p->policy_type == POLICY_KERN) {
+		if (cond_write_list(p->cond_list, fp))
+			return -1;
+	}
+
+	if (p->policy_type == POLICY_KERN) {
+		if (role_trans_write(p->role_tr, fp))
+			return -1;
+
+		if (role_allow_write(p->role_allow, fp))
+			return -1;
+	} else {
+		
+		if (role_trans_rule_write(p->role_tr_rules, fp))
+			return -1;
+
+		if (role_allow_rule_write(p->role_allow_rules, fp))
+			return -1;
+	}
+
+        if (ocontext_write(info, p, fp) == -1) {
+                return -1;
+        }
+        if (genfs_write(p, fp) == -1) {
+                return -1;
+        }
+        
+	if (policyvers >= POLICYDB_VERSION_MLS) {
+                if (range_write(p, fp)) {
+                        return -1;
+                }
+	}
+
+	return 0;
+}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
