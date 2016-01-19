Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0JGJKkp024861
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 11:19:20 -0500
Received: from iosakhe.paris.ensmp.fr (nat-1.ensmp.fr [194.214.158.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 227C256470F
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 17:19:15 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: newrole: add missing defined in #if
Date: Tue, 19 Jan 2016 17:18:28 +0100
Message-Id: <1453220308-2967-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building newrole with gcc 5.3.0 and some warning flags, the
compiler reports:

  newrole.c:77:33: error: "NAMESPACE_PRIV" is not defined [-Werror=undef]
  #if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
                                  ^

Indeed, "defined" is missing here.  This nevertheless worked so far
because when NAMESPACE_PRIV was selected in the Makefile, newrole.c was
compiled with "-DNAMESPACE_PRIV", which defined NAMESPACE_PRIV to 1.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/newrole/newrole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 65a945d3d3f3..c6544eed07b9 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -74,7 +74,7 @@
 #ifdef USE_AUDIT
 #include <libaudit.h>
 #endif
-#if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
+#if defined(AUDIT_LOG_PRIV) || defined(NAMESPACE_PRIV)
 #include <sys/prctl.h>
 #include <cap-ng.h>
 #endif
-- 
2.7.0
