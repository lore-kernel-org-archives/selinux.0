Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i93F8krT012898
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 11:08:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i93F8hqH019257
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 15:08:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: need advice for ld_so_cache_t errors
Date: Mon, 4 Oct 2004 01:08:35 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain>
In-Reply-To: <20041002165041.GB30426@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410040108.35839.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 3 Oct 2004 02:50, Greg Norris <haphazard@kc.rr.com> wrote:
> Could you check one of your Debian machines, and see if "execute" is
> being included somehow?  I'm not sure how we'd have different results,
> tho, as I'm using your selinux-policy-default package (1.14-2).

I've just run apol from setools and it tells me that no execute access is 
being granted.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
