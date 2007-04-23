Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUWmo001607
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:32 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUTSG027819
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:29 GMT
Message-Id: <20070423213729.020024000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:04 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/33] libsemanage: dbase/dconfig cleanup
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This passes the entire dconfig for all calls which is necessary to serialize the databases.

---
 libsemanage/src/booleans_policydb.c   |    2 
 libsemanage/src/database.c            |   42 +++++++--
 libsemanage/src/database.h            |   58 +++++++++----
 libsemanage/src/database_activedb.c   |   17 ++-
 libsemanage/src/database_file.c       |   12 +-
 libsemanage/src/database_join.c       |   24 +++--
 libsemanage/src/database_llist.c      |   70 ++++++++++++----
 libsemanage/src/database_llist.h      |   55 ++++++++----
 libsemanage/src/database_policydb.c   |  145 +++++++++++++++++++++-------------
 libsemanage/src/database_policydb.h   |   61 +++++++++++++-
 libsemanage/src/direct_api.c          |   35 +++-----
 libsemanage/src/interfaces_policydb.c |    2 
 libsemanage/src/nodes_policydb.c      |    2 
 libsemanage/src/policy_components.c   |   32 +++----
 libsemanage/src/ports_policydb.c      |    2 
 libsemanage/src/users_base_policydb.c |    2 
 16 files changed, 381 insertions(+), 180 deletions(-)

Index: selinux-pms-support/libsemanage/src/booleans_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/booleans_policydb.c
+++ selinux-pms-support/libsemanage/src/booleans_policydb.c
@@ -67,5 +67,5 @@ int bool_policydb_dbase_init(semanage_ha
 void bool_policydb_dbase_release(dbase_config_t * dconfig)
 {
 
-	dbase_policydb_release(dconfig->dbase);
+	dbase_policydb_release(dconfig);
 }
Index: selinux-pms-support/libsemanage/src/database.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database.c
+++ selinux-pms-support/libsemanage/src/database.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 #include <semanage/handle.h>
 #include "semanage_store.h"
@@ -36,7 +56,7 @@ static int enter_ro(semanage_handle_t * 
 		}
 	}
 
