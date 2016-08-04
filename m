Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IZJk3011426
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:35:22 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so17963582pac.1
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:52 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/12] policycoreutils/gui: py3 support for modules that
 changed name
Date: Fri,  5 Aug 2016 02:34:04 +0800
Message-Id: <1470335645-24224-12-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

StringIO moved to io and commands moved to subprocess
---
 policycoreutils/gui/booleansPage.py | 12 ++++++++----
 policycoreutils/gui/domainsPage.py  | 10 +++++++---
 policycoreutils/gui/fcontextPage.py | 12 ++++++++----
 policycoreutils/gui/html_util.py    |  7 +++++--
 policycoreutils/gui/loginsPage.py   | 12 ++++++++----
 policycoreutils/gui/modulesPage.py  | 16 ++++++++++------
 policycoreutils/gui/polgengui.py    |  8 ++++++--
 policycoreutils/gui/portsPage.py    | 12 ++++++++----
 policycoreutils/gui/statusPage.py   |  6 +++++-
 policycoreutils/gui/usersPage.py    | 12 ++++++++----
 10 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/policycoreutils/gui/booleansPage.py b/policycoreutils/gui/booleansPage.py
index 6aaaf82..a5d04bf 100644
--- a/policycoreutils/gui/booleansPage.py
+++ b/policycoreutils/gui/booleansPage.py
@@ -31,7 +31,11 @@ import semanagePage
 INSTALLPATH = '/usr/share/system-config-selinux'
 sys.path.append(INSTALLPATH)
 
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 ENFORCING = 0
 PERMISSIVE = 1
 DISABLED = 2
@@ -182,7 +186,7 @@ class booleansPage:
             return
         try:
             self.wait()
-            (rc, out) = commands.getstatusoutput("semanage boolean -d %s" % boolean)
+            (rc, out) = getstatusoutput("semanage boolean -d %s" % boolean)
 
             self.ready()
             if rc != 0:
@@ -233,7 +237,7 @@ class booleansPage:
         self.store.set_value(iter, ACTIVE, not val)
         self.wait()
         setsebool = "/usr/sbin/setsebool -P %s %d" % (key, not val)
-        rc, out = commands.getstatusoutput(setsebool)
+        rc, out = getstatusoutput(setsebool)
         if rc != 0:
             self.error(out)
         self.load(self.filter)
@@ -242,7 +246,7 @@ class booleansPage:
     def on_revert_clicked(self, button):
         self.wait()
         setsebool = "semanage boolean --deleteall"
-        commands.getstatusoutput(setsebool)
+        getstatusoutput(setsebool)
         self.load(self.filter)
         self.ready()
 
diff --git a/policycoreutils/gui/domainsPage.py b/policycoreutils/gui/domainsPage.py
index 744bb10..66f882a 100644
--- a/policycoreutils/gui/domainsPage.py
+++ b/policycoreutils/gui/domainsPage.py
@@ -20,7 +20,11 @@ import string
 import gtk
 import gtk.glade
 import os
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 import gobject
 import sys
 import seobject
@@ -124,7 +128,7 @@ class domainsPage(semanagePage):
         domain = store.get_value(iter, 0)
         try:
             self.wait()
-            status, output = commands.getstatusoutput("semanage permissive -d %s_t" % domain)
+            status, output = getstatusoutput("semanage permissive -d %s_t" % domain)
             self.ready()
             if status != 0:
                 self.error(output)
@@ -149,7 +153,7 @@ class domainsPage(semanagePage):
         domain = store.get_value(iter, 0)
         try:
             self.wait()
-            status, output = commands.getstatusoutput("semanage permissive -a %s_t" % domain)
+            status, output = getstatusoutput("semanage permissive -a %s_t" % domain)
             self.ready()
             if status != 0:
                 self.error(output)
diff --git a/policycoreutils/gui/fcontextPage.py b/policycoreutils/gui/fcontextPage.py
index 86bdff1..c176de4 100644
--- a/policycoreutils/gui/fcontextPage.py
+++ b/policycoreutils/gui/fcontextPage.py
@@ -21,7 +21,11 @@ import gtk.glade
 import os
 import gobject
 import seobject
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 from semanagePage import *
 
 SPEC_COL = 0
@@ -179,7 +183,7 @@ class fcontextPage(semanagePage):
             fspec = store.get_value(iter, SPEC_COL)
             ftype = store.get_value(iter, FTYPE_COL)
             self.wait()
-            (rc, out) = commands.getstatusoutput("semanage fcontext -d -f '%s' '%s'" % (ftype, fspec))
+            (rc, out) = getstatusoutput("semanage fcontext -d -f '%s' '%s'" % (ftype, fspec))
             self.ready()
 
             if rc != 0:
