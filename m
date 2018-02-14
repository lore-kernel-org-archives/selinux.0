From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:14 +0100
Message-Id: <20180214095717.1050-13-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 12/15] secilc: build: follow standard semantics
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

 secilc/Makefile | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 1cac53e4..dfd79cef 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -1,8 +1,6 @@
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
 
 SECILC = secilc
 SECILC_SRCS := secilc.c
@@ -41,12 +39,12 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
 	$(XMLTO) man $(SECIL2CONF_MANPAGE).xml
 
 install: all man
-	-mkdir -p $(BINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 755 $(SECILC) $(BINDIR)
-	install -m 755 $(SECIL2CONF) $(BINDIR)
-	install -m 644 $(SECILC_MANPAGE) $(MANDIR)/man8
-	install -m 644 $(SECIL2CONF_MANPAGE) $(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
+	install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
+	install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
+	install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 doc:
 	$(MAKE) -C docs
-- 
2.15.1
