Message-ID: <4889CF43.2070407@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 22:04:03 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 3/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>
In-Reply-To: <4889CC5F.3030500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[3/3] thread-context-libsepol.1.patch
  This patch add support of new policy version of POLICYDB_VERSION_HIERARCHY.
  It keeps child-parent relationship between two types, and used to make
  a decision whether required dynamic type transition within multithreaded
  process can be allowed, or not, in the kernel space.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
----
 include/sepol/policydb/policydb.h |    7 +++-
 src/expand.c                      |   33 +++++++++++++++++++++
 src/hierarchy.c                   |   50 ++++++++++++++++++++++++++------
 src/link.c                        |   33 +++++++++++++++++++++
 src/policydb.c                    |   59 +++++++++++++++++++++++++++++---------
 src/write.c                       |    9 +++++
 6 files changed, 166 insertions(+), 25 deletions(-)

Index: libsepol/include/sepol/policydb/policydb.h
===================================================================
--- libsepol/include/sepol/policydb/policydb.h	(revision 2928)
+++ libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -145,6 +145,7 @@
 	ebitmap_t types;	/* types with this attribute */
 #define TYPE_FLAGS_PERMISSIVE	0x01
 	uint32_t flags;
+	uint32_t parent;	/* parent type in hierarchical representation */
 } type_datum_t;

 /* User attributes */
@@ -595,10 +596,11 @@
 #define POLICYDB_VERSION_RANGETRANS	21
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
+#define POLICYDB_VERSION_HIERARCHY	24

 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_HIERARCHY

 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	   4
@@ -608,9 +610,10 @@
 #define MOD_POLICYDB_VERSION_MLS_USERS	   6
 #define MOD_POLICYDB_VERSION_POLCAP	   7
 #define MOD_POLICYDB_VERSION_PERMISSIVE	   8
+#define MOD_POLICYDB_VERSION_HIERARCHY	   9

 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PERMISSIVE
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_HIERARCHY

 #define POLICYDB_CONFIG_MLS    1

Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 2928)
+++ libsepol/src/policydb.c	(working copy)
@@ -111,6 +111,12 @@
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_HIERARCHY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -141,6 +147,12 @@
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_HIERARCHY,
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
+	 .version = MOD_POLICYDB_VERSION_HIERARCHY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	},
 };

 #if 0
@@ -1918,30 +1936,45 @@
 	type_datum_t *typdatum;
 	uint32_t buf[5];
 	size_t len;
-	int rc, to_read;
+	int rc, items, to_read;

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
+		if (p->policyvers >= POLICYDB_VERSION_HIERARCHY)
+			to_read = 4;
+		else
+			to_read = 3;
+	} else {
+		if (p->policyvers >= MOD_POLICYDB_VERSION_HIERARCHY)
+			to_read = 6;
+		else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			to_read = 5;
+		else
+			to_read = 4;
+	}

 	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
 	if (rc < 0)
 		goto bad;

