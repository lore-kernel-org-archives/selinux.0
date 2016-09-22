Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFIW5F015315
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:37 -0400
Received: by mail-pa0-f66.google.com with SMTP id oz2so3803335pac.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:14 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/7] sepolicy: make info() use setools4 api
Date: Thu, 22 Sep 2016 23:17:31 +0800
Message-Id: <1474557453-14379-6-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Also make it return generators instead of an explicit list.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 85 ++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 319cb34..a3ab10c 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -164,8 +164,89 @@ except ValueError as e:
 
 
 def info(setype, name=None):
-    dict_list = _policy.info(setype, name)
-    return dict_list
+    if setype == TYPE:
+        q = setools.TypeQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'aliases': map(str, x.aliases()),
+            'name': str(x),
+            'permissive': bool(x.ispermissive),
+        } for x in q.results())
+
+    elif setype == ROLE:
+        q = setools.RoleQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'name': str(x),
+            'roles': map(str, x.expand()),
+            'types': map(str, x.types()),
+        } for x in q.results())
+
+    elif setype == ATTRIBUTE:
+        q = setools.TypeAttributeQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'name': str(x),
+            'types': map(str, x.expand()),
+        } for x in q.results())
+
+    elif setype == PORT:
+        q = setools.PortconQuery(_pol)
+        if name:
+            ports = [int(i) for i in name.split("-")]
+            if len(ports) == 2:
+                q.ports = ports
+            elif len(ports) == 1:
+                q.ports = (ports[0], ports[0])
+
+        return ({
+            'high': x.ports.high,
+            'protocol': str(x.protocol),
+            'range': str(x.context.range_),
+            'type': str(x.context.type_),
+            'low': x.ports.low,
+        } for x in q.results())
+
+    elif setype == USER:
+        q = setools.UserQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'range': str(x.mls_range),
+            'name': str(x),
+            'roles': map(str, x.roles),
+            'level': str(x.mls_level),
+        } for x in q.results())
+
+    elif setype == BOOLEAN:
+        q = setools.BoolQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'name': str(x),
+            'state': x.state,
+        } for x in q.results())
+
+    elif setype == TCLASS:
+        q = setools.ObjClassQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'name': str(x),
+            'permlist': list(x.perms),
+        } for x in q.results())
+
+    else:
+        raise ValueError("Invalid type")
 
 
 def search(types, info={}):
-- 
2.7.3
