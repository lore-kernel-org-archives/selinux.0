Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D4KArT007211
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:20:10 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D4Jn5V019131
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 04:19:49 GMT
Subject: RE: vsftpd with SELinux
Date: Tue, 13 Jul 2004 00:20:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <E6E16A6D4277CD459BBDE6713766033C92A51D@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That's kind of the problem I tail the messages file and don't get an AVC
message.  I'll double check though.

James

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Monday, July 12, 2004 11:42 PM
To: James R. Marcus
Cc: selinux@tycho.nsa.gov
Subject: Re: vsftpd with SELinux

On Tue, 13 Jul 2004 11:49, "James R. Marcus" <jmarcus@mvalent.net>
wrote:
> I just emerged vsftpd on my new Hardened Gentoo system running the
> SELinux kernel.  I think I have configured it correctly but keep
running
> into this issue:

What AVC messages do you get in the kernel message log?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
