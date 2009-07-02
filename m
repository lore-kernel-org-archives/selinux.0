Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62FWoNN002342
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:32:50 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n62FWYAi011348
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 15:32:34 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n62FWnKo022678
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:32:49 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n62FWnnx007369
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:32:49 -0400
Received: from [10.16.10.15] (vpn-10-15.bos.redhat.com [10.16.10.15])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n62FWmMJ030456
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:32:48 -0400
Message-ID: <4A4CD320.2090706@redhat.com>
Date: Thu, 02 Jul 2009 11:32:48 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [Patch 2/2] libsemanage: create a don't audit flag
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com> <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000305000902070408030305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000305000902070408030305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen, Josh: I think this might address all your concerns.
Changes: No more code in libselinux, new handles have their 
disable_dontaudit flag set to 0 upon creation (old way), 
set_disable_dontaudit creates a file in the sandbox to make the setting 
visible after commits.
Justification: After turning off dontaudit rules there is currently no 
way for the system to see that this change has been made, this creates a 
flag file which can be used as an indicator.
Note: still depends on patch 1/2

Signed-off-by: Christopher Pardy <cpardy@redhat.com>

diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux/libsemanage/include/semanage/handle.h

--- selinux.orig2/libsemanage/include/semanage/handle.h    2009-07-01 21:15:17.224235939 -0400

+++ selinux/libsemanage/include/semanage/handle.h    2009-07-02 11:09:06.982262194 -0400

@@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handl

   * 1 for yes, 0 for no (default) */

  void semanage_set_create_store(semanage_handle_t * handle, int create_store);

  

+/*Get whether or not to dontaudits will be disabled upon commit */

+int semanage_get_disable_dontaudit(semanage_handle_t * handle);

+

  /* Set whether or not to disable dontaudits upon commit */

  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);

  

diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c

--- selinux.orig2/libsemanage/src/handle.c    2009-07-01 21:15:17.288238017 -0400

+++ selinux/libsemanage/src/handle.c    2009-07-02 11:29:20.740267205 -0400

@@ -29,6 +29,7 @@

  #include<stdio.h>

  #include<string.h>

  #include<sys/time.h>

+#include<limits.h>

  

  #include "direct_api.h"

  #include "handle.h"

@@ -75,7 +76,12 @@ semanage_handle_t *semanage_handle_creat

      /* Set callback */

      sh->msg_callback = semanage_msg_default_handler;

      sh->msg_callback_arg = NULL;

-

+

+    /*set the flag to be deleted*/

+    char path[PATH_MAX];

+    path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)

+    remove(path);

+

      return sh;

  

        err:

@@ -110,11 +116,27 @@ void semanage_set_create_store(semanage_

      return;

  }

  

+int semanage_get_disable_dontaudit(semanage_handle_t * sh)

+{

+    assert(sh != NULL);

+

+    return sepol_get_disable_dontaudit(sh->sepolh);

+}

+

  void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)

  {

      assert(sh != NULL);

-

+

      sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);

+

+    char path[PATH_MAX];

+    path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)

+        if(disable_dontaudit(sh) == 1){

+            FILE *touch;

+            touch = fopen(path,"w");

+            fclose(touch);

+        }else

+            remove(path);

      return;

  }

  

@@ -264,7 +286,7 @@ int semanage_commit(semanage_handle_t *

      assert(sh != NULL&&  sh->funcs != NULL&&  sh->funcs->commit != NULL);

      if (!sh->is_in_transaction) {

          ERR(sh,

-            "Will not commit because caller does not have a tranaction lock yet.");

+            "Will not commit because caller does not have a transaction lock yet.");

          return -1;

      }

      retval = sh->funcs->commit(sh);

diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux/libsemanage/src/libsemanage.map

--- selinux.orig2/libsemanage/src/libsemanage.map    2009-07-01 21:15:17.290237650 -0400

+++ selinux/libsemanage/src/libsemanage.map    2009-07-02 11:12:49.864242881 -0400

@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {

        semanage_iface_*; semanage_port_*; semanage_context_*;

        semanage_node_*;

        semanage_fcontext_*; semanage_access_check; semanage_set_create_store;

-      semanage_is_connected; semanage_set_disable_dontaudit;

+      semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;

        semanage_mls_enabled;

    local: *;

  };

diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux/libsemanage/src/semanage_store.h

--- selinux.orig2/libsemanage/src/semanage_store.h    2009-07-01 21:15:17.262235597 -0400

+++ selinux/libsemanage/src/semanage_store.h    2009-07-02 10:35:04.362488949 -0400

@@ -58,7 +58,8 @@ enum semanage_sandbox_defs {

      SEMANAGE_USERS_EXTRA,

      SEMANAGE_NC,

      SEMANAGE_FC_HOMEDIRS,

-    SEMANAGE_STORE_NUM_PATHS

+    SEMANAGE_STORE_NUM_PATHS,

+    SEMANAGE_DISABLE_DONTAUDIT

  };

  

  /* FIXME: this needs to be made a module store specific init and the


--------------000305000902070408030305
Content-Type: text/plain;
 name="selinux.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch2"

diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux/libsemanage/include/semanage/handle.h	2009-07-02 11:09:06.982262194 -0400
@@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux/libsemanage/src/handle.c	2009-07-02 11:29:20.740267205 -0400
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -75,7 +76,12 @@ semanage_handle_t *semanage_handle_creat
 	/* Set callback */
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
-
+	
+	/*set the flag to be deleted*/
+	char path[PATH_MAX];
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)
+	remove(path);
+	
 	return sh;
 
       err:
@@ -110,11 +116,27 @@ void semanage_set_create_store(semanage_
 	return;
 }
 
+int semanage_get_disable_dontaudit(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+
+	return sepol_get_disable_dontaudit(sh->sepolh);
+}
+
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
-	
+
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
+	
+	char path[PATH_MAX];
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)
+		if(disable_dontaudit(sh) == 1){
+			FILE *touch;
+			touch = fopen(path,"w");
+			fclose(touch);
+		}else
+			remove(path);
 	return;
 }
 
@@ -264,7 +286,7 @@ int semanage_commit(semanage_handle_t * 
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux/libsemanage/src/libsemanage.map	2009-07-02 11:12:49.864242881 -0400
@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux/libsemanage/src/semanage_store.h	2009-07-02 10:35:04.362488949 -0400
@@ -58,7 +58,8 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
-	SEMANAGE_STORE_NUM_PATHS
+	SEMANAGE_STORE_NUM_PATHS,
+	SEMANAGE_DISABLE_DONTAUDIT
 };
 
 /* FIXME: this needs to be made a module store specific init and the

--------------000305000902070408030305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
