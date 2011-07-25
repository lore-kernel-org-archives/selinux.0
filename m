Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6P1OMi9025319
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 21:24:24 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6P1OCfI009077
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 01:24:13 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v4 PATCH 1/6] Add role attribute support when compiling modules.
Date: Mon, 25 Jul 2011 09:23:54 +0800
Message-ID: <1311557039-2977-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
References: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Add a uint32_t "flavor" field and an ebitmap "roles" to the
role_datum_t structure;

2. Add a new "attribute_role" statement and its handler to declare
a role attribute;

3. Modify declare_role() to setup role_datum_t.flavor according
to the isattr argument;

4. Add a new "roleattribute" rule and its handler, which will record
the regular role's (policy value - 1) into the role attribute's
role_datum_t.roles ebitmap;

5. Modify the syntax for the role-types rule only to define the
role-type associations;

6. Add a new role-attr rule to support the declaration of a single
role, and optionally the role attribute that the role belongs to;

7. Check if the new_role used in role-transition rule is a regular role;

8. Support to require a role attribute;

9. Modify symtab_insert() to allow multiple declarations only for
the regular role, while a role attribute can't be declared more than once
and can't share a same name with another regular role.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/module_compiler.c              |   67 ++++++++++++-
 checkpolicy/module_compiler.h              |    4 +-
 checkpolicy/policy_define.c                |  152 +++++++++++++++++++++++++++-
 checkpolicy/policy_define.h                |    3 +
 checkpolicy/policy_parse.y                 |   18 +++-
 checkpolicy/policy_scan.l                  |    4 +
 libsepol/include/sepol/policydb/policydb.h |    4 +
 libsepol/src/policydb.c                    |   21 ++++
 8 files changed, 265 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 0946ff6..1c1d1d5 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -200,7 +200,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
 	return 0;
 }
 
-role_datum_t *declare_role(void)
+role_datum_t *declare_role(unsigned char isattr)
 {
 	char *id = queue_remove(id_queue), *dest_id = NULL;
 	role_datum_t *role = NULL, *dest_role = NULL;
@@ -217,7 +217,7 @@ role_datum_t *declare_role(void)
 		return NULL;
 	}
 	role_datum_init(role);
-
+	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
 	retval =
 	    declare_symbol(SYM_ROLES, id, (hashtab_datum_t *) role, &value,
 			   &value);
@@ -254,6 +254,7 @@ role_datum_t *declare_role(void)
 			}
 			role_datum_init(dest_role);
 			dest_role->s.value = value;
+			dest_role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
 			if (role_implicit_bounds(roles_tab, dest_id, dest_role)) {
 				free(dest_id);
 				role_datum_destroy(dest_role);
@@ -548,6 +549,55 @@ type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr)
 	return dest_typdatum;
 }
 
