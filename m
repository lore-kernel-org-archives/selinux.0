Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6MK6nHa022086
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 16:06:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6MK5iFB001810
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:05:44 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6MK5gGD001807
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:05:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Charlie Watts <st_possenti@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Date: Tue, 22 Jul 2003 16:06:42 -0400
References: <20030722014248.34651.qmail@web40613.mail.yahoo.com>
In-Reply-To: <20030722014248.34651.qmail@web40613.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307221606.42540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jul 2003 21:42, Charlie Watts wrote:
> I want to make a linux system from scratch. I have never compiled my
> own kernel, but I was wondering if i could start with the SE Linux
> kernel. I am using the instructions from linuxfromscratch.org to make
> the system on my laptop, which is running Mandrake 9, on a i686, 512Mb
> ram, and a 1.13 GHz P IV. Ext3 file system. Any advice would be great.

I recommend that you compile your own kernel without SE Linux first, and then 
try using SE Linux after you have had some practise at building your own 
kernel.  Otherwise if you have a problem you won't know whether it's SE Linux 
related or just a general kernel build issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
