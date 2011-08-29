Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T8LIO4031217
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 04:21:26 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T8LPFQ015589
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 08:21:25 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 7/7] Create a new preserve_tunables flag in sepol_handle_t.
Date: Mon, 29 Aug 2011 16:21:06 +0800
Message-ID: <1314606066-12314-8-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
References: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By default only the effective branch of a tunable conditional would be
expanded and written to raw policy, while all needless unused branches
would be discarded.

Add a new option '-P' or "--preserve_tunables" to the semodule program.
By default it is 0, if set to 1 then the above preserve_tunables flag
in the sepol_handle_t would be set to 1 accordingly, then all branches
of any tunable conditionals would be preserved, resulting in tunables
treated exactly like normal booleans. This would be good for debug
purpose.

Note, this option would invalidate the logic to double check if there
is any mixture of tunables and booleans in discard_tunables().

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsemanage/include/semanage/handle.h |    6 +++++
 libsemanage/src/direct_api.c          |   36 ++++++++++++++++++++++++++++++++-
 libsemanage/src/handle.c              |   13 +++++++++++
 libsemanage/src/libsemanage.map       |    1 +
 libsemanage/src/semanage_store.c      |    1 +
 libsemanage/src/semanage_store.h      |    1 +
 libsepol/include/sepol/handle.h       |    7 ++++++
 libsepol/src/expand.c                 |   36 ++++++++++++++++++++++-----------
 libsepol/src/handle.c                 |   15 +++++++++++++
 libsepol/src/handle.h                 |    2 +-
 libsepol/src/libsepol.map             |    1 +
 policycoreutils/semodule/semodule.c   |   10 ++++++++-
 12 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index e303713..c746930 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -129,6 +129,12 @@ int semanage_mls_enabled(semanage_handle_t *sh);
 /* Change to alternate selinux root path */
 int semanage_set_root(const char *path);
 
+/* Get whether or not needless unused branch of tunables would be preserved */
+int semanage_get_preserve_tunables(semanage_handle_t * handle);
+
+/* Set whether or not to preserve the needless unused branch of tunables */
+void semanage_set_preserve_tunables(semanage_handle_t * handle, int preserve_tunables);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index aac1974..481d8e6 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -236,6 +236,13 @@ int semanage_direct_connect(semanage_handle_t * sh)
 	else
 		sepol_set_disable_dontaudit(sh->sepolh, 0);
 
+	/* set the preserve tunables value */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_PRESERVE_TUNABLES);
+	if (access(path, F_OK) == 0)
+		sepol_set_preserve_tunables(sh->sepolh, 1);
+	else
+		sepol_set_preserve_tunables(sh->sepolh, 0);
+
 	return STATUS_SUCCESS;
 
       err:
@@ -695,7 +702,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
-	    seusers_modified, users_extra_modified, dontaudit_modified;
+	    seusers_modified, users_extra_modified, dontaudit_modified,
+	    preserve_tunables_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -737,6 +745,31 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		}
 	}
 
+	/* Create or remove the preserve_tunables flag file. */
+	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
+	if (access(path, F_OK) == 0)
+		preserve_tunables_modified = !(sepol_get_preserve_tunables(sh->sepolh) == 1);
+	else
+		preserve_tunables_modified = (sepol_get_preserve_tunables(sh->sepolh) == 1);
+	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
+		FILE *touch;
+		touch = fopen(path, "w");
+		if (touch != NULL) {
+			if (fclose(touch) != 0) {
+				ERR(sh, "Error attempting to create preserve_tunable flag.");
+				goto cleanup;
+			}
+		} else {
+			ERR(sh, "Error attempting to create preserve_tunable flag.");
+			goto cleanup;
+		}
+	} else {
+		if (remove(path) == -1 && errno != ENOENT) {
+			ERR(sh, "Error removing the preserve_tunables flag.");
+			goto cleanup;
+		}
+	}
+
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
 	if (users->dtable->is_modified(users->dbase)) {
@@ -759,6 +792,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
 	modified |= dontaudit_modified;
+	modified |= preserve_tunables_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 647f0ee..7adc1cc 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -261,6 +261,19 @@ void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudi
 	return;
 }
 
