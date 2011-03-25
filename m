From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 2/5] Userspace: role_transition parser to handle class field
Date: Fri, 25 Mar 2011 13:51:59 +0800
Message-Id: <1301032323-20363-5-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

Handle the class field in the role_transition rule. If no class is
specified, then it would be set to the "process" class by default.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/policy_define.c |   89 ++++++++++++++++++++++++++++++++-----------
 checkpolicy/policy_define.h |    2 +-
 checkpolicy/policy_parse.y  |    4 +-
 3 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 82ab44c..5e99b30 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2050,17 +2050,18 @@ static int set_roles(role_set_t * set, char *id)
 	return 0;
 }
 
-int define_role_trans(void)
+int define_role_trans(int class_specified)
 {
 	char *id;
 	role_datum_t *role;
 	role_set_t roles;
 	type_set_t types;
-	ebitmap_t e_types, e_roles;
-	ebitmap_node_t *tnode, *rnode;
+	class_datum_t *cladatum;
+	ebitmap_t e_types, e_roles, e_classes;
+	ebitmap_node_t *tnode, *rnode, *cnode;
 	struct role_trans *tr = NULL;
 	struct role_trans_rule *rule = NULL;
-	unsigned int i, j;
+	unsigned int i, j, k;
 	int add = 1;
 
 	if (pass == 1) {
@@ -2068,6 +2069,9 @@ int define_role_trans(void)
 			free(id);
 		while ((id = queue_remove(id_queue)))
 			free(id);
+		if (class_specified)
+			while ((id = queue_remove(id_queue)))
+				free(id);
 		id = queue_remove(id_queue);
 		free(id);
 		return 0;
@@ -2077,6 +2081,7 @@ int define_role_trans(void)
 	ebitmap_init(&e_roles);
 	type_set_init(&types);
 	ebitmap_init(&e_types);
+	ebitmap_init(&e_classes);
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_roles(&roles, id))
@@ -2088,6 +2093,35 @@ int define_role_trans(void)
 			return -1;
 	}
 
+	if (class_specified) {
+		while ((id = queue_remove(id_queue))) {
+			if (!is_id_in_scope(SYM_CLASSES, id)) {
+				yyerror2("class %s is not within scope", id);
+				free(id);
+				return -1;
+			}
+			cladatum = hashtab_search(policydbp->p_classes.table,
+						  id);
+			if (!cladatum) {
+				yyerror2("unknow class %s", id);
+				return -1;
+			}
+
+			ebitmap_set_bit(&e_classes, cladatum->s.value - 1, TRUE);
+			free(id);
+		}
+	} else {
+		cladatum = hashtab_search(policydbp->p_classes.table,
+					  "process");
+		if (!cladatum) {
+			yyerror2("could not find process class for "
+				 "legacy role_transition statement");
+			return -1;
+		}
+
+		ebitmap_set_bit(&e_classes, cladatum->s.value - 1, TRUE);
+	}
+
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
 		yyerror("no new role in transition definition?");
@@ -2117,27 +2151,37 @@ int define_role_trans(void)
 		ebitmap_for_each_bit(&e_types, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
-
-			for (tr = policydbp->role_tr; tr; tr = tr->next) {
-				if (tr->role == (i + 1) && tr->type == (j + 1)) {
-					yyerror2("duplicate role transition for (%s,%s)",
-					      role_val_to_name(i + 1),
-					      policydbp->p_type_val_to_name[j]);
-					goto bad;
+			ebitmap_for_each_bit(&e_classes, cnode, k) {
+				if (!ebitmap_node_get_bit(cnode, k))
+					continue;
+				for (tr = policydbp->role_tr; tr;
+				     tr = tr->next) {
+					if (tr->role == (i + 1) &&
+					    tr->type == (j + 1) &&
+					    tr->tclass == (k + 1)) {
+						yyerror2("duplicate role "
+							 "transition for "
+							 "(%s,%s,%s)",
+							 role_val_to_name(i+1),
+							 policydbp->p_type_val_to_name[j],
+							 policydbp->p_class_val_to_name[k]);
+						goto bad;
+					}
 				}
-			}
 
-			tr = malloc(sizeof(struct role_trans));
-			if (!tr) {
-				yyerror("out of memory");
-				return -1;
+				tr = malloc(sizeof(struct role_trans));
+				if (!tr) {
+					yyerror("out of memory");
+					return -1;
+				}
+				memset(tr, 0, sizeof(struct role_trans));
+				tr->role = i + 1;
+				tr->type = j + 1;
+				tr->tclass = k + 1;
+				tr->new_role = role->s.value;
+				tr->next = policydbp->role_tr;
+				policydbp->role_tr = tr;
 			}
-			memset(tr, 0, sizeof(struct role_trans));
-			tr->role = i + 1;
-			tr->type = j + 1;
-			tr->new_role = role->s.value;
-			tr->next = policydbp->role_tr;
-			policydbp->role_tr = tr;
 		}
 	}
 	/* Now add the real rule */
@@ -2149,6 +2193,7 @@ int define_role_trans(void)
 	memset(rule, 0, sizeof(struct role_trans_rule));
 	rule->roles = roles;
 	rule->types = types;
+	rule->classes = e_classes;
 	rule->new_role = role->s.value;
 
 	append_role_trans(rule);
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 5ac6667..2f7a78f 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -45,7 +45,7 @@ int define_ioport_context(unsigned long low, unsigned long high);
 int define_pcidevice_context(unsigned long device);
 int define_range_trans(int class_specified);
 int define_role_allow(void);
-int define_role_trans(void);
+int define_role_trans(int class_specified);
 int define_role_types(void);
 int define_sens(void);
 int define_te_avtab(int which);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 8d1bc37..8c29e2b 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -417,7 +417,9 @@ role_type_def		: ROLE identifier TYPES names ';'
 role_dominance		: DOMINANCE '{' roles '}'
 			;
 role_trans_def		: ROLE_TRANSITION names names identifier ';'
-			{if (define_role_trans()) return -1; }
+			{if (define_role_trans(0)) return -1; }
+			| ROLE_TRANSITION names names ':' names identifier ';'
+			{if (define_role_trans(1)) return -1;}
 			;
 role_allow_def		: ALLOW names names ';'
 			{if (define_role_allow()) return -1; }
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
