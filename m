Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t45JKBF0007701
 for <selinux@tycho.nsa.gov>; Tue, 5 May 2015 15:20:11 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH v2] libsepol/cil: Verify users prior to evaluating users
Date: Tue, 5 May 2015 15:19:59 -0400
Message-ID: <1430853599-24347-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If a userlevel or userrange statement is missing from a policy,
evaluate_level_expression() and evaluate_levelrange_expression, respectively
will have a NULL pointer dereference caused by a missing level in a user.

Add cil_pre_verify() which verifies users have a valid level. Also, move loop
checking in classpermissions into cil_pre_verify().

This fixes https://github.com/SELinuxProject/cil/issues/1.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsepol/cil/src/cil_post.c   | 20 +++++++++++++++++++-
 libsepol/cil/src/cil_verify.c | 37 ++++++++++++++++++++-----------------
 libsepol/cil/src/cil_verify.h |  2 +-
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 633a5a1..f91727f 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1691,12 +1691,30 @@ exit:
 	return rc;
 }
 
+static int cil_pre_verify(struct cil_db *db)
+{
+	int rc = SEPOL_ERR;
+	struct cil_args_verify extra_args;
+
+	extra_args.db = db;
+
+	rc = cil_tree_walk(db->ast->root, __cil_pre_verify_helper, NULL, NULL, &extra_args);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to verify cil database\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
 int cil_post_process(struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 
-	rc = cil_verify_no_classperms_loop(db);
+	rc = cil_pre_verify(db);
 	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to verify cil database\n");
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 399c94a..62b88d0 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -601,7 +601,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_user(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_user_pre_eval(struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_user *user = node->data;
@@ -635,6 +635,17 @@ int __cil_verify_user(struct cil_db *db, struct cil_tree_node *node)
 		}
 	}
 
+	return SEPOL_OK;
+exit:
+	cil_log(CIL_ERR, "Invalid user at line %d of %s\n", node->line, node->path);
+	return rc;
+}
+
+static int __cil_verify_user_post_eval(struct cil_db *db, struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	struct cil_user *user = node->data;
+
 	/* Verify user range only if anonymous */
 	if (user->range->datum.name == NULL) {
 		rc = __cil_verify_levelrange(db, user->range);
@@ -1318,7 +1329,7 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 	case 0: {
 		switch (node->flavor) {
 		case CIL_USER:
-			rc = __cil_verify_user(db, node);
+			rc = __cil_verify_user_post_eval(db, node);
 			break;
 		case CIL_SELINUXUSERDEFAULT:
 			(*nseuserdflt)++;
@@ -1531,7 +1542,7 @@ static int __cil_verify_map_class(struct cil_tree_node *node)
 	return SEPOL_OK;
 }
 
-static int __cil_verify_no_classperms_loop_helper(struct cil_tree_node *node, uint32_t *finished, __attribute__((unused)) void *extra_args)
+int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
 	int rc = SEPOL_ERR;
 
@@ -1549,6 +1560,12 @@ static int __cil_verify_no_classperms_loop_helper(struct cil_tree_node *node, ui
 	}
 
 	switch (node->flavor) {
+	case CIL_USER:
+		rc = __cil_verify_user_pre_eval(node);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		break;
 	case CIL_MAP_CLASS:
 		rc = __cil_verify_map_class(node);
 		break;
@@ -1563,17 +1580,3 @@ static int __cil_verify_no_classperms_loop_helper(struct cil_tree_node *node, ui
 exit:
 	return rc;
 }
-
-int cil_verify_no_classperms_loop(struct cil_db *db)
-{
-	int rc = SEPOL_ERR;
-
-	rc = cil_tree_walk(db->ast->root, __cil_verify_no_classperms_loop_helper, NULL, NULL, NULL);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to verify no loops in class permissions\n");
-		goto exit;
-	}
-
-exit:
-	return rc;
-}
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 1f47641..bda1565 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -68,6 +68,6 @@ int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor);
 int __cil_verify_initsids(struct cil_list *sids);
 int __cil_verify_senscat(struct cil_sens *sens, struct cil_cat *cat);
 int __cil_verify_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args);
-int cil_verify_no_classperms_loop(struct cil_db *db);
+int __cil_pre_verify_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args);
 
 #endif
-- 
1.9.3
