Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7IBI8bJ011001
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 07:18:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AD944E336
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 11:18:07 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] semanage: fix error message for fcontext -m
Date: Thu, 18 Aug 2016 13:18:01 +0200
Message-Id: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The type must be a file of device type, not a port type.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index a6681f0..a34d20d 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1937,7 +1937,7 @@ class fcontextRecords(semanageRecords):
         if serange == "" and setype == "" and seuser == "":
             raise ValueError(_("Requires setype, serange or seuser"))
         if setype and setype not in self.valid_types:
-            raise ValueError(_("Type %s is invalid, must be a port type") % setype)
+            raise ValueError(_("Type %s is invalid, must be a file or device type") % setype)
 
         self.validate(target)
 
-- 
1.8.3.1
