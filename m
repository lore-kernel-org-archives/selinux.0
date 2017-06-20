Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5K2fR8l014489
 for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2017 22:41:27 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so2485795pfk.2
 for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2017 19:41:22 -0700 (PDT)
Date: Tue, 20 Jun 2017 10:41:17 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Subject: Re: BINDIR/SBINDIR/... variables in Makefiles
Message-ID: <20170620024117.GA22554@meriadoc.perfinion.com>
References: <CAJfZ7=nCOn2uy6hisa0+ki-8XDcLPab6Wj2L0-2Dv+pqhUuHnQ@mail.gmail.com>
 <1497901826.27645.7.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497901826.27645.7.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 19, 2017 at 03:50:26PM -0400, Stephen Smalley wrote:
> On Sat, 2017-06-17 at 15:55 +0200, Nicolas Iooss wrote:
> > Hello,
> > 
> > While updating packages for SELinux userspace 2.7-rc2 release, I
> > noticed there are still some inconsistencies in the Makefile
> > variables
> > related to bin and sbin directories. A quick search (with find .
> > -name
> > Makefile -exec cat {} + |grep '^[A-Z_]*BINDIR' |sort -u) shows:
> > 
> > BINDIR=$(PREFIX)/bin
> > BINDIR ?= $(PREFIX)/bin
> > BINDIR ?= $(PREFIX)/sbin
> > SBINDIR ?= $(DESTDIR)/sbin
> > SBINDIR ?= $(PREFIX)/sbin
> > USRSBINDIR ?= $(PREFIX)/sbin
> > 
> > In the coming days I will not have time to write and test patches in
> > order to make these variables more consistent. I am therefore sending
> > this message in case someone would want to fix these inconsistencies
> > before the 2.7 release.
> 
> I guess the question is do we need to still support distributions that
> do not enable usrmerge?

Yes please, Gentoo hasnt done usrmerge officially (yet?). You can of
course do usrmerge on gentoo but its not the default and since we're a
rolling distro even if/when we do switch we'll likely have to support
unmerged for quite a long time since there isnt a complete re-install on
new releases.

Although, there is still inconsistency in the naming which could perhaps
be fixed. one of them up there has BINDIR?=../sbin so should technically
be called SBINDIR i guess.

-- Jason
> 
> If so, then the difference is meaningful, and changing all SBINDIR
> instances to be either $(PREFIX)/sbin or $(DESTDIR)/sbin could create
> breakage.  Originally I was thinking we should convert them all to
> $(PREFIX)/sbin (and kill the load_policy symlink) and just drop
> USRSBINDIR entirely, since the majority of cases are already using that
> definition and in the usrmerge case it will correspond to the real
> path.  This would however break fixfiles (unless we also update it to
> specify /usr/sbin/{setfiles,restorecon}) and the make relabel targets
> in the selinux Makefiles (unless we update them all to specify
> /usr/sbin/restorecon) on non-usrmerge distributions.  More importantly,
> it would prevent running fixfiles, setfiles, and restorecon before /usr
> is mounted on non-usrmerge distributions, which could be problematic
> for e.g. autorelabel, invocation of restorecon from init scripts, etc.
> 
> Converting them all to $(DESTDIR)/sbin doesn't seem beneficial, as that
> would end up installing far more utilities into /sbin that aren't
> actually needed before /usr is mounted.
> 
> So, if non-usrmerge still matters, we probably can't make them
> consistent.  If it doesn't matter, then I'd go with the first option
> above.
> 
> > By the way, I noticed a few things in the RC that may be worth
> > mentioning in the final release announcement:
> > * libsemanage no longer needs ustr.
> > * libselinux/utils Makefile now uses USRSBINDIR instead of USRBINDIR
> > (since commit 055d14a99a84 ("libselinux/utils: do not create an empty
> > /sbin directory")).
> > * Some packages (libselinux, checkpolicy, selinux-python,
> > semodule-utils and mcstrans) require LIBSEPOLA to the set to the
> > absolute path to libsepol.a when building with DESTDIR set.
> 
> Thanks, will add to the release notes.
> 
