From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Add version option to newrole
Date: Wed, 8 Feb 2006 14:45:14 -0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aAi6Ddy1H7Iujpc"
Message-Id: <200602081445.14747.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_aAi6Ddy1H7Iujpc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a new version that incorporates your suggestions. I moved the constant 
definition to the makefile, and also, I'm gathering the data from the version 
file. Also, Steve, I would like to hear from you why do you think the -v 
option is not that descriptive.

If you guys accept this patch, my obvious next step would be adding it to the 
manpage. 

Glauber.


--Boundary-00=_aAi6Ddy1H7Iujpc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-newrole.v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-newrole.v2"

diff -upNr policycoreutils-1.29.18/newrole/Makefile policycoreutils-1.29.18.mine/newrole/Makefile
--- policycoreutils-1.29.18/newrole/Makefile	2006-02-02 15:08:13.000000000 -0200
+++ policycoreutils-1.29.18.mine/newrole/Makefile	2006-02-08 14:25:41.000000000 -0200
@@ -10,9 +10,10 @@ AUDITH = $(shell ls /usr/include/libaudi
 # This is so that we have the CAP_AUDIT_WRITE capability. newrole will
 # shed all privileges and change to the user's uid.
 LOG_AUDIT_PRIV ?= n
+VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
Binary files policycoreutils-1.29.18/newrole/newrole and policycoreutils-1.29.18.mine/newrole/newrole differ
diff -upNr policycoreutils-1.29.18/newrole/newrole.c policycoreutils-1.29.18.mine/newrole/newrole.c
--- policycoreutils-1.29.18/newrole/newrole.c	2006-02-02 15:08:13.000000000 -0200
+++ policycoreutils-1.29.18.mine/newrole/newrole.c	2006-02-08 14:26:19.000000000 -0200
@@ -10,7 +10,7 @@
  *
  * USAGE:
  *
- * newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]
+ * newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]
  *
  * BUILD OPTIONS:
  *
@@ -84,7 +84,7 @@
 #endif
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]"
 
 #define DEFAULT_CONTEXT_SIZE 255  /* first guess at context size */
 
@@ -417,6 +417,7 @@ int main( int argc, char *argv[] ) {
     { "role", 1, 0, 'r' },
     { "type", 1, 0, 't' },
     { "level", 1, 0, 'l' },
+    { "version", 0, 0, 'v' },
     { NULL, 0, 0, 0 }
   };
   char *role_s = NULL;               /* role spec'd by user in argv[] */
@@ -465,11 +466,15 @@ int main( int argc, char *argv[] ) {
   }
 
   while (1) {
-    clflag=getopt_long(argc,argv,"r:t:l:",long_options,&flag_index);
+    clflag=getopt_long(argc,argv,"r:t:l:v",long_options,&flag_index);
     if (clflag == -1)
 	break;
     
     switch( clflag ) {
+    case 'v':
+	printf("newrole version %s\n",VERSION);
+	exit(0);
+	break;
     case 'r':
       /* If role_s is already set, the user spec'd multiple roles - bad. */
       if( role_s ) {

--Boundary-00=_aAi6Ddy1H7Iujpc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
