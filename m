Subject: [PATCH 10/10] alias fix
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:33 -0400
Message-Id: <1151074354.4011.83.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the alias fix that uses the type flavor patch (9/10)

diff -pruN -x .svn selinux.old/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- selinux.old/libsepol/src/link.c	2006-06-22 14:41:16.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-22 14:41:40.000000000 -0400
@@ -572,6 +572,7 @@ static int alias_copy_callback(hashtab_k
         type_datum_t *type, *base_type, *new_type = NULL, *target_type;
 	link_state_t *state = (link_state_t *)data;
         policy_module_t *mod = state->cur;
+	int primval;
 
         type = (type_datum_t*)datum;
 	/* there are 2 kinds of aliases. Ones with their own value (TYPE_ALIAS)
@@ -583,7 +584,12 @@ static int alias_copy_callback(hashtab_k
                 return 0;
         }
 
-        target_id = mod->policy->p_type_val_to_name[type->value - 1];
+	if (type->flavor == TYPE_ALIAS) 
+		primval = type->primary;
+	else
+		primval = type->value;
+
+        target_id = mod->policy->p_type_val_to_name[primval - 1];
         target_type = hashtab_search(state->base->p_types.table, target_id);
         if (target_type == NULL) {
                 ERR(state->handle, "%s: Could not find type %s for alias %s.",
@@ -599,34 +605,46 @@ static int alias_copy_callback(hashtab_k
                 if ((new_type = (type_datum_t *) calloc(1, sizeof(*new_type))) == NULL) {
                         goto cleanup;
                 }
-                new_type->primary = type->primary;
-                new_type->flavor = type->flavor;
-                new_type->value = target_type->value;
+		/* the linked copy always has TYPE_ALIAS style aliases */
+                new_type->primary = target_type->value;
+                new_type->flavor= TYPE_ALIAS;
+                new_type->value = state->base->p_types.nprim + 1;
                 if ((new_id = strdup(id)) == NULL) {
                         goto cleanup;
                 }
                 if (hashtab_insert(state->base->p_types.table, new_id, new_type)) {
                         goto cleanup;
                 }
+		state->base->p_types.nprim++;
                 base_type = new_type;
-        }
+        } else {
 
-        new_id = NULL;
-        if ((new_type = (type_datum_t *) calloc(1, sizeof(*new_type))) == NULL) {
-                goto cleanup;
-        }
-        new_type->primary = type->primary;
-        new_type->flavor = type->flavor;
-        new_type->value = base_type->value;
-        if ((new_id = strdup(id)) == NULL) {
-                goto cleanup;
-        }
-        if (hashtab_insert(state->dest_decl->p_types.table, new_id, new_type)) {
-                goto cleanup;
-        }
+	/* if this already exists and isn't an alias it was required by another module (or base)
+	 * and inserted into the hashtable as a type, fix it up now */
 
-        state->cur->map[SYM_TYPES][type->value - 1] = new_type->value;
-        return 0;
+		if (base_type->flavor == TYPE_ALIAS) {
+			/* error checking */
+			assert(base_type->primary == target_type->value);
+			assert(base_type->primary == mod->map[SYM_TYPES][primval - 1]);
+			assert(mod->map[SYM_TYPES][type->value - 1] == base_type->primary);
+			return 0;
+		}
+	
+		if (base_type->flavor == TYPE_ATTRIB) {
+			ERR(state->handle, "%s is an alias of an attribute, not allowed",id);
+			return -1;
+		}
+	
+		base_type->flavor = TYPE_ALIAS;
+		base_type->primary = target_type->value;
+	
+
+	}		
+	/* the aliases map points from its value to its primary so when this module 
+	 * references this type the value it gets back from the map is the primary */
+       	mod->map[SYM_TYPES][type->value - 1] = base_type->primary;
+        
+	return 0;
 
  cleanup:
         ERR(state->handle, "Out of memory!");



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
