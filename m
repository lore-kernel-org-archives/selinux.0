Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8ILYDVO029267
 for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2017 17:34:14 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E492856476F
 for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2017 23:32:52 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon, 18 Sep 2017 23:32:13 +0200
Message-Id: <20170918213213.23160-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] sepolicy: do not fail when file_contexts.local
 or .subs do not exist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On a system without any file context customizations, "sepolicy gui"
fails to load because it tries to read a non-existent file:

    FileNotFoundError: [Errno 2] No such file or directory:
    '/etc/selinux/refpolicy-git/contexts/files/file_contexts.local'

Once this issue is fixed, another one is triggered:

    FileNotFoundError: [Errno 2] No such file or directory:
    '/etc/selinux/refpolicy-git/contexts/files/file_contexts.subs

Use os.path.exists() to prevent trying to open non-existent files.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 03742346caf0..14d2ad634d7d 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -523,6 +523,8 @@ def find_entrypoint_path(exe, exclude_list=[]):
 
 
 def read_file_equiv(edict, fc_path, modify):
+    if not os.path.exists(fc_path):
+        return edict
     fd = open(fc_path, "r")
     fc = fd.readlines()
     fd.close()
@@ -555,6 +557,8 @@ def get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
     if local_files:
         return local_files
     local_files = []
+    if not os.path.exists(fc_path + ".local"):
+        return []
     fd = open(fc_path + ".local", "r")
     fc = fd.readlines()
     fd.close()
-- 
2.14.1
