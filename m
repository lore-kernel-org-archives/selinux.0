Message-ID: <43BBD6C0.6020108@cornell.edu>
Date: Wed, 04 Jan 2006 09:08:00 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
Content-Type: multipart/mixed;
 boundary="------------090105080300080501070809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090105080300080501070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Steven pointed out (off-list) that libsemanage vs libsepol behavior 
is inconsistent with respect to set/add/modify.
In libsemanage, the object being added becomes "managed" by the library, 
while this is not true in libsepol. We decided it was better to have the 
client control the object passed in, and be responsible for freeing it.

This patch makes the appropriate changes (which include reversal of some 
of the code from the other patches) to implement that.
It also includes a bugfix for the error path of 
database_policydb.c:list, pointed out by Russel Coker.


--------------090105080300080501070809
Content-Type: text/x-patch;
 name="libsemanage17.setsebool3.caller_free_on_set.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage17.setsebool3.caller_free_on_set.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	2005-12-23 04:50:26.000000000 -0500
+++ new/libsemanage/src/database_activedb.c	2006-01-04 08:34:16.000000000 -0500
@@ -54,7 +54,7 @@ static int dbase_activedb_cache(
 	for (i = 0; i < rcount; i++) { 
 		if (dbase_llist_cache_prepend(handle, &dbase->llist, records[i]) < 0)
 			goto err;
-		records[i] = NULL;
+		rtable->free(records[i]);
 	}
 
 	free(records);
diff -Naurp --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-12-23 01:01:49.000000000 -0500
+++ new/libsemanage/src/database_file.c	2006-01-04 08:16:06.000000000 -0500
@@ -107,6 +107,7 @@ static int dbase_file_cache(
 			process_record) < 0)
 			goto err;
 
+		rtable->free(process_record);
 		process_record = NULL;
 
 	} while (pstatus != STATUS_NODATA);
