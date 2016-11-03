Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA3GYavX022438
 for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2016 12:34:36 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id A067C1A1A8
 for <selinux@tycho.nsa.gov>; Thu,  3 Nov 2016 17:34:30 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gmqFsaZ6Ufcr for <selinux@tycho.nsa.gov>;
 Thu,  3 Nov 2016 17:34:23 +0100 (CET)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id F20BA1A06E
 for <selinux@tycho.nsa.gov>; Thu,  3 Nov 2016 17:34:22 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: Run 2to3 over the sepolicy python code
Date: Thu,  3 Nov 2016 17:34:22 +0100
Message-Id: <20161103163422.18197-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Convert the code to work with python3

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/sepolicy/selinux_client.py       |  6 +-
 policycoreutils/sepolicy/sepolicy.py             | 56 +++++++++---------
 policycoreutils/sepolicy/sepolicy/__init__.py    | 50 ++++++++--------
 policycoreutils/sepolicy/sepolicy/booleans.py    |  2 +-
 policycoreutils/sepolicy/sepolicy/communicate.py |  2 +-
 policycoreutils/sepolicy/sepolicy/generate.py    | 72 ++++++++++++------------
 policycoreutils/sepolicy/sepolicy/gui.py         | 22 ++++----
 policycoreutils/sepolicy/sepolicy/interface.py   | 26 ++++-----
 policycoreutils/sepolicy/sepolicy/manpage.py     | 24 ++++----
 policycoreutils/sepolicy/sepolicy/network.py     |  2 +-
 policycoreutils/sepolicy/sepolicy/transition.py  |  8 +--
 policycoreutils/sepolicy/test_sepolicy.py        |  4 +-
 12 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/policycoreutils/sepolicy/selinux_client.py b/policycoreutils/sepolicy/selinux_client.py
index 7f4a91c..dc29f28 100644
--- a/policycoreutils/sepolicy/selinux_client.py
+++ b/policycoreutils/sepolicy/selinux_client.py
@@ -39,6 +39,6 @@ if __name__ == "__main__":
     try:
         dbus_proxy = SELinuxDBus()
         resp = dbus_proxy.customized()
-        print convert_customization(resp)
-    except dbus.DBusException, e:
-        print e
+        print(convert_customization(resp))
+    except dbus.DBusException as e:
+        print(e)
diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sepolicy/sepolicy.py
index 3e502a7..e7cca4f 100755
--- a/policycoreutils/sepolicy/sepolicy.py
+++ b/policycoreutils/sepolicy/sepolicy.py
@@ -42,8 +42,8 @@ except:
         import builtins
         builtins.__dict__['_'] = str
     except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
+        import builtins
+        builtins.__dict__['_'] = str
 
 usage = "sepolicy generate [-h] [-n NAME] [-p PATH] ["
 usage_dict = {' --newtype': ('-t [TYPES [TYPES ...]]',), ' --customize': ('-d DOMAIN', '-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), ' --admin_user': ('[-r TRANSITION_ROLE ]', "[ -w WRITEPATHS ]",), ' --application': ('COMMAND', "[ -w WRITEPATHS ]",), ' --cgi': ('COMMAND', "[ -w WRITEPATHS ]",), ' --confined_admin': ('-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), ' --dbus': ('COMMAND', "[ -w WRITEPATHS ]",), ' --desktop_user': ('', "[ -w WRITEPATHS ]",), ' --inetd': ('COMMAND', "[ -w WRITEPATHS ]",), ' --init': ('COMMAND', "[ -w WRITEPATHS ]",), ' --sandbox': ("[ -w WRITEPATHS ]",), ' --term_user': ("[ -w WRITEPATHS ]",), ' --x_user': ("[ -w WRITEPATHS ]",)}
