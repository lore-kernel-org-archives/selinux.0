Message-ID: <43BDE09A.30808@cornell.edu>
Date: Thu, 05 Jan 2006 22:14:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Hidden def/proto update
Content-Type: multipart/mixed;
 boundary="------------020108080705010206090807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020108080705010206090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Get rid of relocations...

--------------020108080705010206090807
Content-Type: text/x-patch;
 name="libsemanage.hidden_update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.hidden_update.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2006-01-05 22:07:24.000000000 -0500
@@ -11,6 +11,7 @@
 
 hidden_proto(semanage_bool_clone)
 hidden_proto(semanage_bool_compare)
+hidden_proto(semanage_bool_compare2)
 hidden_proto(semanage_bool_create)
 hidden_proto(semanage_bool_free)
 hidden_proto(semanage_bool_get_name)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2006-01-05 19:48:29.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2006-01-05 22:07:11.000000000 -0500
@@ -58,6 +58,7 @@ int semanage_bool_compare2(
 
 	return sepol_bool_compare2(boolean, boolean2);
 }
+hidden_def(semanage_bool_compare2)
 	
 /* Name */
 const char* semanage_bool_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/context_internal.h new/libsemanage/src/context_internal.h
--- old/libsemanage/src/context_internal.h	2005-12-14 10:09:27.000000000 -0500
+++ new/libsemanage/src/context_internal.h	2006-01-05 22:09:15.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/context_record.h>
 #include "dso.h"
 
+hidden_proto(semanage_context_clone)
 hidden_proto(semanage_context_free)
 hidden_proto(semanage_context_from_string)
 hidden_proto(semanage_context_to_string)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/context_record.c new/libsemanage/src/context_record.c
--- old/libsemanage/src/context_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/context_record.c	2006-01-05 22:08:56.000000000 -0500
@@ -83,6 +83,7 @@ int semanage_context_clone(
 
 	return sepol_context_clone(handle->sepolh, con, con_ptr);
 }
+hidden_def(semanage_context_clone)
 
 void semanage_context_free(
 	semanage_context_t* con) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontext_internal.h new/libsemanage/src/fcontext_internal.h
--- old/libsemanage/src/fcontext_internal.h	2006-01-05 17:04:32.000000000 -0500
+++ new/libsemanage/src/fcontext_internal.h	2006-01-05 22:05:36.000000000 -0500
@@ -9,7 +9,22 @@
 #include "handle.h"
 #include "dso.h"
 
-/* TODO: hidden prototypes */
+hidden_proto(semanage_fcontext_key_create)
+hidden_proto(semanage_fcontext_key_extract)
+hidden_proto(semanage_fcontext_key_free)
+hidden_proto(semanage_fcontext_compare)
+hidden_proto(semanage_fcontext_compare2)
+hidden_proto(semanage_fcontext_create)
+hidden_proto(semanage_fcontext_get_expr)
+hidden_proto(semanage_fcontext_set_expr)
+hidden_proto(semanage_fcontext_get_type)
+hidden_proto(semanage_fcontext_get_type_str)
+hidden_proto(semanage_fcontext_set_type)
+hidden_proto(semanage_fcontext_get_con)
+hidden_proto(semanage_fcontext_set_con)
+hidden_proto(semanage_fcontext_clone)
+hidden_proto(semanage_fcontext_free)
+hidden_proto(semanage_fcontext_iterate_local)
 
 /* FCONTEXT RECORD: metod table */
 extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2006-01-05 22:04:45.000000000 -0500
@@ -52,6 +52,7 @@ int semanage_fcontext_key_create(
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
 }
