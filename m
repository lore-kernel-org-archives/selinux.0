Message-ID: <48C5D9A7.7090909@ak.jp.nec.com>
Date: Tue, 09 Sep 2008 11:04:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, jmorris@namei.org, paul.moore@hp.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp>
In-Reply-To: <48BC141F.2060802@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The attached patch for libsepol add suport for a new policy version
named as (MOD_)POLICYDB_VERSION_BOUNDARY.
Userspace hierarchy checks are reworked in this revision.

FEATURES:

- Boundary feature support:
  The upcoming kernel has a feature to define boundary relationship
  between two users, roles and types. It enables to restrict a bounded
  one can never have wider permissions than its bounds one.
  Any XXXX_datum_t structure have "u32 bounds" member to indicate its
  bounds, and we can handle it with the latest version of policy format
  provided by this patch.

- Loading attributes into kernel space:
  The upcoming kernel also allows to load entries of attribute.
  The attached patch turn off to drop them, when it tries to write
  kernel policy with its version is equal or greater than
  POLICYDB_VERSION_BOUNDARY.
  Any entries of attribute has a property of TYPEDATUM_PROPERTY_ATTRIBUTE.

- Improvement of type_datum format on kernel/modular policy.
  The type_datum entry has several its attribute fields like "primary",
  "flavor" and "flags", and these are stored within separated fields
  on-disk format. This patch enables to pack them into a single field.
  Currently four bits are defined, and rest of them are reserved.
    #define TYPEDATUM_PROPERTY_PRIMARY      0x0001
    #define TYPEDATUM_PROPERTY_ATTRIBUTE    0x0002
    #define TYPEDATUM_PROPERTY_ALIAS        0x0004  /* userspace only */
    #define TYPEDATUM_PROPERTY_PERMISSIVE   0x0008  /* userspace only */

- Hierarchy checks are reworked
  The existing userspace hierarchy checks are reworked for the upcoming
  boundary feature. It can handle parent one based on both newer bounds
  relationship and existing name-based hierarchy.

  In addition, I put a trick to evaluate conditional rules correctly.
  The following example shows a confusable case. A_t is the bounds of B_t,
  so B_t can never has wider permission than A_t.

  Example)
    allow B_t X_t : file { read_file_perms };
    if (A_can_write_X) {
        allow A_t X_t : file { write_file_perms };
    } else {
        allow A_t X_t : file { read_file_perms };
    }

  A_t's permissions on X_t is depend on the 'A_can_write_X', however,
  a part of them, like 'read', are unconditionally allowed.
  If we can find common permission on both of true/false lists, these
  are pulled up to unconditional rules.
  Thus, B_t's read permission on X_t is not hierarchy violated in the
  above example. It also matches the upcoming kernel behavior no need
  to say.

Thanks,

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
---
  include/sepol/policydb/policydb.h |   28 ++
  src/expand.c                      |  132 +++++++++--
  src/hierarchy.c                   |  436 +++++++++++++++++++++-----------------
  src/link.c                        |  108 +++++++++
  src/policydb.c                    |   72 +++++-
  src/write.c                       |   54 +++-
  6 files changed, 585 insertions(+), 245 deletions(-)
---
Index: libsepol/include/sepol/policydb/policydb.h
===================================================================
--- libsepol/include/sepol/policydb/policydb.h	(revision 2950)
+++ libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -119,6 +119,7 @@
  	ebitmap_t dominates;	/* set of roles dominated by this role */
  	type_set_t types;	/* set of authorized types for role */
  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
+	uint32_t bounds;	/* bounds role, if exist */
  } role_datum_t;

  typedef struct role_trans {
@@ -145,8 +146,18 @@
  	ebitmap_t types;	/* types with this attribute */
  #define TYPE_FLAGS_PERMISSIVE	0x01
  	uint32_t flags;
+	uint32_t bounds;	/* bounds type, if exist */
  } type_datum_t;

+/*
+ * Properties of type_datum
+ * available on the policy version >= (MOD_)POLICYDB_VERSION_BOUNDARY
+ */
+#define TYPEDATUM_PROPERTY_PRIMARY	0x0001
+#define TYPEDATUM_PROPERTY_ATTRIBUTE	0x0002
+#define TYPEDATUM_PROPERTY_ALIAS	0x0004	/* userspace only */
+#define TYPEDATUM_PROPERTY_PERMISSIVE	0x0008	/* userspace only */
+
  /* User attributes */
  typedef struct user_datum {
  	symtab_datum_t s;
@@ -156,6 +167,7 @@
  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
  	mls_range_t exp_range;     /* expanded range used for validation */
  	mls_level_t exp_dfltlevel; /* expanded range used for validation */
+	uint32_t bounds;	/* bounds user, if exist */
  } user_datum_t;

  /* Sensitivity attributes */
@@ -595,10 +607,11 @@
  #define POLICYDB_VERSION_RANGETRANS	21
  #define POLICYDB_VERSION_POLCAP		22
  #define POLICYDB_VERSION_PERMISSIVE	23
+#define POLICYDB_VERSION_BOUNDARY	24

  /* Range of policy versions we understand*/
  #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY

  /* Module versions and specific changes*/
  #define MOD_POLICYDB_VERSION_BASE	   4
