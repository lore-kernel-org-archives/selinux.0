Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MIPDrT003867
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 14:25:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MIP9WF020766
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 18:25:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: fuse
Date: Thu, 23 Sep 2004 04:24:55 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040922005509.GD14303@lkcl.net>
In-Reply-To: <20040922005509.GD14303@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409230424.55524.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Sep 2004 10:55, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> has anyone thought about how fuse (file system in userspace) would fit
> in with selinux?

In what way would it be different from any other file system?

Naturally you would need appropriate policy for the proxy program, but that 
should not be difficult to write.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
