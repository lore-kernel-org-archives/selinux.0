Message-ID: <43B7C440.3060205@cornell.edu>
Date: Sun, 01 Jan 2006 07:00:00 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Reorganize sandbox_expand
Content-Type: multipart/mixed;
 boundary="------------020000000505030105090902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020000000505030105090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Happy New Year to everybody...
My new year's resolution is to spent less time writing patches, and more 
time having fun..
Like all such resolutions, it's probably wishful thinking.

==========
This patch splits semanage_sandbox_install into 3 functions - one that 
expands, one that merges local stuff, and one that writes.

This is more flexible, because I can skip the parts I don't like. For 
example I can skip link/expand/write if modules_modified=0, and I just 
want to validate a seuser change (needs a few more changes to do that). 
I can keep the policydb around for a while if I want to - maybe for some 
kind of caching scheme w/ commit numbers. I can choose to grab a 
different policydb - maybe we have it cached, or maybe no modules were 
changed, and we can reuse an existing expanded policy. The point is - do 
one thing per function. The policydb is valuable and should not be 
discarded so easily.

By the way, I don't understand the separation between semanage_store.c 
and direct_api.c anymore.
Expanding things, applying local changes, and writing the policy don't 
seem related to the store IMHO - they work on things stored in the 
store... but so does all the rest of libsemanage. On the other hand, the 
name system (which I still don't use, because it's not flexible enough), 
and locking seem more related to the store.

--------------020000000505030105090902
Content-Type: text/x-patch;
 name="libsemanage13.reorganize_sandbox_expand.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage13.reorganize_sandbox_expand.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-01-01 06:07:12.000000000 -0500
@@ -333,6 +333,7 @@ static int semanage_direct_commit(semana
 	const char *linked_filename = NULL, *fc_filename = NULL;
 	sepol_module_package_t *base = NULL;
 	int retval = -1, num_modfiles = 0, i;
+	sepol_policydb_t* out = NULL;
 
 	/* Check if anything was changed */
 	int modified = sh->modules_modified;
@@ -376,8 +377,14 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 		}
 
-		/* Expand the resulting policy */
-		if (semanage_expand_sandbox(sh, base) < 0)
+		/* Expand the resulting policy, apply local changes, and write it out  */
+		if (semanage_expand_sandbox(sh, base, &out) < 0)
+			goto cleanup;
+
+		if (semanage_apply_local_changes(sh, out) < 0)
+			goto cleanup;
+		
+		if (semanage_write_policydb(sh, out) < 0)
 			goto cleanup;
 
 		/* Verify policy */
@@ -397,6 +404,7 @@ static int semanage_direct_commit(semana
 	}
 	free(mod_filenames);
 	sepol_module_package_free(base);
+	sepol_policydb_free(out);
 	semanage_release_trans_lock(sh);
 
 	/* regardless if the commit was successful or not, remove the
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-12-12 11:37:35.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-01-01 06:09:16.000000000 -0500
@@ -1353,33 +1353,49 @@ int semanage_link_sandbox(semanage_handl
 	return retval;
 }
 
-/* Expands the policy contained within *base and write the final
- * policy to the sandbox's kernel policy.  Returns 0 on success, -1 on
- * error.
+/* 
+ * Expands the policy contained within *base 
  */
