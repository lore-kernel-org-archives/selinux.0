Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91GGCR6017901
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 12:16:12 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E3A60561235
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:15:33 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Oct 2017 18:15:14 +0200
Message-Id: <20171001161517.16407-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/4] gui: remove the status bar
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The status bar of system-config-selinux's main window is not used and
takes some room. Remove it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/system-config-selinux.ui | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/gui/system-config-selinux.ui b/gui/system-config-selinux.ui
index c3f261a10d8d..7cc1cc532a1f 100644
--- a/gui/system-config-selinux.ui
+++ b/gui/system-config-selinux.ui
@@ -1862,25 +1862,6 @@ Level</property>
             <property name="position">1</property>
           </packing>
         </child>
-        <child>
-          <object class="GtkStatusbar">
-            <property name="visible">True</property>
-            <property name="can_focus">False</property>
-            <property name="margin_left">10</property>
-            <property name="margin_right">10</property>
-            <property name="margin_start">10</property>
-            <property name="margin_end">10</property>
-            <property name="margin_top">6</property>
-            <property name="margin_bottom">6</property>
-            <property name="orientation">vertical</property>
-            <property name="spacing">2</property>
-          </object>
-          <packing>
-            <property name="expand">False</property>
-            <property name="fill">False</property>
-            <property name="position">2</property>
-          </packing>
-        </child>
       </object>
     </child>
     <child type="titlebar">
-- 
2.14.2
