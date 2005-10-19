Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9JKT9Ns024734
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 16:29:10 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9JKQMjJ001092
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 20:26:22 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j9JKQ02l013895
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 16:26:00 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j9JKQ0do013894
	for selinux@tycho.nsa.gov; Wed, 19 Oct 2005 16:26:00 -0400
Message-ID: <4356ABA8.2080207@cornell.edu>
Date: Wed, 19 Oct 2005 16:25:12 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Fix and make consistent interface naming
Content-Type: multipart/mixed;
 boundary="------------030206040403010205010803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030206040403010205010803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the next rename patch...
I'm sorry, but things will have to be renamed until they're correct, and 
easy to understand.
As plans change, names become obsolete.

Patch does the following:
- adds (_local) suffix to all functions, and structures that work with 
local users, and puts the code in (_local) files
- changes incorrect (_base) suffix in some cases, which I hadn't noticed 
to (_policy), which is correct
- exposes query APIs for policy objects to libsemanage clients (but not 
modify APIs). Basically I wrote a public header. Note that this header 
is still not included in semanage.h, and the functions are not in the 
map file - I'll change that when I've tested things, and they work.
- removes (_policy) suffix from those APIs - the suffix is kept 
everywhere internally, to make the code clearer, but is removed for the 
function names in the interface, to indicate to the user that the 
objects that he/she is working with _include_ the local ones.
- adds stub implementation and interfaces for in-policy interfaces and 
booleans
- adds stddef.h in a few places where it was missing.
============
This is much better...

I don't like how in some places I use short-hand notation ("bool", 
"iface"), and in others I use the full word ("interface", "boolean"). 
The interfaces are fully consistent, but for example, I can't just feed 
the user relay code through sed to generate the port/iface relay code - 
needs manual editing. Anyway, that's not important right now - I don't 
want to rename more files for no good reason.

--------------030206040403010205010803
Content-Type: text/x-chdr;
 name="libsemanage.fix_interfaces.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_interfaces.h"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/booleans.h new/libsemanage/include/semanage/booleans.h
