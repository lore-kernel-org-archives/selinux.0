Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87ExKrT026895
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 10:59:21 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87ExJll013594
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 14:59:19 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i87Exw0c005601
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 10:59:58 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i87Exw2G005600
	for selinux@tycho.nsa.gov; Tue, 7 Sep 2004 10:59:58 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
Date: Sat, 4 Sep 2004 18:49:09 +1000
Cc: Linas Vepstas <linas@austin.ibm.com>, Nigel Kukard <nkukard@lbsd.net>,
   SELinux <SELinux@tycho.nsa.gov>
References: <20040830173744.GD10151@lbsd.net> <200409022215.20830.russell@coker.com.au> <20040902170734.GA9645@austin.ibm.com>
In-Reply-To: <20040902170734.GA9645@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409041849.09954.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Sep 2004 03:07, Linas Vepstas <linas@austin.ibm.com> wrote:
> Well, here's another idle question, again off-topic: Does SELinux provide
> any sort of assurances that storage media weren't tampered with between
> reboots?

No, that is outside the scope of the SE Linux project.

I am one of the many people in Red Hat who are involved in working on crypto 
block device support.  One of my own systems has a root file system that is 
AES encrypted with the kernel and initrd (which includes the decryption key) 
on removable media.  Eventually I want to see this become a standard feature 
of Fedora, maybe in FC4.  I think it will address most of what you want in 
this regard.

Note that the NSA guys do not talk to me about any security stuff, so I don't 
expect them to have any involvement in such things.

> For example, with BIOS/firmware getting more sophisticated over time,
> there's potential for an attacker to break in, remotely, into
> bios/firmware, shortly before booting into the OS, and then alter
> disk contents.  Yes, I know this is far-fetched, but was just curious.

When booting from removable media that contains the decryption key the attack 
scenario would be to replace the BIOS with one that sends everything it reads 
from disk (IE everything that the boot loader reads) over an Ethernet 
interface.

A trojan BIOS that modifies the kernel during the boot load process to 
introduce a security hole would be doable if you have adequate resources.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
