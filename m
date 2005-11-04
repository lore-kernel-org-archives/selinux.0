Message-ID: <436B0D46.9050102@cornell.edu>
Date: Fri, 04 Nov 2005 02:27:02 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, dwalsh@redhat.com
Subject: [ SEMANAGE 4 ] Copyright 
Content-Type: multipart/mixed;
 boundary="------------050300090706020307030009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050300090706020307030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- Add Red Hat's copyright notice to all code that I've changed... (is 
this done properly?)
- delete old file record.h, which I had forgotten all about... it's not 
used anymore.



--------------050300090706020307030009
Content-Type: text/x-patch;
 name="libsemanage.copyright.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.copyright.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/boolean_record.h new/libsemanage/include/semanage/boolean_record.h
--- old/libsemanage/include/semanage/boolean_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/boolean_record.h	2005-11-04 02:17:12.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_BOOLEAN_RECORD_H_
 #define _SEMANAGE_BOOLEAN_RECORD_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/booleans_local.h	2005-11-04 02:17:28.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_BOOLEANS_LOCAL_H_
 #define _SEMANAGE_BOOLEANS_LOCAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/booleans_policy.h	2005-11-04 02:17:34.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_BOOLEANS_POLICY_H_
 #define _SEMANAGE_BOOLEANS_POLICY_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/context_record.h new/libsemanage/include/semanage/context_record.h
--- old/libsemanage/include/semanage/context_record.h	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/include/semanage/context_record.h	2005-11-04 02:17:43.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_CONTEXT_RECORD_H_
 #define _SEMANAGE_CONTEXT_RECORD_H_ 
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/iface_record.h new/libsemanage/include/semanage/iface_record.h
--- old/libsemanage/include/semanage/iface_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/iface_record.h	2005-11-04 02:18:08.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_IFACE_RECORD_H_
 #define _SEMANAGE_IFACE_RECORD_H_ 
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces_local.h	2005-11-04 02:18:14.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_INTERFACES_LOCAL_H_
 #define _SEMANAGE_INTERFACES_LOCAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/interfaces_policy.h new/libsemanage/include/semanage/interfaces_policy.h
--- old/libsemanage/include/semanage/interfaces_policy.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces_policy.h	2005-11-04 02:18:39.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_INTERFACES_POLICY_H_
 #define _SEMANAGE_INTERFACES_POLICY_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/port_record.h	2005-11-04 02:18:43.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PORT_RECORD_H_
 #define _SEMANAGE_PORT_RECORD_H_ 
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/ports_local.h	2005-11-04 02:18:52.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PORTS_LOCAL_H_
 #define _SEMANAGE_PORTS_LOCAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/ports_policy.h new/libsemanage/include/semanage/ports_policy.h
--- old/libsemanage/include/semanage/ports_policy.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/ports_policy.h	2005-11-04 02:18:58.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PORTS_POLICY_H_
 #define _SEMANAGE_PORTS_POLICY_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/include/semanage/semanage.h	2005-11-04 02:19:19.000000000 -0500
@@ -2,7 +2,8 @@
  *	    Jason Tang	    <jtang@tresys.com>
  *
  * Copyright (C) 2005 Tresys Technology, LLC
- *
+ * Copyright (C) 2005 Red Hat, Inc.
+ * 
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/seuser_record.h new/libsemanage/include/semanage/seuser_record.h
--- old/libsemanage/include/semanage/seuser_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/seuser_record.h	2005-11-04 02:19:31.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_SEUSER_RECORD_H_
 #define _SEMANAGE_SEUSER_RECORD_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/seusers.h	2005-11-04 02:19:37.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_SEUSERS_H_
 #define _SEMANAGE_SEUSERS_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/user_record.h	2005-11-04 02:19:45.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_USER_RECORD_H_
 #define _SEMANAGE_USER_RECORD_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/users_local.h	2005-11-04 02:19:53.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_USERS_LOCAL_H_
 #define _SEMANAGE_USERS_LOCAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/users_policy.h new/libsemanage/include/semanage/users_policy.h
