Message-ID: <36282A1733C57546BE392885C06185928E28AC@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Cc: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "Daniel J Walsh (E-mail)" <dwalsh@redhat.com>
Subject: [PATCH] runcon "-c" transition option
Date: Wed, 27 Apr 2005 15:47:10 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C54B61.E6DC37F0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C54B61.E6DC37F0
Content-Type: text/plain;
	charset="iso-8859-1"


This patch makes the following changes to runcon:
-added "-c" command-line option
-improved usage message
-fixed some broken cmd-line argument processing code
-fixed building of man page

_______________________________________
Chad Hanson
Manager, Trusted Operating Systems Lab

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

www.TrustedCS.com

V: 217.384.0028  ext 12
F: 217.384.0288
E: chanson@TrustedCS.com



------_=_NextPart_000_01C54B61.E6DC37F0
Content-Type: application/octet-stream;
	name="coreutils.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="coreutils.patch"

diff -Nur coreutils/man/runcon.1 coreutils.new/man/runcon.1=0A=
--- coreutils/man/runcon.1	2005-04-22 16:41:56.000000000 -0500=0A=
+++ coreutils.new/man/runcon.1	2005-04-22 20:47:34.000000000 -0500=0A=
@@ -1,9 +1,9 @@=0A=
-.TH RUNCON "1" "July 2003" "runcon (coreutils) 5.0" "selinux"=0A=
+.TH RUNCON "1" "February 2005" "runcon (coreutils) 5.0" "selinux"=0A=
 .SH NAME=0A=
 runcon \- run command with specified security context =0A=
 .SH SYNOPSIS=0A=
 .B runcon=0A=
-[\fI-t TYPE\fR] [\fI-l LEVEL\fR] [\fI-u USER\fR] [\fI-r ROLE\fR] =
\fICOMMAND\fR [\fIARGS...\fR]=0A=
+[\fI-c\fR] [\fI-t TYPE\fR] [\fI-l LEVEL\fR] [\fI-u USER\fR] [\fI-r =
ROLE\fR] \fICOMMAND\fR [\fIARGS...\fR]=0A=
 .PP=0A=
 or=0A=
 .PP=0A=
@@ -15,8 +15,12 @@=0A=
 .PP=0A=
 .\" Add any additional description here=0A=
 .PP=0A=
-Run COMMAND with current security context modified by one or more of =
LEVEL,=0A=
-ROLE, TYPE, and USER, or with completely-specified CONTEXT.=0A=
+Run COMMAND with completely-specified CONTEXT, or with current or=0A=
+transitioned security context modified by one or more of LEVEL,=0A=
+ROLE, TYPE, and USER.=0A=
+.TP=0A=
+\fB\-c\fR=0A=
+compute process transition before modifying context=0A=
 .TP=0A=
 \fB\-t\fR=0A=
 change current type to the specified type=0A=
@@ -30,7 +34,7 @@=0A=
 \fB\-u\fR=0A=
 change current user to the specified user=0A=
 .PP=0A=
-If none of \fI-t\fR, \fI-u\fR, \fI-r\fR, or \fI-l\fR, is specified,=0A=
+If none of \fI-c\fR, \fI-t\fR, \fI-u\fR, \fI-r\fR, or \fI-l\fR, is =
specified,=0A=
 the first argument is used as the complete context.  Any additional=0A=
 arguments after \fICOMMAND\fR are interpreted as arguments to the=0A=
 command.=0A=
diff -Nur coreutils/man/runcon.x coreutils.new/man/runcon.x=0A=
--- coreutils/man/runcon.x	2005-04-22 16:41:56.000000000 -0500=0A=
+++ coreutils.new/man/runcon.x	2005-04-22 20:47:34.000000000 -0500=0A=
@@ -1,2 +1,14 @@=0A=
+[NAME]=0A=
+runcon \- run command with specified security context=0A=
 [DESCRIPTION]=0A=
