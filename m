Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MGjaI4022460
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:45:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4MGjCuO021291
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 16:45:12 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4MGj5lV021288
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 16:45:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: pxe, tftpd and rsync policies
Date: Fri, 23 May 2003 02:43:32 +1000
References: <20030522154816.C6588@lemuria.org>
In-Reply-To: <20030522154816.C6588@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305230243.32308.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 May 2003 23:48, Tom wrote:
> I'm currently trying to write policies for a pxe daemon, tftpd and
> rsync run as a daemon.

For rsync I always run it over ssh, so rsync doesn't need any special 
permissions, the user that you are logging in as needs to be able to access 
the files appropriately.

As for PXE, I thought that someone had written a program that implemented both 
TFTP and PXE protocols...

> On the other hand, I could merge all these changes into one
> systemimager policy. But then this policy would overlap in part with
> other policies (currently just tftpd, but who says there won't be an
> rsync or pxe policy one day?).

I think it's good to keep these things separate.  Some people will want to use 
them for different tasks.

> I could also write a systemimager.te for the tools and sprinkle
> ifdef(`systemimager.te' throughout the other policies - but do we
> really want to fill policies with dozens of "if this special package is
> being used..." ?

Minimising use of ifdef is a good idea.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
