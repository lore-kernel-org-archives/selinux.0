Message-ID: <1497901826.27645.7.camel@tycho.nsa.gov>
Subject: Re: BINDIR/SBINDIR/... variables in Makefiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Date: Mon, 19 Jun 2017 15:50:26 -0400
In-Reply-To: <CAJfZ7=nCOn2uy6hisa0+ki-8XDcLPab6Wj2L0-2Dv+pqhUuHnQ@mail.gmail.com>
References: <CAJfZ7=nCOn2uy6hisa0+ki-8XDcLPab6Wj2L0-2Dv+pqhUuHnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-06-17 at 15:55 +0200, Nicolas Iooss wrote:
> Hello,
> 
> While updating packages for SELinux userspace 2.7-rc2 release, I
> noticed there are still some inconsistencies in the Makefile
> variables
> related to bin and sbin directories. A quick search (with find .
> -name
> Makefile -exec cat {} + |grep '^[A-Z_]*BINDIR' |sort -u) shows:
> 
> BINDIR=$(PREFIX)/bin
> BINDIR ?= $(PREFIX)/bin
> BINDIR ?= $(PREFIX)/sbin
> SBINDIR ?= $(DESTDIR)/sbin
> SBINDIR ?= $(PREFIX)/sbin
> USRSBINDIR ?= $(PREFIX)/sbin
> 
> In the coming days I will not have time to write and test patches in
> order to make these variables more consistent. I am therefore sending
> this message in case someone would want to fix these inconsistencies
> before the 2.7 release.

I guess the question is do we need to still support distributions that
do not enable usrmerge?

If so, then the difference is meaningful, and changing all SBINDIR
instances to be either $(PREFIX)/sbin or $(DESTDIR)/sbin could create
breakage.  Originally I was thinking we should convert them all to
$(PREFIX)/sbin (and kill the load_policy symlink) and just drop
USRSBINDIR entirely, since the majority of cases are already using that
definition and in the usrmerge case it will correspond to the real
path.  This would however break fixfiles (unless we also update it to
specify /usr/sbin/{setfiles,restorecon}) and the make relabel targets
in the selinux Makefiles (unless we update them all to specify
/usr/sbin/restorecon) on non-usrmerge distributions.  More importantly,
it would prevent running fixfiles, setfiles, and restorecon before /usr
is mounted on non-usrmerge distributions, which could be problematic
for e.g. autorelabel, invocation of restorecon from init scripts, etc.

Converting them all to $(DESTDIR)/sbin doesn't seem beneficial, as that
would end up installing far more utilities into /sbin that aren't
actually needed before /usr is mounted.

So, if non-usrmerge still matters, we probably can't make them
consistent.  If it doesn't matter, then I'd go with the first option
above.

> By the way, I noticed a few things in the RC that may be worth
> mentioning in the final release announcement:
> * libsemanage no longer needs ustr.
> * libselinux/utils Makefile now uses USRSBINDIR instead of USRBINDIR
> (since commit 055d14a99a84 ("libselinux/utils: do not create an empty
> /sbin directory")).
> * Some packages (libselinux, checkpolicy, selinux-python,
> semodule-utils and mcstrans) require LIBSEPOLA to the set to the
> absolute path to libsepol.a when building with DESTDIR set.

Thanks, will add to the release notes.