@@ -608,12 +621,23 @@
  #define MOD_POLICYDB_VERSION_MLS_USERS	   6
  #define MOD_POLICYDB_VERSION_POLCAP	   7
  #define MOD_POLICYDB_VERSION_PERMISSIVE	   8
+#define MOD_POLICYDB_VERSION_BOUNDARY      9

  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PERMISSIVE
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_BOUNDARY

  #define POLICYDB_CONFIG_MLS    1

+/* macros to check policy feature */
+
+/* TODO: add other features here */
+
+#define policydb_has_boundary_feature(p)			\
+	(((p)->policy_type == POLICY_KERN			\
+	  && p->policyvers >= POLICYDB_VERSION_BOUNDARY) ||	\
+	 ((p)->policy_type != POLICY_KERN			\
+	  && p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY))
+
  /* the config flags related to unknown classes/perms are bits 2 and 3 */
  #define DENY_UNKNOWN	SEPOL_DENY_UNKNOWN
  #define REJECT_UNKNOWN	SEPOL_REJECT_UNKNOWN
Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 2950)
+++ libsepol/src/policydb.c	(working copy)
@@ -110,6 +110,12 @@
  	 .sym_num = SYM_NUM,
  	 .ocon_num = OCON_NODE6 + 1,
  	 },
+        {
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_BOUNDARY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	},
  	{
  	 .type = POLICY_BASE,
  	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -141,6 +147,12 @@
  	 .ocon_num = OCON_NODE6 + 1,
  	 },
  	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_BOUNDARY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	},
+	{
  	 .type = POLICY_MOD,
  	 .version = MOD_POLICYDB_VERSION_BASE,
  	 .sym_num = SYM_NUM,
@@ -170,6 +182,12 @@
  	 .sym_num = SYM_NUM,
  	 .ocon_num = 0
  	 },
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_BOUNDARY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	},
  };

  #if 0
@@ -1855,20 +1873,25 @@
  {
  	char *key = 0;
  	role_datum_t *role;
-	uint32_t buf[2];
+	uint32_t buf[3];
  	size_t len;
-	int rc;
+	int rc, to_read = 2;

  	role = calloc(1, sizeof(role_datum_t));
  	if (!role)
  		return -1;

-	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (policydb_has_boundary_feature(p))
+		to_read = 3;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
  	if (rc < 0)
  		goto bad;

  	len = le32_to_cpu(buf[0]);
  	role->s.value = le32_to_cpu(buf[1]);
+	if (policydb_has_boundary_feature(p))
+		role->bounds = le32_to_cpu(buf[2]);

  	key = malloc(len + 1);
  	if (!key)
@@ -1924,7 +1947,9 @@
  	if (!typdatum)
  		return -1;

-	if (p->policy_type == POLICY_KERN)
+	if (policydb_has_boundary_feature(p))
+		to_read = 4;
+	else if (p->policy_type == POLICY_KERN)
  		to_read = 3;
  	else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
  		to_read = 5;
@@ -1937,11 +1962,31 @@

  	len = le32_to_cpu(buf[0]);
  	typdatum->s.value = le32_to_cpu(buf[1]);
-	typdatum->primary = le32_to_cpu(buf[2]);
+	if (policydb_has_boundary_feature(p)) {
+		uint32_t properties = le32_to_cpu(buf[2]);
+
+		if (properties & TYPEDATUM_PROPERTY_PRIMARY)
+			typdatum->primary = 1;
+		if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
+			typdatum->flavor = TYPE_ATTRIB;
+		if (properties & TYPEDATUM_PROPERTY_ALIAS
+		    && p->policy_type != POLICY_KERN)
+			typdatum->flavor = TYPE_ALIAS;
+		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
+		    && p->policy_type != POLICY_KERN)
+			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+
+		typdatum->bounds = le32_to_cpu(buf[3]);
+	} else {
+		typdatum->primary = le32_to_cpu(buf[2]);
+		if (p->policy_type != POLICY_KERN) {
+			typdatum->flavor = le32_to_cpu(buf[3]);
+			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+				typdatum->flags = le32_to_cpu(buf[4]);
+		}
+	}
+
  	if (p->policy_type != POLICY_KERN) {
-		typdatum->flavor = le32_to_cpu(buf[3]);
-		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-			typdatum->flags = le32_to_cpu(buf[4]);
  		if (ebitmap_read(&typdatum->types, fp))
  			goto bad;
  	}
