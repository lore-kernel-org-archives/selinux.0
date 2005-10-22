Message-ID: <435A8AE9.3020709@cornell.edu>
Date: Sat, 22 Oct 2005 14:54:33 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Resync to sepol changes
Content-Type: multipart/mixed;
 boundary="------------090709050708020605090003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090709050708020605090003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- update POLICYDB record extension to contain the functions: add, 
modify, set, exists, iterate, and query
- configure all tables with the appropriate functions
- implement those functions in database_policydb.c (6 stubs removed).
- implement database_file.c:iterate() (1 more stub)

- add more error messages, so I can tell what's going on - they can be 
fixed later to something better.
- change Stub status code of all print functions from STATUS_ERR to 
STATUS_NODATA, so that the flat file parser will exit and not get stuck 
in infinite loop recalling the stubs.

- fix bug: initialize modified to 0 in FILE database

=============
I got commit() to start working somehow (no idea how), so now I can test 
this.
It _should_ commit the users file successfully... but it doesn't yet - 
need to do some more investigation.
I'm pretty sure it's read successfully, updated successfully, and merged 
into policy... not sure why it doesn't commit.

I'll probably get it working pretty soon. For now, it stays #if0-ed


--------------090709050708020605090003
Content-Type: text/x-patch;
 name="libsemanage.sepol_resync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sepol_resync.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/booleans_file.c	2005-10-22 14:39:24.000000000 -0400
