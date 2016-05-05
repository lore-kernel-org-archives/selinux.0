Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45Kgehn013386
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 16:42:40 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/6 v3] libsepol/cil: Replace cil_log() calls with
 cil_tree_log()
Date: Thu,  5 May 2016 16:44:17 -0400
Message-Id: <1462481059-12437-5-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace all calls to cil_log() that print path information with a
call to cil_tree_log() which will also print information about any
high-level sources.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil.c             |   3 +-
 libsepol/cil/src/cil_binary.c      |  31 ++---
 libsepol/cil/src/cil_build_ast.c   | 263 +++++++++++++------------------------
 libsepol/cil/src/cil_copy_ast.c    |   4 +-
 libsepol/cil/src/cil_fqn.c         |   2 +-
 libsepol/cil/src/cil_resolve_ast.c |  51 ++++---
 libsepol/cil/src/cil_tree.c        |   6 +-
 libsepol/cil/src/cil_verify.c      |  83 ++++++------
 8 files changed, 170 insertions(+), 273 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 40d520b..929ab19 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1764,8 +1764,7 @@ int cil_get_symtab(struct cil_tree_node *ast_node, symtab_t **symtab, enum cil_s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Failed to get symtab from node at line %d of %s\n",
-			ast_node->line, ast_node->path);
+	cil_tree_log(ast_node, CIL_ERR, "Failed to get symtab from node");
 	return SEPOL_ERR;	
 }
 
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 1cd12d2..a3f9171 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1775,13 +1775,12 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 		cil_typetrans = (struct cil_nametypetransition*)node->data;
 		if (DATUM(cil_typetrans->name)->fqn != CIL_KEY_STAR) {
 			cil_log(CIL_ERR, "typetransition with file name not allowed within a booleanif block.\n");
-			cil_log(CIL_ERR,"Invalid typetransition statement at line %d of %s\n", 
-			node->line, node->path);
+			cil_tree_log(node, CIL_ERR,"Invalid typetransition statement");
 			goto exit;
 		}
 		rc = __cil_typetransition_to_avtab(pdb, db, cil_typetrans, cond_node, cond_flavor, filename_trans_table);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to insert type transition into avtab at line %d of %s\n", node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Failed to insert type transition into avtab");
 			goto exit;
 		}
 		break;
@@ -1789,7 +1788,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 		cil_type_rule = node->data;
 		rc = __cil_type_rule_to_avtab(pdb, db, cil_type_rule, cond_node, cond_flavor);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to insert typerule into avtab at line %d of %s\n", node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Failed to insert typerule into avtab");
 			goto exit;
 		}
 		break;
@@ -1797,7 +1796,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 		cil_avrule = node->data;
 		rc = __cil_avrule_to_avtab(pdb, db, cil_avrule, cond_node, cond_flavor);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to insert avrule into avtab at line %d of %s\n", node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Failed to insert avrule into avtab");
 			goto exit;
 		}
 		break;
@@ -1805,8 +1804,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 	case CIL_TUNABLEIF:
 		break;
 	default:
-		cil_log(CIL_ERR, "Invalid statement within booleanif at line %d of %s\n", 
-			node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Invalid statement within booleanif");
 		goto exit;
 	}
 
@@ -2065,14 +2063,13 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	tmp_cond = cond_node_create(pdb, NULL);
 	if (tmp_cond == NULL) {
 		rc = SEPOL_ERR;
-		cil_log(CIL_INFO, "Failed to create sepol conditional node at line %d of %s\n", 
-			node->line, node->path);
+		cil_tree_log(node, CIL_INFO, "Failed to create sepol conditional node");
 		goto exit;
 	}
 	
 	rc = __cil_cond_expr_to_sepol_expr(pdb, cil_boolif->datum_expr, &tmp_cond->expr);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "Failed to convert CIL conditional expression to sepol expression at line %d of %s\n", node->line, node->path);
+		cil_tree_log(node, CIL_INFO, "Failed to convert CIL conditional expression to sepol expression");
 		goto exit;
 	}
 
@@ -2128,7 +2125,7 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 		bool_args.cond_flavor = CIL_CONDTRUE;
 		rc = cil_tree_walk(true_node, __cil_cond_to_policydb_helper, NULL, NULL, &bool_args);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failure while walking true conditional block at line %d of %s\n", true_node->line, true_node->path);
+			cil_tree_log(true_node, CIL_ERR, "Failure while walking true conditional block");
 			goto exit;
 		}
 	}
@@ -2137,7 +2134,7 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 		bool_args.cond_flavor = CIL_CONDFALSE;
 		rc = cil_tree_walk(false_node, __cil_cond_to_policydb_helper, NULL, NULL, &bool_args);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failure while walking false conditional block at line %d of %s\n", false_node->line, false_node->path);
+			cil_tree_log(false_node, CIL_ERR, "Failure while walking false conditional block");
 			goto exit;
 		}
 	}
@@ -3591,7 +3588,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 
 exit:
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Binary policy creation failed at line %d of %s\n", node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Binary policy creation failed");
 	}
 	return rc;
 }
@@ -4271,10 +4268,8 @@ static void __cil_print_parents(const char *pad, struct cil_tree_node *n)
 
 	__cil_print_parents(pad, n->parent);
 
-	if (!n->path) {
-		cil_log(CIL_ERR,"%s%s\n", pad, cil_node_to_string(n));
-	} else {
-		cil_log(CIL_ERR,"%s%s at line %d of %s\n", pad, cil_node_to_string(n), n->line, n->path);
+	if (n->flavor != CIL_SRC_INFO) {
+		cil_tree_log(n, CIL_ERR,"%s%s", pad, cil_node_to_string(n));
 	}
 }
 
@@ -4365,7 +4360,7 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
 		allow_str = CIL_KEY_ALLOWX;
 		avrule_flavor = CIL_AVRULEX;
 	}
