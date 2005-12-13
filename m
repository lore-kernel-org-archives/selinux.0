Message-ID: <439E19F9.5030609@cornell.edu>
Date: Mon, 12 Dec 2005 19:46:49 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Polymorphism vs headers - fix 
Content-Type: multipart/mixed;
 boundary="------------070509020209000707010200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070509020209000707010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

No headers should precede the polymorphic definition... including the 
internal header.
This allows greater freedom as to what can go into the internal header - 
specifically,
it can now include things like database.h, that make use of the 
polymorphic type.

Also remove unused libselinux headers, things that are in _internal.h 
already, and
add stub port_internal.h.


--------------070509020209000707010200
Content-Type: text/x-patch;
 name="libsemanage.poly_headers_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.poly_headers_cleanup.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-12-12 19:10:29.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "boolean_internal.h"
-
-typedef semanage_bool_t record_t;
-typedef semanage_bool_key_t record_key_t;
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool record_t;
+typedef struct semanage_bool_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_file;
@@ -14,8 +14,8 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <semanage/handle.h>
+#include "boolean_internal.h"
 #include "database_file.h"
 #include "booleans_file.h"
 #include "parse_utils.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/booleans_local.c	2005-12-12 19:21:48.000000000 -0500
@@ -1,12 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "boolean_internal.h"
-
-typedef semanage_bool_key_t record_key_t;
-typedef semanage_bool_t record_t;
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool_key record_key_t;
+typedef struct semanage_bool record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
+#include "boolean_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/booleans_policy.c	2005-12-12 19:15:32.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "boolean_internal.h"
-
-typedef semanage_bool_key_t record_key_t;
-typedef semanage_bool_t record_t;
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool_key record_key_t;
+typedef struct semanage_bool record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/booleans_policy.h>
+#include "boolean_internal.h"
 #include "handle.h"
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-12-12 19:11:01.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "boolean_internal.h"
-
-typedef semanage_bool_t record_t;
-typedef semanage_bool_key_t record_key_t;
+struct semanage_bool;
+struct semanage_bool_key;
+typedef struct semanage_bool record_t;
+typedef struct semanage_bool_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_policydb;
@@ -12,6 +12,7 @@ typedef struct dbase_policydb dbase_t;
 
 #include <sepol/booleans.h>
 #include <semanage/handle.h>
+#include "boolean_internal.h"
 #include "booleans_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-12-12 19:08:54.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "iface_internal.h"
-
-typedef semanage_iface_t record_t;
-typedef semanage_iface_key_t record_key_t;
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface record_t;
+typedef struct semanage_iface_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_file;
@@ -12,8 +12,8 @@ typedef struct dbase_file dbase_t;
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <selinux/selinux.h>
 #include <semanage/handle.h>
+#include "iface_internal.h"
 #include "context_internal.h"
 #include "database_file.h"
 #include "interfaces_file.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/interfaces_local.c	2005-12-12 19:16:08.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "iface_internal.h"
-
-typedef semanage_iface_key_t record_key_t;
-typedef semanage_iface_t record_t;
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface_key record_key_t;
+typedef struct semanage_iface record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/interfaces_local.h>
+#include "iface_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/interfaces_policy.c	2005-12-12 19:21:24.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "iface_internal.h"
-
-typedef semanage_iface_key_t record_key_t;
-typedef semanage_iface_t record_t;
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface_key record_key_t;
+typedef struct semanage_iface record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/interfaces_policy.h>
+#include "iface_internal.h"
 #include "handle.h"
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-12-12 19:09:32.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "iface_internal.h"
-
-typedef semanage_iface_t record_t;
-typedef semanage_iface_key_t record_key_t;
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface record_t;
+typedef struct semanage_iface_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_policydb;
@@ -12,6 +12,7 @@ typedef struct dbase_policydb dbase_t;
 
 #include <sepol/interfaces.h>
 #include <semanage/handle.h>
+#include "iface_internal.h"
 #include "interfaces_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/port_internal.h	2005-12-12 19:12:54.000000000 -0500