+int semanage_get_preserve_tunables(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+	return sepol_get_preserve_tunables(sh->sepolh);
+}
+
+void semanage_set_preserve_tunables(semanage_handle_t * sh,
+				    int preserve_tunables)
+{
+	assert(sh != NULL);
+	sepol_set_preserve_tunables(sh->sepolh, preserve_tunables);
+}
+
 void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
 {
 
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 3222e3d..2827abe 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -22,5 +22,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
 	  semanage_set_check_contexts;
+	  semanage_get_preserve_tunables; semanage_set_preserve_tunables;
   local: *;
 };
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 8d6ff1c..e5f8234 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -117,6 +117,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
 	"/disable_dontaudit",
+	"/preserve_tunables",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index a0b2dd8..eaae05e 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -59,6 +59,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
 	SEMANAGE_DISABLE_DONTAUDIT,
+	SEMANAGE_PRESERVE_TUNABLES,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
diff --git a/libsepol/include/sepol/handle.h b/libsepol/include/sepol/handle.h
index 19be326..115bda1 100644
--- a/libsepol/include/sepol/handle.h
+++ b/libsepol/include/sepol/handle.h
@@ -24,4 +24,11 @@ void sepol_set_expand_consume_base(sepol_handle_t * sh, int consume_base);
 /* Destroy a sepol handle. */
 void sepol_handle_destroy(sepol_handle_t *);
 
+/* Get whether or not needless unused branch of tunables would be preserved */
+int sepol_get_preserve_tunables(sepol_handle_t * sh);
+
+/* Set whether or not to preserve the needless unused branch of tunables,
+ * 0 is default and discard such branch, 1 preserves them */
+void sepol_set_preserve_tunables(sepol_handle_t * sh, int preserve_tunables);
+
 #endif
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index d5f10a6..d67b84c 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2678,25 +2678,29 @@ int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
 	return copy_and_expand_avrule_block(&state);
 }
 