@@ -197,7 +201,7 @@ class fcontextPage(semanagePage):
         list_model = self.fcontextFileTypeCombo.get_model()
         active = self.fcontextFileTypeCombo.get_active()
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, ftype[active], fspec))
+        (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, ftype[active], fspec))
         self.ready()
         if rc != 0:
             self.error(out)
@@ -216,7 +220,7 @@ class fcontextPage(semanagePage):
         iter = self.fcontextFileTypeCombo.get_active_iter()
         ftype = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage fcontext -m -t %s -r %s -f '%s' '%s'" % (type, mls, ftype, fspec))
+        (rc, out) = getstatusoutput("semanage fcontext -m -t %s -r %s -f '%s' '%s'" % (type, mls, ftype, fspec))
         self.ready()
         if rc != 0:
             self.error(out)
diff --git a/policycoreutils/gui/html_util.py b/policycoreutils/gui/html_util.py
index 31492d7..e93c20c 100644
--- a/policycoreutils/gui/html_util.py
+++ b/policycoreutils/gui/html_util.py
@@ -30,7 +30,10 @@ import htmllib
 import formatter as Formatter
 import string
 from types import *
-import StringIO
+try:
+    from io import StringIO
+except ImportError:
+    from StringIO import StringIO
 
 #------------------------------------------------------------------------------
 
@@ -127,7 +130,7 @@ def unescape_html(s):
 
 def html_to_text(html, maxcol=80):
     try:
-        buffer = StringIO.StringIO()
+        buffer = StringIO()
         formatter = Formatter.AbstractFormatter(TextWriter(buffer, maxcol))
         parser = HTMLParserAnchor(formatter)
         parser.feed(html)
diff --git a/policycoreutils/gui/loginsPage.py b/policycoreutils/gui/loginsPage.py
index 1599b45..1f35a57 100644
--- a/policycoreutils/gui/loginsPage.py
+++ b/policycoreutils/gui/loginsPage.py
@@ -22,7 +22,11 @@ import gtk.glade
 import os
 import gobject
 import sys
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 import seobject
 from semanagePage import *
 
@@ -135,7 +139,7 @@ class loginsPage(semanagePage):
                 raise ValueError(_("Login '%s' is required") % login)
 
             self.wait()
-            (rc, out) = commands.getstatusoutput("semanage login -d %s" % login)
+            (rc, out) = getstatusoutput("semanage login -d %s" % login)
             self.ready()
             if rc != 0:
                 self.error(out)
@@ -154,7 +158,7 @@ class loginsPage(semanagePage):
         iter = self.loginsSelinuxUserCombo.get_active_iter()
         seuser = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage login -a -s %s -r %s %s" % (seuser, serange, target))
+        (rc, out) = getstatusoutput("semanage login -a -s %s -r %s %s" % (seuser, serange, target))
         self.ready()
         if rc != 0:
             self.error(out)
@@ -174,7 +178,7 @@ class loginsPage(semanagePage):
         iter = self.loginsSelinuxUserCombo.get_active_iter()
         seuser = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage login -m -s %s -r %s %s" % (seuser, serange, target))
+        (rc, out) = getstatusoutput("semanage login -m -s %s -r %s %s" % (seuser, serange, target))
         self.ready()
         if rc != 0:
             self.error(out)
diff --git a/policycoreutils/gui/modulesPage.py b/policycoreutils/gui/modulesPage.py
index 690f583..3767896 100644
--- a/policycoreutils/gui/modulesPage.py
+++ b/policycoreutils/gui/modulesPage.py
@@ -20,7 +20,11 @@ import string
 import gtk
 import gtk.glade
 import os
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 import gobject
 import sys
 import seobject
@@ -121,7 +125,7 @@ class modulesPage(semanagePage):
         module = store.get_value(iter, 0)
         try:
             self.wait()
-            status, output = commands.getstatusoutput("semodule -r %s" % module)
+            status, output = getstatusoutput("semodule -r %s" % module)
             self.ready()
             if status != 0:
                 self.error(output)
@@ -137,10 +141,10 @@ class modulesPage(semanagePage):
         try:
             self.wait()
             if self.audit_enabled:
-                status, output = commands.getstatusoutput("semodule -DB")
+                status, output = getstatusoutput("semodule -DB")
                 button.set_label(_("Disable Audit"))
             else:
-                status, output = commands.getstatusoutput("semodule -B")
+                status, output = getstatusoutput("semodule -B")
                 button.set_label(_("Enable Audit"))
             self.ready()
 
@@ -153,7 +157,7 @@ class modulesPage(semanagePage):
     def disable_audit(self, button):
         try:
             self.wait()
-            status, output = commands.getstatusoutput("semodule -B")
+            status, output = getstatusoutput("semodule -B")
             self.ready()
             if status != 0:
                 self.error(output)
