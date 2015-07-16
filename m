Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j3021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:08 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 15B1638886F
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:07 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 06/11] sepolgen: Replace usage of __cmp__ with rich comparison.
Date: Thu, 16 Jul 2015 13:48:16 +0200
Message-Id: <1437047301-17672-7-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In Python3 the __cmp__ function is removed, and rich
comparison should be used instead.
Also the cmp function is gone in Python3 therefore it is
reimplemented in util.py and used if running on Python3.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/access.py    | 36 ++++++++++++++++++------------------
 sepolgen/src/sepolgen/matching.py  | 33 ++++++++++++++-------------------
 sepolgen/src/sepolgen/output.py    |  4 ++++
 sepolgen/src/sepolgen/policygen.py |  3 +++
 sepolgen/src/sepolgen/util.py      | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index 46d4dba..98bee98 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -32,6 +32,7 @@ in a variety of ways, but they are the fundamental representation of access.
 """
 
 from . import refpolicy
+from . import util
 
 from selinux import audit2why
 
@@ -52,7 +53,7 @@ def is_idparam(id):
     else:
         return False
 
-class AccessVector:
+class AccessVector(util.Comparison):
     """
     An access vector is the basic unit of access in SELinux.
 
@@ -89,6 +90,9 @@ class AccessVector:
             self.audit_msgs = []
             self.type = audit2why.TERULE
             self.data = []
+        # when implementing __eq__ also __hash__ is needed on py2
+        # if object is muttable __hash__ should be None
+        self.__hash__ = None
 
         # The direction of the information flow represented by this
         # access vector - used for matching
@@ -134,23 +138,19 @@ class AccessVector:
         return "allow %s %s:%s %s;" % (self.src_type, self.tgt_type,
                                         self.obj_class, self.perms.to_space_str())
 
-    def __cmp__(self, other):
-        if self.src_type != other.src_type:
-            return cmp(self.src_type, other.src_type)
-        if self.tgt_type != other.tgt_type:
-            return cmp(self.tgt_type, other.tgt_type)
-        if self.obj_class != self.obj_class:
-            return cmp(self.obj_class, other.obj_class)
-        if len(self.perms) != len(other.perms):
-            return cmp(len(self.perms), len(other.perms))
-        x = list(self.perms)
-        x.sort()
-        y = list(other.perms)
-        y.sort()
-        for pa, pb in zip(x, y):
-            if pa != pb:
-                return cmp(pa, pb)
-        return 0
+    def _compare(self, other, method):
+        try:
+            x = list(self.perms)
+            a = (self.src_type, self.tgt_type, self.obj_class, x)
+            y = list(other.perms)
+            x.sort()
+            y.sort()
+            b = (other.src_type, other.tgt_type, other.obj_class, y)
+            return method(a, b)
+        except (AttributeError, TypeError):
+            # trying to compare to foreign type
+            return NotImplemented
+
 
 def avrule_to_access_vectors(avrule):
     """Convert an avrule into a list of access vectors.
diff --git a/sepolgen/src/sepolgen/matching.py b/sepolgen/src/sepolgen/matching.py
index 47531ff..6f86359 100644
--- a/sepolgen/src/sepolgen/matching.py
+++ b/sepolgen/src/sepolgen/matching.py
@@ -25,31 +25,26 @@ import itertools
 
 from . import access
 from . import objectmodel
+from . import util
 
 
-class Match:
+class Match(util.Comparison):
     def __init__(self, interface=None, dist=0):
         self.interface = interface
         self.dist = dist
         self.info_dir_change = False
-
-    def __cmp__(self, other):
-        if self.dist == other.dist:
-            if self.info_dir_change:
-                if other.info_dir_change:
-                    return 0
-                else:
-                    return 1
-            else:
-                if other.info_dir_change:
-                    return -1
-                else:
-                    return 0
-        else:
-            if self.dist < other.dist:
-                return -1
-            else:
-                return 1
+        # when implementing __eq__ also __hash__ is needed on py2
+        # if object is muttable __hash__ should be None
+        self.__hash__ = None
+
+    def _compare(self, other, method):
+        try:
+            a = (self.dist, self.info_dir_change)
+            b = (other.dist, other.info_dir_change)
+            return method(a, b)
+        except (AttributeError, TypeError):
+            # trying to compare to foreign type
+            return NotImplemented
 
 class MatchList:
     DEFAULT_THRESHOLD = 150
diff --git a/sepolgen/src/sepolgen/output.py b/sepolgen/src/sepolgen/output.py
index 4244a74..d8daedb 100644
--- a/sepolgen/src/sepolgen/output.py
+++ b/sepolgen/src/sepolgen/output.py
@@ -30,6 +30,10 @@ cleanly separated from the formatting issues.
 from . import refpolicy
 from . import util
 
+if util.PY3:
+    from .util import cmp
+
+
 class ModuleWriter:
     def __init__(self):
         self.fd = None
diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 221b78e..0f4c419 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -35,6 +35,9 @@ from . import objectmodel
 from . import access
 from . import interfaces
 from . import matching
+from . import util
+if util.PY3:
+    from .util import cmp
 # Constants for the level of explanation from the generation
 # routines
 NO_EXPLANATION    = 0
diff --git a/sepolgen/src/sepolgen/util.py b/sepolgen/src/sepolgen/util.py
index 2edbf8c..ec628e9 100644
--- a/sepolgen/src/sepolgen/util.py
+++ b/sepolgen/src/sepolgen/util.py
@@ -16,6 +16,10 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
+import sys
+
+
+PY3 = sys.version_info[0] == 3
 
 class ConsoleProgressBar:
     def __init__(self, out, steps=100, indicator='#'):
@@ -90,6 +94,37 @@ def encode_input(text):
         encoded_text = text.encode('utf-8')
     return encoded_text 
 
+class Comparison():
+    """Class used when implementing rich comparison.
+
+    Inherit from this class if you want to have a rich
+    comparison withing the class, afterwards implement
+    _compare function within your class."""
+    
+    def _compare(self, other, method):
+        raise NotImplemented
+
+    def __eq__(self, other):
+        return self._compare(other, lambda a, b: a == b)
+
+    def __lt__(self, other):
+        return self._compare(other, lambda a, b: a < b)
+
+    def __le__(self, other):
+        return self._compare(other, lambda a, b: a <= b)
+
+    def __ge__(self, other):
+        return self._compare(other, lambda a, b: a >= b)
+
+    def __gt__(self, other):
+        return self._compare(other, lambda a, b: a > b)
+
+    def __ne__(self, other):
+        return self._compare(other, lambda a, b: a != b)
+
+def cmp(first, second):
+    return (first > second) - (second > first)
+
 if __name__ == "__main__":
     import sys
     import time
-- 
2.4.3
