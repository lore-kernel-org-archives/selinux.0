Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VNF4Ha006286
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 19:15:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VNF3DW028920
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 23:15:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6VNF2eN028917 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 23:15:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Hariharan Gopalan" <hari@sapta.com>, <selinux@tycho.nsa.gov>
Subject: Re: Error while installing:
Date: Fri, 1 Aug 2003 09:14:47 +1000
References: <MBEOIIDPALLENBNPLKLCAEPMHOAA.hari@sapta.com>
In-Reply-To: <MBEOIIDPALLENBNPLKLCAEPMHOAA.hari@sapta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308010914.47606.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Aug 2003 04:55, Hariharan Gopalan wrote:
> I did not get the same error when I moved inetd.te,

That was due to a bug in ftpd.te which I have fixed in my tree.

> but got another error
> for xserver.te, and that also went away when I removed xserver.

Please tell me what the error was and I'll fix it too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
