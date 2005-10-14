Message-ID: <434FFB5B.1090605@cornell.edu>
Date: Fri, 14 Oct 2005 14:39:23 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Bugfix previous patches
References: <434FF612.8010708@cornell.edu>
In-Reply-To: <434FF612.8010708@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------060500010703080300030000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060500010703080300030000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:
> Adds a few direct databases to the handle.
> There's still no dangerous code in the main commit path...
> This is just the equivalent to file init.
Attached patch includes bugfixes for previous submissions (applies on top).

Specifically:
- direct code should be in direct_api.c (connect/disconnect), not in the 
create/destroy for the handle.
- removes suffix parameter from direct init functions - I don't think 
I'll be implementing per module
databases at this time (maybe some other day)
- set correct suffix to policy.kern, not base.pp - we want to operate on 
the expanded policy, with the modules merged.
Actually, with this fix, there's now a slight chance the dbase_direct 
cache function might start to work (since we're no longer using the 
policy package, so it's just a standard policy database, I think).... 
but I'd need to test that further.
- add release() calls for the boolean/interface/seuser databases.



--------------060500010703080300030000
Content-Type: text/x-patch;
 name="libsemanage.direct.bugfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.direct.bugfixes.diff"

diff -Naur libsemanage/src/direct_api.c libsemanage.new/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-10-14 14:20:47.000000000 -0400
+++ libsemanage.new/src/direct_api.c	2005-10-14 14:31:34.000000000 -0400
@@ -28,6 +28,13 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
+#include "users_direct.h"
+#include "ports_direct.h"
+#if 0
+#include "interfaces_direct.h"
+#include "booleans_direct.h"
+#endif
+
 #include "debug.h"
 #include "handle.h"
 #include "modules.h"
@@ -64,9 +71,8 @@
 /* Check that the module store exists, creating it if necessary.
  */
 int semanage_direct_connect(semanage_handle_t *sh) {
-	if (semanage_create_store(sh, 1) < 0) {
-		return -1;
-	}
+	if (semanage_create_store(sh, 1) < 0) 
+		goto err;
 
 	sh->conn.module.translock_file_fd = -1;
 	sh->conn.module.readlock_file_fd = -1;
@@ -74,9 +80,25 @@
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
 
-	/* FIXME: configure policy query databases */
+	if (user_direct_dbase_init(&sh->dbase[DBASE_BASE_USERS]) < 0)
+		goto err;
 
-	return 0;
+	if (port_direct_dbase_init(&sh->dbase[DBASE_BASE_PORTS]) < 0)
+		goto err;
+
+#if 0
+	if (iface_direct_dbase_init(&sh->dbase[DBASE_BASE_INTERFACES]) < 0)
+		goto err;
+
+	if (bool_direct_dbase_init(&sh->dbase[DBASE_BASE_BOOLEANS]) < 0)
+		goto err;
+#endif
+
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
 }
 
 static void semanage_direct_destroy(semanage_handle_t *sh) {
@@ -95,7 +117,13 @@
 		semanage_release_trans_lock(sh);
 	}
 
-	/* FIXME: release policy query databases */
+	/* Remove object databases */
+	user_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_USERS]);
+	port_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_PORTS]);
+#if 0
+	iface_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_INTERFACES]);
+	bool_direct_dbase_release(sh, &sh->dbase[DBASE_BASE_BOOLEANS]);
+#endif
 
 	return 0;
 }
diff -Naur libsemanage/src/handle.c libsemanage.new/src/handle.c
--- libsemanage/src/handle.c	2005-10-14 14:20:47.000000000 -0400
+++ libsemanage.new/src/handle.c	2005-10-14 14:32:22.000000000 -0400
@@ -29,9 +29,9 @@
 #include <stdio.h>
 #include <sys/time.h>
 
+#include "direct_api.h"
 #include "handle.h"
 #include "debug.h"
-#include "direct_api.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
 #include "users_file.h"
@@ -39,8 +39,6 @@
 #include "interfaces_file.h"
 #include "booleans_file.h"
 #include "seusers_file.h"
-#include "users_direct.h"
-#include "ports_direct.h"
 #include "database.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
@@ -92,12 +90,6 @@
 	if (seuser_file_dbase_init(&sh->dbase[DBASE_SEUSERS]) < 0)
 		goto err;
 
-	if (user_direct_dbase_init("base.pp", &sh->dbase[DBASE_BASE_USERS]) < 0)
-		goto err;
-
-	if (port_direct_dbase_init("base.pp", &sh->dbase[DBASE_BASE_PORTS]) < 0)
-		goto err;
-
         return sh;
 
  omem:
@@ -150,6 +142,9 @@
 	/* Free object databases */
 	user_file_dbase_release(sh, &sh->dbase[DBASE_USERS]);
 	port_file_dbase_release(sh, &sh->dbase[DBASE_PORTS]);
+	iface_file_dbase_release(sh, &sh->dbase[DBASE_INTERFACES]);
+	bool_file_dbase_release(sh, &sh->dbase[DBASE_BOOLEANS]);
+	seuser_file_dbase_release(sh, &sh->dbase[DBASE_SEUSERS]);
 
 	free(sh);
 }
diff -Naur libsemanage/src/ports_direct.c libsemanage.new/src/ports_direct.c
--- libsemanage/src/ports_direct.c	2005-10-06 15:22:48.000000000 -0400
+++ libsemanage.new/src/ports_direct.c	2005-10-14 14:22:56.000000000 -0400
@@ -28,11 +28,10 @@
 };
 
 int port_direct_dbase_init(
-	const char* suffix,
 	dbase_config_t* dconfig) {
 
 	if (dbase_direct_init(
-		suffix,
+		"policy.kern",
 		&SEPOL_PORT_RTABLE,
 		&SEMANAGE_PORT_DIRECT_RTABLE, 
 		&dconfig->dbase) < 0) 
diff -Naur libsemanage/src/ports_direct.h libsemanage.new/src/ports_direct.h
--- libsemanage/src/ports_direct.h	2005-10-06 15:22:48.000000000 -0400
+++ libsemanage.new/src/ports_direct.h	2005-10-14 14:29:37.000000000 -0400
@@ -5,7 +5,6 @@
 #include "handle.h"
 
 int port_direct_dbase_init(
-	const char* suffix,
 	dbase_config_t* dconfig);
 
 void port_direct_dbase_release(
diff -Naur libsemanage/src/users_direct.c libsemanage.new/src/users_direct.c
--- libsemanage/src/users_direct.c	2005-10-06 15:22:48.000000000 -0400
+++ libsemanage.new/src/users_direct.c	2005-10-14 14:23:00.000000000 -0400
@@ -28,11 +28,10 @@
 };
 
 int user_direct_dbase_init(
-	const char* suffix,
 	dbase_config_t* dconfig) {
 
 	if (dbase_direct_init(
-		suffix,
+		"policy.kern",
 		&SEPOL_USER_RTABLE, 
 		&SEMANAGE_USER_DIRECT_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naur libsemanage/src/users_direct.h libsemanage.new/src/users_direct.h
--- libsemanage/src/users_direct.h	2005-10-06 15:22:48.000000000 -0400
+++ libsemanage.new/src/users_direct.h	2005-10-14 14:29:31.000000000 -0400
@@ -5,7 +5,6 @@
 #include "handle.h"
 
 int user_direct_dbase_init(
-	const char* suffix,
 	dbase_config_t* dconfig);
 
 void user_direct_dbase_release(

--------------060500010703080300030000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
