Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Joshua Brindle <jbrindle@tresys.com>
To: Jim Meyering <jim@meyering.net>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <87sljo69le.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
	 <87irkzfcgr.fsf@rho.meyering.net>
	 <1155567404.23601.10.camel@localhost.localdomain>
	 <87ac67iaao.fsf@rho.meyering.net>
	 <1155571378.23601.32.camel@localhost.localdomain>
	 <873bbzi6c1.fsf@rho.meyering.net>
	 <1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	 <87wt929j25.fsf@rho.meyering.net> <1156182056.14126.91.camel@sgc>
	 <87pset93nk.fsf@rho.meyering.net> <44EB02B3.5040100@tresys.com>
	 <87sljo69le.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:23:40 -0400
Message-Id: <1156263820.4242.8.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-22 at 18:03 +0200, Jim Meyering wrote:
> Joshua Brindle <jbrindle@tresys.com> wrote:
> > Jim Meyering wrote:
> >> "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> > <snip>
> But I did.
> Perhaps it doesn't address points that are obvious to you?
> I interpret "Fscon doesn't work for any program..." as meaning that it
> is not an appropriate tool for them.  Not that it would cause any harm.
> Perhaps you interpret it as meaning "fscon could cause arbitrary programs
> to misbehave"?
> 

It could cause harm if users have to manage contexts in different ways
depending on the app they are using.

> I think there's a deeper difference in our understanding of how
> this hypothetical fscon program would work.  I expect that fscon
> would call some new function to request that a specified fscreate
> context be applied (as the default) to the next exec call.
> When I first read the descriptions of setexeccon and setfscreatecon,
> I thought the latter would do just what I wanted.  Unfortunately,
> its semantics aren't analogous to those of setexeccon.
> 

setexeccon sets the context for the next execution, not the context for
the next execution of the next execution, these are not in any way
comparable.

>   [ I wrote the following a week or so ago: ]
>   I see that setexeccon sets the context to be used for next execve call.
>   And then there's setfscreatecon.  I want something similar that sets
>   the fscreate context for the next execve call.  Does such a function exist?
>   Is there some other way to do what I want?
> 
> It sounds like you're expecting the exec'd process to inherit
> unconditionally the fscreate context that the calling process had
> when it called execve.  Of course, that behavior would throw everyone
> for a loop.  The former would be a lot less disruptive, and
> Stephen Smalley said providing it might be feasible.
> 

fine, retracted.

> > Being able to set your childrens fscreatecon is _dangerous_ and
> > potentially affects robustness if a parent forgets to unset it before
> > spawning children. Granted doing this across domain transitions can (and
> > must) be protected by policy but within the same domain there is little
> > that can be done. You'll risk making the filesystem inconsistent with this.
> >
> > I honestly don't understand the problem here, these applications are
> > simple and adding -Z (to be standard with every other selinux aware
> > util) doesn't hurt anything. fscon is _not_ a better way to do this, its
> > a hack that can only be used by coreutils because of the point above
> > that any app of sufficient complexity will be writing files with
> > different contexts.
> 
> I'm concerned that if there's a better way (fscon), adding "-Z CTX" in
> many tools would be a hack.
> 

how is fscon a better way? What other tool in Linux sets attributes for
the next exec this way? (don't say su or sudo, those are used _before_
the upcoming exec, not _in_ the next exec). Very unintuitive IMO.

> Did you see both of my messages to this list yesterday?
> And the long one I posted to fedora-list?
>   https://www.redhat.com/archives/fedora-list/2006-August/msg02264.html
> I've tried hard to explain why I am so reluctant to add "-Z CTX" to
> the coreutils.  If something isn't clear, or if you disagree with
> specific reasons, please give details.

I read them, I don't see anything about fscon compelling, like I said,
very unintuitive. You mention using something like this for tar but,
once again, anything that writes more than 1 file is going to want find
grained labeling support. Tar is going to need to write labels that it
has stored, not random labels that its parent is giving it. 

On that note, how do you plan on reconciling when the parent says one
thing and the child says another? How unintuitive would it be if the
child simply ignored the parent (which it probably would) even when the
user is trying to use fscon.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