@@ -125,7 +125,7 @@ class CheckClass(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
         global all_classes
         if not all_classes:
-            all_classes = map(lambda x: x['name'], sepolicy.info(sepolicy.TCLASS))
+            all_classes = [x['name'] for x in sepolicy.info(sepolicy.TCLASS)]
         if values not in all_classes:
             raise ValueError("%s must be an SELinux class:\nValid classes: %s" % (values, ", ".join(all_classes)))
 
@@ -185,7 +185,7 @@ class CheckPolicyType(argparse.Action):
 
     def __call__(self, parser, namespace, values, option_string=None):
         from sepolicy.generate import get_poltype_desc, poltype
-        if values not in poltype.keys():
+        if values not in list(poltype.keys()):
             raise ValueError("%s invalid SELinux policy type\n%s" % (values, get_poltype_desc()))
             newval.append(v)
         setattr(namespace, self.dest, values)
@@ -223,7 +223,7 @@ class InterfaceInfo(argparse.Action):
         from sepolicy.interface import get_interface_dict
         interface_dict = get_interface_dict()
         for v in values:
-            if v not in interface_dict.keys():
+            if v not in list(interface_dict.keys()):
                 raise ValueError(_("Interface %s does not exist.") % v)
 
         setattr(namespace, self.dest, values)
@@ -231,7 +231,7 @@ class InterfaceInfo(argparse.Action):
 
 def generate_custom_usage(usage_text, usage_dict):
     sorted_keys = []
-    for i in usage_dict.keys():
+    for i in list(usage_dict.keys()):
         sorted_keys.append(i)
     sorted_keys.sort()
     for k in sorted_keys:
@@ -262,7 +262,7 @@ def _print_net(src, protocol, perm):
     if len(portdict) > 0:
         bold_start = "\033[1m"
         bold_end = "\033[0;0m"
-        print "\n" + bold_start + "%s: %s %s" % (src, protocol, perm) + bold_end
+        print("\n" + bold_start + "%s: %s %s" % (src, protocol, perm) + bold_end)
         port_strings = []
         boolean_text = ""
         for p in portdict:
@@ -275,7 +275,7 @@ def _print_net(src, protocol, perm):
                     port_strings.append("%s (%s)" % (", ".join(recs), t))
         port_strings.sort(numcmp)
         for p in port_strings:
-            print "\t" + p
+            print("\t" + p)
 
 
 def network(args):
@@ -286,7 +286,7 @@ def network(args):
             if i[0] not in all_ports:
                 all_ports.append(i[0])
         all_ports.sort()
-        print "\n".join(all_ports)
+        print("\n".join(all_ports))
 
     for port in args.port:
         found = False
@@ -297,18 +297,18 @@ def network(args):
                 else:
                     range = "%s-%s" % (i[0], i[1])
                 found = True
-                print "%d: %s %s %s" % (port, i[2], portrecsbynum[i][0], range)
+                print("%d: %s %s %s" % (port, i[2], portrecsbynum[i][0], range))
         if not found:
             if port < 500:
-                print "Undefined reserved port type"
+                print("Undefined reserved port type")
             else:
-                print "Undefined port type"
+                print("Undefined port type")
 
     for t in args.type:
-        if (t, 'tcp') in portrecs.keys():
-            print "%s: tcp: %s" % (t, ",".join(portrecs[t, 'tcp']))
-        if (t, 'udp') in portrecs.keys():
-            print "%s: udp: %s" % (t, ",".join(portrecs[t, 'udp']))
+        if (t, 'tcp') in list(portrecs.keys()):
+            print("%s: tcp: %s" % (t, ",".join(portrecs[t, 'tcp'])))
+        if (t, 'udp') in list(portrecs.keys()):
+            print("%s: udp: %s" % (t, ",".join(portrecs[t, 'udp'])))
 
     for a in args.applications:
         d = sepolicy.get_init_transtype(a)
@@ -357,7 +357,7 @@ def manpage(args):
 
     for domain in test_domains:
         m = ManPage(domain, path, args.root, args.source_files, args.web)
-        print m.get_man_page_path()
+        print(m.get_man_page_path())
 
     if args.web:
         HTMLManPages(manpage_roles, manpage_domains, path, args.os)
@@ -418,7 +418,7 @@ def communicate(args):
     out = list(set(writable) & set(readable))
 
     for t in out:
-        print t
+        print(t)
 
 
 def gen_communicate_args(parser):
@@ -445,7 +445,7 @@ def booleans(args):
     args.booleans.sort()
 
     for b in args.booleans:
-        print "%s=_(\"%s\")" % (b, boolean_desc(b))
+        print("%s=_(\"%s\")" % (b, boolean_desc(b)))
 
 
 def gen_booleans_args(parser):
@@ -484,16 +484,16 @@ def print_interfaces(interfaces, args, append=""):
     for i in interfaces:
         if args.verbose:
             try:
-                print get_interface_format_text(i + append)
+                print(get_interface_format_text(i + append))
             except KeyError:
-                print i
+                print(i)
         if args.compile:
             try:
                 interface_compile_test(i)
             except KeyError:
-                print i
+                print(i)
         else:
-            print i
+            print(i)
 
 
 def interface(args):
@@ -520,7 +520,7 @@ def generate(args):
         for k in usage_dict:
             error_text += "%s" % (k)
         print(generate_usage)
-        print(_("sepolicy generate: error: one of the arguments %s is required") % error_text)
+        print((_("sepolicy generate: error: one of the arguments %s is required") % error_text))
         sys.exit(1)
 
     if args.policytype in APPLICATIONS:
@@ -565,7 +565,7 @@ def generate(args):
     if args.policytype in APPLICATIONS:
         mypolicy.gen_writeable()
         mypolicy.gen_symbols()
-    print mypolicy.generate(args.path)
+    print(mypolicy.generate(args.path))
 
 
 def gen_interface_args(parser):
@@ -698,12 +698,12 @@ if __name__ == '__main__':
         args = parser.parse_args(args=parser_args)
         args.func(args)
         sys.exit(0)
-    except ValueError, e:
+    except ValueError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
         sys.exit(1)
-    except IOError, e:
+    except IOError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
         sys.exit(1)
     except KeyboardInterrupt:
-        print "Out"
+        print("Out")
         sys.exit(0)
diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 8fbd5b4..9870b5f 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -29,8 +29,8 @@ except:
         import builtins
         builtins.__dict__['_'] = str
     except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
+        import builtins
+        builtins.__dict__['_'] = str
 
 TYPE = 1
 ROLE = 2
@@ -168,7 +168,7 @@ def info(setype, name=None):
             q.name = name
 
         return ({
-            'aliases': map(str, x.aliases()),
+            'aliases': list(map(str, x.aliases())),
             'name': str(x),
             'permissive': bool(x.ispermissive),
         } for x in q.results())
@@ -180,8 +180,8 @@ def info(setype, name=None):
 
         return ({
             'name': str(x),
-            'roles': map(str, x.expand()),
-            'types': map(str, x.types()),
+            'roles': list(map(str, x.expand())),
+            'types': list(map(str, x.types())),
         } for x in q.results())
 
     elif setype == ATTRIBUTE:
@@ -191,7 +191,7 @@ def info(setype, name=None):
 
         return ({
             'name': str(x),
-            'types': map(str, x.expand()),
+            'types': list(map(str, x.expand())),
         } for x in q.results())
 
     elif setype == PORT:
@@ -219,7 +219,7 @@ def info(setype, name=None):
         return ({
             'range': str(x.mls_range),
             'name': str(x),
-            'roles': map(str, x.roles),
+            'roles': list(map(str, x.roles)),
             'level': str(x.mls_level),
         } for x in q.results())
 
@@ -371,7 +371,7 @@ def get_conditionals(src, dest, tclass, perm):
                 allows = []
                 allows.append(i)
     try:
-        for i in map(lambda y: (y), filter(lambda x: set(perm).issubset(x[PERMS]) and x['boolean'], allows)):
+        for i in [(y) for y in [x for x in allows if set(perm).issubset(x[PERMS]) and x['boolean']]]:
             tdict.update({'source': i['source'], 'boolean': i['boolean']})
             if tdict not in tlist:
                 tlist.append(tdict)
@@ -383,8 +383,8 @@ def get_conditionals(src, dest, tclass, perm):
 
 
 def get_conditionals_format_text(cond):
-    enabled = len(filter(lambda x: x['boolean'][0][1], cond)) > 0
-    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['boolean'][0][0], x['boolean'][0][1]), cond))))
+    enabled = len([x for x in cond if x['boolean'][0][1]]) > 0
+    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(["%s=%d" % (x['boolean'][0][0], x['boolean'][0][1]) for x in cond])))
 
 
 def get_types_from_attribute(attribute):
