Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6SEd3wo012812
 for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2016 10:39:03 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol/cil: Warn instead of fail if permission is not
 resolve
Date: Thu, 28 Jul 2016 10:39:14 -0400
Message-Id: <1469716754-11698-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If a policy module package has been created with a policy that contains
a permission and then is used on a system without that permission CIL
will fail with an error when it cannot resolve the permission.

This will prevent the installation on policy and the user will not
know that the policy has not been installed.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 70e4462..8348d57 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -131,10 +131,10 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
 				}
 			}
 			if (rc != SEPOL_OK) {
-				cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
-				goto exit;
+				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
+			} else {
+				cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
 			}
-			cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
 		} else {
 			cil_list_append(*perm_datums, curr->flavor, curr->data);
 		}
@@ -3660,7 +3660,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 			rc = SEPOL_OK;
 		}
 
-		cil_tree_log(node, lvl, "Failed to resolve '%s' in %s statement", args->last_resolved_name, cil_node_to_string(node));
+		cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
 		goto exit;
 	}
 
-- 
2.7.4
