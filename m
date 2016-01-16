Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0GBXbk4022695
 for <selinux@tycho.nsa.gov>; Sat, 16 Jan 2016 06:33:38 -0500
Received: from iosakhe.numericable.fr (89-156-121-7.rev.numericable.fr
 [89.156.121.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 164BB56480E
 for <selinux@tycho.nsa.gov>; Sat, 16 Jan 2016 12:33:32 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] sepolgen: Make sepolgen-ifgen output deterministic with
 Python>=3.3
Date: Sat, 16 Jan 2016 12:33:08 +0100
Message-Id: <1452943989-11913-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since Python 3.3, dictionary hashes are randomized and iterating over
them is no longer deterministic.  This makes it difficult to compare
outputs of sepolgen-ifgen command.

Make sepolgen-ifgen deterministic again with Python>=3.3 by always
sorting the dictonaries and sets which are used to produce output.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 sepolgen/src/sepolgen/access.py     | 2 +-
 sepolgen/src/sepolgen/interfaces.py | 6 +++---
 sepolgen/src/sepolgen/refpolicy.py  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index 1f89ecde5fd9..a5d86982c0b1 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -128,7 +128,7 @@ class AccessVector(util.Comparison):
         is represented in a list.
         """
         l = [self.src_type, self.tgt_type, self.obj_class]
-        l.extend(self.perms)
+        l.extend(sorted(self.perms))
         return l
 
     def __str__(self):
diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index 0b688bfd4072..48ae4f27a414 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -341,12 +341,12 @@ class InterfaceSet:
             self.output.write(str + "\n")
 
     def to_file(self, fd):
-        for iv in self.interfaces.values():
+        for iv in sorted(self.interfaces.values(), key=lambda x: x.name):
             fd.write("[InterfaceVector %s " % iv.name)
-            for param in iv.params.values():
+            for param in sorted(iv.params.values(), key=lambda x: x.name):
                 fd.write("%s:%s " % (param.name, refpolicy.field_to_str[param.type]))
             fd.write("]\n")
-            avl = iv.access.to_list()
+            avl = sorted(iv.access.to_list())
             for av in avl:
                 fd.write(",".join(av))
                 fd.write("\n")
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index 737f95624d48..31b40d8fee00 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -251,10 +251,10 @@ class IdSet(set):
         self.compliment = False
 
     def to_space_str(self):
-        return list_to_space_str(self)
+        return list_to_space_str(sorted(self))
 
     def to_comma_str(self):
-        return list_to_comma_str(self)
+        return list_to_comma_str(sorted(self))
 
 class SecurityContext(Leaf):
     """An SELinux security context with optional MCS / MLS fields."""
-- 
2.7.0
