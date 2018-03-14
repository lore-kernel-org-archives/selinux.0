Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2EMI3wq005266
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 18:18:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id u5so2031570pfh.6
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 15:17:37 -0700 (PDT)
From: Tri Vo <trong@android.com>
To: selinux@tycho.nsa.gov
Cc: jeffv@google.com, dcashman@google.com, sspatil@google.com,
 Tri Vo <trong@android.com>
Date: Wed, 14 Mar 2018 15:17:28 -0700
Message-Id: <20180314221728.115654-1-trong@android.com>
Subject: [PATCH] secilc: resolve conflicts in expandattribute.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When Android combines multiple .cil files from system.img and vendor.img
it's possible to have conflicting expandattribute statements, e.g.
 expandattribute hal_audio true;
 expandattribute hal_audio false;

This change deals with scenario be resolving the value of the
corresponding expandattribute to false. The rationale behind this
override is that true is used for reduce run-time lookups, while
false is used for tests which must pass.
---
 libsepol/cil/src/cil_resolve_ast.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index d1a5ed87..5c66f663 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -271,7 +271,6 @@ exit:
 
 int cil_type_used(struct cil_symtab_datum *datum, int used)
 {
-	int rc = SEPOL_ERR;
 	struct cil_typeattribute *attr = NULL;
 
 	if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
@@ -279,16 +278,13 @@ int cil_type_used(struct cil_symtab_datum *datum, int used)
 		attr->used |= used;
 		if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
 				(attr->used & CIL_ATTR_EXPAND_FALSE)) {
-			cil_log(CIL_ERR, "Conflicting use of expandtypeattribute. "
-					"Expandtypeattribute may be set to true or false "
-					"but not both. \n");
-			goto exit;
+			cil_log(CIL_WARN, "Conflicting use of expandtypeattribute. "
+					"Expandtypeattribute was set to both true or false for %s. "
+					"Resolving to false. \n", attr->datum.name);
+			attr->used ^= CIL_ATTR_EXPAND_TRUE;
 		}
 	}
-
 	return SEPOL_OK;
-exit:
-	return rc;
 }
 
 int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
-- 
2.16.2.804.g6dcf76e118-goog