@@ -448,7 +448,7 @@ def find_file(reg):
     try:
         pat = re.compile(r"%s$" % reg)
     except:
-        print("bad reg:", reg)
+        print(("bad reg:", reg))
         return []
     p = reg
     if p.endswith("(/.*)?"):
@@ -465,14 +465,14 @@ def find_file(reg):
 
     try:
         pat = re.compile(r"%s$" % reg)
-        return filter(pat.match, map(lambda x: path + x, os.listdir(path)))
+        return list(filter(pat.match, [path + x for x in os.listdir(path)]))
     except:
         return []
 
 
 def find_all_files(domain, exclude_list=[]):
     executable_files = get_entrypoints(domain)
-    for exe in executable_files.keys():
+    for exe in list(executable_files.keys()):
         if exe.endswith("_exec_t") and exe not in exclude_list:
             for path in executable_files[exe]:
                 for f in find_file(path):
@@ -589,7 +589,7 @@ def get_fcdict(fc_path=selinux.selinux_file_context_path()):
 
 def get_transitions_into(setype):
     try:
-        return filter(lambda x: x["transtype"] == setype, search([TRANSITION], {'class': 'process'}))
+        return [x for x in search([TRANSITION], {'class': 'process'}) if x["transtype"] == setype]
     except (TypeError, AttributeError):
         pass
     return None
@@ -605,7 +605,7 @@ def get_transitions(setype):
 
 def get_file_transitions(setype):
     try:
-        return filter(lambda x: x['class'] != "process", search([TRANSITION], {'source': setype}))
+        return [x for x in search([TRANSITION], {'source': setype}) if x['class'] != "process"]
     except (TypeError, AttributeError):
         pass
     return None
@@ -641,7 +641,7 @@ def get_entrypoint_types(setype):
 def get_init_transtype(path):
     entrypoint = selinux.getfilecon(path)[1].split(":")[2]
     try:
-        entrypoints = list(filter(lambda x: x['target'] == entrypoint, search([TRANSITION], {'source': "init_t", 'class': 'process'})))
+        entrypoints = list([x for x in search([TRANSITION], {'source': "init_t", 'class': 'process'}) if x['target'] == entrypoint])
         return entrypoints[0]["transtype"]
     except (TypeError, AttributeError, IndexError):
         pass
@@ -666,7 +666,7 @@ def get_init_entrypoint(transtype):
 
 def get_init_entrypoint_target(entrypoint):
     try:
-        entrypoints = map(lambda x: x['transtype'], search([TRANSITION], {'source': "init_t", 'target': entrypoint, 'class': 'process'}))
+        entrypoints = [x['transtype'] for x in search([TRANSITION], {'source': "init_t", 'target': entrypoint, 'class': 'process'})]
         return list(entrypoints)[0]
     except (TypeError, IndexError):
         pass
@@ -695,7 +695,7 @@ def get_methods():
     # List of per_role_template interfaces
         ifs = interfaces.InterfaceSet()
         ifs.from_file(fd)
-        methods = ifs.interfaces.keys()
+        methods = list(ifs.interfaces.keys())
         fd.close()
     except:
         sys.stderr.write("could not open interface info [%s]\n" % fn)
