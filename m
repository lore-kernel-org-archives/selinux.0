Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U2qcNs023568
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 22:52:38 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2kvA9011941
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:46:57 GMT
Message-ID: <433CA938.5090707@cornell.edu>
Date: Thu, 29 Sep 2005 22:55:52 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 3/9 ] [ SEMANAGE ] Rename files
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080503060301060408020802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080503060301060408020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch renames:

record_file.h -> interfaces.h
database_file.h -> database.h

with no changes in those files (hopefully).

This reflects changes in following patches.
Also, add proper status codes to some stubs.



--------------080503060301060408020802
Content-Type: text/x-patch;
 name="libsemanage.02.rename.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.02.rename.diff"

diff -Naur libsemanage/src/database.c libsemanage.new2/src/database.c
--- libsemanage/src/database.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/database.c	2005-09-29 17:08:21.000000000 -0400
@@ -0,0 +1,367 @@
+#include <stdlib.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <errno.h>
+#include "debug.h"
+#include "database.h"
+#include "interfaces.h"
+#include "users_file.h"
+#include "ports_file.h"
+
+/* Representation of the database once loaded in memory */
+typedef struct cache_entry {
+	record_t data;
+	struct cache_entry* prev;
+	struct cache_entry* next;
+} cache_entry_t;
+
+/* Database-specific configuration */
+struct dbase_config {
+
+	/* What's the format of this database */
+	record_table_t* rtable;
+
+	/* Where is it stored */
+	const char* filename;
+
+	/* Once parsed, it is cached here */
+	cache_entry_t* cache;
+	size_t cache_sz;
+};
+
+static int dbase_cache_add(
+	dbase_config_t* dconfig,
+	record_t data) {
+
+	cache_entry_t* entry = 
+		(cache_entry_t*) malloc(sizeof (cache_entry_t));
+	if (entry == NULL)
+		goto omem;
+	entry->data = data;
+	entry->prev = NULL;
+	entry->next = dconfig->cache;
+	if (dconfig->cache != NULL)
+		dconfig->cache->prev = entry;
+	dconfig->cache = entry;
+	dconfig->cache_sz++;
+
+	return STATUS_SUCCESS;
+	omem:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+static int dbase_open_file(parse_info_t* info) {
+
+	info->file_stream = fopen(info->filename, "r");
+	if (!info->file_stream && (errno != ENOENT)) {
+		/* FIXME: handle error condition */
+		return STATUS_ERR;
+	}
+	if (info->file_stream)
+		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
+
+        return STATUS_SUCCESS;
+}
+
+static void dbase_close_file(parse_info_t* info) {
+	if (info->file_stream && (fclose(info->file_stream) < 0))
+		/* FIXME: handle error condition */
+	info->file_stream = NULL;
+}
+
+static int dbase_cache_fill(
+	dbase_config_t* dconfig) {
+
+	/* Already cached */
+	if (dconfig->cache != NULL)
+		return STATUS_SUCCESS;
+
+	int perr_fatal = 0;
+	/* FIXME: pass from caller? */
+
+	record_t process_record = NULL;
+	int pstatus = STATUS_SUCCESS;
+	parse_info_t parse_info;
+	parse_info.filename = dconfig->filename;
+	parse_info.parse_arg = NULL;
+	/* FIXME: pass from caller? */
+
+	if (dbase_open_file(&parse_info) < 0)
+		goto err;
+
+	/* Main processing loop */
+	do {
+		/* Create record */
+		if (dconfig->rtable->create(&process_record) < 0)
+			goto err;
+
+		/* Parse record */
+		pstatus = dconfig->rtable->parse(&parse_info, process_record);
+
+		/* Parse error is fatal, exit */
+		if (perr_fatal && (pstatus < 0))
+			goto err;
+
+		/* Parse error is not fatal */
+		else if (pstatus < 0)
+			continue;
+
+		/* Add record to list */
+		if (dbase_cache_add(dconfig, process_record) < 0)
+			goto err;
+
+        } while (pstatus != STATUS_NODATA);
+
+	dbase_close_file(&parse_info);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle failure */
+	dconfig->rtable->free(process_record);
+	dbase_close_file(&parse_info);
+	return STATUS_ERR;
+}
+
+static int dbase_cache_locate(
+	dbase_config_t* dconfig,
+	record_key_t key, 
+	cache_entry_t** entry) {
+	
+	cache_entry_t* ptr;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) { 
+		if (! dconfig->rtable->compare(ptr->data, key)) {
+			*entry = ptr;	
+			return STATUS_SUCCESS;
+		}
+	}
+
+	return STATUS_NODATA;	
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_add(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data) {
+
+	int exists;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	if (dbase_exists(dconfig, key, &exists) < 0)
+		goto err;
+
+	else if (exists) { 
+		/* FIXME: handle error condition */
+		goto err;
+	}
+
+	if (dbase_cache_add(dconfig, data) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_modify(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data) {
+
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+	if (status == STATUS_NODATA)
+		return dbase_add(dconfig,key,data);
+	else
+		entry->data = data;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+
+}
+
+int dbase_del(
+	dbase_config_t* dconfig,
+	record_key_t key) {
+
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+	
+	else if (status != STATUS_NODATA) {
+		if (entry->next != NULL)
+			entry->next->prev = entry->prev;
+
+		if (entry->prev != NULL)
+			entry->prev->next = entry->next;
+		else
+			dconfig->cache = entry->next;
+
+		dconfig->rtable->free(entry->data);
+		dconfig->cache_sz--;
+		free(entry);
+	}
+
+	return STATUS_SUCCESS;
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_query(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t* response) {
+
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0 || status == STATUS_NODATA)
+		goto err;
+
+	if (dconfig->rtable->clone(entry->data, *response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_exists(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	int* response) {
+
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+
+	*response = (status != STATUS_NODATA);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_count(
+	dbase_config_t* dconfig,
+	int* response) {
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	*response = dconfig->cache_sz;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_iterate(
+	dbase_config_t* dconfig,
+	int (*fn) (record_t record, void* varg),
+	void* fn_arg) {
+
+	int status;	
+	cache_entry_t* ptr;
+	
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) {
+		status = fn(ptr->data, fn_arg);
+		if (status < 0)
+			goto err;
+
+		else if (status > 0)
+			break;
+	}
+	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
+}
+
+int dbase_list(
+	dbase_config_t* dconfig,
+	record_t** records,	
+	size_t* count) {
+
+	cache_entry_t* ptr;
+	record_t* tmp_records = NULL;
+	size_t tmp_count;
+	int i = 0;
+	
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	tmp_count = dconfig->cache_sz;
+
+	if (tmp_count > 0) {
+		tmp_records = (record_t*) calloc(tmp_count, sizeof (record_t));
+		if (tmp_records == NULL) 
+			goto omem;			
+	
+		for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) 
+			if (dconfig->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
+				goto err;
+
+	}
+	*records = tmp_records;
+	*count = tmp_count;
+
+	return STATUS_SUCCESS;	
+
+	omem:
+	/* FIXME: handle error condition */
+
+	err:
+	for (; i >= 0; i--) 
+		free(tmp_records[i]);
+	free(tmp_records);
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
diff -Naur libsemanage/src/database_file.c libsemanage.new2/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/database_file.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,367 +0,0 @@
-#include <stdlib.h>
-#include <stddef.h>
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <errno.h>
-#include "debug.h"
-#include "database.h"
-#include "record_file.h"
-#include "users_file.h"
-#include "ports_file.h"
-
-/* Representation of the database once loaded in memory */
-typedef struct cache_entry {
-	record_t data;
-	struct cache_entry* prev;
-	struct cache_entry* next;
-} cache_entry_t;
-
-/* Database-specific configuration */
-struct dbase_config {
-
-	/* What's the format of this database */
-	record_table_t* rtable;
-
-	/* Where is it stored */
-	const char* filename;
-
-	/* Once parsed, it is cached here */
-	cache_entry_t* cache;
-	size_t cache_sz;
-};
-
-static int dbase_cache_add(
-	dbase_config_t* dconfig,
-	record_t data) {
-
-	cache_entry_t* entry = 
-		(cache_entry_t*) malloc(sizeof (cache_entry_t));
-	if (entry == NULL)
-		goto omem;
-	entry->data = data;
-	entry->prev = NULL;
-	entry->next = dconfig->cache;
-	if (dconfig->cache != NULL)
-		dconfig->cache->prev = entry;
-	dconfig->cache = entry;
-	dconfig->cache_sz++;
-
-	return STATUS_SUCCESS;
-	omem:
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-}
-
-static int dbase_open_file(parse_info_t* info) {
-
-	info->file_stream = fopen(info->filename, "r");
-	if (!info->file_stream && (errno != ENOENT)) {
-		/* FIXME: handle error condition */
-		return STATUS_ERR;
-	}
-	if (info->file_stream)
-		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
-
-        return STATUS_SUCCESS;
-}
-
-static void dbase_close_file(parse_info_t* info) {
-	if (info->file_stream && (fclose(info->file_stream) < 0))
-		/* FIXME: handle error condition */
-	info->file_stream = NULL;
-}
-
-static int dbase_cache_fill(
-	dbase_config_t* dconfig) {
-
-	/* Already cached */
-	if (dconfig->cache != NULL)
-		return STATUS_SUCCESS;
-
-	int perr_fatal = 0;
-	/* FIXME: pass from caller? */
-
-	record_t process_record = NULL;
-	int pstatus = STATUS_SUCCESS;
-	parse_info_t parse_info;
-	parse_info.filename = dconfig->filename;
-	parse_info.parse_arg = NULL;
-	/* FIXME: pass from caller? */
-
-	if (dbase_open_file(&parse_info) < 0)
-		goto err;
-
-	/* Main processing loop */
-	do {
-		/* Create record */
-		if (dconfig->rtable->create(&process_record) < 0)
-			goto err;
-
-		/* Parse record */
-		pstatus = dconfig->rtable->parse(&parse_info, process_record);
-
-		/* Parse error is fatal, exit */
-		if (perr_fatal && (pstatus < 0))
-			goto err;
-
-		/* Parse error is not fatal */
-		else if (pstatus < 0)
-			continue;
-
-		/* Add record to list */
-		if (dbase_cache_add(dconfig, process_record) < 0)
-			goto err;
-
-        } while (pstatus != STATUS_NODATA);
-
-	dbase_close_file(&parse_info);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle failure */
-	dconfig->rtable->free(process_record);
-	dbase_close_file(&parse_info);
-	return STATUS_ERR;
-}
-
-static int dbase_cache_locate(
-	dbase_config_t* dconfig,
-	record_key_t key, 
-	cache_entry_t** entry) {
-	
-	cache_entry_t* ptr;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) { 
-		if (! dconfig->rtable->compare(ptr->data, key)) {
-			*entry = ptr;	
-			return STATUS_SUCCESS;
-		}
-	}
-
-	return STATUS_NODATA;	
-	err:
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_add(
-	dbase_config_t* dconfig,
-	record_key_t key,
-	record_t data) {
-
-	int exists;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	if (dbase_exists(dconfig, key, &exists) < 0)
-		goto err;
-
-	else if (exists) { 
-		/* FIXME: handle error condition */
-		goto err;
-	}
-
-	if (dbase_cache_add(dconfig, data) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_modify(
-	dbase_config_t* dconfig,
-	record_key_t key,
-	record_t data) {
-
-	cache_entry_t* entry;
-	int status;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	status = dbase_cache_locate(dconfig, key, &entry);
-	if (status < 0)
-		goto err;
-	if (status == STATUS_NODATA)
-		return dbase_add(dconfig,key,data);
-	else
-		entry->data = data;
-
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-
-}
-
-int dbase_del(
-	dbase_config_t* dconfig,
-	record_key_t key) {
-
-	cache_entry_t* entry;
-	int status;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	status = dbase_cache_locate(dconfig, key, &entry);
-	if (status < 0)
-		goto err;
-	
-	else if (status != STATUS_NODATA) {
-		if (entry->next != NULL)
-			entry->next->prev = entry->prev;
-
-		if (entry->prev != NULL)
-			entry->prev->next = entry->next;
-		else
-			dconfig->cache = entry->next;
-
-		dconfig->rtable->free(entry->data);
-		dconfig->cache_sz--;
-		free(entry);
-	}
-
-	return STATUS_SUCCESS;
-	err:
-	/* FIXME: Handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_query(
-	dbase_config_t* dconfig,
-	record_key_t key,
-	record_t* response) {
-
-	cache_entry_t* entry;
-	int status;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	status = dbase_cache_locate(dconfig, key, &entry);
-	if (status < 0 || status == STATUS_NODATA)
-		goto err;
-
-	if (dconfig->rtable->clone(entry->data, *response) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
-	err:
-	/* FIXME: Handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_exists(
-	dbase_config_t* dconfig,
-	record_key_t key,
-	int* response) {
-
-	cache_entry_t* entry;
-	int status;
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	status = dbase_cache_locate(dconfig, key, &entry);
-	if (status < 0)
-		goto err;
-
-	*response = (status != STATUS_NODATA);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_count(
-	dbase_config_t* dconfig,
-	int* response) {
-
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	*response = dconfig->cache_sz;
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: Handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_iterate(
-	dbase_config_t* dconfig,
-	int (*fn) (record_t record, void* varg),
-	void* fn_arg) {
-
-	int status;	
-	cache_entry_t* ptr;
-	
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) {
-		status = fn(ptr->data, fn_arg);
-		if (status < 0)
-			goto err;
-
-		else if (status > 0)
-			break;
-	}
-	
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: Handle error condition */
-	return STATUS_ERR;
-}
-
-int dbase_list(
-	dbase_config_t* dconfig,
-	record_t** records,	
-	size_t* count) {
-
-	cache_entry_t* ptr;
-	record_t* tmp_records = NULL;
-	size_t tmp_count;
-	int i = 0;
-	
-	if (dbase_cache_fill(dconfig) < 0)
-		goto err;
-
-	tmp_count = dconfig->cache_sz;
-
-	if (tmp_count > 0) {
-		tmp_records = (record_t*) calloc(tmp_count, sizeof (record_t));
-		if (tmp_records == NULL) 
-			goto omem;			
-	
-		for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) 
-			if (dconfig->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
-				goto err;
-
-	}
-	*records = tmp_records;
-	*count = tmp_count;
-
-	return STATUS_SUCCESS;	
-
-	omem:
-	/* FIXME: handle error condition */
-
-	err:
-	for (; i >= 0; i--) 
-		free(tmp_records[i]);
-	free(tmp_records);
-	/* FIXME: handle error condition */
-	return STATUS_ERR;
-}
diff -Naur libsemanage/src/interfaces.h libsemanage.new2/src/interfaces.h
--- libsemanage/src/interfaces.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new2/src/interfaces.h	2005-09-23 10:38:06.000000000 -0400
@@ -0,0 +1,57 @@
+#ifndef _SEMANAGE_RECORD_FILE_H_
+#define _SEMANAGE_RECORD_FILE_H_
+
+#include <stdio.h>
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+/* Structure available during parsing (created internally) */
+typedef struct parse_info {
+	/* Parser controlled */
+	/* Stub */
+
+	/* Engine-controlled */
+	const char* filename;   /* Input stream file name */
+	FILE* file_stream;      /* Input stream handle */
+
+	/* Caller supplied */
+	void* parse_arg;
+} parse_info_t;
+
+/* Record table format - necessary during processing */
+typedef struct record_table {
+
+	/* Create a record */
+	int (*create) (record_t* rec);
+
+	/* Extract key from record */
+	int (*key_extract) (record_t rec, record_key_t* key);
+	
+	/* Free record key */
+	void (*key_free) (record_key_t key);
+
+	/* Return 0 if record can be matched against key,
+	 * and 1 otherwise */
+	int (*compare) (record_t rec, record_key_t key);
+
+	/* Deep-copy clone of this record */
+	int (*clone) (record_t rec, record_t* new_rec);
+
+	/* Fill record structuure based on supplied parse info.
+	 * Parser must return STATUS_NODATA when EOF is encountered.
+	 * Parser must handle NULL file stream correctly */
+	int (*parse) (parse_info_t* info, record_t record);
+
+	/* Print record to stream */
+	int (*print) (record_t record, FILE* str);
+
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t rec);
+} record_table_t;
+
+#endif 
diff -Naur libsemanage/src/ports_file.c libsemanage.new2/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new2/src/ports_file.c	2005-09-29 17:07:03.000000000 -0400
@@ -1,11 +1,14 @@
-#include <stdlib.h>
-#include <stdio.h>
 #include <semanage/port_record.h>
 
 typedef semanage_port_t record_t;
 typedef semanage_port_key_t record_key_t;
 #define RECORD_DEFINED
-#include "record_file.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <semanage/port_record.h>
+#include "debug.h"
+#include "interfaces.h"
 
 static int semanage_port_print(
 	semanage_port_t port, 
@@ -14,7 +17,7 @@
 	/* Stub */
 	port = NULL;
 	str = NULL;
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 static int semanage_port_parse(
@@ -24,7 +27,7 @@
 	/* Stub */
 	info = NULL;
 	port = NULL;
-	return -1;	
+	return STATUS_SUCCESS;	
 }
 
 record_table_t RTABLE_PORT = {
diff -Naur libsemanage/src/ports_file.h libsemanage.new2/src/ports_file.h
--- libsemanage/src/ports_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new2/src/ports_file.h	2005-09-29 17:07:13.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef _SEMANAGE_PORTS_FILE_H_
 #define _SEMANAGE_PORTS_FILE_H_
 
-#include "record_file.h"
+#include "interfaces.h"
 
 extern record_table_t RTABLE_PORT;
 
diff -Naur libsemanage/src/record_file.h libsemanage.new2/src/record_file.h
--- libsemanage/src/record_file.h	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/record_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,57 +0,0 @@
-#ifndef _SEMANAGE_RECORD_FILE_H_
-#define _SEMANAGE_RECORD_FILE_H_
-
-#include <stdio.h>
-
-#ifndef RECORD_DEFINED
-typedef void* record_t;
-typedef void* record_key_t;
-#define RECORD_DEFINED
-#endif
-
-/* Structure available during parsing (created internally) */
-typedef struct parse_info {
-	/* Parser controlled */
-	/* Stub */
-
-	/* Engine-controlled */
-	const char* filename;   /* Input stream file name */
-	FILE* file_stream;      /* Input stream handle */
-
-	/* Caller supplied */
-	void* parse_arg;
-} parse_info_t;
-
-/* Record table format - necessary during processing */
-typedef struct record_table {
-
-	/* Create a record */
-	int (*create) (record_t* rec);
-
-	/* Extract key from record */
-	int (*key_extract) (record_t rec, record_key_t* key);
-	
-	/* Free record key */
-	void (*key_free) (record_key_t key);
-
-	/* Return 0 if record can be matched against key,
-	 * and 1 otherwise */
-	int (*compare) (record_t rec, record_key_t key);
-
-	/* Deep-copy clone of this record */
-	int (*clone) (record_t rec, record_t* new_rec);
-
-	/* Fill record structuure based on supplied parse info.
-	 * Parser must return STATUS_NODATA when EOF is encountered.
-	 * Parser must handle NULL file stream correctly */
-	int (*parse) (parse_info_t* info, record_t record);
-
-	/* Print record to stream */
-	int (*print) (record_t record, FILE* str);
-
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t rec);
-} record_table_t;
-
-#endif 
diff -Naur libsemanage/src/users_file.c libsemanage.new2/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new2/src/users_file.c	2005-09-29 17:07:53.000000000 -0400
@@ -1,11 +1,13 @@
-#include <stdlib.h>
-#include <stdio.h>
 #include <semanage/user_record.h>
 
 typedef semanage_user_t record_t;
 typedef semanage_user_key_t record_key_t;
 #define RECORD_DEFINED
-#include "record_file.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include "interfaces.h"
+#include "debug.h"
 
 static int semanage_user_print(
 	semanage_user_t user, 
@@ -14,7 +16,7 @@
 	/* Stub */
 	user = NULL;
 	str = NULL;
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 static int semanage_user_parse(
@@ -24,7 +26,7 @@
 	/* Stub */
 	info = NULL;
 	user = NULL;
-	return -1;	
+	return STATUS_SUCCESS;	
 }
 
 record_table_t RTABLE_USER = {
diff -Naur libsemanage/src/users_file.h libsemanage.new2/src/users_file.h
--- libsemanage/src/users_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new2/src/users_file.h	2005-09-29 17:08:00.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef _SEMANAGE_USERS_FILE_H_
 #define _SEMANAGE_USERS_FILE_H_
 
-#include "record_file.h"
+#include "interfaces.h"
 
 extern record_table_t RTABLE_USER;
 

--------------080503060301060408020802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
