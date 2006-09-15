Message-ID: <450AA9BF.1080101@redhat.com>
Date: Fri, 15 Sep 2006 09:25:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest patch for policycoreutils, reworked from previous.
References: <20060914210005.95111.qmail@web51511.mail.yahoo.com>
In-Reply-To: <20060914210005.95111.qmail@web51511.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------000809090007020509000706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000809090007020509000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Reworked patch.

restorecon -v goes back to stdout

added "verify" to print out files with out the verbose mode.

Dan

--------------000809090007020509000706
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.30.29/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.8	2006-09-15 09:19:49.000000000 -0400
@@ -23,6 +23,9 @@
 
 .SH "OPTIONS"
 .TP 
+.B \-i
+ignore files that do not exist
+.TP 
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-15 09:19:49.000000000 -0400
@@ -11,9 +11,10 @@
  * restorecon [-Rnv] pathname...
  * 
  * -e   Specify directory to exclude
+ * -i   Ignore error if file does not exist
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o	filename save list of files with incorrect context
  * -F	Force reset of context to match file_context for customizable files
  *
  * pathname...	The file(s) to label 
@@ -41,12 +42,14 @@
 #include <ftw.h>
 
 static int change = 1;
+static int change_ctr = 0;
 static int verbose = 0;
 static int progress = 0;
 static FILE *outfile = NULL;
 static char *progname;
 static int errors = 0;
 static int recurse = 0;
+static int file_exist = 1;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
@@ -129,7 +132,7 @@
 void usage(const char *const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-FnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+		"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
 		name);
 	exit(1);
 }
@@ -160,6 +163,8 @@
 	}
 
 	if (lstat(filename, &st) != 0) {
+		if (!file_exist && errno == ENOENT)
+			return 0;
 		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
 			strerror(errno));
 		return 1;
@@ -249,7 +254,10 @@
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} 
+				else
+					change_ctr++;
+
 				if (verbose)
 					printf("%s reset %s context %s->%s\n",
 					       progname, filename,
@@ -322,6 +330,8 @@
 			close(pipe_fds[1]);
 		if (rc == -1 || rc > 0) {
 			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+				if (!file_exist && errno == ENOENT)
+					return;
 				fprintf(stderr,
 					"%s:  error while labeling files under %s\n",
 					progname, buf);
@@ -353,11 +363,14 @@
 		exit(0);
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-	while ((opt = getopt(argc, argv, "pFrRnvf:o:e:")) > 0) {
+	while ((opt = getopt(argc, argv, "ipFrRnvf:o:e:")) > 0) {
 		switch (opt) {
 		case 'n':
 			change = 0;
 			break;
+		case 'i':
+			file_exist = 0;
+			break;
 		case 'r':
 		case 'R':
 			recurse = 1;
@@ -370,13 +383,17 @@
 				exit(1);
 			break;
 		case 'o':
-			outfile = fopen(optarg, "w");
-			if (!outfile) {
-				fprintf(stderr, "Error opening %s: %s\n",
-					optarg, strerror(errno));
-				usage(argv[0]);
+			if (strcmp(optarg,"-") == 0) 
+				outfile=stdout;
+			else {
+				outfile = fopen(optarg, "w");
+				if (!outfile) {
+					fprintf(stderr, "Error opening %s: %s\n",
+						optarg, strerror(errno));
+					usage(argv[0]);
+				}
+				__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 			}
-			__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 			break;
 		case 'v':
 			if (progress) {
@@ -428,5 +445,7 @@
 	if (outfile)
 		fclose(outfile);
 
+	if (change) return change_ctr;
+
 	return errors;
 }
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30.29/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/scripts/fixfiles	2006-09-15 09:20:06.000000000 -0400
@@ -117,7 +117,7 @@
     exit $?
 fi
 if [ ! -z "$RPMFILES" ]; then
-    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
+    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
 	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* -f - 2>&1 >> $LOGFILE
     done
     exit $?
@@ -219,7 +219,7 @@
 # check if they specified both DIRS and RPMFILES
 #
 
-if [ ! -z $RPMFILES ]; then
+if [ ! -z "$RPMFILES" ]; then
     if [ $OPTIND -le $# ]; then
 	    usage
     fi
@@ -236,6 +236,7 @@
 case "$command" in
     restore) restore -p ;;
     check) restore -n -v ;;
+    verify) restore -n -o -;;
     relabel) relabel;;
     *)
     usage

--------------000809090007020509000706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
