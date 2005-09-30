Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UEFBNs028843
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 10:15:11 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UE9QDY006050
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:09:26 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j8UE9DcT023767
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 10:09:13 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j8UE9DfM023766
	for selinux@tycho.nsa.gov; Fri, 30 Sep 2005 10:09:13 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U3DSNs023875
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:13:28 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U37bS2017547
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 03:07:37 GMT
Message-ID: <433CAE0B.4010701@cornell.edu>
Date: Thu, 29 Sep 2005 23:16:27 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 8/9 ] [ SEMANAGE ] Eliminate struct pointer typedefs
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------040806030104090501000205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040806030104090501000205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the SEMANAGE equivalent to the first patch I sent for SEPOL.
It replaces struct pointer typedefs with struct alias for consistency.

--------------040806030104090501000205
Content-Type: text/x-patch;
 name="libsemanage.07.consistency.typedefs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.07.consistency.typedefs.diff"

diff -Naru --exclude CVS libsemanage/include/semanage/boolean_record.h libsemanage.new/include/semanage/boolean_record.h
--- libsemanage/include/semanage/boolean_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new/include/semanage/boolean_record.h	2005-09-29 19:50:05.000000000 -0400
@@ -3,50 +3,50 @@
 
 struct semanage_bool; 
 struct semanage_bool_key;
-typedef struct semanage_bool* semanage_bool_t;
-typedef struct semanage_bool_key* semanage_bool_key_t;
+typedef struct semanage_bool semanage_bool_t;
+typedef struct semanage_bool_key semanage_bool_key_t;
 
 /* Key */
 extern int semanage_bool_key_create(
 	const char* name, 
-	semanage_bool_key_t* key);
+	semanage_bool_key_t** key);
 
 extern int semanage_bool_key_extract(
-	semanage_bool_t boolean, 
-	semanage_bool_key_t* key);
+	semanage_bool_t* boolean, 
+	semanage_bool_key_t** key);
 
 extern void semanage_bool_key_free(
-	semanage_bool_key_t key);
+	semanage_bool_key_t* key);
 
 extern int semanage_bool_compare(
-	semanage_bool_t boolean, 
-	semanage_bool_key_t key);
+	semanage_bool_t* boolean, 
+	semanage_bool_key_t* key);
 	
 /* Name */
 extern const char* semanage_bool_get_name(
-	semanage_bool_t boolean);
+	semanage_bool_t* boolean);
 
 extern int semanage_bool_set_name(
-	semanage_bool_t boolean, 
+	semanage_bool_t* boolean, 
 	const char* name);
 
 /* Value */
 extern int semanage_bool_get_value(
-	semanage_bool_t boolean);
+	semanage_bool_t* boolean);
 
 extern void semanage_bool_set_value(
-	semanage_bool_t boolean, 
+	semanage_bool_t* boolean, 
 	int value);
 
 /* Create/Clone/Destroy */
 extern int semanage_bool_create(
-	semanage_bool_t* bool_ptr);
+	semanage_bool_t** bool_ptr);
 
 extern int semanage_bool_clone(
-	semanage_bool_t boolean, 
-	semanage_bool_t* bool_ptr);
+	semanage_bool_t* boolean, 
+	semanage_bool_t** bool_ptr);
 
 extern void semanage_bool_free(
-	semanage_bool_t boolean);
+	semanage_bool_t* boolean);
 
 #endif
diff -Naru --exclude CVS libsemanage/include/semanage/context_record.h libsemanage.new/include/semanage/context_record.h
--- libsemanage/include/semanage/context_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new/include/semanage/context_record.h	2005-09-29 19:50:02.000000000 -0400
@@ -2,57 +2,57 @@
 #define _SEMANAGE_CONTEXT_RECORD_H_ 
 
 struct semanage_context;
-typedef struct semanage_context* semanage_context_t;
+typedef struct semanage_context semanage_context_t;
 
 /* User */
 extern const char* semanage_context_get_user(
-	semanage_context_t con);
+	semanage_context_t* con);
 
 extern int semanage_context_set_user(
-	semanage_context_t con, 
+	semanage_context_t* con, 
 	const char* user);
 
 /* Role */
 extern const char* semanage_context_get_role(
-	semanage_context_t con);
+	semanage_context_t* con);
 
 extern int semanage_context_set_role(
-	semanage_context_t con, 
+	semanage_context_t* con, 
 	const char* role);
 
 /* Type */
 extern const char* semanage_context_get_type(
-	semanage_context_t con);
+	semanage_context_t* con);
 
 extern int semanage_context_set_type(
-	semanage_context_t con, 
+	semanage_context_t* con, 
 	const char* type);
 
 /* MLS */
 extern const char* semanage_context_get_mls(
-	semanage_context_t con);
+	semanage_context_t* con);
 
 extern int semanage_context_set_mls(
-	semanage_context_t con, 
+	semanage_context_t* con, 
 	const char* mls_range);
 
 /* Create/Clone/Destroy */
 extern int semanage_context_create(
-	semanage_context_t* con_ptr);
+	semanage_context_t** con_ptr);
 
 extern int semanage_context_clone(
-	semanage_context_t con, 
-	semanage_context_t* con_ptr);
+	semanage_context_t* con, 
+	semanage_context_t** con_ptr);
 
 extern void semanage_context_free(
-	semanage_context_t con);
+	semanage_context_t* con);
 	
 /* Parse to/from string */
 extern int semanage_context_from_string(
 	const char* str, 
-	semanage_context_t* con);
+	semanage_context_t** con);
 
 extern char* semanage_context_to_string(
-	semanage_context_t con);
+	semanage_context_t* con);
 
 #endif 
diff -Naru --exclude CVS libsemanage/include/semanage/iface_record.h libsemanage.new/include/semanage/iface_record.h
--- libsemanage/include/semanage/iface_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new/include/semanage/iface_record.h	2005-09-29 19:52:17.000000000 -0400
@@ -5,57 +5,57 @@
 
 struct semanage_iface;
 struct semanage_iface_key;
-typedef struct semanage_iface* semanage_iface_t;
-typedef struct semanage_iface_key* semanage_iface_key_t;
+typedef struct semanage_iface semanage_iface_t;
+typedef struct semanage_iface_key semanage_iface_key_t;
 
 /* Key */
 extern int semanage_iface_compare(
-	semanage_iface_t iface, 
-	semanage_iface_key_t key);
+	semanage_iface_t* iface, 
+	semanage_iface_key_t* key);
 
 extern int semanage_iface_key_create(
 	const char* name,
-	semanage_iface_key_t* key_ptr);
+	semanage_iface_key_t** key_ptr);
 
 extern int semanage_iface_key_extract(
-	semanage_iface_t iface,
-	semanage_iface_key_t* key_ptr);
+	semanage_iface_t* iface,
+	semanage_iface_key_t** key_ptr);
 
 extern void semanage_iface_key_free(
-	semanage_iface_key_t key);
+	semanage_iface_key_t* key);
 
 /* Name */
 extern const char* semanage_iface_get_name(
-	semanage_iface_t iface);
+	semanage_iface_t* iface);
 
 extern int semanage_iface_set_name(
 	semanage_user_t iface, 
 	const char* name);
 
 /* Context */
