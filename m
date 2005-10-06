Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j97CM7Ns027087
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2005 08:22:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j97CLBX6020984
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2005 12:21:11 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j97CL9mB009879
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2005 08:21:09 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j97CL9RG009878
	for selinux@tycho.nsa.gov; Fri, 7 Oct 2005 08:21:09 -0400
Message-ID: <43454A61.8010907@cornell.edu>
Date: Thu, 06 Oct 2005 12:01:37 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: [ SEMANAGE ] [ SEPOL ] More database work
Content-Type: multipart/mixed;
 boundary="------------080804020701010305070806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080804020701010305070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The purpose of this patch is to resync against what I have here, which 
is a lot closer to being correct. It might have bugs, but the patch 
touches only unused code paths (the only code path that's used in the 
init/release path for databases, which doesn't do much). The main piece 
missing to make this testable/usable is commit() integration. I have 
file integration sort of working (meaning you can parse files, and 
hopefully modify them, and save the changes), but the changes aren't 
applied to policy yet. I will do further testing and debugging tomorrow. 
Until I've debugged and tested most of the merged code, commit() 
integration will stay out.

Patch is against the selinux-usr folder, since it touches sepol too.

Changes:

SEMANAGE:
==============

- Database interface: add a function called drop_cache(), which forces 
the database to reload the cache on the next call - this will be called 
after commit(), for example (because we're releasing the transaction lock)

- Direct database: remove double pointer policydb hack, since I don't 
know exactly how this is going to work, so I'll get rid of it for now
- Direct database: add cached/modified flags, and use those
- Direct database: try to implement cache function - haven't checked if 
it works yet...needs more things to test
- Direct database: implement iterate()

- File database: implement flush() - not sure if it works yet - looks 
right though.
- File database: fix a bug in list()

- Direct/File database: add construction of proper path, depending on 
whether we're in transaction or not
- Direct/File database: add functions called enter_ro(), exit_ro(), 
enter_rw(), and use those when the corresponding type of function is 
entered. Those functions check if user's connected, and if user's in 
transaction, and create/drop cache where appropriate. Read-only 
functions currently drop the cache on exit, since they don't hold any 
locks - I don't like this very much.

- Direct extension for records: register add() and modify() functions, 
and fill out the appropriate tables (with the functions from sepol). One 
thing that concerns me here is what to do with the key..which is 
currently unused in sepol.....missing for now.

- User and port databases - pass in the right filename suffix. In the 
direct case, allow an arbitrary suffix (so we can look in any module).
- User and port databases - implement parse() and print() functions. 
Those should work, based on testing in the past - I also just tested the 
user parse function today, and it seems to work (so, I can say that 
dbase_file_cache(), dbase_file_count(), and dbase_file_list() appear to 
work correctly...including the user parser)

SEPOL
==========
Rename functions to more consistent naming policy, that matches semanage 
(those names are now used by semanage). In particular, add() means add a 
new thing, and reject duplicates, modify() means add a new thing, or 
modify if it's already there (so it doesn't reject duplicates). load() 
is changed to either add or modify. Also makes a couple of internal 
functions static.





--------------080804020701010305070806
Content-Type: text/x-patch;
 name="libsemanage.sync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sync.diff"

diff -Naur --exclude libselinux old/libsemanage/src/database_direct.c exp/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/database_direct.c	2005-10-06 11:18:10.000000000 -0400
@@ -3,30 +3,23 @@
 #define DBASE_DEFINED
 
 #include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <unistd.h>
 #include <sepol/policydb.h>
 #include "database_direct.h"
+#include "semanage_store.h"
+#include "handle.h"
 #include "debug.h"
 
 /* POLICY DIRECT dbase */
 struct dbase_direct {
 
-	/* Backing file */
-	const char* filename;
-
-	/* Address to store the policydb object, once it's
-	 * read from the file above. This is a double pointer,
-	 * because the address will be provided from outside.
-	 * This is done for two reasons:
-	 *
-	 * 1) We want to share the same policy dbase object
-	 * for multiple databases {user/interfaces/ports} -> same policydb
-	 * dbase. We don't want to re-construct the policy separately for
-	 * each.
-	 *
-	 * 2) This allows the policydb to updated outside the dbase_*
-	 * call chain...for example on commit(), after modifications are made.
-	 */
-	policydb_t** policy;
+	/* Backing file suffix */
+	const char* suffix;
 
 	/* Base record table */
 	record_table_t* rtable;
@@ -34,21 +27,183 @@
 	/* Policy extensions */
 	record_direct_table_t* rptable;
 
+	policydb_t* policy;
+	int cached;
+	int modified;
 };
 
+static int construct_filename(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase,
+	char** filename) {
+
+	const char* path = (handle->is_in_transaction)?
+		semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL):
+		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
+
+	char* fname = malloc(fname_length);
+	if (!fname) {
+		/*  FIXME: handle error */
+		return STATUS_ERR;
+	}
+	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
+
+	*filename = fname;
+	return STATUS_SUCCESS;
+}
+
+static int dbase_direct_cache(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase) {
+
+	int fd = -1;
+	struct stat sb;
+	void* data = NULL;
+	policydb_t* policydb = NULL;
+
+	char* fname = NULL;
+
+	/* Already cached */
+	if (dbase->cached)
+		return STATUS_SUCCESS;
+	
+	if (construct_filename(handle, dbase, &fname) < 0)
+		goto err;
+
+	/* Open file */
+	fd = open(fname, O_RDONLY);
+	if (fd < 0) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	/* Stat */
+	if (fstat(fd, &sb) < 0) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	/* Map file */
+	data = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (data == MAP_FAILED) {
+		/* FIXME: handle error */
+		goto err;
+        }
+
+	/* Create policydb image */
+	policydb = (policydb_t*) malloc(sizeof(policydb_t));
+	if (!policydb)
+		goto omem;
+	if (policydb_from_image(data, sb.st_size, policydb) < 0)
+		goto err;
+	dbase->policy = policydb;
+
+	close(fd);
+	munmap(data, sb.st_size);
+	free(fname);
+	dbase->cached = 1;
+	return STATUS_SUCCESS;
+	
+	omem:
+	/* FIXME: handle error */
+	
+	err:
+	/* FIXME: handle error */
+	if (fd > 0)
+		close(fd);
+	if (data != NULL)
+		munmap(data, sb.st_size);
+	
+	free(policydb);
+	free(fname);
+	return STATUS_ERR;
+
+}
+
 static int dbase_direct_flush(
 	semanage_handle_t* handle,	
 	dbase_direct_t* dbase) {
 
+	if (!dbase->modified || !dbase->cached)
+		return STATUS_SUCCESS;
+
+	/* FIXME: policydb_to_image always writes a KERN policy */
+
 	/* Stub */
 	handle = NULL;
 	dbase = NULL;
 	return STATUS_SUCCESS;
 }
 
