Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QIUggA006739
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:30:42 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QIPJmU007740
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 18:25:19 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4QIQU5n024368
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:26:30 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4QIQUHY024367
	for selinux@tycho.nsa.gov; Thu, 26 May 2005 14:26:30 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QHXngA006195
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 13:33:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QHSPmU002827
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 17:28:25 GMT
Subject: [Patch 3/3] Loadable policy module infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Thu, 26 May 2005 13:27:05 -0400
Message-Id: <1117128425.3483.21.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -burNd a1/checkpolicy/Makefile b/checkpolicy/Makefile
--- a1/checkpolicy/Makefile	2005-05-25 13:14:58.691736752 -0400
+++ b/checkpolicy/Makefile	2005-05-25 13:11:19.295090112 -0400
@@ -1,20 +1,21 @@
 #
 # Makefile for building the checkpolicy program
 #
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= ${PREFIX}/lib
-INCLUDEDIR ?= ${PREFIX}/include
+LIBDIR ?= $(PREFIX)/lib
+INCLUDEDIR ?= $(PREFIX)/include
 TARGETS = checkpolicy 
 
-CFLAGS = -g -Wall -O2 -pipe
+CFLAGS = -g -Wall -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+#override CFLAGS += -I. -I$(INCLUDEDIR)
+CFLAGS += -I. -I../libselinux/include -I../libsepol/include -I../libsemod/include
 
 OBJS += y.tab.o lex.yy.o queue.o checkpolicy.o
 
-LIBS=-lfl ${LIBDIR}/libsepol.a
+LIBS=-lfl $(LIBDIR)/libsepol.a
 
 all:  $(TARGETS)
 
diff -burNd a1/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
--- a1/checkpolicy/checkpolicy.c	2005-05-25 13:14:59.173663488 -0400
+++ b/checkpolicy/checkpolicy.c	2005-05-25 13:11:19.811011680 -0400
@@ -16,8 +16,14 @@
  *
  *	Added IPv6 support.
  *
+ * Updated: Joshua Brindle <jbrindle@tresys.com>
+ *	    Karl MacMillan <kmacmillan@tresys.com>
+ *          Jason Tang     <jtang@tresys.com>
+ *
+ *	Policy Module support.
+ *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
@@ -51,6 +57,11 @@
  * booleans or conditional rules are thrown away a warning is printed.
  */
 
+#include <ctype.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
 #include <getopt.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -59,9 +70,6 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <errno.h>
 #include <sys/mman.h>
 
 #include <sepol/policydb.h>
@@ -69,6 +77,7 @@
 #include <sepol/conditional.h>
 #include <sepol/hierarchy.h>
 #include <sepol/flask.h>
+#include <sepol/expand.h>
 
 #include "queue.h"
 #include "checkpolicy.h"
@@ -83,12 +92,12 @@
 extern queue_t id_queue;
 extern unsigned int policydb_errors;
 extern unsigned long policydb_lineno;
-extern unsigned long source_lineno;
 extern char source_file[];
-extern unsigned int pass;
 
 extern FILE *yyin;
+extern void init_parser(int);
 extern int yyparse(void);
+extern int yywarn(char *);
 extern void yyrestart(FILE *);
 
 char *txtfile = "policy.conf";
@@ -147,15 +150,6 @@
 	return 0;
 }
 
-static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
-{
-	type_datum_t *typdatum;
-
-	typdatum = (type_datum_t *) datum;
-	if (typdatum->isattr)
-		return 1;
-	return 0;
-}
 
 #ifdef EQUIVTYPES
 static int insert_type_rule(avtab_key_t *k, avtab_datum_t *d, 
@@ -321,63 +315,6 @@
 
 extern char *av_to_string(uint32_t tclass, sepol_access_vector_t av);
 
-void check_assertion_helper(unsigned int stype, unsigned int ttype, ebitmap_t *tclasses, 
-			    sepol_access_vector_t *avp, unsigned long line) 
-{
-	avtab_key_t avkey;
-	avtab_datum_t *avdatump;
-	unsigned int k;
-	
-
-	for (k = ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++) {
-		if (!ebitmap_get_bit(tclasses, k)) 
-			continue;
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = k + 1;
-		avdatump = avtab_search(&policydb.te_avtab, &avkey, AVTAB_AV);
-		if (!avdatump) 
-			continue;
-
-		if ((avdatump->specified & AVTAB_ALLOWED) &&
-		    (avtab_allowed(avdatump) & avp[k])) {
-			fprintf(stderr, "assertion on line %ld violated by allow %s %s:%s {%s };\n", line, policydb.p_type_val_to_name[stype], policydb.p_type_val_to_name[ttype], policydb.p_class_val_to_name[k], 
-				av_to_string(k+1,
-					     avtab_allowed(avdatump) & avp[k]));
-			policydb_errors++;
-		}
-	}
-}
-
-void check_assertions(void) 
-{
-	te_assert_t *a, *tmp;
-	unsigned int i, j;
-
-	a = te_assertions;
-	while (a) {
-		for (i = ebitmap_startbit(&a->stypes); i < ebitmap_length(&a->stypes); i++) {
-			if (!ebitmap_get_bit(&a->stypes, i))
-				continue;
-			if (a->self) {
-				check_assertion_helper(i, i, &a->tclasses, a->avp, a->line);
-			}
-			for (j = ebitmap_startbit(&a->ttypes); j < ebitmap_length(&a->ttypes); j++) {
-				if (!ebitmap_get_bit(&a->ttypes, j)) 
-					continue;
-				check_assertion_helper(i, j, &a->tclasses, a->avp, a->line);
-			}
-		}
-		tmp = a;
-		a = a->next;
-		ebitmap_destroy(&tmp->stypes);
-		ebitmap_destroy(&tmp->ttypes);
-		ebitmap_destroy(&tmp->tclasses);
-		free(tmp->avp);
-		free(tmp);
-	}
-}
-
 int display_bools()
 {
 	int i;
@@ -389,11 +326,11 @@
 	return 0;
 }
 
-void display_expr(cond_expr_t *exp)
+void display_expr(cond_expr_t *expr)
 {
 
 	cond_expr_t *cur;
-	for (cur = exp; cur != NULL; cur = cur->next) {
+	for (cur = expr; cur != NULL; cur = cur->next) {
 		switch (cur->expr_type) {
 		case COND_BOOL:
 			printf("%s ", policydbp->p_bool_val_to_name[cur->bool - 1]);
@@ -472,7 +409,6 @@
 	int show_version = 0;
 	struct policy_file pf;
 
-
 	while ((ch = getopt(argc, argv, "o:dbMVc:")) != EOF) {
 		switch (ch) {
 		case 'o':
@@ -575,6 +511,8 @@
 			}
 		}
 	} else {
+                policydb_t parse_policy;
+
 		yyin = fopen(file, "r");
 		if (!yyin) {
 			fprintf(stderr, "%s:  unable to open %s\n", argv[0], 
@@ -582,7 +520,8 @@
 			exit(1);
 		}
 
-		if (policydb_init(&policydb))
+		/* We build this as a base policy first since that is all the parser understands */
+		if (policydb_init(&parse_policy, POLICY_BASE))
 			exit(1);
 
 		/* Let sepol know if we are dealing with MLS support */
@@ -593,65 +532,77 @@
 			fprintf(stderr, "%s:  out of memory\n", argv[0]);
 			exit(1);
 		}
-		policydbp = &policydb;
-		policydb_errors = 0;
-		pass = 1;
+		policydbp = &parse_policy;
+                init_parser(1);
 		if (yyparse() || policydb_errors) {
 			fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
 			exit(1);
 		}
 		rewind(yyin);
-		policydb_lineno = 1;
+                init_parser(2);
 		source_file[0] = '\0';
-		source_lineno = 1;
 		yyrestart(yyin);
-		pass = 2;
 		if (yyparse() || policydb_errors) {
 			fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
 			exit(1);
 		}
 		queue_destroy(id_queue);
-
 		cond_check_type_rules();
 		cond_optimize_lists(policydb.cond_list);
 
-		check_assertions();
 		if (policydb_errors) 
 			exit(1);
 
 		if (policyvers >= POLICYDB_VERSION_NLCLASS &&
-		    policydb.p_classes.nprim < SECCLASS_NETLINK_DNRT_SOCKET) {
+		    parse_policy.p_classes.nprim < SECCLASS_NETLINK_DNRT_SOCKET) {
 			fprintf(stderr, "%s:  policy lacks new netlink classes, unable to generate policy version %d\n", argv[0], policyvers);
 			exit(1);
 		}
 
-		if (hierarchy_check_constraints(&policydb, error_msg, sizeof(error_msg))) {
+		if (hierarchy_check_constraints(&parse_policy, error_msg, sizeof(error_msg))) {
 			fprintf(stderr, "%s\n", error_msg);
 			exit(1);
 		}
 
-		/* remove type attributes */
-		hashtab_map_remove_on_error(policydb.p_types.table, 
-					    type_attr_remove, 0, 0);
+		if (policydb_init(&policydb, POLICY_KERN))
+			exit(1);
+
+		if (expand_module(&parse_policy, &policydb, 0, error_msg, ERRMSG_LEN)) {
+                        fprintf(stderr, "Error while expanding policy: %s\n", error_msg);
+			exit(1);
+                }
+		policydbp = &policydb;
+
+		if (check_assertions(policydbp, policydbp->avrules, &policydbp->te_avtab)) {
+                        fprintf(stderr, "Check assertions failed.\n");
+			return -1;
+                }
 		
+		if (check_assertions(policydbp, policydbp->avrules, &policydbp->te_cond_avtab)) {
+                        fprintf(stderr, "Check assertions failed.\n");
+			return -1;
+                }
 		fclose(yyin);
 	}
 
 	if (policydb_load_isids(&policydb, &sidtab))
 		exit(1);
 
+	if (policydb_index_others(policydbp, 1))
+		exit(1);
+        
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
 	if (outfile) {
 		printf("%s:  writing binary representation (version %d) to %s\n",
 		       argv[0], policyvers, outfile);
-		outfp = fopen(outfile, "w");
+		outfp = fopen(outfile, "wb");
 		if (!outfp) {
 			perror(outfile);
 			exit(1);
 		}
 
-		if (sepol_set_policyvers(policyvers)) {
+		if (sepol_set_policyvers(POLICY_KERN, policyvers)) {
 			fprintf(stderr,"%s:  incompatible policy (version %d) "
 				"for writing to %s\n", argv[0],
 				policyvers, outfile);
diff -burNd a1/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
--- a1/checkpolicy/policy_parse.y	2005-05-25 13:14:58.689737056 -0400
+++ b/checkpolicy/policy_parse.y	2005-05-25 13:11:19.301089200 -0400
@@ -1,4 +1,3 @@
-
 /*
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
  */
@@ -12,8 +11,14 @@
  *
  * 	Added conditional policy language extensions
  *
+ * Updated: Joshua Brindle <jbrindle@tresys.com>
+ *	    Karl MacMillan <kmacmillan@tresys.com>
+ *          Jason Tang     <jtang@tresys.com>
+ *
+ *	Added support for binary policy modules
+ *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -22,13 +27,17 @@
 /* FLASK */
 
 %{
-#include <sys/types.h>
+#include <assert.h>
 #include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <sys/socket.h>
-#include <netinet/in.h>
+#include <sys/types.h>
 #include <arpa/inet.h>
-#include <stdlib.h>
+#include <netinet/in.h>
 
+#include <sepol/expand.h>
 #include <sepol/policydb.h>
 #include <sepol/services.h>
 #include <sepol/conditional.h>
@@ -43,25 +52,37 @@
  * for NULL (ie 0) because that is a potentially valid return.
  */
 static cond_av_list_t *conditional_unused_error_code;
-#define COND_ERR (cond_av_list_t *)&conditional_unused_error_code
+#define COND_ERR (avrule_t *)&conditional_unused_error_code
 
 #define TRUE 1
 #define FALSE 0
 
 policydb_t *policydbp;
 queue_t id_queue = 0;
-unsigned int pass;
 char *curfile = 0;
-unsigned int curline; 
+
+static unsigned int pass;
+static avrule_t *last_avrule = NULL;
+
+/* So as to make it easier to verify the correctness of the module
+ * changes, keep track of how many types (sans attributes and aliases)
+ * have been found.  Conveniently this also acts as to ensure that
+ * type values are ordered based upon their declaration within the
+ * policy.conf file, which is what non-module policy_parse.y did. */
+static uint32_t num_types_found = 0;
 
 extern unsigned long policydb_lineno;
+extern unsigned long source_lineno;
+extern unsigned int policydb_errors;
+extern unsigned int policyvers;
 
 extern char yytext[];
 extern int yylex(void);
 extern int yywarn(char *msg);
 extern int yyerror(char *msg);
 
-static char errormsg[255];
+#define ERRORMSG_LEN 255
+static char errormsg[ERRORMSG_LEN + 1] = {0};
 
 static int insert_separator(int push);
 static int insert_id(char *id,int push);
@@ -78,6 +99,7 @@
 static int define_typealias(void);
 static int define_typeattribute(void);
 static int define_type(int alias);
+static int define_type_noalias(void);
 static int define_compute_type(int which);
 static int define_te_avtab(int which);
 static int define_role_types(void);
@@ -89,13 +111,11 @@
 static int define_constraint(constraint_expr_t *expr);
 static int define_validatetrans(constraint_expr_t *expr);
 static int define_bool();
-static int define_conditional(cond_expr_t *expr,cond_av_list_t *t_list, cond_av_list_t *f_list );
+static int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_list );
 static cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
-static cond_av_list_t *define_cond_pol_list(cond_av_list_t *avlist, cond_av_list_t *stmt);
-static cond_av_list_t *define_cond_compute_type(int which);
-static cond_av_list_t *define_cond_te_avtab(int which);
-static cond_av_list_t *cond_list_append(cond_av_list_t *sl, avtab_key_t *key, avtab_datum_t *datum);
-static void cond_reduce_insert_list(cond_av_list_t *new, cond_av_list_t **active, cond_av_list_t **inactive, int state ); 
+static avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
+static avrule_t *define_cond_compute_type(int which);
+static avrule_t *define_cond_te_avtab(int which);
 static uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2);
 static int define_user(void);
 static int parse_security_context(context_struct_t *c);
@@ -182,11 +202,14 @@
 %right NOT
 %left EQUALS NOTEQUAL
 %%
-policy			: classes initial_sids access_vectors
-                          { if (pass == 1) { if (policydb_index_classes(policydbp)) return -1; } }
+policy			: base_policy
+                        ;
+base_policy             : classes initial_sids access_vectors
+                          { if (pass == 1) { if (policydb_index_classes(policydbp)) return -1; }
+                            else if (pass == 2) { if (policydb_index_others(policydbp, 0)) return -1; }}
 			  opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
-			   if (pass == 2) { if (policydb_index_others(policydbp, 1)) return -1;} } 
+			   else if (pass == 2) { if (policydb_index_others(policydbp, 0)) return -1;}}
 			  initial_sid_contexts opt_fs_contexts fs_uses opt_genfs_contexts net_contexts 
 			;
 classes			: class_def 
@@ -321,13 +344,13 @@
 			{ if (insert_id("F",0)) return -1; }
                         ;
 cond_stmt_def           : IF cond_expr '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (cond_av_list_t*)$4,(cond_av_list_t*) 0) < 0) return -1;  }}
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*) 0) < 0) return -1;  }}
                         | IF cond_expr '{' cond_pol_list '}' ELSE '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(cond_av_list_t*)$4,(cond_av_list_t*)$8) < 0 ) return -1;  }}       
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*)$4,(avrule_t*)$8) < 0 ) return -1;  }}       
                         | IF cond_expr '{' cond_pol_list '}' ELSE '{' '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(cond_av_list_t*)$4,(cond_av_list_t*) 0) < 0 ) return -1;  }}       
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*)$4,(avrule_t*) 0) < 0 ) return -1;  }}       
                         | IF cond_expr '{' '}' ELSE '{' cond_pol_list '}'
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(cond_av_list_t*) 0,(cond_av_list_t*) $7) < 0 ) return -1;  }}       
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(avrule_t*) 0,(avrule_t*) $7) < 0 ) return -1;  }}       
                         | IF cond_expr '{' '}' ELSE '{' '}'
                         /* do nothing */
                         | IF cond_expr '{' '}' 
