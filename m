Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFI2iD015286
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id q2so3941290pfj.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:03 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/7] sepolicy: initialize setools4
Date: Thu, 22 Sep 2016 23:17:28 +0800
Message-Id: <1474557453-14379-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 4d9d6ad..f24750a 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -2,9 +2,11 @@
 
 # Author: Dan Walsh <dwalsh@redhat.com>
 # Author: Ryan Hallisey <rhallise@redhat.com>
+# Author: Jason Zaman <perfinion@gentoo.org>
 
 from . import _policy
 import selinux
+import setools
 import glob
 import sepolgen.defaults as defaults
 import sepolgen.interfaces as interfaces
@@ -31,13 +33,13 @@ except:
         import __builtin__
         __builtin__.__dict__['_'] = unicode
 
-TYPE = _policy.TYPE
-ROLE = _policy.ROLE
-ATTRIBUTE = _policy.ATTRIBUTE
-PORT = _policy.PORT
-USER = _policy.USER
-BOOLEAN = _policy.BOOLEAN
-TCLASS = _policy.CLASS
+TYPE = 1
+ROLE = 2
+ATTRIBUTE = 3
+PORT = 4
+USER = 5
+BOOLEAN = 6
+TCLASS = 7
 
 ALLOW = 'allow'
 AUDITALLOW = 'auditallow'
@@ -88,6 +90,9 @@ trans_file_type_str["-s"] = "s"
 trans_file_type_str["-l"] = "l"
 trans_file_type_str["-p"] = "p"
 
+# the setools policy handle
+_pol = None
+
 # cache the lookup results
 file_equiv_modified = None
 file_equiv = None
@@ -145,6 +150,7 @@ def policy(policy_file):
 
     try:
         _policy.policy(policy_file)
+        _pol = setools.SELinuxPolicy(policy_file)
     except:
         raise ValueError(_("Failed to read %s policy file") % policy_file)
 
-- 
2.7.3
