Subject: [PATCH] declare then require
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-eTTaks38MT5RX88ESMqf"
Date: Wed, 19 Oct 2005 13:51:28 -0400
Message-Id: <1129744289.15338.13.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eTTaks38MT5RX88ESMqf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch allows one to declare a symbol and subsequently require it.
This is necessary for reference policy so that interfaces which require
symbols don't cause errors if the symbol was declared in that module.
This happens on modules that have interfaces that affect all domains,
for example.

Note, the opposite, requiring and then declaring does not work, further
the declaration must be 'in scope' when the require is called, if the
declaration is not in scope this is an error because the symbol may not
exist after linking, and it is not possible to tell at compile time.



--=-eTTaks38MT5RX88ESMqf
Content-Disposition: attachment; filename=1-declare-then-require.diff
Content-Type: text/x-patch; name=1-declare-then-require.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-10-18 11:01:57.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-10-18 11:37:33.000000000 -0400
@@ -33,6 +33,7 @@ typedef struct scope_stack {
                                * declaration is current */
         avrule_t *last_avrule;
         int in_else;          /* if in an avrule block, within ELSE branch */
+        int require_given;    /* 1 if this block had at least one require */
         struct scope_stack *parent, *child;
 } scope_stack_t;
 
@@ -497,12 +498,40 @@ int require_symbol(uint32_t symbol_type,
                 *dest_value = *v;
         }
         else if (retval == -2) {
-                return -2;
+                /* ignore require statements if that symbol was
+                 * previously declared and is in current scope */
+                int prev_declaration_ok = 0;
+                if (is_id_in_scope(symbol_type, key)) {
+                        if (symbol_type == SYM_TYPES) {
+                                /* check that previous symbol has same
+                                 * type/attribute-ness */
+                                unsigned char new_isattr = ((type_datum_t *) datum)->isattr;
+                                type_datum_t *old_datum = (type_datum_t *) hashtab_search(policydbp->symtab[SYM_TYPES].table, key);
+                                assert(old_datum != NULL);
+                                unsigned char old_isattr = old_datum->isattr;
+                                prev_declaration_ok = (old_isattr == new_isattr ? 1 : 0);
+                        }
+                        else {
+                                prev_declaration_ok = 1;
+                        }
+                }
+                if (prev_declaration_ok) {
+                        /* ignore this require statement because it
+                         * was already declared within my scope */
+                        stack_top->require_given = 1;
+                        return 1;
+                }
+                else {
+                        /* previous declaration was not in scope or
+                         * had a mismatched type/attribute, so
+                         * generate an error */
+                        return -2;
+                }
         }
         else if (retval < 0) {
                 return -3;
         }
-        else {  /* fall through possible if retval is 0 */
+        else {  /* fall through possible if retval is 0 or 1 */
         }
         if (datum_value != NULL) {
                 if (ebitmap_set_bit(decl->required.scope + symbol_type,
@@ -511,6 +540,7 @@ int require_symbol(uint32_t symbol_type,
                         return -3;
                 }
         }
+        stack_top->require_given = 1;
         return retval;
 }
 
@@ -1085,6 +1115,7 @@ int begin_optional_else(int pass) {
         stack_top->in_else = 1;
         stack_top->decl = decl;
         stack_top->last_avrule = NULL;
+        stack_top->require_given = 0;
         next_decl_id++;
         return 0;
 }
@@ -1136,9 +1167,7 @@ static int copy_requirements(avrule_decl
  * pass 2, have this block inherit its parents' requirements.  Return
  * 0 on success, -1 on failure. */
 int end_avrule_block(int pass) {
-        int i, j;
         avrule_decl_t *decl = stack_top->decl;
-	ebitmap_node_t *node;
         assert(stack_top->type == 1);
         if (pass == 2) {
                 /* this avrule_decl inherits all of its parents'
@@ -1148,18 +1177,8 @@ int end_avrule_block(int pass) {
                 }
                 return 0;
         }
-        if (!stack_top->in_else) {
+        if (!stack_top->in_else && !stack_top->require_given) {
                 /* non-ELSE branches must have at least one thing required */
-                for (i = 0; i < SYM_NUM; i++) {
-                        ebitmap_t *bitmap = &decl->required.scope[i];
-			ebitmap_for_each_bit(bitmap, node, j) {
-				if (ebitmap_node_get_bit(node, j)) {
-                                        /* at least one thing was required */
-                                        return 0;
-                                }
-                        }
-                }
-                /* this av did not require anything, which is an error */
                 yyerror("This block has no require section.");
                 return -1;
         }

--=-eTTaks38MT5RX88ESMqf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
