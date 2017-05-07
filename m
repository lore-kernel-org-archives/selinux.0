Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HT022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so4753444wrc.3
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:45 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 06/10] policycoreutils: fixfiles: refactor into the `set -u`
 dialect
Date: Sun,  7 May 2017 12:05:52 +0100
Message-Id: <20170507110556.7740-6-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This commit allows the use of `set -u` to detect reads of unset variables.
But what I really liked was making the code more explicit about these
modes.  I hope that this is easier for a new reader to reason about.

`fixfiles restore` has accumulated five different modes it can run in.
Now use a single variable to indicate the mode, out-of-band of the
variables used for the individual modes.

Apparently `set -u` / `set -o nounset` doesn't work correctly with arrays.
If we ever need bash arrays, we can simply remove `set -u`.  The `set -u`
dialect is a strict subset.  See http://mywiki.wooledge.org/BashFAQ/112

Extra notes:

RESTORE_MODE was created because I couldn't bring myself to use an empty
FILEPATH, as a special case to indicate the default mode.  Arguments
to the script (paths) could be empty already, so it would mean I had to
work out how we behaved in that case and decide whether it was reasonable.

It turns out the `-B | -N time` mode is distinct and does not respect
paths.  So we can tell the user we're not going to do anything with the
paths they passed.  Make sure this distinction is shown in the usage error
message.

We already rejected the combination of `-R rpmpackage,... dir/file...`.
Being aware of the different modes just causes more bogus combinations
to be rejected.
---
 policycoreutils/scripts/fixfiles   | 164 ++++++++++++++++++++-----------------
 policycoreutils/scripts/fixfiles.8 |   7 +-
 2 files changed, 95 insertions(+), 76 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 1b173e6..df70b27 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -20,6 +20,8 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
+set -o nounset
+
 #
 # seclabel support was added in 2.6.30.  This function will return a positive
 # number if the current kernel version is greater than 2.6.30, a negative
@@ -107,7 +109,9 @@ fullFlag=0
 BOOTTIME=""
 VERBOSE="-p"
 FORCEFLAG=""
-RPMILES=""
+RPMFILES=""
+PREFC=""
+RESTORE_MODE="DEFAULT"
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
@@ -209,50 +213,57 @@ restore () {
 OPTION=$1
 shift
 
-if [ ! -z "$PREFC" ]; then
-    diff_filecontext $*
-    exit $?
-fi
-if [ ! -z "$BOOTTIME" ]; then
-    newer $BOOTTIME $*
-    exit $?
-fi
+case "$RESTORE_MODE" in
+    PREFC)
+	diff_filecontext $*
+	exit $?
+    ;;
+    BOOTTIME)
+	newer $BOOTTIME $*
+	exit $?
+    ;;
+esac
+
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
 
 EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
 LogExcluded
 
-if [ ! -z "$RPMFILES" ]; then
-    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f -
-    done
-    exit $?
-fi
-if [ ! -z "$FILEPATH" ]; then
-    ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH"
-    return
-fi
-if [  -n "${FILESYSTEMSRW}" ]; then
-    LogReadOnly
-    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW}
-else
-    echo >&2 "fixfiles: No suitable file systems found"
-fi
-if [ ${OPTION} != "Relabel" ]; then
-    return
-fi
-echo "Cleaning up labels on /tmp"
-rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
-
-UNDEFINED=`get_undefined_type` || exit $?
-UNLABELED=`get_unlabeled_type` || exit $?
-find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
-find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /tmp {} \;
-find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/tmp {} \;
-find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/run {} \;
-[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /lib {} \;
-exit 0
+case "$RESTORE_MODE" in
+    RPMFILES)
+	for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
+	    rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f -
+	done
+	exit $?
+    ;;
+    FILEPATH)
+	${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH"
+	return  # to loop over each FILEPATH
+    ;;
+    DEFAULT)
+	if [ -n "${FILESYSTEMSRW}" ]; then
+	    LogReadOnly
+	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
+	    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW}
+	else
+	    echo >&2 "fixfiles: No suitable file systems found"
+	fi
+	if [ ${OPTION} != "Relabel" ]; then
+	    return
+	fi
+	echo "Cleaning up labels on /tmp"
+	rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
+
+	UNDEFINED=`get_undefined_type` || exit $?
+	UNLABELED=`get_unlabeled_type` || exit $?
+	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
+	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /tmp {} \;
+	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/tmp {} \;
+	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/run {} \;
+	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /lib {} \;
+	exit 0
+    ;;
+esac
 }
 
 fullrelabel() {
@@ -263,7 +274,7 @@ fullrelabel() {
 }
 
 relabel() {
-    if [ ! -z "$RPMFILES" ]; then
+    if [ "$RESTORE_MODE" == RPMFILES ]; then
 	restore Relabel
     fi
 
@@ -309,7 +320,9 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | [-f] relabel | verify } [[dir/file] ... ]
+Usage: $0 [-v] [-F] { check | restore | [-f] relabel | verify } dir/file ...
+or
+Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | [-f] relabel | verify }
 or
 Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