-	cil_log(CIL_ERR, "%s check failed at line %d of %s\n", neverallow_str, node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "%s check failed", neverallow_str);
 	__cil_print_rule("  ", neverallow_str, cil_rule);
 	cil_list_init(&matching, CIL_NODE);
 	rc = cil_find_matching_avrule_in_ast(db->ast->root, avrule_flavor, &target, matching, CIL_FALSE);
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 86adb4b..5b9754a 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -108,8 +108,7 @@ int cil_gen_node(__attribute__((unused)) struct cil_db *db, struct cil_tree_node
 			if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
 				if (sflavor == CIL_SYM_BLOCKS) {
 					struct cil_tree_node *node = datum->nodes->head->data;
-					cil_log(CIL_ERR, "Previous declaration at line %d of %s\n",
-						node->line, node->path);
+					cil_tree_log(node, CIL_ERR, "Previous declaration");
 				}
 			}
 			goto exit;
@@ -186,8 +185,7 @@ int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad block declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad block declaration");
 	cil_destroy_block(block);
 	cil_clear_node(ast_node);
 	return rc;
@@ -236,8 +234,7 @@ int cil_gen_blockinherit(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad blockinherit declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad blockinherit declaration");
 	cil_destroy_blockinherit(inherit);
 	return rc;
 }
@@ -281,8 +278,7 @@ int cil_gen_blockabstract(struct cil_db *db, struct cil_tree_node *parse_current
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad blockabstract declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad blockabstract declaration");
 	cil_destroy_blockabstract(abstract);
 	return rc;
 }
@@ -326,8 +322,7 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad in statement at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad in statement");
 	cil_destroy_in(in);
 	return rc;
 }
@@ -387,8 +382,7 @@ int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad class declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad class declaration");
 	cil_destroy_class(class);
 	cil_clear_node(ast_node);
 	return rc;
@@ -456,8 +450,7 @@ int cil_gen_classorder(struct cil_db *db, struct cil_tree_node *parse_current, s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad classorder declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad classorder declaration");
 	cil_destroy_classorder(classorder);
 	return rc;
 }
