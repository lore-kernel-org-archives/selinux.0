Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JmZoP007487
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:48:38 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 692F2561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:00 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:22 +0200
Message-Id: <20180804194734.12577-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 01/13] libselinux: fix flake8 warnings in SWIG-generated code
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

flake8, a Python linter, complains:

    libselinux/src/selinux.py:100:1: F401 'errno' imported but unused
    libselinux/src/selinux.py:100:1: F401 'stat' imported but unused
    libselinux/src/selinux.py:100:14: E401 multiple imports on one line
    libselinux/src/selinux.py:130:16: E111 indentation is not a multiple of four
    libselinux/src/selinux.py:130:45: E231 missing whitespace after ','

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinuxswig_python.i | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index be17ceffe01f..2af7c7e0c038 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -13,7 +13,8 @@
 
 %pythoncode %{
 
-import shutil, os, errno, stat
+import shutil
+import os
 
 DISABLED = -1
 PERMISSIVE = 0
@@ -43,7 +44,7 @@ def chcon(path, context, recursive=False):
     if recursive:
         for root, dirs, files in os.walk(path):
             for name in files + dirs:
-               lsetfilecon(os.path.join(root,name), context)
+                lsetfilecon(os.path.join(root, name), context)
 
 def copytree(src, dest):
     """ An SELinux-friendly shutil.copytree method """
-- 
2.18.0