@@ -752,7 +752,7 @@ def get_all_entrypoint_domains():
 
 
 def gen_interfaces():
-    import commands
+    import subprocess
     ifile = defaults.interface_info()
     headers = defaults.headers()
     try:
@@ -763,7 +763,7 @@ def gen_interfaces():
 
     if os.getuid() != 0:
         raise ValueError(_("You must regenerate interface info by running /usr/bin/sepolgen-ifgen"))
-    print(commands.getstatusoutput("/usr/bin/sepolgen-ifgen")[1])
+    print((subprocess.getstatusoutput("/usr/bin/sepolgen-ifgen")[1]))
 
 
 def gen_port_dict():
@@ -837,7 +837,7 @@ def get_login_mappings():
 
 
 def get_all_users():
-    return sorted(map(lambda x: x['name'], get_selinux_users()))
+    return sorted([x['name'] for x in get_selinux_users()])
 
 
 def get_all_file_types():
@@ -967,7 +967,7 @@ def get_description(f, markup=markup):
 def get_all_attributes():
     global all_attributes
     if not all_attributes:
-        all_attributes = list(sorted(map(lambda x: x['name'], info(ATTRIBUTE))))
+        all_attributes = list(sorted([x['name'] for x in info(ATTRIBUTE)]))
     return all_attributes
 
 
@@ -997,7 +997,7 @@ def get_bools(setype):
     bools = []
     domainbools = []
     domainname, short_name = gen_short_name(setype)
-    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x, search([ALLOW], {'source': setype}))):
+    for i in [x['boolean'] for x in [x for x in search([ALLOW], {'source': setype}) if 'boolean' in x]]:
         for b in i:
             if not isinstance(b, tuple):
                 continue
@@ -1085,8 +1085,8 @@ def get_os_version():
     os_version = ""
     pkg_name = "selinux-policy"
     try:
-        import commands
-        rc, output = commands.getstatusoutput("rpm -q '%s'" % pkg_name)
+        import subprocess
+        rc, output = subprocess.getstatusoutput("rpm -q '%s'" % pkg_name)
         if rc == 0:
             os_version = output.split(".")[-2]
     except:
diff --git a/policycoreutils/sepolicy/sepolicy/booleans.py b/policycoreutils/sepolicy/sepolicy/booleans.py
index cf5f1ff..83ec592 100644
--- a/policycoreutils/sepolicy/sepolicy/booleans.py
+++ b/policycoreutils/sepolicy/sepolicy/booleans.py
@@ -36,6 +36,6 @@ def get_types(src, tclass, perm):
         raise TypeError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
 
     tlist = []
-    for l in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
+    for l in [y[sepolicy.TARGET] for y in [x for x in allows if set(perm).issubset(x[sepolicy.PERMS])]]:
         tlist = tlist + expand_attribute(l)
     return tlist
diff --git a/policycoreutils/sepolicy/sepolicy/communicate.py b/policycoreutils/sepolicy/sepolicy/communicate.py
index b96c4b9..f1c7607 100755
--- a/policycoreutils/sepolicy/sepolicy/communicate.py
+++ b/policycoreutils/sepolicy/sepolicy/communicate.py
@@ -45,6 +45,6 @@ def get_types(src, tclass, perm):
         raise ValueError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
 
     tlist = []
-    for l in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
+    for l in [y[sepolicy.TARGET] for y in [x for x in allows if set(perm).issubset(x[sepolicy.PERMS])]]:
         tlist = tlist + expand_attribute(l)
     return tlist
diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index 65b33b6..a7f7b21 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -31,21 +31,21 @@ import time
 import types
 import platform
 
-from templates import executable
-from templates import boolean
-from templates import etc_rw
-from templates import unit_file
-from templates import var_cache
-from templates import var_spool
-from templates import var_lib
-from templates import var_log
-from templates import var_run
-from templates import tmp
-from templates import rw
-from templates import network
-from templates import script
-from templates import spec
-from templates import user
+from .templates import executable
+from .templates import boolean
+from .templates import etc_rw
+from .templates import unit_file
+from .templates import var_cache
+from .templates import var_spool
+from .templates import var_lib
+from .templates import var_log
+from .templates import var_run
+from .templates import tmp
+from .templates import rw
+from .templates import network
+from .templates import script
+from .templates import spec
+from .templates import user
 import sepolgen.interfaces as interfaces
 import sepolgen.defaults as defaults
 
@@ -67,8 +67,8 @@ except:
         import builtins
         builtins.__dict__['_'] = str
     except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
+        import builtins
+        builtins.__dict__['_'] = str
 
 
 def get_rpm_nvr_from_header(hdr):
@@ -92,7 +92,7 @@ def get_rpm_nvr_list(package):
             nvr = get_rpm_nvr_from_header(h)
             break
     except:
-        print("Failed to retrieve rpm info for %s") % package
+        print(("Failed to retrieve rpm info for %s") % package)
         nvr = None
 
     return nvr
@@ -110,7 +110,7 @@ def get_all_ports():
 
 
 def get_all_users():
-    users = map(lambda x: x['name'], sepolicy.info(sepolicy.USER))
+    users = [x['name'] for x in sepolicy.info(sepolicy.USER)]
     users.remove("system_u")
     users.remove("root")
     users.sort()