+/* Return a role_datum_t for the local avrule_decl with the given ID.
+ * If it does not exist, create one with the same value as 'value'.
+ * This function assumes that the ID is within scope.  c.f.,
+ * is_id_in_scope().
+ *
+ * NOTE: this function usurps ownership of id afterwards.  The caller
+ * shall not reference it nor free() it afterwards.
+ */
+role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr)
+{
+	role_datum_t *dest_roledatum;
+	hashtab_t roles_tab;
+
+	assert(stack_top->type == 1);
+
+	if (stack_top->parent == NULL) {
+		/* in global, so use global symbol table */
+		roles_tab = policydbp->p_roles.table;
+	} else {
+		roles_tab = stack_top->decl->p_roles.table;
+	}
+
+	dest_roledatum = hashtab_search(roles_tab, id);
+	if (!dest_roledatum) {
+		dest_roledatum = (role_datum_t *)malloc(sizeof(role_datum_t));
+		if (dest_roledatum == NULL) {
+			free(id);
+			return NULL;
+		}
+
+		role_datum_init(dest_roledatum);
+		dest_roledatum->s.value = value;
+		dest_roledatum->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
+
+		if (hashtab_insert(roles_tab, id, dest_roledatum)) {
+			free(id);
+			role_datum_destroy(dest_roledatum);
+			free(dest_roledatum);
+			return NULL;
+		}
+	} else {
+		free(id);
+		if (dest_roledatum->flavor != isattr ? ROLE_ATTRIB : ROLE_ROLE)
+			return NULL;
+	}
+	
+	return dest_roledatum;
+}
+
 /* Given the current parse stack, returns 1 if a requirement would be
  * allowed here or 0 if not.  For example, the ELSE branch may never
  * have its own requirements.
@@ -812,7 +862,7 @@ int require_class(int pass)
 	return -1;
 }
 
-int require_role(int pass)
+static int require_role_or_attribute(int pass, unsigned char isattr)
 {
 	char *id = queue_remove(id_queue);
 	role_datum_t *role = NULL;
@@ -831,6 +881,7 @@ int require_role(int pass)
 		return -1;
 	}
 	role_datum_init(role);
+	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
 	retval =
 	    require_symbol(SYM_ROLES, id, (hashtab_datum_t *) role,
 			   &role->s.value, &role->s.value);
@@ -870,6 +921,16 @@ int require_role(int pass)
 	}
 }
 
+int require_role(int pass)
+{
+	return require_role_or_attribute(pass, 0);
+}
+
+int require_attribute_role(int pass)
+{
+	return require_role_or_attribute(pass, 1);
+}
+
 static int require_type_or_attribute(int pass, unsigned char isattr)
 {
 	char *id = queue_remove(id_queue);
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
index ae33753..45a21cd 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -30,11 +30,12 @@ int declare_symbol(uint32_t symbol_type,
 		   hashtab_key_t key, hashtab_datum_t datum,
 		   uint32_t * dest_value, uint32_t * datum_value);
 
-role_datum_t *declare_role(void);
+role_datum_t *declare_role(unsigned char isattr);
 type_datum_t *declare_type(unsigned char primary, unsigned char isattr);
 user_datum_t *declare_user(void);
 
 type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr);
+role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr);
 
 /* Add a symbol to the current avrule_block's require section.  Note
  * that a module may not both declare and require the same symbol.
@@ -54,6 +55,7 @@ int require_class(int pass);
 int require_role(int pass);
 int require_type(int pass);
 int require_attribute(int pass);
+int require_attribute_role(int pass);
 int require_user(int pass);
 int require_bool(int pass);
 int require_sens(int pass);
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f75a682..92646a0 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1774,6 +1774,9 @@ int define_te_avtab(int which)
 	return 0;
 }
 
+/* The role-types rule is no longer used to declare regular role or
+ * role attribute, but solely aimed for declaring role-types associations.
+ */
 int define_role_types(void)
 {
 	role_datum_t *role;
@@ -1786,9 +1789,25 @@ int define_role_types(void)
 		return 0;
 	}
 
-	if ((role = declare_role()) == NULL) {
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no role name for role-types rule?");
+		return -1;
+	}
+
+	if (!is_id_in_scope(SYM_ROLES, id)) {
+		yyerror2("role %s is not within scope", id);
+		free(id);
+		return -1;
+	}
+
+	role = hashtab_search(policydbp->p_roles.table, id);
+	if (!role) {
+		yyerror2("unknown role %s", id);
+		free(id);
 		return -1;
 	}
+
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&role->types, id, &add, 0))
 			return -1;
@@ -1797,6 +1816,132 @@ int define_role_types(void)
 	return 0;
 }
 
