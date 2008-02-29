From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
Date: Fri, 29 Feb 2008 09:23:59 -0500
Cc: selinux@tycho.nsa.gov
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net> <1204293273.31790.251.camel@moss-spartans.epoch.ncsc.mil> <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802290924.00392.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 February 2008 9:13:46 am Stephen Smalley wrote:
> On Fri, 2008-02-29 at 08:54 -0500, Stephen Smalley wrote:
> > On Thu, 2008-02-28 at 16:41 -0500, Paul Moore wrote:
> > > While looking at the SELinux secid/secctx conversion functions I
> > > realized they could probably do with a little cleanup to reduce the
> > > amount of code and make better use of existing string processing
> > > functions in the kernel.  Making use of the kernel's existing string
> > > processing functions is a good idea as many architectures have
> > > specialized/optimized routines which should be an improvement over the
> > > generic code in the SELinux security server. ---
> > >
> > >  security/selinux/ss/mls.c      |   61 +++++--------
> > >  security/selinux/ss/mls.h      |    3 -
> > >  security/selinux/ss/services.c |  194
> > > ++++++++++++++++------------------------ 3 files changed, 103
> > > insertions(+), 155 deletions(-)
> >
> > The snippet below looks like a step backward rather than an improvement
> > - single sprintf replaced by series of strcat calls.  That can't be more
> > efficient.
>
> Hmm...well, maybe I'm wrong (after looking at the implementations).

That is exactly why I decided the multiple strcpy()/strcat() calls would be 
faster.  Our formatting needs here are pretty simple and the kernel's 
sprintf() implementation looks very involved versus strcpy()/strcat().

> Pity that Linux doesn't have stpcpy (as in glibc) - that is much nicer
> than a series of strcat's since it returns the end pointer and doesn't
> require finding the end of string each time.

That would be nice here.  However, I think at least moving away from sprintf() 
should yield an advantage.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
