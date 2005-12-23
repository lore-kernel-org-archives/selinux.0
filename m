Message-ID: <43AC5726.8090102@cornell.edu>
Date: Fri, 23 Dec 2005 14:59:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Optional rebuild
Content-Type: multipart/mixed;
 boundary="------------040606010908090505030900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040606010908090505030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch uses the modified flags to skip a rebuild whenever possible.
It also adds the active boolean header to semanage.h (which I missed 
because of diff excludes).
It will now commit changes to the active booleans, so if no policy 
changes are done (modified = 0), or
changes are done, but preservebools is enabled (which it is, by 
default), then changes to active
booleans in the transaction will work as expected, and will not be 
overwritten by policy booleans.

This is also an optimization - allows running commit without rebuilding 
the policy, which could be beneficial for read-only operations using a 
transaction - it also seems more correct, because a read-only operation 
should not alter the state of the system - commit should not apply any 
changes that weren't explicit.

Note that semodule -B with no arguments will break, because now the 
build will be skipped. I haven't fixed it yet, but I've added an 
interface for that purpose - semanage_do_rebuild, to parallel 
semanage_do_reload (but the default in this new function is 0 - no 
rebuilds if no changes).



--------------040606010908090505030900
Content-Type: text/x-patch;
 name="libsemanage7.optional_rebuild.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage7.optional_rebuild.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/handle.h new/libsemanage/include/semanage/handle.h
--- old/libsemanage/include/semanage/handle.h	2005-11-08 14:48:37.000000000 -0500
+++ new/libsemanage/include/semanage/handle.h	2005-12-23 14:41:42.000000000 -0500
@@ -59,6 +59,11 @@ int semanage_reload_policy(semanage_hand
  * 1 for yes (default), 0 for no */
 void semanage_set_reload(semanage_handle_t *handle, int do_reload);
 
+/* set whether to rebuild the policy on commit, even if no
+ * changes were performed.
+ * 1 for yes, 0 for no (default) */
+void semanage_set_rebuild(semanage_handle_t *handle, int do_rebuild);
+
 /* Check whether policy is managed via libsemanage on this system.
  * Must be called prior to trying to connect.
  * Return 1 if policy is managed via libsemanage on this system,
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/semanage.h	2005-12-23 14:48:21.000000000 -0500
@@ -39,6 +39,7 @@
 /* Dbase */
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
+#include <semanage/booleans_active.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
 #include <semanage/seusers.h>
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-12-23 04:50:26.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-12-23 14:47:02.000000000 -0500
@@ -329,37 +329,56 @@ static int semanage_direct_commit(semana
 	sepol_module_package_t *base = NULL;
 	int retval = -1, num_modfiles = 0, i;
 
-	/* link all modules in the sandbox to the base module */
-	if (semanage_get_modules_names(sh, &mod_filenames, &num_modfiles) != 0 ||
-	    semanage_verify_modules(sh, mod_filenames, num_modfiles) == -1 ||
-	    semanage_link_sandbox(sh, &base) < 0) {
-		goto cleanup;
-	}
-
-	/* write the linked base */
-	if ((linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL ||
-	    semanage_write_module(sh, linked_filename, base) == -1 ||
-	    semanage_verify_linked(sh) != 0) {
-		goto cleanup;
-	}
+	/* Check if anything was changed */
+	int modified = sh->modules_modified;
+	dbase_config_t* pusers = semanage_user_dbase_local(sh);
+	dbase_config_t* pports = semanage_port_dbase_local(sh);
+	dbase_config_t* pbools = semanage_bool_dbase_local(sh);
+	dbase_config_t* pifaces = semanage_iface_dbase_local(sh);
+	dbase_config_t* seusers = semanage_seuser_dbase(sh);
+	modified |= pusers->dtable->is_modified(pusers->dbase);
+	modified |= pports->dtable->is_modified(pports->dbase);
+	modified |= pbools->dtable->is_modified(pbools->dbase);
+	modified |= pifaces->dtable->is_modified(pifaces->dbase);
+	/* FIXME: should not be necessary, just for validation */
+	modified |= seusers->dtable->is_modified(seusers->dbase);
+
+	/* If there were policy changes, or explicitly requested, rebuild the policy */
+	if (sh->do_rebuild || modified) {
+
+		/* link all modules in the sandbox to the base module */
+		if (semanage_get_modules_names(sh, &mod_filenames, &num_modfiles) != 0 ||
+		    semanage_verify_modules(sh, mod_filenames, num_modfiles) == -1 ||
+		    semanage_link_sandbox(sh, &base) < 0) {
+			goto cleanup;
+		}
+	
+		/* write the linked base */
+		if ((linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL ||
+		    semanage_write_module(sh, linked_filename, base) == -1 ||
+		    semanage_verify_linked(sh) != 0) {
+			goto cleanup;
+		}
 
-	/* write the linked file contexts template */
-	if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
-	    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), sepol_module_package_get_file_contexts_len(base)) == -1) {
-		goto cleanup;
-	}
+		/* write the linked file contexts template */
+		if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
+		    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), 
+				sepol_module_package_get_file_contexts_len(base)) == -1) {
+			goto cleanup;
+		}
 	
