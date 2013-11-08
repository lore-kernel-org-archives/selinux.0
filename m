From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 01/08] Call proper dbus function
Date: Fri,  8 Nov 2013 08:17:28 -0500
Message-Id: <1383916655-9354-2-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/sepolicy/sepolicy/gui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 0123e6c..94ddb72 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -2727,7 +2727,7 @@ class SELinuxGui():
         if not active and not exists:
             return
         try:
-            self.dbus.relabel_on_boots(active)
+            self.dbus.relabel_on_boot(active)
         except dbus.exceptions.DBusException, e:
             self.error(e)
 
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
