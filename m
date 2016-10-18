Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjd022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:32 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/7] libsepol/cil: Check that permission is not an empty list
Date: Tue, 18 Oct 2016 14:58:46 -0400
Message-Id: <1476817128-16108-6-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that the statement
"(class C (()))" will cause a segfault.

CIL expects a list of permissions in the class declaration and "(())"
is a valid list. Each item of the list is expected to be an identifier
and as the list is processed each item is checked to see if it is a
list. An error is given if it is a list, otherwise the item is assumed
to be an identifier. Unfortunately, the check only works if the list
is not empty. In this case, the item passes the check and is assumed
to be an identifier and a NULL is passed as the string for name
verification. If name verification assumes that a non-NULL value will
be passed in, a segfault will occur.

Add a check for an empty list when processing a permission list and
improve the error handling for permissions when building the AST.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_build_ast.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index ee283b5..e4a0539 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -482,6 +482,10 @@ int cil_gen_perm(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	cil_perm_init(&perm);
 
 	key = parse_current->data;
+	if (key == NULL) {
+		cil_log(CIL_ERR, "Bad permission\n");
+		goto exit;
+	}
 
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)perm, (hashtab_key_t)key, CIL_SYM_PERMS, flavor);
 	if (rc != SEPOL_OK) {
@@ -529,6 +533,7 @@ int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, st
 
 		rc = cil_gen_perm(db, current_perm, new_ast, flavor, num_perms);
 		if (rc != SEPOL_OK) {
+			cil_tree_node_destroy(&new_ast);
 			goto exit;
 		}
 
@@ -546,6 +551,8 @@ int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, st
 
 exit:
 	cil_log(CIL_ERR, "Bad permissions\n");
+	cil_tree_children_destroy(ast_node);
+	cil_clear_node(ast_node);
 	return rc;
 }
 
-- 
2.7.4
