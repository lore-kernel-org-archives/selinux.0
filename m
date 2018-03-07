Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w279GTIH025385
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 04:16:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zx7LM4qL8z1x08f
 for <selinux@tycho.nsa.gov>; Wed,  7 Mar 2018 09:16:27 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zx7LM4Gb3z1x08b
 for <selinux@tycho.nsa.gov>; Wed,  7 Mar 2018 09:16:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC6A18182D0C
 for <selinux@tycho.nsa.gov>; Wed,  7 Mar 2018 09:16:23 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed,  7 Mar 2018 10:16:20 +0100
Message-Id: <20180307091620.15232-1-jzarsky@redhat.com>
Subject: [PATCH] python/sepolgen: fix typo in PolicyGenerator
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

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
