Subject: [PATCH] libsepol: add permissive domain support
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Content-Type: text/plain
Date: Mon, 24 Mar 2008 09:51:37 -0400
Message-Id: <1206366697.3192.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for permissive types.

In the kernel policy format the permissive types are in a bitmap
referenced by the type value.

In the module policy format a new field in the type_datum_t called
'flags' was added.  The only currently defined flag is
TYPE_FLAGS_PERMISSIVE.

Checkpolicy can set the permissive flag on the type_datum_t in question
and that flag will persist on disk.  It will be OR'd at link time
against the type in the base policy.  At expand time we build the bit
array the kernel uses.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 include/sepol/policydb/policydb.h |   12 +++++++--
 src/expand.c                      |   16 ++++++++++++
 src/link.c                        |    8 ++++++
 src/policydb.c                    |   50 +++++++++++++++++++++++++++++++-------
 src/write.c                       |   27 ++++++++++++++++++++
 5 files changed, 103 insertions(+), 10 deletions(-)

diff -up libsepol-2.0.25/src/expand.c.pre.permissive libsepol-2.0.25/src/expand.c
--- libsepol-2.0.25/src/expand.c.pre.permissive
+++ libsepol-2.0.25/src/expand.c
@@ -92,6 +92,7 @@ static int type_copy_callback(hashtab_ke
 	memset(new_type, 0, sizeof(type_datum_t));
 
 	new_type->flavor = type->flavor;
+	new_type->flags = type->flags;
 	new_type->s.value = ++state->out->p_types.nprim;
 	if (new_type->s.value > UINT16_MAX) {
 		free(new_id);
@@ -112,6 +113,12 @@ static int type_copy_callback(hashtab_ke
 		return -1;
 	}
 
+	if (new_type->flags & TYPE_FLAGS_PERMISSIVE)
+		if (ebitmap_set_bit(&state->out->permissive_map, new_type->s.value, 1)) {
+			ERR(state->handle, "Out of memory!\n");
+			return -1;
+		}
+
 	return 0;
 }
 
@@ -480,6 +487,8 @@ static int alias_copy_callback(hashtab_k
 	else
 		assert(0);	/* unreachable */
 
+	new_alias->flags = alias->flags;
+
 	ret = hashtab_insert(state->out->p_types.table,
 			     (hashtab_key_t) new_id,
 			     (hashtab_datum_t) new_alias);
@@ -492,6 +501,13 @@ static int alias_copy_callback(hashtab_k
 	}
 
 	state->typemap[alias->s.value - 1] = new_alias->s.value;
+
+	if (new_alias->flags & TYPE_FLAGS_PERMISSIVE)
+		if (ebitmap_set_bit(&state->out->permissive_map, new_alias->s.value, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
 	return 0;
 }
 
diff -up libsepol-2.0.25/src/policydb.c.pre.permissive libsepol-2.0.25/src/policydb.c
--- libsepol-2.0.25/src/policydb.c.pre.permissive
+++ libsepol-2.0.25/src/policydb.c
@@ -105,6 +105,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_PERMISSIVE,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -129,6 +135,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_PERMISSIVE,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -150,7 +162,14 @@ static struct policydb_compat_info polic
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_POLCAP,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0},
+	 .ocon_num = 0
+	 },
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_PERMISSIVE,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	 },
 };
 
 #if 0
@@ -467,6 +486,8 @@ int policydb_init(policydb_t * p)
 
 	ebitmap_init(&p->policycaps);
 
+	ebitmap_init(&p->permissive_map);
+
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = NULL;
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
@@ -992,6 +1013,8 @@ void policydb_destroy(policydb_t * p)
 
 	ebitmap_destroy(&p->policycaps);
 
