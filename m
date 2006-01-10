Message-ID: <43C33ECB.2020608@cornell.edu>
Date: Mon, 09 Jan 2006 21:57:47 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] User extra data (part 1)
Content-Type: multipart/mixed;
 boundary="------------010609020107040408060203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010609020107040408060203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch begins to solve the ROLE expansion problem in genhomedircon.
It adds a user_extra record, which will store "extra data", which is 
data that doesn't go into policy, keyed on the selinux user (the key is 
shared).

Currently this record contains only a (name, prefix) pair. It is backed 
by a flat file instantiated 3 times - users_extra.system 
(distro-shipped), users_extra.local (local modifications), and 
users_extra (stacked). The first two get merged into the third.

The format is similar to the SELinux user format, since I thought this 
format is more change-friendly, unlike the seusers format. Format is: 
user %s prefix %s ; (multiline and random space layout is fine, as usual).
========

No validation is currently done on the user field (todo).
No APIs are exposed, everything is static or hidden - this is 
deliberate, because I haven't decided what APIs need to be exposed. In 
particular, I haven't given up on the idea of implementing a join. This 
record should not exist from the outside user's point of view - the user 
does not/should not care that the data goes into two different data 
backends - it's keyed on the same thing, and should be accessible 
together. I will continue working on a join a bit more, and if it 
doesn't work out, we can just expose this record.

Another issue is how users_extra.system will be updated. Joshua, do you 
have any suggestions?

--------------010609020107040408060203
Content-Type: text/x-patch;
 name="libsemanage.user_extra1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.user_extra1.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-06 08:41:43.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-09 21:22:58.000000000 -0700
