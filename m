Subject: Re: problem about boot
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <001f01c398e2$c9efe980$5d38a8c0@lky>
References: <006c01c398a0$5f436ef0$5d38a8c0@lky>
	 <1066929761.22348.17.camel@moss-tarheels.epoch.ncsc.mil>
	 <001f01c398e2$c9efe980$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1066951180.22348.31.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 Oct 2003 19:19:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You need new modutils for the 2.6 kernel.  You can get them from
http://www.kernel.org/pub/linux/kernel/people/rusty/modules
(I'd suggest using the SRPM at the bottom of the list).

You also need to change /etc/rc.d/rc.sysinit to make the modules load
automatically.  See the "Modules" section of:
http://www.codemonkey.org.uk/post-halloween-2.5.txt

And looking ahead, once you get the 2.6 kernel working, rpm is not going
to work.  To fix that, see the "Regressions" section of the same
document.

--Eamon

On Wed, 2003-10-22 at 17:23, lky wrote:
> > Your kernel must be configured with built-in ext3 support if your root
> > partition is ext3.
> > 
> > --Eamon
> 
> Right!I had configured the ext3 as a module at first.
> Then I configured my kernel again with ext3 built-in the kernel.But when I make modules_install I found the following messages:
> -------------------------------------------------------------------
> depmod: QM_MODULES: Function not implemented
> 
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/eni.ko
> depmod:  suni_init
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/idt77252.ko
> depmod:  suni_init
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/iphase.ko
> depmod:  suni_init
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/nicstar.ko
> depmod:  suni_init
> depmod:  idt77105_init
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/atm/zatm.ko
> depmod:  uPD98402_init
> depmod: *** Unresolved symbols in /lib/modules/2.6.0-test6-selinux1/kernel/drivers/block/paride/aten.ko
> depmod:  pi_register
> ...........
> ---------------------------------------------------------------------
> However the installation didn't stop.This time I can reboot with the new kernel. But I found many modules such as my network card and loopback device can't be automatically loaded to work .Why can't I configure them as modules now? I can do that with 2.4 kernels before.
> Thanks!
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Eamon Walsh <ewalsh@epoch.ncsc.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
