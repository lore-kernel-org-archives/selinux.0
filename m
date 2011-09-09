Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89LJoSq005444
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 17:19:51 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89LJmvK009381
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 21:19:49 GMT
Subject: [RFC] Userspace top-level Makefile (was Re: [PATCH] Fix LIBDIR
 usage for load_policy)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Date: Fri, 09 Sep 2011 23:19:46 +0200
In-Reply-To: <1315591143.2170.36.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315603187.2482.22.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So either a top-level README file is introduced (to explictly recommend
to build the libraries first):

--- selinux-09092011-orig/README	1970-01-01 01:00:00.000000000 +0100
+++ selinux-09092011/README	2011-09-09 22:48:42.907857132 +0200
@@ -0,0 +1,21 @@
+INSTALLATION:
+
+First build and install the libraries (libsepol, libselinux and libsemanage) by typing
+"make" and then "make install" in each directory.
+
+Finally build and install the userspace tools (sepolgen, checkpolicy and policycoreutils) by
+typing "make" and then "make install" in each directory.
+
+---
+
+The environment variables CFLAGS and LDFLAGS can be passed to "make" to use custom compiler
+and/or linker flags (for example: CFLAGS="-fPIC -DSHARED" LDFLAGS="-ldl").
+
+The environment variables LIBDIR and SHLIBDIR can be passed to "make" in order to configure
+different directories for the libraries (e.g. LIBDIR=/usr/lib64 and SHLIBDIR=/usr/lib64
+on 64-bit systems).
+
+The environment variable PREFIX can be passed to "make" in order to configure an install
+prefix other than "/usr".
+
+Please see the Makefile(s) for other environment variables that can be used.

And/or a warning could be printed out by the top-level Makefile:

--- selinux-09092011-orig/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-09092011/Makefile	2011-09-09 22:57:12.481152804 +0200
@@ -1,4 +1,6 @@
-SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils # policy
+SUBDIRS_BIN=sepolgen checkpolicy policycoreutils
+SUBDIRS_LIB=libsepol libselinux libsemanage
+SUBDIRS=$(SUBDIRS_LIB) $(SUBDIRS_BIN)
 PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
@@ -11,6 +13,10 @@ all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
+	@echo
+	@echo -n "Do not forget to install the libraries ($(SUBDIRS_LIB))"
+	@echo " before trying to build the userspace tools ($(SUBDIRS_BIN))."
+	@echo
 
 install-pywrap swigify:
 	@for subdir in $(PYSUBDIRS); do \

Or the top-level Makefile could install the libraries automatically
(really awful as it is and NOT recommended, however on my system it
works fine with CFLAGS="-fPIC -DSHARED" and LDFLAGS="-ldl"):

--- selinux-09092011-orig/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-09092011/Makefile	2011-09-09 23:12:12.135859761 +0200
@@ -1,4 +1,5 @@
-SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils # policy
+SUBDIRS=libsepol libselinux libsemanage
+SUBDIRS_BIN=sepolgen checkpolicy policycoreutils # policy
 PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
@@ -7,9 +8,20 @@ ifeq ($(DEBUG),1)
 	export LDFLAGS = -g
 endif
 
-all install relabel clean test indent:
+all relabel test indent:
 	@for subdir in $(SUBDIRS); do \
-		(cd $$subdir && $(MAKE) $@) || exit 1; \
+		(cd $$subdir && $(MAKE) $@ && $(MAKE) install) || exit 1; \
+	done
+	@for subdir_bin in $(SUBDIRS_BIN); do \
+		(cd $$subdir_bin && $(MAKE) $@) || exit 1; \
+	done
+
+install:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) install) || exit 1; \
+	done
+	@for subdir_bin in $(SUBDIRS_BIN); do \
+		(cd $$subdir_bin && $(MAKE) install) || exit 1; \
 	done
 
 install-pywrap swigify:
