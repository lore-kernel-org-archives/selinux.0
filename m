Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfR029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 888473B71B
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:11 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 12/19] sepolicy: Simplify policy types detection
Date: Wed,  3 May 2017 12:30:29 +0200
Message-Id: <20170503103036.17514-13-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

map() and filter() changed their return values from list to iterators in
Python 3. This change drops filter() and map() from gui.py to make it
work on Python 2 and 3

Fixes:
Traceback (most recent call last):
  File "/bin/sepolicy", line 700, in <module>
    args.func(args)
  File "/bin/sepolicy", line 326, in gui_run
    sepolicy.gui.SELinuxGui(args.domain, args.test)
  File "/usr/lib/python3.5/site-packages/sepolicy/gui.py", line 238, in __init__
    if self.populate_system_policy() < 2:
  File "/usr/lib/python3.5/site-packages/sepolicy/gui.py", line 835, in populate_system_policy
    types = map(lambda x: x[1], filter(lambda x: x[0] == selinux_path, os.walk(selinux_path)))[0]
TypeError: 'map' object is not subscriptable

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index e361aa1c..8e86a369 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -831,8 +831,7 @@ class SELinuxGui():
             self.enforce_button = self.disabled_button_default
 
     def populate_system_policy(self):
-        selinux_path = selinux.selinux_path()
-        types = map(lambda x: x[1], filter(lambda x: x[0] == selinux_path, os.walk(selinux_path)))[0]
+        types = next(os.walk(selinux.selinux_path(), topdown=True))[1]
         types.sort()
         ctr = 0
         for item in types:
-- 
2.12.2