--- old/libsemanage/include/semanage/users_policy.h	2005-10-27 17:39:13.000000000 -0400
+++ new/libsemanage/include/semanage/users_policy.h	2005-11-04 02:20:01.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_USERS_POLICY_H_
 #define _SEMANAGE_USERS_POLICY_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2005-11-04 02:09:14.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <sepol/boolean_record.h>
 
 typedef sepol_bool_t semanage_bool_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-11-04 02:09:01.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/boolean_record.h>
 
 typedef semanage_bool_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.h new/libsemanage/src/booleans_file.h
--- old/libsemanage/src/booleans_file.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/booleans_file.h	2005-11-04 02:09:05.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_BOOLEANS_FILE_H_
 #define _SEMANAGE_BOOLEANS_FILE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/booleans_local.c	2005-11-04 02:09:23.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/boolean_record.h>
 
 typedef semanage_bool_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/booleans_policy.c	2005-11-04 02:09:35.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/boolean_record.h>
 
 typedef semanage_bool_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-11-04 02:09:42.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/boolean_record.h>
 
 typedef semanage_bool_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_policydb.h new/libsemanage/src/booleans_policydb.h
--- old/libsemanage/src/booleans_policydb.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.h	2005-11-04 02:09:47.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/context_record.c new/libsemanage/src/context_record.c
--- old/libsemanage/src/context_record.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/context_record.c	2005-11-04 02:09:54.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <sepol/context_record.h>
 #include "handle.h"
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database.c	2005-11-04 02:07:52.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/handle.h>
 #include "semanage_store.h"
 #include "database.h"
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-11-04 02:07:58.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 struct dbase_file;
 typedef struct dbase_file dbase_t;
 #define DBASE_DEFINED
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.h new/libsemanage/src/database_file.h
--- old/libsemanage/src/database_file.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database_file.h	2005-11-04 02:08:47.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_DATABASE_FILE_INTERNAL_H_
 #define _SEMANAGE_DATABASE_FILE_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database.h	2005-11-04 02:16:56.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-11-04 02:08:04.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 struct dbase_policydb;
 typedef struct dbase_policydb dbase_t;
 #define DBASE_DEFINED
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/database_policydb.h	2005-11-04 02:08:22.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-11-04 02:10:30.000000000 -0500
@@ -1,7 +1,8 @@
 /* Author: Jason Tang	  <jtang@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
- *
+ * Copyright (C) 2005 Red Hat, Inc.
+ * 
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/handle.c	2005-11-04 02:11:03.000000000 -0500
@@ -2,7 +2,8 @@
  *	   Jason Tang	  <jtang@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
- *
+ * Copyright (C) 2005 Red Hat, Inc.
+ * 
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2005-11-04 02:11:17.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <sepol/context_record.h>
 #include <sepol/iface_record.h>
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-04 02:11:24.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/iface_record.h>
 
 typedef semanage_iface_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.h new/libsemanage/src/interfaces_file.h
--- old/libsemanage/src/interfaces_file.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/interfaces_file.h	2005-11-04 02:11:43.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_INTERFACES_FILE_H_
 #define _SEMANAGE_INTERFACES_FILE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/interfaces_local.c	2005-11-04 02:11:51.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/iface_record.h>
 
 typedef semanage_iface_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/interfaces_policy.c	2005-11-04 02:11:58.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/iface_record.h>
 
 typedef semanage_iface_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-11-04 02:12:03.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/iface_record.h>
 
 typedef semanage_iface_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_policydb.h new/libsemanage/src/interfaces_policydb.h
--- old/libsemanage/src/interfaces_policydb.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.h	2005-11-04 02:12:07.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-11-04 00:20:54.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-11-04 02:12:52.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <errno.h>
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/parse_utils.h	2005-11-04 02:12:56.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PARSE_UTILS_INTERNAL_H_
 #define _SEMANAGE_PARSE_UTILS_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-11-04 02:13:04.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include "policy.h"
 #include "handle.h"
 #include "database.h"
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/port_record.c	2005-11-04 02:13:19.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <sepol/context_record.h>
 #include <sepol/port_record.h>
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-04 02:13:25.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/port_record.h>
 
 typedef semanage_port_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.h new/libsemanage/src/ports_file.h
--- old/libsemanage/src/ports_file.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/ports_file.h	2005-11-04 02:13:29.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PORTS_FILE_H_
 #define _SEMANAGE_PORTS_FILE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/ports_local.c	2005-11-04 02:13:57.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/port_record.h>
 
 typedef semanage_port_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/ports_policy.c	2005-11-04 02:13:35.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/port_record.h>
 
 typedef semanage_port_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-11-04 02:13:42.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/port_record.h>
 
 typedef semanage_port_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_policydb.h new/libsemanage/src/ports_policydb.h
--- old/libsemanage/src/ports_policydb.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/ports_policydb.h	2005-11-04 02:13:47.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/record.h new/libsemanage/src/record.h
--- old/libsemanage/src/record.h	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/record.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,35 +0,0 @@
-#ifndef _SEMANAGE_RECORD_H_
-#define _SEMANAGE_RECORD_H_
-
-#ifndef RECORD_DEFINED
-typedef void* record_t;
-typedef void* record_key_t;
-#define RECORD_DEFINED
-#endif
-
-/* RECORD interface - method table */
-typedef struct record_table {
-
-	/* Create a record */
-	int (*create) (record_t** rec);
-
-	/* Extract key from record */
-	int (*key_extract) (record_t* rec, record_key_t** key);
-	
-	/* Free record key */
-	void (*key_free) (record_key_t* key);
-
-	/* Return 0 if record can be matched against key,
-	 * and 1 otherwise */
-	int (*compare) (record_t* rec, record_key_t* key);
-
-	/* Deep-copy clone of this record */
-	int (*clone) (record_t* rec, record_t** new_rec);
-
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t* rec);
-
-} record_table_t;
-
-#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2005-11-04 02:15:14.000000000 -0500
@@ -3,6 +3,7 @@
  *	    Jason Tang <jtang@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/semanage_store.h	2005-11-04 02:15:28.000000000 -0500
