Message-ID: <43AB9AEA.6020101@cornell.edu>
Date: Fri, 23 Dec 2005 01:36:26 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fold together internal headers
Content-Type: multipart/mixed;
 boundary="------------080809070805090707070003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080809070805090707070003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch folds _file.h and _policydb.h headers into the _internal.h 
headers, which seems like a good thing - fewer files to deal with...



--------------080809070805090707070003
Content-Type: text/x-patch;
 name="libsemanage3.fold_headers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage3.fold_headers.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2005-12-23 00:51:23.000000000 -0500
@@ -5,6 +5,7 @@
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
 #include "database.h"
+#include "handle.h"
 #include "dso.h"
 
 hidden_proto(semanage_bool_clone)
@@ -21,4 +22,18 @@ hidden_proto(semanage_bool_set_value)
 /* BOOL RECORD: metod table */
 extern record_table_t SEMANAGE_BOOL_RTABLE;
 
+extern int bool_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void bool_file_dbase_release(
+	dbase_config_t* dconfig);
+
+extern int bool_policydb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void bool_policydb_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-12-23 00:53:49.000000000 -0500
@@ -17,7 +17,6 @@ typedef struct dbase_file dbase_t;
 #include <semanage/handle.h>
 #include "boolean_internal.h"
 #include "database_file.h"
-#include "booleans_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_file.h new/libsemanage/src/booleans_file.h
--- old/libsemanage/src/booleans_file.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/booleans_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_BOOLEANS_FILE_H_
-#define _SEMANAGE_BOOLEANS_FILE_H_
-
-#include "database.h"
-#include "handle.h"
-
-int bool_file_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void bool_file_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-12-23 00:53:56.000000000 -0500
@@ -13,7 +13,6 @@ typedef struct dbase_policydb dbase_t;
 #include <sepol/booleans.h>
 #include <semanage/handle.h>
 #include "boolean_internal.h"
-#include "booleans_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policydb.h new/libsemanage/src/booleans_policydb.h
--- old/libsemanage/src/booleans_policydb.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
-#define _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
-
-#include "database.h"
-#include "handle.h"
-
-int bool_policydb_dbase_init(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig);
-
-void bool_policydb_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-11-09 09:52:55.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-12-23 00:52:19.000000000 -0500
@@ -31,15 +31,11 @@
 #include <sys/types.h>
 #include <limits.h>
 
-#include "users_file.h"
-#include "seusers_file.h"
-#include "ports_file.h"
-#include "interfaces_file.h"
-#include "booleans_file.h"
-#include "users_policydb.h"
-#include "ports_policydb.h"
-#include "interfaces_policydb.h"
-#include "booleans_policydb.h"
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "port_internal.h"
+#include "iface_internal.h"
+#include "boolean_internal.h"
 
 #include "debug.h"
 #include "handle.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_internal.h new/libsemanage/src/iface_internal.h
--- old/libsemanage/src/iface_internal.h	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/iface_internal.h	2005-12-23 00:57:19.000000000 -0500
@@ -5,6 +5,7 @@
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
 #include "database.h"
+#include "handle.h"
 #include "dso.h"
 
 hidden_proto(semanage_iface_create)
@@ -23,4 +24,18 @@ hidden_proto(semanage_iface_set_name)
 /* IFACE RECORD: metod table */
 extern record_table_t SEMANAGE_IFACE_RTABLE;
 
+extern int iface_policydb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void iface_policydb_dbase_release(
+	dbase_config_t* dconfig);
+
+extern int iface_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void iface_file_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-12-23 00:57:36.000000000 -0500
@@ -16,7 +16,6 @@ typedef struct dbase_file dbase_t;
 #include "iface_internal.h"
 #include "context_internal.h"
 #include "database_file.h"
-#include "interfaces_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_file.h new/libsemanage/src/interfaces_file.h
--- old/libsemanage/src/interfaces_file.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/interfaces_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_INTERFACES_FILE_H_
-#define _SEMANAGE_INTERFACES_FILE_H_
-
-#include "database.h"
-#include "handle.h"
-
-int iface_file_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void iface_file_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-12-23 00:57:42.000000000 -0500
@@ -13,7 +13,6 @@ typedef struct dbase_policydb dbase_t;
 #include <sepol/interfaces.h>
 #include <semanage/handle.h>
 #include "iface_internal.h"
