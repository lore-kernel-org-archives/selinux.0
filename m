From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: cefrodrigues@gmail.com, jwcart2@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libsemanage: Save linked policy, skip re-link when possible
Date: Tue, 11 Apr 2017 14:15:06 -0400
Message-Id: <20170411181506.22427-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In commit b61922f727d5643265e27654a2d626bcae5d894c ("libsemanage: revert
"Skip policy module re-link when only setting booleans"), we reverted
an optimization for setting booleans since it produced incorrect behavior.
This incorrect behavior was due to operating on the policy with local
changes already merged. However, reverting this change leaves us with
undesirable overhead for setsebool -P.  We also have long wanted
to support the same optimization for making other changes that do
not truly require module re-compilation/re-linking.

If we save the linked policy prior to merging local changes, we
can skip re-linking the policy modules in most cases, thereby
significantly improvement the performance and memory overhead of
semanage and setsebool -P commands.  Save the linked policy in the
policy sandbox and use it when we are not making a change that requires
recompilation of the CIL modules.  With this change, a re-link
is not performed when setting booleans or when adding, deleting, or
modifying port, node, interface, user, login (seusers) or fcontext
mappings.  We save linked versions of the kernel policy, seusers,
and users_extra produced from the CIL modules before any local
changes are merged.  This has an associated storage cost, primarily
storing an extra copy of the kernel policy file.

Before:
$ time setsebool -P zebra_write_config=1
real	0m8.714s
user	0m7.937s
sys	0m0.748s

After:
$ time setsebool -P zebra_write_config=1
real	0m1.070s
user	0m0.343s
sys	0m0.703s

Resolves: https://github.com/SELinuxProject/selinux/issues/50
Reported-by: Carlos Rodrigues <cefrodrigues@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 removes an unused local variable declaration that triggers
a build warning.

 libsemanage/src/direct_api.c     | 261 +++++++++++++++++++++++++++------------
 libsemanage/src/semanage_store.c |  18 +--
 libsemanage/src/semanage_store.h |   8 +-
 3 files changed, 197 insertions(+), 90 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index ee2f9e7..59cfec1 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -617,13 +617,33 @@ static int semanage_direct_update_user_extra(semanage_handle_t * sh, cil_db_t *c
 	}
 
 	if (size > 0) {
+		/*
+		 * Write the users_extra entries from CIL modules.
+		 * This file is used as our baseline when we do not require
+		 * re-linking.
+		 */
+		ofilename = semanage_path(SEMANAGE_TMP,
+					  SEMANAGE_USERS_EXTRA_LINKED);
+		if (ofilename == NULL) {
+			retval = -1;
+			goto cleanup;
+		}
+		retval = write_file(sh, ofilename, data, size);
+		if (retval < 0)
+			goto cleanup;
+
+		/*
+		 * Write the users_extra file; users_extra.local
+		 * will be merged into this file.
+		 */
 		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA);
 		if (ofilename == NULL) {
-			return retval;
+			retval = -1;
+			goto cleanup;
 		}
 		retval = write_file(sh, ofilename, data, size);
 		if (retval < 0)
-			return retval;
+			goto cleanup;
 
 		pusers_extra->dtable->drop_cache(pusers_extra->dbase);
 		
