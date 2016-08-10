Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ADTNHu030542
 for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2016 09:29:23 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB11EC0567A1
 for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2016 13:28:58 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux/ChangeLog: Fix the author of the last libselinux
 change
Date: Wed, 10 Aug 2016 15:28:52 +0200
Message-Id: <1470835732-9875-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/ChangeLog | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/ChangeLog b/libselinux/ChangeLog
index 675403f..c3e84bb 100644
--- a/libselinux/ChangeLog
+++ b/libselinux/ChangeLog
@@ -1,4 +1,4 @@
-	* Fix in tree compilation of utils that depend on libsepol, from Petr Lautrbach.
+	* Fix in tree compilation of utils that depend on libsepol, from Laurent Bigonville.
 	* Change the location of _selinux.so, from Petr Lautrbach.
 	* Clarify is_selinux_mls_enabled() description, from David King.
 	* Explain how to free policy type from selinux_getpolicytype(), from David King.
-- 
1.8.3.1