+
+static void dbase_direct_drop_cache(
+	semanage_handle_t* handle,       
+	 dbase_direct_t* dbase) {
+
+	if (dbase->cached) {
+		policydb_destroy(dbase->policy);
+		free(dbase->policy);
+		dbase->cached = 0;
+	}
+
+	handle = NULL;
+}
+
+static int enter_ro(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase) {
+
+	if (!handle->is_connected) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+	
+	//if (semanage_handle_get_read_lock(handle) < 0) {
+	//	/* FIXME: handle error */
+	//	return STATUS_ERR;
+	//}
+
+	if (dbase_direct_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static inline void exit_ro(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase) {
+
+	//semanage_release_read_lock(handle);
+	dbase_direct_drop_cache(handle, dbase);
+}
+
+static int enter_rw(
+	semanage_handle_t* handle,
+	dbase_direct_t* dbase) {
+
+	if (!handle->is_connected) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+	
+	if (!handle->is_in_transaction) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	if (dbase_direct_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;	
+}
+
 int dbase_direct_init(
-	const char* filename,
-	policydb_t** policy_update_ptr,
+	const char* suffix,
 	record_table_t* rtable,
 	record_direct_table_t* rptable,
         dbase_direct_t** dbase) {
@@ -59,10 +214,12 @@
 	if (!tmp_dbase)
 		goto omem;
 
-	tmp_dbase->filename = filename;
+	tmp_dbase->suffix = suffix;
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rptable = rptable;
-	tmp_dbase->policy = policy_update_ptr;
+	tmp_dbase->policy = NULL;
+	tmp_dbase->cached = 0;
+	tmp_dbase->modified = 0;
 	*dbase = tmp_dbase;
 
 	return STATUS_SUCCESS;
@@ -76,8 +233,10 @@
 
 /* Release dbase resources */
 void dbase_direct_release(
+	semanage_handle_t* handle,
 	dbase_direct_t* dbase) {
 
+	dbase_direct_drop_cache(handle, dbase);
 	free(dbase);
 }
 
@@ -86,13 +245,18 @@
 	dbase_direct_t* dbase,
 	record_key_t* key,
 	record_t* data) {
+	
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
 
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	key = NULL;
 	data = NULL;
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
 }
 
 static int dbase_direct_modify (
@@ -101,12 +265,17 @@
 	record_key_t* key,
 	record_t* data) {
 
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	key = NULL;
 	data = NULL;
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
 }
 
 static int dbase_direct_del (
@@ -114,11 +283,16 @@
 	dbase_direct_t* dbase,
 	record_key_t* key) {
 
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	key = NULL;
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
 }
 
 static int dbase_direct_query (
@@ -127,12 +301,19 @@
 	record_key_t* key,
 	record_t** response) {
 
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	key = NULL;
 	response = NULL;
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
 }
 
 static int dbase_direct_exists (
@@ -141,24 +322,38 @@
 	record_key_t* key,
 	int* response) {
 
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	key = NULL;
 	response = NULL;
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
 }
 
 static int dbase_direct_count (
 	semanage_handle_t* handle,
 	dbase_direct_t* dbase,
 	int* response) {
-	
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	response = NULL;
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
 }
 
 static int dbase_direct_iterate(
@@ -167,13 +362,19 @@
 	int (*fn) (record_t* record, void* fn_arg),
 	void* arg) {
 
-	/* Stub */
-	handle = NULL;
-	dbase = NULL;
-	fn = NULL;
-	arg = NULL;
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+	
+	if (dbase->rptable->iterate(dbase->policy, fn, arg) < 0)
+		goto err;
 
+	exit_ro(handle, dbase);
         return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
 }
 
 static int dbase_direct_list (
@@ -182,16 +383,24 @@
 	record_t*** records,
 	size_t* count) {
 
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	records = NULL;
 	count = NULL;
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
 }
 
 /* DIRECT POLICY dbase - method table implementation */
 dbase_table_t SEMANAGE_DIRECT_DTABLE = {
+	.drop_cache = dbase_direct_drop_cache,
 	.flush = dbase_direct_flush,
 	.iterate = dbase_direct_iterate,
 	.exists = dbase_direct_exists,
diff -Naur --exclude libselinux old/libsemanage/src/database_direct.h exp/libsemanage/src/database_direct.h
--- old/libsemanage/src/database_direct.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/database_direct.h	2005-10-06 11:18:10.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <sepol/policydb.h>
 #include "database.h"
+#include "handle.h"
 
 struct dbase_direct;
 typedef struct dbase_direct dbase_direct_t;
@@ -10,8 +11,11 @@
 /* POLICY DIRECT extension to RECORD interface - method table */
 typedef struct record_direct_table {
 
-	/* Load record into the policy database  */
-	int (*load) (policydb_t* policy, record_t* record);
+	/* Add record into the policy database */
+	int (*add) (policydb_t* policy, record_t* record);
+
+	/* Modify record into the policy database */
+	int (*modify) (policydb_t* policydb, record_t* record);
 
 	/* Iterate over records */
 	int (*iterate) (
@@ -21,16 +25,16 @@
 
 } record_direct_table_t;
 
-/* POLICY DIRECT - initialization */
+/* Initialize database */
 extern int dbase_direct_init(
-	const char* filename,
-	policydb_t** policy_update_ptr,
+	const char* suffix,
 	record_table_t* rtable,
 	record_direct_table_t* rptable,
 	dbase_direct_t** dbase);
 
-/* POLICY DIRECT - release */
+/* Release allocated resources */
 extern void dbase_direct_release(
+	semanage_handle_t* handle,
 	dbase_direct_t* dbase);
 
 /* POLICY DIRECT - method table implementation */
diff -Naur --exclude libselinux old/libsemanage/src/database_file.c exp/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/database_file.c	2005-10-06 11:18:10.000000000 -0400
@@ -4,8 +4,10 @@
 
 #include <stdlib.h>
 #include "debug.h"
+#include "handle.h"
 #include "parse_utils.h"
 #include "database_file.h"
+#include "semanage_store.h"
 
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
@@ -16,8 +18,8 @@
 /* FILE dbase */ 
 struct dbase_file {
 
-	/* Backing file */
-	const char* filename;
+	/* Backing file suffix */
+	const char* suffix;
 
 	/* Base record table */
 	record_table_t* rtable;
@@ -29,9 +31,31 @@
 	cache_entry_t* cache;
 	size_t cache_sz;
 	int cached;
-	int cache_invalid;
+	int modified;
 };
 
+static int construct_filename(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase,
+	char** filename) {
+
+	const char* path = (handle->is_in_transaction)?
+		semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL):
+		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
+
+	char* fname = malloc(fname_length);
+	if (!fname) {
+		/*  FIXME: handle error */
+		return STATUS_ERR;
+	}
+	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
+
+	*filename = fname;
+	return STATUS_SUCCESS;
+}
+
+
 /* Helper for adding records to the cache */
 static int dbase_file_cache_add(
         dbase_file_t* dbase,
@@ -54,33 +78,47 @@
 }
 
 static int dbase_file_cache(
+	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
 	/* Already cached */
-	if (dbase->cached && (!dbase->cache_invalid))
+	if (dbase->cached)
 		return STATUS_SUCCESS;
+	
+	dbase->cache_sz = 0;
+	dbase->cache = NULL;
 
 	int perr_fatal = 0;
 	/* FIXME: pass from caller? */
 
 	record_t* process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
-	parse_info_t parse_info;
-	parse_info.filename = dbase->filename;
-	parse_info.parse_arg = NULL;
-	/* FIXME: pass from caller? */
 
-	if (parse_open(&parse_info) < 0)
+	parse_info_t* parse_info;
+	char* fname = NULL;
+
+	/* Already cached */
+	if (dbase->cached)
+		return STATUS_SUCCESS;
+
+	if (construct_filename(handle, dbase, &fname) < 0)
+		goto err;
+
+	if (parse_init(fname, NULL, &parse_info) < 0) 
+		goto err;
+
+	if (parse_open(parse_info) < 0)
                 goto err;
 
 	/* Main processing loop */
 	do {
+
 		/* Create record */
 		if (dbase->rtable->create(&process_record) < 0)
 			goto err;
 
 		/* Parse record */
-		pstatus = dbase->rftable->parse(&parse_info, process_record);
+		pstatus = dbase->rftable->parse(parse_info, process_record);
 
 		/* Parse error is fatal, exit */
 		if (perr_fatal && (pstatus < 0))
@@ -90,44 +128,142 @@
 		else if (pstatus < 0)
 			continue;
 
+		/* End of file */
+		else if (pstatus == STATUS_NODATA)
+			break;
+
 		/* Add record to list */
 		if (dbase_file_cache_add(dbase, process_record) < 0)
 			goto err;
 
 	} while (pstatus != STATUS_NODATA);
 
-	parse_close(&parse_info);
+	parse_close(parse_info);
+	parse_release(parse_info);
+	free(fname);
 	dbase->cached = 1;
-	dbase->cache_invalid = 0;
 	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle failure */
 	dbase->rtable->free(process_record);
-	parse_close(&parse_info);
+	parse_close(parse_info);
+	parse_release(parse_info);
+	free(fname);
 	return STATUS_ERR;
 }
 
+static void dbase_file_drop_cache(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase) {
+
+	if (!dbase->cached)
+		return;
+
+	cache_entry_t *prev, *ptr = dbase->cache;
+	while (ptr != NULL) {
+		prev = ptr;
+		ptr = ptr->next;
+		dbase->rtable->free(prev->data);
+		free(prev);
+	}
+
+	dbase->cached = 0;
+	handle = NULL;
+}	
+
 /* Flush database to file */
 static int dbase_file_flush(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	/* Stub */
+	cache_entry_t* ptr;
+	char* fname = NULL;
+	FILE* str = NULL;
+
+	if (!dbase->modified || !dbase->cached)
+		return STATUS_SUCCESS;
+
+	if (!construct_filename(handle, dbase, &fname) < 0)
+		goto err;
+
+	str = fopen(fname, "w");
+	if (!str) {
+		/* FIXME: handle error condition */
+		goto err;
+	}
+
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+		if (dbase->rftable->print(ptr->data, str) < 0)
+			goto err;
+	}
+
+	fclose(str);
+	free(fname);
+	return STATUS_SUCCESS;
+
+	err:
 	handle = NULL;
-	dbase = NULL;
+	if (str != NULL)
+		fclose(str);
+	/* FIXME: handle error */
+	free(fname);
+	return STATUS_ERR;
+}
+
+static int enter_ro(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase) {
+
+	//if (semanage_handle_get_read_lock(handle) < 0) {
+	//	/* FIXME: handle error */
+	//	return STATUS_ERR;
+	//}
+
+	if (dbase_file_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static inline void exit_ro(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase) {
+
+	//semanage_release_read_lock(handle);
+	dbase_file_drop_cache(handle, dbase);
+}
+
+
+static int enter_rw(
+	semanage_handle_t* handle,
+	dbase_file_t* dbase) {
+
+	if (!handle->is_in_transaction) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	if (dbase_file_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
 	return STATUS_SUCCESS;
 }
 
 /* Helper for finding records in the cache */
 static int dbase_file_cache_locate(
+	semanage_handle_t* handle,
 	dbase_file_t* dbase,
 	record_key_t* key,
 	cache_entry_t** entry) {
 
 	cache_entry_t* ptr;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (dbase_file_cache(handle, dbase) < 0)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -144,7 +280,7 @@
 }
 
 int dbase_file_init(
-	const char* filename,
+	const char* suffix,
 	record_table_t* rtable,
 	record_file_table_t* rftable,
 	dbase_file_t** dbase) {
@@ -155,13 +291,12 @@
 	if (!tmp_dbase)
 		goto omem;
 
-	tmp_dbase->filename = filename;
+	tmp_dbase->suffix = suffix;
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rftable = rftable;
 	tmp_dbase->cache = NULL;
 	tmp_dbase->cache_sz = 0;
 	tmp_dbase->cached = 0;
-	tmp_dbase->cache_invalid = 0;
 
 	*dbase = tmp_dbase;
 	
@@ -172,19 +307,13 @@
 	free(tmp_dbase);
 	return STATUS_ERR;
 }
-		
+	
 /* Release dbase resources */
 void dbase_file_release(
+	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	cache_entry_t *prev, *ptr = dbase->cache;
-	while (ptr != NULL) {
-		prev = ptr;
-		ptr = ptr->next;
-                dbase->rtable->free(prev->data);
-		free(prev);
-	}
-
+	dbase_file_drop_cache(handle, dbase);
 	free(dbase);
 }
 
@@ -197,19 +326,20 @@
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	status = dbase_file_cache_locate(dbase, key, &entry);
+	status = dbase_file_cache_locate(handle, dbase, key, &entry);
 	if (status < 0)
 		goto err;
 
 	*response = (status != STATUS_NODATA);
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
 	/* FIXME: handle error condition */
+	exit_ro(handle, dbase);
 	return STATUS_ERR;
 }
 
@@ -221,7 +351,7 @@
 
 	int exists;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
 	if (dbase_file_exists(handle, dbase, key, &exists) < 0)
@@ -235,10 +365,10 @@
 	if (dbase_file_cache_add(dbase, data) < 0)
 		goto err;
 
+	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
 }
@@ -252,10 +382,10 @@
 	cache_entry_t* entry;
 	int status;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-	status = dbase_file_cache_locate(dbase, key, &entry);
+	status = dbase_file_cache_locate(handle, dbase, key, &entry);
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA)
@@ -263,10 +393,10 @@
 	else
 		entry->data = data;
 
+	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
 }
@@ -276,15 +406,16 @@
         dbase_file_t* dbase,
         int* response) {
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
 	*response = dbase->cache_sz;
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
 	/* FIXME: Handle error condition */
+	exit_ro(handle, dbase);
 	return STATUS_ERR;
 }
 
@@ -296,21 +427,23 @@
 
 	cache_entry_t* entry;
 	int status;
-        
-	if (dbase_file_cache(dbase) < 0)
+       
+	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	status = dbase_file_cache_locate(dbase, key, &entry);
+	status = dbase_file_cache_locate(handle, dbase, key, &entry);
 	if (status < 0 || status == STATUS_NODATA)
 		goto err;
 
 	if (dbase->rtable->clone(entry->data, response) < 0)
 		goto err;
 
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
+
 	err:
-	handle = NULL;
 	/* FIXME: Handle error condition */
+	exit_ro(handle, dbase);
 	return STATUS_ERR;
 }
 
