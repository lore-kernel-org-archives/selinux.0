Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34GGMDo001386
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 12:16:22 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j34GBbis024119
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 16:11:38 GMT
Received: from twoface.columbia.tresys.com (twoface.columbia.tresys.com [10.1.13.32] (may be forged))
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j34GEL8R026427
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 12:14:21 -0400
Subject: policy hierarchy patch
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-LBD90bktVHComaKskBQC"
Date: Mon, 04 Apr 2005 12:14:42 -0400
Message-Id: <1112631282.19526.18.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LBD90bktVHComaKskBQC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch implements hierarchical types and roles in the current CVS
compiler. More information is available in selinux-doc/README.HIERARCHY,
which is included below.

Joshua Brindle


1. Overview

The hierarchical extensions introduce two new concepts into the SELinux policy 
language. The first is the addition of hierarchy into some symbol namespaces, 
allowing, currently, the creation of types and roles with a parent/child 
relationship to other types or roles. This is done through the introduction of 
the "." operator into the language. The second important concept is the addition 
of implicit constraints based on the hierarchy. The specific semantics of the 
constraints are defined on a per-namespace basis, but in general a child element 
will no more access than its parent.

This extension is meant to ease the creation of policies and introduction a way 
to conceptualize polices that focuses on important security properties. This is 
partially inspired by the SEFramework project. More information on SEFramework 
can be found at http://www.selinux-symposium.org/2005/presentations/session6/6-
1-wilson.pdf. Additionally, this extension is intended to make it possible to
implement access control on the policy. More information on this work can be
found at http://www.selinux-symposium.org/2005/presentations/session3/3-2-macmillan.pdf.

2. Defining Hierarchical Symbols

Hierarchical symbols are defined through the "." operator.  This operator is 
currently valid in the type and role namespaces, but may be introduced in other 
namespaces in the future. For example, consider the following type declarations:

	type apache;
	type apache.cgi;

In this example, the type apache.cgi is a child of apache. A symbol can be both 
a normal symbol and container for other symbols. The addition of hierarchy does 
not otherwise change the syntax of the symbol declarations. It is possible, for 
example, to include attributes and aliases in the declaration of types that 
include hierarchy. The hierarchy can be of arbitrary depth, for example:

	role admins;
	role admins.junior;
	role admins.junior.useradd;

The hierarchy should not be confused with inheritance: children do not inherit 
any access from parents. Like all of the other policy statements, access must be 
explicitly granted.

3. Hierarchical Constraints

Each namespace has specific implicit constraints based on the hierarchy. The 
details of the constraints are different for different namespaces, but the 
general goal is the same: children are constrained to no more access than their 
parents. Again, no access is inherited from parents, only constraints. The 
constraints are defined only by the immediate parent. For example, given the 
following types:

	type apache;
	type apache.cgi;
	type apache.cgi.user;

The type apache.cgi must have equal or less access that apache. If apache.cgi 
has a subset of the access of apache, then apache.cgi.user must be constrained 
to no more than that subset. The type apache.cgi.user cannot be granted access 
that apache.cgi does not have even if apache has that access.

The constraints are not order dependent; the constraints are checked after the 
entire policy has been loaded, so the sum of all access for each symbol is 
considered.

3.1 Type Constraints

Types are constrained based on both explicit access granted through allow rules 
and indirectly based on attributes. This means that a child type can have no 
more attributes than its parent. Audit rules and type transition rules are not 
currently constrained. Take the following example:

	type apache, domain, privlog;
	type apache.cgi, domain, privlog;
	type apache.cgi.user, domain;

	type afile, file_type;

	allow apache afile : file { read write getattr setattr }
	allow apache.cgi afile : file { read getattr };
	allow apache.cgi.user afile : file { read write getattr }

In this example, the hierarchical constraints are satisfied for apache, because 
it has no parent, and apache.cgi, because its access is a subset of its parent. 
The hierarchical constraints are violated for apache.cgi.user, however, because 
it has the permission write that apache.cgi does not.

The hierarchical constraints for types are complicated by conditional 
expressions. A conditional policy can be viewed as a set of N policies, with N 
being the number of unique combinations of boolean settings. The implicit 
constraints, in this model, should be checked for each of the N policies. This 
is both complex programmatically and computationally. The current implementation 
comprises and defines the implicit constrains in a way that is simpler to check, 
but slightly more restrictive. In the current implementation the implicit 
constraints for a child are defined as access granted to the parent that is 
either unconditional or defined in the current conditional expression. For 
example:

	type foo;
	type foo.bar;
	type etc_file;
	bool baz true;
