Message-ID: <43C62D3A.1050607@cornell.edu>
Date: Thu, 12 Jan 2006 03:19:38 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Cleanups after add/set removal
Content-Type: multipart/mixed;
 boundary="------------040305040602060004000703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040305040602060004000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes dead code - add/set functions in ports_local, and add 
entrypoint in database.c.
Secondly it removes the check for duplicates in the remaining (internal) 
copy of add, which we will use for internal purposes.





--------------040305040602060004000703
Content-Type: text/x-patch;
 name="libsemanage.cleanups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.cleanups.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/database.c	2006-01-12 01:10:50.000000000 -0700
@@ -55,7 +55,6 @@ static inline int exit_ro(
 		semanage_release_active_lock(handle);
 		dconfig->dtable->drop_cache(dconfig->dbase);
 	}
-
 	return commit_num;
 }
 
@@ -81,21 +80,6 @@ static int enter_rw(
 	return STATUS_ERR;
 }
 
-int dbase_add (
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig,
-	const record_key_t* key,
-	const record_t* data) {
-
-	if (enter_rw(handle, dconfig) < 0)
-		return STATUS_ERR;
-
-	if (dconfig->dtable->add(handle, dconfig->dbase, key, data) < 0)
-		return STATUS_ERR;
-
-	return STATUS_SUCCESS;
-}
-
 int dbase_modify (
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig,
diff -Naurp --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/database.h	2006-01-12 03:06:15.000000000 -0700
@@ -71,9 +71,7 @@ typedef struct dbase_table {
 	 * In add/set/modify, the data is also property of the caller */
 
 	/* Add the specified record to
-	 * the database if it is not present,
-	 * or fail if it already exists
-	 */
+	 * the database. No check for duplicates is performed */
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-12 03:10:43.000000000 -0700
@@ -121,21 +121,10 @@ int dbase_llist_add(
 	const record_key_t* key,
 	const record_t* data) {
 
-	int status;
-	cache_entry_t* entry;
-
-	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
-	if (status < 0)
-		goto err;
-
-	if (status != STATUS_NODATA) {
-		ERR(handle, "record is already in the database");
-		goto err;
-	}
-
 	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
 		goto err;
 
+	key = NULL;
 	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
@@ -259,7 +248,6 @@ int dbase_llist_iterate(
 			break;
         }
 
-
         return STATUS_SUCCESS;
 
 	err:
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/src/ports_local.c	2006-01-12 03:10:58.000000000 -0700
@@ -11,15 +11,6 @@ typedef struct semanage_port record_t;
 #include "handle.h" 
 #include "database.h"
 
-int semanage_port_add_local(
-	semanage_handle_t* handle,
-	const semanage_port_key_t* key,
-	const semanage_port_t* data) {
-
-	dbase_config_t* dconfig = semanage_port_dbase_local(handle);	
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_port_modify_local(
 	semanage_handle_t* handle,
 	const semanage_port_key_t* key,
@@ -29,15 +20,6 @@ int semanage_port_modify_local(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-int semanage_port_set_local(
-	semanage_handle_t* handle,
-	const semanage_port_key_t* key,
-	const semanage_port_t* data) {
-	
-	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_port_del_local(
 	semanage_handle_t* handle,
 	const semanage_port_key_t* key) {
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-11 16:23:42.000000000 -0700
+++ new/libsemanage/src/seusers.c	2006-01-12 01:09:08.000000000 -0700
@@ -103,8 +103,6 @@ static int validate_handler(
 	const char* mls_range = semanage_seuser_get_mlsrange(seuser);
 	const char* user_mls_range;
 
-	/* FIXME: verify that Unix user exists */
-
 	/* Make sure the (SElinux) user exists */
 	if (semanage_user_key_create(handle, sename, &key) < 0)
 		goto err;

--------------040305040602060004000703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
