Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T4rNgA027549
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 00:53:25 -0400 (EDT)
Received: from go4.ext.ti.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T4lVC2001257
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 04:47:31 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SELinux for embedded devices...
Date: Fri, 29 Jul 2005 10:17:18 +0530
Message-ID: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
From: "Sriram, Kannan" <ksriram@ti.com>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Lorenzo,

 First of all, thanks for the tip and insights!

> Also, what do you mean my "tamper-proof" in this context? Physically
> protecting the chip which serves as storage for it? That sounds strange.

By tamper-proofing, I mean that the kernel image that is on the flash device cannot be altered - any image on the flash (bootloader, kernel, etc) carries a cryptographically signed certificate (by the OEM of the phone, using private key, of a public/ private pair), and the system does not boot up if the certificate of the image is invalid. A "trust chain" is constructed this way - boot ROM (not alterable) authenticates the boot loader, boot loader then authenticates the kernel and so on...

> Under SELinux root is just another user with access to certain roles. Be
> them user_r or sysadm_r, doesn't matter, it's all your choice and you
> can turn root into a non privileged user.

Are their any caveats to this? If I can make the root to be a non-privileged user, how can kernel modules be insmod'ed? Sorry, I know I can dig through the sources and find out how this is handled, but any handholding at this study stage (for me) would be very helpful. Should I be creating one more privilege level and assign it to a "central authority", purely for dealing with the setup and configuration of the security policies itself (for example, the network operator/carrier or some such entity)? Pls note that we are trying to make the person with "physical access to the system" to be able to do whatever a "privileged user" can do, but at the same time, just not give enough power for configuration of the security policy itself, without authorization.

> The problem of NAND flash chips and other flash memory components is
> that they have a limited writable times. Hence, the use of specific file
> systems is needed in order to *not* reach such limit in a short period
> of time.
Does SELinux require a writeable filesystem always? What if I want to use CRAMFS which is a ReadOnly system? Also, do you think that filesystem related issues will be the most important issues to live with? I'm asking this because there are only a countable number of FS variants for embedded systems AFAIK, so we can *maybe* take them on one at a time.

Thanks,
Sriram.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
