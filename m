Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09274
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 16:54:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA26091
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 21:52:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA26087 for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 21:52:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: azeredo@qmc.ufsc.br, selinux@tycho.nsa.gov
Subject: Re: Selinux on RH8
Date: Tue, 5 Nov 2002 22:22:43 +0100
References: <1036528113.3dc829f18bb9c@qmc.ufsc.br>
In-Reply-To: <1036528113.3dc829f18bb9c@qmc.ufsc.br>
MIME-Version: 1.0
Message-Id: <200211052222.43780.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 5 Nov 2002 21:28, azeredo@qmc.ufsc.br wrote:
>  Thank you guys for the help. But i still got some problems. I did
>
> make relabel after adding the Wasterman lines for the postfix policy and
> reboot and got the following messages:
>
> Activating swap partitions
> /etc/rc.d/rc.sysinit: line 318 /etc/mtab: Read-only file system
> /etc/rc.d/rc.sysinit: line 324 Segmentation fault mount -f
> touch: creating '/var/lock/subsys/network/ ' Read-only file system

Sounds like the process of mounting the root file system read-write after fsck 
broke somehow.  Run "dmesg | grep avc" to see the information on the things 
that SE Linux prevented then post the bits that seem relevant here and we can 
probably advise you on what might need to be changed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
