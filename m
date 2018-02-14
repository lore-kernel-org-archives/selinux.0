From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:16 +0100
Message-Id: <20180214095717.1050-15-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 14/15] dbus: build: follow standard semantics for
 DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 dbus/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/dbus/Makefile b/dbus/Makefile
index 9a6cc90e..53143aff 100644
--- a/dbus/Makefile
+++ b/dbus/Makefile
@@ -1,3 +1,5 @@
+PREFIX ?= /usr
+
 all:
 
 clean:
@@ -5,12 +7,12 @@ clean:
 install:
 	-mkdir -p $(DESTDIR)/etc/dbus-1/system.d/
 	install -m 644 org.selinux.conf $(DESTDIR)/etc/dbus-1/system.d/
-	-mkdir -p $(DESTDIR)/usr/share/dbus-1/system-services
-	install -m 644 org.selinux.service $(DESTDIR)/usr/share/dbus-1/system-services
-	-mkdir -p $(DESTDIR)/usr/share/polkit-1/actions/
-	install -m 644 org.selinux.policy $(DESTDIR)/usr/share/polkit-1/actions/
-	-mkdir -p $(DESTDIR)/usr/share/system-config-selinux
-	install -m 755 selinux_server.py $(DESTDIR)/usr/share/system-config-selinux
+	-mkdir -p $(DESTDIR)$(PREFIX)/share/dbus-1/system-services
+	install -m 644 org.selinux.service $(DESTDIR)$(PREFIX)/share/dbus-1/system-services
+	-mkdir -p $(DESTDIR)$(PREFIX)/share/polkit-1/actions/
+	install -m 644 org.selinux.policy $(DESTDIR)$(PREFIX)/share/polkit-1/actions/
+	-mkdir -p $(DESTDIR)$(PREFIX)/share/system-config-selinux
+	install -m 755 selinux_server.py $(DESTDIR)$(PREFIX)/share/system-config-selinux
 
 relabel:
 
-- 
2.15.1