@@ -3,6 +3,7 @@
  *	    Jason Tang <jtang@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2005-11-04 02:15:38.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/seuser_record.h>
 
 typedef semanage_seuser_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/seusers.c	2005-11-04 02:15:46.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/seuser_record.h>
 
 typedef semanage_seuser_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-04 02:15:52.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/seuser_record.h>
 
 typedef semanage_seuser_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.h new/libsemanage/src/seusers_file.h
--- old/libsemanage/src/seusers_file.h	2005-11-04 00:15:23.000000000 -0500
+++ new/libsemanage/src/seusers_file.h	2005-11-04 02:15:56.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_SEUSERS_FILE_H_
 #define _SEMANAGE_SEUSERS_FILE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers.h new/libsemanage/src/seusers.h
--- old/libsemanage/src/seusers.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/seusers.h	2005-11-04 02:16:02.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEUSERS_INTERNAL_H_
 #define _SEUSERS_INTERNAL_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/user_record.c	2005-11-04 02:16:07.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <sepol/user_record.h>
 
 typedef sepol_user_t semanage_user_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-11-04 00:15:24.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-11-04 02:16:13.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/user_record.h>
 
 typedef semanage_user_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.h new/libsemanage/src/users_file.h
--- old/libsemanage/src/users_file.h	2005-11-04 00:15:24.000000000 -0500
+++ new/libsemanage/src/users_file.h	2005-11-04 02:16:21.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_USERS_FILE_H_
 #define _SEMANAGE_USERS_FILE_H_
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/users_local.c	2005-11-04 02:16:29.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/user_record.h>
 
 typedef semanage_user_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/users_policy.c	2005-11-04 02:16:36.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/user_record.h>
 
 typedef semanage_user_key_t record_key_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-11-04 00:15:24.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-11-04 02:16:42.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #include <semanage/user_record.h>
 
 typedef semanage_user_t record_t;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_policydb.h new/libsemanage/src/users_policydb.h
--- old/libsemanage/src/users_policydb.h	2005-11-04 00:15:24.000000000 -0500
+++ new/libsemanage/src/users_policydb.h	2005-11-04 02:16:49.000000000 -0500
@@ -1,3 +1,5 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
 #ifndef _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
 #define _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
 

--------------050300090706020307030009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
