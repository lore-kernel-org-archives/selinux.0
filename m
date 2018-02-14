From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:12 +0100
Message-Id: <20180214095717.1050-11-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 10/15] restorecond: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    	- Only use $(DESTDIR) in install
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 restorecond/Makefile | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index ada94aeb..25be18d4 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -1,13 +1,12 @@
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
-LIBDIR ?= $(PREFIX)/lib
 MANDIR = $(PREFIX)/share/man
-AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
-DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
-SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
+AUTOSTARTDIR = /etc/xdg/autostart
+DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
+SYSTEMDDIR ?= $(PREFIX)/lib/systemd
 
 autostart_DATA = sealertauto.desktop
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
@@ -39,23 +38,23 @@ restorecond:  restore.o restorecond.o utmpwatcher.o stringslist.o user.o watch.o
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
-	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
-	-mkdir -p $(SBINDIR)
-	install -m 755 restorecond $(SBINDIR)
-	install -m 644 restorecond.8 $(MANDIR)/man8
+	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 restorecond $(DESTDIR)$(SBINDIR)
+	install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
 	-mkdir -p $(INITDIR)
 	install -m 755 restorecond.init $(INITDIR)/restorecond
 	-mkdir -p $(SELINUXDIR)
 	install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
 	install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
-	-mkdir -p $(AUTOSTARTDIR)
-	install -m 644 restorecond.desktop $(AUTOSTARTDIR)/restorecond.desktop
-	-mkdir -p $(DBUSSERVICEDIR)
-	install -m 600 org.selinux.Restorecond.service  $(DBUSSERVICEDIR)/org.selinux.Restorecond.service
-	-mkdir -p $(SYSTEMDDIR)/system
-	install -m 644 restorecond.service $(SYSTEMDDIR)/system/
+	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
+	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
+	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
+	install -m 600 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
+	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
+	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
 relabel: install
-	/sbin/restorecon $(SBINDIR)/restorecond 
+	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond 
 
 clean:
 	-rm -f restorecond *.o *~
-- 
2.15.1
