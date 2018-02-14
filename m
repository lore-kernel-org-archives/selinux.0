From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:09 +0100
Message-Id: <20180214095717.1050-8-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 07/15] policycoreutils: build: follow standard
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

 policycoreutils/hll/pp/Makefile      |  9 +++------
 policycoreutils/load_policy/Makefile | 16 ++++++++--------
 policycoreutils/man/Makefile         |  7 ++++---
 policycoreutils/newrole/Makefile     | 24 ++++++++++++------------
 policycoreutils/po/Makefile          |  7 ++++---
 policycoreutils/run_init/Makefile    | 22 +++++++++++-----------
 policycoreutils/scripts/Makefile     | 13 ++++++-------
 policycoreutils/secon/Makefile       | 12 +++++-------
 policycoreutils/semodule/Makefile    | 16 +++++++---------
 policycoreutils/sestatus/Makefile    | 21 ++++++++++-----------
 policycoreutils/setfiles/Makefile    | 23 +++++++++++------------
 policycoreutils/setsebool/Makefile   | 18 ++++++++----------
 12 files changed, 89 insertions(+), 99 deletions(-)

diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 3401dcc9..fc8d3c4a 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -1,8 +1,5 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
 LIBEXECDIR ?= $(PREFIX)/libexec
 HLLDIR ?= $(LIBEXECDIR)/selinux/hll
 
@@ -21,8 +18,8 @@ pp: $(PP_OBJS)
 	$(CC) $(CFLAGS) -c -o $@ $^
 
 install: all
-	-mkdir -p $(HLLDIR)
-	install -m 755 pp $(HLLDIR)
+	-mkdir -p $(DESTDIR)$(HLLDIR)
+	install -m 755 pp $(DESTDIR)$(HLLDIR)
 
 relabel:
 
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index b85833c2..568d5d49 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
+PREFIX ?= /usr
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
@@ -13,10 +13,10 @@ TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 $(TARGETS) $(SBINDIR)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 644 load_policy.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 644 load_policy.8 $(DESTDIR)$(MANDIR)/man8/
 
 clean:
 	-rm -f $(TARGETS) *.o 
@@ -25,4 +25,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel:
-	/sbin/restorecon $(SBINDIR)/load_policy 
+	/sbin/restorecon $(DESTDIR)$(SBINDIR)/load_policy 
diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
index 0d91cd46..8af1520c 100644
--- a/policycoreutils/man/Makefile
+++ b/policycoreutils/man/Makefile
@@ -1,12 +1,13 @@
 # Installation directories.
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
+PREFIX ?= /usr
+MAN5DIR ?= $(PREFIX)/share/man/man5
 
 all:
 
 clean:
 
 install: all
