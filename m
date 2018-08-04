Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JmPVk007481
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:48:25 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 80670561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:02 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:24 +0200
Message-Id: <20180804194734.12577-4-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 03/13] python/sepolgen: return NotImplemented
 instead of raising it
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepolgen uses "return NotImplemented" (in access.py and matching.py) in
order to make Python's sorting function use an other call to compare
objects. For this to work, "NotImplemented" needs to be returned, not
raised like _compare's default implementation does.

This issue has been found using flake8. This Python linter reported:

    python/sepolgen/src/sepolgen/util.py:128:9: F901 'raise
    NotImplemented' should be 'raise NotImplementedError'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/util.py b/python/sepolgen/src/sepolgen/util.py
index 5d38bce29827..f5b66d0370a2 100644
--- a/python/sepolgen/src/sepolgen/util.py
+++ b/python/sepolgen/src/sepolgen/util.py
@@ -123,7 +123,7 @@ class Comparison():
     _compare function within your class."""
 
     def _compare(self, other, method):
-        raise NotImplemented
+        return NotImplemented
 
     def __eq__(self, other):
         return self._compare(other, lambda a, b: a == b)
-- 
2.18.0
