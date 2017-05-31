Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4VI5da5017529
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 14:05:39 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2 v2] libsepol: Fix module_to_cil's handling of type aliases
Date: Wed, 31 May 2017 14:06:33 -0400
Message-Id: <20170531180633.19008-2-jwcart2@tycho.nsa.gov>
In-Reply-To: <20170531180633.19008-1-jwcart2@tycho.nsa.gov>
References: <20170531180633.19008-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Type aliases present a problem for module_to_cil because they are not
in the sym_val_to_name table that it uses to write declarations. Type
aliases are gathered by going through the decl_ids list and then
the alias declaration is written out when the block with that scope
id is handled. This doesn't work if a type alias appears in a require
block, since the require cannot be distinguished from the declaration.
The result is two declarations of the alias and an error when secilc
compiles the policy.

Because of the work cleaning up scope handling, the alias declaration
will always be at the end of the decl_ids list, so now only gather
the last scope id.

Also, when an alias is used in a module it is required as a type and
it will appear in the sym_val_to_name table. When that occurs, just
skip the alias when writing out types.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 77e1219..51e7853 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -323,7 +323,7 @@ static int typealiases_gather_map(char *key, void *data, void *arg)
 	struct type_datum *type = data;
 	struct policydb *pdb = arg;
 	struct scope_datum *scope;
-	uint32_t i;
+	uint32_t len;
 	uint32_t scope_id;
 
 	if (type->primary != 1) {
@@ -332,8 +332,9 @@ static int typealiases_gather_map(char *key, void *data, void *arg)
 			return -1;
 		}
 
-		for (i = 0; i < scope->decl_ids_len; i++) {
-			scope_id = scope->decl_ids[i];
+		len = scope->decl_ids_len;
+		if (len > 0) {
+			scope_id = scope->decl_ids[len-1];
 			if (typealias_lists[scope_id] == NULL) {
 				rc = list_init(&typealias_lists[scope_id]);
 				if (rc != 0) {
@@ -2274,6 +2275,8 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_printf("))\n");
 		}
 		break;
+	case TYPE_ALIAS:
+		break;
 	default:
 		log_err("Unknown flavor (%i) of type %s", type->flavor, key);
 		rc = -1;
@@ -3387,6 +3390,7 @@ static int typealiases_to_cil(int indent, struct policydb *pdb, struct avrule_bl
 {
 	struct type_datum *alias_datum;
 	char *alias_name;
+	char *type_name;
 	struct list_node *curr;
 	struct avrule_decl *decl = stack_peek(decl_stack);
 	struct list *alias_list = typealias_lists[decl->decl_id];
@@ -3403,9 +3407,13 @@ static int typealiases_to_cil(int indent, struct policydb *pdb, struct avrule_bl
 			rc = -1;
 			goto exit;
 		}
-
+		if (alias_datum->flavor == TYPE_ALIAS) {
+			type_name = pdb->p_type_val_to_name[alias_datum->primary - 1];
+		} else {
+			type_name = pdb->p_type_val_to_name[alias_datum->s.value - 1];
+		}
 		cil_println(indent, "(typealias %s)", alias_name);
-		cil_println(indent, "(typealiasactual %s %s)", alias_name, pdb->p_type_val_to_name[alias_datum->s.value - 1]);
+		cil_println(indent, "(typealiasactual %s %s)", alias_name, type_name);
 	}
 
 	return 0;
-- 
2.9.4
