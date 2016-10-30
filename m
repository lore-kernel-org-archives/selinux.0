Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9UJFJQM026694
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 15:15:20 -0400
Received: from eversmanni.numericable.fr (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E0D025646C3
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 20:15:15 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] policycoreutils: restorecond: use pkg-config to find
 dbus-glib-1 files
Date: Sun, 30 Oct 2016 20:15:08 +0100
Message-Id: <20161030191508.9155-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Ubuntu some header files are located in /usr/lib/x86_64-linux-gnu/,
not /usr/lib64/:

    $ pkg-config --cflags dbus-glib-1
    -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
    -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include

Use pkg-config instead of hard-coded paths to find glib and dbus-glib
headers and libraries.

This is needed in order to use environments provided for example by
https://travis-ci.org/.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/restorecond/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/restorecond/Makefile b/policycoreutils/restorecond/Makefile
index 253246d7b5ea..93050f00d230 100644
--- a/policycoreutils/restorecond/Makefile
+++ b/policycoreutils/restorecond/Makefile
@@ -1,3 +1,5 @@
+PKG_CONFIG ?= pkg-config
+
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(PREFIX)/sbin
@@ -11,11 +13,11 @@ autostart_DATA = sealertauto.desktop
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
-DBUSFLAGS = -DHAVE_DBUS -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/lib/dbus-1.0/include
-DBUSLIB = -ldbus-glib-1 -ldbus-1
+DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
+DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
+override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS)
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
@@ -24,7 +26,7 @@ else
 	PCRE_LDFLAGS := -lpcre
 endif
 
-LDLIBS += -lselinux $(PCRE_LDFLAGS) $(DBUSLIB) -lglib-2.0 -L$(LIBDIR)
+LDLIBS += -lselinux $(PCRE_LDFLAGS) $(DBUSLIB) -L$(LIBDIR)
 
 all: restorecond
 
-- 
2.10.1
