Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MDTfAA025096
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 08:29:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A2A08425E
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 13:29:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DEBA213AEE2
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 13:29:38 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 22 Feb 2018 14:29:33 +0100
Message-Id: <20180222132933.5643-1-vmojzis@redhat.com>
Subject: [PATCH] gui/semanagePage: Close "edit" and "add" dialogues
 when successfull
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"Edit" and "add" dialogues weren't closed after successful transaction
("add" and "edit" methods return "None" if successful).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/semanagePage.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gui/semanagePage.py b/gui/semanagePage.py
index 560ec077..4127804f 100644
--- a/gui/semanagePage.py
+++ b/gui/semanagePage.py
@@ -140,7 +140,7 @@ class semanagePage:
 
         while self.dialog.run() == Gtk.ResponseType.OK:
             try:
-                if not self.add():
+                if self.add() is False:
                     continue
                 break
             except ValueError as e:
@@ -153,7 +153,7 @@ class semanagePage:
         self.dialog.set_position(Gtk.WindowPosition.MOUSE)
         while self.dialog.run() == Gtk.ResponseType.OK:
             try:
-                if not self.modify():
+                if self.modify() is False:
                     continue
                 break
             except ValueError as e:
-- 
2.14.3
