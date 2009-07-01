Message-ID: <4A4B862A.5030608@redhat.com>
Date: Wed, 01 Jul 2009 11:52:10 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
References: <4A4B656D.1030004@redhat.com>	 <1246457216.13464.162.camel@moss-pluto.epoch.ncsc.mil> <1246457786.13464.165.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246457786.13464.165.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090108030000090504030401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090108030000090504030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows for the disable_dontaudit setting to be maintained 
between calls to compile policy. Currently if policy is recompiled 
dontaudit rules are automatically turned on unless they are specifically 
disabled. Additionally this patch provides the ability to check weather 
dontaudit rules are turned on.

Signed-off-by: Christopher Pardy <cpardy@redhat.com>

--------------090108030000090504030401
Content-Type: text/plain;
 name="libsemanage[2].patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage[2].patch"

diff -uprN --exclude='*.o' selinux/libsemanage/include/semanage/handle.h selinux.old/libsemanage/include/semanage/handle.h
--- selinux/libsemanage/include/semanage/handle.h	2009-07-01 09:15:05.470541448 -0400
+++ selinux.old/libsemanage/include/semanage/handle.h	2009-07-01 07:35:33.397536085 -0400
@@ -69,9 +69,6 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
-/* Get the whether or not dontaudits are disabled upon commit */
-int semanage_get_disable_dontudit();
-
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff -uprN --exclude='*.o' selinux/libsemanage/src/handle.c selinux.old/libsemanage/src/handle.c
--- selinux/libsemanage/src/handle.c	2009-07-01 09:10:05.741293868 -0400
+++ selinux.old/libsemanage/src/handle.c	2009-07-01 07:35:33.462536710 -0400
@@ -27,7 +27,6 @@
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <unistd.h>
 #include <string.h>
 #include <sys/time.h>
 
@@ -77,9 +76,6 @@ semanage_handle_t *semanage_handle_creat
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
-	/* Set disable dontaudit */
-	sepol_set_disable_dontaudit(sh->sepolh,semanage_get_disable_dontaudit())
-
 	return sh;
 
       err:
@@ -114,48 +110,11 @@ void semanage_set_create_store(semanage_
 	return;
 }
 
-int semanage_get_disable_dontaudit()
-{
-	/*get the policy type*/
-	char *poltype;
-	selinux_getpolicytype(&poltype);
-	/*create a pathname*/
-	char path[255];
-	strcpy(path,"/etc/selinux/");
-	strcat(path,poltype);
-	strcat(path,"/disable_dontaudit");
-	/*free the string poltype string*/
-	free(poltype);
-	/*check for the files existance*/
-	if (access(path,F_OK) == 0)
-		return 1;
-	else
-		return 0;
-}
-
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
 	
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
-	/*get the policy type*/
-	char *poltype;
-	selinux_getpolicytype(&poltype);
-	/*create a pathname*/
-	char path[255];
-	strcpy(path,"/etc/selinux/");
-	strcat(path,poltype);
-	strcat(path,"/disable_dontaudit");
-	/*free the string poltype string*/
-	free(poltype);
-	/*touch or delete the file*/
-	if (disable_dontaudit != 0){
-		FILE *touch;
-		touch = fopen(path,"w");
-		fclose(touch);
-	}else
-		remove(path);
-
 	return;
 }
 

--------------090108030000090504030401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
