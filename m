Message-ID: <48B2A66D.7030608@ak.jp.nec.com>
Date: Mon, 25 Aug 2008 21:32:45 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 3/3] Thread/Child-Domain Assignment (rev.4)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com>
In-Reply-To: <4897EB6F.6080709@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch is revised one for libsepol.

Updates:
 - The properties of type_datum are packed within the third word of
   type entries in the kernel policy.
   The first bit (TYPEDATUM_PROPERTY_PRIMARY) means the entry is a
   primary type, and the second bit (TYPEDATUM_PROPERTY_ATTRIBUTE)
   means the entry is an attribute.

Thanks,

Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
--
 include/sepol/policydb/policydb.h |   26 ++++++-
 src/expand.c                      |  132 ++++++++++++++++++++++++++++++--------
 src/link.c                        |  108 ++++++++++++++++++++++++++++++-
 src/policydb.c                    |   89 +++++++++++++++++++------
 src/write.c                       |   28 +++++++-
 5 files changed, 329 insertions(+), 54 deletions(-)

Index: libsepol/include/sepol/policydb/policydb.h
===================================================================
--- libsepol/include/sepol/policydb/policydb.h	(revision 2938)
+++ libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -119,6 +119,7 @@
 	ebitmap_t dominates;	/* set of roles dominated by this role */
 	type_set_t types;	/* set of authorized types for role */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
+	uint32_t bounds;	/* bounds role, if exist */
 } role_datum_t;

 typedef struct role_trans {
@@ -145,8 +146,16 @@
 	ebitmap_t types;	/* types with this attribute */
 #define TYPE_FLAGS_PERMISSIVE	0x01
 	uint32_t flags;
+	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;

+/*
+ * type_datum properties
+ * available at the kernel policy version >= POLICYDB_VERSION_BOUNDARY
+ */
+#define TYPEDATUM_PROPERTY_PRIMARY      0x0001
+#define TYPEDATUM_PROPERTY_ATTRIBUTE    0x0002
+
 /* User attributes */
 typedef struct user_datum {
 	symtab_datum_t s;
@@ -156,6 +165,7 @@
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
 	mls_range_t exp_range;     /* expanded range used for validation */
 	mls_level_t exp_dfltlevel; /* expanded range used for validation */
+	uint32_t bounds;	/* bounds user, if exist */
 } user_datum_t;

 /* Sensitivity attributes */
@@ -595,10 +605,11 @@
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
@@ -608,12 +619,23 @@
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
--- libsepol/src/policydb.c	(revision 2938)
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
@@ -1916,32 +1939,53 @@
 {
 	char *key = 0;
 	type_datum_t *typdatum;
-	uint32_t buf[5];
+	uint32_t buf[6];
 	size_t len;
-	int rc, to_read;
+	int rc, to_read, items = 0;

 	typdatum = calloc(1, sizeof(type_datum_t));
 	if (!typdatum)
 		return -1;

-	if (p->policy_type == POLICY_KERN)
-		to_read = 3;
-	else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-		to_read = 5;
-	else
-		to_read = 4;
+	if (p->policy_type == POLICY_KERN) {
+		if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
+			to_read = 4;
+		else
+			to_read = 3;
+	} else {
+		if (p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY)
+			to_read = 6;
+		else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			to_read = 5;
+		else
+			to_read = 4;
+	}

 	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
 	if (rc < 0)
 		goto bad;
+	len = le32_to_cpu(buf[items++]);
+	typdatum->s.value = le32_to_cpu(buf[items++]);
+	if (p->policy_type == POLICY_KERN) {
+		if (p->policyvers >= POLICYDB_VERSION_BOUNDARY) {
+			uint32_t prop = le32_to_cpu(buf[items++]);

-	len = le32_to_cpu(buf[0]);
-	typdatum->s.value = le32_to_cpu(buf[1]);
-	typdatum->primary = le32_to_cpu(buf[2]);
-	if (p->policy_type != POLICY_KERN) {
-		typdatum->flavor = le32_to_cpu(buf[3]);
+			if (prop & TYPEDATUM_PROPERTY_PRIMARY)
+				typdatum->primary = 1;
+			if (prop & TYPEDATUM_PROPERTY_ATTRIBUTE)
+				typdatum->flavor = TYPE_ATTRIB;
+
+			typdatum->bounds = le32_to_cpu(buf[items++]);
+		} else {
+			typdatum->primary = le32_to_cpu(buf[items++]);
+		}
+	} else {
+		typdatum->primary = le32_to_cpu(buf[items++]);
+		if (p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY)
+			typdatum->bounds = le32_to_cpu(buf[items++]);
+		typdatum->flavor = le32_to_cpu(buf[items++]);
 		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-			typdatum->flags = le32_to_cpu(buf[4]);
+			typdatum->flags = le32_to_cpu(buf[items++]);
 		if (ebitmap_read(&typdatum->types, fp))
 			goto bad;
 	}
@@ -2293,20 +2337,25 @@
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
Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c	(revision 2938)
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
--- libsepol/src/write.c	(revision 2938)
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
@@ -952,12 +954,32 @@

 	typdatum = (type_datum_t *) datum;

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
+	if (p->policy_type == POLICY_KERN) {
+		if (p->policyvers >= POLICYDB_VERSION_BOUNDARY) {
+			uint32_t prop = 0;
+
+			if (typdatum->primary)
+				prop |= TYPEDATUM_PROPERTY_PRIMARY;
+			if (typdatum->flavor == TYPE_ATTRIB)
+				prop |= TYPEDATUM_PROPERTY_ATTRIBUTE;
+			buf[items++] = cpu_to_le32(prop);
+			buf[items++] = cpu_to_le32(typdatum->bounds);
+		} else {
+			buf[items++] = cpu_to_le32(typdatum->primary);
+		}
+	} else {
+		buf[items++] = cpu_to_le32(typdatum->primary);
+		if (p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY)
+			buf[items++] = cpu_to_le32(typdatum->bounds);
 		buf[items++] = cpu_to_le32(typdatum->flavor);
 		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
 			buf[items++] = cpu_to_le32(typdatum->flags);
@@ -997,6 +1019,8 @@
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
--- libsepol/src/link.c	(revision 2938)
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
