Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u79FBNji015497
 for <selinux@tycho.nsa.gov>; Tue, 9 Aug 2016 11:11:23 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 119B97DD39
 for <selinux@tycho.nsa.gov>; Tue,  9 Aug 2016 13:24:31 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: 'fixfiles check' should not change anything
Date: Tue,  9 Aug 2016 15:24:15 +0200
Message-Id: <1470749055-22365-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-n was not being passed down to restorecon properly in the code path
for -C and -N

Patch-by: Dan Callaghan <dcallagh@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/scripts/fixfiles | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 5c29eb9..fa43a53 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -150,8 +150,9 @@ fi
 #
 newer() {
     DATE=$1
+    shift
     for m in `echo $FILESYSTEMSRW`; do
-	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} -i -0 -f -
+	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} $* -i -0 -f -
     done;
 
 }
@@ -190,7 +191,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac; \
 	       fi; \
 	    done | \
-	${RESTORECON} ${VERBOSE} -i -f - -R `exclude_dirs`; \
+	${RESTORECON} ${VERBOSE} -i -f - -R $* `exclude_dirs`; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -222,7 +223,7 @@ if [ ! -z "$PREFC" ]; then
     exit $?
 fi
 if [ ! -z "$BOOTTIME" ]; then
-    newer $BOOTTIME
+    newer $BOOTTIME $*
     exit $?
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
-- 
1.8.3.1
