Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25386
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 13:31:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA18833
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 18:30:56 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA18829 for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 18:30:55 GMT
Date: Wed, 27 Feb 2002 13:30:43 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <wakkerma@debian.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: straceing SE Linux
In-Reply-To: <20020227182506.47225134A4@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202271327520.12300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Feb 2002, Russell Coker wrote:

> From inspecting the kernel code and the strace it appears that socketcall
> doesn't get processed the way you might expect.  It appears that for every
> function that works with socketcall() there is a separate system call for it.
>  So when I strace a socket program on my system it displays the socket(),
> connect() etc because those system calls are called directly.  It appears
> that my libc does not use socketcall()!  I could not find any special
> handling in the strace source for socketcall, it appears that socketcall()
> will be displayed as such!

If you look at arch/i386/kernel/entry.S in the kernel tree, you'll see
that there are no entrypoints for the individual socket calls.  Just for
sys_socketcall.  Similarly for the System V IPC system calls - they are
all multiplexed through sys_ipc.  It is true that there are separate
library functions for the different calls, but not different system calls.
You won't find any definitions for connect and friends in
include/asm-i386/unistd.h either.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