--- old/libsemanage/include/semanage/booleans.h	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/include/semanage/booleans.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-#ifndef _SEMANAGE_BOOLEANS_H_
-#define _SEMANAGE_BOOLEANS_H_
-
-#include <stddef.h>
-#include <semanage/boolean_record.h>
-#include <semanage/handle.h>
-
-extern int semanage_bool_add(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
-extern int semanage_bool_modify(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data);
-
-extern int semanage_bool_del(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key);
-
-extern int semanage_bool_query(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t** response);
-
-extern int semanage_bool_exists(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	int* response);
-
-extern int semanage_bool_count(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_bool_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_bool_list(
-	semanage_handle_t* handle,
-	semanage_bool_t*** records,
-	size_t* count);
-
-#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_local.h	2005-10-19 15:44:40.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_BOOLEANS_LOCAL_H_
+#define _SEMANAGE_BOOLEANS_LOCAL_H_
+
+#include <stddef.h>
+#include <semanage/boolean_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_bool_add_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_modify_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_del_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key);
+
+extern int semanage_bool_query_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response);
+
+extern int semanage_bool_exists_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response);
+
+extern int semanage_bool_count_local(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_bool_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_bool_list_local(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_policy.h	2005-10-19 15:59:34.000000000 -0400
@@ -0,0 +1,33 @@
+#ifndef _SEMANAGE_BOOLEANS_POLICY_H_
+#define _SEMANAGE_BOOLEANS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/handle.h> 
+#include <semanage/boolean_record.h>
+
+extern int semanage_bool_query(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response);
+
+extern int semanage_bool_exists(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response);
+
+extern int semanage_bool_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_bool_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_bool_list(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/interfaces.h new/libsemanage/include/semanage/interfaces.h
--- old/libsemanage/include/semanage/interfaces.h	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/include/semanage/interfaces.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-#ifndef _SEMANAGE_INTERFACES_H_
-#define _SEMANAGE_INTERFACES_H_
-
-#include <stddef.h>
-#include <semanage/iface_record.h>
-#include <semanage/handle.h>
-
-extern int semanage_iface_add(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
-
-extern int semanage_iface_modify(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data);
-
-extern int semanage_iface_del(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key);
-
-extern int semanage_iface_query(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t** response);
-
-extern int semanage_iface_exists(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	int* response);
-
-extern int semanage_iface_count(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_iface_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_iface_list(
-	semanage_handle_t* handle,
-	semanage_iface_t*** records,
-	size_t* count);
-
-#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/interfaces_local.h	2005-10-19 15:44:04.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_INTERFACES_LOCAL_H_
+#define _SEMANAGE_INTERFACES_LOCAL_H_
+
+#include <stddef.h>
+#include <semanage/iface_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_iface_add_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_modify_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_del_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key);
+
+extern int semanage_iface_query_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response);
+
+extern int semanage_iface_exists_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response);
+
+extern int semanage_iface_count_local(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_iface_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_iface_list_local(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/interfaces_policy.h new/libsemanage/include/semanage/interfaces_policy.h
--- old/libsemanage/include/semanage/interfaces_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/interfaces_policy.h	2005-10-19 15:59:13.000000000 -0400
@@ -0,0 +1,33 @@
+#ifndef _SEMANAGE_INTERFACES_POLICY_H_
+#define _SEMANAGE_INTERFACES_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/handle.h> 
+#include <semanage/iface_record.h>
+
+extern int semanage_iface_query(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response);
+
+extern int semanage_iface_exists(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response);
+
+extern int semanage_iface_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_iface_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_iface_list(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/ports.h new/libsemanage/include/semanage/ports.h
--- old/libsemanage/include/semanage/ports.h	2005-09-30 16:18:58.000000000 -0400
+++ new/libsemanage/include/semanage/ports.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-#ifndef _SEMANAGE_PORTS_H_
-#define _SEMANAGE_PORTS_H_
-
-#include <stddef.h>
-#include <semanage/port_record.h>
-#include <semanage/handle.h>
-
-extern int semanage_port_add(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
-
-extern int semanage_port_modify(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data);
-
-extern int semanage_port_del(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key);
-
-extern int semanage_port_query(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t** response);
-
-extern int semanage_port_exists(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	int* response);
-
-extern int semanage_port_count(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_port_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_port_list(
-	semanage_handle_t* handle,
-	semanage_port_t*** records,
-	size_t* count);
-
-#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/ports_local.h	2005-10-19 15:44:51.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_PORTS_LOCAL_H_
+#define _SEMANAGE_PORTS_LOCAL_H_
+
+#include <stddef.h>
+#include <semanage/port_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_port_add_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data);
+
+extern int semanage_port_modify_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data);
+
+extern int semanage_port_del_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key);
+
+extern int semanage_port_query_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t** response);
+
+extern int semanage_port_exists_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	int* response);
+
+extern int semanage_port_count_local(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_port_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_port_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_port_list_local(
+	semanage_handle_t* handle,
+	semanage_port_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/ports_policy.h new/libsemanage/include/semanage/ports_policy.h
--- old/libsemanage/include/semanage/ports_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/ports_policy.h	2005-10-19 15:22:39.000000000 -0400
@@ -0,0 +1,33 @@
+#ifndef _SEMANAGE_PORTS_POLICY_H_
+#define _SEMANAGE_PORTS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/handle.h> 
+#include <semanage/port_record.h>
+
+extern int semanage_port_query(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t** response);
+
+extern int semanage_port_exists(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	int* response);
+
+extern int semanage_port_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_port_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_port_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_port_list(
+	semanage_handle_t* handle,
+	semanage_port_t*** records,
+	size_t* count);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/users.h new/libsemanage/include/semanage/users.h
--- old/libsemanage/include/semanage/users.h	2005-09-30 16:18:58.000000000 -0400
+++ new/libsemanage/include/semanage/users.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-#ifndef _SEMANAGE_USERS_H_
-#define _SEMANAGE_USERS_H_
-
-#include <stddef.h>
-#include <semanage/user_record.h>
-#include <semanage/handle.h>
-
-extern int semanage_user_add(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
-
-extern int semanage_user_modify(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data);
-
-extern int semanage_user_del(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key);
-
-extern int semanage_user_query(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t** response);
-
-extern int semanage_user_exists(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	int* response);
-
-extern int semanage_user_count(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_user_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_user_list(
-	semanage_handle_t* handle,
-	semanage_user_t*** records,
-	size_t* count);
-
-#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/users_local.h	2005-10-19 15:44:13.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_USERS_LOCAL_H_
+#define _SEMANAGE_USERS_LOCAL_H_
+
+#include <stddef.h>
+#include <semanage/user_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_user_add_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data);
+
+extern int semanage_user_modify_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data);
+
+extern int semanage_user_del_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key);
+
+extern int semanage_user_query_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t** response);
+
+extern int semanage_user_exists_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	int* response);
+
+extern int semanage_user_count_local(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_user_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_user_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_user_list_local(
+	semanage_handle_t* handle,
+	semanage_user_t*** records,
+	size_t* count);
+
+#endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/users_policy.h new/libsemanage/include/semanage/users_policy.h
--- old/libsemanage/include/semanage/users_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/users_policy.h	2005-10-19 15:22:47.000000000 -0400
@@ -0,0 +1,33 @@
+#ifndef _SEMANAGE_USERS_POLICY_H_
+#define _SEMANAGE_USERS_POLICY_H_
+
+#include <stddef.h>
+#include <semanage/handle.h> 
+#include <semanage/user_record.h>
+
+extern int semanage_user_query(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t** response);
+
+extern int semanage_user_exists(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	int* response);
+
+extern int semanage_user_count(
+	semanage_handle_t* handle,
+	int* response);
+
+extern int semanage_user_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_user_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_user_list(
+	semanage_handle_t* handle,
+	semanage_user_t*** records,
+	size_t* count);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans.c new/libsemanage/src/booleans.c
--- old/libsemanage/src/booleans.c	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/src/booleans.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,96 +0,0 @@
-#include <semanage/boolean_record.h>
-
-typedef semanage_bool_key_t record_key_t;
-typedef semanage_bool_t record_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_file;
-typedef struct dbase_file dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <semanage/booleans.h>
-#include "handle.h"
-#include "database.h"
-
-/* Record base functions */
-record_table_t SEMANAGE_BOOL_RTABLE = {
-	.create      = semanage_bool_create,
-	.key_extract = semanage_bool_key_extract,
-	.key_free    = semanage_bool_key_free,
-	.clone       = semanage_bool_clone,
-	.compare     = semanage_bool_compare,
-	.free        = semanage_bool_free,
-};
-
-int semanage_bool_add(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
-}
-
-int semanage_bool_modify(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);	
-	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
-}
-
-int semanage_bool_del(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->del(handle, dconfig->dbase, key);
-}
-
-int semanage_bool_query(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	semanage_bool_t** response) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
-}
-
-int semanage_bool_exists(
-	semanage_handle_t* handle,
-	semanage_bool_key_t* key,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
-}
-
-int semanage_bool_count(
-	semanage_handle_t* handle,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->count(handle, dconfig->dbase, response);
-}
-
-int semanage_bool_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_bool_t* record,
-	                void* varg),
-	void* handler_arg) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
-}
-
-int semanage_bool_list(
-	semanage_handle_t* handle,
-	semanage_bool_t*** records,
-	size_t* count) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase(handle);
-	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/src/booleans_file.c	2005-10-19 15:41:06.000000000 -0400
@@ -40,7 +40,7 @@ static int bool_parse(
 
 }
 