@@ -336,7 +469,7 @@
 
 	cache_entry_t *ptr, *prev = NULL;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -349,6 +482,7 @@
 			dbase->rtable->free(ptr->data);
 			dbase->cache_sz--;
 			free(ptr);
+			dbase->modified = 1;
 			return STATUS_SUCCESS;
 		}
 		else
@@ -357,7 +491,6 @@
 
 	return STATUS_SUCCESS;
 	err:
-	handle = NULL;
 	/* FIXME: Handle error condition */
 	return STATUS_ERR;
 }
@@ -373,7 +506,7 @@
 	size_t tmp_count;
 	int i = 0;
 
-	if (dbase_file_cache(dbase) < 0)
+	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
 	tmp_count = dbase->cache_sz;
@@ -384,23 +517,28 @@
 		if (tmp_records == NULL)
 			goto omem;
 
-		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next)
-			if (dbase->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
+		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+
+			if (dbase->rtable->clone(ptr->data, &tmp_records[i]) < 0)
 				goto err;
+			i++;
+		}
 	}
+
 	*records = tmp_records;
 	*count = tmp_count;
 
+	exit_ro(handle, dbase);
 	return STATUS_SUCCESS;
 
 	omem:
-	handle = NULL;
 	/* FIXME: handle error condition */
 
 	err:
 	for (; i >= 0; i--)
 		dbase->rtable->free(tmp_records[i]);
 	free(tmp_records);
