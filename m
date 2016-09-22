Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFIW5E015315
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id n24so3940552pfb.3
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:11 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] sepolicy: info() and search() will return generators
Date: Thu, 22 Sep 2016 23:17:30 +0800
Message-Id: <1474557453-14379-5-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The next patch will update info() and search() to use the setools4 api.
setools4 makes heavy use of generators so info() and search() will as
well. Pre-emptively update users to cast to a list where required.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sandbox/sandbox               |  2 +-
 policycoreutils/semanage/seobject.py          |  9 +++--
 policycoreutils/sepolicy/sepolicy/__init__.py | 51 +++++++++++----------------
 3 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 4ed57c1..2628802 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -301,7 +301,7 @@ kill -TERM $WM_PID  2> /dev/null
             types = _("""
 Policy defines the following types for use with the -t:
 \t%s
-""") % "\n\t".join(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type")[0]['types'])
+""") % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))[0]['types'])
         except RuntimeError:
             pass
 
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 81dcd86..bb049c0 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -32,7 +32,6 @@ import socket
 from semanage import *
 PROGNAME = "policycoreutils"
 import sepolicy
-sepolicy.gen_bool_dict()
 from IPy import IP
 
 try:
@@ -1038,7 +1037,7 @@ class seluserRecords(semanageRecords):
 
 class portRecords(semanageRecords):
     try:
-        valid_types = sepolicy.info(sepolicy.ATTRIBUTE, "port_type")[0]["types"]
+        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
     except RuntimeError:
         valid_types = []
 
@@ -1313,7 +1312,7 @@ class portRecords(semanageRecords):
 
 class nodeRecords(semanageRecords):
     try:
-        valid_types = sepolicy.info(sepolicy.ATTRIBUTE, "node_type")[0]["types"]
+        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
     except RuntimeError:
         valid_types = []
 
@@ -1744,8 +1743,8 @@ class interfaceRecords(semanageRecords):
 
 class fcontextRecords(semanageRecords):
     try:
-        valid_types = sepolicy.info(sepolicy.ATTRIBUTE, "file_type")[0]["types"]
-        valid_types += sepolicy.info(sepolicy.ATTRIBUTE, "device_node")[0]["types"]
+        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
+        valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
         valid_types.append("<<none>>")
     except RuntimeError:
         valid_types = []
diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 37946f3..319cb34 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -217,7 +217,7 @@ def get_conditionals_format_text(cond):
 
 
 def get_types_from_attribute(attribute):
-    return info(ATTRIBUTE, attribute)[0]["types"]
+    return list(info(ATTRIBUTE, attribute))[0]["types"]
 
 
 def get_file_types(setype):
@@ -236,7 +236,6 @@ def get_file_types(setype):
 
 
 def get_writable_files(setype):
-    all_attributes = get_all_attributes()
     file_types = get_all_file_types()
     all_writes = []
     mpaths = {}
@@ -420,7 +419,7 @@ def get_fcdict(fc_path=selinux.selinux_file_context_path()):
 def get_transitions_into(setype):
     try:
         return filter(lambda x: x["transtype"] == setype, search([TRANSITION], {'class': 'process'}))
-    except TypeError:
+    except (TypeError, AttributeError):
         pass
     return None
 
@@ -428,7 +427,7 @@ def get_transitions_into(setype):
 def get_transitions(setype):
     try:
         return search([TRANSITION], {'source': setype, 'class': 'process'})
-    except TypeError:
+    except (TypeError, AttributeError):
         pass
     return None
 
@@ -436,7 +435,7 @@ def get_transitions(setype):
 def get_file_transitions(setype):
     try:
         return filter(lambda x: x['class'] != "process", search([TRANSITION], {'source': setype}))
-    except TypeError:
+    except (TypeError, AttributeError):
         pass
     return None
 
@@ -471,11 +470,9 @@ def get_entrypoint_types(setype):
 def get_init_transtype(path):
     entrypoint = selinux.getfilecon(path)[1].split(":")[2]
     try:
-        entrypoints = filter(lambda x: x['target'] == entrypoint, search([TRANSITION], {'source': "init_t", 'class': 'process'}))
-        if len(entrypoints) == 0:
-            return None
+        entrypoints = list(filter(lambda x: x['target'] == entrypoint, search([TRANSITION], {'source': "init_t", 'class': 'process'})))
         return entrypoints[0]["transtype"]
-    except TypeError:
+    except (TypeError, AttributeError, IndexError):
         pass
     return None
 
@@ -499,8 +496,8 @@ def get_init_entrypoint(transtype):
 def get_init_entrypoint_target(entrypoint):
     try:
         entrypoints = map(lambda x: x['transtype'], search([TRANSITION], {'source': "init_t", 'target': entrypoint, 'class': 'process'}))
-        return entrypoints[0]
-    except TypeError:
+        return list(entrypoints)[0]
+    except (TypeError, IndexError):
         pass
     return None
 
@@ -540,14 +537,14 @@ def get_methods():
 def get_all_types():
     global all_types
     if all_types is None:
-        all_types = map(lambda x: x['name'], info(TYPE))
+        all_types = [x['name'] for x in info(TYPE)]
     return all_types
 
 
 def get_user_types():
     global user_types
     if user_types is None:
-        user_types = info(ATTRIBUTE, "userdomain")[0]["types"]
+        user_types = list(list(info(ATTRIBUTE, "userdomain"))[0]["types"])
     return user_types
 
 
@@ -574,8 +571,7 @@ def get_all_role_allows():
 def get_all_entrypoint_domains():
     import re
     all_domains = []
-    types = get_all_types()
-    types.sort()
+    types = sorted(get_all_types())
     for i in types:
         m = re.findall("(.*)%s" % "_exec_t$", i)
         if len(m) > 0:
@@ -588,7 +584,6 @@ def gen_interfaces():
     import commands
     ifile = defaults.interface_info()
     headers = defaults.headers()
-    rebuild = False
     try:
         if os.stat(headers).st_mtime <= os.stat(ifile).st_mtime:
             return
@@ -629,7 +624,7 @@ def gen_port_dict():
 def get_all_domains():
     global all_domains
     if not all_domains:
-        all_domains = info(ATTRIBUTE, "domain")[0]["types"]
+        all_domains = list(list(info(ATTRIBUTE, "domain"))[0]["types"])
     return all_domains
 
 
@@ -637,16 +632,16 @@ def get_all_roles():
     global roles
     if roles:
         return roles
-    roles = map(lambda x: x['name'], info(ROLE))
-    roles.remove("object_r")
-    roles.sort()
+
+    q = setools.RoleQuery(_pol)
+    roles = [str(x) for x in q.results() if str(x) != "object_r"]
     return roles
 
 
 def get_selinux_users():
     global selinux_user_list
     if not selinux_user_list:
-        selinux_user_list = info(USER)
+        selinux_user_list = list(info(USER))
         for x in selinux_user_list:
             x['range'] = "".join(x['range'].split(" "))
     return selinux_user_list
@@ -671,17 +666,14 @@ def get_login_mappings():
 
 
 def get_all_users():
-    users = map(lambda x: x['name'], get_selinux_users())
-    users.sort()
-    return users
+    return sorted(map(lambda x: x['name'], get_selinux_users()))
 
 
 def get_all_file_types():
     global file_types
     if file_types:
         return file_types
-    file_types = info(ATTRIBUTE, "file_type")[0]["types"]
-    file_types.sort()
+    file_types = list(sorted(info(ATTRIBUTE, "file_type"))[0]["types"])
     return file_types
 
 
@@ -689,15 +681,14 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = info(ATTRIBUTE, "port_type")[0]["types"]
-    port_types.sort()
+    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
     return port_types
 
 
 def get_all_bools():
     global bools
     if not bools:
-        bools = info(BOOLEAN)
+        bools = list(info(BOOLEAN))
     return bools
 
 
@@ -805,7 +796,7 @@ def get_description(f, markup=markup):
 def get_all_attributes():
     global all_attributes
     if not all_attributes:
-        all_attributes = map(lambda x: x['name'], info(ATTRIBUTE))
+        all_attributes = list(sorted(map(lambda x: x['name'], info(ATTRIBUTE))))
     return all_attributes
 
 
-- 
2.7.3
