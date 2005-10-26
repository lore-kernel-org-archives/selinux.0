Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9VJ2wMA016214
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 14:02:58 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9VIw7mc013841
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 18:58:07 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j9VJvhvt028270
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 14:57:43 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j9VJvg1i028269
	for selinux@tycho.nsa.gov; Mon, 31 Oct 2005 14:57:42 -0500
Message-ID: <435ECB22.8050100@cornell.edu>
Date: Tue, 25 Oct 2005 20:17:38 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] [ SEPOL ] Pass handle to user/boolean/interface, and
 port APIs
Content-Type: multipart/mixed;
 boundary="------------010800010207000102090302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010800010207000102090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
- adds handle to context.c, users.c, ports.c, interfaces.c, and booleans.c
- adds/converts error messages using that handle
- resyncs semanage with those change

- implement all DEBUG calls in services.c as ERR with a NULL handle.

- fix a small memory leak in users.c, on querying a user that isn't found.

=======
Some of those interfaces are getting rather cluttered - take a look in 
context.h.



--------------010800010207000102090302
Content-Type: text/x-patch;
 name="libsepol.debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.debug.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-25 20:09:39.000000000 -0400
@@ -278,7 +278,8 @@ static int dbase_policydb_add (
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->add(dbase->policydb, key, data) < 0)
+	if (dbase->rptable->add(handle->sepolh,	
+		dbase->policydb, key, data) < 0)
 		goto err;
 
 	dbase->modified = 1;
@@ -298,7 +299,8 @@ static int dbase_policydb_set(
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->set(dbase->policydb, key, data) < 0)
+	if (dbase->rptable->set(handle->sepolh, 
+		dbase->policydb, key, data) < 0)
 		goto err;
 
 	dbase->modified = 1;
@@ -318,7 +320,8 @@ static int dbase_policydb_modify (
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->modify(dbase->policydb, key, data) < 0)
+	if (dbase->rptable->modify(handle->sepolh, 
+		dbase->policydb, key, data) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -354,7 +357,8 @@ static int dbase_policydb_query (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->query(dbase->policydb, key, response) < 0)
+	if (dbase->rptable->query(handle->sepolh,
+		dbase->policydb, key, response) < 0)
 		goto err;
 
 	exit_ro(handle, dbase);
@@ -375,7 +379,8 @@ static int dbase_policydb_exists (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->exists(dbase->policydb, key, response) < 0)
+	if (dbase->rptable->exists(handle->sepolh, 
+		dbase->policydb, key, response) < 0)
 		goto err;
 
 	exit_ro(handle, dbase);
@@ -395,7 +400,8 @@ static int dbase_policydb_count (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	if (dbase->rptable->count(dbase->policydb, response) < 0)
+	if (dbase->rptable->count(handle->sepolh,
+		dbase->policydb, response) < 0)
 		goto err;
 
 	exit_ro(handle, dbase);
@@ -416,7 +422,8 @@ static int dbase_policydb_iterate(
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 	
-	if (dbase->rptable->iterate(dbase->policydb, fn, arg) < 0) 
+	if (dbase->rptable->iterate(handle->sepolh,
+		dbase->policydb, fn, arg) < 0) 
 		goto err;
 
 	exit_ro(handle, dbase);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/database_policydb.h	2005-10-25 20:08:24.000000000 -0400
@@ -1,6 +1,7 @@
 #ifndef _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 
+#include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
@@ -13,6 +14,7 @@ typedef struct record_policydb_table {
 
 	/* Add policy record */
 	int (*add) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb, 
 		record_key_t* rkey,
 		record_t* record);
@@ -20,12 +22,14 @@ typedef struct record_policydb_table {
 	/* Modify policy record, or add if 
 	 * the key isn't found */
 	int (*modify) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb, 
 		record_key_t* rkey,
 		record_t* record);
 
 	/* Set policy record */
 	int (*set) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
 		record_key_t* rkey,
 		record_t* record);
@@ -33,23 +37,27 @@ typedef struct record_policydb_table {
 	/* Query policy record  - return the record
 	 * or NULL if it isn't found */
 	int (*query) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
 		record_key_t* rkey,
 		record_t** response);
 
 	/* Count records */
 	int (*count) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
 		int* response);
 
 	/* Check if a record exists */
 	int (*exists) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
 		record_key_t* rkey,
 		int* response);
 		
 	/* Iterate over records */
 	int (*iterate) (
+		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
 		int (*fn)(record_t* record, void* fn_arg),
 		void* arg);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-25 19:55:16.000000000 -0400
@@ -4,6 +4,7 @@
 #include <stddef.h>
 #include <sepol/policydb.h>
 #include <sepol/boolean_record.h>
+#include <sepol/handle.h>
 
 /*--------------compatibility--------------*/
 
@@ -29,23 +30,27 @@ extern int sepol_genbools_array(
 
 /* Set the specified boolean */
 extern int sepol_bool_set (
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
 	sepol_bool_key_t* key,
 	sepol_bool_t* data);
 
 /* Return the number of booleans */
 extern int sepol_bool_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response);
 
 /* Check if the specified boolean exists */
 extern int sepol_bool_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_bool_key_t* key,
 	int* response);
 
 /* Query a boolean - returns the boolean, or NULL if not found */
 extern int sepol_bool_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_bool_key_t* key,
 	sepol_bool_t** response);
@@ -57,6 +62,7 @@ extern int sepol_bool_query(
  * 0 to signal continue */
 
 extern int sepol_bool_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	int (*fn)(
 		sepol_bool_t* boolean,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-25 19:54:32.000000000 -0400
@@ -3,15 +3,17 @@
 
 #include <sepol/policydb.h>
 #include <sepol/iface_record.h>
-#include <stddef.h>
+#include <sepol/handle.h>
 
 /* Return the number of interfaces */
 extern int sepol_iface_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response);
 
 /* Check if an interface exists */
 extern int sepol_iface_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
 	int* response);
@@ -19,6 +21,7 @@ extern int sepol_iface_exists(
 /* Query an interface - returns the interface, 
  * or NULL if not found */
 extern int sepol_iface_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
 	sepol_iface_t** response);
