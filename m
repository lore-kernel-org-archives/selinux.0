Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBRB21KP010010
 for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2016 06:02:01 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id 12915263186
 for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2016 12:01:46 +0100 (CET)
Date: Tue, 27 Dec 2016 12:01:45 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux <selinux@tycho.nsa.gov>
Subject: Domain of kernel module initalization code
Message-ID: <20161227120145.75ff429f@gentp.lnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

when a userspace program A (usually kmod or udev) instructs the kernel
to load a kernel module via the finit_module syscall, the kernel loads
the module into its address space and executes the initalization
routine provided by the module.

This initialization routine then runs in A's SELinux domain. While that
makes sense implementation-wise and is indeed what I'd expected (going
by my admittely fairly basic understanding of the SELinux internals),
I'm not sure whether this is how the kernel should behave.

For example, this behaviour is currently triggering a bug on my
systems: Since Linux 4.8, most graphics drivers need CAP_SYS_ADMIN
during their module initialization (due to what is probably a kernel
bug). Hence, loading them with udev works fine because my SELinux
policy allows udev to use this capability, but those modules can't be
loaded manually with kmod/modprobe.

I could of course work around that by granting kmod the 'self:capability
sys_admin' permission, but I'm reluctant to do this since kmod itself
does not require CAP_SYS_ADMIN for its operations.

Any thoughts on this matter?

Regards,
Luis Ressel
