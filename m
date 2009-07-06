Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n66Es8uQ002680
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:54:08 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n66EroUF006002
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:53:50 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n66Es7Or018428
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:54:07 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n66Es6Pq006174
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:54:06 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n66Es5Db006217
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:54:06 -0400
Message-ID: <4A52100C.3010302@redhat.com>
Date: Mon, 06 Jul 2009 10:54:04 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Patch 2/2] libsemanage: maintain disable dontaudit state between
 handle commits
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com>	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil> <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil> <4A520D47.4040708@redhat.com>
In-Reply-To: <4A520D47.4040708@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules.

Signed-off-by: Christopher Pardy <cpardy@redhat.com>

---
 libsemanage/include/semanage/handle.h |    3 +++
 libsemanage/src/handle.c              |   33 +++++++++++++++++++++++++++++++--
 libsemanage/src/libsemanage.map       |    2 +-
 libsemanage/src/semanage_store.c      |    1 +
 libsemanage/src/semanage_store.h      |    1 +
 5 files changed, 37 insertions(+), 3 deletions(-)


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
+++ selinux/libsemanage/src/handle.c	2009-07-06 10:28:52.492201095 -0400
@@ -23,12 +23,14 @@
 
 #include <selinux/selinux.h>
 
+#include <unistd.h>
 #include <stdarg.h>
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -42,6 +44,7 @@ semanage_handle_t *semanage_handle_creat
 {
 	semanage_handle_t *sh = NULL;
 	const char *conf_name = NULL;
+	char path[PATH_MAX]
 
 	/* Allocate handle */
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
@@ -59,6 +62,14 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/*set the disable dontaudit flag to system defaults*/
+	snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
+
+	if (access(path,F_OK) == 0)
+		semanage_set_disable_dontaudit(sh,1);
+	else
+		semanage_set_disable_dontaudit(sh,0);
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -110,11 +121,29 @@ void semanage_set_create_store(semanage_
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
+	const char *path;
+
 	assert(sh != NULL);
-	
+
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
+	
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+		if(disable_dontaudit == 1){
+			FILE *touch;
+			touch = fopen(path,"w");
+			if (touch != NULL)
+				fclose(touch);
+		}else
+			remove(path);
 	return;
 }
 
@@ -264,7 +293,7 @@ int semanage_commit(semanage_handle_t * 
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
+++ selinux/libsemanage/src/semanage_store.c	2009-07-06 10:06:53.140167854 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/disable_dontaudit",
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
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
