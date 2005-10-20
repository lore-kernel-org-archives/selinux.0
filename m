Message-ID: <4357D018.1000306@cornell.edu>
Date: Thu, 20 Oct 2005 13:12:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] More dbase things
References: <4356F1B3.3060000@cornell.edu> <1129820743.2375.396.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129820743.2375.396.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090009090606010704090007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090009090606010704090007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Let's get that theory turned into practice RSN...
>   
Allright, fine... let's add some more things.

Attach patch:
- stubs dbase function set()
- adds dbase function get_rtable(), and uses it to complete the merge 
function in policy components
- moves if0-ed code for merge and commit in the right place. and adds 
attach/detach
- adds error messages into dbase_policydb_cache
- changes error code for all stubs from STATUS_SUCCESS to STATUS_ERR, so 
that client won't crash, expecting that the function succeeded.

-----
I can now begin to test functionality, and fix bugs (and implement 
functions one by one, and add error messages).



--------------090009090606010704090007
Content-Type: text/x-patch;
 name="libsemanage.further_dbase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.further_dbase.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_file.c	2005-10-20 13:01:59.000000000 -0400
@@ -26,7 +26,7 @@ static int bool_print(
 	/* Stub */
 	bool = NULL;
 	str = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 static int bool_parse(
@@ -36,7 +36,7 @@ static int bool_parse(
 	/* Stub */
 	info = NULL;
 	bool = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_policy.c	2005-10-20 13:02:22.000000000 -0400
@@ -127,7 +127,7 @@ int semanage_bool_query(
 	handle = NULL;
 	key = NULL;
 	response = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_bool_exists(
@@ -180,7 +180,7 @@ int semanage_bool_iterate(
 	handle = NULL;
 	handler = NULL;
 	handler_arg = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_bool_list(
@@ -192,5 +192,5 @@ int semanage_bool_list(
 	handle = NULL;
 	records = NULL;
 	count = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_default.c new/libsemanage/src/database_default.c
--- old/libsemanage/src/database_default.c	2005-10-19 12:13:26.000000000 -0400
+++ new/libsemanage/src/database_default.c	2005-10-20 12:18:27.000000000 -0400
@@ -58,6 +58,18 @@ static int dbase_default_modify (
 	return err_uninitialized(handle);
 }
 
+static int dbase_default_set (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+	
+	key = NULL;
+	data = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
 static int dbase_default_del (
 	semanage_handle_t* handle,
 	dbase_default_t* dbase,
@@ -126,6 +138,18 @@ static int dbase_default_list (
 	return err_uninitialized(handle);
 }
 
+static record_table_t* dbase_default_get_rtable(
+	semanage_handle_t* handle,
+	dbase_default_t* dbase) {
+
+	handle = NULL;
+	dbase = NULL;
+	err_uninitialized(handle);
+
+	/* FIXME */
+	return NULL;
+}
+
 /* DEFAULT dbase - method table implementation */
 dbase_table_t SEMANAGE_DEFAULT_DTABLE = {
 	.drop_cache = dbase_default_drop_cache,
@@ -134,8 +158,10 @@ dbase_table_t SEMANAGE_DEFAULT_DTABLE = 
 	.exists = dbase_default_exists,
 	.list = dbase_default_list,
 	.add = dbase_default_add,
+	.set = dbase_default_set,
 	.del = dbase_default_del,
 	.modify = dbase_default_modify, 
 	.query = dbase_default_query,
 	.count = dbase_default_count,
+	.get_rtable = dbase_default_get_rtable
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-19 12:13:26.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-20 13:01:44.000000000 -0400
@@ -375,6 +375,27 @@ static int dbase_file_add(
 	return STATUS_ERR;
 }
 
+static int dbase_file_set(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
+        /* Stub */
+        key = NULL;
+        data = NULL;
+	dbase->modified = 1;
+        return STATUS_ERR;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+
 static int dbase_file_modify(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase,
@@ -461,7 +482,7 @@ static int dbase_file_iterate(
 	fn = NULL;
 	arg = NULL;
 
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 static int dbase_file_del(
@@ -545,6 +566,14 @@ static int dbase_file_list(
 	return STATUS_ERR;
 }
 
+static record_table_t* dbase_file_get_rtable(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase) {
+
+	handle = NULL;
+	return dbase->rtable;
+}
+
 
 /* FILE dbase - method table implementation */
 dbase_table_t SEMANAGE_FILE_DTABLE = {
@@ -554,8 +583,10 @@ dbase_table_t SEMANAGE_FILE_DTABLE = {
 	.exists = dbase_file_exists, 
 	.list = dbase_file_list,   
 	.add = dbase_file_add,
+	.set = dbase_file_set,
 	.del = dbase_file_del, 
 	.modify = dbase_file_modify, 
 	.query = dbase_file_query, 
 	.count = dbase_file_count, 
+	.get_rtable = dbase_file_get_rtable
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/database.h	2005-10-20 12:17:46.000000000 -0400
@@ -48,7 +48,6 @@ typedef struct dbase_table {
 	/* Add the specified record to
 	 * the database if it is not present,
 	 * or fail if it already exists */
-
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -58,30 +57,41 @@ typedef struct dbase_table {
 	/* Add the specified record to the  
 	 * database if it not present. 
 	 * If it's present, replace it */
-
 	int (*modify) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_key_t* key,
 		record_t* data);
 
+	/* Modify the specified record in the database
+	 * if it is present. Fail if it does not yet exist */
+	int (*set) (
+		struct semanage_handle* handle,
+		dbase_t* dbase,
+		record_key_t* key,
+		record_t* data);
+
+	/* Delete a record */
 	int (*del) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_key_t* key);
 
+	/* Retrieve a record */
 	int (*query) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_key_t* key,
 		record_t** response);
 
+	/* Check if a record exists */
 	int (*exists) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_key_t* key,
 		int* response);
 
+	/* Count the number of records */
 	int (*count) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -92,7 +102,6 @@ typedef struct dbase_table {
 	 * can signal a successful exit by returning 1,
 	 * an error exit by returning -1, and continue by
 	 * returning 0 */
-
 	int (*iterate) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -101,27 +110,38 @@ typedef struct dbase_table {
 			void* varg),
 		void* fn_arg);
 
+	/* Construct a list of all records in this database */
 	int (*list) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_t*** records,
 		size_t* count);
-
+	
+	/* Forgets all changes that haven't been written
+	 * to the database backend */
 	void (*drop_cache) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
 
+	/* Writes the database changes to its backend */
 	int (*flush) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
 
+	/* Retrieves the record table for this database,
+	 * which specifies how to perform basic operations
+	 * on each record. */
+	record_table_t* (*get_rtable) (
+		struct semanage_handle* handle,
+		dbase_t* dbase);
+
 } dbase_table_t;
 
 typedef struct dbase_config {
 
 	/* Database state */
 	dbase_t* dbase;
-	
+
 	/* Database methods */
 	dbase_table_t* dtable;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-19 12:13:26.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-20 13:01:25.000000000 -0400
@@ -9,6 +9,7 @@ typedef struct dbase_policydb dbase_t;
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <errno.h>
 #include <unistd.h>
 #include <string.h>
 #include <sepol/policydb.h>
@@ -77,20 +78,22 @@ static int dbase_policydb_cache(
 	/* Open file */
 	fd = open(fname, O_RDONLY);
 	if (fd < 0) {
-		/* FIXME: handle error */
+		ERR(handle, "could not open %s for reading: %s",
+			fname, strerror(errno));
 		goto err;
 	}
 
 	/* Stat */
 	if (fstat(fd, &sb) < 0) {
-		/* FIXME: handle error */
+		ERR(handle, "could not stat %s: %s",
+			fname, strerror(errno));
 		goto err;
 	}
 
 	/* Map file */
 	data = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (data == MAP_FAILED) {
-		/* FIXME: handle error */
+		ERR(handle, "could not map policy: %s", strerror(errno));
 		goto err;
         }
 
@@ -108,10 +111,10 @@ static int dbase_policydb_cache(
 	return STATUS_SUCCESS;
 	
 	omem:
-	/* FIXME: handle error */
+	ERR(handle, "out of memory");
 	
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "unable to cache policy database from %s", fname);
 	if (fd > 0)
 		close(fd);
 	if (data != NULL)
@@ -134,7 +137,7 @@ static int dbase_policydb_flush(
 
 	/* Stub */
 	handle = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 
@@ -268,8 +271,27 @@ static int dbase_policydb_add (
 	/* Stub */
 	key = NULL;
 	data = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_set(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
 
+	/* Stub */
+	key = NULL;
+	data = NULL;
+	return STATUS_ERR;
+		
 	err:
 	/* FIXME: handle error */
 	return STATUS_ERR;
@@ -287,7 +309,7 @@ static int dbase_policydb_modify (
 	/* Stub */
 	key = NULL;
 	data = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -304,7 +326,7 @@ static int dbase_policydb_del (
 
 	/* Stub */
 	key = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -324,7 +346,7 @@ static int dbase_policydb_query (
 	key = NULL;
 	response = NULL;
 	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -345,7 +367,7 @@ static int dbase_policydb_exists (
 	key = NULL;
 	response = NULL;
 	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -364,7 +386,7 @@ static int dbase_policydb_count (
 	/* Stub */
 	response = NULL;
 	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -406,7 +428,7 @@ static int dbase_policydb_list (
 	records = NULL;
 	count = NULL;
 	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 	err:
 	/* FIXME: handle error */
@@ -414,6 +436,14 @@ static int dbase_policydb_list (
 	return STATUS_ERR;
 }
 
+static record_table_t* dbase_policydb_get_rtable(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	handle = NULL;
+	return dbase->rtable;
+}
+
 /* POLICYDB dbase - method table implementation */
 dbase_table_t SEMANAGE_POLICYDB_DTABLE = {
 	.drop_cache = dbase_policydb_drop_cache,
@@ -422,8 +452,10 @@ dbase_table_t SEMANAGE_POLICYDB_DTABLE =
 	.exists = dbase_policydb_exists,
 	.list = dbase_policydb_list,
 	.add = dbase_policydb_add,
+	.set = dbase_policydb_set,
 	.del = dbase_policydb_del,
 	.modify = dbase_policydb_modify, 
 	.query = dbase_policydb_query,
 	.count = dbase_policydb_count,
+	.get_rtable = dbase_policydb_get_rtable
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-20 13:06:13.000000000 -0400
@@ -331,20 +331,16 @@ static int semanage_direct_commit(semana
 	if (semanage_expand_sandbox(sh, base) < 0)
 		goto cleanup;
 
-#if 0
-	/* Link components into base policy */
-	if (semanage_base_merge_components(sh) < 0)
+	/* Verify policy */
+	if (semanage_verify_kernel(sh) != 0)
 		goto cleanup;
 
+#if 0
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
 #endif
 
-	/* Verify policy */
-	if (semanage_verify_kernel(sh) != 0)
-		goto cleanup;
-
 	retval = semanage_install_sandbox(sh);
 
  cleanup:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_file.c	2005-10-20 13:03:34.000000000 -0400
@@ -26,7 +26,7 @@ static int iface_print(
 	/* Stub */
 	iface = NULL;
 	str = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 static int iface_parse(
@@ -36,7 +36,7 @@ static int iface_parse(
 	/* Stub */
 	info = NULL;
 	iface = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-20 12:34:39.000000000 -0400
@@ -17,35 +17,39 @@ static int load_handler(
 	record_t* record,
 	void* varg) {
 
+	record_key_t* rkey = NULL;
 	load_handler_arg_t* arg = 
 		(load_handler_arg_t*) varg;
 
 	semanage_handle_t* handle = arg->handle;
 	dbase_t* dbase = arg->dconfig->dbase;
 	dbase_table_t* dtable = arg->dconfig->dtable;
-
+	record_table_t* rtable = dtable->get_rtable(handle, dbase);	
+	
+	if (rtable->key_extract(record, &rkey) < 0)
+		goto err;
+ 
 	switch (arg->mode) {
 		
 		case MODE_SET:
-#if 0
-			if (dtable->set(handle, dtable,
-				NULL, /* FIXME: KEY */, record) < 0)
+			if (dtable->set(handle, dbase, rkey, record) < 0)
 				goto err;
-#endif
 			break;
 		
 		default:
 		case MODE_MODIFY:
-			if (dtable->modify(handle, dbase,
-				NULL, /* FIXME: KEY */ record) < 0)
+			if (dtable->modify(handle, dbase, rkey, record) < 0)
 				goto err;
 			break;
 
 	}
+
+	rtable->key_free(rkey);
 	return 0;
 
 	err:
 	/* FIXME: handle error */
+	rtable->key_free(rkey);
 	return -1;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/ports_policy.c	2005-10-20 13:04:14.000000000 -0400
@@ -127,7 +127,7 @@ int semanage_port_query(
 	handle = NULL;
 	key = NULL;
 	response = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_port_exists(
@@ -180,7 +180,7 @@ int semanage_port_iterate(
 	handle = NULL;
 	handler = NULL;
 	handler_arg = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_port_list(
@@ -192,5 +192,5 @@ int semanage_port_list(
 	handle = NULL;
 	records = NULL;
 	count = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-20 13:05:57.000000000 -0400
@@ -24,7 +24,14 @@
  * direct connections, are here as well.
  */
 
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
 #include "semanage_store.h"
+#include "database_policydb.h"
+#include "handle.h"
+#include "policy.h"
 
 #include <selinux/selinux.h>
 #include <sepol/policydb.h>
@@ -1203,6 +1210,26 @@ int semanage_expand_sandbox(semanage_han
  		ERR(sh, "Unknown/Invalid policy version %d.", policyvers);
 		goto cleanup;
 	}
+
+#if 0
+	dbase_policydb_attach(sh, semanage_user_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(sh, semanage_port_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(sh, semanage_iface_dbase_policy(sh)->dbase, out);
+	dbase_policydb_attach(sh, semanage_bool_dbase_policy(sh)->dbase, out);
+
+	retval = semanage_base_merge_components(sh);
+
+	dbase_policydb_detach(sh, semanage_user_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(sh, semanage_port_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(sh, semanage_iface_dbase_policy(sh)->dbase);
+        dbase_policydb_detach(sh, semanage_bool_dbase_policy(sh)->dbase);
+
+	if (retval < 0) {
+		ERR(sh, "Unable to merge local modifications into policy.");
+		goto cleanup;
+	}
+#endif
+
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/seusers_file.c	2005-10-20 13:04:33.000000000 -0400
@@ -24,7 +24,7 @@ static int seuser_print(
 	/* Stub */
 	seuser = NULL;
 	str = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 static int seuser_parse(
@@ -34,7 +34,7 @@ static int seuser_parse(
 	/* Stub */
 	info = NULL;
 	seuser = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 /* SEUSER RECORD: method table (seusers.c) */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/users_policy.c	2005-10-20 13:04:41.000000000 -0400
@@ -127,7 +127,7 @@ int semanage_user_query(
 	handle = NULL;
 	key = NULL;
 	response = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_user_exists(
@@ -180,7 +180,7 @@ int semanage_user_iterate(
 	handle = NULL;
 	handler = NULL;
 	handler_arg = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }
 
 int semanage_user_list(
@@ -192,5 +192,5 @@ int semanage_user_list(
 	handle = NULL;
 	records = NULL;
 	count = NULL;
-	return STATUS_SUCCESS;
+	return STATUS_ERR;
 }

--------------090009090606010704090007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
