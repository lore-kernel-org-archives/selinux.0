Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4GLrMAl010913
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 17:53:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zimbra.inuits.be (Postfix) with ESMTP id 5F74F4418F
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 23:53:17 +0200 (CEST)
From: Julien Pivotto <roidelapluie@inuits.eu>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: set flex as default lexer
Date: Mon, 16 May 2016 23:53:12 +0200
Message-Id: <1463435592-30980-1-git-send-email-roidelapluie@inuits.eu>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This makes the checkpolicy Makefile consistent with the Makefile present
in libsemanage and libsepol.
---
 checkpolicy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index e5fae3d..53a3074 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -8,6 +8,7 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 TARGETS = checkpolicy checkmodule
 
+LEX = flex
 YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
-- 
2.6.1
