Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HChjLa024777
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 08:43:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HCg4LY016103
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:42:04 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8HCg2sG016100
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:42:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Date: Wed, 17 Sep 2003 22:43:31 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030916155439.GN8988@vnl.com> <200309172036.48566.russell@coker.com.au> <20030917111027.GA8988@vnl.com>
In-Reply-To: <20030917111027.GA8988@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172243.31840.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 21:10, Dale Amon wrote:
> On Wed, Sep 17, 2003 at 08:36:48PM +1000, Russell Coker wrote:
> > I suggest also reloading the policy in the same script (see my previous
> > message about initrd policy).
>
> No problem. I actually had it there but decided it was
> redundant and removed it. I'll add it back since I
> really had not strong feelings about it.

If the policy is the same it doesn't do that much harm to reload it.  It will 
slightly hurt performance and operations such as video playing might glitch 
as a result, but this doesn't matter during the boot process.

> > It has occurred to me that if you were to use a NBD or similar device for
> > a root fs then you might want to do a pivot_root in the shutdown to
> > umount root properly, and therefore umounting any file systems under /
> > will be helpful.
>
> But how would you know whether you needed to re-pivot
> or not? What if you have booted your maintenance kernel
> or some other that doesn't pivot? The boot script would
> have to recognize that. I haven't got the test machine
> booted at the moment so I can't check it the initrd mount
> has a unique feature that you can find in /proc/mounts.

The problem of re-pivoting would have to be dealt with in the shutdown scripts 
for such as NBD type device.  As I never got around to implementing such 
support for root on network devices I never wrote shutdown scripts.  However 
I would like to have things be in reasonable shape so that if I won't 
experience excessive pain if/when I do it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
