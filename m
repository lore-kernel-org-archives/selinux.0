Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3D68Rb021005
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 08:06:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3D67qY013332
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:06:07 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB3D650o013325 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:06:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nicholas Mucci <nmucci@eecs.ku.edu>, selinux@tycho.nsa.gov
Subject: Re: machine check exception
Date: Thu, 4 Dec 2003 00:05:54 +1100
References: <20031203043334.S1461@tesla.eecs.ku.edu>
In-Reply-To: <20031203043334.S1461@tesla.eecs.ku.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312040005.54935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Dec 2003 22:05, Nicholas Mucci <nmucci@eecs.ku.edu> wrote:
>         Recently I installed the 2.6.0-test6-selinux1 kernel on my box and
> noticed that it will occassionally throw a machine check exception after
> detecting IDE devices on startup.  I never saw this occur with the
> 2.6.0-test3 selinux kernel, 2.4.18 from RedHat 8, 2.4.9 or 2.4.8 on this

Does this only happen when running SE Linux?  What happens when SE Linux is 
compiled in but not enabled (boot with selinux=0)?  What happens when SE 
Linux is not compiled in?

If the problem occurs when SE Linux is not compiled in to the kernel then it 
is something that is best discussed on the linux-kernel mailing list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
