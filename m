Message-ID: <43E80E52.6090503@cornell.edu>
Date: Mon, 06 Feb 2006 22:04:50 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Add seuser and user_extra to package format
References: <43E7D03D.4090909@tresys.com>
In-Reply-To: <43E7D03D.4090909@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------080602010307080100030007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080602010307080100030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please try with the following patch on top:

- removes system databases, which are unnecessary, write directly to the 
final file
- fix 64-bit bugs Joshua's introducing :)

I will resync my nodecon patch tomorrow - let me know if anything's 
wrong with it, otherwise will submit as is (ordering pending in a later 
patch).


--------------080602010307080100030007
Content-Type: text/x-patch;
 name="libsepol.semanage.seuser_extra_in_package2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.semanage.seuser_extra_in_package2.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-02-06 21:55:11.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-02-06 21:32:16.000000000 -0500
@@ -150,15 +150,6 @@ int semanage_direct_connect(semanage_han
 		semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
-	/* Object databases: policy */
-	if (user_extra_file_dbase_init(sh, "users_extra.system",
-		semanage_user_extra_dbase_system(sh)) < 0)
-		goto err;
-
-	if (seuser_file_dbase_init(sh, "seusers.system", 
-		semanage_seuser_dbase_system(sh)) < 0)
-		goto err;
-
 	/* Object databases: local modifications + policy */
 	if (user_base_policydb_dbase_init(sh, 
 		semanage_user_base_dbase_policy(sh)) < 0)
@@ -229,10 +220,6 @@ static int semanage_direct_disconnect(se
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
 	seuser_file_dbase_release(semanage_seuser_dbase_local(sh));
 
-	/* Release object databases: policy */
-	user_extra_file_dbase_release(semanage_user_extra_dbase_system(sh));
-	seuser_file_dbase_release(semanage_seuser_dbase_system(sh));
-
 	/* Release object databases: local modifications + policy */
 	user_base_policydb_dbase_release(semanage_user_base_dbase_policy(sh));
 	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
@@ -473,7 +460,7 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 		}
 
-		/* ==================== File contexts ================== */
+		/* ==================== File-backed ================== */
 
 		/* write the linked file contexts template */
 		if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
@@ -482,15 +469,11 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 		}
 
-		/* Create file_contexts(.homedirs) and drop any previous cache */
 		if (semanage_split_fc(sh)) 
 			goto cleanup;
-		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
-
-		/* ==================== Other file-backed ================== */
 	
 		if (sepol_module_package_get_seusers_len(base)) {
-			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_SYSTEM)) == NULL ||
+			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS)) == NULL ||
 			    write_file(sh, ofilename, sepol_module_package_get_seusers(base), 
 					sepol_module_package_get_seusers_len(base)) == -1) {
 				goto cleanup;
@@ -498,19 +481,19 @@ static int semanage_direct_commit(semana
 		}
 
 		if (sepol_module_package_get_user_extra_len(base)) {
-			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USER_EXTRA_SYSTEM)) == NULL ||
+			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USER_EXTRA)) == NULL ||
 			    write_file(sh, ofilename, sepol_module_package_get_user_extra(base), 
 					sepol_module_package_get_user_extra_len(base)) == -1) {
 				goto cleanup;
 			}
 		}
 
-		/* Clear any cache, will be regenerated */
-		if (pusers_extra->dtable->clear(sh, pusers_extra->dbase) < 0)
-			goto cleanup;
-		
-		if (pseusers->dtable->clear(sh, pseusers->dbase) < 0)
-			goto cleanup;
+		/* Drop any cached content for file_contexts, seusers, or users_extra,
+	 	 * since it is now superceded by the files just written, and needs to be
+		 * re-cached */
+		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
+		pseusers->dtable->drop_cache(pseusers->dbase);
+		pusers_extra->dtable->drop_cache(pusers_extra->dbase);
 
 		/* ==================== Policydb-backed ================ */
 
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/handle.h	2006-02-06 21:26:20.000000000 -0500
@@ -78,7 +78,7 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      19
+#define DBASE_COUNT      17
 
 /* Local modifications */
 #define DBASE_LOCAL_USERS_BASE  0
