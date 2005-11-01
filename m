Message-ID: <4366E1DC.2070707@cornell.edu>
Date: Mon, 31 Oct 2005 22:32:44 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Add more error messages...
Content-Type: multipart/mixed;
 boundary="------------070102000508070003080007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070102000508070003080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Passes handle and adds more error messages elsewhere... makes other 
messages less verbose (like the extra parse error notice).

There are 4 users in policy before the transaction.
libsemanage.parse_assert_ch: expected character ';', but found 's' 
(/etc/selinux/strict/modules/active/users.local: 1):
user Ivan roles { sysadm_r staff_r } level s0 range s0-s0:c1.c2,c3,c4,c55;
libsemanage.user_parse: could not parse user record
libsemanage.dbase_file_cache: could not cache file database
libsemanage.enter_ro: could not enter read-only section
Error: could not count users



--------------070102000508070003080007
Content-Type: text/x-patch;
 name="libsemanage.more_messages.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.more_messages.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-10-31 22:27:22.000000000 -0500
@@ -15,6 +15,7 @@ typedef struct dbase_file dbase_t;
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
 #include "database_file.h"
+#include "booleans_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
@@ -27,7 +28,7 @@ static int bool_print(
 	int value = semanage_bool_get_value(boolean);
 
 	if (fprintf(str, "%s=%d\n", name, value) < 0) {
-		ERR(handle, "error writing boolean %s to stream", name);
+		ERR(handle, "could not print boolean %s to stream", name);
 		return STATUS_ERR;
 	}
 
@@ -76,7 +77,8 @@ static int bool_parse(
 		value = strtol(str, &test, 10);
 
 		if (*test != '\0') {
-			/* FIXME: handle error */
+			ERR(handle, "could not parse numeric value for %s", 
+				semanage_bool_get_name(boolean));
 			goto err;
 		} 
 	}
@@ -85,14 +87,16 @@ static int bool_parse(
 	else if (!strcasecmp(str, "false"))
 		value = 0;
 	else {
-		/* FIXME: handle error */
+		ERR(handle, "invalid boolean value for %s: %s", 
+			semanage_bool_get_name(boolean), str);
 		goto err;
 	}
 	free(str);
 	str = NULL;
 
 	if (value != 0 && value != 1) {
-		/* FIXME: handle error */
+		ERR(handle, "invalid boolean value for %s: %u", 
+			semanage_bool_get_name(boolean), value);
 		goto err;
 	}
 	semanage_bool_set_value(boolean, value);
@@ -103,8 +107,7 @@ static int bool_parse(
 	return STATUS_NODATA;
 
         err:
-	ERR(handle, "parse error (%s: %u):\n%s",
-		info->filename, info->lineno, info->orig_line);
+	ERR(handle, "could not parse boolean record");
 	free(str);
 	parse_dispose_line(info);
 	return STATUS_ERR;
@@ -119,9 +122,12 @@ record_file_table_t SEMANAGE_BOOL_FILE_R
 	.print       = bool_print,
 };
 
-int bool_file_dbase_init(dbase_config_t* dconfig) {
+int bool_file_dbase_init(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
+		handle, 
 		"booleans.local",
 		&SEMANAGE_BOOL_RTABLE,
 		&SEMANAGE_BOOL_FILE_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.h new/libsemanage/src/booleans_file.h
--- old/libsemanage/src/booleans_file.h	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/booleans_file.h	2005-10-31 22:27:55.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int bool_file_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void bool_file_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-10-31 22:22:16.000000000 -0500
@@ -29,9 +29,11 @@ record_policydb_table_t SEMANAGE_BOOL_PO
 };
 
 int bool_policydb_dbase_init(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
 	if (dbase_policydb_init(
+		handle, 
 		"policy.kern",
 		&SEMANAGE_BOOL_RTABLE, 
 		&SEMANAGE_BOOL_POLICYDB_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.h new/libsemanage/src/booleans_policydb.h
--- old/libsemanage/src/booleans_policydb.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/booleans_policydb.h	2005-10-31 22:22:31.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int bool_policydb_dbase_init(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 void bool_policydb_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-10-31 22:17:42.000000000 -0500
@@ -49,7 +49,7 @@ static int construct_filename(
 
 	char* fname = malloc(fname_length);
 	if (!fname) {
-		/*  FIXME: handle error */
+		ERR(handle, "out of memory, could not construct filename");
 		return STATUS_ERR;
 	}
 	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
@@ -61,7 +61,8 @@ static int construct_filename(
 
 /* Helper for adding records to the cache */
 static int dbase_file_cache_add(
-        dbase_file_t* dbase,
+	semanage_handle_t* handle, 
+	dbase_file_t* dbase,
 	record_t* data) {
 
 	cache_entry_t* entry =
@@ -75,8 +76,9 @@ static int dbase_file_cache_add(
 	dbase->cache_sz++;
 
         return STATUS_SUCCESS;
+
         omem:
-        /* FIXME: handle error condition */
+	ERR(handle, "out of memory, could not cache record");
         return STATUS_ERR;
 }
 
@@ -125,7 +127,7 @@ static int dbase_file_cache(
 			break;
 
 		/* Add record to list */
-		if (dbase_file_cache_add(dbase, process_record) < 0)
+		if (dbase_file_cache_add(handle, dbase, process_record) < 0)
 			goto err;
 		process_record = NULL;
 
@@ -201,7 +203,6 @@ static int dbase_file_flush(
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
 	if (str != NULL)
 		fclose(str);
 		
@@ -230,12 +231,14 @@ static int dbase_file_cache_locate(
 	}
 
 	return STATUS_NODATA;
+
 	err:
-	/* FIXME: handle error condition */
+	ERR(handle, "could not complete cache lookup");
 	return STATUS_ERR;
 }
 
 int dbase_file_init(
+	semanage_handle_t* handle, 
 	const char* suffix,
 	record_table_t* rtable,
 	record_file_table_t* rftable,
@@ -260,7 +263,7 @@ int dbase_file_init(
 	return STATUS_SUCCESS;
 	
 	omem:
-	/* FIXME: handle error condition */
+	ERR(handle, "out of memory, could not initialize file database");
 	free(tmp_dbase);
 	return STATUS_ERR;
 }
@@ -291,7 +294,7 @@ static int dbase_file_exists(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error condition */
+	ERR(handle, "could not check if record exists");
 	return STATUS_ERR;
 }
 
@@ -309,18 +312,18 @@ static int dbase_file_add(
 		goto err;
 
 	if (status != STATUS_NODATA) {
-		/* FIXME: handle error condition */
+		ERR(handle, "record is already in the database");
 		goto err;
 	}
 
-	if (dbase_file_cache_add(dbase, data) < 0)
+	if (dbase_file_cache_add(handle, dbase, data) < 0)
 		goto err;
 
 	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error condition */
+	ERR(handle, "could not add record to the database");
 	return STATUS_ERR;
 }
 
@@ -337,7 +340,7 @@ static int dbase_file_set(
 	if (status < 0)
 		goto err;
         if (status == STATUS_NODATA) {
-		/* FIXME: handle error */
+		ERR(handle, "record not found in the database");
 		goto err;
 	}
 	else {
@@ -349,7 +352,7 @@ static int dbase_file_set(
         return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not set record value");
 	return STATUS_ERR;
 }
 
@@ -367,7 +370,7 @@ static int dbase_file_modify(
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA) {
-		if (dbase_file_cache_add(dbase, data) < 0)
+		if (dbase_file_cache_add(handle, dbase, data) < 0)
 			goto err;
 	}
 	else {
@@ -379,7 +382,7 @@ static int dbase_file_modify(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error condition */
+	ERR(handle, "could not modify record value");
 	return STATUS_ERR;
 }
 
@@ -412,7 +415,7 @@ static int dbase_file_query(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: Handle error condition */
+	ERR(handle, "could not query record value");
 	return STATUS_ERR;
 }
 
@@ -504,13 +507,13 @@ static int dbase_file_list(
 	return STATUS_SUCCESS;
 
 	omem:
-	/* FIXME: handle error condition */
+	ERR(handle, "out of memory");
 
 	err:
 	for (; i >= 0; i--)
 		dbase->rtable->free(tmp_records[i]);
 	free(tmp_records);
-	/* FIXME: handle error condition */
+	ERR(handle, "could not allocate record array");
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.h new/libsemanage/src/database_file.h
--- old/libsemanage/src/database_file.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/database_file.h	2005-10-31 22:17:54.000000000 -0500
@@ -30,6 +30,7 @@ typedef struct record_file_table {
 
 /* FILE - initialization */
 extern int dbase_file_init(
+	semanage_handle_t* handle,
 	const char* suffix,
 	record_table_t* rtable,
 	record_file_table_t* rftable,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-10-31 22:18:08.000000000 -0500
@@ -147,6 +147,7 @@ static void dbase_policydb_drop_cache(
 }
 
 int dbase_policydb_init(
+	semanage_handle_t* handle,
 	const char* suffix,
 	record_table_t* rtable,
 	record_policydb_table_t* rptable,
@@ -170,7 +171,7 @@ int dbase_policydb_init(
 	return STATUS_SUCCESS;
 
 	omem:
-	/* FIXME: handle error condition */
+	ERR(handle, "out of memory, could not initialize policy database");
 	free(tmp_dbase);
 
 	return STATUS_ERR;
@@ -223,7 +224,7 @@ static int dbase_policydb_add (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not add record to the database");
 	return STATUS_ERR;
 }
 
@@ -241,7 +242,7 @@ static int dbase_policydb_set(
 	return STATUS_SUCCESS;
 		
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not set record value");
 	return STATUS_ERR;
 }
 
@@ -258,7 +259,7 @@ static int dbase_policydb_modify (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not modify record value");
 	return STATUS_ERR;
 }
 
@@ -287,7 +288,7 @@ static int dbase_policydb_query (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not query record value");
 	return STATUS_ERR;
 }
 
@@ -304,7 +305,7 @@ static int dbase_policydb_exists (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not check if record exists");
 	return STATUS_ERR;
 }
 
@@ -320,7 +321,7 @@ static int dbase_policydb_count (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not count the database records");
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-10-27 17:39:18.000000000 -0400
+++ new/libsemanage/src/database_policydb.h	2005-10-31 22:18:21.000000000 -0500
@@ -66,6 +66,7 @@ typedef struct record_policydb_table {
 
 /* Initialize database */
 extern int dbase_policydb_init(
+	semanage_handle_t* handle,
 	const char* suffix,
 	record_table_t* rtable,
 	record_policydb_table_t* rptable,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-31 22:29:18.000000000 -0500
@@ -97,39 +97,38 @@ int semanage_direct_connect(semanage_han
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
 
-        /* Configure object databases
-         * Hardcore DATA FILE backend for now */
-	if (user_file_dbase_init(semanage_user_dbase_local(sh)) < 0)
+        /* Configure object databases */
+	if (user_file_dbase_init(sh, semanage_user_dbase_local(sh)) < 0)
 		goto err;
 
-	if (port_file_dbase_init(semanage_port_dbase_local(sh)) < 0)
+	if (port_file_dbase_init(sh, semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(semanage_iface_dbase_local(sh)) < 0)
+	if (iface_file_dbase_init(sh, semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(semanage_bool_dbase_local(sh)) < 0)
+	if (bool_file_dbase_init(sh, semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
+	if (seuser_file_dbase_init(sh, semanage_seuser_dbase(sh)) < 0)
 		goto err;
 
-	if (user_policydb_dbase_init(semanage_user_dbase_policy(sh)) < 0)
+	if (user_policydb_dbase_init(sh, semanage_user_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (port_policydb_dbase_init(semanage_port_dbase_policy(sh)) < 0)
+	if (port_policydb_dbase_init(sh, semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (iface_policydb_dbase_init(semanage_iface_dbase_policy(sh)) < 0)
+	if (iface_policydb_dbase_init(sh, semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (bool_policydb_dbase_init(semanage_bool_dbase_policy(sh)) < 0)
+	if (bool_policydb_dbase_init(sh, semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(sh, "could not establish direct connection");
 	sepol_handle_destroy(sh->sepolh);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-10-31 20:01:36.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-10-31 22:27:38.000000000 -0500
@@ -15,6 +15,7 @@ typedef struct dbase_file dbase_t;
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
 #include "database_file.h"
+#include "interfaces_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
@@ -51,9 +52,12 @@ record_file_table_t SEMANAGE_IFACE_FILE_
 	.print       = iface_print,
 };
 
-int iface_file_dbase_init(dbase_config_t* dconfig) {
+int iface_file_dbase_init(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
+		handle, 
 		"interfaces.local",	
 		&SEMANAGE_IFACE_RTABLE,
 		&SEMANAGE_IFACE_FILE_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.h new/libsemanage/src/interfaces_file.h
--- old/libsemanage/src/interfaces_file.h	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/interfaces_file.h	2005-10-31 22:28:08.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int iface_file_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void iface_file_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-10-31 22:23:51.000000000 -0500
@@ -29,9 +29,11 @@ record_policydb_table_t SEMANAGE_IFACE_P
 };
 
 int iface_policydb_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
 	if (dbase_policydb_init(
+		handle, 
 		"policy.kern",
 		&SEMANAGE_IFACE_RTABLE, 
 		&SEMANAGE_IFACE_POLICYDB_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.h new/libsemanage/src/interfaces_policydb.h
--- old/libsemanage/src/interfaces_policydb.h	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/interfaces_policydb.h	2005-10-31 22:23:25.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int iface_policydb_dbase_init(
+	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
 
 void iface_policydb_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-10-31 22:19:41.000000000 -0500
@@ -58,10 +58,11 @@ int parse_open(
 	return STATUS_SUCCESS;
 }
 
-void parse_close(parse_info_t* info) {
-	if (info->file_stream && (fclose(info->file_stream) < 0)) {
-		/* FIXME: handle error condition */
-	}
+void parse_close(
+	parse_info_t* info) {
+
+	if (info->file_stream)
+		fclose(info->file_stream);
 	info->file_stream = NULL;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-10-31 22:27:41.000000000 -0500
@@ -14,6 +14,7 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "database_file.h"
+#include "ports_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
@@ -22,14 +23,14 @@ static int port_print(
 	semanage_port_t* port, 
 	FILE* str) {
 
-	int low, high;
 	char* con_str = NULL;
 
-	if (fprintf(str, "portcon %s ", semanage_port_get_proto_str(port)) < 0)
-		goto err;
+	int low = semanage_port_get_low(port);
+	int high = semanage_port_get_high(port);
+	const char* proto = semanage_port_get_proto_str(port);
 
-	low = semanage_port_get_low(port);
-	high = semanage_port_get_high(port);
+	if (fprintf(str, "portcon %s ", proto) < 0)
+		goto err;
 
 	if (low == high) {
 		if (fprintf(str, "%d ", low) < 0)
@@ -50,7 +51,8 @@ static int port_print(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "could not print port range %u - %u (%s) to stream", 
+		low, high, proto);
 	free(con_str);
 	return STATUS_ERR;
 }
@@ -77,7 +79,8 @@ static int port_parse(
 		free(context);
 		items = sscanf(info->ptr, "portcon %as %d %as", &proto, &low, &context);
 		if (items != 3) {
-			/* FIXME: handle error */
+			ERR(handle, "too many items on the line (%s: %u):\n%s",
+				info->filename, info->lineno, info->orig_line);
 			goto err;
 		}
 		semanage_port_set_port(port, low);
@@ -91,7 +94,8 @@ static int port_parse(
 		semanage_port_set_proto(port, SEMANAGE_PROTO_UDP);
 
 	else {
-		/* FIXME: handle error */
+		ERR(handle, "invalid protocol value for port range %u - %u: %s",
+			low, high, proto); 
 		goto err;
 	}
 
@@ -114,8 +118,7 @@ static int port_parse(
 	return STATUS_NODATA;
 
 	err:
-	ERR(handle, "parse error (%s: %u):\n%s",
-		info->filename, info->lineno, info->orig_line);
+	ERR(handle, "could not parse port record");
 	free(proto);
 	free(context);
 	semanage_context_free(con);
@@ -133,9 +136,12 @@ record_file_table_t SEMANAGE_PORT_FILE_R
 	.print       = port_print,
 };
 
-int port_file_dbase_init(dbase_config_t* dconfig) {
+int port_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
+		handle, 
 		"ports.local",
 		&SEMANAGE_PORT_RTABLE,
 		&SEMANAGE_PORT_FILE_RTABLE,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.h new/libsemanage/src/ports_file.h
--- old/libsemanage/src/ports_file.h	2005-10-06 15:22:48.000000000 -0400
+++ new/libsemanage/src/ports_file.h	2005-10-31 22:28:20.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int port_file_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void port_file_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-10-31 22:24:10.000000000 -0500
@@ -29,9 +29,11 @@ record_policydb_table_t SEMANAGE_PORT_PO
 };
 
 int port_policydb_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
 	if (dbase_policydb_init(
+		handle, 
 		"policy.kern",
 		&SEMANAGE_PORT_RTABLE,
 		&SEMANAGE_PORT_POLICYDB_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.h new/libsemanage/src/ports_policydb.h
--- old/libsemanage/src/ports_policydb.h	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/ports_policydb.h	2005-10-31 22:24:21.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int port_policydb_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void port_policydb_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-10-31 22:27:12.000000000 -0500
@@ -16,6 +16,7 @@ typedef struct dbase_file dbase_t;
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
+#include "seusers_file.h"
 #include "semanage_store.h"
 #include "handle.h"
 
@@ -38,7 +39,7 @@ static int seuser_print(
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "error writing seuser %s to stream", name);
+	ERR(handle, "could not print seuser %s to stream", name);
 	return STATUS_ERR;
 }
 
@@ -110,8 +111,7 @@ static int seuser_parse(
 	return STATUS_NODATA;
 
 	err:
-	ERR(handle, "parse error (%s: %u):\n%s", 
-		info->filename, info->lineno, info->orig_line);
+	ERR(handle, "could not parse seuser record");
 	free(str);
 	parse_dispose_line(info);
 	return STATUS_ERR;
@@ -126,9 +126,12 @@ record_file_table_t SEMANAGE_SEUSER_FILE
 	.print       = seuser_print,
 };
 
-int seuser_file_dbase_init(dbase_config_t* dconfig) {
+int seuser_file_dbase_init(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
+		handle, 
 		"seusers",
 		&SEMANAGE_SEUSER_RTABLE,
 		&SEMANAGE_SEUSER_FILE_RTABLE,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.h new/libsemanage/src/seusers_file.h
--- old/libsemanage/src/seusers_file.h	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/seusers_file.h	2005-10-31 22:28:34.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int seuser_file_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void seuser_file_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-10-31 22:26:49.000000000 -0500
@@ -15,6 +15,7 @@ typedef struct dbase_file dbase_t;
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
 #include "database_file.h"
+#include "users_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
@@ -59,7 +60,7 @@ static int user_print(
 
 	err:
 	free(roles);
-	/* FIXME: handle error */
+	ERR(handle, "could not print user %s to stream", name);
 	return STATUS_ERR;
 }
 
@@ -211,8 +212,7 @@ static int user_parse(
 	return STATUS_NODATA;
 
 	err:
-	ERR(handle, "parse error (%s: %u):\n%s",
-		info->filename, info->lineno, info->orig_line);
+	ERR(handle, "could not parse user record");
 	free(mls);
 	parse_dispose_line(info);
 	return STATUS_ERR;
@@ -227,9 +227,12 @@ record_file_table_t SEMANAGE_USER_FILE_R
 	.print       = user_print,
 };
 
-int user_file_dbase_init(dbase_config_t* dconfig) {
+int user_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
+		handle, 
 		"users.local",
 		&SEMANAGE_USER_RTABLE,
 		&SEMANAGE_USER_FILE_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.h new/libsemanage/src/users_file.h
--- old/libsemanage/src/users_file.h	2005-10-06 15:22:48.000000000 -0400
+++ new/libsemanage/src/users_file.h	2005-10-31 22:28:44.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int user_file_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void user_file_dbase_release(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-10-31 22:24:57.000000000 -0500
@@ -29,9 +29,11 @@ record_policydb_table_t SEMANAGE_USER_PO
 };
 
 int user_policydb_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig) {
 
 	if (dbase_policydb_init(
+		handle, 
 		"policy.kern",
 		&SEMANAGE_USER_RTABLE, 
 		&SEMANAGE_USER_POLICYDB_RTABLE, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.h new/libsemanage/src/users_policydb.h
--- old/libsemanage/src/users_policydb.h	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/users_policydb.h	2005-10-31 22:24:44.000000000 -0500
@@ -5,6 +5,7 @@
 #include "handle.h"
 
 int user_policydb_dbase_init(
+	semanage_handle_t* handle, 
 	dbase_config_t* dconfig);
 
 void user_policydb_dbase_release(

--------------070102000508070003080007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
