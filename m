Subject: [PATCH 9/10] type flavors
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:30 -0400
Message-Id: <1151074350.4011.81.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This fixes an alias problem where the base or module requires a type
(which adds it to the symtab as a type) but it is declared as an alias
later. This is a problem because the alias would have its own value
instead of the value of its primary. This fixes the problem by changing
the isattr field to a flavor field that can identify the type as a type,
alias or attribute. If flavor is an alias the primary field is set to
the value of its primary. This is only done in the linked copy so the
module format is unchanged. The expander uses the primary value of the
alias via the type maps.

diff -pruN -x .svn selinux.old/checkpolicy/module_compiler.c optionals-in-base-take2/checkpolicy/module_compiler.c
--- selinux.old/checkpolicy/module_compiler.c	2006-06-22 21:04:36.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/module_compiler.c	2006-06-22 20:59:13.000000000 -0400
@@ -280,7 +280,7 @@ type_datum_t *declare_type(unsigned char
 	}
         type_datum_init(typdatum);
         typdatum->primary = primary;
-        typdatum->isattr = isattr;
+        typdatum->flavor = isattr? TYPE_ATTRIB : TYPE_TYPE;
         
         retval = declare_symbol(SYM_TYPES, id, typdatum, &value, &value);
         if (retval == 0 || retval == 1) {
@@ -437,7 +437,7 @@ type_datum_t *get_local_type(char *id, u
                 }
                 type_datum_init(dest_typdatum);
                 dest_typdatum->value = value;
-        	dest_typdatum->isattr = isattr;
+        	dest_typdatum->flavor = isattr? TYPE_ATTRIB : TYPE_TYPE;
 		dest_typdatum->primary = 1;
                 if (hashtab_insert(types_tab, id, dest_typdatum)) {
 			free(id);
@@ -448,7 +448,7 @@ type_datum_t *get_local_type(char *id, u
   
         } else {
 		free(id);
-		if (dest_typdatum->isattr != isattr) {
+		if (dest_typdatum->flavor != isattr? TYPE_ATTRIB : TYPE_TYPE) {
 			return NULL;
 		}
 	}
@@ -504,10 +504,10 @@ int require_symbol(uint32_t symbol_type,
                         if (symbol_type == SYM_TYPES) {
                                 /* check that previous symbol has same
                                  * type/attribute-ness */
-                                unsigned char new_isattr = ((type_datum_t *) datum)->isattr;
+                                unsigned char new_isattr = ((type_datum_t *) datum)->flavor;
                                 type_datum_t *old_datum = (type_datum_t *) hashtab_search(policydbp->symtab[SYM_TYPES].table, key);
                                 assert(old_datum != NULL);
-                                unsigned char old_isattr = old_datum->isattr;
+                                unsigned char old_isattr = old_datum->flavor;
                                 prev_declaration_ok = (old_isattr == new_isattr ? 1 : 0);
                         }
                         else {
@@ -777,7 +777,7 @@ static int require_type_or_attribute(int
         }
         type_datum_init(type);
         type->primary = 1;
-        type->isattr = isattr;
+        type->flavor = isattr? TYPE_ATTRIB : TYPE_TYPE;
         retval = require_symbol(SYM_TYPES, id, (hashtab_datum_t *) type, &type->value, &type->value);
         if (retval != 0) {
                 free(id);
@@ -1071,6 +1071,7 @@ int begin_optional(int pass) {
                     (decl = avrule_decl_create(next_decl_id)) == NULL) {
                         goto cleanup;
                 }
+		block->flags |= AVRULE_OPTIONAL;
                 block->branch_list = decl;
                 last_block->next = block;
         }
diff -pruN -x .svn selinux.old/checkpolicy/policy_parse.y optionals-in-base-take2/checkpolicy/policy_parse.y
--- selinux.old/checkpolicy/policy_parse.y	2006-06-22 21:04:36.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/policy_parse.y	2006-06-22 20:59:13.000000000 -0400
@@ -1772,7 +1772,7 @@ static int define_typealias(void)
                 return -1;
         }
 	t = hashtab_search(policydbp->p_types.table, id);
-	if (!t || t->isattr) {
+	if (!t || t->flavor == TYPE_ATTRIB) {
 		sprintf(errormsg, "unknown type %s, or it was already declared as an attribute", id);
 		yyerror(errormsg);
 		free(id);
@@ -1804,7 +1804,7 @@ static int define_typeattribute(void)
                 return -1;
         }
 	t = hashtab_search(policydbp->p_types.table, id);
-	if (!t || t->isattr) {
+	if (!t || t->flavor == TYPE_ATTRIB) {
 		sprintf(errormsg, "unknown type %s", id);
 		yyerror(errormsg);
 		free(id);
@@ -1826,7 +1826,7 @@ static int define_typeattribute(void)
 			return -1;
 		}
 
-		if (!attr->isattr) {
+		if (attr->flavor != TYPE_ATTRIB) {
 			sprintf(errormsg, "%s is a type, not an attribute", id);
 			yyerror(errormsg);
 			free(id);
@@ -1890,7 +1890,7 @@ static int define_type(int alias)
 			newattr = 0;
 		}
 
-		if (!attr->isattr) {
+		if (attr->flavor != TYPE_ATTRIB) {
 			sprintf(errormsg, "%s is a type, not an attribute", id);
 			yyerror(errormsg);
 			return -1;
@@ -2047,7 +2047,7 @@ static int define_compute_type_helper(in
         }
 	datum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
 						(hashtab_key_t) id);
-	if (!datum || datum->isattr) {
+	if (!datum || datum->flavor == TYPE_ATTRIB) {
 		sprintf(errormsg, "unknown type %s", id);
 		yyerror(errormsg);
 		goto bad;
@@ -3879,7 +3879,7 @@ static int parse_security_context(contex
         }
 	typdatum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
 						   (hashtab_key_t) id);
-	if (!typdatum || typdatum->isattr) {
+	if (!typdatum || typdatum->flavor == TYPE_ATTRIB) {
 		sprintf(errormsg, "type %s is not defined or is an attribute", id);
 		yyerror(errormsg);
 		free(id);
diff -pruN -x .svn selinux.old/checkpolicy/test/dismod.c optionals-in-base-take2/checkpolicy/test/dismod.c
--- selinux.old/checkpolicy/test/dismod.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/test/dismod.c	2006-06-22 20:59:13.000000000 -0400
@@ -296,7 +296,7 @@ int display_type_callback(hashtab_key_t 
                  * alternative way of displaying a name */
                 fprintf(fp, " %s [%d]: ", (char *) key, type->value);
         }
-	if (type->isattr) {
+	if (type->flavor == TYPE_ATTRIB) {
 		fprintf(fp, "attribute for types");
 		for (i = ebitmap_startbit(&type->types); i < ebitmap_length(&type->types); i++) {
 			if (!ebitmap_get_bit(&type->types, i))
diff -pruN -x .svn selinux.old/libsepol/include/sepol/policydb/policydb.h optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h
--- selinux.old/libsepol/include/sepol/policydb/policydb.h	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h	2006-06-22 20:59:13.000000000 -0400
@@ -133,8 +133,11 @@ typedef struct role_allow {
 /* Type attributes */
 typedef struct type_datum {
 	uint32_t value;		/* internal type value */
-	unsigned char primary;	/* primary name? */
-	unsigned char isattr;   /* is this a type attribute? */
+	uint32_t primary;	/* primary name? can be set to primary value if below is TYPE_ */
+#define TYPE_TYPE 0		/* regular type or alias in kernel policies */
+#define TYPE_ATTRIB 1		/* attribute */
+#define TYPE_ALIAS 2		/* alias in modular policy */
+	uint32_t flavor;
 	ebitmap_t types;        /* types with this attribute */
 } type_datum_t;
 
diff -pruN -x .svn selinux.old/libsepol/src/context.c optionals-in-base-take2/libsepol/src/context.c
--- selinux.old/libsepol/src/context.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/context.c	2006-06-22 20:59:13.000000000 -0400
@@ -186,7 +186,7 @@ int context_from_record(
 	/* Type */
 	typdatum = (type_datum_t *) hashtab_search(policydb->p_types.table,
 					(hashtab_key_t) type);
-	if (!typdatum || typdatum->isattr) {
+	if (!typdatum || typdatum->flavor == TYPE_ATTRIB) {
 		ERR(handle, "type %s is not defined", type);
 		goto err_destroy;
 	}
diff -pruN -x .svn selinux.old/libsepol/src/expand.c optionals-in-base-take2/libsepol/src/expand.c
--- selinux.old/libsepol/src/expand.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/expand.c	2006-06-22 20:59:13.000000000 -0400
@@ -54,7 +54,7 @@ static int type_copy_callback(hashtab_ke
         type = (type_datum_t *)datum;
         state = (expand_state_t*)data;
 
-        if (!type->primary) {
+        if ((type->flavor == TYPE_TYPE && !type->primary) || type->flavor == TYPE_ALIAS) {
                 /* aliases are handled later */
                 return 0;
         }
@@ -80,7 +80,7 @@ static int type_copy_callback(hashtab_ke
         }
         memset(new_type, 0, sizeof(type_datum_t));
 
-        new_type->isattr = type->isattr;
+        new_type->flavor = type->flavor;
 	new_type->value = ++state->out->p_types.nprim;
 	if (new_type->value > UINT16_MAX) {
                 free (new_id);
@@ -114,7 +114,7 @@ static int attr_convert_callback(hashtab
         type = (type_datum_t *)datum;
         state = (expand_state_t*)data;
 
-        if (!type->isattr)
+        if (type->flavor != TYPE_ATTRIB)
                 return 0;
 
         if (!is_id_enabled(id, state->base, SYM_TYPES)) {
@@ -414,10 +414,13 @@ static int alias_copy_callback(hashtab_k
         alias = (type_datum_t *)datum;
         state = (expand_state_t*)data;
 
-        /* ignore types and attributes */
-        if (alias->primary || alias->isattr) {
-                return 0;
-        }
+	/* ignore regular types */
+	if (alias->flavor == TYPE_TYPE && alias->primary)
+		return 0;
+	
+	/* ignore attributes */
+	if (alias->flavor == TYPE_ATTRIB)
+		return 0;
 
         if (state->verbose)
                 INFO(state->handle, "copying alias %s", id);
@@ -435,7 +438,12 @@ static int alias_copy_callback(hashtab_k
                 return -ENOMEM;
         }
         memset(new_alias, 0, sizeof(type_datum_t));
-        new_alias->value = state->typemap[alias->value - 1];
+	if (alias->flavor == TYPE_TYPE)
+	        new_alias->value = state->typemap[alias->value - 1];
+	else if (alias->flavor == TYPE_ALIAS)
+		new_alias->value = state->typemap[alias->primary - 1];
+	else 
+		assert(0); /* unreachable */
 
         ret = hashtab_insert(state->out->p_types.table,
                              (hashtab_key_t)new_id, (hashtab_datum_t) new_alias);
@@ -1456,7 +1464,7 @@ static int type_attr_map(hashtab_key_t k
 	ebitmap_node_t *tnode;
 
 	type = (type_datum_t *) datum;
-	if (type->isattr) {
+	if (type->flavor == TYPE_ATTRIB) {
 		if (ebitmap_cpy(&p->attr_type_map[type->value-1],
 				&type->types)) {
 			ERR(state->handle, "Out of memory!");
@@ -1489,7 +1497,7 @@ static int type_attr_remove(hashtab_key_
 
 	typdatum = (type_datum_t *) datum;
 	p = (policydb_t *)args;
-	if (!typdatum->primary) {
+	if (typdatum->flavor == TYPE_ATTRIB) {
 		p->type_val_to_struct[typdatum->value - 1] = NULL;
 		p->p_type_val_to_name[typdatum->value - 1] = NULL;
 		return 1;
@@ -1627,7 +1635,7 @@ int type_set_expand(type_set_t *set, ebi
 		/* First go through the types and OR all the attributes to types */
 		ebitmap_for_each_bit(&set->types, tnode, i) {
 			if (ebitmap_node_get_bit(tnode, i)) {
-				if (p->type_val_to_struct[i]->isattr) {
+				if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
 					if (ebitmap_union(&types, &p->type_val_to_struct[i]->types)) {
 						return -1;
 					}
@@ -1649,7 +1657,7 @@ int type_set_expand(type_set_t *set, ebi
 	ebitmap_for_each_bit(&set->negset, tnode, i) {
                 if (ebitmap_node_get_bit(tnode, i)) {
                         if (p->type_val_to_struct[i] && 
-			    p->type_val_to_struct[i]->isattr) {
+			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
                                 if (ebitmap_union(&neg_types, &p->type_val_to_struct[i]->types)) {
                                         return -1;
                                 }
@@ -1667,7 +1675,7 @@ int type_set_expand(type_set_t *set, ebi
                         if (ebitmap_get_bit(&neg_types, i))
                                 continue;
                         if (p->type_val_to_struct[i] &&
-			    p->type_val_to_struct[i]->isattr)
+			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB)
                                 continue;
                         if (ebitmap_set_bit(t, i, 1))
                                 return -1;
@@ -1684,7 +1692,7 @@ int type_set_expand(type_set_t *set, ebi
         if (set->flags & TYPE_COMP) {
                 for(i = 0; i < p->p_types.nprim; i++) {
                         if (p->type_val_to_struct[i] &&
-			    p->type_val_to_struct[i]->isattr) {
+			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
                                 assert(!ebitmap_get_bit(t, i));
                                 continue;
                         }
diff -pruN -x .svn selinux.old/libsepol/src/hierarchy.c optionals-in-base-take2/libsepol/src/hierarchy.c
--- selinux.old/libsepol/src/hierarchy.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/hierarchy.c	2006-06-22 20:59:13.000000000 -0400
@@ -86,7 +86,7 @@ static int check_type_hierarchy_callback
 	t = (type_datum_t *)d;
 	key = (char *)k;
 
-	if (t->isattr) {
+	if (t->flavor == TYPE_ATTRIB) {
 		/* It's an attribute, we don't care */
 		return 0;
 	}
@@ -106,7 +106,7 @@ static int check_type_hierarchy_callback
 		ERR(a->handle, "type %s does not exist, %s is an orphan",
 			parent,a->p->p_type_val_to_name[t->value - 1]);
 		rc = 1;
-	} else if (t2->isattr) {
+	} else if (t2->flavor == TYPE_ATTRIB) {
 			/* The parent is an attribute but the child isn't, not legal */
 			ERR(a->handle, "type %s is a child of an attribute",
 			a->p->p_type_val_to_name[t->value - 1]);
diff -pruN -x .svn selinux.old/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- selinux.old/libsepol/src/link.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-22 21:05:25.000000000 -0400
@@ -352,7 +352,7 @@ static int type_copy_callback(hashtab_ke
 	link_state_t *state = (link_state_t *)data;
 
         type = (type_datum_t*)datum;
-        if (!type->primary) {
+        if ((type->flavor == TYPE_TYPE && !type->primary) || type->flavor == TYPE_ALIAS) {
                 /* aliases are handled later, in alias_copy_callback() */
                 return 0;
         }
@@ -363,12 +363,12 @@ static int type_copy_callback(hashtab_ke
                  * module expected.  duplicate declarations (e.g., two
                  * modules both declare type foo_t) is checked during
                  * scope_copy_callback(). */
-                if (type->isattr && !base_type->isattr) {
+                if (type->flavor == TYPE_ATTRIB && base_type->flavor != TYPE_ATTRIB) {
                         ERR(state->handle, "%s: Expected %s to be an attribute, but it was already declared as a type.",
                                     state->cur_mod_name, id);
                         return -1;
                 }
-                else if (!type->isattr && base_type->isattr) {
+                else if (type->flavor != TYPE_ATTRIB && base_type->flavor == TYPE_ATTRIB) {
                         ERR(state->handle, "%s: Expected %s to be a type, but it was already declared as an attribute.",
                                     state->cur_mod_name, id);
                         return -1;
@@ -386,7 +386,7 @@ static int type_copy_callback(hashtab_ke
                         goto cleanup;
                 }
                 new_type->primary = type->primary;
-                new_type->isattr = type->isattr;
+                new_type->flavor = type->flavor;
                 /* for attributes, the writing of new_type->types is
                    done in type_fix_callback() */
 
@@ -407,7 +407,7 @@ static int type_copy_callback(hashtab_ke
 			goto cleanup;
 		}
 		new_type->primary = type->primary;
-		new_type->isattr = type->isattr;
+		new_type->flavor = type->flavor;
 		new_type->value = base_type->value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
@@ -574,7 +574,10 @@ static int alias_copy_callback(hashtab_k
         policy_module_t *mod = state->cur;
 
         type = (type_datum_t*)datum;
-        if (type->primary) {
+	/* there are 2 kinds of aliases. Ones with their own value (TYPE_ALIAS)
+	 * and ones with the value of their primary (TYPE_TYPE && type->primary = 0)
+	 */
+        if (!(type->flavor == TYPE_ALIAS || (type->flavor == TYPE_TYPE && !type->primary))) { 
                 /* ignore types and attributes -- they were handled in
                  * type_copy_callback() */
                 return 0;
@@ -597,7 +600,7 @@ static int alias_copy_callback(hashtab_k
                         goto cleanup;
                 }
                 new_type->primary = type->primary;
-                new_type->isattr = type->isattr;
+                new_type->flavor = type->flavor;
                 new_type->value = target_type->value;
                 if ((new_id = strdup(id)) == NULL) {
                         goto cleanup;
@@ -613,7 +616,7 @@ static int alias_copy_callback(hashtab_k
                 goto cleanup;
         }
         new_type->primary = type->primary;
-        new_type->isattr = type->isattr;
+        new_type->flavor = type->flavor;
         new_type->value = base_type->value;
         if ((new_id = strdup(id)) == NULL) {
                 goto cleanup;
@@ -784,12 +787,12 @@ static int type_fix_callback(hashtab_key
 		typetab = &state->dest_decl->p_types;
         
         /* only fix attributes */
-        if (!type->primary || !type->isattr) {
+        if (type->flavor != TYPE_ATTRIB) {
                 return 0;
         }
 
         new_type = hashtab_search(typetab->table, id);
-        assert(new_type != NULL && new_type->isattr);
+        assert(new_type != NULL && new_type->flavor == TYPE_ATTRIB);
 
         if (state->verbose) {
                 INFO(state->handle, "fixing attribute %s", id);
diff -pruN -x .svn selinux.old/libsepol/src/policydb.c optionals-in-base-take2/libsepol/src/policydb.c
--- selinux.old/libsepol/src/policydb.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/policydb.c	2006-06-22 20:59:13.000000000 -0400
@@ -1710,7 +1710,7 @@ static int type_read(policydb_t * p __at
 	typdatum->value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
         if (p->policy_type != POLICY_KERN) {
-                typdatum->isattr = le32_to_cpu(buf[3]);
+                typdatum->flavor = le32_to_cpu(buf[3]);
                 if (ebitmap_read(&typdatum->types, fp))
                         goto bad;
         }
diff -pruN -x .svn selinux.old/libsepol/src/write.c optionals-in-base-take2/libsepol/src/write.c
--- selinux.old/libsepol/src/write.c	2006-06-22 21:08:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/write.c	2006-06-22 20:59:13.000000000 -0400
@@ -902,7 +902,7 @@ static int type_write(hashtab_key_t key,
 	buf[items++] = cpu_to_le32(typdatum->value);
 	buf[items++] = cpu_to_le32(typdatum->primary);
 	if (p->policy_type != POLICY_KERN) {
-		buf[items++] = cpu_to_le32(typdatum->isattr);
+		buf[items++] = cpu_to_le32(typdatum->flavor);
 	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
