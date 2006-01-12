Message-ID: <43C63675.2080207@cornell.edu>
Date: Thu, 12 Jan 2006 03:59:01 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Join: Prerequsites
Content-Type: multipart/mixed;
 boundary="------------020705000603030706080403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020705000603030706080403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the first of a series of patches that implement a join 
operation, and use it to support merging of file-backed user data (i.e. 
the label prefix) with policy-backed user data. Keep in mind that the 
join is rather complex, and it is not too clear whether this is 
justified, given that it's only used to solve the problem of prefixes. 
However, I am hoping that the join can become useful for other 
operations in the future, which would warrant its inclusion (plus it 
solves the problem of prefixes quite nicely, making the user_extra 
record completely transparent to the client, instead of adding things to 
the API that shouldn't be there).

Patch adds some join prerequisites:

First, this patch implements a del_all function, which clears all 
records from a database. This is not the same thing as the drop_cache 
function, which is used to discard the cache. This one indicates an 
explicit request to delete all records from the cache (and the database 
remains marked cached and modified, so upon flush all records will be 
deleted). This function is used to clear all records before writing the 
join back to its component dbase-s.

Second, the patch implements a compare2_qsort function for each semanage 
record (but keeps it internal). I added the compare2 function primarily 
in order to use it in qsort, but unfortnately qsort wants one that takes 
pointers... hence this function. Removing the compare2 fn, or changing 
it seems wrong from the client's point of view, so I'll keep that around 
and use compare2_qsort internally.


--------------020705000603030706080403
Content-Type: text/x-patch;
 name="libsemanage.join_prereq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.join_prereq.diff"

diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/boolean_record.c	2006-01-12 02:16:18.000000000 -0700
@@ -59,6 +59,13 @@ int semanage_bool_compare2(
 	return sepol_bool_compare2(boolean, boolean2);
 }
 hidden_def(semanage_bool_compare2)
+
+int semanage_bool_compare2_qsort(
+	const semanage_bool_t** boolean,
+	const semanage_bool_t** boolean2) {
+
+	return sepol_bool_compare2(*boolean, *boolean2);
+}
 	
 /* Name */
 const char* semanage_bool_get_name(
@@ -126,5 +133,6 @@ record_table_t SEMANAGE_BOOL_RTABLE = {
 	.clone       = semanage_bool_clone,
 	.compare     = semanage_bool_compare,
 	.compare2    = semanage_bool_compare2,
+	.compare2_qsort = semanage_bool_compare2_qsort,
 	.free        = semanage_bool_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/database_file.c	2006-01-12 01:09:38.000000000 -0700
@@ -228,6 +228,7 @@ dbase_table_t SEMANAGE_FILE_DTABLE = {
 	.add = (void*) dbase_llist_add,
 	.set = (void*) dbase_llist_set,
 	.del = (void*) dbase_llist_del, 
+	.del_all = (void*) dbase_llist_del_all,
 	.modify = (void*) dbase_llist_modify, 
 	.query = (void*) dbase_llist_query, 
 	.count = (void*) dbase_llist_count, 
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/database.h	2006-01-12 03:05:57.000000000 -0700
@@ -49,6 +49,13 @@ typedef struct record_table {
 		const record_t* rec,
 		const record_t* rec2);
 
+	/* Same as above, but dereferences the pointer first.
+	 * This function is intenteded to be used as a qsort
+	 * comparator. */
+	int (*compare2_qsort) (
+		const record_t** rec,
+		const record_t** rec2);
+
 	/* Deep-copy clone of this record */
 	int (*clone) (
 		struct semanage_handle* handle,
@@ -103,6 +110,11 @@ typedef struct dbase_table {
 		dbase_t* dbase,
 		const record_key_t* key);
 
+	/* Delete all records */
+	int (*del_all) (
+		struct semanage_handle* handle,
+		dbase_t* dbase);
+
 	/* Retrieve a record 
 	 * 
 	 * Note: the resultant record
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/database_llist.c	2006-01-12 03:10:35.000000000 -0700
@@ -288,6 +288,26 @@ int dbase_llist_del(
 	return STATUS_SUCCESS;
 }
 
+int dbase_llist_del_all(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase) {
+
+	cache_entry_t *prev, *ptr = dbase->cache;
+	while (ptr != NULL) {
+		prev = ptr;
+		ptr = ptr->next;
+		dbase->rtable->free(prev->data);
+		free(prev);
+        }
+
+	dbase->cache = NULL;
+	dbase->cache_tail = NULL;
+	dbase->cache_sz = 0;
+        dbase->modified = 1;
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
 int dbase_llist_list(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/database_llist.h new/libsemanage/src/database_llist.h
--- old/libsemanage/src/database_llist.h	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/database_llist.h	2006-01-11 23:10:57.000000000 -0700
@@ -138,6 +138,10 @@ extern int dbase_llist_del(
 	dbase_llist_t* dbase,
 	const record_key_t* key);
 
+extern int dbase_llist_del_all(
+	semanage_handle_t* handle,
+	dbase_llist_t* dbase);
+
 extern int dbase_llist_list(
 	semanage_handle_t* handle,
 	dbase_llist_t* dbase,
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/database_policydb.c	2006-01-11 20:20:56.000000000 -0700
@@ -284,6 +284,16 @@ static int dbase_policydb_del (
 	return STATUS_ERR;
 }
 
+static int dbase_policydb_del_all (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	return STATUS_ERR;
+}
+
 static int dbase_policydb_query (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
@@ -443,6 +453,7 @@ dbase_table_t SEMANAGE_POLICYDB_DTABLE =
 	.add = dbase_policydb_add,
 	.set = dbase_policydb_set,
 	.del = dbase_policydb_del,
+	.del_all = dbase_policydb_del_all,
 	.modify = dbase_policydb_modify, 
 	.query = dbase_policydb_query,
 	.count = dbase_policydb_count,
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/fcontext_record.c	2006-01-12 02:34:23.000000000 -0700
@@ -115,6 +115,13 @@ int semanage_fcontext_compare2(
 }
 hidden_def(semanage_fcontext_compare2)
 
+static int semanage_fcontext_compare2_qsort(
+	const semanage_fcontext_t** fcontext,
+	const semanage_fcontext_t** fcontext2) {
+
+	return semanage_fcontext_compare2(*fcontext, *fcontext2);
+}
+
 /* Create */
 int semanage_fcontext_create(
 	semanage_handle_t* handle,
@@ -271,5 +278,6 @@ record_table_t SEMANAGE_FCONTEXT_RTABLE 
 	.clone       = semanage_fcontext_clone,
 	.compare     = semanage_fcontext_compare,
 	.compare2    = semanage_fcontext_compare2,
+	.compare2_qsort = semanage_fcontext_compare2_qsort,
 	.free        = semanage_fcontext_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/iface_record.c	2006-01-12 02:33:43.000000000 -0700
@@ -40,6 +40,13 @@ int semanage_iface_compare2(
 }
 hidden_def(semanage_iface_compare2)
 
+static int semanage_iface_compare2_qsort(
+	const semanage_iface_t** iface,
+	const semanage_iface_t** iface2) {
+
+	return sepol_iface_compare2(*iface, *iface2);
+}
+
 int semanage_iface_key_create(
 	semanage_handle_t* handle,
 	const char* name,
@@ -145,5 +152,6 @@ record_table_t SEMANAGE_IFACE_RTABLE = {
 	.clone       = semanage_iface_clone,
 	.compare     = semanage_iface_compare,
 	.compare2    = semanage_iface_compare2,
+	.compare2_qsort = semanage_iface_compare2_qsort,
 	.free        = semanage_iface_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-12 03:47:19.000000000 -0700
+++ new/libsemanage/src/port_record.c	2006-01-12 02:34:02.000000000 -0700
@@ -40,6 +40,13 @@ int semanage_port_compare2(
 }
 hidden_def(semanage_port_compare2)
 
+static int semanage_port_compare2_qsort(
+	const semanage_port_t** port,
+	const semanage_port_t** port2) {
+
+	return sepol_port_compare2(*port, *port2);
+}
+
 int semanage_port_key_create(
 	semanage_handle_t* handle,
 	int low, int high, int proto, 
@@ -167,5 +174,6 @@ record_table_t SEMANAGE_PORT_RTABLE = {
 	.clone       = semanage_port_clone,
 	.compare     = semanage_port_compare,
 	.compare2    = semanage_port_compare2,
+	.compare2_qsort = semanage_port_compare2_qsort,
 	.free        = semanage_port_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2006-01-12 03:47:20.000000000 -0700
+++ new/libsemanage/src/seuser_record.c	2006-01-12 02:34:11.000000000 -0700
@@ -95,6 +95,13 @@ int semanage_seuser_compare2(
 }
 hidden_def(semanage_seuser_compare2)
 
+static int semanage_seuser_compare2_qsort(
+	const semanage_seuser_t** seuser,
+	const semanage_seuser_t** seuser2) {
+
+	return strcmp((*seuser)->name, (*seuser2)->name);
+}
+
 /* Name */
 const char* semanage_seuser_get_name(
 	const semanage_seuser_t* seuser) {
@@ -242,5 +249,6 @@ record_table_t SEMANAGE_SEUSER_RTABLE = 
 	.clone       = semanage_seuser_clone,
 	.compare     = semanage_seuser_compare,
 	.compare2    = semanage_seuser_compare2,
+	.compare2_qsort = semanage_seuser_compare2_qsort,
 	.free        = semanage_seuser_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/user_extra_record.c new/libsemanage/src/user_extra_record.c
--- old/libsemanage/src/user_extra_record.c	2006-01-12 03:47:20.000000000 -0700
+++ new/libsemanage/src/user_extra_record.c	2006-01-12 03:26:02.000000000 -0700
@@ -1,7 +1,7 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-/* Object: semanage_user_extra_t (Unix User)
- * Object: semanage_user_extra_key_t (Unix User Key)
+/* Object: semanage_user_extra_t (SELinux User/Class Extra Data)
+ * Object: semanage_user_extra_key_t (SELinux User/Class Key)
  * Implements: record_t (Database Record)
  * Implements: record_key_t (Database Record Key)
  */
@@ -58,6 +58,13 @@ static int semanage_user_extra_compare2(
 	return strcmp(user_extra->name, user_extra2->name);
 }
 
+static int semanage_user_extra_compare2_qsort(
+	const semanage_user_extra_t** user_extra,
+	const semanage_user_extra_t** user_extra2) {
+
+	return strcmp((*user_extra)->name, (*user_extra2)->name);
+}
+
 /* Name */
 hidden const char* semanage_user_extra_get_name(
 	const semanage_user_extra_t* user_extra) {
@@ -172,5 +179,6 @@ record_table_t SEMANAGE_USER_EXTRA_RTABL
 	.clone       = semanage_user_extra_clone,
 	.compare     = semanage_user_extra_compare,
 	.compare2    = semanage_user_extra_compare2,
+	.compare2_qsort = semanage_user_extra_compare2_qsort,
 	.free        = semanage_user_extra_free,
 };
diff -Naurp --exclude pywrap-test.py --exclude user_record.h --exclude user_internal.h --exclude policy_components.c --exclude direct_api.c --exclude semanage_store.c --exclude user_base_record.c --exclude handle.h --exclude ports_local.c --exclude 'users_*' --exclude 'database_join*' --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-12 03:47:20.000000000 -0700
+++ new/libsemanage/src/user_record.c	2006-01-12 03:46:30.000000000 -0700
@@ -17,6 +17,7 @@ typedef semanage_user_key_t record_key_t
 #define DBASE_RECORD_DEFINED
 
 #include <stdlib.h>
+#include <string.h>
 #include "user_internal.h"
 #include "handle.h"
 #include "database.h"
@@ -70,6 +71,13 @@ int semanage_user_compare2(
 	return sepol_user_compare2(user, user2);
 }
 hidden_def(semanage_user_compare2)
+
+static int semanage_user_compare2_qsort(
+	const semanage_user_t** user,
+	const semanage_user_t** user2) {
+
+	return sepol_user_compare2(*user, *user2);
+}
 	
 /* Name */
 const char* semanage_user_get_name(
@@ -203,5 +211,6 @@ record_table_t SEMANAGE_USER_RTABLE = {
 	.clone       = semanage_user_clone,
 	.compare     = semanage_user_compare,
 	.compare2    = semanage_user_compare2,
+	.compare2_qsort = semanage_user_compare2_qsort,
 	.free        = semanage_user_free,
 };

--------------020705000603030706080403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
