Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w53GQPEd020850
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 12:26:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40zNjq6hhxz1pF1C
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:26:23 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40zNjp6Srtz1pF1M
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 309B956470B
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 18:26:17 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Jun 2018 18:25:38 +0200
Message-Id: <20180603162541.28136-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/4] python/sepolgen: fix typo in PathChoooser name
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/defaults.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
index 9591063989ad..199acfafe4cf 100644
--- a/python/sepolgen/src/sepolgen/defaults.py
+++ b/python/sepolgen/src/sepolgen/defaults.py
@@ -22,7 +22,7 @@ import re
 
 # Select the correct location for the development files based on a
 # path variable (optionally read from a configuration file)
-class PathChoooser(object):
+class PathChooser(object):
     def __init__(self, pathname):
         self.config = dict()
         if not os.path.exists(pathname):
@@ -68,10 +68,10 @@ def attribute_info():
     return data_dir() + "/attribute_info"
 
 def refpolicy_makefile():
-    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
+    chooser = PathChooser("/etc/selinux/sepolgen.conf")
     return chooser("Makefile")
 
 def headers():
-    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
+    chooser = PathChooser("/etc/selinux/sepolgen.conf")
     return chooser("include")
 
-- 
2.17.1
