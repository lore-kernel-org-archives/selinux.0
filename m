Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIH9001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:23 -0400
Received: by mail-pa0-f53.google.com with SMTP id cm16so20661783pac.0
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:22 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 5/5] libsepol: cil: Add cil_constraint_expr_to_policy()
Date: Thu,  8 Sep 2016 13:30:52 -0700
Message-Id: <1473366652-23929-6-git-send-email-dcashman@android.com>
In-Reply-To: <1473366652-23929-5-git-send-email-dcashman@android.com>
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <1473366652-23929-2-git-send-email-dcashman@android.com>
 <1473366652-23929-3-git-send-email-dcashman@android.com>
 <1473366652-23929-4-git-send-email-dcashman@android.com>
 <1473366652-23929-5-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

The current cil_expr_to_policy() does not properly hanlde the case where
CIL_OP is at the beginning of an expression.  Create a new function,
cil_constraint_expr_to_policy() rather than modifying the original,
since the expression syntax for constraint expressions requires this
ability, but the existing cil_expr_to_policy() function has many other
consumers.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_policy.c | 211 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 32b6b41..e5ca091 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -84,6 +84,8 @@ struct cil_args_booleanif {
 
 int cil_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr);
 
+int cil_constraint_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr);
+
 int cil_combine_policy(FILE **file_arr, FILE *policy_file)
 {
 	char temp[BUFFER];
@@ -515,7 +517,7 @@ void cil_constrain_to_policy_helper(FILE **file_arr, char *kind, struct cil_list
 				fprintf(file_arr[CONSTRAINS], "%s %s", kind, cp->class->datum.name);
 				cil_perms_to_policy(file_arr, CONSTRAINS, cp->perms);
 				fprintf(file_arr[CONSTRAINS], "\n\t");
-				cil_expr_to_policy(file_arr, CONSTRAINS, expr);
+				cil_constraint_expr_to_policy(file_arr, CONSTRAINS, expr);
 				fprintf(file_arr[CONSTRAINS], ";\n");
 			} else { /* MAP */
 				struct cil_list_item *i = NULL;
@@ -811,6 +813,195 @@ exit:
 	return rc;
 }
 
+static int cil_constraint_expr_to_string(struct cil_list *expr, char **out)
+{
+	int rc = SEPOL_ERR;
+	struct cil_list_item *curr;
+	const size_t CONS_DEPTH = 3;
+	char *stack[CONS_DEPTH] = {}; // 1 operator + 1 - 2 operands
+	size_t pos = 0;
+	size_t i;
+
+	cil_list_for_each(curr, expr) {
+		if (pos >= CONS_DEPTH) {
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+		switch (curr->flavor) {
+		case CIL_LIST:
+			rc = cil_constraint_expr_to_string(curr->data, &stack[pos]);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+			pos++;
+			break;
+		case CIL_STRING:
+			stack[pos] = strdup(curr->data);
+			if (!stack[pos]) {
+				cil_log(CIL_ERR, "OOM. Unable to convert cons_expr to string\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			pos++;
+			break;
+		case CIL_DATUM:
+			stack[pos] = strdup(((struct cil_symtab_datum *)curr->data)->name);
+			if (!stack[pos]) {
+				cil_log(CIL_ERR, "OOM. Unable to convert cons_expr to string\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			pos++;
+			break;
+		case CIL_OP: {
+			enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
+			char *op_str = NULL;
+
+			if (pos != 0) {
+				/* ops come before the operand(s) */
+				cil_log(CIL_ERR, "CIL_OP encountered at incorrect offset\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			switch (op_flavor) {
+			case CIL_AND:
+				op_str = CIL_KEY_AND;
+				break;
+			case CIL_OR:
+				op_str = CIL_KEY_OR;
+				break;
+			case CIL_NOT:
+				op_str = CIL_KEY_NOT;
+				break;
+			case CIL_ALL:
+				op_str = CIL_KEY_ALL;
+				break;
+			case CIL_EQ:
+				op_str = CIL_KEY_EQ;
+				break;
+			case CIL_NEQ:
+				op_str = CIL_KEY_NEQ;
+				break;
+			case CIL_XOR:
+				op_str = CIL_KEY_XOR;
+				break;
+			case CIL_CONS_DOM:
+				op_str = CIL_KEY_CONS_DOM;
+				break;
+			case CIL_CONS_DOMBY:
+				op_str = CIL_KEY_CONS_DOMBY;
+				break;
+			case CIL_CONS_INCOMP:
+				op_str = CIL_KEY_CONS_INCOMP;
+				break;
+			default:
+				cil_log(CIL_ERR, "Unknown operator in expression\n");
+				rc = SEPOL_ERR;
+				goto exit;
+				break;
+			}
+			stack[pos] = strdup(op_str);
+			if (!stack[pos]) {
+				cil_log(CIL_ERR, "OOM. Unable to convert cons_expr to string\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			pos++;
+			break;
+		}
+		case CIL_CONS_OPERAND: {
+			enum cil_flavor operand_flavor = (enum cil_flavor)curr->data;
+			char *operand_str = NULL;
+			switch (operand_flavor) {
+			case CIL_CONS_U1:
+				operand_str = CIL_KEY_CONS_U1;
+				break;
+			case CIL_CONS_U2:
+				operand_str = CIL_KEY_CONS_U2;
+				break;
+			case CIL_CONS_U3:
+				operand_str = CIL_KEY_CONS_U3;
+				break;
+			case CIL_CONS_T1:
+				operand_str = CIL_KEY_CONS_T1;
+				break;
+			case CIL_CONS_T2:
+				operand_str = CIL_KEY_CONS_T2;
+				break;
+			case CIL_CONS_T3:
+				operand_str = CIL_KEY_CONS_T3;
+				break;
+			case CIL_CONS_R1:
+				operand_str = CIL_KEY_CONS_R1;
+				break;
+			case CIL_CONS_R2:
+				operand_str = CIL_KEY_CONS_R2;
+				break;
+			case CIL_CONS_R3:
+				operand_str = CIL_KEY_CONS_R3;
+				break;
+			case CIL_CONS_L1:
+				operand_str = CIL_KEY_CONS_L1;
+				break;
+			case CIL_CONS_L2:
+				operand_str = CIL_KEY_CONS_L2;
+				break;
+			case CIL_CONS_H1:
+				operand_str = CIL_KEY_CONS_H1;
+				break;
+			case CIL_CONS_H2:
+				operand_str = CIL_KEY_CONS_H2;
+				break;
+			default:
+				cil_log(CIL_ERR, "Unknown operand in expression\n");
+				goto exit;
+				break;
+			}
+			stack[pos] = strdup(operand_str);
+			if (!stack[pos]) {
+				cil_log(CIL_ERR, "OOM. Unable to convert cons_expr to string\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			pos++;
+			break;
+		}
+		default:
+			cil_log(CIL_ERR, "Unknown flavor in expression\n");
+			rc = SEPOL_ERR;
+			goto exit;
+			break;
+		}
+	}
+	if (pos > 3) {
+		cil_log(CIL_ERR, "Illegal CIL expr: more than 3 components\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+	size_t len;
+	char *expr_str;
+	if (!strcmp(stack[0], CIL_KEY_NOT)) {
+		/* All ops take 2 operands except for CIL_KEY_NOT */
+		len = strlen(stack[0]) + strlen(stack[1]) + 4;
+		expr_str = cil_malloc(len);
+		snprintf(expr_str, len, "(%s %s)", stack[0], stack[1]);
+		/* free() done below */
+	} else {
+		len = strlen(stack[0]) + strlen(stack[1]) + strlen(stack[2]) + 5;
+		expr_str = cil_malloc(len);
+		snprintf(expr_str, len, "(%s %s %s)", stack[1], stack[0], stack[2]);
+		/* free() done below */
+	}
+	*out = expr_str;
+	rc = SEPOL_OK;
+exit:
+	for (i = 0; i < pos; i++) {
+		free(stack[i]);
+		stack[i] = NULL;
+	}
+	return rc;
+}
+
 int cil_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
@@ -829,6 +1020,24 @@ out:
 	return rc;
 }
 
+int cil_constraint_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr)
+{
+	int rc = SEPOL_ERR;
+	char *str_out;
+
+	rc = cil_constraint_expr_to_string(expr, &str_out);
+	if (rc != SEPOL_OK) {
+		goto out;
+	}
+	fprintf(file_arr[file_index], "%s", str_out);
+	free(str_out);
+
+	return SEPOL_OK;
+
+out:
+	return rc;
+}
+
 int __cil_booleanif_node_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
-- 
2.8.0.rc3.226.g39d4020
