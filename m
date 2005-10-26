Message-ID: <435EE8CC.70709@cornell.edu>
Date: Tue, 25 Oct 2005 22:24:12 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 2 ] Seusers
Content-Type: multipart/mixed;
 boundary="------------020706090600060805000603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020706090600060805000603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch should get seusers working... maybe needs a bit more testing, 
but this code's disabled anyway..
I can tell the parser's working, but I need to get a new base.pp to test 
the commit (module format changed..)

Changes:
- drop handle from semanage record to match the other records for now
- fill in the seuser record table
- implement seuser_print, and seuser_parse

Parser notes:
- this parser allows multiline records, as the other ones - it does not 
care how things are spaced at all (unlike the selinux parser)
- However.... it does require a compressed MLS string, on a single line, 
with no whitespace. This is consistent with the selinux seuser parser. 
It is not consistent with the users parser (which allows whitespace and 
multiline MLS). Note that the user parser uses a "range" substring to 
delimit where it should stop reading categories (which seems like a 
mistake, because the category name can contain that substring). Here, we 
don't have such a substring following the MLS range, so we can't allow 
spaces and multiline. Another note... "default" is a perfectly valid 
user name...
- also the

Other changes:
- booleans: rename boolean file from "booleans" to "booleans.local"
- parser utils: make the fetch string functions fail on 0-length string, 
instead of returning a '\0' - we really want nonzero strings
- ports : remove misleading parse_dispose_line, which gives the wrong 
idea about how to write a parser function


--------------020706090600060805000603
Content-Type: text/x-patch;
 name="libsemanage.seusers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.seusers.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/seuser_record.h new/libsemanage/include/semanage/seuser_record.h
--- old/libsemanage/include/semanage/seuser_record.h	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/include/semanage/seuser_record.h	2005-10-25 21:37:55.000000000 -0400
@@ -1,8 +1,6 @@
 #ifndef _SEMANAGE_SEUSER_RECORD_H_
 #define _SEMANAGE_SEUSER_RECORD_H_
 
-#include <semanage/handle.h>
-
 struct semanage_seuser;
 struct semanage_seuser_key;
 typedef struct semanage_seuser semanage_seuser_t;
@@ -10,12 +8,10 @@ typedef struct semanage_seuser_key seman
 
 /* Key */
 extern int semanage_seuser_key_create(
-	semanage_handle_t* handle,
 	const char* name, 
 	semanage_seuser_key_t** key);
 
 extern int semanage_seuser_key_extract(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	semanage_seuser_key_t** key);
 
@@ -31,7 +27,6 @@ extern const char* semanage_seuser_get_n
 	semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_name(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	const char* name);
 
@@ -40,7 +35,6 @@ extern const char* semanage_seuser_get_s
 	semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_sename(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser,
 	const char* sename);
 