+int define_attrib_role(void)
+{
+	if (pass == 2) {
+		free(queue_remove(id_queue));
+		return 0;
+	}
+
+	/* Declare a role attribute */
+	if (declare_role(TRUE) == NULL)
+		return -1;
+
+	return 0;
+}
+
+int define_role_attr(void)
+{
+	char *id;
+	role_datum_t *r, *attr;
+
+	if (pass == 2) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+	
+	/* Declare a regular role */
+	if ((r = declare_role(FALSE)) == NULL)
+		return -1;
+
+	while ((id = queue_remove(id_queue))) {
+		if (!is_id_in_scope(SYM_ROLES, id)) {
+			yyerror2("attribute %s is not within scope", id);
+			free(id);
+			return -1;
+		}
+		attr = hashtab_search(policydbp->p_roles.table, id);
+		if (!attr) {
+			/* treat it as a fatal error */
+			yyerror2("role attribute %s is not declared", id);
+			free(id);
+			return -1;
+		}
+
+		if (attr->flavor != ROLE_ATTRIB) {
+			yyerror2("%s is a regular role, not an attribute", id);
+			free(id);
+			return -1;
+		}
+
+		if ((attr = get_local_role(id, attr->s.value, 1)) == NULL) {
+			yyerror("Out of memory!");
+			return -1;
+		}
+
+		if (ebitmap_set_bit(&attr->roles, (r->s.value - 1), TRUE)) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+int define_roleattribute(void)
+{
+	char *id;
+	role_datum_t *r, *attr;
+
+	if (pass == 2) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no role name for roleattribute definition?");
+		return -1;
+	}
+
+	if (!is_id_in_scope(SYM_ROLES, id)) {
+		yyerror2("role %s is not within scope", id);
+		free(id);
+		return -1;
+	}
+	r = hashtab_search(policydbp->p_roles.table, id);
+	if (!r || r->flavor != ROLE_ROLE) {
+		yyerror2("unknown role %s, or not a regular role", id);
+		free(id);
+		return -1;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		if (!is_id_in_scope(SYM_ROLES, id)) {
+			yyerror2("attribute %s is not within scope", id);
+			free(id);
+			return -1;
+		}
+		attr = hashtab_search(policydbp->p_roles.table, id);
+		if (!attr) {
+			/* treat it as a fatal error */
+			yyerror2("role attribute %s is not declared", id);
+			free(id);
+			return -1;
+		}
+
+		if (attr->flavor != ROLE_ATTRIB) {
+			yyerror2("%s is a regular role, not an attribute", id);
+			free(id);
+			return -1;
+		}
+
+		if ((attr = get_local_role(id, attr->s.value, 1)) == NULL) {
+			yyerror("Out of memory!");
+			return -1;
+		}
+
+		if (ebitmap_set_bit(&attr->roles, (r->s.value - 1), TRUE)) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
 {
 	role_datum_t *new;
@@ -2138,6 +2283,11 @@ int define_role_trans(int class_specified)
 		goto bad;
 	}
 
+	if (role->flavor != ROLE_ROLE) {
+		yyerror2("the new role %s must be a regular role", id);
+		goto bad;
+	}
+
 	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
 	if (role_set_expand(&roles, &e_roles, policydbp, NULL))
 		goto bad;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 890a6af..fc8cd4d 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -19,6 +19,7 @@ avrule_t *define_cond_te_avtab(int which);
 avrule_t *define_cond_filename_trans(void);
 cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
 int define_attrib(void);
+int define_attrib_role(void);
 int define_av_perms(int inherits);
 int define_bool(void);
 int define_category(void);
@@ -48,6 +49,8 @@ int define_range_trans(int class_specified);
 int define_role_allow(void);
 int define_role_trans(int class_specified);
 int define_role_types(void);
+int define_role_attr(void);
+int define_roleattribute(void);
 int define_filename_trans(void);
 int define_sens(void);
 int define_te_avtab(int which);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 5305ac6..6567369 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -90,6 +90,8 @@ typedef int (* require_func_t)();
 %token INHERITS
 %token SID
 %token ROLE
+%token ROLEATTRIBUTE
+%token ATTRIBUTE_ROLE
 %token ROLES
 %token TYPEALIAS
 %token TYPEATTRIBUTE
@@ -253,10 +255,13 @@ te_rbac_decl		: te_decl
 			| policycap_def
 			| ';'
                         ;
-rbac_decl		: role_type_def
+rbac_decl		: attribute_role_def
+			| role_type_def
                         | role_dominance
                         | role_trans_def
  			| role_allow_def
+			| roleattribute_def
+			| role_attr_def
 			;
 te_decl			: attribute_def
                         | type_def
@@ -417,10 +422,13 @@ dontaudit_def		: DONTAUDIT names names ':' names names ';'
 neverallow_def		: NEVERALLOW names names ':' names names  ';'
 			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
 		        ;
+attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
+			{if (define_attrib_role()) return -1; }
 role_type_def		: ROLE identifier TYPES names ';'
 			{if (define_role_types()) return -1;}
- 			| ROLE identifier';'
- 			{if (define_role_types()) return -1;}
+			;
+role_attr_def		: ROLE identifier opt_attr_list ';'
+ 			{if (define_role_attr()) return -1;}
                         ;
 role_dominance		: DOMINANCE '{' roles '}'
 			;
@@ -442,6 +450,9 @@ role_def		: ROLE identifier_push ';'
 			| ROLE identifier_push '{' roles '}'
                         {$$ = define_role_dom((role_datum_t*)$4); if ($$ == 0) return -1;}
 			;
+roleattribute_def	: ROLEATTRIBUTE identifier id_comma_list ';'
+			{if (define_roleattribute()) return -1;}
+			;
 opt_constraints         : constraints
                         |
                         ;
@@ -803,6 +814,7 @@ require_class           : CLASS identifier names
 require_decl_def        : ROLE        { $$ = require_role; }
                         | TYPE        { $$ = require_type; }
                         | ATTRIBUTE   { $$ = require_attribute; }
+                        | ATTRIBUTE_ROLE   { $$ = require_attribute_role; }
                         | USER        { $$ = require_user; }
                         | BOOL        { $$ = require_bool; }
                         | SENSITIVITY { $$ = require_sens; }
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 1e7e567..8abc4d9 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -76,6 +76,10 @@ ROLE |
 role				{ return(ROLE); }
 ROLES |
 roles				{ return(ROLES); }
+ROLEATTRIBUTE |
+roleattribute			{ return(ROLEATTRIBUTE);}
+ATTRIBUTE_ROLE |
+attribute_role			{ return(ATTRIBUTE_ROLE);}
 TYPES |
 types				{ return(TYPES); }
 TYPEALIAS |
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index eebf1a9..b59ab2e 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -120,6 +120,10 @@ typedef struct role_datum {
 	type_set_t types;	/* set of authorized types for role */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
 	uint32_t bounds;	/* bounds role, if exist */
+#define ROLE_ROLE 0		/* regular role in kernel policies */
+#define ROLE_ATTRIB 1		/* attribute */
+	uint32_t flavor;
+	ebitmap_t roles;	/* roles with this attribute */
 } role_datum_t;
 
 typedef struct role_trans {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6d8ff91..eb6d590 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -350,6 +350,7 @@ void role_datum_init(role_datum_t * x)
 	ebitmap_init(&x->dominates);
 	type_set_init(&x->types);
 	ebitmap_init(&x->cache);
+	ebitmap_init(&x->roles);
 }
 
 void role_datum_destroy(role_datum_t * x)
@@ -358,6 +359,7 @@ void role_datum_destroy(role_datum_t * x)
 		ebitmap_destroy(&x->dominates);
 		type_set_destroy(&x->types);
 		ebitmap_destroy(&x->cache);
+		ebitmap_destroy(&x->roles);
 	}
 }
 
@@ -1429,6 +1431,25 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 		if (sym != SYM_ROLES && sym != SYM_USERS) {
 			return -2;
 		}
+		/* Further confine that a role attribute can't have the same
+		 * name as another regular role, and a role attribute can't
+		 * be declared more than once. */
+		if (sym == SYM_ROLES) {
+			role_datum_t *base_role;
+			role_datum_t *cur_role = (role_datum_t *)datum;
+		
+			base_role = (role_datum_t *)
+					hashtab_search(pol->symtab[sym].table,
+						       key);
+			assert(base_role != NULL);
+
+			if (!((base_role->flavor == ROLE_ROLE) &&
+			    (cur_role->flavor == ROLE_ROLE))) {
+				/* Only regular roles are allowed to have
+				 * multiple declarations. */
+				return -2;
+			}
+		}
 	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
 		scope_datum->scope = SCOPE_DECL;
 	} else if (scope_datum->scope != scope) {
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
