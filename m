Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91GFmbh017694
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 12:15:48 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0C9BD561238
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:15:40 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Oct 2017 18:15:16 +0200
Message-Id: <20171001161517.16407-3-nicolas.iooss@m4x.org>
In-Reply-To: <20171001161517.16407-1-nicolas.iooss@m4x.org>
References: <20171001161517.16407-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/4] gui: delete overridden definition of usersPage.delete()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Function delete() is defined twice in class usersPage and the first one
invoke semanagePage.delete(), which does not exist.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/usersPage.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/gui/usersPage.py b/gui/usersPage.py
index 9d09bda2171f..26794ed5c3f3 100644
--- a/gui/usersPage.py
+++ b/gui/usersPage.py
@@ -91,10 +91,6 @@ class usersPage(semanagePage):
             self.store.set_value(iter, 2, dict[k][3])
         self.view.get_selection().select_path((0,))
 
-    def delete(self):
-        if semanagePage.delete(self) == Gtk.ResponseType.NO:
-            return None
-
     def dialogInit(self):
         store, iter = self.view.get_selection().get_selected()
         self.selinuxUserEntry.set_text(store.get_value(iter, 0))
-- 
2.14.2
