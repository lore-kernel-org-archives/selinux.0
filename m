Message-ID: <43AB99F4.5060202@cornell.edu>
Date: Fri, 23 Dec 2005 01:32:20 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Separate file rw code from linked list
Content-Type: multipart/mixed;
 boundary="------------050503010900060009000500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050503010900060009000500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch separates the file dbase read (cache) and write (flush) code, 
from the linked list that's used when the records are in memory. There's 
several ways to do this, and this patch uses inheritance to do it - 
dbase_llist becomes the (abstract) parent, and dbase_file inherits from 
it, by routing the method table appropriately.

The reason for this is two-fold:
1) To allow re-use of the linked list dbase elsewhere... (like in a join 
implementation, or the policy server, or somewhere else).

2) To make it easier to implement another in-memory data structure in 
the future (like a hashtable).

I'm not entirely sure if this patch gets all the details right, but I 
think the general idea is on the right track - the representation in 
memory, and how the data gets there should be separate.

--------------050503010900060009000500
Content-Type: text/x-patch;
 name="libsemanage.dbase_llist.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_llist.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-12-22 23:15:33.000000000 -0500
@@ -11,34 +11,22 @@ typedef struct dbase_file dbase_t;
 #include "handle.h"
 #include "parse_utils.h"
 #include "database_file.h"
+#include "database_llist.h"
 #include "semanage_store.h"
 
