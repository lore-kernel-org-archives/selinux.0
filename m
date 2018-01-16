From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:22 +0100
Message-Id: <20180116202327.23253-10-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 09/14] restorecond: build: follow standard
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
