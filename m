Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYfoF011370
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id h186so18641476pfg.2
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:37 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 06/12] sepolicy: update exceptions and print for python3
Date: Fri,  5 Aug 2016 02:33:59 +0800
Message-Id: <1470335645-24224-7-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/sepolicy/sepolicy/__init__.py   | 26 ++++++------
 policycoreutils/sepolicy/sepolicy/generate.py   | 55 +++++++++++++------------
 policycoreutils/sepolicy/sepolicy/gui.py        | 32 +++++++-------
 policycoreutils/sepolicy/sepolicy/interface.py  |  8 ++--
 policycoreutils/sepolicy/sepolicy/manpage.py    | 53 +++++++++++-------------
 policycoreutils/sepolicy/sepolicy/sedbus.py     |  6 +--
 policycoreutils/sepolicy/sepolicy/transition.py |  2 +-
 7 files changed, 89 insertions(+), 93 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 7804b5c..6aec4c0 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -11,6 +11,10 @@ import gettext
 import sepolgen.defaults as defaults
 import sepolgen.interfaces as interfaces
 import sys
+import os
+import re
+import gzip
+
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
 try:
@@ -140,7 +144,7 @@ def get_writable_files(setype):
     all_writes = []
     mpaths = {}
     permlist = search([ALLOW], {'source': setype, 'permlist': ['open', 'write'], 'class': 'file'})
-    if permlist == None or len(permlist) == 0:
+    if permlist is None or len(permlist) == 0:
         return mpaths
 
     fcdict = get_fcdict()
@@ -170,10 +174,6 @@ def get_writable_files(setype):
             mpaths[f] = []  # {"regex":[],"paths":[]}
     return mpaths
 
-import os
-import re
-import sys
-
 
 def find_file(reg):
     if os.path.exists(reg):
@@ -181,7 +181,7 @@ def find_file(reg):
     try:
         pat = re.compile(r"%s$" % reg)
     except:
-        print "bad reg:", reg
+        print("bad reg:", reg)
         return []
     p = reg
     if p.endswith("(/.*)?"):
@@ -193,7 +193,7 @@ def find_file(reg):
         if path[-1] != "/":    # is pass in it breaks without try block
             path += "/"
     except IndexError:
-        print "try failed got an IndexError"
+        print("try failed got an IndexError")
         pass
 
     try:
@@ -464,7 +464,7 @@ all_types = None
 
 def get_all_types():
     global all_types
-    if all_types == None:
+    if all_types is None:
         all_types = map(lambda x: x['name'], info(TYPE))
     return all_types
 
@@ -473,7 +473,7 @@ user_types = None
 
 def get_user_types():
     global user_types
-    if user_types == None:
+    if user_types is None:
         user_types = info(ATTRIBUTE, "userdomain")[0]["types"]
     return user_types
 
@@ -525,7 +525,7 @@ def gen_interfaces():
 
     if os.getuid() != 0:
         raise ValueError(_("You must regenerate interface info by running /usr/bin/sepolgen-ifgen"))
-    print commands.getstatusoutput("/usr/bin/sepolgen-ifgen")[1]
+    print(commands.getstatusoutput("/usr/bin/sepolgen-ifgen")[1])
 
 
 def gen_port_dict():
@@ -797,7 +797,7 @@ def policy(policy_file):
 try:
     policy_file = get_installed_policy()
     policy(policy_file)
-except ValueError, e:
+except ValueError as e:
     if selinux.is_selinux_enabled() == 1:
         raise e
 
@@ -854,7 +854,6 @@ def get_all_booleans():
     return booleans
 
 booleans_dict = None
-import gzip
 
 
 def policy_xml(path="/usr/share/selinux/devel/policy.xml"):
@@ -874,7 +873,6 @@ def gen_bool_dict(path="/usr/share/selinux/devel/policy.xml"):
     if booleans_dict:
         return booleans_dict
     import xml.etree.ElementTree
