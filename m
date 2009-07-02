Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n622Dedr031114
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:13:40 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n622DMfq024807
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 02:13:23 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n622Ddae030999
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:13:39 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n622DcGV017082
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:13:38 -0400
Received: from [10.16.10.57] (vpn-10-57.bos.redhat.com [10.16.10.57])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n622DbCH023845
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:13:38 -0400
Message-ID: <4A4C17D1.3060208@redhat.com>
Date: Wed, 01 Jul 2009 22:13:37 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [Patch 2/2] libsemanage: remember and retrieve dontaudit settings
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com> <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil> <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
In-Reply-To: <4A4C168C.2040900@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------020105020305060805060905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020105020305060805060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2009 10:08 PM, Christopher Pardy wrote:
> This is a heavily modified version of the patch I recently submitted. 
> It provides 3 new functions: in libsepol sepol_get_disable_dontaudit; 
> in libsemanage semanage_get_disable_dontaudit; in libselinux 
> is_dontaudit_disabled. It also fixes issues with the previous patch.
>
> The justification for this patch is the same as the one I posted 
> earlier. Simply, there is currently no way to know if dontaudit rules 
> are  enabled. Additionally once don't audit rules are turned they turn 
> themselves off after policy rebuild (is that the desired 
> functionality?) This patch provides  a way to check on both the 
> current and pending state of the dontaudit rules and it maintains this 
> state between policy rebuilds.
>
> Signed-off-by Christopher Pardy <cpardy@redhat.com>
This patch implements the functions in libsemanage and libselinux.

diff -urN selinux.orig2/libselinux/include/selinux/selinux.h 
selinux/libselinux/include/selinux/selinux.h
--- selinux.orig2/libselinux/include/selinux/selinux.h    2009-07-01 
21:15:17.009238289 -0400
+++ selinux/libselinux/include/selinux/selinux.h    2009-07-01 
21:44:57.264509874 -0400
@@ -8,6 +8,9 @@
  extern "C" {
  #endif

+/* Return 1 if the dont audit rules have been turned off or 0 if not. */
+extern int is_dontaudit_disabled(void);
+
  /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 
if we get an error. */
  extern int is_selinux_enabled(void);
  /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
diff -urN selinux.orig2/libselinux/src/dontaudit.c 
selinux/libselinux/src/dontaudit.c
--- selinux.orig2/libselinux/src/dontaudit.c    1969-12-31 
19:00:00.000000000 -0500
+++ selinux/libselinux/src/dontaudit.c    2009-07-01 21:48:48.635521208 
-0400
@@ -0,0 +1,21 @@
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include "selinux_internal.h"
+#include <stdlib.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+
+int is_dontaudit_disabled(void)
+{
+    char path[PATH_MAX];
+    snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
+
+    if (access(path,F_OK) == 0)
+        return 1;
+    else
+        return 0;
+}
+
+hidden_def(is_dontaudit_disabled)
diff -urN selinux.orig2/libselinux/src/selinux_internal.h 
selinux/libselinux/src/selinux_internal.h
--- selinux.orig2/libselinux/src/selinux_internal.h    2009-07-01 
21:15:17.074235819 -0400
+++ selinux/libselinux/src/selinux_internal.h    2009-07-01 
21:44:57.272486689 -0400
@@ -24,6 +24,7 @@
      hidden_proto(security_compute_create_raw)
      hidden_proto(security_compute_member_raw)
      hidden_proto(security_compute_relabel_raw)
+    hidden_proto(is_dontaudit_disabled)
      hidden_proto(is_selinux_enabled)
      hidden_proto(is_selinux_mls_enabled)
      hidden_proto(freecon)
diff -urN selinux.orig2/libsemanage/include/semanage/handle.h 
selinux/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h    2009-07-01 
21:15:17.224235939 -0400
+++ selinux/libsemanage/include/semanage/handle.h    2009-07-01 
21:44:57.274484577 -0400
@@ -69,6 +69,9 @@
   * 1 for yes, 0 for no (default) */
  void semanage_set_create_store(semanage_handle_t * handle, int 
create_store);

+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
  /* Set whether or not to disable dontaudits upon commit */
  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int 
disable_dontaudit);

diff -urN selinux.orig2/libsemanage/src/handle.c 
selinux/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c    2009-07-01 
21:15:17.288238017 -0400
+++ selinux/libsemanage/src/handle.c    2009-07-01 21:55:04.525487189 -0400
@@ -29,6 +29,7 @@
  #include <stdio.h>
  #include <string.h>
  #include <sys/time.h>
+#include <limits.h>

  #include "direct_api.h"
  #include "handle.h"
@@ -58,6 +59,9 @@
      if (!sh->sepolh)
          goto err;
      sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
+
+    /* Set the disable_dont audit to the system default */
+    semanage_set_disable_dontaudit(sh,is_dontaudit_disabled());

      /* By default do not rebuild the policy on commit
       * If any changes are made, this flag is ignored */
@@ -110,6 +114,14 @@
      return;
  }

