Message-ID: <43AB9A75.3020104@cornell.edu>
Date: Fri, 23 Dec 2005 01:34:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Annotate objects
Content-Type: multipart/mixed;
 boundary="------------020609050000080003070407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020609050000080003070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds comments that explain the object relationships, to avoid 
confusion...



--------------020609050000080003070407
Content-Type: text/x-patch;
 name="libsemanage2.annotate_oop.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage2.annotate_oop.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2005-12-23 00:34:37.000000000 -0500
@@ -1,5 +1,11 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: semanage_bool_t (Policy Boolean)
+ * Object: semanage_bool_key_t (Policy Boolean Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
 #include <sepol/boolean_record.h>
 
 typedef sepol_bool_t semanage_bool_t;
diff -Naurp --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-12-23 00:05:59.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-12-23 00:29:12.000000000 -0500
@@ -1,5 +1,10 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: dbase_file_t (File)
+ * Extends: dbase_llist_t (Linked List) 
+ * Implements: dbase_t (Database)
+ */
+
 struct dbase_file;
 typedef struct dbase_file dbase_t;
 #define DBASE_DEFINED
diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2005-12-23 00:06:00.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2005-12-23 00:35:38.000000000 -0500
@@ -1,5 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: dbase_llist_t (Linked List)
+ * Partially Implements: dbase_t (Database)
+ */
+
 struct dbase_llist;
 typedef struct dbase_llist dbase_t;
 #define DBASE_DEFINED
@@ -30,7 +34,6 @@ hidden int dbase_llist_cache_prepend(
 	if (dbase->cache_tail == NULL)
 		dbase->cache_tail = entry;
 	dbase->cache = entry;
-
 	dbase->cache_sz++;
         return STATUS_SUCCESS;
 
diff -Naurp --exclude-from excludes old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-12-13 11:08:25.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-12-23 00:28:46.000000000 -0500
@@ -1,5 +1,9 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: dbase_policydb_t (Policy)
+ * Implements: dbase_t (Database)
+ */
+
 struct dbase_policydb;
 typedef struct dbase_policydb dbase_t;
 #define DBASE_DEFINED
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2005-12-23 00:34:04.000000000 -0500
@@ -1,5 +1,11 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: semanage_iface_t (Network Interface)
+ * Object: semanage_iface_key_t (Network Interface Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
 #include <sepol/context_record.h>
 #include <sepol/iface_record.h>
 
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2005-12-14 11:04:24.000000000 -0500
+++ new/libsemanage/src/port_record.c	2005-12-23 00:34:28.000000000 -0500
@@ -1,5 +1,11 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: semanage_port_t (Network Port)
+ * Object: semanage_port_key_t (Network Port Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
 #include <sepol/context_record.h>
 #include <sepol/port_record.h>
 
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2005-12-23 00:32:07.000000000 -0500
@@ -1,5 +1,11 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: semanage_seuser_t (Unix User)
+ * Object: semanage_seuser_key_t (Unix User Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
 struct semanage_seuser;
 struct semanage_seuser_key;
 typedef struct semanage_seuser record_t;
diff -Naurp --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/user_record.c	2005-12-23 00:34:53.000000000 -0500
@@ -1,5 +1,11 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+/* Object: semanage_user_t (SELinux User/Class)
+ * Object: semanage_user_key_t (SELinux User/Class Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
 #include <sepol/user_record.h>
 
 typedef sepol_user_t semanage_user_t;

--------------020609050000080003070407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
