Message-ID: <41794ADF.1000200@redhat.com>
Date: Fri, 22 Oct 2004 14:01:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com>	 <1098451420.7614.43.camel@moss-spartans.epoch.ncsc.mil>	 <41790F02.8070207@redhat.com>	 <1098454526.7614.97.camel@moss-spartans.epoch.ncsc.mil>	 <41791827.6050709@redhat.com> <1098455400.7614.112.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098455400.7614.112.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040007020401020506010207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040007020401020506010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rewritten patch to use
setfileflag
getfileflag

Is this closer to what you want?

Dan

--------------040007020401020506010207
Content-Type: text/x-diff;
 name="policycoreutils.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils.diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.17.6/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2004-10-06 09:47:27.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.8	2004-10-22 13:56:06.683115096 -0400
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
+++ policycoreutils-1.17.6/restorecon/restorecon.c	2004-10-22 13:53:13.847390120 -0400
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
+  int customized=0;
+  int flag=0;
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
+      lgetfileflag(filename, &flag);
+      customized=flag && SELINUX_CUSTOMIZE;
+      if (outfile  && (!customized || force))
+	    fprintf(outfile, "%s\n", filename);
       if (change) {
-	retval=lsetfilecon(filename,scontext);
+	if (customized) {
+		if (force) {
+			retval=lsetfilecon(filename,scontext);
+			if (retval >= 0)
+				lsetfileflag(filename, flag && !SELINUX_CUSTOMIZE);
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
+++ policycoreutils-1.17.6/scripts/fixfiles	2004-10-18 15:35:41.000000000 -0400
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
+++ policycoreutils-1.17.6/scripts/fixfiles.cron	2004-10-18 15:35:41.000000000 -0400
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
+++ policycoreutils-1.17.6/scripts/Makefile	2004-10-18 15:35:41.000000000 -0400
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
+++ policycoreutils-1.17.6/setfiles/setfiles.8	2004-10-22 13:56:03.453606056 -0400
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
+++ policycoreutils-1.17.6/setfiles/setfiles.c	2004-10-22 13:52:04.621913992 -0400
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
 
@@ -603,6 +605,7 @@
 	struct stat my_sb;
 	int i, ret;
 	char *context; 
+	int customize=0;
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -675,7 +678,9 @@
 		return 0;
 	}
 
-	if (verbose) {
+	lgetfileflag(my_file, &flag);
+	customize=customize && SELINUX_CUSTOMIZE;
+	if (verbose && (!customize || force)) {
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
@@ -686,22 +691,22 @@
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
+	if (!change || (customize && !force))
 		return 0;
 
 	/*
@@ -714,6 +719,7 @@
 			progname, my_file, spec_arr[i].context);
 		return 0;
 	}
+	lsetfileflag(my_file, flag && !SELINUX_CUSTOMIZE);
 
 	return 0;
 }
@@ -775,7 +781,7 @@
 	memset(excludeArray,0, sizeof(excludeArray));
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -837,6 +843,9 @@
 		case 'l':
 			log = 1;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'n':
 			change = 0;
 			break;

--------------040007020401020506010207
Content-Type: text/x-diff;
 name="libselinux.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.17.15/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/include/selinux/selinux.h	2004-10-22 13:23:55.405713888 -0400
@@ -62,6 +62,15 @@
 extern int setfilecon(const char *path, security_context_t con);
 extern int lsetfilecon(const char *path, security_context_t con);
 extern int fsetfilecon(int fd, security_context_t con);
+/* setfileflag marks a file context as customized.  IE. a default setfiles 
+   will not relabel it.
+*/
+/* The following bit constants can be used with flags */
+#define SELINUX_CUSTOMIZE 0 << 1
+extern int setfileflag(const char *path, int flag);
+extern int lsetfileflag(const char *path, int flag);
+extern int getfileflag(const char *path, int *flag);
+extern int lgetfileflag(const char *path, int *flag);
 
 
 /* Wrappers for the socket API */
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.17.15/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/getfilecon.c	2004-10-22 13:16:07.041916008 -0400
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include <netinet/in.h>
 #include "policy.h"
 
 int getfilecon(const char *path, security_context_t *context)
@@ -43,3 +44,15 @@
 		*context = buf;
 	return ret;
 }
+
+int getfileflag(const char *path, int *retflag)
+{
+	int flag=0;
+	int rc=0;
+	rc=lgetxattr(path, XATTR_NAME_SELINUX_FLAG, &flag, sizeof(flag));
+	if (rc==0) 
+		*retflag=ntohl(flag);
+	else 
+		*retflag=0;
+	return rc;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lgetfilecon.c libselinux-1.17.15/src/lgetfilecon.c
--- nsalibselinux/src/lgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/lgetfilecon.c	2004-10-22 13:16:31.500197784 -0400
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include <netinet/in.h>
 #include "policy.h"
 
 int lgetfilecon(const char *path, security_context_t *context)
@@ -43,3 +44,14 @@
 		*context = buf;
 	return ret;
 }
+int lgetfileflag(const char *path, int *retflag)
+{
+	int flag=0;
+	int rc=0;
+	rc=lgetxattr(path, XATTR_NAME_SELINUX_FLAG, &flag, sizeof(flag));
+	if (rc==0) 
+		*retflag=ntohl(flag);
+	else 
+		*retflag=0;
+	return rc;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lsetfilecon.c libselinux-1.17.15/src/lsetfilecon.c
--- nsalibselinux/src/lsetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/lsetfilecon.c	2004-10-22 13:16:53.540847096 -0400
@@ -5,9 +5,15 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include <netinet/in.h>
 #include "policy.h"
 
 int lsetfilecon(const char *path, security_context_t context)
 {
 	return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+int lsetfileflag(const char *path, int flag)
+{
+	int nflag=htonl(flag);
+	return lsetxattr(path, XATTR_NAME_SELINUX_FLAG, &nflag, sizeof(nflag), 0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/policy.h libselinux-1.17.15/src/policy.h
--- nsalibselinux/src/policy.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/policy.h	2004-10-20 14:23:35.000000000 -0400
@@ -5,6 +5,7 @@
 
 /* xattr name for SELinux attributes. */
 #define XATTR_NAME_SELINUX "security.selinux"
+#define XATTR_NAME_SELINUX_FLAG "security.selinux.flag"
 
 /* Initial length guess for getting contexts. */
 #define INITCONTEXTLEN 255
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setfilecon.c libselinux-1.17.15/src/setfilecon.c
--- nsalibselinux/src/setfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/setfilecon.c	2004-10-22 13:14:31.629420912 -0400
@@ -11,3 +11,8 @@
 {
 	return setxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+int setfileflag(const char *path, int flag)
+{
+	int nflag=htonl(flag);
+	return setxattr(path, XATTR_NAME_SELINUX_FLAG, &nflag, sizeof(nflag), 0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getfileflag.c libselinux-1.17.15/utils/getfileflag.c
--- nsalibselinux/utils/getfileflag.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.15/utils/getfileflag.c	2004-10-22 13:20:33.392424576 -0400
@@ -0,0 +1,24 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv) 
+{
+	int rc, i;
+	int flag;
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = getfileflag(argv[i], &flag);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  getfileflag(%s) failed\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%d\n", argv[i], flag);
+	}
+	exit(0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/setfileflag.c libselinux-1.17.15/utils/setfileflag.c
--- nsalibselinux/utils/setfileflag.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.15/utils/setfileflag.c	2004-10-22 13:22:31.436479152 -0400
@@ -0,0 +1,25 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include <errno.h>
+#include <string.h>
+
+int main(int argc, char **argv) 
+{
+	int rc, i;
+	int flag=SELINUX_CUSTOMIZE;
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = setfileflag(argv[i],flag);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  setfileflag(%s) failed: %s\n", argv[0], argv[i],strerror(errno));
+			exit(2);
+		}
+	}
+	exit(0);
+}

--------------040007020401020506010207--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
