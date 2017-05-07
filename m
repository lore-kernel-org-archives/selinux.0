Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HU022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so4782987wrc.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:53 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 08/10] policycoreutils: fixfiles: remove bad modes of
 "relabel" command
Date: Sun,  7 May 2017 12:05:54 +0100
Message-Id: <20170507110556.7740-8-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

* `fixfiles -B relabel` or `fixfiles -C previouscontext relabel` would
  skip the code that handles e.g. `/var/tmp`, which would be run by
  `fixfiles relabel`.  It would still remove all files in /tmp (subject to
  user confirmation).  This is confusing, undocumented, and unlikely to
  be intentional.

* `fixfiles relabel path1 path2` is the same, except it would only relabel
  the first path.

* `fixfiles -R ... relabel` was equivalent to `fixfiles -R ... restore`,
  again contradicting the man page.

Also `fixfiles onboot` would ignore paths, -C, or -R.

fixfiles is mostly for users, where it should be acceptable to remove these
non-sensical combinations.

`fixfiles -C` is used in selinux-policy rpm install scripts.  However I
believe the rpms used `fixfiles -C previouscontext restore`, and did not
either require user interaction or blow away /tmp without prompting.  So
they should still work fine.

With these combinations removed, we can remove the `exit` calls which were
seen in some of the (non-error) code paths in `restore()`.
---
 policycoreutils/scripts/fixfiles   | 26 +++++++++++++++-----------
 policycoreutils/scripts/fixfiles.8 |  7 +++++--
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index df70b27..ce4a01a 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -216,11 +216,11 @@ shift
 case "$RESTORE_MODE" in
     PREFC)
 	diff_filecontext $*
-	exit $?
+	return
     ;;
     BOOTTIME)
 	newer $BOOTTIME $*
-	exit $?
+	return
     ;;
 esac
 
@@ -234,11 +234,9 @@ case "$RESTORE_MODE" in
 	for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
 	    rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f -
 	done
-	exit $?
     ;;
     FILEPATH)
 	${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH"
-	return  # to loop over each FILEPATH
     ;;
     DEFAULT)
 	if [ -n "${FILESYSTEMSRW}" ]; then
@@ -261,7 +259,6 @@ case "$RESTORE_MODE" in
 	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/tmp {} \;
 	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/run {} \;
 	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /lib {} \;
-	exit 0
     ;;
 esac
 }
@@ -269,17 +266,19 @@ esac
 fullrelabel() {
     echo "Cleaning out /tmp"
     find /tmp/ -mindepth 1 -delete
-    LogReadOnly
     restore Relabel
 }
 
+
 relabel() {
-    if [ "$RESTORE_MODE" == RPMFILES ]; then
-	restore Relabel
+    if [ "$RESTORE_MODE" != DEFAULT ]; then
+	usage
+	exit 1
     fi
 
     if [ $fullFlag == 1  ]; then
 	fullrelabel
+	return
     fi
 
     echo -n "
@@ -306,6 +305,10 @@ case "$1" in
     verify) restore Verify -n;;
     relabel) relabel;;
     onboot)
+	if [ "$RESTORE_MODE" != DEFAULT ]; then
+	    usage
+	    exit 1
+	fi
 	> /.autorelabel
 	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
 	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
@@ -320,9 +323,11 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] { check | restore | [-f] relabel | verify } dir/file ...
+Usage: $0 [-v] [-F] [-f] relabel
+or
+Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | verify }
 or
-Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | [-f] relabel | verify }
+Usage: $0 [-v] [-F] { check | restore | verify } dir/file ...
 or
 Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
@@ -408,4 +413,3 @@ else
     process "$command"
 fi
 
-exit $?
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 7a00bc3..9f447f0 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -6,10 +6,13 @@ fixfiles \- fix file SELinux security contexts.
 .na
 
 .B fixfiles
-.I [\-v] [\-F] { check | restore | [\-f] relabel | verify } dir/file ...
+.I [\-v] [\-F] [\-f] relabel
 
 .B fixfiles
-.I [\-v] [\-F] [\-B | \-N time ] { check | restore | [\-f] relabel | verify }
+.I [\-v] [\-F] { check | restore | verify } dir/file ...
+
+.B fixfiles
+.I [\-v] [\-F] [\-B | \-N time ] { check | restore | verify }
 
 .B fixfiles 
 .I [\-v] [\-F] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
-- 
2.9.3