-.\" Add any additional description here=0A=
+Run COMMAND with completely-specified CONTEXT, or with current or=0A=
+transitioned security context modified by one or more of LEVEL,=0A=
+ROLE, TYPE, and USER.=0A=
+.PP=0A=
+If none of \fI-c\fR, \fI-t\fR, \fI-u\fR, \fI-r\fR, or \fI-l\fR, is =
specified,=0A=
+the first argument is used as the complete context.  Any additional=0A=
+arguments after \fICOMMAND\fR are interpreted as arguments to the=0A=
+command.=0A=
+.PP=0A=
+Note that only carefully-chosen contexts are likely to successfully=0A=
+run.=0A=
diff -Nur coreutils/src/runcon.c coreutils.new/src/runcon.c=0A=
--- coreutils/src/runcon.c	2005-04-22 16:41:55.000000000 -0500=0A=
+++ coreutils.new/src/runcon.c	2005-04-22 20:47:34.000000000 -0500=0A=
@@ -1,6 +1,6 @@=0A=
 /*=0A=
  * runcon [ context |=0A=
- *         ( [ -r role ] [-t type] [ -u user ] [ -l levelrange ] )=0A=
+ *         ( [ -c ] [ -r role ] [-t type] [ -u user ] [ -l levelrange =
] )=0A=
  *         command [arg1 [arg2 ...] ]=0A=
  *=0A=
  * attempt to run the specified command with the specified context.=0A=
@@ -9,6 +9,7 @@=0A=
  * -t type  : use the current context with the specified type=0A=
  * -u user  : use the current context with the specified user=0A=
  * -l level : use the current context with the specified level =
range=0A=
+ * -c       : compute process transition context before modifying=0A=
  *=0A=
  * Contexts are interpreted as follows:=0A=
  *=0A=
@@ -29,6 +30,7 @@=0A=
 #include <getopt.h>=0A=
 #include <selinux/context.h>=0A=
 #include <selinux/selinux.h>=0A=
+#include <selinux/flask.h>=0A=
 #include <errno.h>=0A=
 #include "system.h"=0A=
 extern int errno;=0A=
@@ -36,19 +38,28 @@=0A=
 /* The name the program was run with. */=0A=
 char *program_name;=0A=
 =0A=
+/* If nonzero, display usage information and exit.  */=0A=
+static int show_help;=0A=
+=0A=
+/* If nonzero, print the version on standard output and exit.  */=0A=
+static int show_version;=0A=
+=0A=
 void=0A=
-usage(char *str)=0A=
+usage(int status)=0A=
 {=0A=
-  printf(_("Usage: %s [OPTION]... command [args]\n"=0A=
+  printf(_("Usage: %s CONTEXT COMMAND [args]\n"=0A=
+         "  or:  %s [ -c ] [-u USER] [-r ROLE] [-t TYPE] [-l RANGE] =
COMMAND [args]\n"=0A=
          "Run a program in a different security context.\n\n"=0A=
-         "  context       Complete security context\n"=0A=
-         "  -t            type (for same role as parent)\n"=0A=
-         "  -u            user identity\n"=0A=
-         "  -r            role\n"=0A=
-         "  -l            levelrange\n"=0A=
-         "    --help      display this help and exit\n"),=0A=
-         program_name);=0A=
-  exit(1);=0A=
+         "  CONTEXT            Complete security context\n"=0A=
+         "  -c, --compute      compute process transition context =
before modifying\n"=0A=
+         "  -t, --type=3DTYPE    type (for same role as parent)\n"=0A=
+         "  -u, --user=3DUSER    user identity\n"=0A=
+         "  -r, --role=3DROLE    role\n"=0A=
+         "  -l, --range=3DRANGE  levelrange\n"=0A=
+         "      --help         display this help and exit\n"=0A=
+         "      --version      output version information and =
exit\n"),=0A=
+         program_name, program_name);=0A=
+  exit(status);=0A=
 }=0A=
 =0A=
 int =0A=
@@ -60,6 +71,9 @@=0A=
   char *type    =3D 0;=0A=
   char *context =3D NULL;=0A=
   security_context_t cur_context =3D NULL;=0A=
+  security_context_t file_context =3D NULL;=0A=
+  security_context_t new_context =3D NULL;=0A=
+  int compute_trans =3D 0;=0A=
 =0A=
   context_t      con;=0A=
 =0A=
@@ -77,14 +91,18 @@=0A=
       { "type", 1, 0, 't' },=0A=
       { "user", 1, 0, 'u' },=0A=
       { "range", 1, 0, 'l' },=0A=
-      { "help", 0, 0, '?' },=0A=
+      { "compute", 0, 0, 'c' },=0A=
+      { "help", 0, &show_help, 1 },=0A=
+      { "version", 0, &show_version, 1 },=0A=
       { 0, 0, 0, 0 }=0A=
     };=0A=
