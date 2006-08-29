Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Jim Meyering <jim@meyering.net>, James Antill <james.antill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156796640.22210.167.camel@moss-spartans.epoch.ncsc.mil>
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
	 <1156767829.3283.35.camel@twoface.columbia.tresys.com>
	 <1156796640.22210.167.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:11:04 -0400
Message-Id: <1156878664.22210.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-28 at 16:24 -0400, Stephen Smalley wrote:
> On Mon, 2006-08-28 at 08:23 -0400, Joshua Brindle wrote:
> > On Wed, 2006-08-23 at 12:43 +0200, Jim Meyering wrote:
> > <snip>
> > > Hi James,
> > > 
> > > That's a good description.  And I like the new function name.
> > > As you know, functions other than file-creating-open are affected, too:
> > > mkfifo, mknod, symlink, creat.  And it's not quite like setexeccon, where
> > > at most one execve call is affected.
> > > Also, any use of setfscreatecon-with-non-NULL-arg in the exec'd process
> > > would cancel the effect of a parent's setfspostexeccon.  I think an initial
> > > setfscreatecon(NULL) in the exec'd process would be a no-op.
> > > So here's what I want:
> > > 
> > >         setfspostexeccon
> > >         [...stuff which isn't exec...]
> > >         exec
> > >         [...operations that don't create files
> > >             and that don't call setfscreatecon...]
> > >         open(O_CREAT), or mkfifo, etc. <-- affects this.
> > >         [...still no setfscreatecon...]
> > >         symlink, or mknod, etc.        <-- and this.
> > > 
> > > How is this an argument against making fscon possible?
> > > 
> > 
> > Its a very broken design, we want to taint the new process as little as
> > possible and this is a big nasty piece of environment you want to place
> > solidly in the upcoming process, further you are saying you want to make
> > it more difficult for the child to ignore it?!
> 
> The last part is definitely problematic, I agree.  The first part would
> be addressed by resetting the attribute upon a context-changing exec
> either unconditionally in all cases or based on some new permission
> check modeled after noatsecure, rlimitinh, and siginh for other kinds of
> state inheritance across a context change.  
> 
> > Consider what would happen if you were able to set the mode for files
> > opened by the next process, something like:
> > 
> > setmostexecmode(S_IROTH | S_IWOTH)
> > exec(/usr/bin/passwd)
> > and the resulting shadow is readable and writable by everyone?
> > 
> > Granted this particular piece of environment would have to be removed
> > with ATSECURE
> 
> More like rlimitinh/siginh, since the kernel can directly handle both
> the checking and sanitization of this piece of state, unlike the
> environment purging by glibc (where the kernel just provides the
> decision via AT_SECURE).  
> 
> >  which means domain transitions could also eliminate it but
> > with the targeted policy I don't think we want unconfined_t using this
> > which means fscon would be unusable anyway.
> 
> I was following you up to this point, but don't follow this statement.
> Why can't unconfined_t use fscon? 
> 
> >  Also, the command line
> > syntax is all but intuitive, even for seasoned UNIX people who are
> > probably much more familiar with using command line arguments,
> > especially when you need to domain transition manually *and* set the
> > file context this way, noone will ever do it.
> 
> The runcon piece of this puzzle is actually a bit more of a problem,
> because of entrypoint controls.  You can't just say:
> 	runcon <context> fscon -t type <program> <args>
> because program is the authorized entrypoint for <context>, not fscon.
> fscon would have to become a shared entrypoint for all such contexts,
> and that would be a bad thing.

Actually, I'm not sure that we would need to combine runcon with fscon
in this manner, given the intended usage.  Previously we were executing
<program> -Z <fscontext> <args>, optionally with a runcon prefix to
force it into a specified process context.  The caller was supplying the
fscontext to the program, with no kernel mediation of the fscontext at
all relative to the caller (since arguments aren't interpreted by the
kernel), just when the program itself passes it to setfscreatecon().
Under the proposed approach, we would be executing fscon <fscontext>
<program> <args> or optionally fscon <fscontext> runcon <proccontext> --
<program> <args>.  The caller is still providing the context, but now
there is a kernel mediation of the context relative to the caller when
it performs setfscreatecon(), and there can be mediation of the
inheritance across a context-changing exec based on some new permission
check.  In this case, since we were fine with the caller providing the
context in the first place, we could just allow the inheritance in the
policy, and we don't need the runcon to precede the fscon.  It is only
if we hardcode a behavior of resetting the fscreate attribute on all
context changes that we have to use runcon first, but that behavior
doesn't match the trust model that is already present in the use of the
-Z options.

Now, all of this assumes that the program in question would apply that
-Z context to all files it creates; otherwise, these are not equivalent.
That is likely true of coreutils.  For programs that create a primary
output file but also generate ancillary files for e.g. audit,
bookkeeping, statistics, etc, use of fscon may not be sufficient, but
then neither would a single -Z option.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
