From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:32 +0100
Message-Id: <20180124092736.8432-12-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 11/15] sandbox: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 sandbox/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sandbox/Makefile b/sandbox/Makefile
index 05c3d658..5a6b707a 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -1,14 +1,14 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
-LIBDIR ?= $(PREFIX)/lib
-BINDIR ?= $(PREFIX)/bin
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
-SHAREDIR ?= $(PREFIX)/share/sandbox
+SHAREDIR ?= $(DESTDIR)$(PREFIX)/share/sandbox
 override CFLAGS += -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
 override LDLIBS += -lselinux -lcap-ng
 SEUNSHARE_OBJS = seunshare.o
-- 
2.15.1
