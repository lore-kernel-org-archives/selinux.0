From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:10 +0100
Message-Id: <20180214095717.1050-9-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 08/15] python: build: follow standard semantics
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
    	- Remove CFLAGS from linking rule
    
    v4:
    	-  move platform from platform specific to platform shared installation directory
    
    v3:
    	- Add missing slash
    	- keep the possibility to specify LIBSEPOLA to
    	  make depending component recompile on change. If not specified, fall back to
    	  libsepola in LDFLAGS path.
    
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 python/audit2allow/Makefile           | 30 +++++++++++++++++-------------
 python/chcat/Makefile                 | 11 +++++------
 python/semanage/Makefile              | 25 ++++++++++++-------------
 python/sepolgen/src/sepolgen/Makefile |  9 +++++----
 python/sepolgen/src/share/Makefile    |  8 ++++----
 python/sepolicy/Makefile              | 24 ++++++++++--------------
 6 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 8db8075f..513bb2b6 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -1,19 +1,23 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
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
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 audit2why:
 	ln -sf audit2allow audit2why
@@ -22,14 +26,14 @@ test: all
 	@$(PYTHON) test_audit2allow.py -v
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 audit2allow $(BINDIR)
-	(cd $(BINDIR); ln -sf audit2allow audit2why)
-	install -m 755 sepolgen-ifgen-attr-helper $(BINDIR)
-	install -m 755 sepolgen-ifgen $(BINDIR)
-	-mkdir -p $(MANDIR)/man1
-	install -m 644 audit2allow.1 $(MANDIR)/man1/
-	install -m 644 audit2why.1 $(MANDIR)/man1/
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 audit2allow $(DESTDIR)$(BINDIR)
+	(cd $(DESTDIR)$(BINDIR); ln -sf audit2allow audit2why)
+	install -m 755 sepolgen-ifgen-attr-helper $(DESTDIR)$(BINDIR)
+	install -m 755 sepolgen-ifgen $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man1
+	install -m 644 audit2allow.1 $(DESTDIR)$(MANDIR)/man1/
+	install -m 644 audit2why.1 $(DESTDIR)$(MANDIR)/man1/
 
 clean:
 	rm -f *~ *.o sepolgen-ifgen-attr-helper
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 0fd12d6d..290b9a6e 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -1,17 +1,16 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= $(PREFIX)/share/locale
 
 .PHONY: all
 all: chcat
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 chcat $(BINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 chcat.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 chcat $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 644 chcat.8 $(DESTDIR)$(MANDIR)/man8/
 
 clean:
 
diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 132162bc..a8465e62 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -1,13 +1,12 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
-PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PACKAGEDIR ?= $(PYTHONLIBDIR)
+BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
 TARGETS=semanage
 
@@ -16,14 +15,14 @@ BASHCOMPLETIONS=semanage-bash-completion.sh
 all: $(TARGETS)
 
 install: all
-	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
-	-mkdir -p $(SBINDIR)
-	install -m 755 semanage $(SBINDIR)
-	install -m 644 *.8 $(MANDIR)/man8
-	test -d $(PACKAGEDIR) || install -m 755 -d $(PACKAGEDIR)
-	install -m 755 seobject.py $(PACKAGEDIR)
-	-mkdir -p $(BASHCOMPLETIONDIR)
-	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/semanage
+	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 semanage $(DESTDIR)$(SBINDIR)
+	install -m 644 *.8 $(DESTDIR)$(MANDIR)/man8
+	test -d $(DESTDIR)/$(PACKAGEDIR) || install -m 755 -d $(DESTDIR)/$(PACKAGEDIR)
+	install -m 755 seobject.py $(DESTDIR)/$(PACKAGEDIR)
+	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
+	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/semanage
 
 test:
 	@$(PYTHON) test-semanage.py -a
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index d3aa7715..6d392f5d 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,12 +1,13 @@
+PREFIX ?= /usr
 PYTHON ?= python
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
-PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
 
 all:
 
 install: all
-	-mkdir -p $(PACKAGEDIR)
-	install -m 644 *.py $(PACKAGEDIR)
+	-mkdir -p $(DESTDIR)$(PACKAGEDIR)
+	install -m 644 *.py $(DESTDIR)$(PACKAGEDIR)
 
 clean:
 	rm -f parser.out parsetab.py
diff --git a/python/sepolgen/src/share/Makefile b/python/sepolgen/src/share/Makefile
index abf5e451..1a7133cb 100644
--- a/python/sepolgen/src/share/Makefile
+++ b/python/sepolgen/src/share/Makefile
@@ -1,10 +1,10 @@
-SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
+SHAREDIR ?= /var/lib/sepolgen
 
 all:
 
 install: all
-	-mkdir -p $(SHAREDIR)
-	install -m 644 perm_map $(SHAREDIR)
+	-mkdir -p $(DESTDIR)$(SHAREDIR)
+	install -m 644 perm_map $(DESTDIR)$(SHAREDIR)
 
 clean:
-	rm -f *~
\ No newline at end of file
+	rm -f *~
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 5a56e6c8..fb8a1325 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -1,14 +1,10 @@
 PYTHON ?= python
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
-DATADIR ?= $(PREFIX)/share
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
-BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
-SHAREDIR ?= $(PREFIX)/share/sandbox
+BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 CFLAGS ?= -Wall -Werror -Wextra -W
 override CFLAGS += -DPACKAGE="policycoreutils" -DSHARED -shared
 
@@ -30,13 +26,13 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
-	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
-	install -m 755 sepolicy.py $(BINDIR)/sepolicy
-	(cd $(BINDIR); ln -sf sepolicy sepolgen)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 *.8 $(MANDIR)/man8
-	-mkdir -p $(BASHCOMPLETIONDIR)
-	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/sepolicy
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
+	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 644 *.8 $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
+	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/sepolicy
 
 relabel:
-- 
2.15.1
