Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: distribution of kernel patches
Date: Sat, 29 Sep 2001 00:19:26 +0200
Cc: SELinux@tycho.nsa.gov
References: <Pine.SOL.3.95.1010928142221.624Q-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010928142221.624Q-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <20010928221926.56C2236A0E7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Sep 2001 20:50, Stephen Smalley wrote:
> On Fri, 28 Sep 2001, Russell Coker wrote:
> > I believe that the current method of distributing the kernel code could
> > be improved by supplying it as either a single patch, or a tar file with
> > a tiny patch.
>
> One of the current download options (Option 3, Everything but Kernel
> Source) allows you to download the LSM kernel patch against 2.4.10 and the
> SELinux archive.  The SELinux archive includes a small patch to the LSM
> security/Makefile and security/Config.in files to add an option for
> building the SELinux kernel module into the kernel, but it doesn't include
> any patches to the kernel source code.  The SELinux code is a kernel
> module.  I suppose we could "merge" our small Makefile/Config.in patch and
> our kernel module directly into the version of the LSM kernel patch
> distributed from the NSA site, but I would prefer to keep the LSM kernel
> patch "pure" relative to some snapshot of the LSM kernel patch from
> lsm.immunix.org.  And, of course, if the LSM kernel patch is adopted into
> 2.5, we will no longer need to distribute it at all, so we would naturally
> still need the small patch and kernel module in our separate archive.

I agree that keeping the LSM kernel patch separate is a good idea.  I have 
just discovered that the LSM patch on the site is not the upstream 2001_09_26 
version, but the previous version plus some CVS patches.  I think that it 
would be beneficial to have an original upstream release of LSM with an 
additional patch.  Currently there is an LSM patch on the NSA site with a 
version number implying (to me at least) that it is the same as the current 
LSM upstream release.

Now for the kernel patch for selinux I was not requesting that it be merged 
into a single patch with the LSM code (that's the last thing I want).  What I 
would like is a single unified diff containing all the selinux kernel code 
without any LSM code.  So the proceedure should be:
Extract upstream kernel source.
Apply upstream LSM patch.
Apply SE Linux LSM add-on patch for CVS LSM code.
Apply SE Linux kernel patch.
Compile.

> > The current situation of having a Makefile which applies a patch, creates
> > sym-links, etc makes it virtually impossible to automatically do anything
> > with the code.  This means I can't use pure upstream source in my
> > kernel-patch package which adds a risk of error, and makes it more
> > difficult for anyone who wants to audit my work.
>
> As mentioned above, the selinux module Makefile only patches the
> security/Makefile and security/Config.in files.  It also sets up some
> symbolic links used internally by the kernel module.  It isn't clear
> as to how this is an obstacle to using the pure kernel sources.

Yes, I can write a script that runs that script on a directory containing the 
security sub-directory from the LSM patch and then generates a unified diff 
containing the minor patch to the LSM security sub-directory and the 
security_plugin sub-dir.  But it's painful, nasty, more error prone than 
other methods of achieving the same result, and it makes things more 
difficult for anyone who wants to audit my work (much easier if they can just 
see me using files from the NSA site and move on to the next item in the 
check list).

Another issue is that the kernel module doesn't get generated in the same way 
as other modules.  I've got 246 regular kernel modules in my kernel build and 
an SE Linux module that has to be compiled differently.  I think it would 
really make sense to have the same y/n/m question as for other modules.

The current proceedure for compiling the SE Linux module requires me to do 
one of two things to create a Debian kernel package:
1)  Create a separate package containing only the module for SE Linux (which 
seems hardly worth-while).
2)  Hack the kernel package creation scripts to run the SE Linux module build 
command, or alternatively hack the SE Linux patch to work in the regular 
fashion.

Neither of these options is ideal IMHO.

> > Also could the kernel patch please change the EXTRAVERSION variable in
> > the top-level makefile?  Currently the kernel-patch package I am playing
> > with changes it from "-lsm" to "-selinux", but it would be equally valid
> > to change it to "-lsm-selinux" instead.  I believe that a change to the
> > EXTRAVERSION is necessary for anyone who is attempting to manage kernel
> > builds for dis-similar machines.  The results of installing a non-SE
> > kernel when you want a SE kernel or of installing a SE kernel when you
> > want a non-SE kernel are both unpleasant!
>
> I suppose we could change the EXTRAVERSION, but I'm not sure why.
> The kernel itself is just the LSM kernel.  The SELinux code is a kernel
> module.  You don't typically change the EXTRAVERSION for kernel modules.

However there is the option to compile the module into the kernel, in which 
case it is not a regular kernel and will not successfully boot a system 
without the rest of the SE code installed.

That is a good point though.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
