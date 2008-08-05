Message-ID: <4897EB68.5080309@ak.jp.nec.com>
Date: Tue, 05 Aug 2008 14:55:52 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 2/3] Thread/Child-Domain Assignment (rev.2)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>
In-Reply-To: <4897E974.2040003@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[2/3] thread-context-checkpolicy.2.patch
  It enables to support TYPEBOUNDS statement and to expand
  existing hierarchies implicitly.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 module_compiler.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++
 policy_define.c   |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 policy_define.h   |    1
 policy_parse.y    |    5 ++
 policy_scan.l     |    2 +
 5 files changed, 186 insertions(+), 1 deletion(-)

Index: checkpolicy/policy_define.c
===================================================================
--- checkpolicy/policy_define.c	(revision 2938)
+++ checkpolicy/policy_define.c	(working copy)
@@ -1127,6 +1127,77 @@
 	return 0;
 }

+static int define_typebounds_helper(char *bounds_id, char *type_id)
+{
+	type_datum_t *bounds, *type;
+
+	if (!is_id_in_scope(SYM_TYPES, bounds_id)) {
+		yyerror2("type %s is not within scope", bounds_id);
+		return -1;
+	}
+
+	bounds = hashtab_search(policydbp->p_types.table, bounds_id);
+	if (!bounds || bounds->flavor == TYPE_ATTRIB) {
+		yyerror2("hoge unknown type %s", bounds_id);
+		return -1;
+	}
+
+	if (!is_id_in_scope(SYM_TYPES, type_id)) {
+		yyerror2("type %s is not within scope", type_id);
+		return -1;
+	}
+
+	type = hashtab_search(policydbp->p_types.table, type_id);
+	if (!type || type->flavor == TYPE_ATTRIB) {
+		yyerror2("type %s is not declared", type_id);
+		return -1;
+	}
+
+	if (type->flavor == TYPE_TYPE && !type->primary) {
+		type = policydbp->type_val_to_struct[type->s.value - 1];
+	} else if (type->flavor == TYPE_ALIAS) {
+		type = policydbp->type_val_to_struct[type->primary - 1];
+	}
+
+	if (!type->bounds)
+		type->bounds = bounds->s.value;
+	else if (type->bounds != bounds->s.value) {
+		yyerror2("type %s has inconsistent master {%s,%s}",
+			 type_id,
+			 policydbp->p_type_val_to_name[type->bounds - 1],
+			 policydbp->p_type_val_to_name[bounds->s.value - 1]);
+		return -1;
+	}
+
+	return 0;
+}
+
+int define_typebounds(void)
+{
+	char *bounds, *id;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	bounds = (char *) queue_remove(id_queue);
+	if (!bounds) {
+		yyerror("no type name for typebounds definition?");
+		return -1;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		if (define_typebounds_helper(bounds, id))
+			return -1;
+		free(id);
+	}
+	free(bounds);
+
+	return 0;
+}
+
 int define_type(int alias)
 {
 	char *id;
@@ -1134,12 +1205,32 @@
 	int newattr = 0;

 	if (pass == 2) {
-		while ((id = queue_remove(id_queue)))
+		/*
+		 * If type name contains ".", we have to define boundary
+		 * relationship implicitly to keep compatibility with
+		 * old name based hierarchy.
+		 */
+		if ((id = queue_remove(id_queue))) {
+			char *bounds, *delim;
+
+			if ((delim = strrchr(id, '.'))
+			    && (bounds = strdup(id))) {
+				bounds[(size_t)(delim - id)] = '\0';
+
+				if (define_typebounds_helper(bounds, id))
+					return -1;
+				free(bounds);
+			}
 			free(id);
+		}
+
 		if (alias) {
 			while ((id = queue_remove(id_queue)))
 				free(id);
 		}
+
+		while ((id = queue_remove(id_queue)))
+			free(id);
 		return 0;
 	}

Index: checkpolicy/policy_scan.l
===================================================================
--- checkpolicy/policy_scan.l	(revision 2938)
+++ checkpolicy/policy_scan.l	(working copy)
@@ -82,6 +82,8 @@
 typealias			{ return(TYPEALIAS); }
 TYPEATTRIBUTE |
 typeattribute			{ return(TYPEATTRIBUTE); }
+TYPEBOUNDS |
+typebounds			{ return(TYPEBOUNDS); }
 TYPE |
 type				{ return(TYPE); }
 BOOL |
Index: checkpolicy/policy_define.h
===================================================================
--- checkpolicy/policy_define.h	(revision 2938)
+++ checkpolicy/policy_define.h	(working copy)
@@ -47,6 +47,7 @@
 int define_te_avtab(int which);
 int define_typealias(void);
 int define_typeattribute(void);
+int define_typebounds(void);
 int define_type(int alias);
 int define_user(void);
 int define_validatetrans(constraint_expr_t *expr);
Index: checkpolicy/policy_parse.y
===================================================================
--- checkpolicy/policy_parse.y	(revision 2938)
+++ checkpolicy/policy_parse.y	(working copy)
@@ -92,6 +92,7 @@
 %token ROLES
 %token TYPEALIAS
 %token TYPEATTRIBUTE
+%token TYPEBOUNDS
 %token TYPE
 %token TYPES
 %token ALIAS
@@ -258,6 +259,7 @@
                         | type_def
                         | typealias_def
                         | typeattribute_def
+                        | typebounds_def
                         | bool_def
                         | transition_def
                         | range_trans_def
@@ -278,6 +280,9 @@
 typeattribute_def	: TYPEATTRIBUTE identifier id_comma_list ';'
 			{if (define_typeattribute()) return -1;}
 			;
+typebounds_def          : TYPEBOUNDS identifier id_comma_list ';'
+                        {if (define_typebounds()) return -1;}
+                        ;
 opt_attr_list           : ',' id_comma_list
 			|
 			;
Index: checkpolicy/module_compiler.c
===================================================================
--- checkpolicy/module_compiler.c	(revision 2938)
+++ checkpolicy/module_compiler.c	(working copy)
@@ -163,6 +163,43 @@
 	return retval;
 }

