Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3CKplW4014628
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 16:51:47 -0400
Date: Tue, 12 Apr 2016 23:51:41 +0300
From: Oskari Saarenmaa <os@aiven.io>
To: selinux@tycho.nsa.gov
Subject: [PATCH] fixfiles: make sure $LOGFILE starts with a slash
Message-ID: <20160412205141.GA15479@saarenmaa.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

`tty` may output a (localized) "not a tty" message to stdout and exit with a
zero status in case ttyname(3) returns NULL but isatty(3) returns success. 
This happens at least when stdin is connected to a tty but we're inside a
chroot with no access to the tty file.

This results in an error:

    /usr/sbin/fixfiles: line 257: $LOGFILE: ambiguous redirect

Handle `tty` results that don't start with a slash the same way as no tty
errors: point $LOGFILE to /dev/null.

Signed-off-by: Oskari Saarenmaa <os@aiven.io>
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 5c29eb9..1c64191 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -120,7 +120,7 @@ FORCEFLAG=""
 DIRS=""
 RPMILES=""
 LOGFILE=`tty`
-if [ $? != 0 ]; then
+if [ $? != 0 -o ${LOGFILE:0:1} != "/" ]; then
     LOGFILE="/dev/null"
 fi
 LOGGER=/usr/sbin/logger
-- 
2.5.5
