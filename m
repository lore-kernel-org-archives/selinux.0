Message-ID: <451945DB.90209@redhat.com>
Date: Tue, 26 Sep 2006 11:23:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: New Patch for Policycoreutils.
Content-Type: multipart/mixed;
 boundary="------------000404080908090904000600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000404080908090904000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have updated the patch to remove some of the objectionable changes.

Includes Change submitted on the list for checking if policy loaded in 
avc.py

-i flag to tell restorecon to ignore missing files

-o now takes "-" to allow it to output file list to stdout

Check to make sure restorecon has at least one input file

Build restorecond with -fPIE

fixfiles use "-i" with restorecon, added new command verify to check all 
files and output only the files with wrong context

seobject needs to have oldserange initialized.

--------------000404080908090904000600
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/audit2allow/avc.py policycoreutils-1.30.29/audit2allow/avc.py
--- nsapolicycoreutils/audit2allow/avc.py	2006-09-14 08:07:24.000000000 -0400
+++ policycoreutils-1.30.29/audit2allow/avc.py	2006-09-21 17:16:48.000000000 -0400
@@ -357,6 +357,15 @@
                                 break
                             else:
                                 dict.append(i)
+                                
+                    if not found:
+                        regexp = "audit\(\d+\.\d+:\d+\): policy loaded"
+                        m = re.match(regexp, line)
+                        if m !=None:
+                            found =1
+                            dict.append("load_policy")
+                            dict.append("granted")
+                        
                     if found:
                         self.translate(dict)
                         found = 0
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.30.29/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.8	2006-09-21 17:16:48.000000000 -0400
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
+++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-26 11:06:37.000000000 -0400
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
@@ -47,6 +48,7 @@
 static char *progname;
 static int errors = 0;
 static int recurse = 0;
+static int file_exist = 1;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
@@ -62,6 +64,7 @@
 static int add_exclude(const char *directory)
 {
 	struct stat sb;
+	int len=0;
 	if (directory == NULL || directory[0] != '/') {
 		fprintf(stderr, "Full path required for exclude: %s.\n",
 			directory);
@@ -85,12 +88,18 @@
 		return 1;
 	}
 
-	excludeArray[excludeCtr].directory = strdup(directory);
+	len = strlen(directory);
+	if (len > 1 &&  directory[len-1] == '/') {
+		excludeArray[excludeCtr].directory = calloc(1,len--);
+		strncpy(excludeArray[excludeCtr].directory, directory, len);
+	} else
+		excludeArray[excludeCtr].directory = strdup(directory);
+
 	if (!excludeArray[excludeCtr].directory) {
 		fprintf(stderr, "Out of memory.\n");
 		return 1;
 	}
-	excludeArray[excludeCtr++].size = strlen(directory);
+	excludeArray[excludeCtr++].size = len;
 
 	return 0;
 }
@@ -129,7 +138,7 @@
 void usage(const char *const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-FnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+		"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
 		name);
 	exit(1);
 }
@@ -160,6 +169,8 @@
 	}
 
 	if (lstat(filename, &st) != 0) {
+		if (!file_exist && errno == ENOENT)
+			return 0;
 		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
 			strerror(errno));
 		return 1;
@@ -249,7 +260,8 @@
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} 
+
 				if (verbose)
 					printf("%s reset %s context %s->%s\n",
 					       progname, filename,
@@ -322,6 +334,8 @@
 			close(pipe_fds[1]);
 		if (rc == -1 || rc > 0) {
 			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+				if (!file_exist && errno == ENOENT)
+					return;
 				fprintf(stderr,
 					"%s:  error while labeling files under %s\n",
 					progname, buf);
@@ -351,13 +365,17 @@
 	progname = argv[0];
 	if (is_selinux_enabled() <= 0)
 		exit(0);
+
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
@@ -370,13 +388,17 @@
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
@@ -421,6 +443,7 @@
 		if (strcmp(file_name, "-") != 0)
 			fclose(f);
 	} else {
+		if (optind >= argc) usage(argv[0]);
 		for (i = optind; i < argc; i++) {
 			process(argv[i]);
 		}
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecond/Makefile policycoreutils-1.30.29/restorecond/Makefile
--- nsapolicycoreutils/restorecond/Makefile	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.30.29/restorecond/Makefile	2006-09-21 17:16:49.000000000 -0400
@@ -5,14 +5,14 @@
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
-CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+CFLAGS ?= -g -Werror -Wall -W 
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
 LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 
 all: restorecond
 
 restorecond:  restorecond.o utmpwatcher.o stringslist.o
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	$(CC) -pie $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30.29/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/scripts/fixfiles	2006-09-26 11:16:51.000000000 -0400
@@ -117,8 +117,8 @@
     exit $?
 fi
 if [ ! -z "$RPMFILES" ]; then
-    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* -f - 2>&1 >> $LOGFILE
+    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
+	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -i -f - 2>&1 >> $LOGFILE
     done
     exit $?
 fi
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
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles.8 policycoreutils-1.30.29/scripts/fixfiles.8
--- nsapolicycoreutils/scripts/fixfiles.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.30.29/scripts/fixfiles.8	2006-09-21 17:16:49.000000000 -0400
@@ -3,9 +3,9 @@
 fixfiles \- fix file security contexts.
 
 .SH "SYNOPSIS"
-.B fixfiles [-F] [ -R rpmpackagename[,rpmpackagename...] ] [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] [-o outputfile ] { check | restore | [-F] relabel }"
+.B fixfiles [-F] [ -R rpmpackagename[,rpmpackagename...] ] [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] [-o outputfile ] { check | restore | [-F] relabel | verify }"
 
-.B fixfiles [-F] [-l logfile ] [-o outputfile ] { check | restore|[-f] relabel } [[dir/file] ... ] 
+.B fixfiles [-F] [-l logfile ] [-o outputfile ] { check | restore|[-f] relabel | verify } [[dir/file] ... ] 
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -48,7 +48,7 @@
 One of:
 .TP 
 .B check
-show any incorrect file context labels but do not change them.
+print any incorrect file context labels, showing old and new context, but do not change them.
 .TP 
 .B restore
 change any incorrect file context labels.
@@ -56,6 +56,9 @@
 .B relabel
 Prompt for removal of contents of /tmp directory and then change any inccorect file context labels to match the install file_contexts file.
 .TP 
+.B verify
+List out files with incorrect file context labels, but do not change them.
+.TP 
 .B [[dir/file] ... ] 
 List of files or directories trees that you wish to check file context on.
 
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.30.29/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-09-14 08:07:24.000000000 -0400
+++ policycoreutils-1.30.29/semanage/seobject.py	2006-09-25 09:53:57.000000000 -0400
@@ -486,6 +487,7 @@
 
 	def modify(self, name, roles = [], selevel = "", serange = "", prefix = ""):
 		oldroles = ""
+		oldserange = ""
 		newroles = string.join(roles, ' ');
 		try:
 			if prefix == "" and len(roles) == 0  and serange == "" and selevel == "":

--------------000404080908090904000600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