@@ -739,8 +732,7 @@ int cil_gen_classpermission(struct cil_db *db, struct cil_tree_node *parse_curre
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad classpermission declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad classpermission declaration");
 	cil_destroy_classpermission(cp);
 	cil_clear_node(ast_node);
 	return rc;
@@ -801,8 +793,7 @@ int cil_gen_classpermissionset(struct cil_db *db, struct cil_tree_node *parse_cu
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad classpermissionset at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad classpermissionset");
 	cil_destroy_classpermissionset(cps);
 	return rc;
 }
@@ -853,8 +844,7 @@ int cil_gen_map_class(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad map class declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad map class declaration");
 	cil_destroy_class(map);
 	cil_clear_node(ast_node);
 	return rc;
@@ -898,8 +888,7 @@ int cil_gen_classmapping(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad classmapping declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad classmapping declaration");
 	cil_destroy_classmapping(mapping);
 	return rc;
 }
@@ -955,8 +944,7 @@ int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad common declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad common declaration");
 	cil_destroy_class(common);
 	cil_clear_node(ast_node);
 	return rc;
@@ -995,8 +983,7 @@ int cil_gen_classcommon(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad classcommon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad classcommon declaration");
 	cil_destroy_classcommon(clscom);
 	return rc;
 
@@ -1044,8 +1031,7 @@ int cil_gen_sid(struct cil_db *db, struct cil_tree_node *parse_current, struct c
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sid declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sid declaration");
 	cil_destroy_sid(sid);
 	cil_clear_node(ast_node);
 	return rc;
@@ -1103,8 +1089,7 @@ int cil_gen_sidcontext(struct cil_db *db, struct cil_tree_node *parse_current, s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sidcontext declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sidcontext declaration");
 	cil_destroy_sidcontext(sidcon);
 	return rc;
 }
@@ -1164,8 +1149,7 @@ int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sidorder declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sidorder declaration");
 	cil_destroy_sidorder(sidorder);
 	return rc;
 }
@@ -1216,8 +1200,7 @@ int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad user declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad user declaration");
 	cil_destroy_user(user);
 	cil_clear_node(ast_node);
 	return rc;
@@ -1266,8 +1249,7 @@ int cil_gen_userattribute(struct cil_db *db, struct cil_tree_node *parse_current
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad userattribute declaration at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userattribute declaration");
 	cil_destroy_userattribute(attr);
 	cil_clear_node(ast_node);
 	return rc;
@@ -1337,8 +1319,7 @@ int cil_gen_userattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad userattributeset declaration at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userattributeset declaration");
 	cil_destroy_userattributeset(attrset);
 
 	return rc;
@@ -1398,8 +1379,7 @@ int cil_gen_userlevel(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad userlevel declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userlevel declaration");
 	cil_destroy_userlevel(usrlvl);
 	return rc;
 }
@@ -1459,8 +1439,7 @@ int cil_gen_userrange(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad userrange declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userrange declaration");
 	cil_destroy_userrange(userrange);
 	return rc;
 }
@@ -1509,8 +1488,7 @@ int cil_gen_userprefix(struct cil_db *db, struct cil_tree_node *parse_current, s
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad userprefix declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userprefix declaration");
 	cil_destroy_userprefix(userprefix);
 	return rc;
 }
@@ -1567,8 +1545,7 @@ int cil_gen_selinuxuser(struct cil_db *db, struct cil_tree_node *parse_current,
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad selinuxuser declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad selinuxuser declaration");
 	cil_destroy_selinuxuser(selinuxuser);
 	return rc;
 }
@@ -1615,8 +1592,7 @@ int cil_gen_selinuxuserdefault(struct cil_db *db, struct cil_tree_node *parse_cu
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad selinuxuserdefault declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad selinuxuserdefault declaration");
 	cil_destroy_selinuxuser(selinuxuser);
 	return rc;
 }
@@ -1667,8 +1643,7 @@ int cil_gen_role(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad role declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad role declaration");
 	cil_destroy_role(role);
 	cil_clear_node(ast_node);
 	return rc;
@@ -1718,8 +1693,7 @@ int cil_gen_roletype(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad roletype declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad roletype declaration");
 	cil_destroy_roletype(roletype);
 	return rc;
 }
@@ -1765,8 +1739,7 @@ int cil_gen_userrole(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad userrole declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad userrole declaration");
 	cil_destroy_userrole(userrole);
 	return rc;
 }
@@ -1816,8 +1789,7 @@ int cil_gen_roletransition(struct cil_tree_node *parse_current, struct cil_tree_
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad roletransition rule at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad roletransition rule");
 	cil_destroy_roletransition(roletrans);
 	return rc;
 }
@@ -1863,8 +1835,7 @@ int cil_gen_roleallow(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad roleallow rule at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad roleallow rule");
 	cil_destroy_roleallow(roleallow);
 	return rc;
 }
@@ -1915,8 +1886,7 @@ int cil_gen_roleattribute(struct cil_db *db, struct cil_tree_node *parse_current
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Bad roleattribute declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad roleattribute declaration");
 	cil_destroy_roleattribute(attr);
 	cil_clear_node(ast_node);
 	return rc;
@@ -1983,8 +1953,7 @@ int cil_gen_roleattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad roleattributeset declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad roleattributeset declaration");
 	cil_destroy_roleattributeset(attrset);
 
 	return rc;
@@ -2043,8 +2012,7 @@ int cil_gen_avrule(struct cil_tree_node *parse_current, struct cil_tree_node *as
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad allow rule at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad allow rule");
 	cil_destroy_avrule(rule);
 	return rc;
 }
@@ -2100,8 +2068,7 @@ int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permiss
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad permissionx content at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad permissionx content");
 	return rc;
 }
 
@@ -2144,8 +2111,7 @@ int cil_gen_permissionx(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad permissionx statement at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad permissionx statement");
 	cil_destroy_permissionx(permx);
 	cil_clear_node(ast_node);
 	return rc;
@@ -2211,8 +2177,7 @@ int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *a
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad allowx rule at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad allowx rule");
 	cil_destroy_avrule(rule);
 	return rc;
 }
@@ -2254,8 +2219,7 @@ int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad type rule at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad type rule");
 	cil_destroy_type_rule(rule);
 	return rc;
 }
@@ -2307,8 +2271,7 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad type declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad type declaration");
 	cil_destroy_type(type);
 	cil_clear_node(ast_node);
 	return rc;
@@ -2362,8 +2325,7 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad typeattribute declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad typeattribute declaration");
 	cil_destroy_typeattribute(attr);
 	cil_clear_node(ast_node);
 	return rc;
@@ -2440,11 +2402,9 @@ int cil_gen_bool(struct cil_db *db, struct cil_tree_node *parse_current, struct
 
 exit:
 	if (tunableif) {
-		cil_log(CIL_ERR, "Bad tunable (treated as a boolean due to preserve-tunables) declaration at line %d of %s\n",
-			parse_current->line, parse_current->path);
+		cil_tree_log(parse_current, CIL_ERR, "Bad tunable (treated as a boolean due to preserve-tunables) declaration");
 	} else {
-		cil_log(CIL_ERR, "Bad boolean declaration at line %d of %s\n",
-			parse_current->line, parse_current->path);
+		cil_tree_log(parse_current, CIL_ERR, "Bad boolean declaration");
 	}
 	cil_destroy_bool(boolean);
 	cil_clear_node(ast_node);
@@ -2505,8 +2465,7 @@ int cil_gen_tunable(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad tunable declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad tunable declaration");
 	cil_destroy_tunable(tunable);
 	cil_clear_node(ast_node);
 	return rc;
@@ -2881,11 +2840,9 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
 
 exit:
 	if (tunableif) {
-		cil_log(CIL_ERR, "Bad tunableif (treated as a booleanif due to preserve-tunables) declaration at line %d of %s\n",
-				parse_current->line, parse_current->path);
+		cil_tree_log(parse_current, CIL_ERR, "Bad tunableif (treated as a booleanif due to preserve-tunables) declaration");
 	} else {
-		cil_log(CIL_ERR, "Bad booleanif declaration at line %d of %s\n",
-				parse_current->line, parse_current->path);
+		cil_tree_log(parse_current, CIL_ERR, "Bad booleanif declaration");
 	}
 	cil_destroy_boolif(bif);
 	return rc;
@@ -2965,8 +2922,7 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad tunableif declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad tunableif declaration");
 	cil_destroy_tunif(tif);
 	return rc;
 }
@@ -3019,8 +2975,8 @@ int cil_gen_condblock(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad %s condition declaration at line %d of %s\n",
-		(char*)parse_current->data, parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad %s condition declaration",
+		(char*)parse_current->data);
 	cil_destroy_condblock(cb);
 	return rc;
 }
@@ -3080,8 +3036,7 @@ int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad %s declaration at line %d of %s\n",
-		(char*)parse_current->data, parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad %s declaration", (char*)parse_current->data);
 	cil_destroy_alias(alias);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3138,8 +3093,7 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad %s association at line %d of %s\n", 
-			cil_node_to_string(parse_current),parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad %s association", cil_node_to_string(parse_current));
 	cil_clear_node(ast_node);
 	return rc;
 }
@@ -3188,8 +3142,7 @@ int cil_gen_typeattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad typeattributeset statement at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad typeattributeset statement");
 	cil_destroy_typeattributeset(attrset);
 	return rc;
 }
@@ -3236,8 +3189,7 @@ int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_curren
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad typepermissive declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad typepermissive declaration");
 	cil_destroy_typepermissive(typeperm);
 	return rc;
 }
@@ -3320,8 +3272,7 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad typetransition declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad typetransition declaration");
 	return rc;
 }
 
