Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KFTvRu008832
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 11:29:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so22105867pgc.2
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 08:29:44 -0700 (PDT)
Date: Tue, 20 Jun 2017 23:29:34 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Patrick Steinhardt <ps@pks.im>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] libselinux: fix error when FORTIFY_SOURCE is already
 set
Message-ID: <20170620152934.GA19906@meriadoc.perfinion.com>
References: <cover.1497967444.git.ps@pks.im>
 <8e3ba217e8ac1d93dc438e8ce08ae8557eb94e8f.1497967444.git.ps@pks.im>
 <1497971673.12069.7.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1497971673.12069.7.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 20, 2017 at 11:14:33AM -0400, Stephen Smalley wrote:
> On Tue, 2017-06-20 at 16:07 +0200, Patrick Steinhardt wrote:
> > Two makefiles of ours pass `-D_FORTIFY_SOURCE` directly to the
> > preprocessor. While this does not pose any problems when the value
> > has
> > not been previously set, it can break the build if it is part of the
> > standard build flags.
> > 
> > Fix the issue by undefining the flag with `-Wp,-U_FORTIFY_SOURCE`
> > right
> > before redefining the value. This fixes builds with some hardened
> > compiler chains.
> 
> I don't quite understand why the caller can't just specify their own
> CFLAGS, in which case we won't use the ones in libselinux/src/Makefile
> (except for the override CFLAGS, which don't include the FORTIFY
> options), ala:
> # We turn up security all the way to 11!
> make CFLAGS="-O -Wp,-D_FORTIFY_SOURCE=11"
> 
> The problem I see with your solution is that it means that if your
> hardened toolchain wants to select a higher _FORTIFY_SOURCE value in
> the future (if such a thing were to exist), we'll just undefine it and
> redefine to the lower value in our Makefiles.  If you can't just set
> CFLAGS in the caller, then perhaps the libselinux Makefile should only
> add FORTIFY options if they aren't already defined.

He said this is on gentoo in which case portage will pretty much always
have CFLAGS set so this is never a problem.

Its only a problem for me if i build manually outside of portage in. I
normally just sed'd out the fortify bit. But i'd agree with the best way
would be to test it, something like cc-option from the kernel
CFLAGS ?= $(call cc-option -Werror -Wl,-D_FORTIFY_SOURCE=2)

-- Jason
> 
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  libselinux/src/Makefile   | 3 ++-
> >  libselinux/utils/Makefile | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 4306dd0e..010b7ffe 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -59,7 +59,8 @@ ifeq ($(COMPILER), gcc)
> >  EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-
> > compat -Wsync-nand \
> >  	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul
> > -Wnormalized=nfc -Wsuggest-attribute=const \
> >  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > -Wtrampolines -Wjump-misses-init \
> > -	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > -Wp,-D_FORTIFY_SOURCE=2
> > +	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
> > +	-Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2
> >  else
> >  EXTRA_CFLAGS = -Wunused-command-line-argument
> >  endif
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index 474ee95b..c94d7cf2 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -32,7 +32,8 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> > -Wformat-security -Winit-self -Wmissi
> >            -Wformat-extra-args -Wformat-zero-length -Wformat=2
> > -Wmultichar \
> >            -Woverflow -Wpointer-to-int-cast -Wpragmas \
> >            -Wno-missing-field-initializers -Wno-sign-compare \
> > -          -Wno-format-nonliteral -Wframe-larger-
> > than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
> > +          -Wno-format-nonliteral -Wframe-larger-
> > than=$(MAX_STACK_SIZE) \
> > +          -Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2 \
> >            -fstack-protector-all --param=ssp-buffer-size=4
> > -fexceptions \
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option
> > -funit-at-a-time \
> >            -Werror -Wno-aggregate-return -Wno-redundant-decls \
