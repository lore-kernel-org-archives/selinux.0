Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JmCBB007477
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:48:15 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 82C24561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:06 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:28 +0200
Message-Id: <20180804194734.12577-8-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 07/13] python/sepolgen: silence linter warning about has_key
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

flake8 warns about using has_key():

    python/sepolgen/src/sepolgen/refparser.py:315:15: W601 .has_key() is
    deprecated, use 'in'

However "spt.has_key(id)" uses function SupportMacros.has_key(), which
is not the same as the "in" operator. Silence this warning by using "#
noqa".

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 3415aff9b48f..97e2342c4693 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -312,7 +312,7 @@ def collect(stmts, parent, val=None):
 
 def expand(ids, s):
     for id in ids:
-        if spt.has_key(id):
+        if spt.has_key(id):  # noqa
             s.update(spt.by_name(id))
         else:
             s.add(id)
-- 
2.18.0
