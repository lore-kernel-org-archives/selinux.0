Message-ID: <43ACADB3.7070509@cornell.edu>
Date: Fri, 23 Dec 2005 21:08:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, dwalsh@redhat.com
Subject: [SEMANAGE][SEPOL] Enable ports
Content-Type: multipart/mixed;
 boundary="------------060803060802030700090308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060803060802030700090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I've tried get ports working enough times now, that I think my 
approach is making it too difficult. I've been trying to put too much 
logic into the port key - for example, I wanted the add() function to 
detect overlapping ranges, and complain about it (the range key 
represents all ports from low to high). I wanted the query function to 
match inexactly (if you query port 80, 10-1024 to match...)
I wanted del() to match a range, and clear only the specified sub-range. 
But... this is too difficult to do, and adds lots of extra complexity, 
and we need to get ports working.

So, this patch takes the simplest possible approach - a key matches if 
low = low2, high = high2, and proto = proto2. This means that at the key 
level, ranges 10-20, and 15-30 are completely different, even though 
they overlap and represent the same ports. Two ranges with matching 
bounds and protocol are not allowed, but they can overlap inexactly. In 
that case, the one added later takes precedence, and is written at the 
end of the file (and pushed at the beginning of the list in the 
policydb). If additional overlap checks are needed, they should be 
implemented at the libsemanage client.

This brings up an interesting point - if ordering of records matters, 
then some thought should go into which way iterate() loops over the 
records... (and what order list() returns). Currently for files, the 
ordering is backwards to what appears in the file (not sure what 
policydb does).

--------------060803060802030700090308
Content-Type: text/x-patch;
 name="libsemanage8.libsepol2.ports.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage8.libsepol2.ports.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-12-23 15:01:08.000000000 -0500
+++ new/libsemanage/include/semanage/semanage.h	2005-12-23 20:28:55.000000000 -0500
@@ -32,9 +32,7 @@
 #include <semanage/seuser_record.h>
 #include <semanage/context_record.h>
 #include <semanage/iface_record.h>
-#if 0
 #include <semanage/port_record.h>
-#endif
 
 /* Dbase */
 #include <semanage/booleans_local.h>
@@ -43,10 +41,8 @@
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
 #include <semanage/seusers.h>
-#if 0
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
-#endif
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
 
