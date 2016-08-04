Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYmrl011375
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:51 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so17963536pac.1
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:49 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/12] policycoreutils/gui: update to python3
Date: Fri,  5 Aug 2016 02:34:03 +0800
Message-Id: <1470335645-24224-11-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

print functions
exceptions, e => as e
keys.sort() => sorted(d.keys())
---
 policycoreutils/gui/booleansPage.py          |  2 +-
 policycoreutils/gui/domainsPage.py           |  4 ++--
 policycoreutils/gui/fcontextPage.py          |  6 ++----
 policycoreutils/gui/html_util.py             |  2 +-
 policycoreutils/gui/loginsPage.py            | 10 +++-------
 policycoreutils/gui/mappingsPage.py          |  6 ++----
 policycoreutils/gui/modulesPage.py           | 10 +++++-----
 policycoreutils/gui/polgengui.py             | 12 ++++++------
 policycoreutils/gui/portsPage.py             | 10 +++-------
 policycoreutils/gui/semanagePage.py          |  4 ++--
 policycoreutils/gui/system-config-selinux.py |  8 ++++----
 policycoreutils/gui/usersPage.py             |  6 ++----
 12 files changed, 33 insertions(+), 47 deletions(-)

diff --git a/policycoreutils/gui/booleansPage.py b/policycoreutils/gui/booleansPage.py
index 7057ff4..6aaaf82 100644
--- a/policycoreutils/gui/booleansPage.py
+++ b/policycoreutils/gui/booleansPage.py
@@ -188,7 +188,7 @@ class booleansPage:
             if rc != 0:
                 return self.error(out)
             self.load(self.filter)
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def filter_changed(self, *arg):
diff --git a/policycoreutils/gui/domainsPage.py b/policycoreutils/gui/domainsPage.py
index 8f113ce..744bb10 100644
--- a/policycoreutils/gui/domainsPage.py
+++ b/policycoreutils/gui/domainsPage.py
@@ -132,7 +132,7 @@ class domainsPage(semanagePage):
                 domain = store.set_value(iter, 1, "")
                 self.itemSelected(selection)
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def propertiesDialog(self):
@@ -157,5 +157,5 @@ class domainsPage(semanagePage):
                 domain = store.set_value(iter, 1, _("Permissive"))
                 self.itemSelected(selection)
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
diff --git a/policycoreutils/gui/fcontextPage.py b/policycoreutils/gui/fcontextPage.py
index 2b95099..86bdff1 100644
--- a/policycoreutils/gui/fcontextPage.py
+++ b/policycoreutils/gui/fcontextPage.py
@@ -131,9 +131,7 @@ class fcontextPage(semanagePage):
         self.fcontext = seobject.fcontextRecords()
         self.store.clear()
         fcon_dict = self.fcontext.get_all(self.local)
-        keys = fcon_dict.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(fcon_dict.keys()):
             if not self.match(fcon_dict, k, filter):
                 continue
             iter = self.store.append()
@@ -188,7 +186,7 @@ class fcontextPage(semanagePage):
                 return self.error(out)
             store.remove(iter)
             self.view.get_selection().select_path((0,))
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def add(self):
diff --git a/policycoreutils/gui/html_util.py b/policycoreutils/gui/html_util.py
index 5a596bc..31492d7 100644
--- a/policycoreutils/gui/html_util.py
+++ b/policycoreutils/gui/html_util.py
@@ -135,7 +135,7 @@ def html_to_text(html, maxcol=80):
         text = buffer.getvalue()
         buffer.close()
         return text
-    except Exception, e:
+    except Exception as e:
         log_program.error('cannot convert html to text: %s' % e)
         return None
 
diff --git a/policycoreutils/gui/loginsPage.py b/policycoreutils/gui/loginsPage.py
index 8e0b7a2..1599b45 100644
--- a/policycoreutils/gui/loginsPage.py
+++ b/policycoreutils/gui/loginsPage.py
@@ -75,10 +75,8 @@ class loginsPage(semanagePage):
         self.filter = filter
         self.login = seobject.loginRecords()
         dict = self.login.get_all(0)
-        keys = dict.keys()
-        keys.sort()
         self.store.clear()