diff -Naurp --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-03 07:01:09.000000000 -0500
+++ new/libsemanage/src/database.h	2006-01-04 08:17:28.000000000 -0500
@@ -62,14 +62,13 @@ typedef struct dbase_table {
 	/* --------------- Database Functionality ----------- */
 
 	/* Note: In all the functions below, the key is property
-	 * of the caller, and will not be modified by the database. */
+	 * of the caller, and will not be modified by the database. 
+	 * In add/set/modify, the data is also property of the caller */
 
 	/* Add the specified record to
 	 * the database if it is not present,
 	 * or fail if it already exists
-	 * 
-	 * Note: the <data> record becomes property of the 
-	 * database, and may not be further modified */
+	 */
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -79,9 +78,7 @@ typedef struct dbase_table {
 	/* Add the specified record to the  
 	 * database if it not present. 
 	 * If it's present, replace it
-	 * 
-	 * Note: The <data> record becomes property of the
-	 * database, and may not be further modified */
+	 */
 	int (*modify) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -90,9 +87,7 @@ typedef struct dbase_table {
 
 	/* Modify the specified record in the database
 	 * if it is present. Fail if it does not yet exist
-	 *
-	 * Note: The <data> record becomes property of the
-	 * database, and may not be further modified*/
+	 */
 	int (*set) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2005-12-26 21:21:34.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2006-01-04 08:40:25.000000000 -0500
@@ -24,7 +24,10 @@ hidden int dbase_llist_cache_prepend(
 		(cache_entry_t*) malloc(sizeof (cache_entry_t));
 	if (entry == NULL)
 		goto omem;
-	entry->data = data;
+	
+	if (dbase->rtable->clone(handle, data, &entry->data) < 0)
+		goto err;
+
 	entry->prev = NULL;
 	entry->next = dbase->cache;
 
@@ -38,8 +41,12 @@ hidden int dbase_llist_cache_prepend(
         return STATUS_SUCCESS;
 
         omem:
-	ERR(handle, "out of memory, could not cache record");
-        return STATUS_ERR;
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not cache record");
+	free(entry);
+	return STATUS_ERR;
 }
 
 hidden void dbase_llist_drop_cache(
@@ -154,7 +161,8 @@ hidden int dbase_llist_set(
 	}
 	else {
 		dbase->rtable->free(entry->data);
-		entry->data = data;
+		if (dbase->rtable->clone(handle, data, &entry->data) < 0)
+			goto err;
 	}
 
 	dbase->modified = 1;
@@ -184,7 +192,8 @@ hidden int dbase_llist_modify(
 	}
 	else {
 		dbase->rtable->free(entry->data);
-		entry->data = data;
+		if (dbase->rtable->clone(handle, data, &entry->data) < 0)
+			goto err;
 	}
 
 	dbase->modified = 1;
diff -Naurp --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-12-23 01:01:49.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2006-01-04 08:41:06.000000000 -0500
@@ -375,7 +375,7 @@ static int dbase_policydb_list (
 	size_t* count) {
 
 	record_t** tmp_records = NULL;
-	size_t tmp_count, i;
+	size_t tmp_count;
 	struct list_handler_arg list_arg;
 	list_arg.pos = 0;
 	list_arg.rtable = dbase->rtable;
@@ -410,7 +410,7 @@ static int dbase_policydb_list (
 
 	err:
 	for (; list_arg.pos >= 0; list_arg.pos--)
-		dbase->rtable->free(tmp_records[i]);
+		dbase->rtable->free(tmp_records[list_arg.pos]);
 	free(tmp_records);
 	ERR(handle, "could not list records");
 	return STATUS_ERR;
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-03 06:40:03.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-01-04 08:22:06.000000000 -0500
@@ -72,7 +72,6 @@ static int load_handler(
 	void* varg) {
 
 	record_key_t* rkey = NULL;
-	record_t* rcopy = NULL;
 	load_handler_arg_t* arg = 
 		(load_handler_arg_t*) varg;
 
@@ -84,22 +83,17 @@ static int load_handler(
 	if (rtable->key_extract(handle, record, &rkey) < 0)
 		goto err;
 
-	if (rtable->clone(handle, record, &rcopy) < 0)
-		goto err;
- 
 	switch (arg->mode) {
 	
 		case MODE_SET:
-			if (dtable->set(handle, dbase, rkey, rcopy) < 0) 
+			if (dtable->set(handle, dbase, rkey, record) < 0) 
 				goto err;
-			rcopy = NULL;
 			break;
 		
 		default:
 		case MODE_MODIFY:
-			if (dtable->modify(handle, dbase, rkey, rcopy) < 0) 
+			if (dtable->modify(handle, dbase, rkey, record) < 0) 
 				goto err;
-			rcopy = NULL;
 			break;
 
 	}
@@ -110,7 +104,6 @@ static int load_handler(
 	err:
 	/* FIXME: handle error */
 	rtable->key_free(rkey);
-	rtable->free(rcopy);
 	return -1;
 }
 
diff -Naurp --exclude-from excludes old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-12-23 18:44:43.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2006-01-04 08:19:53.000000000 -0500
@@ -102,7 +102,6 @@ static int semanage_set_boolean_list(
 	size_t j;
 	semanage_handle_t* handle = NULL;
 	semanage_bool_t* boolean = NULL;
-	semanage_bool_t* boolean2 = NULL;
 	semanage_bool_key_t* bool_key = NULL;
 	int managed;
 
@@ -142,19 +141,14 @@ static int semanage_set_boolean_list(
 		if (semanage_bool_key_extract(handle, boolean, &bool_key) < 0)
 			goto err;
 
-		if (permanent) {
-			if (semanage_bool_clone(handle, boolean, &boolean2) < 0)
-				goto err;
-
-			if (semanage_bool_modify_local(handle, bool_key, boolean2) < 0)
-				goto err;
-			boolean2 = NULL;
-		} 
+		if (permanent && semanage_bool_modify_local(handle, bool_key, boolean) < 0)
+			goto err;
 
 		if (semanage_bool_set_active(handle, bool_key, boolean) < 0)
 			goto err;
 
 		semanage_bool_key_free(bool_key);
+		semanage_bool_free(boolean);
 		bool_key = NULL;
 		boolean = NULL;
 	}	
@@ -172,7 +166,6 @@ static int semanage_set_boolean_list(
 	err:
 	semanage_bool_key_free(bool_key);
 	semanage_bool_free(boolean);
-	semanage_bool_free(boolean2);
 	semanage_handle_destroy(handle);
 	fprintf(stderr, "Could not change policy booleans\n");
 	return -1;

--------------090105080300080501070809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
