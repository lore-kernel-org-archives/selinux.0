Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6MEoj6R026215
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 10:50:45 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Improve resolution error messages
Date: Wed, 22 Jul 2015 10:50:11 -0400
Message-ID: <1437576611-28576-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In some cases, if a statement failed to resolve inside an optional, we
would still log a failed to resolve error message, even though the
optional was disabled and everything successfully compiled. This was
confusing. Additionally, if a resolution failure occurred outside of an
optional, the error message did not include the actual name that could
not be resolved--it only logged the statement type (e.g. allow,
booleanif, etc.) and file/line number.

This patch removes resolution error messages which should not always be
printed, as well as improves the resolution failure message to also
print the last name that was attempted to be resolved. Also makes some
less important error messages INFO rather than WARN, which tended to
just clutter things and hide actual error messages.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil.c             | 10 +++++-----
 libsepol/cil/src/cil_resolve_ast.c | 40 ++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index be070de..dcc1a4f 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -341,7 +341,7 @@ int cil_add_file(cil_db_t *db, char *name, char *data, size_t size)
 
 	rc = cil_parser(name, buffer, size + 2, &db->parse);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to parse %s\n", name);
+		cil_log(CIL_INFO, "Failed to parse %s\n", name);
 		goto exit;
 	}
 
@@ -371,7 +371,7 @@ int cil_compile_nopdb(struct cil_db *db)
 	cil_log(CIL_INFO, "Building AST from Parse Tree\n");
 	rc = cil_build_ast(db, db->parse->root, db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to build ast\n");
+		cil_log(CIL_INFO, "Failed to build ast\n");
 		goto exit;
 	}
 
@@ -381,21 +381,21 @@ int cil_compile_nopdb(struct cil_db *db)
 	cil_log(CIL_INFO, "Resolving AST\n");
 	rc = cil_resolve_ast(db, db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to resolve ast\n");
+		cil_log(CIL_INFO, "Failed to resolve ast\n");
 		goto exit;
 	}
 
 	cil_log(CIL_INFO, "Qualifying Names\n");
 	rc = cil_fqn_qualify(db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to qualify names\n");
+		cil_log(CIL_INFO, "Failed to qualify names\n");
 		goto exit;
 	}
 
 	cil_log(CIL_INFO, "Compile post process\n");
 	rc = cil_post_process(db);
 	if (rc != SEPOL_OK ) {
-		cil_log(CIL_ERR, "Post process failed\n");
+		cil_log(CIL_INFO, "Post process failed\n");
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index c9738da..e68a2da 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -51,6 +51,7 @@ struct cil_args_resolve {
 	struct cil_db *db;
 	enum cil_pass pass;
 	uint32_t *changed;
+	char *last_resolved_name;
 	struct cil_tree_node *callstack;
 	struct cil_tree_node *optstack;
 	struct cil_tree_node *boolif;
@@ -880,7 +881,6 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
 	if (selinuxuser->range_str != NULL) {
 		rc = cil_resolve_name(current, selinuxuser->range_str, CIL_SYM_LEVELRANGES, extra_args, &lvlrange_datum);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Unable to resolve name: %s\n", selinuxuser->range_str);
 			goto exit;
 		}
 		selinuxuser->range = (struct cil_levelrange*)lvlrange_datum;
@@ -1455,7 +1455,6 @@ int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cats, void
 
 	rc = cil_resolve_expr(CIL_CATSET, cats->str_expr, &cats->datum_expr, current, extra_args);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR,"Unable to resolve categories\n");
 		goto exit;
 	}
 	
@@ -1654,21 +1653,18 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 
 	rc = cil_resolve_name(current, context->user_str, CIL_SYM_USERS, extra_args, &user_datum);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Unable to resolve name: %s\n", context->user_str);
 		goto exit;
 	}
 	context->user = (struct cil_user*)user_datum;
 
 	rc = cil_resolve_name(current, context->role_str, CIL_SYM_ROLES, extra_args, &role_datum);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Unable to resolve name: %s\n", context->role_str);
 		goto exit;
 	}
 	context->role = (struct cil_role*)role_datum;
 
 	rc = cil_resolve_name(current, context->type_str, CIL_SYM_TYPES, extra_args, &type_datum);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Unable to resolve name: %s\n", context->type_str);
 		goto exit;
 	}
 
