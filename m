Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h43HY4I4021736
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 13:34:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h43HY27R011004
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 17:34:02 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h43HY0KP011001 for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 17:34:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wesley Parish <wes.parish@paradise.net.nz>, selinux@tycho.nsa.gov
Subject: Re: Support for XWindows ?
Date: Sun, 4 May 2003 03:33:01 +1000
References: <20030503004232.1113.qmail@web20805.mail.yahoo.com> <200305031551.14261.russell@coker.com.au> <200305031022.50946.wes.parish@paradise.net.nz>
In-Reply-To: <200305031022.50946.wes.parish@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305040333.01369.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 May 2003 08:22, Wesley Parish wrote:
> I'm thinking of setting up a spare box for use with selinux as a
> spam-culler

Sounds like a good idea.  One significant advantage of SE Linux for such 
applications is that it reduces the chance of a bug in an application being 
exploitable, and therefore increases the length of time that a machine may be 
running on the net unattended.  Naturally leaving a machine on the net 
without monitoring it is not recommended, but it's the typical practise for 
firewall type devices (and no-one seems to want to pay extra for management).

> I hadn't realized that you already had working policies for X-Window.  That
> does encourage me!

Why would you want X on a firewall?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