-    import re
     booleans_dict = {}
     try:
         tree = xml.etree.ElementTree.fromstring(policy_xml(path))
@@ -896,7 +894,7 @@ def gen_bool_dict(path="/usr/share/selinux/devel/policy.xml"):
             desc = i.find("desc").find("p").text.strip("\n")
             desc = re.sub("\n", " ", desc)
             booleans_dict[i.get('name')] = ("global", i.get('dftval'), desc)
-    except IOError, e:
+    except IOError:
         pass
     return booleans_dict
 
diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index a92783a..2d83702 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -28,6 +28,7 @@ import re
 import sepolicy
 from sepolicy import get_all_types, get_all_attributes, get_all_roles
 import time
+import types
 import platform
 
 from templates import executable
@@ -204,10 +205,10 @@ class policy:
             raise ValueError(_("You must enter a name for your policy module for your '%s'.") % poltype[type])
         try:
             self.ports = get_all_ports()
-        except ValueError, e:
-            print "Can not get port types, must be root for this information"
-        except RuntimeError, e:
-            print "Can not get port types", e
+        except ValueError as e:
+            print("Can not get port types, must be root for this information")
+        except RuntimeError as e:
+            print("Can not get port types", e)
 
         self.symbols = {}
         self.symbols["openlog"] = "set_use_kerberos(True)"
@@ -454,52 +455,52 @@ class policy:
         self.out_udp = [all, False, False, verify_ports(ports)]
 
     def set_use_resolve(self, val):
-        if val != True and val != False:
+        if not isinstance(val, types.BooleanType):
             raise ValueError(_("use_resolve must be a boolean value "))
 
         self.use_resolve = val
 
     def set_use_syslog(self, val):
-        if val != True and val != False:
+        if not isinstance(val, types.BooleanType):
             raise ValueError(_("use_syslog must be a boolean value "))
 
         self.use_syslog = val
 
     def set_use_kerberos(self, val):
-        if val != True and val != False:
+        if not isinstance(val, types.BooleanType):
             raise ValueError(_("use_kerberos must be a boolean value "))
 
         self.use_kerberos = val
 
     def set_manage_krb5_rcache(self, val):
-        if val != True and val != False:
+        if not isinstance(val, types.BooleanType):
             raise ValueError(_("manage_krb5_rcache must be a boolean value "))
 
         self.manage_krb5_rcache = val
 
     def set_use_pam(self, val):
-        self.use_pam = val == True
+        self.use_pam = (val is True)
 
     def set_use_dbus(self, val):
-        self.use_dbus = val == True
+        self.use_dbus = (val is True)
 
     def set_use_audit(self, val):
-        self.use_audit = val == True
+        self.use_audit = (val is True)
 
     def set_use_etc(self, val):
-        self.use_etc = val == True
+        self.use_etc = (val is True)
 
     def set_use_localization(self, val):
-        self.use_localization = val == True
+        self.use_localization = (val is True)
 
     def set_use_fd(self, val):
-        self.use_fd = val == True
+        self.use_fd = (val is True)
 
     def set_use_terminal(self, val):
-        self.use_terminal = val == True
+        self.use_terminal = (val is True)
 
     def set_use_mail(self, val):
-        self.use_mail = val == True
+        self.use_mail = (val is True)
 
     def set_use_tmp(self, val):
         if self.type in USERS:
@@ -511,7 +512,7 @@ class policy:
             self.DEFAULT_DIRS["/tmp"][1] = []
 
     def set_use_uid(self, val):
-        self.use_uid = val == True
+        self.use_uid = (val is True)
 
     def generate_uid_rules(self):
         if self.use_uid:
@@ -602,7 +603,7 @@ allow %s_t %s_t:%s_socket name_%s;
     def generate_network_types(self):
         for i in self.in_tcp[PORTS]:
             rec = self.find_port(int(i), "tcp")
-            if rec == None:
+            if rec is None:
                 self.need_tcp_type = True
             else:
                 port_name = rec[0][:-2]
