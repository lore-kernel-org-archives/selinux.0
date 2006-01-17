Message-ID: <43CD3437.1010105@cornell.edu>
Date: Tue, 17 Jan 2006 11:15:19 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Remove apply_local function
Content-Type: multipart/mixed;
 boundary="------------030001060609060407020309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030001060609060407020309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Originally I put the components code into the apply_local function 
(which was part of expand_sandbox). The point was to write more 
self-contained code, and stay away from the modules. However, now this 
function is doing more harm than good - it has nothing to do with the 
semanage store (despite being in semanage_store.c), and contains code 
that I really need in different order/placement in the commit function, 
which already deals with non-module things anyway.

So, remove apply_local, and add it back to the commit function with some 
more comments. We can break down commit into different sub-functions 
again if necessary, but in a way that makes more sense.

---
This puts seuser validation back into the attach-detach bracket, which 
saves us a policy reload, since the policydb remains cached.


--------------030001060609060407020309
Content-Type: text/x-patch;
 name="libsemanage.remove_apply_local.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.remove_apply_local.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-17 09:11:06.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-17 11:02:45.000000000 -0700
@@ -44,6 +44,7 @@
 #include "modules.h"
 #include "direct_api.h"
 #include "semanage_store.h"
+#include "database_policydb.h"
 #include "policy.h"
 
 static void semanage_direct_destroy(semanage_handle_t *sh);
@@ -386,13 +387,19 @@ static int semanage_direct_commit(semana
 	int modified, fcontexts_modified, ports_modified, 
 		seusers_modified, users_extra_modified;
 	dbase_config_t* users = semanage_user_dbase_local(sh);
-        dbase_config_t* users_base = semanage_user_base_dbase_local(sh);
-        dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
-        dbase_config_t* ports = semanage_port_dbase_local(sh);
-        dbase_config_t* bools = semanage_bool_dbase_local(sh);
-        dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
-        dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
-        dbase_config_t* seusers = semanage_seuser_dbase(sh);
+	dbase_config_t* users_base = semanage_user_base_dbase_local(sh);
+	dbase_config_t* pusers_base = semanage_user_base_dbase_policy(sh);
+	dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
+	dbase_config_t* pusers_extra = semanage_user_extra_dbase_policy(sh);
+	dbase_config_t* ports = semanage_port_dbase_local(sh);
+	dbase_config_t* pports = semanage_port_dbase_policy(sh);
+	dbase_config_t* bools = semanage_bool_dbase_local(sh);
+	dbase_config_t* pbools = semanage_bool_dbase_policy(sh);
+	dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
+	dbase_config_t* pifaces = semanage_iface_dbase_policy(sh);
+	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
+	dbase_config_t* pfcontexts = semanage_fcontext_dbase_policy(sh);
+	dbase_config_t* seusers = semanage_seuser_dbase(sh);
 
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
@@ -422,6 +429,8 @@ static int semanage_direct_commit(semana
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
 
+		/* =================== Module expansion =============== */
+
 		/* link all modules in the sandbox to the base module */
 		if (semanage_get_modules_names(sh, &mod_filenames, &num_modfiles) != 0 ||
 		    semanage_verify_modules(sh, mod_filenames, num_modfiles) == -1 ||
@@ -436,28 +445,46 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 		}
 
+		/* ==================== File contexts ================== */
+
 		/* write the linked file contexts template */
 		if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
 		    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), 
 				sepol_module_package_get_file_contexts_len(base)) == -1) {
 			goto cleanup;
 		}
-	
-		if (semanage_split_fc(sh)) {
+
+		/* Create file_contexts(.homedirs) and drop any previous cache */
+		if (semanage_split_fc(sh)) 
+			goto cleanup;
+		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
+
+		/* ==================== Users extra data =============== */
+
+		/* Clear any users_extra cache completely */
+		if (pusers_extra->dtable->clear(sh, pusers_extra->dbase) < 0)
 			goto cleanup;
-		}
 
-		/* Expand the resulting policy, apply local changes, and write it out  */
+		/* ==================== Policydb-backed ================ */
+
+		/* Create new policy object, then attach to policy databases
+		 * that work with a policydb */
 		if (semanage_expand_sandbox(sh, base, &out) < 0)
 			goto cleanup;
 
-		if (semanage_apply_local_changes(sh, out) < 0)
+		dbase_policydb_attach((dbase_policydb_t*) pusers_base->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t*) pports->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t*) pifaces->dbase, out);
+		dbase_policydb_attach((dbase_policydb_t*) pbools->dbase, out);
+
+		/* ============= Apply changes, and verify  =============== */
+
+		if (semanage_base_merge_components(sh) < 0)
 			goto cleanup;
 
 		if (semanage_write_policydb(sh, out) < 0)
 			goto cleanup;
 
