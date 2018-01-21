From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:13 +0100
Message-Id: <20180121214617.8975-11-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 10/14] sandbox: build: follow standard semantics
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
