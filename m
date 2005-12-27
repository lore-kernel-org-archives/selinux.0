Message-ID: <43B086A1.2030007@cornell.edu>
Date: Mon, 26 Dec 2005 19:11:13 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] File Contexts APIs (part 1)
Content-Type: multipart/mixed;
 boundary="------------090108090005000908070801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090108090005000908070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch implemens an API for working with file_contexts.local.

A file context record is represented as a (regexp, type, context) triple.
A key is (regexp, type), and matches only if regexp and type match exactly.
type is block, char, pipe, regular file, all files, etc..

This key scheme might be too simple, but (as in ports), it seems like more
complex operations with the key should be pushed into the client.

The parser is compatible with the current file_contexts format.
It also allows multi-line records, like all other semanage parsers.

Note:
        Unlike ports and interfaces, semanage_fcontext_get_con() can and 
will
        return NULL on file specifications without a context (<<none>>).
        Interfaces and ports do not support <<none>>.

Note2:
        Like in ports, I am concerned here about the order of 
iterate()/list()
        traversal - I will likely have to reverse it in the dbase code, 
because it
        seems backwards.

Caveats:
        - there's currently no support for working with the overall
        file_contexts file, this is just the .local file

        - validation is missing - needs additional sepol functionality, just
        like seuser validation

        - .local file is not installed yet, it stays in the sandbox - 
needs code to merge
        .local into the other file_contexts file somehow (or 
alternatively, the file_contexts.local path
        should be exposed by libselinux)


--------------090108090005000908070801
Content-Type: text/x-patch;
 name="libsemanage11.file_contexts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage11.file_contexts.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontext_record.h new/libsemanage/include/semanage/fcontext_record.h
