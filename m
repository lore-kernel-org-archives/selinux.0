Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0BGNI5X016172
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 11:23:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54C2512E51F
 for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2018 16:22:22 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 11 Jan 2018 17:22:10 +0100
Message-Id: <20180111162210.21281-1-plautrba@redhat.com>
Subject: [PATCH] python/semanage: bring semanageRecords.set_reload
 back
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It's used by third parties, e.g. Ansible modules

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1527745

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/seobject.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b927b184..c2966251 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -260,6 +260,9 @@ class semanageRecords:
         else:
             self.mylog = nulllogger()
 
+    def set_reload(self, load):
+        self.noreload = not load
+
     def get_handle(self, store):
         global is_mls_enabled
 
-- 
2.15.1