@@ -1684,7 +1680,6 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 	if (context->range_str != NULL) {
 		rc = cil_resolve_name(current, context->range_str, CIL_SYM_LEVELRANGES, extra_args, &lvlrange_datum);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Unable to resolve name: %s\n", context->range_str);
 			goto exit;
 		}
 		context->range = (struct cil_levelrange*)lvlrange_datum;
@@ -2351,7 +2346,6 @@ int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
 	cil_list_for_each(curr, def->class_strs) {
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to resolve class %s in %s\n", (char *)curr->data, cil_node_to_string(current));
 			goto exit;
 		}
 		cil_list_append(def->class_datums, CIL_CLASS, datum);
@@ -2375,7 +2369,6 @@ int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_args)
 	cil_list_for_each(curr, def->class_strs) {
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to resolve class %s in defaultrange\n", (char *)curr->data);
 			goto exit;
 		}
 		cil_list_append(def->class_datums, CIL_CLASS, datum);
@@ -2408,7 +2401,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 	macro_node = macro_datum->nodes->head->data;
 
 	if (macro_node->flavor != CIL_MACRO) {
-		printf("Failed to resolve macro %s\n", new_call->macro_str);
+		printf("Failed to resolve %s to a macro\n", new_call->macro_str);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
@@ -3304,14 +3297,22 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unu
 	}
 
 	rc = __cil_resolve_ast_node(node, extra_args);
-	if (rc == SEPOL_ENOENT && optstack != NULL) {
-		struct cil_optional *opt = (struct cil_optional *)optstack->data;
-		cil_log(CIL_WARN, "Disabling optional %s at %d of %s\n", opt->datum.name, node->parent->line, node->parent->path);
-		/* disable an optional if something failed to resolve */
-		opt->enabled = CIL_FALSE;
-		rc = SEPOL_OK;
-	} else if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to resolve %s statement at %d of %s\n", cil_node_to_string(node), node->line, node->path);
+	if (rc == SEPOL_ENOENT) {
+		enum cil_log_level lvl = CIL_ERR;
+
+		if (optstack != NULL) {
+			lvl = CIL_WARN;
+
+			struct cil_optional *opt = (struct cil_optional *)optstack->data;
+			struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
+			cil_log(lvl, "Disabling optional '%s' at line %d of %s: ", opt->datum.name, opt_node->line, opt_node->path);
+			/* disable an optional if something failed to resolve */
+			opt->enabled = CIL_FALSE;
+			rc = SEPOL_OK;
+		}
+
+		cil_log(lvl, "Failed to resolve '%s' in %s statement at line %d of %s\n",
+		        args->last_resolved_name, cil_node_to_string(node), node->line, node->path);
 		goto exit;
 	}
 
@@ -3460,6 +3461,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.db = db;
 	extra_args.pass = pass;
 	extra_args.changed = &changed;
+	extra_args.last_resolved_name = NULL;
 	extra_args.callstack = NULL;
 	extra_args.optstack = NULL;
 	extra_args.boolif= NULL;
@@ -3734,8 +3736,6 @@ int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_in
 exit:
 	if (rc != SEPOL_OK) {
 		*datum = NULL;
-		cil_log(CIL_WARN, "Failed to resolve %s in %s statement on line %d of %s\n", 
-			name, cil_node_to_string(ast_node), ast_node->line, ast_node->path);
 	}
 
 	if (*datum != NULL) {
@@ -3752,5 +3752,7 @@ exit:
 		}
 	}
 
+	args->last_resolved_name = name;
+
 	return rc;
 }
-- 
2.4.3
