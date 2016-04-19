Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JEOYFI005142
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 10:24:34 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/6] libsepol/cil: Add high-level language line marking support
Date: Tue, 19 Apr 2016 10:26:00 -0400
Message-Id: <1461075965-17161-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds support for tracking original file and line numbers for
better error reporting when a high-level language is translated
into CIL.

This adds a field called "hll_line" to struct cil_tree_node which
increases memory usage by 5%.

Syntax:

;;* lm(s|x) LINENO FILENAME
(CIL STATEMENTS)
;;* lme

lms is used when each of the following CIL statements corresponds
to a line in the original file.

lmx is used when the following CIL statements are all expanded
from a single high-level language line.

lme ends a line mark block.

Example:

;;* lms 1 foo.hll
(CIL-1)
(CIL-2)
;;* lme
;;* lmx 10 bar.hll
(CIL-3)
(CIL-4)
;;* lms 100 baz.hll
(CIL-5)
(CIL-6)
;;* lme
(CIL-7)
;;* lme

CIL-1 is from line   1 of foo.hll
CIL-2 is from line   2 of foo.hll
CIL-3 is from line  10 of bar.hll
CIL-4 is from line  10 of bar.hll
CIL-5 is from line 100 of baz.hll
CIL-6 is from line 101 of baz.hll
CIL-7 is from line  10 of bar.hll

Based on work originally done by Yuli Khodorkovskiy of Tresys.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil.c           |  19 +++-
 libsepol/cil/src/cil_build_ast.c |  29 ++++-
 libsepol/cil/src/cil_build_ast.h |   2 +
 libsepol/cil/src/cil_copy_ast.c  |  19 ++++
 libsepol/cil/src/cil_flavor.h    |   1 +
 libsepol/cil/src/cil_internal.h  |   9 ++
 libsepol/cil/src/cil_lexer.h     |   6 +-
 libsepol/cil/src/cil_lexer.l     |  14 +--
 libsepol/cil/src/cil_parser.c    | 226 ++++++++++++++++++++++++++++++++-------
 libsepol/cil/src/cil_tree.c      |   3 +-
 libsepol/cil/src/cil_tree.h      |   1 +
 11 files changed, 278 insertions(+), 51 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index de7033a..40d520b 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -233,6 +233,9 @@ static void cil_init_keys(void)
 	CIL_KEY_PERMISSIONX = cil_strpool_add("permissionx");
 	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
 	CIL_KEY_UNORDERED = cil_strpool_add("unordered");
+	CIL_KEY_SRC_INFO = cil_strpool_add("<src_info>");
+	CIL_KEY_SRC_CIL = cil_strpool_add("<src_cil>");
+	CIL_KEY_SRC_HLL = cil_strpool_add("<src_hll>");
 }
 
 void cil_db_init(struct cil_db **db)
@@ -757,6 +760,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_MLS:
 		cil_destroy_mls(*data);
 		break;
+	case CIL_SRC_INFO:
+		cil_destroy_src_info(*data);
+		break;
 	case CIL_OP:
 	case CIL_CONS_OPERAND:
 		break;
@@ -764,8 +770,8 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_log(CIL_INFO, "Unknown data flavor: %d\n", flavor);
 		break;
 	}
-	
-	*data = NULL;		
+
+	*data = NULL;
 }
 
 int cil_flavor_to_symtab_index(enum cil_flavor flavor, enum cil_sym_index *sym_index)
@@ -1109,6 +1115,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_HANDLEUNKNOWN;
 	case CIL_MLS:
 		return CIL_KEY_MLS;
+	case CIL_SRC_INFO:
+		return CIL_KEY_SRC_INFO;
 	case CIL_ALL:
 		return CIL_KEY_ALL;
 	case CIL_RANGE:
@@ -2554,3 +2562,10 @@ void cil_mls_init(struct cil_mls **mls)
 	*mls = cil_malloc(sizeof(**mls));
 	(*mls)->value = 0;
 }
+
+void cil_src_info_init(struct cil_src_info **info)
+{
+	*info = cil_malloc(sizeof(**info));
+	(*info)->is_cil = 0;
+	(*info)->path = NULL;
+}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 90fee8e..86adb4b 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -527,6 +527,7 @@ int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, st
 		cil_tree_node_init(&new_ast);
 		new_ast->parent = ast_node;
 		new_ast->line = current_perm->line;