-    c =3D getopt_long(argc, argv, "s:r:t:u:l:?", long_options, =
&option_index);=0A=
+    c =3D getopt_long(argc, argv, "r:t:u:l:c", long_options, =
&option_index);=0A=
     if ( c =3D=3D -1 ) {=0A=
       break;=0A=
     }=0A=
     switch ( c ) {=0A=
+    case 0:=0A=
+      break;=0A=
     case 'r':=0A=
       if ( role ) {=0A=
 	fprintf(stderr,_("multiple roles\n"));=0A=
@@ -113,10 +131,11 @@=0A=
       }=0A=
       range =3D optarg;=0A=
       break;=0A=
+    case 'c':=0A=
+      compute_trans =3D 1;=0A=
+      break;=0A=
     default:=0A=
-      fprintf(stderr,_("unrecognised option %c\n"),c);=0A=
-    case '?':=0A=
-      usage(0);=0A=
+      usage(1);=0A=
       break;=0A=
     }=0A=
   }=0A=
@@ -127,15 +146,25 @@=0A=
     exit(-1);=0A=
   }=0A=
   =0A=
-  if ( !(user || role || type || range)) {=0A=
+  if (show_version) {=0A=
+    printf("runcon (%s) %s\n", GNU_PACKAGE, VERSION);=0A=
+    exit(0);=0A=
+  }=0A=
+=0A=
+  if (show_help)=0A=
+    usage(0);=0A=
+=0A=
+  if ( !(user || role || type || range || compute_trans)) {=0A=
     if ( optind >=3D argc ) {=0A=
-      usage(_("must specify -t, -u, -l, -r, or context"));=0A=
+      fprintf(stderr,_("must specify -c, -t, -u, -l, -r, or =
context\n"));=0A=
+      usage(1);=0A=
     }=0A=
     context =3D argv[optind++];=0A=
   }=0A=
   =0A=
   if ( optind >=3D argc ) {=0A=
-    usage(_("no command found"));=0A=
+    fprintf(stderr,_("no command found\n"));=0A=
+    usage(1);=0A=
   }=0A=
 =0A=
   if ( context ) {=0A=
@@ -150,6 +179,29 @@=0A=
       fprintf(stderr,_("Couldn't get current context.\n"));=0A=
       exit(1);=0A=
     }=0A=
+=0A=
+    /* We will generate context based on process transition */=0A=
+    if ( compute_trans ) {=0A=
+      /* Get context of file to be executed */=0A=
+      if (getfilecon(argv[optind], &file_context) =3D=3D -1) {=0A=
+        fprintf(stderr,_("unable to retrieve attributes of %s\n"),=0A=
+                argv[optind]);=0A=
+        exit(1);=0A=
+      }=0A=
+      /* compute result of process transition */=0A=
+      if (security_compute_create(cur_context, file_context,=0A=
+                                  SECCLASS_PROCESS, &new_context) !=3D =
0) {=0A=
+        fprintf(stderr,_("unable to compute a new context\n"));=0A=
+        exit(1);=0A=
+      }=0A=
+      /* free contexts */=0A=
+      freecon(file_context);=0A=
+      freecon(cur_context);=0A=
+=0A=
+      /* set cur_context equal to new_context */=0A=
+      cur_context =3D new_context;=0A=
+    }=0A=
+=0A=
     con =3D context_new(cur_context);=0A=
     if (!con) {=0A=
       fprintf(stderr,_("%s is not a valid context\n"), =
cur_context);=0A=

------_=_NextPart_000_01C54B61.E6DC37F0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
