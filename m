Message-ID: <4AE0A8B7.7070009@tycho.nsa.gov>
Date: Thu, 22 Oct 2009 14:47:19 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Caleb Case <ccase@tresys.com>, srivasta@golden-gryphon.com,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH -v2] pkgconfig support for libsepol, libselinux, and libsemanage
References: <4ADE735D.9020901@tycho.nsa.gov>	 <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil> <1256128292.4061.174.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1256128292.4061.174.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add pkgconfig files for libsepol, libselinux, and libsemanage.

Having a pkgconfig file allows the pkg-config tool to be used to
query the presence of the library (or a particular version of it),
and to obtain the C flags and linker arguments to build with it.

Based on Debian patches by Manoj Srivastava <srivasta@debian.org>.

-v2: Corrected URL, fixed requirements for libselinux and libsemanage.


Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

Notes: Requires.private applies to static linking only, but it will
pull in CFLAGS from dependencies.  This is not very well documented.
My main source for information here is a bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=224148
http://wiki.mandriva.com/en/Overlinking

As far as I can tell, a shared library shouldn't have anything listed
in "Requires" or "Libs".  The only difference between Required.private
and Libs.private I can tell is that the former takes pkgconfig file
names as arguments and the latter actual -lfoo directives.


 .gitignore                        |    1 +
 libselinux/src/Makefile           |   11 +++++++++--
 libselinux/src/libselinux.pc.in   |   12 ++++++++++++
 libsemanage/src/Makefile          |   11 +++++++++--
 libsemanage/src/libsemanage.pc.in |   13 +++++++++++++
 libsepol/src/Makefile             |   12 ++++++++++--
 libsepol/src/libsepol.pc.in       |   11 +++++++++++
 7 files changed, 65 insertions(+), 6 deletions(-)
 create mode 100644 libselinux/src/libselinux.pc.in
 create mode 100644 libsemanage/src/libsemanage.pc.in
 create mode 100644 libsepol/src/libsepol.pc.in

diff --git a/.gitignore b/.gitignore
index c0e010f..9b7ed83 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 *.a
 *.s
 *.mo
+*.pc
 
 # Misc
 *.patch
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 74b1e6a..6623706 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -12,10 +12,12 @@ RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 
+VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
 LIBA=libselinux.a 
 TARGET=libselinux.so
+LIBPC=libselinux.pc
 SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
 SWIGRUBYIF= selinuxswig_ruby.i
 SWIGCOUT= selinuxswig_wrap.c
@@ -56,7 +58,7 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
-all: $(LIBA) $(LIBSO) 
+all: $(LIBA) $(LIBSO) $(LIBPC)
 
 pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
 
@@ -82,6 +84,9 @@ $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
+$(LIBPC): $(LIBPC).in
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	sh exception.sh > $@ 
 
@@ -111,6 +116,8 @@ install: all
 	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
+	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
@@ -127,7 +134,7 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~ 
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
 
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
new file mode 100644
index 0000000..9b3808b
--- /dev/null
+++ b/libselinux/src/libselinux.pc.in
@@ -0,0 +1,12 @@
+prefix=@prefix@
+exec_prefix=${prefix}
+libdir=${exec_prefix}/lib
+includedir=@includedir@
+
+Name: libselinux
+Description: SELinux utility library
+Version: @VERSION@
+URL: http://userspace.selinuxproject.org/
+Requires.private: libsepol
+Libs: -L${libdir} -lselinux
+Cflags: -I${includedir}
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index cfb9558..a249f0f 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -23,10 +23,12 @@ LFLAGS = -s
 YACC = bison
 YFLAGS = -d
 
+VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
 LIBA=libsemanage.a
 TARGET=libsemanage.so
+LIBPC=libsemanage.pc
 SWIGIF= semanageswig_python.i
 SWIGRUBYIF= semanageswig_ruby.i
 SWIGCOUT= semanageswig_wrap.c
@@ -53,7 +55,7 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(wildcard conf-*.[ch])
 
-all: $(LIBA) $(LIBSO) 
+all: $(LIBA) $(LIBSO) $(LIBPC)
 
 pywrap: all $(SWIGLOBJ) $(SWIGSO) 
 
@@ -79,6 +81,9 @@ $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
+$(LIBPC): $(LIBPC).in
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+
 conf-scan.c: conf-scan.l conf-parse.h
 	$(LEX) $(LFLAGS) -t $< > $@
 
@@ -119,6 +124,8 @@ install: all
 	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
+	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
@@ -134,7 +141,7 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c
+	rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c
 
 distclean: clean
 	rm -f $(SWIGCOUT) $(SWIGFILES)
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
new file mode 100644
index 0000000..d0945f8
--- /dev/null
+++ b/libsemanage/src/libsemanage.pc.in
@@ -0,0 +1,13 @@
+prefix=@prefix@
+exec_prefix=${prefix}
+libdir=${exec_prefix}/lib
+includedir=@includedir@
+
+Name: libsemanage
+Description: SELinux management library
+Version: @VERSION@
+URL: http://userspace.selinuxproject.org/
+Requires.private: libselinux libsepol ustr
+Libs: -L${libdir} -lsemanage
+Libs.private: -lbz2
+Cflags: -I${includedir}
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 608fe0b..3b19e37 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -1,19 +1,22 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
+INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 
+VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
 LIBA=libsepol.a 
 TARGET=libsepol.so
+LIBPC=libsepol.pc
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
-all: $(LIBA) $(LIBSO)
+all: $(LIBA) $(LIBSO) $(LIBPC)
 
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
@@ -23,6 +26,9 @@ $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs
 	ln -sf $@ $(TARGET) 
 
+$(LIBPC): $(LIBPC).in
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
 
@@ -34,13 +40,15 @@ install: all
 	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
+	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET)
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
new file mode 100644
index 0000000..bc7635c
--- /dev/null
+++ b/libsepol/src/libsepol.pc.in
@@ -0,0 +1,11 @@
+prefix=@prefix@
+exec_prefix=${prefix}
+libdir=${exec_prefix}/lib
+includedir=@includedir@
+
+Name: libsepol
+Description: SELinux policy library
+Version: @VERSION@
+URL: http://userspace.selinuxproject.org/
+Libs: -L${libdir} -lsepol
+Cflags: -I${includedir}
-- 
1.6.5.rc2



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
