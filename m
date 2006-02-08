From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Selinux@tycho.nsa.gov
Subject: [PATCH] add version option to newrole
Date: Wed, 8 Feb 2006 09:34:33 -0200
MIME-Version: 1.0
Message-Id: <200602080934.33613.glommer@br.ibm.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jdd6DXiwCWFclRH"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Jdd6DXiwCWFclRH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When trying to isolate a problem today, I missed a lot an version option (-v 
or such). This simple patch adds such an option.

If it's of interest, such an option may be added to whole policycoreutils 
package. (IMHO, it would be useful). With this possibility in mind, I decided 
to  implement the version string in a separate version.h file, that could be 
included by other packages too. 

Patch follows.




--Boundary-00=_Jdd6DXiwCWFclRH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-newrole"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-newrole"

diff -upNr policycoreutils-1.29.18/newrole/newrole.c policycoreutils-1.29.18.mine/newrole/newrole.c
--- policycoreutils-1.29.18/newrole/newrole.c	2006-02-02 15:08:13.000000000 -0200
+++ policycoreutils-1.29.18.mine/newrole/newrole.c	2006-02-07 16:16:23.000000000 -0200
@@ -10,7 +10,7 @@
  *
  * USAGE:
  *
- * newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]
+ * newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]
  *
  * BUILD OPTIONS:
  *
@@ -82,9 +82,10 @@
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"   /* the name of this package lang translation */
 #endif
+#include "version.h"
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]"
 
 #define DEFAULT_CONTEXT_SIZE 255  /* first guess at context size */
 
@@ -417,6 +418,7 @@ int main( int argc, char *argv[] ) {
     { "role", 1, 0, 'r' },
     { "type", 1, 0, 't' },
     { "level", 1, 0, 'l' },
+    { "version", 0, 0, 'v' },
     { NULL, 0, 0, 0 }
   };
   char *role_s = NULL;               /* role spec'd by user in argv[] */
@@ -465,11 +467,15 @@ int main( int argc, char *argv[] ) {
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
diff -upNr policycoreutils-1.29.18/newrole/version.h policycoreutils-1.29.18.mine/newrole/version.h
--- policycoreutils-1.29.18/newrole/version.h	1969-12-31 21:00:00.000000000 -0300
+++ policycoreutils-1.29.18.mine/newrole/version.h	2006-02-07 16:15:47.000000000 -0200
@@ -0,0 +1,4 @@
+
+#ifndef VERSION
+#define VERSION "1.29.18"
+#endif

--Boundary-00=_Jdd6DXiwCWFclRH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