diff -Naurp --exclude-from excludes old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-12-23 15:01:09.000000000 -0500
+++ new/libsemanage/src/libsemanage.map	2005-12-23 20:28:39.000000000 -0500
@@ -10,6 +10,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
-	  semanage_iface_*; semanage_context_*;
+	  semanage_iface_*; semanage_port_*; semanage_context_*;
   local: *;
 };
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-12-23 15:01:09.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-12-23 20:28:24.000000000 -0500
@@ -127,10 +127,10 @@ int semanage_base_merge_components(
 
 		{ semanage_user_dbase_local(handle),
 		  semanage_user_dbase_policy(handle), MODE_MODIFY },
-#if 0
+
 		{ semanage_port_dbase_local(handle),
 		  semanage_port_dbase_policy(handle), MODE_MODIFY },
-#endif
+
 		{ semanage_iface_dbase_local(handle),
 		  semanage_iface_dbase_policy(handle), MODE_MODIFY },
 	
@@ -187,7 +187,7 @@ int semanage_commit_components(
 		semanage_iface_dbase_local(handle),
 		semanage_bool_dbase_local(handle),
 		semanage_user_dbase_local(handle),
-		/* semanage_port_dbase_local(handle), */
+		semanage_port_dbase_local(handle),
 		semanage_seuser_dbase(handle),
 		semanage_bool_dbase_active(handle),
 	};
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2005-12-23 01:01:49.000000000 -0500
+++ new/libsemanage/src/port_record.c	2005-12-23 20:26:51.000000000 -0500
@@ -23,24 +23,6 @@ typedef semanage_port_key_t record_key_t
 #include "handle.h"
 #include "database.h"
 
-/* FIXME:  Remove when sepol port interface is stabilized and exported. */
-#define sepol_port_compare(port, key) -1
-#define sepol_port_key_create(handle, low, high, proto, key) -1
-#define sepol_port_key_extract(handle, port, key) -1
-#define sepol_port_key_free(key)
-#define sepol_port_get_proto(port) -1
-#define sepol_port_set_proto(port, proto)
-#define sepol_port_get_proto_str(port) NULL
-#define sepol_port_get_low(port) -1
-#define sepol_port_get_high(port) -1
-#define sepol_port_set_port(port, num)
-#define sepol_port_set_range(port, low, high)
-#define sepol_port_get_con(port) NULL
-#define sepol_port_set_con(port, con)
-#define sepol_port_create(handle, port) -1
-#define sepol_port_clone(handle, port1, port2) -1
-#define sepol_port_free(port)
-
 /* Key */
 int semanage_port_compare(
 	semanage_port_t* port, 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	2005-12-14 11:04:25.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-12-23 20:27:39.000000000 -0500
@@ -16,13 +16,6 @@ typedef struct dbase_policydb dbase_t;
 #include "debug.h"
 #include "database_policydb.h"
 
-/* FIXME:  Remove when sepol port interface is stabilized and exported. */
-#define sepol_port_modify NULL
-#define sepol_port_query NULL
-#define sepol_port_count NULL
-#define sepol_port_exists NULL
-#define sepol_port_iterate NULL
-
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
 record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
 	.add         = NULL, 
diff -Naurp --exclude-from excludes old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-11-15 08:06:55.000000000 -0500
+++ new/libsepol/src/libsepol.map	2005-11-23 18:36:54.000000000 -0500
@@ -4,6 +4,7 @@
 	sepol_bool_*; sepol_genbools*; 
 	sepol_context*; sepol_check_context;
 	sepol_iface_*; 
+	sepol_port_*;
 	sepol_user_*; sepol_genusers; sepol_set_delusers;
 	sepol_msg_*; sepol_debug;
 	sepol_handle_*;
diff -Naurp --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2005-12-23 01:51:54.000000000 -0500
+++ new/libsepol/src/port_record.c	2005-12-23 20:25:18.000000000 -0500
@@ -86,8 +86,8 @@ int sepol_port_compare(
 
 	/* FIXME: needs to support ordering of ports (-1, 0, 1) */
 
-	if ((port->low <= key->low) && 
-	    (port->high >= key->high) &&
+	if ((port->low == key->low) && 
+	    (port->high == key->high) &&
 	    (port->proto == key->proto))
 		return 0;
 
diff -Naurp --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-11-04 15:37:13.000000000 -0500
+++ new/libsepol/src/ports.c	2005-12-23 20:26:07.000000000 -0500
@@ -182,7 +182,7 @@ int sepol_port_exists (
 		int low2 = c->u.port.low_port;
 		int high2 = c->u.port.high_port;
 
-		if (proto == proto2 && low2 <= low && high2 >= high) {
+		if (proto == proto2 && low2 == low && high2 == high) {
 			*response = 1;
 			return STATUS_SUCCESS;
 		}
@@ -220,7 +220,7 @@ int sepol_port_query(
 		int low2 = c->u.port.low_port;
 		int high2 = c->u.port.high_port;
 
-		if (proto == proto2 && low2 <= low && high2 >= high) {
+		if (proto == proto2 && low2 == low && high2 == high) {
 			if (port_to_record(handle, policydb, c, response) < 0)
 				goto err;
 			return STATUS_SUCCESS;
@@ -263,7 +263,7 @@ int sepol_port_modify(
 		int low2 = c->u.port.low_port;
 		int high2 = c->u.port.high_port;
 
-		if (proto == proto2 && low2 <= low && high2 >= high) {
+		if (proto == proto2 && low2 == low && high2 == high) {
 
 			/* Replace */
 			port->next = c->next;

--------------060803060802030700090308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
