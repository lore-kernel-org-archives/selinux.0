Message-ID: <417965BF.7010707@redhat.com>
Date: Fri, 22 Oct 2004 15:55:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil> <20041022155639.GA4986@lkcl.net>
In-Reply-To: <20041022155639.GA4986@lkcl.net>
Content-Type: multipart/mixed;
 boundary="------------050200000608060202010109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050200000608060202010109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Another try.

Dan

--------------050200000608060202010109
Content-Type: text/x-diff;
 name="policycoreutils.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils.diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.17.6/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2004-10-06 09:47:27.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.8	2004-10-22 15:32:09.757994544 -0400
@@ -7,7 +7,7 @@
 .I [\-o outfilename ] [\-R] [\-n] [\-v] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] 
+.I \-f infilename [\-o outfilename ] [\-F] [\-R] [\-n] [\-v] 
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -26,6 +26,9 @@
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
+.B \-F
+restore file context even if admin customized file context.
+.TP 
 .B \-R
 change files and directories file labels recursively
 .TP 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.17.6/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.c	2004-10-22 15:35:25.200282800 -0400
@@ -8,11 +8,14 @@
  * to match the specification returned by matchpathcon.
  *
  * USAGE:
- * restorecon [-Rnv] pathname...
+ * restorecon [-FRnv] [-f inputfile ] [ -o outputfile ] pathname...
  * 
+ * -R	recurse
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o	filename save list of files with incorrect context
+ * -F	Restore file context even if the customize flag is set
+ * -f	filename to read from for changing filecontext
  *
  * pathname...	The file(s) to label 
  *
@@ -42,11 +45,12 @@
 static char *progname;
 static int errors=0;
 static int recurse;
