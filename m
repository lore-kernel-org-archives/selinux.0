Subject: [PATCH 3/10] expand type set fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:11 -0400
Message-Id: <1151074332.4011.72.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Expand type set was previously expanding a typeset to an ebitmap, and
then converting the resulting ebitmap to the out policy. This doesn't
work anymore since the linked copy doesn't have the aggregated attribute
sets so the typeset needs to be converted and then expanded to an
ebitmap with the expanded policy.

diff -pruN -x .svn selinux.old/libsepol/include/sepol/policydb/expand.h optionals-in-base-take2/libsepol/include/sepol/policydb/expand.h
--- selinux.old/libsepol/include/sepol/policydb/expand.h	2006-06-22 11:15:44.000000000 -0400
+++ optionals-in-base-take2/libsepol/include/sepol/policydb/expand.h	2006-06-22 10:02:06.000000000 -0400
@@ -32,6 +32,7 @@
 extern int expand_module(sepol_handle_t *handle,
 			 policydb_t *base, policydb_t *out,
 			 int verbose, int check);
+extern int convert_type_ebitmap(ebitmap_t *src, ebitmap_t *dst, uint32_t *typemap);
 extern int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types, unsigned char alwaysexpand);
 extern int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p, unsigned char alwaysexpand);
 extern int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p);
