Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4A7dvum019423
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 03:39:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 258B66264F
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 07:39:55 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: fix the extract example in semodule.8
Date: Tue, 10 May 2016 09:39:49 +0200
Message-Id: <1462865989-19741-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The man page's example suggested to use -g instead of -E

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 6db390c..e5b54b3 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -121,7 +121,7 @@ $ semodule \-B \-p "/tmp"
 $ semodule \-B \-S "/tmp/var/lib/selinux"
 # Write the HLL version of puppet and the CIL version of wireshark
 # modules at priority 400 to the current working directory
-$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
+$ semodule \-X 400 \-E wireshark \-\-cil \-E puppet \-\-hll
 .fi
 
 .SH SEE ALSO
-- 
2.7.4
