Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8OH7VBc023266
 for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2017 13:07:32 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 02650564806
 for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2017 19:05:33 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 24 Sep 2017 19:04:56 +0200
Message-Id: <20170924170456.5531-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170924170456.5531-1-nicolas.iooss@m4x.org>
References: <20170924170456.5531-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] sepolicy: support non-MLS policy in gui
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Several "sepolic gui" tabs raise exceptions when using a policy without
MLS because some dictionaries describing users and logins lack level and
range properties. Use conditions and get() where appropriate in order
to make "sepolicy gui" usable again with a non-MLS policy.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py |  5 +++--
 python/sepolicy/sepolicy/gui.py      | 31 +++++++++++++++++++------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index bf2494a813c8..89346aba0b15 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -879,8 +879,9 @@ def get_selinux_users():
     global selinux_user_list
     if not selinux_user_list:
         selinux_user_list = list(info(USER))
-        for x in selinux_user_list:
-            x['range'] = "".join(x['range'].split(" "))
+        if _pol.mls:
+            for x in selinux_user_list:
+                x['range'] = "".join(x['range'].split(" "))
     return selinux_user_list
 
 
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 007c94a71c08..6562aa850c98 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -907,8 +907,8 @@ class SELinuxGui():
             if "object_r" in roles:
                 roles.remove("object_r")
             self.user_liststore.set_value(iter, 1, ", ".join(roles))
-            self.user_liststore.set_value(iter, 2, u["level"])
-            self.user_liststore.set_value(iter, 3, u["range"])
+            self.user_liststore.set_value(iter, 2, u.get("level", ""))
+            self.user_liststore.set_value(iter, 3, u.get("range", ""))
             self.user_liststore.set_value(iter, 4, True)
         self.ready_mouse()
 
@@ -1755,14 +1755,14 @@ class SELinuxGui():
         if self.login_mls_entry.get_text() == "":
             for u in sepolicy.get_selinux_users():
                 if seuser == u['name']:
-                    self.login_mls_entry.set_text(u['range'])
+                    self.login_mls_entry.set_text(u.get('range', ''))
 
     def user_roles_combobox_change(self, combo, *args):
         serole = self.combo_get_active_text(combo)
         if self.user_mls_entry.get_text() == "":
             for u in sepolicy.get_all_roles():
                 if serole == u['name']:
-                    self.user_mls_entry.set_text(u['range'])
+                    self.user_mls_entry.set_text(u.get('range', ''))
 
     def get_selected_iter(self):
         iter = None
@@ -1973,7 +1973,10 @@ class SELinuxGui():
             self.cur_dict["user"][name] = {"action": "-m", "range": mls_range, "level": level, "role": roles, "oldrange": oldrange, "oldlevel": oldlevel, "oldroles": oldroles, "oldname": oldname}
         else:
             iter = self.liststore.append(None)
-            self.cur_dict["user"][name] = {"action": "-a", "range": mls_range, "level": level, "role": roles}
+            if mls_range or level:
+                self.cur_dict["user"][name] = {"action": "-a", "range": mls_range, "level": level, "role": roles}
+            else:
+                self.cur_dict["user"][name] = {"action": "-a", "role": roles}
 
         self.liststore.set_value(iter, 0, name)
         self.liststore.set_value(iter, 1, roles)
@@ -2089,8 +2092,8 @@ class SELinuxGui():
             user_dict = self.cust_dict["user"]
             for user in user_dict:
                 roles = user_dict[user]["role"]
-                mls = user_dict[user]["range"]
-                level = user_dict[user]["level"]
+                mls = user_dict[user].get("range", "")
+                level = user_dict[user].get("level", "")
                 iter = self.user_delete_liststore.append()
                 self.user_delete_liststore.set_value(iter, 1, user)
                 self.user_delete_liststore.set_value(iter, 2, roles)
@@ -2104,7 +2107,7 @@ class SELinuxGui():
             login_dict = self.cust_dict["login"]
             for login in login_dict:
                 seuser = login_dict[login]["seuser"]
-                mls = login_dict[login]["range"]
+                mls = login_dict[login].get("range", "")
                 iter = self.login_delete_liststore.append()
                 self.login_delete_liststore.set_value(iter, 1, seuser)
                 self.login_delete_liststore.set_value(iter, 2, login)
@@ -2268,7 +2271,7 @@ class SELinuxGui():
             self.update_treestore.set_value(niter, 3, False)
             roles = self.cur_dict["user"][user]["role"]
             self.update_treestore.set_value(niter, 1, (_("Roles: %s")) % roles)
-            mls = self.cur_dict["user"][user]["range"]
+            mls = self.cur_dict["user"][user].get("range", "")
             niter = self.update_treestore.append(iter)
             self.update_treestore.set_value(niter, 3, False)
             self.update_treestore.set_value(niter, 1, _("MLS/MCS Range: %s") % mls)
@@ -2293,7 +2296,7 @@ class SELinuxGui():
             self.update_treestore.set_value(niter, 3, False)
             seuser = self.cur_dict["login"][login]["seuser"]
             self.update_treestore.set_value(niter, 1, (_("SELinux User: %s")) % seuser)
-            mls = self.cur_dict["login"][login]["range"]
+            mls = self.cur_dict["login"][login].get("range", "")
             niter = self.update_treestore.append(iter)
             self.update_treestore.set_value(niter, 3, False)
             self.update_treestore.set_value(niter, 1, _("MLS/MCS Range: %s") % mls)
@@ -2487,14 +2490,18 @@ class SELinuxGui():
                 for l in self.cur_dict[k]:
                     if self.cur_dict[k][l]["action"] == "-d":
                         update_buffer += "login -d %s\n" % l
-                    else:
+                    elif "range" in self.cur_dict[k][l]:
                         update_buffer += "login %s -s %s -r %s %s\n" % (self.cur_dict[k][l]["action"], self.cur_dict[k][l]["seuser"], self.cur_dict[k][l]["range"], l)
+                    else:
+                        update_buffer += "login %s -s %s %s\n" % (self.cur_dict[k][l]["action"], self.cur_dict[k][l]["seuser"], l)
             if k in "user":
                 for u in self.cur_dict[k]:
                     if self.cur_dict[k][u]["action"] == "-d":
                         update_buffer += "user -d %s\n" % u
-                    else:
+                    elif "level" in self.cur_dict[k][u] and "range" in self.cur_dict[k][u]:
                         update_buffer += "user %s -L %s -r %s -R %s %s\n" % (self.cur_dict[k][u]["action"], self.cur_dict[k][u]["level"], self.cur_dict[k][u]["range"], self.cur_dict[k][u]["role"], u)
+                    else:
+                        update_buffer += "user %s -R %s %s\n" % (self.cur_dict[k][u]["action"], self.cur_dict[k][u]["role"], u)
 
             if k in "fcontext-equiv":
                 for f in self.cur_dict[k]:
-- 
2.14.1
