Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAF2R56W013350
 for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2017 21:27:05 -0500
Received: by mail-io0-f195.google.com with SMTP id 134so26408014ioo.0
 for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2017 16:44:50 -0800 (PST)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman@google.com, Daniel Cashman <dcashman@android.com>
Date: Tue, 14 Nov 2017 16:44:35 -0800
Message-Id: <20171115004436.108424-1-dcashman@android.com>
Subject: [PATCH] libsepol: cil: only overwrite cil_typeattribute
 used when false.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Cashman <dcashman@google.com>

When using cil_db multiple_decls, the different cil_attribute nodes
all point to the same underlying cil_attribute struct.  This leads
to problems, though, when modifying the used value in the struct.
__cil_post_db_attr() changes the value of the field to based on
the output of cil_typeattribute_used(), for use later in
cil_typeattribute_to_policydb and cil_typeattribute_to_bitmap, but
due to the multiple declarations, cil_typeattribute_used() could be called
again by a second node.  In this second call, the value used is the
modifed value of CIL_TRUE or CIL_FALSE, not the flags actually needed.
This could result in the field being reset again, to an incorrect CIL_FALSE
value.  To avoid this, only change the value of the field if it is to
be set to CIL_FALSE.  Also update the checks that use this value to
explicitly check for CIL_FALSE, rather than relying on its underlying
value.

Alternatively, a different field could be used rather than overwriting the
'used' field, attrib structs could be un-shared, or duplicate declarations
could just be skipped rather than sticking around in the tree.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_binary.c | 6 +++---
 libsepol/cil/src/cil_post.c   | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index c0ca60f2..e4003c8b 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -567,8 +567,8 @@ int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil
 	char *key = NULL;
 	type_datum_t *sepol_attr = NULL;
 
-	if (!cil_attr->used) {
-		return SEPOL_OK;		
+	if (cil_attr->used == CIL_FALSE) {
+		return SEPOL_OK;
 	}
 
 	sepol_attr = cil_malloc(sizeof(*sepol_attr));
@@ -632,7 +632,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const struct cil_db *db, struct
 	ebitmap_node_t *tnode;
 	unsigned int i;
 
-	if (!cil_attr->used) {
+	if (cil_attr->used == CIL_FALSE) {
 		return SEPOL_OK;
 	}
 
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 3e013c97..823ecf0f 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1369,7 +1369,8 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, uint32_t *finis
 			rc = __evaluate_type_expression(attr, db);
 			if (rc != SEPOL_OK) goto exit;
 		}
-		attr->used = cil_typeattribute_used(attr, db);
+		if (cil_typeattribute_used(attr, db) == CIL_FALSE)
+			attr->used = CIL_FALSE;
 		break;
 	}
 	case CIL_ROLEATTRIBUTE: {
-- 
2.15.0.448.gf294e3d99a-goog