+hidden_def(semanage_fcontext_key_create)
 
 int semanage_fcontext_key_extract(
 	semanage_handle_t* handle,
@@ -68,11 +69,13 @@ int semanage_fcontext_key_extract(
 
 	return STATUS_SUCCESS;
 }
+hidden_def(semanage_fcontext_key_extract)
 
 void semanage_fcontext_key_free(
 	semanage_fcontext_key_t* key) {
 	free(key);
 }
+hidden_def(semanage_fcontext_key_free)
 
 int semanage_fcontext_compare(
 	const semanage_fcontext_t* fcontext, 
@@ -81,6 +84,7 @@ int semanage_fcontext_compare(
 	return strcmp(fcontext->expr, key->expr) && 
 		(fcontext->type == key->type);
 }
+hidden_def(semanage_fcontext_compare)
 
 int semanage_fcontext_compare2(
 	const semanage_fcontext_t* fcontext,
@@ -89,6 +93,7 @@ int semanage_fcontext_compare2(
 	return strcmp(fcontext->expr, fcontext2->expr) &&
 		(fcontext->type == fcontext2->type);
 }
+hidden_def(semanage_fcontext_compare2)
 
 /* Create */
 int semanage_fcontext_create(
@@ -111,6 +116,7 @@ int semanage_fcontext_create(
 
 	return STATUS_SUCCESS;
 }
+hidden_def(semanage_fcontext_create)
 
 /* Regexp */
 const char* semanage_fcontext_get_expr(
@@ -118,6 +124,7 @@ const char* semanage_fcontext_get_expr(
 
 	return fcontext->expr;
 }
+hidden_def(semanage_fcontext_get_expr)
 
 int semanage_fcontext_set_expr(
 	semanage_handle_t* handle,
@@ -134,6 +141,7 @@ int semanage_fcontext_set_expr(
 	fcontext->expr = tmp_expr;
 	return STATUS_SUCCESS;
 }
+hidden_def(semanage_fcontext_set_expr)
 
 /* Type */
 int semanage_fcontext_get_type(
@@ -141,6 +149,7 @@ int semanage_fcontext_get_type(
 
 	return fcontext->type;
 }
+hidden_def(semanage_fcontext_get_type)
 
 const char* semanage_fcontext_get_type_str(
 	const semanage_fcontext_t* fcontext) {
@@ -165,6 +174,7 @@ const char* semanage_fcontext_get_type_s
 			return "named pipe";
 	}
 }
+hidden_def(semanage_fcontext_get_type_str)
 
 void semanage_fcontext_set_type(
 	semanage_fcontext_t* fcontext,
@@ -172,6 +182,7 @@ void semanage_fcontext_set_type(
 
 	fcontext->type = type;
 }
+hidden_def(semanage_fcontext_set_type)
 
 /* Context */
 semanage_context_t* semanage_fcontext_get_con(
@@ -179,6 +190,7 @@ semanage_context_t* semanage_fcontext_ge
 
 	return fcontext->con;
 }
+hidden_def(semanage_fcontext_get_con)
 
 void semanage_fcontext_set_con(
 	semanage_fcontext_t* fcontext, 
@@ -187,6 +199,7 @@ void semanage_fcontext_set_con(
 	semanage_context_free(fcontext->con);
 	fcontext->con = con;
 }
+hidden_def(semanage_fcontext_set_con)
 
 /* Deep copy clone */
 int semanage_fcontext_clone(
@@ -215,6 +228,7 @@ int semanage_fcontext_clone(
 	semanage_fcontext_free(new_fcontext);
 	return STATUS_ERR;
 }
+hidden_def(semanage_fcontext_clone)
 
 /* Destroy */
 void semanage_fcontext_free(
@@ -227,6 +241,7 @@ void semanage_fcontext_free(
 	semanage_context_free(fcontext->con);
 	free(fcontext);
 }
+hidden_def(semanage_fcontext_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_FCONTEXT_RTABLE = {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/fcontexts_local.c	2006-01-05 22:11:20.000000000 -0500
@@ -11,6 +11,7 @@ typedef struct semanage_fcontext record_
 #include <sepol/policydb.h>
 #include <sepol/context.h>
 #include "fcontext_internal.h"
+#include "context_internal.h"
 #include "debug.h"
 #include "handle.h" 
 #include "database.h"
@@ -86,6 +87,7 @@ int semanage_fcontext_iterate_local(
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
 	return dbase_iterate(handle, dconfig, handler, handler_arg);
 }
+hidden_def(semanage_fcontext_iterate_local)
 
 int semanage_fcontext_list_local(
 	semanage_handle_t* handle,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/iface_internal.h new/libsemanage/src/iface_internal.h
--- old/libsemanage/src/iface_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/iface_internal.h	2006-01-05 22:06:54.000000000 -0500
@@ -10,6 +10,7 @@
 
 hidden_proto(semanage_iface_create)
 hidden_proto(semanage_iface_compare)
+hidden_proto(semanage_iface_compare2)
 hidden_proto(semanage_iface_clone)
 hidden_proto(semanage_iface_free)
 hidden_proto(semanage_iface_get_ifcon)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2006-01-05 22:06:41.000000000 -0500
@@ -38,6 +38,7 @@ int semanage_iface_compare2(
 
 	return sepol_iface_compare2(iface, iface2);
 }
+hidden_def(semanage_iface_compare2)
 
 int semanage_iface_key_create(
 	semanage_handle_t* handle,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/port_internal.h	2006-01-05 21:58:11.000000000 -0500
@@ -8,7 +8,22 @@
 #include "handle.h"
 #include "dso.h"
 
-/* TODO: Hidden prototypes here */
+hidden_proto(semanage_port_create)
+hidden_proto(semanage_port_compare)
+hidden_proto(semanage_port_compare2)
+hidden_proto(semanage_port_clone)
+hidden_proto(semanage_port_free)
+hidden_proto(semanage_port_key_extract)
+hidden_proto(semanage_port_key_free)
+hidden_proto(semanage_port_get_high)
+hidden_proto(semanage_port_get_low)
+hidden_proto(semanage_port_set_port)
+hidden_proto(semanage_port_set_range)
+hidden_proto(semanage_port_get_proto)
+hidden_proto(semanage_port_set_proto)
+hidden_proto(semanage_port_get_proto_str)
+hidden_proto(semanage_port_get_con)
+hidden_proto(semanage_port_set_con)
 
 /* PORT RECORD: method table */
 extern record_table_t SEMANAGE_PORT_RTABLE;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/port_record.c	2006-01-05 21:58:45.000000000 -0500
@@ -30,6 +30,7 @@ int semanage_port_compare(
 
 	return sepol_port_compare(port, key);
 }
+hidden_def(semanage_port_compare)
 
 int semanage_port_compare2(
 	const semanage_port_t* port,
@@ -37,6 +38,7 @@ int semanage_port_compare2(
 
 	return sepol_port_compare2(port, port2);
 }
+hidden_def(semanage_port_compare2)
 
 int semanage_port_key_create(
 	semanage_handle_t* handle,
@@ -53,12 +55,14 @@ int semanage_port_key_extract(
 
 	return sepol_port_key_extract(handle->sepolh, port, key_ptr);
 }
+hidden_def(semanage_port_key_extract)
 
 void semanage_port_key_free(
 	semanage_port_key_t* key) {
 
 	sepol_port_key_free(key);
-}	
+}
+hidden_def(semanage_port_key_free)
 
 /* Protocol */
 int semanage_port_get_proto(
@@ -66,6 +70,7 @@ int semanage_port_get_proto(
 
 	return sepol_port_get_proto(port);
 }
+hidden_def(semanage_port_get_proto)
 
 void semanage_port_set_proto(
 	semanage_port_t* port, 
@@ -73,12 +78,14 @@ void semanage_port_set_proto(
 
 	sepol_port_set_proto(port, proto);
 }
+hidden_def(semanage_port_set_proto)
 
 const char* semanage_port_get_proto_str(
 	const semanage_port_t* port) {
 
 	return sepol_port_get_proto_str(port);
 }
+hidden_def(semanage_port_get_proto_str)
 
 /* Port */
 int semanage_port_get_low(
@@ -86,12 +93,14 @@ int semanage_port_get_low(
 
 	return sepol_port_get_low(port);
 }
+hidden_def(semanage_port_get_low)
 
 int semanage_port_get_high(
 	const semanage_port_t* port) {
 
 	return sepol_port_get_high(port);
 }
+hidden_def(semanage_port_get_high)
 
 void semanage_port_set_port(
 	semanage_port_t* port, 
@@ -99,6 +108,7 @@ void semanage_port_set_port(
 
 	sepol_port_set_port(port, port_num);
 }
+hidden_def(semanage_port_set_port)
 
 void semanage_port_set_range(
 	semanage_port_t* port, 
@@ -106,6 +116,7 @@ void semanage_port_set_range(
 
 	sepol_port_set_range(port, low, high);
 }
+hidden_def(semanage_port_set_range)
 
 /* Context */
 semanage_context_t* semanage_port_get_con(
@@ -113,6 +124,7 @@ semanage_context_t* semanage_port_get_co
 
 	return sepol_port_get_con(port);	
 }
+hidden_def(semanage_port_get_con)
 
 void semanage_port_set_con(
 	semanage_port_t* port, 
@@ -120,6 +132,7 @@ void semanage_port_set_con(
 
 	sepol_port_set_con(port, con);
 }
+hidden_def(semanage_port_set_con)
 
 /* Create/Clone/Destroy */
 int semanage_port_create(
@@ -128,6 +141,7 @@ int semanage_port_create(
 
 	return sepol_port_create(handle->sepolh, port_ptr);
 }
+hidden_def(semanage_port_create)
 
 int semanage_port_clone(
 	semanage_handle_t* handle,
@@ -136,12 +150,14 @@ int semanage_port_clone(
 
 	return sepol_port_clone(handle->sepolh, port, port_ptr);
 }
+hidden_def(semanage_port_clone)
 
 void semanage_port_free(
 	semanage_port_t* port) {
 
 	sepol_port_free(port);
 }
+hidden_def(semanage_port_free)
 
 /* Port base functions */
 record_table_t SEMANAGE_PORT_RTABLE = {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2006-01-05 22:07:58.000000000 -0500
@@ -10,6 +10,7 @@
 
 hidden_proto(semanage_seuser_clone)
 hidden_proto(semanage_seuser_compare)
+hidden_proto(semanage_seuser_compare2)
 hidden_proto(semanage_seuser_create)
 hidden_proto(semanage_seuser_free)
 hidden_proto(semanage_seuser_get_mlsrange)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2006-01-05 22:07:46.000000000 -0500
@@ -93,6 +93,7 @@ int semanage_seuser_compare2(
 
 	return strcmp(seuser->name, seuser2->name);
 }
+hidden_def(semanage_seuser_compare2)
 
 /* Name */
 const char* semanage_seuser_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/user_internal.h	2006-01-05 22:10:36.000000000 -0500
@@ -11,8 +11,8 @@
 hidden_proto(semanage_user_add_role)
 hidden_proto(semanage_user_clone)
 hidden_proto(semanage_user_compare)
+hidden_proto(semanage_user_compare2)
 hidden_proto(semanage_user_create)
-hidden_proto(semanage_user_exists)
 hidden_proto(semanage_user_free)
 hidden_proto(semanage_user_get_mlslevel)
 hidden_proto(semanage_user_get_mlsrange)
@@ -24,6 +24,8 @@ hidden_proto(semanage_user_key_free)
 hidden_proto(semanage_user_set_mlslevel)
 hidden_proto(semanage_user_set_mlsrange)
 hidden_proto(semanage_user_set_name)
+hidden_proto(semanage_user_exists)
+hidden_proto(semanage_user_query)
 
 /* USER RECORD: metod table */
 extern record_table_t SEMANAGE_USER_RTABLE;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-05 19:48:30.000000000 -0500
+++ new/libsemanage/src/user_record.c	2006-01-05 22:08:23.000000000 -0500
@@ -63,6 +63,7 @@ int semanage_user_compare2(
 
 	return sepol_user_compare2(user, user2);
 }
+hidden_def(semanage_user_compare2)
 	
 /* Name */
 const char* semanage_user_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/users_policy.c	2006-01-05 22:10:06.000000000 -0500
@@ -19,6 +19,7 @@ int semanage_user_query(
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
 	return dbase_query(handle, dconfig, key, response);
 }
+hidden_def(semanage_user_query)
 
 int semanage_user_exists(
 	semanage_handle_t* handle,

--------------020108080705010206090807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