@@ -613,7 +614,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
         for i in self.out_tcp[PORTS]:
             rec = self.find_port(int(i), "tcp")
-            if rec == None:
+            if rec is None:
                 self.need_tcp_type = True
             else:
                 port_name = rec[0][:-2]
@@ -624,7 +625,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
         for i in self.in_udp[PORTS]:
             rec = self.find_port(int(i), "udp")
-            if rec == None:
+            if rec is None:
                 self.need_udp_type = True
             else:
                 port_name = rec[0][:-2]
@@ -633,13 +634,13 @@ allow %s_t %s_t:%s_socket name_%s;
                 if line not in self.found_udp_ports:
                     self.found_udp_ports.append(line)
 
-        if self.need_udp_type == True or self.need_tcp_type == True:
+        if self.need_udp_type is True or self.need_tcp_type is True:
             return re.sub("TEMPLATETYPE", self.name, network.te_types)
         return ""
 
     def __find_path(self, file):
         for d in self.DEFAULT_DIRS:
-            if file.find(d) == 0:
+            if file.find(d) is 0:
                 self.DEFAULT_DIRS[d][1].append(file)
                 return self.DEFAULT_DIRS[d]
         self.DEFAULT_DIRS["rw"][1].append(file)
@@ -870,7 +871,7 @@ allow %s_t %s_t:%s_socket name_%s;
         for t in self.types:
             for i in self.DEFAULT_EXT:
                 if t.endswith(i):
-                    print t, t[:-len(i)]
+                    print(t, t[:-len(i)])
                     newte += re.sub("TEMPLATETYPE", t[:-len(i)], self.DEFAULT_EXT[i].te_types)
                     break
 
@@ -1166,12 +1167,12 @@ allow %s_t %s_t:%s_socket name_%s;
             newsh += re.sub("FILENAME", i, script.restorecon)
 
         for i in self.in_tcp[PORTS] + self.out_tcp[PORTS]:
-            if self.find_port(i, "tcp") == None:
+            if self.find_port(i, "tcp") is None:
                 t1 = re.sub("PORTNUM", "%d" % i, script.tcp_ports)
                 newsh += re.sub("TEMPLATETYPE", self.name, t1)
 
         for i in self.in_udp[PORTS]:
-            if self.find_port(i, "udp") == None:
+            if self.find_port(i, "udp") is None:
                 t1 = re.sub("PORTNUM", "%d" % i, script.udp_ports)
                 newsh += re.sub("TEMPLATETYPE", self.name, t1)
 
@@ -1239,7 +1240,7 @@ allow %s_t %s_t:%s_socket name_%s;
         fd = open(shfile, "w")
         fd.write(self.generate_sh())
         fd.close()
-        os.chmod(shfile, 0750)
+        os.chmod(shfile, 0o750)
         return shfile
 
     def write_if(self, out_dir):
@@ -1364,7 +1365,7 @@ Warning %s does not exist
         for s in fd.read().split():
             for b in self.symbols:
                 if s.startswith(b):
-                    exec "self.%s" % self.symbols[b]
+                    exec("self.%s" % self.symbols[b])
         fd.close()
 
     def generate(self, out_dir=os.getcwd()):
diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 313b77f..60a4d83 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -110,8 +110,8 @@ class SELinuxGui():
         self.dbus = SELinuxDBus()
         try:
             customized = self.dbus.customized()
-        except dbus.exceptions.DBusException, e:
-            print e
+        except dbus.exceptions.DBusException as e:
+            print(e)
             self.quit()
 
         sepolicy_domains = sepolicy.get_all_domains()
@@ -818,7 +818,7 @@ class SELinuxGui():
         self.set_application_label = True
 
     def resize_wrap(self, *args):
-        print args
+        print(args)
 
     def initialize_system_default_mode(self):
         self.enforce_mode = selinux.selinux_getenforcemode()[1]
