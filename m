Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4IJ8DI4000727
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 15:08:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4IJ8CtV028588
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 19:08:12 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4IJ7xal028585 for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 19:08:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Torsten Knodt <tk-selinux@datas-world.de>, selinux@tycho.nsa.gov
Subject: Re: Creating a new lsm function
Date: Mon, 19 May 2003 05:06:18 +1000
References: <200305181856.22022.tk-selinux@datas-world.de>
In-Reply-To: <200305181856.22022.tk-selinux@datas-world.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305190506.18495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 May 2003 02:50, Torsten Knodt wrote:
> I'd like to create two new function's, which fill a buffer with lsm
> informations about an interface/ a socket. Both will simply give back the
> context. Also, for this two, a function will return a title for these
> fields. These function will be used to print out these informations in
> /proc/net/tcp, ... to be read by net-tools.

The idea is to have netstat display the security context.

> Can someone give me a hint, where this has to be implemented to be
> independent of the used security module?

When 2.6.0 comes out with xattr being used in a consistant fashion for file 
system and process labelling and this being done in a text form it will 
hopefully be possible to make such things consistant across different 
modules.

I don't think that there's much chance of it for 2.4.x, all of the kernel 
programmers who are involved appear to be spending the vast majority of their 
time on 2.5.x.  I don't think that there's much interest in doing anything 
big for 2.4.x, so anything that gets done will be based on SIDs for SE Linux 
which means that they won't be consistant across modules.


PS  Have you tried playing with SE Linux and 2.5.x yet?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