@@ -186,7 +190,7 @@ class modulesPage(semanagePage):
     def add(self, file):
         try:
             self.wait()
-            status, output = commands.getstatusoutput("semodule -i %s" % file)
+            status, output = getstatusoutput("semodule -i %s" % file)
             self.ready()
             if status != 0:
                 self.error(output)
diff --git a/policycoreutils/gui/polgengui.py b/policycoreutils/gui/polgengui.py
index 5434d20..1d262a9 100644
--- a/policycoreutils/gui/polgengui.py
+++ b/policycoreutils/gui/polgengui.py
@@ -35,7 +35,11 @@ except ValueError as e:
     sys.exit(1)
 
 import sepolicy.interface
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 
 import re
 
@@ -43,7 +47,7 @@ import re
 def get_all_modules():
     try:
         all_modules = []
-        rc, output = commands.getstatusoutput("semodule -l 2>/dev/null")
+        rc, output = getstatusoutput("semodule -l 2>/dev/null")
         if rc == 0:
             l = output.split("\n")
             for i in l:
diff --git a/policycoreutils/gui/portsPage.py b/policycoreutils/gui/portsPage.py
index 8f62921..b6445db 100644
--- a/policycoreutils/gui/portsPage.py
+++ b/policycoreutils/gui/portsPage.py
@@ -23,7 +23,11 @@ import os
 import gobject
 import sys
 import seobject
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 from semanagePage import *
 
 ##
@@ -186,7 +190,7 @@ class portsPage(semanagePage):
         protocol = store.get_value(iter, 1)
         try:
             self.wait()
-            (rc, out) = commands.getstatusoutput("semanage port -d -p %s %s" % (protocol, port))
+            (rc, out) = getstatusoutput("semanage port -d -p %s %s" % (protocol, port))
             self.ready()
             if rc != 0:
                 return self.error(out)
@@ -209,7 +213,7 @@ class portsPage(semanagePage):
         iter = self.ports_protocol_combo.get_active_iter()
         protocol = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage port -a -p %s -r %s -t %s %s" % (protocol, mls, target, port_number))
+        (rc, out) = getstatusoutput("semanage port -a -p %s -r %s -t %s %s" % (protocol, mls, target, port_number))
         self.ready()
         if rc != 0:
             self.error(out)
@@ -229,7 +233,7 @@ class portsPage(semanagePage):
         iter = self.ports_protocol_combo.get_active_iter()
         protocol = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage port -m -p %s -r %s -t %s %s" % (protocol, mls, target, port_number))
+        (rc, out) = getstatusoutput("semanage port -m -p %s -r %s -t %s %s" % (protocol, mls, target, port_number))
         self.ready()
         if rc != 0:
             self.error(out)
diff --git a/policycoreutils/gui/statusPage.py b/policycoreutils/gui/statusPage.py
index de27752..23d0d0f 100644
--- a/policycoreutils/gui/statusPage.py
+++ b/policycoreutils/gui/statusPage.py
@@ -28,7 +28,11 @@ import selinux
 INSTALLPATH = '/usr/share/system-config-selinux'
 sys.path.append(INSTALLPATH)
 
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 ENFORCING = 1
 PERMISSIVE = 0
 DISABLED = -1
diff --git a/policycoreutils/gui/usersPage.py b/policycoreutils/gui/usersPage.py
index 92e624c..75b0547 100644
--- a/policycoreutils/gui/usersPage.py
+++ b/policycoreutils/gui/usersPage.py
@@ -22,7 +22,11 @@ import gtk.glade
 import os
 import gobject
 import sys
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
+
 import seobject
 from semanagePage import *
 
@@ -114,7 +118,7 @@ class usersPage(semanagePage):
         roles = self.selinuxRolesEntry.get_text()
 
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage user -a -R '%s' -r %s %s" % (roles, range, user))
+        (rc, out) = getstatusoutput("semanage user -a -R '%s' -r %s %s" % (roles, range, user))
         self.ready()
         if rc != 0:
             self.error(out)
@@ -130,7 +134,7 @@ class usersPage(semanagePage):
         roles = self.selinuxRolesEntry.get_text()
 
         self.wait()
-        (rc, out) = commands.getstatusoutput("semanage user -m -R '%s' -r %s %s" % (roles, range, user))
+        (rc, out) = getstatusoutput("semanage user -m -R '%s' -r %s %s" % (roles, range, user))
         self.ready()
 
         if rc != 0:
@@ -146,7 +150,7 @@ class usersPage(semanagePage):
                 raise ValueError(_("SELinux user '%s' is required") % user)
 
             self.wait()
-            (rc, out) = commands.getstatusoutput("semanage user -d %s" % user)
+            (rc, out) = getstatusoutput("semanage user -d %s" % user)
             self.ready()
             if rc != 0:
                 self.error(out)
-- 
2.7.3
