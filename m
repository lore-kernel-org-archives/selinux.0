Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i527JYrT002335
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 03:19:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i537JHeD021954
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 03:19:18 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: dpkg-reconfigure xserver-xfree86
Date: Wed, 2 Jun 2004 17:19:29 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040601122114.GI8312@lkcl.net>
In-Reply-To: <20040601122114.GI8312@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406021719.29724.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Jun 2004 22:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> ah ha, you missed one :)
>
> i frequently use dpkg-reconfigure xserver-xfree86 to reconfig X.

This is why there is se_dpkg-reconfigure .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
