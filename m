Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JnWXN007499
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:49:36 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 24AE5561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:12 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:34 +0200
Message-Id: <20180804194734.12577-14-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 13/13] python/sepolicy: do not import types
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This module is not used and its name conflicts with variable "types".

This issue has been found using flake8. This Python linter reported:

    python/sepolicy/sepolicy/generate.py:657:5: F811 redefinition of
    unused 'types' from line 31

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/generate.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index f814e278663e..37ddfc7a2d63 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -28,7 +28,6 @@ import re
 import sepolicy
 from sepolicy import get_all_types, get_all_attributes, get_all_roles
 import time
-import types
 import platform
 
 from .templates import executable
-- 
2.18.0
