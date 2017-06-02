Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v52BLNi5003401
 for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2017 07:21:23 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: fix error check in new cil_resolve_name
Date: Fri, 2 Jun 2017 07:21:07 -0400
Message-ID: <20170602112107.16109-1-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This prevented cil_resolve_name() from returning an actual thing when a
name resolved to an alias. This appears to have only affected resolution
dealing with sensitivity and category aliases. Type aliases were not
affected since places that dealt with types handled type aliases
specifically and did not rely on this behavior from cil_resolve_name().

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index fc44a5e..d1a5ed8 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4125,7 +4125,7 @@ int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_in
 	struct cil_tree_node *node = NULL;
 
 	rc = cil_resolve_name_keep_aliases(ast_node, name, sym_index, extra_args, datum);
-	if (rc != SEPOL_ERR) {
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-- 
2.9.4