diff -pruN -x .svn selinux.old/libsepol/src/expand.c optionals-in-base-take2/libsepol/src/expand.c
--- selinux.old/libsepol/src/expand.c	2006-06-22 11:15:44.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/expand.c	2006-06-22 11:17:59.000000000 -0400
@@ -107,11 +107,10 @@ static int type_copy_callback(hashtab_ke
 
 static int attr_convert_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-	unsigned int i;
         char *id;
         type_datum_t *type, *new_type;
        	expand_state_t *state;
-	ebitmap_node_t *node;
+	ebitmap_t tmp_union;
 
         id = (char *)key;
         type = (type_datum_t *)datum;
@@ -133,20 +132,17 @@ static int attr_convert_callback(hashtab
 		ERR (state->handle, "attribute %s vanished!", id);
                 return -1;
 	}
-	ebitmap_init(&new_type->types);
-
-	ebitmap_for_each_bit(&type->types, node, i) {
-		if (!ebitmap_node_get_bit(node, i))
-			continue; 
-		if (!state->typemap[i])
-			continue;
-		if (ebitmap_set_bit(&new_type->types,
-				    state->typemap[i]-1, 1)) {
-			ERR (state->handle, "out of memory");
-			return -1;
-		}
+	if (convert_type_ebitmap(&type->types, &tmp_union, state->typemap)) {
+		ERR (state->handle, "out of memory");
+		return -1;
 	}
 
+	/* then union tmp_union onto &new_type->types */
+	if (ebitmap_union(&new_type->types, &tmp_union)) {
+                ERR (state->handle, "Out of memory!");
+                return -1;
+        }
+
         return 0;
 }
 
@@ -264,7 +260,7 @@ static int constraint_node_clone(constra
         		if (new_expr->expr_type == CEXPR_NAMES) {
                                 if (new_expr->attr & CEXPR_TYPE) {
 					/* Type sets require expansion and conversion. */
-					if (expand_convert_type_set(state->base,
+					if (expand_convert_type_set(state->out,
 								    state->typemap,
 								    expr->type_names,
 								    &new_expr->names, 1)) {
@@ -490,7 +486,7 @@ static int role_copy_callback(hashtab_ke
                 return -1;
         }
 
-        if (expand_convert_type_set(state->base, state->typemap, &role->types, &new_role->types.types, 1)) {
+        if (expand_convert_type_set(state->out, state->typemap, &role->types, &new_role->types.types, 1)) {
                 ERR (state->handle, "Out of memory!");
                 return -1;
         }
@@ -778,7 +774,7 @@ static int copy_role_trans(expand_state_
                         ERR (state->handle, "Out of memory!");
 			return -1;
                 }
-		if (expand_convert_type_set(state->base, state->typemap, &cur->types, &types, 1)) {
+		if (expand_convert_type_set(state->out, state->typemap, &cur->types, &types, 1)) {
                         ERR (state->handle, "Out of memory!");
 			return -1;
                 }
@@ -1113,8 +1109,7 @@ static int expand_rule_helper(sepol_hand
  * rules in the destination policy.  Return 1 on success, 0 if the
  * rule conflicts with something (and hence was not added), or -1 on
  * error. */
-static int convert_and_expand_rule(sepol_handle_t *handle, 
-				   policydb_t *source_pol, policydb_t *dest_pol,
+static int convert_and_expand_rule(sepol_handle_t *handle, policydb_t *dest_pol,
                                    uint32_t *typemap, avrule_t *source_rule, avtab_t *dest_avtab,
                                    cond_av_list_t **cond, cond_av_list_t **other,
                                    int enabled) {
@@ -1132,9 +1127,9 @@ static int convert_and_expand_rule(sepol
 	alwaysexpand = ((source_rule->specified & AVRULE_TYPE) ||
 			(source_rule->flags & RULE_SELF));
 
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
+        if (expand_convert_type_set(dest_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
                 return -1;
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes, alwaysexpand))
+        if (expand_convert_type_set(dest_pol, typemap, &source_rule->ttypes, &ttypes, alwaysexpand))
                 return -1;
 
         retval = expand_rule_helper(handle, dest_pol, typemap,
@@ -1148,18 +1143,15 @@ static int convert_and_expand_rule(sepol
 }
 

-static int cond_avrule_list_copy(policydb_t *source_pol, policydb_t *dest_pol,
-                                 avrule_t *source_rules, avtab_t *dest_avtab,
-                                 cond_av_list_t **list, cond_av_list_t **other,
-                                 uint32_t *typemap, int enabled,
-                                 expand_state_t *state)
+static int cond_avrule_list_copy(policydb_t *dest_pol, avrule_t *source_rules, avtab_t *dest_avtab,
+                                 cond_av_list_t **list, cond_av_list_t **other, uint32_t *typemap, 
+				 int enabled, expand_state_t *state)
 {
 	avrule_t *cur;
 	
 	cur = source_rules;
 	while (cur) {
-		if (convert_and_expand_rule(state->handle, 
-					    source_pol, dest_pol,
+		if (convert_and_expand_rule(state->handle, dest_pol,
                                             typemap, cur, dest_avtab,
                                             list, other,
                                             enabled) != 1) {
@@ -1196,13 +1188,11 @@ static int cond_node_copy(expand_state_t
 		return -1;
         }
 
-	if (cond_avrule_list_copy(state->base, state->out,
-                                  cn->avtrue_list, &state->out->te_cond_avtab,
+	if (cond_avrule_list_copy(state->out, cn->avtrue_list, &state->out->te_cond_avtab,
                                   &new_cond->true_list, &new_cond->false_list,
                                   state->typemap, new_cond->cur_state, state))
 		return -1;
-	if (cond_avrule_list_copy(state->base, state->out,
-                                  cn->avfalse_list, &state->out->te_cond_avtab,
+	if (cond_avrule_list_copy(state->out, cn->avfalse_list, &state->out->te_cond_avtab,
                                   &new_cond->false_list, &new_cond->true_list, 
                                   state->typemap, !new_cond->cur_state, state))
 		return -1;
@@ -1428,34 +1418,47 @@ static int type_attr_remove(hashtab_key_
 	return 0;
 }
 
-int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types, unsigned char alwaysexpand)
+int convert_type_ebitmap(ebitmap_t *src, ebitmap_t *dst, uint32_t *typemap) 
 {
         unsigned int i;
-        ebitmap_t tmp;
 	ebitmap_node_t *tnode;
-        
-        ebitmap_init(types);
-        ebitmap_init(&tmp);
-        
-        if (type_set_expand(set, &tmp, p, alwaysexpand))
-                return -1;
+        ebitmap_init(dst);
 
-	ebitmap_for_each_bit(&tmp, tnode, i) {                
+	ebitmap_for_each_bit(src, tnode, i) {                
                 if (!ebitmap_node_get_bit(tnode, i))
                         continue;
 		if (!typemap[i])
 			continue;
-                if (ebitmap_set_bit(types, typemap[i] - 1, 1))
+                if (ebitmap_set_bit(dst, typemap[i] - 1, 1))
                         return -1;
         }
+	return 0;
+}
 
-        ebitmap_destroy(&tmp);
+/* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
+ * this should not be called until after all the blocks have been processed and the attributes in target policy
+ * are complete. */
+int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types, unsigned char alwaysexpand)
+{
+	type_set_t tmpset;
+        
+	type_set_init(&tmpset);	
 
-        return 0;
-}
+	if (convert_type_ebitmap(&set->types, &tmpset.types, typemap))
+		return -1;
 
+	if (convert_type_ebitmap(&set->negset, &tmpset.negset, typemap))
+		return -1;
+
+	tmpset.flags = set->flags;
+        
+        if (type_set_expand(&tmpset, types, p, alwaysexpand))
+                return -1;
 

+        return 0;
+}
+
 /* Expand a rule into a given avtab - checking for conflicting type
  * rules.  Return 1 on success, 0 if the rule conflicts with something
  * (and hence was not added), or -1 on error. */
@@ -1623,8 +1626,7 @@ out:
 	return 0;
 }
 
-static int copy_neverallow (policydb_t *source_pol, policydb_t *dest_pol,
-                            uint32_t *typemap, avrule_t *source_rule)
+static int copy_neverallow (policydb_t *dest_pol, uint32_t *typemap, avrule_t *source_rule)
 {
 	ebitmap_t stypes, ttypes;
 	avrule_t *avrule;
@@ -1633,9 +1635,9 @@ static int copy_neverallow (policydb_t *
 	ebitmap_init(&stypes);
 	ebitmap_init(&ttypes);
 
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes, 1))
+        if (expand_convert_type_set(dest_pol, typemap, &source_rule->stypes, &stypes, 1))
                 return -1;
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes, 1))
+        if (expand_convert_type_set(dest_pol, typemap, &source_rule->ttypes, &ttypes, 1))
                 return -1;
 
         avrule = (avrule_t*)malloc(sizeof(avrule_t));
@@ -1835,14 +1837,12 @@ int expand_module(sepol_handle_t *handle
                 while (cur_avrule != NULL) {
                         if (cur_avrule->specified & AVRULE_NEVERALLOW) {
                                 /* copy this over directly so that assertions are checked later */
-                                if (copy_neverallow(state.base, out, state.typemap, cur_avrule))
+                                if (copy_neverallow(out, state.typemap, cur_avrule))
                                         ERR (handle, "Error while copying neverallow.");
                         }
                         else {
-                                if (convert_and_expand_rule(state.handle, state.base, out, 
-                                                            state.typemap, cur_avrule, &out->te_avtab,
-                                                            NULL, NULL,
-                                                            0) != 1) {
+                                if (convert_and_expand_rule(state.handle, out, state.typemap, 
+							cur_avrule, &out->te_avtab, NULL, NULL, 0) != 1) {
                                         goto cleanup;
                                 }
                         }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