-		/* Verify policy */
 		if (semanage_verify_kernel(sh) != 0)
 			goto cleanup;
 	}
@@ -465,6 +492,8 @@ static int semanage_direct_commit(semana
 	/* FIXME: else if !modified, but seusers_modified, 
 	 * load the existing policy instead of rebuilding */
 
+	/* ======= Post-process: Validate non-policydb components ===== */
+
 	/* Validate local modifications to file contexts.
 	 * Note: those are still cached, even though they've been 
 	 * merged into the main file_contexts. We won't check the 
@@ -488,6 +517,8 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 	}
 
+	/* ================== Write non-policydb components ========= */
+
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
@@ -498,6 +529,13 @@ static int semanage_direct_commit(semana
 	for (i = 0; mod_filenames != NULL && i < num_modfiles; i++) {
 		free(mod_filenames[i]);
 	}
+
+	/* Detach out, so it can be freed */
+	dbase_policydb_detach((dbase_policydb_t*) pusers_base->dbase);
+	dbase_policydb_detach((dbase_policydb_t*) pports->dbase);
+	dbase_policydb_detach((dbase_policydb_t*) pifaces->dbase);
+	dbase_policydb_detach((dbase_policydb_t*) pbools->dbase);
+
 	free(mod_filenames);
 	sepol_module_package_free(base);
 	sepol_policydb_free(out);
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-17 11:06:10.000000000 -0700
@@ -307,7 +307,7 @@ class Tests:
 		if exists: 
 			(status, old_user) = semanage.semanage_user_query_local(sh, key)
 			if self.verbose: print "Query status (commit number): ", status
-	
+
 		print "Starting transaction..."
                 status = semanage.semanage_begin_transaction(sh)
                 status = semanage.semanage_user_modify_local(sh,key,user)
@@ -325,7 +325,7 @@ class Tests:
 			if self.verbose: print "User modify: ", status
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
-			
+
 	def test_writeseuser(self,sh):
                 print "Testing seuser write..."
                 
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/semanage_store.c	2006-01-17 11:08:55.000000000 -0700
@@ -32,7 +32,6 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 #include "database_policydb.h"
 #include "handle.h"
-#include "policy.h"
 
 #include <selinux/selinux.h>
 #include <sepol/policydb.h>
@@ -1384,44 +1383,6 @@ int semanage_expand_sandbox(
 	return STATUS_ERR;
 }
 
-/** 
- * Applies local changes to the policy
- */
-int semanage_apply_local_changes(
-	semanage_handle_t *sh,
-	sepol_policydb_t* out) {
-
-	int retval = STATUS_ERR;
-
-	/* Drop any file_context policy cache (from reads), since it 
-	 * was probably changed during expansion */
-	dbase_table_t* fcdtable = semanage_fcontext_dbase_policy(sh)->dtable;
-	dbase_t* fcdbase = semanage_fcontext_dbase_policy(sh)->dbase;
-	fcdtable->drop_cache(fcdbase);
-
-	/* Clear the users_extra dbase completely */
-	dbase_table_t* uedtable = semanage_user_extra_dbase_policy(sh)->dtable;
-	dbase_t* uedbase = semanage_user_extra_dbase_policy(sh)->dbase;
-	if (uedtable->clear(sh, uedbase) < 0)
-		goto exit;	
-
-	/* Similarly, attaching the policydb will erase any existing cache */	
-	dbase_policydb_attach(semanage_user_base_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(semanage_port_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(semanage_iface_dbase_policy(sh)->dbase, out);
-	dbase_policydb_attach(semanage_bool_dbase_policy(sh)->dbase, out);
-
-	retval = semanage_base_merge_components(sh);
-
-	dbase_policydb_detach(semanage_user_base_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(semanage_port_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
-        dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
-
-	exit:
-	return retval;
-}
-
 /**
  * Writes the final policy to the sandbox (kernel)
  */
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/semanage_store.h	2006-01-17 10:05:50.000000000 -0700
@@ -85,10 +85,6 @@ int semanage_expand_sandbox(
 	sepol_module_package_t *base,
 	sepol_policydb_t** policydb);
 
-int semanage_apply_local_changes(
-	semanage_handle_t *sh,
-	sepol_policydb_t* policydb);
-
 int semanage_write_policydb(
 	semanage_handle_t *sh,
 	sepol_policydb_t* policydb);

--------------030001060609060407020309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
