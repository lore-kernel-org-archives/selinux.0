Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UEF2Ns028816
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 10:15:02 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UE9HDY006047
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:09:17 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j8UE93jP023760
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 10:09:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j8UE933u023759
	for selinux@tycho.nsa.gov; Fri, 30 Sep 2005 10:09:03 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U2kfNs023508
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 22:46:41 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2epS2015404
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:40:51 GMT
Message-ID: <433CA7CA.6000207@cornell.edu>
Date: Thu, 29 Sep 2005 22:49:46 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: [ 1/9 ] [ SEPOL ] Eliminate struct pointer typedefs
Content-Type: multipart/mixed;
 boundary="------------060904080806060009060604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060904080806060009060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch changes record structure typedefs in libsepol
from struct pointer to struct alias. Also adds size_t in a few places.



--------------060904080806060009060604
Content-Type: text/x-patch;
 name="libsepol.00.consistency.typedefs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.00.consistency.typedefs.diff"

diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/boolean_record.h libsepol.new/include/sepol/boolean_record.h
--- libsepol/include/sepol/boolean_record.h	2005-09-21 10:42:24.000000000 -0400
+++ libsepol.new/include/sepol/boolean_record.h	2005-09-29 16:30:48.000000000 -0400
@@ -5,36 +5,50 @@
 
 struct sepol_bool;
 struct sepol_bool_key;
-typedef struct sepol_bool* sepol_bool_t;
-typedef struct sepol_bool_key* sepol_bool_key_t;
+typedef struct sepol_bool sepol_bool_t;
+typedef struct sepol_bool_key sepol_bool_key_t;
 
 /* Key */
 extern int sepol_bool_key_create(
 	const char* name,
-	sepol_bool_key_t* key);
+	sepol_bool_key_t** key);
 
 extern int sepol_bool_key_extract(
-	sepol_bool_t boolean,
-	sepol_bool_key_t* key_ptr);
+	sepol_bool_t* boolean,
+	sepol_bool_key_t** key_ptr);
 
 extern void sepol_bool_key_free(
-	sepol_bool_key_t key);
+	sepol_bool_key_t* key);
 
 extern int sepol_bool_compare(
-	sepol_bool_t boolean,
-	sepol_bool_key_t key);
+	sepol_bool_t* boolean,
+	sepol_bool_key_t* key);
 	
 /* Name */
-extern const char* sepol_bool_get_name(sepol_bool_t boolean);
-extern int sepol_bool_set_name(sepol_bool_t boolean, const char* name);
+extern const char* sepol_bool_get_name(
+	sepol_bool_t* boolean);
+
+extern int sepol_bool_set_name(
+	sepol_bool_t* boolean, 
+	const char* name);
 
 /* Value */
-extern int sepol_bool_get_value(sepol_bool_t boolean);
-extern void sepol_bool_set_value(sepol_bool_t boolean, int value);
+extern int sepol_bool_get_value(
+	sepol_bool_t* boolean);
+
+extern void sepol_bool_set_value(
+	sepol_bool_t* boolean, 
+	int value);
 
 /* Create/Clone/Destroy */
-extern int sepol_bool_create(sepol_bool_t* bool_ptr);
-extern int sepol_bool_clone(sepol_bool_t boolean, sepol_bool_t* bool_ptr);
-extern void sepol_bool_free(sepol_bool_t boolean);
+extern int sepol_bool_create(
+	sepol_bool_t** bool_ptr);
+
+extern int sepol_bool_clone(
+	sepol_bool_t* boolean, 
+	sepol_bool_t** bool_ptr);
+
+extern void sepol_bool_free(
+	sepol_bool_t* boolean);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/booleans.h libsepol.new/include/sepol/booleans.h
--- libsepol/include/sepol/booleans.h	2005-09-21 10:42:24.000000000 -0400
+++ libsepol.new/include/sepol/booleans.h	2005-09-29 16:31:14.000000000 -0400
@@ -1,18 +1,19 @@
 #ifndef _SEPOL_BOOLEANS_H_
 #define _SEPOL_BOOLEANS_H_
 
