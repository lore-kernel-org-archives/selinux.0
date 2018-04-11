Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3B9QoFw020043
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 05:26:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31EC340006E6
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 09:26:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA0AC215CDC6
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 09:26:37 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 11 Apr 2018 11:26:28 +0200
Message-Id: <20180411092628.7178-1-vmojzis@redhat.com>
Subject: [PATCH] python/sepolgen: Try to translate SELinux contexts
 to raw
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This allows sepolgen to generate policy from AVC messages that contain
contexts translated by mcstrans.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1356149

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolgen/src/sepolgen/refpolicy.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 2ee029c1..352b1878 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -284,6 +284,11 @@ class SecurityContext(Leaf):
 
         Raises ValueError if the string is not parsable as a security context.
         """
+        # try to translate the context string to raw form
+        raw = selinux.selinux_trans_to_raw_context(context)
+        if raw[0] == 0:
+            context = raw[1]
+
         fields = context.split(":")
         if len(fields) < 3:
             raise ValueError("context string [%s] not in a valid format" % context)
-- 
2.14.3
