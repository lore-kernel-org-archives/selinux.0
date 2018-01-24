From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:31 +0100
Message-Id: <20180124092736.8432-11-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 10/15] restorecond: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 restorecond/Makefile | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index ada94aeb..a2316947 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -1,13 +1,12 @@
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(PREFIX)/sbin
-LIBDIR ?= $(PREFIX)/lib
-MANDIR = $(PREFIX)/share/man
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
 AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
-DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
-SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
+DBUSSERVICEDIR = $(DESTDIR)$(PREFIX)/share/dbus-1/services
+SYSTEMDDIR ?= $(DESTDIR)$(PREFIX)/lib/systemd
 
 autostart_DATA = sealertauto.desktop
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
-- 
2.15.1