@@ -2293,20 +2338,25 @@
  {
  	char *key = 0;
  	user_datum_t *usrdatum;
-	uint32_t buf[2];
+	uint32_t buf[3];
  	size_t len;
-	int rc;
+	int rc, to_read = 2;

  	usrdatum = calloc(1, sizeof(user_datum_t));
  	if (!usrdatum)
  		return -1;

-	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+	if (policydb_has_boundary_feature(p))
+		to_read = 3;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
  	if (rc < 0)
  		goto bad;

  	len = le32_to_cpu(buf[0]);
  	usrdatum->s.value = le32_to_cpu(buf[1]);
+	if (policydb_has_boundary_feature(p))
+		usrdatum->bounds = le32_to_cpu(buf[2]);

  	key = malloc(len + 1);
  	if (!key)
Index: libsepol/src/hierarchy.c
===================================================================
--- libsepol/src/hierarchy.c	(revision 2950)
+++ libsepol/src/hierarchy.c	(working copy)
@@ -1,11 +1,16 @@
  /* Authors: Joshua Brindle <jbrindle@tresys.com>
   * 	    Jason Tang <jtang@tresys.com>
   *
+ * Updates: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ *          adds checks based on newer boundary facility.
+ *
   * A set of utility functions that aid policy decision when dealing
   * with hierarchal namespaces.
   *
   * Copyright (C) 2005 Tresys Technology, LLC
   *
+ * Copyright (c) 2008 NEC Corporation
+ *
   *  This library is free software; you can redistribute it and/or
   *  modify it under the terms of the GNU Lesser General Public
   *  License as published by the Free Software Foundation; either
@@ -41,36 +46,77 @@
  	int numerr;
  } hierarchy_args_t;

-/* This merely returns the string part before the last '.'
- * it does no verification of the existance of the parent
- * in the policy, you must do this yourself.
+/*
+ * find_parent_(type|role|user)
   *
- * Caller must free parent after use.
+ * This function returns the parent datum of given XXX_datum_t
+ * object or NULL, if it doesn't exist.
+ *
+ * If the given datum has a valid bounds, this function merely
+ * returns the indicated object. Otherwise, it looks up the
+ * parent based on the based hierarchy.
   */
-static int find_parent(char *type, char **parent)
+#define find_parent_template(prefix)				\
+int find_parent_##prefix(hierarchy_args_t *a,			\
+			 prefix##_datum_t *datum,		\
+			 prefix##_datum_t **parent)		\
+{								\
+	char *parent_name, *datum_name, *tmp;			\
+								\
+	if (datum->bounds)						\
+		*parent = a->p->prefix##_val_to_struct[datum->bounds - 1]; \
+	else {								\
+		datum_name = a->p->p_##prefix##_val_to_name[datum->s.value - 1]; \
+									\
+		tmp = strrchr(datum_name, '.');				\
+		/* no '.' means it has no parent */			\
+		if (!tmp) {						\
+			*parent = NULL;					\
+			return 0;					\
+		}							\
+									\
+		parent_name = strdup(datum_name);			\
+		if (!parent_name)					\
+			return -1;					\
+		parent_name[tmp - datum_name] = '\0';			\
+									\
+		*parent = hashtab_search(a->p->p_##prefix##s.table, parent_name); \
+		if (!*parent) {						\
+			/* Orphan type/role/user */			\
+			ERR(a->handle,					\
+			    "%s doesn't exist, %s is an orphan",	\
+			    parent_name,				\
+			    a->p->p_##prefix##_val_to_name[datum->s.value - 1]); \
+			free(parent_name);				\
+			return -1;					\
+		}							\
+		free(parent_name);					\
+	}								\
+									\
+	return 0;							\
+}
+
+static find_parent_template(type)
+static find_parent_template(role)
+static find_parent_template(user)
+
+static void compute_avtab_datum(hierarchy_args_t *args,
+				avtab_key_t *key,
+				avtab_datum_t *result)
  {
-	char *tmp;
-	int len;
+	avtab_datum_t *avdatp;
+	uint32_t av = 0;

-	assert(type);
-
-	tmp = strrchr(type, '.');
-	/* no '.' means it has no parent */
-	if (!tmp) {
-		*parent = NULL;
-		return 0;
+	avdatp = avtab_search(args->expa, key);
+	if (avdatp)
+		av = avdatp->data;
+	if (args->opt_cond_list) {
+		avdatp = cond_av_list_search(key, args->opt_cond_list);
+		if (avdatp)
+			av |= avdatp->data;
  	}

-	/* allocate buffer for part of string before the '.' */
-	len = tmp - type;
-	*parent = (char *)malloc(sizeof(char) * (len + 1));
-
-	if (!(*parent))
-		return -1;
-	memcpy(*parent, type, len);
-	(*parent)[len] = '\0';
-
-	return 0;
+	result->data = av;
  }

  /* This function verifies that the type passed in either has a parent or is in the
@@ -79,41 +125,26 @@
  static int check_type_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d,
  					 void *args)
  {
-	char *parent;
  	hierarchy_args_t *a;
-	type_datum_t *t, *t2;
-	char *key;
+	type_datum_t *t, *tp;

  	a = (hierarchy_args_t *) args;
  	t = (type_datum_t *) d;
-	key = (char *)k;

  	if (t->flavor == TYPE_ATTRIB) {
  		/* It's an attribute, we don't care */
  		return 0;
  	}
-
-	if (find_parent(key, &parent))
+	if (find_parent_type(a, t, &tp) < 0)
  		return -1;

-	if (!parent) {
-		/* This type is in the root namespace */
-		return 0;
-	}
-
-	t2 = hashtab_search(a->p->p_types.table, parent);
-	if (!t2) {
-		/* If the parent does not exist this type is an orphan, not legal */
-		ERR(a->handle, "type %s does not exist, %s is an orphan",
-		    parent, a->p->p_type_val_to_name[t->s.value - 1]);
-		a->numerr++;
-	} else if (t2->flavor == TYPE_ATTRIB) {
+	if (tp && tp->flavor == TYPE_ATTRIB) {
  		/* The parent is an attribute but the child isn't, not legal */
-		ERR(a->handle, "type %s is a child of an attribute",
-		    a->p->p_type_val_to_name[t->s.value - 1]);
+		ERR(a->handle, "type %s is a child of an attribute %s",
+		    (char *) k, a->p->p_type_val_to_name[tp->s.value - 1]);
  		a->numerr++;
+		return -1;
  	}
-	free(parent);
  	return 0;
  }

@@ -126,136 +157,176 @@
  static int check_avtab_hierarchy_callback(avtab_key_t * k, avtab_datum_t * d,
  					  void *args)
  {
-	char *parent;
  	avtab_key_t key;
-	avtab_datum_t *avdatump;
-	hierarchy_args_t *a;
-	uint32_t av = 0;
-	type_datum_t *t = NULL, *t2 = NULL;
+	hierarchy_args_t *a = (hierarchy_args_t *) args;
+	type_datum_t *s, *t1 = NULL, *t2 = NULL;
+	avtab_datum_t av;

  	if (!(k->specified & AVTAB_ALLOWED)) {
  		/* This is not an allow rule, no checking done */
  		return 0;
  	}

-	a = (hierarchy_args_t *) args;
-	if (find_parent(a->p->p_type_val_to_name[k->source_type - 1], &parent))
+	/* search for parent first */
+	s = a->p->type_val_to_struct[k->source_type - 1];
+	if (find_parent_type(a, s, &t1) < 0)
  		return -1;
-
-	/* search for parent first */
-	if (parent) {
-		t = hashtab_search(a->p->p_types.table, parent);
-		if (!t) {
-			/* This error was already covered by type_check_hierarchy */
-			free(parent);
-			return 0;
-		}
-		free(parent);
-
-		key.source_type = t->s.value;
+	if (t1) {
+		/*
+		 * search for access allowed between type 1's
+		 * parent and type 2.
+		 */
+		key.source_type = t1->s.value;
  		key.target_type = k->target_type;
  		key.target_class = k->target_class;
  		key.specified = AVTAB_ALLOWED;
+		compute_avtab_datum(a, &key, &av);

-		avdatump = avtab_search(a->expa, &key);
-		if (avdatump) {
-			/* search for access allowed between type 1's parent and type 2 */
-			if ((avdatump->data & d->data) == d->data) {
-				return 0;
-			}
-			av = avdatump->data;
-		}
-		if (a->opt_cond_list) {
-			/* if a conditional list is present search it before continuing */
-			avdatump = cond_av_list_search(&key, a->opt_cond_list);
-			if (avdatump) {
-				if (((av | avdatump->data) & d->data) ==
-				    d->data) {
-					return 0;
-				}
-			}
-		}
+		if ((av.data & d->data) == d->data)
+			return 0;
  	}

  	/* next we try type 1 and type 2's parent */
-	if (find_parent(a->p->p_type_val_to_name[k->target_type - 1], &parent))
+	s = a->p->type_val_to_struct[k->target_type - 1];
+	if (find_parent_type(a, s, &t2) < 0)
  		return -1;
-
-	if (parent) {
-		t2 = hashtab_search(a->p->p_types.table, parent);
-		if (!t2) {
-			/* This error was already covered by type_check_hierarchy */
-			free(parent);
-			return 0;
-		}
-		free(parent);
-
+	if (t2) {
+		/*
+		 * search for access allowed between type 1 and
+		 * type 2's parent.
+		 */
  		key.source_type = k->source_type;
  		key.target_type = t2->s.value;
  		key.target_class = k->target_class;
  		key.specified = AVTAB_ALLOWED;
+		compute_avtab_datum(a, &key, &av);

-		avdatump = avtab_search(a->expa, &key);
-		if (avdatump) {
-			if ((avdatump->data & d->data) == d->data) {
-				return 0;
-			}
-			av = avdatump->data;
-		}
-		if (a->opt_cond_list) {
-			/* if a conditional list is present search it before continuing */
-			avdatump = cond_av_list_search(&key, a->opt_cond_list);
-			if (avdatump) {
-				if (((av | avdatump->data) & d->data) ==
-				    d->data) {
-					return 0;
-				}
-			}
-		}
+		if ((av.data & d->data) == d->data)
+			return 0;
  	}

-	if (t && t2) {
-		key.source_type = t->s.value;
+	if (t1 && t2) {
+		/*
+                 * search for access allowed between type 1's parent
+                 * and type 2's parent.
+                 */
+		key.source_type = t1->s.value;
  		key.target_type = t2->s.value;
  		key.target_class = k->target_class;
  		key.specified = AVTAB_ALLOWED;
+		compute_avtab_datum(a, &key, &av);

-		avdatump = avtab_search(a->expa, &key);
-		if (avdatump) {
-			if ((avdatump->data & d->data) == d->data) {
-				return 0;
-			}
-			av = avdatump->data;
-		}
-		if (a->opt_cond_list) {
-			/* if a conditional list is present search it before continuing */
-			avdatump = cond_av_list_search(&key, a->opt_cond_list);
-			if (avdatump) {
-				if (((av | avdatump->data) & d->data) ==
-				    d->data) {
-					return 0;
-				}
-			}
-		}
+		if ((av.data & d->data) == d->data)
+			return 0;
  	}

-	if (!t && !t2) {
-		/* Neither one of these types have parents and
-		 * therefore the hierarchical constraint does not apply */
+	/*
+	 * Neither one of these types have parents and
+	 * therefore the hierarchical constraint does not apply
+	 */
+	if (!t1 && !t2)
  		return 0;
-	}

-	/* At this point there is a violation of the hierarchal constraint, send error condition back */
+	/*
+	 * At this point there is a violation of the hierarchal
+	 * constraint, send error condition back
+	 */
  	ERR(a->handle,
  	    "hierarchy violation between types %s and %s : %s { %s }",
  	    a->p->p_type_val_to_name[k->source_type - 1],
  	    a->p->p_type_val_to_name[k->target_type - 1],
  	    a->p->p_class_val_to_name[k->target_class - 1],
-	    sepol_av_to_string(a->p, k->target_class, d->data & ~av));
+	    sepol_av_to_string(a->p, k->target_class, d->data & ~av.data));
  	a->numerr++;
  	return 0;
  }

+/*
+ * If same permissions are allowed for same combination of
+ * source and target, we can evaluate them as unconditional
+ * one.
+ * See the following example. A_t type is bounds of B_t type,
+ * so B_t can never have wider permissions then A_t.
+ * A_t has conditional permission on X_t, however, a part of
+ * them (getattr and read) are unconditionaly allowed to A_t.
+ *
+ * Example)
+ * typebounds A_t B_t;
+ *
+ * allow B_t X_t : file { getattr };
+ * if (foo_bool) {
+ *     allow A_t X_t : file { getattr read };
+ * } else {
+ *     allow A_t X_t : file { getattr read write };
+ * }
+ *
+ * We have to pull up them as unconditional ones in this case,
+ * because it seems to us B_t is violated to bounds constraints
+ * during unconditional policy checking.
+ */
+static int pullup_unconditional_perms(cond_list_t * cond_list,
+				      hierarchy_args_t * args)
+{
+	cond_list_t *cur_node;
+	cond_av_list_t *cur_av, *expl_true = NULL, *expl_false = NULL;
+	avtab_t expa_true, expa_false;
+	avtab_datum_t *avdatp;
+	avtab_datum_t avdat;
+	avtab_ptr_t avnode;
+
+	for (cur_node = cond_list; cur_node; cur_node = cur_node->next) {
+		if (avtab_init(&expa_true))
+			goto oom0;
+		if (avtab_init(&expa_false))
+			goto oom1;
+		if (expand_cond_av_list(args->p, cur_node->true_list,
+					&expl_true, &expa_true))
+			goto oom2;
+		if (expand_cond_av_list(args->p, cur_node->false_list,
+					&expl_false, &expa_false))
+			goto oom3;
+		for (cur_av = expl_true; cur_av; cur_av = cur_av->next) {
+			avdatp = avtab_search(&expa_false,
+					      &cur_av->node->key);
+			if (!avdatp)
+				continue;
+
+			avdat.data = (cur_av->node->datum.data
+				      & avdatp->data);
+			if (!avdat.data)
+				continue;
+
+			avnode = avtab_search_node(args->expa,
+						   &cur_av->node->key);
+			if (avnode) {
+				avnode->datum.data |= avdat.data;
+			} else {
+				if (avtab_insert(args->expa,
+						 &cur_av->node->key,
+						 &avdat))
+					goto oom4;
+			}
+		}
+		cond_av_list_destroy(expl_false);
+		cond_av_list_destroy(expl_true);
+		avtab_destroy(&expa_false);
+		avtab_destroy(&expa_true);
+	}
+	return 0;
+
+oom4:
+	cond_av_list_destroy(expl_false);
+oom3:
+	cond_av_list_destroy(expl_true);
+oom2:
+	avtab_destroy(&expa_false);
+oom1:
+	avtab_destroy(&expa_true);
+oom0:
+	ERR(args->handle, "out of memory on conditional av list expansion");
+        return 1;
+}
+
  static int check_cond_avtab_hierarchy(cond_list_t * cond_list,
  				      hierarchy_args_t * args)
  {
@@ -264,37 +335,51 @@
  	cond_av_list_t *cur_av, *expl = NULL;
  	avtab_t expa;
  	hierarchy_args_t *a = (hierarchy_args_t *) args;
+	avtab_datum_t avdat, *uncond;

-	for (cur_node = cond_list; cur_node != NULL; cur_node = cur_node->next) {
+	for (cur_node = cond_list; cur_node; cur_node = cur_node->next) {
+		/*
+		 * Check true condition
+		 */
  		if (avtab_init(&expa))
  			goto oom;
-		if (expand_cond_av_list
-		    (args->p, cur_node->true_list, &expl, &expa)) {
+		if (expand_cond_av_list(args->p, cur_node->true_list,
+					&expl, &expa)) {
  			avtab_destroy(&expa);
  			goto oom;
  		}
  		args->opt_cond_list = expl;
-		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
+		for (cur_av = expl; cur_av; cur_av = cur_av->next) {
+			avdat.data = cur_av->node->datum.data;
+			uncond = avtab_search(a->expa, &cur_av->node->key);
+			if (uncond)
+				avdat.data |= uncond->data;
  			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
-							    &cur_av->node->
-							    datum, args);
+							    &avdat, args);
  			if (rc)
-				a->numerr++;
+				args->numerr++;
  		}
  		cond_av_list_destroy(expl);
-		avtab_destroy(&expa);
+
+		/*
+		 * Check false condition
+		 */
  		if (avtab_init(&expa))
  			goto oom;
-		if (expand_cond_av_list
-		    (args->p, cur_node->false_list, &expl, &expa)) {
+		if (expand_cond_av_list(args->p, cur_node->false_list,
+					&expl, &expa)) {
  			avtab_destroy(&expa);
  			goto oom;
  		}
  		args->opt_cond_list = expl;
-		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
+		for (cur_av = expl; cur_av; cur_av = cur_av->next) {
+			avdat.data = cur_av->node->datum.data;
+			uncond = avtab_search(a->expa, &cur_av->node->key);
+			if (uncond)
+				avdat.data |= uncond->data;
+
  			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
-							    &cur_av->node->
-							    datum, args);
+							    &avdat, args);
  			if (rc)
  				a->numerr++;
  		}
@@ -317,40 +402,21 @@
  					 __attribute__ ((unused)),
  					 hashtab_datum_t d, void *args)
  {
-	char *parent;
  	hierarchy_args_t *a;
  	role_datum_t *r, *rp;

  	a = (hierarchy_args_t *) args;
  	r = (role_datum_t *) d;

-	if (find_parent(a->p->p_role_val_to_name[r->s.value - 1], &parent))
+	if (find_parent_role(a, r, &rp) < 0)
  		return -1;

-	if (!parent) {
-		/* This role has no parent */
-		return 0;
-	}
-
-	rp = hashtab_search(a->p->p_roles.table, parent);
-	if (!rp) {
-		/* Orphan role */
-		ERR(a->handle, "role %s doesn't exist, %s is an orphan",
-		    parent, a->p->p_role_val_to_name[r->s.value - 1]);
-		free(parent);
-		a->numerr++;
-		return 0;
-	}
-
-	if (!ebitmap_contains(&rp->types.types, &r->types.types)) {
-		/* This is a violation of the hiearchal constraint, return error condition */
+	if (rp && !ebitmap_contains(&rp->types.types, &r->types.types)) {
+		/* hierarchical constraint violation, return error */
  		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
-		    a->p->p_role_val_to_name[r->s.value - 1], parent);
+		    (char *) k, a->p->p_role_val_to_name[rp->s.value - 1]);
  		a->numerr++;
  	}
-
-	free(parent);
-
  	return 0;
  }

@@ -362,40 +428,21 @@
  					 __attribute__ ((unused)),
  					 hashtab_datum_t d, void *args)
  {
-	char *parent;
  	hierarchy_args_t *a;
  	user_datum_t *u, *up;

  	a = (hierarchy_args_t *) args;
  	u = (user_datum_t *) d;

-	if (find_parent(a->p->p_user_val_to_name[u->s.value - 1], &parent))
+	if (find_parent_user(a, u, &up) < 0)
  		return -1;

-	if (!parent) {
-		/* This user has no parent */
-		return 0;
-	}
-
-	up = hashtab_search(a->p->p_users.table, parent);
-	if (!up) {
-		/* Orphan user */
-		ERR(a->handle, "user %s doesn't exist, %s is an orphan",
-		    parent, a->p->p_user_val_to_name[u->s.value - 1]);
-		free(parent);
-		a->numerr++;
-		return 0;
-	}
-
-	if (!ebitmap_contains(&up->roles.roles, &u->roles.roles)) {
+	if (up && !ebitmap_contains(&up->roles.roles, &u->roles.roles)) {
  		/* hierarchical constraint violation, return error */
  		ERR(a->handle, "User hierarchy violation, %s exceeds %s",
-		    a->p->p_user_val_to_name[u->s.value - 1], parent);
+		    (char *) k, a->p->p_user_val_to_name[up->s.value - 1]);
  		a->numerr++;
  	}
-
-	free(parent);
-
  	return 0;
  }

@@ -420,6 +467,9 @@
  	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args))
  		goto bad;

+	if (pullup_unconditional_perms(p->cond_list, &args))
+		return -1;
+
  	if (avtab_map(&expa, check_avtab_hierarchy_callback, &args))
  		goto bad;

Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c	(revision 2950)
+++ libsepol/src/expand.c	(working copy)
@@ -466,6 +466,100 @@
  	return 0;
  }