+	exit_ro(handle, dbase);
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
 }
@@ -408,6 +546,7 @@
 
 /* FILE dbase - method table implementation */
 dbase_table_t SEMANAGE_FILE_DTABLE = {
+	.drop_cache = dbase_file_drop_cache,
 	.flush = dbase_file_flush,
 	.iterate = dbase_file_iterate,
 	.exists = dbase_file_exists, 
diff -Naur --exclude libselinux old/libsemanage/src/database_file.h exp/libsemanage/src/database_file.h
--- old/libsemanage/src/database_file.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/database_file.h	2005-10-06 11:18:10.000000000 -0400
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "database.h"
 #include "parse_utils.h"
+#include "handle.h"
 
 struct dbase_file;
 typedef struct dbase_file dbase_file_t;
@@ -23,13 +24,14 @@
 
 /* FILE - initialization */
 extern int dbase_file_init(
-	const char* filename,
+	const char* suffix,
 	record_table_t* rtable,
 	record_file_table_t* rftable,
 	dbase_file_t** dbase);
 
 /* FILE - release */
 extern void dbase_file_release(
+	semanage_handle_t* handle,
 	dbase_file_t* dbase);
 
 /* FILE - method table implementation */
diff -Naur --exclude libselinux old/libsemanage/src/database.h exp/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/database.h	2005-10-06 11:18:10.000000000 -0400
@@ -14,6 +14,7 @@
 
 #include <stddef.h>
 
+/* Circular dependency */
 struct semanage_handle;
 
 /* RECORD interface - method table */
@@ -92,6 +93,10 @@
 		record_t*** records,
 		size_t* count);
 
