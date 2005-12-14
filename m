Message-ID: <439FCDA2.2000504@cornell.edu>
Date: Wed, 14 Dec 2005 02:45:38 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Further header cleanups
Content-Type: multipart/mixed;
 boundary="------------010608040509070801090304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010608040509070801090304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Complete changes began by previous patch(es) (things that were missed):

The internal header should not precede polymorphic definition in:
user_record.c
seuser_record.c
iface_record.c
boolean_record.c

Include guards added for:
context_internal.h

typedef define guard added for:
port_record.h
(and include port_internal.h in port_record.c)
=========
Then... move all extern declarations of the record method table
into the internal header where they belong - that requires including
database.h, but that's okay, because the previous patches fixed
issues relating to that.

--------------010608040509070801090304
Content-Type: text/x-patch;
 name="libsemanage.further_headers_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.further_headers_cleanup.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/include/semanage/port_record.h	2005-12-14 02:12:39.000000000 -0500
@@ -6,10 +6,13 @@
 #include <semanage/context_record.h>
 #include <semanage/handle.h>
 
+#ifndef _SEMANAGE_PORT_DEFINED_
 struct semanage_port;
 struct semanage_port_key;
 typedef struct semanage_port semanage_port_t;
 typedef struct semanage_port_key semanage_port_key_t;
+#define _SEMANAGE_PORT_DEFINED_
+#endif
 
 #define SEMANAGE_PROTO_UDP 0 
 #define SEMANAGE_PROTO_TCP 1
diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2005-12-14 02:21:47.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/boolean_record.h>
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
+#include "database.h"
 #include "dso.h"
 
 hidden_proto(semanage_bool_clone)
@@ -17,4 +18,7 @@ hidden_proto(semanage_bool_key_free)
 hidden_proto(semanage_bool_set_name)
 hidden_proto(semanage_bool_set_value)
 
+/* BOOL RECORD: metod table */
+extern record_table_t SEMANAGE_BOOL_RTABLE;
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2005-12-14 02:18:33.000000000 -0500
@@ -4,14 +4,13 @@
 
 typedef sepol_bool_t semanage_bool_t;
 typedef sepol_bool_key_t semanage_bool_key_t;
-
 #define _SEMANAGE_BOOL_DEFINED_
-#include "boolean_internal.h"
 
 typedef semanage_bool_t record_t;
 typedef semanage_bool_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include "boolean_internal.h"
 #include "handle.h"
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-12-14 02:04:50.000000000 -0500
@@ -103,9 +103,6 @@ static int bool_parse(
 	return STATUS_ERR;
 }
 
-/* BOOL RECORD: metod table (boolean_record.c) */
-extern record_table_t SEMANAGE_BOOL_RTABLE;
-
 /* BOOL RECORD: FILE extension: method table */
 record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
 	.parse       = bool_parse,
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-12-14 02:04:57.000000000 -0500
@@ -17,9 +17,6 @@ typedef struct dbase_policydb dbase_t;
 #include "debug.h"
 #include "database_policydb.h"
 
-/* BOOL RECORD: metod table (boolean_record.c) */
-extern record_table_t SEMANAGE_BOOL_RTABLE;
-
 /* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
 	.add         = NULL, 
diff -Naurp --exclude-from excludes old/libsemanage/src/context_internal.h new/libsemanage/src/context_internal.h
--- old/libsemanage/src/context_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/context_internal.h	2005-12-14 02:08:42.000000000 -0500
@@ -1,6 +1,11 @@
+#ifndef _SEMANAGE_CONTEXT_INTERNAL_H_
+#define _SEMANAGE_CONTEXT_INTERNAL_H_
+
 #include <semanage/context_record.h>
 #include "dso.h"
 
 hidden_proto(semanage_context_free)
 hidden_proto(semanage_context_from_string)
 hidden_proto(semanage_context_to_string)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_internal.h new/libsemanage/src/iface_internal.h
--- old/libsemanage/src/iface_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/iface_internal.h	2005-12-14 02:21:39.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/iface_record.h>
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
+#include "database.h"
 #include "dso.h"
 
 hidden_proto(semanage_iface_create)
@@ -19,4 +20,7 @@ hidden_proto(semanage_iface_set_ifcon)
 hidden_proto(semanage_iface_set_msgcon)
 hidden_proto(semanage_iface_set_name)
 
+/* IFACE RECORD: metod table */
+extern record_table_t SEMANAGE_IFACE_RTABLE;
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2005-12-14 02:18:21.000000000 -0500
@@ -6,15 +6,14 @@
 typedef sepol_context_t semanage_context_t;
 typedef sepol_iface_t semanage_iface_t;
 typedef sepol_iface_key_t semanage_iface_key_t;
