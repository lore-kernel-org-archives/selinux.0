Message-ID: <439E1A64.7030007@cornell.edu>
Date: Mon, 12 Dec 2005 19:48:36 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Include guards for internal headers
Content-Type: multipart/mixed;
 boundary="------------070102070005020002060304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070102070005020002060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds include guards for _internal headers.


--------------070102070005020002060304
Content-Type: text/x-patch;
 name="libsemanage.internal_include_guards.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.internal_include_guards.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2005-11-16 08:44:47.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2005-12-12 19:25:24.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEMANAGE_BOOLEAN_INTERNAL_H_
+#define _SEMANAGE_BOOLEAN_INTERNAL_H_
+
 #include <semanage/boolean_record.h>
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
@@ -13,3 +16,5 @@ hidden_proto(semanage_bool_key_extract)
 hidden_proto(semanage_bool_key_free)
 hidden_proto(semanage_bool_set_name)
 hidden_proto(semanage_bool_set_value)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/handle_internal.h new/libsemanage/src/handle_internal.h
--- old/libsemanage/src/handle_internal.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/handle_internal.h	2005-12-12 19:25:46.000000000 -0500
@@ -1,6 +1,11 @@
+#ifndef _SEMANAGE_HANDLE_INTERNAL_H_
+#define _SEMANAGE_HANDLE_INTERNAL_H_
+
 #include <semanage/handle.h>
 #include "dso.h"
 
 hidden_proto(semanage_begin_transaction)
 hidden_proto(semanage_handle_destroy)
 hidden_proto(semanage_reload_policy)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_internal.h new/libsemanage/src/iface_internal.h
--- old/libsemanage/src/iface_internal.h	2005-11-08 09:34:17.000000000 -0500
+++ new/libsemanage/src/iface_internal.h	2005-12-12 19:26:09.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEMANAGE_IFACE_INTERNAL_H_
+#define _SEMANAGE_IFACE_INTERNAL_H_
+
 #include <semanage/iface_record.h>
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
@@ -15,3 +18,5 @@ hidden_proto(semanage_iface_key_free)
 hidden_proto(semanage_iface_set_ifcon)
 hidden_proto(semanage_iface_set_msgcon)
 hidden_proto(semanage_iface_set_name)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/module_internal.h new/libsemanage/src/module_internal.h
--- old/libsemanage/src/module_internal.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/module_internal.h	2005-12-12 19:26:28.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEMANAGE_MODULE_INTERNAL_H_
+#define _SEMANAGE_MODULE_INTERNAL_H_
+
 #include <semanage/modules.h>
 #include "dso.h"
 
@@ -5,3 +8,5 @@ hidden_proto(semanage_module_get_name)
 hidden_proto(semanage_module_get_version)
 hidden_proto(semanage_module_info_datum_destroy)
 hidden_proto(semanage_module_list_nth)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2005-12-12 19:26:59.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEMANAGE_SEUSER_INTERNAL_H_
+#define _SEMANAGE_SEUSER_INTERNAL_H_
+
 #include <semanage/seuser_record.h>
 #include <semanage/seusers.h>
 #include "dso.h"
@@ -16,3 +19,5 @@ hidden_proto(semanage_seuser_key_free)
 hidden_proto(semanage_seuser_set_mlsrange)
 hidden_proto(semanage_seuser_set_name)
 hidden_proto(semanage_seuser_set_sename)
+
+#endif
diff -Naurp --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2005-12-05 15:00:50.000000000 -0500
+++ new/libsemanage/src/user_internal.h	2005-12-12 19:27:27.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEMANAGE_USER_INTERNAL_H_
+#define _SEMANAGE_USER_INTERNAL_H_
+
 #include <semanage/user_record.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
@@ -19,3 +22,5 @@ hidden_proto(semanage_user_key_free)
 hidden_proto(semanage_user_set_mlslevel)
 hidden_proto(semanage_user_set_mlsrange)
 hidden_proto(semanage_user_set_name)
+
+#endif

--------------070102070005020002060304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
