Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEKk4MI020346
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:46:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id 144so6671990pfv.0
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 12:46:03 -0800 (PST)
Date: Tue, 15 Nov 2016 04:46:00 +0800
From: Jason Zaman <jason@perfinion.com>
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: fix subdir build and usage of cmdline CFLAGS
Message-ID: <20161114204600.GB9733@meriadoc.perfinion.com>
References: <1479147126-11727-1-git-send-email-sds@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC561CD24A31@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD24A31@ORSMSX103.amr.corp.intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 14, 2016 at 06:31:09PM +0000, Roberts, William C wrote:
> 
> 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Monday, November 14, 2016 10:12 AM
> > To: selinux@tycho.nsa.gov
> > Cc: Roberts, William C <william.c.roberts@intel.com>; Stephen Smalley
> > <sds@tycho.nsa.gov>
> > Subject: [PATCH] libselinux: fix subdir build and usage of cmdline CFLAGS
> > 
> > commit 16c123f4b1f3c8d20b3f597df161d7e635620923 ("libselinux:
> > support ANDROID_HOST=1 on Mac") broke the ability to run make in the src
> > subdirectory of libselinux (because OS and COMPILER were not defined) and also
> > caused some warning flags that could be overridden via command-line CFLAGS to
> > be mandatory.  Fix it.
> 
> Ack.
> 
> It would be nice if we could avoid the duplication running repent throughout these make files,
> maybe include a file that has the definitions/callable functions for all of this stuff?

I just noticed some weirdness in a bunch of the makefiles too. Some of
the variables randomly default to different things depending on the
package. including a base makefile would be nice but the problem is when
packaged up they are separate tarballs.

We'd probably need to unify everything and duplicate it in each of the
subdirs and then the release script should diff them and make sure there
are no discrepancies before release.
> 
> > 
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  libselinux/src/Makefile   | 12 ++++++++++--
> >  libselinux/utils/Makefile | 10 +++++++++-
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile index
> > 24946ce..76efe49 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -23,6 +23,14 @@ LIBSEPOLA ?= $(LIBDIR)/libsepol.a  VERSION = $(shell cat
> > ../VERSION)  LIBVERSION = 1
> > 
> > +OS ?= $(shell uname)
> > +
> > +ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),) COMPILER ?= gcc else
> > +COMPILER ?= clang endif
> > +
> >  LIBA=libselinux.a
> >  TARGET=libselinux.so
> >  LIBPC=libselinux.pc
> > @@ -67,12 +75,12 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-
> > security -Winit-self -Wmissi  LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-
> > z,relro
> > 
> >  ifeq ($(COMPILER), gcc)
> > -override CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -
> > Wsync-nand \
> > +CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat
> > +-Wsync-nand \
> >  	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -
> > Wsuggest-attribute=const \
> >  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines
> > -Wjump-misses-init \
> >  	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-
> > D_FORTIFY_SOURCE=2  else -override CFLAGS += -Wunused-command-line-
> > argument
> > +CFLAGS += -Wunused-command-line-argument
> >  endif
> > 
> >  ifeq ($(OS), Darwin)
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> > a4f9903..7744184 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -5,6 +5,14 @@ USRBINDIR ?= $(PREFIX)/sbin  SBINDIR ?= $(DESTDIR)/sbin
> > INCLUDEDIR ?= $(PREFIX)/include
> > 
> > +OS ?= $(shell uname)
> > +
> > +ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),) COMPILER ?= gcc else
> > +COMPILER ?= clang endif
> > +
> >  MAX_STACK_SIZE=8192
> >  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -
> > Wmissing-include-dirs \
> >            -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-
> > arith \ @@ -26,7 +34,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -
> > Wformat-security -Winit-self -Wmissi  LD_SONAME_FLAGS=-soname,$(LIBSO),-
> > z,defs,-z,relro
> > 
> >  ifeq ($(COMPILER), gcc)
> > -override CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -
> > Wcoverage-mismatch \
> > +CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand
> > +-Wcoverage-mismatch \
> >  	-Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-
> > attribute=const \
> >  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines
> > -Wjump-misses-init \
> >  	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > --
> > 2.7.4
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
