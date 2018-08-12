Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKQ8KJ017820
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:26:08 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id EC860564728
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:20 +0200
Message-Id: <20180812202522.3743-12-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 11/13] python/sepolicy: use variables which exist
 in the gui.py
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some function used variables which were not defined when populating
self.cur_dict with an operation. Fix this, even though the old values do
not seem to be used.

This issue has been found using flake8. This Python linter reported:

    python/sepolicy/sepolicy/gui.py:2020:101: F821 undefined name 'oldsetype'
    python/sepolicy/sepolicy/gui.py:2020:122: F821 undefined name 'oldmls'
    python/sepolicy/sepolicy/gui.py:2020:142: F821 undefined name 'oldclass'
    python/sepolicy/sepolicy/gui.py:2050:133: F821 undefined name 'oldmls'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/gui.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 6933f6a142ed..9d413652f2ed 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -2015,9 +2015,9 @@ class SELinuxGui():
         if self.modify:
             iter = self.get_selected_iter()
             oldpath = self.unmark(self.liststore.get_value(iter, 0))
-            setype = self.unmark(self.liststore.set_value(iter, 1))
+            oldsetype = self.unmark(self.liststore.set_value(iter, 1))
             oldtclass = self.liststore.get_value(iter, 2)
-            self.cur_dict["fcontext"][(path, tclass)] = {"action": "-m", "type": setype, "oldtype": oldsetype, "oldmls": oldmls, "oldclass": oldclass}
+            self.cur_dict["fcontext"][(path, tclass)] = {"action": "-m", "type": setype, "oldtype": oldsetype, "oldpath": oldpath, "oldclass": oldtclass}
         else:
             iter = self.liststore.append(None)
             self.cur_dict["fcontext"][(path, tclass)] = {"action": "-a", "type": setype}
@@ -2047,7 +2047,7 @@ class SELinuxGui():
             oldports = self.unmark(self.liststore.get_value(iter, 0))
             oldprotocol = self.unmark(self.liststore.get_value(iter, 1))
             oldsetype = self.unmark(self.liststore.set_value(iter, 2))
-            self.cur_dict["port"][(ports, protocol)] = {"action": "-m", "type": setype, "mls": mls, "oldtype": oldsetype, "oldmls": oldmls, "oldprotocol": oldprotocol, "oldports": oldports}
+            self.cur_dict["port"][(ports, protocol)] = {"action": "-m", "type": setype, "mls": mls, "oldtype": oldsetype, "oldprotocol": oldprotocol, "oldports": oldports}
         else:
             iter = self.liststore.append(None)
             self.cur_dict["port"][(ports, protocol)] = {"action": "-a", "type": setype, "mls": mls}
-- 
2.18.0
