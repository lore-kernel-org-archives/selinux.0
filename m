Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKR6JN017836
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:27:09 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B83AD564728
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:03 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:18 +0200
Message-Id: <20180812202522.3743-10-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 09/13] python/sepolgen: use self when accessing
 members in FilesystemUse
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This silences the following flake8 errors:

    python/sepolgen/src/sepolgen/refpolicy.py:758:25: F821 undefined name 'XATTR'
    python/sepolgen/src/sepolgen/refpolicy.py:760:27: F821 undefined name 'TRANS'
    python/sepolgen/src/sepolgen/refpolicy.py:762:27: F821 undefined name 'TASK'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/refpolicy.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index c30a8c70f9ca..e3dd33a21935 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -755,11 +755,11 @@ class FilesystemUse(Leaf):
 
     def to_string(self):
         s = ""
-        if self.type == XATTR:
+        if self.type == self.XATTR:
             s = "fs_use_xattr "
-        elif self.type == TRANS:
+        elif self.type == self.TRANS:
             s = "fs_use_trans "
-        elif self.type == TASK:
+        elif self.type == self.TASK:
             s = "fs_use_task "
 
         return "%s %s %s;" % (s, self.filesystem, str(self.context))
-- 
2.18.0
