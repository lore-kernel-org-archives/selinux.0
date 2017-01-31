Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgGD019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:43 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] checkpolicy: Cleanup error messages
Date: Tue, 31 Jan 2017 14:41:57 -0500
Message-Id: <1485891718-18829-5-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add the new function print_error_msg() to print an error message
based on the local error number and symbol_type. Remove the
duplicate switch statements used throughout module_complier.c
to display error messages.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 213 +++++++++++++-----------------------------
 1 file changed, 64 insertions(+), 149 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 90e82c2..7b35b56 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -51,6 +51,34 @@ static scope_stack_t *stack_top = NULL;
 static avrule_block_t *last_block;
 static uint32_t next_decl_id = 1;
 
+static const char * const flavor_str[SYM_NUM] = {
+	[SYM_COMMONS] = "common",
+	[SYM_CLASSES] = "class",
+	[SYM_ROLES] = "role",
+	[SYM_TYPES] = "type",
+	[SYM_USERS] = "user",
+	[SYM_BOOLS] = "bool",
+	[SYM_LEVELS] = "level",
+	[SYM_CATS] = "cat"
+};
+
+void print_error_msg(int ret, uint32_t symbol_type)
+{
+	switch (ret) {
+	case -3:
+		yyerror("Out of memory!");
+		break;
+	case -2:
+		yyerror2("Duplicate declaration of %s", flavor_str[symbol_type]);
+		break;
+	case -1:
+		yyerror2("Could not declare %s here", flavor_str[symbol_type]);
+		break;
+	default:
+		yyerror("Unknown error");
+	}
+}
+
 int define_policy(int pass, int module_header_given)
 {
 	char *id;
@@ -246,23 +274,10 @@ int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role, char
 		*role = datum;
 		*key = id;
 	} else {
+		print_error_msg(ret, SYM_ROLES);
 		free(id);
 		role_datum_destroy(datum);
 		free(datum);
-
-		switch (ret) {
-		case -3:
-			yyerror("Out of memory!");
-			break;
-		case -2:
-			yyerror("duplicate declaration of role");
-			break;
-		case -1:
-			yyerror("could not declare role here");
-			break;
-		default:
-			abort();	/* should never get here */
-		}
 	}
 
 	return ret;
@@ -385,23 +400,10 @@ int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
 		*type = hashtab_search(policydbp->symtab[SYM_TYPES].table, id);
 		free(id);
 	} else {
+		print_error_msg(ret, SYM_TYPES);
 		free(id);
 		type_datum_destroy(datum);
 		free(datum);
-
-		switch (ret) {
-		case -3:
-			yyerror("Out of memory!");
-			break;
-		case -2:
-			yyerror2("duplicate declaration of type/attribute");
-			break;
-		case -1:
-			yyerror("could not declare type/attribute here");
-			break;
-		default:
-			abort();	/* should never get here */
-		}
 	}
 
 	return ret;
@@ -499,23 +501,10 @@ int create_user(uint32_t scope, user_datum_t **user, char **key)
 		*user = datum;
 		*key = id;
 	} else {
+		print_error_msg(ret, SYM_USERS);
 		free(id);
 		user_datum_destroy(datum);
 		free(datum);
-
-		switch (ret) {
-		case -3:
-			yyerror("Out of memory!");
-			break;
-		case -2:
-			yyerror("duplicate declaration of user");
-			break;
-		case -1:
-			yyerror("could not declare user here");
-			break;
-		default:
-			abort();	/* should never get here */
-		}
 	}
 
 	return ret;
