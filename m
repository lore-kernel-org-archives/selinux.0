Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8R8HEnM014922
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 04:17:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47453C07F9A4
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 08:17:10 +0000 (UTC)
Received: from Thinkpad_450.redhat.com (unknown [10.40.205.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4DDE7EA3D
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 08:17:09 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 27 Sep 2017 10:16:45 +0200
Message-Id: <20170927081645.32481-3-vmojzis@redhat.com>
In-Reply-To: <20170927081645.32481-1-vmojzis@redhat.com>
References: <20170927081645.32481-1-vmojzis@redhat.com>
Subject: [PATCH 2/2] python/semanage: Enable listing
 fcontexts.homedirs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Include entries from fcontexts.homedirs when listing file contexts
via "semanage fcontext -l"

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
---
 python/semanage/seobject.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 70fd192..cf64e25 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2566,10 +2566,15 @@ class fcontextRecords(semanageRecords):
             if rc < 0:
                 raise ValueError(_("Could not list file contexts"))
 
+            (rc, fchomedirs) = semanage_fcontext_list_homedirs(self.sh)
+            if rc < 0:
+                raise ValueError(_("Could not list local file contexts"))
+
             (rc, fclocal) = semanage_fcontext_list_local(self.sh)
             if rc < 0:
                 raise ValueError(_("Could not list local file contexts"))
 
+            self.flist += fchomedirs
             self.flist += fclocal
 
         ddict = {}
-- 
2.9.4
