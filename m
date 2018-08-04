Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JoFgR007514
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:50:15 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4B41C561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:11 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:33 +0200
Message-Id: <20180804194734.12577-13-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 12/13] python/sepolicy: do not import
 sepolicy.generate.DAEMON twice
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This issue has been found using flake8. This Python linter reported:

    python/sepolicy/sepolicy.py:582:5: F811 redefinition of unused
    'DAEMON' from line 582

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 24631b51ee37..a000c1addd99 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -579,7 +579,7 @@ def gen_interface_args(parser):
 
 
 def gen_generate_args(parser):
-    from sepolicy.generate import DAEMON, get_poltype_desc, poltype, DAEMON, DBUS, INETD, CGI, SANDBOX, USER, EUSER, TUSER, XUSER, LUSER, AUSER, RUSER, NEWTYPE
+    from sepolicy.generate import get_poltype_desc, poltype, DAEMON, DBUS, INETD, CGI, SANDBOX, USER, EUSER, TUSER, XUSER, LUSER, AUSER, RUSER, NEWTYPE
 
     generate_usage = generate_custom_usage(usage, usage_dict)
 
-- 
2.18.0
