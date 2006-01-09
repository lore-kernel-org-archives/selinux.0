Message-ID: <43C2C414.9070503@cornell.edu>
Date: Mon, 09 Jan 2006 13:14:12 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE(lib/tool)] Remove add_local/set_local
Content-Type: multipart/mixed;
 boundary="------------070103090207070400030701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070103090207070400030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch removes add_local and set_local functions from the dbase 
API, since they duplicate other functionality.

Set_local offers no benefits over modify_local coupled with an exists 
check - it takes the same amount of time, and the error path behavior 
isn't really useful, since the client should know whether an object 
exists or not in advance, and handle that case appropriately.

Same for add_local, unless the internal check for duplicate keys is 
removed, in which case it will have faster performance. However, I am 
thinking that the library must maintain the integrity of the store, so 
this optimization should not be made, since it can corrupt the store if 
the client is careless. Let me know if you disagree, I am not sure if 
removing add is a good idea or not...

========
This doesn't remove the dbase add or set capability, which are still 
used internally in several places (will have to take another look at 
those) - it just clears the API and manpages. The set_active function is 
kept. I also updated the semanage tool and pywrap-test.py. Note that the 
pywrap test update makes it work properly when the record being tested 
is already present in the local store (will reset it properly when the 
test is done).


--------------070103090207070400030701
Content-Type: text/x-patch;
 name="libsemanage.add.set_local.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.add.set_local.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/booleans_local.h new/libsemanage/include/semanage/booleans_local.h
--- old/libsemanage/include/semanage/booleans_local.h	2006-01-05 12:13:34.000000000 -0700
+++ new/libsemanage/include/semanage/booleans_local.h	2006-01-09 11:59:34.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_bool_add_local(
-	semanage_handle_t* handle,
-	const semanage_bool_key_t* key,
-	const semanage_bool_t* data);
-
 extern int semanage_bool_modify_local(
 	semanage_handle_t* handle,
 	const semanage_bool_key_t* key,
 	const semanage_bool_t* data);
 