---
VALID:

	allow foo etc_file : file { read write append };
	
	if(baz) {
		allow foo.bar etc_file : file { read write };
	}
---

VALID:  

	if (baz) {
	 	allow foo etc_file : file { read write append };
	 	allow foo.bar etc_file : file { read write append };
	}
---

INVALID:

	if (baz) {
	  	allow foo etc_file : file { read write append };
	} else {
	  	allow foo.bar etc_file : file { read write };
	}
---

INVALID:

	allow foo.bar etc_file : file { read write };
	
	if (baz) {
	  	allow foo etc_file : file { read write append };
	}

3.2 Role Constraints

The role constraint simply says that any child role must have the same or fewer 
types associated with it. For example:

	role user types { foo_t bar_t baz_t  };
	role user.guest types foo_t;

The following, however, is not valid:

	role user types foo_t;
	role user.guest types { foo_t bar_t };



--=-LBD90bktVHComaKskBQC
Content-Disposition: attachment; filename=hierarchy-backport.diff
Content-Type: text/x-patch; name=hierarchy-backport.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

diff -urN -xpolicy -xCVS nsa/selinux-usr/checkpolicy/Makefile new/checkpolicy/Makefile
--- nsa/selinux-usr/checkpolicy/Makefile	2005-02-17 10:45:12.000000000 -0500
+++ new/checkpolicy/Makefile	2005-04-04 10:39:10.238390400 -0400
@@ -5,11 +5,12 @@
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
+INCLUDEDIR ?= ${PREFIX}/include
 TARGETS = checkpolicy 
 
 CFLAGS = -g -Wall -O2 -pipe
 
-override CFLAGS += -I.
+override CFLAGS += -I. -I${INCLUDEDIR}
 
 OBJS += y.tab.o lex.yy.o queue.o checkpolicy.o
 
diff -urN -xpolicy -xCVS nsa/selinux-usr/checkpolicy/checkpolicy.c new/checkpolicy/checkpolicy.c
--- nsa/selinux-usr/checkpolicy/checkpolicy.c	2005-01-26 15:08:56.000000000 -0500
+++ new/checkpolicy/checkpolicy.c	2005-04-04 10:39:10.200396176 -0400
@@ -67,6 +67,7 @@
 #include <sepol/policydb.h>
 #include <sepol/services.h>
 #include <sepol/conditional.h>
+#include <sepol/hierarchy.h>
 #include <sepol/flask.h>
 
 #include "queue.h"
@@ -449,7 +450,7 @@
 	security_context_t scontext;
 	struct av_decision avd;
 	class_datum_t *cladatum;
-	char ans[80 + 1], *file = txtfile, *outfile = NULL, *path, *fstype;
+	char ans[80 + 1], *file = txtfile, *outfile = NULL, *path, *fstype, error_msg[ERRMSG_LEN];
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
@@ -617,10 +618,16 @@
 			fprintf(stderr, "%s:  policy lacks new netlink classes, unable to generate policy version %d\n", argv[0], policyvers);
 			exit(1);
 		}
-	    
+
+		if (hierarchy_check_constraints(&policydb, error_msg, sizeof(error_msg))) {
+			fprintf(stderr, "%s\n", error_msg);
+			exit(1);
+		}
+
 		/* remove type attributes */
 		hashtab_map_remove_on_error(policydb.p_types.table, 
 					    type_attr_remove, 0, 0);
+		
 		fclose(yyin);
 	}
 
diff -urN -xpolicy -xCVS nsa/selinux-usr/checkpolicy/policy_parse.y new/checkpolicy/policy_parse.y
--- nsa/selinux-usr/checkpolicy/policy_parse.y	2005-02-17 10:45:13.000000000 -0500
+++ new/checkpolicy/policy_parse.y	2005-04-04 10:39:10.847297832 -0400
@@ -27,11 +27,13 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <stdlib.h>
 
 #include <sepol/policydb.h>
 #include <sepol/services.h>
 #include <sepol/conditional.h>
 #include <sepol/flask.h>
+#include <sepol/hierarchy.h>
 #include "queue.h"
 #include "checkpolicy.h"
 
@@ -55,6 +57,7 @@
 extern unsigned long policydb_lineno;
 
 extern char yytext[];
+extern int yylex(void);
 extern int yywarn(char *msg);
 extern int yyerror(char *msg);
 
@@ -62,6 +65,7 @@
 
 static int insert_separator(int push);
 static int insert_id(char *id,int push);
