Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0O9h50i023584
 for <selinux@tycho.nsa.gov>; Wed, 24 Jan 2018 04:43:06 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Wed, 24 Jan 2018 09:42:54 +0000
Message-Id: <20180124094254.6171-1-richard_c_haines@btinternet.com>
Subject: [PATCH V3] libsemanage: Allow tmp files to be kept if a compile fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow the tmp build files to be kept for debugging when a policy
build fails.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes: 
Remove the retain-tmp flag and just keep tmp files on build errors.
V3 Changes:
Release transaction lock after tmp files removed.
Add additional comments to commit_err in handle.h

 libsemanage/src/direct_api.c | 56 ++++++++++++++++++++++++++++++--------------
 libsemanage/src/handle.c     |  2 ++
 libsemanage/src/handle.h     |  4 ++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a455612f..88873c43 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -323,25 +323,43 @@ static void semanage_direct_destroy(semanage_handle_t * sh
 	/* do nothing */
 }
 
-static int semanage_direct_disconnect(semanage_handle_t * sh)
+static int semanage_remove_tmps(semanage_handle_t *sh)
 {
-	/* destroy transaction */
-	if (sh->is_in_transaction) {
-		/* destroy sandbox */
-		if (semanage_remove_directory
-		    (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
+	if (sh->commit_err)
+		return 0;
+
+	/* destroy sandbox if it exists */
+	if (semanage_remove_directory
+	    (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
+		if (errno != ENOENT) {
 			ERR(sh, "Could not cleanly remove sandbox %s.",
 			    semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
 			return -1;
 		}
-		if (semanage_remove_directory
-		    (semanage_final_path(SEMANAGE_FINAL_TMP,
-					 SEMANAGE_FINAL_TOPLEVEL)) < 0) {
+	}
+
+	/* destroy tmp policy if it exists */
+	if (semanage_remove_directory
+	    (semanage_final_path(SEMANAGE_FINAL_TMP,
+				 SEMANAGE_FINAL_TOPLEVEL)) < 0) {
+		if (errno != ENOENT) {
 			ERR(sh, "Could not cleanly remove tmp %s.",
 			    semanage_final_path(SEMANAGE_FINAL_TMP,
 						SEMANAGE_FINAL_TOPLEVEL));
 			return -1;
 		}
+	}
+
+	return 0;
+}
+
+static int semanage_direct_disconnect(semanage_handle_t *sh)
+{
+	int retval = 0;
+
+	/* destroy transaction and remove tmp files if no commit error */
+	if (sh->is_in_transaction) {
+		retval = semanage_remove_tmps(sh);
 		semanage_release_trans_lock(sh);
 	}
 
@@ -375,7 +393,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 	/* Release object databases: active kernel policy */
 	bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
 
-	return 0;
+	return retval;
 }
 
 static int semanage_direct_begintrans(semanage_handle_t * sh)
@@ -1635,17 +1653,19 @@ cleanup:
 	free(mod_filenames);
 	sepol_policydb_free(out);
 	cil_db_destroy(&cildb);
-	semanage_release_trans_lock(sh);
 
 	free(fc_buffer);
 
-	/* regardless if the commit was successful or not, remove the
-	   sandbox if it is still there */
-	semanage_remove_directory(semanage_path
-				  (SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
-	semanage_remove_directory(semanage_final_path
-				  (SEMANAGE_FINAL_TMP,
-				   SEMANAGE_FINAL_TOPLEVEL));
+	/* Set commit_err so other functions can detect any errors. Note that
+	 * retval > 0 will be the commit number.
+	 */
+	if (retval < 0)
+		sh->commit_err = retval;
+
+	if (semanage_remove_tmps(sh) != 0)
+		retval = -1;
+
+	semanage_release_trans_lock(sh);
 	umask(mask);
 
 	return retval;
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 4ce1df03..a6567bd4 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -86,6 +86,8 @@ semanage_handle_t *semanage_handle_create(void)
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
 
+	sh->commit_err = 0;
+
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 1780ac81..a91907b0 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -62,6 +62,10 @@ struct semanage_handle {
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
+	int commit_err;		/* set by semanage_direct_commit() if there are
+				 * any errors when building or committing the
+				 * sandbox to kernel policy at /etc/selinux
+				 */
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
 				 * this will only have an effect on direct connections */
-- 
2.14.3