@@ -319,39 +332,52 @@ Usage: $0 [-F] [-B] onboot
 """
 }
 
-if [ $# = 0 ]; then
+if [ $# -eq 0 ]; then
 	usage
 	exit 1
 fi
 
+set_restore_mode() {
+	if [ "$RESTORE_MODE" != DEFAULT ]; then
+		# can't specify two different modes
+		usage
+		exit 1
+	fi
+	RESTORE_MODE="$1"
+}
+
 # See how we were called.
 while getopts "N:BC:FfR:l:v" i; do
     case "$i" in
 	B)
 		BOOTTIME=`/bin/who -b | awk '{print $3}'`
+		set_restore_mode BOOTTIME
 		;;
-	f)
-		fullFlag=1
-		;;
-	v)
-		VERBOSE="-v"
+	N)
+		BOOTTIME=$OPTARG
+		set_restore_mode BOOTTIME
 		;;
 	R)
 		RPMFILES=$OPTARG
+		set_restore_mode RPMFILES
+		;;
+	C)
+		PREFC=$OPTARG
+		set_restore_mode PREFC
+		;;
+	v)
+		VERBOSE="-v"
 		;;
 	l)
 		# Old scripts use obsolete option `-l logfile`
 		echo "Redirecting output to $OPTARG"
 		exec >>"$OPTARG" 2>&1
 		;;
-	C)
-		PREFC=$OPTARG
-		;;
 	F)
 		FORCEFLAG="-F"
 		;;
-	N)
-		BOOTTIME=$OPTARG
+	f)
+		fullFlag=1
 		;;
 	*)
 	    usage
@@ -362,34 +388,24 @@ done
 shift $(( OPTIND - 1 ))
 
 # Check for the command
-command="$1"
-if [ -z "$command" ]; then
+if [ $# -eq 0 ]; then
     usage
     exit 1
 fi
+command="$1"
 
 # Move out command from arguments
 shift
 
-#
-# check if they specified both RPMFILES and FILEPATHs
-#
-
-if [ ! -z "$RPMFILES" ]; then
-    if [ $# -gt 0 ]; then
-	usage
-	exit 1
-    fi
-    process "$command"
+if [ $# -gt 0 ]; then
+    set_restore_mode FILEPATH
+    while [ $# -gt 0 ]; do
+	FILEPATH="$1"
+	process "$command" || exit $?
+	shift
+    done
 else
-    if [ -z "$1" ]; then
-	process "$command"
-    else
-	while [ -n "$1" ]; do
-	    FILEPATH="$1"
-	    process "$command" || exit $?
-	    shift
-	done
-    fi
+    process "$command"
 fi
+
 exit $?
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index c58cb7d..0ec18a8 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -5,8 +5,11 @@ fixfiles \- fix file SELinux security contexts.
 .SH "SYNOPSIS"
 .na
 
-.B fixfiles 
-.I [\-v] [\-F] [\-B | \-N time ] { check | restore | [\-f] relabel | verify } [[dir/file] ... ]
+.B fixfiles
+.I [\-v] [\-F] { check | restore | [\-f] relabel | verify } dir/file ...
+
+.B fixfiles
+.I [\-v] [\-F] [\-B | \-N time ] { check | restore | [\-f] relabel | verify }
 
 .B fixfiles 
 .I [\-v] [\-F] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
-- 
2.9.3
