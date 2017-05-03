Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfW029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E095180C09
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:16 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 17/19] sepolicy: Fix several issues in 'sepolicy manpage -a'
Date: Wed,  3 May 2017 12:30:34 +0200
Message-Id: <20170503103036.17514-18-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
$ sepolicy manpage -a
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 699, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 359, in manpage
    m = ManPage(domain, path, args.root, args.source_files, args.web)
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 408, in __init__
    self.__gen_man_page()
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 495, in __gen_man_page
    self._entrypoints()
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 903, in _entrypoints
    if len(entrypoints) > 1:
TypeError: object of type 'map' has no len()

$ sepolicy manpage -a
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 699, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 359, in manpage
    m = ManPage(domain, path, args.root, args.source_files, args.web)
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 408, in __init__
    self.__gen_man_page()
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 497, in __gen_man_page
    self._mcs_types()
  File "/usr/lib/python3.6/site-packages/sepolicy/manpage.py", line 927, in _mcs_types
    attributes = sepolicy.info(sepolicy.TYPE, (self.type))[0]["attributes"]
TypeError: 'generator' object is not subscriptable

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 4cebb299..a4dc717a 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -94,11 +94,10 @@ def get_all_users_info():
 
 all_entrypoints = None
 
-
 def get_entrypoints():
     global all_entrypoints
     if not all_entrypoints:
-        all_entrypoints = sepolicy.info(sepolicy.ATTRIBUTE, "entry_type")[0]["types"]
+        all_entrypoints = next(sepolicy.info(sepolicy.ATTRIBUTE, "entry_type"))["types"]
     return all_entrypoints
 
 domains = None
@@ -939,9 +938,8 @@ selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
         return True
 
     def _entrypoints(self):
-        try:
-            entrypoints = map(lambda x: x['target'], sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['entrypoint'], 'class': 'file'}))
-        except:
+        entrypoints = [x['target'] for x in sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['entrypoint'], 'class': 'file'})]
+        if len(entrypoints) == 0:
             return
 
         self.fd.write("""
@@ -971,8 +969,8 @@ All executeables with the default executable label, usually stored in /usr/bin a
 %s""" % ", ".join(paths))
 
     def _mcs_types(self):
-        attributes = sepolicy.info(sepolicy.TYPE, (self.type))[0]["attributes"]
-        if "mcs_constrained_type" not in attributes:
+        mcs_constrained_type = next(sepolicy.info(sepolicy.ATTRIBUTE, "mcs_constrained_type"))
+        if self.type not in mcs_constrained_type['types']:
             return
         self.fd.write ("""
 .SH "MCS Constrained"
-- 
2.12.2
