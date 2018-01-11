Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0BHipH5023166
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 12:44:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID03.oob.disa.mil (Postfix) with SMTP id 3zHYDB6kxxzmpCR
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 17:44:42 +0000 (UTC)
Received: from USFB19PA10.eemsg.mil (unknown [192.168.16.7])
 by USFBF3ID03.oob.disa.mil (Postfix) with ESMTP id 3zHYDB6DDvzmp8n
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 17:44:42 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 005856345
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 17:44:34 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.43.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778165C66F
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 17:44:33 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 11 Jan 2018 18:44:27 +0100
Message-Id: <20180111174427.24529-1-vmojzis@redhat.com>
Subject: [PATCH] python/semanage: Remove redundant and broken
 moduleRecords.modify()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

moduleRecords.modify() calls nonexistent function
semanage_module_update_file (maybe it should have been
semanage_module_upgrade_file which is now obsolete and calls
semanage_module_install_file) and the job of updating a module is done
by moduleRecords.add().

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b927b18..740bd7c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -423,11 +423,6 @@ class moduleRecords(semanageRecords):
                     raise ValueError(_("Could not disable module %s") % m)
         self.commit()
 
-    def modify(self, file):
-        rc = semanage_module_update_file(self.sh, file)
-        if rc >= 0:
-            self.commit()
-
     def delete(self, module, priority):
         rc = semanage_set_default_priority(self.sh, priority)
         if rc < 0:
-- 
2.9.4