+	ebitmap_destroy(&p->permissive_map);
+
 	symtabs_destroy(p->symtab);
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -1907,19 +1930,22 @@ static int type_read(policydb_t * p
 {
 	char *key = 0;
 	type_datum_t *typdatum;
-	uint32_t buf[4];
+	uint32_t buf[5];
 	size_t len;
-	int rc;
+	int rc, to_read;
 
 	typdatum = calloc(1, sizeof(type_datum_t));
 	if (!typdatum)
 		return -1;
 
-	if (p->policy_type == POLICY_KERN) {
-		rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
-	} else {
-		rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
-	}
+	if (p->policy_type == POLICY_KERN)
+		to_read = 3;
+	else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+		to_read = 5;
+	else
+		to_read = 4;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
 	if (rc < 0)
 		goto bad;
 
@@ -1928,6 +1954,8 @@ static int type_read(policydb_t * p
 	typdatum->primary = le32_to_cpu(buf[2]);
 	if (p->policy_type != POLICY_KERN) {
 		typdatum->flavor = le32_to_cpu(buf[3]);
+		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			typdatum->flags = le32_to_cpu(buf[4]);
 		if (ebitmap_read(&typdatum->types, fp))
 			goto bad;
 	}
@@ -3157,6 +3185,12 @@ int policydb_read(policydb_t * p, struct
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_read(&p->permissive_map, fp))
+			goto bad;
+	}
+
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
diff -up libsepol-2.0.25/src/write.c.pre.permissive libsepol-2.0.25/src/write.c
--- libsepol-2.0.25/src/write.c.pre.permissive
+++ libsepol-2.0.25/src/write.c
@@ -959,6 +959,12 @@ static int type_write(hashtab_key_t key,
 	buf[items++] = cpu_to_le32(typdatum->primary);
 	if (p->policy_type != POLICY_KERN) {
 		buf[items++] = cpu_to_le32(typdatum->flavor);
+		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			buf[items++] = cpu_to_le32(typdatum->flags);
+		else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
+			WARN(fp->handle, "Warning! Module policy version %d cannnot "
+			     "support permissive types, but one was defined",
+			     p->policyvers);
 	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
@@ -1618,6 +1624,27 @@ int policydb_write(policydb_t * p, struc
 			return POLICYDB_ERROR;
 	}
 
+	if (p->policyvers < POLICYDB_VERSION_PERMISSIVE &&
+	    p->policy_type == POLICY_KERN) {
+		ebitmap_node_t *tnode;
+		unsigned int i;
+
+		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
+			if (ebitmap_node_get_bit(tnode, i)) {
+				WARN(fp->handle, "Warning! Policy version %d cannot "
+				     "support permissive types, but some were defined",
+				     p->policyvers);
+				break;
+			}
+		}
+	}
+
+	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_write(&p->permissive_map, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
diff -up libsepol-2.0.25/src/link.c.pre.permissive libsepol-2.0.25/src/link.c
--- libsepol-2.0.25/src/link.c.pre.permissive
+++ libsepol-2.0.25/src/link.c
@@ -405,6 +405,8 @@ static int type_copy_callback(hashtab_ke
 			    state->cur_mod_name, id);
 			return -1;
 		}
+		/* permissive should pass to the base type */
+		base_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
 	} else {
 		if (state->verbose)
 			INFO(state->handle, "copying type %s", id);
@@ -418,6 +420,7 @@ static int type_copy_callback(hashtab_ke
 			goto cleanup;
 		}
 		new_type->primary = type->primary;
+		new_type->flags = type->flags;
 		new_type->flavor = type->flavor;
 		/* for attributes, the writing of new_type->types is
 		   done in type_fix_callback() */
@@ -441,6 +444,7 @@ static int type_copy_callback(hashtab_ke
 		}
 		new_type->primary = type->primary;
 		new_type->flavor = type->flavor;
+		new_type->flags = type->flags;
 		new_type->s.value = base_type->s.value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
@@ -702,6 +706,8 @@ static int alias_copy_callback(hashtab_k
 		return -1;
 	}
 
+	target_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
+
 	base_type = hashtab_search(state->base->p_types.table, id);
 	if (base_type == NULL) {
 		if (state->verbose)
@@ -713,6 +719,7 @@ static int alias_copy_callback(hashtab_k
 		}
 		/* the linked copy always has TYPE_ALIAS style aliases */
 		new_type->primary = target_type->s.value;
+		new_type->flags = target_type->flags;
 		new_type->flavor = TYPE_ALIAS;
 		new_type->s.value = state->base->p_types.nprim + 1;
 		if ((new_id = strdup(id)) == NULL) {
@@ -747,6 +754,7 @@ static int alias_copy_callback(hashtab_k
 
 		base_type->flavor = TYPE_ALIAS;
 		base_type->primary = target_type->s.value;
+		base_type->flags |= (target_type->flags & TYPE_FLAGS_PERMISSIVE);
 
 	}
 	/* the aliases map points from its value to its primary so when this module 
diff -up libsepol-2.0.25/include/sepol/policydb/policydb.h.pre.permissive libsepol-2.0.25/include/sepol/policydb/policydb.h
--- libsepol-2.0.25/include/sepol/policydb/policydb.h.pre.permissive
+++ libsepol-2.0.25/include/sepol/policydb/policydb.h
@@ -143,6 +143,8 @@ typedef struct type_datum {
 #define TYPE_ALIAS 2		/* alias in modular policy */
 	uint32_t flavor;
 	ebitmap_t types;	/* types with this attribute */
+#define TYPE_FLAGS_PERMISSIVE	0x01
+	uint32_t flags;
 } type_datum_t;
 
 /* User attributes */
@@ -470,6 +472,10 @@ typedef struct policydb {
 
 	ebitmap_t policycaps;
 
+	/* this bitmap is referenced by type NOT the typical type-1 used in other
+	   bitmaps.  Someday the 0 bit may be used for global permissive */
+	ebitmap_t permissive_map;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -588,10 +594,11 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_AVTAB		20
 #define POLICYDB_VERSION_RANGETRANS	21
 #define POLICYDB_VERSION_POLCAP		22
+#define POLICYDB_VERSION_PERMISSIVE	23
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	   4
@@ -600,9 +607,10 @@ extern int policydb_write(struct policyd
 #define MOD_POLICYDB_VERSION_RANGETRANS	   6
 #define MOD_POLICYDB_VERSION_MLS_USERS	   6
 #define MOD_POLICYDB_VERSION_POLCAP	   7
+#define MOD_POLICYDB_VERSION_PERMISSIVE	   8
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_POLCAP
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PERMISSIVE
 
 #define POLICYDB_CONFIG_MLS    1
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
