Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjf022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:32 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/7] libsepol/cil: Verify neither child nor parent in a bounds
 is an attribute
Date: Tue, 18 Oct 2016 14:58:48 -0400
Message-Id: <1476817128-16108-8-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that using an attribute
as a child in a typebounds statement will cause a segfault.

This happens because the child datum is assumed to be part of a cil_type
struct when it is really part of a cil_typeattribute struct. The check to
verify that it is a type and not an attribute comes after it is used.

This bug effects user and role bounds as well because they do not check
whether a datum refers to an attribute or not.

Add checks to verify that neither the child nor the parent datum refer
to an attribute before using them in user, role, and type bounds.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 44 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 149e4f4..ec547d3 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2468,7 +2468,7 @@ exit:
 }
 
 
-int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor)
+int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor attr_flavor)
 {
 	int rc = SEPOL_ERR;
 	struct cil_bounds *bounds = current->data;
@@ -2485,19 +2485,29 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
+	if (NODE(parent_datum)->flavor == attr_flavor) {
+		cil_log(CIL_ERR, "Bounds parent %s is an attribute\n", bounds->parent_str);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 
 	rc = cil_resolve_name(current, bounds->child_str, index, extra_args, &child_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
+	if (NODE(child_datum)->flavor == attr_flavor) {
+		cil_log(CIL_ERR, "Bounds child %s is an attribute\n", bounds->child_str);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
 
 	switch (flavor) {
 	case CIL_USER: {
 		struct cil_user *user = (struct cil_user *)child_datum;
 
 		if (user->bounds != NULL) {
-			struct cil_tree_node *node = user->bounds->datum.nodes->head->data;
-			cil_tree_log(node, CIL_ERR, "User %s already bound by parent", bounds->child_str);
+			cil_tree_log(NODE(user->bounds), CIL_ERR, "User %s already bound by parent", bounds->child_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2509,8 +2519,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 		struct cil_role *role = (struct cil_role *)child_datum;
 
 		if (role->bounds != NULL) {
-			struct cil_tree_node *node = role->bounds->datum.nodes->head->data;
-			cil_tree_log(node, CIL_ERR, "Role %s already bound by parent", bounds->child_str);
+			cil_tree_log(NODE(role->bounds), CIL_ERR, "Role %s already bound by parent", bounds->child_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -2520,26 +2529,9 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 	}
 	case CIL_TYPE: {
 		struct cil_type *type = (struct cil_type *)child_datum;
-		struct cil_tree_node *node = NULL;
 
 		if (type->bounds != NULL) {
-			node = ((struct cil_symtab_datum *)type->bounds)->nodes->head->data;
-			cil_tree_log(node, CIL_ERR, "Type %s already bound by parent", bounds->child_str);
-			cil_tree_log(current, CIL_ERR, "Now being bound to parent %s", bounds->parent_str);
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-
-		node = parent_datum->nodes->head->data;
-		if (node->flavor == CIL_TYPEATTRIBUTE) {
-			cil_log(CIL_ERR, "Bounds parent %s is an attribute\n", bounds->parent_str);
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-
-		node = child_datum->nodes->head->data;
-		if (node->flavor == CIL_TYPEATTRIBUTE) {
-			cil_log(CIL_ERR, "Bounds child %s is an attribute\n", bounds->child_str);
+			cil_tree_log(NODE(type->bounds), CIL_ERR, "Type %s already bound by parent", bounds->child_str);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3445,7 +3437,7 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 			rc = cil_resolve_typeattributeset(node, args);
 			break;
 		case CIL_TYPEBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_TYPE);
+			rc = cil_resolve_bounds(node, args, CIL_TYPE, CIL_TYPEATTRIBUTE);
 			break;
 		case CIL_TYPEPERMISSIVE:
 			rc = cil_resolve_typepermissive(node, args);
@@ -3482,7 +3474,7 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 			rc = cil_resolve_userrange(node, args);
 			break;
 		case CIL_USERBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_USER);
+			rc = cil_resolve_bounds(node, args, CIL_USER, CIL_USERATTRIBUTE);
 			break;
 		case CIL_USERPREFIX:
 			rc = cil_resolve_userprefix(node, args);
@@ -3504,7 +3496,7 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 			rc = cil_resolve_roleallow(node, args);
 			break;
 		case CIL_ROLEBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_ROLE);
+			rc = cil_resolve_bounds(node, args, CIL_ROLE, CIL_ROLEATTRIBUTE);
 			break;
 		case CIL_LEVEL:
 			rc = cil_resolve_level(node, (struct cil_level*)node->data, args);
-- 
2.7.4
