Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB4DgPRb027494
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 08:42:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB4DgORV009018
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 13:42:24 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB4DgKta008991 for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 13:42:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Policy error of the day
Date: Fri, 5 Dec 2003 00:42:09 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031129123120.GI18062@vnl.com> <20031201143409.GI11972@vnl.com> <20031204124047.GQ25416@vnl.com>
In-Reply-To: <20031204124047.GQ25416@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312050042.09363.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Dec 2003 23:40, Dale Amon <amon@vnl.com> wrote:
> I'm preparing a new kernel for the machine I build on
> and have just hesitated over the enabling of xattr's
> in the kernel config. I'm pretty sure the file system
> won't be automatically affected, but I want to do
> a "tell me three times on it" because I simply cannot
> afford to make this machine unable to boot under
> old kernels.
>
> So, do all swear on a stack of bible and assorted other
> holy or unholy books that booting a kernel with xattr ext2
> support enabled will *NOT* touch an existing file system
> and make it unuseable in, say a 2.2 kernel?

XATTR's don't appear on their own.  You can have a file system driver compiled 
with XATTR options and nothing will happen as long as no programs try to set 
an xattr.  Of course it would only take one program to do this...

In practise I have not found this to be a problem, I've run machines for 
months with XATTR enabled and not had it get used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
