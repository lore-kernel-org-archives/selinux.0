Message-ID: <41782BBA.9090101@redhat.com>
Date: Thu, 21 Oct 2004 17:35:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>,
   "wal >> Colin Walters" <walters@redhat.com>
Subject: Proposed patch for libselinux
Content-Type: multipart/mixed;
 boundary="------------050606050103000400020805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050606050103000400020805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I would like to add getfileconperm and setfileconperm to libselinux.  
This will set a flag to indicate whether the security context of the
file was set via chcon (Permanently) or via setfiles/restorecon.  If 
this patch is approved, I have patches to coreutils and policycoreutils
to use them.

chcon will always set the permanent flag.

restorecon and setfiles will ignore permanent files, unless the -F flag 
is passed which will cause them to modify the
context.

Examples of where a sysadmin would want to use this is for html pages.

What do you think?

Downsides:
It will cause restorecon and setfiles to run a little slower.
It is not atomic so chcon could set the file context and not set the 
permanent flag.

Dan

--------------050606050103000400020805
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.17.15/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/include/selinux/selinux.h	2004-10-21 16:28:18.194233008 -0400
@@ -62,6 +62,13 @@
 extern int setfilecon(const char *path, security_context_t con);
 extern int lsetfilecon(const char *path, security_context_t con);
 extern int fsetfilecon(int fd, security_context_t con);
+/* setfileconperm marks a file context as permanent.  IE. a default setfiles 
+   will not relabel it.
+*/
+extern int setfileconperm(const char *path, int perm);
+extern int lsetfileconperm(const char *path, int perm);
+extern int getfileconperm(const char *path, int *perm);
+extern int lgetfileconperm(const char *path, int *perm);
 
 
 /* Wrappers for the socket API */
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.17.15/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/getfilecon.c	2004-10-20 16:35:52.000000000 -0400
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <sys/xattr.h>
+#include <attr/xattr.h>
 #include "policy.h"
 
 int getfilecon(const char *path, security_context_t *context)
@@ -43,3 +43,9 @@
 		*context = buf;
 	return ret;
 }
+
+int getfileconperm(const char *path, int *perm)
+{
+	*perm=0;
+	return getxattr(path, XATTR_NAME_SELINUX_PERM, perm, sizeof(*perm));
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lgetfilecon.c libselinux-1.17.15/src/lgetfilecon.c
--- nsalibselinux/src/lgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/lgetfilecon.c	2004-10-20 16:29:56.000000000 -0400
@@ -4,7 +4,7 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <sys/xattr.h>
+#include <attr/xattr.h>
 #include "policy.h"
 
 int lgetfilecon(const char *path, security_context_t *context)
@@ -43,3 +43,8 @@
 		*context = buf;
 	return ret;
 }
