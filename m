Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171476502.20576.35.camel@sgc.columbia.tresys.com>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:55:34 +0100
Message-Id: <1171547734.2891.16.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno mer, 14/02/2007 alle 18.08 +0000, Christopher J. PeBenito ha
scritto:

> You need a patched init to load the policy.  If no policy is loaded,
> SELinux is disabled:

I finally patched everything with fedora's patch
(pam,coreutils,sysvinit,openssh) for selinux-support and everything
seems to be ok. 

Coreutils-6.7 now are selinux-ready:
# ls -Z
-rw-r--r--  root root unlabeled                        System.map
drwxr-xr-x  root root unlabeled                        bin

So i tried to reboot my kernel.

I still can't get selinux enabled. I think that is still a sysvinit
problem. Init still can't perform the /selinux mount.

Here the package patched and selinux-ready that i built:
http://www.netwosix.org/selinux/sysvinit-2.85-selinux.tar.gz

I compiled it with the standard options: 

#  make -C src        
#  make -C src install

I also created a script in the /etc/rc but nothing happened. Until init
can't mount /selinux i can't use /selinux/enforce.

So i still have problems. Any suggestions? Am i missing something ?

Thank you in advance!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
