Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5S7lhrT010856
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 03:47:43 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5S7lRVC004396
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 07:47:28 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3FA2B61C7F
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:47:40 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21956-06 for <selinux@tycho.nsa.gov>;
	Mon, 28 Jun 2004 17:47:39 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A99E661BD6
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:47:39 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E0006B5A1D
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:47:37 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: r_file_perms and ioctl
Date: Mon, 28 Jun 2004 17:47:37 +1000
References: <200406281701.18137.russell@coker.com.au>
In-Reply-To: <200406281701.18137.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406281747.37392.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Jun 2004 17:01, Russell Coker <russell@coker.com.au> wrote:
> It seems to me that including ioctl in the r_file_perms macro is a bad
> idea. ioctl is often (usually?) used for writing, so therefore the macro is
> not doing what it's name suggests.

Sorry my last message was not complete.

I was thinking of the case of using r_file_perms for access to device nodes.  
ioctl on a file is usually harmless.

Of course there's probably some policy which uses r_file_perms when it really 
wants to do ioctl's as well, access to sound devices and SCSI generic devices 
comes to mind.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
