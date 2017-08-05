Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75GcXn1007251
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:33 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2B88D56497D
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:37:57 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:48 +0200
Message-Id: <20170805163750.1920-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170805163750.1920-1-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/6] sepolicy: support non-MLS policy in manpage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"sepolicy manpage" fails when the system does not use MLS because
using x.context.range_ raises an exception. Avoid using range and levels
when _pol.mls is False.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 18 +++++++++++++++---
 python/sepolicy/sepolicy/manpage.py  |  3 ++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 2d8e9ef6e862..03742346caf0 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -207,10 +207,17 @@ def info(setype, name=None):
             elif len(ports) == 1:
                 q.ports = (ports[0], ports[0])
 
+        if _pol.mls:
+            return ({
+                'high': x.ports.high,
+                'protocol': str(x.protocol),
+                'range': str(x.context.range_),
+                'type': str(x.context.type_),
+                'low': x.ports.low,
+            } for x in q.results())
         return ({
             'high': x.ports.high,
             'protocol': str(x.protocol),
-            'range': str(x.context.range_),
             'type': str(x.context.type_),
             'low': x.ports.low,
         } for x in q.results())
@@ -220,11 +227,16 @@ def info(setype, name=None):
         if name:
             q.name = name
 
+        if _pol.mls:
+            return ({
+                'range': str(x.mls_range),
+                'name': str(x),
+                'roles': list(map(str, x.roles)),
+                'level': str(x.mls_level),
+            } for x in q.results())
         return ({
-            'range': str(x.mls_range),
             'name': str(x),
             'roles': list(map(str, x.roles)),
-            'level': str(x.mls_level),
         } for x in q.results())
 
     elif setype == BOOLEAN:
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 035065afd292..494c34319c26 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -84,7 +84,8 @@ def get_all_users_info():
 
     for d in allusers_info:
         allusers.append(d['name'])
-        users_range[d['name'].split("_")[0]] = d['range']
+        if 'range' in d:
+            users_range[d['name'].split("_")[0]] = d['range']
 
     for u in allusers:
         if u not in ["system_u", "root", "unconfined_u"]:
-- 
2.13.3
