Message-ID: <43BC6F79.50009@cornell.edu>
Date: Wed, 04 Jan 2006 19:59:37 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Remove add/mod/del for active booleans
Content-Type: multipart/mixed;
 boundary="------------020101040008020606020509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020101040008020606020509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove some functions that won't work properly, and shouldn't have been 
added for active booleans.


--------------020101040008020606020509
Content-Type: text/x-patch;
 name="libsemanage.active_remove_add_mod_del.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.active_remove_add_mod_del.diff"

diff -Naurp --exclude pywrap-test.py --exclude man --exclude-from excludes old/libsemanage/include/semanage/booleans_active.h new/libsemanage/include/semanage/booleans_active.h
--- old/libsemanage/include/semanage/booleans_active.h	2006-01-04 19:58:09.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_active.h	2006-01-04 19:49:24.000000000 -0500
@@ -7,25 +7,11 @@
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_bool_add_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
-extern int semanage_bool_modify_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
 extern int semanage_bool_set_active(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key,
 	semanage_bool_t* data);
 
-extern int semanage_bool_del_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key);
-
 extern int semanage_bool_query_active(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key,
diff -Naurp --exclude pywrap-test.py --exclude man --exclude-from excludes old/libsemanage/src/booleans_active.c new/libsemanage/src/booleans_active.c
--- old/libsemanage/src/booleans_active.c	2006-01-04 19:58:10.000000000 -0500
+++ new/libsemanage/src/booleans_active.c	2006-01-04 19:49:38.000000000 -0500
@@ -11,24 +11,6 @@ typedef struct semanage_bool record_t;
 #include "handle.h" 
 #include "database.h"
 
-int semanage_bool_add_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
-int semanage_bool_modify_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);	
-	return dbase_modify(handle, dconfig, key, data);
-}
-
 int semanage_bool_set_active(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key,
@@ -38,14 +20,6 @@ int semanage_bool_set_active(
 	return dbase_set(handle, dconfig, key, data);
 }
 
-int semanage_bool_del_active(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase_active(handle);
-	return dbase_del(handle, dconfig, key);
-}
-
 int semanage_bool_query_active(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key,

--------------020101040008020606020509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