@@ -26,6 +29,7 @@ extern int sepol_iface_query(
 /* Modify an interface, or add it, if the key
  * is not found */
 extern int sepol_iface_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
 	sepol_iface_t* data);
@@ -37,6 +41,7 @@ extern int sepol_iface_modify(
  * 0 to signal continue */
 
 extern int sepol_iface_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	int (*fn)(
 		sepol_iface_t* iface,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-25 19:51:59.000000000 -0400
@@ -1,29 +1,33 @@
 #ifndef _SEPOL_PORTS_H_
 #define _SEPOL_PORTS_H_
 
+#include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include <sepol/port_record.h>
-#include <stddef.h>
 
 /* Return the number of ports */
 extern int sepol_port_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response);
 
 /* Check if a port exists */
 extern int sepol_port_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_port_key_t* key,
 	int* response);
 
 /* Query a port - returns the port, or NULL if not found */
 extern int sepol_port_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_port_key_t* key,
 	sepol_port_t** response);
 
 /* Modify a port, or add it, if the key is not found */
 extern int sepol_port_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
 	sepol_port_key_t* key,
 	sepol_port_t* data);
@@ -35,6 +39,7 @@ extern int sepol_port_modify(
  * 0 to signal continue */
 
 extern int sepol_port_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	int (*fn)(
 		sepol_port_t* port,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-25 19:53:50.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <sepol/policydb.h>
 #include <sepol/user_record.h>
+#include <sepol/handle.h>
 #include <stddef.h>
 
 /*---------compatibility------------*/
@@ -25,23 +26,27 @@ extern void sepol_set_delusers(int on);
 
 /* Modify the user, or add it, if the key is not found */
 extern int sepol_user_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
 	sepol_user_key_t* key,
 	sepol_user_t* data);
 
 /* Return the number of users */
 extern int sepol_user_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response);
 
 /* Check if the specified user exists */
 extern int sepol_user_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	sepol_user_key_t* key,
 	int* response);
 
 /* Query a user - returns the user or NULL if not found */
 extern int sepol_user_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_user_key_t* key,
 	sepol_user_t** response);
