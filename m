Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7G6J0Ha006380
	for <selinux@tycho.nsa.gov>; Sat, 16 Aug 2003 02:19:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7G6Ixj6015636
	for <selinux@tycho.nsa.gov>; Sat, 16 Aug 2003 06:18:59 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7G6IrNN015627 for <selinux@tycho.nsa.gov>; Sat, 16 Aug 2003 06:18:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ripin Natani" <ripinfs@hotmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: iso image and smallest partition questions ...
Date: Sat, 16 Aug 2003 16:16:58 +1000
References: <BAY8-DAV5vcSzLPMvY200038899@hotmail.com>
In-Reply-To: <BAY8-DAV5vcSzLPMvY200038899@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308161616.58894.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 16 Aug 2003 07:55, Ripin Natani wrote:
>      1. Is there an SELinux ISO image available ? (I have an old version of
> RH and compiling the SELinux is giving me a lot of errors ) 2. What is the
> smallest partition size that I can create on SELinux (with just network
> access). I think its about 2.5 MB but if someone else has also experimented
> with this please enlighten me. Thanks,

In my paper for OLS 2003 I investigated the disk usage for small devices in 
great depth.  The conclusion was that the disk usage was significantly less 
than 1M, and could be as little as ~200K depending on exactly how you do it 
(there are some trade-offs to be made between security and space).

My paper is on the OLS web site and my SE Linux site (listed below).

When you compare the amount of disk space needed for a basic installation of 
any of the major distributions nowadays the ~500K you may require for SE 
Linux is nothing.  In my paper I conclude that disk use for SE Linux is not a 
major issue on machines with 32M of flash, it's RAM use that's more of a 
concern.

ISOs for installing SE Linux are not yet available, but work is in progress.  
I am not sure what the release plans are however.  Hopefully someone from Red 
Hat who knows the plans will be able to comment on this issue.

I think it's safe to say that such an install CD will not be available in the 
time-frame you desire.  So I recommend that you persist with trying to 
compile SE Linux.  Also I strongly recommend that you first compile and 
install your own non-SE kernel to ensure that there are no problems 
preventing general kernel compilation and configuration.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
