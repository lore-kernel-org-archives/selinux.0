Message-ID: <43580ADB.1060003@cornell.edu>
Date: Thu, 20 Oct 2005 17:23:39 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Remove unused relay functions
Content-Type: multipart/mixed;
 boundary="------------040104090202070305050308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040104090202070305050308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removes unused relay interfaces for POLICYDB databases (modify 
functions). Some of them had the wrong names too...

This is basically the logical conclusion of splitting the internal 
POLICYDB header in half - one half was made public in an earlier patch, 
and now I'm dropping the other half in favor of more direct access 
(without relay) - policydb_components.c uses polymorphism and method 
tables to call the right function itself without relay, which is better.

====

What I don't like very much is that accessing the functions directly via 
the dbase interfaces assumes binary compatibility between the sepol and 
semanage record (currently true), while in the previous versions I had 
convert() functions to change between the two. I've put a warning - not 
sure if I'll do anything about it.


--------------040104090202070305050308
Content-Type: text/x-patch;
 name="libsemanage.no_relay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.no_relay.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-10-20 14:03:25.000000000 -0400
+++ new/libsemanage/src/booleans_policy.c	2005-10-20 17:10:07.000000000 -0400
@@ -11,9 +11,9 @@ typedef struct dbase_direct dbase_t;
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/boolean_record.h>
+#include <semanage/booleans_policy.h>
 #include "handle.h"
 #include "database.h"
