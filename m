Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MKj7Wt005993
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 16:45:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9MKj6IE009962
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 20:45:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9MKj61J009959 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 20:45:06 GMT
Subject: Re: [PATCH] checkpolicy/policy_scan.y
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031022190241.GA4671@hydra.joerghoh.de>
References: <20031022175608.GB4531@hydra.joerghoh.de>
	 <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022190241.GA4671@hydra.joerghoh.de>
Content-Type: multipart/mixed; boundary="=-qyyXoKPK4FC7NsId9HcO"
Message-Id: <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 16:44:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qyyXoKPK4FC7NsId9HcO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Below is a modified form of your patch that seeks to preserve the
distinction between val and ptr and introduces a valptr for the
uintptr_t case.  Let me know if you see warnings with this patch that
you do not see with your patch.  Note that with either patch, warnings
will still occur on 64bit unless you have also patched your constraint.h
to use uintptr_t for the fields of the constraint_expr structure, but
that is not acceptable as it changes the binary policy format (or it
would, if the write.c code were also adjusted correspondingly, and it
serves no purpose otherwise). 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-qyyXoKPK4FC7NsId9HcO
Content-Disposition: attachment; filename=parse.patch
Content-Type: text/x-patch; name=parse.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.5
diff -u -r1.5 policy_parse.y
--- checkpolicy/policy_parse.y	26 Jun 2003 17:23:12 -0000	1.5
+++ checkpolicy/policy_parse.y	22 Oct 2003 20:02:25 -0000
@@ -10,6 +10,7 @@
 #include "services.h"
 #include "queue.h"
 #include "checkpolicy.h"
+#include <stdint.h>
 
 #define TRUE 1
 #define FALSE 0
@@ -48,25 +49,27 @@
 static int define_role_trans(void);
 static int define_role_allow(void);
 static int define_constraint(constraint_expr_t *expr);
-static constraint_expr_t *define_cexpr(__u32 expr_type, void *arg1, void* arg2);
+static uintptr_t define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2);
 static int define_user(void);
 static int parse_security_context(context_struct_t *c);
 static int define_initial_sid_context(void);
 static int define_fs_use(int behavior);
 static int define_genfs_context(int has_type);
-static int define_fs_context(int major, int minor);
-static int define_port_context(int low, int high);
+static int define_fs_context(unsigned int major, unsigned int minor);
+static int define_port_context(unsigned int low, unsigned int high);
 static int define_netif_context(void);
-static int define_node_context(int addr, int mask);
+static int define_node_context(unsigned int addr, unsigned int mask);
 %}
 
 %union {
-	int val;
+	unsigned int val;
+	uintptr_t valptr;
 	void *ptr;
 }
 
-%type <ptr> role_def roles cexpr cexpr_prim op roleop
-%type <val> ipv4_addr_def number
+%type <ptr> role_def roles
+%type <valptr> cexpr cexpr_prim 
+%type <val> ipv4_addr_def number op roleop
 
 %token PATH
 %token CLONE
@@ -322,64 +325,64 @@
 			{ $$ = $1; }
 			;
 cexpr_prim		: U1 op U2
-			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_USER, $2);
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, $2);
 			  if ($$ == 0) return -1; }
 			| R1 roleop R2
-			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_ROLE, $2);
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
 			  if ($$ == 0) return -1; }
 			| T1 op T2
-			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_TYPE, $2);
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
 			  if ($$ == 0) return -1; }
 			| U1 op { if (insert_separator(1)) return -1; } user_names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_USER, $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
 			  if ($$ == 0) return -1; }
 			| U2 op { if (insert_separator(1)) return -1; } user_names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_USER | CEXPR_TARGET), $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
 			  if ($$ == 0) return -1; }
 			| R1 op { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_ROLE, $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, $2);
 			  if ($$ == 0) return -1; }
 			| R2 op { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_ROLE | CEXPR_TARGET), $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), $2);
 			  if ($$ == 0) return -1; }
 			| T1 op { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_TYPE, $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, $2);
 			  if ($$ == 0) return -1; }
 			| T2 op { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_TYPE | CEXPR_TARGET), $2);
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), $2);
 			  if ($$ == 0) return -1; }
 			| SAMEUSER
-			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_USER, (void*)CEXPR_EQ);
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, CEXPR_EQ);
 			  if ($$ == 0) return -1; }
 			| SOURCE ROLE { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_ROLE, (void*)CEXPR_EQ);
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, CEXPR_EQ);
 			  if ($$ == 0) return -1; }
 			| TARGET ROLE { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_ROLE | CEXPR_TARGET), (void*)CEXPR_EQ);
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), CEXPR_EQ);
 			  if ($$ == 0) return -1; }
 			| ROLE roleop
