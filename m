Date: Thu, 28 Jan 2010 14:56:45 +0300
From: AlannY <m@alanny.ru>
To: SELinux@tycho.nsa.gov
Subject: /dev on tmpfs. How to label?
Message-ID: <20100128115643.GA19986@alanny-pc.lcl.starlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there. I'm still trying to install SELinux on Archlinux. I've already done
step with /sbin/load_policy -i at initramfs. But now have another difficult to
solve problem.

Archlinux at boot time (at /etc/rc.sysinit) mount /dev at tmpfs so:

    /bin/mount -n -t tmpfs none /dev -o mode=0755

As you can see, nodes at /dev never have correct context, because they
are temporary created and at shutdown deleted.

I see there are 2 ways to solve:

  1. recrack Archlinux boot process and make not mount /dev at tmpfs.
  2. Somehow relabel all nodes created at boot.

What do you think about it? Is there any distro, which mounts /dev at tmpfs and have working SELinux?

Thanks for patience.
-- 
   )\._.,--....,'``.
  /,   _.. \   _\  (`._ ,.
 `._.-(,_..'--(,_..'`-.;.' 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
