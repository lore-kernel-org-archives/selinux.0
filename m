From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:20 +0100
Message-Id: <20180116202327.23253-8-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 07/14] policycoreutils: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 policycoreutils/hll/pp/Makefile      |  7 ++-----
 policycoreutils/load_policy/Makefile |  8 ++++----
 policycoreutils/man/Makefile         |  3 ++-
 policycoreutils/newrole/Makefile     |  8 ++++----
 policycoreutils/po/Makefile          |  3 ++-
 policycoreutils/run_init/Makefile    |  8 ++++----
 policycoreutils/scripts/Makefile     |  8 ++++----
 policycoreutils/secon/Makefile       |  9 ++++-----
 policycoreutils/semodule/Makefile    |  8 +++-----
 policycoreutils/sestatus/Makefile    |  8 ++++----
 policycoreutils/setfiles/Makefile    |  5 ++---
 policycoreutils/setsebool/Makefile   | 10 ++++------
 12 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 3401dcc9..ce58e0cf 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -1,9 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-LIBEXECDIR ?= $(PREFIX)/libexec
+PREFIX ?= /usr
+LIBEXECDIR ?= $(DESTDIR)$(PREFIX)/libexec
 HLLDIR ?= $(LIBEXECDIR)/selinux/hll
 
 CFLAGS ?= -Werror -Wall -W
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index b85833c2..720bf45f 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
-MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
index 0d91cd46..8a8fbd49 100644
--- a/policycoreutils/man/Makefile
+++ b/policycoreutils/man/Makefile
@@ -1,5 +1,6 @@
 # Installation directories.
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
+PREFIX ?= /usr
+MAN5DIR ?= $(DESTDIR)$(PREFIX)/share/man/man5
 
 all:
 
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 196af926..4dbe6f52 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR = /usr/share/locale
+LOCALEDIR = $(DESTDIR)$(PREFIX)/share/locale
 PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 # Enable capabilities to permit newrole to generate audit records.
diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
index 58148613..c583d23a 100644
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
+INSTALL_NLS_DIR = $(DESTDIR)$(PREFIX)/share/locale
 
 # PO catalog handling
 MSGMERGE	= msgmerge
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 921f0b07..4178493e 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -1,10 +1,10 @@
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR ?= $(PREFIX)/share/man
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index d9e86ffe..cfd841ec 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
-MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= $(PREFIX)/share/locale
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 .PHONY: all
 all: fixfiles
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 8e491d74..4ecbd57d 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -1,9 +1,8 @@
 # secon tool - command-line context
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index fffb43ac..9d47e7e1 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol -lselinux -lsemanage
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 41ca6832..15443800 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
-LIBDIR ?= $(PREFIX)/lib
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -D_FILE_OFFSET_BITS=64
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index c08e2dd1..2a384234 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -1,8 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 SBINDIR ?= $(DESTDIR)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
 ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index bc254dab..cf300336 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -1,10 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
+BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol -lselinux -lsemanage
-- 
2.15.1
