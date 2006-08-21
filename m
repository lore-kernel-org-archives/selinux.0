Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jim Meyering <jim@meyering.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <87wt929j25.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
	 <87irkzfcgr.fsf@rho.meyering.net>
	 <1155567404.23601.10.camel@localhost.localdomain>
	 <87ac67iaao.fsf@rho.meyering.net>
	 <1155571378.23601.32.camel@localhost.localdomain>
	 <873bbzi6c1.fsf@rho.meyering.net>
	 <1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	 <87wt929j25.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 13:40:56 -0400
Message-Id: <1156182056.14126.91.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-21 at 17:58 +0200, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2006-08-14 at 19:18 +0200, Jim Meyering wrote:
> >> I agree that it's not a trivial way to use programs, but isn't the
> >> scenario that'd require such usage a little bit off the beaten track?
> >
> > I'm not sure that this is a valid assumption.  It might be educational
> > (or perhaps not) to take your proposal to fedora-selinux-list, and seek
> > feedback there, as I think they have a much larger subscriber base and
> 
> As you've probably noticed, I posted to the lists, as you suggested:
>   https://www.redhat.com/archives/fedora-list/2006-August/msg02264.html (long)
> 
> I suppose it's still early, but so far, all I have is positive feedback:
> 
>   http://lists.gnu.org/archive/html/bug-coreutils/2006-08/msg00147.html
> 
> Support (and even rebuttal) welcomed.
> Even silence is ok, as long as it implies consent :)

It has mentioned before but I think it needs to be said again.  Since
SELinux support is being merged upstream, it should be treated like a
first class citizen.  Many of the tools have the -m options, and the
mode is to Linux DAC as the context is to SELinux; therefore, the -Z
options should be kept.  Any coreutils program that has a -m option
should likely have a -Z option.

Fscon has security implications.  For example, if the program fscon
exec's transitions to a different domain, either it would have to be
disallowed across a transition, or we would have to add a permission to
allow it to work across transitions.  If a misbehaving program doesn't
clear its fscreate, then all its child programs will be broken by trying
to create programs in the wrong context, which would be common for the
non-transitioning exec() case.

Fscon doesn't work for any program that isn't simple like coreutils
programs.  For example, it does not work for any program that creates
multiple files in different locations, because using fscon assumes that
they should all be the same context, when they likely shouldn't.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
