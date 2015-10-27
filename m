Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9RMfnJo003560
 for <selinux@tycho.nsa.gov>; Tue, 27 Oct 2015 18:41:55 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id A85961A1D8
 for <selinux@tycho.nsa.gov>; Tue, 27 Oct 2015 23:41:34 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 08JESUQAHvMD for <selinux@tycho.nsa.gov>;
 Tue, 27 Oct 2015 23:41:32 +0100 (CET)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id D82B61A070
 for <selinux@tycho.nsa.gov>; Tue, 27 Oct 2015 23:41:31 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Load libsepol.so.1 instead of libsepol.so
Date: Tue, 27 Oct 2015 23:41:31 +0100
Message-Id: <1445985691-15518-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <l.bigonville@edpnet.be>

libsepol.so symlink is usually part of the development package, try to
load the library directly instead.
---
 libsemanage/utils/semanage_migrate_store | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index b5eefaa..0ebd285 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -10,7 +10,7 @@ from optparse import OptionParser
 
 import ctypes
 
-sepol = ctypes.cdll.LoadLibrary('libsepol.so')
+sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
 
 try:
 	import selinux
-- 
2.6.2
