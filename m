Message-ID: <433DA069.3090208@cornell.edu>
Date: Fri, 30 Sep 2005 16:30:33 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: [10 / 9] [ SEMANAGE ] FIx placement of function table
Content-Type: multipart/mixed;
 boundary="------------080603020004080906080500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080603020004080906080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In one of my patches I broke up semanage_private.h into pieces.  
However, I've placed things incorrectly, because I misunderstood what 
things were supposed to do.

This corrects one of the problems - it moves the function table into a 
new file called policy_connection.h. It also renames that structure, 
because I use at least 3 or 4 different types of func_tables in my 
code.  For consistency this should go into interfaces.h, but perhaps I 
should split up interfaces.h into several headers instead (?)

The other problem is the connection object - module_conn_t. I put that 
in modules.h, because it said "module", but it doesn't look like it 
belongs there. Karl, where should I move this? Should it go into 
direct_api.h ? I see the semanage_store makes use of that... is the 
semanage_store specific to the direct API?

On a related note, where can I put policydb pointers - I need two of 
them for starters - ACTIVE, and LOCAL_MOD... the actual policydb objects 
will be created on demand (say when the user decides to query 
something), or when commit decides to re-create the active policy from 
scratch, but I need the pointers to them in a data structure linked into 
the handle (that's specific to direct api?) Should this go into 
conn.module (renaming that to conn.direct ?)


--------------080603020004080906080500
Content-Type: text/x-patch;
 name="libsemanage.policy.poly.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policy.poly.diff"

diff -Naur libsemanage/src/direct_api.c libsemanage.new/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new/src/direct_api.c	2005-09-30 16:10:57.000000000 -0400
@@ -31,6 +31,7 @@
 #include "modules.h"
 #include "direct_api.h"
 #include "semanage_store.h"
+#include "policy_connection.h"
 
 static void semanage_direct_destroy(semanage_handle_t *sh);
 static int semanage_direct_disconnect(semanage_handle_t *sh);
@@ -46,7 +47,7 @@
 static int semanage_direct_list(semanage_handle_t *sh,
 				semanage_module_info_t **modinfo, int *num_modules);
 
-static struct semanage_func_table direct_funcs = {
+static struct semanage_policy_table direct_funcs = {
 	.destroy = semanage_direct_destroy,
 	.disconnect = semanage_direct_disconnect,
 	.begin_trans = semanage_direct_begintrans,
diff -Naur libsemanage/src/handle.h libsemanage.new/src/handle.h
--- libsemanage/src/handle.h	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new/src/handle.h	2005-09-30 16:19:10.000000000 -0400
@@ -27,23 +27,11 @@
 #include <semanage/handle.h>
 #include "modules.h"
 #include "semanage_conf.h"
+#include "policy_connection.h"
 
 /* Can't include - circular dependency */
 struct dbase;
 
-/* FIXME: Some of this needs to go into modules.h */
-struct semanage_func_table {
-	void (*destroy)(semanage_handle_t *);
-	int (*disconnect)(semanage_handle_t *);
-	int (*begin_trans)(semanage_handle_t *);
-	int (*commit)(semanage_handle_t *);
-	int (*install)(semanage_handle_t *, char *, size_t);
-	int (*upgrade)(semanage_handle_t *, char *, size_t);
-	int (*install_base)(semanage_handle_t *, char *, size_t);
-	int (*remove)(semanage_handle_t *, char *);
-	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);
-};
-
 struct semanage_handle {
 	int con_id;             /* Connection ID */
 	int policy_serial;      /* Policy serial number at connect time */
@@ -72,7 +60,7 @@
 	/* these function pointers will point to the appropriate
 	 * routine given the connection type.  think of these as
 	 * simulating polymorphism for non-OO languages. */
-	struct semanage_func_table *funcs;
+	struct semanage_policy_table* funcs;
 
 	/* Object databases */
 #define DBASE_COUNT 2
diff -Naur libsemanage/src/policy_connection.h libsemanage.new/src/policy_connection.h
--- libsemanage/src/policy_connection.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/policy_connection.h	2005-09-30 16:19:53.000000000 -0400
@@ -0,0 +1,55 @@
+/* Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Jason Tang     <jtang@tresys.com>
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_POLICY_CONNECTION_INTERNAL_H_
+#define _SEMANAGE_POLICY_CONNECTION_INTERNAL_H_
+
+struct semanage_policy_table {
+
+	/* Destroy a connection */	
+        void (*destroy)(semanage_handle_t *);
+
+	/* Disconnect from policy */
+        int (*disconnect)(semanage_handle_t *);
+
+	/* Begin a policy transaction */
+        int (*begin_trans)(semanage_handle_t *);
+
+	/* Commit a policy transaction */
+        int (*commit)(semanage_handle_t *);
+
+	/* Install a policy module */
+        int (*install)(semanage_handle_t *, char *, size_t);
+
+	/* Upgrade a policy module */
+        int (*upgrade)(semanage_handle_t *, char *, size_t);
+
+	/* Remove a policy module */
+	int (*remove)(semanage_handle_t *, char *);
+
+	/* List policy modules */
+	int (*list)(semanage_handle_t *, semanage_module_info_t **, int *);
+
+	/* Install base policy */
+        int (*install_base)(semanage_handle_t *, char *, size_t);
+};
+
+#endif

--------------080603020004080906080500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