-int semanage_expand_sandbox(semanage_handle_t *sh, sepol_module_package_t *base) {
-	struct sepol_policydb *out;
-	int retval = -1;
-	const char *kernel_filename = NULL;
-	struct sepol_policy_file *pf = NULL;
+int semanage_expand_sandbox(
+	semanage_handle_t *sh, 
+	sepol_module_package_t *base,
+	sepol_policydb_t** policydb) {
+
+	struct sepol_policydb *out = NULL;
 	int policyvers = sh->conf->policyvers;
 	int expand_check = sh->conf->expand_check ? sh->modules_modified : 0;
-	FILE *outfile = NULL;
 
-	if (sepol_policydb_create(&out)) {
-		return -1;
-	}
+	if (sepol_policydb_create(&out))
+		goto err;
+
 	if (sepol_expand_module(sh->sepolh, 
-				sepol_module_package_get_policy(base), out, 0, expand_check)
-				== -1) {
+			sepol_module_package_get_policy(base), out, 0, expand_check)
+			== -1) {
 		ERR(sh, "Expand module failed");
-		goto cleanup;
+		goto err;
 	}
 	if (sepol_policydb_set_vers(out, policyvers)) {
  		ERR(sh, "Unknown/Invalid policy version %d.", policyvers);
-		goto cleanup;
+		goto err;
 	}
 
+	*policydb = out;
+	return STATUS_SUCCESS;
+
+	err:
+	sepol_policydb_free(out);
+	return STATUS_ERR;
+}
+
+/** 
+ * Applies local changes to the policy
+ */
+int semanage_apply_local_changes(
+	semanage_handle_t *sh,
+	sepol_policydb_t* out) {
+
+	int retval;
+
 	dbase_policydb_attach(semanage_user_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(semanage_iface_dbase_policy(sh)->dbase, out);
@@ -1392,8 +1408,20 @@ int semanage_expand_sandbox(semanage_han
         dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
 
-	if (retval < 0) 
-		goto cleanup;
+	return retval;
+}
+
+/**
+ * Writes the final policy to the sandbox (kernel)
+ */
+int semanage_write_policydb(
+	semanage_handle_t *sh,
+	sepol_policydb_t* out) {
+
+	int retval = STATUS_ERR;
+	const char *kernel_filename = NULL;
+	struct sepol_policy_file *pf = NULL;
+	FILE *outfile = NULL;
 
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;
@@ -1412,13 +1440,12 @@ int semanage_expand_sandbox(semanage_han
  		ERR(sh, "Error while writing kernel policy to %s.", kernel_filename);
 		goto cleanup;
 	}
-	retval = 0;
+	retval = STATUS_SUCCESS;
 
  cleanup:
 	if (outfile != NULL) {
 		fclose(outfile);
 	}
-	sepol_policydb_free(out);
 	sepol_policy_file_free(pf);
 	return retval;
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/semanage_store.h	2006-01-01 06:02:41.000000000 -0500
@@ -61,8 +61,12 @@ int semanage_create_store(semanage_handl
 int semanage_remove_directory(const char *path);
 
 int semanage_make_sandbox(semanage_handle_t *sh);
-int semanage_get_modules_names(semanage_handle_t *sh,
-			       char ***filenames, int *len);
+
+int semanage_get_modules_names(
+	semanage_handle_t *sh,
+	char ***filenames, 
+	int *len);
+
 int semanage_install_sandbox(semanage_handle_t *sh);
 
 /* lock file routines */
@@ -72,13 +76,30 @@ void semanage_release_trans_lock(semanag
 void semanage_release_active_lock(semanage_handle_t *sh);
 int semanage_get_commit_number(semanage_handle_t *sh);
 
+int semanage_link_sandbox(
+	semanage_handle_t *sh, 
+	sepol_module_package_t **base);
+
+int semanage_expand_sandbox(
+	semanage_handle_t *sh, 
+	sepol_module_package_t *base,
+	sepol_policydb_t** policydb);
+
+int semanage_apply_local_changes(
+	semanage_handle_t *sh,
+	sepol_policydb_t* policydb);
+
+int semanage_write_policydb(
+	semanage_handle_t *sh,
+	sepol_policydb_t* policydb);
 
-int semanage_link_sandbox(semanage_handle_t *sh, sepol_module_package_t **base);
-int semanage_expand_sandbox(semanage_handle_t *sh, sepol_module_package_t *base);
 int semanage_install_sandbox(semanage_handle_t *sh);
 
-int semanage_verify_modules(semanage_handle_t *sh,
-			    char **module_filenames, int num_modules);
+int semanage_verify_modules(
+	semanage_handle_t *sh,
+	char **module_filenames, 
+	int num_modules);
+
 int semanage_verify_linked(semanage_handle_t *sh);
 int semanage_verify_kernel(semanage_handle_t *sh);
 int semanage_split_fc(semanage_handle_t *sh);

--------------020000000505030105090902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