@@ -113,6 +113,10 @@ int semanage_direct_connect(semanage_han
 	if (user_file_dbase_init(sh, semanage_user_dbase_local(sh)) < 0)
 		goto err;
 
+	if (user_extra_file_dbase_init(sh, "users_extra.local",
+		semanage_user_extra_dbase_local(sh)) < 0)
+		goto err;
+
 	if (port_file_dbase_init(sh, semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
@@ -129,9 +133,17 @@ int semanage_direct_connect(semanage_han
 	if (seuser_file_dbase_init(sh, semanage_seuser_dbase(sh)) < 0)
 		goto err;
 
+	if (user_extra_file_dbase_init(sh, "users_extra.system",
+		semanage_user_extra_dbase_system(sh)) < 0)
+		goto err;
+
 	if (user_policydb_dbase_init(sh, semanage_user_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (user_extra_file_dbase_init(sh, "users_extra", 
+		semanage_user_extra_dbase_policy(sh)) < 0)
+		goto err;
+
 	if (port_policydb_dbase_init(sh, semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -174,13 +186,17 @@ static int semanage_direct_disconnect(se
 
 	/* Remove object databases */
 	user_file_dbase_release(semanage_user_dbase_local(sh));
+	user_extra_file_dbase_release(semanage_user_extra_dbase_local(sh));
 	port_file_dbase_release(semanage_port_dbase_local(sh));
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
 	seuser_file_dbase_release(semanage_seuser_dbase(sh));
 
+	user_extra_file_dbase_release(semanage_user_extra_dbase_system(sh));
+
 	user_policydb_dbase_release(semanage_user_dbase_policy(sh));
+	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
 	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/handle.h	2006-01-09 21:20:26.000000000 -0700
@@ -77,22 +77,30 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      12
+#define DBASE_COUNT      15
 
+/* Local modifications */
 #define DBASE_LOCAL_USERS       0
-#define DBASE_LOCAL_PORTS       1
-#define DBASE_LOCAL_INTERFACES  2
-#define DBASE_LOCAL_BOOLEANS    3
-#define DBASE_LOCAL_FCONTEXTS	4
-#define DBASE_SEUSERS           5
-
-#define DBASE_POLICY_USERS      6
-#define DBASE_POLICY_PORTS      7
-#define DBASE_POLICY_INTERFACES 8
-#define DBASE_POLICY_BOOLEANS   9
-#define DBASE_POLICY_FCONTEXTS  10
+#define DBASE_LOCAL_USERS_EXTRA 1
+#define DBASE_LOCAL_PORTS       2
+#define DBASE_LOCAL_INTERFACES  3
+#define DBASE_LOCAL_BOOLEANS    4
+#define DBASE_LOCAL_FCONTEXTS	5
+#define DBASE_SEUSERS           6
+
+/* Policy */
+#define DBASE_SYSTEM_USERS_EXTRA 7
+
+/* Policy + Local modifications */
+#define DBASE_POLICY_USERS       8
+#define DBASE_POLICY_USERS_EXTRA 9
+#define DBASE_POLICY_PORTS       10
+#define DBASE_POLICY_INTERFACES  11
+#define DBASE_POLICY_BOOLEANS    12
+#define DBASE_POLICY_FCONTEXTS   13
 
-#define DBASE_ACTIVE_BOOLEANS   11
+/* Active kernel policy */
+#define DBASE_ACTIVE_BOOLEANS    14
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -101,6 +109,11 @@ dbase_config_t* semanage_user_dbase_loca
 	return &handle->dbase[DBASE_LOCAL_USERS];
 }
 
+static inline
+dbase_config_t* semanage_user_extra_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_USERS_EXTRA];
+}
+
 static inline 
 dbase_config_t* semanage_port_dbase_local(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_LOCAL_PORTS];
@@ -127,11 +140,21 @@ dbase_config_t* semanage_seuser_dbase(se
 }
 
 static inline
+dbase_config_t* semanage_user_extra_dbase_system(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_SYSTEM_USERS_EXTRA];
+}
+
+static inline
 dbase_config_t* semanage_user_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_USERS];
 }
 
 static inline
+dbase_config_t* semanage_user_extra_dbase_policy(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_POLICY_USERS_EXTRA];
+}
+
+static inline
 dbase_config_t* semanage_port_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_PORTS];
 }
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-09 21:25:24.000000000 -0700
@@ -122,11 +122,21 @@ int semanage_base_merge_components(
 	semanage_handle_t* handle) {
 
 	int i;
+
+	/* Order is important here - change things carefully.
+	 * System components first, local next. Verify runs with 
+	 * mutual dependencies are ran after everything is merged */
 	load_table_t components[] = {
 
 		{ semanage_user_dbase_local(handle),
 		  semanage_user_dbase_policy(handle), MODE_MODIFY },
 
+		{ semanage_user_extra_dbase_system(handle),
+		  semanage_user_extra_dbase_policy(handle), MODE_MODIFY },
+
+		{ semanage_user_extra_dbase_local(handle),
+		  semanage_user_extra_dbase_policy(handle), MODE_MODIFY },
+
 		{ semanage_port_dbase_local(handle),
 		  semanage_port_dbase_policy(handle), MODE_MODIFY },
 
@@ -181,10 +191,11 @@ int semanage_commit_components(
 
 	int i;
 	dbase_config_t* components[] = {
-		/* semanage_modules_dbase(handle), */
 		semanage_iface_dbase_local(handle),
 		semanage_bool_dbase_local(handle),
 		semanage_user_dbase_local(handle),
+		semanage_user_extra_dbase_local(handle),
+		semanage_user_extra_dbase_policy(handle),
 		semanage_port_dbase_local(handle),
 		semanage_fcontext_dbase_local(handle),
 		semanage_fcontext_dbase_policy(handle),
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/seusers_file.c	2006-01-09 21:07:47.000000000 -0700
@@ -12,13 +12,11 @@ typedef struct dbase_file dbase_t;
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <strings.h>
 
 #include "seuser_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
-#include "semanage_store.h"
 #include "handle.h"
 
 static int seuser_print(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_extra_record.c new/libsemanage/src/user_extra_record.c
--- old/libsemanage/src/user_extra_record.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/user_extra_record.c	2006-01-09 21:32:42.000000000 -0700
@@ -0,0 +1,176 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+/* Object: semanage_user_extra_t (Unix User)
+ * Object: semanage_user_extra_key_t (Unix User Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
+struct semanage_user_extra;
+struct semanage_user_extra_key;
+typedef struct semanage_user_extra record_t;
+typedef struct semanage_user_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+#include <semanage/handle.h>
+#include <stdlib.h>
+#include <string.h>
+#include "user_internal.h"
+#include "debug.h"
+#include "database.h"
+
+struct semanage_user_extra {
+	/* This user's name */
+	char* name;
+
+	/* Labeling prefix */
+	char* prefix;
+};
+
+static int semanage_user_extra_key_extract(
+	semanage_handle_t* handle,
+	const semanage_user_extra_t* user_extra, 
+	semanage_user_key_t** key_ptr) {
+
+	if (semanage_user_key_create(handle, user_extra->name, key_ptr) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not extract key from user extra record");
+	return STATUS_ERR;
+}	
+
+static int semanage_user_extra_compare(
+	const semanage_user_extra_t* user_extra,
+	const semanage_user_key_t* key) {
+
+	const char* name;
+	semanage_user_key_unpack(key, &name);
+	return strcmp(user_extra->name, name);	
+}
+
+static int semanage_user_extra_compare2(
+	const semanage_user_extra_t* user_extra,
+	const semanage_user_extra_t* user_extra2) {
+
+	return strcmp(user_extra->name, user_extra2->name);
+}
+
+/* Name */
+hidden const char* semanage_user_extra_get_name(
+	const semanage_user_extra_t* user_extra) {
+
+	return user_extra->name;
+}
+
+hidden int semanage_user_extra_set_name(
+	semanage_handle_t* handle,
+	semanage_user_extra_t* user_extra, 
+	const char* name) {
+
+	char* tmp_name = strdup(name);
+	if (!tmp_name) {
+		ERR(handle, "out of memory, could not set name %s "
+			"for user extra data", name);
+		return STATUS_ERR;
+	}
+	free(user_extra->name);
+	user_extra->name = tmp_name;
+	return STATUS_SUCCESS;
+}
+
+/* Labeling prefix */
+hidden const char* semanage_user_extra_get_prefix(
+	const semanage_user_extra_t* user_extra) {
+
+	return user_extra->prefix;
+}
+
+hidden int semanage_user_extra_set_prefix(
+	semanage_handle_t* handle,
+	semanage_user_extra_t* user_extra,
+	const char* prefix) {
+
+	char* tmp_prefix = strdup(prefix);
+	if (!tmp_prefix) {
+		ERR(handle, "out of memory, could not set prefix %s "
+			"for user %s", prefix, user_extra->name);
+		return STATUS_ERR;
+	}
+	free(user_extra->prefix);
+	user_extra->prefix = tmp_prefix;
+	return STATUS_SUCCESS;
+}
+
+/* Create */
+static int semanage_user_extra_create(
+	semanage_handle_t* handle,
+	semanage_user_extra_t** user_extra_ptr) {
+
+	semanage_user_extra_t* user_extra = 
+		(semanage_user_extra_t*) malloc(sizeof (semanage_user_extra_t));
+
+        if (!user_extra) {
+		ERR(handle, "out of memory, could not "
+			"create user extra data record");
+		return STATUS_ERR;
+	}
+
+        user_extra->name = NULL;
+	user_extra->prefix = NULL;
+	
+	*user_extra_ptr = user_extra;
+	return STATUS_SUCCESS;
+}
+
+/* Destroy */
+static void semanage_user_extra_free(
+	semanage_user_extra_t* user_extra) {
+
+	if (!user_extra)
+		return;
+
+	free(user_extra->name);
+	free(user_extra->prefix);
+	free(user_extra);
+}
+
+/* Deep copy clone */
+static int semanage_user_extra_clone(
+	semanage_handle_t* handle,
+	const semanage_user_extra_t* user_extra, 
+	semanage_user_extra_t** user_extra_ptr) {
+
+	semanage_user_extra_t* new_user_extra = NULL;
+
+	if (semanage_user_extra_create(handle, &new_user_extra) < 0)
+		goto err;
+
+	if (semanage_user_extra_set_name(handle, new_user_extra, user_extra->name) < 0)
+		goto err;
+
+	if (semanage_user_extra_set_prefix(handle, new_user_extra, user_extra->prefix) < 0)
+		goto err;
+
+	*user_extra_ptr = new_user_extra;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not clone extra data for user %s", 
+		user_extra->name);
+	semanage_user_extra_free(new_user_extra);
+	return STATUS_ERR;
+}
+
+/* Record base functions */
+record_table_t SEMANAGE_USER_EXTRA_RTABLE = {
+	.create      = semanage_user_extra_create,
+	.key_extract = semanage_user_extra_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_extra_clone,
+	.compare     = semanage_user_extra_compare,
+	.compare2    = semanage_user_extra_compare2,
+	.free        = semanage_user_extra_free,
+};
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2006-01-06 07:36:31.000000000 -0700
+++ new/libsemanage/src/user_internal.h	2006-01-09 21:30:28.000000000 -0700
@@ -27,9 +27,13 @@ hidden_proto(semanage_user_set_name)
 hidden_proto(semanage_user_exists)
 hidden_proto(semanage_user_query)
 
-/* USER RECORD: metod table */
+/* USER record: metod table */
 extern record_table_t SEMANAGE_USER_RTABLE;
 
+/* USER EXTRA record: method table */
+extern record_table_t SEMANAGE_USER_EXTRA_RTABLE;
+
+/* USER record, FILE backend */
 extern int user_file_dbase_init(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
@@ -37,6 +41,16 @@ extern int user_file_dbase_init(
 extern void user_file_dbase_release(
 	dbase_config_t* dconfig);
 
+/* USER EXTRA record, FILE backend */
+extern int user_extra_file_dbase_init(
+	semanage_handle_t* handle,
+	const char* fname,
+	dbase_config_t* dconfig);
+
+extern void user_extra_file_dbase_release(
+	dbase_config_t* dconfig);
+
+/* USER record, POLICYDB backend */
 extern int user_policydb_dbase_init(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig);
@@ -44,4 +58,29 @@ extern int user_policydb_dbase_init(
 extern void user_policydb_dbase_release(
 	dbase_config_t* dconfig);
 
+/* Internal use */
+
+struct semanage_user_extra;
+typedef struct semanage_user_extra semanage_user_extra_t;
+
+hidden void semanage_user_key_unpack(
+	const semanage_user_key_t* key,
+	const char** name);
+
+hidden const char* semanage_user_extra_get_name(
+	const semanage_user_extra_t* user_extra);
+
+hidden int semanage_user_extra_set_name(
+	semanage_handle_t* handle,
+	semanage_user_extra_t* user_extra,
+	const char* name);
+
+hidden const char* semanage_user_extra_get_prefix(
+	const semanage_user_extra_t* user_extra);
+
+hidden int semanage_user_extra_set_prefix(
+	semanage_handle_t* handle,
+	semanage_user_extra_t* user_extra,
+	const char* prefix);
+
 #endif
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-06 07:36:31.000000000 -0700
+++ new/libsemanage/src/user_record.c	2006-01-09 21:30:40.000000000 -0700
@@ -49,6 +49,13 @@ void semanage_user_key_free(
 }
 hidden_def(semanage_user_key_free)
 
+hidden void semanage_user_key_unpack(
+	const semanage_user_key_t* key,
+	const char** name) {
+
+	sepol_user_key_unpack(key, name);
+}
+
 int semanage_user_compare(
 	const semanage_user_t* user, 
 	const semanage_user_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_extra_file.c new/libsemanage/src/users_extra_file.c
--- old/libsemanage/src/users_extra_file.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/users_extra_file.c	2006-01-09 21:38:20.000000000 -0700
@@ -0,0 +1,130 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_user_extra;
+struct semanage_user_key;
+typedef struct semanage_user_extra record_t;
+typedef struct semanage_user_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+
+#include "user_internal.h"
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+#include "handle.h"
+
+static int user_extra_print(
+	semanage_handle_t* handle,
+	semanage_user_extra_t* user_extra, 
+	FILE* str) {
+
+	const char* name = semanage_user_extra_get_name(user_extra);
+	const char* prefix = semanage_user_extra_get_prefix(user_extra);
+
+	if (fprintf(str, "user %s prefix %s;\n", name, prefix) < 0) 
+		goto err;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not print user extra data "
+		"for %s to stream", name);
+	return STATUS_ERR;
+}
+
+static int user_extra_parse(
+	semanage_handle_t* handle,
+	parse_info_t* info, 
+	semanage_user_extra_t* user_extra) {
+
+	char* str = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* User string */
+	if (parse_assert_str(handle, info, "user") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	
+	/* Extract name */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_user_extra_set_name(handle, user_extra, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Prefix string */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_str(handle, info, "prefix") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* Extract prefix */
+	if (parse_fetch_string(handle, info, &str, ';') < 0)
+		goto err;
+	if (semanage_user_extra_set_prefix(handle, user_extra, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Semicolon */
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_ch(handle, info, ';') < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+	err:
+	ERR(handle, "could not parse user extra data");
+	free(str);
+	parse_dispose_line(info);
+	return STATUS_ERR;
+}
+
+/* USER EXTRA RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
+	.parse       = user_extra_parse,
+	.print       = user_extra_print,
+};
+
+int user_extra_file_dbase_init(
+	semanage_handle_t* handle, 
+	const char* fname,
+	dbase_config_t* dconfig) {
+
+	if (dbase_file_init(
+		handle, 
+		fname,
+		&SEMANAGE_USER_EXTRA_RTABLE,
+		&SEMANAGE_USER_EXTRA_FILE_RTABLE,
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_extra_file_dbase_release(
+	dbase_config_t* dconfig) {
+
+	dbase_file_release(dconfig->dbase);
+}

--------------010609020107040408060203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
