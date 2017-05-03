Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfT029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 973D781229
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:13 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 14/19] policycoreutils/sepolicy: Define our own cmp()
Date: Wed,  3 May 2017 12:30:31 +0200
Message-Id: <20170503103036.17514-15-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
Traceback (most recent call last):
  File "/usr/lib/python3.5/site-packages/sepolicy/gui.py", line 1447, in stripsort
    return cmp(val1, val2)
NameError: name 'cmp' is not defined

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 8e86a369..7f84b6f9 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -69,8 +69,14 @@ enabled = [_("No"), _("Yes")]
 action = [_("Disable"), _("Enable")]
 
 
-def compare(a, b):
-    return cmp(a.lower(), b.lower())
+def cmp(a, b):
+    if a is None and b is None:
+        return 0
+    if a is None:
+        return -1
+    if b is None:
+        return 1
+    return (a > b) - (a < b)
 
 import distutils.sysconfig
 ADVANCED_LABEL = (_("Advanced >>"), _("Advanced <<"))
-- 
2.12.2
