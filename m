Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n46MDj0K001720
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 18:13:45 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n46MDi7e024417
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 22:13:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by tundra.namei.org (8.13.1/8.13.1) with ESMTP id n46MDYcw022049
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 18:13:35 -0400
Date: Thu, 7 May 2009 08:13:34 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole (fwd)
Message-ID: <alpine.LRH.2.00.0905070813020.21675@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like the google chrome folk are considering using SELinux if it's 
available.

---------- Forwarded message ----------
Date: Wed, 6 May 2009 14:46:02 -0700
From: "Markus Gutschke (???)" <markus@google.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
    Roland McGrath <roland@redhat.com>,
    Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
    linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org,
    sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole

On Wed, May 6, 2009 at 14:29, Ingo Molnar <mingo@elte.hu> wrote:
> That's a pretty interesting usage. What would be fallback mode you
> are using if the kernel doesnt have seccomp built in? Completely
> non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?

Ptrace has performance and/or reliability problems when used to
sandbox threaded applications due to potential race conditions when
inspecting system call arguments. We hope that we can avoid this
problem with seccomp. It is very attractive that kernel automatically
terminates any application that violates the very well-defined
constraints of the sandbox.

In general, we are currently exploring different options based on
general availability, functionality, and complexity of implementation.
Seccomp is a good middle ground that we expect to be able to use in
the medium term to provide an acceptable solution for a large segment
of Linux users. Although the restriction to just four unfiltered
system calls is painful.

We are still discussing what fallback options we have, and they are
likely on different schedules.

For instance, on platforms that have AppArmor or SELinux, we might be
able to use them as part of our sandboxing solution. Although we are
still investigating whether they meet all of our needs.


Markus
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
