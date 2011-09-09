Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89HkRaa026765
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 13:46:27 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89HkPhl022270
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 17:46:26 GMT
Subject: Re: [PATCH] Fix include semanage/handle.h for semanage_set_root()
 as used by semodule
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Date: Fri, 09 Sep 2011 19:46:23 +0200
In-Reply-To: <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315590383.2170.32.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-09 at 13:31 -0400, Eric Paris wrote:
> I'm also really annoyed by this at times, but I don't know what the
> right answer is.

Well, as long as it is a git-only thing, perhaps a README file would do.

It could be improved too...

For example, load_policy does not honour LIBDIR or SHLIBDIR:

--- selinux-05092011/policycoreutils/load_policy/Makefile	2011-09-02
04:19:47.317716618 +0200
+++ selinux-05092011-fix-LIBDIR/policycoreutils/load_policy/Makefile
2011-09-09 19:44:23.710064117 +0200
@@ -3,11 +3,12 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(DESTDIR)/sbin
 USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= $(PREFIX)/usr/lib
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS
-DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
+LDLIBS += -lsepol -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 


> We really treat it like we have 5+ separate projects which just all
> happen to live in the same git tree.  Thus to build libselinux you
> must have already built and installed libsepol.  And then to build
> libsemanage you need to have done that with both libsepol and
> libselinux.  Then of course to get the builds and install right (on
> Fedora/RHEL) you have to know to use LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> for libsepol and libsepol, but SHLIBDIR=/usr/lib64 for libsemanage.
> Its a mess, but I don't know what to do that's better....
> 
> -Eric
> 
> On Fri, Sep 9, 2011 at 1:17 PM, Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > It only happens when building from git (because it uses the top-level
> > Makefile which is not being distributed with the released components).
> >
> > On Fri, 2011-09-09 at 19:01 +0200, Guido Trentalancia wrote:
> >> Hello,
> >>
> >> I am not able to build semodule from the current git unless the
> >> following patch is applied.
> >>
> >> Also, it would still be problematic if an outdated version of handle.h
> >> is getting picked up directly from the root include directory (as it
> >> happens now) and not from the local build directory... In other words,
> >> the Makefile and build system should be modified so that the local
> >> header files are picked up during each new build rather than the
> >> system-wide ones from previous installations.
> >>
> >> But at least this is a start:
> >>
> >> Include <semanage/handle.h> for semodule_set_root() currently used by semodule
> >>
> >> --- selinux-05092011/policycoreutils/semodule/semodule.c      2011-09-02 04:19:47.357716917 +0200
> >> +++ selinux-05092011-fix-semanage_set_root/policycoreutils/semodule/semodule.c        2011-09-09 18:41:24.078319022 +0200
> >> @@ -21,6 +21,7 @@
> >>  #include <sys/types.h>
> >>
> >>  #include <semanage/modules.h>
> >> +#include <semanage/handle.h>
> >>
> >>  enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, ENABLE_M, DISABLE_M, REMOVE_M,
> >>       LIST_M, RELOAD
> >>
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >> the words "unsubscribe selinux" without quotes as the message.
> >>
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