@@ -0,0 +1,11 @@
+#ifndef _SEMANAGE_PORT_INTERNAL_H_
+#define _SEMANAGE_PORT_INTERNAL_H_
+
+#include <semanage/port_record.h>
+#include <semanage/ports_local.h>
+#include <semanage/ports_policy.h>
+#include "dso.h"
+
+/* TODO: Hidden prototypes here */
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-23 21:43:46.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include <semanage/port_record.h>
-
-typedef semanage_port_t record_t;
-typedef semanage_port_key_t record_key_t;
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port record_t;
+typedef struct semanage_port_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_file;
@@ -14,6 +14,7 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <strings.h>
 #include <semanage/handle.h>
+#include "port_internal.h"
 #include "context_internal.h"
 #include "database_file.h"
 #include "ports_file.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/ports_local.c	2005-12-12 19:16:32.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include <semanage/port_record.h>
-
-typedef semanage_port_key_t record_key_t;
-typedef semanage_port_t record_t;
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port_key record_key_t;
+typedef struct semanage_port record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/handle.h>
+#include "port_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/ports_policy.c	2005-12-12 19:16:36.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include <semanage/port_record.h>
-
-typedef semanage_port_key_t record_key_t;
-typedef semanage_port_t record_t;
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port_key record_key_t;
+typedef struct semanage_port record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/ports_policy.h>
+#include "port_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-12-12 18:59:48.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include <semanage/port_record.h>
-
-typedef semanage_port_t record_t;
-typedef semanage_port_key_t record_key_t;
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port record_t;
+typedef struct semanage_port_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_policydb;
@@ -12,7 +12,7 @@ typedef struct dbase_policydb dbase_t;
 
 #include <sepol/ports.h>
 #include <semanage/handle.h>
-#include "ports_policydb.h"
+#include "port_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/seusers.c	2005-12-12 19:21:40.000000000 -0500
@@ -1,14 +1,14 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "seuser_internal.h"
-
-typedef semanage_seuser_key_t record_key_t;
-typedef semanage_seuser_t record_t;
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser_key record_key_t;
+typedef struct semanage_seuser record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
 #include "user_internal.h"
-#include <semanage/users_policy.h>
+#include "seuser_internal.h"
 #include "seusers.h"
 #include "handle.h"
 #include "database.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-12-12 19:18:29.000000000 -0500
@@ -1,9 +1,9 @@
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
 
 struct dbase_file;
@@ -14,7 +14,7 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <strings.h>
 
-#include <selinux/selinux.h>
+#include "seuser_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-12-12 19:05:10.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "user_internal.h"
-
-typedef semanage_user_t record_t;
-typedef semanage_user_key_t record_key_t;
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user record_t;
+typedef struct semanage_user_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_file;
@@ -14,8 +14,8 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <semanage/handle.h>
+#include "user_internal.h"
 #include "database_file.h"
 #include "users_file.h"
 #include "parse_utils.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/users_local.c	2005-12-12 19:23:07.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "user_internal.h"
-
-typedef semanage_user_key_t record_key_t;
-typedef semanage_user_t record_t;
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user_key record_key_t;
+typedef struct semanage_user record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/users_local.h>
+#include "user_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/users_policy.c	2005-12-12 19:23:27.000000000 -0500
@@ -1,13 +1,13 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "user_internal.h"
-
-typedef semanage_user_key_t record_key_t;
-typedef semanage_user_t record_t;
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user_key record_key_t;
+typedef struct semanage_user record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/users_policy.h>
+#include "user_internal.h"
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude-from excludes old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-12-12 19:20:55.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-12-12 19:06:18.000000000 -0500
@@ -1,9 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
-#include "user_internal.h"
-
-typedef semanage_user_t record_t;
-typedef semanage_user_key_t record_key_t;
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user record_t;
+typedef struct semanage_user_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
 struct dbase_policydb;
@@ -12,6 +12,7 @@ typedef struct dbase_policydb dbase_t;
 
 #include <sepol/users.h>
 #include <semanage/handle.h>
+#include "user_internal.h"
 #include "users_policydb.h"
 #include "debug.h"
 #include "database_policydb.h"

--------------070509020209000707010200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