@@ -851,12 +851,12 @@ class SELinuxGui():
             for x in range(0, list.get_n_columns()):
                 try:
                     val = list.get_value(iter, x)
-                    if val == True or val == False or val == None:
+                    if val is True or val is False or val is None:
                         continue
                     # Returns true if filter_txt exists within the val
                     if(val.find(self.filter_txt) != -1 or val.lower().find(self.filter_txt) != -1):
                         return True
-                except AttributeError, TypeError:
+                except (AttributeError, TypeError):
                     pass
         except:  # ValueError:
             pass
@@ -959,7 +959,7 @@ class SELinuxGui():
         return liststore.get_value(iter, 0)
 
     def combo_box_initialize(self, val, desc):
-        if val == None:
+        if val is None:
             return
         iter = self.combobox_menu_model.append()
         for f in val:
@@ -968,7 +968,7 @@ class SELinuxGui():
     def select_type_more(self, *args):
         app = self.moreTypes_treeview.get_selection()
         iter = app.get_selected()[1]
-        if iter == None:
+        if iter is None:
             return
         app = self.more_types_files_liststore.get_value(iter, 0)
         self.combo_set_active_text(self.files_type_combobox, app)
@@ -980,7 +980,7 @@ class SELinuxGui():
         iter = model.convert_iter_to_child_iter(iter)
         iter = self.advanced_search_filter.convert_iter_to_child_iter(iter)
         app = self.advanced_search_liststore.get_value(iter, 1)
-        if app == None:
+        if app is None:
             return
         self.advanced_filter_entry.set_text('')
         self.advanced_search_window.hide()
@@ -1172,7 +1172,7 @@ class SELinuxGui():
 
     def files_initial_data_insert(self, liststore, path, seLinux_label, file_class):
         iter = liststore.append(None)
-        if path == None:
+        if path is None:
             path = _("MISSING FILE PATH")
             modify = False
         else:
@@ -1669,7 +1669,7 @@ class SELinuxGui():
                         self.more_types_files_liststore.set_value(iter, 0, app)
                 self.files_class_combobox.set_active(0)
         except AttributeError:
-            print "error"
+            print("error")
             pass
         self.files_type_combobox.set_active(0)
         self.files_mls_entry.set_text("s0")
@@ -1811,7 +1811,7 @@ class SELinuxGui():
             self.wait_mouse()
             try:
                 self.dbus.semanage(update_buffer)
-            except dbus.exceptions.DBusException, e:
+            except dbus.exceptions.DBusException as e:
                 self.error(e)
             self.ready_mouse()
 
@@ -1890,7 +1890,7 @@ class SELinuxGui():
         tree.set_value(iter, 2, fclass)
 
     def restore_to_default(self, *args):
-        print "restore to defualt clicked..."
+        print("restore to defualt clicked...")
 
     def invalid_entry_retry(self, *args):
         self.closewindow(self.error_check_window)
@@ -2143,7 +2143,7 @@ class SELinuxGui():
 
     def on_save_delete_file_equiv_clicked(self, *args):
         for delete in self.files_delete_liststore:
-            print delete[0], delete[1], delete[2],
+            print(delete[0], delete[1], delete[2],)
 
     def on_toggle_update(self, cell, path, model):
         model[path][0] = not model[path][0]
@@ -2451,8 +2451,8 @@ class SELinuxGui():
         self.wait_mouse()
         try:
             self.dbus.semanage(update_buffer)
-        except dbus.exceptions.DBusException, e:
-            print e
+        except dbus.exceptions.DBusException as e:
+            print(e)
         self.ready_mouse()
         self.init_cur()
 
@@ -2735,7 +2735,7 @@ class SELinuxGui():
             return
         try:
             self.dbus.relabel_on_boot(active)
-        except dbus.exceptions.DBusException, e:
+        except dbus.exceptions.DBusException as e:
             self.error(e)
 
     def closewindow(self, window, *args):