@@ -361,9 +384,9 @@
 			  if ($$ == COND_ERR) return   -1; }
                         ;
 cond_pol_list           : cond_rule_def
-                        { $$ = define_cond_pol_list((cond_av_list_t *) 0, (cond_av_list_t *)$1);}
+                        { $$ = define_cond_pol_list((avrule_t *) 0, (avrule_t *)$1);}
                         | cond_pol_list cond_rule_def 
-                        { $$ = define_cond_pol_list((cond_av_list_t *)$1, (cond_av_list_t *)$2); }
+                        { $$ = define_cond_pol_list((avrule_t *)$1, (avrule_t *)$2); }
 			;
 cond_rule_def           : cond_transition_def
                         { $$ = $1; }
@@ -371,13 +394,13 @@
                         { $$ = $1; }
                         ;
 cond_transition_def	: TYPE_TRANSITION names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVTAB_TRANSITION) ;
+                        { $$ = define_cond_compute_type(AVRULE_TRANSITION) ;
                           if ($$ == COND_ERR) return -1;}
                         | TYPE_MEMBER names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVTAB_MEMBER) ;
+                        { $$ = define_cond_compute_type(AVRULE_MEMBER) ;
                           if ($$ ==  COND_ERR) return -1;}
                         | TYPE_CHANGE names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVTAB_CHANGE) ;
+                        { $$ = define_cond_compute_type(AVRULE_CHANGE) ;
                           if ($$ == COND_ERR) return -1;}
     			;
 cond_te_avtab_def	: cond_allow_def
@@ -390,27 +413,27 @@
 			  { $$ = $1; }
 			;
 cond_allow_def		: ALLOW names names ':' names names  ';'
-			{ $$ = define_cond_te_avtab(AVTAB_ALLOWED) ;
+			{ $$ = define_cond_te_avtab(AVRULE_ALLOWED) ;
                           if ($$ == COND_ERR) return -1; }
 		        ;
 cond_auditallow_def	: AUDITALLOW names names ':' names names ';'
-			{ $$ = define_cond_te_avtab(AVTAB_AUDITALLOW) ;
+			{ $$ = define_cond_te_avtab(AVRULE_AUDITALLOW) ;
                           if ($$ == COND_ERR) return -1; }
 		        ;
 cond_auditdeny_def	: AUDITDENY names names ':' names names ';'
-			{ $$ = define_cond_te_avtab(AVTAB_AUDITDENY) ;
+			{ $$ = define_cond_te_avtab(AVRULE_AUDITDENY) ;
                           if ($$ == COND_ERR) return -1; }
 		        ;
 cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
-			{ $$ = define_cond_te_avtab(-AVTAB_AUDITDENY);
+			{ $$ = define_cond_te_avtab(AVRULE_DONTAUDIT);
                           if ($$ == COND_ERR) return -1; }
 		        ;
 transition_def		: TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVTAB_TRANSITION)) return -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION)) return -1;}
                         | TYPE_MEMBER names names ':' names identifier ';'
-                        {if (define_compute_type(AVTAB_MEMBER)) return -1;}
+                        {if (define_compute_type(AVRULE_MEMBER)) return -1;}
                         | TYPE_CHANGE names names ':' names identifier ';'