+static int force=0;
 
 void usage(const char * const name)
 {	
   fprintf(stderr,
-	  "usage:  %s [-Rnv] [-f filename | pathname... ]\n",  name);
+	  "usage:  %s [-FRnv] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
 int restore(char *filename) {
@@ -54,6 +58,8 @@
   int retval=0;
   security_context_t scontext;
   security_context_t prev_context;
+  unsigned int customized=0;
+  unsigned int flag=0;
   int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
@@ -109,14 +115,27 @@
     return 0;
   }
   retcontext=lgetfilecon(filename,&prev_context);
-  
+   
   if (retcontext >= 0 || errno == ENODATA) {
     if (retcontext < 0 || strcmp(prev_context,scontext) != 0) {
-      if (outfile) {
-	fprintf(outfile, "%s\n", filename);
-      }
+      lgetfileconflag(filename, &flag);
+      customized=flag & SELINUX_CUSTOMIZE;
+      if (outfile  && (!customized || force))
+	    fprintf(outfile, "%s\n", filename);
       if (change) {
-	retval=lsetfilecon(filename,scontext);
+	if (customized) {
+		if (force) {
+			retval=lsetfilecon(filename,scontext);
+			if (retval >= 0)
+				lsetfileconflag(filename, flag & !SELINUX_CUSTOMIZE);
+		} else {
+			if (verbose)
+				fprintf(stderr,"%s did not reset context for %s, marked flaganent\n",
+					progname, filename);
+		}
+	} else {
+		retval=lsetfilecon(filename,scontext);
+	}
       }
       if (retval<0) {
 	  fprintf(stderr,"%s set context %s->%s failed:'%s'\n",
@@ -126,7 +145,7 @@
 	  freecon(scontext);
 	  return 1;
       } else 	
-	if (verbose)
+	if (verbose && (!customized || force))
 	  fprintf(stderr,"%s reset context %s->%s\n",
 		  progname, filename, scontext);
     } 
@@ -179,7 +198,7 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "FRnvf:o:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -187,6 +206,9 @@
     case 'R':
       recurse = 1;
       break;
+    case 'F':
+      force = 1;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.17.6/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/scripts/fixfiles	2004-10-22 15:32:09.759994240 -0400
@@ -31,6 +31,8 @@
 outfileFlag=0
 OUTFILES=""
 logfileFlag=0
+LOGFILE=/dev/null
+SYSLOGFLAG="-l"
 SETFILES=/usr/sbin/setfiles
 FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(rw/{print $3}';`
 FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
@@ -44,50 +46,54 @@
     FC=/etc/security/selinux/file_contexts
 fi
 
+logit () {
+if [ $logfileFlag = 0 ]; then
+    logger -i $1
+else
+    echo $1 >> $LOGFILE
+fi
+}
 checkLabels () {
-echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
 fi
 }
 
 restoreLabels () {
-echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -v ${FC} ${FILESYSTEMS} 2>&1 >> $LOGFILE
 fi
 }
 
 relabel() {
-echo "logging to $LOGFILE"
-echo "Cleaning out /tmp"
+logit "Cleaning out /tmp"
 rm -rf /tmp/.??* /tmp/*
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -v ${FC} ${FILESYSTEMS} 2>&1 >> $LOGFILE
 fi
 }
 relabelCheck() {
@@ -129,6 +135,8 @@
 fi
 if [ $logfileFlag = 2 ]; then
     LOGFILE="$i"
+    echo > $LOGFILE
+    SYSLOGFLAG=""
     logfileFlag=1
     continue
 fi
@@ -165,13 +173,6 @@
     exit 1
 fi
 
-if [ $logfileFlag = 0 ]; then
-    LOGFILE=`mktemp /var/tmp/fixfiles.log.XXXXXXXXXX`
-    if [ ! -w $LOGFILE ] ; then
-	exit 1
-    fi
-fi
-
 if [ $checkFlag = 1 ]; then
     checkLabels $rpmFiles
 fi
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles.cron policycoreutils-1.17.6/scripts/fixfiles.cron
--- nsapolicycoreutils/scripts/fixfiles.cron	2004-09-10 11:25:57.000000000 -0400
+++ policycoreutils-1.17.6/scripts/fixfiles.cron	2004-10-22 15:32:09.760994088 -0400
@@ -21,7 +21,8 @@
 	    mail ${CRONMAILTO} -s "Invalid File Contexts" < $OUTFILE
 	    rm -f $OUTFILE
 	else
-	    mail ${CRONMAILTO} -s "Invalid File Contexts listed in $OUTFILE" < /dev/null
+	    MESSAGE="Invalid File Contexts listed in $OUTFILE"
+	    mail ${CRONMAILTO} -s "Invalid File Contexts" <<< $MESSAGE
 	fi
     else
 	rm -f $OUTFILE
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/Makefile policycoreutils-1.17.6/scripts/Makefile
--- nsapolicycoreutils/scripts/Makefile	2004-09-10 11:25:57.000000000 -0400
+++ policycoreutils-1.17.6/scripts/Makefile	2004-10-22 15:32:09.761993936 -0400
@@ -12,7 +12,7 @@
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
-	install -D -m 755 fixfiles.cron $(DESTDIR)/etc/cron.daily/fixfiles.cron
+	install -D -m 755 fixfiles.cron $(DESTDIR)/etc/cron.weekly/fixfiles.cron
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8.gz $(MANDIR)/man8/
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.8 policycoreutils-1.17.6/setfiles/setfiles.8
--- nsapolicycoreutils/setfiles/setfiles.8	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/setfiles/setfiles.8	2004-10-22 15:32:09.761993936 -0400
@@ -4,7 +4,7 @@
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] spec_file pathname...
+.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-F] [\-W] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -47,6 +47,9 @@
 .B \-vv
 show changes in file labels, if type, role, or user are changing.
 .TP 
+.B \-F
+set file context even if admin customized file context.
+.TP 
 .B \-W
 display warnings about entries that had no matching files.
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.17.6/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/setfiles/setfiles.c	2004-10-22 15:36:18.282213120 -0400
@@ -12,7 +12,7 @@
  * the user.  The program does not cross file system boundaries.
  *
  * USAGE:
- * setfiles [-dnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
+ * setfiles [-FdnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
  * 
  * -e   Specify directory to exclude
  * -c   Verify the specification file using a binary policy
@@ -24,6 +24,7 @@
  * -s   Use stdin for a list of files instead of searching a partition.
  * -v	Show changes in file labels.  
  * -W   Warn about entries that have no matching file.
+ * -F	reset file context even if the customize flag is set
  * -o filename write out file names with wrong context.
  *
  * spec_file	The specification file.
@@ -96,6 +97,7 @@
 static int use_stdin = 0;
 static int verbose = 0;
 static int log = 0;
+static int force = 0;
 static int warn_no_match = 0;
 static char *rootpath = NULL;
 static int rootpathlen = 0;
@@ -515,9 +517,9 @@
 void usage(const char * const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-dnqvW] [-o filename] spec_file pathname...\n"
+		"usage:  %s [-FdnqvW] [-o filename] spec_file pathname...\n"
 		"usage:  %s [-c policyfile] spec_file\n"
-		"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name, name);
+		"usage:  %s -s [-FdnqvW] [-o filename ] spec_file\n", name, name, name);
 	exit(1);
 }
 
@@ -603,6 +605,8 @@
 	struct stat my_sb;
 	int i, ret;
 	char *context; 
+	unsigned int customize=0;
+	unsigned int fileconflag=0;
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -675,7 +679,9 @@
 		return 0;
 	}
 
-	if (verbose) {
+	lgetfileconflag(my_file, &fileconflag);
+	customize=fileconflag & SELINUX_CUSTOMIZE;
+	if (verbose && (!customize || force)) {
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
@@ -686,22 +692,22 @@
 		}
 	}
 
-	if (log &&
+	if (log && (!customize || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) {
 		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
 		       my_file, context, spec_arr[i].context);
 	}
 
-	if (outfile &&
+	if (outfile && (!customize || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) 
 		fprintf(outfile, "%s\n", my_file);
 
 	freecon(context);
 
 	/*
-	 * Do not relabel the file if -n was used.
+	 * Do not relabel the file if -n was used or if customized.
 	 */
-	if (!change)
+	if (!change || (customize & !force))
 		return 0;
 
 	/*
@@ -714,6 +720,7 @@
 			progname, my_file, spec_arr[i].context);
 		return 0;
 	}
+	lsetfileconflag(my_file, fileconflag & !SELINUX_CUSTOMIZE);
 
 	return 0;
 }
@@ -775,7 +782,7 @@
 	memset(excludeArray,0, sizeof(excludeArray));
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -837,6 +844,9 @@
 		case 'l':
 			log = 1;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'n':
 			change = 0;
 			break;

--------------050200000608060202010109
Content-Type: text/x-diff;
 name="libselinux.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.17.6/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2004-10-06 09:47:27.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.8	2004-10-22 15:32:09.757994544 -0400
@@ -7,7 +7,7 @@
 .I [\-o outfilename ] [\-R] [\-n] [\-v] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] 
+.I \-f infilename [\-o outfilename ] [\-F] [\-R] [\-n] [\-v] 
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -26,6 +26,9 @@
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
+.B \-F
+restore file context even if admin customized file context.
+.TP 
 .B \-R
 change files and directories file labels recursively
 .TP 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.17.6/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.c	2004-10-22 15:35:25.200282800 -0400
@@ -8,11 +8,14 @@
  * to match the specification returned by matchpathcon.
  *
  * USAGE:
- * restorecon [-Rnv] pathname...
+ * restorecon [-FRnv] [-f inputfile ] [ -o outputfile ] pathname...
  * 
+ * -R	recurse
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o	filename save list of files with incorrect context
+ * -F	Restore file context even if the customize flag is set
+ * -f	filename to read from for changing filecontext
  *
  * pathname...	The file(s) to label 
  *
@@ -42,11 +45,12 @@
 static char *progname;
 static int errors=0;
 static int recurse;
+static int force=0;
 
 void usage(const char * const name)
 {	
   fprintf(stderr,
-	  "usage:  %s [-Rnv] [-f filename | pathname... ]\n",  name);
+	  "usage:  %s [-FRnv] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
 int restore(char *filename) {
@@ -54,6 +58,8 @@
   int retval=0;
   security_context_t scontext;
   security_context_t prev_context;
+  unsigned int customized=0;
+  unsigned int flag=0;
   int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
@@ -109,14 +115,27 @@
     return 0;
   }
   retcontext=lgetfilecon(filename,&prev_context);
-  
+   
   if (retcontext >= 0 || errno == ENODATA) {
     if (retcontext < 0 || strcmp(prev_context,scontext) != 0) {
-      if (outfile) {
-	fprintf(outfile, "%s\n", filename);
-      }
+      lgetfileconflag(filename, &flag);
+      customized=flag & SELINUX_CUSTOMIZE;
+      if (outfile  && (!customized || force))
+	    fprintf(outfile, "%s\n", filename);
       if (change) {
-	retval=lsetfilecon(filename,scontext);
+	if (customized) {
+		if (force) {
+			retval=lsetfilecon(filename,scontext);
+			if (retval >= 0)
+				lsetfileconflag(filename, flag & !SELINUX_CUSTOMIZE);
+		} else {
+			if (verbose)
+				fprintf(stderr,"%s did not reset context for %s, marked flaganent\n",
+					progname, filename);
+		}
+	} else {
+		retval=lsetfilecon(filename,scontext);
+	}
       }
       if (retval<0) {
 	  fprintf(stderr,"%s set context %s->%s failed:'%s'\n",
@@ -126,7 +145,7 @@
 	  freecon(scontext);
 	  return 1;
       } else 	
-	if (verbose)
+	if (verbose && (!customized || force))
 	  fprintf(stderr,"%s reset context %s->%s\n",
 		  progname, filename, scontext);
     } 
@@ -179,7 +198,7 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "FRnvf:o:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -187,6 +206,9 @@
     case 'R':
       recurse = 1;
       break;
+    case 'F':
+      force = 1;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.17.6/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/scripts/fixfiles	2004-10-22 15:32:09.759994240 -0400
@@ -31,6 +31,8 @@
 outfileFlag=0
 OUTFILES=""
 logfileFlag=0
+LOGFILE=/dev/null
+SYSLOGFLAG="-l"
 SETFILES=/usr/sbin/setfiles
 FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(rw/{print $3}';`
 FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
@@ -44,50 +46,54 @@
     FC=/etc/security/selinux/file_contexts
 fi
 
+logit () {
+if [ $logfileFlag = 0 ]; then
+    logger -i $1
+else
+    echo $1 >> $LOGFILE
+fi
+}
 checkLabels () {
-echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
 fi
 }
 
 restoreLabels () {
-echo "logging to $LOGFILE"
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -v ${FC} ${FILESYSTEMS} 2>&1 >> $LOGFILE
 fi
 }
 
 relabel() {
-echo "logging to $LOGFILE"
-echo "Cleaning out /tmp"
+logit "Cleaning out /tmp"
 rm -rf /tmp/.??* /tmp/*
 if [ ! -z "$1" ]; then
     for i in `echo $1 | sed 's/,/ /g'`; do
-	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
+	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 >> $LOGFILE
     done
 else
     if [ ! -z "$FILESYSTEMSRO" ]; then
-        echo "Warning: Skipping the following R/O filesystems:"
-        echo "$FILESYSTEMSRO"
+        logit "Warning: Skipping the following R/O filesystems:"
+        logit "$FILESYSTEMSRO"
     fi
-    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 > $LOGFILE
+    ${SETFILES} ${OUTFILES} ${SYSLOGFLAG} -v ${FC} ${FILESYSTEMS} 2>&1 >> $LOGFILE
 fi
 }
 relabelCheck() {
@@ -129,6 +135,8 @@
 fi
 if [ $logfileFlag = 2 ]; then
     LOGFILE="$i"
+    echo > $LOGFILE
+    SYSLOGFLAG=""
     logfileFlag=1
     continue
 fi
@@ -165,13 +173,6 @@
     exit 1
 fi
 
-if [ $logfileFlag = 0 ]; then
-    LOGFILE=`mktemp /var/tmp/fixfiles.log.XXXXXXXXXX`
-    if [ ! -w $LOGFILE ] ; then
-	exit 1
-    fi
-fi
-
 if [ $checkFlag = 1 ]; then
     checkLabels $rpmFiles
 fi
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles.cron policycoreutils-1.17.6/scripts/fixfiles.cron
--- nsapolicycoreutils/scripts/fixfiles.cron	2004-09-10 11:25:57.000000000 -0400
+++ policycoreutils-1.17.6/scripts/fixfiles.cron	2004-10-22 15:32:09.760994088 -0400
@@ -21,7 +21,8 @@
 	    mail ${CRONMAILTO} -s "Invalid File Contexts" < $OUTFILE
 	    rm -f $OUTFILE
 	else
-	    mail ${CRONMAILTO} -s "Invalid File Contexts listed in $OUTFILE" < /dev/null
+	    MESSAGE="Invalid File Contexts listed in $OUTFILE"
+	    mail ${CRONMAILTO} -s "Invalid File Contexts" <<< $MESSAGE
 	fi
     else
 	rm -f $OUTFILE
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/Makefile policycoreutils-1.17.6/scripts/Makefile
--- nsapolicycoreutils/scripts/Makefile	2004-09-10 11:25:57.000000000 -0400
+++ policycoreutils-1.17.6/scripts/Makefile	2004-10-22 15:32:09.761993936 -0400
@@ -12,7 +12,7 @@
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
-	install -D -m 755 fixfiles.cron $(DESTDIR)/etc/cron.daily/fixfiles.cron
+	install -D -m 755 fixfiles.cron $(DESTDIR)/etc/cron.weekly/fixfiles.cron
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8.gz $(MANDIR)/man8/
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.8 policycoreutils-1.17.6/setfiles/setfiles.8
--- nsapolicycoreutils/setfiles/setfiles.8	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/setfiles/setfiles.8	2004-10-22 15:32:09.761993936 -0400
@@ -4,7 +4,7 @@
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] spec_file pathname...
+.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-F] [\-W] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -47,6 +47,9 @@
 .B \-vv
 show changes in file labels, if type, role, or user are changing.
 .TP 
+.B \-F
+set file context even if admin customized file context.
+.TP 
 .B \-W
 display warnings about entries that had no matching files.
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.17.6/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/setfiles/setfiles.c	2004-10-22 15:36:18.282213120 -0400
@@ -12,7 +12,7 @@
  * the user.  The program does not cross file system boundaries.
  *
  * USAGE:
- * setfiles [-dnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
+ * setfiles [-FdnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
  * 
  * -e   Specify directory to exclude
  * -c   Verify the specification file using a binary policy
@@ -24,6 +24,7 @@
  * -s   Use stdin for a list of files instead of searching a partition.
  * -v	Show changes in file labels.  
  * -W   Warn about entries that have no matching file.
+ * -F	reset file context even if the customize flag is set
  * -o filename write out file names with wrong context.
  *
  * spec_file	The specification file.
@@ -96,6 +97,7 @@
 static int use_stdin = 0;
 static int verbose = 0;
 static int log = 0;
+static int force = 0;
 static int warn_no_match = 0;
 static char *rootpath = NULL;
 static int rootpathlen = 0;
@@ -515,9 +517,9 @@
 void usage(const char * const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-dnqvW] [-o filename] spec_file pathname...\n"
+		"usage:  %s [-FdnqvW] [-o filename] spec_file pathname...\n"
 		"usage:  %s [-c policyfile] spec_file\n"
-		"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name, name);
+		"usage:  %s -s [-FdnqvW] [-o filename ] spec_file\n", name, name, name);
 	exit(1);
 }
 
@@ -603,6 +605,8 @@
 	struct stat my_sb;
 	int i, ret;
 	char *context; 
+	unsigned int customize=0;
+	unsigned int fileconflag=0;
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -675,7 +679,9 @@
 		return 0;
 	}
 
-	if (verbose) {
+	lgetfileconflag(my_file, &fileconflag);
+	customize=fileconflag & SELINUX_CUSTOMIZE;
+	if (verbose && (!customize || force)) {
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
@@ -686,22 +692,22 @@
 		}
 	}
 
-	if (log &&
+	if (log && (!customize || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) {
 		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
 		       my_file, context, spec_arr[i].context);
 	}
 
-	if (outfile &&
+	if (outfile && (!customize || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) 
 		fprintf(outfile, "%s\n", my_file);
 
 	freecon(context);
 
 	/*
-	 * Do not relabel the file if -n was used.
+	 * Do not relabel the file if -n was used or if customized.
 	 */
-	if (!change)
+	if (!change || (customize & !force))
 		return 0;
 
 	/*
@@ -714,6 +720,7 @@
 			progname, my_file, spec_arr[i].context);
 		return 0;
 	}
+	lsetfileconflag(my_file, fileconflag & !SELINUX_CUSTOMIZE);
 
 	return 0;
 }
@@ -775,7 +782,7 @@
 	memset(excludeArray,0, sizeof(excludeArray));
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -837,6 +844,9 @@
 		case 'l':
 			log = 1;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'n':
 			change = 0;
 			break;

--------------050200000608060202010109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
