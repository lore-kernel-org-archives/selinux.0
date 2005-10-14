Message-ID: <434FF612.8010708@cornell.edu>
Date: Fri, 14 Oct 2005 14:16:50 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Add a few direct dbases to handle
Content-Type: multipart/mixed;
 boundary="------------080303080909000806000103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080303080909000806000103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds a few direct databases to the handle.
There's still no dangerous code in the main commit path...
This is just the equivalent to file init.





--------------080303080909000806000103
Content-Type: text/x-patch;
 name="libsemanage.direct_dbase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.direct_dbase.diff"

diff -Naur libsemanage/src/direct_api.c libsemanage.new/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-10-13 15:23:31.000000000 -0400
+++ libsemanage.new/src/direct_api.c	2005-10-14 14:08:44.000000000 -0400
@@ -272,7 +272,7 @@
 
 #if 0
 	/* Link components into base policy */
-	if (semanage_base_merge_components(sh, NULL /* FIXME */) < 0)
+	if (semanage_base_merge_components(sh) < 0)
 		goto cleanup;
 
 	/* Commit changes to components */
diff -Naur libsemanage/src/handle.c libsemanage.new/src/handle.c
--- libsemanage/src/handle.c	2005-10-14 14:10:54.000000000 -0400
+++ libsemanage.new/src/handle.c	2005-10-14 14:07:52.000000000 -0400
@@ -39,6 +39,8 @@
 #include "interfaces_file.h"
 #include "booleans_file.h"
 #include "seusers_file.h"
+#include "users_direct.h"
+#include "ports_direct.h"
 #include "database.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
@@ -90,6 +92,12 @@
 	if (seuser_file_dbase_init(&sh->dbase[DBASE_SEUSERS]) < 0)
 		goto err;
 
+	if (user_direct_dbase_init("base.pp", &sh->dbase[DBASE_BASE_USERS]) < 0)
+		goto err;
+
+	if (port_direct_dbase_init("base.pp", &sh->dbase[DBASE_BASE_PORTS]) < 0)
+		goto err;
+
         return sh;
 
  omem:
diff -Naur libsemanage/src/handle.h libsemanage.new/src/handle.h
--- libsemanage/src/handle.h	2005-10-14 14:10:54.000000000 -0400
+++ libsemanage.new/src/handle.h	2005-10-14 14:07:46.000000000 -0400
@@ -71,12 +71,20 @@
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      5
+#define DBASE_COUNT      7
+
 #define DBASE_USERS      0
 #define DBASE_PORTS      1
 #define DBASE_INTERFACES 2
 #define DBASE_BOOLEANS   3
 #define DBASE_SEUSERS    4
+
+#define DBASE_BASE_USERS      5
+#define DBASE_BASE_PORTS      6
+#if 0
+#define DBASE_BASE_INTERFACES 7
+#define DBASE_BASE_BOOLEANS   8
+#endif
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -105,5 +113,27 @@
 	return &handle->dbase[DBASE_SEUSERS];
 }
 
+static inline
+dbase_config_t* semanage_base_user_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_BASE_USERS];
+}
+
+static inline
+dbase_config_t* semanage_base_port_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_BASE_PORTS];
+}
+
+#if 0
+static inline
+dbase_config_t* semanage_base_iface_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_BASE_INTERFACES];
+}
+
+static inline
+dbase_config_t* semanage_base_bool_dbase(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_BASE_BOOLEANS];
+}
+#endif
+
 #endif
 
diff -Naur libsemanage/src/policy_components.c libsemanage.new/src/policy_components.c
--- libsemanage/src/policy_components.c	2005-10-14 13:19:51.000000000 -0400
+++ libsemanage.new/src/policy_components.c	2005-10-14 14:09:35.000000000 -0400
@@ -5,8 +5,7 @@
 #include "debug.h"
 
 int semanage_base_merge_components(
-	semanage_handle_t* handle,
-	semanage_module_info_t* base) {
+	semanage_handle_t* handle) {
 
 	//dbase_config_t* modules = dbase_modules_dbase(handle);
 	dbase_config_t* interfaces = semanage_iface_dbase(handle);
@@ -36,7 +35,6 @@
 		ports->dbase, NULL, NULL /* FIXME */) < 0)
 		goto err;
 
-	base = NULL;
 	return STATUS_SUCCESS;
 
 	err:
diff -Naur libsemanage/src/policy.h libsemanage.new/src/policy.h
--- libsemanage/src/policy.h	2005-10-13 13:08:35.000000000 -0400
+++ libsemanage.new/src/policy.h	2005-10-14 14:09:44.000000000 -0400
@@ -66,8 +66,7 @@
 
 /* Should be backend independent */
 extern int semanage_base_merge_components(
-	struct semanage_handle* handle,
-	semanage_module_info_t* base);
+	struct semanage_handle* handle);
 
 extern int semanage_commit_components(
 	struct semanage_handle* handle);

--------------080303080909000806000103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