-                        {if (define_compute_type(AVTAB_CHANGE)) return -1;}
+                        {if (define_compute_type(AVRULE_CHANGE)) return -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
 			{ if (define_range_trans()) return -1; }
@@ -422,22 +445,24 @@
 			| neverallow_def
 			;
 allow_def		: ALLOW names names ':' names names  ';'
-			{if (define_te_avtab(AVTAB_ALLOWED)) return -1; }
+			{if (define_te_avtab(AVRULE_ALLOWED)) return -1; }
 		        ;
 auditallow_def		: AUDITALLOW names names ':' names names ';'
-			{if (define_te_avtab(AVTAB_AUDITALLOW)) return -1; }
+			{if (define_te_avtab(AVRULE_AUDITALLOW)) return -1; }
 		        ;
 auditdeny_def		: AUDITDENY names names ':' names names ';'
-			{if (define_te_avtab(AVTAB_AUDITDENY)) return -1; }
+			{if (define_te_avtab(AVRULE_AUDITDENY)) return -1; }
 		        ;
 dontaudit_def		: DONTAUDIT names names ':' names names ';'
-			{if (define_te_avtab(-AVTAB_AUDITDENY)) return -1; }
+			{if (define_te_avtab(AVRULE_DONTAUDIT)) return -1; }
 		        ;
 neverallow_def		: NEVERALLOW names names ':' names names  ';'
-			{if (define_te_avtab(-AVTAB_ALLOWED)) return -1; }
+			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
 		        ;
 role_type_def		: ROLE identifier TYPES names ';'
 			{if (define_role_types()) return -1;}
+ 			| ROLE identifier';'
+ 			{if (define_role_types()) return -1;}
                         ;
 role_dominance		: DOMINANCE '{' roles '}'
 			;
@@ -643,11 +668,8 @@
                         | FSUSETRANS identifier security_context_def ';'
                         {if (define_fs_use(SECURITY_FS_USE_TRANS)) return -1;}
                         ;
-opt_genfs_contexts      : genfs_contexts
-                        | 
-                        ;
-genfs_contexts	        : genfs_context_def
-			| genfs_contexts genfs_context_def
+opt_genfs_contexts      : genfs_context_def opt_genfs_contexts
+                        | /* empty */
 			;
 genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
@@ -656,6 +678,7 @@
                         | GENFSCON identifier path security_context_def
 			{if (define_genfs_context(0)) return -1;}
 			;
+/* FIX ME: add policycon statements here */
 ipv4_addr_def		: number '.' number '.' number '.' number
 			{ 
 			  unsigned int addr;
@@ -763,6 +786,18 @@
 			{ if (insert_id(yytext,0)) return -1; }
 			;
 %%
+
+/* initialize all of the state variables for the scanner/parser */
+void init_parser(int pass_number)
+{
+        policydb_lineno = 1;
+        source_lineno = 1;
+        policydb_errors = 0;
+        pass = pass_number;
+        last_avrule = NULL;
+        num_types_found = 0;
+}
+
 #define DEBUG 1
 
 static int insert_separator(int push)
@@ -805,7 +840,44 @@
 	return 0;
 }
 
-/* If the identifier has a dot within it return 1, else return 0. */
+/* Add a rule onto an avtab hash table only if it does not already
+ * exist.  (Note that the avtab is discarded afterwards; it will be
+ * regenerated during expansion.)  Return 1 if rule was added (or
+ * otherwise handled successfully), 0 if it conflicted with something,
+ * or -1 on error. */
+static int insert_check_type_rule(avrule_t *rule, avtab_t *avtab, cond_av_list_t **list, cond_av_list_t **other)
+{
+	char *error_msg = NULL;
+	int ret;
+	
+	ret = expand_rule(policydbp, rule, avtab, list, other, 0, &error_msg);
+	switch (ret) {
+        case 0: {
+                if (error_msg == NULL) {
+                        yywarn("Conflicting rule");
+                }
+                else {
+                        yywarn(error_msg);
+                }
+                free(error_msg);
+                break;
+        }
+        case -1: {
+                if (error_msg == NULL) {
+                        yyerror("Error inserting rule");
+                }
+                else {
+                        yyerror(error_msg);
+                }
+                free(error_msg);
+                break;
+        }
+        }
+	return ret;
+}
+
+/* If the identifier has a dot within it and that its first character
+   is not a dot then return 1, else return 0. */
 static int id_has_dot(char *id)
 {
         if (strchr(id, '.') >= id + 1) {
@@ -819,7 +891,7 @@
 	char *id = 0;
 	class_datum_t *datum = 0;
 	int ret;
-
+	uint32_t value;
 
 	if (pass == 2) {
 		id = queue_remove(id_queue);
@@ -832,9 +904,12 @@
 		yyerror("no class name for class definition?");
 		return -1;
 	}
-        if (id_has_dot(id)) {
-                free(id);
-                yyerror("class identifiers may not contain periods");
+        datum = hashtab_search(policydbp->p_classes.table, id);
+        if (datum) {
+                snprintf(errormsg, ERRORMSG_LEN,
+                         "duplicate declaration for class %s\n", id);
+                free (id);
+                yyerror(errormsg);
                 return -1;
         }
 	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
@@ -843,20 +918,13 @@
 		goto bad;
 	}
 	memset(datum, 0, sizeof(class_datum_t));
-	datum->value = ++policydbp->p_classes.nprim;
 
-	ret = hashtab_insert(policydbp->p_classes.table,
-			     (hashtab_key_t) id, (hashtab_datum_t) datum);
-
-	if (ret == HASHTAB_PRESENT) {
-		--policydbp->p_classes.nprim;
-		yyerror("duplicate class definition");
-		goto bad;
-	}
-	if (ret == HASHTAB_OVERFLOW) {
+        ret = symtab_insert(policydbp, SYM_CLASSES, id, datum, &value);
+        if (ret) {
 		yyerror("hash table overflow");
-		goto bad;
+                return -1;
 	}
+        datum->value = value;
 	return 0;
 
       bad:
@@ -939,13 +1007,19 @@
 		yyerror("no common name for common perm definition?");
 		return -1;
 	}
+        comdatum = hashtab_search(policydbp->p_commons.table, id);
+        if (comdatum) {
+                snprintf(errormsg, ERRORMSG_LEN,
+                         "duplicate declaration for common %s\n", id);
+                yyerror(errormsg);
+                return -1;
+        }
 	comdatum = (common_datum_t *) malloc(sizeof(common_datum_t));
 	if (!comdatum) {
 		yyerror("out of memory");
 		goto bad;
 	}
 	memset(comdatum, 0, sizeof(common_datum_t));
-	comdatum->value = ++policydbp->p_commons.nprim;
 	ret = hashtab_insert(policydbp->p_commons.table,
 			 (hashtab_key_t) id, (hashtab_datum_t) comdatum);
 
@@ -957,6 +1031,7 @@
 		yyerror("hash table overflow");
 		goto bad;
 	}
+        comdatum->value = ++policydbp->p_commons.nprim;
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("out of memory");
 		goto bad;
@@ -1466,7 +1541,7 @@
 	char *id;
 	type_datum_t *attr;
 	int ret;
-
+	uint32_t value;
 
 	if (pass == 2) {
 		free(queue_remove(id_queue));
@@ -1493,12 +1568,14 @@
 	}
 	memset(attr, 0, sizeof(type_datum_t));
 	attr->isattr = TRUE;
-	ret = hashtab_insert(policydbp->p_types.table,
-			     id, (hashtab_datum_t) attr);
+        attr->primary = TRUE;
+        
+        ret = symtab_insert(policydbp, SYM_TYPES, id, attr, &value);
 	if (ret) {
 		yyerror("hash table overflow");
 		return -1;
 	}
+        attr->value = value;
 
 	return 0;
 }
@@ -1523,7 +1600,7 @@
 
 	t = hashtab_search(policydbp->p_types.table, id);
 	if (!t || t->isattr) {
-		sprintf(errormsg, "unknown type %s", id);
+		sprintf(errormsg, "unknown type %s, or it was already declared as an attribute", id);
 		yyerror(errormsg);
 		free(id);
 		return -1;
@@ -1544,6 +1621,12 @@
 		memset(aliasdatum, 0, sizeof(type_datum_t));
 		aliasdatum->value = t->value;
 
+                /* Type aliases are intentionally added to the global
+                   scope.  The reason is that they do not provide any
+                   new capabilities; they are still linked to its
+                   original type.  Thus, to determine the alias's
+                   scope, one must dereference to the original type
+                   and then look up that type's scope. */
 		ret = hashtab_insert(policydbp->p_types.table,
 				     (hashtab_key_t) id, (hashtab_datum_t) aliasdatum);
 
@@ -1622,7 +1705,7 @@
 	char *id;
 	type_datum_t *datum, *aliasdatum, *attr;
 	int ret, newattr = 0;
-
+	uint32_t value;
 
 	if (pass == 2) {
 		while ((id = queue_remove(id_queue))) 
@@ -1639,6 +1722,14 @@
 		yyerror("no type name for type definition?");
 		return -1;
 	}
+        datum = hashtab_search(policydbp->p_types.table, id);
+        if (datum) {
+                snprintf(errormsg, ERRORMSG_LEN,
+                         "duplicate declaration for type %s\n", id);
+                free(id);
+                yyerror(errormsg);
+                return -1;
+        }
 
 	datum = (type_datum_t *) malloc(sizeof(type_datum_t));
 	if (!datum) {
@@ -1648,25 +1739,16 @@
 	}
 	memset(datum, 0, sizeof(type_datum_t));
 	datum->primary = TRUE;
-	datum->value = ++policydbp->p_types.nprim;
 
-	ret = hashtab_insert(policydbp->p_types.table,
-			     (hashtab_key_t) id, (hashtab_datum_t) datum);
-
-	if (ret == HASHTAB_PRESENT) {
-		--policydbp->p_types.nprim;
-		free(datum);
-		sprintf(errormsg, "name conflict for type %s", id);
-		yyerror(errormsg);
-		free(id);
-		return -1;
-	}
-	if (ret == HASHTAB_OVERFLOW) {
+        ret = symtab_insert(policydbp, SYM_TYPES, (hashtab_key_t) id, (hashtab_datum_t) datum, &value);
+	if (ret) {
 		yyerror("hash table overflow");
 		free(datum);
 		free(id);
 		return -1;
 	}
+        datum->value = value;
+        datum->order = ++num_types_found;
 
 	if (alias) { 
 		while ((id = queue_remove(id_queue))) {
@@ -1677,18 +1759,8 @@
 			}
 			memset(aliasdatum, 0, sizeof(type_datum_t));
 			aliasdatum->value = datum->value;
-
-			ret = hashtab_insert(policydbp->p_types.table,
-					     (hashtab_key_t) id, (hashtab_datum_t) aliasdatum);
-
-			if (ret == HASHTAB_PRESENT) {
-				sprintf(errormsg, "name conflict for type alias %s", id);
-				yyerror(errormsg);
-				free(aliasdatum);
-				free(id);
-				return -1;
-			}
-			if (ret == HASHTAB_OVERFLOW) {
+                        ret = symtab_insert(policydbp, SYM_TYPES, id, (hashtab_datum_t) aliasdatum, NULL);
+			if (ret) {
 				yyerror("hash table overflow");
 				free(aliasdatum);
 				free(id);
@@ -1744,67 +1816,35 @@
 	return 0;
 }
 
-struct val_to_name {
-	unsigned int val;
-	char *name;
-};
-
-static int type_val_to_name_helper(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	type_datum_t *typdatum;
-	struct val_to_name *v = p;
-
-	typdatum = (type_datum_t *) datum;
-
-	if (v->val == typdatum->value) {
-		v->name = key;
-		return 1;
-	}
-
-	return 0;
-}
-
-static char *type_val_to_name(unsigned int val) 
-{
-	struct val_to_name v;
-	int rc;
-
-	v.val = val;
-	rc = hashtab_map(policydbp->p_types.table, 
-			 type_val_to_name_helper, &v);
-	if (rc)
-		return v.name;
-	return NULL;
+/* FIX ME: to be used by module requires */
+#if 0
+static int define_type_noalias(void) {
+    return define_type(0);
 }
+#endif
 
-
-static int set_types(ebitmap_t *set,
-		     ebitmap_t *negset,
+/* Adds a type, given by its textual name, to a typeset.  If *add is
+   0, then add the type to the negative set; otherwise if *add is 1
+   then add it to the positive side. */
+static int set_types(type_set_t *set,
 		     char *id,
 		     int *add)
 {
 	type_datum_t *t;
-	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
-		/* set all types not in negset */
-		for (i = 0; i < policydbp->p_types.nprim; i++) {
-			if (!ebitmap_get_bit(negset, i))
-				ebitmap_set_bit(set, i, TRUE);
-		}
+                /* set TYPE_STAR flag */
+                set->flags = TYPE_STAR;
 		free(id);
+                *add = 1;
 		return 0;
 	}
 
 	if (strcmp(id, "~") == 0) {
 		/* complement the set */
-		for (i = 0; i < policydbp->p_types.nprim; i++) {
-			if (ebitmap_get_bit(set, i))
-				ebitmap_set_bit(set, i, FALSE);
-			else 
-				ebitmap_set_bit(set, i, TRUE);
-		}
+                set->flags = TYPE_COMP;
 		free(id);
+                *add = 1;
 		return 0;
 	}
 
@@ -1816,103 +1856,73 @@
 
 	t = hashtab_search(policydbp->p_types.table, id);
 	if (!t) {
-		sprintf(errormsg, "unknown type %s", id);
+		snprintf(errormsg, ERRORMSG_LEN, "unknown type %s", id);
 		yyerror(errormsg);
 		free(id);
 		return -1;
 	}
 
-	if (t->isattr) {
-		/* set or clear all types with this attribute,
-		   but do not set anything explicitly cleared previously */
-		for (i = ebitmap_startbit(&t->types); i < ebitmap_length(&t->types); i++) {
-			if (!ebitmap_get_bit(&t->types, i)) 
-				continue;		
-			if (!(*add)) {
-				ebitmap_set_bit(set, i, FALSE);
-				ebitmap_set_bit(negset, i, TRUE);
-			} else if (!ebitmap_get_bit(negset, i)) {
-				ebitmap_set_bit(set, i, TRUE);
-#if VERBOSE
-			} else {
-				char *name = type_val_to_name(i+1);
-				sprintf(errormsg, "ignoring %s due to prior -%s", name, name);
-				yywarn(errormsg);
-#endif
-			}
-		}
-	} else {
-		/* set or clear one type, but do not set anything
-		   explicitly cleared previously */	
-		if (!(*add)) {
-			ebitmap_set_bit(set, t->value - 1, FALSE);
-			ebitmap_set_bit(negset, t->value - 1, TRUE);
-		} else if (!ebitmap_get_bit(negset, t->value - 1)) {
-			ebitmap_set_bit(set, t->value - 1, TRUE);
-#if VERBOSE
-		} else {
-			sprintf(errormsg, "ignoring %s due to prior -%s", id, id);
-			yywarn(errormsg);
-#endif
+        if (*add == 0) {
+                ebitmap_set_bit(&set->negset, t->value - 1, TRUE);
 		}
+        else {
+                ebitmap_set_bit(&set->types, t->value - 1, TRUE);
 	}
-
 	free(id);
 	*add = 1;
 	return 0;
 }
 
-
-static int define_compute_type(int which)
+static int define_compute_type_helper(int which, avrule_t **rule)
 {
 	char *id;
-	avtab_key_t avkey;
-	avtab_datum_t avdatum, *avdatump;
 	type_datum_t *datum;
 	class_datum_t *cladatum;
-	ebitmap_t stypes, ttypes, tclasses, negset;
-	uint32_t newtype = 0;
-	int ret, add = 1;
-	unsigned int i, j, k;
+	ebitmap_t tclasses;
+	avrule_t *avrule;
+	class_perm_node_t *perm;
+	int i, add = 1;
 
-	if (pass == 1) {
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		id = queue_remove(id_queue);
-		free(id);
-		return 0;
+	avrule = malloc(sizeof(avrule_t));
+	if (!avrule) {
+		yyerror("out of memory");
+		return -1;
 	}
+	avrule_init(avrule);
+        avrule->specified = which;
+        avrule->line = policydb_lineno;
 
-	ebitmap_init(&stypes);
-	ebitmap_init(&ttypes);
-	ebitmap_init(&tclasses);
-
-	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+                if (set_types(&avrule->stypes, id, &add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
-
-	ebitmap_init(&negset);
+        add = 1;
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&avrule->ttypes, id, &add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
 
+        ebitmap_init(&tclasses);
 	while ((id = queue_remove(id_queue))) {
+                uint32_t classvalue;
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
 		if (!cladatum) {
 			sprintf(errormsg, "unknown class %s", id);
 			yyerror(errormsg);
 			goto bad;
 		}
-		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);
+                if (policyvers < POLICYDB_VERSION_NLCLASS &&
+		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
+		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
+			sprintf(errormsg, "remapping class %s to netlink_socket "
+			        "for policy version %d", id, policyvers);
+			yywarn(errormsg);
+			classvalue = SECCLASS_NETLINK_SOCKET;
+                }
+                else {
+                        classvalue = cladatum->value;
+                }
+                ebitmap_set_bit(&tclasses, classvalue - 1, TRUE);
 		free(id);
 	}
 
@@ -1929,91 +1939,35 @@
 		goto bad;
 	}
 
-	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
-		if (!ebitmap_get_bit(&stypes, i)) 
-			continue;
-		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
-			if (!ebitmap_get_bit(&ttypes, j)) 
-				continue;
-			for (k = ebitmap_startbit(&tclasses); k < ebitmap_length(&tclasses); k++) {
-				if (!ebitmap_get_bit(&tclasses, k)) 
-					continue;
-				avkey.source_type = i + 1;
-				avkey.target_type = j + 1;
-				avkey.target_class = k + 1;
-				avdatump = avtab_search(&policydbp->te_avtab, &avkey, AVTAB_TYPE);
-				if (avdatump) {
-					switch (which) {
-					case AVTAB_TRANSITION:
-						newtype = avtab_transition(avdatump);
-						break;
-					case AVTAB_MEMBER:
-						newtype = avtab_member(avdatump);
-						break;
-					case AVTAB_CHANGE:
-						newtype = avtab_change(avdatump);
-						break;
-					}
-					if ( (avdatump->specified & which) &&
-					     (newtype != datum->value) ) {
-						sprintf(errormsg, "conflicting rule for (%s, %s:%s):  default was %s, is now %s", type_val_to_name(i+1), type_val_to_name(j+1), policydbp->p_class_val_to_name[k],
-							type_val_to_name(newtype),
-							type_val_to_name(datum->value));
-						yywarn(errormsg);
-					}
-					avdatump->specified |= which;
-					switch (which) {
-					case AVTAB_TRANSITION:
-						avtab_transition(avdatump) = datum->value;
-						break;
-					case AVTAB_MEMBER:
-						avtab_member(avdatump) = datum->value;
-						break;
-					case AVTAB_CHANGE:
-						avtab_change(avdatump) = datum->value;
-						break;
-					}
-				} else {
-					memset(&avdatum, 0, sizeof avdatum);
-					avdatum.specified |= which;
-					switch (which) {
-					case AVTAB_TRANSITION:
-					        avtab_transition(&avdatum) = datum->value;
-						break;
-					case AVTAB_MEMBER:
-						avtab_member(&avdatum) = datum->value;
-						break;
-					case AVTAB_CHANGE:
-						avtab_change(&avdatum) = datum->value;
-						break;
-					}
-					ret = avtab_insert(&policydbp->te_avtab, &avkey, &avdatum);
-					if (ret) {
-						yyerror("hash table overflow");
-						goto bad;
-					}
-				}
+	for (i = ebitmap_startbit(&tclasses); i < ebitmap_length(&tclasses); i++ ) {
+		if (ebitmap_get_bit(&tclasses, i)) {
+			perm = malloc(sizeof(class_perm_node_t));
+			if (!perm) {
+				yyerror("out of memory"); 
+				return -1;
 			}
+			class_perm_node_init(perm);
+			perm->class = i + 1;
+			perm->data = datum->value;
+			perm->next = avrule->perms;
+			avrule->perms = perm;
 		}
 	}
 
+        *rule = avrule;
 	return 0;
 
       bad:
+      	avrule_destroy(avrule);
+      	free(avrule);
 	return -1;
 }
 
-static cond_av_list_t *define_cond_compute_type(int which)
+static int define_compute_type(int which)
 {
 	char *id;
-	cond_av_list_t *sub_list;
-	avtab_key_t avkey;
-	avtab_datum_t avdatum, *avdatump;
-	type_datum_t *datum;
-	class_datum_t *cladatum;
-	ebitmap_t stypes, ttypes, tclasses, negset;
-	uint32_t newtype = 0;
-	int i, j, k, add = 1;
+	avrule_t *avrule;
+        int retval;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue)))
@@ -2024,217 +1978,63 @@
 			free(id);
 		id = queue_remove(id_queue);
 		free(id);
-		return (cond_av_list_t *)1; /* any non-NULL value */
-	}
-	
-	ebitmap_init(&stypes);
-	ebitmap_init(&ttypes);
-	ebitmap_init(&tclasses);
-
-	ebitmap_init(&negset);
-	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
-			return  COND_ERR;
-	}
-	ebitmap_destroy(&negset);
-
-	ebitmap_init(&negset);
-	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, &negset, id, &add))
-			return COND_ERR;
-	}
-	ebitmap_destroy(&negset);
-
-	while ((id = queue_remove(id_queue))) {
-		cladatum = hashtab_search(policydbp->p_classes.table, id);
-		if (!cladatum) {
-			sprintf(errormsg, "unknown class %s", id);
-			yyerror(errormsg);
-			goto bad;
-		}
-		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);
-		free(id);
-	}
-
-	id = (char *) queue_remove(id_queue);
-	if (!id) {
-		yyerror("no newtype?");
-		goto bad;
-	}
-	datum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
-						(hashtab_key_t) id);
-	if (!datum || datum->isattr) {
-		sprintf(errormsg, "unknown type %s", id);
-		yyerror(errormsg);
-		goto bad;
+		return 0;
 	}
 
-	/* create sub_list to be passed back and appended to true or false list */
-	sub_list = (cond_av_list_t *) 0;
-
-	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
-		if (!ebitmap_get_bit(&stypes, i)) 
-			continue;
-		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
-			if (!ebitmap_get_bit(&ttypes, j)) 
-				continue;
-			for (k = ebitmap_startbit(&tclasses); k < ebitmap_length(&tclasses); k++) {
-				if (!ebitmap_get_bit(&tclasses, k)) 
-					continue;
-				avkey.source_type = i + 1;
-				avkey.target_type = j + 1;
-				avkey.target_class = k + 1;
-				avdatump = avtab_search(&policydbp->te_avtab, &avkey, AVTAB_TYPE);
+	if (define_compute_type_helper(which, &avrule))
+		return -1;
 				
-				/* does rule exist in base policy? */
-				if ((avdatump) && (avdatump->specified & which)) {
-					switch (which) {
-					case AVTAB_TRANSITION:
-						newtype = avtab_transition(avdatump);
-						break;
-					case AVTAB_MEMBER:
-						newtype = avtab_member(avdatump);
-						break;
-					case AVTAB_CHANGE:
-						newtype = avtab_change(avdatump);
-						break;
-					}
-					if ( (newtype != datum->value) ) {
-						sprintf(errormsg, "conflicting type rule for conditional "
-							"(%s, %s:%s) in base: default is %s, conditional %s "
-							"will be ignored", 
-							type_val_to_name(i+1), 
-							type_val_to_name(j+1), 
-							policydbp->p_class_val_to_name[k],
-							type_val_to_name(newtype),
-							type_val_to_name(datum->value));
-						yywarn(errormsg);
-					} else {
-						sprintf(errormsg, "conditional type rule (%s, %s:%s): "
-							"has same default, %s, as rule in base policy; "
-							"conditional %s will be ignored", 
-							type_val_to_name(i+1), 
-							type_val_to_name(j+1), 
-							policydbp->p_class_val_to_name[k],
-							type_val_to_name(newtype),
-							type_val_to_name(datum->value));
-						yywarn(errormsg);
-					}
+	retval = insert_check_type_rule(avrule, &policydbp->te_avtab, NULL, NULL);
+	switch (retval) {
+        case 1: {
+                /* append this avrule to the end of the rules list */
+                if (last_avrule == NULL) {
+                        policydbp->avrules = last_avrule = avrule;
 				}
-				/* rule does not exist in base policy */
 				else {
-					
-					memset(&avdatum, 0, sizeof avdatum);
-					avdatum.specified |= which;
-					switch (which) {
-					case AVTAB_TRANSITION:
-					        avtab_transition(&avdatum) = datum->value;
-						break;
-					case AVTAB_MEMBER:
-						avtab_member(&avdatum) = datum->value;
-						break;
-					case AVTAB_CHANGE:
-						avtab_change(&avdatum) = datum->value;
-						break;
-					}
-					/* add rule to sub list */
-					sub_list = cond_list_append(sub_list, &avkey, &avdatum);
-					if (sub_list == COND_ERR) {
-						yyerror("list overflow");
-						goto bad;
-					}
-				}
+                        last_avrule->next = avrule;
+                        last_avrule = avrule;
 			}
+                return 0;
 		}
+        case 0: {
+                /* rule conflicted, so don't actually add this rule */
+                avrule_destroy(avrule);
+                free(avrule);
+                return 0;
 	}
-	
-	return sub_list;
-
-      bad:
-	return COND_ERR;
-}
-
-static cond_av_list_t *cond_list_append(cond_av_list_t *sl, avtab_key_t *key, avtab_datum_t *datum) {
-
-	cond_av_list_t  *n, *end;
-
-	n = (cond_av_list_t *) malloc(sizeof(cond_av_list_t));
-	if (!n) {
-		  yyerror("out of memory");
-		  return COND_ERR;
+        case -1: {
+                avrule_destroy(avrule);
+                free(avrule);
+                return -1;
 	}
-	memset(n, 0, sizeof(cond_av_list_t));
-	if (sl) {
-		for(end=sl; end->next != NULL; end = end->next);
-		end->next = n;
+        default: {
+                assert(0); /* should never get here */
 	}
-	else sl = n;
-	n->next = NULL;
-	
-	/* construct new node */
-	n->node = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
-	if (!n->node) {
-		yyerror("out of memory");
-		return COND_ERR;
 	}
-	memset(n->node, 0, sizeof(struct avtab_node));
-	n->node->key = *key;
-	n->node->datum = *datum;
-	/* the next two fields get filled in when we add to true/false list  */
-	n->node->next = (avtab_ptr_t) 0;
-	n->node->parse_context = (void *) 0;
-	
-	return(sl);
 }
 
-
-static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static avrule_t *define_cond_compute_type(int which)
 {
-	struct val_to_name *v = data;
-	perm_datum_t *perdatum;
-
-	perdatum = (perm_datum_t *) datum;
+	char *id;
+	avrule_t *avrule;
 
-	if (v->val == perdatum->value) {
-		v->name = key;
-		return 1;
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		id = queue_remove(id_queue);
+		free(id);
+		return (avrule_t*)1;
 	}
 
-	return 0;
-}
-
-
-char *av_to_string(uint32_t tclass, sepol_access_vector_t av)
-{
-	struct val_to_name v;
-	static char avbuf[1024];
-	class_datum_t *cladatum;
-	char *perm = NULL, *p;
-	unsigned int i;
-	int rc;
-
-	cladatum = policydbp->class_val_to_struct[tclass-1];
-	p = avbuf;
-	for (i = 0; i < cladatum->permissions.nprim; i++) {
-		if (av & (1 << i)) {
-			v.val = i+1;
-			rc = hashtab_map(cladatum->permissions.table,
-					 perm_name, &v);
-			if (!rc && cladatum->comdatum) {
-				rc = hashtab_map(
-					cladatum->comdatum->permissions.table,
-					perm_name, &v);
-			}
-			if (rc)
-				perm = v.name;
-			if (perm) {
-				sprintf(p, " %s", perm);
-				p += strlen(p);
-			}
-		}
-	}
+	if (define_compute_type_helper(which, &avrule))
+		return COND_ERR;
 
-	return avbuf;
+	return avrule;
 }
 
 static int define_bool()
@@ -2242,7 +2042,7 @@
 	char *id, *name;
 	cond_bool_datum_t *datum;
 	int ret;
-
+	uint32_t value;
 
 	if (pass == 2) {
 		while ((id = queue_remove(id_queue)))
@@ -2262,10 +2062,20 @@
         }
 	name = id;
 
+        datum = hashtab_search(policydbp->p_bools.table, name);
+        if (datum) {
+                snprintf(errormsg, ERRORMSG_LEN, 
+                         "duplicate declaration for bool %s\n", id);
+                free(id);
+                yyerror(errormsg);
+                return -1;
+        }
+
 	id = (char *) queue_remove(id_queue);
 	if (!id) {
 		yyerror("no default value for bool definition?");
 		free(name);
+                /* FIX ME: allow this if in a module's require section */
 		return -1;
 	}
 
@@ -2278,213 +2088,74 @@
 	}
 	memset(datum, 0, sizeof(cond_bool_datum_t));
 	datum->state = (int)(id[0] == 'T') ? 1 : 0;
-	datum->value = ++policydbp->p_bools.nprim;
-
-	ret = hashtab_insert(policydbp->p_bools.table,
-			     (hashtab_key_t) name, (hashtab_datum_t) datum);
+        ret = symtab_insert(policydbp, SYM_BOOLS, name, datum, &value);
 
-	if (ret == HASHTAB_PRESENT) {
-		--policydbp->p_bools.nprim;
-		free(datum);
-		sprintf(errormsg, "name conflict for bool %s", id);
-		yyerror(errormsg);
-		free(id);
-		free(name);
-		return -1;
-	}
-	if (ret == HASHTAB_OVERFLOW) {
+	if (ret) {
 		yyerror("hash table overflow");
 		free(datum);
 		free(id);
 		free(name);
 		return -1;
 	}
+	datum->value = value;
+
 	return 0;
 }
 
-static cond_av_list_t *define_cond_pol_list( cond_av_list_t *avlist, cond_av_list_t *sl )
+static avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *sl)
 {
-	cond_av_list_t *end;
-
 	if (pass == 1) {
 		/* return something so we get through pass 1 */
-		return (cond_av_list_t *)1;
-	}
-
-	/* if we've started collecting sub lists, prepend to start of collection
-	   because it's probably less iterations than appending. */
-	if (!sl) return avlist;
-	else if (!avlist) return sl;
-	else {
-		end = sl;
-		while (end->next) end = end->next;
-		end->next = avlist;
-	} 
-	return sl;
-}
-
-static int te_avtab_helper(int which, unsigned int stype, unsigned int ttype, 
-			   ebitmap_t *tclasses, sepol_access_vector_t *avp)
-
-{
-	avtab_key_t avkey;
-	avtab_datum_t avdatum, *avdatump;
-	int ret;
-	unsigned int k;
-
-	if (which == -AVTAB_ALLOWED) {
-		yyerror("neverallow should not reach this function.");
-		return -1;
-	}
-
-	for (k = ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++) {
-		if (!ebitmap_get_bit(tclasses, k)) 
-			continue;
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = k + 1;
-		avdatump = avtab_search(&policydbp->te_avtab, &avkey, AVTAB_AV);
-		if (!avdatump) {
-			memset(&avdatum, 0, sizeof avdatum);
-			avdatum.specified = (which > 0) ? which : -which;
-			ret = avtab_insert(&policydbp->te_avtab, &avkey, &avdatum);
-			if (ret) {
-				yyerror("hash table overflow");
-				return -1;
-			}
-			avdatump = avtab_search(&policydbp->te_avtab, &avkey, AVTAB_AV);
-			if (!avdatump) {
-				yyerror("inserted entry vanished!");
-				return -1;
-			}
-		}
-
-		avdatump->specified |= ((which > 0) ? which : -which);
-
-		switch (which) {
-		case AVTAB_ALLOWED:
-			avtab_allowed(avdatump) |= avp[k];
-			break;
-		case AVTAB_AUDITALLOW:
-			avtab_auditallow(avdatump) |= avp[k];
-			break;
-		case AVTAB_AUDITDENY:
-			avtab_auditdeny(avdatump) |= avp[k];
-			break;
-		case -AVTAB_AUDITDENY:
-			if (avtab_auditdeny(avdatump))
-				avtab_auditdeny(avdatump) &= ~avp[k];
-			else
-				avtab_auditdeny(avdatump) = ~avp[k];
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static  cond_av_list_t *cond_te_avtab_helper(int which, int stype, int ttype, 
-			   ebitmap_t *tclasses, sepol_access_vector_t *avp )
-
-{
-	cond_av_list_t *sl;
-	avtab_key_t avkey;
-	avtab_datum_t avdatum;
-	int  k;
-
-	if (which == -AVTAB_ALLOWED) {
-		yyerror("neverallow should not reach this function.");
-		return COND_ERR;
-	}
-
-	/* create sub_list to be passed back and appended to true or false list */
-	sl = (cond_av_list_t *) 0;
-
-	for (k = ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++) {
-		if (!ebitmap_get_bit(tclasses, k)) 
-			continue;
-		/* build the key */
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = k + 1;
-		
-		/* build the datum */
-		memset(&avdatum, 0, sizeof avdatum);
-		avdatum.specified = (which > 0) ? which : -which;
-
-		switch (which) {
-		case AVTAB_ALLOWED:
-			avtab_allowed(&avdatum) = avp[k];
-			break;
-		case AVTAB_AUDITALLOW:
-			avtab_auditallow(&avdatum) = avp[k];
-			break;
-		case AVTAB_AUDITDENY:
-			yyerror("AUDITDENY statements are not allowed in a conditional block; use DONTAUDIT");
-			return COND_ERR;
-		case -AVTAB_AUDITDENY:
-			avtab_auditdeny(&avdatum) = ~avp[k];
-			break;
-		}
-
-		/* add to temporary list */
-		sl = cond_list_append(sl, &avkey, &avdatum);
-
-		if (sl == COND_ERR) {
-			yyerror("list overflow");
-			return COND_ERR;
-		}
+		return (avrule_t *)1;
 	}
 
+        /* prepend the new avlist to the pre-existing one */
+        sl->next = avlist;
 	return sl;
 }
 
-static cond_av_list_t *define_cond_te_avtab(int which)
+static int define_te_avtab_helper(int which, avrule_t **rule)
 {
 	char *id;
-	cond_av_list_t *sub_list, *final_list, *tail;
 	class_datum_t *cladatum;
-	perm_datum_t *perdatum;
-	ebitmap_t stypes, ttypes, tclasses, negset;
-	sepol_access_vector_t *avp;
-	int i, j, hiclass, self = 0, add = 1;
+	perm_datum_t *perdatum = NULL;
+	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
+	ebitmap_t tclasses;
+	avrule_t *avrule;
+	unsigned int i, hiclass;
+	int add = 1, ret = 0;
 	int suppress = 0;
 
-	if (pass == 1) {
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		return (cond_av_list_t *) 1; /* any non-NULL value */
+	avrule = (avrule_t*)malloc(sizeof(avrule_t));
+	if (!avrule) {
+		yyerror("memory error");
+		ret = -1;
+		goto out;
 	}
+	avrule_init(avrule);
+        avrule->specified = which;
+        avrule->line = policydb_lineno;
 
-	ebitmap_init(&stypes);
-	ebitmap_init(&ttypes);
-	ebitmap_init(&tclasses);
-
-	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
-			return COND_ERR;
+		if (set_types(&avrule->stypes, id, &add)) {
+			ret = -1;
+			goto out;
 	}
-	ebitmap_destroy(&negset);
-
-	ebitmap_init(&negset);
+	}
+        add = 1;
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
-			self = 1;
+			avrule->flags |= RULE_SELF;
 			continue;
 		}
-		if (set_types(&ttypes, &negset, id, &add))
-			return COND_ERR;
+		if (set_types(&avrule->ttypes, id, &add)) {
+			ret = -1;
+			goto out;
+		}
 	}
-	ebitmap_destroy(&negset);
 
 	hiclass = 0;
+	ebitmap_init(&tclasses);
 	while ((id = queue_remove(id_queue))) {
 		uint32_t classvalue;
 
@@ -2492,9 +2163,9 @@
 		if (!cladatum) 	{
 			sprintf(errormsg, "unknown class %s used in rule", id);
 			yyerror(errormsg);
-			goto bad;
+			ret = -1;
+			goto out;
 		}
-		
 		if (policyvers < POLICYDB_VERSION_NLCLASS &&
 		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
 		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
@@ -2512,14 +2183,27 @@
 		free(id);
 	}
 
-	avp = malloc(hiclass * sizeof(sepol_access_vector_t));
-	if (!avp) {
+	perms = NULL;
+	for (i = ebitmap_startbit(&tclasses); i < ebitmap_length(&tclasses); i++) {
+		if (!ebitmap_get_bit(&tclasses, i))
+			continue;
+		cur_perms = (class_perm_node_t *)malloc(sizeof(class_perm_node_t));
+		if (!cur_perms) {
 		yyerror("out of memory");
-		return COND_ERR;
+			ret = -1;
+			goto out;
 	}
-	for (i = 0; i < hiclass; i++)
-		avp[i] = 0;
+		class_perm_node_init(cur_perms);
+		cur_perms->class = i + 1;
+		if (!perms)
+			perms = cur_perms;
+		if (tail)
+			tail->next = cur_perms;
+		tail = cur_perms;
+	}
+
 	while ((id = queue_remove(id_queue))) {
+		cur_perms = perms;
 		for (i = ebitmap_startbit(&tclasses); i < ebitmap_length(&tclasses); i++) {
 			if (!ebitmap_get_bit(&tclasses, i)) 
 				continue;
@@ -2527,20 +2211,19 @@
 
 			if (strcmp(id, "*") == 0) {
 				/* set all permissions in the class */
-				avp[i] = ~0;
-				continue;
+				cur_perms->data = ~0U;
+				goto next;
 			}
 
 			if (strcmp(id, "~") == 0) {
 				/* complement the set */
-				if (which == -AVTAB_AUDITDENY) 
+				if (which == AVRULE_DONTAUDIT) 
 					yywarn("dontaudit rule with a ~?");
-				avp[i] = ~avp[i];
-				continue;
+				cur_perms->data = ~cur_perms->data;
+				goto next;
 			}
 
-			perdatum = hashtab_search(cladatum->permissions.table,
-						  id);
+			perdatum = hashtab_search(cladatum->permissions.table, id);
 			if (!perdatum) {
 				if (cladatum->comdatum) {
 					perdatum = hashtab_search(cladatum->comdatum->permissions.table,
@@ -2552,272 +2235,116 @@
 				if (!suppress)
 				  yyerror(errormsg);
 				continue;
-			}
-
-			avp[i] |= (1 << (perdatum->value - 1));
-		}
-
-		free(id);
-	}
-
-	sub_list = NULL;
-	tail = NULL;
-	final_list = NULL;
-
-	if (self) {
-		for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
-			if (!ebitmap_get_bit(&stypes, i)) 
-				continue;
-			if (self) {
-				if ((sub_list = cond_te_avtab_helper(which, i, i, &tclasses, avp )) == COND_ERR)
-					return COND_ERR;
-				if (final_list) {
-					tail->next = sub_list;
-					while (tail->next != NULL)
-						tail = tail->next;
 				} else {
-					final_list = sub_list;
-					tail = final_list;
-					while (tail->next != NULL)
-						tail = tail->next;
-				}
-			}
-		}
-	}
-	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
-		if (!ebitmap_get_bit(&stypes, i)) 
-			continue;
-		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
-			if (!ebitmap_get_bit(&ttypes, j)) 
-				continue;
-			if ((sub_list = cond_te_avtab_helper(which, i, j, &tclasses, avp)) == COND_ERR)
-				return COND_ERR;
-			if (final_list) {
-				tail->next = sub_list;
-				while (tail->next != NULL)
-					tail = tail->next;
-			} else {
-				final_list = sub_list;
-				tail = final_list;
-				while (tail->next != NULL)
-					tail = tail->next;
+                                cur_perms->data |= 1U << (perdatum->value - 1);
 			}
+next:
+                        cur_perms = cur_perms->next;
 		}
+		free(id);
 	}
 
-	ebitmap_destroy(&stypes);
-	ebitmap_destroy(&ttypes);
-	ebitmap_destroy(&tclasses);
-	free(avp);
+        avrule->perms = perms;
+        *rule = avrule;
 	
-	return final_list;
- bad:
-	return COND_ERR;
+out:
+	return ret;
 }
 
-
-static int define_te_avtab(int which)
+static avrule_t *define_cond_te_avtab(int which)
 {
 	char *id;
-	class_datum_t *cladatum;
-	perm_datum_t *perdatum;
-	ebitmap_t stypes, ttypes, tclasses, negset;
-	sepol_access_vector_t *avp;
-	unsigned int i, j, hiclass;
-	int self = 0, add = 1;
-	te_assert_t *newassert;
-	int suppress = 0;
+	avrule_t *avrule;
+	int i;
 
 	if (pass == 1) {
+		for (i = 0; i < 4; i++) {
 		while ((id = queue_remove(id_queue))) 
 			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		while ((id = queue_remove(id_queue))) 
-			free(id);
-		return 0;
 	}
-
-	ebitmap_init(&stypes);
-	ebitmap_init(&ttypes);
-	ebitmap_init(&tclasses);
-
-	ebitmap_init(&negset);
-	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
-			return -1;
-	}
-	ebitmap_destroy(&negset);
-
-	ebitmap_init(&negset);
-	while ((id = queue_remove(id_queue))) {
-		if (strcmp(id, "self") == 0) {
-			self = 1;
-			continue;
-		}
-		if (set_types(&ttypes, &negset, id, &add))
-			return -1;
+		return (avrule_t *) 1; /* any non-NULL value */
 	}
-	ebitmap_destroy(&negset);
 
-	hiclass = 0;
-	while ((id = queue_remove(id_queue))) {
-		uint32_t classvalue;
+	if (define_te_avtab_helper(which, &avrule))
+		return COND_ERR;
 
-		cladatum = hashtab_search(policydbp->p_classes.table, id);
-		if (!cladatum) {
-			sprintf(errormsg, "unknown class %s used in rule", id);
-			yyerror(errormsg);
-			goto bad;
-		}
+	return avrule;
+}
 		
-		if (policyvers < POLICYDB_VERSION_NLCLASS &&
-		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
-		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
-			sprintf(errormsg, "remapping class %s to netlink_socket "
-			        "for policy version %d", id, policyvers);
-			yywarn(errormsg);
-			classvalue = SECCLASS_NETLINK_SOCKET;
-			suppress = 1;
-		} else
-			classvalue = cladatum->value;
+static int define_te_avtab(int which)
+{
+	char *id;
+	avrule_t *avrule;
+	int i;
 				
-		ebitmap_set_bit(&tclasses, classvalue - 1, TRUE);	
-		if (classvalue > hiclass)
-			hiclass = classvalue;
+	if (pass == 1) {
+		for (i = 0; i < 4; i++) {
+			while ((id = queue_remove(id_queue))) 
 		free(id);
 	}
-
-	avp = malloc(hiclass * sizeof(sepol_access_vector_t));
-	if (!avp) {
-		yyerror("out of memory");
-		return -1;
-	}
-	for (i = 0; i < hiclass; i++)
-		avp[i] = 0;
-
-	while ((id = queue_remove(id_queue))) {
-		for (i = ebitmap_startbit(&tclasses); i < ebitmap_length(&tclasses); i++) {
-			if (!ebitmap_get_bit(&tclasses, i)) 
-				continue;
-			cladatum = policydbp->class_val_to_struct[i];
-
-			if (strcmp(id, "*") == 0) {
-				/* set all permissions in the class */
-				avp[i] = ~0U;
-				continue;
+		return 0;
 			}
 
-			if (strcmp(id, "~") == 0) {
-				/* complement the set */
-				if (which == -AVTAB_AUDITDENY) 
-					yywarn("dontaudit rule with a ~?");
-				avp[i] = ~avp[i];
-				continue;
-			}
+	if (define_te_avtab_helper(which, &avrule))
+		return -1;
 
-			perdatum = hashtab_search(cladatum->permissions.table,
-						  id);
-			if (!perdatum) {
-				if (cladatum->comdatum) {
-					perdatum = hashtab_search(cladatum->comdatum->permissions.table,
-								  id);
-				}
-			}
-			if (!perdatum) {
-				sprintf(errormsg, "permission %s is not defined for class %s", id, policydbp->p_class_val_to_name[i]);
-				if (!suppress)
-				  yyerror(errormsg);
-				continue;
+        /* append this avrule to the end of the rules list */
+        if (last_avrule == NULL) {
+                policydbp->avrules = last_avrule = avrule;
 			}
-
-			avp[i] |= (1 << (perdatum->value - 1));
+        else {
+                last_avrule->next = avrule;
+                last_avrule = avrule;
 		}
+	return 0;
+}
 
-		free(id);
-	}
+static int define_role(char *id)
+{
+	role_datum_t *role;
+	uint32_t value;
+	int ret;
 
-	if (which == -AVTAB_ALLOWED) {
-		newassert = malloc(sizeof(te_assert_t));
-		if (!newassert) {
+	role = (role_datum_t *) hashtab_search(policydbp->p_roles.table,
+					       id);
+	if (!role) {
+		role = (role_datum_t *) malloc(sizeof(role_datum_t));
+		if (!role) {
 			yyerror("out of memory");
+			free(id);
 			return -1;
 		}
-		memset(newassert, 0, sizeof(te_assert_t));
-		newassert->stypes = stypes;
-		newassert->ttypes = ttypes;
-		newassert->tclasses = tclasses;
-		newassert->self = self;
-		newassert->avp = avp;
-		newassert->line = policydb_lineno;
-		newassert->next = te_assertions;
-		te_assertions = newassert;
-		return 0;
-	}
-
-	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
-		if (!ebitmap_get_bit(&stypes, i)) 
-			continue;
-		if (self) {
-			if (te_avtab_helper(which, i, i, &tclasses, avp))
-				return -1;
-		}
-		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
-			if (!ebitmap_get_bit(&ttypes, j)) 
-				continue;
-			if (te_avtab_helper(which, i, j, &tclasses, avp))
-				return -1;
-		}
-	}
+		role_datum_init(role);
 
-	ebitmap_destroy(&stypes);
-	ebitmap_destroy(&ttypes);
-	ebitmap_destroy(&tclasses);
-	free(avp);
+		ret = symtab_insert(policydbp, SYM_ROLES, id, (hashtab_datum_t*)role, &value);
 
-	return 0;
- bad:
+		if (ret) {
+			yyerror("hash table overflow");
+			free(role);
 	return -1;
-}
-
-
-static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	struct val_to_name *v = p;
-	role_datum_t *roldatum;
-
-	roldatum = (role_datum_t *) datum;
-
-	if (v->val == roldatum->value) {
-		v->name = key;
-		return 1;
 	}
 
+		role->value = value;
+		ebitmap_set_bit(&role->dominates, value - 1, TRUE);
+        }
 	return 0;
 }
 
-
-static char *role_val_to_name(unsigned int val) 
+/* FIX ME: to be used by module requires */
+#if 0
+static int define_role_require(void)
 {
-	struct val_to_name v;
-	int rc;
-
-	v.val = val;
-	rc = hashtab_map(policydbp->p_roles.table, 
-			 role_val_to_name_helper, &v);
-	if (rc)
-		return v.name;
-	return NULL;
+        char *id = queue_remove(id_queue);
+        int retval = define_role(id);
+        return retval;
 }
+#endif
 
 static int define_role_types(void)
 {
 	role_datum_t *role;
-	char *role_id, *id;
-	int ret, add = 1;
-	ebitmap_t negset;
+	char *id;
+	int add = 1;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2825,43 +2352,19 @@
 		return 0;
 	}
 
-	role_id = queue_remove(id_queue);
-
-	role = (role_datum_t *) hashtab_search(policydbp->p_roles.table,
-					       role_id);
-	if (!role) {
-		role = (role_datum_t *) malloc(sizeof(role_datum_t));
-		if (!role) {
-			yyerror("out of memory");
-			free(role_id);
-			return -1;
-		}
-		memset(role, 0, sizeof(role_datum_t));
-		role->value = ++policydbp->p_roles.nprim;
-		ebitmap_set_bit(&role->dominates, role->value-1, TRUE);
-		ret = hashtab_insert(policydbp->p_roles.table,
-				     (hashtab_key_t) role_id, (hashtab_datum_t) role);
-
-		if (ret) {
-			yyerror("hash table overflow");
-			free(role);
-			free(role_id);
+	id = queue_remove(id_queue);
+        if (define_role(id))
 			return -1;
-		}
-	} else
-		free(role_id);
-
-	ebitmap_init(&negset);
+	role = (role_datum_t *) hashtab_search(policydbp->p_roles.table,
+					       id);
+        assert(role);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&role->types, &negset, id, &add))
+                if (set_types(&role->types, id,&add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
-
 	return 0;
 }
 
-
 static role_datum_t *
  merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
 {
@@ -2882,20 +2385,20 @@
 		yyerror("out of memory");
 		return NULL;
 	}
-	if (ebitmap_or(&new->types, &r1->types, &r2->types)) {
+	if (ebitmap_or(&new->types.types, &r1->types.types, &r2->types.types)) {
 		yyerror("out of memory");
 		return NULL;
 	}
 	if (!r1->value) {
 		/* free intermediate result */
-		ebitmap_destroy(&r1->types);
+		type_set_destroy(&r1->types);
 		ebitmap_destroy(&r1->dominates);
 		free(r1);
 	}
 	if (!r2->value) {
 		/* free intermediate result */
 		yyerror("right hand role is temporary?");
-		ebitmap_destroy(&r2->types);
+		type_set_destroy(&r2->types);
 		ebitmap_destroy(&r2->dominates);
 		free(r2);
 	}
@@ -2907,6 +2410,7 @@
 {
 	role_datum_t *rdp = (role_datum_t *) arg;
 	role_datum_t *rdatum = (role_datum_t *) datum;
+	ebitmap_t *types = NULL;
 	int i;
 
 	/* Don't bother to process against self role */
@@ -2916,6 +2420,8 @@
 	/* If a dominating role found */
 	if (ebitmap_get_bit(&(rdatum->dominates), rdp->value - 1))
 	{
+		if (type_set_expand(&rdp->types, types, policydbp)) 
+			return -1;
 		/* raise types and dominates from dominated role */
 		for (i = ebitmap_startbit(&rdp->dominates); 
 			i < ebitmap_length(&rdp->dominates); i++) 
@@ -2923,11 +2429,11 @@
 			if (ebitmap_get_bit(&rdp->dominates, i))
 				ebitmap_set_bit(&rdatum->dominates, i, TRUE);
 		}
-		for (i = ebitmap_startbit(&rdp->types); 
-			i < ebitmap_length(&rdp->types); i++)	
+		for (i = ebitmap_startbit(types); 
+			i < ebitmap_length(types); i++)	
 		{
-			if (ebitmap_get_bit(&rdp->types, i))
-				ebitmap_set_bit(&rdatum->types, i, TRUE);
+			if (ebitmap_get_bit(types, i))
+				ebitmap_set_bit(&rdatum->types.types, i, TRUE);
 		}		
 	}
 
@@ -2940,6 +2446,7 @@
 {
 	role_datum_t *role;
 	char *role_id;
+	ebitmap_t *types = NULL;
 	unsigned int i;
 	int ret;
 
@@ -2977,13 +2484,15 @@
 			if (ebitmap_get_bit(&r->dominates, i))
 				ebitmap_set_bit(&role->dominates, i, TRUE);
 		}
-		for (i = ebitmap_startbit(&r->types); i < ebitmap_length(&r->types); i++)	{
-			if (ebitmap_get_bit(&r->types, i))
-				ebitmap_set_bit(&role->types, i, TRUE);
+		if (type_set_expand(&r->types, types, policydbp)) 
+			return NULL;
+		for (i = ebitmap_startbit(types); i < ebitmap_length(types); i++)	{
+			if (ebitmap_get_bit(types, i))
+				ebitmap_set_bit(&role->types.types, i, TRUE);
 		}
 		if (!r->value) {
 			/* free intermediate result */
-			ebitmap_destroy(&r->types);
+			type_set_destroy(&r->types);
 			ebitmap_destroy(&r->dominates);
 			free(r);
 		}
@@ -2997,29 +2506,21 @@
 	return role;
 }
 
-
-static int set_roles(ebitmap_t *set,
+static int set_roles(role_set_t *set,
 		     char *id)
 {
 	role_datum_t *r;
-	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) 
-			ebitmap_set_bit(set, i, TRUE);
+		set->flags = ROLE_STAR;
 		free(id);
 		return 0;
 	}
 
 	if (strcmp(id, "~") == 0) {
 		/* complement the set */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) {
-			if (ebitmap_get_bit(set, i))
-				ebitmap_set_bit(set, i, FALSE);
-			else 
-				ebitmap_set_bit(set, i, TRUE);
-		}
+		set->flags = ROLE_COMP;
 		free(id);
 		return 0;
 	}
@@ -3032,19 +2533,20 @@
 		return -1;
 	}
 
-	/* set one role */
-	ebitmap_set_bit(set, r->value - 1, TRUE);
+        ebitmap_set_bit(&set->roles, r->value - 1, TRUE);
 	free(id);
 	return 0;
 }
 
-
 static int define_role_trans(void)
 {
 	char *id;
 	role_datum_t *role;
-	ebitmap_t roles, types, negset;
-	struct role_trans *tr = 0;
+	role_set_t roles;
+	type_set_t types;
+	ebitmap_t e_types, e_roles;
+	struct role_trans *tr = NULL;
+	struct role_trans_rule *rule = NULL;
 	unsigned int i, j;
 	int add = 1;
 
@@ -3058,20 +2560,20 @@
 		return 0;
 	}
 
-	ebitmap_init(&roles);
-	ebitmap_init(&types);
+	role_set_init(&roles);
+	ebitmap_init(&e_roles);
+	type_set_init(&types);
+	ebitmap_init(&e_types);
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_roles(&roles, id))
 			return -1;
 	}
-
-	ebitmap_init(&negset);
+        add = 1;
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, id, &add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
 
 	id = (char *) queue_remove(id_queue);
 	if (!id) {
@@ -3085,17 +2587,24 @@
 		goto bad;
 	}
 
-	for (i = ebitmap_startbit(&roles); i < ebitmap_length(&roles); i++) {
-		if (!ebitmap_get_bit(&roles, i)) 
+	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
+	if (role_set_expand(&roles, &e_roles, policydbp))
+		goto bad;
+		
+	if (type_set_expand(&types, &e_types, policydbp))
+		goto bad;
+
+	for (i = ebitmap_startbit(&e_roles); i < ebitmap_length(&e_roles); i++) {
+		if (!ebitmap_get_bit(&e_roles, i)) 
 			continue;
-		for (j = ebitmap_startbit(&types); j < ebitmap_length(&types); j++) {
-			if (!ebitmap_get_bit(&types, j)) 
+		for (j = ebitmap_startbit(&e_types); j < ebitmap_length(&e_types); j++) {
+			if (!ebitmap_get_bit(&e_types, j))
 				continue;
 
 			for (tr = policydbp->role_tr; tr; tr = tr->next) {
 				if (tr->role == (i+1) && tr->type == (j+1)) {
 					sprintf(errormsg, "duplicate role transition defined for (%s,%s)", 
-						role_val_to_name(i+1), type_val_to_name(j+1));
+						policydbp->p_role_val_to_name[i], policydbp->p_type_val_to_name[j]);
 					yyerror(errormsg);
 					goto bad;
 				}
@@ -3112,8 +2621,26 @@
 			tr->new_role = role->value;
 			tr->next = policydbp->role_tr;
 			policydbp->role_tr = tr;
+
+		}
 		}
+
+	/* Now add the real rule */
+	rule = malloc(sizeof(struct role_trans_rule));
+	if (!rule) {
+		yyerror("out of memory");
+		return -1;
 	}
+	memset(rule, 0, sizeof(struct role_trans_rule));
+	rule->roles = roles;
+	rule->types = types;
+	rule->new_role = role->value;
+			
+        rule->next = policydbp->role_tr_rules;
+        policydbp->role_tr_rules = rule;
+
+	ebitmap_destroy(&e_roles);
+	ebitmap_destroy(&e_types);
 
 	return 0;
 
@@ -3121,13 +2648,10 @@
 	return -1;
 }
 
-
 static int define_role_allow(void)
 {
 	char *id;
-	ebitmap_t roles, new_roles;
-	struct role_allow *ra = 0;
-	unsigned int i, j;
+	struct role_allow_rule *ra = 0;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -3137,47 +2661,25 @@
 		return 0;
 	}
 
-	ebitmap_init(&roles);
-	ebitmap_init(&new_roles);
-
-	while ((id = queue_remove(id_queue))) {
-		if (set_roles(&roles, id))
+	ra = malloc(sizeof(role_allow_rule_t));
+	if (!ra) {
+		yyerror("out of memory");
 			return -1;
 	}
-
+	role_allow_rule_init(ra);
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_roles(&new_roles, id))
+		if (set_roles(&ra->roles, id))
 			return -1;
 	}
 
-	for (i = ebitmap_startbit(&roles); i < ebitmap_length(&roles); i++) {
-		if (!ebitmap_get_bit(&roles, i)) 
-			continue;
-		for (j = ebitmap_startbit(&new_roles); j < ebitmap_length(&new_roles); j++) {
-			if (!ebitmap_get_bit(&new_roles, j)) 
-				continue;
-
-			for (ra = policydbp->role_allow; ra; ra = ra->next) {
-				if (ra->role == (i+1) && ra->new_role == (j+1))
-					break;
-			}
-
-			if (ra) 
-				continue;
-
-			ra = malloc(sizeof(struct role_allow));
-			if (!ra) {
-				yyerror("out of memory");
+	while ((id = queue_remove(id_queue))) {
+		if (set_roles(&ra->new_roles, id))
 				return -1;
 			}
-			memset(ra, 0, sizeof(struct role_allow));
-			ra->role = i+1;
-			ra->new_role = j+1;
-			ra->next = policydbp->role_allow;
-			policydbp->role_allow = ra;
-		}
-	}
+
+        ra->next = policydbp->role_allow_rules;
+        policydbp->role_allow_rules = ra;
 
 	return 0;
 }
@@ -3399,10 +2901,10 @@
 	struct constraint_expr *expr, *e1 = NULL, *e2;
 	user_datum_t *user;
 	role_datum_t *role;
+        type_datum_t *type;
 	ebitmap_t negset;
 	char *id;
 	uint32_t val;
-	int add = 1;
 
 	if (pass == 1) {
 		if (expr_type == CEXPR_NAMES) {
@@ -3493,11 +2995,15 @@
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
-				if (set_types(&expr->names, &negset, id, &add)) {
+				type = (type_datum_t *) hashtab_search(policydbp->p_types.table,
+									(hashtab_key_t) id);
+				if (!type) {
+					sprintf(errormsg, "unknown type %s", id);
+					yyerror(errormsg);
 					free(expr);
 					return 0;
 				}
-				continue;
+                                val = type->value;
 			} else {
 				yyerror("invalid constraint expression");
 				free(expr);
@@ -3524,12 +3030,12 @@
 	return 0;
 }
 
-static int define_conditional(cond_expr_t *expr, cond_av_list_t *t, cond_av_list_t *f )
+static int define_conditional(cond_expr_t *expr, avrule_t *t, avrule_t *f )
 {
 	cond_expr_t *e;
-	cond_node_t *cn, tmp, *cn_new;
-	int depth;
-
+	int depth, retval;
+        cond_node_t cn, *cn_old;
+        avrule_t *tmp, *last_tmp;
 
 	/* expression cannot be NULL */
 	if ( !expr) {
@@ -3590,169 +3096,128 @@
 	}
 
         /*  use tmp conditional node to partially build new node */
-	cn = &tmp;
-	cn->expr = expr;
-	cn->true_list = t;
-	cn->false_list = f;
+        memset(&cn, 0, sizeof(cn));
+        cn.expr = expr;
+        cn.avtrue_list = t;
+        cn.avfalse_list = f;
       
 	/* normalize/precompute expression */
-	if (cond_normalize_expr(policydbp, cn) < 0) {
+	if (cond_normalize_expr(policydbp, &cn) < 0) {
 		yyerror("problem normalizing conditional expression");
 		return -1;
 	}
 
 	/* get the existing conditional node, or a new one*/
-	cn_new = cond_node_search(policydbp, cn);
-	if(cn_new) {
-		cond_reduce_insert_list (cn->true_list, &cn_new->true_list, &cn_new->false_list, cn_new->cur_state);
-		cond_reduce_insert_list (cn->false_list, &cn_new->false_list, &cn_new->true_list, !cn_new->cur_state);
-	} else { 
-		yyerror("could not get a conditional node");
+        cn_old = cond_node_search(policydbp, policydbp->cond_list, &cn);
+        if (!cn_old) {
 		return -1;
 	}
 
-
-	return 0;
-}
-
-
-/*  Set the ENABLE bit and parse_context for each rule and check rules to see if they already exist.
- * Insert rules into the conditional db when appropriate.
- *  
- * new - list of rules to potentially add/insert
- * active - list to add rule to, and address to use as parse_context
- * inactive - opposite rule list in same conditional
- * state - whether rules in new are on or off by default.
- *
- * There are 4 possible conditions for a TYPE_* rule.  Allow rules are always inserted or
- * OR'd with existing allow rules on the same side of the same conditional.
- *
- * 1) Not present anywhere -> add it
- * 2) Already in cond, same side -> warn, replace default in prev rule, delete this rule
- * 3) Just added to opp side -> search again (we may still add this rule)
- * 4) In another conditional (either side) -> warn, delete this rule
- */
-static void cond_reduce_insert_list(cond_av_list_t *new, cond_av_list_t **active, cond_av_list_t **inactive, int state)
-{
-	int add_rule = 1;
-	cond_av_list_t *c, *top;
-	avtab_ptr_t dup;
-	uint32_t old_data = 0, new_data = 0;
-
-	top = c = new; 
-	/* loop through all the rules in the list */
-	while(c) {
-
-                /* is conditional rule a TYPE_* rule that's already in a conditional? */
-                /* [note that we checked to see if it's in the base when we parsed the rule] */
-		if ((c->node->datum.specified & AVTAB_TYPE) &&
-		    ((dup = avtab_search_node(&policydbp->te_cond_avtab, &c->node->key, c->node->datum.specified & AVTAB_TYPE)) != NULL) ){
-			do {
-				/* is the rule we found in the current rule list or the equivalent */
-				if (dup->parse_context == active) {
-					/* change original default */
-					switch(c->node->datum.specified & AVTAB_TYPE) {
-					case AVTAB_TRANSITION:
-						old_data = avtab_transition(&dup->datum);
-						new_data = avtab_transition(&c->node->datum);
-						avtab_transition(&dup->datum) = new_data;
-						break;
-					case AVTAB_MEMBER:
-						old_data = avtab_member(&dup->datum);
-						new_data = avtab_member(&c->node->datum);
-						avtab_member(&dup->datum) = new_data;
-						break;
-					case AVTAB_CHANGE:
-						old_data = avtab_change(&dup->datum);
-						new_data = avtab_change(&c->node->datum);
-						avtab_change(&dup->datum) = new_data;
+        /* verify te rules */
+	tmp = cn.avtrue_list;
+        last_tmp = NULL;
+	while (tmp) {
+		if (!tmp->specified & AVRULE_TRANSITION)
+			continue;
+		retval = insert_check_type_rule(tmp,
+                                                &policydbp->te_cond_avtab,
+                                                &cn_old->true_list, &cn_old->false_list);
+                switch (retval) {
+                case 1: {
+                        last_tmp = tmp;
+                        tmp = tmp->next;
 						break;
 					}
-					sprintf(errormsg, "duplicate type rule on same side of conditional for (%s, %s:%s); overwrote original default %s with %s",
-						type_val_to_name(c->node->key.source_type), 
-						type_val_to_name(c->node->key.target_type), 
-						policydbp->p_class_val_to_name[c->node->key.target_class],
-						type_val_to_name(old_data),
-						type_val_to_name(new_data));					
-					yywarn(errormsg);
-					add_rule = 0;
-					break;
+                case 0: {
+                        /* rule conflicted, so remove it from consideration */
+                        if (last_tmp == NULL) {
+                                cn.avtrue_list = cn.avtrue_list->next;
+                                avrule_destroy(tmp);
+                                tmp = cn.avtrue_list;
+                        }
+                        else {
+                                last_tmp->next = tmp->next;
+                                avrule_destroy(tmp);
+                                tmp = last_tmp->next;
 				}
-				/* if the rule we found is in the opposite rule list that's OK*/
-				if (dup->parse_context == inactive) {
-					continue;
-				} else {
-					/* the rule we found must be in another conditional */
-					sprintf(errormsg, "discarding conflicting conditional type rule for (%s, %s:%s); may only be in one conditional",
-						type_val_to_name(c->node->key.source_type), 
-						type_val_to_name(c->node->key.target_type), 
-						policydbp->p_class_val_to_name[c->node->key.target_class]);
-					yywarn(errormsg);
-					add_rule = 0;
 					break;
 				}
-			} while ( (dup = avtab_search_node_next(dup, c->node->datum.specified & AVTAB_TYPE)) != NULL);
+                case -1: {
+                        return -1;
+                }
+                default: {
+                        assert(0);  /* should never get here */
+                }
+                }
+	}
 
-		} /* end dealing with TYPE_* rules */
-		else if ( (c->node->datum.specified & AVTAB_AV ) &&
-		     ((dup = avtab_search_node(&policydbp->te_cond_avtab, &c->node->key, c->node->datum.specified & AVTAB_AV)) != NULL) ){
-			do {
-				/* we only care if the same AV rule is on the same side of the same conditional */
-				if (dup->parse_context == active) {
-					/* add to original */
-					switch(c->node->datum.specified & AVTAB_AV) {
-					case AVTAB_ALLOWED:
-						new_data = avtab_allowed(&c->node->datum);
-						avtab_allowed(&dup->datum) |= new_data;
-						break;
-					case AVTAB_AUDITALLOW:
-						new_data = avtab_auditallow(&c->node->datum);
-						avtab_auditallow(&dup->datum) |= new_data;
-						break;
-					case AVTAB_AUDITDENY:
-						new_data = avtab_auditdeny(&c->node->datum);
-						/* Since a '0' in an auditdeny mask represents a 
-						 * permission we do NOT want to audit (dontaudit), we use
-						 * the '&' operand to ensure that all '0's in the mask
-						 * are retained (much unlike the allow and auditallow cases).
-						 */
-						avtab_auditdeny(&dup->datum) &= new_data;
+	tmp = cn.avfalse_list;
+        last_tmp = NULL;
+	while (tmp) {
+		if (!tmp->specified & AVRULE_TRANSITION)
+			continue;
+		retval = insert_check_type_rule(tmp,
+                                                &policydbp->te_cond_avtab,
+                                                &cn_old->false_list, &cn_old->true_list);
+                switch (retval) {
+                case 1: {
+                        last_tmp = tmp;
+                        tmp = tmp->next;
 						break;
 					}
-					add_rule = 0;
+                case 0: {
+                        /* rule conflicted, so remove it from consideration  */
+                        if (last_tmp == NULL) {
+                                cn.avfalse_list = cn.avfalse_list->next;
+                                avrule_destroy(tmp);
+                                tmp = cn.avfalse_list;
+                        }
+                        else {
+                                last_tmp->next = tmp->next;
+                                avrule_destroy(tmp);
+                                tmp = last_tmp->next;
+                        }
 					break;
 				}
-			} while ( (dup = avtab_search_node_next(dup, c->node->datum.specified & AVTAB_AV)) != NULL);
-		} /* end dealing with ALLOW rules */
+                case -1: {
+                        return -1;
+                }
+                default: {
+                        assert(0);  /* should never get here */
+                }
+                }
+	}
 
-		top = c->next;
-		/* Either insert the rule into the policy and active list, or discard the rule */
-		if (add_rule) {
-			c->node = avtab_insert_with_parse_context(&policydbp->te_cond_avtab, 
-								  &c->node->key,
-								  &c->node->datum,
-								  active);
-			/* set whether the rule is enabled/disabled */
-			if (state) {
-				c->node->datum.specified |= AVTAB_ENABLED;
-			} else {
-				c->node->datum.specified &= ~AVTAB_ENABLED;
+        /* append the new conditional node to the existing ones.
+         * during expansion the list will be reversed -- i.e., the
+         * last AV rule will be the first one listed in the policy.
+         * this matches the behavior of the upstream compiler. */
+        if (cn_old->avtrue_list == NULL) {
+                cn_old->avtrue_list = cn.avtrue_list;
+        }
+        else {
+                for (tmp = cn_old->avtrue_list; tmp->next != NULL; tmp = tmp->next)
+                        ;
+                tmp->next = cn.avtrue_list;
+        }
+        if (cn_old->avfalse_list == NULL) {
+                cn_old->avfalse_list = cn.avfalse_list;
+        }
+        else {
+                for (tmp = cn_old->avfalse_list; tmp->next != NULL; tmp = tmp->next)
+                        ;
+                tmp->next = cn.avfalse_list;
 			}
 
-			/* prepend new rule to active list */
- 			c->next = *active; 
- 			*active = c; 
-		} else {
-			/* discard rule */
-			free(c->node);
-			free(c);
+        /* note that there is no check here for duplicate rules, nor
+         * check that rule already exists in base -- that will be
+         * handled during conditional expansion, in expand.c */
 			
-			add_rule = 1;
-		}
-                /* next rule */
-		c = top;
+	cn.avtrue_list = NULL;
+	cn.avfalse_list = NULL;
+	cond_node_destroy(&cn);
 		
-	} /* while */
+	return 0;
 }
 
 static cond_expr_t *
@@ -3855,7 +3320,7 @@
 }
 

-static int set_user_roles(ebitmap_t *set,
+static int set_user_roles(role_set_t *set,
 			  char *id)
 {
 	role_datum_t *r;
@@ -3863,20 +3328,14 @@
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) 
-			ebitmap_set_bit(set, i, TRUE);
+		set->flags = ROLE_STAR;
 		free(id);
 		return 0;
 	}
 
 	if (strcmp(id, "~") == 0) {
 		/* complement the set */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) {
-			if (ebitmap_get_bit(set, i))
-				ebitmap_set_bit(set, i, FALSE);
-			else 
-				ebitmap_set_bit(set, i, TRUE);
-		}
+		set->flags = ROLE_COMP;
 		free(id);
 		return 0;
 	}
@@ -3892,7 +3351,7 @@
 	/* set the role and every role it dominates */
 	for (i = ebitmap_startbit(&r->dominates); i < ebitmap_length(&r->dominates); i++) {
 		if (ebitmap_get_bit(&r->dominates, i))
-			ebitmap_set_bit(set, i, TRUE);
+			ebitmap_set_bit(&set->roles, i, TRUE);
 	}
 	free(id);
 	return 0;
@@ -3967,6 +3426,7 @@
 	int ret;
 	level_datum_t *levdatum;
 	int l;
+	uint32_t value;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -4002,17 +3462,15 @@
 			free(id);
 			return -1;
 		}
-		memset(usrdatum, 0, sizeof(user_datum_t));
-		usrdatum->value = ++policydbp->p_users.nprim;
-		ebitmap_init(&usrdatum->roles);
-		ret = hashtab_insert(policydbp->p_users.table,
-				     (hashtab_key_t) id, (hashtab_datum_t) usrdatum);
+                user_datum_init(usrdatum);
+                ret = symtab_insert(policydbp, SYM_USERS, id, (hashtab_datum_t*)usrdatum, &value);
 		if (ret) {
 			yyerror("hash table overflow");
 			free(usrdatum);
 			free(id);
 			return -1;
 		}
+		usrdatum->value = value;
 	} else
 		free(id);
 
@@ -4806,7 +4264,7 @@
 	char *id;
 	level_datum_t *levdatum = 0;
 	mls_range_t range;
-	ebitmap_t doms, types, negset;
+	type_set_t doms, types;
 	range_trans_t *rt = 0;
 	unsigned int i, j;
 	int l, add = 1;
@@ -4834,22 +4292,18 @@
 		return 0;
 	}
 
-	ebitmap_init(&doms);
-	ebitmap_init(&types);
+	type_set_init(&doms);
+	type_set_init(&types);
 
-	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&doms, &negset, id, &add))
+		if (set_types(&doms, id, &add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
-
-	ebitmap_init(&negset);
+        add = 1;
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, id, &add))
 			return -1;
 	}
-	ebitmap_destroy(&negset);
 
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
@@ -4895,17 +4349,18 @@
 		return -1;
 	}
 
-	for (i = ebitmap_startbit(&doms); i < ebitmap_length(&doms); i++) {
-		if (!ebitmap_get_bit(&doms, i))
+	for (i = ebitmap_startbit(&doms.types); i < ebitmap_length(&doms.types); i++) {
+		if (!ebitmap_get_bit(&doms.types, i))
 			continue;
-		for (j = ebitmap_startbit(&types); j < ebitmap_length(&types); j++) {
-			if (!ebitmap_get_bit(&types, j))
+		for (j = ebitmap_startbit(&types.types); j < ebitmap_length(&types.types); j++) {
+			if (!ebitmap_get_bit(&types.types, j))
 				continue;
 
 			for (rt = policydbp->range_tr; rt; rt = rt->next) {
 				if (rt->dom == (i + 1) && rt->type == (j + 1)) {
 					sprintf(errormsg, "duplicate range_transition defined for (%s,%s)",
-					        type_val_to_name(i + 1), type_val_to_name(j + 1));
+					        policydbp->p_type_val_to_name[i + 1],
+                                                policydbp->p_type_val_to_name[j + 1]);
 					yyerror(errormsg);
 					return -1;
 				}
@@ -4938,13 +4393,11 @@
 		}
 	}
 
-	ebitmap_destroy(&doms);
-	ebitmap_destroy(&types);
+	type_set_destroy(&doms);
+	type_set_destroy(&types);
 	ebitmap_destroy(&range.level[0].cat);
 	ebitmap_destroy(&range.level[1].cat);
 	return 0;
 }
 
 /* FLASK */
-
-


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
