Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9T5N2Wt005197
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 00:23:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9T5MjIS013629
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 05:22:45 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id h9T5MhDc013626
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 05:22:44 GMT
Message-ID: <000701c39dde$236a85b0$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "SELINUX" <SELinux@tycho.nsa.gov>, "Eric Estabrooks" <eric@urbanrage.com>
References: <003b01c39d8d$5ead9690$5d38a8c0@lky> <3F9F091C.5090505@urbanrage.com>
Subject: Re: question about 2.6 modules
Date: Wed, 29 Oct 2003 13:33:05 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wednesday, October 29, 2003 8:26 AM,Eric Estabrooks wrote:

> do the modules have .ko instead of .o? the 2.6 kernel modules now need
> to end in .ko to be automatically loaded, and it is just a name
> difference. I had this problem with some modules that I had compiled for
> 2.6 and I just renamed them and depmod'd and they worked fine.

I have all my ordered modules with .ko and I can load them with modprobe from command line.But the modules can't be automatically loaded when I run the associated commands. For example,I have built the vfat filesystem as a module and the system also created the vfat.ko file.But when I reboot the new kernel and run 'mount /dev/hda6 /mnt' it said the kernel don't support vfat filesystem.(/dev/hda6 is a vfat section) However I can run 'modprobe vfat' to load the vfat module.
I have modified the /etc/rc.sysinit and just let '/proc/sys/kernel/modprobe' replaced by '/sbin/modprobe'. Did it have some problems?
Thanks!
lky


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
