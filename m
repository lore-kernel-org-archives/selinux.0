Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D3gbrT007014
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 23:42:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D3gYPJ003427
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 03:42:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "James R. Marcus" <jmarcus@mvalent.net>
Subject: Re: vsftpd with SELinux
Date: Tue, 13 Jul 2004 13:42:27 +1000
Cc: <selinux@tycho.nsa.gov>
References: <E6E16A6D4277CD459BBDE6713766033C92A4FA@exchange.mvalent.local>
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033C92A4FA@exchange.mvalent.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407131342.27724.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jul 2004 11:49, "James R. Marcus" <jmarcus@mvalent.net> wrote:
> I just emerged vsftpd on my new Hardened Gentoo system running the
> SELinux kernel.  I think I have configured it correctly but keep running
> into this issue:

What AVC messages do you get in the kernel message log?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
