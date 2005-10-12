Subject: [PATCH] require in conditional
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-UZsoA8ibMcQyARNMWjCm"
Date: Wed, 12 Oct 2005 10:50:14 -0400
Message-Id: <1129128614.3504.13.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UZsoA8ibMcQyARNMWjCm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes the parser to allow require blocks inside
conditionals . This is necessary for reference policy because interfaces
always add their dependencies in require blocks but won't know they are
in a conditional. For example:

if (allow_ptrace) {
	domain_ptrace_all_domains(sysadm_t)
}

will expand to:
if (allow_ptrace) {
	require {
		attribute domain;
	}
	allow $1 domain:process ptrace;
}

which isn't currently allowed.

This patch adds the symbols in the require block to the current scope,
conditionals do not have a separate scope. This means that something
required inside a conditional will be required for its scope to be
enabled. For example:

optional {
	require {
		type foo_t;
	}

	if (allow_ptrace) {
		require {
			attribute domain; 
		}
	allow foo_t domain: process ptrace;
	}
}

In this example both the type foo_t and the attribute domain will be
require for the optional to be enabled.

--=-UZsoA8ibMcQyARNMWjCm
Content-Disposition: attachment; filename=1-require-in-cond.patch
Content-Type: text/x-patch; name=1-require-in-cond.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-10-11 13:49:45.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-10-11 14:39:00.000000000 -0400
@@ -458,7 +458,8 @@ type_datum_t *get_local_type(char *id, u
  * have its own requirements.
  */
 static int is_require_allowed(void) {
-        if (stack_top->type == 1 &&
+        if (policydbp->policy_type == POLICY_MOD &&
+	    stack_top->type == 1 &&
             !stack_top->in_else) {
                 return 1;
         }
diff -purN -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-10-11 13:49:45.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-10-11 14:39:00.000000000 -0400
@@ -135,7 +135,7 @@ typedef int (* require_func_t)();
         require_func_t require_func;
 }
 
-%type <ptr> cond_expr cond_expr_prim cond_pol_list
+%type <ptr> cond_expr cond_expr_prim cond_pol_list cond_else
 %type <ptr> cond_allow_def cond_auditallow_def cond_auditdeny_def cond_dontaudit_def
 %type <ptr> cond_transition_def cond_te_avtab_def cond_rule_def
 %type <ptr> role_def roles
@@ -347,19 +347,13 @@ bool_val                : CTRUE
                         | CFALSE
 			{ if (insert_id("F",0)) return -1; }
                         ;
-cond_stmt_def           : IF cond_expr '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*) 0) < 0) return -1;  }}
-                        | IF cond_expr '{' cond_pol_list '}' ELSE '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*)$4,(avrule_t*)$8) < 0 ) return -1;  }}       
-                        | IF cond_expr '{' cond_pol_list '}' ELSE '{' '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*)$4,(avrule_t*) 0) < 0 ) return -1;  }}       
-                        | IF cond_expr '{' '}' ELSE '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*) 0,(avrule_t*) $7) < 0 ) return -1;  }}       
-                        | IF cond_expr '{' '}' ELSE '{' '}'
-                        /* do nothing */
-                        | IF cond_expr '{' '}' 
-                        /* do nothing */
+cond_stmt_def           : IF cond_expr '{' cond_pol_list '}' cond_else
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*)$6) < 0) return -1;  }}
                         ;
+cond_else		: ELSE '{' cond_pol_list '}'
+			{ $$ = $3; }
+			| /* empty */ 
+			{ $$ = NULL; }
 cond_expr               : '(' cond_expr ')'
 			{ $$ = $2;}
 			| NOT cond_expr
@@ -387,15 +381,17 @@ cond_expr_prim          : identifier
                         { $$ = define_cond_expr(COND_BOOL,0, 0);
 			  if ($$ == COND_ERR) return   -1; }
                         ;
-cond_pol_list           : cond_rule_def
-                        { $$ = define_cond_pol_list((avrule_t *) 0, (avrule_t *)$1);}
-                        | cond_pol_list cond_rule_def 
+cond_pol_list           : cond_pol_list cond_rule_def 
                         { $$ = define_cond_pol_list((avrule_t *)$1, (avrule_t *)$2); }
+			| /* empty */ 
+			{ $$ = NULL; }
 			;
 cond_rule_def           : cond_transition_def
                         { $$ = $1; }
                         | cond_te_avtab_def
                         { $$ = $1; }
+			| require_block
+			{ $$ = NULL; }
                         ;
 cond_transition_def	: TYPE_TRANSITION names names ':' names identifier ';'
                         { $$ = define_cond_compute_type(AVRULE_TRANSITION) ;
@@ -2217,6 +2213,11 @@ static avrule_t *define_cond_pol_list(av
 		return (avrule_t *)1;
 	}
 
+	if (sl == NULL) {
+		/* This is a require block, return previous list */
+		return avlist;
+	}
+
         /* prepend the new avlist to the pre-existing one */
         sl->next = avlist;
         return sl;
@@ -3261,8 +3262,9 @@ static int define_conditional(cond_expr_
 	}
 	if (!t) {
 		if (!f) {
-			yyerror("must have at least one rule");
-			return -1;
+			/* empty is fine, destroy expression and return */
+			cond_expr_destroy(expr);
+			return 0;
 		}
 		/* Invert */
 		t = f;
diff -purN -x .svn libsepol/include/sepol/policydb/conditional.h libsepol/include/sepol/policydb/conditional.h
--- libsepol/include/sepol/policydb/conditional.h	2005-10-11 13:51:45.000000000 -0400
+++ libsepol/include/sepol/policydb/conditional.h	2005-10-11 15:47:38.000000000 -0400
@@ -93,6 +93,7 @@ extern cond_expr_t *cond_copy_expr(cond_
 
 extern int cond_normalize_expr(policydb_t *p, cond_node_t *cn);
 extern void cond_node_destroy(cond_node_t *node);
+extern void cond_expr_destroy(cond_expr_t *expr);
 
 extern cond_node_t *cond_node_find(
 	policydb_t *p, 
diff -purN -x .svn libsepol/src/conditional.c libsepol/src/conditional.c
--- libsepol/src/conditional.c	2005-10-11 13:53:47.000000000 -0400
+++ libsepol/src/conditional.c	2005-10-11 14:38:59.000000000 -0400
@@ -440,17 +440,24 @@ void cond_av_list_destroy(cond_av_list_t
 	}
 }
 
-void cond_node_destroy(cond_node_t *node)
-{
+void cond_expr_destroy(cond_expr_t *expr) {
 	cond_expr_t *cur_expr, *next_expr;
 
-	if (!node)
+	if (!expr)
 		return;
 
-	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = next_expr) {
+	for (cur_expr = expr; cur_expr != NULL; cur_expr = next_expr) {
 		next_expr = cur_expr->next;
 		free(cur_expr);
 	}
+}
+
+void cond_node_destroy(cond_node_t *node)
+{
+	if (!node)
+		return;
+
+	cond_expr_destroy(node->expr);
         avrule_list_destroy(node->avtrue_list);
         avrule_list_destroy(node->avfalse_list);
 	cond_av_list_destroy(node->true_list);

--=-UZsoA8ibMcQyARNMWjCm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
