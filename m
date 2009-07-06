Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n66CQwos008749
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 08:26:58 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n66CQdUF018195
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 12:26:39 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n66CQuQf007869
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 08:26:56 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n66CQpbg022227
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 08:26:56 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n66CQoYS008200
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 08:26:51 -0400
Message-ID: <4A51ED89.8010001@redhat.com>
Date: Mon, 06 Jul 2009 08:26:49 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [Patch 2/2] libsemanage: create a don't audit flag
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com> <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070201060005030009060505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070201060005030009060505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch provides the new function semanage_get_disable_dontaudit in libsemanage.

The justification for this patch is that there is currently no way to know if dontaudit rules are  enabled. This patch provides a way to check on both the pending state of the dontaudit rules and it creates a flag file which can be looked for to determine the state of dontaudit rule on the last rebuild.

Signed-off-by Christopher Pardy <cpardy@redhat.com> 
---
 libsemanage/include/semanage/handle.h |    3 +++
 libsemanage/src/handle.c              |   26 +++++++++++++++++++++++---
 libsemanage/src/libsemanage.map       |    2 +-
 libsemanage/src/semanage_store.c      |    1 +
 libsemanage/src/semanage_store.h      |    1 +
 5 files changed, 29 insertions(+), 4 deletions(-)


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
+++ selinux/libsemanage/src/handle.c	2009-07-06 08:09:22.536166709 -0400
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -59,6 +60,9 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/*make sure our flags are set right*/
+	semanage_set_disable_dontaudit(sh,semanage_get_disable_dontaudit(sh))
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -75,7 +79,7 @@ semanage_handle_t *semanage_handle_creat
 	/* Set callback */
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
-
+	
 	return sh;
 
       err:
@@ -110,11 +114,27 @@ void semanage_set_create_store(semanage_
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
+	const char *path;
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)
+		if(disable_dontaudit == 1){
+			FILE *touch;
+			touch = fopen(path,"w");
+			fclose(touch);
+		}else
+			remove(path);
 	return;
 }
 
@@ -264,7 +284,7 @@ int semanage_commit(semanage_handle_t * 
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
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux/libsemanage/src/semanage_store.c	2009-07-06 08:21:49.374412534 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/modules/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux/libsemanage/src/semanage_store.h	2009-07-06 08:01:57.577197155 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };
 

--------------070201060005030009060505
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
+++ selinux/libsemanage/src/handle.c	2009-07-06 08:09:22.536166709 -0400
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -59,6 +60,9 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/*make sure our flags are set right*/
+	semanage_set_disable_dontaudit(sh,semanage_get_disable_dontaudit(sh))
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -75,7 +79,7 @@ semanage_handle_t *semanage_handle_creat
 	/* Set callback */
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
-
+	
 	return sh;
 
       err:
@@ -110,11 +114,27 @@ void semanage_set_create_store(semanage_
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
+	const char *path;
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)
+		if(disable_dontaudit == 1){
+			FILE *touch;
+			touch = fopen(path,"w");
+			fclose(touch);
+		}else
+			remove(path);
 	return;
 }
 
@@ -264,7 +284,7 @@ int semanage_commit(semanage_handle_t * 
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
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux/libsemanage/src/semanage_store.c	2009-07-06 08:21:49.374412534 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/modules/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux/libsemanage/src/semanage_store.h	2009-07-06 08:01:57.577197155 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };
 

--------------070201060005030009060505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
