Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELvVpO027952
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:57:31 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 45EF85649BA
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:57:29 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux,libsemanage: fall back to gcc in exception.sh
Date: Mon, 14 Nov 2016 22:57:11 +0100
Message-Id: <20161114215712.18962-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang does not support -aux-info option. When exception.sh is run with
CC=clang, use gcc to build selinuxswig_python_exception.i and
semanageswig_python_exception.i.

This does not solve the issue of building libselinux and libsemanage
Python wrappers on a system without gcc. However parsing the result of
"gcc -aux-info" is easier than parsing the header files so stay with
this command at least for now.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/exception.sh  | 6 +++++-
 libsemanage/src/exception.sh | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index a58bf3f45778..a3ff83235ced 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -15,6 +15,10 @@ echo "
 ;;
 esac
 }
-${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+then
+    # clang does not support -aux-info so fall back to gcc
+    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+fi
 for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
 rm -f -- temp.aux -.o
diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
index d18959cbe85d..a4095f4f8ba6 100644
--- a/libsemanage/src/exception.sh
+++ b/libsemanage/src/exception.sh
@@ -9,6 +9,10 @@ echo "
 }
 "
 }
-${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+then
+    # clang does not support -aux-info so fall back to gcc
+    gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+fi
 for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
 rm -f -- temp.aux -.o
-- 
2.10.2
