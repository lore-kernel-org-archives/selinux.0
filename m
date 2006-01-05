Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k06DKKXf000015
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 08:20:20 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k06DJIk6027028
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 13:19:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k06DJS8s023648
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 08:19:28 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k06DJS8v023647
	for selinux@tycho.nsa.gov; Fri, 6 Jan 2006 08:19:28 -0500
Message-ID: <43BD77BA.7060303@cornell.edu>
Date: Thu, 05 Jan 2006 14:47:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Const in APIs (part 2)
Content-Type: multipart/mixed;
 boundary="------------090702020805040904070005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090702020805040904070005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marks lots of libsemanage things const.

Note that I haven't been including semanageswig_wrap.c changes into any 
of my patches, since it makes them really huge. If you want
 that file to be up to date, please rebuild it..



--------------090702020805040904070005
Content-Type: text/x-patch;
 name="libsemanage.const_api.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.const_api.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/boolean_record.h new/libsemanage/include/semanage/boolean_record.h
--- old/libsemanage/include/semanage/boolean_record.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/include/semanage/boolean_record.h	2006-01-05 14:01:03.000000000 -0500
@@ -21,19 +21,19 @@ extern int semanage_bool_key_create(
 
 extern int semanage_bool_key_extract(
 	semanage_handle_t* handle,
-	semanage_bool_t* boolean, 
+	const semanage_bool_t* boolean, 
 	semanage_bool_key_t** key);
 
 extern void semanage_bool_key_free(
 	semanage_bool_key_t* key);
 
 extern int semanage_bool_compare(
-	semanage_bool_t* boolean, 
-	semanage_bool_key_t* key);
+	const semanage_bool_t* boolean, 
+	const semanage_bool_key_t* key);
 	
 /* Name */
 extern const char* semanage_bool_get_name(
-	semanage_bool_t* boolean);
+	const semanage_bool_t* boolean);
 
 extern int semanage_bool_set_name(
 	semanage_handle_t* handle,
@@ -42,7 +42,7 @@ extern int semanage_bool_set_name(
 
 /* Value */
 extern int semanage_bool_get_value(
-	semanage_bool_t* boolean);
+	const semanage_bool_t* boolean);
 
 extern void semanage_bool_set_value(
 	semanage_bool_t* boolean, 
@@ -55,7 +55,7 @@ extern int semanage_bool_create(
 
 extern int semanage_bool_clone(
 	semanage_handle_t* handle,
-	semanage_bool_t* boolean, 
+	const semanage_bool_t* boolean, 
 	semanage_bool_t** bool_ptr);
 
 extern void semanage_bool_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_active.h new/libsemanage/include/semanage/booleans_active.h
--- old/libsemanage/include/semanage/booleans_active.h	2006-01-05 08:26:18.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_active.h	2006-01-05 14:14:07.000000000 -0500
@@ -9,17 +9,17 @@
 
 extern int semanage_bool_set_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data);
 
 extern int semanage_bool_query_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response);
 
 extern int semanage_bool_exists_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response);
 
 extern int semanage_bool_count_active(
@@ -28,8 +28,9 @@ extern int semanage_bool_count_active(
 
 extern int semanage_bool_iterate_active(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_bool_list_active(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_local.h	2006-01-05 14:13:34.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_bool_add_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data);
 
 extern int semanage_bool_modify_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data);
 
 extern int semanage_bool_set_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data);
 
 extern int semanage_bool_del_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key);
