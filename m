Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAII5o82004033
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 13:05:50 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol/cil: Add ability to write policy.conf file from
 CIL AST
Date: Fri, 18 Nov 2016 13:05:27 -0500
Message-Id: <1479492328-12238-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The ability to create a policy.conf file from the CIL AST has been
a desire from the beginning to assist in debugging and for general
flexibility. Some work towards this end was started early in CIL's
history, but cil_policy.c has not been remotely functional in a long
time. Until now.

The function cil_gen_policy() will write a policy.conf file from a
CIL AST after cil_build_ast(), cil_resolve_ast(), cil_fqn_qualify(),
and cil_post_process() have been called.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/include/cil/cil.h |    1 +
 libsepol/cil/src/cil.c         |    6 +
 libsepol/cil/src/cil_policy.c  | 2696 ++++++++++++++++++++++++----------------
 libsepol/cil/src/cil_policy.h  |   12 +-
 libsepol/src/libsepol.map.in   |    1 +
 5 files changed, 1611 insertions(+), 1105 deletions(-)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index e4b10c5..c4a6fb9 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -52,6 +52,7 @@ extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
 extern void cil_set_mls(cil_db_t *db, int mls);
 extern void cil_set_target_platform(cil_db_t *db, int target_platform);
 extern void cil_set_policy_version(cil_db_t *db, int policy_version);
+extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 9b18773..15833c13 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -461,6 +461,12 @@ exit:
 	return rc;
 }
 
+void cil_write_policy_conf(FILE *out, struct cil_db *db)
+{
+	cil_log(CIL_INFO, "Writing policy.conf file\n");
+	cil_gen_policy(out, db);
+}
+
 void cil_destroy_data(void **data, enum cil_flavor flavor)
 {
 	if (*data == NULL) {
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 382129b..d343ffa 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1,16 +1,16 @@
 /*
  * Copyright 2011 Tresys Technology, LLC. All rights reserved.
- * 
+ *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
- * 
+ *
  *    1. Redistributions of source code must retain the above copyright notice,
  *       this list of conditions and the following disclaimer.
- * 
+ *
  *    2. Redistributions in binary form must reproduce the above copyright notice,
  *       this list of conditions and the following disclaimer in the documentation
  *       and/or other materials provided with the distribution.
- * 
+ *
  * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
  * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
@@ -21,7 +21,7 @@
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
  * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- * 
+ *
  * The views and conclusions contained in the software and documentation are those
  * of the authors and should not be interpreted as representing official policies,
  * either expressed or implied, of Tresys Technology, LLC.
@@ -39,1063 +39,1413 @@
 
 #include "cil_internal.h"
 #include "cil_flavor.h"
-#include "cil_log.h"
+#include "cil_find.h"
 #include "cil_mem.h"
 #include "cil_tree.h"
 #include "cil_list.h"
-#include "cil_policy.h"
 #include "cil_symtab.h"
-#include "cil_strpool.h"
-
-#define SEPOL_DONE			555
-
-#define CLASS_DECL			0
-#define ISIDS				1
-#define COMMONS				2
-#define CLASSES				3
-#define INTERFACES			4
-#define SENS				5
-#define CATS				6
-#define LEVELS				7
-#define CONSTRAINS			8
-#define TYPEATTRTYPES			9
-#define ALIASES				10
-#define ALLOWS				11
-#define CONDS				12
-#define USERROLES			13
-#define SIDS				14
-#define NETIFCONS			15 
-
-#define BUFFER				1024
-#define NUM_POLICY_FILES		16
-
-struct cil_args_genpolicy {
-	struct cil_list *users;
-	struct cil_list *sens;
-	struct cil_list *cats;
-	FILE **file_arr;
-};
-
-struct cil_args_booleanif {
-	FILE **file_arr;
-	uint32_t *file_index;
-};
 
 
-int cil_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr);
+enum cil_statement_list {
+	CIL_LIST_COMMON = 1,
+	CIL_LIST_DEFAULT_USER,
+	CIL_LIST_DEFAULT_ROLE,
+	CIL_LIST_DEFAULT_TYPE,
+	CIL_LIST_DEFAULT_RANGE,
+	CIL_LIST_SENSALIAS,
+	CIL_LIST_CATALIAS,
+	CIL_LIST_MLSCONSTRAIN,
+	CIL_LIST_MLSVALIDATETRANS,
+	CIL_LIST_POLICYCAP,
+	CIL_LIST_TYPEATTRIBUTE,
+	CIL_LIST_ROLEATTRIBUTE,
+	CIL_LIST_BOOL,
+	CIL_LIST_TYPE,
+	CIL_LIST_TYPEALIAS,
+	CIL_LIST_ROLE,
+	CIL_LIST_ROLEALLOW,
+	CIL_LIST_ROLETRANSITION,
+	CIL_LIST_USER,
+	CIL_LIST_CONSTRAINT,
+	CIL_LIST_VALIDATETRANS,
+	CIL_LIST_NUM_LISTS
+};
 
-int cil_combine_policy(FILE **file_arr, FILE *policy_file)
+static int __cil_gather_statements_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
-	char temp[BUFFER];
-	int i, rc, rc_read, rc_write;
+	struct cil_list **lists;
+	int kind = 0;
 
-	for(i=0; i<NUM_POLICY_FILES; i++) {
-		fseek(file_arr[i], 0, SEEK_SET);
-		while (!feof(file_arr[i])) {
-			rc_read = fread(temp, 1, BUFFER, file_arr[i]);
-			if (rc_read == 0 && ferror(file_arr[i])) {
-				cil_log(CIL_ERR, "Error reading temp policy file\n");
-				return SEPOL_ERR;
-			}
-			rc_write = 0;
-			while (rc_read > rc_write) {
-				rc = fwrite(temp+rc_write, 1, rc_read-rc_write, policy_file);
-				rc_write += rc;
-				if (rc == 0 && ferror(file_arr[i])) {
-					cil_log(CIL_ERR, "Error writing to policy.conf\n");
-					return SEPOL_ERR;
-				}
-			}
+	lists = (struct cil_list **)extra_args;
+
+	switch (node->flavor) {
+	case CIL_BLOCK: {
+		struct cil_block *blk = node->data;
+		if (blk->is_abstract == CIL_TRUE) {
+			*finished = CIL_TREE_SKIP_HEAD;
+		}
+		break;
+	}
+	case CIL_MACRO:
+		*finished = CIL_TREE_SKIP_HEAD;
+		break;
+	case CIL_BOOLEANIF:
+		*finished = CIL_TREE_SKIP_HEAD;
+		break;
+	case CIL_COMMON:
+		kind = CIL_LIST_COMMON;
+		break;
+	case CIL_DEFAULTUSER:
+		kind = CIL_LIST_DEFAULT_USER;
+		break;
+	case CIL_DEFAULTROLE:
+		kind = CIL_LIST_DEFAULT_ROLE;
+		break;
+	case CIL_DEFAULTTYPE:
+		kind = CIL_LIST_DEFAULT_TYPE;
+		break;
+	case CIL_DEFAULTRANGE:
+		kind = CIL_LIST_DEFAULT_RANGE;
+		break;
+	case CIL_SENSALIAS:
+		kind = CIL_LIST_SENSALIAS;
+		break;
+	case CIL_CATALIAS:
+		kind = CIL_LIST_CATALIAS;
+		break;
+	case CIL_MLSCONSTRAIN:
+		kind = CIL_LIST_MLSCONSTRAIN;
+		break;
+	case CIL_MLSVALIDATETRANS:
+		kind = CIL_LIST_MLSVALIDATETRANS;
+		break;
+	case CIL_POLICYCAP:
+		kind = CIL_LIST_POLICYCAP;
+		break;
+	case CIL_TYPEATTRIBUTE: {
+		struct cil_typeattribute *attr = node->data;
+		if (attr->used) {
+			kind = CIL_LIST_TYPEATTRIBUTE;
+		}
+		break;
+	}
+	case CIL_ROLEATTRIBUTE: {
+		struct cil_roleattribute *attr = node->data;
+		if (strcmp(attr->datum.fqn, "cil_gen_require") != 0) {
+			kind = CIL_LIST_ROLEATTRIBUTE;
+		}
+		break;
+	}
+	case CIL_BOOL:
+		kind = CIL_LIST_BOOL;
+		break;
+	case CIL_TYPE:
+		kind = CIL_LIST_TYPE;
+		break;
+	case CIL_TYPEALIAS:
+		kind = CIL_LIST_TYPEALIAS;
+		break;
+	case CIL_ROLE: {
+		struct cil_role *role = node->data;
+		if (strcmp(role->datum.fqn, "object_r") != 0) {
+			kind = CIL_LIST_ROLE;
 		}
+		break;
+	}
+	case CIL_ROLEALLOW:
+		kind = CIL_LIST_ROLEALLOW;
+		break;
+	case CIL_ROLETRANSITION:
+		kind = CIL_LIST_ROLETRANSITION;
+		break;
+	case CIL_USER:
+		kind = CIL_LIST_USER;
+		break;
+	case CIL_CONSTRAIN:
+		kind = CIL_LIST_CONSTRAINT;
+		break;
+	case CIL_VALIDATETRANS:
+		kind = CIL_LIST_VALIDATETRANS;
+		break;
+	default:
+		break;
+	}
+
+	if (kind > 0) {
+		cil_list_append(lists[kind], node->flavor, node->data);
 	}
 
 	return SEPOL_OK;
 }
 
-int cil_portcon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static void cil_gather_statements(struct cil_tree_node *start, struct cil_list *lists[])
 {
-	uint32_t i = 0;
-
-	for (i=0; i<sort->count; i++) {
-		struct cil_portcon *portcon = (struct cil_portcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "portcon ");
-		if (portcon->proto == CIL_PROTOCOL_UDP) {
-			fprintf(file_arr[NETIFCONS], "udp ");
-		} else if (portcon->proto == CIL_PROTOCOL_TCP) {
-			fprintf(file_arr[NETIFCONS], "tcp ");
-		} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
-			fprintf(file_arr[NETIFCONS], "dccp ");
-		}
-		fprintf(file_arr[NETIFCONS], "%d ", portcon->port_low);
-		fprintf(file_arr[NETIFCONS], "%d ", portcon->port_high);
-		cil_context_to_policy(file_arr, NETIFCONS, portcon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
-	}
-
-	return SEPOL_OK;
+	cil_tree_walk(start, __cil_gather_statements_helper, NULL, NULL, lists);
 }
 
-int cil_genfscon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static void cil_simple_rules_to_policy(FILE *out, struct cil_list *rules, char *kind)
 {
-	uint32_t i = 0;
+	struct cil_list_item *i1;
 
-	for (i=0; i<sort->count; i++) {
-		struct cil_genfscon *genfscon = (struct cil_genfscon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "genfscon %s ", genfscon->fs_str);
-		fprintf(file_arr[NETIFCONS], "%s ", genfscon->path_str);
-		cil_context_to_policy(file_arr, NETIFCONS, genfscon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	cil_list_for_each(i1, rules) {
+		fprintf(out, "%s %s;\n", kind, DATUM(i1->data)->fqn);
 	}
-
-	return SEPOL_OK;
 }
 
-int cil_netifcon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static void cil_cats_to_policy(FILE *out, struct cil_cats *cats)
 {
-	uint32_t i = 0;
-
-	for (i=0; i<sort->count; i++) {
-		struct cil_netifcon *netifcon = (struct cil_netifcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "netifcon %s ", netifcon->interface_str);
-		cil_context_to_policy(file_arr, NETIFCONS, netifcon->if_context);
-		fprintf(file_arr[NETIFCONS], " ");
-		cil_context_to_policy(file_arr, NETIFCONS, netifcon->packet_context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	char lead = '\0';
+	struct cil_cat *first = NULL, *last = NULL, *cat;
+	struct cil_list_item *i1;
+
+	cil_list_for_each(i1, cats->datum_expr) {
+		cat = i1->data;
+		if (first == NULL) {
+			first = cat;
+		} else if (last == NULL) {
+			if (cat->value == first->value + 1) {
+				last = cat;
+			} else {
+				fprintf(out, "%c%s,%s", lead,
+					DATUM(first)->fqn, DATUM(cat)->fqn);
+				lead = ',';
+				first = NULL;
+			}
+		} else if (cat->value == last->value + 1) {
+			last = cat;
+		} else {
+			fprintf(out, "%c%s", lead, DATUM(first)->fqn);
+			if (last->value >= first->value + 1) {
+				fprintf(out, ".");
+			} else {
+				fprintf(out, ",");
+			}
+			fprintf(out, "%s", DATUM(last)->fqn);
+			lead = ',';
+			first = cat;
+			last = NULL;
+		}
+	}
+	if (first) {
+		fprintf(out, "%c%s", lead, DATUM(first)->fqn);
+		if (last != NULL) {
+			if (last->value >= first->value + 1) {
+				fprintf(out, ".");
+			} else {
+				fprintf(out, ",");
+			}
+			fprintf(out, "%s", DATUM(last)->fqn);
+		}
 	}
+}
 
-	return SEPOL_OK;
+static void cil_level_to_policy(FILE *out, struct cil_level *level)
+{
+	fprintf(out, "%s", DATUM(level->sens)->fqn);
+	if (level->cats != NULL) {
+		fprintf(out, ":");
+		cil_cats_to_policy(out, level->cats);
+	}
 }
 
-int cil_nodecon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static void cil_levelrange_to_policy(FILE *out, struct cil_levelrange *lvlrange)
 {
-	uint32_t i = 0;
-	int rc = SEPOL_ERR;
+	cil_level_to_policy(out, lvlrange->low);
+	if (lvlrange->low != lvlrange->high) {
+		fprintf(out, "-");
+		cil_level_to_policy(out, lvlrange->high);
+	}
+}
 
-	for (i=0; i<sort->count; i++) {
-		struct cil_nodecon *nodecon = (struct cil_nodecon*)sort->array[i];
-		char *buf = NULL;
-		errno = 0;
-		if (nodecon->addr->family == AF_INET) {
-			buf = cil_malloc(INET_ADDRSTRLEN);
-			inet_ntop(nodecon->addr->family, &nodecon->addr->ip.v4, buf, INET_ADDRSTRLEN);
-		} else if (nodecon->addr->family == AF_INET6) {
-			buf = cil_malloc(INET6_ADDRSTRLEN);
-			inet_ntop(nodecon->addr->family, &nodecon->addr->ip.v6, buf, INET6_ADDRSTRLEN);
-		}
+static void cil_context_to_policy(FILE *out, struct cil_context *context, int mls)
+{
+	fprintf(out, "%s:", DATUM(context->user)->fqn);
+	fprintf(out, "%s:", DATUM(context->role)->fqn);
+	fprintf(out, "%s", DATUM(context->type)->fqn);
+	if (mls) {
+		fprintf(out, ":");
+		cil_levelrange_to_policy(out, context->range);
+	}
+}
 
-		if (errno != 0) {
-			cil_log(CIL_INFO, "Failed to convert ip address to string\n");
-			rc = SEPOL_ERR;
-			goto exit;
+static char *cil_cond_expr_to_policy(FILE *out, struct cil_list *expr, int first)
+{
+	struct cil_list_item *i1 = expr->head;
+
+	if (i1->flavor == CIL_OP) {
+		enum cil_flavor op = (enum cil_flavor)i1->data;
+		fprintf(out, "(");
+		switch (op) {
+		case CIL_NOT:
+			fprintf(out, "! ");
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			break;
+		case CIL_OR:
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			fprintf(out, " || ");
+			cil_cond_expr_to_policy(out, i1->next->next->data, CIL_FALSE);
+			break;
+		case CIL_AND:
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			fprintf(out, " && ");
+			cil_cond_expr_to_policy(out, i1->next->next->data, CIL_FALSE);
+			break;
+		case CIL_XOR:
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			fprintf(out, " ^ ");
+			cil_cond_expr_to_policy(out, i1->next->next->data, CIL_FALSE);
+			break;
+		case CIL_EQ:
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			fprintf(out, " == ");
+			cil_cond_expr_to_policy(out, i1->next->next->data, CIL_FALSE);
+			break;
+		case CIL_NEQ:
+			cil_cond_expr_to_policy(out, i1->next->data, CIL_FALSE);
+			fprintf(out, " != ");
+			cil_cond_expr_to_policy(out, i1->next->next->data, CIL_FALSE);
+			break;
+		default:
+			fprintf(out, "???");
+			break;
 		}
-
-		fprintf(file_arr[NETIFCONS], "nodecon %s ", buf);
-		free(buf);
-
-		if (nodecon->mask->family == AF_INET) {
-			buf = cil_malloc(INET_ADDRSTRLEN);
-			inet_ntop(nodecon->mask->family, &nodecon->mask->ip.v4, buf, INET_ADDRSTRLEN);
-		} else if (nodecon->mask->family == AF_INET6) {
-			buf = cil_malloc(INET6_ADDRSTRLEN);
-			inet_ntop(nodecon->mask->family, &nodecon->mask->ip.v6, buf, INET6_ADDRSTRLEN);
+		fprintf(out, ")");
+	} else if (i1->flavor == CIL_DATUM) {
+		if (first == CIL_TRUE) {
+			fprintf(out, "(");
 		}
-
-		if (errno != 0) {
-			cil_log(CIL_INFO, "Failed to convert mask to string\n");
-			rc = SEPOL_ERR;
-			goto exit;
+		fprintf(out, "%s", DATUM(i1->data)->fqn);
+		if (first == CIL_TRUE) {
+			fprintf(out, ")");
 		}
-
-		fprintf(file_arr[NETIFCONS], "%s ", buf);
-		free(buf);
-
-		cil_context_to_policy(file_arr, NETIFCONS, nodecon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	} else if (i1->flavor == CIL_LIST) {
+		cil_cond_expr_to_policy(out, i1->data, CIL_FALSE);
+	} else {
+		fprintf(out, "???");
 	}
-
-	return SEPOL_OK;
-
-exit:
-	return rc;
 }
 
-
-int cil_pirqcon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static size_t __cil_userattribute_len(struct cil_db *db, struct cil_userattribute *attr)
 {
-	uint32_t i = 0;
+	ebitmap_node_t *unode;
+	unsigned int i;
+	size_t len = 0;
 
-	for (i = 0; i < sort->count; i++) {
-		struct cil_pirqcon *pirqcon = (struct cil_pirqcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "pirqcon %d ", pirqcon->pirq);
-		cil_context_to_policy(file_arr, NETIFCONS, pirqcon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	ebitmap_for_each_bit(attr->users, unode, i) {
+		if (!ebitmap_get_bit(attr->users, i))
+			continue;
+		len += strlen(DATUM(db->val_to_user[i])->fqn);
+		len++;
 	}
 
-	return SEPOL_OK;
+	return len;
 }
-int cil_iomemcon_to_policy(FILE **file_arr, struct cil_sort *sort)
-{
-	uint32_t i = 0;
 
-	for (i = 0; i < sort->count; i++) {
-		struct cil_iomemcon *iomemcon = (struct cil_iomemcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "iomemcon %"PRId64"-%"PRId64" ", iomemcon->iomem_low, iomemcon->iomem_high);
-		cil_context_to_policy(file_arr, NETIFCONS, iomemcon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+static size_t __cil_cons_leaf_operand_len(struct cil_db *db, struct cil_list_item *operand)
+{
+	struct cil_list_item *i1;
+	enum cil_flavor flavor = operand->flavor;
+	size_t len;
+
+	if (flavor == CIL_CONS_OPERAND) {
+		len = 2;
+	} else if (flavor == CIL_DATUM) {
+		struct cil_tree_node *node = NODE(operand->data);
+		if (node->flavor == CIL_USERATTRIBUTE) {
+			len = __cil_userattribute_len(db, operand->data);
+			len++; /* "{" */
+		} else {
+			len = strlen(DATUM(operand->data)->fqn);
+		}
+	} else if (flavor == CIL_LIST) {
+		len = 1; /* "{" */
+		cil_list_for_each(i1, (struct cil_list *)operand->data) {
+			struct cil_tree_node *node = NODE(operand->data);
+			if (node->flavor == CIL_USERATTRIBUTE) {
+				len = __cil_userattribute_len(db, operand->data);
+			} else {
+				len += strlen(DATUM(operand->data)->fqn);
+				len++; /* " " or "}" */
+			}
+		}
 	}
 
