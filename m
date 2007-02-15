Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1171547734.2891.16.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
	 <1171547734.2891.16.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:41:07 -0500
Message-Id: <1171564867.32574.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 14:55 +0100, Vincenzo Ciaglia wrote:
> Il giorno mer, 14/02/2007 alle 18.08 +0000, Christopher J. PeBenito ha
> scritto:
> 
> > You need a patched init to load the policy.  If no policy is loaded,
> > SELinux is disabled:
> 
> I finally patched everything with fedora's patch
> (pam,coreutils,sysvinit,openssh) for selinux-support and everything
> seems to be ok. 
> 
> Coreutils-6.7 now are selinux-ready:
> # ls -Z
> -rw-r--r--  root root unlabeled                        System.map
> drwxr-xr-x  root root unlabeled                        bin
> 
> So i tried to reboot my kernel.
> 
> I still can't get selinux enabled. I think that is still a sysvinit
> problem. Init still can't perform the /selinux mount.
> 
> Here the package patched and selinux-ready that i built:
> http://www.netwosix.org/selinux/sysvinit-2.85-selinux.tar.gz
> 
> I compiled it with the standard options: 
> 
> #  make -C src        
> #  make -C src install
> 
> I also created a script in the /etc/rc but nothing happened. Until init
> can't mount /selinux i can't use /selinux/enforce.
> 
> So i still have problems. Any suggestions? Am i missing something ?

If you boot your kernel with init=/bin/bash and try to manually mount
selinuxfs on /selinux, does it work?

Also, be warned that it is presently very difficult to find all of the
selinux-related bits in Fedora and apply them elsewhere; there may be
multiple patches in a single package that are selinux-related, they can
be relative to non-selinux patches in the same package, and they have
become increasingly intertwined with audit patches.  Which is why people
familiar with that code need to do some work to extract them, unify
them, clean them up, and re-base them to an upstream (if one exists).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
