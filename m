Message-Id: <20070726144817.301972098@manicmethod.com>
References: <20070726144535.573371598@manicmethod.com>
Date: Thu, 26 Jul 2007 10:45:38 -0400
From: method@manicmethod.com
To: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: [POLICYREP] [PATCHv2 3/3] semodule_package implementation in cpp for libpolicyrep
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 policycoreutils/semodule_package/semodule_package.c   |  257 ------------------
 policycoreutils/semodule_package/semodule_package.cpp |   60 ++--
 2 files changed, 35 insertions(+), 282 deletions(-)

--- policyrep-policy_package.orig/policycoreutils/semodule_package/semodule_package.c
+++ /dev/null
@@ -1,257 +0,0 @@
-/* Authors: Karl MacMillan <kmacmillan@tresys.com>
- *
- * Copyright (C) 2004 Tresys Technology, LLC
- *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation, version 2.
- */
-
-#include <sepol/module.h>
-#include <getopt.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include <errno.h>
-
-char *progname = NULL;
-extern char *optarg;
-
-static void usage(char *prog)
-{
-	printf("usage: %s -o <output file> -m <module> [-f <file contexts>]\n",
-	       prog);
-	printf("Options:\n");
-	printf("  -o --outfile		Output file (required)\n");
-	printf("  -m --module		Module file (required)\n");
-	printf("  -f --fc		File contexts file\n");
-	printf("  -s --seuser		Seusers file (only valid in base)\n");
-	printf
-	    ("  -u --user_extra	user_extra file (only valid in base)\n");
-	printf("  -n --nc		Netfilter contexts file\n");
-	exit(1);
-}
-
-static int file_to_policy_file(char *filename, struct sepol_policy_file **pf,
-			       char *mode)
-{
-	FILE *f;
-
-	if (sepol_policy_file_create(pf)) {
-		fprintf(stderr, "%s:  Out of memory\n", progname);
-		return -1;
-	}
-
-	f = fopen(filename, mode);
-	if (!f) {
-		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname,
-			strerror(errno), filename);
-		return -1;
-	}
-	sepol_policy_file_set_fp(*pf, f);
-	return 0;
-}
-
-static int file_to_data(const char *path, char **data, size_t * len)
-{
-	int fd;
-	struct stat sb;
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "%s:  Failed to open %s:  %s\n", progname, path,
-			strerror(errno));
-		return -1;
-	}
-	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr, "%s:  Failed to fstat %s:  %s\n", progname,
-			path, strerror(errno));
-		goto err;
-	}
-
-	*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (*data == MAP_FAILED) {
-		fprintf(stderr, "%s:  Failed to mmap %s:  %s\n", progname, path,
-			strerror(errno));
-		goto err;
-	}
-	*len = sb.st_size;
-	close(fd);
-	return 0;
-      err:
-	close(fd);
-	return -1;
-}
-
-int main(int argc, char **argv)
-{
-	struct sepol_module_package *pkg;
-	struct sepol_policy_file *mod, *out;
-	char *module = NULL, *file_contexts = NULL, *seusers =
-	    NULL, *user_extra = NULL;
-	char *fcdata = NULL, *outfile = NULL, *seusersdata =
-	    NULL, *user_extradata = NULL;
-	char *netfilter_contexts = NULL, *ncdata = NULL;
-	size_t fclen = 0, seuserslen = 0, user_extralen = 0, nclen = 0;
-	int i;
-
-	static struct option opts[] = {
-		{"module", required_argument, NULL, 'm'},
-		{"fc", required_argument, NULL, 'f'},
-		{"seuser", required_argument, NULL, 's'},
-		{"user_extra", required_argument, NULL, 'u'},
-		{"nc", required_argument, NULL, 'n'},
-		{"outfile", required_argument, NULL, 'o'},
-		{"help", 0, NULL, 'h'},
-		{NULL, 0, NULL, 0}
-	};
-
-	while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:h", opts, NULL)) != -1) {
-		switch (i) {
-		case 'h':
-			usage(argv[0]);
-			exit(0);
-		case 'm':
-			if (module) {
-				fprintf(stderr,
-					"May not specify more than one module\n");
-				exit(1);
-			}
-			module = strdup(optarg);
-			if (!module)
-				exit(1);
-			break;
-		case 'f':
-			if (file_contexts) {
-				fprintf(stderr,
-					"May not specify more than one file context file\n");
-				exit(1);
-			}
-			file_contexts = strdup(optarg);
-			if (!file_contexts)
-				exit(1);
-			break;
-		case 'o':
-			if (outfile) {
-				fprintf(stderr,
-					"May not specify more than one output file\n");
-				exit(1);
-			}
-			outfile = strdup(optarg);
-			if (!outfile)
-				exit(1);
-			break;
-		case 's':
-			if (seusers) {
-				fprintf(stderr,
-					"May not specify more than one seuser file\n");
-				exit(1);
-			}
-			seusers = strdup(optarg);
-			if (!seusers)
-				exit(1);
-			break;
-		case 'u':
-			if (user_extra) {
-				fprintf(stderr,
-					"May not specify more than one user_extra file\n");
-				exit(1);
-			}
-			user_extra = strdup(optarg);
-			if (!user_extra)
-				exit(1);
-			break;
-		case 'n':
-			if (netfilter_contexts) {
-				fprintf(stderr,
-					"May not specify more than one netfilter contexts file\n");
-				exit(1);
-			}
-			netfilter_contexts = strdup(optarg);
-			if (!netfilter_contexts)
-				exit(1);
-			break;
-		}
-	}
-
-	progname = argv[0];
-
-	if (!module || !outfile) {
-		usage(argv[0]);
-		exit(0);
-	}
-
-	if (file_contexts) {
-		if (file_to_data(file_contexts, &fcdata, &fclen))
-			exit(1);
-	}
-
-	if (seusers) {
-		if (file_to_data(seusers, &seusersdata, &seuserslen))
-			exit(1);
-	}
-
-	if (user_extra) {
-		if (file_to_data(user_extra, &user_extradata, &user_extralen))
-			exit(1);
-	}
-
-	if (netfilter_contexts) {
-		if (file_to_data(netfilter_contexts, &ncdata, &nclen))
-			exit(1);
-	}
-
-	if (file_to_policy_file(module, &mod, "r"))
-		exit(1);
-
-	if (sepol_module_package_create(&pkg)) {
-		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
-	}
-
-	if (sepol_policydb_read(sepol_module_package_get_policy(pkg), mod)) {
-		fprintf(stderr,
-			"%s:  Error while reading policy module from %s\n",
-			argv[0], module);
-		exit(1);
-	}
-
-	if (fclen)
-		sepol_module_package_set_file_contexts(pkg, fcdata, fclen);
-
-	if (seuserslen)
-		sepol_module_package_set_seusers(pkg, seusersdata, seuserslen);
-
-	if (user_extra)
-		sepol_module_package_set_user_extra(pkg, user_extradata,
-						    user_extralen);
-
-	if (nclen)
-		sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen);
-
-	if (file_to_policy_file(outfile, &out, "w"))
-		exit(1);
-
-	if (sepol_module_package_write(pkg, out)) {
-		fprintf(stderr,
-			"%s:  Error while writing module package to %s\n",
-			argv[0], argv[1]);
-		exit(1);
-	}
-
-	if (fclen)
-		munmap(fcdata, fclen);
-	if (nclen)
-		munmap(ncdata, nclen);
-	sepol_policy_file_free(mod);
-	sepol_policy_file_free(out);
-	sepol_module_package_free(pkg);
-	free(file_contexts);
-	free(outfile);
-	free(module);
-	exit(0);
-}
--- policyrep-policy_package.orig/policycoreutils/semodule_package/semodule_package.cpp
+++ policyrep-policy_package/policycoreutils/semodule_package/semodule_package.cpp
@@ -10,11 +10,9 @@
 extern "C" {
 #include <getopt.h>
 }
