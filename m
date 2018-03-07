Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w279xjgO006393
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 04:59:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5BE840363BE
 for <selinux@tycho.nsa.gov>; Wed,  7 Mar 2018 09:59:27 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed,  7 Mar 2018 10:59:21 +0100
Message-Id: <20180307095921.15664-1-jzarsky@redhat.com>
In-Reply-To: <20180307091620.15232-1-jzarsky@redhat.com>
References: <20180307091620.15232-1-jzarsky@redhat.com>
Subject: [PATCH] python/sepolgen: fix typo in PolicyGenerator
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 python/sepolgen/src/sepolgen/policygen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 34c84010..ee664fb7 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -77,7 +77,7 @@ class PolicyGenerator:
         self.explain = NO_EXPLANATION
         self.gen_requires = False
         if module:
-            self.moduel = module
+            self.module = module
         else:
             self.module = refpolicy.Module()
 
-- 
2.14.3
