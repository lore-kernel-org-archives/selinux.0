Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA3FbGuX026587
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:37:16 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nA3FdB3X004760
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 15:39:12 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nA3FbFkT002238
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:37:15 -0500
Received: from localhost.localdomain (vpn-8-158.rdu.redhat.com [10.11.8.158])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nA3FbEGx014266
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:37:14 -0500
Message-ID: <4AF04E29.4020101@redhat.com>
Date: Tue, 03 Nov 2009 10:37:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This patch removes OUTPUT from fixfiles which was never used and
 was broken
Content-Type: multipart/mixed;
 boundary="------------030409080700030409010903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030409080700030409010903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patches come from 

Moray.Henderson@ict.om.org

--------------030409080700030409010903
Content-Type: text/plain;
 name="policoreutils-fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policoreutils-fixfiles.patch"

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index e60ce31..ae519fc 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -27,7 +27,6 @@ fullFlag=0
 FORCEFLAG=""
 DIRS=""
 RPMILES=""
-OUTFILES=""
 LOGFILE=`tty`
 if [ $? != 0 ]; then
     LOGFILE="/dev/null"
@@ -122,7 +121,7 @@ if [ ! -z "$PREFC" ]; then
 fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -R -i -f - 2>&1 >> $LOGFILE
+	rpmlist $i | ${RESTORECON} ${FORCEFLAG} $* -R -i -f - 2>&1 >> $LOGFILE
     done
     exit $?
 fi
@@ -130,14 +129,15 @@ if [ ! -z "$FILEPATH" ]; then
     if [ -x /usr/bin/find ]; then
 	/usr/bin/find "$FILEPATH" \
 	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o -print0 | \
-	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
+	    ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
     else
-	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
+	${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
     fi
     return
 fi
+[ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
 LogReadOnly
-${SETFILES} -q ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
+${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
 rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
 find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
 find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
@@ -193,10 +193,15 @@ case "$1" in
 esac
 }
 usage() {
-      	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
-	echo or
-      	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
-      	echo $"Usage: $0 onboot"
+      	echo $"""
+Usage: $0 [-F] [-l logfile ] { check | restore| [-f] relabel | verify } [[dir/file] ... ] 
+or
+Usage: $0 [-F] -R rpmpackage[,rpmpackage...] [-l logfile ] { check | restore | verify }
+or
+Usage: $0 [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
+or
+Usage: $0 onboot
+"""
 }
 
 if [ $# = 0 ]; then
@@ -205,7 +210,7 @@ if [ $# = 0 ]; then
 fi
 
 # See how we were called.
-while getopts "C:Ffo:R:l:" i; do
+while getopts "C:FfR:l:" i; do
     case "$i" in
 	f)
 		fullFlag=1
@@ -213,9 +218,6 @@ while getopts "C:Ffo:R:l:" i; do
         R)
 		RPMFILES=$OPTARG
 		;;
-        o)
-		OUTFILES=$OPTARG
-		;;
         l)
 		LOGFILE=$OPTARG
 		;;
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 307ea4c..dfe8aa9 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -3,11 +3,18 @@
 fixfiles \- fix file SELinux security contexts.
 
 .SH "SYNOPSIS"
-.B fixfiles [-F] [ -R rpmpackagename[,rpmpackagename...] ] [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] [-o outputfile ] { check | restore | [-F] relabel | verify }"
 
-.B fixfiles [-F] [-l logfile ] [-o outputfile ] { check | restore|[-f] relabel | verify } [[dir/file] ... ] 
+.B fixfiles 
+.I [-F] [-l logfile ] { check | restore|[-f] relabel | verify } [[dir/file] ... ] 
 
-.B fixfiles onboot
+.B fixfiles 
+.I [-F] [ -R rpmpackagename[,rpmpackagename...] ] [-l logfile ] { check | restore | verify }
+
+.B fixfiles 
+.I [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] { check | restore | verify }
+
+.B fixfiles 
+.I onboot
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -31,10 +38,6 @@ will setup the machine to relabel on the next reboot.
 .B -l logfile
 Save the output to the specified logfile
 .TP 
-.B -o outputfile
-Save all files that have file_context that differs from the default, in outputfile.
-
-.TP 
 .B -F
 Force  reset  of  context to match file_context for customizable files
 

--------------030409080700030409010903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
