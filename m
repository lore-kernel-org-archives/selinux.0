Subject: [PATCH] sepol link.c fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-RcXD9IIxbXiqDuq/MoP6"
Date: Thu, 22 Sep 2005 16:52:53 -0400
Message-Id: <1127422373.21806.41.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RcXD9IIxbXiqDuq/MoP6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The first patch fixes a NULL dereference, a memory leak (only the first
block of an avrule list was being freed instead of the whole list), and
makes merge_avrules static.

The second patch makes a permission dependancy error message more
helpful, adds sanity checking to ensure that the first policydb sent to
link_modules is a base module, and that all the others are modules.
Last, a typo in a verbose message is fixed.

There may be offsets in the second patch, they are ok.

Joshua Brindle

--=-RcXD9IIxbXiqDuq/MoP6
Content-Disposition: attachment; filename=7-sepol-link-fixes.patch
Content-Type: text/x-patch; name=7-sepol-link-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/link.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/link.c	2005-09-22 15:39:59.000000000 -0400
@@ -1488,7 +1488,8 @@ static void enable_avrules(link_state_t 
                                 continue;
                         }
                         while (depth_count-- > 0 && decl != NULL) {
-                                if (is_decl_requires_met(state, decl, NULL)) {
+                                struct missing_requirement req;  /* unused */
+                                if (is_decl_requires_met(state, decl, &req)) {
                                         decl->enabled = 1;
                                         block->enabled = decl;
                                         changed = 1;
@@ -1552,7 +1553,7 @@ static int verify_module_requirements(li
 /*********** merging and stripping functions ***********/
 
 /* for each enabled block, merge its identifiers and avrules into the base */
-int merge_avrules(link_state_t *state, avrule_block_t *block) {
+static int merge_avrules(link_state_t *state, avrule_block_t *block) {
         avrule_decl_t *dest_decl = block->branch_list;
         cond_node_t *src_cond, *dest_cond;
         avrule_t *last_avrule = dest_decl->avrules, *tmp;
@@ -1951,8 +1961,8 @@ int link_modules(policydb_t *b, policydb
                 retval = -1;
                 goto cleanup;
         }
-        avrule_block_destroy(state.last_base_avrule_block->next);
-        state.last_base_avrule_block->next = NULL;
+        avrule_block_list_destroy(state.base->global->next);
+        state.base->global->next = NULL;
 
         /* reset the global branch enabled flag now that the policy
            has been reconstructed */

--=-RcXD9IIxbXiqDuq/MoP6
Content-Disposition: attachment; filename=8-sepol-link-errors.patch
Content-Type: text/x-patch; name=8-sepol-link-errors.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/link.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/link.c	2005-09-22 15:39:59.000000000 -0400
@@ -164,7 +164,7 @@ static int permission_copy_callback(hash
                 new_perm = hashtab_search(dest_class->comdatum->permissions.table, perm_id);
         }
         if (!new_perm) {
-                write_error(state, "Modules may not declare new permissions.");
+                write_error(state, "Module %s depends on permission %s in class %s, not satisfied", state->cur_mod_name, perm_id, mod->policy->p_class_val_to_name[dest_class->value - 1]);
                 return -1;
         }
 
@@ -1879,7 +1880,12 @@ int link_modules(policydb_t *b, policydb
         state.verbose = verbose;
         state.error_buf = error_buf;
         state.error_buf_size = error_buf_size;
-        
+
+        if (b->policy_type != POLICY_BASE) {
+                write_error(&state, "Target of link was not a base policy.");
+                return -1;
+        }
+
         /* first allocate some space to hold the maps from module
          * symbol's value to the destination symbol value; then do
          * other preparation work */
@@ -1888,6 +1894,10 @@ int link_modules(policydb_t *b, policydb
         	return -1;
         }
         for (i = 0; i < len; i++) {
+                if (mods[i]->policy_type != POLICY_MOD) {
+                        write_error(&state, "Tried to link in a policy that was not a module.");
+                        goto cleanup;
+                }
         	if ((modules[i] = (policy_module_t*)calloc(1, sizeof(policy_module_t))) == NULL) {
                         write_error(&state, "Out of memory!");
                         goto cleanup;
@@ -1926,7 +1936,7 @@ int link_modules(policydb_t *b, policydb
          * longer needed other than for error reporting purposes */
 
         if (state.verbose) {
-                printf("Determing which avrules to enable.\n");
+                printf("Determining which avrules to enable.\n");
         }
         /* enable the global branch, then the appropriate optional branches */
         base_was_enabled = b->global->branch_list->enabled;

--=-RcXD9IIxbXiqDuq/MoP6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
