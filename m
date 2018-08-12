Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKQ8KI017820
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:26:08 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5C02C564728
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:19 +0200
Message-Id: <20180812202522.3743-11-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 10/13] python/sepolicy: fix "procotol" misspelling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

procotol -> protocol

This issue has been found using flake8. This Python linter reported:

    python/sepolicy/sepolicy/gui.py:2525:132: F821 undefined name 'procotol'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/gui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 16f24a0ab2f9..6933f6a142ed 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -2522,7 +2522,7 @@ class SELinuxGui():
                     if self.cur_dict[k][(port, protocol)]["action"] == "-d":
                         update_buffer += "port -d -p %s %s\n" % (protocol, port)
                     else:
-                        update_buffer += "port %s -t %s -p %s %s\n" % (self.cur_dict[k][f]["action"], self.cur_dict[k][f]["type"], procotol, port)
+                        update_buffer += "port %s -t %s -p %s %s\n" % (self.cur_dict[k][f]["action"], self.cur_dict[k][f]["type"], protocol, port)
 
         return update_buffer
 
-- 
2.18.0
