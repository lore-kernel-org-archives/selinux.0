Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FJc1gA014044
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:38:01 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FJXdBp002343
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 19:33:39 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6FJYPbX021236
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:34:25 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6FJYKV18663
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:34:20 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6FJYJg1014591
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:34:19 -0400
Subject: More patches
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-+CsocuO5eE/7j/mXFZFf"
Date: Fri, 15 Jul 2005 15:31:10 -0400
Message-Id: <1121455871.10134.21.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+CsocuO5eE/7j/mXFZFf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch removes the utilities
genpolusers and genpolbools from libsepol:

libsepol-0-remove_genutils.diff

They are of limited value, and mostly superseded by load_policy.
In the future they will be superseded by a new utility called
gen policy.


The following patch makes restorecon use standard output 
for displaying status information, which will make it
easier to handle failure in our startup script.

policycoreutils-restorecon-stdout.diff


--=-+CsocuO5eE/7j/mXFZFf
Content-Disposition: attachment; filename=libsepol-0-remove_genutils.diff
Content-Type: text/x-patch; name=libsepol-0-remove_genutils.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/utils/genpolbools.c libsepol-0-remove_genutils/utils/genpolbools.c
--- libsepol.work/utils/genpolbools.c	2005-07-07 06:50:51.000000000 -0400
+++ libsepol-0-remove_genutils/utils/genpolbools.c	2005-07-12 19:50:14.000000000 -0400
@@ -1,76 +0,0 @@
-/*
- * genpolbools old-policy booleans new-policy
- *
- * Given an existing binary policy and a boolean configuration, generate a 
- * new binary policy with the specified initial boolean values and rules
- * enabled based on a re-evaluation of the new boolean values.
- */ 
-
-#include <sepol/policydb.h>
-#include <sepol/services.h>
-#include <sepol/conditional.h>
-#include <sepol/sepol.h>
-#include <getopt.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <sys/mman.h>
-
-void usage(char *progname)
-{
-	printf("usage:  %s old-policy booleans new-policy\n", progname);
-	exit(1);
-}
-
-int main(int argc, char **argv)
-{
-	struct stat sb;
-	FILE *outfp;
-	int fd, rc;
-	void *map;
-
-	if (argc != 4) 
-		usage(argv[0]);
-
-	fd = open(argv[1], O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "Can't open '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr, "Can't stat '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-	map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		fprintf(stderr, "Can't map '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-
-	if (sepol_genbools(map, sb.st_size, argv[2]) < 0) {
-		fprintf(stderr, "Error while processing %s:  %s\n",
-			argv[2], strerror(errno));
-		exit(1);
-	}
-
-	outfp = fopen(argv[3], "w");
-	if (!outfp) {
-		perror(argv[3]);
-		exit(1);
-	}
-	rc = fwrite(map, sb.st_size, 1, outfp);
-	if (rc != 1) {
-		fprintf(stderr, "%s:  error writing %s\n",
-			argv[0], argv[3]);
-		exit(1);
-	}
-	fclose(outfp);
-	exit(0);
-}
diff -aru libsepol.work/utils/genpolusers.c libsepol-0-remove_genutils/utils/genpolusers.c
--- libsepol.work/utils/genpolusers.c	2005-07-07 06:50:51.000000000 -0400
+++ libsepol-0-remove_genutils/utils/genpolusers.c	2005-07-12 19:50:11.000000000 -0400
@@ -1,78 +0,0 @@
-/*
- * genpolusers in-policy usersdir out-policy
- *
- * Given an existing binary policy, generate a new binary policy with 
- * an updated user configuration based on any system.users and local.users
- * files in the specified usersdir.
- */ 
-
-#include <sepol/policydb.h>
-#include <sepol/services.h>
-#include <sepol/conditional.h>
-#include <sepol/sepol.h>
-#include <getopt.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <sys/mman.h>
-
-void usage(char *progname)
-{
-	printf("usage:  %s inpolicy usersdir outpolicy\n", progname);
-	exit(1);
-}
-
-int main(int argc, char **argv)
-{
-	struct stat sb;
-	FILE *outfp;
-	int fd, rc;
-	void *map;
-	void *data;
-	unsigned len;
-
-	if (argc != 4) 
-		usage(argv[0]);
-
-	fd = open(argv[1], O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "Can't open '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr, "Can't stat '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-	map = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		fprintf(stderr, "Can't map '%s':  %s\n",
-			argv[1], strerror(errno));
-		exit(1);
-	}
-
-	if (sepol_genusers(map, sb.st_size, argv[2], &data, &len) < 0) {
-		fprintf(stderr, "Error while processing users from %s:  %s\n",
-			argv[2], strerror(errno));
-		exit(1);
-	}
-
-	outfp = fopen(argv[3], "w");
-	if (!outfp) {
-		perror(argv[3]);
-		exit(1);
-	}
-	rc = fwrite(data, len, 1, outfp);
-	if (rc != 1) {
-		fprintf(stderr, "Can't write '%s':  %s\n",
-			argv[3], strerror(errno));
-		exit(1);
-	}
-	fclose(outfp);
-	exit(0);
-}

--=-+CsocuO5eE/7j/mXFZFf
Content-Disposition: attachment; filename=policycoreutils-restorecon-stdout.diff
Content-Type: text/x-patch; name=policycoreutils-restorecon-stdout.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru policycoreutils.work/restorecon/restorecon.c policycoreutils-restorecon-stdout/restorecon/restorecon.c
--- policycoreutils.work/restorecon/restorecon.c	2005-06-29 16:09:47.000000000 -0400
+++ policycoreutils-restorecon-stdout/restorecon/restorecon.c	2005-07-15 15:25:05.000000000 -0400
@@ -211,11 +211,11 @@
       } else 	
 	      if (verbose && 
 		  (verbose > 1 || !user_only_changed))
-		      fprintf(stderr,"%s reset %s context %s->%s\n",
+		      fprintf(stdout,"%s reset %s context %s->%s\n",
 			      progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
     }
     if (verbose > 1 && customizable>0) {
-	    fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
+	    fprintf(stdout,"%s: %s not reset customized by admin to %s\n",
 		      progname, filename, prev_context);
     }
 

--=-+CsocuO5eE/7j/mXFZFf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