-/* Representation of the database once loaded in memory */
-typedef struct cache_entry {
-	record_t* data;
-	struct cache_entry* prev;
-	struct cache_entry* next;
-} cache_entry_t;
-
 /* FILE dbase */ 
 struct dbase_file {
 
+	/* Parent object - must always be 
+	 * the first field - here we are using
+	 * a linked list to store the records */
+	dbase_llist_t llist;
+
 	/* Backing file suffix */
 	const char* suffix;
 
-	/* Base record table */
-	record_table_t* rtable;
-
 	/* FILE extension */
 	record_file_table_t* rftable;
-
-	/* In-memory representation (cache) */
-	cache_entry_t* cache;
-	cache_entry_t* cache_tail;
-
-	size_t cache_sz;
-	int cached;
-	int modified;
 };
 
 static int construct_filename(
@@ -63,41 +51,13 @@ static int construct_filename(
 	return STATUS_SUCCESS;
 }
 
-
-/* Helper for adding records to the cache */
-static int dbase_file_cache_prepend(
-	semanage_handle_t* handle, 
-	dbase_file_t* dbase,
-	record_t* data) {
-
-	/* Initialize */
-	cache_entry_t* entry =
-		(cache_entry_t*) malloc(sizeof (cache_entry_t));
-	if (entry == NULL)
-		goto omem;
-	entry->data = data;
-	entry->prev = NULL;
-	entry->next = dbase->cache;
-
-	/* Link */
-	if (dbase->cache != NULL)
-		dbase->cache->prev = entry;
-	if (dbase->cache_tail == NULL)
-		dbase->cache_tail = entry;
-	dbase->cache = entry;
-
-	dbase->cache_sz++;
-        return STATUS_SUCCESS;
-
-        omem:
-	ERR(handle, "out of memory, could not cache record");
-        return STATUS_ERR;
-}
-
 static int dbase_file_cache(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
+	record_table_t* rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_file_table_t* rftable = dbase->rftable;
+
 	record_t* process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 
@@ -105,12 +65,10 @@ static int dbase_file_cache(
 	char* fname = NULL;
 
 	/* Already cached */
-	if (dbase->cached)
+	if (dbase_llist_is_cached(&dbase->llist))
 		return STATUS_SUCCESS;
 
-	dbase->cache_sz = 0;
-	dbase->cache = NULL;
-	dbase->cache_tail = NULL;
+	dbase_llist_cache_init(&dbase->llist);
 
 	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
@@ -125,11 +83,11 @@ static int dbase_file_cache(
 	do {
 
 		/* Create record */
-		if (dbase->rtable->create(handle, &process_record) < 0)
+		if (rtable->create(handle, &process_record) < 0)
 			goto err;
 
 		/* Parse record */
-		pstatus = dbase->rftable->parse(handle, parse_info, process_record);
+		pstatus = rftable->parse(handle, parse_info, process_record);
 
 		/* Parse error */
 		if (pstatus < 0)
@@ -139,58 +97,44 @@ static int dbase_file_cache(
 		else if (pstatus == STATUS_NODATA) 
 			break;
 
-		/* Add record to list */
-		if (dbase_file_cache_prepend(handle, dbase, process_record) < 0)
+		/* Prepend to cache */
+		if (dbase_llist_cache_prepend(handle, &dbase->llist, 
+			process_record) < 0)
 			goto err;
+
 		process_record = NULL;
 
 	} while (pstatus != STATUS_NODATA);
 
-	dbase->rtable->free(process_record);
+	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
 	free(fname);
-	dbase->cached = 1;
-
+	dbase_llist_set_cached(&dbase->llist, 1);
 	return STATUS_SUCCESS;
 
 	err:
 	ERR(handle, "could not cache file database");
-	dbase->rtable->free(process_record);
+	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
 	free(fname);
 	return STATUS_ERR;
 }
 
-static void dbase_file_drop_cache(
-	dbase_file_t* dbase) {
-
-	if (!dbase->cached)
-		return;
-
-	cache_entry_t *prev, *ptr = dbase->cache;
-	while (ptr != NULL) {
-		prev = ptr;
-		ptr = ptr->next;
-		dbase->rtable->free(prev->data);
-		free(prev);
-	}
-
-	dbase->cached = 0;
-	dbase->modified = 0;
-}	
-
 /* Flush database to file */
 static int dbase_file_flush(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
+	record_file_table_t* rftable = dbase->rftable;
+
 	cache_entry_t* ptr;
 	char* fname = NULL;
 	FILE* str = NULL;
 
-	if (!dbase->modified || !dbase->cached)
+	if (!dbase_llist_is_cached(&dbase->llist) ||
+	    !dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
 	if (construct_filename(handle, dbase, &fname) < 0)
@@ -203,12 +147,12 @@ static int dbase_file_flush(
 		goto err;
 	}
 
-	for (ptr = dbase->cache_tail; ptr != NULL; ptr = ptr->prev) {
-		if (dbase->rftable->print(handle, ptr->data, str) < 0)
+	for (ptr = dbase->llist.cache_tail; ptr != NULL; ptr = ptr->prev) {
+		if (rftable->print(handle, ptr->data, str) < 0)
 			goto err;
 	}
 
-	dbase->modified = 0;
+	dbase_llist_set_modified(&dbase->llist, 0);
 	fclose(str);
 	free(fname);
 	return STATUS_SUCCESS;
@@ -222,39 +166,6 @@ static int dbase_file_flush(
 	return STATUS_ERR;
 }
 
-/* Check if modified */
-static int dbase_file_is_modified(
-	dbase_file_t* dbase) {
-
-	return dbase->modified;
-}
-
-/* Helper for finding records in the cache */
-static int dbase_file_cache_locate(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	cache_entry_t** entry) {
-
-	cache_entry_t* ptr;
-
-	if (dbase_file_cache(handle, dbase) < 0)
-		goto err;
-
-	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
-		if (! dbase->rtable->compare(ptr->data, key)) {
-			*entry = ptr;
-			return STATUS_SUCCESS;
-		}
-	}
-
-	return STATUS_NODATA;
-
-	err:
-	ERR(handle, "could not complete cache lookup");
-	return STATUS_ERR;
-}
-
 int dbase_file_init(
 	semanage_handle_t* handle, 
 	const char* suffix,
@@ -269,13 +180,9 @@ int dbase_file_init(
 		goto omem;
 
 	tmp_dbase->suffix = suffix;
-	tmp_dbase->rtable = rtable;
 	tmp_dbase->rftable = rftable;
-	tmp_dbase->cache = NULL;
-	tmp_dbase->cache_tail = NULL;
-	tmp_dbase->cache_sz = 0;
-	tmp_dbase->cached = 0;
-	tmp_dbase->modified = 0;
+	dbase_llist_init(
+		&tmp_dbase->llist, rtable, &SEMANAGE_FILE_DTABLE);
 
 	*dbase = tmp_dbase;
 	
@@ -291,281 +198,30 @@ int dbase_file_init(
 void dbase_file_release(
 	dbase_file_t* dbase) {
 
-	dbase_file_drop_cache(dbase);
+	dbase_llist_drop_cache(&dbase->llist);
 	free(dbase);
 }
 
-static int dbase_file_exists(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	int* response) {
-
-	cache_entry_t* entry;
-	int status;
-
-	status = dbase_file_cache_locate(handle, dbase, key, &entry);
-	if (status < 0)
-		goto err;
-
-	*response = (status != STATUS_NODATA);
-	return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not check if record exists");
-	return STATUS_ERR;
-}
-
-static int dbase_file_add(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	record_t* data) {
-
-	int status;
-	cache_entry_t* entry;
-
-	status = dbase_file_cache_locate(handle, dbase, key, &entry);
-	if (status < 0)
-		goto err;
-
-	if (status != STATUS_NODATA) {
-		ERR(handle, "record is already in the database");
-		goto err;
-	}
-
-	if (dbase_file_cache_prepend(handle, dbase, data) < 0)
-		goto err;
-
-	dbase->modified = 1;
-	return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not add record to the database");
-	return STATUS_ERR;
-}
-
-static int dbase_file_set(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	record_t* data) {
-
-	cache_entry_t* entry;
-	int status;
-
-	status = dbase_file_cache_locate(handle, dbase, key, &entry);
-	if (status < 0)
-		goto err;
-        if (status == STATUS_NODATA) {
-		ERR(handle, "record not found in the database");
-		goto err;
-	}
-	else {
-		dbase->rtable->free(entry->data);
-		entry->data = data;
-	}
-
-	dbase->modified = 1;
-        return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not set record value");
-	return STATUS_ERR;
-}
-
-
-static int dbase_file_modify(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	record_t* data) {
-
-	cache_entry_t* entry;
-	int status;
-
-	status = dbase_file_cache_locate(handle, dbase, key, &entry);
-	if (status < 0)
-		goto err;
-	if (status == STATUS_NODATA) {
-		if (dbase_file_cache_prepend(handle, dbase, data) < 0)
-			goto err;
-	}
-	else {
-		dbase->rtable->free(entry->data);
-		entry->data = data;
-	}
-
-	dbase->modified = 1;
-	return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not modify record value");
-	return STATUS_ERR;
-}
-
-static int dbase_file_count(
-        semanage_handle_t* handle,
-        dbase_file_t* dbase,
-        unsigned int* response) {
-
-	*response = dbase->cache_sz;
-	handle = NULL;
-	return STATUS_SUCCESS;
-}
-
-static int dbase_file_query(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key,
-	record_t** response) {
-
-	cache_entry_t* entry;
-	int status;
-       
-	status = dbase_file_cache_locate(handle, dbase, key, &entry);
-	if (status < 0 || status == STATUS_NODATA)
-		goto err;
-
-	if (dbase->rtable->clone(handle, entry->data, response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not query record value");
-	return STATUS_ERR;
-}
-
-static int dbase_file_iterate(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase, 
-	int (*fn) (record_t* record, void* fn_arg),
-	void* arg) {
-
-	int rc;
-	cache_entry_t* ptr;
-
-	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
-
-		rc = fn(ptr->data, arg);
-		if (rc < 0) 
-			goto err;
-		
-		else if (rc > 1)
-			break;
-        }
-
-
-        return STATUS_SUCCESS;
-
-	err:
-	ERR(handle, "could not iterate over records");
-	return STATUS_ERR;
-}
-
-static int dbase_file_del(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_key_t* key) {
-
-	cache_entry_t *ptr, *prev = NULL;
-
-	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
-		if (! dbase->rtable->compare(ptr->data, key)) {
-			if (prev != NULL)
-				prev->next = ptr->next;
-			else
-				dbase->cache = ptr->next;
-
-			if (ptr->next != NULL)
-				ptr->next->prev = ptr->prev;
-			else
-				dbase->cache_tail = ptr->prev;
-
-			dbase->rtable->free(ptr->data);
-			dbase->cache_sz--;
-			free(ptr);
-			dbase->modified = 1;
-			return STATUS_SUCCESS;
-		}
-		else
-			prev = ptr;
-	}
-
-	handle = NULL;
-	return STATUS_SUCCESS;
-}
-
-static int dbase_file_list(
-	semanage_handle_t* handle,
-	dbase_file_t* dbase,
-	record_t*** records,
-	size_t* count) {
-
-	cache_entry_t* ptr;
-	record_t** tmp_records = NULL;
-	size_t tmp_count;
-	int i = 0;
-
-	tmp_count = dbase->cache_sz;
-	if (tmp_count > 0) {
-		tmp_records = (record_t**)
-			calloc(tmp_count, sizeof (record_t*));
-
-		if (tmp_records == NULL)
-			goto omem;
-
-		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
-			if (dbase->rtable->clone(handle, 
-				ptr->data, &tmp_records[i]) < 0)
-				goto err;
-			i++;
-		}
-	}
-
-	*records = tmp_records;
-	*count = tmp_count;
-	return STATUS_SUCCESS;
-
-	omem:
-	ERR(handle, "out of memory");
-
-	err:
-	for (; i >= 0; i--)
-		dbase->rtable->free(tmp_records[i]);
-	free(tmp_records);
-	ERR(handle, "could not allocate record array");
-	return STATUS_ERR;
-}
-
-static record_table_t* dbase_file_get_rtable(
-	dbase_file_t* dbase) {
-
-	return dbase->rtable;
-}
-
-
 /* FILE dbase - method table implementation */
 dbase_table_t SEMANAGE_FILE_DTABLE = {
 
 	/* Cache/Transactions */
 	.cache = dbase_file_cache,
-	.drop_cache = dbase_file_drop_cache,
+	.drop_cache = (void*) dbase_llist_drop_cache,
 	.flush = dbase_file_flush,
-	.is_modified = dbase_file_is_modified,
+	.is_modified = (void*) dbase_llist_is_modified,
 
 	/* Database API */
-	.iterate = dbase_file_iterate,
-	.exists = dbase_file_exists, 
-	.list = dbase_file_list,   
-	.add = dbase_file_add,
-	.set = dbase_file_set,
-	.del = dbase_file_del, 
-	.modify = dbase_file_modify, 
-	.query = dbase_file_query, 
-	.count = dbase_file_count, 
+	.iterate = (void*) dbase_llist_iterate,
+	.exists = (void*) dbase_llist_exists, 
+	.list = (void*) dbase_llist_list,   
+	.add = (void*) dbase_llist_add,
+	.set = (void*) dbase_llist_set,
+	.del = (void*) dbase_llist_del, 
+	.modify = (void*) dbase_llist_modify, 
+	.query = (void*) dbase_llist_query, 
+	.count = (void*) dbase_llist_count, 
 
 	/* Polymorphism */
-	.get_rtable = dbase_file_get_rtable
+	.get_rtable = (void*) dbase_llist_get_rtable
 };
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2005-12-22 23:06:40.000000000 -0500
@@ -0,0 +1,328 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct dbase_llist;
+typedef struct dbase_llist dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include "debug.h"
+#include "handle.h"
+#include "database_llist.h"
+
+/* Helper for adding records to the cache */
+hidden int dbase_llist_cache_prepend(
+	semanage_handle_t* handle, 
+	dbase_llist_t* dbase,
+	record_t* data) {
+
+	/* Initialize */
+	cache_entry_t* entry =
+		(cache_entry_t*) malloc(sizeof (cache_entry_t));
+	if (entry == NULL)
+		goto omem;
+	entry->data = data;
+	entry->prev = NULL;
+	entry->next = dbase->cache;
+
+	/* Link */
+	if (dbase->cache != NULL)
+		dbase->cache->prev = entry;
+	if (dbase->cache_tail == NULL)
+		dbase->cache_tail = entry;
+	dbase->cache = entry;
+
+	dbase->cache_sz++;
+        return STATUS_SUCCESS;
+
+        omem:
+	ERR(handle, "out of memory, could not cache record");
+        return STATUS_ERR;
+}
+
+hidden void dbase_llist_drop_cache(
+	dbase_llist_t* dbase) {
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
+	dbase->modified = 0;
+}	
+
+/* Helper for finding records in the cache */
+static int dbase_llist_cache_locate(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	cache_entry_t** entry) {
+
+	cache_entry_t* ptr;
+
+	/* Implemented in parent */
+	if (dbase->dtable->cache(handle, dbase) < 0)
+		goto err;
+
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+		if (! dbase->rtable->compare(ptr->data, key)) {
+			*entry = ptr;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	return STATUS_NODATA;
+
+	err:
+	ERR(handle, "could not complete cache lookup");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_exists(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	int* response) {
+
+	cache_entry_t* entry;
+	int status;
+
+	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
+		goto err;
+
+	*response = (status != STATUS_NODATA);
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not check if record exists");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_add(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	int status;
+	cache_entry_t* entry;
+
+	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
+		goto err;
+
+	if (status != STATUS_NODATA) {
+		ERR(handle, "record is already in the database");
+		goto err;
+	}
+
+	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not add record to the database");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_set(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	cache_entry_t* entry;
+	int status;
+
+	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
+		goto err;
+        if (status == STATUS_NODATA) {
+		ERR(handle, "record not found in the database");
+		goto err;
+	}
+	else {
+		dbase->rtable->free(entry->data);
+		entry->data = data;
+	}
+
+	dbase->modified = 1;
+        return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not set record value");
+	return STATUS_ERR;
+}
+
+
+hidden int dbase_llist_modify(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	cache_entry_t* entry;
+	int status;
+
+	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
+		goto err;
+	if (status == STATUS_NODATA) {
+		if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
+			goto err;
+	}
+	else {
+		dbase->rtable->free(entry->data);
+		entry->data = data;
+	}
+
+	dbase->modified = 1;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not modify record value");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_count(
+        semanage_handle_t* handle,
+        dbase_llist_t* dbase,
+        unsigned int* response) {
+
+	*response = dbase->cache_sz;
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
+hidden int dbase_llist_query(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t** response) {
+
+	cache_entry_t* entry;
+	int status;
+       
+	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	if (status < 0 || status == STATUS_NODATA)
+		goto err;
+
+	if (dbase->rtable->clone(handle, entry->data, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not query record value");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_iterate(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase, 
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	int rc;
+	cache_entry_t* ptr;
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
+
+        return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not iterate over records");
+	return STATUS_ERR;
+}
+
+hidden int dbase_llist_del(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key) {
+
+	cache_entry_t *ptr, *prev = NULL;
+
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+		if (! dbase->rtable->compare(ptr->data, key)) {
+			if (prev != NULL)
+				prev->next = ptr->next;
+			else
+				dbase->cache = ptr->next;
+
+			if (ptr->next != NULL)
+				ptr->next->prev = ptr->prev;
+			else
+				dbase->cache_tail = ptr->prev;
+
+			dbase->rtable->free(ptr->data);
+			dbase->cache_sz--;
+			free(ptr);
+			dbase->modified = 1;
+			return STATUS_SUCCESS;
+		}
+		else
+			prev = ptr;
+	}
+
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
+hidden int dbase_llist_list(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_t*** records,
+	size_t* count) {
+
+	cache_entry_t* ptr;
+	record_t** tmp_records = NULL;
+	size_t tmp_count;
+	int i = 0;
+
+	tmp_count = dbase->cache_sz;
+	if (tmp_count > 0) {
+		tmp_records = (record_t**)
+			calloc(tmp_count, sizeof (record_t*));
+
+		if (tmp_records == NULL)
+			goto omem;
+
+		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+			if (dbase->rtable->clone(handle, 
+				ptr->data, &tmp_records[i]) < 0)
+				goto err;
+			i++;
+		}
+	}
+
+	*records = tmp_records;
+	*count = tmp_count;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	for (; i >= 0; i--)
+		dbase->rtable->free(tmp_records[i]);
+	free(tmp_records);
+	ERR(handle, "could not allocate record array");
+	return STATUS_ERR;
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_llist.h	2005-12-22 23:07:00.000000000 -0500
@@ -0,0 +1,146 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
+#define _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
+
+#include <stddef.h>
+#include "database.h"
+#include "handle.h"
+
+/* Representation of the database once loaded in memory */
+typedef struct cache_entry {
+	record_t* data;
+	struct cache_entry* prev;
+	struct cache_entry* next;
+} cache_entry_t;
+
+/* LLIST dbase */
+typedef struct dbase_llist {
+
+	/* Method tables */
+	record_table_t* rtable;
+	dbase_table_t* dtable;
+
+	/* In-memory representation (cache) */
+	cache_entry_t* cache;
+	cache_entry_t* cache_tail;
+
+	size_t cache_sz;
+	int cached;
+	int modified;
+} dbase_llist_t;
+
+/* Helpers for internal use only */
+
+static inline void dbase_llist_cache_init(
+	dbase_llist_t* dbase) {
+
+	dbase->cache = NULL;
+	dbase->cache_tail = NULL;
+	dbase->cache_sz = 0;
+	dbase->cached = 0;
+	dbase->modified = 0;
+}
+
+static inline void dbase_llist_init(
+	dbase_llist_t* dbase,
+	record_table_t* rtable,
+	dbase_table_t* dtable) {
+
+	dbase->rtable = rtable;
+	dbase->dtable = dtable;
+	dbase_llist_cache_init(dbase);
+}
+
+extern int dbase_llist_cache_prepend(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_t* data);
+
+static inline int dbase_llist_is_cached(
+	dbase_llist_t* dbase) {
+	return dbase->cached;
+}
+
+static inline void dbase_llist_set_cached(
+	dbase_llist_t* dbase,
+	int status) {
+	dbase->cached = status;
+}
+
+static inline void dbase_llist_set_modified(
+	dbase_llist_t* dbase,
+	int status) {
+	dbase->modified = status;
+}
+
+/* LLIST - cache/transactions */
+extern void dbase_llist_drop_cache(
+	dbase_llist_t* dbase);
+
+static inline int dbase_llist_is_modified(
+	dbase_llist_t* dbase) {
+	
+	return dbase->modified;
+}
+
+/* LLIST - polymorphism */
+static inline record_table_t* dbase_llist_get_rtable(
+	dbase_llist_t* dbase) {
+	return dbase->rtable;
+}
+
+/* LLIST - dbase API */
+extern int dbase_llist_exists(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	int* response);
+
+extern int dbase_llist_add(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data);
+
+extern int dbase_llist_set(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data);
+
+extern int dbase_llist_modify(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t* data);
+
+extern int dbase_llist_count(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	unsigned int* response);
+
+extern int dbase_llist_query(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key,
+	record_t** response);
+
+extern int dbase_llist_iterate(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg);
+
+extern int dbase_llist_del(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_key_t* key);
+
+extern int dbase_llist_list(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase,
+	record_t*** records,
+	size_t* count);
+
+#endif

--------------050503010900060009000500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
