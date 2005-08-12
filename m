Subject: [patch 2/2] Fix memory leaks in libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
References: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 16:50:48 -0400
Message-Id: <1123879848.23483.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-12 at 16:38 -0400, Stephen Smalley wrote:
> These patches fix some memory leaks in libsepol and checkpolicy detected
> by valgrind.  To help detect such leaks, I changed checkpolicy to free
> the policydbs prior to exit rather than just letting exit handle the
> final release of memory.  This required altering checkpolicy to avoid
> pointer aliasing for the constraint expressions to allow
> policydb_destroy to work cleanly.  I haven't finished tracking down all
> of the memory leaks reported by valgrind yet, so this is just a start.

This second patch changes checkpolicy to free the policydbs prior to
exit and fixes several leaks in checkpolicy, including:
- leak of policydb due to duplicate policydb_init call on the kernel
policydb (handled by expand_module),
- leak of temporary tclasses ebitmaps,
- leak of avrules

 checkpolicy.c     |   12 +++--------
 module_compiler.c |    1 
 policy_parse.y    |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 9 deletions(-)

Index: checkpolicy/checkpolicy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkpolicy.c,v
retrieving revision 1.34
diff -u -p -r1.34 checkpolicy.c
--- checkpolicy/checkpolicy.c	11 Aug 2005 15:43:16 -0000	1.34
+++ checkpolicy/checkpolicy.c	12 Aug 2005 20:08:57 -0000
@@ -564,10 +564,6 @@ int main(int argc, char **argv)
 			exit(1);
 		}
 
-		if (policydb_init(&policydb, POLICY_KERN)) {
-			exit(1);
-                }
-
                 /* as that this is building a non-module policy,
                    always enable the global avrule block */
                 parse_policy.global->branch_list->enabled = 1;
@@ -576,6 +572,7 @@ int main(int argc, char **argv)
                         fprintf(stderr, "Error while expanding policy: %s\n", error_msg);
 			exit(1);
                 }
+		policydb_destroy(&parse_policy);
 		policydbp = &policydb;
 
 		if (hierarchy_check_constraints(policydbp, error_msg, sizeof(error_msg))) {
@@ -595,9 +592,6 @@ int main(int argc, char **argv)
 	if (policydb_load_isids(&policydb, &sidtab))
 		exit(1);
 
-	if (policydb_index_others(policydbp, 1))
-		exit(1);
-        
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
 	if (outfile) {
@@ -626,8 +620,10 @@ int main(int argc, char **argv)
 		}
 		fclose(outfp);
 	}
-	if (!debug)
+	if (!debug) {
+		policydb_destroy(&policydb);
 		exit(0);
+	}
 
       menu:
 	printf("\nSelect an option:\n");
Index: checkpolicy/module_compiler.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/module_compiler.c,v
retrieving revision 1.3
diff -u -p -r1.3 module_compiler.c
--- checkpolicy/module_compiler.c	11 Aug 2005 15:43:16 -0000	1.3
+++ checkpolicy/module_compiler.c	12 Aug 2005 19:16:14 -0000
@@ -288,6 +288,7 @@ type_datum_t *declare_type(unsigned char
                 }
                 if ((dest_typdatum = get_local_type(dest_id, value)) == NULL) {
                         yyerror("Out of memory!");
+			free(dest_id);
                         return NULL;
                 }       
         }
Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.39
diff -u -p -r1.39 policy_parse.y
--- checkpolicy/policy_parse.y	11 Aug 2005 15:43:17 -0000	1.39
+++ checkpolicy/policy_parse.y	12 Aug 2005 19:46:27 -0000
@@ -2053,6 +2053,7 @@ static int define_compute_type_helper(in
 			avrule->perms = perm;
 		}               
 	}
+	ebitmap_destroy(&tclasses);
         
         *rule = avrule;
 	return 0;
@@ -2354,6 +2355,8 @@ next:
 
 		free(id);
 	}
+	
+	ebitmap_destroy(&tclasses);
 
         avrule->perms = perms;
         *rule = avrule;
@@ -2774,6 +2777,47 @@ static int define_role_allow(void)
 	return 0;
 }
 
+static constraint_expr_t *constraint_expr_clone(constraint_expr_t *expr)
+{
+	constraint_expr_t *h = NULL, *l = NULL, *e, *newe;
+	for (e = expr; e; e = e->next) {
+		newe = malloc(sizeof(*newe));
+		if (!newe)
+			goto oom;
+		if (constraint_expr_init(newe) == -1) {
+			free(newe);
+			goto oom;
+		}
+		if (l) 
+			l->next = newe;
+		else
+			h = newe;
+		l = newe;
+		newe->expr_type = e->expr_type;
+		newe->attr = e->attr;
+		newe->op = e->op;
+		if (newe->expr_type == CEXPR_NAMES) {
+			if (newe->attr & CEXPR_TYPE) {
+				if (type_set_cpy(newe->type_names, e->type_names))
+					goto oom;
+			} else {
+				if (ebitmap_cpy(&newe->names, &e->names))
+					goto oom;
+			}
+		}
+	}
+
+	return h;
+oom:
+	e = h;
+	while (e) {
+		l = e;
+		e = e->next;
+		constraint_expr_destroy(e);
+	}
+	return NULL;
+}
+
 
 static int define_constraint(constraint_expr_t * expr)
 {
@@ -2862,7 +2906,11 @@ static int define_constraint(constraint_
 			return -1;
 		}
 		memset(node, 0, sizeof(constraint_node_t));
-		node->expr = expr;
+		node->expr = constraint_expr_clone(expr);
+		if (!node->expr) {
+			yyerror("out of memory");
+			return -1;
+		}
 		node->permissions = 0;
 
 		node->next = cladatum->constraints;
@@ -3018,6 +3066,7 @@ static uintptr_t
 	if ((expr = malloc(sizeof(*expr))) == NULL ||
             constraint_expr_init(expr) == - 1) {
 		yyerror("out of memory");
+		free(expr);
 		return 0;
 	}
 	expr->expr_type = expr_type;
@@ -3240,11 +3289,13 @@ static int define_conditional(cond_expr_
                         if (last_tmp == NULL) {
                                 cn.avtrue_list = cn.avtrue_list->next;
                                 avrule_destroy(tmp);
+				free(tmp);
                                 tmp = cn.avtrue_list;
                         }
                         else {
                                 last_tmp->next = tmp->next;
                                 avrule_destroy(tmp);
+				free(tmp);
                                 tmp = last_tmp->next;
                         }
                         break;
@@ -3277,11 +3328,13 @@ static int define_conditional(cond_expr_
                         if (last_tmp == NULL) {
                                 cn.avfalse_list = cn.avfalse_list->next;
                                 avrule_destroy(tmp);
+				free(tmp);
                                 tmp = cn.avfalse_list;
                         }
                         else {
                                 last_tmp->next = tmp->next;
                                 avrule_destroy(tmp);
+				free(tmp);
                                 tmp = last_tmp->next;
                         }
                         break;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