-
 #define _SEMANAGE_CONTEXT_DEFINED_
 #define _SEMANAGE_IFACE_DEFINED_
-#include "iface_internal.h"
 
 typedef sepol_iface_t record_t;
 typedef sepol_iface_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include "iface_internal.h"
 #include "handle.h"
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-12-14 02:03:59.000000000 -0500
@@ -144,9 +144,6 @@ static int iface_parse(
 	return STATUS_ERR;
 }
 
-/* IFACE RECORD: metod table (iface_record.c) */
-extern record_table_t SEMANAGE_IFACE_RTABLE;
-
 /* IFACE RECORD: FILE extension: method table */
 record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
 	.parse       = iface_parse,
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-12-14 02:04:07.000000000 -0500
@@ -17,9 +17,6 @@ typedef struct dbase_policydb dbase_t;
 #include "debug.h"
 #include "database_policydb.h"
 
-/* IFACE RECORD: metod table (iface_record.c) */
-extern record_table_t SEMANAGE_IFACE_RTABLE;
-
 /* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
 	.add         = NULL,
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/port_internal.h	2005-12-14 02:21:29.000000000 -0500
@@ -4,8 +4,12 @@
 #include <semanage/port_record.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
+#include "database.h"
 #include "dso.h"
 
 /* TODO: Hidden prototypes here */
 
+/* PORT RECORD: method table */
+extern record_table_t SEMANAGE_PORT_RTABLE;
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/port_record.c	2005-12-14 02:38:44.000000000 -0500
@@ -6,11 +6,14 @@
 typedef sepol_context_t semanage_context_t;
 typedef sepol_port_t semanage_port_t;
 typedef sepol_port_key_t semanage_port_key_t;
+#define _SEMANAGE_PORT_DEFINED_
+#define _SEMANAGE_CONTEXT_DEFINED_
 
 typedef semanage_port_t record_t;
 typedef semanage_port_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include "port_internal.h"
 #include "handle.h"
 #include "database.h"
 
@@ -20,17 +23,17 @@ typedef semanage_port_key_t record_key_t
 #define sepol_port_key_extract(handle, port, key) -1
 #define sepol_port_key_free(key)
 #define sepol_port_get_proto(port) -1
-#define sepol_port_set_proto(port, proto) 
+#define sepol_port_set_proto(port, proto)
 #define sepol_port_get_proto_str(port) NULL
 #define sepol_port_get_low(port) -1
 #define sepol_port_get_high(port) -1
-#define sepol_port_set_port(port, num) 
-#define sepol_port_set_range(port, low, high) 
+#define sepol_port_set_port(port, num)
+#define sepol_port_set_range(port, low, high)
 #define sepol_port_get_con(port) NULL
 #define sepol_port_set_con(port, con)
 #define sepol_port_create(handle, port) -1
 #define sepol_port_clone(handle, port1, port2) -1
