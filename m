Date: Tue, 11 Dec 2001 16:02:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: James Harrison <jlharris_mail@fimble.com>
cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Other Architecture Support...
In-Reply-To: <1008100411.6507.11.camel@humboldt>
Message-ID: <Pine.GSO.4.33.0112111515520.19311-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 11 Dec 2001, James Harrison wrote:

> I was wondering if their is any plan to port this patch to other
> architectures.  Specifically the Power PC arch.
>
> If not, if I was to work on porting the patch to the PPC arch would the
> changes be folded into this secure linux patch?

A SELinux user ported the architecture-specific code of the original
SELinux kernel patch to the PPC a long time ago (see the mailing list
archives, easily searcheable at http://marc.theaimsgroup.com/?l=selinux).
However, as I recall, he also had to merge a number of patches for the PPC
that weren't related to SELinux in order to get it working, and it was
consequently never merged into our tree.  But you might want to ask
him for it and use it for reference.

SELinux was subsequently reworked to use the LSM kernel patch, which
was jointly developed by several Linux security projects (see
http://lsm.immunix.org).  Hence, to port SELinux to another architecture
now, you will need to port the architecture-specific changes in the LSM
kernel patch and the architecture-specific code in the SELinux security
module.  The port for the LSM kernel patch should be submitted to the LSM
project's mailing list, not here.  The port for the SELinux module code
can be submitted on this list, and I would expect that we would merge it.

There are a small number of architecture-specific changes in the LSM
kernel patch that have only been made for the x86 and ia64 architectures
so far.  The LSM kernel patch adds a new security system call (which is now
reserved in the main Linux kernel for the x86 architecture, but not for
other architectures), and it inserts security hooks into the code of a few
system calls in the architecture-specific directories.  See the LSM
changes to arch/i386/kernel/entry.S, arch/i386/kernel/ioport.c, and
arch/i386/kernel/ptrace.c.  You will need to add the new security system
call to the PPC architecture, and it would be best if you submit a patch
reserving the call to the PPC maintainer so that it isn't later used for
some other purpose in the main PPC tree.

The SELinux security module also contains a small amount of
architecture-specific code related to the new system calls in the
arch/i386/syscalls.c and include/asm-i386/flask/unistd.h files under the
security/selinux directory.  Notice that the Makefile sets up arch/machine
and include/asm symlinks appropriately during the 'make dep', so you can
simply add new arch/ppc and include/asm-ppc directories with your
port of these files.  This architecture-specific code is to support
the execve_secure system call and for the 64-bit variants of the
stat_secure calls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
