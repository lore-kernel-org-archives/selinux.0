Message-ID: <43C63AE4.1060904@cornell.edu>
Date: Thu, 12 Jan 2006 04:17:56 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Join: implementation
Content-Type: multipart/mixed;
 boundary="------------050205030603050005040404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050205030603050005040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements a two-source database join. I am thinking that it 
would be useful to have a multi-source join, but I don't know how to do 
that right now, and we have no use cases for it. I think two source-join 
is fine for now, and we can expand on that later. Also, technically you 
could nest several joins to merge information from many sources, 
although we probably need a better way to describe joint records first 
(right now I have to write lots of small functions that route to the 
proper record).

Anyway, this join is backed by a linked list, using inheritance - exact 
same thing as database_file and database_activedb. It does all the 
join-ing on cache() and all the un-joining on flush(). Cache lists 
records in each component dbase, then quick-sorts them, then merges them 
together. Flush writes back to its component databases, not to disk 
(direct_api controls how and when that happens).

The join requires each supporting record to implement functions join() 
and split() which construct a joint record from two component ones, and 
split it into pieces. An interesting feature is that join() must support 
one NULL component if necessary. What happens in that case is a partial 
join - the missing information is left blank if optional, or is 
initialized to something reasonable  if it's required. Particularly, the 
key is copied from the part that isn't missing. This provides a 
migration path from users without prefix to users with prefix. It's 
rather neat - if you have a completely different user set in each join 
part, they will be combined.

--------------050205030603050005040404
Content-Type: text/x-patch;
 name="libsemanage.join_implementation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.join_implementation.diff"

diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude-from excludes old/libsemanage/src/database_join.c new/libsemanage/src/database_join.c
--- old/libsemanage/src/database_join.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/database_join.c	2006-01-12 02:44:32.000000000 -0700
@@ -0,0 +1,304 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+/* Object: dbase_join_t (Join)
+ * Extends: dbase_llist_t (Linked List) 
+ * Implements: dbase_t (Database)
+ */
+
+struct dbase_join;
+typedef struct dbase_join dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+
+#include "user_internal.h"
+#include "debug.h"
+#include "handle.h"
+#include "database_join.h"
+#include "database_llist.h"
+
+/* JOIN dbase */ 
+struct dbase_join {
+
+	/* Parent object - must always be 
+	 * the first field - here we are using
+	 * a linked list to store the records */
+	dbase_llist_t llist;
+
+	/* Backing databases - for each
+	 * thing being joined  */
+	dbase_config_t* join1;
+	dbase_config_t* join2;
+
+	/* JOIN extension */
+	record_join_table_t* rjtable;
+};
+
+static int dbase_join_cache(
+	semanage_handle_t* handle,
+	dbase_join_t* dbase) {
+
+	/* Extract all the object tables information */ 
+	dbase_t* dbase1 = dbase->join1->dbase;
+	dbase_t* dbase2 = dbase->join2->dbase;
+	dbase_table_t* dtable1 = dbase->join1->dtable;
+	dbase_table_t* dtable2 = dbase->join2->dtable;
+	record_table_t* rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_join_table_t* rjtable = dbase->rjtable;
+	record_table_t* rtable1 = dtable1->get_rtable(dbase1);
+	record_table_t* rtable2 = dtable2->get_rtable(dbase2);
+
+	record_key_t* rkey = NULL;
+	record_t* record = NULL;
+	record1_t **records1 = NULL;
+	record2_t **records2 = NULL;
+	unsigned int rcount1 = 0, rcount2 = 0, i = 0, j = 0;
+
+	/* Already cached */
+	if (dbase_llist_is_cached(&dbase->llist))
+		return STATUS_SUCCESS;
+	
+	dbase_llist_cache_init(&dbase->llist);
+
+	/* First cache any child dbase, which must
+	 * be the first thing done when calling dbase
+	 * functions internally */
+	if (dtable1->cache(handle, dbase1) < 0)
+		goto err;
+	if (dtable2->cache(handle, dbase2) < 0)
+		goto err;
+
+	/* Fetch records */
+	if (dtable1->list(handle, dbase1, &records1, &rcount1) < 0)
+		goto err;
+	if (dtable2->list(handle, dbase2, &records2, &rcount2) < 0)
+		goto err;
+
+	/* Sort for quicker merge later */
+	qsort(records1, rcount1, sizeof(record1_t*), 
+		(int (*) (const void*, const void*)) rtable1->compare2_qsort);
+	qsort(records2, rcount2, sizeof(record2_t*), 
+		(int (*) (const void*, const void*)) rtable2->compare2_qsort);
+
+	/* Now merge into this dbase */
+	while (i < rcount1 || j < rcount2) {
+		int rc;
+
+		/* End of one list, or the other */
+		if (i == rcount1) 
+			rc = -1;
+		else if (j == rcount2)
+			rc = 1;
+
+		/* Still more records to go, compare them */
+		else {
+			if (rtable1->key_extract(handle, records1[i], &rkey) < 0)
+				goto err;
+
+			rc = rtable2->compare(records2[j], rkey);
+
+			rtable->key_free(rkey);
+			rkey = NULL;
+		}
+
+		/* Missing record1 data */
+		if (rc < 0) {
+			if (rjtable->join(handle, NULL, 
+				records2[j], &record) < 0)
+				goto err;
+			j++;
+		}	
+		
+		/* Missing record2 data */
+		else if (rc > 0) {
+			if (rjtable->join(handle, records1[i], 
+				NULL, &record) < 0)
+				goto err;
+			i++;
+		}
+	
+		/* Both records available */
+		else {
+			if (rjtable->join(handle, records1[i], 
+				records2[j], &record) < 0)
+				goto err;
+
+			i++;
+			j++;
+		}
+
+		/* Add result record to database */
+		if (dbase_llist_cache_prepend(handle, &dbase->llist, record) < 0)
+			goto err;
+
+		rtable->free(record);
+		record = NULL;
+	}
+
+	dbase_llist_set_cached(&dbase->llist, 1);
+
+	for (i=0; i < rcount1; i++)
+		rtable1->free(records1[i]);
+	for (i=0; i < rcount2; i++)
+		rtable2->free(records2[i]);
+	free(records1);
+	free(records2);
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not cache join database");
+	for (i=0; i < rcount1; i++)
+		rtable1->free(records1[i]);
+	for (i=0; i < rcount2; i++)
+		rtable2->free(records2[i]);
+	free(records1);
+	free(records2);
+	rtable->key_free(rkey);
+	rtable->free(record);
+	return STATUS_ERR;
+}
+
+/* Flush database */
+static int dbase_join_flush(
+	semanage_handle_t* handle,
+	dbase_join_t* dbase) {
+
+	/* Extract all the object tables information */
+	dbase_t* dbase1 = dbase->join1->dbase;
+	dbase_t* dbase2 = dbase->join2->dbase;
+	dbase_table_t* dtable1 = dbase->join1->dtable;
+	dbase_table_t* dtable2 = dbase->join2->dtable;
+	record_table_t* rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_join_table_t* rjtable = dbase->rjtable;
+	record_table_t* rtable1 = dtable1->get_rtable(dbase1);
+	record_table_t* rtable2 = dtable2->get_rtable(dbase2);
+
+	cache_entry_t* ptr;
+	record_key_t* rkey = NULL;
+	record1_t* record1 = NULL;
+	record2_t* record2 = NULL;
+
+	/* No effect of flush */
+	if (!dbase_llist_is_cached(&dbase->llist) ||
+	    !dbase_llist_is_modified(&dbase->llist))
+		return STATUS_SUCCESS;
+
+	/* First cache any dbase, (which should already be cached
+	 * unless somebody did a drop_cache on the underlying 
+	 * databases while we were working on the join, so this probably 
+	 * doesn't do anything - it's just a precaution) */
+	if (dtable1->cache(handle, dbase1) < 0)
+		goto err;
+	if (dtable2->cache(handle, dbase2) < 0)
+		goto err;
+
+	/* Then clear all records from the cache.
+	 * This is *not* the same as dropping the cache - it's an explicit
+	 * request to delete all current records. We need to do 
+	 * this because we don't store delete deltas for the join,
+	 * so we must re-add all records from scratch */
+	if (dtable1->del_all(handle, dbase1) < 0)
+		goto err;
+	if (dtable2->del_all(handle, dbase2) < 0)
+		goto err;
+
+	/* For each record, split, and add parts into their corresponding databases */
+	for (ptr = dbase->llist.cache_tail; ptr != NULL; ptr = ptr->prev) {
+
+		if (rtable->key_extract(handle, ptr->data, &rkey) < 0)
+			goto err;
+
+		if (rjtable->split(handle, ptr->data, 
+			&record1, &record2) < 0)
+			goto err;
+
+		if (record1 && dtable1->add(handle, dbase1, rkey, record1) < 0)
+			goto err;
+	
+		if (record2 && dtable2->add(handle, dbase2, rkey, record2) < 0)
+			goto err;
+
+		rtable->key_free(rkey);
+		rtable1->free(record1);
+		rtable2->free(record2);
+		rkey = NULL;
+		record1 = NULL;
+		record2 = NULL;
+	}
+
+	/* Note that this function does not flush the child databases, it
+	 * leaves that decision up to higher-level code */
+
+	dbase_llist_set_modified(&dbase->llist, 0);
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not flush join database");
+	rtable->key_free(rkey);
+	rtable1->free(record1);
+	rtable2->free(record2);
+	return STATUS_ERR;
+}
+
+int dbase_join_init(
+	semanage_handle_t* handle,
+	record_table_t* rtable,
+	record_join_table_t* rjtable,
+	dbase_config_t* join1,
+	dbase_config_t* join2,
+	dbase_t** dbase) {	
+ 
+	dbase_join_t* tmp_dbase = malloc(sizeof(dbase_join_t));
+	
+	if (!tmp_dbase)
+		goto omem;
+
+	dbase_llist_init(
+		&tmp_dbase->llist, rtable, &SEMANAGE_JOIN_DTABLE);
+
+	tmp_dbase->rjtable = rjtable;
+	tmp_dbase->join1 = join1;
+	tmp_dbase->join2 = join2;
+
+	*dbase = tmp_dbase;
+	
+	return STATUS_SUCCESS;
+	
+	omem:
+	ERR(handle, "out of memory, could not initialize join database");
+	free(tmp_dbase);
+	return STATUS_ERR;
+}
+	
+/* Release dbase resources */
+void dbase_join_release(
+	dbase_join_t* dbase) {
+
+	dbase_llist_drop_cache(&dbase->llist);
+	free(dbase);
+}
+
+/* JOIN dbase - method table implementation */
+dbase_table_t SEMANAGE_JOIN_DTABLE = {
+
+	/* Cache/Transactions */
+	.cache = dbase_join_cache,
+	.drop_cache = (void*) dbase_llist_drop_cache,
+	.flush = dbase_join_flush,
+	.is_modified = (void*) dbase_llist_is_modified,
+
+	/* Database API */
+	.iterate = (void*) dbase_llist_iterate,
+	.exists = (void*) dbase_llist_exists, 
+	.list = (void*) dbase_llist_list,   
+	.add = (void*) dbase_llist_add,
+	.set = (void*) dbase_llist_set,
+	.del = (void*) dbase_llist_del, 
+	.del_all = (void*) dbase_llist_del_all,
+	.modify = (void*) dbase_llist_modify, 
+	.query = (void*) dbase_llist_query, 
+	.count = (void*) dbase_llist_count, 
+
+	/* Polymorphism */
+	.get_rtable = (void*) dbase_llist_get_rtable
+};
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude-from excludes old/libsemanage/src/database_join.h new/libsemanage/src/database_join.h
--- old/libsemanage/src/database_join.h	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/database_join.h	2006-01-11 21:16:05.000000000 -0700
@@ -0,0 +1,54 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_DATABASE_JOIN_INTERNAL_H_
+#define _SEMANAGE_DATABASE_JOIN_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+#ifndef DBASE_RECORD_JOIN_DEFINED
+typedef void* record1_t;
+typedef void* record2_t;
+#define DBASE_RECORD_JOIN_DEFINED
+#endif
+
+struct dbase_join;
+typedef struct dbase_join dbase_join_t;
+
+/* JOIN extension to RECORD interface - method table */
+typedef struct record_join_table {
+
+	/* Join two records together.
+	 * One of the provided records could be NULL */
+	int (*join) (
+		semanage_handle_t* handle,
+		const record1_t* record1,
+		const record2_t* record2,
+		record_t** result);		
+
+	/* Splits a record into two */
+	int (*split) ( 
+		semanage_handle_t* handle,
+		const record_t* record,
+		record1_t** split1,
+		record2_t** split2);
+
+} record_join_table_t;
+
+/* JOIN - initialization */
+extern int dbase_join_init(
+	semanage_handle_t* handle,
+	record_table_t* rtable,
+	record_join_table_t* rjtable,
+	dbase_config_t* join1,
+	dbase_config_t* join2,
+	dbase_join_t** dbase);
+
+/* FILE - release */
+extern void dbase_join_release(
+	dbase_join_t* dbase);
+
+/* JOIN - method table implementation */
+extern dbase_table_t SEMANAGE_JOIN_DTABLE;
+
+#endif

--------------050205030603050005040404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