@@ -52,6 +57,7 @@ extern int sepol_user_query(
  * 1 to signal successful exit
  * 0 to signal continue */
 extern int sepol_user_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
 	int (*fn)(
 		sepol_user_t* user,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-25 19:56:19.000000000 -0400
@@ -1,8 +1,8 @@
-#include <stdio.h>
+#include <string.h>
 #include <stdlib.h>
 #include <stddef.h>
-#include <errno.h>
 
+#include "handle.h"
 #include "private.h"
 #include "debug.h"
 
@@ -13,6 +13,7 @@
 #include <sepol/boolean_record.h>
 
 static int bool_update (
+	sepol_handle_t* handle, 
 	policydb_t* policydb,
 	sepol_bool_key_t* key,
 	sepol_bool_t* data) {
@@ -25,19 +26,17 @@ static int bool_update (
 	name = strdup(cname);	
 	value = sepol_bool_get_value(data);
 
-	if (!name) {
-		DEBUG(__FUNCTION__, "out of memory\n");
-		goto err;
-	}
+	if (!name) 
+		goto omem;
 
 	cond_bool_datum_t *datum = 
 		hashtab_search(policydb->p_bools.table, name);
 	if (!datum) {
-		DEBUG(__FUNCTION__, "boolean %s no longer in policy\n", name);
+		ERR(handle, "boolean %s no longer in policy", name);
 		goto err;
 	}
 	if (value != 0 && value != 1) {
-		DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n", value, name);
+		ERR(handle, "illegal value %d for boolean %s", value, name);
 		goto err;
 	}
 
@@ -45,13 +44,17 @@ static int bool_update (
 	datum->state = value;
 	return STATUS_SUCCESS;
 
+	omem:
+	ERR(handle, "out of memory");
+
 	err:
 	free(name);
-	DEBUG(__FUNCTION__, "could not update boolean %s\n",  cname);
+	ERR(handle, "could not update boolean %s\n",  cname);
 	return STATUS_ERR;		
 }
 
 static int bool_to_record (
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	int bool_idx,
 	sepol_bool_t** record) {
@@ -74,44 +77,50 @@ static int bool_to_record (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not convert boolean %s to record", name);
 	sepol_bool_free(tmp_record);
 	return STATUS_ERR;
 }
 
 int sepol_bool_set (
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_bool_key_t* key, 
 	sepol_bool_t* data) {
 
+	const char* name;
+	sepol_bool_key_unpack(key, &name);
+
 	policydb_t *policydb = &p->p;
-	if (bool_update(policydb, key, data) < 0)
+	if (bool_update(handle, policydb, key, data) < 0)
 		goto err;	
 	
         if (evaluate_conds(policydb) < 0) {
-		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
+		ERR(handle, "error while re-evaluating conditionals");
 		goto err;
 	}
 
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not set boolean %s\n",
-		sepol_bool_get_name(data)); 
-	errno = EINVAL;
+	ERR(handle, "could not set boolean %s", name);
 	return STATUS_ERR;
 }
 
 int sepol_bool_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response) {
 
 	policydb_t* policydb = &p->p;
 	*response = policydb->p_bools.nprim;
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 int sepol_bool_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_bool_key_t* key,
 	int* response) {
@@ -124,7 +133,8 @@ int sepol_bool_exists(
 	name = strdup(cname);
 
 	if (!name) {
-		/* FIXME: handle error */
+		ERR(handle, "out of memory, could not check "
+			"if user %s exists", cname);
 		return STATUS_ERR;
 	}
 
@@ -134,6 +144,7 @@ int sepol_bool_exists(
 }
 
 int sepol_bool_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,	
 	sepol_bool_key_t* key,
 	sepol_bool_t** response) {
@@ -146,10 +157,8 @@ int sepol_bool_query(
 	sepol_bool_key_unpack(key, &cname);
 	name = strdup(cname);
 
-	if (!name) {
-		/* FIXME: handle error */
-		goto err;
-	}
+	if (!name) 
+		goto omem;
 
 	booldatum = hashtab_search(policydb->p_bools.table, name);
 	if (!booldatum) {
@@ -157,19 +166,24 @@ int sepol_bool_query(
 		return STATUS_SUCCESS;
 	}
 
-	if (bool_to_record(policydb, booldatum->value - 1, response) < 0)
+	if (bool_to_record(handle, policydb, 
+		booldatum->value - 1, response) < 0)
 		goto err;
 
 	free(name);
 	return STATUS_SUCCESS;
 
+	omem:
+	ERR(handle, "out of memory");
+
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not query boolean %s", cname);
 	free(name);
 	return STATUS_ERR;
 }
 
 int sepol_bool_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int (*fn)(
 		sepol_bool_t* boolean,
@@ -186,7 +200,7 @@ int sepol_bool_iterate(
 
 		int status;
 
-		if (bool_to_record(policydb, i, &boolean) < 0)
+		if (bool_to_record(handle, policydb, i, &boolean) < 0)
 			goto err;
 			
 		/* Invoke handler */
@@ -205,7 +219,7 @@ int sepol_bool_iterate(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not iterate over booleans\n");
+	ERR(handle, "could not iterate over booleans");
 	sepol_bool_free(boolean);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-25 19:58:20.000000000 -0400
@@ -1,4 +1,5 @@
 #include <stdlib.h>
+#include <string.h>
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/mls.h>
@@ -6,6 +7,7 @@
 
 #include "debug.h"
 #include "context.h"
+#include "handle.h"
 
 /* ----- Compatibility ---- */
 int policydb_context_isvalid(
@@ -73,6 +75,7 @@ int context_is_valid(policydb_t *p, cont
  * the length of the string.
  */
 int context_to_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t * context,
 	char **result,
@@ -118,8 +121,8 @@ int context_to_string(
 	return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory, could not convert "
-		"context to string\n");
+	ERR(handle, "out of memory, could not convert " 
+			"context to string");
 	free(scontext);
 	return STATUS_ERR;
 }
@@ -128,6 +131,7 @@ int context_to_string(
  * Create a context structure from the given record
  */
 int context_from_record(
+	sepol_handle_t* handle,
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
 	sepol_context_t* record) {
@@ -145,7 +149,7 @@ int context_from_record(
 
 	scontext = (context_struct_t*) malloc(sizeof(context_struct_t));
  	if (!user || !role || !type || !scontext) {
-		DEBUG(__FUNCTION__, "out of memory\n"); 
+		ERR(handle, "out of memory");
 		goto err;
 	}
 	context_init(scontext);
@@ -154,7 +158,7 @@ int context_from_record(
 	usrdatum = (user_datum_t*) hashtab_search(policydb->p_users.table,
                                         (hashtab_key_t) user);
 	if (!usrdatum) {
-		DEBUG(__FUNCTION__, "user %s is not defined\n", user);
+		ERR(handle, "user %s is not defined", user);
 		goto err_destroy;
 	}
 	scontext->user = usrdatum->value;
@@ -163,7 +167,7 @@ int context_from_record(
 	roldatum = (role_datum_t*) hashtab_search(policydb->p_roles.table,
 					(hashtab_key_t) role);
 	if (!roldatum) {
-		DEBUG(__FUNCTION__, "role %s is not defined\n", role);
+		ERR(handle, "role %s is not defined", role);
 		goto err_destroy;
 	}
 	scontext->role = roldatum->value;
@@ -172,37 +176,36 @@ int context_from_record(
 	typdatum = (type_datum_t *) hashtab_search(policydb->p_types.table,
 					(hashtab_key_t) type);
 	if (!typdatum || typdatum->isattr) {
-		DEBUG(__FUNCTION__, "type %s is not defined\n", type);
+		ERR(handle, "type %s is not defined", type);
 		goto err_destroy;
 	}
 	scontext->type = typdatum->value;
 
 	/* MLS */
 	if (mls && !policydb->mls) {
- 		DEBUG(__FUNCTION__, "Warning! mls context \"%s\" found, "
- 			"but mls is disabled\n", mls);
+ 		WARN(handle, "mls context \"%s\" ignored, since "
+			"mls is disabled", mls);
 		mls = NULL;
 	}
 	else if (!mls && policydb->mls) {
- 		DEBUG(__FUNCTION__, "mls is enabled, but no "
- 			"mls context found\n");
+ 		ERR(handle, "mls is enabled, but no mls context found");
 		goto err_destroy;
 	}
 	if (mls && (mls_from_string(policydb, mls, scontext) < 0)) {
- 		DEBUG(__FUNCTION__, "invalid mls context: %s\n", mls);
+ 		ERR(handle, "invalid mls context: \"%s\"", mls);
 		goto err_destroy;
 	}
 
 	/* Validity check */
  	if (!context_is_valid(policydb, scontext)) {
 		if (mls) {
-			DEBUG(__FUNCTION__, 
-				"invalid security context: %s:%s:%s:%s\n",
+			ERR(handle, 
+				"invalid security context: \"%s:%s:%s:%s\"",
 				user, role, type, mls);
 		}
 		else {
-			DEBUG(__FUNCTION__, 
-				"invalid security context: %s:%s:%s\n",
+			ERR(handle, 
+				"invalid security context: \"%s:%s:%s\"",
 				user, role, type);
 		}
 		goto err_destroy;
@@ -222,7 +225,7 @@ int context_from_record(
 	free(user);
 	free(type);
 	free(role);
-	DEBUG(__FUNCTION__, "error creating context structure\n");
+	ERR(handle, "could not create context structure");
 	return STATUS_ERR;
 }
 
@@ -230,6 +233,7 @@ int context_from_record(
  * Create a record from the given context structure
  */
 int context_to_record(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t* context,
 	sepol_context_t** record) {
@@ -265,7 +269,7 @@ int context_to_record(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not create context record");
 	sepol_context_free(tmp_record);
 	free(mls);
 	return STATUS_ERR;
@@ -275,6 +279,7 @@ int context_to_record(
  * Create a context structure from the provided string.
  */
 int context_from_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
@@ -285,10 +290,8 @@ int context_from_string(
 
 	/* sepol_context_from_string expects a NULL-terminated string */
 	con_cpy = malloc(con_str_len + 1);
-	if (!con_cpy) {
-		DEBUG(__FUNCTION__, "out of memory\n");
-		goto err;
-	}
+	if (!con_cpy) 
+		goto omem;
 	memcpy(con_cpy, con_str, con_str_len);
 	con_cpy[con_str_len] = '\0';
 
@@ -296,15 +299,18 @@ int context_from_string(
 		goto err;
 
 	/* Now create from the data structure */
-	if (context_from_record(policydb, cptr, ctx_record) < 0)
+	if (context_from_record(handle, policydb, cptr, ctx_record) < 0)
 		goto err;
 
 	free(con_cpy);
 	sepol_context_free(ctx_record);
 	return STATUS_SUCCESS;
 	
+	omem:
+	ERR(handle, "out of memory");
+
 	err:
-	DEBUG(__FUNCTION__, "unable to create context structure\n");
+	ERR(handle, "could not create context structure");
 	free(con_cpy);
 	sepol_context_free(ctx_record);
 	return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/context.h new/libsepol/src/context.h
--- old/libsepol/src/context.h	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/context.h	2005-10-25 19:57:52.000000000 -0400
@@ -5,20 +5,24 @@
 #include <sepol/context_record.h>
 #include <sepol/policydb/context.h> 
 #include <sepol/policydb/policydb.h>
+#include <sepol/handle.h>
 
 /* Create a context structure from high level representation */
 extern int context_from_record(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t** cptr,
 	sepol_context_t* data);
 
 extern int context_to_record(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t* context,
 	sepol_context_t** record);
 
 /* Create a context structure from string representation */
 extern int context_from_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
@@ -31,6 +35,7 @@ extern int context_is_valid(
 
 /* Extract the context as string */
 extern int context_to_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t* context,
 	char ** result,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-25 19:41:07.000000000 -0400
@@ -1,17 +1,16 @@
-#include <netinet/in.h>
 #include <stdlib.h>
 
 #include "debug.h"
 #include "context.h"
-#include <sepol/sepol.h>
+#include "handle.h"
+
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/sidtab.h>
-#include <sepol/policydb/services.h>
 #include <sepol/interfaces.h>
 #include <sepol/iface_record.h>
 
 /* Create a low level structure from record */
 static int iface_from_record (
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	ocontext_t** iface,
 	sepol_iface_t* record) {
@@ -30,7 +29,7 @@ static int iface_from_record (
 		goto omem;
 
 	/* Interface Context */
-	if (context_from_record(policydb, 
+	if (context_from_record(handle, policydb, 
 		&tmp_ifcon, sepol_iface_get_ifcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
@@ -38,7 +37,7 @@ static int iface_from_record (
 	free(tmp_ifcon);
 
 	/* Message Context */
-	if (context_from_record(policydb, 
+	if (context_from_record(handle, policydb, 
 		&tmp_msgcon, sepol_iface_get_msgcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
@@ -49,16 +48,17 @@ static int iface_from_record (
 	return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
+	ERR(handle, "out of memory");
 
 	err:
 	free(tmp_iface->u.name);
 	free(tmp_iface);
-	DEBUG(__FUNCTION__, "error creating interface structure\n");
+	ERR(handle, "error creating interface structure");
 	return STATUS_ERR;
 }
 
 static int iface_to_record (
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	ocontext_t* iface,
         sepol_iface_t** record) {
@@ -76,13 +76,13 @@ static int iface_to_record (
 	if (sepol_iface_set_name(tmp_record, name) < 0)
 		goto err;
 
-	if (context_to_record(policydb, ifcon, &tmp_con) < 0)
+	if (context_to_record(handle, policydb, ifcon, &tmp_con) < 0)
 		goto err;
 	if (sepol_iface_set_ifcon(tmp_record, tmp_con) < 0)
 		goto err;
 	tmp_con = NULL;
 
-	if (context_to_record(policydb, msgcon, &tmp_con) < 0)
+	if (context_to_record(handle, policydb, msgcon, &tmp_con) < 0)
 		goto err;
 	if (sepol_iface_set_msgcon(tmp_record, tmp_con) < 0)
 		goto err;
@@ -92,7 +92,7 @@ static int iface_to_record (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not convert interface %s to record", name);
 	sepol_context_free(tmp_con);
 	sepol_iface_free(tmp_record);
 	return STATUS_ERR;
@@ -100,6 +100,7 @@ static int iface_to_record (
 
 /* Check if an interface exists */
 int sepol_iface_exists (
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_iface_key_t* key,
 	int* response) {
@@ -118,11 +119,14 @@ int sepol_iface_exists (
 		}
 	}
 	*response = 0;
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 /* Query an interface */
 int sepol_iface_query (
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_iface_key_t* key,
 	sepol_iface_t** response) {
@@ -137,7 +141,7 @@ int sepol_iface_query (
 	for (c = head; c; c = c->next) {
 		if (!strcmp(name, c->u.name)) {
 
-			if (iface_to_record(policydb, c, response) < 0)
+			if (iface_to_record(handle, policydb, c, response) < 0)
 				goto err;
 
 			return STATUS_SUCCESS;
@@ -148,12 +152,13 @@ int sepol_iface_query (
 	return STATUS_SUCCESS;
 
 	err: 
-	DEBUG(__FUNCTION__, "could not query interface %s\n", name);
+	ERR(handle, "could not query interface %s", name);
 	return STATUS_ERR;
 }
 
 /* Load an interface into policy */
 int sepol_iface_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_iface_key_t* key, 
 	sepol_iface_t* data) {
@@ -164,7 +169,7 @@ int sepol_iface_modify(
 	const char* name;
 	sepol_iface_key_unpack(key, &name);
 
-	if (iface_from_record(policydb, &iface, data) < 0)
+	if (iface_from_record(handle, policydb, &iface, data) < 0)
 		goto err;
 
 	prev = NULL;
@@ -192,7 +197,7 @@ int sepol_iface_modify(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "error while loading interface %s\n", name);
+	ERR(handle, "error while loading interface %s", name);
 
 	if (iface != NULL) {
 		free(iface->u.name);
@@ -203,6 +208,7 @@ int sepol_iface_modify(
 
 /* Return the number of interfaces */
 extern int sepol_iface_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response) {
 
@@ -215,10 +221,13 @@ extern int sepol_iface_count(
 		count++;
 
 	*response = count;
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 int sepol_iface_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int (*fn)(
 		sepol_iface_t* iface,
@@ -233,7 +242,7 @@ int sepol_iface_iterate(
 	for (l = NULL, c = head; c; l = c, c = c->next) {
 		int status;
 
-		if (iface_to_record(policydb, c, &iface) < 0)
+		if (iface_to_record(handle, policydb, c, &iface) < 0)
 			goto err;
 		
 		/* Invoke handler */
@@ -252,7 +261,7 @@ int sepol_iface_iterate(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not iterate over interfaces\n");
+	ERR(handle, "could not iterate over interfaces");
 	sepol_iface_free(iface);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-25 09:06:48.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-25 19:59:35.000000000 -0400
@@ -3,35 +3,39 @@
 
 #include "debug.h"
 #include "context.h"
-#include <sepol/sepol.h>
+#include "handle.h"
+
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/sidtab.h>
-#include <sepol/policydb/services.h>
 #include <sepol/ports.h>
 #include <sepol/port_record.h>
 
-static int sepol2ipproto(int proto) {
+static inline int sepol2ipproto(
+	sepol_handle_t* handle,
+	int proto) {
+
 	switch(proto) {
 		case SEPOL_PROTO_TCP:
 			return IPPROTO_TCP;
 		case SEPOL_PROTO_UDP:
 			return IPPROTO_UDP;
 		default:
-			DEBUG(__FUNCTION__, "unsupported protocol %d\n",
-                                proto);
+			ERR(handle, "unsupported protocol %u", proto);
 			return STATUS_ERR;
 	}
 }
 
-static int ipproto2sepol(int proto) {
+static inline int ipproto2sepol(
+	sepol_handle_t* handle,
+	int proto) {
+
 	switch(proto) {
 		case IPPROTO_TCP:
 			return SEPOL_PROTO_TCP;
 		case IPPROTO_UDP:
 			return SEPOL_PROTO_UDP;
 		default:
-			DEBUG(__FUNCTION__, "invalid protocol %d "
-				"found in policy\n", proto);
+			ERR(handle, "invalid protocol %u "
+				"found in policy", proto);
 			return STATUS_ERR;
 	}
 }
@@ -39,6 +43,7 @@ static int ipproto2sepol(int proto) {
 /* Create a low level port structure from
  * a high level representation */
 static int port_from_record(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	ocontext_t** port,
 	sepol_port_t* data) {
@@ -48,13 +53,11 @@ static int port_from_record(
 	int tmp_proto;
 
 	tmp_port = (ocontext_t *) calloc(1, sizeof(ocontext_t));
-	if (!tmp_port) {
-		DEBUG(__FUNCTION__, "out of memory\n");
-		goto err;
-	}
+	if (!tmp_port) 
+		goto omem;
 	
 	/* Process protocol */
-	tmp_proto = sepol2ipproto(sepol_port_get_proto(data));
+	tmp_proto = sepol2ipproto(handle, sepol_port_get_proto(data));
 	if (tmp_proto < 0)
 		goto err;
 	tmp_port->u.port.protocol = tmp_proto;
@@ -63,14 +66,14 @@ static int port_from_record(
 	tmp_port->u.port.low_port = sepol_port_get_low(data);
 	tmp_port->u.port.high_port = sepol_port_get_high(data);
 	if (tmp_port->u.port.low_port > tmp_port->u.port.high_port) {
-		DEBUG(__FUNCTION__, "low port %d exceeds high port %d\n",
+		ERR(handle, "low port %d exceeds high port %d\n",
 			tmp_port->u.port.low_port, 
 			tmp_port->u.port.high_port);
 		goto err;
 	}
 
 	/* Context */
-	if (context_from_record(policydb, &tmp_con, 
+	if (context_from_record(handle, policydb, &tmp_con, 
 		sepol_port_get_con(data)) < 0)
 		goto err;
 	context_cpy(&tmp_port->context[0], tmp_con);
@@ -80,13 +83,17 @@ static int port_from_record(
 	*port = tmp_port;
 	return STATUS_SUCCESS;
 
+	omem:
+	ERR(handle, "out of memory");
+
 	err:
 	free(tmp_port);
-	DEBUG(__FUNCTION__, "error creating port structure\n");
+	ERR(handle, "error creating port structure");
 	return STATUS_ERR;
 }
 
 static int port_to_record (
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	ocontext_t* port,
 	sepol_port_t** record) {
@@ -103,7 +110,7 @@ static int port_to_record (
 	if (sepol_port_create(&tmp_record) < 0)
 		goto err;
 
-	rec_proto = ipproto2sepol(proto);
+	rec_proto = ipproto2sepol(handle, proto);
 	if (rec_proto < 0)
 		goto err;
 
@@ -113,7 +120,7 @@ static int port_to_record (
 	if (sepol_port_set_range(tmp_record, low, high) < 0)
 		goto err;
 
-	if (context_to_record(policydb, con, &tmp_con) < 0)
+	if (context_to_record(handle, policydb, con, &tmp_con) < 0)
 		goto err;
 
 	if (sepol_port_set_con(tmp_record, tmp_con) < 0)
@@ -124,7 +131,9 @@ static int port_to_record (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	/* FIXME: print protocol string */
+	ERR(handle, "could not convert port range %u - %u (protocol: %u)"
+		"to record", low, high, proto);
 	sepol_context_free(tmp_con);
 	sepol_port_free(tmp_record);
 	return STATUS_ERR;
@@ -132,6 +141,7 @@ static int port_to_record (
 
 /* Return the number of ports */
 extern int sepol_port_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response) {
 
@@ -144,11 +154,14 @@ extern int sepol_port_count(
 		count++;
 
 	*response = count;
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 /* Check if a port exists */
 int sepol_port_exists (
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_port_key_t* key,
 	int* response) {
@@ -158,7 +171,7 @@ int sepol_port_exists (
 
 	int low, high, proto;
 	sepol_port_key_unpack(key, &low, &high, &proto);
-	proto = sepol2ipproto(proto);
+	proto = sepol2ipproto(handle, proto);
 	if (proto < 0)
 		goto err;
 
@@ -178,13 +191,15 @@ int sepol_port_exists (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	/* FIXME: print out protocol string */
+	ERR(handle, "could not check if port range %u - %u (protocol: %u) exists",
+		low, high, proto);
 	return STATUS_ERR;
-
 }
 
 /* Query a port */
 int sepol_port_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_port_key_t* key,
 	sepol_port_t** response) {
@@ -194,7 +209,7 @@ int sepol_port_query(
 
 	int low, high, proto;
 	sepol_port_key_unpack(key, &low, &high, &proto);
-	proto = sepol2ipproto(proto);
+	proto = sepol2ipproto(handle, proto);
 	if (proto < 0)
 		goto err;
 
@@ -205,7 +220,7 @@ int sepol_port_query(
 		int high2 = c->u.port.high_port;
 
 		if (proto == proto2 && low2 <= low && high2 >= high) {
-			if (port_to_record(policydb, c, response) < 0)
+			if (port_to_record(handle, policydb, c, response) < 0)
 				goto err;
 			return STATUS_SUCCESS;
 		}
@@ -215,14 +230,16 @@ int sepol_port_query(
 	return STATUS_SUCCESS;
 
 	err: 
-	DEBUG(__FUNCTION__, "could not get context for port %i:%d-%d\n", 
-				proto, low, high);
+	/* FIXME: print protocol string */
+	ERR(handle, "could not query port range %u - %u (protocol: %u)",
+		low, high, proto);
 	return STATUS_ERR;
 
 }
 
 /* Load a port into policy */
 int sepol_port_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	sepol_port_key_t* key,
 	sepol_port_t* data) {
@@ -232,11 +249,11 @@ int sepol_port_modify(
 
 	int low, high, proto;
 	sepol_port_key_unpack(key, &low, &high, &proto);
-	proto = sepol2ipproto(proto);	
+	proto = sepol2ipproto(handle, proto);	
 	if (proto < 0)
 		goto err;
 
-	if (port_from_record(policydb, &port, data) < 0)
+	if (port_from_record(handle, policydb, &port, data) < 0)
 		goto err;
 
 	head = policydb->ocontexts[OCON_PORT];
@@ -267,17 +284,15 @@ int sepol_port_modify(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not load "
-		"%s port %d-%d\n",
-		sepol_port_get_proto_str(data), 
-		sepol_port_get_low(data),
-		sepol_port_get_high(data));
-
+	/* FIXME: print protocol string */
+	ERR(handle, "could not load port range %u - %u (protocol: %u)",
+		low, high, proto); 
 	free(port);
 	return STATUS_ERR;
 }
 
 int sepol_port_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int (*fn)(
 		sepol_port_t* port,
@@ -292,7 +307,7 @@ int sepol_port_iterate(
 	for (l = NULL, c = head; c; l = c, c = c->next) {
 		int status;
 
-		if (port_to_record(policydb, c, &port) < 0)
+		if (port_to_record(handle, policydb, c, &port) < 0)
 			goto err;
 
 		/* Invoke handler */	
@@ -311,7 +326,7 @@ int sepol_port_iterate(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not iterate over ports\n");
+	ERR(handle, "could not iterate over ports");
 	sepol_port_free(port);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/services.c	2005-10-25 19:50:47.000000000 -0400
@@ -61,8 +61,8 @@
 #include "context.h"
 #include "av_permissions.h"
 
-#define BUG() do { DEBUG(__FUNCTION__, "Badness at %s:%d\n", __FILE__, __LINE__); } while (0)
-#define BUG_ON(x) do { if (x) DEBUG(__FUNCTION__, "Badness at %s:%d\n", __FILE__, __LINE__); } while (0)
+#define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
+#define BUG_ON(x) do { if (x) ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
 
 static int selinux_enforcing = 1;
 
@@ -89,11 +89,11 @@ int sepol_set_policydb_from_file(FILE *f
 	if (mypolicydb.policy_type)
 		policydb_destroy(&mypolicydb);
 	if (policydb_init(&mypolicydb)) {
-		DEBUG(__FUNCTION__, "Out of memory!\n");
+		ERR(NULL, "Out of memory!");
 		return -1;
 	}
 	if (policydb_read(&mypolicydb, &pf, 0)) {
-		DEBUG(__FUNCTION__, "can't read binary policy: %s\n",
+		ERR(NULL, "can't read binary policy: %s",
 			strerror(errno));
 		return -1;
 	}
@@ -317,7 +317,7 @@ static int context_struct_compute_av(con
 	unsigned int i, j;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
-		DEBUG(__FUNCTION__, "unrecognized class %d\n", tclass);
+		ERR(NULL, "unrecognized class %d", tclass);
 		return -EINVAL;
 	}
 	tclass_datum = policydb->class_val_to_struct[tclass - 1];
@@ -425,26 +425,26 @@ int sepol_validate_transition(sepol_secu
 	constraint_node_t *constraint;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
-		DEBUG(__FUNCTION__, "unrecognized class %d\n", tclass);
+		ERR(NULL, "unrecognized class %d", tclass);
 		return -EINVAL;
 	}
 	tclass_datum = policydb->class_val_to_struct[tclass - 1];
 
 	ocontext = sepol_sidtab_search(sidtab, oldsid);
 	if (!ocontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", oldsid);
+		ERR(NULL, "unrecognized SID %d", oldsid);
 		return -EINVAL;
 	}
 
 	ncontext = sepol_sidtab_search(sidtab, newsid);
 	if (!ncontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", newsid);
+		ERR(NULL, "unrecognized SID %d", newsid);
 		return -EINVAL;
 	}
 
 	tcontext = sepol_sidtab_search(sidtab, tasksid);
 	if (!tcontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tasksid);
+		ERR(NULL, "unrecognized SID %d", tasksid);
 		return -EINVAL;
 	}
 
@@ -472,13 +472,13 @@ int sepol_compute_av_reason(sepol_securi
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", ssid);
+		ERR(NULL, "unrecognized SID %d", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tsid);
+		ERR(NULL, "unrecognized SID %d", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -515,11 +515,11 @@ int sepol_sid_to_context(sepol_security_
 
 	context = sepol_sidtab_search(sidtab, sid);
 	if (!context) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", sid);
+		ERR(NULL, "unrecognized SID %d", sid);
 		rc = -EINVAL;
 		goto out;
 	}
-	rc = context_to_string(policydb, context, scontext, scontext_len);
+	rc = context_to_string(NULL, policydb, context, scontext, scontext_len);
 out:
 	return rc;
 	
@@ -536,7 +536,7 @@ int sepol_context_to_sid(sepol_security_
 	context_struct_t* context = NULL;
 
 	/* First, create the context */
-	if (context_from_string(policydb, &context, 
+	if (context_from_string(NULL, policydb, &context, 
 		scontext, scontext_len) < 0)
 		goto err;
 
@@ -553,7 +553,7 @@ int sepol_context_to_sid(sepol_security_
 		context_destroy(context);
                 free(context);
         }
-	DEBUG(__FUNCTION__, "could not convert %s to sid\n", scontext);
+	ERR(NULL, "could not convert %s to sid", scontext);
 	return STATUS_ERR;
 }
 
@@ -574,11 +574,11 @@ static inline int compute_sid_handle_inv
 		sepol_security_context_t s, t, n;
 		size_t slen, tlen, nlen;
 
-		context_to_string(policydb, scontext, &s, &slen);
-		context_to_string(policydb, tcontext, &t, &tlen);
-		context_to_string(policydb, newcontext, &n, &nlen);
-		DEBUG(__FUNCTION__, "invalid context %s for "
-			"scontext=%s tcontext=%s tclass=%s\n",
+		context_to_string(NULL, policydb, scontext, &s, &slen);
+		context_to_string(NULL, policydb, tcontext, &t, &tlen);
+		context_to_string(NULL, policydb, newcontext, &n, &nlen);
+		ERR(NULL, "invalid context %s for "
+			"scontext=%s tcontext=%s tclass=%s",
 			n, s, t, policydb->p_class_val_to_name[tclass-1]);
 		free(s);
 		free(t);
@@ -602,13 +602,13 @@ static int sepol_compute_sid(sepol_secur
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", ssid);
+		ERR(NULL, "unrecognized SID %d", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tsid);
+		ERR(NULL, "unrecognized SID %d", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -763,12 +763,11 @@ static int validate_perm(hashtab_key_t k
 
 	perdatum2 = (perm_datum_t *) hashtab_search(h, key);
 	if (!perdatum2) {
-		DEBUG(__FUNCTION__, "permission %s disappeared\n", key);
+		ERR(NULL, "permission %s disappeared", key);
 		return -1;
 	}
 	if (perdatum->value != perdatum2->value) {
-		DEBUG(__FUNCTION__, "the value of permissions "
-			"%s changed\n", key);
+		ERR(NULL, "the value of permissions %s changed", key);
 		return -1;
 	}
 	return 0;
@@ -790,31 +789,30 @@ static int validate_class(hashtab_key_t 
 
 	cladatum2 = (class_datum_t *) hashtab_search(newp->p_classes.table, key);
 	if (!cladatum2) {
-		DEBUG(__FUNCTION__, "class %s disappeared\n", key);
+		ERR(NULL, "class %s disappeared", key);
 		return -1;
 	}
 	if (cladatum->value != cladatum2->value) {
-		DEBUG(__FUNCTION__, "the value of class %s changed\n", key);
+		ERR(NULL, "the value of class %s changed", key);
 		return -1;
 	}
 	if ((cladatum->comdatum && !cladatum2->comdatum) ||
 	    (!cladatum->comdatum && cladatum2->comdatum)) {
-		DEBUG(__FUNCTION__, "the inherits clause for the access "
+		ERR(NULL, "the inherits clause for the access "
 			"vector definition for class %s changed", key);
 		return -1;
 	}
 	if (cladatum->comdatum) {
 		if (hashtab_map(cladatum->comdatum->permissions.table, validate_perm,
 				cladatum2->comdatum->permissions.table)) {
-			DEBUG(__FUNCTION__, " in the access vector definition "
+			ERR(NULL, " in the access vector definition "
 				"for class %s\n", key);
 			return -1;
 		}
 	}
 	if (hashtab_map(cladatum->permissions.table, validate_perm,
 			cladatum2->permissions.table)) {
-		DEBUG(__FUNCTION__, " in access vector definition "
-			"for class %s\n", key);
+		ERR(NULL, " in access vector definition for class %s", key);
 		return -1;
 	}
 	return 0;
@@ -839,8 +837,8 @@ static inline int convert_context_handle
 		sepol_security_context_t s;
 		size_t len;
 
-		context_to_string(policydb, context, &s, &len);
-		DEBUG(__FUNCTION__, "context %s is invalid\n", s);
+		context_to_string(NULL, policydb, context, &s, &len);
+		ERR(NULL, "context %s is invalid", s);
 		free(s);
 		return 0;
 	}
@@ -917,9 +915,9 @@ static int convert_context(sepol_securit
 	return 0;
 
       bad:
-	context_to_string(policydb, &oldc, &s, &len);
+	context_to_string(NULL, policydb, &oldc, &s, &len);
 	context_destroy(&oldc);
-	DEBUG(__FUNCTION__, "invalidating context %s\n", s);
+	ERR(NULL, "invalidating context %s\n", s);
 	free(s);
 	return rc;
 }
@@ -966,8 +964,7 @@ int sepol_load_policy(void * data, size_
 	/* Verify that the existing classes did not change. */
 	if (hashtab_map(
 		policydb->p_classes.table, validate_class, &newpolicydb)) {
-		DEBUG(__FUNCTION__, "the definition of an existing "
-			"class changed\n");
+		ERR(NULL, "the definition of an existing class changed");
 		rc = -EINVAL;
 		goto err;
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-25 10:17:32.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-25 20:06:45.000000000 -0400
@@ -1,10 +1,11 @@
 #include <stdlib.h>
 #include <stddef.h>
+#include <string.h>
 
 #include "private.h"
 #include "debug.h"
+#include "handle.h"
 
-#include <sepol/sepol.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/mls.h>
@@ -98,6 +99,7 @@ static int user_to_record (
 }
 
 int sepol_user_modify(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	sepol_user_key_t* key,
 	sepol_user_t* user) {
@@ -166,7 +168,7 @@ int sepol_user_modify(
 		/* Search for the role */
 		roldatum = hashtab_search(policydb->p_roles.table, role);
 		if (!roldatum) {
-			DEBUG(__FUNCTION__, "undefined role %s for user %s\n", 
+			ERR(handle, "undefined role %s for user %s", 
 				role, name);
 			goto err;	
 		}
@@ -174,7 +176,8 @@ int sepol_user_modify(
 		/* Set the role and every role it dominates */
 		ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
 			if (ebitmap_node_get_bit(rnode, bit)) {
-				if (ebitmap_set_bit(&(usrdatum->roles.roles), bit, 1)) 
+				if (ebitmap_set_bit(
+					&(usrdatum->roles.roles), bit, 1)) 
 					goto omem;
 			}
 		}
@@ -188,20 +191,20 @@ int sepol_user_modify(
 
 		/* MLS level */
 		if (mls_level == NULL) {
-			DEBUG(__FUNCTION__, "MLS is enabled, but no MLS "
-				"default level was defined for user %s\n", name);
+			ERR(handle, "MLS is enabled, but no MLS "
+				"default level was defined for user %s", name);
 			goto err;
 		}
 		
 		context_init(&context);
 		if (mls_from_string(policydb, mls_level, &context) < 0) {
-			DEBUG(__FUNCTION__, "invalid MLS default level %s for user %s\n", 
-				mls_level, name);
+			ERR(handle, "invalid MLS default level %s "
+				"for user %s", mls_level, name);
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_level_cpy(&usrdatum->dfltlevel, &context.range.level[0]) < 0) {
-			DEBUG(__FUNCTION__, "could not copy MLS level %s", mls_level); 
+			ERR(handle, "could not copy MLS level %s", mls_level); 
 			context_destroy(&context);
 			goto err;
 		}
@@ -209,20 +212,20 @@ int sepol_user_modify(
 	
 		/* MLS range */
 		if (mls_range == NULL) {
-			DEBUG(__FUNCTION__, "MLS is enabled, but no MLS"
-				"range was defined for user %s\n", name);
+			ERR(handle, "MLS is enabled, but no MLS"
+				"range was defined for user %s", name);
 			goto err;
 		}	
 		
 		context_init(&context);
 		if (mls_from_string(policydb, mls_range, &context) < 0) {
-			DEBUG(__FUNCTION__, "invalid MLS range %s for user %s\n", 
+			ERR(handle, "invalid MLS range %s for user %s", 
 				mls_range, name);
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_range_cpy(&usrdatum->range, &context.range) < 0) {
-			DEBUG(__FUNCTION__, "could not copy MLS range %s", mls_range);
+			ERR(handle, "could not copy MLS range %s", mls_range);
 			context_destroy(&context);
 			goto err;
 		}
@@ -259,7 +262,7 @@ int sepol_user_modify(
 
 		/* Expand roles */
 		if (role_set_expand(&usrdatum->roles, &usrdatum->cache, policydb)) {
-			DEBUG(__FUNCTION__, "unable to expand role set\n");
+			ERR(handle, "unable to expand role set");
 			goto err;
 		}
 	}	
@@ -271,10 +274,10 @@ int sepol_user_modify(
 	return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
+	ERR(handle, "out of memory");
 
 	err:
-	DEBUG(__FUNCTION__, "could not load %s into policy\n", name);
+	ERR(handle, "could not load %s into policy", name);
 
 	free(name);
 	free(role);
@@ -289,6 +292,7 @@ int sepol_user_modify(
 }
 
 int sepol_user_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	sepol_user_key_t* key,
 	int* response) {
@@ -301,7 +305,7 @@ int sepol_user_exists(
 	name = strdup(cname);	
 
 	if (!name) {
-		DEBUG(__FUNCTION__, "out of memory, user check failed\n");
+		ERR(handle, "out of memory, user check failed");
 		return STATUS_ERR;
 	}
 	
@@ -311,15 +315,19 @@ int sepol_user_exists(
 }
 
 int sepol_user_count(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	int* response) {
 
 	policydb_t* policydb = &p->p;
 	*response = policydb->p_users.nprim;
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 int sepol_user_query(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p,
 	sepol_user_key_t* key,
 	sepol_user_t** response) {
@@ -332,12 +340,13 @@ int sepol_user_query(
 	sepol_user_key_unpack(key, &cname);
 	name = strdup(cname);
 
-	if (!name) {
-		/* FIXME: handle error */
-		goto err;
-	}
+	if (!name) 
+		goto omem;
 
 	usrdatum = hashtab_search(policydb->p_users.table, name);
+	free(name);
+	name = NULL;
+
 	if (!usrdatum) {
 		*response = NULL;
 		return STATUS_SUCCESS; 
@@ -346,16 +355,19 @@ int sepol_user_query(
 	if (user_to_record(policydb, usrdatum->value - 1, response) < 0)
 		goto err;
 
-	free(name);
 	return STATUS_SUCCESS;
 
+	omem:
+	ERR(handle, "out of memory");
+
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not query user %s", cname);
 	free(name);
 	return STATUS_ERR;
 }
 
 int sepol_user_iterate(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	int (*fn)(
 		sepol_user_t* user,
@@ -391,7 +403,7 @@ int sepol_user_iterate(
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not iterate over users\n");
+	ERR(handle, "could not iterate over users");
 	sepol_user_free(user);
 	return STATUS_ERR;
 }

--------------010800010207000102090302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