diff --git a/policycoreutils/sepolicy/sepolicy/interface.py b/policycoreutils/sepolicy/sepolicy/interface.py
index 69078b0..85f7351 100644
--- a/policycoreutils/sepolicy/sepolicy/interface.py
+++ b/policycoreutils/sepolicy/sepolicy/interface.py
@@ -79,7 +79,7 @@ def get_admin(path=""):
             for k in idict.keys():
                 if k.endswith("_admin"):
                     admin_list.append(k)
-        except IOError, e:
+        except IOError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
     else:
@@ -102,7 +102,7 @@ def get_user(path=""):
                 if k.endswith("_role"):
                     if (("%s_exec_t" % k[:-5]) in sepolicy.get_all_types()):
                         trans_list.append(k)
-        except IOError, e:
+        except IOError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
     else:
@@ -154,7 +154,7 @@ def get_interface_dict(path="/usr/share/selinux/devel/policy.xml"):
                         param_list.append(e.get('name'))
                     interface_dict[(i.get("name"))] = [param_list, (i.find('summary').text), "template"]
                     param_list = []
-    except IOError, e:
+    except IOError:
         pass
     return interface_dict
 
@@ -220,7 +220,7 @@ def interface_compile_test(interface, path="/usr/share/selinux/devel/policy.xml"
                 sys.stderr.write(output)
                 sys.stderr.write(_("\nCompile test for %s failed.\n") % interface)
 
-        except EnvironmentError, e:
+        except EnvironmentError as e:
             sys.stderr.write(_("\nCompile test for %s has not run. %s\n") % (interface, e))
         for v in policy_files.values():
             if os.path.exists(v):
diff --git a/policycoreutils/sepolicy/sepolicy/manpage.py b/policycoreutils/sepolicy/sepolicy/manpage.py
index 7de2f80..a3ffd45 100755
--- a/policycoreutils/sepolicy/sepolicy/manpage.py
+++ b/policycoreutils/sepolicy/sepolicy/manpage.py
@@ -25,15 +25,12 @@
 __all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
 
 import string
-import argparse
 import selinux
 import sepolicy
 from sepolicy import *
 
 import commands
-import sys
 import os
-import re
 import time
 
 equiv_dict = {"smbd": ["samba"], "httpd": ["apache"], "virtd": ["virt", "libvirt", "svirt", "svirt_tcg", "svirt_lxc_t", "svirt_lxc_net_t"], "named": ["bind"], "fsdaemon": ["smartmon"], "mdadm": ["raid"]}
@@ -62,7 +59,7 @@ def gen_modules_dict(path="/usr/share/selinux/devel/policy.xml"):
                     name = "unconfined"
                 for b in m.findall("summary"):
                     modules_dict[name] = b.text
-    except IOError, e:
+    except IOError:
         pass
     return modules_dict
 
@@ -169,7 +166,7 @@ def get_alphabet_manpages(manpage_list):
 def convert_manpage_to_html(html_manpage, manpage):
     rc, output = commands.getstatusoutput("/usr/bin/groff -man -Thtml %s 2>/dev/null" % manpage)
     if rc == 0:
-        print html_manpage, " has been created"
+        print(html_manpage, "has been created")
         fd = open(html_manpage, 'w')
         fd.write(output)
         fd.close()
@@ -238,7 +235,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
 """)
         for f in fedora_releases:
             fd.write("""
-<a href=%s/%s.html>%s</a> - SELinux man pages for %s """  % (f, f, f, f))
+<a href=%s/%s.html>%s</a> - SELinux man pages for %s """ % (f, f, f, f))
 
         fd.write("""
 </pre>
@@ -307,7 +304,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
             if len(self.manpage_domains[letter]):
                 fd.write("""
 <a href=#%s_domain>%s</a>
-			"""	% (letter, letter))
+			""" % (letter, letter))
 
         fd.write("""
 </td>
@@ -514,7 +511,7 @@ class ManPage:
         self.fd = open("%s/%s_selinux.8" % (self.path, alias), 'w')
         self.fd.write(".so man8/%s_selinux.8" % self.domainname)
         self.fd.close()
-        print path
+        print(path)
 
     def __gen_man_page(self):
         self.anon_list = []
@@ -744,7 +741,7 @@ SELinux %(domainname)s policy is very flexible allowing users to setup their %(d
 .br
 .B restorecon -R -v /srv/%(alt)s
 .PP
-""" % {'domainname': self.domainname, 'equiv': e, 'alt': e.split('/')[-1] })
+""" % {'domainname': self.domainname, 'equiv': e, 'alt': e.split('/')[-1]})
 
         self.fd.write(r"""
 .PP
