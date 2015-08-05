Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t757FHjJ032256
 for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2015 03:15:17 -0400
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t757FFks003884
 for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2015 03:15:15 -0400
Date: Wed, 5 Aug 2015 03:15:14 -0400 (EDT)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <189579949.3453211.1438758914947.JavaMail.zimbra@redhat.com>
In-Reply-To: <647927280.3452313.1438758780544.JavaMail.zimbra@redhat.com>
Subject: [PATCH] sepolgen: convert cmp functions to key functions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In python3 it is needed to pass compare function as a key argument
instead of directly passing compare function to sort function

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/output.py |  4 ++--
 sepolgen/src/sepolgen/util.py   | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/sepolgen/src/sepolgen/output.py b/sepolgen/src/sepolgen/output.py
index d8daedb..e9a3b8c 100644
--- a/sepolgen/src/sepolgen/output.py
+++ b/sepolgen/src/sepolgen/output.py
@@ -131,7 +131,7 @@ def sort_filter(module):
         rules = []
         rules.extend(node.avrules())
         rules.extend(node.interface_calls())
-        rules.sort(rule_cmp)
+        rules.sort(key=util.cmp_to_key(rule_cmp))
 
         cur = None
         sep_rules = []
@@ -155,7 +155,7 @@ def sort_filter(module):
 
         ras = []
         ras.extend(node.role_types())
-        ras.sort(role_type_cmp)
+        ras.sort(key=util.cmp_to_key(role_type_cmp))
         if len(ras):
             comment = refpolicy.Comment()
             comment.lines.append("============= ROLES ==============")
diff --git a/sepolgen/src/sepolgen/util.py b/sepolgen/src/sepolgen/util.py
index 16e7ca2..9ad7fbd 100644
--- a/sepolgen/src/sepolgen/util.py
+++ b/sepolgen/src/sepolgen/util.py
@@ -145,6 +145,29 @@ class Comparison():
     def __ne__(self, other):
         return self._compare(other, lambda a, b: a != b)
 
+if sys.version_info < (2,7):
+    # cmp_to_key function is missing in python2.6
+    def cmp_to_key(mycmp):
+        'Convert a cmp= function into a key= function'
+        class K:
+            def __init__(self, obj, *args):
+                self.obj = obj
+            def __lt__(self, other):
+                return mycmp(self.obj, other.obj) < 0
+            def __gt__(self, other):
+                return mycmp(self.obj, other.obj) > 0
+            def __eq__(self, other):
+                return mycmp(self.obj, other.obj) == 0
+            def __le__(self, other):
+                return mycmp(self.obj, other.obj) <= 0
+            def __ge__(self, other):
+                return mycmp(self.obj, other.obj) >= 0
+            def __ne__(self, other):
+                return mycmp(self.obj, other.obj) != 0
+        return K
+else:
+    from functools import cmp_to_key
+
 def cmp(first, second):
     return (first > second) - (second > first)
 
-- 
2.4.3
