Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74CiFrG003617
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 08:44:15 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id F380C1A1AE
 for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2016 14:44:09 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TmVXvtSJsjIR for <selinux@tycho.nsa.gov>;
 Thu,  4 Aug 2016 14:44:07 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id CA1201A1A1
 for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2016 14:44:06 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux/utils/Makefile: Fix in tree compilation
Date: Thu,  4 Aug 2016 14:44:06 +0200
Message-Id: <1470314646-29805-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Some tools need the sepol/sepol.h header
---
 libselinux/utils/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index cf7af52..8497cb4 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -3,6 +3,7 @@ PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 USRBINDIR ?= $(PREFIX)/sbin
 SBINDIR ?= $(DESTDIR)/sbin
+INCLUDEDIR ?= $(PREFIX)/include
 
 MAX_STACK_SIZE=8192
 CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
@@ -23,7 +24,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
-override CFLAGS += -I../include -D_GNU_SOURCE $(EMFLAGS)
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
-- 
2.8.1
