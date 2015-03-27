Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2RFGa1H031288
 for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2015 11:16:36 -0400
Message-ID: <551574D9.3090108@tycho.nsa.gov>
Date: Fri, 27 Mar 2015 11:18:49 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/3] libsepol: add function to generate CIL from a module
 policydb
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add new function, sepol_module_policydb_to_cil, that generates
CIL from a module (not kernel) policydb.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/module_to_cil.h |   2 +
 libsepol/src/module_to_cil.c           | 367 ++++++++++++++++++++++-----------
 2 files changed, 254 insertions(+), 115 deletions(-)

diff --git a/libsepol/include/sepol/module_to_cil.h b/libsepol/include/sepol/module_to_cil.h
index 1d0225c..18bb3bf 100644
--- a/libsepol/include/sepol/module_to_cil.h
+++ b/libsepol/include/sepol/module_to_cil.h
@@ -1,6 +1,8 @@
 #include <stdlib.h>
 
 #include <sepol/module.h>
+#include <sepol/policydb/policydb.h>
 
+int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked);
 int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg);
 int sepol_ppfile_to_module_package(FILE *fp, struct sepol_module_package **mod_pkg);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index f1e13b5..69d4dd8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3405,126 +3405,177 @@ exit:
 	return rc;
 }
 
-static int blocks_to_cil(struct policydb *pdb)
+static int block_to_cil(struct policydb *pdb, struct avrule_block *block, struct stack *stack, int indent)
 {
 	int rc = -1;
-	struct avrule_block *block;
 	struct avrule_decl *decl;
-	struct avrule_decl *decl_tmp;
-	int indent = 0;
-	struct stack *stack;
 	struct list *attr_list;
 
-	Src = stack_init(&stack);
+	decl = block->branch_list;
+
+	rc = list_init(&attr_list);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	for (block = pdb->global; block != NULL; block = block->next) {
-		rc = list_init(&attr_list);
-		if (rc != 0) {
-			goto exit;
-		}
+	rc = typealiases_to_cil(indent, pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		decl = block->branch_list;
-		if (decl == NULL) {
-			continue;
-		}
+	rc = declared_scopes_to_cil(indent, pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		if (decl->next != NULL) {
-			log_err("Warning: 'else' blocks in optional statements are unsupported in CIL. Dropping from output.");
-		}
+	rc = required_scopes_to_cil(indent, pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		if (block->flags & AVRULE_OPTIONAL) {
-			while (stack->pos > 0) {
-				decl_tmp = stack_peek(stack);
-				if (is_scope_superset(&decl->required, &decl_tmp->required)) {
-					break;
-				}
+	rc = additive_scopes_to_cil(indent, pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
 
-				stack_pop(stack);
-				indent--;
-				cil_println(indent, ")");
-			}
+	rc = avrule_list_to_cil(indent, pdb, decl->avrules, attr_list);
+	if (rc != 0) {
+		goto exit;
+	}
 
-			cil_println(indent, "(optional %s_optional_%i", pdb->name, decl->decl_id);
-			indent++;
-		}
+	rc = role_trans_to_cil(indent, pdb, decl->role_tr_rules);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		stack_push(stack, decl);
+	rc = role_allows_to_cil(indent, pdb, decl->role_allow_rules);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		if (stack->pos == 0) {
-			// type aliases and commons are only stored in the global symtab.
-			// However, to get scoping correct, we assume they are in the
-			// global block
-			struct map_args args;
-			args.pdb = pdb;
-			args.block = block;
-			args.decl_stack = stack;
-			args.indent = 0;
-			args.scope = SCOPE_DECL;
+	rc = range_trans_to_cil(indent, pdb, decl->range_tr_rules);
+	if (rc != 0) {
+		goto exit;
+	}
 
-			rc = hashtab_map(pdb->p_commons.table, common_to_cil, &args);
-			if (rc != 0) {
-				goto exit;
+	rc = filename_trans_to_cil(indent, pdb, decl->filename_trans_rules);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = cond_list_to_cil(indent, pdb, decl->cond_list);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = cil_print_attr_list(indent, pdb, attr_list);
+	if (rc != 0) {
+		goto exit;
+	}
+
+exit:
+	attr_list_destroy(&attr_list);
+	return rc;
+}
+
+static int module_block_to_cil(struct policydb *pdb, struct avrule_block *block, struct stack *stack, int *indent)
+{
+	int rc = 0;
+	struct avrule_decl *decl;
+	struct avrule_decl *decl_tmp;
+
+	decl = block->branch_list;
+	if (decl == NULL) {
+		goto exit;
+	}
+
+	if (decl->next != NULL) {
+		log_err("Warning: 'else' blocks in optional statements are unsupported in CIL. Dropping from output.");
+	}
+
+	if (block->flags & AVRULE_OPTIONAL) {
+		while (stack->pos > 0) {
+			decl_tmp = stack_peek(stack);
+			if (is_scope_superset(&decl->required, &decl_tmp->required)) {
+				break;
 			}
-		}
 
-		rc = typealiases_to_cil(indent, pdb, block, stack);
-		if (rc != 0) {
-			goto exit;
+			stack_pop(stack);
+			(*indent)--;
+			cil_println(*indent, ")");
 		}
 
-		rc = declared_scopes_to_cil(indent, pdb, block, stack);
-		if (rc != 0) {
-			goto exit;
-		}
+		cil_println(*indent, "(optional %s_optional_%i", pdb->name, decl->decl_id);
+		(*indent)++;
+	}
 
-		rc = required_scopes_to_cil(indent, pdb, block, stack);
-		if (rc != 0) {
-			goto exit;
-		}
+	stack_push(stack, decl);
 
-		rc = additive_scopes_to_cil(indent, pdb, block, stack);
-		if (rc != 0) {
-			goto exit;
-		}
+	rc = block_to_cil(pdb, block, stack, *indent);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		rc = avrule_list_to_cil(indent, pdb, decl->avrules, attr_list);
-		if (rc != 0) {
-			goto exit;
-		}
+exit:
+	return rc;
+}
 
-		rc = role_trans_to_cil(indent, pdb, decl->role_tr_rules);
-		if (rc != 0) {
-			goto exit;
-		}
+static int global_block_to_cil(struct policydb *pdb, struct avrule_block *block, struct stack *stack)
+{
+	int rc = 0;
+	struct avrule_decl *decl;
 
-		rc = role_allows_to_cil(indent, pdb, decl->role_allow_rules);
-		if (rc != 0) {
-			goto exit;
-		}
+	decl = block->branch_list;
+	if (decl == NULL) {
+		goto exit;
+	}
 
-		rc = range_trans_to_cil(indent, pdb, decl->range_tr_rules);
-		if (rc != 0) {
-			goto exit;
-		}
+	if (decl->next != NULL) {
+		log_err("Warning: 'else' not allowed in global block. Dropping from output.");
+	}
 
-		rc = filename_trans_to_cil(indent, pdb, decl->filename_trans_rules);
-		if (rc != 0) {
-			goto exit;
-		}
+	stack_push(stack, decl);
 
-		rc = cond_list_to_cil(indent, pdb, decl->cond_list);
-		if (rc != 0) {
-			goto exit;
-		}
+	// type aliases and commons are only stored in the global symtab.
+	// However, to get scoping correct, we assume they are in the
+	// global block
+	rc = hashtab_map(pdb->p_commons.table, common_to_cil, NULL);
+	if (rc != 0) {
+		goto exit;
+	}
 
-		rc = cil_print_attr_list(indent, pdb, attr_list);
+	rc = block_to_cil(pdb, block, stack, 0);
+	if (rc != 0) {
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
+static int blocks_to_cil(struct policydb *pdb)
+{
+	int rc = -1;
+	struct avrule_block *block;
+	int indent = 0;
+	struct stack *stack;
+
+	rc = stack_init(&stack);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	block = pdb->global;
+	rc = global_block_to_cil(pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	for (block = block->next; block != NULL; block = block->next) {
+		rc = module_block_to_cil(pdb, block, stack, &indent);
 		if (rc != 0) {
 			goto exit;
 		}
-		attr_list_destroy(&attr_list);
 	}
 
 	while (indent > 0) {
@@ -3532,11 +3583,71 @@ static int blocks_to_cil(struct policydb *pdb)
 		cil_println(indent, ")");
 	}
 
-	rc = 0;
+exit:
+	stack_destroy(&stack);
+
+	return rc;
+}
+
+static int linked_block_to_cil(struct policydb *pdb, struct avrule_block *block, struct stack *stack)
+{
+	int rc = 0;
+	struct avrule_decl *decl;
+
+	decl = block->branch_list;
+	if (decl == NULL) {
+		goto exit;
+	}
+
+	if (!decl->enabled) {
+		if (decl->next != NULL) {
+			decl = decl->next;
+		} else {
+			goto exit;
+		}
+	}
+
+	stack_push(stack, decl);
+
+	rc = block_to_cil(pdb, block, stack, 0);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	stack_pop(stack);
+
+exit:
+	return rc;
+}
+
+static int linked_blocks_to_cil(struct policydb *pdb)
+{
+	// Convert base module that has been linked to CIL
+	// Since it is linked, all optional blocks have been resolved
+	int rc = -1;
+	struct avrule_block *block;
+	struct stack *stack;
+
+	rc = stack_init(&stack);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	block = pdb->global;
+	rc = global_block_to_cil(pdb, block, stack);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	for (block = block->next; block != NULL; block = block->next) {
+		rc = linked_block_to_cil(pdb, block, stack);
+		if (rc != 0) {
+			goto exit;
+		}
+	}
 
 exit:
 	stack_destroy(&stack);
-	attr_list_destroy(&attr_list);
 
 	return rc;
 }
@@ -3636,33 +3747,30 @@ exit:
 	return rc;
 }
 
-int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
+int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked)
 {
 	int rc = -1;
-	struct sepol_policydb *pdb;
 
 	out_file = fp;
 
-	pdb = sepol_module_package_get_policy(mod_pkg);
 	if (pdb == NULL) {
-		log_err("Failed to get policydb");
-		rc = -1;
+		rc = 0;
 		goto exit;
 	}
 
-	if (pdb->p.policy_type != SEPOL_POLICY_BASE &&
-		pdb->p.policy_type != SEPOL_POLICY_MOD) {
+	if (pdb->policy_type != SEPOL_POLICY_BASE &&
+		pdb->policy_type != SEPOL_POLICY_MOD) {
 		log_err("Policy pakcage is not a base or module");
 		rc = -1;
 		goto exit;
 	}
 
-	rc = fix_module_name(&pdb->p);
+	rc = fix_module_name(pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	if (pdb->p.policy_type == SEPOL_POLICY_BASE && !pdb->p.mls) {
+	if (pdb->policy_type == SEPOL_POLICY_BASE && !pdb->mls) {
 		// If this is a base non-mls policy, we need to define a default level
 		// range that can be used for contexts by other non-mls modules, since
 		// CIL requires that all contexts have a range, even if they are
@@ -3673,7 +3781,7 @@ int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
 		}
 	}
 
-	if (pdb->p.policy_type == SEPOL_POLICY_BASE) {
+	if (pdb->policy_type == SEPOL_POLICY_BASE) {
 		// object_r is implicit in checkmodule, but not with CIL, create it
 		// as part of base
 		rc = generate_default_object();
@@ -3688,65 +3796,97 @@ int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
 		}
 
 		// handle_unknown is used from only the base module
-		rc = handle_unknown_to_cil(&pdb->p);
+		rc = handle_unknown_to_cil(pdb);
 		if (rc != 0) {
 			goto exit;
 		}
 
 		// mls is used from only the base module	
-		rc = generate_mls(&pdb->p);
+		rc = generate_mls(pdb);
 		if (rc != 0) {
 			goto exit;
 		}
 	}
 
-	rc = role_list_create(pdb->p.p_roles.table);
+	rc = role_list_create(pdb->p_roles.table);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = typealias_list_create(&pdb->p);
+	rc = typealias_list_create(pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = polcaps_to_cil(&pdb->p);
+	rc = polcaps_to_cil(pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = ocontexts_to_cil(&pdb->p);
+	rc = ocontexts_to_cil(pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = genfscon_to_cil(&pdb->p);
+	rc = genfscon_to_cil(pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = seusers_to_cil(mod_pkg);
+	// now print everything that is scoped
+	if (linked) {
+		rc = linked_blocks_to_cil(pdb);
+	} else {
+		rc = blocks_to_cil(pdb);
+	}
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = netfilter_contexts_to_cil(mod_pkg);
+	rc = 0;
+
+exit:
+	role_list_destroy();
+	typealias_list_destroy();
+
+	return rc;
+}
+
+int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
+{
+	int rc = -1;
+	struct sepol_policydb *pdb;
+
+	out_file = fp;
+
+	pdb = sepol_module_package_get_policy(mod_pkg);
+	if (pdb == NULL) {
+		log_err("Failed to get policydb");
+		rc = -1;
+		goto exit;
+	}
+
+	rc = sepol_module_policydb_to_cil(fp, &pdb->p, 0);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = user_extra_to_cil(mod_pkg);
+	rc = seusers_to_cil(mod_pkg);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = file_contexts_to_cil(mod_pkg);
+	rc = netfilter_contexts_to_cil(mod_pkg);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	// now print everything that is scoped
-	rc = blocks_to_cil(&pdb->p);
+	rc = user_extra_to_cil(mod_pkg);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = file_contexts_to_cil(mod_pkg);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -3754,9 +3894,6 @@ int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
 	rc = 0;
 
 exit:
-	role_list_destroy();
-	typealias_list_destroy();
-
 	return rc;
 }
 
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
