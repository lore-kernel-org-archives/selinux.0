Message-ID: <43DBB31D.1090802@cornell.edu>
Date: Sat, 28 Jan 2006 11:08:29 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Pass fname argument to all file-backed dbases
Content-Type: multipart/mixed;
 boundary="------------090706040801040207000708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090706040801040207000708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

... so we can easily configure it in one place, and instantiate those 
multiple times on different files if necessary (which it will be 
shortly, in the seuser case).

Ok, so I've switched to a 64-bit system, and the first thing I see is 
that everything gets installed in the completely wrong place until I 
export LIBDIR/SHLIBDIR to point to lib64. Is this normal, or should the 
Makefile do something about that?
The second thing I see is a bunch of warnings, which I'll be tracking 
down soon...


--------------090706040801040207000708
Content-Type: text/x-patch;
 name="libsemanage.fname_parameter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fname_parameter.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/src/boolean_internal.h	2006-01-28 10:20:38.000000000 -0700
@@ -26,6 +26,7 @@ extern record_table_t SEMANAGE_BOOL_RTAB
 
 extern int bool_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void bool_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/booleans_file.c	2006-01-28 10:14:15.000000000 -0700
@@ -110,11 +110,12 @@ record_file_table_t SEMANAGE_BOOL_FILE_R
 
 int bool_file_dbase_init(
 	semanage_handle_t* handle, 
+	const char* fname,
 	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
 		handle, 
-		"booleans.local",
+		fname,
 		&SEMANAGE_BOOL_RTABLE,
 		&SEMANAGE_BOOL_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-28 10:19:54.000000000 -0700
@@ -116,7 +116,7 @@ int semanage_direct_connect(semanage_han
 	sh->funcs = &direct_funcs;
 
         /* Configure object databases */
-	if (user_base_file_dbase_init(sh, 
+	if (user_base_file_dbase_init(sh, "users.local", 
 		semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
 
@@ -130,20 +130,24 @@ int semanage_direct_connect(semanage_han
 		semanage_user_dbase_local(sh)) < 0)
 		goto err;
 
-	if (port_file_dbase_init(sh, semanage_port_dbase_local(sh)) < 0)
+	if (port_file_dbase_init(sh, "ports.local", 
+		semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(sh, semanage_iface_dbase_local(sh)) < 0)
+	if (iface_file_dbase_init(sh, "interfaces.local",
+		semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(sh, semanage_bool_dbase_local(sh)) < 0)
+	if (bool_file_dbase_init(sh, "booleans.local",
+		semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
 	if (fcontext_file_dbase_init(sh, "file_contexts.local", 
 		semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
-	if (seuser_file_dbase_init(sh, semanage_seuser_dbase_local(sh)) < 0)
+	if (seuser_file_dbase_init(sh, "seusers",
+		semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh, "users_extra.system",
diff -Naurp --exclude-from excludes old/libsemanage/src/iface_internal.h new/libsemanage/src/iface_internal.h
--- old/libsemanage/src/iface_internal.h	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/src/iface_internal.h	2006-01-28 10:15:36.000000000 -0700
@@ -34,6 +34,7 @@ extern void iface_policydb_dbase_release
 
 extern int iface_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void iface_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/interfaces_file.c	2006-01-28 10:21:04.000000000 -0700
@@ -150,12 +150,13 @@ record_file_table_t SEMANAGE_IFACE_FILE_
 };
 
 int iface_file_dbase_init(
-	semanage_handle_t* handle, 
+	semanage_handle_t* handle,
+	const char* fname, 
 	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		handle, 
-		"interfaces.local",	
+		handle,
+		fname, 
 		&SEMANAGE_IFACE_RTABLE,
 		&SEMANAGE_IFACE_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/port_internal.h	2006-01-28 10:16:45.000000000 -0700
@@ -31,6 +31,7 @@ extern record_table_t SEMANAGE_PORT_RTAB
 
 extern int port_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void port_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2006-01-05 06:26:19.000000000 -0700
+++ new/libsemanage/src/ports_file.c	2006-01-28 10:15:52.000000000 -0700
@@ -166,11 +166,12 @@ record_file_table_t SEMANAGE_PORT_FILE_R
 
 int port_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
 		handle, 
-		"ports.local",
+		fname,
 		&SEMANAGE_PORT_RTABLE,
 		&SEMANAGE_PORT_FILE_RTABLE,
 		&dconfig->dbase) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2006-01-27 13:44:09.000000000 -0700
+++ new/libsemanage/src/seuser_internal.h	2006-01-28 10:17:25.000000000 -0700
@@ -29,6 +29,7 @@ extern record_table_t SEMANAGE_SEUSER_RT
 
 extern int seuser_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void seuser_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/seusers_file.c	2006-01-28 10:17:12.000000000 -0700
@@ -117,12 +117,13 @@ record_file_table_t SEMANAGE_SEUSER_FILE
 };
 
 int seuser_file_dbase_init(
-	semanage_handle_t* handle, 
+	semanage_handle_t* handle,
+	const char* fname, 
 	dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
 		handle, 
-		"seusers",
+		fname,
 		&SEMANAGE_SEUSER_RTABLE,
 		&SEMANAGE_SEUSER_FILE_RTABLE,
 		&dconfig->dbase) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/user_internal.h	2006-01-28 10:18:12.000000000 -0700
@@ -42,6 +42,7 @@ extern record_table_t SEMANAGE_USER_EXTR
 /* USER BASE record, FILE backend */
 extern int user_base_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig);
 
 extern void user_base_file_dbase_release(
diff -Naurp --exclude-from excludes old/libsemanage/src/users_base_file.c new/libsemanage/src/users_base_file.c
--- old/libsemanage/src/users_base_file.c	2006-01-13 06:37:34.000000000 -0700
+++ new/libsemanage/src/users_base_file.c	2006-01-28 10:17:47.000000000 -0700
@@ -207,11 +207,12 @@ record_file_table_t SEMANAGE_USER_BASE_F
 
 int user_base_file_dbase_init(
 	semanage_handle_t* handle,
+	const char* fname,
 	dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
 		handle, 
-		"users.local",
+		fname,
 		&SEMANAGE_USER_BASE_RTABLE,
 		&SEMANAGE_USER_BASE_FILE_RTABLE, 
 		&dconfig->dbase) < 0)

--------------090706040801040207000708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