@@ -3392,8 +3343,7 @@ int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_curre
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad rangetransition declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad rangetransition declaration");
 	cil_destroy_rangetransition(rangetrans);
 	return rc;
 }
@@ -3444,8 +3394,7 @@ int cil_gen_sensitivity(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sensitivity declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sensitivity declaration");
 	cil_destroy_sensitivity(sens);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3497,8 +3446,7 @@ int cil_gen_category(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad category declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad category declaration");
 	cil_destroy_category(cat);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3553,8 +3501,7 @@ int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad categoryset declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad categoryset declaration");
 	cil_destroy_catset(catset);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3615,8 +3562,7 @@ int cil_gen_catorder(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad categoryorder declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad categoryorder declaration");
 	cil_destroy_catorder(catorder);
 	return rc;
 }
@@ -3676,8 +3622,7 @@ int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_curr
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sensitivityorder declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sensitivityorder declaration");
 	cil_destroy_sensitivityorder(sensorder);
 	return rc;
 }
@@ -3731,8 +3676,7 @@ int cil_gen_senscat(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad sensitivitycategory declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad sensitivitycategory declaration");
 	cil_destroy_senscat(senscat);
 	return rc;
 }
@@ -3787,8 +3731,7 @@ int cil_gen_level(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad level declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad level declaration");
 	cil_destroy_level(level);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3894,8 +3837,7 @@ int cil_gen_levelrange(struct cil_db *db, struct cil_tree_node *parse_current, s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad levelrange declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad levelrange declaration");
 	cil_destroy_levelrange(lvlrange);
 	cil_clear_node(ast_node);
 	return rc;
@@ -3959,8 +3901,7 @@ int cil_gen_constrain(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad constrain declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad constrain declaration");
 	cil_destroy_constrain(cons);
 	return rc;
 }
@@ -4014,8 +3955,7 @@ int cil_gen_validatetrans(struct cil_db *db, struct cil_tree_node *parse_current
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad validatetrans declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad validatetrans declaration");
 	cil_destroy_validatetrans(validtrans);
 	return rc;
 
@@ -4119,8 +4059,7 @@ int cil_gen_context(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad context declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad context declaration");
 	cil_destroy_context(context);
 	cil_clear_node(ast_node);
 	return SEPOL_ERR;
@@ -4212,8 +4151,7 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad filecon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad filecon declaration");
 	cil_destroy_filecon(filecon);
 	return rc;
 }
@@ -4314,8 +4252,7 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad portcon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad portcon declaration");
 	cil_destroy_portcon(portcon);
 	return rc;
 }
@@ -4396,8 +4333,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad nodecon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad nodecon declaration");
 	cil_destroy_nodecon(nodecon);
 	return rc;
 }
@@ -4467,8 +4403,7 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad genfscon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad genfscon declaration");
 	cil_destroy_genfscon(genfscon);
 	return SEPOL_ERR;
 }
@@ -4541,8 +4476,7 @@ int cil_gen_netifcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad netifcon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad netifcon declaration");
 	cil_destroy_netifcon(netifcon);
 	return SEPOL_ERR;
 }
@@ -4609,8 +4543,7 @@ int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad pirqcon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad pirqcon declaration");
 	cil_destroy_pirqcon(pirqcon);
 	return rc;
 }
@@ -4695,8 +4628,7 @@ int cil_gen_iomemcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad iomemcon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad iomemcon declaration");
 	cil_destroy_iomemcon(iomemcon);
 	return rc;
 }
@@ -4781,8 +4713,7 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad ioportcon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad ioportcon declaration");
 	cil_destroy_ioportcon(ioportcon);
 	return rc;
 }
@@ -4845,8 +4776,7 @@ int cil_gen_pcidevicecon(struct cil_db *db, struct cil_tree_node *parse_current,
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad pcidevicecon declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad pcidevicecon declaration");
 	cil_destroy_pcidevicecon(pcidevicecon);
 	return rc;
 }
@@ -4906,8 +4836,7 @@ int cil_gen_devicetreecon(struct cil_db *db, struct cil_tree_node *parse_current
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad devicetreecon declaration at line %d of %s\n",
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad devicetreecon declaration");
 	cil_destroy_devicetreecon(devicetreecon);
 	return rc;
 }
@@ -4982,8 +4911,7 @@ int cil_gen_fsuse(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad fsuse declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad fsuse declaration");
 	cil_destroy_fsuse(fsuse);
 	return SEPOL_ERR;
 }
@@ -5140,8 +5068,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad macro declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad macro declaration");
 	cil_destroy_macro(macro);
 	cil_clear_node(ast_node);
 	return SEPOL_ERR;
@@ -5199,8 +5126,7 @@ int cil_gen_call(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad macro call at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad macro call");
 	cil_destroy_call(call);
 	return rc;
 }
