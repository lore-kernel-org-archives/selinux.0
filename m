Message-ID: <435D61E1.6040007@cornell.edu>
Date: Mon, 24 Oct 2005 18:36:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Resync to sepol changes (again)
Content-Type: multipart/mixed;
 boundary="------------040403000405040007000900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040403000405040007000900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- add count function to POLICYDB record extension
- fill in all missing functions in the correct tables
- implement stub: dbase_policydb_count

Bugfixes:

- set STATUS_SUCCESS, not ERR in policydb exists() on the success path
- fix user parser bug, which did not allow multiple spaces between the 
user name and the "roles"
- replace an error-prone inplace parse helper (which was wrong, and 
could crash), with a correct, and better one that uses malloc.

--------------040403000405040007000900
Content-Type: text/x-patch;
 name="libsemanage.resync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.resync.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/booleans_policydb.c	2005-10-24 17:30:44.000000000 -0400
@@ -25,8 +25,9 @@ record_policydb_table_t SEMANAGE_BOOL_PO
 	.add         = NULL, 
 	.modify      = NULL,
 	.set         = sepol_bool_set,
-	.query       = NULL, /* FIXME */
-	.exists      = NULL, /* FIXME */ 
+	.query       = sepol_bool_query,
+	.count       = sepol_bool_count,
+	.exists      = sepol_bool_exists, 
 	.iterate     = sepol_bool_iterate,
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-24 17:34:32.000000000 -0400
@@ -379,7 +379,7 @@ static int dbase_policydb_exists (
 		goto err;
 
 	exit_ro(handle, dbase);
-	return STATUS_ERR;
+	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
@@ -395,10 +395,11 @@ static int dbase_policydb_count (
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	response = NULL;
+	if (dbase->rptable->count(dbase->policydb, response) < 0)
+		goto err;
+
 	exit_ro(handle, dbase);
-	return STATUS_ERR;
+	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/database_policydb.h	2005-10-24 17:29:20.000000000 -0400
@@ -17,7 +17,8 @@ typedef struct record_policydb_table {
 		record_key_t* rkey,
 		record_t* record);
 
-	/* Modify policy record */
+	/* Modify policy record, or add if 
+	 * the key isn't found */
 	int (*modify) (
 		sepol_policydb_t* policydb, 
 		record_key_t* rkey,
@@ -29,12 +30,18 @@ typedef struct record_policydb_table {
 		record_key_t* rkey,
 		record_t* record);
 
-	/* Query policy record */
+	/* Query policy record  - return the record
+	 * or NULL if it isn't found */
 	int (*query) (
 		sepol_policydb_t* policydb,
 		record_key_t* rkey,
 		record_t** response);
 
+	/* Count records */
+	int (*count) (
+		sepol_policydb_t* policydb,
+		int* response);
+
 	/* Check if a record exists */
 	int (*exists) (
 		sepol_policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/interfaces_policydb.c	2005-10-24 17:30:19.000000000 -0400
@@ -26,6 +26,7 @@ record_policydb_table_t SEMANAGE_IFACE_P
 	.modify      = sepol_iface_modify,
 	.set         = NULL,
 	.query       = sepol_iface_query,
+        .count       = sepol_iface_count,
 	.exists      = sepol_iface_exists, 
 	.iterate     = sepol_iface_iterate,
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/parse_utils.c	2005-10-24 18:21:34.000000000 -0400
@@ -256,13 +256,24 @@ char* parse_filter_space_until(parse_inf
 	return NULL;
 }
 
-
-char* parse_fetch_string_inplace(parse_info_t* info) {
+int parse_fetch_string(parse_info_t* info, char** str) {
 	char* start = info->ptr;
+	int len = 0;
+	char* tmp_str = NULL;
 
-	while (*(info->ptr) && !isspace(*(info->ptr)))
+	while (*(info->ptr) && !isspace(*(info->ptr))) {
 		info->ptr++;
-	*(info->ptr)++ = '\0';
-
-	return start;
+		len ++;
+	}
+		
+	tmp_str = (char*) malloc(len + 1);
+	if (!tmp_str) {
+		/* FIXME: handle error */
+		return STATUS_ERR;	
+	}
+	
+	strncpy(tmp_str, start, len);
+	*(tmp_str + len)= '\0';
+	*str = tmp_str;
+	return STATUS_SUCCESS;
 } 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/parse_utils.h	2005-10-24 18:23:24.000000000 -0400
@@ -81,10 +81,10 @@ extern char* parse_filter_space_until(
 	const char* substr);
 
 /* Extract the next string (delimited by 
- * whitespace), and move the read pointer past it. 
- * This string is overwritten when the next line 
- * is read (inplace storage) */
-extern char* parse_fetch_string_inplace(
-	parse_info_t* info);
+ * whitespace), and move the read pointer past it. */
+
+extern int parse_fetch_string(
+	parse_info_t* info,
+	char** str_ptr);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/ports_policydb.c	2005-10-24 17:30:24.000000000 -0400
@@ -26,6 +26,7 @@ record_policydb_table_t SEMANAGE_PORT_PO
 	.modify      = sepol_port_modify,
 	.set         = NULL, 
 	.query       = sepol_port_query,
+        .count       = sepol_port_count,
 	.exists      = sepol_port_exists,
 	.iterate     = sepol_port_iterate,
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/users_file.c	2005-10-24 18:27:55.000000000 -0400
@@ -70,13 +70,14 @@ static int user_parse(
 	int islist = 0;
 	char* mls = NULL;
 	char* start;
+	char* name_str = NULL;
 
 	if (parse_skip_space(info) < 0)
 		goto err;
 	if (!info->ptr)
 		goto last;
 
-	/* Parse user name */
+	/* Parse user header */
 	if (parse_assert_str(info, "user") < 0)
 		goto err;
 
@@ -87,7 +88,21 @@ static int user_parse(
 	if (parse_assert_noeof(info) < 0)
 		goto err;
 
-	if (semanage_user_set_name(user, parse_fetch_string_inplace(info)) < 0)
+	/* Parse user name */
+	if (parse_fetch_string(info, &name_str) < 0)
+		goto err;
+
+	if (semanage_user_set_name(user, name_str) < 0) {
+		free(name_str);
+                goto err;
+	}
+	free(name_str);
+
+	if (parse_assert_space(info) < 0)
+		goto err;
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
                 goto err;
 
 	/* Parse roles header */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/users_policydb.c	2005-10-24 17:29:43.000000000 -0400
@@ -25,7 +25,8 @@ record_policydb_table_t SEMANAGE_USER_PO
 	.add         = NULL,
 	.modify      = sepol_user_modify,
 	.set         = NULL,
-	.query       = NULL, /* FIXME */
+	.query       = sepol_user_query, 
+	.count       = sepol_user_count,
 	.exists      = sepol_user_exists,
 	.iterate     = sepol_user_iterate,
 };

--------------040403000405040007000900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
