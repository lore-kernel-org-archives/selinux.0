From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:13 +0100
Message-Id: <20180214095717.1050-12-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 11/15] sandbox: build: follow standard semantics
 for DESTDIR and PREFIX
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

 sandbox/Makefile | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/sandbox/Makefile b/sandbox/Makefile
index 05c3d658..49c1d3f6 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -1,13 +1,11 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+SYSCONFDIR ?= /etc/sysconfig
 BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
 override CFLAGS += -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
 override LDLIBS += -lselinux -lcap-ng
@@ -18,20 +16,20 @@ all: sandbox seunshare sandboxX.sh start
 seunshare: $(SEUNSHARE_OBJS)
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 sandbox $(BINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 sandbox.8 $(MANDIR)/man8/
-	install -m 644 seunshare.8 $(MANDIR)/man8/
-	-mkdir -p $(MANDIR)/man5
-	install -m 644 sandbox.5 $(MANDIR)/man5/
-	-mkdir -p $(SBINDIR)
-	install -m 4755 seunshare $(SBINDIR)/
-	-mkdir -p $(SHAREDIR)
-	install -m 755 sandboxX.sh $(SHAREDIR)
-	install -m 755 start $(SHAREDIR)
-	-mkdir -p $(SYSCONFDIR)
-	install -m 644 sandbox.conf $(SYSCONFDIR)/sandbox
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 sandbox $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 644 sandbox.8 $(DESTDIR)$(MANDIR)/man8/
+	install -m 644 seunshare.8 $(DESTDIR)$(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(MANDIR)/man5
+	install -m 644 sandbox.5 $(DESTDIR)$(MANDIR)/man5/
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 4755 seunshare $(DESTDIR)$(SBINDIR)/
+	-mkdir -p $(DESTDIR)$(SHAREDIR)
+	install -m 755 sandboxX.sh $(DESTDIR)$(SHAREDIR)
+	install -m 755 start $(DESTDIR)$(SHAREDIR)
+	-mkdir -p $(DESTDIR)$(SYSCONFDIR)
+	install -m 644 sandbox.conf $(DESTDIR)$(SYSCONFDIR)/sandbox
 
 test:
 	@$(PYTHON) test_sandbox.py -v
-- 
2.15.1
