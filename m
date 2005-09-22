Subject: [PATCH] sepol minor fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-PwFN57v7swAA1WjTfvNy"
Date: Thu, 22 Sep 2005 16:51:25 -0400
Message-Id: <1127422285.21806.38.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PwFN57v7swAA1WjTfvNy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The first patch adds a sanity check to expand_module to ensure the
incoming module is a base module.

The second patch moves the pointer free for avrule_decl_t to it's
destroy function, and removes it from the callers.

The third patch corrects some logic that tests whether a symbol is
enabled or not. The new logic is whether it has ever been enabled within
the current scope, the old (incorrect) logic was whether it had ever
been disabled.

Joshua Brindle

--=-PwFN57v7swAA1WjTfvNy
Content-Disposition: attachment; filename=4-sepol-expand-check-module.patch
Content-Type: text/x-patch; name=4-sepol-expand-check-module.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/expand.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/expand.c	2005-09-21 11:27:28.000000000 -0400
@@ -1737,7 +1737,12 @@ int expand_module(policydb_t *base, poli
         if (error_buf != NULL && error_buf_size > 0) {
                 *error_buf = '\0';
         }
-        
+
+        if (base->policy_type != POLICY_BASE) {
+                write_error(&state, "Target of expand was not a base policy.");
+                return -1;
+        }
+
 	if (policydb_index_classes(state.base)) {
                 write_error (&state, "Error while indexing base classes");
                 goto cleanup;

--=-PwFN57v7swAA1WjTfvNy
Content-Disposition: attachment; filename=5-sepol-avrule-destroy.patch
Content-Type: text/x-patch; name=5-sepol-avrule-destroy.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/avrule_block.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/avrule_block.c	2005-09-22 14:56:02.000000000 -0400
@@ -61,6 +75,8 @@ avrule_decl_t *avrule_decl_create(uint32
         return decl;
 }
 
+/* note that unlike the other destroy functions, this one does /NOT/
+ * destroy the pointer itself */
 static void scope_index_destroy(scope_index_t *scope) {
         unsigned int i;
         if (scope == NULL) {
@@ -87,6 +103,7 @@ static void avrule_decl_destroy(avrule_d
         scope_index_destroy(&x->required);
         scope_index_destroy(&x->declared);
         symtabs_destroy(x->symtab);
+        free(x);
 }
 
 void avrule_block_destroy(avrule_block_t *x)
@@ -99,9 +116,9 @@ void avrule_block_destroy(avrule_block_t
         while (decl != NULL) {
             avrule_decl_t *next_decl = decl->next;
             avrule_decl_destroy(decl);
-            free(decl);
             decl = next_decl;
         }
+        free(x);
 }
 
 void avrule_block_list_destroy(avrule_block_t *x)
@@ -109,7 +126,6 @@ void avrule_block_list_destroy(avrule_bl
         while (x != NULL) {
                 avrule_block_t *next = x->next;
                 avrule_block_destroy(x);
-                free(x);
                 x = next;
         }
 }

--=-PwFN57v7swAA1WjTfvNy
Content-Disposition: attachment; filename=6-sepol-avrule-id_enabled.patch
Content-Type: text/x-patch; name=6-sepol-avrule-id_enabled.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/avrule_block.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/avrule_block.c	2005-09-22 10:18:26.000000000 -0400
@@ -156,11 +174,11 @@ int is_id_enabled(char *id, policydb_t *
         }
         for (i = 0; i < scope->decl_ids_len; i++) {
                 avrule_decl_t *decl = get_avrule_decl(p, scope->decl_ids[i]);
-                if (decl == NULL || !decl->enabled) {
-                        return 0;
+                if (decl != NULL && decl->enabled) {
+                        return 1;
                 }
         }
-        return 1;
+        return 0;
 }
 
 /* Check if a particular permission is present within the given class,

--=-PwFN57v7swAA1WjTfvNy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
