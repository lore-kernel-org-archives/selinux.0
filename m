Message-ID: <415E9107.4030900@redhat.com>
Date: Sat, 02 Oct 2004 07:29:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: A couple of patches to setfiles.
Content-Type: multipart/mixed;
 boundary="------------050405080105010303040706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050405080105010303040706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added -e flag to exclude directories.

setfiles -e /home -e /tmp -v  -n 
/etc/selinux/strict/contexts/files/file_context /

Also added syslog to log differences. 

I would like to move the fixfiles/setfiles stuff to a more central 
logging capability.
Need to cleanup the way it currently works.

Dan

--------------050405080105010303040706
Content-Type: text/plain;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

--- policycoreutils-1.17.5/restorecon/restorecon.c.rhat	2004-08-30 11:46:46.000000000 -0400
+++ policycoreutils-1.17.5/restorecon/restorecon.c	2004-10-01 16:46:18.000000000 -0400
@@ -8,7 +8,7 @@
  * to match the specification returned by matchpathcon.
  *
  * USAGE:
- * restorecon [-nv] pathname...
+ * restorecon [-Rnv] pathname...
  * 
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
@@ -33,19 +33,25 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stdio.h>
+#define __USE_XOPEN_EXTENDED 1	/* nftw */
+#include <ftw.h>
 
-char *progname;
+static int change=1;
+static int verbose=0;
+static FILE *outfile=NULL;
+static char *progname;
+static int errors=0;
+static int recurse;
 
 void usage(const char * const name)
 {	
   fprintf(stderr,
-	  "usage:  %s [-nv] [-f filename | pathname... ]\n",  name);
+	  "usage:  %s [-Rnv] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
-int restore(char *filename, int change, int verbose, FILE *outfile) {
+int restore(char *filename) {
   int retcontext=0;
   int retval=0;
-  int errors=0;
   security_context_t scontext;
   security_context_t prev_context;
   int len=strlen(filename);
@@ -135,15 +141,36 @@
   freecon(scontext);
   return errors;
 }
+static int apply_spec(const char *file,
+		      const struct stat *sb_unused, int flag, struct FTW *s_unused)
+{
+	if (flag == FTW_DNR) {
+		fprintf(stderr, "%s:  unable to read directory %s\n",
+			progname, file);
+		return 0;
+	}
+	errors=errors+restore((char *)file);
+	return 0;
+}
+void process(char *buf) {
+      if (recurse) {
+	if (nftw
+	    (buf, apply_spec, 1024, FTW_PHYS | FTW_MOUNT)) {
+	  fprintf(stderr,
+		  "%s:  error while labeling files under %s\n",
+		  progname, buf);
+	  exit(1);
+	}
+      }
+      else
+	errors=errors+restore(buf);
+}
 int main(int argc, char **argv) {
   int i=0;
   char *file_name=NULL;
   int errors=0;
-  int change=1;
-  int verbose=0;
   int file=0;
   int opt;
-  FILE *outfile=NULL;
   char buf[PATH_MAX];
 
   progname=argv[0];
@@ -152,11 +179,14 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "nvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
       break;
+    case 'R':
+      recurse = 1;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
@@ -187,14 +217,14 @@
     }
     while(fgets(buf,PATH_MAX,f)) {
       buf[strlen(buf)-1]=0;
-      errors=errors+restore(buf, change, verbose, outfile);
+      process(buf);
     }
     if (strcmp(file_name,"-")!=0) 
       fclose(f);
   } 
   else {
     for (i=optind; i< argc; i++) {
-      errors=errors+restore(argv[i], change, verbose, outfile);
+      process(argv[i]);
     }
   }
   if (outfile) 
--- policycoreutils-1.17.5/restorecon/restorecon.8.rhat	2004-08-30 11:46:46.000000000 -0400
+++ policycoreutils-1.17.5/restorecon/restorecon.8	2004-10-01 16:46:18.000000000 -0400
@@ -4,10 +4,10 @@
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-o outfilename ] [\-n] [\-v] pathname...
+.I [\-o outfilename ] [\-R] [\-n] [\-v] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-n] [\-v] 
+.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] 
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -26,6 +26,9 @@
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
+.B \-R
+change files and directories file labels recursively
+.TP 
 .B \-n
 don't change any file labels.
 .TP 
--- policycoreutils-1.17.5/scripts/fixfiles.rhat	2004-08-30 11:46:47.000000000 -0400
+++ policycoreutils-1.17.5/scripts/fixfiles	2004-10-01 16:46:18.000000000 -0400
@@ -36,6 +36,8 @@
 FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
 FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
 SELINUXTYPE="targeted"
