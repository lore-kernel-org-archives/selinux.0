Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HBAnLa024287
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 07:10:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8HBAnmw002784
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 11:10:49 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8HBAm9d002781 for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 11:10:48 GMT
Date: Wed, 17 Sep 2003 12:10:27 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030917111027.GA8988@vnl.com>
References: <20030916155439.GN8988@vnl.com> <200309172036.48566.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309172036.48566.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 17, 2003 at 08:36:48PM +1000, Russell Coker wrote:
> I suggest also reloading the policy in the same script (see my previous 
> message about initrd policy).

No problem. I actually had it there but decided it was
redundant and removed it. I'll add it back since I 
really had not strong feelings about it.

If the policy version changes from policy.15, presumably 
there is a package update anyway, so that doesn't seem
a problem.
 
> It has occurred to me that if you were to use a NBD or similar device for a 
> root fs then you might want to do a pivot_root in the shutdown to umount root 
> properly, and therefore umounting any file systems under / will be helpful.

But how would you know whether you needed to re-pivot 
or not? What if you have booted your maintenance kernel
or some other that doesn't pivot? The boot script would
have to recognize that. I haven't got the test machine
booted at the moment so I can't check it the initrd mount
has a unique feature that you can find in /proc/mounts.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