+	const semanage_bool_key_t* key);
 
 extern int semanage_bool_query_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response);
 
 extern int semanage_bool_exists_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response);
 
 extern int semanage_bool_count_local(
@@ -42,8 +42,9 @@ extern int semanage_bool_count_local(
 
 extern int semanage_bool_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_bool_list_local(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_policy.h	2006-01-05 14:13:54.000000000 -0500
@@ -9,12 +9,12 @@
 
 extern int semanage_bool_query(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response);
 
 extern int semanage_bool_exists(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response);
 
 extern int semanage_bool_count(
@@ -23,8 +23,9 @@ extern int semanage_bool_count(
 
 extern int semanage_bool_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_bool_list(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/context_record.h new/libsemanage/include/semanage/context_record.h
--- old/libsemanage/include/semanage/context_record.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/include/semanage/context_record.h	2006-01-05 14:01:55.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_context semanage
 
 /* User */
 extern const char* semanage_context_get_user(
-	semanage_context_t* con);
+	const semanage_context_t* con);
 
 extern int semanage_context_set_user(
 	semanage_handle_t* handle,
@@ -22,7 +22,7 @@ extern int semanage_context_set_user(
 
 /* Role */
 extern const char* semanage_context_get_role(
-	semanage_context_t* con);
+	const semanage_context_t* con);
 
 extern int semanage_context_set_role(
 	semanage_handle_t* handle,
@@ -31,7 +31,7 @@ extern int semanage_context_set_role(
 
 /* Type */
 extern const char* semanage_context_get_type(
-	semanage_context_t* con);
+	const semanage_context_t* con);
 
 extern int semanage_context_set_type(
 	semanage_handle_t* handle,
@@ -40,7 +40,7 @@ extern int semanage_context_set_type(
 
 /* MLS */
 extern const char* semanage_context_get_mls(
-	semanage_context_t* con);
+	const semanage_context_t* con);
 
 extern int semanage_context_set_mls(
 	semanage_handle_t* handle,
@@ -54,7 +54,7 @@ extern int semanage_context_create(
 
 extern int semanage_context_clone(
 	semanage_handle_t* handle,
-	semanage_context_t* con, 
+	const semanage_context_t* con, 
 	semanage_context_t** con_ptr);
 
 extern void semanage_context_free(
@@ -68,7 +68,7 @@ extern int semanage_context_from_string(
 
 extern int semanage_context_to_string(
 	semanage_handle_t* handle,
-	semanage_context_t* con,
+	const semanage_context_t* con,
 	char** str_ptr);
 
 #endif 
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontext_record.h new/libsemanage/include/semanage/fcontext_record.h
--- old/libsemanage/include/semanage/fcontext_record.h	2006-01-04 12:18:11.000000000 -0500
+++ new/libsemanage/include/semanage/fcontext_record.h	2006-01-05 14:02:38.000000000 -0500
@@ -16,8 +16,8 @@ typedef struct semanage_fcontext_key sem
 
 /* Key */
 extern int semanage_fcontext_compare(
-	semanage_fcontext_t* fcontext, 
-	semanage_fcontext_key_t* key);
+	const semanage_fcontext_t* fcontext, 
+	const semanage_fcontext_key_t* key);
 
 extern int semanage_fcontext_key_create(
 	semanage_handle_t* handle,
@@ -27,7 +27,7 @@ extern int semanage_fcontext_key_create(
 
 extern int semanage_fcontext_key_extract(
 	semanage_handle_t* handle,
-	semanage_fcontext_t* fcontext,
+	const semanage_fcontext_t* fcontext,
 	semanage_fcontext_key_t** key_ptr);
 
 extern void semanage_fcontext_key_free(
@@ -35,7 +35,7 @@ extern void semanage_fcontext_key_free(
 
 /* Regexp */
 extern const char* semanage_fcontext_get_expr(
-	semanage_fcontext_t* fcontext);
+	const semanage_fcontext_t* fcontext);
 
 extern int semanage_fcontext_set_expr(
 	semanage_handle_t* handle,
@@ -53,10 +53,10 @@ extern int semanage_fcontext_set_expr(
 #define SEMANAGE_FCONTEXT_PIPE  7
 
 extern int semanage_fcontext_get_type(
-	semanage_fcontext_t* fcontext);
+	const semanage_fcontext_t* fcontext);
 
 extern const char* semanage_fcontext_get_type_str(
-	semanage_fcontext_t* fcontext);
+	const semanage_fcontext_t* fcontext);
 
 extern void semanage_fcontext_set_type(
 	semanage_fcontext_t* fcontext,
@@ -64,7 +64,7 @@ extern void semanage_fcontext_set_type(
 
 /* Context */
 extern semanage_context_t* semanage_fcontext_get_con(
-	semanage_fcontext_t* fcontext);
+	const semanage_fcontext_t* fcontext);
 
 extern void semanage_fcontext_set_con(
 	semanage_fcontext_t* fcontext, 
@@ -77,7 +77,7 @@ extern int semanage_fcontext_create(
 
 extern int semanage_fcontext_clone(
 	semanage_handle_t* handle,
-	semanage_fcontext_t* fcontext, 
+	const semanage_fcontext_t* fcontext, 
 	semanage_fcontext_t** fcontext_ptr);
 
 extern void semanage_fcontext_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontexts_local.h new/libsemanage/include/semanage/fcontexts_local.h
--- old/libsemanage/include/semanage/fcontexts_local.h	2006-01-04 12:18:11.000000000 -0500
+++ new/libsemanage/include/semanage/fcontexts_local.h	2006-01-05 14:14:31.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_fcontext_add_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data);
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data);
 
 extern int semanage_fcontext_modify_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data);
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data);
 
 extern int semanage_fcontext_set_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data);
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data);
 
 extern int semanage_fcontext_del_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key);
+	const semanage_fcontext_key_t* key);
 
 extern int semanage_fcontext_query_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	semanage_fcontext_t** response);
 
 extern int semanage_fcontext_exists_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	int* response);
 
 extern int semanage_fcontext_count_local(
@@ -42,8 +42,9 @@ extern int semanage_fcontext_count_local
 
 extern int semanage_fcontext_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_fcontext_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_fcontext_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_fcontext_list_local(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontexts_policy.h new/libsemanage/include/semanage/fcontexts_policy.h
--- old/libsemanage/include/semanage/fcontexts_policy.h	2006-01-04 12:18:11.000000000 -0500
+++ new/libsemanage/include/semanage/fcontexts_policy.h	2006-01-05 14:14:46.000000000 -0500
@@ -9,12 +9,12 @@
 
 extern int semanage_fcontext_query(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	semanage_fcontext_t** response);
 
 extern int semanage_fcontext_exists(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	int* response);
 
 extern int semanage_fcontext_count(
@@ -23,8 +23,9 @@ extern int semanage_fcontext_count(
 
 extern int semanage_fcontext_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_fcontext_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_fcontext_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_fcontext_list(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/iface_record.h new/libsemanage/include/semanage/iface_record.h
--- old/libsemanage/include/semanage/iface_record.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/include/semanage/iface_record.h	2006-01-05 14:03:18.000000000 -0500
@@ -16,8 +16,8 @@ typedef struct semanage_iface_key semana
 
 /* Key */
 extern int semanage_iface_compare(
-	semanage_iface_t* iface, 
-	semanage_iface_key_t* key);
+	const semanage_iface_t* iface, 
+	const semanage_iface_key_t* key);
 
 extern int semanage_iface_key_create(
 	semanage_handle_t* handle,
@@ -26,7 +26,7 @@ extern int semanage_iface_key_create(
 
 extern int semanage_iface_key_extract(
 	semanage_handle_t* handle,
-	semanage_iface_t* iface,
+	const semanage_iface_t* iface,
 	semanage_iface_key_t** key_ptr);
 
 extern void semanage_iface_key_free(
@@ -34,7 +34,7 @@ extern void semanage_iface_key_free(
 
 /* Name */
 extern const char* semanage_iface_get_name(
-	semanage_iface_t* iface);
+	const semanage_iface_t* iface);
 
 extern int semanage_iface_set_name(
 	semanage_handle_t* handle,
@@ -43,14 +43,14 @@ extern int semanage_iface_set_name(
 
 /* Context */
 extern semanage_context_t* semanage_iface_get_ifcon(
-	semanage_iface_t* iface);
+	const semanage_iface_t* iface);
 
 extern void semanage_iface_set_ifcon(
 	semanage_iface_t* iface, 
 	semanage_context_t* con);
 
 extern semanage_context_t* semanage_iface_get_msgcon(
-	semanage_iface_t* iface);
+	const semanage_iface_t* iface);
 
 extern void semanage_iface_set_msgcon(
 	semanage_iface_t* iface, 
@@ -63,7 +63,7 @@ extern int semanage_iface_create(
 
 extern int semanage_iface_clone(
 	semanage_handle_t* handle,
-	semanage_iface_t* iface, 
+	const semanage_iface_t* iface, 
 	semanage_iface_t** iface_ptr);
 
 extern void semanage_iface_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/interfaces_local.h	2006-01-05 14:15:10.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_iface_add_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data);
 
 extern int semanage_iface_modify_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data);
 
 extern int semanage_iface_set_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data);
 
 extern int semanage_iface_del_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key);
+	const semanage_iface_key_t* key);
 
 extern int semanage_iface_query_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	semanage_iface_t** response);
 
 extern int semanage_iface_exists_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	int* response);
 
 extern int semanage_iface_count_local(
@@ -42,8 +42,9 @@ extern int semanage_iface_count_local(
 
 extern int semanage_iface_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_iface_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_iface_list_local(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/interfaces_policy.h new/libsemanage/include/semanage/interfaces_policy.h
--- old/libsemanage/include/semanage/interfaces_policy.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/interfaces_policy.h	2006-01-05 14:15:26.000000000 -0500
@@ -9,12 +9,12 @@
 
 extern int semanage_iface_query(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	semanage_iface_t** response);
 
 extern int semanage_iface_exists(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	int* response);
 
 extern int semanage_iface_count(
@@ -23,8 +23,9 @@ extern int semanage_iface_count(
 
 extern int semanage_iface_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_iface_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_iface_list(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2005-12-14 10:09:27.000000000 -0500
+++ new/libsemanage/include/semanage/port_record.h	2006-01-05 14:03:54.000000000 -0500
@@ -19,8 +19,8 @@ typedef struct semanage_port_key semanag
 
 /* Key */
 extern int semanage_port_compare(
-	semanage_port_t* port, 
-	semanage_port_key_t* key);
+	const semanage_port_t* port, 
+	const semanage_port_key_t* key);
 
 extern int semanage_port_key_create(
 	semanage_handle_t* handle, 
@@ -29,7 +29,7 @@ extern int semanage_port_key_create(
 
 extern int semanage_port_key_extract(
 	semanage_handle_t* handle,
-	semanage_port_t* port,
+	const semanage_port_t* port,
 	semanage_port_key_t** key_ptr);
 
 extern void semanage_port_key_free(
@@ -37,21 +37,21 @@ extern void semanage_port_key_free(
 
 /* Protocol */
 extern int semanage_port_get_proto(
-	semanage_port_t* port);
+	const semanage_port_t* port);
 
 extern void semanage_port_set_proto(
 	semanage_port_t* port, 
 	int proto);
 
 extern const char* semanage_port_get_proto_str(
-	semanage_port_t* port);
+	const semanage_port_t* port);
 
 /* Port */
 extern int semanage_port_get_low(
-	semanage_port_t* port);
+	const semanage_port_t* port);
 
 extern int semanage_port_get_high(
-	semanage_port_t* port);
+	const semanage_port_t* port);
 
 extern void semanage_port_set_port(
 	semanage_port_t* port, 
@@ -63,7 +63,7 @@ extern void semanage_port_set_range(
 
 /* Context */
 extern semanage_context_t* semanage_port_get_con(
-	semanage_port_t* port);
+	const semanage_port_t* port);
 
 extern void semanage_port_set_con(
 	semanage_port_t* port, 
@@ -76,7 +76,7 @@ extern int semanage_port_create(
 
 extern int semanage_port_clone(
 	semanage_handle_t* handle,
-	semanage_port_t* port, 
+	const semanage_port_t* port, 
 	semanage_port_t** port_ptr);
 
 extern void semanage_port_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/ports_local.h	2006-01-05 14:15:52.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_port_add_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
+	const semanage_port_key_t* key,
+	const semanage_port_t* data);
 
 extern int semanage_port_modify_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
+	const semanage_port_key_t* key,
+	const semanage_port_t* data);
 
 extern int semanage_port_set_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
+	const semanage_port_key_t* key,
+	const semanage_port_t* data);
 
 extern int semanage_port_del_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key);
+	const semanage_port_key_t* key);
 
 extern int semanage_port_query_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	semanage_port_t** response);
 
 extern int semanage_port_exists_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	int* response);
 
 extern int semanage_port_count_local(
@@ -42,8 +42,9 @@ extern int semanage_port_count_local(
 
 extern int semanage_port_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_port_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list_local(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/ports_policy.h new/libsemanage/include/semanage/ports_policy.h
--- old/libsemanage/include/semanage/ports_policy.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/ports_policy.h	2006-01-05 14:16:26.000000000 -0500
@@ -9,12 +9,12 @@
 
 extern int semanage_port_query(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	semanage_port_t** response);
 
 extern int semanage_port_exists(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	int* response);
 
 extern int semanage_port_count(
@@ -23,8 +23,9 @@ extern int semanage_port_count(
 
 extern int semanage_port_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_port_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seuser_record.h new/libsemanage/include/semanage/seuser_record.h
--- old/libsemanage/include/semanage/seuser_record.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/seuser_record.h	2006-01-05 14:04:28.000000000 -0500
@@ -18,19 +18,19 @@ extern int semanage_seuser_key_create(
 
 extern int semanage_seuser_key_extract(
 	semanage_handle_t* handle,
-	semanage_seuser_t* seuser, 
+	const semanage_seuser_t* seuser, 
 	semanage_seuser_key_t** key);
 
 extern void semanage_seuser_key_free(
 	semanage_seuser_key_t* key);
 
 extern int semanage_seuser_compare(
-	semanage_seuser_t* seuser, 
-	semanage_seuser_key_t* key);
+	const semanage_seuser_t* seuser, 
+	const semanage_seuser_key_t* key);
 	
 /* Name */
 extern const char* semanage_seuser_get_name(
-	semanage_seuser_t* seuser);
+	const semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_name(
 	semanage_handle_t* handle,
@@ -39,7 +39,7 @@ extern int semanage_seuser_set_name(
 
 /* Selinux Name */
 extern const char* semanage_seuser_get_sename(
-	semanage_seuser_t* seuser);
+	const semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_sename(
 	semanage_handle_t* handle,
@@ -48,7 +48,7 @@ extern int semanage_seuser_set_sename(
 
 /* MLS */
 extern const char* semanage_seuser_get_mlsrange(
-	semanage_seuser_t* seuser);
+	const semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_mlsrange(
 	semanage_handle_t* handle,
@@ -62,7 +62,7 @@ extern int semanage_seuser_create(
 
 extern int semanage_seuser_clone(
 	semanage_handle_t* handle,
-	semanage_seuser_t* seuser, 
+	const semanage_seuser_t* seuser, 
 	semanage_seuser_t** seuser_ptr);
 
 extern void semanage_seuser_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/seusers.h	2006-01-05 14:18:06.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_seuser_add(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data);
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data);
 
 extern int semanage_seuser_modify(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data);
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data);
 
 extern int semanage_seuser_set(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data);
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data);
 
 extern int semanage_seuser_del(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key);
+	const semanage_seuser_key_t* key);
 
 extern int semanage_seuser_query(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
+	const semanage_seuser_key_t* key,
 	semanage_seuser_t** response);
 
 extern int semanage_seuser_exists(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
+	const semanage_seuser_key_t* key,
 	int* response);
 
 extern int semanage_seuser_count(
@@ -42,8 +42,9 @@ extern int semanage_seuser_count(
 
 extern int semanage_seuser_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_seuser_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_seuser_list(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2005-12-05 15:00:42.000000000 -0500
+++ new/libsemanage/include/semanage/user_record.h	2006-01-05 14:05:22.000000000 -0500
@@ -22,19 +22,19 @@ extern int semanage_user_key_create(
 
 extern int semanage_user_key_extract(
 	semanage_handle_t* handle,
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	semanage_user_key_t** key);
 
 extern void semanage_user_key_free(
 	semanage_user_key_t* key);
 
 extern int semanage_user_compare(
-	semanage_user_t* user, 
-	semanage_user_key_t* key);
+	const semanage_user_t* user, 
+	const semanage_user_key_t* key);
 	
 /* Name */
 extern const char* semanage_user_get_name(
-	semanage_user_t* user);
+	const semanage_user_t* user);
 
 extern int semanage_user_set_name(
 	semanage_handle_t* handle,
@@ -43,7 +43,7 @@ extern int semanage_user_set_name(
 
 /* MLS */
 extern const char* semanage_user_get_mlslevel(
-	semanage_user_t* user);
+	const semanage_user_t* user);
 
 extern int semanage_user_set_mlslevel(
 	semanage_handle_t* handle,
@@ -51,7 +51,7 @@ extern int semanage_user_set_mlslevel(
 	const char* mls_level);
 
 extern const char* semanage_user_get_mlsrange(
-	semanage_user_t* user);
+	const semanage_user_t* user);
 
 extern int semanage_user_set_mlsrange(
 	semanage_handle_t* handle,
@@ -60,7 +60,7 @@ extern int semanage_user_set_mlsrange(
 
 /* Role management */
 extern int semanage_user_get_num_roles(
-	semanage_user_t* user);
+	const semanage_user_t* user);
 
 extern int semanage_user_add_role(
 	semanage_handle_t* handle,
@@ -72,12 +72,12 @@ extern void semanage_user_del_role(
 	const char* role);
 
 extern int semanage_user_has_role(
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	const char* role);
 
 extern int semanage_user_get_roles(
 	semanage_handle_t* handle,
-	semanage_user_t* user,
+	const semanage_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles);
 
@@ -94,7 +94,7 @@ extern int semanage_user_create(
 
 extern int semanage_user_clone(
 	semanage_handle_t* handle,
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	semanage_user_t** user_ptr);
 
 extern void semanage_user_free(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/users_local.h	2006-01-05 14:18:09.000000000 -0500
@@ -9,31 +9,31 @@
 
 extern int semanage_user_add_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
+	const semanage_user_key_t* key,
+	const semanage_user_t* data);
 
 extern int semanage_user_modify_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
+	const semanage_user_key_t* key,
+	const semanage_user_t* data);
 
 extern int semanage_user_set_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
+	const semanage_user_key_t* key,
+	const semanage_user_t* data);
 
 extern int semanage_user_del_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key);
+	const semanage_user_key_t* key);
 
 extern int semanage_user_query_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	semanage_user_t** response);
 
 extern int semanage_user_exists_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	int* response);
 
 extern int semanage_user_count_local(
@@ -42,8 +42,9 @@ extern int semanage_user_count_local(
 
 extern int semanage_user_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_user_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list_local(
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/users_policy.h new/libsemanage/include/semanage/users_policy.h
--- old/libsemanage/include/semanage/users_policy.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/include/semanage/users_policy.h	2006-01-05 14:18:00.000000000 -0500
@@ -9,12 +9,12 @@
 
 extern int semanage_user_query(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	semanage_user_t** response);
 
 extern int semanage_user_exists(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	int* response);
 
 extern int semanage_user_count(
@@ -23,8 +23,9 @@ extern int semanage_user_count(
 
 extern int semanage_user_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_user_t* record,
+		void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list(
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_add_local.3 new/libsemanage/man/man3/semanage_user_add_local.3
--- old/libsemanage/man/man3/semanage_user_add_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_add_local.3	2006-01-05 14:26:55.000000000 -0500
@@ -43,9 +43,9 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ","
+.BI "	const semanage_OBJECT_key_t *" key ","
 .br
-.BI "	semanage_OBJECT_t *" data ");"
+.BI "	const semanage_OBJECT_t *" data ");"
 
 .SH "DESCRIPTION"
 .TP
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_del_local.3 new/libsemanage/man/man3/semanage_user_del_local.3
--- old/libsemanage/man/man3/semanage_user_del_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_del_local.3	2006-01-05 14:27:27.000000000 -0500
@@ -44,7 +44,7 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ");"
+.BI "	const semanage_OBJECT_key_t *" key ");"
 
 .SH "DESCRIPTION"
 .TP
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_exists_local.3 new/libsemanage/man/man3/semanage_user_exists_local.3
--- old/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-05 14:27:45.000000000 -0500
@@ -74,7 +74,7 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ","
+.BI "	const semanage_OBJECT_key_t *" key ","
 .br
 .BI "	semanage_OBJECT_t **" response ");"
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_iterate_local.3 new/libsemanage/man/man3/semanage_user_iterate_local.3
--- old/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-05 14:27:58.000000000 -0500
@@ -74,7 +74,7 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	int (*handler) (semanage_OBJECT_t *" object ","
+.BI "	int (*handler) (const semanage_OBJECT_t *" object ","
 .br
 .BI "                   void *" varg "),"
 .br
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_modify_local.3 new/libsemanage/man/man3/semanage_user_modify_local.3
--- old/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-05 14:27:06.000000000 -0500
@@ -43,9 +43,9 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ","
+.BI "	const semanage_OBJECT_key_t *" key ","
 .br
-.BI "	semanage_OBJECT_t *" data ");"
+.BI "	const semanage_OBJECT_t *" data ");"
 
 .SH "DESCRIPTION"
 .TP
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_query_local.3 new/libsemanage/man/man3/semanage_user_query_local.3
--- old/libsemanage/man/man3/semanage_user_query_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_query_local.3	2006-01-05 14:27:36.000000000 -0500
@@ -74,7 +74,7 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ","
+.BI "	const semanage_OBJECT_key_t *" key ","
 .br
 .BI "	semanage_OBJECT_t **" response ");"
 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_set_local.3 new/libsemanage/man/man3/semanage_user_set_local.3
--- old/libsemanage/man/man3/semanage_user_set_local.3	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_set_local.3	2006-01-05 14:27:18.000000000 -0500
@@ -48,9 +48,9 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_handle_t *" handle ","
 .br
-.BI "	semanage_OBJECT_key_t *" key ","
+.BI "	const semanage_OBJECT_key_t *" key ","
 .br
-.BI "	semanage_OBJECT_t *" data ");"
+.BI "	const semanage_OBJECT_t *" data ");"
 
 .SH "DESCRIPTION"
 .TP
diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2006-01-05 14:05:59.000000000 -0500
@@ -31,21 +31,22 @@ int semanage_bool_key_create(
 
 int semanage_bool_key_extract(
 	semanage_handle_t* handle,
-	semanage_bool_t* boolean, 
+	const semanage_bool_t* boolean, 
 	semanage_bool_key_t** key) {
 
 	return sepol_bool_key_extract(handle->sepolh, boolean, key);
 }
 hidden_def(semanage_bool_key_extract)
 
-void semanage_bool_key_free(semanage_bool_key_t* key) {
+void semanage_bool_key_free(
+	semanage_bool_key_t* key) {
 	sepol_bool_key_free(key);
 }
 hidden_def(semanage_bool_key_free)
 
 int semanage_bool_compare(
-	semanage_bool_t* boolean, 
-	semanage_bool_key_t* key) {
+	const semanage_bool_t* boolean, 
+	const semanage_bool_key_t* key) {
 
 	return sepol_bool_compare(boolean, key);
 }
@@ -53,7 +54,7 @@ hidden_def(semanage_bool_compare)
 	
 /* Name */
 const char* semanage_bool_get_name(
-	semanage_bool_t* boolean) {
+	const semanage_bool_t* boolean) {
 
 	return sepol_bool_get_name(boolean);
 }
@@ -70,7 +71,7 @@ hidden_def(semanage_bool_set_name)
 
 /* Value */
 int semanage_bool_get_value(
-	semanage_bool_t* boolean) {
+	const semanage_bool_t* boolean) {
 
 	return sepol_bool_get_value(boolean);
 }
@@ -95,7 +96,7 @@ hidden_def(semanage_bool_create)
 
 int semanage_bool_clone(
 	semanage_handle_t* handle,
-	semanage_bool_t* boolean, 
+	const semanage_bool_t* boolean, 
 	semanage_bool_t** bool_ptr) {
 
 	return sepol_bool_clone(handle->sepolh, boolean, bool_ptr);
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_active.c new/libsemanage/src/booleans_active.c
--- old/libsemanage/src/booleans_active.c	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/src/booleans_active.c	2006-01-05 14:22:11.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_bool record_t;
 
 int semanage_bool_set_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);	
 	return dbase_set(handle, dconfig, key, data);
@@ -22,7 +22,7 @@ int semanage_bool_set_active(
 
 int semanage_bool_query_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
@@ -31,7 +31,7 @@ int semanage_bool_query_active(
 
 int semanage_bool_exists_active(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
@@ -48,8 +48,9 @@ int semanage_bool_count_active(
 
 int semanage_bool_iterate_active(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/booleans_local.c	2006-01-05 14:18:46.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_bool record_t;
 
 int semanage_bool_add_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
 	return dbase_add(handle, dconfig, key, data);
@@ -22,8 +22,8 @@ int semanage_bool_add_local(
 
 int semanage_bool_modify_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);	
 	return dbase_modify(handle, dconfig, key, data);
@@ -31,8 +31,8 @@ int semanage_bool_modify_local(
 
 int semanage_bool_set_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
+	const semanage_bool_key_t* key,
+	const semanage_bool_t* data) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);	
 	return dbase_set(handle, dconfig, key, data);
@@ -40,7 +40,7 @@ int semanage_bool_set_local(
 
 int semanage_bool_del_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key) {
+	const semanage_bool_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
 	return dbase_del(handle, dconfig, key);
@@ -48,7 +48,7 @@ int semanage_bool_del_local(
 
 int semanage_bool_query_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
@@ -57,7 +57,7 @@ int semanage_bool_query_local(
 
 int semanage_bool_exists_local(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
@@ -74,8 +74,9 @@ int semanage_bool_count_local(
 
 int semanage_bool_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/booleans_policy.c	2006-01-05 14:22:25.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_bool record_t;
 
 int semanage_bool_query(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	semanage_bool_t** response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
@@ -22,7 +22,7 @@ int semanage_bool_query(
 
 int semanage_bool_exists(
 	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
+	const semanage_bool_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
@@ -39,8 +39,9 @@ int semanage_bool_count(
 
 int semanage_bool_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_bool_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/context_record.c new/libsemanage/src/context_record.c
--- old/libsemanage/src/context_record.c	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/context_record.c	2006-01-05 14:06:39.000000000 -0500
@@ -10,7 +10,7 @@ typedef sepol_context_t semanage_context
 
 /* User */
 const char* semanage_context_get_user(
-	semanage_context_t* con) {
+	const semanage_context_t* con) {
 
 	return sepol_context_get_user(con);
 }
@@ -25,7 +25,7 @@ int semanage_context_set_user(
 
 /* Role */
 const char* semanage_context_get_role(
-	semanage_context_t* con) {
+	const semanage_context_t* con) {
 
 	return sepol_context_get_role(con);
 }
@@ -39,7 +39,9 @@ int semanage_context_set_role(
 }
 
 /* Type */
-const char* semanage_context_get_type(semanage_context_t* con) {
+const char* semanage_context_get_type(
+	const semanage_context_t* con) {
+
 	return sepol_context_get_type(con);
 }
 
@@ -52,7 +54,9 @@ int semanage_context_set_type(
 }
 
 /* MLS */
-const char* semanage_context_get_mls(semanage_context_t* con) {
+const char* semanage_context_get_mls(
+	const semanage_context_t* con) {
+
 	return sepol_context_get_mls(con);
 }
 
@@ -74,13 +78,15 @@ int semanage_context_create(
 
 int semanage_context_clone(
 	semanage_handle_t* handle,
-	semanage_context_t* con, 
+	const semanage_context_t* con, 
 	semanage_context_t** con_ptr) {
 
 	return sepol_context_clone(handle->sepolh, con, con_ptr);
 }
 
-void semanage_context_free(semanage_context_t* con) {
+void semanage_context_free(
+	semanage_context_t* con) {
+
 	sepol_context_free(con);
 }
 hidden_def(semanage_context_free)
@@ -97,7 +103,7 @@ hidden_def(semanage_context_from_string)
 
 int semanage_context_to_string(
 	semanage_handle_t* handle,
-	semanage_context_t* con,
+	const semanage_context_t* con,
 	char** str_ptr) {
 
 	return sepol_context_to_string(handle->sepolh, con, str_ptr);
diff -Naurp --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/database.c	2006-01-05 14:31:35.000000000 -0500
@@ -84,8 +84,8 @@ static int enter_rw(
 int dbase_add (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
@@ -99,8 +99,8 @@ int dbase_add (
 int dbase_modify (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
@@ -114,8 +114,8 @@ int dbase_modify (
 int dbase_set (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
@@ -129,7 +129,7 @@ int dbase_set (
 int dbase_del (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key) {
+	const record_key_t* key) {
 
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
@@ -143,7 +143,7 @@ int dbase_del (
 int dbase_query (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
+	const record_key_t* key,
 	record_t** response) {
 
 	if (enter_ro(handle, dconfig) < 0)
@@ -160,7 +160,7 @@ int dbase_query (
 int dbase_exists (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
+	const record_key_t* key,
 	int* response) {
 
 	if (enter_ro(handle, dconfig) < 0)
@@ -193,7 +193,9 @@ int dbase_count (
 int dbase_iterate(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
-	int (*fn) (record_t* record, void* fn_arg),
+	int (*fn) (
+		const record_t* record, 
+		void* fn_arg),
 	void* fn_arg) {
 
 	if (enter_ro(handle, dconfig) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/database.h	2006-01-05 14:31:00.000000000 -0500
@@ -30,7 +30,7 @@ typedef struct record_table {
 	/* Extract key from record */
 	int (*key_extract) (
 		struct semanage_handle* handle,
-		record_t* rec, 
+		const record_t* rec, 
 		record_key_t** key);
 
 	/* Free record key */
@@ -41,13 +41,13 @@ typedef struct record_table {
 	 * -1 if the key represents a record that should
 	 * be ordered before this record, and 1 if vice-versa */
 	int (*compare) (
-		record_t* rec, 
-		record_key_t* key);
+		const record_t* rec, 
+		const record_key_t* key);
 
 	/* Deep-copy clone of this record */
 	int (*clone) (
 		struct semanage_handle* handle,
-		record_t* rec, 
+		const record_t* rec, 
 		record_t** new_rec);
 
 	/* Deallocate record resources. Must sucessfully handle NULL. */
@@ -72,8 +72,8 @@ typedef struct dbase_table {
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key,
-		record_t* data);
+		const record_key_t* key,
+		const record_t* data);
 
 	/* Add the specified record to the  
 	 * database if it not present. 
@@ -82,8 +82,8 @@ typedef struct dbase_table {
 	int (*modify) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key,
-		record_t* data);
+		const record_key_t* key,
+		const record_t* data);
 
 	/* Modify the specified record in the database
 	 * if it is present. Fail if it does not yet exist
@@ -91,14 +91,14 @@ typedef struct dbase_table {
 	int (*set) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key,
-		record_t* data);
+		const record_key_t* key,
+		const record_t* data);
 
 	/* Delete a record */
 	int (*del) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key);
+		const record_key_t* key);
 
 	/* Retrieve a record 
 	 * 
@@ -109,14 +109,14 @@ typedef struct dbase_table {
 	int (*query) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key,
+		const record_key_t* key,
 		record_t** response);
 
 	/* Check if a record exists */
 	int (*exists) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		record_key_t* key,
+		const record_key_t* key,
 		int* response);
 
 	/* Count the number of records */
@@ -145,7 +145,7 @@ typedef struct dbase_table {
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		int (*fn) (
-			record_t* record,
+			const record_t* record,
 			void* varg),
 		void* fn_arg);
 
@@ -206,36 +206,36 @@ typedef struct dbase_config {
 extern int dbase_add (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_modify (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_set (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_del (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key);
+	const record_key_t* key);
 
 extern int dbase_query (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
+	const record_key_t* key,
 	record_t** response);
 
 extern int dbase_exists (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	record_key_t* key,
+	const record_key_t* key,
 	int* response);
 
 extern int dbase_count (
@@ -246,7 +246,9 @@ extern int dbase_count (
 extern int dbase_iterate(
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
-	int (*fn) (record_t* record, void* fn_arg),
+	int (*fn) (
+		const record_t* record, 
+		void* fn_arg),
 	void* fn_arg);
 
 extern int dbase_list (
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2006-01-05 14:32:12.000000000 -0500
@@ -14,10 +14,10 @@ typedef struct dbase_llist dbase_t;
 #include "database_llist.h"
 
 /* Helper for adding records to the cache */
-hidden int dbase_llist_cache_prepend(
+int dbase_llist_cache_prepend(
 	semanage_handle_t* handle, 
 	dbase_llist_t* dbase,
-	record_t* data) {
+	const record_t* data) {
 
 	/* Initialize */
 	cache_entry_t* entry =
@@ -49,7 +49,7 @@ hidden int dbase_llist_cache_prepend(
 	return STATUS_ERR;
 }
 
-hidden void dbase_llist_drop_cache(
+void dbase_llist_drop_cache(
 	dbase_llist_t* dbase) {
 
 	if (!dbase->cached)
@@ -71,7 +71,7 @@ hidden void dbase_llist_drop_cache(
 static int dbase_llist_cache_locate(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	cache_entry_t** entry) {
 
 	cache_entry_t* ptr;
@@ -94,10 +94,10 @@ static int dbase_llist_cache_locate(
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_exists(
+int dbase_llist_exists(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	int* response) {
 
 	cache_entry_t* entry;
@@ -115,11 +115,11 @@ hidden int dbase_llist_exists(
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_add(
+int dbase_llist_add(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	int status;
 	cache_entry_t* entry;
@@ -144,11 +144,11 @@ hidden int dbase_llist_add(
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_set(
+int dbase_llist_set(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	cache_entry_t* entry;
 	int status;
@@ -175,11 +175,11 @@ hidden int dbase_llist_set(
 }
 
 
-hidden int dbase_llist_modify(
+int dbase_llist_modify(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	cache_entry_t* entry;
 	int status;
@@ -215,10 +215,10 @@ hidden int dbase_llist_count(
 	return STATUS_SUCCESS;
 }
 
-hidden int dbase_llist_query(
+int dbase_llist_query(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	record_t** response) {
 
 	cache_entry_t* entry;
@@ -238,10 +238,12 @@ hidden int dbase_llist_query(
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_iterate(
+int dbase_llist_iterate(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase, 
-	int (*fn) (record_t* record, void* fn_arg),
+	int (*fn) (
+		const record_t* record, 
+		void* fn_arg),
 	void* arg) {
 
 	int rc;
@@ -265,10 +267,10 @@ hidden int dbase_llist_iterate(
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_del(
+int dbase_llist_del(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key) {
+	const record_key_t* key) {
 
 	cache_entry_t *ptr, *prev = NULL;
 
@@ -298,7 +300,7 @@ hidden int dbase_llist_del(
 	return STATUS_SUCCESS;
 }
 
-hidden int dbase_llist_list(
+int dbase_llist_list(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
 	record_t*** records,
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/database_llist.h	2006-01-05 14:32:29.000000000 -0500
@@ -55,7 +55,7 @@ static inline void dbase_llist_init(
 extern int dbase_llist_cache_prepend(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_t* data);
+	const record_t* data);
 
 static inline int dbase_llist_is_cached(
 	dbase_llist_t* dbase) {
@@ -94,26 +94,26 @@ static inline record_table_t* dbase_llis
 extern int dbase_llist_exists(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	int* response);
 
 extern int dbase_llist_add(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_llist_set(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_llist_modify(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
-	record_t* data);
+	const record_key_t* key,
+	const record_t* data);
 
 extern int dbase_llist_count(
 	semanage_handle_t* handle,
@@ -123,19 +123,21 @@ extern int dbase_llist_count(
 extern int dbase_llist_query(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	record_t** response);
 
 extern int dbase_llist_iterate(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	int (*fn) (record_t* record, void* fn_arg),
+	int (*fn) (
+		const record_t* record, 
+		void* fn_arg),
 	void* arg);
 
 extern int dbase_llist_del(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
-	record_key_t* key);
+	const record_key_t* key);
 
 extern int dbase_llist_list(
 	semanage_handle_t* handle,
diff -Naurp --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2006-01-05 14:35:06.000000000 -0500
@@ -220,8 +220,8 @@ void dbase_policydb_detach(
 static int dbase_policydb_add (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 	
 	if (dbase->rptable->add(handle->sepolh,	
 		dbase->policydb, key, data) < 0)
@@ -238,8 +238,8 @@ static int dbase_policydb_add (
 static int dbase_policydb_set(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	if (dbase->rptable->set(handle->sepolh, 
 		dbase->policydb, key, data) < 0)
@@ -256,8 +256,8 @@ static int dbase_policydb_set(
 static int dbase_policydb_modify (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key,
-	record_t* data) {
+	const record_key_t* key,
+	const record_t* data) {
 
 	if (dbase->rptable->modify(handle->sepolh, 
 		dbase->policydb, key, data) < 0)
@@ -274,7 +274,7 @@ static int dbase_policydb_modify (
 static int dbase_policydb_del (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key) {
+	const record_key_t* key) {
 
 	/* Stub */
 	key = NULL;
@@ -286,7 +286,7 @@ static int dbase_policydb_del (
 static int dbase_policydb_query (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	record_t** response) {
 
 	if (dbase->rptable->query(handle->sepolh,
@@ -303,7 +303,7 @@ static int dbase_policydb_query (
 static int dbase_policydb_exists (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	record_key_t* key,
+	const record_key_t* key,
 	int* response) {
 
 	if (dbase->rptable->exists(handle->sepolh, 
@@ -336,7 +336,9 @@ static int dbase_policydb_count (
 static int dbase_policydb_iterate(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	int (*fn) (record_t* record, void* fn_arg),
+	int (*fn) (
+		const record_t* record, 
+		void* fn_arg),
 	void* arg) {
 
 	if (dbase->rptable->iterate(handle->sepolh,
@@ -358,7 +360,7 @@ struct list_handler_arg {
 };
 
 static int list_handler(
-	record_t* record,
+	const record_t* record,
 	void* varg) {
 
 	struct list_handler_arg* arg = 
diff -Naurp --exclude-from excludes old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/database_policydb.h	2006-01-05 14:33:52.000000000 -0500
@@ -18,50 +18,52 @@ typedef struct record_policydb_table {
 	int (*add) (
 		sepol_handle_t* handle,
 		sepol_policydb_t* policydb, 
-		record_key_t* rkey,
-		record_t* record);
+		const record_key_t* rkey,
+		const record_t* record);
 
 	/* Modify policy record, or add if 
 	 * the key isn't found */
 	int (*modify) (
 		sepol_handle_t* handle,
 		sepol_policydb_t* policydb, 
-		record_key_t* rkey,
-		record_t* record);
+		const record_key_t* rkey,
+		const record_t* record);
 
 	/* Set policy record */
 	int (*set) (
 		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
-		record_key_t* rkey,
-		record_t* record);
+		const record_key_t* rkey,
+		const record_t* record);
 
 	/* Query policy record  - return the record
 	 * or NULL if it isn't found */
 	int (*query) (
 		sepol_handle_t* handle,
-		sepol_policydb_t* policydb,
-		record_key_t* rkey,
+		const sepol_policydb_t* policydb,
+		const record_key_t* rkey,
 		record_t** response);
 
 	/* Count records */
 	int (*count) (
 		sepol_handle_t* handle,
-		sepol_policydb_t* policydb,
+		const sepol_policydb_t* policydb,
 		unsigned int* response);
 
 	/* Check if a record exists */
 	int (*exists) (
 		sepol_handle_t* handle,
-		sepol_policydb_t* policydb,
-		record_key_t* rkey,
+		const sepol_policydb_t* policydb,
+		const record_key_t* rkey,
 		int* response);
 		
 	/* Iterate over records */
 	int (*iterate) (
 		sepol_handle_t* handle,
-		sepol_policydb_t* policydb,
-		int (*fn)(record_t* record, void* fn_arg),
+		const sepol_policydb_t* policydb,
+		int (*fn)(
+			const record_t* record, 
+			void* fn_arg),
 		void* arg);
 
 } record_policydb_table_t;
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2006-01-05 14:07:40.000000000 -0500
@@ -55,7 +55,7 @@ int semanage_fcontext_key_create(
 
 int semanage_fcontext_key_extract(
 	semanage_handle_t* handle,
-	semanage_fcontext_t* fcontext, 
+	const semanage_fcontext_t* fcontext, 
 	semanage_fcontext_key_t** key_ptr) {
 
 	if (semanage_fcontext_key_create(handle, fcontext->expr, 
@@ -69,13 +69,14 @@ int semanage_fcontext_key_extract(
 	return STATUS_SUCCESS;
 }
 
-void semanage_fcontext_key_free(semanage_fcontext_key_t* key) {
+void semanage_fcontext_key_free(
+	semanage_fcontext_key_t* key) {
 	free(key);
 }
 
 int semanage_fcontext_compare(
-	semanage_fcontext_t* fcontext, 
-	semanage_fcontext_key_t* key) {
+	const semanage_fcontext_t* fcontext, 
+	const semanage_fcontext_key_t* key) {
 
 	return strcmp(fcontext->expr, key->expr) && 
 		(fcontext->type == key->type);
@@ -104,7 +105,9 @@ int semanage_fcontext_create(
 }
 
 /* Regexp */
-const char* semanage_fcontext_get_expr(semanage_fcontext_t* fcontext) {
+const char* semanage_fcontext_get_expr(
+	const semanage_fcontext_t* fcontext) {
+
 	return fcontext->expr;
 }
 
@@ -125,11 +128,15 @@ int semanage_fcontext_set_expr(
 }
 
 /* Type */
-int semanage_fcontext_get_type(semanage_fcontext_t* fcontext) {
+int semanage_fcontext_get_type(
+	const semanage_fcontext_t* fcontext) {
+
 	return fcontext->type;
 }
 
-const char* semanage_fcontext_get_type_str(semanage_fcontext_t* fcontext) {
+const char* semanage_fcontext_get_type_str(
+	const semanage_fcontext_t* fcontext) {
+
 	switch (fcontext->type) {
 		default:
 		case SEMANAGE_FCONTEXT_ALL:
@@ -159,7 +166,9 @@ void semanage_fcontext_set_type(
 }
 
 /* Context */
-semanage_context_t* semanage_fcontext_get_con(semanage_fcontext_t* fcontext) {
+semanage_context_t* semanage_fcontext_get_con(
+	const semanage_fcontext_t* fcontext) {
+
 	return fcontext->con;
 }
 
@@ -174,7 +183,7 @@ void semanage_fcontext_set_con(
 /* Deep copy clone */
 int semanage_fcontext_clone(
 	semanage_handle_t* handle,
-	semanage_fcontext_t* fcontext, 
+	const semanage_fcontext_t* fcontext, 
 	semanage_fcontext_t** fcontext_ptr) {
 
 	semanage_fcontext_t* new_fcontext = NULL;
@@ -200,7 +209,9 @@ int semanage_fcontext_clone(
 }
 
 /* Destroy */
-void semanage_fcontext_free(semanage_fcontext_t* fcontext) {
+void semanage_fcontext_free(
+	semanage_fcontext_t* fcontext) {
+
 	if (!fcontext)
 		return;
 
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/fcontexts_local.c	2006-01-05 14:19:16.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_fcontext record_
 
 int semanage_fcontext_add_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data) {
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
 	return dbase_add(handle, dconfig, key, data);
@@ -22,8 +22,8 @@ int semanage_fcontext_add_local(
 
 int semanage_fcontext_modify_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data) {
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);	
 	return dbase_modify(handle, dconfig, key, data);
@@ -31,8 +31,8 @@ int semanage_fcontext_modify_local(
 
 int semanage_fcontext_set_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
-	semanage_fcontext_t* data) {
+	const semanage_fcontext_key_t* key,
+	const semanage_fcontext_t* data) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);	
 	return dbase_set(handle, dconfig, key, data);
@@ -40,7 +40,7 @@ int semanage_fcontext_set_local(
 
 int semanage_fcontext_del_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key) {
+	const semanage_fcontext_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
 	return dbase_del(handle, dconfig, key);
@@ -48,7 +48,7 @@ int semanage_fcontext_del_local(
 
 int semanage_fcontext_query_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	semanage_fcontext_t** response) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
@@ -57,7 +57,7 @@ int semanage_fcontext_query_local(
 
 int semanage_fcontext_exists_local(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
@@ -74,8 +74,9 @@ int semanage_fcontext_count_local(
 
 int semanage_fcontext_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_fcontext_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_fcontext_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_policy.c new/libsemanage/src/fcontexts_policy.c
--- old/libsemanage/src/fcontexts_policy.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/fcontexts_policy.c	2006-01-05 14:22:38.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_fcontext record_
 
 int semanage_fcontext_query(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	semanage_fcontext_t** response) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
@@ -22,7 +22,7 @@ int semanage_fcontext_query(
 
 int semanage_fcontext_exists(
 	semanage_handle_t* handle,
-	semanage_fcontext_key_t* key,
+	const semanage_fcontext_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
@@ -39,8 +39,9 @@ int semanage_fcontext_count(
 
 int semanage_fcontext_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_fcontext_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_fcontext_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2006-01-05 14:08:12.000000000 -0500
@@ -25,8 +25,8 @@ typedef sepol_iface_key_t record_key_t;
 
 /* Key */
 int semanage_iface_compare(
-	semanage_iface_t* iface, 
-	semanage_iface_key_t* key) {
+	const semanage_iface_t* iface, 
+	const semanage_iface_key_t* key) {
 
 	return sepol_iface_compare(iface, key);
 }
@@ -42,7 +42,7 @@ int semanage_iface_key_create(
 
 int semanage_iface_key_extract(
 	semanage_handle_t* handle,
-	semanage_iface_t* iface,
+	const semanage_iface_t* iface,
 	semanage_iface_key_t** key_ptr) {
 
 	return sepol_iface_key_extract(handle->sepolh, iface, key_ptr);
@@ -58,7 +58,7 @@ hidden_def(semanage_iface_key_free)
 
 /* Name */
 const char* semanage_iface_get_name(
-	semanage_iface_t* iface) {
+	const semanage_iface_t* iface) {
 
         return sepol_iface_get_name(iface);
 }
@@ -75,7 +75,7 @@ hidden_def(semanage_iface_set_name)
 	
 /* Context */
 semanage_context_t* semanage_iface_get_ifcon(
-	semanage_iface_t* iface) {
+	const semanage_iface_t* iface) {
 
 	return sepol_iface_get_ifcon(iface);
 }
@@ -90,7 +90,7 @@ void semanage_iface_set_ifcon(
 hidden_def(semanage_iface_set_ifcon)
 
 semanage_context_t* semanage_iface_get_msgcon(
-	semanage_iface_t* iface) {
+	const semanage_iface_t* iface) {
 
 	return sepol_iface_get_msgcon(iface);	
 }
@@ -115,7 +115,7 @@ hidden_def(semanage_iface_create)
 
 int semanage_iface_clone(
 	semanage_handle_t* handle,
-	semanage_iface_t* iface, 
+	const semanage_iface_t* iface, 
 	semanage_iface_t** iface_ptr) {
 
 	return sepol_iface_clone(handle->sepolh, iface, iface_ptr);
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/interfaces_local.c	2006-01-05 14:19:45.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_iface record_t;
 
 int semanage_iface_add_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
 	return dbase_add(handle, dconfig, key, data);
@@ -22,8 +22,8 @@ int semanage_iface_add_local(
 
 int semanage_iface_modify_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);	
 	return dbase_modify(handle, dconfig, key, data);
@@ -31,8 +31,8 @@ int semanage_iface_modify_local(
 
 int semanage_iface_set_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
+	const semanage_iface_key_t* key,
+	const semanage_iface_t* data) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);	
 	return dbase_set(handle, dconfig, key, data);
@@ -40,7 +40,7 @@ int semanage_iface_set_local(
 
 int semanage_iface_del_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key) {
+	const semanage_iface_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
 	return dbase_del(handle, dconfig, key);
@@ -48,7 +48,7 @@ int semanage_iface_del_local(
 
 int semanage_iface_query_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	semanage_iface_t** response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
@@ -57,7 +57,7 @@ int semanage_iface_query_local(
 
 int semanage_iface_exists_local(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
@@ -74,8 +74,9 @@ int semanage_iface_count_local(
 
 int semanage_iface_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_iface_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/interfaces_policy.c	2006-01-05 14:22:54.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_iface record_t;
 
 int semanage_iface_query(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	semanage_iface_t** response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
@@ -22,7 +22,7 @@ int semanage_iface_query(
 
 int semanage_iface_exists(
 	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
+	const semanage_iface_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
@@ -39,8 +39,9 @@ int semanage_iface_count(
 
 int semanage_iface_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_iface_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-01-05 14:35:18.000000000 -0500
@@ -68,7 +68,7 @@ typedef struct load_handler_arg {
 } load_handler_arg_t;
 
 static int load_handler(
-	record_t* record,
+	const record_t* record,
 	void* varg) {
 
 	record_key_t* rkey = NULL;
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/port_record.c	2006-01-05 14:08:47.000000000 -0500
@@ -25,8 +25,8 @@ typedef semanage_port_key_t record_key_t
 
 /* Key */
 int semanage_port_compare(
-	semanage_port_t* port, 
-	semanage_port_key_t* key) {
+	const semanage_port_t* port, 
+	const semanage_port_key_t* key) {
 
 	return sepol_port_compare(port, key);
 }
@@ -41,7 +41,7 @@ int semanage_port_key_create(
 
 int semanage_port_key_extract(
 	semanage_handle_t* handle,
-	semanage_port_t* port,
+	const semanage_port_t* port,
 	semanage_port_key_t** key_ptr) {
 
 	return sepol_port_key_extract(handle->sepolh, port, key_ptr);
@@ -55,7 +55,7 @@ void semanage_port_key_free(
 
 /* Protocol */
 int semanage_port_get_proto(
-	semanage_port_t* port) {
+	const semanage_port_t* port) {
 
 	return sepol_port_get_proto(port);
 }
@@ -68,20 +68,20 @@ void semanage_port_set_proto(
 }
 
 const char* semanage_port_get_proto_str(
-	semanage_port_t* port) {
+	const semanage_port_t* port) {
 
 	return sepol_port_get_proto_str(port);
 }
 
 /* Port */
 int semanage_port_get_low(
-	semanage_port_t* port) {
+	const semanage_port_t* port) {
 
 	return sepol_port_get_low(port);
 }
 
 int semanage_port_get_high(
-	semanage_port_t* port) {
+	const semanage_port_t* port) {
 
 	return sepol_port_get_high(port);
 }
@@ -102,7 +102,7 @@ void semanage_port_set_range(
 
 /* Context */
 semanage_context_t* semanage_port_get_con(
-	semanage_port_t* port) {
+	const semanage_port_t* port) {
 
 	return sepol_port_get_con(port);	
 }
@@ -124,7 +124,7 @@ int semanage_port_create(
 
 int semanage_port_clone(
 	semanage_handle_t* handle,
-	semanage_port_t* port, 
+	const semanage_port_t* port, 
 	semanage_port_t** port_ptr) {
 
 	return sepol_port_clone(handle->sepolh, port, port_ptr);
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/ports_local.c	2006-01-05 14:20:14.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_port record_t;
 
 int semanage_port_add_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
+	const semanage_port_key_t* key,
+	const semanage_port_t* data) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);	
 	return dbase_add(handle, dconfig, key, data);
@@ -22,8 +22,8 @@ int semanage_port_add_local(
 
 int semanage_port_modify_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
+	const semanage_port_key_t* key,
+	const semanage_port_t* data) {
 	
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dbase_modify(handle, dconfig, key, data);
@@ -31,8 +31,8 @@ int semanage_port_modify_local(
 
 int semanage_port_set_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
+	const semanage_port_key_t* key,
+	const semanage_port_t* data) {
 	
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dbase_set(handle, dconfig, key, data);
@@ -40,7 +40,7 @@ int semanage_port_set_local(
 
 int semanage_port_del_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key) {
+	const semanage_port_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dbase_del(handle, dconfig, key);
@@ -48,7 +48,7 @@ int semanage_port_del_local(
 
 int semanage_port_query_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	semanage_port_t** response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
@@ -57,7 +57,7 @@ int semanage_port_query_local(
 
 int semanage_port_exists_local(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
@@ -74,8 +74,9 @@ int semanage_port_count_local(
 
 int semanage_port_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_port_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/ports_policy.c	2006-01-05 14:23:07.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_port record_t;
 
 int semanage_port_query(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	semanage_port_t** response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
@@ -22,7 +22,7 @@ int semanage_port_query(
 
 int semanage_port_exists(
 	semanage_handle_t* handle,
-	semanage_port_key_t* key,
+	const semanage_port_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
@@ -39,8 +39,9 @@ int semanage_port_count(
 
 int semanage_port_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_port_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2006-01-05 14:21:52.000000000 -0500
@@ -35,6 +35,6 @@ extern void seuser_file_dbase_release(
 
 extern int hidden semanage_seuser_validate(
 	semanage_handle_t* handle,
-	sepol_policydb_t* policydb);
+	const sepol_policydb_t* policydb);
 
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2006-01-05 14:09:20.000000000 -0500
@@ -68,7 +68,7 @@ hidden_def(semanage_seuser_key_create)
 
 int semanage_seuser_key_extract(
 	semanage_handle_t* handle,
-	semanage_seuser_t* seuser, 
+	const semanage_seuser_t* seuser, 
 	semanage_seuser_key_t** key_ptr) {
 
 	if (semanage_seuser_key_create(handle, seuser->name, key_ptr) < 0)
@@ -82,14 +82,16 @@ int semanage_seuser_key_extract(
 }	
 hidden_def(semanage_seuser_key_extract)
 
-void semanage_seuser_key_free(semanage_seuser_key_t* key) {
+void semanage_seuser_key_free(
+	semanage_seuser_key_t* key) {
+
 	free(key);
 }
 hidden_def(semanage_seuser_key_free)
 
 int semanage_seuser_compare(
-	semanage_seuser_t* seuser,
-	semanage_seuser_key_t* key) {
+	const semanage_seuser_t* seuser,
+	const semanage_seuser_key_t* key) {
 
 	return strcmp(seuser->name, key->name);	
 }
@@ -97,7 +99,7 @@ hidden_def(semanage_seuser_compare)
 
 /* Name */
 const char* semanage_seuser_get_name(
-	semanage_seuser_t* seuser) {
+	const semanage_seuser_t* seuser) {
 
 	return seuser->name;
 }
@@ -121,7 +123,7 @@ hidden_def(semanage_seuser_set_name)
 
 /* Selinux Name */
 const char* semanage_seuser_get_sename(
-	semanage_seuser_t* seuser) {
+	const semanage_seuser_t* seuser) {
 
 	return seuser->sename;
 }
@@ -145,7 +147,7 @@ hidden_def(semanage_seuser_set_sename)
 
 /* MLS Range */
 const char* semanage_seuser_get_mlsrange(
-	semanage_seuser_t* seuser) {
+	const semanage_seuser_t* seuser) {
 
 	return seuser->mls_range;
 }
@@ -192,7 +194,7 @@ hidden_def(semanage_seuser_create)
 /* Deep copy clone */
 int semanage_seuser_clone(
 	semanage_handle_t* handle,
-	semanage_seuser_t* seuser, 
+	const semanage_seuser_t* seuser, 
 	semanage_seuser_t** seuser_ptr) {
 
 	semanage_seuser_t* new_seuser = NULL;
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/seusers.c	2006-01-05 14:37:19.000000000 -0500
@@ -17,8 +17,8 @@ typedef struct semanage_seuser record_t;
 
 int semanage_seuser_add(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data) {
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dbase_add(handle, dconfig, key, data);
@@ -26,8 +26,8 @@ int semanage_seuser_add(
 
 int semanage_seuser_modify(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data) {
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);	
 	return dbase_modify(handle, dconfig, key, data);
@@ -35,8 +35,8 @@ int semanage_seuser_modify(
 
 int semanage_seuser_set(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
-	semanage_seuser_t* data) {
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dbase_set(handle, dconfig, key, data);
@@ -44,7 +44,7 @@ int semanage_seuser_set(
 
 int semanage_seuser_del(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key) {
+	const semanage_seuser_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dbase_del(handle, dconfig, key);
@@ -52,7 +52,7 @@ int semanage_seuser_del(
 
 int semanage_seuser_query(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
+	const semanage_seuser_key_t* key,
 	semanage_seuser_t** response) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
@@ -61,7 +61,7 @@ int semanage_seuser_query(
 
 int semanage_seuser_exists(
 	semanage_handle_t* handle,
-	semanage_seuser_key_t* key,
+	const semanage_seuser_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
@@ -78,8 +78,9 @@ int semanage_seuser_count(
 
 int semanage_seuser_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_seuser_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
@@ -99,11 +100,11 @@ int semanage_seuser_list(
 
 struct validate_handler_arg {
 	semanage_handle_t* handle;
-	sepol_policydb_t* policydb;
+	const sepol_policydb_t* policydb;
 };
 
 static int validate_handler(
-	semanage_seuser_t* seuser,
+	const semanage_seuser_t* seuser,
 	void* varg) {
 
 	semanage_user_t* user = NULL;
@@ -114,7 +115,7 @@ static int validate_handler(
 	struct validate_handler_arg* arg = 
 		(struct validate_handler_arg*) varg;
 	semanage_handle_t* handle = arg->handle;
-	sepol_policydb_t* policydb = arg->policydb;
+	const sepol_policydb_t* policydb = arg->policydb;
 
 	/* Unpack seuser */
 	const char* name = semanage_seuser_get_name(seuser);
@@ -176,7 +177,7 @@ static int validate_handler(
 
 int hidden semanage_seuser_validate(
 	semanage_handle_t* handle,	
-	sepol_policydb_t* policydb) {
+	const sepol_policydb_t* policydb) {
 
 	struct validate_handler_arg arg;
 	arg.handle = handle;
diff -Naurp --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/user_record.c	2006-01-05 14:09:53.000000000 -0500
@@ -35,7 +35,7 @@ hidden_def(semanage_user_key_create)
 
 int semanage_user_key_extract(
 	semanage_handle_t* handle,
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	semanage_user_key_t** key) {
 
 	return sepol_user_key_extract(handle->sepolh, user, key);
@@ -50,8 +50,8 @@ void semanage_user_key_free(
 hidden_def(semanage_user_key_free)
 
 int semanage_user_compare(
-	semanage_user_t* user, 
-	semanage_user_key_t* key) {
+	const semanage_user_t* user, 
+	const semanage_user_key_t* key) {
 
 	return sepol_user_compare(user, key);
 }
@@ -59,7 +59,7 @@ hidden_def(semanage_user_compare)
 	
 /* Name */
 const char* semanage_user_get_name(
-	semanage_user_t* user) {
+	const semanage_user_t* user) {
 
 	return sepol_user_get_name(user);
 }
@@ -76,7 +76,7 @@ hidden_def(semanage_user_set_name)
 
 /* MLS */
 const char* semanage_user_get_mlslevel(
-	semanage_user_t* user) {
+	const semanage_user_t* user) {
 
 	return sepol_user_get_mlslevel(user);
 }
@@ -92,7 +92,7 @@ int semanage_user_set_mlslevel(
 hidden_def(semanage_user_set_mlslevel)
 
 const char* semanage_user_get_mlsrange(
-	semanage_user_t* user) {
+	const semanage_user_t* user) {
 
 	return sepol_user_get_mlsrange(user);
 }
@@ -109,7 +109,7 @@ hidden_def(semanage_user_set_mlsrange)
 
 /* Role management */
 int semanage_user_get_num_roles(
-	semanage_user_t* user) {
+	const semanage_user_t* user) {
 
 	return sepol_user_get_num_roles(user);
 }
@@ -131,7 +131,7 @@ void semanage_user_del_role(
 }
 
 int semanage_user_has_role(
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	const char* role) {
 
 	return sepol_user_has_role(user, role);
@@ -139,7 +139,7 @@ int semanage_user_has_role(
 
 int semanage_user_get_roles(
 	semanage_handle_t* handle,
-	semanage_user_t* user,
+	const semanage_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles) {
 
@@ -167,7 +167,7 @@ hidden_def(semanage_user_create)
 
 int semanage_user_clone(
 	semanage_handle_t* handle,
-	semanage_user_t* user, 
+	const semanage_user_t* user, 
 	semanage_user_t** user_ptr) {
 
 	return sepol_user_clone(handle->sepolh, user, user_ptr);
diff -Naurp --exclude-from excludes old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/users_local.c	2006-01-05 14:20:41.000000000 -0500
@@ -13,8 +13,8 @@ typedef struct semanage_user record_t;
 
 int semanage_user_add_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
+	const semanage_user_key_t* key,
+	const semanage_user_t* data) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
 	return dbase_add(handle, dconfig, key, data);
@@ -22,8 +22,8 @@ int semanage_user_add_local(
 
 int semanage_user_modify_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
+	const semanage_user_key_t* key,
+	const semanage_user_t* data) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);	
 	return dbase_modify(handle, dconfig, key, data);
@@ -32,8 +32,8 @@ int semanage_user_modify_local(
 
 int semanage_user_set_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
+	const semanage_user_key_t* key,
+	const semanage_user_t* data) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);	
 	return dbase_set(handle, dconfig, key, data);
@@ -41,7 +41,7 @@ int semanage_user_set_local(
 
 int semanage_user_del_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key) {
+	const semanage_user_key_t* key) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
 	return dbase_del(handle, dconfig, key);
@@ -49,7 +49,7 @@ int semanage_user_del_local(
 
 int semanage_user_query_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	semanage_user_t** response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
@@ -58,7 +58,7 @@ int semanage_user_query_local(
 
 int semanage_user_exists_local(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
@@ -75,8 +75,9 @@ int semanage_user_count_local(
 
 int semanage_user_iterate_local(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_user_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-12-13 10:43:23.000000000 -0500
+++ new/libsemanage/src/users_policy.c	2006-01-05 14:23:27.000000000 -0500
@@ -13,7 +13,7 @@ typedef struct semanage_user record_t;
 
 int semanage_user_query(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	semanage_user_t** response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
@@ -22,7 +22,7 @@ int semanage_user_query(
 
 int semanage_user_exists(
 	semanage_handle_t* handle,
-	semanage_user_key_t* key,
+	const semanage_user_key_t* key,
 	int* response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
@@ -40,8 +40,9 @@ int semanage_user_count(
 
 int semanage_user_iterate(
 	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
+	int (*handler) (
+		const semanage_user_t* record,
+		void* varg),
 	void* handler_arg) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);

--------------090702020805040904070005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
