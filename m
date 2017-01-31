Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgGB019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:42 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] checkpolicy: Create common function for role declares and
 requires
Date: Tue, 31 Jan 2017 14:41:55 -0500
Message-Id: <1485891718-18829-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move common code out of declare_role() and require_role_or_attribute()
    into the new function create_role().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 252 ++++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 122 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 0c76bfb..891cadf 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -201,108 +201,143 @@ static int role_implicit_bounds(hashtab_t roles_tab,
 	return 0;
 }
 
-role_datum_t *declare_role(unsigned char isattr)
+int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role, char **key)
 {
-	char *id = queue_remove(id_queue), *dest_id = NULL;
-	role_datum_t *role = NULL, *dest_role = NULL;
-	int retval;
+	char *id = queue_remove(id_queue);
+	role_datum_t *datum = NULL;
+	int ret;
 	uint32_t value;
 
+	*role = NULL;
+	*key = NULL;
+	isattr = isattr ? ROLE_ATTRIB : ROLE_ROLE;
+
 	if (id == NULL) {
 		yyerror("no role name");
-		return NULL;
+		return -1;
 	}
-	if ((role = (role_datum_t *) malloc(sizeof(*role))) == NULL) {
+
+	datum = malloc(sizeof(*datum));
+	if (datum == NULL) {
 		yyerror("Out of memory!");
 		free(id);
-		return NULL;
+		return -1;
 	}
-	role_datum_init(role);
-	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
-	retval =
-	    declare_symbol(SYM_ROLES, id, (hashtab_datum_t *) role, &value,
-			   &value);
-	if (retval == 0) {
-		role->s.value = value;
-		if ((dest_id = strdup(id)) == NULL) {
+
+	role_datum_init(datum);
+	datum->flavor = isattr;
+
+	if (scope == SCOPE_DECL) {
+		ret = declare_symbol(SYM_ROLES, id, datum, &value, &value);
+	} else {
+		ret = require_symbol(SYM_ROLES, id, datum, &value, &value);
+	}
+
+	datum->s.value = value;
+
+	if (ret == 0) {
+		*role = datum;
+		*key = strdup(id);
+		if (*key == NULL) {
 			yyerror("Out of memory!");
-			return NULL;
+			return -1;
 		}
+	} else if (ret == 1) {
+		*role = datum;
+		*key = id;
 	} else {
-		/* this role was already declared in this module, or error */
-		dest_id = id;
-		role_datum_destroy(role);
-		free(role);
-	}
-	if (retval == 0 || retval == 1) {
-		/* create a new role_datum_t for this decl, if necessary */
-		hashtab_t roles_tab;
-		assert(stack_top->type == 1);
-		if (stack_top->parent == NULL) {
-			/* in parent, so use global symbol table */
-			roles_tab = policydbp->p_roles.table;
-		} else {
-			roles_tab = stack_top->decl->p_roles.table;
+		free(id);
+		role_datum_destroy(datum);
+		free(datum);
+
+		switch (ret) {
+		case -3:
+			yyerror("Out of memory!");
+			break;
+		case -2:
+			yyerror("duplicate declaration of role");
+			break;
+		case -1:
+			yyerror("could not declare role here");
+			break;
+		default:
+			abort();	/* should never get here */
 		}
-		dest_role = (role_datum_t *) hashtab_search(roles_tab, dest_id);
-		if (dest_role == NULL) {
-			if ((dest_role =
-			     (role_datum_t *) malloc(sizeof(*dest_role))) ==
-			    NULL) {
+	}
+
+	return ret;
+}
+
+role_datum_t *declare_role(unsigned char isattr)
+{
+	char *key = NULL;
+	role_datum_t *role = NULL;
+	role_datum_t *dest_role = NULL;
+	hashtab_t roles_tab;
+	int ret, ret2;
+
+	ret = create_role(SCOPE_DECL, isattr, &role, &key);
+	if (ret < 0) {
+		return NULL;
+	}
+
+	/* create a new role_datum_t for this decl, if necessary */
+	assert(stack_top->type == 1);
+
+	if (stack_top->parent == NULL) {
+		/* in parent, so use global symbol table */
+		roles_tab = policydbp->p_roles.table;
+	} else {
+		roles_tab = stack_top->decl->p_roles.table;
+	}
+
+	dest_role = hashtab_search(roles_tab, key);
+	if (dest_role == NULL) {
+		if (ret == 0) {
+			dest_role = malloc(sizeof(*dest_role));
+			if (dest_role == NULL) {
 				yyerror("Out of memory!");
-				free(dest_id);
+				free(key);
 				return NULL;
 			}
 			role_datum_init(dest_role);
-			dest_role->s.value = value;
-			dest_role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
-			if (role_implicit_bounds(roles_tab, dest_id, dest_role)) {
-				free(dest_id);
-				role_datum_destroy(dest_role);
-				free(dest_role);
-				return NULL;
-			}
-			if (hashtab_insert(roles_tab, dest_id, dest_role)) {
-				yyerror("Out of memory!");
-				free(dest_id);
-				role_datum_destroy(dest_role);
-				free(dest_role);
-				return NULL;
-			}
+			dest_role->s.value = role->s.value;
+			dest_role->flavor = role->flavor;
 		} else {
-			free(dest_id);
-		}
-	} else {
-		free(dest_id);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
-			return NULL;
+			dest_role = role;
 		}
-	case -2:{
-			yyerror("duplicate declaration of role");
+		ret2 = role_implicit_bounds(roles_tab, key, dest_role);
+		if (ret2 != 0) {
+			free(key);
+			role_datum_destroy(dest_role);
+			free(dest_role);
 			return NULL;
 		}
-	case -1:{
-			yyerror("could not declare role here");
+		ret2 = hashtab_insert(roles_tab, key, dest_role);
+		if (ret2 != 0) {
+			yyerror("Out of memory!");
+			free(key);
+			role_datum_destroy(dest_role);
+			free(dest_role);
 			return NULL;
 		}
-	case 0:{
-			if (ebitmap_set_bit
-			    (&dest_role->dominates, role->s.value - 1, 1)) {
-				yyerror("out of memory");
-				return NULL;
-			}
-			return dest_role;
-		}
-	case 1:{
-			return dest_role;	/* role already declared for this block */
+	} else {
+		free(key);
+		if (ret == 1) {
+			role_datum_destroy(role);
+			free(role);
 		}
-	default:{
-			abort();	/* should never get here */
+	}
+
+	if (ret == 0) {
+		ret2 = ebitmap_set_bit(&dest_role->dominates, dest_role->s.value - 1, 1);
+		if (ret2 != 0) {
+			yyerror("out of memory");
+			return NULL;
 		}
 	}
+
+	return dest_role;
 }
 
 int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
@@ -881,61 +916,34 @@ int require_class(int pass)
 
 static int require_role_or_attribute(int pass, unsigned char isattr)
 {
-	char *id = queue_remove(id_queue);
+	char *key = NULL;
 	role_datum_t *role = NULL;
-	int retval;
+	int ret;
+
 	if (pass == 2) {
-		free(id);
+		free(queue_remove(id_queue));
 		return 0;
 	}
-	if (id == NULL) {
-		yyerror("no role name");
-		return -1;
-	}
-	if ((role = malloc(sizeof(*role))) == NULL) {
-		free(id);
-		yyerror("Out of memory!");
+
+	ret = create_role(SCOPE_REQ, isattr, &role, &key);
+	if (ret < 0) {
 		return -1;
 	}
-	role_datum_init(role);
-	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
-	retval =
-	    require_symbol(SYM_ROLES, id, (hashtab_datum_t *) role,
-			   &role->s.value, &role->s.value);
-	if (retval != 0) {
-		free(id);
-		role_datum_destroy(role);
-		free(role);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
-			return -1;
-		}
-	case -2:{
-			yyerror("duplicate declaration of role");
-			return -1;
-		}
-	case -1:{
-			yyerror("could not require role here");
+
+	free(key);
+
+	if (ret == 0) {
+		ret = ebitmap_set_bit(&role->dominates, role->s.value - 1, 1);
+		if (ret != 0) {
+			yyerror("Out of memory");
 			return -1;
 		}
-	case 0:{
-			/* all roles dominate themselves */
-			if (ebitmap_set_bit
-			    (&role->dominates, role->s.value - 1, 1)) {
-				yyerror("Out of memory");
-				return -1;
-			}
-			return 0;
-		}
-	case 1:{
-			return 0;	/* role already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
+	} else {
+		role_datum_destroy(role);
+		free(role);
 	}
+
+	return 0;
 }
 
 int require_role(int pass)
-- 
2.7.4
