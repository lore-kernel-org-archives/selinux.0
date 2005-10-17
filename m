Message-ID: <4353F9B7.7010001@cornell.edu>
Date: Mon, 17 Oct 2005 15:21:27 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
Subject: [ SEMANAGE ] Move local dbase initialization
Content-Type: multipart/mixed;
 boundary="------------060803000408090307020906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060803000408090307020906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been explained by Joshua that we need to support a policy server 
backend, even for local files, since they'll be retrieved over the 
policy server in order to do permission checks.

This patch moves initialization of local databases from the handle.c, 
into direct_api.c. Joshua, please take a look...

It also adds commit of seusers database into policy_components.c. I am 
starting to think that the commit_components function can't possibly be 
backend independent,  so it might be a good idea to move it into 
direct_api.c, and use the correct dbase types. I might do that in a 
later patch - hmm...

--------------060803000408090307020906
Content-Type: text/x-patch;
 name="libsemanage.dbase_init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_init.diff"

diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/include/semanage/seuser_record.h new/libsemanage/include/semanage/seuser_record.h
--- old/libsemanage/include/semanage/seuser_record.h	2005-10-14 13:26:14.000000000 -0400
+++ new/libsemanage/include/semanage/seuser_record.h	2005-10-15 06:28:40.000000000 -0400
@@ -1,7 +1,6 @@
 #ifndef _SEMANAGE_SEUSER_RECORD_H_
 #define _SEMANAGE_SEUSER_RECORD_H_
 
-#include <stddef.h>
 #include <semanage/handle.h>
 
 struct semanage_seuser;
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-17 15:05:36.000000000 -0400
@@ -28,6 +28,11 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
+#include "users_file.h"
+#include "seusers_file.h"
+#include "ports_file.h"
+#include "interfaces_file.h"
+#include "booleans_file.h"
 #include "users_direct.h"
 #include "ports_direct.h"
 #if 0
@@ -85,21 +90,33 @@
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
 
-	if (user_direct_dbase_init(
-		semanage_user_dbase_policy(sh)) < 0)
+        /* Configure object databases
+         * Hardcore DATA FILE backend for now */
+	if (user_file_dbase_init(semanage_user_dbase(sh)) < 0)
 		goto err;
 
-	if (port_direct_dbase_init(
-		semanage_port_dbase_policy(sh)) < 0)
+	if (port_file_dbase_init(semanage_port_dbase(sh)) < 0)
 		goto err;
 
+	if (iface_file_dbase_init(semanage_iface_dbase(sh)) < 0)
+		goto err;
+
+	if (bool_file_dbase_init(semanage_bool_dbase(sh)) < 0)
+		goto err;
+
+	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
+		goto err;
+
+	if (user_direct_dbase_init(semanage_user_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (port_direct_dbase_init(semanage_port_dbase_policy(sh)) < 0)
+		goto err;
 #if 0
-	if (iface_direct_dbase_init(
-		semanage_iface_dbase_policy(sh)) < 0)
+	if (iface_direct_dbase_init(semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (bool_direct_dbase_init(
-		semanage_bool_dbase_policy(sh)) < 0)
+	if (bool_direct_dbase_init(semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 #endif
 
@@ -130,6 +147,12 @@
 	sh->sepolh = NULL;
 
 	/* Remove object databases */
+	user_file_dbase_release(sh, semanage_user_dbase(sh));
+	port_file_dbase_release(sh, semanage_port_dbase(sh));
+	iface_file_dbase_release(sh, semanage_iface_dbase(sh));
+	bool_file_dbase_release(sh, semanage_bool_dbase(sh));
+	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
+
 	user_direct_dbase_release(sh, semanage_user_dbase_policy(sh));
 	port_direct_dbase_release(sh, semanage_port_dbase_policy(sh));
 #if 0
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-17 14:06:35.000000000 -0400
+++ new/libsemanage/src/handle.c	2005-10-17 15:05:19.000000000 -0400
@@ -34,12 +34,6 @@
 #include "debug.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
-#include "users_file.h"
-#include "ports_file.h"
-#include "interfaces_file.h"
-#include "booleans_file.h"
-#include "seusers_file.h"
-#include "database.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
 
@@ -49,7 +43,7 @@
 
 	/* Allocate handle */
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
-		goto omem;
+		goto err;
 
 	/* Policy root */
 	const char *pr = selinux_policy_root();
@@ -73,29 +67,9 @@
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
-	/* Configure object databases 
-	 * Hardcore DATA FILE backend for now */
-	if (user_file_dbase_init(semanage_user_dbase(sh)) < 0)
-		goto err;
-
-	if (port_file_dbase_init(semanage_port_dbase(sh)) < 0)
-		goto err;
-
-	if (iface_file_dbase_init(semanage_iface_dbase(sh)) < 0)
-		goto err;
-
-	if (bool_file_dbase_init(semanage_bool_dbase(sh)) < 0)
-		goto err;
-
-	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
-		goto err;
-
         return sh;
 
- omem:
-	/* FIXME: report error condition */
  err:
-	/* FIXME: report error condition */
 	semanage_handle_destroy(sh);
 	return NULL;
 }
@@ -139,13 +113,6 @@
 		sh->funcs->destroy(sh);
 	semanage_conf_destroy(sh->conf);
 
-	/* Free object databases */
-	user_file_dbase_release(sh, semanage_user_dbase(sh));
-	port_file_dbase_release(sh, semanage_port_dbase(sh));
-	iface_file_dbase_release(sh, semanage_iface_dbase(sh));
-	bool_file_dbase_release(sh, semanage_bool_dbase(sh));
-	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
-
 	free(sh);
 }
 
diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-14 14:32:34.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-15 18:33:18.000000000 -0400
@@ -50,6 +50,7 @@
 	dbase_config_t* booleans = semanage_bool_dbase(handle);
 	dbase_config_t* users = semanage_user_dbase(handle);
 	dbase_config_t* ports = semanage_port_dbase(handle);
+	dbase_config_t* seusers = semanage_seuser_dbase(handle);
 
 #if 0
         if (modules->dtable->flush(handle, modules->dbase) < 0)
@@ -68,6 +69,9 @@
 	if (ports->dtable->flush(handle, ports->dbase) < 0) 
 		goto err;
 
+	if (seusers->dtable->flush(handle,  seusers->dbase) < 0)
+		goto err;
+
 	return STATUS_SUCCESS;
 
 	err:
@@ -79,5 +83,6 @@
 	booleans->dtable->drop_cache(handle, booleans->dbase);
 	users->dtable->drop_cache(handle, users->dbase);
 	ports->dtable->drop_cache(handle, ports->dbase);
+	seusers->dtable->drop_cache(handle, seusers->dbase);
 	return STATUS_ERR;
 }

--------------060803000408090307020906--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