@@ -5302,8 +5228,7 @@ int cil_gen_optional(struct cil_db *db, struct cil_tree_node *parse_current, str
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad optional at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad optional");
 	cil_destroy_optional(optional);
 	cil_clear_node(ast_node);
 	return rc;
@@ -5351,8 +5276,7 @@ int cil_gen_policycap(struct cil_db *db, struct cil_tree_node *parse_current, st
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad policycap statement at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad policycap statement");
 	cil_destroy_policycap(polcap);
 	cil_clear_node(ast_node);
 	return rc;
@@ -5407,8 +5331,7 @@ int cil_gen_ipaddr(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad ipaddr statement at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad ipaddr statement");
 	cil_destroy_ipaddr(ipaddr);
 	cil_clear_node(ast_node);
 	return rc;
@@ -5612,8 +5535,7 @@ int cil_gen_bounds(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad bounds declaration at line %d of %s\n", 
-		parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad bounds declaration");
 	cil_destroy_bounds(bounds);
 	return rc;
 }
@@ -5674,8 +5596,7 @@ int cil_gen_default(struct cil_tree_node *parse_current, struct cil_tree_node *a
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad %s declaration at line %d of %s\n", 
-			cil_node_to_string(parse_current), parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad %s declaration", cil_node_to_string(parse_current));
 	cil_destroy_default(def);
 	return rc;
 }
@@ -5761,8 +5682,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad defaultrange declaration at line %d of %s\n", 
-			parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad defaultrange declaration");
 	cil_destroy_defaultrange(def);
 	return rc;
 }
@@ -5822,8 +5742,7 @@ int cil_gen_handleunknown(struct cil_tree_node *parse_current, struct cil_tree_n
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad handleunknown at line %d of %s\n",
-			parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad handleunknown");
 	cil_destroy_handleunknown(unknown);
 	return rc;
 }
@@ -5871,8 +5790,7 @@ int cil_gen_mls(struct cil_tree_node *parse_current, struct cil_tree_node *ast_n
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad mls at line %d of %s\n",
-			parse_current->line, parse_current->path);
+	cil_tree_log(parse_current, CIL_ERR, "Bad mls");
 	cil_destroy_mls(mls);
 	return rc;
 }
@@ -5937,7 +5855,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		if (parse_current->parent->parent == NULL) {
 			rc = SEPOL_OK;
 		} else {
-			cil_log(CIL_ERR, "Keyword expected after open parenthesis in line %d of %s\n", parse_current->line, parse_current->path);
+			cil_tree_log(parse_current, CIL_ERR, "Keyword expected after open parenthesis");
 		}
 		goto exit;
 	}
@@ -5950,7 +5868,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data == CIL_KEY_BLOCKINHERIT ||
 			parse_current->data == CIL_KEY_BLOCKABSTRACT) {
 			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "%s is not allowed in macros (%s:%d)\n", (char *)parse_current->data, parse_current->path, parse_current->line);
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in macros", (char *)parse_current->data);
 			goto exit;
 		}
 	}
@@ -5966,8 +5884,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data != CIL_KEY_TYPECHANGE &&
 			parse_current->data != CIL_KEY_CALL) {
 			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "Found %s at line %d of %s\n",
-				(char*)parse_current->data, parse_current->line, parse_current->path);
+			cil_tree_log(parse_current, CIL_ERR, "Found %s", (char*)parse_current->data);
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
 				cil_log(CIL_ERR, "%s cannot be defined within tunableif statement (treated as a booleanif due to preserve-tunables)\n",
 						(char*)parse_current->data);
@@ -5982,8 +5899,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	if (tunif != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE) {
 			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "Found tunable at line %d of %s\n",
-				parse_current->line, parse_current->path);
+			cil_tree_log(parse_current, CIL_ERR, "Found tunable");
 			cil_log(CIL_ERR, "Tunables cannot be defined within tunableif statement\n");
 			goto exit;
 		}