@@ -842,50 +831,29 @@ int require_class(int pass)
 	if ((datum = calloc(1, sizeof(*datum))) == NULL ||
 	    symtab_init(&datum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("Out of memory!");
-		goto cleanup;
+		return -1;
 	}
 	ret =
 	    require_symbol(SYM_CLASSES, class_id, datum, &datum->s.value,
 			   &datum->s.value);
-	switch (ret) {
-	case -3:{
+	if (ret < 0) {
+		print_error_msg(ret, SYM_CLASSES);
+		free(class_id);
+		class_datum_destroy(datum);
+		return -1;
+	}
+
+	if (ret == 0) {
+		/* a new class was added; reindex everything */
+		if (policydb_index_classes(policydbp)) {
 			yyerror("Out of memory!");
-			free(class_id);
-			class_datum_destroy(datum);
-			goto cleanup;
-		}
-	case -2:{
-			yyerror("duplicate declaration of class");
-			free(class_id);
-			class_datum_destroy(datum);
-			goto cleanup;
-		}
-	case -1:{
-			yyerror("could not require class here");
-			free(class_id);
-			class_datum_destroy(datum);
-			goto cleanup;
-		}
-	case 0:{
-			/* a new class was added; reindex everything */
-			if (policydb_index_classes(policydbp)) {
-				yyerror("Out of memory!");
-				goto cleanup;
-			}
-			break;
-		}
-	case 1:{
-			class_datum_destroy(datum);
-			datum =
-			    hashtab_search(policydbp->p_classes.table,
-					   class_id);
-			assert(datum);	/* the class datum should have existed */
-			free(class_id);
-			break;
-		}
-	default:{
-			abort();	/* should never get here */
+			return -1;
 		}
+	} else {
+		class_datum_destroy(datum);
+		datum = hashtab_search(policydbp->p_classes.table, class_id);
+		assert(datum);	/* the class datum should have existed */
+		free(class_id);
 	}
 
 	/* now add each of the permissions to this class's requirements */
@@ -908,13 +876,13 @@ int require_class(int pass)
 				    ("Base policy - require of permission %s without prior declaration.",
 				     perm_id);
 				free(perm_id);
-				goto cleanup;
+				return -1;
 			}
 			allocated = 1;
 			if ((perm = malloc(sizeof(*perm))) == NULL) {
 				yyerror("Out of memory!");
 				free(perm_id);
-				goto cleanup;
+				return -1;
 			}
 			memset(perm, 0, sizeof(*perm));
 			ret =
@@ -924,14 +892,14 @@ int require_class(int pass)
 				yyerror("Out of memory!");
 				free(perm_id);
 				free(perm);
-				goto cleanup;
+				return -1;
 			}
 			perm->s.value = datum->permissions.nprim + 1;
 		}
 
 		if (add_perm_to_class(perm->s.value, datum->s.value) == -1) {
 			yyerror("Out of memory!");
-			goto cleanup;
+			return -1;
 		}
 
 		/* Update number of primitives if we allocated one. */
@@ -939,8 +907,6 @@ int require_class(int pass)
 			datum->permissions.nprim++;
 	}
 	return 0;
-      cleanup:
-	return -1;
 }
 
 static int require_role_or_attribute(int pass, unsigned char isattr)
@@ -1065,30 +1031,13 @@ static int require_bool_tunable(int pass, int is_tunable)
 			   &booldatum->s.value, &booldatum->s.value);
 	if (retval != 0) {
 		cond_destroy_bool(id, booldatum, NULL);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
+		if (retval < 0) {
+			print_error_msg(retval, SYM_BOOLS);
 			return -1;
 		}
-	case -2:{
-			yyerror("duplicate declaration of boolean");
-			return -1;
-		}
-	case -1:{
-			yyerror("could not require boolean here");
-			return -1;
-		}
-	case 0:{
-			return 0;
-		}
-	case 1:{
-			return 0;	/* boolean already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
 	}
+
+	return 0;
 }
 
 int require_bool(int pass)
@@ -1138,30 +1087,13 @@ int require_sens(int pass)
 		free(level->level);
 		level_datum_destroy(level);
 		free(level);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
+		if (retval < 0) {
+			print_error_msg(retval, SYM_LEVELS);
 			return -1;
 		}
-	case -2:{
-			yyerror("duplicate declaration of sensitivity");
-			return -1;
-		}
-	case -1:{
-			yyerror("could not require sensitivity here");
-			return -1;
-		}
-	case 0:{
-			return 0;
-		}
-	case 1:{
-			return 0;	/* sensitivity already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
 	}
+
+	return 0;
 }
 
 int require_cat(int pass)
@@ -1191,30 +1123,13 @@ int require_cat(int pass)
 		free(id);
 		cat_datum_destroy(cat);
 		free(cat);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
-			return -1;
-		}
-	case -2:{
-			yyerror("duplicate declaration of category");
+		if (retval < 0) {
+			print_error_msg(retval, SYM_CATS);
 			return -1;
 		}
-	case -1:{
-			yyerror("could not require category here");
-			return -1;
-		}
-	case 0:{
-			return 0;
-		}
-	case 1:{
-			return 0;	/* category already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
 	}
+
+	return 0;
 }
 
 static int is_scope_in_stack(scope_datum_t * scope, scope_stack_t * stack)
-- 
2.7.4
