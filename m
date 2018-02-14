From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:07 +0100
Message-Id: <20180214095717.1050-6-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 05/15] gui: build: follow standard semantics for
 DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    	-  Only use $(DESTDIR) in install
    
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 gui/Makefile | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/gui/Makefile b/gui/Makefile
index cfe47405..d26f0000 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 SHAREDIR ?= $(PREFIX)/share/system-config-selinux
 DATADIR ?= $(PREFIX)/share
@@ -23,29 +23,29 @@ usersPage.py
 all: $(TARGETS) system-config-selinux.py polgengui.py
 
 install: all
-	-mkdir -p $(MANDIR)/man8
-	-mkdir -p $(SHAREDIR)
-	-mkdir -p $(BINDIR)
-	-mkdir -p $(DATADIR)/pixmaps
-	-mkdir -p $(DATADIR)/icons/hicolor/24x24/apps
-	-mkdir -p $(DATADIR)/polkit-1/actions/
-	install -m 755 system-config-selinux.py $(SHAREDIR)
-	install -m 755 system-config-selinux $(BINDIR)
-	install -m 755 polgengui.py $(SHAREDIR)
-	install -m 644 $(TARGETS) $(SHAREDIR)
-	install -m 644 system-config-selinux.8 $(MANDIR)/man8
-	install -m 644 selinux-polgengui.8 $(MANDIR)/man8
-	install -m 644 system-config-selinux.png $(DATADIR)/pixmaps
-	install -m 644 system-config-selinux.png $(DATADIR)/icons/hicolor/24x24/apps
-	install -m 644 system-config-selinux.png $(DATADIR)/system-config-selinux
-	install -m 644 *.desktop $(DATADIR)/system-config-selinux
-	-mkdir -p $(DESTDIR) $(DATADIR)/pixmaps
-	install -m 644 sepolicy_256.png $(DATADIR)/pixmaps/sepolicy.png
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(SHAREDIR)
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
+	-mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
+	-mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
+	install -m 755 system-config-selinux.py $(DESTDIR)$(SHAREDIR)
+	install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
+	install -m 755 polgengui.py $(DESTDIR)$(SHAREDIR)
+	install -m 644 $(TARGETS) $(DESTDIR)$(SHAREDIR)
+	install -m 644 system-config-selinux.8 $(DESTDIR)$(MANDIR)/man8
+	install -m 644 selinux-polgengui.8 $(DESTDIR)$(MANDIR)/man8
+	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/pixmaps
+	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
+	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/system-config-selinux
+	install -m 644 *.desktop $(DESTDIR)$(DATADIR)/system-config-selinux
+	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
+	install -m 644 sepolicy_256.png $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
 	for i in 16 22 32 48 256; do \
-		mkdir -p $(DESTDIR) $(DATADIR)/icons/hicolor/$${i}x$${i}/apps; \
-		install -m 644 sepolicy_$${i}.png $(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
+		mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/$${i}x$${i}/apps; \
+		install -m 644 sepolicy_$${i}.png $(DESTDIR)$(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
 	done
-	install -m 644 org.selinux.config.policy $(DATADIR)/polkit-1/actions/
+	install -m 644 org.selinux.config.policy $(DESTDIR)$(DATADIR)/polkit-1/actions/
 clean:
 
 indent:
-- 
2.15.1
