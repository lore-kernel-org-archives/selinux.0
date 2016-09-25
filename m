Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8PEVnR4026972
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 10:31:49 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A6BCD564A39
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 16:31:46 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/tests: fix mispelling of optimization option
Date: Sun, 25 Sep 2016 16:30:40 +0200
Message-Id: <20160925143040.31378-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In CFLAGS, -o0 means "output in file 0", not "compile at optimization
level 0".

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index dd7bd333c58c..60b3e836cc94 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -2,7 +2,7 @@ M4 ?= m4
 MKDIR ?= mkdir
 EXE ?= libsepol-tests
 
-CFLAGS += -g3 -gdwarf-2 -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
+CFLAGS += -g3 -gdwarf-2 -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
 
 # Statically link libsepol on the assumption that we are going to
 # be testing internal functions.
-- 
2.10.0
