Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB7G0pIG008035
 for <selinux@tycho.nsa.gov>; Mon, 7 Dec 2015 11:00:51 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Validate extended avrules and permissionxs
Date: Mon, 7 Dec 2015 11:00:44 -0500
Message-ID: <1449504044-11175-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Classes used in extended avrules and permissionxs must have an "ioctl"
permission. Add validation to ensure that is the case, or print an error
message otherwise.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_verify.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index c2d5ce9..36ec45a 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -43,6 +43,7 @@
 #include "cil_mem.h"
 #include "cil_tree.h"
 #include "cil_list.h"
+#include "cil_find.h"
 
 #include "cil_verify.h"
 
@@ -1226,6 +1227,59 @@ exit:
 	return rc;
 }
 
+int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node *node)
+{
+	int rc;
+	struct cil_list *classes = NULL;
+	struct cil_list_item *item;
+	struct cil_class *class;
+	struct cil_symtab_datum *perm_datum;
+	char *kind_str;
+
+	switch (permx->kind) {
+		case CIL_PERMX_KIND_IOCTL:
+			kind_str = CIL_KEY_IOCTL;
+			break;
+		default:
+			cil_log(CIL_ERR, "Invalid permissionx kind (%d) at line %d of %s\n", permx->kind, node->line, node->path);
+			rc = SEPOL_ERR;
+			goto exit;
+	}
+
+	classes = cil_expand_class(permx->obj);
+
+	cil_list_for_each(item, classes) {
+		class = item->data;
+		rc = cil_symtab_get_datum(&class->perms, kind_str, &perm_datum);
+		if (rc == SEPOL_ENOENT) {
+			if (class->common != NULL) {
+				rc = cil_symtab_get_datum(&class->common->perms, kind_str, &perm_datum);
+			}
+
+			if (rc == SEPOL_ENOENT) {
+				cil_log(CIL_ERR, "Invalid permissionx at line %d of %s: %s is not a permission of class %s\n", node->line, node->path, kind_str, class->datum.name);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+		}
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	if (classes != NULL) {
+		cil_list_destroy(&classes, CIL_FALSE);
+	}
+
+	return rc;
+}
+
+int __cil_verify_avrulex(struct cil_tree_node *node)
+{
+	struct cil_avrule *avrulex = node->data;
+	return __cil_verify_permissionx(avrulex->perms.x.permx, node);
+}
+
 int __cil_verify_class(struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -1420,6 +1474,12 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 		case CIL_FSUSE:
 			rc = __cil_verify_fsuse(db, node);
 			break;
+		case CIL_AVRULEX:
+			rc = __cil_verify_avrulex(node);
+			break;
+		case CIL_PERMISSIONX:
+			rc = __cil_verify_permissionx(node->data, node);
+			break;
 		case CIL_RANGETRANSITION:
 			rc = SEPOL_OK;
 			break;
-- 
2.4.3