+static int role_implicit_bounds(hashtab_t roles_tab,
+				char *role_id, role_datum_t *role)
+{
+	role_datum_t *bounds;
+	char *bounds_id, *delim;
+
+	delim = strrchr(role_id, '.');
+	if (!delim)
+		return 0;	/* no implicit boundary */
+
+	bounds_id = strdup(role_id);
+	if (!bounds_id) {
+		yyerror("out of memory");
+		return -1;
+	}
+	bounds_id[(size_t)(delim - role_id)] = '\0';
+
+	bounds = hashtab_search(roles_tab, bounds_id);
+	if (!bounds) {
+		yyerror2("role %s doesn't exist, is implicit bounds of %s",
+			 bounds_id, role_id);
+		return -1;
+	}
+
+	if (!role->bounds)
+		role->bounds = bounds->s.value;
+	else if (role->bounds != bounds->s.value) {
+		yyerror2("role %s has inconsistent bounds %s/%s",
+			 role_id, bounds_id,
+			 policydbp->p_role_val_to_name[role->bounds - 1]);
+		return -1;
+	}
+	free(bounds_id);
+
+	return 0;
+}
+
 role_datum_t *declare_role(void)
 {
 	char *id = queue_remove(id_queue), *dest_id = NULL;
@@ -217,6 +254,12 @@
 			}
 			role_datum_init(dest_role);
 			dest_role->s.value = value;
+			if (role_implicit_bounds(roles_tab, dest_id, dest_role)) {
+				free(dest_id);
+				role_datum_destroy(dest_role);
+				free(dest_role);
+				return NULL;
+			}
 			if (hashtab_insert(roles_tab, dest_id, dest_role)) {
 				yyerror("Out of memory!");
 				free(dest_id);
@@ -323,6 +366,43 @@
 	}
 }

+static int user_implicit_bounds(hashtab_t users_tab,
+				char *user_id, user_datum_t *user)
+{
+	user_datum_t *bounds;
+	char *bounds_id, *delim;
+
+	delim = strrchr(user_id, '.');
+	if (!delim)
+		return 0;	/* no implicit boundary */
+
+	bounds_id = strdup(user_id);
+	if (!bounds_id) {
+		yyerror("out of memory");
+		return -1;
+	}
+	bounds_id[(size_t)(delim - user_id)] = '\0';
+
+	bounds = hashtab_search(users_tab, bounds_id);
+	if (!bounds) {
+		yyerror2("user %s doesn't exist, is implicit bounds of %s",
+			 bounds_id, user_id);
+		return -1;
+	}
+
+	if (!user->bounds)
+		user->bounds = bounds->s.value;
+	else if (user->bounds != bounds->s.value) {
+		yyerror2("user %s has inconsistent bounds %s/%s",
+			 user_id, bounds_id,
+			 policydbp->p_role_val_to_name[user->bounds - 1]);
+		return -1;
+	}
+	free(bounds_id);
+
+	return 0;
+}
+
 user_datum_t *declare_user(void)
 {
 	char *id = queue_remove(id_queue), *dest_id = NULL;
@@ -378,6 +458,12 @@
 			}
 			user_datum_init(dest_user);
 			dest_user->s.value = value;
+			if (user_implicit_bounds(users_tab, dest_id, dest_user)) {
+				free(dest_id);
+				user_datum_destroy(dest_user);
+				free(dest_user);
+				return NULL;
+			}
 			if (hashtab_insert(users_tab, dest_id, dest_user)) {
 				yyerror("Out of memory!");
 				free(dest_id);

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
