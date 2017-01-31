Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJh834019663
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:43:08 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: Improve check for identifier flavor mismatch
Date: Tue, 31 Jan 2017 14:43:24 -0500
Message-Id: <1485891804-18892-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

An identifier flavor mismatch occurs when an identifier is
declared or required as a regular role or type in one place but as
an attribute in another place.

Currently there is only a check for an identifier flavor mismatch
when a type has already been declared and there is a require of
the same type in the same scope. There are no checks if the require
comes first and there are no checks for roles.

Check for an identifier flavor mismatch for both roles and types
whenever a declaration or requirement tries to add an identifier
that is already in the symtab.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 46 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index e128a1b..95e29be 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -291,6 +291,15 @@ int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role, char
 			return -1;
 		}
 	} else if (ret == 1) {
+		*role = hashtab_search(policydbp->symtab[SYM_ROLES].table, id);
+		if (*role && (isattr != (*role)->flavor)) {
+			yyerror2("Identifier %s used as both an attribute and a role",
+				 id);
+			free(id);
+			role_datum_destroy(datum);
+			free(datum);
+			return -1;
+		}
 		*role = datum;
 		*key = id;
 	} else {
@@ -383,6 +392,7 @@ int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
 	uint32_t value = 0;
 
 	*type = NULL;
+	isattr = isattr ? TYPE_ATTRIB : TYPE_TYPE;
 
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
@@ -403,7 +413,7 @@ int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
 	}
 	type_datum_init(datum);
 	datum->primary = 1;
-	datum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
+	datum->flavor = isattr;
 
 	if (scope == SCOPE_DECL) {
 		ret = declare_symbol(SYM_TYPES, id, datum, &value, &value);
@@ -418,6 +428,12 @@ int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
 		type_datum_destroy(datum);
 		free(datum);
 		*type = hashtab_search(policydbp->symtab[SYM_TYPES].table, id);
+		if (*type && (isattr != (*type)->flavor)) {
+			yyerror2("Identifier %s used as both an attribute and a type",
+				 id);
+			free(id);
+			return -1;
+		}
 		free(id);
 	} else {
 		print_error_msg(ret, SYM_TYPES);
@@ -711,35 +727,9 @@ int require_symbol(uint32_t symbol_type,
 	} else if (ret == -2) {
 		/* ignore require statements if that symbol was
 		 * previously declared and is in current scope */
-		int prev_declaration_ok = 0;
 		if (is_id_in_scope(symbol_type, key)) {
-			if (symbol_type == SYM_TYPES) {
-				/* check that previous symbol has same
-				 * type/attribute-ness */
-				unsigned char new_isattr =
-				    ((type_datum_t *) datum)->flavor;
-				type_datum_t *old_datum =
-				    (type_datum_t *) hashtab_search(policydbp->
-								    symtab
-								    [SYM_TYPES].
-								    table, key);
-				assert(old_datum != NULL);
-				unsigned char old_isattr = old_datum->flavor;
-				prev_declaration_ok =
-				    (old_isattr == new_isattr ? 1 : 0);
-			} else {
-				prev_declaration_ok = 1;
-			}
-		}
-		if (prev_declaration_ok) {
-			/* ignore this require statement because it
-			 * was already declared within my scope */
-			stack_top->require_given = 1;
-			return 1;
+			ret = 1;
 		} else {
-			/* previous declaration was not in scope or
-			 * had a mismatched type/attribute, so
-			 * generate an error */
 			return -2;
 		}
 	} else if (ret < 0) {
-- 
2.7.4
