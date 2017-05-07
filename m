Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HR022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so4782115wrc.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:30 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 02/10] policycoreutils: fixfiles: remove two unused variables
Date: Sun,  7 May 2017 12:05:48 +0100
Message-Id: <20170507110556.7740-2-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

DIRS was suspicious because you can't store file names in a normal variable,
and it's not that common to use arrays in bash.  It's not actually used.

While we're here, there's another variable which is never used
and should just be removed.  (Pointed out by `shellcheck`.
It makes a couple of other points too, but I have more specific
patches I want to put those in).
---
 policycoreutils/scripts/fixfiles | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index e416dfc..da79f47 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -107,13 +107,11 @@ fullFlag=0
 BOOTTIME=""
 VERBOSE="-p"
 FORCEFLAG=""
-DIRS=""
 RPMILES=""
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
 FILESYSTEMSRO=`get_ro_labeled_mounts`
-FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
@@ -373,7 +371,7 @@ fi
 shift
 
 #
-# check if they specified both DIRS and RPMFILES
+# check if they specified both RPMFILES and FILEPATHs
 #
 
 if [ ! -z "$RPMFILES" ]; then
-- 
2.9.3