-#include "booleans_policy.h"
 #include "debug.h"
 
 static inline int semanage2sepol_key(
@@ -43,81 +43,6 @@ record_table_t SEPOL_BOOL_RTABLE = {
 	.free        = sepol_bool_free,
 };
 
-int semanage_bool_add(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_bool_dbase_policy(handle);
-	sepol_bool_t* sepol_data;
-	sepol_bool_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->add(handle, dconfig->dbase, 
-			sepol_key, sepol_data) < 0)
-		goto err;
-	
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_bool_modify_policy(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_bool_t* sepol_data;
-	sepol_bool_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->modify(handle, dconfig->dbase,
-			sepol_key, sepol_data) <  0)
-		goto err;
-
-	return STATUS_SUCCESS;
-	
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_bool_del(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key) {
-
-	dbase_config_t* dconfig = 
-		semanage_bool_dbase_policy(handle);
-	sepol_bool_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
 int semanage_bool_query(
 	semanage_handle_t* handle,
 	semanage_bool_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policy.h new/libsemanage/src/booleans_policy.h
--- old/libsemanage/src/booleans_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_policy.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,25 +0,0 @@
-#ifndef _SEMANAGE_BOOLEANS_POLICY_INTERNAL_H_
-#define _SEMANAGE_BOOLEANS_POLICY_INTERNAL_H_
-
-#include <semanage/handle.h> 
-#include <semanage/boolean_record.h>
-#include <semanage/booleans_policy.h>
-
-/* BOOLEAN RECORD (SEPOL): method table */
-extern record_table_t SEPOL_BOOL_RTABLE;
-
-extern int semanage_bool_add(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
-extern int semanage_bool_modify(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
-extern int semanage_bool_del(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key);
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_policy.c	2005-10-20 17:09:34.000000000 -0400
@@ -11,9 +11,9 @@ typedef struct dbase_direct dbase_t;
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/iface_record.h>
+#include <semanage/interfaces_policy.h>
 #include "handle.h"
 #include "database.h"
-#include "interfaces_policy.h"
 #include "debug.h"
 
 static inline int semanage2sepol_key(
@@ -43,81 +43,6 @@ record_table_t SEPOL_IFACE_RTABLE = {
 	.free        = sepol_iface_free,
 };
 
-int semanage_iface_add(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_iface_dbase_policy(handle);
-	sepol_iface_t* sepol_data;
-	sepol_iface_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->add(handle, dconfig->dbase, 
-			sepol_key, sepol_data) < 0)
-		goto err;
-	
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_iface_modify_policy(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_iface_t* sepol_data;
-	sepol_iface_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->modify(handle, dconfig->dbase,
-			sepol_key, sepol_data) <  0)
-		goto err;
-
-	return STATUS_SUCCESS;
-	
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_iface_del(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key) {
-
-	dbase_config_t* dconfig = 
-		semanage_iface_dbase_policy(handle);
-	sepol_iface_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
 int semanage_iface_query(
 	semanage_handle_t* handle,
 	semanage_iface_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policy.h new/libsemanage/src/interfaces_policy.h
--- old/libsemanage/src/interfaces_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_policy.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,25 +0,0 @@
-#ifndef _SEMANAGE_INTERFACES_POLICY_INTERNAL_H_
-#define _SEMANAGE_INTERFACES_POLICY_INTERNAL_H_
-
-#include <semanage/handle.h> 
-#include <semanage/iface_record.h>
-#include <semanage/interfaces_policy.h>
-
-/* INTERFACE RECORD (SEPOL): method table */
-extern record_table_t SEPOL_IFACE_RTABLE;
-
-extern int semanage_iface_add(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
-
-extern int semanage_iface_modify(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
-
-extern int semanage_iface_del(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key);
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-20 14:03:26.000000000 -0400
+++ new/libsemanage/src/ports_policy.c	2005-10-20 17:09:08.000000000 -0400
@@ -11,9 +11,9 @@ typedef struct dbase_direct dbase_t;
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/port_record.h>
+#include <semanage/ports_policy.h>
 #include "handle.h"
 #include "database.h"
-#include "ports_policy.h"
 #include "debug.h"
 
 static inline int semanage2sepol_key(
@@ -43,81 +43,6 @@ record_table_t SEPOL_PORT_RTABLE = {
 	.free        = sepol_port_free,
 };
 
-int semanage_port_add(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_port_t* sepol_data;
-	sepol_port_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->add(handle, dconfig->dbase, 
-			sepol_key, sepol_data) < 0)
-		goto err;
-	
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_port_modify(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_port_t* sepol_data;
-	sepol_port_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->modify(handle, dconfig->dbase,
-			sepol_key, sepol_data) <  0)
-		goto err;
-
-	return STATUS_SUCCESS;
-	
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_port_del(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_port_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
 int semanage_port_query(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policy.h new/libsemanage/src/ports_policy.h
--- old/libsemanage/src/ports_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/ports_policy.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,25 +0,0 @@
-#ifndef _SEMANAGE_PORTS_POLICY_INTERNAL_H_
-#define _SEMANAGE_PORTS_POLICY_INTERNAL_H_
-
-#include <semanage/handle.h> 
-#include <semanage/port_record.h>
-#include <semanage/ports_policy.h>
-
-/* PORT RECORD (SEPOL): method table */
-extern record_table_t SEPOL_PORT_RTABLE;
-
-extern int semanage_port_add(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
-
-extern int semanage_port_modify(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
-
-extern int semanage_port_del(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key);
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-20 14:03:27.000000000 -0400
+++ new/libsemanage/src/users_policy.c	2005-10-20 17:09:20.000000000 -0400
@@ -11,9 +11,9 @@ typedef struct dbase_direct dbase_t;
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/user_record.h>
+#include <semanage/users_policy.h>
 #include "handle.h"
 #include "database.h"
-#include "users_policy.h"
 #include "debug.h"
 
 static inline int semanage2sepol_key(
@@ -43,81 +43,6 @@ record_table_t SEPOL_USER_RTABLE = {
 	.free        = sepol_user_free,
 };
 
-int semanage_user_add(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_user_dbase_policy(handle);
-	sepol_user_t* sepol_data;
-	sepol_user_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->add(handle, dconfig->dbase, 
-			sepol_key, sepol_data) < 0)
-		goto err;
-	
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_user_modify_policy(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
-
-	dbase_config_t* dconfig = 
-		semanage_port_dbase_policy(handle);
-	sepol_user_t* sepol_data;
-	sepol_user_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (semanage2sepol_data(data, &sepol_data) < 0)
-		goto err;
-
-	if (dconfig->dtable->modify(handle, dconfig->dbase,
-			sepol_key, sepol_data) <  0)
-		goto err;
-
-	return STATUS_SUCCESS;
-	
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-int semanage_user_del(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key) {
-
-	dbase_config_t* dconfig = 
-		semanage_user_dbase_policy(handle);
-	sepol_user_key_t* sepol_key;
-
-	if (semanage2sepol_key(key, &sepol_key) < 0)
-		goto err;
-
-	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
 int semanage_user_query(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policy.h new/libsemanage/src/users_policy.h
--- old/libsemanage/src/users_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/users_policy.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,25 +0,0 @@
-#ifndef _SEMANAGE_USERS_POLICY_INTERNAL_H_
-#define _SEMANAGE_USERS_POLICY_INTERNAL_H_
-
-#include <semanage/handle.h> 
-#include <semanage/user_record.h>
-#include <semanage/users_policy.h>
-
-/* USER RECORD (SEPOL): method table */
-extern record_table_t SEPOL_USER_RTABLE;
-
-extern int semanage_user_add(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
-
-extern int semanage_user_modify(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
-
-extern int semanage_user_del(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key);
-
-#endif

--------------040104090202070305050308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
