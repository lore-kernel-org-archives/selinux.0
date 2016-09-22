Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFI2iC015286
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id q2so3941243pfj.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:00 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] sepolicy: rearrange vars together at the top
Date: Thu, 22 Sep 2016 23:17:27 +0800
Message-Id: <1474557453-14379-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This has no functional or code changes other than grouping lines
together for clarity.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 229 ++++++++++++--------------
 1 file changed, 106 insertions(+), 123 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index c8d3b90..4d9d6ad 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -51,6 +51,112 @@ TRANSITION = 'transition'
 ROLE_ALLOW = 'role_allow'
 
 
+# Autofill for adding files *************************
+DEFAULT_DIRS = {}
+DEFAULT_DIRS["/etc"] = "etc_t"
+DEFAULT_DIRS["/tmp"] = "tmp_t"
+DEFAULT_DIRS["/usr/lib/systemd/system"] = "unit_file_t"
+DEFAULT_DIRS["/lib/systemd/system"] = "unit_file_t"
+DEFAULT_DIRS["/etc/systemd/system"] = "unit_file_t"
+DEFAULT_DIRS["/var/cache"] = "var_cache_t"
+DEFAULT_DIRS["/var/lib"] = "var_lib_t"
+DEFAULT_DIRS["/var/log"] = "log_t"
+DEFAULT_DIRS["/var/run"] = "var_run_t"
+DEFAULT_DIRS["/run"] = "var_run_t"
+DEFAULT_DIRS["/run/lock"] = "var_lock_t"
+DEFAULT_DIRS["/var/run/lock"] = "var_lock_t"
+DEFAULT_DIRS["/var/spool"] = "var_spool_t"
+DEFAULT_DIRS["/var/www"] = "content_t"
+
+file_type_str = {}
+file_type_str["a"] = _("all files")
+file_type_str["f"] = _("regular file")
+file_type_str["d"] = _("directory")
+file_type_str["c"] = _("character device")
+file_type_str["b"] = _("block device")
+file_type_str["s"] = _("socket file")
+file_type_str["l"] = _("symbolic link")
+file_type_str["p"] = _("named pipe")
+
+trans_file_type_str = {}
+trans_file_type_str[""] = "a"
+trans_file_type_str["--"] = "f"
+trans_file_type_str["-d"] = "d"
+trans_file_type_str["-c"] = "c"
+trans_file_type_str["-b"] = "b"
+trans_file_type_str["-s"] = "s"
+trans_file_type_str["-l"] = "l"
+trans_file_type_str["-p"] = "p"
+
+# cache the lookup results
+file_equiv_modified = None
+file_equiv = None
+local_files = None
+fcdict = None
+methods = []
+all_types = None
+user_types = None
+role_allows = None
+portrecs = None
+portrecsbynum = None
+all_domains = None
+roles = None
+selinux_user_list = None
+login_mappings = None
+file_types = None
+port_types = None
+bools = None
+all_attributes = None
+booleans = None
+booleans_dict = None
+
+
+def get_installed_policy(root="/"):
+    try:
+        path = root + selinux.selinux_binary_policy_path()
+        policies = glob.glob("%s.*" % path)
+        policies.sort()
+        return policies[-1]
+    except:
+        pass
+    raise ValueError(_("No SELinux Policy installed"))
+
+
+def policy(policy_file):
+    global all_domains
+    global all_attributes
+    global bools
+    global all_types
+    global role_allows
+    global users
+    global roles
+    global file_types
+    global port_types
+    all_domains = None
+    all_attributes = None
+    bools = None
+    all_types = None
+    role_allows = None
+    users = None
+    roles = None
+    file_types = None
+    port_types = None
+    global _pol
+
+    try:
+        _policy.policy(policy_file)
+    except:
+        raise ValueError(_("Failed to read %s policy file") % policy_file)
+
+
+try:
+    policy_file = get_installed_policy()
+    policy(policy_file)
+except ValueError as e:
+    if selinux.is_selinux_enabled() == 1:
+        raise e
+
+
 def info(setype, name=None):
     dict_list = _policy.info(setype, name)
     return dict_list