+	void (*drop_cache) (
+		struct semanage_handle* handle,
+		dbase_t* dbase);
+
 	int (*flush) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
diff -Naur --exclude libselinux old/libsemanage/src/handle.c exp/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-04 10:51:22.000000000 -0400
+++ exp/libsemanage/src/handle.c	2005-10-06 11:18:37.000000000 -0400
@@ -124,8 +124,8 @@
 	semanage_conf_destroy(sh->conf);
 
 	/* Free object databases */
-	user_file_dbase_release(&sh->dbase[DBASE_USERS]);
-	port_file_dbase_release(&sh->dbase[DBASE_PORTS]);
+	user_file_dbase_release(sh, &sh->dbase[DBASE_USERS]);
+	port_file_dbase_release(sh, &sh->dbase[DBASE_PORTS]);
 
 	free(sh);
 }
diff -Naur --exclude libselinux old/libsemanage/src/ports_direct.c exp/libsemanage/src/ports_direct.c
--- old/libsemanage/src/ports_direct.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/ports_direct.c	2005-10-06 11:18:10.000000000 -0400
@@ -13,23 +13,28 @@
 #include <sepol/policydb.h>
 #include "ports_direct.h"
 #include "debug.h"
+#include "handle.h"
 #include "database_direct.h"
+#include "semanage_store.h"
 
 /* PORT RECORD (SEPOL): method table (ports_policy.c) */
 extern record_table_t SEPOL_PORT_RTABLE;
 
 /* PORT RECORD (SEPOL): POLICY DIRECT extension : method table */
 record_direct_table_t SEMANAGE_PORT_DIRECT_RTABLE = {
-	.load        = sepol_port_load,
+	.add         = sepol_port_add,
+	.modify      = NULL, /* FIXME */
 	.iterate     = sepol_port_iterate,
 };
 