-        for k in keys:
+        for k in sorted(dict.keys()):
             range = seobject.translate(dict[k][1])
             if not (self.match(k, filter) or self.match(dict[k][0], filter) or self.match(range, filter)):
                 continue
@@ -99,9 +97,7 @@ class loginsPage(semanagePage):
         self.loginsSelinuxUserCombo.add_attribute(cell, 'text', 0)
 
         selusers = seobject.seluserRecords().get_all(0)
-        keys = selusers.keys()
-        keys.sort()
-        for k in keys:
+        for k in sorted(selusers.keys()):
             if k != "system_u":
                 self.loginsSelinuxUserCombo.append_text(k)
 
@@ -146,7 +142,7 @@ class loginsPage(semanagePage):
                 return False
             store.remove(iter)
             self.view.get_selection().select_path((0,))
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def add(self):
diff --git a/policycoreutils/gui/mappingsPage.py b/policycoreutils/gui/mappingsPage.py
index 3b4ceb6..acf0bb5 100644
--- a/policycoreutils/gui/mappingsPage.py
+++ b/policycoreutils/gui/mappingsPage.py
@@ -56,7 +56,5 @@ class loginsPage:
         self.view.set_model(self.store)
         self.login = loginRecords()
         dict = self.login.get_all(0)
-        keys = dict.keys()
-        keys.sort()
-        for k in keys:
-            print "%-25s %-25s %-25s" % (k, dict[k][0], translate(dict[k][1]))
+        for k in sorted(dict.keys()):
+            print("%-25s %-25s %-25s" % (k, dict[k][0], translate(dict[k][1])))
diff --git a/policycoreutils/gui/modulesPage.py b/policycoreutils/gui/modulesPage.py
index c7c7848..690f583 100644
--- a/policycoreutils/gui/modulesPage.py
+++ b/policycoreutils/gui/modulesPage.py
@@ -113,7 +113,7 @@ class modulesPage(semanagePage):
     def new_module(self, args):
         try:
             Popen(["/usr/share/system-config-selinux/polgengui.py"])
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def delete(self):
@@ -129,7 +129,7 @@ class modulesPage(semanagePage):
                 store.remove(iter)
                 self.view.get_selection().select_path((0,))
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def enable_audit(self, button):
@@ -147,7 +147,7 @@ class modulesPage(semanagePage):
             if status != 0:
                 self.error(output)
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def disable_audit(self, button):
@@ -158,7 +158,7 @@ class modulesPage(semanagePage):
             if status != 0:
                 self.error(output)
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def propertiesDialog(self):
@@ -193,5 +193,5 @@ class modulesPage(semanagePage):
             else:
                 self.load()
 
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
diff --git a/policycoreutils/gui/polgengui.py b/policycoreutils/gui/polgengui.py
index 1f97ada..5434d20 100644
--- a/policycoreutils/gui/polgengui.py
+++ b/policycoreutils/gui/polgengui.py
@@ -30,7 +30,7 @@ import gnome
 import sys
 try:
     import sepolicy
-except ValueError, e:
+except ValueError as e:
     sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
     sys.exit(1)
 
@@ -202,7 +202,7 @@ class childWindow:
             self.all_modules = get_all_modules()
             self.all_roles = sepolicy.generate.get_all_roles()
             self.all_users = sepolicy.generate.get_all_users()
-        except RuntimeError, e:
+        except RuntimeError as e:
             self.all_types = []
             self.all_modules = []
             self.all_roles = []
@@ -340,7 +340,7 @@ class childWindow:
             for a in sepolicy.interface.get_admin():
                 iter = self.admin_store.append()
                 self.admin_store.set_value(iter, 0, a)
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.message)
 
     def confine_application(self):
@@ -526,7 +526,7 @@ class childWindow:
 
             self.info(my_policy.generate(outputdir))
             return False
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.message)
 
     def delete(self, args):
@@ -694,7 +694,7 @@ class childWindow:
         try:
             generate.verify_ports(self.in_tcp_entry.get_text())
             generate.verify_ports(self.in_udp_entry.get_text())
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.message)
             return True
 
@@ -702,7 +702,7 @@ class childWindow:
         try:
             generate.verify_ports(self.out_tcp_entry.get_text())
             generate.verify_ports(self.out_udp_entry.get_text())
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.message)
             return True
 