-	mkdir -p $(MAN5DIR)
-	install -m 644 man5/*.5 $(MAN5DIR)
+	mkdir -p $(DESTDIR)$(MAN5DIR)
+	install -m 644 man5/*.5 $(DESTDIR)$(MAN5DIR)
 
 relabel:
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 196af926..a1bfe1a6 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR = /usr/share/locale
+ETCDIR ?= /etc
+LOCALEDIR = $(DESTDIR)$(PREFIX)/share/locale
 PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 # Enable capabilities to permit newrole to generate audit records.
@@ -61,17 +61,17 @@ newrole: newrole.o $(EXTRA_OBJS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
-	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)
-	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
-	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
-	install -m $(MODE) newrole $(BINDIR)
-	install -m 644 newrole.1 $(MANDIR)/man1/
+	test -d $(DESTDIR)$(BINDIR)      || install -m 755 -d $(DESTDIR)$(BINDIR)
+	test -d $(DESTDIR)$(ETCDIR)/pam.d || install -m 755 -d $(DESTDIR)$(ETCDIR)/pam.d
+	test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d $(DESTDIR)$(MANDIR)/man1
+	install -m $(MODE) newrole $(DESTDIR)$(BINDIR)
+	install -m 644 newrole.1 $(DESTDIR)$(MANDIR)/man1/
 ifeq ($(PAMH), y)
-	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
+	test -d $(DESTDIR)$(ETCDIR)/pam.d || install -m 755 -d $(DESTDIR)$(ETCDIR)/pam.d
 ifeq ($(LSPP_PRIV),y)
-	install -m 644 newrole-lspp.pamd $(ETCDIR)/pam.d/newrole
+	install -m 644 newrole-lspp.pamd $(DESTDIR)$(ETCDIR)/pam.d/newrole
 else
-	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
+	install -m 644 newrole.pamd $(DESTDIR)$(ETCDIR)/pam.d/newrole
 endif
 endif
 
@@ -82,4 +82,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	/sbin/restorecon $(BINDIR)/newrole
+	/sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
index 58148613..575e1431 100644
--- a/policycoreutils/po/Makefile
+++ b/policycoreutils/po/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PO files (translation) catalog
 #
 
+PREFIX ?= /usr
 TOP	 = ../..
 
 # What is this package?
@@ -12,7 +13,7 @@ INSTALL_DATA	= $(INSTALL) -m 644
 INSTALL_DIR	= /usr/bin/install -d
 
 # destination directory
-INSTALL_NLS_DIR = $(DESTDIR)/usr/share/locale
+INSTALL_NLS_DIR = $(PREFIX)/share/locale
 
 # PO catalog handling
 MSGMERGE	= msgmerge
@@ -128,8 +129,8 @@ clean:
 install: $(MOFILES)
 	@for n in $(MOFILES); do \
 	    l=`basename $$n .mo`; \
-	    $(INSTALL_DIR) $(INSTALL_NLS_DIR)/$$l/LC_MESSAGES; \
-	    $(INSTALL_DATA) --verbose $$n $(INSTALL_NLS_DIR)/$$l/LC_MESSAGES/$(NLSPACKAGE).mo; \
+	    $(INSTALL_DIR) $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES; \
+	    $(INSTALL_DATA) --verbose $$n $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES/$(NLSPACKAGE).mo; \
 	done
 
 %.mo: %.po
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 921f0b07..1d5de572 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -1,10 +1,10 @@
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR ?= /usr/share/locale
+ETCDIR ?= /etc
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
@@ -32,14 +32,14 @@ open_init_pty: open_init_pty.c
 
 
 install: all
-	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 755 run_init $(SBINDIR)
-	install -m 755 open_init_pty $(SBINDIR)
-	install -m 644 run_init.8 $(MANDIR)/man8/
-	install -m 644 open_init_pty.8 $(MANDIR)/man8/
+	test -d $(DESTDIR)$(SBINDIR)      || install -m 755 -d $(DESTDIR)$(SBINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 755 run_init $(DESTDIR)$(SBINDIR)
+	install -m 755 open_init_pty $(DESTDIR)$(SBINDIR)
+	install -m 644 run_init.8 $(DESTDIR)$(MANDIR)/man8/
+	install -m 644 open_init_pty.8 $(DESTDIR)$(MANDIR)/man8/
 ifeq ($(PAMH), y)
-	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
+	install -m 644 run_init.pamd $(DESTDIR)$(ETCDIR)/pam.d/run_init
 endif
 
 clean:
@@ -49,4 +49,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	/sbin/restorecon $(SBINDIR)/run_init $(SBINDIR)/open_init_pty
+	/sbin/restorecon $(DESTDIR)$(SBINDIR)/run_init $(DESTDIR)$(SBINDIR)/open_init_pty
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index d9e86ffe..afe5dc49 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -1,17 +1,16 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
+PREFIX ?= /usr
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= $(PREFIX)/share/locale
 
 .PHONY: all
 all: fixfiles
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 fixfiles $(SBINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 fixfiles.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 fixfiles $(DESTDIR)$(SBINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 644 fixfiles.8 $(DESTDIR)$(MANDIR)/man8/
 
 clean:
 
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 8e491d74..db8ee421 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -1,9 +1,7 @@
 # secon tool - command-line context
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
 
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
@@ -18,13 +16,13 @@ secon: secon.o
 install-nogui: install
 
 install: all
-	install -m 755 secon $(BINDIR);
+	install -m 755 secon $(DESTDIR)$(BINDIR);
 
-	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
-	install -m 644 secon.1 $(MANDIR)/man1
+	test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d $(DESTDIR)$(MANDIR)/man1
+	install -m 644 secon.1 $(DESTDIR)$(MANDIR)/man1
 
 relabel:
-	/sbin/restorecon $(BINDIR)/secon
+	/sbin/restorecon $(DESTDIR)$(BINDIR)/secon
 
 clean:
 	rm -f *.o core* secon *~ *.bak
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index fffb43ac..639d3689 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol -lselinux -lsemanage
@@ -17,12 +15,12 @@ genhomedircon:
 	ln -sf semodule genhomedircon
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 semodule $(SBINDIR)
-	(cd $(SBINDIR); ln -sf semodule genhomedircon)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 644 semodule.8 $(MANDIR)/man8/
-	install -m 644 genhomedircon.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 semodule $(DESTDIR)$(SBINDIR)
+	(cd $(DESTDIR)$(SBINDIR); ln -sf semodule genhomedircon)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 644 semodule.8 $(DESTDIR)$(MANDIR)/man8/
+	install -m 644 genhomedircon.8 $(DESTDIR)$(MANDIR)/man8/
 
 relabel:
 
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 41ca6832..274ef353 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -1,9 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-ETCDIR ?= $(DESTDIR)/etc
-LIBDIR ?= $(PREFIX)/lib
+ETCDIR ?= /etc
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -D_FILE_OFFSET_BITS=64
@@ -14,14 +13,14 @@ all: sestatus
 sestatus: sestatus.o
 
 install: all
-	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
-	[ -d $(MANDIR)/man5 ] || mkdir -p $(MANDIR)/man5
-	-mkdir -p $(SBINDIR)
-	install -m 755 sestatus $(SBINDIR)
-	install -m 644 sestatus.8 $(MANDIR)/man8
-	install -m 644 sestatus.conf.5 $(MANDIR)/man5
-	-mkdir -p $(ETCDIR)
-	install -m 644 sestatus.conf $(ETCDIR)
+	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
+	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 sestatus $(DESTDIR)$(SBINDIR)
+	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
+	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
+	-mkdir -p $(DESTDIR)$(ETCDIR)
+	install -m 644 sestatus.conf $(DESTDIR)$(ETCDIR)
 
 clean:
 	rm -f sestatus *.o
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index c08e2dd1..e9432768 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -1,8 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
+PREFIX ?= /usr
+SBINDIR ?= /sbin
 MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
 ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
@@ -29,14 +28,14 @@ man:
 	@sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g" setfiles.8.man
 
 install: all
-	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
-	-mkdir -p $(SBINDIR)
-	install -m 755 setfiles $(SBINDIR)
-	(cd $(SBINDIR) && ln -sf setfiles restorecon)
-	install -m 755 restorecon_xattr $(SBINDIR)
-	install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
-	install -m 644 restorecon.8 $(MANDIR)/man8/restorecon.8
-	install -m 644 restorecon_xattr.8 $(MANDIR)/man8/restorecon_xattr.8
+	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 setfiles $(DESTDIR)$(SBINDIR)
+	(cd $(DESTDIR)$(SBINDIR) && ln -sf setfiles restorecon)
+	install -m 755 restorecon_xattr $(DESTDIR)$(SBINDIR)
+	install -m 644 setfiles.8.man $(DESTDIR)$(MANDIR)/man8/setfiles.8
+	install -m 644 restorecon.8 $(DESTDIR)$(MANDIR)/man8/restorecon.8
+	install -m 644 restorecon_xattr.8 $(DESTDIR)$(MANDIR)/man8/restorecon_xattr.8
 
 clean:
 	rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man
@@ -45,4 +44,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	$(SBINDIR)/restorecon $(SBINDIR)/setfiles $(SBINDIR)/restorecon_xattr
+	$(DESTDIR)$(SBINDIR)/restorecon $(DESTDIR)$(SBINDIR)/setfiles $(DESTDIR)$(SBINDIR)/restorecon_xattr
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index bc254dab..3cd58353 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -1,10 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
+BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol -lselinux -lsemanage
@@ -17,12 +15,12 @@ all: setsebool
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 setsebool $(SBINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 setsebool.8 $(MANDIR)/man8/
-	-mkdir -p $(BASHCOMPLETIONDIR)
-	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/setsebool
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 setsebool $(DESTDIR)$(SBINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 644 setsebool.8 $(DESTDIR)$(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
+	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/setsebool
 
 relabel:
 
-- 
2.15.1