@@ -90,22 +90,18 @@ struct semanage_handle {
 #define DBASE_LOCAL_FCONTEXTS	6
 #define DBASE_LOCAL_SEUSERS     7
 
-/* Policy */
-#define DBASE_SYSTEM_USERS_EXTRA 8
-#define DBASE_SYSTEM_SEUSERS     9
-
 /* Policy + Local modifications */
-#define DBASE_POLICY_USERS_BASE  10
-#define DBASE_POLICY_USERS_EXTRA 11
-#define DBASE_POLICY_USERS       12
-#define DBASE_POLICY_PORTS       13
-#define DBASE_POLICY_INTERFACES  14
-#define DBASE_POLICY_BOOLEANS    15
-#define DBASE_POLICY_FCONTEXTS   16
-#define DBASE_POLICY_SEUSERS     17
+#define DBASE_POLICY_USERS_BASE  8
+#define DBASE_POLICY_USERS_EXTRA 9
+#define DBASE_POLICY_USERS       10
+#define DBASE_POLICY_PORTS       11
+#define DBASE_POLICY_INTERFACES  12
+#define DBASE_POLICY_BOOLEANS    13
+#define DBASE_POLICY_FCONTEXTS   14
+#define DBASE_POLICY_SEUSERS     15
 
 /* Active kernel policy */
-#define DBASE_ACTIVE_BOOLEANS    18
+#define DBASE_ACTIVE_BOOLEANS    16
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -150,18 +146,6 @@ dbase_config_t* semanage_seuser_dbase_lo
 	return &handle->dbase[DBASE_LOCAL_SEUSERS];
 }
 
-/* === Policy === */
-static inline
-dbase_config_t* semanage_user_extra_dbase_system(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_SYSTEM_USERS_EXTRA];
-}
-
-static inline
-dbase_config_t* semanage_seuser_dbase_system(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_SYSTEM_SEUSERS];
-}
-
-
 /* === Policy + Local modifications === */
 static inline
 dbase_config_t* semanage_user_base_dbase_policy(semanage_handle_t* handle) {
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-02-06 21:25:40.000000000 -0500
@@ -130,9 +130,6 @@ int semanage_base_merge_components(
 		{ semanage_user_base_dbase_local(handle),
 		  semanage_user_base_dbase_policy(handle), MODE_MODIFY },
 
-		{ semanage_user_extra_dbase_system(handle),
-		  semanage_user_extra_dbase_policy(handle), MODE_MODIFY },
-
 		{ semanage_user_extra_dbase_local(handle),
 		  semanage_user_extra_dbase_policy(handle), MODE_MODIFY },
 
@@ -148,9 +145,6 @@ int semanage_base_merge_components(
 		{ semanage_fcontext_dbase_local(handle),
 		  semanage_fcontext_dbase_policy(handle), MODE_MODIFY },
 
-		{ semanage_seuser_dbase_system(handle),
-		  semanage_seuser_dbase_policy(handle), MODE_MODIFY },
-	
 		{ semanage_seuser_dbase_local(handle),
 		  semanage_seuser_dbase_policy(handle), MODE_MODIFY },
 	};
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-02-06 21:55:11.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-02-06 21:47:37.000000000 -0500
@@ -97,8 +97,7 @@ static const char *semanage_sandbox_path
 	"/file_contexts.template",
 	"/commit_num",
 	"/seusers.final",
-	"/seusers.system",
-	"/users_extra.system"
+	"/users_extra",
 };
 
 /* Initialize the paths to config file, lock files and store root.
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2006-02-06 21:55:11.000000000 -0500
+++ new/libsemanage/src/semanage_store.h	2006-02-06 21:26:55.000000000 -0500
@@ -46,8 +46,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
 	SEMANAGE_SEUSERS,
-	SEMANAGE_SEUSERS_SYSTEM,
-	SEMANAGE_USER_EXTRA_SYSTEM,
+	SEMANAGE_USER_EXTRA,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
diff -Naurp --exclude-from excludes old/libsepol/src/module.c new/libsepol/src/module.c
--- old/libsepol/src/module.c	2006-02-06 21:55:11.000000000 -0500
+++ new/libsepol/src/module.c	2006-02-06 21:44:15.000000000 -0500
@@ -460,7 +460,8 @@ int sepol_module_package_read(sepol_modu
 			break;
 		default:
 			/* unknown section, ignore */	
-			ERR(file->handle, "unknown magic number at section %u, offset: %zx, number: %zx ",i, offsets[i],le32_to_cpu(buf[0]));
+			ERR(file->handle, "unknown magic number at section %u, offset: %zx, number: %ux ", 
+				i, offsets[i],le32_to_cpu(buf[0]));
 			break;
 		}
 	}
@@ -636,8 +637,10 @@ cleanup:
 	return -1;
 }
 
-static int write_helper(char *data, int len, struct policy_file *file) {
-	int idx = 0, len2;
+static int write_helper(char *data, size_t len, struct policy_file *file) {
+	int idx = 0;
+	size_t len2;
+
 	while (len) {
 		if (len > BUFSIZ)
 			len2 = BUFSIZ;

--------------080602010307080100030007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
