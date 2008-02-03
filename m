Message-ID: <47A5311F.2020703@manicmethod.com>
Date: Sat, 02 Feb 2008 22:12:31 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Todd Miller <tmiller@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: free policydb before fork
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While testing the recent memory-related patches on a low memory machine 
(512m total) I found that semodule still failed. It turns out that 
fork() requires enough free ram for the amount of private dirty memory 
in the parent process to succeed (even if it is never written to in the 
child process). This patch moves the genhomedircon call to outside of 
semanage_sandbox_install so that the policydb can be freed before any 
forks happen. With this patch and the prior ones semodule runs fine on a 
512m machine.
 
Signed-off-By: Joshua Brindle <method@manicmethod.com>

------

Index: libsemanage/src/direct_api.c
===================================================================
--- libsemanage/src/direct_api.c        (revision 2774)
+++ libsemanage/src/direct_api.c        (working copy)
@@ -41,6 +41,7 @@
 #include "boolean_internal.h"
 #include "fcontext_internal.h"
 #include "node_internal.h"
+#include "genhomedircon.h"
 
 #include "debug.h"
 #include "handle.h"
@@ -701,8 +702,27 @@
        if (retval < 0)
                goto cleanup;
 
+       /* run genhomedircon if its enabled, this should be the last operation
+        * which requires the out policydb */
+       if (!sh->conf->disable_genhomedircon) {
+               if ((retval =
+                               semanage_genhomedircon(sh, out, 1)) != 0) {
+                       ERR(sh, "semanage_genhomedircon returned error code %d.",
+                                       retval);
+                       goto cleanup;
+               }
+       } else {
+               WARN(sh, "WARNING: genhomedircon is disabled. \
+                               See /etc/selinux/semanage.conf if you need to enable it.");
+        }
+
+       /* free out, if we don't free it before calling semanage_install_sandbox 
+        * then fork() may fail on low memory machines */
+       sepol_policydb_free(out);
+       out = NULL;
+
        if (sh->do_rebuild || modified) {
-               retval = semanage_install_sandbox(sh, out);
+               retval = semanage_install_sandbox(sh);
        }
 
       cleanup:
Index: libsemanage/src/semanage_store.c
===================================================================
--- libsemanage/src/semanage_store.c    (revision 2775)
+++ libsemanage/src/semanage_store.c    (working copy)
@@ -34,7 +34,6 @@
 #include "semanage_store.h"
 #include "database_policydb.h"
 #include "handle.h"
-#include "genhomedircon.h"
 
 #include <selinux/selinux.h>
 #include <sepol/policydb.h>
@@ -1279,8 +1278,7 @@
  * should be placed within a mutex lock to ensure that it runs
  * atomically. Returns commit number on success, -1 on error.
  */
-int semanage_install_sandbox(semanage_handle_t * sh,
-                            sepol_policydb_t * policydb)
+int semanage_install_sandbox(semanage_handle_t * sh)
 {
        int retval = -1, commit_num = -1;
 
@@ -1293,17 +1291,6 @@
                ERR(sh, "No setfiles program specified in configuration file.");
                goto cleanup;
        }
-       if (!sh->conf->disable_genhomedircon) {
-               if ((retval =
-                    semanage_genhomedircon(sh, policydb, TRUE)) != 0) {
-                       ERR(sh, "semanage_genhomedircon returned error code %d.",
-                           retval);
-                       goto cleanup;
-               }
-       } else {
-               WARN(sh, "WARNING: genhomedircon is disabled. \
-See /etc/selinux/semanage.conf if you need to enable it.");
-       }
 
        if ((commit_num = semanage_commit_sandbox(sh)) < 0) {
                retval = commit_num;
Index: libsemanage/src/semanage_store.h
===================================================================
--- libsemanage/src/semanage_store.h    (revision 2774)
+++ libsemanage/src/semanage_store.h    (working copy)
@@ -100,8 +100,7 @@
 int semanage_write_policydb(semanage_handle_t * sh,
                            sepol_policydb_t * policydb);
 
-int semanage_install_sandbox(semanage_handle_t * sh,
-                            sepol_policydb_t * policydb);
+int semanage_install_sandbox(semanage_handle_t * sh);
 
 int semanage_verify_modules(semanage_handle_t * sh,
                            char **module_filenames, int num_modules);




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
