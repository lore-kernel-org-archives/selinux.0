Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91I24ba026471
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 14:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED09C4E33A
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:02:00 +0000 (UTC)
Received: from Thinkpad_450.redhat.com (ovpn-204-59.brq.redhat.com
 [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61509413E
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:02:00 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Oct 2017 20:01:27 +0200
Message-Id: <20171001180127.3673-3-vmojzis@redhat.com>
In-Reply-To: <20171001180127.3673-1-vmojzis@redhat.com>
References: <1506536279.27095.13.camel@tycho.nsa.gov>
 <20171001180127.3673-1-vmojzis@redhat.com>
Subject: [PATCH 3/3] python/semanage: Enable listing
 file_contexts.homedirs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Include entries from file_contexts.homedirs when listing file contexts
via "semanage fcontext -l"

"semanage fcontext -l" so far ignored content of file_contexts.homedirs
file, which is confusing for users (more specific rules may be ignored in
favor of rules unseen to the user since file_contexts.homedirs has
higher priority than file_contexts).

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
---
 python/semanage/seobject.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 70fd192..1385315 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2566,10 +2566,15 @@ class fcontextRecords(semanageRecords):
             if rc < 0:
                 raise ValueError(_("Could not list file contexts"))
 
+            (rc, fchomedirs) = semanage_fcontext_list_homedirs(self.sh)
+            if rc < 0:
+                raise ValueError(_("Could not list file contexts for home directories"))
+
             (rc, fclocal) = semanage_fcontext_list_local(self.sh)
             if rc < 0:
                 raise ValueError(_("Could not list local file contexts"))
 
+            self.flist += fchomedirs
             self.flist += fclocal
 
         ddict = {}
-- 
2.9.4