-
 #include <policyrep/policy_package.hpp>
 #include <iostream>
 #include <sstream>
-
 char *progname = NULL;
 extern char *optarg;
 
@@ -22,7 +20,8 @@ using namespace std;
 
 static void usage(char *prog)
 {
-	cout << "usage: " << prog << " -o <output file> -m <module> [-f <file contexts>]" << endl;
+	cout << "usage: " << prog <<
+	    " -o <output file> -m <module> [-f <file contexts>]" << endl;
 	cout << "Options:" << endl;
 	cout << "  -o --outfile		Output file (required)" << endl;
 	cout << "  -m --module		Module file" << endl;
@@ -33,14 +32,12 @@ static void usage(char *prog)
 	exit(1);
 }
 
-
 int main(int argc, char **argv)
 {
 	policyrep::PolicyPackageArchive package;
-	char *module = NULL, *file_contexts = NULL, 
-             *seusers = NULL, *user_extra = NULL,
-	     *netfilter_contexts = NULL, *outfile = NULL,
-	     *unpack = NULL;
+	char *module = NULL, *file_contexts = NULL,
+	    *seusers = NULL, *user_extra = NULL,
+	    *netfilter_contexts = NULL, *outfile = NULL, *unpack = NULL;
 	int i;
 
 	static struct option opts[] = {
@@ -61,7 +58,8 @@ int main(int argc, char **argv)
 			exit(0);
 		case 'm':
 			if (module) {
-				cout << "May not specify more than one module" << endl;
+				cout << "May not specify more than one module"
+				    << endl;
 				exit(1);
 			}
 			module = strdup(optarg);
@@ -70,7 +68,9 @@ int main(int argc, char **argv)
 			break;
 		case 'f':
 			if (file_contexts) {
-				cout << "May not specify more than one file context file" << endl;
+				cout <<
+				    "May not specify more than one file context file"
+				    << endl;
 				exit(1);
 			}
 			file_contexts = strdup(optarg);
@@ -79,7 +79,9 @@ int main(int argc, char **argv)
 			break;
 		case 'o':
 			if (outfile) {
-				cout << "May not specify more than one output file" << endl;
+				cout <<
+				    "May not specify more than one output file"
+				    << endl;
 				exit(1);
 			}
 			outfile = strdup(optarg);
@@ -88,7 +90,9 @@ int main(int argc, char **argv)
 			break;
 		case 's':
 			if (seusers) {
-				cout << "May not specify more than one seuser file" << endl;
+				cout <<
+				    "May not specify more than one seuser file"
+				    << endl;
 				exit(1);
 			}
 			seusers = strdup(optarg);
@@ -97,7 +101,9 @@ int main(int argc, char **argv)
 			break;
 		case 'u':
 			if (user_extra) {
-				cout << "May not specify more than one user_extra file" << endl;
+				cout <<
+				    "May not specify more than one user_extra file"
+				    << endl;
 				exit(1);
 			}
 			user_extra = strdup(optarg);
@@ -106,17 +112,19 @@ int main(int argc, char **argv)
 			break;
 		case 'n':
 			if (netfilter_contexts) {
-				cout << "May not specify more than one netfilter contexts file" << endl;
+				cout <<
+				    "May not specify more than one netfilter contexts file"
+				    << endl;
 				exit(1);
 			}
 			netfilter_contexts = strdup(optarg);
 			if (!netfilter_contexts)
 				exit(1);
 			break;
-		}
 		case '?':
-			usage();
+			usage(argv[0]);
 			exit(1);
+		}
 	}
 
 	progname = argv[0];
@@ -128,25 +136,27 @@ int main(int argc, char **argv)
 
 	if (module)
 		package.set_mod_file(module);
-	
-	if (file_contexts) 
+
+	if (file_contexts)
 		package.set_fc_file(file_contexts);
 
-	if (seusers) 
+	if (seusers)
 		package.set_seusers_file(seusers);
 
-	if (user_extra) 
+	if (user_extra)
 		package.set_user_extra_file(user_extra);
 
-	if (netfilter_contexts) 
+	if (netfilter_contexts)
 		package.set_nc_file(netfilter_contexts);
 
 	try {
 		package.create_archive(outfile);
-	} catch (exception *e) {
-		cerr << "Exception thrown" << e.what() << endl;
-	} catch (const bad_alloc& x) {
-		cerr << "Out of memory" << x.what() << endl;
+	}
+	catch(const bad_alloc & x) {
+		cerr << "Out of memory " << x.what() << endl;
+	} catch(exception & e) {
+		cerr << "Exception thrown: " << e.what() << endl;
+	}
 
 	free(module);
 	free(file_contexts);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
