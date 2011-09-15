Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8F9hbZU007824
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 05:43:37 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8F9hYQE008076
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 09:43:35 GMT
Subject: [PATCH] Fix symbolic link creation for the userspace libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eric Paris
	 <eparis@parisplace.org>
Date: Thu, 15 Sep 2011 11:40:39 +0200
In-Reply-To: <1316061658.23290.83.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost> <1315951507.2218.91.camel@vortex>
	 <1315956807.2218.98.camel@vortex> <1316028712.2738.34.camel@localhost>
	 <1316061658.23290.83.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316079639.24843.68.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

if you really want to use the modified shared library link creation,
then please use one amongst the two following patches, so that at least
it also gets rid of "cd" in favor of "pushd/popd":

- first version of the patch: single link creation in SHLIBDIR rather
than in LIBDIR (with the executable in SHLIBDIR);
- second version of the patch: double link creation (in SHLIBDIR and
also in LIBDIR with the executable in SHLIBDIR);

The first version of the patch might break the link creation for some
distributions (as Stephen predicted and as you confirmed, i.e. leads to
build failure on distributions that do not independently recreate the
symbolic link but rather rely on the original one being in LIBDIR).

The second version of the patch (creation of two links) should not
interfere with the build process from different vendors. At this point
this is the only version which is possibly recommended and in fact it is
the only one which is signed. It still needs testing before eventually
getting committed.

SINGLE (might interfere with the proper creation of a symbolic link in
distributed packages)

Not-signed - Not-recommended

diff -pruN selinux-orig/libselinux/src/Makefile selinux-fix-library-symlink-creation/libselinux/src/Makefile
--- selinux-orig/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-fix-library-symlink-creation/libselinux/src/Makefile	2011-09-15 10:23:09.476450309 +0200
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
diff -pruN selinux-orig/libsemanage/src/Makefile selinux-fix-library-symlink-creation/libsemanage/src/Makefile
--- selinux-orig/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-fix-library-symlink-creation/libsemanage/src/Makefile	2011-09-15 10:23:22.244545681 +0200
@@ -139,7 +139,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
diff -pruN selinux-orig/libsepol/src/Makefile selinux-fix-library-symlink-creation/libsepol/src/Makefile
--- selinux-orig/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-fix-library-symlink-creation/libsepol/src/Makefile	2011-09-15 10:23:35.519644366 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

DOUBLE (possibly recommended version)

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
--- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libselinux/src/Makefile	2011-09-15 10:51:50.720619457 +0200
@@ -126,7 +126,8 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
--- selinux/libsepol/src/Makefile	2011-09-09 20:12:56.021662468 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libsepol/src/Makefile	2011-09-15 10:52:23.139869859 +0200
@@ -43,7 +43,8 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
--- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
+++ selinux-14092011-fix-library-double-symlink-creation/libsemanage/src/Makefile	2011-09-15 10:53:01.131163131 +0200
@@ -139,7 +139,8 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	pushd $(LIBDIR) && ln -sf $(SHLIBDIR)/$(LIBSO) $(TARGET) && popd
+	pushd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET) && popd
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages

The second version is always recommended over the first (that's also why
it is the only one that is actually signed). It still needs further
testing.

Regards,

Guido