-	return SEPOL_OK;
+	return len;
 }
 
-int cil_ioportcon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static size_t __cil_cons_leaf_op_len(struct cil_list_item *op)
 {
-	uint32_t i = 0;
+	enum cil_flavor flavor = (enum cil_flavor)op->data;
+	size_t len;
 
-	for (i = 0; i < sort->count; i++) {
-		struct cil_ioportcon *ioportcon = (struct cil_ioportcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "ioportcon %d-%d ", ioportcon->ioport_low, ioportcon->ioport_high);
-		cil_context_to_policy(file_arr, NETIFCONS, ioportcon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	switch (flavor) {
+	case CIL_EQ:
+		len = 4; /* " == " */
+		break;
+	case CIL_NEQ:
+		len = 4; /* " != " */
+		break;
+	case CIL_CONS_DOM:
+		len = 5; /* " dom " */
+		break;
+	case CIL_CONS_DOMBY:
+		len = 7; /* " domby " */
+		break;
+	case CIL_CONS_INCOMP:
+		len = 8; /* " incomp " */
+		break;
+	default:
+		/* Should be impossible to be here */
+		len = 5; /* " ??? " */
 	}
 
-	return SEPOL_OK;
+	return len;
 }
 
-int cil_pcidevicecon_to_policy(FILE **file_arr, struct cil_sort *sort)
+static size_t cil_cons_expr_len(struct cil_db *db, struct cil_list *cons_expr)
 {
-	uint32_t i = 0;
+	struct cil_list_item *i1;
+	enum cil_flavor op;
+	size_t len;
 
-	for (i = 0; i < sort->count; i++) {
-		struct cil_pcidevicecon *pcidevicecon = (struct cil_pcidevicecon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "pcidevicecon %d ", pcidevicecon->dev);
-		cil_context_to_policy(file_arr, NETIFCONS, pcidevicecon->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+	i1 = cons_expr->head;
+
+	op = (enum cil_flavor)i1->data;
+	switch (op) {
+	case CIL_NOT:
+		len = 6; /* "(not )" */
+		len += cil_cons_expr_len(db, i1->next->data);
+		break;
+	case CIL_AND:
+		len = 7; /* "( and )" */
+		len += cil_cons_expr_len(db, i1->next->data);
+		len += cil_cons_expr_len(db, i1->next->next->data);
+		break;
+	case CIL_OR:
+		len = 6; /* "( or )" */
+		len += cil_cons_expr_len(db, i1->next->data);
+		len += cil_cons_expr_len(db, i1->next->next->data);
+		break;
+	default:
+		len = 2; /* "()" */
+		len += __cil_cons_leaf_operand_len(db, i1->next);
+		len += __cil_cons_leaf_op_len(i1);
+		len += __cil_cons_leaf_operand_len(db, i1->next->next);
 	}
 
-	return SEPOL_OK;
+	return len;
 }
 
-int cil_fsuse_to_policy(FILE **file_arr, struct cil_sort *sort)
+static char *__cil_userattribute_to_string(struct cil_db *db, struct cil_userattribute *attr, char *new)
 {
-	uint32_t i = 0;
+	ebitmap_node_t *unode;
+	unsigned int i;
+	char *str;
+	size_t len;
+
+	ebitmap_for_each_bit(attr->users, unode, i) {
+		if (!ebitmap_get_bit(attr->users, i))
+			continue;
+		str = DATUM(db->val_to_user[i])->fqn;
+		len = strlen(str);
+		memcpy(new, str, len);
+		new += len;
+		*new++ = ' ';
+	}
+
+	return new;
+}
 
-	for (i=0; i<sort->count; i++) {
-		struct cil_fsuse *fsuse = (struct cil_fsuse*)sort->array[i];
-		if (fsuse->type == CIL_FSUSE_XATTR) {
-			fprintf(file_arr[NETIFCONS], "fs_use_xattr ");
-		} else if (fsuse->type == CIL_FSUSE_TASK) {
-			fprintf(file_arr[NETIFCONS], "fs_use_task ");
-		} else if (fsuse->type == CIL_FSUSE_TRANS) {
-			fprintf(file_arr[NETIFCONS], "fs_use_trans ");
+static char *__cil_cons_leaf_operand_to_string(struct cil_db *db, struct cil_list_item *operand, char *new)
+{
+	struct cil_list_item *i1;
+	enum cil_flavor flavor = operand->flavor;
+	char *o_str;
+	size_t o_len;
+
+	if (flavor == CIL_CONS_OPERAND) {
+		enum cil_flavor o_flavor = (enum cil_flavor)operand->data;
+		switch (o_flavor) {
+		case CIL_CONS_U1:
+			o_str = "u1";
+			break;
+		case CIL_CONS_U2:
+			o_str = "u2";
+			break;
+		case CIL_CONS_U3:
+			o_str = "u3";
+			break;
+		case CIL_CONS_R1:
+			o_str = "r1";
+			break;
+		case CIL_CONS_R2:
+			o_str = "r2";
+			break;
+		case CIL_CONS_R3:
+			o_str = "r3";
+			break;
+		case CIL_CONS_T1:
+			o_str = "t1";
+			break;
+		case CIL_CONS_T2:
+			o_str = "t2";
+			break;
+		case CIL_CONS_T3:
+			o_str = "t3";
+			break;
+		case CIL_CONS_L1:
+			o_str = "l1";
+			break;
+		case CIL_CONS_L2:
+			o_str = "l2";
+			break;
+		case CIL_CONS_H1:
+			o_str = "h1";
+			break;
+		case CIL_CONS_H2:
+			o_str = "h2";
+			break;
+		default:
+			/* Impossible */
+			o_str = "??";
+		}
+		strcpy(new, o_str);
+		new += 2;
+	} else if (flavor == CIL_DATUM) {
+		struct cil_tree_node *node = NODE(operand->data);
+		if (node->flavor == CIL_USERATTRIBUTE) {
+			*new++ = '{';
+			new = __cil_userattribute_to_string(db, operand->data, new);
+			new--;
+			*new++ = '}';
 		} else {
-			return SEPOL_ERR;
+			o_str = DATUM(operand->data)->fqn;
+			o_len = strlen(o_str);
+			memcpy(new, o_str, o_len);
+			new += o_len;
+		}
+	} else if (flavor == CIL_LIST) {
+		*new++ = '{';
+		cil_list_for_each(i1, (struct cil_list *)operand->data) {
+			struct cil_tree_node *node = NODE(operand->data);
+			if (node->flavor == CIL_USERATTRIBUTE) {
+				new = __cil_userattribute_to_string(db, operand->data, new);
+			} else {
+				o_str = DATUM(operand->data)->fqn;
+				o_len = strlen(o_str);
+				memcpy(new, o_str, o_len);
+				new += o_len;
+				*new++ = ' ';
+			}
 		}
-		fprintf(file_arr[NETIFCONS], "%s ", fsuse->fs_str);
-		cil_context_to_policy(file_arr, NETIFCONS, fsuse->context);
-		fprintf(file_arr[NETIFCONS], ";\n");
+		new--;
+		*new++ = '}';
 	}
 
-	return SEPOL_OK;
+	return new;
 }
 
-int cil_multimap_insert(struct cil_list *list, struct cil_symtab_datum *key, struct cil_symtab_datum *value, uint32_t key_flavor, uint32_t val_flavor)
+static char *__cil_cons_leaf_op_to_string(struct cil_list_item *op, char *new)
 {
-	struct cil_list_item *curr_key;
-	struct cil_multimap_item *new_data;
-
-	if (list == NULL || key == NULL) {
-		return SEPOL_ERR;
-	}
-
-	cil_list_for_each(curr_key, list) {
-		struct cil_multimap_item *curr_multimap_item = curr_key->data;
-		if (curr_multimap_item != NULL) {
-			if (curr_multimap_item->key != NULL && curr_multimap_item->key == key) {
-				struct cil_list_item *curr_value;
-				cil_list_for_each(curr_value, curr_multimap_item->values) {
-					if (curr_value == (struct cil_list_item*)value) {
-						return SEPOL_OK;;
-					}
-				}
-				cil_list_append(curr_multimap_item->values, val_flavor, value);
-			}
-		} else {
-			cil_log(CIL_INFO, "No data in list item\n");
-			return SEPOL_ERR;
-		}
+	enum cil_flavor flavor = (enum cil_flavor)op->data;
+	char *op_str;
+	size_t len;
+
+	switch (flavor) {
+	case CIL_EQ:
+		op_str = " == ";
+		len = 4;
+		break;
+	case CIL_NEQ:
+		op_str = " != ";
+		len = 4;
+		break;
+	case CIL_CONS_DOM:
+		op_str = " dom ";
+		len = 5;
+		break;
+	case CIL_CONS_DOMBY:
+		op_str = " domby ";
+		len = 7;
+		break;
+	case CIL_CONS_INCOMP:
+		op_str = " incomp ";
+		len = 8;
+		break;
+	default:
+		/* Should be impossible to be here */
+		op_str = " ??? ";
+		len = 5;
 	}
 
-	new_data = cil_malloc(sizeof(*new_data));
-	new_data->key = key;
-	cil_list_init(&new_data->values, CIL_LIST_ITEM);
-	if (value != NULL) {
-		cil_list_append(new_data->values, val_flavor, value);
-	}
-	cil_list_append(list, key_flavor, new_data);
+	strcpy(new, op_str);
+	new += len;
 
-	return SEPOL_OK;
+	return new;
 }
 
-int cil_userrole_to_policy(FILE **file_arr, struct cil_list *userroles)
+static char *__cil_cons_expr_to_string(struct cil_db *db, struct cil_list *cons_expr, char *new)
 {
-	struct cil_list_item *current_user;
-
-	if (userroles == NULL) {
-		return SEPOL_OK;
+	struct cil_list_item *i1;
+	enum cil_flavor op;
+
+	i1 = cons_expr->head;
+
+	op = (enum cil_flavor)i1->data;
+	switch (op) {
+	case CIL_NOT:
+		*new++ = '(';
+		strcpy(new, "not ");
+		new += 4;
+		new = __cil_cons_expr_to_string(db, i1->next->data, new);
+		*new++ = ')';
+		break;
+	case CIL_AND:
+		*new++ = '(';
+		new = __cil_cons_expr_to_string(db, i1->next->data, new);
+		strcpy(new, " and ");
+		new += 5;
+		new = __cil_cons_expr_to_string(db, i1->next->next->data, new);
+		*new++ = ')';
+		break;
+	case CIL_OR:
+		*new++ = '(';
+		new = __cil_cons_expr_to_string(db, i1->next->data, new);
+		strcpy(new, " or ");
+		new += 4;
+		new = __cil_cons_expr_to_string(db, i1->next->next->data, new);
+		*new++ = ')';
+		break;
+	default:
+		*new++ = '(';
+		new = __cil_cons_leaf_operand_to_string(db, i1->next, new);
+		new = __cil_cons_leaf_op_to_string(i1, new);
+		new = __cil_cons_leaf_operand_to_string(db, i1->next->next, new);
+		*new++ = ')';
 	}
-	
-	cil_list_for_each(current_user, userroles) {
-		struct cil_multimap_item *user_multimap_item = current_user->data;
-		struct cil_list_item *current_role;
-		if (user_multimap_item->values->head == NULL) {
-			cil_log(CIL_INFO, "No roles associated with user %s\n",  
-					user_multimap_item->key->name);
-			return SEPOL_ERR;
-		}
 
-		fprintf(file_arr[USERROLES], "user %s roles {", user_multimap_item->key->name);
+	return new;
+}
+
+static char *cil_cons_expr_to_string(struct cil_db *db, struct cil_list *cons_expr)
+{
+	char *new, *tail;
+	size_t len = cil_cons_expr_len(db, cons_expr);
 
-		cil_list_for_each(current_role, user_multimap_item->values) {
-			fprintf(file_arr[USERROLES], " %s", ((struct cil_role*)current_role->data)->datum.name);
-		}
-		fprintf(file_arr[USERROLES], " };\n"); 
-	}
+	new = cil_malloc(len+1);
+	tail = __cil_cons_expr_to_string(db, cons_expr, new);
+	*tail = '\0';
 
-	return SEPOL_OK;
+	return new;
 }
 
-int cil_cat_to_policy(FILE **file_arr, struct cil_list *cats)
+static void cil_classperms_to_string(struct cil_classperms *classperms, struct cil_list *classperms_strs)
 {
-	struct cil_list_item *curr_cat;
+	struct cil_list_item *i1;
+	size_t len = 0;
+	char *new, *curr;
 
-	if (cats == NULL) {
-		return SEPOL_OK;
+	len += strlen(DATUM(classperms->class)->fqn) + 1;
+	cil_list_for_each(i1, classperms->perms) {
+		len += strlen(DATUM(i1->data)->fqn) + 1;
 	}
+	len += 4; /* for "{ " and " }" */
 
-	cil_list_for_each(curr_cat, cats) {
-		struct cil_multimap_item *cat_multimap_item = curr_cat->data;
-		fprintf(file_arr[CATS], "category %s", cat_multimap_item->key->name);
-		if (cat_multimap_item->values->head == NULL) {
-			fprintf(file_arr[CATS], ";\n");
-		} else {
-			struct cil_list_item *curr_catalias;
-			fprintf(file_arr[CATS], " alias");
-			cil_list_for_each(curr_catalias, cat_multimap_item->values) {
-				fprintf(file_arr[CATS], " %s", ((struct cil_cat*)curr_catalias->data)->datum.name);
-			}
-			fprintf(file_arr[CATS], ";\n"); 
-		}
+	new = cil_malloc(len);
+	curr = new;
+
+	curr[len-1] = '\0';
+
+	len = strlen(DATUM(classperms->class)->fqn);
+	memcpy(curr, DATUM(classperms->class)->fqn, len);
+	curr += len;
+	*curr++ = ' ';
+
+	*curr++ = '{';
+	*curr++ = ' ';
+	cil_list_for_each(i1, classperms->perms) {
+		len = strlen(DATUM(i1->data)->fqn);
+		memcpy(curr, DATUM(i1->data)->fqn, len);
+		curr += len;
+		*curr++ = ' ';
 	}
+	*curr++ = '}';
 
-	return SEPOL_OK;
+	cil_list_append(classperms_strs, CIL_STRING, new);
 }
 
-int cil_sens_to_policy(FILE **file_arr, struct cil_list *sens)
+static void cil_classperms_to_strings(struct cil_list *classperms, struct cil_list *classperms_strs)
 {
-	struct cil_list_item *curr_sens;
+	struct cil_list_item *i1;
 
-	if (sens == NULL) {
-		return SEPOL_OK;
-	}
-
-	cil_list_for_each(curr_sens, sens) {
-		struct cil_multimap_item *sens_multimap_item = curr_sens->data;
-		fprintf(file_arr[SENS], "sensitivity %s", sens_multimap_item->key->name);
-		if (sens_multimap_item->values->head == NULL) 
-			fprintf(file_arr[SENS], ";\n");
-		else {
-			struct cil_list_item *curr_sensalias;
-			fprintf(file_arr[SENS], " alias");
-			cil_list_for_each(curr_sensalias, sens_multimap_item->values) {
-				fprintf(file_arr[SENS], " %s", ((struct cil_sens*)curr_sensalias->data)->datum.name);
+	cil_list_for_each(i1, classperms) {
+		if (i1->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = i1->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				cil_classperms_to_string(cp, classperms_strs);
+			} else { /* MAP */
+				struct cil_list_item *i2 = NULL;
+				cil_list_for_each(i2, cp->perms) {
+					struct cil_perm *cmp = i2->data;
+					cil_classperms_to_strings(cmp->classperms, classperms_strs);
+				}
 			}
-			fprintf(file_arr[SENS], ";\n"); 
+		} else { /* SET */
+			struct cil_classperms_set *cp_set = i1->data;
+			struct cil_classpermission *cp = cp_set->set;
+			cil_classperms_to_strings(cp->classperms, classperms_strs);
 		}
 	}
-
-	return SEPOL_OK;
 }
 
-void cil_cats_to_policy(FILE **file_arr, uint32_t file_index, struct cil_cats *cats)
+static void cil_class_decls_to_policy(FILE *out, struct cil_list *classorder)
 {
-	cil_expr_to_policy(file_arr, file_index, cats->datum_expr);
+	struct cil_list_item *i1;
+
+	cil_list_for_each(i1, classorder) {
+		fprintf(out, "class %s\n", DATUM(i1->data)->fqn);
+	}
 }
 
-void cil_level_to_policy(FILE **file_arr, uint32_t file_index, struct cil_level *level)
+static void cil_sid_decls_to_policy(FILE *out, struct cil_list *sidorder)
 {
-	char *sens_str = level->sens->datum.name;
+	struct cil_list_item *i1;
 
-	fprintf(file_arr[file_index], "%s", sens_str);
-	if (level->cats != NULL) {
-		fprintf(file_arr[file_index], ":");
-		cil_cats_to_policy(file_arr, file_index, level->cats);
+	cil_list_for_each(i1, sidorder) {
+		fprintf(out, "sid %s\n", DATUM(i1->data)->fqn);
 	}
 }
 
-void cil_levelrange_to_policy(FILE **file_arr, uint32_t file_index, struct cil_levelrange *lvlrange)
+static void cil_commons_to_policy(FILE *out, struct cil_list *commons)
 {
-	struct cil_level *low = lvlrange->low;
-	struct cil_level *high = lvlrange->high;
-
-	cil_level_to_policy(file_arr, file_index, low);
-	fprintf(file_arr[file_index], "-");
-	cil_level_to_policy(file_arr, file_index, high);
+	struct cil_list_item *i1;
+	struct cil_class* common;
+	struct cil_tree_node *node;
+	struct cil_tree_node *perm;
+
+	cil_list_for_each(i1, commons) {
+		common = i1->data;
+		node = NODE(&common->datum);
+		perm = node->cl_head;
+
+		fprintf(out, "common %s {", common->datum.fqn);
+		while (perm != NULL) {
+			fprintf(out, "%s ", DATUM(perm->data)->fqn);
+			perm = perm->next;
+		}
+		fprintf(out, "}\n");
+	}
 }
 
-void cil_context_to_policy(FILE **file_arr, uint32_t file_index, struct cil_context *context)
+static void cil_classes_to_policy(FILE *out, struct cil_list *classorder)
 {
-	char *user_str = ((struct cil_symtab_datum*)context->user)->name;
-	char *role_str = ((struct cil_symtab_datum*)context->role)->name;
-	char *type_str = ((struct cil_symtab_datum*)context->type)->name;
-	struct cil_levelrange *lvlrange = context->range;
+	struct cil_list_item *i1;
+	struct cil_class *class;
+	struct cil_tree_node *node;
+
+	cil_list_for_each(i1, classorder) {
+		class = i1->data;
+		node = NODE(&class->datum);
+
+		fprintf(out, "class %s", class->datum.fqn);
+		if (class->common != NULL) {
+			fprintf(out, " inherits %s", class->common->datum.fqn);
+		}
+		if (node->cl_head != NULL) {
+			struct cil_tree_node *perm = node->cl_head;
+			fprintf(out, " {");
+			while (perm != NULL) {
+				fprintf(out, " %s", DATUM(perm->data)->fqn);
+				perm = perm->next;
+			}
+			fprintf(out, " }");
+		}
+		fprintf(out, "\n");
+	}
+}
 
-	fprintf(file_arr[file_index], "%s:%s:%s:", user_str, role_str, type_str);
-	cil_levelrange_to_policy(file_arr, file_index, lvlrange);
+static void cil_defaults_to_policy(FILE *out, struct cil_list *defaults, char *kind)
+{
+	struct cil_list_item *i1, *i2, *i3;
+	struct cil_default *def;
+	struct cil_list *class_list;
+
+	cil_list_for_each(i1, defaults) {
+		def = i1->data;
+		fprintf(out, "%s {",kind);
+		cil_list_for_each(i2, def->class_datums) {
+			class_list = cil_expand_class(i2->data);
+			cil_list_for_each(i3, class_list) {
+				fprintf(out, " %s", DATUM(i3->data)->fqn);
+			}
+			cil_list_destroy(&class_list, CIL_FALSE);
+		}
+		fprintf(out, " }");
+		if (def->object == CIL_DEFAULT_SOURCE) {
+			fprintf(out," %s",CIL_KEY_SOURCE);
+		} else if (def->object == CIL_DEFAULT_TARGET) {
+			fprintf(out," %s",CIL_KEY_TARGET);
+		}
+		fprintf(out,";\n");
+	}
 }
 
-void cil_perms_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *list)
+static void cil_default_ranges_to_policy(FILE *out, struct cil_list *defaults)
 {
-	struct cil_list_item *curr;
+	struct cil_list_item *i1, *i2, *i3;
+	struct cil_defaultrange *def;
+	struct cil_list *class_list;
+
+	cil_list_for_each(i1, defaults) {
+		def = i1->data;
+		fprintf(out, "default_range {");
+		cil_list_for_each(i2, def->class_datums) {
+			class_list = cil_expand_class(i2->data);
+			cil_list_for_each(i3, class_list) {
+				fprintf(out, " %s", DATUM(i3->data)->fqn);
+			}
+			cil_list_destroy(&class_list, CIL_FALSE);
+		}
+		fprintf(out, " }");
 
-	fprintf(file_arr[file_index], " {");
-	cil_list_for_each(curr, list) {
-		switch (curr->flavor) {
-		case CIL_LIST:
-			cil_perms_to_policy(file_arr, file_index, curr->data);
+		switch (def->object_range) {
+		case CIL_DEFAULT_SOURCE_LOW:
+			fprintf(out," %s %s", CIL_KEY_SOURCE, CIL_KEY_LOW);
 			break;
-		case CIL_STRING:
-			fprintf(file_arr[file_index], " %s", (char *)curr->data);
+		case CIL_DEFAULT_SOURCE_HIGH:
+			fprintf(out," %s %s", CIL_KEY_SOURCE, CIL_KEY_HIGH);
 			break;
-		case CIL_DATUM:
-			fprintf(file_arr[file_index], " %s", ((struct cil_symtab_datum *)curr->data)->name);
+		case CIL_DEFAULT_SOURCE_LOW_HIGH:
+			fprintf(out," %s %s", CIL_KEY_SOURCE, CIL_KEY_LOW_HIGH);
 			break;
-		case CIL_OP: {
-			enum cil_flavor op_flavor = *((enum cil_flavor *)curr->data);
-			char *op_str = NULL;
-
-			switch (op_flavor) {
-			case CIL_AND:
-				op_str = CIL_KEY_AND;
-				break;
-			case CIL_OR:
-				op_str = CIL_KEY_OR;
-				break;
-			case CIL_NOT:
-				op_str = CIL_KEY_NOT;
-				break;
-			case CIL_ALL:
-				op_str = CIL_KEY_ALL;
-				break;
-			case CIL_XOR:
-				op_str = CIL_KEY_XOR;
-				break;
-			default:
-				cil_log(CIL_ERR, "Unknown operator in expression\n");
-				break;
-			}
-			fprintf(file_arr[file_index], " %s", op_str);
+		case CIL_DEFAULT_TARGET_LOW:
+			fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW);
+			break;
+		case CIL_DEFAULT_TARGET_HIGH:
+			fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_HIGH);
+			break;
+		case CIL_DEFAULT_TARGET_LOW_HIGH:
+			fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW_HIGH);
 			break;
-		}
 		default:
-			cil_log(CIL_ERR, "Unknown flavor in expression\n");
 			break;
 		}
+		fprintf(out,";\n");
 	}
-	fprintf(file_arr[file_index], " }");
 }
 
-void cil_constrain_to_policy_helper(FILE **file_arr, char *kind, struct cil_list *classperms, struct cil_list *expr)
+static void cil_sensitivities_to_policy(FILE *out, struct cil_list *sensorder, struct cil_list *all_aliases)
 {
-	struct cil_list_item *curr;
-
-	cil_list_for_each(curr, classperms) {
-		if (curr->flavor == CIL_CLASSPERMS) {
-			struct cil_classperms *cp = curr->data;
-			if (FLAVOR(cp->class) == CIL_CLASS) {
-				fprintf(file_arr[CONSTRAINS], "%s %s", kind, cp->class->datum.name);
-				cil_perms_to_policy(file_arr, CONSTRAINS, cp->perms);
-				fprintf(file_arr[CONSTRAINS], "\n\t");
-				cil_expr_to_policy(file_arr, CONSTRAINS, expr);
-				fprintf(file_arr[CONSTRAINS], ";\n");
-			} else { /* MAP */
-				struct cil_list_item *i = NULL;
-				cil_list_for_each(i, cp->perms) {
-					struct cil_perm *cmp = i->data;
-					cil_constrain_to_policy_helper(file_arr, kind, cmp->classperms, expr);
+	struct cil_list_item *i1, *i2;
+	struct cil_sens *sens;
+	struct cil_list *aliases;
+	struct cil_alias *alias;
+	struct cil_sens *actual;
+	int num_aliases;
+
+	cil_list_for_each(i1, sensorder) {
+		sens = i1->data;
+		num_aliases = 0;
+		cil_list_for_each(i2, all_aliases) {
+			alias = i2->data;
+			actual = alias->actual;
+			if (sens == actual) {
+				if (num_aliases == 0) {
+					cil_list_init(&aliases, CIL_LIST);
 				}
-			}	
-		} else { /* SET */
-			struct cil_classperms_set *cp_set = curr->data;
-			struct cil_classpermission *cp = cp_set->set;
-			cil_constrain_to_policy_helper(file_arr, kind, cp->classperms, expr);
+				cil_list_append(aliases, CIL_SENSALIAS, alias);
+				num_aliases++;
+			}
+		}
+		fprintf(out, "sensitivity %s", sens->datum.fqn);
+		if (num_aliases > 0) {
+			fprintf(out, " alias");
+			if (num_aliases > 1) {
+				fprintf(out, " {");
+			}
+			cil_list_for_each(i2, aliases) {
+				alias = i2->data;
+				fprintf(out, " %s", alias->datum.fqn);
+			}
+			if (num_aliases > 1) {
+				fprintf(out, " }");
+			}
+			cil_list_destroy(&aliases, CIL_FALSE);
 		}
+		fprintf(out, ";\n");
 	}
 }
 
-void cil_constrain_to_policy(FILE **file_arr, __attribute__((unused)) uint32_t file_index, struct cil_constrain *cons, enum cil_flavor flavor)
+static void cil_dominance_to_policy(FILE *out, struct cil_list *sensorder)
 {
-	char *kind = NULL;
+	struct cil_list_item *item;
+	struct cil_sens *sens;
 
-	if (flavor == CIL_CONSTRAIN) {
-		kind = CIL_KEY_CONSTRAIN;
-	} else if (flavor == CIL_MLSCONSTRAIN) {
-		kind = CIL_KEY_MLSCONSTRAIN;
+	fprintf(out, "dominance {");
+	cil_list_for_each(item, sensorder) {
+		sens = item->data;
+		fprintf(out, " %s", sens->datum.fqn);
 	}
-
-	cil_constrain_to_policy_helper(file_arr, kind, cons->classperms, cons->datum_expr);
+	fprintf(out, " }\n");
 }
 
-void cil_avrule_to_policy_helper(FILE **file_arr, uint32_t file_index, const char *kind, const char *src, const char *tgt, struct cil_list *classperms)
+static void cil_categories_to_policy(FILE *out, struct cil_list *catorder, struct cil_list *all_aliases)
 {
-	struct cil_list_item *i;
-
-	cil_list_for_each(i, classperms) {
-		if (i->flavor == CIL_CLASSPERMS) {
-			struct cil_classperms *cp = i->data;
-			if (FLAVOR(cp->class) == CIL_CLASS) {
-				fprintf(file_arr[file_index], "%s %s %s: %s", kind, src, tgt, cp->class->datum.name);
-				cil_perms_to_policy(file_arr, file_index, cp->perms);
-				fprintf(file_arr[file_index], ";\n");
-			} else { /* MAP */
-				struct cil_list_item *j = NULL;
-				cil_list_for_each(j, cp->perms) {
-					struct cil_perm *cmp = j->data;
-					cil_avrule_to_policy_helper(file_arr, file_index, kind, src, tgt, cmp->classperms);
+	struct cil_list_item *i1, *i2;
+	struct cil_sens *cat;
+	struct cil_list *aliases;
+	struct cil_alias *alias;
+	struct cil_sens *actual;
+	int num_aliases;
+
+	cil_list_for_each(i1, catorder) {
+		cat = i1->data;
+		num_aliases = 0;
+		cil_list_for_each(i2, all_aliases) {
+			alias = i2->data;
+			actual = alias->actual;
+			if (cat == actual) {
+				if (num_aliases == 0) {
+					cil_list_init(&aliases, CIL_LIST);
 				}
+				cil_list_append(aliases, CIL_CATALIAS, alias);
+				num_aliases++;
 			}
-		} else { /* SET */
-			struct cil_list_item *j;
-			struct cil_classperms_set *cp_set = i->data;
-			struct cil_classpermission *cp = cp_set->set;
-			cil_list_for_each(j, cp->classperms) {
-				cil_avrule_to_policy_helper(file_arr, file_index, kind, src, tgt, j->data);
+		}
+		fprintf(out, "category %s",cat->datum.fqn);
+		if (num_aliases > 0) {
+			fprintf(out, " alias");
+			if (num_aliases > 1) {
+				fprintf(out, " { ");
+			}
+			cil_list_for_each(i2, aliases) {
+				alias = i2->data;
+				fprintf(out, " %s", alias->datum.fqn);
 			}
+			if (num_aliases > 1) {
+				fprintf(out, " }");
+			}
+			cil_list_destroy(&aliases, CIL_FALSE);
 		}
+		fprintf(out, ";\n");
 	}
 }
 
-int cil_avrule_to_policy(FILE **file_arr, uint32_t file_index, struct cil_avrule *rule)
+static void cil_levels_to_policy(FILE *out, struct cil_list *sensorder)
 {
-	const char *kind_str = NULL;
-	const char *src_str = DATUM(rule->src)->name;
-	const char *tgt_str = DATUM(rule->tgt)->name;
-
-
-	switch (rule->rule_kind) {
-	case CIL_AVRULE_ALLOWED:
-		kind_str = "allow";
-		break;
-	case CIL_AVRULE_AUDITALLOW:
-		kind_str = "auditallow";
-		break;
-	case CIL_AVRULE_DONTAUDIT:
-		kind_str = "dontaudit";
-		break;
-	case CIL_AVRULE_NEVERALLOW:
-		kind_str = "neverallow";
-		break;
-	default :
-		cil_log(CIL_INFO, "Unknown avrule with kind=%d src=%s tgt=%s\n",
-				rule->rule_kind, src_str, tgt_str);
-		return SEPOL_ERR;
+	struct cil_list_item *i1, *i2;
+	struct cil_sens *sens;
+
+	cil_list_for_each(i1, sensorder) {
+		sens = i1->data;
+		fprintf(out, "level %s",sens->datum.fqn);
+		if (sens->cats_list) {
+			fprintf(out, ":");
+			cil_list_for_each(i2, sens->cats_list) {
+				cil_cats_to_policy(out, i2->data);
+			}
+		}
 	}
+}
 
-	cil_avrule_to_policy_helper(file_arr, file_index, kind_str, src_str, tgt_str, rule->perms.classperms);
-
-	return SEPOL_OK;
+static void cil_mlsconstrains_to_policy(FILE *out, struct cil_db *db, struct cil_list *mlsconstrains)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_constrain *cons;
+	struct cil_list *classperms_strs;
+	char *cp_str;
+	char *expr_str;
+
+	cil_list_for_each(i1, mlsconstrains) {
+		cons = i1->data;
+		cil_list_init(&classperms_strs, CIL_LIST);
+		cil_classperms_to_strings(cons->classperms, classperms_strs);
+		expr_str = cil_cons_expr_to_string(db, cons->datum_expr);
+		cil_list_for_each(i2, classperms_strs) {
+			cp_str = i2->data;
+			fprintf(out, "mlsconstrain %s %s;\n", cp_str, expr_str);
+			free(cp_str);
+		}
+		free(expr_str);
+		cil_list_destroy(&classperms_strs, CIL_FALSE);
+	}
 }
 
-int cil_typerule_to_policy(FILE **file_arr, __attribute__((unused)) uint32_t file_index, struct cil_type_rule *rule)
+static void cil_validatetrans_to_policy(FILE *out, struct cil_db *db, struct cil_list *validatetrans, char *kind)
 {
-	char *src_str = ((struct cil_symtab_datum*)rule->src)->name;
-	char *tgt_str = ((struct cil_symtab_datum*)rule->tgt)->name;
-	char *obj_str = ((struct cil_symtab_datum*)rule->obj)->name;
-	char *result_str = ((struct cil_symtab_datum*)rule->result)->name;
-		
-	switch (rule->rule_kind) {
-	case CIL_TYPE_TRANSITION:
-		fprintf(file_arr[ALLOWS], "type_transition %s %s : %s %s;\n", src_str, tgt_str, obj_str, result_str);
-		break;
-	case CIL_TYPE_CHANGE:
-		fprintf(file_arr[ALLOWS], "type_change %s %s : %s %s\n;", src_str, tgt_str, obj_str, result_str);
-		break;
-	case CIL_TYPE_MEMBER:
-		fprintf(file_arr[ALLOWS], "type_member %s %s : %s %s;\n", src_str, tgt_str, obj_str, result_str);
-		break;
-	default:
-		cil_log(CIL_INFO, "Unknown type_rule\n");
-		return SEPOL_ERR;
+	struct cil_list_item *i1, *i2;
+	struct cil_validatetrans *trans;
+	struct cil_list *class_list;
+	struct cil_class *class;
+	char *expr_str;
+
+	cil_list_for_each(i1, validatetrans) {
+		trans = i1->data;
+		class_list = cil_expand_class(trans->class);
+		expr_str = cil_cons_expr_to_string(db, trans->datum_expr);
+		cil_list_for_each(i2, class_list) {
+			class = i2->data;
+			fprintf(out, "%s %s %s;\n", kind, class->datum.fqn, expr_str);
+		}
+		free(expr_str);
+		cil_list_destroy(&class_list, CIL_FALSE);
 	}
-
-	return SEPOL_OK;
 }
 
-int cil_nametypetransition_to_policy(FILE **file_arr, uint32_t file_index, struct cil_nametypetransition *nametypetrans)
+static void cil_bools_to_policy(FILE *out, struct cil_list *bools)
 {
-	char *src_str = ((struct cil_symtab_datum*)nametypetrans->src)->name;
-	char *tgt_str = ((struct cil_symtab_datum*)nametypetrans->tgt)->name;
-	char *obj_str = ((struct cil_symtab_datum*)nametypetrans->obj)->name;
-	char *result_str = ((struct cil_symtab_datum*)nametypetrans->result)->name;
+	struct cil_list_item *i1;
+	struct cil_bool *bool;
+	char *value;
 
-	fprintf(file_arr[file_index], "type_transition %s %s : %s %s %s;\n", src_str, tgt_str, obj_str, result_str, nametypetrans->name_str);
-	return SEPOL_OK;
+	cil_list_for_each(i1, bools) {
+		bool = i1->data;
+		value = bool->value ? "true" : "false";
+		fprintf(out, "bool %s %s;\n", bool->datum.fqn, value);
+	}
 }
 
-static int cil_expr_to_string(struct cil_list *expr, char **out)
+static void cil_typealiases_to_policy(FILE *out, struct cil_list *types, struct cil_list *all_aliases)
 {
-	int rc = SEPOL_ERR;
-	struct cil_list_item *curr;
-	char *stack[COND_EXPR_MAXDEPTH] = {};
-	int pos = 0;
-	int i;
-
-	cil_list_for_each(curr, expr) {
-		if (pos > COND_EXPR_MAXDEPTH) {
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-		switch (curr->flavor) {
-		case CIL_LIST:
-			rc = cil_expr_to_string(curr->data, &stack[pos]);
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
-			pos++;
-			break;
-		case CIL_STRING:
-			stack[pos] = curr->data;
-			pos++;
-			break;
-		case CIL_DATUM:
-			stack[pos] = ((struct cil_symtab_datum *)curr->data)->name;
-			pos++;
-			break;
-		case CIL_OP: {
-			int len;
-			char *expr_str;
-			enum cil_flavor op_flavor = *((enum cil_flavor *)curr->data);
-			char *op_str = NULL;
-
-			if (pos == 0) {
-				rc = SEPOL_ERR;
-				goto exit;
-			}
-			switch (op_flavor) {
-			case CIL_AND:
-				op_str = CIL_KEY_AND;
-				break;
-			case CIL_OR:
-				op_str = CIL_KEY_OR;
-				break;
-			case CIL_NOT:
-				op_str = CIL_KEY_NOT;
-				break;
-			case CIL_ALL:
-				op_str = CIL_KEY_ALL;
-				break;
-			case CIL_EQ:
-				op_str = CIL_KEY_EQ;
-				break;
-			case CIL_NEQ:
-				op_str = CIL_KEY_NEQ;
-				break;
-			case CIL_XOR:
-				op_str = CIL_KEY_XOR;
-				break;
-			case CIL_CONS_DOM:
-				op_str = CIL_KEY_CONS_DOM;
-				break;
-			case CIL_CONS_DOMBY:
-				op_str = CIL_KEY_CONS_DOMBY;
-				break;
-			case CIL_CONS_INCOMP:
-				op_str = CIL_KEY_CONS_INCOMP;
-				break;
-			default:
-				cil_log(CIL_ERR, "Unknown operator in expression\n");
-				goto exit;
-				break;
-			}
-			if (op_flavor == CIL_NOT) {
-				len = strlen(stack[pos-1]) + strlen(op_str) + 4;
-				expr_str = cil_malloc(len);
-				snprintf(expr_str, len, "(%s %s)", op_str, stack[pos-1]);
-				free(stack[pos-1]);
-				stack[pos-1] = NULL;
-				pos--;
-			} else {
-				if (pos < 2) {
-					rc = SEPOL_ERR;
-					goto exit;
+	struct cil_list_item *i1, *i2;
+	struct cil_type *type;
+	struct cil_list *aliases;
+	struct cil_alias *alias;
+	struct cil_type *actual;
+	int num_aliases;
+
+	cil_list_for_each(i1, types) {
+		type = i1->data;
+		num_aliases = 0;
+		cil_list_for_each(i2, all_aliases) {
+			alias = i2->data;
+			actual = alias->actual;
+			if (type == actual) {
+				if (num_aliases == 0) {
+					cil_list_init(&aliases, CIL_LIST);
 				}
-				len = strlen(stack[pos-1]) + strlen(stack[pos-2]) + strlen(op_str) + 5;
-				expr_str = cil_malloc(len);
-				snprintf(expr_str, len, "(%s %s %s)", stack[pos-1], op_str, stack[pos-2]);
-				free(stack[pos-2]);
-				free(stack[pos-1]);
-				stack[pos-2] = NULL;
-				stack[pos-1] = NULL;
-				pos -= 2;
+				cil_list_append(aliases, CIL_TYPEALIAS, alias);
+				num_aliases++;
 			}
-			stack[pos] = expr_str;
-			pos++;
-			break;
 		}
-		case CIL_CONS_OPERAND: {
-			enum cil_flavor operand_flavor = *((enum cil_flavor *)curr->data);
-			char *operand_str = NULL;
-			switch (operand_flavor) {
-			case CIL_CONS_U1:
-				operand_str = CIL_KEY_CONS_U1;
-				break;
-			case CIL_CONS_U2:
-				operand_str = CIL_KEY_CONS_U2;
-				break;
-			case CIL_CONS_U3:
-				operand_str = CIL_KEY_CONS_U3;
-				break;
-			case CIL_CONS_T1:
-				operand_str = CIL_KEY_CONS_T1;
-				break;
-			case CIL_CONS_T2:
-				operand_str = CIL_KEY_CONS_T2;
-				break;
-			case CIL_CONS_T3:
-				operand_str = CIL_KEY_CONS_T3;
-				break;
-			case CIL_CONS_R1:
-				operand_str = CIL_KEY_CONS_R1;
-				break;
-			case CIL_CONS_R2:
-				operand_str = CIL_KEY_CONS_R2;
-				break;
-			case CIL_CONS_R3:
-				operand_str = CIL_KEY_CONS_R3;
-				break;
-			case CIL_CONS_L1:
-				operand_str = CIL_KEY_CONS_L1;
-				break;
-			case CIL_CONS_L2:
-				operand_str = CIL_KEY_CONS_L2;
-				break;
-			case CIL_CONS_H1:
-				operand_str = CIL_KEY_CONS_H1;
-				break;
-			case CIL_CONS_H2:
-				operand_str = CIL_KEY_CONS_H2;
-				break;
-			default:
-				cil_log(CIL_ERR, "Unknown operand in expression\n");
-				goto exit;
-				break;
+		if (num_aliases > 0) {
+			fprintf(out, "typealias %s alias", type->datum.fqn);
+			if (num_aliases > 1) {
+				fprintf(out, " {");
 			}
-			stack[pos] = operand_str;
-			pos++;
-			break;
-		}
-		default:
-			cil_log(CIL_ERR, "Unknown flavor in expression\n");
-			goto exit;
-			break;
+			cil_list_for_each(i2, aliases) {
+				alias = i2->data;
+				fprintf(out, " %s", alias->datum.fqn);
+			}
+			if (num_aliases > 1) {
+				fprintf(out, " }");
+			}
+			fprintf(out, ";\n");
+			cil_list_destroy(&aliases, CIL_FALSE);
 		}
 	}
+}
 
-	*out = stack[0];
-
-	return SEPOL_OK;
+static void cil_typebounds_to_policy(FILE *out, struct cil_list *types)
+{
+	struct cil_list_item *i1;
+	struct cil_type *child;
+	struct cil_type *parent;
+
+	cil_list_for_each(i1, types) {
+		child = i1->data;
+		if (child->bounds != NULL) {
+			parent = child->bounds;
+			fprintf(out, "typebounds %s %s\n", parent->datum.fqn, child->datum.fqn);
+		}
+	}
+}
 
-exit:
-	for (i = 0; i < pos; i++) {
-		free(stack[i]);
+static void cil_typeattributes_to_policy(FILE *out, struct cil_list *types, struct cil_list *attributes)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_type *type;
+	struct cil_typeattribute *attribute;
+	int first = CIL_TRUE;
+
+	cil_list_for_each(i1, types) {
+		type = i1->data;
+		cil_list_for_each(i2, attributes) {
+			attribute = i2->data;
+			if (!attribute->used)
+				continue;
+			if (ebitmap_get_bit(attribute->types, type->value)) {
+				if (first) {
+					fprintf(out, "typeattribute %s %s", type->datum.fqn, attribute->datum.fqn);
+					first = CIL_FALSE;
+				} else {
+					fprintf(out, ", %s", attribute->datum.fqn);
+				}
+			}
+		}
+		if (!first) {
+			fprintf(out, ";\n");
+			first = CIL_TRUE;
+		}
 	}
-	return rc;
 }
 
-int cil_expr_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *expr)
+static void cil_xperms_to_policy(FILE *out, struct cil_permissionx *permx)
 {
-	int rc = SEPOL_ERR;
-	char *str_out;
+	ebitmap_node_t *node;
+	unsigned int i;
+	int first = -1, last = -1;
+	char *kind;
 
-	rc = cil_expr_to_string(expr, &str_out);
-	if (rc != SEPOL_OK) {
-		goto out;
+	if (permx->kind == CIL_PERMX_KIND_IOCTL) {
+		kind = "ioctl";
+	} else {
+		kind = "???";
 	}
-	fprintf(file_arr[file_index], "%s", str_out);
-	free(str_out);
 
-	return SEPOL_OK;
+	fprintf(out, "%s %s {", DATUM(permx->obj)->fqn, kind);
 
-out:
-	return rc;
+	ebitmap_for_each_bit(permx->perms, node, i) {
+		if (!ebitmap_get_bit(permx->perms, i))
+			continue;
+		if (first < 0) {
+			first = i;
+		} else if (last < 0) {
+			if (i == first+1) {
+				last = i;
+			} else {
+				fprintf(out, " 0x%hx 0x%hx", first, i);
+				first = -1;
+			}
+		} else if (i == last+1) {
+			last = i;
+		} else {
+			if (last > first+1) {
+				fprintf(out, " 0x%hx-0x%hx", first, last);
+			} else {
+				fprintf(out, " 0x%hx 0x%hx", first, last);
+			}
+			first = i;
+			last = -1;
+		}
+	}
+	if (first >= 0) {
+		if (last >= 0) {
+			fprintf(out, " 0x%hx-0x%hx", first, last);
+		} else {
+			fprintf(out, " 0x%hx", first);
+		}
+	}
+	fprintf(out," }");
 }
 
-int __cil_booleanif_node_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
+static void cil_av_rulex_to_policy(FILE *out, struct cil_avrule *rule)
 {
-	int rc = SEPOL_ERR;
-	struct cil_args_booleanif *args;
-	FILE **file_arr;
-	uint32_t *file_index;
+	char *kind;
+	struct cil_symtab_datum *src, *tgt;
 
-	args = extra_args;
-	file_arr = args->file_arr;
-	file_index = args->file_index;
+	src = rule->src;
+	tgt = rule->tgt;
 
-	switch (node->flavor) {
-	case CIL_AVRULE:
-		rc = cil_avrule_to_policy(file_arr, *file_index, (struct cil_avrule*)node->data);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "cil_avrule_to_policy failed, rc: %d\n", rc);
-			return rc;
-		}
+	switch (rule->rule_kind) {
+	case CIL_AVRULE_ALLOWED:
+		kind = "allowxperm";
 		break;
-	case CIL_TYPE_RULE:
-		rc = cil_typerule_to_policy(file_arr, *file_index, (struct cil_type_rule*)node->data);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "cil_typerule_to_policy failed, rc: %d\n", rc);
-			return rc;
-		}
+	case CIL_AVRULE_AUDITALLOW:
+		kind = "auditallowxperm";
 		break;
-	case CIL_FALSE:
-		fprintf(file_arr[*file_index], "else {\n");
+	case CIL_AVRULE_DONTAUDIT:
+		kind = "dontauditxperm";
 		break;
-	case CIL_TRUE:
+	case CIL_AVRULE_NEVERALLOW:
+		kind = "neverallowxperm";
 		break;
 	default:
-		return SEPOL_ERR;
+		kind = "???";
+		break;
 	}
 
-	return SEPOL_OK;
+	fprintf(out, "%s %s %s : ", kind, src->fqn, tgt->fqn);
+	cil_xperms_to_policy(out, rule->perms.x.permx);
+	fprintf(out, ";\n");
 }
 
-int __cil_booleanif_last_child_helper(struct cil_tree_node *node, void *extra_args)
+static void cil_av_rule_to_policy(FILE *out, struct cil_avrule *rule)
 {
-	struct cil_args_booleanif *args;
-	FILE **file_arr;
-	uint32_t *file_index;
+	char *kind;
+	struct cil_symtab_datum *src, *tgt;
+	struct cil_list *classperms_strs;
+	struct cil_list_item *i1;
 
-	args = extra_args;
-	file_arr = args->file_arr;
-	file_index = args->file_index;
+	src = rule->src;
+	tgt = rule->tgt;
+
+	switch (rule->rule_kind) {
+	case CIL_AVRULE_ALLOWED:
+		kind = "allow";
+		break;
+	case CIL_AVRULE_AUDITALLOW:
+		kind = "auditallow";
+		break;
+	case CIL_AVRULE_DONTAUDIT:
+		kind = "dontaudit";
+		break;
+	case CIL_AVRULE_NEVERALLOW:
+		kind = "neverallow";
+		break;
+	default:
+		kind = "???";
+		break;
+	}
 
-	if (node->parent->flavor == CIL_FALSE) {
-		fprintf(file_arr[*file_index], "}\n");
+	cil_list_init(&classperms_strs, CIL_LIST);
+	cil_classperms_to_strings(rule->perms.classperms, classperms_strs);
+	cil_list_for_each(i1, classperms_strs) {
+		char *cp_str = i1->data;
+		fprintf(out, "%s %s %s : %s;\n", kind, src->fqn, tgt->fqn, cp_str);
+		free(cp_str);
 	}
-	
-	return SEPOL_OK;
+	cil_list_destroy(&classperms_strs, CIL_FALSE);
 }
 
-int cil_booleanif_to_policy(FILE **file_arr, uint32_t file_index, struct cil_tree_node *node)
+static void cil_type_rule_to_policy(FILE *out, struct cil_type_rule *rule)
 {
-	int rc = SEPOL_ERR;
-	struct cil_booleanif *bif = node->data;
-	struct cil_list *expr = bif->datum_expr;
-	struct cil_args_booleanif extra_args;
-	struct cil_tree_node *true_node = NULL;
-	struct cil_tree_node *false_node = NULL;
-	struct cil_condblock *cb = NULL;
+	char *kind;
+	struct cil_symtab_datum *src, *tgt, *res;
+	struct cil_list *class_list;
+	struct cil_list_item *i1;
 
-	extra_args.file_arr = file_arr;
-	extra_args.file_index = &file_index;;
+	src = rule->src;
+	tgt = rule->tgt;
+	res = rule->result;
 
-	fprintf(file_arr[file_index], "if ");
-
-	rc = cil_expr_to_policy(file_arr, file_index, expr);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to write expression\n");
-		return rc;
+	switch (rule->rule_kind) {
+	case CIL_TYPE_TRANSITION:
+		kind = "type_transition";
+		break;
+	case CIL_TYPE_MEMBER:
+		kind = "type_member";
+		break;
+	case CIL_TYPE_CHANGE:
+		kind = "type_change";
+		break;
+	default:
+		kind = "???";
+		break;
 	}
 
-	if (node->cl_head != NULL && node->cl_head->flavor == CIL_CONDBLOCK) {
-		cb = node->cl_head->data;
-		if (cb->flavor == CIL_CONDTRUE) {
-			true_node = node->cl_head;
-		} else if (cb->flavor == CIL_CONDFALSE) {
-			false_node = node->cl_head;
-		}
+	class_list = cil_expand_class(rule->obj);
+	cil_list_for_each(i1, class_list) {
+		fprintf(out, "%s %s %s : %s %s;\n", kind, src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn);
 	}
+	cil_list_destroy(&class_list, CIL_FALSE);
+}
 
-	if (node->cl_head != NULL && node->cl_head->next != NULL && node->cl_head->next->flavor == CIL_CONDBLOCK) {
-		cb = node->cl_head->next->data;
-		if (cb->flavor == CIL_CONDTRUE) {
-			true_node = node->cl_head->next;
-		} else if (cb->flavor == CIL_CONDFALSE) {
-			false_node = node->cl_head->next;
-		}
-	}
+static void cil_nametypetransition_to_policy(FILE *out, struct cil_nametypetransition *trans)
+{
+	struct cil_symtab_datum *src, *tgt, *res;
+	struct cil_name *name;
+	struct cil_list *class_list;
+	struct cil_list_item *i1;
 
-	fprintf(file_arr[file_index], "{\n");
-	if (true_node != NULL) {
-		rc = cil_tree_walk(true_node, __cil_booleanif_node_helper, __cil_booleanif_last_child_helper, NULL, &extra_args);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Failed to write booleanif content to file, rc: %d\n", rc);
-			return rc;
-		}
+	src = trans->src;
+	tgt = trans->tgt;
+	name = trans->name;
+	res = trans->result;
+
+	class_list = cil_expand_class(trans->obj);
+	cil_list_for_each(i1, class_list) {
+		fprintf(out, "type_transition %s %s : %s %s;\n", src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn);
 	}
-	fprintf(file_arr[file_index], "}\n");
+	cil_list_destroy(&class_list, CIL_FALSE);
+}
 
-	if (false_node != NULL) {
-		fprintf(file_arr[file_index], "else {\n");
-		rc = cil_tree_walk(false_node, __cil_booleanif_node_helper, __cil_booleanif_last_child_helper, NULL, &extra_args);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Failed to write booleanif false content to file, rc: %d\n", rc);
-			return rc;
-		}
-		fprintf(file_arr[file_index], "}\n");
+static void cil_rangetransition_to_policy(FILE *out, struct cil_rangetransition *trans)
+{
+	struct cil_symtab_datum *src, *exec;
+	struct cil_list *class_list;
+	struct cil_list_item *i1;
+
+	src = trans->src;
+	exec = trans->exec;
+
+	class_list = cil_expand_class(trans->obj);
+	cil_list_for_each(i1, class_list) {
+		fprintf(out, "range_transition %s %s : %s ", src->fqn, exec->fqn, DATUM(i1->data)->fqn);
+		cil_levelrange_to_policy(out, trans->range);
+		fprintf(out, ";\n");
 	}
+	cil_list_destroy(&class_list, CIL_FALSE);
+}
 
-	return SEPOL_OK;
+static void cil_typepermissive_to_policy(FILE *out, struct cil_typepermissive *rule)
+{
+	fprintf(out, "permissive %s;\n", DATUM(rule->type)->fqn);
 }
 
-int cil_name_to_policy(FILE **file_arr, struct cil_tree_node *current) 
+struct block_te_rules_extra {
+	FILE *out;
+	enum cil_flavor flavor;
+	uint32_t rule_kind;
+};
+
+static int __cil_block_te_rules_to_policy_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
-	uint32_t flavor = current->flavor;
-	int rc = SEPOL_ERR;
+	struct block_te_rules_extra *args = extra_args;
 
-	switch(flavor) {
-	case CIL_TYPEATTRIBUTE:
-		fprintf(file_arr[TYPEATTRTYPES], "attribute %s;\n", ((struct cil_symtab_datum*)current->data)->name);
-		break;
-	case CIL_TYPE:
-		fprintf(file_arr[TYPEATTRTYPES], "type %s;\n", ((struct cil_symtab_datum*)current->data)->name);
-		break;
-	case CIL_TYPEALIAS: {
-		struct cil_alias *alias = current->data;
-		fprintf(file_arr[ALIASES], "typealias %s alias %s;\n", ((struct cil_symtab_datum*)alias->actual)->name, ((struct cil_symtab_datum*)current->data)->name);
-		break;
-	}
-	case CIL_TYPEBOUNDS: {
-		struct cil_bounds *bnds = current->data;
-		fprintf(file_arr[ALLOWS], "typebounds %s %s;\n", bnds->parent_str, bnds->child_str);
-		break;
-	}
-	case CIL_TYPEPERMISSIVE: {
-		struct cil_typepermissive *typeperm = (struct cil_typepermissive*)current->data;
-		fprintf(file_arr[TYPEATTRTYPES], "permissive %s;\n", ((struct cil_symtab_datum*)typeperm->type)->name);
+	switch (node->flavor) {
+	case CIL_BLOCK: {
+		struct cil_block *blk = node->data;
+		if (blk->is_abstract == CIL_TRUE) {
+			*finished = CIL_TREE_SKIP_HEAD;
+		}
 		break;
 	}
-	case CIL_ROLE:
-		fprintf(file_arr[TYPEATTRTYPES], "role %s;\n", ((struct cil_symtab_datum*)current->data)->name);
+	case CIL_MACRO:
+		*finished = CIL_TREE_SKIP_HEAD;
 		break;
-	case CIL_BOOL: {
-		const char *boolean = ((struct cil_bool*)current->data)->value ? "true" : "false";
-		fprintf(file_arr[TYPEATTRTYPES], "bool %s %s;\n", ((struct cil_symtab_datum*)current->data)->name, boolean);
+	case CIL_BOOLEANIF:
+		*finished = CIL_TREE_SKIP_HEAD;
 		break;
-	}
-	case CIL_COMMON:
-		fprintf(file_arr[COMMONS], "common %s", ((struct cil_symtab_datum*)current->data)->name);
-
-		if (current->cl_head != NULL) {
-			current = current->cl_head;
-			fprintf(file_arr[COMMONS], " {");
-		} else {
-			cil_log(CIL_INFO, "No permissions given\n");
-			return SEPOL_ERR;
+	case CIL_AVRULE:
+	case CIL_AVRULEX:
+		if (args->flavor == node->flavor) {
+			struct cil_avrule *rule = node->data;
+			if (args->rule_kind == rule->rule_kind) {
+				if (rule->is_extended) {
+					cil_av_rulex_to_policy(args->out, rule);
+				} else {
+					cil_av_rule_to_policy(args->out, rule);
+				}
+			}
 		}
-
-		while (current != NULL) {
-			if (current->flavor == CIL_PERM) {
-				fprintf(file_arr[COMMONS], "%s ", ((struct cil_symtab_datum*)current->data)->name);
-			} else {
-				cil_log(CIL_INFO, "Improper data type found in common permissions: %d\n", current->flavor);
-				return SEPOL_ERR;
+		break;
+	case CIL_TYPE_RULE:
+		if (args->flavor == node->flavor) {
+			struct cil_type_rule *rule = node->data;
+			if (args->rule_kind == rule->rule_kind) {
+				cil_type_rule_to_policy(args->out, rule);
 			}
-			current = current->next;
 		}
-		fprintf(file_arr[COMMONS], "}\n");
-
-		return SEPOL_DONE;
-	case CIL_AVRULE: {
-		struct cil_avrule *avrule = (struct cil_avrule*)current->data;
-		rc = cil_avrule_to_policy(file_arr, ALLOWS, avrule);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Failed to write avrule to policy\n");
-			return rc;
+
+		break;
+	case CIL_NAMETYPETRANSITION:
+		if (args->flavor == node->flavor) {
+			cil_nametypetransition_to_policy(args->out, node->data);
 		}
 		break;
-	}
-	case CIL_TYPE_RULE: {
-		struct cil_type_rule *rule = (struct cil_type_rule*)current->data;
-		rc = cil_typerule_to_policy(file_arr, ALLOWS, rule);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Failed to write type rule to policy\n");
-			return rc;
+	case CIL_RANGETRANSITION:
+		if (args->flavor == node->flavor) {
+			cil_rangetransition_to_policy(args->out, node->data);
 		}
+
 		break;
-	}
-	case CIL_NAMETYPETRANSITION: {
-		struct cil_nametypetransition *nametypetrans = (struct cil_nametypetransition*)current->data;
-		rc = cil_nametypetransition_to_policy(file_arr, ALLOWS, nametypetrans);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_INFO, "Failed to write nametypetransition to policy\n");
-			return rc;
+	case CIL_TYPEPERMISSIVE:
+		if (args->flavor == node->flavor) {
+			cil_typepermissive_to_policy(args->out, node->data);
 		}
-	}
-	case CIL_ROLETRANSITION: {
-		struct cil_roletransition *roletrans = (struct cil_roletransition*)current->data;
-		char *src_str = ((struct cil_symtab_datum*)roletrans->src)->name;
-		char *tgt_str = ((struct cil_symtab_datum*)roletrans->tgt)->name;
-		char *obj_str = ((struct cil_symtab_datum*)roletrans->obj)->name;
-		char *result_str = ((struct cil_symtab_datum*)roletrans->result)->name;
-		
-		fprintf(file_arr[ALLOWS], "role_transition %s %s:%s %s;\n", src_str, tgt_str, obj_str, result_str);
 		break;
-	}
-	case CIL_ROLEALLOW: {
-		struct cil_roleallow *roleallow = (struct cil_roleallow*)current->data;
-		char *src_str = ((struct cil_symtab_datum*)roleallow->src)->name;
-		char *tgt_str = ((struct cil_symtab_datum*)roleallow->tgt)->name;
-
-		fprintf(file_arr[ALLOWS], "roleallow %s %s;\n", src_str, tgt_str);
+	default:
 		break;
 	}
-	case CIL_ROLETYPE: {
-		struct cil_roletype *roletype = (struct cil_roletype*)current->data;
-		char *role_str = ((struct cil_symtab_datum*)roletype->role)->name;
-		char *type_str = ((struct cil_symtab_datum*)roletype->type)->name;
 
-		fprintf(file_arr[ALIASES], "role %s types %s\n", role_str, type_str);
-		break;
-	}
-	case CIL_LEVEL:
-		fprintf(file_arr[LEVELS], "level ");
-		cil_level_to_policy(file_arr, LEVELS, (struct cil_level*)current->data);
-			fprintf(file_arr[LEVELS], ";\n");
-			break;
-	case CIL_CONSTRAIN:
-		cil_constrain_to_policy(file_arr, CONSTRAINS, (struct cil_constrain*)current->data, flavor);
-		break;
-	case CIL_MLSCONSTRAIN:
-		cil_constrain_to_policy(file_arr, CONSTRAINS, (struct cil_constrain*)current->data, flavor);
-		break;
-	case CIL_VALIDATETRANS: {
-		struct cil_validatetrans *vt = current->data;
-		fprintf(file_arr[CONSTRAINS], "validatetrans");
-		fprintf(file_arr[CONSTRAINS], " %s ", ((struct cil_class*)vt->class)->datum.name);
-		cil_expr_to_policy(file_arr, CONSTRAINS, vt->datum_expr);
-		fprintf(file_arr[CONSTRAINS], ";\n");
-		break;
+	return SEPOL_OK;
+}
+
+static void cil_block_te_rules_to_policy(FILE *out, struct cil_tree_node *start, int mls)
+{
+	struct block_te_rules_extra args;
+
+	args.out = out;
+
+	args.flavor = CIL_TYPEPERMISSIVE;
+	args.rule_kind = 0;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
+	args.flavor = CIL_AVRULE;
+	args.rule_kind = CIL_AVRULE_ALLOWED;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_AUDITALLOW;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_DONTAUDIT;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_NEVERALLOW;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
+	args.flavor = CIL_AVRULEX;
+	args.rule_kind = CIL_AVRULE_ALLOWED;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_AUDITALLOW;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_DONTAUDIT;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_NEVERALLOW;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
+	args.flavor = CIL_TYPE_RULE;
+	args.rule_kind = CIL_TYPE_TRANSITION;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_TYPE_MEMBER;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_TYPE_CHANGE;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+	args.rule_kind = CIL_AVRULE_TYPE;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
+	args.flavor = CIL_NAMETYPETRANSITION;
+	args.rule_kind = 0;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
+	if (mls == CIL_TRUE) {
+		args.flavor = CIL_RANGETRANSITION;
+		args.rule_kind = 0;
+		cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
 	}
-	case CIL_MLSVALIDATETRANS: {
-		struct cil_validatetrans *vt = current->data;
-		fprintf(file_arr[CONSTRAINS], "mlsvalidatetrans");
-		fprintf(file_arr[CONSTRAINS], " %s " , ((struct cil_class*)vt->class)->datum.name);
-		cil_expr_to_policy(file_arr, CONSTRAINS, vt->datum_expr);
-		fprintf(file_arr[CONSTRAINS], ";\n");
+}
+
+struct te_rules_extra {
+	FILE *out;
+	int mls;
+};
+
+static int __cil_te_rules_to_policy_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+{
+	struct te_rules_extra *args = extra_args;
+
+	switch (node->flavor) {
+	case CIL_BLOCK: {
+		struct cil_block *blk = node->data;
+		if (blk->is_abstract == CIL_TRUE) {
+			*finished = CIL_TREE_SKIP_HEAD;
+		}
 		break;
 	}
-	case CIL_SID:
-		fprintf(file_arr[ISIDS], "sid %s\n", ((struct cil_symtab_datum*)current->data)->name);
+	case CIL_MACRO:
+		*finished = CIL_TREE_SKIP_HEAD;
 		break;
-	case CIL_SIDCONTEXT: {
-		struct cil_sidcontext *sidcon = (struct cil_sidcontext*)current->data;
-		fprintf(file_arr[SIDS], "sid %s ", sidcon->sid_str);
-		cil_context_to_policy(file_arr, SIDS, sidcon->context);
-		fprintf(file_arr[SIDS], "\n");
+	case CIL_BOOLEANIF: {
+		struct cil_booleanif *bool = node->data;
+		struct cil_tree_node *n;
+		struct cil_condblock *cb;
+
+		fprintf(args->out, "if ");
+		cil_cond_expr_to_policy(args->out, bool->datum_expr, CIL_TRUE);
+		fprintf(args->out," {\n");
+		n = node->cl_head;
+		cb = n != NULL ? n->data : NULL;
+		if (cb && cb->flavor == CIL_CONDTRUE) {
+			cil_block_te_rules_to_policy(args->out, n, args->mls);
+			n = n->next;
+			cb = n != NULL ? n->data : NULL;
+		}
+		if (cb && cb->flavor == CIL_CONDFALSE) {
+			fprintf(args->out,"} else {\n");
+			cil_block_te_rules_to_policy(args->out, n, args->mls);
+		}
+		fprintf(args->out,"}\n");
+		*finished = CIL_TREE_SKIP_HEAD;
 		break;
 	}
-	case CIL_POLICYCAP:
-		fprintf(file_arr[TYPEATTRTYPES], "policycap %s;\n", ((struct cil_symtab_datum*)current->data)->name);
-		break;
 	default:
 		break;
 	}
@@ -1103,324 +1453,482 @@ int cil_name_to_policy(FILE **file_arr, struct cil_tree_node *current)
 	return SEPOL_OK;
 }
 
-int __cil_gen_policy_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+static void cil_te_rules_to_policy(FILE *out, struct cil_tree_node *head, int mls)
 {
-	int rc = SEPOL_ERR;
-	struct cil_args_genpolicy *args = NULL;
-	struct cil_list *users = NULL;
-	struct cil_list *sens = NULL;
-	struct cil_list *cats = NULL;
-	FILE **file_arr = NULL;
+	struct te_rules_extra args;
 
-	if (extra_args == NULL) {
-		return SEPOL_ERR;
-	}
+	args.out = out;
+	args.mls = mls;
 
-	*finished = CIL_TREE_SKIP_NOTHING;
+	cil_block_te_rules_to_policy(out, head, mls);
+	cil_tree_walk(head, __cil_te_rules_to_policy_helper, NULL, NULL, &args);
+}
 
-	args = extra_args;
-	users = args->users;
-	sens = args->sens;
-	cats = args->cats;
-	file_arr = args->file_arr;
+static void cil_roles_to_policy(FILE *out, struct cil_list *rules)
+{
+	struct cil_list_item *i1;
+	struct cil_role *role;
 
-	if (node->cl_head != NULL) {
-		if (node->flavor == CIL_MACRO) {
-			*finished = CIL_TREE_SKIP_HEAD;
-			return SEPOL_OK;
-		}
+	cil_list_for_each(i1, rules) {
+		role = i1->data;
+		if (strcmp(role->datum.fqn,"object_r") == 0)
+			continue;
+		fprintf(out, "role %s;\n", role->datum.fqn);
+	}
+}
 
-		if (node->flavor == CIL_BOOLEANIF) {
-			rc = cil_booleanif_to_policy(file_arr, CONDS, node);
-			if (rc != SEPOL_OK) {
-				cil_log(CIL_INFO, "Failed to write booleanif contents to file\n");
-				return rc;
+static void cil_role_types_to_policy(FILE *out, struct cil_list *roles, struct cil_list *types)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_role *role;
+	struct cil_type *type;
+	int first = CIL_TRUE;
+
+	cil_list_for_each(i1, roles) {
+		role = i1->data;
+		if (strcmp(role->datum.fqn,"object_r") == 0)
+			continue;
+		cil_list_for_each(i2, types) {
+			type = i2->data;
+			if (ebitmap_get_bit(role->types, type->value)) {
+				if (first) {
+					fprintf(out, "role %s types {%s", role->datum.fqn, type->datum.fqn);
+					first = CIL_FALSE;
+				} else {
+					fprintf(out, " %s", type->datum.fqn);
+				}
 			}
-			*finished = CIL_TREE_SKIP_HEAD;
-			return SEPOL_OK;
 		}
-
-		if (node->flavor == CIL_BLOCK && ((struct cil_block*)node->data)->is_abstract == CIL_TRUE) {
-			*finished = CIL_TREE_SKIP_HEAD;
-			return SEPOL_OK;
+		if (!first) {
+			fprintf(out, "};\n");
+			first = CIL_TRUE;
 		}
+	}
+}
 
-		if (node->flavor != CIL_ROOT) {
-			rc = cil_name_to_policy(file_arr, node);
-			if (rc != SEPOL_OK && rc != SEPOL_DONE) {
-				cil_log(CIL_ERR, "Error converting node to policy %d\n", node->flavor);
-				return SEPOL_ERR;
+static void cil_roleattributes_to_policy(FILE *out, struct cil_list *roles, struct cil_list *attributes)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_role *role;
+	struct cil_roleattribute *attribute;
+	int first = CIL_TRUE;
+
+	cil_list_for_each(i1, roles) {
+		role = i1->data;
+		if (strcmp(role->datum.fqn,"object_r") == 0)
+			continue;
+		cil_list_for_each(i2, attributes) {
+			attribute = i2->data;
+			if (ebitmap_get_bit(attribute->roles, role->value)) {
+				if (first) {
+					fprintf(out, "roleattribute %s %s", role->datum.fqn, attribute->datum.fqn);
+					first = CIL_FALSE;
+				} else {
+					fprintf(out, ", %s", attribute->datum.fqn);
+				}
 			}
 		}
-	} else {
-		switch (node->flavor) {
-		case CIL_USER:
-			cil_multimap_insert(users, node->data, NULL, CIL_USERROLE, CIL_NONE);
-			break;
-		case CIL_CATALIAS: {
-			struct cil_alias *alias = node->data;
-			struct cil_symtab_datum *datum = alias->actual;
-			cil_multimap_insert(cats, datum, node->data, CIL_CAT, CIL_CATALIAS);
-		}
-			break;
-		case CIL_SENSALIAS: {
-			struct cil_alias *alias = node->data;
-			struct cil_symtab_datum *datum = alias->actual;
-			cil_multimap_insert(sens, datum, node->data, CIL_SENS, CIL_SENSALIAS);
-		}
-			break;
-		default:
-			rc = cil_name_to_policy(file_arr, node);
-			if (rc != SEPOL_OK && rc != SEPOL_DONE) {
-				cil_log(CIL_ERR, "Error converting node to policy %d\n", rc);
-				return SEPOL_ERR;
-			}
-			break;
+		if (!first) {
+			fprintf(out, ";\n");
+			first = CIL_TRUE;
 		}
 	}
+}
 
-	return SEPOL_OK;
+static void cil_roleallows_to_policy(FILE *out, struct cil_list *roleallows)
+{
+	struct cil_list_item *i1;
+	struct cil_roleallow *allow;
+
+	cil_list_for_each(i1, roleallows) {
+		allow = i1->data;
+		fprintf(out, "allow %s %s;\n", DATUM(allow->src)->fqn, DATUM(allow->tgt)->fqn);
+	}
 }
 
-int cil_gen_policy(struct cil_db *db)
+static void cil_roletransitions_to_policy(FILE *out, struct cil_list *roletransitions)
 {
-	struct cil_tree_node *curr = db->ast->root;
-	struct cil_list_item *item;
-	int rc = SEPOL_ERR;
-	FILE *policy_file;
-	FILE **file_arr = cil_malloc(sizeof(FILE*) * NUM_POLICY_FILES);
-	char *file_path_arr[NUM_POLICY_FILES];
-	char temp[32];
-
-	struct cil_list *users = NULL;
-	struct cil_list *cats = NULL;
-	struct cil_list *sens = NULL;
-	struct cil_args_genpolicy extra_args;
-
-	cil_list_init(&users, CIL_LIST_ITEM);
-	cil_list_init(&cats, CIL_LIST_ITEM);
-	cil_list_init(&sens, CIL_LIST_ITEM);
-
-	strcpy(temp, "/tmp/cil_classdecl-XXXXXX");
-	file_arr[CLASS_DECL] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[CLASS_DECL] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_isids-XXXXXX");
-	file_arr[ISIDS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[ISIDS] = cil_strpool_add(temp);
-
-	strcpy(temp,"/tmp/cil_common-XXXXXX");
-	file_arr[COMMONS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[COMMONS] = cil_strpool_add(temp);
-	
-	strcpy(temp, "/tmp/cil_class-XXXXXX");
-	file_arr[CLASSES] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[CLASSES] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_interf-XXXXXX");
-	file_arr[INTERFACES] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[INTERFACES] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_sens-XXXXXX");
-	file_arr[SENS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[SENS] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_cats-XXXXXX");
-	file_arr[CATS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[CATS] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_levels-XXXXXX");
-	file_arr[LEVELS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[LEVELS] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_mlscon-XXXXXX");
-	file_arr[CONSTRAINS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[CONSTRAINS] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_attrtypes-XXXXXX");
-	file_arr[TYPEATTRTYPES] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[TYPEATTRTYPES] = cil_strpool_add(temp);
-	
-	strcpy(temp, "/tmp/cil_aliases-XXXXXX");
-	file_arr[ALIASES] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[ALIASES] = cil_strpool_add(temp);
-	
-	strcpy(temp, "/tmp/cil_allows-XXXXXX");
-	file_arr[ALLOWS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[ALLOWS] = cil_strpool_add(temp);
-	
-	strcpy(temp, "/tmp/cil_conds-XXXXXX");
-	file_arr[CONDS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[CONDS] = cil_strpool_add(temp);
-	
-	strcpy(temp, "/tmp/cil_userroles-XXXXXX");
-	file_arr[USERROLES] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[USERROLES] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_sids-XXXXXX");
-	file_arr[SIDS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[SIDS] = cil_strpool_add(temp);
-
-	strcpy(temp, "/tmp/cil_netifcons-XXXXXX");
-	file_arr[NETIFCONS] = fdopen(mkstemp(temp), "w+");
-	file_path_arr[NETIFCONS] = cil_strpool_add(temp);
-
-	policy_file = fopen("policy.conf", "w+");
-
-	cil_list_for_each(item, db->sidorder) {
-		fprintf(file_arr[ISIDS], "sid %s ", ((struct cil_sid*)item->data)->datum.name);
-	}
-
-	cil_list_for_each(item, db->classorder) {
-		struct cil_class *class = item->data;
-		struct cil_tree_node *node = class->datum.nodes->head->data;
-
-		fprintf(file_arr[CLASS_DECL], "class %s\n", class->datum.name);
-
-		fprintf(file_arr[CLASSES], "class %s ", class->datum.name);
-		if (class->common != NULL) {
-			fprintf(file_arr[CLASSES], "inherits %s ", class->common->datum.name);
+	struct cil_list_item *i1, *i2;
+	struct cil_list *class_list;
+	struct cil_roletransition *trans;
+
+
+	cil_list_for_each(i1, roletransitions) {
+		trans = i1->data;
+		class_list = cil_expand_class(trans->obj);
+		cil_list_for_each(i2, class_list) {
+			fprintf(out, "role_transition %s %s : %s %s;\n", DATUM(trans->src)->fqn, DATUM(trans->tgt)->fqn, DATUM(i2->data)->fqn, DATUM(trans->result)->fqn);
 		}
-		if (node->cl_head != NULL) {
-			struct cil_tree_node *curr_perm = node->cl_head;
-			fprintf(file_arr[CLASSES], "{ ");
-			while (curr_perm != NULL) {
-				fprintf(file_arr[CLASSES], "%s ", ((struct cil_symtab_datum*)curr_perm->data)->name);
-				curr_perm = curr_perm->next;
+		cil_list_destroy(&class_list, CIL_FALSE);
+	}
+}
+
+static void cil_users_to_policy(FILE *out, int mls, struct cil_list *users, struct cil_list *all_roles)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_user *user;
+	struct cil_list *roles;
+	struct cil_role *role;
+	int num_roles;
+
+	cil_list_for_each(i1, users) {
+		user = i1->data;
+		num_roles = 0;
+		fprintf(out, "user %s",user->datum.fqn);
+		cil_list_for_each(i2, all_roles) {
+			role = i2->data;
+			if (ebitmap_get_bit(user->roles, role->value)) {
+				if (num_roles == 0) {
+					cil_list_init(&roles, CIL_LIST);
+				}
+				cil_list_append(roles, CIL_ROLE, role);
+				num_roles++;
 			}
-			fprintf(file_arr[CLASSES], "}");
 		}
-		fprintf(file_arr[CLASSES], "\n");
-	}
+		if (num_roles > 0) {
+			fprintf(out, " roles");
+			if (num_roles > 1) {
+				fprintf(out, " {");
+			}
+			cil_list_for_each(i2, roles) {
+				role = i2->data;
+				fprintf(out, " %s", role->datum.fqn);
+			}
+			if (num_roles > 1) {
+				fprintf(out, " }");
+			}
+			cil_list_destroy(&roles, CIL_FALSE);
+		}
+
+		if (mls == CIL_TRUE && user->dftlevel != NULL) {
+			fprintf(out, " level ");
+			cil_level_to_policy(out, user->dftlevel);
+		}
 
-	if (db->catorder->head != NULL) {
-		cil_list_for_each(item, db->catorder) {
-			cil_multimap_insert(cats, item->data, NULL, CIL_CAT, 0);
+		if (mls == CIL_TRUE && user->range != NULL) {
+			fprintf(out, " range ");
+			cil_levelrange_to_policy(out, user->range);
 		}
+
+		fprintf(out,";\n");
 	}
+}
 
-	if (db->sensitivityorder->head != NULL) {
-		fprintf(file_arr[SENS], "sensitivityorder { ");
-		cil_list_for_each(item, db->sensitivityorder) {
-			fprintf(file_arr[SENS], "%s ", ((struct cil_sens*)item->data)->datum.name);
+static void cil_constrains_to_policy(FILE *out, struct cil_db *db, struct cil_list *constrains)
+{
+	struct cil_list_item *i1, *i2;
+	struct cil_constrain *cons;
+	struct cil_list *classperms_strs;
+	char *cp_str;
+	char *expr_str;
+
+	cil_list_for_each(i1, constrains) {
+		cons = i1->data;
+		cil_list_init(&classperms_strs, CIL_LIST);
+		cil_classperms_to_strings(cons->classperms, classperms_strs);
+		expr_str = cil_cons_expr_to_string(db, cons->datum_expr);
+		cil_list_for_each(i2, classperms_strs) {
+			cp_str = i2->data;
+			fprintf(out, "constrain %s %s;\n",cp_str, expr_str);
+			free(cp_str);
 		}
-		fprintf(file_arr[SENS], "};\n");
+		free(expr_str);
+		cil_list_destroy(&classperms_strs, CIL_FALSE);
 	}
+}
 
-	extra_args.users = users;
-	extra_args.sens = sens;
-	extra_args.cats = cats;
-	extra_args.file_arr= file_arr;
+static void cil_sid_contexts_to_policy(FILE *out, struct cil_list *sids, int mls)
+{
+	struct cil_list_item *i1;
+	struct cil_sid *sid;
 
-	rc = cil_tree_walk(curr, __cil_gen_policy_node_helper, NULL, NULL, &extra_args);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error walking tree\n");
-		return rc;
+	cil_list_for_each(i1, sids) {
+		sid = i1->data;
+		fprintf(out, "sid %s ", sid->datum.fqn);
+		cil_context_to_policy(out, sid->context, mls);
+		fprintf(out,"\n");
 	}
+}
 
-	rc = cil_netifcon_to_policy(file_arr, db->netifcon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
-	}
-	
-	rc = cil_genfscon_to_policy(file_arr, db->genfscon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+static void cil_fsuses_to_policy(FILE *out, struct cil_sort *fsuses, int mls)
+{
+	int i;
+	struct cil_fsuse *fsuse;
+
+	for (i=0; i<fsuses->count; i++) {
+		fsuse = fsuses->array[i];
+		if (fsuse->type == CIL_FSUSE_XATTR) {
+			fprintf(out, "fs_use_xattr %s ", fsuse->fs_str);
+			cil_context_to_policy(out, fsuse->context, mls);
+			fprintf(out,";\n");
+		}
 	}
 
-	rc = cil_portcon_to_policy(file_arr, db->portcon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+	for (i=0; i<fsuses->count; i++) {
+		fsuse = fsuses->array[i];
+		if (fsuse->type == CIL_FSUSE_TASK) {
+			fprintf(out, "fs_use_task %s ", fsuse->fs_str);
+			cil_context_to_policy(out, fsuse->context, mls);
+			fprintf(out,";\n");
+		}
 	}
 
-	rc = cil_nodecon_to_policy(file_arr, db->nodecon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+	for (i=0; i<fsuses->count; i++) {
+		fsuse = fsuses->array[i];
+		if (fsuse->type == CIL_FSUSE_TRANS) {
+			fprintf(out, "fs_use_trans %s ", fsuse->fs_str);
+			cil_context_to_policy(out, fsuse->context, mls);
+			fprintf(out,";\n");
+		}
 	}
+}
+
+static void cil_genfscons_to_policy(FILE *out, struct cil_sort *genfscons, int mls)
+{
+	int i;
+	struct cil_genfscon *genfscon;
 
-	rc = cil_fsuse_to_policy(file_arr, db->fsuse);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+	for (i=0; i<genfscons->count; i++) {
+		genfscon = genfscons->array[i];
+		fprintf(out, "genfscon %s %s ", genfscon->fs_str, genfscon->path_str);
+		cil_context_to_policy(out, genfscon->context, mls);
+		fprintf(out, "\n");
 	}
+}
 
-	rc = cil_pirqcon_to_policy(file_arr, db->pirqcon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+static void cil_portcons_to_policy(FILE *out, struct cil_sort *portcons, int mls)
+{
+	int i;
+	struct cil_portcon *portcon;
+
+	for (i=0; i<portcons->count; i++) {
+		portcon = portcons->array[i];
+		fprintf(out, "portcon ");
+		if (portcon->proto == CIL_PROTOCOL_UDP) {
+			fprintf(out, "udp ");
+		} else if (portcon->proto == CIL_PROTOCOL_TCP) {
+			fprintf(out, "tcp ");
+		} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
+			fprintf(out, "dccp ");
+		}
+		if (portcon->port_low == portcon->port_high) {
+			fprintf(out, "%d ", portcon->port_low);
+		} else {
+			fprintf(out, "%d-%d ", portcon->port_low, portcon->port_high);
+		}
+		cil_context_to_policy(out, portcon->context, mls);
+		fprintf(out, "\n");
 	}
+}
 
-	rc = cil_iomemcon_to_policy(file_arr, db->iomemcon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+static void cil_netifcons_to_policy(FILE *out, struct cil_sort *netifcons, int mls)
+{
+	int i;
+	struct cil_netifcon *netifcon;
+
+	for (i=0; i<netifcons->count; i++) {
+		netifcon = netifcons->array[i];
+		fprintf(out, "netifcon %s ", netifcon->interface_str);
+		cil_context_to_policy(out, netifcon->if_context, mls);
+		fprintf(out, " ");
+		cil_context_to_policy(out, netifcon->packet_context, mls);
+		fprintf(out, ";\n");
 	}
+}
+
+static void cil_nodecons_to_policy(FILE *out, struct cil_sort *nodecons, int mls)
+{
+	int i;
+	struct cil_nodecon *nodecon;
+	char *addr, *mask;
+
+	for (i=0; i<nodecons->count; i++) {
+		nodecon = nodecons->array[i];
+		fprintf(out, "nodecon ");
 
-	rc = cil_ioportcon_to_policy(file_arr, db->ioportcon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+		if (nodecon->addr->family == AF_INET) {
+			errno = 0;
+			addr = cil_malloc(INET_ADDRSTRLEN);
+			inet_ntop(nodecon->addr->family, &nodecon->addr->ip.v4, addr, INET_ADDRSTRLEN);
+			if (errno == 0) {
+				fprintf(out, "%s ",addr);
+			} else {
+				fprintf(out, "[INVALID] ");
+			}
+			free(addr);
+
+			errno = 0;
+			mask = cil_malloc(INET_ADDRSTRLEN);
+			inet_ntop(nodecon->mask->family, &nodecon->mask->ip.v4, mask, INET_ADDRSTRLEN);
+			if (errno == 0) {
+				fprintf(out, "%s ",mask);
+			} else {
+				fprintf(out, "[INVALID] ");
+			}
+			free(mask);
+		} else {
+			errno = 0;
+			addr = cil_malloc(INET6_ADDRSTRLEN);
+			inet_ntop(nodecon->addr->family, &nodecon->addr->ip.v6, addr, INET6_ADDRSTRLEN);
+			if (errno == 0) {
+				fprintf(out, "%s ",addr);
+			} else {
+				fprintf(out, "[INVALID] ");
+			}
+			free(addr);
+
+			errno = 0;
+			mask = cil_malloc(INET6_ADDRSTRLEN);
+			inet_ntop(nodecon->mask->family, &nodecon->mask->ip.v6, mask, INET6_ADDRSTRLEN);
+			if (errno == 0) {
+				fprintf(out, "%s ",mask);
+			} else {
+				fprintf(out, "[INVALID] ");
+			}
+			free(mask);
+		}
+
+		cil_context_to_policy(out, nodecon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
 
-	rc = cil_pcidevicecon_to_policy(file_arr, db->pcidevicecon);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return rc;
+static void cil_pirqcons_to_policy(FILE *out, struct cil_sort *pirqcons, int mls)
+{
+	int i;
+	struct cil_pirqcon *pirqcon;
+
+	for (i = 0; i<pirqcons->count; i++) {
+		pirqcon = pirqcons->array[i];
+		fprintf(out, "pirqcon %d ", pirqcon->pirq);
+		cil_context_to_policy(out, pirqcon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
 
-	rc = cil_userrole_to_policy(file_arr, users);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return SEPOL_ERR;
+static void cil_iomemcons_to_policy(FILE *out, struct cil_sort *iomemcons, int mls)
+{
+	int i;
+	struct cil_iomemcon *iomemcon;
+
+	for (i = 0; i<iomemcons->count; i++) {
+		iomemcon = iomemcons->array[i];
+		fprintf(out, "iomemcon %" PRIu64 "-%" PRIu64 " ", iomemcon->iomem_low, iomemcon->iomem_high);
+		cil_context_to_policy(out, iomemcon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
+
+static void cil_ioportcons_to_policy(FILE *out, struct cil_sort *ioportcons, int mls)
+{
+	int i;
+	struct cil_ioportcon *ioportcon;
 
-	rc = cil_sens_to_policy(file_arr, sens);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return SEPOL_ERR;
+	for (i = 0; i < ioportcons->count; i++) {
+		ioportcon = ioportcons->array[i];
+		fprintf(out, "ioportcon %d-%d ", ioportcon->ioport_low, ioportcon->ioport_high);
+		cil_context_to_policy(out, ioportcon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
 
-	rc = cil_cat_to_policy(file_arr, cats);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return SEPOL_ERR;
+static void cil_pcidevicecons_to_policy(FILE *out, struct cil_sort *pcidevicecons, int mls)
+{
+	int i;
+	struct cil_pcidevicecon *pcidevicecon;
+
+	for (i = 0; i < pcidevicecons->count; i++) {
+		pcidevicecon = pcidevicecons->array[i];
+		fprintf(out, "pcidevicecon %d ", pcidevicecon->dev);
+		cil_context_to_policy(out, pcidevicecon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
+
+static void cil_devicetreecons_to_policy(FILE *out, struct cil_sort *devicetreecons, int mls)
+{
+	int i;
+	struct cil_devicetreecon *devicetreecon;
 
-	rc = cil_combine_policy(file_arr, policy_file);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Error creating policy.conf\n");
-		return SEPOL_ERR;
+	for (i = 0; i < devicetreecons->count; i++) {
+		devicetreecon = devicetreecons->array[i];
+		fprintf(out, "devicetreecon %s ", devicetreecon->path);
+		cil_context_to_policy(out, devicetreecon->context, mls);
+		fprintf(out, ";\n");
 	}
+}
 
-	// Remove temp files
+void cil_gen_policy(FILE *out, struct cil_db *db)
+{
 	int i;
-	for (i=0; i<NUM_POLICY_FILES; i++) {
-		rc = fclose(file_arr[i]);
-		if (rc != 0) {
-			cil_log(CIL_ERR, "Error closing temporary file\n");
-			return SEPOL_ERR;
-		}
-		rc = unlink(file_path_arr[i]);
-		if (rc != 0) {
-			cil_log(CIL_ERR, "Error unlinking temporary files\n");
-			return SEPOL_ERR;
-		}
+	struct cil_tree_node *head = db->ast->root;
+	struct cil_list *lists[CIL_LIST_NUM_LISTS];
+
+	for (i=0; i<CIL_LIST_NUM_LISTS; i++) {
+		cil_list_init(&lists[i], CIL_LIST);
 	}
 
-	rc = fclose(policy_file);
-	if (rc != 0) {
-		cil_log(CIL_ERR, "Error closing policy.conf\n");
-		return SEPOL_ERR;
+	cil_gather_statements(head, lists);
+
+	cil_class_decls_to_policy(out, db->classorder);
+
+	cil_sid_decls_to_policy(out, db->sidorder);
+
+	cil_commons_to_policy(out, lists[CIL_LIST_COMMON]);
+	cil_classes_to_policy(out, db->classorder);
+
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], CIL_KEY_DEFAULTUSER);
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], CIL_KEY_DEFAULTROLE);
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], CIL_KEY_DEFAULTTYPE);
+
+	if (db->mls == CIL_TRUE) {
+		cil_default_ranges_to_policy(out, lists[CIL_LIST_DEFAULT_RANGE]);
+		cil_sensitivities_to_policy(out, db->sensitivityorder, lists[CIL_LIST_SENSALIAS]);
+		cil_dominance_to_policy(out, db->sensitivityorder);
+		cil_categories_to_policy(out, db->catorder, lists[CIL_LIST_CATALIAS]);
+		cil_levels_to_policy(out, db->sensitivityorder);
+		cil_mlsconstrains_to_policy(out, db, lists[CIL_LIST_MLSCONSTRAIN]);
+		cil_validatetrans_to_policy(out, db, lists[CIL_LIST_MLSVALIDATETRANS], CIL_KEY_MLSVALIDATETRANS);
 	}
-	free(file_arr);
-	
-	cil_list_destroy(&users, CIL_FALSE);
-	cil_list_destroy(&cats, CIL_FALSE);
-	cil_list_destroy(&sens, CIL_FALSE);
-	
-	return SEPOL_OK;
+
+	cil_simple_rules_to_policy(out, lists[CIL_LIST_POLICYCAP], CIL_KEY_POLICYCAP);
+
+	cil_simple_rules_to_policy(out, lists[CIL_LIST_TYPEATTRIBUTE], "attribute");
+	cil_simple_rules_to_policy(out, lists[CIL_LIST_ROLEATTRIBUTE], "attribute_role");
+
+	cil_bools_to_policy(out, lists[CIL_LIST_BOOL]);
+
+	cil_simple_rules_to_policy(out, lists[CIL_LIST_TYPE], "type");
+	cil_typealiases_to_policy(out, lists[CIL_LIST_TYPE], lists[CIL_LIST_TYPEALIAS]);
+	cil_typebounds_to_policy(out, lists[CIL_LIST_TYPE]);
+	cil_typeattributes_to_policy(out, lists[CIL_LIST_TYPE], lists[CIL_LIST_TYPEATTRIBUTE]);
+	cil_te_rules_to_policy(out, head, db->mls);
+
+	cil_roles_to_policy(out, lists[CIL_LIST_ROLE]);
+	cil_role_types_to_policy(out, lists[CIL_LIST_ROLE], lists[CIL_LIST_TYPE]);
+	cil_roleattributes_to_policy(out, lists[CIL_LIST_ROLE], lists[CIL_LIST_ROLEATTRIBUTE]);
+	cil_roleallows_to_policy(out, lists[CIL_LIST_ROLEALLOW]);
+	cil_roletransitions_to_policy(out, lists[CIL_LIST_ROLETRANSITION]);
+
+	cil_users_to_policy(out, db->mls, lists[CIL_LIST_USER], lists[CIL_LIST_ROLE]);
+
+	cil_constrains_to_policy(out, db, lists[CIL_LIST_CONSTRAINT]);
+	cil_validatetrans_to_policy(out, db, lists[CIL_LIST_VALIDATETRANS], CIL_KEY_VALIDATETRANS);
+
+	cil_sid_contexts_to_policy(out, db->sidorder, db->mls);
+	cil_fsuses_to_policy(out, db->fsuse, db->mls);
+	cil_genfscons_to_policy(out, db->genfscon, db->mls);
+	cil_portcons_to_policy(out, db->portcon, db->mls);
+	cil_netifcons_to_policy(out, db->netifcon, db->mls);
+	cil_nodecons_to_policy(out, db->nodecon, db->mls);
+	cil_pirqcons_to_policy(out, db->pirqcon, db->mls);
+	cil_iomemcons_to_policy(out, db->iomemcon, db->mls);
+	cil_ioportcons_to_policy(out, db->ioportcon, db->mls);
+	cil_pcidevicecons_to_policy(out, db->pcidevicecon, db->mls);
+	cil_devicetreecons_to_policy(out, db->devicetreecon, db->mls);
+
+	for (i=0; i<CIL_LIST_NUM_LISTS; i++) {
+		cil_list_destroy(&lists[i], CIL_FALSE);
+	}
+
 }
diff --git a/libsepol/cil/src/cil_policy.h b/libsepol/cil/src/cil_policy.h
index 72cf162..d9c0a4b 100644
--- a/libsepol/cil/src/cil_policy.h
+++ b/libsepol/cil/src/cil_policy.h
@@ -30,18 +30,8 @@
 #ifndef CIL_POLICY_H_
 #define CIL_POLICY_H_
 
-#include "cil_tree.h"
-#include "cil_list.h"
 #include "cil_internal.h"
 
-struct cil_multimap_item {
-	struct cil_symtab_datum *key;
-	struct cil_list *values;
-};
-
-int cil_combine_policy(FILE **file_arr, FILE *policy_file);
-void cil_context_to_policy(FILE **, uint32_t, struct cil_context *);
-int cil_name_to_policy(FILE **, struct cil_tree_node *);
-int cil_gen_policy(struct cil_db *);
+void cil_gen_policy(FILE *out, struct cil_db *db);
 
 #endif
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 9683caf..47a4440 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -45,6 +45,7 @@ LIBSEPOL_1.1 {
 	cil_set_target_platform;
 	cil_set_policy_version;
 	cil_set_mls;
+	cil_write_policy_conf;
 	sepol_ppfile_to_module_package;
 	sepol_module_package_to_cil;
 	sepol_module_policydb_to_cil;
-- 
2.7.4
