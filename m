Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MITiJa022475
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 14:29:44 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Do not allow categories/sensitivities inside
 blocks
Date: Fri, 22 May 2015 14:29:23 -0400
Message-ID: <1432319363-47838-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes https://github.com/SELinuxProject/cil/issues/2.

Sensitivities and categories generated from blocks use dots to indicate
namespacing. This could result in categories that contain ambiguous
ranges with categories declared in blocks.

Example:

    (category c0)
    (category c2)
    (block c0
        (category (c2))
        (filecon ... (s0 (c2)))
    )

The above policy results in the filecontext: ... s0:c0.c2. The categories c0.c2
could be interpreted as a range between c0 and c2 or it could be the namespaced
category c0.c2. Therefore, categories are no longer allowed inside blocks to
eliminate this ambiguity.

This patch also disallows sensitivites in blocks for consistency with category
behavior.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 7d46fd5..c9738da 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -55,6 +55,7 @@ struct cil_args_resolve {
 	struct cil_tree_node *optstack;
 	struct cil_tree_node *boolif;
 	struct cil_tree_node *macro;
+	struct cil_tree_node *blockstack;
 	struct cil_list *sidorder_lists;
 	struct cil_list *classorder_lists;
 	struct cil_list *catorder_lists;
@@ -3248,6 +3249,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unu
 	enum cil_pass pass = args->pass;
 	struct cil_tree_node *optstack = args->optstack;
 	struct cil_tree_node *boolif = args->boolif;
+	struct cil_tree_node *blockstack = args->blockstack;
 
 	if (node == NULL) {
 		goto exit;
@@ -3262,6 +3264,14 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unu
 		}
 	}
 
+	if (blockstack != NULL) {
+		if (node->flavor == CIL_CAT || node->flavor == CIL_SENS) {
+			cil_log(CIL_ERR, "%s statement is not allowed in blocks (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+	}
+
 	if (boolif != NULL) {
 		if (!(node->flavor == CIL_CONDBLOCK ||
 			node->flavor == CIL_AVRULE ||
@@ -3318,6 +3328,8 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
 	struct cil_tree_node *callstack = NULL;
 	struct cil_tree_node *optstack = NULL;
 	struct cil_tree_node *parent = NULL;
+	struct cil_tree_node *blockstack = NULL;
+	struct cil_tree_node *new = NULL;
 
 	if (current == NULL || extra_args == NULL) {
 		goto exit;
@@ -3326,10 +3338,10 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
 	callstack = args->callstack;
 	optstack = args->optstack;
 	parent = current->parent;
+	blockstack = args->blockstack;
 
-	if (parent->flavor == CIL_CALL || parent->flavor == CIL_OPTIONAL) {
+	if (parent->flavor == CIL_CALL || parent->flavor == CIL_OPTIONAL || parent->flavor == CIL_BLOCK) {
 		/* push this node onto a stack */
-		struct cil_tree_node *new;
 		cil_tree_node_init(&new);
 
 		new->data = parent->data;
@@ -3358,6 +3370,12 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
 				new->cl_head = optstack;
 			}
 			args->optstack = new;
+		} else if (parent->flavor == CIL_BLOCK) {
+			if (blockstack != NULL) {
+				blockstack->parent = new;
+				new->cl_head = blockstack;
+			}
+			args->blockstack = new;
 		}
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = parent;
@@ -3377,6 +3395,7 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
 	struct cil_tree_node *parent = NULL;
+	struct cil_tree_node *blockstack = NULL;
 
 	if (current == NULL ||  extra_args == NULL) {
 		goto exit;
@@ -3411,6 +3430,14 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 		free(optstack);
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = NULL;
+	} else if (parent->flavor == CIL_BLOCK) {
+		/* pop off the stack */
+		blockstack = args->blockstack;
+		args->blockstack = blockstack->cl_head;
+		if (blockstack->cl_head) {
+			blockstack->cl_head->parent = NULL;
+		}
+		free(blockstack);
 	}
 
 	return SEPOL_OK;
@@ -3442,6 +3469,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.catorder_lists = NULL;
 	extra_args.sensitivityorder_lists = NULL;
 	extra_args.in_list = NULL;
+	extra_args.blockstack = NULL;
 
 	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
@@ -3536,6 +3564,12 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 			free(curr);
 			extra_args.optstack = next;
 		}
+		while (extra_args.blockstack!= NULL) {
+			struct cil_tree_node *curr = extra_args.blockstack;
+			struct cil_tree_node *next = curr->cl_head;
+			free(curr);
+			extra_args.blockstack= next;
+		}
 	}
 
 	rc = __cil_verify_initsids(db->sidorder);
-- 
1.9.3
