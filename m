Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44H2g4c022709
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:02:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so4687230wmb.1
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:01:57 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 1/6] Revert "policycoreutils: let output of `fixfiles` be
 redirected (as normal)"
Date: Thu,  4 May 2017 18:01:17 +0100
Message-Id: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This reverts commit ac7899fc3ad6221e195dd13cdf14b346897314ae,
which is not yet part of an officially tagged release
(or release candidate).

`LOGFILE=/proc/self/fd/1` was wrong.

`LOGFILE=$(tty)` was being relied on in one case (exclude_dirs),
to log messages from a function run specifically with stdout redirected
(captured into a variable).

Having `logit "message"` break inside redirected functions
is a nasty leaky abstraction.

This caused e.g. `fixfiles restore` to terminate early with the error

    skipping: No such file or directory

if the user had configured any excluded paths in
/etc/selinux/fixfiles_exclude_dirs
---
 policycoreutils/scripts/fixfiles | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index bc74d69..75d7762 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -119,7 +119,11 @@ VERBOSE="-p"
 FORCEFLAG=""
 DIRS=""
 RPMILES=""
-LOGFILE=/proc/self/fd/1
+LOGFILE=`tty`
+if [ $? != 0 ]; then
+    LOGFILE="/dev/null"
+fi
+LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
@@ -134,11 +138,11 @@ else
 fi
 
 #
-# Write to LOGFILE
+# Log to either syslog or a LOGFILE
 #
 logit () {
 if [ -n $LOGFILE ]; then
-    echo $1 >> "$LOGFILE"
+    echo $1 >> $LOGFILE
 fi
 }
 #
-- 
2.9.3