On Thu, 2011-09-15 at 06:40 +0200, Guido Trentalancia wrote:
> Hello Eric,
> 
> you are right about the signature and about conforming to the official
> patch style and guidelines. I just wanted to discuss things first.
> 
> There are still at least two issues that need to be further discussed:
> 
> - link creation to versioned shared libraries executables (directory
> SHLIBDIR versus LIBDIR and relative versus absolute linking so that it
> does not break distribution build scripts and resulting packages);
> - creation of individual released components getting broken because a
> few SELinux static libraries are now linked in from local sources
> instead of from existing system-wide versions.
> 
> I can sign and repost the whole thing, but I have now removed the diff
> relative to the symbolic link creation:
> 
> ***
> 
> This is a maintenance patch for further testing. It potentially replaces
> any other patch previously posted in this same and/or other recent
> threads.
> 
> Make sure that the SELinux userspace libraries and tools bundle from the
> git repository can be built from scratch without requiring existing
> SELinux installations (in particular header files) by exploiting the
> CURDIR variable (provided by the make tool itself) in the top-level
> Makefile only.
> 
> Create a top-level README file which is intended to provide a few
> details about some of the possible environment variables that can be
> configured and passed to the make tool.
> 
> Do not hard-code the path to semodule in the genhomedircon script but
> rather generate it each time by using PREFIX. Improve the manual page
> for genhomedircon.
> 
> Replace curly brackets with parentheses for some variables such as
> DESTDIR and PREFIX in the Makefiles. Add and make use of LIBDIR and
> INCLUDEDIR where appropriate within the Makefiles. Make use of PREFIX
> for determining the value of LOCALEDIR within some of the Makefiles. Do
> not override the environment variables passed from the command-line for
> some of the Makefiles.
> 
> Change the default target for *all* Makefiles (even the "hidden" ones)
> to "all" from "install", as we cannot install anything without the user
> *explicitly* requiring it.
> 
> This patch no longer tackles a possible installation issue (creation of
> symbolic links to shared libraries using a wrong target file and in a
> possibly wrong directory for libselinux, libsepol and libsemanage)
> because it needs further discussion/testing/acknowledgement.
> 
> Please note that this patch might break the creation of separate
> components distributables (i.e. released components) unless parts of
> this patch (i.e. linkage of the local version of some static libraries
> in certain executables) are reverted (for example by reverting a patch
> created for the purpose or by running sed). Use the make_release.sh
> script on a cloned tree before creating the released archives. The
> original behavior has been modified because otherwise it might create a
> really unwanted and even potentially dangerous sort of "cache" when
> building the whole userspace SELinux from top-level (a previously-built
> static library is used instead of the very latest one) .
> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> 
> ---
> diff -pruN selinux/checkpolicy/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/checkpolicy/Makefile
> --- selinux/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/checkpolicy/Makefile	2011-09-15 05:19:34.850414982 +0200
> @@ -19,7 +19,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
>  CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
>  CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
>  
> -LDLIBS=$(LIBDIR)/libsepol.a -lfl
> +LDLIBS=../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
>  
>  GENERATED=lex.yy.c y.tab.c y.tab.h
>  
> diff -pruN selinux/checkpolicy/test/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/checkpolicy/test/Makefile
> --- selinux/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/checkpolicy/test/Makefile	2011-09-15 05:19:34.850414982 +0200
> @@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>  CFLAGS ?= -g -Wall -O2 -pipe
>  override CFLAGS += -I$(INCLUDEDIR)
>  
> -LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
> +LDLIBS=-lsepol -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
>  
>  all: dispol dismod
>  
> diff -pruN selinux/libselinux/include/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/include/Makefile
> --- selinux/libselinux/include/Makefile	2011-09-09 20:12:55.981662183 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/include/Makefile	2011-09-15 05:21:20.957262156 +0200
> @@ -2,6 +2,8 @@
>  PREFIX ?= $(DESTDIR)/usr
>  INCDIR ?= $(PREFIX)/include/selinux
>  
> +all:
> +
>  install:
>  	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
>  	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
> diff -pruN selinux/libselinux/man/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile
> --- selinux/libselinux/man/Makefile	2011-09-09 20:12:55.982662190 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile	2011-09-15 05:21:20.959262094 +0200
> @@ -3,6 +3,8 @@ MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
>  MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
>  MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
>  
> +all:
> +
>  install:
>  	mkdir -p $(MAN3DIR)
>  	mkdir -p $(MAN5DIR)
> diff -pruN selinux/libselinux/src/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/src/Makefile
> --- selinux/libselinux/src/Makefile	2011-09-09 20:12:55.992662259 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/src/Makefile	2011-09-15 05:19:34.857415057 +0200
> @@ -102,7 +102,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
>  
>  %.o:  %.c policy.h
>  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff -pruN selinux/libsemanage/include/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/include/Makefile
> --- selinux/libsemanage/include/Makefile	2011-09-09 20:12:56.001662322 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/include/Makefile	2011-09-15 05:21:20.957262156 +0200
> @@ -2,6 +2,8 @@
>  PREFIX ?= $(DESTDIR)/usr
>  INCDIR ?= $(PREFIX)/include/semanage
>  
> +all:
> +
>  install:
>  	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
>  	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
> diff -pruN selinux/libsemanage/man/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/Makefile
> --- selinux/libsemanage/man/Makefile	2011-09-09 20:12:56.003662337 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/Makefile	2011-09-15 05:21:20.959262094 +0200
> @@ -1,6 +1,8 @@
>  # Installation directories.
>  MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
>  
> +all:
> +
>  install:
>  	mkdir -p $(MAN3DIR)
>  	install -m 644 man3/*.3 $(MAN3DIR)
> diff -pruN selinux/libsemanage/src/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/src/Makefile
> --- selinux/libsemanage/src/Makefile	2011-09-09 20:12:56.008662374 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/src/Makefile	2011-09-15 05:19:34.858415064 +0200
> @@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
>  	$(RANLIB) $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -L$(LIBDIR) -lbz2 -lustr -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
>  	ln -sf $@ $(TARGET)
>  
>  $(LIBPC): $(LIBPC).in
> diff -pruN selinux/libsepol/include/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/include/Makefile
> --- selinux/libsepol/include/Makefile	2011-09-09 20:12:56.018662447 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/include/Makefile	2011-09-15 05:21:20.957262156 +0200
> @@ -2,6 +2,8 @@
>  PREFIX ?= $(DESTDIR)/usr
>  INCDIR ?= $(PREFIX)/include/sepol
>  
> +all:
> +
>  install:
>  	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
>  	test -d $(INCDIR)/policydb || install -m 755 -d $(INCDIR)/policydb
> diff -pruN selinux/libsepol/man/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/man/Makefile
> --- selinux/libsepol/man/Makefile	2011-09-09 20:12:56.021662468 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/man/Makefile	2011-09-15 05:21:20.959262094 +0200
> @@ -2,6 +2,8 @@
>  MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
>  MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
>  
> +all:
> +
>  install:
>  	mkdir -p $(MAN3DIR)
>  	mkdir -p $(MAN8DIR)
> diff -pruN selinux/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/Makefile
> --- selinux/Makefile	2011-09-09 20:12:55.977662144 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/Makefile	2011-09-15 05:19:34.858415064 +0200
> @@ -3,10 +3,15 @@ PYSUBDIRS=libselinux libsemanage
>  DISTCLEANSUBIDRS=libselinux libsemanage
>  
>  ifeq ($(DEBUG),1)
> -	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
> -	export LDFLAGS = -g
> +	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
> +	LDFLAGS += -g
>  endif
>  
> +CFLAGS += -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsepol/include -I$(CURDIR)/libsemanage/include
> +LDFLAGS += -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsepol/src -L$(CURDIR)/libsemanage/src
> +export CFLAGS
> +export LDFLAGS
> +
>  all install relabel clean test indent:
>  	@for subdir in $(SUBDIRS); do \
>  		(cd $$subdir && $(MAKE) $@) || exit 1; \
> diff -pruN selinux/make_release.sh selinux-14092011-patch-v5-do-not-modify-library-link-creation/make_release.sh
> --- selinux/make_release.sh	1970-01-01 01:00:00.000000000 +0100
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/make_release.sh	2011-09-15 06:05:41.463331729 +0200
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +sed -i 's/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' libselinux/src/Makefile
> +sed -i 's/\.\.\/src\/libsemanage\.a/\-L\$(LIBDIR)\/libsemanage.a/g' libsemanage/tests/Makefile
> +sed -i 's/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' libsemanage/tests/Makefile
> +sed -i 's/\.\.\/\.\.\/libselinux\/src\/libselinux\.a/\-L\$(LIBDIR)\/libselinux\.a/g' libsemanage/tests/Makefile
> +sed -i 's/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' checkpolicy/Makefile
> +sed -i 's/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' checkpolicy/test/Makefile
> +sed -i 's/\.\.\/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' policycoreutils/mcstrans/utils/Makefile
> +sed -i 's/\.\.\/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' policycoreutils/mcstrans/src/Makefile
> +sed -i 's/\.\.\/\.\.\/libsepol\/src\/libsepol\.a/\-L\$(LIBDIR)\/libsepol\.a/g' policycoreutils/semodule_deps/Makefile
> diff -pruN selinux/policycoreutils/audit2allow/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/audit2allow/Makefile
> --- selinux/policycoreutils/audit2allow/Makefile	2011-09-09 20:12:56.034662561 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/audit2allow/Makefile	2011-09-15 05:19:34.858415064 +0200
> @@ -1,9 +1,9 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
> -LOCALEDIR ?= /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  
>  all: ;
>  
> diff -pruN selinux/policycoreutils/audit2why/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/audit2why/Makefile
> --- selinux/policycoreutils/audit2why/Makefile	2011-09-09 20:12:56.035662568 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/audit2why/Makefile	2011-09-15 05:19:34.858415064 +0200
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  
> diff -pruN selinux/policycoreutils/load_policy/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/load_policy/Makefile
> --- selinux/policycoreutils/load_policy/Makefile	2011-09-09 20:12:56.035662568 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/load_policy/Makefile	2011-09-15 05:19:34.859415071 +0200
> @@ -1,13 +1,15 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(DESTDIR)/sbin
>  USRSBINDIR ?= $(PREFIX)/sbin
> +INCLUDEDIR ?= $(PREFIX)/include
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
> -LOCALEDIR ?= /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  
>  CFLAGS ?= -Werror -Wall -W
> -override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
> +override CFLAGS += $(LDFLAGS) -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lsepol -lselinux -L$(LIBDIR)
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>  
> diff -pruN selinux/policycoreutils/mcstrans/man/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/man/Makefile
> --- selinux/policycoreutils/mcstrans/man/Makefile	2011-09-09 20:12:56.036662576 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/man/Makefile	2011-09-15 05:20:35.371897173 +0200
> @@ -1,6 +1,8 @@
>  # Installation directories.
>  MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
>  
> +all:
> +
>  install:
>  	mkdir -p $(MAN8DIR)
>  	install -m 644 man8/*.8 $(MAN8DIR)
> diff -pruN selinux/policycoreutils/mcstrans/src/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/src/Makefile
> --- selinux/policycoreutils/mcstrans/src/Makefile	2011-09-09 20:12:56.040662607 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/src/Makefile	2011-09-15 05:19:34.859415071 +0200
> @@ -28,7 +28,7 @@ override CFLAGS += -I../include -D_GNU_S
>  all: $(PROG)
>  
>  $(PROG): $(PROG_OBJS)
> -	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
> +	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux ../../../libsepol/src/libsepol.a -L$(LIBDIR) -lcap -lpcre
>  
>  %.o:  %.c 
>  	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
> diff -pruN selinux/policycoreutils/mcstrans/utils/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/utils/Makefile
> --- selinux/policycoreutils/mcstrans/utils/Makefile	2011-09-09 20:12:56.041662614 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/mcstrans/utils/Makefile	2011-09-15 05:19:34.859415071 +0200
> @@ -21,7 +21,7 @@ endif
>  
>  CFLAGS ?= -Wall
>  override CFLAGS += -I../src -D_GNU_SOURCE
> -LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
> +LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre ../../../libsepol/src/libsepol.a
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>  
> diff -pruN selinux/policycoreutils/newrole/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/newrole/Makefile
> --- selinux/policycoreutils/newrole/Makefile	2011-09-09 20:12:56.041662614 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/newrole/Makefile	2011-09-15 05:19:34.859415071 +0200
> @@ -1,9 +1,11 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> +INCLUDEDIR ?= $(PREFIX)/include
> +LIBDIR ?= $(PREFIX)/lib
>  ETCDIR ?= $(DESTDIR)/etc
> -LOCALEDIR = /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  # Enable capabilities to permit newrole to generate audit records.
> @@ -22,8 +24,8 @@ VERSION = $(shell cat ../VERSION)
>  
>  CFLAGS ?= -Werror -Wall -W
>  EXTRA_OBJS =
> -override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lselinux -L$(PREFIX)/lib
> +override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lselinux -L$(LIBDIR)
>  ifeq (${PAMH}, /usr/include/security/pam_appl.h)
>  	override CFLAGS += -DUSE_PAM
>  	EXTRA_OBJS += hashtab.o
> diff -pruN selinux/policycoreutils/restorecond/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/restorecond/Makefile
> --- selinux/policycoreutils/restorecond/Makefile	2011-09-09 20:12:56.072662837 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/restorecond/Makefile	2011-09-15 05:19:34.860415079 +0200
> @@ -1,13 +1,15 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(PREFIX)/sbin
> -MANDIR = $(PREFIX)/share/man
> -INITDIR = $(DESTDIR)/etc/rc.d/init.d
> -SELINUXDIR = $(DESTDIR)/etc/selinux
> +INCLUDEDIR ?= $(PREFIX)/include
> +LIBDIR ?= $(PREFIX)/lib
> +MANDIR ?= $(PREFIX)/share/man
> +INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
> +SELINUXDIR ?= $(DESTDIR)/etc/selinux
>  
>  CFLAGS ?= -g -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> -LDLIBS += -lselinux -L$(PREFIX)/lib
> +override CFLAGS += -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
> +LDLIBS += -lselinux -L$(LIBDIR)
>  
>  all: restorecond
>  
> diff -pruN selinux/policycoreutils/run_init/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/run_init/Makefile
> --- selinux/policycoreutils/run_init/Makefile	2011-09-09 20:12:56.072662837 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/run_init/Makefile	2011-09-15 05:19:34.860415079 +0200
> @@ -1,16 +1,17 @@
> -
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(PREFIX)/sbin
> +INCLUDEDIR ?= $(PREFIX)/include
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  ETCDIR ?= $(DESTDIR)/etc
> -LOCALEDIR ?= /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
>  CFLAGS ?= -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lselinux -L$(PREFIX)/lib
> +override CFLAGS += -I$(INCLUDEDIR) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lselinux -L$(LIBDIR)
>  ifeq (${PAMH}, /usr/include/security/pam_appl.h)
>  	override CFLAGS += -DUSE_PAM
>  	LDLIBS += -lpam -lpam_misc
> diff -pruN selinux/policycoreutils/sandbox/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/sandbox/Makefile
> --- selinux/policycoreutils/sandbox/Makefile	2011-09-09 20:12:56.073662844 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/sandbox/Makefile	2011-09-15 05:19:34.860415079 +0200
> @@ -1,14 +1,16 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> -INITDIR ?= ${DESTDIR}/etc/rc.d/init.d/
> -SYSCONFDIR ?= ${DESTDIR}/etc/sysconfig
> +PREFIX ?= $(DESTDIR)/usr
> +INITDIR ?= $(DESTDIR)/etc/rc.d/init.d/
> +SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
>  BINDIR ?= $(PREFIX)/bin
>  SBINDIR ?= $(PREFIX)/sbin
> +INCLUDEDIR ?= $(PREFIX)/include
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
> -LOCALEDIR ?= /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  SHAREDIR ?= $(PREFIX)/share/sandbox
> -override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lselinux -lcap-ng 
> +override CFLAGS += $(LDFLAGS) -I$(INCLUDEDIR) -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lselinux -L$(LIBDIR) -lcap-ng
>  
>  all: sandbox seunshare sandboxX.sh start
>  
> diff -pruN selinux/policycoreutils/scripts/genhomedircon.8 selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/scripts/genhomedircon.8
> --- selinux/policycoreutils/scripts/genhomedircon.8	2011-09-09 20:12:56.074662851 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/scripts/genhomedircon.8	2011-09-15 05:19:34.860415079 +0200
> @@ -1,37 +1,21 @@
> -.\" Hey, Emacs! This is an -*- nroff -*- source file.
> -.\" Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
> -.\"
> -.\" This is free documentation; you can redistribute it and/or
> -.\" modify it under the terms of the GNU General Public License as
> -.\" published by the Free Software Foundation; either version 2 of
> -.\" the License, or (at your option) any later version.
> -.\"
> -.\" The GNU General Public License's references to "object code"
> -.\" and "executables" are to be interpreted as the output of any
> -.\" document formatting or typesetting system, including
> -.\" intermediate and printed output.
> -.\"
> -.\" This manual is distributed in the hope that it will be useful,
> -.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> -.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -.\" GNU General Public License for more details.
> -.\"
> -.\" You should have received a copy of the GNU General Public
> -.\" License along with this manual; if not, write to the Free
> -.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
> -.\" USA.
> -.\"
> -.\"
> -.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
> +.TH GENHOMEDIRCON "8" "Sep 2011" "Security Enhanced Linux" "SELinux"
>  .SH NAME
>  genhomedircon \- generate SELinux file context configuration entries for user home directories
>  .SH SYNOPSIS
>  .B genhomedircon
> -is a script that executes semodule to rebuild policy and create the
> -labels for HOMEDIRS based on home directories returned by the getpw calls.
> +is a script that executes
> +.B semodule
> +to rebuild the SELinux policy and to create the
> +labels for each user home directory based on directory paths returned by calls to getpwent().
>  
> -This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
> +This functionality can be disabled by using the "usepasswd" flag in /etc/selinux/semanage.conf
> +(such flag can either take the value "true" or "false" and by default it is set to "true").
>  
>  .SH AUTHOR
>  This manual page was written by
>  .I Dan Walsh <dwalsh@redhat.com>
> +
> +The supporting functionality in the semanage library was written by Tresys Technology.
> +
> +.SH "SEE ALSO"
> +semodule(8), getpwent(3), getpwent_r(3)
> diff -pruN selinux/policycoreutils/scripts/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/scripts/Makefile
> --- selinux/policycoreutils/scripts/Makefile	2011-09-09 20:12:56.074662851 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/scripts/Makefile	2011-09-15 05:19:34.861415088 +0200
> @@ -1,9 +1,9 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> -LOCALEDIR ?= /usr/share/locale
> +LOCALEDIR ?= $(PREFIX)/share/locale
>  
>  all: fixfiles genhomedircon chcat
>  
> @@ -11,7 +11,10 @@ install: all
>  	-mkdir -p $(BINDIR)
>  	install -m 755 chcat $(BINDIR)
>  	install -m 755 fixfiles $(DESTDIR)/sbin
> -	install -m 755 genhomedircon  $(SBINDIR)
> +	@echo "#!/bin/sh" > genhomedircon
> +	@echo >> genhomedircon
> +	@echo "$(SBINDIR)/semodule -Bn" >> genhomedircon
> +	install -m 755 genhomedircon $(SBINDIR)
>  	-mkdir -p $(MANDIR)/man8
>  	install -m 644 fixfiles.8 $(MANDIR)/man8/
>  	install -m 644 genhomedircon.8 $(MANDIR)/man8/
> diff -pruN selinux/policycoreutils/secon/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/secon/Makefile
> --- selinux/policycoreutils/secon/Makefile	2011-09-09 20:12:56.075662858 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/secon/Makefile	2011-09-15 05:19:34.861415088 +0200
> @@ -1,9 +1,9 @@
>  # secon tool - command-line context
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  
>  WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
>  VERSION = $(shell cat ../VERSION)
> diff -pruN selinux/policycoreutils/semanage/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semanage/Makefile
> --- selinux/policycoreutils/semanage/Makefile	2011-09-09 20:12:56.075662858 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semanage/Makefile	2011-09-15 05:19:34.861415088 +0200
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(PREFIX)/sbin
> -MANDIR = $(PREFIX)/share/man
> +MANDIR ?= $(PREFIX)/share/man
>  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
>  PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
>  
> diff -pruN selinux/policycoreutils/semodule/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule/Makefile
> --- selinux/policycoreutils/semodule/Makefile	2011-09-09 20:12:56.076662865 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule/Makefile	2011-09-15 05:19:34.862415096 +0200
> @@ -2,8 +2,8 @@
>  PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  SBINDIR ?= $(PREFIX)/sbin
> -MANDIR = $(PREFIX)/share/man
> -LIBDIR ?= ${PREFIX}/lib
> +MANDIR ?= $(PREFIX)/share/man
> +LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> diff -pruN selinux/policycoreutils/semodule_deps/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_deps/Makefile
> --- selinux/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_deps/Makefile	2011-09-15 05:19:34.862415096 +0200
> @@ -1,13 +1,13 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> -LDLIBS = $(LIBDIR)/libsepol.a
> +LDLIBS = ../../libsepol/src/libsepol.a
>  
>  all: semodule_deps
>  
> diff -pruN selinux/policycoreutils/semodule_expand/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_expand/Makefile
> --- selinux/policycoreutils/semodule_expand/Makefile	2011-09-09 20:12:56.077662873 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_expand/Makefile	2011-09-15 05:19:34.862415096 +0200
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
> diff -pruN selinux/policycoreutils/semodule_link/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_link/Makefile
> --- selinux/policycoreutils/semodule_link/Makefile	2011-09-09 20:12:56.077662873 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_link/Makefile	2011-09-15 05:19:34.862415096 +0200
> @@ -1,9 +1,9 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> diff -pruN selinux/policycoreutils/semodule_package/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_package/Makefile
> --- selinux/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/semodule_package/Makefile	2011-09-15 05:19:34.863415104 +0200
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
> diff -pruN selinux/policycoreutils/sestatus/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/sestatus/Makefile
> --- selinux/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/sestatus/Makefile	2011-09-15 05:19:34.863415104 +0200
> @@ -1,12 +1,13 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(PREFIX)/sbin
> -MANDIR = $(PREFIX)/share/man
> +INCLUDEDIR ?= $(PREFIX)/include
> +MANDIR ?= $(PREFIX)/share/man
>  ETCDIR ?= $(DESTDIR)/etc
> -LIBDIR ?= ${PREFIX}/lib
> +LIBDIR ?= $(PREFIX)/lib
>  
> -CFLAGS = -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> +CFLAGS ?= -Werror -Wall -W
> +override CFLAGS += -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64
>  LDLIBS = -lselinux -L$(LIBDIR)
>  
>  all: sestatus
> diff -pruN selinux/policycoreutils/setfiles/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/setfiles/Makefile
> --- selinux/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/setfiles/Makefile	2011-09-15 05:19:34.863415104 +0200
> @@ -1,12 +1,13 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(DESTDIR)/sbin
> -MANDIR = $(PREFIX)/share/man
> +INCLUDEDIR ?= $(PREFIX)/include
> +MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
> -CFLAGS = -g -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include
> +CFLAGS ?= -g -Werror -Wall -W
> +override CFLAGS += -I$(INCLUDEDIR)
>  LDLIBS = -lselinux -lsepol -L$(LIBDIR)
>  
>  ifeq (${AUDITH}, /usr/include/libaudit.h)
> diff -pruN selinux/policycoreutils/setsebool/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/setsebool/Makefile
> --- selinux/policycoreutils/setsebool/Makefile	2011-09-09 20:12:56.078662881 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/policycoreutils/setsebool/Makefile	2011-09-15 05:19:34.863415104 +0200
> @@ -2,8 +2,8 @@
>  PREFIX ?= $(DESTDIR)/usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  SBINDIR ?= $(PREFIX)/sbin
> -MANDIR = $(PREFIX)/share/man
> -LIBDIR ?= ${PREFIX}/lib
> +MANDIR ?= $(PREFIX)/share/man
> +LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> diff -pruN selinux/README selinux-14092011-patch-v5-do-not-modify-library-link-creation/README
> --- selinux/README	1970-01-01 01:00:00.000000000 +0100
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/README	2011-09-15 05:19:34.864415112 +0200
> @@ -0,0 +1,20 @@
> +INSTALLATION:
> +
> +Type "make" to build and then "make install" to install.
> +
> +---
> +
> +The environment variables CFLAGS and LDFLAGS can be passed to "make" to use custom compiler
> +and/or linker flags (for example: CFLAGS="-O3" LDFLAGS="" make).
> +
> +The environment variables LIBDIR and SHLIBDIR can be passed to "make" in order to configure
> +different directories for the libraries (e.g. LIBDIR=/usr/lib64 and SHLIBDIR=/usr/lib64
> +on 64-bit systems).
> +
> +The environment variable PREFIX can be passed to "make" in order to configure an install
> +prefix other than "/usr".
> +
> +The environment variable DESTDIR can be passed to "make" in order to configure a
> +specific directory to be used as the root installation directory.
> +
> +Please see the Makefile(s) for other environment variables that can be used.
> diff -pruN selinux/sepolgen/src/sepolgen/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/sepolgen/src/sepolgen/Makefile
> --- selinux/sepolgen/src/sepolgen/Makefile	2011-09-09 20:12:56.080662897 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/sepolgen/src/sepolgen/Makefile	2011-09-15 05:20:22.403798789 +0200
> @@ -1,7 +1,9 @@
>  PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
>  PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
>  
> -install:
> +all:
> +
> +install: all
>  	-mkdir -p $(PACKAGEDIR)
>  	install -m 644 *.py $(PACKAGEDIR)
>  
> diff -pruN selinux/sepolgen/src/share/Makefile selinux-14092011-patch-v5-do-not-modify-library-link-creation/sepolgen/src/share/Makefile
> --- selinux/sepolgen/src/share/Makefile	2011-09-09 20:12:56.082662911 +0200
> +++ selinux-14092011-patch-v5-do-not-modify-library-link-creation/sepolgen/src/share/Makefile	2011-09-15 05:20:22.404798727 +0200
> @@ -1,6 +1,8 @@
>  SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
>  
> -install:
> +all:
> +
> +install: all
>  	-mkdir -p $(SHAREDIR)
>  	install -m 644 perm_map $(SHAREDIR)
>  
> After the above patch, other patches are pending: semanage.conf manual
> page (might no longer apply cleanly), libsemanage test fix function's
> arguments.
> 
> Regards,
> 
> Guido
> 
> On Wed, 2011-09-14 at 15:31 -0400, Eric Paris wrote:
> > On Wed, 2011-09-14 at 01:33 +0200, Guido Trentalancia wrote:
> > > Another possible improvement could be as follows (libsemanag):
> > > 
> > > Fix a few calls to semanage_store_access_check() in the libsemanage
> > > tests so that a void function is called.
> > 
> > Please in the future include a line which looks something like the
> > following at the end of the comments with all patches you wish to have
> > committed:
> > 
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> > 
> > The purpose of this line is to indicate that you have the rights to
> > contribute this code to the project and that you agree to license the
> > code according to the license(s) of the file(s) that the patch will be
> > applied to.
> > 
> > I prefer patches in the format like the linux kernel: 
> > https://github.com/torvalds/linux/blob/master/Documentation/SubmittingPatches
> > 
> > Basically that entails the subject line of the e-mail is the short
> > description of the patch (nothing extra except inside the [])
> > 
> > The body should be a complete description of what change you made and in
> > particular why.  You should mention testing and things like that as
> > well.
> > 
> > The signed-off-by line.
> > The last line of the changelog should be just --- (at the beginning of
> > the line)
> > 
> > After the --- line include the patch.
> > 
> > thanks so much!
> > 
> > -Eric
> > 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
