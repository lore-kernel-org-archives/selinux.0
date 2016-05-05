Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45Kgeho013386
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 16:42:41 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/6 v3] libsepol/cil: Remove path field from cil_tree_node
 struct
Date: Thu,  5 May 2016 16:44:18 -0400
Message-Id: <1462481059-12437-6-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Remove path field from cil_tree_node struct and all references
to it in CIL. This will reduce memory usage by 5%.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c    | 14 +++++++++++++-
 libsepol/cil/src/cil_build_ast.c |  2 --
 libsepol/cil/src/cil_copy_ast.c  |  1 -
 libsepol/cil/src/cil_parser.c    | 23 +++++++++++------------
 libsepol/cil/src/cil_tree.c      |  1 -
 libsepol/cil/src/cil_tree.h      |  1 -
 6 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index a3f9171..5d03127 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4232,6 +4232,9 @@ exit:
 static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *node)
 {
 	avrule_t *avrule;
+	struct cil_tree_node *source_node;
+	char *source_path;
+	int is_cil;
 
 	avrule = cil_malloc(sizeof(avrule_t));
 	avrule->specified = kind;
@@ -4240,8 +4243,17 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
 	__cil_init_sepol_type_set(&avrule->ttypes);
 	avrule->perms = NULL;
 	avrule->line = node->line;
-	avrule->source_filename = node->path;
+
+	avrule->source_filename = NULL;
 	avrule->source_line = node->line;
+	source_node = cil_tree_get_next_path(node, &source_path, &is_cil);
+	if (source_node) {
+		avrule->source_filename = source_path;
+		if (!is_cil) {
+			avrule->source_line = node->hll_line;
+		}
+	}
+
 	avrule->next = NULL;
 	return avrule;
 }
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 5b9754a..1505873 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -521,7 +521,6 @@ int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, st
 		new_ast->parent = ast_node;
 		new_ast->line = current_perm->line;
 		new_ast->hll_line = current_perm->hll_line;
-		new_ast->path = current_perm->path;
 
 		rc = cil_gen_perm(db, current_perm, new_ast, flavor, num_perms);
 		if (rc != SEPOL_OK) {
@@ -5919,7 +5918,6 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	ast_node->parent = ast_current;
 	ast_node->line = parse_current->line;
 	ast_node->hll_line = parse_current->hll_line;
-	ast_node->path = parse_current->path;
 
 	if (parse_current->data == CIL_KEY_BLOCK) {
 		rc = cil_gen_block(db, parse_current, ast_node, 0);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index ad69781..5debd0d 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1983,7 +1983,6 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 		new->parent = parent;
 		new->line = orig->line;
 		new->hll_line = orig->hll_line;
-		new->path = orig->path;
 		new->flavor = orig->flavor;
 		new->data = data;
 
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index 451014a..101520c 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -78,14 +78,13 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
 	}
 }
 
-static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, char *path, void *value)
+static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, void *value)
 {
 	cil_tree_node_init(node);
 	(*node)->parent = current;
 	(*node)->flavor = CIL_NODE;
 	(*node)->line = line;
 	(*node)->hll_line = hll_line;
-	(*node)->path = path;
 	(*node)->data = value;
 }
 
@@ -117,14 +116,14 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
 		pop_hll_info(stack, hll_lineno, hll_expand);
 		*current = (*current)->parent;
 	} else {
-		create_node(&node, *current, tok.line, *hll_lineno, path, NULL);
+		create_node(&node, *current, tok.line, *hll_lineno, NULL);
 		insert_node(node, *current);
 		*current = node;
 
-		create_node(&node, *current, tok.line, *hll_lineno, path, CIL_KEY_SRC_INFO);
+		create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_INFO);
 		insert_node(node, *current);
 
-		create_node(&node, *current, tok.line, *hll_lineno, path, CIL_KEY_SRC_HLL);
+		create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_HLL);
 		insert_node(node, *current);
 
 		if (hll_type == CIL_KEY_HLL_LMS) {
@@ -162,7 +161,7 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
 
 		hll_file = cil_strpool_add(tok.value);
 
-		create_node(&node, *current, tok.line, *hll_lineno, path, hll_file);
+		create_node(&node, *current, tok.line, *hll_lineno, hll_file);
 		insert_node(node, *current);
 	}
 
@@ -183,17 +182,17 @@ static void add_cil_path(struct cil_tree_node **current, char *path)
 {
 	struct cil_tree_node *node;
 
-	create_node(&node, *current, 0, 0, path, NULL);
+	create_node(&node, *current, 0, 0, NULL);
 	insert_node(node, *current);
 	*current = node;
 
-	create_node(&node, *current, 0, 0, path, CIL_KEY_SRC_INFO);
+	create_node(&node, *current, 0, 0, CIL_KEY_SRC_INFO);
 	insert_node(node, *current);
 
-	create_node(&node, *current, 0, 0, path, CIL_KEY_SRC_CIL);
+	create_node(&node, *current, 0, 0, CIL_KEY_SRC_CIL);
 	insert_node(node, *current);
 
-	create_node(&node, *current, 0, 0, path, path);
+	create_node(&node, *current, 0, 0, path);
 	insert_node(node, *current);
 }
 
@@ -237,7 +236,7 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
 		case OPAREN:
 			paren_count++;
 
-			create_node(&node, current, tok.line, hll_lineno, path, NULL);
+			create_node(&node, current, tok.line, hll_lineno, NULL);
 			insert_node(node, current);
 			current = node;
 			break;
@@ -258,7 +257,7 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
 				goto exit;
 			}
 
-			create_node(&node, current, tok.line, hll_lineno, path, cil_strpool_add(tok.value));
+			create_node(&node, current, tok.line, hll_lineno, cil_strpool_add(tok.value));
 			insert_node(node, current);
 			break;
 		case NEWLINE :
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 7dc1a1e..9ff9d4b 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -216,7 +216,6 @@ void cil_tree_node_init(struct cil_tree_node **node)
 	new_node->flavor = CIL_ROOT;
 	new_node->line = 0;
 	new_node->hll_line = 0;
-	new_node->path = NULL;
 
 	*node = new_node;
 }
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index 318eecd..aeded56 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -47,7 +47,6 @@ struct cil_tree_node {
 	enum cil_flavor flavor;
 	uint32_t line;
 	uint32_t hll_line;
-	char *path;
 	void *data;
 };
 
-- 
2.5.5