@@ -36,7 +36,7 @@ static int bool_parse(
 	/* Stub */
 	info = NULL;
 	bool = NULL;
-	return STATUS_ERR;
+	return STATUS_NODATA;
 
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_policydb.c	2005-10-22 13:38:16.000000000 -0400
@@ -22,8 +22,11 @@ extern record_table_t SEPOL_BOOL_RTABLE;
 
 /* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
-	.add         = NULL, /* FIXME */
-	.modify      = NULL, /* FIXME */
+	.add         = NULL, 
+	.modify      = NULL,
+	.set         = sepol_bool_set,
+	.query       = NULL, /* FIXME */
+	.exists      = NULL, /* FIXME */ 
 	.iterate     = sepol_bool_iterate,
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-22 14:46:56.000000000 -0400
@@ -4,6 +4,7 @@ typedef struct dbase_file dbase_t;
 
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 #include "debug.h"
 #include "handle.h"
 #include "parse_utils.h"
@@ -43,6 +44,7 @@ static int construct_filename(
 	const char* path = (handle->is_in_transaction)?
 		semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL):
 		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+
 	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
 
 	char* fname = malloc(fname_length);
@@ -191,7 +193,8 @@ static int dbase_file_flush(
 
 	str = fopen(fname, "w");
 	if (!str) {
-		/* FIXME: handle error condition */
+		ERR(handle, "could not open %s for writing: %s",
+			fname, strerror(errno));
 		goto err;
 	}
 
@@ -209,7 +212,8 @@ static int dbase_file_flush(
 	handle = NULL;
 	if (str != NULL)
 		fclose(str);
-	/* FIXME: handle error */
+		
+	ERR(handle, "could not flush database to file");
 	free(fname);
 	return STATUS_ERR;
 }
@@ -219,16 +223,18 @@ static int enter_ro(
 	dbase_file_t* dbase) {
 
 	if (semanage_get_active_lock(handle) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
+		ERR(handle, "could not get the active lock");
+		goto err;
 	}
 
-	if (dbase_file_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
+	if (dbase_file_cache(handle, dbase) < 0) 
+		goto err;
 
 	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not enter read-only operation");
+	return STATUS_ERR;
 }
 
 static inline void exit_ro(
@@ -299,6 +305,7 @@ int dbase_file_init(
 	tmp_dbase->cache = NULL;
 	tmp_dbase->cache_sz = 0;
 	tmp_dbase->cached = 0;
+	tmp_dbase->modified = 0;
 
 	*dbase = tmp_dbase;
 	
@@ -476,12 +483,29 @@ static int dbase_file_iterate(
 	int (*fn) (record_t* record, void* fn_arg),
 	void* arg) {
 
-	/* Stub */
-	handle = NULL;
-	dbase = NULL;
-	fn = NULL;
-	arg = NULL;
+	int rc;
+	cache_entry_t* ptr;
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+
+		rc = fn(ptr->data, arg);
+		if (rc < 0) 
+			goto err;
+		
+		else if (rc > 1)
+			break;
+        }
 
+
+        exit_ro(handle, dbase);
+        return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not iterate over records");
+	exit_ro(handle, dbase);
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-22 14:46:41.000000000 -0400
@@ -30,7 +30,7 @@ struct dbase_policydb {
 	/* Policy extensions */
 	record_policydb_table_t* rptable;
 
-	sepol_policydb_t* policy;
+	sepol_policydb_t* policydb;
 	int cached;
 	int modified;
 	int attached;
@@ -47,8 +47,8 @@ static int construct_filename(
 	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
 
 	char* fname = malloc(fname_length);
-	if (!fname) {
-		/*  FIXME: handle error */
+	if (!fname) { 
+		ERR(handle, "out of memory, could not construct database name");
 		return STATUS_ERR;
 	}
 	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
@@ -72,7 +72,7 @@ static int dbase_policydb_cache(
 	if (dbase->cached || dbase->attached)
 		return STATUS_SUCCESS;
 	
-	if (construct_filename(handle, dbase, &fname) < 0)
+	if (construct_filename(handle, dbase, &fname) < 0) 
 		goto err;
 
 	/* Open file */
@@ -102,7 +102,7 @@ static int dbase_policydb_cache(
 		goto omem;
 	if (sepol_policydb_from_image(handle->sepolh, data, sb.st_size, policydb) < 0)
 		goto err;
-	dbase->policy = policydb;
+	dbase->policydb = policydb;
 
 	close(fd);
 	munmap(data, sb.st_size);
@@ -142,11 +142,11 @@ static int dbase_policydb_flush(
 
 
 static void dbase_policydb_drop_cache(
-	semanage_handle_t* handle,       
-	 dbase_policydb_t* dbase) {
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
 
 	if (dbase->cached) {
-		sepol_policydb_free(dbase->policy);
+		sepol_policydb_free(dbase->policydb);
 		dbase->cached = 0;
 		dbase->modified = 0;
 	}
@@ -159,16 +159,19 @@ static int enter_ro(
 	dbase_policydb_t* dbase) {
 
 	if (semanage_get_active_lock(handle) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
+		ERR(handle, "could not obtain the active lock");
+		goto err;
 	}
 
-	if (dbase_policydb_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
+	if (dbase_policydb_cache(handle, dbase) < 0) 
+		goto err;
 
 	return STATUS_SUCCESS;
+
+
+	err:
+	ERR(handle, "could not begin read-only operation");
+	return STATUS_ERR;
 }
 
 static inline void exit_ro(
@@ -211,7 +214,7 @@ int dbase_policydb_init(
 	tmp_dbase->suffix = suffix;
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rptable = rptable;
-	tmp_dbase->policy = NULL;
+	tmp_dbase->policydb = NULL;
 	tmp_dbase->cached = 0;
 	tmp_dbase->modified = 0;
 	tmp_dbase->attached = 0;
@@ -246,7 +249,7 @@ void dbase_policydb_attach(
 
 	dbase->attached = 1;
 	dbase_policydb_drop_cache(handle, dbase);
-	dbase->policy = policydb;
+	dbase->policydb = policydb;
 }
 
 /* Detach from a shared policdb.
@@ -268,10 +271,11 @@ static int dbase_policydb_add (
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	key = NULL;
-	data = NULL;
-	return STATUS_ERR;
+	if (dbase->rptable->add(dbase->policydb, key, data) < 0)
+		goto err;
+
+	dbase->modified = 1;
+	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
@@ -287,10 +291,11 @@ static int dbase_policydb_set(
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	key = NULL;
-	data = NULL;
-	return STATUS_ERR;
+	if (dbase->rptable->set(dbase->policydb, key, data) < 0)
+		goto err;
+
+	dbase->modified = 1;
+	return STATUS_SUCCESS;
 		
 	err:
 	/* FIXME: handle error */
@@ -306,10 +311,10 @@ static int dbase_policydb_modify (
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	key = NULL;
-	data = NULL;
-	return STATUS_ERR;
+	if (dbase->rptable->modify(dbase->policydb, key, data) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
@@ -342,11 +347,11 @@ static int dbase_policydb_query (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	key = NULL;
-	response = NULL;
+	if (dbase->rptable->query(dbase->policydb, key, response) < 0)
+		goto err;
+
 	exit_ro(handle, dbase);
-	return STATUS_ERR;
+	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
@@ -363,9 +368,9 @@ static int dbase_policydb_exists (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	key = NULL;
-	response = NULL;
+	if (dbase->rptable->exists(dbase->policydb, key, response) < 0)
+		goto err;
+
 	exit_ro(handle, dbase);
 	return STATUS_ERR;
 
@@ -403,14 +408,14 @@ static int dbase_policydb_iterate(
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 	
-	if (dbase->rptable->iterate(dbase->policy, fn, arg) < 0)
+	if (dbase->rptable->iterate(dbase->policydb, fn, arg) < 0) 
 		goto err;
 
 	exit_ro(handle, dbase);
         return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not iterate over records");
 	exit_ro(handle, dbase);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/database_policydb.h	2005-10-22 13:34:46.000000000 -0400
@@ -11,17 +11,41 @@ typedef struct dbase_policydb dbase_poli
 /* POLICYDB extension to RECORD interface - method table */
 typedef struct record_policydb_table {
 
-	/* Add record into the policy database */
-	int (*add) (sepol_policydb_t* policydb, record_t* record);
+	/* Add policy record */
+	int (*add) (
+		sepol_policydb_t* policydb, 
+		record_key_t* rkey,
+		record_t* record);
+
+	/* Modify policy record */
+	int (*modify) (
+		sepol_policydb_t* policydb, 
+		record_key_t* rkey,
+		record_t* record);
 
-	/* Modify record into the policy database */
-	int (*modify) (sepol_policydb_t* policydb, record_t* record);
+	/* Set policy record */
+	int (*set) (
+		sepol_policydb_t* policydb,
+		record_key_t* rkey,
+		record_t* record);
+
+	/* Query policy record */
+	int (*query) (
+		sepol_policydb_t* policydb,
+		record_key_t* rkey,
+		record_t** response);
 
+	/* Check if a record exists */
+	int (*exists) (
+		sepol_policydb_t* policydb,
+		record_key_t* rkey,
+		int* response);
+		
 	/* Iterate over records */
 	int (*iterate) (
 		sepol_policydb_t* policydb,
 		int (*fn)(record_t* record, void* fn_arg),
-	void* arg);
+		void* arg);
 
 } record_policydb_table_t;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/interfaces_file.c	2005-10-22 14:39:14.000000000 -0400
@@ -36,8 +36,7 @@ static int iface_parse(
 	/* Stub */
 	info = NULL;
 	iface = NULL;
-	return STATUS_ERR;
-
+	return STATUS_NODATA;
 }
 
 /* IFACE RECORD: metod table (interfaces_local.c) */
@@ -52,7 +51,7 @@ record_file_table_t SEMANAGE_IFACE_FILE_
 int iface_file_dbase_init(dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		NULL, /* FIXME */
+		"", /* FIXME */	
 		&SEMANAGE_IFACE_RTABLE,
 		&SEMANAGE_IFACE_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_policydb.c	2005-10-22 13:37:20.000000000 -0400
@@ -22,8 +22,11 @@ extern record_table_t SEPOL_IFACE_RTABLE
 
 /* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
-	.add         = sepol_iface_add,
-	.modify      = NULL, /* FIXME */
+	.add         = NULL,
+	.modify      = sepol_iface_modify,
+	.set         = NULL,
+	.query       = sepol_iface_query,
+	.exists      = sepol_iface_exists, 
 	.iterate     = sepol_iface_iterate,
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-22 14:46:16.000000000 -0400
@@ -25,20 +25,25 @@ static int load_handler(
 	dbase_t* dbase = arg->dconfig->dbase;
 	dbase_table_t* dtable = arg->dconfig->dtable;
 	record_table_t* rtable = dtable->get_rtable(handle, dbase);	
-	
+
 	if (rtable->key_extract(record, &rkey) < 0)
 		goto err;
  
 	switch (arg->mode) {
-		
+	
+		/* WARNING:
+		 * This assumes binary compatibility between
+		 * the source and target key/record type. This is currently
+		 * true, but may change in the future (?) */
+	
 		case MODE_SET:
-			if (dtable->set(handle, dbase, rkey, record) < 0)
+			if (dtable->set(handle, dbase, rkey, record) < 0) 
 				goto err;
 			break;
 		
 		default:
 		case MODE_MODIFY:
-			if (dtable->modify(handle, dbase, rkey, record) < 0)
+			if (dtable->modify(handle, dbase, rkey, record) < 0) 
 				goto err;
 			break;
 
@@ -91,15 +96,14 @@ int semanage_base_merge_components(
 		load_arg.mode   = components[i].mode;
 
 		if (from->dtable->iterate(
-			handle, from->dbase, load_handler, &load_arg) < 0)
+			handle, from->dbase, load_handler, &load_arg) < 0) 
 			goto err;
-					
 	}	
 	
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not merge local modifications into policy");
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/ports_policydb.c	2005-10-22 13:36:39.000000000 -0400
@@ -22,8 +22,11 @@ extern record_table_t SEPOL_PORT_RTABLE;
 
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
 record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
-	.add         = sepol_port_add,
-	.modify      = NULL, /* FIXME */
+	.add         = NULL, 
+	.modify      = sepol_port_modify,
+	.set         = NULL, 
+	.query       = sepol_port_query,
+	.exists      = sepol_port_exists,
 	.iterate     = sepol_port_iterate,
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/seusers_file.c	2005-10-22 14:39:32.000000000 -0400
@@ -34,7 +34,7 @@ static int seuser_parse(
 	/* Stub */
 	info = NULL;
 	seuser = NULL;
-	return STATUS_ERR;
+	return STATUS_NODATA;
 }
 
 /* SEUSER RECORD: method table (seusers.c) */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsemanage/src/users_policydb.c	2005-10-22 13:35:58.000000000 -0400
@@ -22,8 +22,11 @@ extern record_table_t SEPOL_USER_RTABLE;
 
 /* USER RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_USER_POLICYDB_RTABLE = {
-	.add         = NULL, /* FIXME */
+	.add         = NULL,
 	.modify      = sepol_user_modify,
+	.set         = NULL,
+	.query       = NULL, /* FIXME */
+	.exists      = sepol_user_exists,
 	.iterate     = sepol_user_iterate,
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-22 13:33:38.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-22 14:45:38.000000000 -0400
@@ -265,7 +265,7 @@ int sepol_user_modify(
 			goto err;
 		}
 	}	
-	
+
 	free(name);
 	free(roles);
 	free(mls_range);

--------------090709050708020605090003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
