Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44GCQ2t009971
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 12:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D9DE81A88C3
 for <selinux@tycho.nsa.gov>; Fri,  4 May 2018 11:51:56 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri,  4 May 2018 13:51:46 +0200
Message-Id: <20180504115146.19532-1-plautrba@redhat.com>
Subject: [PATCH] python/semanage/seobject.py: Fix undefined store
 check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Vit Mojzis <vmojzis@redhat.com>

self.store is always a string (actual store name or "") because of
semanageRecords.__init__. Fix check for not defined store.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1559174#c3

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index ac310ea6..c76dce85 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2651,7 +2651,7 @@ class booleanRecords(semanageRecords):
             self.current_booleans = []
             ptype = None
 
-        if self.store is None or self.store == ptype:
+        if self.store == "" or self.store == ptype:
             self.modify_local = True
         else:
             self.modify_local = False
-- 
2.17.0
