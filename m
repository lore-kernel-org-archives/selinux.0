Message-ID: <43613FB8.2070307@cornell.edu>
Date: Thu, 27 Oct 2005 16:59:36 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] [ SEPOL ] Implement dbase_policydb_list
Content-Type: multipart/mixed;
 boundary="------------090108000807090505010302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090108000807090505010302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements dbase_policydb_list on top of count/iterate. It 
also changes the count() specification to unsigned int everywhere...I 
probably still shouldn't be casting unsigned int to size_t in  list(), 
but at least it's better than casting signed int (and producing a warning).

list() tested and should work.


--------------090108000807090505010302
Content-Type: text/x-patch;
 name="libsemanage.policy_list.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policy_list.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/booleans_local.h	2005-10-27 16:40:26.000000000 -0400
@@ -36,7 +36,7 @@ extern int semanage_bool_exists_local(
 
 extern int semanage_bool_count_local(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_bool_iterate_local(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/booleans_policy.h	2005-10-27 16:40:57.000000000 -0400
@@ -17,7 +17,7 @@ extern int semanage_bool_exists(
 
 extern int semanage_bool_count(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_bool_iterate(
 	semanage_handle_t* handle,
@@ -28,6 +28,6 @@ extern int semanage_bool_iterate(
 extern int semanage_bool_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	size_t* count);
+	size_t* size);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces_local.h	2005-10-27 16:41:47.000000000 -0400
@@ -36,7 +36,7 @@ extern int semanage_iface_exists_local(
 
 extern int semanage_iface_count_local(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_iface_iterate_local(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/interfaces_policy.h new/libsemanage/include/semanage/interfaces_policy.h
--- old/libsemanage/include/semanage/interfaces_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces_policy.h	2005-10-27 16:42:02.000000000 -0400
@@ -17,7 +17,7 @@ extern int semanage_iface_exists(
 
 extern int semanage_iface_count(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_iface_iterate(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/ports_local.h	2005-10-27 16:41:11.000000000 -0400
@@ -36,7 +36,7 @@ extern int semanage_port_exists_local(
 
 extern int semanage_port_count_local(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_port_iterate_local(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/ports_policy.h new/libsemanage/include/semanage/ports_policy.h
--- old/libsemanage/include/semanage/ports_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/ports_policy.h	2005-10-27 16:41:19.000000000 -0400
@@ -17,7 +17,7 @@ extern int semanage_port_exists(
 
 extern int semanage_port_count(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_port_iterate(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/seusers.h	2005-10-27 16:44:49.000000000 -0400
@@ -36,7 +36,7 @@ extern int semanage_seuser_exists(
 
 extern int semanage_seuser_count(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_seuser_iterate(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/users_local.h	2005-10-27 16:41:28.000000000 -0400
@@ -36,7 +36,7 @@ extern int semanage_user_exists_local(
 
 extern int semanage_user_count_local(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_user_iterate_local(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/users_policy.h new/libsemanage/include/semanage/users_policy.h
--- old/libsemanage/include/semanage/users_policy.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/include/semanage/users_policy.h	2005-10-27 16:41:37.000000000 -0400
@@ -17,7 +17,7 @@ extern int semanage_user_exists(
 
 extern int semanage_user_count(
 	semanage_handle_t* handle,
-	int* response);
+	unsigned int* response);
 
 extern int semanage_user_iterate(
 	semanage_handle_t* handle,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/booleans_local.c	2005-10-27 16:39:59.000000000 -0400
@@ -79,7 +79,7 @@ int semanage_bool_exists_local(
 
 int semanage_bool_count_local(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-10-27 09:51:27.000000000 -0400
+++ new/libsemanage/src/booleans_policy.c	2005-10-27 16:40:11.000000000 -0400
@@ -52,7 +52,7 @@ int semanage_bool_exists(
 
 int semanage_bool_count(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_bool_dbase_policy(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_default.c new/libsemanage/src/database_default.c
--- old/libsemanage/src/database_default.c	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/database_default.c	2005-10-27 16:48:22.000000000 -0400
@@ -107,7 +107,7 @@ static int dbase_default_exists (
 static int dbase_default_count (
 	semanage_handle_t* handle,
 	dbase_default_t* dbase,
-	int* response) {
+	unsigned int* response) {
 
 	response = NULL;
 	dbase = NULL;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-27 09:51:27.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-27 16:37:11.000000000 -0400
@@ -450,7 +450,7 @@ static int dbase_file_modify(
 static int dbase_file_count(
         semanage_handle_t* handle,
         dbase_file_t* dbase,
-        int* response) {
+        unsigned int* response) {
 
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-10-20 13:52:10.000000000 -0400
+++ new/libsemanage/src/database.h	2005-10-27 16:37:59.000000000 -0400
@@ -95,7 +95,7 @@ typedef struct dbase_table {
 	int (*count) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
-		int* response);
+		unsigned int* response);
 
 	/* Execute the specified handler over 
 	 * the records of this database. The handler
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-27 16:47:49.000000000 -0400
@@ -388,7 +388,7 @@ static int dbase_policydb_exists (
 static int dbase_policydb_count (
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase,
-	int* response) {
+	unsigned int* response) {
 
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
@@ -428,24 +428,75 @@ static int dbase_policydb_iterate(
 	return STATUS_ERR;
 }
 
+struct list_handler_arg {
+	record_table_t* rtable;
+	record_t** records;
+	int pos;
+};
+
+static int list_handler(
+	record_t* record,
+	void* varg) {
+
+	struct list_handler_arg* arg = 
+		(struct list_handler_arg*) varg;
+
+	if (arg->rtable->clone(record, &arg->records[arg->pos]) < 0)
+		return -1;
+	arg->pos++;
+	return 0;
+}
+
 static int dbase_policydb_list (
 	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_t*** records,
 	size_t* count) {
 
+	record_t** tmp_records = NULL;
+	size_t tmp_count, i;
+	struct list_handler_arg list_arg;
+	list_arg.pos = 0;
+	list_arg.rtable = dbase->rtable;
+
 	if (enter_ro(handle, dbase) < 0)
 		goto err;
 
-	/* Stub */
-	records = NULL;
-	count = NULL;
+	if (dbase->rptable->count(handle->sepolh, 
+		dbase->policydb, &tmp_count) < 0)
+		goto err;
+
+	if (tmp_count > 0) {
+		tmp_records = (record_t**)
+			calloc(tmp_count, sizeof (record_t*));
+
+		if (tmp_records == NULL)
+			goto omem;
+
+		list_arg.records = tmp_records;
+		
+		if (dbase->rptable->iterate(handle->sepolh,
+			dbase->policydb, list_handler, &list_arg) < 0) {
+			ERR(handle, "list handler could not extract record");
+			goto err;
+		}
+	}
+
+	*records = tmp_records;
+	*count = tmp_count;
+
 	exit_ro(handle, dbase);
-	return STATUS_ERR;
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
 
 	err:
-	/* FIXME: handle error */
+	for (; list_arg.pos >= 0; list_arg.pos--)
+		dbase->rtable->free(tmp_records[i]);
+	free(tmp_records);
 	exit_ro(handle, dbase);
+	ERR(handle, "could not list records");
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-10-26 09:34:29.000000000 -0400
+++ new/libsemanage/src/database_policydb.h	2005-10-27 16:48:02.000000000 -0400
@@ -46,7 +46,7 @@ typedef struct record_policydb_table {
 	int (*count) (
 		sepol_handle_t* handle,
 		sepol_policydb_t* policydb,
-		int* response);
+		unsigned int* response);
 
 	/* Check if a record exists */
 	int (*exists) (
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/interfaces_local.c	2005-10-27 16:39:27.000000000 -0400
@@ -79,7 +79,7 @@ int semanage_iface_exists_local(
 
 int semanage_iface_count_local(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-10-27 09:51:27.000000000 -0400
+++ new/libsemanage/src/interfaces_policy.c	2005-10-27 16:39:36.000000000 -0400
@@ -52,7 +52,7 @@ int semanage_iface_exists(
 
 int semanage_iface_count(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_iface_dbase_policy(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/ports_local.c	2005-10-27 16:39:49.000000000 -0400
@@ -79,7 +79,7 @@ int semanage_port_exists_local(
 
 int semanage_port_count_local(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-27 09:51:27.000000000 -0400
+++ new/libsemanage/src/ports_policy.c	2005-10-27 16:39:15.000000000 -0400
@@ -52,7 +52,7 @@ int semanage_port_exists(
 
 int semanage_port_count(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_policy(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/seusers.c	2005-10-27 16:45:02.000000000 -0400
@@ -79,7 +79,7 @@ int semanage_seuser_exists(
 
 int semanage_seuser_count(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/users_local.c	2005-10-27 16:38:47.000000000 -0400
@@ -80,7 +80,7 @@ int semanage_user_exists_local(
 
 int semanage_user_count_local(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-27 09:51:27.000000000 -0400
+++ new/libsemanage/src/users_policy.c	2005-10-27 16:38:57.000000000 -0400
@@ -52,7 +52,7 @@ int semanage_user_exists(
 
 int semanage_user_count(
 	semanage_handle_t* handle,
-	int* response) {
+	unsigned int* response) {
 
 	dbase_config_t* dconfig = semanage_user_dbase_policy(handle);
 	return dconfig->dtable->count(handle, dconfig->dbase, response);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-26 09:34:21.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-27 16:42:20.000000000 -0400
@@ -39,7 +39,7 @@ extern int sepol_bool_set (
 extern int sepol_bool_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response);
+	unsigned int* response);
 
 /* Check if the specified boolean exists */
 extern int sepol_bool_exists(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-26 09:34:21.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-27 16:42:49.000000000 -0400
@@ -9,7 +9,7 @@
 extern int sepol_iface_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response);
+	unsigned int* response);
 
 /* Check if an interface exists */
 extern int sepol_iface_exists(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-26 09:34:21.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-27 16:42:37.000000000 -0400
@@ -9,7 +9,7 @@
 extern int sepol_port_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response);
+	unsigned int* response);
 
 /* Check if a port exists */
 extern int sepol_port_exists(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-26 09:34:21.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-27 16:42:29.000000000 -0400
@@ -35,7 +35,7 @@ extern int sepol_user_modify(
 extern int sepol_user_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response);
+	unsigned int* response);
 
 /* Check if the specified user exists */
 extern int sepol_user_exists(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-27 16:43:05.000000000 -0400
@@ -110,7 +110,7 @@ int sepol_bool_set (
 int sepol_bool_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response) {
+	unsigned int* response) {
 
 	policydb_t* policydb = &p->p;
 	*response = policydb->p_bools.nprim;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-27 16:43:52.000000000 -0400
@@ -212,9 +212,9 @@ int sepol_iface_modify(
 extern int sepol_iface_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response) {
+	unsigned int* response) {
 
-	int count = 0;
+	unsigned int count = 0;
 	ocontext_t *c, *head;
 	policydb_t* policydb = &p->p;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-27 16:43:20.000000000 -0400
@@ -143,9 +143,9 @@ static int port_to_record (
 extern int sepol_port_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response) {
+	unsigned int* response) {
 
-	int count = 0;
+	unsigned int count = 0;
 	ocontext_t *c, *head;
 	policydb_t* policydb = &p->p;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-27 16:43:55.000000000 -0400
@@ -316,7 +316,7 @@ int sepol_user_exists(
 int sepol_user_count(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	int* response) {
+	unsigned int* response) {
 
 	policydb_t* policydb = &p->p;
 	*response = policydb->p_users.nprim;

--------------090108000807090505010302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
