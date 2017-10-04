Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v94G3t9J001208
 for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2017 12:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C35179705
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 15:36:18 +0000 (UTC)
Received: from Thinkpad_450.redhat.com (unknown [10.40.205.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BAAE6FDC7
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 15:36:16 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed,  4 Oct 2017 17:36:04 +0200
Message-Id: <20171004153604.5817-3-vmojzis@redhat.com>
In-Reply-To: <20171004153604.5817-1-vmojzis@redhat.com>
References: <1dcea489-7584-e7a3-aa50-99a974440734@redhat.com>
 <20171004153604.5817-1-vmojzis@redhat.com>
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

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
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