-int port_direct_dbase_init(dbase_config_t* dconfig) {
+int port_direct_dbase_init(
+	const char* suffix,
+	dbase_config_t* dconfig) {
+
 	if (dbase_direct_init(
-		NULL,                         /* FIXME: backing file       */
-		NULL,                         /* FIXME: policydb pointer   */
-		&SEPOL_PORT_RTABLE,           /* base record table         */
-		&SEMANAGE_PORT_DIRECT_RTABLE, /* direct extensions         */
+		suffix,
+		&SEPOL_PORT_RTABLE,
+		&SEMANAGE_PORT_DIRECT_RTABLE, 
 		&dconfig->dbase) < 0) 
 		return STATUS_ERR;
 
@@ -38,6 +43,9 @@
 	return STATUS_SUCCESS;
 }
 
-void port_direct_dbase_release(dbase_config_t* dconfig) {
-	dbase_direct_release(dconfig->dbase);
+void port_direct_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_direct_release(handle, dconfig->dbase);
 }
diff -Naur --exclude libselinux old/libsemanage/src/ports_direct.h exp/libsemanage/src/ports_direct.h
--- old/libsemanage/src/ports_direct.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/ports_direct.h	2005-10-06 11:18:10.000000000 -0400
@@ -2,11 +2,14 @@
 #define _SEMANAGE_PORTS_DIRECT_H_
 
 #include "database.h"
+#include "handle.h"
 
 int port_direct_dbase_init(
+	const char* suffix,
 	dbase_config_t* dconfig);
 
 void port_direct_dbase_release(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif
diff -Naur --exclude libselinux old/libsemanage/src/ports_file.c exp/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/ports_file.c	2005-10-06 11:18:10.000000000 -0400
@@ -1,4 +1,5 @@
 #include <semanage/port_record.h>
+#include <semanage/context_record.h>
 
 typedef semanage_port_t record_t;
 typedef semanage_port_key_t record_key_t;
@@ -13,25 +14,114 @@
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
+#include "semanage_store.h"
+#include "handle.h"
 
 static int port_print(
 	semanage_port_t* port, 
 	FILE* str) {
 
-	/* Stub */
-	port = NULL;
-	str = NULL;
+	int low, high;
+	char* con_str = NULL;
+
+	if (fprintf(str, "portcon %s ", semanage_port_get_proto_str(port)) < 0)
+		goto err;
+
+	low = semanage_port_get_low(port);
+	high = semanage_port_get_high(port);
+
+	if (low == high) {
+		if (fprintf(str, "%d ", low) < 0)
+			goto err;
+	} else {
+		if (fprintf(str, "%d - %d ", low, high) < 0)
+			goto err;
+	}
+
+	con_str = semanage_context_to_string(semanage_port_get_con(port));
+	if (!con_str)
+		goto err;
+
+	if (fprintf(str, "%s\n", con_str) < 0)
+		goto err;
+
+	free(con_str);
 	return STATUS_SUCCESS;
+
+	err:
+        /* DEBUG(__FUNCTION__, "error writing to stream: %s\n", strerror(errno)); */
+	free(con_str);
+	return STATUS_ERR;
 }
 
 static int port_parse(
 	parse_info_t* info, 
 	semanage_port_t* port) {
 
-	/* Stub */
-	info = NULL;
-	port = NULL;
-	return STATUS_SUCCESS;	
+	int low, high, items;
+	char* proto = NULL;
+	char* context = NULL;
+	semanage_context_t* con = NULL;
+
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	items = sscanf(info->ptr, "portcon %as %d - %d %as",
+			&proto, &low, &high, &context);
+	if (items != 4) {
+		free(proto);
+		free(context);
+		items = sscanf(info->ptr, "portcon %as %d %as", &proto, &low, &context);
+		if (items != 3) {
+			/* DEBUG(__FUNCTION__, "malformed line %u (%s): \n%s\n",
+				info->lineno, info->filename, info->orig_line); */
+			goto err;
+		}
+		semanage_port_set_port(port, low);
+	}
+	else semanage_port_set_range(port, low, high);
+
+	if (!strcasecmp(proto, "tcp"))
+		semanage_port_set_proto(port, SEMANAGE_PROTO_TCP);
+
+	else if (!strcasecmp(proto, "udp"))
+		semanage_port_set_proto(port, SEMANAGE_PROTO_UDP);
+
+	else {
+		/* DEBUG(__FUNCTION__, "invalid protocol %s on line %u (%s)\n",
+			 proto, info->lineno, info->filename); */
+		goto err;
+	}
+
+	if (semanage_context_from_string(context, &con) < 0)
+		goto err;
+
+	/* <<none>> is not allowed for ports */
+	if (!con)
+		goto err;
+
+	semanage_port_set_con(port, con);
+	con = NULL;
+
+	free(proto);
+	free(context);
+	parse_dispose_line(info);
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+	err:
+	/* DEBUG(__FUNCTION__, "error parsing port record\n"); */
+	free(proto);
+	free(context);
+	semanage_context_free(con);
+
+	parse_dispose_line(info);
+	return STATUS_ERR;
 }
 
 /* PORT RECORD: method table (ports.c) */
@@ -46,9 +136,9 @@
 int port_file_dbase_init(dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
-		NULL,                         /* FIXME: backing file     */
-		&SEMANAGE_PORT_RTABLE,        /* record base table       */
-		&SEMANAGE_PORT_FILE_RTABLE,   /* file extensions         */
+		"port_contexts",
+		&SEMANAGE_PORT_RTABLE,
+		&SEMANAGE_PORT_FILE_RTABLE,
 		&dconfig->dbase) < 0)
 		return STATUS_ERR;
 
@@ -56,6 +146,9 @@
 	return STATUS_SUCCESS;
 }
 
-void port_file_dbase_release(dbase_config_t* dconfig) {
-	dbase_file_release(dconfig->dbase);
+void port_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(handle, dconfig->dbase);
 }
diff -Naur --exclude libselinux old/libsemanage/src/ports_file.h exp/libsemanage/src/ports_file.h
--- old/libsemanage/src/ports_file.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/ports_file.h	2005-10-06 11:18:10.000000000 -0400
@@ -2,11 +2,13 @@
 #define _SEMANAGE_PORTS_FILE_H_
 
 #include "database.h"
