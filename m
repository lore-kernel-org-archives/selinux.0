Date: Fri, 28 Sep 2001 14:50:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: distribution of kernel patches
In-Reply-To: <20010928180800.00E31334E9@lyta.coker.com.au>
Message-ID: <Pine.SOL.3.95.1010928142221.624Q-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 28 Sep 2001, Russell Coker wrote:

> I believe that the current method of distributing the kernel code could be
> improved by supplying it as either a single patch, or a tar file with a tiny
> patch.

One of the current download options (Option 3, Everything but Kernel
Source) allows you to download the LSM kernel patch against 2.4.10 and the 
SELinux archive.  The SELinux archive includes a small patch to the LSM 
security/Makefile and security/Config.in files to add an option for 
building the SELinux kernel module into the kernel, but it doesn't include 
any patches to the kernel source code.  The SELinux code is a kernel 
module.  I suppose we could "merge" our small Makefile/Config.in patch and 
our kernel module directly into the version of the LSM kernel patch
distributed from the NSA site, but I would prefer to keep the LSM kernel 
patch "pure" relative to some snapshot of the LSM kernel patch from 
lsm.immunix.org.  And, of course, if the LSM kernel patch is adopted into
2.5, we will no longer need to distribute it at all, so we would naturally
still need the small patch and kernel module in our separate archive.

> Most kernel code is distributed in the form of a unified diff.  This form is
> easy to separate from other related code (often we need kernel code and
> user-space code separate for compilation on different machines).  It is easy
> to manipulate in scripts (such as for the Debian packages I am preparing),
> and is easy to combine with other patches.

> A tar file and a small patch would also be easy to deal with.

Option 3 provides the LSM kernel patch and a gzipped tar file.

> The current situation of having a Makefile which applies a patch, creates
> sym-links, etc makes it virtually impossible to automatically do anything
> with the code.  This means I can't use pure upstream source in my
> kernel-patch package which adds a risk of error, and makes it more difficult 
> for anyone who wants to audit my work.

As mentioned above, the selinux module Makefile only patches the 
security/Makefile and security/Config.in files.  It also sets up some
symbolic links used internally by the kernel module.  It isn't clear
as to how this is an obstacle to using the pure kernel sources.

> Also could the kernel patch please change the EXTRAVERSION variable in the 
> top-level makefile?  Currently the kernel-patch package I am playing with 
> changes it from "-lsm" to "-selinux", but it would be equally valid to change 
> it to "-lsm-selinux" instead.  I believe that a change to the EXTRAVERSION is 
> necessary for anyone who is attempting to manage kernel builds for 
> dis-similar machines.  The results of installing a non-SE kernel when you 
> want a SE kernel or of installing a SE kernel when you want a non-SE kernel 
> are both unpleasant!

I suppose we could change the EXTRAVERSION, but I'm not sure why.
The kernel itself is just the LSM kernel.  The SELinux code is a kernel
module.  You don't typically change the EXTRAVERSION for kernel modules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