-#define sepol_port_free(port) 
+#define sepol_port_free(port)
 
 /* Key */
 int semanage_port_compare(
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-12-14 02:19:19.000000000 -0500
@@ -152,9 +152,6 @@ static int port_parse(
 	return STATUS_ERR;
 }
 
-/* PORT RECORD: method table (port_record.c) */
-extern record_table_t SEMANAGE_PORT_RTABLE;
-
 /* PORT RECORD: FILE extension: method table */
 record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
 	.parse       = port_parse,
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-12-14 02:05:35.000000000 -0500
@@ -23,9 +23,6 @@ typedef struct dbase_policydb dbase_t;
 #define sepol_port_exists NULL
 #define sepol_port_iterate NULL
 
-/* PORT RECORD: method table (port_record.c) */
-extern record_table_t SEMANAGE_PORT_RTABLE;
-
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
 record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
 	.add         = NULL, 
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2005-12-14 02:21:57.000000000 -0500
@@ -3,6 +3,7 @@
 
 #include <semanage/seuser_record.h>
 #include <semanage/seusers.h>
+#include "database.h"
 #include "dso.h"
 
 hidden_proto(semanage_seuser_clone)
@@ -20,4 +21,7 @@ hidden_proto(semanage_seuser_set_mlsrang
 hidden_proto(semanage_seuser_set_name)
 hidden_proto(semanage_seuser_set_sename)
 
+/* SEUSER RECORD: method table */
+extern record_table_t SEMANAGE_SEUSER_RTABLE;
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2005-12-14 02:17:49.000000000 -0500
@@ -1,13 +1,14 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "seuser_internal.h"
-
-typedef semanage_seuser_t record_t;
-typedef semanage_seuser_key_t record_key_t;
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser record_t;
+typedef struct semanage_seuser_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stdlib.h>
 #include <string.h>
+#include "seuser_internal.h"
 #include "debug.h"
 #include <semanage/handle.h>
 #include "database.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-12-14 02:06:20.000000000 -0500
@@ -113,9 +113,6 @@ static int seuser_parse(
 	return STATUS_ERR;
 }
 
-/* SEUSER RECORD: method table (seuser_record.c) */
-extern record_table_t SEMANAGE_SEUSER_RTABLE;
-
 /* SEUSER RECORD: FILE extension: method table */
 record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
 	.parse       = seuser_parse,
diff -Naurp --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/user_internal.h	2005-12-14 02:21:19.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/user_record.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
+#include "database.h"
 #include "dso.h"
 
 hidden_proto(semanage_user_add_role)
@@ -23,4 +24,7 @@ hidden_proto(semanage_user_set_mlslevel)
 hidden_proto(semanage_user_set_mlsrange)
 hidden_proto(semanage_user_set_name)
 
+/* USER RECORD: metod table */
+extern record_table_t SEMANAGE_USER_RTABLE;
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/user_record.c	2005-12-14 02:28:23.000000000 -0500
@@ -4,9 +4,7 @@
 
 typedef sepol_user_t semanage_user_t;
 typedef sepol_user_key_t semanage_user_key_t;
-
 #define _SEMANAGE_USER_DEFINED_
-#include "user_internal.h"
 
 typedef semanage_user_t record_t;
 typedef semanage_user_key_t record_key_t;
@@ -14,6 +12,7 @@ typedef semanage_user_key_t record_key_t
 
 #include <stdlib.h>
 #include <stddef.h>
+#include "user_internal.h"
 #include "handle.h"
 #include "database.h"
 #include "debug.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-12-14 02:03:03.000000000 -0500
@@ -200,9 +200,6 @@ static int user_parse(
 	return STATUS_ERR;
 }
 
-/* USER RECORD: metod table (user_record.c) */
-extern record_table_t SEMANAGE_USER_RTABLE;
-
 /* USER RECORD: FILE extension: method table */
 record_file_table_t SEMANAGE_USER_FILE_RTABLE = {
 	.parse       = user_parse,
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-12-14 02:38:24.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-12-14 02:03:29.000000000 -0500
@@ -17,9 +17,6 @@ typedef struct dbase_policydb dbase_t;
 #include "debug.h"
 #include "database_policydb.h"
 
-/* USER RECORD: metod table (user_record.c) */
-extern record_table_t SEMANAGE_USER_RTABLE;
-
 /* USER RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_USER_POLICYDB_RTABLE = {
 	.add         = NULL,

--------------010608040509070801090304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