+#include "handle.h"
 
 int port_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void port_file_dbase_release(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naur --exclude libselinux old/libsemanage/src/users_direct.c exp/libsemanage/src/users_direct.c
--- old/libsemanage/src/users_direct.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/users_direct.c	2005-10-06 11:18:10.000000000 -0400
@@ -14,22 +14,27 @@
 #include "users_direct.h"
 #include "debug.h"
 #include "database_direct.h"
+#include "handle.h"
+#include "semanage_store.h"
 
 /* USER RECORD (SEPOL): method table (users_policy.c) */
 extern record_table_t SEPOL_USER_RTABLE;
 
 /* USER RECRORD (SEPOL): POLICY DIRECT extension: method table */
 record_direct_table_t SEMANAGE_USER_DIRECT_RTABLE = {
-	.load        = sepol_user_load,
+	.add         = sepol_user_add,
+	.modify      = sepol_user_modify,
 	.iterate     = sepol_user_iterate,
 };
 
-int user_direct_dbase_init(dbase_config_t* dconfig) {
+int user_direct_dbase_init(
+	const char* suffix,
+	dbase_config_t* dconfig) {
+
 	if (dbase_direct_init(
-		NULL,                         /* FIXME: backing file         */
-		NULL,                         /* FIXME: policydb pointer     */
-		&SEPOL_USER_RTABLE,           /* record base table */
-		&SEMANAGE_USER_DIRECT_RTABLE, /* direct extensions */
+		suffix,
+		&SEPOL_USER_RTABLE, 
+		&SEMANAGE_USER_DIRECT_RTABLE, 
 		&dconfig->dbase) < 0)
 		return STATUS_ERR;
 
@@ -37,6 +42,9 @@
 	return STATUS_SUCCESS;
 }
 
-void user_direct_dbase_release(dbase_config_t* dconfig) {
-	dbase_direct_release(dconfig->dbase);
+void user_direct_dbase_release(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+
+	dbase_direct_release(handle, dconfig->dbase);
 }
diff -Naur --exclude libselinux old/libsemanage/src/users_direct.h exp/libsemanage/src/users_direct.h
--- old/libsemanage/src/users_direct.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/users_direct.h	2005-10-06 11:18:10.000000000 -0400
@@ -2,11 +2,14 @@
 #define _SEMANAGE_USERS_DIRECT_H_
 
 #include "database.h"
+#include "handle.h"
 
 int user_direct_dbase_init(
+	const char* suffix,
 	dbase_config_t* dconfig);
 
 void user_direct_dbase_release(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif
diff -Naur --exclude libselinux old/libsemanage/src/users_file.c exp/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/users_file.c	2005-10-06 11:18:10.000000000 -0400
@@ -10,28 +10,211 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <ctype.h>
+#include <selinux/selinux.h>
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
+#include "semanage_store.h"
+#include "handle.h"
 
 static int user_print(
 	semanage_user_t* user, 
 	FILE* str) {
 
-	/* Stub */
-	user = NULL;
-	str = NULL;
+	const char** roles = NULL;
+	size_t i, nroles;
+
+	const char* name      = semanage_user_get_name(user);
+	const char* def_role  = semanage_user_get_defrole(user);
+	const char* mls_level = semanage_user_get_mlslevel(user);
+	const char* mls_range = semanage_user_get_mlsrange(user);
+
+	if (fprintf(str, "user %s roles { %s", name, def_role) < 0)
+		goto err;
+
+	if (semanage_user_get_roles(user, &roles, &nroles) < 0)
+		goto err;
+	
+	for (i = 0; i < nroles; i++) {
+		if (strcmp(roles[i], def_role) && 
+			fprintf(str, "%s ", roles[i]) < 0)
+			goto err;
+	}
+
+	if (fprintf(str, "}") < 0)
+		goto err;
+
+	/* MLS */
+	if (mls_level != NULL && mls_range != NULL)
+		if (fprintf(str, "level %s range %s", mls_level, mls_range) < 0)
+			goto err;
+
+	if (fprintf(str, ";\n") < 0)
+		goto err;
+
+	free(roles);
 	return STATUS_SUCCESS;
+
+	err:
+	free(roles);
+	/* DEBUG(__FUNCTION__, "error writing to stream: %s\n", strerror(errno)); */
+	return STATUS_ERR;
 }
 
 static int user_parse(
 	parse_info_t* info, 
 	semanage_user_t* user) {
 
-	/* Stub */
-	info = NULL;
-	user = NULL;
-	return STATUS_SUCCESS;	
+	int islist = 0;
+	char* mls = NULL;
+	char* start;
+
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Parse user name */
+	if (parse_assert_str(info, "user") < 0)
+		goto err;
+
+	if (parse_assert_space(info) < 0)
+		goto err;
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
+		goto err;
+
+	if (semanage_user_set_name(user, parse_fetch_string_inplace(info)) < 0)
+                goto err;
+
+	/* Parse roles header */
+	if (parse_assert_str(info, "roles") < 0)
+		goto err;
+
+	if (parse_assert_space(info) < 0)
+		goto err;
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
+		goto err;
+
+	islist = (parse_optional_ch(info,'{') != STATUS_NODATA);
+
+	/* For each role, loop */
+	do {
+		char delim;
+
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+		start = info->ptr;
+		while (
+			*(info->ptr) &&
+			*(info->ptr) != ';' &&
+			*(info->ptr) != '}' &&
+			!isspace(*(info->ptr)))
+			info->ptr++;
+
+		delim = *(info->ptr);
+		*(info->ptr)++ = '\0';
+
+		if (semanage_user_add_role(user, start) < 0)
+			goto err;
+
+		if (delim && !isspace(delim)) {
+			if (islist && delim == '}')
+				break;
+			else if (!islist && delim == ';')
+				goto skip_semicolon;
+			else
+				goto err;
+		}
+
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+		if (parse_optional_ch(info,';') != STATUS_NODATA)
+			goto skip_semicolon;
+
+		if (parse_optional_ch(info,'}') != STATUS_NODATA)
+			islist =0;
+
+	} while (islist);
+
+	/* Handle mls */
+	if (is_selinux_mls_enabled()) {
+
+		/* Parse level header */
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+		if (parse_optional_str(info, "level") != STATUS_NODATA)
+			goto semicolon;
+
+		if (parse_assert_space(info) < 0)
+			goto err;
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+		mls = parse_filter_space_until(info, "range");
+		if (!mls)
+			goto err;
+		if (semanage_user_set_mlslevel(user, mls) < 0)
+			goto err;
+		free(mls);
+
+		/* Parse range header */
+		if (parse_assert_str(info, "range") < 0)
+                       goto err;
+
+		if (parse_assert_space(info) < 0)
+			goto err;
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+		mls = parse_filter_space_until(info, ";");
+		if (!mls)
+			goto err;
+		if (semanage_user_set_mlsrange(user, mls) < 0)
+			goto err;
+		free(mls);
+	}
+
+	/* Check for semicolon */
+	semicolon:
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
+		goto err;
+	if (parse_assert_ch(info,';') < 0)
+		goto err;
+
+	info->ptr++;
+
+	skip_semicolon:
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+	err:
+        /* DEBUG(__FUNCTION__, "error parsing user record\n"); */
+	free(mls);
+	parse_dispose_line(info);
+	return STATUS_ERR;
 }
 
 /* USER RECORD: metod table (users.c) */
@@ -46,9 +229,9 @@
 int user_file_dbase_init(dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		NULL,                          /* FIXME: backing file  */
-		&SEMANAGE_USER_RTABLE,         /* record base table    */
-		&SEMANAGE_USER_FILE_RTABLE,    /* file extensions      */
+		"local.users",
+		&SEMANAGE_USER_RTABLE,
+		&SEMANAGE_USER_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
 		return STATUS_ERR;
 
@@ -56,6 +239,9 @@
 	return STATUS_SUCCESS;
 }
 
-void user_file_dbase_release(dbase_config_t* dconfig) {
-	dbase_file_release(dconfig->dbase);
+void user_file_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(handle, dconfig->dbase);
 }
diff -Naur --exclude libselinux old/libsemanage/src/users_file.h exp/libsemanage/src/users_file.h
--- old/libsemanage/src/users_file.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsemanage/src/users_file.h	2005-10-06 11:18:10.000000000 -0400
@@ -2,11 +2,13 @@
 #define _SEMANAGE_USERS_FILE_H_
 
 #include "database.h"
+#include "handle.h"
 
 int user_file_dbase_init(
 	dbase_config_t* dconfig);
 
 void user_file_dbase_release(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 #endif 
diff -Naur --exclude libselinux old/libsepol/include/sepol/interfaces.h exp/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/include/sepol/interfaces.h	2005-10-06 11:18:10.000000000 -0400
@@ -13,7 +13,7 @@
 	char** msgcon_str, size_t* msgcon_str_len);
 
 /* Load an interface into policy */
-extern int sepol_iface_load(
+extern int sepol_iface_add(
 	policydb_t* policydb,
 	sepol_iface_t* data);
 
diff -Naur --exclude libselinux old/libsepol/include/sepol/ports.h exp/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/include/sepol/ports.h	2005-10-06 11:18:10.000000000 -0400
@@ -15,7 +15,7 @@
 	size_t* con_str_len);
 
 /* Load the given port into policy. No shadowing is allowed. */
-extern int sepol_port_load(
+extern int sepol_port_add(
 	policydb_t* policydb, 
 	sepol_port_t* data);
 
diff -Naur --exclude libselinux old/libsepol/include/sepol/users.h exp/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/include/sepol/users.h	2005-10-06 11:18:10.000000000 -0400
@@ -19,7 +19,7 @@
 	policydb_t* policydb, 
 	const char *username);
 
-extern int sepol_user_load(
+extern int sepol_user_modify(
 	policydb_t* policydb, 
 	sepol_user_t* user);
 
diff -Naur --exclude libselinux old/libsepol/src/interfaces.c exp/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/src/interfaces.c	2005-10-06 11:18:10.000000000 -0400
@@ -12,7 +12,7 @@
 
 /* Create a low level interface structure from
  * a high level representation */
-int sepol_iface_struct_create(
+static int sepol_iface_struct_create(
 	policydb_t* policydb,
 	ocontext_t** iface,
 	sepol_iface_t* data) {
@@ -91,7 +91,7 @@
 }
 
 /* Load an interface into policy */
-int sepol_iface_load(
+int sepol_iface_add(
 	policydb_t* policydb, 
 	sepol_iface_t* data) {
 
diff -Naur --exclude libselinux old/libsepol/src/ports.c exp/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/src/ports.c	2005-10-06 11:18:10.000000000 -0400
@@ -38,7 +38,7 @@
 
 /* Create a low level port structure from
  * a high level representation */
-int sepol_port_struct_create(
+static int sepol_port_struct_create(
 	policydb_t* policydb,
 	ocontext_t** port,
 	sepol_port_t* data) {
@@ -132,7 +132,7 @@
 }
 
 /* Load a port into policy */
-int sepol_port_load(
+int sepol_port_add(
 	policydb_t* policydb, 
 	sepol_port_t* data) {
 
diff -Naur --exclude libselinux old/libsepol/src/users.c exp/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-06 11:16:51.000000000 -0400
+++ exp/libsepol/src/users.c	2005-10-06 11:18:10.000000000 -0400
@@ -99,7 +99,7 @@
 		goto err;
 	}
 	
-	if (sepol_user_load(policydb, user) < 0) 
+	if (sepol_user_modify(policydb, user) < 0) 
 		goto err;
 
 	free(name);
@@ -157,7 +157,7 @@
  * which case the supplied data replaces the existing data. Alternatively,
  * the user could be new. */
 
-int sepol_user_load(policydb_t* policydb, sepol_user_t* user) {
+int sepol_user_modify(policydb_t* policydb, sepol_user_t* user) {
 
 	/* For user data */	
 	const char *tmp_mlslevel, *tmp_mlsrange;

--------------080804020701010305070806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
