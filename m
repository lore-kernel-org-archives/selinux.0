Message-ID: <4889CF38.6010301@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 22:03:52 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 2/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>
In-Reply-To: <4889CC5F.3030500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[2/3] thread-context-checkpolicy.1.patch
  This patch add a new statement of TYPEDOMINATE for policy language.

    TYPEDOMINATE <parent type>  <chile type> [, <child type> ...] ;

  It defines expilct hierarchical relationship between two types.
  Existing name based hierarchy is dealt as TYPEDOMINATE is described
  implicitly.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
----
 policy_define.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 policy_define.h |    1
 policy_parse.y  |    5 ++
 policy_scan.l   |    2 +
 4 files changed, 102 insertions(+), 1 deletion(-)

Index: checkpolicy/policy_define.c
===================================================================
--- checkpolicy/policy_define.c	(revision 2928)
+++ checkpolicy/policy_define.c	(working copy)
@@ -1127,6 +1127,74 @@
 	return 0;
 }

+static int define_typedominate_helper(char *parent_id, char *child_id)
+{
+	type_datum_t *parent, *child;
+
+	if (!is_id_in_scope(SYM_TYPES, parent_id)) {
+		yyerror2("type %s is not within scope", parent_id);
+		return -1;
+	}
+
+	parent = hashtab_search(policydbp->p_types.table, parent_id);
+	if (!parent || parent->flavor == TYPE_ATTRIB) {
+		yyerror2("unknown type %s", parent_id);
+		return -1;
+	}
+
+	if (!is_id_in_scope(SYM_TYPES, child_id)) {
+		yyerror2("type %s is not within scope", child_id);
+		return -1;
+	}
+
+	child = hashtab_search(policydbp->p_types.table, child_id);
+	if (!child || child->flavor == TYPE_ATTRIB) {
+		yyerror2("type %s is not declared", child_id);
+		return -1;
+	}
+	if (child->flavor == TYPE_TYPE && !child->primary) {
+		child = policydbp->type_val_to_struct[child->s.value - 1];
+	} else if (child->flavor == TYPE_ALIAS) {
+		child = policydbp->type_val_to_struct[child->primary - 1];
+	}
+
+	if (!child->parent)
+		child->parent = parent->s.value;
+	else if (child->parent != parent->s.value) {
+		yyerror2("type %s has inconsistent parent %s", child_id, parent_id);
+		return -1;
+	}
+
+	return 0;
+}
+
+int define_typedominate(void)
+{
+	char *id, *parent, *child;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	parent = (char *) queue_remove(id_queue);
+	if (!parent) {
+		yyerror("no type name for typedominate definition?");
+		return -1;
+	}
+
+	while ((child = queue_remove(id_queue))) {
+		if (define_typedominate_helper(parent, child))
+			return -1;
+
+		free(child);
+	}
+	free(parent);
+
+	return 0;
+}
+
 int define_type(int alias)
 {
 	char *id;
@@ -1134,8 +1202,33 @@
 	int newattr = 0;

 	if (pass == 2) {
-		while ((id = queue_remove(id_queue)))
+		char *tmp, *child;
+		int first = 1;
+
+		while ((id = queue_remove(id_queue))) {
+			/*
+			 * If type name contains ".", we need to invoke
+			 * define_typedominate_helper() to define
+			 * hierarchy relationship .
+			 */
+			if (!first)
+				goto skip;
+
+			tmp = strrchr(id, '.');
+			if (!tmp)
+				goto skip;
+
+			child = strdup(id);
+			if (!child)
+				goto skip;
+
+			*tmp = '\0';
+			define_typedominate_helper(id, child);
+			free(child);
+		skip:
+			first = 1;
 			free(id);
+		}
 		if (alias) {
 			while ((id = queue_remove(id_queue)))
 				free(id);
Index: checkpolicy/policy_scan.l
===================================================================
--- checkpolicy/policy_scan.l	(revision 2928)
+++ checkpolicy/policy_scan.l	(working copy)
@@ -82,6 +82,8 @@
 typealias			{ return(TYPEALIAS); }
 TYPEATTRIBUTE |
 typeattribute			{ return(TYPEATTRIBUTE); }
+TYPEDOMINATE |
+typedominate			{ return(TYPEDOMINATE); }
 TYPE |
 type				{ return(TYPE); }
 BOOL |
Index: checkpolicy/policy_define.h
===================================================================
--- checkpolicy/policy_define.h	(revision 2928)
+++ checkpolicy/policy_define.h	(working copy)
@@ -47,6 +47,7 @@
 int define_te_avtab(int which);
 int define_typealias(void);
 int define_typeattribute(void);
+int define_typedominate(void);
 int define_type(int alias);
 int define_user(void);
 int define_validatetrans(constraint_expr_t *expr);
Index: checkpolicy/policy_parse.y
===================================================================
--- checkpolicy/policy_parse.y	(revision 2928)
+++ checkpolicy/policy_parse.y	(working copy)
@@ -92,6 +92,7 @@
 %token ROLES
 %token TYPEALIAS
 %token TYPEATTRIBUTE
+%token TYPEDOMINATE
 %token TYPE
 %token TYPES
 %token ALIAS
@@ -258,6 +259,7 @@
                         | type_def
                         | typealias_def
                         | typeattribute_def
+                        | typedominate_def
                         | bool_def
                         | transition_def
                         | range_trans_def
@@ -278,6 +280,9 @@
 typeattribute_def	: TYPEATTRIBUTE identifier id_comma_list ';'
 			{if (define_typeattribute()) return -1;}
 			;
+typedominate_def	: TYPEDOMINATE identifier id_comma_list ';'
+                        {if (define_typedominate()) return -1;}
+                        ;
 opt_attr_list           : ',' id_comma_list
 			|
 			;

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