@@ -107,26 +213,6 @@ def get_conditionals_format_text(cond):
 def get_types_from_attribute(attribute):
     return info(ATTRIBUTE, attribute)[0]["types"]
 
-file_type_str = {}
-file_type_str["a"] = _("all files")
-file_type_str["f"] = _("regular file")
-file_type_str["d"] = _("directory")
-file_type_str["c"] = _("character device")
-file_type_str["b"] = _("block device")
-file_type_str["s"] = _("socket file")
-file_type_str["l"] = _("symbolic link")
-file_type_str["p"] = _("named pipe")
-
-trans_file_type_str = {}
-trans_file_type_str[""] = "a"
-trans_file_type_str["--"] = "f"
-trans_file_type_str["-d"] = "d"
-trans_file_type_str["-c"] = "c"
-trans_file_type_str["-b"] = "b"
-trans_file_type_str["-s"] = "s"
-trans_file_type_str["-l"] = "l"
-trans_file_type_str["-p"] = "p"
-
 
 def get_file_types(setype):
     flist = []
@@ -209,18 +295,14 @@ def find_file(reg):
 
 
 def find_all_files(domain, exclude_list=[]):
-    all_entrypoints = []
     executable_files = get_entrypoints(domain)
     for exe in executable_files.keys():
         if exe.endswith("_exec_t") and exe not in exclude_list:
             for path in executable_files[exe]:
                 for f in find_file(path):
                     return f
-                    #all_entrypoints.append(f)
     return None
 
-#return all_entrypoints
-
 
 def find_entrypoint_path(exe, exclude_list=[]):
     fcdict = get_fcdict()
@@ -243,8 +325,6 @@ def read_file_equiv(edict, fc_path, modify):
         edict[f[0]] = {"equiv": f[1], "modify": modify}
     return edict
 
-file_equiv_modified = None
-
 
 def get_file_equiv_modified(fc_path=selinux.selinux_file_context_path()):
     global file_equiv_modified
@@ -254,8 +334,6 @@ def get_file_equiv_modified(fc_path=selinux.selinux_file_context_path()):
     file_equiv_modified = read_file_equiv(file_equiv_modified, fc_path + ".subs", modify=True)
     return file_equiv_modified
 
-file_equiv = None
-
 
 def get_file_equiv(fc_path=selinux.selinux_file_context_path()):
     global file_equiv
@@ -265,8 +343,6 @@ def get_file_equiv(fc_path=selinux.selinux_file_context_path()):
     file_equiv = read_file_equiv(file_equiv, fc_path + ".subs_dist", modify=False)
     return file_equiv
 
-local_files = None
-
 
 def get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
     global local_files
@@ -291,8 +367,6 @@ def get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
             pass
     return local_files
 
-fcdict = None
-
 
 def get_fcdict(fc_path=selinux.selinux_file_context_path()):
     global fcdict
@@ -431,19 +505,6 @@ def get_entrypoints(setype):
     return mpaths
 
 
-def get_installed_policy(root="/"):
-    try:
-        path = root + selinux.selinux_binary_policy_path()
-        policies = glob.glob("%s.*" % path)
-        policies.sort()
-        return policies[-1]
-    except:
-        pass
-    raise ValueError(_("No SELinux Policy installed"))
-
-methods = []
-
-
 def get_methods():
     global methods
     if len(methods) > 0:
@@ -464,8 +525,6 @@ def get_methods():
     methods.sort()
     return methods
 
-all_types = None
-
 
 def get_all_types():
     global all_types
@@ -473,8 +532,6 @@ def get_all_types():
         all_types = map(lambda x: x['name'], info(TYPE))
     return all_types
 
-user_types = None
-
 
 def get_user_types():
     global user_types
@@ -482,8 +539,6 @@ def get_user_types():
         user_types = info(ATTRIBUTE, "userdomain")[0]["types"]
     return user_types
 
-role_allows = None
-
 
 def get_all_role_allows():
     global role_allows
@@ -513,9 +568,6 @@ def get_all_entrypoint_domains():
                 all_domains.append(m[0])
     return all_domains
 
-portrecs = None
-portrecsbynum = None
-
 
 def gen_interfaces():
     import commands
@@ -558,8 +610,6 @@ def gen_port_dict():
 
     return (portrecs, portrecsbynum)
 
