Message-ID: <4360F880.10605@cornell.edu>
Date: Thu, 27 Oct 2005 11:55:44 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Enable things for testing, add missing set relay
Content-Type: multipart/mixed;
 boundary="------------030107080302020307030109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030107080302020307030109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1: (mistakenly sent off-list)  (enable_dbase1)
- enable users, seusers, and booleans for testing

Patch 2: (set_relay)
- add missing relay for set function


--------------030107080302020307030109
Content-Type: text/x-patch;
 name="libsemanage.set_relay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.set_relay.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/booleans_local.h	2005-10-27 11:50:26.000000000 -0400
@@ -15,6 +15,11 @@ extern int semanage_bool_modify_local(
 	semanage_bool_key_t* key,
 	semanage_bool_t* data);
 
+extern int semanage_bool_set_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
 extern int semanage_bool_del_local(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces_local.h	2005-10-27 11:51:27.000000000 -0400
@@ -15,6 +15,11 @@ extern int semanage_iface_modify_local(
 	semanage_iface_key_t* key,
 	semanage_iface_t* data);
 
+extern int semanage_iface_set_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
 extern int semanage_iface_del_local(
 	semanage_handle_t* handle,
 	semanage_iface_key_t* key);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/ports_local.h	2005-10-27 11:50:47.000000000 -0400
@@ -15,6 +15,11 @@ extern int semanage_port_modify_local(
 	semanage_port_key_t* key,
 	semanage_port_t* data);
 
+extern int semanage_port_set_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data);
+
 extern int semanage_port_del_local(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2005-10-14 14:32:29.000000000 -0400
+++ new/libsemanage/include/semanage/seusers.h	2005-10-27 11:51:48.000000000 -0400
@@ -15,6 +15,11 @@ extern int semanage_seuser_modify(
 	semanage_seuser_key_t* key,
 	semanage_seuser_t* data);
 
+extern int semanage_seuser_set(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data);
+
 extern int semanage_seuser_del(
 	semanage_handle_t* handle,
 	semanage_seuser_key_t* key);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/users_local.h	2005-10-27 11:51:06.000000000 -0400
@@ -15,6 +15,11 @@ extern int semanage_user_modify_local(
 	semanage_user_key_t* key,
 	semanage_user_t* data);
 
+extern int semanage_user_set_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data);
+
 extern int semanage_user_del_local(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_local.c	2005-10-27 11:49:57.000000000 -0400
@@ -42,6 +42,15 @@ int semanage_bool_modify_local(
 	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
 }
 
+int semanage_bool_set_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);	
+	return dconfig->dtable->set(handle, dconfig->dbase, key, data);
+}
+
 int semanage_bool_del_local(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_local.c	2005-10-27 11:49:11.000000000 -0400
@@ -42,6 +42,15 @@ int semanage_iface_modify_local(
 	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
 }
 
+int semanage_iface_set_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);	
+	return dconfig->dtable->set(handle, dconfig->dbase, key, data);
+}
+
 int semanage_iface_del_local(
 	semanage_handle_t* handle,
 	semanage_iface_key_t* key) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/ports_local.c	2005-10-27 11:49:31.000000000 -0400
@@ -42,6 +42,15 @@ int semanage_port_modify_local(
 	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
 }
 
+int semanage_port_set_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
+	
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->set(handle, dconfig->dbase, key, data);
+}
+
 int semanage_port_del_local(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsemanage/src/seusers.c	2005-10-27 11:52:28.000000000 -0400
@@ -42,6 +42,15 @@ int semanage_seuser_modify(
 	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
 }
 
+int semanage_seuser_set(
+	semanage_handle_t* handle,
+	semanage_seuser_key_t* key,
+	semanage_seuser_t* data) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
+	return dconfig->dtable->set(handle, dconfig->dbase, key, data);
+}
+
 int semanage_seuser_del(
 	semanage_handle_t* handle,
 	semanage_seuser_key_t* key) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/users_local.c	2005-10-27 11:48:03.000000000 -0400
@@ -42,6 +42,16 @@ int semanage_user_modify_local(
 	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
 }
 
+
+int semanage_user_set_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);	
+	return dconfig->dtable->set(handle, dconfig->dbase, key, data);
+}
+
 int semanage_user_del_local(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key) {

--------------030107080302020307030109
Content-Type: text/x-patch;
 name="libsemanage.enable_dbase1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.enable_dbase1.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/include/semanage/semanage.h	2005-10-27 11:18:46.000000000 -0400
@@ -25,4 +25,26 @@
 #include <semanage/modules.h>
 #include <semanage/debug.h>
 
+/* Records */
+#include <semanage/boolean_record.h>
+#include <semanage/user_record.h>
+#include <semanage/seuser_record.h>
+#if 0
+#include <semanage/iface_record.h>
+#include <semanage/port_record.h>
+#endif
+
+/* Dbase */
+#include <semanage/booleans_local.h>
+#include <semanage/booleans_policy.h>
+#include <semanage/users_local.h>
+#include <semanage/users_policy.h>
+#include <semanage/seusers.h>
+#if 0
+#include <semanage/ports_local.h>
+#include <semanage/ports_policy.h>
+#include <semanage/interfaces_local.h>
+#include <semanage/interfaces_policy.h>
+#endif
+
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-27 10:49:39.000000000 -0400
@@ -349,11 +349,9 @@ static int semanage_direct_commit(semana
 	if (semanage_verify_kernel(sh) != 0)
 		goto cleanup;
 
-#if 0
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
-#endif
 
 	retval = semanage_install_sandbox(sh);
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/libsemanage.map	2005-10-27 11:22:53.000000000 -0400
@@ -9,5 +9,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload;
+	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
   local: *;
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-25 22:06:48.000000000 -0400
@@ -1351,7 +1351,6 @@ int semanage_expand_sandbox(semanage_han
 		goto cleanup;
 	}
 
-#if 0
 	dbase_policydb_attach(sh, semanage_user_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(sh, semanage_port_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(sh, semanage_iface_dbase_policy(sh)->dbase, out);
@@ -1368,7 +1367,6 @@ int semanage_expand_sandbox(semanage_han
 		ERR(sh, "Unable to merge local modifications into policy.");
 		goto cleanup;
 	}
-#endif
 
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;

--------------030107080302020307030109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