+int lgetfileconperm(const char *path, int *perm)
+{
+	*perm=0;
+	return lgetxattr(path, XATTR_NAME_SELINUX_PERM, perm, sizeof(*perm));
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lsetfilecon.c libselinux-1.17.15/src/lsetfilecon.c
--- nsalibselinux/src/lsetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/lsetfilecon.c	2004-10-21 16:49:41.127197552 -0400
@@ -11,3 +11,7 @@
 {
 	return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+int lsetfileconperm(const char *path, int perm)
+{
+	return setxattr(path, XATTR_NAME_SELINUX_PERM, &perm, sizeof(perm), 0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/policy.h libselinux-1.17.15/src/policy.h
--- nsalibselinux/src/policy.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/policy.h	2004-10-20 14:23:35.000000000 -0400
@@ -5,6 +5,7 @@
 
 /* xattr name for SELinux attributes. */
 #define XATTR_NAME_SELINUX "security.selinux"
+#define XATTR_NAME_SELINUX_PERM "security.selinux.perm"
 
 /* Initial length guess for getting contexts. */
 #define INITCONTEXTLEN 255
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setfilecon.c libselinux-1.17.15/src/setfilecon.c
--- nsalibselinux/src/setfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.17.15/src/setfilecon.c	2004-10-21 16:49:31.985587288 -0400
@@ -11,3 +11,7 @@
 {
 	return setxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+int setfileconperm(const char *path, int perm)
+{
+	return setxattr(path, XATTR_NAME_SELINUX_PERM, &perm, sizeof(perm), 0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getfileconperm.c libselinux-1.17.15/utils/getfileconperm.c
--- nsalibselinux/utils/getfileconperm.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.15/utils/getfileconperm.c	2004-10-20 16:25:47.000000000 -0400
@@ -0,0 +1,24 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv) 
+{
+	int rc, i;
+	int perm;
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = getfileconperm(argv[i], &perm);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  getfileconperm(%s) failed\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%d\n", argv[i], perm);
+	}
+	exit(0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/setfileconperm.c libselinux-1.17.15/utils/setfileconperm.c
--- nsalibselinux/utils/setfileconperm.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.15/utils/setfileconperm.c	2004-10-21 16:50:46.098320440 -0400
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
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = setfileconperm(argv[i],1);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  setfileconperm(%s) failed: %s\n", argv[0], argv[i],strerror(errno));
+			exit(2);
+		}
+	}
+	exit(0);
+}

--------------050606050103000400020805
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

Binary files nsapolicycoreutils/restorecon/restorecon and policycoreutils-1.17.6/restorecon/restorecon differ
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.17.6/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.c	2004-10-21 17:11:08.741450432 -0400
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
+ * -F	Restorecon files that have permanant changes
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
@@ -54,6 +58,7 @@
   int retval=0;
   security_context_t scontext;
   security_context_t prev_context;
+  int perm=0;
   int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
@@ -109,14 +114,25 @@
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
+      lgetfileconperm(filename, &perm);
+      if (outfile  && (!perm || force))
+	    fprintf(outfile, "%s\n", filename);
       if (change) {
-	retval=lsetfilecon(filename,scontext);
+	if (perm) {
+		if (force) {
+			lsetfileconperm(filename, 0);
+			retval=lsetfilecon(filename,scontext);
+		} else {
+			if (verbose)
+				fprintf(stderr,"%s did not reset context for %s, marked permanent\n",
+					progname, filename);
+		}
+	} else {
+		retval=lsetfilecon(filename,scontext);
+	}
       }
       if (retval<0) {
 	  fprintf(stderr,"%s set context %s->%s failed:'%s'\n",
@@ -126,7 +142,7 @@
 	  freecon(scontext);
 	  return 1;
       } else 	
-	if (verbose)
+	if (verbose && (!perm || force))
 	  fprintf(stderr,"%s reset context %s->%s\n",
 		  progname, filename, scontext);
     } 
@@ -179,7 +195,7 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "FRnvf:o:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -187,6 +203,9 @@
     case 'R':
       recurse = 1;
       break;
+    case 'F':
+      force = 1;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
Binary files nsapolicycoreutils/restorecon/restorecon.o and policycoreutils-1.17.6/restorecon/restorecon.o differ
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
 
Binary files nsapolicycoreutils/setfiles/setfiles and policycoreutils-1.17.6/setfiles/setfiles differ
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.17.6/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.17.6/setfiles/setfiles.c	2004-10-21 17:17:30.557405584 -0400
@@ -24,6 +24,7 @@
  * -s   Use stdin for a list of files instead of searching a partition.
  * -v	Show changes in file labels.  
  * -W   Warn about entries that have no matching file.
+ * -F	set file context even those that have permanant changes
  * -o filename write out file names with wrong context.
  *
  * spec_file	The specification file.
@@ -96,6 +97,7 @@
 static int use_stdin = 0;
 static int verbose = 0;
 static int log = 0;
+static int force = 1;
 static int warn_no_match = 0;
 static char *rootpath = NULL;
 static int rootpathlen = 0;
@@ -603,6 +605,7 @@
 	struct stat my_sb;
 	int i, ret;
 	char *context; 
+	int perm=0;
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -675,7 +678,8 @@
 		return 0;
 	}
 
-	if (verbose) {
+	lgetfileconperm(my_file, &perm);
+	if (verbose && (!perm || force)) {
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
@@ -686,13 +690,13 @@
 		}
 	}
 
-	if (log &&
+	if (log && (!perm || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) {
 		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
 		       my_file, context, spec_arr[i].context);
 	}
 
-	if (outfile &&
+	if (outfile && (!perm || force) &&
 	    !only_changed_user(context, spec_arr[i].context)) 
 		fprintf(outfile, "%s\n", my_file);
 
@@ -701,7 +705,7 @@
 	/*
 	 * Do not relabel the file if -n was used.
 	 */
-	if (!change)
+	if (!change || (perm && !force))
 		return 0;
 
 	/*
@@ -714,6 +718,7 @@
 			progname, my_file, spec_arr[i].context);
 		return 0;
 	}
+	lsetfileconperm(my_file, 0);
 
 	return 0;
 }
@@ -775,7 +780,7 @@
 	memset(excludeArray,0, sizeof(excludeArray));
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -837,6 +842,9 @@
 		case 'l':
 			log = 1;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'n':
 			change = 0;
 			break;
Binary files nsapolicycoreutils/setfiles/setfiles.o and policycoreutils-1.17.6/setfiles/setfiles.o differ

--------------050606050103000400020805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