@@ -5992,8 +5908,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	if (in != NULL) {
 		if (parse_current->data == CIL_KEY_IN) {
 			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "Found in-statement at line %d of %s\n",
-				parse_current->line, parse_current->path);
+			cil_tree_log(parse_current, CIL_ERR, "Found in-statement");
 			cil_log(CIL_ERR, "in-statements cannot be defined within in-statements\n");
 			goto exit;
 		}
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 5615b30..ad69781 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -2004,8 +2004,8 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 						param = item->data;
 						if (param->flavor == new->flavor) {
 							if (param->str == ((struct cil_symtab_datum*)new->data)->name) {
-								cil_log(CIL_ERR, "%s %s shadows a macro parameter (%s line:%d)\n", cil_node_to_string(new), ((struct cil_symtab_datum*)orig->data)->name, orig->path, orig->line);
-								cil_log(CIL_ERR, "Note: macro declaration (%s line:%d)\n", namespace->path, namespace->line);
+								cil_tree_log(orig, CIL_ERR, "%s %s shadows a macro parameter", cil_node_to_string(new), ((struct cil_symtab_datum*)orig->data)->name);
+								cil_tree_log(namespace, CIL_ERR, "Note: macro declaration");
 								rc = SEPOL_ERR;
 								goto exit;
 							}
diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
index 865bd7d..dad1347 100644
--- a/libsepol/cil/src/cil_fqn.c
+++ b/libsepol/cil/src/cil_fqn.c
@@ -121,7 +121,7 @@ static int __cil_fqn_qualify_blocks(__attribute__((unused)) hashtab_key_t k, has
 
 exit:
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR,"Problem qualifying names in block at line %d of %s\n", child_args.node->line, child_args.node->path);
+		cil_tree_log(child_args.node, CIL_ERR,"Problem qualifying names in block");
 	}
 
 	return rc;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 1489680..70e4462 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -497,7 +497,7 @@ int cil_resolve_alias_to_actual(struct cil_tree_node *current, enum cil_flavor f
 	int limit = 2;
 
 	if (alias->actual == NULL) {
-		cil_log(CIL_ERR, "Alias declared but not used at line %d of %s\n",current->line, current->path);
+		cil_tree_log(current, CIL_ERR, "Alias declared but not used");
 		return SEPOL_ERR;
 	}
 
@@ -1380,7 +1380,7 @@ struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists,
 			cil_list_for_each(curr, *ordered_lists) {
 				struct cil_ordered_list *ordered_list = curr->data;
 				if (ordered_list->merged == CIL_FALSE) {
-					cil_log(CIL_ERR, "Unable to merge ordered list at line %d of %s\n",ordered_list->node->line, ordered_list->node->path);
+					cil_tree_log(ordered_list->node, CIL_ERR, "Unable to merge ordered list");
 				}
 			}
 			goto exit;
@@ -2252,12 +2252,10 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
 
 	cil_list_for_each(item, trace) {
 		curr = item->data;
-		cil_log(CIL_ERR, "  %s:%d: ", curr->path, curr->line);
-
 		if (curr->flavor == CIL_BLOCK) {
-			cil_log(CIL_ERR, "block %s\n", DATUM(curr->data)->name);
+			cil_tree_log(curr, CIL_ERR, "block %s", DATUM(curr->data)->name);
 		} else {
-			cil_log(CIL_ERR, "blockinherit %s\n", ((struct cil_blockinherit *)curr->data)->block_str);
+			cil_tree_log(curr, CIL_ERR, "blockinherit %s", ((struct cil_blockinherit *)curr->data)->block_str);
 		}
 	}
 
@@ -2442,7 +2440,7 @@ int cil_resolve_in_list(void *extra_args)
 		}
 
 		if (unresolved > 0 && resolved == 0) {
-			cil_log(CIL_ERR, "Failed to resolve in-statement on line %d of %s\n", last_failed_node->line, last_failed_node->path);
+			cil_tree_log(last_failed_node, CIL_ERR, "Failed to resolve in-statement");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2485,7 +2483,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 
 		if (user->bounds != NULL) {
 			struct cil_tree_node *node = user->bounds->datum.nodes->head->data;
-			cil_log(CIL_ERR, "User %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "User %s already bound by parent", bounds->child_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2498,7 +2496,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 
 		if (role->bounds != NULL) {
 			struct cil_tree_node *node = role->bounds->datum.nodes->head->data;
-			cil_log(CIL_ERR, "Role %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Role %s already bound by parent", bounds->child_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2512,8 +2510,8 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 
 		if (type->bounds != NULL) {
 			node = ((struct cil_symtab_datum *)type->bounds)->nodes->head->data;
-			cil_log(CIL_ERR, "Type %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
-			cil_log(CIL_ERR, "Now being bound to parent %s at line %u of %s\n", bounds->parent_str, current->line, current->path);
+			cil_tree_log(node, CIL_ERR, "Type %s already bound by parent", bounds->child_str);
+			cil_tree_log(current, CIL_ERR, "Now being bound to parent %s", bounds->parent_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2542,7 +2540,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad bounds statement at line %u of %s\n", current->line, current->path);
+	cil_tree_log(current, CIL_ERR, "Bad bounds statement");
 	return rc;
 }
 
@@ -2617,12 +2615,10 @@ void cil_print_recursive_call(struct cil_tree_node *call_node, struct cil_tree_n
 
 	cil_list_for_each(item, trace) {
 		curr = item->data;
-		cil_log(CIL_ERR, "  %s:%d: ", curr->path, curr->line);
-
 		if (curr->flavor == CIL_MACRO) {
-			cil_log(CIL_ERR, "macro %s\n", DATUM(curr->data)->name);
+			cil_tree_log(curr, CIL_ERR, "macro %s", DATUM(curr->data)->name);
 		} else {
-			cil_log(CIL_ERR, "call %s\n", ((struct cil_call *)curr->data)->macro_str);
+			cil_tree_log(curr, CIL_ERR, "call %s", ((struct cil_call *)curr->data)->macro_str);
 		}
 	}
 
@@ -2700,7 +2696,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 		struct cil_tree_node *pc = NULL;
 
 		if (new_call->args_tree == NULL) {
-			cil_log(CIL_ERR, "Missing arguments (%s, line: %d)\n", current->path, current->line);
+			cil_tree_log(current, CIL_ERR, "Missing arguments");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2713,7 +2709,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 			enum cil_flavor flavor = ((struct cil_param*)item->data)->flavor;
 
 			if (pc == NULL) {
-				cil_log(CIL_ERR, "Missing arguments (%s, line: %d)\n", current->path, current->line);
+				cil_tree_log(current, CIL_ERR, "Missing arguments");
 				rc = SEPOL_ERR;
 				goto exit;
 			}
@@ -2890,12 +2886,12 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 		}
 
 		if (pc != NULL) {
-			cil_log(CIL_ERR, "Unexpected arguments (%s, line: %d)\n", current->path, current->line);
+			cil_tree_log(current, CIL_ERR, "Unexpected arguments");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 	} else if (new_call->args_tree != NULL) {
-		cil_log(CIL_ERR, "Unexpected arguments (%s, line: %d)\n", current->path, current->line);
+		cil_tree_log(current, CIL_ERR, "Unexpected arguments");
 		rc = SEPOL_ERR;
 		goto exit;
 	}
@@ -3593,7 +3589,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	if (optstack != NULL) {
 		if (node->flavor == CIL_TUNABLE || node->flavor == CIL_MACRO) {
 			/* tuanbles and macros are not allowed in optionals*/
-			cil_log(CIL_ERR, "%s statement is not allowed in optionals (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3601,7 +3597,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 
 	if (blockstack != NULL) {
 		if (node->flavor == CIL_CAT || node->flavor == CIL_SENS) {
-			cil_log(CIL_ERR, "%s statement is not allowed in blocks (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in blocks", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3612,7 +3608,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 			node->flavor == CIL_BLOCK ||
 			node->flavor == CIL_BLOCKABSTRACT ||
 			node->flavor == CIL_MACRO) {
-			cil_log(CIL_ERR, "%s statement is not allowed in macros (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in macros", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3626,9 +3622,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 			node->flavor == CIL_TUNABLEIF ||
 			node->flavor == CIL_NAMETYPETRANSITION)) {
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
-				cil_log(CIL_ERR, "%s statement is not allowed in booleanifs (tunableif treated as a booleanif) (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs (tunableif treated as a booleanif)", cil_node_to_string(node));
 			} else {
-				cil_log(CIL_ERR, "%s statement is not allowed in booleanifs (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs", cil_node_to_string(node));
 			}
 			rc = SEPOL_ERR;
 			goto exit;
@@ -3658,14 +3654,13 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 
 			struct cil_optional *opt = (struct cil_optional *)optstack->data;
 			struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
-			cil_log(lvl, "Disabling optional '%s' at line %d of %s: ", opt->datum.name, opt_node->line, opt_node->path);
+			cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
 			/* disable an optional if something failed to resolve */
 			opt->enabled = CIL_FALSE;
 			rc = SEPOL_OK;
 		}
 
-		cil_log(lvl, "Failed to resolve '%s' in %s statement at line %d of %s\n",
-		        args->last_resolved_name, cil_node_to_string(node), node->line, node->path);
+		cil_tree_log(node, lvl, "Failed to resolve '%s' in %s statement", args->last_resolved_name, cil_node_to_string(node));
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 33cc4f8..7dc1a1e 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -272,7 +272,7 @@ int cil_tree_walk_core(struct cil_tree_node *node,
 		if (process_node != NULL) {
 			rc = (*process_node)(node, &finished, extra_args);
 			if (rc != SEPOL_OK) {
-				cil_log(CIL_INFO, "Problem at line %d of %s\n", node->line, node->path);
+				cil_tree_log(node, CIL_INFO, "Problem");
 				return rc;
 			}
 		}
@@ -309,7 +309,7 @@ int cil_tree_walk(struct cil_tree_node *node,
 	if (first_child != NULL) {
 		rc = (*first_child)(node->cl_head, extra_args);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Problem at line %d of %s\n", node->line, node->path);
+			cil_tree_log(node, CIL_INFO, "Problem");
 			return rc;
 		}
 	}
@@ -322,7 +322,7 @@ int cil_tree_walk(struct cil_tree_node *node,
 	if (last_child != NULL) {
 		rc = (*last_child)(node->cl_tail, extra_args);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Problem at line %d of %s\n",node->line, node->path);
+			cil_tree_log(node, CIL_INFO, "Problem");
 			return rc;
 		}
 	}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 36ec45a..038f77a 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -377,25 +377,25 @@ int __cil_verify_ordered_node_helper(struct cil_tree_node *node, __attribute__((
 		if (node->flavor == CIL_SID) {
 			struct cil_sid *sid = node->data;
 			if (sid->ordered == CIL_FALSE) {
-				cil_log(CIL_ERR, "SID %s not in sidorder statement at line %d of %s\n", sid->datum.name, node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "SID %s not in sidorder statement", sid->datum.name);
 				return SEPOL_ERR;
 			}
 		} else if (node->flavor == CIL_CLASS) {
 			struct cil_class *class = node->data;
 			if (class->ordered == CIL_FALSE) {
-				cil_log(CIL_ERR, "Class %s not in classorder statement at line %d of %s\n", class->datum.name, node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "Class %s not in classorder statement", class->datum.name);
 				return SEPOL_ERR;
 			}
 		} else if (node->flavor == CIL_CAT) {
 			struct cil_cat *cat = node->data;
 			if (cat->ordered == CIL_FALSE) {
-				cil_log(CIL_ERR, "Category %s not in categoryorder statement at line %d of %s\n", cat->datum.name, node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "Category %s not in categoryorder statement", cat->datum.name);
 				return SEPOL_ERR;
 			}
 		} else if (node->flavor == CIL_SENS) {
 			struct cil_sens *sens = node->data;
 			if (sens->ordered == CIL_FALSE) {
-				cil_log(CIL_ERR, "Sensitivity %s not in sensitivityorder statement at line %d of %s\n", sens->datum.name, node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "Sensitivity %s not in sensitivityorder statement", sens->datum.name);
 				return SEPOL_ERR;
 			}
 		}
@@ -430,7 +430,7 @@ int __cil_verify_initsids(struct cil_list *sids)
 		struct cil_sid *sid = i->data;
 		if (sid->context == NULL) {
 			struct cil_tree_node *node = sid->datum.nodes->head->data;
-			cil_log(CIL_ERR, "No context assigned to SID %s declared at line %d in %s\n",sid->datum.name, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",sid->datum.name);
 			rc = SEPOL_ERR;
 		}
 	}
@@ -598,7 +598,7 @@ int __cil_verify_named_levelrange(struct cil_db *db, struct cil_tree_node *node)
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid named range at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid named range");
 	return rc;
 }
 
@@ -638,7 +638,7 @@ static int __cil_verify_user_pre_eval(struct cil_tree_node *node)
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid user at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid user");
 	return rc;
 }
 
@@ -657,7 +657,7 @@ static int __cil_verify_user_post_eval(struct cil_db *db, struct cil_tree_node *
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid user at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid user");
 	return rc;
 }
 
@@ -688,7 +688,7 @@ int __cil_verify_role(struct cil_tree_node *node)
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid role at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid role");
 	return rc;
 }
 
@@ -719,7 +719,7 @@ int __cil_verify_type(struct cil_tree_node *node)
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid type at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid type");
 	return rc;
 }
 
@@ -813,7 +813,7 @@ int __cil_verify_named_context(struct cil_db *db, struct cil_tree_node *node)
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid named context at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid named context");
 	return rc;
 }
 
@@ -852,8 +852,7 @@ int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_symtab *sym
 		struct cil_complex_symtab_datum *datum = NULL;
 		cil_complex_symtab_search(symtab, &ckey, &datum);
 		if (datum == NULL) {
-			cil_log(CIL_ERR, "Duplicate rule defined on line %d of %s\n", 
-				node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Duplicate rule defined");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -861,7 +860,7 @@ int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_symtab *sym
 
 	return SEPOL_OK;
 exit:
-	cil_log(CIL_ERR, "Invalid rule at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid rule");
 	return rc;
 }
 
@@ -877,11 +876,9 @@ int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute__((unu
 		avrule = rule_node->data;
 		if (avrule->rule_kind == CIL_AVRULE_NEVERALLOW) {
 			if (bif->preserved_tunable) {
-				cil_log(CIL_ERR, "Neverallow found in tunableif block (treated as a booleanif due to preserve-tunables) at line %d or %s\n",
-					node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "Neverallow found in tunableif block (treated as a booleanif due to preserve-tunables)");
 			} else {
-				cil_log(CIL_ERR, "Neverallow found in booleanif block at line %d or %s\n",
-					node->line, node->path);
+				cil_tree_log(node, CIL_ERR, "Neverallow found in booleanif block");
 			}
 			rc = SEPOL_ERR;
 			goto exit;
@@ -942,11 +939,9 @@ int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute__((unu
 	default: {
 		const char * flavor = cil_node_to_string(node);
 		if (bif->preserved_tunable) {
-			cil_log(CIL_ERR, "Invalid %s statement in tunableif (treated as a booleanif due to preserve-tunables) at line %d of %s\n",
-					flavor, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Invalid %s statement in tunableif (treated as a booleanif due to preserve-tunables)", flavor);
 		} else {
-			cil_log(CIL_ERR, "Invalid %s statement in booleanif at line %d of %s\n",
-					flavor, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Invalid %s statement in booleanif", flavor);
 		}
 		goto exit;
 	}
@@ -974,9 +969,9 @@ int __cil_verify_booleanif(struct cil_tree_node *node, struct cil_complex_symtab
 	return SEPOL_OK;
 exit:
 	if (bif->preserved_tunable) {
-		cil_log(CIL_ERR, "Invalid tunableif (treated as a booleanif due to preserve-tunables) at line %d of %s\n", node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Invalid tunableif (treated as a booleanif due to preserve-tunables)");
 	} else {
-		cil_log(CIL_ERR, "Invalid booleanif at line %d of %s\n", node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Invalid booleanif");
 	}
 	return rc;
 }
@@ -1007,7 +1002,7 @@ int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid netifcon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid netifcon");
 	return rc;
 }
 
@@ -1028,7 +1023,7 @@ int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid genfscon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid genfscon");
 	return rc;
 }
 
@@ -1047,8 +1042,7 @@ int __cil_verify_filecon(struct cil_db *db, struct cil_tree_node *node)
 	if (ctx->datum.name == NULL) {
 		rc = __cil_verify_context(db, ctx);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Invalid filecon at line %d of %s\n", 
-				node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Invalid filecon");
 			goto exit;
 		}
 	}
@@ -1076,7 +1070,7 @@ int __cil_verify_nodecon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid nodecon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid nodecon");
 	return rc;
 }
 
@@ -1097,7 +1091,7 @@ int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid portcon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid portcon");
 	return rc;
 }
 
@@ -1118,7 +1112,7 @@ int __cil_verify_pirqcon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid pirqcon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid pirqcon");
 	return rc;
 }
 
@@ -1139,7 +1133,7 @@ int __cil_verify_iomemcon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid iomemcon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid iomemcon");
 	return rc;
 }
 
@@ -1160,7 +1154,7 @@ int __cil_verify_ioportcon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid ioportcon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid ioportcon");
 	return rc;
 }
 
@@ -1181,7 +1175,7 @@ int __cil_verify_pcidevicecon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid pcidevicecon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid pcidevicecon");
 	return rc;
 }
 
@@ -1202,7 +1196,7 @@ int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid devicetreecon at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid devicetreecon");
 	return rc;
 }
 
@@ -1223,7 +1217,7 @@ int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid fsuse at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid fsuse");
 	return rc;
 }
 
@@ -1241,7 +1235,7 @@ int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node
 			kind_str = CIL_KEY_IOCTL;
 			break;
 		default:
-			cil_log(CIL_ERR, "Invalid permissionx kind (%d) at line %d of %s\n", permx->kind, node->line, node->path);
+			cil_tree_log(node, CIL_ERR, "Invalid permissionx kind (%d)", permx->kind);
 			rc = SEPOL_ERR;
 			goto exit;
 	}
@@ -1257,7 +1251,7 @@ int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node
 			}
 
 			if (rc == SEPOL_ENOENT) {
-				cil_log(CIL_ERR, "Invalid permissionx at line %d of %s: %s is not a permission of class %s\n", node->line, node->path, kind_str, class->datum.name);
+				cil_tree_log(node, CIL_ERR, "Invalid permissionx: %s is not a permission of class %s", kind_str, class->datum.name);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
@@ -1312,7 +1306,7 @@ int __cil_verify_class(struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid class at line %d of %s\n", node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid class");
 	return rc;
 }
 
@@ -1329,8 +1323,7 @@ int __cil_verify_policycap(struct cil_tree_node *node)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Invalid policycap (%s) at line %d of %s\n", 
-		(const char*)polcap->datum.name, node->line, node->path);
+	cil_tree_log(node, CIL_ERR, "Invalid policycap (%s)", (const char*)polcap->datum.name);
 	return rc;
 }
 
@@ -1547,14 +1540,14 @@ static int __cil_verify_classpermission(struct cil_tree_node *node)
 	struct cil_classpermission *cp = node->data;
 
 	if (cp->classperms == NULL) {
-		cil_log(CIL_ERR, "Classpermission %s does not have a classpermissionset at line %d of %s\n", cp->datum.name, node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Classpermission %s does not have a classpermissionset", cp->datum.name);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
 
 	rc = __cil_verify_classperms(cp->classperms, &cp->datum);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Found circular class permissions involving the set %s at line %d of %s\n",cp->datum.name, node->line, node->path);
+		cil_tree_log(node, CIL_ERR, "Found circular class permissions involving the set %s",cp->datum.name);
 		goto exit;
 	}
 
@@ -1577,14 +1570,14 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
 	struct cil_perm *cmp = (struct cil_perm *)d;
 
 	if (cmp->classperms == NULL) {
-		cil_log(CIL_ERR, "Map class %s does not have a classmapping for %s at line %d of %s\n", map_args->class->datum.name, cmp->datum.name, map_args->node->line, map_args->node->path);
+		cil_tree_log(map_args->node, CIL_ERR, "Map class %s does not have a classmapping for %s", map_args->class->datum.name, cmp->datum.name);
 		map_args->rc = SEPOL_ERR;
 		goto exit;
 	}
 
 	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Found circular class permissions involving the map class %s and permission %s at line %d of %s\n", map_args->class->datum.name, cmp->datum.name, map_args->node->line, map_args->node->path);
+		cil_tree_log(map_args->node, CIL_ERR, "Found circular class permissions involving the map class %s and permission %s", map_args->class->datum.name, cmp->datum.name);
 		map_args->rc = SEPOL_ERR;
 		goto exit;
 	}
-- 
2.5.5
