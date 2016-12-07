Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7CGQM5031145
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 07:16:27 -0500
Received: from workstation.localdomain ([185.34.9.224]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MWgND-1cBRhh38IN-00XwJ5 for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2016
 13:16:18 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol/cil: remove avrules with no affected types
Date: Wed,  7 Dec 2016 12:15:59 +0000
Message-Id: <1481112959-26208-2-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1481112959-26208-1-git-send-email-gary.tierney@gmx.com>
References: <1481112959-26208-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds a check for avrules with type attributes that have a bitmap cardinality
of 0 (i.e., no types in their set) before adding them to the libsepol policy in
__cil_avrule_to_avtab().  Also adds an exception for neverallow rules to
prevent breaking anything from AOSP mentioned in
f9927d9370f90bd9d975ff933fe107ec4f93a9ac.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsepol/cil/src/cil_binary.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index d33981b..3aa350a 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1411,6 +1411,48 @@ exit:
 	return rc;
 }
 
+static int __cil_type_datum_is_unused_attrib(struct cil_symtab_datum *src)
+{
+	struct cil_tree_node *node = NULL;
+	struct cil_typeattribute *attrib = NULL;
+
+	if (src->fqn == CIL_KEY_SELF) {
+		return CIL_FALSE;
+	}
+
+	node = src->nodes->head->data;
+
+	if (node->flavor != CIL_TYPEATTRIBUTE) {
+		return CIL_FALSE;
+	}
+
+	attrib = (struct cil_typeattribute *) src;
+	return ebitmap_cardinality(attrib->types) == 0;
+}
+
+static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)
+{
+	struct cil_symtab_datum *src = cil_avrule->src;
+	struct cil_symtab_datum *tgt = cil_avrule->tgt;
+
+	// Don't remove neverallow rules so they are written to
+	// the resulting policy and can be checked by tools in
+	// AOSP.
+	if (cil_avrule->rule_kind == CIL_AVRULE_NEVERALLOW) {
+		return CIL_FALSE;
+	}
+
+	if (__cil_type_datum_is_unused_attrib(src)) {
+		return CIL_TRUE;
+	}
+
+	if (__cil_type_datum_is_unused_attrib(tgt)) {
+		return CIL_TRUE;
+	}
+
+	return CIL_FALSE;
+}
+
 int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
@@ -1425,6 +1467,11 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 		goto exit;
 	}
 
+	if (__cil_avrule_can_remove(cil_avrule)) {
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
 	src = cil_avrule->src;
 	tgt = cil_avrule->tgt;
 
-- 
2.4.11