-extern semanage_context_t semanage_iface_get_ifcon(
-	semanage_iface_t iface);
+extern semanage_context_t* semanage_iface_get_ifcon(
+	semanage_iface_t* iface);
 
 extern int semanage_iface_set_ifcon(
-	semanage_iface_t iface, 
-	semanage_context_t con);
+	semanage_iface_t* iface, 
+	semanage_context_t* con);
 
-extern semanage_context_t semanage_iface_get_msgcon(
-	semanage_iface_t iface);
+extern semanage_context_t* semanage_iface_get_msgcon(
+	semanage_iface_t* iface);
 
 extern int semanage_iface_set_msgcon(
-	semanage_iface_t iface, 
-	semanage_context_t con);
+	semanage_iface_t* iface, 
+	semanage_context_t* con);
 
 /* Create/Clone/Destroy */
 extern int semanage_iface_create(
-	semanage_iface_t* iface_ptr);
+	semanage_iface_t** iface_ptr);
 
 extern int semanage_iface_clone(
-	semanage_iface_t iface, 
-	semanage_iface_t* iface_ptr);
+	semanage_iface_t* iface, 
+	semanage_iface_t** iface_ptr);
 
 extern void semanage_iface_free(
-	semanage_iface_t iface);
+	semanage_iface_t* iface);
 
 #endif
diff -Naru --exclude CVS libsemanage/include/semanage/port_record.h libsemanage.new/include/semanage/port_record.h
--- libsemanage/include/semanage/port_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new/include/semanage/port_record.h	2005-09-29 19:56:21.000000000 -0400
@@ -5,72 +5,72 @@
 
 struct semanage_port;
 struct semanage_port_key;
-typedef struct semanage_port* semanage_port_t;
-typedef struct semanage_port_key* semanage_port_key_t;
+typedef struct semanage_port semanage_port_t;
+typedef struct semanage_port_key semanage_port_key_t;
 
-#define SEMANAGE_PROTO_UDP SEPOL_PROTO_UDP
-#define SEMANAGE_PROTO_TCP SEPOL_PROTO_TCP
+#define SEMANAGE_PROTO_UDP 0 
+#define SEMANAGE_PROTO_TCP 1
 
 /* Key */
 extern int semanage_port_compare(
-	semanage_port_t port, 
-	semanage_port_key_t key);
+	semanage_port_t* port, 
+	semanage_port_key_t* key);
 
 extern int semanage_port_key_create(
 	int low, int high, 
 	int proto, 
-	semanage_port_key_t* key_ptr);
+	semanage_port_key_t** key_ptr);
 
 extern int semanage_port_key_extract(
-	semanage_port_t port,
-	semanage_port_key_t* key_ptr);
+	semanage_port_t* port,
+	semanage_port_key_t** key_ptr);
 
 extern void semanage_port_key_free(
-	semanage_port_key_t key);
+	semanage_port_key_t* key);
 
 /* Protocol */
 extern int semanage_port_get_proto(
-	semanage_port_t port);
+	semanage_port_t* port);
 
 extern int semanage_port_set_proto(
-	semanage_port_t port, 
+	semanage_port_t* port, 
 	int proto);
 
 extern const char* semanage_port_get_proto_str(
-	semanage_port_t port);
+	semanage_port_t* port);
 
 /* Port */
 extern int semanage_port_get_low(
-	semanage_port_t port);
+	semanage_port_t* port);
 
 extern int semanage_port_get_high(
-	semanage_port_t port);
+	semanage_port_t* port);
 
 extern int semanage_port_set_port(
-	semanage_port_t port, 
+	semanage_port_t* port, 
 	int port_num);
 
 extern int semanage_port_set_range(
-	semanage_port_t port, 
+	semanage_port_t* port, 
 	int low, int high);
 
 /* Context */
-extern semanage_context_t semanage_port_get_con(
-	semanage_port_t port);
+extern semanage_context_t* semanage_port_get_con(
+	semanage_port_t* port);
 
 extern int semanage_port_set_con(
-	semanage_port_t port, 
-	semanage_context_t con);
+	semanage_port_t* port, 
+	semanage_context_t* con);
 
 /* Create/Clone/Destroy */
 extern int semanage_port_create(
-	semanage_port_t* port_ptr);
+	semanage_port_t** port_ptr);
 
 extern int semanage_port_clone(
-	semanage_port_t port, 
-	semanage_port_t* port_ptr);
+	semanage_port_t* port, 
+	semanage_port_t** port_ptr);
 
 extern void semanage_port_free(
-	semanage_port_t port);
+	semanage_port_t* port);
 
 #endif
diff -Naru --exclude CVS libsemanage/include/semanage/ports.h libsemanage.new/include/semanage/ports.h
--- libsemanage/include/semanage/ports.h	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new/include/semanage/ports.h	2005-09-29 19:55:09.000000000 -0400
@@ -7,26 +7,26 @@
 
 extern int semanage_port_add(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data);
+	semanage_port_key_t* key,
+	semanage_port_t* data);
 
 extern int semanage_port_modify(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data);
+	semanage_port_key_t* key,
+	semanage_port_t* data);
 
 extern int semanage_port_del(
 	semanage_handle_t* handle,
-	semanage_port_key_t key);
+	semanage_port_key_t* key);
 
 extern int semanage_port_query(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t* response);