-	len = le32_to_cpu(buf[0]);
-	typdatum->s.value = le32_to_cpu(buf[1]);
-	typdatum->primary = le32_to_cpu(buf[2]);
-	if (p->policy_type != POLICY_KERN) {
-		typdatum->flavor = le32_to_cpu(buf[3]);
+	items = 0;
+	len = le32_to_cpu(buf[items++]);
+	typdatum->s.value = le32_to_cpu(buf[items++]);
+	typdatum->primary = le32_to_cpu(buf[items++]);
+
+	if (p->policy_type == POLICY_KERN) {
+		if (p->policyvers >= POLICYDB_VERSION_HIERARCHY)
+			typdatum->parent = le32_to_cpu(buf[items++]);
+	} else {
+		if (p->policyvers >= MOD_POLICYDB_VERSION_HIERARCHY)
+			typdatum->parent = le32_to_cpu(buf[items++]);
+
+		typdatum->flavor = le32_to_cpu(buf[items++]);
 		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-			typdatum->flags = le32_to_cpu(buf[4]);
+			typdatum->flags = le32_to_cpu(buf[items++]);
 		if (ebitmap_read(&typdatum->types, fp))
 			goto bad;
 	}
Index: libsepol/src/hierarchy.c
===================================================================
--- libsepol/src/hierarchy.c	(revision 2928)
+++ libsepol/src/hierarchy.c	(working copy)
@@ -47,7 +47,7 @@
  *
  * Caller must free parent after use.
  */
-static int find_parent(char *type, char **parent)
+static int find_parent_namebased(char *type, char **parent)
 {
 	char *tmp;
 	int len;
@@ -73,6 +73,34 @@
 	return 0;
 }

+static int find_parent(policydb_t *p, char *child, char **parent)
+{
+	type_datum_t *child_type;
+
+	/* legacy name based hierarchy relationship */
+	if ((p->policy_type == POLICY_KERN
+	     && p->policyvers < POLICYDB_VERSION_HIERARCHY) ||
+	    (p->policy_type != POLICY_KERN
+	     && p->policyvers < MOD_POLICYDB_VERSION_HIERARCHY))
+		return find_parent_namebased(child, parent);
+
+	child_type = hashtab_search(p->p_types.table, child);
+	if (!child_type)
+		return -1;
+
+	/* no hierarchy relationship */
+	if (!child_type->parent) {
+		*parent = NULL;
+		return 0;
+	}
+
+	*parent = strdup(p->p_type_val_to_name[child_type->parent - 1]);
+	if (!(*parent))
+		return -1;
+
+	return 0;
+}
+
 /* This function verifies that the type passed in either has a parent or is in the
  * root of the namespace, 0 on success, 1 on orphan and -1 on error
  */
@@ -93,7 +121,7 @@
 		return 0;
 	}

-	if (find_parent(key, &parent))
+	if (find_parent(a->p, key, &parent))
 		return -1;

 	if (!parent) {
@@ -126,7 +154,7 @@
 static int check_avtab_hierarchy_callback(avtab_key_t * k, avtab_datum_t * d,
 					  void *args)
 {
-	char *parent;
+	char *type_name, *parent;
 	avtab_key_t key;
 	avtab_datum_t *avdatump;
 	hierarchy_args_t *a;
@@ -139,7 +167,8 @@
 	}

 	a = (hierarchy_args_t *) args;
-	if (find_parent(a->p->p_type_val_to_name[k->source_type - 1], &parent))
+	type_name = a->p->p_type_val_to_name[k->source_type - 1];
+	if (find_parent(a->p, type_name, &parent))
 		return -1;

 	/* search for parent first */
@@ -178,7 +207,8 @@
 	}

 	/* next we try type 1 and type 2's parent */