+static int id_has_dot(char *id);
 static int define_class(void);
 static int define_initial_sid(void);
 static int define_common_perms(void);
@@ -166,7 +170,7 @@
 %token NOT AND OR XOR
 %token CTRUE CFALSE
 %token IDENTIFIER
-%token USER_IDENTIFIER
+%token MLS_IDENTIFIER
 %token NUMBER
 %token EQUALS
 %token NOTEQUAL
@@ -493,13 +497,13 @@
 			| T1 op T2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
 			  if ($$ == 0) return -1; }
-			| U1 op { if (insert_separator(1)) return -1; } user_names_push
+			| U1 op { if (insert_separator(1)) return -1; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
 			  if ($$ == 0) return -1; }
-			| U2 op { if (insert_separator(1)) return -1; } user_names_push
+			| U2 op { if (insert_separator(1)) return -1; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
 			  if ($$ == 0) return -1; }
-			| U3 op { if (insert_separator(1)) return -1; } user_names_push
+			| U3 op { if (insert_separator(1)) return -1; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_XTARGET), $2);
 			  if ($$ == 0) return -1; }
 			| R1 op { if (insert_separator(1)) return -1; } names_push
@@ -575,7 +579,6 @@
 			| users user_def
 			;
 user_id			: identifier
-			| user_identifier
 			;
 user_def		: USER user_id ROLES names opt_mls_user ';'
 	                {if (define_user()) return -1;}
@@ -676,16 +679,16 @@
 	                | mls_level_def
 			{if (insert_separator(0)) return -1;}
 	                ;
-mls_level_def		: identifier ':' cat_comma_list
+mls_level_def		: mls_identifier ':' cat_comma_list
 			{if (insert_separator(0)) return -1;}
-	                | identifier 
+	                | mls_identifier 
 			{if (insert_separator(0)) return -1;}
 	                ;
 cat_comma_list		: cat_range
 			| cat_comma_list ',' cat_range
 			;
-cat_range		: identifier
-			| identifier '.' identifier
+cat_range		: mls_identifier
+			| mls_identifier '.' mls_identifier
 			{ if (insert_id("MLS_CAT_RANGE",0)) return -1; }
 			;
 id_comma_list           : identifier
@@ -741,23 +744,12 @@
 identifier		: IDENTIFIER
 			{ if (insert_id(yytext,0)) return -1; }
 			;
-user_identifier		: USER_IDENTIFIER
+mls_identifier		: MLS_IDENTIFIER
 			{ if (insert_id(yytext,0)) return -1; }
 			;
-user_identifier_push	: USER_IDENTIFIER
+mls_identifier_push	: MLS_IDENTIFIER
 			{ if (insert_id(yytext, 1)) return -1; }
 			;
-user_identifier_list_push : user_identifier_push
-			| identifier_list_push user_identifier_push
-			| user_identifier_list_push identifier_push
-			| user_identifier_list_push user_identifier_push
-			;
-user_names_push		: names_push
-			| user_identifier_push
-			| '{' user_identifier_list_push '}'
-			| tilde_push user_identifier_push
-			| tilde_push '{' user_identifier_list_push '}'
-			;
 path     		: PATH
 			{ if (insert_id(yytext,0)) return -1; }
 			;
@@ -810,6 +802,14 @@
 	return 0;
 }
 
+/* If the identifier has a dot within it return 1, else return 0. */
+static int id_has_dot(char *id)
+{
+        if (strchr(id, '.') >= id + 1) {
+                return 1;
+        }
+        return 0;
+}
 
 static int define_class(void)
 {
@@ -829,6 +829,11 @@
 		yyerror("no class name for class definition?");
 		return -1;
 	}
+        if (id_has_dot(id)) {
+                free(id);
+                yyerror("class identifiers may not contain periods");
+                return -1;
+        }
 	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
@@ -1515,8 +1520,14 @@
 	}
 
 	while ((id = queue_remove(id_queue))) {
+                if (id_has_dot(id)) {
+                        free(id);
+                        yyerror("type alias identifiers may not contain periods");
+                        return -1;
+                }
 		aliasdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
 		if (!aliasdatum) {
+                        free(id);
 			yyerror("out of memory");
 			return -1;
 		}
@@ -2227,13 +2238,18 @@
 		while ((id = queue_remove(id_queue)))
 			free(id);
 		return 0;
-	}		
+	}
 
 	id = (char *) queue_remove(id_queue);
 	if (!id) {
 		yyerror("no identifier for bool definition?");
 		return -1;
 	}