-	if (semanage_split_fc(sh)) {
-		goto cleanup;
-	}
+		if (semanage_split_fc(sh)) {
+			goto cleanup;
+		}
 
-	/* Expand the resulting policy */
-	if (semanage_expand_sandbox(sh, base) < 0)
-		goto cleanup;
+		/* Expand the resulting policy */
+		if (semanage_expand_sandbox(sh, base) < 0)
+			goto cleanup;
 
-	/* Verify policy */
-	if (semanage_verify_kernel(sh) != 0)
-		goto cleanup;
+		/* Verify policy */
+		if (semanage_verify_kernel(sh) != 0)
+			goto cleanup;
+	}
 
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-12-06 11:47:46.000000000 -0500
+++ new/libsemanage/src/handle.c	2005-12-23 14:40:28.000000000 -0500
@@ -57,6 +57,10 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/* By default do not rebuild the policy on commit
+	 * If any changes are made, this flag is ignored */
+	sh->do_rebuild = 0;
+
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
@@ -74,6 +78,14 @@ semanage_handle_t *semanage_handle_creat
 	return NULL;
 }
 
+void semanage_set_rebuild(semanage_handle_t *sh, int do_rebuild) {
+
+	assert(sh != NULL);
+
+	sh->do_rebuild = do_rebuild;
+	return;
+}
+
 void semanage_set_reload(semanage_handle_t *sh, int do_reload) {
 	
 	assert(sh != NULL);
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-12-23 06:19:04.000000000 -0500
+++ new/libsemanage/src/handle.h	2005-12-23 14:44:07.000000000 -0500
@@ -62,6 +62,7 @@ struct semanage_handle {
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
+	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
 
 	/* This timeout is used for transactions and waiting for lock
diff -Naurp --exclude-from excludes old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-11-08 14:48:37.000000000 -0500
+++ new/libsemanage/src/libsemanage.map	2005-12-23 14:42:09.000000000 -0500
@@ -8,7 +8,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
-	  semanage_reload_policy; semanage_set_reload;
+	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_context_*;
   local: *;
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-12-13 11:08:25.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-12-23 13:32:43.000000000 -0500
@@ -188,7 +188,8 @@ int semanage_commit_components(
 		semanage_bool_dbase_local(handle),
 		semanage_user_dbase_local(handle),
 		/* semanage_port_dbase_local(handle), */
-		semanage_seuser_dbase(handle)
+		semanage_seuser_dbase(handle),
+		semanage_bool_dbase_active(handle),
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
 
@@ -207,7 +208,7 @@ int semanage_commit_components(
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "could not commit local modifications");
+	ERR(handle, "could not commit local/active modifications");
 
 	for (i=0; i < CCOUNT; i++) 
 		components[i]->dtable->drop_cache(components[i]->dbase);

--------------040606010908090505030900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