+FCFILE=`mktemp /var/tmp/file_contexts.XXXXXXXXXX`
+trap "rm -f $FCFILE; exit 2" 1 2 3 5 15 
 
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
@@ -48,14 +50,14 @@
 echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 | tee $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
         echo "Warning: Skipping the following R/O filesystems:"
         echo "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 | tee $LOGFILE
+    ${SETFILES} ${OUTFILES} -n -v ${FCFILE} ${FILESYSTEMSRW} 2>&1 > $LOGFILE
 fi
 }
 
@@ -63,14 +65,14 @@
 echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 | tee $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
         echo "Warning: Skipping the following R/O filesystems:"
         echo "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 | tee $LOGFILE
+    ${SETFILES} ${OUTFILES} -v ${FCFILE} ${FILESYSTEMS} 2>&1 > $LOGFILE
 fi
 }
 
@@ -80,29 +82,29 @@
 rm -rf /tmp/.??* /tmp/*
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 | tee $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
         echo "Warning: Skipping the following R/O filesystems:"
         echo "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 | tee $LOGFILE
+    ${SETFILES} ${OUTFILES} -v ${FCFILE} ${FILESYSTEMS} 2>&1 > $LOGFILE
 fi
 }
 relabelCheck() {
-echo -n "
-Files in the /tmp directory may be labeled incorrectly, this command 
-can remove all files in /tmp.  If you choose to remove files from /tmp, 
-a reboot will be required after completion.
-
-Do you wish to clean out the /tmp directory [N]? "
-read answer
-if [ "$answer" = y -o  "$answer" = Y ]; then 
-    relabel $1
-else
-    restoreLabels $1
-fi
+    echo -n "
+    Files in the /tmp directory may be labeled incorrectly, this command 
+    can remove all files in /tmp.  If you choose to remove files from /tmp, 
+    a reboot will be required after completion.
+    
+    Do you wish to clean out the /tmp directory [N]? "
+    read answer
+    if [ "$answer" = y -o  "$answer" = Y ]; then 
+	relabel $1
+    else
+	restoreLabels $1
+    fi
 
 }
 
@@ -110,6 +112,12 @@
       	echo $"Usage: $0 {-R rpmpackage[,rpmpackage...] [-l logfile ] [-o outputfile ] |check|restore|[-F] relabel}"
 }
 
+if [ $# = 0 ]; then
+	usage
+	rm -f $FCFILE
+	exit 1
+fi
+
 # See how we were called.
 for i in $@; do
 if [ $rpmFlag = 2 ]; then
@@ -127,6 +135,7 @@
     logfileFlag=1
     continue
 fi
+
 case "$i" in
 	check)
 		checkFlag=1
@@ -151,22 +160,38 @@
 		;;
 	*)
 	    usage
+           rm -f $FCFILE
 	    exit 1
 esac
 done
 if [ `expr $checkFlag + $restoreFlag + $relabelFlag` -gt 1 ]; then 
     usage
+    rm -f $FCFILE
     exit 1
 fi
+
+cp $FC $FCFILE
+#
+# Check for removable devices
+#
+for i in /proc/ide/hd*/media; do 
+	grep -q cdrom $i && echo $i | awk -F / '{ print "/dev/"$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $FCFILE || true
+done 
+
+if [ $logfileFlag = 0 ]; then
+    LOGFILE=`mktemp /var/tmp/fixfiles.log.XXXXXXXXXX`
+    if [ ! -w $LOGFILE ] ; then
+        rm -f $FCFILE
+	exit 1
+    fi
+fi
+
 if [ $checkFlag = 1 ]; then
     checkLabels $rpmFiles
 fi
 if [ $restoreFlag = 1 ]; then
     restoreLabels $rpmFiles
 fi
-if [ $logfileFlag = 0 ]; then
-    LOGFILE=`mktemp /var/tmp/fixfiles.XXXXXXXXXX`  || exit 1
-fi
 if [ $relabelFlag = 1 ]; then
     if [ $fullFlag = 1 ]; then
 	relabel $rpmFiles
@@ -174,6 +199,6 @@
 	relabelCheck $rpmFiles
     fi
 fi
-exit $?
-
 