+	semanage_port_key_t* key,
+	semanage_port_t** response);
 
 extern int semanage_port_exists(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
+	semanage_port_key_t* key,
 	int* response);
 
 extern int semanage_port_count(
@@ -35,13 +35,13 @@
 
 extern int semanage_port_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t record,
+	int (*handler) (semanage_port_t* record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list(
 	semanage_handle_t* handle,
-	semanage_port_t** records,
+	semanage_port_t*** records,
 	size_t* count);
 
 #endif 
diff -Naru --exclude CVS libsemanage/include/semanage/user_record.h libsemanage.new/include/semanage/user_record.h
--- libsemanage/include/semanage/user_record.h	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/include/semanage/user_record.h	2005-09-29 19:53:37.000000000 -0400
@@ -5,89 +5,89 @@
 
 struct semanage_user;
 struct semanage_user_key;
-typedef struct semanage_user* semanage_user_t;
-typedef struct semanage_user_key* semanage_user_key_t;
+typedef struct semanage_user semanage_user_t;
+typedef struct semanage_user_key semanage_user_key_t;
 
 /* Key */
 extern int semanage_user_key_create(
 	const char* name, 
-	semanage_user_key_t* key);
+	semanage_user_key_t** key);
 
 extern int semanage_user_key_extract(
-	semanage_user_t user, 
-	semanage_user_key_t* key);
+	semanage_user_t* user, 
+	semanage_user_key_t** key);
 
 extern void semanage_user_key_free(
-	semanage_user_key_t key);
+	semanage_user_key_t* key);
 
 extern int semanage_user_compare(
-	semanage_user_t user, 
-	semanage_user_key_t key);
+	semanage_user_t* user, 
+	semanage_user_key_t* key);
 	
 /* Name */
 extern const char* semanage_user_get_name(
-	semanage_user_t user);
+	semanage_user_t* user);
 
 extern int semanage_user_set_name(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* name);
 
 /* MLS */
 extern const char* semanage_user_get_mlslevel(
-	semanage_user_t user);
+	semanage_user_t* user);
 
 extern int semanage_user_set_mlslevel(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* mls_level);
 
 extern const char* semanage_user_get_mlsrange(
-	semanage_user_t user);
+	semanage_user_t* user);
 
 extern int semanage_user_set_mlsrange(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* mls_range);
 
 /* Role management */
 extern int semanage_user_get_num_roles(
-	semanage_user_t user);
+	semanage_user_t* user);
 
 extern const char* semanage_user_get_defrole(
-	semanage_user_t user);
+	semanage_user_t* user);
 
 extern int semanage_user_add_role(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* role);
 
 extern int semanage_user_del_role(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* role);
 
 extern int semanage_user_has_role(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* role);
 
 extern int semanage_user_set_defrole(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	const char* role);
 
 extern int semanage_user_get_roles(
-	semanage_user_t user,
+	semanage_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles);
 
 extern int semanage_user_set_roles(
-	semanage_user_t user,
+	semanage_user_t* user,
 	const char** roles_arr,
 	size_t num_roles);
 
 /* Create/Clone/Destroy */
 extern int semanage_user_create(
-	semanage_user_t* user_ptr);
+	semanage_user_t** user_ptr);
 
 extern int semanage_user_clone(
-	semanage_user_t user, 
-	semanage_user_t* user_ptr);
+	semanage_user_t* user, 
+	semanage_user_t** user_ptr);
 
 extern void semanage_user_free(
-	semanage_user_t user);
+	semanage_user_t* user);
 #endif
diff -Naru --exclude CVS libsemanage/include/semanage/users.h libsemanage.new/include/semanage/users.h
--- libsemanage/include/semanage/users.h	2005-09-29 18:34:10.000000000 -0400
+++ libsemanage.new/include/semanage/users.h	2005-09-29 19:54:22.000000000 -0400
@@ -7,26 +7,26 @@
 
 extern int semanage_user_add(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data);
+	semanage_user_key_t* key,
+	semanage_user_t* data);
 
 extern int semanage_user_modify(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data);
+	semanage_user_key_t* key,
+	semanage_user_t* data);
 
 extern int semanage_user_del(
 	semanage_handle_t* handle,
-	semanage_user_key_t key);
+	semanage_user_key_t* key);
 
 extern int semanage_user_query(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t* response);
