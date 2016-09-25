Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8PCGdhP015441
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 08:16:43 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 34E78564E1F
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 14:16:41 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] policycoreutils: Remove LDFLAGS from CFLAGS
Date: Sun, 25 Sep 2016 14:16:09 +0200
Message-Id: <20160925121609.14516-3-nicolas.iooss@m4x.org>
In-Reply-To: <20160925121609.14516-1-nicolas.iooss@m4x.org>
References: <20160925121609.14516-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Mixing LDFLAGS in CFLAGS can lead to compiler errors. For example in
policycoreutils/sandbox:

    $ make CC=clang LDFLAGS='-Wl,-as-needed,-no-undefined'
    clang -Wl,-as-needed,-no-undefined -I/usr/include
    -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W   -c -o
    seunshare.o seunshare.c
    clang-3.8: error: -Wl,-as-needed,-no-undefined: 'linker' input
    unused

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/newrole/Makefile | 2 +-
 policycoreutils/sandbox/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 646cd4dd7214..8b41428cbbbc 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -22,7 +22,7 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq ($(PAMH), /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
index a4861eab52b6..2716d691d81b 100644
--- a/policycoreutils/sandbox/Makefile
+++ b/policycoreutils/sandbox/Makefile
@@ -9,7 +9,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
+override CFLAGS += -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
 LDLIBS += -lselinux -lcap-ng -L$(LIBDIR)
 SEUNSHARE_OBJS = seunshare.o
 
-- 
2.10.0
