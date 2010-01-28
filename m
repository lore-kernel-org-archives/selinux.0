Subject: Re: /dev on tmpfs. How to label?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100128115643.GA19986@alanny-pc.lcl.starlink.ru>
References: <20100128115643.GA19986@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Thu, 28 Jan 2010 08:29:18 -0500
Message-Id: <1264685358.6232.38.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-28 at 14:56 +0300, AlannY wrote:
> Hi there. I'm still trying to install SELinux on Archlinux. I've already done
> step with /sbin/load_policy -i at initramfs. But now have another difficult to
> solve problem.
> 
> Archlinux at boot time (at /etc/rc.sysinit) mount /dev at tmpfs so:
> 
>     /bin/mount -n -t tmpfs none /dev -o mode=0755
> 
> As you can see, nodes at /dev never have correct context, because they
> are temporary created and at shutdown deleted.
> 
> I see there are 2 ways to solve:
> 
>   1. recrack Archlinux boot process and make not mount /dev at tmpfs.
>   2. Somehow relabel all nodes created at boot.
> 
> What do you think about it? Is there any distro, which mounts /dev at tmpfs and have working SELinux?

Most distros do that these days, and it works fine in Fedora, for
example.

The technique used in Fedora is to run restorecon -R /dev from
rc.sysinit to set the contexts on the /dev nodes set up before the
policy load, and udev is already SELinux-aware (if built with SELinux
support enabled) and should label any dynamically created nodes
appropriately once SELinux policy has loaded.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
