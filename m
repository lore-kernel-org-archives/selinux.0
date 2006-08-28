Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Antill <james.antill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
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
Date: Mon, 28 Aug 2006 15:05:05 -0400
Message-Id: <1156791905.22210.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 12:43 +0200, Jim Meyering wrote:
> James Antill <james.antill@redhat.com> wrote:
> > On Tue, 2006-08-22 at 19:16 +0200, Jim Meyering wrote:
> ...
> >> I'll rephrase the part I understand:
> >>   setexeccon sets the execution context for the next execve call
> >>
> >> I would like fscon to set the default fscreate context to take effect
> >> for the next execve call -- then it performs that execve call.
> >
> >  I think their argument is, that atm. you have:
> >
> >         setexeccon
> >         [...stuff which isn't exec...]
> >         exec <-- affects this.
> >
> >         setfscreatecon
> >         [...stuff which isn't open(O_CREAT)...]
> >         open(O_CREAT) <-- affects this.
> >
> > ...and you want:
> >
> >         setfspostexeccon
> >         [...stuff which isn't exec...]
> >         exec
> >         [...stuff which isn't open(O_CREAT)...]
> >         open(O_CREAT) <-- affects this.
> 
> Hi James,
> 
> That's a good description.  And I like the new function name.
> As you know, functions other than file-creating-open are affected, too:
> mkfifo, mknod, symlink, creat.  And it's not quite like setexeccon, where
> at most one execve call is affected.

In both cases (setfscreatecon and setexeccon), the call affects the
labeling behavior of subsequent calls by the program until either a) the
program makes another set* call or b) a new program starts execution.
They are consistent in that respect.

> Also, any use of setfscreatecon-with-non-NULL-arg in the exec'd process
> would cancel the effect of a parent's setfspostexeccon.  I think an initial
> setfscreatecon(NULL) in the exec'd process would be a no-op.

I don't see why that would be desirable.  setfscreatecon(NULL) is an
explicit request by the program to reset its labeling behavior to the
policy defaults, and should always be honored.  In practice, I wouldn't
expect many programs to do that anyway, but if they do it, they meant to
do it.   Code that wants to save, set, create, and restore the fscreate
context (like library functions) would typically do a
getfscreatecon(&orig);setfscreatecon(new);creat/mkdir/...();
setfscreatecon(orig) sequence, but in the hypothetical case where the
fscreate context was inherited from the caller, that orig context would
not be NULL.

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

I'd tend toward an orthogonal operation that affects inheritance of
context attributes rather than creating yet-another-fscreate-like
attribute, more along the lines of prctl(PR_SET_KEEPCAPS), ala:
	setfscreatecon(c);
	setkeepcon(TRUE);
	...
	exec that doesn't involve a context change (or that allows inheritance
of contexts across the context change via some new permission)
	[...anything other than setfscreatecon...]
	any file creation calls <-- affects this.

> How is this an argument against making fscon possible?

I don't think he was making that argument per se, just trying to
eliminate confusion with a picture.

> Regardless of how it's implemented, I think it is clear that a program
> like fscon would make it possible for more tools to work more easily
> with SELinux.

I can agree with that, particularly for third party tools and closed
source programs.  It doesn't necessarily follow that core utilities
provided by the distribution shouldn't include direct support for
SELinux.  I think that is the larger concern.  The context inheritance
issue is easily addressed by prohibiting it upon context changes or
controlling it via permission.

> As upstream maintainer, I can't provide a "-Z CTX"-like option for SELinux,
> and then say "No" to proposals to add ones for other MAC-based system.
> Eventually we'd have an unmaintainable mess, with per-scheme code for
> option handling, portability infrastructure, and actual implementation
> (however simple) being duplicated in at least these four coreutils
> programs.  And that's not counting the eventual code that might have
> to detect and diagnose when people try to mix and match options for
> incompatible schemes.

coreutils doesn't need to care which security module is being used, as
long as it handles the contexts as just strings.  

> On the contrary, patch does preserve permissions.  It tries to apply
> the permissions (st_mode) of the input file to the output file:
> 
>     $ echo a > 1; touch 2 3; diff 2 1 | strace -e chmod patch 3 -
>     patching file 3
>     chmod("3", 0100644)                     = 0
>     Process 25711 detached

I think he meant that patch doesn't preserve security context.  Which is
a problem, but not related to this.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
