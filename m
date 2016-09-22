Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFIKYM015304
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id n24so3940485pfb.3
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:07 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] sepolicy: update some users of search() to use setools
 directly
Date: Thu, 22 Sep 2016 23:17:29 +0800
Message-Id: <1474557453-14379-4-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

search() is an overly complex wrapper around setools, several users are
simplified by just directly using setools.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 47 ++++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index f24750a..37946f3 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -460,12 +460,12 @@ def get_all_entrypoints():
 
 
 def get_entrypoint_types(setype):
-    entrypoints = []
-    try:
-        entrypoints = map(lambda x: x['target'], filter(lambda x: x['source'] == setype, search([ALLOW], {'source': setype, 'permlist': ['entrypoint'], 'class': 'file'})))
-    except TypeError:
-        pass
-    return entrypoints
+    q = setools.TERuleQuery(_pol,
+                            ruletype=[ALLOW],
+                            source=setype,
+                            tclass=["file"],
+                            perms=["entrypoint"])
+    return [str(x.target) for x in q.results() if x.source == setype]
 
 
 def get_init_transtype(path):
@@ -481,14 +481,19 @@ def get_init_transtype(path):
 
 
 def get_init_entrypoint(transtype):
-    try:
-        entrypoints = filter(lambda x: x['transtype'] == transtype, search([TRANSITION], {'source': "init_t", 'class': 'process'}))
-        if len(entrypoints) == 0:
-            return None
-        return entrypoints[0]["target"]
-    except TypeError:
-        pass
-    return None
+    q = setools.TERuleQuery(_pol,
+                            ruletype=["type_transition"],
+                            source="init_t",
+                            tclass=["process"])
+    entrypoints = []
+    for i in q.results():
+        try:
+            if i.default == transtype:
+                entrypoints.append(i.target)
+        except AttributeError:
+            continue
+
+    return entrypoints
 
 
 def get_init_entrypoint_target(entrypoint):
@@ -551,13 +556,17 @@ def get_all_role_allows():
     if role_allows:
         return role_allows
     role_allows = {}
-    for r in search([ROLE_ALLOW]):
-        if r["source"] == "system_r" or r["target"] == "system_r":
+
+    q = setools.RBACRuleQuery(_pol, ruletype='allow')
+    for r in q.results():
+        src = str(r.source)
+        tgt = str(r.target)
+        if src == "system_r" or tgt == "system_r":
             continue
-        if r["source"] in role_allows:
-            role_allows[r["source"]].append(r["target"])
+        if src in role_allows:
+            role_allows[src].append(tgt)
         else:
-            role_allows[r["source"]] = [r["target"]]
+            role_allows[src] = [tgt]
 
     return role_allows
 
-- 
2.7.3