-	if (find_parent(a->p->p_type_val_to_name[k->target_type - 1], &parent))
+	type_name = a->p->p_type_val_to_name[k->target_type - 1];
+	if (find_parent(a->p, type_name, &parent))
 		return -1;

 	if (parent) {
@@ -317,14 +347,15 @@
 					 __attribute__ ((unused)),
 					 hashtab_datum_t d, void *args)
 {
-	char *parent;
+	char *role_name, *parent;
 	hierarchy_args_t *a;
 	role_datum_t *r, *rp;

 	a = (hierarchy_args_t *) args;
 	r = (role_datum_t *) d;

-	if (find_parent(a->p->p_role_val_to_name[r->s.value - 1], &parent))
+	role_name = a->p->p_role_val_to_name[r->s.value - 1];
+	if (find_parent_namebased(role_name, &parent))
 		return -1;

 	if (!parent) {
@@ -362,14 +393,15 @@
 					 __attribute__ ((unused)),
 					 hashtab_datum_t d, void *args)
 {
-	char *parent;
+	char *user_name, *parent;
 	hierarchy_args_t *a;
 	user_datum_t *u, *up;

 	a = (hierarchy_args_t *) args;
 	u = (user_datum_t *) d;

-	if (find_parent(a->p->p_user_val_to_name[u->s.value - 1], &parent))
+	user_name = a->p->p_user_val_to_name[u->s.value - 1];
+	if (find_parent_namebased(user_name, &parent))
 		return -1;

 	if (!parent) {
Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c	(revision 2928)
+++ libsepol/src/expand.c	(working copy)
@@ -538,6 +538,35 @@
 	return 0;
 }

+static int hierarchy_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	expand_state_t *state = (expand_state_t *) data;
+	type_datum_t *type = (type_datum_t *) datum;
+	type_datum_t *target;
+	uint32_t parent_val;
+
+	if (!type->parent)
+		return 0;
+
+	if (!is_id_enabled((char *)key, state->base, SYM_TYPES))
+		return 0;
+
+	parent_val = state->typemap[type->parent - 1];
+
+	target = hashtab_search(state->out->p_types.table, (char *)key);
+	if (!target) {
+		ERR(state->handle, "Type lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (target->parent > 0 && target->parent != parent_val) {
+		ERR(state->handle, "Inconsistent hierarchy for %s", (char *)key);
+		return -1;
+	}
+	target->parent = parent_val;
+
+	return 0;
+}
+
 static int role_remap_dominates(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *data)
 {
 	ebitmap_t mapped_roles;
@@ -2393,6 +2422,10 @@
 		goto cleanup;
 	}

+	/* copy hierarchy */
+	if (hashtab_map(state.base->p_types.table, hierarchy_type_callback, &state))
+		goto cleanup;
+
 	/* copy aliases */
 	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
 		goto cleanup;
Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2928)
+++ libsepol/src/write.c	(working copy)
@@ -957,7 +957,14 @@
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(typdatum->s.value);
 	buf[items++] = cpu_to_le32(typdatum->primary);
-	if (p->policy_type != POLICY_KERN) {
+
+	if (p->policy_type == POLICY_KERN) {
+		if (p->policyvers >= POLICYDB_VERSION_HIERARCHY)
+			buf[items++] = cpu_to_le32(typdatum->parent);
+	} else {
+		if (p->policyvers >= MOD_POLICYDB_VERSION_HIERARCHY)
+			buf[items++] = cpu_to_le32(typdatum->parent);
+
 		buf[items++] = cpu_to_le32(typdatum->flavor);
 		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
 			buf[items++] = cpu_to_le32(typdatum->flags);
Index: libsepol/src/link.c
===================================================================
--- libsepol/src/link.c	(revision 2928)
+++ libsepol/src/link.c	(working copy)
@@ -770,6 +770,35 @@
 	return -1;
 }

+static int hierarchy_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	link_state_t *state = (link_state_t *) data;
+	type_datum_t *type = (type_datum_t *) datum;
+	type_datum_t *target;
+	uint32_t parent_val;
+
+	if (!type->parent)
+		return 0;
+
+	parent_val = state->cur->map[SYM_TYPES][type->parent - 1];
+
+	target = hashtab_search(state->base->p_types.table, key);
+	if (!target) {
+		ERR(state->handle,
+		    "Type lookup failed for %s", (char *)key);
+		return -1;
+	}
+	if (target->parent > 0 && target->parent != parent_val) {
+		ERR(state->handle,
+		    "Inconsistent domain hierarchy for %s", (char *)key);
+		return -1;
+	}
+	target->parent = parent_val;
+
+	return 0;
+}
+
+
 /*********** callbacks that fix bitmaps ***********/

 static int type_set_convert(type_set_t * types, type_set_t * dst,
@@ -1362,6 +1391,10 @@
 		}
 	}

+	if (hashtab_map(src_symtab[SYM_TYPES].table,
+			hierarchy_type_callback, state))
+		return -1;
+
 	if (hashtab_map
 	    (src_symtab[SYM_TYPES].table, alias_copy_callback, state)) {
 		return -1;

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