-	if (dconfig->dtable->cache(handle, dconfig->dbase) < 0)
+	if (dconfig->dtable->cache(handle, dconfig) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -69,7 +89,7 @@ static int enter_rw(semanage_handle_t * 
 		goto err;
 	}
 
-	if (dconfig->dtable->cache(handle, dconfig->dbase) < 0)
+	if (dconfig->dtable->cache(handle, dconfig) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -87,7 +107,7 @@ int dbase_modify(semanage_handle_t * han
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->modify(handle, dconfig->dbase, key, data) < 0)
+	if (dconfig->dtable->modify(handle, dconfig, key, data) < 0)
 		return STATUS_ERR;
 
 	return STATUS_SUCCESS;
@@ -101,7 +121,7 @@ int dbase_set(semanage_handle_t * handle
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->set(handle, dconfig->dbase, key, data) < 0)
+	if (dconfig->dtable->set(handle, dconfig, key, data) < 0)
 		return STATUS_ERR;
 
 	return STATUS_SUCCESS;
@@ -114,7 +134,7 @@ int dbase_del(semanage_handle_t * handle
 	if (enter_rw(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->del(handle, dconfig->dbase, key) < 0)
+	if (dconfig->dtable->del(handle, dconfig, key) < 0)
 		return STATUS_ERR;
 
 	return STATUS_SUCCESS;
@@ -128,7 +148,7 @@ int dbase_query(semanage_handle_t * hand
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->query(handle, dconfig->dbase, key, response) < 0) {
+	if (dconfig->dtable->query(handle, dconfig, key, response) < 0) {
 		exit_ro(handle, dconfig);
 		return STATUS_ERR;
 	}
@@ -144,7 +164,7 @@ int dbase_exists(semanage_handle_t * han
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->exists(handle, dconfig->dbase, key, response) < 0) {
+	if (dconfig->dtable->exists(handle, dconfig, key, response) < 0) {
 		exit_ro(handle, dconfig);
 		return STATUS_ERR;
 	}
@@ -159,7 +179,7 @@ int dbase_count(semanage_handle_t * hand
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0) {
+	if (dconfig->dtable->count(handle, dconfig, response) < 0) {
 		exit_ro(handle, dconfig);
 		return STATUS_ERR;
 	}
@@ -176,7 +196,7 @@ int dbase_iterate(semanage_handle_t * ha
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->iterate(handle, dconfig->dbase, fn, fn_arg) < 0) {
+	if (dconfig->dtable->iterate(handle, dconfig, fn, fn_arg) < 0) {
 		exit_ro(handle, dconfig);
 		return STATUS_ERR;
 	}
@@ -192,7 +212,7 @@ int dbase_list(semanage_handle_t * handl
 	if (enter_ro(handle, dconfig) < 0)
 		return STATUS_ERR;
 
-	if (dconfig->dtable->list(handle, dconfig->dbase, records, count) < 0) {
+	if (dconfig->dtable->list(handle, dconfig, records, count) < 0) {
 		exit_ro(handle, dconfig);
 		return STATUS_ERR;
 	}
Index: selinux-pms-support/libsemanage/src/database.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database.h
+++ selinux-pms-support/libsemanage/src/database.h
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
@@ -14,8 +34,9 @@ typedef void *dbase_t;
 #define DBASE_DEFINED
 #endif
 
-/* Circular dependency */
+/* Circular dependencies */
 struct semanage_handle;
+struct dbase_config;
 
 /* RECORD interface - method table */
 typedef struct record_table {
@@ -66,7 +87,7 @@ typedef struct dbase_table {
 	/* Add the specified record to
 	 * the database. No check for duplicates is performed */
 	int (*add) (struct semanage_handle * handle,
-		    dbase_t * dbase,
+		    struct dbase_config * dconfig,
 		    const record_key_t * key, const record_t * data);
 
 	/* Add the specified record to the  
@@ -74,24 +95,25 @@ typedef struct dbase_table {
 	 * If it's present, replace it
 	 */
 	int (*modify) (struct semanage_handle * handle,
-		       dbase_t * dbase,
+		       struct dbase_config * dconfig,
 		       const record_key_t * key, const record_t * data);
 
 	/* Modify the specified record in the database
 	 * if it is present. Fail if it does not yet exist
 	 */
 	int (*set) (struct semanage_handle * handle,
-		    dbase_t * dbase,
+		    struct dbase_config * dconfig,
 		    const record_key_t * key, const record_t * data);
 
 	/* Delete a record */
 	int (*del) (struct semanage_handle * handle,
-		    dbase_t * dbase, const record_key_t * key);
+		    struct dbase_config * dconfig, const record_key_t * key);
 
 	/* Clear all records, and leave the database in
 	 * cached, modified state. This function does 
 	 * not require a call to cache() */
-	int (*clear) (struct semanage_handle * handle, dbase_t * dbase);
+	int (*clear) (struct semanage_handle * handle,
+		      struct dbase_config * dconfig);
 
 	/* Retrieve a record 
 	 * 
@@ -100,17 +122,17 @@ typedef struct dbase_table {
 	 * must be freed accordingly */
 
 	int (*query) (struct semanage_handle * handle,
-		      dbase_t * dbase,
+		      struct dbase_config * dconfig,
 		      const record_key_t * key, record_t ** response);
 
 	/* Check if a record exists */
 	int (*exists) (struct semanage_handle * handle,
-		       dbase_t * dbase,
+		       struct dbase_config * dconfig,
 		       const record_key_t * key, int *response);
 
 	/* Count the number of records */
 	int (*count) (struct semanage_handle * handle,
-		      dbase_t * dbase, unsigned int *response);
+		      struct dbase_config * dconfig, unsigned int *response);
 
 	/* Execute the specified handler over 
 	 * the records of this database. The handler
@@ -129,7 +151,7 @@ typedef struct dbase_table {
 	 * not modify the underlying database.
 	 */
 	int (*iterate) (struct semanage_handle * handle,
-			dbase_t * dbase,
+			struct dbase_config * dconfig,
 			int (*fn) (const record_t * record,
 				   void *varg), void *fn_arg);
 
@@ -139,7 +161,7 @@ typedef struct dbase_table {
 	 * and must be freed accordingly. 
 	 */
 	int (*list) (struct semanage_handle * handle,
-		     dbase_t * dbase,
+		     struct dbase_config * dconfig,
 		     record_t *** records, unsigned int *count);
 
 	/* ---------- Cache/Transaction Management ---------- */
@@ -149,24 +171,28 @@ typedef struct dbase_table {
 	 * any of the database functions above. It may be invoked
 	 * multiple times, and will update the cache if a commit
 	 * occured between invocations */
-	int (*cache) (struct semanage_handle * handle, dbase_t * dbase);
+	int (*cache) (struct semanage_handle * handle,
+		      struct dbase_config * dconfig);
 
 	/* Forgets all changes that haven't been written
 	 * to the database backend */
+	/* FIXME: Why not a dconfig here? */
+	//void (*drop_cache) (struct dbase_config * dconfig);
 	void (*drop_cache) (dbase_t * dbase);
 
 	/* Checks if there are any changes not written to the backend */
-	int (*is_modified) (dbase_t * dbase);
+	int (*is_modified) (struct dbase_config * dconfig);
 
 	/* Writes the database changes to its backend */
-	int (*flush) (struct semanage_handle * handle, dbase_t * dbase);
+	int (*flush) (struct semanage_handle * handle,
+		      struct dbase_config * dconfig);
 
 	/* ------------- Polymorphism ----------------------- */
 
 	/* Retrieves the record table for this database,
 	 * which specifies how to perform basic operations
 	 * on each record. */
-	record_table_t *(*get_rtable) (dbase_t * dbase);
+	record_table_t *(*get_rtable) (struct dbase_config * dconfig);
 
 } dbase_table_t;
 
Index: selinux-pms-support/libsemanage/src/database_activedb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_activedb.c
+++ selinux-pms-support/libsemanage/src/database_activedb.c
@@ -30,10 +30,11 @@ struct dbase_activedb {
 };
 
 static int dbase_activedb_cache(semanage_handle_t * handle,
-				dbase_activedb_t * dbase)
+				dbase_config_t * dconfig)
 {
 
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	dbase_activedb_t *dbase = dconfig->dbase;
+	record_table_t *rtable = dbase_llist_get_rtable(dconfig);
 	record_activedb_table_t *ratable = dbase->ratable;
 
 	record_t **records = NULL;
@@ -74,10 +75,11 @@ static int dbase_activedb_cache(semanage
 }
 
 static int dbase_activedb_flush(semanage_handle_t * handle,
-				dbase_activedb_t * dbase)
+				dbase_config_t * dconfig)
 {
-
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	int status = STATUS_SUCCESS;
+	dbase_activedb_t *dbase = dconfig->dbase;
+	record_table_t *rtable = dbase_llist_get_rtable(dconfig);
 	record_activedb_table_t *ratable = dbase->ratable;
 
 	record_t **records = NULL;
@@ -89,7 +91,8 @@ static int dbase_activedb_flush(semanage
 		return STATUS_SUCCESS;
 
 	/* Fetch list */
-	if (dbase_llist_list(handle, &dbase->llist, &records, &rcount) < 0)
+	status = dbase_llist_list(handle, dconfig, &records, &rcount);
+	if (status != STATUS_SUCCESS)
 		goto err;
 
 	/* Commit */
@@ -123,7 +126,7 @@ int dbase_activedb_init(semanage_handle_
 		goto omem;
 
 	tmp_dbase->ratable = ratable;
-	dbase_llist_init(&tmp_dbase->llist, rtable, &SEMANAGE_ACTIVEDB_DTABLE);
+	dbase_llist_init(&tmp_dbase->llist, rtable);
 
 	*dbase = tmp_dbase;
 
Index: selinux-pms-support/libsemanage/src/database_file.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_file.c
+++ selinux-pms-support/libsemanage/src/database_file.c
@@ -58,10 +58,12 @@ static int construct_filename(semanage_h
 	return STATUS_SUCCESS;
 }
 
-static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
+static int dbase_file_cache(semanage_handle_t * handle,
+			    dbase_config_t * dconfig)
 {
 
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	dbase_file_t *dbase = dconfig->dbase;
+	record_table_t *rtable = dbase_llist_get_rtable(dconfig);
 	record_file_table_t *rftable = dbase->rftable;
 
 	record_t *process_record = NULL;
@@ -135,9 +137,11 @@ static int dbase_file_cache(semanage_han
 }
 
 /* Flush database to file */
-static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
+static int dbase_file_flush(semanage_handle_t * handle,
+			    dbase_config_t * dconfig)
 {
 
+	dbase_file_t *dbase = dconfig->dbase;
 	record_file_table_t *rftable = dbase->rftable;
 
 	cache_entry_t *ptr;
@@ -197,7 +201,7 @@ int dbase_file_init(semanage_handle_t * 
 
 	tmp_dbase->suffix = suffix;
 	tmp_dbase->rftable = rftable;
-	dbase_llist_init(&tmp_dbase->llist, rtable, &SEMANAGE_FILE_DTABLE);
+	dbase_llist_init(&tmp_dbase->llist, rtable);
 
 	*dbase = tmp_dbase;
 
Index: selinux-pms-support/libsemanage/src/database_join.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_join.c
+++ selinux-pms-support/libsemanage/src/database_join.c
@@ -34,15 +34,18 @@ struct dbase_join {
 	record_join_table_t *rjtable;
 };
 
-static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
+static int dbase_join_cache(semanage_handle_t * handle,
+			    dbase_config_t * dconfig)
 {
 
+	dbase_join_t *dbase = dconfig->dbase;
+
 	/* Extract all the object tables information */
-	dbase_t *dbase1 = dbase->join1->dbase;
-	dbase_t *dbase2 = dbase->join2->dbase;
+	dbase_config_t *dbase1 = dbase->join1;
+	dbase_config_t *dbase2 = dbase->join2;
 	dbase_table_t *dtable1 = dbase->join1->dtable;
 	dbase_table_t *dtable2 = dbase->join2->dtable;
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_table_t *rtable = dbase_llist_get_rtable(dconfig);
 	record_join_table_t *rjtable = dbase->rjtable;
 	record_table_t *rtable1 = dtable1->get_rtable(dbase1);
 	record_table_t *rtable2 = dtable2->get_rtable(dbase2);
@@ -166,15 +169,18 @@ static int dbase_join_cache(semanage_han
 }
 
 /* Flush database */
-static int dbase_join_flush(semanage_handle_t * handle, dbase_join_t * dbase)
+static int dbase_join_flush(semanage_handle_t * handle,
+			    dbase_config_t * dconfig)
 {
 
+	dbase_join_t *dbase = dconfig->dbase;
+
 	/* Extract all the object tables information */
-	dbase_t *dbase1 = dbase->join1->dbase;
-	dbase_t *dbase2 = dbase->join2->dbase;
+	dbase_config_t *dbase1 = dbase->join1;
+	dbase_config_t *dbase2 = dbase->join2;
 	dbase_table_t *dtable1 = dbase->join1->dtable;
 	dbase_table_t *dtable2 = dbase->join2->dtable;
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	record_table_t *rtable = dbase_llist_get_rtable(dconfig);
 	record_join_table_t *rjtable = dbase->rjtable;
 	record_table_t *rtable1 = dtable1->get_rtable(dbase1);
 	record_table_t *rtable2 = dtable2->get_rtable(dbase2);
@@ -247,7 +253,7 @@ int dbase_join_init(semanage_handle_t * 
 	if (!tmp_dbase)
 		goto omem;
 
-	dbase_llist_init(&tmp_dbase->llist, rtable, &SEMANAGE_JOIN_DTABLE);
+	dbase_llist_init(&tmp_dbase->llist, rtable);
 
 	tmp_dbase->rjtable = rjtable;
 	tmp_dbase->join1 = join1;
Index: selinux-pms-support/libsemanage/src/database_llist.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_llist.c
+++ selinux-pms-support/libsemanage/src/database_llist.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 /* Object: dbase_llist_t (Linked List)
  * Partially Implements: dbase_t (Database)
@@ -100,15 +120,17 @@ int dbase_llist_set_serial(semanage_hand
 
 /* Helper for finding records in the cache */
 static int dbase_llist_cache_locate(semanage_handle_t * handle,
-				    dbase_llist_t * dbase,
+				    dbase_config_t * dconfig,
 				    const record_key_t * key,
 				    cache_entry_t ** entry)
 {
-
+	int status = STATUS_SUCCESS;
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *ptr;
 
 	/* Implemented in parent */
-	if (dbase->dtable->cache(handle, dbase) < 0)
+	status = dconfig->dtable->cache(handle, dconfig);
+	if (status != STATUS_SUCCESS)
 		goto err;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -126,14 +148,14 @@ static int dbase_llist_cache_locate(sema
 }
 
 int dbase_llist_exists(semanage_handle_t * handle,
-		       dbase_llist_t * dbase,
+		       dbase_config_t * dconfig,
 		       const record_key_t * key, int *response)
 {
 
 	cache_entry_t *entry;
 	int status;
 
-	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	status = dbase_llist_cache_locate(handle, dconfig, key, &entry);
 	if (status < 0)
 		goto err;
 
@@ -146,10 +168,12 @@ int dbase_llist_exists(semanage_handle_t
 }
 
 int dbase_llist_add(semanage_handle_t * handle,
-		    dbase_llist_t * dbase,
+		    dbase_config_t * dconfig,
 		    const record_key_t * key, const record_t * data)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
+
 	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
 		goto err;
 
@@ -163,14 +187,15 @@ int dbase_llist_add(semanage_handle_t * 
 }
 
 int dbase_llist_set(semanage_handle_t * handle,
-		    dbase_llist_t * dbase,
+		    dbase_config_t * dconfig,
 		    const record_key_t * key, const record_t * data)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *entry;
 	int status;
 
-	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	status = dbase_llist_cache_locate(handle, dconfig, key, &entry);
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA) {
@@ -191,14 +216,15 @@ int dbase_llist_set(semanage_handle_t * 
 }
 
 int dbase_llist_modify(semanage_handle_t * handle,
-		       dbase_llist_t * dbase,
+		       dbase_config_t * dconfig,
 		       const record_key_t * key, const record_t * data)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *entry;
 	int status;
 
-	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	status = dbase_llist_cache_locate(handle, dconfig, key, &entry);
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA) {
@@ -219,23 +245,26 @@ int dbase_llist_modify(semanage_handle_t
 }
 
 hidden int dbase_llist_count(semanage_handle_t * handle,
-			     dbase_llist_t * dbase, unsigned int *response)
+			     dbase_config_t * dconfig, unsigned int *response)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
+
 	*response = dbase->cache_sz;
 	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
 int dbase_llist_query(semanage_handle_t * handle,
-		      dbase_llist_t * dbase,
+		      dbase_config_t * dconfig,
 		      const record_key_t * key, record_t ** response)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *entry;
 	int status;
 
-	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
+	status = dbase_llist_cache_locate(handle, dconfig, key, &entry);
 	if (status < 0 || status == STATUS_NODATA)
 		goto err;
 
@@ -250,11 +279,12 @@ int dbase_llist_query(semanage_handle_t 
 }
 
 int dbase_llist_iterate(semanage_handle_t * handle,
-			dbase_llist_t * dbase,
+			dbase_config_t * dconfig,
 			int (*fn) (const record_t * record,
 				   void *fn_arg), void *arg)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	int rc;
 	cache_entry_t *ptr;
 
@@ -276,9 +306,10 @@ int dbase_llist_iterate(semanage_handle_
 }
 
 int dbase_llist_del(semanage_handle_t * handle,
-		    dbase_llist_t * dbase, const record_key_t * key)
+		    dbase_config_t * dconfig, const record_key_t * key)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *ptr, *prev = NULL;
 
 	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
@@ -306,9 +337,11 @@ int dbase_llist_del(semanage_handle_t * 
 	return STATUS_SUCCESS;
 }
 
-int dbase_llist_clear(semanage_handle_t * handle, dbase_llist_t * dbase)
+int dbase_llist_clear(semanage_handle_t * handle, dbase_config_t * dconfig)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
+
 	int old_serial = dbase->cache_serial;
 
 	if (dbase_llist_set_serial(handle, dbase) < 0) {
@@ -334,10 +367,11 @@ int dbase_llist_clear(semanage_handle_t 
 }
 
 int dbase_llist_list(semanage_handle_t * handle,
-		     dbase_llist_t * dbase,
+		     dbase_config_t * dconfig,
 		     record_t *** records, unsigned int *count)
 {
 
+	dbase_llist_t *dbase = dconfig->dbase;
 	cache_entry_t *ptr;
 	record_t **tmp_records = NULL;
 	unsigned int tmp_count;
Index: selinux-pms-support/libsemanage/src/database_llist.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_llist.h
+++ selinux-pms-support/libsemanage/src/database_llist.h
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 #ifndef _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
 #define _SEMANAGE_DATABASE_LLIST_INTERNAL_H_
@@ -16,9 +36,8 @@ typedef struct cache_entry {
 /* LLIST dbase */
 typedef struct dbase_llist {
 
-	/* Method tables */
+	/* Method table */
 	record_table_t *rtable;
-	dbase_table_t *dtable;
 
 	/* In-memory representation (cache) */
 	cache_entry_t *cache;
@@ -42,12 +61,10 @@ static inline void dbase_llist_cache_ini
 }
 
 static inline void dbase_llist_init(dbase_llist_t * dbase,
-				    record_table_t * rtable,
-				    dbase_table_t * dtable)
+				    record_table_t * rtable)
 {
 
 	dbase->rtable = rtable;
-	dbase->dtable = dtable;
 	dbase_llist_cache_init(dbase);
 }
 
@@ -76,47 +93,49 @@ static inline int dbase_llist_is_modifie
 }
 
 /* LLIST - polymorphism */
-static inline record_table_t *dbase_llist_get_rtable(dbase_llist_t * dbase)
+static inline record_table_t *dbase_llist_get_rtable(dbase_config_t * dconfig)
 {
-	return dbase->rtable;
+
+	return ((dbase_llist_t *) dconfig->dbase)->rtable;
 }
 
 /* LLIST - dbase API */
 extern int dbase_llist_exists(semanage_handle_t * handle,
-			      dbase_llist_t * dbase,
+			      dbase_config_t * dconfig,
 			      const record_key_t * key, int *response);
 
 extern int dbase_llist_add(semanage_handle_t * handle,
-			   dbase_llist_t * dbase,
+			   dbase_config_t * dconfig,
 			   const record_key_t * key, const record_t * data);
 
 extern int dbase_llist_set(semanage_handle_t * handle,
-			   dbase_llist_t * dbase,
+			   dbase_config_t * dconfig,
 			   const record_key_t * key, const record_t * data);
 
 extern int dbase_llist_modify(semanage_handle_t * handle,
-			      dbase_llist_t * dbase,
+			      dbase_config_t * dconfig,
 			      const record_key_t * key, const record_t * data);
 
 extern int dbase_llist_count(semanage_handle_t * handle,
-			     dbase_llist_t * dbase, unsigned int *response);
+			     dbase_config_t * dconfig, unsigned int *response);
 
 extern int dbase_llist_query(semanage_handle_t * handle,
-			     dbase_llist_t * dbase,
+			     dbase_config_t * dconfig,
 			     const record_key_t * key, record_t ** response);
 
 extern int dbase_llist_iterate(semanage_handle_t * handle,
-			       dbase_llist_t * dbase,
+			       dbase_config_t * dconfig,
 			       int (*fn) (const record_t * record,
 					  void *fn_arg), void *arg);
 
 extern int dbase_llist_del(semanage_handle_t * handle,
-			   dbase_llist_t * dbase, const record_key_t * key);
+			   dbase_config_t * dconfig, const record_key_t * key);
 
-extern int dbase_llist_clear(semanage_handle_t * handle, dbase_llist_t * dbase);
+extern int dbase_llist_clear(semanage_handle_t * handle,
+			     dbase_config_t * dconfig);
 
 extern int dbase_llist_list(semanage_handle_t * handle,
-			    dbase_llist_t * dbase,
+			    dbase_config_t * dconfig,
 			    record_t *** records, unsigned int *count);
 
 #endif
Index: selinux-pms-support/libsemanage/src/database_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_policydb.c
+++ selinux-pms-support/libsemanage/src/database_policydb.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 /* Object: dbase_policydb_t (Policy)
  * Implements: dbase_t (Database)
@@ -41,7 +61,7 @@ struct dbase_policydb {
 	int attached;
 };
 
-static void dbase_policydb_drop_cache(dbase_policydb_t * dbase)
+void dbase_policydb_drop_cache(dbase_t * dbase)
 {
 
 	if (dbase->cache_serial >= 0) {
@@ -51,8 +71,8 @@ static void dbase_policydb_drop_cache(db
 	}
 }
 
-static int dbase_policydb_set_serial(semanage_handle_t * handle,
-				     dbase_policydb_t * dbase)
+int dbase_policydb_set_serial(semanage_handle_t * handle,
+			      dbase_policydb_t * dbase)
 {
 
 	int cache_serial = handle->funcs->get_serial(handle);
@@ -65,10 +85,12 @@ static int dbase_policydb_set_serial(sem
 	return STATUS_SUCCESS;
 }
 
-static int dbase_policydb_needs_resync(semanage_handle_t * handle,
-				       dbase_policydb_t * dbase)
+int dbase_policydb_needs_resync(semanage_handle_t * handle,
+				dbase_config_t * dconfig)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	int cache_serial;
 
 	if (dbase->cache_serial < 0)
@@ -79,7 +101,7 @@ static int dbase_policydb_needs_resync(s
 		return 1;
 
 	if (cache_serial != dbase->cache_serial) {
-		dbase_policydb_drop_cache(dbase);
+		dbase_policydb_drop_cache(dconfig->dbase);
 		dbase->cache_serial = -1;
 		return 1;
 	}
@@ -106,10 +128,11 @@ static int construct_filename(semanage_h
 	return STATUS_SUCCESS;
 }
 
-static int dbase_policydb_cache(semanage_handle_t * handle,
-				dbase_policydb_t * dbase)
+int dbase_policydb_cache(semanage_handle_t * handle, dbase_config_t * dconfig)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	FILE *fp = NULL;
 	sepol_policydb_t *policydb = NULL;
 	sepol_policy_file_t *pf = NULL;
@@ -119,7 +142,7 @@ static int dbase_policydb_cache(semanage
 	if (dbase->attached)
 		return STATUS_SUCCESS;
 
-	if (!dbase_policydb_needs_resync(handle, dbase))
+	if (!dbase_policydb_needs_resync(handle, dconfig))
 		return STATUS_SUCCESS;
 
 	if (construct_filename(handle, dbase, &fname) < 0)
@@ -177,10 +200,11 @@ static int dbase_policydb_cache(semanage
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_flush(semanage_handle_t * handle,
-				dbase_policydb_t * dbase)
+int dbase_policydb_flush(semanage_handle_t * handle, dbase_config_t * dconfig)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (!dbase->modified)
 		return STATUS_SUCCESS;
 
@@ -192,10 +216,10 @@ static int dbase_policydb_flush(semanage
 }
 
 /* Check if modified */
-static int dbase_policydb_is_modified(dbase_policydb_t * dbase)
+int dbase_policydb_is_modified(dbase_config_t * dconfig)
 {
 
-	return dbase->modified;
+	return ((dbase_policydb_t *) dconfig->dbase)->modified;
 }
 
 int dbase_policydb_init(semanage_handle_t * handle,
@@ -230,21 +254,22 @@ int dbase_policydb_init(semanage_handle_
 }
 
 /* Release dbase resources */
-void dbase_policydb_release(dbase_policydb_t * dbase)
+void dbase_policydb_release(dbase_config_t * dconfig)
 {
-
-	dbase_policydb_drop_cache(dbase);
-	free(dbase);
+	dbase_policydb_drop_cache(dconfig->dbase);
+	free(dconfig->dbase);
 }
 
 /* Attach to a shared policydb.
  * This implies drop_cache(),
  * and prevents flush() and drop_cache()
  * until detached. */
-void dbase_policydb_attach(dbase_policydb_t * dbase,
+void dbase_policydb_attach(dbase_config_t * dconfig,
 			   sepol_policydb_t * policydb)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	dbase->attached = 1;
 	dbase_policydb_drop_cache(dbase);
 	dbase->policydb = policydb;
@@ -259,11 +284,13 @@ void dbase_policydb_detach(dbase_policyd
 	dbase->modified = 0;
 }
 
-static int dbase_policydb_add(semanage_handle_t * handle,
-			      dbase_policydb_t * dbase,
-			      const record_key_t * key, const record_t * data)
+int dbase_policydb_add(semanage_handle_t * handle,
+		       dbase_config_t * dconfig,
+		       const record_key_t * key, const record_t * data)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->add(handle->sepolh, dbase->policydb, key, data) < 0)
 		goto err;
 
@@ -275,11 +302,13 @@ static int dbase_policydb_add(semanage_h
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_set(semanage_handle_t * handle,
-			      dbase_policydb_t * dbase,
-			      const record_key_t * key, const record_t * data)
+int dbase_policydb_set(semanage_handle_t * handle,
+		       dbase_config_t * dconfig,
+		       const record_key_t * key, const record_t * data)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->set(handle->sepolh, dbase->policydb, key, data) < 0)
 		goto err;
 
@@ -291,12 +320,13 @@ static int dbase_policydb_set(semanage_h
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_modify(semanage_handle_t * handle,
-				 dbase_policydb_t * dbase,
-				 const record_key_t * key,
-				 const record_t * data)
+int dbase_policydb_modify(semanage_handle_t * handle,
+			  dbase_config_t * dconfig,
+			  const record_key_t * key, const record_t * data)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->modify(handle->sepolh,
 				   dbase->policydb, key, data) < 0)
 		goto err;
@@ -309,33 +339,33 @@ static int dbase_policydb_modify(semanag
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_del(semanage_handle_t * handle,
-			      dbase_policydb_t * dbase,
-			      const record_key_t * key)
+int dbase_policydb_del(semanage_handle_t * handle,
+		       dbase_config_t * dconfig, const record_key_t * key)
 {
 
 	/* Stub */
 	key = NULL;
 	handle = NULL;
-	dbase = NULL;
+	dconfig = NULL;
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_clear(semanage_handle_t * handle,
-				dbase_policydb_t * dbase)
+int dbase_policydb_clear(semanage_handle_t * handle, dbase_config_t * dconfig)
 {
 
 	/* Stub */
 	handle = NULL;
-	dbase = NULL;
+	dconfig = NULL;
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_query(semanage_handle_t * handle,
-				dbase_policydb_t * dbase,
-				const record_key_t * key, record_t ** response)
+int dbase_policydb_query(semanage_handle_t * handle,
+			 dbase_config_t * dconfig,
+			 const record_key_t * key, record_t ** response)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->query(handle->sepolh,
 				  dbase->policydb, key, response) < 0)
 		goto err;
@@ -347,11 +377,13 @@ static int dbase_policydb_query(semanage
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_exists(semanage_handle_t * handle,
-				 dbase_policydb_t * dbase,
-				 const record_key_t * key, int *response)
+int dbase_policydb_exists(semanage_handle_t * handle,
+			  dbase_config_t * dconfig,
+			  const record_key_t * key, int *response)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->exists(handle->sepolh,
 				   dbase->policydb, key, response) < 0)
 		goto err;
@@ -363,11 +395,12 @@ static int dbase_policydb_exists(semanag
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_count(semanage_handle_t * handle,
-				dbase_policydb_t * dbase,
-				unsigned int *response)
+int dbase_policydb_count(semanage_handle_t * handle,
+			 dbase_config_t * dconfig, unsigned int *response)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->count(handle->sepolh,
 				  dbase->policydb, response) < 0)
 		goto err;
@@ -379,12 +412,14 @@ static int dbase_policydb_count(semanage
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_iterate(semanage_handle_t * handle,
-				  dbase_policydb_t * dbase,
-				  int (*fn) (const record_t * record,
-					     void *fn_arg), void *arg)
+int dbase_policydb_iterate(semanage_handle_t * handle,
+			   dbase_config_t * dconfig,
+			   int (*fn) (const record_t * record,
+				      void *fn_arg), void *arg)
 {
 
+	dbase_policydb_t *dbase = dconfig->dbase;
+
 	if (dbase->rptable->iterate(handle->sepolh,
 				    dbase->policydb, fn, arg) < 0)
 		goto err;
@@ -415,11 +450,13 @@ static int list_handler(const record_t *
 	return 0;
 }
 
-static int dbase_policydb_list(semanage_handle_t * handle,
-			       dbase_t * dbase,
-			       record_t *** records, unsigned int *count)
+int dbase_policydb_list(semanage_handle_t * handle,
+			dbase_config_t * dconfig,
+			record_t *** records, unsigned int *count)
 {
 
+	dbase_t *dbase = dconfig->dbase;
+
 	record_t **tmp_records = NULL;
 	unsigned int tmp_count;
 	struct list_handler_arg list_arg;
@@ -463,10 +500,10 @@ static int dbase_policydb_list(semanage_
 	return STATUS_ERR;
 }
 
-static record_table_t *dbase_policydb_get_rtable(dbase_policydb_t * dbase)
+record_table_t *dbase_policydb_get_rtable(dbase_config_t * dconfig)
 {
 
-	return dbase->rtable;
+	return ((dbase_policydb_t *) dconfig->dbase)->rtable;
 }
 
 /* POLICYDB dbase - method table implementation */
Index: selinux-pms-support/libsemanage/src/database_policydb.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_policydb.h
+++ selinux-pms-support/libsemanage/src/database_policydb.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2005 Red Hat, Inc.
  * Copyright (C) 2006 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
@@ -16,8 +17,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-/* Copyright (C) 2005 Red Hat, Inc. */
-
 #ifndef _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 
@@ -95,7 +94,7 @@ extern int dbase_policydb_init(semanage_
  * This implies drop_cache().
  * and prevents flush() and drop_cache()
  * until detached. */
-extern void dbase_policydb_attach(dbase_policydb_t * dbase,
+extern void dbase_policydb_attach(dbase_config_t * dconfig,
 				  sepol_policydb_t * policydb);
 
 /* Detach from a shared policdb.
@@ -103,7 +102,61 @@ extern void dbase_policydb_attach(dbase_
 extern void dbase_policydb_detach(dbase_policydb_t * dbase);
 
 /* Release allocated resources */
-extern void dbase_policydb_release(dbase_policydb_t * dbase);
+extern void dbase_policydb_release(dbase_config_t * dconfig);
+
+/* POLICYDB database methods */
+int dbase_policydb_cache(semanage_handle_t * handle, dbase_config_t * dconfig);
+
+void dbase_policydb_drop_cache(dbase_t * dbase);
+
+int dbase_policydb_flush(semanage_handle_t * handle, dbase_config_t * dconfig);
+
+int dbase_policydb_is_modified(dbase_config_t * dconfig);
+
+int dbase_policydb_iterate(semanage_handle_t * handle,
+			   dbase_config_t * dconfig,
+			   int (*fn) (const record_t * record, void *fn_arg),
+			   void *arg);
+
+int dbase_policydb_exists(semanage_handle_t * handle,
+			  dbase_config_t * dconfig,
+			  const record_key_t * key, int *response);
+
+int dbase_policydb_list(semanage_handle_t * handle,
+			dbase_config_t * dconfig,
+			record_t *** records, unsigned int *count);
+
+int dbase_policydb_add(semanage_handle_t * handle,
+		       dbase_config_t * dconfig,
+		       const record_key_t * key, const record_t * data);
+
+int dbase_policydb_set(semanage_handle_t * handle,
+		       dbase_config_t * dconfig,
+		       const record_key_t * key, const record_t * data);
+
+int dbase_policydb_del(semanage_handle_t * handle,
+		       dbase_config_t * dconfig, const record_key_t * key);
+
+int dbase_policydb_clear(semanage_handle_t * handle, dbase_config_t * dconfig);
+
+int dbase_policydb_modify(semanage_handle_t * handle,
+			  dbase_config_t * dconfig,
+			  const record_key_t * key, const record_t * data);
+
+int dbase_policydb_query(semanage_handle_t * handle,
+			 dbase_config_t * dconfig,
+			 const record_key_t * key, record_t ** response);
+
+int dbase_policydb_count(semanage_handle_t * handle,
+			 dbase_config_t * dconfig, unsigned int *response);
+
+int dbase_policydb_set_serial(semanage_handle_t * handle,
+			      dbase_policydb_t * dbase);
+
+int dbase_policydb_needs_resync(semanage_handle_t * handle,
+				dbase_config_t * dconfig);
+
+record_table_t *dbase_policydb_get_rtable(dbase_config_t * dconfig);
 
 /* POLICYDB database - method table implementation */
 extern dbase_table_t SEMANAGE_POLICYDB_DTABLE;
Index: selinux-pms-support/libsemanage/src/direct_api.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/direct_api.c
+++ selinux-pms-support/libsemanage/src/direct_api.c
@@ -467,25 +467,25 @@ static int semanage_direct_commit(semana
 
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
-	if (users->dtable->is_modified(users->dbase)) {
-		retval = users->dtable->flush(sh, users->dbase);
+	if (users->dtable->is_modified(users)) {
+		retval = users->dtable->flush(sh, users);
 		if (retval < 0)
 			goto cleanup;
 	}
 
 	/* Decide if anything was modified */
-	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
-	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
+	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts);
+	seusers_modified = seusers->dtable->is_modified(seusers);
 	users_extra_modified =
-	    users_extra->dtable->is_modified(users_extra->dbase);
-	ports_modified = ports->dtable->is_modified(ports->dbase);
+	    users_extra->dtable->is_modified(users_extra);
+	ports_modified = ports->dtable->is_modified(ports);
 
 	modified = sh->modules_modified;
 	modified |= ports_modified;
-	modified |= users->dtable->is_modified(users_base->dbase);
-	modified |= bools->dtable->is_modified(bools->dbase);
-	modified |= ifaces->dtable->is_modified(ifaces->dbase);
-	modified |= nodes->dtable->is_modified(nodes->dbase);
+	modified |= users->dtable->is_modified(users_base);
+	modified |= bools->dtable->is_modified(bools);
+	modified |= ifaces->dtable->is_modified(ifaces);
+	modified |= nodes->dtable->is_modified(nodes);
 
 	/* FIXME: get rid of these, once we support loading the existing policy,
 	 * instead of rebuilding it */
@@ -588,7 +588,7 @@ static int semanage_direct_commit(semana
 			pseusers->dtable->drop_cache(pseusers->dbase);
 
 		} else {
-			retval = pseusers->dtable->clear(sh, pseusers->dbase);
+			retval = pseusers->dtable->clear(sh, pseusers);
 			if (retval < 0)
 				goto cleanup;
 		}
@@ -608,7 +608,7 @@ static int semanage_direct_commit(semana
 			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
 
 		} else {
-			retval = pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+			retval = pusers_extra->dtable->clear(sh, pusers_extra);
 			if (retval < 0)
 				goto cleanup;
 		}
@@ -641,12 +641,11 @@ static int semanage_direct_commit(semana
 		if (retval < 0)
 			goto cleanup;
 
-		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
-				      out);
-		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
-		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
+		dbase_policydb_attach(pusers_base, out);
+		dbase_policydb_attach(pports, out);
+		dbase_policydb_attach(pifaces, out);
+		dbase_policydb_attach(pbools, out);
+		dbase_policydb_attach(pnodes, out);
 
 		/* ============= Apply changes, and verify  =============== */
 
Index: selinux-pms-support/libsemanage/src/interfaces_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/interfaces_policydb.c
+++ selinux-pms-support/libsemanage/src/interfaces_policydb.c
@@ -63,5 +63,5 @@ int iface_policydb_dbase_init(semanage_h
 void iface_policydb_dbase_release(dbase_config_t * dconfig)
 {
 
-	dbase_policydb_release(dconfig->dbase);
+	dbase_policydb_release(dconfig);
 }
Index: selinux-pms-support/libsemanage/src/nodes_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/nodes_policydb.c
+++ selinux-pms-support/libsemanage/src/nodes_policydb.c
@@ -63,5 +63,5 @@ int node_policydb_dbase_init(semanage_ha
 void node_policydb_dbase_release(dbase_config_t * dconfig)
 {
 
-	dbase_policydb_release(dconfig->dbase);
+	dbase_policydb_release(dconfig);
 }
Index: selinux-pms-support/libsemanage/src/policy_components.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/policy_components.c
+++ selinux-pms-support/libsemanage/src/policy_components.c
@@ -17,25 +17,28 @@ static int clear_obsolete(semanage_handl
 			  unsigned int nrecords,
 			  dbase_config_t * src, dbase_config_t * dst)
 {
-
+	int status = STATUS_SUCCESS;
 	record_key_t *key = NULL;
 	unsigned int i;
 
 	dbase_table_t *src_dtable = src->dtable;
 	dbase_table_t *dst_dtable = dst->dtable;
-	record_table_t *rtable = src_dtable->get_rtable(src->dbase);
+	record_table_t *rtable = src_dtable->get_rtable(src);
 
 	for (i = 0; i < nrecords; i++) {
 		int exists;
 
-		if (rtable->key_extract(handle, records[i], &key) < 0)
+		status = rtable->key_extract(handle, records[i], &key);
+		if (status != STATUS_SUCCESS)
 			goto err;
 
-		if (dst_dtable->exists(handle, dst->dbase, key, &exists) < 0)
+		status = dst_dtable->exists(handle, dst, key, &exists);
+		if (status != STATUS_SUCCESS)
 			goto err;
 
 		if (!exists) {
-			if (src_dtable->del(handle, src->dbase, key) < 0)
+			status = src_dtable->del(handle, src, key);
+			if (status != STATUS_SUCCESS)
 				goto err;
 
 			rtable->free(records[i]);
@@ -64,9 +67,8 @@ static int load_records(semanage_handle_
 	unsigned int i;
 	record_key_t *rkey = NULL;
 
-	dbase_t *dbase = dst->dbase;
 	dbase_table_t *dtable = dst->dtable;
-	record_table_t *rtable = dtable->get_rtable(dbase);
+	record_table_t *rtable = dtable->get_rtable(dst);
 
 	for (i = 0; i < nrecords; i++) {
 
@@ -78,11 +80,11 @@ static int load_records(semanage_handle_
 			goto err;
 
 		if (mode & MODE_SET &&
-		    dtable->set(handle, dbase, rkey, records[i]) < 0)
+		    dtable->set(handle, dst, rkey, records[i]) < 0)
 			goto err;
 
 		else if (mode & MODE_MODIFY &&
-			 dtable->modify(handle, dbase, rkey, records[i]) < 0)
+			 dtable->modify(handle, dst, rkey, records[i]) < 0)
 			goto err;
 
 		rtable->key_free(rkey);
@@ -149,17 +151,16 @@ int semanage_base_merge_components(seman
 		dbase_config_t *src = components[i].src;
 		dbase_config_t *dst = components[i].dst;
 		int mode = components[i].mode;
-		record_table_t *rtable = src->dtable->get_rtable(src->dbase);
+		record_table_t *rtable = src->dtable->get_rtable(src);
 
 		/* Must invoke cache function first */
-		if (src->dtable->cache(handle, src->dbase) < 0)
+		if (src->dtable->cache(handle, src) < 0)
 			goto err;
-		if (dst->dtable->cache(handle, dst->dbase) < 0)
+		if (dst->dtable->cache(handle, dst) < 0)
 			goto err;
 
 		/* List all records */
-		if (src->dtable->list(handle, src->dbase,
-				      &records, &nrecords) < 0)
+		if (src->dtable->list(handle, src, &records, &nrecords) < 0)
 			goto err;
 
 		/* Sort records on MODE_SORT */
@@ -223,8 +224,7 @@ int semanage_commit_components(semanage_
 
 	for (i = 0; i < CCOUNT; i++) {
 		/* Flush to disk */
-		if (components[i]->dtable->flush(handle, components[i]->dbase) <
-		    0)
+		if (components[i]->dtable->flush(handle, components[i]) < 0)
 			goto err;
 	}
 
Index: selinux-pms-support/libsemanage/src/ports_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/ports_policydb.c
+++ selinux-pms-support/libsemanage/src/ports_policydb.c
@@ -63,5 +63,5 @@ int port_policydb_dbase_init(semanage_ha
 void port_policydb_dbase_release(dbase_config_t * dconfig)
 {
 
-	dbase_policydb_release(dconfig->dbase);
+	dbase_policydb_release(dconfig);
 }
Index: selinux-pms-support/libsemanage/src/users_base_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/users_base_policydb.c
+++ selinux-pms-support/libsemanage/src/users_base_policydb.c
@@ -62,5 +62,5 @@ int user_base_policydb_dbase_init(semana
 void user_base_policydb_dbase_release(dbase_config_t * dconfig)
 {
 
-	dbase_policydb_release(dconfig->dbase);
+	dbase_policydb_release(dconfig);
 }

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
