Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4KIJMpY014609
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2013 14:19:22 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH] Properly build the swig exception file even if the headers are missing
Date: Mon, 20 May 2013 20:18:45 +0200
Message-Id: <1369073925-4446-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

During build if the headers are not installed in the system path, the
generated swig exception (.i) file might be empty.
---
 libselinux/src/exception.sh  | 2 +-
 libsemanage/src/exception.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index c3e61a5..b7cff7e09 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -15,6 +15,6 @@ echo "
 ;;
 esac
 }
-gcc -x c -c - -aux-info temp.aux < ../include/selinux/selinux.h
+gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
 for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
 rm -f -- temp.aux -.o
diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
index 8693fb7..94619d2 100644
--- a/libsemanage/src/exception.sh
+++ b/libsemanage/src/exception.sh
@@ -9,6 +9,6 @@ echo "
 }
 "
 }
-gcc -x c -c - -aux-info temp.aux < ../include/semanage/semanage.h
+gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
 for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
 rm -f -- temp.aux -.o
-- 
1.8.3.rc2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
