Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44H2g4d022709
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:02:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so4699667wmi.2
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:02:07 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 4/6] policycoreutils: fixfiles: fix logging about R/O
 filesystems
Date: Thu,  4 May 2017 18:01:20 +0100
Message-Id: <20170504170122.26882-4-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The LogReadOnly() call which warns the user about R/O filesystems, applies
to the `-B` mode (newer() function), and the `fixfiles check` mode
(no paths).

Make sure to print it for these modes, and these modes only.
---
 policycoreutils/scripts/fixfiles | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index dae073d..01bf97c 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -136,16 +136,27 @@ if [ -n $LOGFILE ]; then
     echo $1 >> $LOGFILE
 fi
 }
+
+#
+# Log all Read Only file systems
+#
+LogReadOnly() {
+if [ ! -z "$FILESYSTEMSRO" ]; then
+    logit "Warning: Skipping the following R/O filesystems:"
+    logit "$FILESYSTEMSRO"
+fi
+}
+
 #
 # Find files newer then the passed in date and fix the label
 #
 newer() {
     DATE=$1
     shift
+    LogReadOnly
     for m in `echo $FILESYSTEMSRW`; do
 	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} $* -i -0 -f -
     done;
-
 }
 
 #
@@ -192,15 +203,6 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
-#
-# Log all Read Only file systems
-#
-LogReadOnly() {
-if [ ! -z "$FILESYSTEMSRO" ]; then
-    logit "Warning: Skipping the following R/O filesystems:"
-    logit "$FILESYSTEMSRO"
-fi
-}
 
 rpmlist() {
 rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
@@ -224,9 +226,8 @@ if [ ! -z "$BOOTTIME" ]; then
     exit $?
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
-LogReadOnly
-#
-exclude_dirs="`exclude_dirs_from_relabelling $OPTION`"
+
+exclude_dirs="`exclude_dirs_from_relabelling`"
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
 	rpmlist $i | ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
@@ -238,6 +239,7 @@ if [ ! -z "$FILEPATH" ]; then
     return
 fi
 if [  -n "${FILESYSTEMSRW}" ]; then
+    LogReadOnly
     echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
     ${SETFILES} ${VERBOSE} $exclude_dirs -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} >>$LOGFILE 2>&1
 else
-- 
2.9.3
