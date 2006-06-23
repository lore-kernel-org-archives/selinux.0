Subject: [PATCH 2/10] fix parser bugs
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:03 -0400
Message-Id: <1151074323.4011.70.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes several bugs in the parser: The role->dominates was
being set on the main symtab role datum instead of the local decl one,
types do not need to be in the local decl symtabs, role requires should
be parsed on pass 1, attributes now have typeset set in local decl so
that disabled optionals won't add types to an attribute. There is also a
FIXME noted for a future format change to make range_trans use a
type_set instead of a bitmap.

diff -pruN -x .svn selinux.old/checkpolicy/module_compiler.c optionals-in-base-take2/checkpolicy/module_compiler.c
--- selinux.old/checkpolicy/module_compiler.c	2006-06-22 20:54:51.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/module_compiler.c	2006-06-22 20:55:01.000000000 -0400
@@ -240,7 +240,7 @@ role_datum_t *declare_role(void)
                 return NULL;
         }
         case 0: {
-		if (ebitmap_set_bit(&role->dominates, role->value - 1, 1)) {
+		if (ebitmap_set_bit(&dest_role->dominates, role->value - 1, 1)) {
 			yyerror("out of memory");
 			return NULL;
 		}
@@ -256,8 +256,8 @@ role_datum_t *declare_role(void)
 }
 
 type_datum_t *declare_type(unsigned char primary, unsigned char isattr) {
-	char *id, *dest_id = NULL;
-	type_datum_t *typdatum, *dest_typdatum = NULL;
+	char *id;
+	type_datum_t *typdatum;
 	int retval;
 	uint32_t value = 0;
 
@@ -287,14 +287,6 @@ type_datum_t *declare_type(unsigned char
                 if (typdatum->primary) {
                         typdatum->value = value;
                 }
-                if ((dest_id = strdup(id)) == NULL) {
-                        yyerror("Out of memory!");
-                        return NULL;
-                }
-                if ((dest_typdatum = get_local_type(dest_id, value)) == NULL) {
-                        yyerror("Out of memory!");
-                        return NULL;
-                }       
         }
         else {
                 /* error occurred (can't have duplicate type declarations) */
@@ -317,7 +309,7 @@ type_datum_t *declare_type(unsigned char
         }
         case 0:
         case 1: {
-                return dest_typdatum;
+                return typdatum;
         }
         default: {
                 assert(0);  /* should never get here */
@@ -425,18 +417,19 @@ user_datum_t *declare_user(void) {
  * NOTE: this function usurps ownership of id afterwards.  The caller
  * shall not reference it nor free() it afterwards.
  */
-type_datum_t *get_local_type(char *id, uint32_t value) {
+type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr) {
         type_datum_t *dest_typdatum;
         hashtab_t types_tab;
         assert(stack_top->type == 1);
         if (stack_top->parent == NULL) {
-                /* in parent, so use global symbol table */
+                /* in global, so use global symbol table */
                 types_tab = policydbp->p_types.table;
         }
         else {
                 types_tab = stack_top->decl->p_types.table;
         }
-        if ((dest_typdatum = hashtab_search(types_tab, id)) == NULL) {
+        dest_typdatum = hashtab_search(types_tab, id);
+	if (!dest_typdatum) {
                 dest_typdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
                 if (dest_typdatum == NULL) {
                         free(id);
@@ -444,6 +437,8 @@ type_datum_t *get_local_type(char *id, u
                 }
                 type_datum_init(dest_typdatum);
                 dest_typdatum->value = value;
+        	dest_typdatum->isattr = isattr;
+		dest_typdatum->primary = 1;
                 if (hashtab_insert(types_tab, id, dest_typdatum)) {
 			free(id);
                         type_datum_destroy(dest_typdatum);
@@ -453,6 +448,9 @@ type_datum_t *get_local_type(char *id, u
   
         } else {
 		free(id);
+		if (dest_typdatum->isattr != isattr) {
+			return NULL;
+		}
 	}
         return dest_typdatum;
 }
@@ -709,7 +707,7 @@ int require_role(int pass)
         char *id = queue_remove(id_queue);
         role_datum_t *role = NULL;
         int retval;
-        if (pass == 1) {
+        if (pass == 2) {
                 free(id);
                 return 0;
         }
diff -pruN -x .svn selinux.old/checkpolicy/module_compiler.h optionals-in-base-take2/checkpolicy/module_compiler.h
--- selinux.old/checkpolicy/module_compiler.h	2006-06-22 20:54:51.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/module_compiler.h	2006-06-22 11:46:20.000000000 -0400
@@ -34,7 +34,7 @@ role_datum_t *declare_role(void);
 type_datum_t *declare_type(unsigned char primary, unsigned char isattr);
 user_datum_t *declare_user(void);
 
-type_datum_t *get_local_type(char *id, uint32_t value);
+type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr);
 
 /* Add a symbol to the current avrule_block's require section.  Note
  * that a module may not both declare and require the same symbol.
diff -pruN -x .svn selinux.old/checkpolicy/parse_util.c optionals-in-base-take2/checkpolicy/parse_util.c
--- selinux.old/checkpolicy/parse_util.c	2006-06-22 20:54:51.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/parse_util.c	2006-06-22 11:46:20.000000000 -0400
@@ -33,7 +33,7 @@ extern char source_file[];
 extern policydb_t *policydbp;
 extern int mlspol;
 
-int read_source_policy(policydb_t *p, char *file, char *progname)
+int read_source_policy(policydb_t *p, const char *file, const char *progname)
 {
         yyin = fopen(file, "r");
         if (!yyin) {
diff -pruN -x .svn selinux.old/checkpolicy/parse_util.h optionals-in-base-take2/checkpolicy/parse_util.h
--- selinux.old/checkpolicy/parse_util.h	2006-06-22 20:54:51.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/parse_util.h	2006-06-22 11:46:20.000000000 -0400
@@ -30,6 +30,6 @@
  * expected policy type set. The string progname is used for
  * error messages. No checking of assertions, hierarchy, etc.
  * is done. */
-int read_source_policy(policydb_t *p, char *file, char *progname);
+int read_source_policy(policydb_t *p, const char *file, const char *progname);
 
 #endif
diff -pruN -x .svn selinux.old/checkpolicy/policy_parse.y optionals-in-base-take2/checkpolicy/policy_parse.y
--- selinux.old/checkpolicy/policy_parse.y	2006-06-22 20:54:51.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/policy_parse.y	2006-06-22 20:57:21.000000000 -0400
@@ -1810,10 +1810,6 @@ static int define_typeattribute(void)
 		free(id);
 		return -1;
 	}
-        if ((t = get_local_type(id, t->value)) == NULL) {
-                yyerror("Out of memory!");
-                return -1;
-        }
 
 	while ((id = queue_remove(id_queue))) {
                 if (!is_id_in_scope(SYM_TYPES, id)) {
@@ -1837,7 +1833,10 @@ static int define_typeattribute(void)
 			return -1;
 		}
 
-		free(id);
+	        if ((attr = get_local_type(id, attr->value, 1)) == NULL) {
+	                yyerror("Out of memory!");
+	                return -1;
+	        }
 
 		if (ebitmap_set_bit(&attr->types, (t->value - 1), TRUE)) {
 			yyerror("out of memory");
@@ -1897,7 +1896,7 @@ static int define_type(int alias)
 			return -1;
 		}
 
-                if ((attr = get_local_type(id, attr->value)) == NULL) {
+                if ((attr = get_local_type(id, attr->value, 1)) == NULL) {
                         yyerror("Out of memory!");
                         return -1;
                 }
@@ -4582,6 +4581,8 @@ static int define_range_trans(void)
 		return -1;
 	}
 
+	/* FIXME: this expands type_sets at compile time which is inappropriate, the type_sets
+	 * should be stored which is a format change */
 	ebitmap_for_each_bit(&doms.types, snode, i) {
 		if (!ebitmap_node_get_bit(snode, i))
 			continue;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
