Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61Fv5AV012383
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 11:57:05 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n61Fvd4N020423
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 15:57:39 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n61Fv3tU018152
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 11:57:03 -0400
Message-ID: <4A4B874E.8020402@redhat.com>
Date: Wed, 01 Jul 2009 11:57:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Christopher Pardy <cpardy@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
References: <4A4B656D.1030004@redhat.com>
In-Reply-To: <4A4B656D.1030004@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090505090304040203070902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090505090304040203070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2009 09:32 AM, Christopher Pardy wrote:
> Creates a empty file disable_dontaudit in the polciy directory
> (/etc/selinux/<policytype>). Checks for the existance of this file to
> set the sepol disable don't audit upon handle creation. Also provides
> the function "int semanage_get_disable_dontaudit()" which returns the
> don't audit property of the current policy.
>
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>

Better version of patch.

--------------090505090304040203070902
Content-Type: text/plain;
 name="libsemanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/handle.h libsemanage-2.0.32/include/semanage/handle.h
--- nsalibsemanage/include/semanage/handle.h	2008-11-14 17:10:15.000000000 -0500
+++ libsemanage-2.0.32/include/semanage/handle.h	2009-07-01 11:29:25.000000000 -0400
@@ -72,6 +72,9 @@
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
+/* Get the whether or not dontaudits are disabled upon commit */
+int semanage_get_disable_dontudit();
+ 
 /* Check whether policy is managed via libsemanage on this system.
  * Must be called prior to trying to connect.
  * Return 1 if policy is managed via libsemanage on this system,
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.c libsemanage-2.0.32/src/handle.c
--- nsalibsemanage/src/handle.c	2008-11-14 17:10:15.000000000 -0500
+++ libsemanage-2.0.32/src/handle.c	2009-07-01 11:49:20.000000000 -0400
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <limits.h>
 
 #include "direct_api.h"
 #include "handle.h"
@@ -76,7 +77,10 @@
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
-	return sh;
+ 	/* Set disable dontaudit */
+ 	sepol_set_disable_dontaudit(sh->sepolh,semanage_get_disable_dontaudit());
+
+ 	return sh;
 
       err:
 	semanage_handle_destroy(sh);
@@ -110,11 +114,32 @@
 	return;
 }
 
+int semanage_get_disable_dontaudit()
+{
+ 	char path[PATH_MAX];
+	snprintf(path, PATH_MAX, "%s/disable_dontaudit", selinux_policy_root());
+	
+	/*check for the files existance*/
+	return (access(path,F_OK) == 0);
+}
+ 
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
+
+ 	char path[PATH_MAX];
+	snprintf(path, PATH_MAX, "%s/disable_dontaudit", selinux_policy_root());
 	
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
+
+ 	/*touch or delete the file*/
+ 	if (disable_dontaudit != 0){
+ 		FILE *touch;
+ 		touch = fopen(path,"w");
+ 		fclose(touch);
+ 	}else
+ 		remove(path);
+
 	return;
 }
 
@@ -264,7 +289,7 @@
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);

--------------090505090304040203070902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
