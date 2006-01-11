Message-ID: <43C592E9.20900@cornell.edu>
Date: Wed, 11 Jan 2006 16:21:13 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
Subject: [SEMANAGE] [SEPOL] Change size_t -> unsigned int 
Content-Type: multipart/mixed;
 boundary="------------070603040609070505000202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070603040609070505000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The count functions work with unsigned int. The list functions work with 
size_t, and do not convert unsigned int properly, breaking 64-bit 
platforms. Size_t = unsigned int | unsigned long int, and long int >= 
int. I was also told on #selinux that a size_t usually indicates a value 
measured in bytes. Therefore, size_t does not seem appropriate in the 
list() function.

Please consider the following patch, which changes list functions in 
many places to use unsigned int, instead of size_t.
I also changed get_roles/set_roles in the user record. Also, fixed an 
unitialized variable bug in the error path of booleans_activedb.c: 
bool_read_list, reported out by Sergey Tikhonov (bugzilla).

Technically this is an API change, but I doubt it will cause any 
problems - it's much more likely to solve problems on 64-bit platforms.




--------------070603040609070505000202
Content-Type: text/x-patch;
 name="libsemanage.libsepol.size_t.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.libsepol.size_t.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/booleans_active.h new/libsemanage/include/semanage/booleans_active.h
--- old/libsemanage/include/semanage/booleans_active.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/booleans_active.h	2006-01-11 14:30:22.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_BOOLEANS_ACTIVE_H_
 #define _SEMANAGE_BOOLEANS_ACTIVE_H_
 
