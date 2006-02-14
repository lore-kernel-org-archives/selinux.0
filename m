Message-ID: <43F24788.6060601@cornell.edu>
Date: Tue, 14 Feb 2006 16:11:36 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Use the paths array
Content-Type: multipart/mixed;
 boundary="------------080204070901000502000308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080204070901000502000308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joshua's complained about my non-use of the store path array.
Correct this issue.




--------------080204070901000502000308
Content-Type: text/x-patch;
 name="libsemanage.use_store_paths.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.use_store_paths.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-02-14 13:48:16.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-02-14 15:06:35.000000000 -0500
@@ -117,11 +117,13 @@ int semanage_direct_connect(semanage_han
 	sh->funcs = &direct_funcs;
 
         /* Object databases: local modifications */
-	if (user_base_file_dbase_init(sh, "users.local", 
+	if (user_base_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_BASE_LOCAL),
 		semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
 
-	if (user_extra_file_dbase_init(sh, "users_extra.local",
+	if (user_extra_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_EXTRA_LOCAL),
 		semanage_user_extra_dbase_local(sh)) < 0)
 		goto err;
 
@@ -131,27 +133,33 @@ int semanage_direct_connect(semanage_han
 		semanage_user_dbase_local(sh)) < 0)
 		goto err;
 
-	if (port_file_dbase_init(sh, "ports.local", 
+	if (port_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_PORTS_LOCAL), 
 		semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(sh, "interfaces.local",
+	if (iface_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_INTERFACES_LOCAL),
 		semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(sh, "booleans.local",
+	if (bool_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_BOOLEANS_LOCAL),
 		semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
-	if (fcontext_file_dbase_init(sh, "file_contexts.local", 
+	if (fcontext_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_FC_LOCAL), 
 		semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(sh, "seusers",
+	if (seuser_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_SEUSERS_LOCAL),
 		semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
-	if (node_file_dbase_init(sh, "nodes.local",
+	if (node_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_NODES_LOCAL),
 		semanage_node_dbase_local(sh)) < 0)
 		goto err;
 
@@ -160,7 +168,8 @@ int semanage_direct_connect(semanage_han
 		semanage_user_base_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (user_extra_file_dbase_init(sh, "users_extra", 
+	if (user_extra_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_EXTRA), 
 		semanage_user_extra_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -179,11 +188,13 @@ int semanage_direct_connect(semanage_han
 	if (bool_policydb_dbase_init(sh, semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (fcontext_file_dbase_init(sh, "file_contexts", 
+	if (fcontext_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_FC), 
 		semanage_fcontext_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(sh, "seusers.final", 
+	if (seuser_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_SEUSERS), 
 		semanage_seuser_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -503,7 +514,7 @@ static int semanage_direct_commit(semana
 
 		/* Users_extra */
 		if (sepol_module_package_get_user_extra_len(base)) {
-			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USER_EXTRA)) == NULL ||
+			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA)) == NULL ||
 			    write_file(sh, ofilename, sepol_module_package_get_user_extra(base), 
 					sepol_module_package_get_user_extra_len(base)) == -1) {
 				goto cleanup;
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-02-14 16:09:26.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-02-14 16:05:07.000000000 -0500
@@ -1026,8 +1026,6 @@ class Tests:
 			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
-		self.test_nodes(sh)
-
 		status = semanage.semanage_begin_transaction(sh)
 		if status < 0:
 			raise Error("Could not start semanage transaction")
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-02-13 10:13:22.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-02-14 15:51:01.000000000 -0500
@@ -96,6 +96,14 @@ static const char *semanage_sandbox_path
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
+	"/ports.local",
+	"/interfaces.local",
+	"/nodes.local",
+	"/booleans.local",
+	"/file_contexts.local",
+	"/seusers",
+	"/users_extra.local",
+	"/users.local",
 	"/seusers.final",
 	"/users_extra",
 };
@@ -188,6 +196,11 @@ int semanage_check_init(const char *root
 	return 0;
 }
 
+/* Given a definition number, return a file name from the paths array */
+const char* semanage_fname(enum semanage_sandbox_defs file_enum) {
+	return semanage_sandbox_paths[file_enum];
+}
+
 /* Given a store location (active/previous/tmp) and a definition
  * number, return a fully-qualified path to that file or directory.
  * The caller must not alter the string returned (and hence why this
diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2006-02-07 09:20:42.000000000 -0500
+++ new/libsemanage/src/semanage_store.h	2006-02-14 15:06:19.000000000 -0500
@@ -45,8 +45,16 @@ enum semanage_sandbox_defs {
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
+	SEMANAGE_PORTS_LOCAL,
+	SEMANAGE_INTERFACES_LOCAL,
+	SEMANAGE_NODES_LOCAL,
+	SEMANAGE_BOOLEANS_LOCAL,
+	SEMANAGE_FC_LOCAL,
+	SEMANAGE_SEUSERS_LOCAL,
+	SEMANAGE_USERS_BASE_LOCAL,
+	SEMANAGE_USERS_EXTRA_LOCAL,
 	SEMANAGE_SEUSERS,
-	SEMANAGE_USER_EXTRA,
+	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
@@ -55,7 +63,13 @@ enum semanage_sandbox_defs {
  */
 const char *semanage_conf_path(void);
 int semanage_check_init(const char *root);
-const char *semanage_path(enum semanage_store_defs store, enum semanage_sandbox_defs file);
+
+extern const char* semanage_fname(
+	enum semanage_sandbox_defs file_enum);
+
+extern const char *semanage_path(
+	enum semanage_store_defs store, 
+	enum semanage_sandbox_defs file);
 
 int semanage_create_store(semanage_handle_t *sh, int create);
 

--------------080204070901000502000308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
