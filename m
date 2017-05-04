Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44H2iik022714
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:02:44 -0400
Received: by mail-wr0-f176.google.com with SMTP id w50so11301269wrc.0
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:02:11 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 6/6] policycoreutils: fixfiles: deprecate -l option
Date: Thu,  4 May 2017 18:01:22 +0100
Message-Id: <20170504170122.26882-6-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

...and write log messages to standard output.

Some versions of fixfiles in 2004 created a logfile by default.
Apparently they also used `tee` to log to standard output at the same time.
We're also told that the logfile was implemented because there was too
much output generated for use on a tty, and it scrolled out of reach.

https://bugzilla.redhat.com/show_bug.cgi?id=131707

In the current version, none of these original reasons for `-l` remain.

The logfile is not created by default.  If no log file is specified,
messages are written to stdin [sic]... if and only stdin is a tty.  If
stdin is not a tty, the log defaults to /dev/null.

When a user runs fixfiles on a tty and finds there is too much output, she
is likely to try redirecting standard output and/or standard error using
the shell.  She will find this doesn't help, because fixfiles is writing
the verbose log messages to standard input.

I tried to fix the problem non-intrusively, by changing the default log
file to `/dev/stdout`.  Sadly, this breaks down where you have
`echo >>$LOGFILE "Log message"` inside a specific function, which is run
with output redirected in order to "return" a string value (captured
into a variable).  exclude_dirs_from_relabelling() was such a function.

I was trying to abstract over writing to both normal files and stdout, but
my abstraction "leaks" in a non-obvious way.

There is a simple solution.  We can write the log messages to standard
output.  When we are passed `-l` by a legacy script, we can redirect
standard output to the logfile.

This removes any distinctions between the logfile and "non-log" messages.
Some calls to restorecon were missing redirections to the log file.
"Cleaning out /tmp" was written to the log file, but "Cleaning out labels
on /tmp" was not.  There were no comments to explain these distinctions.
---
 policycoreutils/scripts/fixfiles | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 183efe9..c876432 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -109,11 +109,6 @@ VERBOSE="-p"
 FORCEFLAG=""
 DIRS=""
 RPMILES=""
-LOGFILE=`tty`
-if [ $? != 0 ]; then
-    LOGFILE="/dev/null"
-fi
-LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
@@ -128,21 +123,12 @@ else
 fi
 
 #
-# Log to either syslog or a LOGFILE
-#
-logit () {
-if [ -n $LOGFILE ]; then
-    echo $1 >> $LOGFILE
-fi
-}
-
-#
 # Log all Read Only file systems
 #
 LogReadOnly() {
 if [ ! -z "$FILESYSTEMSRO" ]; then
-    logit "Warning: Skipping the following R/O filesystems:"
-    logit "$FILESYSTEMSRO"
+    echo "Warning: Skipping the following R/O filesystems:"
+    echo "$FILESYSTEMSRO"
 fi
 }
 
@@ -151,7 +137,7 @@ fi
 #
 LogExcluded() {
 for i in ${EXCLUDEDIRS//-e / }; do
-    logit "skipping the directory $i"
+    echo "skipping the directory $i"
 done
 }
 
@@ -240,18 +226,18 @@ LogExcluded
 
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
+	rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f -
     done
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" >>$LOGFILE 2>&1
+    ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH"
     return
 fi
 if [  -n "${FILESYSTEMSRW}" ]; then
     LogReadOnly
     echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} >>$LOGFILE 2>&1
+    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW}
 else
     echo >&2 "fixfiles: No suitable file systems found"
 fi
@@ -272,7 +258,7 @@ exit 0
 }
 
 fullrelabel() {
-    logit "Cleaning out /tmp"
+    echo "Cleaning out /tmp"
     find /tmp/ -mindepth 1 -delete
     LogReadOnly
     restore Relabel
@@ -325,9 +311,9 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F]  [-N time ] [-l logfile ] { check | restore| [-f] relabel | verify } [[dir/file] ... ]
+Usage: $0 [-v] [-F] [-N time ] { check | restore| [-f] relabel | verify } [[dir/file] ... ]
 or
-Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] [-l logfile ] { check | restore | verify }
+Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
 Usage: $0 [-v] [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
 or
@@ -356,7 +342,9 @@ while getopts "N:BC:FfR:l:v" i; do
 		RPMFILES=$OPTARG
 		;;
 	l)
-		LOGFILE=$OPTARG
+		# Old scripts use obsolete option `-l logfile`
+		echo "Redirecting output to $OPTARG"
+		exec >>"$OPTARG" 2>&1
 		;;
 	C)
 		PREFC=$OPTARG
-- 
2.9.3
