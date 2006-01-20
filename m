Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0NDm7Xf013629
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2006 08:48:07 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0NDktM3013978
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2006 13:46:55 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k0NDlAtd003854
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2006 08:47:10 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k0NDlAeH003853
	for selinux@tycho.nsa.gov; Mon, 23 Jan 2006 08:47:10 -0500
Message-ID: <43D1737F.6010002@cornell.edu>
Date: Fri, 20 Jan 2006 16:34:23 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Rename seuser -> seuser_local
Content-Type: multipart/mixed;
 boundary="------------060208050300090700030509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060208050300090700030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Seuser functions and dbase have incorrect names, since originally I did 
not think we'd have seusers.system. I must have asked about this, but 
regardless, I now think that a systems file will likely be necessary, so 
this patch renames all seuser-related things to _local, which leaves 
space for a _policy set of functions. It updates dependencies and 
manpages. This is an API change.

I think we should add users_extra.system and seusers.system into the 
package format.
 


--------------060208050300090700030509
Content-Type: text/x-patch;
 name="libsemanage.local_seuser.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.local_seuser.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2006-01-04 10:18:11.000000000 -0700
+++ new/libsemanage/include/semanage/semanage.h	2006-01-20 16:00:22.000000000 -0700
@@ -42,7 +42,7 @@
 #include <semanage/users_policy.h>
 #include <semanage/fcontexts_local.h>
 #include <semanage/fcontexts_policy.h>
-#include <semanage/seusers.h>
+#include <semanage/seusers_local.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
 #include <semanage/interfaces_local.h>
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2006-01-13 06:37:09.000000000 -0700
+++ new/libsemanage/include/semanage/seusers.h	1969-12-31 17:00:00.000000000 -0700
@@ -1,44 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEMANAGE_SEUSERS_H_
-#define _SEMANAGE_SEUSERS_H_
-
-#include <semanage/seuser_record.h>
-#include <semanage/handle.h>
-
-extern int semanage_seuser_modify(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data);
-
-extern int semanage_seuser_del(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key);
-
-extern int semanage_seuser_query(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	semanage_seuser_t** response);
-
-extern int semanage_seuser_exists(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	int* response);
-
-extern int semanage_seuser_count(
-	semanage_handle_t* handle,
-	unsigned int* response);
-
-extern int semanage_seuser_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (
-		const semanage_seuser_t* record,
-		void* varg),
-	void* handler_arg);
-
-extern int semanage_seuser_list(
-	semanage_handle_t* handle,
-	semanage_seuser_t*** records,
-	unsigned int* count);
-
-#endif 
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/seusers_local.h new/libsemanage/include/semanage/seusers_local.h
--- old/libsemanage/include/semanage/seusers_local.h	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/include/semanage/seusers_local.h	2006-01-20 16:00:08.000000000 -0700
@@ -0,0 +1,44 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_SEUSERS_H_
+#define _SEMANAGE_SEUSERS_H_
+
+#include <semanage/seuser_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_seuser_modify_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data);
+
+extern int semanage_seuser_del_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key);
+
+extern int semanage_seuser_query_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	semanage_seuser_t** response);
+
+extern int semanage_seuser_exists_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	int* response);
+
+extern int semanage_seuser_count_local(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_seuser_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
+	void* handler_arg);
+
+extern int semanage_seuser_list_local(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	unsigned int* count);
+
+#endif 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_bool_del_local.3 new/libsemanage/man/man3/semanage_bool_del_local.3
--- old/libsemanage/man/man3/semanage_bool_del_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_bool_del_local.3	2006-01-20 16:14:16.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_del_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_del_local.3 new/libsemanage/man/man3/semanage_fcontext_del_local.3
--- old/libsemanage/man/man3/semanage_fcontext_del_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_fcontext_del_local.3	2006-01-20 16:14:35.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_del_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_iface_del_local.3 new/libsemanage/man/man3/semanage_iface_del_local.3
--- old/libsemanage/man/man3/semanage_iface_del_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_iface_del_local.3	2006-01-20 16:14:10.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_del_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_port_del_local.3 new/libsemanage/man/man3/semanage_port_del_local.3
--- old/libsemanage/man/man3/semanage_port_del_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_port_del_local.3	2006-01-20 16:14:27.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_del_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_count.3 new/libsemanage/man/man3/semanage_seuser_count.3
--- old/libsemanage/man/man3/semanage_seuser_count.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_count.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_count_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_count_local.3 new/libsemanage/man/man3/semanage_seuser_count_local.3
--- old/libsemanage/man/man3/semanage_seuser_count_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_count_local.3	2006-01-04 17:29:50.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_del_local.3 new/libsemanage/man/man3/semanage_seuser_del_local.3
--- old/libsemanage/man/man3/semanage_seuser_del_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_del_local.3	2006-01-20 16:12:35.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_del_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_exists.3 new/libsemanage/man/man3/semanage_seuser_exists.3
--- old/libsemanage/man/man3/semanage_seuser_exists.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_exists.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_exists_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_exists_local.3 new/libsemanage/man/man3/semanage_seuser_exists_local.3
--- old/libsemanage/man/man3/semanage_seuser_exists_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_exists_local.3	2006-01-04 16:30:54.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_iterate.3 new/libsemanage/man/man3/semanage_seuser_iterate.3
--- old/libsemanage/man/man3/semanage_seuser_iterate.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_iterate.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_iterate_local.3 new/libsemanage/man/man3/semanage_seuser_iterate_local.3
--- old/libsemanage/man/man3/semanage_seuser_iterate_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_iterate_local.3	2006-01-04 16:55:35.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_list.3 new/libsemanage/man/man3/semanage_seuser_list.3
--- old/libsemanage/man/man3/semanage_seuser_list.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_list.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_list_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_list_local.3 new/libsemanage/man/man3/semanage_seuser_list_local.3
--- old/libsemanage/man/man3/semanage_seuser_list_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_list_local.3	2006-01-04 17:09:26.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_modify.3 new/libsemanage/man/man3/semanage_seuser_modify.3
--- old/libsemanage/man/man3/semanage_seuser_modify.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_modify.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_modify_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_modify_local.3 new/libsemanage/man/man3/semanage_seuser_modify_local.3
--- old/libsemanage/man/man3/semanage_seuser_modify_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_modify_local.3	2006-01-04 08:42:28.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_query.3 new/libsemanage/man/man3/semanage_seuser_query.3
--- old/libsemanage/man/man3/semanage_seuser_query.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_query.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_query_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_query_local.3 new/libsemanage/man/man3/semanage_seuser_query_local.3
--- old/libsemanage/man/man3/semanage_seuser_query_local.3	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_query_local.3	2006-01-04 16:24:34.000000000 -0700
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_count_local.3 new/libsemanage/man/man3/semanage_user_count_local.3
--- old/libsemanage/man/man3/semanage_user_count_local.3	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_count_local.3	2006-01-20 16:13:05.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_count_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_count_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_count \-
 return the number of users users in the persistent policy
