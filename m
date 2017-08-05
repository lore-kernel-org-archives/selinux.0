Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75Gc1vV006997
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:01 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 59FF056497D
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:37:51 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:46 +0200
Message-Id: <20170805163750.1920-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170805163750.1920-1-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/6] sepolicy: do not fail when file_contexts.local
 does not exist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running "sepolicy manpage" on a system without file_contexts.local,
the command fails with:

    FileNotFoundError: [Errno 2] No such file or directory:
    '//etc/selinux/refpolicy/contexts/files/file_contexts.local'

Verify that the file exists before using it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 5cfc0715bc90..62158864b7cd 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -573,9 +573,10 @@ def get_fcdict(fc_path=selinux.selinux_file_context_path()):
     fc += fd.readlines()
     fd.close()
     fcdict = {}
-    fd = open(fc_path + ".local", "r")
-    fc += fd.readlines()
-    fd.close()
+    if os.path.exists(fc_path + ".local"):
+        fd = open(fc_path + ".local", "r")
+        fc += fd.readlines()
+        fd.close()
 
     for i in fc:
         rec = i.split()
-- 
2.13.3