-#include "interfaces_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policydb.h new/libsemanage/src/interfaces_policydb.h
--- old/libsemanage/src/interfaces_policydb.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
-#define _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
-
-#include "database.h"
-#include "handle.h"
-
-int iface_policydb_dbase_init(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig);
-
-void iface_policydb_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2005-12-14 10:09:27.000000000 -0500
+++ new/libsemanage/src/port_internal.h	2005-12-23 00:53:30.000000000 -0500
@@ -5,6 +5,7 @@
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
 #include "database.h"
+#include "handle.h"
 #include "dso.h"
 
 /* TODO: Hidden prototypes here */
@@ -12,4 +13,18 @@
 /* PORT RECORD: method table */
 extern record_table_t SEMANAGE_PORT_RTABLE;
 
+extern int port_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void port_file_dbase_release(
+	dbase_config_t* dconfig);
+
+extern int port_policydb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void port_policydb_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-12-23 00:54:07.000000000 -0500
@@ -17,7 +17,6 @@ typedef struct dbase_file dbase_t;
 #include "port_internal.h"
 #include "context_internal.h"
 #include "database_file.h"
-#include "ports_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.h new/libsemanage/src/ports_file.h
--- old/libsemanage/src/ports_file.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/ports_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_PORTS_FILE_H_
-#define _SEMANAGE_PORTS_FILE_H_
-
-#include "database.h"
-#include "handle.h"
-
-int port_file_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void port_file_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policydb.h new/libsemanage/src/ports_policydb.h
--- old/libsemanage/src/ports_policydb.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/ports_policydb.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
-#define _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
-
-#include "database.h"
-#include "handle.h"
-
-int port_policydb_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void port_policydb_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2005-12-23 00:58:19.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/seuser_record.h>
 #include <semanage/seusers.h>
 #include "database.h"
+#include "handle.h"
 #include "dso.h"
 
 hidden_proto(semanage_seuser_clone)
@@ -24,4 +25,11 @@ hidden_proto(semanage_seuser_set_sename)
 /* SEUSER RECORD: method table */
 extern record_table_t SEMANAGE_SEUSER_RTABLE;
 
+extern int seuser_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void seuser_file_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-12-23 00:58:31.000000000 -0500
@@ -18,7 +18,6 @@ typedef struct dbase_file dbase_t;
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
-#include "seusers_file.h"
 #include "semanage_store.h"
 #include "handle.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_file.h new/libsemanage/src/seusers_file.h
--- old/libsemanage/src/seusers_file.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/seusers_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_SEUSERS_FILE_H_
-#define _SEMANAGE_SEUSERS_FILE_H_
-
-#include "database.h"
-#include "handle.h"
-
-int seuser_file_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void seuser_file_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/user_internal.h	2005-12-23 00:55:35.000000000 -0500
@@ -5,6 +5,7 @@
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
 #include "database.h"
+#include "handle.h"
 #include "dso.h"
 
 hidden_proto(semanage_user_add_role)
@@ -27,4 +28,18 @@ hidden_proto(semanage_user_set_name)
 /* USER RECORD: metod table */
 extern record_table_t SEMANAGE_USER_RTABLE;
 
+extern int user_file_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void user_file_dbase_release(
+	dbase_config_t* dconfig);
+
+extern int user_policydb_dbase_init(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+extern void user_policydb_dbase_release(
+	dbase_config_t* dconfig);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-12-23 00:55:57.000000000 -0500
@@ -17,7 +17,6 @@ typedef struct dbase_file dbase_t;
 #include <semanage/handle.h>
 #include "user_internal.h"
 #include "database_file.h"
-#include "users_file.h"
 #include "parse_utils.h"
 #include "debug.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/users_file.h new/libsemanage/src/users_file.h
--- old/libsemanage/src/users_file.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/users_file.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_USERS_FILE_H_
-#define _SEMANAGE_USERS_FILE_H_
-
-#include "database.h"
-#include "handle.h"
-
-int user_file_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void user_file_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-12-23 00:55:50.000000000 -0500
@@ -13,7 +13,6 @@ typedef struct dbase_policydb dbase_t;
 #include <sepol/users.h>
 #include <semanage/handle.h>
 #include "user_internal.h"
-#include "users_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policydb.h new/libsemanage/src/users_policydb.h
--- old/libsemanage/src/users_policydb.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/users_policydb.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,16 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
-#define _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
-
-#include "database.h"
-#include "handle.h"
-
-int user_policydb_dbase_init(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig);
-
-void user_policydb_dbase_release(
-	dbase_config_t* dconfig);
-
-#endif

--------------080809070805090707070003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
