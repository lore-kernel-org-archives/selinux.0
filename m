Message-ID: <1498074673.32258.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH] Use DESTDIR only in install targets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 21 Jun 2017 15:51:13 -0400
In-Reply-To: <20170621180402.8425-1-plautrba@redhat.com>
References: <20170620045529.GB22554@meriadoc.perfinion.com>
 <20170621180402.8425-1-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-06-21 at 20:04 +0200, Petr Lautrbach wrote:
> https://www.gnu.org/prep/standards/html_node/DESTDIR.html
> DESTDIR should be supported only in the install* and uninstall*
> targets, as those are the only targets where it is useful.

If you run make with DESTDIR= set before and after this change, and
compare both the output of make and the resulting directories, you'll
see there are some unexpected differences (I noted the ones I saw
below, but there may be more).

Also, as I note below, this does not fully remove all usage of DESTDIR
outside of install targets (I think it is reasonable to use it in
relabel targets too, but we're still using it elsewhere).

Lastly, there was trailing whitespace.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  checkpolicy/Makefile                     | 20 +++++++--------
>  checkpolicy/test/Makefile                |  6 ++---
>  gui/Makefile                             | 44 ++++++++++++++++----
> ------------
>  libselinux/include/Makefile              |  6 ++---
>  libselinux/src/Makefile                  | 38 +++++++++++++---------
> -----
>  libselinux/utils/Makefile                |  6 ++---
>  libsemanage/include/Makefile             |  6 ++---
>  libsemanage/src/Makefile                 | 32 +++++++++++-----------
> -
>  libsemanage/tests/Makefile               |  2 +-
>  libsemanage/utils/Makefile               |  6 ++---
>  libsepol/include/Makefile                | 14 +++++-----
>  libsepol/src/Makefile                    | 20 +++++++--------
>  libsepol/utils/Makefile                  |  6 ++---
>  mcstrans/man/Makefile                    |  6 ++---
>  mcstrans/src/Makefile                    | 22 ++++++++--------
>  mcstrans/utils/Makefile                  |  8 +++---
>  policycoreutils/hll/pp/Makefile          |  6 ++---
>  policycoreutils/load_policy/Makefile     | 14 +++++-----
>  policycoreutils/man/Makefile             |  6 ++---
>  policycoreutils/newrole/Makefile         | 22 ++++++++--------
>  policycoreutils/run_init/Makefile        | 20 +++++++--------
>  policycoreutils/scripts/Makefile         | 12 ++++-----
>  policycoreutils/secon/Makefile           | 10 ++++----
>  policycoreutils/semodule/Makefile        | 14 +++++-----
>  policycoreutils/sestatus/Makefile        | 20 +++++++--------
>  policycoreutils/setfiles/Makefile        | 22 ++++++++--------
>  policycoreutils/setsebool/Makefile       | 16 ++++++------
>  python/audit2allow/Makefile              | 20 +++++++--------
>  python/chcat/Makefile                    | 10 ++++----
>  python/semanage/Makefile                 | 22 ++++++++--------
>  python/sepolgen/src/sepolgen/Makefile    |  6 ++---
>  python/sepolgen/src/share/Makefile       |  8 +++---
>  python/sepolicy/Makefile                 | 18 ++++++-------
>  restorecond/Makefile                     | 44 ++++++++++++++++----
> ------------
>  sandbox/Makefile                         | 32 +++++++++++-----------
> -
>  secilc/Makefile                          | 14 +++++-----
>  semodule-utils/semodule_deps/Makefile    | 12 ++++-----
>  semodule-utils/semodule_expand/Makefile  | 10 ++++----
>  semodule-utils/semodule_link/Makefile    | 12 ++++-----
>  semodule-utils/semodule_package/Makefile | 14 +++++-----
>  40 files changed, 313 insertions(+), 313 deletions(-)
> 
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index 68e11f2a..e4f4fa19 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for building the checkpolicy program
>  #
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> @@ -26,9 +26,9 @@ GENERATED=lex.yy.c y.tab.c y.tab.h
>  all:  $(TARGETS)
>  	$(MAKE) -C test
>  
> -checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
> +checkpolicy: $(CHECKPOLOBJS) $(DESTDIR)$(LIBSEPOLA)

Hmm...seems like we're still using DESTDIR for more than just install.
So either the patch or the patch description isn't quite right.
The original usage of make DESTDIR in selinux was to support building
and installing to a private directory, so we wanted it to affect more
than just install.  If we truly make this transition to conform to the
GNU standards, then we still need a clean way of building and
installing to a private directory for local testing.  The top-level
Makefile has a workaround currently of automatically defining CFLAGS
and LDFLAGS when DESTDIR is defined, but that has a side effect: it
suppresses any non-override CFLAGS and LDFLAGS definitions in the
Makefiles, so then we no longer get all of the warning options enabled
in such local builds like we used to do.  All of this leaves me
wondering about whether we ought to just revert the earlier changes and
preserve our usage of DESTDIR, even if it doesn't correspond to GNU.

>  
> -checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
> +checkmodule: $(CHECKMODOBJS) $(DESTDIR)$(LIBSEPOLA)
>  
>  %.o: %.c 
>  	$(CC) $(CFLAGS) -o $@ -c $<
> @@ -46,15 +46,15 @@ lex.yy.c: policy_scan.l y.tab.c
>  	$(LEX) policy_scan.l
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 755 $(TARGETS) $(BINDIR)	
> -	install -m 644 checkpolicy.8 $(MANDIR)/man8
> -	install -m 644 checkmodule.8 $(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)	
> +	install -m 644 checkpolicy.8 $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 checkmodule.8 $(DESTDIR)$(MANDIR)/man8
>  
>  relabel: install
> -	/sbin/restorecon $(BINDIR)/checkpolicy
> -	/sbin/restorecon $(BINDIR)/checkmodule
> +	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkpolicy
> +	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
>  
>  clean:
>  	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c
> y.tab.h lex.yy.c
> diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
> index 59fa4460..c9a8d4c5 100644
> --- a/checkpolicy/test/Makefile
> +++ b/checkpolicy/test/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for building the dispol program
>  #
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
> @@ -11,9 +11,9 @@ CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
>  
>  all: dispol dismod
>  
> -dispol: dispol.o $(LIBSEPOLA)
> +dispol: dispol.o $(DESTDIR)$(LIBSEPOLA)
>  
> -dismod: dismod.o $(LIBSEPOLA)
> +dismod: dismod.o $(DESTDIR)$(LIBSEPOLA)

Ditto

>  
>  clean:
>  	-rm -f dispol dismod *.o 
> diff --git a/gui/Makefile b/gui/Makefile
> index 4fc2c1a1..52c3cab2 100644
> --- a/gui/Makefile
> +++ b/gui/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  SHAREDIR ?= $(PREFIX)/share/system-config-selinux
>  DATADIR ?= $(PREFIX)/share
> @@ -24,29 +24,29 @@ usersPage.py
>  all: $(TARGETS) system-config-selinux.py polgengui.py
>  
>  install: all
> -	-mkdir -p $(MANDIR)/man8
> -	-mkdir -p $(SHAREDIR)
> -	-mkdir -p $(BINDIR)
> -	-mkdir -p $(DATADIR)/pixmaps
> -	-mkdir -p $(DATADIR)/icons/hicolor/24x24/apps
> -	-mkdir -p $(DATADIR)/polkit-1/actions/
> -	install -m 755 system-config-selinux.py $(SHAREDIR)
> -	install -m 755 system-config-selinux $(BINDIR)
> -	install -m 755 polgengui.py $(SHAREDIR)
> -	install -m 644 $(TARGETS) $(SHAREDIR)
> -	install -m 644 system-config-selinux.8 $(MANDIR)/man8
> -	install -m 644 selinux-polgengui.8 $(MANDIR)/man8
> -	install -m 644 system-config-selinux.png $(DATADIR)/pixmaps
> -	install -m 644 system-config-selinux.png
> $(DATADIR)/icons/hicolor/24x24/apps
> -	install -m 644 system-config-selinux.png $(DATADIR)/system-
> config-selinux
> -	install -m 644 *.desktop $(DATADIR)/system-config-selinux

This one seems to have been dropped accidentally rather than augmented
with $(DESTDIR).

> -	-mkdir -p $(DESTDIR) $(DATADIR)/pixmaps
> -	install -m 644 sepolicy_256.png
> $(DATADIR)/pixmaps/sepolicy.png
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(SHAREDIR)
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
> +	-mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
> +	-mkdir -p $(DESTDIR)$(SYSCONFDIR)
> +	-mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
> +	install -m 755 system-config-selinux.py
> $(DESTDIR)$(SHAREDIR)
> +	install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
> +	install -m 755 polgengui.py $(DESTDIR)$(SHAREDIR)
> +	install -m 644 $(TARGETS) $(DESTDIR)$(SHAREDIR)
> +	install -m 644 system-config-selinux.8
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 selinux-polgengui.8 $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 system-config-selinux.png
> $(DESTDIR)$(DATADIR)/pixmaps
> +	install -m 644 system-config-selinux.png
> $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
> +	install -m 644 system-config-selinux.png
> $(DESTDIR)$(DATADIR)/system-config-selinux
> +	-mkdir -p $(DESTDIR) $(DESTDIR)$(DATADIR)/pixmaps
> +	install -m 644 sepolicy_256.png
> $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
>  	for i in 16 22 32 48 256; do \
> -		mkdir -p $(DESTDIR)
> $(DATADIR)/icons/hicolor/$${i}x$${i}/apps; \
> -		install -m 644 sepolicy_$${i}.png
> $(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
> +		mkdir -p
> $(DESTDIR)/$(DATADIR)/icons/hicolor/$${i}x$${i}/apps; \
> +		install -m 644 sepolicy_$${i}.png
> $(DESTDIR)$(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
>  	done
> -	install -m 644 org.selinux.config.policy $(DATADIR)/polkit-
> 1/actions/
> +	install -m 644 org.selinux.config.policy
> $(DESTDIR)$(DATADIR)/polkit-1/actions/
>  clean:
>  
>  indent:
> diff --git a/libselinux/include/Makefile
> b/libselinux/include/Makefile
> index 757a6c9c..c1d3fa15 100644
> --- a/libselinux/include/Makefile
> +++ b/libselinux/include/Makefile
> @@ -1,12 +1,12 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCDIR ?= $(PREFIX)/include/selinux
>  
>  all:
>  
>  install: all
> -	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
> -	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
> +	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d
> $(DESTDIR)$(INCDIR)
> +	install -m 644 $(wildcard selinux/*.h) $(DESTDIR)$(INCDIR)
>  
>  relabel:
>  
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 4306dd0e..6d65b682 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -8,17 +8,17 @@ RUBYPREFIX ?= $(notdir $(RUBY))
>  PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(DESTDIR)/lib
> +SHLIBDIR ?= /lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> -PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site;
> print(site.getsitepackages()[0])')
> +PYSITEDIR ?= $(shell $(PYTHON) -c 'import site;
> print(site.getsitepackages()[0])')
>  PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in
> imp.get_suffixes() if t == imp.C_EXTENSION][0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" +
> RbConfig::CONFIG["rubyarchhdrdir"] + " -I" +
> RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" +
> RbConfig::CONFIG["libdir"] + " -lruby"')
> -RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts
> RbConfig::CONFIG["vendorarchdir"]')
> +RUBYINSTALL ?= $(shell $(RUBY) -e 'puts
> RbConfig::CONFIG["vendorarchdir"]')
>  LIBBASE ?= $(shell basename $(LIBDIR))
>  LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>  
> @@ -156,7 +156,7 @@ selinuxswig_python_exception.i:
> ../include/selinux/selinux.h
>  $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC
> -DSHARED -c -o $@ $<
>  
> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(DESTDIR)$(LIBSEPOLA)
>  	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
> $(PYLIBS)

Here again with using DESTDIR outside of install.

>  
>  %.o:  %.c policy.h
> @@ -177,26 +177,26 @@ swigify: $(SWIGIF)
>  	$(SWIG) $<
>  
>  install: all 
> -	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
> -	install -m 644 $(LIBA) $(LIBDIR)
> -	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
> -	install -m 755 $(LIBSO) $(SHLIBDIR)
> -	test -d $(LIBDIR)/pkgconfig || install -m 755 -d
> $(LIBDIR)/pkgconfig
> -	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> -	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
> +	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d
> $(DESTDIR)$(LIBDIR)
> +	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> +	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d
> $(DESTDIR)$(SHLIBDIR)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> +	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d
> $(DESTDIR)$(LIBDIR)/pkgconfig
> +	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> $(DESTDIR)$(LIBDIR)/$(TARGET)
>  
>  install-pywrap: pywrap
> -	test -d $(PYSITEDIR)/selinux || install -m 755 -d
> $(PYSITEDIR)/selinux
> -	install -m 755 $(SWIGSO) $(PYSITEDIR)/_selinux$(PYCEXT)
> -	install -m 755 $(AUDIT2WHYSO)
> $(PYSITEDIR)/selinux/audit2why$(PYCEXT)
> -	install -m 644 $(SWIGPYOUT) $(PYSITEDIR)/selinux/__init__.py
> +	test -d $(DESTDIR)$(PYSITEDIR)/selinux || install -m 755 -d
> $(DESTDIR)$(PYSITEDIR)/selinux
> +	install -m 755 $(SWIGSO)
> $(DESTDIR)$(PYSITEDIR)/_selinux$(PYCEXT)
> +	install -m 755 $(AUDIT2WHYSO)
> $(DESTDIR)$(PYSITEDIR)/selinux/audit2why$(PYCEXT)
> +	install -m 644 $(SWIGPYOUT)
> $(DESTDIR)$(PYSITEDIR)/selinux/__init__.py
>  
>  install-rubywrap: rubywrap
> -	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
> -	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
> +	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d
> $(DESTDIR)$(RUBYINSTALL) 
> +	install -m 755 $(SWIGRUBYSO)
> $(DESTDIR)$(RUBYINSTALL)/selinux.so
>  
>  relabel:
> -	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
> +	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
>  
>  clean-pywrap:
>  	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 843b0e7c..882a6787 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(PREFIX)/sbin
>  INCLUDEDIR ?= $(PREFIX)/include
> @@ -63,8 +63,8 @@ sefcontext_compile: sefcontext_compile.o
> ../src/regex.o
>  all: $(TARGETS)
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 $(TARGETS) $(SBINDIR)
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
>  
>  clean:
>  	rm -f $(TARGETS) *.o *~
> diff --git a/libsemanage/include/Makefile
> b/libsemanage/include/Makefile
> index b660660e..6e44a28a 100644
> --- a/libsemanage/include/Makefile
> +++ b/libsemanage/include/Makefile
> @@ -1,12 +1,12 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCDIR ?= $(PREFIX)/include/semanage
>  
>  all:
>  
>  install: all
> -	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
> -	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
> +	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d
> $(DESTDIR)$(INCDIR)
> +	install -m 644 $(wildcard semanage/*.h) $(DESTDIR)$(INCDIR)
>  
>  indent:
>  	../../scripts/Lindent $(wildcard semanage/*.h)
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index f01385c5..8c0b4557 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -8,17 +8,17 @@ RUBYPREFIX ?= $(notdir $(RUBY))
>  PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(DESTDIR)/lib
> +SHLIBDIR ?= /lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> -PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site;
> print(site.getsitepackages()[0])')
> +PYSITEDIR ?= $(shell $(PYTHON) -c 'import site;
> print(site.getsitepackages()[0])')
>  PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in
> imp.get_suffixes() if t == imp.C_EXTENSION][0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" +
> RbConfig::CONFIG["rubyarchhdrdir"] + " -I" +
> RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" +
> RbConfig::CONFIG["libdir"] + " -lruby"')
> -RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts
> RbConfig::CONFIG["vendorarchdir"]')
> +RUBYINSTALL ?= $(shell $(RUBY) -e 'puts
> RbConfig::CONFIG["vendorarchdir"]')
>  
>  LIBBASE=$(shell basename $(LIBDIR))
>  
> @@ -136,26 +136,26 @@ swigify: $(SWIGIF)
>  	$(SWIG) $<
>  
>  install: all 
> -	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
> -	install -m 644 $(LIBA) $(LIBDIR)
> -	install -m 755 $(LIBSO) $(LIBDIR)
> -	test -d $(LIBDIR)/pkgconfig || install -m 755 -d
> $(LIBDIR)/pkgconfig
> -	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> +	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d
> $(DESTDIR)$(LIBDIR)
> +	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
> +	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d
> $(DESTDIR)$(LIBDIR)/pkgconfig
> +	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
>  	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644
> -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
> -	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
>  
>  install-pywrap: pywrap 
> -	test -d $(PYSITEDIR) || install -m 755 -d $(PYSITEDIR)
> -	install -m 755 $(SWIGSO) $(PYSITEDIR)/_semanage$(PYCEXT)
> -	install -m 644 semanage.py $(PYSITEDIR)
> +	test -d $(DESTDIR)$(PYSITEDIR) || install -m 755 -d
> $(DESTDIR)$(PYSITEDIR)
> +	install -m 755 $(SWIGSO)
> $(DESTDIR)$(PYSITEDIR)/_semanage$(PYCEXT)
> +	install -m 644 semanage.py $(DESTDIR)$(PYSITEDIR)
>  
>  
>  install-rubywrap: rubywrap
> -	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
> -	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
> +	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d
> $(DESTDIR)$(RUBYINSTALL) 
> +	install -m 755 $(SWIGRUBYSO)
> $(DESTDIR)$(RUBYINSTALL)/semanage.so
>  
>  relabel:
> -	/sbin/restorecon $(LIBDIR)/$(LIBSO)
> +	/sbin/restorecon $(DESTDIR)$(LIBDIR)/$(LIBSO)
>  
>  clean: 
>  	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO)
> $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-
> parse.h conf-scan.c *.o *.lo *~
> diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
> index 2ef8d30d..8103cf8f 100644
> --- a/libsemanage/tests/Makefile
> +++ b/libsemanage/tests/Makefile
> @@ -1,4 +1,4 @@
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
>  
>  # Add your test source files here:
> diff --git a/libsemanage/utils/Makefile b/libsemanage/utils/Makefile
> index 725f0eec..5b8fbb6b 100644
> --- a/libsemanage/utils/Makefile
> +++ b/libsemanage/utils/Makefile
> @@ -1,13 +1,13 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBEXECDIR ?= $(PREFIX)/libexec
>  SELINUXEXECDIR ?= $(LIBEXECDIR)/selinux/
>  
>  all:
>  
>  install: all
> -	-mkdir -p $(SELINUXEXECDIR)
> -	install -m 755 semanage_migrate_store $(SELINUXEXECDIR)
> +	-mkdir -p $(DESTDIR)$(SELINUXEXECDIR)
> +	install -m 755 semanage_migrate_store
> $(DESTDIR)$(SELINUXEXECDIR)
>  
>  clean:
>  
> diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
> index 56b7a114..49f817ce 100644
> --- a/libsepol/include/Makefile
> +++ b/libsepol/include/Makefile
> @@ -1,17 +1,17 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCDIR ?= $(PREFIX)/include/sepol
>  CILDIR ?= ../cil
>  
>  all:
>  
>  install: all
> -	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
> -	test -d $(INCDIR)/policydb || install -m 755 -d
> $(INCDIR)/policydb
> -	test -d $(INCDIR)/cil || install -m 755 -d $(INCDIR)/cil
> -	install -m 644 $(wildcard sepol/*.h) $(INCDIR)
> -	install -m 644 $(wildcard sepol/policydb/*.h)
> $(INCDIR)/policydb
> -	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h)
> $(INCDIR)/cil
> +	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d
> $(DESTDIR)$(INCDIR)
> +	test -d $(DESTDIR)$(INCDIR)/policydb || install -m 755 -d
> $(DESTDIR)$(INCDIR)/policydb
> +	test -d $(DESTDIR)$(INCDIR)/cil || install -m 755 -d
> $(DESTDIR)$(INCDIR)/cil
> +	install -m 644 $(wildcard sepol/*.h) $(DESTDIR)$(INCDIR)
> +	install -m 644 $(wildcard sepol/policydb/*.h)
> $(DESTDIR)$(INCDIR)/policydb
> +	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h)
> $(DESTDIR)$(INCDIR)/cil
>  
>  indent:
>  	../../scripts/Lindent $(wildcard sepol/*.h)
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 819d261b..4c7e23fa 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(DESTDIR)/lib
> +SHLIBDIR ?= $(PREFIX)/lib

This yields a change in the default install location for libsepol.so.1
(/lib -> /usr/lib).

>  RANLIB ?= ranlib
>  LIBBASE ?= $(shell basename $(LIBDIR))
>  CILDIR ?= ../cil
> @@ -80,16 +80,16 @@ endif
>  	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>  
>  install: all
> -	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
> -	install -m 644 $(LIBA) $(LIBDIR)
> -	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
> -	install -m 755 $(LIBSO) $(SHLIBDIR)
> -	test -d $(LIBDIR)/pkgconfig || install -m 755 -d
> $(LIBDIR)/pkgconfig
> -	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> -	$(LN) -sf --relative $(SHLIBDIR)/$(LIBSO)
> $(LIBDIR)/$(TARGET)
> +	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d
> $(DESTDIR)$(LIBDIR)
> +	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> +	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d
> $(DESTDIR)$(SHLIBDIR)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> +	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d
> $(DESTDIR)$(LIBDIR)/pkgconfig
> +	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +	$(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> $(DESTDIR)$(LIBDIR)/$(TARGET)
>  
>  relabel:
> -	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
> +	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
>  
>  clean: 
>  	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO)
> $(TARGET) $(CIL_GENERATED)
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index fba1d8a0..31932c11 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  
>  CFLAGS ?= -Wall -Werror
> @@ -12,8 +12,8 @@ TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  all: $(TARGETS)
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 $(TARGETS) $(BINDIR)
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)
>  
>  clean:
>  	-rm -f $(TARGETS) *.o 
> diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
> index 8e971192..dbd87f49 100644
> --- a/mcstrans/man/Makefile
> +++ b/mcstrans/man/Makefile
> @@ -1,11 +1,11 @@
>  # Installation directories.
> -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
> +MAN8DIR ?= /usr/share/man/man8
>  
>  all:
>  
>  install: all
> -	mkdir -p $(MAN8DIR)
> -	install -m 644 man8/*.8 $(MAN8DIR)
> +	mkdir -p $(DESTDIR)$(MAN8DIR)
> +	install -m 644 man8/*.8 $(DESTDIR)$(MAN8DIR)
>  
>  clean:
>  	-rm -f *~ \#*
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index 709e1e02..be54e349 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -1,9 +1,9 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
> -SBINDIR ?= $(DESTDIR)/sbin
> -INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
> -SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
> +SBINDIR ?= /sbin
> +INITDIR ?= /etc/rc.d/init.d
> +SYSTEMDDIR ?= /usr/lib/systemd
>  
>  PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
>  PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
> @@ -15,18 +15,18 @@ override CFLAGS += -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64
>  all: $(PROG)
>  
>  $(PROG): $(PROG_OBJS)
> -	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre
> $(LIBDIR)/libsepol.a
> +	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre
> $(DESTDIR)$(LIBDIR)/libsepol.a
>  
>  %.o:  %.c 
>  	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
>  
>  install: all
> -	test -d $(SBINDIR) || install -m 755 -d $(SBINDIR)
> -	install -m 755 $(PROG) $(SBINDIR)
> -	test -d $(INITDIR) || install -m 755 -d $(INITDIR)
> -	install -m 755 $(INITSCRIPT).init $(INITDIR)/$(INITSCRIPT)
> -	test -d $(SYSTEMDDIR)/system || install -m 755 -d
> $(SYSTEMDDIR)/system
> -	install -m 644 mcstrans.service $(SYSTEMDDIR)/system/
> +	test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d
> $(DESTDIR)$(SBINDIR)
> +	install -m 755 $(PROG) $(DESTDIR)$(SBINDIR)
> +	test -d $(DESTDIR)$(INITDIR) || install -m 755 -d
> $(DESTDIR)$(INITDIR)
> +	install -m 755 $(INITSCRIPT).init
> $(DESTDIR)$(INITDIR)/$(INITSCRIPT)
> +	test -d $(DESTDIR)$(SYSTEMDDIR)/system || install -m 755 -d
> $(DESTDIR)$(SYSTEMDDIR)/system
> +	install -m 644 mcstrans.service
> $(DESTDIR)$(SYSTEMDDIR)/system/
>  
>  clean: 
>  	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) *~
> \#*
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index 4d3cbfcb..1364cece 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(PREFIX)/sbin
>  LIBSEPOLA ?= $(LIBDIR)/libsepol.a
> @@ -12,11 +12,11 @@ TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  
>  all: $(TARGETS)
>  
> -$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
> +$(TARGETS): ../src/mcstrans.o ../src/mls_level.o
> $(DESTDIR)$(LIBSEPOLA)
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 $(TARGETS) $(SBINDIR)
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
>  
>  test:
>  	./mlstrans-test-runner.py ../test/*.test
> diff --git a/policycoreutils/hll/pp/Makefile
> b/policycoreutils/hll/pp/Makefile
> index 3401dcc9..ed70c449 100644
> --- a/policycoreutils/hll/pp/Makefile
> +++ b/policycoreutils/hll/pp/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> @@ -21,8 +21,8 @@ pp: $(PP_OBJS)
>  	$(CC) $(CFLAGS) -c -o $@ $^
>  
>  install: all
> -	-mkdir -p $(HLLDIR)
> -	install -m 755 pp $(HLLDIR)
> +	-mkdir -p $(DESTDIR)$(HLLDIR)
> +	install -m 755 pp $(DESTDIR)$(HLLDIR)
>  
>  relabel:
>  
> diff --git a/policycoreutils/load_policy/Makefile
> b/policycoreutils/load_policy/Makefile
> index b85833c2..00f59aba 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -1,6 +1,6 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -SBINDIR ?= $(DESTDIR)/sbin
> +PREFIX ?= /usr
> +SBINDIR ?= /sbin
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= /usr/share/locale
>  
> @@ -13,10 +13,10 @@ TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  all: $(TARGETS)
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 $(TARGETS) $(SBINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 load_policy.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 load_policy.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  clean:
>  	-rm -f $(TARGETS) *.o 
> @@ -25,4 +25,4 @@ indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
>  
>  relabel:
> -	/sbin/restorecon $(SBINDIR)/load_policy 
> +	/sbin/restorecon $(DESTDIR)$(SBINDIR)/load_policy 
> diff --git a/policycoreutils/man/Makefile
> b/policycoreutils/man/Makefile
> index 0d91cd46..ae3d27b6 100644
> --- a/policycoreutils/man/Makefile
> +++ b/policycoreutils/man/Makefile
> @@ -1,12 +1,12 @@
>  # Installation directories.
> -MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
> +MAN5DIR ?= /usr/share/man/man5
>  
>  all:
>  
>  clean:
>  
>  install: all
> -	mkdir -p $(MAN5DIR)
> -	install -m 644 man5/*.5 $(MAN5DIR)
> +	mkdir -p $(DESTDIR)$(MAN5DIR)
> +	install -m 644 man5/*.5 $(DESTDIR)$(MAN5DIR)
>  
>  relabel:
> diff --git a/policycoreutils/newrole/Makefile
> b/policycoreutils/newrole/Makefile
> index 196af926..e687b6ab 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> -ETCDIR ?= $(DESTDIR)/etc
> +ETCDIR ?= /etc
>  LOCALEDIR = /usr/share/locale
>  PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
>  AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
> @@ -61,17 +61,17 @@ newrole: newrole.o $(EXTRA_OBJS)
>  	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>  
>  install: all
> -	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)
> -	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
> -	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
> -	install -m $(MODE) newrole $(BINDIR)
> -	install -m 644 newrole.1 $(MANDIR)/man1/
> +	test -d $(DESTDIR)$(BINDIR)      || install -m 755 -d
> $(DESTDIR)$(BINDIR)
> +	test -d $(DESTDIR)$(ETCDIR)/pam.d || install -m 755 -d
> $(DESTDIR)$(ETCDIR)/pam.d
> +	test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man1
> +	install -m $(MODE) newrole $(DESTDIR)$(BINDIR)
> +	install -m 644 newrole.1 $(DESTDIR)$(MANDIR)/man1/
>  ifeq ($(PAMH), y)
> -	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
> +	test -d $(ETCDIR)/pam.d || install -m 755 -d
> $(DESTDIR)$(ETCDIR)/pam.d

Need to prefix the first $(ETCDIR)/pam.d with $(DESTDIR) too.

>  ifeq ($(LSPP_PRIV),y)
> -	install -m 644 newrole-lspp.pamd $(ETCDIR)/pam.d/newrole
> +	install -m 644 newrole-lspp.pamd
> $(DESTDIR)$(ETCDIR)/pam.d/newrole
>  else
> -	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
> +	install -m 644 newrole.pamd
> $(DESTDIR)$(ETCDIR)/pam.d/newrole
>  endif
>  endif
>  
> @@ -82,4 +82,4 @@ indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
>  
>  relabel: install
> -	/sbin/restorecon $(BINDIR)/newrole
> +	/sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
> diff --git a/policycoreutils/run_init/Makefile
> b/policycoreutils/run_init/Makefile
> index 921f0b07..8d8eb704 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -1,9 +1,9 @@
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> -ETCDIR ?= $(DESTDIR)/etc
> +ETCDIR ?= /etc
>  LOCALEDIR ?= /usr/share/locale
>  PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
>  AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
> @@ -32,14 +32,14 @@ open_init_pty: open_init_pty.c
>  
>  
>  install: all
> -	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 755 run_init $(SBINDIR)
> -	install -m 755 open_init_pty $(SBINDIR)
> -	install -m 644 run_init.8 $(MANDIR)/man8/
> -	install -m 644 open_init_pty.8 $(MANDIR)/man8/
> +	test -d $(DESTDIR)$(SBINDIR)      || install -m 755 -d
> $(DESTDIR)$(SBINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 755 run_init $(DESTDIR)$(SBINDIR)
> +	install -m 755 open_init_pty $(DESTDIR)$(SBINDIR)
> +	install -m 644 run_init.8 $(DESTDIR)$(MANDIR)/man8/
> +	install -m 644 open_init_pty.8 $(DESTDIR)$(MANDIR)/man8/
>  ifeq ($(PAMH), y)
> -	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
> +	install -m 644 run_init.pamd
> $(DESTDIR)$(ETCDIR)/pam.d/run_init
>  endif
>  
>  clean:
> @@ -49,4 +49,4 @@ indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
>  
>  relabel: install
> -	/sbin/restorecon $(SBINDIR)/run_init
> $(SBINDIR)/open_init_pty
> +	/sbin/restorecon $(DESTDIR)$(SBINDIR)/run_init
> $(DESTDIR)$(SBINDIR)/open_init_pty
> diff --git a/policycoreutils/scripts/Makefile
> b/policycoreutils/scripts/Makefile
> index d9e86ffe..a988144b 100644
> --- a/policycoreutils/scripts/Makefile
> +++ b/policycoreutils/scripts/Makefile
> @@ -1,6 +1,6 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -SBINDIR ?= $(DESTDIR)/sbin
> +PREFIX ?= /usr
> +SBINDIR ?= /sbin
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= $(PREFIX)/share/locale
>  
> @@ -8,10 +8,10 @@ LOCALEDIR ?= $(PREFIX)/share/locale
>  all: fixfiles
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 fixfiles $(SBINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 644 fixfiles.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 fixfiles $(DESTDIR)$(SBINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 fixfiles.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  clean:
>  
> diff --git a/policycoreutils/secon/Makefile
> b/policycoreutils/secon/Makefile
> index 8e491d74..c03f0d7d 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -1,5 +1,5 @@
>  # secon tool - command-line context
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> @@ -18,13 +18,13 @@ secon: secon.o
>  install-nogui: install
>  
>  install: all
> -	install -m 755 secon $(BINDIR);
> +	install -m 755 secon $(DESTDIR)$(BINDIR);
>  
> -	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
> -	install -m 644 secon.1 $(MANDIR)/man1
> +	test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man1
> +	install -m 644 secon.1 $(DESTDIR)$(MANDIR)/man1
>  
>  relabel:
> -	/sbin/restorecon $(BINDIR)/secon
> +	/sbin/restorecon $(DESTDIR)$(BINDIR)/secon
>  
>  clean:
>  	rm -f *.o core* secon *~ *.bak
> diff --git a/policycoreutils/semodule/Makefile
> b/policycoreutils/semodule/Makefile
> index fffb43ac..7c257bf5 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> @@ -17,12 +17,12 @@ genhomedircon:
>  	ln -sf semodule genhomedircon
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 semodule $(SBINDIR)
> -	(cd $(SBINDIR); ln -sf semodule genhomedircon)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 semodule.8 $(MANDIR)/man8/
> -	install -m 644 genhomedircon.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 semodule $(DESTDIR)$(SBINDIR)
> +	(cd $(DESTDIR)$(SBINDIR); ln -sf semodule genhomedircon)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 semodule.8 $(DESTDIR)$(MANDIR)/man8/
> +	install -m 644 genhomedircon.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  relabel:
>  
> diff --git a/policycoreutils/sestatus/Makefile
> b/policycoreutils/sestatus/Makefile
> index 41ca6832..130b764b 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -1,8 +1,8 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> -ETCDIR ?= $(DESTDIR)/etc
> +ETCDIR ?= /etc
>  LIBDIR ?= $(PREFIX)/lib
>  
>  CFLAGS ?= -Werror -Wall -W
> @@ -14,14 +14,14 @@ all: sestatus
>  sestatus: sestatus.o
>  
>  install: all
> -	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> -	[ -d $(MANDIR)/man5 ] || mkdir -p $(MANDIR)/man5
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 sestatus $(SBINDIR)
> -	install -m 644 sestatus.8 $(MANDIR)/man8
> -	install -m 644 sestatus.conf.5 $(MANDIR)/man5
> -	-mkdir -p $(ETCDIR)
> -	install -m 644 sestatus.conf $(ETCDIR)
> +	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p
> $(DESTDIR)$(MANDIR)/man8
> +	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p
> $(DESTDIR)$(MANDIR)/man5
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 sestatus $(DESTDIR)$(SBINDIR)
> +	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
> +	-mkdir -p $(DESTDIR)$(ETCDIR)
> +	install -m 644 sestatus.conf $(DESTDIR)$(ETCDIR)
>  
>  clean:
>  	rm -f sestatus *.o
> diff --git a/policycoreutils/setfiles/Makefile
> b/policycoreutils/setfiles/Makefile
> index c08e2dd1..4e56698f 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -1,6 +1,6 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -SBINDIR ?= $(DESTDIR)/sbin
> +PREFIX ?= /usr
> +SBINDIR ?= /sbin
>  MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
> @@ -29,14 +29,14 @@ man:
>  	@sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g"
> setfiles.8.man
>  
>  install: all
> -	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 setfiles $(SBINDIR)
> -	(cd $(SBINDIR) && ln -sf setfiles restorecon)
> -	install -m 755 restorecon_xattr $(SBINDIR)
> -	install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
> -	install -m 644 restorecon.8 $(MANDIR)/man8/restorecon.8
> -	install -m 644 restorecon_xattr.8
> $(MANDIR)/man8/restorecon_xattr.8
> +	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p
> $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 setfiles $(DESTDIR)$(SBINDIR)
> +	(cd $(DESTDIR)$(SBINDIR) && ln -sf setfiles restorecon)
> +	install -m 755 restorecon_xattr $(DESTDIR)$(SBINDIR)
> +	install -m 644 setfiles.8.man
> $(DESTDIR)$(MANDIR)/man8/setfiles.8
> +	install -m 644 restorecon.8
> $(DESTDIR)$(MANDIR)/man8/restorecon.8
> +	install -m 644 restorecon_xattr.8
> $(DESTDIR)$(MANDIR)/man8/restorecon_xattr.8
>  
>  clean:
>  	rm -f setfiles restorecon restorecon_xattr *.o
> setfiles.8.man
> @@ -45,4 +45,4 @@ indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
>  
>  relabel: install
> -	$(SBINDIR)/restorecon $(SBINDIR)/setfiles
> $(SBINDIR)/restorecon_xattr
> +	$(SBINDIR)/restorecon $(DESTDIR)$(SBINDIR)/setfiles
> $(DESTDIR)$(SBINDIR)/restorecon_xattr
> diff --git a/policycoreutils/setsebool/Makefile
> b/policycoreutils/setsebool/Makefile
> index bc254dab..f3379be9 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -1,10 +1,10 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
> completion/completions
> +BASHCOMPLETIONDIR ?= /usr/share/bash-completion/completions
>  
>  CFLAGS ?= -Werror -Wall -W
>  override LDLIBS += -lsepol -lselinux -lsemanage
> @@ -17,12 +17,12 @@ all: setsebool
>  setsebool: $(SETSEBOOL_OBJS)
>  
>  install: all
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 setsebool $(SBINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 644 setsebool.8 $(MANDIR)/man8/
> -	-mkdir -p $(BASHCOMPLETIONDIR)
> -	install -m 644 $(BASHCOMPLETIONS)
> $(BASHCOMPLETIONDIR)/setsebool
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 setsebool $(DESTDIR)$(SBINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 setsebool.8 $(DESTDIR)$(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
> +	install -m 644 $(BASHCOMPLETIONS)
> $(DESTDIR)$(BASHCOMPLETIONDIR)/setsebool
>  
>  relabel:
>  
> diff --git a/python/audit2allow/Makefile
> b/python/audit2allow/Makefile
> index 8db8075f..02526fa7 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -1,7 +1,7 @@
>  PYTHON ?= python
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
> @@ -13,7 +13,7 @@ CFLAGS ?= -Werror -Wall -W
>  
>  all: audit2why sepolgen-ifgen-attr-helper
>  
> -sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o
> $(LIBSEPOLA)
> +sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o
> $(DESTDIR)$(LIBSEPOLA)
>  
>  audit2why:
>  	ln -sf audit2allow audit2why
> @@ -22,14 +22,14 @@ test: all
>  	@$(PYTHON) test_audit2allow.py -v
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 audit2allow $(BINDIR)
> -	(cd $(BINDIR); ln -sf audit2allow audit2why)
> -	install -m 755 sepolgen-ifgen-attr-helper $(BINDIR)
> -	install -m 755 sepolgen-ifgen $(BINDIR)
> -	-mkdir -p $(MANDIR)/man1
> -	install -m 644 audit2allow.1 $(MANDIR)/man1/
> -	install -m 644 audit2why.1 $(MANDIR)/man1/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 audit2allow $(DESTDIR)$(BINDIR)
> +	(cd $(DESTDIR)$(BINDIR); ln -sf audit2allow audit2why)
> +	install -m 755 sepolgen-ifgen-attr-helper
> $(DESTDIR)$(BINDIR)
> +	install -m 755 sepolgen-ifgen $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man1
> +	install -m 644 audit2allow.1 $(DESTDIR)$(MANDIR)/man1/
> +	install -m 644 audit2why.1 $(DESTDIR)$(MANDIR)/man1/
>  
>  clean:
>  	rm -f *~ *.o sepolgen-ifgen-attr-helper
> diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> index 0fd12d6d..890033e2 100644
> --- a/python/chcat/Makefile
> +++ b/python/chcat/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= $(PREFIX)/share/locale
> @@ -8,10 +8,10 @@ LOCALEDIR ?= $(PREFIX)/share/locale
>  all: chcat
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 chcat $(BINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 644 chcat.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 chcat $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 chcat.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  clean:
>  
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index 60c36a3a..bd02e9e9 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -1,29 +1,29 @@
>  PYTHON ?= python
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
>  PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" %
> sys.version_info[0:2])')
>  PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
> -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
> completion/completions
> +BASHCOMPLETIONDIR ?= /usr/share/bash-completion/completions
>  
>  TARGETS=semanage
>  
> -BASHCOMPLETIONS=semanage-bash-completion.sh 
> +BASHCOMPLETIONS=semanage-bash-completion.sh
>  
>  all: $(TARGETS)
>  
>  install: all
> -	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 semanage $(SBINDIR)
> -	install -m 644 *.8 $(MANDIR)/man8
> -	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d
> $(PYTHONLIBDIR)/site-packages
> -	install -m 755 seobject.py $(PYTHONLIBDIR)/site-packages
> -	-mkdir -p $(BASHCOMPLETIONDIR)
> -	install -m 644 $(BASHCOMPLETIONS)
> $(BASHCOMPLETIONDIR)/semanage
> +	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p
> $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 semanage $(DESTDIR)$(SBINDIR)
> +	install -m 644 *.8 $(DESTDIR)$(MANDIR)/man8
> +	test -d $(DESTDIR)$(PYTHONLIBDIR)/site-packages || install
> -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)/site-packages
> +	install -m 755 seobject.py $(DESTDIR)$(PYTHONLIBDIR)/site-
> packages
> +	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
> +	install -m 644 $(BASHCOMPLETIONS)
> $(DESTDIR)$(BASHCOMPLETIONDIR)/semanage
>  
>  test:
>  	@$(PYTHON) test-semanage.py -a
> diff --git a/python/sepolgen/src/sepolgen/Makefile
> b/python/sepolgen/src/sepolgen/Makefile
> index d3aa7715..12ef0827 100644
> --- a/python/sepolgen/src/sepolgen/Makefile
> +++ b/python/sepolgen/src/sepolgen/Makefile
> @@ -1,12 +1,12 @@
>  PYTHON ?= python
>  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
> import *; print(get_python_lib(1))")
> -PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> +PACKAGEDIR ?= $(PYTHONLIBDIR)/sepolgen
>  
>  all:
>  
>  install: all
> -	-mkdir -p $(PACKAGEDIR)
> -	install -m 644 *.py $(PACKAGEDIR)
> +	-mkdir -p $(DESTDIR)$(PACKAGEDIR)
> +	install -m 644 *.py $(DESTDIR)$(PACKAGEDIR)
>  
>  clean:
>  	rm -f parser.out parsetab.py
> diff --git a/python/sepolgen/src/share/Makefile
> b/python/sepolgen/src/share/Makefile
> index abf5e451..1a7133cb 100644
> --- a/python/sepolgen/src/share/Makefile
> +++ b/python/sepolgen/src/share/Makefile
> @@ -1,10 +1,10 @@
> -SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
> +SHAREDIR ?= /var/lib/sepolgen
>  
>  all:
>  
>  install: all
> -	-mkdir -p $(SHAREDIR)
> -	install -m 644 perm_map $(SHAREDIR)
> +	-mkdir -p $(DESTDIR)$(SHAREDIR)
> +	install -m 644 perm_map $(DESTDIR)$(SHAREDIR)
>  
>  clean:
> -	rm -f *~
> \ No newline at end of file
> +	rm -f *~
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 5a56e6c8..c75dce73 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -1,13 +1,13 @@
>  PYTHON ?= python
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  LIBDIR ?= $(PREFIX)/lib
>  BINDIR ?= $(PREFIX)/bin
>  DATADIR ?= $(PREFIX)/share
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= /usr/share/locale
> -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
> completion/completions
> +BASHCOMPLETIONDIR ?= /usr/share/bash-completion/completions
>  SHAREDIR ?= $(PREFIX)/share/sandbox
>  CFLAGS ?= -Wall -Werror -Wextra -W
>  override CFLAGS += -DPACKAGE="policycoreutils" -DSHARED -shared
> @@ -31,12 +31,12 @@ test:
>  
>  install:
>  	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --
> root $(DESTDIR)`
> -	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
> -	install -m 755 sepolicy.py $(BINDIR)/sepolicy
> -	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 644 *.8 $(MANDIR)/man8
> -	-mkdir -p $(BASHCOMPLETIONDIR)
> -	install -m 644 $(BASHCOMPLETIONS)
> $(BASHCOMPLETIONDIR)/sepolicy
> +	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
> +	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 *.8 $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
> +	install -m 644 $(BASHCOMPLETIONS)
> $(DESTDIR)$(BASHCOMPLETIONDIR)/sepolicy
>  
>  relabel:
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index ada94aeb..a9a57b48 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -1,17 +1,17 @@
>  PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  LIBDIR ?= $(PREFIX)/lib
>  MANDIR = $(PREFIX)/share/man
> -AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
> -DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
> -SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
> +AUTOSTARTDIR = /etc/xdg/autostart
> +DBUSSERVICEDIR = /usr/share/dbus-1/services
> +SYSTEMDDIR ?= /usr/lib/systemd
>  
>  autostart_DATA = sealertauto.desktop
> -INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
> -SELINUXDIR = $(DESTDIR)/etc/selinux
> +INITDIR ?= /etc/rc.d/init.d
> +SELINUXDIR = /etc/selinux
>  
>  DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
>  DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
> @@ -39,23 +39,23 @@ restorecond:  restore.o restorecond.o
> utmpwatcher.o stringslist.o user.o watch.o
>  	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>  
>  install: all
> -	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 restorecond $(SBINDIR)
> -	install -m 644 restorecond.8 $(MANDIR)/man8
> -	-mkdir -p $(INITDIR)
> -	install -m 755 restorecond.init $(INITDIR)/restorecond
> -	-mkdir -p $(SELINUXDIR)
> -	install -m 644 restorecond.conf
> $(SELINUXDIR)/restorecond.conf
> -	install -m 644 restorecond_user.conf
> $(SELINUXDIR)/restorecond_user.conf
> -	-mkdir -p $(AUTOSTARTDIR)
> -	install -m 644 restorecond.desktop
> $(AUTOSTARTDIR)/restorecond.desktop
> -	-mkdir -p $(DBUSSERVICEDIR)
> -	install -m 600
> org.selinux.Restorecond.service  $(DBUSSERVICEDIR)/org.selinux.Restor
> econd.service
> -	-mkdir -p $(SYSTEMDDIR)/system
> -	install -m 644 restorecond.service $(SYSTEMDDIR)/system/
> +	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p
> $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 755 restorecond $(DESTDIR)$(SBINDIR)
> +	install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(INITDIR)
> +	install -m 755 restorecond.init
> $(DESTDIR)$(INITDIR)/restorecond
> +	-mkdir -p $(DESTDIR)$(SELINUXDIR)
> +	install -m 644 restorecond.conf
> $(DESTDIR)$(SELINUXDIR)/restorecond.conf
> +	install -m 644 restorecond_user.conf
> $(DESTDIR)$(SELINUXDIR)/restorecond_user.conf
> +	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
> +	install -m 644 restorecond.desktop
> $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
> +	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
> +	install -m 600
> org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.seli
> nux.Restorecond.service
> +	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
> +	install -m 644 restorecond.service
> $(DESTDIR)$(SYSTEMDDIR)/system/
>  relabel: install
> -	/sbin/restorecon $(SBINDIR)/restorecond 
> +	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond 
>  
>  clean:
>  	-rm -f restorecond *.o *~
> diff --git a/sandbox/Makefile b/sandbox/Makefile
> index 05c3d658..9c78041c 100644
> --- a/sandbox/Makefile
> +++ b/sandbox/Makefile
> @@ -1,8 +1,8 @@
>  PYTHON ?= python
>  
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
> +PREFIX ?= /usr
> +SYSCONFDIR ?= /etc/sysconfig
>  LIBDIR ?= $(PREFIX)/lib
>  BINDIR ?= $(PREFIX)/bin
>  SBINDIR ?= $(PREFIX)/sbin
> @@ -18,20 +18,20 @@ all: sandbox seunshare sandboxX.sh start
>  seunshare: $(SEUNSHARE_OBJS)
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 sandbox $(BINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 644 sandbox.8 $(MANDIR)/man8/
> -	install -m 644 seunshare.8 $(MANDIR)/man8/
> -	-mkdir -p $(MANDIR)/man5
> -	install -m 644 sandbox.5 $(MANDIR)/man5/
> -	-mkdir -p $(SBINDIR)
> -	install -m 4755 seunshare $(SBINDIR)/
> -	-mkdir -p $(SHAREDIR)
> -	install -m 755 sandboxX.sh $(SHAREDIR)
> -	install -m 755 start $(SHAREDIR)
> -	-mkdir -p $(SYSCONFDIR)
> -	install -m 644 sandbox.conf $(SYSCONFDIR)/sandbox
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 sandbox $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 sandbox.8 $(DESTDIR)$(MANDIR)/man8/
> +	install -m 644 seunshare.8 $(DESTDIR)$(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man5
> +	install -m 644 sandbox.5 $(DESTDIR)$(MANDIR)/man5/
> +	-mkdir -p $(DESTDIR)$(SBINDIR)
> +	install -m 4755 seunshare $(DESTDIR)$(SBINDIR)/
> +	-mkdir -p $(DESTDIR)$(SHAREDIR)
> +	install -m 755 sandboxX.sh $(DESTDIR)$(SHAREDIR)
> +	install -m 755 start $(DESTDIR)$(SHAREDIR)
> +	-mkdir -p $(DESTDIR)$(SYSCONFDIR)
> +	install -m 644 sandbox.conf $(DESTDIR)$(SYSCONFDIR)/sandbox
>  
>  test:
>  	@$(PYTHON) test_sandbox.py -v
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 1cac53e4..597b4a27 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -1,4 +1,4 @@
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> @@ -41,12 +41,12 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
>  	$(XMLTO) man $(SECIL2CONF_MANPAGE).xml
>  
>  install: all man
> -	-mkdir -p $(BINDIR)
> -	-mkdir -p $(MANDIR)/man8
> -	install -m 755 $(SECILC) $(BINDIR)
> -	install -m 755 $(SECIL2CONF) $(BINDIR)
> -	install -m 644 $(SECILC_MANPAGE) $(MANDIR)/man8
> -	install -m 644 $(SECIL2CONF_MANPAGE) $(MANDIR)/man8
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	-mkdir -p $(DESTDIR)$(MANDIR)/man8
> +	install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
> +	install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
> +	install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 $(SECIL2CONF_MANPAGE)
> $(DESTDIR)$(MANDIR)/man8
>  
>  doc:
>  	$(MAKE) -C docs
> diff --git a/semodule-utils/semodule_deps/Makefile b/semodule-
> utils/semodule_deps/Makefile
> index 328a5030..7b106781 100644
> --- a/semodule-utils/semodule_deps/Makefile
> +++ b/semodule-utils/semodule_deps/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
> @@ -10,13 +10,13 @@ CFLAGS ?= -Werror -Wall -W
>  
>  all: semodule_deps
>  
> -semodule_deps:  semodule_deps.o $(LIBSEPOLA)
> +semodule_deps:  semodule_deps.o $(DESTDIR)$(LIBSEPOLA)
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 semodule_deps $(BINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 semodule_deps.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 semodule_deps $(DESTDIR)$(BINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 semodule_deps.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  relabel:
>  
> diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-
> utils/semodule_expand/Makefile
> index 072f2137..58d2d3cb 100644
> --- a/semodule-utils/semodule_expand/Makefile
> +++ b/semodule-utils/semodule_expand/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
> @@ -13,10 +13,10 @@ all: semodule_expand
>  semodule_expand:  semodule_expand.o 
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 semodule_expand $(BINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 semodule_expand.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 semodule_expand $(DESTDIR)$(BINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 semodule_expand.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  relabel:
>  
> diff --git a/semodule-utils/semodule_link/Makefile b/semodule-
> utils/semodule_link/Makefile
> index cc4687bd..178bea30 100644
> --- a/semodule-utils/semodule_link/Makefile
> +++ b/semodule-utils/semodule_link/Makefile
> @@ -1,6 +1,6 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -INCLUDEDIR ?= $(PREFIX)/include
> +PREFIX ?= /usr
> +INCLUDEDIR ?= /include
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> @@ -13,10 +13,10 @@ all: semodule_link
>  semodule_link:  semodule_link.o 
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 semodule_link $(BINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 semodule_link.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 semodule_link $(DESTDIR)$(BINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(PREFIX)$(MANDIR)/man8

Missing $(DESTDIR) in the final install location above.

> +	install -m 644 semodule_link.8 $(DESTDIR)$(MANDIR)/man8/
>  
>  relabel:
>  
> diff --git a/semodule-utils/semodule_package/Makefile b/semodule-
> utils/semodule_package/Makefile
> index 96dd7c4f..37bd0d4b 100644
> --- a/semodule-utils/semodule_package/Makefile
> +++ b/semodule-utils/semodule_package/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> +PREFIX ?= /usr
>  INCLUDEDIR ?= $(PREFIX)/include
>  BINDIR ?= $(PREFIX)/bin
>  LIBDIR ?= $(PREFIX)/lib
> @@ -13,12 +13,12 @@ all: semodule_package semodule_unpackage
>  semodule_package:  semodule_package.o 
>  
>  install: all
> -	-mkdir -p $(BINDIR)
> -	install -m 755 semodule_package $(BINDIR)
> -	install -m 755 semodule_unpackage $(BINDIR)
> -	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
> -	install -m 644 semodule_package.8 $(MANDIR)/man8/
> -	install -m 644 semodule_unpackage.8 $(MANDIR)/man8/
> +	-mkdir -p $(DESTDIR)$(BINDIR)
> +	install -m 755 semodule_package $(DESTDIR)$(BINDIR)
> +	install -m 755 semodule_unpackage $(DESTDIR)$(BINDIR)
> +	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d
> $(DESTDIR)$(MANDIR)/man8
> +	install -m 644 semodule_package.8 $(DESTDIR)$(MANDIR)/man8/
> +	install -m 644 semodule_unpackage.8
> $(DESTDIR)$(MANDIR)/man8/
>  
>  relabel:
>  
