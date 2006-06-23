Subject: [PATCH 5/10] decl index in policydb
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:18 -0400
Message-Id: <1151074338.4011.75.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds a decl_val_to_struct index to the policydb and changes the decl
search function to use it. This speeds up the linker quite a bit.

diff -pruN -x .svn selinux.old/libsepol/include/sepol/policydb/policydb.h optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h
--- selinux.old/libsepol/include/sepol/policydb/policydb.h	2006-06-10 00:11:50.000000000 -0400
+++ optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h	2006-06-22 11:47:07.000000000 -0400
@@ -405,6 +405,8 @@ typedef struct policydb {
 
         /* module rule storage */
         avrule_block_t *global;
+        /* avrule_decl index used for link/expand */
+	avrule_decl_t **decl_val_to_struct;
 
         
 	/* compiled storage of rules - use for the kernel policy */
diff -pruN -x .svn selinux.old/libsepol/src/avrule_block.c optionals-in-base-take2/libsepol/src/avrule_block.c
--- selinux.old/libsepol/src/avrule_block.c	2006-06-10 00:11:53.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/avrule_block.c	2006-06-22 11:47:26.000000000 -0400
@@ -128,21 +128,6 @@ void avrule_block_list_destroy(avrule_bl
         }
 }
 
-/* Return the AV decl block with the requested identifier.  If the
- * decl was not found return NULL. */
-avrule_decl_t *get_avrule_decl(policydb_t *p, uint32_t decl_id) {
-        avrule_block_t *cur;
-        for (cur = p->global; cur != NULL; cur = cur->next) {
-                avrule_decl_t *decl;
-                for (decl = cur->branch_list; decl != NULL; decl = decl->next) {
-                        if (decl->decl_id == decl_id) {
-                                return decl;
-                        }
-                }
-        }
-        return NULL;
-}
-
 /* Get a conditional node from a avrule_decl with the same expression.
  * If that expression does not exist then create one. */
 cond_list_t *get_decl_cond_list(policydb_t *p, avrule_decl_t *decl, cond_list_t *cond) {
@@ -158,7 +143,8 @@ cond_list_t *get_decl_cond_list(policydb
 
 /* Look up an identifier in a policy's scoping table.  If it is there,
  * marked as SCOPE_DECL, and any of its declaring block has been enabled,
- * then return 1.  Otherwise return 0. */
+ * then return 1.  Otherwise return 0. Can only be called after the 
+ * decl_val_to_struct index has been created */
 int is_id_enabled(char *id, policydb_t *p, int symbol_table) {
         scope_datum_t *scope = (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
         uint32_t i;
@@ -169,7 +155,7 @@ int is_id_enabled(char *id, policydb_t *
                 return 0;
         }
         for (i = 0; i < scope->decl_ids_len; i++) {
-                avrule_decl_t *decl = get_avrule_decl(p, scope->decl_ids[i]);
+                avrule_decl_t *decl = p->decl_val_to_struct[scope->decl_ids[i]];
                 if (decl != NULL && decl->enabled) {
                         return 1;
                 }
diff -pruN -x .svn selinux.old/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- selinux.old/libsepol/src/link.c	2006-06-10 00:11:53.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-22 13:14:55.000000000 -0400
@@ -54,7 +54,6 @@ typedef struct link_state {
 	policydb_t *base;
         avrule_block_t *last_avrule_block, *last_base_avrule_block;
         uint32_t next_decl_id, current_decl_id;
-        avrule_decl_t **decl_id_to_decl;
 
         /* temporary variables, used during hashtab_map() calls */
 	policy_module_t *cur;
@@ -1217,7 +1216,8 @@ static int copy_avrule_block(link_state_
                         last_decl->next = new_decl;
                 }
                 last_decl = new_decl;
-                state->decl_id_to_decl[state->next_decl_id] = new_decl;
+                state->base->decl_val_to_struct[state->next_decl_id] = new_decl;
+		state->decl_to_mod[state->next_decl_id] = module->policy;
                 module->avdecl_map[decl->decl_id] = new_decl->decl_id;
 
                 if (copy_avrule_decl(state, module, decl, new_decl) == -1) {
@@ -1858,8 +1858,14 @@ static int prepare_base(link_state_t *st
 
         /* allocate the table mapping from base's decl_id to its
          * avrule_decls and set the initial mappings */
-        if ((state->decl_id_to_decl = calloc(state->next_decl_id + num_mod_decls,
-                                             sizeof(*(state->decl_id_to_decl)))) == NULL) {
+        if ((state->base->decl_val_to_struct = calloc(state->next_decl_id + num_mod_decls,
+                                             sizeof(*(state->base->decl_val_to_struct)))) == NULL) {
+                ERR(state->handle, "Out of memory!");
+                return -1;
+        }
+	/* This allocates the decl block to module mapping used for error reporting */
+        if ((state->decl_to_mod = calloc(state->next_decl_id + num_mod_decls,
+                                             sizeof(*(state->decl_to_mod)))) == NULL) {
                 ERR(state->handle, "Out of memory!");
                 return -1;
         }
@@ -1867,7 +1873,8 @@ static int prepare_base(link_state_t *st
         while (cur != NULL) {
                 avrule_decl_t *decl = cur->branch_list;
                 while (decl != NULL) {
-                        state->decl_id_to_decl[decl->decl_id] = decl;
+                        state->base->decl_val_to_struct[decl->decl_id] = decl;
+			state->decl_to_mod[decl->decl_id] = state->base;
                         decl = decl->next;
                 }
                 cur = cur->next;
diff -pruN -x .svn selinux.old/libsepol/src/policydb.c optionals-in-base-take2/libsepol/src/policydb.c
--- selinux.old/libsepol/src/policydb.c	2006-06-22 11:46:42.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/policydb.c	2006-06-22 13:15:26.000000000 -0400
@@ -393,6 +393,7 @@ int policydb_init(policydb_t * p)
             (p->global->branch_list = avrule_decl_create(1)) == NULL) {
                 goto out_free_symtab;
         }
+	p->decl_val_to_struct = NULL;
 
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
@@ -650,6 +651,34 @@ int policydb_index_bools(policydb_t * p)
 	return 0;
 }
 
+int policydb_index_decls(policydb_t *p)
+{
+	avrule_block_t *curblock;
+	avrule_decl_t *decl;
+	int num_decls = 1;
+
+	free(p->decl_val_to_struct);
+
+	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
+		for (decl = curblock->branch_list; decl != NULL; decl = decl->next) {
+			num_decls++;	
+		}
+	}
+	
+	p->decl_val_to_struct = calloc(num_decls, sizeof(*(p->decl_val_to_struct)));
+	if (!p->decl_val_to_struct) {
+		return -1;
+	}
+	
+	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
+		for (decl = curblock->branch_list; decl != NULL; decl = decl->next) {
+			p->decl_val_to_struct[decl->decl_id] = decl;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Define the other val_to_name and val_to_struct arrays
  * in a policy database structure.  
@@ -884,6 +913,7 @@ void policydb_destroy(policydb_t * p)
 		free(p->user_val_to_struct);
 	if (p->type_val_to_struct)
 		free(p->type_val_to_struct);
+	free(p->decl_val_to_struct);
 
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->scope[i].table, scope_destroy, 0);
@@ -2789,6 +2819,8 @@ int policydb_read(policydb_t * p, struct
 
         }
 
+	if (policydb_index_decls(p))
+		goto bad;
 
 	if (policydb_index_classes(p))
 		goto bad;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