+#include <stddef.h>
 #include <sepol/policydb.h>
 #include <sepol/boolean_record.h>
 
 /* Load a boolean into the policy */
 extern int sepol_bool_load (
 	policydb_t* policydb, 
-	sepol_bool_t boolean);
+	sepol_bool_t* boolean);
 
 /* Load a boolean array into the policy */
 extern int sepol_bool_load_array(
 	policydb_t* policydb,
-	sepol_bool_t* bool_arr,
-	int bool_arr_len);
+	sepol_bool_t** bool_arr,
+	size_t bool_arr_len);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/context.h libsepol.new/include/sepol/context.h
--- libsepol/include/sepol/context.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol.new/include/sepol/context.h	2005-09-29 16:34:01.000000000 -0400
@@ -118,7 +118,7 @@
 extern int sepol_ctx_struct_create(
 	struct policydb *policydb,
 	context_struct_t** cptr,
-	sepol_context_t data);
+	sepol_context_t* data);
 
 /* Create a context structure from string representation */
 extern int sepol_ctx_struct_from_string(
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/context_record.h libsepol.new/include/sepol/context_record.h
--- libsepol/include/sepol/context_record.h	2005-08-02 09:16:52.000000000 -0400
+++ libsepol.new/include/sepol/context_record.h	2005-09-29 16:33:11.000000000 -0400
@@ -2,34 +2,60 @@
 #define _SEPOL_CONTEXT_RECORD_H_ 
 
 struct sepol_context;
-typedef struct sepol_context* sepol_context_t;
+typedef struct sepol_context sepol_context_t;
 
 /* We don't need a key, because the context is never stored
  * in a data collection by itself */
 
 /* User */
-extern const char* sepol_context_get_user(sepol_context_t con);
-extern int sepol_context_set_user(sepol_context_t con, const char* user);
+extern const char* sepol_context_get_user(
+	sepol_context_t* con);
+
+extern int sepol_context_set_user(
+	sepol_context_t* con, 
+	const char* user);
 
 /* Role */
-extern const char* sepol_context_get_role(sepol_context_t con);
-extern int sepol_context_set_role(sepol_context_t con, const char* role);
+extern const char* sepol_context_get_role(
+	sepol_context_t* con);
+
+extern int sepol_context_set_role(
+	sepol_context_t* con, 
+	const char* role);
 
 /* Type */
-extern const char* sepol_context_get_type(sepol_context_t con);
-extern int sepol_context_set_type(sepol_context_t con, const char* type);
+extern const char* sepol_context_get_type(
+	sepol_context_t* con);
+
+extern int sepol_context_set_type(
+	sepol_context_t* con, 
+	const char* type);
 
 /* MLS */
-extern const char* sepol_context_get_mls(sepol_context_t con);
-extern int sepol_context_set_mls(sepol_context_t con, const char* mls_range);
+extern const char* sepol_context_get_mls(
+	sepol_context_t* con);
+
+extern int sepol_context_set_mls(
+	sepol_context_t* con,
+	const char* mls_range);
 
 /* Create/Clone/Destroy */
-extern int sepol_context_create(sepol_context_t* con_ptr);
-extern int sepol_context_clone(sepol_context_t con, sepol_context_t* con_ptr);
-extern void sepol_context_free(sepol_context_t con);
+extern int sepol_context_create(
+	sepol_context_t** con_ptr);
+
+extern int sepol_context_clone(
+	sepol_context_t* con, 
+	sepol_context_t** con_ptr);
+
+extern void sepol_context_free(
+	sepol_context_t* con);
 
 /* Parse to/from string */
-extern int sepol_context_from_string(const char* str, sepol_context_t* con);
-extern char* sepol_context_to_string(sepol_context_t con);
+extern int sepol_context_from_string(
+	const char* str, 
+	sepol_context_t** con);
+
+extern char* sepol_context_to_string(
+	sepol_context_t* con);
 
 #endif 
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/iface_record.h libsepol.new/include/sepol/iface_record.h
--- libsepol/include/sepol/iface_record.h	2005-09-19 15:31:28.000000000 -0400
+++ libsepol.new/include/sepol/iface_record.h	2005-09-29 16:33:39.000000000 -0400
@@ -5,39 +5,57 @@
 
 struct sepol_iface;
 struct sepol_iface_key;
-typedef struct sepol_iface* sepol_iface_t;
-typedef struct sepol_iface_key* sepol_iface_key_t;
+typedef struct sepol_iface sepol_iface_t;
+typedef struct sepol_iface_key sepol_iface_key_t;
 
 /* Key */
 extern int sepol_iface_compare(
-	sepol_iface_t iface, 
-	sepol_iface_key_t key);
+	sepol_iface_t* iface, 
+	sepol_iface_key_t* key);
 
 extern int sepol_iface_key_create(
 	const char* name,
-	sepol_iface_key_t* key_ptr);
+	sepol_iface_key_t** key_ptr);
 
 extern int sepol_iface_key_extract(
-	sepol_iface_t iface, 
-	sepol_iface_key_t* key_ptr);
+	sepol_iface_t* iface, 
+	sepol_iface_key_t** key_ptr);
 
 extern void sepol_iface_key_free(
-	sepol_iface_key_t key);
+	sepol_iface_key_t* key);
 
 /* Name */
-extern const char* sepol_iface_get_name(sepol_iface_t iface);
-extern int sepol_iface_set_name(sepol_iface_t iface, const char* name);
+extern const char* sepol_iface_get_name(
+	sepol_iface_t* iface);
+
+extern int sepol_iface_set_name(
+	sepol_iface_t* iface, 
+	const char* name);
 
 /* Context */
-extern sepol_context_t sepol_iface_get_ifcon(sepol_iface_t iface);
-extern int sepol_iface_set_ifcon(sepol_iface_t iface, sepol_context_t con);
+extern sepol_context_t* sepol_iface_get_ifcon(
+	sepol_iface_t* iface);
 
-extern sepol_context_t sepol_iface_get_msgcon(sepol_iface_t iface);
-extern int sepol_iface_set_msgcon(sepol_iface_t iface, sepol_context_t con);
+extern int sepol_iface_set_ifcon(
+	sepol_iface_t* iface, 
+	sepol_context_t* con);
+
+extern sepol_context_t* sepol_iface_get_msgcon(
+	sepol_iface_t* iface);
+
+extern int sepol_iface_set_msgcon(
+	sepol_iface_t* iface, 
+	sepol_context_t* con);
 
 /* Create/Clone/Destroy */
-extern int sepol_iface_create(sepol_iface_t* iface_ptr);
-extern int sepol_iface_clone(sepol_iface_t iface, sepol_iface_t* iface_ptr);
-extern void sepol_iface_free(sepol_iface_t iface);
+extern int sepol_iface_create(
+	sepol_iface_t** iface_ptr);
+
+extern int sepol_iface_clone(
+	sepol_iface_t* iface, 
+	sepol_iface_t** iface_ptr);
+
+extern void sepol_iface_free(
+	sepol_iface_t* iface);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/interfaces.h libsepol.new/include/sepol/interfaces.h
--- libsepol/include/sepol/interfaces.h	2005-09-21 10:42:24.000000000 -0400
+++ libsepol.new/include/sepol/interfaces.h	2005-09-29 16:29:25.000000000 -0400
@@ -8,13 +8,13 @@
 /* Get the current context mapping for this interface */
 extern int sepol_iface_get_context(
 	policydb_t* policydb,
-	sepol_iface_t data,
+	sepol_iface_t* data,
 	char** ifcon_str, size_t* ifcon_str_len,
 	char** msgcon_str, size_t* msgcon_str_len);
 
 /* Load an interface into policy */
 extern int sepol_iface_load(
 	policydb_t* policydb,
-	sepol_iface_t data);
+	sepol_iface_t* data);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/port_record.h libsepol.new/include/sepol/port_record.h
--- libsepol/include/sepol/port_record.h	2005-08-02 09:16:53.000000000 -0400
+++ libsepol.new/include/sepol/port_record.h	2005-09-29 16:33:22.000000000 -0400
@@ -5,46 +5,71 @@
 
 struct sepol_port;
 struct sepol_port_key;