+rm $FCFILE
+exit $?
--- policycoreutils-1.17.5/setfiles/setfiles.8.rhat	2004-10-01 18:37:41.776923384 -0400
+++ policycoreutils-1.17.5/setfiles/setfiles.8	2004-10-01 18:38:38.072735318 -0400
@@ -4,7 +4,7 @@
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-d] [\-n] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] spec_file pathname...
+.I [\-d] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -29,6 +29,9 @@
 .B \-q
 suppress non-error output.
 .TP 
+.B \-e directory
+directory to exclude (repeat option for more than one directory.)
+.TP 
 .B \-o filename
 save list of files with incorrect context in filename.
 .TP 
--- policycoreutils-1.17.5/setfiles/setfiles.c.rhat	2004-08-30 11:46:46.000000000 -0400
+++ policycoreutils-1.17.5/setfiles/setfiles.c	2004-10-01 18:35:17.000000000 -0400
@@ -12,8 +12,9 @@
  * the user.  The program does not cross file system boundaries.
  *
  * USAGE:
- * setfiles [-dnpqsvW] [-c policy] [-o filename ] spec_file pathname...
+ * setfiles [-dnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
  * 
+ * -e   Specify directory to exclude
  * -c   Verify the specification file using a binary policy
  * -d   Show what specification matched each file.
  * -n	Do not change any file labels.
@@ -69,10 +70,20 @@
 #include <limits.h>
 #include <sepol/sepol.h>
 #include <selinux/selinux.h>
+#include <syslog.h> 
+#include <libgen.h>
 
 static int add_assoc = 1;
 static FILE *outfile=NULL;
 
+#define MAX_EXCLUDES 100
+static int excludeCtr=0;
+struct edir {
+	char *directory;
+        int size;
+};
+static struct edir excludeArray[MAX_EXCLUDES];
+
 /*
  * Command-line options.
  */
@@ -140,6 +151,18 @@
 	return tmp - buf;
 }
 
+static int exclude(const char *file) {
+	int i=0;
+	for(i=0; i < excludeCtr; i++) { 
+		if (strncmp(file,excludeArray[i].directory,excludeArray[i].size)==0) {
+			if (file[excludeArray[i].size]==0 || 
+			    file[excludeArray[i].size]=='/') {
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
 /* return the length of the text that is the stem of a file name */
 int get_stem_from_file_name(const char * const buf)
 {
@@ -393,6 +416,11 @@
 		buf += rootpathlen;
 	}
 
+	if (excludeCtr > 0) {
+		if (exclude(fullname)) {
+			return -1;
+		}
+	}
 	ret = lstat(fullname, sb);
 	if (ret) {
 		fprintf(stderr, "%s:  unable to stat file %s\n", progname,
@@ -655,6 +683,8 @@
 			       my_file, context, spec_arr[i].context);
 		}
 	}
+	syslog(LOG_INFO, "%s:  relabeling %s from %s to %s\n", progname,
+	       my_file, context, spec_arr[i].context);
 
 	freecon(context);
 
@@ -736,8 +766,10 @@
 	int opt, items, len, lineno, pass, regerr, i, j;
 	spec_t *spec_copy;
 
+	memset(excludeArray,0, sizeof(excludeArray));
+
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dnqrsvWo:")) > 0) {
+	while ((opt = getopt(argc, argv, "c:dnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -761,6 +793,33 @@
 			
 			break;
 		}
+		case 'e':
+		{
+			int len;
+			struct stat sb;
+			if(optarg[0] != '/') {
+				fprintf(stderr, "Full patch required for exclude: %s.\n", 
+					optarg);
+				exit(1);
+			}
+			if(lstat(optarg, &sb)) {
+				fprintf(stderr, "Directory \"%s\" not found.\n", optarg);
+				exit(1);
+			}
+			if ((sb.st_mode & S_IFDIR) == 0 ) {
+				fprintf(stderr, "\"%s\" is not a Directory.%d\n", optarg,sb.st_mode);
+				exit(1);
+			}
+			len=strlen(optarg);
+			excludeArray[excludeCtr].directory = strdup(optarg);
+			excludeArray[excludeCtr++].size = len;
+			if (excludeCtr > MAX_EXCLUDES) {
+				fprintf(stderr, "Maximum excludes %d exceeded.\n", 
+					MAX_EXCLUDES);
+			}
+			break;
+		}
+			
 		case 'd':
 			debug = 1;
 			break;
@@ -1102,6 +1161,10 @@
 	if (outfile) 
 		fclose(outfile);
 
+	for(i=0; i < excludeCtr; i++) { 
+		free(excludeArray[i].directory);
+	}
+
 	QPRINTF("%s:  Done.\n", argv[0]);
 
 	exit(0);

--------------050405080105010303040706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
