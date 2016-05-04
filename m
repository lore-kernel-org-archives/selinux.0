Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u44KdQa2014889
 for <selinux@tycho.nsa.gov>; Wed, 4 May 2016 16:39:26 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/6 v2] libsepol/cil: Store CIL filename in parse tree and AST
Date: Wed,  4 May 2016 16:41:02 -0400
Message-Id: <1462394466-25076-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1462394466-25076-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1462394466-25076-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use some of the functionality recently added to support high-level
language line marking to track the CIL filename.

The goal is to eventually remove the path field from the tree node
struct and offset the addtion of the hll_line field.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_parser.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index a92e3bb..451014a 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -179,6 +179,24 @@ exit:
 	return SEPOL_ERR;
 }
 
+static void add_cil_path(struct cil_tree_node **current, char *path)
+{
+	struct cil_tree_node *node;
+
+	create_node(&node, *current, 0, 0, path, NULL);
+	insert_node(node, *current);
+	*current = node;
+
+	create_node(&node, *current, 0, 0, path, CIL_KEY_SRC_INFO);
+	insert_node(node, *current);
+
+	create_node(&node, *current, 0, 0, path, CIL_KEY_SRC_CIL);
+	insert_node(node, *current);
+
+	create_node(&node, *current, 0, 0, path, path);
+	insert_node(node, *current);
+}
+
 int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse_tree)
 {
 
@@ -205,6 +223,8 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
 	tree = *parse_tree;
 	current = tree->root;
 
+	add_cil_path(&current, path);
+
 	do {
 		cil_lexer_next(&tok);
 		switch (tok.type) {
-- 
2.5.5