+		new_ast->hll_line = current_perm->hll_line;
 		new_ast->path = current_perm->path;
 
 		rc = cil_gen_perm(db, current_perm, new_ast, flavor, num_perms);
@@ -5881,6 +5882,27 @@ void cil_destroy_mls(struct cil_mls *mls)
 	free(mls);
 }
 
+int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	/* No need to check syntax, because this is auto generated */
+	struct cil_src_info *info = NULL;
+
+	cil_src_info_init(&info);
+
+	info->is_cil = (parse_current->next->data == CIL_KEY_SRC_CIL) ? CIL_TRUE : CIL_FALSE;
+	info->path = parse_current->next->next->data;
+
+	ast_node->data = info;
+	ast_node->flavor = CIL_SRC_INFO;
+
+	return SEPOL_OK;
+}
+
+void cil_destroy_src_info(struct cil_src_info *info)
+{
+	free(info);
+}
+
 int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
 {
 	struct cil_args_build *args = NULL;
@@ -5981,6 +6003,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 
 	ast_node->parent = ast_current;
 	ast_node->line = parse_current->line;
+	ast_node->hll_line = parse_current->hll_line;
 	ast_node->path = parse_current->path;
 
 	if (parse_current->data == CIL_KEY_BLOCK) {
@@ -6244,8 +6267,10 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_MLS) {
 		rc = cil_gen_mls(parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_SRC_INFO) {
+		rc = cil_gen_src_info(parse_current, ast_node);
 	} else {
-		cil_log(CIL_ERR, "Error: Unknown keyword %s\n", (char*)parse_current->data);
+		cil_log(CIL_ERR, "Error: Unknown keyword %s\n", (char *)parse_current->data);
 		rc = SEPOL_ERR;
 	}
 
@@ -6266,7 +6291,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			if (ast_current->flavor == CIL_IN) {
 				args->in = ast_current;
 			}
-		
+
 			ast_current->cl_head = ast_node;
 		} else {
 			ast_current->cl_tail->next = ast_node;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index f428394..825029e 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -215,6 +215,8 @@ int cil_gen_mls(struct cil_tree_node *parse_current, struct cil_tree_node *ast_n
 void cil_destroy_mls(struct cil_mls *mls);
 int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_defaultrange(struct cil_defaultrange *def);
+int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_src_info(struct cil_src_info *info);
 
 int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats);
 void cil_destroy_cats(struct cil_cats *cats);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 0be1dda..5615b30 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1666,6 +1666,21 @@ int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
+int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_src_info *orig = data;
+	struct cil_src_info *new = NULL;
+
+	cil_src_info_init(&new);
+
+	new->is_cil = orig->is_cil;
+	new->path = orig->path;
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
@@ -1942,6 +1957,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_MLS:
 		copy_func = &cil_copy_mls;
 		break;
+	case CIL_SRC_INFO:
+		copy_func = &cil_copy_src_info;
+		break;
 	default:
 		goto exit;
 	}
@@ -1964,6 +1982,7 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 
 		new->parent = parent;
 		new->line = orig->line;
+		new->hll_line = orig->hll_line;
 		new->path = orig->path;
 		new->flavor = orig->flavor;
 		new->data = data;
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 9fb5083..cd08b97 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -111,6 +111,7 @@ enum cil_flavor {
 	CIL_DEFAULTRANGE,
 	CIL_HANDLEUNKNOWN,
 	CIL_MLS,
+	CIL_SRC_INFO,
 
 /*
  *          boolean  constraint  set  catset
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index a75ddf8..5875dc9 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -226,6 +226,9 @@ char *CIL_KEY_NEVERALLOWX;
 char *CIL_KEY_PERMISSIONX;
 char *CIL_KEY_IOCTL;
 char *CIL_KEY_UNORDERED;
+char *CIL_KEY_SRC_INFO;
+char *CIL_KEY_SRC_CIL;
+char *CIL_KEY_SRC_HLL;
 
 /*
 	Symbol Table Array Indices
@@ -917,6 +920,11 @@ struct cil_mls {
 	int value;
 };
 
+struct cil_src_info {
+	int is_cil;
+	char *path;
+};
+
 void cil_db_init(struct cil_db **db);
 void cil_db_destroy(struct cil_db **db);
 
@@ -1019,6 +1027,7 @@ void cil_default_init(struct cil_default **def);
 void cil_defaultrange_init(struct cil_defaultrange **def);
 void cil_handleunknown_init(struct cil_handleunknown **unk);
 void cil_mls_init(struct cil_mls **mls);
+void cil_src_info_init(struct cil_src_info **info);
 void cil_userattribute_init(struct cil_userattribute **attribute);
 void cil_userattributeset_init(struct cil_userattributeset **attrset);
 
diff --git a/libsepol/cil/src/cil_lexer.h b/libsepol/cil/src/cil_lexer.h
index 1537d5e..ab555d8 100644
--- a/libsepol/cil/src/cil_lexer.h
+++ b/libsepol/cil/src/cil_lexer.h
@@ -37,8 +37,10 @@
 #define SYMBOL 3
 #define QSTRING 4
 #define COMMENT 5
-#define END_OF_FILE 6
-#define UNKNOWN 7
+#define HLL_LINEMARK 6
+#define NEWLINE 7
+#define END_OF_FILE 8
+#define UNKNOWN 9
 
 struct token {
 	uint32_t type;
diff --git a/libsepol/cil/src/cil_lexer.l b/libsepol/cil/src/cil_lexer.l
index 8e4c207..6da79c4 100644
--- a/libsepol/cil/src/cil_lexer.l
+++ b/libsepol/cil/src/cil_lexer.l
@@ -50,15 +50,16 @@ symbol		({digit}|{alpha}|{spec_char})+
 white		[ \t]
 newline		[\n\r]
 qstring		\"[^"\n]*\"
-comment		;[^\n]*
+comment		;[^;*\n]*
 
 %%
-{newline}	line++; 
+{newline}	line++; return NEWLINE;
+";;*"		value=yytext; return HLL_LINEMARK;
 {comment}	value=yytext; return COMMENT;
 "("		value=yytext; return OPAREN;
-")"		value=yytext; return CPAREN;	
+")"		value=yytext; return CPAREN;
 {symbol}	value=yytext; return SYMBOL;
-{white}		//cil_log(CIL_INFO, "white, ");
+{white}		;
 {qstring}	value=yytext; return QSTRING;
 <<EOF>>		return END_OF_FILE;
 .		value=yytext; return UNKNOWN;
@@ -73,7 +74,7 @@ int cil_lexer_setup(char *buffer, uint32_t size)
 	}
 
 	line = 1;
-	
+
 	return SEPOL_OK;
 }
 
@@ -87,7 +88,6 @@ int cil_lexer_next(struct token *tok)
 	tok->type = yylex();
 	tok->value = value;
 	tok->line = line;
-	
+
 	return SEPOL_OK;
 }
-
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index d0e108c..23d1466 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -36,9 +36,148 @@
 #include "cil_internal.h"
 #include "cil_log.h"
 #include "cil_mem.h"
-#include "cil_tree.h" 
+#include "cil_tree.h"
 #include "cil_lexer.h"
 #include "cil_strpool.h"
+#include "cil_stack.h"
+
+char *CIL_KEY_HLL_LMS;
+char *CIL_KEY_HLL_LMX;
+char *CIL_KEY_HLL_LME;
+
+struct hll_info {
+	int hll_lineno;
+	int hll_expand;
+};
+
+static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expand)
+{
+	struct hll_info *new = cil_malloc(sizeof(*new));
+
+	new->hll_lineno = hll_lineno;
+	new->hll_expand = hll_expand;
+
+	cil_stack_push(stack, CIL_NONE, new);
+}
+
+static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expand)
+{
+	struct cil_stack_item *curr = cil_stack_pop(stack);
+	struct cil_stack_item *prev = cil_stack_peek(stack);
+	struct hll_info *old;
+
+	free(curr->data);
+
+	if (!prev) {
+		*hll_lineno = -1;
+		*hll_expand = -1;
+	} else {
+		old = prev->data;
+		*hll_lineno = old->hll_lineno;
+		*hll_expand = old->hll_expand;
+	}
+}
+
+static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, char *path, void *value)
+{
+	cil_tree_node_init(node);
+	(*node)->parent = current;
+	(*node)->flavor = CIL_NODE;
+	(*node)->line = line;
+	(*node)->hll_line = hll_line;
+	(*node)->path = path;
+	(*node)->data = value;
+}
+
+static void insert_node(struct cil_tree_node *node, struct cil_tree_node *current)
+{
+	if (current->cl_head == NULL) {
+		current->cl_head = node;
+	} else {
+		current->cl_tail->next = node;
+	}
+	current->cl_tail = node;
+}
+
+static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int *hll_expand, struct cil_stack *stack, char *path)
+{
+	char *hll_type;
+	struct cil_tree_node *node;
+	struct token tok;
+	char *hll_file;
+	char *end = NULL;
+
+	cil_lexer_next(&tok);
+	hll_type = cil_strpool_add(tok.value);
+	if (hll_type == CIL_KEY_HLL_LME) {
+		if (cil_stack_is_empty(stack)) {
+			cil_log(CIL_ERR, "Line mark end without start\n");
+			goto exit;
+		}
+		pop_hll_info(stack, hll_lineno, hll_expand);
+		*current = (*current)->parent;
+	} else {
+		create_node(&node, *current, tok.line, *hll_lineno, path, NULL);
+		insert_node(node, *current);
+		*current = node;
+
+		create_node(&node, *current, tok.line, *hll_lineno, path, CIL_KEY_SRC_INFO);
+		insert_node(node, *current);
+
+		create_node(&node, *current, tok.line, *hll_lineno, path, CIL_KEY_SRC_HLL);
+		insert_node(node, *current);
+
+		if (hll_type == CIL_KEY_HLL_LMS) {
+			*hll_expand = 0;
+		} else if (hll_type == CIL_KEY_HLL_LMX) {
+			*hll_expand = 1;
+		} else {
+			cil_log(CIL_ERR, "Invalid line mark syntax\n");
+			goto exit;
+		}
+
+		cil_lexer_next(&tok);
+		if (tok.type != SYMBOL) {
+			cil_log(CIL_ERR, "Invalid line mark syntax\n");
+			goto exit;
+		}
+		*hll_lineno = strtol(tok.value, &end, 10);
+		if (errno == ERANGE || *end != '\0') {
+			cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
+			goto exit;
+		}
+
+		push_hll_info(stack, *hll_lineno, *hll_expand);
+
+		cil_lexer_next(&tok);
+		if (tok.type != SYMBOL && tok.type != QSTRING) {
+			cil_log(CIL_ERR, "Invalid line mark syntax\n");
+			goto exit;
+		}
+
+		if (tok.type == QSTRING) {
+			tok.value[strlen(tok.value) - 1] = '\0';
+			tok.value = tok.value+1;
+		}
+
+		hll_file = cil_strpool_add(tok.value);
+
+		create_node(&node, *current, tok.line, *hll_lineno, path, hll_file);
+		insert_node(node, *current);
+	}
+
+	cil_lexer_next(&tok);
+	if (tok.type != NEWLINE) {
+		cil_log(CIL_ERR, "Invalid line mark syntax\n");
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Problem with high-level line mark at line %d of %s\n", tok.line, path);
+	return SEPOL_ERR;
+}
 
 int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse_tree)
 {
@@ -47,71 +186,74 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
 
 	struct cil_tree *tree = NULL;
 	struct cil_tree_node *node = NULL;
-	struct cil_tree_node *item = NULL;
 	struct cil_tree_node *current = NULL;
 	char *path = cil_strpool_add(_path);
-
+	struct cil_stack *stack;
+	int hll_lineno = -1;
+	int hll_expand = -1;
 	struct token tok;
+	int rc = SEPOL_OK;
+
+	CIL_KEY_HLL_LMS = cil_strpool_add("lms");
+	CIL_KEY_HLL_LMX = cil_strpool_add("lmx");
+	CIL_KEY_HLL_LME = cil_strpool_add("lme");
+
+	cil_stack_init(&stack);
 
 	cil_lexer_setup(buffer, size);
 
 	tree = *parse_tree;
-	current = tree->root;	
+	current = tree->root;
 
 	do {
 		cil_lexer_next(&tok);
 		switch (tok.type) {
+		case HLL_LINEMARK:
+			rc = add_hll_linemark(&current, &hll_lineno, &hll_expand, stack, path);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+			break;
 		case OPAREN:
 			paren_count++;
-			cil_tree_node_init(&node);
-			node->parent = current;
-			node->flavor = CIL_NODE;
-			node->line = tok.line;
-			node->path = path;
-			if (current->cl_head == NULL) {
-				current->cl_head = node;
-			} else {
-				current->cl_tail->next = node;
-			}
-			current->cl_tail = node;
+
+			create_node(&node, current, tok.line, hll_lineno, path, NULL);
+			insert_node(node, current);
 			current = node;
 			break;
 		case CPAREN:
 			paren_count--;
 			if (paren_count < 0) {
 				cil_log(CIL_ERR, "Close parenthesis without matching open at line %d of %s\n", tok.line, path);
-				return SEPOL_ERR;
+				goto exit;
 			}
 			current = current->parent;
 			break;
-		case SYMBOL:
 		case QSTRING:
+			tok.value[strlen(tok.value) - 1] = '\0';
+			tok.value = tok.value+1;
+		case SYMBOL:
 			if (paren_count == 0) {
 				cil_log(CIL_ERR, "Symbol not inside parenthesis at line %d of %s\n", tok.line, path);
-				return SEPOL_ERR;
+				goto exit;
 			}
-			cil_tree_node_init(&item);
-			item->parent = current;
-			if (tok.type == QSTRING) {
-				tok.value[strlen(tok.value) - 1] = '\0';
-				item->data = cil_strpool_add(tok.value + 1);
-			} else {
-				item->data = cil_strpool_add(tok.value);
-			}
-			item->flavor = CIL_NODE;
-			item->line = tok.line;
-			item->path = path;
-			if (current->cl_head == NULL) {
-				current->cl_head = item;
-			} else {
-				current->cl_tail->next = item;
+
+			create_node(&node, current, tok.line, hll_lineno, path, cil_strpool_add(tok.value));
+			insert_node(node, current);
+			break;
+		case NEWLINE :
+			if (!hll_expand) {
+				hll_lineno++;
 			}
-			current->cl_tail = item;
 			break;
 		case END_OF_FILE:
 			if (paren_count > 0) {
 				cil_log(CIL_ERR, "Open parenthesis without matching close at line %d of %s\n", tok.line, path);
-				return SEPOL_ERR;
+				goto exit;
+			}
+			if (!cil_stack_is_empty(stack)) {
+				cil_log(CIL_ERR, "High-level language line marker start without close at line %d of %s\n", tok.line, path);
+				goto exit;
 			}
 			break;
 		case COMMENT:
@@ -119,17 +261,27 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
 			break;
 		case UNKNOWN:
 			cil_log(CIL_ERR, "Invalid token '%s' at line %d of %s\n", tok.value, tok.line, path);
-			return SEPOL_ERR;
+			goto exit;
 		default:
 			cil_log(CIL_ERR, "Unknown token type '%d' at line %d of %s\n", tok.type, tok.line, path);
-			return SEPOL_ERR;
+			goto exit;
 		}
 	}
 	while (tok.type != END_OF_FILE);
 
 	cil_lexer_destroy();
 
+	cil_stack_destroy(&stack);
+
 	*parse_tree = tree;
 
 	return SEPOL_OK;
+
+exit:
+	while (!cil_stack_is_empty(stack)) {
+		pop_hll_info(stack, &hll_lineno, &hll_expand);
+	}
+	cil_stack_destroy(&stack);
+
+	return SEPOL_ERR;
 }
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 563b817..6e56dd1 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -128,7 +128,8 @@ void cil_tree_node_init(struct cil_tree_node **node)
 	new_node->data = NULL;
 	new_node->next = NULL;
 	new_node->flavor = CIL_ROOT;
-	new_node->line = 0;	
+	new_node->line = 0;
+	new_node->hll_line = 0;
 	new_node->path = NULL;
 
 	*node = new_node;
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index 9bb602f..43d6b98 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -46,6 +46,7 @@ struct cil_tree_node {
 	struct cil_tree_node *next;		//Each element in the list points to the next element
 	enum cil_flavor flavor;
 	uint32_t line;
+	uint32_t hll_line;
 	char *path;
 	void *data;
 };
-- 
2.5.5