+        if (id_has_dot(id)) {
+                free(id);
+                yyerror("boolean identifiers may not contain periods");
+                return -1;
+        }
 	name = id;
 
 	id = (char *) queue_remove(id_queue);
diff -urN -xpolicy -xCVS nsa/selinux-usr/checkpolicy/policy_scan.l new/checkpolicy/policy_scan.l
--- nsa/selinux-usr/checkpolicy/policy_scan.l	2005-02-17 10:45:13.000000000 -0500
+++ new/checkpolicy/policy_scan.l	2005-04-04 10:39:10.373369880 -0400
@@ -32,6 +32,8 @@
 unsigned long policydb_lineno = 1;
 
 unsigned int policydb_errors = 0;
+
+static int is_valid_identifier(char *id);
 %}
 %array
 letter  [A-Za-z]
@@ -185,8 +187,12 @@
 h2 |
 H2				{ return(H2); }
 "/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
-{letter}({letter}|{digit}|_)*	{ return(IDENTIFIER); }
-{letter}({letter}|{digit}|_|"."|"-")*	{ return(USER_IDENTIFIER); }
+{letter}({letter}|{digit}|_|"."|"-")*({letter}|{digit})	{ if (is_valid_identifier(yytext)) 
+						return(IDENTIFIER); 
+					  else 
+					  	REJECT;
+					}
+{letter}({letter}|{digit}|_)*	{ return(MLS_IDENTIFIER); }
 {digit}{digit}*                 { return(NUMBER); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*	{ return(IPV6_ADDR); }
 #line[ ]1[ ]\"[^\n]*\"		{ source_lineno = 1; strncpy(source_file, yytext+9, 255); source_file[strlen(source_file)-1] = '\0'; }
@@ -244,3 +250,14 @@
 			linebuf[0], linebuf[1]);
 	return 0;
 }
+
+static int is_valid_identifier(char *id) {
+        char *s;
+        if ((s = strrchr(id, '.')) != NULL) {
+                if (strstr(id, "..") != NULL) {
+                        /* identifier has consecutive '.' */
+                        return 0;
+                }
+        }
+        return 1;
+}
 Release: 1
 License: Public domain (uncopyrighted)
 Group: System Environment/Libraries
