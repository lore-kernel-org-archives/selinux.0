Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAR37mRb022925
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 22:07:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAR37lqY002938
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 03:07:47 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAR37k0o002935 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 03:07:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: mkinitrd setup script problem
Date: Thu, 27 Nov 2003 14:07:36 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031126231523.GX2718@vnl.com>
In-Reply-To: <20031126231523.GX2718@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311271407.36409.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Nov 2003 10:15, Dale Amon <amon@vnl.com> wrote:
> Installs
> 	/sbin/load_policy
> and a link
> 	/usr/sbin/load_policy -> /sbin/load_policy

This is because /sbin/init executes load_policy in the current Debian package.  
When I update it to match Dan's new code this won't matter, but until then 
load_policy needs to be on the root fs.  For the long term I think that 
load_policy should be on the root fs to allow the most possible configuration 
options for users.

> Installs
> 	/etc/mkinitrd/scripts/selinux
> which contains the line:
> 	cp -a /usr/sbin/load_policy "$INITRDDIR/bin/load_policy

The next version of my policy package will fix this.  I haven't tested this 
for a while as I don't use initrd any more.

When compiling a kernel for your own use an initrd usually does not offer much 
(except for unusual situations such as nfs-root - which often don't work with 
SE Linux).  I have had some problems with the Debian mkinitrd script recently 
and decided not to use it for any of my machines.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
