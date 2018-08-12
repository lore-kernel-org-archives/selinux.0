Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKQFal017830
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:26:15 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id EECC4564728
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:16 +0200
Message-Id: <20180812202522.3743-8-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 07/13] python/sepolgen: silence linter warning about has_key
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
