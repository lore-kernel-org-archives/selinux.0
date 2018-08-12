Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKQ8KH017820
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:26:08 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 90C2B564740
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:02 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:17 +0200
Message-Id: <20180812202522.3743-9-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 08/13] python/sepolgen: remove buggy code
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

av_extract_params() may call __param_insert() with only 2 parameters
instead of 4, which has no chance to work fine. Moreover it uses "PERM",
which is undefined. As nobody complained about this code, it seems to be
dead, so remove it.

This issue has been found using flake8. This Python linter reported:

    python/sepolgen/src/sepolgen/interfaces.py:158:37: F821 undefined
    name 'PERM'

While at it, fix a typo in a comment.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/interfaces.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/interfaces.py b/python/sepolgen/src/sepolgen/interfaces.py
index 48ae4f27a414..f4d3e5c5d6e0 100644
--- a/python/sepolgen/src/sepolgen/interfaces.py
+++ b/python/sepolgen/src/sepolgen/interfaces.py
@@ -112,7 +112,7 @@ def av_extract_params(av, params):
     entries in the dict, but if an unresolvable conflict is
     found it is reported to the caller.
 
-    The goal here is to figure out how interface paramaters are
+    The goal here is to figure out how interface parameters are
     actually used in the interface - e.g., that $1 is a domain used as
     a SRC_TYPE. In general an interface will look like this:
 
@@ -153,11 +153,6 @@ def av_extract_params(av, params):
         if __param_insert(av.obj_class, refpolicy.OBJ_CLASS, av, params) == 1:
             ret = 1
 
-    for perm in av.perms:
-        if access.is_idparam(perm):
-            if __param_insert(perm, PERM) == 1:
-                ret = 1
-
     return ret
 
 def role_extract_params(role, params):
-- 
2.18.0
