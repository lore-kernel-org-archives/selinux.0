Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAK3tlRb021800
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:55:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAK3tkqY010509
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 03:55:46 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAK3tg0o010505 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 03:55:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "samwun" <samwun@hgcbroadband.com>, "'SELinux ML'" <selinux@tycho.nsa.gov>
Subject: Re: where to download LSM-patched 2.4
Date: Thu, 20 Nov 2003 14:55:29 +1100
References: <029a01c3af19$4d549d60$5801a8c0@samgpj2wzuimme>
In-Reply-To: <029a01c3af19$4d549d60$5801a8c0@samgpj2wzuimme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311201455.29570.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Nov 2003 14:49, "samwun" <samwun@hgcbroadband.com> wrote:
> I found that command "make install" failed in selinux 2.6 kernel source:
>
> # make install
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
> Kernel: arch/i386/boot/bzImage is ready
> sh /usr/local/linux-2.6/arch/i386/boot/install.sh 2.6.0-test6-selinux1
> arch/i386/boot/bzImage System.map ""
> No module advansys found for kernel 2.6.0-test6-selinux1

This is a problem with the kernel build proceedure not with SE Linux as such.  
Generally you want to follow the usual proceedures for building a kernel 
package for your OS but have the SE Linux options enabled.  This has been 
tested to work with both Debian and Red Hat kernel images.

I suggest that as a first step you build a kernel without SE Linux.  Once you 
get that working you can then move on to getting SE Linux working.  The 
changes from 2.4.20 to 2.6.0 are immense and you can expect your first 
attempt to not be successful regardles of SE Linux.

Probably the best thing to do is to ask for help at your local Linux Users 
Group.

> image=/boot/vmlinuz-2.6.0-test6-selinux1
>         label=selinux2.6
>         initrd=/boot/initrd-2.4.20-8.img

That would not work because a 2.6.0 kernel can not load modules from a 2.4.20 
kernel.  You have to create an initrd for 2.6.0-test6 or build a kernel that 
does not need an initrd.

Recently I have ceased using initrd's on my machines.  The range of hardware 
that I own is not large enough to justify an initrd so I just compile in 
every driver that may be needed for booting any of my machines.  It makes 
things a lot easier to manage.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