-all_domains = None
-
 
 def get_all_domains():
     global all_domains
@@ -567,8 +617,6 @@ def get_all_domains():
         all_domains = info(ATTRIBUTE, "domain")[0]["types"]
     return all_domains
 
-roles = None
-
 
 def get_all_roles():
     global roles
@@ -579,8 +627,6 @@ def get_all_roles():
     roles.sort()
     return roles
 
-selinux_user_list = None
-
 
 def get_selinux_users():
     global selinux_user_list
@@ -590,8 +636,6 @@ def get_selinux_users():
             x['range'] = "".join(x['range'].split(" "))
     return selinux_user_list
 
-login_mappings = None
-
 
 def get_login_mappings():
     global login_mappings
@@ -616,8 +660,6 @@ def get_all_users():
     users.sort()
     return users
 
-file_types = None
-
 
 def get_all_file_types():
     global file_types
@@ -627,8 +669,6 @@ def get_all_file_types():
     file_types.sort()
     return file_types
 
-port_types = None
-
 
 def get_all_port_types():
     global port_types
@@ -638,8 +678,6 @@ def get_all_port_types():
     port_types.sort()
     return port_types
 
-bools = None
-
 
 def get_all_bools():
     global bools
@@ -655,23 +693,6 @@ def prettyprint(f, trim):
 def markup(f):
     return f
 
-# Autofill for adding files *************************
-DEFAULT_DIRS = {}
-DEFAULT_DIRS["/etc"] = "etc_t"
-DEFAULT_DIRS["/tmp"] = "tmp_t"
-DEFAULT_DIRS["/usr/lib/systemd/system"] = "unit_file_t"
-DEFAULT_DIRS["/lib/systemd/system"] = "unit_file_t"
-DEFAULT_DIRS["/etc/systemd/system"] = "unit_file_t"
-DEFAULT_DIRS["/var/cache"] = "var_cache_t"
-DEFAULT_DIRS["/var/lib"] = "var_lib_t"
-DEFAULT_DIRS["/var/log"] = "log_t"
-DEFAULT_DIRS["/var/run"] = "var_run_t"
-DEFAULT_DIRS["/run"] = "var_run_t"
-DEFAULT_DIRS["/run/lock"] = "var_lock_t"
-DEFAULT_DIRS["/var/run/lock"] = "var_lock_t"
-DEFAULT_DIRS["/var/spool"] = "var_spool_t"
-DEFAULT_DIRS["/var/www"] = "content_t"
-
 
 def get_description(f, markup=markup):
 
@@ -765,8 +786,6 @@ def get_description(f, markup=markup):
 
     return txt + "treat the files as %s data." % prettyprint(f, "_t")
 
-all_attributes = None
-
 
 def get_all_attributes():
     global all_attributes
@@ -775,38 +794,6 @@ def get_all_attributes():
     return all_attributes
 
 
-def policy(policy_file):
-    global all_domains
-    global all_attributes
-    global bools
-    global all_types
-    global role_allows
-    global users
-    global roles
-    global file_types
-    global port_types
-    all_domains = None
-    all_attributes = None
-    bools = None
-    all_types = None
-    role_allows = None
-    users = None
-    roles = None
-    file_types = None
-    port_types = None
-    try:
-        _policy.policy(policy_file)
-    except:
-        raise ValueError(_("Failed to read %s policy file") % policy_file)
-
-try:
-    policy_file = get_installed_policy()
-    policy(policy_file)
-except ValueError as e:
-    if selinux.is_selinux_enabled() == 1:
-        raise e
-
-
 def _dict_has_perms(dict, perms):
     for perm in perms:
         if perm not in dict[PERMS]:
@@ -849,8 +836,6 @@ def get_bools(setype):
                     bools.append((b[0], enabled))
     return (domainbools, bools)
 
-booleans = None
-
 
 def get_all_booleans():
     global booleans
@@ -858,8 +843,6 @@ def get_all_booleans():
         booleans = selinux.security_get_boolean_names()[1]
     return booleans
 
-booleans_dict = None
-
 
 def policy_xml(path="/usr/share/selinux/devel/policy.xml"):
     try:
-- 
2.7.3