@@ -154,7 +154,7 @@ poltype[NEWTYPE] = _("Module information for a new type")
 
 
 def get_poltype_desc():
-    keys = poltype.keys()
+    keys = list(poltype.keys())
     keys.sort()
     msg = _("Valid Types:\n")
     for k in keys:
@@ -212,7 +212,7 @@ class policy:
         except ValueError as e:
             print("Can not get port types, must be root for this information")
         except RuntimeError as e:
-            print("Can not get port types", e)
+            print(("Can not get port types", e))
 
         self.symbols = {}
         self.symbols["openlog"] = "set_use_kerberos(True)"
@@ -429,7 +429,7 @@ class policy:
         return self.use_tcp() or self.use_udp()
 
     def find_port(self, port, protocol="tcp"):
-        for begin, end, p in self.ports.keys():
+        for begin, end, p in list(self.ports.keys()):
             if port >= begin and port <= end and protocol == p:
                 return self.ports[begin, end, protocol]
         return None
@@ -459,25 +459,25 @@ class policy:
         self.out_udp = [all, False, False, verify_ports(ports)]
 
     def set_use_resolve(self, val):
-        if not isinstance(val, types.BooleanType):
+        if not isinstance(val, bool):
             raise ValueError(_("use_resolve must be a boolean value "))
 
         self.use_resolve = val
 
     def set_use_syslog(self, val):
-        if not isinstance(val, types.BooleanType):
+        if not isinstance(val, bool):
             raise ValueError(_("use_syslog must be a boolean value "))
 
         self.use_syslog = val
 
     def set_use_kerberos(self, val):
-        if not isinstance(val, types.BooleanType):
+        if not isinstance(val, bool):
             raise ValueError(_("use_kerberos must be a boolean value "))
 
         self.use_kerberos = val
 
     def set_manage_krb5_rcache(self, val):
-        if not isinstance(val, types.BooleanType):
+        if not isinstance(val, bool):
             raise ValueError(_("manage_krb5_rcache must be a boolean value "))
 
         self.manage_krb5_rcache = val
@@ -875,7 +875,7 @@ allow %s_t %s_t:%s_socket name_%s;
         for t in self.types:
             for i in self.DEFAULT_EXT:
                 if t.endswith(i):
-                    print(t, t[:-len(i)])
+                    print((t, t[:-len(i)]))
                     newte += re.sub("TEMPLATETYPE", t[:-len(i)], self.DEFAULT_EXT[i].te_types)
                     break
 
@@ -1093,7 +1093,7 @@ allow %s_t %s_t:%s_socket name_%s;
     def generate_fc(self):
         newfc = ""
         fclist = []
-        for i in self.files.keys():
+        for i in list(self.files.keys()):
             if os.path.exists(i) and stat.S_ISSOCK(os.stat(i)[stat.ST_MODE]):
                 t1 = re.sub("TEMPLATETYPE", self.name, self.files[i][2].fc_sock_file)
             else:
@@ -1101,7 +1101,7 @@ allow %s_t %s_t:%s_socket name_%s;
             t2 = re.sub("FILENAME", i, t1)
             fclist.append(re.sub("FILETYPE", self.files[i][0], t2))
 
-        for i in self.dirs.keys():
+        for i in list(self.dirs.keys()):
             t1 = re.sub("TEMPLATETYPE", self.name, self.dirs[i][2].fc_dir)
             t2 = re.sub("FILENAME", i, t1)
             fclist.append(re.sub("FILETYPE", self.dirs[i][0], t2))
@@ -1164,10 +1164,10 @@ allow %s_t %s_t:%s_socket name_%s;
         if self.initscript != "":
             newsh += re.sub("FILENAME", self.initscript, script.restorecon)
 
-        for i in self.files.keys():
+        for i in list(self.files.keys()):
             newsh += re.sub("FILENAME", i, script.restorecon)
 
-        for i in self.dirs.keys():
+        for i in list(self.dirs.keys()):
             newsh += re.sub("FILENAME", i, script.restorecon)
 
         for i in self.in_tcp[PORTS] + self.out_tcp[PORTS]:
@@ -1203,9 +1203,9 @@ allow %s_t %s_t:%s_socket name_%s;
                 newspec += re.sub("FILENAME", self.program, spec.define_relabel_files_end)
             if self.initscript != "":
                 newspec += re.sub("FILENAME", self.initscript, spec.define_relabel_files_end)
-            for i in self.files.keys():
+            for i in list(self.files.keys()):
                 newspec += re.sub("FILENAME", i, spec.define_relabel_files_end)
-            for i in self.dirs.keys():
+            for i in list(self.dirs.keys()):
                 newspec += re.sub("FILENAME", i, spec.define_relabel_files_end)
 
         newspec += re.sub("VERSION", selinux_policyver, spec.base_section)
@@ -1334,7 +1334,7 @@ allow %s_t %s_t:%s_socket name_%s;
         # we don't want to have subdir in the .fc policy file
         # if we already specify labeling for parent dir
         temp_basepath = []
-        for p in self.DEFAULT_DIRS.keys():
+        for p in list(self.DEFAULT_DIRS.keys()):
             temp_dirs = []
             try:
                 temp_basepath = self.DEFAULT_DIRS[p][1][0] + "/"
