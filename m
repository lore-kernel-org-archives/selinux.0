Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13288
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2001 09:19:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23954
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2001 13:18:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA23950
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2001 13:18:37 GMT
Date: Wed, 19 Sep 2001 09:18:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carlos Cardenas <ccardena@cs.utsa.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: UltraSparc
In-Reply-To: <Pine.GSO.3.95.1010918171342.1734B-100000@ten46>
Message-ID: <Pine.SOL.3.95.1010919084244.18976B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 18 Sep 2001, Carlos Cardenas wrote:

> Has there been any successfull attempt for SELinux on an UltraSparc?

Not as far as I know, but it shouldn't be difficult to port the 
architecture-specific code of LSM and SELinux to other architectures.
Someone ported the architecture-specific code of the original SELinux
prototype to the PPC a while back without any real difficulty, and it
shouldn't be any harder using the new LSM-based SELinux prototype.

There are a small number of architecture-specific changes in the LSM
kernel patch that have only been made for the x86 and ia64 architectures
so far.  Specifically, LSM adds a general security system call to support
new system calls by security modules (see the changes to
lsm/arch/i386/kernel/entry.S and lsm/include/asm-i386/unistd.h) and it
inserts security hooks into the code of a few system calls in the
architecture-specific directories (see the changes to
lsm/arch/i386/kernel/ioport.c and lsm/arch/i386/kernel/ptrace.c).
And you'll need to add a 'source security/Config.in' to the
arch/*/config.in file for your desired architecture.  If you port
these changes to another architecture, please feed them back to
the LSM project - see their web site at lsm.immunix.org.

The SELinux kernel module also contains a little architecture-specific 
code in selinux/module/selinux_plug/include/asm-i386/flask/unistd.h and 
selinux/module/selinux_plug/arch/i386/syscalls.c.  This code is to 
implement one additional system call, execve_secure, that I wasn't able to
successfully implement using the general security system call.  This is an
extended version of execve that also passes the requested security
identifier to use for the transformed process, invoked by some of our
modified daemons and utilities.  If you port the architecture-specific
version of execve_secure to another architecture, then please feed it back
to us.

Another option would be to try using the architecture-independent version
of execve_secure (in selinux/module/selinux_plug/syscalls.c) by leaving
USE_MD_EXECVE (use machine-dependent execve_secure) undefined in
the include/asm-XXX/flask/unistd.file for your architecture.  This was an
attempt to use the general security system call to implement 
execve_secure (thus avoiding any architecture-specific code in the
SELinux kernel module), but it returns the wrong error code when used
to probe the path for some unknown reason, and I haven't tracked down the
problem yet.  See the comment before the syscalls.c:sys_execve_secure.

As a side note, please be aware that a number of important bug fixes and
improvements have been made to both LSM and SELinux since the August 23rd
release of SELinux, so I would expect that we are likely to make a new
release soon.  I would have pushed for a new release already, but we've
been waiting for 2.4.10.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
