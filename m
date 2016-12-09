Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9FAW0o018955
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 10:10:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C57E72EBD06
 for <selinux@tycho.nsa.gov>; Fri,  9 Dec 2016 15:10:08 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] python/sepolicy/sepolicy: optimise sepolicy gui loading
Date: Fri,  9 Dec 2016 16:10:00 +0100
Message-Id: <1481296200-28904-2-git-send-email-vmojzis@redhat.com>
In-Reply-To: <1481296200-28904-1-git-send-email-vmojzis@redhat.com>
References: <1481296200-28904-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Significantly speed up sepolicy gui loading by aggregating setools
queries.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 17 +++++++++++++++++
 python/sepolicy/sepolicy/gui.py      |  5 +++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index fee6438..22c72b2 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -663,6 +663,23 @@ def get_init_entrypoint(transtype):
 
     return entrypoints
 
+def get_init_entrypoints_str():
+    q = setools.TERuleQuery(_pol,
+                            ruletype=["type_transition"],
+                            source="init_t",
+                            tclass=["process"])
+    entrypoints = {}
+    for i in q.results():
+        try:
+            transtype = str(i.default)
+            if transtype in entrypoints:
+                entrypoints[transtype].append(str(i.target))
+            else:
+                entrypoints[transtype] = [str(i.target)]
+        except AttributeError:
+            continue
+
+    return entrypoints
 
 def get_init_entrypoint_target(entrypoint):
     try:
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 115e18b..c9dd4c1 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -499,6 +499,8 @@ class SELinuxGui():
 
         loading_gui.show()
         length = len(self.all_domains)
+
+        entrypoint_dict = sepolicy.get_init_entrypoints_str()
         for domain in self.all_domains:
             # After the user selects a path in the drop down menu call
             # get_init_entrypoint_target(entrypoint) to get the transtype
@@ -509,8 +511,7 @@ class SELinuxGui():
             self.progress_bar.set_pulse_step(self.percentage)
             self.idle_func()
 
-            entrypoints = [str(x) for x in sepolicy.get_init_entrypoint(domain)]
-            for entrypoint in entrypoints:
+            for entrypoint in entrypoint_dict.get(domain, []):
                 path = sepolicy.find_entrypoint_path(entrypoint)
                 if path:
                     self.combo_box_add(path, domain)
-- 
2.7.4