@@ -758,7 +755,7 @@ store files with these types in a diffent paths, you need to execute the semanag
 .B restorecon -R -v /srv/my%(domainname)s_content
 
 Note: SELinux often uses regular expressions to specify labels that match multiple files.
-"""  % {'domainname': self.domainname, "type": flist[0] })
+""" % {'domainname': self.domainname, "type": flist[0]})
 
         self.fd.write(r"""
 .I The following file types are defined for %(domainname)s:
@@ -772,7 +769,7 @@ Note: SELinux often uses regular expressions to specify labels that match multip
 .EE
 
 - %s
-""" % ( f, sepolicy.get_description(f)))
+""" % (f, sepolicy.get_description(f)))
 
             if f in self.fcdict:
                 plural = ""
@@ -829,7 +826,7 @@ semanage fcontext -a -t public_content_rw_t "/var/%(domainname)s/incoming(/.*)?"
 .B restorecon -F -R -v /var/%(domainname)s/incoming
 .br
 .B setsebool -P %(domainname)s_anon_write 1
-"""  % {'domainname': self.domainname})
+""" % {'domainname': self.domainname})
             for b in self.anon_list:
                 desc = self.booleans_dict[b][2][0].lower() + self.booleans_dict[b][2][1:]
                 self.fd.write("""
@@ -899,7 +896,7 @@ selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
         except:
             return
 
-        self.fd.write ("""
+        self.fd.write("""
 .SH "ENTRYPOINTS"
 """)
         if len(entrypoints) > 1:
@@ -907,14 +904,14 @@ selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
         else:
             entrypoints_str = "\\fB%s\\fP file type" % entrypoints[0]
 
-        self.fd.write ("""
+        self.fd.write("""
 The %s_t SELinux type can be entered via the %s.
 
 The default entrypoint paths for the %s_t domain are the following:
-"""   % (self.domainname, entrypoints_str, self.domainname))
+""" % (self.domainname, entrypoints_str, self.domainname))
         if "bin_t" in entrypoints:
             entrypoints.remove("bin_t")
-            self.fd.write ("""
+            self.fd.write("""
 All executeables with the default executable label, usually stored in /usr/bin and /usr/sbin.""")
 
         paths = []
@@ -927,7 +924,7 @@ All executeables with the default executable label, usually stored in /usr/bin a
 
     def _writes(self):
         permlist = sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['open', 'write'], 'class': 'file'})
-        if permlist == None or len(permlist) == 0:
+        if permlist is None or len(permlist) == 0:
             return
 
         all_writes = []
@@ -943,12 +940,12 @@ All executeables with the default executable label, usually stored in /usr/bin a
 
         if len(all_writes) == 0:
             return
