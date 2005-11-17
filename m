Message-ID: <437CADB3.4060404@redhat.com>
Date: Thu, 17 Nov 2005 11:20:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Please tell semodule to shut up????
References: <437A7AD5.6040500@cornell.edu> <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil> <437CAA27.30302@redhat.com>
In-Reply-To: <437CAA27.30302@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080303020807040502020306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080303020807040502020306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wrong patch

-- 



--------------080303020807040502020306
Content-Type: text/x-patch;
 name="policycoreutils-verbose.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-verbose.patch"

--- policycoreutils-1.27.28/semodule/semodule.c~	2005-11-16 15:39:03.000000000 -0500
+++ policycoreutils-1.27.28/semodule/semodule.c	2005-11-17 11:02:35.000000000 -0500
@@ -38,7 +38,7 @@
 static int num_commands = 0;
 
 /* options given on command line */
-static int quiet;
+static int verbose;
 static int reload;
 static int no_reload;
 static int build;
@@ -122,7 +122,7 @@
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -n,--noreload	   do not reload policy after commit\n");
         printf("  -h,--help        print this message and quit\n");
-        printf("  -q,--quiet       be quiet\n");
+        printf("  -v,--verbose     be verbose\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -157,7 +157,7 @@
                 {"help", 0, NULL, 'h'},
                 {"install", required_argument, NULL, 'i'},
                 {"list-modules", 0, NULL, 'l'},
-                {"quiet", 0, NULL, 'q'},
+                {"verbose", 0, NULL, 'v'},
                 {"remove", required_argument, NULL, 'r'},
                 {"upgrade", required_argument, NULL, 'u'},
 		{"reload", 0, NULL, 'R'},
@@ -166,7 +166,7 @@
                 {NULL, 0, NULL, 0}
         };
         int i;
-        quiet = 0;
+        verbose = 0;
 	reload = 0;
 	no_reload = 0;
         while ((i = getopt_long(argc, argv, "s:b:hi:lqr:u:RnB", opts, NULL)) != -1) {
@@ -175,7 +175,7 @@
                 case 'h': usage(argv[0]); exit(0);
                 case 'i': set_mode(INSTALL_M, optarg); break;
                 case 'l': set_mode(LIST_M, NULL); break;
-                case 'q': quiet = 1; break;
+                case 'v': verbose = 1; break;
                 case 'r': set_mode(REMOVE_M, optarg); break;
                 case 'u': set_mode(UPGRADE_M,optarg); break;
 		case 's': set_store(optarg); break;
@@ -266,28 +266,28 @@
                 }
                 switch (mode) {
                 case INSTALL_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to install module '%s':\n", mode_arg);
                         }
                         result = semanage_module_install(sh, data, data_len);
                         break;
                 }
                 case UPGRADE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to upgrade module '%s':\n", mode_arg);
                         }
                         result = semanage_module_upgrade(sh, data, data_len);
                         break;
                 }
                 case BASE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to install base module '%s':\n", mode_arg);
                         }
                         result = semanage_module_install_base(sh, data, data_len);
                         break;
                 }
                 case REMOVE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to remove module '%s':\n", mode_arg);
                         }
                         result = semanage_module_remove(sh, mode_arg);
@@ -296,7 +296,7 @@
                 case LIST_M: {
                         semanage_module_info_t *modinfo;
                         int num_modules;
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to list active modules:\n");
                         }
                         if ((result = semanage_module_list(sh, &modinfo, &num_modules)) >= 0) {
@@ -328,13 +328,13 @@
                         fprintf(stderr, "Failed!\n");
                         goto cleanup;
                 }
-                else if (!quiet) {
+                else if (verbose) {
                         printf("Ok: return value of %d.\n", result);
                 }
         }
         
         if (commit) {
-                if (!quiet) {
+                if (verbose) {
                         printf("Committing changes:\n");
                 }
 		if (no_reload) {
@@ -347,7 +347,7 @@
                 fprintf(stderr, "Failed!\n");
                 goto cleanup;
         }
-        else if (commit && !quiet) {
+        else if (commit && verbose) {
                 printf("Ok: transaction number %d.\n", result);
         }
 

--------------080303020807040502020306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
