Message-ID: <43DBB694.2010600@cornell.edu>
Date: Sat, 28 Jan 2006 11:23:16 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fix more size_t warnings
Content-Type: multipart/mixed;
 boundary="------------010408080409060706090000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010408080409060706090000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix size_t warnings which show up on a 64-bit machine.


--------------010408080409060706090000
Content-Type: text/x-patch;
 name="libsemanage.fix_more_size_t.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_more_size_t.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-28 11:19:46.000000000 -0700
@@ -17,8 +17,7 @@ static int clear_obsolete(
 
 	record_key_t* key = NULL;
 	record_t** records = NULL;
-	size_t nrecords = 0;
-	size_t i;
+	unsigned int i, nrecords = 0;
 
 	dbase_table_t* src_dtable = src->dtable;
 	dbase_table_t* dst_dtable = dst->dtable;
diff -Naurp --exclude-from excludes old/libsemanage/src/user_base_record.c new/libsemanage/src/user_base_record.c
--- old/libsemanage/src/user_base_record.c	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/user_base_record.c	2006-01-28 11:18:05.000000000 -0700
@@ -19,7 +19,6 @@ typedef semanage_user_key_t record_key_t
 #define DBASE_RECORD_DEFINED
 
 #include <stdlib.h>
-#include <stddef.h>
 #include "user_internal.h"
 #include "handle.h"
 #include "database.h"
@@ -132,7 +131,7 @@ hidden int semanage_user_base_get_roles(
 	semanage_handle_t* handle,
 	const semanage_user_base_t* user,
 	const char*** roles_arr, 
-	size_t* num_roles) {
+	unsigned int* num_roles) {
 
 	return sepol_user_get_roles(handle->sepolh, user, roles_arr, num_roles);
 }
@@ -141,7 +140,7 @@ hidden int semanage_user_base_set_roles(
 	semanage_handle_t* handle,
 	semanage_user_base_t* user,
 	const char** roles_arr,
-	size_t num_roles) {
+	unsigned int num_roles) {
 
 	return sepol_user_set_roles(handle->sepolh, user, roles_arr, num_roles);
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2006-01-28 11:03:16.000000000 -0700
+++ new/libsemanage/src/user_internal.h	2006-01-28 11:16:53.000000000 -0700
@@ -141,13 +141,13 @@ hidden int semanage_user_base_get_roles(
 	semanage_handle_t* handle,
 	const semanage_user_base_t* user,
 	const char*** roles_arr,
-	size_t* num_roles);
+	unsigned int* num_roles);
 
 hidden int semanage_user_base_set_roles(
 	semanage_handle_t* handle,
 	semanage_user_base_t* user,
 	const char** roles_arr,
-	size_t num_roles);
+	unsigned int num_roles);
 
 hidden void semanage_user_base_free(
 	semanage_user_base_t* user);

--------------010408080409060706090000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