+int semanage_get_disable_dontaudit(semanage_handle_t * sh)
+{
+    assert(sh != NULL);
+
+    return sepol_get_disable_dontaudit(sh->sepolh);
+}
+
+
  void semanage_set_disable_dontaudit(semanage_handle_t * sh, int 
disable_dontaudit)
  {
      assert(sh != NULL);
@@ -264,11 +276,22 @@
      assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
      if (!sh->is_in_transaction) {
          ERR(sh,
-            "Will not commit because caller does not have a tranaction 
lock yet.");
+            "Will not commit because caller does not have a transaction 
lock yet.");
          return -1;
      }
      retval = sh->funcs->commit(sh);
      sh->is_in_transaction = 0;
      sh->modules_modified = 0;
+    if (retval == 0){
+        char path[PATH_MAX];
+        
snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
+        if(semanage_get_disable_dontaudit(sh) == 1){
+            FILE *touch;
+            touch = fopen(path,"w");
+            fclose(touch);
+        }else{
+            remove(path);
+        }
+    }
      return retval;
  }
diff -urN selinux.orig2/libsemanage/src/libsemanage.map 
selinux/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map    2009-07-01 
21:15:17.290237650 -0400
+++ selinux/libsemanage/src/libsemanage.map    2009-07-01 
21:44:57.278485521 -0400
@@ -15,7 +15,7 @@
        semanage_iface_*; semanage_port_*; semanage_context_*;
        semanage_node_*;
        semanage_fcontext_*; semanage_access_check; 
semanage_set_create_store;
-      semanage_is_connected; semanage_set_disable_dontaudit;
+      semanage_is_connected; semanage_get_disable_dontaudit; 
semanage_set_disable_dontaudit;
        semanage_mls_enabled;
    local: *;
  };

--------------020105020305060805060905
Content-Type: text/plain;
 name="selinux.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch2"

diff -urN selinux.orig2/libselinux/include/selinux/selinux.h selinux/libselinux/include/selinux/selinux.h
--- selinux.orig2/libselinux/include/selinux/selinux.h	2009-07-01 21:15:17.009238289 -0400
+++ selinux/libselinux/include/selinux/selinux.h	2009-07-01 21:44:57.264509874 -0400
@@ -8,6 +8,9 @@
 extern "C" {
 #endif
 
+/* Return 1 if the dont audit rules have been turned off or 0 if not. */
+extern int is_dontaudit_disabled(void);
+
 /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
 extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
diff -urN selinux.orig2/libselinux/src/dontaudit.c selinux/libselinux/src/dontaudit.c
--- selinux.orig2/libselinux/src/dontaudit.c	1969-12-31 19:00:00.000000000 -0500
+++ selinux/libselinux/src/dontaudit.c	2009-07-01 21:48:48.635521208 -0400
@@ -0,0 +1,21 @@
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include "selinux_internal.h"
+#include <stdlib.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+
+int is_dontaudit_disabled(void)
+{
+	char path[PATH_MAX];
+	snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
+
+	if (access(path,F_OK) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+hidden_def(is_dontaudit_disabled)
diff -urN selinux.orig2/libselinux/src/selinux_internal.h selinux/libselinux/src/selinux_internal.h
--- selinux.orig2/libselinux/src/selinux_internal.h	2009-07-01 21:15:17.074235819 -0400
+++ selinux/libselinux/src/selinux_internal.h	2009-07-01 21:44:57.272486689 -0400
@@ -24,6 +24,7 @@
     hidden_proto(security_compute_create_raw)
     hidden_proto(security_compute_member_raw)
     hidden_proto(security_compute_relabel_raw)
+    hidden_proto(is_dontaudit_disabled)
     hidden_proto(is_selinux_enabled)
     hidden_proto(is_selinux_mls_enabled)
     hidden_proto(freecon)
diff -urN selinux.orig2/libsemanage/include/semanage/handle.h selinux/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux/libsemanage/include/semanage/handle.h	2009-07-01 21:44:57.274484577 -0400
@@ -69,6 +69,9 @@
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff -urN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux/libsemanage/src/handle.c	2009-07-01 21:55:04.525487189 -0400
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -58,6 +59,9 @@
 	if (!sh->sepolh)
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
+	
+	/* Set the disable_dont audit to the system default */
+	semanage_set_disable_dontaudit(sh,is_dontaudit_disabled());
 
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
@@ -110,6 +114,14 @@
 	return;
 }
 
+int semanage_get_disable_dontaudit(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+
+	return sepol_get_disable_dontaudit(sh->sepolh);
+}
+
+
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
@@ -264,11 +276,22 @@
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
 	sh->is_in_transaction = 0;
 	sh->modules_modified = 0;
+	if (retval == 0){
+		char path[PATH_MAX];
+		snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
+		if(semanage_get_disable_dontaudit(sh) == 1){
+			FILE *touch;
+			touch = fopen(path,"w");
+			fclose(touch);
+		}else{
+			remove(path);
+		}
+	}
 	return retval;
 }
diff -urN selinux.orig2/libsemanage/src/libsemanage.map selinux/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux/libsemanage/src/libsemanage.map	2009-07-01 21:44:57.278485521 -0400
@@ -15,7 +15,7 @@
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };

--------------020105020305060805060905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
