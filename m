Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2QEaOYH010241
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 10:36:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so5555402wrx.0
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 07:36:20 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 1/2] policycoreutils: fixfiles should handle path arguments
 more robustly
Date: Sun, 26 Mar 2017 15:35:50 +0100
Message-Id: <20170326143551.9407-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

E.g. `fixfiles restore -v /usr` - before:

Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
Progress and Verbose mutually exclusive
usage:  /sbin/restorecon [-iFnprRv0] [-e excludedir] pathname...
usage:  /sbin/restorecon [-iFnprRv0] [-e excludedir] -f filename
Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
229k

after:

Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
/sbin/restorecon:  lstat(-v) failed:  No such file or directory
Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
229k

This matches the usage shown in the manual page.  While we're in there,
we should handle spaces as well e.g `fixfiles restore "a b"`.  Before:

Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
/sbin/restorecon:  lstat(b) failed:  No such file or directory

After:

Warning: Skipping the following R/O filesystems:
/sys/fs/cgroup
/sbin/restorecon:  lstat(a b) failed:  No such file or directory

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/scripts/fixfiles | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 3896d19..d3a53ba 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -248,7 +248,7 @@ if [ ! -z "$RPMFILES" ]; then
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* $FILEPATH 2>&1 | cat >> $LOGFILE
+    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" 2>&1 | cat >> $LOGFILE
     return
 fi
 if [  -n "${FILESYSTEMSRW}" ]; then
@@ -400,7 +400,7 @@ else
 	process $command
     else
 	while [ -n "$1" ]; do
-	    FILEPATH=$1
+	    FILEPATH="$1"
 	    process $command
 	    shift
 	done
-- 
2.9.3
