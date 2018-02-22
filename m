Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MHpAIs024293
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 12:51:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 485914084FEC
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 17:50:49 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 22 Feb 2018 18:50:35 +0100
Message-Id: <20180222175035.22160-1-plautrba@redhat.com>
Subject: [PATCH] gui/polgengui.py: Use stop_emission_by_name instead
 of emit_stop_by_name
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
/usr/share/system-config-selinux/polgengui.py:679: PyGIDeprecationWarning: Deprecated, please use stop_emission_by_name.
  entry.emit_stop_by_name("insert_text")

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---


This is based on the set of patches related to polgengui.py:

https://marc.info/?l=selinux&m=151860211514842&w=2
https://marc.info/?l=selinux&m=151864307629079&w=2
https://marc.info/?l=selinux&m=151864311929090&w=2
https://marc.info/?l=selinux&m=151864316529106&w=2


gui/polgengui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gui/polgengui.py b/gui/polgengui.py
index cd73ea6d..1601dbef 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -674,7 +674,7 @@ class childWindow:
 
     def on_name_entry_changed(self, entry, text, size, position):
         if text.find(" ") >= 0:
-            entry.emit_stop_by_name("insert_text")
+            entry.stop_emission_by_name("insert-text")
 
     def on_focus_out_event(self, entry, third):
         name = entry.get_text()
-- 
2.16.2
