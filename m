Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5DJcUI4007083
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 15:38:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5DJbnss027678
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 19:37:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h5DJbnhY027673
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 19:37:49 GMT
Received: from moss-huskers.epoch.ncsc.mil (moss-huskers [144.51.25.140])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5DJcQu1012696
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 15:38:26 -0400 (EDT)
Subject: [patch] newrole tty relabeling fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-tpYBD5LoCqG1jszHTeFr"
Message-Id: <1055533107.3362.19.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 13 Jun 2003 15:38:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tpYBD5LoCqG1jszHTeFr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch corrects the newrole tty relabeling bug identified by
Rafal Wojtczuk.  The patch changes newrole to sets it handler for SIGHUP
to the default action so that it will be terminated by vhangup, to use
open+fstat_secure+fchsid to ensure that it is accessing the same tty
throughout, and to recheck the tty label before resetting it to the
original value when the child process terminates.

To apply, save the attachment to ~/newrole.patch, cd
selinux/utils/newrole, and run patch -p0 < ~/newrole.patch.  Then build
and install the updated newrole and relabel it to the proper context
(system_u:object_r:newrole_exec_t).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-tpYBD5LoCqG1jszHTeFr
Content-Disposition: attachment; filename=newrole.patch
Content-Type: text/x-patch; name=newrole.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: newrole.c
===================================================================
RCS file: /home/pal/CVS/selinux/utils/newrole/newrole.c,v
retrieving revision 1.9
retrieving revision 1.12
diff -u -r1.9 -r1.12
--- newrole.c	9 Jan 2003 15:20:39 -0000	1.9
+++ newrole.c	13 Jun 2003 13:34:23 -0000	1.12
@@ -63,6 +63,7 @@
 #include <ss.h>                   /* for sid<->context routines */
 #include <context.h>              /* for context-mangling functions */
 #include <get_default_type.h>
+#include <signal.h>
 
 /* USAGE_STRING describes the command-line args of this program. */
 #define USAGE_STRING "USAGE: newrole -r role [ -t type ] [ -- args ]"
@@ -272,6 +273,7 @@
  
   security_id_t tty_sid;	     /* The current sid of tty file */
   security_id_t new_tty_sid;	     /* The new tty file sid */	
+  security_id_t sid;	     
 
   security_context_t context_s;      /* our security context as a string */
   int context_length;
@@ -296,6 +298,7 @@
   struct stat statbuf;		     /* when stat'ing the tty */
   int fd;
 
+  signal(SIGHUP, SIG_DFL);
 
   /*
    *
@@ -495,11 +498,22 @@
 
   /* Fetch TTY information */
   ttyn=ttyname(0);
-  if( ttyn==NULL || *ttyn=='\0' || stat_secure(ttyn,&statbuf,&tty_sid) ) {
+  if( ttyn==NULL || *ttyn=='\0') {
       fprintf(stderr, "Could not retrieve tty information.\n");
       exit (-1);
     }
 
+  fd = open(ttyn, O_RDWR);
+  if (fd < 0) {
+      fprintf(stderr, "Could not open %s.\n", ttyn);
+      exit (-1);
+  }
+	  
+  if (fstat_secure(fd,&statbuf,&tty_sid) ) {
+      fprintf(stderr, "Could not fstat_secure %s.\n", ttyn);
+      exit (-1);
+  }
+
 #ifdef CANTSPELLGDB
   printf("Your tty %s was labeled with SID %d\n", ttyn, tty_sid);
 #endif
@@ -515,7 +529,7 @@
 #endif
 
   /* Relabel it */
-  if( chsid(ttyn,new_tty_sid)!=0 ) {
+  if( fchsid(fd,new_tty_sid)!=0 ) {
     fprintf(stderr,"newrole: error: chsid");
     exit(-1);
   }
@@ -531,18 +545,30 @@
     /* PARENT */
     wait(NULL);
 
+    /* Verify that the tty still has the SID set by newrole. */
+    if (fstat_secure(fd,&statbuf,&sid) ) {
+	  fprintf(stderr, "Could not fstat_secure %s.\n", ttyn);
+	  exit (-1);
+    }
+
+    if (sid != new_tty_sid) {
+	    fprintf(stderr, "%s changed labels.\n", ttyn);
+	    exit(-1);
+    }
+
 #ifdef CANTSPELLGDB
   printf("Restoring tty %s back to SID %d\n", ttyn, tty_sid);
 #endif
 
-    /* Cleanup TTY Context */
-    chsid(ttyn,tty_sid);
+    fchsid(fd,tty_sid);
 
     /* Done! */
     exit(0);
   }
 
   /* CHILD */
+
+  close(fd);
 
   /* Close and reopen descriptors 0 through 2 */
   if( close(0) || close(1) || close(2) )

--=-tpYBD5LoCqG1jszHTeFr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