@@ -652,11 +672,33 @@ static int semanage_direct_update_seuser(semanage_handle_t * sh, cil_db_t *cildb
 	}
 
 	if (size > 0) {
+		/*
+		 * Write the seusers entries from CIL modules.
+		 * This file is used as our baseline when we do not require
+		 * re-linking.
+		 */
+		ofilename = semanage_path(SEMANAGE_TMP,
+					  SEMANAGE_SEUSERS_LINKED);
+		if (ofilename == NULL) {
+			retval = -1;
+			goto cleanup;
+		}
+		retval = write_file(sh, ofilename, data, size);
+		if (retval < 0)
+			goto cleanup;
+
+		/*
+		 * Write the seusers file; seusers.local will be merged into
+		 * this file.
+		 */
 		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
 		if (ofilename == NULL) {
-			return -1;
+			retval = -1;
+			goto cleanup;
 		}
 		retval = write_file(sh, ofilename, data, size);
+		if (retval < 0)
+			goto cleanup;
 
 		pseusers->dtable->drop_cache(pseusers->dbase);
 	} else {
@@ -1095,20 +1137,18 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	size_t fc_buffer_len = 0;
 	const char *ofilename = NULL;
 	const char *path;
-	int retval = -1, num_modinfos = 0, i, missing_policy_kern = 0,
-		missing_seusers = 0, missing_fc = 0, missing = 0;
+	int retval = -1, num_modinfos = 0, i;
 	sepol_policydb_t *out = NULL;
 	struct cil_db *cildb = NULL;
 	semanage_module_info_t *modinfos = NULL;
 
-	/* Declare some variables */
-	int modified = 0, fcontexts_modified, ports_modified,
-	    seusers_modified, users_extra_modified, dontaudit_modified,
-	    preserve_tunables_modified, disable_dontaudit, preserve_tunables;
+	int do_rebuild, do_write_kernel, do_install;
+	int fcontexts_modified, ports_modified, seusers_modified,
+		disable_dontaudit, preserve_tunables;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
-	dbase_config_t *users_extra = semanage_user_extra_dbase_local(sh);
+	dbase_config_t *pusers_extra = semanage_user_extra_dbase_policy(sh);
 	dbase_config_t *ports = semanage_port_dbase_local(sh);
 	dbase_config_t *pports = semanage_port_dbase_policy(sh);
 	dbase_config_t *bools = semanage_bool_dbase_local(sh);
@@ -1120,13 +1160,22 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	dbase_config_t *fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
 	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
+	dbase_config_t *pseusers = semanage_seuser_dbase_policy(sh);
+
+	/* Modified flags that we need to use more than once. */
+	ports_modified = ports->dtable->is_modified(ports->dbase);
+	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
+	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
+
+	/* Rebuild if explicitly requested or any module changes occurred. */
+	do_rebuild = sh->do_rebuild | sh->modules_modified;
 
 	/* Create or remove the disable_dontaudit flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
 	if (access(path, F_OK) == 0)
-		dontaudit_modified = !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
+		do_rebuild |= !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
 	else
-		dontaudit_modified = (sepol_get_disable_dontaudit(sh->sepolh) == 1);
+		do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
 	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
 		FILE *touch;
 		touch = fopen(path, "w");
@@ -1149,9 +1198,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Create or remove the preserve_tunables flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
 	if (access(path, F_OK) == 0)
-		preserve_tunables_modified = !(sepol_get_preserve_tunables(sh->sepolh) == 1);
+		do_rebuild |= !(sepol_get_preserve_tunables(sh->sepolh) == 1);
 	else
-		preserve_tunables_modified = (sepol_get_preserve_tunables(sh->sepolh) == 1);
+		do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
 	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
 		FILE *touch;
 		touch = fopen(path, "w");
@@ -1179,54 +1228,75 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			goto cleanup;
 	}
 
-	/* Decide if anything was modified */
-	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
-	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
-	users_extra_modified =
-	    users_extra->dtable->is_modified(users_extra->dbase);
-	ports_modified = ports->dtable->is_modified(ports->dbase);
-
-	modified = sh->modules_modified;
-	modified |= seusers_modified;
-	modified |= users_extra_modified;
-	modified |= ports_modified;
-	modified |= users->dtable->is_modified(users_base->dbase);
-	modified |= bools->dtable->is_modified(bools->dbase);
-	modified |= ifaces->dtable->is_modified(ifaces->dbase);
-	modified |= nodes->dtable->is_modified(nodes->dbase);
-	modified |= dontaudit_modified;
-	modified |= preserve_tunables_modified;
-
-	/* This is for systems that have already migrated with an older version
-	 * of semanage_migrate_store. The older version did not copy policy.kern so
-	 * the policy binary must be rebuilt here.
+	/*
+	 * This is for systems that have already migrated with an older version
+	 * of semanage_migrate_store. The older version did not copy
+	 * policy.kern so the policy binary must be rebuilt here.
+	 * This also ensures that any linked files that are required
+	 * in order to skip re-linking are present; otherwise, we force
+	 * a rebuild.
 	 */
-	if (!sh->do_rebuild && !modified) {
+	if (!do_rebuild) {
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
-
 		if (access(path, F_OK) != 0) {
-			missing_policy_kern = 1;
+			do_rebuild = 1;
+			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
-
 		if (access(path, F_OK) != 0) {
-			missing_fc = 1;
+			do_rebuild = 1;
+			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
+		if (access(path, F_OK) != 0) {
+			do_rebuild = 1;
+			goto rebuild;
+		}
 
+		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
 		if (access(path, F_OK) != 0) {
-			missing_seusers = 1;
+			do_rebuild = 1;
+			goto rebuild;
+		}
+
+		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
+		if (access(path, F_OK) != 0) {
+			do_rebuild = 1;
+			goto rebuild;
 		}
-	}
 
-	missing |= missing_policy_kern;
-	missing |= missing_fc;
-	missing |= missing_seusers;
+		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
+		if (access(path, F_OK) != 0) {
+			do_rebuild = 1;
+			goto rebuild;
+		}
+	}
 
-	/* If there were policy changes, or explicitly requested, rebuild the policy */
-	if (sh->do_rebuild || modified || missing) {
+rebuild:
+	/*
+	 * Now that we know whether or not a rebuild is required,
+	 * we can determine what else needs to be done.
+	 * We need to write the kernel policy if we are rebuilding
+	 * or if any other policy component that lives in the kernel
+	 * policy has been modified.
+	 * We need to install the policy files if any of the managed files
+	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
+	 * will be modified.
+	 */
+	do_write_kernel = do_rebuild | ports_modified |
+		bools->dtable->is_modified(bools->dbase) |
+		ifaces->dtable->is_modified(ifaces->dbase) |
+		nodes->dtable->is_modified(nodes->dbase) |
+		users->dtable->is_modified(users_base->dbase);
+	do_install = do_write_kernel | seusers_modified | fcontexts_modified;
+
+	/*
+	 * If there were policy changes, or explicitly requested, or
+	 * any required files are missing, rebuild the policy.
+	 */
+	if (do_rebuild) {
 		/* =================== Module expansion =============== */
 
 		retval = semanage_get_active_modules(sh, &modinfos, &num_modinfos);
@@ -1316,37 +1386,69 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 		cil_db_destroy(&cildb);
 
-		/* Attach to policy databases that work with a policydb. */
-		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
-
-		/* ============= Apply changes, and verify  =============== */
-
-		retval = semanage_base_merge_components(sh);
+		/* Write the linked policy before merging local changes. */
+		retval = semanage_write_policydb(sh, out,
+						 SEMANAGE_LINKED);
 		if (retval < 0)
 			goto cleanup;
-
-		retval = semanage_write_policydb(sh, out);
+	} else {
+		/* Load the existing linked policy, w/o local changes */
+		retval = sepol_policydb_create(&out);
 		if (retval < 0)
 			goto cleanup;
 
-		retval = semanage_verify_kernel(sh);
-		if (retval < 0)
-			goto cleanup;
-	} else {
-		/* Load already linked policy */
-		retval = sepol_policydb_create(&out);
+		retval = semanage_read_policydb(sh, out, SEMANAGE_LINKED);
 		if (retval < 0)
 			goto cleanup;
 
-		retval = semanage_read_policydb(sh, out);
+		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
+		if (access(path, F_OK) == 0) {
+			retval = semanage_copy_file(path,
+						    semanage_path(SEMANAGE_TMP,
+								  SEMANAGE_STORE_SEUSERS),
+						    sh->conf->file_mode);
+			if (retval < 0)
+				goto cleanup;
+			pseusers->dtable->drop_cache(pseusers->dbase);
+		} else {
+			pseusers->dtable->clear(sh, pseusers->dbase);
+		}
+
+		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
+		if (access(path, F_OK) == 0) {
+			retval = semanage_copy_file(path,
+						    semanage_path(SEMANAGE_TMP,
+								  SEMANAGE_USERS_EXTRA),
+						    sh->conf->file_mode);
+			if (retval < 0)
+				goto cleanup;
+			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
+		} else {
+			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+		}
+	}
+
+	/* Attach our databases to the policydb we just created or loaded. */
+	dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
+
+	/* Merge local changes */
+	retval = semanage_base_merge_components(sh);
+	if (retval < 0)
+		goto cleanup;
+
+	if (do_write_kernel) {
+		/* Write new kernel policy. */
+		retval = semanage_write_policydb(sh, out,
+						 SEMANAGE_STORE_KERNEL);
 		if (retval < 0)
 			goto cleanup;
 
-		retval = semanage_base_merge_components(sh);
+		/* Run the kernel policy verifier, if any. */
+		retval = semanage_verify_kernel(sh);
 		if (retval < 0)
 			goto cleanup;
 	}
@@ -1357,21 +1459,21 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * Note: those are still cached, even though they've been 
 	 * merged into the main file_contexts. We won't check the 
 	 * large file_contexts - checked at compile time */
-	if (sh->do_rebuild || modified || fcontexts_modified) {
+	if (do_rebuild || fcontexts_modified) {
 		retval = semanage_fcontext_validate_local(sh, out);
 		if (retval < 0)
 			goto cleanup;
 	}
 
 	/* Validate local seusers against policy */
-	if (sh->do_rebuild || modified || seusers_modified) {
+	if (do_rebuild || seusers_modified) {
 		retval = semanage_seuser_validate_local(sh, out);
 		if (retval < 0)
 			goto cleanup;
 	}
 
 	/* Validate local ports for overlap */
-	if (sh->do_rebuild || modified || ports_modified) {
+	if (do_rebuild || ports_modified) {
 		retval = semanage_port_validate_local(sh);
 		if (retval < 0)
 			goto cleanup;
@@ -1440,9 +1542,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	sepol_policydb_free(out);
 	out = NULL;
 
-	if (sh->do_rebuild || modified || fcontexts_modified) {
+	if (do_install)
 		retval = semanage_install_sandbox(sh);
-	}
 
 cleanup:
 	for (i = 0; i < num_modinfos; i++) {
@@ -1454,14 +1555,12 @@ cleanup:
 		free(mod_filenames[i]);
 	}
 
-	if (modified) {
-		/* Detach from policydb, so it can be freed */
-		dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
-		dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
-		dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
-		dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
-		dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
-	}
+	/* Detach from policydb, so it can be freed */
+	dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
 
 	free(mod_filenames);
 	sepol_policydb_free(out);
@@ -1977,7 +2076,7 @@ int semanage_direct_mls_enabled(semanage_handle_t * sh)
 	if (retval < 0)
 		goto cleanup;
 
-	retval = semanage_read_policydb(sh, p);
+	retval = semanage_read_policydb(sh, p, SEMANAGE_STORE_KERNEL);
 	if (retval < 0)
 		goto cleanup;
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index bf1a448..6b75002 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -95,7 +95,7 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
 static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"",
 	"/modules",
-	"/base.linked",
+	"/policy.linked",
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
@@ -104,8 +104,10 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/nodes.local",
 	"/booleans.local",
 	"/seusers.local",
+	"/seusers.linked",
 	"/users.local",
 	"/users_extra.local",
+	"/users_extra.linked",
 	"/users_extra",
 	"/disable_dontaudit",
 	"/preserve_tunables",
@@ -2042,9 +2044,10 @@ int semanage_load_files(semanage_handle_t * sh, cil_db_t *cildb, char **filename
  */
 
 /**
- * Read the policy from the sandbox (kernel)
+ * Read the policy from the sandbox (linked or kernel)
  */
-int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
+int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in,
+			   enum semanage_sandbox_defs file)
 {
 
 	int retval = STATUS_ERR;
@@ -2053,7 +2056,7 @@ int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
 	FILE *infile = NULL;
 
 	if ((kernel_filename =
-	     semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_KERNEL)) == NULL) {
+	     semanage_path(SEMANAGE_ACTIVE, file)) == NULL) {
 		goto cleanup;
 	}
 	if ((infile = fopen(kernel_filename, "r")) == NULL) {
@@ -2083,9 +2086,10 @@ int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
 	return retval;
 }
 /**
- * Writes the final policy to the sandbox (kernel)
+ * Writes the policy to the sandbox (linked or kernel)
  */
-int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
+int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
+			    enum semanage_sandbox_defs file)
 {
 
 	int retval = STATUS_ERR;
@@ -2094,7 +2098,7 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
 	FILE *outfile = NULL;
 
 	if ((kernel_filename =
-	     semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL)) == NULL) {
+	     semanage_path(SEMANAGE_TMP, file)) == NULL) {
 		goto cleanup;
 	}
 	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index c5b33c8..0b96fbe 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -49,8 +49,10 @@ enum semanage_sandbox_defs {
 	SEMANAGE_NODES_LOCAL,
 	SEMANAGE_BOOLEANS_LOCAL,
 	SEMANAGE_SEUSERS_LOCAL,
+	SEMANAGE_SEUSERS_LINKED,
 	SEMANAGE_USERS_BASE_LOCAL,
 	SEMANAGE_USERS_EXTRA_LOCAL,
+	SEMANAGE_USERS_EXTRA_LINKED,
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_PRESERVE_TUNABLES,
@@ -129,10 +131,12 @@ int semanage_load_files(semanage_handle_t * sh,
 			    cil_db_t *cildb, char **filenames, int num_modules);
 
 int semanage_read_policydb(semanage_handle_t * sh,
-			    sepol_policydb_t * policydb);
+			   sepol_policydb_t * policydb,
+			   enum semanage_sandbox_defs file);
 
 int semanage_write_policydb(semanage_handle_t * sh,
-			    sepol_policydb_t * policydb);
+			    sepol_policydb_t * policydb,
+			    enum semanage_sandbox_defs file);
 
 int semanage_install_sandbox(semanage_handle_t * sh);
 
-- 
2.9.3