@@ -17,6 +29,14 @@ install-pywrap swigify:
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 
+clean:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
+	@for subdir_bin in $(SUBDIRS_BIN); do \
+		(cd $$subdir_bin && $(MAKE) $@) || exit 1; \
+	done
+
 distclean:
 	@for subdir in $(DISTCLEANSUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \

The above methods are intended to make the build process (for the
userspace git version only) a little bit more user-friendly since the
tools might not build if the libraries are not already installed on the
system (because, for example, some header files from the libraries are
getting included from the system-wide include directory rather than from
the local build tree).

A previosly posted patch to honour the environment variable LIBDIR in
load_policy is also suggested (both for git and released versions).

Regards,

Guido

On Fri, 2011-09-09 at 19:59 +0200, Guido Trentalancia wrote:
> On Fri, 2011-09-09 at 19:46 +0200, Guido Trentalancia wrote:
> > On Fri, 2011-09-09 at 13:31 -0400, Eric Paris wrote:
> > > I'm also really annoyed by this at times, but I don't know what the
> > > right answer is.
> > 
> > Well, as long as it is a git-only thing, perhaps a README file would do.
> > 
> > It could be improved too...
> > 
> > For example, load_policy does not honour LIBDIR or SHLIBDIR:
> 
> It was in a broken format and now I've also changed the subject. The
> following one should be better:
> 
> --- selinux-05092011/policycoreutils/load_policy/Makefile	2011-09-02 04:19:47.317716618 +0200
> +++ selinux-05092011-fix-LIBDIR/policycoreutils/load_policy/Makefile	2011-09-09 19:44:23.710064117 +0200
> @@ -3,11 +3,12 @@ PREFIX ?= ${DESTDIR}/usr
>  SBINDIR ?= $(DESTDIR)/sbin
>  USRSBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> +LIBDIR ?= $(PREFIX)/usr/lib
>  LOCALEDIR ?= /usr/share/locale
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
> +LDLIBS += -lsepol -lselinux -L$(LIBDIR)
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>  
> 
> The top-level Makefile could be improved too perhaps...
> 
> > --- selinux-05092011/policycoreutils/load_policy/Makefile	2011-09-02
> > 04:19:47.317716618 +0200
> > +++ selinux-05092011-fix-LIBDIR/policycoreutils/load_policy/Makefile
> > 2011-09-09 19:44:23.710064117 +0200
> > @@ -3,11 +3,12 @@ PREFIX ?= ${DESTDIR}/usr
> >  SBINDIR ?= $(DESTDIR)/sbin
> >  USRSBINDIR ?= $(PREFIX)/sbin
> >  MANDIR ?= $(PREFIX)/share/man
> > +LIBDIR ?= $(PREFIX)/usr/lib
> >  LOCALEDIR ?= /usr/share/locale
> >  
> >  CFLAGS ?= -Werror -Wall -W
> >  override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS
> > -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> > -LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
> > +LDLIBS += -lsepol -lselinux -L$(LIBDIR)
> >  
> >  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> >  
> > 
> > 
> > > We really treat it like we have 5+ separate projects which just all
> > > happen to live in the same git tree.  Thus to build libselinux you
> > > must have already built and installed libsepol.  And then to build
> > > libsemanage you need to have done that with both libsepol and
> > > libselinux.  Then of course to get the builds and install right (on
> > > Fedora/RHEL) you have to know to use LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> > > for libsepol and libsepol, but SHLIBDIR=/usr/lib64 for libsemanage.
> > > Its a mess, but I don't know what to do that's better....
> > > 
> > > -Eric
> > > 
> > > On Fri, Sep 9, 2011 at 1:17 PM, Guido Trentalancia
> > > <guido@trentalancia.com> wrote:
> > > > It only happens when building from git (because it uses the top-level
> > > > Makefile which is not being distributed with the released components).
> > > >
> > > > On Fri, 2011-09-09 at 19:01 +0200, Guido Trentalancia wrote:
> > > >> Hello,
> > > >>
> > > >> I am not able to build semodule from the current git unless the
> > > >> following patch is applied.
> > > >>
> > > >> Also, it would still be problematic if an outdated version of handle.h
> > > >> is getting picked up directly from the root include directory (as it
> > > >> happens now) and not from the local build directory... In other words,
> > > >> the Makefile and build system should be modified so that the local
> > > >> header files are picked up during each new build rather than the
> > > >> system-wide ones from previous installations.
> > > >>
> > > >> But at least this is a start:
> > > >>
> > > >> Include <semanage/handle.h> for semodule_set_root() currently used by semodule
> > > >>
> > > >> --- selinux-05092011/policycoreutils/semodule/semodule.c      2011-09-02 04:19:47.357716917 +0200
> > > >> +++ selinux-05092011-fix-semanage_set_root/policycoreutils/semodule/semodule.c        2011-09-09 18:41:24.078319022 +0200
> > > >> @@ -21,6 +21,7 @@
> > > >>  #include <sys/types.h>
> > > >>
> > > >>  #include <semanage/modules.h>
> > > >> +#include <semanage/handle.h>
> > > >>
> > > >>  enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, ENABLE_M, DISABLE_M, REMOVE_M,
> > > >>       LIST_M, RELOAD
> > > >>
> > > >>
> > > >> --
> > > >> This message was distributed to subscribers of the selinux mailing list.
> > > >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > > >> the words "unsubscribe selinux" without quotes as the message.
> > > >>
> > > >
> > > >
> > > >
> > > > --
> > > > This message was distributed to subscribers of the selinux mailing list.
> > > > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > > > the words "unsubscribe selinux" without quotes as the message.
> > > >
> > > 
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
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
