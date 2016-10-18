Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVje022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:32 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] libsepol/cil: Verify alias in aliasactual statement is
 really an alias
Date: Tue, 18 Oct 2016 14:58:47 -0400
Message-Id: <1476817128-16108-7-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that the statement
"(sensitivityaliasactual SENS SENS)" will cause a segfault.

The segfault occurs because when the aliasactual is resolved the first
identifier is assumed to refer to an alias structure, but it is not.

Add a check to verify that the datum retrieved is actually an alias
and exit with an error if it is not.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f3f3e92..149e4f4 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -452,7 +452,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor)
+int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
 {
 	int rc = SEPOL_ERR;
 	enum cil_sym_index sym_index;
@@ -465,10 +465,15 @@ int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enu
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
+
 	rc = cil_resolve_name(current, aliasactual->alias_str, sym_index, extra_args, &alias_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
+	if (NODE(alias_datum)->flavor != alias_flavor) {
+		cil_log(CIL_ERR, "%s is not an alias\n",alias_datum->name);
+		goto exit;
+	}
 
 	rc = cil_resolve_name(current, aliasactual->actual_str, sym_index, extra_args, &actual_datum);
 	if (rc != SEPOL_OK) {
@@ -3365,13 +3370,13 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	case CIL_PASS_ALIAS1:
 		switch (node->flavor) {
 		case CIL_TYPEALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_TYPE);
+			rc = cil_resolve_aliasactual(node, args, CIL_TYPE, CIL_TYPEALIAS);
 			break;
 		case CIL_SENSALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_SENS);
+			rc = cil_resolve_aliasactual(node, args, CIL_SENS, CIL_SENSALIAS);
 			break;
 		case CIL_CATALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_CAT);
+			rc = cil_resolve_aliasactual(node, args, CIL_CAT, CIL_CATALIAS);
 			break;
 		default: 
 			break;
-- 
2.7.4