-/* BOOL RECORD: metod table (booleans.c) */
+/* BOOL RECORD: metod table (booleans_local.c) */
 extern record_table_t SEMANAGE_BOOL_RTABLE;
 
 /* BOOL RECORD: FILE extension: method table */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_local.c	2005-10-19 15:46:42.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/boolean_record.h>
+
+typedef semanage_bool_key_t record_key_t;
+typedef semanage_bool_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/booleans_local.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_BOOL_RTABLE = {
+	.create      = semanage_bool_create,
+	.key_extract = semanage_bool_key_extract,
+	.key_free    = semanage_bool_key_free,
+	.clone       = semanage_bool_clone,
+	.compare     = semanage_bool_compare,
+	.free        = semanage_bool_free,
+};
+
+int semanage_bool_add_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_bool_modify_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_bool_del_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_bool_query_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_bool_exists_local(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_bool_count_local(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_bool_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_bool_list_local(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policy.c new/libsemanage/src/booleans_policy.c
--- old/libsemanage/src/booleans_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_policy.c	2005-10-19 16:10:04.000000000 -0400
@@ -0,0 +1,196 @@
+#include <sepol/boolean_record.h>
+
+typedef sepol_bool_key_t record_key_t;
+typedef sepol_bool_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_direct;
+typedef struct dbase_direct dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/boolean_record.h>
+#include "handle.h"
+#include "database.h"
+#include "booleans_policy.h"
+#include "debug.h"
+
+static inline int semanage2sepol_key(
+	semanage_bool_key_t* semanage_key,
+	sepol_bool_key_t** sepol_key) {
+	
+	*sepol_key = (sepol_bool_key_t*) semanage_key;
+	return STATUS_SUCCESS;
+}
+
+
+static inline int semanage2sepol_data(
+	semanage_bool_t* semanage_data,
+	sepol_bool_t** sepol_data) {
+
+	*sepol_data = (sepol_bool_t*) semanage_data;
+	return STATUS_SUCCESS;
+}
+
+/* BOOLEAN RECORD (SEPOL): method table */
+record_table_t SEPOL_BOOL_RTABLE = {
+	.create      = sepol_bool_create,
+	.key_extract = sepol_bool_key_extract,
+	.key_free    = sepol_bool_key_free,
+	.clone       = sepol_bool_clone,
+	.compare     = sepol_bool_compare,
+	.free        = sepol_bool_free,
+};
+
+int semanage_bool_add(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_bool_dbase_policy(handle);
+	sepol_bool_t* sepol_data;
+	sepol_bool_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->add(handle, dconfig->dbase, 
+			sepol_key, sepol_data) < 0)
+		goto err;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_bool_modify_policy(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_bool_t* sepol_data;
+	sepol_bool_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->modify(handle, dconfig->dbase,
+			sepol_key, sepol_data) <  0)
+		goto err;
+
+	return STATUS_SUCCESS;
+	
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_bool_del(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key) {
+
+	dbase_config_t* dconfig = 
+		semanage_bool_dbase_policy(handle);
+	sepol_bool_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_bool_query(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_bool_exists(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_bool_dbase_policy(handle);
+	sepol_bool_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->exists(handle, dconfig->dbase, 
+			sepol_key, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_bool_count(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_bool_dbase_policy(handle);
+
+	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_bool_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	handle = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_bool_list(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count) {
+
+	/* Stub */
+	handle = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_SUCCESS;
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policydb.c new/libsemanage/src/booleans_policydb.c
--- old/libsemanage/src/booleans_policydb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.c	2005-10-19 16:07:18.000000000 -0400
@@ -0,0 +1,49 @@
+#include <sepol/boolean_record.h>
+
+typedef sepol_bool_t record_t;
+typedef sepol_bool_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <sepol/booleans.h>
+#include <sepol/policydb.h>
+#include "booleans_policydb.h"
+#include "debug.h"
+#include "database_policydb.h"
+#include "handle.h"
+#include "semanage_store.h"
+
+/* BOOLEAN RECORD (SEPOL): method table (booleans_policy.c) */
+extern record_table_t SEPOL_BOOL_RTABLE;
+
+/* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
+record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
+	.add         = NULL, /* FIXME */
+	.modify      = NULL, /* FIXME */
+	.iterate     = sepol_bool_iterate,
+};
+
+int bool_policydb_dbase_init(
+	dbase_config_t* dconfig) {
+
+	if (dbase_policydb_init(
+		"policy.kern",
+		&SEPOL_BOOL_RTABLE, 
+		&SEMANAGE_BOOL_POLICYDB_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_policydb_dbase_release(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+
+	dbase_policydb_release(handle, dconfig->dbase);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policydb.h new/libsemanage/src/booleans_policydb.h
--- old/libsemanage/src/booleans_policydb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_policydb.h	2005-10-19 16:07:51.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
+#define _SEMANAGE_BOOLEANS_POLICYDB_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+int bool_policydb_dbase_init(
+	dbase_config_t* dconfig);
+
+void bool_policydb_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/booleans_policy.h new/libsemanage/src/booleans_policy.h
--- old/libsemanage/src/booleans_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_policy.h	2005-10-19 16:08:44.000000000 -0400
@@ -0,0 +1,25 @@
+#ifndef _SEMANAGE_BOOLEANS_POLICY_INTERNAL_H_
+#define _SEMANAGE_BOOLEANS_POLICY_INTERNAL_H_
+
+#include <semanage/handle.h> 
+#include <semanage/boolean_record.h>
+#include <semanage/booleans_policy.h>
+
+/* BOOLEAN RECORD (SEPOL): method table */
+extern record_table_t SEPOL_BOOL_RTABLE;
+
+extern int semanage_bool_add(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_modify(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_del(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-19 12:13:26.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-19 16:08:31.000000000 -0400
@@ -35,10 +35,8 @@
 #include "booleans_file.h"
 #include "users_policydb.h"
 #include "ports_policydb.h"
-#if 0
 #include "interfaces_policydb.h"
 #include "booleans_policydb.h"
-#endif
 
 #include "debug.h"
 #include "handle.h"
@@ -92,16 +90,16 @@ int semanage_direct_connect(semanage_han
 
         /* Configure object databases
          * Hardcore DATA FILE backend for now */
-	if (user_file_dbase_init(semanage_user_dbase(sh)) < 0)
+	if (user_file_dbase_init(semanage_user_dbase_local(sh)) < 0)
 		goto err;
 
-	if (port_file_dbase_init(semanage_port_dbase(sh)) < 0)
+	if (port_file_dbase_init(semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(semanage_iface_dbase(sh)) < 0)
+	if (iface_file_dbase_init(semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(semanage_bool_dbase(sh)) < 0)
+	if (bool_file_dbase_init(semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
@@ -112,13 +110,12 @@ int semanage_direct_connect(semanage_han
 
 	if (port_policydb_dbase_init(semanage_port_dbase_policy(sh)) < 0)
 		goto err;
-#if 0
+
 	if (iface_policydb_dbase_init(semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
 	if (bool_policydb_dbase_init(semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
-#endif
 
 	return STATUS_SUCCESS;
 
@@ -147,18 +144,16 @@ static int semanage_direct_disconnect(se
 	sh->sepolh = NULL;
 
 	/* Remove object databases */
-	user_file_dbase_release(sh, semanage_user_dbase(sh));
-	port_file_dbase_release(sh, semanage_port_dbase(sh));
-	iface_file_dbase_release(sh, semanage_iface_dbase(sh));
-	bool_file_dbase_release(sh, semanage_bool_dbase(sh));
+	user_file_dbase_release(sh, semanage_user_dbase_local(sh));
+	port_file_dbase_release(sh, semanage_port_dbase_local(sh));
+	iface_file_dbase_release(sh, semanage_iface_dbase_local(sh));
+	bool_file_dbase_release(sh, semanage_bool_dbase_local(sh));
 	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
 
 	user_policydb_dbase_release(sh, semanage_user_dbase_policy(sh));
 	port_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
-#if 0
 	iface_policydb_dbase_release(sh, semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
-#endif
 
 	return 0;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/handle.h	2005-10-19 16:03:05.000000000 -0400
@@ -73,41 +73,39 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      7
+#define DBASE_COUNT      9
 
-#define DBASE_USERS      0
-#define DBASE_PORTS      1
-#define DBASE_INTERFACES 2
-#define DBASE_BOOLEANS   3
-#define DBASE_SEUSERS    4
+#define DBASE_LOCAL_USERS       0
+#define DBASE_LOCAL_PORTS       1
+#define DBASE_LOCAL_INTERFACES  2
+#define DBASE_LOCAL_BOOLEANS    3
+#define DBASE_SEUSERS           4
 
 #define DBASE_POLICY_USERS      5
 #define DBASE_POLICY_PORTS      6
-#if 0
 #define DBASE_POLICY_INTERFACES 7
 #define DBASE_POLICY_BOOLEANS   8
-#endif
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
 static inline
-dbase_config_t* semanage_user_dbase(semanage_handle_t* handle) {
-        return &handle->dbase[DBASE_USERS];
+dbase_config_t* semanage_user_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_USERS];
 }
 
 static inline 
-dbase_config_t* semanage_port_dbase(semanage_handle_t* handle) {
-        return &handle->dbase[DBASE_PORTS];
+dbase_config_t* semanage_port_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_PORTS];
 }
 
 static inline
-dbase_config_t* semanage_iface_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_INTERFACES];
+dbase_config_t* semanage_iface_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_INTERFACES];
 }
 
 static inline
-dbase_config_t* semanage_bool_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_BOOLEANS];
+dbase_config_t* semanage_bool_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_BOOLEANS];
 }
 
 static inline
@@ -125,7 +123,6 @@ dbase_config_t* semanage_port_dbase_poli
 	return &handle->dbase[DBASE_POLICY_PORTS];
 }
 
-#if 0
 static inline
 dbase_config_t* semanage_iface_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_INTERFACES];
@@ -135,7 +132,6 @@ static inline
 dbase_config_t* semanage_bool_dbase_policy(semanage_handle_t* handle) {
 	return &handle->dbase[DBASE_POLICY_BOOLEANS];
 }
-#endif
 
 #endif
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces.c new/libsemanage/src/interfaces.c
--- old/libsemanage/src/interfaces.c	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/src/interfaces.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,96 +0,0 @@
-#include <semanage/iface_record.h>
-
-typedef semanage_iface_key_t record_key_t;
-typedef semanage_iface_t record_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_file;
-typedef struct dbase_file dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <semanage/interfaces.h>
-#include "handle.h"
-#include "database.h"
-
-/* Record base functions */
-record_table_t SEMANAGE_IFACE_RTABLE = {
-	.create      = semanage_iface_create,
-	.key_extract = semanage_iface_key_extract,
-	.key_free    = semanage_iface_key_free,
-	.clone       = semanage_iface_clone,
-	.compare     = semanage_iface_compare,
-	.free        = semanage_iface_free,
-};
-
-int semanage_iface_add(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
-}
-
-int semanage_iface_modify(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);	
-	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
-}
-
-int semanage_iface_del(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->del(handle, dconfig->dbase, key);
-}
-
-int semanage_iface_query(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	semanage_iface_t** response) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
-}
-
-int semanage_iface_exists(
-	semanage_handle_t* handle,
-	semanage_iface_key_t* key,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
-}
-
-int semanage_iface_count(
-	semanage_handle_t* handle,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->count(handle, dconfig->dbase, response);
-}
-
-int semanage_iface_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_iface_t* record,
-	                void* varg),
-	void* handler_arg) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
-}
-
-int semanage_iface_list(
-	semanage_handle_t* handle,
-	semanage_iface_t*** records,
-	size_t* count) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase(handle);
-	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-10-14 13:15:51.000000000 -0400
+++ new/libsemanage/src/interfaces_file.c	2005-10-19 15:41:16.000000000 -0400
@@ -40,7 +40,7 @@ static int iface_parse(
 
 }
 
-/* IFACE RECORD: metod table (interfaces.c) */
+/* IFACE RECORD: metod table (interfaces_local.c) */
 extern record_table_t SEMANAGE_IFACE_RTABLE;
 
 /* IFACE RECORD: FILE extension: method table */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/interfaces_local.c	2005-10-19 15:46:34.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/iface_record.h>
+
+typedef semanage_iface_key_t record_key_t;
+typedef semanage_iface_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/interfaces_local.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_IFACE_RTABLE = {
+	.create      = semanage_iface_create,
+	.key_extract = semanage_iface_key_extract,
+	.key_free    = semanage_iface_key_free,
+	.clone       = semanage_iface_clone,
+	.compare     = semanage_iface_compare,
+	.free        = semanage_iface_free,
+};
+
+int semanage_iface_add_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_iface_modify_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_iface_del_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_iface_query_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_iface_exists_local(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_iface_count_local(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_iface_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_iface_list_local(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policy.c new/libsemanage/src/interfaces_policy.c
--- old/libsemanage/src/interfaces_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/interfaces_policy.c	2005-10-19 16:09:48.000000000 -0400
@@ -0,0 +1,196 @@
+#include <sepol/iface_record.h>
+
+typedef sepol_iface_key_t record_key_t;
+typedef sepol_iface_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_direct;
+typedef struct dbase_direct dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/iface_record.h>
+#include "handle.h"
+#include "database.h"
+#include "interfaces_policy.h"
+#include "debug.h"
+
+static inline int semanage2sepol_key(
+	semanage_iface_key_t* semanage_key,
+	sepol_iface_key_t** sepol_key) {
+	
+	*sepol_key = (sepol_iface_key_t*) semanage_key;
+	return STATUS_SUCCESS;
+}
+
+
+static inline int semanage2sepol_data(
+	semanage_iface_t* semanage_data,
+	sepol_iface_t** sepol_data) {
+
+	*sepol_data = (sepol_iface_t*) semanage_data;
+	return STATUS_SUCCESS;
+}
+
+/* INTERFACE RECORD (SEPOL): method table */
+record_table_t SEPOL_IFACE_RTABLE = {
+	.create      = sepol_iface_create,
+	.key_extract = sepol_iface_key_extract,
+	.key_free    = sepol_iface_key_free,
+	.clone       = sepol_iface_clone,
+	.compare     = sepol_iface_compare,
+	.free        = sepol_iface_free,
+};
+
+int semanage_iface_add(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_iface_dbase_policy(handle);
+	sepol_iface_t* sepol_data;
+	sepol_iface_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->add(handle, dconfig->dbase, 
+			sepol_key, sepol_data) < 0)
+		goto err;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_iface_modify_policy(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data) {
+
+	dbase_config_t* dconfig = 
+		semanage_port_dbase_policy(handle);
+	sepol_iface_t* sepol_data;
+	sepol_iface_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (semanage2sepol_data(data, &sepol_data) < 0)
+		goto err;
+
+	if (dconfig->dtable->modify(handle, dconfig->dbase,
+			sepol_key, sepol_data) <  0)
+		goto err;
+
+	return STATUS_SUCCESS;
+	
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_iface_del(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key) {
+
+	dbase_config_t* dconfig = 
+		semanage_iface_dbase_policy(handle);
+	sepol_iface_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->del(handle, dconfig->dbase, sepol_key) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_iface_query(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t** response) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_iface_exists(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_iface_dbase_policy(handle);
+	sepol_iface_key_t* sepol_key;
+
+	if (semanage2sepol_key(key, &sepol_key) < 0)
+		goto err;
+
+	if (dconfig->dtable->exists(handle, dconfig->dbase, 
+			sepol_key, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_iface_count(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = 
+		semanage_iface_dbase_policy(handle);
+
+	if (dconfig->dtable->count(handle, dconfig->dbase, response) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+int semanage_iface_iterate(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_iface_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	handle = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return STATUS_SUCCESS;
+}
+
+int semanage_iface_list(
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	size_t* count) {
+
+	/* Stub */
+	handle = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_SUCCESS;
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policydb.c new/libsemanage/src/interfaces_policydb.c
--- old/libsemanage/src/interfaces_policydb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.c	2005-10-19 16:06:39.000000000 -0400
@@ -0,0 +1,49 @@
+#include <sepol/iface_record.h>
+
+typedef sepol_iface_t record_t;
+typedef sepol_iface_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <sepol/interfaces.h>
+#include <sepol/policydb.h>
+#include "interfaces_policydb.h"
+#include "debug.h"
+#include "database_policydb.h"
+#include "handle.h"
+#include "semanage_store.h"
+
+/* INTERFACE RECORD (SEPOL): method table (interfaces_policy.c) */
+extern record_table_t SEPOL_IFACE_RTABLE;
+
+/* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
+record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
+	.add         = sepol_iface_add,
+	.modify      = NULL, /* FIXME */
+	.iterate     = sepol_iface_iterate,
+};
+
+int iface_policydb_dbase_init(
+	dbase_config_t* dconfig) {
+
+	if (dbase_policydb_init(
+		"policy.kern",
+		&SEPOL_IFACE_RTABLE, 
+		&SEMANAGE_IFACE_POLICYDB_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void iface_policydb_dbase_release(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+
+	dbase_policydb_release(handle, dconfig->dbase);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policydb.h new/libsemanage/src/interfaces_policydb.h
--- old/libsemanage/src/interfaces_policydb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/interfaces_policydb.h	2005-10-19 16:08:06.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
+#define _SEMANAGE_INTERFACES_POLICYDB_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+int iface_policydb_dbase_init(
+	dbase_config_t* dconfig);
+
+void iface_policydb_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/interfaces_policy.h new/libsemanage/src/interfaces_policy.h
--- old/libsemanage/src/interfaces_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/interfaces_policy.h	2005-10-19 16:02:33.000000000 -0400
@@ -0,0 +1,25 @@
+#ifndef _SEMANAGE_INTERFACES_POLICY_INTERNAL_H_
+#define _SEMANAGE_INTERFACES_POLICY_INTERNAL_H_
+
+#include <semanage/handle.h> 
+#include <semanage/iface_record.h>
+#include <semanage/interfaces_policy.h>
+
+/* INTERFACE RECORD (SEPOL): method table */
+extern record_table_t SEPOL_IFACE_RTABLE;
+
+extern int semanage_iface_add(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_modify(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key,
+	semanage_iface_t* data);
+
+extern int semanage_iface_del(
+	semanage_handle_t* handle,
+	semanage_iface_key_t* key);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-19 15:47:37.000000000 -0400
@@ -8,10 +8,10 @@ int semanage_base_merge_components(
 	semanage_handle_t* handle) {
 
 	//dbase_config_t* modules = dbase_modules_dbase(handle);
-	dbase_config_t* interfaces = semanage_iface_dbase(handle);
-	dbase_config_t* booleans = semanage_bool_dbase(handle);
-	dbase_config_t* users = semanage_user_dbase(handle);
-	dbase_config_t* ports = semanage_port_dbase(handle);
+	dbase_config_t* interfaces = semanage_iface_dbase_local(handle);
+	dbase_config_t* booleans = semanage_bool_dbase_local(handle);
+	dbase_config_t* users = semanage_user_dbase_local(handle);
+	dbase_config_t* ports = semanage_port_dbase_local(handle);
 
 #if 0
 	if (modules->dtable->iterate(handle,
@@ -46,10 +46,10 @@ int semanage_commit_components(
 	semanage_handle_t* handle) {
 
 	//dbase_config_t* modules = semanage_modules_dbase(handle);
-	dbase_config_t* interfaces = semanage_iface_dbase(handle);
-	dbase_config_t* booleans = semanage_bool_dbase(handle);
-	dbase_config_t* users = semanage_user_dbase(handle);
-	dbase_config_t* ports = semanage_port_dbase(handle);
+	dbase_config_t* interfaces = semanage_iface_dbase_local(handle);
+	dbase_config_t* booleans = semanage_bool_dbase_local(handle);
+	dbase_config_t* users = semanage_user_dbase_local(handle);
+	dbase_config_t* ports = semanage_port_dbase_local(handle);
 	dbase_config_t* seusers = semanage_seuser_dbase(handle);
 
 #if 0
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports.c new/libsemanage/src/ports.c
--- old/libsemanage/src/ports.c	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/ports.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,96 +0,0 @@
-#include <semanage/port_record.h>
-
-typedef semanage_port_key_t record_key_t;
-typedef semanage_port_t record_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_file;
-typedef struct dbase_file dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <semanage/ports.h>
-#include "database.h"
-#include "handle.h"
-
-/* Port base functions */
-record_table_t SEMANAGE_PORT_RTABLE = {
-	.create      = semanage_port_create,
-	.key_extract = semanage_port_key_extract,
-	.key_free    = semanage_port_key_free,
-	.clone       = semanage_port_clone,
-	.compare     = semanage_port_compare,
-	.free        = semanage_port_free,
-};
-
-int semanage_port_add(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);	
-	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
-}
-
-int semanage_port_modify(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t* data) {
-	
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
-}
-
-int semanage_port_del(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->del(handle, dconfig->dbase, key);
-}
-
-int semanage_port_query(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t** response) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
-}
-
-int semanage_port_exists(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
-}
-
-int semanage_port_count(
-	semanage_handle_t* handle,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->count(handle, dconfig->dbase, response);
-}
-
-int semanage_port_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
-	void* handler_arg) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
-}
-
-int semanage_port_list(
-	semanage_handle_t* handle,
-	semanage_port_t*** records,
-	size_t* count) {
-
-	dbase_config_t* dconfig = semanage_port_dbase(handle);
-	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-07 16:46:45.000000000 -0400
+++ new/libsemanage/src/ports_file.c	2005-10-19 15:41:35.000000000 -0400
@@ -125,7 +125,7 @@ static int port_parse(
 	return STATUS_ERR;
 }
 
-/* PORT RECORD: method table (ports.c) */
+/* PORT RECORD: method table (ports_local.c) */
 extern record_table_t SEMANAGE_PORT_RTABLE;
 
 /* PORT RECORD: FILE extension: method table */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/ports_local.c	2005-10-19 15:45:48.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/port_record.h>
+
+typedef semanage_port_key_t record_key_t;
+typedef semanage_port_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/ports_local.h>
+#include "database.h"
+#include "handle.h"
+
+/* Port base functions */
+record_table_t SEMANAGE_PORT_RTABLE = {
+	.create      = semanage_port_create,
+	.key_extract = semanage_port_key_extract,
+	.key_free    = semanage_port_key_free,
+	.clone       = semanage_port_clone,
+	.compare     = semanage_port_compare,
+	.free        = semanage_port_free,
+};
+
+int semanage_port_add_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);	
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_port_modify_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t* data) {
+	
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_port_del_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_port_query_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	semanage_port_t** response) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_port_exists_local(
+	semanage_handle_t* handle,
+	semanage_port_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_port_count_local(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_port_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_port_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_port_list_local(
+	semanage_handle_t* handle,
+	semanage_port_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policy.c new/libsemanage/src/ports_policy.c
--- old/libsemanage/src/ports_policy.c	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/ports_policy.c	2005-10-19 15:17:05.000000000 -0400
@@ -43,7 +43,7 @@ record_table_t SEPOL_PORT_RTABLE = {
 	.free        = sepol_port_free,
 };
 
-int semanage_port_add_base(
+int semanage_port_add(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t* data) {
@@ -70,7 +70,7 @@ int semanage_port_add_base(
 	return STATUS_ERR;
 }
 
-int semanage_port_modify_base(
+int semanage_port_modify(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t* data) {
@@ -97,7 +97,7 @@ int semanage_port_modify_base(
 	return STATUS_ERR;
 }
 
-int semanage_port_del_base(
+int semanage_port_del(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key) {
 
@@ -118,7 +118,7 @@ int semanage_port_del_base(
 	return STATUS_ERR;
 }
 
-int semanage_port_query_base(
+int semanage_port_query(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t** response) {
@@ -130,7 +130,7 @@ int semanage_port_query_base(
 	return STATUS_SUCCESS;
 }
 
-int semanage_port_exists_base(
+int semanage_port_exists(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	int* response) {
@@ -153,7 +153,7 @@ int semanage_port_exists_base(
 	return STATUS_ERR;
 }
 
-int semanage_port_count_base(
+int semanage_port_count(
 	semanage_handle_t* handle,
 	int* response) {
 
@@ -170,7 +170,7 @@ int semanage_port_count_base(
 	return STATUS_ERR;
 }
 
-int semanage_port_iterate_base(
+int semanage_port_iterate(
 	semanage_handle_t* handle,
 	int (*handler) (semanage_port_t* record,
 	                void* varg),
@@ -183,7 +183,7 @@ int semanage_port_iterate_base(
 	return STATUS_SUCCESS;
 }
 
-int semanage_port_list_base(
+int semanage_port_list(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
 	size_t* count) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policy.h new/libsemanage/src/ports_policy.h
--- old/libsemanage/src/ports_policy.h	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/ports_policy.h	2005-10-19 15:23:50.000000000 -0400
@@ -3,47 +3,23 @@
 
 #include <semanage/handle.h> 
 #include <semanage/port_record.h>
+#include <semanage/ports_policy.h>
 
 /* PORT RECORD (SEPOL): method table */
 extern record_table_t SEPOL_PORT_RTABLE;
 
-extern int semanage_port_add_policy(
+extern int semanage_port_add(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t* data);
 
-extern int semanage_port_modify_policy(
+extern int semanage_port_modify(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key,
 	semanage_port_t* data);
 
-extern int semanage_port_del_policy(
+extern int semanage_port_del(
 	semanage_handle_t* handle,
 	semanage_port_key_t* key);
 
-extern int semanage_port_query_policy(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	semanage_port_t** response);
-
-extern int semanage_port_exists_policy(
-	semanage_handle_t* handle,
-	semanage_port_key_t* key,
-	int* response);
-
-extern int semanage_port_count_policy(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_port_iterate_policy(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_port_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_port_list_policy(
-	semanage_handle_t* handle,
-	semanage_port_t*** records,
-	size_t* count);
-
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users.c new/libsemanage/src/users.c
--- old/libsemanage/src/users.c	2005-10-04 10:51:22.000000000 -0400
+++ new/libsemanage/src/users.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,96 +0,0 @@
-#include <semanage/user_record.h>
-
-typedef semanage_user_key_t record_key_t;
-typedef semanage_user_t record_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_file;
-typedef struct dbase_file dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <semanage/users.h>
-#include "handle.h"
-#include "database.h"
-
-/* Record base functions */
-record_table_t SEMANAGE_USER_RTABLE = {
-	.create      = semanage_user_create,
-	.key_extract = semanage_user_key_extract,
-	.key_free    = semanage_user_key_free,
-	.clone       = semanage_user_clone,
-	.compare     = semanage_user_compare,
-	.free        = semanage_user_free,
-};
-
-int semanage_user_add(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
-}
-
-int semanage_user_modify(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t* data) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);	
-	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
-}
-
-int semanage_user_del(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->del(handle, dconfig->dbase, key);
-}
-
-int semanage_user_query(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t** response) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
-}
-
-int semanage_user_exists(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
-}
-
-int semanage_user_count(
-	semanage_handle_t* handle,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->count(handle, dconfig->dbase, response);
-}
-
-int semanage_user_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
-	void* handler_arg) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
-}
-
-int semanage_user_list(
-	semanage_handle_t* handle,
-	semanage_user_t*** records,
-	size_t* count) {
-
-	dbase_config_t* dconfig = semanage_user_dbase(handle);
-	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-07 16:46:45.000000000 -0400
+++ new/libsemanage/src/users_file.c	2005-10-19 15:41:56.000000000 -0400
@@ -218,7 +218,7 @@ static int user_parse(
 	return STATUS_ERR;
 }
 
-/* USER RECORD: metod table (users.c) */
+/* USER RECORD: metod table (users_local.c) */
 extern record_table_t SEMANAGE_USER_RTABLE;
 
 /* USER RECORD: FILE extension: method table */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/users_local.c	2005-10-19 15:45:54.000000000 -0400
@@ -0,0 +1,96 @@
+#include <semanage/user_record.h>
+
+typedef semanage_user_key_t record_key_t;
+typedef semanage_user_t record_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/users_local.h>
+#include "handle.h"
+#include "database.h"
+
+/* Record base functions */
+record_table_t SEMANAGE_USER_RTABLE = {
+	.create      = semanage_user_create,
+	.key_extract = semanage_user_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_clone,
+	.compare     = semanage_user_compare,
+	.free        = semanage_user_free,
+};
+
+int semanage_user_add_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->add(handle, dconfig->dbase, key, data);
+}
+
+int semanage_user_modify_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t* data) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);	
+	return dconfig->dtable->modify(handle, dconfig->dbase, key, data);
+}
+
+int semanage_user_del_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->del(handle, dconfig->dbase, key);
+}
+
+int semanage_user_query_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	semanage_user_t** response) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->query(handle, dconfig->dbase, key, response);
+}
+
+int semanage_user_exists_local(
+	semanage_handle_t* handle,
+	semanage_user_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->exists(handle, dconfig->dbase, key, response);
+}
+
+int semanage_user_count_local(
+	semanage_handle_t* handle,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->count(handle, dconfig->dbase, response);
+}
+
+int semanage_user_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_user_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->iterate(handle, dconfig->dbase, handler, handler_arg);
+}
+
+int semanage_user_list_local(
+	semanage_handle_t* handle,
+	semanage_user_t*** records,
+	size_t* count) {
+
+	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
+	return dconfig->dtable->list(handle, dconfig->dbase, records, count);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policy.c new/libsemanage/src/users_policy.c
--- old/libsemanage/src/users_policy.c	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/users_policy.c	2005-10-19 15:32:27.000000000 -0400
@@ -43,7 +43,7 @@ record_table_t SEPOL_USER_RTABLE = {
 	.free        = sepol_user_free,
 };
 
-int semanage_user_add_policy(
+int semanage_user_add(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	semanage_user_t* data) {
@@ -97,7 +97,7 @@ int semanage_user_modify_policy(
 	return STATUS_ERR;
 }
 
-int semanage_user_del_policy(
+int semanage_user_del(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key) {
 
@@ -118,7 +118,7 @@ int semanage_user_del_policy(
 	return STATUS_ERR;
 }
 
-int semanage_user_query_policy(
+int semanage_user_query(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	semanage_user_t** response) {
@@ -130,7 +130,7 @@ int semanage_user_query_policy(
 	return STATUS_SUCCESS;
 }
 
-int semanage_user_exists_policy(
+int semanage_user_exists(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	int* response) {
@@ -153,7 +153,7 @@ int semanage_user_exists_policy(
 	return STATUS_ERR;
 }
 
-int semanage_user_count_policy(
+int semanage_user_count(
 	semanage_handle_t* handle,
 	int* response) {
 
@@ -170,7 +170,7 @@ int semanage_user_count_policy(
 	return STATUS_ERR;
 }
 
-int semanage_user_iterate_policy(
+int semanage_user_iterate(
 	semanage_handle_t* handle,
 	int (*handler) (semanage_user_t* record,
 	                void* varg),
@@ -183,7 +183,7 @@ int semanage_user_iterate_policy(
 	return STATUS_SUCCESS;
 }
 
-int semanage_user_list_policy(
+int semanage_user_list(
 	semanage_handle_t* handle,
 	semanage_user_t*** records,
 	size_t* count) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policy.h new/libsemanage/src/users_policy.h
--- old/libsemanage/src/users_policy.h	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/users_policy.h	2005-10-19 15:32:34.000000000 -0400
@@ -3,47 +3,23 @@
 
 #include <semanage/handle.h> 
 #include <semanage/user_record.h>
+#include <semanage/users_policy.h>
 
 /* USER RECORD (SEPOL): method table */
 extern record_table_t SEPOL_USER_RTABLE;
 
-extern int semanage_user_add_policy(
+extern int semanage_user_add(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	semanage_user_t* data);
 
-extern int semanage_user_modify_policy(
+extern int semanage_user_modify(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key,
 	semanage_user_t* data);
 
-extern int semanage_user_del_policy(
+extern int semanage_user_del(
 	semanage_handle_t* handle,
 	semanage_user_key_t* key);
 
-extern int semanage_user_query_policy(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	semanage_user_t** response);
-
-extern int semanage_user_exists_policy(
-	semanage_handle_t* handle,
-	semanage_user_key_t* key,
-	int* response);
-
-extern int semanage_user_count_policy(
-	semanage_handle_t* handle,
-	int* response);
-
-extern int semanage_user_iterate_policy(
-	semanage_handle_t* handle,
-	int (*handler) (semanage_user_t* record,
-	                void* varg),
-	void* handler_arg);
-
-extern int semanage_user_list_policy(
-	semanage_handle_t* handle,
-	semanage_user_t*** records,
-	size_t* count);
-
 #endif

--------------030206040403010205010803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
