Message-ID: <41FA6861.6080505@redhat.com>
Date: Fri, 28 Jan 2005 11:29:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Patch to policycoreutils
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040302020200010408050102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040302020200010408050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added new fixfiles -C PREVIOUS_FILECONTEXT  (RESTORE | CHECK)

Which will take an old version of the file_context file and the 
currently installed one and do a
diff.  Then it will run a recursive restorecon on all files covered by 
the difference.  The idea here
is to potentially call this function from within policy spec files on 
updates.  So the if the file_context
file changes on update, the file context on disk will be updated.

Also changed restorecon to not error out if one of the files  handed to 
it does not exist.

restorecon /etc/BOGUS_FILE /etc/passwd /etc/shadow

Will restore password and shadow and warn about BOGUS_FILE.

Dan

--------------040302020200010408050102
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.21.5/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-01-25 10:32:01.000000000 -0500
+++ policycoreutils-1.21.5/restorecon/restorecon.c	2005-01-28 10:40:23.000000000 -0500
@@ -188,7 +188,7 @@
 	  fprintf(stderr,
 		  "%s:  error while labeling files under %s\n",
 		  progname, buf);
-	  exit(1);
+	  errors++;
 	}
       }
       else
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.5/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-26 11:30:57.000000000 -0500
+++ policycoreutils-1.21.5/scripts/fixfiles	2005-01-28 11:16:21.000000000 -0500
@@ -37,10 +37,12 @@
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
+    FILE_CONTEXT=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
     FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
-    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
+    cat ${FILE_CONTEXT} ${FILE_CONTEXT}.local > $FC 2> /dev/null
 else
-    FC=/etc/security/selinux/file_contexts
+    FILE_CONTEXT=/etc/security/selinux/file_contexts
+    FC=${FILE_CONTEXT}
 fi
 
 cleanup() {
@@ -60,7 +62,24 @@
     echo $1 >> $LOGFILE
 fi
 }
-
+#
+# Compare PREVious File Context to currently installed File Context and 
+# run restorecon on all files affected by the differences.
+#
+diff_filecontext() {
+if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
+	TEMPFILE=`mktemp /var/tmp/${SELINUXTYPE}.XXXXXXXXXX`
+	test -z "$TEMPFILE" && exit
+	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
+        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
+            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
+        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
+	while read pattern ; do find $pattern -print; done 2> /dev/null | \
+	${RESTORECON} $2 -v -f - 
+	rm -f ${TEMPFILE}
+fi
+}
 #
 # Log all Read Only file systems 
 #
@@ -80,6 +99,10 @@
 # if called with -n will only check file context
 #
 restore () {
+if [ ! -z "$PREFC" ]; then
+    diff_filecontext $1
+    exit $?
+fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo $RPMFILES | sed 's/,/ /g'`; do
 	rpmlist $i | ${RESTORECON} ${OUTFILES} -R $1 -v -f - 2>&1 >> $LOGFILE
@@ -128,7 +151,7 @@
 usage() {
       	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
 	echo or
-      	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] [-l logfile ] [-o outputfile ] { check | restore }"
+      	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
 }
 
 if [ $# = 0 ]; then
@@ -137,7 +160,7 @@
 fi
 
 # See how we were called.
-while getopts "Fo:R:l:" i; do
+while getopts "C:Fo:R:l:" i; do
     case "$i" in
 	F)
 	fullFlag=1
@@ -151,6 +174,9 @@
         l)
 		LOGFILE=$OPTARG
 		;;
+        C)
+		PREFC=$OPTARG
+		;;
 	*)
 	    usage
 	    exit 1

--------------040302020200010408050102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