-#include <stddef.h>
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
@@ -36,6 +35,6 @@ extern int semanage_bool_iterate_active(
 extern int semanage_bool_list_active(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/booleans_local.h	2006-01-11 14:30:09.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_BOOLEANS_LOCAL_H_
 #define _SEMANAGE_BOOLEANS_LOCAL_H_
 
-#include <stddef.h>
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_bool_iterate_local(
 extern int semanage_bool_list_local(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/booleans_policy.h	2006-01-11 14:27:57.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_BOOLEANS_POLICY_H_
 #define _SEMANAGE_BOOLEANS_POLICY_H_
 
-#include <stddef.h>
 #include <semanage/handle.h> 
 #include <semanage/boolean_record.h>
 
@@ -31,6 +30,6 @@ extern int semanage_bool_iterate(
 extern int semanage_bool_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* size);
+	unsigned int* size);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/fcontexts_local.h new/libsemanage/include/semanage/fcontexts_local.h
--- old/libsemanage/include/semanage/fcontexts_local.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/fcontexts_local.h	2006-01-11 14:30:38.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_FCONTEXTS_LOCAL_H_
 #define _SEMANAGE_FCONTEXTS_LOCAL_H_
 
-#include <stddef.h>
 #include <semanage/fcontext_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_fcontext_iterate_loc
 extern int semanage_fcontext_list_local(
 	semanage_handle_t* handle,
 	semanage_fcontext_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/fcontexts_policy.h new/libsemanage/include/semanage/fcontexts_policy.h
--- old/libsemanage/include/semanage/fcontexts_policy.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/fcontexts_policy.h	2006-01-11 14:31:53.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_FCONTEXTS_POLICY_H_
 #define _SEMANAGE_FCONTEXTS_POLICY_H_
 
-#include <stddef.h>
 #include <semanage/fcontext_record.h>
 #include <semanage/handle.h>
 
@@ -31,6 +30,6 @@ extern int semanage_fcontext_iterate(
 extern int semanage_fcontext_list(
 	semanage_handle_t* handle,
 	semanage_fcontext_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/interfaces_local.h	2006-01-11 14:30:00.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_INTERFACES_LOCAL_H_
 #define _SEMANAGE_INTERFACES_LOCAL_H_
 
-#include <stddef.h>
 #include <semanage/iface_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_iface_iterate_local(
 extern int semanage_iface_list_local(
 	semanage_handle_t* handle,
 	semanage_iface_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/interfaces_policy.h new/libsemanage/include/semanage/interfaces_policy.h
--- old/libsemanage/include/semanage/interfaces_policy.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/interfaces_policy.h	2006-01-11 14:29:52.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_INTERFACES_POLICY_H_
 #define _SEMANAGE_INTERFACES_POLICY_H_
 
-#include <stddef.h>
 #include <semanage/handle.h> 
 #include <semanage/iface_record.h>
 
@@ -31,6 +30,6 @@ extern int semanage_iface_iterate(
 extern int semanage_iface_list(
 	semanage_handle_t* handle,
 	semanage_iface_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/ports_local.h	2006-01-11 14:29:32.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_PORTS_LOCAL_H_
 #define _SEMANAGE_PORTS_LOCAL_H_
 
-#include <stddef.h>
 #include <semanage/port_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_port_iterate_local(
 extern int semanage_port_list_local(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/ports_policy.h new/libsemanage/include/semanage/ports_policy.h
--- old/libsemanage/include/semanage/ports_policy.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/ports_policy.h	2006-01-11 14:29:41.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_PORTS_POLICY_H_
 #define _SEMANAGE_PORTS_POLICY_H_
 
-#include <stddef.h>
 #include <semanage/handle.h> 
 #include <semanage/port_record.h>
 
@@ -31,6 +30,6 @@ extern int semanage_port_iterate(
 extern int semanage_port_list(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/seusers.h	2006-01-11 14:46:00.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_SEUSERS_H_
 #define _SEMANAGE_SEUSERS_H_
 
-#include <stddef.h>
 #include <semanage/seuser_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_seuser_iterate(
 extern int semanage_seuser_list(
 	semanage_handle_t* handle,
 	semanage_seuser_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/user_record.h	2006-01-11 14:51:19.000000000 -0700
@@ -83,13 +83,13 @@ extern int semanage_user_get_roles(
 	semanage_handle_t* handle,
 	const semanage_user_t* user,
 	const char*** roles_arr, 
-	size_t* num_roles);
+	unsigned int* num_roles);
 
 extern int semanage_user_set_roles(
 	semanage_handle_t* handle,
 	semanage_user_t* user,
 	const char** roles_arr,
-	size_t num_roles);
+	unsigned int num_roles);
 
 /* Create/Clone/Destroy */
 extern int semanage_user_create(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/users_local.h	2006-01-11 14:29:21.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_USERS_LOCAL_H_
 #define _SEMANAGE_USERS_LOCAL_H_
 
-#include <stddef.h>
 #include <semanage/user_record.h>
 #include <semanage/handle.h>
 
@@ -40,6 +39,6 @@ extern int semanage_user_iterate_local(
 extern int semanage_user_list_local(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/users_policy.h new/libsemanage/include/semanage/users_policy.h
--- old/libsemanage/include/semanage/users_policy.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/include/semanage/users_policy.h	2006-01-11 14:29:14.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_USERS_POLICY_H_
 #define _SEMANAGE_USERS_POLICY_H_
 
-#include <stddef.h>
 #include <semanage/handle.h> 
 #include <semanage/user_record.h>
 
@@ -31,6 +30,6 @@ extern int semanage_user_iterate(
 extern int semanage_user_list(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_user_list_local.3 new/libsemanage/man/man3/semanage_user_list_local.3
--- old/libsemanage/man/man3/semanage_user_list_local.3	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_list_local.3	2006-01-11 16:01:30.000000000 -0700
@@ -76,7 +76,7 @@ user, port, fcontext, iface, seuser
 .br
 .BI "	semanage_user_t ***" objects ","
 .br
-.BI "	size_t* " count ");"
+.BI "	unsigned int* " count ");"
 
 .SH "DESCRIPTION"
 .TP
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/booleans_active.c new/libsemanage/src/booleans_active.c
--- old/libsemanage/src/booleans_active.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/booleans_active.c	2006-01-11 14:24:35.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_bool_key record_
 typedef struct semanage_bool record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "boolean_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -60,7 +59,7 @@ int semanage_bool_iterate_active(
 int semanage_bool_list_active(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/booleans_activedb.c new/libsemanage/src/booleans_activedb.c
--- old/libsemanage/src/booleans_activedb.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/booleans_activedb.c	2006-01-11 15:01:27.000000000 -0700
@@ -22,10 +22,10 @@ typedef struct dbase_activedb dbase_t;
 static int bool_read_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** booleans,
-	size_t* count) {
+	unsigned int* count) {
 
 	semanage_bool_t** tmp_booleans = NULL;
-	size_t tmp_count = 0;
+	unsigned int tmp_count = 0;
 	int i;
 
 	char** names = NULL;
@@ -82,7 +82,7 @@ static int bool_read_list(
 	for (i=0; i < len; i++)
 		free(names[i]);
 	free(names);
-	for (i=0; (size_t) i < tmp_count; i++)
+	for (i=0; (unsigned int) i < tmp_count; i++)
 		semanage_bool_free(tmp_booleans[i]);
 	free(tmp_booleans);
 	return STATUS_ERR;
@@ -91,11 +91,11 @@ static int bool_read_list(
 static int bool_commit_list(
 	semanage_handle_t* handle,
 	semanage_bool_t** booleans,
-	size_t count) {
+	unsigned int count) {
 
 	SELboolean* blist = NULL;
-	size_t bcount = 0;
-	size_t i;
+	unsigned int bcount = 0;
+	unsigned int i;
 
 	/* Allocate a sufficiently large array */
 	blist = malloc(sizeof(SELboolean) * count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/booleans_local.c	2006-01-11 14:23:35.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_bool_key record_
 typedef struct semanage_bool record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "boolean_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -68,7 +67,7 @@ int semanage_bool_iterate_local(
 int semanage_bool_list_local(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/booleans_policy.c	2006-01-11 14:24:17.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_bool_key record_
 typedef struct semanage_bool record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "boolean_internal.h"
 #include "handle.h"
 #include "database.h"
@@ -51,7 +50,7 @@ int semanage_bool_iterate(
 int semanage_bool_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_activedb.c	2006-01-11 14:52:05.000000000 -0700
@@ -37,8 +37,8 @@ static int dbase_activedb_cache(
 	record_activedb_table_t* ratable = dbase->ratable;
 
 	record_t** records = NULL;
-	size_t rcount = 0;
-	size_t i;
+	unsigned int rcount = 0;
+	unsigned int i = 0;
 
 	/* Already cached */
 	if (dbase_llist_is_cached(&dbase->llist))
@@ -51,7 +51,7 @@ static int dbase_activedb_cache(
 		goto err;
 
 	/* Add records one by one */
-	for (i = 0; i < rcount; i++) { 
+	for (; i < rcount; i++) { 
 		if (dbase_llist_cache_prepend(handle, &dbase->llist, records[i]) < 0)
 			goto err;
 		rtable->free(records[i]);
@@ -77,8 +77,8 @@ static int dbase_activedb_flush(
 	record_activedb_table_t* ratable = dbase->ratable;
 
 	record_t** records = NULL;
-	size_t rcount = 0;
-	size_t i;
+	unsigned int rcount = 0;
+	unsigned int i;
 
 	/* Not cached, or not modified - flush is not necessary */
 	if (!dbase_llist_is_cached(&dbase->llist) ||
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_activedb.h new/libsemanage/src/database_activedb.h
--- old/libsemanage/src/database_activedb.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_activedb.h	2006-01-11 14:49:47.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_DATABASE_ACTIVEDB_INTERNAL_H_
 #define _SEMANAGE_DATABASE_ACTIVEDB_INTERNAL_H_
 
-#include <stddef.h>
 #include "database.h"
 #include "handle.h"
 
@@ -17,13 +16,13 @@ typedef struct record_activedb_table {
 	int (*read_list) (
 		semanage_handle_t* handle,
 		record_t*** records,
-		size_t* count);
+		unsigned int* count);
 
 	/* Commit a list of records */
 	int (*commit_list) (
 		semanage_handle_t* handle,
 		record_t** records,
-		size_t count);
+		unsigned int count);
 
 } record_activedb_table_t;
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database.c	2006-01-11 14:27:21.000000000 -0700
@@ -213,7 +213,7 @@ int dbase_list (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
 	record_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_file.c	2006-01-11 14:06:36.000000000 -0700
@@ -10,6 +10,7 @@ typedef struct dbase_file dbase_t;
 #define DBASE_DEFINED
 
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <errno.h>
 #include <stdio.h>
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database.h	2006-01-11 14:24:52.000000000 -0700
@@ -14,8 +14,6 @@ typedef void* dbase_t;
 #define DBASE_DEFINED
 #endif
 
-#include <stddef.h>
-
 /* Circular dependency */
 struct semanage_handle;
 
@@ -165,7 +163,7 @@ typedef struct dbase_table {
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_t*** records,
-		size_t* count);
+		unsigned int* count);
 
 	/* ---------- Cache/Transaction Management ---------- */
 
@@ -262,6 +260,6 @@ extern int dbase_list (
 	struct semanage_handle* handle,
 	dbase_config_t* dconfig,
 	record_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-11 14:50:43.000000000 -0700
@@ -304,11 +304,11 @@ int dbase_llist_list(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
 	record_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	cache_entry_t* ptr;
 	record_t** tmp_records = NULL;
-	size_t tmp_count;
+	unsigned int tmp_count;
 	int i = 0;
 
 	tmp_count = dbase->cache_sz;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_llist.h	2006-01-11 14:52:30.000000000 -0700
@@ -3,7 +3,6 @@
 #ifndef _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
 #define _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
 
-#include <stddef.h>
 #include "database.h"
 #include "handle.h"
 
@@ -25,7 +24,7 @@ typedef struct dbase_llist {
 	cache_entry_t* cache;
 	cache_entry_t* cache_tail;
 
-	size_t cache_sz;
+	unsigned int cache_sz;
 	int cached;
 	int modified;
 } dbase_llist_t;
@@ -143,6 +142,6 @@ extern int dbase_llist_list(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
 	record_t*** records,
-	size_t* count);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/database_policydb.c	2006-01-11 14:17:25.000000000 -0700
@@ -9,6 +9,7 @@ typedef struct dbase_policydb dbase_t;
 #define DBASE_DEFINED
 
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdio_ext.h>
@@ -376,10 +377,10 @@ static int dbase_policydb_list (
 	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	record_t** tmp_records = NULL;
-	size_t tmp_count;
+	unsigned int tmp_count;
 	struct list_handler_arg list_arg;
 	list_arg.pos = 0;
 	list_arg.rtable = dbase->rtable;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/fcontexts_local.c	2006-01-11 14:09:07.000000000 -0700
@@ -7,7 +7,6 @@ typedef struct semanage_fcontext record_
 #define DBASE_RECORD_DEFINED
 
 #include <stdlib.h>
-#include <stddef.h>
 #include <sepol/policydb.h>
 #include <sepol/context.h>
 #include "fcontext_internal.h"
@@ -74,7 +73,7 @@ hidden_def(semanage_fcontext_iterate_loc
 int semanage_fcontext_list_local(
 	semanage_handle_t* handle,
 	semanage_fcontext_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_policy.c new/libsemanage/src/fcontexts_policy.c
--- old/libsemanage/src/fcontexts_policy.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/fcontexts_policy.c	2006-01-11 14:09:22.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_fcontext_key rec
 typedef struct semanage_fcontext record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "fcontext_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -51,7 +50,7 @@ int semanage_fcontext_iterate(
 int semanage_fcontext_list(
 	semanage_handle_t* handle,
 	semanage_fcontext_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_fcontext_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/interfaces_local.c	2006-01-11 14:22:25.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_iface_key record
 typedef struct semanage_iface record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "iface_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -68,7 +67,7 @@ int semanage_iface_iterate_local(
 int semanage_iface_list_local(
 	semanage_handle_t* handle,
 	semanage_iface_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/interfaces_policy.c	2006-01-11 14:22:43.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_iface_key record
 typedef struct semanage_iface record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "iface_internal.h"
 #include "handle.h"
 #include "database.h"
@@ -51,7 +50,7 @@ int semanage_iface_iterate(
 int semanage_iface_list(
 	semanage_handle_t* handle,
 	semanage_iface_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/ports_policy.c	2006-01-11 14:22:05.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_port_key record_
 typedef struct semanage_port record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "port_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -51,7 +50,7 @@ int semanage_port_iterate(
 int semanage_port_list(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/src/semanageswig.i	2006-01-11 16:17:29.000000000 -0700
@@ -78,6 +78,7 @@
    if it becomes necessary to send in data this should be changed to INOUT */
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
+%apply int *OUTPUT { unsigned int * };
 
 %typemap(in, numinputs=0) char **(char *temp) {
 	$1 = &temp;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/seusers.c	2006-01-11 14:45:47.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_seuser_key recor
 typedef struct semanage_seuser record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include <sepol/policydb.h>
 #include <sepol/context.h>
 #include "user_internal.h"
@@ -73,7 +72,7 @@ hidden_def(semanage_seuser_iterate)
 int semanage_seuser_list(
 	semanage_handle_t* handle,
 	semanage_seuser_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/user_record.c	2006-01-11 14:45:29.000000000 -0700
@@ -17,7 +17,6 @@ typedef semanage_user_key_t record_key_t
 #define DBASE_RECORD_DEFINED
 
 #include <stdlib.h>
-#include <stddef.h>
 #include "user_internal.h"
 #include "handle.h"
 #include "database.h"
@@ -156,7 +155,7 @@ int semanage_user_get_roles(
 	semanage_handle_t* handle,
 	const semanage_user_t* user,
 	const char*** roles_arr, 
-	size_t* num_roles) {
+	unsigned int* num_roles) {
 
 	return sepol_user_get_roles(handle->sepolh, user, roles_arr, num_roles);
 }
@@ -166,7 +165,7 @@ int semanage_user_set_roles(
 	semanage_handle_t* handle,
 	semanage_user_t* user,
 	const char** roles_arr,
-	size_t num_roles) {
+	unsigned int num_roles) {
 
 	return sepol_user_set_roles(handle->sepolh, user, roles_arr, num_roles);
 }
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/users_file.c	2006-01-11 14:44:50.000000000 -0700
@@ -26,7 +26,7 @@ static int user_print(
 	FILE* str) {
 
 	const char** roles = NULL;
-	size_t i, nroles;
+	unsigned int i, nroles;
 
 	const char* name      = semanage_user_get_name(user);
 	const char* mls_level = semanage_user_get_mlslevel(user);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/users_local.c	2006-01-11 14:17:40.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_user_key record_
 typedef struct semanage_user record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "user_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -68,7 +67,7 @@ int semanage_user_iterate_local(
 int semanage_user_list_local(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsemanage/src/users_policy.c	2006-01-11 14:21:28.000000000 -0700
@@ -6,7 +6,6 @@ typedef struct semanage_user_key record_
 typedef struct semanage_user record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
 #include "user_internal.h"
 #include "handle.h" 
 #include "database.h"
@@ -53,7 +52,7 @@ int semanage_user_iterate(
 int semanage_user_list(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/roles.h new/libsepol/include/sepol/roles.h
--- old/libsepol/include/sepol/roles.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/include/sepol/roles.h	2006-01-11 14:40:39.000000000 -0700
@@ -9,6 +9,6 @@ extern int sepol_role_exists(
 extern int sepol_role_list(
 	const sepol_policydb_t* policydb,
 	char*** roles,
-	size_t* nroles);
+	unsigned int* nroles);
 
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/user_record.h new/libsepol/include/sepol/user_record.h
--- old/libsepol/include/sepol/user_record.h	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/include/sepol/user_record.h	2006-01-11 14:41:06.000000000 -0700
@@ -82,13 +82,13 @@ extern int sepol_user_get_roles(
 	sepol_handle_t* handle,
 	const sepol_user_t* user,
 	const char*** roles_arr, 
-	size_t* num_roles);
+	unsigned int* num_roles);
 
 extern int sepol_user_set_roles(
 	sepol_handle_t* handle,
 	sepol_user_t* user,
 	const char** roles_arr,
-	size_t num_roles);
+	unsigned int num_roles);
 
 /* Create/Clone/Destroy */
 extern int sepol_user_create(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/src/booleans.c	2006-01-11 14:38:07.000000000 -0700
@@ -1,6 +1,5 @@
 #include <string.h>
 #include <stdlib.h>
-#include <stddef.h>
 
 #include "handle.h"
 #include "private.h"
@@ -191,9 +190,9 @@ int sepol_bool_iterate(
 	void* arg) {
 
 	const policydb_t *policydb = &p->p;
-	size_t nbools = policydb->p_bools.nprim;
+	unsigned int nbools = policydb->p_bools.nprim;
 	sepol_bool_t* boolean = NULL;
-	size_t i;
+	unsigned int i;
 
 	/* For each boolean */
 	for (i = 0; i < nbools; i++) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/roles.c new/libsepol/src/roles.c
--- old/libsepol/src/roles.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/src/roles.c	2006-01-11 14:37:15.000000000 -0700
@@ -1,6 +1,5 @@
 #include <stdlib.h>
 #include <string.h>
-#include <stddef.h>
 
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/policydb.h>
@@ -29,13 +28,13 @@ int sepol_role_list(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	char*** roles, 
-	size_t* nroles) {
+	unsigned int* nroles) {
 
 	policydb_t *policydb = &p->p;
-	size_t tmp_nroles = policydb->p_roles.nprim;
+	unsigned int tmp_nroles = policydb->p_roles.nprim;
 	char **tmp_roles = (char**) malloc(tmp_nroles * sizeof(char*));
 	char **ptr;
-	size_t i;
+	unsigned int i;
 	if (!tmp_roles) 
 		goto omem;
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/src/user_record.c	2006-01-11 14:35:55.000000000 -0700
@@ -1,7 +1,6 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
-#include <stddef.h>
 
 #include "user_internal.h"
 #include "debug.h"
@@ -20,7 +19,7 @@ struct sepol_user {
 	char** roles;
 
 	/* The number of roles */
-	size_t num_roles;
+	unsigned int num_roles;
 };
 
 struct sepol_user_key {
@@ -205,7 +204,7 @@ int sepol_user_has_role(
 	const sepol_user_t* user, 
 	const char* role) {
 
-	size_t i;
+	unsigned int i;
 
 	for (i = 0; i < user->num_roles; i++)
 		if (!strcmp(user->roles[i], role)) 
@@ -218,9 +217,9 @@ int sepol_user_set_roles(
 	sepol_handle_t* handle,
 	sepol_user_t* user,
 	const char** roles_arr,
-	size_t num_roles) {
+	unsigned int num_roles) {
 
-	size_t i;
+	unsigned int i;
 	char** tmp_roles = NULL;
 
 	if (num_roles > 0) {
@@ -264,9 +263,9 @@ int sepol_user_get_roles(
 	sepol_handle_t* handle,
 	const sepol_user_t* user, 
 	const char*** roles_arr, 
-	size_t* num_roles) {
+	unsigned int* num_roles) {
 
-	size_t i;	
+	unsigned int i;	
 	const char** tmp_roles = 
 		(const char**) malloc(sizeof (char*) * user->num_roles);
 	if (!tmp_roles)
@@ -291,7 +290,7 @@ void sepol_user_del_role(
 	sepol_user_t* user, 
 	const char* role) {
 
-	size_t i;
+	unsigned int i;
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
 			free(user->roles[i]);
@@ -333,7 +332,7 @@ int sepol_user_clone(
 	sepol_user_t** user_ptr) {
 
 	sepol_user_t* new_user = NULL;
-	size_t i;
+	unsigned int i;
 
 	if (sepol_user_create(handle, &new_user) < 0)
 		goto err;
@@ -367,7 +366,7 @@ int sepol_user_clone(
 void sepol_user_free(
 	sepol_user_t* user) {
 
-	size_t i;
+	unsigned int i;
 
 	if (!user)
 		return;
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2006-01-11 16:19:46.000000000 -0700
+++ new/libsepol/src/users.c	2006-01-11 14:37:45.000000000 -0700
@@ -112,7 +112,7 @@ int sepol_user_modify(
 	char *name = NULL;
 
 	const char **roles = NULL;
-	size_t num_roles = 0;
+	unsigned int num_roles = 0;
 
 	/* Low-level representation */
 	user_datum_t* usrdatum = NULL;
@@ -348,9 +348,9 @@ int sepol_user_iterate(
 	void* arg) {
 
 	const policydb_t* policydb = &p->p;
-	size_t nusers = policydb->p_users.nprim;
+	unsigned int nusers = policydb->p_users.nprim;
 	sepol_user_t* user = NULL;
-	size_t i;
+	unsigned int i;
 
 	/* For each user */	
 	for (i = 0; i < nusers; i++) {

--------------070603040609070505000202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
