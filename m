Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SKb0pd003870
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 16:37:00 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C131564998
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 22:36:54 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] policycoreutils: setfiles: ignore restorecon_xattr in git
Date: Wed, 28 Sep 2016 22:36:44 +0200
Message-Id: <20160928203644.9458-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit f1352e739925 ("policycoreutils: setfiles - Utility to find
security.restorecon_last entries") introduced restorecon_xattr binary
without adding it to .gitignore.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/.gitignore b/policycoreutils/.gitignore
index 3a96936c6ce0..53d5d558d61b 100644
--- a/policycoreutils/.gitignore
+++ b/policycoreutils/.gitignore
@@ -12,6 +12,7 @@ semodule_package/semodule_package
 semodule_package/semodule_unpackage
 sestatus/sestatus
 setfiles/restorecon
+setfiles/restorecon_xattr
 setfiles/setfiles
 setsebool/setsebool
 hll/pp/pp
-- 
2.10.0
