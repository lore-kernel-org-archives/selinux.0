From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
   Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] Add version option to policycoreutils
Date: Fri, 10 Feb 2006 14:45:22 -0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jMM7DkJ/bAxtFaa"
Message-Id: <200602101445.23334.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_jMM7DkJ/bAxtFaa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Along with it's manpages changes, this patch coalesces all the changes 
suggested by people in the list. More programs in the policycoreutils suite 
may follow soon

--Boundary-00=_jMM7DkJ/bAxtFaa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-newrole.v3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-newrole.v3"

diff -uprN policycoreutils-1.29.18/newrole/Makefile policycoreutils-1.29.18.mine/newrole/Makefile
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
diff -uprN policycoreutils-1.29.18/newrole/newrole.1 policycoreutils-1.29.18.mine/newrole/newrole.1
--- policycoreutils-1.29.18/newrole/newrole.1	2006-02-02 15:08:13.000000000 -0200
+++ policycoreutils-1.29.18.mine/newrole/newrole.1	2006-02-10 14:35:50.000000000 -0200
@@ -50,6 +50,13 @@ treated as a command by most command int
 The new shell will be the shell specified in the user's entry in the 
 .I /etc/passwd
 file.
+.PP
+The
+.B -V
+or 
+.B --version
+shows the current version of newrole
+.PP
 .SH FILES
 /etc/passwd - user account information
 .br
diff -uprN policycoreutils-1.29.18/newrole/newrole.c policycoreutils-1.29.18.mine/newrole/newrole.c
--- policycoreutils-1.29.18/newrole/newrole.c	2006-02-02 15:08:13.000000000 -0200
+++ policycoreutils-1.29.18.mine/newrole/newrole.c	2006-02-10 14:29:18.000000000 -0200
@@ -10,7 +10,7 @@
  *
  * USAGE:
  *
- * newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]
+ * newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]
  *
  * BUILD OPTIONS:
  *
@@ -84,7 +84,7 @@
 #endif
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
 
 #define DEFAULT_CONTEXT_SIZE 255  /* first guess at context size */
 
@@ -417,6 +417,7 @@ int main( int argc, char *argv[] ) {
     { "role", 1, 0, 'r' },
     { "type", 1, 0, 't' },
     { "level", 1, 0, 'l' },
+    { "version", 0, 0, 'V' },
     { NULL, 0, 0, 0 }
   };
   char *role_s = NULL;               /* role spec'd by user in argv[] */
@@ -465,11 +466,15 @@ int main( int argc, char *argv[] ) {
   }
 
   while (1) {
-    clflag=getopt_long(argc,argv,"r:t:l:",long_options,&flag_index);
+    clflag=getopt_long(argc,argv,"r:t:l:V",long_options,&flag_index);
     if (clflag == -1)
 	break;
     
     switch( clflag ) {
+    case 'V':
+	printf("newrole: %s version %s\n",PACKAGE,VERSION);
+	exit(0);
+	break;
     case 'r':
       /* If role_s is already set, the user spec'd multiple roles - bad. */
       if( role_s ) {

--Boundary-00=_jMM7DkJ/bAxtFaa--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