-        self.fd.write ("""
+        self.fd.write("""
 .SH "MANAGED FILES"
 """)
-        self.fd.write ("""
+        self.fd.write("""
 The SELinux process type %s_t can manage files labeled with the following file types.  The paths listed are the default paths for these file types.  Note the processes UID still need to have DAC permissions.
-"""   % self.domainname)
+""" % self.domainname)
 
         all_writes.sort()
         if "file_type" in all_writes:
@@ -1013,7 +1010,7 @@ If you want to map the one Linux user (joe) to the SELinux user %(user)s, you wo
 
 .B $ semanage login -a -s %(user)s_u joe
 
-"""	% {'user': self.domainname})
+""" % {'user': self.domainname})
 
     def _can_sudo(self):
         sudotype = "%s_sudo_t" % self.domainname
@@ -1029,13 +1026,13 @@ You can set up sudo to allow %(user)s to transition to an administrative domain:
 
 Add one or more of the following record to sudoers using visudo.
 
-""" % { 'user': self.domainname } )
+""" % {'user': self.domainname})
             for adminrole in self.role_allows[role]:
                 self.fd.write("""
 USERNAME ALL=(ALL) ROLE=%(admin)s_r TYPE=%(admin)s_t COMMAND
 .br
 sudo will run COMMAND as %(user)s_u:%(admin)s_r:%(admin)s_t:LEVEL
-""" % {'admin': adminrole[:-2], 'user': self.domainname } )
+""" % {'admin': adminrole[:-2], 'user': self.domainname})
 
                 self.fd.write("""
 You might also need to add one or more of these new roles to your SELinux user record.
@@ -1050,7 +1047,7 @@ Modify the roles list and add %(user)s_r to this list.
 
 For more details you can see semanage man page.
 
-""" % {'user': self.domainname, "roles": " ".join([role] + self.role_allows[role]) } )
+""" % {'user': self.domainname, "roles": " ".join([role] + self.role_allows[role])})
             else:
                 self.fd.write("""
 The SELinux type %s_t is not allowed to execute sudo.
@@ -1136,16 +1133,16 @@ The SELinux user %s_u is able to connect to the following tcp ports.
         permlist = sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'target': 'user_home_type', 'class': 'file', 'permlist': ['ioctl', 'read', 'getattr', 'execute', 'execute_no_trans', 'open']})
         self.fd.write("""
 .SH HOME_EXEC
-""" )
+""")
         if permlist is not None:
             self.fd.write("""
 The SELinux user %s_u is able execute home content files.
-"""  % self.domainname)
+""" % self.domainname)
 
         else:
             self.fd.write("""
 The SELinux user %s_u is not able execute home content files.
-"""  % self.domainname)
+""" % self.domainname)
 
     def _transitions(self):
         self.fd.write(r"""
@@ -1171,7 +1168,7 @@ Execute the following to see the types that the SELinux user %(type)s can execut
 
 .B $ search -A -s %(type)s -c process -p transition
 
-"""	% {'user': self.domainname, 'type': self.type})
+""" % {'user': self.domainname, 'type': self.type})
 
     def _role_header(self):
         self.fd.write('.TH  "%(user)s_selinux"  "8"  "%(user)s" "mgrepl@redhat.com" "%(user)s SELinux Policy documentation"'
diff --git a/policycoreutils/sepolicy/sepolicy/sedbus.py b/policycoreutils/sepolicy/sepolicy/sedbus.py
index 6055294..76b259a 100644
--- a/policycoreutils/sepolicy/sepolicy/sedbus.py
+++ b/policycoreutils/sepolicy/sepolicy/sedbus.py
@@ -55,6 +55,6 @@ if __name__ == "__main__":
     try:
         dbus_proxy = SELinuxDBus()
         resp = dbus_proxy.setenforce(int(sys.argv[1]))
-        print (resp)
-    except dbus.DBusException, e:
-        print e
+        print(resp)
+    except dbus.DBusException as e:
+        print(e)
diff --git a/policycoreutils/sepolicy/sepolicy/transition.py b/policycoreutils/sepolicy/sepolicy/transition.py
index 15b0eb1..a8edb69 100755
--- a/policycoreutils/sepolicy/sepolicy/transition.py
+++ b/policycoreutils/sepolicy/sepolicy/transition.py
@@ -81,4 +81,4 @@ class setrans:
 
     def output(self):
         self.seen = []
-        print self.out(self.source)
+        print(self.out(self.source))
-- 
2.7.3
