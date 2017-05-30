Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UGWcTH022136
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 12:32:40 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/1] libsepol/cil: fix aliasactual resolution errors
Date: Tue, 30 May 2017 12:32:06 -0400
Message-ID: <20170530163206.30421-1-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Set rc to SEPOL_ERR if the alias part of an aliasactual statement
  does not resolve to the correct alias flavor (e.g. typealias, senalias, catalias)
- Add an error check if the actual part of an aliasactual statement
  does not resolve to the correct actual flavor (type, sens, cat)

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a671068..5c26530 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -521,6 +521,7 @@ int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enu
 	}
 	if (NODE(alias_datum)->flavor != alias_flavor) {
 		cil_log(CIL_ERR, "%s is not an alias\n",alias_datum->name);
+		rc = SEPOL_ERR;
 		goto exit;
 	}
 
@@ -529,6 +530,12 @@ int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enu
 		goto exit;
 	}
 
+	if (NODE(actual_datum)->flavor != flavor) {
+		cil_log(CIL_ERR, "%s is a %s, but aliases a %s\n", alias_datum->name, cil_node_to_string(NODE(alias_datum)), cil_node_to_string(NODE(actual_datum)));
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	alias = (struct cil_alias *)alias_datum;
 
 	if (alias->actual != NULL) {
-- 
2.9.4
