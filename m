Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12Hkt53024453
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 12:46:55 -0500 (EST)
Message-ID: <42011203.3010005@redhat.com>
Date: Wed, 02 Feb 2005 12:46:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: New patch for fixfiles sed script
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9717.2000609@redhat.com>	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>	 <4200DC75.1070009@redhat.com> <1107360761.890.234.camel@moss-spartans.epoch.ncsc.mil> <4201012F.6040604@redhat.com>
In-Reply-To: <4201012F.6040604@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090200080904060803090707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090200080904060803090707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok how about this patch.

Added -e flag for restorecon



--------------090200080904060803090707
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.21.10/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2005-01-20 15:59:21.000000000 -0500
+++ policycoreutils-1.21.10/restorecon/restorecon.8	2005-02-02 12:16:06.000000000 -0500
@@ -4,10 +4,10 @@
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-o outfilename ] [\-R] [\-n] [\-v] pathname...
+.I [\-o outfilename ] [\-R] [\-n] [\-v] [\-e directory ] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] [\-F]
+.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v] [\-F]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -26,6 +26,9 @@
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
+.B \-e directory
+directory to exclude (repeat option for more than one directory.)
+.TP 
 .B \-R
 change files and directories file labels recursively
 .TP 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.21.10/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-01-31 09:49:15.000000000 -0500
+++ policycoreutils-1.21.10/restorecon/restorecon.c	2005-02-02 12:16:49.000000000 -0500
@@ -10,6 +10,7 @@
  * USAGE:
  * restorecon [-Rnv] pathname...
  * 
+ * -e   Specify directory to exclude
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
  * -o filename save list of files with incorrect context
@@ -45,6 +46,54 @@
 static int recurse=0;
 static int force=0;
 
+#define MAX_EXCLUDES 100
+static int excludeCtr=0;
+struct edir {
+	char *directory;
+        int size;
+};
+static struct edir excludeArray[MAX_EXCLUDES];
+static int add_exclude(const char *directory) {
+  struct stat sb;
+  if(directory == NULL || directory[0] != '/') {
+    fprintf(stderr, "Full path required for exclude: %s.\n", 
+	    directory);
+    return 1;
+  }
+  if(lstat(directory, &sb)) {
+    fprintf(stderr, "Directory \"%s\" not found.\n", directory);
+    return 1;
+  }
+  if ((sb.st_mode & S_IFDIR) == 0 ) {
+    fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
+    return 1;
+  }
+   excludeArray[excludeCtr].directory = strdup(directory);
+  if (!excludeArray[excludeCtr].directory) {
+    fprintf(stderr, "Out of memory.\n");
+    return 1;
+  }
+  excludeArray[excludeCtr++].size = strlen(directory);
+
+  if (excludeCtr > MAX_EXCLUDES) {
+    fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
+    return 1;
+  }
+  return 0;
+}
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
+
 /* Compare two contexts to see if their differences are "significant",
  * or whether the only difference is in the user. */
 static int only_changed_user(const char *a, const char *b)
