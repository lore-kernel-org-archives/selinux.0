Message-ID: <45094B5D.3070606@redhat.com>
Date: Thu, 14 Sep 2006 08:30:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Latest patch for policycoreutils, reworked from previous.
Content-Type: multipart/mixed;
 boundary="------------090301070602030709060706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301070602030709060706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Reworked patch to restorecon

Added -i qualified to ignore missing files.  (-f) flag is already used 
for filename.  If you want to pick another qualifier, pick it, I am not 
wed to -i.

Added ability to use stdout for -o qualifier, so -o - will now output to 
stdout.

Changed verbose mode to print to stderr, so you can use -v and -o - at 
the same time.


Add a change_ctr to allow restorecon to exit with the number of 
"changed" files.  Similar to what grep returns.

Also changes fixfiles to send only stdout to logfile so we can grab "-o 
-" separately.

There is a bug in fixfiles which causes it not to handle multiple rpm 
files which is also fixed.

--------------090301070602030709060706
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.30.29/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.8	2006-09-14 08:12:16.000000000 -0400
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
+++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-14 08:17:23.000000000 -0400
@@ -11,9 +11,10 @@
  * restorecon [-Rnv] pathname...
  * 
  * -e   Specify directory to exclude
+ * -i   Ignore error if file does not exist
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o   filename save list of files with incorrect context
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
+		"usage:  %s [-iFonrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
 		name);
 	exit(1);
 }
@@ -160,7 +163,9 @@
 	}
 
 	if (lstat(filename, &st) != 0) {
-		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
+		if (!file_exist && errno == ENOENT)
+			return 0;
+		fprintf(outfile, "lstat(%s) failed: %s\n", filename,
 			strerror(errno));
 		return 1;
 	}
@@ -249,9 +251,12 @@
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} 
+				else
+					change_ctr++;
+
 				if (verbose)
-					printf("%s reset %s context %s->%s\n",
+					fprintf(stderr, "%s reset %s context %s->%s\n",
 					       progname, filename,
 					       (retcontext >=
 						0 ? prev_context : ""),
@@ -259,7 +264,7 @@
 			}
 		}
 		if (verbose > 1 && !force && customizable > 0) {
-			printf("%s: %s not reset customized by admin to %s\n",
+			fprintf(stderr, "%s: %s not reset customized by admin to %s\n",
 			       progname, filename, prev_context);
 		}
 
@@ -322,6 +327,8 @@
 			close(pipe_fds[1]);
 		if (rc == -1 || rc > 0) {
 			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+				if (!file_exist && errno == ENOENT)
+					return;
 				fprintf(stderr,
 					"%s:  error while labeling files under %s\n",
 					progname, buf);
@@ -353,11 +360,14 @@
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
@@ -370,13 +380,17 @@
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
@@ -425,8 +439,11 @@
 			process(argv[i]);
 		}
 	}
+
 	if (outfile)
 		fclose(outfile);
 
+	if (change) return change_ctr;
+
 	return errors;
 }
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30.29/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/scripts/fixfiles	2006-09-14 08:12:16.000000000 -0400
@@ -117,8 +117,8 @@
     exit $?
 fi
 if [ ! -z "$RPMFILES" ]; then
-    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* -f - 2>&1 >> $LOGFILE
+    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
+	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -i $* -f - 2>> $LOGFILE
     done
     exit $?
 fi
@@ -126,10 +126,10 @@
     if [ -x /usr/bin/find ]; then
 	for d in ${DIRS} ; do find $d \
 	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o -print | \
-	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -f - 2>&1 >> $LOGFILE
+	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -f - 2>> $LOGFILE
 	done
     else
-	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $DIRS 2>&1 >> $LOGFILE
+	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $DIRS 2>> $LOGFILE
     fi
 
     exit $?
@@ -219,7 +219,7 @@
 # check if they specified both DIRS and RPMFILES
 #
 
-if [ ! -z $RPMFILES ]; then
+if [ ! -z "$RPMFILES" ]; then
     if [ $OPTIND -le $# ]; then
 	    usage
     fi

--------------090301070602030709060706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
