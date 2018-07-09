Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w69IV1DH021603
 for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2018 14:31:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 41PYmz5PQRz34qRh
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 18:30:59 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 41PYmz1ctcz34qRs
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 18:30:59 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80C154074476
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 18:30:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2226C2166BA2
 for <selinux@tycho.nsa.gov>; Mon,  9 Jul 2018 18:30:53 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  9 Jul 2018 20:29:40 +0200
Message-Id: <20180709182940.32725-1-vmojzis@redhat.com>
Subject: [PATCH] python/semanage: Fix logger class definition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Test if audit module is enabled so that logger class is defined
correctly.

Fixes:
"semanage fcontext -l" fails with "OSError: Protocol not supported" when
booting with audit=0

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index e5c81a7d..29b4afe0 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -101,6 +101,8 @@ ftype_to_audit = {"": "any",
 
 try:
     import audit
+    #test if audit module is enabled
+    audit.audit_close(audit.audit_open())
 
     class logger:
 
-- 
2.14.3
