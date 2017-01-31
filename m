Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgGC019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:42 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] checkpolicy: Create common function for user declares and
 requires
Date: Tue, 31 Jan 2017 14:41:56 -0500
Message-Id: <1485891718-18829-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move common code out of declare_user() and require_user() into the
new function create_user().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 224 +++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 110 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 891cadf..90e82c2 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -456,103 +456,132 @@ static int user_implicit_bounds(hashtab_t users_tab,
 	return 0;
 }
 
-user_datum_t *declare_user(void)
+int create_user(uint32_t scope, user_datum_t **user, char **key)
 {
-	char *id = queue_remove(id_queue), *dest_id = NULL;
-	user_datum_t *user = NULL, *dest_user = NULL;
-	int retval;
-	uint32_t value = 0;
+	char *id = queue_remove(id_queue);
+	user_datum_t *datum = NULL;
+	int ret;
+	uint32_t value;
+
+	*user = NULL;
+	*key = NULL;
 
 	if (id == NULL) {
 		yyerror("no user name");
-		return NULL;
+		return -1;
 	}
-	if ((user = (user_datum_t *) malloc(sizeof(*user))) == NULL) {
+
+	datum = malloc(sizeof(*datum));
+	if (datum == NULL) {
 		yyerror("Out of memory!");
 		free(id);
-		return NULL;
+		return -1;
 	}
-	user_datum_init(user);
 
-	retval =
-	    declare_symbol(SYM_USERS, id, (hashtab_datum_t *) user, &value,
-			   &value);
+	user_datum_init(datum);
 
-	if (retval == 0) {
-		user->s.value = value;
-		if ((dest_id = strdup(id)) == NULL) {
+	if (scope == SCOPE_DECL) {
+		ret = declare_symbol(SYM_USERS, id, datum, &value, &value);
+	} else {
+		ret = require_symbol(SYM_USERS, id, datum, &value, &value);
+	}
+
+	datum->s.value = value;
+
+	if (ret == 0) {
+		*user = datum;
+		*key = strdup(id);
+		if (*key == NULL) {
 			yyerror("Out of memory!");
-			return NULL;
+			return -1;
 		}
+	} else if (ret == 1) {
+		*user = datum;
+		*key = id;
 	} else {
-		/* this user was already declared in this module, or error */
-		dest_id = id;
-		user_datum_destroy(user);
-		free(user);
-	}
-	if (retval == 0 || retval == 1) {
-		/* create a new user_datum_t for this decl, if necessary */
-		hashtab_t users_tab;
-		assert(stack_top->type == 1);
-		if (stack_top->parent == NULL) {
-			/* in parent, so use global symbol table */
-			users_tab = policydbp->p_users.table;
-		} else {
-			users_tab = stack_top->decl->p_users.table;
+		free(id);
+		user_datum_destroy(datum);
+		free(datum);
+
+		switch (ret) {
+		case -3:
+			yyerror("Out of memory!");
+			break;
+		case -2:
+			yyerror("duplicate declaration of user");
+			break;
+		case -1:
+			yyerror("could not declare user here");
+			break;
+		default:
+			abort();	/* should never get here */
 		}
-		dest_user = (user_datum_t *) hashtab_search(users_tab, dest_id);
-		if (dest_user == NULL) {
-			if ((dest_user =
-			     (user_datum_t *) malloc(sizeof(*dest_user))) ==
-			    NULL) {
+	}
+
+	return ret;
+}
+
+user_datum_t *declare_user(void)
+{
+	char *key = NULL;
+	user_datum_t *user = NULL;
+	user_datum_t *dest_user = NULL;
+	hashtab_t users_tab;
+	int ret, ret2;
+
+	ret = create_user(SCOPE_DECL, &user, &key);
+	if (ret < 0) {
+		return NULL;
+	}
+
+	/* create a new user_datum_t for this decl, if necessary */
+	assert(stack_top->type == 1);
+
+	if (stack_top->parent == NULL) {
+		/* in parent, so use global symbol table */
+		users_tab = policydbp->p_users.table;
+	} else {
+		users_tab = stack_top->decl->p_users.table;
+	}
+
+	dest_user = hashtab_search(users_tab, key);
+	if (dest_user == NULL) {
+		if (ret == 0) {
+			dest_user = malloc(sizeof(*dest_user));
+			if (dest_user == NULL) {
 				yyerror("Out of memory!");
-				free(dest_id);
+				free(key);
 				return NULL;
 			}
 			user_datum_init(dest_user);
-			dest_user->s.value = value;
-			if (user_implicit_bounds(users_tab, dest_id, dest_user)) {
-				free(dest_id);
-				user_datum_destroy(dest_user);
-				free(dest_user);
-				return NULL;
-			}
-			if (hashtab_insert(users_tab, dest_id, dest_user)) {
-				yyerror("Out of memory!");
-				free(dest_id);
-				user_datum_destroy(dest_user);
-				free(dest_user);
-				return NULL;
-			}
+			dest_user->s.value = user->s.value;
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
+			dest_user = user;
 		}
-	case -2:{
-			yyerror("duplicate declaration of user");
+		ret2 = user_implicit_bounds(users_tab, key, dest_user);
+		if (ret2 != 0) {
+			free(key);
+			user_datum_destroy(dest_user);
+			free(dest_user);
 			return NULL;
 		}
-	case -1:{
-			yyerror("could not declare user here");
+		ret2 = hashtab_insert(users_tab, key, dest_user);
+		if (ret2 != 0) {
+			yyerror("Out of memory!");
+			free(key);
+			user_datum_destroy(dest_user);
+			free(dest_user);
 			return NULL;
 		}
-	case 0:{
-			return dest_user;
-		}
-	case 1:{
-			return dest_user;	/* user already declared for this block */
-		}
-	default:{
-			abort();	/* should never get here */
+	} else {
+		free(key);
+		if (ret == 1) {
+			user_datum_destroy(user);
+			free(user);
 		}
 	}
+
+	return dest_user;
 }
 
 /* Return a type_datum_t for the local avrule_decl with the given ID.
@@ -987,53 +1016,28 @@ int require_attribute(int pass)
 
 int require_user(int pass)
 {
-	char *id = queue_remove(id_queue);
+	char *key = NULL;
 	user_datum_t *user = NULL;
-	int retval;
+	int ret;
+
 	if (pass == 1) {
-		free(id);
+		free(queue_remove(id_queue));
 		return 0;
 	}
-	if (id == NULL) {
-		yyerror("no user name");
-		return -1;
-	}
-	if ((user = malloc(sizeof(*user))) == NULL) {
-		free(id);
-		yyerror("Out of memory!");
+
+	ret = create_user(SCOPE_REQ, &user, &key);
+	if (ret < 0) {
 		return -1;
 	}
-	user_datum_init(user);
-	retval =
-	    require_symbol(SYM_USERS, id, (hashtab_datum_t *) user,
-			   &user->s.value, &user->s.value);
-	if (retval != 0) {
-		free(id);
+
+	free(key);
+
+	if (ret == 1) {
 		user_datum_destroy(user);
+		free(user);
 	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
-			return -1;
-		}
-	case -2:{
-			yyerror("duplicate declaration of user");
-			return -1;
-		}
-	case -1:{
-			yyerror("could not require user here");
-			return -1;
-		}
-	case 0:{
-			return 0;
-		}
-	case 1:{
-			return 0;	/* user already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
-	}
+
+	return 0;
 }
 
 static int require_bool_tunable(int pass, int is_tunable)
-- 
2.7.4
