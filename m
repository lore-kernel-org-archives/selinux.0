Subject: [PATCH] Conditional expression mapping fix
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-DR6hQi9RV4PzuB4N9iVW"
Date: Fri, 14 Oct 2005 15:28:23 -0400
Message-Id: <1129318103.2958.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DR6hQi9RV4PzuB4N9iVW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a condition where conditionals in modules did not have
the boolean values in their expressions mapped correctly while linking.
This would result in conditionals with incorrect expressions in the
final policy.


--=-DR6hQi9RV4PzuB4N9iVW
Content-Disposition: attachment; filename=1-cond-expr-mapping.diff
Content-Type: text/x-patch; name=1-cond-expr-mapping.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libsepol/src/link.c libsepol/src/link.c
--- libsepol/src/link.c	2005-10-14 11:58:15.000000000 -0400
+++ libsepol/src/link.c	2005-10-14 14:05:01.000000000 -0400
@@ -1004,6 +1004,7 @@ static int copy_role_allow_list(role_all
 static int copy_cond_list(cond_node_t *list, cond_node_t **dst,
                           policy_module_t *module, link_state_t *state)
 {
+        int i;
         cond_node_t *cur, *new_node = NULL, *tail;
         cond_expr_t *cur_expr;
         tail = *dst;
@@ -1027,6 +1028,13 @@ static int copy_cond_list(cond_node_t *l
                         assert(module->map[SYM_BOOLS][cur_expr->bool - 1] != 0);
                         cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
                 }
+                new_node->nbools = cur->nbools;
+                for (i = 0; i < cur->nbools; i++) {
+                        uint32_t remapped_id = module->map[SYM_BOOLS][cur->bool_ids[i] - 1];
+                        assert(remapped_id != 0);
+                        new_node->bool_ids[i] = remapped_id;
+                }
+                new_node->expr_pre_comp = cur->expr_pre_comp;
 
                 if (copy_avrule_list(cur->avtrue_list, &new_node->avtrue_list, module, state) ||
                     copy_avrule_list(cur->avfalse_list, &new_node->avfalse_list, module, state)) {
@@ -1605,7 +1613,7 @@ static int merge_avrules(link_state_t *s
                                 dest_cond->avtrue_list = src_cond->avtrue_list;
                         }
                         else {
-                                tmp = src_cond->avtrue_list;
+                                tmp = dest_cond->avtrue_list;
                                 while (tmp->next != NULL) {
                                         tmp = tmp->next;
                                 }
@@ -1616,7 +1624,7 @@ static int merge_avrules(link_state_t *s
                                 dest_cond->avfalse_list = src_cond->avfalse_list;
                         }
                         else {
-                                tmp = src_cond->avfalse_list;
+                                tmp = dest_cond->avfalse_list;
                                 while (tmp->next != NULL) {
                                         tmp = tmp->next;
                                 }
@@ -1745,6 +1753,22 @@ static int strip_symbols(link_state_t *s
 
 /*********** the main linking functions ***********/
 
+/* Given a module's policy, normalize all conditional expressions
+ * within.  Return 0 on success, -1 on error. */
+static int cond_normalize(policydb_t *p) {
+        avrule_block_t *block;
+        for (block = p->global; block != NULL; block = block->next) {
+                avrule_decl_t *decl;
+                for (decl = block->branch_list; decl != NULL; decl = decl->next) {
+                        cond_list_t *cond = decl->cond_list;
+                        if (cond != NULL && cond_normalize_expr(p, cond) < 0) {
+                                return -1;
+                        }
+                }
+        }
+        return 0;
+}
+
 /* Allocate space for the various remapping arrays. */
 static int prepare_module(link_state_t *state, policy_module_t *module) {
         int i;
@@ -1787,6 +1811,11 @@ static int prepare_module(link_state_t *
         }
         module->num_decls = num_decls;
         
+        /* normalize conditionals within */
+        if (cond_normalize(module->policy) < 0) {
+                write_error(state, "Error while normalizing conditionals within the module %s.", module->policy->name);
+                return -1;
+        }
         return 0;
 }
 
@@ -1827,6 +1856,11 @@ static int prepare_base(link_state_t *st
                 cur = cur->next;
         }
 
+        /* normalize conditionals within */
+        if (cond_normalize(state->base) < 0) {
+                write_error(state, "Error while normalizing conditionals within the base module.");
+                return -1;
+        }
         return 0;
 }
 

--=-DR6hQi9RV4PzuB4N9iVW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