@@ -49,17 +43,14 @@ extern const char* semanage_seuser_get_m
 	semanage_seuser_t* seuser);
 
 extern int semanage_seuser_set_mlsrange(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	const char* mls_range);
 
 /* Create/Clone/Destroy */
 extern int semanage_seuser_create(
-	semanage_handle_t* handle,
 	semanage_seuser_t** seuser_ptr);
 
 extern int semanage_seuser_clone(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	semanage_seuser_t** seuser_ptr);
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/booleans_file.c	2005-10-25 21:24:11.000000000 -0400
@@ -59,10 +59,8 @@ static int bool_parse(
 		goto err;
 	if (parse_assert_noeof(info) < 0)
 		goto err;
-	
 	if (parse_assert_ch(info, '=') < 0)
 		goto err;
-
 	if (parse_skip_space(info) < 0) 
 		goto err;
 	if (parse_assert_noeof(info)  < 0)
@@ -122,7 +120,7 @@ record_file_table_t SEMANAGE_BOOL_FILE_R
 int bool_file_dbase_init(dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		"booleans",
+		"booleans.local",
 		&SEMANAGE_BOOL_RTABLE,
 		&SEMANAGE_BOOL_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/handle.c	2005-10-25 21:44:50.000000000 -0400
@@ -46,10 +46,10 @@ semanage_handle_t *semanage_handle_creat
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
 		goto err;
 
-	if ((conf_name = semanage_conf_path()) == NULL) 
+	if ((conf_name = semanage_conf_path()) == NULL)
 		goto err;
 
-	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
+	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL) 
 		goto err;
 
 	/* By default always reload policy after commit */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/parse_utils.c	2005-10-25 21:59:43.000000000 -0400
@@ -274,6 +274,11 @@ int parse_fetch_string(
 		info->ptr++;
 		len ++;
 	}
+
+	if (len == 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
 		
 	tmp_str = (char*) malloc(len + 1);
 	if (!tmp_str) {
@@ -302,6 +307,11 @@ int parse_fetch_string_until(
 		len ++;
         }
 
+	if (len == 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
 	tmp_str = (char*) malloc(len + 1);
 	if (!tmp_str) {
 		/* FIXME: handle error */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-20 10:40:46.000000000 -0400
+++ new/libsemanage/src/ports_file.c	2005-10-25 21:03:36.000000000 -0400
@@ -108,7 +108,6 @@ static int port_parse(
 
 	free(proto);
 	free(context);
-	parse_dispose_line(info);
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-10-14 13:26:14.000000000 -0400
+++ new/libsemanage/src/seuser_record.c	2005-10-25 21:37:44.000000000 -0400
@@ -3,7 +3,6 @@
 
 #include <semanage/seuser_record.h>
 #include "debug.h"
-#include "handle.h"
 
 struct semanage_seuser {
 	/* This user's name */
@@ -23,7 +22,6 @@ struct semanage_seuser_key {
 };
 
 int semanage_seuser_key_create(
-	semanage_handle_t* handle,
 	const char* name,
 	semanage_seuser_key_t** key_ptr) {
 
@@ -32,7 +30,7 @@ int semanage_seuser_key_create(
 		malloc(sizeof (semanage_seuser_key_t));
 
 	if (!tmp_key) {
-		ERR(handle, "out of memory, could not create seuser key");
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 	tmp_key->name = name;
@@ -42,13 +40,11 @@ int semanage_seuser_key_create(
 }
 
 int semanage_seuser_key_extract(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	semanage_seuser_key_t** key_ptr) {
 
-	if (semanage_seuser_key_create(handle, seuser->name, key_ptr) < 0) {
-		ERR(handle, "could not extract key from seuser %s",
-			seuser->name);
+	if (semanage_seuser_key_create(seuser->name, key_ptr) < 0) {
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 
@@ -76,13 +72,12 @@ const char* semanage_seuser_get_name(
 }
 
 int semanage_seuser_set_name(
-	semanage_handle_t* handle, 
 	semanage_seuser_t* seuser, 
 	const char* name) {
 
 	seuser->name = strdup(name);
 	if (!seuser->name) {
-		ERR(handle,  "out of memory, could not set name");
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 	return STATUS_SUCCESS;
@@ -96,13 +91,12 @@ const char* semanage_seuser_get_sename(
 }
 
 int semanage_seuser_set_sename(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser,
 	const char* sename) {
 
 	seuser->sename = strdup(sename);
 	if (!seuser->sename) {
-		ERR(handle,  "out of memory, could not set name");
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 	return STATUS_SUCCESS;
@@ -116,14 +110,12 @@ const char* semanage_seuser_get_mlsrange
 }
 
 int semanage_seuser_set_mlsrange(
-	semanage_handle_t* handle, 
 	semanage_seuser_t* seuser, 
 	const char* mls_range) {
 
 	seuser->mls_range = strdup(mls_range);
 	if (!seuser->mls_range) {
-		ERR(handle, "out of memory, could not set "
-			"MLS allowed range");
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 	return STATUS_SUCCESS;
@@ -131,15 +123,13 @@ int semanage_seuser_set_mlsrange(
 
 /* Create */
 int semanage_seuser_create(
-	semanage_handle_t* handle,
 	semanage_seuser_t** seuser_ptr) {
 
 	semanage_seuser_t* seuser = 
 		(semanage_seuser_t*) malloc(sizeof (semanage_seuser_t));
 
         if (!seuser) {
-		ERR(handle, "out of memory, "
-			"could not create seuser record"); 
+		/* FIXME: handle error */
 		return STATUS_ERR;
 	}
 
@@ -153,30 +143,29 @@ int semanage_seuser_create(
 
 /* Deep copy clone */
 int semanage_seuser_clone(
-	semanage_handle_t* handle,
 	semanage_seuser_t* seuser, 
 	semanage_seuser_t** seuser_ptr) {
 
 	semanage_seuser_t* new_seuser = NULL;
 
-	if (semanage_seuser_create(handle, &new_seuser) < 0)
+	if (semanage_seuser_create(&new_seuser) < 0)
 		goto err;
 
-	if (semanage_seuser_set_name(handle, new_seuser, seuser->name) < 0)
+	if (semanage_seuser_set_name(new_seuser, seuser->name) < 0)
 		goto err;
 
-	if (semanage_seuser_set_sename(handle, new_seuser, seuser->sename) < 0)
+	if (semanage_seuser_set_sename(new_seuser, seuser->sename) < 0)
 		goto err;
 
 	if (seuser->mls_range &&
-	   (semanage_seuser_set_mlsrange(handle, new_seuser, seuser->mls_range) < 0))
+	   (semanage_seuser_set_mlsrange(new_seuser, seuser->mls_range) < 0))
 		goto err;
 
 	*seuser_ptr = new_seuser;
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "could not clone seuser record");
+	/* FIXME: handle error */
 	semanage_seuser_free(new_seuser);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/seusers.c	2005-10-25 21:27:28.000000000 -0400
@@ -16,10 +16,10 @@ typedef struct dbase_file dbase_t;
 
 /* Record base functions */
 record_table_t SEMANAGE_SEUSER_RTABLE = {
-	.create      = NULL, /* FIXME: takes handle argument  */
-	.key_extract = NULL, /* FIXME */
+	.create      = semanage_seuser_create, 
+	.key_extract = semanage_seuser_key_extract,
 	.key_free    = semanage_seuser_key_free,
-	.clone       = NULL, /* FIXME */
+	.clone       = semanage_seuser_clone,
 	.compare     = semanage_seuser_compare,
 	.free        = semanage_seuser_free,
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/seusers_file.c	2005-10-25 21:56:33.000000000 -0400
@@ -11,6 +11,8 @@ typedef struct dbase_file dbase_t;
 #include <stdlib.h>
 #include <stdio.h>
 #include <strings.h>
+
+#include <selinux/selinux.h>
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
@@ -21,20 +23,95 @@ static int seuser_print(
 	semanage_seuser_t* seuser, 
 	FILE* str) {
 
-	/* Stub */
-	seuser = NULL;
-	str = NULL;
+	const char* name = semanage_seuser_get_name(seuser);
+	const char* sename = semanage_seuser_get_sename(seuser);
+	const char* mls = semanage_seuser_get_mlsrange(seuser);
+
+	if (fprintf(str, "%s:%s", name, sename) < 0) 
+		goto err;
+	
+	if (mls != NULL && fprintf(str, ":%s", mls) <  0)
+		goto err;
+	
+	fprintf(str, "\n");
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
 	return STATUS_ERR;
 }
 
 static int seuser_parse(
 	parse_info_t* info, 
 	semanage_seuser_t* seuser) {
-	
-	/* Stub */
-	info = NULL;
-	seuser = NULL;
+
+	char* str = NULL;
+
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Extract name */
+	if (parse_fetch_string_until(info, &str, ':') < 0)
+		goto err;
+	if (semanage_seuser_set_name(seuser, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
+		goto err;
+	if (parse_assert_ch(info, ':') < 0)
+		goto err;
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info)  < 0)
+		goto err;
+
+	/* Extract sename */
+	if (parse_fetch_string_until(info, &str, ':') < 0)
+		goto err;
+	if (semanage_seuser_set_sename(seuser, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	if (is_selinux_mls_enabled()) {
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+		if (parse_assert_ch(info, ':') < 0)
+			goto err;
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info)  < 0)
+			goto err;
+
+		/* NOTE: does not allow spaces/multiline */
+		if (parse_fetch_string(info, &str) < 0)
+			goto err;
+
+		if (semanage_seuser_set_mlsrange(seuser, str) <  0)
+			goto err;
+		free(str);
+		str = NULL;
+	} 
+
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
 	return STATUS_NODATA;
+
+	err:
+	/* FIXME: handle error */
+	free(str);
+	parse_dispose_line(info);
+	return STATUS_ERR;
 }
 
 /* SEUSER RECORD: method table (seusers.c) */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/users_file.c	2005-10-25 21:09:36.000000000 -0400
@@ -100,11 +100,8 @@ static int user_parse(
 		goto err;
 	if (parse_assert_noeof(info) < 0)
                 goto err;
-
-	/* Parse roles header */
 	if (parse_assert_str(info, "roles") < 0)
 		goto err;
-
 	if (parse_assert_space(info) < 0)
 		goto err;
 	if (parse_assert_noeof(info) < 0)
@@ -165,10 +162,8 @@ static int user_parse(
 			goto err;
 		if (parse_assert_noeof(info) < 0)
 			goto err;
-
 		if (parse_optional_str(info, "level") != STATUS_NODATA)
 			goto semicolon;
-
 		if (parse_assert_space(info) < 0)
 			goto err;
 		if (parse_assert_noeof(info) < 0)

--------------020706090600060805000603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
