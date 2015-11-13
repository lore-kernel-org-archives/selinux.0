Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tADBqWT0023644
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 06:52:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 83F22A14E2
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 11:52:21 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sepolgen: Use key function in sort()
Date: Fri, 13 Nov 2015 12:52:09 +0100
Message-Id: <1447415529-7588-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In Py3.0, the cmp parameter in sort() function was removed and key keyword is
available since Py2.4.

Fixes: # cat avc.log | audit2allow -R
Traceback (most recent call last):
  File "/usr/bin/audit2allow", line 363, in <module>
    app.main()
  File "/usr/bin/audit2allow", line 351, in main
    self.__output()
  File "/usr/bin/audit2allow", line 308, in __output
    g.set_gen_refpol(ifs, perm_maps)
  File "/usr/lib64/python3.4/site-packages/sepolgen/policygen.py", line 101, in set_gen_refpol
    self.ifgen = InterfaceGenerator(if_set, perm_maps)
  File "/usr/lib64/python3.4/site-packages/sepolgen/policygen.py", line 353, in __init__
    self.hack_check_ifs(ifs)
  File "/usr/lib64/python3.4/site-packages/sepolgen/policygen.py", line 365, in hack_check_ifs
    params.sort(param_comp)
TypeError: must use keyword argument for key function

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 sepolgen/src/sepolgen/policygen.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 4438a11..34c8401 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -36,8 +36,6 @@ from . import access
 from . import interfaces
 from . import matching
 from . import util
-if util.PY3:
-    from .util import cmp
 # Constants for the level of explanation from the generation
 # routines
 NO_EXPLANATION    = 0
@@ -278,15 +276,12 @@ def explain_access(av, ml=None, verbosity=SHORT_EXPLANATION):
         explain_interfaces()
     return s
 
-def param_comp(a, b):
-    return cmp(b.num, a.num)
-
 def call_interface(interface, av):
     params = []
     args = []
 
     params.extend(interface.params.values())
-    params.sort(param_comp)
+    params.sort(key=lambda param: param.num, reverse=True)
 
     ifcall = refpolicy.InterfaceCall()
     ifcall.ifname = interface.name
@@ -321,7 +316,7 @@ class InterfaceGenerator:
         for x in ifs.interfaces.values():
             params = []
             params.extend(x.params.values())
-            params.sort(param_comp)
+            params.sort(key=lambda param: param.num, reverse=True)
             for i in range(len(params)):
                 # Check that the paramater position matches
                 # the number (e.g., $1 is the first arg). This
-- 
2.6.2
