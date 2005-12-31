Message-ID: <43B6788E.40103@cornell.edu>
Date: Sat, 31 Dec 2005 07:24:46 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Include guards for internal headers
Content-Type: multipart/mixed;
 boundary="------------060709090307040108020801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060709090307040108020801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds include guards for _internal.h headers in sepol.


--------------060709090307040108020801
Content-Type: text/x-patch;
 name="libsepol2.include_guards.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol2.include_guards.diff"

diff -Naurp --exclude-from excludes old/libsepol/src/boolean_internal.h new/libsepol/src/boolean_internal.h
--- old/libsepol/src/boolean_internal.h	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/boolean_internal.h	2005-12-31 07:06:02.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEPOL_BOOLEAN_INTERNAL_H_
+#define _SEPOL_BOOLEAN_INTERNAL_H_
+
 #include <sepol/boolean_record.h>
 #include <sepol/booleans.h>
 #include "dso.h"
@@ -10,3 +13,5 @@ hidden_proto(sepol_bool_get_value)
 hidden_proto(sepol_bool_set_value)
 hidden_proto(sepol_bool_create)
 hidden_proto(sepol_bool_free)
+
+#endif
diff -Naurp --exclude-from excludes old/libsepol/src/context.h new/libsepol/src/context.h
--- old/libsepol/src/context.h	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/context.h	2005-12-31 07:10:21.000000000 -0500
@@ -1,5 +1,5 @@
-#ifndef _SEPOL_CONTEXT_INTERNAL_H_
-#define _SEPOL_CONTEXT_INTERNAL_H_
+#ifndef _SEPOL_INTERNAL_CONTEXT_H_
+#define _SEPOL_INTERNAL_CONTEXT_H_
 
 #include <stddef.h>
 #include "context_internal.h"
diff -Naurp --exclude-from excludes old/libsepol/src/context_internal.h new/libsepol/src/context_internal.h
--- old/libsepol/src/context_internal.h	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/context_internal.h	2005-12-31 07:08:24.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEPOL_CONTEXT_INTERNAL_H_
+#define _SEPOL_CONTEXT_INTERNAL_H_
+
 #include <sepol/context_record.h>
 #include "dso.h"
 
@@ -13,3 +16,5 @@ hidden_proto(sepol_context_set_mls)
 hidden_proto(sepol_context_set_role)
 hidden_proto(sepol_context_set_type)
 hidden_proto(sepol_context_set_user)
+
+#endif
diff -Naurp --exclude-from excludes old/libsepol/src/iface_internal.h new/libsepol/src/iface_internal.h
--- old/libsepol/src/iface_internal.h	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/iface_internal.h	2005-12-31 07:08:50.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEPOL_IFACE_INTERNAL_H_
+#define _SEPOL_IFACE_INTERNAL_H_
+
 #include <sepol/iface_record.h>
 #include <sepol/interfaces.h>
 #include "dso.h"
@@ -12,3 +15,5 @@ hidden_proto(sepol_iface_key_unpack)
 hidden_proto(sepol_iface_set_ifcon)
 hidden_proto(sepol_iface_set_msgcon)
 hidden_proto(sepol_iface_set_name)
+
+#endif
diff -Naurp --exclude-from excludes old/libsepol/src/policydb_internal.h new/libsepol/src/policydb_internal.h
--- old/libsepol/src/policydb_internal.h	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/policydb_internal.h	2005-12-31 07:09:56.000000000 -0500
@@ -1,5 +1,10 @@
+#ifndef _SEPOL_POLICYDB_INTERNAL_H_
+#define _SEPOL_POLICYDB_INTERNAL_H_
+
 #include <sepol/policydb.h>
 #include "dso.h"
 
 hidden_proto(sepol_policydb_create)
 hidden_proto(sepol_policydb_free)
+
+#endif
diff -Naurp --exclude-from excludes old/libsepol/src/port_internal.h new/libsepol/src/port_internal.h
--- old/libsepol/src/port_internal.h	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/port_internal.h	2005-12-31 07:09:11.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEPOL_PORT_INTERNAL_H_
+#define _SEPOL_PORT_INTERNAL_H_
+
 #include <sepol/port_record.h>
 #include <sepol/ports.h>
 #include "dso.h"
@@ -14,3 +17,5 @@ hidden_proto(sepol_port_key_unpack)
 hidden_proto(sepol_port_set_con)
 hidden_proto(sepol_port_set_proto)
 hidden_proto(sepol_port_set_range)
+
+#endif
diff -Naurp --exclude-from excludes old/libsepol/src/user_internal.h new/libsepol/src/user_internal.h
--- old/libsepol/src/user_internal.h	2005-11-28 14:11:30.000000000 -0500
+++ new/libsepol/src/user_internal.h	2005-12-31 07:09:31.000000000 -0500
@@ -1,3 +1,6 @@
+#ifndef _SEPOL_USER_INTERNAL_H_
+#define _SEPOL_USER_INTERNAL_H_
+
 #include <sepol/user_record.h>
 #include <sepol/users.h>
 #include "dso.h"
@@ -14,3 +17,5 @@ hidden_proto(sepol_user_key_unpack)
 hidden_proto(sepol_user_set_mlslevel)
 hidden_proto(sepol_user_set_mlsrange)
 hidden_proto(sepol_user_set_name)
+
+#endif

--------------060709090307040108020801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
