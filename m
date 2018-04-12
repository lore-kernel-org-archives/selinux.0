Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3C7fcSK026278
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 03:41:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 40MCXG1Rmdzg47K
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 07:41:34 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 40MCXG0j0Czg46x
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 07:41:34 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7DA9EBFE5
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 07:41:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC2D215CDC6
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 07:41:30 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 12 Apr 2018 09:41:26 +0200
Message-Id: <20180412074126.26156-1-vmojzis@redhat.com>
In-Reply-To: <7c0df9c3-db88-47fd-aff4-f7ff900194b0@tycho.nsa.gov>
References: <7c0df9c3-db88-47fd-aff4-f7ff900194b0@tycho.nsa.gov>
Subject: [PATCH] python/sepolgen: Try to translate SELinux contexts
 to raw
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This allows sepolgen to generate policy from AVC messages that contain
contexts translated by mcstrans.

Fixes:

\# echo "type=USER_AVC msg=audit(1468415802.940:2199604): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0-s15:c0.c1023 msg='avc:  denied  { status } for auid=n/a uid=0 gid=0 cmdline="/usr/lib/systemd/systemd-logind" scontext=system_u:system_r:systemd_logind_t:SystemLow-SystemHigh tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=system  exe="/usr/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'" | audit2allow

libsepol.mls_from_string: invalid MLS context SystemLow-SystemHigh
libsepol.mls_from_string: could not construct mls context structure
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
system_u:system_r:systemd_logind_t:SystemLow-SystemHigh to sid

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
