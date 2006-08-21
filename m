From: Jim Meyering <jim@meyering.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1156182056.14126.91.camel@sgc> (Christopher J. PeBenito's
	message of "Mon, 21 Aug 2006 13:40:56 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155308294.8018.59.camel@localhost.localdomain>
	<87irkzfcgr.fsf@rho.meyering.net>
	<1155567404.23601.10.camel@localhost.localdomain>
	<87ac67iaao.fsf@rho.meyering.net>
	<1155571378.23601.32.camel@localhost.localdomain>
	<873bbzi6c1.fsf@rho.meyering.net>
	<1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	<87wt929j25.fsf@rho.meyering.net> <1156182056.14126.91.camel@sgc>
Date: Mon, 21 Aug 2006 23:31:43 +0200
Message-ID: <87pset93nk.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
...
> It has mentioned before but I think it needs to be said again.  Since
> SELinux support is being merged upstream, it should be treated like a
> first class citizen.  Many of the tools have the -m options, and the
> mode is to Linux DAC as the context is to SELinux; therefore, the -Z
> options should be kept.

IMHO, that doesn't follow, IF there is a better way, like via fscon.

[ Your use of "kept" is a little ambiguous.  Just to be clear,
  I suspect the -Z CTX options of mkdir, install, mkfifo, mknod will be
  "kept" in FC and Red Hat products for some time to come.  This is about
  whether they should propagate to upstream coreutils.  ]

> Any coreutils program that has a -m option
> should likely have a -Z option.

Alternatively, there should be a tool by which to make each of those
coreutils programs produce the same net effect.

> Fscon has security implications.  For example, if the program fscon
> exec's transitions to a different domain, either it would have to be
> disallowed across a transition, or we would have to add a permission to

I understood that making fscon disallow a transition would be fine.
Any cross-transition use could be achieved via runcon.

> allow it to work across transitions.  If a misbehaving program doesn't
> clear its fscreate, then all its child programs will be broken by trying
> to create programs in the wrong context, which would be common for the
> non-transitioning exec() case.
>
> Fscon doesn't work for any program that isn't simple like coreutils
> programs.

But there are many others that *would* benefit.

> For example, it does not work for any program that creates
> multiple files in different locations, because using fscon assumes that
> they should all be the same context, when they likely shouldn't.

And no one would even try to use fscon with such programs.  Besides, to
work properly, wouldn't such a program have to set the fscreate context
of each different output file explicitly?  In that case, the default
set by fscon would have no effect.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