+/*
+ * The boundaries have to be copied after the types/roles/users are copied,
+ * because it refers hashtab to lookup destinated objects.
+ */
+static int type_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	expand_state_t *state = (expand_state_t *) data;
+	type_datum_t *type = (type_datum_t *) datum;
+	type_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!type->bounds)
+		return 0;
+
+	if (!is_id_enabled((char *)key, state->base, SYM_TYPES))
+		return 0;
+
+	bounds_val = state->typemap[type->bounds - 1];
+
+	dest = hashtab_search(state->out->p_types.table, (char *)key);
+	if (!dest) {
+		ERR(state->handle, "Type lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle, "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
+static int role_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	expand_state_t *state = (expand_state_t *) data;
+	role_datum_t *role = (role_datum_t *) datum;
+	role_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!role->bounds)
+		return 0;
+
+	if (!is_id_enabled((char *)key, state->base, SYM_ROLES))
+		return 0;
+
+	bounds_val = state->rolemap[role->bounds - 1];
+
+	dest = hashtab_search(state->out->p_roles.table, (char *)key);
+	if (!dest) {
+		ERR(state->handle, "Role lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle, "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
+static int user_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	expand_state_t *state = (expand_state_t *) data;
+	user_datum_t *user = (user_datum_t *) datum;
+	user_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!user->bounds)
+		return 0;
+
+	if (!is_id_enabled((char *)key, state->base, SYM_USERS))
+		return 0;
+
+	bounds_val = state->usermap[user->bounds - 1];
+
+	dest = hashtab_search(state->out->p_users.table, (char *)key);
+	if (!dest) {
+		ERR(state->handle, "User lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle, "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
  /* The aliases have to be copied after the types and attributes to be certain that
   * the out symbol table will have the type that the alias refers. Otherwise, we
   * won't be able to find the type value for the alias. We can't depend on the
@@ -1865,31 +1959,6 @@
  	return 0;
  }

-static void type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
-			 __attribute__ ((unused)))
-{
-	free(key);
-	type_datum_destroy((type_datum_t *) datum);
-	free(datum);
-}
-
-static int type_attr_remove(hashtab_key_t key
-			    __attribute__ ((unused)), hashtab_datum_t datum,
-			    void *args)
-{
-	type_datum_t *typdatum;
-	policydb_t *p;
-
-	typdatum = (type_datum_t *) datum;
-	p = (policydb_t *) args;
-	if (typdatum->flavor == TYPE_ATTRIB) {
-		p->type_val_to_struct[typdatum->s.value - 1] = NULL;
-		p->p_type_val_to_name[typdatum->s.value - 1] = NULL;
-		return 1;
-	}
-	return 0;
-}
-
  /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
   * this should not be called until after all the blocks have been processed and the attributes in target policy
   * are complete. */
@@ -2393,6 +2462,11 @@
  		goto cleanup;
  	}

+	/* copy type bounds */
+	if (hashtab_map(state.base->p_types.table,
+			type_bounds_copy_callback, &state))
+		goto cleanup;
+
  	/* copy aliases */
  	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
  		goto cleanup;
@@ -2406,6 +2480,9 @@
  	/* copy roles */
  	if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
  		goto cleanup;
+	if (hashtab_map(state.base->p_roles.table,
+			role_bounds_copy_callback, &state))
+		goto cleanup;

  	/* copy MLS's sensitivity level and categories - this needs to be done
  	 * before expanding users (they need to be indexed too) */
@@ -2421,6 +2498,9 @@
  	/* copy users */
  	if (hashtab_map(state.base->p_users.table, user_copy_callback, &state))
  		goto cleanup;
+	if (hashtab_map(state.base->p_users.table,
+			user_bounds_copy_callback, &state))
+		goto cleanup;

  	/* copy bools */
  	if (hashtab_map(state.base->p_bools.table, bool_copy_callback, &state))
@@ -2510,8 +2590,6 @@
  	}
  	if (hashtab_map(state.out->p_types.table, type_attr_map, &state))
  		goto cleanup;
-	hashtab_map_remove_on_error(state.out->p_types.table,
-				    type_attr_remove, type_destroy, state.out);
  	if (check) {
  		if (hierarchy_check_constraints(handle, state.out))
  			goto cleanup;
Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2950)
+++ libsepol/src/write.c	(working copy)
@@ -920,6 +920,8 @@
  	items = 0;
  	buf[items++] = cpu_to_le32(len);
  	buf[items++] = cpu_to_le32(role->s.value);
+	if (policydb_has_boundary_feature(p))
+		buf[items++] = cpu_to_le32(role->bounds);
  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
  	if (items != items2)
  		return POLICYDB_ERROR;
@@ -952,19 +954,51 @@

  	typdatum = (type_datum_t *) datum;

+	/*
+	 * The kernel policy version less than 24 (= POLICYDB_VERSION_BOUNDARY)
+	 * does not support to load entries of attribute, so we skip to write it.
+	 */
+	if (p->policy_type == POLICY_KERN
+	    && p->policyvers < POLICYDB_VERSION_BOUNDARY
+	    && typdatum->flavor == TYPE_ATTRIB)
+		return POLICYDB_SUCCESS;
+
  	len = strlen(key);
  	items = 0;
  	buf[items++] = cpu_to_le32(len);
  	buf[items++] = cpu_to_le32(typdatum->s.value);
-	buf[items++] = cpu_to_le32(typdatum->primary);
-	if (p->policy_type != POLICY_KERN) {
-		buf[items++] = cpu_to_le32(typdatum->flavor);
-		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-			buf[items++] = cpu_to_le32(typdatum->flags);
-		else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
-			WARN(fp->handle, "Warning! Module policy version %d cannnot "
-			     "support permissive types, but one was defined",
-			     p->policyvers);
+	if (policydb_has_boundary_feature(p)) {
+		uint32_t properties = 0;
+
+		if (typdatum->primary)
+			properties |= TYPEDATUM_PROPERTY_PRIMARY;
+
+		if (typdatum->flavor == TYPE_ATTRIB) {
+			properties |= TYPEDATUM_PROPERTY_ATTRIBUTE;
+		} else if (typdatum->flavor == TYPE_ALIAS
+			   && p->policy_type != POLICY_KERN)
+			properties |= TYPEDATUM_PROPERTY_ALIAS;
+
+		if (typdatum->flags & TYPE_FLAGS_PERMISSIVE
+		    && p->policy_type != POLICY_KERN)
+			properties |= TYPEDATUM_PROPERTY_PERMISSIVE;
+
+		buf[items++] = cpu_to_le32(properties);
+		buf[items++] = cpu_to_le32(typdatum->bounds);
+	} else {
+		buf[items++] = cpu_to_le32(typdatum->primary);
+
+		if (p->policy_type != POLICY_KERN) {
+			buf[items++] = cpu_to_le32(typdatum->flavor);
+
+			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+				buf[items++] = cpu_to_le32(typdatum->flags);
+			else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
+				WARN(fp->handle, "Warning! Module policy "
+				     "version %d cannnot suport permissive "
+				     "types, but one was defined",
+				     p->policyvers);
+		}
  	}
  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
  	if (items != items2)
@@ -997,6 +1031,8 @@
  	items = 0;
  	buf[items++] = cpu_to_le32(len);
  	buf[items++] = cpu_to_le32(usrdatum->s.value);
+	if (policydb_has_boundary_feature(p))
+		buf[items++] = cpu_to_le32(usrdatum->bounds);
  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
  	if (items != items2)
  		return POLICYDB_ERROR;
Index: libsepol/src/link.c
===================================================================
--- libsepol/src/link.c	(revision 2950)
+++ libsepol/src/link.c	(working copy)
@@ -660,6 +660,97 @@
  	    user_copy_callback, bool_copy_callback, sens_copy_callback,
  	    cat_copy_callback};

+/*
+ * The boundaries have to be copied after the types/roles/users are copied,
+ * because it refers hashtab to lookup destinated objects.
+ */
+static int type_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	link_state_t *state = (link_state_t *) data;
+	type_datum_t *type = (type_datum_t *) datum;
+	type_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!type->bounds)
+		return 0;
+
+	bounds_val = state->cur->map[SYM_TYPES][type->bounds - 1];
+
+	dest = hashtab_search(state->base->p_types.table, key);
+	if (!dest) {
+		ERR(state->handle,
+		    "Type lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle,
+		    "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
+static int role_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	link_state_t *state = (link_state_t *) data;
+	role_datum_t *role = (role_datum_t *) datum;
+	role_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!role->bounds)
+		return 0;
+
+	bounds_val = state->cur->map[SYM_ROLES][role->bounds - 1];
+
+	dest = hashtab_search(state->base->p_roles.table, key);
+	if (!dest) {
+		ERR(state->handle,
+		    "Role lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle,
+		    "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
+static int user_bounds_copy_callback(hashtab_key_t key,
+				     hashtab_datum_t datum, void *data)
+{
+	link_state_t *state = (link_state_t *) data;
+	user_datum_t *user = (user_datum_t *) datum;
+	user_datum_t *dest;
+	uint32_t bounds_val;
+
+	if (!user->bounds)
+		return 0;
+
+	bounds_val = state->cur->map[SYM_USERS][user->bounds - 1];
+
+	dest = hashtab_search(state->base->p_users.table, key);
+	if (!dest) {
+		ERR(state->handle,
+		    "User lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (dest->bounds != 0 && dest->bounds != bounds_val) {
+		ERR(state->handle,
+		    "Inconsistent boundary for %s", (char *)key);
+		return -1;
+	}
+	dest->bounds = bounds_val;
+
+	return 0;
+}
+
  /* The aliases have to be copied after the types and attributes to be
   * certain that the base symbol table will have the type that the
   * alias refers. Otherwise, we won't be able to find the type value
@@ -1362,11 +1453,22 @@
  		}
  	}

-	if (hashtab_map
-	    (src_symtab[SYM_TYPES].table, alias_copy_callback, state)) {
+	if (hashtab_map(src_symtab[SYM_TYPES].table,
+			type_bounds_copy_callback, state))
  		return -1;
-	}

+	if (hashtab_map(src_symtab[SYM_TYPES].table,
+			alias_copy_callback, state))
+		return -1;
+
+	if (hashtab_map(src_symtab[SYM_ROLES].table,
+			role_bounds_copy_callback, state))
+		return -1;
+
+	if (hashtab_map(src_symtab[SYM_USERS].table,
+			user_bounds_copy_callback, state))
+		return -1;
+
  	/* then fix bitmaps associated with those newly copied identifiers */
  	for (i = 0; i < SYM_NUM; i++) {
  		if (fix_callback_f[i] != NULL &&

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
