Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA08933
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 13:04:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA08400
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 17:04:42 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id RAA08396
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 17:04:41 GMT
Date: Fri, 18 May 2001 12:04:46 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105181704.MAA88311@tomcat.admin.navo.hpc.mil>
To: jan.petranek@student.uni-tuebingen.de,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Immunity against Buffer Overflows / exploits
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---------  Received message begins Here  ---------

> 
> Hello there,
> 
> I just wondered, whether the security mechanisms implemented in SELinux
> would be able to protect the system from the exploit (not the occurrence)
> of Buffer Overflows.

Simple answer: No.

> Let's assume, the security mechanism and the kernel are sane & safe. An
> application runs in "underpriviledged" mode, that is the policy permits
> the application to read file A and read & write to file B. Now, if the
> application tries to go berserk, the policy control mechanism will take it
> out and shoot it. But if somehow a buffer within the application gets an
> overflow, will it be able to acces memory areas, that belong to other
> applications?

The buffer overlow will only access current process memory. If that
process can attach to other memory (via /proc or /dev/kmem) then
anything goes.

The problem is significant, but no solution currently exists.

Depends on hardware support -
	IF the hardware allows read/write access to memory and denies
	   execute access to read/write memory (instruction space is execute
	   only) THEN and only then can buffer overflows be properly limited.

You still have the problem of causing an "exec" to another program. But
that is (partially) a different problem. This can be addressed.

If an executable image on disk is not permitted to "fork/exec/..." then
it can be prevented. That is one of the advantages to static linking
over using shared libraries. The static link will only have the system
calls included that it requires. If the program doesn't use fork/exec
system call, then it would not be included.

If this is combined with hardware protection above, then the exec system
call could not be invoked.

Invoking the system call currently can be done by loading the system call
invokation on the stack, with parameters and the pointer to the stack area
containing this executable code (replacing the return address of the caller;
then allowing the current function to complete.

If the stack cannot be exected it fails.

If the return address on the stack points to an exec function, then the
exec will be executed, using the other parameters on the stack (loaded via
the overflow).

If the exec function doesn't exist in the text image then it fails.

If the privileges of the process doesn't include exec, then it would
also fail, even if the exec system call were included.

This combined with the non-executable rw memory (stack and data) then
a reasonable amount can be done to shield against buffer overflows.

Unfortuanately, protection of rw memory is not available on Intel.
 A: If you can read it, it is executable.
 B: If you can write it; you can read it. (see A)

Other patforms may vary.

You also have the problem with the GNU C compiler generating "trampoline"
functions on the stack to implement function nesting. C++ requires these
or their equivalent.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