-			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_ROLE, (void*)$2);
+			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
 			  if ($$ == 0) return -1; }
 			| SOURCE TYPE { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_TYPE, (void*)CEXPR_EQ);
+			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, CEXPR_EQ);
 			  if ($$ == 0) return -1; }
 			| TARGET TYPE { if (insert_separator(1)) return -1; } names_push
-			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_TYPE | CEXPR_TARGET), (void*)CEXPR_EQ);
+			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), CEXPR_EQ);
 			  if ($$ == 0) return -1; }
 			;
 op			: EQUALS
-			{ $$ = (void*)CEXPR_EQ; }
+			{ $$ = CEXPR_EQ; }
 			| NOTEQUAL
-			{ $$ = (void*)CEXPR_NEQ; }
+			{ $$ = CEXPR_NEQ; }
 			;
 roleop			: op 
 			{ $$ = $1; }
 			| DOM
-			{ $$ = (void*)CEXPR_DOM; }
+			{ $$ = CEXPR_DOM; }
 			| DOMBY
-			{ $$ = (void*)CEXPR_DOMBY; }
+			{ $$ = CEXPR_DOMBY; }
 			| INCOMP
-			{ $$ = (void*)CEXPR_INCOMP; }
+			{ $$ = CEXPR_INCOMP; }
 			;
 users			: user_def
 			| users user_def
@@ -1659,7 +1662,7 @@
 		     char *id)
 {
 	type_datum_t *t;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all types */
@@ -1715,7 +1718,8 @@
 	class_datum_t *cladatum;
 	ebitmap_t stypes, ttypes, tclasses;
 	__u32 newtype = 0;
-	int ret, i, j, k;
+	int ret;
+	unsigned int i, j, k;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -1864,7 +1868,8 @@
 	static char avbuf[1024];
 	class_datum_t *cladatum;
 	char *perm = NULL, *p;
-	int i, rc;
+	unsigned int i;
+	int rc;
 
 	cladatum = policydbp->class_val_to_struct[tclass-1];
 	p = avbuf;
@@ -1891,13 +1896,14 @@
 }
 
 
