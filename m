Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4CChLnd022657
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 08:43:21 -0400
Received: by mail-wm0-f44.google.com with SMTP id t11-v6so6488028wmt.0
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 05:43:17 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Date: Sat, 12 May 2018 13:43:09 +0100
Message-Id: <20180512124309.26362-1-alan.christopher.jenkins@gmail.com>
Subject: [PATCH] policycoreutils: fixfiles: failure to create
 /.autorelabel is fatal
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following ambiguous output (from booting with init=/bin/sh):

    # /usr/sbin/fixfiles onboot
    /usr/sbin/fixfiles: line 313: /.autorelabel: Read-only file system
    /usr/sbin/fixfiles: line 317: /.autorelabel: Read-only file system
    System will relabel on next boot

System will not relabel on next boot if we couldn't create ./autorelabel

(In case anyone reading this description is still confused: To run
`fixfiles onboot` after booting with init=/bin/sh, you must first run
`mount / -oremount,rw`).
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 0eeeea46..69bd8488 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -309,7 +309,7 @@ case "$1" in
 	    usage
 	    exit 1
 	fi
-	> /.autorelabel
+	> /.autorelabel || exit $?
 	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
 	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
 	# Force full relabel if / does not have a label on it
-- 
2.17.0
