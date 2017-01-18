Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0IH7CRt018782
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 12:07:12 -0500
Received: by mail-wm0-f46.google.com with SMTP id r144so35371282wme.1
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 09:07:10 -0800 (PST)
MIME-Version: 1.0
From: Karl MacMillan <karlwmacmillan@gmail.com>
Date: Wed, 18 Jan 2017 12:07:08 -0500
Message-ID: <CANjvhbOeeRaFw_DhEL=QqLnycvHDd4rAnuLNVikhjQOjPYQVkQ@mail.gmail.com>
Subject: [PATCH] Compilation fixes for macOS
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Compilation fixes for macOS

ln on macOS doesn't support --relative, so use the gnu version by default.

Changes to how PREFIX is used in recent Makefiles make it so that
installation to /usr/local is broken on all systems, but /usr is not
writable on recent macOS versions so that is needed. This patch makes
'PREFIX=/usr/local make install' work again, but will break the
default of having LIBDIR be /usr/lib and SHLIBDIR be /usr/lib. I'm not
certain what this might break.

---
 README                | 3 +++
 libsepol/src/Makefile | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/README b/README
index e6f7276..2e04fa6 100644
--- a/README
+++ b/README
@@ -14,6 +14,9 @@ make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
install-pywrap relabel
 or on x86 (32-bit), run:
 make install install-pywrap relabel

+To install everyting under /usr/local run:
+make PREFIX=/usr/local install install-pywrap relabel
+
 This may render your system unusable if the upstream SELinux userspace
 lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 497cd56..1a924e1 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -2,7 +2,7 @@
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
+SHLIBDIR ?= $(PREFIX)/lib
 RANLIB ?= ranlib
 LIBBASE ?= $(shell basename $(LIBDIR))
 CILDIR ?= ../cil
@@ -32,10 +32,12 @@ endif

 LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs

+LN=ln
 OS := $(shell uname)
 ifeq ($(OS), Darwin)
 LD_SONAME_FLAGS=-install_name,$(LIBSO)
 LDFLAGS += -undefined dynamic_lookup
+LN=gln
 endif

 all: $(LIBA) $(LIBSO) $(LIBPC)
@@ -84,7 +86,7 @@ install: all
        install -m 755 $(LIBSO) $(SHLIBDIR)
        test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
        install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-       ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
+       $(LN) -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)

 relabel:
        /sbin/restorecon $(SHLIBDIR)/$(LIBSO)
-- 
2.6.2