@@ -1349,9 +1349,9 @@ allow %s_t %s_t:%s_socket name_%s;
 
             if len(temp_dirs) is not 0:
                 for i in temp_dirs:
-                    if i in self.dirs.keys():
+                    if i in list(self.dirs.keys()):
                         del(self.dirs[i])
-                    elif i in self.files.keys():
+                    elif i in list(self.files.keys()):
                         del(self.files[i])
                     else:
                         continue
diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 7f1888c..cd7ca29 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -56,8 +56,8 @@ except:
         import builtins
         builtins.__dict__['_'] = str
     except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
+        import builtins
+        builtins.__dict__['_'] = str
 
 reverse_file_type_str = {}
 for f in sepolicy.file_type_str:
@@ -835,7 +835,7 @@ class SELinuxGui():
 
     def populate_system_policy(self):
         selinux_path = selinux.selinux_path()
-        types = map(lambda x: x[1], filter(lambda x: x[0] == selinux_path, os.walk(selinux_path)))[0]
+        types = map(lambda x: x[1], [x for x in os.walk(selinux_path) if x[0] == selinux_path])[0]
         types.sort()
         ctr = 0
         for item in types:
@@ -867,7 +867,7 @@ class SELinuxGui():
         return False
 
     def net_update(self, app, netd, protocol, direction, model):
-        for k in netd.keys():
+        for k in list(netd.keys()):
             for t, ports in netd[k]:
                 pkey = (",".join(ports), protocol)
                 if pkey in self.cur_dict["port"]:
@@ -1124,7 +1124,7 @@ class SELinuxGui():
 
     def executable_files_initialize(self, application):
         self.entrypoints = sepolicy.get_entrypoints(application)
-        for exe in self.entrypoints.keys():
+        for exe in list(self.entrypoints.keys()):
             if len(self.entrypoints[exe]) == 0:
                 continue
             file_class = self.entrypoints[exe][1]
@@ -1161,7 +1161,7 @@ class SELinuxGui():
     def writable_files_initialize(self, application):
         # Traversing the dictionary data struct
         self.writable_files = sepolicy.get_writable_files(application)
-        for write in self.writable_files.keys():
+        for write in list(self.writable_files.keys()):
             if len(self.writable_files[write]) < 2:
                 self.files_initial_data_insert(self.writable_files_liststore, None, write, _("all files"))
                 continue
@@ -1204,7 +1204,7 @@ class SELinuxGui():
 
     def application_files_initialize(self, application):
         self.file_types = sepolicy.get_file_types(application)
-        for app in self.file_types.keys():
+        for app in list(self.file_types.keys()):
             if len(self.file_types[app]) == 0:
                 continue
             file_class = self.file_types[app][1]
@@ -1646,7 +1646,7 @@ class SELinuxGui():
                 self.files_class_combolist.set_value(iter, 0, sepolicy.file_type_str[files])
 
             if ipage == EXE_PAGE and self.entrypoints != None:
-                for exe in self.entrypoints.keys():
+                for exe in list(self.entrypoints.keys()):
                     if exe.startswith(compare):
                         iter = self.files_type_combolist.append()
                         self.files_type_combolist.set_value(iter, 0, exe)
@@ -1656,7 +1656,7 @@ class SELinuxGui():
                 self.files_class_combobox.set_sensitive(False)
 
             elif ipage == WRITABLE_PAGE and self.writable_files != None:
-                for write in self.writable_files.keys():
+                for write in list(self.writable_files.keys()):
                     if write.startswith(compare) and not self.exclude_type(write, exclude_list) and write in self.file_types:
                         iter = self.files_type_combolist.append()
                         self.files_type_combolist.set_value(iter, 0, write)
@@ -1720,7 +1720,7 @@ class SELinuxGui():
                 netd += sepolicy.network.get_network_connect(self.application, "udp", "name_bind")
 
             port_types = []
-            for k in netd.keys():
+            for k in list(netd.keys()):
                 for t, ports in netd[k]:
                     if t not in port_types + ["port_t", "unreserved_port_t"]:
                         if t.endswith("_type"):
@@ -2147,7 +2147,7 @@ class SELinuxGui():
 
     def on_save_delete_file_equiv_clicked(self, *args):
         for delete in self.files_delete_liststore:
-            print(delete[0], delete[1], delete[2],)
+            print((delete[0], delete[1], delete[2],))
 
     def on_toggle_update(self, cell, path, model):
         model[path][0] = not model[path][0]
diff --git a/policycoreutils/sepolicy/sepolicy/interface.py b/policycoreutils/sepolicy/sepolicy/interface.py
index c2cb971..1e42f4f 100644
--- a/policycoreutils/sepolicy/sepolicy/interface.py
+++ b/policycoreutils/sepolicy/sepolicy/interface.py
@@ -47,15 +47,15 @@ except:
         import builtins
         builtins.__dict__['_'] = str
     except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
+        import builtins
+        builtins.__dict__['_'] = str
 
 
 def get_interfaces_from_xml(path):
     """ Get all interfaces from given xml file"""
     interfaces_list = []
     idict = get_interface_dict(path)
-    for k in idict.keys():
+    for k in list(idict.keys()):
         interfaces_list.append(k)
     return interfaces_list
 