-typedef struct sepol_port* sepol_port_t;
-typedef struct sepol_port_key* sepol_port_key_t;
+typedef struct sepol_port sepol_port_t;
+typedef struct sepol_port_key sepol_port_key_t;
 
 #define SEPOL_PROTO_UDP 0
 #define SEPOL_PROTO_TCP 1
 
 /* Key */
 extern int sepol_port_compare(
-	sepol_port_t port, 
-	sepol_port_key_t key);
+	sepol_port_t* port, 
+	sepol_port_key_t* key);
 
 extern int sepol_port_key_create(
 	int low, int high, int proto,
-	sepol_port_key_t* key_ptr);
+	sepol_port_key_t** key_ptr);
 
 extern int sepol_port_key_extract(
-	sepol_port_t port, 
-	sepol_port_key_t* key_ptr);
+	sepol_port_t* port, 
+	sepol_port_key_t** key_ptr);
 
 extern void sepol_port_key_free(
-	sepol_port_key_t key);
+	sepol_port_key_t* key);
 
 /* Protocol */
-extern int sepol_port_get_proto(sepol_port_t port);
-extern int sepol_port_set_proto(sepol_port_t port, int proto);
-extern const char* sepol_port_get_proto_str(sepol_port_t port);
+extern int sepol_port_get_proto(
+	sepol_port_t* port);
+
+extern int sepol_port_set_proto(
+	sepol_port_t* port, 
+	int proto);
+
+extern const char* sepol_port_get_proto_str(
+	sepol_port_t* port);
 
 /* Port */
-extern int sepol_port_get_low(sepol_port_t port);
-extern int sepol_port_get_high(sepol_port_t port);
-extern int sepol_port_set_port(sepol_port_t port, int port_num);
-extern int sepol_port_set_range(sepol_port_t port, int low, int high);
+extern int sepol_port_get_low(
+	sepol_port_t* port);
+
+extern int sepol_port_get_high(
+	sepol_port_t* port);
+
+extern int sepol_port_set_port(
+	sepol_port_t* port, 
+	int port_num);
+
+extern int sepol_port_set_range(
+	sepol_port_t* port, 
+	int low, int high);
 
 /* Context */
-extern sepol_context_t sepol_port_get_con(sepol_port_t port);
-extern int sepol_port_set_con(sepol_port_t port, sepol_context_t con);
+extern sepol_context_t* sepol_port_get_con(
+	sepol_port_t* port);
+
+extern int sepol_port_set_con(
+	sepol_port_t* port, 
+	sepol_context_t* con);
 
 /* Create/Clone/Destroy */
-extern int sepol_port_create(sepol_port_t* port_ptr);
-extern int sepol_port_clone(sepol_port_t port, sepol_port_t* port_ptr);
-extern void sepol_port_free(sepol_port_t port);
+extern int sepol_port_create(
+	sepol_port_t** port_ptr);
+
+extern int sepol_port_clone(
+	sepol_port_t* port, 
+	sepol_port_t** port_ptr);
+
+extern void sepol_port_free(
+	sepol_port_t* port);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/ports.h libsepol.new/include/sepol/ports.h
--- libsepol/include/sepol/ports.h	2005-09-21 10:42:24.000000000 -0400
+++ libsepol.new/include/sepol/ports.h	2005-09-29 16:26:10.000000000 -0400
@@ -10,13 +10,13 @@
  * success. The returned data is allocated on the heap */
 int sepol_port_get_context(
 	policydb_t* policydb,
-	sepol_port_t data,
+	sepol_port_t* data,
 	char** con_str,
 	size_t* con_str_len);
 
 /* Load the given port into policy. No shadowing is allowed. */
 extern int sepol_port_load(
 	policydb_t* policydb, 
-	sepol_port_t data);
+	sepol_port_t* data);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/user_record.h libsepol.new/include/sepol/user_record.h
--- libsepol/include/sepol/user_record.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol.new/include/sepol/user_record.h	2005-09-29 16:23:35.000000000 -0400
@@ -5,63 +5,90 @@
 
 struct sepol_user;
 struct sepol_user_key;
-typedef struct sepol_user* sepol_user_t;
-typedef struct sepol_user_key* sepol_user_key_t;
+typedef struct sepol_user sepol_user_t;
+typedef struct sepol_user_key sepol_user_key_t;
 
 /* Key */
 extern int sepol_user_key_create(
 	const char* name,
-	sepol_user_key_t* key);
+	sepol_user_key_t** key);
 
 extern int sepol_user_key_extract(
-	sepol_user_t user,
-	sepol_user_key_t* key_ptr);
+	sepol_user_t* user,
+	sepol_user_key_t** key_ptr);
 
 extern void sepol_user_key_free(
-	sepol_user_key_t key);
+	sepol_user_key_t* key);
 
 extern int sepol_user_compare(
-	sepol_user_t user,
-	sepol_user_key_t key);
+	sepol_user_t* user,
+	sepol_user_key_t* key);
 	
 /* Name */
-extern const char* sepol_user_get_name(sepol_user_t user);
-extern int sepol_user_set_name(sepol_user_t user, const char* name);
+extern const char* sepol_user_get_name(
+	sepol_user_t* user);
+
+extern int sepol_user_set_name(
+	sepol_user_t* user, 
+	const char* name);
 
 /* MLS */
 extern const char* sepol_user_get_mlslevel(
-	sepol_user_t user);
+	sepol_user_t* user);
 
 extern int sepol_user_set_mlslevel(
-	sepol_user_t user, 
+	sepol_user_t* user, 
 	const char* mls_level);
 
 extern const char* sepol_user_get_mlsrange(
-	sepol_user_t user);
+	sepol_user_t* user);
 
 extern int sepol_user_set_mlsrange(
-	sepol_user_t user, 
+	sepol_user_t* user, 
 	const char* mls_range);
 
 /* Role management */
-extern int sepol_user_get_num_roles(sepol_user_t user);
-extern const char* sepol_user_get_defrole(sepol_user_t user);
-extern int sepol_user_add_role(sepol_user_t user, const char* role);
-extern int sepol_user_del_role(sepol_user_t user, const char* role);
-extern int sepol_user_has_role(sepol_user_t user, const char* role);
-extern int sepol_user_set_defrole(sepol_user_t user, const char* role);
+extern int sepol_user_get_num_roles(
+	sepol_user_t* user);
+
+extern const char* sepol_user_get_defrole(
+	sepol_user_t* user);
+
+extern int sepol_user_add_role(
+	sepol_user_t* user, 
+	const char* role);
+
+extern int sepol_user_del_role(
+	sepol_user_t* user, 
+	const char* role);
+
+extern int sepol_user_has_role(
+	sepol_user_t* user, 
+	const char* role);
+
+extern int sepol_user_set_defrole(
+	sepol_user_t* user, 
+	const char* role);
+
 extern int sepol_user_get_roles(
-	sepol_user_t user,
+	sepol_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles);
+
 extern int sepol_user_set_roles(
-	sepol_user_t user,
+	sepol_user_t* user,
 	const char** roles_arr,
 	size_t num_roles);
 
 /* Create/Clone/Destroy */
