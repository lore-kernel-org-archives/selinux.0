From: Jim Meyering <jim@meyering.net>
To: James Antill <james.antill@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1156292847.8627.25.camel@code.and.org> (James Antill's message
	of "Tue, 22 Aug 2006 20:27:27 -0400")
Date: Wed, 23 Aug 2006 12:43:55 +0200
Message-ID: <87ac5vu3ys.fsf@rho.meyering.net>
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
	<87k6506682.fsf@rho.meyering.net>
	<1156292847.8627.25.camel@code.and.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[strange.  I sent this message a week ago, but it returned to me today with
 "unknown mail transport error" for each recipient.  No wonder I received no
 reply.  I'll watch the list and my queue more carefully, now. ]

James Antill <james.antill@redhat.com> wrote:
> On Tue, 2006-08-22 at 19:16 +0200, Jim Meyering wrote:
...
>> I'll rephrase the part I understand:
>>   setexeccon sets the execution context for the next execve call
>>
>> I would like fscon to set the default fscreate context to take effect
>> for the next execve call -- then it performs that execve call.
>
>  I think their argument is, that atm. you have:
>
>         setexeccon
>         [...stuff which isn't exec...]
>         exec <-- affects this.
>
>         setfscreatecon
>         [...stuff which isn't open(O_CREAT)...]
>         open(O_CREAT) <-- affects this.
>
> ...and you want:
>
>         setfspostexeccon
>         [...stuff which isn't exec...]
>         exec
>         [...stuff which isn't open(O_CREAT)...]
>         open(O_CREAT) <-- affects this.

Hi James,

That's a good description.  And I like the new function name.
As you know, functions other than file-creating-open are affected, too:
mkfifo, mknod, symlink, creat.  And it's not quite like setexeccon, where
at most one execve call is affected.
Also, any use of setfscreatecon-with-non-NULL-arg in the exec'd process
would cancel the effect of a parent's setfspostexeccon.  I think an initial
setfscreatecon(NULL) in the exec'd process would be a no-op.
So here's what I want:

        setfspostexeccon
        [...stuff which isn't exec...]
        exec
        [...operations that don't create files
            and that don't call setfscreatecon...]
        open(O_CREAT), or mkfifo, etc. <-- affects this.
        [...still no setfscreatecon...]
        symlink, or mknod, etc.        <-- and this.

How is this an argument against making fscon possible?

>> It's more of the one task, one tool Unix approach to problem solving.
>
>  Personally I don't believe this has been the case for decades, but
> anyway...
>
>> Another program that works this way: setarch.
>
>  It doesn't work that way, setarch calls the personality() syscall. This
> is basically a global variable inside the kernel. For instance:
...

Thanks for explaining.
I didn't do enough homework there.  Shouldn't have taken the bait :)

Sounds like sour grapes, but are implementation details really relevant?
Or maybe the argument is that it is not possible (or reasonable)
to implement fscon?

Regardless of how it's implemented, I think it is clear that a program
like fscon would make it possible for more tools to work more easily
with SELinux.

As upstream maintainer, I can't provide a "-Z CTX"-like option for SELinux,
and then say "No" to proposals to add ones for other MAC-based system.
Eventually we'd have an unmaintainable mess, with per-scheme code for
option handling, portability infrastructure, and actual implementation
(however simple) being duplicated in at least these four coreutils
programs.  And that's not counting the eventual code that might have
to detect and diagnose when people try to mix and match options for
incompatible schemes.

Sure, I'm looking ahead a little (would AppArmor be a contender?
I don't know), but that's part of the "upstream" job.

Remember, if there is agreement that providing SELinux infrastructure
to implement a program like fscon is not feasible, then we're done.
But I heard exactly the opposite conclusion already.

>> Both were mentioned in my earlier posts.
>>
>> In principle, what I'm suggesting is no more unusual than what the
>> setarch program does nor what the setexeccon function does.
> [...]
>> The patch program (which I also mentioned) is a better example.
>
>  As someone else said, I think people want -Z (and/or matchpathcon) on
> commands that have -m and preservation on commands that have
> owner/mode/etc. preservation. Patch doesn't do either of those.

On the contrary, patch does preserve permissions.  It tries to apply
the permissions (st_mode) of the input file to the output file:

    $ echo a > 1; touch 2 3; diff 2 1 | strace -e chmod patch 3 -
    patching file 3
    chmod("3", 0100644)                     = 0
    Process 25711 detached

But that's just a detail.  *preserving* attributes like owner/mode/etc.
is no reason to use fscon or to add a "-Z CTX" option.  So now, I think
that patch does *not* need such an option.  I must have put patch and
tar on my list of potentially affected programs before we came to the
conclusion that merely preserving permissions (as done by mv and cp)
does not justify adding a "-Z CTX" option.

>  mknod/mkfifo/mkdir do have -m, so it seems natural to have -Z (and
> setting umask before could have worked, but having -m options was deemed
> to be better).

Note that tar does have a --mode option.  From --help:

      --mode=CHANGES         force (symbolic) mode CHANGES for added files

but it merely changes what's recorded in the archive, and it doesn't set
the default used at extract-time.  So although it might be justified to
add a new option to permit specifying an ACL, XATTR, or an SELinux security
context in the same way, it's not relevant to the fscon discussion.


If there's serious disagreement, to the point that fscon is never
implementable, then I'll consider keeping the relatively small "-Z CTX"
diffs separate.  I could even maintain patches, much the way that is done
with rsync development.  If it turns out everyone who uses the upstream
coreutils also applies a certain patch, eventually I might have no choice
but to accept it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