@@ -33,8 +33,8 @@ return the number of context specificati
 .B semanage_fcontext_count_local \- 
 return the number of context specifications in the local store
 .br
-.B semanage_seuser_count \- 
-return the number of seusers (login mappings)
+.B semanage_seuser_count_local \- 
+return the number of seusers (login mappings) in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_policy.h>
@@ -59,7 +59,7 @@ return the number of seusers (login mapp
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_del_local.3 new/libsemanage/man/man3/semanage_user_del_local.3
--- old/libsemanage/man/man3/semanage_user_del_local.3	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_del_local.3	2006-01-20 16:12:58.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_del_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_del_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_del_local \- 
 delete a user from the local store
@@ -15,8 +15,8 @@ delete a network interface from the loca
 .B semanage_fcontext_del_local \- 
 delete a context specification from the local store
 .br
-.B semanage_seuser_del \- 
-delete a seuser (login mapping)
+.B semanage_seuser_del_local \- 
+delete a seuser (login mapping) from the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_local.h> 
@@ -29,7 +29,7 @@ delete a seuser (login mapping)
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_exists_local.3 new/libsemanage/man/man3/semanage_user_exists_local.3
--- old/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-20 16:13:14.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_exists_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_exists_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_exists \-
 check if a user exists in the persistent policy
@@ -33,8 +33,8 @@ check if a context specification exists 
 .B semanage_fcontext_exists_local \- 
 check if a context specification exists in the local store
 .br
-.B semanage_seuser_exists \- 
-check if a seuser exists (login mapping)
+.B semanage_seuser_exists_local \- 
+check if a seuser (login mapping) exists in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_policy.h>
@@ -59,7 +59,7 @@ check if a seuser exists (login mapping)
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_iterate_local.3 new/libsemanage/man/man3/semanage_user_iterate_local.3
--- old/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-20 16:13:32.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_iterate_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_iterate_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_iterate \-
 execute a callback for all users users in the persistent policy
@@ -33,8 +33,8 @@ execute a callback for all context speci
 .B semanage_fcontext_iterate_local \- 
 execute a callback for all context specifications in the local store
 .br
-.B semanage_seuser_iterate \- 
-execute a callback for all seusers (login mappings)
+.B semanage_seuser_iterate_local \- 
+execute a callback for all seusers (login mappings) in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_policy.h>
@@ -59,7 +59,7 @@ execute a callback for all seusers (logi
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_list_local.3 new/libsemanage/man/man3/semanage_user_list_local.3
--- old/libsemanage/man/man3/semanage_user_list_local.3	2006-01-13 06:37:09.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_list_local.3	2006-01-20 16:13:54.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_list_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_list_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_list \-
 list all users users in the persistent policy
@@ -33,8 +33,8 @@ list all context specifications in the p
 .B semanage_fcontext_list_local \- 
 list all context specifications in the local store
 .br
-.B semanage_seuser_list \- 
-list all seusers (login mappings)
+.B semanage_seuser_list_local \- 
+list all seusers (login mappings) in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_policy.h>
@@ -59,7 +59,7 @@ list all seusers (login mappings)
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_modify_local.3 new/libsemanage/man/man3/semanage_user_modify_local.3
--- old/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-13 06:37:09.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-20 16:13:42.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_modify_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_modify_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_modify_local \- 
 add or update a user in the local store
@@ -15,8 +15,8 @@ add or update an interface in the local 
 .B semanage_fcontext_modify_local \- 
 add or override a context specification in the local store
 .br
-.B semanage_seuser_modify \- 
-add or update a seuser (login mapping)
+.B semanage_seuser_modify_local \- 
+add or update a seuser (login mapping) in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_local.h> 
@@ -29,7 +29,7 @@ add or update a seuser (login mapping)
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/man/man3/semanage_user_query_local.3 new/libsemanage/man/man3/semanage_user_query_local.3
--- old/libsemanage/man/man3/semanage_user_query_local.3	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_query_local.3	2006-01-20 16:13:23.000000000 -0700
@@ -1,4 +1,4 @@
-.TH semanage_user_query_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.TH semanage_user_query_local 3 "20 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
 .B semanage_user_query \-
 query a user in the persistent policy
@@ -33,8 +33,8 @@ query a context specification in the per
 .B semanage_fcontext_query_local \- 
 query a context specification in the local store
 .br
-.B semanage_seuser_query \- 
-query a seuser (login mapping)
+.B semanage_seuser_query_local \- 
+query a seuser (login mapping) in the local store
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_policy.h>
@@ -59,7 +59,7 @@ query a seuser (login mapping)
 .br
 .B #include <semanage/fcontexts_local.h>
 .br
-.B #include <semanage/seusers.h>
+.B #include <semanage/seusers_local.h>
 .sp
 
 .B FUNCTION: 
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-20 16:04:13.000000000 -0700
@@ -139,7 +139,7 @@ int semanage_direct_connect(semanage_han
 		semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(sh, semanage_seuser_dbase(sh)) < 0)
+	if (seuser_file_dbase_init(sh, semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh, "users_extra.system",
@@ -208,7 +208,7 @@ static int semanage_direct_disconnect(se
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
-	seuser_file_dbase_release(semanage_seuser_dbase(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase_local(sh));
 
 	user_extra_file_dbase_release(semanage_user_extra_dbase_system(sh));
 
@@ -399,7 +399,7 @@ static int semanage_direct_commit(semana
 	dbase_config_t* pifaces = semanage_iface_dbase_policy(sh);
 	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t* pfcontexts = semanage_fcontext_dbase_policy(sh);
-	dbase_config_t* seusers = semanage_seuser_dbase(sh);
+	dbase_config_t* seusers = semanage_seuser_dbase_local(sh);
 
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
@@ -503,11 +503,9 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 	}
 
-	/* Validate seusers against policy
-	 * if either policy changed, or seusers changed,
-	 * or we forced a rebuild */
+	/* Validate local seusers against policy */
 	if (sh->do_rebuild || modified || seusers_modified) {
-		if (semanage_seuser_validate(sh, out) < 0) 
+		if (semanage_seuser_validate_local(sh, out) < 0) 
 			goto cleanup;
 	}
 
diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/handle.h	2006-01-20 16:03:54.000000000 -0700
@@ -86,7 +86,7 @@ struct semanage_handle {
 #define DBASE_LOCAL_INTERFACES  4
 #define DBASE_LOCAL_BOOLEANS    5
 #define DBASE_LOCAL_FCONTEXTS	6
-#define DBASE_SEUSERS           7
+#define DBASE_LOCAL_SEUSERS     7
 
 /* Policy */
 #define DBASE_SYSTEM_USERS_EXTRA 8
@@ -141,8 +141,8 @@ dbase_config_t* semanage_fcontext_dbase_
 }
 
 static inline
-dbase_config_t* semanage_seuser_dbase(semanage_handle_t* handle) {
-	return &handle->dbase[DBASE_SEUSERS];
+dbase_config_t* semanage_seuser_dbase_local(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_LOCAL_SEUSERS];
 }
 
 static inline
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/policy_components.c	2006-01-20 16:23:16.000000000 -0700
@@ -199,7 +199,7 @@ int semanage_commit_components(
 		semanage_port_dbase_local(handle),
 		semanage_fcontext_dbase_local(handle),
 		semanage_fcontext_dbase_policy(handle),
-		semanage_seuser_dbase(handle),
+		semanage_seuser_dbase_local(handle),
 		semanage_bool_dbase_active(handle),
 	};
 	const int CCOUNT = sizeof(components)/sizeof(components[0]);
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-20 16:28:01.000000000 -0700
@@ -132,7 +132,7 @@ class Tests:
 	def test_seusers(self,sh):
 		print "Testing seusers..."
 
-		(status, slist, slist_size) = semanage.semanage_seuser_list(sh)
+		(status, slist, slist_size) = semanage.semanage_seuser_list_local(sh)
 		if status < 0:
 			raise Error("Could not list seusers")
 		print "Query status (commit number): ", status
@@ -434,13 +434,13 @@ class Tests:
 			raise Error("Could not extract SEUser key")
                 if self.verbose: print "SEUser key extracted: ", key
 	
-                (status,exists) = semanage.semanage_seuser_exists(sh,key)
+                (status,exists) = semanage.semanage_seuser_exists_local(sh,key)
 		if status < 0:
 			raise Error("Could not check if SEUser exists")
 		if self.verbose: print "Exists status (commit number): ", status
 
 		if exists:
-			(status, old_seuser) = semanage.semanage_seuser_query(sh, key)
+			(status, old_seuser) = semanage.semanage_seuser_query_local(sh, key)
 			if status < 0:
 				raise Error("Could not query old SEUser")
 			if self.verbose: print "Query status (commit number): ", status
@@ -450,7 +450,7 @@ class Tests:
 		if status < 0:
 			raise Error("Could not start semanage transaction")
 
-		status = semanage.semanage_seuser_modify(sh,key,seuser)
+		status = semanage.semanage_seuser_modify_local(sh,key,seuser)
 		if status < 0:
 			raise Error("Could not modify SEUser")
 
@@ -465,13 +465,13 @@ class Tests:
 
 		if not exists:
 			print "Removing seuser..."
-			status = semanage.semanage_seuser_del(sh, key)
+			status = semanage.semanage_seuser_del_local(sh, key)
 			if status < 0:
 				raise Error("Could not delete test SEUser")
 			if self.verbose: print "Seuser delete: ", status
 		else:
 			print "Resetting seuser..."
-			status = semanage.semanage_seuser_modify(sh, key, old_seuser)
+			status = semanage.semanage_seuser_modify_local(sh, key, old_seuser)
 			if status < 0:
 				raise Error("Could not reset test SEUser")
 			if self.verbose: print "Seuser modify: ", status
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/semanageswig.i	2006-01-20 16:01:30.000000000 -0700
@@ -41,7 +41,7 @@
 	#include "semanage/fcontext_record.h"
 	#include "semanage/fcontexts_local.h"
 	#include "semanage/fcontexts_policy.h"
-	#include "semanage/seusers.h"	
+	#include "semanage/seusers_local.h"	
 	#include "semanage/semanage.h"
 %}
 
@@ -310,5 +310,5 @@
 %include "../include/semanage/fcontexts_local.h"
 %include "../include/semanage/fcontexts_policy.h"
 %include "../include/semanage/seuser_record.h"
-%include "../include/semanage/seusers.h"
+%include "../include/semanage/seusers_local.h"
 %include "../include/semanage/semanage.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2006-01-06 07:36:31.000000000 -0700
+++ new/libsemanage/src/seuser_internal.h	2006-01-20 16:02:05.000000000 -0700
@@ -2,7 +2,7 @@
 #define _SEMANAGE_SEUSER_INTERNAL_H_
 
 #include <semanage/seuser_record.h>
-#include <semanage/seusers.h>
+#include <semanage/seusers_local.h>
 #include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
@@ -16,13 +16,13 @@ hidden_proto(semanage_seuser_free)
 hidden_proto(semanage_seuser_get_mlsrange)
 hidden_proto(semanage_seuser_get_name)
 hidden_proto(semanage_seuser_get_sename)
-hidden_proto(semanage_seuser_iterate)
 hidden_proto(semanage_seuser_key_create)
 hidden_proto(semanage_seuser_key_extract)
 hidden_proto(semanage_seuser_key_free)
 hidden_proto(semanage_seuser_set_mlsrange)
 hidden_proto(semanage_seuser_set_name)
 hidden_proto(semanage_seuser_set_sename)
+hidden_proto(semanage_seuser_iterate_local)
 
 /* SEUSER RECORD: method table */
 extern record_table_t SEMANAGE_SEUSER_RTABLE;
@@ -34,7 +34,7 @@ extern int seuser_file_dbase_init(
 extern void seuser_file_dbase_release(
 	dbase_config_t* dconfig);
 
-extern int hidden semanage_seuser_validate(
+extern int hidden semanage_seuser_validate_local(
 	semanage_handle_t* handle,
 	const sepol_policydb_t* policydb);
 
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/seusers.c	1969-12-31 17:00:00.000000000 -0700
@@ -1,164 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-struct semanage_seuser;
-struct semanage_seuser_key;
-typedef struct semanage_seuser_key record_key_t;
-typedef struct semanage_seuser record_t;
-#define DBASE_RECORD_DEFINED
-
-#include <sepol/policydb.h>
-#include <sepol/context.h>
-#include "user_internal.h"
-#include "seuser_internal.h"
-#include "handle.h"
-#include "database.h"
-#include "debug.h"
-
-int semanage_seuser_modify(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);	
-	return dbase_modify(handle, dconfig, key, data);
-}
-
-int semanage_seuser_del(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_del(handle, dconfig, key);
-}
-
-int semanage_seuser_query(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	semanage_seuser_t** response) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_query(handle, dconfig, key, response);
-}
-
-int semanage_seuser_exists(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	int* response) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_exists(handle, dconfig, key, response);
-}
-
-int semanage_seuser_count(
-	semanage_handle_t* handle,
-	unsigned int* response) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_count(handle, dconfig, response);
-}
-
-int semanage_seuser_iterate(
-	semanage_handle_t* handle,
-	int (*handler) (
-		const semanage_seuser_t* record,
-		void* varg),
-	void* handler_arg) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_iterate(handle, dconfig, handler, handler_arg);
-}
-hidden_def(semanage_seuser_iterate)
-
-int semanage_seuser_list(
-	semanage_handle_t* handle,
-	semanage_seuser_t*** records,
-	unsigned int* count) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_list(handle, dconfig, records, count);
-}
-
-struct validate_handler_arg {
-	semanage_handle_t* handle;
-	const sepol_policydb_t* policydb;
-};
-
-static int validate_handler(
-	const semanage_seuser_t* seuser,
-	void* varg) {
-
-	semanage_user_t* user = NULL;
-	semanage_user_key_t* key = NULL;
-	int exists, mls_ok;
-
-	/* Unpack varg */
-	struct validate_handler_arg* arg = 
-		(struct validate_handler_arg*) varg;
-	semanage_handle_t* handle = arg->handle;
-	const sepol_policydb_t* policydb = arg->policydb;
-
-	/* Unpack seuser */
-	const char* name = semanage_seuser_get_name(seuser);
-	const char* sename = semanage_seuser_get_sename(seuser);
-	const char* mls_range = semanage_seuser_get_mlsrange(seuser);
-	const char* user_mls_range;
-
-	/* Make sure the (SElinux) user exists */
-	if (semanage_user_key_create(handle, sename, &key) < 0)
-		goto err;
-	if (semanage_user_exists(handle, key, &exists) < 0)
-		goto err;
-	if (!exists) {
-		ERR(handle, "selinux user %s does not exist", sename);
-		goto invalid;
-	}
-
-	/* Verify that the mls range is valid, and that it's contained
-	 * within the (SELinux) user mls range */
-	if (mls_range) {
-
-		if (semanage_user_query(handle, key, &user) < 0)
-			goto err;
-		user_mls_range = semanage_user_get_mlsrange(user);
-
-		if (sepol_mls_check(handle->sepolh, policydb, mls_range) < 0)
-			goto invalid;
-		if (sepol_mls_contains(handle->sepolh, policydb, 
-			user_mls_range, mls_range, &mls_ok) < 0)
-			goto err;
-		if (!mls_ok) {
-			ERR(handle, "mls range %s for Unix user %s "
-				"exceeds allowed range %s for SELinux user %s",
-				mls_range, name, user_mls_range, sename);
-			goto invalid;
-		}
-	}
-
-	semanage_user_key_free(key);
-	semanage_user_free(user);
-	return 0;
-
-	err:
-	ERR(handle, "could not check if the seuser mapping "
-		"%s -> (%s, %s) is valid", name, sename, mls_range);
-	semanage_user_key_free(key);
-	semanage_user_free(user);
-	return -1;
-
-	invalid:
-	ERR(handle, "seuser mapping %s -> (%s, %s) is invalid",
-		name, sename, mls_range);
-	semanage_user_key_free(key);
-	semanage_user_free(user);
-	return -1;
-}
-
-int hidden semanage_seuser_validate(
-	semanage_handle_t* handle,	
-	const sepol_policydb_t* policydb) {
-
-	struct validate_handler_arg arg;
-	arg.handle = handle;
-	arg.policydb = policydb;
-	return semanage_seuser_iterate(handle, validate_handler, &arg);
-}
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_local.c new/libsemanage/src/seusers_local.c
--- old/libsemanage/src/seusers_local.c	1969-12-31 17:00:00.000000000 -0700
+++ new/libsemanage/src/seusers_local.c	2006-01-20 16:02:22.000000000 -0700
@@ -0,0 +1,164 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser_key record_key_t;
+typedef struct semanage_seuser record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "handle.h"
+#include "database.h"
+#include "debug.h"
+
+int semanage_seuser_modify_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	const semanage_seuser_t* data) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);	
+	return dbase_modify(handle, dconfig, key, data);
+}
+
+int semanage_seuser_del_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_del(handle, dconfig, key);
+}
+
+int semanage_seuser_query_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	semanage_seuser_t** response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_seuser_exists_local(
+	semanage_handle_t* handle,
+	const semanage_seuser_key_t* key,
+	int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_seuser_count_local(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_seuser_iterate_local(
+	semanage_handle_t* handle,
+	int (*handler) (
+		const semanage_seuser_t* record,
+		void* varg),
+	void* handler_arg) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+hidden_def(semanage_seuser_iterate_local)
+
+int semanage_seuser_list_local(
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	unsigned int* count) {
+
+	dbase_config_t* dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_list(handle, dconfig, records, count);
+}
+
+struct validate_handler_arg {
+	semanage_handle_t* handle;
+	const sepol_policydb_t* policydb;
+};
+
+static int validate_handler(
+	const semanage_seuser_t* seuser,
+	void* varg) {
+
+	semanage_user_t* user = NULL;
+	semanage_user_key_t* key = NULL;
+	int exists, mls_ok;
+
+	/* Unpack varg */
+	struct validate_handler_arg* arg = 
+		(struct validate_handler_arg*) varg;
+	semanage_handle_t* handle = arg->handle;
+	const sepol_policydb_t* policydb = arg->policydb;
+
+	/* Unpack seuser */
+	const char* name = semanage_seuser_get_name(seuser);
+	const char* sename = semanage_seuser_get_sename(seuser);
+	const char* mls_range = semanage_seuser_get_mlsrange(seuser);
+	const char* user_mls_range;
+
+	/* Make sure the (SElinux) user exists */
+	if (semanage_user_key_create(handle, sename, &key) < 0)
+		goto err;
+	if (semanage_user_exists(handle, key, &exists) < 0)
+		goto err;
+	if (!exists) {
+		ERR(handle, "selinux user %s does not exist", sename);
+		goto invalid;
+	}
+
+	/* Verify that the mls range is valid, and that it's contained
+	 * within the (SELinux) user mls range */
+	if (mls_range) {
+
+		if (semanage_user_query(handle, key, &user) < 0)
+			goto err;
+		user_mls_range = semanage_user_get_mlsrange(user);
+
+		if (sepol_mls_check(handle->sepolh, policydb, mls_range) < 0)
+			goto invalid;
+		if (sepol_mls_contains(handle->sepolh, policydb, 
+			user_mls_range, mls_range, &mls_ok) < 0)
+			goto err;
+		if (!mls_ok) {
+			ERR(handle, "mls range %s for Unix user %s "
+				"exceeds allowed range %s for SELinux user %s",
+				mls_range, name, user_mls_range, sename);
+			goto invalid;
+		}
+	}
+
+	semanage_user_key_free(key);
+	semanage_user_free(user);
+	return 0;
+
+	err:
+	ERR(handle, "could not check if the seuser mapping "
+		"%s -> (%s, %s) is valid", name, sename, mls_range);
+	semanage_user_key_free(key);
+	semanage_user_free(user);
+	return -1;
+
+	invalid:
+	ERR(handle, "seuser mapping %s -> (%s, %s) is invalid",
+		name, sename, mls_range);
+	semanage_user_key_free(key);
+	semanage_user_free(user);
+	return -1;
+}
+
+int hidden semanage_seuser_validate_local(
+	semanage_handle_t* handle,	
+	const sepol_policydb_t* policydb) {
+
+	struct validate_handler_arg arg;
+	arg.handle = handle;
+	arg.policydb = policydb;
+	return semanage_seuser_iterate_local(handle, validate_handler, &arg);
+}
diff -Naurp --exclude-from excludes old/policycoreutils/scripts/genhomedircon new/policycoreutils/scripts/genhomedircon
--- old/policycoreutils/scripts/genhomedircon	2006-01-20 16:16:49.000000000 -0700
+++ new/policycoreutils/scripts/genhomedircon	2006-01-20 16:20:02.000000000 -0700
@@ -207,7 +207,7 @@ class selinuxConfig:
 	def getUsers(self):
 		udict = {}
 		if self.semanaged:
-			(status, list, lsize) = semanage_seuser_list(self.semanageHandle)
+			(status, list, lsize) = semanage_seuser_list_local(self.semanageHandle)
 			for idx in range(lsize):
 				user=[]
 				seuser = semanage_seuser_by_idx(list, idx)
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-20 16:16:49.000000000 -0700
+++ new/policycoreutils/semanage/seobject.py	2006-01-20 16:21:04.000000000 -0700
@@ -165,7 +165,7 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if exists:
@@ -195,7 +195,7 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_seuser_modify(self.sh, k, u)
+		rc = semanage_seuser_modify_local(self.sh, k, u)
 		if rc < 0:
 			raise ValueError("Could not add login mapping for %s" % name)
 
@@ -214,13 +214,13 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
 			raise ValueError("Login mapping for %s is not defined" % name)
 
-		(rc,u) = semanage_seuser_query(self.sh, k)
+		(rc,u) = semanage_seuser_query_local(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query seuser for %s" % name)
 
@@ -233,7 +233,7 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not srart semanage transaction")
 
-		rc = semanage_seuser_modify(self.sh, k, u)
+		rc = semanage_seuser_modify_local(self.sh, k, u)
 		if rc < 0:
 			raise ValueError("Could not modify login mapping for %s" % name)
 	
@@ -249,7 +249,7 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
@@ -259,7 +259,8 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_seuser_del(self.sh, k)
+		rc = semanage_seuser_del_local(self.sh, k)
+
 		if rc < 0:
 			raise ValueError("Could not delete login mapping for %s" % name)
 
@@ -272,7 +273,7 @@ class loginRecords(semanageRecords):
 		
 	def get_all(self):
 		ddict={}
-		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		(rc, self.ulist, self.usize) = semanage_seuser_list_local(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list login mappings")
 

--------------060208050300090700030509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