@@ -80,7 +80,7 @@ def get_admin(path=""):
         try:
             xml_path = get_xml_file(path)
             idict = get_interface_dict(xml_path)
-            for k in idict.keys():
+            for k in list(idict.keys()):
                 if k.endswith("_admin"):
                     admin_list.append(k)
         except IOError as e:
@@ -102,7 +102,7 @@ def get_user(path=""):
         try:
             xml_path = get_xml_file(path)
             idict = get_interface_dict(xml_path)
-            for k in idict.keys():
+            for k in list(idict.keys()):
                 if k.endswith("_role"):
                     if (("%s_exec_t" % k[:-5]) in sepolicy.get_all_types()):
                         trans_list.append(k)
@@ -171,7 +171,7 @@ def get_interface_format_text(interface, path="/usr/share/selinux/devel/policy.x
 
 
 def get_interface_compile_format_text(interfaces_dict, interface):
-    from templates import test_module
+    from .templates import test_module
     param_tmp = []
     for i in interfaces_dict[interface][0]:
         param_tmp.append(test_module.dict_values[i])
@@ -181,7 +181,7 @@ def get_interface_compile_format_text(interfaces_dict, interface):
 
 
 def generate_compile_te(interface, idict, name="compiletest"):
-    from templates import test_module
+    from .templates import test_module
     te = ""
     te += re.sub("TEMPLATETYPE", name, test_module.te_test_module)
     te += get_interface_compile_format_text(idict, interface)
@@ -192,10 +192,10 @@ def generate_compile_te(interface, idict, name="compiletest"):
 def get_xml_file(if_file):
     """ Returns xml format of interfaces for given .if policy file"""
     import os
-    import commands
+    import subprocess
     basedir = os.path.dirname(if_file) + "/"
     filename = os.path.basename(if_file).split(".")[0]
-    rc, output = commands.getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
+    rc, output = subprocess.getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
     if rc != 0:
         sys.stderr.write("\n Could not proceed selected interface file.\n")
         sys.stderr.write("\n%s" % output)
@@ -208,25 +208,25 @@ def interface_compile_test(interface, path="/usr/share/selinux/devel/policy.xml"
     exclude_interfaces = ["userdom", "kernel", "corenet", "files", "dev"]
     exclude_interface_type = ["template"]
 
-    import commands
+    import subprocess
     import os
     policy_files = {'pp': "compiletest.pp", 'te': "compiletest.te", 'fc': "compiletest.fc", 'if': "compiletest.if"}
     idict = get_interface_dict(path)
 
     if not (interface.split("_")[0] in exclude_interfaces or idict[interface][2] in exclude_interface_type):
-        print(_("Compiling %s interface" % interface))
+        print((_("Compiling %s interface" % interface)))
         try:
             fd = open(policy_files['te'], "w")
             fd.write(generate_compile_te(interface, idict))
             fd.close()
-            rc, output = commands.getstatusoutput("make -f /usr/share/selinux/devel/Makefile %s" % policy_files['pp'])
+            rc, output = subprocess.getstatusoutput("make -f /usr/share/selinux/devel/Makefile %s" % policy_files['pp'])
             if rc != 0:
                 sys.stderr.write(output)
                 sys.stderr.write(_("\nCompile test for %s failed.\n") % interface)
 
         except EnvironmentError as e:
             sys.stderr.write(_("\nCompile test for %s has not run. %s\n") % (interface, e))
-        for v in policy_files.values():
+        for v in list(policy_files.values()):
             if os.path.exists(v):
                 os.remove(v)
 
diff --git a/policycoreutils/sepolicy/sepolicy/manpage.py b/policycoreutils/sepolicy/sepolicy/manpage.py
index 7365f93..35ea19a 100755
--- a/policycoreutils/sepolicy/sepolicy/manpage.py
+++ b/policycoreutils/sepolicy/sepolicy/manpage.py
@@ -27,7 +27,7 @@ __all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_d
 import string
 import selinux
 import sepolicy
-import commands
+import subprocess
 import os
 import time
 
@@ -162,9 +162,9 @@ def get_alphabet_manpages(manpage_list):
 
 
 def convert_manpage_to_html(html_manpage, manpage):
-    rc, output = commands.getstatusoutput("/usr/bin/groff -man -Thtml %s 2>/dev/null" % manpage)
+    rc, output = subprocess.getstatusoutput("/usr/bin/groff -man -Thtml %s 2>/dev/null" % manpage)
     if rc == 0:
-        print(html_manpage, "has been created")
+        print((html_manpage, "has been created"))
         fd = open(html_manpage, 'w')
         fd.write(output)
         fd.close()
@@ -186,7 +186,7 @@ class HTMLManPages:
         if self.os_version in fedora_releases or rhel_releases:
             self.__gen_html_manpages()
         else:
-            print("SELinux HTML man pages can not be generated for this %s" % os_version)
+            print(("SELinux HTML man pages can not be generated for this %s" % os_version))
             exit(1)
 
     def __gen_html_manpages(self):
@@ -199,12 +199,12 @@ class HTMLManPages:
         if not os.path.isdir(self.new_path):
             os.mkdir(self.new_path)
 
-        for domain in self.manpage_domains.values():
+        for domain in list(self.manpage_domains.values()):
             if len(domain):
                 for d in domain:
                     convert_manpage_to_html((self.new_path + d.split("_selinux")[0] + ".html"), self.old_path + d)
 
-        for role in self.manpage_roles.values():
+        for role in list(self.manpage_roles.values()):
             if len(role):
                 for r in role:
                     convert_manpage_to_html((self.new_path + r.split("_selinux")[0] + ".html"), self.old_path + r)
@@ -253,7 +253,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
 </pre>
 	""")
         fd.close()
-        print("%s has been created") % index
+        print(("%s has been created") % index)
 
     def _gen_body(self):
         html = self.new_path + self.os_version + ".html"
@@ -324,7 +324,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
 """ % domainname_body)
 
         fd.close()
-        print("%s has been created") % html
+        print(("%s has been created") % html)
 
     def _gen_css(self):
         style_css = self.old_path + "style.css"
@@ -387,7 +387,7 @@ pre.code {
 """)
 
         fd.close()
-        print("%s has been created") % style_css
+        print(("%s has been created") % style_css)
 
 
 class ManPage:
@@ -449,7 +449,7 @@ class ManPage:
             self.__gen_man_page()
         self.fd.close()
 
-        for k in equiv_dict.keys():
+        for k in list(equiv_dict.keys()):
             if k == self.domainname:
                 for alias in equiv_dict[k]:
                     self.__gen_man_page_link(alias)
@@ -596,7 +596,7 @@ SELinux policy is customizable based on least access required.  %s policy is ext
         nsswitch_types = []
         nsswitch_booleans = ['authlogin_nsswitch_use_ldap', 'kerberos_enabled']
         nsswitchbooltext = ""
-        for k in self.attributes.keys():
+        for k in list(self.attributes.keys()):
             if "nsswitch_domain" in self.attributes[k]:
                 nsswitch_types.append(k)
 
@@ -890,7 +890,7 @@ selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
 
     def _entrypoints(self):
         try:
-            entrypoints = map(lambda x: x['target'], sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['entrypoint'], 'class': 'file'}))
+            entrypoints = [x['target'] for x in sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['entrypoint'], 'class': 'file'})]
         except:
             return
 
diff --git a/policycoreutils/sepolicy/sepolicy/network.py b/policycoreutils/sepolicy/sepolicy/network.py
index c4d95da..7b5b7e9 100755
--- a/policycoreutils/sepolicy/sepolicy/network.py
+++ b/policycoreutils/sepolicy/sepolicy/network.py
@@ -27,7 +27,7 @@ def get_types(src, tclass, perm):
     allows = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
     nlist = []
     if allows:
-        for i in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
+        for i in [y[sepolicy.TARGET] for y in [x for x in allows if set(perm).issubset(x[sepolicy.PERMS])]]:
             if i not in nlist:
                 nlist.append(i)
     return nlist
diff --git a/policycoreutils/sepolicy/sepolicy/transition.py b/policycoreutils/sepolicy/sepolicy/transition.py
index ad53cef..dd032a5 100755
--- a/policycoreutils/sepolicy/sepolicy/transition.py
+++ b/policycoreutils/sepolicy/sepolicy/transition.py
@@ -26,7 +26,7 @@ __all__ = ['setrans']
 
 def _entrypoint(src):
     trans = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src})
-    return map(lambda y: y[sepolicy.TARGET], filter(lambda x: "entrypoint" in x[sepolicy.PERMS], trans))
+    return [y[sepolicy.TARGET] for y in [x for x in trans if "entrypoint" in x[sepolicy.PERMS]]]
 
 
 def _get_trans(src):
@@ -53,8 +53,8 @@ class setrans:
         if not self.dest:
             self.sdict[source]["map"] = trans
         else:
-            self.sdict[source]["map"] = map(lambda y: y, filter(lambda x: x["transtype"] == self.dest, trans))
-            self.sdict[source]["child"] = map(lambda y: y["transtype"], filter(lambda x: x["transtype"] not in [self.dest, source], trans))
+            self.sdict[source]["map"] = [y for y in [x for x in trans if x["transtype"] == self.dest]]
+            self.sdict[source]["child"] = [y["transtype"] for y in [x for x in trans if x["transtype"] not in [self.dest, source]]]
             for s in self.sdict[source]["child"]:
                 self._process(s)
 
@@ -79,4 +79,4 @@ class setrans:
 
     def output(self):
         self.seen = []
-        print(self.out(self.source))
+        print((self.out(self.source)))
diff --git a/policycoreutils/sepolicy/test_sepolicy.py b/policycoreutils/sepolicy/test_sepolicy.py
index 61dfb45..8f63b84 100644
--- a/policycoreutils/sepolicy/test_sepolicy.py
+++ b/policycoreutils/sepolicy/test_sepolicy.py
@@ -8,11 +8,11 @@ from subprocess import Popen, PIPE
 class SepolicyTests(unittest.TestCase):
 
     def assertDenied(self, err):
-        self.assert_('Permission denied' in err,
+        self.assertTrue('Permission denied' in err,
                      '"Permission denied" not found in %r' % err)
 
     def assertNotFound(self, err):
-        self.assert_('not found' in err,
+        self.assertTrue('not found' in err,
                      '"not found" not found in %r' % err)
 
     def assertFailure(self, status):
-- 
2.10.2