-static void discard_tunables(policydb_t *pol)
+static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 {
 	avrule_block_t *block;
 	avrule_decl_t *decl;
 	cond_node_t *cur_node;
 	cond_expr_t *cur_expr;
-	int cur_state;
+	int cur_state, preserve_tunables = 0;
 	avrule_t *tail, *to_be_appended;
 
+	if (sh && sh->preserve_tunables)
+		preserve_tunables = 1;
+
 	/* Iterate through all cond_node of all enabled decls, if a cond_node
-	 * is about tunable, caculate its state value and concatenate one of
-	 * its avrule list to the current decl->avrules list.
+	 * is about tunable, calculate its state value and concatenate one of
+	 * its avrule list to the current decl->avrules list. On the other
+	 * hand, the disabled unused branch of a tunable would be discarded.
 	 *
 	 * Note, such tunable cond_node would be skipped over in expansion,
 	 * so we won't have to worry about removing it from decl->cond_list
 	 * here :-)
 	 *
-	 * If tunables and booleans co-exist in the expression of a cond_node,
-	 * then tunables would be "transformed" as booleans.
+	 * If tunables are requested to be preserved then they would be
+	 * "transformed" as booleans by having their TUNABLE flag cleared.
 	 */
 	for (block = pol->global; block != NULL; block = block->next) {
 		decl = block->enabled;
@@ -2709,10 +2713,12 @@ static void discard_tunables(policydb_t *pol)
 
 		for (cur_node = decl->cond_list; cur_node != NULL;
 		     cur_node = cur_node->next) {
-			int booleans, tunables;
+			int booleans, tunables, i;
 			cond_bool_datum_t *booldatum;
+			cond_bool_datum_t *tmp[COND_EXPR_MAXDEPTH];
 
 			booleans = tunables = 0;
+			memset(tmp, 0, sizeof(cond_bool_datum_t *) * COND_EXPR_MAXDEPTH);
 
 			for (cur_expr = cur_node->expr; cur_expr != NULL;
 			     cur_expr = cur_expr->next) {
@@ -2720,18 +2726,24 @@ static void discard_tunables(policydb_t *pol)
 					continue;
 				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
 				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
-					tunables++;
+					tmp[tunables++] = booldatum;
 				else
 					booleans++;
 			}
 
 			/* bool_copy_callback() at link phase has ensured
 			 * that no mixture of tunables and booleans in one
-			 * expression. */
-			assert(!(booleans && tunables));
+			 * expression. However, this would be broken by the
+			 * request to preserve tunables */
+			if (!preserve_tunables)
+				assert(!(booleans && tunables));
 
-			if (booleans) {
+			if (booleans || preserve_tunables) {
 				cur_node->flags &= ~COND_NODE_FLAGS_TUNABLE;
+				if (tunables) {
+					for (i = 0; i < tunables; i++)
+						tmp[i]->flags &= ~COND_BOOL_FLAGS_TUNABLE;
+				}
 			} else {
 				cur_node->flags |= COND_NODE_FLAGS_TUNABLE;
 				cur_state = cond_evaluate_expr(pol, cur_node->expr);
@@ -2787,7 +2799,7 @@ int expand_module(sepol_handle_t * handle,
 	 * Originally this function is called at the very end of link phase,
 	 * however, we need to keep the linked policy intact for analysis
 	 * purpose. */
-	discard_tunables(base);
+	discard_tunables(handle, base);
 
 	expand_state_init(&state);
 
diff --git a/libsepol/src/handle.c b/libsepol/src/handle.c
index 191ac57..2e9a4ad 100644
--- a/libsepol/src/handle.c
+++ b/libsepol/src/handle.c
@@ -18,9 +18,24 @@ sepol_handle_t *sepol_handle_create(void)
 	sh->disable_dontaudit = 0;
 	sh->expand_consume_base = 0;
 
+	/* by default needless unused branch of tunables would be discarded  */
+	sh->preserve_tunables = 0;
+
 	return sh;
 }
 
+int sepol_get_preserve_tunables(sepol_handle_t *sh)
+{
+	assert(sh != NULL);
+	return sh->preserve_tunables;
+}
+
+void sepol_set_preserve_tunables(sepol_handle_t * sh, int preserve_tunables)
+{
+	assert(sh !=NULL);
+	sh->preserve_tunables = preserve_tunables;
+}
+
 int sepol_get_disable_dontaudit(sepol_handle_t *sh)
 {
 	assert(sh !=NULL);
diff --git a/libsepol/src/handle.h b/libsepol/src/handle.h
index 254fbd8..7728d04 100644
--- a/libsepol/src/handle.h
+++ b/libsepol/src/handle.h
@@ -17,7 +17,7 @@ struct sepol_handle {
 
 	int disable_dontaudit;
 	int expand_consume_base;
-
+	int preserve_tunables;
 };
 
 #endif
diff --git a/libsepol/src/libsepol.map b/libsepol/src/libsepol.map
index 719e5b7..81e0d48 100644
--- a/libsepol/src/libsepol.map
+++ b/libsepol/src/libsepol.map
@@ -15,5 +15,6 @@
 	sepol_get_disable_dontaudit;
 	sepol_set_disable_dontaudit;
 	sepol_set_expand_consume_base;
+	sepol_get_preserve_tunables; sepol_set_preserve_tunables;
   local: *;
 };
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 81d6a3c..5d662e7 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -45,6 +45,7 @@ static int no_reload;
 static int create_store;
 static int build;
 static int disable_dontaudit;
+static int preserve_tunables;
 
 static semanage_handle_t *sh = NULL;
 static char *store;
@@ -117,6 +118,7 @@ static void usage(char *progname)
 	printf("  -h,--help        print this message and quit\n");
 	printf("  -v,--verbose     be verbose\n");
 	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
+	printf("  -P,--preserve_tunables	Preserve tunables in policy\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -162,6 +164,7 @@ static void parse_command_line(int argc, char **argv)
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
 		{"disable_dontaudit", 0, NULL, 'D'},
+		{"preserve_tunables", 0, NULL, 'P'},
 		{"path", required_argument, NULL, 'p'},
 		{NULL, 0, NULL, 0}
 	};
@@ -171,7 +174,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	create_store = 0;
 	while ((i =
-		getopt_long(argc, argv, "p:s:b:hi:lvqe:d:r:u:RnBD", opts,
+		getopt_long(argc, argv, "p:s:b:hi:lvqe:d:r:u:RnBDP", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -220,6 +223,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'D':
 			disable_dontaudit = 1;
 			break;
+		case 'P':
+			preserve_tunables = 1;
+			break;
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -466,6 +472,8 @@ int main(int argc, char *argv[])
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
 			semanage_set_disable_dontaudit(sh, 0);
+		if (preserve_tunables)
+			semanage_set_preserve_tunables(sh, 1);
 
 		result = semanage_commit(sh);
 	}
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