+	semanage_user_key_t* key,
+	semanage_user_t** response);
 
 extern int semanage_user_exists(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
+	semanage_user_key_t* key,
 	int* response);
 
 extern int semanage_user_count(
@@ -35,13 +35,13 @@
 
 extern int semanage_user_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t record,
+	int (*handler) (semanage_user_t* record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list(
 	semanage_handle_t* handle,
-	semanage_user_t** records,
+	semanage_user_t*** records,
 	size_t* count);
 
 #endif 
diff -Naru --exclude CVS libsemanage/src/boolean_record.c libsemanage.new/src/boolean_record.c
--- libsemanage/src/boolean_record.c	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/src/boolean_record.c	2005-09-29 19:34:45.000000000 -0400
@@ -1,52 +1,78 @@
 #include <sepol/boolean_record.h>
 
-typedef sepol_bool_t* semanage_bool_t;
-typedef sepol_bool_key_t* semanage_bool_key_t;
+typedef sepol_bool_t semanage_bool_t;
+typedef sepol_bool_key_t semanage_bool_key_t;
 
 /* Key */
-int semanage_bool_key_create(const char* name, semanage_bool_key_t* key) {
+int semanage_bool_key_create(
+	const char* name, 
+	semanage_bool_key_t** key) {
+
 	return sepol_bool_key_create(name, key);
 }
 
-int semanage_bool_key_extract(semanage_bool_t boolean, semanage_bool_key_t* key) {
+int semanage_bool_key_extract(
+	semanage_bool_t* boolean, 
+	semanage_bool_key_t** key) {
+
 	return sepol_bool_key_extract(boolean, key);
 }
 
-void semanage_bool_key_free(semanage_bool_key_t key) {
+void semanage_bool_key_free(semanage_bool_key_t* key) {
 	sepol_bool_key_free(key);
 }
 
-int semanage_bool_compare(semanage_bool_t boolean, semanage_bool_key_t key) {
+int semanage_bool_compare(
+	semanage_bool_t* boolean, 
+	semanage_bool_key_t* key) {
+
 	return sepol_bool_compare(boolean, key);
 }
 	
 /* Name */
-const char* semanage_bool_get_name(semanage_bool_t boolean) {
+const char* semanage_bool_get_name(
+	semanage_bool_t* boolean) {
+
 	return sepol_bool_get_name(boolean);
 }
 
-int semanage_bool_set_name(semanage_bool_t boolean, const char* name) {
+int semanage_bool_set_name(
+	semanage_bool_t* boolean, 
+	const char* name) {
+
 	return sepol_bool_set_name(boolean, name);
 }
 
 /* Value */
-int semanage_bool_get_value(semanage_bool_t boolean) {
+int semanage_bool_get_value(
+	semanage_bool_t* boolean) {
+
 	return sepol_bool_get_value(boolean);
 }
 
-void semanage_bool_set_value(semanage_bool_t boolean, int value) {
+void semanage_bool_set_value(
+	semanage_bool_t* boolean, 
+	int value) {
+
 	sepol_bool_set_value(boolean, value);
 }
 
 /* Create/Clone/Destroy */
-int semanage_bool_create(semanage_bool_t* bool_ptr) {
+int semanage_bool_create(
+	semanage_bool_t** bool_ptr) {
+
 	return sepol_bool_create(bool_ptr);
 }
 
-int semanage_bool_clone(semanage_bool_t boolean, semanage_bool_t* bool_ptr) {
+int semanage_bool_clone(
+	semanage_bool_t* boolean, 
+	semanage_bool_t** bool_ptr) {
+
 	return sepol_bool_clone(boolean, bool_ptr);
 }
 
-void semanage_bool_free(semanage_bool_t boolean) {
+void semanage_bool_free(
+	semanage_bool_t* boolean) {
+
 	sepol_bool_free(boolean);
 }
diff -Naru --exclude CVS libsemanage/src/context_record.c libsemanage.new/src/context_record.c
--- libsemanage/src/context_record.c	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/src/context_record.c	2005-09-29 19:27:31.000000000 -0400
@@ -1,61 +1,61 @@
 #include <sepol/context_record.h>
 
-typedef sepol_context_t* semanage_context_t;
+typedef sepol_context_t semanage_context_t;
 
 /* User */
-const char* semanage_context_get_user(semanage_context_t con) {
+const char* semanage_context_get_user(semanage_context_t* con) {
 	return sepol_context_get_user(con);
 }
 
-int semanage_context_set_user(semanage_context_t con, const char* user) {
+int semanage_context_set_user(semanage_context_t* con, const char* user) {
 	return sepol_context_set_user(con, user);
 }
 
 /* Role */
-const char* semanage_context_get_role(semanage_context_t con) {
+const char* semanage_context_get_role(semanage_context_t* con) {
 	return sepol_context_get_role(con);
 }
 
-int semanage_context_set_role(semanage_context_t con, const char* role) {
+int semanage_context_set_role(semanage_context_t* con, const char* role) {
 	return sepol_context_set_role(con, role);
 }
 
 /* Type */
-const char* semanage_context_get_type(semanage_context_t con) {
+const char* semanage_context_get_type(semanage_context_t* con) {
 	return sepol_context_get_type(con);
 }
 
-int semanage_context_set_type(semanage_context_t con, const char* type) {
+int semanage_context_set_type(semanage_context_t* con, const char* type) {
 	return sepol_context_set_type(con, type);
 }
 
 /* MLS */
-const char* semanage_context_get_mls(semanage_context_t con) {
+const char* semanage_context_get_mls(semanage_context_t* con) {
 	return sepol_context_get_mls(con);
 }
 
-int semanage_context_set_mls(semanage_context_t con, const char* mls_range) {
+int semanage_context_set_mls(semanage_context_t* con, const char* mls_range) {
 	return sepol_context_set_mls(con, mls_range);
 }
 
 /* Create/Clone/Destroy */
-int semanage_context_create(semanage_context_t* con_ptr) {
+int semanage_context_create(semanage_context_t** con_ptr) {
 	return sepol_context_create(con_ptr);
 }
 
-int semanage_context_clone(semanage_context_t con, semanage_context_t* con_ptr) {
+int semanage_context_clone(semanage_context_t* con, semanage_context_t** con_ptr) {
 	return sepol_context_clone(con, con_ptr);
 }
 
-void semanage_context_free(semanage_context_t con) {
+void semanage_context_free(semanage_context_t* con) {
 	sepol_context_free(con);
 }
 	
 /* Parse to/from string */
-int semanage_context_from_string(const char* str, semanage_context_t* con) {
+int semanage_context_from_string(const char* str, semanage_context_t** con) {
 	return sepol_context_from_string(str, con);
 }
 
-char* semanage_context_to_string(semanage_context_t con) {
+char* semanage_context_to_string(semanage_context_t* con) {
 	return sepol_context_to_string(con);
 }
diff -Naru --exclude CVS libsemanage/src/database.c libsemanage.new/src/database.c
--- libsemanage/src/database.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/database.c	2005-09-29 19:59:38.000000000 -0400
@@ -69,7 +69,7 @@
 
 int dbase_cache_add(
 	dbase_t* dbase,
-	record_t data) {
+	record_t* data) {
 
 	cache_entry_t* entry = 
 		(cache_entry_t*) malloc(sizeof (cache_entry_t));
@@ -88,7 +88,7 @@
 
 static int dbase_cache_locate(
 	dbase_t* dbase,
-	record_key_t key,
+	record_key_t* key,
 	cache_entry_t** entry) {
 	
 	cache_entry_t* ptr;
@@ -112,8 +112,8 @@
 int dbase_add(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t data) {
+	record_key_t* key,
+	record_t* data) {
 
 	int exists;
 
@@ -142,8 +142,8 @@
 int dbase_modify(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t data) {
+	record_key_t* key,
+	record_t* data) {
 
 	cache_entry_t* entry;
 	int status;
@@ -170,7 +170,7 @@
 int dbase_del(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key) {
+	record_key_t* key) {
 
 	cache_entry_t *ptr, *prev = NULL;
 
@@ -203,8 +203,8 @@
 int dbase_query(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t* response) {
+	record_key_t* key,
+	record_t** response) {
 
 	cache_entry_t* entry;
 	int status;
@@ -216,7 +216,7 @@
 	if (status < 0 || status == STATUS_NODATA)
 		goto err;
 
-	if (dbase->rtable->clone(entry->data, *response) < 0)
+	if (dbase->rtable->clone(entry->data, response) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -229,7 +229,7 @@
 int dbase_exists(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
+	record_key_t* key,
 	int* response) {
 
 	cache_entry_t* entry;
@@ -271,7 +271,7 @@
 int dbase_iterate(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	int (*fn) (record_t record, void* varg),
+	int (*fn) (record_t* record, void* varg),
 	void* fn_arg) {
 
 	int status;	
@@ -300,11 +300,11 @@
 int dbase_list(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_t** records,	
+	record_t*** records,	
 	size_t* count) {
 
 	cache_entry_t* ptr;
-	record_t* tmp_records = NULL;
+	record_t** tmp_records = NULL;
 	size_t tmp_count;
 	int i = 0;
 	
@@ -314,7 +314,8 @@
 	tmp_count = dbase->cache_sz;
 
 	if (tmp_count > 0) {
-		tmp_records = (record_t*) calloc(tmp_count, sizeof (record_t));
+		tmp_records = (record_t**) 
+			calloc(tmp_count, sizeof (record_t*));
 		if (tmp_records == NULL) 
 			goto omem;			
 	
diff -Naru --exclude CVS libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-29 19:58:50.000000000 -0400
@@ -50,7 +50,7 @@
 	int perr_fatal = 0;
 	/* FIXME: pass from caller? */
 
-	record_t process_record = NULL;
+	record_t* process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 	parse_info_t parse_info;
 	parse_info.filename = backend->filename;
diff -Naru --exclude CVS libsemanage/src/database.h libsemanage.new/src/database.h
--- libsemanage/src/database.h	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/database.h	2005-09-29 19:57:21.000000000 -0400
@@ -23,7 +23,7 @@
 
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
-        record_t data;
+        record_t* data;
         struct cache_entry* next;
 } cache_entry_t;
 
@@ -49,7 +49,7 @@
 /* Add a record to the database cache */
 extern int dbase_cache_add(
 	dbase_t* dbase,
-	record_t data);
+	record_t* data);
 
 /* ======================================
    API for use elsewhere:
@@ -84,30 +84,30 @@
 extern int dbase_add(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t data);
+	record_key_t* key,
+	record_t* data);
 
 extern int dbase_modify(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t data);
+	record_key_t* key,
+	record_t* data);
 
 extern int dbase_del(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key);
+	record_key_t* key);
 
 extern int dbase_query(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
-	record_t* response);
+	record_key_t* key,
+	record_t** response);
 
 extern int dbase_exists(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_key_t key,
+	record_key_t* key,
 	int* response);
 
 extern int dbase_count(
@@ -118,14 +118,14 @@
 extern int dbase_iterate(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	int (*fn) (record_t record,
+	int (*fn) (record_t* record,
 	           void* varg),
 	void* fn_arg);
 
 extern int dbase_list(
 	semanage_handle_t* handle,
 	dbase_t* dbase,
-	record_t** records,	
+	record_t*** records,	
 	size_t* count);
 
 #endif 
diff -Naru --exclude CVS libsemanage/src/iface_record.c libsemanage.new/src/iface_record.c
--- libsemanage/src/iface_record.c	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/src/iface_record.c	2005-09-29 19:38:07.000000000 -0400
@@ -1,65 +1,92 @@
 #include <sepol/iface_record.h>
 
-typedef sepol_context_t* semanage_context_t;
-typedef sepol_iface_t* semanage_iface_t;
-typedef sepol_iface_key_t* semanage_iface_key_t;
+typedef sepol_context_t semanage_context_t;
+typedef sepol_iface_t semanage_iface_t;
+typedef sepol_iface_key_t semanage_iface_key_t;
 
 /* Key */
-int semanage_iface_compare(semanage_iface_t iface, semanage_iface_key_t key) {
+int semanage_iface_compare(
+	semanage_iface_t* iface, 
+	semanage_iface_key_t* key) {
+
 	return sepol_iface_compare(iface, key);
 }
 
 int semanage_iface_key_create(
 	const char* name,
-	semanage_iface_key_t* key_ptr) {
+	semanage_iface_key_t** key_ptr) {
+
 	return sepol_iface_key_create(name, key_ptr);
 }
 
 int semanage_iface_key_extract(
-	semanage_iface_t iface,
-	semanage_iface_key_t* key_ptr) {
+	semanage_iface_t* iface,
+	semanage_iface_key_t** key_ptr) {
+
 	return sepol_iface_key_extract(iface, key_ptr);
 }
 
-void semanage_iface_key_free(semanage_iface_key_t key) {
+void semanage_iface_key_free(
+	semanage_iface_key_t* key) {
 	sepol_iface_key_free(key);
 }
 
 /* Name */
-const char* semanage_iface_get_name(semanage_iface_t iface) {
+const char* semanage_iface_get_name(
+	semanage_iface_t* iface) {
+
         return sepol_iface_get_name(iface);
 }
 
-int semanage_iface_set_name(semanage_iface_t iface, const char* name) {
+int semanage_iface_set_name(
+	semanage_iface_t* iface, 
+	const char* name) {
+
         return sepol_iface_set_name(iface, name);
 }
 	
 /* Context */
-semanage_context_t semanage_iface_get_ifcon(semanage_iface_t iface) {
+semanage_context_t* semanage_iface_get_ifcon(
+	semanage_iface_t* iface) {
+
 	return sepol_iface_get_ifcon(iface);
 }
 
-int semanage_iface_set_ifcon(semanage_iface_t iface, semanage_context_t con) {
+int semanage_iface_set_ifcon(
+	semanage_iface_t* iface, 
+	semanage_context_t* con) {
+
 	return sepol_iface_set_ifcon(iface, con);
 }
 
-semanage_context_t semanage_iface_get_msgcon(semanage_iface_t iface) {
+semanage_context_t* semanage_iface_get_msgcon(
+	semanage_iface_t* iface) {
+
 	return sepol_iface_get_msgcon(iface);	
 }
 
-int semanage_iface_set_msgcon(semanage_iface_t iface, semanage_context_t con) {
+int semanage_iface_set_msgcon(
+	semanage_iface_t* iface, semanage_context_t* con) {
+
 	return sepol_iface_set_msgcon(iface, con);
 }
 
 /* Create/Clone/Destroy */
-int semanage_iface_create(semanage_iface_t* iface_ptr) {
+int semanage_iface_create(
+	semanage_iface_t** iface_ptr) {
+
 	return sepol_iface_create(iface_ptr);
 }
 
-int semanage_iface_clone(semanage_iface_t iface, semanage_iface_t* iface_ptr) {
+int semanage_iface_clone(
+	semanage_iface_t* iface, 
+	semanage_iface_t** iface_ptr) {
+
 	return sepol_iface_clone(iface, iface_ptr);
 }
 
-void semanage_iface_free(semanage_iface_t iface) {
+void semanage_iface_free(
+	semanage_iface_t* iface) {
+
 	sepol_iface_free(iface);
 }
diff -Naru --exclude CVS libsemanage/src/interfaces.h libsemanage.new/src/interfaces.h
--- libsemanage/src/interfaces.h	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/interfaces.h	2005-09-29 18:58:45.000000000 -0400
@@ -37,24 +37,24 @@
 typedef struct record_table {
 
 	/* Create a record */
-	int (*create) (record_t* rec);
+	int (*create) (record_t** rec);
 
 	/* Extract key from record */
-	int (*key_extract) (record_t rec, record_key_t* key);
+	int (*key_extract) (record_t* rec, record_key_t** key);
 	
 	/* Free record key */
-	void (*key_free) (record_key_t key);
+	void (*key_free) (record_key_t* key);
 
 	/* Return 0 if record can be matched against key,
 	 * and 1 otherwise */
-	int (*compare) (record_t rec, record_key_t key);
+	int (*compare) (record_t* rec, record_key_t* key);
 
 	/* Deep-copy clone of this record */
-	int (*clone) (record_t rec, record_t* new_rec);
+	int (*clone) (record_t* rec, record_t** new_rec);
 
 	/* Deallocate record resources. Must
 	 * sucessfully handle NULL. */
-	void (*free) (record_t rec);
+	void (*free) (record_t* rec);
 
 } record_table_t;
 
@@ -64,10 +64,10 @@
 	/* Fill record structuure based on supplied parse info.
 	 * Parser must return STATUS_NODATA when EOF is encountered.
 	 * Parser must handle NULL file stream correctly */
-	int (*parse) (parse_info_t* info, record_t record);
+	int (*parse) (parse_info_t* info, record_t* record);
 
 	/* Print record to stream */
-	int (*print) (record_t record, FILE* str);
+	int (*print) (record_t* record, FILE* str);
 
 } record_file_table_t;
 
@@ -75,10 +75,10 @@
 typedef struct record_direct_table {
 
 	/* Load record into policy store */
-	int (*load) (policydb_t* policy, record_t record); 
+	int (*load) (policydb_t* policy, record_t* record); 
 
 	/* Extract records from policy store */
-	int (*list) (policydb_t* policy, record_t** records, size_t* nrecords);
+	int (*list) (policydb_t* policy, record_t*** records, size_t* nrecords);
 
 } record_direct_table_t;
 
diff -Naru --exclude CVS libsemanage/src/port_record.c libsemanage.new/src/port_record.c
--- libsemanage/src/port_record.c	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/src/port_record.c	2005-09-29 19:37:50.000000000 -0400
@@ -1,78 +1,114 @@
 #include <sepol/port_record.h>
 
-typedef sepol_context_t* semanage_context_t;
-typedef sepol_port_t* semanage_port_t;
-typedef sepol_port_key_t* semanage_port_key_t;
+typedef sepol_context_t semanage_context_t;
+typedef sepol_port_t semanage_port_t;
+typedef sepol_port_key_t semanage_port_key_t;
 
 /* Key */
-int semanage_port_compare(semanage_port_t port, semanage_port_key_t key) {
+int semanage_port_compare(
+	semanage_port_t* port, 
+	semanage_port_key_t* key) {
+
 	return sepol_port_compare(port, key);
 }
 
 int semanage_port_key_create(
 	int low, int high, int proto, 
-	semanage_port_key_t* key_ptr) {
+	semanage_port_key_t** key_ptr) {
+
 	return sepol_port_key_create(low, high, proto, key_ptr);
 }
 
 int semanage_port_key_extract(
-	semanage_port_t port,
-	semanage_port_key_t* key_ptr) {
+	semanage_port_t* port,
+	semanage_port_key_t** key_ptr) {
+
 	return sepol_port_key_extract(port, key_ptr);
 }
 
-void semanage_port_key_free(semanage_port_key_t key) {
+void semanage_port_key_free(
+	semanage_port_key_t* key) {
+
 	sepol_port_key_free(key);
 }	
 
 /* Protocol */
-int semanage_port_get_proto(semanage_port_t port) {
+int semanage_port_get_proto(
+	semanage_port_t* port) {
+
 	return sepol_port_get_proto(port);
 }
 
-int semanage_port_set_proto(semanage_port_t port, int proto) {
+int semanage_port_set_proto(
+	semanage_port_t* port, 
+	int proto) {
+
 	return sepol_port_set_proto(port, proto);
 }
 
-const char* semanage_port_get_proto_str(semanage_port_t port) {
+const char* semanage_port_get_proto_str(
+	semanage_port_t* port) {
+
 	return sepol_port_get_proto_str(port);
 }
 
 /* Port */
-int semanage_port_get_low(semanage_port_t port) {
+int semanage_port_get_low(
+	semanage_port_t* port) {
+
 	return sepol_port_get_low(port);
 }
 
-int semanage_port_get_high(semanage_port_t port) {
+int semanage_port_get_high(
+	semanage_port_t* port) {
+
 	return sepol_port_get_high(port);
 }
 
-int semanage_port_set_port(semanage_port_t port, int port_num) {
+int semanage_port_set_port(
+	semanage_port_t* port, 
+	int port_num) {
+
 	return sepol_port_set_port(port, port_num);
 }
 
-int semanage_port_set_range(semanage_port_t port, int low, int high) {
+int semanage_port_set_range(
+	semanage_port_t* port, 
+	int low, int high) {
+
 	return sepol_port_set_range(port, low, high);
 }
 
 /* Context */
-semanage_context_t semanage_port_get_con(semanage_port_t port) {
+semanage_context_t* semanage_port_get_con(
+	semanage_port_t* port) {
+
 	return sepol_port_get_con(port);	
 }
 
-int semanage_port_set_con(semanage_port_t port, semanage_context_t con) {
+int semanage_port_set_con(
+	semanage_port_t* port, 
+	semanage_context_t* con) {
+
 	return sepol_port_set_con(port, con);
 }
 
 /* Create/Clone/Destroy */
-int semanage_port_create(semanage_port_t* port_ptr) {
+int semanage_port_create(
+	semanage_port_t** port_ptr) {
+
 	return sepol_port_create(port_ptr);
 }
 
-int semanage_port_clone(semanage_port_t port, semanage_port_t* port_ptr) {
+int semanage_port_clone(
+	semanage_port_t* port, 
+	semanage_port_t** port_ptr) {
+
 	return sepol_port_clone(port, port_ptr);
 }
 
-void semanage_port_free(semanage_port_t port) {
+void semanage_port_free(
+	semanage_port_t* port) {
+
 	sepol_port_free(port);
 }
diff -Naru --exclude CVS libsemanage/src/ports.c libsemanage.new/src/ports.c
--- libsemanage/src/ports.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/ports.c	2005-09-29 19:39:02.000000000 -0400
@@ -27,8 +27,8 @@
 
 int semanage_port_add(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data) {
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
 
 	dbase_t* dbase = semanage_port_dbase(handle);	
 	return dbase_add(handle, dbase, key, data);
@@ -36,8 +36,8 @@
 
 int semanage_port_modify(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data) {
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
 	
 	dbase_t* dbase = semanage_port_dbase(handle);
 	return dbase_modify(handle, dbase, key, data);
@@ -45,7 +45,7 @@
 
 int semanage_port_del(
 	semanage_handle_t* handle,
-	semanage_port_key_t key) {
+	semanage_port_key_t* key) {
 
 	dbase_t* dbase = semanage_port_dbase(handle);
 	return dbase_del(handle, dbase, key);
@@ -53,8 +53,8 @@
 
 int semanage_port_query(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t* response) {
+	semanage_port_key_t* key,
+	semanage_port_t** response) {
 
 	dbase_t* dbase = semanage_port_dbase(handle);
 	return dbase_query(handle, dbase, key, response);
@@ -62,7 +62,7 @@
 
 int semanage_port_exists(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
+	semanage_port_key_t* key,
 	int* response) {
 
 	dbase_t* dbase = semanage_port_dbase(handle);
@@ -79,7 +79,7 @@
 
 int semanage_port_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t record,
+	int (*handler) (semanage_port_t* record,
 	                void* varg),
 	void* handler_arg) {
 
@@ -89,7 +89,7 @@
 
 int semanage_port_list(
 	semanage_handle_t* handle,
-	semanage_port_t** records,
+	semanage_port_t*** records,
 	size_t* count) {
 
 	dbase_t* dbase = semanage_port_dbase(handle);
diff -Naru --exclude CVS libsemanage/src/ports_direct.c libsemanage.new/src/ports_direct.c
--- libsemanage/src/ports_direct.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/ports_direct.c	2005-09-29 19:57:57.000000000 -0400
@@ -3,8 +3,8 @@
  */
 #include <sepol/port_record.h>
 
-typedef sepol_port_t* record_t;
-typedef sepol_port_key_t* record_key_t;
+typedef sepol_port_t record_t;
+typedef sepol_port_key_t record_key_t;
 #define RECORD_DEFINED
 
 struct dbase_direct_backend;
diff -Naru --exclude CVS libsemanage/src/ports_file.c libsemanage.new/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/ports_file.c	2005-09-29 19:40:14.000000000 -0400
@@ -15,7 +15,7 @@
 #include "debug.h"
 
 static int port_print(
-	semanage_port_t port, 
+	semanage_port_t* port, 
 	FILE* str) {
 
 	/* Stub */
@@ -26,7 +26,7 @@
 
 static int port_parse(
 	parse_info_t* info, 
-	semanage_port_t port) {
+	semanage_port_t* port) {
 
 	/* Stub */
 	info = NULL;
@@ -49,7 +49,8 @@
 
 	if (dbase_file_init(
 		NULL, /* FIXME */
-		&SEMANAGE_PORT_FILE_RTABLE, &backend) < 0)
+		&SEMANAGE_PORT_FILE_RTABLE, 
+		&backend) < 0)
 		return STATUS_ERR;
 
 	return dbase_init(
diff -Naru --exclude CVS libsemanage/src/ports_policy.c libsemanage.new/src/ports_policy.c
--- libsemanage/src/ports_policy.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/ports_policy.c	2005-09-29 19:40:44.000000000 -0400
@@ -4,8 +4,8 @@
 
 #include <sepol/port_record.h>
 
-typedef sepol_port_key_t* record_key_t;
-typedef sepol_port_t* record_t;
+typedef sepol_port_key_t record_key_t;
+typedef sepol_port_t record_t;
 #define RECORD_DEFINED
 
 #include <semanage/port_record.h>
@@ -18,8 +18,8 @@
 #include "debug.h"
 
 static inline int convert(
-	semanage_port_key_t semanage_key,
-	semanage_port_t semanage_port,
+	semanage_port_key_t* semanage_key,
+	semanage_port_t* semanage_port,
 	sepol_port_key_t** sepol_key,
 	sepol_port_t** sepol_port) {
 
@@ -42,8 +42,8 @@
 #if 0
 int semanage_port_policy_load(
 	semanage_handle_t* handle,
-	semanage_port_key_t key,
-	semanage_port_t data) {
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
 
 	sepol_port_t* sepol_data;
 	sepol_port_key_t* sepol_key;
@@ -57,7 +57,7 @@
 
 int semanage_port_policy_list(
 	semanage_handle_t* handle,
-	semanage_port_t** records,
+	semanage_port_t*** records,
 	size_t* count) {
 
 	/* Stub */
diff -Naru --exclude CVS libsemanage/src/user_record.c libsemanage.new/src/user_record.c
--- libsemanage/src/user_record.c	2005-09-29 16:59:38.000000000 -0400
+++ libsemanage.new/src/user_record.c	2005-09-29 19:44:16.000000000 -0400
@@ -1,100 +1,151 @@
 #include <stddef.h>
 #include <sepol/user_record.h>
 
-typedef sepol_user_t* semanage_user_t;
-typedef sepol_user_key_t* semanage_user_key_t;
+typedef sepol_user_t semanage_user_t;
+typedef sepol_user_key_t semanage_user_key_t;
 
 /* Key */
-int semanage_user_key_create(const char* name, semanage_user_key_t* key) {
+int semanage_user_key_create(
+	const char* name, 
+	semanage_user_key_t** key) {
+
 	return sepol_user_key_create(name, key);
 }
 
-int semanage_user_key_extract(semanage_user_t user, semanage_user_key_t* key) {
+int semanage_user_key_extract(
+	semanage_user_t* user, 
+	semanage_user_key_t** key) {
+
 	return sepol_user_key_extract(user, key);
 }
 
-void semanage_user_key_free(semanage_user_key_t key) {
+void semanage_user_key_free(
+	semanage_user_key_t* key) {
+
 	sepol_user_key_free(key);
 }
 
-int semanage_user_compare(semanage_user_t user, semanage_user_key_t key) {
+int semanage_user_compare(
+	semanage_user_t* user, 
+	semanage_user_key_t* key) {
+
 	return sepol_user_compare(user, key);
 }
 	
 /* Name */
-const char* semanage_user_get_name(semanage_user_t user) {
+const char* semanage_user_get_name(
+	semanage_user_t* user) {
+
 	return sepol_user_get_name(user);
 }
 
-int semanage_user_set_name(semanage_user_t user, const char* name) {
+int semanage_user_set_name(
+	semanage_user_t* user, 
+	const char* name) {
+
 	return sepol_user_set_name(user, name);
 }
 
 /* MLS */
-const char* semanage_user_get_mlslevel(semanage_user_t user) {
+const char* semanage_user_get_mlslevel(
+	semanage_user_t* user) {
+
 	return sepol_user_get_mlslevel(user);
 }
 
-int semanage_user_set_mlslevel(semanage_user_t user, const char* mls_level) {
+int semanage_user_set_mlslevel(
+	semanage_user_t* user, 
+	const char* mls_level) {
+
 	return sepol_user_set_mlslevel(user, mls_level);
 }
 
-const char* semanage_user_get_mlsrange(semanage_user_t user) {
+const char* semanage_user_get_mlsrange(
+	semanage_user_t* user) {
+
 	return sepol_user_get_mlsrange(user);
 }
 
-int semanage_user_set_mlsrange(semanage_user_t user, const char* mls_range) {
+int semanage_user_set_mlsrange(
+	semanage_user_t* user, 
+	const char* mls_range) {
+
 	return sepol_user_set_mlsrange(user, mls_range);
 }
 
 /* Role management */
-int semanage_user_get_num_roles(semanage_user_t user) {
+int semanage_user_get_num_roles(
+	semanage_user_t* user) {
+
 	return sepol_user_get_num_roles(user);
 }
 
-const char* semanage_user_get_defrole(semanage_user_t user) {
+const char* semanage_user_get_defrole(
+	semanage_user_t* user) {
+
 	return sepol_user_get_defrole(user);
 }
 
-int semanage_user_add_role(semanage_user_t user, const char* role) {
+int semanage_user_add_role(
+	semanage_user_t* user, 
+	const char* role) {
+
 	return sepol_user_add_role(user, role);
 }
 
-int semanage_user_del_role(semanage_user_t user, const char* role) {
+int semanage_user_del_role(
+	semanage_user_t* user, 
+	const char* role) {
+
 	return sepol_user_del_role(user, role);
 }
 
-int semanage_user_has_role(semanage_user_t user, const char* role) {
+int semanage_user_has_role(
+	semanage_user_t* user, 
+	const char* role) {
+
 	return sepol_user_has_role(user, role);
 }
 
-int semanage_user_set_defrole(semanage_user_t user, const char* role) {
+int semanage_user_set_defrole(
+	semanage_user_t* user, 
+	const char* role) {
+
 	return sepol_user_set_defrole(user, role);
 }
 
 int semanage_user_get_roles(
-	semanage_user_t user,
+	semanage_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles) {
+
 	return sepol_user_get_roles(user, roles_arr, num_roles);
 }
 
 int semanage_user_set_roles(
-	semanage_user_t user,
+	semanage_user_t* user,
 	const char** roles_arr,
 	size_t num_roles) {
+
 	return sepol_user_set_roles(user, roles_arr, num_roles);
 }
 
 /* Create/Clone/Destroy */
-int semanage_user_create(semanage_user_t* user_ptr) {
+int semanage_user_create(
+	semanage_user_t** user_ptr) {
+
 	return sepol_user_create(user_ptr);
 }
 
-int semanage_user_clone(semanage_user_t user, semanage_user_t* user_ptr) {
+int semanage_user_clone(
+	semanage_user_t* user, 
+	semanage_user_t** user_ptr) {
+
 	return sepol_user_clone(user, user_ptr);
 }
 
-void semanage_user_free(semanage_user_t user) {
+void semanage_user_free(
+	semanage_user_t* user) {
+
 	sepol_user_free(user);
 }
diff -Naru --exclude CVS libsemanage/src/users.c libsemanage.new/src/users.c
--- libsemanage/src/users.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/users.c	2005-09-29 19:45:08.000000000 -0400
@@ -27,8 +27,8 @@
 
 int semanage_user_add(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data) {
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);
 	return dbase_add(handle, dbase, key, data);
@@ -36,8 +36,8 @@
 
 int semanage_user_modify(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data) {
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);	
 	return dbase_modify(handle, dbase, key, data);
@@ -45,7 +45,7 @@
 
 int semanage_user_del(
 	semanage_handle_t* handle,
-	semanage_user_key_t key) {
+	semanage_user_key_t* key) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);
 	return dbase_del(handle, dbase, key);
@@ -53,8 +53,8 @@
 
 int semanage_user_query(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t* response) {
+	semanage_user_key_t* key,
+	semanage_user_t** response) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);
 	return dbase_query(handle, dbase, key, response);
@@ -62,7 +62,7 @@
 
 int semanage_user_exists(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
+	semanage_user_key_t* key,
 	int* response) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);
@@ -79,7 +79,7 @@
 
 int semanage_user_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t record,
+	int (*handler) (semanage_user_t* record,
 	                void* varg),
 	void* handler_arg) {
 
@@ -89,7 +89,7 @@
 
 int semanage_user_list(
 	semanage_handle_t* handle,
-	semanage_user_t** records,
+	semanage_user_t*** records,
 	size_t* count) {
 
 	dbase_t* dbase = semanage_user_dbase(handle);
diff -Naru --exclude CVS libsemanage/src/users_direct.c libsemanage.new/src/users_direct.c
--- libsemanage/src/users_direct.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/users_direct.c	2005-09-29 19:58:01.000000000 -0400
@@ -3,8 +3,8 @@
  */
 #include <sepol/user_record.h>
 
-typedef sepol_user_t* record_t;
-typedef sepol_user_key_t* record_key_t;
+typedef sepol_user_t record_t;
+typedef sepol_user_key_t record_key_t;
 #define RECORD_DEFINED
 
 struct dbase_direct_backend;
diff -Naru --exclude CVS libsemanage/src/users_file.c libsemanage.new/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/users_file.c	2005-09-29 19:58:13.000000000 -0400
@@ -15,7 +15,7 @@
 #include "debug.h"
 
 static int user_print(
-	semanage_user_t user, 
+	semanage_user_t* user, 
 	FILE* str) {
 
 	/* Stub */
@@ -26,7 +26,7 @@
 
 static int user_parse(
 	parse_info_t* info, 
-	semanage_user_t user) {
+	semanage_user_t* user) {
 
 	/* Stub */
 	info = NULL;
diff -Naru --exclude CVS libsemanage/src/users_policy.c libsemanage.new/src/users_policy.c
--- libsemanage/src/users_policy.c	2005-09-29 19:17:48.000000000 -0400
+++ libsemanage.new/src/users_policy.c	2005-09-29 19:46:17.000000000 -0400
@@ -4,8 +4,8 @@
 
 #include <sepol/user_record.h>
 
-typedef sepol_user_key_t* record_key_t;
-typedef sepol_user_t* record_t;
+typedef sepol_user_key_t record_key_t;
+typedef sepol_user_t record_t;
 #define RECORD_DEFINED
 
 #include <stddef.h>
@@ -18,8 +18,8 @@
 #include "debug.h"
 
 static inline int convert(
-	semanage_user_key_t semanage_key,
-	semanage_user_t semanage_user,
+	semanage_user_key_t* semanage_key,
+	semanage_user_t* semanage_user,
 	sepol_user_key_t** sepol_key,
 	sepol_user_t** sepol_user) {
 
@@ -42,8 +42,8 @@
 #if 0
 int semanage_user_policy_load(
 	semanage_handle_t* handle,
-	semanage_user_key_t key,
-	semanage_user_t data) {
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
 
 	sepol_user_t* sepol_data;
 	sepol_user_key_t* sepol_key;
@@ -57,7 +57,7 @@
 
 int semanage_user_policy_list(
 	semanage_handle_t* handle,
-	semanage_user_t** records,
+	semanage_user_t*** records,
 	size_t* count) {
 
 	/* Stub */

--------------040806030104090501000205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