-extern int sepol_user_create(sepol_user_t* user_ptr);
-extern int sepol_user_clone(sepol_user_t user, sepol_user_t* user_ptr);
-extern void sepol_user_free(sepol_user_t user);
+extern int sepol_user_create(
+	sepol_user_t** user_ptr);
+
+extern int sepol_user_clone(
+	sepol_user_t* user, 
+	sepol_user_t** user_ptr);
+
+extern void sepol_user_free(
+	sepol_user_t* user);
 
 #endif
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/include/sepol/users.h libsepol.new/include/sepol/users.h
--- libsepol/include/sepol/users.h	2005-09-29 16:39:40.000000000 -0400
+++ libsepol.new/include/sepol/users.h	2005-09-29 16:23:20.000000000 -0400
@@ -13,7 +13,7 @@
    Load allows duplicates, but add does not. */
 extern int sepol_user_add(
 	policydb_t* policydb,
-	sepol_user_t user); 
+	sepol_user_t* user); 
 
 extern int sepol_user_del(
 	policydb_t* policydb, 
@@ -21,7 +21,7 @@
 
 extern int sepol_user_load(
 	policydb_t* policydb, 
-	sepol_user_t user);
+	sepol_user_t* user);
 
 /* Check if users or roles are valid */
 extern int sepol_user_is_valid(
@@ -43,4 +43,4 @@
 	char*** roles, 
 	size_t* nroles);
 
-#endif /* _SEPOL_USERS_H_ */
+#endif 
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/boolean_record.c libsepol.new/src/boolean_record.c
--- libsepol/src/boolean_record.c	2005-09-21 10:42:24.000000000 -0400
+++ libsepol.new/src/boolean_record.c	2005-09-29 16:12:50.000000000 -0400
@@ -20,10 +20,10 @@
 
 int sepol_bool_key_create(
 	const char* name,
-	sepol_bool_key_t* key_ptr) {
+	sepol_bool_key_t** key_ptr) {
 
-	sepol_bool_key_t tmp_key = 
-		(sepol_bool_key_t) malloc(sizeof (struct sepol_bool_key));
+	sepol_bool_key_t* tmp_key = 
+		(sepol_bool_key_t*) malloc(sizeof (struct sepol_bool_key));
 
 	if (!tmp_key) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -37,7 +37,7 @@
 	return STATUS_SUCCESS;
 }
 
