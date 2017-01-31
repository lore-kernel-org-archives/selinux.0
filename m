Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgGE019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:43 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] checkpolicy: Move common require and declare code into
 new function
Date: Tue, 31 Jan 2017 14:41:58 -0500
Message-Id: <1485891718-18829-6-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move common code from declare_symbol() and require_symbol() to a new
function named create_symbol().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 137 +++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 74 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 7b35b56..e128a1b 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -130,12 +130,12 @@ int define_policy(int pass, int module_header_given)
 	return 0;
 }
 
-/* Given the current parse stack, returns 1 if a declaration would be
- * allowed here or 0 if not.  For example, declarations are not
- * allowed in conditionals, so if there are any conditionals in the
+/* Given the current parse stack, returns 1 if a declaration or require would
+ * be allowed here or 0 if not.  For example, declarations and requirements are
+ * not allowed in conditionals, so if there are any conditionals in the
  * current scope stack then this would return a 0.
  */
-static int is_declaration_allowed(void)
+static int is_creation_allowed(void)
 {
 	if (stack_top->type != 1 || stack_top->in_else) {
 		return 0;
@@ -143,6 +143,47 @@ static int is_declaration_allowed(void)
 	return 1;
 }
 
+/* Attempt to declare or require a symbol within the current scope.
+ * Returns:
+ *  0: Success - Symbol had not been previously created.
+ *  1: Success - Symbol had already been created and caller must free datum.
+ * -1: Failure - Symbol cannot be created here
+ * -2: Failure - Duplicate declaration or type/attribute mismatch
+ * -3: Failure - Out of memory or some other error
+ */
+int create_symbol(uint32_t symbol_type, hashtab_key_t key, hashtab_datum_t datum,
+		  uint32_t * dest_value, uint32_t scope)
+{
+	avrule_decl_t *decl = stack_top->decl;
+	int ret;
+
+	if (!is_creation_allowed()) {
+		return -1;
+	}
+
+	ret = symtab_insert(policydbp, symbol_type, key, datum, scope,
+			    decl->decl_id, dest_value);
+
+	if (ret == 1 && dest_value) {
+		symtab_datum_t *s =
+			hashtab_search(policydbp->symtab[symbol_type].table,
+				       key);
+		assert(s != NULL);
+
+		if (symbol_type == SYM_LEVELS) {
+			*dest_value = ((level_datum_t *)s)->level->sens;
+		} else {
+			*dest_value = s->value;
+		}
+	} else if (ret == -2) {
+		return -2;
+	} else if (ret < 0) {
+		return -3;
+	}
+
+	return ret;
+}
+
 /* Attempt to declare a symbol within the current declaration.  If
  * currently within a non-conditional and in a non-else branch then
  * insert the symbol, return 0 on success if symbol was undeclared.
@@ -157,39 +198,18 @@ int declare_symbol(uint32_t symbol_type,
 		   uint32_t * dest_value, uint32_t * datum_value)
 {
 	avrule_decl_t *decl = stack_top->decl;
-	int retval;
+	int ret = create_symbol(symbol_type, key, datum, dest_value, SCOPE_DECL);
 
-	/* first check that symbols may be declared here */
-	if (!is_declaration_allowed()) {
-		return -1;
+	if (ret < 0) {
+		return ret;
 	}
-	retval = symtab_insert(policydbp, symbol_type, key, datum,
-			       SCOPE_DECL, decl->decl_id, dest_value);
-	if (retval == 1 && dest_value) {
-		symtab_datum_t *s =
-		    (symtab_datum_t *) hashtab_search(policydbp->
-						      symtab[symbol_type].table,
-						      key);
-		assert(s != NULL);
-		
-		if (symbol_type == SYM_LEVELS) {
-			*dest_value = ((level_datum_t *)s)->level->sens;
-		} else {
-			*dest_value = s->value;
-		}
-	} else if (retval == -2) {
-		return -2;
-	} else if (retval < 0) {
+
+	if (ebitmap_set_bit(decl->declared.scope + symbol_type,
+			    *datum_value - 1, 1)) {
 		return -3;
-	} else {		/* fall through possible if retval is 0 */
-	}
-	if (datum_value != NULL) {
-		if (ebitmap_set_bit(decl->declared.scope + symbol_type,
-				    *datum_value - 1, 1)) {
-			return -3;
-		}
 	}
-	return retval;
+
+	return ret;
 }
 
 static int role_implicit_bounds(hashtab_t roles_tab,
@@ -668,18 +688,6 @@ role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr)
 	return dest_roledatum;
 }
 
-/* Given the current parse stack, returns 1 if a requirement would be
- * allowed here or 0 if not.  For example, the ELSE branch may never
- * have its own requirements.
- */
-static int is_require_allowed(void)
-{
-	if (stack_top->type == 1 && !stack_top->in_else) {
-		return 1;
-	}
-	return 0;
-}
-
 /* Attempt to require a symbol within the current scope.  If currently
  * within an optional (and not its else branch), add the symbol to the
  * required list.  Return 0 on success, 1 if caller needs to free()
@@ -693,27 +701,14 @@ int require_symbol(uint32_t symbol_type,
 		   uint32_t * dest_value, uint32_t * datum_value)
 {
 	avrule_decl_t *decl = stack_top->decl;
-	int retval;
+	int ret = create_symbol(symbol_type, key, datum, dest_value, SCOPE_REQ);
 
-	/* first check that symbols may be required here */
-	if (!is_require_allowed()) {
-		return -1;
-	}
-	retval = symtab_insert(policydbp, symbol_type, key, datum,
-			       SCOPE_REQ, decl->decl_id, dest_value);
-	if (retval == 1) {
-		symtab_datum_t *s =
-		    (symtab_datum_t *) hashtab_search(policydbp->
-						      symtab[symbol_type].table,
-						      key);
-		assert(s != NULL);
-		
-		if (symbol_type == SYM_LEVELS) {
-			*dest_value = ((level_datum_t *)s)->level->sens;
-		} else {
-			*dest_value = s->value;
+	if (ret == 0 || ret == 1) {
+		if (ebitmap_set_bit(decl->required.scope + symbol_type,
+				    *datum_value - 1, 1)) {
+			return -3;
 		}
-	} else if (retval == -2) {
+	} else if (ret == -2) {
 		/* ignore require statements if that symbol was
 		 * previously declared and is in current scope */
 		int prev_declaration_ok = 0;
@@ -747,18 +742,12 @@ int require_symbol(uint32_t symbol_type,
 			 * generate an error */
 			return -2;
 		}
-	} else if (retval < 0) {
-		return -3;
-	} else {		/* fall through possible if retval is 0 or 1 */
-	}
-	if (datum_value != NULL) {
-		if (ebitmap_set_bit(decl->required.scope + symbol_type,
-				    *datum_value - 1, 1)) {
-			return -3;
-		}
+	} else if (ret < 0) {
+		return ret;
 	}
+
 	stack_top->require_given = 1;
-	return retval;
+	return ret;
 }
 
 int add_perm_to_class(uint32_t perm_value, uint32_t class_value)
-- 
2.7.4