-extern int semanage_bool_set_local(
-	semanage_handle_t* handle,
-	const semanage_bool_key_t* key,
-	const semanage_bool_t* data);
-
 extern int semanage_bool_del_local(
 	semanage_handle_t* handle,
 	const semanage_bool_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/fcontexts_local.h new/libsemanage/include/semanage/fcontexts_local.h
--- old/libsemanage/include/semanage/fcontexts_local.h	2006-01-05 12:14:31.000000000 -0700
+++ new/libsemanage/include/semanage/fcontexts_local.h	2006-01-09 11:59:04.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/fcontext_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_fcontext_add_local(
-	semanage_handle_t* handle,
-	const semanage_fcontext_key_t* key,
-	const semanage_fcontext_t* data);
-
 extern int semanage_fcontext_modify_local(
 	semanage_handle_t* handle,
 	const semanage_fcontext_key_t* key,
 	const semanage_fcontext_t* data);
 
-extern int semanage_fcontext_set_local(
-	semanage_handle_t* handle,
-	const semanage_fcontext_key_t* key,
-	const semanage_fcontext_t* data);
-
 extern int semanage_fcontext_del_local(
 	semanage_handle_t* handle,
 	const semanage_fcontext_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/interfaces_local.h new/libsemanage/include/semanage/interfaces_local.h
--- old/libsemanage/include/semanage/interfaces_local.h	2006-01-05 12:15:10.000000000 -0700
+++ new/libsemanage/include/semanage/interfaces_local.h	2006-01-09 11:59:25.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/iface_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_iface_add_local(
-	semanage_handle_t* handle,
-	const semanage_iface_key_t* key,
-	const semanage_iface_t* data);
-
 extern int semanage_iface_modify_local(
 	semanage_handle_t* handle,
 	const semanage_iface_key_t* key,
 	const semanage_iface_t* data);
 
-extern int semanage_iface_set_local(
-	semanage_handle_t* handle,
-	const semanage_iface_key_t* key,
-	const semanage_iface_t* data);
-
 extern int semanage_iface_del_local(
 	semanage_handle_t* handle,
 	const semanage_iface_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/ports_local.h new/libsemanage/include/semanage/ports_local.h
--- old/libsemanage/include/semanage/ports_local.h	2006-01-05 12:15:52.000000000 -0700
+++ new/libsemanage/include/semanage/ports_local.h	2006-01-09 11:58:57.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/port_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_port_add_local(
-	semanage_handle_t* handle,
-	const semanage_port_key_t* key,
-	const semanage_port_t* data);
-
 extern int semanage_port_modify_local(
 	semanage_handle_t* handle,
 	const semanage_port_key_t* key,
 	const semanage_port_t* data);
 
-extern int semanage_port_set_local(
-	semanage_handle_t* handle,
-	const semanage_port_key_t* key,
-	const semanage_port_t* data);
-
 extern int semanage_port_del_local(
 	semanage_handle_t* handle,
 	const semanage_port_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/seusers.h new/libsemanage/include/semanage/seusers.h
--- old/libsemanage/include/semanage/seusers.h	2006-01-05 12:18:06.000000000 -0700
+++ new/libsemanage/include/semanage/seusers.h	2006-01-09 11:59:14.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/seuser_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_seuser_add(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data);
-
 extern int semanage_seuser_modify(
 	semanage_handle_t* handle,
 	const semanage_seuser_key_t* key,
 	const semanage_seuser_t* data);
 
-extern int semanage_seuser_set(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data);
-
 extern int semanage_seuser_del(
 	semanage_handle_t* handle,
 	const semanage_seuser_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/users_local.h new/libsemanage/include/semanage/users_local.h
--- old/libsemanage/include/semanage/users_local.h	2006-01-05 12:18:09.000000000 -0700
+++ new/libsemanage/include/semanage/users_local.h	2006-01-09 11:58:51.000000000 -0700
@@ -7,21 +7,11 @@
 #include <semanage/user_record.h>
 #include <semanage/handle.h>
 
-extern int semanage_user_add_local(
-	semanage_handle_t* handle,
-	const semanage_user_key_t* key,
-	const semanage_user_t* data);
-
 extern int semanage_user_modify_local(
 	semanage_handle_t* handle,
 	const semanage_user_key_t* key,
 	const semanage_user_t* data);
 
-extern int semanage_user_set_local(
-	semanage_handle_t* handle,
-	const semanage_user_key_t* key,
-	const semanage_user_t* data);
-
 extern int semanage_user_del_local(
 	semanage_handle_t* handle,
 	const semanage_user_key_t* key);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_bool_add_local.3 new/libsemanage/man/man3/semanage_bool_add_local.3
--- old/libsemanage/man/man3/semanage_bool_add_local.3	2006-01-04 08:40:22.000000000 -0700
+++ new/libsemanage/man/man3/semanage_bool_add_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_add_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_bool_set_active.3 new/libsemanage/man/man3/semanage_bool_set_active.3
--- old/libsemanage/man/man3/semanage_bool_set_active.3	2006-01-04 08:42:38.000000000 -0700
+++ new/libsemanage/man/man3/semanage_bool_set_active.3	2006-01-09 12:52:00.000000000 -0700
@@ -1 +1,47 @@
-.so man3/semanage_user_set_local.3
+.TH semanage_bool_set_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_bool_set_active \- 
+update an existing boolean in the currently active policy
+.br
+
+.SH "SYNOPSIS"
+.B #include <semanage/booleans_active.h>
+.br
+.sp
+.B extern int semanage_bool_set_active (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	const semanage_bool_key_t *" key ","
+.br
+.BI "	const semanage_bool_t *" data ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The set function will fail if no matching key is found in the local store. Otherwise, the provided object will replace the current one. When 
+.B semanage_commit 
+is invoked, changes will be written permanently into the local store, and will be loaded into policy. Validity of the object being added is checked at commit time. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the 
+.I data
+object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+), and must be executed in a transaction (see 
+.B semanage_begin_transaction
+).
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_bool_set_local.3 new/libsemanage/man/man3/semanage_bool_set_local.3
--- old/libsemanage/man/man3/semanage_bool_set_local.3	2006-01-04 08:42:52.000000000 -0700
+++ new/libsemanage/man/man3/semanage_bool_set_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_set_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_add_local.3 new/libsemanage/man/man3/semanage_fcontext_add_local.3
--- old/libsemanage/man/man3/semanage_fcontext_add_local.3	2006-01-04 08:41:22.000000000 -0700
+++ new/libsemanage/man/man3/semanage_fcontext_add_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_add_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_set_local.3 new/libsemanage/man/man3/semanage_fcontext_set_local.3
--- old/libsemanage/man/man3/semanage_fcontext_set_local.3	2006-01-04 08:43:01.000000000 -0700
+++ new/libsemanage/man/man3/semanage_fcontext_set_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_set_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_iface_add_local.3 new/libsemanage/man/man3/semanage_iface_add_local.3
--- old/libsemanage/man/man3/semanage_iface_add_local.3	2006-01-04 08:40:42.000000000 -0700
+++ new/libsemanage/man/man3/semanage_iface_add_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_add_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_iface_set_local.3 new/libsemanage/man/man3/semanage_iface_set_local.3
--- old/libsemanage/man/man3/semanage_iface_set_local.3	2006-01-04 08:42:58.000000000 -0700
+++ new/libsemanage/man/man3/semanage_iface_set_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_set_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_port_add_local.3 new/libsemanage/man/man3/semanage_port_add_local.3
--- old/libsemanage/man/man3/semanage_port_add_local.3	2006-01-04 08:40:35.000000000 -0700
+++ new/libsemanage/man/man3/semanage_port_add_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_add_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_port_set_local.3 new/libsemanage/man/man3/semanage_port_set_local.3
--- old/libsemanage/man/man3/semanage_port_set_local.3	2006-01-04 08:42:55.000000000 -0700
+++ new/libsemanage/man/man3/semanage_port_set_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_set_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_add.3 new/libsemanage/man/man3/semanage_seuser_add.3
--- old/libsemanage/man/man3/semanage_seuser_add.3	2006-01-04 08:41:04.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_add.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_add_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_set.3 new/libsemanage/man/man3/semanage_seuser_set.3
--- old/libsemanage/man/man3/semanage_seuser_set.3	2006-01-04 16:23:52.000000000 -0700
+++ new/libsemanage/man/man3/semanage_seuser_set.3	1969-12-31 17:00:00.000000000 -0700
@@ -1 +0,0 @@
-.so man3/semanage_user_set_local.3
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_user_add_local.3 new/libsemanage/man/man3/semanage_user_add_local.3
--- old/libsemanage/man/man3/semanage_user_add_local.3	2006-01-05 12:26:55.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_add_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1,81 +0,0 @@
-.TH semanage_user_add_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
-.SH "NAME"
-.B semanage_user_add_local \- 
-add a new user to the local store
-.br
-.B semanage_bool_add_local \- 
-add a new boolean to the local store
-.br
-.B semanage_port_add_local \-
-add a new port range to the local store 
-.br
-.B semanage_iface_add_local \- 
-add a new network interface to the local store
-.br
-.B semanage_fcontext_add_local \- 
-add a new context specification to the local store
-.br
-.B semanage_seuser_add \- 
-add a new seuser (login mapping)
-
-.SH "SYNOPSIS"
-.B #include <semanage/users_local.h> 
-.br
-.B #include <semanage/booleans_local.h>
-.br
-.B #include <semanage/ports_local.h>
-.br
-.B #include <semanage/interfaces_local.h>
-.br
-.B #include <semanage/fcontexts_local.h>
-.br
-.B #include <semanage/seusers.h>
-.sp
-
-.B FUNCTION: 
-see above
-.br
-.B OBJECT: 
-user, port, fcontext, iface, seuser
-.sp
-.sp
-.B extern int FUNCTION (
-.br
-.BI "	semanage_handle_t *" handle ","
-.br
-.BI "	const semanage_OBJECT_key_t *" key ","
-.br
-.BI "	const semanage_OBJECT_t *" data ");"
-
-.SH "DESCRIPTION"
-.TP
-.SS Add Group:
-The group of add functions are one of three ways to modify policy objects (the other two being the set group, and the modify group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Add functions will not allow updates to existing objects in the local store - they can only add new objects.
-.TP
-.SS Behavior:
-The add functions will fail if a matching key is found in the local store. Otherwise, the object provided will be added to the local store, and then loaded into policy. Changes will become permanent when 
-.B semanage_commit 
-is invoked. Validity of the object being added is checked at commit time. 
-.TP
-.SS Parameters:
-The 
-.I handle
-is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the 
-.I data
-object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
-.TP
-.SS Requirements:
-This function requires an semanage connection to be established (see 
-.B semanage_connect
-), and must be executed in a transaction (see 
-.B semanage_begin_transaction
-).
-
-.SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
-Otherwise 0 is returned.
-
-.SH "SEE ALSO"
-.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_user_modify_local.3 new/libsemanage/man/man3/semanage_user_modify_local.3
--- old/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-05 12:27:06.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-09 12:54:15.000000000 -0700
@@ -16,7 +16,7 @@ add or update an interface in the local 
 add or override a context specification in the local store
 .br
 .B semanage_seuser_modify \- 
-add a new seuser (login mapping)
+add or update a seuser (login mapping)
 
 .SH "SYNOPSIS"
 .B #include <semanage/users_local.h> 
@@ -49,13 +49,10 @@ user, port, fcontext, iface, seuser
 
 .SH "DESCRIPTION"
 .TP
-.SS Modify Group:
-The group of modify functions are one of three ways to modify policy objects (the other two being the add group, and the set group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Modify functions will update existing objects in the local store, and will also allow new objects.
-.TP
 .SS Behavior:
-If a matching key is found in the local store, the object provided will replace the current one. Otherwise, it will be added to the store, and later loaded into policy. Changes will become permanent when
+If a matching key is found in the local store, the provided object will replace the current one. Otherwise, it will be added to the store. When
 .B semanage_commit 
-is invoked. Validity of the object being added is checked at commit time. 
+is invoked, changes will be permanently written into the local store, and then loaded into policy. Validity of the object being added is checked at commit time. Adding new objects with respect to policy is allowed, except in the case of booleans. Attempt to add new booleans with respect to policy will fail at commit time.
 .TP
 .SS Parameters:
 The 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/man/man3/semanage_user_set_local.3 new/libsemanage/man/man3/semanage_user_set_local.3
--- old/libsemanage/man/man3/semanage_user_set_local.3	2006-01-05 12:27:18.000000000 -0700
+++ new/libsemanage/man/man3/semanage_user_set_local.3	1969-12-31 17:00:00.000000000 -0700
@@ -1,86 +0,0 @@
-.TH semanage_user_set_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
-.SH "NAME"
-.B semanage_user_set_local \- 
-update an existing user in the local store
-.br
-.B semanage_bool_set_local \- 
-update an existing boolean in the local store
-.br
-.B semanage_bool_set_active \- 
-update an existing boolean in the currently active policy
-.br
-.B semanage_port_set_local \- 
-update an existing port range in the local store
-.br
-.B semanage_iface_set_local \- 
-update an existing network interface in the local store
-.br
-.B semanage_fcontext_set_local \- 
-update an existing context specification in the local store
-.br
-.B semanage_seuser_set \- 
-update an existing seuser (login mapping)
-
-.SH "SYNOPSIS"
-.B #include <semanage/users_local.h> 
-.br
-.B #include <semanage/booleans_local.h>
-.br
-.B #include <semanage/booleans_active.h>
-.br
-.B #include <semanage/ports_local.h>
-.br
-.B #include <semanage/interfaces_local.h>
-.br
-.B #include <semanage/fcontexts_local.h>
-.br
-.B #include <semanage/seusers.h>
-.sp
-
-.B FUNCTION: 
-see above
-.br
-.B OBJECT: 
-user, port, fcontext, iface, seuser
-.sp
-.sp
-.B extern int FUNCTION (
-.br
-.BI "	semanage_handle_t *" handle ","
-.br
-.BI "	const semanage_OBJECT_key_t *" key ","
-.br
-.BI "	const semanage_OBJECT_t *" data ");"
-
-.SH "DESCRIPTION"
-.TP
-.SS Set Group:
-The group of set functions are one of three ways to modify policy objects (the other two being the add group, and the modify group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Set functions will update existing objects in the local store, and will not allow new objects.
-.TP
-.SS Behavior:
-The set functions will fail if no matching key is found in the local store. Otherwise, the object provided will replace the current one in the local store, and will be loaded into policy. Changes will become permanent when 
-.B semanage_commit 
-is invoked. Validity of the object being added is checked at commit time. 
-.TP
-.SS Parameters:
-The 
-.I handle
-is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the 
-.I data
-object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
-.TP
-.SS Requirements:
-This function requires an semanage connection to be established (see 
-.B semanage_connect
-), and must be executed in a transaction (see 
-.B semanage_begin_transaction
-).
-
-.SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
-Otherwise 0 is returned.
-
-.SH "SEE ALSO"
-.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2006-01-05 12:18:46.000000000 -0700
+++ new/libsemanage/src/booleans_local.c	2006-01-09 11:57:44.000000000 -0700
@@ -11,15 +11,6 @@ typedef struct semanage_bool record_t;
 #include "handle.h" 
 #include "database.h"
 
-int semanage_bool_add_local(
-	semanage_handle_t* handle,
-	const semanage_bool_key_t* key,
-	const semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_bool_modify_local(
 	semanage_handle_t* handle,
 	const semanage_bool_key_t* key,
@@ -29,15 +20,6 @@ int semanage_bool_modify_local(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-int semanage_bool_set_local(
-	semanage_handle_t* handle,
-	const semanage_bool_key_t* key,
-	const semanage_bool_t* data) {
-
-	dbase_config_t* dconfig = semanage_bool_dbase_local(handle);	
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_bool_del_local(
 	semanage_handle_t* handle,
 	const semanage_bool_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-05 20:11:20.000000000 -0700
+++ new/libsemanage/src/fcontexts_local.c	2006-01-09 11:58:36.000000000 -0700
@@ -16,15 +16,6 @@ typedef struct semanage_fcontext record_
 #include "handle.h" 
 #include "database.h"
 
-int semanage_fcontext_add_local(
-	semanage_handle_t* handle,
-	const semanage_fcontext_key_t* key,
-	const semanage_fcontext_t* data) {
-
-	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_fcontext_modify_local(
 	semanage_handle_t* handle,
 	const semanage_fcontext_key_t* key,
@@ -34,15 +25,6 @@ int semanage_fcontext_modify_local(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-int semanage_fcontext_set_local(
-	semanage_handle_t* handle,
-	const semanage_fcontext_key_t* key,
-	const semanage_fcontext_t* data) {
-
-	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);	
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_fcontext_del_local(
 	semanage_handle_t* handle,
 	const semanage_fcontext_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/interfaces_local.c new/libsemanage/src/interfaces_local.c
--- old/libsemanage/src/interfaces_local.c	2006-01-05 12:19:45.000000000 -0700
+++ new/libsemanage/src/interfaces_local.c	2006-01-09 11:57:53.000000000 -0700
@@ -11,15 +11,6 @@ typedef struct semanage_iface record_t;
 #include "handle.h" 
 #include "database.h"
 
-int semanage_iface_add_local(
-	semanage_handle_t* handle,
-	const semanage_iface_key_t* key,
-	const semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_iface_modify_local(
 	semanage_handle_t* handle,
 	const semanage_iface_key_t* key,
@@ -29,15 +20,6 @@ int semanage_iface_modify_local(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-int semanage_iface_set_local(
-	semanage_handle_t* handle,
-	const semanage_iface_key_t* key,
-	const semanage_iface_t* data) {
-
-	dbase_config_t* dconfig = semanage_iface_dbase_local(handle);	
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_iface_del_local(
 	semanage_handle_t* handle,
 	const semanage_iface_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-04 20:16:49.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-09 12:29:02.000000000 -0700
@@ -297,19 +297,30 @@ class Tests:
                 
 		(status,key) = semanage.semanage_user_key_extract(sh,user)
                 if self.verbose: print "User key extracted: ", key
-		
+	
+		(status,exists) = semanage.semanage_user_exists_local(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists: 
+			(status, old_user) = semanage.semanage_user_query_local(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+	
 		print "Starting transaction..."
                 status = semanage.semanage_begin_transaction(sh)
-                status = semanage.semanage_user_add_local(sh,key,user)
+                status = semanage.semanage_user_modify_local(sh,key,user)
                 status = semanage.semanage_commit(sh)
                 print "Commit status (transaction number): ", status
 
-		print "Removing user..."
-                status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_user_del_local(sh, key)
-                if self.verbose: print "User delete: ", status
-                status = semanage.semanage_commit(sh)
-                print "Commit status (transaction number): ", status
+		status = semanage.semanage_begin_transaction(sh)
+		if not exists:
+			print "Removing user..."
+			status = semanage.semanage_user_del_local(sh, key)
+                	if self.verbose: print "User delete: ", status
+		else:
+			print "Resetting user..."
+			status = semanage.semanage_user_modify_local(sh, key, old_user)
+			if self.verbose: print "User modify: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
 			
 	def test_writeseuser(self,sh):
                 print "Testing seuser write..."
@@ -328,17 +339,28 @@ class Tests:
                 
 		(status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
                 if self.verbose: print "SEUser key extracted: ", key
-		
+	
+                (status,exists) = semanage.semanage_seuser_exists(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists:
+			(status, old_seuser) = semanage.semanage_seuser_query(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+
 		print "Starting transaction..."
                 status = semanage.semanage_begin_transaction(sh)
-                status = semanage.semanage_seuser_add(sh,key,seuser)
+                status = semanage.semanage_seuser_modify(sh,key,seuser)
                 status = semanage.semanage_commit(sh)
                 print "Commit status (transaction number): ", status
 
-		print "Removing seuser..."
-                status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_seuser_del(sh, key)
-                if self.verbose: print "SEUser delete: ", status
+		status = semanage.semanage_begin_transaction(sh)
+		if not exists:
+			print "Removing seuser..."
+			status = semanage.semanage_seuser_del(sh, key)
+			if self.verbose: print "Seuser delete: ", status
+		else:
+			print "Resetting seuser..."
+			status = semanage.semanage_seuser_modify(sh, key, old_seuser)
+			if self.verbose: print "Seuser modify: ", status
                 status = semanage.semanage_commit(sh)
                 print "Commit status (transaction number): ", status
 
@@ -377,16 +399,27 @@ class Tests:
                 (status,key) = semanage.semanage_port_key_extract(sh,port)
                 if self.verbose: print "SEPort key extracted: ", key
 
+		(status,exists) = semanage.semanage_port_exists_local(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists:
+			(status, old_port) = semanage.semanage_port_query_local(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_port_add_local(sh,key,port)
+		status = semanage.semanage_port_modify_local(sh,key,port)
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
-		print "Removing port range..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_port_del_local(sh, key)
-                if self.verbose: print "SEPort delete: ", status
+		if not exists:
+			print "Removing port range..."
+                        status = semanage.semanage_port_del_local(sh, key)
+                        if self.verbose: print "Port range delete: ", status
+                else:
+			print "Resetting port range..."
+			status = semanage.semanage_port_modify_local(sh, key, old_port)
+			if self.verbose: print "Port range modify: ", status
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
@@ -423,16 +456,27 @@ class Tests:
 		(status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
 		if self.verbose: print "SEFcontext key extracted: ", key
 
+		(status,exists) = semanage.semanage_fcontext_exists_local(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists:
+			(status, old_fcontext) = semanage.semanage_fcontext_query_local(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_fcontext_add_local(sh,key,fcon)
+		status = semanage.semanage_fcontext_modify_local(sh,key,fcon)
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
-		print "Removing file context..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_fcontext_del_local(sh, key)
-		if self.verbose: print "SEFcontext delete: ", status
+		if not exists:
+			print "Removing file context..."
+			status = semanage.semanage_fcontext_del_local(sh, key)
+			if self.verbose: print "File context delete: ", status
+		else:
+			print "Resetting file context..."
+			status = semanage.semanage_fcontext_modify_local(sh, key, old_fcontext)
+			if self.verbose: print "File context modify: ", status
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 	
@@ -484,16 +528,27 @@ class Tests:
 		(status,key) = semanage.semanage_iface_key_extract(sh,iface)
 		if self.verbose: print "SEIface key extracted: ", key
 
+		(status,exists) = semanage.semanage_iface_exists_local(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists:
+			(status, old_iface) = semanage.semanage_iface_query_local(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_iface_add_local(sh,key,iface)
+		status = semanage.semanage_iface_modify_local(sh,key,iface)
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
-		print "Removing network interface..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_iface_del_local(sh, key)
-		if self.verbose: print "SEIface delete: ", status
+		if not exists:
+			print "Removing interface..."
+			status = semanage.semanage_iface_del_local(sh, key)
+			if self.verbose: print "Interface delete: ", status
+		else:
+			print "Resetting interface..."
+			status = semanage.semanage_iface_modify_local(sh, key, old_iface)
+			if self.verbose: print "Interface modify: ", status
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
@@ -512,16 +567,27 @@ class Tests:
 		(status,key) = semanage.semanage_bool_key_extract(sh,bool)
 		if self.verbose: print "SEBool key extracted: ", key
 
+		(status,exists) = semanage.semanage_bool_exists_local(sh,key)
+		if self.verbose: print "Exists status (commit number): ", status
+		if exists:
+			(status, old_bool) = semanage.semanage_bool_query_local(sh, key)
+			if self.verbose: print "Query status (commit number): ", status
+
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_bool_add_local(sh,key,bool)
+		status = semanage.semanage_bool_modify_local(sh,key,bool)
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
-		print "Removing boolean..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_bool_del_local(sh, key)
-		if self.verbose: print "SEBool delete: ", status
+		if not exists:
+			print "Removing boolean..."
+			status = semanage.semanage_bool_del_local(sh, key)
+			if self.verbose: print "Boolean delete: ", status
+		else:
+			print "Resetting boolean..."
+			status = semanage.semanage_bool_modify_local(sh, key, old_bool)
+			if self.verbose: print "Boolean modify: ", status
 		status = semanage.semanage_commit(sh)
 		print "Commit status (transaction number): ", status
 
@@ -531,7 +597,7 @@ class Tests:
 		(status, key) = semanage.semanage_bool_key_create(sh, "allow_execmem")
 		if self.verbose: print "SEBool key created: ", key
 
-		(status, old_bool) = semanage.semanage_bool_query(sh, key)
+		(status, old_bool) = semanage.semanage_bool_query_active(sh, key)
 		if self.verbose: print "Query status (commit number): ", status
 
 		(status, abool) = semanage.semanage_bool_create(sh)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-05 14:38:25.000000000 -0700
+++ new/libsemanage/src/seusers.c	2006-01-09 11:58:24.000000000 -0700
@@ -15,15 +15,6 @@ typedef struct semanage_seuser record_t;
 #include "database.h"
 #include "debug.h"
 
-int semanage_seuser_add(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_seuser_modify(
 	semanage_handle_t* handle,
 	const semanage_seuser_key_t* key,
@@ -33,15 +24,6 @@ int semanage_seuser_modify(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-int semanage_seuser_set(
-	semanage_handle_t* handle,
-	const semanage_seuser_key_t* key,
-	const semanage_seuser_t* data) {
-
-	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_seuser_del(
 	semanage_handle_t* handle,
 	const semanage_seuser_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/users_local.c new/libsemanage/src/users_local.c
--- old/libsemanage/src/users_local.c	2006-01-05 12:20:41.000000000 -0700
+++ new/libsemanage/src/users_local.c	2006-01-09 11:58:11.000000000 -0700
@@ -11,15 +11,6 @@ typedef struct semanage_user record_t;
 #include "handle.h" 
 #include "database.h"
 
-int semanage_user_add_local(
-	semanage_handle_t* handle,
-	const semanage_user_key_t* key,
-	const semanage_user_t* data) {
-
-	dbase_config_t* dconfig = semanage_user_dbase_local(handle);
-	return dbase_add(handle, dconfig, key, data);
-}
-
 int semanage_user_modify_local(
 	semanage_handle_t* handle,
 	const semanage_user_key_t* key,
@@ -29,16 +20,6 @@ int semanage_user_modify_local(
 	return dbase_modify(handle, dconfig, key, data);
 }
 
-
-int semanage_user_set_local(
-	semanage_handle_t* handle,
-	const semanage_user_key_t* key,
-	const semanage_user_t* data) {
-
-	dbase_config_t* dconfig = semanage_user_dbase_local(handle);	
-	return dbase_set(handle, dconfig, key, data);
-}
-
 int semanage_user_del_local(
 	semanage_handle_t* handle,
 	const semanage_user_key_t* key) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-01-06 07:38:18.000000000 -0700
+++ new/policycoreutils/semanage/semanage	2006-01-09 12:35:33.000000000 -0700
@@ -145,7 +145,7 @@ class seluserRecords:
 			raise ValueError("Could not extract key for %s" % name)
 
 		semanage_begin_transaction(self.sh)
-		semanage_user_add_local(self.sh, k, u)
+		semanage_user_modify_local(self.sh, k, u)
 		if semanage_commit(self.sh) < 0:
 			raise ValueError("Failed to add SELinux user")
 
@@ -275,7 +275,7 @@ class portRecords:
 		semanage_context_set_mls(self.sh, con, serange)
 		semanage_port_set_con(p, con)
 		semanage_begin_transaction(self.sh)
-		semanage_port_add_local(self.sh, k, p)
+		semanage_port_modify_local(self.sh, k, p)
 		if semanage_commit(self.sh) < 0:
 			raise ValueError("Failed to add port")
 

--------------070103090207070400030701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