-int sepol_bool_key_extract(sepol_bool_t boolean, sepol_bool_key_t* key_ptr) {
+int sepol_bool_key_extract(sepol_bool_t* boolean, sepol_bool_key_t** key_ptr) {
 	if (sepol_bool_key_create(boolean->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from boolean %s\n",
 			boolean->name);
@@ -47,13 +47,13 @@
 	return STATUS_SUCCESS;
 }	
 
-void sepol_bool_key_free(sepol_bool_key_t key) {
+void sepol_bool_key_free(sepol_bool_key_t* key) {
 	free(key);
 }
 
 int sepol_bool_compare(
-	sepol_bool_t boolean,
-	sepol_bool_key_t key) {
+	sepol_bool_t* boolean,
+	sepol_bool_key_t* key) {
 	
 	if (!strcmp(boolean->name, key->name))
 		return 0;
@@ -61,11 +61,11 @@
 }
 
 /* Name */
-const char* sepol_bool_get_name(sepol_bool_t boolean) {
+const char* sepol_bool_get_name(sepol_bool_t* boolean) {
 	return boolean->name;
 }
 
-int sepol_bool_set_name(sepol_bool_t boolean, const char* name) {
+int sepol_bool_set_name(sepol_bool_t* boolean, const char* name) {
 	boolean->name = strdup(name);
 	if (!boolean->name) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -76,18 +76,17 @@
 }
 
 /* Value */
-int sepol_bool_get_value(sepol_bool_t boolean) {
+int sepol_bool_get_value(sepol_bool_t* boolean) {
 	return boolean->value;
 }
 
-void sepol_bool_set_value(sepol_bool_t boolean, int value) {
+void sepol_bool_set_value(sepol_bool_t* boolean, int value) {
 	boolean->value = value;
 }
 
 /* Create */
-int sepol_bool_create(sepol_bool_t* bool_ptr) {
-	sepol_bool_t boolean = (sepol_bool_t) 
-		malloc(sizeof (struct sepol_bool));
+int sepol_bool_create(sepol_bool_t** bool_ptr) {
+	sepol_bool_t* boolean = (sepol_bool_t*) malloc(sizeof (sepol_bool_t));
 
         if (!boolean) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -103,8 +102,8 @@
 }
 
 /* Deep copy clone */
-int sepol_bool_clone(sepol_bool_t boolean, sepol_bool_t* bool_ptr) {
-	sepol_bool_t new_bool = NULL;
+int sepol_bool_clone(sepol_bool_t* boolean, sepol_bool_t** bool_ptr) {
+	sepol_bool_t* new_bool = NULL;
 
 	if (sepol_bool_create(&new_bool) < 0)
 		goto err;
@@ -124,7 +123,7 @@
 }
 
 /* Destroy */
-void sepol_bool_free(sepol_bool_t boolean) {
+void sepol_bool_free(sepol_bool_t* boolean) {
 	if (!boolean)
 		return;
 	
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/booleans.c libsepol.new/src/booleans.c
--- libsepol/src/booleans.c	2005-09-23 20:42:45.000000000 -0400
+++ libsepol.new/src/booleans.c	2005-09-29 16:45:58.000000000 -0400
@@ -1,5 +1,6 @@
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <errno.h>
 
 #include "private.h"
@@ -11,9 +12,9 @@
 #include <sepol/conditional.h>
 #include <sepol/boolean_record.h>
 
-static int bool_update (
+static inline int bool_update (
 	policydb_t* policydb,
-	sepol_bool_t boolean) {
+	sepol_bool_t* boolean) {
 
 	char* name = strdup(sepol_bool_get_name(boolean));
 	int value = sepol_bool_get_value(boolean);
@@ -46,7 +47,7 @@
 }
 
 int sepol_bool_load (
-	policydb_t* policydb, sepol_bool_t boolean) {
+	policydb_t* policydb, sepol_bool_t* boolean) {
 
 	if (bool_update(policydb, boolean) < 0)
 		goto err;	
@@ -67,10 +68,10 @@
 
 int sepol_bool_load_array(
 	policydb_t* policydb,
-	sepol_bool_t* bool_arr,
-	int bool_arr_len) {	
+	sepol_bool_t** bool_arr,
+	size_t bool_arr_len) {	
 
-	int i, errors = 0;
+	unsigned int i, errors = 0;
 
 	for (i = 0; i < bool_arr_len; i++)
 		if (bool_update(policydb, bool_arr[i]) < 0) {
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/context.c libsepol.new/src/context.c
--- libsepol/src/context.c	2005-08-02 09:17:09.000000000 -0400
+++ libsepol.new/src/context.c	2005-09-29 16:20:11.000000000 -0400
@@ -122,7 +122,7 @@
 int sepol_ctx_struct_create(
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
-	sepol_context_t data) {
+	sepol_context_t* data) {
 
 	context_struct_t* scontext = NULL;
 	user_datum_t* usrdatum;
@@ -232,7 +232,7 @@
 	size_t con_str_len) { 
 
 	char* con_cpy = NULL;
-	sepol_context_t ctx_info = NULL;
+	sepol_context_t* ctx_info = NULL;
 
 	/* sepol_context_from_string expects a NULL-terminated string */
 	con_cpy = malloc(con_str_len + 1);
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/context_record.c libsepol.new/src/context_record.c
--- libsepol/src/context_record.c	2005-08-18 16:42:25.000000000 -0400
+++ libsepol.new/src/context_record.c	2005-09-29 16:17:55.000000000 -0400
@@ -21,11 +21,11 @@
 };
 
 /* User */
-const char* sepol_context_get_user(sepol_context_t con) {
+const char* sepol_context_get_user(sepol_context_t* con) {
 	return con->user;
 }
 
-int sepol_context_set_user(sepol_context_t con, const char* user) {
+int sepol_context_set_user(sepol_context_t* con, const char* user) {
 	con->user = strdup(user);
 	if (!con->user) { 
 		DEBUG(__FUNCTION__, "out of memory, could not set "
@@ -36,11 +36,11 @@
 }
 
 /* Role */
-const char* sepol_context_get_role(sepol_context_t con) {
+const char* sepol_context_get_role(sepol_context_t* con) {
 	return con->role;
 }
 
-int sepol_context_set_role(sepol_context_t con, const char* role) {
+int sepol_context_set_role(sepol_context_t* con, const char* role) {
 	con->role = strdup(role);
 	if (!con->role) {
 		DEBUG(__FUNCTION__, "out of memory, could not set "
@@ -51,11 +51,11 @@
 }
 
 /* Type */
-const char* sepol_context_get_type(sepol_context_t con) {
+const char* sepol_context_get_type(sepol_context_t* con) {
 	return con->type;
 }
 
-int sepol_context_set_type(sepol_context_t con, const char* type) {
+int sepol_context_set_type(sepol_context_t* con, const char* type) {
 	con->type = strdup(type);
 	if (!con->role) {
 		DEBUG(__FUNCTION__, "out of memory, could not set "
@@ -66,11 +66,11 @@
 }
 
 /* MLS */
-const char* sepol_context_get_mls(sepol_context_t con) {
+const char* sepol_context_get_mls(sepol_context_t* con) {
 	return con->mls;
 }
 
-int sepol_context_set_mls(sepol_context_t con, const char* mls) {
+int sepol_context_set_mls(sepol_context_t* con, const char* mls) {
 	con->mls = strdup(mls);
 	if (!con->mls) {
 		DEBUG(__FUNCTION__, "out of memory, could not set "
@@ -81,9 +81,9 @@
 }
 
 /* Create */
-int sepol_context_create(sepol_context_t* con_ptr) {
-	sepol_context_t con =
-                (sepol_context_t) malloc(sizeof(struct sepol_context));
+int sepol_context_create(sepol_context_t** con_ptr) {
+	sepol_context_t* con =
+                (sepol_context_t*) malloc(sizeof(sepol_context_t));
 
         if (!con) {
 		DEBUG(__FUNCTION__, "out of memory, could not "
@@ -101,10 +101,10 @@
 
 /* Deep copy clone */
 int sepol_context_clone(
-	sepol_context_t con,
-	sepol_context_t* con_ptr) {
+	sepol_context_t* con,
+	sepol_context_t** con_ptr) {
 
-	sepol_context_t new_con = NULL;	
+	sepol_context_t* new_con = NULL;	
 	if (sepol_context_create(&new_con) < 0)
 		goto err;
 
@@ -133,7 +133,7 @@
 }
 
 /* Destroy */
-void sepol_context_free(sepol_context_t con) {
+void sepol_context_free(sepol_context_t* con) {
 	if (!con)
 		return;
 
@@ -144,10 +144,10 @@
 	free(con);
 }
 
-int sepol_context_from_string(const char* str, sepol_context_t* con) {
+int sepol_context_from_string(const char* str, sepol_context_t** con) {
 
 	char *tmp = NULL, *low, *high;
-	sepol_context_t tmp_con = NULL;
+	sepol_context_t* tmp_con = NULL;
 
 	if (!strcmp(str, "<<none>>")) {
 		*con = NULL;
@@ -214,7 +214,7 @@
 	return STATUS_ERR;
 }
 
-char* sepol_context_to_string(sepol_context_t con) {
+char* sepol_context_to_string(sepol_context_t* con) {
 
 	const int user_sz = strlen(con->user);
 	const int role_sz = strlen(con->role);
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/iface_record.c libsepol.new/src/iface_record.c
--- libsepol/src/iface_record.c	2005-09-19 15:31:28.000000000 -0400
+++ libsepol.new/src/iface_record.c	2005-09-29 16:18:17.000000000 -0400
@@ -11,10 +11,10 @@
 	char* name;
 
 	/* Interface context */
-	sepol_context_t netif_con;
+	sepol_context_t* netif_con;
 
 	/* Message context */
-	sepol_context_t netmsg_con;
+	sepol_context_t* netmsg_con;
 };
 
 struct sepol_iface_key {
@@ -26,10 +26,10 @@
 /* Key */
 int sepol_iface_key_create(
 	const char* name,
-	sepol_iface_key_t* key_ptr) {
+	sepol_iface_key_t** key_ptr) {
 
-	sepol_iface_key_t tmp_key = 
-		(sepol_iface_key_t) malloc(sizeof(struct sepol_iface_key));
+	sepol_iface_key_t* tmp_key = 
+		(sepol_iface_key_t*) malloc(sizeof(sepol_iface_key_t));
 
 	if (!tmp_key) {
 		DEBUG(__FUNCTION__, "out of memory, could not create "
@@ -43,7 +43,7 @@
 	return STATUS_SUCCESS;
 }
 
-int sepol_iface_key_extract(sepol_iface_t iface, sepol_iface_key_t* key_ptr) {
+int sepol_iface_key_extract(sepol_iface_t* iface, sepol_iface_key_t** key_ptr) {
 	if (sepol_iface_key_create(iface->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from "
 			"interface %s\n", iface->name);
@@ -53,13 +53,13 @@
 	return STATUS_SUCCESS;
 }
 
-void sepol_iface_key_free(sepol_iface_key_t key) {
+void sepol_iface_key_free(sepol_iface_key_t* key) {
 	free(key);
 }
 
 int sepol_iface_compare(
-	sepol_iface_t iface, 
-	sepol_iface_key_t key) {
+	sepol_iface_t* iface, 
+	sepol_iface_key_t* key) {
 	
 	if (!strcmp(iface->name, key->name)) 
 		return 0;
@@ -67,9 +67,9 @@
 }
 
 /* Create */
-int sepol_iface_create(sepol_iface_t* iface) {
-	sepol_iface_t tmp_iface = 
-		(sepol_iface_t) malloc(sizeof(struct sepol_iface));
+int sepol_iface_create(sepol_iface_t** iface) {
+	sepol_iface_t* tmp_iface = 
+		(sepol_iface_t*) malloc(sizeof(sepol_iface_t));
 
         if (!tmp_iface) {
 		DEBUG(__FUNCTION__, "out of memory, could not create "
@@ -86,11 +86,11 @@
 }
 
 /* Name */
-const char* sepol_iface_get_name(sepol_iface_t iface) {
+const char* sepol_iface_get_name(sepol_iface_t* iface) {
 	return iface->name;
 }
 
-int sepol_iface_set_name(sepol_iface_t iface, const char* name) {
+int sepol_iface_set_name(sepol_iface_t* iface, const char* name) {
         iface->name = strdup(name);
         if (!iface->name) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -101,29 +101,29 @@
 }
 
 /* Interface Context */
-sepol_context_t sepol_iface_get_ifcon(sepol_iface_t iface) {
+sepol_context_t* sepol_iface_get_ifcon(sepol_iface_t* iface) {
 	return iface->netif_con;
 }
 
-int sepol_iface_set_ifcon(sepol_iface_t iface, sepol_context_t con) {
+int sepol_iface_set_ifcon(sepol_iface_t* iface, sepol_context_t* con) {
 	iface->netif_con = con;
 	return STATUS_SUCCESS;
 }
 
 /* Message Context */
-sepol_context_t sepol_iface_get_msgcon(sepol_iface_t iface) {
+sepol_context_t* sepol_iface_get_msgcon(sepol_iface_t* iface) {
 	return iface->netmsg_con;
 }
 
-int sepol_iface_set_msgcon(sepol_iface_t iface, sepol_context_t con) {
+int sepol_iface_set_msgcon(sepol_iface_t* iface, sepol_context_t* con) {
 	iface->netmsg_con = con;
 	return STATUS_SUCCESS;
 }
 
 /* Deep copy clone */
-int sepol_iface_clone(sepol_iface_t iface, sepol_iface_t* iface_ptr) {
+int sepol_iface_clone(sepol_iface_t* iface, sepol_iface_t** iface_ptr) {
 
-	sepol_iface_t new_iface = NULL;
+	sepol_iface_t* new_iface = NULL;
 	if (sepol_iface_create(&new_iface) < 0)
 		goto err;
 
@@ -148,7 +148,7 @@
 }
 
 /* Destroy */
-void sepol_iface_free(sepol_iface_t iface) {
+void sepol_iface_free(sepol_iface_t* iface) {
 	if (!iface)
 		return;
 
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/interfaces.c libsepol.new/src/interfaces.c
--- libsepol/src/interfaces.c	2005-09-23 20:43:05.000000000 -0400
+++ libsepol.new/src/interfaces.c	2005-09-29 16:15:41.000000000 -0400
@@ -12,10 +12,10 @@
 
 /* Create a low level interface structure from
  * a high level representation */
-static int sepol_iface_struct_create(
+int sepol_iface_struct_create(
 	policydb_t* policydb,
 	ocontext_t** iface,
-	sepol_iface_t data) {
+	sepol_iface_t* data) {
 
 	ocontext_t* tmp_iface = NULL;
 	context_struct_t* tmp_ifcon = NULL;
@@ -60,7 +60,7 @@
 /* Get the current context mapping for this interface */
 int sepol_iface_get_context(
 	policydb_t* policydb,
-	sepol_iface_t data,
+	sepol_iface_t* data,
 	char** ifcon_str, size_t* ifcon_str_len,	
 	char** msgcon_str, size_t* msgcon_str_len) {
 
@@ -93,7 +93,7 @@
 /* Load an interface into policy */
 int sepol_iface_load(
 	policydb_t* policydb, 
-	sepol_iface_t data) {
+	sepol_iface_t* data) {
 
 	ocontext_t* iface = NULL;
 	char *ifcon_str, *msgcon_str;
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/port_record.c libsepol.new/src/port_record.c
--- libsepol/src/port_record.c	2005-08-02 09:17:09.000000000 -0400
+++ libsepol.new/src/port_record.c	2005-09-29 16:18:31.000000000 -0400
@@ -13,7 +13,7 @@
 	int proto;
 
 	/* Context */
-	sepol_context_t con;
+	sepol_context_t* con;
 };
 
 struct sepol_port_key {
@@ -27,10 +27,10 @@
 /* Key */
 int sepol_port_key_create(
 	int low, int high, int proto, 
-	sepol_port_key_t* key_ptr) {
+	sepol_port_key_t** key_ptr) {
 
-	sepol_port_key_t tmp_key = 
-		(sepol_port_key_t) malloc(sizeof(struct sepol_port_key));
+	sepol_port_key_t* tmp_key = 
+		(sepol_port_key_t*) malloc(sizeof(sepol_port_key_t));
 
 	if (!tmp_key) {
 		DEBUG(__FUNCTION__, "out of memory, could not create "
@@ -46,7 +46,7 @@
 	return STATUS_SUCCESS;
 }
 
-int sepol_port_key_extract(sepol_port_t port, sepol_port_key_t* key_ptr) {
+int sepol_port_key_extract(sepol_port_t* port, sepol_port_key_t** key_ptr) {
 	if (sepol_port_key_create(
 		port->low, port->high, port->proto, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from "
@@ -58,13 +58,13 @@
 	return STATUS_SUCCESS;
 }
 
-void sepol_port_key_free(sepol_port_key_t key) {
+void sepol_port_key_free(sepol_port_key_t* key) {
 	free(key);
 }
 
 int sepol_port_compare(
-	sepol_port_t port, 
-	sepol_port_key_t key) {
+	sepol_port_t* port, 
+	sepol_port_key_t* key) {
 
 	if ((port->low <= key->low) && 
 	    (port->high >= key->high) &&
@@ -75,32 +75,32 @@
 }
 
 /* Port */
-int sepol_port_get_low(sepol_port_t port) {
+int sepol_port_get_low(sepol_port_t* port) {
 	return port->low;
 }
 
-int sepol_port_get_high(sepol_port_t port) {
+int sepol_port_get_high(sepol_port_t* port) {
 	return port->high;
 }
 
-int sepol_port_set_port(sepol_port_t port, int port_num) {
+int sepol_port_set_port(sepol_port_t* port, int port_num) {
 	port->low = port_num;
 	port->high = port_num;
 	return STATUS_SUCCESS;
 }
 
-int sepol_port_set_range(sepol_port_t port, int low, int high) {
+int sepol_port_set_range(sepol_port_t* port, int low, int high) {
 	port->low = low;
 	port->high = high;
 	return STATUS_SUCCESS;
 }
 
 /* Protocol */
-int sepol_port_get_proto(sepol_port_t port) {
+int sepol_port_get_proto(sepol_port_t* port) {
 	return port->proto;
 }
 
-const char* sepol_port_get_proto_str(sepol_port_t port) {
+const char* sepol_port_get_proto_str(sepol_port_t* port) {
 	switch (port->proto) {
 		case SEPOL_PROTO_UDP:
 			return "udp";
@@ -111,15 +111,15 @@
 	}	
 }
 
-int sepol_port_set_proto(sepol_port_t port, int proto) {
+int sepol_port_set_proto(sepol_port_t* port, int proto) {
 	port->proto = proto;
 	return STATUS_SUCCESS;
 }
 
 /* Create */
-int sepol_port_create(sepol_port_t* port) {
-	sepol_port_t tmp_port = 
-		(sepol_port_t) malloc(sizeof(struct sepol_port));
+int sepol_port_create(sepol_port_t** port) {
+	sepol_port_t* tmp_port = 
+		(sepol_port_t*) malloc(sizeof(sepol_port_t));
 
         if (!tmp_port) {
 		DEBUG(__FUNCTION__, "out of memory, could not create "
@@ -137,9 +137,9 @@
 }
 
 /* Deep copy clone */
-int sepol_port_clone(sepol_port_t port, sepol_port_t* port_ptr) {
+int sepol_port_clone(sepol_port_t* port, sepol_port_t** port_ptr) {
 
-	sepol_port_t new_port = NULL;
+	sepol_port_t* new_port = NULL;
 	if (sepol_port_create(&new_port) < 0)
 		goto err;
 
@@ -161,7 +161,7 @@
 }
 
 /* Destroy */
-void sepol_port_free(sepol_port_t port) {
+void sepol_port_free(sepol_port_t* port) {
 	if (!port)
 		return;
 	
@@ -170,11 +170,11 @@
 }
 
 /* Context */
-sepol_context_t sepol_port_get_con(sepol_port_t port) {
+sepol_context_t* sepol_port_get_con(sepol_port_t* port) {
 	return port->con;
 }
 
-int sepol_port_set_con(sepol_port_t port, sepol_context_t con) {
+int sepol_port_set_con(sepol_port_t* port, sepol_context_t* con) {
 	port->con = con;
 	return STATUS_SUCCESS;
 }
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/ports.c libsepol.new/src/ports.c
--- libsepol/src/ports.c	2005-09-23 20:42:12.000000000 -0400
+++ libsepol.new/src/ports.c	2005-09-29 16:08:34.000000000 -0400
@@ -25,10 +25,10 @@
 
 /* Create a low level port structure from
  * a high level representation */
-static int sepol_port_struct_create(
+int sepol_port_struct_create(
 	policydb_t* policydb,
 	ocontext_t** port,
-	sepol_port_t data) {
+	sepol_port_t* data) {
 
 	ocontext_t* tmp_port = NULL;
 	context_struct_t* tmp_con = NULL;
@@ -75,7 +75,7 @@
 /* Get the current context mapping for this port */
 int sepol_port_get_context(
 	policydb_t* policydb,
-	sepol_port_t data,
+	sepol_port_t* data,
 	char** con_str,	
 	size_t* con_str_len) {
 
@@ -121,7 +121,7 @@
 /* Load a port into policy */
 int sepol_port_load(
 	policydb_t* policydb, 
-	sepol_port_t data) {
+	sepol_port_t* data) {
 
 	ocontext_t* port = NULL;
 	char* dup_match;
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/user_record.c libsepol.new/src/user_record.c
--- libsepol/src/user_record.c	2005-09-28 22:50:57.000000000 -0400
+++ libsepol.new/src/user_record.c	2005-09-29 16:38:32.000000000 -0400
@@ -32,10 +32,10 @@
 
 int sepol_user_key_create(
 	const char* name,
-	sepol_user_key_t* key_ptr) {
+	sepol_user_key_t** key_ptr) {
 
-	sepol_user_key_t tmp_key = 
-		(sepol_user_key_t) malloc(sizeof (struct sepol_user_key));
+	sepol_user_key_t* tmp_key = 
+		(sepol_user_key_t*) malloc(sizeof (sepol_user_key_t));
 
 	if (!tmp_key) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -49,7 +49,7 @@
 	return STATUS_SUCCESS;
 }
 
-int sepol_user_key_extract(sepol_user_t user, sepol_user_key_t* key_ptr) {
+int sepol_user_key_extract(sepol_user_t* user, sepol_user_key_t** key_ptr) {
 	if (sepol_user_key_create(user->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from user %s\n",
 			user->name);
@@ -59,13 +59,13 @@
 	return STATUS_SUCCESS;
 }	
 
-void sepol_user_key_free(sepol_user_key_t key) {
+void sepol_user_key_free(sepol_user_key_t* key) {
 	free(key);
 }
 
 int sepol_user_compare(
-	sepol_user_t user,
-	sepol_user_key_t key) {
+	sepol_user_t* user,
+	sepol_user_key_t* key) {
 	
 	if (!strcmp(user->name, key->name))
 		return 0;
@@ -73,11 +73,11 @@
 }
 
 /* Name */
-const char* sepol_user_get_name(sepol_user_t user) {
+const char* sepol_user_get_name(sepol_user_t* user) {
 	return user->name;
 }
 
-int sepol_user_set_name(sepol_user_t user, const char* name) {
+int sepol_user_set_name(sepol_user_t* user, const char* name) {
 	user->name = strdup(name);
 	if (!user->name) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -88,11 +88,11 @@
 }
 
 /* MLS */
-const char* sepol_user_get_mlslevel(sepol_user_t user) {
+const char* sepol_user_get_mlslevel(sepol_user_t* user) {
 	return user->mls_level;
 }
 
-int sepol_user_set_mlslevel(sepol_user_t user, const char* mls_level) {
+int sepol_user_set_mlslevel(sepol_user_t* user, const char* mls_level) {
 	user->mls_level = strdup(mls_level);
 	if (!user->mls_level) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -102,11 +102,11 @@
 	return STATUS_SUCCESS;
 }
 
-const char* sepol_user_get_mlsrange(sepol_user_t user) {
+const char* sepol_user_get_mlsrange(sepol_user_t* user) {
 	return user->mls_range;
 }
 
-int sepol_user_set_mlsrange(sepol_user_t user, const char* mls_range) {
+int sepol_user_set_mlsrange(sepol_user_t* user, const char* mls_range) {
 	user->mls_range = strdup(mls_range);
 	if (!user->mls_range) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -117,15 +117,15 @@
 }
 
 /* Roles */
-int sepol_user_get_num_roles(sepol_user_t user) {
+int sepol_user_get_num_roles(sepol_user_t* user) {
 	return user->num_roles;
 }
 
-const char* sepol_user_get_defrole(sepol_user_t user) {
+const char* sepol_user_get_defrole(sepol_user_t* user) {
 	 return (user->def_role == NULL)? NULL : user->def_role;
 }
 
-int sepol_user_add_role(sepol_user_t user, const char* role) {
+int sepol_user_add_role(sepol_user_t* user, const char* role) {
 
 	char* role_cp = strdup(role);
 	char* role_cp2 = strdup(role); 
@@ -150,7 +150,7 @@
 	return STATUS_ERR;
 }
 
-int sepol_user_has_role(sepol_user_t user, const char* role) {
+int sepol_user_has_role(sepol_user_t* user, const char* role) {
 	unsigned int i;
 
 	for (i = 0; i < user->num_roles; i++)
@@ -160,7 +160,7 @@
 }
 
 int sepol_user_set_roles(
-	sepol_user_t user,
+	sepol_user_t* user,
 	const char** roles_arr,
 	size_t num_roles) {
 
@@ -196,7 +196,7 @@
 }
 
 int sepol_user_get_roles(
-	sepol_user_t user, 
+	sepol_user_t* user, 
 	const char*** roles_arr, 
 	size_t* num_roles) {
 
@@ -220,7 +220,7 @@
 	return STATUS_ERR;
 }
 
-int sepol_user_del_role(sepol_user_t user, const char* role) {
+int sepol_user_del_role(sepol_user_t* user, const char* role) {
 	unsigned int i;
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
@@ -254,7 +254,7 @@
 	return STATUS_ERR;
 }
 
-int sepol_user_set_defrole(sepol_user_t user, const char* role) {
+int sepol_user_set_defrole(sepol_user_t* user, const char* role) {
 
 	/* First, add the role if we don't have it */
 	if (!sepol_user_has_role(user, role)) {
@@ -279,9 +279,8 @@
 }
 
 /* Create */
-int sepol_user_create(sepol_user_t* user_ptr) {
-	sepol_user_t user = (sepol_user_t) 
-		malloc(sizeof (struct sepol_user));
+int sepol_user_create(sepol_user_t** user_ptr) {
+	sepol_user_t* user = (sepol_user_t*) malloc(sizeof (sepol_user_t));
 
         if (!user) {
 		DEBUG(__FUNCTION__, "out of memory, "
@@ -301,8 +300,8 @@
 }
 
 /* Deep copy clone */
-int sepol_user_clone(sepol_user_t user, sepol_user_t* user_ptr) {
-	sepol_user_t new_user = NULL;
+int sepol_user_clone(sepol_user_t* user, sepol_user_t** user_ptr) {
+	sepol_user_t* new_user = NULL;
 	unsigned int i;
 
 	if (sepol_user_create(&new_user) < 0)
@@ -337,7 +336,7 @@
 }
 
 /* Destroy */
-void sepol_user_free(sepol_user_t user) {
+void sepol_user_free(sepol_user_t* user) {
 	unsigned int i;
 
 	if (!user)
diff -Naur --exclude CVS --exclude 'users*new' --exclude VERSION --exclude ChangeLog libsepol/src/users.c libsepol.new/src/users.c
--- libsepol/src/users.c	2005-09-29 16:39:04.000000000 -0400
+++ libsepol.new/src/users.c	2005-09-29 16:10:51.000000000 -0400
@@ -81,7 +81,7 @@
 
 /* Add a user to the given policydb. The user may not exist already */
 
-int sepol_user_add(policydb_t* policydb, sepol_user_t user) {
+int sepol_user_add(policydb_t* policydb, sepol_user_t* user) {
 
 	char* name = NULL;
 	user_datum_t* usrdatum;
@@ -157,7 +157,7 @@
  * which case the supplied data replaces the existing data. Alternatively,
  * the user could be new. */
 
-int sepol_user_load(policydb_t* policydb, sepol_user_t user) {
+int sepol_user_load(policydb_t* policydb, sepol_user_t* user) {
 
 	/* For user data */	
 	const char *tmp_mlslevel, *tmp_mlsrange;

--------------060904080806060009060604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
