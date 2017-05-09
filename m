Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49GrQoe016350
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 12:53:26 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Expand attributes with TYPE_FLAGS_EXPAND_ATTR_TRUE
 set
Date: Tue,  9 May 2017 12:54:11 -0400
Message-Id: <20170509165411.18720-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 1089665e31a647a5f0ba2eabe8ac6232b384bed9 (Add attribute
expansion options) adds an expandattribute rule to the policy.conf
language which sets a type_datum flag. Currently the flag is used
only when writing out CIL policy from a policy.conf.

Make use of the flag when expanding policy to expand policy rules
and remove all type associations for an attribute that has
TYPE_FLAGS_EXPAND_ATTR_TRUE set. (The attribute will remain in the
policy, but have no types associated with it.)

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/expand.c | 72 ++++++++++++++++++++++++++++++---------------------
 libsepol/src/link.c   |  8 +++---
 2 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 54bf781..74a650f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2360,6 +2360,20 @@ oom:
 	return -1;
 }
 
+static int remove_types_from_expanded(hashtab_key_t key
+				      __attribute__ ((unused)), hashtab_datum_t datum,
+				      void *ptr)
+{
+	type_datum_t *type = (type_datum_t *) datum;
+
+	if (type->flavor == TYPE_ATTRIB && (type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE)) {
+		ebitmap_destroy(&type->types);
+		ebitmap_init(&type->types);
+	}
+
+	return 0;
+}
+
 /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
  * this should not be called until after all the blocks have been processed and the attributes in target policy
  * are complete. */
@@ -2513,46 +2527,41 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 	unsigned int i;
 	ebitmap_t types, neg_types;
 	ebitmap_node_t *tnode;
+	unsigned char expand = alwaysexpand || ebitmap_length(&set->negset) || set->flags;
+	type_datum_t *type;
 	int rc =-1;
 
 	ebitmap_init(&types);
 	ebitmap_init(t);
 
-	if (alwaysexpand || ebitmap_length(&set->negset) || set->flags) {
-		/* First go through the types and OR all the attributes to types */
-		ebitmap_for_each_bit(&set->types, tnode, i) {
-			if (ebitmap_node_get_bit(tnode, i)) {
+	/* First go through the types and OR all the attributes to types */
+	ebitmap_for_each_bit(&set->types, tnode, i) {
+		if (!ebitmap_node_get_bit(tnode, i))
+			continue;
+
+		/*
+		 * invalid policies might have more types set in the ebitmap than
+		 * what's available in the type_val_to_struct mapping
+		 */
+		if (i >= p->p_types.nprim)
+			goto err_types;
 
-				/*
-				 * invalid policies might have more types set in the ebitmap than
-				 * what's available in the type_val_to_struct mapping
-				 */
-				if (i >= p->p_types.nprim)
-					goto err_types;
+		type = p->type_val_to_struct[i];
 
-				if (!p->type_val_to_struct[i]) {
-					goto err_types;
-				}
+		if (!type) {
+			goto err_types;
+		}
 
-				if (p->type_val_to_struct[i]->flavor ==
-				    TYPE_ATTRIB) {
-					if (ebitmap_union
-					    (&types,
-					     &p->type_val_to_struct[i]->
-					     types)) {
-						goto err_types;
-					}
-				} else {
-					if (ebitmap_set_bit(&types, i, 1)) {
-						goto err_types;
-					}
-				}
+		if (type->flavor == TYPE_ATTRIB && 
+		    (expand || (type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE))) {
+			if (ebitmap_union(&types, &type->types)) {
+				goto err_types;
+			}
+		} else {
+			if (ebitmap_set_bit(&types, i, 1)) {
+				goto err_types;
 			}
 		}
-	} else {
-		/* No expansion of attributes, just copy the set as is. */
-		if (ebitmap_cpy(&types, &set->types))
-			goto err_types;
 	}
 
 	/* Now do the same thing for negset */
@@ -3160,6 +3169,9 @@ int expand_module(sepol_handle_t * handle,
 	if (genfs_copy(&state))
 		goto cleanup;
 
+	if (hashtab_map(state.out->p_types.table, remove_types_from_expanded, &state))
+		goto cleanup;
+
 	/* Build the type<->attribute maps and remove attributes. */
 	state.out->attr_type_map = malloc(state.out->p_types.nprim *
 					  sizeof(ebitmap_t));
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index f211164..52770f4 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -467,8 +467,8 @@ static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			    state->cur_mod_name, id);
 			return -1;
 		}
-		/* permissive should pass to the base type */
-		base_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
+
+		base_type->flags |= type->flags;
 	} else {
 		if (state->verbose)
 			INFO(state->handle, "copying type %s", id);
@@ -890,7 +890,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return -1;
 	}
 
-	target_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
+	target_type->flags |= type->flags;
 
 	base_type = hashtab_search(state->base->p_types.table, id);
 	if (base_type == NULL) {
@@ -938,7 +938,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 
 		base_type->flavor = TYPE_ALIAS;
 		base_type->primary = target_type->s.value;
-		base_type->flags |= (target_type->flags & TYPE_FLAGS_PERMISSIVE);
+		base_type->flags |= target_type->flags;
 
 	}
 	/* the aliases map points from its value to its primary so when this module 
-- 
2.9.3
