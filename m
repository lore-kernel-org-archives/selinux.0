Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HCsVLa024871
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 08:54:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HCqoLY016791
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:52:50 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8HCqnsG016788
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:52:49 GMT
Date: Wed, 17 Sep 2003 13:54:25 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030917125425.GG8988@vnl.com>
References: <20030916155439.GN8988@vnl.com> <200309172036.48566.russell@coker.com.au> <20030917111027.GA8988@vnl.com> <200309172243.31840.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309172243.31840.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 17, 2003 at 10:43:31PM +1000, Russell Coker wrote:
> The problem of re-pivoting would have to be dealt with in the shutdown scripts 
> for such as NBD type device.  As I never got around to implementing such 
> support for root on network devices I never wrote shutdown scripts.  However 
> I would like to have things be in reasonable shape so that if I won't 
> experience excessive pain if/when I do it.

The more I think about it, the less I'm sure of what
to do. I brought my test bed back on line and did a bit
of looking around.

/initrd is gone after boot up, so I can't use anything 
about it as an indicator; also I can't then pivot back to
it. I can detect that an initrd must have occurred at boot
because there is an selinuxfs which wouldn't exist if I
hadn't booted from selinux.

But even that isn't quite good enough. The boot script
should not try to mount /selinux at all unless the
kernel is an selinux enabled one. I'm not quite sure
how to detect that... wait, hold on thar.... 2.6.0
kernels put the .config into /proc. Hmmm... let me
think on that!




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
