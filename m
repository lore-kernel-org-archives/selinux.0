From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:05 +0100
Message-Id: <20180214095717.1050-4-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 03/15] libsemanage: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- DESTDIR is needed during compile time to compute library and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    		- Only use $(DESTDIR) in install
    v4:
            - Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined.
    
    v3:
            - keep the possibility to specify LIBSEPOLA to
              make depending component recompile on change. If not specified, fall back to
              libsepola in LDFLAGS path.
    
    v2:
            - Use separate directories for shared libraries as before( Comment from Stephen Smalley)
            - Rework all packages (not just selinux/sepol/semanage)
    
    v4:
            - Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined.
    
    v2:
            - Use separate directories for shared libraries as before( Comment from Stephen Smalley)
            - Rework all packages (not just selinux/sepol/semanage)

 libsemanage/include/Makefile      |  6 +++---
 libsemanage/man/Makefile          | 13 +++++++------
 libsemanage/src/Makefile          | 39 ++++++++++++++++++---------------------
 libsemanage/src/libsemanage.pc.in |  2 +-
 libsemanage/tests/Makefile        |  3 ---
 libsemanage/utils/Makefile        |  6 +++---
 6 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
index b660660e..6e44a28a 100644
--- a/libsemanage/include/Makefile
+++ b/libsemanage/include/Makefile
@@ -1,12 +1,12 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 INCDIR ?= $(PREFIX)/include/semanage
 
 all:
 
 install: all
-	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
-	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
+	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
+	install -m 644 $(wildcard semanage/*.h) $(DESTDIR)$(INCDIR)
 
 indent:
 	../../scripts/Lindent $(wildcard semanage/*.h)
diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
index 852043d4..8667c9b6 100644
--- a/libsemanage/man/Makefile
+++ b/libsemanage/man/Makefile
@@ -1,12 +1,13 @@
 # Installation directories.
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
+PREFIX ?= /usr
+MAN3DIR ?= $(PREFIX)/share/man/man3
+MAN5DIR ?= $(PREFIX)/share/man/man5
 
 all:
 
 install: all
-	mkdir -p $(MAN3DIR)
-	mkdir -p $(MAN5DIR)
-	install -m 644 man3/*.3 $(MAN3DIR)
-	install -m 644 man5/*.5 $(MAN5DIR)
+	mkdir -p $(DESTDIR)$(MAN3DIR)
+	mkdir -p $(DESTDIR)$(MAN5DIR)
+	install -m 644 man3/*.3 $(DESTDIR)$(MAN3DIR)
+	install -m 644 man5/*.5 $(DESTDIR)$(MAN5DIR)
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index fdb178f5..e98d8760 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -8,21 +8,18 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYSITEDIR ?= $(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
-RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
+RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
-LIBBASE=$(shell basename $(LIBDIR))
-
-DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
+DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
 	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
@@ -95,7 +92,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 semanageswig_python_exception.i: ../include/semanage/semanage.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
@@ -136,26 +133,26 @@ swigify: $(SWIGIF)
 	$(SWIG) $<
 
 install: all 
-	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
-	install -m 755 $(LIBSO) $(LIBDIR)
-	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
-	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
+	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
+	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+	test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
+	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
-	test -d $(PYSITEDIR) || install -m 755 -d $(PYSITEDIR)
-	install -m 755 $(SWIGSO) $(PYSITEDIR)/_semanage$(PYCEXT)
-	install -m 644 semanage.py $(PYSITEDIR)
+	test -d $(DESTDIR)$(PYSITEDIR) || install -m 755 -d $(DESTDIR)$(PYSITEDIR)
+	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_semanage$(PYCEXT)
+	install -m 644 semanage.py $(DESTDIR)$(PYSITEDIR)
 
 
 install-rubywrap: rubywrap
-	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
-	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
+	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
+	install -m 755 $(SWIGRUBYSO) $(DESTDIR)$(RUBYINSTALL)/semanage.so
 
 relabel:
-	/sbin/restorecon $(LIBDIR)/$(LIBSO)
+	/sbin/restorecon $(DESTDIR)$(LIBDIR)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index d3eaa062..43681ddb 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/@libdir@
+libdir=@libdir@
 includedir=@includedir@
 
 Name: libsemanage
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 2ef8d30d..324766a0 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -1,6 +1,3 @@
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-
 # Add your test source files here:
 SOURCES = $(sort $(wildcard *.c))
 
diff --git a/libsemanage/utils/Makefile b/libsemanage/utils/Makefile
index 725f0eec..5b8fbb6b 100644
--- a/libsemanage/utils/Makefile
+++ b/libsemanage/utils/Makefile
@@ -1,13 +1,13 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 LIBEXECDIR ?= $(PREFIX)/libexec
 SELINUXEXECDIR ?= $(LIBEXECDIR)/selinux/
 
 all:
 
 install: all
-	-mkdir -p $(SELINUXEXECDIR)
-	install -m 755 semanage_migrate_store $(SELINUXEXECDIR)
+	-mkdir -p $(DESTDIR)$(SELINUXEXECDIR)
+	install -m 755 semanage_migrate_store $(DESTDIR)$(SELINUXEXECDIR)
 
 clean:
 
-- 
2.15.1
