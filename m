Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24820
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 17:53:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA22258
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 21:53:05 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id VAA22254
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 21:53:04 GMT
Date: Tue, 22 May 2001 16:53:07 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105222153.QAA38354@tomcat.admin.navo.hpc.mil>
To: edm@tycho.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: Immunity against Buffer Overflows / exploits
In-Reply-To: <1010522165616.216AAH0F.edm@termpaper>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

edm@tycho.ncsc.mil:
> 
> Actually, selinux provides a very effective defense against the exploitation
> of buffer overflows. Here's why:
> 
> A typical use of the buffer overflow attack is for the attacker to execute a
> shell or some other program (such as a compiler as the internet virus did.)
> Under selinux, only certain domains are allowed to execute a shell or
> another program for that matter. If the policy does not allow the domain
> that the program is executing in to exec a shell or another process (or fork
> for that matter), a policy violation occurs and the attack is stopped. In
> addition, even if the process can execute another program only programs that
> have the proper type allowed by the policy can be executed within a
> particular domain.

True, as far as it goes. The buffer overflow can:
   1. reload current process memory (it used to be called an "overlay")
   2. start execution of the reloaded memory (may be a shell or equivalent)
   3. which resets the stack, frees data space and generally becomes a
      new process via a simulated exec.

> These restrictions apply to "privileged" (or root) processes as well. Root
> under selinux is not like root under linux, it's restricted. All system
> processes are each setup to execute in their own domain. These domains have
> only the privileges that are necessary for its process to execute. For
> example, if fingerd is attacked using buffer overflow, the policy will
> prevent it from executing another program. In addition, even if that
> attacker is able to inject extensive code into the process space, that code
> will only be able to access those objects that the policy restricts the
> fingerd's domain to.

It IS limited to only what the domain permits a process to do directly.
Indirectly, the process could become a shell anyway.
 
> However, if the policy allows for that domain type to access /dev/mem (or
> any file that allows access to system memory) then the system can be attack.
> It is important to note, however, that the policy has to allow for a given
> domain type to access this and any domain that needs this type of access
> needs review. -->Under selinux only programs that execute in the klogd and
> the xserver domains have this access.<--

In any case, the BEST that can be done is to limit the process into a
sandbox that only occupies memory. This also means that the original process
couldn't do that much that was usefull anyway.

Look at a sample memory layout (this is not exact):

low:
	program text		(read only?)
	static data		(read write)
	heap			(read write)
	stack			(read write)
	shared text		(read only)
high:

My arguments are still limited to Intel 32 bit only (and limited there to
explainations of why "non-exec stack" doesn't stop penetrations).

There is no execute only flag on memory.

Penetration can replace any writable memory. It may reuse the shared text/
program text for libraries.

The program may remain in the heap and stack space. Any program running
here can do whatever the domain allows. If the domain "allowed" the initial
penetration, then there is a channel that can be used to load yet more
of a program in.

Since /tmp is normally available, there is a LOT of expansion ability if
the penetrated program can use mmap...

Other hardware controls do change this. Even Intel could be better if the
memory management hardware had execute capability separate from read; and
separate from write. Once that is possible then the initial penetration
would fail.

> >> > Hello there,
> >> >
> >> > I just wondered, whether the security mechanisms implemented in SELinux
> >> > would be able to protect the system from the exploit (not the
> occurrence)
> >> > of Buffer Overflows.
> >>
> >> Simple answer: No.
> >>
> >> > Let's assume, the security mechanism and the kernel are sane & safe. An
> >> > application runs in "underpriviledged" mode, that is the policy permits
> >> > the application to read file A and read & write to file B. Now, if the
> >> > application tries to go berserk, the policy control mechanism will take
> it
> >> > out and shoot it. But if somehow a buffer within the application gets
> an
> >> > overflow, will it be able to acces memory areas, that belong to other
> >> > applications?
> >>
> >> The buffer overlow will only access current process memory. If that
> >> process can attach to other memory (via /proc or /dev/kmem) then
> >> anything goes.
> >
> >I'm not sure, if I fully got that. So, basically, the application
> >has only it's _own_ memory for data and it's own instruction stack, is
> >that correct? And, as long as the policy is intact, whatever will happen
> >in this overwritten buffer will not be able to do anything that the
> >application was not allowed to. Of course, if the application was allowed
> >to mess with memory directly, we will be in deep trouble. But even
> >standard linux should be able to keep userprocesses from doing so.
> >(I tried on this machine to mess with /proc and /dev/kmem as a user, no
> >way. Admittedly, I did it in a very dilletant way with cat /dev/kmem )
> >
> >> The problem is significant, but no solution currently exists.
> >>
> >> Depends on hardware support -
> >> 	IF the hardware allows read/write access to memory and denies
> >> 	   execute access to read/write memory (instruction space is execute
> >> 	   only) THEN and only then can buffer overflows be properly
> limited.
> >>
> >> You still have the problem of causing an "exec" to another program. But
> >> that is (partially) a different problem. This can be addressed.
> >>
> >> If an executable image on disk is not permitted to "fork/exec/..." then
> >> it can be prevented. That is one of the advantages to static linking
> >> over using shared libraries. The static link will only have the system
> >> calls included that it requires. If the program doesn't use fork/exec
> >> system call, then it would not be included.
> >>
> >> If this is combined with hardware protection above, then the exec system
> >> call could not be invoked.
> >>
> >> Invoking the system call currently can be done by loading the system call
> >> invokation on the stack, with parameters and the pointer to the stack
> area
> >> containing this executable code (replacing the return address of the
> caller;
> >> then allowing the current function to complete.
> >>
> >> If the stack cannot be exected it fails.
> >>
> >> If the return address on the stack points to an exec function, then the
> >> exec will be executed, using the other parameters on the stack (loaded
> via
> >> the overflow).
> >>
> >> If the exec function doesn't exist in the text image then it fails.
> >>
> >> If the privileges of the process doesn't include exec, then it would
> >> also fail, even if the exec system call were included.
> >>
> >> This combined with the non-executable rw memory (stack and data) then
> >> a reasonable amount can be done to shield against buffer overflows.
> >>
> >> Unfortuanately, protection of rw memory is not available on Intel.
> >>  A: If you can read it, it is executable.
> >>  B: If you can write it; you can read it. (see A)
> >>
> >> Other patforms may vary.
> >
> >So I see, the question is now, to which extend security can be done in
> >software and where do we have to fondle with hardware.
> >
> >Thanks you,
> >
> >JanP
> >
> >
> >--
> >You have received this message because you are subscribed to the selinux
> list.
> >If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> >the words "unsubscribe selinux" without quotes as the message.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
