Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Joshua Brindle <jbrindle@tresys.com>
To: Jim Meyering <jim@meyering.net>
Cc: James Antill <james.antill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <87ac5vu3ys.fsf@rho.meyering.net>
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
	 <1156263820.4242.8.camel@twoface.columbia.tresys.com>
	 <87k6506682.fsf@rho.meyering.net> <1156292847.8627.25.camel@code.and.org>
	 <87ac5vu3ys.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 08:23:49 -0400
Message-Id: <1156767829.3283.35.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 12:43 +0200, Jim Meyering wrote:
<snip>
> Hi James,
> 
> That's a good description.  And I like the new function name.
> As you know, functions other than file-creating-open are affected, too:
> mkfifo, mknod, symlink, creat.  And it's not quite like setexeccon, where
> at most one execve call is affected.
> Also, any use of setfscreatecon-with-non-NULL-arg in the exec'd process
> would cancel the effect of a parent's setfspostexeccon.  I think an initial
> setfscreatecon(NULL) in the exec'd process would be a no-op.
> So here's what I want:
> 
>         setfspostexeccon
>         [...stuff which isn't exec...]
>         exec
>         [...operations that don't create files
>             and that don't call setfscreatecon...]
>         open(O_CREAT), or mkfifo, etc. <-- affects this.
>         [...still no setfscreatecon...]
>         symlink, or mknod, etc.        <-- and this.
> 
> How is this an argument against making fscon possible?
> 

Its a very broken design, we want to taint the new process as little as
possible and this is a big nasty piece of environment you want to place
solidly in the upcoming process, further you are saying you want to make
it more difficult for the child to ignore it?!

Consider what would happen if you were able to set the mode for files
opened by the next process, something like:

setmostexecmode(S_IROTH | S_IWOTH)
exec(/usr/bin/passwd)
and the resulting shadow is readable and writable by everyone?

Granted this particular piece of environment would have to be removed
with ATSECURE which means domain transitions could also eliminate it but
with the targeted policy I don't think we want unconfined_t using this
which means fscon would be unusable anyway. Also, the command line
syntax is all but intuitive, even for seasoned UNIX people who are
probably much more familiar with using command line arguments,
especially when you need to domain transition manually *and* set the
file context this way, noone will ever do it. 

> >> It's more of the one task, one tool Unix approach to problem solving.
> >
> >  Personally I don't believe this has been the case for decades, but
> > anyway...
> >
> >> Another program that works this way: setarch.
> >
> >  It doesn't work that way, setarch calls the personality() syscall. This
> > is basically a global variable inside the kernel. For instance:
> ...
> 
> Thanks for explaining.
> I didn't do enough homework there.  Shouldn't have taken the bait :)
> 
> Sounds like sour grapes, but are implementation details really relevant?
> Or maybe the argument is that it is not possible (or reasonable)
> to implement fscon?
> 

its possible, I think it is a very terrible idea though.

> Regardless of how it's implemented, I think it is clear that a program
> like fscon would make it possible for more tools to work more easily
> with SELinux.
> 
> As upstream maintainer, I can't provide a "-Z CTX"-like option for SELinux,
> and then say "No" to proposals to add ones for other MAC-based system.

you can if those others aren't in the mainline kernel.

> Eventually we'd have an unmaintainable mess, with per-scheme code for
> option handling, portability infrastructure, and actual implementation
> (however simple) being duplicated in at least these four coreutils
> programs.  And that's not counting the eventual code that might have
> to detect and diagnose when people try to mix and match options for
> incompatible schemes.
> 
> Sure, I'm looking ahead a little (would AppArmor be a contender?
> I don't know), but that's part of the "upstream" job.
> 

apparmor doesn't label files, they use paths, no it is not a contender.

> Remember, if there is agreement that providing SELinux infrastructure
> to implement a program like fscon is not feasible, then we're done.
> But I heard exactly the opposite conclusion already.
<snip>
> 
> If there's serious disagreement, to the point that fscon is never
> implementable, then I'll consider keeping the relatively small "-Z CTX"
> diffs separate.  I could even maintain patches, much the way that is done
> with rsync development.  If it turns out everyone who uses the upstream
> coreutils also applies a certain patch, eventually I might have no choice
> but to accept it.

Personally I don't think any distro will ever use fscon, at least
Gentoo, possibly Red Hat and Debian will continue to maintain patches to
keep the -Z behavior and this whole discussion was a waste of time. 

And I still disagree with your notion that its ok to silently ignore the
user input if they invoke fscon with a context and the next process
overwrites it. The next process should always have precedence but
silently dropping user input with no explanation of why what they are
trying is not succeeding is very bad user interface design.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
