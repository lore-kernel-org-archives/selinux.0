From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 04/08] Fix up desktop files to match current standards
Date: Fri,  8 Nov 2013 08:17:31 -0500
Message-Id: <1383916655-9354-5-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Encoding is depracated
Keywords is depracated

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/gui/selinux-polgengui.desktop     | 1 -
 policycoreutils/gui/system-config-selinux.desktop | 1 -
 policycoreutils/restorecond/restorecond.desktop   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/policycoreutils/gui/selinux-polgengui.desktop b/policycoreutils/gui/selinux-polgengui.desktop
index 0c2f399..bbcb18f 100644
--- a/policycoreutils/gui/selinux-polgengui.desktop
+++ b/policycoreutils/gui/selinux-polgengui.desktop
@@ -64,4 +64,3 @@ Type=Application
 Terminal=false
 Categories=System;Security;
 X-Desktop-File-Install-Version=0.2
-Keywords=policy;security;selinux;avc;permission;mac;
diff --git a/policycoreutils/gui/system-config-selinux.desktop b/policycoreutils/gui/system-config-selinux.desktop
index 8822ce2..befdb23 100644
--- a/policycoreutils/gui/system-config-selinux.desktop
+++ b/policycoreutils/gui/system-config-selinux.desktop
@@ -64,4 +64,3 @@ Type=Application
 Terminal=false
 Categories=System;Security;
 X-Desktop-File-Install-Version=0.2
-Keywords=policy;security;selinux;avc;permission;mac;
diff --git a/policycoreutils/restorecond/restorecond.desktop b/policycoreutils/restorecond/restorecond.desktop
index 89201e1..af72868 100644
--- a/policycoreutils/restorecond/restorecond.desktop
+++ b/policycoreutils/restorecond/restorecond.desktop
@@ -2,7 +2,6 @@
 Name=File Context maintainer
 Exec=/usr/sbin/restorecond -u
 Comment=Fix file context in owned by the user
-Encoding=UTF-8
 Type=Application
 StartupNotify=false
 X-GNOME-Autostart-enabled=false
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
