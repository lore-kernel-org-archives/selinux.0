Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T8LINx031217
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 04:21:18 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T8LGFQ015552
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 08:21:17 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 2/7] Separate tunable from boolean during compile.
Date: Mon, 29 Aug 2011 16:21:01 +0800
Message-ID: <1314606066-12314-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
References: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both boolean and tunable keywords are processed by define_bool_tunable(),
argument 0 and 1 would be passed for boolean and tunable respectively.
For tunable, a TUNABLE flag would be set in cond_bool_datum_t.flags.

Note, when creating an if-else conditional we can not know if the
tunable identifier is indeed a tunable(for example, a boolean may be
misused in tunable_policy() or vice versa), thus the TUNABLE flag
for cond_node_t would be calculated and used in expansion when all
booleans/tunables copied during link.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/module_compiler.c |   16 +++++++++++++++-
 checkpolicy/module_compiler.h |    1 +
 checkpolicy/policy_define.c   |    4 +++-
 checkpolicy/policy_define.h   |    2 +-
 checkpolicy/policy_parse.y    |    8 +++++++-
 checkpolicy/policy_scan.l     |    2 ++
 libsepol/src/conditional.c    |    1 +
 7 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 1c1d1d5..ffffaf1 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1045,7 +1045,7 @@ int require_user(int pass)
 	}
 }
 
-int require_bool(int pass)
+static int require_bool_tunable(int pass, int is_tunable)
 {
 	char *id = queue_remove(id_queue);
 	cond_bool_datum_t *booldatum = NULL;
@@ -1063,6 +1063,8 @@ int require_bool(int pass)
 		yyerror("Out of memory!");
 		return -1;
 	}
+	if (is_tunable)
+		booldatum->flags |= COND_BOOL_FLAGS_TUNABLE;
 	retval =
 	    require_symbol(SYM_BOOLS, id, (hashtab_datum_t *) booldatum,
 			   &booldatum->s.value, &booldatum->s.value);
@@ -1094,6 +1096,16 @@ int require_bool(int pass)
 	}
 }
 
+int require_bool(int pass)
+{
+	return require_bool_tunable(pass, 0);
+}
+
+int require_tunable(int pass)
+{
+	return require_bool_tunable(pass, 1);
+}
+
 int require_sens(int pass)
 {
 	char *id = queue_remove(id_queue);
@@ -1328,6 +1340,8 @@ void append_cond_list(cond_list_t * cond)
 		     tmp = tmp->next) ;
 		tmp->next = cond->avfalse_list;
 	}
+
+	old_cond->flags |= cond->flags;
 }
 
 void append_avrule(avrule_t * avrule)
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
index 45a21cd..72c2d9b 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -58,6 +58,7 @@ int require_attribute(int pass);
 int require_attribute_role(int pass);
 int require_user(int pass);
 int require_bool(int pass);
+int require_tunable(int pass);
 int require_sens(int pass);
 int require_cat(int pass);
 
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ded27f7..1bf669c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1494,7 +1494,7 @@ avrule_t *define_cond_compute_type(int which)
 	return avrule;
 }
 
-int define_bool(void)
+int define_bool_tunable(int is_tunable)
 {
 	char *id, *bool_value;
 	cond_bool_datum_t *datum;
@@ -1524,6 +1524,8 @@ int define_bool(void)
 		return -1;
 	}
 	memset(datum, 0, sizeof(cond_bool_datum_t));
+	if (is_tunable)
+		datum->flags |= COND_BOOL_FLAGS_TUNABLE;
 	ret = declare_symbol(SYM_BOOLS, id, datum, &value, &value);
 	switch (ret) {
 	case -3:{
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index fc8cd4d..92a9be7 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -21,7 +21,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
 int define_attrib(void);
 int define_attrib_role(void);
 int define_av_perms(int inherits);
-int define_bool(void);
+int define_bool_tunable(int is_tunable);
 int define_category(void);
 int define_class(void);
 int define_common_perms(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 0a17bdc..49ac15f 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -101,6 +101,7 @@ typedef int (* require_func_t)();
 %token ALIAS
 %token ATTRIBUTE
 %token BOOL
+%token TUNABLE
 %token IF
 %token ELSE
 %token TYPE_TRANSITION
@@ -269,6 +270,7 @@ te_decl			: attribute_def
                         | typeattribute_def
                         | typebounds_def
                         | bool_def
+			| tunable_def
                         | transition_def
                         | range_trans_def
                         | te_avtab_def
@@ -295,8 +297,11 @@ opt_attr_list           : ',' id_comma_list
 			| 
 			;
 bool_def                : BOOL identifier bool_val ';'
-                        {if (define_bool()) return -1;}
+                        { if (define_bool_tunable(0)) return -1; }
                         ;
+tunable_def		: TUNABLE identifier bool_val ';'
+			{ if (define_bool_tunable(1)) return -1; }
+			;
 bool_val                : CTRUE
  			{ if (insert_id("T",0)) return -1; }
                         | CFALSE
@@ -820,6 +825,7 @@ require_decl_def        : ROLE        { $$ = require_role; }
                         | ATTRIBUTE_ROLE   { $$ = require_attribute_role; }
                         | USER        { $$ = require_user; }
                         | BOOL        { $$ = require_bool; }
+			| TUNABLE     { $$ = require_tunable; }
                         | SENSITIVITY { $$ = require_sens; }
                         | CATEGORY    { $$ = require_cat; }
                         ;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index ed27bbe..a61e0db 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -92,6 +92,8 @@ TYPE |
 type				{ return(TYPE); }
 BOOL |
 bool                            { return(BOOL); }
+TUNABLE |
+tunable				{ return(TUNABLE); }
 IF |
 if				{ return(IF); }
 ELSE |
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 1482387..efdedb0 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -160,6 +160,7 @@ cond_node_t *cond_node_create(policydb_t * p, cond_node_t * node)
 		for (i = 0; i < min(node->nbools, COND_MAX_BOOLS); i++)
 			new_node->bool_ids[i] = node->bool_ids[i];
 		new_node->expr_pre_comp = node->expr_pre_comp;
+		new_node->flags = node->flags;
 	}
 
 	return new_node;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
