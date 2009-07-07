Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n67DmvIH023702
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 09:48:57 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n67DnZHU021878
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 13:49:35 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n67DmtFh005319
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 09:48:55 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n67DmsYU019222
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 09:48:55 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n67DmsNH031805
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 09:48:54 -0400
Message-ID: <4A535240.1000900@redhat.com>
Date: Tue, 07 Jul 2009 09:48:48 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [Patch 2/2 v4] libsemanage: maintain disable dontaudit state
 between handle commits
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com>	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil> <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil> <4A520D47.4040708@redhat.com> <4A52100C.3010302@redhat.com> <4A523652.2040603@redhat.com> <4A524C27.7020601@redhat.com>
In-Reply-To: <4A524C27.7020601@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------000606090208070107070203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000606090208070107070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules. In the event that a the file cannot be created the dontaudit rules dont change and errors are set.
 
Signed-off-by: Christopher Pardy <cpardy@redhat.com>

---
 libsemanage/include/semanage/handle.h |    8 +++++-
 libsemanage/src/direct_api.c          |   40 ++++++++++++++++++++++++++++++++++
 libsemanage/src/direct_api.h          |    5 ++++
 libsemanage/src/handle.c              |   21 ++++++++++++++++-
 libsemanage/src/libsemanage.map       |    2 -
 libsemanage/src/semanage_store.c      |    1 
 libsemanage/src/semanage_store.h      |    1 
 7 files changed, 74 insertions(+), 4 deletions(-)

diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux.orig3/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux.orig3/libsemanage/include/semanage/handle.h	2009-07-07 09:37:35.888570766 -0400
@@ -69,7 +69,13 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
-/* Set whether or not to disable dontaudits upon commit */
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
+/* Set whether or not to disable dontaudits upon commit
+ * Sets errno to 0 if successful. Otherwise sets errno
+ * to any of the errors specified by fopen,fclose, or remove.
+ */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
 /* Check whether policy is managed via libsemanage on this system.
diff -urpN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
--- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
+++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-07 09:19:28.174321784 -0400
@@ -293,6 +293,46 @@ static int semanage_direct_begintrans(se
 	return 0;
 }
 
+/*********Dont audit functions*************/
+
+/* Creates, removes, and tests for the existance of a dont audit flag.
+ */
+
+int get_disable_dontaudit_flag(void)
+{
+	const char *path;
+	
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(access(path,F_OK) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+int set_disable_dontaudit_flag(int setting)
+{
+	const char *path;
+	int retcode;
+
+	retcode = 0;
+
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(setting == 1){
+		FILE *touch;
+		touch = fopen(path,"w");
+		if (touch != NULL)
+			if(fclose(touch) != 0)
+				retcode = -1;
+		else
+			retcode = -1;
+	}else
+		if(remove(path) == -1 && errno != ENOENT)
+			retcode = -1
+	
+	return retcode;
+}
+
+
 /********************* utility functions *********************/
 
 /* Takes a module stored in 'module_data' and parses its headers.
diff -urpN selinux.orig2/libsemanage/src/direct_api.h selinux.orig3/libsemanage/src/direct_api.h
--- selinux.orig2/libsemanage/src/direct_api.h	2009-07-01 21:15:17.270235734 -0400
+++ selinux.orig3/libsemanage/src/direct_api.h	2009-07-07 08:50:24.620326359 -0400
@@ -39,6 +39,11 @@ int semanage_direct_access_check(struct 
 
 int semanage_direct_mls_enabled(struct semanage_handle *sh);
 
+int get_disable_dontaudit_flag(void);
+
+/*returns a 0 on success*/
+int set_disable_dontaudit_flag(int setting);
+
 #include <stdio.h>
 #include <unistd.h>
 ssize_t bunzip(FILE *f, char **data);
diff -urpN selinux.orig2/libsemanage/src/handle.c selinux.orig3/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux.orig3/libsemanage/src/handle.c	2009-07-07 09:44:23.677572218 -0400
@@ -23,6 +23,7 @@
 
 #include <selinux/selinux.h>
 
+#include <errno.h>
 #include <stdarg.h>
 #include <assert.h>
 #include <stdlib.h>
@@ -59,6 +60,9 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/*set the disable dontaudit flag to system defaults*/
+	sepol_set_disable_dontaudit(sh->sepolh,get_disable_dontaudit_flag());
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -66,6 +70,7 @@ semanage_handle_t *semanage_handle_creat
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
+
 	/* By default do not create store */
 	sh->create_store = 0;
 
@@ -110,11 +115,22 @@ void semanage_set_create_store(semanage_
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
+	if(set_disable_dontaudit_flag(disable_dontaudit) == 0){
+		sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
+		errno = 0;
+	}else
+		ERR(sh,"Could not set disable dontaudit flag of handle.");
 	
-	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
 	return;
 }
 
@@ -264,9 +280,10 @@ int semanage_commit(semanage_handle_t * 
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
+	set_disable_dontaudit_flag(sepol_get_disable_dontaudit(sh->sepolh));
 	retval = sh->funcs->commit(sh);
 	sh->is_in_transaction = 0;
 	sh->modules_modified = 0;
diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux.orig3/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux.orig3/libsemanage/src/libsemanage.map	2009-07-06 13:26:53.591167982 -0400
@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux.orig3/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.c	2009-07-06 13:26:53.598164077 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux.orig3/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.h	2009-07-06 13:26:53.626166474 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };
 

--------------000606090208070107070203
Content-Type: text/plain;
 name="selinux.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch2"

diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux.orig3/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux.orig3/libsemanage/include/semanage/handle.h	2009-07-07 09:37:35.888570766 -0400
@@ -69,7 +69,13 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
-/* Set whether or not to disable dontaudits upon commit */
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
+/* Set whether or not to disable dontaudits upon commit
+ * Sets errno to 0 if successful. Otherwise sets errno
+ * to any of the errors specified by fopen,fclose, or remove.
+ */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
 /* Check whether policy is managed via libsemanage on this system.
diff -urpN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
--- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
+++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-07 09:19:28.174321784 -0400
@@ -293,6 +293,46 @@ static int semanage_direct_begintrans(se
 	return 0;
 }
 
+/*********Dont audit functions*************/
+
+/* Creates, removes, and tests for the existance of a dont audit flag.
+ */
+
+int get_disable_dontaudit_flag(void)
+{
+	const char *path;
+	
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(access(path,F_OK) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+int set_disable_dontaudit_flag(int setting)
+{
+	const char *path;
+	int retcode;
+
+	retcode = 0;
+
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(setting == 1){
+		FILE *touch;
+		touch = fopen(path,"w");
+		if (touch != NULL)
+			if(fclose(touch) != 0)
+				retcode = -1;
+		else
+			retcode = -1;
+	}else
+		if(remove(path) == -1 && errno != ENOENT)
+			retcode = -1
+	
+	return retcode;
+}
+
+
 /********************* utility functions *********************/
 
 /* Takes a module stored in 'module_data' and parses its headers.
diff -urpN selinux.orig2/libsemanage/src/direct_api.h selinux.orig3/libsemanage/src/direct_api.h
--- selinux.orig2/libsemanage/src/direct_api.h	2009-07-01 21:15:17.270235734 -0400
+++ selinux.orig3/libsemanage/src/direct_api.h	2009-07-07 08:50:24.620326359 -0400
@@ -39,6 +39,11 @@ int semanage_direct_access_check(struct 
 
 int semanage_direct_mls_enabled(struct semanage_handle *sh);
 
+int get_disable_dontaudit_flag(void);
+
+/*returns a 0 on success*/
+int set_disable_dontaudit_flag(int setting);
+
 #include <stdio.h>
 #include <unistd.h>
 ssize_t bunzip(FILE *f, char **data);
diff -urpN selinux.orig2/libsemanage/src/handle.c selinux.orig3/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux.orig3/libsemanage/src/handle.c	2009-07-07 09:44:23.677572218 -0400
@@ -23,6 +23,7 @@
 
 #include <selinux/selinux.h>
 
+#include <errno.h>
 #include <stdarg.h>
 #include <assert.h>
 #include <stdlib.h>
@@ -59,6 +60,9 @@ semanage_handle_t *semanage_handle_creat
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/*set the disable dontaudit flag to system defaults*/
+	sepol_set_disable_dontaudit(sh->sepolh,get_disable_dontaudit_flag());
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -66,6 +70,7 @@ semanage_handle_t *semanage_handle_creat
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
+
 	/* By default do not create store */
 	sh->create_store = 0;
 
@@ -110,11 +115,22 @@ void semanage_set_create_store(semanage_
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
+	if(set_disable_dontaudit_flag(disable_dontaudit) == 0){
+		sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
+		errno = 0;
+	}else
+		ERR(sh,"Could not set disable dontaudit flag of handle.");
 	
-	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
 	return;
 }
 
@@ -264,9 +280,10 @@ int semanage_commit(semanage_handle_t * 
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
+	set_disable_dontaudit_flag(sepol_get_disable_dontaudit(sh->sepolh));
 	retval = sh->funcs->commit(sh);
 	sh->is_in_transaction = 0;
 	sh->modules_modified = 0;
diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux.orig3/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux.orig3/libsemanage/src/libsemanage.map	2009-07-06 13:26:53.591167982 -0400
@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux.orig3/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.c	2009-07-06 13:26:53.598164077 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux.orig3/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.h	2009-07-06 13:26:53.626166474 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };
 

--------------000606090208070107070203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
