Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfP029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 297D43B71F
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:06 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/19] sepolicy: Adapt to new the semodule list output
Date: Wed,  3 May 2017 12:30:27 +0200
Message-Id: <20170503103036.17514-11-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

semodule in policycoreutils-2.4 changed the list format. With this
patch, org.selinux.semodule_list uses 'semodule --list=full' and the
code using this was adapted to the new format.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1281309

Fixes:
File "/usr/lib64/python3.4/site-packages/sepolicy/gui.py", line 670, in lockdown_init
  self.enable_unconfined_button.set_active(not self.module_dict["unconfined"]["Disabled"])
KeyError: 'unconfined'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 dbus/selinux_server.py          | 4 ++--
 gui/polgengui.py                | 2 +-
 python/sepolicy/sepolicy/gui.py | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index 8bd1fe5b..aae8b5fa 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -46,13 +46,13 @@ class selinux_server(slip.dbus.service.Object):
         return buf
 
     #
-    # The semodule_list method will return the output of semodule -l, using the customized polkit,
+    # The semodule_list method will return the output of semodule --list=full, using the customized polkit,
     # since this is a readonly behaviour
     #
     @slip.dbus.polkit.require_auth("org.selinux.semodule_list")
     @dbus.service.method("org.selinux", in_signature='', out_signature='s')
     def semodule_list(self):
-        p = Popen(["/usr/sbin/semodule", "-l"], stdout=PIPE, stderr=PIPE)
+        p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE)
         buf = p.stdout.read()
         output = p.communicate()
         if p.returncode and p.returncode != 0:
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 1d262a95..7460cce2 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -679,7 +679,7 @@ class childWindow:
                     entry.set_text("")
                     return False
             if name in self.all_modules:
-                if self.verify(_("Module %s.pp already loaded in current policy.\nDo you want to continue?") % name, _("Verify Name")) == gtk.RESPONSE_NO:
+                if self.verify(_("Module %s already loaded in current policy.\nDo you want to continue?") % name, _("Verify Name")) == gtk.RESPONSE_NO:
                     entry.set_text("")
                     return False
 
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index c9dd4c1c..e361aa1c 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -673,9 +673,9 @@ class SELinuxGui():
         self.module_dict = {}
         for m in self.dbus.semodule_list().split("\n"):
             mod = m.split()
-            if len(mod) < 2:
+            if len(mod) < 3:
                 continue
-            self.module_dict[mod[0]] = {"version": mod[1], "Disabled": (len(mod) > 2)}
+            self.module_dict[mod[1]] = { "priority": mod[0], "Disabled" : (len(mod) > 3) }
 
         self.enable_unconfined_button.set_active(not self.module_dict["unconfined"]["Disabled"])
         self.enable_permissive_button.set_active(not self.module_dict["permissivedomains"]["Disabled"])
-- 
2.12.2
