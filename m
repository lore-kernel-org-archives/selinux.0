Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAT99NXV011294
 for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2016 04:09:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE55D80083
 for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2016 09:09:20 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/sepolicy/gui: fix current selinux state
 radiobutton
Date: Tue, 29 Nov 2016 10:09:00 +0100
Message-Id: <1480410540-5192-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Radiobutton was always set to "Permissive" and couldn't be switched.
Update radiobutton together with status text in bottom left corner.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index ee78e0c..3c5a9d2 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -2609,9 +2609,10 @@ class SELinuxGui():
     def set_enforce_text(self, value):
         if value:
             self.status_bar.push(self.context_id, _("System Status: Enforcing"))
+            self.current_status_enforcing.set_active(True)
         else:
             self.status_bar.push(self.context_id, _("System Status: Permissive"))
-        self.current_status_permissive.set_active(True)
+            self.current_status_permissive.set_active(True)
 
     def set_enforce(self, button):
         self.dbus.setenforce(button.get_active())
-- 
2.7.4
