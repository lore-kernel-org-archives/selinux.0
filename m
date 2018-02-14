From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:04 +0100
Message-Id: <20180214095717.1050-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 02/15] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- The pkg-config files generates odd paths when using DESTDIR without PREFIX
- DESTDIR is needed during compile time to compute library and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    	-  Only use $(DESTDIR) in install
    v4:
    	- move platform from platform specific to platform shared installation directory
    	- Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined.
    
    v3:
    	- keep the possibility to specify LIBSEPOLA to
    	  make depending component recompile on change. If not specified, fall back to
    	  libsepola in LDFLAGS path.
    
    v2:
    	- Use separate directories for shared libraries as before( Comment from Stephen Smalley)
    	- Rework all packages (not just selinux/sepol/semanage)

 libselinux/include/Makefile     |  8 +++----
 libselinux/man/Makefile         | 19 ++++++++--------
 libselinux/src/Makefile         | 49 +++++++++++++++++++++++------------------
 libselinux/src/libselinux.pc.in |  2 +-
 libselinux/utils/Makefile       |  8 +++----
 5 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
index 757a6c9c..8ab9ce92 100644
--- a/libselinux/include/Makefile
+++ b/libselinux/include/Makefile
@@ -1,12 +1,12 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCDIR ?= $(PREFIX)/include/selinux
+PREFIX ?= /usr
+INCDIR = $(PREFIX)/include/selinux
 
 all:
 
 install: all
-	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
-	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
+	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
+	install -m 644 $(wildcard selinux/*.h) $(DESTDIR)$(INCDIR)
 
 relabel:
 
diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
index 0643e6af..f634d1fe 100644
--- a/libselinux/man/Makefile
+++ b/libselinux/man/Makefile
@@ -1,17 +1,18 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
+PREFIX	?= /usr
+MAN8DIR ?= $(PREFIX)/share/man/man8
+MAN5DIR ?= $(PREFIX)/share/man/man5
+MAN3DIR ?= $(PREFIX)/share/man/man3
 
 all:
 
 install: all
-	mkdir -p $(MAN3DIR)
-	mkdir -p $(MAN5DIR)
-	mkdir -p $(MAN8DIR)
-	install -m 644 man3/*.3 $(MAN3DIR)
-	install -m 644 man5/*.5 $(MAN5DIR)
-	install -m 644 man8/*.8 $(MAN8DIR)
+	mkdir -p $(DESTDIR)$(MAN3DIR)
+	mkdir -p $(DESTDIR)$(MAN5DIR)
+	mkdir -p $(DESTDIR)$(MAN8DIR)
+	install -m 644 man3/*.3 $(DESTDIR)$(MAN3DIR)
+	install -m 644 man5/*.5 $(DESTDIR)$(MAN5DIR)
+	install -m 644 man8/*.8 $(DESTDIR)$(MAN8DIR)
 
 relabel:
 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 18df75c8..18588da5 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -8,19 +8,17 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
+SHLIBDIR ?= /lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYSITEDIR ?= $(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
-RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-LIBBASE ?= $(shell basename $(LIBDIR))
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -50,6 +48,13 @@ LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
 AUDIT2WHYSO=$(PYPREFIX)audit2why.so
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
+
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
 SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
@@ -148,7 +153,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
@@ -157,7 +162,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
@@ -177,26 +182,26 @@ swigify: $(SWIGIF)
 	$(SWIG) $<
 
 install: all 
-	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
-	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
-	install -m 755 $(LIBSO) $(SHLIBDIR)
-	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
-	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
+	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
+	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
+	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	test -d $(PYSITEDIR)/selinux || install -m 755 -d $(PYSITEDIR)/selinux
-	install -m 755 $(SWIGSO) $(PYSITEDIR)/_selinux$(PYCEXT)
-	install -m 755 $(AUDIT2WHYSO) $(PYSITEDIR)/selinux/audit2why$(PYCEXT)
-	install -m 644 $(SWIGPYOUT) $(PYSITEDIR)/selinux/__init__.py
+	test -d $(DESTDIR)$(PYSITEDIR)/selinux || install -m 755 -d $(DESTDIR)$(PYSITEDIR)/selinux
+	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_selinux$(PYCEXT)
+	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYSITEDIR)/selinux/audit2why$(PYCEXT)
+	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYSITEDIR)/selinux/__init__.py
 
 install-rubywrap: rubywrap
-	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
-	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
+	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
+	install -m 755 $(SWIGRUBYSO) $(DESTDIR)$(RUBYINSTALL)/selinux.so
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 2e90a844..7c66b1fa 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/@libdir@
+libdir=@libdir@
 includedir=@includedir@
 
 Name: libselinux
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index eb4851a9..d06ffd66 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,8 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
-INCLUDEDIR ?= $(PREFIX)/include
 
 OS ?= $(shell uname)
 
@@ -63,8 +61,8 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 $(TARGETS) $(SBINDIR)
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
 
 clean:
 	rm -f $(TARGETS) *.o *~
-- 
2.15.1