--- old/libsemanage/include/semanage/fcontext_record.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/fcontext_record.h	2005-12-26 15:49:58.000000000 -0500
@@ -0,0 +1,86 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_FCONTEXT_RECORD_H_
+#define _SEMANAGE_FCONTEXT_RECORD_H_ 
+
+#include <semanage/context_record.h>
+#include <semanage/handle.h>
+
+#ifndef _SEMANAGE_FCONTEXT_DEFINED_
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext semanage_fcontext_t;
+typedef struct semanage_fcontext_key semanage_fcontext_key_t;
+#define _SEMANAGE_FCONTEXT_DEFINED_
+#endif
+
+/* Key */
+extern int semanage_fcontext_compare(
+	semanage_fcontext_t* fcontext, 
+	semanage_fcontext_key_t* key);
+
+extern int semanage_fcontext_key_create(
+	semanage_handle_t* handle,
+	const char* expr,
+	int type,
+	semanage_fcontext_key_t** key_ptr);
+
+extern int semanage_fcontext_key_extract(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext,
+	semanage_fcontext_key_t** key_ptr);
+
+extern void semanage_fcontext_key_free(
+	semanage_fcontext_key_t* key);
+
+/* Regexp */
+extern const char* semanage_fcontext_get_expr(
+	semanage_fcontext_t* fcontext);
+
+extern int semanage_fcontext_set_expr(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	const char* expr);
+
+/* Type */
+#define SEMANAGE_FCONTEXT_ALL   0
+#define SEMANAGE_FCONTEXT_REG   1
+#define SEMANAGE_FCONTEXT_DIR   2
+#define SEMANAGE_FCONTEXT_CHAR  3
+#define SEMANAGE_FCONTEXT_BLOCK 4
+#define SEMANAGE_FCONTEXT_SOCK  5
+#define SEMANAGE_FCONTEXT_LINK  6
+#define SEMANAGE_FCONTEXT_PIPE  7
+
+extern int semanage_fcontext_get_type(
+	semanage_fcontext_t* fcontext);
+
+extern const char* semanage_fcontext_get_type_str(
+	semanage_fcontext_t* fcontext);
+
+extern void semanage_fcontext_set_type(
+	semanage_fcontext_t* fcontext,
+	int type);
+
+/* Context */
+extern semanage_context_t* semanage_fcontext_get_con(
+	semanage_fcontext_t* fcontext);
+
+extern void semanage_fcontext_set_con(
+	semanage_fcontext_t* fcontext, 
+	semanage_context_t* con);
+
+/* Create/Clone/Destroy */
+extern int semanage_fcontext_create(
+	semanage_handle_t* handle,
+	semanage_fcontext_t** fcontext_ptr);
+
+extern int semanage_fcontext_clone(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	semanage_fcontext_t** fcontext_ptr);
+
+extern void semanage_fcontext_free(
+	semanage_fcontext_t* fcontext);
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontexts_local.h new/libsemanage/include/semanage/fcontexts_local.h
--- old/libsemanage/include/semanage/fcontexts_local.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/fcontexts_local.h	2005-12-26 15:37:06.000000000 -0500
@@ -0,0 +1,54 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_FCONTEXTS_LOCAL_H_
+#define _SEMANAGE_FCONTEXTS_LOCAL_H_
+
+#include <stddef.h>
+#include <semanage/fcontext_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_fcontext_add_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data);
+
+extern int semanage_fcontext_modify_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data);
+
+extern int semanage_fcontext_set_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data);
+
+extern int semanage_fcontext_del_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key);
+
+extern int semanage_fcontext_query_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t** response);
+
+extern int semanage_fcontext_exists_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	int* response);
+
+extern int semanage_fcontext_count_local(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_fcontext_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_fcontext_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_fcontext_list_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-12-26 19:04:15.000000000 -0500
+++ new/libsemanage/include/semanage/semanage.h	2005-12-26 15:55:02.000000000 -0500
@@ -40,6 +40,7 @@
 #include <semanage/booleans_active.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
+#include <semanage/fcontexts_local.h>
 #include <semanage/seusers.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-12-26 19:04:15.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-12-26 18:56:36.000000000 -0500
@@ -36,6 +36,7 @@
 #include "port_internal.h"
 #include "iface_internal.h"
 #include "boolean_internal.h"
+#include "fcontext_internal.h"
 
 #include "debug.h"
 #include "handle.h"
@@ -120,6 +121,9 @@ int semanage_direct_connect(semanage_han
 	if (bool_file_dbase_init(sh, semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
+	if (fcontext_file_dbase_init(sh, semanage_fcontext_dbase_local(sh)) < 0)
+		goto err;
+
 	if (seuser_file_dbase_init(sh, semanage_seuser_dbase(sh)) < 0)
 		goto err;
 
@@ -167,6 +171,7 @@ static int semanage_direct_disconnect(se
 	port_file_dbase_release(semanage_port_dbase_local(sh));
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
+	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
 	seuser_file_dbase_release(semanage_seuser_dbase(sh));
 
 	user_policydb_dbase_release(semanage_user_dbase_policy(sh));
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_internal.h new/libsemanage/src/fcontext_internal.h
--- old/libsemanage/src/fcontext_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/fcontext_internal.h	2005-12-26 18:25:04.000000000 -0500
@@ -0,0 +1,22 @@
+#ifndef _SEMANAGE_FCONTEXT_INTERNAL_H_
+#define _SEMANAGE_FCONTEXT_INTERNAL_H_
+
+#include <semanage/fcontext_record.h>
+#include <semanage/fcontexts_local.h>
+#include "database.h"
+#include "handle.h"
+#include "dso.h"
+
+/* TODO: hidden prototypes */
+
+/* FCONTEXT RECORD: metod table */
+extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
+
+extern int fcontext_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void fcontext_file_dbase_release(
+	dbase_config_t* dconfig);
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2005-12-26 16:10:25.000000000 -0500
@@ -0,0 +1,220 @@
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext record_t;
+typedef struct semanage_fcontext_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include "fcontext_internal.h"
+#include "context_internal.h"
+#include "debug.h"
+
+struct semanage_fcontext {
+
+	/* Matching expression */
+	char* expr; 
+	
+	/* Type of object */
+	int type;
+
+	/* Context */
+	semanage_context_t* con;
+};
+
+struct semanage_fcontext_key {
+
+	/* Matching expression */
+	const char* expr;
+
+	/* Type of object */
+	int type;
+};
+
+/* Key */
+int semanage_fcontext_key_create(
+	semanage_handle_t* handle,
+	const char* expr,
+	int type,
+	semanage_fcontext_key_t** key_ptr) {
+
+	semanage_fcontext_key_t* tmp_key = 
+		(semanage_fcontext_key_t*) malloc(sizeof(semanage_fcontext_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not "
+			"create file context key");
+		return STATUS_ERR;
+	}
+	tmp_key->expr = expr;
+	tmp_key->type = type;	
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+int semanage_fcontext_key_extract(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	semanage_fcontext_key_t** key_ptr) {
+
+	if (semanage_fcontext_key_create(handle, fcontext->expr, 
+		fcontext->type, key_ptr) < 0) {
+		ERR(handle, "could not extract key from "
+			"file context %s (%s)", fcontext->expr, 
+			semanage_fcontext_get_type_str(fcontext));
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+void semanage_fcontext_key_free(semanage_fcontext_key_t* key) {
+	free(key);
+}
+
+int semanage_fcontext_compare(
+	semanage_fcontext_t* fcontext, 
+	semanage_fcontext_key_t* key) {
+
+	return strcmp(fcontext->expr, key->expr) && 
+		(fcontext->type == key->type);
+}
+
+/* Create */
+int semanage_fcontext_create(
+	semanage_handle_t* handle,
+	semanage_fcontext_t** fcontext) {
+
+	semanage_fcontext_t* tmp_fcontext = 
+		(semanage_fcontext_t*) malloc(sizeof(semanage_fcontext_t));
+
+        if (!tmp_fcontext) {
+		ERR(handle, "out of memory, could not create "
+			"file context record");
+		return STATUS_ERR;
+	}
+
+	tmp_fcontext->expr = NULL;
+	tmp_fcontext->type = SEMANAGE_FCONTEXT_ALL;
+	tmp_fcontext->con = NULL;
+	*fcontext = tmp_fcontext;	
+
+	return STATUS_SUCCESS;
+}
+
+/* Regexp */
+const char* semanage_fcontext_get_expr(semanage_fcontext_t* fcontext) {
+	return fcontext->expr;
+}
+
+int semanage_fcontext_set_expr(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	const char* expr) {
+
+	char* tmp_expr = strdup(expr);
+	if (!tmp_expr) {
+		ERR(handle, "out of memory, "
+			"could not set regexp string");
+		return STATUS_ERR;
+	}
+	free(fcontext->expr);
+	fcontext->expr = tmp_expr;
+	return STATUS_SUCCESS;
+}
+
+/* Type */
+int semanage_fcontext_get_type(semanage_fcontext_t* fcontext) {
+	return fcontext->type;
+}
+
+const char* semanage_fcontext_get_type_str(semanage_fcontext_t* fcontext) {
+	switch (fcontext->type) {
+		default:
+		case SEMANAGE_FCONTEXT_ALL:
+			return "all files";
+		case SEMANAGE_FCONTEXT_REG:
+			return "regular file";
+		case SEMANAGE_FCONTEXT_DIR:
+			return "directory";
+		case SEMANAGE_FCONTEXT_CHAR:
+			return "character device";
+		case SEMANAGE_FCONTEXT_BLOCK:
+			return "block device";
+		case SEMANAGE_FCONTEXT_SOCK:
+			return "socket";
+		case SEMANAGE_FCONTEXT_LINK:
+			return "symbolic link";
+		case SEMANAGE_FCONTEXT_PIPE:
+			return "named pipe";
+	}
+}
+
+void semanage_fcontext_set_type(
+	semanage_fcontext_t* fcontext,
+	int type) {
+
+	fcontext->type = type;
+}
+
+/* Context */
+semanage_context_t* semanage_fcontext_get_con(semanage_fcontext_t* fcontext) {
+	return fcontext->con;
+}
+
+void semanage_fcontext_set_con(
+	semanage_fcontext_t* fcontext, 
+	semanage_context_t* con) {
+
+	semanage_context_free(fcontext->con);
+	fcontext->con = con;
+}
+
+/* Deep copy clone */
+int semanage_fcontext_clone(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	semanage_fcontext_t** fcontext_ptr) {
+
+	semanage_fcontext_t* new_fcontext = NULL;
+	if (semanage_fcontext_create(handle, &new_fcontext) < 0)
+		goto err;
+
+	if (semanage_fcontext_set_expr(handle, new_fcontext, fcontext->expr) < 0)
+		goto err;
+
+	new_fcontext->type = fcontext->type;
+
+	if (fcontext->con &&
+	   (semanage_context_clone(handle, fcontext->con, &new_fcontext->con) < 0))
+		goto err;
+
+	*fcontext_ptr = new_fcontext;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not clone file context record");
+	semanage_fcontext_free(new_fcontext);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void semanage_fcontext_free(semanage_fcontext_t* fcontext) {
+	if (!fcontext)
+		return;
+
+	free(fcontext->expr);
+	semanage_context_free(fcontext->con);
+	free(fcontext);
+}
+
+/* Record base functions */
+record_table_t SEMANAGE_FCONTEXT_RTABLE = {
+	.create      = semanage_fcontext_create,
+	.key_extract = semanage_fcontext_key_extract,
+	.key_free    = semanage_fcontext_key_free,
+	.clone       = semanage_fcontext_clone,
+	.compare     = semanage_fcontext_compare,
+	.free        = semanage_fcontext_free,
+};
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_file.c new/libsemanage/src/fcontexts_file.c
--- old/libsemanage/src/fcontexts_file.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/fcontexts_file.c	2005-12-26 18:55:54.000000000 -0500
@@ -0,0 +1,185 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext record_t;
+typedef struct semanage_fcontext_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED 
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "fcontext_internal.h"
+#include "context_internal.h"
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+
+static const char* type_str(int type) {
+	switch (type) {
+		default:
+		case SEMANAGE_FCONTEXT_ALL:
+			return "  ";
+		case SEMANAGE_FCONTEXT_REG:
+			return "--";
+		case SEMANAGE_FCONTEXT_DIR:
+			return "-d";
+		case SEMANAGE_FCONTEXT_CHAR:
+			return "-c";
+		case SEMANAGE_FCONTEXT_BLOCK:
+			return "-b";
+		case SEMANAGE_FCONTEXT_SOCK:
+			return "-s";
+		case SEMANAGE_FCONTEXT_LINK:
+			return "-l";
+		case SEMANAGE_FCONTEXT_PIPE:
+			return "-p";
+	}
+}
+
+static int fcontext_print(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext, 
+	FILE* str) {
+
+	char* con_str = NULL;
+
+	const char* expr = semanage_fcontext_get_expr(fcontext);
+	const char* type = type_str(semanage_fcontext_get_type(fcontext));
+	semanage_context_t* con = semanage_fcontext_get_con(fcontext);
+
+	if (fprintf(str, "%s %s ", expr, type) < 0)
+		goto err;
+
+	if (con != NULL) {
+		if (semanage_context_to_string(handle, con, &con_str) < 0)
+			goto err;
+		if (fprintf(str, "%s\n", con_str) < 0)
+			goto err;
+		free(con_str);
+		con_str = NULL;
+	} else { 
+		if (fprintf(str, "<<none>>\n") < 0)
+			goto err;
+	}
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not print file context "
+		"%s (%s) to stream", expr, type);
+	free(con_str);
+	return STATUS_ERR;
+}
+
+static int fcontext_parse(
+	semanage_handle_t* handle,
+	parse_info_t* info, 
+	semanage_fcontext_t* fcontext) {
+
+	char* str = NULL;
+	semanage_context_t* con = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+	
+	/* Regexp */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;		
+	if (semanage_fcontext_set_expr(handle, fcontext, str)  < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+        /* Type */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (!strcasecmp(str, "-s"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_SOCK);
+	else if (!strcasecmp(str, "-p"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_PIPE);
+	else if (!strcasecmp(str, "-b"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_BLOCK);
+	else if (!strcasecmp(str, "-l"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_LINK);
+	else if (!strcasecmp(str, "-c"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_CHAR);
+	else if (!strcasecmp(str, "-d"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_DIR);
+	else if (!strcasecmp(str, "--"))
+		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_REG);
+	else
+		goto process_context;
+        free(str);
+        str = NULL;
+
+	/* Context */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	
+	process_context:
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+			str, info->filename, info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
+
+	semanage_fcontext_set_con(fcontext, con);
+	con = NULL;	
+
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+	err:
+	ERR(handle, "could not parse file context record");
+	free(str);
+	semanage_context_free(con);
+	parse_dispose_line(info);
+	return STATUS_ERR;
+}
+
+/* FCONTEXT RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
+	.parse       = fcontext_parse,
+	.print       = fcontext_print,
+};
+
+int fcontext_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+	
+	if (dbase_file_init(
+		handle, 
+		"file_contexts.local",
+		&SEMANAGE_FCONTEXT_RTABLE,
+		&SEMANAGE_FCONTEXT_FILE_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void fcontext_file_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(dconfig->dbase);
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/fcontexts_local.c	2005-12-26 15:37:28.000000000 -0500
@@ -0,0 +1,92 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext_key record_key_t;
+typedef struct semanage_fcontext record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stddef.h>
+#include "fcontext_internal.h"
+#include "handle.h" 
+#include "database.h"
+
+int semanage_fcontext_add_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_add(handle, dconfig, key, data);
+}
+
+int semanage_fcontext_modify_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);	
+	return dbase_modify(handle, dconfig, key, data);
+}
+
+int semanage_fcontext_set_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t* data) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);	
+	return dbase_set(handle, dconfig, key, data);
+}
+
+int semanage_fcontext_del_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_del(handle, dconfig, key);
+}
+
+int semanage_fcontext_query_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	semanage_fcontext_t** response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_fcontext_exists_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_fcontext_count_local(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_fcontext_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_fcontext_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_fcontext_list_local(
+	semanage_handle_t* handle,
+	semanage_fcontext_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_list(handle, dconfig, records, count);
+}
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-12-26 19:04:16.000000000 -0500
+++ new/libsemanage/src/handle.h	2005-12-26 15:40:37.000000000 -0500
@@ -77,20 +77,21 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      10
+#define DBASE_COUNT      11
 
 #define DBASE_LOCAL_USERS       0
 #define DBASE_LOCAL_PORTS       1
 #define DBASE_LOCAL_INTERFACES  2
 #define DBASE_LOCAL_BOOLEANS    3
-#define DBASE_SEUSERS           4
+#define DBASE_LOCAL_FCONTEXTS	4
+#define DBASE_SEUSERS           5
 
-#define DBASE_POLICY_USERS      5
-#define DBASE_POLICY_PORTS      6
-#define DBASE_POLICY_INTERFACES 7
-#define DBASE_POLICY_BOOLEANS   8
+#define DBASE_POLICY_USERS      6
+#define DBASE_POLICY_PORTS      7
+#define DBASE_POLICY_INTERFACES 8
+#define DBASE_POLICY_BOOLEANS   9
 
-#define DBASE_ACTIVE_BOOLEANS   9
+#define DBASE_ACTIVE_BOOLEANS   10
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -115,6 +116,11 @@ dbase_config_t* semanage_bool_dbase_loca
 }
 
 static inline
+dbase_config_t* semanage_fcontext_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_FCONTEXTS];
+}
+
+static inline
 dbase_config_t* semanage_seuser_dbase(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_SEUSERS];
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-12-26 19:04:16.000000000 -0500
+++ new/libsemanage/src/libsemanage.map	2005-12-26 15:41:09.000000000 -0500
@@ -11,5 +11,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
+	  semanage_fcontext_*;
   local: *;
 };
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-12-26 19:04:16.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-12-26 15:41:16.000000000 -0500
@@ -188,6 +188,7 @@ int semanage_commit_components(
 		semanage_bool_dbase_local(handle),
 		semanage_user_dbase_local(handle),
 		semanage_port_dbase_local(handle),
+		semanage_fcontext_dbase_local(handle),
 		semanage_seuser_dbase(handle),
 		semanage_bool_dbase_active(handle),
 	};
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2005-12-26 19:04:16.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2005-12-26 15:45:49.000000000 -0500
@@ -38,6 +38,8 @@
 	#include "semanage/ports_local.h"
 	#include "semanage/ports_policy.h"
 	#include "semanage/seuser_record.h"
+	#include "semanage/fcontext_record.h"
+	#include "semanage/fcontexts_local.h"
 	#include "semanage/seusers.h"	
 	#include "semanage/semanage.h"
 %}
@@ -141,6 +143,34 @@
 	$1 = &temp;
 }
 
+/** fcontext typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_fcontext_t *** parameter */
+%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_fcontext_t *** {
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_fcontext, 0));
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_fcontext_t ** {
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext, 0));
+}
+
+%typemap(argout) semanage_fcontext_key_t ** {
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp) {
+        $1 = &temp;
+}
+
 /** interface typemaps **/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
@@ -271,6 +301,8 @@
 %include "../include/semanage/port_record.h"
 %include "../include/semanage/ports_local.h"
 %include "../include/semanage/ports_policy.h"
+%include "../include/semanage/fcontext_record.h"
+%include "../include/semanage/fcontexts_local.h"
 %include "../include/semanage/seuser_record.h"
 %include "../include/semanage/seusers.h"
 %include "../include/semanage/semanage.h"

--------------090108090005000908070801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
