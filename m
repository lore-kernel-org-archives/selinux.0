Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NLErWt012348
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 17:14:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9NLEqIE028785
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:14:52 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id h9NLEo1J028781 for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:14:50 GMT
Message-ID: <001f01c398e2$c9efe980$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "Eamon Walsh" <ewalsh@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <006c01c398a0$5f436ef0$5d38a8c0@lky> <1066929761.22348.17.camel@moss-tarheels.epoch.ncsc.mil>
Subject: Re: problem about boot
Date: Thu, 23 Oct 2003 05:23:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Your kernel must be configured with built-in ext3 support if your root
> partition is ext3.
> 
> --Eamon

Right!I had configured the ext3 as a module at first.
Then I configured my kernel again with ext3 built-in the kernel.But when I make modules_install I found the following messages:
-------------------------------------------------------------------
depmod: QM_MODULES: Function not implemented

depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/eni.ko
depmod:  suni_init
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/idt77252.ko
depmod:  suni_init
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/iphase.ko
depmod:  suni_init
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/nicstar.ko
depmod:  suni_init
depmod:  idt77105_init
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/zatm.ko
depmod:  uPD98402_init
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/block/paride/aten.ko
depmod:  pi_register
...........
---------------------------------------------------------------------
However the installation didn't stop.This time I can reboot with the new kernel. But I found many modules such as my network card and loopback device can't be automatically loaded to work .Why can't I configure them as modules now? I can do that with 2.4 kernels before.
Thanks!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
