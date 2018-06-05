Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w55EiCaQ027402
 for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2018 10:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D87B4075390
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-229.brq.redhat.com
 [10.40.204.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9928663F48
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:31 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  5 Jun 2018 16:34:03 +0200
Message-Id: <20180605143405.4491-2-jzarsky@redhat.com>
In-Reply-To: <20180605143405.4491-1-jzarsky@redhat.com>
References: <20180605143405.4491-1-jzarsky@redhat.com>
Subject: [PATCH 1/3] python/sepolgen: print all AV rules correctly
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In refpolicy module, in AVRule.__rule_type_str() method, self.rule_type
was not checked for value self.NEVERALLOW so that string "neverallow"
was never returned. Fix this by checking all four possible values and
returning correct strings.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 python/sepolgen/src/sepolgen/refpolicy.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 352b1878..a262e1c5 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -472,8 +472,10 @@ class AVRule(Leaf):
             return "allow"
         elif self.rule_type == self.DONTAUDIT:
             return "dontaudit"
-        else:
+        elif self.rule_type == self.AUDITALLOW:
             return "auditallow"
+        elif self.rule_type == self.NEVERALLOW:
+            return "neverallow"
 
     def from_av(self, av):
         """Add the access from an access vector to this allow
-- 
2.14.4
