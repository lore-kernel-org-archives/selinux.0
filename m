Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JnWXO007499
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:49:36 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 54619561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:03 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:25 +0200
Message-Id: <20180804194734.12577-5-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 04/13] python/sepolicy: drop unused CheckPolicyType
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

CheckPolicyType class is not used in sepolicy and has been written from
an buggy copy-paste: "newval.append(v)" does not make any sense in
CheckPolicyType.__call__, as reported by flake8:

    python/sepolicy/sepolicy.py:190:13: F821 undefined name 'newval'
    python/sepolicy/sepolicy.py:190:27: F821 undefined name 'v'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy.py | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 141f64ecd15f..24631b51ee37 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -181,16 +181,6 @@ class LoadPolicy(argparse.Action):
         setattr(namespace, self.dest, values)
 
 
-class CheckPolicyType(argparse.Action):
-
-    def __call__(self, parser, namespace, values, option_string=None):
-        from sepolicy.generate import get_poltype_desc, poltype
-        if values not in poltype.keys():
-            raise ValueError("%s invalid SELinux policy type\n%s" % (values, get_poltype_desc()))
-            newval.append(v)
-        setattr(namespace, self.dest, values)
-
-
 class CheckUser(argparse.Action):
 
     def __call__(self, parser, namespace, value, option_string=None):
-- 
2.18.0
