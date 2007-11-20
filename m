Message-ID: <47435B32.9030205@manicmethod.com>
Date: Tue, 20 Nov 2007 17:09:54 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Athey <jathey@tresys.com>
Subject: [PATCH 1/1] semanage_select_store fun
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, I got a report here that python scripts that call 
semanage_select_store will get a double free error when calling 
semanage_handle_destroy because the swig wrapper free's the buffer 
passed to semanage_select_store. I haven't seen this with semanage but 
the bug does appear legitimate to me, we should have never been assuming 
control of the buffer passed to semanage_select_store (especially 
without documenting it).

This is fun because semanage_select_store was originally a void but 
clearly this needs to strdup() instead of just setting the pointer. This 
patch can be applied trunk as it changes the API but the bug would still 
exist in stable (and the person who reported this will unfortunately 
have to patch it in their release of the stable repo).

---

 libsemanage/include/semanage/handle.h |    3 ++-
 libsemanage/src/handle.c              |   13 ++++++++++---
 policycoreutils/semanage/seobject.py  |    4 +++-
 policycoreutils/semodule/semodule.c   |    3 ++-
 4 files changed, 17 insertions(+), 6 deletions(-)

---

Index: libsemanage/include/semanage/handle.h
===================================================================
--- libsemanage/include/semanage/handle.h	(revision 2677)
+++ libsemanage/include/semanage/handle.h	(working copy)
@@ -48,8 +48,9 @@
 /* This function allows you to specify the store to  connect to.
  * It must be called after semanage_handle_create but before 
  * semanage_connect. The argument should be the full path to the store.
+ * path is duplicated and should be freed by the caller.
  */
-void semanage_select_store(semanage_handle_t * handle, char *path,
+int semanage_select_store(semanage_handle_t * handle, char *path,
 			   enum semanage_connect_type storetype);
 
 /* Just reload the policy */
Index: libsemanage/src/handle.c
===================================================================
--- libsemanage/src/handle.c	(revision 2677)
+++ libsemanage/src/handle.c	(working copy)
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/time.h>
+#include <string.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -123,7 +124,7 @@
 	return sh->is_connected;
 }
 
-void semanage_select_store(semanage_handle_t * sh, char *storename,
+int semanage_select_store(semanage_handle_t * sh, char *storename,
 			   enum semanage_connect_type storetype)
 {
 
@@ -131,10 +132,16 @@
 
 	/* This just sets the storename to what the user requests, no 
 	   verification of existance will be done until connect */
-	sh->conf->store_path = storename;
+	
+	/* sh->conf->store_path could already exist if it was read from the
+ 	 * config file, free first */
+	free(sh->conf->store_path);
+	sh->conf->store_path = strdup(storename);
+	if (!sh->conf->store_path)
+		return -1;
 	sh->conf->store_type = storetype;
 
-	return;
+	return 0;
 }
 
 int semanage_is_managed(semanage_handle_t * sh)
Index: policycoreutils/semanage/seobject.py
===================================================================
--- policycoreutils/semanage/seobject.py	(revision 2677)
+++ policycoreutils/semanage/seobject.py	(working copy)
@@ -219,7 +219,9 @@
 		       raise ValueError(_("Could not create semanage handle"))
 		
                 if store != "":
-                       semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
+			rc = semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
+			if rc:
+				raise ValueError(_("Could not set store."))
 
 		self.semanaged = semanage_is_managed(self.sh)
 
Index: policycoreutils/semodule/semodule.c
===================================================================
--- policycoreutils/semodule/semodule.c	(revision 2677)
+++ policycoreutils/semodule/semodule.c	(working copy)
@@ -293,7 +293,8 @@
 		 * this will always set a direct connection now, an additional
 		 * option will need to be used later to specify a policy server 
 		 * location */
-		semanage_select_store(sh, store, SEMANAGE_CON_DIRECT);
+		if (semanage_select_store(sh, store, SEMANAGE_CON_DIRECT))
+			goto cleanup;
 	}
 
 	/* if installing base module create store if necessary, for bootstrapping */




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
