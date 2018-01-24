From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:29 +0100
Message-Id: <20180124092736.8432-9-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 08/15] python: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 python/audit2allow/Makefile           | 19 ++++++++++++-------
 python/chcat/Makefile                 |  8 ++++----
 python/semanage/Makefile              | 11 +++++------
 python/sepolgen/src/sepolgen/Makefile |  3 ++-
 python/sepolicy/Makefile              | 18 +++++++++---------
 5 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 8db8075f..7463ed85 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -1,19 +1,24 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
+
 all: audit2why sepolgen-ifgen-attr-helper
 
 sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 audit2why:
 	ln -sf audit2allow audit2why
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 0fd12d6d..947734a0 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -1,8 +1,8 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= $(PREFIX)/share/locale
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 .PHONY: all
 all: chcat
diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 132162bc..3e48b673 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -1,13 +1,12 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(PREFIX)/sbin
-MANDIR = $(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
+MANDIR = $(DESTDIR)$(PREFIX)/share/man
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
+BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
 
 TARGETS=semanage
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index d3aa7715..84548e98 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,5 +1,6 @@
+PREFIX ?= /usr
 PYTHON ?= python
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
 
 all:
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 5a56e6c8..1c02ee06 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -1,14 +1,14 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-BINDIR ?= $(PREFIX)/bin
-DATADIR ?= $(PREFIX)/share
-MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
-SHAREDIR ?= $(PREFIX)/share/sandbox
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+DATADIR ?= $(DESTDIR)$(PREFIX)/share
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
+BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
+SHAREDIR ?= $(DESTDIR)$(PREFIX)/share/sandbox
 CFLAGS ?= -Wall -Werror -Wextra -W
 override CFLAGS += -DPACKAGE="policycoreutils" -DSHARED -shared
 
@@ -30,7 +30,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
 	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
 	install -m 755 sepolicy.py $(BINDIR)/sepolicy
 	(cd $(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.15.1
