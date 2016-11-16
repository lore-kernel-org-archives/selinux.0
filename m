Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGE5ZKN011164
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 09:05:38 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so9916507pfk.2
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 06:05:37 -0800 (PST)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] mcstrans: take LIBDIR from args, dont guess
Date: Wed, 16 Nov 2016 22:05:19 +0800
Message-Id: <1479305122-2419-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1479305122-2419-1-git-send-email-jason@perfinion.com>
References: <1479305122-2419-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

All the other makefiles just have LIBDIR optionally set so it can be
overridden. These makefiles were autodetecting incorrectly. uname -i
returns "GenuineIntel" so should have been uname -m.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 mcstrans/src/Makefile   | 18 ++----------------
 mcstrans/utils/Makefile | 18 +-----------------
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 907a1f1..ae74a16 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,20 +1,6 @@
-ARCH = $(shell uname -i)
-ifeq "$(ARCH)" "x86_64"
-	# In case of 64 bit system, use these lines
-	LIBDIR=/usr/lib64
-else 
-ifeq "$(ARCH)" "i686"
-	# In case of 32 bit system, use these lines
-	LIBDIR=/usr/lib
-else
-ifeq "$(ARCH)" "i386"
-	# In case of 32 bit system, use these lines
-	LIBDIR=/usr/lib
-endif
-endif
-endif
 # Installation directories.
-PREFIX  ?= $(DESTDIR)/usr
+PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(DESTDIR)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
 SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 1ffb027..43608db 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,24 +1,8 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
 
-ARCH = $(shell uname -i)
-ifeq "$(ARCH)" "x86_64"
-        # In case of 64 bit system, use these lines
-        LIBDIR=/usr/lib64
-else
-ifeq "$(ARCH)" "i686"
-        # In case of 32 bit system, use these lines
-        LIBDIR=/usr/lib
-else
-ifeq "$(ARCH)" "i386"
-        # In case of 32 bit system, use these lines
-        LIBDIR=/usr/lib
-endif
-endif
-endif
-
-
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
 LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
-- 
2.7.3
