Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7A8dJhh031090
 for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2016 04:39:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11D7AC0586CA
 for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2016 08:39:14 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] semanage: swap tcp and udp protocol numbers
Date: Wed, 10 Aug 2016 10:39:10 +0200
Message-Id: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The tcp/udp protocol numbers were accidentaly swapped in
the original patch 'semanage: add auditing of changes in records'.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 317b421..786ed0e 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -88,8 +88,8 @@ file_type_str_to_option = {"all files": "a",
                            "symbolic link": "l",
                            "named pipe": "p"}
 
-proto_to_audit = {"tcp": 17,
-                  "udp": 6,
+proto_to_audit = {"tcp": 6,
+                  "udp": 17,
                   "ipv4": 4,
                   "ipv6": 41}
 
-- 
1.8.3.1
