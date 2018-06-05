Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w55EZAd0026504
 for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2018 10:35:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 410Z856zKMz3GD9q
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:45 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 410Z846r2pz3GDB7
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:44 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3B244075398
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-229.brq.redhat.com
 [10.40.204.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B91863F48
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:32 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  5 Jun 2018 16:34:04 +0200
Message-Id: <20180605143405.4491-3-jzarsky@redhat.com>
In-Reply-To: <20180605143405.4491-1-jzarsky@redhat.com>
References: <20180605143405.4491-1-jzarsky@redhat.com>
Subject: [PATCH 2/3] python/sepolgen: fix access vector
 initialization
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In access module, in AccessVector.__init__() method, when init_list is
not None, the access vector is initialized by from_list() method.
However, this method does not assign attributes self.audit_msgs,
self.type, and self.data. Fix this by assigning these attributes in
__init__() method.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 python/sepolgen/src/sepolgen/access.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/access.py b/python/sepolgen/src/sepolgen/access.py
index a5d86982..21613eb8 100644
--- a/python/sepolgen/src/sepolgen/access.py
+++ b/python/sepolgen/src/sepolgen/access.py
@@ -87,9 +87,10 @@ class AccessVector(util.Comparison):
             self.tgt_type = None
             self.obj_class = None
             self.perms = refpolicy.IdSet()
-            self.audit_msgs = []
-            self.type = audit2why.TERULE
-            self.data = []
+
+        self.audit_msgs = []
+        self.type = audit2why.TERULE
+        self.data = []
         # when implementing __eq__ also __hash__ is needed on py2
         # if object is muttable __hash__ should be None
         self.__hash__ = None
-- 
2.14.4
