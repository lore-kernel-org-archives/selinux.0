Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9J4gPWt015343
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 00:42:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9J4gPmR005126
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:42:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9J4gNjp005123 for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:42:24 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7660E924F3
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:42:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 20F077F03A
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:42:15 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: runcon/chcon patch
Date: Sun, 19 Oct 2003 14:42:14 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mYhk/XuLxGIPjvO"
Message-Id: <200310191442.14560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_mYhk/XuLxGIPjvO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch has the changes needed to chcon.c and runcon.c to compile 
with the latest coreutils (5.0.91).

The latest coreutils does many more tests on utility programs and is much more 
fussy about return codes.  So programs that return the wrong values in some 
situations or which make the wrong choices about whether to write to stdout 
or stderr will break the build.

Also changing the value of optind seems to not work for me.  So I use a 
separate variable prog_ind to contain the index of the program to be run.  It 
also makes the code slightly clearer.

Even if compiling against an older coreutils 99% of this patch can still be 
usefully applied.  Giving the right return codes is good even if no-one is 
checking.  Not abusing optind is good even if you can get it to work either 
way.  The only change that can't be applied with old versions of coreutils is 
the first change to chcon.c.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_mYhk/XuLxGIPjvO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="core.diff"

--- /tmp/chcon.c	2003-10-19 14:35:06.000000000 +1000
+++ chcon.c	2003-10-18 23:58:08.000000000 +1000
@@ -32,7 +32,7 @@
   V_off
 };
 
-static int change_dir_context PARAMS ((const char *dir, const struct stat *statp));
+static int change_dir_context (const char *dir, const struct stat *statp);
 
 /* The name the program was run with. */
 char *program_name;
@@ -50,8 +50,8 @@
 /* Level of verbosity.  */
 static enum Verbosity verbosity = V_off;
 
-/* The name of the context file is being given. */
-static const char *specified_context;
+/* The context the file is being given. */
+static security_context_t specified_context;
 
 /* Specific components of the context */
 static const char *specified_user;
@@ -326,6 +326,9 @@
 
   recurse = force_silent = 0;
   
+  if(argc == 1)
+    usage(0);
+
   while ((optc = getopt_long (argc, argv, "Rcfhvu:r:t:l:", long_options, NULL)) != -1)
   {
 	  switch (optc)
--- /tmp/runcon.c	2003-10-19 14:35:06.000000000 +1000
+++ runcon.c	2003-10-19 14:23:34.000000000 +1000
@@ -31,15 +31,22 @@
 #include <selinux/selinux.h>
 #include <errno.h>
 #include "system.h"
-extern int errno;
+#include "error.h"
 
 /* The name the program was run with. */
 char *program_name;
 
 void
-usage(char *str)
+usage(int status)
 {
-  printf(_("Usage: %s [OPTION]... command [args]\n"
+  if (status != 0)
+  {
+    fprintf (stderr, _("Try `%s --help' for more information.\n"),
+            program_name);
+  }
+  else
+  {
+    printf(_("Usage: %s [OPTION]... command [args]\n"
          "Run a program in a different security context.\n\n"
          "  context       Complete security context\n"
          "  -t            type (for same role as parent)\n"
@@ -48,9 +55,17 @@
          "  -l            levelrange\n"
          "    --help      display this help and exit\n"),
          program_name);
-  exit(1);
+    close_stdout ();
+  }
+  exit(status);
 }
 
+/* If nonzero, display usage information and exit.  */
+static int show_help;
+
+/* If nonzero, print the version on standard output and exit.  */
+static int show_version;
+
 int 
 main(int argc,char **argv,char **envp )
 {
@@ -60,6 +75,7 @@
   char *type    = 0;
   char *context = NULL;
   security_context_t cur_context = NULL;
+  int prog_ind;
 
   context_t      con;
 
@@ -68,16 +84,19 @@
   bindtextdomain (PACKAGE, LOCALEDIR);
   textdomain (PACKAGE);
   
+  if(argc == 1)
+    usage(0);
+
   while (1) {
     int c;
-    int this_option_optind = optind ? optind : 1;
     int option_index = 0;
     static struct option long_options[] = {
-      { "role", 1, 0, 'r' },
-      { "type", 1, 0, 't' },
-      { "user", 1, 0, 'u' },
-      { "range", 1, 0, 'l' },
-      { "help", 0, 0, '?' },
+      { "role", required_argument, 0, 'r' },
+      { "type", required_argument, 0, 't' },
+      { "user", required_argument, 0, 'u' },
+      { "range", required_argument, 0, 'l' },
+      { "help", no_argument, &show_help, 1 },
+      { "version", no_argument, &show_version, 1 },
       { 0, 0, 0, 0 }
     };
     c = getopt_long(argc, argv, "s:r:t:u:l:?", long_options, &option_index);
@@ -85,6 +104,8 @@
       break;
     }
     switch ( c ) {
+    case 0:
+      break;
     case 'r':
       if ( role ) {
 	fprintf(stderr,_("multiple roles\n"));
@@ -120,15 +141,31 @@
       break;
     }
   }
+
+  if (show_version)
+  {
+     printf ("runcon (%s) %s\n", GNU_PACKAGE, VERSION);
+     close_stdout ();
+     exit (0);
+  }
+ 
+  if (show_help)
+    usage (0);
+
   if ( !(user || role || type || range)) {
     if ( optind >= argc ) {
-      usage(_("must specify -t, -u, -l, -r, or context"));
+      error(0, 0, _("must specify -t, -u, -l, -r, or context"));
+      usage(1);
     }
-    context = argv[optind++];
+    context = argv[optind];
+    prog_ind = optind + 1;
   }
+  else
+    prog_ind = optind;
   
   if ( optind >= argc ) {
-    usage(_("no command found"));
+    error(0, 0, _("no command found"));
+    usage(1);
   }
 
   if ( context ) {
@@ -166,7 +203,7 @@
   if (cur_context!=NULL) 
     freecon(cur_context);
 
-  if ( execvp(argv[optind],argv+optind) ) {
+  if ( execvp(argv[prog_ind], argv + prog_ind) ) {
     perror("execvp");
     exit(1);
   }

--Boundary-00=_mYhk/XuLxGIPjvO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
