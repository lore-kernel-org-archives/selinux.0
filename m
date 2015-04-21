Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3LBlAop024507
 for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2015 07:47:10 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 25C528F004
 for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2015 11:46:57 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: selinux.py - use os.walk() instead of
 os.path.walk()
Date: Tue, 21 Apr 2015 13:46:49 +0200
Message-Id: <1429616809-5417-1-git-send-email-plautrba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?UTF-8?q?Miro=20Hron=C4=8Dok?= <mhroncok@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Miro Hrončok <mhroncok@redhat.com>

os.path.walk() function is deprecated and has been removed in Python 3

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

A simple fix which allows to use same construction in Python 2 and Python 3.
It's reported and proposed in https://bugzilla.redhat.com/show_bug.cgi?id=1195004


 libselinux/src/selinuxswig_python.i | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index ae72246..c9a2341 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -31,9 +31,9 @@ def restorecon(path, recursive=False):
             lsetfilecon(path, context)
 
         if recursive:
-            os.path.walk(path, lambda arg, dirname, fnames:
-                             map(restorecon, [os.path.join(dirname, fname)
-                                              for fname in fnames]), None)
+            for root, dirs, files in os.walk(path):
+                for name in files + dirs:
+                   restorecon(os.path.join(root, name))
 
 def chcon(path, context, recursive=False):
     """ Set the SELinux context on a given path """
-- 
2.3.5
