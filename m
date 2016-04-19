Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JEOYFK005142
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 10:24:34 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/6] libsepol/cil: Add cil_tree_log() and supporting functions
Date: Tue, 19 Apr 2016 10:26:02 -0400
Message-Id: <1461075965-17161-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Provide more detailed log messages containing all relevant CIL and
high-level language source file information through cil_tree_log().

cil_tree_log() uses two new functions: cil_tree_get_next_path() and
cil_tree_get_cil_path().

cil_tree_get_next_path() traverses up the parse tree or AST until
it finds the next CIL or high-level language source information nodes.
It will return the path and whether or not the path is for a CIL file.

cil_tree_get_cil_path() uses cil_tree_get_next_path() to return
the CIL path.

Example cil_tree_log() message:
    Problem at line 21 of policy.cil (from line 11 of foo.hll) (from line 2 of bar.hll)

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_tree.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_tree.h |  4 +++
 2 files changed, 80 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 6e56dd1..1ccf9f5 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -59,6 +59,82 @@ __attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_e
 	exit(1);
 }
 
+struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil)
+{
+	if (!node) {
+		return NULL;
+	}
+
+	node = node->parent;
+
+	while (node) {
+		if (node->flavor == CIL_SRC_INFO) {
+			/* AST */
+			struct cil_src_info *info = node->data;
+			*path = info->path;
+			*is_cil = info->is_cil;
+			return node;
+		} else if (node->flavor == CIL_NODE && node->data == NULL) {
+			if (node->cl_head->data == CIL_KEY_SRC_INFO) {
+				/* Parse Tree */
+				*path = node->cl_head->next->next->data;
+				*is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
+				return node;
+			}
+		}
+		node = node->parent;
+	}
+
+	return NULL;
+}
+
+char *cil_tree_get_cil_path(struct cil_tree_node *node)
+{
+	char *path = NULL;
+	int is_cil;
+
+	while (node) {
+		node = cil_tree_get_next_path(node, &path, &is_cil);
+		if (node && is_cil) {
+			return path;
+		}
+	}
+
+	return NULL;
+}
+
+__attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...)
+{
+	va_list ap;
+
+	va_start(ap, msg);
+	cil_vlog(lvl, msg, ap);
+	va_end(ap);
+
+	if (node) {
+		char *path = NULL;
+		int is_cil;
+		unsigned hll_line = node->hll_line;
+
+		path = cil_tree_get_cil_path(node);
+
+		if (path != NULL) {
+			cil_log(lvl, " at line %d of %s", node->line, path);
+		}
+
+		while (node) {
+			node = cil_tree_get_next_path(node, &path, &is_cil);
+			if (node && !is_cil) {
+				cil_log(lvl," (from line %d of %s)", hll_line, path);
+				path = NULL;
+				hll_line = node->hll_line;
+			}
+		}
+	}
+
+	cil_log(lvl,"\n");
+}
+
 int cil_tree_init(struct cil_tree **tree)
 {
 	struct cil_tree *new_tree = cil_malloc(sizeof(*new_tree));
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index 43d6b98..318eecd 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -51,6 +51,10 @@ struct cil_tree_node {
 	void *data;
 };
 
+struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil);
+char *cil_tree_get_cil_path(struct cil_tree_node *node);
+__attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
+
 int cil_tree_init(struct cil_tree **tree);
 void cil_tree_destroy(struct cil_tree **tree);
 void cil_tree_subtree_destroy(struct cil_tree_node *node);
-- 
2.5.5
