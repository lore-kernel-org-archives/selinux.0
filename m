Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA17511
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 12:05:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA04207
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 16:05:40 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzband.ncsc.mil  with ESMTP id QAA04203
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 16:05:39 GMT
Date: Mon, 21 May 2001 11:04:24 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105211604.LAA05113@tomcat.admin.navo.hpc.mil>
To: jd9812@my-deja.com, jan.petranek@student.uni-tuebingen.de,
        maksim@otstavnov.com
Cc: selinux@tycho.nsa.gov
Subject: RE: Re[2]: SELinux as a desktop / workstation?
In-Reply-To: <200105211333.GAA01899@mail6.bigmailbox.com>
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---------  Received message begins Here  ---------

> 
> >JP> The reason I'm writing this is, that I'm a bit concerned about security
> >JP> issues. Up to now, very little viruses have shaken the linux community,
> >JP> but except for selinux and sandbox, there is no thing that prevents code
> >JP> running in the user space from doing anything in the user space.
> >
> >RSBAC (www.rsbac.org; see also ftp.altlinux.ru for Beta-version of "ALT
> >Linux Castle" distro).
> 
> There are a number of ways to prevent viruses in Linux.

"prevent" is too strong. There is no way prevent given the current hardware
and software structures. The use of "trampoline" code guarantees that in
software. The inability to distinquish between read and execute access
guarantees the hardware vulnerability. Viruses would become (nearly) extinct
with "no-execute data segments", and an execute only text (privileged code).

This leaves only the stack overflow to force an exec (or other system call).
At which point other security measures could become effective.

> 1) Tripwire, et al, are "better" detection tools than a virus scanner, as they don't depend on signatures being present, and therefore detect new viruses as well as old ones.

This detects, but does not prevent.

> 2) Bastille Linux, OpenWall, LIDS, and other "Linux Hardening Programs" use Linux "capabilities" to disable userland services which aren't necessary.

None of which can prevent the virus. They do help limit the spread of
the virus to more than one user (depending on virus entry point).

> 3) POSIX ACL, Trustees, etc, add "access control lists" to Linux. IMHO, Trustees is a more interesting project, as it goes beyond just trivial ACL lists.

only if you are working through the "proper" channels, which a virus would
try to avoid.

> 4) Mount your application partitions as "read-only". You don't NEED to have those read/write, except when installing software. Logs, spool-files, etc, all go into /var and the user area is all in /home. Put those two into seperate partitions, which -are- read/write, and you're largely fine.

And the virus only "remounts". It is good practice, but not an absolute
prevention.

> SELinux would certainly help (in that it would quarantine any infected region), but that is not its primary role.
> BTW, since this is a SELinux mailing list, I'll throw in the obligatory plea. Is SELinux holding off for 2.4.5, or will we see a 2.4.4 version?

It depends on where the virus can attack. If the kernel had no buffer overflow
or programming oversights, it will help. The primary attack point are the
service daemons, which run with some elevated privileges.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