diff -urN -xpolicy -xCVS nsa/selinux-usr/libsepol/include/sepol/conditional.h new/libsepol/include/sepol/conditional.h
--- nsa/selinux-usr/libsepol/include/sepol/conditional.h	2004-08-11 10:18:54.000000000 -0400
+++ new/libsepol/include/sepol/conditional.h	2005-04-04 10:39:10.817302392 -0400
@@ -1,7 +1,7 @@
 /* Authors: Karl MacMillan <kmacmillan@tresys.com>
  *          Frank Mayer <mayerf@tresys.com>
  *
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -78,6 +78,7 @@
 int cond_normalize_expr(policydb_t *p, cond_node_t *cn);
 cond_node_t *cond_node_search(policydb_t *p,cond_node_t *cn);
 int evaluate_conds(policydb_t *p);
+avtab_datum_t *cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list);
 
 void cond_optimize_lists(cond_list_t *cl);
 
diff -urN -xpolicy -xCVS nsa/selinux-usr/libsepol/include/sepol/hierarchy.h new/libsepol/include/sepol/hierarchy.h
--- nsa/selinux-usr/libsepol/include/sepol/hierarchy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/include/sepol/hierarchy.h	2005-04-04 10:39:10.442359392 -0400
@@ -0,0 +1,22 @@
+/* Authors: Jason Tang <jtang@tresys.com>
+ *	    Joshua Brindle <jbrindle@tresys.com>
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * A set of utility functions that aid policy decision when dealing
+ * with hierarchal items.
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _HIERARCHY_H_
+#define _HIERARCHY_H_
+
+#include <sepol/avtab.h>
+#include <sepol/hashtab.h>
+
+int hierarchy_check_constraints(policydb_t *p, char *error_msg, uint32_t error_len);
+
+#endif
diff -urN -xpolicy -xCVS nsa/selinux-usr/libsepol/include/sepol/policydb.h new/libsepol/include/sepol/policydb.h
--- nsa/selinux-usr/libsepol/include/sepol/policydb.h	2005-02-17 10:44:56.000000000 -0500
+++ new/libsepol/include/sepol/policydb.h	2005-04-04 10:39:10.751312424 -0400
@@ -36,6 +36,8 @@
 #include <sepol/constraint.h>
 #include <sepol/sidtab.h>
 
+#define ERRMSG_LEN 1024
+
 /*
  * A datum type is defined for each kind of symbol 
  * in the configuration data:  individual permissions, 
diff -urN -xpolicy -xCVS nsa/selinux-usr/libsepol/src/conditional.c new/libsepol/src/conditional.c
--- nsa/selinux-usr/libsepol/src/conditional.c	2004-08-11 10:18:54.000000000 -0400
+++ new/libsepol/src/conditional.c	2005-04-04 10:39:10.370370336 -0400
@@ -2,7 +2,7 @@
  *          Frank Mayer <mayerf@tresys.com>
  *          David Caplan <dac@tresys.com>
  *
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -721,3 +721,20 @@
 	return;	
 }
 
+avtab_datum_t *cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list)
+{
+	
+	cond_av_list_t *cur_av;
+
+	for(cur_av = cond_list; cur_av != NULL; cur_av = cur_av->next) {
+		
+		if (cur_av->node->key.source_type == key->source_type &&
+		    cur_av->node->key.target_type == key->target_type && 
+		    cur_av->node->key.target_class == key->target_class)
+			
+			return &cur_av->node->datum;
+
+	}
+	return NULL;
+
+}
diff -urN -xpolicy -xCVS nsa/selinux-usr/libsepol/src/hierarchy.c new/libsepol/src/hierarchy.c
--- nsa/selinux-usr/libsepol/src/hierarchy.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/hierarchy.c	2005-04-04 10:39:10.749312728 -0400
@@ -0,0 +1,340 @@
+/* Authors: Joshua Brindle <jbrindle@tresys.com>
+ * 	    Jason Tang <jtang@tresys.com>
+ *
+ * A set of utility functions that aid policy decision when dealing
+ * with hierarchal namespaces.
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <sepol/policydb.h>
+#include <sepol/conditional.h>
+#include <sepol/hierarchy.h>
+
+typedef struct hierarchy_args {
+	policydb_t *p;
+	/* This tells check_avtab_hierarchy to check this list in addition to the unconditional avtab */
+	cond_av_list_t *opt_cond_list; 
+	char errmsg[ERRMSG_LEN];
+} hierarchy_args_t;
+
+/* This merely returns the string part before the last '.'
+ * it does no verification of the existance of the parent
+ * in the policy, you must do this yourself.
+ */
+static int find_parent(char *type, char **parent)
+{
+	char *tmp;
+	int i;
+	
+	assert(type);
+
+	tmp = strchr(type, '.');
+	/* no '.' means it has no parent */
+	if (!tmp) {
+		*parent = NULL;
+		return 0;
+	}
+
+	for (i = strlen(type) - 1; i > 0; i--) {
+		if (type[i] == '.')
+			break;
+	}
+	
+	*parent = (char *)malloc(sizeof(char) * (i + 1));
+
+	if (!(*parent))  {
+		fprintf(stderr, "Memory Error\n");
+		return -1;
+	}
+	memset(*parent, 0, (i + 1));
+	memcpy(*parent, type, i);
+		
+	return 0;
+}
+
+/* This function verifies that the type passed in either has a parent or is in the 
+ * root of the namespace, 0 on success, 1 on orphan and -1 on error
+ */
+static int check_type_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	char *parent;
+	hierarchy_args_t *a;
+	type_datum_t *t, *t2;
+
+
+	a = (hierarchy_args_t *)args;
+	t = (type_datum_t *)d;
+
+	if (t->isattr) {
+		/* It's an attribute, we don't care */
+		return 0;
+	}
+        
+	if (find_parent(a->p->p_type_val_to_name[t->value - 1], &parent))
+		return -1;
+
+	if (!parent) {
+		/* This type is in the root namespace */
+		return 0;
+	}
+
+	t2 = hashtab_search(a->p->p_types.table, parent);
+	if (!t2) {
+		/* If the parent does not exist this type is an orphan, not legal */
+		snprintf(a->errmsg, ERRMSG_LEN, "type %s does not exist, %s is an orphan",
+			parent,a->p->p_type_val_to_name[t->value - 1]);
+		return 1;
+	} else if (t2->isattr) {
+			/* The parent is an attribute but the child isn't, not legal */
+			snprintf(a->errmsg, ERRMSG_LEN, "type %s is a child of an attribute",
+			a->p->p_type_val_to_name[t->value - 1]);
+		return 1;
+	}
+	
+	return 0;
+}
+
+/* This function only verifies that the avtab node passed in does not violate any
+ * hiearchy constraint via any relationship with other types in the avtab.
+ * it should be called using avtab_map, returns 0 on success, 1 on violation and
+ * -1 on error. opt_cond_list is an optional argument that tells this to check
+ * a conditional list for the relationship as well as the unconditional avtab
+ */
+static int check_avtab_hierarchy_callback(avtab_key_t *k, avtab_datum_t *d, void *args)
+{
+	char *parent;
+	avtab_key_t key;
+	avtab_datum_t *avdatump;
+	hierarchy_args_t *a;
+	uint32_t av;
+	type_datum_t *t = NULL, *t2 = NULL;
+	
+	a = (hierarchy_args_t *)args;
+	if (find_parent(a->p->p_type_val_to_name[k->source_type - 1], &parent))
+		return -1;
+		
+	/* search for parent first */
+	if (parent) {
+		t = hashtab_search(a->p->p_types.table, parent);
+		if (!t) {
+			/* If the parent does not exist this type is an orphan, not legal */
+			snprintf(a->errmsg, ERRMSG_LEN, "type %s doesn't exist, %s is an orphan",
+				parent,a->p->p_type_val_to_name[k->target_type - 1]);
+			free(parent);
+			return 1;
+		}
+		free(parent);
+		
+		key.source_type = t->value;
+		key.target_type = k->target_type;
+		key.target_class = k->target_class;
+	
+		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		if (avdatump) {
+			/* search for access allowed between type 1's parent and type 2 */
+			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+				return 0;
+			}
+			av = avtab_allowed(avdatump);
+		} else 
+			av = 0;
+		if (a->opt_cond_list) {
+			/* if a conditional list is present search it before continuing */
+			avdatump = cond_av_list_search(&key, a->opt_cond_list);
+			if (avdatump) {
+				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+					return 0;
+				}
+			}			
+		}			
+	}
+
+	/* next we try type 1 and type 2's parent */
+	if (find_parent(a->p->p_type_val_to_name[k->target_type - 1], &parent))
+		return -1;
+
+	if (parent) {
+		t2 = hashtab_search(a->p->p_types.table, parent);
+		if (!t2) {
+			snprintf(a->errmsg, ERRMSG_LEN, "type %s doesn't exist, %s is an orphan",
+				parent, a->p->p_type_val_to_name[k->target_type - 1]);
+			free(parent);
+			return 1;
+		}
+		free(parent);
+	
+		key.source_type = k->source_type;
+		key.target_type = t2->value;
+		key.target_class = k->target_class;
+		
+		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		if (avdatump) {
+			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+				return 0;
+			}
+			av = avtab_allowed(avdatump);
+		} else 
+			av = 0;
+		if (a->opt_cond_list) {
+			/* if a conditional list is present search it before continuing */
+			avdatump = cond_av_list_search(&key, a->opt_cond_list);
+			if (avdatump) {
+				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+					return 0;
+				}
+			}			
+		}			
+	}
+
+	if (t && t2) {
+		key.source_type = t->value;
+		key.target_type = t2->value;
+		key.target_class = k->target_class;
+	
+		avdatump = avtab_search(&a->p->te_avtab, &key, AVTAB_AV);
+		if (avdatump) {
+			if ((avtab_allowed(avdatump) & avtab_allowed(d)) == avtab_allowed(d)) {
+				return 0;
+			}
+			av = avtab_allowed(avdatump);
+		} else 
+			av = 0;
+		if (a->opt_cond_list) {
+			/* if a conditional list is present search it before continuing */
+			avdatump = cond_av_list_search(&key, a->opt_cond_list);
+			if (avdatump) {
+				if (((av | avtab_allowed(avdatump)) & avtab_allowed(d)) == avtab_allowed(d)) {
+					return 0;
+				}
+			}
+		}			
+	}
+
+	if (!t && !t2) {
+		/* Neither one of these types have parents and 
+		 * therefore the hierarchical constraint does not apply */
+		return 0;
+	}
+	
+	/* At this point there is a violation of the hierarchal constraint, send error condition back */
+	snprintf(a->errmsg, ERRMSG_LEN,"hierachy violation between types %s and %s",
+			a->p->p_type_val_to_name[k->source_type - 1],
+			a->p->p_type_val_to_name[k->target_type - 1]);
+	return 1;
+}
+
+	
+
+static int check_cond_avtab_hierarchy(cond_list_t *cond_list, hierarchy_args_t *args)
+{
+	int rc;
+	cond_list_t *cur_node;
+	cond_av_list_t *cur_av;
+
+	for (cur_node = cond_list; cur_node != NULL; cur_node = cur_node ->next) {
+		args->opt_cond_list = cur_node->true_list;
+		for (cur_av = cur_node->true_list; cur_av != NULL; cur_av = cur_av->next) {
+			rc = check_avtab_hierarchy_callback(&cur_av->node->key, &cur_av->node->datum, args);
+			if (rc == 0)
+				continue;
+			/* error condition */
+			return rc;
+		}
+		args->opt_cond_list = cur_node->false_list;
+		for (cur_av = cur_node->false_list; cur_av != NULL; cur_av = cur_av->next) {
+			rc = check_avtab_hierarchy_callback(&cur_av->node->key, &cur_av->node->datum, args);
+			if (rc == 0)
+				continue;
+			/* error condition */
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+/* The role hierarchy is defined as: a child role cannot have more types than it's parent.
+ * This function should be called with hashtab_map, it will return 0 on success, 1 on 
+ * constraint violation and -1 on error
+ */
+static int check_role_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	char *parent;
+	hierarchy_args_t *a;
+	role_datum_t *r, *rp;
+	ebitmap_t *eb;
+
+	a = (hierarchy_args_t *)args;
+	r = (role_datum_t *)d;
+
+        if (find_parent(a->p->p_role_val_to_name[r->value - 1], &parent))
+		return -1;
+
+	if (!parent) {
+		/* This role has no parent */
+		return 0;
+	}
+
+	rp = hashtab_search(a->p->p_roles.table, parent);
+	if (!rp) {
+		/* Orphan role */
+		snprintf(a->errmsg, ERRMSG_LEN, "role %s doesn't exist, %s is an orphan",
+				parent,a->p->p_role_val_to_name[r->value - 1]);
+		free(parent);
+		return 1;
+	}
+
+	if (ebitmap_or(eb, &r->types, &rp->types)) {
+		/* Memory error */
+		return -1;
+	}
+	
+	if (!ebitmap_cmp(eb, &rp->types)) {
+		ebitmap_destroy(eb);
+		/* This is a violation of the hiearchal constraint, return error condition */
+		snprintf(a->errmsg, ERRMSG_LEN, "Role hierarchy violation, %s exceeds %s",
+				   a->p->p_role_val_to_name[r->value - 1],
+				   parent);
+		return 1;
+	}
+
+	ebitmap_destroy(eb);
+
+	return 0;
+}
+
+int hierarchy_check_constraints(policydb_t *p, char *error_msg, uint32_t error_len)
+{
+	hierarchy_args_t args;
+
+	args.p = p;
+	args.opt_cond_list = NULL;
+
+	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args)) 
+		goto bad;
+
+	if (avtab_map(&p->te_avtab, check_avtab_hierarchy_callback, &args))
+		goto bad;
+
+	if (check_cond_avtab_hierarchy(p->cond_list, &args))
+		goto bad;
+
+	if (hashtab_map(p->p_roles.table, check_role_hierarchy_callback, &args)) 
+		goto bad;
+
+	return 0;
+
+bad:
+	if (args.errmsg)
+		error_msg = strncpy(error_msg, args.errmsg, error_len);
+
+	return -1;
+}
+
diff -urN -xpolicy -xCVS nsa/selinux-usr/selinux-doc/README.HIERARCHY new/selinux-doc/README.HIERARCHY
--- nsa/selinux-usr/selinux-doc/README.HIERARCHY	1969-12-31 19:00:00.000000000 -0500
+++ new/selinux-doc/README.HIERARCHY	2005-04-04 10:39:10.296381584 -0400
@@ -0,0 +1,148 @@
+1. Overview
+
+The hierarchical extensions introduce two new concepts into the SELinux policy 
+language. The first is the addition of hierarchy into some symbol namespaces, 
+allowing, currently, the creation of types and roles with a parent/child 
+relationship to other types or roles. This is done through the introduction of 
+the ‘.’ operator into the language. The second important concept is the addition 
+of implicit constraints based on the hierarchy. The specific semantics of the 
+constraints are defined on a per-namespace basis, but in general a child element 
+will no more access than its parent.
+
+This extension is meant to ease the creation of policies and introduction a way 
+to conceptualize polices that focuses on important security properties. This is 
+partially inspired by the SEFramework project. More information on SEFramework 
+can be found at http://www.selinux-symposium.org/2005/presentations/session6/6-
+1-wilson.pdf. Additionally, this extension is intended to make it possible to
+implement access control on the policy. More information on this work can be
+found at http://www.selinux-symposium.org/2005/presentations/session3/3-2-macmillan.pdf.
+
+2. Defining Hierarchical Symbols
+
+Hierarchical symbols are defined through the ‘.’ operator.  This operator is 
+currently valid in the type and role namespaces, but may be introduced in other 
+namespaces in the future. For example, consider the following type declarations:
+
+	type apache;
+	type apache.cgi;
+
+In this example, the type apache.cgi is a child of apache. A symbol can be both 
+a normal symbol and container for other symbols. The addition of hierarchy does 
+not otherwise change the syntax of the symbol declarations. It is possible, for 
+example, to include attributes and aliases in the declaration of types that 
+include hierarchy. The hierarchy can be of arbitrary depth, for example:
+
+	role admins;
+	role admins.junior;
+	role admins.junior.useradd;
+
+The hierarchy should not be confused with inheritance: children do not inherit 
+any access from parents. Like all of the other policy statements, access must be 
+explicitly granted.
+
+3. Hierarchical Constraints
+
+Each namespace has specific implicit constraints based on the hierarchy. The 
+details of the constraints are different for different namespaces, but the 
+general goal is the same: children are constrained to no more access than their 
+parents. Again, no access is inherited from parents, only constraints. The 
+constraints are defined only by the immediate parent. For example, given the 
+following types:
+
+	type apache;
+	type apache.cgi;
+	type apache.cgi.user;
+
+The type apache.cgi must have equal or less access that apache. If apache.cgi 
+has a subset of the access of apache, then apache.cgi.user must be constrained 
+to no more than that subset. The type apache.cgi.user cannot be granted access 
+that apache.cgi does not have even if apache has that access.
+
+The constraints are not order dependent; the constraints are checked after the 
+entire policy has been loaded, so the sum of all access for each symbol is 
+considered.
+
+3.1 Type Constraints
+
+Types are constrained based on both explicit access granted through allow rules 
+and indirectly based on attributes. This means that a child type can have no 
+more attributes than its parent. Audit rules and type transition rules are not 
+currently constrained. Take the following example:
+
+	type apache, domain, privlog;
+	type apache.cgi, domain, privlog;
+	type apache.cgi.user, domain;
+
+	type afile, file_type;
+
+	allow apache afile : file { read write getattr setattr }
+	allow apache.cgi afile : file { read getattr };
+	allow apache.cgi.user afile : file { read write getattr }
+
+In this example, the hierarchical constraints are satisfied for apache, because 
+it has no parent, and apache.cgi, because its access is a subset of its parent. 
+The hierarchical constraints are violated for apache.cgi.user, however, because 
+it has the permission write that apache.cgi does not.
+
+The hierarchical constraints for types are complicated by conditional 
+expressions. A conditional policy can be viewed as a set of N policies, with N 
+being the number of unique combinations of boolean settings. The implicit 
+constraints, in this model, should be checked for each of the N policies. This 
+is both complex programmatically and computationally. The current implementation 
+comprises and defines the implicit constrains in a way that is simpler to check, 
+but slightly more restrictive. In the current implementation the implicit 
+constraints for a child are defined as access granted to the parent that is 
+either unconditional or defined in the current conditional expression. For 
+example:
+
+	type foo;
+	type foo.bar;
+	type etc_file;
+	bool baz true;
+---
+VALID:
+
+	allow foo etc_file : file { read write append };
+	
+	if(baz) {
+		allow foo.bar etc_file : file { read write };
+	}
+---
+
+VALID:
+  
+	if (baz) {
+	 	allow foo etc_file : file { read write append };
+	 	allow foo.bar etc_file : file { read write append };
+	}
+---
+
+INVALID:
+
+	if (baz) {
+	  	allow foo etc_file : file { read write append };
+	} else {
+	  	allow foo.bar etc_file : file { read write };
+	}
+---
+
+INVALID:
+
+	allow foo.bar etc_file : file { read write };
+	
+	if (baz) {
+	  	allow foo etc_file : file { read write append };
+	}
+
+3.2 Role Constraints
+
+The role constraint simply says that any child role must have the same or fewer 
+types associated with it. For example:
+
+	role user types { foo_t bar_t baz_t  };
+	role user.guest types foo_t;
+
+The following, however, is not valid:
+
+	role user types foo_t;
+	role user.guest types { foo_t bar_t };

--=-LBD90bktVHComaKskBQC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
