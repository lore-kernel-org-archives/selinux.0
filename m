From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] dispol: Extend to display operations.
Date: Thu, 23 Apr 2015 08:39:28 -0400
Message-Id: <1429792768-21986-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Also drop expanding of rules; just display the rules in their
original form.  I think expansion was a relic of an older policy
version where we did not preserve attributes in the kernel policy.
In any event, it seems more useful to display the rules unmodified.

Change-Id: I85095a35cfb48138cd9cf01cde6dd0330e342c61
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/test/dispol.c | 77 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 0333bcc..133759f 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -21,7 +21,6 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/util.h>
 #include <sepol/policydb/polcaps.h>
 #include <getopt.h>
@@ -55,6 +54,29 @@ int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
 	return 0;
 }
 
+#define operation_perm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
+
+int render_operations(avtab_operations_t *ops, avtab_key_t * key, FILE * fp)
+{
+	uint16_t value;
+	unsigned int bit = 0;
+
+	fprintf(fp, "{ ");
+	for (bit = 0; bit < sizeof(ops->perms)*8; bit++) {
+		if (!operation_perm_test(bit, ops->perms))
+			continue;
+		if (key->specified & AVTAB_OPNUM) {
+			value = ops->type<<8 | bit;
+			fprintf(fp, "0x%hx ", value);
+		} else if (key->specified & AVTAB_OPTYPE) {
+			value = bit << 8;
+			fprintf(fp, "0x%hx-0x%hx ", value, value|0xff);
+		}
+	}
+	fprintf(fp, "}");
+	return 0;
+}
+
 int render_type(uint32_t type, policydb_t * p, FILE * fp)
 {
 	fprintf(fp, "%s", p->p_type_val_to_name[type - 1]);
@@ -148,6 +170,16 @@ int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
 			render_type(datum->data, p, fp);
 			fprintf(fp, ";\n");
 		}
+	} else if (key->specified & AVTAB_OP) {
+		if (key->specified & (AVTAB_OPNUM_ALLOWED|AVTAB_OPTYPE_ALLOWED))
+			fprintf(fp, "allow ");
+		else if (key->specified & (AVTAB_OPNUM_AUDITALLOW|AVTAB_OPTYPE_AUDITALLOW))
+			fprintf(fp, "auditallow ");
+		else if (key->specified & (AVTAB_OPNUM_DONTAUDIT|AVTAB_OPTYPE_DONTAUDIT))
+			fprintf(fp, "dontaudit ");
+		render_key(key, p, fp);
+		render_operations(datum->ops, key, fp);
+		fprintf(fp, ";\n");
 	} else {
 		fprintf(fp, "     ERROR: no valid rule type specified\n");
 		return -1;
@@ -159,27 +191,15 @@ int display_avtab(avtab_t * a, uint32_t what, policydb_t * p, FILE * fp)
 {
 	unsigned int i;
 	avtab_ptr_t cur;
-	avtab_t expa;
-
-	if (avtab_init(&expa))
-		goto oom;
-	if (expand_avtab(p, a, &expa)) {
-		avtab_destroy(&expa);
-		goto oom;
-	}
 
 	/* hmm...should have used avtab_map. */
-	for (i = 0; i < expa.nslot; i++) {
-		for (cur = expa.htable[i]; cur; cur = cur->next) {
+	for (i = 0; i < a->nslot; i++) {
+		for (cur = a->htable[i]; cur; cur = cur->next) {
 			render_av_rule(&cur->key, &cur->datum, what, p, fp);
 		}
 	}
-	avtab_destroy(&expa);
 	fprintf(fp, "\n");
 	return 0;
-      oom:
-	fprintf(stderr, "out of memory\n");
-	return 1;
 }
 
 int display_bools(policydb_t * p, FILE * fp)
@@ -231,47 +251,26 @@ void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 int display_cond_expressions(policydb_t * p, FILE * fp)
 {
 	cond_node_t *cur;
-	cond_av_list_t *av_cur, *expl = NULL;
-	avtab_t expa;
+	cond_av_list_t *av_cur;
 
 	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
 		fprintf(fp, "expression: ");
 		display_expr(p, cur->expr, fp);
 		fprintf(fp, "current state: %d\n", cur->cur_state);
 		fprintf(fp, "True list:\n");
-		if (avtab_init(&expa))
-			goto oom;
-		if (expand_cond_av_list(p, cur->true_list, &expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
-		for (av_cur = expl; av_cur != NULL; av_cur = av_cur->next) {
+		for (av_cur = cur->true_list; av_cur != NULL; av_cur = av_cur->next) {
 			fprintf(fp, "\t");
 			render_av_rule(&av_cur->node->key, &av_cur->node->datum,
 				       RENDER_CONDITIONAL, p, fp);
 		}
-		cond_av_list_destroy(expl);
-		avtab_destroy(&expa);
 		fprintf(fp, "False list:\n");
-		if (avtab_init(&expa))
-			goto oom;
-		if (expand_cond_av_list(p, cur->false_list, &expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
-		for (av_cur = expl; av_cur != NULL; av_cur = av_cur->next) {
+		for (av_cur = cur->false_list; av_cur != NULL; av_cur = av_cur->next) {
 			fprintf(fp, "\t");
 			render_av_rule(&av_cur->node->key, &av_cur->node->datum,
 				       RENDER_CONDITIONAL, p, fp);
 		}
-		cond_av_list_destroy(expl);
-		avtab_destroy(&expa);
 	}
 	return 0;
-
-      oom:
-	fprintf(stderr, "out of memory\n");
-	return 1;
 }
 
 int display_handle_unknown(policydb_t * p, FILE * out_fp)
-- 
2.1.0