-static int te_avtab_helper(int which, int stype, int ttype, 
+static int te_avtab_helper(int which, unsigned int stype, unsigned int ttype, 
 			   ebitmap_t *tclasses, access_vector_t *avp)
 
 {
 	avtab_key_t avkey;
 	avtab_datum_t avdatum, *avdatump;
-	int ret, k;
+	int ret;
+	unsigned int k;
 
 	if (which == -AVTAB_ALLOWED) {
 		yyerror("neverallow should not reach this function.");
@@ -1958,7 +1964,8 @@
 	perm_datum_t *perdatum;
 	ebitmap_t stypes, ttypes, tclasses;
 	access_vector_t *avp;
-	int i, j, hiclass, self = 0;
+	unsigned int i, j, hiclass;
+	int self = 0;
 	te_assert_t *newassert;
 
 	if (pass == 1) {
@@ -2021,7 +2028,7 @@
 
 			if (strcmp(id, "*") == 0) {
 				/* set all permissions in the class */
-				avp[i] = ~0;
+				avp[i] = ~0UL;
 				continue;
 			}
 
@@ -2219,7 +2226,8 @@
 {
 	role_datum_t *role;
 	char *role_id;
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	if (pass == 1) {
 		role_id = queue_remove(id_queue);
@@ -2274,7 +2282,7 @@
 		     char *id)
 {
 	role_datum_t *r;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
@@ -2317,7 +2325,7 @@
 	role_datum_t *role;
 	ebitmap_t roles, types;
 	struct role_trans *tr = 0;
-	int i, j;
+	unsigned int i, j;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2398,7 +2406,7 @@
 	char *id;
 	ebitmap_t roles, new_roles;
 	struct role_allow *ra = 0;
-	int i, j;
+	unsigned int i, j;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2462,7 +2470,8 @@
 	perm_datum_t *perdatum;
 	ebitmap_t classmap;
 	constraint_expr_t *e;
-	int i, depth;
+	unsigned int i;
+	int depth;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2572,8 +2581,8 @@
 }
 
 
-static constraint_expr_t *
- define_cexpr(__u32 expr_type, void* arg1, void* arg2)
+static uintptr_t
+ define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2)
 {
 	struct constraint_expr *expr, *e1 = NULL, *e2;
 	user_datum_t *user;
@@ -2586,13 +2595,13 @@
 			while ((id = queue_remove(id_queue))) 
 				free(id);
 		}
-		return (constraint_expr_t *)1; /* any non-NULL value */
+		return 1; /* any non-NULL value */
 	}
 
 	expr = malloc(sizeof(struct constraint_expr));
 	if (!expr) {
 		yyerror("out of memory");
-		return NULL;
+		return 0;
 	}
 	memset(expr, 0, sizeof(constraint_expr_t));
 	expr->expr_type = expr_type;
@@ -2608,10 +2617,10 @@
 		if (!e1 || e1->next) {
 			yyerror("illegal constraint expression");
 			free(expr);
-			return NULL;
+			return 0;
 		}
 		e1->next = expr;
-		return (struct constraint_expr *) arg1;
+		return arg1;
 	case CEXPR_AND:
 	case CEXPR_OR:
 		e1 = NULL;
@@ -2623,7 +2632,7 @@
 		if (!e1 || e1->next) {
 			yyerror("illegal constraint expression");
 			free(expr);
-			return NULL;
+			return 0;
 		}
 		e1->next = (struct constraint_expr *) arg2;
 
@@ -2636,17 +2645,17 @@
 		if (!e1 || e1->next) {
 			yyerror("illegal constraint expression");
 			free(expr);
-			return NULL;
+			return 0;
 		}
 		e1->next = expr;
-		return (struct constraint_expr *) arg1;
+		return arg1;
 	case CEXPR_ATTR:
-		expr->attr = (__u32)arg1;
-		expr->op = (__u32)arg2;
-		return expr;
+		expr->attr = arg1;
+		expr->op = arg2;
+		return (uintptr_t)expr;
 	case CEXPR_NAMES:
-		expr->attr = (__u32)arg1;
-		expr->op = (__u32)arg2;
+		expr->attr = arg1;
+		expr->op = arg2;
 		while ((id = (char *) queue_remove(id_queue))) {
 			if (expr->attr & CEXPR_USER) {
 				user = (user_datum_t *) hashtab_search(policydbp->p_users.table,
@@ -2655,7 +2664,7 @@
 					sprintf(errormsg, "unknown user %s", id);
 					yyerror(errormsg);
 					free(expr);
-					return NULL;
+					return 0;
 				}
 				val = user->value;
 			} else if (expr->attr & CEXPR_ROLE) {
@@ -2665,38 +2674,38 @@
 					sprintf(errormsg, "unknown role %s", id);
 					yyerror(errormsg);
 					free(expr);
-					return NULL;
+					return 0;
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
 				if (set_types(&expr->names, id)) {
 					free(expr);
-					return NULL;
+					return 0;
 				}
 				continue;
 			} else {
 				yyerror("invalid constraint expression");
 				free(expr);
-				return NULL;
+				return 0;
 			}
 			if (ebitmap_set_bit(&expr->names, val - 1, TRUE)) {
 				yyerror("out of memory");
 				ebitmap_destroy(&expr->names);
 				free(expr);
-				return NULL;
+				return 0;
 			}
 			free(id);
 		}
-		return expr;
+		return (uintptr_t)expr;
 	default:
 		yyerror("invalid constraint expression");
 		free(expr);
-		return NULL;
+		return 0;
 	}
 
 	yyerror("invalid constraint expression");
 	free(expr);
-	return NULL;
+	return 0;
 }
 
 
@@ -2704,7 +2713,7 @@
 			  char *id)
 {
 	role_datum_t *r;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
@@ -3137,7 +3146,7 @@
 	return 0;
 }
 
-static int define_fs_context(int major, int minor)
+static int define_fs_context(unsigned int major, unsigned int minor)
 {
 	ocontext_t *newc, *c, *head;
 
@@ -3193,7 +3202,7 @@
 	return 0;
 }
 
-static int define_port_context(int low, int high)
+static int define_port_context(unsigned int low, unsigned int high)
 {
 	ocontext_t *newc;
 	char *id;
@@ -3292,7 +3301,7 @@
 	return 0;
 }
 
-static int define_node_context(int addr, int mask)
+static int define_node_context(unsigned int addr, unsigned int mask)
 {
 	ocontext_t *newc, *c, *l, *head;
 

--=-qyyXoKPK4FC7NsId9HcO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