@@ -61,7 +110,7 @@
 void usage(const char * const name)
 {	
   fprintf(stderr,
-	  "usage:  %s [-Rnv] [-f filename | pathname... ]\n",  name);
+	  "usage:  %s [-Rnv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
 int restore(char *filename) {
@@ -79,6 +128,9 @@
   if (len > 0 && filename[len-1]=='/' && (strcmp(filename,"/") != 0)) {
     filename[len-1]=0;
   }
+  if (excludeCtr > 0 && exclude(filename)) {
+      return 1;
+  }
   if (lstat(filename, &st)!=0) {
     fprintf(stderr,"lstat(%s) failed: %s\n", filename,strerror(errno));
     return 1;
@@ -184,7 +236,7 @@
 void process(char *buf) {
       if (recurse) {
 	if (nftw
-	    (buf, apply_spec, 1024, FTW_PHYS | FTW_MOUNT)) {
+	    (buf, apply_spec, 1024, FTW_PHYS)) {
 	  fprintf(stderr,
 		  "%s:  error while labeling files under %s\n",
 		  progname, buf);
@@ -202,13 +254,15 @@
   int opt;
   char buf[PATH_MAX];
 
+  memset(excludeArray,0, sizeof(excludeArray));
+
   progname=argv[0];
   if (is_selinux_enabled() <= 0 )
     exit(0);
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "FRnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "FRnvf:o:e:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -219,6 +273,9 @@
     case 'F':
       force = 1;
       break;
+    case 'e':
+      if ( add_exclude(optarg) ) exit(1);
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.10/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-31 09:49:15.000000000 -0500
+++ policycoreutils-1.21.10/scripts/fixfiles	2005-02-02 12:16:06.000000000 -0500
@@ -60,12 +60,26 @@
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
-	/usr/bin/diff $PREFC $FC | egrep '^[<>]'|cut -c3-| grep ^/ | \
-        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
-            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
-        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
+	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
+	sed -r -e 's,[[:blank:]].*,,g' \
+               -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
+	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
+               -e 's|\?.*|*|g' \
+	       -e 's|\(.*|*|g' \
+	       -e 's|\[.*|*|g' \
+               -e 's|\.\*|*|g' \
+               -e 's|\.\+|*|g' | \
+	sort -u | \
+        while read pattern ; \
+	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
+                  echo "$pattern"; \
+                  case "$pattern" in *"*") \
+	               echo "$pattern" | sed 's,\*$,,g' >> ${TEMPFILE};;  
+                  esac; \
+               fi; \
+            done | \
 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	${RESTORECON} $2 -v -f -R - 
+	${RESTORECON} -R $2 -v -e /root -e /home -e /tmp -e /var/tmp -f - 
 	rm -f ${TEMPFILE}
 fi
 }
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.21.10/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2005-01-31 09:49:15.000000000 -0500
+++ policycoreutils-1.21.10/setfiles/setfiles.c	2005-02-02 12:16:16.000000000 -0500
@@ -116,6 +116,35 @@
 	va_end(ap);
 }
 
+static int add_exclude(const char *directory) {
+        struct stat sb;
+	if(directory == NULL || directory[0] != '/') {
+	        fprintf(stderr, "Full path required for exclude: %s.\n", 
+		        directory);
+		return 1;
+	}
+	if(lstat(directory, &sb)) {
+	        fprintf(stderr, "Directory \"%s\" not found.\n", directory);
+	        return 1;
+	}
+	if ((sb.st_mode & S_IFDIR) == 0 ) {
+	        fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
+	        return 1;
+	}
+	excludeArray[excludeCtr].directory = strdup(directory);
+	if (!excludeArray[excludeCtr].directory) {
+	        fprintf(stderr, "Out of memory.\n");
+	        return 1;
+	}
+	excludeArray[excludeCtr++].size = strlen(directory);
+	
+	if (excludeCtr > MAX_EXCLUDES) {
+	        fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
+	        return 1;
+	}
+	return 0;
+}
+
 static int exclude(const char *file) {
 	int i=0;
 	for(i=0; i < excludeCtr; i++) { 
@@ -402,36 +431,8 @@
 			break;
 		}
 		case 'e':
-		{
-			int len;
-			struct stat sb;
-			if(optarg[0] != '/') {
-				fprintf(stderr, "Full path required for exclude: %s.\n", 
-					optarg);
-				exit(1);
-			}
-			if(lstat(optarg, &sb)) {
-				fprintf(stderr, "Directory \"%s\" not found.\n", optarg);
-				exit(1);
-			}
-			if ((sb.st_mode & S_IFDIR) == 0 ) {
-				fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", optarg,sb.st_mode);
-				exit(1);
-			}
-			len=strlen(optarg);
-			excludeArray[excludeCtr].directory = strdup(optarg);
-			if (!excludeArray[excludeCtr].directory) {
-				fprintf(stderr, "Out of memory.\n");
-				exit(1);
-			}
-			excludeArray[excludeCtr++].size = len;
-			if (excludeCtr > MAX_EXCLUDES) {
-				fprintf(stderr, "Maximum excludes %d exceeded.\n", 
-					MAX_EXCLUDES);
-				exit(1);
-			}
+		        if ( add_exclude(optarg) ) exit(1);
 			break;
-		}
 			
 		case 'd':
 			debug = 1;

--------------090200080904060803090707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