diff --git a/policycoreutils/gui/portsPage.py b/policycoreutils/gui/portsPage.py
index 7e7a653..8f62921 100644
--- a/policycoreutils/gui/portsPage.py
+++ b/policycoreutils/gui/portsPage.py
@@ -123,10 +123,8 @@ class portsPage(semanagePage):
         self.filter = filter
         self.port = seobject.portRecords()
         dict = self.port.get_all(self.local)
-        keys = dict.keys()
-        keys.sort()
         self.store.clear()
-        for k in keys:
+        for k in sorted(dict.keys()):
             if not (self.match(str(k[0]), filter) or self.match(dict[k][0], filter) or self.match(k[2], filter) or self.match(dict[k][1], filter) or self.match(dict[k][1], filter)):
                 continue
             iter = self.store.append()
@@ -144,10 +142,8 @@ class portsPage(semanagePage):
         self.filter = filter
         self.port = seobject.portRecords()
         dict = self.port.get_all_by_type(self.local)
-        keys = dict.keys()
-        keys.sort()
         self.store.clear()
-        for k in keys:
+        for k in sorted(dict.keys()):
             ports_string = ", ".join(dict[k])
             if not (self.match(ports_string, filter) or self.match(k[0], filter) or self.match(k[1], filter)):
                 continue
@@ -196,7 +192,7 @@ class portsPage(semanagePage):
                 return self.error(out)
             store.remove(iter)
             self.view.get_selection().select_path((0,))
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
 
     def add(self):
diff --git a/policycoreutils/gui/semanagePage.py b/policycoreutils/gui/semanagePage.py
index d07ce27..1f14d56 100644
--- a/policycoreutils/gui/semanagePage.py
+++ b/policycoreutils/gui/semanagePage.py
@@ -147,7 +147,7 @@ class semanagePage:
                 if self.add() == False:
                     continue
                 break
-            except ValueError, e:
+            except ValueError as e:
                 self.error(e.args[0])
         self.dialog.hide()
 
@@ -160,7 +160,7 @@ class semanagePage:
                 if self.modify() == False:
                     continue
                 break
-            except ValueError, e:
+            except ValueError as e:
                 self.error(e.args[0])
         self.dialog.hide()
 
diff --git a/policycoreutils/gui/system-config-selinux.py b/policycoreutils/gui/system-config-selinux.py
index 8d2be13..ed41e98 100644
--- a/policycoreutils/gui/system-config-selinux.py
+++ b/policycoreutils/gui/system-config-selinux.py
@@ -25,9 +25,9 @@ import string
 import sys
 try:
     import gtk
-except RuntimeError, e:
-    print "system-config-selinux:", e
-    print "This is a graphical application and requires DISPLAY to be set."
+except RuntimeError as e:
+    print("system-config-selinux:", e)
+    print("This is a graphical application and requires DISPLAY to be set.")
     sys.exit(1)
 
 import gtk.glade
@@ -100,7 +100,7 @@ class childWindow:
                 self.add_page(portsPage.portsPage(xml))
                 self.add_page(modulesPage.modulesPage(xml))  # modules
                 self.add_page(domainsPage.domainsPage(xml))  # domains
-            except ValueError, e:
+            except ValueError as e:
                 self.error(e.message)
 
         xml.signal_connect("on_quit_activate", self.destroy)
diff --git a/policycoreutils/gui/usersPage.py b/policycoreutils/gui/usersPage.py
index eb978ea..92e624c 100644
--- a/policycoreutils/gui/usersPage.py
+++ b/policycoreutils/gui/usersPage.py
@@ -79,10 +79,8 @@ class usersPage(semanagePage):
         self.filter = filter
         self.user = seobject.seluserRecords()
         dict = self.user.get_all()
-        keys = dict.keys()
-        keys.sort()
         self.store.clear()
-        for k in keys:
+        for k in sorted(dict.keys()):
             range = seobject.translate(dict[k][2])
             if not (self.match(k, filter) or self.match(dict[k][0], filter) or self.match(range, filter) or self.match(dict[k][3], filter)):
                 continue
@@ -155,5 +153,5 @@ class usersPage(semanagePage):
                 return False
             store.remove(iter)
             self.view.get_selection().select_path((0,))
-        except ValueError, e:
+        except ValueError as e:
             self.error(e.args[0])
-- 
2.7.3
