Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Joshua Brindle <jbrindle@tresys.com>
To: James Antill <james.antill@redhat.com>
Cc: Jim Meyering <jim@meyering.net>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156292847.8627.25.camel@code.and.org>
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
	 <87k6506682.fsf@rho.meyering.net>  <1156292847.8627.25.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 07:52:37 -0400
Message-Id: <1156333957.4242.10.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-22 at 20:27 -0400, James Antill wrote:
> On Tue, 2006-08-22 at 19:16 +0200, Jim Meyering wrote:
> 
> > >
> > > setexeccon sets the context for the next execution, not the context for
> > > the next execution of the next execution, these are not in any way
> > > comparable.
> > 
> > Sorry, I can't parse that.
> > I'll rephrase the part I understand:
> >   setexeccon sets the execution context for the next execve call
> > 
> > I would like fscon to set the default fscreate context to take effect
> > for the next execve call -- then it performs that execve call.
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
> 

Yes, thank you for drawing a picture :) this is absolutely right and I
think this strange way of changing the behavior of the upcoming app
_after_ the exec is a very bad idea.

> 
> > It's more of the one task, one tool Unix approach to problem solving.
> 
>  Personally I don't believe this has been the case for decades, but
> anyway...
> 
> > Another program that works this way: setarch.
> 
>  It doesn't work that way, setarch calls the personality() syscall. This
> is basically a global variable inside the kernel. For instance:
> 
> % cat ~/personality.c
> #include <sys/personality.h>
> 
> int main(void)
> {
>         personality(-1);
>         return 0;
> }
> % gcc -Wall -W -o ~/personality ~/personality.c
> % strace -e trace=personality setarch i386 ~/personality
> personality(PER_LINUX32)                = 0
> personality(0xffffffff /* PER_??? */)   = 8
> Process 9009 detached
> % strace -e trace=personality setarch i386 sh -c ~/personality
> personality(PER_LINUX32)                = 0
> personality(0xffffffff /* PER_??? */)   = 8
> Process 9013 detached
> 

Thanks for explaining this setarch, I wasn't quite sure what it was but
I had doubts that it was analogous to this fscon idea.

> > Both were mentioned in my earlier posts.
> > 
> > In principle, what I'm suggesting is no more unusual than what the
> > setarch program does nor what the setexeccon function does.
> [...]
> > The patch program (which I also mentioned) is a better example.
> 
>  As someone else said, I think people want -Z (and/or matchpathcon) on
> commands that have -m and preservation on commands that have
> owner/mode/etc. preservation. Patch doesn't do either of those.
>  mknod/mkfifo/mkdir do have -m, so it seems natural to have -Z (and
> setting umask before could have worked, but having -m options was deemed
> to be better).
> 
>  You would never want -Z in tar to do what you said, AFAICS.
> 

Correct and correct.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
