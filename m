Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAU3ZiRb001930
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 22:35:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAU3ZhqY006529
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 03:35:43 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAU3Zg0o006526 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 03:35:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nick <nagray@austin.rr.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re:
Date: Sun, 30 Nov 2003 14:35:29 +1100
References: <1070143772.4562.253.camel@hawaii>
In-Reply-To: <1070143772.4562.253.camel@hawaii>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311301435.29525.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 30 Nov 2003 09:09, Nick <nagray@austin.rr.com> wrote:
> I seem to have lost usage of Kudzu (Actually it still runs but cannot
> see the printer on the parallel port) after installing SELinux. Is this
> a known issue?
>
> I am running in permissive mode. Any suggestions?

If you are running in permissive mode then SE Linux should not change the 
operation of kudzu.

What kernel version were you using before installing SE Linux, and what kernel 
version are you using now?  Did you upgrade from 2.4 to 2.6?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
