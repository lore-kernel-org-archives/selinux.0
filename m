Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UJCAQl026091
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 15:12:10 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol: Clean up scope handling
Date: Tue, 30 May 2017 15:13:03 -0400
Message-Id: <20170530191304.29886-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently, when checking if an identifier is enabled, each scope in
the decl_ids list is checked. This means that if any block that
requires the identifier is enabled, then the identifier will be treated
as being declared.

Now, declarations will be kept at the end of the decl_ids list and
when checking if an identifier is enabled, only the last scope will
be checked (Except for roles and users which allow multiple declarations,
they will have to keep the old behavior.)

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/avrule_block.c | 24 ++++++++++++++++++++----
 libsepol/src/policydb.c     | 13 +++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 224e999..e1f460e 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -156,20 +156,36 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
 {
 	scope_datum_t *scope =
 	    (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
-	uint32_t i;
+	avrule_decl_t *decl;
+	uint32_t len = scope->decl_ids_len;
+
 	if (scope == NULL) {
 		return 0;
 	}
 	if (scope->scope != SCOPE_DECL) {
 		return 0;
 	}
-	for (i = 0; i < scope->decl_ids_len; i++) {
-		avrule_decl_t *decl =
-		    p->decl_val_to_struct[scope->decl_ids[i] - 1];
+
+	if (len < 1) {
+		return 0;
+	}
+
+	if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
+		uint32_t i;
+		for (i = 0; i < len; i++) {
+			avrule_decl_t *decl =
+				p->decl_val_to_struct[scope->decl_ids[i] - 1];
+			if (decl != NULL && decl->enabled) {
+				return 1;
+			}
+		}
+	} else {
+		decl = p->decl_val_to_struct[scope->decl_ids[len-1] - 1];
 		if (decl != NULL && decl->enabled) {
 			return 1;
 		}
 	}
+
 	return 0;
 }
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b153095..ff4fc4e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1698,6 +1698,19 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 		return -ENOMEM;
 	}
 
+	if (scope_datum->scope == SCOPE_DECL && scope == SCOPE_REQ) {
+		/* Need to keep the decl at the end of the list */
+		uint32_t len, tmp;
+		len = scope_datum->decl_ids_len;
+		if (len < 2) {
+			/* This should be impossible here */
+			return -1;
+		}
+		tmp = scope_datum->decl_ids[len-2];
+		scope_datum->decl_ids[len-2] = scope_datum->decl_ids[len-1];
+		scope_datum->decl_ids[len-1] = tmp;
+	}
+
 	return retval;
 }
 
-- 
2.9.4
